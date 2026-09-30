class VegetationGrowthRateModel {
  FindCYGrowthSizeAndCYGrowthFtList? findCYGrowthSizeAndCYGrowthFtList;
  FindPYGrowthFtAndPYTreeSizeList? findPYGrowthFtAndPYTreeSizeList;
  List<GetAllTableDataList>? getAllTableDataList;
  List<FindsZipCodeByYear>? findsZipCodeByYear;
  List<FindsTreeTypeByYearAndZipCode>? findsTreeTypeByYearAndZipCode;
  List<FindsSeasonByGrowSpeedAndTreeTypeAndYearAndZipCode>?
      findsSeasonByGrowSpeedAndTreeTypeAndYearAndZipCode;
  List<GetAllYrList>? getAllYrList;
  List<FindTreeTypeAndGrowRateGroupByTreeOrderByTreeTypeBySqlInjection>?
      findTreeTypeAndGrowRateGroupByTreeOrderByTreeTypeBySqlInjection;
  List<FindsGrowSpeedByTreeTypeAndYearAndZipCodeList>?
      findsGrowSpeedByTreeTypeAndYearAndZipCodeList;
  List<GrowthBySeasonGraphData>? growthBySeasonGraphData;

  VegetationGrowthRateModel(
      {this.findCYGrowthSizeAndCYGrowthFtList,
      this.findPYGrowthFtAndPYTreeSizeList,
      this.getAllTableDataList,
      this.findsZipCodeByYear,
      this.findsTreeTypeByYearAndZipCode,
      this.findsSeasonByGrowSpeedAndTreeTypeAndYearAndZipCode,
      this.getAllYrList,
      this.findTreeTypeAndGrowRateGroupByTreeOrderByTreeTypeBySqlInjection,
      this.findsGrowSpeedByTreeTypeAndYearAndZipCodeList,
      this.growthBySeasonGraphData});

  VegetationGrowthRateModel.fromJson(Map<String, dynamic> json) {
    findCYGrowthSizeAndCYGrowthFtList =
        json['findCY_Growth_SizeAndCY_Growth_ftList'] != null
            ? FindCYGrowthSizeAndCYGrowthFtList.fromJson(
                json['findCY_Growth_SizeAndCY_Growth_ftList'])
            : null;
    findPYGrowthFtAndPYTreeSizeList =
        json['findPY_Growth_ftAndPY_Tree_SizeList'] != null
            ? FindPYGrowthFtAndPYTreeSizeList.fromJson(
                json['findPY_Growth_ftAndPY_Tree_SizeList'])
            : null;
    if (json['getAllTableDataList'] != null) {
      getAllTableDataList = <GetAllTableDataList>[];
      json['getAllTableDataList'].forEach((v) {
        getAllTableDataList!.add(GetAllTableDataList.fromJson(v));
      });
    }
    if (json['findsZipCodeByYear'] != null) {
      findsZipCodeByYear = <FindsZipCodeByYear>[];
      json['findsZipCodeByYear'].forEach((v) {
        findsZipCodeByYear!.add(FindsZipCodeByYear.fromJson(v));
      });
    }
    if (json['findsTreeTypeByYearAndZipCode'] != null) {
      findsTreeTypeByYearAndZipCode = <FindsTreeTypeByYearAndZipCode>[];
      json['findsTreeTypeByYearAndZipCode'].forEach((v) {
        findsTreeTypeByYearAndZipCode!
            .add(FindsTreeTypeByYearAndZipCode.fromJson(v));
      });
    }
    if (json['findsSeasonByGrowSpeedAndTreeTypeAndYearAndZipCode'] != null) {
      findsSeasonByGrowSpeedAndTreeTypeAndYearAndZipCode =
          <FindsSeasonByGrowSpeedAndTreeTypeAndYearAndZipCode>[];
      json['findsSeasonByGrowSpeedAndTreeTypeAndYearAndZipCode'].forEach((v) {
        findsSeasonByGrowSpeedAndTreeTypeAndYearAndZipCode!.add(
            FindsSeasonByGrowSpeedAndTreeTypeAndYearAndZipCode.fromJson(v));
      });
    }
    if (json['getAllYrList'] != null) {
      getAllYrList = <GetAllYrList>[];
      json['getAllYrList'].forEach((v) {
        getAllYrList!.add(GetAllYrList.fromJson(v));
      });
    }
    if (json[
            'findTreeTypeAndGrowRateGroupByTreeOrderByTreeTypeBySqlInjection'] !=
        null) {
      findTreeTypeAndGrowRateGroupByTreeOrderByTreeTypeBySqlInjection =
          <FindTreeTypeAndGrowRateGroupByTreeOrderByTreeTypeBySqlInjection>[];
      json['findTreeTypeAndGrowRateGroupByTreeOrderByTreeTypeBySqlInjection']
          .forEach((v) {
        findTreeTypeAndGrowRateGroupByTreeOrderByTreeTypeBySqlInjection!.add(
            FindTreeTypeAndGrowRateGroupByTreeOrderByTreeTypeBySqlInjection
                .fromJson(v));
      });
    }
    if (json['findsGrowSpeedByTreeTypeAndYearAndZipCodeList'] != null) {
      findsGrowSpeedByTreeTypeAndYearAndZipCodeList =
          <FindsGrowSpeedByTreeTypeAndYearAndZipCodeList>[];
      json['findsGrowSpeedByTreeTypeAndYearAndZipCodeList'].forEach((v) {
        findsGrowSpeedByTreeTypeAndYearAndZipCodeList!
            .add(FindsGrowSpeedByTreeTypeAndYearAndZipCodeList.fromJson(v));
      });
    }
    if (json['growthBySeasonGraphData'] != null) {
      growthBySeasonGraphData = <GrowthBySeasonGraphData>[];
      json['growthBySeasonGraphData'].forEach((v) {
        growthBySeasonGraphData!.add(GrowthBySeasonGraphData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (findCYGrowthSizeAndCYGrowthFtList != null) {
      data['findCY_Growth_SizeAndCY_Growth_ftList'] =
          findCYGrowthSizeAndCYGrowthFtList!.toJson();
    }
    if (findPYGrowthFtAndPYTreeSizeList != null) {
      data['findPY_Growth_ftAndPY_Tree_SizeList'] =
          findPYGrowthFtAndPYTreeSizeList!.toJson();
    }
    if (getAllTableDataList != null) {
      data['getAllTableDataList'] =
          getAllTableDataList!.map((v) => v.toJson()).toList();
    }
    if (findsZipCodeByYear != null) {
      data['findsZipCodeByYear'] =
          findsZipCodeByYear!.map((v) => v.toJson()).toList();
    }
    if (findsTreeTypeByYearAndZipCode != null) {
      data['findsTreeTypeByYearAndZipCode'] =
          findsTreeTypeByYearAndZipCode!.map((v) => v.toJson()).toList();
    }
    if (findsSeasonByGrowSpeedAndTreeTypeAndYearAndZipCode != null) {
      data['findsSeasonByGrowSpeedAndTreeTypeAndYearAndZipCode'] =
          findsSeasonByGrowSpeedAndTreeTypeAndYearAndZipCode!
              .map((v) => v.toJson())
              .toList();
    }
    if (getAllYrList != null) {
      data['getAllYrList'] = getAllYrList!.map((v) => v.toJson()).toList();
    }
    if (findTreeTypeAndGrowRateGroupByTreeOrderByTreeTypeBySqlInjection !=
        null) {
      data['findTreeTypeAndGrowRateGroupByTreeOrderByTreeTypeBySqlInjection'] =
          findTreeTypeAndGrowRateGroupByTreeOrderByTreeTypeBySqlInjection!
              .map((v) => v.toJson())
              .toList();
    }
    if (findsGrowSpeedByTreeTypeAndYearAndZipCodeList != null) {
      data['findsGrowSpeedByTreeTypeAndYearAndZipCodeList'] =
          findsGrowSpeedByTreeTypeAndYearAndZipCodeList!
              .map((v) => v.toJson())
              .toList();
    }
    if (growthBySeasonGraphData != null) {
      data['growthBySeasonGraphData'] =
          growthBySeasonGraphData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FindCYGrowthSizeAndCYGrowthFtList {
  double? cYGrowthFt;
  double? cYGrowthSize;

  FindCYGrowthSizeAndCYGrowthFtList({this.cYGrowthFt, this.cYGrowthSize});

  FindCYGrowthSizeAndCYGrowthFtList.fromJson(Map<String, dynamic> json) {
    cYGrowthFt = json['CY_Growth_ft'];
    cYGrowthSize = json['CY_Growth_Size'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['CY_Growth_ft'] = cYGrowthFt;
    data['CY_Growth_Size'] = cYGrowthSize;
    return data;
  }
}

class FindPYGrowthFtAndPYTreeSizeList {
  double? pYGrowthFt;
  double? pYTreeSize;
  int? yearCount;
  double? totalGrowth;
  double? yOYTsGrowth;

  FindPYGrowthFtAndPYTreeSizeList(
      {this.pYGrowthFt,
      this.pYTreeSize,
      this.yearCount,
      this.totalGrowth,
      this.yOYTsGrowth});

  FindPYGrowthFtAndPYTreeSizeList.fromJson(Map<String, dynamic> json) {
    pYGrowthFt = json['pY_Growth_ft'];
    pYTreeSize = json['pY_Tree_Size'];
    yearCount = json['yearCount'];
    totalGrowth = json['totalGrowth'];
    yOYTsGrowth = json['yOY_Ts_Growth'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pY_Growth_ft'] = pYGrowthFt;
    data['pY_Tree_Size'] = pYTreeSize;
    data['yearCount'] = yearCount;
    data['totalGrowth'] = totalGrowth;
    data['yOY_Ts_Growth'] = yOYTsGrowth;
    return data;
  }
}

class GetAllTableDataList {
  String? dateTime;
  String? zipCode;
  String? reason;
  double? treeSize;
  double? temp;
  String? treeType;
  String? growSpeed;
  String? severityGs;
  String? growRate;
  String? duration;
  String? yoyTsGrowthPercent;
  String? severityTs;
  double? precipitatin;
  String? season;
  String? conditions;
  String? yoyGrowthPercent;
  String? severityLevelPt;

  GetAllTableDataList(
      {this.dateTime,
      this.zipCode,
      this.reason,
      this.treeSize,
      this.temp,
      this.treeType,
      this.growSpeed,
      this.severityGs,
      this.growRate,
      this.duration,
      this.yoyTsGrowthPercent,
      this.severityTs,
      this.precipitatin,
      this.season,
      this.conditions,
      this.yoyGrowthPercent,
      this.severityLevelPt});

  GetAllTableDataList.fromJson(Map<String, dynamic> json) {
    dateTime = json['dateTime'];
    zipCode = json['zipCode'];
    reason = json['reason'];
    treeSize = json['treeSize'];
    temp = json['temp'];
    treeType = json['treeType'];
    growSpeed = json['growSpeed'];
    severityGs = json['severityGs'];
    growRate = json['growRate'];
    duration = json['duration'];
    yoyTsGrowthPercent = json['yoyTsGrowthPercent'];
    severityTs = json['severityTs'];
    precipitatin = json['precipitatin'];
    season = json['season'];
    conditions = json['conditions'];
    yoyGrowthPercent = json['yoyGrowthPercent'];
    severityLevelPt = json['severityLevelPt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['dateTime'] = dateTime;
    data['zipCode'] = zipCode;
    data['reason'] = reason;
    data['treeSize'] = treeSize;
    data['temp'] = temp;
    data['treeType'] = treeType;
    data['growSpeed'] = growSpeed;
    data['severityGs'] = severityGs;
    data['growRate'] = growRate;
    data['duration'] = duration;
    data['yoyTsGrowthPercent'] = yoyTsGrowthPercent;
    data['severityTs'] = severityTs;
    data['precipitatin'] = precipitatin;
    data['season'] = season;
    data['conditions'] = conditions;
    data['yoyGrowthPercent'] = yoyGrowthPercent;
    data['severityLevelPt'] = severityLevelPt;
    return data;
  }
}

class FindsZipCodeByYear {
  String? zipCode;

  FindsZipCodeByYear({this.zipCode});

  FindsZipCodeByYear.fromJson(Map<String, dynamic> json) {
    zipCode = json['zipCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['zipCode'] = zipCode;
    return data;
  }
}

class FindsTreeTypeByYearAndZipCode {
  String? treeType;

  FindsTreeTypeByYearAndZipCode({this.treeType});

  FindsTreeTypeByYearAndZipCode.fromJson(Map<String, dynamic> json) {
    treeType = json['treeType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['treeType'] = treeType;
    return data;
  }
}

class FindsSeasonByGrowSpeedAndTreeTypeAndYearAndZipCode {
  String? season;

  FindsSeasonByGrowSpeedAndTreeTypeAndYearAndZipCode({this.season});

  FindsSeasonByGrowSpeedAndTreeTypeAndYearAndZipCode.fromJson(
      Map<String, dynamic> json) {
    season = json['season'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['season'] = season;
    return data;
  }
}

class GetAllYrList {
  String? year;

  GetAllYrList({this.year});

  GetAllYrList.fromJson(Map<String, dynamic> json) {
    year = json['year'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['year'] = year;
    return data;
  }
}

class FindTreeTypeAndGrowRateGroupByTreeOrderByTreeTypeBySqlInjection {
  String? typeTree;
  double? growRate;

  FindTreeTypeAndGrowRateGroupByTreeOrderByTreeTypeBySqlInjection(
      {this.typeTree, this.growRate});

  FindTreeTypeAndGrowRateGroupByTreeOrderByTreeTypeBySqlInjection.fromJson(
      Map<String, dynamic> json) {
    typeTree = json['typeTree'];
    growRate = json['growRate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['typeTree'] = typeTree;
    data['growRate'] = growRate;
    return data;
  }
}

class FindsGrowSpeedByTreeTypeAndYearAndZipCodeList {
  String? growSpeed;

  FindsGrowSpeedByTreeTypeAndYearAndZipCodeList({this.growSpeed});

  FindsGrowSpeedByTreeTypeAndYearAndZipCodeList.fromJson(
      Map<String, dynamic> json) {
    growSpeed = json['growSpeed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['growSpeed'] = growSpeed;
    return data;
  }
}

class GrowthBySeasonGraphData {
  String? season;
  double? growRate;

  GrowthBySeasonGraphData({this.season, this.growRate});

  GrowthBySeasonGraphData.fromJson(Map<String, dynamic> json) {
    season = json['season'];
    growRate = json['growRate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['season'] = season;
    data['growRate'] = growRate;
    return data;
  }
}
