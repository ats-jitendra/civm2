class AddBudgetPlanThirdModel {
  List<int>? getInsertedBudgetId;
  List<GetDistinctSubstationbdgtPage3List>? getDistinctSubstationbdgtPage3List;
  int? getMaxIdOfBudgetPlanDtlsByYr;
  List<GetDistinctFeederList>? getDistinctFeederList;
  BudgetPlaningDtlsById? budgetPlaningDtlsById;
  BudgetPlanSubFdrDetlsById? budgetPlanSubFdrDetlsById;

  AddBudgetPlanThirdModel(
      {this.getInsertedBudgetId,
      this.getDistinctSubstationbdgtPage3List,
      this.getMaxIdOfBudgetPlanDtlsByYr,
      this.getDistinctFeederList,
      this.budgetPlaningDtlsById,
      this.budgetPlanSubFdrDetlsById});

  AddBudgetPlanThirdModel.fromJson(Map<String, dynamic> json) {
    getInsertedBudgetId = json['getInsertedBudgetId'].cast<int>();
    if (json['getDistinctSubstationbdgtPage3List'] != null) {
      getDistinctSubstationbdgtPage3List =
          <GetDistinctSubstationbdgtPage3List>[];
      json['getDistinctSubstationbdgtPage3List'].forEach((v) {
        getDistinctSubstationbdgtPage3List!
            .add(GetDistinctSubstationbdgtPage3List.fromJson(v));
      });
    }
    getMaxIdOfBudgetPlanDtlsByYr = json['getMaxIdOfBudgetPlanDtlsByYr'];
    if (json['getDistinctFeederList'] != null) {
      getDistinctFeederList = <GetDistinctFeederList>[];
      json['getDistinctFeederList'].forEach((v) {
        getDistinctFeederList!.add(GetDistinctFeederList.fromJson(v));
      });
    }
    budgetPlaningDtlsById = json['budgetPlaningDtlsById'] != null
        ? BudgetPlaningDtlsById.fromJson(json['budgetPlaningDtlsById'])
        : null;
    budgetPlanSubFdrDetlsById = json['budgetPlanSubFdrDetlsById'] != null
        ? BudgetPlanSubFdrDetlsById.fromJson(
            json['budgetPlanSubFdrDetlsById'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['getInsertedBudgetId'] = getInsertedBudgetId;
    if (getDistinctSubstationbdgtPage3List != null) {
      data['getDistinctSubstationbdgtPage3List'] = getDistinctSubstationbdgtPage3List!
          .map((v) => v.toJson())
          .toList();
    }
    data['getMaxIdOfBudgetPlanDtlsByYr'] = getMaxIdOfBudgetPlanDtlsByYr;
    if (getDistinctFeederList != null) {
      data['getDistinctFeederList'] =
          getDistinctFeederList!.map((v) => v.toJson()).toList();
    }
    if (budgetPlaningDtlsById != null) {
      data['budgetPlaningDtlsById'] = budgetPlaningDtlsById!.toJson();
    }
    if (budgetPlanSubFdrDetlsById != null) {
      data['budgetPlanSubFdrDetlsById'] =
          budgetPlanSubFdrDetlsById!.toJson();
    }
    return data;
  }
}

class GetDistinctSubstationbdgtPage3List {
  String? substation;

  GetDistinctSubstationbdgtPage3List({this.substation});

  GetDistinctSubstationbdgtPage3List.fromJson(Map<String, dynamic> json) {
    substation = json['substation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['substation'] = substation;
    return data;
  }
}

class GetDistinctFeederList {
  String? feeder;

  GetDistinctFeederList({this.feeder});

  GetDistinctFeederList.fromJson(Map<String, dynamic> json) {
    feeder = json['feeder'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['feeder'] = feeder;
    return data;
  }
}

class BudgetPlaningDtlsById {
  int? id;
  int? budgetId;
  String? date;
  String? changeOrders;
  String? midCycleLinePatrol;
  String? midCycleSpray;
  String? midCycleWorkOrders;
  String? workOrders;
  String? stormWork;
  String? subSpray;

  BudgetPlaningDtlsById(
      {this.id,
      this.budgetId,
      this.date,
      this.changeOrders,
      this.midCycleLinePatrol,
      this.midCycleSpray,
      this.midCycleWorkOrders,
      this.workOrders,
      this.stormWork,
      this.subSpray});

  BudgetPlaningDtlsById.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    budgetId = json['budgetId'];
    date = json['date'];
    changeOrders = json['changeOrders'];
    midCycleLinePatrol = json['midCycleLinePatrol'];
    midCycleSpray = json['midCycleSpray'];
    midCycleWorkOrders = json['midCycleWorkOrders'];
    workOrders = json['workOrders'];
    stormWork = json['stormWork'];
    subSpray = json['subSpray'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['budgetId'] = budgetId;
    data['date'] = date;
    data['changeOrders'] = changeOrders;
    data['midCycleLinePatrol'] = midCycleLinePatrol;
    data['midCycleSpray'] = midCycleSpray;
    data['midCycleWorkOrders'] = midCycleWorkOrders;
    data['workOrders'] = workOrders;
    data['stormWork'] = stormWork;
    data['subSpray'] = subSpray;
    return data;
  }
}

class BudgetPlanSubFdrDetlsById {
  int? id;
  int? planDtlsId;
  String? substation;
  String? feeder;
  String? amount;

  BudgetPlanSubFdrDetlsById(
      {this.id, this.planDtlsId, this.substation, this.feeder, this.amount});

  BudgetPlanSubFdrDetlsById.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    planDtlsId = json['planDtlsId'];
    substation = json['substation'];
    feeder = json['feeder'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['planDtlsId'] = planDtlsId;
    data['substation'] = substation;
    data['feeder'] = feeder;
    data['amount'] = amount;
    return data;
  }
}
