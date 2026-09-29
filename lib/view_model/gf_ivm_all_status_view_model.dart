import 'package:CIVM/models/image_model.dart';
import 'package:CIVM/models/ivm_allStatus_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:CIVM/data/response/api_Response.dart';
import 'package:CIVM/models/user_model.dart';
import 'package:CIVM/repository/auth_repository.dart';
import 'package:CIVM/utils/custom_toast_snackbar_progressdialog.dart';
import 'package:CIVM/utils/user_pref.dart';

class GFIvmAllStatusViewModel with ChangeNotifier {
  final _myRepo = AuthRepository();

//*****************************tabular data********************************************* */
  ApiResponse<IvmAllStatusModel> gfIvmAllStatusModelGetTabularData =
      ApiResponse.loading();

  void setGFIvmAllStatusModelGetTabularList(
      ApiResponse<IvmAllStatusModel> response) {
    gfIvmAllStatusModelGetTabularData = response;
    notifyListeners();
  }

  Future<void> fetchGFIvmAllStatusModelTabularListApi(
      BuildContext context,
      String budgetType,
      String tokenNo,
      String year) async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    setGFIvmAllStatusModelGetTabularList(ApiResponse.loading());
    _myRepo
        .gfIvmAllStatusTabularDataApi(data.token!, budgetType, tokenNo, year)
        .then((value) async {
      setGFIvmAllStatusModelGetTabularList(ApiResponse.completed(value));
      if (kDebugMode) {
        print(value.toString());
      }
      return value;
      // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
    }).onError((error, StackTrace) {
      setGFIvmAllStatusModelGetTabularList(ApiResponse.error(error.toString()));
      if (kDebugMode) {
        CustomToastSnackBarProgressDialog.flushBarErrorMessage(
            error.toString(), context);
        print(error.toString());
      }
      return IvmAllStatusModel();
    });
  }




   Future<void> fetchGFIvmReworkFailedStatusModelTabularListApi(
      BuildContext context,
      String budgetType,
      String tokenNo,
      String status,
      String year) async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    setGFIvmAllStatusModelGetTabularList(ApiResponse.loading());
    _myRepo
        .gfIvmReworkFailedStatusTabularDataApi(data.token!, budgetType, tokenNo, status, year)
        .then((value) async {
      setGFIvmAllStatusModelGetTabularList(ApiResponse.completed(value));
      if (kDebugMode) {
        print(value.toString());
      }
      return value;
      // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
    }).onError((error, StackTrace) {
      setGFIvmAllStatusModelGetTabularList(ApiResponse.error(error.toString()));
      if (kDebugMode) {
        CustomToastSnackBarProgressDialog.flushBarErrorMessage(
            error.toString(), context);
        print(error.toString());
      }
      return IvmAllStatusModel();
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
