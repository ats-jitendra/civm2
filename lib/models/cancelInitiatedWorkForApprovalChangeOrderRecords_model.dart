// // ignore: file_names
// class CancelWorkForApprovalInitiatedRecordChangeOrderModel {
//   List<Data>? data;

//   CancelWorkForApprovalInitiatedRecordChangeOrderModel({this.data});

//   CancelWorkForApprovalInitiatedRecordChangeOrderModel.fromJson(
//       Map<String, dynamic> json) {
//     if (json['data'] != null) {
//       data = <Data>[];
//       json['data'].forEach((v) {
//         data!.add(new Data.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class Data {
//   int? id;
//   int? tokenNo;
//   String? createdBy;
//   String? supervisor;
//   String? contractor;
//   String? crew;
//   String? maintType;
//   String? district;
//   String? county;
//   String? substation;
//   String? feeder;
//   String? street;
//   String? type;
//   String? contractYear;
//   String? cycle;
//   String? lastMaintDone;
//   String? nextMaintDue;
//   String? contractEndYear;
//   String? maintCount;
//   String? maintDateHistory;
//   String? totalMiles;
//   String? costPerMile;
//   String? totalCost;
//   String? dueMonth;
//   String? dueWeek;
//   String? budget;
//   String? milesCompleted;
//   String? milesInProgress;
//   String? milesPending;
//   String? actionNeeded;
//   String? treeType;
//   String? growthRate;
//   String? growthScore;
//   String? status;
//   String? documentUpload;
//   String? invoiceCreated;
//   String? workPriority;
//   String? createDate;
//   String? tblVmaNewRowMaintenancePlanId;
//   String? approvedBy;
//   String? planType;
//   String? contractorCompany;
//   String? streetAddress;
//   String? mapLocation;
//   String? changeOrderImage;
//   String? adminNotes1;
//   String? contractorNotes;
//   String? adminNotes2;
//   String? dateOfInspection;
//   String? followUpDate;
//   String? budgetType;
//   String? estCost;
//   String? estTime;
//   String? actualCost;
//   String? rowYear;
//   String? visibilityFlag;

//   Data(
//       {this.id,
//       this.tokenNo,
//       this.createdBy,
//       this.supervisor,
//       this.contractor,
//       this.crew,
//       this.maintType,
//       this.district,
//       this.county,
//       this.substation,
//       this.feeder,
//       this.street,
//       this.type,
//       this.contractYear,
//       this.cycle,
//       this.lastMaintDone,
//       this.nextMaintDue,
//       this.contractEndYear,
//       this.maintCount,
//       this.maintDateHistory,
//       this.totalMiles,
//       this.costPerMile,
//       this.totalCost,
//       this.dueMonth,
//       this.dueWeek,
//       this.budget,
//       this.milesCompleted,
//       this.milesInProgress,
//       this.milesPending,
//       this.actionNeeded,
//       this.treeType,
//       this.growthRate,
//       this.growthScore,
//       this.status,
//       this.documentUpload,
//       this.invoiceCreated,
//       this.workPriority,
//       this.createDate,
//       this.tblVmaNewRowMaintenancePlanId,
//       this.approvedBy,
//       this.planType,
//       this.contractorCompany,
//       this.streetAddress,
//       this.mapLocation,
//       this.changeOrderImage,
//       this.adminNotes1,
//       this.contractorNotes,
//       this.adminNotes2,
//       this.dateOfInspection,
//       this.followUpDate,
//       this.budgetType,
//       this.estCost,
//       this.estTime,
//       this.actualCost,
//       this.rowYear,
//       this.visibilityFlag});

