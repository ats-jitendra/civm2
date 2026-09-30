import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:CIVM/piedmont/services/app_exceptions.dart';
import 'package:http/http.dart' as http;

class BaseClient {
  // ignore: constant_identifier_names
  static const int TIME_OUT_DURATION = 20;
  //GET
  Future<dynamic> get(String baseUrl, String api) async {
    var uri = Uri.parse(baseUrl + api);
    try {
      var response =
          await http.get(uri).timeout(Duration(seconds: TIME_OUT_DURATION));
      return _processResponse(response);
    } on SocketException {
      throw FetchDataException('No inter net connection', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'Api not responded in time', uri.toString());
    }
  }

  //POST
  Future<dynamic> post(String baseUrl, String api, dynamic payloadObj) async {
    var uri = Uri.parse(baseUrl + api);
    // var payload = json.decode(payloadObj);
    try {
      var response =
          await http.get(uri).timeout(Duration(seconds: TIME_OUT_DURATION));
      return _processResponse(response);
    } on SocketException {
      throw FetchDataException('No inter net connection', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'Api not responded in time', uri.toString());
    }
  }
  //DELETE
  //OTHER

  dynamic _processResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = utf8.decode(response.bodyBytes);
        return responseJson;
        // break;
      case 400:
        throw BadRequestException(
            utf8.decode(response.bodyBytes), response.request!.url.toString());
      case 401:
      case 403:
        throw UnAuthorizeException(
            utf8.decode(response.bodyBytes), response.request!.url.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured with code: ${response.statusCode}',
            response.request!.url.toString());
    }
  }
}
