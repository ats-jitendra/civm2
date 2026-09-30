class RowMaintenancePlanTabNewModel {
  int? id;
  String? totalMiles;
  double? costPerMile;
  double? totalCost;
  double? budget;
  String? cycle;
  String? nextMaintDue;
  String? supervisorId;
  String? status;
  String? contractorCompany;

  RowMaintenancePlanTabNewModel(
      this.id,
      this.totalMiles,
      this.costPerMile,
      this.totalCost,
      this.budget,
      this.cycle,
      this.nextMaintDue,
      this.supervisorId,
      this.status,
      this.contractorCompany);
}
