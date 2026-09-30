class GfAlexDashboardDataListModel {
  List<GfAlexDashboardDatadata>? gettabledata;

  GfAlexDashboardDataListModel({this.gettabledata});

  GfAlexDashboardDataListModel.fromJson(Map<String, dynamic> json) {
    if (json['gettabledata'] != null) {
      gettabledata = <GfAlexDashboardDatadata>[];
      json['gettabledata'].forEach((v) {
        gettabledata!.add(new GfAlexDashboardDatadata.fromJson(v));
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

class GfAlexDashboardDatadata {
  String? type;
  String? jobno;
  String? status;
  String? substation;
  String? feeder;
  String? maintenanceType;
  String? contractor;
  String? totalMiles;
  String? contractYear;
  String? cycle;
  String? serviceStreetAddress;
  String? serviceMapLocation;
  String? generalForemanNotes1;
  String? generalForemanNotes2;
  String? adminNotes;
  String? contractorCompany;
  String? dateOfInspection;
  String? followUpDate;
  String? nextMaintDue;
  String? createDate;
  String? estTime;
  String? budgetType;

  GfAlexDashboardDatadata(
      {this.type,
      this.jobno,
      this.status,
      this.substation,
      this.feeder,
      this.maintenanceType,
      this.contractor,
      this.totalMiles,
      this.contractYear,
      this.cycle,
      this.serviceStreetAddress,
      this.serviceMapLocation,
      this.generalForemanNotes1,
      this.generalForemanNotes2,
      this.adminNotes,
      this.contractorCompany,
      this.dateOfInspection,
      this.followUpDate,
      this.nextMaintDue,
      this.createDate,
      this.estTime,
      this.budgetType});

  GfAlexDashboardDatadata.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    jobno = json['jobno'];
    status = json['status'];
    substation = json['substation'];
    feeder = json['feeder'];
    maintenanceType = json['maintenanceType'];
    contractor = json['contractor'];
    totalMiles = json['totalMiles'];
    contractYear = json['contractYear'];
    cycle = json['cycle'];
    serviceStreetAddress = json['serviceStreetAddress'];
    serviceMapLocation = json['serviceMapLocation'];
    generalForemanNotes1 = json['generalForemanNotes1'];
    generalForemanNotes2 = json['generalForemanNotes2'];
    adminNotes = json['adminNotes'];
    contractorCompany = json['contractorCompany'];
    dateOfInspection = json['dateOfInspection'];
    followUpDate = json['followUpDate'];
    nextMaintDue = json['nextMaintDue'];
    createDate = json['createDate'];
    estTime = json['estTime'];
    budgetType = json['budgetType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = type;
    data['jobno'] = jobno;
    data['status'] = status;
    data['substation'] = substation;
    data['feeder'] = feeder;
    data['maintenanceType'] = maintenanceType;
    data['contractor'] = contractor;
    data['totalMiles'] = totalMiles;
    data['contractYear'] = contractYear;
    data['cycle'] = cycle;
    data['serviceStreetAddress'] = serviceStreetAddress;
    data['serviceMapLocation'] = serviceMapLocation;
    data['generalForemanNotes1'] = generalForemanNotes1;
    data['generalForemanNotes2'] = generalForemanNotes2;
    data['adminNotes'] = adminNotes;
    data['contractorCompany'] = contractorCompany;
    data['dateOfInspection'] = dateOfInspection;
    data['followUpDate'] = followUpDate;
    data['nextMaintDue'] = nextMaintDue;
    data['createDate'] = createDate;
    data['estTime'] = estTime;
    data['budgetType'] = budgetType;
    return data;
  }
}
