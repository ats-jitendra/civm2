import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:CIVM/data/response/api_response.dart';
import 'package:CIVM/models/row_maintenance_plan_dashboard_model.dart';
import 'package:CIVM/models/user_model.dart';
import 'package:CIVM/repository/auth_repository.dart';
import 'package:CIVM/utils/custom_toast_snackbar_progressdialog.dart';
import 'package:CIVM/utils/user_pref.dart';

class RowMaintenancePlanViewModel with ChangeNotifier {
  final _myRepo = AuthRepository();
  ApiResponse<RowMaintenancePlanDashboardModel> rowMaintenancePlanGetData =
      ApiResponse.loading();

  setRowMaintenancePlanData(ApiResponse<RowMaintenancePlanDashboardModel> response) {
    rowMaintenancePlanGetData = response;
    notifyListeners();
  }

  Future<void> fetchProgressBarRowMaintDataApi(BuildContext context) async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    setRowMaintenancePlanData(ApiResponse.loading());
    _myRepo.rowMaintenancePlanDashboardListApi(data.token!).then((value) async {
      setRowMaintenancePlanData(ApiResponse.completed(value));
      if (kDebugMode) {
        print(value.toString());
      }
      return value;
    }).onError((error, StackTrace) {
      setRowMaintenancePlanData(ApiResponse.error(error.toString()));
      if (kDebugMode) {
        CustomToastSnackBarProgressDialog.flushBarErrorMessage(
            error.toString(), context);
        print(error.toString());
      }
      return RowMaintenancePlanDashboardModel();
    });
  }

// // **********************get list data in cards***********************//
//   setRowMaintenancePlanDashboardTableData(
//       ApiResponse<RowMaintenancePlanDashboardListModel> response) {
//     rowMaintenancePlanGetData = response;
//     notifyListeners();
//   }

//   Future<void> fetchRowMaintenancePlanDashboardListApi(
//       BuildContext context) async {
//     final userPreferences = Provider.of<UserPref>(context, listen: false);
//     UserModel data = await userPreferences.getUser();
//     setRowMaintenancePlanDashboardTableData(ApiResponse.loading());
//     _myRepo.rowMaintenancePlanDashboardListApi(data.token!).then((value) async {
//       setRowMaintenancePlanDashboardTableData(ApiResponse.completed(value));
//       if (kDebugMode) {
//         print(value.toString());
//       }
//       return value;
//       // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
//     }).onError((error, StackTrace) {
//       setRowMaintenancePlanDashboardTableData(
//           ApiResponse.error(error.toString()));
//       if (kDebugMode) {
//         CustomToastSnackBarProgressDialog.flushBarErrorMessage(
//             error.toString(), context);
//         print(error.toString());
//       }
//       return RowMaintenancePlanDashboardListModel();
//     });
//   }
}
