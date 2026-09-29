class AddNewRowMaintenancePlanTabularDataModel {
  List<GetAlls>? getAlls;
  List<YearList>? yearList;

  AddNewRowMaintenancePlanTabularDataModel({this.getAlls});

  AddNewRowMaintenancePlanTabularDataModel.fromJson(Map<String, dynamic> json) {
    if (json['getAlls'] != null) {
      getAlls = <GetAlls>[];
      json['getAlls'].forEach((v) {
        getAlls!.add(GetAlls.fromJson(v));
      });
    }
    if (json['yearList'] != null) {
      yearList = <YearList>[];
      json['yearList'].forEach((v) {
        yearList!.add(new YearList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (getAlls != null) {
      data['getAlls'] = getAlls!.map((v) => v.toJson()).toList();
    }
    if (yearList != null) {
      data['yearList'] = yearList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetAlls {
  String? budgetType;
  String? contractor;
  String? role;
  String? contractYear;
  double? costPerMile;
  String? feeder;
  int? dueWeek;
  String? county;
  int? tokenNo;
  int? nextMaintDue;
  String? type;
  String? cycle;
  String? maintDateHistory;
  String? rowYear;
  int? dueMonth;
  String? maintType;
  String? street;
  String? substation;
  int? id;
  String? actualCost;
  String? lastMaintDone;
  String? contractorCompany;
  String? planType;
  String? superviser;
  int? maintCount;
  String? estCost;
  String? totalMiles;
  String? estTime;
  String? contractEndYear;
  String? district;
  String? supervisor;
  double? totalCost;
  String? status;
  String? visibilityFlag;
  String? masterJobNo;

  GetAlls(
      {this.budgetType,
      this.contractor,
      this.role,
      this.contractYear,
      this.costPerMile,
      this.feeder,
      this.dueWeek,
      this.county,
      this.tokenNo,
      this.nextMaintDue,
      this.type,
      this.cycle,
      this.maintDateHistory,
      this.rowYear,
      this.dueMonth,
      this.maintType,
      this.street,
      this.substation,
      this.id,
      this.actualCost,
      this.lastMaintDone,
      this.contractorCompany,
      this.planType,
      this.superviser,
      this.maintCount,
      this.estCost,
      this.totalMiles,
      this.estTime,
      this.contractEndYear,
      this.district,
      this.supervisor,
      this.totalCost,
      this.status,
      this.visibilityFlag,
      this.masterJobNo});

  GetAlls.fromJson(Map<String, dynamic> json) {
    budgetType = json['budgetType'];
    contractor = json['contractor'];
    role = json['role'];
    contractYear = json['contractYear'];
    costPerMile = json['costPerMile'];
    feeder = json['feeder'];
    dueWeek = json['dueWeek'];
    county = json['county'];
    tokenNo = json['tokenNo'];
    nextMaintDue = json['nextMaintDue'];
    type = json['type'];
    cycle = json['cycle'];
    maintDateHistory = json['maintDateHistory'];
    rowYear = json['rowYear'];
    dueMonth = json['dueMonth'];
    maintType = json['maintType'];
    street = json['street'];
    substation = json['substation'];
    id = json['id'];
    actualCost = json['actualCost'];
    lastMaintDone = json['lastMaintDone'];
    contractorCompany = json['contractorCompany'];
    planType = json['planType'];
    superviser = json['superviser'];
    maintCount = json['maintCount'];
    estCost = json['estCost'];
    totalMiles = json['totalMiles'];
    estTime = json['estTime'];
    contractEndYear = json['contractEndYear'];
    district = json['district'];
    supervisor = json['supervisor'];
    totalCost = json['totalCost'];
    status = json['status'];
    visibilityFlag = json['visibilityFlag'];
    masterJobNo = json['masterJobNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['budgetType'] = budgetType;
    data['contractor'] = contractor;
    data['role'] = role;
    data['contractYear'] = contractYear;
    data['costPerMile'] = costPerMile;
    data['feeder'] = feeder;
    data['dueWeek'] = dueWeek;
    data['county'] = county;
    data['tokenNo'] = tokenNo;
    data['nextMaintDue'] = nextMaintDue;
    data['type'] = type;
    data['cycle'] = cycle;
    data['maintDateHistory'] = maintDateHistory;
    data['rowYear'] = rowYear;
    data['dueMonth'] = dueMonth;
    data['maintType'] = maintType;
    data['street'] = street;
    data['substation'] = substation;
    data['id'] = id;
    data['actualCost'] = actualCost;
    data['lastMaintDone'] = lastMaintDone;
    data['contractorCompany'] = contractorCompany;
    data['planType'] = planType;
    data['superviser'] = superviser;
    data['maintCount'] = maintCount;
    data['estCost'] = estCost;
    data['totalMiles'] = totalMiles;
    data['estTime'] = estTime;
    data['contractEndYear'] = contractEndYear;
    data['district'] = district;
    data['supervisor'] = supervisor;
    data['totalCost'] = totalCost;
    data['status'] = status;
    data['visibilityFlag'] = visibilityFlag;
    data['masterJobNo'] = masterJobNo;
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
