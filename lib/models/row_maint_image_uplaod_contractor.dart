class RowMaintenanceImageUploadContractorModel {
  List<String>? fileName;
  String? message;

  RowMaintenanceImageUploadContractorModel({this.fileName, this.message});

  RowMaintenanceImageUploadContractorModel.fromJson(Map<String, dynamic> json) {
    fileName = json['fileName'].cast<String>();
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fileName'] = fileName;
    data['message'] = message;
    return data;
  }
}
