class LogModel {
  final String performedByName;
  final String performedAt;
  final String action;
  final String description;
  final int tokenNo;

  LogModel({
    required this.performedByName,
    required this.performedAt,
    required this.action,
    required this.description,
    required this.tokenNo,
  });

  factory LogModel.fromJson(Map<String, dynamic> json) {
    return LogModel(
      performedByName: json['performedByName'] ?? '',
      performedAt: json['performedAt'] ?? '',
      action: json['action'] ?? '',
      description: json['description'] ?? '',
      tokenNo: json['token'] ?? 0,
    );
  }
}