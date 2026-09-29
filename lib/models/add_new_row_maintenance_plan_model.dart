// class AddNewRowMaintenancePlanModel {
//   List<GetIdAndSubstation>? getIdAndSubstation;
//   String? getCostPerMileBySubstation;
//   List<ContractorGetInsert>? contractorGetInsert;
//   List<GetIdAndFeederBySubstationId>? getIdAndFeederBySubstationId;

//   AddNewRowMaintenancePlanModel(
//       {this.getIdAndSubstation,
//       this.getCostPerMileBySubstation,
//       this.contractorGetInsert,
//       this.getIdAndFeederBySubstationId});

//   AddNewRowMaintenancePlanModel.fromJson(Map<String, dynamic> json) {
//     if (json['getIdAndSubstation'] != null) {
//       getIdAndSubstation = <GetIdAndSubstation>[];
//       json['getIdAndSubstation'].forEach((v) {
//         getIdAndSubstation!.add(GetIdAndSubstation.fromJson(v));
//       });
//     }
//     getCostPerMileBySubstation = json['getCostPerMileBySubstation'];
//     if (json['contractor_get_insert'] != null) {
//       contractorGetInsert = <ContractorGetInsert>[];
//       json['contractor_get_insert'].forEach((v) {
//         contractorGetInsert!.add(ContractorGetInsert.fromJson(v));
//       });
//     }
//     if (json['getIdAndFeederBySubstationId'] != null) {
//       getIdAndFeederBySubstationId = <GetIdAndFeederBySubstationId>[];
//       json['getIdAndFeederBySubstationId'].forEach((v) {
//         getIdAndFeederBySubstationId!
//             .add(GetIdAndFeederBySubstationId.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     if (getIdAndSubstation != null) {
//       data['getIdAndSubstation'] =
//           getIdAndSubstation!.map((v) => v.toJson()).toList();
//     }
//     data['getCostPerMileBySubstation'] = getCostPerMileBySubstation;
//     if (contractorGetInsert != null) {
//       data['contractor_get_insert'] =
//           contractorGetInsert!.map((v) => v.toJson()).toList();
//     }
//     if (getIdAndFeederBySubstationId != null) {
//       data['getIdAndFeederBySubstationId'] =
//           getIdAndFeederBySubstationId!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class GetIdAndSubstation {
//   String? subStation;
//   int? id;

//   GetIdAndSubstation({this.subStation, this.id});

//   GetIdAndSubstation.fromJson(Map<String, dynamic> json) {
//     subStation = json['subStation'];
//     id = json['id'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['subStation'] = subStation;
//     data['id'] = id;
//     return data;
//   }
// }

// class ContractorGetInsert {
//   int? loginId;
//   String? name;

//   ContractorGetInsert({this.loginId, this.name});

//   ContractorGetInsert.fromJson(Map<String, dynamic> json) {
//     loginId = json['loginId'];
//     name = json['name'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['loginId'] = loginId;
//     data['name'] = name;
//     return data;
//   }
// }

// class GetIdAndFeederBySubstationId {
//   String? feeder;
//   int? id;

//   GetIdAndFeederBySubstationId({this.feeder, this.id});

//   GetIdAndFeederBySubstationId.fromJson(Map<String, dynamic> json) {
//     feeder = json['feeder'];
//     id = json['id'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['feeder'] = feeder;
//     data['id'] = id;
//     return data;
//   }
// }

// class AddNewRowMaintenancePlanModel {
//   List<GetIdAndSubstation>? getIdAndSubstation;
//   String? getCostPerMileBySubstation;
//   List<ContractorGetInsert>? contractorGetInsert;
//   List<GetIdAndFeederBySubstationId>? getIdAndFeederBySubstationId;
//   List<YearList>? yearList;

//   AddNewRowMaintenancePlanModel(
//       {this.getIdAndSubstation,
//       this.getCostPerMileBySubstation,
//       this.contractorGetInsert,
//       this.getIdAndFeederBySubstationId,
//       this.yearList});

