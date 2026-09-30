class RowMaintenanceProgressNewModel {
  List<GetSPROWMAINTTBLFLTRList>? getSPROWMAINTTBLFLTRList;
  List<GetAllSubstations>? getAllSubstations;
  List<GetCycleBySubstationAndFdr>? getCycleBySubstationAndFdr;
  List<FindSumOfTotalMileBySubstationAndFeederAndCycle>?
      findSumOfTotalMileBySubstationAndFeederAndCycle;
  List<GetYearBySubstationFdrCycleMonth>? getYearBySubstationFdrCycleMonth;
  List<GetMonthBySubstationFdrCycle>? getMonthBySubstationFdrCycle;
  List<FindAllSumOfTotalMiles>? findAllSumOfTotalMiles;
  List<GetSPSMMAINTTOTALCOSTBYTYPEFTRList>? getSPSMMAINTTOTALCOSTBYTYPEFTRList;
  List<FindSumOfTotalMilesBySubstationAndFeederCycleMonthYear>?
      findSumOfTotalMilesBySubstationAndFeederCycleMonthYear;
  List<FindSumOfTotalMilesBySubstationAndFeederCycleMonthList>?
      findSumOfTotalMilesBySubstationAndFeederCycleMonthList;
  List<GetSPSMMAINTTOTALMILESBYTYPEFTRLIST>?
      getSPSMMAINTTOTALMILESBYTYPEFTRLIST;
  List<double>? getSumOfTotalMilesBysubstation;
  List<GetSPMAINTENANCEANALYSISPROGRESS>? getSPMAINTENANCEANALYSISPROGRESS;
  List<FindSumOfTotalMileBySubstationAndFeeder>?
      findSumOfTotalMileBySubstationAndFeeder;
  List<GetSPROWMAINTSUBSTIONFDRFLTRList>? getSPROWMAINTSUBSTIONFDRFLTRList;

  RowMaintenanceProgressNewModel(
      {this.getSPROWMAINTTBLFLTRList,
      this.getAllSubstations,
      this.getCycleBySubstationAndFdr,
      this.findSumOfTotalMileBySubstationAndFeederAndCycle,
      this.getYearBySubstationFdrCycleMonth,
      this.getMonthBySubstationFdrCycle,
      this.findAllSumOfTotalMiles,
      this.getSPSMMAINTTOTALCOSTBYTYPEFTRList,
      this.findSumOfTotalMilesBySubstationAndFeederCycleMonthYear,
      this.findSumOfTotalMilesBySubstationAndFeederCycleMonthList,
      this.getSPSMMAINTTOTALMILESBYTYPEFTRLIST,
      this.getSumOfTotalMilesBysubstation,
      this.getSPMAINTENANCEANALYSISPROGRESS,
      this.findSumOfTotalMileBySubstationAndFeeder,
      this.getSPROWMAINTSUBSTIONFDRFLTRList});

  RowMaintenanceProgressNewModel.fromJson(Map<String, dynamic> json) {
    if (json['getSP_ROW_MAINT_TBL_FLTRList'] != null) {
      getSPROWMAINTTBLFLTRList = <GetSPROWMAINTTBLFLTRList>[];
      json['getSP_ROW_MAINT_TBL_FLTRList'].forEach((v) {
        getSPROWMAINTTBLFLTRList!.add(GetSPROWMAINTTBLFLTRList.fromJson(v));
      });
    }
    if (json['getAllSubstations'] != null) {
      getAllSubstations = <GetAllSubstations>[];
      json['getAllSubstations'].forEach((v) {
        getAllSubstations!.add(GetAllSubstations.fromJson(v));
      });
    }
    if (json['getCycleBySubstationAndFdr'] != null) {
      getCycleBySubstationAndFdr = <GetCycleBySubstationAndFdr>[];
      json['getCycleBySubstationAndFdr'].forEach((v) {
        getCycleBySubstationAndFdr!.add(GetCycleBySubstationAndFdr.fromJson(v));
      });
    }
    if (json['findSumOfTotalMileBySubstationAndFeederAndCycle'] != null) {
      findSumOfTotalMileBySubstationAndFeederAndCycle =
          <FindSumOfTotalMileBySubstationAndFeederAndCycle>[];
      json['findSumOfTotalMileBySubstationAndFeederAndCycle'].forEach((v) {
        findSumOfTotalMileBySubstationAndFeederAndCycle!
            .add(FindSumOfTotalMileBySubstationAndFeederAndCycle.fromJson(v));
      });
    }
    if (json['getYearBySubstationFdrCycleMonth'] != null) {
      getYearBySubstationFdrCycleMonth = <GetYearBySubstationFdrCycleMonth>[];
      json['getYearBySubstationFdrCycleMonth'].forEach((v) {
        getYearBySubstationFdrCycleMonth!
            .add(GetYearBySubstationFdrCycleMonth.fromJson(v));
      });
    }
    if (json['getMonthBySubstationFdrCycle'] != null) {
      getMonthBySubstationFdrCycle = <GetMonthBySubstationFdrCycle>[];
      json['getMonthBySubstationFdrCycle'].forEach((v) {
        getMonthBySubstationFdrCycle!
            .add(GetMonthBySubstationFdrCycle.fromJson(v));
      });
    }
    if (json['findAllSumOfTotalMiles'] != null) {
      findAllSumOfTotalMiles = <FindAllSumOfTotalMiles>[];
      json['findAllSumOfTotalMiles'].forEach((v) {
        findAllSumOfTotalMiles!.add(FindAllSumOfTotalMiles.fromJson(v));
      });
    }
    if (json['getSP_SM_MAINT_TOTAL_COST_BY_TYPE_FTRList'] != null) {
      getSPSMMAINTTOTALCOSTBYTYPEFTRList =
          <GetSPSMMAINTTOTALCOSTBYTYPEFTRList>[];
      json['getSP_SM_MAINT_TOTAL_COST_BY_TYPE_FTRList'].forEach((v) {
        getSPSMMAINTTOTALCOSTBYTYPEFTRList!
            .add(GetSPSMMAINTTOTALCOSTBYTYPEFTRList.fromJson(v));
      });
    }
    if (json['findSumOfTotalMilesBySubstationAndFeederCycleMonthYear'] !=
        null) {
      findSumOfTotalMilesBySubstationAndFeederCycleMonthYear =
          <FindSumOfTotalMilesBySubstationAndFeederCycleMonthYear>[];
      json['findSumOfTotalMilesBySubstationAndFeederCycleMonthYear']
          .forEach((v) {
        findSumOfTotalMilesBySubstationAndFeederCycleMonthYear!.add(
            FindSumOfTotalMilesBySubstationAndFeederCycleMonthYear.fromJson(v));
      });
    }
    if (json['findSumOfTotalMilesBySubstationAndFeederCycleMonthList'] !=
        null) {
      findSumOfTotalMilesBySubstationAndFeederCycleMonthList =
          <FindSumOfTotalMilesBySubstationAndFeederCycleMonthList>[];
      json['findSumOfTotalMilesBySubstationAndFeederCycleMonthList']
          .forEach((v) {
        findSumOfTotalMilesBySubstationAndFeederCycleMonthList!.add(
            FindSumOfTotalMilesBySubstationAndFeederCycleMonthList.fromJson(v));
      });
    }
    if (json['getSP_SM_MAINTTOTAL_MILES_BYTYPE_FTRLIST'] != null) {
      getSPSMMAINTTOTALMILESBYTYPEFTRLIST =
          <GetSPSMMAINTTOTALMILESBYTYPEFTRLIST>[];
      json['getSP_SM_MAINTTOTAL_MILES_BYTYPE_FTRLIST'].forEach((v) {
        getSPSMMAINTTOTALMILESBYTYPEFTRLIST!
            .add(GetSPSMMAINTTOTALMILESBYTYPEFTRLIST.fromJson(v));
      });
    }
    getSumOfTotalMilesBysubstation =
        json['getSumOfTotalMilesBysubstation'].cast<double>();
    if (json['getSP_MAINTENANCE_ANALYSIS_PROGRESS'] != null) {
      getSPMAINTENANCEANALYSISPROGRESS = <GetSPMAINTENANCEANALYSISPROGRESS>[];
      json['getSP_MAINTENANCE_ANALYSIS_PROGRESS'].forEach((v) {
        getSPMAINTENANCEANALYSISPROGRESS!
            .add(GetSPMAINTENANCEANALYSISPROGRESS.fromJson(v));
      });
    }
    if (json['findSumOfTotalMileBySubstationAndFeeder'] != null) {
      findSumOfTotalMileBySubstationAndFeeder =
          <FindSumOfTotalMileBySubstationAndFeeder>[];
      json['findSumOfTotalMileBySubstationAndFeeder'].forEach((v) {
        findSumOfTotalMileBySubstationAndFeeder!
            .add(FindSumOfTotalMileBySubstationAndFeeder.fromJson(v));
      });
    }
    if (json['getSP_ROW_MAINT_SUBSTION_FDR_FLTRList'] != null) {
      getSPROWMAINTSUBSTIONFDRFLTRList = <GetSPROWMAINTSUBSTIONFDRFLTRList>[];
      json['getSP_ROW_MAINT_SUBSTION_FDR_FLTRList'].forEach((v) {
        getSPROWMAINTSUBSTIONFDRFLTRList!
            .add(GetSPROWMAINTSUBSTIONFDRFLTRList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (getSPROWMAINTTBLFLTRList != null) {
      data['getSP_ROW_MAINT_TBL_FLTRList'] =
          getSPROWMAINTTBLFLTRList!.map((v) => v.toJson()).toList();
    }
    if (getAllSubstations != null) {
      data['getAllSubstations'] =
          getAllSubstations!.map((v) => v.toJson()).toList();
    }
    if (getCycleBySubstationAndFdr != null) {
      data['getCycleBySubstationAndFdr'] =
          getCycleBySubstationAndFdr!.map((v) => v.toJson()).toList();
    }
    if (findSumOfTotalMileBySubstationAndFeederAndCycle != null) {
      data['findSumOfTotalMileBySubstationAndFeederAndCycle'] =
          findSumOfTotalMileBySubstationAndFeederAndCycle!
              .map((v) => v.toJson())
              .toList();
    }
    if (getYearBySubstationFdrCycleMonth != null) {
      data['getYearBySubstationFdrCycleMonth'] =
          getYearBySubstationFdrCycleMonth!.map((v) => v.toJson()).toList();
    }
    if (getMonthBySubstationFdrCycle != null) {
      data['getMonthBySubstationFdrCycle'] =
          getMonthBySubstationFdrCycle!.map((v) => v.toJson()).toList();
    }
    if (findAllSumOfTotalMiles != null) {
      data['findAllSumOfTotalMiles'] =
          findAllSumOfTotalMiles!.map((v) => v.toJson()).toList();
    }
    if (getSPSMMAINTTOTALCOSTBYTYPEFTRList != null) {
      data['getSP_SM_MAINT_TOTAL_COST_BY_TYPE_FTRList'] =
          getSPSMMAINTTOTALCOSTBYTYPEFTRList!.map((v) => v.toJson()).toList();
    }
    if (findSumOfTotalMilesBySubstationAndFeederCycleMonthYear != null) {
      data['findSumOfTotalMilesBySubstationAndFeederCycleMonthYear'] =
          findSumOfTotalMilesBySubstationAndFeederCycleMonthYear!
              .map((v) => v.toJson())
              .toList();
    }
    if (findSumOfTotalMilesBySubstationAndFeederCycleMonthList != null) {
      data['findSumOfTotalMilesBySubstationAndFeederCycleMonthList'] =
          findSumOfTotalMilesBySubstationAndFeederCycleMonthList!
              .map((v) => v.toJson())
              .toList();
    }
    if (getSPSMMAINTTOTALMILESBYTYPEFTRLIST != null) {
      data['getSP_SM_MAINTTOTAL_MILES_BYTYPE_FTRLIST'] =
          getSPSMMAINTTOTALMILESBYTYPEFTRLIST!.map((v) => v.toJson()).toList();
    }
    data['getSumOfTotalMilesBysubstation'] = getSumOfTotalMilesBysubstation;
    if (getSPMAINTENANCEANALYSISPROGRESS != null) {
      data['getSP_MAINTENANCE_ANALYSIS_PROGRESS'] =
          getSPMAINTENANCEANALYSISPROGRESS!.map((v) => v.toJson()).toList();
    }
    if (findSumOfTotalMileBySubstationAndFeeder != null) {
      data['findSumOfTotalMileBySubstationAndFeeder'] =
          findSumOfTotalMileBySubstationAndFeeder!
              .map((v) => v.toJson())
              .toList();
    }
    if (getSPROWMAINTSUBSTIONFDRFLTRList != null) {
      data['getSP_ROW_MAINT_SUBSTION_FDR_FLTRList'] =
          getSPROWMAINTSUBSTIONFDRFLTRList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetSPROWMAINTSUBSTIONFDRFLTRList {
  String? fdrName;

  GetSPROWMAINTSUBSTIONFDRFLTRList({this.fdrName});

  GetSPROWMAINTSUBSTIONFDRFLTRList.fromJson(Map<String, dynamic> json) {
    fdrName = json['fdrName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fdrName'] = fdrName;
    return data;
  }
}

class FindSumOfTotalMileBySubstationAndFeeder {
  double? totalMiles;

  FindSumOfTotalMileBySubstationAndFeeder({this.totalMiles});

  FindSumOfTotalMileBySubstationAndFeeder.fromJson(Map<String, dynamic> json) {
    totalMiles = json['totalMiles'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalMiles'] = totalMiles;
    return data;
  }
}

class FindSumOfTotalMilesBySubstationAndFeederCycleMonthList {
  double? totalMiles;

  FindSumOfTotalMilesBySubstationAndFeederCycleMonthList({this.totalMiles});

  FindSumOfTotalMilesBySubstationAndFeederCycleMonthList.fromJson(
      Map<String, dynamic> json) {
    totalMiles = json['totalMiles'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalMiles'] = totalMiles;
    return data;
  }
}

class FindSumOfTotalMilesBySubstationAndFeederCycleMonthYear {
  double? totalMiles;

  FindSumOfTotalMilesBySubstationAndFeederCycleMonthYear({this.totalMiles});

  FindSumOfTotalMilesBySubstationAndFeederCycleMonthYear.fromJson(
      Map<String, dynamic> json) {
    totalMiles = json['totalMiles'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalMiles'] = totalMiles;
    return data;
  }
}

class GetMonthBySubstationFdrCycle {
  String? month;

  GetMonthBySubstationFdrCycle({this.month});

  GetMonthBySubstationFdrCycle.fromJson(Map<String, dynamic> json) {
    month = json['month'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['month'] = month;
    return data;
  }
}

class GetYearBySubstationFdrCycleMonth {
  String? year;

  GetYearBySubstationFdrCycleMonth({this.year});

  GetYearBySubstationFdrCycleMonth.fromJson(Map<String, dynamic> json) {
    year = json['year'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['year'] = year;
    return data;
  }
}

class GetCycleBySubstationAndFdr {
  String? cycle;

  GetCycleBySubstationAndFdr({this.cycle});

  GetCycleBySubstationAndFdr.fromJson(Map<String, dynamic> json) {
    cycle = json['cycle'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cycle'] = cycle;
    return data;
  }
}

class GetSPROWMAINTTBLFLTRList {
  String? contractYear;
  String? dateOfInspection;
  String? county;
  String? approvedBy;
  String? actionNeeded;
  String? type;
  String? adminNotes1;
  String? growthScore;
  String? rowYear;
  String? documentUpload;
  String? substationName;
  String? dueMonth;
  String? milesInProgress;
  String? maintType;
  String? contractorNotes;
  int? id;
  String? budget;
  String? lastMaintDone;
  String? milesPending;
  String? maintCount;
  String? monthName;
  String? contractEndYear;
  String? followUpDate;
  String? district;
  String? tblVmaNewRowMaintanacePlanId;
  String? changeOrderImage;
  String? workPriority;
  String? totalCost;
  String? status;
  String? invoiceCreated;
  String? supervisorName;
  String? budgetType;
  String? milesCompleted;
  String? dueWeek;
  String? growthRate;
  String? costPerMiles;
  String? contractorName;
  int? tokenNo;
  String? nextMaintDue;
  String? cycle;
  String? maintDateHistory;
  String? crew;
  String? fdrName;
  String? street;
  String? yearName;
  String? createDate;
  String? contractorCompny;
  String? actualCost;
  String? planType;
  String? estCost;
  String? treeType;
  String? totalMiles;
  String? estTime;
  String? adminNotes2;
  String? createdBy;
  String? streetAddress;
  String? mapLocation;

  GetSPROWMAINTTBLFLTRList(
      {this.contractYear,
      this.dateOfInspection,
      this.county,
      this.approvedBy,
      this.actionNeeded,
      this.type,
      this.adminNotes1,
      this.growthScore,
      this.rowYear,
      this.documentUpload,
      this.substationName,
      this.dueMonth,
      this.milesInProgress,
      this.maintType,
      this.contractorNotes,
      this.id,
      this.budget,
      this.lastMaintDone,
      this.milesPending,
      this.maintCount,
      this.monthName,
      this.contractEndYear,
      this.followUpDate,
      this.district,
      this.tblVmaNewRowMaintanacePlanId,
      this.changeOrderImage,
      this.workPriority,
      this.totalCost,
      this.status,
      this.invoiceCreated,
      this.supervisorName,
      this.budgetType,
      this.milesCompleted,
      this.dueWeek,
      this.growthRate,
      this.costPerMiles,
      this.contractorName,
      this.tokenNo,
      this.nextMaintDue,
      this.cycle,
      this.maintDateHistory,
      this.crew,
      this.fdrName,
      this.street,
      this.yearName,
      this.createDate,
      this.contractorCompny,
      this.actualCost,
      this.planType,
      this.estCost,
      this.treeType,
      this.totalMiles,
      this.estTime,
      this.adminNotes2,
      this.createdBy,
      this.streetAddress,
      this.mapLocation});

  GetSPROWMAINTTBLFLTRList.fromJson(Map<String, dynamic> json) {
    contractYear = json['contractYear'];
    dateOfInspection = json['dateOfInspection'];
    county = json['county'];
    approvedBy = json['approvedBy'];
    actionNeeded = json['actionNeeded'];
    type = json['type'];
    adminNotes1 = json['adminNotes1'];
    growthScore = json['growthScore'];
    rowYear = json['rowYear'];
    documentUpload = json['documentUpload'];
    substationName = json['substationName'];
    dueMonth = json['dueMonth'];
    milesInProgress = json['milesInProgress'];
    maintType = json['maintType'];
    contractorNotes = json['contractorNotes'];
    id = json['id'];
    budget = json['budget'];
    lastMaintDone = json['lastMaintDone'];
    milesPending = json['milesPending'];
    maintCount = json['maintCount'];
    monthName = json['monthName'];
    contractEndYear = json['contractEndYear'];
    followUpDate = json['followUpDate'];
    district = json['district'];
    tblVmaNewRowMaintanacePlanId = json['tblVmaNewRowMaintanacePlanId'];
    changeOrderImage = json['changeOrderImage'];
    workPriority = json['workPriority'];
    totalCost = json['totalCost'];
    status = json['status'];
    invoiceCreated = json['invoiceCreated'];
    supervisorName = json['supervisorName'];
    budgetType = json['budgetType'];
    milesCompleted = json['milesCompleted'];
    dueWeek = json['dueWeek'];
    growthRate = json['growthRate'];
    costPerMiles = json['costPerMiles'];
    contractorName = json['contractorName'];
    tokenNo = json['tokenNo'];
    nextMaintDue = json['nextMaintDue'];
    cycle = json['cycle'];
    maintDateHistory = json['maintDateHistory'];
    crew = json['crew'];
    fdrName = json['fdrName'];
    street = json['street'];
    yearName = json['yearName'];
    createDate = json['createDate'];
    contractorCompny = json['contractorCompny'];
    actualCost = json['actualCost'];
    planType = json['planType'];
    estCost = json['estCost'];
    treeType = json['treeType'];
    totalMiles = json['totalMiles'];
    estTime = json['estTime'];
    adminNotes2 = json['adminNotes2'];
    createdBy = json['createdBy'];
    streetAddress = json['streetAddress'];
    mapLocation = json['mapLocation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['contractYear'] = contractYear;
    data['dateOfInspection'] = dateOfInspection;
    data['county'] = county;
    data['approvedBy'] = approvedBy;
    data['actionNeeded'] = actionNeeded;
    data['type'] = type;
    data['adminNotes1'] = adminNotes1;
    data['growthScore'] = growthScore;
    data['rowYear'] = rowYear;
    data['documentUpload'] = documentUpload;
    data['substationName'] = substationName;
    data['dueMonth'] = dueMonth;
    data['milesInProgress'] = milesInProgress;
    data['maintType'] = maintType;
    data['contractorNotes'] = contractorNotes;
    data['id'] = id;
    data['budget'] = budget;
    data['lastMaintDone'] = lastMaintDone;
    data['milesPending'] = milesPending;
    data['maintCount'] = maintCount;
    data['monthName'] = monthName;
    data['contractEndYear'] = contractEndYear;
    data['followUpDate'] = followUpDate;
    data['district'] = district;
    data['tblVmaNewRowMaintanacePlanId'] = tblVmaNewRowMaintanacePlanId;
    data['changeOrderImage'] = changeOrderImage;
    data['workPriority'] = workPriority;
    data['totalCost'] = totalCost;
    data['status'] = status;
    data['invoiceCreated'] = invoiceCreated;
    data['supervisorName'] = supervisorName;
    data['budgetType'] = budgetType;
    data['milesCompleted'] = milesCompleted;
    data['dueWeek'] = dueWeek;
    data['growthRate'] = growthRate;
    data['costPerMiles'] = costPerMiles;
    data['contractorName'] = contractorName;
    data['tokenNo'] = tokenNo;
    data['nextMaintDue'] = nextMaintDue;
    data['cycle'] = cycle;
    data['maintDateHistory'] = maintDateHistory;
    data['crew'] = crew;
    data['fdrName'] = fdrName;
    data['street'] = street;
    data['yearName'] = yearName;
    data['createDate'] = createDate;
    data['contractorCompny'] = contractorCompny;
    data['actualCost'] = actualCost;
    data['planType'] = planType;
    data['estCost'] = estCost;
    data['treeType'] = treeType;
    data['totalMiles'] = totalMiles;
    data['estTime'] = estTime;
    data['adminNotes2'] = adminNotes2;
    data['createdBy'] = createdBy;
    data['streetAddress'] = streetAddress;
    data['mapLocation'] = mapLocation;
    return data;
  }
}

class GetAllSubstations {
  String? substation;

  GetAllSubstations({this.substation});

  GetAllSubstations.fromJson(Map<String, dynamic> json) {
    substation = json['substation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['substation'] = substation;
    return data;
  }
}

class FindSumOfTotalMileBySubstationAndFeederAndCycle {
  double? totalMiles;

  FindSumOfTotalMileBySubstationAndFeederAndCycle({this.totalMiles});

  FindSumOfTotalMileBySubstationAndFeederAndCycle.fromJson(
      Map<String, dynamic> json) {
    totalMiles = json['totalMiles'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalMiles'] = totalMiles;
    return data;
  }
}

class FindAllSumOfTotalMiles {
  double? sumOfTotalMiles;

  FindAllSumOfTotalMiles({this.sumOfTotalMiles});

  FindAllSumOfTotalMiles.fromJson(Map<String, dynamic> json) {
    sumOfTotalMiles = json['SumOfTotalMiles'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['SumOfTotalMiles'] = sumOfTotalMiles;
    return data;
  }
}

class GetSPSMMAINTTOTALCOSTBYTYPEFTRList {
  String? type;
  int? totalCost;

  GetSPSMMAINTTOTALCOSTBYTYPEFTRList({this.type, this.totalCost});

  GetSPSMMAINTTOTALCOSTBYTYPEFTRList.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    totalCost = json['totalCost'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['totalCost'] = totalCost;
    return data;
  }
}

class GetSPSMMAINTTOTALMILESBYTYPEFTRLIST {
  double? totalMiles;
  String? type;

  GetSPSMMAINTTOTALMILESBYTYPEFTRLIST({this.totalMiles, this.type});

  GetSPSMMAINTTOTALMILESBYTYPEFTRLIST.fromJson(Map<String, dynamic> json) {
    totalMiles = json['totalMiles'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalMiles'] = totalMiles;
    data['type'] = type;
    return data;
  }
}

class GetSPMAINTENANCEANALYSISPROGRESS {
  int? cnt;
  String? status;

  GetSPMAINTENANCEANALYSISPROGRESS({this.cnt, this.status});

  GetSPMAINTENANCEANALYSISPROGRESS.fromJson(Map<String, dynamic> json) {
    cnt = json['cnt'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cnt'] = cnt;
    data['status'] = status;
    return data;
  }
}
