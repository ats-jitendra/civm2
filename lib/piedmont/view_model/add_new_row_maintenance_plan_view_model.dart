import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:CIVM/piedmont/data/response/api_Response.dart';
import 'package:CIVM/piedmont/models/add_new_row_maintenance_plan_model.dart';
import 'package:CIVM/piedmont/models/add_new_row_tabular_data.dart';
import 'package:CIVM/piedmont/models/user_model.dart';
import 'package:CIVM/piedmont/repository/auth_repository.dart';
import 'package:CIVM/piedmont/utils/custom_toast_snackbar_progressdialog.dart';
import 'package:CIVM/piedmont/utils/user_pref.dart';
import 'package:CIVM/utils/user_pref.dart';
import 'package:CIVM/models/user_model.dart';
class AddNewRowMaintenancePlanViewModel with ChangeNotifier {
  final _myRepo = AuthRepositoryPemc();
  ApiResponse<AddNewRowMaintenancePlanModel> addNewRowMaintenancePlanList =
      ApiResponse.loading();

  setAddNewRowMaintenancePlanList(
      ApiResponse<AddNewRowMaintenancePlanModel> response) {
    addNewRowMaintenancePlanList = response;
    notifyListeners();
  }

  Future<void> fetchAddNewRowMaintenancePlanViewListApi(
      BuildContext context,
      String substationId,
      String action,
      String name1,
      String supervisorId,
      String loginId,
      String substationName,
      String year,
      String feeder,
      String contractorCompany) async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    setAddNewRowMaintenancePlanList(ApiResponse.loading());
    _myRepo
        .addNewRowMaintenancePlanGetApi(
            substationId,
            action,
            supervisorId,
            loginId,
            substationName,
            year,
            feeder,
            contractorCompany,
            data.token!)
        .then((value) async {
      setAddNewRowMaintenancePlanList(ApiResponse.completed(value));
      if (kDebugMode) {
        print('objectResponseFromAPI');
        print(value.toString());
      }
      return value;
    }).onError((error, StackTrace) {
      setAddNewRowMaintenancePlanList(ApiResponse.error(error.toString()));
      if (kDebugMode) {
        CustomToastSnackBarProgressDialog.flushBarErrorMessage(
            error.toString(), context);
        print(error.toString());
      }
      return AddNewRowMaintenancePlanModel();
    });
  }

  // ***************************************************************************************************
  // for submitting data
  ApiResponse<AddNewRowMaintenancePlanModel>
      addNewRowMaintenancePlanSubmitData = ApiResponse.loading();

  setAddNewRowMaintenancePlanSubmitList(
      ApiResponse<AddNewRowMaintenancePlanModel> response) {
    addNewRowMaintenancePlanSubmitData = response;
    notifyListeners();
  }

  Future<void> fetchAddNewRowMaintenancePlanSubmitListApi(
      BuildContext context, Map mappedData) async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    setAddNewRowMaintenancePlanSubmitList(ApiResponse.loading());
    _myRepo
        .addNewRowMaintenancePlanSubmitApi(mappedData, data.token!)
        .then((value) async {
      setAddNewRowMaintenancePlanSubmitList(ApiResponse.completed(value));
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
      setAddNewRowMaintenancePlanSubmitList(
          ApiResponse.error(error.toString()));
      if (kDebugMode) {
        CustomToastSnackBarProgressDialog.flushBarErrorMessage(
            error.toString(), context);
        print(error.toString());
      }
      return AddNewRowMaintenancePlanModel();
    });
  }

//*****************************tabular data********************************************* */
  ApiResponse<AddNewRowMaintenancePlanTabularDataModel>
      addNewRowMaintenancePlanGetTabularData = ApiResponse.loading();

  setAddNewRowMaintenancePlanGetTabularList(
      ApiResponse<AddNewRowMaintenancePlanTabularDataModel> response) {
    addNewRowMaintenancePlanGetTabularData = response;
    notifyListeners();
  }

  Future<void> fetchAddNewRowMaintenancePlanTabularListApi(
      BuildContext context, String year) async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    setAddNewRowMaintenancePlanGetTabularList(ApiResponse.loading());
    _myRepo
        .addNewRowMaintenancePlanTabularDataApi(data.token!, year)
        .then((value) async {
      setAddNewRowMaintenancePlanGetTabularList(ApiResponse.completed(value));
      if (kDebugMode) {
        print(value.toString());
      }
      return value;
      // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
    }).onError((error, StackTrace) {
      setAddNewRowMaintenancePlanGetTabularList(
          ApiResponse.error(error.toString()));
      if (kDebugMode) {
        CustomToastSnackBarProgressDialog.flushBarErrorMessage(
            error.toString(), context);
        print(error.toString());
      }
      return AddNewRowMaintenancePlanTabularDataModel();
    });
  }

  Future<void> fetchAddNewRowMaintenancePlanSprayTabularListApi(
      BuildContext context, String year) async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    setAddNewRowMaintenancePlanGetTabularList(ApiResponse.loading());
    _myRepo
        .addNewRowMaintenancePlanSprayTabularDataApi(data.token!, year)
        .then((value) async {
      setAddNewRowMaintenancePlanGetTabularList(ApiResponse.completed(value));
      if (kDebugMode) {
        print(value.toString());
      }
      return value;
      // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
    }).onError((error, StackTrace) {
      setAddNewRowMaintenancePlanGetTabularList(
          ApiResponse.error(error.toString()));
      if (kDebugMode) {
        CustomToastSnackBarProgressDialog.flushBarErrorMessage(
            error.toString(), context);
        print(error.toString());
      }
      return AddNewRowMaintenancePlanTabularDataModel();
    });
  }
}
