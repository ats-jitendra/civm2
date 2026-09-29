import 'package:CIVM/models/invoice_form_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:CIVM/data/response/api_Response.dart';
import 'package:CIVM/models/user_model.dart';
import 'package:CIVM/repository/auth_repository.dart';
import 'package:CIVM/utils/custom_toast_snackbar_progressdialog.dart';
import 'package:CIVM/utils/user_pref.dart';

class InvoiceFormViewModel with ChangeNotifier {
  final _myRepo = AuthRepository();

  // ***************************************************************************************************
  // for submitting data
  ApiResponse<InvoiceFormModel> ivoiceFormSubmitData = ApiResponse.loading();

  setInvoiceFormSubmitList(ApiResponse<InvoiceFormModel> response) {
    ivoiceFormSubmitData = response;
    notifyListeners(); 
  }

  Future<void> fetchInvoiceFormSubmitListApi(
      BuildContext context, Map mappedData) async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    setInvoiceFormSubmitList(ApiResponse.loading());
    _myRepo.invoiceFormSubmitApi(mappedData, data.token!).then((value) async {
      setInvoiceFormSubmitList(ApiResponse.completed(value));
      CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
          'Successfully Submitted', context);
      // Navigator.of(context).push(MaterialPageRoute(
      //     builder: (BuildContext context) =>
      //         const InvoiceFormTable()));
      if (kDebugMode) {
        print(value.toString());
      }
      return value;
    }).onError((error, StackTrace) {
      setInvoiceFormSubmitList(ApiResponse.error(error.toString()));
      if (kDebugMode) {
        CustomToastSnackBarProgressDialog.flushBarErrorMessage(
            error.toString(), context);
        print(error.toString());
      }
      return InvoiceFormModel();
    });
  }
}
