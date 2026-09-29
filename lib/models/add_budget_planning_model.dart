class AddBudgetPlanningModel {
  List<GetAllBudgetPlanningOfSubstationAndIdList>?
      getAllBudgetPlanningOfSubstationAndIdList;
  List<int>? getInsertedBudgetId;
  int? budgetPlanningOfIdByYr;
  List<GetSPBUDGETTOTALDTLSBugetVsBilledList>?
      getSPBUDGETTOTALDTLSBugetVsBilledList;
  List<GetBudgetPlanningOfIdByYearList>? getBudgetPlanningOfIdByYearList;
  List<GetBudgetPlanningOfSubstationFdrAmtByBudgetIdList>?
      getBudgetPlanningOfSubstationFdrAmtByBudgetIdList;
  double? getSumOfAllBudgetByYr;
  List<GetAllSPBUDGETTOTALBILLINGList>? getAllSPBUDGETTOTALBILLINGList;
  List<GetAllBUDGETPLANDTLSByYrList>? getAllBUDGETPLANDTLSByYrList;
  List<GetFeederBySubstationIdList>? getFeederBySubstationIdList;

  AddBudgetPlanningModel(
      {this.getAllBudgetPlanningOfSubstationAndIdList,
      this.getInsertedBudgetId,
      this.budgetPlanningOfIdByYr,
      this.getSPBUDGETTOTALDTLSBugetVsBilledList,
      this.getBudgetPlanningOfIdByYearList,
      this.getBudgetPlanningOfSubstationFdrAmtByBudgetIdList,
      this.getSumOfAllBudgetByYr,
      this.getAllSPBUDGETTOTALBILLINGList,
      this.getAllBUDGETPLANDTLSByYrList,
      this.getFeederBySubstationIdList});

  AddBudgetPlanningModel.fromJson(Map<String, dynamic> json) {
    if (json['getAllBudgetPlanningOfSubstationAndIdList'] != null) {
      getAllBudgetPlanningOfSubstationAndIdList =
          <GetAllBudgetPlanningOfSubstationAndIdList>[];
      json['getAllBudgetPlanningOfSubstationAndIdList'].forEach((v) {
        getAllBudgetPlanningOfSubstationAndIdList!
            .add(GetAllBudgetPlanningOfSubstationAndIdList.fromJson(v));
      });
    }
    getInsertedBudgetId = json['getInsertedBudgetId'].cast<int>();
    budgetPlanningOfIdByYr = json['budgetPlanningOfIdByYr'];
    if (json['getSP_BUDGET_TOTAL_DTLSBugetVsBilledList'] != null) {
      getSPBUDGETTOTALDTLSBugetVsBilledList =
          <GetSPBUDGETTOTALDTLSBugetVsBilledList>[];
      json['getSP_BUDGET_TOTAL_DTLSBugetVsBilledList'].forEach((v) {
        getSPBUDGETTOTALDTLSBugetVsBilledList!
            .add(GetSPBUDGETTOTALDTLSBugetVsBilledList.fromJson(v));
      });
    }
    if (json['getBudgetPlanningOfIdByYearList'] != null) {
      getBudgetPlanningOfIdByYearList = <GetBudgetPlanningOfIdByYearList>[];
      json['getBudgetPlanningOfIdByYearList'].forEach((v) {
        getBudgetPlanningOfIdByYearList!
            .add(GetBudgetPlanningOfIdByYearList.fromJson(v));
      });
    }
    if (json['getBudgetPlanningOfSubstationFdrAmtByBudgetIdList'] != null) {
      getBudgetPlanningOfSubstationFdrAmtByBudgetIdList =
          <GetBudgetPlanningOfSubstationFdrAmtByBudgetIdList>[];
      json['getBudgetPlanningOfSubstationFdrAmtByBudgetIdList'].forEach((v) {
        getBudgetPlanningOfSubstationFdrAmtByBudgetIdList!
            .add(GetBudgetPlanningOfSubstationFdrAmtByBudgetIdList.fromJson(v));
      });
    }
    getSumOfAllBudgetByYr = json['getSumOfAllBudgetByYr'];
    if (json['getAllSP_BUDGET_TOTAL_BILLINGList'] != null) {
      getAllSPBUDGETTOTALBILLINGList = <GetAllSPBUDGETTOTALBILLINGList>[];
      json['getAllSP_BUDGET_TOTAL_BILLINGList'].forEach((v) {
        getAllSPBUDGETTOTALBILLINGList!
            .add(GetAllSPBUDGETTOTALBILLINGList.fromJson(v));
      });
    }
    if (json['getAllBUDGET_PLAN_DTLSByYrList'] != null) {
      getAllBUDGETPLANDTLSByYrList = <GetAllBUDGETPLANDTLSByYrList>[];
      json['getAllBUDGET_PLAN_DTLSByYrList'].forEach((v) {
        getAllBUDGETPLANDTLSByYrList!
            .add(GetAllBUDGETPLANDTLSByYrList.fromJson(v));
      });
    }
    if (json['getFeederBySubstationIdList'] != null) {
      getFeederBySubstationIdList = <GetFeederBySubstationIdList>[];
      json['getFeederBySubstationIdList'].forEach((v) {
        getFeederBySubstationIdList!
            .add(GetFeederBySubstationIdList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (getAllBudgetPlanningOfSubstationAndIdList != null) {
      data['getAllBudgetPlanningOfSubstationAndIdList'] =
          getAllBudgetPlanningOfSubstationAndIdList!
              .map((v) => v.toJson())
              .toList();
    }
    data['getInsertedBudgetId'] = getInsertedBudgetId;
    data['budgetPlanningOfIdByYr'] = budgetPlanningOfIdByYr;
    if (getSPBUDGETTOTALDTLSBugetVsBilledList != null) {
      data['getSP_BUDGET_TOTAL_DTLSBugetVsBilledList'] =
          getSPBUDGETTOTALDTLSBugetVsBilledList!
              .map((v) => v.toJson())
              .toList();
    }
    if (getBudgetPlanningOfIdByYearList != null) {
      data['getBudgetPlanningOfIdByYearList'] =
          getBudgetPlanningOfIdByYearList!.map((v) => v.toJson()).toList();
    }
    if (getBudgetPlanningOfSubstationFdrAmtByBudgetIdList != null) {
      data['getBudgetPlanningOfSubstationFdrAmtByBudgetIdList'] =
          getBudgetPlanningOfSubstationFdrAmtByBudgetIdList!
              .map((v) => v.toJson())
              .toList();
    }
    data['getSumOfAllBudgetByYr'] = getSumOfAllBudgetByYr;
    if (getAllSPBUDGETTOTALBILLINGList != null) {
      data['getAllSP_BUDGET_TOTAL_BILLINGList'] =
          getAllSPBUDGETTOTALBILLINGList!.map((v) => v.toJson()).toList();
    }
    if (getAllBUDGETPLANDTLSByYrList != null) {
      data['getAllBUDGET_PLAN_DTLSByYrList'] =
          getAllBUDGETPLANDTLSByYrList!.map((v) => v.toJson()).toList();
    }
    if (getFeederBySubstationIdList != null) {
      data['getFeederBySubstationIdList'] =
          getFeederBySubstationIdList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetAllBudgetPlanningOfSubstationAndIdList {
  String? substation;
  int? id;

  GetAllBudgetPlanningOfSubstationAndIdList({this.substation, this.id});

  GetAllBudgetPlanningOfSubstationAndIdList.fromJson(
      Map<String, dynamic> json) {
    substation = json['substation'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['substation'] = substation;
    data['id'] = id;
    return data;
  }
}

class GetSPBUDGETTOTALDTLSBugetVsBilledList {
  double? totalBudget;
  String? yr;
  double? totalBilling;

  GetSPBUDGETTOTALDTLSBugetVsBilledList(
      {this.totalBudget, this.yr, this.totalBilling});

  GetSPBUDGETTOTALDTLSBugetVsBilledList.fromJson(Map<String, dynamic> json) {
    totalBudget = json['totalBudget'];
    yr = json['yr'];
    totalBilling = json['totalBilling'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalBudget'] = totalBudget;
    data['yr'] = yr;
    data['totalBilling'] = totalBilling;
    return data;
  }
}

class GetBudgetPlanningOfIdByYearList {
  String? year;
  int? id;
  String? budget;

  GetBudgetPlanningOfIdByYearList({this.year, this.id, this.budget});

  GetBudgetPlanningOfIdByYearList.fromJson(Map<String, dynamic> json) {
    year = json['year'];
    id = json['id'];
    budget = json['budget'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['year'] = year;
    data['id'] = id;
    data['budget'] = budget;
    return data;
  }
}

class GetAllSPBUDGETTOTALBILLINGList {
  String? yr;
  double? totalBilling;

  GetAllSPBUDGETTOTALBILLINGList({this.yr, this.totalBilling});

  GetAllSPBUDGETTOTALBILLINGList.fromJson(Map<String, dynamic> json) {
    yr = json['yr'];
    totalBilling = json['totalBilling'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['yr'] = yr;
    data['totalBilling'] = totalBilling;
    return data;
  }
}

class GetAllBUDGETPLANDTLSByYrList {
  String? date;
  String? stormWork;
  String? workOrders;
  List<L1>? l1;
  String? midCycleWorkOrders;
  int? id;
  int? budgetId;
  String? changeOrders;
  String? subSpray;
  String? midCycleLinePatrol;
  String? midCycleSpray;

  GetAllBUDGETPLANDTLSByYrList(
      {this.date,
      this.stormWork,
      this.workOrders,
      this.l1,
      this.midCycleWorkOrders,
      this.id,
      this.budgetId,
      this.changeOrders,
      this.subSpray,
      this.midCycleLinePatrol,
      this.midCycleSpray});

  GetAllBUDGETPLANDTLSByYrList.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    stormWork = json['stormWork'];
    workOrders = json['workOrders'];
    if (json['l1'] != null) {
      l1 = <L1>[];
      json['l1'].forEach((v) {
        l1!.add(L1.fromJson(v));
      });
    }
    midCycleWorkOrders = json['midCycleWorkOrders'];
    id = json['id'];
    budgetId = json['budgetId'];
    changeOrders = json['changeOrders'];
    subSpray = json['subSpray'];
    midCycleLinePatrol = json['midCycleLinePatrol'];
    midCycleSpray = json['midCycleSpray'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['stormWork'] = stormWork;
    data['workOrders'] = workOrders;
    if (l1 != null) {
      data['l1'] = l1!.map((v) => v.toJson()).toList();
    }
    data['midCycleWorkOrders'] = midCycleWorkOrders;
    data['id'] = id;
    data['budgetId'] = budgetId;
    data['changeOrders'] = changeOrders;
    data['subSpray'] = subSpray;
    data['midCycleLinePatrol'] = midCycleLinePatrol;
    data['midCycleSpray'] = midCycleSpray;
    return data;
  }
}

class L1 {
  String? amount;
  int? planDtlsId;
  String? feeder;
  String? substation;
  int? id;

  L1({this.amount, this.planDtlsId, this.feeder, this.substation, this.id});

  L1.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    planDtlsId = json['planDtlsId'];
    feeder = json['feeder'];
    substation = json['substation'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['amount'] = amount;
    data['planDtlsId'] = planDtlsId;
    data['feeder'] = feeder;
    data['substation'] = substation;
    data['id'] = id;
    return data;
  }
}

class GetBudgetPlanningOfSubstationFdrAmtByBudgetIdList {
  String? year;
  String? substation;
  String? feeder;
  String? budget;
  String? insertedBudgetAndYearOfGetId;

  GetBudgetPlanningOfSubstationFdrAmtByBudgetIdList(
      {this.year,
      this.substation,
      this.feeder,
      this.budget,
      this.insertedBudgetAndYearOfGetId});

  GetBudgetPlanningOfSubstationFdrAmtByBudgetIdList.fromJson(
      Map<String, dynamic> json) {
    year = json['year'];
    substation = json['substation'];
    feeder = json['feeder'];
    budget = json['amount'];
    insertedBudgetAndYearOfGetId =
        json['insertedBudgetAndYearOfGetId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['year'] = year;
    data['substation'] = substation;
    data['feeder'] = feeder;
    data['amount'] = budget;
    data['insertedBudgetAndYearOfGetId'] =
        insertedBudgetAndYearOfGetId;
    return data;
  }
}

class GetFeederBySubstationIdList {
  String? feeder;
  int? id;
  String? substationId;

  GetFeederBySubstationIdList({this.feeder, this.id, this.substationId});

  GetFeederBySubstationIdList.fromJson(Map<String, dynamic> json) {
    feeder = json['feeder'];
    id = json['id'];
    substationId = json['substationId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['feeder'] = feeder;
    data['id'] = id;
    data['substationId'] = substationId;
    return data;
  }
}
