import 'package:CIVM/models/invoice_create_invoice_model.dart';
import 'package:CIVM/models/invoice_get_token_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:CIVM/data/response/api_Response.dart';
import 'package:CIVM/models/user_model.dart';
import 'package:CIVM/repository/auth_repository.dart';
import 'package:CIVM/utils/custom_toast_snackbar_progressdialog.dart';
import 'package:CIVM/utils/user_pref.dart';

class InvoiceCreateInvoiceViewModel with ChangeNotifier {
  final _myRepo = AuthRepository();

  // ***************************************************************************************************
  // for submitting data
  ApiResponse<InvoiceCreateInvoiceModel> ivoiceCreateInvoiceSubmitData =
      ApiResponse.loading();

  setInvoiceCreateInvoiceSubmitList(
      ApiResponse<InvoiceCreateInvoiceModel> response) {
    ivoiceCreateInvoiceSubmitData = response;
    notifyListeners();
  }

  Future<void> fetchInvoiceCreateInvoiceSubmitListApi(
      BuildContext context, List mappedData) async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    setInvoiceCreateInvoiceSubmitList(ApiResponse.loading());
    _myRepo
        .invoiceCreateInvoiceSubmitApi(mappedData, data.token!)
        .then((value) async {
      setInvoiceCreateInvoiceSubmitList(ApiResponse.completed(value));
      CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
          'Successfully Submitted', context);
      // Navigator.of(context).push(MaterialPageRoute(
      //     builder: (BuildContext context) =>
      //         const InvoiceCreateInvoiceTable()));
      if (kDebugMode) {
        print(value.toString());
      }
      return value;
    }).onError((error, StackTrace) {
      setInvoiceCreateInvoiceSubmitList(ApiResponse.error(error.toString()));
      if (kDebugMode) {
        CustomToastSnackBarProgressDialog.flushBarErrorMessage(
            error.toString(), context);
        print(error.toString());
      }
      return InvoiceCreateInvoiceModel();
    });
  }

  //***********************get data******************/

  ApiResponse<InvoiceGetTokenModel> ivoiceGetData = ApiResponse.loading();

  setInvoiceGetList(ApiResponse<InvoiceGetTokenModel> response) {
    ivoiceGetData = response;
    notifyListeners();
  }

  Future<void> fetchInvoiceGetDataApi(BuildContext context) async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    setInvoiceGetList(ApiResponse.loading());
    _myRepo.invoiceGetDataApi(data.token!).then((value) async {
      setInvoiceGetList(ApiResponse.completed(value));
      if (kDebugMode) {
        print(value.toString());
      }
      return value;
      // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
    }).onError((error, StackTrace) {
      setInvoiceGetList(ApiResponse.error(error.toString()));
      if (kDebugMode) {
        CustomToastSnackBarProgressDialog.flushBarErrorMessage(
            error.toString(), context);
        print(error.toString());
      }
      return InvoiceGetTokenModel();
    });
  }
}
