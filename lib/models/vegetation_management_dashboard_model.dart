// //*********************************************************************************************************** */
// //*****************************************working model**********************************************************************//
// class VegetationManagementDashboardModel {
//   // int? getHERBICIDESCount;
//   // int? getMECHANICALPURINGCount;
//   List<GetSPGETPERCENTAGEAll>? getSPGETPERCENTAGEAll;
//   // int? getRowMaintPendingCount;
//   // int? getChangeOrderCOMPLETECount;
//   // int? getARIELPURINGCount;
//   // int? getMECHANICALCLEARINGCount;
//   // int? getOpenOrderCount;
//   // int? getRejectedOrderCount;
//   // int? getPendingOrderCount;
//   // int? getPRUNINGCount;
//   // int? getMECHANICALTREEREMOVALCount;
//   List<GetSPGETPERCENTAGE>? getSPGETPERCENTAGE;
//   // int? getChangeOrderPendingCount;
//   // int? getPendingApprovalOrderCount;
//   // int? getRowMaintClosedCount;
//   // int? getClosedOrderCount;
//   // int? getChangeOrderSUBSTATIONCount;
//   int? gROUNDWORK;
//   int? getRowMaintPendingCount;
//   int? getbucketWorkCount;
//   int? getChangeOrderCOMPLETECount;
//   int? getOpenOrderCount;
//   int? mOWING;
//   int? jARAFFMOWINGSPRAYWORK;
//   int? getRowMainSUBSTATIONCount;
//   int? mOWINGNOSPRAY;
//   int? getRejectedOrderCount;
//   int? getPendingOrderCount;
//   int? jARAFFMOWINGNOSPRAY;
//   int? getChangeOrderPendingCount;
//   int? getPendingApprovalOrderCount;
//   int? getRowMaintClosedCount;
//   int? sPRAY;
//   int? getClosedOrderCount;
//   int? getChangeOrderSUBSTATIONCount;

//   VegetationManagementDashboardModel(
//       {
//       //   this.getHERBICIDESCount,
//       // this.getMECHANICALPURINGCount,
//       ///////
//       this.getSPGETPERCENTAGEAll,
//       //////
//       // this.getRowMaintPendingCount,
//       // this.getChangeOrderCOMPLETECount,
//       // this.getARIELPURINGCount,
//       // this.getMECHANICALCLEARINGCount,
//       // this.getOpenOrderCount,
//       // this.getRejectedOrderCount,
//       // this.getPendingOrderCount,
//       // this.getPRUNINGCount,
//       // this.getMECHANICALTREEREMOVALCount,
//       ///////
//       this.getSPGETPERCENTAGE,
//       ///////
//       // this.getChangeOrderPendingCount,
//       // this.getPendingApprovalOrderCount,
//       // this.getRowMaintClosedCount,
//       // this.getClosedOrderCount,
//       // this.getChangeOrderSUBSTATIONCount
//       this.gROUNDWORK,
//       this.getRowMaintPendingCount,
//       this.getbucketWorkCount,
//       this.getChangeOrderCOMPLETECount,
//       this.getOpenOrderCount,
//       this.mOWING,
//       this.jARAFFMOWINGSPRAYWORK,
//       this.getRowMainSUBSTATIONCount,
//       this.mOWINGNOSPRAY,
//       this.getRejectedOrderCount,
//       this.getPendingOrderCount,
//       this.jARAFFMOWINGNOSPRAY,
//       this.getChangeOrderPendingCount,
//       this.getPendingApprovalOrderCount,
//       this.getRowMaintClosedCount,
//       this.sPRAY,
//       this.getClosedOrderCount,
//       this.getChangeOrderSUBSTATIONCount
//       });

