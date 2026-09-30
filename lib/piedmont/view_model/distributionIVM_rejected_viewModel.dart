import 'package:CIVM/piedmont/models/distributionIVM_rejected_model.dart';
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
class DistributionivmRejectedViewmodel with ChangeNotifier {
  final _myRepo = AuthRepositoryPemc();

//*****************************tabular data********************************************* */
  ApiResponse<DistributionIVMRejected> distributionivmRejectedGetTabularData =
      ApiResponse.loading();

  setLcpWorkOrderClosedGetTabularList(
      ApiResponse<DistributionIVMRejected> response) {
    distributionivmRejectedGetTabularData = response;
    notifyListeners();
  }

  Future<void> fetchDistributionivmRejectedGetTabularListApi(
      BuildContext context, String status) async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    setLcpWorkOrderClosedGetTabularList(ApiResponse.loading());
    _myRepo
        .distributionIVmRejectedTabularDataApi(data.token!, status)
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
      return DistributionIVMRejected();
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
