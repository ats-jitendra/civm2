import 'package:CIVM/piedmont/models/contractor_change_order_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:CIVM/piedmont/data/response/api_Response.dart';
import 'package:CIVM/piedmont/models/user_model.dart';
import 'package:CIVM/piedmont/repository/auth_repository.dart';
import 'package:CIVM/piedmont/utils/custom_toast_snackbar_progressdialog.dart';
import 'package:CIVM/piedmont/utils/user_pref.dart';
import 'package:CIVM/utils/user_pref.dart';
import 'package:CIVM/models/user_model.dart';
class ContractorChangeOrderViewModel with ChangeNotifier {
  final _myRepo = AuthRepositoryPemc();
  ApiResponse<ContractorChangeOrderModel> contractorChangeOrderCountList =
      ApiResponse.loading();

  setContractorChangeOrdercountList(
      ApiResponse<ContractorChangeOrderModel> response) {
    contractorChangeOrderCountList = response;
    notifyListeners();
  }

  Future<void> fetchContractorChangeOrdercountApi(
    BuildContext context,
  ) async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    setContractorChangeOrdercountList(ApiResponse.loading());
    _myRepo.contractorChangeOrderApi(data.token!).then((value) async {
      setContractorChangeOrdercountList(ApiResponse.completed(value));
      if (kDebugMode) {
        print(value.toString());
      }
      return value;
    }).onError((error, StackTrace) {
      setContractorChangeOrdercountList(ApiResponse.error(error.toString()));
      if (kDebugMode) {
        CustomToastSnackBarProgressDialog.flushBarErrorMessage(
            error.toString(), context);
        print(error.toString());
      }
      return ContractorChangeOrderModel();
    });
  }
}