//   VegetationManagementDashboardModel.fromJson(Map<String, dynamic> json) {
//     // getHERBICIDESCount = json['getHERBICIDESCount'];
//     // getMECHANICALPURINGCount = json['getMECHANICAL_PURINGCount'];
//     if (json['getSP_GET_PERCENTAGEAll'] != null) {
//       getSPGETPERCENTAGEAll = <GetSPGETPERCENTAGEAll>[];
//       json['getSP_GET_PERCENTAGEAll'].forEach((v) {
//         getSPGETPERCENTAGEAll!.add(GetSPGETPERCENTAGEAll.fromJson(v));
//       });
//     } gROUNDWORK = json['GROUND_WORK'];
//     getRowMaintPendingCount = json['getRowMaintPendingCount'];
//     getbucketWorkCount = json['getbucketWorkCount'];
//     getChangeOrderCOMPLETECount = json['getChangeOrderCOMPLETECount'];
//     getOpenOrderCount = json['getOpenOrderCount'];
//     mOWING = json['MOWING'];
//     jARAFFMOWINGSPRAYWORK = json['JARAFF_MOWING_SPRAY_WORK'];
//     getRowMainSUBSTATIONCount = json['getRowMainSUBSTATIONCount'];
//     mOWINGNOSPRAY = json['MOWING_NOSPRAY'];
//     getRejectedOrderCount = json['getRejectedOrderCount'];
//     getPendingOrderCount = json['getPendingOrderCount'];
//     jARAFFMOWINGNOSPRAY = json['JARAFF_MOWING_NO_SPRAY'];
//     getChangeOrderPendingCount = json['getChangeOrder_PendingCount'];
//     getPendingApprovalOrderCount = json['getPendingApprovalOrderCount'];
//     getRowMaintClosedCount = json['getRowMaintClosedCount'];
//     sPRAY = json['SPRAY'];
//     getClosedOrderCount = json['getClosedOrderCount'];
//     getChangeOrderSUBSTATIONCount = json['getChangeOrder_SUBSTATIONCount'];
//     // getRowMaintPendingCount = json['getRowMaintPendingCount'];
//     // getChangeOrderCOMPLETECount = json['getChangeOrderCOMPLETECount'];
//     // getARIELPURINGCount = json['getARIEL_PURINGCount'];
//     // getMECHANICALCLEARINGCount = json['getMECHANICALCLEARINGCount'];
//     // getOpenOrderCount = json['getOpenOrderCount'];
//     // getRejectedOrderCount = json['getRejectedOrderCount'];
//     // getPendingOrderCount = json['getPendingOrderCount'];
//     // getPRUNINGCount = json['getPRUNINGCount'];
//     // getMECHANICALTREEREMOVALCount = json['getMECHANICALTREEREMOVALCount'];
//     // getChangeOrderPendingCount = json['getChangeOrder_PendingCount'];
//     // getPendingApprovalOrderCount = json['getPendingApprovalOrderCount'];
//     // getRowMaintClosedCount = json['getRowMaintClosedCount'];
//     // getClosedOrderCount = json['getClosedOrderCount'];
//     // getChangeOrderSUBSTATIONCount = json['getChangeOrder_SUBSTATIONCount'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     // data['getHERBICIDESCount'] = getHERBICIDESCount;
//     // data['getMECHANICAL_PURINGCount'] = getMECHANICALPURINGCount;
//     if (getSPGETPERCENTAGEAll != null) {
//       data['GetSPGETPERCENTAGEAll'] =
//           getSPGETPERCENTAGEAll!.map((v) => v.toJson()).toList();
//     }
//     // data['getRowMaintPendingCount'] = getRowMaintPendingCount;
//     // data['getChangeOrderCOMPLETECount'] = getChangeOrderCOMPLETECount;
//     // data['getARIEL_PURINGCount'] = getARIELPURINGCount;
//     // data['getMECHANICALCLEARINGCount'] = getMECHANICALCLEARINGCount;
//     // data['getOpenOrderCount'] = getOpenOrderCount;
//     // data['getRejectedOrderCount'] = getRejectedOrderCount;
//     // data['getPendingOrderCount'] = getPendingOrderCount;
//     // data['getPRUNINGCount'] = getPRUNINGCount;
//     // data['getMECHANICALTREEREMOVALCount'] = getMECHANICALTREEREMOVALCount;
//     // data['getChangeOrder_PendingCount'] = getChangeOrderPendingCount;
//     // data['getPendingApprovalOrderCount'] = getPendingApprovalOrderCount;
//     // data['getRowMaintClosedCount'] = getRowMaintClosedCount;
//     // data['getClosedOrderCount'] = getClosedOrderCount;
//     // data['getChangeOrder_SUBSTATIONCount'] = getChangeOrderSUBSTATIONCount;
//     data['GROUND_WORK'] = gROUNDWORK;
//     data['getRowMaintPendingCount'] = getRowMaintPendingCount;
//     data['getbucketWorkCount'] = getbucketWorkCount;
//     data['getChangeOrderCOMPLETECount'] = getChangeOrderCOMPLETECount;
//     data['getOpenOrderCount'] = getOpenOrderCount;
//     data['MOWING'] = mOWING;
//     data['JARAFF_MOWING_SPRAY_WORK'] = jARAFFMOWINGSPRAYWORK;
//     data['getRowMainSUBSTATIONCount'] = getRowMainSUBSTATIONCount;
//     data['MOWING_NOSPRAY'] = mOWINGNOSPRAY;
//     data['getRejectedOrderCount'] = getRejectedOrderCount;
//     data['getPendingOrderCount'] = getPendingOrderCount;
//     data['JARAFF_MOWING_NO_SPRAY'] = jARAFFMOWINGNOSPRAY;
//     data['getChangeOrder_PendingCount'] = getChangeOrderPendingCount;
//     data['getPendingApprovalOrderCount'] = getPendingApprovalOrderCount;
//     data['getRowMaintClosedCount'] = getRowMaintClosedCount;
//     data['SPRAY'] = sPRAY;
//     data['getClosedOrderCount'] = getClosedOrderCount;
//     data['getChangeOrder_SUBSTATIONCount'] = getChangeOrderSUBSTATIONCount;
//     return data;
//   }
// }

