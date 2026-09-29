import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:CIVM/data/response/api_Response.dart';
import 'package:CIVM/models/add_crew_member_model.dart';
import 'package:CIVM/models/user_model.dart';
import 'package:CIVM/repository/auth_repository.dart';
import 'package:CIVM/utils/custom_toast_snackbar_progressdialog.dart';
import 'package:CIVM/utils/user_pref.dart';

class AddCrewMemberViewModel with ChangeNotifier {
  final _myRepo = AuthRepository();

//*****************************tabular data**********************************************/
  ApiResponse<AddCrewMemberModel> addCrewMemberTabularData =
      ApiResponse.loading();

  setAddCrewMemberTabularList(ApiResponse<AddCrewMemberModel> response) {
    addCrewMemberTabularData = response;
    notifyListeners();
  }

  // Future<void> fetchAddCrewMemberTabularListApi(BuildContext context) async {
  //   final userPreferences = Provider.of<UserPref>(context, listen: false);
  //   UserModel data = await userPreferences.getUser();
  //   setAddCrewMemberTabularList(ApiResponse.loading());
  //   _myRepo.addCrewMemberTabularDataApi(data.token!).then((value) async {
  //     setAddCrewMemberTabularList(ApiResponse.completed(value));
  //     if (kDebugMode) {
  //       print(value.toString());
  //     }
  //     return value;
  //     // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
  //   }).onError((error, StackTrace) {
  //     setAddCrewMemberTabularList(ApiResponse.error(error.toString()));
  //     if (kDebugMode) {
  //       CustomToastSnackBarProgressDialog.flushBarErrorMessage(
  //           error.toString(), context);
  //       print(error.toString());
  //     }
  //     return AddCrewMemberModel();
  //   });
  // }
Future<void> fetchAddCrewMemberTabularListApi(BuildContext context) async {
  final userPreferences = Provider.of<UserPref>(
    context,
    listen: false,
  );

  UserModel data = await userPreferences.getUser();

  setAddCrewMemberTabularList(ApiResponse.loading());

  try {
    final value = await _myRepo.addCrewMemberTabularDataApi(
      data.token!,
    );

    setAddCrewMemberTabularList(
      ApiResponse.completed(value),
    );

    if (kDebugMode) {
      print(value.toString());
    }
  } catch (error, stackTrace) {
    setAddCrewMemberTabularList(
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
  // ***************************************************************************************************
//   // for updating the status in add crew member*******************
  ApiResponse<AddCrewMemberModel> approveCIVMUpdateData = ApiResponse.loading();

  setApproveCIVMPostList(ApiResponse<AddCrewMemberModel> response) {
    approveCIVMUpdateData = response;
    notifyListeners();
  }

  Future<void> fetchApproveCIVMUpdatePutListApi(
      BuildContext context, String status, String userName) async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    setApproveCIVMPostList(ApiResponse.loading());
    _myRepo
        .addCrewMemberPutDataApi(data.token!, status, userName)
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
      return AddCrewMemberModel();
    });
  }

  // ***************************************************************************************************
//   // for Inserting data in add crew member*******************
  ApiResponse<AddCrewMemberModel> addCrewMemeberInsert = ApiResponse.loading();

  setAddCrewMemberInsertList(ApiResponse<AddCrewMemberModel> response) {
    addCrewMemeberInsert = response;
    notifyListeners();
  }

  Future<void> fetchAddCrewMemberInsertApi(
      BuildContext context, Map mappedData) async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    setAddCrewMemberInsertList(ApiResponse.loading());
    _myRepo
        .addCrewMemberInsertDataApi(data.token!, mappedData)
        .then((value) async {
      setAddCrewMemberInsertList(ApiResponse.completed(value));
      CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
          'Data Successfully Inserted', context);
      // Navigator.pop(context);
      if (kDebugMode) {
        print(value.toString());
      }
      return value;
      // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
    }).onError((error, StackTrace) {
      setAddCrewMemberInsertList(ApiResponse.error(error.toString()));
      if (kDebugMode) {
        CustomToastSnackBarProgressDialog.flushBarErrorMessage(
            error.toString(), context);
        print(error.toString());
      }
      return AddCrewMemberModel();
    });
  }

  // ***************************************************************************************************
//   // for deleting data in add crew member*******************
  ApiResponse<AddCrewMemberModel> addCrewMemeberDelete = ApiResponse.loading();

  setAddCrewMemberDeleteList(ApiResponse<AddCrewMemberModel> response) {
    addCrewMemeberDelete = response;
    notifyListeners();
  }

  Future<void> fetchAddCrewMemberDeleteApi(
      BuildContext context, String id) async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    setAddCrewMemberDeleteList(ApiResponse.loading());
    _myRepo.addCrewMemberDeleteDataApi(data.token!, id).then((value) async {
      setAddCrewMemberDeleteList(ApiResponse.completed(value));
      if (kDebugMode) {
        // print(value.toString());
      }
      // return value;
      // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
    }).onError((error, StackTrace) {
      setAddCrewMemberDeleteList(ApiResponse.error(error.toString()));
      if (kDebugMode) {
        // CustomToastSnackBarProgressDialog.flushBarErrorMessage(
        //     error.toString(), context);
        print(error.toString());
      }
      // return AddCrewMemberModel();
    });
  }
}
