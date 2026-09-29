import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:CIVM/data/response/api_Response.dart';
import 'package:CIVM/models/row_cost_analysis_by_Season_model.dart';
import 'package:CIVM/models/user_model.dart';
import 'package:CIVM/repository/auth_repository.dart';
import 'package:CIVM/utils/custom_toast_snackbar_progressdialog.dart';
import 'package:CIVM/utils/user_pref.dart';

class RowCostAnalysisBySeasonViewModel with ChangeNotifier {
  final _myRepo = AuthRepository();
  ApiResponse<RowCostAnalysisBySeasonModel> rowCostAnalysisBySeasonList =
      ApiResponse.loading();

  setRowCostAnalysisBySeasonList(
      ApiResponse<RowCostAnalysisBySeasonModel> response) {
    rowCostAnalysisBySeasonList = response;
    notifyListeners();
  }

  Future<void> fetchRowCostAnalysisBySeasonListApi(
    BuildContext context,
    String substation,
    String feeder,
    String nextMaintDueYr,
    String season,
    String type,
    String nextMaintDueMonth,
  ) async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    setRowCostAnalysisBySeasonList(ApiResponse.loading());
    _myRepo
        .rowCostAnalysisBySeasonApi(substation, feeder, nextMaintDueYr, season,
            type, nextMaintDueMonth, data.token!)
        .then((value) async {
      setRowCostAnalysisBySeasonList(ApiResponse.completed(value));
      if (kDebugMode) {
        print(value.toString());
      }
      return value;
    }).onError((error, StackTrace) {
      setRowCostAnalysisBySeasonList(ApiResponse.error(error.toString()));
      if (kDebugMode) {
        CustomToastSnackBarProgressDialog.flushBarErrorMessage(
            error.toString(), context);
        print(error.toString());
      }
      return RowCostAnalysisBySeasonModel();
    });
  }
}
