class RowCostAnalysisModel {
  int? findEstimatedBudgetBYSubstation;
  List<FindsNextMaintDueBySubstation>? findsNextMaintDueBySubstation;
  List<GetSPROWCOSTANALYSISTotalCostBySubstation>?
      getSPROWCOSTANALYSISTotalCostBySubstation;
  List<FindsSubstation>? findsSubstation;
  int? findsEstimatedBudget;
  List<GetSPROWCOSTANALYSISTotalMilesBySubstation>?
      getSPROWCOSTANALYSISTotalMilesBySubstation;
  List<FindsEstimatedBudgetBySubstationAndNextMaintDue>?
      findsEstimatedBudgetBySubstationAndNextMaintDue;
  List<GetSPMAINTENANCEANALYSIS>? getSPMAINTENANCEANALYSIS;

  RowCostAnalysisModel(
      {this.findEstimatedBudgetBYSubstation,
      this.findsNextMaintDueBySubstation,
      this.getSPROWCOSTANALYSISTotalCostBySubstation,
      this.findsSubstation,
      this.findsEstimatedBudget,
      this.getSPROWCOSTANALYSISTotalMilesBySubstation,
      this.findsEstimatedBudgetBySubstationAndNextMaintDue,
      this.getSPMAINTENANCEANALYSIS});

