import 'package:CIVM/models/vegetation_growth_rate_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:CIVM/data/response/api_Response.dart';
import 'package:CIVM/models/user_model.dart';
import 'package:CIVM/repository/auth_repository.dart';
import 'package:CIVM/utils/custom_toast_snackbar_progressdialog.dart';
import 'package:CIVM/utils/user_pref.dart';

class VegetationGrowthRateViewModel with ChangeNotifier {
  final _myRepo = AuthRepository();
  ApiResponse<VegetationGrowthRateModel> vegetationGrowthRateList =
      ApiResponse.loading();

  setvegetationGrowthRateList(ApiResponse<VegetationGrowthRateModel> response) {
    vegetationGrowthRateList = response;
    notifyListeners();
  }

  Future<void> fetchVegetationGrowthRateListApi(
    BuildContext context,
    String year,
    String growthRate,
    String treeType,
    String zipCode,
    String season,
  ) async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    setvegetationGrowthRateList(ApiResponse.loading());
    _myRepo
        .vegetationGrowthRateApi(
            year, growthRate, treeType, zipCode, season, data.token!)
        .then((value) async {
      setvegetationGrowthRateList(ApiResponse.completed(value));
      if (kDebugMode) {
        print(value.toString());
      }
      return value;
    }).onError((error, StackTrace) {
      setvegetationGrowthRateList(ApiResponse.error(error.toString()));
      if (kDebugMode) {
        CustomToastSnackBarProgressDialog.flushBarErrorMessage(
            error.toString(), context);
        print(error.toString());
      }
      return VegetationGrowthRateModel();
    });
  }
}
