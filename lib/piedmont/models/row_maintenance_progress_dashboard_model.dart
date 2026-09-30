class RowMaintenanceProgressDashboardModel {
  List<GetSPAGGMILESFORDISTINCTTYPEBYMNTH>? getSPAGGMILESFORDISTINCTTYPEBYMNTH;
  List<GetSPAGGMILESFORDISTINCTTYPE>? getSPAGGMILESFORDISTINCTTYPE;
  List<FindDelayReasonAndCrew1EFFECTEDNOOFDAYS1EFFECTEDNOOFDAYS2and3>?
      findDelayReasonAndCrew1EFFECTEDNOOFDAYS1EFFECTEDNOOFDAYS2and3;
  List<RowMaintenanceData>? rowMaintenanceData;
  List<AffectedDaysByWeatherDelayList>? affectedDaysByWeatherDelayList;
  List<AffectedDaysByOtherIssuesList>? affectedDaysByOtherIssuesList;
  List<FindUNDERPERFORMANCEAndINLINEPERFORMANCEOVERPERFORMANCE>?
      findUNDERPERFORMANCEAndINLINEPERFORMANCEOVERPERFORMANCE;
  List<PercentAndStatus>? percentAndStatus;
  List<FindDelayCouseAndCrew1EFFECTEDNOOFDAYS1EFFECTEDNOOFDAYS2and3>?
      findDelayCouseAndCrew1EFFECTEDNOOFDAYS1EFFECTEDNOOFDAYS2and3;
  List<FindDelayReasonAndCrew1EFFECTEDNOOFDAYS1EFFECTEDNOOFDAYS2and3ByDELAYCAUSE>?
      findDelayReasonAndCrew1EFFECTEDNOOFDAYS1EFFECTEDNOOFDAYS2and3ByDELAYCAUSE;
  List<FindCrewMilesCompletedAndMilesInProgress>?
      findCrewMilesCompletedAndMilesInProgress;
  List<FindAffectedDaysByOtherIssuesAndCrew1EFFECTEDNOOFDAYS1EFFECTEDNOOFDAYS2and3ByDELAYCAUSE>?
      findAffectedDaysByOtherIssuesAndCrew1EFFECTEDNOOFDAYS1EFFECTEDNOOFDAYS2and3ByDELAYCAUSE;
  List<AffectedDaysByCausesList>? affectedDaysByCausesList;

  RowMaintenanceProgressDashboardModel(
      {this.getSPAGGMILESFORDISTINCTTYPEBYMNTH,
      this.getSPAGGMILESFORDISTINCTTYPE,
      this.findDelayReasonAndCrew1EFFECTEDNOOFDAYS1EFFECTEDNOOFDAYS2and3,
      this.rowMaintenanceData,
      this.affectedDaysByWeatherDelayList,
      this.affectedDaysByOtherIssuesList,
      this.findUNDERPERFORMANCEAndINLINEPERFORMANCEOVERPERFORMANCE,
      this.percentAndStatus,
      this.findDelayCouseAndCrew1EFFECTEDNOOFDAYS1EFFECTEDNOOFDAYS2and3,
      this.findDelayReasonAndCrew1EFFECTEDNOOFDAYS1EFFECTEDNOOFDAYS2and3ByDELAYCAUSE,
      this.findCrewMilesCompletedAndMilesInProgress,
      this.findAffectedDaysByOtherIssuesAndCrew1EFFECTEDNOOFDAYS1EFFECTEDNOOFDAYS2and3ByDELAYCAUSE,
      this.affectedDaysByCausesList});

  RowMaintenanceProgressDashboardModel.fromJson(Map<String, dynamic> json) {
    if (json['getSP_AGG_MILES_FOR_DISTINCT_TYPE_BY_MNTH'] != null) {
      getSPAGGMILESFORDISTINCTTYPEBYMNTH =
          <GetSPAGGMILESFORDISTINCTTYPEBYMNTH>[];
      json['getSP_AGG_MILES_FOR_DISTINCT_TYPE_BY_MNTH'].forEach((v) {
        getSPAGGMILESFORDISTINCTTYPEBYMNTH!
            .add(GetSPAGGMILESFORDISTINCTTYPEBYMNTH.fromJson(v));
      });
    }
    if (json['getSP_AGG_MILES_FOR_DISTINCT_TYPE'] != null) {
      getSPAGGMILESFORDISTINCTTYPE = <GetSPAGGMILESFORDISTINCTTYPE>[];
      json['getSP_AGG_MILES_FOR_DISTINCT_TYPE'].forEach((v) {
        getSPAGGMILESFORDISTINCTTYPE!
            .add(GetSPAGGMILESFORDISTINCTTYPE.fromJson(v));
      });
    }
    if (json[
            'findDelayReasonAndCrew1EFFECTED_NO_OF_DAYS_1_EFFECTED_NO_OF_DAYS_2and3'] !=
        null) {
      findDelayReasonAndCrew1EFFECTEDNOOFDAYS1EFFECTEDNOOFDAYS2and3 =
          <FindDelayReasonAndCrew1EFFECTEDNOOFDAYS1EFFECTEDNOOFDAYS2and3>[];
      json['findDelayReasonAndCrew1EFFECTED_NO_OF_DAYS_1_EFFECTED_NO_OF_DAYS_2and3']
          .forEach((v) {
        findDelayReasonAndCrew1EFFECTEDNOOFDAYS1EFFECTEDNOOFDAYS2and3!.add(
            FindDelayReasonAndCrew1EFFECTEDNOOFDAYS1EFFECTEDNOOFDAYS2and3
                .fromJson(v));
      });
    }
    if (json['row_maintenance_data'] != null) {
      rowMaintenanceData = <RowMaintenanceData>[];
      json['row_maintenance_data'].forEach((v) {
        rowMaintenanceData!.add(RowMaintenanceData.fromJson(v));
      });
    }
    if (json['AffectedDaysByWeatherDelayList'] != null) {
      affectedDaysByWeatherDelayList = <AffectedDaysByWeatherDelayList>[];
      json['AffectedDaysByWeatherDelayList'].forEach((v) {
        affectedDaysByWeatherDelayList!
            .add(AffectedDaysByWeatherDelayList.fromJson(v));
      });
    }
    if (json['affectedDaysByOtherIssuesList'] != null) {
      affectedDaysByOtherIssuesList = <AffectedDaysByOtherIssuesList>[];
      json['affectedDaysByOtherIssuesList'].forEach((v) {
        affectedDaysByOtherIssuesList!
            .add(AffectedDaysByOtherIssuesList.fromJson(v));
      });
    }
    if (json['findUNDER_PERFORMANCE_And_INLINE_PERFORMANCE_OVER_PERFORMANCE'] !=
        null) {
      findUNDERPERFORMANCEAndINLINEPERFORMANCEOVERPERFORMANCE =
          <FindUNDERPERFORMANCEAndINLINEPERFORMANCEOVERPERFORMANCE>[];
      json['findUNDER_PERFORMANCE_And_INLINE_PERFORMANCE_OVER_PERFORMANCE']
          .forEach((v) {
        findUNDERPERFORMANCEAndINLINEPERFORMANCEOVERPERFORMANCE!.add(
            FindUNDERPERFORMANCEAndINLINEPERFORMANCEOVERPERFORMANCE.fromJson(
                v));
      });
    }
    if (json['percentAndStatus'] != null) {
      percentAndStatus = <PercentAndStatus>[];
      json['percentAndStatus'].forEach((v) {
        percentAndStatus!.add(PercentAndStatus.fromJson(v));
      });
    }
    if (json[
            'findDelayCouseAndCrew1EFFECTED_NO_OF_DAYS_1_EFFECTED_NO_OF_DAYS_2and3'] !=
        null) {
      findDelayCouseAndCrew1EFFECTEDNOOFDAYS1EFFECTEDNOOFDAYS2and3 =
          <FindDelayCouseAndCrew1EFFECTEDNOOFDAYS1EFFECTEDNOOFDAYS2and3>[];
      json['findDelayCouseAndCrew1EFFECTED_NO_OF_DAYS_1_EFFECTED_NO_OF_DAYS_2and3']
          .forEach((v) {
        findDelayCouseAndCrew1EFFECTEDNOOFDAYS1EFFECTEDNOOFDAYS2and3!.add(
            FindDelayCouseAndCrew1EFFECTEDNOOFDAYS1EFFECTEDNOOFDAYS2and3
                .fromJson(v));
      });
    }
    if (json[
            'findDelayReasonAndCrew1EFFECTED_NO_OF_DAYS_1_EFFECTED_NO_OF_DAYS_2and3ByDELAY_CAUSE'] !=
        null) {
      findDelayReasonAndCrew1EFFECTEDNOOFDAYS1EFFECTEDNOOFDAYS2and3ByDELAYCAUSE =
          <FindDelayReasonAndCrew1EFFECTEDNOOFDAYS1EFFECTEDNOOFDAYS2and3ByDELAYCAUSE>[];
      json['findDelayReasonAndCrew1EFFECTED_NO_OF_DAYS_1_EFFECTED_NO_OF_DAYS_2and3ByDELAY_CAUSE']
          .forEach((v) {
        findDelayReasonAndCrew1EFFECTEDNOOFDAYS1EFFECTEDNOOFDAYS2and3ByDELAYCAUSE!
            .add(
                FindDelayReasonAndCrew1EFFECTEDNOOFDAYS1EFFECTEDNOOFDAYS2and3ByDELAYCAUSE
                    .fromJson(v));
      });
    }
    if (json['findCrewMilesCompletedAndMilesInProgress'] != null) {
      findCrewMilesCompletedAndMilesInProgress =
          <FindCrewMilesCompletedAndMilesInProgress>[];
      json['findCrewMilesCompletedAndMilesInProgress'].forEach((v) {
        findCrewMilesCompletedAndMilesInProgress!
            .add(FindCrewMilesCompletedAndMilesInProgress.fromJson(v));
      });
    }
    if (json[
            'findAffectedDaysByOtherIssuesAndCrew1EFFECTED_NO_OF_DAYS_1_EFFECTED_NO_OF_DAYS_2and3ByDELAY_CAUSE'] !=
        null) {
      findAffectedDaysByOtherIssuesAndCrew1EFFECTEDNOOFDAYS1EFFECTEDNOOFDAYS2and3ByDELAYCAUSE =
          <FindAffectedDaysByOtherIssuesAndCrew1EFFECTEDNOOFDAYS1EFFECTEDNOOFDAYS2and3ByDELAYCAUSE>[];
      json['findAffectedDaysByOtherIssuesAndCrew1EFFECTED_NO_OF_DAYS_1_EFFECTED_NO_OF_DAYS_2and3ByDELAY_CAUSE']
          .forEach((v) {
        findAffectedDaysByOtherIssuesAndCrew1EFFECTEDNOOFDAYS1EFFECTEDNOOFDAYS2and3ByDELAYCAUSE!
            .add(
                FindAffectedDaysByOtherIssuesAndCrew1EFFECTEDNOOFDAYS1EFFECTEDNOOFDAYS2and3ByDELAYCAUSE
                    .fromJson(v));
      });
    }
    if (json['affectedDaysByCausesList'] != null) {
      affectedDaysByCausesList = <AffectedDaysByCausesList>[];
      json['affectedDaysByCausesList'].forEach((v) {
        affectedDaysByCausesList!.add(AffectedDaysByCausesList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (getSPAGGMILESFORDISTINCTTYPEBYMNTH != null) {
      data['getSP_AGG_MILES_FOR_DISTINCT_TYPE_BY_MNTH'] =
          getSPAGGMILESFORDISTINCTTYPEBYMNTH!.map((v) => v.toJson()).toList();
    }
    if (getSPAGGMILESFORDISTINCTTYPE != null) {
      data['getSP_AGG_MILES_FOR_DISTINCT_TYPE'] =
          getSPAGGMILESFORDISTINCTTYPE!.map((v) => v.toJson()).toList();
    }
    if (findDelayReasonAndCrew1EFFECTEDNOOFDAYS1EFFECTEDNOOFDAYS2and3 != null) {
      data['findDelayReasonAndCrew1EFFECTED_NO_OF_DAYS_1_EFFECTED_NO_OF_DAYS_2and3'] =
          findDelayReasonAndCrew1EFFECTEDNOOFDAYS1EFFECTEDNOOFDAYS2and3!
              .map((v) => v.toJson())
              .toList();
    }
    if (rowMaintenanceData != null) {
      data['row_maintenance_data'] =
          rowMaintenanceData!.map((v) => v.toJson()).toList();
    }
    if (affectedDaysByWeatherDelayList != null) {
      data['AffectedDaysByWeatherDelayList'] =
          affectedDaysByWeatherDelayList!.map((v) => v.toJson()).toList();
    }
    if (affectedDaysByOtherIssuesList != null) {
      data['affectedDaysByOtherIssuesList'] =
          affectedDaysByOtherIssuesList!.map((v) => v.toJson()).toList();
    }
    if (findUNDERPERFORMANCEAndINLINEPERFORMANCEOVERPERFORMANCE != null) {
      data['findUNDER_PERFORMANCE_And_INLINE_PERFORMANCE_OVER_PERFORMANCE'] =
          findUNDERPERFORMANCEAndINLINEPERFORMANCEOVERPERFORMANCE!
              .map((v) => v.toJson())
              .toList();
    }
    if (percentAndStatus != null) {
      data['percentAndStatus'] =
          percentAndStatus!.map((v) => v.toJson()).toList();
    }
    if (findDelayCouseAndCrew1EFFECTEDNOOFDAYS1EFFECTEDNOOFDAYS2and3 != null) {
      data['findDelayCouseAndCrew1EFFECTED_NO_OF_DAYS_1_EFFECTED_NO_OF_DAYS_2and3'] =
          findDelayCouseAndCrew1EFFECTEDNOOFDAYS1EFFECTEDNOOFDAYS2and3!
              .map((v) => v.toJson())
              .toList();
    }
    if (findDelayReasonAndCrew1EFFECTEDNOOFDAYS1EFFECTEDNOOFDAYS2and3ByDELAYCAUSE !=
        null) {
      data['findDelayReasonAndCrew1EFFECTED_NO_OF_DAYS_1_EFFECTED_NO_OF_DAYS_2and3ByDELAY_CAUSE'] =
          findDelayReasonAndCrew1EFFECTEDNOOFDAYS1EFFECTEDNOOFDAYS2and3ByDELAYCAUSE!
              .map((v) => v.toJson())
              .toList();
    }
    if (findCrewMilesCompletedAndMilesInProgress != null) {
      data['findCrewMilesCompletedAndMilesInProgress'] =
          findCrewMilesCompletedAndMilesInProgress!
              .map((v) => v.toJson())
              .toList();
    }
    if (findAffectedDaysByOtherIssuesAndCrew1EFFECTEDNOOFDAYS1EFFECTEDNOOFDAYS2and3ByDELAYCAUSE !=
        null) {
      data['findAffectedDaysByOtherIssuesAndCrew1EFFECTED_NO_OF_DAYS_1_EFFECTED_NO_OF_DAYS_2and3ByDELAY_CAUSE'] =
          findAffectedDaysByOtherIssuesAndCrew1EFFECTEDNOOFDAYS1EFFECTEDNOOFDAYS2and3ByDELAYCAUSE!
              .map((v) => v.toJson())
              .toList();
    }
    if (affectedDaysByCausesList != null) {
      data['affectedDaysByCausesList'] =
          affectedDaysByCausesList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FindAffectedDaysByOtherIssuesAndCrew1EFFECTEDNOOFDAYS1EFFECTEDNOOFDAYS2and3ByDELAYCAUSE {
  String? crew1;
  String? crew2;
  double? effectedNoOfDays1;
  String? crew3;
  String? delayReason;
  double? effectedNoOfDays2;
  double? effectedNoOfDays3;

  FindAffectedDaysByOtherIssuesAndCrew1EFFECTEDNOOFDAYS1EFFECTEDNOOFDAYS2and3ByDELAYCAUSE(
      {this.crew1,
      this.crew2,
      this.effectedNoOfDays1,
      this.crew3,
      this.delayReason,
      this.effectedNoOfDays2,
      this.effectedNoOfDays3});

  FindAffectedDaysByOtherIssuesAndCrew1EFFECTEDNOOFDAYS1EFFECTEDNOOFDAYS2and3ByDELAYCAUSE.fromJson(
      Map<String, dynamic> json) {
    crew1 = json['crew1'];
    crew2 = json['crew2'];
    effectedNoOfDays1 = json['effectedNoOfDays1'];
    crew3 = json['crew3'];
    delayReason = json['delayReason'];
    effectedNoOfDays2 = json['effectedNoOfDays2'];
    effectedNoOfDays3 = json['effectedNoOfDays3'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['crew1'] = crew1;
    data['crew2'] = crew2;
    data['effectedNoOfDays1'] = effectedNoOfDays1;
    data['crew3'] = crew3;
    data['delayReason'] = delayReason;
    data['effectedNoOfDays2'] = effectedNoOfDays2;
    data['effectedNoOfDays3'] = effectedNoOfDays3;
    return data;
  }
}

class FindDelayReasonAndCrew1EFFECTEDNOOFDAYS1EFFECTEDNOOFDAYS2and3ByDELAYCAUSE {
  FindDelayReasonAndCrew1EFFECTEDNOOFDAYS1EFFECTEDNOOFDAYS2and3ByDELAYCAUSE.fromJson(
      v);

  toJson() {}
}

class GetSPAGGMILESFORDISTINCTTYPEBYMNTH {
  String? monthName;
  double? aggMiles;
  String? type;

  GetSPAGGMILESFORDISTINCTTYPEBYMNTH(
      {this.monthName, this.aggMiles, this.type});

  GetSPAGGMILESFORDISTINCTTYPEBYMNTH.fromJson(Map<String, dynamic> json) {
    monthName = json['monthName'];
    aggMiles = json['aggMiles'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['monthName'] = monthName;
    data['aggMiles'] = aggMiles;
    data['type'] = type;
    return data;
  }
}

class GetSPAGGMILESFORDISTINCTTYPE {
  int? year;
  double? aggMiles;
  String? type;
  String? percentage;

  GetSPAGGMILESFORDISTINCTTYPE(
      {this.year, this.aggMiles, this.type, this.percentage});

  GetSPAGGMILESFORDISTINCTTYPE.fromJson(Map<String, dynamic> json) {
    year = json['year'];
    aggMiles = json['aggMiles'];
    type = json['type'];
    percentage = json['percentage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['year'] = year;
    data['aggMiles'] = aggMiles;
    data['type'] = type;
    data['percentage'] = percentage;
    return data;
  }
}

class FindDelayReasonAndCrew1EFFECTEDNOOFDAYS1EFFECTEDNOOFDAYS2and3 {
  String? crew1;
  String? crew2;
  double? effectedNoOfDays1;
  String? crew3;
  String? delayReason;
  double? effectedNoOfDays2;
  double? effectedNoOfDays3;

  FindDelayReasonAndCrew1EFFECTEDNOOFDAYS1EFFECTEDNOOFDAYS2and3(
      {this.crew1,
      this.crew2,
      this.effectedNoOfDays1,
      this.crew3,
      this.delayReason,
      this.effectedNoOfDays2,
      this.effectedNoOfDays3});

  FindDelayReasonAndCrew1EFFECTEDNOOFDAYS1EFFECTEDNOOFDAYS2and3.fromJson(
      Map<String, dynamic> json) {
    crew1 = json['crew1'];
    crew2 = json['crew2'];
    effectedNoOfDays1 = json['effectedNoOfDays1'];
    crew3 = json['crew3'];
    delayReason = json['delayReason'];
    effectedNoOfDays2 = json['effectedNoOfDays2'];
    effectedNoOfDays3 = json['effectedNoOfDays3'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['crew1'] = crew1;
    data['crew2'] = crew2;
    data['effectedNoOfDays1'] = effectedNoOfDays1;
    data['crew3'] = crew3;
    data['delayReason'] = delayReason;
    data['effectedNoOfDays2'] = effectedNoOfDays2;
    data['effectedNoOfDays3'] = effectedNoOfDays3;
    return data;
  }
}

class RowMaintenanceData {
  String? budgetType;
  String? contractor;
  double? costPerMile;
  String? contractYear;
  double? milesCompleted;
  String? feeder;
  int? tokenNo;
  String? subStationName;
  String? type;
  String? cycle;
  String? crew;
  String? adminNotes1;
  String? rowYear;
  double? milesInProgress;
  String? street;
  String? maintType;
  String? rowMethod;
  String? contractorNotes;
  int? id;
  String? delayReason;
  String? actualCost;
  double? milesPending;
  String? delayCause;
  String? estCost;
  String? totalMiles;
  String? contractorCompay;
  String? estTime;
  int? nextMaintYear;
  String? adminNotes2;
  double? effectedNoOfDays;
  int? lastRowYear;
  double? wtdProgress;
  double? mtdProgress;
  double? ytdProgress;
  double? totalCost;
  String? mapLocation;
  String? status;
  String? transmissionName;

  RowMaintenanceData(
      {this.budgetType,
      this.contractor,
      this.costPerMile,
      this.contractYear,
      this.milesCompleted,
      this.feeder,
      this.tokenNo,
      this.subStationName,
      this.type,
      this.cycle,
      this.crew,
      this.adminNotes1,
      this.rowYear,
      this.milesInProgress,
      this.street,
      this.maintType,
      this.rowMethod,
      this.contractorNotes,
      this.id,
      this.delayReason,
      this.actualCost,
      this.milesPending,
      this.delayCause,
      this.estCost,
      this.totalMiles,
      this.contractorCompay,
      this.estTime,
      this.nextMaintYear,
      this.adminNotes2,
      this.effectedNoOfDays,
      this.lastRowYear,
      this.wtdProgress,
      this.mtdProgress,
      this.ytdProgress,
      this.totalCost,
      this.mapLocation,
      this.status,
      this.transmissionName});

  RowMaintenanceData.fromJson(Map<String, dynamic> json) {
    budgetType = json['budgetType'];
    contractor = json['contractor'];
    costPerMile = json['costPerMile'];
    contractYear = json['contractYear'];
    milesCompleted = json['milesCompleted'];
    feeder = json['feeder'];
    tokenNo = json['tokenNo'];
    subStationName = json['subStationName'];
    type = json['type'];
    cycle = json['cycle'];
    crew = json['crew'];
    adminNotes1 = json['adminNotes1'];
    rowYear = json['rowYear'];
    milesInProgress = json['milesInProgress'];
    street = json['street'];
    maintType = json['maintType'];
    rowMethod = json['rowMethod'];
    contractorNotes = json['contractorNotes'];
    id = json['id'];
    delayReason = json['delayReason'];
    actualCost = json['actualCost'];
    milesPending = json['milesPending'];
    delayCause = json['delayCause'];
    estCost = json['estCost'];
    totalMiles = json['totalMiles'];
    contractorCompay = json['contractorCompay'];
    estTime = json['estTime'];
    nextMaintYear = json['nextMaintYear'];
    adminNotes2 = json['adminNotes2'];
    effectedNoOfDays = json['effectedNoOfDays'];
    lastRowYear = json['lastRowYear'];
    wtdProgress = json['wtdProgress'];
    mtdProgress = json['mtdProgress'];
    ytdProgress = json['ytdProgress'];
    totalCost = json['totalCost'];
    mapLocation = json['mapLocation'];
    status = json['status'];
    transmissionName = json['transmissionName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['budgetType'] = budgetType;
    data['contractor'] = contractor;
    data['costPerMile'] = costPerMile;
    data['contractYear'] = contractYear;
    data['milesCompleted'] = milesCompleted;
    data['feeder'] = feeder;
    data['tokenNo'] = tokenNo;
    data['subStationName'] = subStationName;
    data['type'] = type;
    data['cycle'] = cycle;
    data['crew'] = crew;
    data['adminNotes1'] = adminNotes1;
    data['rowYear'] = rowYear;
    data['milesInProgress'] = milesInProgress;
    data['street'] = street;
    data['maintType'] = maintType;
    data['rowMethod'] = rowMethod;
    data['contractorNotes'] = contractorNotes;
    data['id'] = id;
    data['delayReason'] = delayReason;
    data['actualCost'] = actualCost;
    data['milesPending'] = milesPending;
    data['delayCause'] = delayCause;
    data['estCost'] = estCost;
    data['totalMiles'] = totalMiles;
    data['contractorCompay'] = contractorCompay;
    data['estTime'] = estTime;
    data['nextMaintYear'] = nextMaintYear;
    data['adminNotes2'] = adminNotes2;
    data['effectedNoOfDays'] = effectedNoOfDays;
    data['lastRowYear'] = lastRowYear;
    data['wtdProgress'] = wtdProgress;
    data['mtdProgress'] = mtdProgress;
    data['ytdProgress'] = ytdProgress;
    data['totalCost'] = totalCost;
    data['mapLocation'] = mapLocation;
    data['status'] = status;
    data['transmissionName'] = transmissionName;
    return data;
  }
}

class AffectedDaysByWeatherDelayList {
  String? delayCause;
  String? crew1;
  String? crew2;
  String? crew3;
  String? crew4;
  String? crew5;
  double? effectedNoOfDays1;
  double? effectedNoOfDays2;
  double? effectedNoOfDays3;
  double? effectedNoOfDays4;
  double? effectedNoOfDays5;

  AffectedDaysByWeatherDelayList(
      {this.delayCause,
      this.crew1,
      this.crew2,
      this.crew3,
      this.crew4,
      this.crew5,
      this.effectedNoOfDays1,
      this.effectedNoOfDays2,
      this.effectedNoOfDays3,
      this.effectedNoOfDays4,
      this.effectedNoOfDays5});

  AffectedDaysByWeatherDelayList.fromJson(Map<String, dynamic> json) {
    delayCause = json['delayCause'];
    crew1 = json['crew1'];
    crew2 = json['crew2'];
    crew3 = json['crew3'];
    crew4 = json['crew4'];
    crew5 = json['crew5'];
    effectedNoOfDays1 = json['effectedNoOfDays1'];
    effectedNoOfDays2 = json['effectedNoOfDays2'];
    effectedNoOfDays3 = json['effectedNoOfDays3'];
    effectedNoOfDays4 = json['effectedNoOfDays4'];
    effectedNoOfDays5 = json['effectedNoOfDays5'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['delayCause'] = delayCause;
    data['crew1'] = crew1;
    data['crew2'] = crew2;
    data['effectedNoOfDays1'] = effectedNoOfDays1;
    data['effectedNoOfDays2'] = effectedNoOfDays2;
    return data;
  }
}

class AffectedDaysByCausesList {
  String? delayCause;
  String? crew1;
  String? crew2;
  String? crew3;
  String? crew4;
  String? crew5;
  double? effectedNoOfDays1;
  double? effectedNoOfDays2;
  double? effectedNoOfDays3;
  double? effectedNoOfDays4;
  double? effectedNoOfDays5;

  AffectedDaysByCausesList({
    this.delayCause,
    this.crew1,
    this.crew2,
    this.crew3,
    this.crew4,
    this.crew5,
    this.effectedNoOfDays1,
    this.effectedNoOfDays2,
    this.effectedNoOfDays3,
    this.effectedNoOfDays4,
    this.effectedNoOfDays5,
  });

  AffectedDaysByCausesList.fromJson(Map<String, dynamic> json) {
    delayCause = json['delayCause'];
    crew1 = json['crew1'];
    crew2 = json['crew2'];
    crew3 = json['crew3'];
    crew4 = json['crew4'];
    crew5 = json['crew5'];
    effectedNoOfDays1 = json['effectedNoOfDays1'];
    effectedNoOfDays2 = json['effectedNoOfDays2'];
    effectedNoOfDays3 = json['effectedNoOfDays3'];
    effectedNoOfDays4 = json['effectedNoOfDays4'];
    effectedNoOfDays5 = json['effectedNoOfDays5'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['delayCause'] = delayCause;
    data['crew1'] = crew1;
    data['crew2'] = crew2;
    data['crew3'] = crew3;
    data['crew4'] = crew4;
    data['crew5'] = crew5;
    data['effectedNoOfDays1'] = effectedNoOfDays1;
    data['effectedNoOfDays2'] = effectedNoOfDays2;
    data['effectedNoOfDays3'] = effectedNoOfDays3;
    data['effectedNoOfDays4'] = effectedNoOfDays4;
    data['effectedNoOfDays5'] = effectedNoOfDays5;

    return data;
  }
}

class AffectedDaysByOtherIssuesList {
  String? delayCause;
  String? crew1;
  String? crew2;
  String? crew3;
  String? crew4;
  String? crew5;
  double? effectedNoOfDays1;
  double? effectedNoOfDays2;
  double? effectedNoOfDays3;
  double? effectedNoOfDays4;
  double? effectedNoOfDays5;

  AffectedDaysByOtherIssuesList({
    this.delayCause,
    this.crew1,
    this.crew2,
    this.crew3,
    this.crew4,
    this.crew5,
    this.effectedNoOfDays1,
    this.effectedNoOfDays2,
    this.effectedNoOfDays3,
    this.effectedNoOfDays4,
    this.effectedNoOfDays5,
  });

  AffectedDaysByOtherIssuesList.fromJson(Map<String, dynamic> json) {
    delayCause = json['delayCause'];
    crew1 = json['crew1'];
    crew2 = json['crew2'];
    crew3 = json['crew3'];
    crew4 = json['crew4'];
    crew5 = json['crew5'];
    effectedNoOfDays1 = json['effectedNoOfDays1'];
    effectedNoOfDays2 = json['effectedNoOfDays2'];
    effectedNoOfDays3 = json['effectedNoOfDays3'];
    effectedNoOfDays4 = json['effectedNoOfDays4'];
    effectedNoOfDays5 = json['effectedNoOfDays5'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['delayCause'] = delayCause;
    data['crew1'] = crew1;
    data['crew2'] = crew2;
    data['crew3'] = crew3;
    data['crew4'] = crew4;
    data['crew5'] = crew5;
    data['effectedNoOfDays1'] = effectedNoOfDays1;
    data['effectedNoOfDays2'] = effectedNoOfDays2;
    data['effectedNoOfDays3'] = effectedNoOfDays3;
    data['effectedNoOfDays4'] = effectedNoOfDays4;
    data['effectedNoOfDays5'] = effectedNoOfDays5;
    return data;
  }
}

class FindUNDERPERFORMANCEAndINLINEPERFORMANCEOVERPERFORMANCE {
  int? lastRowYear;
  double? underPerformance;
  double? inlinePerformance;
  double? overPerformance;

  FindUNDERPERFORMANCEAndINLINEPERFORMANCEOVERPERFORMANCE(
      {this.lastRowYear,
      this.underPerformance,
      this.inlinePerformance,
      this.overPerformance});

  FindUNDERPERFORMANCEAndINLINEPERFORMANCEOVERPERFORMANCE.fromJson(
      Map<String, dynamic> json) {
    lastRowYear = json['lastRowYear'];
    underPerformance = json['underPerformance'];
    inlinePerformance = json['inlinePerformance'];
    overPerformance = json['overPerformance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lastRowYear'] = lastRowYear;
    data['underPerformance'] = underPerformance;
    data['inlinePerformance'] = inlinePerformance;
    data['overPerformance'] = overPerformance;
    return data;
  }
}

class PercentAndStatus {
  double? percentage;
  String? status;

  PercentAndStatus({this.percentage, this.status});

  PercentAndStatus.fromJson(Map<String, dynamic> json) {
    percentage = json['percentage'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['percentage'] = percentage;
    data['status'] = status;
    return data;
  }
}

class FindDelayCouseAndCrew1EFFECTEDNOOFDAYS1EFFECTEDNOOFDAYS2and3 {
  String? delayCause;
  String? crew1;
  String? crew2;
  double? effectedNoOfDays1;
  String? crew3;
  double? effectedNoOfDays2;
  double? effectedNoOfDays3;

  FindDelayCouseAndCrew1EFFECTEDNOOFDAYS1EFFECTEDNOOFDAYS2and3(
      {this.delayCause,
      this.crew1,
      this.crew2,
      this.effectedNoOfDays1,
      this.crew3,
      this.effectedNoOfDays2,
      this.effectedNoOfDays3});

  FindDelayCouseAndCrew1EFFECTEDNOOFDAYS1EFFECTEDNOOFDAYS2and3.fromJson(
      Map<String, dynamic> json) {
    delayCause = json['delayCause'];
    crew1 = json['crew1'];
    crew2 = json['crew2'];
    effectedNoOfDays1 = json['effectedNoOfDays1'];
    crew3 = json['crew3'];
    effectedNoOfDays2 = json['effectedNoOfDays2'];
    effectedNoOfDays3 = json['effectedNoOfDays3'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['delayCause'] = delayCause;
    data['crew1'] = crew1;
    data['crew2'] = crew2;
    data['effectedNoOfDays1'] = effectedNoOfDays1;
    data['crew3'] = crew3;
    data['effectedNoOfDays2'] = effectedNoOfDays2;
    data['effectedNoOfDays3'] = effectedNoOfDays3;
    return data;
  }
}

class FindCrewMilesCompletedAndMilesInProgress {
  double? milesCompleted;
  double? milesInProgress;
  String? crew;

  FindCrewMilesCompletedAndMilesInProgress(
      {this.milesCompleted, this.milesInProgress, this.crew});

  FindCrewMilesCompletedAndMilesInProgress.fromJson(Map<String, dynamic> json) {
    milesCompleted = json['milesCompleted'];
    milesInProgress = json['milesInProgress'];
    crew = json['crew'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['milesCompleted'] = milesCompleted;
    data['milesInProgress'] = milesInProgress;
    data['crew'] = crew;
    return data;
  }
}
