import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:CIVM/data/response/api_Response.dart';
import 'package:CIVM/models/approve_civm_access_model.dart';
import 'package:CIVM/models/user_model.dart';
import 'package:CIVM/repository/auth_repository.dart';
import 'package:CIVM/utils/custom_toast_snackbar_progressdialog.dart';
import 'package:CIVM/utils/user_pref.dart';

class ApproveCIVMAccessViewModel with ChangeNotifier {
  final _myRepo = AuthRepository();

//*****************************tabular data********************************************* */
  ApiResponse<ApproveCIVMAccessModel> approveCIVMAccessTabularData =
      ApiResponse.loading();

  setApproveCIVMAccessTabularList(
      ApiResponse<ApproveCIVMAccessModel> response) {
    approveCIVMAccessTabularData = response;
    notifyListeners();
  }

  // Future<void> fetchApproveCIVMAccessTabularListApi(
  //     BuildContext context, String loginId, String id) async {
  //   final userPreferences = Provider.of<UserPref>(context, listen: false);
  //   UserModel data = await userPreferences.getUser();
  //   setApproveCIVMAccessTabularList(ApiResponse.loading());
  //   _myRepo
  //       .approveCIVMAccessTabularDataApi(loginId, id, data.token!)
  //       .then((value) async {
  //     setApproveCIVMAccessTabularList(ApiResponse.completed(value));
  //     if (kDebugMode) {
  //       print(value.toString());
  //     }
  //     return value;
  //     // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
  //   }).onError((error, StackTrace) {
  //     setApproveCIVMAccessTabularList(ApiResponse.error(error.toString()));
  //     if (kDebugMode) {
  //       CustomToastSnackBarProgressDialog.flushBarErrorMessage(
  //           error.toString(), context);
  //       print(error.toString());
  //     }
  //     return ApproveCIVMAccessModel();
  //   });
  // }
   
   Future<void> fetchApproveCIVMAccessTabularListApi(
  BuildContext context,
  String loginId,
  String id,
) async {
  final userPreferences = Provider.of<UserPref>(
    context,
    listen: false,
  );

  UserModel data = await userPreferences.getUser();

  setApproveCIVMAccessTabularList(
    ApiResponse.loading(),
  );

  try {
    final value = await _myRepo.approveCIVMAccessTabularDataApi(
      loginId,
      id,
      data.token!,
    );

    setApproveCIVMAccessTabularList(
      ApiResponse.completed(value),
    );

    if (kDebugMode) {
      print(value.toString());
    }
  } catch (error, stackTrace) {
    setApproveCIVMAccessTabularList(
      ApiResponse.error(error.toString()),
    );

    if (kDebugMode) {
      CustomToastSnackBarProgressDialog.flushBarErrorMessage(
        error.toString(),
        context,
      );

      print(error.toString());
      print(stackTrace);
    }
  }
}
   
//    Future<void> fetchApproveCIVMAccessTabularListApi(
//   BuildContext context,
//   String search1,
//   String search2,
// ) async {
//   final userPreferences = Provider.of<UserPref>(
//     context,
//     listen: false,
//   );

//   UserModel data = await userPreferences.getUser();

//   setApproveCIVMAccessTabularList(
//     ApiResponse.loading(),
//   );

//   try {
//     final value = await _myRepo.approveCIVMAccessTabularDataApi(
//       data.token!,
//       search1,
//       search2,
//     );

//     setApproveCIVMAccessTabularList(
//       ApiResponse.completed(value),
//     );

//     if (kDebugMode) {
//       print(value.toString());
//     }
//   } catch (error, stackTrace) {
//     setApproveCIVMAccessTabularList(
//       ApiResponse.error(error.toString()),
//     );

//     if (kDebugMode) {
//       CustomToastSnackBarProgressDialog.flushBarErrorMessage(
//         error.toString(),
//         context,
//       );

//       print(error.toString());
//       print(stackTrace);
//     }
//   }
// }
 
 
  // ***************************************************************************************************
//   // for submitting data in approve CIVM*******************
  ApiResponse<ApproveCIVMAccessModel> approveCIVMUpdateData =
      ApiResponse.loading();

