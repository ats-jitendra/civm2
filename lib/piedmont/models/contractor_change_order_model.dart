class ContractorChangeOrderModel {
  int? countOfRejectOrder;
  int? countOfPendingOrder;
  int? countOfPendingApprovalOrder;
  int? countOfOpenOrder;
  int? countOfCloseOrder;

  ContractorChangeOrderModel(
      {this.countOfRejectOrder,
      this.countOfPendingOrder,
      this.countOfPendingApprovalOrder,
      this.countOfOpenOrder,
      this.countOfCloseOrder});

  ContractorChangeOrderModel.fromJson(Map<String, dynamic> json) {
    countOfRejectOrder = json['countOfRejectOrder'];
    countOfPendingOrder = json['countOfPendingOrder'];
    countOfPendingApprovalOrder = json['countOfPendingApprovalOrder'];
    countOfOpenOrder = json['countOfOpenOrder'];
    countOfCloseOrder = json['countOfCloseOrder'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['countOfRejectOrder'] = countOfRejectOrder;
    data['countOfPendingOrder'] = countOfPendingOrder;
    data['countOfPendingApprovalOrder'] = countOfPendingApprovalOrder;
    data['countOfOpenOrder'] = countOfOpenOrder;
    data['countOfCloseOrder'] = countOfCloseOrder;
    return data;
  }
}
