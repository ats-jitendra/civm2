import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:CIVM/data/response/api_Response.dart';
import 'package:CIVM/models/RowMaintenacePlanTabModel.dart';
import 'package:CIVM/models/user_model.dart';
import 'package:CIVM/repository/auth_repository.dart';
import 'package:CIVM/utils/custom_toast_snackbar_progressdialog.dart';
import 'package:CIVM/utils/user_pref.dart';

class RowMaintenancePlanTabViewModel with ChangeNotifier {
  final _myRepo = AuthRepository();
  ApiResponse<RowMaintenacePlanTabModel> rowMaintenancePlanTabList =
      ApiResponse.loading();

  setRowMaintenancePlanTabList(
      ApiResponse<RowMaintenacePlanTabModel> response) {
    rowMaintenancePlanTabList = response;
    notifyListeners();
  }

  Future<void> fetchRowMaintenancePlanTavViewListApi(
    BuildContext context,
    String yearList,
    String cycleList,
    String substationList,
    String feederList,
  ) async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    setRowMaintenancePlanTabList(ApiResponse.loading());
    _myRepo
        .rowMaintenancePlanTabViewApi(
            yearList, cycleList, substationList, feederList, data.token!)
        .then((value) async {
      setRowMaintenancePlanTabList(ApiResponse.completed(value));
      if (kDebugMode) {
        print(value.toString());
      }
      return value;
    }).onError((error, StackTrace) {
      setRowMaintenancePlanTabList(ApiResponse.error(error.toString()));
      if (kDebugMode) {
        CustomToastSnackBarProgressDialog.flushBarErrorMessage(
            error.toString(), context);
        print(error.toString());
      }
      return RowMaintenacePlanTabModel();
    });
  }

// ***************************************************************************************************
  // for submitting data
  ApiResponse<RowMaintenacePlanTabModel> rowMaintenancePlanTabViewSubmitData =
      ApiResponse.loading();

  setRowMaintenancePlanTabViewPostList(
      ApiResponse<RowMaintenacePlanTabModel> response) {
    rowMaintenancePlanTabViewSubmitData = response;
    notifyListeners();
  }

  Future<void> fetchRowMaintenancePlanTabViewUpdateListApi(
      BuildContext context, List mappedData) async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    setRowMaintenancePlanTabViewPostList(ApiResponse.loading());
    _myRepo
        .rowMaintenancePlanTabViewSubmitDataApi(mappedData, data.token!)
        .then((value) async {
      setRowMaintenancePlanTabViewPostList(ApiResponse.completed(value));
      CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
          'Row Maintenance Plan Modified Successfully', context);
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
      setRowMaintenancePlanTabViewPostList(ApiResponse.error(error.toString()));
      if (kDebugMode) {
        CustomToastSnackBarProgressDialog.flushBarErrorMessage(
            error.toString(), context);
        print(error.toString());
      }
      return RowMaintenacePlanTabModel();
    });
  }
}



















//  // ***************************************************************************************************
//   // for submitting data
//   ApiResponse<PostAuditTestOutSingleDataModel> postAuditSubmitData =
//       ApiResponse.loading();

//   setPostAuditPostList(ApiResponse<PostAuditTestOutSingleDataModel> response) {
//     postAuditSubmitData = response;
//     notifyListeners();
//   }

//   Future<void> fetchnPostAuditSubmitDataPutListApi(
//       BuildContext context, Map mappedData) async {
//     final userPreferences = Provider.of<UserPref>(context, listen: false);
//     UserModel data = await userPreferences.getUser();
//     setPostAuditPostList(ApiResponse.loading());
//     _myRepo
//         .postAuditTestOutSubmitData(mappedData, data.token!)
//         .then((value) async {
//       setPostAuditPostList(ApiResponse.completed(value));
//       CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
//           'Successfully Submitted', context);

//       if (kDebugMode) {
//         print(value.toString());
//       }
//       return value;
//       // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
//     }).onError((error, StackTrace) {
//       setPostAuditPostList(ApiResponse.error(error.toString()));
//       if (kDebugMode) {
//         CustomToastSnackBarProgressDialog.flushBarErrorMessage(
//             error.toString(), context);
//         print(error.toString());
//       }
//       return PostAuditTestOutSingleDataModel();
//     });
//   }
// }
