class DistributionIvmReadyforreviewEditModel {
  bool? success;
  String? message;
  List<DistributionIvmReadyforreviewEditModelData>? readyForReviewData;

  DistributionIvmReadyforreviewEditModel(
      {this.success, this.message, this.readyForReviewData});

  DistributionIvmReadyforreviewEditModel.fromJson(Map<String, dynamic> json) {
    success = json['Success'];
    message = json['Message'];
    if (json['ready_For_review_Data'] != null) {
      readyForReviewData = <DistributionIvmReadyforreviewEditModelData>[];
      json['ready_For_review_Data'].forEach((v) {
        readyForReviewData!
            .add(new DistributionIvmReadyforreviewEditModelData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Success'] = this.success;
    data['Message'] = this.message;
    if (this.readyForReviewData != null) {
      data['ready_For_review_Data'] =
          this.readyForReviewData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DistributionIvmReadyforreviewEditModelData {
  int? iD;
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
  String? sUPERVISORNOTES;
  String? aDMINNOTES;
  String? sUBSTATION;
  String? fdrName;
  String? tRANSMISSIONNAME;

  DistributionIvmReadyforreviewEditModelData(
      {this.iD,
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
      this.sUPERVISORNOTES,
      this.aDMINNOTES,
      this.sUBSTATION,
      this.fdrName,
      this.tRANSMISSIONNAME});

  DistributionIvmReadyforreviewEditModelData.fromJson(
      Map<String, dynamic> json) {
    iD = json['ID'] ?? 0;
    tBLSUBMILESCOSTID = json['TBL_SUB_MILES_COST_ID'] ?? '';
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
    sUPERVISORNOTES = json['SUPERVISOR_NOTES'] ?? '';
    aDMINNOTES = json['ADMIN_NOTES'] ?? '';
    sUBSTATION = json['SUBSTATION'] ?? '';
    fdrName = json['fdr_name'] ?? '';
    tRANSMISSIONNAME = json['TRANSMISSION_NAME'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['TBL_SUB_MILES_COST_ID'] = this.tBLSUBMILESCOSTID;
    data['SUBSTAT_NAME'] = this.sUBSTATNAME;
    data['FEEDER'] = this.fEEDER;
    data['STREET'] = this.sTREET;
    data['CREW'] = this.cREW;
    data['TOTAL_MILES'] = this.tOTALMILES;
    data['MILES_COMPLETED'] = this.mILESCOMPLETED;
    data['MILES_IN_PROGRESS'] = this.mILESINPROGRESS;
    data['MILES_PENDING'] = this.mILESPENDING;
    data['PERFORMENCE_TYPE'] = this.pERFORMENCETYPE;
    data['WTD_PROGRESS'] = this.wTDPROGRESS;
    data['MTD_PROGRESS'] = this.mTDPROGRESS;
    data['YTD_PROGRESS'] = this.yTDPROGRESS;
    data['ROW_METHOD'] = this.rOWMETHOD;
    data['DELAY_CAUSE'] = this.dELAYCAUSE;
    data['DELAY_REASON'] = this.dELAYREASON;
    data['EFFECTED_NO_OF_DAYS'] = this.eFFECTEDNOOFDAYS;
    data['FILE_UPLOAD'] = this.fILEUPLOAD;
    data['CREATE_DATE'] = this.cREATEDATE;
    data['STATUS'] = this.sTATUS;
    data['NOTES'] = this.nOTES;
    data['SPAN_COMPLETED'] = this.sPANCOMPLETED;
    data['SUPERVISOR_NOTES'] = this.sUPERVISORNOTES;
    data['ADMIN_NOTES'] = this.aDMINNOTES;
    data['SUBSTATION'] = this.sUBSTATION;
    data['fdr_name'] = this.fdrName;
    data['TRANSMISSION_NAME'] = this.tRANSMISSIONNAME;
    return data;
  }
}
