import 'package:CIVM/models/image_model.dart';
import 'package:CIVM/models/mainTenance_report_view_new.dart';
import 'package:CIVM/models/maintenance_report_view_model.dart';
import 'package:CIVM/models/maintenance_report_view_update_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:CIVM/data/response/api_Response.dart';
import 'package:CIVM/models/user_model.dart';
import 'package:CIVM/repository/auth_repository.dart';
import 'package:CIVM/utils/custom_toast_snackbar_progressdialog.dart';
import 'package:CIVM/utils/user_pref.dart';

class MaintenanceReportViewViewModel with ChangeNotifier {
  final _myRepo = AuthRepository();

//*****************************tabular data********************************************* */
  ApiResponse<MaintenanceReportViewModel> maintenanceReportViewGetTabularData =
      ApiResponse.loading();

  setMaintenanceReportViewGetTabularList(
      ApiResponse<MaintenanceReportViewModel> response) {
    maintenanceReportViewGetTabularData = response;
    notifyListeners();
  }

  Future<void> fetchMaintenanceReportViewTabularListApi(BuildContext context,
      String type, String substation, String feeder, String id) async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    setMaintenanceReportViewGetTabularList(ApiResponse.loading());
    _myRepo
        .maintenanceReportViewTabularDataApi(
            data.token!, type, substation, feeder, id)
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

  Future<void> fetchMaintenanceReportViewUpdateListApi(
      BuildContext context, String status, String tokenNo, String id, String budgetType) async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    setMaintenanceReportViewUpdateList(ApiResponse.loading());
    _myRepo
        .maintenanceReportViewUpdateDataApi(data.token!, status, tokenNo, id)
        .then((value) async {
      setMaintenanceReportViewUpdateList(ApiResponse.completed(value));
              if(budgetType.toString() =='Mid Cycle maintenance'){
CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
              'Mid Cycle Maintenance Rejected Successfully', context);
                  }else {
CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
              'IVM Maintenance Rejected Successfully', context);}
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
   Future<void> fetchImageNewApi(BuildContext context, String tokenNo,String vegId) async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    setImageList(ApiResponse.loading());
    _myRepo.imageNewApi(data.token!, tokenNo,vegId).then((value) async {
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

  ///////////////////////////////////////////////////////
  
//*****************************tabular data********************************************* */
  ApiResponse<MaintenanceReportViewModelNew> maintenanceReportViewGetTabularDataNew =
      ApiResponse.loading();

  setMaintenanceReportViewGetTabularListNew(
      ApiResponse<MaintenanceReportViewModelNew> response) {
    maintenanceReportViewGetTabularDataNew = response;
    notifyListeners();
  }

  Future<void> fetchMaintenanceReportViewTabularListApiNew(BuildContext context,
      String type, String substation, String feeder, String id, String year) async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    setMaintenanceReportViewGetTabularListNew(ApiResponse.loading());
    _myRepo
        .maintenanceReportViewTabularDataApiNew(
            data.token!, type, substation, feeder, id, year)
        .then((value) async {
      setMaintenanceReportViewGetTabularListNew(ApiResponse.completed(value));
      if (kDebugMode) {
        print(value.toString());
      }
      return value;
      // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
    }).onError((error, StackTrace) {
      setMaintenanceReportViewGetTabularListNew(
          ApiResponse.error(error.toString()));
      if (kDebugMode) {
        CustomToastSnackBarProgressDialog.flushBarErrorMessage(
            error.toString(), context);
        print(error.toString());
      }
      return MaintenanceReportViewModelNew();
    });
  }

}
