// ignore: file_names
abstract class BaseApiServices {
  Future<dynamic> getGetApiResponse(String url, String token);
  Future<dynamic> getPostApiResponse(String url, dynamic data);
  Future<dynamic> getPostApiResponseLogin(String url, dynamic data);
  // new added
  Future<dynamic> getPostApiResponse2(String url, String token);
  Future<dynamic> getPostApiResponse1(String url, dynamic data, String token);
  Future<dynamic> getPutApiResponse1(String url, dynamic data, String token);
  Future<dynamic> getPutApiResponse2(String url, dynamic data);
  Future<dynamic> getPutApiResponse(String url, String token);
  // new added for delete
  Future<dynamic> getDeleteApiResponse(String url, String token);
  // added for formData
  Future<dynamic> getPutApiResponseFormData(
      String url, dynamic formData, String token);
}
