import 'package:CIVM/models/cancelInitiatedWorkForApprovalChangeOrderRecords_model.dart';
import 'package:CIVM/models/image_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:CIVM/data/response/api_Response.dart';
import 'package:CIVM/models/user_model.dart';
import 'package:CIVM/repository/auth_repository.dart';
import 'package:CIVM/utils/custom_toast_snackbar_progressdialog.dart';
import 'package:CIVM/utils/user_pref.dart';

class IniciatedCancelWorkForApprovalViewModel with ChangeNotifier {
  final _myRepo = AuthRepository();

//*****************************tabular data********************************************* */
  ApiResponse<CancelWorkForApprovalInitiatedRecordChangeOrderModel>
      iniciatedCancelWorkApprovalTabularData = ApiResponse.loading();

  setIniciatedCancelWorkApprovalGetTabularList(
      ApiResponse<CancelWorkForApprovalInitiatedRecordChangeOrderModel> response) {
    iniciatedCancelWorkApprovalTabularData = response;
    notifyListeners();
  }

  Future<void> fetchIniciatedCancelWorkApprovalTabularListApi(
      BuildContext context,
      String status, String id) async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    setIniciatedCancelWorkApprovalGetTabularList(ApiResponse.loading());
    _myRepo
        .iniciatedCancelWorkApprovalTabularDataApi(data.token!,
            status, id)
        .then((value) async {
      setIniciatedCancelWorkApprovalGetTabularList(ApiResponse.completed(value));
      if (kDebugMode) {
        print(value.toString());
      }
      return value;
      // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
    }).onError((error, StackTrace) {
      setIniciatedCancelWorkApprovalGetTabularList(
          ApiResponse.error(error.toString()));
      if (kDebugMode) {
        CustomToastSnackBarProgressDialog.flushBarErrorMessage(
            error.toString(), context);
        print(error.toString());
      }
      return CancelWorkForApprovalInitiatedRecordChangeOrderModel();
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

  // ***************************************************************************************************
  // for change status
  // ApiResponse<CancelWorkForApprovalInitiatedRecordChangeOrderModel> lcpStatusChangeData =
  //     ApiResponse.loading();

  // setLcpDocumentPendingApprovalChangeStatusList(
  //     ApiResponse<CancelWorkForApprovalInitiatedRecordChangeOrderModel> response) {
  //   lcpDocumentApprovalSubmitData = response;
  //   notifyListeners();
  // }

  // Future<void> fetchLCPDocumentPendingApprovalChangeStatusListApi(
  //     BuildContext context, String tokenNo, String status) async {
  //   final userPreferences = Provider.of<UserPref>(context, listen: false);
  //   UserModel data = await userPreferences.getUser();
  //   setLcpDocumentPendingApprovalChangeStatusList(ApiResponse.loading());
  //   _myRepo
  //       .lcpDocumentPendingApprovalChangeStatusApi(tokenNo, status, data.token!)
  //       .then((value) async {
  //     setLcpDocumentPendingApprovalChangeStatusList(
  //         ApiResponse.completed(value));
  //     CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
  //         'Successfully Updated', context);
  //     // Navigator.of(context).push(MaterialPageRoute(
  //     //     builder: (BuildContext context) =>
  //     //         const AddNewRowMaintenancePlanTable()));
  //     if (kDebugMode) {
  //       print(value.toString());
  //     }
  //     return value;
  //     // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
  //   }).onError((error, StackTrace) {
  //     setLcpDocumentPendingApprovalChangeStatusList(
  //         ApiResponse.error(error.toString()));
  //     if (kDebugMode) {
  //       CustomToastSnackBarProgressDialog.flushBarErrorMessage(
  //           error.toString(), context);
  //       print(error.toString());
  //     }
  //     return CancelWorkForApprovalInitiatedRecordChangeOrderModel();
  //   });
  // }

 
}
