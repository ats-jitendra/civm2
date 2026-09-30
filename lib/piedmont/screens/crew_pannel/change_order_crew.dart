import 'dart:convert';
import 'dart:io';

import 'package:CIVM/piedmont/resources/app_colors.dart';
import 'package:CIVM/piedmont/resources/app_url.dart';
import 'package:CIVM/piedmont/screens/crew_pannel/crew_SO_Open.dart';
import 'package:CIVM/piedmont/screens/crew_pannel/crew_SO_closed.dart';
import 'package:CIVM/piedmont/screens/crew_pannel/crew_SO_inprogress.dart';
import 'package:CIVM/piedmont/screens/crew_pannel/crew_SO_ready_for_review.dart';
import 'package:CIVM/piedmont/screens/crew_pannel/crew_WO_Closed.dart';
import 'package:CIVM/piedmont/screens/crew_pannel/crew_WO_Assigned.dart';
import 'package:CIVM/piedmont/screens/crew_pannel/crew_WO_worked.dart';
import 'package:CIVM/piedmont/screens/crew_pannel/crew_WO_rejected.dart.dart';
import 'package:CIVM/piedmont/screens/crew_pannel/crew_bottom_navigation_pannel.dart';
import 'package:CIVM/piedmont/screens/crew_pannel/crew_ivm_maintenance_plan_table.dart';
import 'package:CIVM/piedmont/screens/leaflat_map/leaf_lat_map_wakeLock.dart';
import 'package:CIVM/piedmont/screens/login_page.dart';
import 'package:CIVM/piedmont/screens/map/provider/location_provider.dart';
import 'package:CIVM/piedmont/screens/my_chrome_safari_map_recording.dart';
import 'package:CIVM/sharedPrefs/constants.dart';
import 'package:CIVM/piedmont/utils/common_functions.dart';
import 'package:CIVM/utils/user_pref.dart';
import 'package:CIVM/models/user_model.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:provider/provider.dart';

import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class ChangeOrderCrew extends StatefulWidget {
  // String budgetType;
  // String maintenanceType;
  // String heading;

  ChangeOrderCrew({
    Key? key,
    // required this.budgetType,
    // required this.maintenanceType,
    // required this.heading
  }) : super(key: key);

  @override
  State<ChangeOrderCrew> createState() => _ChangeOrderCrewState();
}

class _ChangeOrderCrewState extends State<ChangeOrderCrew> {
  String id = "";
  // final List<Widget> _children = [
  //   RowMaintenancePlan(),
  //   // BottomNavigationHomePage(),
  //   // BottomNavigationAccountPage()
  // ];
  List<String> menu = [];

  onTappedBar(int index) {
    setState(() {
      // _currentIndex = index;
    });
  }

  // ignore: prefer_typing_uninitialized_variables
  var selectedWorkOrderNo;

  // ContractorChangeOrderViewModel contractorChangeOrderViewModel =
  //     ContractorChangeOrderViewModel();
  // LCPViewModel lCPViewModel = LCPViewModel();

  late final Future? myFuture;

