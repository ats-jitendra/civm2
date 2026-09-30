import 'package:CIVM/piedmont/models/image_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:CIVM/piedmont/data/response/api_Response.dart';
import 'package:CIVM/piedmont/models/lcp_document_approval_model.dart';
import 'package:CIVM/piedmont/models/user_model.dart';
import 'package:CIVM/piedmont/repository/auth_repository.dart';
import 'package:CIVM/piedmont/utils/custom_toast_snackbar_progressdialog.dart';
import 'package:CIVM/piedmont/utils/user_pref.dart';
import 'package:CIVM/utils/user_pref.dart';
import 'package:CIVM/models/user_model.dart';
class LCPDocumentApprovalPendingViewModel with ChangeNotifier {
  final _myRepo = AuthRepositoryPemc();

//*****************************tabular data********************************************* */
  ApiResponse<LCPDocumentApprovalPendingModel>
      lcpDocumentApprovalPendingGetTabularData = ApiResponse.loading();

  setLcpDocumentApprovalPendingGetTabularList(
      ApiResponse<LCPDocumentApprovalPendingModel> response) {
    lcpDocumentApprovalPendingGetTabularData = response;
    notifyListeners();
  }

  Future<void> fetchLCPDocumentApprovalPendingTabularListApi(
      BuildContext context,
      String substation,
      String status,
      String contractorCompany,
      String feeder,
      String budgetType,
      String maintenanceType) async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    setLcpDocumentApprovalPendingGetTabularList(ApiResponse.loading());
    _myRepo
        .lcpDocumentApprovalPendingTabularDataApi(data.token!, substation,
            status, contractorCompany, feeder, budgetType, maintenanceType)
        .then((value) async {
      setLcpDocumentApprovalPendingGetTabularList(ApiResponse.completed(value));
      if (kDebugMode) {
        print(value.toString());
      }
      return value;
      // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
    }).onError((error, StackTrace) {
      setLcpDocumentApprovalPendingGetTabularList(
          ApiResponse.error(error.toString()));
      if (kDebugMode) {
        CustomToastSnackBarProgressDialog.flushBarErrorMessage(
            error.toString(), context);
        print(error.toString());
      }
      return LCPDocumentApprovalPendingModel();
    });
  }

  // ***************************************************************************************************
  // for submitting data on click in pending approval
  ApiResponse<LCPDocumentApprovalPendingModel> lcpDocumentApprovalSubmitData =
      ApiResponse.loading();

  setlcpDocumentPendingApprovalSubmitList(
      ApiResponse<LCPDocumentApprovalPendingModel> response) {
    lcpDocumentApprovalSubmitData = response;
    notifyListeners();
  }

  Future<void> fetchLCPDocumentPendingApprovalSubmitListApi(
    BuildContext context,
    String status,
    String adminNotes2,
    int tokenNo,
  ) async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    setlcpDocumentPendingApprovalSubmitList(ApiResponse.loading());
    _myRepo
        .lcpDocumentPendingApprovalSubmitApi(
            status, adminNotes2, tokenNo, data.token!)
        .then((value) async {
      setlcpDocumentPendingApprovalSubmitList(ApiResponse.completed(value));
      CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
          'Successfully Submitted', context);
      // Navigator.of(context).push(MaterialPageRoute(
      //     builder: (BuildContext context) =>
      //         const AddNewRowMaintenancePlanTable()));
      if (kDebugMode) {
        print(value.toString());
      }
      return value;
      // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
    }).onError((error, StackTrace) {
      setlcpDocumentPendingApprovalSubmitList(
          ApiResponse.error(error.toString()));
      if (kDebugMode) {
        CustomToastSnackBarProgressDialog.flushBarErrorMessage(
            error.toString(), context);
        print(error.toString());
      }
      return LCPDocumentApprovalPendingModel();
    });
  }

  // ***************************************************************************************************
  // for change status
  ApiResponse<LCPDocumentApprovalPendingModel> lcpStatusChangeData =
      ApiResponse.loading();

  setLcpDocumentPendingApprovalChangeStatusList(
      ApiResponse<LCPDocumentApprovalPendingModel> response) {
    lcpDocumentApprovalSubmitData = response;
    notifyListeners();
  }

  Future<void> fetchLCPDocumentPendingApprovalChangeStatusListApi(
      BuildContext context, String tokenNo, String status) async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    setLcpDocumentPendingApprovalChangeStatusList(ApiResponse.loading());
    _myRepo
        .lcpDocumentPendingApprovalChangeStatusApi(tokenNo, status, data.token!)
        .then((value) async {
      setLcpDocumentPendingApprovalChangeStatusList(
          ApiResponse.completed(value));
      CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
          'Successfully Updated', context);
      // Navigator.of(context).push(MaterialPageRoute(
      //     builder: (BuildContext context) =>
      //         const AddNewRowMaintenancePlanTable()));
      if (kDebugMode) {
        print(value.toString());
      }
      return value;
      // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
    }).onError((error, StackTrace) {
      setLcpDocumentPendingApprovalChangeStatusList(
          ApiResponse.error(error.toString()));
      if (kDebugMode) {
        CustomToastSnackBarProgressDialog.flushBarErrorMessage(
            error.toString(), context);
        print(error.toString());
      }
      return LCPDocumentApprovalPendingModel();
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