// class GetSPGETPERCENTAGE {
//   String? feeder;
//   String? subStationName;
//   String? type1;
//   double? growthPercentage;

//   GetSPGETPERCENTAGE(
//       {this.feeder, this.subStationName, this.type1, this.growthPercentage});

//   GetSPGETPERCENTAGE.fromJson(Map<String, dynamic> json) {
//     feeder = json['feeder'];
//     subStationName = json['subStationName'];
//     type1 = json['type1'];
//     growthPercentage = json['growthPercentage'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['feeder'] = feeder;
//     data['subStationName'] = subStationName;
//     data['type1'] = type1;
//     data['growthPercentage'] = growthPercentage;
//     return data;
//   }
// }

// class GetSPGETPERCENTAGEAll {
//   String? feeder;
//   String? subStationName;
//   String? type1;
//   double? growthPercentage;

//   GetSPGETPERCENTAGEAll(
//       {this.feeder, this.subStationName, this.type1, this.growthPercentage});

//   GetSPGETPERCENTAGEAll.fromJson(Map<String, dynamic> json) {
//     feeder = json['feeder'];
//     subStationName = json['subStationName'];
//     type1 = json['type1'];
//     growthPercentage = json['growthPercentage'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['feeder'] = feeder;
//     data['subStationName'] = subStationName;
//     data['type1'] = type1;
//     data['growthPercentage'] = growthPercentage;
//     return data;
//   }
// }

// class VegetationManagementDashboardModel {
//   int? gROUNDWORK;
//   int? getRowMaintPendingCount;
//   int? getbucketWorkCount;
//   int? getChangeOrderCOMPLETECount;
//   List<GetSPGETPERCENTAGEAll>? getSPGETPERCENTAGEAll;
//   int? getOpenOrderCount;
//   int? mOWING;
//   int? jARAFFMOWINGSPRAYWORK;
//   int? getRowMainSUBSTATIONCount;
//   int? mOWINGNOSPRAY;
//   int? getRejectedOrderCount;
//   int? getPendingOrderCount;
//   int? jARAFFMOWINGNOSPRAY;
//   // List<GetSPGETPERCENTAGE>? getSPGETPERCENTAGE;
//   int? getChangeOrderPendingCount;
//   int? getPendingApprovalOrderCount;
//   int? getRowMaintClosedCount;
//   int? sPRAY;
//   List<SubstationList>? substationList;
//   int? getClosedOrderCount;
//   List<MonthList>? monthList;
//   int? getChangeOrderSUBSTATIONCount;

//   VegetationManagementDashboardModel(
//       {this.gROUNDWORK,
//       this.getRowMaintPendingCount,
//       this.getbucketWorkCount,
//       this.getChangeOrderCOMPLETECount,
//       this.getSPGETPERCENTAGEAll,
//       this.getOpenOrderCount,
//       this.mOWING,
//       this.jARAFFMOWINGSPRAYWORK,
//       this.getRowMainSUBSTATIONCount,
//       this.mOWINGNOSPRAY,
//       this.getRejectedOrderCount,
//       this.getPendingOrderCount,
//       this.jARAFFMOWINGNOSPRAY,
//       // this.getSPGETPERCENTAGE,
//       this.getChangeOrderPendingCount,
//       this.getPendingApprovalOrderCount,
//       this.getRowMaintClosedCount,
//       this.sPRAY,
//       this.substationList,
//       this.getClosedOrderCount,
//       this.monthList,
//       this.getChangeOrderSUBSTATIONCount});