  RowCostAnalysisModel.fromJson(Map<String, dynamic> json) {
    findEstimatedBudgetBYSubstation = json['findEstimatedBudgetBYSubstation'];
    if (json['findsNextMaintDueBySubstation'] != null) {
      findsNextMaintDueBySubstation = <FindsNextMaintDueBySubstation>[];
      json['findsNextMaintDueBySubstation'].forEach((v) {
        findsNextMaintDueBySubstation!
            .add(FindsNextMaintDueBySubstation.fromJson(v));
      });
    }
    if (json['getSP_ROW_COST_ANALYSIS_Total_Cost_By_Substation'] != null) {
      getSPROWCOSTANALYSISTotalCostBySubstation =
          <GetSPROWCOSTANALYSISTotalCostBySubstation>[];
      json['getSP_ROW_COST_ANALYSIS_Total_Cost_By_Substation'].forEach((v) {
        getSPROWCOSTANALYSISTotalCostBySubstation!
            .add(GetSPROWCOSTANALYSISTotalCostBySubstation.fromJson(v));
      });
    }
    if (json['findsSubstation'] != null) {
      findsSubstation = <FindsSubstation>[];
      json['findsSubstation'].forEach((v) {
        findsSubstation!.add(FindsSubstation.fromJson(v));
      });
    }
    findsEstimatedBudget = json['findsEstimatedBudget'];
    if (json['getSP_ROW_COST_ANALYSIS_Total_Miles_By_Substation'] != null) {
      getSPROWCOSTANALYSISTotalMilesBySubstation = <GetSPROWCOSTANALYSISTotalMilesBySubstation>[];
      json['getSP_ROW_COST_ANALYSIS_Total_Miles_By_Substation'].forEach((v) {
        getSPROWCOSTANALYSISTotalMilesBySubstation!
            .add(GetSPROWCOSTANALYSISTotalMilesBySubstation.fromJson(v));
      });
    }
    if (json['findsEstimatedBudgetBySubstationAndNextMaintDue'] != null) {
      findsEstimatedBudgetBySubstationAndNextMaintDue =
          <FindsEstimatedBudgetBySubstationAndNextMaintDue>[];
      json['findsEstimatedBudgetBySubstationAndNextMaintDue'].forEach((v) {
        findsEstimatedBudgetBySubstationAndNextMaintDue!.add(
            FindsEstimatedBudgetBySubstationAndNextMaintDue.fromJson(v));
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
    data['findEstimatedBudgetBYSubstation'] =
        findEstimatedBudgetBYSubstation;
    if (findsNextMaintDueBySubstation != null) {
      data['findsNextMaintDueBySubstation'] =
          findsNextMaintDueBySubstation!.map((v) => v.toJson()).toList();
    }
    if (getSPROWCOSTANALYSISTotalCostBySubstation != null) {
      data['getSP_ROW_COST_ANALYSIS_Total_Cost_By_Substation'] = getSPROWCOSTANALYSISTotalCostBySubstation!
          .map((v) => v.toJson())
          .toList();
    }
    if (findsSubstation != null) {
      data['findsSubstation'] =
          findsSubstation!.map((v) => v.toJson()).toList();
    }
    data['findsEstimatedBudget'] = findsEstimatedBudget;
    if (getSPROWCOSTANALYSISTotalMilesBySubstation != null) {
      data['getSP_ROW_COST_ANALYSIS_Total_Miles_By_Substation'] = getSPROWCOSTANALYSISTotalMilesBySubstation!
          .map((v) => v.toJson())
          .toList();
    }
    if (findsEstimatedBudgetBySubstationAndNextMaintDue != null) {
      data['findsEstimatedBudgetBySubstationAndNextMaintDue'] = findsEstimatedBudgetBySubstationAndNextMaintDue!
          .map((v) => v.toJson())
          .toList();
    }
    if (getSPMAINTENANCEANALYSIS != null) {
      data['getSP_MAINTENANCE_ANALYSIS'] =
          getSPMAINTENANCEANALYSIS!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
class GetSPROWCOSTANALYSISTotalMilesBySubstation {
  String? substationName;
  double? totalMiles;

  GetSPROWCOSTANALYSISTotalMilesBySubstation(
      {this.substationName, this.totalMiles});

  GetSPROWCOSTANALYSISTotalMilesBySubstation.fromJson(
      Map<String, dynamic> json) {
    substationName = json['substationName'];
    totalMiles = json['totalMiles'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['substationName'] = substationName;
    data['totalMiles'] = totalMiles;
    return data;
  }
}

class FindsNextMaintDueBySubstation {
  int? nextMaintDue;

  FindsNextMaintDueBySubstation({this.nextMaintDue});

  FindsNextMaintDueBySubstation.fromJson(Map<String, dynamic> json) {
    nextMaintDue = json['nextMaintDue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nextMaintDue'] = nextMaintDue;
    return data;
  }
}

class GetSPROWCOSTANALYSISTotalCostBySubstation {
  String? substationName;
  double? totalCost;

  GetSPROWCOSTANALYSISTotalCostBySubstation(
      {this.substationName, this.totalCost});

  GetSPROWCOSTANALYSISTotalCostBySubstation.fromJson(
      Map<String, dynamic> json) {
    substationName = json['substationName'];
    totalCost = json['totalCost'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['substationName'] = substationName;
    data['totalCost'] = totalCost;
    return data;
  }
}

class FindsSubstation {
  String? substation;
  int? id;

  FindsSubstation({this.substation, this.id});

  FindsSubstation.fromJson(Map<String, dynamic> json) {
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

class FindsEstimatedBudgetBySubstationAndNextMaintDue {
  int? findsEstimatedBudget;

  FindsEstimatedBudgetBySubstationAndNextMaintDue({this.findsEstimatedBudget});

  FindsEstimatedBudgetBySubstationAndNextMaintDue.fromJson(
      Map<String, dynamic> json) {
    findsEstimatedBudget = json['findsEstimatedBudget'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['findsEstimatedBudget'] = findsEstimatedBudget;
    return data;
  }
}

class GetSPMAINTENANCEANALYSIS {
  String? contractYear;
  String? costPerMile;
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
  String? changeOrderImage;
  String? supervisor;
  String? totalCost;
  String? status;
  String? invoiceCreated;
  String? contractor;
  String? milesCompleted;
  String? dueWeek;
  String? growthRate;
  String? tokenNo;
  String? nextMaintDue;
  String? cycle;
  String? maintDateHistory;
  String? crew;
  String? tblVmaNewMaintenancePlanId;
  String? fdrName;
  String? street;
  String? createDate;
  String? planType;
  String? treeType;
  String? totalMiles;
  String? contactorCompany;
  String? noColumnName;
  String? adminNotes2;
  String? createdBy;
  String? streetAddress;
  String? mapLocation;

  GetSPMAINTENANCEANALYSIS(
      {this.contractYear,
      this.costPerMile,
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
      this.changeOrderImage,
      this.supervisor,
      this.totalCost,
      this.status,
      this.invoiceCreated,
      this.contractor,
      this.milesCompleted,
      this.dueWeek,
      this.growthRate,
      this.tokenNo,
      this.nextMaintDue,
      this.cycle,
      this.maintDateHistory,
      this.crew,
      this.tblVmaNewMaintenancePlanId,
      this.fdrName,
      this.street,
      this.createDate,
      this.planType,
      this.treeType,
      this.totalMiles,
      this.contactorCompany,
      this.noColumnName,
      this.adminNotes2,
      this.createdBy,
      this.streetAddress,
      this.mapLocation});

  GetSPMAINTENANCEANALYSIS.fromJson(Map<String, dynamic> json) {
    contractYear = json['contractYear'];
    costPerMile = json['costPerMile'];
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
    changeOrderImage = json['changeOrderImage'];
    supervisor = json['supervisor'];
    totalCost = json['totalCost'];
    status = json['status'];
    invoiceCreated = json['invoiceCreated'];
    contractor = json['contractor'];
    milesCompleted = json['milesCompleted'];
    dueWeek = json['dueWeek'];
    growthRate = json['growthRate'];
    tokenNo = json['tokenNo'];
    nextMaintDue = json['nextMaintDue'];
    cycle = json['cycle'];
    maintDateHistory = json['maintDateHistory'];
    crew = json['crew'];
    tblVmaNewMaintenancePlanId = json['tblVmaNewMaintenancePlanId'];
    fdrName = json['fdrName'];
    street = json['street'];
    createDate = json['createDate'];
    planType = json['planType'];
    treeType = json['treeType'];
    totalMiles = json['totalMiles'];
    contactorCompany = json['contactorCompany'];
    noColumnName = json['noColumnName'];
    adminNotes2 = json['adminNotes2'];
    createdBy = json['createdBy'];
    streetAddress = json['streetAddress'];
    mapLocation = json['mapLocation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['contractYear'] = contractYear;
    data['costPerMile'] = costPerMile;
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
    data['changeOrderImage'] = changeOrderImage;
    data['supervisor'] = supervisor;
    data['totalCost'] = totalCost;
    data['status'] = status;
    data['invoiceCreated'] = invoiceCreated;
    data['contractor'] = contractor;
    data['milesCompleted'] = milesCompleted;
    data['dueWeek'] = dueWeek;
    data['growthRate'] = growthRate;
    data['tokenNo'] = tokenNo;
    data['nextMaintDue'] = nextMaintDue;
    data['cycle'] = cycle;
    data['maintDateHistory'] = maintDateHistory;
    data['crew'] = crew;
    data['tblVmaNewMaintenancePlanId'] = tblVmaNewMaintenancePlanId;
    data['fdrName'] = fdrName;
    data['street'] = street;
    data['createDate'] = createDate;
    data['planType'] = planType;
    data['treeType'] = treeType;
    data['totalMiles'] = totalMiles;
    data['contactorCompany'] = contactorCompany;
    data['noColumnName'] = noColumnName;
    data['adminNotes2'] = adminNotes2;
    data['createdBy'] = createdBy;
    data['streetAddress'] = streetAddress;
    data['mapLocation'] = mapLocation;
    return data;
  }
}
