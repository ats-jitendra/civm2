import 'package:CIVM/piedmont/models/invoice_list_model.dart';
import 'package:CIVM/piedmont/models/invoice_model.dart';
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
class InvoiceListViewModel with ChangeNotifier {
  final _myRepo = AuthRepositoryPemc();

//*****************************tabular data********************************************* */
  ApiResponse<InvoiceListModel> invoiceListGetTabularData =
      ApiResponse.loading();

  setInvoiceListGetTabularList(ApiResponse<InvoiceListModel> response) {
    invoiceListGetTabularData = response;
    notifyListeners();
  }

  Future<void> fetchInvoiceListTabularListApi(BuildContext context) async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    setInvoiceListGetTabularList(ApiResponse.loading());
    _myRepo.invoiceListTabularDataApi(data.token!).then((value) async {
      setInvoiceListGetTabularList(ApiResponse.completed(value));
      if (kDebugMode) {
        print(value.toString());
      }
      return value;
      // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
    }).onError((error, StackTrace) {
      setInvoiceListGetTabularList(ApiResponse.error(error.toString()));
      if (kDebugMode) {
        CustomToastSnackBarProgressDialog.flushBarErrorMessage(
            error.toString(), context);
        print(error.toString());
      }
      return InvoiceListModel();
    });
  }

  //*****************************tabular data********************************************* */
  ApiResponse<InvoiceModel> invoiceData = ApiResponse.loading();

  setInvoiceList(ApiResponse<InvoiceModel> response) {
    invoiceData = response;
    notifyListeners();
  }

  Future<void> fetchInvoiceApi(BuildContext context, String tokenNo) async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    setInvoiceList(ApiResponse.loading());
    _myRepo.invoiceDataApi(data.token!, tokenNo).then((value) async {
      setInvoiceList(ApiResponse.completed(value));
      if (kDebugMode) {
        print(value.toString());
      }
      return value;
      // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
    }).onError((error, StackTrace) {
      setInvoiceList(ApiResponse.error(error.toString()));
      if (kDebugMode) {
        CustomToastSnackBarProgressDialog.flushBarErrorMessage(
            error.toString(), context);
        print(error.toString());
      }
      return InvoiceModel();
    });
  }
}
