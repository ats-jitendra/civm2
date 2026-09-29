// ignore: file_names
class MaintenanceReportViewModelNew {
  List<FindSubstationAndSubIds>? findSubstationAndSubIds;
  List<FindAllJoinDatas>? findAllJoinDatas;
  List<FindAllFdrBySubstation>? findAllFdrBySubstation;
  List<FindAllTypeBySubstations>? findAllTypeBySubstations;

  MaintenanceReportViewModelNew(
      {this.findSubstationAndSubIds,
      this.findAllJoinDatas,
      this.findAllFdrBySubstation,
      this.findAllTypeBySubstations});

  MaintenanceReportViewModelNew.fromJson(Map<String, dynamic> json) {
    if (json['findSubstationAndSubIds'] != null) {
      findSubstationAndSubIds = <FindSubstationAndSubIds>[];
      json['findSubstationAndSubIds'].forEach((v) {
        findSubstationAndSubIds!.add(new FindSubstationAndSubIds.fromJson(v));
      });
    }
    if (json['findAllJoinDatas'] != null) {
      findAllJoinDatas = <FindAllJoinDatas>[];
      json['findAllJoinDatas'].forEach((v) {
        findAllJoinDatas!.add(new FindAllJoinDatas.fromJson(v));
      });
    }
    if (json['findAllFdrBySubstation'] != null) {
      findAllFdrBySubstation = <FindAllFdrBySubstation>[];
      json['findAllFdrBySubstation'].forEach((v) {
        findAllFdrBySubstation!.add(new FindAllFdrBySubstation.fromJson(v));
      });
    }
    if (json['findAllTypeBySubstations'] != null) {
      findAllTypeBySubstations = <FindAllTypeBySubstations>[];
      json['findAllTypeBySubstations'].forEach((v) {
        findAllTypeBySubstations!.add(new FindAllTypeBySubstations.fromJson(v));
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
  String? budgetType;
  String? masterJobNo;
  String? contractYear;
  String? maintType;
  int? tokenNo;
  String? feederName;
  String? subStationName;
  String? status;
  String? showICon;

  FindAllJoinDatas(
      {this.budgetType,
      this.masterJobNo,
      this.contractYear,
      this.maintType,
      this.tokenNo,
      this.feederName,
      this.subStationName,
      this.status,
      this.showICon});

  FindAllJoinDatas.fromJson(Map<String, dynamic> json) {
    budgetType = json['budgetType'];
    masterJobNo = json['masterJobNo'];
    contractYear = json['contractYear'];
    maintType = json['maintType'];
    tokenNo = json['tokenNo'];
    feederName = json['feederName'];
    subStationName = json['subStationName'];
    status = json['status'];
    showICon = json['showICon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['budgetType'] = budgetType;
    data['masterJobNo'] = masterJobNo;
    data['contractYear'] = contractYear;
    data['maintType'] = maintType;
    data['tokenNo'] = tokenNo;
    data['feederName'] = feederName;
    data['subStationName'] = subStationName;
    data['status'] = status;
    data['showICon'] = showICon;
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
