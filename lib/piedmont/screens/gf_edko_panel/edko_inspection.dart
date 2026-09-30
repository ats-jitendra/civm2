import 'dart:convert';
import 'dart:io';
import 'package:CIVM/piedmont/repository/map_url.dart';
import 'package:CIVM/piedmont/screens/gf_edko_panel/edko_annual_Herbicde_TO_pending_inspection.dart';
import 'package:CIVM/piedmont/screens/gf_edko_panel/edko_annual_Herbicide_TO_closed.dart';
import 'package:CIVM/piedmont/screens/gf_edko_panel/edko_annual_Herbicide_TO_pending.dart';
import 'package:CIVM/piedmont/screens/gf_edko_panel/edko_annual_Herbicide_TO_rejected.dart';
import 'package:CIVM/piedmont/screens/gf_edko_panel/edko_bottom_navigation.dart';
import 'package:CIVM/piedmont/screens/gf_edko_panel/edko_trans_Herbicide_TO_closed.dart';
import 'package:CIVM/piedmont/screens/gf_edko_panel/edko_trans_Herbicide_TO_pending.dart';
import 'package:CIVM/piedmont/screens/gf_edko_panel/edko_trans_Herbicide_TO_pending_inspection.dart';
import 'package:CIVM/piedmont/screens/gf_edko_panel/edko_trans_Herbicide_TO_rejected.dart';
import 'package:CIVM/utils/user_pref.dart';
import 'package:CIVM/models/user_model.dart';
import 'package:CIVM/piedmont/resources/app_colors.dart';
import 'package:CIVM/piedmont/resources/app_url.dart';
import 'package:CIVM/piedmont/screens/login_page.dart';
import 'package:CIVM/piedmont/screens/map/provider/location_provider.dart';
import 'package:CIVM/piedmont/screens/my_chrome_safari_map_recording.dart';
// import 'package:CIVM/piedmont/screens/supervisor_pannel/location_map.dart';
import 'package:CIVM/sharedPrefs/constants.dart';
import 'package:CIVM/piedmont/utils/common_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:CIVM/piedmont/screens/leaflat_map/leaf_lat_map_wakeLock.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class EdkoInspection extends StatefulWidget {
  const EdkoInspection({Key? key}) : super(key: key);

  @override
  State<EdkoInspection> createState() => _EdkoInspectionState();
}

class _EdkoInspectionState extends State<EdkoInspection> {
  List<Map<String, dynamic>> listOfColumns = [];
  List<Map<String, dynamic>> listOfColumns1 = [];
  var result = [];
  List<String> menu = [];

  int loadingFlag = 0;

  int uniqueDataCount = 0;

  var state;
  // var _setState;

  DateTimeRange? dateRange;
  String startDateSelected = DateFormat('yyyy-MM-dd').format(
    DateTime.now().subtract(const Duration(days: 7)),
  );
  String endDateSelected = DateFormat('yyyy-MM-dd').format(DateTime.now());

  late String dateSelected1 = '$startDateSelected - $endDateSelected';

