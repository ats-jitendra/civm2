import 'package:CIVM/piedmont/models/lcpChangeOrderModel.dart';
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
class LCPChangeOrderViewModel with ChangeNotifier {
  final _myRepo = AuthRepositoryPemc();
  ApiResponse<LcpCreateOrderModel> lcpChangeOrderList = ApiResponse.loading();

  setLCPChangeOrderList(ApiResponse<LcpCreateOrderModel> response) {
    lcpChangeOrderList = response;
    notifyListeners();
  }

  Future<void> fetchLCPChangeOrderViewListApi(
      BuildContext context,
      String substation,
      String userType,
      String action,
      String streetAddress,
      String location,
      String substationId,
      String contractorCompany) async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    setLCPChangeOrderList(ApiResponse.loading());
    _myRepo
        .lcpChangeOrderGetApi(substation, userType, action, streetAddress,
            location, substationId, contractorCompany, data.token!)
        .then((value) async {
      setLCPChangeOrderList(ApiResponse.completed(value));
      if (kDebugMode) {
        print(value.toString());
      }
      return value;
    }).onError((error, StackTrace) {
      setLCPChangeOrderList(ApiResponse.error(error.toString()));
      if (kDebugMode) {
        CustomToastSnackBarProgressDialog.flushBarErrorMessage(
            error.toString(), context);
        print(error.toString());
      }
      return LcpCreateOrderModel();
    });
  }

  // ***************************************************************************************************
  // for submitting data
//   ApiResponse<LcpCreateOrderModel> lcpCreateOrderSubmitData =
//       ApiResponse.loading();

//   setLCPCreateOrderSubmitList(ApiResponse<LcpCreateOrderModel> response) {
//     lcpCreateOrderSubmitData = response;
//     notifyListeners();
//   }

//   Future<int> fetchLCPCreateOrderSubmitListApi(
//       BuildContext context, Map mappedData) async {
//     final userPreferences = Provider.of<UserPref>(context, listen: false);
//     UserModel data = await userPreferences.getUser();
//     setLCPCreateOrderSubmitList(ApiResponse.loading());
//     _myRepo
//         .lcpCreateOrderSubmitApi(mappedData, data.token!)
//         .then((value) async {
//       setLCPCreateOrderSubmitList(ApiResponse.completed(value));
//       CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
//           'Successfully Submitted', context);
//       // Navigator.of(context).push(MaterialPageRoute(
//       //     builder: (BuildContext context) =>
//       //         const AddNewRowMaintenancePlanTable()));
//       if (kDebugMode) {
//         print(value.toString());
//       }
//       return value;
//       // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
//     }).onError((error, StackTrace) {
//       setLCPCreateOrderSubmitList(ApiResponse.error(error.toString()));
//       if (kDebugMode) {
//         CustomToastSnackBarProgressDialog.flushBarErrorMessage(
//             error.toString(), context);
//         print(error.toString());
//       }
//       return LcpCreateOrderModel();
//     });
//     return 1;
//   }
}