//   Data.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     tokenNo = json['tokenNo'];
//     createdBy = json['createdBy'];
//     supervisor = json['supervisor'];
//     contractor = json['contractor'];
//     crew = json['crew'];
//     maintType = json['maintType'];
//     district = json['district'];
//     county = json['county'];
//     substation = json['substation'];
//     feeder = json['feeder'];
//     street = json['street'];
//     type = json['type'];
//     contractYear = json['contractYear'];
//     cycle = json['cycle'];
//     lastMaintDone = json['lastMaintDone'];
//     nextMaintDue = json['nextMaintDue'];
//     contractEndYear = json['contractEndYear'];
//     maintCount = json['maintCount'];
//     maintDateHistory = json['maintDateHistory'];
//     totalMiles = json['totalMiles'];
//     costPerMile = json['costPerMile'];
//     totalCost = json['totalCost'];
//     dueMonth = json['dueMonth'];
//     dueWeek = json['dueWeek'];
//     budget = json['budget'];
//     milesCompleted = json['milesCompleted'];
//     milesInProgress = json['milesInProgress'];
//     milesPending = json['milesPending'];
//     actionNeeded = json['actionNeeded'];
//     treeType = json['treeType'];
//     growthRate = json['growthRate'];
//     growthScore = json['growthScore'];
//     status = json['status'];
//     documentUpload = json['documentUpload'];
//     invoiceCreated = json['invoiceCreated'];
//     workPriority = json['workPriority'];
//     createDate = json['createDate'];
//     tblVmaNewRowMaintenancePlanId = json['tblVmaNewRowMaintenancePlanId'];
//     approvedBy = json['approvedBy'];
//     planType = json['planType'];
//     contractorCompany = json['contractorCompany'];
//     streetAddress = json['streetAddress'];
//     mapLocation = json['mapLocation'];
//     changeOrderImage = json['changeOrderImage'];
//     adminNotes1 = json['adminNotes1'];
//     contractorNotes = json['contractorNotes'];
//     adminNotes2 = json['adminNotes2'];
//     dateOfInspection = json['dateOfInspection'];
//     followUpDate = json['followUpDate'];
//     budgetType = json['budgetType'];
//     estCost = json['estCost'];
//     estTime = json['estTime'];
//     actualCost = json['actualCost'];
//     rowYear = json['rowYear'];
//     visibilityFlag = json['visibilityFlag'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['tokenNo'] = tokenNo;
//     data['createdBy'] = createdBy;
//     data['supervisor'] = supervisor;
//     data['contractor'] = contractor;
//     data['crew'] = crew;
//     data['maintType'] = maintType;
//     data['district'] = district;
//     data['county'] = county;
//     data['substation'] = substation;
//     data['feeder'] = feeder;
//     data['street'] = street;
//     data['type'] = type;
//     data['contractYear'] = contractYear;
//     data['cycle'] = cycle;
//     data['lastMaintDone'] = lastMaintDone;
//     data['nextMaintDue'] = nextMaintDue;
//     data['contractEndYear'] = contractEndYear;
//     data['maintCount'] = maintCount;
//     data['maintDateHistory'] = maintDateHistory;
//     data['totalMiles'] = totalMiles;
//     data['costPerMile'] = costPerMile;
//     data['totalCost'] = totalCost;
//     data['dueMonth'] = dueMonth;
//     data['dueWeek'] = dueWeek;
//     data['budget'] = budget;
//     data['milesCompleted'] = milesCompleted;
//     data['milesInProgress'] = milesInProgress;
//     data['milesPending'] = milesPending;
//     data['actionNeeded'] = actionNeeded;
//     data['treeType'] = treeType;
//     data['growthRate'] = growthRate;
//     data['growthScore'] = growthScore;
//     data['status'] = status;
//     data['documentUpload'] = documentUpload;
//     data['invoiceCreated'] = invoiceCreated;
//     data['workPriority'] = workPriority;
//     data['createDate'] = createDate;
//     data['tblVmaNewRowMaintenancePlanId'] = tblVmaNewRowMaintenancePlanId;
//     data['approvedBy'] = approvedBy;
//     data['planType'] = planType;
//     data['contractorCompany'] = contractorCompany;
//     data['streetAddress'] = streetAddress;
//     data['mapLocation'] = mapLocation;
//     data['changeOrderImage'] = changeOrderImage;
//     data['adminNotes1'] = adminNotes1;
//     data['contractorNotes'] = contractorNotes;
//     data['adminNotes2'] = adminNotes2;
//     data['dateOfInspection'] = dateOfInspection;
//     data['followUpDate'] = followUpDate;
//     data['budgetType'] = budgetType;
//     data['estCost'] = estCost;
//     data['estTime'] = estTime;
//     data['actualCost'] = actualCost;
//     data['rowYear'] = rowYear;
//     data['visibilityFlag'] = visibilityFlag;
//     return data;
//   }
// }

class CancelWorkForApprovalInitiatedRecordChangeOrderModel {
  List<Data>? data;
  String? message;

