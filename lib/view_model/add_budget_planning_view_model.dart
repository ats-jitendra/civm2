import 'package:CIVM/models/add_budget_planning_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:CIVM/data/response/api_Response.dart';
import 'package:CIVM/models/user_model.dart';
import 'package:CIVM/repository/auth_repository.dart';
import 'package:CIVM/utils/custom_toast_snackbar_progressdialog.dart';
import 'package:CIVM/utils/user_pref.dart';

class AddBudgetPlanningViewModel with ChangeNotifier {
  final _myRepo = AuthRepository();

//*****************************get data**********************************************/
  ApiResponse<AddBudgetPlanningModel> addBudgetPlanningGetData =
      ApiResponse.loading();

  setAddBudgetPlanningGetList(ApiResponse<AddBudgetPlanningModel> response) {
    addBudgetPlanningGetData = response;
    notifyListeners();
  }

  Future<void> fetchAddBudgetPlanningGetListApi(
      BuildContext context,
      String budgetId,
      String year,
      String planDtlsId,
      String substationId) async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    setAddBudgetPlanningGetList(ApiResponse.loading());
    _myRepo
        .addBudgetPlanningGetDataApi(
            budgetId, year, planDtlsId, substationId, data.token!)
        .then((value) async {
      setAddBudgetPlanningGetList(ApiResponse.completed(value));
      if (kDebugMode) {
        print(value.toString());
      }
      return value;
      // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
    }).onError((error, StackTrace) {
      setAddBudgetPlanningGetList(ApiResponse.error(error.toString()));
      if (kDebugMode) {
        CustomToastSnackBarProgressDialog.flushBarErrorMessage(
            error.toString(), context);
        print(error.toString());
      }
      return AddBudgetPlanningModel();
    });
  }

  // ***************************************************************************************************
//   // for deleting data in add budget planning*******************
  ApiResponse<AddBudgetPlanningModel> addBudgetPlanningDelete =
      ApiResponse.loading();

  setAddBudgetPlanningDeleteList(ApiResponse<AddBudgetPlanningModel> response) {
    addBudgetPlanningDelete = response;
    notifyListeners();
  }

  Future<void> fetchAddBudgetPlanningDeleteDataApi(
      BuildContext context, String year, String id) async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    setAddBudgetPlanningDeleteList(ApiResponse.loading());
    _myRepo
        .addBudgetPlanningDeleteDataApi(data.token!, year, id)
        .then((value) async {
      setAddBudgetPlanningDeleteList(ApiResponse.completed(value));
      if (kDebugMode) {
        // print(value.toString());
      }
      // return value;
      // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
    }).onError((error, StackTrace) {
      setAddBudgetPlanningDeleteList(ApiResponse.error(error.toString()));
      if (kDebugMode) {
        // CustomToastSnackBarProgressDialog.flushBarErrorMessage(
        //     error.toString(), context);
        print(error.toString());
      }
      // return AddBudgetPlanningModel();
    });
  }

  // ***************************************************************************************************
  // for submitting data
  ApiResponse<AddBudgetPlanningModel> addBudgetPlanningSubmitData =
      ApiResponse.loading();

  setAddBudgetPlanningSubmitPostList(
      ApiResponse<AddBudgetPlanningModel> response) {
    addBudgetPlanningSubmitData = response;
    notifyListeners();
  }

  Future<void> fetchAddBudgedtPlanningInsertListApi(
      BuildContext context, dynamic list) async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    setAddBudgetPlanningSubmitPostList(ApiResponse.loading());
    _myRepo
        .addBudgetPlanningInsertDataApi(list, data.token!)
        .then((value) async {
      setAddBudgetPlanningSubmitPostList(ApiResponse.completed(value));
      CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
          'Successfully Submitted', context);
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
      setAddBudgetPlanningSubmitPostList(ApiResponse.error(error.toString()));
      if (kDebugMode) {
        print('Error123456');
        // CustomToastSnackBarProgressDialog.flushBarErrorMessage(
        //     error.toString(), context);
        print(error.toString());
      }
      return AddBudgetPlanningModel();
    });
  }



   // ***************************************************************************************************
//   // for deleting data in add budget planning*******************
  ApiResponse<AddBudgetPlanningModel> addBudgetPlanningThirdDelete =
      ApiResponse.loading();

  setAddBudgetPlanningThirdDeleteList(
      ApiResponse<AddBudgetPlanningModel> response) {
    addBudgetPlanningThirdDelete = response;
    notifyListeners();
  }

  Future<void> fetchAddBudgetPlanningDeleteThirdDataApi(
      BuildContext context, String id) async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    setAddBudgetPlanningThirdDeleteList(ApiResponse.loading());
    _myRepo
        .addBudgetPlanningThirdDeleteDataApi( id,data.token!)
        .then((value) async {
      setAddBudgetPlanningThirdDeleteList(ApiResponse.completed(value));
      CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
          'Successfully Deleted', context);
      if (kDebugMode) {
        // print(value.toString());
      }
      // return value;
      // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
    }).onError((error, StackTrace) {
      setAddBudgetPlanningThirdDeleteList(ApiResponse.error(error.toString()));
      if (kDebugMode) {
        // CustomToastSnackBarProgressDialog.flushBarErrorMessage(
        //     error.toString(), context);
        print(error.toString());
      }
      // return AddBudgetPlanningModel();
    });
  }

 
}
