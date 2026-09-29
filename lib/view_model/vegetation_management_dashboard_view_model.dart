import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:CIVM/data/response/api_Response.dart';
import 'package:CIVM/models/user_model.dart';
import 'package:CIVM/models/vegetation_management_dashboard_model.dart';
import 'package:CIVM/repository/auth_repository.dart';
import 'package:CIVM/utils/custom_toast_snackbar_progressdialog.dart';
import 'package:CIVM/utils/user_pref.dart';

class VegetationManagementDashboardViewModel with ChangeNotifier {
  final _myRepo = AuthRepository();
  ApiResponse<VegetationManagementDashboardModel>
      vegetationManagementDashboardList = ApiResponse.loading();

  setvegetationManagementDashboardList(
      ApiResponse<VegetationManagementDashboardModel> response) {
    vegetationManagementDashboardList = response;
    notifyListeners();
  }

  Future<void> fetchVegetationManagementDashboardListApi(
      BuildContext context,
      String action,
      String selectSpray,
      String selectMowing,
      String selectMowingNoSpray,
      String selectJaraffMowingSprayWork,
      String selectGroundWork,
      String selectJaraffMowingNoSpray,
      String selectBucketWork,
      String substation,
      String year,
      String month,
      String dateFrom,
      String dateTo,
      String yearFilters) async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    setvegetationManagementDashboardList(ApiResponse.loading());
    _myRepo
        .vegetationManagementDashboardApi(
            action,
            selectSpray,
            selectMowing,
            selectMowingNoSpray,
            selectJaraffMowingSprayWork,
            selectGroundWork,
            selectJaraffMowingNoSpray,
            selectBucketWork,
            substation,
            year,
            month,
            dateFrom,
            dateTo,
            yearFilters,
            data.token!)
        .then((value) async {
      setvegetationManagementDashboardList(ApiResponse.completed(value));
      if (kDebugMode) {
        print(value.toString());
      }
      return value;
    }).onError((error, StackTrace) {
      setvegetationManagementDashboardList(ApiResponse.error(error.toString()));
      if (kDebugMode) {
        CustomToastSnackBarProgressDialog.flushBarErrorMessage(
            error.toString(), context);
        print(error.toString());
      }
      return VegetationManagementDashboardModel();
    });
  }
}
