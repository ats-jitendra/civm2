class ContractorChangeOrderPending {
  List<TokenNoLists>? tokenNoLists;
  List<FindAllTableData>? findAllTableData;

  ContractorChangeOrderPending({this.tokenNoLists, this.findAllTableData});

  ContractorChangeOrderPending.fromJson(Map<String, dynamic> json) {
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
  int? tokenNo;

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
  String? mixingInventory;
  String? type;
  String? adminNotes1;
  String? growthScore;
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
  String? milesCompleted;
  String? dueWeek;
  String? growthRate;
  String? tokenNo;
  String? nextMaintDue;
  String? cycle;
  String? maintDateHistory;
  String? dailyHerbicide;
  String? crew;
  String? tblVmaNewMaintenancePlanId;
  String? fdrName;
  String? createDate;
  String? dueMoth;
  String? planType;
  String? treeType;
  String? totalMiles;
  String? contactorCompany;
  String? noColumnName;
  String? adminNotes2;
  String? ivmTimesheet;
  String? createdBy;
  String? streetAddress;
  String? mapLocation;

  FindAllTableData(
      {this.contractYear,
      this.costPerMile,
      this.dateOfInspection,
      this.county,
      this.approvedBy,
      this.actionNeeded,
      this.mixingInventory,
      this.type,
      this.adminNotes1,
      this.growthScore,
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
      this.milesCompleted,
      this.dueWeek,
      this.growthRate,
      this.tokenNo,
      this.nextMaintDue,
      this.cycle,
      this.maintDateHistory,
      this.dailyHerbicide,
      this.crew,
      this.tblVmaNewMaintenancePlanId,
      this.fdrName,
      this.createDate,
      this.dueMoth,
      this.planType,
      this.treeType,
      this.totalMiles,
      this.contactorCompany,
      this.noColumnName,
      this.adminNotes2,
      this.ivmTimesheet,
      this.createdBy,
      this.streetAddress,
      this.mapLocation});

  FindAllTableData.fromJson(Map<String, dynamic> json) {
    contractYear = json['contractYear'];
    costPerMile = json['costPerMile'];
    dateOfInspection = json['dateOfInspection'];
    county = json['county'];
    approvedBy = json['approvedBy'];
    actionNeeded = json['actionNeeded'];
    mixingInventory = json['mixingInventory'];
    type = json['type'];
    adminNotes1 = json['adminNotes1'];
    growthScore = json['growthScore'];
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
    milesCompleted = json['milesCompleted'];
    dueWeek = json['dueWeek'];
    growthRate = json['growthRate'];
    tokenNo = json['tokenNo'];
    nextMaintDue = json['nextMaintDue'];
    cycle = json['cycle'];
    maintDateHistory = json['maintDateHistory'];
    dailyHerbicide = json['dailyHerbicide'];
    crew = json['crew'];
    tblVmaNewMaintenancePlanId = json['tblVmaNewMaintenancePlanId'];
    fdrName = json['fdrName'];
    createDate = json['createDate'];
    dueMoth = json['dueMoth'];
    planType = json['planType'];
    treeType = json['treeType'];
    totalMiles = json['totalMiles'];
    contactorCompany = json['contactorCompany'];
    noColumnName = json['noColumnName'];
    adminNotes2 = json['adminNotes2'];
    ivmTimesheet = json['ivmTimesheet'];
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
    data['mixingInventory'] = mixingInventory;
    data['type'] = type;
    data['adminNotes1'] = adminNotes1;
    data['growthScore'] = growthScore;
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
    data['milesCompleted'] = milesCompleted;
    data['dueWeek'] = dueWeek;
    data['growthRate'] = growthRate;
    data['tokenNo'] = tokenNo;
    data['nextMaintDue'] = nextMaintDue;
    data['cycle'] = cycle;
    data['maintDateHistory'] = maintDateHistory;
    data['dailyHerbicide'] = dailyHerbicide;
    data['crew'] = crew;
    data['tblVmaNewMaintenancePlanId'] = tblVmaNewMaintenancePlanId;
    data['fdrName'] = fdrName;
    data['createDate'] = createDate;
    data['dueMoth'] = dueMoth;
    data['planType'] = planType;
    data['treeType'] = treeType;
    data['totalMiles'] = totalMiles;
    data['contactorCompany'] = contactorCompany;
    data['noColumnName'] = noColumnName;
    data['adminNotes2'] = adminNotes2;
    data['ivmTimesheet'] = ivmTimesheet;
    data['createdBy'] = createdBy;
    data['streetAddress'] = streetAddress;
    data['mapLocation'] = mapLocation;
    return data;
  }
}
