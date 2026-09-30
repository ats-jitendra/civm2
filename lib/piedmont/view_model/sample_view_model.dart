// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';

// import '../data/response/api_response.dart';
// import '../repository/auth_repository.dart';
// import '../utils/custom_toast_snackbar_progressdialog.dart';
// import '../utils/user_pref.dart';

// class PostAuditTestOutServiceOrdersViewModel with ChangeNotifier {
//   final _myRepo = AuthRepository();
//   ApiResponse<PostAuditModel> postAuditTestOutGetList = ApiResponse.loading();

//   setPostAuditTestOutServiceOrdersList(ApiResponse<PostAuditModel> response) {
//     postAuditTestOutGetList = response;
//     notifyListeners();
//   }

//   Future<void> fetchnPostAuditTestOutServiceOrdersListApi(
//       BuildContext context) async {
//     final userPreferences = Provider.of<UserPref>(context, listen: false);
//     UserModel data = await userPreferences.getUser();
//     setPostAuditTestOutServiceOrdersList(ApiResponse.loading());
//     _myRepo.postAuditApi(data.token!).then((value) async {
//       setPostAuditTestOutServiceOrdersList(ApiResponse.completed(value));
//       if (kDebugMode) {
//         print(value.toString());
//       }
//       return value;
//       // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
//     }).onError((error, StackTrace) {
//       setPostAuditTestOutServiceOrdersList(ApiResponse.error(error.toString()));
//       if (kDebugMode) {
//         CustomToastSnackBarProgressDialog.flushBarErrorMessage(
//             error.toString(), context);
//         print(error.toString());
//       }
//       return PostAuditModel();
//     });
//   }

// // *********************************************************************************************
//   ApiResponse<PostAuditTestOutSingleDataModel> postAuditGetDataByAuditID =
//       ApiResponse.loading();

//   setPostAuditTestOutGetData(
//       ApiResponse<PostAuditTestOutSingleDataModel> response) {
//     postAuditGetDataByAuditID = response;
//     notifyListeners();
//   }

//   Future<void> fetchnPostAuditTestOutSingleDataApi(
//       BuildContext context, String auditId) async {
//     final userPreferences = Provider.of<UserPref>(context, listen: false);
//     UserModel data = await userPreferences.getUser();
//     setPostAuditTestOutGetData(ApiResponse.loading());
//     _myRepo
//         .postAuditTestOutByAuditIdApi(auditId, data.token!)
//         .then((value) async {
//       setPostAuditTestOutGetData(ApiResponse.completed(value));
//       if (kDebugMode) {
//         print(value.toString());
//       }
//       return value;
//       // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
//     }).onError((error, StackTrace) {
//       setPostAuditTestOutGetData(ApiResponse.error(error.toString()));
//       if (kDebugMode) {
//         CustomToastSnackBarProgressDialog.flushBarErrorMessage(
//             error.toString(), context);
//         print(error.toString());
//       }
//       return PostAuditTestOutSingleDataModel();
//     });
//   }

//   // ***************************************************************************************************
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
