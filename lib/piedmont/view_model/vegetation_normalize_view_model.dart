import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:CIVM/piedmont/data/response/api_Response.dart';
import 'package:CIVM/piedmont/models/user_model.dart';
import 'package:CIVM/piedmont/models/vegetation_normalize_model.dart';
import 'package:CIVM/piedmont/repository/auth_repository.dart';
import 'package:CIVM/piedmont/utils/custom_toast_snackbar_progressdialog.dart';
import 'package:CIVM/piedmont/utils/user_pref.dart';
import 'package:CIVM/utils/user_pref.dart';
import 'package:CIVM/models/user_model.dart';
class VegetationNormalizeViewModel with ChangeNotifier {
  final _myRepo = AuthRepositoryPemc();
  ApiResponse<VegetationNormalizeModel> vegetationNormalizeList =
      ApiResponse.loading();

  setvegetationNormalizeList(ApiResponse<VegetationNormalizeModel> response) {
    vegetationNormalizeList = response;
    notifyListeners();
  }

  Future<void> fetchVegetationNormalizeListApi(
      BuildContext context,
      String substation,
      String fdrName,
      String outageCause,
      String sDate,
      String eDate,
      String delayCause) async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    setvegetationNormalizeList(ApiResponse.loading());
    _myRepo
        .vegetationNormalizeApi(substation, fdrName, outageCause, sDate, eDate,
            delayCause, data.token!)
        .then((value) async {
      setvegetationNormalizeList(ApiResponse.completed(value));
      if (kDebugMode) {
        print(value.toString());
      }
      return value;
    }).onError((error, StackTrace) {
      setvegetationNormalizeList(ApiResponse.error(error.toString()));
      if (kDebugMode) {
        CustomToastSnackBarProgressDialog.flushBarErrorMessage(
            error.toString(), context);
        print(error.toString());
      }
      return VegetationNormalizeModel();
    });
  }
}
