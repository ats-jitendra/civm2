class RowCostAnalysisByMonthModel {
  List<FindsTableDataOfRowCosAnalysisPage>? findsTableDataOfRowCosAnalysisPage;
  List<FindsFeederAndIdBySubstation>? findsFeederAndIdBySubstation;
  List<FindsNextMaintDueAndMonthIdBySubstationAndFeeder>?
      findsNextMaintDueAndMonthIdBySubstationAndFeeder;
  List<FindsNextMaintDueBySubstationAndFeederAndNextMaintDueMonth>?
      findsNextMaintDueBySubstationAndFeederAndNextMaintDueMonth;
  List<SumOfBudgetsByNextMaintDueMonthAndYrAndSubstationAndFeeder>?
      sumOfBudgetsByNextMaintDueMonthAndYrAndSubstationAndFeeder;
  List<GetSPROWCOSTANALYSISBYMONTH>? getSPROWCOSTANALYSISBYMONTH;
  List<FindsAllSubstation>? findsAllSubstation;
  int? findsEstimatedBudget;
  List<FindsSumOfBudgetByNextMaintDueMonthAndYrAndTypeAndSubstationAndFeeder>?
      findsSumOfBudgetByNextMaintDueMonthAndYrAndTypeAndSubstationAndFeeder;
  List<FindsEstimatedBudgetBySubstation>? findsEstimatedBudgetBySubstation;
  List<FindsEstimatedBudgetByAndSubstationAndFeederAndNextMaintDue>?
      findsEstimatedBudgetByAndSubstationAndFeederAndNextMaintDue;

  RowCostAnalysisByMonthModel(
      {this.findsTableDataOfRowCosAnalysisPage,
      this.findsFeederAndIdBySubstation,
      this.findsNextMaintDueAndMonthIdBySubstationAndFeeder,
      this.findsNextMaintDueBySubstationAndFeederAndNextMaintDueMonth,
      this.sumOfBudgetsByNextMaintDueMonthAndYrAndSubstationAndFeeder,
      this.getSPROWCOSTANALYSISBYMONTH,
      this.findsAllSubstation,
      this.findsEstimatedBudget,
      this.findsSumOfBudgetByNextMaintDueMonthAndYrAndTypeAndSubstationAndFeeder,
      this.findsEstimatedBudgetBySubstation,
      this.findsEstimatedBudgetByAndSubstationAndFeederAndNextMaintDue});

  RowCostAnalysisByMonthModel.fromJson(Map<String, dynamic> json) {
    if (json['findsTableDataOfRowCosAnalysisPage'] != null) {
      findsTableDataOfRowCosAnalysisPage =
          <FindsTableDataOfRowCosAnalysisPage>[];
      json['findsTableDataOfRowCosAnalysisPage'].forEach((v) {
        findsTableDataOfRowCosAnalysisPage!
            .add(FindsTableDataOfRowCosAnalysisPage.fromJson(v));
      });
    }
    if (json['findsFeederAndIdBySubstation'] != null) {
      findsFeederAndIdBySubstation = <FindsFeederAndIdBySubstation>[];
      json['findsFeederAndIdBySubstation'].forEach((v) {
        findsFeederAndIdBySubstation!
            .add(FindsFeederAndIdBySubstation.fromJson(v));
      });
    }
    if (json['findsNextMaintDueAndMonthIdBySubstationAndFeeder'] != null) {
      findsNextMaintDueAndMonthIdBySubstationAndFeeder =
          <FindsNextMaintDueAndMonthIdBySubstationAndFeeder>[];
      json['findsNextMaintDueAndMonthIdBySubstationAndFeeder'].forEach((v) {
        findsNextMaintDueAndMonthIdBySubstationAndFeeder!
            .add(FindsNextMaintDueAndMonthIdBySubstationAndFeeder.fromJson(v));
      });
    }
    if (json['findsNextMaintDueBySubstationAndFeederAndNextMaintDueMonth'] !=
        null) {
      findsNextMaintDueBySubstationAndFeederAndNextMaintDueMonth =
          <FindsNextMaintDueBySubstationAndFeederAndNextMaintDueMonth>[];
      json['findsNextMaintDueBySubstationAndFeederAndNextMaintDueMonth']
          .forEach((v) {
        findsNextMaintDueBySubstationAndFeederAndNextMaintDueMonth!.add(
            FindsNextMaintDueBySubstationAndFeederAndNextMaintDueMonth.fromJson(
                v));
      });
    }
    if (json['sumOfBudgetsByNextMaintDueMonthAndYrAndSubstationAndFeeder'] !=
        null) {
      sumOfBudgetsByNextMaintDueMonthAndYrAndSubstationAndFeeder =
          <SumOfBudgetsByNextMaintDueMonthAndYrAndSubstationAndFeeder>[];
      json['sumOfBudgetsByNextMaintDueMonthAndYrAndSubstationAndFeeder']
          .forEach((v) {
        sumOfBudgetsByNextMaintDueMonthAndYrAndSubstationAndFeeder!.add(
            SumOfBudgetsByNextMaintDueMonthAndYrAndSubstationAndFeeder.fromJson(
                v));
      });
    }
    if (json['getSP_ROW_COST_ANALYSIS_BY_MONTH'] != null) {
      getSPROWCOSTANALYSISBYMONTH = <GetSPROWCOSTANALYSISBYMONTH>[];
      json['getSP_ROW_COST_ANALYSIS_BY_MONTH'].forEach((v) {
        getSPROWCOSTANALYSISBYMONTH!
            .add(GetSPROWCOSTANALYSISBYMONTH.fromJson(v));
      });
    }
    if (json['findsAllSubstation'] != null) {
      findsAllSubstation = <FindsAllSubstation>[];
      json['findsAllSubstation'].forEach((v) {
        findsAllSubstation!.add(FindsAllSubstation.fromJson(v));
      });
    }
    findsEstimatedBudget = json['findsEstimatedBudget'];
    if (json[
            'findsSumOfBudgetByNextMaintDueMonthAndYrAndTypeAndSubstationAndFeeder'] !=
        null) {
      findsSumOfBudgetByNextMaintDueMonthAndYrAndTypeAndSubstationAndFeeder =
          <FindsSumOfBudgetByNextMaintDueMonthAndYrAndTypeAndSubstationAndFeeder>[];
      json['findsSumOfBudgetByNextMaintDueMonthAndYrAndTypeAndSubstationAndFeeder']
          .forEach((v) {
        findsSumOfBudgetByNextMaintDueMonthAndYrAndTypeAndSubstationAndFeeder!.add(
            FindsSumOfBudgetByNextMaintDueMonthAndYrAndTypeAndSubstationAndFeeder
                .fromJson(v));
      });
    }
    if (json['findsEstimatedBudgetBySubstation'] != null) {
      findsEstimatedBudgetBySubstation = <FindsEstimatedBudgetBySubstation>[];
      json['findsEstimatedBudgetBySubstation'].forEach((v) {
        findsEstimatedBudgetBySubstation!
            .add(FindsEstimatedBudgetBySubstation.fromJson(v));
      });
    }
    if (json['findsEstimatedBudgetByAndSubstationAndFeederAndNextMaintDue'] !=
        null) {
      findsEstimatedBudgetByAndSubstationAndFeederAndNextMaintDue =
          <FindsEstimatedBudgetByAndSubstationAndFeederAndNextMaintDue>[];
      json['findsEstimatedBudgetByAndSubstationAndFeederAndNextMaintDue']
          .forEach((v) {
        findsEstimatedBudgetByAndSubstationAndFeederAndNextMaintDue!.add(
            FindsEstimatedBudgetByAndSubstationAndFeederAndNextMaintDue
                .fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (findsTableDataOfRowCosAnalysisPage != null) {
      data['findsTableDataOfRowCosAnalysisPage'] =
          findsTableDataOfRowCosAnalysisPage!.map((v) => v.toJson()).toList();
    }
    if (findsFeederAndIdBySubstation != null) {
      data['findsFeederAndIdBySubstation'] =
          findsFeederAndIdBySubstation!.map((v) => v.toJson()).toList();
    }
    if (findsNextMaintDueAndMonthIdBySubstationAndFeeder != null) {
      data['findsNextMaintDueAndMonthIdBySubstationAndFeeder'] =
          findsNextMaintDueAndMonthIdBySubstationAndFeeder!
              .map((v) => v.toJson())
              .toList();
    }
    if (findsNextMaintDueBySubstationAndFeederAndNextMaintDueMonth != null) {
      data['findsNextMaintDueBySubstationAndFeederAndNextMaintDueMonth'] =
          findsNextMaintDueBySubstationAndFeederAndNextMaintDueMonth!
              .map((v) => v.toJson())
              .toList();
    }
    if (sumOfBudgetsByNextMaintDueMonthAndYrAndSubstationAndFeeder != null) {
      data['sumOfBudgetsByNextMaintDueMonthAndYrAndSubstationAndFeeder'] =
          sumOfBudgetsByNextMaintDueMonthAndYrAndSubstationAndFeeder!
              .map((v) => v.toJson())
              .toList();
    }
    if (getSPROWCOSTANALYSISBYMONTH != null) {
      data['getSP_ROW_COST_ANALYSIS_BY_MONTH'] =
          getSPROWCOSTANALYSISBYMONTH!.map((v) => v.toJson()).toList();
    }
    if (findsAllSubstation != null) {
      data['findsAllSubstation'] =
          findsAllSubstation!.map((v) => v.toJson()).toList();
    }
    data['findsEstimatedBudget'] = findsEstimatedBudget;
    if (findsSumOfBudgetByNextMaintDueMonthAndYrAndTypeAndSubstationAndFeeder !=
        null) {
      data['findsSumOfBudgetByNextMaintDueMonthAndYrAndTypeAndSubstationAndFeeder'] =
          findsSumOfBudgetByNextMaintDueMonthAndYrAndTypeAndSubstationAndFeeder!
              .map((v) => v.toJson())
              .toList();
    }
    if (findsEstimatedBudgetBySubstation != null) {
      data['findsEstimatedBudgetBySubstation'] =
          findsEstimatedBudgetBySubstation!.map((v) => v.toJson()).toList();
    }
    if (findsEstimatedBudgetByAndSubstationAndFeederAndNextMaintDue != null) {
      data['findsEstimatedBudgetByAndSubstationAndFeederAndNextMaintDue'] =
          findsEstimatedBudgetByAndSubstationAndFeederAndNextMaintDue!
              .map((v) => v.toJson())
              .toList();
    }
    return data;
  }
}

class FindsSumOfBudgetByNextMaintDueMonthAndYrAndTypeAndSubstationAndFeeder {
  String? sumOfBudget;

  FindsSumOfBudgetByNextMaintDueMonthAndYrAndTypeAndSubstationAndFeeder(
      {this.sumOfBudget});

  FindsSumOfBudgetByNextMaintDueMonthAndYrAndTypeAndSubstationAndFeeder.fromJson(
      Map<String, dynamic> json) {
    sumOfBudget = json['sumOfBudget'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sumOfBudget'] = sumOfBudget;
    return data;
  }
}

class FindsNextMaintDueBySubstationAndFeederAndNextMaintDueMonth {
  String? year;
  int? id;

  FindsNextMaintDueBySubstationAndFeederAndNextMaintDueMonth(
      {this.year, this.id});

  FindsNextMaintDueBySubstationAndFeederAndNextMaintDueMonth.fromJson(
      Map<String, dynamic> json) {
    year = json['year'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['year'] = year;
    data['id'] = id;
    return data;
  }
}

class FindsTableDataOfRowCosAnalysisPage {
  String? contractYear;
  String? costPerMile;
  String? dateOfInspection;
  String? county;
  String? approvedBy;
  String? actionNeeded;
  String? type;
  String? adminNotes1;
  String? growthScore;
  String? documentUpload;
  String? milesInProgress;
  String? maintType;
  String? substation;
  String? contractorNotes;
  int? id;
  String? budget;
  String? lastMaintDone;
  String? milesPending;
  String? maintCount;
  String? contractEndYear;
  String? followUpDate;
  String? district;
  String? changeOrderImage;
  String? supervisor;
  String? totalCost;
  String? status;
  String? invoiceCreated;
  String? contractor;
  String? milesCompleted;
  String? dueWeek;
  String? growthRate;
  String? tokenNo;
  String? nextMaintDue;
  String? cycle;
  String? maintDateHistory;
  String? crew;
  String? tblVmaNewMaintenancePlanId;
  String? fdrName;
  String? street;
  String? createDate;
  String? dueMoth;
  String? planType;
  String? treeType;
  String? totalMiles;
  String? contactorCompany;
  String? noColumnName;
  String? adminNotes2;
  String? createdBy;
  String? streetAddress;
  String? mapLocation;

  FindsTableDataOfRowCosAnalysisPage(
      {this.contractYear,
      this.costPerMile,
      this.dateOfInspection,
      this.county,
      this.approvedBy,
      this.actionNeeded,
      this.type,
      this.adminNotes1,
      this.growthScore,
      this.documentUpload,
      this.milesInProgress,
      this.maintType,
      this.substation,
      this.contractorNotes,
      this.id,
      this.budget,
      this.lastMaintDone,
      this.milesPending,
      this.maintCount,
      this.contractEndYear,
      this.followUpDate,
      this.district,
      this.changeOrderImage,
      this.supervisor,
      this.totalCost,
      this.status,
      this.invoiceCreated,
      this.contractor,
      this.milesCompleted,
      this.dueWeek,
      this.growthRate,
      this.tokenNo,
      this.nextMaintDue,
      this.cycle,
      this.maintDateHistory,
      this.crew,
      this.tblVmaNewMaintenancePlanId,
      this.fdrName,
      this.street,
      this.createDate,
      this.dueMoth,
      this.planType,
      this.treeType,
      this.totalMiles,
      this.contactorCompany,
      this.noColumnName,
      this.adminNotes2,
      this.createdBy,
      this.streetAddress,
      this.mapLocation});

  FindsTableDataOfRowCosAnalysisPage.fromJson(Map<String, dynamic> json) {
    contractYear = json['contractYear'];
    costPerMile = json['costPerMile'];
    dateOfInspection = json['dateOfInspection'];
    county = json['county'];
    approvedBy = json['approvedBy'];
    actionNeeded = json['actionNeeded'];
    type = json['type'];
    adminNotes1 = json['adminNotes1'];
    growthScore = json['growthScore'];
    documentUpload = json['documentUpload'];
    milesInProgress = json['milesInProgress'];
    maintType = json['maintType'];
    substation = json['substation'];
    contractorNotes = json['contractorNotes'];
    id = json['id'];
    budget = json['budget'];
    lastMaintDone = json['lastMaintDone'];
    milesPending = json['milesPending'];
    maintCount = json['maintCount'];
    contractEndYear = json['contractEndYear'];
    followUpDate = json['followUpDate'];
    district = json['district'];
    changeOrderImage = json['changeOrderImage'];
    supervisor = json['supervisor'];
    totalCost = json['totalCost'];
    status = json['status'];
    invoiceCreated = json['invoiceCreated'];
    contractor = json['contractor'];
    milesCompleted = json['milesCompleted'];
    dueWeek = json['dueWeek'];
    growthRate = json['growthRate'];
    tokenNo = json['tokenNo'];
    nextMaintDue = json['nextMaintDue'];
    cycle = json['cycle'];
    maintDateHistory = json['maintDateHistory'];
    crew = json['crew'];
    tblVmaNewMaintenancePlanId = json['tblVmaNewMaintenancePlanId'];
    fdrName = json['fdrName'];
    street = json['street'];
    createDate = json['createDate'];
    dueMoth = json['dueMoth'];
    planType = json['planType'];
    treeType = json['treeType'];
    totalMiles = json['totalMiles'];
    contactorCompany = json['contactorCompany'];
    noColumnName = json['noColumnName'];
    adminNotes2 = json['adminNotes2'];
    createdBy = json['createdBy'];
    streetAddress = json['streetAddress'];
    mapLocation = json['mapLocation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['contractYear'] = contractYear;
    data['costPerMile'] = costPerMile;
    data['dateOfInspection'] = dateOfInspection;
    data['county'] = county;
    data['approvedBy'] = approvedBy;
    data['actionNeeded'] = actionNeeded;
    data['type'] = type;
    data['adminNotes1'] = adminNotes1;
    data['growthScore'] = growthScore;
    data['documentUpload'] = documentUpload;
    data['milesInProgress'] = milesInProgress;
    data['maintType'] = maintType;
    data['substation'] = substation;
    data['contractorNotes'] = contractorNotes;
    data['id'] = id;
    data['budget'] = budget;
    data['lastMaintDone'] = lastMaintDone;
    data['milesPending'] = milesPending;
    data['maintCount'] = maintCount;
    data['contractEndYear'] = contractEndYear;
    data['followUpDate'] = followUpDate;
    data['district'] = district;
    data['changeOrderImage'] = changeOrderImage;
    data['supervisor'] = supervisor;
    data['totalCost'] = totalCost;
    data['status'] = status;
    data['invoiceCreated'] = invoiceCreated;
    data['contractor'] = contractor;
    data['milesCompleted'] = milesCompleted;
    data['dueWeek'] = dueWeek;
    data['growthRate'] = growthRate;
    data['tokenNo'] = tokenNo;
    data['nextMaintDue'] = nextMaintDue;
    data['cycle'] = cycle;
    data['maintDateHistory'] = maintDateHistory;
    data['crew'] = crew;
    data['tblVmaNewMaintenancePlanId'] = tblVmaNewMaintenancePlanId;
    data['fdrName'] = fdrName;
    data['street'] = street;
    data['createDate'] = createDate;
    data['dueMoth'] = dueMoth;
    data['planType'] = planType;
    data['treeType'] = treeType;
    data['totalMiles'] = totalMiles;
    data['contactorCompany'] = contactorCompany;
    data['noColumnName'] = noColumnName;
    data['adminNotes2'] = adminNotes2;
    data['createdBy'] = createdBy;
    data['streetAddress'] = streetAddress;
    data['mapLocation'] = mapLocation;
    return data;
  }
}

class FindsFeederAndIdBySubstation {
  String? feederName;
  int? id;

  FindsFeederAndIdBySubstation({this.feederName, this.id});

  FindsFeederAndIdBySubstation.fromJson(Map<String, dynamic> json) {
    feederName = json['feederName'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['feederName'] = feederName;
    data['id'] = id;
    return data;
  }
}

class FindsNextMaintDueAndMonthIdBySubstationAndFeeder {
  String? nextMaintDue;
  int? monthId;

  FindsNextMaintDueAndMonthIdBySubstationAndFeeder(
      {this.nextMaintDue, this.monthId});

  FindsNextMaintDueAndMonthIdBySubstationAndFeeder.fromJson(
      Map<String, dynamic> json) {
    nextMaintDue = json['nextMaintDue'];
    monthId = json['monthId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nextMaintDue'] = nextMaintDue;
    data['monthId'] = monthId;
    return data;
  }
}

class SumOfBudgetsByNextMaintDueMonthAndYrAndSubstationAndFeeder {
  String? sumOfBudget;

  SumOfBudgetsByNextMaintDueMonthAndYrAndSubstationAndFeeder(
      {this.sumOfBudget});

  SumOfBudgetsByNextMaintDueMonthAndYrAndSubstationAndFeeder.fromJson(
      Map<String, dynamic> json) {
    sumOfBudget = json['sumOfBudget'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sumOfBudget'] = sumOfBudget;
    return data;
  }
}

class GetSPROWCOSTANALYSISBYMONTH {
  double? mechanicalCleaning;
  double? pruning;
  double? arealPruning;
  double? mechanicalPruning;
  double? selectiveMechanicalTreeRemoval;
  double? herbicide;
  String? yrMonth;

  GetSPROWCOSTANALYSISBYMONTH(
      {this.mechanicalCleaning,
      this.pruning,
      this.arealPruning,
      this.mechanicalPruning,
      this.selectiveMechanicalTreeRemoval,
      this.herbicide,
      this.yrMonth});

  GetSPROWCOSTANALYSISBYMONTH.fromJson(Map<String, dynamic> json) {
    mechanicalCleaning = json['mechanicalCleaning'];
    pruning = json['pruning'];

    arealPruning = json['arealPruning'];
    mechanicalPruning = json['mechanicalPruning'];

    selectiveMechanicalTreeRemoval = json['SelectiveMechanicalTreeRemoval'];
    herbicide = json['herbicide'];
    yrMonth = json['yrMonth'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mechanicalCleaning'] = mechanicalCleaning;
    data['arealPruning'] = arealPruning;
    data['mechanicalPruning'] = mechanicalPruning;
    data['SelectiveMechanicalTreeRemoval'] = selectiveMechanicalTreeRemoval;
    data['herbicide'] = herbicide;
    data['yrMonth'] = yrMonth;
    return data;
  }
}

class FindsAllSubstation {
  String? substation;
  int? id;

  FindsAllSubstation({this.substation, this.id});

  FindsAllSubstation.fromJson(Map<String, dynamic> json) {
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

class FindsEstimatedBudgetBySubstation {
  double? estimatedBudget;

  FindsEstimatedBudgetBySubstation({this.estimatedBudget});

  FindsEstimatedBudgetBySubstation.fromJson(Map<String, dynamic> json) {
    estimatedBudget = json['estimatedBudget'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['estimatedBudget'] = estimatedBudget;
    return data;
  }
}

class FindsEstimatedBudgetByAndSubstationAndFeederAndNextMaintDue {
  double? estimatedBudget;

  FindsEstimatedBudgetByAndSubstationAndFeederAndNextMaintDue(
      {this.estimatedBudget});

  FindsEstimatedBudgetByAndSubstationAndFeederAndNextMaintDue.fromJson(
      Map<String, dynamic> json) {
    estimatedBudget = json['estimatedBudget'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['estimatedBudget'] = estimatedBudget;
    return data;
  }
}
