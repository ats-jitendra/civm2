import 'dart:convert';
import 'dart:io';

import 'package:CIVM/piedmont/screens/admin_pannel/pemc_admin_new/adm_distributionIVM_open.dart';
import 'package:CIVM/piedmont/screens/admin_pannel/pemc_admin_new/adm_invoice_list.dart';
import 'package:CIVM/piedmont/screens/admin_pannel/pemc_admin_new/adm_maintenance_report_view_annual_herbicide.dart';
import 'package:CIVM/piedmont/screens/admin_pannel/pemc_admin_new/adm_maintenance_report_view_new.dart';
import 'package:CIVM/piedmont/screens/admin_pannel/pemc_admin_new/adm_maintenance_report_view_trans_IVM.dart';
import 'package:CIVM/piedmont/screens/admin_pannel/pemc_admin_new/adm_maintenance_report_view_trans_herbicide.dart';
import 'package:CIVM/piedmont/screens/admin_pannel/pemc_admin_new/adm_annual_herbicide_closed.dart';
import 'package:CIVM/piedmont/screens/admin_pannel/pemc_admin_new/adm_service_order.dart';
import 'package:CIVM/piedmont/screens/admin_pannel/pemc_admin_new/adm_sup_annual_herbicide_inprogress.dart';
import 'package:CIVM/piedmont/screens/admin_pannel/pemc_admin_new/adm_annual_herbicide_rejected.dart';
import 'package:CIVM/piedmont/screens/admin_pannel/pemc_admin_new/adm_distributionIVM_completed.dart';
import 'package:CIVM/piedmont/screens/admin_pannel/pemc_admin_new/adm_distributionIVM_inProgress.dart';
import 'package:CIVM/piedmont/screens/admin_pannel/pemc_admin_new/adm_distributionIVM_rejected.dart';
import 'package:CIVM/piedmont/screens/admin_pannel/pemc_admin_new/adm_transmissionHerbicide_closed.dart';
import 'package:CIVM/piedmont/screens/admin_pannel/pemc_admin_new/adm_transmissionHerbicide_inProgress.dart';
import 'package:CIVM/piedmont/screens/admin_pannel/pemc_admin_new/adm_transmissionHerbicide_rejected.dart';
import 'package:CIVM/piedmont/screens/admin_pannel/pemc_admin_new/adm_transmissionIVM_closed.dart';
import 'package:CIVM/piedmont/screens/admin_pannel/pemc_admin_new/adm_transmissionIVM_inProgress.dart';
import 'package:CIVM/piedmont/screens/admin_pannel/pemc_admin_new/adm_transmissionIVM_rejected.dart';
import 'package:CIVM/piedmont/screens/admin_pannel/pemc_admin_new/adm_SO_Open.dart';
import 'package:CIVM/piedmont/screens/admin_pannel/pemc_admin_new/adm_SO_closed.dart';
import 'package:CIVM/piedmont/screens/admin_pannel/pemc_admin_new/adm_SO_inprogress.dart';
import 'package:CIVM/piedmont/screens/admin_pannel/pemc_admin_new/adm_SO_ready_for_review.dart';
import 'package:CIVM/piedmont/screens/admin_pannel/pemc_admin_new/adm_WO_Completed.dart';
import 'package:CIVM/piedmont/screens/admin_pannel/pemc_admin_new/adm_WO_T&M_inProgress.dart';
import 'package:CIVM/piedmont/screens/admin_pannel/pemc_admin_new/adm_WO_ready_for_review.dart';
import 'package:CIVM/piedmont/screens/admin_pannel/pemc_admin_new/adm_WO_rejected.dart';
import 'package:CIVM/piedmont/screens/admin_pannel/row_maintenance_view/add_crew_member.dart';
import 'package:CIVM/piedmont/screens/admin_pannel/row_maintenance_view/add_new_row_table.dart';
import 'package:CIVM/piedmont/screens/admin_pannel/row_maintenance_view/admin_pannel.dart';
import 'package:CIVM/piedmont/screens/admin_pannel/row_maintenance_view/approve_civm_access.dart';
import 'package:CIVM/piedmont/screens/admin_pannel/row_maintenance_view/budget_planning.dart';
import 'package:CIVM/piedmont/screens/admin_pannel/row_maintenance_view/ivm_maintenance_progress.dart';
import 'package:CIVM/utils/user_pref.dart';
import 'package:CIVM/models/user_model.dart';
import 'package:CIVM/piedmont/resources/app_colors.dart';
import 'package:CIVM/piedmont/resources/app_url.dart';

import 'package:CIVM/piedmont/screens/login_page.dart';
import 'package:CIVM/piedmont/screens/map/provider/location_provider.dart';
// import 'package:CIVM/piedmont/screens/supervisor_pannel/location_map.dart';
import 'package:CIVM/sharedPrefs/constants.dart';
import 'package:CIVM/piedmont/utils/common_functions.dart';

import 'package:flutter/material.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:provider/provider.dart';
import 'package:CIVM/piedmont/screens/leaflat_map/leaf_lat_map_wakeLock.dart';
import 'package:http/http.dart' as http;
import 'package:CIVM/piedmont/repository/map_url.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:CIVM/piedmont/screens/my_chrome_safari_map_recording.dart';

// ignore: must_be_immutable
class InspectionZielies extends StatefulWidget {
  const InspectionZielies({Key? key}) : super(key: key);

  @override
  State<InspectionZielies> createState() => _InspectionZieliesState();
}

class _InspectionZieliesState extends State<InspectionZielies> {
  List<String> menu = [];

