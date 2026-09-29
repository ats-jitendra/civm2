import 'package:CIVM/models/image_model.dart';
import 'package:CIVM/models/supervisor_ordersPendingModel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:CIVM/data/response/api_Response.dart';
import 'package:CIVM/models/user_model.dart';
import 'package:CIVM/repository/auth_repository.dart';
import 'package:CIVM/utils/custom_toast_snackbar_progressdialog.dart';
import 'package:CIVM/utils/user_pref.dart';

class SupervisorOrderPendingViewModel with ChangeNotifier {
  final _myRepo = AuthRepository();

//*****************************tabular data********************************************* */
  ApiResponse<SupervisorOrderPendingModel>
      supervisorOrderPendingGetTabularData = ApiResponse.loading();

  setSupervisorOrderPendingGetTabularList(
      ApiResponse<SupervisorOrderPendingModel> response) {
    supervisorOrderPendingGetTabularData = response;
    notifyListeners();
  }

  Future<void> fetchSupervisorOrderPendingTabularListApi(
      BuildContext context,
      String status,
      String userId,
      String changeOrder,
      String budgetType,
      String maintType) async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    setSupervisorOrderPendingGetTabularList(ApiResponse.loading());
    _myRepo
        .supervisorOrderPendingTabularDataApi(
            data.token!, status, userId, changeOrder, budgetType, maintType)
        .then((value) async {
      setSupervisorOrderPendingGetTabularList(ApiResponse.completed(value));
      if (kDebugMode) {
        print(value.toString());
      }
      return value;
      // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
    }).onError((error, StackTrace) {
      setSupervisorOrderPendingGetTabularList(
          ApiResponse.error(error.toString()));
      if (kDebugMode) {
        CustomToastSnackBarProgressDialog.flushBarErrorMessage(
            error.toString(), context);
        print(error.toString());
      }
      return SupervisorOrderPendingModel();
    });
  }

  // ***************************************************************************************************
//   //****************** */ status change*******************
  ApiResponse<SupervisorOrderPendingModel> orderPendingChangeStatus =
      ApiResponse.loading();

  setOrderPendingChangeStatusPostList(
      ApiResponse<SupervisorOrderPendingModel> response) {
    orderPendingChangeStatus = response;
    notifyListeners();
  }

  Future<void> fetchOrderPendingChangePutListApi(BuildContext context,
      String folowUpDate, String insp, String tokenNo) async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    setOrderPendingChangeStatusPostList(ApiResponse.loading());
    _myRepo
        .orderPendingStatusPutDataApi(data.token!, folowUpDate, insp, tokenNo)
        .then((value) async {
      setOrderPendingChangeStatusPostList(ApiResponse.completed(value));
      CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
          'Successfully Submitted for Approval', context);
      if (kDebugMode) {
        print(value.toString());
      }
      return value;
      // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
    }).onError((error, StackTrace) {
      setOrderPendingChangeStatusPostList(ApiResponse.error(error.toString()));
      if (kDebugMode) {
        CustomToastSnackBarProgressDialog.flushBarErrorMessage(
            error.toString(), context);
        print(error.toString());
      }
      return SupervisorOrderPendingModel();
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
