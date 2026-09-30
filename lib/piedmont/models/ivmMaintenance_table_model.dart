// ignore: file_names
class IVMMaintenanceTableDataModel {
  List<GetAllTableData>? getAllTableData;

  IVMMaintenanceTableDataModel({this.getAllTableData});

  IVMMaintenanceTableDataModel.fromJson(Map<String, dynamic> json) {
    if (json['getAllTableData'] != null) {
      getAllTableData = <GetAllTableData>[];
      json['getAllTableData'].forEach((v) {
        getAllTableData!.add(GetAllTableData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (getAllTableData != null) {
      data['getAllTableData'] =
          getAllTableData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetAllTableData {
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
  String? rowYear;
  String? documentUpload;
  String? dueMonth;
  String? milesInProgress;
  String? maintType;
  String? substation;
  String? contractorNotes;
  int? id;
  String? budget;
  String? lastMaintDone;
  String? contractorCompany;
  String? milesPending;
  String? maintCount;
  String? contractEndYear;
  String? followUpDate;
  String? district;
  String? changeOrderImage;
  String? workPriority;
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
  String? cycle;
  String? maintDateHistory;
  String? dailyHerbicide;
  String? crew;
  int? substationId;
  int? feederId;
  String? tblVmaNewMaintenancePlanId;
  String? fdrName;
  String? createDate;
  String? actualCost;
  String? planType;
  String? estCost;
  String? treeType;
  String? totalMiles;
  String? estTime;
  String? adminNotes2;
  String? ivmTimesheet;
  String? createdBy;
  String? streetAddress;
  String? visibilityFlag;
  String? mapLocation;

  GetAllTableData(
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
      this.rowYear,
      this.documentUpload,
      this.dueMonth,
      this.milesInProgress,
      this.maintType,
      this.substation,
      this.contractorNotes,
      this.id,
      this.budget,
      this.lastMaintDone,
      this.contractorCompany,
      this.milesPending,
      this.maintCount,
      this.contractEndYear,
      this.followUpDate,
      this.district,
      this.changeOrderImage,
      this.workPriority,
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
      this.dailyHerbicide,
      this.crew,
      this.substationId,
      this.feederId,
      this.tblVmaNewMaintenancePlanId,
      this.fdrName,
      this.createDate,
      this.actualCost,
      this.planType,
      this.estCost,
      this.treeType,
      this.totalMiles,
      this.estTime,
      this.adminNotes2,
      this.ivmTimesheet,
      this.createdBy,
      this.streetAddress,
      this.visibilityFlag,
      this.mapLocation});

  GetAllTableData.fromJson(Map<String, dynamic> json) {
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
    rowYear = json['rowYear'];
    documentUpload = json['documentUpload'];
    dueMonth = json['dueMonth'];
    milesInProgress = json['milesInProgress'];
    maintType = json['maintType'];
    substation = json['substation'];
    contractorNotes = json['contractorNotes'];
    id = json['id'];
    budget = json['budget'];
    lastMaintDone = json['lastMaintDone'];
    contractorCompany = json['contractorCompany'];
    milesPending = json['milesPending'];
    maintCount = json['maintCount'];
    contractEndYear = json['contractEndYear'];
    followUpDate = json['followUpDate'];
    district = json['district'];
    changeOrderImage = json['changeOrderImage'];
    workPriority = json['workPriority'];
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
    dailyHerbicide = json['dailyHerbicide'];
    crew = json['crew'];
    substationId = json['substationId'];
    feederId = json['feederId'];
    tblVmaNewMaintenancePlanId = json['tblVmaNewMaintenancePlanId'];
    fdrName = json['fdrName'];
    createDate = json['createDate'];
    actualCost = json['actualCost'];
    planType = json['planType'];
    estCost = json['estCost'];
    treeType = json['treeType'];
    totalMiles = json['totalMiles'];
    estTime = json['estTime'];
    adminNotes2 = json['adminNotes2'];
    ivmTimesheet = json['ivmTimesheet'];
    createdBy = json['createdBy'];
    streetAddress = json['streetAddress'];
    visibilityFlag = json['visibilityFlag'];
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
    data['rowYear'] = rowYear;
    data['documentUpload'] = documentUpload;
    data['dueMonth'] = dueMonth;
    data['milesInProgress'] = milesInProgress;
    data['maintType'] = maintType;
    data['substation'] = substation;
    data['contractorNotes'] = contractorNotes;
    data['id'] = id;
    data['budget'] = budget;
    data['lastMaintDone'] = lastMaintDone;
    data['contractorCompany'] = contractorCompany;
    data['milesPending'] = milesPending;
    data['maintCount'] = maintCount;
    data['contractEndYear'] = contractEndYear;
    data['followUpDate'] = followUpDate;
    data['district'] = district;
    data['changeOrderImage'] = changeOrderImage;
    data['workPriority'] = workPriority;
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
    data['dailyHerbicide'] = dailyHerbicide;
    data['crew'] = crew;
    data['substationId'] = substationId;
    data['feederId'] = feederId;
    data['tblVmaNewMaintenancePlanId'] = tblVmaNewMaintenancePlanId;
    data['fdrName'] = fdrName;
    data['createDate'] = createDate;
    data['actualCost'] = actualCost;
    data['planType'] = planType;
    data['estCost'] = estCost;
    data['treeType'] = treeType;
    data['totalMiles'] = totalMiles;
    data['estTime'] = estTime;
    data['adminNotes2'] = adminNotes2;
    data['ivmTimesheet'] = ivmTimesheet;
    data['createdBy'] = createdBy;
    data['streetAddress'] = streetAddress;
    data['visibilityFlag'] = visibilityFlag;
    data['mapLocation'] = mapLocation;
    return data;
  }
}
