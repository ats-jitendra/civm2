class AddNewRowMaintenanceTabularDetailModel {
  List<GetAlls1>? getAlls;
  List<YearList>? yearList;

  AddNewRowMaintenanceTabularDetailModel({this.getAlls, this.yearList});

  AddNewRowMaintenanceTabularDetailModel.fromJson(Map<String, dynamic> json) {
    if (json['getAlls'] != null) {
      getAlls = <GetAlls1>[];
      json['getAlls'].forEach((v) {
        getAlls!.add(GetAlls1.fromJson(v));
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
    if (getAlls != null) {
      data['getAlls'] = getAlls!.map((v) => v.toJson()).toList();
    }
    if (yearList != null) {
      data['yearList'] = yearList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetAlls1 {
  String? budgetType;
  String? contractor;
  String? role;
  String? contractYear;
  double? costPerMile;
  String? feeder;
  String? dueWeek;
  String? county;
  int? tokenNo;
  int? nextMaintDue;
  String? type;
  String? cycle;
  String? maintDateHistory;
  String? addChatNotes;
  String? rowYear;
  String? dueMonth;
  String? maintType;
  String? street;
  String? substation;
  int? id;
  String? initiatedBy;
  String? actualCost;
  String? lastMaintDone;
  String? contractorCompany;
  String? planType;
  String? superviser;
  String? maintCount;
  String? estCost;
  String? crewName;
  String? totalMiles;
  String? estTime;
  String? contractEndYear;
  String? visibilityFlag;
  String? district;
  String? supervisor;
  double? totalCost;
  String? status;
  String? masterJobNo;
  String? contractorId;
  String? crew;

  GetAlls1(
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
      this.addChatNotes,
      this.rowYear,
      this.dueMonth,
      this.maintType,
      this.street,
      this.substation,
      this.id,
      this.initiatedBy,
      this.actualCost,
      this.lastMaintDone,
      this.contractorCompany,
      this.planType,
      this.superviser,
      this.maintCount,
      this.estCost,
      this.crewName,
      this.totalMiles,
      this.estTime,
      this.contractEndYear,
      this.visibilityFlag,
      this.district,
      this.supervisor,
      this.totalCost,
      this.status,
      this.masterJobNo,
      this.contractorId,
      this.crew});

  GetAlls1.fromJson(Map<String, dynamic> json) {
    budgetType = json['budgetType']??'';
    contractor = json['contractor']??'';
    role = json['role']??'';
    contractYear = json['contractYear']??'';
    costPerMile = json['costPerMile']??0.0;
    feeder = json['feeder']??'';
    dueWeek = json['dueWeek']??'';
    county = json['county']??'';
    tokenNo = json['tokenNo']??0;
    nextMaintDue = json['nextMaintDue']??0;
    type = json['type']??'';
    cycle = json['cycle']??'';
    maintDateHistory = json['maintDateHistory']??'';
    addChatNotes = json['addChatNotes']??'';
    rowYear = json['rowYear']??'';
    dueMonth = json['dueMonth']??'';
    maintType = json['maintType']??'';
    street = json['street']??'';
    substation = json['substation']??'';
    id = json['id']??0;
    initiatedBy = json['initiatedBy']??'';
    actualCost = json['actualCost']??'';
    lastMaintDone = json['lastMaintDone']??'';
    contractorCompany = json['contractorCompany']??'';
    planType = json['planType']??'';
    superviser = json['superviser']??'';
    maintCount = json['maintCount']??'';
    estCost = json['estCost']??'';
    crewName = json['crewName']??'';
    totalMiles = json['totalMiles']??'';
    estTime = json['estTime']??'';
    contractEndYear = json['contractEndYear']??'';
    visibilityFlag = json['visibilityFlag']??'';
    district = json['district']??'';
    supervisor = json['supervisor']??'';
    totalCost = json['totalCost']??0.0;
    status = json['status']??'';
    masterJobNo = json['masterJobNo']??'';
    contractorId = json['contractorId']??'';
    crew = json['crew']??'';
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
    data['addChatNotes'] = addChatNotes;
    data['rowYear'] = rowYear;
    data['dueMonth'] = dueMonth;
    data['maintType'] = maintType;
    data['street'] = street;
    data['substation'] = substation;
    data['id'] = id;
    data['initiatedBy'] = initiatedBy;
    data['actualCost'] = actualCost;
    data['lastMaintDone'] = lastMaintDone;
    data['contractorCompany'] = contractorCompany;
    data['planType'] = planType;
    data['superviser'] = superviser;
    data['maintCount'] = maintCount;
    data['estCost'] = estCost;
    data['crewName'] = crewName;
    data['totalMiles'] = totalMiles;
    data['estTime'] = estTime;
    data['contractEndYear'] = contractEndYear;
    data['visibilityFlag'] = visibilityFlag;
    data['district'] = district;
    data['supervisor'] = supervisor;
    data['totalCost'] = totalCost;
    data['status'] = status;
    data['masterJobNo'] = masterJobNo;
    data['contractorId'] = contractorId;
    data['crew'] = crew;
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
