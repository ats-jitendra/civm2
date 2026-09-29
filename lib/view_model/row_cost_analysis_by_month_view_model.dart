import 'package:CIVM/models/row_cost_analysis_by_month_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:CIVM/data/response/api_Response.dart';
import 'package:CIVM/models/user_model.dart';
import 'package:CIVM/repository/auth_repository.dart';
import 'package:CIVM/utils/custom_toast_snackbar_progressdialog.dart';
import 'package:CIVM/utils/user_pref.dart';

class RowCostAnalysisByMonthViewModel with ChangeNotifier {
  final _myRepo = AuthRepository();
  ApiResponse<RowCostAnalysisByMonthModel> rowCostAnalysisByMonthList =
      ApiResponse.loading();

  setRowCostAnalysisByMonthList(
      ApiResponse<RowCostAnalysisByMonthModel> response) {
    rowCostAnalysisByMonthList = response;
    notifyListeners();
  }

  Future<void> fetchRowCostAnalysisByMonthListApi(
    BuildContext context,
    String substation,
    String feeder,
    String nextMaintDueYr,
    String nextMaintDueMonth
  ) async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    setRowCostAnalysisByMonthList(ApiResponse.loading());
    _myRepo
        .rowCostAnalysisByMonthApi(
            substation, feeder, nextMaintDueYr, nextMaintDueMonth, data.token!)
        .then((value) async {
      setRowCostAnalysisByMonthList(ApiResponse.completed(value));
      if (kDebugMode) {
        print(value.toString());
      }
      return value;
    }).onError((error, StackTrace) {
      setRowCostAnalysisByMonthList(ApiResponse.error(error.toString()));
      if (kDebugMode) {
        CustomToastSnackBarProgressDialog.flushBarErrorMessage(
            error.toString(), context);
        print(error.toString());
      }
      return RowCostAnalysisByMonthModel();
    });
  }
}