  @override
  void initState() {
    // contractorChangeOrderViewModel.fetchContractorChangeOrdercountApi(context);
    myFuture = fetchCardsCountMethod();
    // getContractorDataCount();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var provider = Provider.of<LocationProviderPemc>(context, listen: true);
    final userPreferences = Provider.of<UserPref>(context);
    return PopScope(
        canPop: false,
        onPopInvoked: ((didpop) {
          if (didpop) {
            return;
          }
          showExitPopup(context);
        }),
        child: Scaffold(
            backgroundColor: AppColors.backgroundColor,
            appBar: AppBar(
              iconTheme: const IconThemeData(color: Colors.white),
              title: const Text(
                'Dashboard',
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: AppColors.baseColor,
              actions: [
                IconButton(
                  icon: const Icon(Icons.logout, color: Colors.white),
                  onPressed: () {
                    userPreferences.remove().then((value) {
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
            // drawer: DrawerManu(menu: menu),
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
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
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
                                                              CrewWOAssigned(
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
                                                  cardColor:
                                                      const Color.fromRGBO(
                                                          237, 230, 141, 1),
                                                  cardTitle: 'Assigned',
                                                  cardCount: woInprogressCount
                                                      .toString(),
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
                                                              CrewWORejected(
                                                                budgetType: '',
                                                                maintenanceType:
                                                                    'ChangeOrder',
                                                                heading: 'CO',
                                                              )));
                                                },
                                                child: DashboardCard(
                                                  cardIcon:
                                                      'assets/Orders_Open.png',
                                                  cardColor:
                                                      const Color.fromRGBO(
                                                          240, 129, 127, 1),
                                                  cardTitle: 'Rejected',
                                                  cardCount: woRejectedCount
                                                      .toString(),
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
                                                              CrewWOWorked(
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
                                                  cardColor:
                                                      const Color.fromRGBO(
                                                          176, 196, 222, 1),
                                                  cardTitle: 'Worked',
                                                  cardCount:
                                                      woInspectionPendingCount
                                                          .toString(),
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
                                                              CrewWOClosed(
                                                                budgetType: '',
                                                                maintenanceType:
                                                                    'ChangeOrder',
                                                                heading: 'CO',
                                                              )));
                                                },
                                                child: DashboardCard(
                                                  cardIcon:
                                                      'assets/Orders_Open.png',
                                                  cardColor:
                                                      const Color.fromRGBO(
                                                          142, 189, 143, 1),
                                                  cardTitle: 'Closed',
                                                  cardCount: woCompletedCount
                                                      .toString(),
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
                                              "Service Order",
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
                                                              CrewSOOpen()));
                                                },
                                                child: DashboardCard(
                                                  cardIcon:
                                                      'assets/Orders_Pending.png',
                                                  cardColor:
                                                      const Color.fromRGBO(
                                                          2, 205, 205, 1),
                                                  cardTitle: 'Open',
                                                  cardCount:
                                                      soOpenCount.toString(),
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
                                                              CrewSOInprogress()));
                                                },
                                                child: DashboardCard(
                                                  cardIcon:
                                                      'assets/Orders_Pending.png',
                                                  cardColor:
                                                      const Color.fromRGBO(
                                                          237, 230, 141, 1),
                                                  cardTitle: 'Assigned',
                                                  cardCount: soInprogressCount
                                                      .toString(),
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
                                                              CrewSOReadyForReview()));
                                                },
                                                child: DashboardCard(
                                                  cardIcon:
                                                      'assets/Orders_Open.png',
                                                  cardColor:
                                                      const Color.fromRGBO(
                                                          240, 129, 127, 1),
                                                  cardTitle: 'Worked',
                                                  cardCount:
                                                      soReadyForReviewCount
                                                          .toString(),
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
                                                              CrewSOClosed()));
                                                },
                                                child: DashboardCard(
                                                  cardIcon:
                                                      'assets/Orders_Open.png',
                                                  cardColor:
                                                      const Color.fromRGBO(
                                                          142, 189, 143, 1),
                                                  cardTitle: 'Closed',
                                                  cardCount:
                                                      soClosedCount.toString(),
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
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 0, bottom: 10, left: 8, right: 8),
                                  child: InkWell(
                                    onTap: () async {
                                      provider.getLocation();
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const MapScreenLeafLat()));
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(top: 10.0),
                                      padding: const EdgeInsets.all(8),
                                      alignment: Alignment.center,
                                      height: size.height * 0.15,
                                      width: size.width * 0.99,
                                      decoration: BoxDecoration(
                                          // shape: BoxShape.circle,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: const [
                                            BoxShadow(
                                                color: Color.fromARGB(
                                                    255, 2, 75, 4),
                                                blurRadius: 5,
                                                offset: Offset(2.0, 5.0))
                                          ],
                                          gradient: const LinearGradient(
                                            colors: [
                                              Colors.white,
                                              Colors.white,
                                            ],
                                          )),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            const Expanded(
                                              flex: 2,
                                              child: Align(
                                                alignment: Alignment.topCenter,
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 10.0, bottom: 10),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                15.0)),
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 8.0),
                                                      child: Image(
                                                        image: AssetImage(
                                                            'assets/map1.png'),
                                                        // color:Color.fromARGB(255, 83, 116, 47),
                                                        color: Color.fromARGB(
                                                            255, 102, 143, 57),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const Expanded(
                                              flex: 3,
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    bottom: 10.0, top: 10),
                                                child: Text(
                                                  "PEMC System Map",
                                                  // "Live IVM System Map",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 102, 143, 57),
                                                    //  Color.fromARGB(
                                                    //     255, 82, 185, 13),
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Container(),
                                            ),
                                          ]),
                                    ),
                                  ),
                                ),

                                //       Container(
                                //   margin: const EdgeInsets.only(
                                //       top: 10, bottom: 10, left: 8, right: 8),
                                //   padding: const EdgeInsets.all(8),
                                //   alignment: Alignment.center,
                                //   // height: size.height * 0.55,
                                //   width: size.width * 0.99,
                                //   decoration: BoxDecoration(
                                //       // shape: BoxShape.circle,
                                //       borderRadius: BorderRadius.circular(10),
                                //       boxShadow: const [
                                //         BoxShadow(
                                //             color: AppColors.buttonShadow,
                                //             blurRadius: 10,
                                //             offset: Offset(2.0, 5.0))
                                //       ],
                                //       gradient: const LinearGradient(
                                //         colors: [
                                //           Color.fromARGB(255, 255, 255, 255),
                                //           Color.fromARGB(255, 255, 255, 255),
                                //         ],
                                //       )),
                                //   child: Column(
                                //     children: [
                                //       Container(
                                //         padding: const EdgeInsets.all(10),
                                //         alignment: Alignment.center,
                                //         width: size.width * 0.99,
                                //         // width: MediaQuery.of(context).size.width,
                                //         // height: 40,
                                //         decoration: const BoxDecoration(
                                //             // shape: BoxShape.circle,
                                //             //borderRadius: BorderRadius.circular(25),
                                //             boxShadow: [
                                //               BoxShadow(
                                //                   color: AppColors.buttonShadow,
                                //                   blurRadius: 5,
                                //                   offset: Offset(2.0, 5.0))
                                //             ],
                                //             gradient: LinearGradient(
                                //               colors: [
                                //                 AppColors.baseColor,
                                //                 AppColors.buttonOrange,
                                //                 AppColors.baseColor,
                                //               ],
                                //             )),
                                //         child: const Row(children: [
                                //           Align(
                                //             alignment: Alignment.centerLeft,
                                //             child: Text(
                                //               "Service Order",
                                //               textAlign: TextAlign.left,
                                //               style: TextStyle(
                                //                 color: Colors.white,
                                //                 fontWeight: FontWeight.bold,
                                //                 fontSize: 20,
                                //               ),
                                //             ),
                                //           ),
                                //         ]),
                                //       ),
                                //       const SizedBox(
                                //         height: 10,
                                //       ),
                                //       Padding(
                                //         padding:
                                //             const EdgeInsets.only(right: 8, left: 8),
                                //         child: Row(
                                //           children: [

                                //             Expanded(
                                //               child: InkWell(
                                //                 onTap: () {
                                //                   // Navigator.of(context).push(
                                //                   //     MaterialPageRoute(
                                //                   //         builder: (BuildContext
                                //                   //                 context) =>
                                //                   //             SupervisorZIELIESTotalOrderPending(
                                //                   //               budgetType: '',
                                //                   //               maintenanceType:
                                //                   //                   'Change Order',
                                //                   //               heading: 'Change Order',
                                //                   //             )));
                                //                 },
                                //                 child: DashboardCard(
                                //                   cardIcon: 'assets/Orders_Pending.png',
                                //                   cardColor: const Color.fromRGBO(
                                //                       237, 230, 141, 1),
                                //                   cardTitle: 'Assigned',
                                //                   cardCount: initiatedCount.toString(),
                                //                 ),
                                //               ),
                                //             ),
                                //               const SizedBox(
                                //               width: 10,
                                //             ),
                                //               Expanded(
                                //               child: InkWell(
                                //                 onTap: () {
                                //                   // Navigator.of(context).push(
                                //                   //           MaterialPageRoute(
                                //                   //               builder: (BuildContext
                                //                   //                       context) =>
                                //                   //                   SupervisorZIELIESTotalOrderRejectCO(
                                //                   //                     budgetType: '',
                                //                   //                     maintenanceType:
                                //                   //                         'Change Order',
                                //                   //                     heading: 'CO',
                                //                   //                   )));
                                //                 },
                                //                 child: DashboardCard(
                                //                   cardIcon: 'assets/Orders_Open.png',
                                //                   cardColor: const Color.fromRGBO(
                                //                      240, 129, 127, 1),
                                //                   cardTitle: 'Rejected',
                                //                   cardCount: initiatedCount.toString(),
                                //                 ),
                                //               ),
                                //             ),
                                //            ],
                                //         ),
                                //       ),
                                //       Padding(
                                //         padding:
                                //             const EdgeInsets.only(right: 8, left: 8),
                                //         child: Row(
                                //           children: [
                                //               Expanded(
                                //               child: InkWell(
                                //                 onTap: () {
                                //                   // Navigator.of(context).push(
                                //                   //     MaterialPageRoute(
                                //                   //         builder: (BuildContext
                                //                   //                 context) =>
                                //                   //             SupervisorZIELIESDocumentApprovalPending(
                                //                   //               budgetType: '',
                                //                   //               maintenanceType:
                                //                   //                   'Change Order',
                                //                   //               heading: 'Change Order',
                                //                   //             )));
                                //                 },
                                //                 child: DashboardCard(
                                //                   cardIcon: 'assets/Orders_Pending.png',
                                //                   cardColor:const Color.fromRGBO(
                                //                       2, 205, 205, 1),
                                //                   cardTitle: 'Worked',
                                //                   cardCount: initiatedCount.toString(),
                                //                 ),
                                //               ),
                                //             ),
                                //             const SizedBox(
                                //               width: 10,
                                //             ),
                                //             Expanded(
                                //               child: InkWell(
                                //                 onTap: () {
                                //                   // Navigator.of(context).push(
                                //                   //     MaterialPageRoute(
                                //                   //         builder: (BuildContext
                                //                   //                 context) =>
                                //                   //             SupervisorZIELIESTotalOrderClosed(
                                //                   //               budgetType: '',
                                //                   //               maintenanceType:
                                //                   //                   'Change Order',
                                //                   //               heading: 'CO',
                                //                   //             )));
                                //                 },
                                //                 child: DashboardCard(
                                //                   cardIcon: 'assets/Orders_Open.png',
                                //                   cardColor:  const Color.fromRGBO(
                                //                      142, 189, 143, 1),
                                //                   cardTitle: 'Closed',
                                //                   cardCount: initiatedCount.toString(),
                                //                 ),
                                //               ),
                                //             ),
                                //            ],
                                //         ),
                                //       ),
                                //       const SizedBox(
                                //         height: 10,
                                //       ),
                                //     ],
                                //   ),
                                // ),

                                // DashboardCard(
                                //   title: 'Total Order (Initiated)',
                                //   imagePath: 'assets/Dash_1.jpg',
                                //   height: size.height * 0.15,
                                //   width: size.width * 0.99,
                                //   count: initiatedCount.toString(),
                                //   onTap: () {
                                //     Navigator.of(context).push(
                                //       MaterialPageRoute(
                                //         builder: (context) =>
                                //             CrewTotalOrderIniciated(
                                //           budgetType: widget.budgetType,
                                //           maintenanceType: widget.maintenanceType,
                                //           heading: 'Total Order Initiated',
                                //         ),
                                //       ),
                                //     );
                                //   },
                                // ),
                                // DashboardCard(
                                //   title: 'Pending Approval',
                                //   imagePath: 'assets/Dash_2.jpg',
                                //   height: size.height * 0.15,
                                //   width: size.width * 0.99,
                                //   count: pendingApprovalCount.toString(),
                                //   onTap: () {
                                //     Navigator.of(context).push(
                                //       MaterialPageRoute(
                                //         builder: (context) =>
                                //             CrewTotalOrderPendingApproval(
                                //           budgetType: widget.budgetType,
                                //           maintenanceType: widget.maintenanceType,
                                //           heading:
                                //               'Pending Approval (${widget.heading})',
                                //         ),
                                //       ),
                                //     );
                                //   },
                                // ),
                                // DashboardCard(
                                //   title: 'Pending',
                                //   imagePath: 'assets/Dash_3.png',
                                //   height: size.height * 0.15,
                                //   width: size.width * 0.99,
                                //   count: pendingCount.toString(),
                                //   onTap: () {
                                //     Navigator.of(context).push(
                                //       MaterialPageRoute(
                                //         builder: (context) =>
                                //             CrewTotalOrderPending(
                                //           budgetType: widget.budgetType,
                                //           maintenanceType: widget.maintenanceType,
                                //           heading:
                                //               'Pending (${widget.heading})',
                                //         ),
                                //       ),
                                //     );
                                //   },
                                // ),
                                // DashboardCard(
                                //   title: 'Assigned',
                                //   imagePath: 'assets/Dash_4.jpg',
                                //   height: size.height * 0.15,
                                //   width: size.width * 0.99,
                                //   count: assignedCount.toString(),
                                //   onTap: () {
                                //     Navigator.of(context).push(
                                //       MaterialPageRoute(
                                //         builder: (context) =>
                                //             const ChangeOrderTable(),
                                //       ),
                                //     );
                                //   },
                                // ),
                                // DashboardCard(
                                //   title: 'Total Order (Rejected)',
                                //   imagePath: 'assets/Dash_6.jpg',
                                //   height: size.height * 0.15,
                                //   width: size.width * 0.99,
                                //   count: rejectedCount.toString(),
                                //   onTap: () {
                                //     Navigator.of(context).push(
                                //       MaterialPageRoute(
                                //         builder: (context) =>
                                //             const ChangeOrderTableRejected(),
                                //       ),
                                //     );
                                //   },
                                // ),
                                // DashboardCard(
                                //   title: 'Worked',
                                //   imagePath: 'assets/Dash_5.jpg',
                                //   height: size.height * 0.15,
                                //   width: size.width * 0.99,
                                //   count: workedCount.toString(),
                                //   onTap: () {
                                //     Navigator.of(context).push(
                                //       MaterialPageRoute(
                                //         builder: (context) => CrewTotalOrderWorked(
                                //           budgetType: widget.budgetType,
                                //           maintenanceType: widget.maintenanceType,
                                //           heading:
                                //               'Total Order Inspection (${widget.heading})',
                                //         ),
                                //       ),
                                //     );
                                //   },
                                // ),
                                // DashboardCard(
                                //   title: 'Total Orders (Completed)',
                                //   imagePath: 'assets/Dash_1.jpg',
                                //   height: size.height * 0.15,
                                //   width: size.width * 0.99,
                                //   count: completedCount.toString(),
                                //   onTap: () {
                                //     Navigator.of(context).push(
                                //       MaterialPageRoute(
                                //         builder: (context) => CrewTotalOrderClosed(
                                //           budgetType: widget.budgetType,
                                //           maintenanceType: widget.maintenanceType,
                                //           heading:
                                //               'Total Order Closed (${widget.heading})',
                                //         ),
                                //       ),
                                //     );
                                //   },
                                // ),
                                // DashboardCard(
                                //   title: 'Total Orders (Cancelled)',
                                //   imagePath: 'assets/Dash_6.jpg',
                                //   height: size.height * 0.15,
                                //   width: size.width * 0.99,
                                //   count: cancelledCount.toString(),
                                //   onTap: () {
                                //     Navigator.of(context).push(
                                //       MaterialPageRoute(
                                //         builder: (context) =>
                                //             CrewTotalOrderCancelled(
                                //           budgetType: widget.budgetType,
                                //           maintenanceType: widget.maintenanceType,
                                //           heading:
                                //               'Total Order Cancelled (${widget.heading})',
                                //         ),
                                //       ),
                                //     );
                                //   },
                                // ),
                              ],
                            ),
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
            )));
  }

  int woInspectionPendingCount = 0;
  int woInprogressCount = 0;
  int woRejectedCount = 0;
  int woCompletedCount = 0;
  int soOpenCount = 0;
  int soInprogressCount = 0;
  int soReadyForReviewCount = 0;
  int soClosedCount = 0;

  Future<void> fetchCardsCountMethod() async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel userData = await userPreferences.getUser();
    id = userData.user!.id.toString();
    print("id test ${id}");
    String url = '${AppUrl.workAndServiceOrderCount}';

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
        //  initiatedCount = data['countOfInitiatedOrder'] ?? 0;
        setState(() {
          print('UI building-----------------');
          woInspectionPendingCount = data['work_order_inspection_pending'] ?? 0;
          woInprogressCount = data['work_order_inProgress'] ?? 0;
          woRejectedCount = data['work_order_rejected'] ?? 0;
          woCompletedCount = data['work_order_completed'] ?? 0;
          soOpenCount = data['service_order_open'] ?? 0;
          soInprogressCount = data['service_order_inProgress'] ?? 0;
          soReadyForReviewCount = data['service_order_readyfor_review'] ?? 0;
          soClosedCount = data['service_order_closed'] ?? 0;
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

  Future<bool> showExitPopup(context) async {
    return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SizedBox(
              height: 100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Text(
                      "Do you want to exit?",
                      style: TextStyle(
                        color: AppColors.baseColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            exit(0);
                          },
                          child: const Text("Yes",
                              style: TextStyle(color: Colors.white)),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red.shade800),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                          child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text("No",
                            style: TextStyle(color: Colors.white)),
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
}

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
  final browser = MyChromeSafariBrowser();
  @override
  void initState() {
    setUserName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userPreferences = Provider.of<UserPref>(context);
    var provider = Provider.of<LocationProviderPemc>(context, listen: true);
    return Drawer(
      child: SafeArea(
        child: Column(
          // Important: Remove any padding from the ListView.
          // padding: EdgeInsets.zero,
          children: [
            Container(
              width: double.infinity,
              height: 180,
              color: const Color.fromARGB(255, 3, 47, 97),
              padding: const EdgeInsets.only(top: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipOval(
                      child: _imagePath != null
                          ? Image.network(
                              _imagePath!,
                              height: 100,
                              width: 100,
                              fit: BoxFit.cover,
                            )
                          : Image.asset(
                              'assets/person_icon.jpg',
                              height: 100,
                              width: 100,
                              fit: BoxFit.cover,
                            )),
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
                    title: const Text('Crew Dashboard'),
                    textColor: const Color.fromARGB(255, 7, 59, 120),
                    iconColor: const Color.fromARGB(255, 7, 59, 120),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const CrewBottomNavigationPannel()));
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.running_with_errors,
                    ),
                    title: const Text('IVM Maintenance Job List'),
                    textColor: const Color.fromARGB(255, 7, 59, 120),
                    iconColor: const Color.fromARGB(255, 7, 59, 120),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const CrewIVMMaintenancePlanTable()));
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.table_view,
                    ),
                    title: const Text('View Change Order'),
                    textColor: const Color.fromARGB(255, 7, 59, 120),
                    iconColor: const Color.fromARGB(255, 7, 59, 120),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  // ListTile(
                  //   leading: const Icon(
                  //     Icons.map,
                  //   ),
                  //   title: const Text('Map View'),
                  //   textColor: const Color.fromARGB(255, 7, 59, 120),
                  //   iconColor: const Color.fromARGB(255, 7, 59, 120),
                  //   onTap: () async {
                  //     String id = '';
                  //     final userPreferences1 =
                  //         Provider.of<UserPref>(context, listen: false);
                  //     UserModel data = await userPreferences1.getUser();
                  //     id = data.user!.id.toString();
                  //     //  Navigator.push(
                  //     //                 context,
                  //     //                 MaterialPageRoute(
                  //     //                   builder: (context) =>
                  //     //                       MapViewPage(
                  //     //                     url: MapUrl.getCrewWithIdEndPoint(id),
                  //     //                   ),
                  //     //                 ),
                  //     //               );

                  //     await browser.open(
                  //         url: WebUri(MapUrl.getCrewWithIdEndPoint(id)),
                  //         // "https://mapapi.ariespro.com/main/crew_main/CIVM_Map/USRQWXH589Z/${id}"),
                  //         settings: ChromeSafariBrowserSettings(
                  //             shareState: CustomTabsShareState.SHARE_STATE_OFF,
                  //             barCollapsingEnabled: true));
                  //   },
                  // ),
                  ListTile(
                    leading: const Icon(
                      Icons.location_on,
                    ),
                    title: const Text('LCP System Map'),
                    textColor: const Color.fromARGB(255, 7, 59, 120),
                    iconColor: const Color.fromARGB(255, 7, 59, 120),
                    onTap: () {
                      provider.getLocation();
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const MapScreenLeafLat()));
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.logout,
                    ),
                    title: const Text('Log Out'),
                    textColor: const Color.fromARGB(255, 7, 59, 120),
                    iconColor: const Color.fromARGB(255, 7, 59, 120),
                    onTap: () {
                      // // Constants.prefs.setBool("LoggedIn", false);
                      userPreferences.remove().then((value) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const LoginPagePemc()));
                      });
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
      'https://civm.ariespro.com/assets/clientuploads/${data.user!.profilePhoto}',
    );
    String imageUrl =
        'https://civm.ariespro.com/assets/clientuploads/${data.user!.profilePhoto}';
    _imagePath = imageUrl;
    setState(() {
      String fName =
          (data.user!.fName == 'null') ? '' : data.user!.fName.toString();
      String lName =
          (data.user!.lName == 'null') ? '' : data.user!.lName.toString();
      // userName = '${data.user!.fName} ${(data.user!.lName) != null? data.user!.lName :''}';
      userName = '$fName $lName';
    });
  }
}
