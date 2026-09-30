import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:CIVM/piedmont/data/response/api_Response.dart';
import 'package:CIVM/piedmont/models/daily_herbicide_model.dart';
import 'package:CIVM/piedmont/models/user_model.dart';
import 'package:CIVM/piedmont/repository/auth_repository.dart';
import 'package:CIVM/piedmont/utils/custom_toast_snackbar_progressdialog.dart';
import 'package:CIVM/piedmont/utils/user_pref.dart';
import 'package:CIVM/utils/user_pref.dart';
import 'package:CIVM/models/user_model.dart';
class DailyHerbicideViewModel with ChangeNotifier {
  final _myRepo = AuthRepositoryPemc();

//*****************************tabular data********************************************* */
  ApiResponse<DailyHerbicideModel> dailyHerbicideGetTabularData =
      ApiResponse.loading();

  setDailyHerbicideGetTabularList(ApiResponse<DailyHerbicideModel> response) {
    dailyHerbicideGetTabularData = response;
    notifyListeners();
  }

  Future<void> fetchDailyHerbicideTabularListApi(
      BuildContext context, String id) async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    setDailyHerbicideGetTabularList(ApiResponse.loading());
    _myRepo.dailyHerbicideTabularDataApi(data.token!, id).then((value) async {
      setDailyHerbicideGetTabularList(ApiResponse.completed(value));
      if (kDebugMode) {
        print(value.toString());
      }
      return value;
      // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
    }).onError((error, StackTrace) {
      setDailyHerbicideGetTabularList(ApiResponse.error(error.toString()));
      if (kDebugMode) {
        CustomToastSnackBarProgressDialog.flushBarErrorMessage(
            error.toString(), context);
        print(error.toString());
      }
      return DailyHerbicideModel();
    });
  }

  // ***************************************************************************************************
//   //****************** */ status change*******************
  ApiResponse<DailyHerbicideModel> dailyHerbicideUpdateStatus =
      ApiResponse.loading();

  setDailyHerbicideUpdateStatusPostList(
      ApiResponse<DailyHerbicideModel> response) {
    dailyHerbicideUpdateStatus = response;
    notifyListeners();
  }

  Future<void> fetchApproveCIVMUpdatePutListApi(
      BuildContext context, String tokenNo, String status) async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    setDailyHerbicideUpdateStatusPostList(ApiResponse.loading());
    _myRepo
        .dailyHerbicideStatusPutDataApi(data.token!, tokenNo, status)
        .then((value) async {
      setDailyHerbicideUpdateStatusPostList(ApiResponse.completed(value));
      CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
          'Status Changes Successfully', context);
      if (kDebugMode) {
        print(value.toString());
      }
      return value;
      // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
    }).onError((error, StackTrace) {
      setDailyHerbicideUpdateStatusPostList(
          ApiResponse.error(error.toString()));
      if (kDebugMode) {
        CustomToastSnackBarProgressDialog.flushBarErrorMessage(
            error.toString(), context);
        print(error.toString());
      }
      return DailyHerbicideModel();
    });
  }
}
