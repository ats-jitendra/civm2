class ContractorDispatcherDashboardModel {
  int? distributionPending;
  int? distributionClosed;
  int? distributionRejected;
  int? transmissionIVMPending;
  int? transmissionIVMClosed;
  int? transmissionHerbicidePending;
  int? transmissionHerbicideClosed;
  int? annualHerbicidePending;
  int? annualHerbicideClosed;
  int? distributionReadyForInspection;

  //
  int? iVMAndHerbicideInspectionPending;
  int? regularIVMPending;
  int? regularIVMCompleted;
  int? regularIVMPendingApproval;
  int? midCyclePending;
  int? midCycleCompleted;
  int? midCyclePendingApproval;
  int? exceptionAndChangeOrderPending;
  int? exceptionAndChangeOrderCompleted;
  int? exceptionAndChangeOrderPendingApproval;
  int? allCompleted;
  int? allPendingApproval;
  int? pendingOrder;
  int? completeOrder;
  int? lastMonthCmpt;
  List<FindSmMaintTestResultRequestDatas>? findSmMaintTestResultRequestDatas;
  int? lastMonthPending;
  List<FindMonthAndMiles>? findMonthAndMiles;
  // List<FindMonthMilesByRowMethod>? findMonthMilesByRowMethod;

  ContractorDispatcherDashboardModel({
    this.distributionReadyForInspection,
    this.distributionPending,
    this.distributionClosed,
    this.distributionRejected,
    this.transmissionIVMPending,
    this.transmissionIVMClosed,
    this.transmissionHerbicidePending,
    this.transmissionHerbicideClosed,
    this.annualHerbicidePending,
    this.annualHerbicideClosed,
    this.iVMAndHerbicideInspectionPending,
    this.regularIVMPending,
    this.regularIVMCompleted,
    this.regularIVMPendingApproval,
    this.midCyclePending,
    this.midCycleCompleted,
    this.midCyclePendingApproval,
    this.exceptionAndChangeOrderPending,
    this.exceptionAndChangeOrderCompleted,
    this.exceptionAndChangeOrderPendingApproval,
    this.allCompleted,
    this.allPendingApproval,
    this.pendingOrder,
    this.completeOrder,
    this.lastMonthCmpt,
    this.findSmMaintTestResultRequestDatas,
    this.lastMonthPending,
    this.findMonthAndMiles,
    //  this.findMonthMilesByRowMethod,
  });

  ContractorDispatcherDashboardModel.fromJson(Map<String, dynamic> json) {
    distributionReadyForInspection = json['distribution_ready_for_inspection'];
    distributionPending = json['distribution_pending'];
    distributionClosed = json['distribution_closed'];
    distributionRejected = json['distribution_rejected'];
    transmissionIVMPending = json['transmissionIVM_pending'];
    transmissionIVMClosed = json['transmissionIVM_closed'];
    transmissionHerbicidePending = json['transmissionHerbicide_pending'];
    transmissionHerbicideClosed = json['transmissionHerbicide_closed'];
    annualHerbicidePending = json['annualHerbicide_pending'];
    annualHerbicideClosed = json['annualHerbicide_closed'];
    //
    iVMAndHerbicideInspectionPending = json['IVMAndHerbicideInspectionPending'];
    regularIVMPending = json['regularIVMPending'];
    regularIVMCompleted = json['regularIVMCompleted'];
    regularIVMPendingApproval = json['regularIVMPendingApproval'];
    midCyclePending = json['midCyclePending'];
    midCycleCompleted = json['midCycleCompleted'];
    midCyclePendingApproval = json['midCyclePendingApproval'];
    exceptionAndChangeOrderPending = json['exceptionAndChangeOrderPending'];
    exceptionAndChangeOrderCompleted = json['exceptionAndChangeOrderCompleted'];
    exceptionAndChangeOrderPendingApproval =
        json['exceptionAndChangeOrderPendingApproval'];
    allCompleted = json['allCompleted'];
    allPendingApproval = json['allPendingApproval'];
    pendingOrder = json['pendingOrder'];
    completeOrder = json['completeOrder'];
    lastMonthCmpt = json['lastMonthCmpt'];

    if (json['findSmMaintTestResultRequestDatas'] != null) {
      findSmMaintTestResultRequestDatas = <FindSmMaintTestResultRequestDatas>[];
      json['findSmMaintTestResultRequestDatas'].forEach((v) {
        findSmMaintTestResultRequestDatas!
            .add(FindSmMaintTestResultRequestDatas.fromJson(v));
      });
    }
    lastMonthPending = json['lastMonthPending'];
    if (json['findMonthAndMiles'] != null) {
      findMonthAndMiles = <FindMonthAndMiles>[];
      json['findMonthAndMiles'].forEach((v) {
        findMonthAndMiles!.add(FindMonthAndMiles.fromJson(v));
      });
    }
    // if (json['findMonthMilesByRowMethod'] != null) {
    //   findMonthMilesByRowMethod = <FindMonthMilesByRowMethod>[];
    //   json['findMonthMilesByRowMethod'].forEach((v) {
    //     findMonthMilesByRowMethod!.add(FindMonthMilesByRowMethod.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['distributionReadyForInspection'] = distributionReadyForInspection;
    data['distribution_pending'] = distributionPending;
    data['distribution_closed'] = distributionClosed;
    data['distributionRejected'] = distributionRejected;
    data['transmissionIVM_pending'] = transmissionHerbicidePending;
    data['transmissionIVM_closed'] = transmissionHerbicideClosed;
    data['transmissionHerbicide_pending'] = transmissionHerbicidePending;
    data['transmissionHerbicide_closed'] = transmissionHerbicideClosed;
    data['annualHerbicide_pending'] = annualHerbicidePending;
    data['annualHerbicide_closed'] = annualHerbicideClosed;

    data['IVMAndHerbicideInspectionPending'] = iVMAndHerbicideInspectionPending;
    data['regularIVMPending'] = regularIVMPending;
    data['regularIVMCompleted'] = regularIVMCompleted;
    data['regularIVMPendingApproval'] = regularIVMPendingApproval;
    data['midCyclePending'] = midCyclePending;
    data['midCycleCompleted'] = midCycleCompleted;
    data['midCyclePendingApproval'] = midCyclePendingApproval;
    data['exceptionAndChangeOrderPending'] = exceptionAndChangeOrderPending;
    data['exceptionAndChangeOrderCompleted'] = exceptionAndChangeOrderCompleted;
    data['exceptionAndChangeOrderPendingApproval'] =
        exceptionAndChangeOrderPendingApproval;
    data['allCompleted'] = allCompleted;
    data['allPendingApproval'] = allPendingApproval;
    data['pendingOrder'] = pendingOrder;
    data['completeOrder'] = completeOrder;
    data['lastMonthCmpt'] = lastMonthCmpt;

    if (findSmMaintTestResultRequestDatas != null) {
      data['findSmMaintTestResultRequestDatas'] =
          findSmMaintTestResultRequestDatas!.map((v) => v.toJson()).toList();
    }
    data['lastMonthPending'] = lastMonthPending;
    if (findMonthAndMiles != null) {
      data['findMonthAndMiles'] =
          findMonthAndMiles!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FindSmMaintTestResultRequestDatas {
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
  int? nextMaintDue;
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
  String? noColumnName;
  String? estTime;
  String? adminNotes2;
  String? createdBy;
  String? streetAddress;
  String? mapLocation;
  String? supervisorNotes;
  String? plannerNotes;

  FindSmMaintTestResultRequestDatas(
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
      this.contractorCompany,
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
      this.noColumnName,
      this.estTime,
      this.adminNotes2,
      this.createdBy,
      this.streetAddress,
      this.mapLocation,
      this.supervisorNotes,
      this.plannerNotes});

  FindSmMaintTestResultRequestDatas.fromJson(Map<String, dynamic> json) {
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
    noColumnName = json['noColumnName'];
    estTime = json['estTime'];
    adminNotes2 = json['adminNotes2'];
    createdBy = json['createdBy'];
    streetAddress = json['streetAddress'];
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
    data['noColumnName'] = noColumnName;
    data['estTime'] = estTime;
    data['adminNotes2'] = adminNotes2;
    data['createdBy'] = createdBy;
    data['streetAddress'] = streetAddress;
    data['mapLocation'] = mapLocation;
    data['supervisorNotes'] = supervisorNotes;
    data['plannerNotes'] = plannerNotes;

    return data;
  }
}

class FindMonthAndMiles {
  String? month;
  double? miles;

  FindMonthAndMiles({this.month, this.miles});

  FindMonthAndMiles.fromJson(Map<String, dynamic> json) {
    month = json['month'];
    miles = json['miles'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['month'] = month;
    data['miles'] = miles;
    return data;
  }
}

// class FindMonthMilesByRowMethod {
//   String? month;
//   int? miles;
//   String? rowMethod;
//   String? crew;

//   FindMonthMilesByRowMethod(
//       {this.month, this.miles, this.rowMethod, this.crew});

//   FindMonthMilesByRowMethod.fromJson(Map<String, dynamic> json) {
//     month = json['month'];
//     miles = json['miles'];
//     rowMethod = json['rowMethod'];
//     crew = json['crew'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['month'] = month;
//     data['miles'] = miles;
//     data['rowMethod'] = rowMethod;
//     data['crew'] = crew;
//     return data;
//   }
// }
