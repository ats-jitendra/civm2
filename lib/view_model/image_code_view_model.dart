import 'package:CIVM/models/image_model.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:CIVM/data/response/api_Response.dart';
import 'package:CIVM/models/user_model.dart';
import 'package:CIVM/repository/auth_repository.dart';
import 'package:CIVM/utils/custom_toast_snackbar_progressdialog.dart';
import 'package:CIVM/utils/user_pref.dart';

class ImageViewViewModel with ChangeNotifier {
  final _myRepo = AuthRepository();

//*****************************Image********************************************* */
  ApiResponse<ImageModel> imageData = ApiResponse.loading();

  setImageList(ApiResponse<ImageModel> response) {
    imageData = response;
    notifyListeners();
  }

  // Future<void> fetchImageApi(BuildContext context, String tokenNo) async {
  //   final userPreferences = Provider.of<UserPref>(context, listen: false);
  //   UserModel data = await userPreferences.getUser();
  //   setImageList(ApiResponse.loading());
  //   _myRepo.imageApi(data.token!, tokenNo).then((value) async {
  //     setImageList(ApiResponse.completed(value));
  //     if (kDebugMode) {
  //       print(value.toString());
  //     }
  //     return value;
  //     // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
  //   }).onError((error, StackTrace) {
  //     setImageList(ApiResponse.error(error.toString()));
  //     if (kDebugMode) {
  //       CustomToastSnackBarProgressDialog.flushBarErrorMessage(
  //           error.toString(), context);
  //       print(error.toString());
  //     }
  //     return ImageModel();
  //   });
  // }
Future<void> fetchImageApi(BuildContext context, String tokenNo) async {
  final userPreferences = Provider.of<UserPref>(context, listen: false);

  try {
    UserModel data = await userPreferences.getUser();

    setImageList(ApiResponse.loading());

    final value = await _myRepo.imageApi(data.token!, tokenNo);

    setImageList(ApiResponse.completed(value));

    if (kDebugMode) {
      print("API SUCCESS: ${value.toString()}");
    }
  } catch (error) {
    setImageList(ApiResponse.error(error.toString()));

    if (kDebugMode) {
      print("API ERROR: $error");
    }

    CustomToastSnackBarProgressDialog.flushBarErrorMessage(
      error.toString(),
      context,
    );
  }
}
}
