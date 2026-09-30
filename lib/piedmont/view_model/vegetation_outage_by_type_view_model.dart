import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:CIVM/piedmont/data/response/api_Response.dart';
import 'package:CIVM/piedmont/models/user_model.dart';
import 'package:CIVM/piedmont/models/vegetation_outage_by_type_model.dart';
import 'package:CIVM/piedmont/repository/auth_repository.dart';
import 'package:CIVM/piedmont/utils/custom_toast_snackbar_progressdialog.dart';
import 'package:CIVM/piedmont/utils/user_pref.dart';
import 'package:CIVM/utils/user_pref.dart';
import 'package:CIVM/models/user_model.dart';
class VegetationOutageByTypeViewModel with ChangeNotifier {
  final _myRepo = AuthRepositoryPemc();
  ApiResponse<VegetationOutageByTypeModel> vegetationOutageByTypeList =
      ApiResponse.loading();

  setvegetationOutageByTypeList(
      ApiResponse<VegetationOutageByTypeModel> response) {
    vegetationOutageByTypeList = response;
    notifyListeners();
  }

  Future<void> fetchVegetationOutageByTypeListApi(
      BuildContext context,
      String delayCause,
      String substation,
      String fdrName,
      String outageCause) async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    setvegetationOutageByTypeList(ApiResponse.loading());
    _myRepo
        .vegetationOutageByTypeApi(
            delayCause, substation, fdrName, outageCause, data.token!)
        .then((value) async {
      setvegetationOutageByTypeList(ApiResponse.completed(value));
      if (kDebugMode) {
        print(value.toString());
      }
      return value;
    }).onError((error, StackTrace) {
      setvegetationOutageByTypeList(ApiResponse.error(error.toString()));
      if (kDebugMode) {
        CustomToastSnackBarProgressDialog.flushBarErrorMessage(
            error.toString(), context);
        print(error.toString());
      }
      return VegetationOutageByTypeModel();
    });
  }
}