  Future<void> selectDateRange(BuildContext context) async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2010),
      lastDate: DateTime(2050),
      initialDateRange: dateRange ??
          DateTimeRange(
            start: DateTime.now().subtract(const Duration(days: 7)),
            end: DateTime.now(),
          ),
    );
    if (picked != null && picked != dateRange) {
      setState(() {
        dateRange = picked;
        startDateSelected = DateFormat('yyyy-MM-dd').format(picked.start);
        endDateSelected = DateFormat('yyyy-MM-dd').format(picked.end);
        dateSelected1 = '$startDateSelected - $endDateSelected';
      });
    }
  }

  // ignore: non_constant_identifier_names
  final select_type = ['Daily', 'Monthly'];
  String? type = 'Monthly';

  // ignore: non_constant_identifier_names
  List<String> select_month = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];
  String? month;
  String dynamicYear = '';

  int currentYear = DateTime.now().year;

  String? year;
  List<String> select_year = generateYearList();
  // ignore: prefer_typing_uninitialized_variables
  String? selectedMonth;

  String aMowing = 'MOWING';
  String bSpray = 'SPRAY';
  String cMowingNoSpray = 'MOWING, NO SPRAY';
  String dJaraffMowingSprayWork = 'JARAFF, MOWING, SPRAY WORK';
  String eGroundWork = 'GROUND WORK';
  String fJaraffMowingNoSpray = 'JARAFF, MOWING, NO SPRAY';
  String gBucketWork = 'BUCKET WORK';

  String monthNo = '';
  String? selectedSubstation;
  String id = "";
  Future? myFuture;
  @override
  void initState() {
    myFuture = fetchCardsCountMethod();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return
        // PopScope(
        //   canPop: false,
        //   onPopInvoked: ((didpop) {
        //     if (didpop) {
        //       return;
        //     }
        //     showExitPopup(context);
        //   }),
        //   child:
        Scaffold(
            backgroundColor: AppColors.backgroundColor,
            appBar: AppBar(
              iconTheme: const IconThemeData(color: Colors.white),
              title: const Text(
                'Herbicide',
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
                    child: RefreshIndicator(
                        onRefresh: () async {
                          await fetchCardsCountMethod();
                          print('RefreshIndicator called');
                        },
                      child: Stack(fit: StackFit.expand, children: [
                        SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: Column(
                            children: [
                      
                              // Container(
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
                              //               "Transmission IVM",
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
                              //         padding: const EdgeInsets.only(
                              //             right: 8, left: 8),
                              //         child: Row(
                              //           children: [
                              //             Expanded(
                              //               child: InkWell(
                              //                 onTap: () {
                              //                   Navigator.of(context).push(
                              //                       MaterialPageRoute(
                              //                           builder: (BuildContext
                              //                                   context) =>
                              //                               const EdkoTransmissionIVMpEnding()));
                              //                 },
                              //                 child: DashboardCard(
                              //                   cardIcon:
                              //                       'assets/Orders_Pending.png',
                              //                   cardColor: const Color.fromRGBO(
                              //                       237, 230, 141, 1),
                              //                   cardTitle:
                              //                       'Total Order \n(Pending)',
                              //                   cardCount: transIVMPendingCount
                              //                       .toString(),
                              //                 ),
                              //               ),
                              //             ),
                              //             const SizedBox(
                              //               width: 10,
                              //             ),
                              //             Expanded(
                              //               child: InkWell(
                              //                 onTap: () {
                              //                   Navigator.of(context).push(
                              //                       MaterialPageRoute(
                              //                           builder: (BuildContext
                              //                                   context) =>
                              //                               const EdkoTransmissionIVMRejected()));
                              //                 },
                              //                 child: DashboardCard(
                              //                   cardIcon:
                              //                       'assets/Orders_Pending.png',
                              //                   cardColor: const Color.fromRGBO(
                              //                       240, 129, 127, 1),
                              //                   cardTitle:
                              //                       'Total Order \n(Rejected)',
                              //                   cardCount: transIVMRejectedCount
                              //                       .toString(),
                              //                 ),
                              //               ),
                              //             ),
                              //           ],
                              //         ),
                              //       ),
                              //       Padding(
                              //         padding: const EdgeInsets.only(
                              //             right: 8, left: 8),
                              //         child: Row(
                              //           children: [
                              //             Expanded(
                              //               child: InkWell(
                              //                 onTap: () {
                              //                   Navigator.of(context).push(
                              //                       MaterialPageRoute(
                              //                           builder: (BuildContext
                              //                                   context) =>
                              //                               const EdkoTransmissionIVMcLOSED()));
                              //                 },
                              //                 child: DashboardCard(
                              //                   cardIcon:
                              //                       'assets/Orders_Open.png',
                              //                   cardColor: const Color.fromRGBO(
                              //                       142, 189, 143, 1),
                              //                   cardTitle:
                              //                       'Total Order \n(Closed)',
                              //                   cardCount: transIVMClosedCount
                              //                       .toString(),
                              //                 ),
                              //               ),
                              //             ),
                              //             const SizedBox(
                              //               width: 10,
                              //             ),
                              //             Expanded(
                              //               child: InkWell(
                              //                 onTap: () {
                              //                   Navigator.of(context).push(
                              //                       MaterialPageRoute(
                              //                           builder: (BuildContext
                              //                                   context) =>
                              //                               EdkoTransmissionIvmReadyForReview()));
                              //                 },
                              //                 child: DashboardCard(
                              //                   cardIcon:
                              //                       'assets/Orders_Pending.png',
                              //                   iconColor: Colors.red,
                              //                   cardColor: const Color.fromARGB(
                              //                       255, 146, 129, 175),
                              //                   cardTitle: 'Pending Inspection',
                              //                   cardCount:
                              //                       transIVMPendingInspectionCount
                              //                           .toString(),
                              //                   // (contractorDispatcherDashboardViewModel
                              //                   //                 .contractorDispatcherDashboardGetTabularData
                              //                   //                 .data!
                              //                   //                 .distributionRejected ==
                              //                   //             null ||
                              //                   //         contractorDispatcherDashboardViewModel
                              //                   //                 .contractorDispatcherDashboardGetTabularData
                              //                   //                 .data!
                              //                   //                 .distributionRejected
                              //                   //                 .toString() ==
                              //                   //             'null')
                              //                   //     ? ''
                              //                   //     : contractorDispatcherDashboardViewModel
                              //                   //         .contractorDispatcherDashboardGetTabularData
                              //                   //         .data!
                              //                   //         .distributionRejected
                              //                   //         .toString()
                              //                 ),
                              //               ),
                              //             ),
                              //           ],
                              //         ),
                              //       ),
                              //       const SizedBox(
                              //         height: 10,
                              //       ),
                              //     ],
                              //   ),
                              // ),
                             
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
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (BuildContext
                                                                context) =>
                                                            const EdkoTransmissionHerbicidepEnding()));
                                              },
                                              child: DashboardCard(
                                                cardIcon:
                                                    'assets/Orders_Pending.png',
                                                cardColor: const Color.fromRGBO(
                                                    237, 230, 141, 1),
                                                cardTitle:
                                                    'Total Order \n(Pending)',
                                                cardCount:
                                                    transHerbicidePendingCount
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
                                                            const EdkoTransmissionHerbicideRejected()));
                                              },
                                              child: DashboardCard(
                                                cardIcon:
                                                    'assets/Orders_Pending.png',
                                                cardColor: const Color.fromRGBO(
                                                    240, 129, 127, 1),
                                                cardTitle:
                                                    'Total Order \n(Rejected)',
                                                cardCount:
                                                    transHerbicideRejectedCount
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
                                                            const EdkoTransmissionHerbicideIVMcLOSED()));
                                              },
                                              child: DashboardCard(
                                                cardIcon:
                                                    'assets/Orders_Open.png',
                                                cardColor: const Color.fromRGBO(
                                                    142, 189, 143, 1),
                                                cardTitle:
                                                    'Total Order \n(Closed)',
                                                cardCount:
                                                    transHerbicideClosedCount
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
                                                            EdkoTransmissionHerbicideReadyForReview()));
                                              },
                                              child: DashboardCard(
                                                cardIcon:
                                                    'assets/Orders_Pending.png',
                                                iconColor: Colors.red,
                                                cardColor: const Color.fromARGB(
                                                    255, 146, 129, 175),
                                                cardTitle: 'Pending Inspection',
                                                cardCount:
                                                    transHerbicidePendingInspectionCount
                                                        .toString(),
                                                // (contractorDispatcherDashboardViewModel
                                                //                 .contractorDispatcherDashboardGetTabularData
                                                //                 .data!
                                                //                 .distributionRejected ==
                                                //             null ||
                                                //         contractorDispatcherDashboardViewModel
                                                //                 .contractorDispatcherDashboardGetTabularData
                                                //                 .data!
                                                //                 .distributionRejected
                                                //                 .toString() ==
                                                //             'null')
                                                //     ? ''
                                                //     : contractorDispatcherDashboardViewModel
                                                //         .contractorDispatcherDashboardGetTabularData
                                                //         .data!
                                                //         .distributionRejected
                                                //         .toString()
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
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (BuildContext
                                                                context) =>
                                                            EdkoAnnualHerbicideTOPending()));
                                              },
                                              child: DashboardCard(
                                                cardIcon:
                                                    'assets/Orders_Pending.png',
                                                cardColor: const Color.fromRGBO(
                                                    237, 230, 141, 1),
                                                cardTitle:
                                                    'Total Order \n(Pending)',
                                                cardCount:
                                                    annualHerbicidePendingCount
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
                                                            EdkoAnnualHerbicideTORejected()));
                                              },
                                              child: DashboardCard(
                                                  cardIcon:
                                                      'assets/Orders_Pending.png',
                                                  cardColor:
                                                      const Color.fromRGBO(
                                                          240, 129, 127, 1),
                                                  cardTitle:
                                                      'Total Order \n(Rejected)',
                                                  cardCount:
                                                      annualHerbicideRejectedCount
                                                          .toString()),
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
                                                            EdkoAnnualHerbicideTOClosed()));
                                                // EdkoAnnualHerbicideTOClosed
                                              },
                                              child: DashboardCard(
                                                  cardIcon:
                                                      'assets/Orders_Open.png',
                                                  cardColor:
                                                      const Color.fromRGBO(
                                                          142, 189, 143, 1),
                                                  cardTitle:
                                                      'Total Order \n(Closed)',
                                                  cardCount:
                                                      annualHerbicideClosedCount
                                                          .toString()),
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
                                                            EdkoAnnualHerbicideReadyForReview()));
                                              },
                                              child: DashboardCard(
                                                cardIcon:
                                                    'assets/Orders_Pending.png',
                                                iconColor: Colors.red,
                                                cardColor: const Color.fromARGB(
                                                    255, 146, 129, 175),
                                                cardTitle: 'Pending Inspection',
                                                cardCount:
                                                    annualHerbicidePendingInspectionCount
                                                        .toString(),
                                                // (contractorDispatcherDashboardViewModel
                                                //                 .contractorDispatcherDashboardGetTabularData
                                                //                 .data!
                                                //                 .distributionRejected ==
                                                //             null ||
                                                //         contractorDispatcherDashboardViewModel
                                                //                 .contractorDispatcherDashboardGetTabularData
                                                //                 .data!
                                                //                 .distributionRejected
                                                //                 .toString() ==
                                                //             'null')
                                                //     ? ''
                                                //     : contractorDispatcherDashboardViewModel
                                                //         .contractorDispatcherDashboardGetTabularData
                                                //         .data!
                                                //         .distributionRejected
                                                //         .toString()
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
                      ]),
                    ),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Color.fromARGB(255, 7, 59, 120),
                    ),
                  );
                }
              },
            ));
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

  int distriIVMPendingCount = 0;
  int distriIVMRejectedCount = 0;
  int distriIVMClosedCount = 0;
  int transIVMPendingCount = 0;
  int transIVMRejectedCount = 0;
  int transIVMClosedCount = 0;
  int transIVMPendingInspectionCount = 0;
  int transHerbicidePendingCount = 0;
  int transHerbicideRejectedCount = 0;
  int transHerbicideClosedCount = 0;
  int transHerbicidePendingInspectionCount = 0;
  int annualHerbicidePendingCount = 0;
  int annualHerbicideRejectedCount = 0;
  int annualHerbicideClosedCount = 0;
  int annualHerbicidePendingInspectionCount = 0;
  Future<void> fetchCardsCountMethod() async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel userData = await userPreferences.getUser();
    id = userData.user!.id.toString();
    print("id test ${id}");
    String url = '${AppUrl.getgeneralForemanDashboardData}?userid=$id';

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
          distriIVMPendingCount = data['distribution_pending'] ?? 0;
          distriIVMRejectedCount = data['distribution_rejected'] ?? 0;
          distriIVMClosedCount = data['distribution_closed'] ?? 0;
          transIVMPendingCount = data['transmissionIVM_pending'] ?? 0;
          transIVMRejectedCount = data['transmissionIVM_rejected'] ?? 0;
          transIVMClosedCount = data['transmissionIVM_closed'] ?? 0;
          transIVMPendingInspectionCount =
              data['transmissionIVM_ready_for_inspection'] ?? 0;
          transHerbicidePendingCount =
              data['transmissionHerbicide_pending'] ?? 0;
          transHerbicideRejectedCount =
              data['transmissionHerbicide_rejected'] ?? 0;
          transHerbicideClosedCount = data['transmissionHerbicide_closed'] ?? 0;
          transHerbicidePendingInspectionCount =
              data['transmissionHerbicide_ready_for_inspection'] ?? 0;
          annualHerbicidePendingCount = data['annualHerbicide_pending'] ?? 0;
          annualHerbicideRejectedCount = data['annualHerbicide_rejected'] ?? 0;
          annualHerbicideClosedCount = data['annualHerbicide_closed'] ?? 0;
          annualHerbicidePendingInspectionCount =
              data['annualHerbicide_ready_for_inspection'] ?? 0;
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
          // Important: Remove any padding from the ListView.
          // padding: EdgeInsets.zero,
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
                    title: const Text('General Foreman Dashboard'),
                    textColor: AppColors.baseColor,
                    iconColor: AppColors.baseColor,
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const EdkoBottomNavigationPannel()));
                    },
                  ),
                  //    ListTile(
                  //   leading: const Icon(
                  //     Icons.maps_ugc,
                  //   ),
                  //   title: const Text('Add ROW Transmission Map'),
                  //   textColor: AppColors.baseColor,
                  //   iconColor: AppColors.baseColor,
                  //   onTap: () async {
                  //     String id = '';
                  //     final userPreferences1 =
                  //         Provider.of<UserPref>(context, listen: false);
                  //     UserModel data = await userPreferences1.getUser();
                  //     id = data.user!.id.toString();
                  //     await browser.open(
                  //         url: WebUri(
                  //             MapUrl.getPlannerTransmissionMapEndPoint(id)),
                  //         settings: ChromeSafariBrowserSettings(
                  //             shareState: CustomTabsShareState.SHARE_STATE_OFF,
                  //             barCollapsingEnabled: true));
                  //   },
                  // ),
             
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
                      Icons.closed_caption_off,
                    ),
                    title: const Text('Herbicide'),
                    textColor: AppColors.baseColor,
                    iconColor: AppColors.baseColor,
                    onTap: () {
                      Navigator.pop(context);
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
                  ListTile(
                    leading: const Icon(
                      Icons.logout,
                    ),
                    title: const Text('Log Out'),
                    textColor: AppColors.baseColor,
                    iconColor: AppColors.baseColor,
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
      'https://atsdev2test.ariespro.com/assets/clientuploads/${data.user!.profilePhoto}',
    );
    String imageUrl =
        'https://atsdev2test.ariespro.com/assets/clientuploads/${data.user!.profilePhoto}';
    _imagePath = imageUrl;
    setState(() {
      userName = '${data.user!.fName} ${data.user!.lName}';
    });
  }

  String extractYear(String? date) {
    if (date == null || date.isEmpty || date == "N/A") {
      return ""; // Handle null or invalid dates
    }
    try {
      if (date.contains('T')) {
        // ISO 8601 format (e.g., 2024-12-07T11:37:16.750+00:00)
        DateTime parsedDate = DateTime.parse(date);
        return parsedDate.year.toString();
      } else if (date.contains(' ')) {
        // Formats like "Dec  7 2024 12:00AM"
        String normalizedDate =
            date.replaceAll(RegExp(r'\s+'), ' '); // Remove extra spaces
        DateTime parsedDate =
            DateFormat("MMM d yyyy h:mma").parse(normalizedDate);
        return parsedDate.year.toString();
      } else if (date.contains('/')) {
        // Format MM/dd/yyyy
        DateTime parsedDate = DateFormat("MM/dd/yyyy").parse(date);
        return parsedDate.year.toString();
      }
    } catch (e) {
      print("Error parsing date: $date, Error: $e");
    }
    return ""; // Default if parsing fails
  }
}
