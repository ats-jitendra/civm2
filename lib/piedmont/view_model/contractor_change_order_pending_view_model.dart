import 'package:CIVM/piedmont/models/contractor_order_pending_model.dart';
import 'package:CIVM/piedmont/models/image_model.dart';
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
class ContractorOrderPendingViewModel with ChangeNotifier {
  final _myRepo = AuthRepositoryPemc();

//*****************************tabular data********************************************* */
  ApiResponse<ContractorChangeOrderPendingModel>
      contractorOrderPendingGetTabularData = ApiResponse.loading();

  setContractorOrderPendingGetTabularList(
      ApiResponse<ContractorChangeOrderPendingModel> response) {
    contractorOrderPendingGetTabularData = response;
    notifyListeners();
  }

  Future<void> fetchContractorOrderPendingTabularListApi(
      BuildContext context, String userId, String changeOrder) async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    setContractorOrderPendingGetTabularList(ApiResponse.loading());
    _myRepo
        .contractorOrderPendingTabularDataApi(data.token!, userId, changeOrder)
        .then((value) async {
      setContractorOrderPendingGetTabularList(ApiResponse.completed(value));
      if (kDebugMode) {
        print(value.toString());
      }
      return value;
      // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
    }).onError((error, StackTrace) {
      setContractorOrderPendingGetTabularList(
          ApiResponse.error(error.toString()));
      if (kDebugMode) {
        CustomToastSnackBarProgressDialog.flushBarErrorMessage(
            error.toString(), context);
        print(error.toString());
      }
      return ContractorChangeOrderPendingModel();
    });
  }

//*****************************tabular data********************************************* */
  ApiResponse<ContractorChangeOrderPendingModel>
      contractorOrderPendingStatusChangeData = ApiResponse.loading();

  setContractorOrderPendingStatusChangeList(
      ApiResponse<ContractorChangeOrderPendingModel> response) {
    contractorOrderPendingStatusChangeData = response;
    notifyListeners();
  }

  Future<void> fetchStatusChangeApi(
      BuildContext context, String status, String notes, int id) async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    setContractorOrderPendingStatusChangeList(ApiResponse.loading());
    _myRepo
        .contractorOrderPendingStatusApi(data.token!, status, notes, id)
        .then((value) async {
      setContractorOrderPendingStatusChangeList(ApiResponse.completed(value));
      if (kDebugMode) {
        print(value.toString());
      }
      return value;
      // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
    }).onError((error, StackTrace) {
      setContractorOrderPendingStatusChangeList(
          ApiResponse.error(error.toString()));
      if (kDebugMode) {
        CustomToastSnackBarProgressDialog.flushBarErrorMessage(
            error.toString(), context);
        print(error.toString());
      }
      return ContractorChangeOrderPendingModel();
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
