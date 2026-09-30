import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:CIVM/piedmont/data/response/api_Response.dart';
import 'package:CIVM/piedmont/models/lcp_model.dart';
import 'package:CIVM/piedmont/models/user_model.dart';
import 'package:CIVM/piedmont/repository/auth_repository.dart';
import 'package:CIVM/piedmont/utils/custom_toast_snackbar_progressdialog.dart';
import 'package:CIVM/piedmont/utils/user_pref.dart';
import 'package:CIVM/utils/user_pref.dart';
import 'package:CIVM/models/user_model.dart';
class LCPViewModel with ChangeNotifier {
  final _myRepo = AuthRepositoryPemc();
  ApiResponse<LCPModel> lcpCountList = ApiResponse.loading();

  setLCPcountList(ApiResponse<LCPModel> response) {
    lcpCountList = response;
    notifyListeners();
  }

  Future<void> fetchLCPcountApi(
      BuildContext context,
      String contractorCompanyName,
      String status,
      String budgetType,
      String maintType,
      String id,
      String panel) async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    setLCPcountList(ApiResponse.loading());
    _myRepo
        .lcpApi(contractorCompanyName, status, budgetType, maintType, id, panel,
            data.token!)
        .then((value) async {
      setLCPcountList(ApiResponse.completed(value));
      if (kDebugMode) {
        print(value.toString());
      }
      return value;
    }).onError((error, StackTrace) {
      setLCPcountList(ApiResponse.error(error.toString()));
      if (kDebugMode) {
        CustomToastSnackBarProgressDialog.flushBarErrorMessage(
            error.toString(), context);
        print(error.toString());
      }
      return LCPModel();
    });
  }
}
