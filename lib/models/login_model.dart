class LoginModel {
  String? message;
  String? code;
  String? exception;
  List<Result>? result;

  LoginModel({this.message, this.code, this.exception, this.result});

  LoginModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    code = json['code'];
    exception = json['exception'];
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        result!.add(Result.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['code'] = code;
    data['exception'] = exception;
    if (result != null) {
      data['result'] = result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Result {
  int? iD;
  String? uSERNAME;
  String? pASSWORD;
  String? uSERTYPE;
  String? eMAIL;

  Result({this.iD, this.uSERNAME, this.pASSWORD, this.uSERTYPE, this.eMAIL});

  Result.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    uSERNAME = json['USER_NAME'];
    pASSWORD = json['PASSWORD'];
    uSERTYPE = json['USER_TYPE'];
    eMAIL = json['EMAIL'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['USER_NAME'] = uSERNAME;
    data['PASSWORD'] = pASSWORD;
    data['USER_TYPE'] = uSERTYPE;
    data['EMAIL'] = eMAIL;
    return data;
  }
}
