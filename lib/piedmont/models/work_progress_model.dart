class WorkProgressModel {
  final String? fdr;
  final String maintType;
  final int totalSpans;
  final int completedSpans;
  final int notRequiredSpans;

  WorkProgressModel({
    this.fdr,
    required this.maintType,
    required this.totalSpans,
    required this.completedSpans,
    required this.notRequiredSpans,
  });

  factory WorkProgressModel.fromJson(Map<String, dynamic> json) {
    return WorkProgressModel(
      fdr: json['fdr']?.toString(),
      maintType: json['maintType']?.toString() ?? '',
      totalSpans: (json['totalSpans'] ?? 0).toInt(),
      completedSpans: (json['completedSpans'] ?? 0).toInt(),
      notRequiredSpans: (json['notRequiredSpans'] ?? 0).toInt(),
    );
  }
}