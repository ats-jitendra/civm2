class ServiceOrderModel {
  bool? success;
  String? message;
  List<ServiceOrderForReviewData>? serviceOrderForReviewData;

  ServiceOrderModel(
      {this.success, this.message, this.serviceOrderForReviewData});

  ServiceOrderModel.fromJson(Map<String, dynamic> json) {
    success = json['Success'];
    message = json['Message'];
    if (json['Service_Order_For_Review_Data'] != null) {
      serviceOrderForReviewData = <ServiceOrderForReviewData>[];
      json['Service_Order_For_Review_Data'].forEach((v) {
        serviceOrderForReviewData!
            .add( ServiceOrderForReviewData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Success'] = success;
    data['Message'] = message;
    if (serviceOrderForReviewData != null) {
      data['Service_Order_For_Review_Data'] =
          serviceOrderForReviewData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ServiceOrderForReviewData {
  int? iD;
  String? bISONBR;
  String? bISOTYPECD;
  String? bIENTERTYPECD;
  String? bIWOWORKORD;
  String? bISOFULLNM;
  String? bIALLOWPURGESW;
  double? bISOMASTERCTR;
  String? bISODESC;
  String? bISOSTATCD;
  String? bINEEDEDDTTM;
  String? bIUSERNM;
  String? bIOPENDT;
  String? bICLOSEDT;
  String? bIWOPROJECT;
  String? bIWOLOANPROJ;
  String? bIWOLOANPROJEXT;
  String? bIWOLOANDESGN;
  double? bIWOLOANYR;
  String? bIMULTISELECTSW;
  String? bIWODT;
  String? bIOPERID;
  String? bIORIGPROCESS;
  String? bIREVIEWSTATCD;
  String? bICLOSEBY;
  String? bISORESPONSE;
  String? bISOSRCE;
  String? bIREQUESTEDBY;
  String? bITAKENBY;
  String? bIINTERNALORDSW;
  String? bIDELAYTYPE;
  String? bISOHOLDSW;
  String? bIOVERRIDERULESW;
  String? bISALESREP;
  String? bICOMMISSIONTYPE;
  String? bIREASCDIN;
  String? bIREASCDOUT;
  String? bIREASTYPEIN;
  String? bIREASTYPEOUT;
  double? bIREQAMT;
  double? bIPAIDAMT;
  String? bIDESC40;
  double? bICLOSEBILLCYCNBR;
  String? bIINSWTALKSW;
  String? bISWUPDTSW;
  String? bISOGRPMSTRNBR;
  String? bITRANDTTM;
  String? sTATUS;
  String? tANDMNOTES;
  String? sUPERVISORNOTES;
  String? cREATEDATETIME;
  String? cONTRACTORNOTE;
  int? vISIBILITYFLAG;
    String? aCCOUNTNO;
  String? aDDRESS;
  String? pHONE;
  String? zIP;

  ServiceOrderForReviewData(
      {this.iD,
      this.bISONBR,
      this.bISOTYPECD,
      this.bIENTERTYPECD,
      this.bIWOWORKORD,
      this.bISOFULLNM,
      this.bIALLOWPURGESW,
      this.bISOMASTERCTR,
      this.bISODESC,
      this.bISOSTATCD,
      this.bINEEDEDDTTM,
      this.bIUSERNM,
      this.bIOPENDT,
      this.bICLOSEDT,
      this.bIWOPROJECT,
      this.bIWOLOANPROJ,
      this.bIWOLOANPROJEXT,
      this.bIWOLOANDESGN,
      this.bIWOLOANYR,
      this.bIMULTISELECTSW,
      this.bIWODT,
      this.bIOPERID,
      this.bIORIGPROCESS,
      this.bIREVIEWSTATCD,
      this.bICLOSEBY,
      this.bISORESPONSE,
      this.bISOSRCE,
      this.bIREQUESTEDBY,
      this.bITAKENBY,
      this.bIINTERNALORDSW,
      this.bIDELAYTYPE,
      this.bISOHOLDSW,
      this.bIOVERRIDERULESW,
      this.bISALESREP,
      this.bICOMMISSIONTYPE,
      this.bIREASCDIN,
      this.bIREASCDOUT,
      this.bIREASTYPEIN,
      this.bIREASTYPEOUT,
      this.bIREQAMT,
      this.bIPAIDAMT,
      this.bIDESC40,
      this.bICLOSEBILLCYCNBR,
      this.bIINSWTALKSW,
      this.bISWUPDTSW,
      this.bISOGRPMSTRNBR,
      this.bITRANDTTM,
      this.sTATUS,
      this.tANDMNOTES,
      this.sUPERVISORNOTES,
      this.cREATEDATETIME,
      this.cONTRACTORNOTE,
      this.vISIBILITYFLAG,
       this.aCCOUNTNO,
      this.aDDRESS,
      this.pHONE,
      this.zIP});

  ServiceOrderForReviewData.fromJson(Map<String, dynamic> json) {
    iD = json['ID']??0;
    bISONBR = json['BI_SO_NBR']??'';
    bISOTYPECD = json['BI_SO_TYPE_CD']??'';
    bIENTERTYPECD = json['BI_ENTER_TYPE_CD']??'';
    bIWOWORKORD = json['BI_WO_WORKORD']??'';
    bISOFULLNM = json['BI_SO_FULL_NM']??'';
    bIALLOWPURGESW = json['BI_ALLOW_PURGE_SW']??'';
    // bISOMASTERCTR = json['BI_SO_MASTER_CTR']??0.0;
    bISOMASTERCTR = (json['BI_SO_MASTER_CTR'] ?? 0).toDouble();
    bISODESC = json['BI_SO_DESC']??'';
    bISOSTATCD = json['BI_SO_STAT_CD']??'';
    bINEEDEDDTTM = json['BI_NEEDED_DT_TM']??'';
    bIUSERNM = json['BI_USER_NM']??'';
    bIOPENDT = json['BI_OPEN_DT']??'';
    bICLOSEDT = json['BI_CLOSE_DT']??'';
    bIWOPROJECT = json['BI_WO_PROJECT']??'';
    bIWOLOANPROJ = json['BI_WO_LOAN_PROJ']??'';
    bIWOLOANPROJEXT = json['BI_WO_LOAN_PROJ_EXT']??'';
    bIWOLOANDESGN = json['BI_WO_LOAN_DESGN']??'';
    // bIWOLOANYR = json['BI_WO_LOAN_YR']??0.0;
    bIWOLOANYR = (json['BI_WO_LOAN_YR'] ?? 0).toDouble();
    bIMULTISELECTSW = json['BI_MULTI_SELECT_SW']??'';
    bIWODT = json['BI_WO_DT']??'';
    bIOPERID = json['BI_OPER_ID']??'';
    bIORIGPROCESS = json['BI_ORIG_PROCESS']??'';
    bIREVIEWSTATCD = json['BI_REVIEW_STAT_CD']??'';
    bICLOSEBY = json['BI_CLOSE_BY']??'';
    bISORESPONSE = json['BI_SO_RESPONSE']??'';
    bISOSRCE = json['BI_SO_SRCE']??'';
    bIREQUESTEDBY = json['BI_REQUESTED_BY']??'';
    bITAKENBY = json['BI_TAKEN_BY']??'';
    bIINTERNALORDSW = json['BI_INTERNAL_ORD_SW']??'';
    bIDELAYTYPE = json['BI_DELAY_TYPE']??'';
    bISOHOLDSW = json['BI_SO_HOLD_SW']??'';
    bIOVERRIDERULESW = json['BI_OVERRIDE_RULE_SW']??'';
    bISALESREP = json['BI_SALES_REP']??'';
    bICOMMISSIONTYPE = json['BI_COMMISSION_TYPE']??'';
    bIREASCDIN = json['BI_REAS_CD_IN']??'';
    bIREASCDOUT = json['BI_REAS_CD_OUT']??'';
    bIREASTYPEIN = json['BI_REAS_TYPE_IN']??'';
    bIREASTYPEOUT = json['BI_REAS_TYPE_OUT']??'';
    // bIREQAMT = json['BI_REQ_AMT']??0.0;
    bIREQAMT = (json['BI_REQ_AMT'] ?? 0).toDouble();
    // bIPAIDAMT = json['BI_PAID_AMT']??0.0;
    bIPAIDAMT = (json['BI_PAID_AMT'] ?? 0).toDouble();
    bIDESC40 = json['BI_DESC_40']??'';
    // bICLOSEBILLCYCNBR = json['BI_CLOSE_BILL_CYC_NBR']??0.0;
    bICLOSEBILLCYCNBR =
    (json['BI_CLOSE_BILL_CYC_NBR'] ?? 0).toDouble();
    bIINSWTALKSW = json['BI_IN_SWTALK_SW']??'';
    bISWUPDTSW = json['BI_SW_UPDT_SW']??'';
    bISOGRPMSTRNBR = json['BI_SO_GRP_MSTR_NBR']??'';
    bITRANDTTM = json['BI_TRAN_DT_TM']??'';
    sTATUS = json['STATUS']??'';
    tANDMNOTES = json['T_AND_M_NOTES']??'';
    sUPERVISORNOTES = json['SUPERVISOR_NOTES']??'';
    cREATEDATETIME = json['CREATE_DATETIME']??'';
    cONTRACTORNOTE = json['CONTRACTOR_NOTE']??'';
    vISIBILITYFLAG = json['VISIBILITY_FLAG']??0;
     aCCOUNTNO = json['ACCOUNT_NO'];
    aDDRESS = json['ADDRESS'];
    pHONE = json['PHONE'];
    zIP = json['ZIP'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['BI_SO_NBR'] = bISONBR;
    data['BI_SO_TYPE_CD'] = bISOTYPECD;
    data['BI_ENTER_TYPE_CD'] = bIENTERTYPECD;
    data['BI_WO_WORKORD'] = bIWOWORKORD;
    data['BI_SO_FULL_NM'] = bISOFULLNM;
    data['BI_ALLOW_PURGE_SW'] = bIALLOWPURGESW;
    data['BI_SO_MASTER_CTR'] = bISOMASTERCTR;
    data['BI_SO_DESC'] = bISODESC;
    data['BI_SO_STAT_CD'] = bISOSTATCD;
    data['BI_NEEDED_DT_TM'] = bINEEDEDDTTM;
    data['BI_USER_NM'] = bIUSERNM;
    data['BI_OPEN_DT'] = bIOPENDT;
    data['BI_CLOSE_DT'] = bICLOSEDT;
    data['BI_WO_PROJECT'] = bIWOPROJECT;
    data['BI_WO_LOAN_PROJ'] = bIWOLOANPROJ;
    data['BI_WO_LOAN_PROJ_EXT'] = bIWOLOANPROJEXT;
    data['BI_WO_LOAN_DESGN'] = bIWOLOANDESGN;
    data['BI_WO_LOAN_YR'] = bIWOLOANYR;
    data['BI_MULTI_SELECT_SW'] = bIMULTISELECTSW;
    data['BI_WO_DT'] = bIWODT;
    data['BI_OPER_ID'] = bIOPERID;
    data['BI_ORIG_PROCESS'] = bIORIGPROCESS;
    data['BI_REVIEW_STAT_CD'] = bIREVIEWSTATCD;
    data['BI_CLOSE_BY'] = bICLOSEBY;
    data['BI_SO_RESPONSE'] = bISORESPONSE;
    data['BI_SO_SRCE'] = bISOSRCE;
    data['BI_REQUESTED_BY'] = bIREQUESTEDBY;
    data['BI_TAKEN_BY'] = bITAKENBY;
    data['BI_INTERNAL_ORD_SW'] = bIINTERNALORDSW;
    data['BI_DELAY_TYPE'] = bIDELAYTYPE;
    data['BI_SO_HOLD_SW'] = bISOHOLDSW;
    data['BI_OVERRIDE_RULE_SW'] = bIOVERRIDERULESW;
    data['BI_SALES_REP'] = bISALESREP;
    data['BI_COMMISSION_TYPE'] = bICOMMISSIONTYPE;
    data['BI_REAS_CD_IN'] = bIREASCDIN;
    data['BI_REAS_CD_OUT'] = bIREASCDOUT;
    data['BI_REAS_TYPE_IN'] = bIREASTYPEIN;
    data['BI_REAS_TYPE_OUT'] = bIREASTYPEOUT;
    data['BI_REQ_AMT'] = bIREQAMT;
    data['BI_PAID_AMT'] = bIPAIDAMT;
    data['BI_DESC_40'] = bIDESC40;
    data['BI_CLOSE_BILL_CYC_NBR'] = bICLOSEBILLCYCNBR;
    data['BI_IN_SWTALK_SW'] = bIINSWTALKSW;
    data['BI_SW_UPDT_SW'] = bISWUPDTSW;
    data['BI_SO_GRP_MSTR_NBR'] = bISOGRPMSTRNBR;
    data['BI_TRAN_DT_TM'] = bITRANDTTM;
    data['STATUS'] = sTATUS;
    data['T_AND_M_NOTES'] = tANDMNOTES;
    data['SUPERVISOR_NOTES'] = sUPERVISORNOTES;
    data['CREATE_DATETIME'] = cREATEDATETIME;
    data['CONTRACTOR_NOTE'] = cONTRACTORNOTE;
    data['VISIBILITY_FLAG'] = vISIBILITYFLAG;
     data['ACCOUNT_NO'] = aCCOUNTNO;
    data['ADDRESS'] = aDDRESS;
    data['PHONE'] = pHONE;
    data['ZIP'] = zIP;
    return data;
  }
}
