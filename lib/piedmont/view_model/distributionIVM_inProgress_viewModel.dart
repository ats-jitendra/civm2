import 'package:CIVM/piedmont/models/image_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:CIVM/piedmont/data/response/api_Response.dart';
import 'package:CIVM/piedmont/models/lcp_work_order_closed_model.dart';
import 'package:CIVM/piedmont/repository/auth_repository.dart';
import 'package:CIVM/piedmont/utils/custom_toast_snackbar_progressdialog.dart';
import 'package:CIVM/utils/user_pref.dart';
import 'package:CIVM/models/user_model.dart';
class DistributionivmInProgressViewmodel with ChangeNotifier {
  final _myRepo = AuthRepositoryPemc();

//*****************************tabular data********************************************* */
  ApiResponse<LCPWorkOrdersClosedModel>
      distributionivmInProgressGetTabularData = ApiResponse.loading();

  setLcpWorkOrderClosedGetTabularList(
      ApiResponse<LCPWorkOrdersClosedModel> response) {
    distributionivmInProgressGetTabularData = response;
    notifyListeners();
  }

  Future<void> fetchDistributionivmInProgressGetTabularListApi(
      BuildContext context,
      String status,
      String budgetType,
      String maintType,
      String panel,
      String planType,
      String contractorCompany) async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    setLcpWorkOrderClosedGetTabularList(ApiResponse.loading());
    _myRepo
        .distributionIVmINPROGRESSTabularDataApi(
            data.token!, status, budgetType, maintType, panel, planType, contractorCompany)
        .then((value) async {
      setLcpWorkOrderClosedGetTabularList(ApiResponse.completed(value));
      if (kDebugMode) {
        print(value.toString());
      }
      return value;
      // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
    }).onError((error, StackTrace) {
      setLcpWorkOrderClosedGetTabularList(ApiResponse.error(error.toString()));
      if (kDebugMode) {
        CustomToastSnackBarProgressDialog.flushBarErrorMessage(
            error.toString(), context);
        print(error.toString());
      }
      return LCPWorkOrdersClosedModel();
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
