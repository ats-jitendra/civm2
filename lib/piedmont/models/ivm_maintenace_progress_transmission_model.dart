/// MAIN MODEL
class MileageModel {
  final String name;

  final double totalMiles;

  /// KEY = DATE
  /// VALUE = MILES
  final Map<String, dynamic> weeks;

  MileageModel({
    required this.name,
    required this.totalMiles,
    required this.weeks,
  });

  factory MileageModel.fromJson(Map<String, dynamic> json) {
    /// CONVERT TransmissionIVMWeeklyMiles LIST TO MAP
    Map<String, dynamic> weekMap = {};

    if (json['TransmissionIVMWeeklyMiles'] != null) {
      for (var item in json['TransmissionIVMWeeklyMiles']) {
        weekMap[item['WeekEnding']] = item['Miles'];
      }
    }

    return MileageModel(
      name: json['Name'] ?? '',
      totalMiles: (json['TotalMiles'] ?? 0).toDouble(),
      weeks: weekMap,
    );
  }
}

class YearlyMilesModel {
  final String subFdr;
  final double totalMiles;
  final String year;
  final double milesCompleted;
  final double milesPending;
  final double cost;

  YearlyMilesModel({
    required this.subFdr,
    required this.totalMiles,
    required this.year,
    required this.milesCompleted,
    required this.milesPending,
    required this.cost,
  });

  factory YearlyMilesModel.fromJson(Map<String, dynamic> json) {
    return YearlyMilesModel(
      subFdr: json['SUB_FDR'] ?? '',
      totalMiles: (json['TOTALMILES'] ?? 0).toDouble(),
      year: json['YEAR']?.toString() ?? '',
      milesCompleted: (json['MILES_COMPLETED'] ?? 0).toDouble(),
      milesPending: (json['MILES_PENDING'] ?? 0).toDouble(),
      cost: (json['COST'] ?? 0).toDouble(),
    );
  }
}

////////////
class DurationGraphModel {
  final String subFdr;
  final double totalMiles;
  final String year;
  final String? month;
  final String? weekDate;
  final double milesCompleted;
  final double milesPending;
  final double cost;
  DurationGraphModel({
    required this.subFdr,
    required this.totalMiles,
    required this.year,
    this.month,
    this.weekDate,
    required this.milesCompleted,
    required this.milesPending,
    required this.cost,
  });

  factory DurationGraphModel.fromJson(Map<String, dynamic> json) {
    return DurationGraphModel(
      subFdr: json['SUB_FDR'] ?? '',
      totalMiles: double.tryParse(json['TOTALMILES'].toString()) ?? 0,
      year: json['YEAR']?.toString() ?? '',
      month: json['MNTH']?.toString(),
      weekDate: json['WEEK_DATE']?.toString(),
      milesCompleted: double.tryParse(json['MILES_COMPLETED'].toString()) ?? 0,
      milesPending: double.tryParse(json['MILES_PENDING'].toString()) ?? 0,
      cost: double.tryParse(json['COST'].toString()) ?? 0,
    );
  }
}

//////
class PieChartModel {
  final String title;
  final double value;
  final double percentage;
  final double miles;

  PieChartModel({
    required this.title,
    required this.value,
    required this.percentage,
    required this.miles,
  });
}
///////////

/////
class CrewMilesModel {
  final String crew;
  final double milesCompleted;
  final double milesInProgress;

  CrewMilesModel({
    required this.crew,
    required this.milesCompleted,
    required this.milesInProgress,
  });

  factory CrewMilesModel.fromJson(Map<String, dynamic> json) {
    return CrewMilesModel(
      crew: json['crew'] ?? '',
      milesCompleted: (json['milesCompleted'] ?? 0).toDouble(),
      milesInProgress: (json['milesInProgress'] ?? 0).toDouble(),
    );
  }
}
