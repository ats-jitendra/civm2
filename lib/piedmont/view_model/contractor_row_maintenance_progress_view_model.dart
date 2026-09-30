import 'package:CIVM/piedmont/models/contractor_row_maintenance_progress_model.dart';
import 'package:CIVM/piedmont/models/row_maint_image_uplaod_contractor.dart';
import 'package:CIVM/piedmont/models/row_maintenance_progress_contractor_insert_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:CIVM/piedmont/data/response/api_Response.dart';
import 'package:CIVM/piedmont/models/user_model.dart';
import 'package:CIVM/piedmont/repository/auth_repository.dart';
import 'package:CIVM/piedmont/utils/custom_toast_snackbar_progressdialog.dart';
import 'package:CIVM/piedmont/utils/user_pref.dart';
import 'package:dio/dio.dart';
import 'package:CIVM/utils/user_pref.dart';
import 'package:CIVM/models/user_model.dart';
class ContractorRowMaintenanceProgressViewModelViewModel with ChangeNotifier {
  final _myRepo = AuthRepositoryPemc();

//*****************************get data********************************************* */
  ApiResponse<ContractorRowMaintenanceProgressModel>
      contractorRowMaintenanceProgressViewModelGetTabularData =
      ApiResponse.loading();

  setContractorRowMaintenanceProgressViewModelGetTabularList(
      ApiResponse<ContractorRowMaintenanceProgressModel> response) {
    contractorRowMaintenanceProgressViewModelGetTabularData = response;
    notifyListeners();
  }

  Future<void> fetchContractorRowMaintenanceProgressViewModelTabularListApi(
      BuildContext context,
      String contractor,
      // String substation,
      // String feeder,
      // String nextMaintDue,
      String tokenNo) async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    setContractorRowMaintenanceProgressViewModelGetTabularList(
        ApiResponse.loading());
    _myRepo
        .contractorRowMaintenanceProgressTabularDataApi(
            data.token!, contractor, tokenNo)
        .then((value) async {
      setContractorRowMaintenanceProgressViewModelGetTabularList(
          ApiResponse.completed(value));
      if (kDebugMode) {
        print(value.toString());
      }
      return value;
      // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
    }).onError((error, StackTrace) {
      setContractorRowMaintenanceProgressViewModelGetTabularList(
          ApiResponse.error(error.toString()));
      if (kDebugMode) {
        CustomToastSnackBarProgressDialog.flushBarErrorMessage(
            error.toString(), context);
        print(error.toString());
      }
      return ContractorRowMaintenanceProgressModel();
    });
  }

  // ***************************************************************************************************
  // for submitting data
  ApiResponse<RowMaintenanceProgressContractorInsertModel>
      rowMaintenanceProgressContractorSubmitData = ApiResponse.loading();

  setRowMaintenanceProgressContractorSubmitList(
      ApiResponse<RowMaintenanceProgressContractorInsertModel> response) {
    rowMaintenanceProgressContractorSubmitData = response;
    notifyListeners();
  }

  Future<void> fetchRowMaintenanceProgressContractorSubmitListApi(
      BuildContext context, Map mappedData) async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    setRowMaintenanceProgressContractorSubmitList(ApiResponse.loading());
    _myRepo
        .rowMaintenanceProgressContractorSubmitListApi(mappedData, data.token!)
        .then((value) async {
      setRowMaintenanceProgressContractorSubmitList(
          ApiResponse.completed(value));
      CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
          'Successfully Submitted', context);
      print('data successfully submitted');
      // Navigator.of(context).push(MaterialPageRoute(
      //     builder: (BuildContext context) =>
      //         const InvoiceFormTable()));
      if (kDebugMode) {
        print(value.toString());
      }
      return value;
    }).onError((error, StackTrace) {
      setRowMaintenanceProgressContractorSubmitList(
          ApiResponse.error(error.toString()));
      print('error.toString()in submitting data ${error.toString()}');
      if (kDebugMode) {
        CustomToastSnackBarProgressDialog.flushBarErrorMessage(
            error.toString(), context);
        print('error in submitting data');
        print(error.toString());
      }
      return RowMaintenanceProgressContractorInsertModel();
    });
  }

  // ***************************************************************************************************
  // for image upload
  ApiResponse<RowMaintenanceImageUploadContractorModel>
      rowMaintImageUploadContractor = ApiResponse.loading();

  setRowMaintImageUploadContractor(
      ApiResponse<RowMaintenanceImageUploadContractorModel> response) {
    rowMaintImageUploadContractor = response;
    notifyListeners();
  }

  Future<void> fetchRowMaintenanceImageUploadApi(
      BuildContext context, FormData formData) async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    setRowMaintImageUploadContractor(ApiResponse.loading());

    _myRepo
        .rowMaintenanceUploadImageContractorApi(formData, data.token!)
        .then((value) async {
      setRowMaintImageUploadContractor(ApiResponse.completed(value));
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
      setRowMaintImageUploadContractor(ApiResponse.error(error.toString()));
      if (kDebugMode) {
        CustomToastSnackBarProgressDialog.flushBarErrorMessage(
            error.toString(), context);
        print(error.toString());
      }
      return RowMaintenanceImageUploadContractorModel();
    });
  }

  ////////////////////////////////////////////////////////////
  //submit for review
  ApiResponse<ContractorRowMaintenanceProgressModel> submitForReview =
      ApiResponse.loading();

  setSubmitForReviewPostList(
      ApiResponse<ContractorRowMaintenanceProgressModel> response) {
    submitForReview = response;
    notifyListeners();
  }

  Future<void> fetchSubmitForReviewListApi(
      BuildContext context, String id) async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    setSubmitForReviewPostList(ApiResponse.loading());
    _myRepo.rowMaintSubmitForReviewApi(data.token!, id).then((value) async {
      print('value $value');
      setSubmitForReviewPostList(ApiResponse.completed(value));

      CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
          'Submitted for Review Successfully', context);
      print('Submitted for Review Successfully');

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
      setSubmitForReviewPostList(ApiResponse.error(error.toString()));
      if (kDebugMode) {
        CustomToastSnackBarProgressDialog.flushBarErrorMessage(
            error.toString(), context);
        print(error.toString());
        print('error');
      }
      return ContractorRowMaintenanceProgressModel();
    });
  }
}
