import 'package:CIVM/piedmont/models/ivm_timesheet_model.dart';
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
class IvmTimeSheetViewModel with ChangeNotifier {
  final _myRepo = AuthRepositoryPemc();

//*****************************get data********************************************* */
  ApiResponse<IvmTimeSheetModel> ivmTimeSheetGetTabularData =
      ApiResponse.loading();

  setivmTimeSheetGetTabularList(ApiResponse<IvmTimeSheetModel> response) {
    ivmTimeSheetGetTabularData = response;
    notifyListeners();
  }

  Future<void> fetchivmTimeSheetTabularListApi(
      BuildContext context, String id) async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    setivmTimeSheetGetTabularList(ApiResponse.loading());
    _myRepo.ivmTimeSheetTabularDataApi(data.token!, id).then((value) async {
      setivmTimeSheetGetTabularList(ApiResponse.completed(value));
      if (kDebugMode) {
        print(value.toString());
      }
      return value;
      // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
    }).onError((error, StackTrace) {
      setivmTimeSheetGetTabularList(ApiResponse.error(error.toString()));
      if (kDebugMode) {
        CustomToastSnackBarProgressDialog.flushBarErrorMessage(
            error.toString(), context);
        print(error.toString());
      }
      return IvmTimeSheetModel();
    });
  }

  // ***************************************************************************************************
//   ***********************status change*******************
  ApiResponse<IvmTimeSheetModel> ivmTimeSheetChangeStatus =
      ApiResponse.loading();

  setIvmTimeSheetChangeStatusStatusPostList(
      ApiResponse<IvmTimeSheetModel> response) {
    ivmTimeSheetChangeStatus = response;
    notifyListeners();
  }

  Future<void> fetchIvmTimeSheetChangeStatusListApi(
      BuildContext context, String tokenNo, String status) async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    setIvmTimeSheetChangeStatusStatusPostList(ApiResponse.loading());
    _myRepo
        .ivmTimesheetStatusChangePutDataApi(data.token!, tokenNo, status)
        .then((value) async {
      setIvmTimeSheetChangeStatusStatusPostList(ApiResponse.completed(value));
      CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
          'Status Changes Successfully', context);
      if (kDebugMode) {
        print(value.toString());
      }
      return value;
      // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
    }).onError((error, StackTrace) {
      setIvmTimeSheetChangeStatusStatusPostList(
          ApiResponse.error(error.toString()));
      if (kDebugMode) {
        CustomToastSnackBarProgressDialog.flushBarErrorMessage(
            error.toString(), context);
        print(error.toString());
      }
      return IvmTimeSheetModel();
    });
  }
}
