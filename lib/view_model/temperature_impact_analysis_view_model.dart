import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:CIVM/data/response/api_Response.dart';
import 'package:CIVM/models/temperature_impact_analysis_model.dart';
import 'package:CIVM/models/user_model.dart';
import 'package:CIVM/repository/auth_repository.dart';
import 'package:CIVM/utils/custom_toast_snackbar_progressdialog.dart';
import 'package:CIVM/utils/user_pref.dart';

class TemperatureImpactAnalysisViewModel with ChangeNotifier {
  final _myRepo = AuthRepository();
  ApiResponse<TemperatureImpactAnalysisModel> temperatureImpactAnalysisList =
      ApiResponse.loading();

  setTemperatureImpactAnalysisList(
      ApiResponse<TemperatureImpactAnalysisModel> response) {
    temperatureImpactAnalysisList = response;
    notifyListeners();
  }

  Future<void> fetchTemperatureImpactAnalysisListApi(
    BuildContext context,
    String substation,
    String fdrName,
    String sDate,
    String eDate,
    String delayCause,
  ) async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    setTemperatureImpactAnalysisList(ApiResponse.loading());
    _myRepo
        .temperatureImpactAnalysisApi(
            substation, fdrName, sDate, eDate, delayCause, data.token!)
        .then((value) async {
      setTemperatureImpactAnalysisList(ApiResponse.completed(value));
      if (kDebugMode) {
        print(value.toString());
      }
      return value;
    }).onError((error, StackTrace) {
      setTemperatureImpactAnalysisList(ApiResponse.error(error.toString()));
      if (kDebugMode) {
        CustomToastSnackBarProgressDialog.flushBarErrorMessage(
            error.toString(), context);
        print(error.toString());
      }
      return TemperatureImpactAnalysisModel();
    });
  }
}
