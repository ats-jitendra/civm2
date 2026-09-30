class TransmissionHerbicideReadyForReviewModel {
  bool? success;
  String? message;
  List<ReadyForReviewData>? readyForReviewData;

  TransmissionHerbicideReadyForReviewModel(
      {this.success, this.message, this.readyForReviewData});

  TransmissionHerbicideReadyForReviewModel.fromJson(Map<String, dynamic> json) {
    success = json['Success'];
    message = json['Message'];
    if (json['ready_For_review_Data'] != null) {
      readyForReviewData = <ReadyForReviewData>[];
      json['ready_For_review_Data'].forEach((v) {
        readyForReviewData!.add(new ReadyForReviewData.fromJson(v));
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

class ReadyForReviewData {
  // int? iD;
  String? uPDATEDDATE;
  String? tBLSUBMILESCOSTID;
  String? sUBSTATNAME;
  String? fEEDER;
  String? sTREET;
  String? cREW;
  String? tOTALMILES;
  String? mILESCOMPLETED;
  String? mILESINPROGRESS;
  String? mILESPENDING;
  String? pERFORMENCETYPE;
  String? wTDPROGRESS;
  String? mTDPROGRESS;
  String? yTDPROGRESS;
  String? rOWMETHOD;
  String? dELAYCAUSE;
  String? dELAYREASON;
  String? eFFECTEDNOOFDAYS;
  String? fILEUPLOAD;
  String? cREATEDATE;
  String? sTATUS;
  String? nOTES;
  String? sPANCOMPLETED;
  String? tOKENNO;
  String? cREATEDBY;
  String? sUPERVISOR;
  String? cONTRACTOR;
  String? mAINTTYPE;
  String? dISTRICT;
  String? cOUNTY;
  String? sUBSTATION;
  String? tYPE;
  String? cONTRACTYEAR;
  String? cYCLE;
  String? lASTMAINTDONE;
  String? nEXTMAINTDUE;
  String? cONTRACTENDYEAR;
  String? mAINTCOUNT;
  String? mAINTDATEHISTORY;
  String? cOSTPERMILE;
  String? tOTALCOST;
  String? dUEMONTH;
  String? dUEWEEK;
  String? bUDGET;
  String? aCTIONNEEDED;
  String? tREETYPE;
  String? gROWTHRATE;
  String? gROWTHSCORE;
  String? dOCUMENTUPLOAD;
  String? iNVOICECREATED;
  String? wORKPRIORITY;
  String? tBLVMANEWROWMAINTENANCEPLANID;
  String? aPPROVEDBY;
  String? pLANTYPE;
  String? cONTRACTORCOMPAY;
  String? sTREETADDRESS;
  String? mAPLOCATION;
  String? cHANGEORDERIMAGE;
  String? aDMINNOTES1;
  String? cONTRACTORNOTES;
  String? aDMINNOTES2;
  String? dATEOFINSPECTION;
  String? fOLLOWUPDATE;
  String? bUDGETTYPE;
  String? eSTCOST;
  String? eSTTIME;
  String? aCTUALCOST;
  String? rOWYEAR;
  String? vISIBILITYFLAG;
  String? cREWNOTES;
  String? pLANNERNOTES;
  String? sUPERVISORNOTES;
  String? tRANSMISSIONNAME;
  String? sUBID;
  String? cOUNTYID;
  String? sUBSATIONID;
  String? nAME;
  String? lOGINID;
  String? sUPERVISORID;
  String? cONTRACTORCOMPANY;
  String? tblSUBMILESCOSTID;
  String? sUBSTATIONNAME;
  String? fDRNAME;
  String? checkPendingStatus;

  ReadyForReviewData(
      {
      //   this.iD,
      this.uPDATEDDATE,
      this.tBLSUBMILESCOSTID,
      this.sUBSTATNAME,
      this.fEEDER,
      this.sTREET,
      this.cREW,
      this.tOTALMILES,
      this.mILESCOMPLETED,
      this.mILESINPROGRESS,
      this.mILESPENDING,
      this.pERFORMENCETYPE,
      this.wTDPROGRESS,
      this.mTDPROGRESS,
      this.yTDPROGRESS,
      this.rOWMETHOD,
      this.dELAYCAUSE,
      this.dELAYREASON,
      this.eFFECTEDNOOFDAYS,
      this.fILEUPLOAD,
      this.cREATEDATE,
      this.sTATUS,
      this.nOTES,
      this.sPANCOMPLETED,
      this.tOKENNO,
      this.cREATEDBY,
      this.sUPERVISOR,
      this.cONTRACTOR,
      this.mAINTTYPE,
      this.dISTRICT,
      this.cOUNTY,
      this.sUBSTATION,
      this.tYPE,
      this.cONTRACTYEAR,
      this.cYCLE,
      this.lASTMAINTDONE,
      this.nEXTMAINTDUE,
      this.cONTRACTENDYEAR,
      this.mAINTCOUNT,
      this.mAINTDATEHISTORY,
      this.cOSTPERMILE,
      this.tOTALCOST,
      this.dUEMONTH,
      this.dUEWEEK,
      this.bUDGET,
      this.aCTIONNEEDED,
      this.tREETYPE,
      this.gROWTHRATE,
      this.gROWTHSCORE,
      this.dOCUMENTUPLOAD,
      this.iNVOICECREATED,
      this.wORKPRIORITY,
      this.tBLVMANEWROWMAINTENANCEPLANID,
      this.aPPROVEDBY,
      this.pLANTYPE,
      this.cONTRACTORCOMPAY,
      this.sTREETADDRESS,
      this.mAPLOCATION,
      this.cHANGEORDERIMAGE,
      this.aDMINNOTES1,
      this.cONTRACTORNOTES,
      this.aDMINNOTES2,
      this.dATEOFINSPECTION,
      this.fOLLOWUPDATE,
      this.bUDGETTYPE,
      this.eSTCOST,
      this.eSTTIME,
      this.aCTUALCOST,
      this.rOWYEAR,
      this.vISIBILITYFLAG,
      this.cREWNOTES,
      this.pLANNERNOTES,
      this.sUPERVISORNOTES,
      this.tRANSMISSIONNAME,
      this.sUBID,
      this.cOUNTYID,
      this.sUBSATIONID,
      this.nAME,
      this.lOGINID,
      this.sUPERVISORID,
      this.cONTRACTORCOMPANY,
      this.tblSUBMILESCOSTID,
      this.sUBSTATIONNAME,
      this.fDRNAME,
      this.checkPendingStatus});

  ReadyForReviewData.fromJson(Map<String, dynamic> json) {
    //iD = json['ID'] ?? 0;
    uPDATEDDATE = json['UPDATED_DATE'] ?? '';
    tBLSUBMILESCOSTID = json['TBL_SUB_MILES_COST_ID'] ?? 0;
    sUBSTATNAME = json['SUBSTAT_NAME'] ?? '';
    fEEDER = json['FEEDER'] ?? '';
    sTREET = json['STREET'] ?? '';
    cREW = json['CREW'] ?? '';
    tOTALMILES = json['TOTAL_MILES'] ?? '';
    mILESCOMPLETED = json['MILES_COMPLETED'] ?? '';
    mILESINPROGRESS = json['MILES_IN_PROGRESS'] ?? '';
    mILESPENDING = json['MILES_PENDING'] ?? '';
    pERFORMENCETYPE = json['PERFORMENCE_TYPE'] ?? '';
    wTDPROGRESS = json['WTD_PROGRESS'] ?? '';
    mTDPROGRESS = json['MTD_PROGRESS'] ?? '';
    yTDPROGRESS = json['YTD_PROGRESS'] ?? '';
    rOWMETHOD = json['ROW_METHOD'] ?? '';
    dELAYCAUSE = json['DELAY_CAUSE'] ?? '';
    dELAYREASON = json['DELAY_REASON'] ?? '';
    eFFECTEDNOOFDAYS = json['EFFECTED_NO_OF_DAYS'] ?? '';
    fILEUPLOAD = json['FILE_UPLOAD'] ?? '';
    cREATEDATE = json['CREATE_DATE'] ?? '';
    sTATUS = json['STATUS'] ?? '';
    nOTES = json['NOTES'] ?? '';
    sPANCOMPLETED = json['SPAN_COMPLETED'] ?? '';
    tOKENNO = json['TOKEN_NO'] ?? '';
    cREATEDBY = json['CREATED_BY'] ?? '';
    sUPERVISOR = json['SUPERVISOR'] ?? '';
    cONTRACTOR = json['CONTRACTOR'] ?? '';
    mAINTTYPE = json['MAINT_TYPE'] ?? '';
    dISTRICT = json['DISTRICT'] ?? '';
    cOUNTY = json['COUNTY'] ?? '';
    sUBSTATION = json['SUBSTATION'] ?? '';
    tYPE = json['TYPE'] ?? '';
    cONTRACTYEAR = json['CONTRACT_YEAR'] ?? '';
    cYCLE = json['CYCLE'] ?? '';
    lASTMAINTDONE = json['LAST_MAINT_DONE'] ?? '';
    nEXTMAINTDUE = json['NEXT_MAINT_DUE'] ?? '';
    cONTRACTENDYEAR = json['CONTRACT_END_YEAR'] ?? '';
    mAINTCOUNT = json['MAINT_COUNT'] ?? '';
    mAINTDATEHISTORY = json['MAINT_DATE_HISTORY'] ?? '';
    cOSTPERMILE = json['COST_PER_MILE'] ?? '';
    tOTALCOST = json['TOTAL_COST'] ?? '';
    dUEMONTH = json['DUE_MONTH'] ?? '';
    dUEWEEK = json['DUE_WEEK'] ?? '';
    bUDGET = json['BUDGET'] ?? '';
    aCTIONNEEDED = json['ACTION_NEEDED'] ?? '';
    tREETYPE = json['TREE_TYPE'] ?? '';
    gROWTHRATE = json['GROWTH_RATE'] ?? '';
    gROWTHSCORE = json['GROWTH_SCORE'] ?? '';
    dOCUMENTUPLOAD = json['DOCUMENT_UPLOAD'] ?? '';
    iNVOICECREATED = json['INVOICE_CREATED'] ?? '';
    wORKPRIORITY = json['WORK_PRIORITY'] ?? '';
    tBLVMANEWROWMAINTENANCEPLANID =
        json['TBL_VMA_NEW_ROW_MAINTENANCE_PLAN_ID'] ?? '';
    aPPROVEDBY = json['APPROVED_BY'] ?? '';
    pLANTYPE = json['PLAN_TYPE'] ?? '';
    cONTRACTORCOMPAY = json['CONTRACTOR_COMPAY'] ?? '';
    sTREETADDRESS = json['STREET_ADDRESS'] ?? '';
    mAPLOCATION = json['MAP_LOCATION'] ?? '';
    cHANGEORDERIMAGE = json['CHANGE_ORDER_IMAGE'] ?? '';
    aDMINNOTES1 = json['ADMIN_NOTES1'] ?? '';
    cONTRACTORNOTES = json['CONTRACTOR_NOTES'] ?? '';
    aDMINNOTES2 = json['ADMIN_NOTES2'] ?? '';
    dATEOFINSPECTION = json['DATE_OF_INSPECTION'] ?? '';
    fOLLOWUPDATE = json['FOLLOW_UP_DATE'] ?? '';
    bUDGETTYPE = json['BUDGET_TYPE'] ?? '';
    eSTCOST = json['EST_COST'] ?? '';
    eSTTIME = json['EST_TIME'] ?? '';
    aCTUALCOST = json['ACTUAL_COST'] ?? '';
    rOWYEAR = json['ROW_YEAR'] ?? '';
    vISIBILITYFLAG = json['VISIBILITY_FLAG'] ?? '';
    cREWNOTES = json['CREW_NOTES'] ?? '';
    pLANNERNOTES = json['PLANNER_NOTES'] ?? '';
    sUPERVISORNOTES = json['SUPERVISOR_NOTES'] ?? '';
    tRANSMISSIONNAME = json['TRANSMISSION_NAME'] ?? '';
    sUBID = json['SUB_ID'] ?? '';
    cOUNTYID = json['COUNTY_ID'] ?? '';
    sUBSATIONID = json['SUBSATION_ID'] ?? '';
    nAME = json['NAME'] ?? '';
    lOGINID = json['LOGIN_ID'] ?? '';
    sUPERVISORID = json['SUPERVISOR_ID'] ?? '';
    cONTRACTORCOMPANY = json['CONTRACTOR_COMPANY'] ?? '';
    tblSUBMILESCOSTID = json['Tbl_SUB_MILES_COST_ID'] ?? '';
    sUBSTATIONNAME = json['SUBSTATION_NAME'] ?? '';
    fDRNAME = json['FDR_NAME'] ?? '';
    checkPendingStatus = json['checkPendingStatus']??'';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    //  data['ID'] = this.iD;
    data['UPDATED_DATE'] = uPDATEDDATE;
    data['TBL_SUB_MILES_COST_ID'] = tBLSUBMILESCOSTID;
    data['SUBSTAT_NAME'] = sUBSTATNAME;
    data['FEEDER'] = fEEDER;
    data['STREET'] = sTREET;
    data['CREW'] = cREW;
    data['TOTAL_MILES'] = tOTALMILES;
    data['MILES_COMPLETED'] = mILESCOMPLETED;
    data['MILES_IN_PROGRESS'] = mILESINPROGRESS;
    data['MILES_PENDING'] = mILESPENDING;
    data['PERFORMENCE_TYPE'] = pERFORMENCETYPE;
    data['WTD_PROGRESS'] = wTDPROGRESS;
    data['MTD_PROGRESS'] = mTDPROGRESS;
    data['YTD_PROGRESS'] = yTDPROGRESS;
    data['ROW_METHOD'] = rOWMETHOD;
    data['DELAY_CAUSE'] = dELAYCAUSE;
    data['DELAY_REASON'] = dELAYREASON;
    data['EFFECTED_NO_OF_DAYS'] = eFFECTEDNOOFDAYS;
    data['FILE_UPLOAD'] = fILEUPLOAD;
    data['CREATE_DATE'] = cREATEDATE;
    data['STATUS'] = sTATUS;
    data['NOTES'] = nOTES;
    data['SPAN_COMPLETED'] = sPANCOMPLETED;
    data['TOKEN_NO'] = tOKENNO;
    data['CREATED_BY'] = cREATEDBY;
    data['SUPERVISOR'] = sUPERVISOR;
    data['CONTRACTOR'] = cONTRACTOR;
    data['MAINT_TYPE'] = mAINTTYPE;
    data['DISTRICT'] = dISTRICT;
    data['COUNTY'] = cOUNTY;
    data['SUBSTATION'] = sUBSTATION;
    data['TYPE'] = tYPE;
    data['CONTRACT_YEAR'] = cONTRACTYEAR;
    data['CYCLE'] = cYCLE;
    data['LAST_MAINT_DONE'] = lASTMAINTDONE;
    data['NEXT_MAINT_DUE'] = nEXTMAINTDUE;
    data['CONTRACT_END_YEAR'] = cONTRACTENDYEAR;
    data['MAINT_COUNT'] = mAINTCOUNT;
    data['MAINT_DATE_HISTORY'] = mAINTDATEHISTORY;
    data['COST_PER_MILE'] = cOSTPERMILE;
    data['TOTAL_COST'] = tOTALCOST;
    data['DUE_MONTH'] = dUEMONTH;
    data['DUE_WEEK'] = dUEWEEK;
    data['BUDGET'] = bUDGET;
    data['ACTION_NEEDED'] = aCTIONNEEDED;
    data['TREE_TYPE'] = tREETYPE;
    data['GROWTH_RATE'] = gROWTHRATE;
    data['GROWTH_SCORE'] = gROWTHSCORE;
    data['DOCUMENT_UPLOAD'] = dOCUMENTUPLOAD;
    data['INVOICE_CREATED'] = iNVOICECREATED;
    data['WORK_PRIORITY'] = wORKPRIORITY;
    data['TBL_VMA_NEW_ROW_MAINTENANCE_PLAN_ID'] =
        tBLVMANEWROWMAINTENANCEPLANID;
    data['APPROVED_BY'] = aPPROVEDBY;
    data['PLAN_TYPE'] = pLANTYPE;
    data['CONTRACTOR_COMPAY'] = cONTRACTORCOMPAY;
    data['STREET_ADDRESS'] = sTREETADDRESS;
    data['MAP_LOCATION'] = mAPLOCATION;
    data['CHANGE_ORDER_IMAGE'] = cHANGEORDERIMAGE;
    data['ADMIN_NOTES1'] = aDMINNOTES1;
    data['CONTRACTOR_NOTES'] = cONTRACTORNOTES;
    data['ADMIN_NOTES2'] = aDMINNOTES2;
    data['DATE_OF_INSPECTION'] = dATEOFINSPECTION;
    data['FOLLOW_UP_DATE'] = fOLLOWUPDATE;
    data['BUDGET_TYPE'] = bUDGETTYPE;
    data['EST_COST'] = eSTCOST;
    data['EST_TIME'] = eSTTIME;
    data['ACTUAL_COST'] = aCTUALCOST;
    data['ROW_YEAR'] = rOWYEAR;
    data['VISIBILITY_FLAG'] = vISIBILITYFLAG;
    data['CREW_NOTES'] = cREWNOTES;
    data['PLANNER_NOTES'] = pLANNERNOTES;
    data['SUPERVISOR_NOTES'] = sUPERVISORNOTES;
    data['TRANSMISSION_NAME'] = tRANSMISSIONNAME;
    data['SUB_ID'] = sUBID;
    data['COUNTY_ID'] = cOUNTYID;
    data['SUBSATION_ID'] = sUBSATIONID;
    data['NAME'] = nAME;
    data['LOGIN_ID'] = lOGINID;
    data['SUPERVISOR_ID'] = sUPERVISORID;
    data['CONTRACTOR_COMPANY'] = cONTRACTORCOMPANY;
    data['Tbl_SUB_MILES_COST_ID'] = tblSUBMILESCOSTID;
    data['SUBSTATION_NAME'] = sUBSTATIONNAME;
    data['FDR_NAME'] = fDRNAME;
     data['checkPendingStatus'] = checkPendingStatus;
    return data;
  }
}
