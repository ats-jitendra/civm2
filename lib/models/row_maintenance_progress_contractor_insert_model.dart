class RowMaintenanceProgressContractorInsertModel {
  int? id;
  int? tblSubMilesCostId;
  String? subStateName;
  String? feeder;
  String? street;
  String? crew;
  double? totalMiles;
  double? milesCompleted;
  double? milesInProgress;
  double? milesPending;
  String? performanceType;
  double? wtdProgress;
  double? mtdProgress;
  double? ytdProgress;
  String? rowMethod;
  String? delayCause;
  String? delayReason;
  double? effectedNoOfDays;
  String? fileUpload;
  String? createDate;
  String? status;

  RowMaintenanceProgressContractorInsertModel(
      {this.id,
      this.tblSubMilesCostId,
      this.subStateName,
      this.feeder,
      this.street,
      this.crew,
      this.totalMiles,
      this.milesCompleted,
      this.milesInProgress,
      this.milesPending,
      this.performanceType,
      this.wtdProgress,
      this.mtdProgress,
      this.ytdProgress,
      this.rowMethod,
      this.delayCause,
      this.delayReason,
      this.effectedNoOfDays,
      this.fileUpload,
      this.createDate,
      this.status});

  RowMaintenanceProgressContractorInsertModel.fromJson(
      Map<String, dynamic> json) {
    id = json['id'];
    tblSubMilesCostId = json['tblSubMilesCostId'];
    subStateName = json['subStateName'];
    feeder = json['feeder'];
    street = json['street'];
    crew = json['crew'];
    totalMiles = json['totalMiles'];
    milesCompleted = json['milesCompleted'];
    milesInProgress = json['milesInProgress'];
    milesPending = json['milesPending'];
    performanceType = json['performanceType'];
    wtdProgress = json['wtdProgress'];
    mtdProgress = json['mtdProgress'];
    ytdProgress = json['ytdProgress'];
    rowMethod = json['rowMethod'];
    delayCause = json['delayCause'];
    delayReason = json['delayReason'];
    effectedNoOfDays = json['effectedNoOfDays'];
    fileUpload = json['fileUpload'];
    createDate = json['createDate'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['tblSubMilesCostId'] = tblSubMilesCostId;
    data['subStateName'] = subStateName;
    data['feeder'] = feeder;
    data['street'] = street;
    data['crew'] = crew;
    data['totalMiles'] = totalMiles;
    data['milesCompleted'] = milesCompleted;
    data['milesInProgress'] = milesInProgress;
    data['milesPending'] = milesPending;
    data['performanceType'] = performanceType;
    data['wtdProgress'] = wtdProgress;
    data['mtdProgress'] = mtdProgress;
    data['ytdProgress'] = ytdProgress;
    data['rowMethod'] = rowMethod;
    data['delayCause'] = delayCause;
    data['delayReason'] = delayReason;
    data['effectedNoOfDays'] = effectedNoOfDays;
    data['fileUpload'] = fileUpload;
    data['createDate'] = createDate;
    data['status'] = status;
    return data;
  }
}
