class AddNewRowMaintModel {
  String? message;
  String? code;
  String? exception;
  List<Result>? result;

  AddNewRowMaintModel({this.message, this.code, this.exception, this.result});

  AddNewRowMaintModel.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = Map<String, dynamic>();
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
  int? tOKENNO;
  String? sUPERVISOR;
  String? rOLE;
  String? sUPERVISER;
  String? mAINTTYPE;
  String? dISTRICT;
  String? cOUNTY;
  String? sUBSTATION;
  String? fEEDER;
  String? sTREET;
  String? tYPE;
  String? cONTRACTYEAR;
  String? cYCLE;
  String? lASTMAINTDONE;
  String? nEXTMAINTDUE;
  String? cONTRACTENDYEAR;
  int? mAINTCOUNT;
  String? mAINTDATEHISTORY;
  String? tOTALMILES;
  int? cOSTPERMILE;
  int? tOTALCOST;
  int? dUEMONTH;
  int? dUEWEEK;
  int? bUDGET;
  String? pLANTYPE;
  String? sTATUS;

  Result(
      {this.iD,
      this.tOKENNO,
      this.sUPERVISOR,
      this.rOLE,
      this.sUPERVISER,
      this.mAINTTYPE,
      this.dISTRICT,
      this.cOUNTY,
      this.sUBSTATION,
      this.fEEDER,
      this.sTREET,
      this.tYPE,
      this.cONTRACTYEAR,
      this.cYCLE,
      this.lASTMAINTDONE,
      this.nEXTMAINTDUE,
      this.cONTRACTENDYEAR,
      this.mAINTCOUNT,
      this.mAINTDATEHISTORY,
      this.tOTALMILES,
      this.cOSTPERMILE,
      this.tOTALCOST,
      this.dUEMONTH,
      this.dUEWEEK,
      this.bUDGET,
      this.pLANTYPE,
      this.sTATUS});

  Result.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    tOKENNO = json['TOKEN_NO'];
    sUPERVISOR = json['SUPERVISOR'];
    rOLE = json['ROLE'];
    sUPERVISER = json['SUPERVISER'];
    mAINTTYPE = json['MAINT_TYPE'];
    dISTRICT = json['DISTRICT'];
    cOUNTY = json['COUNTY'];
    sUBSTATION = json['SUBSTATION'];
    fEEDER = json['FEEDER'];
    sTREET = json['STREET'];
    tYPE = json['TYPE'];
    cONTRACTYEAR = json['CONTRACT_YEAR'];
    cYCLE = json['CYCLE'];
    lASTMAINTDONE = json['LAST_MAINT_DONE'];
    nEXTMAINTDUE = json['NEXT_MAINT_DUE'];
    cONTRACTENDYEAR = json['CONTRACT_END_YEAR'];
    mAINTCOUNT = json['MAINT_COUNT'];
    mAINTDATEHISTORY = json['MAINT_DATE_HISTORY'];
    tOTALMILES = json['TOTAL_MILES'];
    cOSTPERMILE = json['COST_PER_MILE'];
    tOTALCOST = json['TOTAL_COST'];
    dUEMONTH = json['DUE_MONTH'];
    dUEWEEK = json['DUE_WEEK'];
    bUDGET = json['BUDGET'];
    pLANTYPE = json['PLAN_TYPE'];
    sTATUS = json['STATUS'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['TOKEN_NO'] = tOKENNO;
    data['SUPERVISOR'] = sUPERVISOR;
    data['ROLE'] = rOLE;
    data['SUPERVISER'] = sUPERVISER;
    data['MAINT_TYPE'] = mAINTTYPE;
    data['DISTRICT'] = dISTRICT;
    data['COUNTY'] = cOUNTY;
    data['SUBSTATION'] = sUBSTATION;
    data['FEEDER'] = fEEDER;
    data['STREET'] = sTREET;
    data['TYPE'] = tYPE;
    data['CONTRACT_YEAR'] = cONTRACTYEAR;
    data['CYCLE'] = cYCLE;
    data['LAST_MAINT_DONE'] = lASTMAINTDONE;
    data['NEXT_MAINT_DUE'] = nEXTMAINTDUE;
    data['CONTRACT_END_YEAR'] = cONTRACTENDYEAR;
    data['MAINT_COUNT'] = mAINTCOUNT;
    data['MAINT_DATE_HISTORY'] = mAINTDATEHISTORY;
    data['TOTAL_MILES'] = tOTALMILES;
    data['COST_PER_MILE'] = cOSTPERMILE;
    data['TOTAL_COST'] = tOTALCOST;
    data['DUE_MONTH'] = dUEMONTH;
    data['DUE_WEEK'] = dUEWEEK;
    data['BUDGET'] = bUDGET;
    data['PLAN_TYPE'] = pLANTYPE;
    data['STATUS'] = sTATUS;
    return data;
  }
}