//   VegetationManagementDashboardModel.fromJson(Map<String, dynamic> json) {
//     gROUNDWORK = json['GROUND_WORK'];
//     getRowMaintPendingCount = json['getRowMaintPendingCount'];
//     getbucketWorkCount = json['getbucketWorkCount'];
//     getChangeOrderCOMPLETECount = json['getChangeOrderCOMPLETECount'];
//     if (json['getSP_GET_PERCENTAGEAll'] != null) {
//       getSPGETPERCENTAGEAll = <GetSPGETPERCENTAGEAll>[];
//       json['getSP_GET_PERCENTAGEAll'].forEach((v) {
//         getSPGETPERCENTAGEAll!.add(GetSPGETPERCENTAGEAll.fromJson(v));
//       });
//     }
//     getOpenOrderCount = json['getOpenOrderCount'];
//     mOWING = json['MOWING'];
//     jARAFFMOWINGSPRAYWORK = json['JARAFF_MOWING_SPRAY_WORK'];
//     getRowMainSUBSTATIONCount = json['getRowMainSUBSTATIONCount'];
//     mOWINGNOSPRAY = json['MOWING_NOSPRAY'];
//     getRejectedOrderCount = json['getRejectedOrderCount'];
//     getPendingOrderCount = json['getPendingOrderCount'];
//     jARAFFMOWINGNOSPRAY = json['JARAFF_MOWING_NO_SPRAY'];
//     // if (json['getSP_GET_PERCENTAGE'] != null) {
//     //   getSPGETPERCENTAGE = <GetSPGETPERCENTAGE>[];
//     //   json['getSP_GET_PERCENTAGE'].forEach((v) {
//     //     getSPGETPERCENTAGE!.add(GetSPGETPERCENTAGE.fromJson(v));
//     //   });
//     // }
//     getChangeOrderPendingCount = json['getChangeOrder_PendingCount'];
//     getPendingApprovalOrderCount = json['getPendingApprovalOrderCount'];
//     getRowMaintClosedCount = json['getRowMaintClosedCount'];
//     sPRAY = json['SPRAY'];
//     if (json['substationList'] != null) {
//       substationList = <SubstationList>[];
//       json['substationList'].forEach((v) {
//         substationList!.add(SubstationList.fromJson(v));
//       });
//     }
//     getClosedOrderCount = json['getClosedOrderCount'];
//     if (json['monthList'] != null) {
//       monthList = <MonthList>[];
//       json['monthList'].forEach((v) {
//         monthList!.add(MonthList.fromJson(v));
//       });
//     }
//     getChangeOrderSUBSTATIONCount = json['getChangeOrder_SUBSTATIONCount'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['GROUND_WORK'] = gROUNDWORK;
//     data['getRowMaintPendingCount'] = getRowMaintPendingCount;
//     data['getbucketWorkCount'] = getbucketWorkCount;
//     data['getChangeOrderCOMPLETECount'] = getChangeOrderCOMPLETECount;
//     if (getSPGETPERCENTAGEAll != null) {
//       data['getSP_GET_PERCENTAGEAll'] =
//           getSPGETPERCENTAGEAll!.map((v) => v.toJson()).toList();
//     }
//     data['getOpenOrderCount'] = getOpenOrderCount;
//     data['MOWING'] = mOWING;
//     data['JARAFF_MOWING_SPRAY_WORK'] = jARAFFMOWINGSPRAYWORK;
//     data['getRowMainSUBSTATIONCount'] = getRowMainSUBSTATIONCount;
//     data['MOWING_NOSPRAY'] = mOWINGNOSPRAY;
//     data['getRejectedOrderCount'] = getRejectedOrderCount;
//     data['getPendingOrderCount'] = getPendingOrderCount;
//     data['JARAFF_MOWING_NO_SPRAY'] = jARAFFMOWINGNOSPRAY;
//     // if (getSPGETPERCENTAGE != null) {
//     //   data['getSP_GET_PERCENTAGE'] =
//     //       getSPGETPERCENTAGE!.map((v) => v.toJson()).toList();
//     // }
//     data['getChangeOrder_PendingCount'] = getChangeOrderPendingCount;
//     data['getPendingApprovalOrderCount'] = getPendingApprovalOrderCount;
//     data['getRowMaintClosedCount'] = getRowMaintClosedCount;
//     data['SPRAY'] = sPRAY;
//     if (substationList != null) {
//       data['substationList'] = substationList!.map((v) => v.toJson()).toList();
//     }
//     data['getClosedOrderCount'] = getClosedOrderCount;
//     if (monthList != null) {
//       data['monthList'] = monthList!.map((v) => v.toJson()).toList();
//     }
//     data['getChangeOrder_SUBSTATIONCount'] = getChangeOrderSUBSTATIONCount;
//     return data;
//   }
// }

// class GetSPGETPERCENTAGEAll {
//   String? feeder;
//   String? subStationName;
//   String? type1;
//   double? growthPercentage;

//   GetSPGETPERCENTAGEAll(
//       {this.feeder, this.subStationName, this.type1, this.growthPercentage});