  setApproveCIVMPostList(ApiResponse<ApproveCIVMAccessModel> response) {
    approveCIVMUpdateData = response;
    notifyListeners();
  }

  Future<void> fetchApproveCIVMUpdatePutListApi(
      BuildContext context, String status, String userName) async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    setApproveCIVMPostList(ApiResponse.loading());
    _myRepo
        .approveCIVMPutDataApi(data.token!, status, userName)
        .then((value) async {
      setApproveCIVMPostList(ApiResponse.completed(value));
      if (kDebugMode) {
        print(value.toString());
      }
      return value;
      // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
    }).onError((error, StackTrace) {
      setApproveCIVMPostList(ApiResponse.error(error.toString()));
      if (kDebugMode) {
        CustomToastSnackBarProgressDialog.flushBarErrorMessage(
            error.toString(), context);
        print(error.toString());
      }
      return ApproveCIVMAccessModel();
    });
  }

  // ***************************************************************************************************
  // for submitting data1
  ApiResponse<ApproveCIVMAccessModel> approveCIVMPlanSubmitData =
      ApiResponse.loading();

  setApproveCIVMSubmitList(ApiResponse<ApproveCIVMAccessModel> response) {
    approveCIVMPlanSubmitData = response;
    notifyListeners();
  }

  Future<void> fetchApproveCIVMSubmitListApi1(
      BuildContext context, Map mappedData) async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    setApproveCIVMSubmitList(ApiResponse.loading());
    _myRepo.approveCIVMSubmitApi(mappedData, data.token!).then((value) async {
      setApproveCIVMSubmitList(ApiResponse.completed(value));
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
      setApproveCIVMSubmitList(ApiResponse.error(error.toString()));
      if (kDebugMode) {
        CustomToastSnackBarProgressDialog.flushBarErrorMessage(
            error.toString(), context);
        print(error.toString());
      }
      return ApproveCIVMAccessModel();
    });
  }

  // ***************************************************************************************************
  // for submitting data2
  ApiResponse<ApproveCIVMAccessModel> approveCIVMPlanSubmitData2 =
      ApiResponse.loading();

  setApproveCIVMSubmitList2(ApiResponse<ApproveCIVMAccessModel> response) {
    approveCIVMPlanSubmitData2 = response;
    notifyListeners();
  }

  Future<void> fetchApproveCIVMSubmitListApi2(
      BuildContext context, Map mappedData) async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    setApproveCIVMSubmitList2(ApiResponse.loading());
    _myRepo.approveCIVMSubmitApi2(mappedData, data.token!).then((value) async {
      setApproveCIVMSubmitList2(ApiResponse.completed(value));
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
      setApproveCIVMSubmitList2(ApiResponse.error(error.toString()));
      if (kDebugMode) {
        CustomToastSnackBarProgressDialog.flushBarErrorMessage(
            error.toString(), context);
        print(error.toString());
      }
      return ApproveCIVMAccessModel();
    });
  }

  // ***************************************************************************************************
  // for submitting data3
  ApiResponse<ApproveCIVMAccessModel> approveCIVMPlanSubmitData3 =
      ApiResponse.loading();

  setApproveCIVMSubmitList3(ApiResponse<ApproveCIVMAccessModel> response) {
    approveCIVMPlanSubmitData3 = response;
    notifyListeners();
  }

  Future<void> fetchApproveCIVMSubmitListApi3(
    BuildContext context,
    String supervisor,
    String contractor,
  ) async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    setApproveCIVMSubmitList3(ApiResponse.loading());
    _myRepo
        .approveCIVMSubmitApi3( supervisor, contractor, data.token!)
        .then((value) async {
      setApproveCIVMSubmitList3(ApiResponse.completed(value));
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
      setApproveCIVMSubmitList3(ApiResponse.error(error.toString()));
      if (kDebugMode) {
        CustomToastSnackBarProgressDialog.flushBarErrorMessage(
            error.toString(), context);
        print(error.toString());
      }
      return ApproveCIVMAccessModel();
    });
  }
}
