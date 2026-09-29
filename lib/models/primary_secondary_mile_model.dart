// class PrimarySecondaryMileModel {
//   String? mileage;
//   String? span;

//   PrimarySecondaryMileModel({
//     this.mileage,
//     this.span,
//   });

//   PrimarySecondaryMileModel.fromJson(Map<String, dynamic> json) {
//     mileage = json["Mileage"];
//     span = json["Span"];
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       "Mileage": mileage,
//       "Span": span,
//     };
//   }
// }

class PrimarySecondaryMileModel {
  String? secondaryMilesTotal;
  String? totalMilesTotal;
  String? totalMilesCompleted;
  String? secondaryMilesCompleted;
  String? primarySpanTotal;
  String? mileage;
  String? span;
  String? secondarySpanTotal;
  String? primaryMilesTotal;
  String? totalSpanCompleted;
  String? secondarySpanCompleted;
  String? primaryMilesCompleted;
  String? totalSpanTotal;
  String? primarySpanCompleted;

  PrimarySecondaryMileModel(
      {this.secondaryMilesTotal,
      this.totalMilesTotal,
      this.totalMilesCompleted,
      this.secondaryMilesCompleted,
      this.primarySpanTotal,
      this.mileage,
      this.span,
      this.secondarySpanTotal,
      this.primaryMilesTotal,
      this.totalSpanCompleted,
      this.secondarySpanCompleted,
      this.primaryMilesCompleted,
      this.totalSpanTotal,
      this.primarySpanCompleted});

  PrimarySecondaryMileModel.fromJson(Map<String, dynamic> json) {
    secondaryMilesTotal = json['secondaryMilesTotal'];
    totalMilesTotal = json['totalMilesTotal'];
    totalMilesCompleted = json['totalMilesCompleted'];
    secondaryMilesCompleted = json['secondaryMilesCompleted'];
    primarySpanTotal = json['primarySpanTotal'];
    mileage = json['Mileage'];
    span = json['Span'];
    secondarySpanTotal = json['secondarySpanTotal'];
    primaryMilesTotal = json['primaryMilesTotal'];
    totalSpanCompleted = json['totalSpanCompleted'];
    secondarySpanCompleted = json['secondarySpanCompleted'];
    primaryMilesCompleted = json['primaryMilesCompleted'];
    totalSpanTotal = json['totalSpanTotal'];
    primarySpanCompleted = json['primarySpanCompleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['secondaryMilesTotal'] = this.secondaryMilesTotal;
    data['totalMilesTotal'] = this.totalMilesTotal;
    data['totalMilesCompleted'] = this.totalMilesCompleted;
    data['secondaryMilesCompleted'] = this.secondaryMilesCompleted;
    data['primarySpanTotal'] = this.primarySpanTotal;
    data['Mileage'] = this.mileage;
    data['Span'] = this.span;
    data['secondarySpanTotal'] = this.secondarySpanTotal;
    data['primaryMilesTotal'] = this.primaryMilesTotal;
    data['totalSpanCompleted'] = this.totalSpanCompleted;
    data['secondarySpanCompleted'] = this.secondarySpanCompleted;
    data['primaryMilesCompleted'] = this.primaryMilesCompleted;
    data['totalSpanTotal'] = this.totalSpanTotal;
    data['primarySpanCompleted'] = this.primarySpanCompleted;
    return data;
  }
  
}
