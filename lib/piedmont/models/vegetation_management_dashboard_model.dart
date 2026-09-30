

class VegetationManagementDashboardModel {
  // int? getRegularIVMMaintenanceCount;
  // int? getMidCycleHerbicideCount;
  // int? midCycleRejectedCount;
  // int? getOpenOrderCount;
  // int? iVMRejectedCount;
  // int? mOWING;
  // int? jARAFFMOWINGSPRAYWORK;
  // int? getChangeOrdercount;
  // int? getRowMainSUBSTATIONCount;
  // int? mOWINGNOSPRAY;
  // int? getRejectedOrderCount;
  // int? getPendingOrderCount;
  // int? jARAFFMOWINGNOSPRAY;
  // int? changeOrderClosedCount;
  // int? iVMClosedCount;
  // int? getChangeOrderSUBSTATIONCount;
  // int? gROUNDWORK;
  // int? getChangeOrderWFACount;
  // int? getbucketWorkCount;
  int? workOrderInspectionPending;
  int? workOrderInProgress;
  int? workOrderRejected;
  int? workOrderCompleted;
  int? distributionReadyForInspection;
  int? distributionInProgress;
  int? distributionRejected;
  int? distributionCompleted;
  int? distributionOpen;
  List<GetSPGETPERCENTAGEAll>? getSPGETPERCENTAGEAll;
  // int? changeOrderPendingCount;
  // int? changeOrderRejectedCount;
  // int? iVMPendingCount;
  // int? getPendingApprovalOrderCount;
  // int? midCycleClosedCount;
  // int? sPRAY;
  // List<SubstationList>? substationList;
  // int? getClosedOrderCount;
  // List<MonthList>? monthList;
  // int? midCyclePendingCount;
  //

  int? serviceOrderOpen;
  int? serviceOrderInProgress;
  int? serviceOrderReadyforReview;
  int? serviceOrderClosed;
  int? transmissionIVMReadyForInspection;
  int? transmissionIVMInProgress;
  int? transmissionIVMRejected;
  int? transmissionIVMClosed;
  int? transmissionHerbicideReadyForInspection;
  int? transmissionHerbicideInProgress;
  int? transmissionHerbicideRejected;
  int? transmissionHerbicideClosed;
  int? annualHerbicideReadyForInspection;
  int? annualHerbicideInProgress;
  int? annualHerbicideRejected;
    int? annualHerbicideClosed;

  VegetationManagementDashboardModel({
    // this.getRegularIVMMaintenanceCount,
    // this.getMidCycleHerbicideCount,
    // this.midCycleRejectedCount,
    // this.getOpenOrderCount,
    // this.iVMRejectedCount,
    // this.mOWING,
    // this.jARAFFMOWINGSPRAYWORK,
    // this.getChangeOrdercount,
    // this.getRowMainSUBSTATIONCount,
    // this.mOWINGNOSPRAY,
    // this.getRejectedOrderCount,
    // this.getPendingOrderCount,
    // this.jARAFFMOWINGNOSPRAY,
    // this.changeOrderClosedCount,
    // this.iVMClosedCount,
    // this.getChangeOrderSUBSTATIONCount,
    // this.gROUNDWORK,
    // this.getChangeOrderWFACount,
    // this.getbucketWorkCount,
    this.workOrderInspectionPending,
    this.workOrderInProgress,
    this.workOrderRejected,
    this.workOrderCompleted,
    this.distributionReadyForInspection,
    this.distributionInProgress,
    this.distributionRejected,
    this.distributionCompleted,
    this.distributionOpen,
    this.getSPGETPERCENTAGEAll,
    // this.changeOrderPendingCount,
    // this.changeOrderRejectedCount,
    // this.iVMPendingCount,
    // this.getPendingApprovalOrderCount,
    // this.midCycleClosedCount,
    // this.sPRAY,
    // this.substationList,
    // this.getClosedOrderCount,
    // this.monthList,
    // this.midCyclePendingCount,
    this.serviceOrderOpen,
    this.serviceOrderInProgress,
    this.serviceOrderReadyforReview,
    this.serviceOrderClosed,
     this.transmissionIVMReadyForInspection,
      this.transmissionIVMInProgress,
      this.transmissionIVMRejected,
      this.transmissionIVMClosed,
      this.transmissionHerbicideReadyForInspection,
      this.transmissionHerbicideInProgress,
      this.transmissionHerbicideRejected,
      this.transmissionHerbicideClosed,
      this.annualHerbicideReadyForInspection,
      this.annualHerbicideInProgress,
      this.annualHerbicideRejected,
      this.annualHerbicideClosed,
  });

