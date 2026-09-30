class AdminDashboardDataListModel {
  List<AdminDashboardDataListdata>? gettabledata;

  AdminDashboardDataListModel({this.gettabledata});

  AdminDashboardDataListModel.fromJson(Map<String, dynamic> json) {
    if (json['gettabledata'] != null) {
      gettabledata = <AdminDashboardDataListdata>[];
      json['gettabledata'].forEach((v) {
        gettabledata!.add(new AdminDashboardDataListdata.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (gettabledata != null) {
      data['gettabledata'] = gettabledata!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AdminDashboardDataListdata {
  String? type;
  String? jobno;
  String? serviceOrderNo;
  String? annualHerbicide;
  String? status;
  String? substation;
  String? feeder;
  String? maintenanceType;
  String? createdBy;
  String? transmissionName;
  String? foreman;
  String? contractorCompany;
  String? createDate;
  String? totalMiles;
  String? contractYear;
  String? cycle;
  String? adminNotes;
  String? generalForemanNotes;
  String? dateOfInspection;
  String? followUpDate;
  String? costPerMile;
  String? totalCost;
  String? nextMaintDue;
  String? budgetType;
  String? planType;

  AdminDashboardDataListdata(
      {this.type,
      this.jobno,
      this.serviceOrderNo,
      this.annualHerbicide,
      this.status,
      this.substation,
      this.feeder,
      this.maintenanceType,
      this.createdBy,
      this.transmissionName,
      this.foreman,
      this.contractorCompany,
      this.createDate,
      this.totalMiles,
      this.contractYear,
      this.cycle,
      this.adminNotes,
      this.generalForemanNotes,
      this.dateOfInspection,
      this.followUpDate,
      this.costPerMile,
      this.totalCost,
      this.nextMaintDue,
      this.budgetType,
      this.planType});

  AdminDashboardDataListdata.fromJson(Map<String, dynamic> json) {
    type = json['type'] ?? '';
    jobno = json['jobno'] ?? '';
    serviceOrderNo = json['serviceOrderNo'] ?? '';
    annualHerbicide = json['annualHerbicide'] ?? '';
    status = json['status'] ?? '';
    substation = json['substation'] ?? '';
    feeder = json['feeder'] ?? '';
    maintenanceType = json['maintenanceType'] ?? '';
    createdBy = json['createdBy'] ?? '';
    transmissionName = json['transmissionName'] ?? '';
    foreman = json['foreman'] ?? '';
    contractorCompany = json['contractorCompany'] ?? '';
    createDate = json['createDate'] ?? '';
    totalMiles = json['totalMiles'] ?? '';
    contractYear = json['contractYear'] ?? '';
    cycle = json['cycle'] ?? '';
    adminNotes = json['adminNotes'] ?? '';
    generalForemanNotes = json['generalForemanNotes'] ?? '';
    dateOfInspection = json['dateOfInspection'] ?? '';
    followUpDate = json['followUpDate'] ?? '';
    costPerMile = json['costPerMile'] ?? '';
    totalCost = json['totalCost'] ?? '';
    nextMaintDue = json['nextMaintDue'] ?? '';
    budgetType = json['budgetType'] ?? '';
    planType = json['planType'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = type;
    data['jobno'] = jobno;
    data['serviceOrderNo'] = serviceOrderNo;
    data['annualHerbicide'] = annualHerbicide;
    data['status'] = status;
    data['substation'] = substation;
    data['feeder'] = feeder;
    data['maintenanceType'] = maintenanceType;
    data['createdBy'] = createdBy;
    data['transmissionName'] = transmissionName;
    data['foreman'] = foreman;
    data['contractorCompany'] = contractorCompany;
    data['createDate'] = createDate;
    data['totalMiles'] = totalMiles;
    data['contractYear'] = contractYear;
    data['cycle'] = cycle;
    data['adminNotes'] = adminNotes;
    data['generalForemanNotes'] = generalForemanNotes;
    data['dateOfInspection'] = dateOfInspection;
    data['followUpDate'] = followUpDate;
    data['costPerMile'] = costPerMile;
    data['totalCost'] = totalCost;
    data['nextMaintDue'] = nextMaintDue;
    data['budgetType'] = budgetType;
    data['planType'] = planType;
    return data;
  }
}
