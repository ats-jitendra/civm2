class IvmChangeOrderCountGFModel {
  int? changeOrderCount;
  String? note;
  int? rejectedIvmCount;
  int? changeOrderPendingZieliesApprovalCount;
  int? changeOrderPendingZieliesAssignmentCount;
  int? pendingIvmCount;
  int? changeOrderAssignedCount;
  int? changeOrderPendingLCPInspectionCount;
  int? lcpInspectionIvmCount;
  int? completedIvmCount;
  int? changeOrderCompletedCount;
  int? changeOrderPendingLCPApprovalCount;
  int? ivmCount;
  int? assignmentIvmCount;
  int? finalCompleted;
  int? pendingZieliesApproval;
  int? reworkRejected;
  int? changeOrderPendingApprovalCount;
  int? changeOrderCancelledCount;
  int? lcpInspectionFailed;
  int? ivmAssignedCount;
  bool? status;

  IvmChangeOrderCountGFModel(
      {this.changeOrderCount,
      this.note,
      this.rejectedIvmCount,
      this.changeOrderPendingZieliesApprovalCount,
      this.changeOrderPendingZieliesAssignmentCount,
      this.pendingIvmCount,
      this.changeOrderAssignedCount,
      this.changeOrderPendingLCPInspectionCount,
      this.lcpInspectionIvmCount,
      this.completedIvmCount,
      this.changeOrderCompletedCount,
      this.changeOrderPendingLCPApprovalCount,
      this.ivmCount,
      this.assignmentIvmCount,
      this.finalCompleted,
      this.pendingZieliesApproval,
      this.reworkRejected,
      this.changeOrderPendingApprovalCount,
      this.changeOrderCancelledCount,
      this.lcpInspectionFailed,
      this.ivmAssignedCount,
      this.status});

  IvmChangeOrderCountGFModel.fromJson(Map<String, dynamic> json) {
    changeOrderCount = json['changeOrderCount'];
    note = json['note'];
    rejectedIvmCount = json['rejectedIvmCount'];
    changeOrderPendingZieliesApprovalCount =
        json['changeOrderPendingZieliesApprovalCount'];
    changeOrderPendingZieliesAssignmentCount =
        json['changeOrderPendingZieliesAssignmentCount'];
    pendingIvmCount = json['pendingIvmCount'];
    changeOrderAssignedCount = json['changeOrderAssignedCount'];
    changeOrderPendingLCPInspectionCount =
        json['changeOrderPendingLCPInspectionCount'];
    lcpInspectionIvmCount = json['lcpInspectionIvmCount'];
    completedIvmCount = json['completedIvmCount'];
    changeOrderCompletedCount = json['changeOrderCompletedCount'];
    changeOrderPendingLCPApprovalCount =
        json['changeOrderPendingLCPApprovalCount'];
    ivmCount = json['ivmCount'];
    assignmentIvmCount = json['assignmentIvmCount'];
    finalCompleted = json['finalCompleted'];
    pendingZieliesApproval = json['pendingZieliesApproval'];
    reworkRejected = json['reworkRejected'];
    changeOrderPendingApprovalCount = json['changeOrderPendingApprovalCount'];
    changeOrderCancelledCount = json['changeOrderCancelledCount'];
    lcpInspectionFailed = json['lcpInspectionFailed'];
    ivmAssignedCount = json['ivmAssignedCount'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['changeOrderCount'] = changeOrderCount;
    data['note'] = note;
    data['rejectedIvmCount'] = rejectedIvmCount;
    data['changeOrderPendingZieliesApprovalCount'] =
        changeOrderPendingZieliesApprovalCount;
    data['changeOrderPendingZieliesAssignmentCount'] =
        changeOrderPendingZieliesAssignmentCount;
    data['pendingIvmCount'] = pendingIvmCount;
    data['changeOrderAssignedCount'] = changeOrderAssignedCount;
    data['changeOrderPendingLCPInspectionCount'] =
        changeOrderPendingLCPInspectionCount;
    data['lcpInspectionIvmCount'] = lcpInspectionIvmCount;
    data['completedIvmCount'] = completedIvmCount;
    data['changeOrderCompletedCount'] = changeOrderCompletedCount;
    data['changeOrderPendingLCPApprovalCount'] =
        changeOrderPendingLCPApprovalCount;
    data['ivmCount'] = ivmCount;
    data['assignmentIvmCount'] = assignmentIvmCount;
    data['finalCompleted'] = finalCompleted;
    data['pendingZieliesApproval'] = pendingZieliesApproval;
    data['reworkRejected'] = reworkRejected;
    data['changeOrderPendingApprovalCount'] =
        changeOrderPendingApprovalCount;
    data['changeOrderCancelledCount'] = changeOrderCancelledCount;
    data['lcpInspectionFailed'] = lcpInspectionFailed;
    data['ivmAssignedCount'] = ivmAssignedCount;
    data['status'] = status;
    return data;
  }
}