//   AddNewRowMaintenancePlanModel.fromJson(Map<String, dynamic> json) {
//     if (json['getIdAndSubstation'] != null) {
//       getIdAndSubstation = <GetIdAndSubstation>[];
//       json['getIdAndSubstation'].forEach((v) {
//         getIdAndSubstation!.add(new GetIdAndSubstation.fromJson(v));
//       });
//     }
//     getCostPerMileBySubstation = json['getCostPerMileBySubstation'];
//     if (json['contractor_get_insert'] != null) {
//       contractorGetInsert = <ContractorGetInsert>[];
//       json['contractor_get_insert'].forEach((v) {
//         contractorGetInsert!.add(new ContractorGetInsert.fromJson(v));
//       });
//     }
//     if (json['getIdAndFeederBySubstationId'] != null) {
//       getIdAndFeederBySubstationId = <GetIdAndFeederBySubstationId>[];
//       json['getIdAndFeederBySubstationId'].forEach((v) {
//         getIdAndFeederBySubstationId!.add(new GetIdAndFeederBySubstationId.fromJson(v));
//       });
//     }
//     if (json['yearList'] != null) {
//       yearList = <YearList>[];
//       json['yearList'].forEach((v) {
//         yearList!.add(new YearList.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.getIdAndSubstation != null) {
//       data['getIdAndSubstation'] =
//           this.getIdAndSubstation!.map((v) => v.toJson()).toList();
//     }
//     data['getCostPerMileBySubstation'] = this.getCostPerMileBySubstation;
//     if (this.contractorGetInsert != null) {
//       data['contractor_get_insert'] =
//           this.contractorGetInsert!.map((v) => v.toJson()).toList();
//     }
//     if (this.getIdAndFeederBySubstationId != null) {
//       data['getIdAndFeederBySubstationId'] =
//           this.getIdAndFeederBySubstationId!.map((v) => v.toJson()).toList();
//     }
//     if (this.yearList != null) {
//       data['yearList'] = this.yearList!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class GetIdAndSubstation {
//   String? subStation;
//   int? id;

//   GetIdAndSubstation({this.subStation, this.id});

//   GetIdAndSubstation.fromJson(Map<String, dynamic> json) {
//     subStation = json['subStation'];
//     id = json['id'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['subStation'] = this.subStation;
//     data['id'] = this.id;
//     return data;
//   }
// }

// class ContractorGetInsert {
//   int? loginId;
//   String? name;

//   ContractorGetInsert({this.loginId, this.name});

//   ContractorGetInsert.fromJson(Map<String, dynamic> json) {
//     loginId = json['loginId'];
//     name = json['name'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['loginId'] = this.loginId;
//     data['name'] = this.name;
//     return data;
//   }
// }

// class YearList {
//   int? year;

//   YearList({this.year});

//   YearList.fromJson(Map<String, dynamic> json) {
//     year = json['year'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['year'] = this.year;
//     return data;
//   }
// }

// class AddNewRowMaintenancePlanModel {
//   List<GetIdAndSubstation>? getIdAndSubstation;
//   List<FeederList>? feederList;
//   String? getCostPerMileBySubstation;
//   List<ContractorGetInsert>? contractorGetInsert;
//   List<SubstationList>? substationList;
//   List<GetIdAndFeederBySubstationId>? getIdAndFeederBySubstationId;
//   List<YearList>? yearList;

//   AddNewRowMaintenancePlanModel(
//       {this.getIdAndSubstation,
//       this.feederList,
//       this.getCostPerMileBySubstation,
//       this.contractorGetInsert,
//       this.substationList,
//       this.getIdAndFeederBySubstationId,
//       this.yearList});

