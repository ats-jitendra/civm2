class RowMaintenancePlanDashboardModel {
  List<RowMaintenancePlanList>? rowMaintenancePlanList;
  List<CostTotalMilesMilesCmpltedMilesInProgressMilesPending>?
      costTotalMilesMilesCmpltedMilesInProgressMilesPending;

  RowMaintenancePlanDashboardModel(
      {this.rowMaintenancePlanList,
      this.costTotalMilesMilesCmpltedMilesInProgressMilesPending});

  RowMaintenancePlanDashboardModel.fromJson(Map<String, dynamic> json) {
    if (json['row_maintenance_plan_list'] != null) {
      rowMaintenancePlanList = <RowMaintenancePlanList>[];
      json['row_maintenance_plan_list'].forEach((v) {
        rowMaintenancePlanList!.add(RowMaintenancePlanList.fromJson(v));
      });
    }
    if (json['costTotalMilesMilesCmpltedMilesInProgressMilesPending'] != null) {
      costTotalMilesMilesCmpltedMilesInProgressMilesPending =
          <CostTotalMilesMilesCmpltedMilesInProgressMilesPending>[];
      json['costTotalMilesMilesCmpltedMilesInProgressMilesPending']
          .forEach((v) {
        costTotalMilesMilesCmpltedMilesInProgressMilesPending!.add(
            CostTotalMilesMilesCmpltedMilesInProgressMilesPending.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (rowMaintenancePlanList != null) {
      data['row_maintenance_plan_list'] =
          rowMaintenancePlanList!.map((v) => v.toJson()).toList();
    }
    if (costTotalMilesMilesCmpltedMilesInProgressMilesPending != null) {
      data['costTotalMilesMilesCmpltedMilesInProgressMilesPending'] =
          costTotalMilesMilesCmpltedMilesInProgressMilesPending!
              .map((v) => v.toJson())
              .toList();
    }
    return data;
  }
}

class RowMaintenancePlanList {
  String? contractYear;
  String? costPerMile;
  String? dateOfInspection;
  String? county;
  String? approvedBy;
  String? actionNeeded;
  String? type;
  String? adminNotes1;
  String? growthScore;
  String? rowYear;
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
  String? documentUpload;
  String? contractEndYear;
  String? followOfDate;
  String? district;
  String? changeOrderImage;
  String? supervisor;
  String? totalCost;
  String? status;
  String? invoiceCreated;
  String? contractor;
  String? budgetType;
  String? milesCompleted;
  String? dueWeek;
  String? growthRate;
  String? tokenNo;
  int? nextMaintDue;
  String? cycle;
  String? maintDateHistory;
  String? crew;
  String? fdrName;
  String? street;
  String? actualCost;
  String? planType;
  String? estCost;
  String? treeType;
  String? totalMiles;
  String? noColumnName;
  String? contractorCompay;
  String? estTime;
  String? adminNotes2;
  String? createdDate;
  String? createdBy;
  String? streetAddress;
  String? tblVmlNewRowMaintenancePlanId;
  String? mapLocation;
  String? supervisorNotes;
  String? plannerNotes;

  RowMaintenancePlanList(
      {this.contractYear,
      this.costPerMile,
      this.dateOfInspection,
      this.county,
      this.approvedBy,
      this.actionNeeded,
      this.type,
      this.adminNotes1,
      this.growthScore,
      this.rowYear,
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
      this.documentUpload,
      this.contractEndYear,
      this.followOfDate,
      this.district,
      this.changeOrderImage,
      this.supervisor,
      this.totalCost,
      this.status,
      this.invoiceCreated,
      this.contractor,
      this.budgetType,
      this.milesCompleted,
      this.dueWeek,
      this.growthRate,
      this.tokenNo,
      this.nextMaintDue,
      this.cycle,
      this.maintDateHistory,
      this.crew,
      this.fdrName,
      this.street,
      this.actualCost,
      this.planType,
      this.estCost,
      this.treeType,
      this.totalMiles,
      this.noColumnName,
      this.contractorCompay,
      this.estTime,
      this.adminNotes2,
      this.createdDate,
      this.createdBy,
      this.streetAddress,
      this.tblVmlNewRowMaintenancePlanId,
      this.mapLocation,
      this.supervisorNotes,
      this.plannerNotes});

  RowMaintenancePlanList.fromJson(Map<String, dynamic> json) {
    contractYear = json['contractYear'];
    costPerMile = json['costPerMile'];
    dateOfInspection = json['dateOfInspection'];
    county = json['county'];
    approvedBy = json['approvedBy'];
    actionNeeded = json['actionNeeded'];
    type = json['type'];
    adminNotes1 = json['adminNotes1'];
    growthScore = json['growthScore'];
    rowYear = json['rowYear'];
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
    documentUpload = json['DocumentUpload'];
    contractEndYear = json['contractEndYear'];
    followOfDate = json['followOfDate'];
    district = json['district'];
    changeOrderImage = json['changeOrderImage'];
    supervisor = json['supervisor'];
    totalCost = json['totalCost'];
    status = json['status'];
    invoiceCreated = json['invoiceCreated'];
    contractor = json['contractor'];
    budgetType = json['budgetType'];
    milesCompleted = json['milesCompleted'];
    dueWeek = json['dueWeek'];
    growthRate = json['growthRate'];
    tokenNo = json['tokenNo'];
    nextMaintDue = json['nextMaintDue'];
    cycle = json['cycle'];
    maintDateHistory = json['maintDateHistory'];
    crew = json['crew'];
    fdrName = json['fdrName'];
    street = json['street'];
    actualCost = json['actualCost'];
    planType = json['planType'];
    estCost = json['estCost'];
    treeType = json['treeType'];
    totalMiles = json['totalMiles'];
    noColumnName = json['noColumnName'];
    contractorCompay = json['contractorCompay'];
    estTime = json['estTime'];
    adminNotes2 = json['adminNotes2'];
    createdDate = json['createdDate'];
    createdBy = json['createdBy'];
    streetAddress = json['streetAddress'];
    tblVmlNewRowMaintenancePlanId = json['tblVmlNewRowMaintenancePlanId'];
    mapLocation = json['mapLocation'];
    supervisorNotes = json['supervisorNotes'];
    plannerNotes = json['plannerNotes'];
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
    data['rowYear'] = rowYear;
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
    data['DocumentUpload'] = documentUpload;
    data['contractEndYear'] = contractEndYear;
    data['followOfDate'] = followOfDate;
    data['district'] = district;
    data['changeOrderImage'] = changeOrderImage;
    data['supervisor'] = supervisor;
    data['totalCost'] = totalCost;
    data['status'] = status;
    data['invoiceCreated'] = invoiceCreated;
    data['contractor'] = contractor;
    data['budgetType'] = budgetType;
    data['milesCompleted'] = milesCompleted;
    data['dueWeek'] = dueWeek;
    data['growthRate'] = growthRate;
    data['tokenNo'] = tokenNo;
    data['nextMaintDue'] = nextMaintDue;
    data['cycle'] = cycle;
    data['maintDateHistory'] = maintDateHistory;
    data['crew'] = crew;
    data['fdrName'] = fdrName;
    data['street'] = street;
    data['actualCost'] = actualCost;
    data['planType'] = planType;
    data['estCost'] = estCost;
    data['treeType'] = treeType;
    data['totalMiles'] = totalMiles;
    data['noColumnName'] = noColumnName;
    data['contractorCompay'] = contractorCompay;
    data['estTime'] = estTime;
    data['adminNotes2'] = adminNotes2;
    data['createdDate'] = createdDate;
    data['createdBy'] = createdBy;
    data['streetAddress'] = streetAddress;
    data['tblVmlNewRowMaintenancePlanId'] = tblVmlNewRowMaintenancePlanId;
    data['mapLocation'] = mapLocation;
    data['supervisorNotes'] = supervisorNotes;
    data['plannerNotes'] = plannerNotes;

    return data;
  }
}

class CostTotalMilesMilesCmpltedMilesInProgressMilesPending {
  double? milesCompleted;
  double? milesInProgress;
  double? milesPending;
  double? totalMiles;

  CostTotalMilesMilesCmpltedMilesInProgressMilesPending(
      {this.milesCompleted,
      this.milesInProgress,
      this.milesPending,
      this.totalMiles});

  CostTotalMilesMilesCmpltedMilesInProgressMilesPending.fromJson(
      Map<String, dynamic> json) {
    milesCompleted = json['milesCompleted'];
    milesInProgress = json['milesInProgress'];
    milesPending = json['milesPending'];
    totalMiles = json['totalMiles'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['milesCompleted'] = milesCompleted;
    data['milesInProgress'] = milesInProgress;
    data['milesPending'] = milesPending;
    data['totalMiles'] = totalMiles;
    return data;
  }
}
