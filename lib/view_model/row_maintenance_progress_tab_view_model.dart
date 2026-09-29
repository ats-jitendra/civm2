import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:CIVM/data/response/api_Response.dart';
import 'package:CIVM/models/row_maintenance_progress_tab_model.dart';
import 'package:CIVM/models/user_model.dart';
import 'package:CIVM/repository/auth_repository.dart';
import 'package:CIVM/utils/custom_toast_snackbar_progressdialog.dart';
import 'package:CIVM/utils/user_pref.dart';

class RowMaintenanceProgressTabViewModel with ChangeNotifier {
  final _myRepo = AuthRepository();
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
