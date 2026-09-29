class VegetationNormalizeModel {
  List<FindCompletedMile>? findCompletedMile;
  List<FindsFdrNameAndIdBySubstation>? findsFdrNameAndIdBySubstation;
  List<GetSPVMAVEGETATIONNORMALIZEDATADYNAMIC>?
      getSPVMAVEGETATIONNORMALIZEDATADYNAMIC;
  List<FindsSubstationAndId>? findsSubstationAndId;
  List<FindsDelayCauseBySubstationAndFdr>? findsDelayCauseBySubstationAndFdr;
  List<GetSPVMAVEGETATIONNORMALIZEDYNAMIC>? getSPVMAVEGETATIONNORMALIZEDYNAMIC;

  VegetationNormalizeModel(
      {this.findCompletedMile,
      this.findsFdrNameAndIdBySubstation,
      this.getSPVMAVEGETATIONNORMALIZEDATADYNAMIC,
      this.findsSubstationAndId,
      this.findsDelayCauseBySubstationAndFdr,
      this.getSPVMAVEGETATIONNORMALIZEDYNAMIC});

  VegetationNormalizeModel.fromJson(Map<String, dynamic> json) {
    if (json['findCompletedMile'] != null) {
      findCompletedMile = <FindCompletedMile>[];
      json['findCompletedMile'].forEach((v) {
        findCompletedMile!.add(FindCompletedMile.fromJson(v));
      });
    }
    if (json['findsFdrNameAndIdBySubstation'] != null) {
      findsFdrNameAndIdBySubstation = <FindsFdrNameAndIdBySubstation>[];
      json['findsFdrNameAndIdBySubstation'].forEach((v) {
        findsFdrNameAndIdBySubstation!
            .add(FindsFdrNameAndIdBySubstation.fromJson(v));
      });
    }
    if (json['getSP_VMA_VEGETATION_NORMALIZE_DATA_DYNAMIC'] != null) {
      getSPVMAVEGETATIONNORMALIZEDATADYNAMIC =
          <GetSPVMAVEGETATIONNORMALIZEDATADYNAMIC>[];
      json['getSP_VMA_VEGETATION_NORMALIZE_DATA_DYNAMIC'].forEach((v) {
        getSPVMAVEGETATIONNORMALIZEDATADYNAMIC!
            .add(GetSPVMAVEGETATIONNORMALIZEDATADYNAMIC.fromJson(v));
      });
    }
    if (json['findsSubstationAndId'] != null) {
      findsSubstationAndId = <FindsSubstationAndId>[];
      json['findsSubstationAndId'].forEach((v) {
        findsSubstationAndId!.add(FindsSubstationAndId.fromJson(v));
      });
    }
    if (json['findsDelayCauseBySubstationAndFdr'] != null) {
      findsDelayCauseBySubstationAndFdr = <FindsDelayCauseBySubstationAndFdr>[];
      json['findsDelayCauseBySubstationAndFdr'].forEach((v) {
        findsDelayCauseBySubstationAndFdr!
            .add(FindsDelayCauseBySubstationAndFdr.fromJson(v));
      });
    }
    if (json['getSP_VMA_VEGETATION_NORMALIZE_DYNAMIC'] != null) {
      getSPVMAVEGETATIONNORMALIZEDYNAMIC =
          <GetSPVMAVEGETATIONNORMALIZEDYNAMIC>[];
      json['getSP_VMA_VEGETATION_NORMALIZE_DYNAMIC'].forEach((v) {
        getSPVMAVEGETATIONNORMALIZEDYNAMIC!
            .add(GetSPVMAVEGETATIONNORMALIZEDYNAMIC.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (findCompletedMile != null) {
      data['findCompletedMile'] =
          findCompletedMile!.map((v) => v.toJson()).toList();
    }
    if (findsFdrNameAndIdBySubstation != null) {
      data['findsFdrNameAndIdBySubstation'] =
          findsFdrNameAndIdBySubstation!.map((v) => v.toJson()).toList();
    }
    if (getSPVMAVEGETATIONNORMALIZEDATADYNAMIC != null) {
      data['getSP_VMA_VEGETATION_NORMALIZE_DATA_DYNAMIC'] =
          getSPVMAVEGETATIONNORMALIZEDATADYNAMIC!
              .map((v) => v.toJson())
              .toList();
    }
    if (findsSubstationAndId != null) {
      data['findsSubstationAndId'] =
          findsSubstationAndId!.map((v) => v.toJson()).toList();
    }
    if (findsDelayCauseBySubstationAndFdr != null) {
      data['findsDelayCauseBySubstationAndFdr'] =
          findsDelayCauseBySubstationAndFdr!.map((v) => v.toJson()).toList();
    }
    if (getSPVMAVEGETATIONNORMALIZEDYNAMIC != null) {
      data['getSP_VMA_VEGETATION_NORMALIZE_DYNAMIC'] =
          getSPVMAVEGETATIONNORMALIZEDYNAMIC!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FindCompletedMile {
  double? completedMiles;

  FindCompletedMile({this.completedMiles});

  FindCompletedMile.fromJson(Map<String, dynamic> json) {
    completedMiles = json['completedMiles'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['completedMiles'] = completedMiles;
    return data;
  }
}

class FindsFdrNameAndIdBySubstation {
  String? fdrName;
  int? id;

  FindsFdrNameAndIdBySubstation({this.fdrName, this.id});

  FindsFdrNameAndIdBySubstation.fromJson(Map<String, dynamic> json) {
    fdrName = json['fdrName'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fdrName'] = fdrName;
    data['id'] = id;
    return data;
  }
}

class GetSPVMAVEGETATIONNORMALIZEDATADYNAMIC {
  double? sAIDI;
  String? sDate;
  int? sAIFI;
  double? cAIDI;

  GetSPVMAVEGETATIONNORMALIZEDATADYNAMIC(
      {this.sAIDI, this.sDate, this.sAIFI, this.cAIDI});

  GetSPVMAVEGETATIONNORMALIZEDATADYNAMIC.fromJson(Map<String, dynamic> json) {
    sAIDI = json['SAIDI'];
    sDate = json['sDate'];
    sAIFI = json['SAIFI'];
    cAIDI = json['CAIDI'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['SAIDI'] = sAIDI;
    data['sDate'] = sDate;
    data['SAIFI'] = sAIFI;
    data['CAIDI'] = cAIDI;
    return data;
  }
}

class FindsSubstationAndId {
  String? substation;
  int? id;

  FindsSubstationAndId({this.substation, this.id});

  FindsSubstationAndId.fromJson(Map<String, dynamic> json) {
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

class FindsDelayCauseBySubstationAndFdr {
  String? delayCause;

  FindsDelayCauseBySubstationAndFdr({this.delayCause});

  FindsDelayCauseBySubstationAndFdr.fromJson(Map<String, dynamic> json) {
    delayCause = json['delayCause'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['delayCause'] = delayCause;
    return data;
  }
}

class GetSPVMAVEGETATIONNORMALIZEDYNAMIC {
  String? budgetType;
  String? contractor;
  double? costPerMile;
  String? contractYear;
  double? milesCompleted;
  String? county;
  String? contractorName;
  String? nextMaintDue;
  int? tokenNo;
  String? fileUpload;
  String? type;
  String? performanceType;
  String? cycle;
  String? sAIFI;
  String? crew;
  String? adminNotes1;
  String? rowYear;
  String? fdrName;
  double? milesInProgress;
  String? street;
  String? maintType;
  String? substation;
  String? rowMethod;
  String? contractorNotes;
  int? id;
  String? delayReason;
  String? createDate;
  String? actualCost;
  String? contractorCompany;
  double? milesPending;
  String? delayCause;
  String? estCost;
  double? totalMiles;
  String? estTime;
  String? adminNotes2;
  String? sAIDI;
  double? effectedNoOfDays;
  double? wtdProgress;
  String? streetAddress;
  int? tblSubMilesCostId;
  double? mtdProgress;
  double? ytdProgress;
  double? cAIDI;
  double? totalCost;
  String? status;
  String? mapLocation;

  GetSPVMAVEGETATIONNORMALIZEDYNAMIC(
      {this.budgetType,
      this.contractor,
      this.costPerMile,
      this.contractYear,
      this.milesCompleted,
      this.contractorName,
      this.county,
      this.nextMaintDue,
      this.tokenNo,
      this.fileUpload,
      this.type,
      this.performanceType,
      this.cycle,
      this.sAIFI,
      this.crew,
      this.adminNotes1,
      this.rowYear,
      this.fdrName,
      this.milesInProgress,
      this.street,
      this.maintType,
      this.substation,
      this.rowMethod,
      this.contractorNotes,
      this.id,
      this.delayReason,
      this.createDate,
      this.actualCost,
      this.contractorCompany,
      this.milesPending,
      this.delayCause,
      this.estCost,
      this.totalMiles,
      this.estTime,
      this.adminNotes2,
      this.sAIDI,
      this.effectedNoOfDays,
      this.wtdProgress,
      this.streetAddress,
      this.tblSubMilesCostId,
      this.mtdProgress,
      this.ytdProgress,
      this.cAIDI,
      this.totalCost,
      this.status,
      this.mapLocation});

  GetSPVMAVEGETATIONNORMALIZEDYNAMIC.fromJson(Map<String, dynamic> json) {
    budgetType = json['budgetType'];
    contractor = json['contractor'];
    costPerMile = json['costPerMile'];
    contractYear = json['contractYear'];
    milesCompleted = json['milesCompleted'];
    contractorName = json['contractorName'];
    county = json['county'];
    nextMaintDue = json['nextMaintDue'];
    tokenNo = json['tokenNo'];
    fileUpload = json['fileUpload'];
    type = json['type'];
    performanceType = json['performanceType'];
    cycle = json['cycle'];
    sAIFI = json['SAIFI'];
    crew = json['crew'];
    adminNotes1 = json['adminNotes1'];
    rowYear = json['rowYear'];
    fdrName = json['fdrName'];
    milesInProgress = json['milesInProgress'];
    street = json['street'];
    maintType = json['maintType'];
    substation = json['substation'];
    rowMethod = json['rowMethod'];
    contractorNotes = json['contractorNotes'];
    id = json['id'];
    delayReason = json['delayReason'];
    createDate = json['createDate'];
    actualCost = json['actualCost'];
    contractorCompany = json['contractorCompany'];
    milesPending = json['milesPending'];
    delayCause = json['delayCause'];
    estCost = json['estCost'];
    totalMiles = json['totalMiles'];
    estTime = json['estTime'];
    adminNotes2 = json['adminNotes2'];
    sAIDI = json['SAIDI'];
    effectedNoOfDays = json['effectedNoOfDays'];
    wtdProgress = json['wtdProgress'];
    streetAddress = json['streetAddress'];
    tblSubMilesCostId = json['tblSubMilesCostId'];
    mtdProgress = json['mtdProgress'];
    ytdProgress = json['ytdProgress'];
    cAIDI = json['CAIDI'];
    totalCost = json['totalCost'];
    status = json['status'];
    mapLocation = json['mapLocation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['budgetType'] = budgetType;
    data['contractor'] = contractor;
    data['costPerMile'] = costPerMile;
    data['contractYear'] = contractYear;
    data['milesCompleted'] = milesCompleted;
    data['contractorName'] = contractorName;
    data['county'] = county;
    data['nextMaintDue'] = nextMaintDue;
    data['tokenNo'] = tokenNo;
    data['fileUpload'] = fileUpload;
    data['type'] = type;
    data['performanceType'] = performanceType;
    data['cycle'] = cycle;
    data['SAIFI'] = sAIFI;
    data['crew'] = crew;
    data['adminNotes1'] = adminNotes1;
    data['rowYear'] = rowYear;
    data['fdrName'] = fdrName;
    data['milesInProgress'] = milesInProgress;
    data['street'] = street;
    data['maintType'] = maintType;
    data['substation'] = substation;
    data['rowMethod'] = rowMethod;
    data['contractorNotes'] = contractorNotes;
    data['id'] = id;
    data['delayReason'] = delayReason;
    data['createDate'] = createDate;
    data['actualCost'] = actualCost;
    data['contractorCompany'] = contractorCompany;
    data['milesPending'] = milesPending;
    data['delayCause'] = delayCause;
    data['estCost'] = estCost;
    data['totalMiles'] = totalMiles;
    data['estTime'] = estTime;
    data['adminNotes2'] = adminNotes2;
    data['SAIDI'] = sAIDI;
    data['effectedNoOfDays'] = effectedNoOfDays;
    data['wtdProgress'] = wtdProgress;
    data['streetAddress'] = streetAddress;
    data['tblSubMilesCostId'] = tblSubMilesCostId;
    data['mtdProgress'] = mtdProgress;
    data['ytdProgress'] = ytdProgress;
    data['CAIDI'] = cAIDI;
    data['totalCost'] = totalCost;
    data['status'] = status;
    data['mapLocation'] = mapLocation;
    return data;
  }
}
