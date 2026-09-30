import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:CIVM/piedmont/data/response/api_Response.dart';
import 'package:CIVM/piedmont/models/row_maintenance_progress_tab_model.dart';
import 'package:CIVM/piedmont/models/user_model.dart';
import 'package:CIVM/piedmont/repository/auth_repository.dart';
import 'package:CIVM/piedmont/utils/custom_toast_snackbar_progressdialog.dart';
import 'package:CIVM/piedmont/utils/user_pref.dart';
import 'package:CIVM/utils/user_pref.dart';
import 'package:CIVM/models/user_model.dart';
class RowMaintenanceProgressTabViewModel with ChangeNotifier {
  final _myRepo = AuthRepositoryPemc();
  ApiResponse<RowMaintenanceProgressTabModel> rowMaintenanceProgressTabList =
      ApiResponse.loading();

  setRowMaintenanceProgressTabList(
      ApiResponse<RowMaintenanceProgressTabModel> response) {
    rowMaintenanceProgressTabList = response;
    notifyListeners();
  }

  Future<void> fetchRowMaintenanceProgressTabListApi(
      BuildContext context,
      String cycleList,
      String subStationList,
      String feeder,
      String crew,
      String yearList) async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    setRowMaintenanceProgressTabList(ApiResponse.loading());
    _myRepo
        .rowMaintenanceProgressTabApi(
            cycleList, subStationList, feeder, crew, yearList, data.token!)
        .then((value) async {
      setRowMaintenanceProgressTabList(ApiResponse.completed(value));
      if (kDebugMode) {
        print(value.toString());
      }
      return value;
    }).onError((error, StackTrace) {
      setRowMaintenanceProgressTabList(ApiResponse.error(error.toString()));
      if (kDebugMode) {
        CustomToastSnackBarProgressDialog.flushBarErrorMessage(
            error.toString(), context);
        print(error.toString());
      }
      return RowMaintenanceProgressTabModel();
    });
  }
}
