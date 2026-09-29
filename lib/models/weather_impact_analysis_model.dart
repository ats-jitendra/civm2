class WeatherImpactAnalysisModel {
  List<GetSPOUTAGECOUNTBYPRECBYSUBSTATION>? getSPOUTAGECOUNTBYPRECBYSUBSTATION;
  List<FindsCustomerCounts>? findsCustomerCounts;
  List<FindCustomerCountBySubstationAndFdrs>?
      findCustomerCountBySubstationAndFdrs;
  List<FindsCustomerCountByDelayCauseAndSubstationAndFdrs>?
      findsCustomerCountByDelayCauseAndSubstationAndFdrs;
  List<FindNextMaintDueBySubstationFeederDelayCause>?
      findNextMaintDueBySubstationFeederDelayCause;
  List<GetVMAVEGETATIONCREWFORM>? getVMAVEGETATIONCREWFORM;
  List<FindAllSubstation>? findAllSubstation;
  List<GetSPOUTAGECOUNTBYTEMPBYSUBSTATION>? getSPOUTAGECOUNTBYTEMPBYSUBSTATION;
  List<FindsDelayCauseBySubstationAndFdr>? findsDelayCauseBySubstationAndFdr;
  List<FindCustomerCountsByCountyAndSubstation>?
      findCustomerCountsByCountyAndSubstation;
  List<FindFeederNameAndIdBySubstation>? findFeederNameAndIdBySubstation;

  WeatherImpactAnalysisModel(
      {this.getSPOUTAGECOUNTBYPRECBYSUBSTATION,
      this.findsCustomerCounts,
      this.findCustomerCountBySubstationAndFdrs,
      this.findsCustomerCountByDelayCauseAndSubstationAndFdrs,
      this.findNextMaintDueBySubstationFeederDelayCause,
      this.getVMAVEGETATIONCREWFORM,
      this.findAllSubstation,
      this.getSPOUTAGECOUNTBYTEMPBYSUBSTATION,
      this.findsDelayCauseBySubstationAndFdr,
      this.findCustomerCountsByCountyAndSubstation,
      this.findFeederNameAndIdBySubstation});

  WeatherImpactAnalysisModel.fromJson(Map<String, dynamic> json) {
    if (json['getSP_OUTAGE_COUNT_BY_PREC_BY_SUBSTATION'] != null) {
      getSPOUTAGECOUNTBYPRECBYSUBSTATION =
          <GetSPOUTAGECOUNTBYPRECBYSUBSTATION>[];
      json['getSP_OUTAGE_COUNT_BY_PREC_BY_SUBSTATION'].forEach((v) {
        getSPOUTAGECOUNTBYPRECBYSUBSTATION!
            .add(GetSPOUTAGECOUNTBYPRECBYSUBSTATION.fromJson(v));
      });
    }
    if (json['findsCustomerCounts'] != null) {
      findsCustomerCounts = <FindsCustomerCounts>[];
      json['findsCustomerCounts'].forEach((v) {
        findsCustomerCounts!.add(FindsCustomerCounts.fromJson(v));
      });
    }
    if (json['findCustomerCountBySubstationAndFdrs'] != null) {
      findCustomerCountBySubstationAndFdrs =
          <FindCustomerCountBySubstationAndFdrs>[];
      json['findCustomerCountBySubstationAndFdrs'].forEach((v) {
        findCustomerCountBySubstationAndFdrs!
            .add(FindCustomerCountBySubstationAndFdrs.fromJson(v));
      });
    }
    if (json['findsCustomerCountByDelayCauseAndSubstationAndFdrs'] != null) {
      findsCustomerCountByDelayCauseAndSubstationAndFdrs =
          <FindsCustomerCountByDelayCauseAndSubstationAndFdrs>[];
      json['findsCustomerCountByDelayCauseAndSubstationAndFdrs'].forEach((v) {
        findsCustomerCountByDelayCauseAndSubstationAndFdrs!.add(
            FindsCustomerCountByDelayCauseAndSubstationAndFdrs.fromJson(v));
      });
    }
    if (json['findNextMaintDueBySubstationFeederDelayCause'] != null) {
      findNextMaintDueBySubstationFeederDelayCause =
          <FindNextMaintDueBySubstationFeederDelayCause>[];
      json['findNextMaintDueBySubstationFeederDelayCause'].forEach((v) {
        findNextMaintDueBySubstationFeederDelayCause!
            .add(FindNextMaintDueBySubstationFeederDelayCause.fromJson(v));
      });
    }
    if (json['getVMA_VEGETATION_CREWFORM'] != null) {
      getVMAVEGETATIONCREWFORM = <GetVMAVEGETATIONCREWFORM>[];
      json['getVMA_VEGETATION_CREWFORM'].forEach((v) {
        getVMAVEGETATIONCREWFORM!.add(GetVMAVEGETATIONCREWFORM.fromJson(v));
      });
    }
    if (json['findAllSubstation'] != null) {
      findAllSubstation = <FindAllSubstation>[];
      json['findAllSubstation'].forEach((v) {
        findAllSubstation!.add(FindAllSubstation.fromJson(v));
      });
    }
    if (json['getSP_OUTAGE_COUNT_BY_TEMP_BY_SUBSTATION'] != null) {
      getSPOUTAGECOUNTBYTEMPBYSUBSTATION =
          <GetSPOUTAGECOUNTBYTEMPBYSUBSTATION>[];
      json['getSP_OUTAGE_COUNT_BY_TEMP_BY_SUBSTATION'].forEach((v) {
        getSPOUTAGECOUNTBYTEMPBYSUBSTATION!
            .add(GetSPOUTAGECOUNTBYTEMPBYSUBSTATION.fromJson(v));
      });
    }
    if (json['findsDelayCauseBySubstationAndFdr'] != null) {
      findsDelayCauseBySubstationAndFdr = <FindsDelayCauseBySubstationAndFdr>[];
      json['findsDelayCauseBySubstationAndFdr'].forEach((v) {
        findsDelayCauseBySubstationAndFdr!
            .add(FindsDelayCauseBySubstationAndFdr.fromJson(v));
      });
    }
    if (json['findCustomerCountsByCountyAndSubstation'] != null) {
      findCustomerCountsByCountyAndSubstation =
          <FindCustomerCountsByCountyAndSubstation>[];
      json['findCustomerCountsByCountyAndSubstation'].forEach((v) {
        findCustomerCountsByCountyAndSubstation!
            .add(FindCustomerCountsByCountyAndSubstation.fromJson(v));
      });
    }
    if (json['findFeederNameAndIdBySubstation'] != null) {
      findFeederNameAndIdBySubstation = <FindFeederNameAndIdBySubstation>[];
      json['findFeederNameAndIdBySubstation'].forEach((v) {
        findFeederNameAndIdBySubstation!
            .add(FindFeederNameAndIdBySubstation.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (getSPOUTAGECOUNTBYPRECBYSUBSTATION != null) {
      data['getSP_OUTAGE_COUNT_BY_PREC_BY_SUBSTATION'] =
          getSPOUTAGECOUNTBYPRECBYSUBSTATION!.map((v) => v.toJson()).toList();
    }
    if (findsCustomerCounts != null) {
      data['findsCustomerCounts'] =
          findsCustomerCounts!.map((v) => v.toJson()).toList();
    }
    if (findCustomerCountBySubstationAndFdrs != null) {
      data['findCustomerCountBySubstationAndFdrs'] =
          findCustomerCountBySubstationAndFdrs!.map((v) => v.toJson()).toList();
    }
    if (findsCustomerCountByDelayCauseAndSubstationAndFdrs != null) {
      data['findsCustomerCountByDelayCauseAndSubstationAndFdrs'] =
          findsCustomerCountByDelayCauseAndSubstationAndFdrs!
              .map((v) => v.toJson())
              .toList();
    }
    if (findNextMaintDueBySubstationFeederDelayCause != null) {
      data['findNextMaintDueBySubstationFeederDelayCause'] =
          findNextMaintDueBySubstationFeederDelayCause!
              .map((v) => v.toJson())
              .toList();
    }
    if (getVMAVEGETATIONCREWFORM != null) {
      data['getVMA_VEGETATION_CREWFORM'] =
          getVMAVEGETATIONCREWFORM!.map((v) => v.toJson()).toList();
    }
    if (findAllSubstation != null) {
      data['findAllSubstation'] =
          findAllSubstation!.map((v) => v.toJson()).toList();
    }
    if (getSPOUTAGECOUNTBYTEMPBYSUBSTATION != null) {
      data['getSP_OUTAGE_COUNT_BY_TEMP_BY_SUBSTATION'] =
          getSPOUTAGECOUNTBYTEMPBYSUBSTATION!.map((v) => v.toJson()).toList();
    }
    if (findsDelayCauseBySubstationAndFdr != null) {
      data['findsDelayCauseBySubstationAndFdr'] =
          findsDelayCauseBySubstationAndFdr!.map((v) => v.toJson()).toList();
    }
    if (findCustomerCountsByCountyAndSubstation != null) {
      data['findCustomerCountsByCountyAndSubstation'] =
          findCustomerCountsByCountyAndSubstation!
              .map((v) => v.toJson())
              .toList();
    }
    if (findFeederNameAndIdBySubstation != null) {
      data['findFeederNameAndIdBySubstation'] =
          findFeederNameAndIdBySubstation!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FindFeederNameAndIdBySubstation {
  String? fdrName;
  int? id;

  FindFeederNameAndIdBySubstation({this.fdrName, this.id});

  FindFeederNameAndIdBySubstation.fromJson(Map<String, dynamic> json) {
    fdrName = json['fdrName'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fdrName'] = fdrName;
    data['id'] = id;
    return data;
  }
}

class FindNextMaintDueBySubstationFeederDelayCause {
  FindNextMaintDueBySubstationFeederDelayCause.fromJson(v);

  toJson() {}
}

class FindCustomerCountsByCountyAndSubstation {
  FindCustomerCountsByCountyAndSubstation.fromJson(v);

  toJson() {}
}

class FindsDelayCauseBySubstationAndFdr {
  String? delayCause;

  FindsDelayCauseBySubstationAndFdr({this.delayCause});

  FindsDelayCauseBySubstationAndFdr.fromJson(Map<String, dynamic> json) {
    delayCause = json['delayCause'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['delayCause'] = delayCause;
    return data;
  }
}

class GetSPOUTAGECOUNTBYTEMPBYSUBSTATION {
  String? precipitation;
  String? substation;
  int? countDelayCause;

  GetSPOUTAGECOUNTBYTEMPBYSUBSTATION(
      {this.precipitation, this.substation, this.countDelayCause});

  GetSPOUTAGECOUNTBYTEMPBYSUBSTATION.fromJson(Map<String, dynamic> json) {
    precipitation = json['precipitation'];
    substation = json['substation'];
    countDelayCause = json['countDelayCause'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['precipitation'] = precipitation;
    data['substation'] = substation;
    data['countDelayCause'] = countDelayCause;
    return data;
  }
}

class FindsCustomerCountByDelayCauseAndSubstationAndFdrs {
  FindsCustomerCountByDelayCauseAndSubstationAndFdrs.fromJson(v);

  toJson() {}
}

class GetSPOUTAGECOUNTBYPRECBYSUBSTATION {
  String? precipitation;
  String? substation;
  int? countDelayCause;

  GetSPOUTAGECOUNTBYPRECBYSUBSTATION(
      {this.precipitation, this.substation, this.countDelayCause});

  GetSPOUTAGECOUNTBYPRECBYSUBSTATION.fromJson(Map<String, dynamic> json) {
    precipitation = json['precipitation'];
    substation = json['substation'];
    countDelayCause = json['countDelayCause'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['precipitation'] = precipitation;
    data['substation'] = substation;
    data['countDelayCause'] = countDelayCause;
    return data;
  }
}

class FindsCustomerCounts {
  double? customerCounts;

  FindsCustomerCounts({this.customerCounts});

  FindsCustomerCounts.fromJson(Map<String, dynamic> json) {
    customerCounts = json['customerCounts'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['customerCounts'] = customerCounts;
    return data;
  }
}

class FindCustomerCountBySubstationAndFdrs {
  double? customerCount;

  FindCustomerCountBySubstationAndFdrs({this.customerCount});

  FindCustomerCountBySubstationAndFdrs.fromJson(Map<String, dynamic> json) {
    customerCount = json['customerCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['customerCount'] = customerCount;
    return data;
  }
}

class GetVMAVEGETATIONCREWFORM {
  String? contractYear;
  double? milesCompleted;
  String? feeder;
  String? county;
  String? nextMaintDue;
  String? type;
  String? fileUpload;
  String? cycle;
  String? performanceType;
  String? adminNotes1;
  String? crew;
  String? precip;
  double? milesInProgress;
  String? maintType;
  String? street;
  String? substation;
  String? rowMethod;
  int? id;
  String? delayReason;
  String? createDate;
  String? contractorCompany;
  String? temp;
  double? milesPending;
  String? delayCause;
  double? totalMiles;
  double? effectedNoOfDays;
  double? wtdProgress;
  int? tblSubMilesCostId;
  double? mtdProgress;
  double? ytdProgress;
  String? status;

  GetVMAVEGETATIONCREWFORM(
      {this.contractYear,
      this.milesCompleted,
      this.feeder,
      this.county,
      this.nextMaintDue,
      this.type,
      this.fileUpload,
      this.cycle,
      this.performanceType,
      this.adminNotes1,
      this.crew,
      this.precip,
      this.milesInProgress,
      this.maintType,
      this.street,
      this.substation,
      this.rowMethod,
      this.id,
      this.delayReason,
      this.createDate,
      this.contractorCompany,
      this.temp,
      this.milesPending,
      this.delayCause,
      this.totalMiles,
      this.effectedNoOfDays,
      this.wtdProgress,
      this.tblSubMilesCostId,
      this.mtdProgress,
      this.ytdProgress,
      this.status});

  GetVMAVEGETATIONCREWFORM.fromJson(Map<String, dynamic> json) {
    contractYear = json['contractYear'];
    milesCompleted = json['milesCompleted'];
    feeder = json['feeder'];
    county = json['county'];
    nextMaintDue = json['nextMaintDue'];
    type = json['type'];
    fileUpload = json['fileUpload'];
    cycle = json['cycle'];
    performanceType = json['performanceType'];
    adminNotes1 = json['adminNotes1'];
    crew = json['crew'];
    precip = json['precip'];
    milesInProgress = json['milesInProgress'];
    maintType = json['maintType'];
    street = json['street'];
    substation = json['substation'];
    rowMethod = json['rowMethod'];
    id = json['id'];
    delayReason = json['delayReason'];
    createDate = json['createDate'];
    contractorCompany = json['contractorCompany'];
    temp = json['temp'];
    milesPending = json['milesPending'];
    delayCause = json['delayCause'];
    totalMiles = json['totalMiles'];
    effectedNoOfDays = json['effectedNoOfDays'];
    wtdProgress = json['wtdProgress'];
    tblSubMilesCostId = json['tblSubMilesCostId'];
    mtdProgress = json['mtdProgress'];
    ytdProgress = json['ytdProgress'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['contractYear'] = contractYear;
    data['milesCompleted'] = milesCompleted;
    data['feeder'] = feeder;
    data['county'] = county;
    data['nextMaintDue'] = nextMaintDue;
    data['type'] = type;
    data['fileUpload'] = fileUpload;
    data['cycle'] = cycle;
    data['performanceType'] = performanceType;
    data['adminNotes1'] = adminNotes1;
    data['crew'] = crew;
    data['precip'] = precip;
    data['milesInProgress'] = milesInProgress;
    data['maintType'] = maintType;
    data['street'] = street;
    data['substation'] = substation;
    data['rowMethod'] = rowMethod;
    data['id'] = id;
    data['delayReason'] = delayReason;
    data['createDate'] = createDate;
    data['contractorCompany'] = contractorCompany;
    data['temp'] = temp;
    data['milesPending'] = milesPending;
    data['delayCause'] = delayCause;
    data['totalMiles'] = totalMiles;
    data['effectedNoOfDays'] = effectedNoOfDays;
    data['wtdProgress'] = wtdProgress;
    data['tblSubMilesCostId'] = tblSubMilesCostId;
    data['mtdProgress'] = mtdProgress;
    data['ytdProgress'] = ytdProgress;
    data['status'] = status;
    return data;
  }
}

class FindAllSubstation {
  String? substation;
  int? id;

  FindAllSubstation({this.substation, this.id});

  FindAllSubstation.fromJson(Map<String, dynamic> json) {
    substation = json['substation'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['substation'] = substation;
    data['id'] = id;
    return data;
  }
}
