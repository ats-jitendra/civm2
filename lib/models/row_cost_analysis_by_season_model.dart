class RowCostAnalysisBySeasonModel {
  List<FindsTableDataOfRowCosAnalysisPage>? findsTableDataOfRowCosAnalysisPage;
  List<FindsEstimatedBudgetBySubstationAndFdrAndNextMaintDueMonthAndYrAndTypes>?
      findsEstimatedBudgetBySubstationAndFdrAndNextMaintDueMonthAndYrAndTypes;
  List<FindsEstimatedBudgetBySubstationAndFdrAndNextMaintDueMonthAndYr>?
      findsEstimatedBudgetBySubstationAndFdrAndNextMaintDueMonthAndYr;
  List<FindEstimatedBudgetBySubstations>? findEstimatedBudgetBySubstations;
  List<FindsSubstations>? findsSubstations;
  List<FindsFdrNameAndIdsBySubstation>? findsFdrNameAndIdsBySubstation;
  List<FindsEstimatedBudgetBySubstationAndMainType>?
      findsEstimatedBudgetBySubstationAndMainType;
  int? findsEstimatedBudget;
  List<FindsNextMaintDueBySubstationAndFeederOfRowCABySeasonPage>?
      findsNextMaintDueBySubstationAndFeederOfRowCABySeasonPage;
  List<FindsEstimatedBudgetBySubstationAndFeederAndNextMaintDueMonthOfSeasonPage>?
      findsEstimatedBudgetBySubstationAndFeederAndNextMaintDueMonthOfSeasonPage;
  List<FindsNextMaintDueBySubstationAndFdrAndNextMaintDueYr>?
      findsNextMaintDueBySubstationAndFdrAndNextMaintDueYr;
  List<GetSpRowCostANALYSISBYSEASON>? getSpRowCostANALYSISBYSEASON;

  RowCostAnalysisBySeasonModel(
      {this.findsTableDataOfRowCosAnalysisPage,
      this.findsEstimatedBudgetBySubstationAndFdrAndNextMaintDueMonthAndYrAndTypes,
      this.findsEstimatedBudgetBySubstationAndFdrAndNextMaintDueMonthAndYr,
      this.findEstimatedBudgetBySubstations,
      this.findsSubstations,
      this.findsFdrNameAndIdsBySubstation,
      this.findsEstimatedBudgetBySubstationAndMainType,
      this.findsEstimatedBudget,
      this.findsNextMaintDueBySubstationAndFeederOfRowCABySeasonPage,
      this.findsEstimatedBudgetBySubstationAndFeederAndNextMaintDueMonthOfSeasonPage,
      this.findsNextMaintDueBySubstationAndFdrAndNextMaintDueYr,
      this.getSpRowCostANALYSISBYSEASON});

  RowCostAnalysisBySeasonModel.fromJson(Map<String, dynamic> json) {
    if (json['findsTableDataOfRowCosAnalysisPage'] != null) {
      findsTableDataOfRowCosAnalysisPage =
          <FindsTableDataOfRowCosAnalysisPage>[];
      json['findsTableDataOfRowCosAnalysisPage'].forEach((v) {
        findsTableDataOfRowCosAnalysisPage!
            .add(FindsTableDataOfRowCosAnalysisPage.fromJson(v));
      });
    }
    if (json[
            'findsEstimatedBudgetBySubstationAndFdrAndNextMaintDueMonthAndYrAndTypes'] !=
        null) {
      findsEstimatedBudgetBySubstationAndFdrAndNextMaintDueMonthAndYrAndTypes =
          <FindsEstimatedBudgetBySubstationAndFdrAndNextMaintDueMonthAndYrAndTypes>[];
      json['findsEstimatedBudgetBySubstationAndFdrAndNextMaintDueMonthAndYrAndTypes']
          .forEach((v) {
        findsEstimatedBudgetBySubstationAndFdrAndNextMaintDueMonthAndYrAndTypes!
            .add(
                FindsEstimatedBudgetBySubstationAndFdrAndNextMaintDueMonthAndYrAndTypes
                    .fromJson(v));
      });
    }
    if (json[
            'findsEstimatedBudgetBySubstationAndFdrAndNextMaintDueMonthAndYr'] !=
        null) {
      findsEstimatedBudgetBySubstationAndFdrAndNextMaintDueMonthAndYr =
          <FindsEstimatedBudgetBySubstationAndFdrAndNextMaintDueMonthAndYr>[];
      json['findsEstimatedBudgetBySubstationAndFdrAndNextMaintDueMonthAndYr']
          .forEach((v) {
        findsEstimatedBudgetBySubstationAndFdrAndNextMaintDueMonthAndYr!.add(
            FindsEstimatedBudgetBySubstationAndFdrAndNextMaintDueMonthAndYr
                .fromJson(v));
      });
    }
    if (json['findEstimatedBudgetBySubstations'] != null) {
      findEstimatedBudgetBySubstations = <FindEstimatedBudgetBySubstations>[];
      json['findEstimatedBudgetBySubstations'].forEach((v) {
        findEstimatedBudgetBySubstations!
            .add(FindEstimatedBudgetBySubstations.fromJson(v));
      });
    }
    if (json['findsSubstations'] != null) {
      findsSubstations = <FindsSubstations>[];
      json['findsSubstations'].forEach((v) {
        findsSubstations!.add(FindsSubstations.fromJson(v));
      });
    }
    if (json['findsFdrNameAndIdsBySubstation'] != null) {
      findsFdrNameAndIdsBySubstation = <FindsFdrNameAndIdsBySubstation>[];
      json['findsFdrNameAndIdsBySubstation'].forEach((v) {
        findsFdrNameAndIdsBySubstation!
            .add(FindsFdrNameAndIdsBySubstation.fromJson(v));
      });
    }
    if (json['findsEstimatedBudgetBySubstationAndMainType'] != null) {
      findsEstimatedBudgetBySubstationAndMainType =
          <FindsEstimatedBudgetBySubstationAndMainType>[];
      json['findsEstimatedBudgetBySubstationAndMainType'].forEach((v) {
        findsEstimatedBudgetBySubstationAndMainType!
            .add(FindsEstimatedBudgetBySubstationAndMainType.fromJson(v));
      });
    }
    findsEstimatedBudget = json['findsEstimatedBudget'];
    if (json['findsNextMaintDueBySubstationAndFeederOfRowCABySeasonPage'] !=
        null) {
      findsNextMaintDueBySubstationAndFeederOfRowCABySeasonPage =
          <FindsNextMaintDueBySubstationAndFeederOfRowCABySeasonPage>[];
      json['findsNextMaintDueBySubstationAndFeederOfRowCABySeasonPage']
          .forEach((v) {
        findsNextMaintDueBySubstationAndFeederOfRowCABySeasonPage!.add(
            FindsNextMaintDueBySubstationAndFeederOfRowCABySeasonPage
                .fromJson(v));
      });
    }
    if (json[
            'findsEstimatedBudgetBySubstationAndFeederAndNextMaintDueMonthOfSeasonPage'] !=
        null) {
      findsEstimatedBudgetBySubstationAndFeederAndNextMaintDueMonthOfSeasonPage =
          <FindsEstimatedBudgetBySubstationAndFeederAndNextMaintDueMonthOfSeasonPage>[];
      json['findsEstimatedBudgetBySubstationAndFeederAndNextMaintDueMonthOfSeasonPage']
          .forEach((v) {
        findsEstimatedBudgetBySubstationAndFeederAndNextMaintDueMonthOfSeasonPage!
            .add(
                FindsEstimatedBudgetBySubstationAndFeederAndNextMaintDueMonthOfSeasonPage
                    .fromJson(v));
      });
    }
    if (json['findsNextMaintDueBySubstationAndFdrAndNextMaintDueYr'] != null) {
      findsNextMaintDueBySubstationAndFdrAndNextMaintDueYr =
          <FindsNextMaintDueBySubstationAndFdrAndNextMaintDueYr>[];
      json['findsNextMaintDueBySubstationAndFdrAndNextMaintDueYr'].forEach((v) {
        findsNextMaintDueBySubstationAndFdrAndNextMaintDueYr!.add(
            FindsNextMaintDueBySubstationAndFdrAndNextMaintDueYr.fromJson(
                v));
      });
    }
    if (json['getSpRowCostANALYSISBYSEASON'] != null) {
      getSpRowCostANALYSISBYSEASON = <GetSpRowCostANALYSISBYSEASON>[];
      json['getSpRowCostANALYSISBYSEASON'].forEach((v) {
        getSpRowCostANALYSISBYSEASON!
            .add(GetSpRowCostANALYSISBYSEASON.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (findsTableDataOfRowCosAnalysisPage != null) {
      data['findsTableDataOfRowCosAnalysisPage'] = findsTableDataOfRowCosAnalysisPage!
          .map((v) => v.toJson())
          .toList();
    }
    if (findsEstimatedBudgetBySubstationAndFdrAndNextMaintDueMonthAndYrAndTypes !=
        null) {
      data['findsEstimatedBudgetBySubstationAndFdrAndNextMaintDueMonthAndYrAndTypes'] =
          findsEstimatedBudgetBySubstationAndFdrAndNextMaintDueMonthAndYrAndTypes!
              .map((v) => v.toJson())
              .toList();
    }
    if (findsEstimatedBudgetBySubstationAndFdrAndNextMaintDueMonthAndYr !=
        null) {
      data['findsEstimatedBudgetBySubstationAndFdrAndNextMaintDueMonthAndYr'] =
          findsEstimatedBudgetBySubstationAndFdrAndNextMaintDueMonthAndYr!
              .map((v) => v.toJson())
              .toList();
    }
    if (findEstimatedBudgetBySubstations != null) {
      data['findEstimatedBudgetBySubstations'] = findEstimatedBudgetBySubstations!
          .map((v) => v.toJson())
          .toList();
    }
    if (findsSubstations != null) {
      data['findsSubstations'] =
          findsSubstations!.map((v) => v.toJson()).toList();
    }
    if (findsFdrNameAndIdsBySubstation != null) {
      data['findsFdrNameAndIdsBySubstation'] =
          findsFdrNameAndIdsBySubstation!.map((v) => v.toJson()).toList();
    }
    if (findsEstimatedBudgetBySubstationAndMainType != null) {
      data['findsEstimatedBudgetBySubstationAndMainType'] = findsEstimatedBudgetBySubstationAndMainType!
          .map((v) => v.toJson())
          .toList();
    }
    data['findsEstimatedBudget'] = findsEstimatedBudget;
    if (findsNextMaintDueBySubstationAndFeederOfRowCABySeasonPage !=
        null) {
      data['findsNextMaintDueBySubstationAndFeederOfRowCABySeasonPage'] = findsNextMaintDueBySubstationAndFeederOfRowCABySeasonPage!
          .map((v) => v.toJson())
          .toList();
    }
    if (findsEstimatedBudgetBySubstationAndFeederAndNextMaintDueMonthOfSeasonPage !=
        null) {
      data['findsEstimatedBudgetBySubstationAndFeederAndNextMaintDueMonthOfSeasonPage'] =
          findsEstimatedBudgetBySubstationAndFeederAndNextMaintDueMonthOfSeasonPage!
              .map((v) => v.toJson())
              .toList();
    }
    if (findsNextMaintDueBySubstationAndFdrAndNextMaintDueYr != null) {
      data['findsNextMaintDueBySubstationAndFdrAndNextMaintDueYr'] = findsNextMaintDueBySubstationAndFdrAndNextMaintDueYr!
          .map((v) => v.toJson())
          .toList();
    }
    if (getSpRowCostANALYSISBYSEASON != null) {
      data['getSpRowCostANALYSISBYSEASON'] =
          getSpRowCostANALYSISBYSEASON!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FindsEstimatedBudgetBySubstationAndMainType {
  FindsEstimatedBudgetBySubstationAndMainType.fromJson(v);

  toJson() {}
}

class FindEstimatedBudgetBySubstations {
  FindEstimatedBudgetBySubstations.fromJson(v);

  toJson() {}
}

class FindsEstimatedBudgetBySubstationAndFdrAndNextMaintDueMonthAndYr {
  FindsEstimatedBudgetBySubstationAndFdrAndNextMaintDueMonthAndYr.fromJson(v);

  toJson() {}
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

class FindsEstimatedBudgetBySubstationAndFdrAndNextMaintDueMonthAndYrAndTypes {
  double? estimatedBudget;

  FindsEstimatedBudgetBySubstationAndFdrAndNextMaintDueMonthAndYrAndTypes(
      {this.estimatedBudget});

  FindsEstimatedBudgetBySubstationAndFdrAndNextMaintDueMonthAndYrAndTypes.fromJson(
      Map<String, dynamic> json) {
    estimatedBudget = json['estimatedBudget'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['estimatedBudget'] = estimatedBudget;
    return data;
  }
}

class FindsSubstations {
  String? substation;
  int? id;

  FindsSubstations({this.substation, this.id});

  FindsSubstations.fromJson(Map<String, dynamic> json) {
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

class FindsFdrNameAndIdsBySubstation {
  String? fdrName;
  int? id;

  FindsFdrNameAndIdsBySubstation({this.fdrName, this.id});

  FindsFdrNameAndIdsBySubstation.fromJson(Map<String, dynamic> json) {
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

class FindsNextMaintDueBySubstationAndFeederOfRowCABySeasonPage {
  int? nextMaintDue;

  FindsNextMaintDueBySubstationAndFeederOfRowCABySeasonPage(
      {this.nextMaintDue});

  FindsNextMaintDueBySubstationAndFeederOfRowCABySeasonPage.fromJson(
      Map<String, dynamic> json) {
    nextMaintDue = json['nextMaintDue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nextMaintDue'] = nextMaintDue;
    return data;
  }
}

class FindsEstimatedBudgetBySubstationAndFeederAndNextMaintDueMonthOfSeasonPage {
  double? estimatedBudget;

  FindsEstimatedBudgetBySubstationAndFeederAndNextMaintDueMonthOfSeasonPage(
      {this.estimatedBudget});

  FindsEstimatedBudgetBySubstationAndFeederAndNextMaintDueMonthOfSeasonPage.fromJson(
      Map<String, dynamic> json) {
    estimatedBudget = json['estimatedBudget'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['estimatedBudget'] = estimatedBudget;
    return data;
  }
}

class FindsNextMaintDueBySubstationAndFdrAndNextMaintDueYr {
  String? nextMaintDue;

  FindsNextMaintDueBySubstationAndFdrAndNextMaintDueYr({this.nextMaintDue});

  FindsNextMaintDueBySubstationAndFdrAndNextMaintDueYr.fromJson(
      Map<String, dynamic> json) {
    nextMaintDue = json['nextMaintDue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nextMaintDue'] = nextMaintDue;
    return data;
  }
}

class GetSpRowCostANALYSISBYSEASON {
  double? pruning;
  double? arealPruning;
  double? mechanicalPruning;
  double? herbicide;
  String? yearSeason;
  double? mechanicalClearing;
  double? selectiveMechanicalTreeRemoval;

  GetSpRowCostANALYSISBYSEASON(
      {this.pruning,
      this.arealPruning,
      this.mechanicalPruning,
      this.herbicide,
      this.yearSeason,
      this.mechanicalClearing,
      this.selectiveMechanicalTreeRemoval});

  GetSpRowCostANALYSISBYSEASON.fromJson(Map<String, dynamic> json) {
    pruning = json['pruning'];
    arealPruning = json['arealPruning'];
    mechanicalPruning = json['mechanicalPruning'];
    herbicide = json['herbicide'];
    yearSeason = json['yearSeason'];
    mechanicalClearing = json['mechanicalClearing'];
    selectiveMechanicalTreeRemoval = json['selectiveMechanicalTreeRemoval'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pruning'] = pruning;
    data['arealPruning'] = arealPruning;
    data['mechanicalPruning'] = mechanicalPruning;
    data['herbicide'] = herbicide;
    data['yearSeason'] = yearSeason;
    data['mechanicalClearing'] = mechanicalClearing;
    data['selectiveMechanicalTreeRemoval'] =
        selectiveMechanicalTreeRemoval;
    return data;
  }
}
