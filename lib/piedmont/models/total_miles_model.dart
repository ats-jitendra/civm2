class TotalWorkProgressModel {
  final double totalMiles;
  final double completedMiles;
  final double notRequiredMiles;
  final double pendingMiles;
  final double completedPercent;

  TotalWorkProgressModel({
    required this.totalMiles,
    required this.completedMiles,
    required this.notRequiredMiles,
    required this.pendingMiles,
    required this.completedPercent,
  });

  factory TotalWorkProgressModel.fromJson(Map<String, dynamic> json) {
    return TotalWorkProgressModel(
      totalMiles: (json['totalMiles'] ?? 0).toDouble(),
      completedMiles: (json['completedMiles'] ?? 0).toDouble(),
      notRequiredMiles: (json['notRequiredMiles'] ?? 0).toDouble(),
      pendingMiles: (json['pendingMiles'] ?? 0).toDouble(),
      completedPercent: (json['completedPercent'] ?? 0).toDouble(),
    );
  }
}