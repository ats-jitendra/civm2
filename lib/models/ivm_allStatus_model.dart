class IvmAllStatusModel {
  List<FindAllTableData>? findAllTableData;

  IvmAllStatusModel({this.findAllTableData});

  IvmAllStatusModel.fromJson(Map<String, dynamic> json) {
    if (json['findAllTableData'] != null) {
      findAllTableData = (json['findAllTableData'] as List)
          .map((e) => FindAllTableData.fromJson(e))
          .toList();
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'findAllTableData':
          findAllTableData?.map((e) => e.toJson()).toList(),
    };
  }
}

class FindAllTableData {
  String? plannerNotes;
  String? contractYear;
  double? costPerMile;
  String? dateOfInspection;
  String? county;
  String? approvedBy;
  String? actionNeeded;
  bool? mixingInventory;
  String? type;
  String? adminNotes1;
  String? growthScore;
  int? rowYear;
  String? documentUpload;
  String? dueMonth;
  double? milesInProgress;
  String? maintType;
  String? substation;
  String? contractorNotes;
  int? id;
  double? budget;
  String? lastMaintDone;
  String? contractorCompany;
  double? milesPending;
  String? supervisorNotes;
  String? maintCount;
  String? crewName;
  String? contractEndYear;
  String? followUpDate;
  String? district;
  String? changeOrderImage;
  String? workPriority;
  String? supervisor;
  double? totalCost;
  String? status;
  String? invoiceCreated;
  String? contractor;
  String? budgetType;
  double? milesCompleted;
  String? dueWeek;
  String? growthRate;
  String? tokenNo;
  String? nextMaintDue;
  int? cycle;
  String? maintDateHistory;
  bool? dailyHerbicide;
  String? addChatNotes;
  String? crew;
  int? substationId;
  String? tblVmaNewMaintenancePlanId;
  String? fdrName;
  String? initiatedBy;
  String? createDate;
  double? actualCost;
  String? planType;
  double? estCost;
  String? treeType;
  double? totalMiles;
  String? estTime;
  String? adminNotes2;
  bool? ivmTimesheet;
  String? createdBy;
  String? streetAddress;
  String? mapLocation;
  String? masterJobNo;
  String? note;

  FindAllTableData.fromJson(Map<String, dynamic> json) {
    plannerNotes = _toString(json['plannerNotes']);
    contractYear = _toString(json['contractYear']);
    costPerMile = _toDouble(json['costPerMile']);
    dateOfInspection = _toString(json['dateOfInspection']);
    county = _toString(json['county']);
    approvedBy = _toString(json['approvedBy']);
    actionNeeded = _toString(json['actionNeeded']);
    mixingInventory = _toBool(json['mixingInventory']);
    type = _toString(json['type']);
    adminNotes1 = _toString(json['adminNotes1']);
    growthScore = _toString(json['growthScore']);
    rowYear = _toInt(json['rowYear']);
    documentUpload = _toString(json['documentUpload']);
    dueMonth = _toString(json['dueMonth']);
    milesInProgress = _toDouble(json['milesInProgress']);
    maintType = _toString(json['maintType']);
    substation = _toString(json['substation']);
    contractorNotes = _toString(json['contractorNotes']);
    id = _toInt(json['id']);
    budget = _toDouble(json['budget']);
    lastMaintDone = _toString(json['lastMaintDone']);
    contractorCompany = _toString(json['contractorCompany']);
    milesPending = _toDouble(json['milesPending']);
    supervisorNotes = _toString(json['supervisorNotes']);
    maintCount = _toString(json['maintCount']);
    crewName = _toString(json['crewName']);
    contractEndYear = _toString(json['contractEndYear']);
    followUpDate = _toString(json['followUpDate']);
    district = _toString(json['district']);
    changeOrderImage = _toString(json['changeOrderImage']);
    workPriority = _toString(json['workPriority']);
    supervisor = _toString(json['supervisor']);
    totalCost = _toDouble(json['totalCost']);
    status = _toString(json['status']);
    invoiceCreated = _toString(json['invoiceCreated']);
    contractor = _toString(json['contractor']);
    budgetType = _toString(json['budgetType']);
    milesCompleted = _toDouble(json['milesCompleted']);
    dueWeek = _toString(json['dueWeek']);
    growthRate = _toString(json['growthRate']);
    tokenNo = _toString(json['tokenNo']);
    nextMaintDue = _toString(json['nextMaintDue']);
    cycle = _toInt(json['cycle']);
    maintDateHistory = _toString(json['maintDateHistory']);
    dailyHerbicide = _toBool(json['dailyHerbicide']);
    addChatNotes = _toString(json['addChatNotes']);
    crew = _toString(json['crew']);
    substationId = _toInt(json['substationId']);
    tblVmaNewMaintenancePlanId =
        _toString(json['tblVmaNewMaintenancePlanId']);
    fdrName = _toString(json['fdrName']);
    initiatedBy = _toString(json['initiatedBy']);
    createDate = _toString(json['createDate']);
    actualCost = _toDouble(json['actualCost']);
    planType = _toString(json['planType']);
    estCost = _toDouble(json['estCost']);
    treeType = _toString(json['treeType']);
    totalMiles = _toDouble(json['totalMiles']);
    estTime = _toString(json['estTime']);
    adminNotes2 = _toString(json['adminNotes2']);
    ivmTimesheet = _toBool(json['ivmTimesheet']);
    createdBy = _toString(json['createdBy']);
    streetAddress = _toString(json['streetAddress']);
    mapLocation = _toString(json['mapLocation']);
    masterJobNo = _toString(json['masterJobNo']);
    note = _toString(json['note']);
  }

  Map<String, dynamic> toJson() {
    return {
      'plannerNotes': plannerNotes,
      'contractYear': contractYear,
      'costPerMile': costPerMile,
      'mixingInventory': mixingInventory,
      'rowYear': rowYear,
      'milesInProgress': milesInProgress,
      'id': id,
      'budget': budget,
      'milesPending': milesPending,
      'totalCost': totalCost,
      'milesCompleted': milesCompleted,
      'cycle': cycle,
      'dailyHerbicide': dailyHerbicide,
      'substationId': substationId,
      'actualCost': actualCost,
      'estCost': estCost,
      'totalMiles': totalMiles,
      'ivmTimesheet': ivmTimesheet,
      'masterJobNo': masterJobNo,
      'note': note
    };
  }

  /// 🔧 Helpers (THIS FIXES YOUR CRASH)
  String? _toString(dynamic value) =>
      value == null ? null : value.toString();

  int? _toInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    return int.tryParse(value.toString());
  }

  double? _toDouble(dynamic value) {
    if (value == null) return null;
    if (value is double) return value;
    return double.tryParse(value.toString());
  }

  bool? _toBool(dynamic value) {
    if (value == null) return null;
    if (value is bool) return value;
    return value.toString().toLowerCase() == 'true';
  }
}