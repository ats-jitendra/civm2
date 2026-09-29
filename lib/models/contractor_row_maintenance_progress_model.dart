class ContractorRowMaintenanceProgressModel {
  List<FindCrewOrderNo>? findCrewOrderNo;
  List<GetAllList>? getAllList;
  List<FindSubstationByContractorAndNextMaintDues>?
      findSubstationByContractorAndNextMaintDues;
  List<FindTokenNoBySubstationAndFeederAndNextMaintsDue>?
      findTokenNoBySubstationAndFeederAndNextMaintsDue;
  List<FindNextMaintDueBuyContractors>? findNextMaintDueBuyContractors;
  List<FindAllByContractorAndNextMaintDueAndSubstation>?
      findAllByContractorAndNextMaintDueAndSubstation;
  // List<FindTotalMilesByTokenNo>? findTotalMilesByTokenNo;
  List<GetAllVMAVEGETATIONCREWFORMBySubMilesCostIdList>?
      getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList;
  List<FindAllByTokenNumbers>? findAllByTokenNumbers;
  List<FindLastMaintDone>? findLastMaintDone;

  ContractorRowMaintenanceProgressModel(
      {this.findCrewOrderNo,
      this.findSubstationByContractorAndNextMaintDues,
      this.findTokenNoBySubstationAndFeederAndNextMaintsDue,
      this.findNextMaintDueBuyContractors,
      this.findAllByContractorAndNextMaintDueAndSubstation,
      // this.findTotalMilesByTokenNo,
      this.getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList,
      this.findAllByTokenNumbers,
      this.findLastMaintDone});

  ContractorRowMaintenanceProgressModel.fromJson(Map<String, dynamic> json) {
    if (json['findCrewOrderNo'] != null) {
      findCrewOrderNo = <FindCrewOrderNo>[];
      json['findCrewOrderNo'].forEach((v) {
        findCrewOrderNo!.add(FindCrewOrderNo.fromJson(v));
      });
    }
    if (json['getAllList'] != null) {
      getAllList = <GetAllList>[];
      json['getAllList'].forEach((v) {
        getAllList!.add(GetAllList.fromJson(v));
      });
    }
    if (json['findSubstationByContractorAndNextMaintDues'] != null) {
      findSubstationByContractorAndNextMaintDues =
          <FindSubstationByContractorAndNextMaintDues>[];
      json['findSubstationByContractorAndNextMaintDues'].forEach((v) {
        findSubstationByContractorAndNextMaintDues!
            .add(FindSubstationByContractorAndNextMaintDues.fromJson(v));
      });
    }
    if (json['findTokenNoBySubstationAndFeederAndNextMaintsDue'] != null) {
      findTokenNoBySubstationAndFeederAndNextMaintsDue =
          <FindTokenNoBySubstationAndFeederAndNextMaintsDue>[];
      json['findTokenNoBySubstationAndFeederAndNextMaintsDue'].forEach((v) {
        findTokenNoBySubstationAndFeederAndNextMaintsDue!
            .add(FindTokenNoBySubstationAndFeederAndNextMaintsDue.fromJson(v));
      });
    }
    if (json['findNextMaintDueBuyContractors'] != null) {
      findNextMaintDueBuyContractors = <FindNextMaintDueBuyContractors>[];
      json['findNextMaintDueBuyContractors'].forEach((v) {
        findNextMaintDueBuyContractors!
            .add(FindNextMaintDueBuyContractors.fromJson(v));
      });
    }
    if (json['findAllByContractorAndNextMaintDueAndSubstation'] != null) {
      findAllByContractorAndNextMaintDueAndSubstation =
          <FindAllByContractorAndNextMaintDueAndSubstation>[];
      json['findAllByContractorAndNextMaintDueAndSubstation'].forEach((v) {
        findAllByContractorAndNextMaintDueAndSubstation!
            .add(FindAllByContractorAndNextMaintDueAndSubstation.fromJson(v));
      });
    }
    // if (json['findTotalMilesByTokenNo'] != null) {
    //   findTotalMilesByTokenNo = <FindTotalMilesByTokenNo>[];
    //   json['findTotalMilesByTokenNo'].forEach((v) {
    //     findTotalMilesByTokenNo!.add(FindTotalMilesByTokenNo.fromJson(v));
    //   });
    // }
    if (json['getAllVMA_VEGETATION_CREWFORMBySubMilesCostIdList'] != null) {
      getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList =
          <GetAllVMAVEGETATIONCREWFORMBySubMilesCostIdList>[];
      json['getAllVMA_VEGETATION_CREWFORMBySubMilesCostIdList'].forEach((v) {
        getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList!
            .add(GetAllVMAVEGETATIONCREWFORMBySubMilesCostIdList.fromJson(v));
      });
    }
    if (json['findAllByTokenNumbers'] != null) {
      findAllByTokenNumbers = <FindAllByTokenNumbers>[];
      json['findAllByTokenNumbers'].forEach((v) {
        findAllByTokenNumbers!.add(FindAllByTokenNumbers.fromJson(v));
      });
    }
    if (json['findLastMaintDone'] != null) {
      findLastMaintDone = <FindLastMaintDone>[];
      json['findLastMaintDone'].forEach((v) {
        findLastMaintDone!.add(FindLastMaintDone.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (findCrewOrderNo != null) {
      data['findCrewOrderNo'] =
          findCrewOrderNo!.map((v) => v.toJson()).toList();
    }
    if (getAllList != null) {
      data['getAllList'] = getAllList!.map((v) => v.toJson()).toList();
    }
    if (findSubstationByContractorAndNextMaintDues != null) {
      data['findSubstationByContractorAndNextMaintDues'] =
          findSubstationByContractorAndNextMaintDues!
              .map((v) => v.toJson())
              .toList();
    }
    if (findTokenNoBySubstationAndFeederAndNextMaintsDue != null) {
      data['findTokenNoBySubstationAndFeederAndNextMaintsDue'] =
          findTokenNoBySubstationAndFeederAndNextMaintsDue!
              .map((v) => v.toJson())
              .toList();
    }
    if (findNextMaintDueBuyContractors != null) {
      data['findNextMaintDueBuyContractors'] =
          findNextMaintDueBuyContractors!.map((v) => v.toJson()).toList();
    }
    if (findAllByContractorAndNextMaintDueAndSubstation != null) {
      data['findAllByContractorAndNextMaintDueAndSubstation'] =
          findAllByContractorAndNextMaintDueAndSubstation!
              .map((v) => v.toJson())
              .toList();
    }
    // if (findTotalMilesByTokenNo != null) {
    //   data['findTotalMilesByTokenNo'] =
    //       findTotalMilesByTokenNo!.map((v) => v.toJson()).toList();
    // }
    if (getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList != null) {
      data['getAllVMA_VEGETATION_CREWFORMBySubMilesCostIdList'] =
          getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList!
              .map((v) => v.toJson())
              .toList();
    }
    if (findAllByTokenNumbers != null) {
      data['findAllByTokenNumbers'] =
          findAllByTokenNumbers!.map((v) => v.toJson()).toList();
    }
    if (findLastMaintDone != null) {
      data['findLastMaintDone'] =
          findLastMaintDone!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FindLastMaintDone {
  String? lastUpdated;

  FindLastMaintDone({this.lastUpdated});

  FindLastMaintDone.fromJson(Map<String, dynamic> json) {
    lastUpdated = json['lastUpdated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lastUpdated'] = lastUpdated;
    return data;
  }
}

class FindCrewOrderNo {
  String? crew;

  FindCrewOrderNo({this.crew});

  FindCrewOrderNo.fromJson(Map<String, dynamic> json) {
    crew = json['crew'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['crew'] = crew;
    return data;
  }
}

class FindSubstationByContractorAndNextMaintDues {
  String? subId;
  String? subStation;

  FindSubstationByContractorAndNextMaintDues({this.subId, this.subStation});

  FindSubstationByContractorAndNextMaintDues.fromJson(
      Map<String, dynamic> json) {
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

class FindTokenNoBySubstationAndFeederAndNextMaintsDue {
  int? tokenNo;

  FindTokenNoBySubstationAndFeederAndNextMaintsDue({this.tokenNo});

  FindTokenNoBySubstationAndFeederAndNextMaintsDue.fromJson(
      Map<String, dynamic> json) {
    tokenNo = json['tokenNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tokenNo'] = tokenNo;
    return data;
  }
}

class FindNextMaintDueBuyContractors {
  int? nextMaintDues;

  FindNextMaintDueBuyContractors({this.nextMaintDues});

  FindNextMaintDueBuyContractors.fromJson(Map<String, dynamic> json) {
    nextMaintDues = json['NextMaintDues'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['NextMaintDues'] = nextMaintDues;
    return data;
  }
}

class FindAllByContractorAndNextMaintDueAndSubstation {
  String? subId;
  String? fdrId;
  String? fdrName;
  String? feeder;
  String? subStation;

  FindAllByContractorAndNextMaintDueAndSubstation(
      {this.subId, this.fdrId, this.fdrName, this.feeder, this.subStation});

  FindAllByContractorAndNextMaintDueAndSubstation.fromJson(
      Map<String, dynamic> json) {
    subId = json['subId'];
    fdrId = json['fdrId'];
    fdrName = json['fdrName'];
    feeder = json['feeder'];
    subStation = json['subStation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['subId'] = subId;
    data['fdrId'] = fdrId;
    data['fdrName'] = fdrName;
    data['feeder'] = feeder;
    data['subStation'] = subStation;
    return data;
  }
}

// class FindTotalMilesByTokenNo {
//   String? totalMiles;

//   FindTotalMilesByTokenNo({this.totalMiles});

//   FindTotalMilesByTokenNo.fromJson(Map<String, dynamic> json) {
//     totalMiles = json['totalMiles'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['totalMiles'] = totalMiles;
//     return data;
//   }
// }

class GetAllVMAVEGETATIONCREWFORMBySubMilesCostIdList {
  double? effectedNoOfDays;
  double? milesCompleted;
  String? fdrName;
  String? delayCause;
  String? feeder;
  String? rowMethod;
  String? substation;
  int? tblSubMilesCostId;
  int? id;
  double? totalMiles;
  String? delayReason;
  String? status;
  String? notes;
  String? createDate;

  GetAllVMAVEGETATIONCREWFORMBySubMilesCostIdList(
      {this.effectedNoOfDays,
      this.milesCompleted,
      this.fdrName,
      this.delayCause,
      this.feeder,
      this.rowMethod,
      this.substation,
      this.tblSubMilesCostId,
      this.id,
      this.totalMiles,
      this.delayReason,
      this.status,
      this.createDate,
      this.notes});

  GetAllVMAVEGETATIONCREWFORMBySubMilesCostIdList.fromJson(
      Map<String, dynamic> json) {
    effectedNoOfDays = json['effectedNoOfDays'];
    milesCompleted = json['milesCompleted'];
    fdrName = json['fdrName'];
    delayCause = json['delayCause'];
    feeder = json['feeder'];
    rowMethod = json['rowMethod'];
    substation = json['substation'];
    tblSubMilesCostId = json['tblSubMilesCostId'];
    id = json['id'];
    totalMiles = json['totalMiles'];
    delayReason = json['delayReason'];
    status = json['status'];
    notes = json['notes'];
    createDate = json['createDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['effectedNoOfDays'] = effectedNoOfDays;
    data['milesCompleted'] = milesCompleted;
    data['fdrName'] = fdrName;
    data['delayCause'] = delayCause;
    data['feeder'] = feeder;
    data['rowMethod'] = rowMethod;
    data['substation'] = substation;
    data['tblSubMilesCostId'] = tblSubMilesCostId;
    data['id'] = id;
    data['totalMiles'] = totalMiles;
    data['delayReason'] = delayReason;
    data['status'] = status;
    data['notes'] = notes;
    data['createDate'] = createDate;
    return data;
  }
}

class FindAllByTokenNumbers {
  double? costPerMile;
  double? milesCompleted;
  double? milesPending;
  String? feeder;
  int? dueWeek;
  String? county;
  String? nextMaintDue;
  String? totalMiles;
  String? cycle;
  String? crew;
  double? wtdProgress;
  int? dueMonth;
  double? milesInProgress;
  String? street;
  String? district;
  String? substation;
  int? id;
  double? mtdProgress;
  double? ytdProgress;
  double? totalCost;
  double? budget;
  String? budgetType;

  FindAllByTokenNumbers(
      {this.costPerMile,
      this.milesCompleted,
      this.milesPending,
      this.feeder,
      this.dueWeek,
      this.county,
      this.nextMaintDue,
      this.totalMiles,
      this.cycle,
      this.crew,
      this.wtdProgress,
      this.dueMonth,
      this.milesInProgress,
      this.street,
      this.district,
      this.substation,
      this.id,
      this.mtdProgress,
      this.ytdProgress,
      this.totalCost,
      this.budget,
      this.budgetType});

  // FindAllByTokenNumbers.fromJson(Map<String, dynamic> json) {
  //   costPerMile = json['costPerMile'];
  //   milesCompleted = json['milesCompleted'];
  //   milesPending = json['milesPending'];
  //   feeder = json['feeder'];
  //   dueWeek = json['dueWeek'];
  //   county = json['county'];
  //   nextMaintDue = json['nextMaintDue'];
  //   totalMiles = json['totalMiles'];
  //   cycle = json['cycle'];
  //   crew = json['crew'];
  //   wtdProgress = json['wtdProgress'];
  //   dueMonth = json['dueMonth'];
  //   milesInProgress = json['milesInProgress'];
  //   street = json['street'];
  //   district = json['district'];
  //   substation = json['substation'];
  //   id = json['id'];
  //   mtdProgress = json['mtdProgress'];
  //   ytdProgress = json['ytdProgress'];
  //   totalCost = json['totalCost'];
  //   budget = json['budget'];
  // }

  FindAllByTokenNumbers.fromJson(Map<String, dynamic> json) {
    costPerMile = json['costPerMile']?.toDouble();
    milesCompleted = json['milesCompleted']?.toDouble();
    milesPending = json['milesPending']?.toDouble();
    feeder = json['feeder'];
    dueWeek = json['dueWeek'];
    county = json['county'];
    nextMaintDue = json['nextMaintDue'];
    totalMiles = json['totalMiles']; // Check if this should be a double
    cycle = json['cycle'];
    crew = json['crew'];
    wtdProgress = json['wtdProgress']?.toDouble();
    dueMonth = json['dueMonth'];
    milesInProgress = json['milesInProgress']?.toDouble();
    street = json['street'];
    district = json['district'];
    substation = json['substation'];
    id = json['id'];
    mtdProgress = json['mtdProgress']?.toDouble();
    ytdProgress = json['ytdProgress']?.toDouble();
    totalCost = json['totalCost']?.toDouble();
    budget = json['budget']?.toDouble();
    budgetType = json['budgetType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['costPerMile'] = costPerMile;
    data['milesCompleted'] = milesCompleted;
    data['milesPending'] = milesPending;
    data['feeder'] = feeder;
    data['dueWeek'] = dueWeek;
    data['county'] = county;
    data['nextMaintDue'] = nextMaintDue;
    data['totalMiles'] = totalMiles;
    data['cycle'] = cycle;
    data['crew'] = crew;
    data['wtdProgress'] = wtdProgress;
    data['dueMonth'] = dueMonth;
    data['milesInProgress'] = milesInProgress;
    data['street'] = street;
    data['district'] = district;
    data['substation'] = substation;
    data['id'] = id;
    data['mtdProgress'] = mtdProgress;
    data['ytdProgress'] = ytdProgress;
    data['totalCost'] = totalCost;
    data['budget'] = budget;
    data['budgetType'] = budgetType;
    return data;
  }
}

class GetAllList {
  String? feederId;
  int? orderNo;
  String? feeder;
  String? substation;
  String? substationId;

  GetAllList(
      {this.feederId,
      this.orderNo,
      this.feeder,
      this.substation,
      this.substationId});

  GetAllList.fromJson(Map<String, dynamic> json) {
    feederId = json['feederId'];
    orderNo = json['orderNo'];
    feeder = json['feeder'];
    substation = json['substation'];
    substationId = json['substationId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['feederId'] = feederId;
    data['orderNo'] = orderNo;
    data['feeder'] = feeder;
    data['substation'] = substation;
    data['substationId'] = substationId;
    return data;
  }
}
