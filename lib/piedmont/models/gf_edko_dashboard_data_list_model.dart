class GfEdkoDashboardDataListModel {
  List<GfEdkoDashboardDatadata>? gettabledata;

  GfEdkoDashboardDataListModel({this.gettabledata});

  GfEdkoDashboardDataListModel.fromJson(Map<String, dynamic> json) {
    if (json['gettabledata'] != null) {
      gettabledata = <GfEdkoDashboardDatadata>[];
      json['gettabledata'].forEach((v) {
        gettabledata!.add(new GfEdkoDashboardDatadata.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.gettabledata != null) {
      data['gettabledata'] = this.gettabledata!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GfEdkoDashboardDatadata {
  String? type;
  String? jobno;
  String? annualHerbicide;
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
  String? budgetType;
  String? planType;

  GfEdkoDashboardDatadata(
      {this.type,
      this.jobno,
      this.annualHerbicide,
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
      this.budgetType,
      this.planType});

  GfEdkoDashboardDatadata.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    jobno = json['jobno'];
    annualHerbicide = json['annualHerbicide'];
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
    budgetType = json['budgetType'];
    planType = json['planType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['jobno'] = this.jobno;
    data['annualHerbicide'] = this.annualHerbicide;
    data['status'] = this.status;
    data['substation'] = this.substation;
    data['feeder'] = this.feeder;
    data['maintenanceType'] = this.maintenanceType;
    data['contractor'] = this.contractor;
    data['totalMiles'] = this.totalMiles;
    data['contractYear'] = this.contractYear;
    data['cycle'] = this.cycle;
    data['serviceStreetAddress'] = this.serviceStreetAddress;
    data['serviceMapLocation'] = this.serviceMapLocation;
    data['generalForemanNotes1'] = this.generalForemanNotes1;
    data['generalForemanNotes2'] = this.generalForemanNotes2;
    data['adminNotes'] = this.adminNotes;
    data['contractorCompany'] = this.contractorCompany;
    data['dateOfInspection'] = this.dateOfInspection;
    data['followUpDate'] = this.followUpDate;
    data['nextMaintDue'] = this.nextMaintDue;
    data['createDate'] = this.createDate;
    data['budgetType'] = this.budgetType;
    data['planType'] = this.planType;
    return data;
  }
}
