import 'package:CIVM/models/create_invoice_contractor_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:CIVM/data/response/api_Response.dart';
import 'package:CIVM/models/user_model.dart';
import 'package:CIVM/repository/auth_repository.dart';
import 'package:CIVM/utils/custom_toast_snackbar_progressdialog.dart';
import 'package:CIVM/utils/user_pref.dart';

class CreateInvoiceContractorViewModel with ChangeNotifier {
  final _myRepo = AuthRepository();

//*****************************get data********************************************* */
  ApiResponse<CreateInvoiceContractorModel>
      createInvoiceContractorViewModelGetTabularData =
      ApiResponse.loading();

  setCreateInvoiceContractorViewModelGetTabularList(
      ApiResponse<CreateInvoiceContractorModel> response) {
    createInvoiceContractorViewModelGetTabularData = response;
    notifyListeners();
  }

  Future<void> fetchCreateInvoiceContractorViewModelTabularListApi(
      BuildContext context,
      String substationId,
      String feeder) async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    setCreateInvoiceContractorViewModelGetTabularList(
        ApiResponse.loading());
    _myRepo
        .createInvoiceContractorTabularDataApi(
            data.token!, substationId, feeder)
        .then((value) async {
      setCreateInvoiceContractorViewModelGetTabularList(
          ApiResponse.completed(value));
      if (kDebugMode) {
        print(value.toString());
      }
      return value;
      // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
    }).onError((error, StackTrace) {
      setCreateInvoiceContractorViewModelGetTabularList(
          ApiResponse.error(error.toString()));
      if (kDebugMode) {
        CustomToastSnackBarProgressDialog.flushBarErrorMessage(
            error.toString(), context);
        print(error.toString());
      }
      return CreateInvoiceContractorModel();
    });
  }
}
