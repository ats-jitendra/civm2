// ignore: file_names
class SupervisorOrderPendingModel {
  List<TokenNoLists>? tokenNoLists;
  List<FindAllTableData>? findAllTableData;

  SupervisorOrderPendingModel({this.tokenNoLists, this.findAllTableData});

  SupervisorOrderPendingModel.fromJson(Map<String, dynamic> json) {
    if (json['TokenNoLists'] != null) {
      tokenNoLists = <TokenNoLists>[];
      json['TokenNoLists'].forEach((v) {
        tokenNoLists!.add(TokenNoLists.fromJson(v));
      });
    }
    if (json['findAllTableData'] != null) {
      findAllTableData = <FindAllTableData>[];
      json['findAllTableData'].forEach((v) {
        findAllTableData!.add(FindAllTableData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (tokenNoLists != null) {
      data['TokenNoLists'] = tokenNoLists!.map((v) => v.toJson()).toList();
    }
    if (findAllTableData != null) {
      data['findAllTableData'] =
          findAllTableData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TokenNoLists {
  String? tokenNo;

  TokenNoLists({this.tokenNo});

  TokenNoLists.fromJson(Map<String, dynamic> json) {
    tokenNo = json['TokenNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['TokenNo'] = tokenNo;
    return data;
  }
}

class FindAllTableData {
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
  String? budgetType;
  String? milesCompleted;
  String? dueWeek;
  String? growthRate;
  String? tokenNo;
  String? nextMaintDue;
  String? mixingInventorVisible;
  String? cycle;
  String? maintDateHistory;
  String? crew;
  String? tblVmaNewMaintenancePlanId;
  String? fdrName;
  String? createDate;
  String? actualCost;
  String? dueMoth;
  String? planType;
  String? estCost;
  String? treeType;
  String? totalMiles;
  String? contactorCompany;
  String? noColumnName;
  String? estTime;
  String? ivmTimeDateShit;
  String? adminNotes2;
  String? createdBy;
  String? streetAddress;
  String? mapLocation;
  String? dailyHerbicideVisible;
  String? supervisorNotes;
  String? plannerNotes;
  String? initiatedBy;

  FindAllTableData(
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
      this.documentUpload,
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
      this.budgetType,
      this.milesCompleted,
      this.dueWeek,
      this.growthRate,
      this.tokenNo,
      this.nextMaintDue,
      this.mixingInventorVisible,
      this.cycle,
      this.maintDateHistory,
      this.crew,
      this.tblVmaNewMaintenancePlanId,
      this.fdrName,
      this.createDate,
      this.actualCost,
      this.dueMoth,
      this.planType,
      this.estCost,
      this.treeType,
      this.totalMiles,
      this.contactorCompany,
      this.noColumnName,
      this.estTime,
      this.ivmTimeDateShit,
      this.adminNotes2,
      this.createdBy,
      this.streetAddress,
      this.mapLocation,
      this.dailyHerbicideVisible,
      this.supervisorNotes,
      this.plannerNotes,
      this.initiatedBy});

  FindAllTableData.fromJson(Map<String, dynamic> json) {
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
    budgetType = json['budgetType'];
    milesCompleted = json['milesCompleted'];
    dueWeek = json['dueWeek'];
    growthRate = json['growthRate'];
    tokenNo = json['tokenNo'];
    nextMaintDue = json['nextMaintDue'];
    mixingInventorVisible = json['mixingInventorVisible'];
    cycle = json['cycle'];
    maintDateHistory = json['maintDateHistory'];
    crew = json['crew'];
    tblVmaNewMaintenancePlanId = json['tblVmaNewMaintenancePlanId'];
    fdrName = json['fdrName'];
    createDate = json['createDate'];
    actualCost = json['actualCost'];
    dueMoth = json['dueMoth'];
    planType = json['planType'];
    estCost = json['estCost'];
    treeType = json['treeType'];
    totalMiles = json['totalMiles'];
    contactorCompany = json['contactorCompany'];
    noColumnName = json['noColumnName'];
    estTime = json['estTime'];
    ivmTimeDateShit = json['ivmTimeDateShit'];
    adminNotes2 = json['adminNotes2'];
    createdBy = json['createdBy'];
    streetAddress = json['streetAddress'];
    mapLocation = json['mapLocation'];
    dailyHerbicideVisible = json['dailyHerbicideVisible'];
    supervisorNotes = json['supervisorNotes'];
    plannerNotes = json['plannerNotes'];
    initiatedBy = json['initiatedBy'];
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
    data['documentUpload'] = documentUpload;
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
    data['budgetType'] = budgetType;
    data['milesCompleted'] = milesCompleted;
    data['dueWeek'] = dueWeek;
    data['growthRate'] = growthRate;
    data['tokenNo'] = tokenNo;
    data['nextMaintDue'] = nextMaintDue;
    data['mixingInventorVisible'] = mixingInventorVisible;
    data['cycle'] = cycle;
    data['maintDateHistory'] = maintDateHistory;
    data['crew'] = crew;
    data['tblVmaNewMaintenancePlanId'] = tblVmaNewMaintenancePlanId;
    data['fdrName'] = fdrName;
    data['createDate'] = createDate;
    data['actualCost'] = actualCost;
    data['dueMoth'] = dueMoth;
    data['planType'] = planType;
    data['estCost'] = estCost;
    data['treeType'] = treeType;
    data['totalMiles'] = totalMiles;
    data['contactorCompany'] = contactorCompany;
    data['noColumnName'] = noColumnName;
    data['estTime'] = estTime;
    data['ivmTimeDateShit'] = ivmTimeDateShit;
    data['adminNotes2'] = adminNotes2;
    data['createdBy'] = createdBy;
    data['streetAddress'] = streetAddress;
    data['mapLocation'] = mapLocation;
    data['dailyHerbicideVisible'] = dailyHerbicideVisible;
    data['supervisorNotes'] = supervisorNotes;
    data['plannerNotes'] = plannerNotes;
    data['initiatedBy'] = initiatedBy;
    return data;
  }
}
