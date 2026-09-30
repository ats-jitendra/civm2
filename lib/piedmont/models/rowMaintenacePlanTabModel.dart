// ignore: file_names
class RowMaintenacePlanTabModel {
  List<CycleLists>? cycleLists;
  List<SubStations>? subStations;
  List<GetAllContractorList>? getAllContractorList;
  List<Feeders>? feeders;
  List<AllVMARowMaintPlanListForAdminSupervisorWorkStatus>?
      allVMARowMaintPlanListForAdminSupervisorWorkStatus;
  List<NextMaintDueYear>? nextMaintDueYear;

  RowMaintenacePlanTabModel(
      {this.cycleLists,
      this.subStations,
      this.getAllContractorList,
      this.feeders,
      this.allVMARowMaintPlanListForAdminSupervisorWorkStatus,
      this.nextMaintDueYear});

  RowMaintenacePlanTabModel.fromJson(Map<String, dynamic> json) {
    if (json['cycleLists'] != null) {
      cycleLists = <CycleLists>[];
      json['cycleLists'].forEach((v) {
        cycleLists!.add(CycleLists.fromJson(v));
      });
    }
    if (json['subStations'] != null) {
      subStations = <SubStations>[];
      json['subStations'].forEach((v) {
        subStations!.add(SubStations.fromJson(v));
      });
    }
    if (json['getAllContractorList'] != null) {
      getAllContractorList = <GetAllContractorList>[];
      json['getAllContractorList'].forEach((v) {
        getAllContractorList!.add(GetAllContractorList.fromJson(v));
      });
    }
    if (json['feeders'] != null) {
      feeders = <Feeders>[];
      json['feeders'].forEach((v) {
        feeders!.add(Feeders.fromJson(v));
      });
    }
    if (json['allVMARowMaintPlanListForAdminSupervisorWorkStatus'] != null) {
      allVMARowMaintPlanListForAdminSupervisorWorkStatus =
          <AllVMARowMaintPlanListForAdminSupervisorWorkStatus>[];
      json['allVMARowMaintPlanListForAdminSupervisorWorkStatus'].forEach((v) {
        allVMARowMaintPlanListForAdminSupervisorWorkStatus!.add(
            AllVMARowMaintPlanListForAdminSupervisorWorkStatus.fromJson(v));
      });
    }
    if (json['next_maint_due_year'] != null) {
      nextMaintDueYear = <NextMaintDueYear>[];
      json['next_maint_due_year'].forEach((v) {
        nextMaintDueYear!.add(NextMaintDueYear.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (cycleLists != null) {
      data['cycleLists'] = cycleLists!.map((v) => v.toJson()).toList();
    }
    if (subStations != null) {
      data['subStations'] = subStations!.map((v) => v.toJson()).toList();
    }
    if (getAllContractorList != null) {
      data['getAllContractorList'] =
          getAllContractorList!.map((v) => v.toJson()).toList();
    }
    if (feeders != null) {
      data['feeders'] = feeders!.map((v) => v.toJson()).toList();
    }
    if (allVMARowMaintPlanListForAdminSupervisorWorkStatus != null) {
      data['allVMARowMaintPlanListForAdminSupervisorWorkStatus'] =
          allVMARowMaintPlanListForAdminSupervisorWorkStatus!
              .map((v) => v.toJson())
              .toList();
    }
    if (nextMaintDueYear != null) {
      data['next_maint_due_year'] =
          nextMaintDueYear!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CycleLists {
  String? cycle;

  CycleLists({this.cycle});

  CycleLists.fromJson(Map<String, dynamic> json) {
    cycle = json['cycle'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cycle'] = cycle;
    return data;
  }
}

class SubStations {
  String? subId;
  String? subStation;

  SubStations({this.subId, this.subStation});

  SubStations.fromJson(Map<String, dynamic> json) {
    subId = json['subId'];
    subStation = json['subStation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['subId'] = subId;
    data['subStation'] = subStation;
    return data;
  }
}

class Feeders {
  String? subId;
  String? fdrId;
  String? fdrName;
  String? feeder;
  String? subStation;

  Feeders({this.subId, this.fdrId, this.fdrName, this.feeder, this.subStation});

  Feeders.fromJson(Map<String, dynamic> json) {
    subId = json['subId'];
    fdrId = json['fdrId'];
    fdrName = json['fdrName'];
    feeder = json['feeder'];
    subStation = json['subStation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['subId'] = subId;
    data['fdrId'] = fdrId;
    data['fdrName'] = fdrName;
    data['feeder'] = feeder;
    data['subStation'] = subStation;
    return data;
  }
}

class AllVMARowMaintPlanListForAdminSupervisorWorkStatus {
  String? contractYear;
  double? costPerMile;
  String? feeder;
  String? county;
  String? type;
  String? adminNotes1;
  String? rowYear;
  int? dueMonth;
  String? maintType;
  String? substation;
  String? contractorNotes;
  int? id;
  double? budget;
  String? lastMaintDone;
  String? workStatusCss;
  int? maintCount;
  String? supervisorId;
  String? contractEndYear;
  String? district;
  String? supervisor;
  double? totalCost;
  String? streetId;
  String? contractor;
  String? budgetType;
  String? role;
  int? dueWeek;
  String? fileUpStatus;
  int? tokenNo;
  String? nextMaintDue;
  String? cycle;
  String? maintDateHistory;
  String? crew;
  String? substationId;
  String? feederId;
  String? countyId;
  String? street;
  String? createDate;
  String? actualCost;
  String? workStatus;
  String? planType;
  String? estCost;
  String? filePath;
  String? fileUploadStatus;
  double? totalMiles;
  String? contractorCompay;
  String? documentUploadCss;
  String? estTime;
  String? adminNotes2;
  String? districtId;
  String? mapLocation;
  String? contractorName;
  String? nextMaintDueYear;

  AllVMARowMaintPlanListForAdminSupervisorWorkStatus(
      {this.contractYear,
      this.costPerMile,
      this.feeder,
      this.county,
      this.type,
      this.adminNotes1,
      this.rowYear,
      this.dueMonth,
      this.maintType,
      this.substation,
      this.contractorNotes,
      this.id,
      this.budget,
      this.lastMaintDone,
      this.workStatusCss,
      this.maintCount,
      this.supervisorId,
      this.contractEndYear,
      this.district,
      this.supervisor,
      this.totalCost,
      this.streetId,
      this.contractor,
      this.budgetType,
      this.role,
      this.dueWeek,
      this.fileUpStatus,
      this.tokenNo,
      this.nextMaintDue,
      this.cycle,
      this.maintDateHistory,
      this.crew,
      this.substationId,
      this.feederId,
      this.countyId,
      this.street,
      this.createDate,
      this.actualCost,
      this.workStatus,
      this.planType,
      this.estCost,
      this.filePath,
      this.fileUploadStatus,
      this.totalMiles,
      this.contractorCompay,
      this.documentUploadCss,
      this.estTime,
      this.adminNotes2,
      this.districtId,
      this.mapLocation,
      this.contractorName,
      this.nextMaintDueYear});

  AllVMARowMaintPlanListForAdminSupervisorWorkStatus.fromJson(
      Map<String, dynamic> json) {
    contractYear = json['contractYear'];
    costPerMile = json['costPerMile'];
    feeder = json['feeder'];
    county = json['county'];
    type = json['type'];
    adminNotes1 = json['adminNotes1'];
    rowYear = json['rowYear'];
    dueMonth = json['dueMonth'];
    maintType = json['maintType'];
    substation = json['substation'];
    contractorNotes = json['contractorNotes'];
    id = json['id'];
    budget = json['budget'];
    lastMaintDone = json['lastMaintDone'];
    workStatusCss = json['workStatusCss'];
    maintCount = json['maintCount'];
    supervisorId = json['supervisorId'];
    contractEndYear = json['contractEndYear'];
    district = json['district'];
    supervisor = json['supervisor'];
    totalCost = json['totalCost'];
    streetId = json['streetId'];
    contractor = json['contractor'];
    budgetType = json['budgetType'];
    role = json['role'];
    dueWeek = json['dueWeek'];
    fileUpStatus = json['fileUpStatus'];
    tokenNo = json['tokenNo'];
    nextMaintDue = json['nextMaintDue'];
    cycle = json['cycle'];
    maintDateHistory = json['maintDateHistory'];
    crew = json['crew'];
    substationId = json['substationId'];
    feederId = json['feederId'];
    countyId = json['countyId'];
    street = json['street'];
    createDate = json['createDate'];
    actualCost = json['actualCost'];
    workStatus = json['workStatus'];
    planType = json['planType'];
    estCost = json['estCost'];
    filePath = json['filePath'];
    fileUploadStatus = json['fileUploadStatus'];
    totalMiles = json['totalMiles'];
    contractorCompay = json['contractorCompay'];
    documentUploadCss = json['documentUploadCss'];
    estTime = json['estTime'];
    adminNotes2 = json['adminNotes2'];
    districtId = json['districtId'];
    mapLocation = json['mapLocation'];
    contractorName = json['contractorName'];
    nextMaintDueYear = json['nextMaintDueYear'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['contractYear'] = contractYear;
    data['costPerMile'] = costPerMile;
    data['feeder'] = feeder;
    data['county'] = county;
    data['type'] = type;
    data['adminNotes1'] = adminNotes1;
    data['rowYear'] = rowYear;
    data['dueMonth'] = dueMonth;
    data['maintType'] = maintType;
    data['substation'] = substation;
    data['contractorNotes'] = contractorNotes;
    data['id'] = id;
    data['budget'] = budget;
    data['lastMaintDone'] = lastMaintDone;
    data['workStatusCss'] = workStatusCss;
    data['maintCount'] = maintCount;
    data['supervisorId'] = supervisorId;
    data['contractEndYear'] = contractEndYear;
    data['district'] = district;
    data['supervisor'] = supervisor;
    data['totalCost'] = totalCost;
    data['streetId'] = streetId;
    data['contractor'] = contractor;
    data['budgetType'] = budgetType;
    data['role'] = role;
    data['dueWeek'] = dueWeek;
    data['fileUpStatus'] = fileUpStatus;
    data['tokenNo'] = tokenNo;
    data['nextMaintDue'] = nextMaintDue;
    data['cycle'] = cycle;
    data['maintDateHistory'] = maintDateHistory;
    data['crew'] = crew;
    data['substationId'] = substationId;
    data['feederId'] = feederId;
    data['countyId'] = countyId;
    data['street'] = street;
    data['createDate'] = createDate;
    data['actualCost'] = actualCost;
    data['workStatus'] = workStatus;
    data['planType'] = planType;
    data['estCost'] = estCost;
    data['filePath'] = filePath;
    data['fileUploadStatus'] = fileUploadStatus;
    data['totalMiles'] = totalMiles;
    data['contractorCompay'] = contractorCompay;
    data['documentUploadCss'] = documentUploadCss;
    data['estTime'] = estTime;
    data['adminNotes2'] = adminNotes2;
    data['districtId'] = districtId;
    data['mapLocation'] = mapLocation;
    data['contractorName'] = contractorName;
    data['nextMaintDueYear'] = nextMaintDueYear;
    return data;
  }
}

class NextMaintDueYear {
  int? nextMaintDue;

  NextMaintDueYear({this.nextMaintDue});

  NextMaintDueYear.fromJson(Map<String, dynamic> json) {
    nextMaintDue = json['next_maint_due'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['next_maint_due'] = nextMaintDue;
    return data;
  }
}

class GetAllContractorList {
  int? loginId;
  String? name;

  GetAllContractorList({this.loginId, this.name});

  GetAllContractorList.fromJson(Map<String, dynamic> json) {
    loginId = json['loginId'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['loginId'] = loginId;
    data['name'] = name;
    return data;
  }
}