  String id = "";
  Future? myFuture;
  int currentYear = DateTime.now().year;
  @override
  void initState() {
    myFuture = fetchCardsCountMethod();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          return;
        }
        Navigator.push(context, MaterialPageRoute(builder: (context)=>const EnergyAuditPannel()));
      },
      child: Scaffold(
          backgroundColor: AppColors.backgroundColor,
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.white),
            title: const Text(
              'Inspection',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: AppColors.baseColor,
          ),
          drawer: DrawerManu(menu: menu),
          body: FutureBuilder(
            future: myFuture,
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return GestureDetector(
                  onTap: () {
                    FocusScopeNode currentFocus = FocusScope.of(context);
                    if (!currentFocus.hasPrimaryFocus) {
                      currentFocus.unfocus();
                    }
                  },
                  child: Stack(fit: StackFit.expand, children: [
                    RefreshIndicator(
                      onRefresh: () async {
                        await fetchCardsCountMethod();
                        print('RefreshIndicator called');
                      },
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(
                                  top: 10, bottom: 10, left: 8, right: 8),
                              padding: const EdgeInsets.all(8),
                              alignment: Alignment.center,
                              // height: size.height * 0.55,
                              width: size.width * 0.99,
                              decoration: BoxDecoration(
                                  // shape: BoxShape.circle,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: AppColors.buttonShadow,
                                        blurRadius: 10,
                                        offset: Offset(2.0, 5.0))
                                  ],
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color.fromARGB(255, 255, 255, 255),
                                      Color.fromARGB(255, 255, 255, 255),
                                    ],
                                  )),
                              child: Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    alignment: Alignment.center,
                                    width: size.width * 0.99,
                                    // width: MediaQuery.of(context).size.width,
                                    // height: 40,
                                    decoration: const BoxDecoration(
                                        // shape: BoxShape.circle,
                                        //borderRadius: BorderRadius.circular(25),
                                        boxShadow: [
                                          BoxShadow(
                                              color: AppColors.buttonShadow,
                                              blurRadius: 5,
                                              offset: Offset(2.0, 5.0))
                                        ],
                                        gradient: LinearGradient(
                                          colors: [
                                            AppColors.baseColor,
                                            AppColors.buttonOrange,
                                            AppColors.baseColor,
                                          ],
                                        )),
                                    child: const Row(children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Work Order For Review",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                    ]),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 8, left: 8),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (BuildContext
                                                              context) =>
                                                          AdmZIELIESTotalOrderPending(
                                                            budgetType: '',
                                                            maintenanceType:
                                                                'ChangeOrder',
                                                            heading:
                                                                'Change Order',
                                                          )));
                                            },
                                            child: DashboardCard(
                                                cardIcon:
                                                    'assets/Orders_Pending.png',
                                                cardColor: const Color.fromRGBO(
                                                    237, 230, 141, 1),
                                                cardTitle: 'In Progress',
                                                cardCount:
                                                    woTMprogressCount.toString()
                                                //  (vegetationManagementDashboardViewModel
                                                //                 .vegetationManagementDashboardList
                                                //                 .data!
                                                //                 .workOrderInProgress ==
                                                //             null ||
                                                //         vegetationManagementDashboardViewModel
                                                //                 .vegetationManagementDashboardList
                                                //                 .data!
                                                //                 .workOrderInProgress
                                                //                 .toString() ==
                                                //             'null')
                                                //     ? ''
                                                //     : vegetationManagementDashboardViewModel
                                                //         .vegetationManagementDashboardList
                                                //         .data!
                                                //         .workOrderInProgress
                                                //         .toString(),
                                                ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (BuildContext
                                                              context) =>
                                                          AdmZIELIESDocumentApprovalPending(
                                                            budgetType: '',
                                                            maintenanceType:
                                                                'ChangeOrder',
                                                            heading:
                                                                'Change Order',
                                                          )));
                                            },
                                            child: DashboardCard(
                                                cardIcon:
                                                    'assets/Orders_Pending.png',
                                                cardColor: const Color.fromRGBO(
                                                    176, 196, 222, 1),
                                                cardTitle: 'Ready For Review',
                                                cardCount: woReadyforReviewCount
                                                    .toString()
                                                //  (vegetationManagementDashboardViewModel
                                                //                 .vegetationManagementDashboardList
                                                //                 .data!
                                                //                 .workOrderInspectionPending ==
                                                //             null ||
                                                //         vegetationManagementDashboardViewModel
                                                //                 .vegetationManagementDashboardList
                                                //                 .data!
                                                //                 .workOrderInspectionPending
                                                //                 .toString() ==
                                                //             'null')
                                                //     ? ''
                                                //     : vegetationManagementDashboardViewModel
                                                //         .vegetationManagementDashboardList
                                                //         .data!
                                                //         .workOrderInspectionPending
                                                //         .toString(),
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 8, left: 8),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (BuildContext
                                                              context) =>
                                                          AdmZIELIESTotalOrderRejectCO(
                                                            budgetType: '',
                                                            maintenanceType:
                                                                'ChangeOrder',
                                                            heading: 'CO',
                                                          )));
                                            },
                                            child: DashboardCard(
                                                cardIcon:
                                                    'assets/Orders_Open.png',
                                                cardColor: const Color.fromRGBO(
                                                    240, 129, 127, 1),
                                                cardTitle: 'Rejected',
                                                cardCount:
                                                    woRejectedCount.toString()
                                                // (vegetationManagementDashboardViewModel
                                                //                 .vegetationManagementDashboardList
                                                //                 .data!
                                                //                 .workOrderRejected ==
                                                //             null ||
                                                //         vegetationManagementDashboardViewModel
                                                //                 .vegetationManagementDashboardList
                                                //                 .data!
                                                //                 .workOrderRejected
                                                //                 .toString() ==
                                                //             'null')
                                                //     ? ''
                                                //     : vegetationManagementDashboardViewModel
                                                //         .vegetationManagementDashboardList
                                                //         .data!
                                                //         .workOrderRejected
                                                //         .toString(),
                                                ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (BuildContext
                                                              context) =>
                                                          AdmZIELIESTotalOrderClosed(
                                                            budgetType: '',
                                                            maintenanceType:
                                                                'ChangeOrder',
                                                            heading: 'CO',
                                                          )));
                                            },
                                            child: DashboardCard(
                                                cardIcon:
                                                    'assets/Orders_Open.png',
                                                cardColor: const Color.fromRGBO(
                                                    142, 189, 143, 1),
                                                cardTitle: 'Closed',
                                                cardCount:
                                                    woClosedCount.toString()
                                                // (vegetationManagementDashboardViewModel
                                                //                 .vegetationManagementDashboardList
                                                //                 .data!
                                                //                 .workOrderCompleted ==
                                                //             null ||
                                                //         vegetationManagementDashboardViewModel
                                                //                 .vegetationManagementDashboardList
                                                //                 .data!
                                                //                 .workOrderCompleted
                                                //                 .toString() ==
                                                //             'null')
                                                //     ? ''
                                                //     : vegetationManagementDashboardViewModel
                                                //         .vegetationManagementDashboardList
                                                //         .data!
                                                //         .workOrderCompleted
                                                //         .toString(),
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                  top: 10, bottom: 10, left: 8, right: 8),
                              padding: const EdgeInsets.all(8),
                              alignment: Alignment.center,
                              // height: size.height * 0.55,
                              width: size.width * 0.99,
                              decoration: BoxDecoration(
                                  // shape: BoxShape.circle,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: AppColors.buttonShadow,
                                        blurRadius: 10,
                                        offset: Offset(2.0, 5.0))
                                  ],
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color.fromARGB(255, 255, 255, 255),
                                      Color.fromARGB(255, 255, 255, 255),
                                    ],
                                  )),
                              child: Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    alignment: Alignment.center,
                                    width: size.width * 0.99,
                                    // width: MediaQuery.of(context).size.width,
                                    // height: 40,
                                    decoration: const BoxDecoration(
                                        // shape: BoxShape.circle,
                                        //borderRadius: BorderRadius.circular(25),
                                        boxShadow: [
                                          BoxShadow(
                                              color: AppColors.buttonShadow,
                                              blurRadius: 5,
                                              offset: Offset(2.0, 5.0))
                                        ],
                                        gradient: LinearGradient(
                                          colors: [
                                            AppColors.baseColor,
                                            AppColors.buttonOrange,
                                            AppColors.baseColor,
                                          ],
                                        )),
                                    child: const Row(children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Service Order for Review",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                    ]),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 8, left: 8),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (BuildContext
                                                              context) =>
                                                          AdmSOOpen()));
                                            },
                                            child: DashboardCard(
                                                cardIcon:
                                                    'assets/Orders_Pending.png',
                                                cardColor: const Color.fromRGBO(
                                                    2, 205, 205, 1),
                                                cardTitle: 'Open',
                                                cardCount:
                                                    soOpenCount.toString()
                                                //  (vegetationManagementDashboardViewModel
                                                //                 .vegetationManagementDashboardList
                                                //                 .data!
                                                //                 .serviceOrderOpen ==
                                                //             null ||
                                                //         vegetationManagementDashboardViewModel
                                                //                 .vegetationManagementDashboardList
                                                //                 .data!
                                                //                 .serviceOrderOpen
                                                //                 .toString() ==
                                                //             'null')
                                                //     ? ''
                                                //     : vegetationManagementDashboardViewModel
                                                //         .vegetationManagementDashboardList
                                                //         .data!
                                                //         .serviceOrderOpen
                                                //         .toString(),
                                                ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (BuildContext
                                                              context) =>
                                                          AdmSOInprogress()));
                                            },
                                            child: DashboardCard(
                                                cardIcon:
                                                    'assets/Orders_Pending.png',
                                                cardColor: const Color.fromRGBO(
                                                    237, 230, 141, 1),
                                                cardTitle: 'In Progress',
                                                cardCount:
                                                    soInprogressCount.toString()
                                                // (vegetationManagementDashboardViewModel
                                                //                 .vegetationManagementDashboardList
                                                //                 .data!
                                                //                 .serviceOrderInProgress ==
                                                //             null ||
                                                //         vegetationManagementDashboardViewModel
                                                //                 .vegetationManagementDashboardList
                                                //                 .data!
                                                //                 .serviceOrderInProgress
                                                //                 .toString() ==
                                                //             'null')
                                                //     ? ''
                                                //     : vegetationManagementDashboardViewModel
                                                //         .vegetationManagementDashboardList
                                                //         .data!
                                                //         .serviceOrderInProgress
                                                //         .toString(),
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 8, left: 8),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (BuildContext
                                                              context) =>
                                                          AdmSOReadyForReview()));
                                            },
                                            child: DashboardCard(
                                                cardIcon:
                                                    'assets/Orders_Open.png',
                                                cardColor: const Color.fromRGBO(
                                                    240, 129, 127, 1),
                                                cardTitle: 'Ready For Review',
                                                cardCount: soReadyforReviewCount
                                                    .toString()
                                                // (vegetationManagementDashboardViewModel
                                                //                 .vegetationManagementDashboardList
                                                //                 .data!
                                                //                 .serviceOrderReadyforReview ==
                                                //             null ||
                                                //         vegetationManagementDashboardViewModel
                                                //                 .vegetationManagementDashboardList
                                                //                 .data!
                                                //                 .serviceOrderReadyforReview
                                                //                 .toString() ==
                                                //             'null')
                                                //     ? ''
                                                //     : vegetationManagementDashboardViewModel
                                                //         .vegetationManagementDashboardList
                                                //         .data!
                                                //         .serviceOrderReadyforReview
                                                //         .toString(),
                                                ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (BuildContext
                                                              context) =>
                                                          AdmSOClosed()));
                                            },
                                            child: DashboardCard(
                                                cardIcon:
                                                    'assets/Orders_Open.png',
                                                cardColor: const Color.fromRGBO(
                                                    142, 189, 143, 1),
                                                cardTitle: 'Closed',
                                                cardCount:
                                                    soClosedCount.toString()
                                                // (vegetationManagementDashboardViewModel
                                                //                 .vegetationManagementDashboardList
                                                //                 .data!
                                                //                 .serviceOrderClosed ==
                                                //             null ||
                                                //         vegetationManagementDashboardViewModel
                                                //                 .vegetationManagementDashboardList
                                                //                 .data!
                                                //                 .serviceOrderClosed
                                                //                 .toString() ==
                                                //             'null')
                                                //     ? ''
                                                //     : vegetationManagementDashboardViewModel
                                                //         .vegetationManagementDashboardList
                                                //         .data!
                                                //         .serviceOrderClosed
                                                //         .toString(),
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                  top: 10, bottom: 10, left: 8, right: 8),
                              padding: const EdgeInsets.all(8),
                              alignment: Alignment.center,
                              // height: size.height * 0.55,
                              width: size.width * 0.99,
                              decoration: BoxDecoration(
                                  // shape: BoxShape.circle,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: AppColors.buttonShadow,
                                        blurRadius: 10,
                                        offset: Offset(2.0, 5.0))
                                  ],
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color.fromARGB(255, 255, 255, 255),
                                      Color.fromARGB(255, 255, 255, 255),
                                    ],
                                  )),
                              child: Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    alignment: Alignment.center,
                                    width: size.width * 0.99,
                                    // width: MediaQuery.of(context).size.width,
                                    // height: 40,
                                    decoration: const BoxDecoration(
                                        // shape: BoxShape.circle,
                                        //borderRadius: BorderRadius.circular(25),
                                        boxShadow: [
                                          BoxShadow(
                                              color: AppColors.buttonShadow,
                                              blurRadius: 5,
                                              offset: Offset(2.0, 5.0))
                                        ],
                                        gradient: LinearGradient(
                                          colors: [
                                            AppColors.baseColor,
                                            AppColors.buttonOrange,
                                            AppColors.baseColor,
                                          ],
                                        )),
                                    child: const Row(children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Distribution IVM",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                    ]),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                   Padding(
                                    padding: const EdgeInsets.only(
                                        right: 8, left: 8),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (BuildContext
                                                              context) =>
                                                          AdmDistributionIVmOPEN(
                                                            budgetType:
                                                                'Mid Cycle maintenance',
                                                            maintenanceType:
                                                                'RegularMaint',
                                                            heading:
                                                                'Mid Cycle',
                                                          )));
                                            },
                                            child: DashboardCard(
                                                cardIcon:
                                                    'assets/Orders_Pending.png',
                                                cardColor: const Color.fromRGBO(
                                                  2, 205, 205, 1),
                                                cardTitle: 'Open',
                                                cardCount:
                                                    distriIVMOpenCount
                                                        .toString()
                                                ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                          Expanded(
                                          child: InkWell(
                                            onTap: () {
                                              // Navigator.of(context).push(
                                              //     MaterialPageRoute(
                                              //         builder: (BuildContext
                                              //                 context) =>
                                              //             SupervisorAddNewRowTable(
                                              //                 index: '0')));
                                              // Navigator.of(context).push(
                                              //     MaterialPageRoute(
                                              //         builder: (BuildContext
                                              //                 context) =>
                                              //             SupervisorZIELIESDocumentApprovalPending(
                                              //               budgetType:
                                              //                   'Mid Cycle maintenance',
                                              //               maintenanceType:
                                              //                   'RegularMaint',
                                              //               heading: 'Mid Cycle',
                                              //             )));
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (BuildContext
                                                              context) =>
                                                          AdmDistributionIVmINPGROGRESS(
                                                            budgetType:
                                                                'Mid Cycle maintenance',
                                                            maintenanceType:
                                                                'RegularMaint',
                                                            heading:
                                                                'Mid Cycle',
                                                          )));
                                            },
                                            child: DashboardCard(
                                                cardIcon:
                                                    'assets/Orders_Pending.png',
                                                cardColor: const Color.fromRGBO(
                                                    237, 230, 141, 1),
                                                cardTitle: 'In Progress',
                                                cardCount:
                                                    distriIVMInprogressCount
                                                        .toString()
                                                //  (vegetationManagementDashboardViewModel
                                                //                 .vegetationManagementDashboardList
                                                //                 .data!
                                                //                 .distributionInProgress ==
                                                //             null ||
                                                //         vegetationManagementDashboardViewModel
                                                //                 .vegetationManagementDashboardList
                                                //                 .data!
                                                //                 .distributionInProgress
                                                //                 .toString() ==
                                                //             'null')
                                                //     ? ''
                                                //     : vegetationManagementDashboardViewModel
                                                //         .vegetationManagementDashboardList
                                                //         .data!
                                                //         .distributionInProgress
                                                //         .toString(),
                                                ),
                                          ),
                                        ),
                                       
                                        ],
                                    ),
                                  ),
                                 



                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 8, left: 8),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: InkWell(
                                            onTap: () {
                                              // Navigator.of(context).push(
                                              //     MaterialPageRoute(
                                              //         builder: (BuildContext
                                              //                 context) =>
                                              //             SupervisorZIELIESDocumentApprovalPending(
                                              //               budgetType:
                                              //                   'Regular IVM maintenance',
                                              //               maintenanceType:
                                              //                   'RegularMaint',
                                              //               heading:
                                              //                   'IVM maintenance',
                                              //             )));
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const AdmMaintenanceReportViewNew()));
                                            },
                                            child: DashboardCard(
                                                cardIcon:
                                                    'assets/Orders_Pending.png',
                                                cardColor: const Color.fromRGBO(
                                                    176, 196, 222, 1),
                                                cardTitle: 'Ready For Review',
                                                cardCount:
                                                    distriIVMReadyforReviewCount
                                                        .toString()
                                                //  (vegetationManagementDashboardViewModel
                                                //                 .vegetationManagementDashboardList
                                                //                 .data!
                                                //                 .distributionReadyForInspection ==
                                                //             null ||
                                                //         vegetationManagementDashboardViewModel
                                                //                 .vegetationManagementDashboardList
                                                //                 .data!
                                                //                 .distributionReadyForInspection
                                                //                 .toString() ==
                                                //             'null')
                                                //     ? ''
                                                //     : vegetationManagementDashboardViewModel
                                                //         .vegetationManagementDashboardList
                                                //         .data!
                                                //         .distributionReadyForInspection
                                                //         .toString(),
                                                ),
                                          ),
                                        ),
                                    
                                       const SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (BuildContext
                                                              context) =>
                                                          AdmDistributionIVmRejected(
                                                            budgetType:
                                                                'Regular IVM maintenance',
                                                            maintenanceType:
                                                                'RegularMaint',
                                                            heading: 'IVM',
                                                          )));
                                            },
                                            child: DashboardCard(
                                                cardIcon:
                                                    'assets/Orders_Pending.png',
                                                cardColor: const Color.fromRGBO(
                                                    240, 129, 127, 1),
                                                cardTitle: 'Rejected',
                                                cardCount:
                                                    distriIVMRejectedCount
                                                        .toString()
                                                //  (vegetationManagementDashboardViewModel
                                                //                 .vegetationManagementDashboardList
                                                //                 .data!
                                                //                 .distributionRejected ==
                                                //             null ||
                                                //         vegetationManagementDashboardViewModel
                                                //                 .vegetationManagementDashboardList
                                                //                 .data!
                                                //                 .distributionRejected
                                                //                 .toString() ==
                                                //             'null')
                                                //     ? ''
                                                //     : vegetationManagementDashboardViewModel
                                                //         .vegetationManagementDashboardList
                                                //         .data!
                                                //         .distributionRejected
                                                //         .toString(),
                                                ),
                                          ),
                                        ),
                                        ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 8, left: 8),
                                    child: Row(
                                      children: [
                                         Expanded(
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (BuildContext
                                                              context) =>
                                                          AdmDistributionIVmCompleted(
                                                            budgetType:
                                                                'Regular IVM maintenance',
                                                            maintenanceType:
                                                                'RegularMaint',
                                                            heading: 'IVM',
                                                          )));
                                            },
                                            child: DashboardCard(
                                                cardIcon:
                                                    'assets/Orders_Open.png',
                                                cardColor: const Color.fromRGBO(
                                                    142, 189, 143, 1),
                                                cardTitle: 'Closed',
                                                cardCount: distriIVMClosedCount
                                                    .toString()
                                                //  (vegetationManagementDashboardViewModel
                                                //                 .vegetationManagementDashboardList
                                                //                 .data!
                                                //                 .distributionCompleted ==
                                                //             null ||
                                                //         vegetationManagementDashboardViewModel
                                                //                 .vegetationManagementDashboardList
                                                //                 .data!
                                                //                 .distributionCompleted
                                                //                 .toString() ==
                                                //             'null')
                                                //     ? ''
                                                //     : vegetationManagementDashboardViewModel
                                                //         .vegetationManagementDashboardList
                                                //         .data!
                                                //         .distributionCompleted
                                                //         .toString(),
                                                ),
                                          ),
                                        ),
                                          const SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(child: Container())],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                  top: 10, bottom: 10, left: 8, right: 8),
                              padding: const EdgeInsets.all(8),
                              alignment: Alignment.center,
                              // height: size.height * 0.55,
                              width: size.width * 0.99,
                              decoration: BoxDecoration(
                                  // shape: BoxShape.circle,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: AppColors.buttonShadow,
                                        blurRadius: 10,
                                        offset: Offset(2.0, 5.0))
                                  ],
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color.fromARGB(255, 255, 255, 255),
                                      Color.fromARGB(255, 255, 255, 255),
                                    ],
                                  )),
                              child: Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    alignment: Alignment.center,
                                    width: size.width * 0.99,
                                    // width: MediaQuery.of(context).size.width,
                                    // height: 40,
                                    decoration: const BoxDecoration(
                                        // shape: BoxShape.circle,
                                        //borderRadius: BorderRadius.circular(25),
                                        boxShadow: [
                                          BoxShadow(
                                              color: AppColors.buttonShadow,
                                              blurRadius: 5,
                                              offset: Offset(2.0, 5.0))
                                        ],
                                        gradient: LinearGradient(
                                          colors: [
                                            AppColors.baseColor,
                                            AppColors.buttonOrange,
                                            AppColors.baseColor,
                                          ],
                                        )),
                                    child: const Row(children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Transmission IVM",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                    ]),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 8, left: 8),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          AdmTransmissionIvmInprogress()));
                                            },
                                            child: DashboardCard(
                                                cardIcon:
                                                    'assets/Orders_Pending.png',
                                                cardColor: const Color.fromRGBO(
                                                    237, 230, 141, 1),
                                                cardTitle: 'In Progress',
                                                cardCount:
                                                    transIVMInprogressCount
                                                        .toString()
                                                //  (vegetationManagementDashboardViewModel
                                                //                 .vegetationManagementDashboardList
                                                //                 .data!
                                                //                 .transmissionIVMInProgress ==
                                                //             null ||
                                                //         vegetationManagementDashboardViewModel
                                                //                 .vegetationManagementDashboardList
                                                //                 .data!
                                                //                 .transmissionIVMInProgress
                                                //                 .toString() ==
                                                //             'null')
                                                //     ? ''
                                                //     : vegetationManagementDashboardViewModel
                                                //         .vegetationManagementDashboardList
                                                //         .data!
                                                //         .transmissionIVMInProgress
                                                //         .toString(),
                                                ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          AdmTransmissionIvmReadyForReview()));
                                            },
                                            child: DashboardCard(
                                                cardIcon:
                                                    'assets/Orders_Pending.png',
                                                cardColor: const Color.fromRGBO(
                                                    2, 205, 205, 1),
                                                cardTitle: 'Ready For Review',
                                                cardCount:
                                                    transIVMReadyforReviewCount
                                                        .toString()
                                                //  (vegetationManagementDashboardViewModel
                                                //                 .vegetationManagementDashboardList
                                                //                 .data!
                                                //                 .transmissionIVMReadyForInspection ==
                                                //             null ||
                                                //         vegetationManagementDashboardViewModel
                                                //                 .vegetationManagementDashboardList
                                                //                 .data!
                                                //                 .transmissionIVMReadyForInspection
                                                //                 .toString() ==
                                                //             'null')
                                                //     ? ''
                                                //     : vegetationManagementDashboardViewModel
                                                //         .vegetationManagementDashboardList
                                                //         .data!
                                                //         .transmissionIVMReadyForInspection
                                                //         .toString(),
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 8, left: 8),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          AdmTransmissionIvmRejected()));
                                            },
                                            child: DashboardCard(
                                                cardIcon:
                                                    'assets/Orders_Pending.png',
                                                cardColor: const Color.fromRGBO(
                                                    240, 129, 127, 1),
                                                cardTitle: 'Rejected',
                                                cardCount: transIVMRejectedCount
                                                    .toString()
                                                // (vegetationManagementDashboardViewModel
                                                //                 .vegetationManagementDashboardList
                                                //                 .data!
                                                //                 .transmissionIVMRejected ==
                                                //             null ||
                                                //         vegetationManagementDashboardViewModel
                                                //                 .vegetationManagementDashboardList
                                                //                 .data!
                                                //                 .transmissionIVMRejected
                                                //                 .toString() ==
                                                //             'null')
                                                //     ? ''
                                                //     : vegetationManagementDashboardViewModel
                                                //         .vegetationManagementDashboardList
                                                //         .data!
                                                //         .transmissionIVMRejected
                                                //         .toString(),
                                                ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          AdmTransmissionIvmClosed()));
                                            },
                                            child: DashboardCard(
                                                cardIcon:
                                                    'assets/Orders_Open.png',
                                                cardColor: const Color.fromRGBO(
                                                    142, 189, 143, 1),
                                                cardTitle: 'Closed',
                                                cardCount: transIVMMClosedCount
                                                    .toString()
                                                //  (vegetationManagementDashboardViewModel
                                                //                 .vegetationManagementDashboardList
                                                //                 .data!
                                                //                 .transmissionIVMClosed ==
                                                //             null ||
                                                //         vegetationManagementDashboardViewModel
                                                //                 .vegetationManagementDashboardList
                                                //                 .data!
                                                //                 .transmissionIVMClosed
                                                //                 .toString() ==
                                                //             'null')
                                                //     ? ''
                                                //     : vegetationManagementDashboardViewModel
                                                //         .vegetationManagementDashboardList
                                                //         .data!
                                                //         .transmissionIVMClosed
                                                //         .toString(),
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                  top: 10, bottom: 10, left: 8, right: 8),
                              padding: const EdgeInsets.all(8),
                              alignment: Alignment.center,
                              // height: size.height * 0.55,
                              width: size.width * 0.99,
                              decoration: BoxDecoration(
                                  // shape: BoxShape.circle,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: AppColors.buttonShadow,
                                        blurRadius: 10,
                                        offset: Offset(2.0, 5.0))
                                  ],
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color.fromARGB(255, 255, 255, 255),
                                      Color.fromARGB(255, 255, 255, 255),
                                    ],
                                  )),
                              child: Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    alignment: Alignment.center,
                                    width: size.width * 0.99,
                                    // width: MediaQuery.of(context).size.width,
                                    // height: 40,
                                    decoration: const BoxDecoration(
                                        // shape: BoxShape.circle,
                                        //borderRadius: BorderRadius.circular(25),
                                        boxShadow: [
                                          BoxShadow(
                                              color: AppColors.buttonShadow,
                                              blurRadius: 5,
                                              offset: Offset(2.0, 5.0))
                                        ],
                                        gradient: LinearGradient(
                                          colors: [
                                            AppColors.baseColor,
                                            AppColors.buttonOrange,
                                            AppColors.baseColor,
                                          ],
                                        )),
                                    child: const Row(children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Transmission Herbicide",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                    ]),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 8, left: 8),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          AdmTransmissionHerbicideInprogress()));
                                            },
                                            child: DashboardCard(
                                                cardIcon:
                                                    'assets/Orders_Pending.png',
                                                iconColor: Colors.red,
                                                cardColor: const Color.fromRGBO(
                                                    237, 230, 141, 1),
                                                cardTitle: 'In Progress',
                                                cardCount:
                                                    transHerbicideInprogressCount
                                                        .toString()
                                                //  (vegetationManagementDashboardViewModel
                                                //                 .vegetationManagementDashboardList
                                                //                 .data!
                                                //                 .transmissionHerbicideInProgress ==
                                                //             null ||
                                                //         vegetationManagementDashboardViewModel
                                                //                 .vegetationManagementDashboardList
                                                //                 .data!
                                                //                 .transmissionHerbicideInProgress
                                                //                 .toString() ==
                                                //             'null')
                                                //     ? ''
                                                //     : vegetationManagementDashboardViewModel
                                                //         .vegetationManagementDashboardList
                                                //         .data!
                                                //         .transmissionHerbicideInProgress
                                                //         .toString(),
                                                ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          AdmTransmissionHerbicideReadyForReview()));
                                            },
                                            child: DashboardCard(
                                                cardIcon:
                                                    'assets/Orders_Pending.png',
                                                iconColor: Colors.red,
                                                cardColor: const Color.fromRGBO(
                                                    176, 196, 222, 1),
                                                cardTitle: 'Ready For Review',
                                                cardCount:
                                                    transHerbicideReadyforReviewCount
                                                        .toString()
                                                //  (vegetationManagementDashboardViewModel
                                                //                 .vegetationManagementDashboardList
                                                //                 .data!
                                                //                 .transmissionHerbicideReadyForInspection ==
                                                //             null ||
                                                //         vegetationManagementDashboardViewModel
                                                //                 .vegetationManagementDashboardList
                                                //                 .data!
                                                //                 .transmissionHerbicideReadyForInspection
                                                //                 .toString() ==
                                                //             'null')
                                                //     ? ''
                                                //     : vegetationManagementDashboardViewModel
                                                //         .vegetationManagementDashboardList
                                                //         .data!
                                                //         .transmissionHerbicideReadyForInspection
                                                //         .toString(),
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 8, left: 8),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (BuildContext
                                                              context) =>
                                                          AdmTransmissionHerbicideRejected()));
                                            },
                                            child: DashboardCard(
                                                cardIcon:
                                                    'assets/Orders_Pending.png',
                                                cardColor: const Color.fromRGBO(
                                                    240, 129, 127, 1),
                                                cardTitle: 'Rejected',
                                                cardCount:
                                                    transHerbicidRejectedCount
                                                        .toString()
                                                //  (vegetationManagementDashboardViewModel
                                                //                 .vegetationManagementDashboardList
                                                //                 .data!
                                                //                 .transmissionHerbicideRejected ==
                                                //             null ||
                                                //         vegetationManagementDashboardViewModel
                                                //                 .vegetationManagementDashboardList
                                                //                 .data!
                                                //                 .transmissionHerbicideRejected
                                                //                 .toString() ==
                                                //             'null')
                                                //     ? ''
                                                //     : vegetationManagementDashboardViewModel
                                                //         .vegetationManagementDashboardList
                                                //         .data!
                                                //         .transmissionHerbicideRejected
                                                //         .toString(),
                                                ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          AdmTransmissionHerbicideClosed()));
                                            },
                                            child: DashboardCard(
                                                cardIcon:
                                                    'assets/Orders_Open.png',
                                                cardColor: const Color.fromRGBO(
                                                    142, 189, 143, 1),
                                                cardTitle: 'Closed',
                                                cardCount:
                                                    transHerbicideClosedCount
                                                        .toString()
                                                //  (vegetationManagementDashboardViewModel
                                                //                 .vegetationManagementDashboardList
                                                //                 .data!
                                                //                 .transmissionHerbicideClosed ==
                                                //             null ||
                                                //         vegetationManagementDashboardViewModel
                                                //                 .vegetationManagementDashboardList
                                                //                 .data!
                                                //                 .transmissionHerbicideClosed
                                                //                 .toString() ==
                                                //             'null')
                                                //     ? ''
                                                //     : vegetationManagementDashboardViewModel
                                                //         .vegetationManagementDashboardList
                                                //         .data!
                                                //         .transmissionHerbicideClosed
                                                //         .toString(),
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                  top: 10, bottom: 10, left: 8, right: 8),
                              padding: const EdgeInsets.all(8),
                              alignment: Alignment.center,
                              // height: size.height * 0.55,
                              width: size.width * 0.99,
                              decoration: BoxDecoration(
                                  // shape: BoxShape.circle,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: AppColors.buttonShadow,
                                        blurRadius: 10,
                                        offset: Offset(2.0, 5.0))
                                  ],
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color.fromARGB(255, 255, 255, 255),
                                      Color.fromARGB(255, 255, 255, 255),
                                    ],
                                  )),
                              child: Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    alignment: Alignment.center,
                                    width: size.width * 0.99,
                                    // width: MediaQuery.of(context).size.width,
                                    // height: 40,
                                    decoration: const BoxDecoration(
                                        // shape: BoxShape.circle,
                                        //borderRadius: BorderRadius.circular(25),
                                        boxShadow: [
                                          BoxShadow(
                                              color: AppColors.buttonShadow,
                                              blurRadius: 5,
                                              offset: Offset(2.0, 5.0))
                                        ],
                                        gradient: LinearGradient(
                                          colors: [
                                            AppColors.baseColor,
                                            AppColors.buttonOrange,
                                            AppColors.baseColor,
                                          ],
                                        )),
                                    child: const Row(children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Annual Herbicide",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                    ]),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 8, left: 8),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          AdmAnnualHerbicideInprogress()));
                                            },
                                            child: DashboardCard(
                                                cardIcon:
                                                    'assets/Orders_Pending.png',
                                                iconColor: Colors.red,
                                                cardColor: const Color.fromRGBO(
                                                    237, 230, 141, 1),
                                                cardTitle: 'In Progress',
                                                cardCount:
                                                    annualHerbicideInprogressCount
                                                        .toString()
                                                //  (vegetationManagementDashboardViewModel
                                                //                 .vegetationManagementDashboardList
                                                //                 .data!
                                                //                 .annualHerbicideInProgress ==
                                                //             null ||
                                                //         vegetationManagementDashboardViewModel
                                                //                 .vegetationManagementDashboardList
                                                //                 .data!
                                                //                 .annualHerbicideInProgress
                                                //                 .toString() ==
                                                //             'null')
                                                //     ? ''
                                                //     : vegetationManagementDashboardViewModel
                                                //         .vegetationManagementDashboardList
                                                //         .data!
                                                //         .annualHerbicideInProgress
                                                //         .toString(),
                                                ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          AdmAnnualHerbicideReadyForReview()));
                                            },
                                            child: DashboardCard(
                                                cardIcon:
                                                    'assets/Orders_Pending.png',
                                                iconColor: Colors.red,
                                                cardColor: const Color.fromRGBO(
                                                    176, 196, 222, 1),
                                                cardTitle: 'Ready For Review',
                                                cardCount:
                                                    annualHerbicideReadyforReviewCount
                                                        .toString()
                                                // (vegetationManagementDashboardViewModel
                                                //                 .vegetationManagementDashboardList
                                                //                 .data!
                                                //                 .annualHerbicideReadyForInspection ==
                                                //             null ||
                                                //         vegetationManagementDashboardViewModel
                                                //                 .vegetationManagementDashboardList
                                                //                 .data!
                                                //                 .annualHerbicideReadyForInspection
                                                //                 .toString() ==
                                                //             'null')
                                                //     ? ''
                                                //     : vegetationManagementDashboardViewModel
                                                //         .vegetationManagementDashboardList
                                                //         .data!
                                                //         .annualHerbicideReadyForInspection
                                                //         .toString(),
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 8, left: 8),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          AdmAnnualHerbicideRejected()));
                                            },
                                            child: DashboardCard(
                                                cardIcon:
                                                    'assets/Orders_Pending.png',
                                                cardColor: const Color.fromRGBO(
                                                    240, 129, 127, 1),
                                                cardTitle: 'Rejected',
                                                cardCount:
                                                    annualHerbicideRejectedCount
                                                        .toString()
                                                // (vegetationManagementDashboardViewModel
                                                //                 .vegetationManagementDashboardList
                                                //                 .data!
                                                //                 .annualHerbicideRejected ==
                                                //             null ||
                                                //         vegetationManagementDashboardViewModel
                                                //                 .vegetationManagementDashboardList
                                                //                 .data!
                                                //                 .annualHerbicideRejected
                                                //                 .toString() ==
                                                //             'null')
                                                //     ? ''
                                                //     : vegetationManagementDashboardViewModel
                                                //         .vegetationManagementDashboardList
                                                //         .data!
                                                //         .annualHerbicideRejected
                                                //         .toString(),
                                                ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          AdmAnnualHerbicideClosed()));
                                            },
                                            child: DashboardCard(
                                                cardIcon:
                                                    'assets/Orders_Open.png',
                                                cardColor: const Color.fromRGBO(
                                                    142, 189, 143, 1),
                                                cardTitle: 'Closed',
                                                cardCount:
                                                    annualHerbicideClosedCount
                                                        .toString()
                                                //  (vegetationManagementDashboardViewModel
                                                //                 .vegetationManagementDashboardList
                                                //                 .data!
                                                //                 .annualHerbicideClosed ==
                                                //             null ||
                                                //         vegetationManagementDashboardViewModel
                                                //                 .vegetationManagementDashboardList
                                                //                 .data!
                                                //                 .annualHerbicideClosed
                                                //                 .toString() ==
                                                //             'null')
                                                //     ? ''
                                                //     : vegetationManagementDashboardViewModel
                                                //         .vegetationManagementDashboardList
                                                //         .data!
                                                //         .annualHerbicideClosed
                                                //         .toString(),
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ]),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Color.fromARGB(255, 7, 59, 120),
                  ),
                );
              }
            },
          )),
    );
    //  );
  }

  showSnackBar(String msg) {
    final snackBar = SnackBar(
      content: Text(msg),
      action: SnackBarAction(
        label: '',
        onPressed: () {
          // Some code to undo the change.
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<bool> showExitPopup(context) async {
    return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SizedBox(
              height: 90,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Do you want to exit?"),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            print('yes selected');
                            exit(0);
                          },
                          child: const Text("Yes",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red.shade800),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                          child: ElevatedButton(
                        onPressed: () {
                          print('no selected');
                          Navigator.of(context).pop();
                        },
                        child: const Text("No",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                      ))
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
      value: item,
      child: Text(item,
          style: const TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 20,
          )));

  static List<String> generateYearList() {
    DateTime now = DateTime.now();
    int currentYear = now.year;
    List<String> years = [];
    for (int i = currentYear - 4; i <= currentYear + 0; i++) {
      years.add(i.toString());
    }
    return years;
  }

  int woReadyforReviewCount = 0;
  int woTMprogressCount = 0;
  int woRejectedCount = 0;
  int woClosedCount = 0;
  int soReadyforReviewCount = 0;
  int soInprogressCount = 0;
  int soOpenCount = 0;
  int soClosedCount = 0;
  int distriIVMReadyforReviewCount = 0;
  int distriIVMInprogressCount = 0;
  int distriIVMRejectedCount = 0;
  int distriIVMClosedCount = 0;
  int distriIVMOpenCount = 0;

  int transIVMReadyforReviewCount = 0;
  int transIVMInprogressCount = 0;
  int transIVMRejectedCount = 0;
  int transIVMMClosedCount = 0;

  int transHerbicideReadyforReviewCount = 0;
  int transHerbicideInprogressCount = 0;
  int transHerbicidRejectedCount = 0;
  int transHerbicideClosedCount = 0;

  int annualHerbicideReadyforReviewCount = 0;
  int annualHerbicideInprogressCount = 0;
  int annualHerbicideRejectedCount = 0;
  int annualHerbicideClosedCount = 0;
  Future<void> fetchCardsCountMethod() async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel userData = await userPreferences.getUser();
    id = userData.user!.id.toString();
    print("id test ${id}");
    String url =
        "${AppUrl.vegetationManagementDataEndPoint}?action=TYPE&selectSpray=&selectMowing=&selectMowingNoSpray=&selectJaraffMowingSprayWork=&selectGroundWork=&selectJaraffMowingNoSpray=&selectBucketWork=&substation=&year=&month=&dateFrom=&dateTo=";
    //'${AppUrl.getgeneralForemanDashboardData}?userid=$id';

    print("url cards count $url");
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer ${userData.token}',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print('responseBody $data');

        print('API call successful $url');

        setState(() {
          // distriIVMPendingCount = data[''] ?? 0;
          woReadyforReviewCount = data['work_order_inspection_pending'] ?? 0;
          woTMprogressCount = data['work_order_inProgress'] ?? 0;
          woRejectedCount = data['work_order_rejected'] ?? 0;
          woClosedCount = data['work_order_completed'] ?? 0;
          soReadyforReviewCount = data['service_order_readyfor_review'] ?? 0;
          soInprogressCount = data['service_order_inProgress'] ?? 0;
          soOpenCount = data['service_order_open'] ?? 0;
          soClosedCount = data['service_order_closed'] ?? 0;
          distriIVMReadyforReviewCount =
              data['distribution_ready_for_inspection'] ?? 0;
          distriIVMInprogressCount = data['distribution_In_Progress'] ?? 0;
          distriIVMOpenCount = data['distribution_Open'] ?? 0;
          distriIVMRejectedCount = data['distribution_rejected'] ?? 0;
          distriIVMClosedCount = data['distribution_completed'] ?? 0;

          transIVMReadyforReviewCount =
              data['transmissionIVM_ready_for_inspection'] ?? 0;
          transIVMInprogressCount = data['transmissionIVM_In_Progress'] ?? 0;
          transIVMRejectedCount = data['transmissionIVM_rejected'] ?? 0;
          transIVMMClosedCount = data['transmissionIVM_closed'] ?? 0;

          transHerbicideReadyforReviewCount =
              data['transmissionHerbicide_ready_for_inspection'] ?? 0;
          transHerbicideInprogressCount =
              data['transmissionHerbicide_In_Progress'] ?? 0;
          transHerbicidRejectedCount =
              data['transmissionHerbicide_rejected'] ?? 0;
          transHerbicideClosedCount = data['transmissionHerbicide_closed'] ?? 0;

          annualHerbicideReadyforReviewCount =
              data['annualHerbicide_ready_for_inspection'] ?? 0;
          annualHerbicideInprogressCount =
              data['annualHerbicide_In_Progress'] ?? 0;
          annualHerbicideRejectedCount = data['annualHerbicide_rejected'] ?? 0;
          annualHerbicideClosedCount = data['annualHerbicide_closed'] ?? 0;
        });
      } else {
        setState(() {});
        print('Failed to update status: ${response.statusCode}');
      }
    } catch (e) {
      setState(() {});
      print('Error occurred: $e');
    }
  }
}

