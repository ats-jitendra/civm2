import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:CIVM/data/response/api_Response.dart';
import 'package:CIVM/models/user_model.dart';
import 'package:CIVM/models/vegetation_outage_by_type_model.dart';
import 'package:CIVM/repository/auth_repository.dart';
import 'package:CIVM/utils/custom_toast_snackbar_progressdialog.dart';
import 'package:CIVM/utils/user_pref.dart';

class VegetationOutageByTypeViewModel with ChangeNotifier {
  final _myRepo = AuthRepository();
  ApiResponse<VegetationOutageByTypeModel> vegetationOutageByTypeList =
      ApiResponse.loading();

  setvegetationOutageByTypeList(ApiResponse<VegetationOutageByTypeModel> response) {
    vegetationOutageByTypeList = response;
    notifyListeners();
  }

  Future<void> fetchVegetationOutageByTypeListApi(
    BuildContext context,
    String delayCause,
    String substation,
    String fdrName,
    String outageCause
  ) async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    setvegetationOutageByTypeList(ApiResponse.loading());
    _myRepo
        .vegetationOutageByTypeApi(
           delayCause, substation,fdrName,outageCause, data.token!)
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
