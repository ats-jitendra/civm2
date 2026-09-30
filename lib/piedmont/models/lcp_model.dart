class LCPModel {
  List<int>? countOfRejectOrder;
  List<int>? countOfCancelledOrder;
  List<int>? countOfPendingOrder;
  List<int>? countOfPendingApprovalOrder;
  List<int>? countOfWorkForApprovalOrder;
  List<int>? countOfInitiatedOrder;
  List<int>? countOfOpenOrder;
  List<int>? countOfCompletedOrder;
  List<int>? countOfCloseOrder;

  LCPModel(
      {this.countOfRejectOrder,
      this.countOfCancelledOrder,
      this.countOfPendingOrder,
      this.countOfPendingApprovalOrder,
      this.countOfWorkForApprovalOrder,
      this.countOfInitiatedOrder,
      this.countOfOpenOrder,
      this.countOfCompletedOrder,
      this.countOfCloseOrder});

  LCPModel.fromJson(Map<String, dynamic> json) {
    countOfRejectOrder = json['countOfRejectOrder'].cast<int>();
    countOfCancelledOrder = json['countOfCancelledOrder'].cast<int>();
    countOfPendingOrder = json['countOfPendingOrder'].cast<int>();
    countOfPendingApprovalOrder =
        json['countOfPendingApprovalOrder'].cast<int>();
    countOfWorkForApprovalOrder =
        json['countOfWorkForApprovalOrder'].cast<int>();
    countOfInitiatedOrder = json['countOfInitiatedOrder'].cast<int>();
    countOfOpenOrder = json['countOfOpenOrder'].cast<int>();
    countOfCompletedOrder = json['countOfCompletedOrder'].cast<int>();
    countOfCloseOrder = json['countOfCloseOrder'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['countOfRejectOrder'] = countOfRejectOrder;
    data['countOfCancelledOrder'] = countOfCancelledOrder;
    data['countOfPendingOrder'] = countOfPendingOrder;
    data['countOfPendingApprovalOrder'] = countOfPendingApprovalOrder;
    data['countOfWorkForApprovalOrder'] = countOfWorkForApprovalOrder;
    data['countOfInitiatedOrder'] = countOfInitiatedOrder;
    data['countOfOpenOrder'] = countOfOpenOrder;
    data['countOfCompletedOrder'] = countOfCompletedOrder;
    data['countOfCloseOrder'] = countOfCloseOrder;
    return data;
  }
}
