class TransmissionIvmRejectedModel {
  List<TransIVMRejectedFindAllTableData>? findAllTableData;

  TransmissionIvmRejectedModel({this.findAllTableData});

  TransmissionIvmRejectedModel.fromJson(Map<String, dynamic> json) {
    if (json['findAllTableData'] != null) {
      findAllTableData = <TransIVMRejectedFindAllTableData>[];
      json['findAllTableData'].forEach((v) {
        findAllTableData!.add(new TransIVMRejectedFindAllTableData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.findAllTableData != null) {
      data['findAllTableData'] =
          this.findAllTableData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TransIVMRejectedFindAllTableData {
  int? tokenNo;
  String? type;
  String? status;
  String? transmissionName;
  String? substation;
  String? fdrName;
  String? contractor;
  String? totalMiles;
  String? milesPending;
  String? milesCompleted;
  String? streetAddress;
  String? mapLocation;
  String? supervisorNotes;
  String? contractorCompany;
  String? dateOfInspection;
  String? followUpDate;
  String? createDate;
  String? subId;
  String? fdrId;
  String? createdBy;

  TransIVMRejectedFindAllTableData({
    this.tokenNo,
    this.type,
    this.status,
    this.transmissionName,
    this.substation,
    this.fdrName,
    this.contractor,
    this.totalMiles,
    this.milesPending,
    this.milesCompleted,
    this.streetAddress,
    this.mapLocation,
    this.supervisorNotes,
    this.contractorCompany,
    this.dateOfInspection,
    this.followUpDate,
    this.createDate,
    this.subId,
    this.fdrId,
    this.createdBy
  });

  TransIVMRejectedFindAllTableData.fromJson(Map<String, dynamic> json) {
    tokenNo = json['tokenNo'] ?? 0;
    type = json['type'] ?? '';
    status = json['status'] ?? '';
    transmissionName = json['transmission_name'] ?? '';
    substation = json['substation'] ?? '';
    fdrName = json['fdrName'] ?? '';
    contractor = json['contractor'] ?? '';
    totalMiles = json['totalMiles'] ?? '';
    milesPending = json['milesPending'] ?? '';
    milesCompleted = json['milesCompleted'] ?? '';
    streetAddress = json['streetAddress'] ?? '';
    mapLocation = json['mapLocation'] ?? '';
    supervisorNotes = json['supervisorNotes'] ?? '';
    contractorCompany = json['contractorCompany'] ?? '';
    dateOfInspection = json['dateOfInspection'] ?? '';
    followUpDate = json['followUpDate'] ?? '';
    createDate = json['createDate'] ?? '';
    subId = json['subId'] ?? '';
    fdrId = json['fdrId'] ?? '';
     createdBy = json['createdBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tokenNo'] = this.tokenNo;
    data['type'] = this.type;
    data['status'] = this.status;
    data['transmission_name'] = this.transmissionName;
    data['substation'] = this.substation;
    data['fdrName'] = this.fdrName;
    data['contractor'] = this.contractor;
    data['totalMiles'] = this.totalMiles;
    data['milesPending'] = this.milesPending;
    data['milesCompleted'] = this.milesCompleted;
    data['streetAddress'] = this.streetAddress;
    data['mapLocation'] = this.mapLocation;
    data['supervisorNotes'] = this.supervisorNotes;
    data['contractorCompany'] = this.contractorCompany;
    data['dateOfInspection'] = this.dateOfInspection;
    data['followUpDate'] = this.followUpDate;
    data['createDate'] = this.createDate;
    data['subId'] = subId;
    data['fdrId'] = fdrId;
    data['createdBy'] = createdBy;
    return data;
  }
}
