// show error dialog
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DialogHelper {
  static void showErrorDialog(
      {String title = 'Error', String description = 'Somthing went wrong!'}) {
    Get.dialog(Dialog(
        child: Column(
      children: [
        Text(
          title,
          style: Get.textTheme.headlineMedium,
        ),
        Text(
          description,
          style: Get.textTheme.headlineMedium,
          //  style: Get.textTheme.headline4,
        ),
        ElevatedButton(onPressed: () {}, child: Text('Okay'))
      ],
    )));
  }
// show toast
// show snack bar
// show loading
// hide loading

}