//   AddNewRowMaintenancePlanModel.fromJson(Map<String, dynamic> json) {
//     if (json['getIdAndSubstation'] != null) {
//       getIdAndSubstation = <GetIdAndSubstation>[];
//       json['getIdAndSubstation'].forEach((v) {
//         getIdAndSubstation!.add(GetIdAndSubstation.fromJson(v));
//       });
//     }
//     if (json['feederList'] != null) {
//       feederList = <FeederList>[];
//       json['feederList'].forEach((v) {
//         feederList!.add(FeederList.fromJson(v));
//       });
//     }
//     getCostPerMileBySubstation = json['getCostPerMileBySubstation'];
//     if (json['contractor_get_insert'] != null) {
//       contractorGetInsert = <ContractorGetInsert>[];
//       json['contractor_get_insert'].forEach((v) {
//         contractorGetInsert!.add(ContractorGetInsert.fromJson(v));
//       });
//     }
//     if (json['substationList'] != null) {
//       substationList = <SubstationList>[];
//       json['substationList'].forEach((v) {
//         substationList!.add(SubstationList.fromJson(v));
//       });
//     }
//     if (json['getIdAndFeederBySubstationId'] != null) {
//       getIdAndFeederBySubstationId = <GetIdAndFeederBySubstationId>[];
//       json['getIdAndFeederBySubstationId'].forEach((v) {
//         getIdAndFeederBySubstationId!
//             .add(GetIdAndFeederBySubstationId.fromJson(v));
//       });
//     }
//     if (json['yearList'] != null) {
//       yearList = <YearList>[];
//       json['yearList'].forEach((v) {
//         yearList!.add(YearList.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     if (getIdAndSubstation != null) {
//       data['getIdAndSubstation'] =
//           getIdAndSubstation!.map((v) => v.toJson()).toList();
//     }
//     if (feederList != null) {
//       data['feederList'] = feederList!.map((v) => v.toJson()).toList();
//     }
//     data['getCostPerMileBySubstation'] = getCostPerMileBySubstation;
//     if (contractorGetInsert != null) {
//       data['contractor_get_insert'] =
//           contractorGetInsert!.map((v) => v.toJson()).toList();
//     }
//     if (substationList != null) {
//       data['substationList'] =
//           substationList!.map((v) => v.toJson()).toList();
//     }
//     if (getIdAndFeederBySubstationId != null) {
//       data['getIdAndFeederBySubstationId'] =
//           getIdAndFeederBySubstationId!.map((v) => v.toJson()).toList();
//     }
//     if (yearList != null) {
//       data['yearList'] = yearList!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class GetIdAndSubstation {
//   String? subStation;
//   int? id;

//   GetIdAndSubstation({this.subStation, this.id});

//   GetIdAndSubstation.fromJson(Map<String, dynamic> json) {
//     subStation = json['subStation'];
//     id = json['id'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['subStation'] = subStation;
//     data['id'] = id;
//     return data;
//   }
// }

// class ContractorGetInsert {
//   int? loginId;
//   String? name;

//   ContractorGetInsert({this.loginId, this.name});

//   ContractorGetInsert.fromJson(Map<String, dynamic> json) {
//     loginId = json['loginId'];
//     name = json['name'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['loginId'] = loginId;
//     data['name'] = name;
//     return data;
//   }
// }

// class SubstationList {
//   String? substationName;
//   String? substationId;

//   SubstationList({this.substationName, this.substationId});

//   SubstationList.fromJson(Map<String, dynamic> json) {
//     substationName = json['substationName'];
//     substationId = json['substationId'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['substationName'] = substationName;
//     data['substationId'] = substationId;
//     return data;
//   }
// }

// class GetIdAndFeederBySubstationId {
//   String? feeder;
//   int? id;

//   GetIdAndFeederBySubstationId({this.feeder, this.id});

//   GetIdAndFeederBySubstationId.fromJson(Map<String, dynamic> json) {
//     feeder = json['feeder'];
//     id = json['id'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['feeder'] = feeder;
//     data['id'] = id;
//     return data;
//   }
// }

// class YearList {
//   int? year;

//   YearList({this.year});

//   YearList.fromJson(Map<String, dynamic> json) {
//     year = json['year'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['year'] = year;
//     return data;
//   }
// }

// class FeederList {
//   String? feederName;

//   FeederList({this.feederName});

//   FeederList.fromJson(Map<String, dynamic> json) {
//     feederName = json['feederName'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['feederName'] = this.feederName;
//     return data;
//   }
// }










class AddNewRowMaintenancePlanModel {
  List<GetIdAndSubstation>? getIdAndSubstation;
  List<FeederList>? feederList;
  String? getCostPerMileBySubstation;
  List<ContractorGetInsert>? contractorGetInsert;
  List<SubstationList>? substationList;
  double? totalMiles;
  List<GetIdAndFeederBySubstationId>? getIdAndFeederBySubstationId;
  List<YearList>? yearList;

  AddNewRowMaintenancePlanModel(
      {this.getIdAndSubstation,
      this.feederList,
      this.getCostPerMileBySubstation,
      this.contractorGetInsert,
      this.substationList,
      this.totalMiles,
      this.getIdAndFeederBySubstationId,
      this.yearList});

