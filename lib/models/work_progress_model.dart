class WorkProgressModel {
  final int primaryCompleted;
  final int secondaryCompleted;
  final int completedSpans;
  final String fdr;
  final String maintType;
  final int primarySpans;
  final int secondarySpans;
  final int totalSpans;

  WorkProgressModel({
    required this.primaryCompleted,
    required this.secondaryCompleted,
    required this.completedSpans,
    required this.fdr,
    required this.maintType,
    required this.primarySpans,
    required this.secondarySpans,
    required this.totalSpans,
  });

  factory WorkProgressModel.fromJson(Map<String, dynamic> json) {
    return WorkProgressModel(
      primaryCompleted: json['primaryCompleted'] ?? 0,
      secondaryCompleted: json['secondaryCompleted'] ?? 0,
      completedSpans: json['completedSpans'] ?? 0,
      fdr: json['fdr'] ?? '',
      maintType: json['maintType'] ?? '',
      primarySpans: json['primarySpans'] ?? 0,
      secondarySpans: json['secondarySpans'] ?? 0,
      totalSpans: json['totalSpans'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "primaryCompleted": primaryCompleted,
      "secondaryCompleted": secondaryCompleted,
      "completedSpans": completedSpans,
      "fdr": fdr,
      "maintType": maintType,
      "primarySpans": primarySpans,
      "secondarySpans": secondarySpans,
      "totalSpans": totalSpans,
    };
  }
}


// class WorkProgressModel {
//   final int completedSpans;
//   final String fdr;
//   final String maintType;
//   final int totalSpans;

//   WorkProgressModel({
//     required this.completedSpans,
//     required this.fdr,
//     required this.maintType,
//     required this.totalSpans,
//   });

//   factory WorkProgressModel.fromJson(Map<String, dynamic> json) {
//     return WorkProgressModel(
//       completedSpans: json['completedSpans'],
//       fdr: json['fdr'],
//       maintType: json['maintType'],
//       totalSpans: json['totalSpans'],
//     );
//   }
// }