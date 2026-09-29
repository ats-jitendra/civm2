import 'package:CIVM/models/image_model.dart';
import 'package:CIVM/models/lcp_work_order_reject_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:CIVM/data/response/api_Response.dart';
import 'package:CIVM/models/user_model.dart';
import 'package:CIVM/repository/auth_repository.dart';
import 'package:CIVM/utils/custom_toast_snackbar_progressdialog.dart';
import 'package:CIVM/utils/user_pref.dart';

class LCPWorkOrderRejectViewModel with ChangeNotifier {
  final _myRepo = AuthRepository();

//*****************************tabular data********************************************* */
  ApiResponse<LCPWorkOrderRejectModel> lcpWorkOrderRejectGetTabularData =
      ApiResponse.loading();

  setLcpWorkOrderRejectGetTabularList(
      ApiResponse<LCPWorkOrderRejectModel> response) {
    lcpWorkOrderRejectGetTabularData = response;
    notifyListeners();
  }

  Future<void> fetchLCPWorkOrderRejectTabularListApi(
      BuildContext context,
      String feeder,
      String subStations,
      String status,
      String contractorCompany,
      String budgetType,
      String maintenanceType,
      String id,
      String panel) async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    setLcpWorkOrderRejectGetTabularList(ApiResponse.loading());
    _myRepo
        .lcpWorkOrderRejectTabularDataApi(data.token!, feeder, subStations,
            status, contractorCompany, budgetType, maintenanceType, id, panel)
        .then((value) async {
      setLcpWorkOrderRejectGetTabularList(ApiResponse.completed(value));
      if (kDebugMode) {
        print(value.toString());
      }
      return value;
      // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
    }).onError((error, StackTrace) {
      setLcpWorkOrderRejectGetTabularList(ApiResponse.error(error.toString()));
      if (kDebugMode) {
        CustomToastSnackBarProgressDialog.flushBarErrorMessage(
            error.toString(), context);
        print(error.toString());
      }
      return LCPWorkOrderRejectModel();
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