  CancelWorkForApprovalInitiatedRecordChangeOrderModel(
      {this.data, this.message});

  CancelWorkForApprovalInitiatedRecordChangeOrderModel.fromJson(
      Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    return data;
  }
}

class Data {
  int? id;
  String? tokenNo;
  String? createdBy;
  String? supervisor;
  String? contractor;
  String? crew;
  String? maintType;
  String? district;
  String? county;
  String? substation;
  String? feeder;
  String? type;
  String? contractYear;
  String? cycle;
  String? lastMaintDone;
  String? nextMaintDue;
  String? contractEndYear;
  String? maintCount;
  String? maintDateHistory;
  String? totalMiles;
  String? costPerMile;
  String? totalCost;
  String? dueMonth;
  String? dueWeek;
  String? budget;
  String? milesCompleted;
  String? milesInProgress;
  String? milesPending;
  String? actionNeeded;
  String? treeType;
  String? growthRate;
  String? growthScore;
  String? status;
  String? documentUpload;
  String? invoiceCreated;
  String? workPriority;
  String? createDate;
  String? tblVmaNewRowMaintenancePlanId;
  String? approvedBy;
  String? planType;
  String? contractorCompany;
  String? streetAddress;
  String? mapLocation;
  String? changeOrderImage;
  String? adminNotes1;
  String? contractorNotes;
  String? adminNotes2;
  String? dateOfInspection;
  String? followUpDate;
  String? dailyHerbicide;
  String? ivmTimesheet;
  String? mixingIn;
  String? estCost;
  String? estTime;
  String? actualCost;
  int? substationId;
  String? rowYear;
  String? budgetType;
  String? visibilityFlag;
  String? plannerNotes;
  String? supervisorNotes;
  String? initiatedBy;
  String? addChatNotes;

