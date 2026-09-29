class MaintenanceReportViewUpdateModel {
  String? message;

  MaintenanceReportViewUpdateModel({this.message});

  MaintenanceReportViewUpdateModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    return data;
  }
}
