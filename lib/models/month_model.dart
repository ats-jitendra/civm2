class MonthModel {
  String? month;

  MonthModel({this.month});

  MonthModel.fromJson(Map<String, dynamic> json) {
    month = json['month'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['month'] = month;
    return data;
  }
}
