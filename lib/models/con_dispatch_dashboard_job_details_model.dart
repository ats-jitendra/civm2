class ConDispatchDashboardJobDetailsModel {
  List<ConDispatchDashboardJobDetailsData>? data;
  String? message;

  ConDispatchDashboardJobDetailsModel({this.data, this.message});

  ConDispatchDashboardJobDetailsModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <ConDispatchDashboardJobDetailsData>[];
      json['data'].forEach((v) {
        data!.add(new ConDispatchDashboardJobDetailsData.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    return data;
  }
}

class ConDispatchDashboardJobDetailsData {
  String? plannerNotes;
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
  String? documentUpload;
  String? milesInProgress;
  String? maintType;
  String? substation;
  String? contractorNotes;
  int? id;
  String? budget;
  String? lastMaintDone;
  String? contractorCompany;
  String? milesPending;
  String? supervisorNotes;
  String? maintCount;
  String? crewName;
  String? contractEndYear;
  String? followUpDate;
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
  String? addChatNotes;
  String? crew;
  String? tblVmaNewMaintenancePlanId;
  String? fdrName;
  String? initiatedBy;
  String? createDate;
  String? actualCost;
  String? dueMoth;
  String? planType;
  String? estCost;
  String? treeType;
  String? totalMiles;
  String? noColumnName;
  String? estTime;
  String? adminNotes2;
  String? createdBy;
  String? streetAddress;
  String? visibilityFlag;
  String? mapLocation;
  String? masterJobNo;

  ConDispatchDashboardJobDetailsData(
      {this.plannerNotes,
      this.contractYear,
      this.costPerMile,
      this.dateOfInspection,
      this.county,
      this.approvedBy,
      this.actionNeeded,
      this.type,
      this.adminNotes1,
      this.growthScore,
      this.rowYear,
      this.documentUpload,
      this.milesInProgress,
      this.maintType,
      this.substation,
      this.contractorNotes,
      this.id,
      this.budget,
      this.lastMaintDone,
      this.contractorCompany,
      this.milesPending,
      this.supervisorNotes,
      this.maintCount,
      this.crewName,
      this.contractEndYear,
      this.followUpDate,
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
      this.addChatNotes,
      this.crew,
      this.tblVmaNewMaintenancePlanId,
      this.fdrName,
      this.initiatedBy,
      this.createDate,
      this.actualCost,
      this.dueMoth,
      this.planType,
      this.estCost,
      this.treeType,
      this.totalMiles,
      this.noColumnName,
      this.estTime,
      this.adminNotes2,
      this.createdBy,
      this.streetAddress,
      this.visibilityFlag,
      this.mapLocation,
      this.masterJobNo});

  ConDispatchDashboardJobDetailsData.fromJson(Map<String, dynamic> json) {
    plannerNotes = json['plannerNotes'];
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
    documentUpload = json['documentUpload'];
    milesInProgress = json['milesInProgress'];
    maintType = json['maintType'];
    substation = json['substation'];
    contractorNotes = json['contractorNotes'];
    id = json['id'];
    budget = json['budget'];
    lastMaintDone = json['lastMaintDone'];
    contractorCompany = json['contractorCompany'];
    milesPending = json['milesPending'];
    supervisorNotes = json['supervisorNotes'];
    maintCount = json['maintCount'];
    crewName = json['crewName'];
    contractEndYear = json['contractEndYear'];
    followUpDate = json['followUpDate'];
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
    addChatNotes = json['addChatNotes'];
    crew = json['crew'];
    tblVmaNewMaintenancePlanId = json['tblVmaNewMaintenancePlanId'];
    fdrName = json['fdrName'];
    initiatedBy = json['initiatedBy'];
    createDate = json['createDate'];
    actualCost = json['actualCost'];
    dueMoth = json['dueMoth'];
    planType = json['planType'];
    estCost = json['estCost'];
    treeType = json['treeType'];
    totalMiles = json['totalMiles'];
    noColumnName = json['noColumnName'];
    estTime = json['estTime'];
    adminNotes2 = json['adminNotes2'];
    createdBy = json['createdBy'];
    streetAddress = json['streetAddress'];
    visibilityFlag = json['visibilityFlag'];
    mapLocation = json['mapLocation'];
    masterJobNo = json['masterJobNo']??'';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['plannerNotes'] = plannerNotes;
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
    data['documentUpload'] = documentUpload;
    data['milesInProgress'] = milesInProgress;
    data['maintType'] = maintType;
    data['substation'] = substation;
    data['contractorNotes'] = contractorNotes;
    data['id'] = id;
    data['budget'] = budget;
    data['lastMaintDone'] = lastMaintDone;
    data['contractorCompany'] = contractorCompany;
    data['milesPending'] = milesPending;
    data['supervisorNotes'] = supervisorNotes;
    data['maintCount'] = maintCount;
    data['crewName'] = crewName;
    data['contractEndYear'] = contractEndYear;
    data['followUpDate'] = followUpDate;
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
    data['addChatNotes'] = addChatNotes;
    data['crew'] = crew;
    data['tblVmaNewMaintenancePlanId'] = tblVmaNewMaintenancePlanId;
    data['fdrName'] = fdrName;
    data['initiatedBy'] = initiatedBy;
    data['createDate'] = createDate;
    data['actualCost'] = actualCost;
    data['dueMoth'] = dueMoth;
    data['planType'] = planType;
    data['estCost'] = estCost;
    data['treeType'] = treeType;
    data['totalMiles'] = totalMiles;
    data['noColumnName'] = noColumnName;
    data['estTime'] = estTime;
    data['adminNotes2'] = adminNotes2;
    data['createdBy'] = createdBy;
    data['streetAddress'] = streetAddress;
    data['visibilityFlag'] = visibilityFlag;
    data['mapLocation'] = mapLocation;
    data['masterJobNo'] = masterJobNo;
    return data;
  }
}
