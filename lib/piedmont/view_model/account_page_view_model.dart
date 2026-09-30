import 'package:CIVM/piedmont/models/account_page_model.dart';
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
class AccountPageViewModel with ChangeNotifier {
  final _myRepo = AuthRepositoryPemc();

//*****************************tabular data********************************************* */
  ApiResponse<AccountPageModel> accountPageGetTabularData =
      ApiResponse.loading();

  setAccountPageGetTabularList(ApiResponse<AccountPageModel> response) {
    accountPageGetTabularData = response;
    notifyListeners();
  }

  Future<void> fetchAccountPageTabularListApi(
      BuildContext context, String email) async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    setAccountPageGetTabularList(ApiResponse.loading());
    _myRepo.accountPageGetDataApi(data.token!, email).then((value) async {
      setAccountPageGetTabularList(ApiResponse.completed(value));
      if (kDebugMode) {
        print(value.toString());
      }
      return value;
      // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
    }).onError((error, StackTrace) {
      setAccountPageGetTabularList(ApiResponse.error(error.toString()));
      if (kDebugMode) {
        CustomToastSnackBarProgressDialog.flushBarErrorMessage(
            error.toString(), context);
        print(error.toString());
      }
      return AccountPageModel();
    });
  }
}
