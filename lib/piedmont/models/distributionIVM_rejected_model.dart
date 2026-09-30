class DistributionIVMRejected {
  bool? success;
  String? message;
  List<GetDistributionIVMData>? getDistributionIVMData;

  DistributionIVMRejected(
      {this.success, this.message, this.getDistributionIVMData});

  DistributionIVMRejected.fromJson(Map<String, dynamic> json) {
    success = json['Success'];
    message = json['Message'];
    if (json['get_Distribution_IVM_Data'] != null) {
      getDistributionIVMData = <GetDistributionIVMData>[];
      json['get_Distribution_IVM_Data'].forEach((v) {
        getDistributionIVMData!.add(new GetDistributionIVMData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Success'] = success;
    data['Message'] = message;
    if (getDistributionIVMData != null) {
      data['get_Distribution_IVM_Data'] =
          getDistributionIVMData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetDistributionIVMData {
  int? tOKENNO;
  String? tYPE;
  String? sTATUS;
  String? sUBSTATION;
  String? fDRNAME;
  String? cONTRACTOR;
  String? tOTALMILES;
  String? milesPending;
  String? milesCompleted;
  String? sTREETADDRESS;
  String? mAPLOCATION;
  String? sUPERVISORNOTES;
  String? cONTRACTORCOMPAY;
  String? dATEOFINSPECTION;
  String? fOLLOWUPDATE;
  String? cREATEDATE;
  String? createdBy;

  GetDistributionIVMData(
      {this.tOKENNO,
      this.tYPE,
      this.sTATUS,
      this.sUBSTATION,
      this.fDRNAME,
      this.cONTRACTOR,
      this.tOTALMILES,
      this.milesPending,
      this.milesCompleted,
      this.sTREETADDRESS,
      this.mAPLOCATION,
      this.sUPERVISORNOTES,
      this.cONTRACTORCOMPAY,
      this.dATEOFINSPECTION,
      this.fOLLOWUPDATE,
      this.cREATEDATE,
      this.createdBy});

  GetDistributionIVMData.fromJson(Map<String, dynamic> json) {
    tOKENNO = json['TOKEN_NO'];
    tYPE = json['TYPE'];
    sTATUS = json['STATUS'];
    sUBSTATION = json['SUBSTATION'];
    fDRNAME = json['FDR_NAME'];
    cONTRACTOR = json['CONTRACTOR'];
    tOTALMILES = json['TOTAL_MILES'];
    milesPending = json['MILES_PENDING'];
    milesCompleted = json['MILES_COMPLETED'];
    sTREETADDRESS = json['STREET_ADDRESS'];
    mAPLOCATION = json['MAP_LOCATION'];
    sUPERVISORNOTES = json['SUPERVISOR_NOTES'];
    cONTRACTORCOMPAY = json['CONTRACTOR_COMPAY'];
    dATEOFINSPECTION = json['DATE_OF_INSPECTION'];
    fOLLOWUPDATE = json['FOLLOW_UP_DATE'];
    cREATEDATE = json['CREATE_DATE'];
    createdBy = json['CREATED_BY'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['TOKEN_NO'] = tOKENNO;
    data['TYPE'] = tYPE;
    data['STATUS'] = sTATUS;
    data['SUBSTATION'] = sUBSTATION;
    data['FDR_NAME'] = fDRNAME;
    data['CONTRACTOR'] = cONTRACTOR;
    data['TOTAL_MILES'] = tOTALMILES;
    data['MILES_PENDING'] = milesPending;
    data['MILES_COMPLETED'] = milesCompleted;
    data['STREET_ADDRESS'] = sTREETADDRESS;
    data['MAP_LOCATION'] = mAPLOCATION;
    data['SUPERVISOR_NOTES'] = sUPERVISORNOTES;
    data['CONTRACTOR_COMPAY'] = cONTRACTORCOMPAY;
    data['DATE_OF_INSPECTION'] = dATEOFINSPECTION;
    data['FOLLOW_UP_DATE'] = fOLLOWUPDATE;
    data['CREATE_DATE'] = cREATEDATE;
    data['CREATED_BY'] = createdBy;
    return data;
  }
}