//   GetSPGETPERCENTAGEAll.fromJson(Map<String, dynamic> json) {
//     feeder = json['feeder'];
//     subStationName = json['subStationName'];
//     type1 = json['type1'];
//     growthPercentage = json['growthPercentage'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['feeder'] = feeder;
//     data['subStationName'] = subStationName;
//     data['type1'] = type1;
//     data['growthPercentage'] = growthPercentage;
//     return data;
//   }
// }

// class SubstationList {
//   String? substationName;

//   SubstationList({this.substationName});

//   SubstationList.fromJson(Map<String, dynamic> json) {
//     substationName = json['substationName'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['substationName'] = this.substationName;
//     return data;
//   }
// }

// // class GetSPGETPERCENTAGE {
// //   String? feeder;
// //   String? subStationName;
// //   String? type1;
// //   double? growthPercentage;

// //   GetSPGETPERCENTAGE(
// //       {this.feeder, this.subStationName, this.type1, this.growthPercentage});

// //   GetSPGETPERCENTAGE.fromJson(Map<String, dynamic> json) {
// //     feeder = json['feeder'];
// //     subStationName = json['subStationName'];
// //     type1 = json['type1'];
// //     growthPercentage = json['growthPercentage'];
// //   }

// //   Map<String, dynamic> toJson() {
// //     final Map<String, dynamic> data = <String, dynamic>{};
// //     data['feeder'] = feeder;
// //     data['subStationName'] = subStationName;
// //     data['type1'] = type1;
// //     data['growthPercentage'] = growthPercentage;
// //     return data;
// //   }
// // }

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

// class VegetationManagementDashboardModel {
//   int? gROUNDWORK;
//   int? getRowMaintPendingCount;
//   ////////////////////////////
//   List<int>? getRegularIVMMaintenanceCount;
//   List<int>? getMidCycleHerbicideCount;
//   List<int>? getChangeOrdercount;
//   ////////////////////////////////////
//   int? getbucketWorkCount;
//   int? getChangeOrderCOMPLETECount;
//   List<GetSPGETPERCENTAGEAll>? getSPGETPERCENTAGEAll;
//   int? getOpenOrderCount;
//   int? mOWING;
//   int? jARAFFMOWINGSPRAYWORK;
//   int? getRowMainSUBSTATIONCount;
//   int? mOWINGNOSPRAY;
//   int? getRejectedOrderCount;
//   int? getPendingOrderCount;
//   int? jARAFFMOWINGNOSPRAY;
//   int? getChangeOrderPendingCount;
//   int? getPendingApprovalOrderCount;
//   int? getRowMaintClosedCount;
//   int? sPRAY;
//   List<SubstationList>? substationList;
//   int? getClosedOrderCount;
//   List<MonthList>? monthList;
//   int? getChangeOrderSUBSTATIONCount;

//   VegetationManagementDashboardModel(
//       {this.gROUNDWORK,
//       this.getRowMaintPendingCount,
//       this.getbucketWorkCount,
//       this.getChangeOrderCOMPLETECount,
//       this.getSPGETPERCENTAGEAll,
//       this.getOpenOrderCount,
//       this.mOWING,
//       this.jARAFFMOWINGSPRAYWORK,
//       this.getRowMainSUBSTATIONCount,
//       this.mOWINGNOSPRAY,
//       this.getRejectedOrderCount,
//       this.getPendingOrderCount,
//       this.jARAFFMOWINGNOSPRAY,
//       this.getChangeOrderPendingCount,
//       this.getPendingApprovalOrderCount,
//       this.getRowMaintClosedCount,
//       this.sPRAY,
//       this.substationList,
//       this.getClosedOrderCount,
//       this.monthList,
//       this.getChangeOrderSUBSTATIONCount,
//       this.getChangeOrdercount,
//       this.getMidCycleHerbicideCount,
//       this.getRegularIVMMaintenanceCount});

