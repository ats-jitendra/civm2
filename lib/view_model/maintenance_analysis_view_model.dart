import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:CIVM/data/response/api_Response.dart';
import 'package:CIVM/models/maintenance_analysi_model.dart';
import 'package:CIVM/models/user_model.dart';
import 'package:CIVM/repository/auth_repository.dart';
import 'package:CIVM/utils/custom_toast_snackbar_progressdialog.dart';
import 'package:CIVM/utils/user_pref.dart';

class MaintenanceAnalysisViewModel with ChangeNotifier {
  final _myRepo = AuthRepository();
  ApiResponse<MaintenanceAnalysisModel> maintenanceAnalysisList =
      ApiResponse.loading();

  setMaintenanceAnalysisList(ApiResponse<MaintenanceAnalysisModel> response) {
    maintenanceAnalysisList = response;
    notifyListeners();
  }

  Future<void> fetchMaintenanceAnanlysisListApi(
    BuildContext context,
    String substation,
    String fdrName,
    String nextMaintenanceDue,
  ) async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    setMaintenanceAnalysisList(ApiResponse.loading());
    _myRepo
        .maintenanceAnalysisApi(
            substation, fdrName, nextMaintenanceDue, data.token!)
        .then((value) async {
      setMaintenanceAnalysisList(ApiResponse.completed(value));
      if (kDebugMode) {
        print(value.toString());
      }
      return value;
    }).onError((error, StackTrace) {
      setMaintenanceAnalysisList(ApiResponse.error(error.toString()));
      if (kDebugMode) {
        CustomToastSnackBarProgressDialog.flushBarErrorMessage(
            error.toString(), context);
        print(error.toString());
      }
      return MaintenanceAnalysisModel();
    });
  }
}
