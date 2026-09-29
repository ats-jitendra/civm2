import 'dart:convert';
import 'package:CIVM/models/primary_secondary_mile_model.dart';
import 'package:CIVM/models/work_progress_model.dart';
import 'package:CIVM/resources/app_url.dart';
import 'package:http/http.dart' as http;
import 'package:CIVM/models/user_model.dart';
import 'package:CIVM/utils/user_pref.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WorkProgressApi {

  static Future<List<WorkProgressModel>> getWorkProgress(int jobNo,BuildContext context) async {
      final userPreferences = Provider.of<UserPref>(context, listen: false);
      UserModel data = await userPreferences.getUser();
    final response = await http.get(
       Uri.parse(
          AppUrl.workProgressByMaintType,
        ).replace(queryParameters: {"jobNo": jobNo.toString()}),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${data.token!}"
      },
    );

    if (response.statusCode == 200) {

      final jsonData = jsonDecode(response.body);

      List list = jsonData["data"];

      return list.map((e) => WorkProgressModel.fromJson(e)).toList();

    } else {
      throw Exception("Unable to load data");
    }
  }

   static Future<PrimarySecondaryMileModel> getPrimarySecondaryMileDetails(
    int tokenNo, BuildContext context) async {

  final userPreferences = Provider.of<UserPref>(context, listen: false);
  UserModel user = await userPreferences.getUser();

  final response = await http.get(
    Uri.parse(
      AppUrl.getPrimarySecondaryMileDetails,
    ).replace(queryParameters: {
      "tokenNo": tokenNo.toString(),
    }),
    headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${user.token!}",
    },
  );

  if (response.statusCode == 200) {
    print(response.body);

    return PrimarySecondaryMileModel.fromJson(
      jsonDecode(response.body),
    );
  } else {
    throw Exception("Unable to load data");
  }
}
  
  static Widget statusBox(String title, String value, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 5),
    decoration: BoxDecoration(
      color: color.withValues(alpha: .08),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 12,
          ),
        ),
      ],
    ),
  );
}
  }