//   VegetationManagementDashboardModel.fromJson(Map<String, dynamic> json) {
//     gROUNDWORK = json['GROUND_WORK'];
//     getRowMaintPendingCount = json['getRowMaintPendingCount'];
//     getRegularIVMMaintenanceCount =
//         json['getRegularIVMMaintenanceCount'].cast<int>();
//     getMidCycleHerbicideCount = json['getMidCycleHerbicideCount'].cast<int>();
//     getChangeOrdercount = json['getChangeOrdercount'].cast<int>();
//     getbucketWorkCount = json['getbucketWorkCount'];
//     getChangeOrderCOMPLETECount = json['getChangeOrderCOMPLETECount'];
//     if (json['getSP_GET_PERCENTAGEAll'] != null) {
//       getSPGETPERCENTAGEAll = <GetSPGETPERCENTAGEAll>[];
//       json['getSP_GET_PERCENTAGEAll'].forEach((v) {
//         getSPGETPERCENTAGEAll!.add(GetSPGETPERCENTAGEAll.fromJson(v));
//       });
//     }
//     getOpenOrderCount = json['getOpenOrderCount'];
//     mOWING = json['MOWING'];
//     jARAFFMOWINGSPRAYWORK = json['JARAFF_MOWING_SPRAY_WORK'];
//     getRowMainSUBSTATIONCount = json['getRowMainSUBSTATIONCount'];
//     mOWINGNOSPRAY = json['MOWING_NOSPRAY'];
//     getRejectedOrderCount = json['getRejectedOrderCount'];
//     getPendingOrderCount = json['getPendingOrderCount'];
//     jARAFFMOWINGNOSPRAY = json['JARAFF_MOWING_NO_SPRAY'];
//     getChangeOrderPendingCount = json['getChangeOrder_PendingCount'];
//     getPendingApprovalOrderCount = json['getPendingApprovalOrderCount'];
//     getRowMaintClosedCount = json['getRowMaintClosedCount'];
//     sPRAY = json['SPRAY'];
//     if (json['substationList'] != null) {
//       substationList = <SubstationList>[];
//       json['substationList'].forEach((v) {
//         substationList!.add(SubstationList.fromJson(v));
//       });
//     }
//     getClosedOrderCount = json['getClosedOrderCount'];
//     if (json['monthList'] != null) {
//       monthList = <MonthList>[];
//       json['monthList'].forEach((v) {
//         monthList!.add(MonthList.fromJson(v));
//       });
//     }
//     getChangeOrderSUBSTATIONCount = json['getChangeOrder_SUBSTATIONCount'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['GROUND_WORK'] = gROUNDWORK;
//     data['getRowMaintPendingCount'] = getRowMaintPendingCount;
//     data['getbucketWorkCount'] = getbucketWorkCount;
//     data['getRegularIVMMaintenanceCount'] = getRegularIVMMaintenanceCount;
//     data['getMidCycleHerbicideCount'] = this.getMidCycleHerbicideCount;
//     data['getChangeOrdercount'] = this.getChangeOrdercount;
//     data['getChangeOrderCOMPLETECount'] = getChangeOrderCOMPLETECount;
//     if (getSPGETPERCENTAGEAll != null) {
//       data['getSP_GET_PERCENTAGEAll'] =
//           getSPGETPERCENTAGEAll!.map((v) => v.toJson()).toList();
//     }
//     data['getOpenOrderCount'] = getOpenOrderCount;
//     data['MOWING'] = mOWING;
//     data['JARAFF_MOWING_SPRAY_WORK'] = jARAFFMOWINGSPRAYWORK;
//     data['getRowMainSUBSTATIONCount'] = getRowMainSUBSTATIONCount;
//     data['MOWING_NOSPRAY'] = mOWINGNOSPRAY;
//     data['getRejectedOrderCount'] = getRejectedOrderCount;
//     data['getPendingOrderCount'] = getPendingOrderCount;
//     data['JARAFF_MOWING_NO_SPRAY'] = jARAFFMOWINGNOSPRAY;
//     data['getChangeOrder_PendingCount'] = getChangeOrderPendingCount;
//     data['getPendingApprovalOrderCount'] = getPendingApprovalOrderCount;
//     data['getRowMaintClosedCount'] = getRowMaintClosedCount;
//     data['SPRAY'] = sPRAY;
//     if (substationList != null) {
//       data['substationList'] = substationList!.map((v) => v.toJson()).toList();
//     }
//     data['getClosedOrderCount'] = getClosedOrderCount;
//     if (monthList != null) {
//       data['monthList'] = monthList!.map((v) => v.toJson()).toList();
//     }
//     data['getChangeOrder_SUBSTATIONCount'] = getChangeOrderSUBSTATIONCount;
//     return data;
//   }
// }

// class GetSPGETPERCENTAGEAll {
//   String? feeder;
//   String? subStationName;
//   String? type1;
//   double? growthPercentage;

//   GetSPGETPERCENTAGEAll(
//       {this.feeder, this.subStationName, this.type1, this.growthPercentage});

//   GetSPGETPERCENTAGEAll.fromJson(Map<String, dynamic> json) {
//     feeder = json['feeder'];
//     subStationName = json['subStationName'];
//     type1 = json['type1'];
//     growthPercentage = json['growthPercentage'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['feeder'] = feeder;
//     data['subStationName'] = subStationName;
//     data['type1'] = type1;
//     data['growthPercentage'] = growthPercentage;
//     return data;
//   }
// }

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

