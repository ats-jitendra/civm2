import 'package:CIVM/piedmont/models/image_model.dart';
import 'package:CIVM/piedmont/models/maintenance_report_view_model.dart';
import 'package:CIVM/piedmont/models/maintenance_report_view_update_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:CIVM/piedmont/data/response/api_Response.dart';
import 'package:CIVM/piedmont/models/user_model.dart';
import 'package:CIVM/piedmont/repository/auth_repository.dart';
import 'package:CIVM/piedmont/utils/custom_toast_snackbar_progressdialog.dart';
import 'package:CIVM/piedmont/utils/user_pref.dart';
import 'package:CIVM/utils/user_pref.dart';
import 'package:CIVM/models/user_model.dart';
class MaintenanceReportViewViewModel with ChangeNotifier {
  final _myRepo = AuthRepositoryPemc();

//*****************************tabular data********************************************* */
  ApiResponse<MaintenanceReportViewModel> maintenanceReportViewGetTabularData =
      ApiResponse.loading();

  setMaintenanceReportViewGetTabularList(
      ApiResponse<MaintenanceReportViewModel> response) {
    maintenanceReportViewGetTabularData = response;
    notifyListeners();
  }

  Future<void> fetchMaintenanceReportViewTabularListApi(BuildContext context,
      String type, String substation, String feeder, String id, String vFlag) async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    setMaintenanceReportViewGetTabularList(ApiResponse.loading());
    _myRepo
        .maintenanceReportViewTabularDataApi(
            data.token!, type, substation, feeder, id, vFlag)
        .then((value) async {
      setMaintenanceReportViewGetTabularList(ApiResponse.completed(value));
      if (kDebugMode) {
        print(value.toString());
      }
      return value;
      // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
    }).onError((error, StackTrace) {
      setMaintenanceReportViewGetTabularList(
          ApiResponse.error(error.toString()));
      if (kDebugMode) {
        CustomToastSnackBarProgressDialog.flushBarErrorMessage(
            error.toString(), context);
        print(error.toString());
      }
      return MaintenanceReportViewModel();
    });
  }

  // ***************************************************************************************************
  // for updating data
  ApiResponse<MaintenanceReportViewUpdateModel>
      maintenanceReportViewUpdateData = ApiResponse.loading();

  setMaintenanceReportViewUpdateList(
      ApiResponse<MaintenanceReportViewUpdateModel> response) {
    maintenanceReportViewUpdateData = response;
    notifyListeners();
  }

  Future<void> fetchMaintenanceReportViewUpdateListApi(BuildContext context,
      String status, String tokenNo, String id, String budgetType) async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    setMaintenanceReportViewUpdateList(ApiResponse.loading());
    _myRepo
        .maintenanceReportViewUpdateDataApi(data.token!, status, tokenNo, id)
        .then((value) async {
      setMaintenanceReportViewUpdateList(ApiResponse.completed(value));
      if (budgetType.toString() == 'Mid Cycle maintenance') {
        CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
            'Mid Cycle Maintenance Rejected Successfully', context);
      } else {
        CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
            'IVM Maintenance Rejected Successfully', context);
      }
      // CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
      //     'Change Order Rejected Successfuly', context);
      // Navigator.pushNamed(
      //   context,
      //   RoutesName.auditorHome,
      // );
      if (kDebugMode) {
        print(value.toString());
      }
      return value;
      // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
    }).onError((error, StackTrace) {
      setMaintenanceReportViewUpdateList(ApiResponse.error(error.toString()));
      if (kDebugMode) {
        CustomToastSnackBarProgressDialog.flushBarErrorMessage(
            error.toString(), context);
        print(error.toString());
      }
      return MaintenanceReportViewUpdateModel();
    });
  }

//*****************************Image********************************************* */
  ApiResponse<ImageModel> imageData = ApiResponse.loading();

  setImageList(ApiResponse<ImageModel> response) {
    imageData = response;
    notifyListeners();
  }

  Future<void> fetchImageApi(BuildContext context, String tokenNo) async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    setImageList(ApiResponse.loading());
    _myRepo.imageApi(data.token!, tokenNo).then((value) async {
      setImageList(ApiResponse.completed(value));
      if (kDebugMode) {
        print(value.toString());
      }
      return value;
      // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
    }).onError((error, StackTrace) {
      setImageList(ApiResponse.error(error.toString()));
      if (kDebugMode) {
        CustomToastSnackBarProgressDialog.flushBarErrorMessage(
            error.toString(), context);
        print(error.toString());
      }
      return ImageModel();
    });
  }
}
