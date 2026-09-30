class TransmissionHerbicideRejectedModel {
  bool? success;
  String? message;
  List<ReadyForInspectionData>? readyForInspectionData;

  TransmissionHerbicideRejectedModel(
      {this.success, this.message, this.readyForInspectionData});

  TransmissionHerbicideRejectedModel.fromJson(Map<String, dynamic> json) {
    success = json['Success'];
    message = json['Message'];
    if (json['ready_For_Inspection_Data'] != null) {
      readyForInspectionData = <ReadyForInspectionData>[];
      json['ready_For_Inspection_Data'].forEach((v) {
        readyForInspectionData!.add(new ReadyForInspectionData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Success'] = this.success;
    data['Message'] = this.message;
    if (this.readyForInspectionData != null) {
      data['ready_For_Inspection_Data'] =
          this.readyForInspectionData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ReadyForInspectionData {
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

  ReadyForInspectionData(
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

  ReadyForInspectionData.fromJson(Map<String, dynamic> json) {
    tOKENNO = json['TOKEN_NO'] ?? 0;
    tYPE = json['TYPE'] ?? '';
    sTATUS = json['STATUS'] ?? '';
    sUBSTATION = json['SUBSTATION'] ?? '';
    fDRNAME = json['FDR_NAME'] ?? '';
    cONTRACTOR = json['CONTRACTOR'] ?? '';
    tOTALMILES = json['TOTAL_MILES'] ?? '';
    milesPending = json['MILES_PENDING'] ?? '';
    milesCompleted = json['MILES_COMPLETED'] ?? '';
    sTREETADDRESS = json['STREET_ADDRESS'] ?? '';
    mAPLOCATION = json['MAP_LOCATION'] ?? '';
    sUPERVISORNOTES = json['SUPERVISOR_NOTES'] ?? '';
    cONTRACTORCOMPAY = json['CONTRACTOR_COMPAY'] ?? '';
    dATEOFINSPECTION = json['DATE_OF_INSPECTION'] ?? '';
    fOLLOWUPDATE = json['FOLLOW_UP_DATE'] ?? '';
    cREATEDATE = json['CREATE_DATE'] ?? '';
    createdBy = json['CREATED_BY'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TOKEN_NO'] = this.tOKENNO;
    data['TYPE'] = this.tYPE;
    data['STATUS'] = this.sTATUS;
    data['SUBSTATION'] = this.sUBSTATION;
    data['FDR_NAME'] = this.fDRNAME;
    data['CONTRACTOR'] = this.cONTRACTOR;
    data['TOTAL_MILES'] = this.tOTALMILES;
    data['MILES_PENDING'] = this.milesPending;
    data['MILES_COMPLETED'] = this.milesCompleted;
    data['STREET_ADDRESS'] = this.sTREETADDRESS;
    data['MAP_LOCATION'] = this.mAPLOCATION;
    data['SUPERVISOR_NOTES'] = this.sUPERVISORNOTES;
    data['CONTRACTOR_COMPAY'] = this.cONTRACTORCOMPAY;
    data['DATE_OF_INSPECTION'] = this.dATEOFINSPECTION;
    data['FOLLOW_UP_DATE'] = this.fOLLOWUPDATE;
    data['CREATE_DATE'] = this.cREATEDATE;
    data['CREATED_BY'] = createdBy;
    return data;
  }
}
