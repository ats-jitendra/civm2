class WorkProgressByMilesModel {
  String? fdr;
  String? maintType;
  double? totalMiles;
  double? completedMiles;
  double? notRequiredMiles;

  WorkProgressByMilesModel({
    this.fdr,
    this.maintType,
    this.totalMiles,
    this.completedMiles,
    this.notRequiredMiles
  });

  WorkProgressByMilesModel.fromJson(Map<String, dynamic> json) {
    fdr = json['fdr'];
    maintType = json['maintType'];
    totalMiles = (json['totalMiles'] as num?)?.toDouble();
    completedMiles = (json['completedMiles'] as num?)?.toDouble();
    notRequiredMiles = (json['notRequiredMiles'] as num?)?.toDouble(); 
  }
}