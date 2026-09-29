class CrewInitiatedModel {
  List<Data>? data;
  String? message;

  CrewInitiatedModel({this.data, this.message});

  CrewInitiatedModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
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
      this.visibilityFlag});

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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tokenNo'] = this.tokenNo;
    data['createdBy'] = this.createdBy;
    data['supervisor'] = this.supervisor;
    data['contractor'] = this.contractor;
    data['crew'] = this.crew;
    data['maintType'] = this.maintType;
    data['district'] = this.district;
    data['county'] = this.county;
    data['substation'] = this.substation;
    data['feeder'] = this.feeder;
    data['type'] = this.type;
    data['contractYear'] = this.contractYear;
    data['cycle'] = this.cycle;
    data['lastMaintDone'] = this.lastMaintDone;
    data['nextMaintDue'] = this.nextMaintDue;
    data['contractEndYear'] = this.contractEndYear;
    data['maintCount'] = this.maintCount;
    data['maintDateHistory'] = this.maintDateHistory;
    data['totalMiles'] = this.totalMiles;
    data['costPerMile'] = this.costPerMile;
    data['totalCost'] = this.totalCost;
    data['dueMonth'] = this.dueMonth;
    data['dueWeek'] = this.dueWeek;
    data['budget'] = this.budget;
    data['milesCompleted'] = this.milesCompleted;
    data['milesInProgress'] = this.milesInProgress;
    data['milesPending'] = this.milesPending;
    data['actionNeeded'] = this.actionNeeded;
    data['treeType'] = this.treeType;
    data['growthRate'] = this.growthRate;
    data['growthScore'] = this.growthScore;
    data['status'] = this.status;
    data['documentUpload'] = this.documentUpload;
    data['invoiceCreated'] = this.invoiceCreated;
    data['workPriority'] = this.workPriority;
    data['createDate'] = this.createDate;
    data['tblVmaNewRowMaintenancePlanId'] = this.tblVmaNewRowMaintenancePlanId;
    data['approvedBy'] = this.approvedBy;
    data['planType'] = this.planType;
    data['contractorCompany'] = this.contractorCompany;
    data['streetAddress'] = this.streetAddress;
    data['mapLocation'] = this.mapLocation;
    data['changeOrderImage'] = this.changeOrderImage;
    data['adminNotes1'] = this.adminNotes1;
    data['contractorNotes'] = this.contractorNotes;
    data['adminNotes2'] = this.adminNotes2;
    data['dateOfInspection'] = this.dateOfInspection;
    data['followUpDate'] = this.followUpDate;
    data['dailyHerbicide'] = this.dailyHerbicide;
    data['ivmTimesheet'] = this.ivmTimesheet;
    data['mixingIn'] = this.mixingIn;
    data['estCost'] = this.estCost;
    data['estTime'] = this.estTime;
    data['actualCost'] = this.actualCost;
    data['substationId'] = this.substationId;
    data['rowYear'] = this.rowYear;
    data['budgetType'] = this.budgetType;
    data['visibilityFlag'] = this.visibilityFlag;
    return data;
  }
}
