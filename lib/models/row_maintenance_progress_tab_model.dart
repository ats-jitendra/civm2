class RowMaintenanceProgressTabModel {
  List<CycleLists>? cycleLists;
  List<SubStations>? subStations;
  List<PercentAndStatus>? percentAndStatus;
  List<FeederLists>? feederLists;
  List<RowMAINTENANCEPROGRESSData>? rowMAINTENANCEPROGRESSData;
  List<CrewsData>? crewsData;
  List<NextMaintDueYear>? nextMaintDueYear;
  List<CompleteProgressAndPending>? completeProgressAndPending;
  List<CompleteProgressAndPendingData>? completeProgressAndPendingData;

  RowMaintenanceProgressTabModel(
      {this.cycleLists,
      this.subStations,
      this.percentAndStatus,
      this.feederLists,
      this.rowMAINTENANCEPROGRESSData,
      this.completeProgressAndPendingData,
      this.crewsData,
      this.nextMaintDueYear,
      this.completeProgressAndPending});

  RowMaintenanceProgressTabModel.fromJson(Map<String, dynamic> json) {
    if (json['cycleLists'] != null) {
      cycleLists = <CycleLists>[];
      json['cycleLists'].forEach((v) {
        cycleLists!.add(CycleLists.fromJson(v));
      });
    }
    if (json['subStations'] != null) {
      subStations = <SubStations>[];
      json['subStations'].forEach((v) {
        subStations!.add(SubStations.fromJson(v));
      });
    }
    if (json['percentAndStatus'] != null) {
      percentAndStatus = <PercentAndStatus>[];
      json['percentAndStatus'].forEach((v) {
        percentAndStatus!.add(PercentAndStatus.fromJson(v));
      });
    }
    if (json['feederLists'] != null) {
      feederLists = <FeederLists>[];
      json['feederLists'].forEach((v) {
        feederLists!.add(FeederLists.fromJson(v));
      });
    }
    if (json['rowMAINTENANCEPROGRESSData'] != null) {
      rowMAINTENANCEPROGRESSData = <RowMAINTENANCEPROGRESSData>[];
      json['rowMAINTENANCEPROGRESSData'].forEach((v) {
        rowMAINTENANCEPROGRESSData!.add(RowMAINTENANCEPROGRESSData.fromJson(v));
      });
    }
    if (json['completeProgressAndPendingData'] != null) {
      completeProgressAndPendingData = <CompleteProgressAndPendingData>[];
      json['completeProgressAndPendingData'].forEach((v) {
        completeProgressAndPendingData!
            .add(new CompleteProgressAndPendingData.fromJson(v));
      });
    }
    if (json['crewsData'] != null) {
      crewsData = <CrewsData>[];
      json['crewsData'].forEach((v) {
        crewsData!.add(CrewsData.fromJson(v));
      });
    }
    if (json['next_maint_due_year'] != null) {
      nextMaintDueYear = <NextMaintDueYear>[];
      json['next_maint_due_year'].forEach((v) {
        nextMaintDueYear!.add(NextMaintDueYear.fromJson(v));
      });
    }
    if (json['completeProgressAndPending'] != null) {
      completeProgressAndPending = <CompleteProgressAndPending>[];
      json['completeProgressAndPending'].forEach((v) {
        completeProgressAndPending!.add(CompleteProgressAndPending.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (cycleLists != null) {
      data['cycleLists'] = cycleLists!.map((v) => v.toJson()).toList();
    }
    if (subStations != null) {
      data['subStations'] = subStations!.map((v) => v.toJson()).toList();
    }
    if (percentAndStatus != null) {
      data['percentAndStatus'] =
          percentAndStatus!.map((v) => v.toJson()).toList();
    }
    if (feederLists != null) {
      data['feederLists'] = feederLists!.map((v) => v.toJson()).toList();
    }
    if (rowMAINTENANCEPROGRESSData != null) {
      data['rowMAINTENANCEPROGRESSData'] =
          rowMAINTENANCEPROGRESSData!.map((v) => v.toJson()).toList();
    }
    if (completeProgressAndPendingData != null) {
      data['completeProgressAndPendingData'] =
          completeProgressAndPendingData!.map((v) => v.toJson()).toList();
    }
    if (crewsData != null) {
      data['crewsData'] = crewsData!.map((v) => v.toJson()).toList();
    }
    if (nextMaintDueYear != null) {
      data['next_maint_due_year'] =
          nextMaintDueYear!.map((v) => v.toJson()).toList();
    }
    if (completeProgressAndPending != null) {
      data['completeProgressAndPending'] =
          completeProgressAndPending!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CycleLists {
  String? cycle;

  CycleLists({this.cycle});

  CycleLists.fromJson(Map<String, dynamic> json) {
    cycle = json['cycle'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cycle'] = cycle;
    return data;
  }
}

class SubStations {
  String? subStation;

  SubStations({this.subStation});

  SubStations.fromJson(Map<String, dynamic> json) {
    subStation = json['subStation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['subStation'] = subStation;
    return data;
  }
}

class PercentAndStatus {
  double? percentage;
  String? status;

  PercentAndStatus({this.percentage, this.status});

  PercentAndStatus.fromJson(Map<String, dynamic> json) {
    percentage = json['percentage'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['percentage'] = percentage;
    data['status'] = status;
    return data;
  }
}

class FeederLists {
  String? feeder;

  FeederLists({this.feeder});

  FeederLists.fromJson(Map<String, dynamic> json) {
    feeder = json['feeder'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['feeder'] = feeder;
    return data;
  }
}

class RowMAINTENANCEPROGRESSData {
  double? costPerMile;
  double? milesProgress;
  double? milesCompleted;
  double? milesPending;
  String? feeder;
  int? tokenNo;
  String? cardColor;
  String? totalMiles;
  String? cycle;
  String? crew;
  String? lastRowYear;
  String? substation;
  String? nextMaintYr;
  double? totalCost;
  double? budget;

  RowMAINTENANCEPROGRESSData(
      {this.costPerMile,
      this.milesProgress,
      this.milesCompleted,
      this.milesPending,
      this.feeder,
      this.tokenNo,
      this.cardColor,
      this.totalMiles,
      this.cycle,
      this.crew,
      this.lastRowYear,
      this.substation,
      this.nextMaintYr,
      this.totalCost,
      this.budget});

  RowMAINTENANCEPROGRESSData.fromJson(Map<String, dynamic> json) {
    costPerMile = json['costPerMile'];
    milesProgress = json['milesProgress'];
    milesCompleted = json['milesCompleted'];
    milesPending = json['milesPending'];
    feeder = json['feeder'];
    tokenNo = json['tokenNo'];
    cardColor = json['cardColor'];
    totalMiles = json['totalMiles'];
    cycle = json['cycle'];
    crew = json['crew'];
    lastRowYear = json['lastRowYear'];
    substation = json['substation'];
    nextMaintYr = json['nextMaintYr'];
    totalCost = json['totalCost'];
    budget = json['budget'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['costPerMile'] = costPerMile;
    data['milesProgress'] = milesProgress;
    data['milesCompleted'] = milesCompleted;
    data['milesPending'] = milesPending;
    data['feeder'] = feeder;
    data['tokenNo'] = tokenNo;
    data['cardColor'] = cardColor;
    data['totalMiles'] = totalMiles;
    data['cycle'] = cycle;
    data['crew'] = crew;
    data['lastRowYear'] = lastRowYear;
    data['substation'] = substation;
    data['nextMaintYr'] = nextMaintYr;
    data['totalCost'] = totalCost;
    data['budget'] = budget;
    return data;
  }
}

class CrewsData {
  String? crew;
  CrewsData({this.crew});
  CrewsData.fromJson(Map<String, dynamic> json) {
    crew = json['crew'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['crew'] = crew;
    return data;
  }
}

class NextMaintDueYear {
  int? nextMaintDue;

  NextMaintDueYear({this.nextMaintDue});

  NextMaintDueYear.fromJson(Map<String, dynamic> json) {
    nextMaintDue = json['next_maint_due'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['next_maint_due'] = nextMaintDue;
    return data;
  }
}

class CompleteProgressAndPending {
  double? pending;
  double? progress;
  double? totalMiles;
  double? completed;

  CompleteProgressAndPending(
      {this.pending, this.progress, this.totalMiles, this.completed});

  CompleteProgressAndPending.fromJson(Map<String, dynamic> json) {
    pending = json['pending'];
    progress = json['progress'];
    totalMiles = json['totalMiles'];
    completed = json['completed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pending'] = pending;
    data['progress'] = progress;
    data['totalMiles'] = totalMiles;
    data['completed'] = completed;
    return data;
  }
}

class CompleteProgressAndPendingData {
  double? value;
  String? status;

  CompleteProgressAndPendingData({this.value, this.status});

  CompleteProgressAndPendingData.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['value'] = value;
    data['status'] = status;
    return data;
  }
}
