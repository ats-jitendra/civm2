class SupervisorInvoiceListModel {
  bool? success;
  String? message;
  List<SupervisorInvoiceListData>? readyForReviewData;

  SupervisorInvoiceListModel(
      {this.success, this.message, this.readyForReviewData});

  SupervisorInvoiceListModel.fromJson(Map<String, dynamic> json) {
    success = json['Success'];
    message = json['Message'];
    if (json['ready_For_review_Data'] != null) {
      readyForReviewData = <SupervisorInvoiceListData>[];
      json['ready_For_review_Data'].forEach((v) {
        readyForReviewData!.add(new SupervisorInvoiceListData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Success'] = success;
    data['Message'] = message;
    if (readyForReviewData != null) {
      data['ready_For_review_Data'] =
          readyForReviewData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SupervisorInvoiceListData {
  int? tOKENNO;
  String? mAINTTYPE;
  String? tYPE;
  String? cREWNOTES;
  String? sTATUS;
  String? cONTRACTYEAR;
  String? cYCLE;
  String? nEXTMAINTDUE;
  String? tRANSMISSIONNAME;
  String? nAME;
  int? tblSUBMILESCOSTID;
  String? sUBSTATIONNAME;
  String? fDRNAME;
  double? tOTALMILES;
  double? mILESCOMPLETED;
  int? oRDERMONTH;
  int? oRDERYEAR;
  double? mILESINPROGRESS;
  String? aPPROVEDDATE;

  SupervisorInvoiceListData(
      {this.tOKENNO,
      this.mAINTTYPE,
      this.tYPE,
      this.cREWNOTES,
      this.sTATUS,
      this.cONTRACTYEAR,
      this.cYCLE,
      this.nEXTMAINTDUE,
      this.tRANSMISSIONNAME,
      this.nAME,
      this.tblSUBMILESCOSTID,
      this.sUBSTATIONNAME,
      this.fDRNAME,
      this.tOTALMILES,
      this.mILESCOMPLETED,
      this.oRDERMONTH,
      this.oRDERYEAR,
      this.mILESINPROGRESS,
      this.aPPROVEDDATE});

  SupervisorInvoiceListData.fromJson(Map<String, dynamic> json) {
    tOKENNO = json['TOKEN_NO']??0;
    mAINTTYPE = json['MAINT_TYPE']??'';
    tYPE = json['TYPE']??'';
    cREWNOTES = json['CREW_NOTES']??'';
    sTATUS = json['STATUS']??'';
    cONTRACTYEAR = json['CONTRACT_YEAR']??'';
    cYCLE = json['CYCLE']??'';
    nEXTMAINTDUE = json['NEXT_MAINT_DUE']??'';
    tRANSMISSIONNAME = json['TRANSMISSION_NAME']??'';
    nAME = json['NAME']??'';
    tblSUBMILESCOSTID = json['Tbl_SUB_MILES_COST_ID']??0;
    sUBSTATIONNAME = json['SUBSTATION_NAME']??'';
    fDRNAME = json['FDR_NAME']??'';
    tOTALMILES = json['TOTAL_MILES']??0.0;
    mILESCOMPLETED = json['MILES_COMPLETED']??0.0;
    oRDERMONTH = json['ORDER_MONTH']??0;
    oRDERYEAR = json['ORDER_YEAR']??0;
    mILESINPROGRESS = json['MILES_IN_PROGRESS']??0.0;
    aPPROVEDDATE = json['APPROVED_DATE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TOKEN_NO'] = tOKENNO;
    data['MAINT_TYPE'] = mAINTTYPE;
    data['TYPE'] = tYPE;
    data['CREW_NOTES'] = cREWNOTES;
    data['STATUS'] = sTATUS;
    data['CONTRACT_YEAR'] = cONTRACTYEAR;
    data['CYCLE'] = cYCLE;
    data['NEXT_MAINT_DUE'] = nEXTMAINTDUE;
    data['TRANSMISSION_NAME'] = tRANSMISSIONNAME;
    data['NAME'] = nAME;
    data['Tbl_SUB_MILES_COST_ID'] = tblSUBMILESCOSTID;
    data['SUBSTATION_NAME'] = sUBSTATIONNAME;
    data['FDR_NAME'] = fDRNAME;
    data['TOTAL_MILES'] = tOTALMILES;
    data['MILES_COMPLETED'] = mILESCOMPLETED;
    data['ORDER_MONTH'] = oRDERMONTH;
    data['ORDER_YEAR'] = oRDERYEAR;
    data['MILES_IN_PROGRESS'] = mILESINPROGRESS;
     data['APPROVED_DATE'] = aPPROVEDDATE;
    return data;
  }
}
