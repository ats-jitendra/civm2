import 'package:CIVM/models/weather_impact_analysis_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:CIVM/data/response/api_Response.dart';
import 'package:CIVM/models/user_model.dart';
import 'package:CIVM/repository/auth_repository.dart';
import 'package:CIVM/utils/custom_toast_snackbar_progressdialog.dart';
import 'package:CIVM/utils/user_pref.dart';

class WeatherImpactAnalysisViewModel with ChangeNotifier {
  final _myRepo = AuthRepository();
  ApiResponse<WeatherImpactAnalysisModel> weatherImpactAnalysisList =
      ApiResponse.loading();

  setWeatherImpactAnalysisList(ApiResponse<WeatherImpactAnalysisModel> response) {
    weatherImpactAnalysisList = response;
    notifyListeners();
  }

  Future<void> fetchWeatherImpactAnalysisListApi(
    BuildContext context,
    String substation,
      String fdrName,
      String sDate,
      String eDate,
      String delayCause,
  ) async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    setWeatherImpactAnalysisList(ApiResponse.loading());
    _myRepo
        .weatherImpactAnalysisApi( substation, fdrName, sDate,
            eDate, delayCause, data.token!)
        .then((value) async {
      setWeatherImpactAnalysisList(ApiResponse.completed(value));
      if (kDebugMode) {
        print(value.toString());
      }
      return value;
    }).onError((error, StackTrace) {
      setWeatherImpactAnalysisList(ApiResponse.error(error.toString()));
      if (kDebugMode) {
        CustomToastSnackBarProgressDialog.flushBarErrorMessage(
            error.toString(), context);
        print(error.toString());
      }
      return WeatherImpactAnalysisModel();
    });
  }
}
