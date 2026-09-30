class DailyHerbicideModel {
  List<GetDailyHerbicideDHWEATHERCONDITIONDataList>?
      getDailyHerbicideDHWEATHERCONDITIONDataList;
  List<GetDailyHerbicideDataList>? getDailyHerbicideDataList;
  List<GetDailyHerbicideDHAPPLICATIONDataList>?
      getDailyHerbicideDHAPPLICATIONDataList;
  List<GetDailyHerbicideDHEQUIPMENTDataList>?
      getDailyHerbicideDHEQUIPMENTDataList;
  List<GetDailyHerbicideDHLABORDataList>? getDailyHerbicideDHLABORDataList;
  List<GetDailyHerbicideDetailsDataList>? getDailyHerbicideDetailsDataList;
  List<GetDailyHerbicideDHAPPLICANTSDataList>?
      getDailyHerbicideDHAPPLICANTSDataList;

  DailyHerbicideModel(
      {this.getDailyHerbicideDHWEATHERCONDITIONDataList,
      this.getDailyHerbicideDataList,
      this.getDailyHerbicideDHAPPLICATIONDataList,
      this.getDailyHerbicideDHEQUIPMENTDataList,
      this.getDailyHerbicideDHLABORDataList,
      this.getDailyHerbicideDetailsDataList,
      this.getDailyHerbicideDHAPPLICANTSDataList});

  DailyHerbicideModel.fromJson(Map<String, dynamic> json) {
    if (json['getDailyHerbicideDH_WEATHER_CONDITIONDataList'] != null) {
      getDailyHerbicideDHWEATHERCONDITIONDataList =
          <GetDailyHerbicideDHWEATHERCONDITIONDataList>[];
      json['getDailyHerbicideDH_WEATHER_CONDITIONDataList'].forEach((v) {
        getDailyHerbicideDHWEATHERCONDITIONDataList!
            .add(GetDailyHerbicideDHWEATHERCONDITIONDataList.fromJson(v));
      });
    }
    if (json['getDailyHerbicideDataList'] != null) {
      getDailyHerbicideDataList = <GetDailyHerbicideDataList>[];
      json['getDailyHerbicideDataList'].forEach((v) {
        getDailyHerbicideDataList!
            .add(GetDailyHerbicideDataList.fromJson(v));
      });
    }
    if (json['getDailyHerbicideDH_APPLICATIONDataList'] != null) {
      getDailyHerbicideDHAPPLICATIONDataList =
          <GetDailyHerbicideDHAPPLICATIONDataList>[];
      json['getDailyHerbicideDH_APPLICATIONDataList'].forEach((v) {
        getDailyHerbicideDHAPPLICATIONDataList!
            .add(GetDailyHerbicideDHAPPLICATIONDataList.fromJson(v));
      });
    }
    if (json['getDailyHerbicideDH_EQUIPMENTDataList'] != null) {
      getDailyHerbicideDHEQUIPMENTDataList =
          <GetDailyHerbicideDHEQUIPMENTDataList>[];
      json['getDailyHerbicideDH_EQUIPMENTDataList'].forEach((v) {
        getDailyHerbicideDHEQUIPMENTDataList!
            .add(GetDailyHerbicideDHEQUIPMENTDataList.fromJson(v));
      });
    }
    if (json['getDailyHerbicideDH_LABORDataList'] != null) {
      getDailyHerbicideDHLABORDataList = <GetDailyHerbicideDHLABORDataList>[];
      json['getDailyHerbicideDH_LABORDataList'].forEach((v) {
        getDailyHerbicideDHLABORDataList!
            .add(GetDailyHerbicideDHLABORDataList.fromJson(v));
      });
    }
    if (json['getDailyHerbicideDetailsDataList'] != null) {
      getDailyHerbicideDetailsDataList = <GetDailyHerbicideDetailsDataList>[];
      json['getDailyHerbicideDetailsDataList'].forEach((v) {
        getDailyHerbicideDetailsDataList!
            .add(GetDailyHerbicideDetailsDataList.fromJson(v));
      });
    }
    if (json['getDailyHerbicideDH_APPLICANTSDataList'] != null) {
      getDailyHerbicideDHAPPLICANTSDataList =
          <GetDailyHerbicideDHAPPLICANTSDataList>[];
      json['getDailyHerbicideDH_APPLICANTSDataList'].forEach((v) {
        getDailyHerbicideDHAPPLICANTSDataList!
            .add(GetDailyHerbicideDHAPPLICANTSDataList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (getDailyHerbicideDHWEATHERCONDITIONDataList != null) {
      data['getDailyHerbicideDH_WEATHER_CONDITIONDataList'] = getDailyHerbicideDHWEATHERCONDITIONDataList!
          .map((v) => v.toJson())
          .toList();
    }
    if (getDailyHerbicideDataList != null) {
      data['getDailyHerbicideDataList'] =
          getDailyHerbicideDataList!.map((v) => v.toJson()).toList();
    }
    if (getDailyHerbicideDHAPPLICATIONDataList != null) {
      data['getDailyHerbicideDH_APPLICATIONDataList'] = getDailyHerbicideDHAPPLICATIONDataList!
          .map((v) => v.toJson())
          .toList();
    }
    if (getDailyHerbicideDHEQUIPMENTDataList != null) {
      data['getDailyHerbicideDH_EQUIPMENTDataList'] = getDailyHerbicideDHEQUIPMENTDataList!
          .map((v) => v.toJson())
          .toList();
    }
    if (getDailyHerbicideDHLABORDataList != null) {
      data['getDailyHerbicideDH_LABORDataList'] = getDailyHerbicideDHLABORDataList!
          .map((v) => v.toJson())
          .toList();
    }
    if (getDailyHerbicideDetailsDataList != null) {
      data['getDailyHerbicideDetailsDataList'] = getDailyHerbicideDetailsDataList!
          .map((v) => v.toJson())
          .toList();
    }
    if (getDailyHerbicideDHAPPLICANTSDataList != null) {
      data['getDailyHerbicideDH_APPLICANTSDataList'] = getDailyHerbicideDHAPPLICANTSDataList!
          .map((v) => v.toJson())
          .toList();
    }
    return data;
  }
}

class GetDailyHerbicideDHWEATHERCONDITIONDataList {
  String? dailyHerbicideId;
  String? temperature;
  int? id;
  String? time;
  String? windSpeed;
  String? direction;

  GetDailyHerbicideDHWEATHERCONDITIONDataList(
      {this.dailyHerbicideId,
      this.temperature,
      this.id,
      this.time,
      this.windSpeed,
      this.direction});

  GetDailyHerbicideDHWEATHERCONDITIONDataList.fromJson(
      Map<String, dynamic> json) {
    dailyHerbicideId = json['dailyHerbicideId'];
    temperature = json['temperature'];
    id = json['id'];
    time = json['time'];
    windSpeed = json['windSpeed'];
    direction = json['direction'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['dailyHerbicideId'] = dailyHerbicideId;
    data['temperature'] = temperature;
    data['id'] = id;
    data['time'] = time;
    data['windSpeed'] = windSpeed;
    data['direction'] = direction;
    return data;
  }
}

class GetDailyHerbicideDataList {
  String? date;
  String? circuitNo;
  String? foreman;
  String? substation;
  String? subNo;
  int? id;
  String? mapLineNo;
  String? maintenanceType;
  String? workOrderNo;
  String? jobNumber;
  String? status;

  GetDailyHerbicideDataList(
      {this.date,
      this.circuitNo,
      this.foreman,
      this.substation,
      this.subNo,
      this.id,
      this.mapLineNo,
      this.maintenanceType,
      this.workOrderNo,
      this.jobNumber,
      this.status});

  GetDailyHerbicideDataList.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    circuitNo = json['circuitNo'];
    foreman = json['foreman'];
    substation = json['substation'];
    subNo = json['subNo'];
    id = json['id'];
    mapLineNo = json['mapLineNo'];
    maintenanceType = json['maintenanceType'];
    workOrderNo = json['workOrderNo'];
    jobNumber = json['jobNumber'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['circuitNo'] = circuitNo;
    data['foreman'] = foreman;
    data['substation'] = substation;
    data['subNo'] = subNo;
    data['id'] = id;
    data['mapLineNo'] = mapLineNo;
    data['maintenanceType'] = maintenanceType;
    data['workOrderNo'] = workOrderNo;
    data['jobNumber'] = jobNumber;
    data['status'] = status;
    return data;
  }
}

class GetDailyHerbicideDHAPPLICATIONDataList {
  String? reason;
  String? applicationStartTime;
  String? breakEndTime;
  String? dailyHerbicideId;
  String? breakStartTime;
  int? id;
  String? applicationEndTime;

  GetDailyHerbicideDHAPPLICATIONDataList(
      {this.reason,
      this.applicationStartTime,
      this.breakEndTime,
      this.dailyHerbicideId,
      this.breakStartTime,
      this.id,
      this.applicationEndTime});

  GetDailyHerbicideDHAPPLICATIONDataList.fromJson(Map<String, dynamic> json) {
    reason = json['reason'];
    applicationStartTime = json['applicationStartTime'];
    breakEndTime = json['breakEndTime'];
    dailyHerbicideId = json['dailyHerbicideId'];
    breakStartTime = json['breakStartTime'];
    id = json['id'];
    applicationEndTime = json['applicationEndTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['reason'] = reason;
    data['applicationStartTime'] = applicationStartTime;
    data['breakEndTime'] = breakEndTime;
    data['dailyHerbicideId'] = dailyHerbicideId;
    data['breakStartTime'] = breakStartTime;
    data['id'] = id;
    data['applicationEndTime'] = applicationEndTime;
    return data;
  }
}

class GetDailyHerbicideDHEQUIPMENTDataList {
  String? quantity;
  String? dailyHerbicideId;
  String? totalHours;
  String? hoursEach;
  String? equipment;
  int? id;
  String? equipmentNo;

  GetDailyHerbicideDHEQUIPMENTDataList(
      {this.quantity,
      this.dailyHerbicideId,
      this.totalHours,
      this.hoursEach,
      this.equipment,
      this.id,
      this.equipmentNo});

  GetDailyHerbicideDHEQUIPMENTDataList.fromJson(Map<String, dynamic> json) {
    quantity = json['quantity'];
    dailyHerbicideId = json['dailyHerbicideId'];
    totalHours = json['totalHours'];
    hoursEach = json['hoursEach'];
    equipment = json['equipment'];
    id = json['id'];
    equipmentNo = json['equipmentNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['quantity'] = quantity;
    data['dailyHerbicideId'] = dailyHerbicideId;
    data['totalHours'] = totalHours;
    data['hoursEach'] = hoursEach;
    data['equipment'] = equipment;
    data['id'] = id;
    data['equipmentNo'] = equipmentNo;
    return data;
  }
}

class GetDailyHerbicideDHLABORDataList {
  String? quantity;
  String? dailyHerbicideId;
  String? totalHours;
  String? hoursEach;
  int? id;
  String? labour;

  GetDailyHerbicideDHLABORDataList(
      {this.quantity,
      this.dailyHerbicideId,
      this.totalHours,
      this.hoursEach,
      this.id,
      this.labour});

  GetDailyHerbicideDHLABORDataList.fromJson(Map<String, dynamic> json) {
    quantity = json['quantity'];
    dailyHerbicideId = json['dailyHerbicideId'];
    totalHours = json['totalHours'];
    hoursEach = json['hoursEach'];
    id = json['id'];
    labour = json['labour'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['quantity'] = quantity;
    data['dailyHerbicideId'] = dailyHerbicideId;
    data['totalHours'] = totalHours;
    data['hoursEach'] = hoursEach;
    data['id'] = id;
    data['labour'] = labour;
    return data;
  }
}

class GetDailyHerbicideDetailsDataList {
  String? dailyHerbicideId;
  String? rowWith40;
  String? rowWith30;
  String? rowWith20;
  String? appliedRatePerGallon;
  String? rowWith80;
  String? rowWith70;
  String? productName;
  String? rowWith60;
  String? rowWith50;
  String? epaNo;
  String? sectionPage;
  String? acrossPerSections;
  int? id;
  String? gallonsOfSolution;

  GetDailyHerbicideDetailsDataList(
      {this.dailyHerbicideId,
      this.rowWith40,
      this.rowWith30,
      this.rowWith20,
      this.appliedRatePerGallon,
      this.rowWith80,
      this.rowWith70,
      this.productName,
      this.rowWith60,
      this.rowWith50,
      this.epaNo,
      this.sectionPage,
      this.acrossPerSections,
      this.id,
      this.gallonsOfSolution});

  GetDailyHerbicideDetailsDataList.fromJson(Map<String, dynamic> json) {
    dailyHerbicideId = json['dailyHerbicideId'];
    rowWith40 = json['rowWith40'];
    rowWith30 = json['rowWith30'];
    rowWith20 = json['rowWith20'];
    appliedRatePerGallon = json['appliedRatePerGallon'];
    rowWith80 = json['rowWith80'];
    rowWith70 = json['rowWith70'];
    productName = json['productName'];
    rowWith60 = json['rowWith60'];
    rowWith50 = json['rowWith50'];
    epaNo = json['epaNo'];
    sectionPage = json['sectionPage'];
    acrossPerSections = json['acrossPerSections'];
    id = json['id'];
    gallonsOfSolution = json['gallonsOfSolution'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['dailyHerbicideId'] = dailyHerbicideId;
    data['rowWith40'] = rowWith40;
    data['rowWith30'] = rowWith30;
    data['rowWith20'] = rowWith20;
    data['appliedRatePerGallon'] = appliedRatePerGallon;
    data['rowWith80'] = rowWith80;
    data['rowWith70'] = rowWith70;
    data['productName'] = productName;
    data['rowWith60'] = rowWith60;
    data['rowWith50'] = rowWith50;
    data['epaNo'] = epaNo;
    data['sectionPage'] = sectionPage;
    data['acrossPerSections'] = acrossPerSections;
    data['id'] = id;
    data['gallonsOfSolution'] = gallonsOfSolution;
    return data;
  }
}

class GetDailyHerbicideDHAPPLICANTSDataList {
  String? applicantLicense;
  String? dailyHerbicideId;
  int? id;
  String? applicantName;
  String? applicantDigitalSignature;

  GetDailyHerbicideDHAPPLICANTSDataList(
      {this.applicantLicense,
      this.dailyHerbicideId,
      this.id,
      this.applicantName,
      this.applicantDigitalSignature});

  GetDailyHerbicideDHAPPLICANTSDataList.fromJson(Map<String, dynamic> json) {
    applicantLicense = json['applicantLicense'];
    dailyHerbicideId = json['dailyHerbicideId'];
    id = json['id'];
    applicantName = json['applicantName'];
    applicantDigitalSignature = json['applicantDigitalSignature'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['applicantLicense'] = applicantLicense;
    data['dailyHerbicideId'] = dailyHerbicideId;
    data['id'] = id;
    data['applicantName'] = applicantName;
    data['applicantDigitalSignature'] = applicantDigitalSignature;
    return data;
  }
}