  AddNewRowMaintenancePlanModel.fromJson(Map<String, dynamic> json) {
    if (json['getIdAndSubstation'] != null) {
      getIdAndSubstation = <GetIdAndSubstation>[];
      json['getIdAndSubstation'].forEach((v) {
        getIdAndSubstation!.add(GetIdAndSubstation.fromJson(v));
      });
    }
    if (json['feederList'] != null) {
      feederList = <FeederList>[];
      json['feederList'].forEach((v) {
        feederList!.add(FeederList.fromJson(v));
      });
    }
    getCostPerMileBySubstation = json['getCostPerMileBySubstation'];
    if (json['contractor_get_insert'] != null) {
      contractorGetInsert = <ContractorGetInsert>[];
      json['contractor_get_insert'].forEach((v) {
        contractorGetInsert!.add(ContractorGetInsert.fromJson(v));
      });
    }
    if (json['substationList'] != null) {
      substationList = <SubstationList>[];
      json['substationList'].forEach((v) {
        substationList!.add(SubstationList.fromJson(v));
      });
    }
    totalMiles = json['totalMiles'];
    if (json['getIdAndFeederBySubstationId'] != null) {
      getIdAndFeederBySubstationId = <GetIdAndFeederBySubstationId>[];
      json['getIdAndFeederBySubstationId'].forEach((v) {
        getIdAndFeederBySubstationId!
            .add(GetIdAndFeederBySubstationId.fromJson(v));
      });
    }
    if (json['yearList'] != null) {
      yearList = <YearList>[];
      json['yearList'].forEach((v) {
        yearList!.add(YearList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (getIdAndSubstation != null) {
      data['getIdAndSubstation'] =
          getIdAndSubstation!.map((v) => v.toJson()).toList();
    }
    if (feederList != null) {
      data['feederList'] = feederList!.map((v) => v.toJson()).toList();
    }
    data['getCostPerMileBySubstation'] = getCostPerMileBySubstation;
    if (contractorGetInsert != null) {
      data['contractor_get_insert'] =
          contractorGetInsert!.map((v) => v.toJson()).toList();
    }
    if (substationList != null) {
      data['substationList'] =
          substationList!.map((v) => v.toJson()).toList();
    }
    data['totalMiles'] = totalMiles;
    if (getIdAndFeederBySubstationId != null) {
      data['getIdAndFeederBySubstationId'] =
          getIdAndFeederBySubstationId!.map((v) => v.toJson()).toList();
    }
    if (yearList != null) {
      data['yearList'] = yearList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetIdAndSubstation {
  String? subStation;
  int? id;

  GetIdAndSubstation({this.subStation, this.id});

  GetIdAndSubstation.fromJson(Map<String, dynamic> json) {
    subStation = json['subStation'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['subStation'] = subStation;
    data['id'] = id;
    return data;
  }
}

class FeederList {
  String? feederId;
  String? feederName;

  FeederList({this.feederId, this.feederName});

  FeederList.fromJson(Map<String, dynamic> json) {
    feederId = json['feederId'];
    feederName = json['feederName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['feederId'] = feederId;
    data['feederName'] = feederName;
    return data;
  }
}

class ContractorGetInsert {
  int? loginId;
  String? name;

  ContractorGetInsert({this.loginId, this.name});

  ContractorGetInsert.fromJson(Map<String, dynamic> json) {
    loginId = json['loginId'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['loginId'] = loginId;
    data['name'] = name;
    return data;
  }
}

class SubstationList {
  String? substationName;
  String? substationId;

  SubstationList({this.substationName, this.substationId});

  SubstationList.fromJson(Map<String, dynamic> json) {
    substationName = json['substationName'];
    substationId = json['substationId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['substationName'] = substationName;
    data['substationId'] = substationId;
    return data;
  }
}

class GetIdAndFeederBySubstationId {
  String? feeder;
  int? id;

  GetIdAndFeederBySubstationId({this.feeder, this.id});

  GetIdAndFeederBySubstationId.fromJson(Map<String, dynamic> json) {
    feeder = json['feeder'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['feeder'] = feeder;
    data['id'] = id;
    return data;
  }
}

class YearList {
  int? year;

  YearList({this.year});

  YearList.fromJson(Map<String, dynamic> json) {
    year = json['year'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['year'] = year;
    return data;
  }
}
