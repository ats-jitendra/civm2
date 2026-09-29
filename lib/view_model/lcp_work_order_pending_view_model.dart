import 'package:CIVM/models/image_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:CIVM/data/response/api_Response.dart';
import 'package:CIVM/models/lcp_work_order_pending_model.dart';
import 'package:CIVM/models/user_model.dart';
import 'package:CIVM/repository/auth_repository.dart';
import 'package:CIVM/utils/custom_toast_snackbar_progressdialog.dart';
import 'package:CIVM/utils/user_pref.dart';

class LCPWorkOrderPendingViewModel with ChangeNotifier {
  final _myRepo = AuthRepository();

//*****************************tabular data********************************************* */
  ApiResponse<LCPWorkOrderPendingModel> lcpWorkOrderPendingGetTabularData =
      ApiResponse.loading();

  setLcpWorkOrderPendingGetTabularList(
      ApiResponse<LCPWorkOrderPendingModel> response) {
    lcpWorkOrderPendingGetTabularData = response;
    notifyListeners();
  }

  Future<void> fetchLCPWorkOrderPendingTabularListApi(
      BuildContext context,
      String status,
      String workOrderNo,
      String contractorCompany,
      String budgetType,
      String maintenanceType,
      String id,
      String pannel,
      String visibilityFlag) async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    setLcpWorkOrderPendingGetTabularList(ApiResponse.loading());
    _myRepo
        .lcpWorkOrderPendingTabularDataApi(data.token!, status, workOrderNo,
            contractorCompany, budgetType, maintenanceType, id, pannel,visibilityFlag)
        .then((value) async {
      setLcpWorkOrderPendingGetTabularList(ApiResponse.completed(value));
      if (kDebugMode) {
        print(value.toString());
      }
      return value;
      // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
    }).onError((error, StackTrace) {
      setLcpWorkOrderPendingGetTabularList(ApiResponse.error(error.toString()));
      if (kDebugMode) {
        CustomToastSnackBarProgressDialog.flushBarErrorMessage(
            error.toString(), context);
        print(error.toString());
      }
      return LCPWorkOrderPendingModel();
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
