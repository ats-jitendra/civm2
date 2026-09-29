class IVMMaintenanceProgressDashboardModel {
  int? currentYear;
  List<String>? years;
  List<DropdownItem>? substations;
  List<DropdownItem>? feeders;
  StatusData? status;
  List<MaintenanceType>? types;
  List<CrewData>? crews;
  List<MonthData>? months;
  bool? success;

  IVMMaintenanceProgressDashboardModel({
    this.currentYear,
    this.years,
    this.substations,
    this.feeders,
    this.status,
    this.types,
    this.crews,
    this.months,
    this.success,
  });

  IVMMaintenanceProgressDashboardModel.fromJson(Map<String, dynamic> json) {
    currentYear = json['currentYear'];
    years = json['years'] != null ? List<String>.from(json['years']) : [];

    if (json['substations'] != null) {
      substations = <DropdownItem>[];
      json['substations'].forEach((v) {
        substations!.add(DropdownItem.fromJson(v));
      });
    }

    if (json['feeders'] != null) {
      feeders = <DropdownItem>[];
      json['feeders'].forEach((v) {
        feeders!.add(DropdownItem.fromJson(v));
      });
    }

    status =
        json['status'] != null ? StatusData.fromJson(json['status']) : null;

    if (json['types'] != null) {
      types = <MaintenanceType>[];
      json['types'].forEach((v) {
        types!.add(MaintenanceType.fromJson(v));
      });
    }

    if (json['crews'] != null) {
      crews = <CrewData>[];
      json['crews'].forEach((v) {
        crews!.add(CrewData.fromJson(v));
      });
    }

    if (json['months'] != null) {
      months = <MonthData>[];
      json['months'].forEach((v) {
        months!.add(MonthData.fromJson(v));
      });
    }

    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    data['currentYear'] = currentYear;
    data['years'] = years;
    data['substations'] = substations?.map((e) => e.toJson()).toList();
    data['feeders'] = feeders?.map((e) => e.toJson()).toList();
    data['status'] = status?.toJson();
    data['types'] = types?.map((e) => e.toJson()).toList();
    data['crews'] = crews?.map((e) => e.toJson()).toList();
    data['months'] = months?.map((e) => e.toJson()).toList();
    data['success'] = success;

    return data;
  }
}

class DropdownItem {
  String? id;
  String? name;

  DropdownItem({this.id, this.name});

  DropdownItem.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}

class StatusData {
  int? workOrders;
  double? totalMiles;
  double? completedMiles;
  double? inProgressMiles;
  double? pendingMiles;
  double? completedPct;
  double? inProgressPct;
  double? pendingPct;

  StatusData({
    this.workOrders,
    this.totalMiles,
    this.completedMiles,
    this.inProgressMiles,
    this.pendingMiles,
    this.completedPct,
    this.inProgressPct,
    this.pendingPct,
  });

  StatusData.fromJson(Map<String, dynamic> json) {
    workOrders = json['workOrders'];
    totalMiles = (json['totalMiles'] ?? 0).toDouble();
    completedMiles = (json['completedMiles'] ?? 0).toDouble();
    inProgressMiles = (json['inProgressMiles'] ?? 0).toDouble();
    pendingMiles = (json['pendingMiles'] ?? 0).toDouble();
    completedPct = (json['completedPct'] ?? 0).toDouble();
    inProgressPct = (json['inProgressPct'] ?? 0).toDouble();
    pendingPct = (json['pendingPct'] ?? 0).toDouble();
  }

  Map<String, dynamic> toJson() {
    return {
      'workOrders': workOrders,
      'totalMiles': totalMiles,
      'completedMiles': completedMiles,
      'inProgressMiles': inProgressMiles,
      'pendingMiles': pendingMiles,
      'completedPct': completedPct,
      'inProgressPct': inProgressPct,
      'pendingPct': pendingPct,
    };
  }
}

class MaintenanceType {
  String? maintType;
  double? totalMiles;
  double? completedMiles;
  double? pendingMiles;
  double? percent;
  String? color;

  MaintenanceType({
    this.maintType,
    this.totalMiles,
    this.completedMiles,
    this.pendingMiles,
    this.percent,
    this.color,
  });

  MaintenanceType.fromJson(Map<String, dynamic> json) {
    maintType = json['maintType'];
    totalMiles = (json['totalMiles'] ?? 0).toDouble();
    completedMiles = (json['completedMiles'] ?? 0).toDouble();
    pendingMiles = (json['pendingMiles'] ?? 0).toDouble();
    percent = (json['percent'] ?? 0).toDouble();
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    return {
      'maintType': maintType,
      'totalMiles': totalMiles,
      'completedMiles': completedMiles,
      'pendingMiles': pendingMiles,
      'percent': percent,
      'color': color,
    };
  }
}

class CrewData {
  String? name;
  double? completedMiles;
  double? pendingMiles;
  double? percent;

  CrewData({
    this.name,
    this.completedMiles,
    this.pendingMiles,
    this.percent,
  });

  CrewData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    completedMiles = (json['completedMiles'] ?? 0).toDouble();
    pendingMiles = (json['pendingMiles'] ?? 0).toDouble();
    percent = (json['percent'] ?? 0).toDouble();
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'completedMiles': completedMiles,
      'pendingMiles': pendingMiles,
      'percent': percent,
    };
  }
}

class MonthData {
  String? monthName;
  double? plannedMiles;
  double? completedMiles;
  double? pendingMiles;
  double? percent;

  MonthData({
    this.monthName,
    this.plannedMiles,
    this.completedMiles,
    this.pendingMiles,
    this.percent,
  });

  MonthData.fromJson(Map<String, dynamic> json) {
    monthName = json['monthName'];
    plannedMiles = (json['plannedMiles'] ?? 0).toDouble();
    completedMiles = (json['completedMiles'] ?? 0).toDouble();
    pendingMiles = (json['pendingMiles'] ?? 0).toDouble();
    percent = (json['percent'] ?? 0).toDouble();
  }

  Map<String, dynamic> toJson() {
    return {
      'monthName': monthName,
      'plannedMiles': plannedMiles,
      'completedMiles': completedMiles,
      'pendingMiles': pendingMiles,
      'percent': percent,
    };
  }
}