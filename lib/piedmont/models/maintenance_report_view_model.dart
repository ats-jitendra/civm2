class MaintenanceReportViewModel {
  List<FindSubstationAndSubIds>? findSubstationAndSubIds;
  List<FindAllJoinDatas>? findAllJoinDatas;
  List<FindAllFdrBySubstation>? findAllFdrBySubstation;
  List<FindAllTypeBySubstations>? findAllTypeBySubstations;

  MaintenanceReportViewModel(
      {this.findSubstationAndSubIds,
      this.findAllJoinDatas,
      this.findAllFdrBySubstation,
      this.findAllTypeBySubstations});

  MaintenanceReportViewModel.fromJson(Map<String, dynamic> json) {
    if (json['findSubstationAndSubIds'] != null) {
      findSubstationAndSubIds = <FindSubstationAndSubIds>[];
      json['findSubstationAndSubIds'].forEach((v) {
        findSubstationAndSubIds!.add(FindSubstationAndSubIds.fromJson(v));
      });
    }
    if (json['findAllJoinDatas'] != null) {
      findAllJoinDatas = <FindAllJoinDatas>[];
      json['findAllJoinDatas'].forEach((v) {
        findAllJoinDatas!.add(FindAllJoinDatas.fromJson(v));
      });
    }
    if (json['findAllFdrBySubstation'] != null) {
      findAllFdrBySubstation = <FindAllFdrBySubstation>[];
      json['findAllFdrBySubstation'].forEach((v) {
        findAllFdrBySubstation!.add(FindAllFdrBySubstation.fromJson(v));
      });
    }
    if (json['findAllTypeBySubstations'] != null) {
      findAllTypeBySubstations = <FindAllTypeBySubstations>[];
      json['findAllTypeBySubstations'].forEach((v) {
        findAllTypeBySubstations!.add(FindAllTypeBySubstations.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (findSubstationAndSubIds != null) {
      data['findSubstationAndSubIds'] =
          findSubstationAndSubIds!.map((v) => v.toJson()).toList();
    }
    if (findAllJoinDatas != null) {
      data['findAllJoinDatas'] =
          findAllJoinDatas!.map((v) => v.toJson()).toList();
    }
    if (findAllFdrBySubstation != null) {
      data['findAllFdrBySubstation'] =
          findAllFdrBySubstation!.map((v) => v.toJson()).toList();
    }
    if (findAllTypeBySubstations != null) {
      data['findAllTypeBySubstations'] =
          findAllTypeBySubstations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FindSubstationAndSubIds {
  String? subId;
  String? subStation;

  FindSubstationAndSubIds({this.subId, this.subStation});

  FindSubstationAndSubIds.fromJson(Map<String, dynamic> json) {
    subId = json['subId'];
    subStation = json['subStation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['subId'] = subId;
    data['subStation'] = subStation;
    return data;
  }
}

class FindAllJoinDatas {
  String? mileInProgress;
  String? updatedDate;
  String? maintType;
  String? contractYear;
  int? tokenNo;
  String? nextMaintDue;
  String? totalCost;
  String? fileUpload;
  String? type;
  String? cycle;
  String? subStateName;
  String? name;
  int? tblSubMilesCostId;
  String? feederName;
  String? status;
  String? createDate;
  int? id;
  String? costPerMile;
  String? totalMiles;
  String? milesPending;
  String? milesCompleted;
  String? notes;
  String? budgetType;
  String? createdBy;
  String? checkPendingStatus;

  FindAllJoinDatas(
      {this.mileInProgress,
      this.updatedDate,
      this.maintType,
      this.contractYear,
      this.tokenNo,
      this.nextMaintDue,
      this.totalCost,
      this.fileUpload,
      this.type,
      this.cycle,
      this.subStateName,
      this.name,
      this.tblSubMilesCostId,
      this.feederName,
      this.status,
      this.createDate,
      this.id,
      this.costPerMile,
      this.totalMiles,
      this.milesPending,
      this.milesCompleted,
      this.notes,
      this.budgetType,
      this.createdBy,
      this.checkPendingStatus});

  FindAllJoinDatas.fromJson(Map<String, dynamic> json) {
    mileInProgress = json['mileInProgress'] ?? 0.0;
    updatedDate = json['updatedDate'];
    maintType = json['MaintType'];
    contractYear = json['contractYear'];
    tokenNo = json['tokenNo'];
    nextMaintDue = json['nextMaintDue'];
    totalCost = json['totalCost'];
    fileUpload = json['fileUpload'];
    type = json['type'];
    cycle = json['cycle'];
    subStateName = json['subStateName'];
    name = json['name'];
    tblSubMilesCostId = json['tblSubMilesCostId'];
    feederName = json['feederName'];
    status = json['status'];
    createDate = json['createDate'];
    id = json['id'];
    costPerMile = json['costPerMile'];

    totalMiles = json['totalMiles'];
    milesPending = json['milesPending'];
    milesCompleted = json['milesCompleted'];
    notes = json['notes'];
    budgetType = json['budgetType'];
    createdBy = json['createdBy'];
    checkPendingStatus = json['checkPendingStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mileInProgress'] = mileInProgress;
    data['updatedDate'] = updatedDate;
    data['MaintType'] = maintType;
    data['contractYear'] = contractYear;
    data['tokenNo'] = tokenNo;
    data['nextMaintDue'] = nextMaintDue;
    data['totalCost'] = totalCost;
    data['fileUpload'] = fileUpload;
    data['type'] = type;
    data['cycle'] = cycle;
    data['subStateName'] = subStateName;
    data['name'] = name;
    data['tblSubMilesCostId'] = tblSubMilesCostId;
    data['feederName'] = feederName;
    data['status'] = status;
    data['createDate'] = createDate;
    data['id'] = id;
    data['costPerMile'] = costPerMile;
    data['totalMiles'] = totalMiles;
    data['milesPending'] = milesPending;
    data['milesCompleted'] = milesCompleted;
    data['notes'] = notes;
    data['budgetType'] = budgetType;
    data['createdBy'] = createdBy;
    data['checkPendingStatus'] = checkPendingStatus;
    return data;
  }
}

class FindAllFdrBySubstation {
  String? subId;
  String? feeder;
  String? subStation;
  String? feederName;
  String? feedrId;

  FindAllFdrBySubstation(
      {this.subId,
      this.feeder,
      this.subStation,
      this.feederName,
      this.feedrId});

  FindAllFdrBySubstation.fromJson(Map<String, dynamic> json) {
    subId = json['subId'];
    feeder = json['feeder'];
    subStation = json['subStation'];
    feederName = json['feederName'];
    feedrId = json['feedrId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['subId'] = subId;
    data['feeder'] = feeder;
    data['subStation'] = subStation;
    data['feederName'] = feederName;
    data['feedrId'] = feedrId;
    return data;
  }
}

class FindAllTypeBySubstations {
  String? type;

  FindAllTypeBySubstations({this.type});

  FindAllTypeBySubstations.fromJson(Map<String, dynamic> json) {
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    return data;
  }
}
