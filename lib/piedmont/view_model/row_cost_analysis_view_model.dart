import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:CIVM/piedmont/data/response/api_Response.dart';
import 'package:CIVM/piedmont/models/row_cost_analysis_model.dart';
import 'package:CIVM/piedmont/models/user_model.dart';
import 'package:CIVM/piedmont/repository/auth_repository.dart';
import 'package:CIVM/piedmont/utils/custom_toast_snackbar_progressdialog.dart';
import 'package:CIVM/piedmont/utils/user_pref.dart';
import 'package:CIVM/utils/user_pref.dart';
import 'package:CIVM/models/user_model.dart';
class RowCostAnalysisViewModel with ChangeNotifier {
  final _myRepo = AuthRepositoryPemc();
  ApiResponse<RowCostAnalysisModel> rowCostAnalysisList = ApiResponse.loading();

  setRowCostAnalysisList(ApiResponse<RowCostAnalysisModel> response) {
    rowCostAnalysisList = response;
    notifyListeners();
  }

  Future<void> fetchRowCostAnalysisListApi(BuildContext context,
      String subStation, String fdrName, String nextMaintenanceDue) async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    setRowCostAnalysisList(ApiResponse.loading());
    _myRepo
        .rowCostAnanlysisApi(
            subStation, fdrName, nextMaintenanceDue, data.token!)
        .then((value) async {
      setRowCostAnalysisList(ApiResponse.completed(value));
      if (kDebugMode) {
        print(value.toString());
      }
      return value;
    }).onError((error, StackTrace) {
      setRowCostAnalysisList(ApiResponse.error(error.toString()));
      if (kDebugMode) {
        CustomToastSnackBarProgressDialog.flushBarErrorMessage(
            error.toString(), context);
        print(error.toString());
      }
      return RowCostAnalysisModel();
    });
  }
}
