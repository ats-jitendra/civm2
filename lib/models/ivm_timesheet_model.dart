class IvmTimeSheetModel {
  List<GetLAKECOUNTRYPOWERTIMEREPORTDataList>?
      getLAKECOUNTRYPOWERTIMEREPORTDataList;
  List<GetPOWERTIMEREPORTEMPLOYEESDataList>?
      getPOWERTIMEREPORTEMPLOYEESDataList;
  List<GetPOWERTIMEREPORTEQUIPMENTSDataList>?
      getPOWERTIMEREPORTEQUIPMENTSDataList;
  List<GetLCPTIMEREPORTACTIVITIESDataList>? getLCPTIMEREPORTACTIVITIESDataList;
  List<GetPERSONNELRATESDataList>? getPERSONNELRATESDataList;
  List<GetEQUIPMENTRATESDataList>? getEQUIPMENTRATESDataList;

  IvmTimeSheetModel(
      {this.getLAKECOUNTRYPOWERTIMEREPORTDataList,
      this.getPOWERTIMEREPORTEMPLOYEESDataList,
      this.getPOWERTIMEREPORTEQUIPMENTSDataList,
      this.getLCPTIMEREPORTACTIVITIESDataList,
      this.getEQUIPMENTRATESDataList,
      this.getPERSONNELRATESDataList});

  IvmTimeSheetModel.fromJson(Map<String, dynamic> json) {
    if (json['getLAKE_COUNTRY_POWER_TIME_REPORTDataList'] != null) {
      getLAKECOUNTRYPOWERTIMEREPORTDataList =
          <GetLAKECOUNTRYPOWERTIMEREPORTDataList>[];
      json['getLAKE_COUNTRY_POWER_TIME_REPORTDataList'].forEach((v) {
        getLAKECOUNTRYPOWERTIMEREPORTDataList!
            .add(GetLAKECOUNTRYPOWERTIMEREPORTDataList.fromJson(v));
      });
    }
    if (json['getPOWER_TIME_REPORT_EMPLOYEESDataList'] != null) {
      getPOWERTIMEREPORTEMPLOYEESDataList =
          <GetPOWERTIMEREPORTEMPLOYEESDataList>[];
      json['getPOWER_TIME_REPORT_EMPLOYEESDataList'].forEach((v) {
        getPOWERTIMEREPORTEMPLOYEESDataList!
            .add(GetPOWERTIMEREPORTEMPLOYEESDataList.fromJson(v));
      });
    }
    if (json['getPOWER_TIME_REPORT_EQUIPMENTSDataList'] != null) {
      getPOWERTIMEREPORTEQUIPMENTSDataList =
          <GetPOWERTIMEREPORTEQUIPMENTSDataList>[];
      json['getPOWER_TIME_REPORT_EQUIPMENTSDataList'].forEach((v) {
        getPOWERTIMEREPORTEQUIPMENTSDataList!
            .add(GetPOWERTIMEREPORTEQUIPMENTSDataList.fromJson(v));
      });
    }
    if (json['getLCP_TIME_REPORT_ACTIVITIESDataList'] != null) {
      getLCPTIMEREPORTACTIVITIESDataList =
          <GetLCPTIMEREPORTACTIVITIESDataList>[];
      json['getLCP_TIME_REPORT_ACTIVITIESDataList'].forEach((v) {
        getLCPTIMEREPORTACTIVITIESDataList!
            .add(GetLCPTIMEREPORTACTIVITIESDataList.fromJson(v));
      });
    }
    if (json['getPERSONNEL_RATESDataList'] != null) {
      getPERSONNELRATESDataList = <GetPERSONNELRATESDataList>[];
      json['getPERSONNEL_RATESDataList'].forEach((v) {
        getPERSONNELRATESDataList!.add(GetPERSONNELRATESDataList.fromJson(v));
      });
    }
    if (json['getEQUIPMENT_RATESDataList'] != null) {
      getEQUIPMENTRATESDataList = <GetEQUIPMENTRATESDataList>[];
      json['getEQUIPMENT_RATESDataList'].forEach((v) {
        getEQUIPMENTRATESDataList!.add(GetEQUIPMENTRATESDataList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (getLAKECOUNTRYPOWERTIMEREPORTDataList != null) {
      data['getLAKE_COUNTRY_POWER_TIME_REPORTDataList'] =
          getLAKECOUNTRYPOWERTIMEREPORTDataList!
              .map((v) => v.toJson())
              .toList();
    }
    if (getPOWERTIMEREPORTEMPLOYEESDataList != null) {
      data['getPOWER_TIME_REPORT_EMPLOYEESDataList'] =
          getPOWERTIMEREPORTEMPLOYEESDataList!.map((v) => v.toJson()).toList();
    }
    if (getPOWERTIMEREPORTEQUIPMENTSDataList != null) {
      data['getPOWER_TIME_REPORT_EQUIPMENTSDataList'] =
          getPOWERTIMEREPORTEQUIPMENTSDataList!.map((v) => v.toJson()).toList();
    }
    if (getLCPTIMEREPORTACTIVITIESDataList != null) {
      data['getLCP_TIME_REPORT_ACTIVITIESDataList'] =
          getLCPTIMEREPORTACTIVITIESDataList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetLAKECOUNTRYPOWERTIMEREPORTDataList {
  String? contractor;
  String? date;
  String? personnelName;
  String? contractorType;
  int? reportId;
  String? foreManDigitalSign;
  String? weekendDate;
  String? generalforeMan;
  String? estimatedValue;
  String? personnelType;
  String? jobNo;
  String? crewMember;
  String? ratesValue;
  String? pesticiedLicNo;
  String? foreManDigitalSignature;
  String? workOrderNo;
  String? remarks;
  String? status;

  GetLAKECOUNTRYPOWERTIMEREPORTDataList(
      {this.contractor,
      this.date,
      this.personnelName,
      this.contractorType,
      this.reportId,
      this.foreManDigitalSign,
      this.weekendDate,
      this.generalforeMan,
      this.estimatedValue,
      this.personnelType,
      this.jobNo,
      this.crewMember,
      this.ratesValue,
      this.pesticiedLicNo,
      this.foreManDigitalSignature,
      this.workOrderNo,
      this.remarks,
      this.status});

  GetLAKECOUNTRYPOWERTIMEREPORTDataList.fromJson(Map<String, dynamic> json) {
    contractor = json['contractor'];
    date = json['date'];
    personnelName = json['personnelName'];
    contractorType = json['contractorType'];
    reportId = json['reportId'];
    foreManDigitalSign = json['foreManDigitalSign'];
    weekendDate = json['weekendDate'];
    generalforeMan = json['generalforeMan'];
    estimatedValue = json['estimatedValue'];
    personnelType = json['personnelType'];
    jobNo = json['jobNo'];
    crewMember = json['crewMember'];
    ratesValue = json['ratesValue'];
    pesticiedLicNo = json['pesticiedLicNo'];
    foreManDigitalSignature = json['foreManDigitalSignature'];
    workOrderNo = json['workOrderNo'];
    remarks = json['remarks'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['contractor'] = contractor;
    data['date'] = date;
    data['personnelName'] = personnelName;
    data['contractorType'] = contractorType;
    data['reportId'] = reportId;
    data['foreManDigitalSign'] = foreManDigitalSign;
    data['weekendDate'] = weekendDate;
    data['generalforeMan'] = generalforeMan;
    data['estimatedValue'] = estimatedValue;
    data['personnelType'] = personnelType;
    data['jobNo'] = jobNo;
    data['crewMember'] = crewMember;
    data['ratesValue'] = ratesValue;
    data['pesticiedLicNo'] = pesticiedLicNo;
    data['foreManDigitalSignature'] = foreManDigitalSignature;
    data['workOrderNo'] = workOrderNo;
    data['remarks'] = remarks;
    data['status'] = status;
    return data;
  }
}

class GetPOWERTIMEREPORTEMPLOYEESDataList {
  List<GetEMPWORKINGDATAByEmpNumberAndEmpNameAndClassCodeAndotherCewDataList>?
      getEMPWORKINGDATAByEmpNumberAndEmpNameAndClassCodeAndotherCewDataList;
  String? classCode;
  String? reportId;
  String? otherCew;
  String? empName;
  int? id;
  String? empNo;

  GetPOWERTIMEREPORTEMPLOYEESDataList(
      {this.getEMPWORKINGDATAByEmpNumberAndEmpNameAndClassCodeAndotherCewDataList,
      this.classCode,
      this.reportId,
      this.otherCew,
      this.empName,
      this.id,
      this.empNo});

  GetPOWERTIMEREPORTEMPLOYEESDataList.fromJson(Map<String, dynamic> json) {
    if (json[
            'getEMP_WORKING_DATAByEmp_numberAndEmp_nameAndClassCodeAndotherCewDataList'] !=
        null) {
      getEMPWORKINGDATAByEmpNumberAndEmpNameAndClassCodeAndotherCewDataList =
          <GetEMPWORKINGDATAByEmpNumberAndEmpNameAndClassCodeAndotherCewDataList>[];
      json['getEMP_WORKING_DATAByEmp_numberAndEmp_nameAndClassCodeAndotherCewDataList']
          .forEach((v) {
        getEMPWORKINGDATAByEmpNumberAndEmpNameAndClassCodeAndotherCewDataList!.add(
            GetEMPWORKINGDATAByEmpNumberAndEmpNameAndClassCodeAndotherCewDataList
                .fromJson(v));
      });
    }
    classCode = json['classCode'];
    reportId = json['reportId'];
    otherCew = json['otherCew'];
    empName = json['empName'];
    id = json['id'];
    empNo = json['empNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (getEMPWORKINGDATAByEmpNumberAndEmpNameAndClassCodeAndotherCewDataList !=
        null) {
      data['getEMP_WORKING_DATAByEmp_numberAndEmp_nameAndClassCodeAndotherCewDataList'] =
          getEMPWORKINGDATAByEmpNumberAndEmpNameAndClassCodeAndotherCewDataList!
              .map((v) => v.toJson())
              .toList();
    }
    data['classCode'] = classCode;
    data['reportId'] = reportId;
    data['otherCew'] = otherCew;
    data['empName'] = empName;
    data['id'] = id;
    data['empNo'] = empNo;
    return data;
  }
}

class GetEMPWORKINGDATAByEmpNumberAndEmpNameAndClassCodeAndotherCewDataList {
  String? hours;
  String? mIn;
  String? mOut;
  String? eOut;
  String? eIn;
  String? day;

  GetEMPWORKINGDATAByEmpNumberAndEmpNameAndClassCodeAndotherCewDataList(
      {this.hours, this.mIn, this.mOut, this.eOut, this.eIn, this.day});

  GetEMPWORKINGDATAByEmpNumberAndEmpNameAndClassCodeAndotherCewDataList.fromJson(
      Map<String, dynamic> json) {
    hours = json['hours'];
    mIn = json['mIn'];
    mOut = json['mOut'];
    eOut = json['eOut'];
    eIn = json['eIn'];
    day = json['day'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['hours'] = hours;
    data['mIn'] = mIn;
    data['mOut'] = mOut;
    data['eOut'] = eOut;
    data['eIn'] = eIn;
    data['day'] = day;
    return data;
  }
}

class GetPOWERTIMEREPORTEQUIPMENTSDataList {
  String? code;
  String? otherEquipment;
  String? reportId;
  List<GetSubPOWERTIMEREPORTEQUIPMENTSOfDayHrsList>?
      getSubPOWERTIMEREPORTEQUIPMENTSOfDayHrsList;
  String? equipmentsRatesValue;
  int? id;
  String? equipmentNo;
  String? equipmentType;

  GetPOWERTIMEREPORTEQUIPMENTSDataList(
      {this.code,
      this.otherEquipment,
      this.reportId,
      this.getSubPOWERTIMEREPORTEQUIPMENTSOfDayHrsList,
      this.equipmentsRatesValue,
      this.id,
      this.equipmentNo,
      this.equipmentType});

  GetPOWERTIMEREPORTEQUIPMENTSDataList.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    otherEquipment = json['otherEquipment'];
    reportId = json['reportId'];
    if (json['getSubPOWER_TIME_REPORT_EQUIPMENTSOfDayHrsList'] != null) {
      getSubPOWERTIMEREPORTEQUIPMENTSOfDayHrsList =
          <GetSubPOWERTIMEREPORTEQUIPMENTSOfDayHrsList>[];
      json['getSubPOWER_TIME_REPORT_EQUIPMENTSOfDayHrsList'].forEach((v) {
        getSubPOWERTIMEREPORTEQUIPMENTSOfDayHrsList!
            .add(GetSubPOWERTIMEREPORTEQUIPMENTSOfDayHrsList.fromJson(v));
      });
    }
    equipmentsRatesValue = json['equipmentsRatesValue'];
    id = json['id'];
    equipmentNo = json['equipmentNo'];
    equipmentType = json['equipmentType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['otherEquipment'] = otherEquipment;
    data['reportId'] = reportId;
    if (getSubPOWERTIMEREPORTEQUIPMENTSOfDayHrsList != null) {
      data['getSubPOWER_TIME_REPORT_EQUIPMENTSOfDayHrsList'] =
          getSubPOWERTIMEREPORTEQUIPMENTSOfDayHrsList!
              .map((v) => v.toJson())
              .toList();
    }
    data['equipmentsRatesValue'] = equipmentsRatesValue;
    data['id'] = id;
    data['equipmentNo'] = equipmentNo;
    data['equipmentType'] = equipmentType;
    return data;
  }
}

class GetSubPOWERTIMEREPORTEQUIPMENTSOfDayHrsList {
  String? hours;
  String? day;

  GetSubPOWERTIMEREPORTEQUIPMENTSOfDayHrsList({this.hours, this.day});

  GetSubPOWERTIMEREPORTEQUIPMENTSOfDayHrsList.fromJson(
      Map<String, dynamic> json) {
    hours = json['hours'];
    day = json['day'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['hours'] = hours;
    data['day'] = day;
    return data;
  }
}

class GetLCPTIMEREPORTACTIVITIESDataList {
  String? spans;
  String? notesActivityCode;
  String? chemicalQuantity;
  String? reportId;
  String? mapNumber;
  String? manHours;
  String? widths;
  String? sectionAddress;
  String? chemicalCode;
  String? substationId;
  String? feederId;
  String? dayOfWeek;
  String? lengths;
  String? accountNo;
  String? workType;
  int? id;
  String? poleNumber;

  GetLCPTIMEREPORTACTIVITIESDataList(
      {this.spans,
      this.notesActivityCode,
      this.chemicalQuantity,
      this.reportId,
      this.mapNumber,
      this.manHours,
      this.widths,
      this.sectionAddress,
      this.chemicalCode,
      this.substationId,
      this.feederId,
      this.dayOfWeek,
      this.lengths,
      this.accountNo,
      this.workType,
      this.id,
      this.poleNumber});

  GetLCPTIMEREPORTACTIVITIESDataList.fromJson(Map<String, dynamic> json) {
    spans = json['spans'];
    notesActivityCode = json['notesActivityCode'];
    chemicalQuantity = json['chemicalQuantity'];
    reportId = json['reportId'];
    mapNumber = json['mapNumber'];
    manHours = json['manHours'];
    widths = json['widths'];
    sectionAddress = json['sectionAddress'];
    chemicalCode = json['chemicalCode'];
    substationId = json['substationId'];
    feederId = json['feederId'];
    dayOfWeek = json['dayOfWeek'];
    lengths = json['lengths'];
    accountNo = json['accountNo'];
    workType = json['workType'];
    id = json['id'];
    poleNumber = json['poleNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['spans'] = spans;
    data['notesActivityCode'] = notesActivityCode;
    data['chemicalQuantity'] = chemicalQuantity;
    data['reportId'] = reportId;
    data['mapNumber'] = mapNumber;
    data['manHours'] = manHours;
    data['widths'] = widths;
    data['sectionAddress'] = sectionAddress;
    data['chemicalCode'] = chemicalCode;
    data['substationId'] = substationId;
    data['feederId'] = feederId;
    data['dayOfWeek'] = dayOfWeek;
    data['lengths'] = lengths;
    data['accountNo'] = accountNo;
    data['workType'] = workType;
    data['id'] = id;
    data['poleNumber'] = poleNumber;
    return data;
  }
}

class GetEQUIPMENTRATESDataList {
  String? rates;
  String? equipmentType;

  GetEQUIPMENTRATESDataList({this.rates, this.equipmentType});

  GetEQUIPMENTRATESDataList.fromJson(Map<String, dynamic> json) {
    rates = json['rates'];
    equipmentType = json['equipmentType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['rates'] = rates;
    data['equipmentType'] = equipmentType;
    return data;
  }
}

class GetPERSONNELRATESDataList {
  String? personnelRates;
  String? doubletime;
  String? overtime;
  String? regular;

  GetPERSONNELRATESDataList(
      {this.personnelRates, this.doubletime, this.overtime, this.regular});

  GetPERSONNELRATESDataList.fromJson(Map<String, dynamic> json) {
    personnelRates = json['personnelRates'];
    doubletime = json['doubletime'];
    overtime = json['overtime'];
    regular = json['regular'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['personnelRates'] = personnelRates;
    data['doubletime'] = doubletime;
    data['overtime'] = overtime;
    data['regular'] = regular;
    return data;
  }
}