  Data(
      {this.id,
      this.tokenNo,
      this.createdBy,
      this.supervisor,
      this.contractor,
      this.crew,
      this.maintType,
      this.district,
      this.county,
      this.substation,
      this.feeder,
      this.type,
      this.contractYear,
      this.cycle,
      this.lastMaintDone,
      this.nextMaintDue,
      this.contractEndYear,
      this.maintCount,
      this.maintDateHistory,
      this.totalMiles,
      this.costPerMile,
      this.totalCost,
      this.dueMonth,
      this.dueWeek,
      this.budget,
      this.milesCompleted,
      this.milesInProgress,
      this.milesPending,
      this.actionNeeded,
      this.treeType,
      this.growthRate,
      this.growthScore,
      this.status,
      this.documentUpload,
      this.invoiceCreated,
      this.workPriority,
      this.createDate,
      this.tblVmaNewRowMaintenancePlanId,
      this.approvedBy,
      this.planType,
      this.contractorCompany,
      this.streetAddress,
      this.mapLocation,
      this.changeOrderImage,
      this.adminNotes1,
      this.contractorNotes,
      this.adminNotes2,
      this.dateOfInspection,
      this.followUpDate,
      this.dailyHerbicide,
      this.ivmTimesheet,
      this.mixingIn,
      this.estCost,
      this.estTime,
      this.actualCost,
      this.substationId,
      this.rowYear,
      this.budgetType,
      this.visibilityFlag,
      this.plannerNotes,
      this.supervisorNotes,
      this.initiatedBy,
      this.addChatNotes});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tokenNo = json['tokenNo'];
    createdBy = json['createdBy'];
    supervisor = json['supervisor'];
    contractor = json['contractor'];
    crew = json['crew'];
    maintType = json['maintType'];
    district = json['district'];
    county = json['county'];
    substation = json['substation'];
    feeder = json['feeder'];
    type = json['type'];
    contractYear = json['contractYear'];
    cycle = json['cycle'];
    lastMaintDone = json['lastMaintDone'];
    nextMaintDue = json['nextMaintDue'];
    contractEndYear = json['contractEndYear'];
    maintCount = json['maintCount'];
    maintDateHistory = json['maintDateHistory'];
    totalMiles = json['totalMiles'];
    costPerMile = json['costPerMile'];
    totalCost = json['totalCost'];
    dueMonth = json['dueMonth'];
    dueWeek = json['dueWeek'];
    budget = json['budget'];
    milesCompleted = json['milesCompleted'];
    milesInProgress = json['milesInProgress'];
    milesPending = json['milesPending'];
    actionNeeded = json['actionNeeded'];
    treeType = json['treeType'];
    growthRate = json['growthRate'];
    growthScore = json['growthScore'];
    status = json['status'];
    documentUpload = json['documentUpload'];
    invoiceCreated = json['invoiceCreated'];
    workPriority = json['workPriority'];
    createDate = json['createDate'];
    tblVmaNewRowMaintenancePlanId = json['tblVmaNewRowMaintenancePlanId'];
    approvedBy = json['approvedBy'];
    planType = json['planType'];
    contractorCompany = json['contractorCompany'];
    streetAddress = json['streetAddress'];
    mapLocation = json['mapLocation'];
    changeOrderImage = json['changeOrderImage'];
    adminNotes1 = json['adminNotes1'];
    contractorNotes = json['contractorNotes'];
    adminNotes2 = json['adminNotes2'];
    dateOfInspection = json['dateOfInspection'];
    followUpDate = json['followUpDate'];
    dailyHerbicide = json['dailyHerbicide'];
    ivmTimesheet = json['ivmTimesheet'];
    mixingIn = json['mixingIn'];
    estCost = json['estCost'];
    estTime = json['estTime'];
    actualCost = json['actualCost'];
    substationId = json['substationId'];
    rowYear = json['rowYear'];
    budgetType = json['budgetType'];
    visibilityFlag = json['visibilityFlag'];
    plannerNotes = json['plannerNotes'];
    supervisorNotes = json['supervisorNotes'];
    initiatedBy = json['initiatedBy'];
    addChatNotes = json['addChatNotes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['tokenNo'] = tokenNo;
    data['createdBy'] = createdBy;
    data['supervisor'] = supervisor;
    data['contractor'] = contractor;
    data['crew'] = crew;
    data['maintType'] = maintType;
    data['district'] = district;
    data['county'] = county;
    data['substation'] = substation;
    data['feeder'] = feeder;
    data['type'] = type;
    data['contractYear'] = contractYear;
    data['cycle'] = cycle;
    data['lastMaintDone'] = lastMaintDone;
    data['nextMaintDue'] = nextMaintDue;
    data['contractEndYear'] = contractEndYear;
    data['maintCount'] = maintCount;
    data['maintDateHistory'] = maintDateHistory;
    data['totalMiles'] = totalMiles;
    data['costPerMile'] = costPerMile;
    data['totalCost'] = totalCost;
    data['dueMonth'] = dueMonth;
    data['dueWeek'] = dueWeek;
    data['budget'] = budget;
    data['milesCompleted'] = milesCompleted;
    data['milesInProgress'] = milesInProgress;
    data['milesPending'] = milesPending;
    data['actionNeeded'] = actionNeeded;
    data['treeType'] = treeType;
    data['growthRate'] = growthRate;
    data['growthScore'] = growthScore;
    data['status'] = status;
    data['documentUpload'] = documentUpload;
    data['invoiceCreated'] = invoiceCreated;
    data['workPriority'] = workPriority;
    data['createDate'] = createDate;
    data['tblVmaNewRowMaintenancePlanId'] = tblVmaNewRowMaintenancePlanId;
    data['approvedBy'] = approvedBy;
    data['planType'] = planType;
    data['contractorCompany'] = contractorCompany;
    data['streetAddress'] = streetAddress;
    data['mapLocation'] = mapLocation;
    data['changeOrderImage'] = changeOrderImage;
    data['adminNotes1'] = adminNotes1;
    data['contractorNotes'] = contractorNotes;
    data['adminNotes2'] = adminNotes2;
    data['dateOfInspection'] = dateOfInspection;
    data['followUpDate'] = followUpDate;
    data['dailyHerbicide'] = dailyHerbicide;
    data['ivmTimesheet'] = ivmTimesheet;
    data['mixingIn'] = mixingIn;
    data['estCost'] = estCost;
    data['estTime'] = estTime;
    data['actualCost'] = actualCost;
    data['substationId'] = substationId;
    data['rowYear'] = rowYear;
    data['budgetType'] = budgetType;
    data['visibilityFlag'] = visibilityFlag;
    data['plannerNotes'] = plannerNotes;
    data['supervisorNotes'] = supervisorNotes;
    data['initiatedBy'] = initiatedBy;
    data['addChatNotes'] = addChatNotes;

    return data;
  }
}
