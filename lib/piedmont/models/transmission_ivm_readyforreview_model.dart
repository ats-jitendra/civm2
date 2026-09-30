class TransmissionIvmReadyforreviewModel {
  List<FindAllTableDataTransIVMReadyForReview>? findAllTableData;

  TransmissionIvmReadyforreviewModel({this.findAllTableData});

  TransmissionIvmReadyforreviewModel.fromJson(Map<String, dynamic> json) {
    if (json['findAllTableData'] != null) {
      findAllTableData = <FindAllTableDataTransIVMReadyForReview>[];
      json['findAllTableData'].forEach((v) {
        findAllTableData!
            .add(new FindAllTableDataTransIVMReadyForReview.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (findAllTableData != null) {
      data['findAllTableData'] =
          findAllTableData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FindAllTableDataTransIVMReadyForReview {
  // int? sepId;
  // int? id;
  String? mileInProgress;
  String? updatedDate;
  String? tokenNo;
  String? createdBy;
  String? supervisor;
  String? contractor;
  String? crew;
  String? maintType;
  String? district;
  String? county;
  String? substation;
  String? fdrName;
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
  String? tblVmaNewMaintenancePlanId;
  String? approvedBy;
  String? planType;
  String? contractorCompany;
  String? streetAddress;
  String? mapLocation;
  String? changeOrderImage;
  String? adminNotes1;
  String? contractorNotes;
  String? supervisorNotes;
  String? adminNotes2;
  String? dateOfInspection;
  String? followUpDate;
  String? estCost;
  String? estTime;
  String? actualCost;
  String? visibilityFlag;
  String? plannerNotes;
  String? transmissionName;
  String? name;
  String? orderDate;
   String? checkPendingStatus;
  // String? budgetType;

  FindAllTableDataTransIVMReadyForReview({
    // this.sepId,
    // this.id,
    this.mileInProgress,
    this.updatedDate,
    this.tokenNo,
    this.createdBy,
    this.supervisor,
    this.contractor,
    this.crew,
    this.maintType,
    this.district,
    this.county,
    this.substation,
    this.fdrName,
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
    this.tblVmaNewMaintenancePlanId,
    this.approvedBy,
    this.planType,
    this.contractorCompany,
    this.streetAddress,
    this.mapLocation,
    this.changeOrderImage,
    this.adminNotes1,
    this.contractorNotes,
    this.supervisorNotes,
    this.adminNotes2,
    this.dateOfInspection,
    this.followUpDate,
    this.estCost,
    this.estTime,
    this.actualCost,
    this.visibilityFlag,
    this.plannerNotes,
    this.transmissionName,
    this.name,
    this.orderDate,
    this.checkPendingStatus
    //  this.budgetType
  });

  FindAllTableDataTransIVMReadyForReview.fromJson(Map<String, dynamic> json) {
    //  sepId = json['sepId'] ?? 0;
    //   id = json['id'] ?? 0;
    mileInProgress = json['mileInProgress'] ?? '';
    updatedDate = json['updatedDate'] ?? '';
    tokenNo = json['tokenNo'] ?? '';
    createdBy = json['createdBy'] ?? '';
    supervisor = json['supervisor'] ?? '';
    contractor = json['contractor'] ?? '';
    crew = json['crew'] ?? '';
    maintType = json['maintType'] ?? '';
    district = json['district'] ?? '';
    county = json['county'] ?? '';
    substation = json['substation'] ?? '';
    fdrName = json['fdrName'] ?? '';
    type = json['type'] ?? '';
    contractYear = json['contractYear'] ?? '';
    cycle = json['cycle'] ?? '';
    lastMaintDone = json['lastMaintDone'] ?? '';
    nextMaintDue = json['nextMaintDue'] ?? '';
    contractEndYear = json['contractEndYear'] ?? '';
    maintCount = json['maintCount'] ?? '';
    maintDateHistory = json['maintDateHistory'] ?? '';
    totalMiles = json['totalMiles'] ?? '';
    costPerMile = json['costPerMile'] ?? '';
    totalCost = json['totalCost'] ?? '';
    dueMonth = json['dueMonth'] ?? '';
    dueWeek = json['dueWeek'] ?? '';
    budget = json['budget'] ?? '';
    milesCompleted = json['milesCompleted'] ?? '';
    milesInProgress = json['milesInProgress'] ?? '';
    milesPending = json['milesPending'] ?? '';
    actionNeeded = json['actionNeeded'] ?? '';
    treeType = json['treeType'] ?? '';
    growthRate = json['growthRate'] ?? '';
    growthScore = json['growthScore'] ?? '';
    status = json['status'] ?? '';
    documentUpload = json['documentUpload'] ?? '';
    invoiceCreated = json['invoiceCreated'] ?? '';
    workPriority = json['workPriority'] ?? '';
    createDate = json['createDate'] ?? '';
    tblVmaNewMaintenancePlanId = json['tblVmaNewMaintenancePlanId'] ?? '';
    approvedBy = json['approvedBy'] ?? '';
    planType = json['planType'] ?? '';
    contractorCompany = json['contractorCompany'] ?? '';
    streetAddress = json['streetAddress'] ?? '';
    mapLocation = json['mapLocation'] ?? '';
    changeOrderImage = json['changeOrderImage'] ?? '';
    adminNotes1 = json['adminNotes1'] ?? '';
    contractorNotes = json['contractorNotes'] ?? '';
    supervisorNotes = json['supervisorNotes'] ?? '';
    adminNotes2 = json['adminNotes2'] ?? '';
    dateOfInspection = json['dateOfInspection'] ?? '';
    followUpDate = json['followUpDate'] ?? '';
    estCost = json['estCost'] ?? '';
    estTime = json['estTime'] ?? '';
    actualCost = json['actualCost'] ?? '';
    visibilityFlag = json['visibilityFlag'] ?? '';
    plannerNotes = json['plannerNotes'] ?? '';
    transmissionName = json['transmission_name'] ?? '';
    name = json['name'] ?? '';
    orderDate = json['order_date'] ?? '';
    // budgetType = json['budgetType'] ?? '';
    checkPendingStatus = json['checkPendingStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    //  data['sepId'] = this.sepId;
    // data['id'] = this.id;
    data['mileInProgress'] = mileInProgress;
    data['updatedDate'] = updatedDate;
    data['tokenNo'] = tokenNo;
    data['createdBy'] = createdBy;
    data['supervisor'] = supervisor;
    data['contractor'] = contractor;
    data['crew'] = crew;
    data['maintType'] = maintType;
    data['district'] = district;
    data['county'] = county;
    data['substation'] = substation;
    data['fdrName'] = fdrName;
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
    data['tblVmaNewMaintenancePlanId'] = tblVmaNewMaintenancePlanId;
    data['approvedBy'] = approvedBy;
    data['planType'] = planType;
    data['contractorCompany'] = contractorCompany;
    data['streetAddress'] = streetAddress;
    data['mapLocation'] = mapLocation;
    data['changeOrderImage'] = changeOrderImage;
    data['adminNotes1'] = adminNotes1;
    data['contractorNotes'] = contractorNotes;
    data['supervisorNotes'] = supervisorNotes;
    data['adminNotes2'] = adminNotes2;
    data['dateOfInspection'] = dateOfInspection;
    data['followUpDate'] = followUpDate;
    data['estCost'] = estCost;
    data['estTime'] = estTime;
    data['actualCost'] = actualCost;
    data['visibilityFlag'] = visibilityFlag;
    data['plannerNotes'] = plannerNotes;
    data['transmission_name'] = transmissionName;
    data['name'] = name;
    data['order_date'] = orderDate;
     data['checkPendingStatus'] = checkPendingStatus;
    // data['budgetType'] = this.budgetType;

    return data;
  }
}
