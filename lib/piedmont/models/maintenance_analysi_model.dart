class MaintenanceAnalysisModel {
  List<FindNextMaintDueBySubstationAndFeeder>?
      findNextMaintDueBySubstationAndFeeder;
  List<int>? getSumOfTotalMilesBysubstation;
  List<FindSubstations>? findSubstations;
  List<FindFdrNamesBySubstation>? findFdrNamesBySubstation;
  List<GetSPMAINTENANCEANALYSISPROGRESS>? getSPMAINTENANCEANALYSISPROGRESS;
  List<FindSumOfTotalMileBySubstationAndFeeder>?
      findSumOfTotalMileBySubstationAndFeeder;
  List<FindSumOfTotalMileBySubstation>? findSumOfTotalMileBySubstation;
  List<FindAllSumOfTotalMiles>? findAllSumOfTotalMiles;
  List<GetSPMAINTENANCEANALYSIS>? getSPMAINTENANCEANALYSIS;

  MaintenanceAnalysisModel(
      {this.findNextMaintDueBySubstationAndFeeder,
      this.getSumOfTotalMilesBysubstation,
      this.findSubstations,
      this.findFdrNamesBySubstation,
      this.getSPMAINTENANCEANALYSISPROGRESS,
      this.findSumOfTotalMileBySubstationAndFeeder,
      this.findSumOfTotalMileBySubstation,
      this.findAllSumOfTotalMiles,
      this.getSPMAINTENANCEANALYSIS});

  MaintenanceAnalysisModel.fromJson(Map<String, dynamic> json) {
    if (json['findNextMaintDueBySubstationAndFeeder'] != null) {
      findNextMaintDueBySubstationAndFeeder =
          <FindNextMaintDueBySubstationAndFeeder>[];
      json['findNextMaintDueBySubstationAndFeeder'].forEach((v) {
        findNextMaintDueBySubstationAndFeeder!
            .add(FindNextMaintDueBySubstationAndFeeder.fromJson(v));
      });
    }
    getSumOfTotalMilesBysubstation =
        json['getSumOfTotalMilesBysubstation'].cast<int>();
    if (json['findSubstations'] != null) {
      findSubstations = <FindSubstations>[];
      json['findSubstations'].forEach((v) {
        findSubstations!.add(FindSubstations.fromJson(v));
      });
    }
    if (json['findSubstations'] != null) {
      findSubstations = <FindSubstations>[];
      json['findSubstations'].forEach((v) {
        findSubstations!.add(FindSubstations.fromJson(v));
      });
    }
    if (json['findFdrNamesBySubstation'] != null) {
      findFdrNamesBySubstation = <FindFdrNamesBySubstation>[];
      json['findFdrNamesBySubstation'].forEach((v) {
        findFdrNamesBySubstation!.add(FindFdrNamesBySubstation.fromJson(v));
      });
    }
    if (json['getSP_MAINTENANCE_ANALYSIS_PROGRESS'] != null) {
      getSPMAINTENANCEANALYSISPROGRESS = <GetSPMAINTENANCEANALYSISPROGRESS>[];
      json['getSP_MAINTENANCE_ANALYSIS_PROGRESS'].forEach((v) {
        getSPMAINTENANCEANALYSISPROGRESS!
            .add(GetSPMAINTENANCEANALYSISPROGRESS.fromJson(v));
      });
    }
    if (json['findSumOfTotalMileBySubstationAndFeeder'] != null) {
      findSumOfTotalMileBySubstationAndFeeder =
          <FindSumOfTotalMileBySubstationAndFeeder>[];
      json['findSumOfTotalMileBySubstationAndFeeder'].forEach((v) {
        findSumOfTotalMileBySubstationAndFeeder!
            .add(FindSumOfTotalMileBySubstationAndFeeder.fromJson(v));
      });
    }
    if (json['findSumOfTotalMileBySubstation'] != null) {
      findSumOfTotalMileBySubstation = <FindSumOfTotalMileBySubstation>[];
      json['findSumOfTotalMileBySubstation'].forEach((v) {
        findSumOfTotalMileBySubstation!
            .add(FindSumOfTotalMileBySubstation.fromJson(v));
      });
    }
    if (json['findAllSumOfTotalMiles'] != null) {
      findAllSumOfTotalMiles = <FindAllSumOfTotalMiles>[];
      json['findAllSumOfTotalMiles'].forEach((v) {
        findAllSumOfTotalMiles!.add(FindAllSumOfTotalMiles.fromJson(v));
      });
    }
    if (json['getSP_MAINTENANCE_ANALYSIS'] != null) {
      getSPMAINTENANCEANALYSIS = <GetSPMAINTENANCEANALYSIS>[];
      json['getSP_MAINTENANCE_ANALYSIS'].forEach((v) {
        getSPMAINTENANCEANALYSIS!.add(GetSPMAINTENANCEANALYSIS.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (findNextMaintDueBySubstationAndFeeder != null) {
      data['findNextMaintDueBySubstationAndFeeder'] = findNextMaintDueBySubstationAndFeeder!
          .map((v) => v.toJson())
          .toList();
    }
    data['getSumOfTotalMilesBysubstation'] =
        getSumOfTotalMilesBysubstation;
    if (findSubstations != null) {
      data['findSubstations'] =
          findSubstations!.map((v) => v.toJson()).toList();
    }
    if (findFdrNamesBySubstation != null) {
      data['findFdrNamesBySubstation'] =
          findFdrNamesBySubstation!.map((v) => v.toJson()).toList();
    }
    if (getSPMAINTENANCEANALYSISPROGRESS != null) {
      data['getSP_MAINTENANCE_ANALYSIS_PROGRESS'] = getSPMAINTENANCEANALYSISPROGRESS!
          .map((v) => v.toJson())
          .toList();
    }
    if (findSubstations != null) {
      data['findSubstations'] =
          findSubstations!.map((v) => v.toJson()).toList();
    }
    if (findSumOfTotalMileBySubstationAndFeeder != null) {
      data['findSumOfTotalMileBySubstationAndFeeder'] = findSumOfTotalMileBySubstationAndFeeder!
          .map((v) => v.toJson())
          .toList();
    }
    if (findSumOfTotalMileBySubstation != null) {
      data['findSumOfTotalMileBySubstation'] =
          findSumOfTotalMileBySubstation!.map((v) => v.toJson()).toList();
    }
    if (findAllSumOfTotalMiles != null) {
      data['findAllSumOfTotalMiles'] =
          findAllSumOfTotalMiles!.map((v) => v.toJson()).toList();
    }
    if (getSPMAINTENANCEANALYSIS != null) {
      data['getSP_MAINTENANCE_ANALYSIS'] =
          getSPMAINTENANCEANALYSIS!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FindNextMaintDueBySubstationAndFeeder {
  int? nextMaintDue;

  FindNextMaintDueBySubstationAndFeeder({this.nextMaintDue});

  FindNextMaintDueBySubstationAndFeeder.fromJson(Map<String, dynamic> json) {
    nextMaintDue = json['nextMaintDue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nextMaintDue'] = nextMaintDue;
    return data;
  }
}

class FindSubstations {
  String? substation;
  int? id;

  FindSubstations({this.substation, this.id});

  FindSubstations.fromJson(Map<String, dynamic> json) {
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

class FindFdrNamesBySubstation {
  String? fdrName;
  int? id;

  FindFdrNamesBySubstation({this.fdrName, this.id});

  FindFdrNamesBySubstation.fromJson(Map<String, dynamic> json) {
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

class GetSPMAINTENANCEANALYSISPROGRESS {
  int? cnt;
  String? status;

  GetSPMAINTENANCEANALYSISPROGRESS({this.cnt, this.status});

  GetSPMAINTENANCEANALYSISPROGRESS.fromJson(Map<String, dynamic> json) {
    cnt = json['cnt'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cnt'] = cnt;
    data['status'] = status;
    return data;
  }
}

class FindSumOfTotalMileBySubstationAndFeeder {
  double? totalMiles;

  FindSumOfTotalMileBySubstationAndFeeder({this.totalMiles});

  FindSumOfTotalMileBySubstationAndFeeder.fromJson(Map<String, dynamic> json) {
    totalMiles = json['totalMiles'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalMiles'] = totalMiles;
    return data;
  }
}

class FindSumOfTotalMileBySubstation {
  double? subTotalMiles;

  FindSumOfTotalMileBySubstation({this.subTotalMiles});

  FindSumOfTotalMileBySubstation.fromJson(Map<String, dynamic> json) {
    subTotalMiles = json['subTotalMiles'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['subTotalMiles'] = subTotalMiles;
    return data;
  }
}

class FindAllSumOfTotalMiles {
  double? sumOfTotalMiles;

  FindAllSumOfTotalMiles({this.sumOfTotalMiles});

  FindAllSumOfTotalMiles.fromJson(Map<String, dynamic> json) {
    sumOfTotalMiles = json['SumOfTotalMiles'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['SumOfTotalMiles'] = sumOfTotalMiles;
    return data;
  }
}

class GetSPMAINTENANCEANALYSIS {
  String? contractYear;
  String? dateOfInspection;
  String? county;
  String? approvedBy;
  String? actionNeeded;
  String? type;
  String? adminNotes1;
  String? growthScore;
  String? documentUpload;
  String? dueMonth;
  String? milesInProgress;
  String? maintType;
  String? substation;
  String? contractorNotes;
  int? id;
  String? budget;
  String? lastMaintDone;
  String? milesPending;
  String? maintCount;
  String? contractEndYear;
  String? followUpDate;
  String? district;
  String? tblVmaNewRowMaintanacePlanId;
  String? changeOrderImage;
  String? supervisor;
  String? totalCost;
  String? status;
  String? invoiceCreated;
  String? contractor;
  String? milesCompleted;
  String? dueWeek;
  String? growthRate;
  String? costPerMiles;
  String? tokenNo;
  String? nextMaintDue;
  String? cycle;
  String? maintDateHistory;
  String? crew;
  String? fdrName;
  String? street;
  String? createDate;
  String? contractorCompny;
  String? planType;
  String? treeType;
  String? totalMiles;
  String? noColumnName;
  String? adminNotes2;
  String? createdBy;
  String? streetAddress;
  String? mapLocation;

  GetSPMAINTENANCEANALYSIS(
      {this.contractYear,
      this.dateOfInspection,
      this.county,
      this.approvedBy,
      this.actionNeeded,
      this.type,
      this.adminNotes1,
      this.growthScore,
      this.documentUpload,
      this.dueMonth,
      this.milesInProgress,
      this.maintType,
      this.substation,
      this.contractorNotes,
      this.id,
      this.budget,
      this.lastMaintDone,
      this.milesPending,
      this.maintCount,
      this.contractEndYear,
      this.followUpDate,
      this.district,
      this.tblVmaNewRowMaintanacePlanId,
      this.changeOrderImage,
      this.supervisor,
      this.totalCost,
      this.status,
      this.invoiceCreated,
      this.contractor,
      this.milesCompleted,
      this.dueWeek,
      this.growthRate,
      this.costPerMiles,
      this.tokenNo,
      this.nextMaintDue,
      this.cycle,
      this.maintDateHistory,
      this.crew,
      this.fdrName,
      this.street,
      this.createDate,
      this.contractorCompny,
      this.planType,
      this.treeType,
      this.totalMiles,
      this.noColumnName,
      this.adminNotes2,
      this.createdBy,
      this.streetAddress,
      this.mapLocation});

  GetSPMAINTENANCEANALYSIS.fromJson(Map<String, dynamic> json) {
    contractYear = json['contractYear'];
    dateOfInspection = json['dateOfInspection'];
    county = json['county'];
    approvedBy = json['approvedBy'];
    actionNeeded = json['actionNeeded'];
    type = json['type'];
    adminNotes1 = json['adminNotes1'];
    growthScore = json['growthScore'];
    documentUpload = json['documentUpload'];
    dueMonth = json['dueMonth'];
    milesInProgress = json['milesInProgress'];
    maintType = json['maintType'];
    substation = json['substation'];
    contractorNotes = json['contractorNotes'];
    id = json['id'];
    budget = json['budget'];
    lastMaintDone = json['lastMaintDone'];
    milesPending = json['milesPending'];
    maintCount = json['maintCount'];
    contractEndYear = json['contractEndYear'];
    followUpDate = json['followUpDate'];
    district = json['district'];
    tblVmaNewRowMaintanacePlanId = json['tblVmaNewRowMaintanacePlanId'];
    changeOrderImage = json['changeOrderImage'];
    supervisor = json['supervisor'];
    totalCost = json['totalCost'];
    status = json['status'];
    invoiceCreated = json['invoiceCreated'];
    contractor = json['contractor'];
    milesCompleted = json['milesCompleted'];
    dueWeek = json['dueWeek'];
    growthRate = json['growthRate'];
    costPerMiles = json['costPerMiles'];
    tokenNo = json['tokenNo'];
    nextMaintDue = json['nextMaintDue'];
    cycle = json['cycle'];
    maintDateHistory = json['maintDateHistory'];
    crew = json['crew'];
    fdrName = json['fdrName'];
    street = json['street'];
    createDate = json['createDate'];
    contractorCompny = json['contractorCompny'];
    planType = json['planType'];
    treeType = json['treeType'];
    totalMiles = json['totalMiles'];
    noColumnName = json['noColumnName'];
    adminNotes2 = json['adminNotes2'];
    createdBy = json['createdBy'];
    streetAddress = json['streetAddress'];
    mapLocation = json['mapLocation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['contractYear'] = contractYear;
    data['dateOfInspection'] = dateOfInspection;
    data['county'] = county;
    data['approvedBy'] = approvedBy;
    data['actionNeeded'] = actionNeeded;
    data['type'] = type;
    data['adminNotes1'] = adminNotes1;
    data['growthScore'] = growthScore;
    data['documentUpload'] = documentUpload;
    data['dueMonth'] = dueMonth;
    data['milesInProgress'] = milesInProgress;
    data['maintType'] = maintType;
    data['substation'] = substation;
    data['contractorNotes'] = contractorNotes;
    data['id'] = id;
    data['budget'] = budget;
    data['lastMaintDone'] = lastMaintDone;
    data['milesPending'] = milesPending;
    data['maintCount'] = maintCount;
    data['contractEndYear'] = contractEndYear;
    data['followUpDate'] = followUpDate;
    data['district'] = district;
    data['tblVmaNewRowMaintanacePlanId'] = tblVmaNewRowMaintanacePlanId;
    data['changeOrderImage'] = changeOrderImage;
    data['supervisor'] = supervisor;
    data['totalCost'] = totalCost;
    data['status'] = status;
    data['invoiceCreated'] = invoiceCreated;
    data['contractor'] = contractor;
    data['milesCompleted'] = milesCompleted;
    data['dueWeek'] = dueWeek;
    data['growthRate'] = growthRate;
    data['costPerMiles'] = costPerMiles;
    data['tokenNo'] = tokenNo;
    data['nextMaintDue'] = nextMaintDue;
    data['cycle'] = cycle;
    data['maintDateHistory'] = maintDateHistory;
    data['crew'] = crew;
    data['fdrName'] = fdrName;
    data['street'] = street;
    data['createDate'] = createDate;
    data['contractorCompny'] = contractorCompny;
    data['planType'] = planType;
    data['treeType'] = treeType;
    data['totalMiles'] = totalMiles;
    data['noColumnName'] = noColumnName;
    data['adminNotes2'] = adminNotes2;
    data['createdBy'] = createdBy;
    data['streetAddress'] = streetAddress;
    data['mapLocation'] = mapLocation;
    return data;
  }
}
