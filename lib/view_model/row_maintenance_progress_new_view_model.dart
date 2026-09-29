import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:CIVM/data/response/api_Response.dart';
import 'package:CIVM/models/row_maintenance_progress_new_model.dart';
import 'package:CIVM/models/user_model.dart';
import 'package:CIVM/repository/auth_repository.dart';
import 'package:CIVM/utils/custom_toast_snackbar_progressdialog.dart';
import 'package:CIVM/utils/user_pref.dart';

class RowMaintenanceProgressNewViewModel with ChangeNotifier {
  final _myRepo = AuthRepository();
  ApiResponse<RowMaintenanceProgressNewModel> rowMaintenanceProgressNewList =
      ApiResponse.loading();

  setrowMaintenanceProgressNewList(
      ApiResponse<RowMaintenanceProgressNewModel> response) {
    rowMaintenanceProgressNewList = response;
    notifyListeners();
  }

  Future<void> fetchRowMaintenanceProgressNewListApi(
      BuildContext context,
      String substation,
      String feeder,
      String cycle,
      String month,
      String year) async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    setrowMaintenanceProgressNewList(ApiResponse.loading());
    _myRepo
        .rowMaintenanceProgressNewApi(
            data.token!, substation, feeder, cycle, month, year)
        .then((value) async {
      setrowMaintenanceProgressNewList(ApiResponse.completed(value));
      if (kDebugMode) {
        print(value.toString());
      }
      return value;
    }).onError((error, StackTrace) {
      setrowMaintenanceProgressNewList(ApiResponse.error(error.toString()));
      if (kDebugMode) {
        CustomToastSnackBarProgressDialog.flushBarErrorMessage(
            error.toString(), context);
        print(error.toString());
      }
      return RowMaintenanceProgressNewModel();
    });
  }
}
