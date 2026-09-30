import 'package:CIVM/piedmont/models/mixing_inventory_model.dart';
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
class MixingInventoryViewModel with ChangeNotifier {
  final _myRepo = AuthRepositoryPemc();

//*****************************get data********************************************* */
  ApiResponse<MixingInventoryModel> mixingInventoryGetTabularData =
      ApiResponse.loading();

  setmixingInventoryGetTabularList(ApiResponse<MixingInventoryModel> response) {
    mixingInventoryGetTabularData = response;
    notifyListeners();
  }

  Future<void> fetchMixingInventoryTabularListApi(
      BuildContext context, String id) async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    setmixingInventoryGetTabularList(ApiResponse.loading());
    _myRepo.mixingInventoryTabularDataApi(data.token!, id).then((value) async {
      setmixingInventoryGetTabularList(ApiResponse.completed(value));
      if (kDebugMode) {
        print(value.toString());
      }
      return value;
      // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
    }).onError((error, StackTrace) {
      setmixingInventoryGetTabularList(ApiResponse.error(error.toString()));
      if (kDebugMode) {
        CustomToastSnackBarProgressDialog.flushBarErrorMessage(
            error.toString(), context);
        print(error.toString());
      }
      return MixingInventoryModel();
    });
  }

  // ***************************************************************************************************
//   ***********************status change*******************
  ApiResponse<MixingInventoryModel> mixingInventoryChangeStatus =
      ApiResponse.loading();

  setMixingInventoryChangeStatusStatusPostList(
      ApiResponse<MixingInventoryModel> response) {
    mixingInventoryChangeStatus = response;
    notifyListeners();
  }

  Future<void> fetchMixingInventoryChangeStatusListApi(
      BuildContext context, String tokenNo, String status) async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    setMixingInventoryChangeStatusStatusPostList(ApiResponse.loading());
    _myRepo
        .mixingInventoryStatusChangePutDataApi(data.token!, tokenNo, status)
        .then((value) async {
      setMixingInventoryChangeStatusStatusPostList(
          ApiResponse.completed(value));
      CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
          'Status Changes Successfully', context);
      if (kDebugMode) {
        print(value.toString());
      }
      return value;
      // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
    }).onError((error, StackTrace) {
      setMixingInventoryChangeStatusStatusPostList(
          ApiResponse.error(error.toString()));
      if (kDebugMode) {
        CustomToastSnackBarProgressDialog.flushBarErrorMessage(
            error.toString(), context);
        print(error.toString());
      }
      return MixingInventoryModel();
    });
  }
}
