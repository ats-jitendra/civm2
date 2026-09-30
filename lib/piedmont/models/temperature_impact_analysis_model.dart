class TemperatureImpactAnalysisModel {
  List<GetSPOUTAGECOUNTBYPRECBYSUBSTATION>? getSPOUTAGECOUNTBYPRECBYSUBSTATION;
  List<FindsCustomerCountBySubstation>? findsCustomerCountBySubstation;
  List<FindsFdrNameAndIdsBySubstation>? findsFdrNameAndIdsBySubstation;
  List<GetVMAVEGETATIONCREWFORM>? getVMAVEGETATIONCREWFORM;
  List<FindsCustomerCountByDelayCauseAndCountyAndSubstationAndFdrs>?
      findsCustomerCountByDelayCauseAndCountyAndSubstationAndFdrs;
  List<FindNextMaintDueByCountySubstationFeederDelayCause>?
      findNextMaintDueByCountySubstationFeederDelayCause;
  List<GetSPOUTAGECOUNTBYTEMPBYSUBSTATION>? getSPOUTAGECOUNTBYTEMPBYSUBSTATION;
  List<FindCustomerCountOfTmpImpactAnalysisPages>?
      findCustomerCountOfTmpImpactAnalysisPages;
  List<FindsCustomerCountBySubstationAndFeeder>?
      findsCustomerCountBySubstationAndFeeder;
  List<FindSubstationsByCountyOfTmpImpactAnalysisPage>?
      findSubstationsByCountyOfTmpImpactAnalysisPage;
  List<FindsDelayCauseBySubstationAndFdrOfTmpImpactAnalysisPage>?
      findsDelayCauseBySubstationAndFdrOfTmpImpactAnalysisPage;

  TemperatureImpactAnalysisModel(
      {this.getSPOUTAGECOUNTBYPRECBYSUBSTATION,
      this.findsCustomerCountBySubstation,
      this.findsFdrNameAndIdsBySubstation,
      this.getVMAVEGETATIONCREWFORM,
      this.findsCustomerCountByDelayCauseAndCountyAndSubstationAndFdrs,
      this.findNextMaintDueByCountySubstationFeederDelayCause,
      this.getSPOUTAGECOUNTBYTEMPBYSUBSTATION,
      this.findCustomerCountOfTmpImpactAnalysisPages,
      this.findsCustomerCountBySubstationAndFeeder,
      this.findSubstationsByCountyOfTmpImpactAnalysisPage,
      this.findsDelayCauseBySubstationAndFdrOfTmpImpactAnalysisPage});

  TemperatureImpactAnalysisModel.fromJson(Map<String, dynamic> json) {
    if (json['getSP_OUTAGE_COUNT_BY_PREC_BY_SUBSTATION'] != null) {
      getSPOUTAGECOUNTBYPRECBYSUBSTATION =
          <GetSPOUTAGECOUNTBYPRECBYSUBSTATION>[];
      json['getSP_OUTAGE_COUNT_BY_PREC_BY_SUBSTATION'].forEach((v) {
        getSPOUTAGECOUNTBYPRECBYSUBSTATION!
            .add(GetSPOUTAGECOUNTBYPRECBYSUBSTATION.fromJson(v));
      });
    }
    if (json['findsCustomerCountBySubstation'] != null) {
      findsCustomerCountBySubstation = <FindsCustomerCountBySubstation>[];
      json['findsCustomerCountBySubstation'].forEach((v) {
        findsCustomerCountBySubstation!
            .add(FindsCustomerCountBySubstation.fromJson(v));
      });
    }
    if (json['findsFdrNameAndIdsBySubstation'] != null) {
      findsFdrNameAndIdsBySubstation = <FindsFdrNameAndIdsBySubstation>[];
      json['findsFdrNameAndIdsBySubstation'].forEach((v) {
        findsFdrNameAndIdsBySubstation!
            .add(FindsFdrNameAndIdsBySubstation.fromJson(v));
      });
    }
    if (json['getVMA_VEGETATION_CREWFORM'] != null) {
      getVMAVEGETATIONCREWFORM = <GetVMAVEGETATIONCREWFORM>[];
      json['getVMA_VEGETATION_CREWFORM'].forEach((v) {
        getVMAVEGETATIONCREWFORM!.add(GetVMAVEGETATIONCREWFORM.fromJson(v));
      });
    }
    if (json['findsCustomerCountByDelayCauseAndCountyAndSubstationAndFdrs'] !=
        null) {
      findsCustomerCountByDelayCauseAndCountyAndSubstationAndFdrs =
          <FindsCustomerCountByDelayCauseAndCountyAndSubstationAndFdrs>[];
      json['findsCustomerCountByDelayCauseAndCountyAndSubstationAndFdrs']
          .forEach((v) {
        findsCustomerCountByDelayCauseAndCountyAndSubstationAndFdrs!.add(
            FindsCustomerCountByDelayCauseAndCountyAndSubstationAndFdrs
                .fromJson(v));
      });
    }
    if (json['findNextMaintDueByCountySubstationFeederDelayCause'] != null) {
      findNextMaintDueByCountySubstationFeederDelayCause =
          <FindNextMaintDueByCountySubstationFeederDelayCause>[];
      json['findNextMaintDueByCountySubstationFeederDelayCause'].forEach((v) {
        findNextMaintDueByCountySubstationFeederDelayCause!.add(
            FindNextMaintDueByCountySubstationFeederDelayCause.fromJson(v));
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
    if (json['findCustomerCountOfTmpImpactAnalysisPages'] != null) {
      findCustomerCountOfTmpImpactAnalysisPages =
          <FindCustomerCountOfTmpImpactAnalysisPages>[];
      json['findCustomerCountOfTmpImpactAnalysisPages'].forEach((v) {
        findCustomerCountOfTmpImpactAnalysisPages!
            .add(FindCustomerCountOfTmpImpactAnalysisPages.fromJson(v));
      });
    }
    if (json['findsCustomer_CountBySubstationAndFeeder'] != null) {
      findsCustomerCountBySubstationAndFeeder =
          <FindsCustomerCountBySubstationAndFeeder>[];
      json['findsCustomer_CountBySubstationAndFeeder'].forEach((v) {
        findsCustomerCountBySubstationAndFeeder!
            .add(FindsCustomerCountBySubstationAndFeeder.fromJson(v));
      });
    }
    if (json['findSubstationsByCountyOfTmpImpactAnalysisPage'] != null) {
      findSubstationsByCountyOfTmpImpactAnalysisPage =
          <FindSubstationsByCountyOfTmpImpactAnalysisPage>[];
      json['findSubstationsByCountyOfTmpImpactAnalysisPage'].forEach((v) {
        findSubstationsByCountyOfTmpImpactAnalysisPage!.add(
            FindSubstationsByCountyOfTmpImpactAnalysisPage.fromJson(v));
      });
    }
    if (json['findsDelayCauseBySubstationAndFdrOfTmpImpactAnalysisPage'] !=
        null) {
      findsDelayCauseBySubstationAndFdrOfTmpImpactAnalysisPage =
          <FindsDelayCauseBySubstationAndFdrOfTmpImpactAnalysisPage>[];
      json['findsDelayCauseBySubstationAndFdrOfTmpImpactAnalysisPage']
          .forEach((v) {
        findsDelayCauseBySubstationAndFdrOfTmpImpactAnalysisPage!.add(
            FindsDelayCauseBySubstationAndFdrOfTmpImpactAnalysisPage
                .fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (getSPOUTAGECOUNTBYPRECBYSUBSTATION != null) {
      data['getSP_OUTAGE_COUNT_BY_PREC_BY_SUBSTATION'] = getSPOUTAGECOUNTBYPRECBYSUBSTATION!
          .map((v) => v.toJson())
          .toList();
    }
    if (findsCustomerCountBySubstation != null) {
      data['findsCustomerCountBySubstation'] =
          findsCustomerCountBySubstation!.map((v) => v.toJson()).toList();
    }
    if (findsFdrNameAndIdsBySubstation != null) {
      data['findsFdrNameAndIdsBySubstation'] =
          findsFdrNameAndIdsBySubstation!.map((v) => v.toJson()).toList();
    }
    if (getVMAVEGETATIONCREWFORM != null) {
      data['getVMA_VEGETATION_CREWFORM'] =
          getVMAVEGETATIONCREWFORM!.map((v) => v.toJson()).toList();
    }
    if (findsCustomerCountByDelayCauseAndCountyAndSubstationAndFdrs !=
        null) {
      data['findsCustomerCountByDelayCauseAndCountyAndSubstationAndFdrs'] = findsCustomerCountByDelayCauseAndCountyAndSubstationAndFdrs!
          .map((v) => v.toJson())
          .toList();
    }
    if (findNextMaintDueByCountySubstationFeederDelayCause != null) {
      data['findNextMaintDueByCountySubstationFeederDelayCause'] = findNextMaintDueByCountySubstationFeederDelayCause!
          .map((v) => v.toJson())
          .toList();
    }
    if (getSPOUTAGECOUNTBYTEMPBYSUBSTATION != null) {
      data['getSP_OUTAGE_COUNT_BY_TEMP_BY_SUBSTATION'] = getSPOUTAGECOUNTBYTEMPBYSUBSTATION!
          .map((v) => v.toJson())
          .toList();
    }
    if (findCustomerCountOfTmpImpactAnalysisPages != null) {
      data['findCustomerCountOfTmpImpactAnalysisPages'] = findCustomerCountOfTmpImpactAnalysisPages!
          .map((v) => v.toJson())
          .toList();
    }
    if (findsCustomerCountBySubstationAndFeeder != null) {
      data['findsCustomer_CountBySubstationAndFeeder'] = findsCustomerCountBySubstationAndFeeder!
          .map((v) => v.toJson())
          .toList();
    }
    if (findSubstationsByCountyOfTmpImpactAnalysisPage != null) {
      data['findSubstationsByCountyOfTmpImpactAnalysisPage'] = findSubstationsByCountyOfTmpImpactAnalysisPage!
          .map((v) => v.toJson())
          .toList();
    }
    if (findsDelayCauseBySubstationAndFdrOfTmpImpactAnalysisPage != null) {
      data['findsDelayCauseBySubstationAndFdrOfTmpImpactAnalysisPage'] = findsDelayCauseBySubstationAndFdrOfTmpImpactAnalysisPage!
          .map((v) => v.toJson())
          .toList();
    }
    return data;
  }
}

class FindsDelayCauseBySubstationAndFdrOfTmpImpactAnalysisPage {
  String? delayCause;

  FindsDelayCauseBySubstationAndFdrOfTmpImpactAnalysisPage({this.delayCause});

  FindsDelayCauseBySubstationAndFdrOfTmpImpactAnalysisPage.fromJson(
      Map<String, dynamic> json) {
    delayCause = json['delayCause'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['delayCause'] = delayCause;
    return data;
  }
}

class FindNextMaintDueByCountySubstationFeederDelayCause {
  String? nextMaintDue;

  FindNextMaintDueByCountySubstationFeederDelayCause({this.nextMaintDue});

  FindNextMaintDueByCountySubstationFeederDelayCause.fromJson(
      Map<String, dynamic> json) {
    nextMaintDue = json['nextMaintDue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nextMaintDue'] = nextMaintDue;
    return data;
  }
}

class FindsCustomerCountBySubstationAndFeeder {
  double? customerCount;

  FindsCustomerCountBySubstationAndFeeder({this.customerCount});

  FindsCustomerCountBySubstationAndFeeder.fromJson(Map<String, dynamic> json) {
    customerCount = json['customerCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['customerCount'] = customerCount;
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

class FindsCustomerCountByDelayCauseAndCountyAndSubstationAndFdrs {
  double? customerCount;

  FindsCustomerCountByDelayCauseAndCountyAndSubstationAndFdrs(
      {this.customerCount});

  FindsCustomerCountByDelayCauseAndCountyAndSubstationAndFdrs.fromJson(
      Map<String, dynamic> json) {
    customerCount = json['customerCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['customerCount'] = customerCount;
    return data;
  }
}

class FindsFdrNameAndIdsBySubstation {
  String? fdrName;
  int? id;

  FindsFdrNameAndIdsBySubstation({this.fdrName, this.id});

  FindsFdrNameAndIdsBySubstation.fromJson(Map<String, dynamic> json) {
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

class FindsCustomerCountBySubstation {
  double? customerCount;

  FindsCustomerCountBySubstation({this.customerCount});

  FindsCustomerCountBySubstation.fromJson(Map<String, dynamic> json) {
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

class FindCustomerCountOfTmpImpactAnalysisPages {
  double? customerCount;

  FindCustomerCountOfTmpImpactAnalysisPages({this.customerCount});

  FindCustomerCountOfTmpImpactAnalysisPages.fromJson(
      Map<String, dynamic> json) {
    customerCount = json['customerCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['customerCount'] = customerCount;
    return data;
  }
}

class FindSubstationsByCountyOfTmpImpactAnalysisPage {
  String? substation;
  int? id;

  FindSubstationsByCountyOfTmpImpactAnalysisPage({this.substation, this.id});

  FindSubstationsByCountyOfTmpImpactAnalysisPage.fromJson(
      Map<String, dynamic> json) {
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
