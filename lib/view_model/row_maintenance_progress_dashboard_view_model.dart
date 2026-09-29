import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:CIVM/data/response/api_response.dart';
import 'package:CIVM/models/row_maintenance_progress_dashboard_model.dart';
import 'package:CIVM/models/user_model.dart';
import 'package:CIVM/repository/auth_repository.dart';
import 'package:CIVM/utils/custom_toast_snackbar_progressdialog.dart';
import 'package:CIVM/utils/user_pref.dart';

class RowMaintenanceProgressDashboardViewModel with ChangeNotifier {
  final _myRepo = AuthRepository();
  ApiResponse<RowMaintenanceProgressDashboardModel>
      rowMaintenanceProgressGetDataList = ApiResponse.loading();

  setRowMaintenanceProgressDashboardData(
      ApiResponse<RowMaintenanceProgressDashboardModel> response) {
    rowMaintenanceProgressGetDataList = response;
    notifyListeners();
  }

  Future<void> fetchRowMaintenanceProgressDashboardDataApi(
      BuildContext context, String year) async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    setRowMaintenanceProgressDashboardData(ApiResponse.loading());
    _myRepo
        .rowMaintenanceProgressDashboardApi(data.token!, year)
        .then((value) async {
      setRowMaintenanceProgressDashboardData(ApiResponse.completed(value));
      if (kDebugMode) {
        print(value.toString());
      }
      return value;
    }).onError((error, StackTrace) {
      setRowMaintenanceProgressDashboardData(
          ApiResponse.error(error.toString()));
      if (kDebugMode) {
        CustomToastSnackBarProgressDialog.flushBarErrorMessage(
            error.toString(), context);
        print(error.toString());
      }
      return RowMaintenanceProgressDashboardModel();
    });
  }

  Future<void> fetchRowMaintenanceProgressDashboardDataApi2(
      BuildContext context, String year) async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    setRowMaintenanceProgressDashboardData(ApiResponse.loading());
    _myRepo
        .rowMaintenanceProgressDashboardApi(data.token!, year)
        .then((value) async {
      setRowMaintenanceProgressDashboardData(ApiResponse.completed(value));
      if (kDebugMode) {
        print(value.toString());
      }
      return value;
    }).onError((error, StackTrace) {
      setRowMaintenanceProgressDashboardData(
          ApiResponse.error(error.toString()));
      if (kDebugMode) {
        CustomToastSnackBarProgressDialog.flushBarErrorMessage(
            error.toString(), context);
        print(error.toString());
      }
      return RowMaintenanceProgressDashboardModel();
    });
  }
}
