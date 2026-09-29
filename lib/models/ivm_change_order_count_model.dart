class IvmChangeOrderCountModel {
  final int ivmCount;
  final int changeOrderCount;
  final bool status;
  String? note;

  IvmChangeOrderCountModel({
    required this.ivmCount,
    required this.changeOrderCount,
    required this.status,
    required this.note,
  });

  factory IvmChangeOrderCountModel.fromJson(Map<String, dynamic> json) {
    return IvmChangeOrderCountModel(
      ivmCount: json["count"] ?? 0,
      changeOrderCount: json["changeOrderCount"] ?? 0,
      status: json["status"] ?? false,
      note: json["note"] ?? '',
    );
  }
}