class VegetationManagementDashboardModel {
  int? getChangeOrderWFACount;
  int? getRegularIVMMaintenanceCount;
  int? getMidCycleHerbicideCount;
  int? midCycleRejectedCount;
  int? getOpenOrderCount;
  int? iVMRejectedCount;
  int? mOWING;
  int? jARAFFMOWINGSPRAYWORK;
  int? getChangeOrdercount;
  int? getRowMainSUBSTATIONCount;
  int? mOWINGNOSPRAY;
  int? getRejectedOrderCount;
  int? getPendingOrderCount;
  int? jARAFFMOWINGNOSPRAY;
  int? changeOrderClosedCount;
  int? iVMClosedCount;
  int? getChangeOrderSUBSTATIONCount;
  int? gROUNDWORK;
  int? getbucketWorkCount;
  List<GetSPGETPERCENTAGEAll>? getSPGETPERCENTAGEAll;
  int? changeOrderPendingCount;
  int? changeOrderRejectedCount;
  int? changeOrderCancelledCount;
  int? iVMPendingCount;
  int? getPendingApprovalOrderCount;
  int? midCycleClosedCount;
  int? sPRAY;
  List<SubstationList>? substationList;
  int? getClosedOrderCount;
  List<MonthList>? monthList;
  int? midCyclePendingCount;

  VegetationManagementDashboardModel(
      {this.getChangeOrderWFACount,
      this.getRegularIVMMaintenanceCount,
      this.getMidCycleHerbicideCount,
      this.midCycleRejectedCount,
      this.getOpenOrderCount,
      this.iVMRejectedCount,
      this.mOWING,
      this.jARAFFMOWINGSPRAYWORK,
      this.getChangeOrdercount,
      this.getRowMainSUBSTATIONCount,
      this.mOWINGNOSPRAY,
      this.getRejectedOrderCount,
      this.getPendingOrderCount,
      this.jARAFFMOWINGNOSPRAY,
      this.changeOrderClosedCount,
      this.iVMClosedCount,
      this.getChangeOrderSUBSTATIONCount,
      this.gROUNDWORK,
      this.getbucketWorkCount,
      this.getSPGETPERCENTAGEAll,
      this.changeOrderPendingCount,
      this.changeOrderRejectedCount,
      this.changeOrderCancelledCount,
      this.iVMPendingCount,
      this.getPendingApprovalOrderCount,
      this.midCycleClosedCount,
      this.sPRAY,
      this.substationList,
      this.getClosedOrderCount,
      this.monthList,
      this.midCyclePendingCount});