  VegetationManagementDashboardModel.fromJson(Map<String, dynamic> json) {
    // getRegularIVMMaintenanceCount = json['getRegularIVMMaintenanceCount'];
    // getMidCycleHerbicideCount = json['getMidCycleHerbicideCount'];
    // midCycleRejectedCount = json['MidCycleRejectedCount'];
    // getOpenOrderCount = json['getOpenOrderCount'];
    // iVMRejectedCount = json['IVMRejectedCount'];
    // mOWING = json['MOWING'];
    // jARAFFMOWINGSPRAYWORK = json['JARAFF_MOWING_SPRAY_WORK'];
    // getChangeOrdercount = json['getChangeOrdercount'];
    // getRowMainSUBSTATIONCount = json['getRowMainSUBSTATIONCount'];
    // mOWINGNOSPRAY = json['MOWING_NOSPRAY'];
    // getRejectedOrderCount = json['getRejectedOrderCount'];
    // getPendingOrderCount = json['getPendingOrderCount'];
    // jARAFFMOWINGNOSPRAY = json['JARAFF_MOWING_NO_SPRAY'];
    // changeOrderClosedCount = json['ChangeOrderClosedCount'];
    // iVMClosedCount = json['IVMClosedCount'];
    // getChangeOrderSUBSTATIONCount = json['getChangeOrder_SUBSTATIONCount'];
    // gROUNDWORK = json['GROUND_WORK'];
    // getChangeOrderWFACount = json['getChangeOrderWFACount'];
    // getbucketWorkCount = json['getbucketWorkCount'];
    workOrderInspectionPending = json['work_order_inspection_pending'];
    workOrderInProgress = json['work_order_inProgress'];
    workOrderRejected = json['work_order_rejected'];
    workOrderCompleted = json['work_order_completed'];
    distributionReadyForInspection = json['distribution_ready_for_inspection'];
    distributionInProgress = json['distribution_In_Progress'];
    distributionRejected = json['distribution_rejected'];
    distributionCompleted = json['distribution_completed'];
    distributionOpen = json['distribution_Open'];
    if (json['getSP_GET_PERCENTAGEAll'] != null) {
      getSPGETPERCENTAGEAll = <GetSPGETPERCENTAGEAll>[];
      json['getSP_GET_PERCENTAGEAll'].forEach((v) {
        getSPGETPERCENTAGEAll!.add(GetSPGETPERCENTAGEAll.fromJson(v));
      });
    }
    // changeOrderPendingCount = json['ChangeOrderPendingCount'];
    // changeOrderRejectedCount = json['ChangeOrderRejectedCount'];
    // iVMPendingCount = json['IVMPendingCount'];
    // getPendingApprovalOrderCount = json['getPendingApprovalOrderCount'];
    // midCycleClosedCount = json['MidCycleClosedCount'];
    // sPRAY = json['SPRAY'];
    // if (json['substationList'] != null) {
    //   substationList = <SubstationList>[];
    //   json['substationList'].forEach((v) {
    //     substationList!.add(SubstationList.fromJson(v));
    //   });
    // }
    // getClosedOrderCount = json['getClosedOrderCount'];
    // if (json['monthList'] != null) {
    //   monthList = <MonthList>[];
    //   json['monthList'].forEach((v) {
    //     monthList!.add(MonthList.fromJson(v));
    //   });
    // }
    // midCyclePendingCount = json['MidCyclePendingCount'];
    serviceOrderOpen = json['service_order_open'];
    serviceOrderInProgress = json['service_order_inProgress'];
    serviceOrderReadyforReview = json['service_order_readyfor_review'];
    serviceOrderClosed = json['service_order_closed'];
     transmissionIVMReadyForInspection =
        json['transmissionIVM_ready_for_inspection'];
    transmissionIVMInProgress = json['transmissionIVM_In_Progress'];
    transmissionIVMRejected = json['transmissionIVM_rejected'];
    transmissionIVMClosed = json['transmissionIVM_closed'];
    transmissionHerbicideReadyForInspection =
        json['transmissionHerbicide_ready_for_inspection'];
    transmissionHerbicideInProgress = json['transmissionHerbicide_In_Progress'];
    transmissionHerbicideRejected = json['transmissionHerbicide_rejected'];
    transmissionHerbicideClosed = json['transmissionHerbicide_closed'];
    annualHerbicideReadyForInspection =
        json['annualHerbicide_ready_for_inspection'];
    annualHerbicideInProgress = json['annualHerbicide_In_Progress'];
    annualHerbicideRejected = json['annualHerbicide_rejected'];
    annualHerbicideClosed = json['annualHerbicide_closed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // data['getRegularIVMMaintenanceCount'] = getRegularIVMMaintenanceCount;
    // data['getMidCycleHerbicideCount'] = getMidCycleHerbicideCount;
    // data['MidCycleRejectedCount'] = midCycleRejectedCount;
    // data['getOpenOrderCount'] = getOpenOrderCount;
    // data['IVMRejectedCount'] = iVMRejectedCount;
    // data['MOWING'] = mOWING;
    // data['JARAFF_MOWING_SPRAY_WORK'] = jARAFFMOWINGSPRAYWORK;
    // data['getChangeOrdercount'] = getChangeOrdercount;
    // data['getRowMainSUBSTATIONCount'] = getRowMainSUBSTATIONCount;
    // data['MOWING_NOSPRAY'] = mOWINGNOSPRAY;
    // data['getRejectedOrderCount'] = getRejectedOrderCount;
    // data['getPendingOrderCount'] = getPendingOrderCount;
    // data['JARAFF_MOWING_NO_SPRAY'] = jARAFFMOWINGNOSPRAY;
    // data['ChangeOrderClosedCount'] = changeOrderClosedCount;
    // data['IVMClosedCount'] = iVMClosedCount;
    // data['getChangeOrder_SUBSTATIONCount'] = getChangeOrderSUBSTATIONCount;
    // data['GROUND_WORK'] = gROUNDWORK;
    // data['getChangeOrderWFACount'] = getChangeOrderWFACount;
    // data['getbucketWorkCount'] = getbucketWorkCount;
    data['work_order_inspection_pending'] = workOrderInspectionPending;
    data['work_order_inProgress'] = workOrderInProgress;
    data['work_order_rejected'] = workOrderRejected;
    data['work_order_completed'] = workOrderCompleted;
    data['distribution_ready_for_inspection'] = distributionReadyForInspection;
    data['distribution_In_Progress'] = distributionInProgress;
    data['distribution_rejected'] = distributionRejected;
    data['distribution_completed'] = distributionCompleted;
    data['distribution_Open'] = distributionOpen;
    if (getSPGETPERCENTAGEAll != null) {
      data['getSP_GET_PERCENTAGEAll'] =
          getSPGETPERCENTAGEAll!.map((v) => v.toJson()).toList();
    }
    // data['ChangeOrderPendingCount'] = changeOrderPendingCount;
    // data['ChangeOrderRejectedCount'] = changeOrderRejectedCount;
    // data['IVMPendingCount'] = iVMPendingCount;
    // data['getPendingApprovalOrderCount'] = getPendingApprovalOrderCount;
    // data['MidCycleClosedCount'] = midCycleClosedCount;
    // data['SPRAY'] = sPRAY;
    // if (substationList != null) {
    //   data['substationList'] = substationList!.map((v) => v.toJson()).toList();
    // }
    // data['getClosedOrderCount'] = getClosedOrderCount;
    // if (monthList != null) {
    //   data['monthList'] = monthList!.map((v) => v.toJson()).toList();
    // }
    // data['MidCyclePendingCount'] = midCyclePendingCount;
    data['service_order_open'] = serviceOrderOpen;
    data['service_order_inProgress'] = serviceOrderInProgress;
    data['service_order_readyfor_review'] = serviceOrderReadyforReview;
    data['service_order_closed'] = serviceOrderClosed;
      data['transmissionIVM_ready_for_inspection'] =
        transmissionIVMReadyForInspection;
    data['transmissionIVM_In_Progress'] = transmissionIVMInProgress;
    data['transmissionIVM_rejected'] = transmissionIVMRejected;
    data['transmissionIVM_closed'] = transmissionIVMClosed;
    data['transmissionHerbicide_ready_for_inspection'] =
        transmissionHerbicideReadyForInspection;
    data['transmissionHerbicide_In_Progress'] =
        transmissionHerbicideInProgress;
    data['transmissionHerbicide_rejected'] = transmissionHerbicideRejected;
    data['transmissionHerbicide_closed'] = transmissionHerbicideClosed;
    data['annualHerbicide_ready_for_inspection'] =
        annualHerbicideReadyForInspection;
    data['annualHerbicide_In_Progress'] = annualHerbicideInProgress;
    data['annualHerbicide_rejected'] = annualHerbicideRejected;
    data['annualHerbicide_closed'] = annualHerbicideClosed;
    return data;
  }
}

class GetSPGETPERCENTAGEAll {
  String? subStationName;
  String? feeder;
  String? type1;
  double? growthPercentage;

  GetSPGETPERCENTAGEAll(
      {this.subStationName, this.feeder, this.type1, this.growthPercentage});

  GetSPGETPERCENTAGEAll.fromJson(Map<String, dynamic> json) {
    subStationName = json['subStationName'];
    feeder = json['feeder'];
    type1 = json['type1'];
    growthPercentage = json['growthPercentage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['subStationName'] = subStationName;
    data['feeder'] = feeder;
    data['type1'] = type1;
    data['growthPercentage'] = growthPercentage;
    return data;
  }
}

// class SubstationList {
//   String? substationName;

//   SubstationList({this.substationName});

//   SubstationList.fromJson(Map<String, dynamic> json) {
//     substationName = json['substationName'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['substationName'] = substationName;
//     return data;
//   }
// }

// class MonthList {
//   String? month;

//   MonthList({this.month});

//   MonthList.fromJson(Map<String, dynamic> json) {
//     month = json['month'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['month'] = month;
//     return data;
//   }
// }
