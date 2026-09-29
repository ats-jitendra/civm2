// ignore: file_names
import 'dart:convert';
import 'dart:io';
import 'package:CIVM/data/app_exception.dart';
import 'package:CIVM/data/network/baseApiServices.dart';
import 'package:CIVM/utils/custom_toast_snackbar_progressdialog.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart' hide Response;
import '../../screens/login_page.dart';

class NetworkApiService extends BaseApiServices {
  @override
  Future getGetApiResponse(String url, String token) async {
    print(url);
    dynamic responseJson;
    try {
      final response = await http.get(Uri.parse(url), headers: {
        'Authorization': 'Bearer $token',
      }).timeout(const Duration(seconds: 60));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection...');
    }
    return responseJson;
  }

  @override
  Future getPostApiResponse(String url, dynamic data) async {
    print(url);
    dynamic responseJson;
    try {
      Response response = await post(Uri.parse(url),
          body: jsonEncode(data),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json"
          }).timeout(const Duration(seconds: 60));
      responseJson = returnResponse(response);
      print(response.body);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

@override
Future<dynamic> getPostApiResponseLogin(String url, dynamic data) async {
  try {
    final response = await http.post(Uri.parse(url),
        body: jsonEncode(data),
        headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else if  (response.statusCode == 401) {
      print('errorrrrrrrrrrrrrrrrrrrrrr');
      // return error body instead of throwing raw string
      var errorJson = jsonDecode(response.body);
      print('Something went wrong::: ${response.body}');
       if (response.body.contains("Password has expired. Please reset your password")) {
        // ToastUtil.showError("Password has expired. Please reset your password");
        // return;
      }else if (response.body.contains("Account locked due to multiple failed attempts.")) {
        // ToastUtil.showError("Account locked due to multiple failed attempts.");
        // return;
      }
      throw Exception(errorJson['message'] ?? 'Something went wrong');
    }else {
      print('errorrrrrrrrr user not found');
      print('Something went wrong::: ${response.body}');
      throw Exception('Server Error');
    }
  } catch (e) {
    throw Exception(e.toString());
  }
}

// *********************newly added************************//
  @override
  Future getPostApiResponse1(String url, dynamic data, String token) async {
    print(url);
    dynamic responseJson;
    try {
      Response response =
          await post(Uri.parse(url), body: jsonEncode(data), headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
        "Accept": "application/json"
      }).timeout(const Duration(seconds: 60));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  @override
  Future getPutApiResponse1(String url, dynamic data, String token) async {
    print(url);
    dynamic responseJson;
    try {
      Response response =
          await put(Uri.parse(url), body: jsonEncode(data), headers: {
        'Authorization': 'Bearer $token',
        "Content-Type": "application/json",
        "Accept": "application/json"
      }).timeout(const Duration(seconds: 60));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  @override
  Future getPutApiResponse2(String url, dynamic data) async {
    print(url);
    dynamic responseJson;
    try {
      Response response = await put(Uri.parse(url),
          body: jsonEncode(data),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json"
          }).timeout(const Duration(seconds: 60));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  @override
  Future getPutApiResponse(String url, String token) async {
    print(url);
    dynamic responseJson;
    try {
      final response = await http.put(Uri.parse(url), headers: {
        'Authorization': 'Bearer $token',
      }).timeout(const Duration(seconds: 60));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  // *****************new added for form data*****************************//

  @override
  Future getPutApiResponseFormData(
      String url, dynamic formData, String token) async {
    print(url);
    dynamic responseJson;
    try {
      var request = http.MultipartRequest('PUT', Uri.parse(url))
        ..headers.addAll({
          'Authorization': 'Bearer $token',
          "Accept": "application/json",
        });
      request.fields['key1'] = 'value1';
      request.fields['key2'] = 'value2';
      request.files.add(
        http.MultipartFile.fromBytes(
          'fileKey',
          utf8.encode(formData.toString()),
          filename: 'filename.txt',
        ),
      );

      var response = await http.Response.fromStream(await request.send());
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  /////////////////////////////////////////////////

// bhdbchwsbdnjwendjwefnjwenf
  @override
  Future getPostApiResponse2(String url, String token) async {
    print(url);
    dynamic responseJson;
    try {
      final response = await http.post(Uri.parse(url), headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      }).timeout(const Duration(seconds: 60));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  @override
  Future getDeleteApiResponse(String url, String token) async {
    print(url);
    dynamic responseJson;
    try {
      final response = await http.delete(Uri.parse(url), headers: {
        'Authorization': 'Bearer $token',
      }).timeout(const Duration(seconds: 60));
      // responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    // return responseJson;
  }

  dynamic returnResponse(http.Response response) async {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 500:
        throw InternalServerException(response.body.toString());
      case 404:
        throw UnauthoriseException(response.body.toString());
      case 401:
        final SharedPreferences pref = await SharedPreferences.getInstance();
        pref.clear();
        return Get.offAll(const LoginPage());
      default:
        throw FetchDataException(
            'Error accured while communicating with server with status code ${response.statusCode}');
    }
  }
}