// ignore: must_be_immutable
// ignore: must_be_immutable
class DrawerManu extends StatefulWidget {
  List<String> menu;
  DrawerManu({Key? key, required this.menu}) : super(key: key);

  @override
  State<DrawerManu> createState() => _DrawerManuState();
}

class _DrawerManuState extends State<DrawerManu> {
  String userName = '';
  String? _imagePath;

  @override
  void initState() {
    setUserName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userPreferences = Provider.of<UserPref>(context);
    var provider = Provider.of<LocationProviderPemc>(context, listen: true);
    final browser = MyChromeSafariBrowser();
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 180,
              color: AppColors.lighterBaseColor,
              padding: const EdgeInsets.only(top: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  menuLogo(),
                  const SizedBox(height: 6),
                  Text(
                    userName,
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    leading: const Icon(
                      Icons.computer,
                    ),
                    title: const Text('Row Maintenance Plan'),
                    textColor: AppColors.baseColor,
                    iconColor: AppColors.baseColor,
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const EnergyAuditPannel()));
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.compare,
                    ),
                    title: const Text('Inspection'),
                    textColor: AppColors.baseColor,
                    iconColor: AppColors.baseColor,
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.pending,
                    ),
                    title: const Text('Service Order'),
                    textColor: AppColors.baseColor,
                    iconColor: AppColors.baseColor,
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const AdmServiceOrder()));
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.airplane_ticket_sharp,
                    ),
                    title: const Text('Job List'),
                    textColor: AppColors.baseColor,
                    iconColor: AppColors.baseColor,
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              AdminAddNewRowTable(index: '0')));
                    },
                  ),
                  ///////////new added maps for PEMC
                  ListTile(
                    leading: const Icon(
                      Icons.vertical_distribute,
                    ),
                    title: const Text('Add ROW Distribution Map'),
                    textColor: AppColors.baseColor,
                    iconColor: AppColors.baseColor,
                    onTap: () async {
                      String id = '';
                      final userPreferences1 =
                          Provider.of<UserPref>(context, listen: false);
                      UserModel data = await userPreferences1.getUser();
                      id = data.user!.id.toString();
                      await browser.open(
                          url: WebUri(
                              MapUrl.getPlannerDistributionMapEndPoint(id)),
                          settings: ChromeSafariBrowserSettings(
                              shareState: CustomTabsShareState.SHARE_STATE_OFF,
                              barCollapsingEnabled: true));
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.maps_ugc,
                    ),
                    title: const Text('Add ROW Transmission Map'),
                    textColor: AppColors.baseColor,
                    iconColor: AppColors.baseColor,
                    onTap: () async {
                      String id = '';
                      final userPreferences1 =
                          Provider.of<UserPref>(context, listen: false);
                      UserModel data = await userPreferences1.getUser();
                      id = data.user!.id.toString();
                      await browser.open(
                          url: WebUri(
                              MapUrl.getPlannerTransmissionMapEndPoint(id)),
                          settings: ChromeSafariBrowserSettings(
                              shareState: CustomTabsShareState.SHARE_STATE_OFF,
                              barCollapsingEnabled: true));
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.map,
                    ),
                    title: const Text('Add Herbicide Transmission Map'),
                    textColor: AppColors.baseColor,
                    iconColor: AppColors.baseColor,
                    onTap: () async {
                      String id = '';
                      final userPreferences1 =
                          Provider.of<UserPref>(context, listen: false);
                      UserModel data = await userPreferences1.getUser();
                      id = data.user!.id.toString();
                      await browser.open(
                          url: WebUri(MapUrl.midTransmissionMapEndPoint(id)),
                          settings: ChromeSafariBrowserSettings(
                              shareState: CustomTabsShareState.SHARE_STATE_OFF,
                              barCollapsingEnabled: true));
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.maps_ugc_rounded,
                    ),
                    title: const Text('Add Annual Herbicide Map'),
                    textColor: AppColors.baseColor,
                    iconColor: AppColors.baseColor,
                    onTap: () async {
                      String id = '';
                      final userPreferences1 =
                          Provider.of<UserPref>(context, listen: false);
                      UserModel data = await userPreferences1.getUser();
                      id = data.user!.id.toString();
                      await browser.open(
                          url: WebUri(MapUrl.officeTransmissionMapEndPoint(id)),
                          settings: ChromeSafariBrowserSettings(
                              shareState: CustomTabsShareState.SHARE_STATE_OFF,
                              barCollapsingEnabled: true));
                    },
                  ),

                  ////////////////////////////////////
                  ListTile(
                    leading: const Icon(
                      Icons.open_in_new,
                    ),
                    title: const Text('IVM Maintenance Progress'),
                    textColor: AppColors.baseColor,
                    iconColor: AppColors.baseColor,
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const RowMaintenanceProgress()));
                    },
                  ),
                  // ),
                  // ListTile(
                  //   leading: const Icon(
                  //     Icons.closed_caption_off,
                  //   ),
                  //   title: const Text('Row Analytics Dashboard'),
                  //   textColor: AppColors.baseColor,
                  //   iconColor: AppColors.baseColor,
                  //   onTap: () {
                  //     Navigator.of(context).push(MaterialPageRoute(
                  //         builder: (BuildContext context) =>
                  //             const RowAnalyticsDashboard()));
                  //   },
                  // ),
                  ListTile(
                    leading: const Icon(
                      Icons.list,
                    ),
                    title: const Text('Invoice List'),
                    textColor: AppColors.baseColor,
                    iconColor: AppColors.baseColor,
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const AdmInvoiceList()));
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.data_usage,
                    ),
                    title: const Text('Budget Planning'),
                    textColor: AppColors.baseColor,
                    iconColor: AppColors.baseColor,
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const BudgetPlanning()));
                    },
                  ),

                  ListTile(
                    leading: const Icon(
                      Icons.location_on,
                    ),
                    title: const Text('Live IVM System Map'),
                    textColor: AppColors.baseColor,
                    iconColor: AppColors.baseColor,
                    onTap: () {
                      provider.getLocation();
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const MapScreenLeafLat()));
                    },
                  ),
                  //       ListTile(
                  //   leading: const Icon(
                  //     Icons.map,
                  //   ),
                  //   title: const Text('Location Map'),
                  //   textColor: AppColors.baseColor,
                  //   iconColor: AppColors.baseColor,
                  //   onTap: () {
                  //     provider.getLocation();
                  //     Navigator.of(context)
                  //         .push(MaterialPageRoute(builder: (context) => Maps()));
                  //   },
                  // ),

                  ListTile(
                    leading: const Icon(
                      Icons.check,
                    ),
                    title: const Text('Approve CIVM Access'),
                    textColor: AppColors.baseColor,
                    iconColor: AppColors.baseColor,
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const ApproveCIVMAccess()));
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.add,
                    ),
                    title: const Text('Add Crew Member'),
                    textColor: AppColors.baseColor,
                    iconColor: AppColors.baseColor,
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const AddCrewMember()));
                    },
                  ),

                  ListTile(
                    leading: const Icon(
                      Icons.logout,
                    ),
                    title: const Text('Logout'),
                    textColor: AppColors.baseColor,
                    iconColor: AppColors.baseColor,
                    onTap: () {
                      // Constants.prefs.setBool("LoggedIn", false);
                      userPreferences.remove().then((value) {
                        // ignore: use_build_context_synchronously
                        // Navigator.pushReplacement(context, RoutesName.login);
                        // Navigator.pushNamed(
                        //     context, RoutesName.login);
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const LoginPagePemc()));
                      });
                      // Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (BuildContext context) => const LoginPage()));
                    },
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Text(
                    'Version: ${Constants.prefs.getString('VERSION') ?? ''}',
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    'Updated: ${Constants.prefs.getString('VERSION_DATE') ?? ''}',
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> setUserName() async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    Image.network(
      'https://atsdev2test.ariespro.com/assets/clientuploads/${data.user!.profilePhoto}',
    );
    String imageUrl =
        'https://atsdev2test.ariespro.com/assets/clientuploads/${data.user!.profilePhoto}';
    _imagePath = imageUrl;
    setState(() {
      userName = '${data.user!.fName} ${data.user!.lName}';
    });
  }
}