  VegetationManagementDashboardModel.fromJson(Map<String, dynamic> json) {
    getChangeOrderWFACount = json['getChangeOrderWFACount'];
    getRegularIVMMaintenanceCount = json['getRegularIVMMaintenanceCount'];
    getMidCycleHerbicideCount = json['getMidCycleHerbicideCount'];
    midCycleRejectedCount = json['MidCycleRejectedCount'];
    getOpenOrderCount = json['getOpenOrderCount'];
    iVMRejectedCount = json['IVMRejectedCount'];
    mOWING = json['MOWING'];
    jARAFFMOWINGSPRAYWORK = json['JARAFF_MOWING_SPRAY_WORK'];
    getChangeOrdercount = json['getChangeOrdercount'];
    getRowMainSUBSTATIONCount = json['getRowMainSUBSTATIONCount'];
    mOWINGNOSPRAY = json['MOWING_NOSPRAY'];
    getRejectedOrderCount = json['getRejectedOrderCount'];
    getPendingOrderCount = json['getPendingOrderCount'];
    jARAFFMOWINGNOSPRAY = json['JARAFF_MOWING_NO_SPRAY'];
    changeOrderClosedCount = json['ChangeOrderClosedCount'];
    iVMClosedCount = json['IVMClosedCount'];
    getChangeOrderSUBSTATIONCount = json['getChangeOrder_SUBSTATIONCount'];
    gROUNDWORK = json['GROUND_WORK'];
    getbucketWorkCount = json['getbucketWorkCount'];
    if (json['getSP_GET_PERCENTAGEAll'] != null) {
      getSPGETPERCENTAGEAll = <GetSPGETPERCENTAGEAll>[];
      json['getSP_GET_PERCENTAGEAll'].forEach((v) {
        getSPGETPERCENTAGEAll!.add(new GetSPGETPERCENTAGEAll.fromJson(v));
      });
    }
    changeOrderPendingCount = json['ChangeOrderPendingCount'];
    changeOrderRejectedCount = json['ChangeOrderRejectedCount'];
    changeOrderCancelledCount = json['changeOrderCancelled'];
    iVMPendingCount = json['IVMPendingCount'];
    getPendingApprovalOrderCount = json['getPendingApprovalOrderCount'];
    midCycleClosedCount = json['MidCycleClosedCount'];
    sPRAY = json['SPRAY'];
    if (json['substationList'] != null) {
      substationList = <SubstationList>[];
      json['substationList'].forEach((v) {
        substationList!.add(new SubstationList.fromJson(v));
      });
    }
    getClosedOrderCount = json['getClosedOrderCount'];
    if (json['monthList'] != null) {
      monthList = <MonthList>[];
      json['monthList'].forEach((v) {
        monthList!.add(new MonthList.fromJson(v));
      });
    }
    midCyclePendingCount = json['MidCyclePendingCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['getChangeOrderWFACount'] = this.getChangeOrderWFACount;
    data['getRegularIVMMaintenanceCount'] = this.getRegularIVMMaintenanceCount;
    data['getMidCycleHerbicideCount'] = this.getMidCycleHerbicideCount;
    data['MidCycleRejectedCount'] = this.midCycleRejectedCount;
    data['getOpenOrderCount'] = this.getOpenOrderCount;
    data['IVMRejectedCount'] = this.iVMRejectedCount;
    data['MOWING'] = this.mOWING;
    data['JARAFF_MOWING_SPRAY_WORK'] = this.jARAFFMOWINGSPRAYWORK;
    data['getChangeOrdercount'] = this.getChangeOrdercount;
    data['getRowMainSUBSTATIONCount'] = this.getRowMainSUBSTATIONCount;
    data['MOWING_NOSPRAY'] = this.mOWINGNOSPRAY;
    data['getRejectedOrderCount'] = this.getRejectedOrderCount;
    data['getPendingOrderCount'] = this.getPendingOrderCount;
    data['JARAFF_MOWING_NO_SPRAY'] = this.jARAFFMOWINGNOSPRAY;
    data['ChangeOrderClosedCount'] = this.changeOrderClosedCount;
    data['IVMClosedCount'] = this.iVMClosedCount;
    data['getChangeOrder_SUBSTATIONCount'] = this.getChangeOrderSUBSTATIONCount;
    data['GROUND_WORK'] = this.gROUNDWORK;
    data['getbucketWorkCount'] = this.getbucketWorkCount;
    if (this.getSPGETPERCENTAGEAll != null) {
      data['getSP_GET_PERCENTAGEAll'] =
          this.getSPGETPERCENTAGEAll!.map((v) => v.toJson()).toList();
    }
    data['ChangeOrderPendingCount'] = this.changeOrderPendingCount;
    data['ChangeOrderRejectedCount'] = this.changeOrderRejectedCount;
     data['changeOrderCancelledCount'] = this.changeOrderCancelledCount;
    
    data['IVMPendingCount'] = this.iVMPendingCount;
    data['getPendingApprovalOrderCount'] = this.getPendingApprovalOrderCount;
    data['MidCycleClosedCount'] = this.midCycleClosedCount;
    data['SPRAY'] = this.sPRAY;
    if (this.substationList != null) {
      data['substationList'] =
          this.substationList!.map((v) => v.toJson()).toList();
    }
    data['getClosedOrderCount'] = this.getClosedOrderCount;
    if (this.monthList != null) {
      data['monthList'] = this.monthList!.map((v) => v.toJson()).toList();
    }
    data['MidCyclePendingCount'] = this.midCyclePendingCount;
    return data;
  }
}

class GetSPGETPERCENTAGEAll {
  String? feeder;
  String? subStationName;
  String? type1;
  double? growthPercentage;

  GetSPGETPERCENTAGEAll(
      {this.feeder, this.subStationName, this.type1, this.growthPercentage});

  GetSPGETPERCENTAGEAll.fromJson(Map<String, dynamic> json) {
    feeder = json['feeder'];
    subStationName = json['subStationName'];
    type1 = json['type1'];
    growthPercentage = json['growthPercentage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['feeder'] = this.feeder;
    data['subStationName'] = this.subStationName;
    data['type1'] = this.type1;
    data['growthPercentage'] = this.growthPercentage;
    return data;
  }
}

class SubstationList {
  String? substationName;

  SubstationList({this.substationName});

  SubstationList.fromJson(Map<String, dynamic> json) {
    substationName = json['substationName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['substationName'] = this.substationName;
    return data;
  }
}

class MonthList {
  String? month;

  MonthList({this.month});

  MonthList.fromJson(Map<String, dynamic> json) {
    month = json['month'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['month'] = this.month;
    return data;
  }
}
