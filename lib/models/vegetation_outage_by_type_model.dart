class VegetationOutageByTypeModel {
  List<GetSPOUTAGESUBFDRTABLEDATA>? getSPOUTAGESUBFDRTABLEDATA;
  List<FindCompletedMiles>? findCompletedMiles;
  List<FindSubstationsAndIds>? findSubstationsAndIds;
  List<FindCntAndTypes>? findCntAndTypes;
  List<OutagesDurationByVegetation>? outagesDurationByVegetation;
  List<FindOutageCause>? findOutageCause;
  List<FindCntAndYears>? findCntAndYears;
  List<FindCompletedMilesByType>? findCompletedMilesByType;
  List<FindFdrNamesIdBySubstation>? findFdrNamesIdBySubstation;

  VegetationOutageByTypeModel(
      {this.getSPOUTAGESUBFDRTABLEDATA,
      this.findCompletedMiles,
      this.findSubstationsAndIds,
      this.findCntAndTypes,
      this.outagesDurationByVegetation,
      this.findOutageCause,
      this.findCntAndYears,
      this.findCompletedMilesByType,
      this.findFdrNamesIdBySubstation});

  VegetationOutageByTypeModel.fromJson(Map<String, dynamic> json) {
    if (json['getSP_OUTAGE_SUB_FDR_TABLE_DATA'] != null) {
      getSPOUTAGESUBFDRTABLEDATA = <GetSPOUTAGESUBFDRTABLEDATA>[];
      json['getSP_OUTAGE_SUB_FDR_TABLE_DATA'].forEach((v) {
        getSPOUTAGESUBFDRTABLEDATA!.add(GetSPOUTAGESUBFDRTABLEDATA.fromJson(v));
      });
    }
    if (json['findCompletedMiles'] != null) {
      findCompletedMiles = <FindCompletedMiles>[];
      json['findCompletedMiles'].forEach((v) {
        findCompletedMiles!.add(FindCompletedMiles.fromJson(v));
      });
    }
    if (json['findSubstationsAndIds'] != null) {
      findSubstationsAndIds = <FindSubstationsAndIds>[];
      json['findSubstationsAndIds'].forEach((v) {
        findSubstationsAndIds!.add(FindSubstationsAndIds.fromJson(v));
      });
    }
    if (json['findCntAndTypes'] != null) {
      findCntAndTypes = <FindCntAndTypes>[];
      json['findCntAndTypes'].forEach((v) {
        findCntAndTypes!.add(FindCntAndTypes.fromJson(v));
      });
    }
    if (json['outagesDurationByVegetation'] != null) {
      outagesDurationByVegetation = <OutagesDurationByVegetation>[];
      json['outagesDurationByVegetation'].forEach((v) {
        outagesDurationByVegetation!
            .add(OutagesDurationByVegetation.fromJson(v));
      });
    }
    if (json['findOutageCause'] != null) {
      findOutageCause = <FindOutageCause>[];
      json['findOutageCause'].forEach((v) {
        findOutageCause!.add(FindOutageCause.fromJson(v));
      });
    }
    if (json['findCntAndYears'] != null) {
      findCntAndYears = <FindCntAndYears>[];
      json['findCntAndYears'].forEach((v) {
        findCntAndYears!.add(FindCntAndYears.fromJson(v));
      });
    }
    if (json['findCompletedMilesByType'] != null) {
      findCompletedMilesByType = <FindCompletedMilesByType>[];
      json['findCompletedMilesByType'].forEach((v) {
        findCompletedMilesByType!.add(FindCompletedMilesByType.fromJson(v));
      });
    }
    if (json['findFdrNamesIdBySubstation'] != null) {
      findFdrNamesIdBySubstation = <FindFdrNamesIdBySubstation>[];
      json['findFdrNamesIdBySubstation'].forEach((v) {
        findFdrNamesIdBySubstation!.add(FindFdrNamesIdBySubstation.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (getSPOUTAGESUBFDRTABLEDATA != null) {
      data['getSP_OUTAGE_SUB_FDR_TABLE_DATA'] =
          getSPOUTAGESUBFDRTABLEDATA!.map((v) => v.toJson()).toList();
    }
    if (findCompletedMiles != null) {
      data['findCompletedMiles'] =
          findCompletedMiles!.map((v) => v.toJson()).toList();
    }
    if (findSubstationsAndIds != null) {
      data['findSubstationsAndIds'] =
          findSubstationsAndIds!.map((v) => v.toJson()).toList();
    }
    if (findCntAndTypes != null) {
      data['findCntAndTypes'] =
          findCntAndTypes!.map((v) => v.toJson()).toList();
    }
    if (outagesDurationByVegetation != null) {
      data['outagesDurationByVegetation'] =
          outagesDurationByVegetation!.map((v) => v.toJson()).toList();
    }
    if (findOutageCause != null) {
      data['findOutageCause'] =
          findOutageCause!.map((v) => v.toJson()).toList();
    }
    if (findCntAndYears != null) {
      data['findCntAndYears'] =
          findCntAndYears!.map((v) => v.toJson()).toList();
    }
    if (findCompletedMilesByType != null) {
      data['findCompletedMilesByType'] =
          findCompletedMilesByType!.map((v) => v.toJson()).toList();
    }
    if (findFdrNamesIdBySubstation != null) {
      data['findFdrNamesIdBySubstation'] =
          findFdrNamesIdBySubstation!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetSPOUTAGESUBFDRTABLEDATA {
  double? costPerMile;
  String? outagerecId;
  String? feeder;
  String? county;
  String? type;
  String? fdrName;
  int? outageCustomer;
  String? subStateName;
  String? season;
  String? dueYr;
  double? saifi;
  String? mnthName;
  String? outageCause;
  double? budget;
  double? saidi;
  double? aggrCost;
  String? totalMiles;
  String? redngDt;
  double? otgHours;
  double? caidi;
  int? transformerCount;
  int? mnthNo;
  String? district;
  int? outageDuration;
  int? milesOfLine;
  double? totalCost;

  GetSPOUTAGESUBFDRTABLEDATA(
      {this.costPerMile,
      this.outagerecId,
      this.feeder,
      this.county,
      this.type,
      this.fdrName,
      this.outageCustomer,
      this.subStateName,
      this.season,
      this.dueYr,
      this.saifi,
      this.mnthName,
      this.outageCause,
      this.budget,
      this.saidi,
      this.aggrCost,
      this.totalMiles,
      this.redngDt,
      this.otgHours,
      this.caidi,
      this.transformerCount,
      this.mnthNo,
      this.district,
      this.outageDuration,
      this.milesOfLine,
      this.totalCost});

  GetSPOUTAGESUBFDRTABLEDATA.fromJson(Map<String, dynamic> json) {
    costPerMile = json['costPerMile'];
    outagerecId = json['outagerecId'];
    feeder = json['feeder'];
    county = json['county'];
    type = json['type'];
    fdrName = json['fdrName'];
    outageCustomer = json['outageCustomer'];
    subStateName = json['subStateName'];
    season = json['season'];
    dueYr = json['dueYr'];
    saifi = json['saifi'];
    mnthName = json['mnthName'];
    outageCause = json['outageCause'];
    budget = json['budget'];
    saidi = json['saidi'];
    aggrCost = json['aggrCost'];
    totalMiles = json['totalMiles'];
    redngDt = json['redngDt'];
    otgHours = json['otgHours'];
    caidi = json['caidi'];
    transformerCount = json['transformerCount'];
    mnthNo = json['mnthNo'];
    district = json['district'];
    outageDuration = json['outageDuration'];
    milesOfLine = json['milesOfLine'];
    totalCost = json['totalCost'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['costPerMile'] = costPerMile;
    data['outagerecId'] = outagerecId;
    data['feeder'] = feeder;
    data['county'] = county;
    data['type'] = type;
    data['fdrName'] = fdrName;
    data['outageCustomer'] = outageCustomer;
    data['subStateName'] = subStateName;
    data['season'] = season;
    data['dueYr'] = dueYr;
    data['saifi'] = saifi;
    data['mnthName'] = mnthName;
    data['outageCause'] = outageCause;
    data['budget'] = budget;
    data['saidi'] = saidi;
    data['aggrCost'] = aggrCost;
    data['totalMiles'] = totalMiles;
    data['redngDt'] = redngDt;
    data['otgHours'] = otgHours;
    data['caidi'] = caidi;
    data['transformerCount'] = transformerCount;
    data['mnthNo'] = mnthNo;
    data['district'] = district;
    data['outageDuration'] = outageDuration;
    data['milesOfLine'] = milesOfLine;
    data['totalCost'] = totalCost;
    return data;
  }
}

class FindCompletedMiles {
  double? completedMiles;

  FindCompletedMiles({this.completedMiles});

  FindCompletedMiles.fromJson(Map<String, dynamic> json) {
    completedMiles = json['completedMiles'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['completedMiles'] = completedMiles;
    return data;
  }
}

class FindSubstationsAndIds {
  String? substation;

  FindSubstationsAndIds({this.substation});

  FindSubstationsAndIds.fromJson(Map<String, dynamic> json) {
    substation = json['substation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['substation'] = substation;
    return data;
  }
}

class FindCntAndTypes {
  String? cnt;
  int? type;

  FindCntAndTypes({this.cnt, this.type});

  FindCntAndTypes.fromJson(Map<String, dynamic> json) {
    cnt = json['cnt'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cnt'] = cnt;
    data['type'] = type;
    return data;
  }
}

class OutagesDurationByVegetation {
  double? outageSum;
  String? type;

  OutagesDurationByVegetation({this.outageSum, this.type});

  OutagesDurationByVegetation.fromJson(Map<String, dynamic> json) {
    outageSum = json['outageSum'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['outageSum'] = outageSum;
    data['type'] = type;
    return data;
  }
}

class FindOutageCause {
  String? outageCause;

  FindOutageCause({this.outageCause});

  FindOutageCause.fromJson(Map<String, dynamic> json) {
    outageCause = json['outageCause'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['outageCause'] = outageCause;
    return data;
  }
}

class FindCntAndYears {
  double? outAgeSum;
  String? year;

  FindCntAndYears({this.outAgeSum, this.year});

  FindCntAndYears.fromJson(Map<String, dynamic> json) {
    outAgeSum = json['outAgeSum'];
    year = json['year'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['outAgeSum'] = outAgeSum;
    data['year'] = year;
    return data;
  }
}

class FindCompletedMilesByType {
  double? milesCompleted;

  FindCompletedMilesByType({this.milesCompleted});

  FindCompletedMilesByType.fromJson(Map<String, dynamic> json) {
    milesCompleted = json['milesCompleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['milesCompleted'] = milesCompleted;
    return data;
  }
}

class FindFdrNamesIdBySubstation {
  String? fdrName;

  FindFdrNamesIdBySubstation({this.fdrName});

  FindFdrNamesIdBySubstation.fromJson(Map<String, dynamic> json) {
    fdrName = json['fdrName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fdrName'] = fdrName;
    return data;
  }
}
