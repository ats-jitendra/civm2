import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:CIVM/piedmont/data/response/api_Response.dart';
import 'package:CIVM/piedmont/models/add_budget_planning_third_model.dart';
import 'package:CIVM/piedmont/models/user_model.dart';
import 'package:CIVM/piedmont/repository/auth_repository.dart';
import 'package:CIVM/piedmont/utils/custom_toast_snackbar_progressdialog.dart';
import 'package:CIVM/piedmont/utils/user_pref.dart';
import 'package:CIVM/utils/user_pref.dart';
import 'package:CIVM/models/user_model.dart';
class AddBudgetPlanningThirdViewModel with ChangeNotifier {
  final _myRepo = AuthRepositoryPemc();

  //*****************************get data in third page**********************************************/
  ApiResponse<AddBudgetPlanThirdModel> addBudgetPlanningThirdGetData =
      ApiResponse.loading();

  setAddBudgetPlanningThirdGetList(
      ApiResponse<AddBudgetPlanThirdModel> response) {
    addBudgetPlanningThirdGetData = response;
    notifyListeners();
  }

  Future<void> fetchAddBudgetPlanningThirdGetListApi(
      BuildContext context, String id, String substation, String year) async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    setAddBudgetPlanningThirdGetList(ApiResponse.loading());
    _myRepo
        .addBudgetPlanningThirdGetDataApi(id, substation, year, data.token!)
        .then((value) async {
      setAddBudgetPlanningThirdGetList(ApiResponse.completed(value));
      if (kDebugMode) {
        print(value.toString());
      }
      return value;
      // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
    }).onError((error, StackTrace) {
      setAddBudgetPlanningThirdGetList(ApiResponse.error(error.toString()));
      if (kDebugMode) {
        CustomToastSnackBarProgressDialog.flushBarErrorMessage(
            error.toString(), context);
        print(error.toString());
      }
      return AddBudgetPlanThirdModel();
    });
  }

  // ***************************************************************************************************
  // for submitting card data in the third page of budget planning
  ApiResponse<AddBudgetPlanThirdModel> addBudgetPlanningThirdSubmitData =
      ApiResponse.loading();

  setAddBudgetPlanningThirdSubmitPostList(
      ApiResponse<AddBudgetPlanThirdModel> response) {
    addBudgetPlanningThirdSubmitData = response;
    notifyListeners();
  }

  Future<void> fetchAddBudgedtPlanningThirdInsertListApi(
      BuildContext context, List mappedData) async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    setAddBudgetPlanningThirdSubmitPostList(ApiResponse.loading());
    _myRepo
        .addBudgetPlanningThirdInsertDataApi(mappedData, data.token!)
        .then((value) async {
      setAddBudgetPlanningThirdSubmitPostList(ApiResponse.completed(value));
      print('Card data entering');
      CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
          'Successfully Submitted', context);
      print('Card data succesxsfully entered');
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
      setAddBudgetPlanningThirdSubmitPostList(
          ApiResponse.error(error.toString()));
      if (kDebugMode) {
        print('Error123456');
        CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
            'Successfully created', context);
        // CustomToastSnackBarProgressDialog.flushBarErrorMessage(
        //     error.toString(), context);
        print(error.toString());
      }
      return AddBudgetPlanThirdModel();
    });
  }

  // ***************************************************************************************************
  // for submitting textBox data in the third page of budget planning
  ApiResponse<AddBudgetPlanThirdModel> addBudgetPlanningThirdBoxSubmitData =
      ApiResponse.loading();

  setAddBudgetPlanningThirdBoxSubmitPostList(
      ApiResponse<AddBudgetPlanThirdModel> response) {
    addBudgetPlanningThirdBoxSubmitData = response;
    notifyListeners();
  }

  Future<void> fetchAddBudgedtPlanningThirdBoxInsertListApi(
      BuildContext context, Map mappedData) async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    setAddBudgetPlanningThirdBoxSubmitPostList(ApiResponse.loading());
    _myRepo
        .addBudgetPlanningThirdBoxInsertDataApi(mappedData, data.token!)
        .then((value) async {
      setAddBudgetPlanningThirdBoxSubmitPostList(ApiResponse.completed(value));
      CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
          'Successfully Submitted', context);
      // Navigator.of(context).push(MaterialPageRoute(
      //     builder: (BuildContext context) =>
      //         const AddNewRowMaintenancePlanTable()));
      print('object');
      if (kDebugMode) {
        print(value.toString());
        print('object1');
      }
      return value;
      // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
    }).onError((error, StackTrace) {
      setAddBudgetPlanningThirdBoxSubmitPostList(
          ApiResponse.error(error.toString()));
      print('object2');
      if (kDebugMode) {
        CustomToastSnackBarProgressDialog.flushBarErrorMessage(
            error.toString(), context);
        print(error.toString());
        print('object3');
      }
      print('object4');
      return AddBudgetPlanThirdModel();
    });
  }

  // ***************************************************************************************************
//   // for deleting data in add budget planning*******************
  // ApiResponse<AddBudgetPlanThirdModel> addBudgetPlanningThirdDelete =
  //     ApiResponse.loading();

  // setAddBudgetPlanningThirdDeleteList(
  //     ApiResponse<AddBudgetPlanThirdModel> response) {
  //   addBudgetPlanningThirdDelete = response;
  //   notifyListeners();
  // }

  // Future<void> fetchAddBudgetPlanningDeleteDataApi(
  //     BuildContext context, String id) async {
  //   final userPreferences = Provider.of<UserPref>(context, listen: false);
  //   UserModel data = await userPreferences.getUser();
  //   setAddBudgetPlanningThirdDeleteList(ApiResponse.loading());
  //   _myRepo
  //       .addBudgetPlanningThirdDeleteDataApi(data.token!, id)
  //       .then((value) async {
  //     setAddBudgetPlanningThirdDeleteList(ApiResponse.completed(value));
  //     if (kDebugMode) {
  //       // print(value.toString());
  //     }
  //     // return value;
  //     // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
  //   }).onError((error, StackTrace) {
  //     setAddBudgetPlanningThirdDeleteList(ApiResponse.error(error.toString()));
  //     if (kDebugMode) {
  //       // CustomToastSnackBarProgressDialog.flushBarErrorMessage(
  //       //     error.toString(), context);
  //       print(error.toString());
  //     }
  //     // return AddBudgetPlanningModel();
  //   });
  // }
}
