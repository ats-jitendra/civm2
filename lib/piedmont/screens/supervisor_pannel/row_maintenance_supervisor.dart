import 'dart:io';
import 'package:CIVM/piedmont/data/response/status.dart';
import 'package:CIVM/piedmont/models/graph_vegetation_management_dashboard.dart';
import 'package:CIVM/piedmont/screens/supervisor_pannel/sup_distributionIVM_open.dart';
import 'package:CIVM/piedmont/screens/supervisor_pannel/sup_invoice_list.dart';
import 'package:CIVM/utils/user_pref.dart';
import 'package:CIVM/models/user_model.dart';
import 'package:CIVM/piedmont/models/vegetation_management_dashboard_model.dart';
import 'package:CIVM/piedmont/repository/map_url.dart';
import 'package:CIVM/piedmont/resources/app_colors.dart';
import 'package:CIVM/piedmont/screens/login_page.dart';
import 'package:CIVM/piedmont/screens/map/provider/location_provider.dart';
import 'package:CIVM/piedmont/screens/my_chrome_safari_map_recording.dart';
import 'package:CIVM/piedmont/screens/supervisor_pannel/change_order_new_inDrawer.dart';
import 'package:CIVM/piedmont/screens/supervisor_pannel/maintenance_report_view_annual_herbicide.dart';
import 'package:CIVM/piedmont/screens/supervisor_pannel/maintenance_report_view_new.dart';
import 'package:CIVM/piedmont/screens/supervisor_pannel/maintenance_report_view_trans_IVM.dart';
import 'package:CIVM/piedmont/screens/supervisor_pannel/maintenance_report_view_trans_herbicide.dart';
import 'package:CIVM/piedmont/screens/supervisor_pannel/service_order.dart';
import 'package:CIVM/piedmont/screens/supervisor_pannel/sup_annual_herbicide_closed.dart';
import 'package:CIVM/piedmont/screens/supervisor_pannel/sup_annual_herbicide_inprogress.dart';
import 'package:CIVM/piedmont/screens/supervisor_pannel/sup_annual_herbicide_rejected.dart';
import 'package:CIVM/piedmont/screens/supervisor_pannel/sup_distributionIVM_inProgress.dart';
import 'package:CIVM/piedmont/screens/supervisor_pannel/sup_distributionIVM_rejected.dart';
import 'package:CIVM/piedmont/screens/supervisor_pannel/sup_transmissionHerbicide_closed.dart';
import 'package:CIVM/piedmont/screens/supervisor_pannel/sup_transmissionHerbicide_inProgress.dart';
import 'package:CIVM/piedmont/screens/supervisor_pannel/sup_transmissionHerbicide_rejected.dart';
import 'package:CIVM/piedmont/screens/supervisor_pannel/sup_transmissionIVM_closed.dart';
import 'package:CIVM/piedmont/screens/supervisor_pannel/sup_transmissionIVM_inProgress.dart';
import 'package:CIVM/piedmont/screens/supervisor_pannel/sup_transmissionIVM_rejected.dart';
import 'package:CIVM/piedmont/screens/supervisor_pannel/supervisor_SO_Open.dart';
import 'package:CIVM/piedmont/screens/supervisor_pannel/supervisor_SO_closed.dart';
import 'package:CIVM/piedmont/screens/supervisor_pannel/supervisor_SO_ready_for_review.dart';
import 'package:CIVM/piedmont/screens/supervisor_pannel/supervisor_SO_inprogress.dart';
// import 'package:CIVM/piedmont/screens/supervisor_pannel/location_map.dart';
import 'package:CIVM/piedmont/screens/supervisor_pannel/supervisor_add_crew_member.dart';
import 'package:CIVM/piedmont/screens/supervisor_pannel/supervisor_add_new_row_table.dart';
import 'package:CIVM/piedmont/screens/supervisor_pannel/supervisor_approve_civm_access.dart';
import 'package:CIVM/piedmont/screens/supervisor_pannel/supervisor_row_maintenance_progress.dart';
import 'package:CIVM/piedmont/screens/supervisor_pannel/supervisor_WO_T&M_inProgress.dart';
import 'package:CIVM/piedmont/screens/supervisor_pannel/supervisor_WO_ready_for_review.dart';
import 'package:CIVM/piedmont/screens/supervisor_pannel/supervisor_WO_rejected.dart';
import 'package:CIVM/piedmont/screens/supervisor_pannel/supervisor_WO_Completed.dart';
import 'package:CIVM/sharedPrefs/constants.dart';
import 'package:CIVM/piedmont/utils/common_functions.dart';
import 'package:CIVM/piedmont/view_model/vegetation_management_dashboard_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:CIVM/piedmont/screens/leaflat_map/leaf_lat_map_wakeLock.dart';

import 'sup_distributionIVM_completed.dart';

// ignore: must_be_immutable
class RowMaintenanceSupervisor extends StatefulWidget {
  const RowMaintenanceSupervisor({Key? key}) : super(key: key);

  @override
  State<RowMaintenanceSupervisor> createState() =>
      _RowMaintenanceSupervisorState();
}

class _RowMaintenanceSupervisorState extends State<RowMaintenanceSupervisor> {
  List<Map<String, dynamic>> listOfColumns = [];
  List<Map<String, dynamic>> listOfColumns1 = [];
  var result = [];
  List<String> menu = [];

  bool? _selectJaraffMowingNoSpray = true;
  bool? _selectSpray = true;
  bool? _selectMowing = true;
  bool? _selectMowingNoSpray = true;
  bool? _selectJaraffMowingSprayWork = true;
  bool? _selectGroundWork = true;
  bool? _selectBucketWork = true;

  VegetationManagementDashboardViewModel
      vegetationManagementDashboardViewModel =
      VegetationManagementDashboardViewModel();

  List<GraphVegetationManagementDashboard> dataset = [];
  int loadingFlag = 0;

  int uniqueDataCount = 0;

  var state;


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

  @override
  void initState() {
    dynamicYear = currentYear.toString();
    // year = currentYear.toString();
    vegetationManagementDashboardViewModel
        .fetchVegetationManagementDashboardListApi(
            context, 'TYPE', '', '', '', '', '', '', '', '', '', '', '', '');
    super.initState();
  }

  var _parentSetState;

  @override
  Widget build(BuildContext context) {
    // final data = vegetationManagementDashboardViewModel
    //     .vegetationManagementDashboardList.data;
    _parentSetState = setState;
    Size size = MediaQuery.of(context).size;
    return PopScope(
      canPop: false,
    onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          return;
        }
        showExitPopup(context);
      },
      child: Scaffold(
          backgroundColor: AppColors.backgroundColor,
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.white),
            title: const Text(
              'Dashboard',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: AppColors.baseColor,
            // actions: [
            //   InkWell(
            //     onTap: () async {
            //       openFilter();
            //     },
            //     child: Padding(
            //       padding: const EdgeInsets.only(
            //           left: 12.0, right: 8, bottom: 12, top: 8),
            //       child: Align(
            //         alignment: Alignment.centerRight,
            //         child: Container(
            //           // width: 65,
            //           padding: const EdgeInsets.only(
            //             right: 8,
            //             left: 8,
            //           ),
            //           alignment: Alignment.center,
            //           decoration: BoxDecoration(
            //               // shape: BoxShape.circle,
            //               borderRadius: BorderRadius.circular(10),
            //               boxShadow: const [
            //                 BoxShadow(
            //                     color: AppColors.buttonShadow,
            //                     blurRadius: 5,
            //                     offset: Offset(2.0, 5.0))
            //               ],
            //               color: const Color.fromARGB(255, 130, 193, 245),
            //               gradient: const LinearGradient(
            //                 colors: [Colors.white, Colors.white],
            //               )),
            //           child: const Align(
            //             alignment: Alignment.center,
            //             child: Text(
            //               'Filter',
            //               textAlign: TextAlign.left,
            //               style: TextStyle(
            //                 color: AppColors.baseColor,
            //                 //  fontWeight: FontWeight.bold,
            //                 fontSize: 18,
            //               ),
            //             ),
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),

            //   // IconButton(
            //   //   icon:
            //   //       const Icon(Icons.filter_alt_outlined, color: Colors.white),
            //   //   onPressed: () {
            //   //     openFilter();
            //   //   },
            //   // ),
            // ],
      
          ),
          drawer: DrawerManu(menu: menu),
          body: ChangeNotifierProvider<VegetationManagementDashboardViewModel>(
              create: (BuildContext context) =>
                  vegetationManagementDashboardViewModel,
              child: Consumer<VegetationManagementDashboardViewModel>(
                  builder: (context, value, _) {
                switch (value.vegetationManagementDashboardList.status) {
                  case Status.LOADING:
                    return const Center(child: CircularProgressIndicator());
                  case Status.ERROR:
                    return
                        // CustomToastSnackBarProgressDialog
                        //     .flushBarErrorMessage(
                        //         value.vegetationManagementDashboardList.message
                        //             .toString(),
                        //         context);
                        Padding(
                      padding: const EdgeInsets.only(
                          top: 16.0, bottom: 16, left: 8, right: 8),
                      child: Center(
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Column(
                            children: [
                              Image.asset(
                                'assets/empty_box_pemc.png',
                                height: 200,
                                width: 200,
                                fit: BoxFit.cover,
                              ),
                              const Center(
                                child: Text(
                                  'Sorry, Data Not Found!',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: AppColors.baseColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  case Status.COMPLETED:
                    if (loadingFlag == 0) {
                      _recreateDataMain();
                      loadingFlag = 1;
                    }

                    return RefreshIndicator(
                      onRefresh: () async {
                        await vegetationManagementDashboardViewModel
                            .fetchVegetationManagementDashboardListApi(
                                context,
                                'TYPE',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                '',
                                // currentYear.toString(),
                                '',
                                '',
                                '');
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
                                                          SupervisorZIELIESTotalOrderPending(
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
                                              cardCount: (vegetationManagementDashboardViewModel
                                                              .vegetationManagementDashboardList
                                                              .data!
                                                              .workOrderInProgress ==
                                                          null ||
                                                      vegetationManagementDashboardViewModel
                                                              .vegetationManagementDashboardList
                                                              .data!
                                                              .workOrderInProgress
                                                              .toString() ==
                                                          'null')
                                                  ? ''
                                                  : vegetationManagementDashboardViewModel
                                                      .vegetationManagementDashboardList
                                                      .data!
                                                      .workOrderInProgress
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
                                                          SupervisorZIELIESDocumentApprovalPending(
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
                                              cardCount: (vegetationManagementDashboardViewModel
                                                              .vegetationManagementDashboardList
                                                              .data!
                                                              .workOrderInspectionPending ==
                                                          null ||
                                                      vegetationManagementDashboardViewModel
                                                              .vegetationManagementDashboardList
                                                              .data!
                                                              .workOrderInspectionPending
                                                              .toString() ==
                                                          'null')
                                                  ? ''
                                                  : vegetationManagementDashboardViewModel
                                                      .vegetationManagementDashboardList
                                                      .data!
                                                      .workOrderInspectionPending
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
                                                          SupervisorZIELIESTotalOrderRejectCO(
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
                                              cardCount: (vegetationManagementDashboardViewModel
                                                              .vegetationManagementDashboardList
                                                              .data!
                                                              .workOrderRejected ==
                                                          null ||
                                                      vegetationManagementDashboardViewModel
                                                              .vegetationManagementDashboardList
                                                              .data!
                                                              .workOrderRejected
                                                              .toString() ==
                                                          'null')
                                                  ? ''
                                                  : vegetationManagementDashboardViewModel
                                                      .vegetationManagementDashboardList
                                                      .data!
                                                      .workOrderRejected
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
                                                          SupervisorZIELIESTotalOrderClosed(
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
                                              cardCount: (vegetationManagementDashboardViewModel
                                                              .vegetationManagementDashboardList
                                                              .data!
                                                              .workOrderCompleted ==
                                                          null ||
                                                      vegetationManagementDashboardViewModel
                                                              .vegetationManagementDashboardList
                                                              .data!
                                                              .workOrderCompleted
                                                              .toString() ==
                                                          'null')
                                                  ? ''
                                                  : vegetationManagementDashboardViewModel
                                                      .vegetationManagementDashboardList
                                                      .data!
                                                      .workOrderCompleted
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
                                                          SupervisorSOOpen()));
                                            },
                                            child: DashboardCard(
                                              cardIcon:
                                                  'assets/Orders_Pending.png',
                                              cardColor: const Color.fromRGBO(
                                                  2, 205, 205, 1),
                                              cardTitle: 'Open',
                                              cardCount: (vegetationManagementDashboardViewModel
                                                              .vegetationManagementDashboardList
                                                              .data!
                                                              .serviceOrderOpen ==
                                                          null ||
                                                      vegetationManagementDashboardViewModel
                                                              .vegetationManagementDashboardList
                                                              .data!
                                                              .serviceOrderOpen
                                                              .toString() ==
                                                          'null')
                                                  ? ''
                                                  : vegetationManagementDashboardViewModel
                                                      .vegetationManagementDashboardList
                                                      .data!
                                                      .serviceOrderOpen
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
                                                          SupervisorSOInprogress()));
                                            },
                                            child: DashboardCard(
                                              cardIcon:
                                                  'assets/Orders_Pending.png',
                                              cardColor: const Color.fromRGBO(
                                                  237, 230, 141, 1),
                                              cardTitle: 'In Progress',
                                              cardCount: (vegetationManagementDashboardViewModel
                                                              .vegetationManagementDashboardList
                                                              .data!
                                                              .serviceOrderInProgress ==
                                                          null ||
                                                      vegetationManagementDashboardViewModel
                                                              .vegetationManagementDashboardList
                                                              .data!
                                                              .serviceOrderInProgress
                                                              .toString() ==
                                                          'null')
                                                  ? ''
                                                  : vegetationManagementDashboardViewModel
                                                      .vegetationManagementDashboardList
                                                      .data!
                                                      .serviceOrderInProgress
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
                                                          SupervisorSOReadyForReview()));
                                            },
                                            child: DashboardCard(
                                              cardIcon:
                                                  'assets/Orders_Open.png',
                                              cardColor: const Color.fromRGBO(
                                                  240, 129, 127, 1),
                                              cardTitle: 'Ready For Review',
                                              cardCount: (vegetationManagementDashboardViewModel
                                                              .vegetationManagementDashboardList
                                                              .data!
                                                              .serviceOrderReadyforReview ==
                                                          null ||
                                                      vegetationManagementDashboardViewModel
                                                              .vegetationManagementDashboardList
                                                              .data!
                                                              .serviceOrderReadyforReview
                                                              .toString() ==
                                                          'null')
                                                  ? ''
                                                  : vegetationManagementDashboardViewModel
                                                      .vegetationManagementDashboardList
                                                      .data!
                                                      .serviceOrderReadyforReview
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
                                                          SupervisorSOClosed()));
                                            },
                                            child: DashboardCard(
                                              cardIcon:
                                                  'assets/Orders_Open.png',
                                              cardColor: const Color.fromRGBO(
                                                  142, 189, 143, 1),
                                              cardTitle: 'Closed',
                                              cardCount: (vegetationManagementDashboardViewModel
                                                              .vegetationManagementDashboardList
                                                              .data!
                                                              .serviceOrderClosed ==
                                                          null ||
                                                      vegetationManagementDashboardViewModel
                                                              .vegetationManagementDashboardList
                                                              .data!
                                                              .serviceOrderClosed
                                                              .toString() ==
                                                          'null')
                                                  ? ''
                                                  : vegetationManagementDashboardViewModel
                                                      .vegetationManagementDashboardList
                                                      .data!
                                                      .serviceOrderClosed
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
                                                          SupDistributionIVmOPEN(
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
                                              cardColor:const Color.fromRGBO(
                                                  2, 205, 205, 1),
                                              cardTitle: 'Open',
                                              cardCount: (vegetationManagementDashboardViewModel
                                                              .vegetationManagementDashboardList
                                                              .data!
                                                              .distributionOpen ==
                                                          null ||
                                                      vegetationManagementDashboardViewModel
                                                              .vegetationManagementDashboardList
                                                              .data!
                                                              .distributionOpen
                                                              .toString() ==
                                                          'null')
                                                  ? ''
                                                  : vegetationManagementDashboardViewModel
                                                      .vegetationManagementDashboardList
                                                      .data!
                                                      .distributionOpen
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
                                                          SupDistributionIVmINPGROGRESS(
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
                                              cardCount: (vegetationManagementDashboardViewModel
                                                              .vegetationManagementDashboardList
                                                              .data!
                                                              .distributionInProgress ==
                                                          null ||
                                                      vegetationManagementDashboardViewModel
                                                              .vegetationManagementDashboardList
                                                              .data!
                                                              .distributionInProgress
                                                              .toString() ==
                                                          'null')
                                                  ? ''
                                                  : vegetationManagementDashboardViewModel
                                                      .vegetationManagementDashboardList
                                                      .data!
                                                      .distributionInProgress
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
                                                          const MaintenanceReportViewNew()));
                                            },
                                            child: DashboardCard(
                                              cardIcon:
                                                  'assets/Orders_Pending.png',
                                              cardColor: const Color.fromRGBO(
                                                  176, 196, 222, 1),
                                              cardTitle: 'Ready For Review',
                                              cardCount: (vegetationManagementDashboardViewModel
                                                              .vegetationManagementDashboardList
                                                              .data!
                                                              .distributionReadyForInspection ==
                                                          null ||
                                                      vegetationManagementDashboardViewModel
                                                              .vegetationManagementDashboardList
                                                              .data!
                                                              .distributionReadyForInspection
                                                              .toString() ==
                                                          'null')
                                                  ? ''
                                                  : vegetationManagementDashboardViewModel
                                                      .vegetationManagementDashboardList
                                                      .data!
                                                      .distributionReadyForInspection
                                                      .toString(),
                                            ),
                                          ),
                                        ),
                                      const SizedBox(
                                          width: 10,
                                        ), Expanded(
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (BuildContext
                                                              context) =>
                                                          SupDistributionIVmRejected(
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
                                              cardCount: (vegetationManagementDashboardViewModel
                                                              .vegetationManagementDashboardList
                                                              .data!
                                                              .distributionRejected ==
                                                          null ||
                                                      vegetationManagementDashboardViewModel
                                                              .vegetationManagementDashboardList
                                                              .data!
                                                              .distributionRejected
                                                              .toString() ==
                                                          'null')
                                                  ? ''
                                                  : vegetationManagementDashboardViewModel
                                                      .vegetationManagementDashboardList
                                                      .data!
                                                      .distributionRejected
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
                                                          SupDistributionIVmCompleted(
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
                                              cardCount: (vegetationManagementDashboardViewModel
                                                              .vegetationManagementDashboardList
                                                              .data!
                                                              .distributionCompleted ==
                                                          null ||
                                                      vegetationManagementDashboardViewModel
                                                              .vegetationManagementDashboardList
                                                              .data!
                                                              .distributionCompleted
                                                              .toString() ==
                                                          'null')
                                                  ? ''
                                                  : vegetationManagementDashboardViewModel
                                                      .vegetationManagementDashboardList
                                                      .data!
                                                      .distributionCompleted
                                                      .toString(),
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
                                                          SupTransmissionIvmInprogress()));
                                            },
                                            child: DashboardCard(
                                              cardIcon:
                                                  'assets/Orders_Pending.png',
                                              cardColor: const Color.fromRGBO(
                                                  237, 230, 141, 1),
                                              cardTitle: 'In Progress',
                                              cardCount: (vegetationManagementDashboardViewModel
                                                              .vegetationManagementDashboardList
                                                              .data!
                                                              .transmissionIVMInProgress ==
                                                          null ||
                                                      vegetationManagementDashboardViewModel
                                                              .vegetationManagementDashboardList
                                                              .data!
                                                              .transmissionIVMInProgress
                                                              .toString() ==
                                                          'null')
                                                  ? ''
                                                  : vegetationManagementDashboardViewModel
                                                      .vegetationManagementDashboardList
                                                      .data!
                                                      .transmissionIVMInProgress
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
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          SupTransmissionIvmReadyForReview()));
                                            },
                                            child: DashboardCard(
                                              cardIcon:
                                                  'assets/Orders_Pending.png',
                                              cardColor: const Color.fromRGBO(
                                                  2, 205, 205, 1),
                                              cardTitle: 'Ready For Review',
                                              cardCount: (vegetationManagementDashboardViewModel
                                                              .vegetationManagementDashboardList
                                                              .data!
                                                              .transmissionIVMReadyForInspection ==
                                                          null ||
                                                      vegetationManagementDashboardViewModel
                                                              .vegetationManagementDashboardList
                                                              .data!
                                                              .transmissionIVMReadyForInspection
                                                              .toString() ==
                                                          'null')
                                                  ? ''
                                                  : vegetationManagementDashboardViewModel
                                                      .vegetationManagementDashboardList
                                                      .data!
                                                      .transmissionIVMReadyForInspection
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
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          SupTransmissionIvmRejected()));
                                            },
                                            child: DashboardCard(
                                              cardIcon:
                                                  'assets/Orders_Pending.png',
                                              cardColor: const Color.fromRGBO(
                                                  240, 129, 127, 1),
                                              cardTitle: 'Rejected',
                                              cardCount: (vegetationManagementDashboardViewModel
                                                              .vegetationManagementDashboardList
                                                              .data!
                                                              .transmissionIVMRejected ==
                                                          null ||
                                                      vegetationManagementDashboardViewModel
                                                              .vegetationManagementDashboardList
                                                              .data!
                                                              .transmissionIVMRejected
                                                              .toString() ==
                                                          'null')
                                                  ? ''
                                                  : vegetationManagementDashboardViewModel
                                                      .vegetationManagementDashboardList
                                                      .data!
                                                      .transmissionIVMRejected
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
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          SupTransmissionIvmClosed()));
                                            },
                                            child: DashboardCard(
                                              cardIcon:
                                                  'assets/Orders_Open.png',
                                              cardColor: const Color.fromRGBO(
                                                  142, 189, 143, 1),
                                              cardTitle: 'Closed',
                                              cardCount: (vegetationManagementDashboardViewModel
                                                              .vegetationManagementDashboardList
                                                              .data!
                                                              .transmissionIVMClosed ==
                                                          null ||
                                                      vegetationManagementDashboardViewModel
                                                              .vegetationManagementDashboardList
                                                              .data!
                                                              .transmissionIVMClosed
                                                              .toString() ==
                                                          'null')
                                                  ? ''
                                                  : vegetationManagementDashboardViewModel
                                                      .vegetationManagementDashboardList
                                                      .data!
                                                      .transmissionIVMClosed
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
                                                          SupTransmissionHerbicideInprogress()));
                                            },
                                            child: DashboardCard(
                                              cardIcon:
                                                  'assets/Orders_Pending.png',
                                              iconColor: Colors.red,
                                              cardColor: const Color.fromRGBO(
                                                  237, 230, 141, 1),
                                              cardTitle: 'In Progress',
                                              cardCount: (vegetationManagementDashboardViewModel
                                                              .vegetationManagementDashboardList
                                                              .data!
                                                              .transmissionHerbicideInProgress ==
                                                          null ||
                                                      vegetationManagementDashboardViewModel
                                                              .vegetationManagementDashboardList
                                                              .data!
                                                              .transmissionHerbicideInProgress
                                                              .toString() ==
                                                          'null')
                                                  ? ''
                                                  : vegetationManagementDashboardViewModel
                                                      .vegetationManagementDashboardList
                                                      .data!
                                                      .transmissionHerbicideInProgress
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
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          SupTransmissionHerbicideReadyForReview()));
                                            },
                                            child: DashboardCard(
                                              cardIcon:
                                                  'assets/Orders_Pending.png',
                                              iconColor: Colors.red,
                                              cardColor: const Color.fromRGBO(
                                                  176, 196, 222, 1),
                                              cardTitle: 'Ready For Review',
                                              cardCount: (vegetationManagementDashboardViewModel
                                                              .vegetationManagementDashboardList
                                                              .data!
                                                              .transmissionHerbicideReadyForInspection ==
                                                          null ||
                                                      vegetationManagementDashboardViewModel
                                                              .vegetationManagementDashboardList
                                                              .data!
                                                              .transmissionHerbicideReadyForInspection
                                                              .toString() ==
                                                          'null')
                                                  ? ''
                                                  : vegetationManagementDashboardViewModel
                                                      .vegetationManagementDashboardList
                                                      .data!
                                                      .transmissionHerbicideReadyForInspection
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
                                                          SupTransmissionHerbicideRejected()));
                                            },
                                            child: DashboardCard(
                                              cardIcon:
                                                  'assets/Orders_Pending.png',
                                              cardColor: const Color.fromRGBO(
                                                  240, 129, 127, 1),
                                              cardTitle: 'Rejected',
                                              cardCount: (vegetationManagementDashboardViewModel
                                                              .vegetationManagementDashboardList
                                                              .data!
                                                              .transmissionHerbicideRejected ==
                                                          null ||
                                                      vegetationManagementDashboardViewModel
                                                              .vegetationManagementDashboardList
                                                              .data!
                                                              .transmissionHerbicideRejected
                                                              .toString() ==
                                                          'null')
                                                  ? ''
                                                  : vegetationManagementDashboardViewModel
                                                      .vegetationManagementDashboardList
                                                      .data!
                                                      .transmissionHerbicideRejected
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
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          SupTransmissionHerbicideClosed()));
                                            },
                                            child: DashboardCard(
                                              cardIcon:
                                                  'assets/Orders_Open.png',
                                              cardColor: const Color.fromRGBO(
                                                  142, 189, 143, 1),
                                              cardTitle: 'Closed',
                                              cardCount: (vegetationManagementDashboardViewModel
                                                              .vegetationManagementDashboardList
                                                              .data!
                                                              .transmissionHerbicideClosed ==
                                                          null ||
                                                      vegetationManagementDashboardViewModel
                                                              .vegetationManagementDashboardList
                                                              .data!
                                                              .transmissionHerbicideClosed
                                                              .toString() ==
                                                          'null')
                                                  ? ''
                                                  : vegetationManagementDashboardViewModel
                                                      .vegetationManagementDashboardList
                                                      .data!
                                                      .transmissionHerbicideClosed
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
                                                          SuperviosrAnnualHerbicideInprogress()));
                                            },
                                            child: DashboardCard(
                                              cardIcon:
                                                  'assets/Orders_Pending.png',
                                              iconColor: Colors.red,
                                              cardColor: const Color.fromRGBO(
                                                  237, 230, 141, 1),
                                              cardTitle: 'In Progress',
                                              cardCount: (vegetationManagementDashboardViewModel
                                                              .vegetationManagementDashboardList
                                                              .data!
                                                              .annualHerbicideInProgress ==
                                                          null ||
                                                      vegetationManagementDashboardViewModel
                                                              .vegetationManagementDashboardList
                                                              .data!
                                                              .annualHerbicideInProgress
                                                              .toString() ==
                                                          'null')
                                                  ? ''
                                                  : vegetationManagementDashboardViewModel
                                                      .vegetationManagementDashboardList
                                                      .data!
                                                      .annualHerbicideInProgress
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
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          SupAnnualHerbicideReadyForReview()));
                                            },
                                            child: DashboardCard(
                                              cardIcon:
                                                  'assets/Orders_Pending.png',
                                              iconColor: Colors.red,
                                              cardColor: const Color.fromRGBO(
                                                  176, 196, 222, 1),
                                              cardTitle: 'Ready For Review',
                                              cardCount: (vegetationManagementDashboardViewModel
                                                              .vegetationManagementDashboardList
                                                              .data!
                                                              .annualHerbicideReadyForInspection ==
                                                          null ||
                                                      vegetationManagementDashboardViewModel
                                                              .vegetationManagementDashboardList
                                                              .data!
                                                              .annualHerbicideReadyForInspection
                                                              .toString() ==
                                                          'null')
                                                  ? ''
                                                  : vegetationManagementDashboardViewModel
                                                      .vegetationManagementDashboardList
                                                      .data!
                                                      .annualHerbicideReadyForInspection
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
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          SuperviosrAnnualHerbicideRejected()));
                                            },
                                            child: DashboardCard(
                                              cardIcon:
                                                  'assets/Orders_Pending.png',
                                              cardColor: const Color.fromRGBO(
                                                  240, 129, 127, 1),
                                              cardTitle: 'Rejected',
                                              cardCount: (vegetationManagementDashboardViewModel
                                                              .vegetationManagementDashboardList
                                                              .data!
                                                              .annualHerbicideRejected ==
                                                          null ||
                                                      vegetationManagementDashboardViewModel
                                                              .vegetationManagementDashboardList
                                                              .data!
                                                              .annualHerbicideRejected
                                                              .toString() ==
                                                          'null')
                                                  ? ''
                                                  : vegetationManagementDashboardViewModel
                                                      .vegetationManagementDashboardList
                                                      .data!
                                                      .annualHerbicideRejected
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
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          SuperviosrAnnualHerbicideClosed()));
                                            },
                                            child: DashboardCard(
                                              cardIcon:
                                                  'assets/Orders_Open.png',
                                              cardColor: const Color.fromRGBO(
                                                  142, 189, 143, 1),
                                              cardTitle: 'Closed',
                                              cardCount: (vegetationManagementDashboardViewModel
                                                              .vegetationManagementDashboardList
                                                              .data!
                                                              .annualHerbicideClosed ==
                                                          null ||
                                                      vegetationManagementDashboardViewModel
                                                              .vegetationManagementDashboardList
                                                              .data!
                                                              .annualHerbicideClosed
                                                              .toString() ==
                                                          'null')
                                                  ? ''
                                                  : vegetationManagementDashboardViewModel
                                                      .vegetationManagementDashboardList
                                                      .data!
                                                      .annualHerbicideClosed
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
                                    margin: const EdgeInsets.only(
                                        left: 4, right: 4, bottom: 4, top: 4),
                                    padding: const EdgeInsets.only(
                                        left: 4, right: 4, bottom: 4, top: 4),
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
                                    child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "IVM/Herbicide Status",
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () async {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (BuildContext
                                                              context) =>
                                                          const SupervisorRowMaintenanceProgress()));
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0,
                                                  right: 8,
                                                  bottom: 8,
                                                  top: 8),
                                              child: Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Container(
                                                  width: 120,
                                                  padding:
                                                      const EdgeInsets.all(4),
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                      // shape: BoxShape.circle,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      boxShadow: const [
                                                        BoxShadow(
                                                            color: AppColors
                                                                .buttonShadow,
                                                            blurRadius: 5,
                                                            offset: Offset(
                                                                2.0, 5.0))
                                                      ],
                                                      color:
                                                          const Color.fromARGB(
                                                              255,
                                                              130,
                                                              193,
                                                              245),
                                                      gradient:
                                                          const LinearGradient(
                                                        colors: [
                                                          Colors.white,
                                                          Colors.white
                                                        ],
                                                      )),
                                                  child: const Row(children: [
                                                    Expanded(
                                                      child: Align(
                                                        alignment:
                                                            Alignment.center,
                                                        child: Text(
                                                          'View More',
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: TextStyle(
                                                            color: AppColors
                                                                .green2,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 20,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ]),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ]),
                                  ),
                                ],
                              ),
                            ),
                            // Container(
                            //   margin: const EdgeInsets.only(
                            //       top: 10, bottom: 10, left: 8, right: 8),
                            //   padding: const EdgeInsets.all(8),
                            //   alignment: Alignment.center,
                            //   height: size.height * 0.7,
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
                            //         height: MediaQuery.of(context).size.height *
                            //             0.059,
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
                            //         child: Row(children: [
                            //           const Align(
                            //             alignment: Alignment.centerLeft,
                            //             child: Text(
                            //               "IVM And Herbicide Summary",
                            //               textAlign: TextAlign.left,
                            //               style: TextStyle(
                            //                 color: Colors.white,
                            //                 fontWeight: FontWeight.bold,
                            //                 fontSize: 20,
                            //               ),
                            //             ),
                            //           ),
                            //           Expanded(
                            //             child: Align(
                            //               alignment: Alignment.centerRight,
                            //               child: IconButton(
                            //                 icon: const Icon(
                            //                   Icons.filter_alt_outlined,
                            //                   color: Colors.white,
                            //                 ),
                            //                 onPressed: () {
                            //                   openDailogOverallSummary();
                            //                 },
                            //               ),
                            //             ),
                            //           ),
                            //         ]),
                            //       ),
                            //       Expanded(
                            //         child: SingleChildScrollView(
                            //           child: Padding(
                            //               padding: const EdgeInsets.all(4.0),
                            //               child: ListView.builder(
                            //                   shrinkWrap: true,
                            //                   itemCount: dataset.length,
                            //                   physics:
                            //                       const NeverScrollableScrollPhysics(),
                            //                   // itemCount: energyhistory!.result!.length,
                            //                   itemBuilder: (context, index) {
                            //                     return Container(
                            //                       margin: const EdgeInsets.only(
                            //                           top: 10, bottom: 10),
                            //                       padding:
                            //                           const EdgeInsets.all(8),
                            //                       alignment: Alignment.center,
                            //                       // height: size.height * 0.2,
                            //                       width: size.width - 40,
                            //                       decoration: BoxDecoration(
                            //                         gradient: LinearGradient(
                            //                           colors: [
                            //                             AppColors.green1
                            //                                 .withOpacity(0.9),
                            //                             AppColors.green2
                            //                                 .withOpacity(0.7),
                            //                             AppColors.green1
                            //                                 .withOpacity(0.9),
                            //                           ],
                            //                           begin: Alignment.topLeft,
                            //                           end:
                            //                               Alignment.bottomRight,
                            //                         ),
                            //                         border: Border.all(
                            //                           color: Colors.white,
                            //                         ),
                            //                         borderRadius:
                            //                             const BorderRadius.only(
                            //                           topRight:
                            //                               Radius.circular(10),
                            //                           bottomRight:
                            //                               Radius.circular(10),
                            //                           topLeft:
                            //                               Radius.circular(10),
                            //                           bottomLeft:
                            //                               Radius.circular(10),
                            //                         ),
                            //                       ),
                            //                       child: Column(
                            //                         children: [
                            //                           Padding(
                            //                             padding:
                            //                                 const EdgeInsets
                            //                                     .only(
                            //                                     top: 4.0,
                            //                                     left: 8.0),
                            //                             child: Row(children: [
                            //                               const Expanded(
                            //                                 child: Align(
                            //                                   alignment: Alignment
                            //                                       .centerLeft,
                            //                                   child: Text(
                            //                                     "Substation: ",
                            //                                     textAlign:
                            //                                         TextAlign
                            //                                             .left,
                            //                                     style:
                            //                                         TextStyle(
                            //                                       color:
                            //                                           AppColors
                            //                                               .white,
                            //                                       fontWeight:
                            //                                           FontWeight
                            //                                               .bold,
                            //                                       fontSize: 16,
                            //                                     ),
                            //                                   ),
                            //                                 ),
                            //                               ),
                            //                               Expanded(
                            //                                 child: Align(
                            //                                   alignment: Alignment
                            //                                       .centerLeft,
                            //                                   child: Text(
                            //                                     dataset[index]
                            //                                         .substation
                            //                                         .toString(),
                            //                                     textAlign:
                            //                                         TextAlign
                            //                                             .left,
                            //                                     style:
                            //                                         const TextStyle(
                            //                                       color:
                            //                                           AppColors
                            //                                               .white,
                            //                                       // fontWeight: FontWeight.bold,
                            //                                       fontSize: 16,
                            //                                     ),
                            //                                   ),
                            //                                 ),
                            //                               ),
                            //                             ]),
                            //                           ),
                            //                           Padding(
                            //                             padding:
                            //                                 const EdgeInsets
                            //                                     .only(
                            //                                     top: 4.0,
                            //                                     left: 8.0),
                            //                             child: Row(children: [
                            //                               const Expanded(
                            //                                 child: Align(
                            //                                   alignment: Alignment
                            //                                       .centerLeft,
                            //                                   child: Text(
                            //                                     "Feeder: ",
                            //                                     textAlign:
                            //                                         TextAlign
                            //                                             .left,
                            //                                     style:
                            //                                         TextStyle(
                            //                                       color:
                            //                                           AppColors
                            //                                               .white,
                            //                                       fontWeight:
                            //                                           FontWeight
                            //                                               .bold,
                            //                                       fontSize: 16,
                            //                                     ),
                            //                                   ),
                            //                                 ),
                            //                               ),
                            //                               Expanded(
                            //                                 child: Align(
                            //                                   alignment: Alignment
                            //                                       .centerLeft,
                            //                                   child: Text(
                            //                                     dataset[index]
                            //                                         .feeder
                            //                                         .toString(),
                            //                                     textAlign:
                            //                                         TextAlign
                            //                                             .left,
                            //                                     style:
                            //                                         const TextStyle(
                            //                                       color:
                            //                                           AppColors
                            //                                               .white,
                            //                                       // fontWeight: FontWeight.bold,
                            //                                       fontSize: 16,
                            //                                     ),
                            //                                   ),
                            //                                 ),
                            //                               ),
                            //                             ]),
                            //                           ),
                            //                           const Padding(
                            //                             padding:
                            //                                 EdgeInsets.only(
                            //                                     top: 10.0,
                            //                                     left: 8.0),
                            //                             child: Row(children: [
                            //                               Expanded(
                            //                                 child: Align(
                            //                                   alignment: Alignment
                            //                                       .centerLeft,
                            //                                   child: Text(
                            //                                     "Row Maintenance Percentage: ",
                            //                                     textAlign:
                            //                                         TextAlign
                            //                                             .left,
                            //                                     style:
                            //                                         TextStyle(
                            //                                       color:
                            //                                           AppColors
                            //                                               .white,
                            //                                       fontWeight:
                            //                                           FontWeight
                            //                                               .bold,
                            //                                       fontSize: 16,
                            //                                     ),
                            //                                   ),
                            //                                 ),
                            //                               ),
                            //                             ]),
                            //                           ),
                            //                           PrimerProgressBar(
                            //                             segments: [
                            //                               Segment(
                            //                                   value: (dataset[index]
                            //                                               .spray !=
                            //                                           null)
                            //                                       ? (double.parse(dataset[
                            //                                                   index]
                            //                                               .spray
                            //                                               .toString())
                            //                                           .toInt())
                            //                                       : 0,
                            //                                   color:
                            //                                       Colors.purple,
                            //                                   label: const Text(
                            //                                       "SPRAY")),
                            //                               Segment(
                            //                                   value: (dataset[index]
                            //                                               .mowing !=
                            //                                           null)
                            //                                       ? double.parse(dataset[
                            //                                                   index]
                            //                                               .mowing
                            //                                               .toString())
                            //                                           .toInt()
                            //                                       : 0,
                            //                                   color: const Color
                            //                                       .fromARGB(255,
                            //                                       121, 10, 2),
                            //                                   label: const Text(
                            //                                       "MOWING")),
                            //                               Segment(
                            //                                   value: (dataset[index]
                            //                                               .mowingNoSpray !=
                            //                                           null)
                            //                                       ? double.parse(dataset[
                            //                                                   index]
                            //                                               .mowingNoSpray
                            //                                               .toString())
                            //                                           .toInt()
                            //                                       : 0,
                            //                                   color: const Color
                            //                                       .fromARGB(
                            //                                       255,
                            //                                       249,
                            //                                       135,
                            //                                       173),
                            //                                   label: const Text(
                            //                                       "MOWING,NO SPRAY")),
                            //                               Segment(
                            //                                   value: (dataset[index]
                            //                                               .jaraffMowingSprayWork !=
                            //                                           null)
                            //                                       ? double.parse(dataset[
                            //                                                   index]
                            //                                               .jaraffMowingSprayWork
                            //                                               .toString())
                            //                                           .toInt()
                            //                                       : 0,
                            //                                   color:
                            //                                       Colors.green,
                            //                                   label: const Text(
                            //                                       "JARAFF, MOWING, SPRAY WORK")),
                            //                               Segment(
                            //                                   value: (dataset[index]
                            //                                               .groundWork !=
                            //                                           null)
                            //                                       ? double.parse(dataset[
                            //                                                   index]
                            //                                               .groundWork
                            //                                               .toString())
                            //                                           .toInt()
                            //                                       : 0,
                            //                                   color:
                            //                                       Colors.yellow,
                            //                                   label: const Text(
                            //                                       "GROUND_WORK")),
                            //                               Segment(
                            //                                   value: (dataset[index]
                            //                                               .jaraffMowingNoSpray !=
                            //                                           null)
                            //                                       ? double.parse(dataset[
                            //                                                   index]
                            //                                               .jaraffMowingNoSpray
                            //                                               .toString())
                            //                                           .toInt()
                            //                                       : 0,
                            //                                   color: Colors.red,
                            //                                   label: const Text(
                            //                                       "JARAFF, MOWING, NO SPRAY")),
                            //                               Segment(
                            //                                   value: (dataset[index]
                            //                                               .bucketWork !=
                            //                                           null)
                            //                                       ? double.parse(dataset[
                            //                                                   index]
                            //                                               .bucketWork
                            //                                               .toString())
                            //                                           .toInt()
                            //                                       : 0,
                            //                                   color: const Color
                            //                                       .fromARGB(255,
                            //                                       21, 5, 243),
                            //                                   label: const Text(
                            //                                       "BUCKET WORK")),
                            //                             ],
                            //                             // legendStyle:
                            //                             //     const SegmentedBarLegendStyle(
                            //                             //         maxLines: 2),
                            //                           ),
                            //                         ],
                            //                       ),
                            //                     );
                            //                   })),
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                        
                          ],
                        ),
                      ),
                    );

                  default:
                    return const Text('data');
                }
              }))),
    );
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

  Future openDailogOverallSummary() => showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: CheckboxListTile(
                          title: const Text("SPRAY",
                              style: TextStyle(
                                  color: AppColors.baseColor, fontSize: 20)),
                          // secondary: Icon(Icons.beach_access),
                          controlAffinity: ListTileControlAffinity.leading,
                          value: _selectSpray,
                          onChanged: (val) {
                            setState(() {
                              _selectSpray = val;
                            });

                            // callApiAccordingToTheCheckedList();
                          },
                          tileColor: Colors.white,
                          activeColor: Colors.white,
                          checkColor: AppColors.baseColor,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 20, right: 50),
                        alignment: Alignment.center,
                        width: 20,
                        height: 20,
                        decoration: const BoxDecoration(
                            color: Colors.black,
                            gradient: LinearGradient(
                              colors: [
                                Colors.purple,
                                Colors.purple,
                              ],
                            )),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CheckboxListTile(
                          title: const Text("MOWING",
                              style: TextStyle(
                                  color: AppColors.baseColor, fontSize: 20)),
                          // secondary: Icon(Icons.beach_access),
                          controlAffinity: ListTileControlAffinity.leading,
                          value: _selectMowing,
                          onChanged: (val) {
                            setState(() {
                              _selectMowing = val;
                            });
                            // callApiAccordingToTheCheckedList();
                          },
                          tileColor: Colors.white,
                          activeColor: Colors.white,
                          checkColor: AppColors.baseColor,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 20, right: 50),
                        alignment: Alignment.center,
                        width: 20,
                        height: 20,
                        decoration: const BoxDecoration(
                            color: Colors.black,
                            gradient: LinearGradient(
                              colors: [
                                Color.fromARGB(255, 121, 10, 2),
                                Color.fromARGB(255, 121, 10, 2),
                              ],
                            )),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CheckboxListTile(
                          title: const Text("MOWING, NO SPRAY",
                              style: TextStyle(
                                  color: AppColors.baseColor, fontSize: 20)),
                          // secondary: Icon(Icons.beach_access),
                          controlAffinity: ListTileControlAffinity.leading,
                          value: _selectMowingNoSpray,
                          onChanged: (val) {
                            setState(() {
                              _selectMowingNoSpray = val;
                            });
                            // callApiAccordingToTheCheckedList();
                          },
                          tileColor: Colors.white,
                          activeColor: Colors.white,
                          checkColor: AppColors.baseColor,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 20, right: 50),
                        alignment: Alignment.center,
                        width: 20,
                        height: 20,
                        decoration: const BoxDecoration(
                            color: Colors.black,
                            gradient: LinearGradient(
                              colors: [
                                Color.fromARGB(255, 249, 135, 173),
                                Color.fromARGB(255, 249, 135, 173),
                              ],
                            )),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CheckboxListTile(
                          title: const Text("JARAFF, MOWING, SPRAY WORK",
                              style: TextStyle(
                                  color: AppColors.baseColor, fontSize: 20)),
                          // secondary: Icon(Icons.beach_access),
                          controlAffinity: ListTileControlAffinity.leading,
                          value: _selectJaraffMowingSprayWork,
                          onChanged: (val) {
                            setState(() {
                              _selectJaraffMowingSprayWork = val;
                            });
                            // callApiAccordingToTheCheckedList();
                          },
                          tileColor: Colors.white,
                          activeColor: Colors.white,
                          checkColor: AppColors.baseColor,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 20, right: 50),
                        alignment: Alignment.center,
                        width: 20,
                        height: 20,
                        decoration: const BoxDecoration(
                            color: Colors.black,
                            gradient: LinearGradient(
                              colors: [
                                // Color.fromARGB(255, 107, 65, 2),
                                // Color.fromARGB(255, 107, 65, 2),
                                Colors.green,
                                Colors.green,
                              ],
                            )),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CheckboxListTile(
                          title: const Text("GROUND WORK",
                              style: TextStyle(
                                  color: AppColors.baseColor, fontSize: 20)),
                          // secondary: Icon(Icons.beach_access),
                          controlAffinity: ListTileControlAffinity.leading,
                          value: _selectGroundWork,
                          onChanged: (val) {
                            setState(() {
                              _selectGroundWork = val;
                            });
                            // callApiAccordingToTheCheckedList();
                          },
                          tileColor: Colors.white,
                          activeColor: Colors.white,
                          checkColor: AppColors.baseColor,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 20, right: 50),
                        alignment: Alignment.center,
                        width: 20,
                        height: 20,
                        decoration: const BoxDecoration(
                            color: Colors.black,
                            gradient: LinearGradient(
                              colors: [
                                // Colors.red,
                                Colors.yellow,
                                Colors.yellow,
                              ],
                            )),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CheckboxListTile(
                          title: const Text("JARAFF, MOWING, NO SPRAY",
                              style: TextStyle(
                                  color: AppColors.baseColor, fontSize: 20)),
                          // secondary: Icon(Icons.beach_access),
                          controlAffinity: ListTileControlAffinity.leading,
                          value: _selectJaraffMowingNoSpray,
                          onChanged: (val) {
                            setState(() {
                              _selectJaraffMowingNoSpray = val;
                            });
                            // callApiAccordingToTheCheckedList();
                          },
                          tileColor: Colors.white,
                          activeColor: Colors.white,
                          checkColor: AppColors.baseColor,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 20, right: 50),
                        alignment: Alignment.center,
                        width: 20,
                        height: 20,
                        decoration: const BoxDecoration(
                            color: Colors.black,
                            gradient: LinearGradient(
                              colors: [
                                Colors.red,
                                Colors.red,
                              ],
                            )),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CheckboxListTile(
                          title: const Text("BUCKET WORK",
                              style: TextStyle(
                                  color: AppColors.baseColor, fontSize: 20)),
                          // secondary: Icon(Icons.beach_access),
                          controlAffinity: ListTileControlAffinity.leading,
                          value: _selectBucketWork,
                          onChanged: (val) {
                            setState(() {
                              _selectBucketWork = val;
                            });
                            // callApiAccordingToTheCheckedList();
                          },
                          tileColor: Colors.white,
                          activeColor: Colors.white,
                          checkColor: AppColors.baseColor,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 20, right: 50),
                        alignment: Alignment.center,
                        width: 20,
                        height: 20,
                        decoration: const BoxDecoration(
                            color: Colors.black,
                            gradient: LinearGradient(
                              colors: [
                                Color.fromARGB(255, 22, 3, 167),
                                Color.fromARGB(255, 22, 3, 167),
                              ],
                            )),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            actions: [
              InkWell(
                onTap: (() {
                  _recreateDataCopyFilter();
                  Navigator.pop(context);
                }),
                child: const Text(
                  'Search',
                  // textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.baseColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          );
        });
      });

  _recreateDataMain() {
    dataset.clear();
    if (vegetationManagementDashboardViewModel
                .vegetationManagementDashboardList.data !=
            null &&
        vegetationManagementDashboardViewModel.vegetationManagementDashboardList
                .data!.getSPGETPERCENTAGEAll !=
            null) {
      List<GetSPGETPERCENTAGEAll> yourDataList =
          vegetationManagementDashboardViewModel
              .vegetationManagementDashboardList.data!.getSPGETPERCENTAGEAll!;

      Set<YourData> uniqueData = <YourData>{};
      for (var item in yourDataList) {
        final data =
            YourData(item.feeder.toString(), item.subStationName.toString());
        uniqueData.add(data);
      }
      for (var a in uniqueData) {
        GraphVegetationManagementDashboard temp =
            GraphVegetationManagementDashboard();
        //  added this to fix null issue of substation and feeder
        temp.substation = a.subStationName;
        temp.feeder = a.feeder;
        //------------------
        for (var b in yourDataList) {
          if (a.subStationName == b.subStationName && a.feeder == b.feeder) {
            if (b.type1 == 'SPRAY' && _selectSpray == true) {
              temp.substation = a.subStationName;
              temp.feeder = a.feeder;
              temp.spray = b.growthPercentage;
              //  print('temp.substation');
              // print(temp.substation);
            }
            if (b.type1 == 'JARAFF,MOWING,SPRAY WORK' &&
                _selectJaraffMowingSprayWork == true) {
              temp.substation = a.subStationName;
              temp.feeder = a.feeder;
              temp.jaraffMowingSprayWork = b.growthPercentage;
            }
            if (b.type1 == 'MOWING,NO SPRAY' && _selectMowingNoSpray == true) {
              temp.substation = a.subStationName;
              temp.feeder = a.feeder;
              temp.mowingNoSpray = b.growthPercentage;
            }
            if (b.type1 == 'GROUND WORK' && _selectGroundWork == true) {
              temp.substation = a.subStationName;
              temp.feeder = a.feeder;
              temp.groundWork = b.growthPercentage;
            }
            if (b.type1 == 'MOWING' && _selectMowing == true) {
              temp.substation = a.subStationName;
              temp.feeder = a.feeder;
              temp.mowing = b.growthPercentage;
            }
            if (b.type1 == 'BUCKET WORK' && _selectBucketWork == true) {
              temp.substation = a.subStationName;
              temp.feeder = a.feeder;
              temp.bucketWork = b.growthPercentage;
            }
            if (b.type1 == "JARAFF,MOWING,NO SPRAY" &&
                _selectJaraffMowingNoSpray == true) {
              temp.substation = a.subStationName;
              temp.feeder = a.feeder;
              temp.jaraffMowingNoSpray = b.growthPercentage;
            }
          }
        }
        dataset.add(temp);
      }
      uniqueDataCount = uniqueData.length;
    }
  }

  _recreateDataCopyFilter() {
    dataset.clear();
    if (vegetationManagementDashboardViewModel
                .vegetationManagementDashboardList.data !=
            null &&
        vegetationManagementDashboardViewModel.vegetationManagementDashboardList
                .data!.getSPGETPERCENTAGEAll !=
            null) {
      List<GetSPGETPERCENTAGEAll> yourDataList =
          vegetationManagementDashboardViewModel
              .vegetationManagementDashboardList.data!.getSPGETPERCENTAGEAll!;

      Set<YourData> uniqueData = <YourData>{};
      for (var item in yourDataList) {
        final data =
            YourData(item.feeder.toString(), item.subStationName.toString());
        uniqueData.add(data);
      }
      for (var a in uniqueData) {
        GraphVegetationManagementDashboard temp =
            GraphVegetationManagementDashboard();
        //  added this to fix null issue of substation and feeder
        temp.substation = a.subStationName;
        temp.feeder = a.feeder;
        //-----------
        for (var b in yourDataList) {
          if (a.subStationName == b.subStationName && a.feeder == b.feeder) {
            if (b.type1 == 'SPRAY' && _selectSpray == true) {
              temp.substation = a.subStationName;
              temp.feeder = a.feeder;
              temp.spray = b.growthPercentage;
              //  print('temp.substation');
              // print(temp.substation);
            }
            if (b.type1 == 'JARAFF,MOWING,SPRAY WORK' &&
                _selectJaraffMowingSprayWork == true) {
              temp.substation = a.subStationName;
              temp.feeder = a.feeder;
              temp.jaraffMowingSprayWork = b.growthPercentage;
            }
            if (b.type1 == 'MOWING,NO SPRAY' && _selectMowingNoSpray == true) {
              temp.substation = a.subStationName;
              temp.feeder = a.feeder;
              temp.mowingNoSpray = b.growthPercentage;
            }
            if (b.type1 == 'GROUND WORK' && _selectGroundWork == true) {
              temp.substation = a.subStationName;
              temp.feeder = a.feeder;
              temp.groundWork = b.growthPercentage;
            }
            if (b.type1 == 'MOWING' && _selectMowing == true) {
              temp.substation = a.subStationName;
              temp.feeder = a.feeder;
              temp.mowing = b.growthPercentage;
            }
            if (b.type1 == 'BUCKET WORK' && _selectBucketWork == true) {
              temp.substation = a.subStationName;
              temp.feeder = a.feeder;
              temp.bucketWork = b.growthPercentage;
            }
            if (b.type1 == "JARAFF,MOWING,NO SPRAY" &&
                _selectJaraffMowingNoSpray == true) {
              temp.substation = a.subStationName;
              temp.feeder = a.feeder;
              temp.jaraffMowingNoSpray = b.growthPercentage;
            }
          }
        }
        dataset.add(temp);
      }
      uniqueDataCount = uniqueData.length;
    }
    _parentSetState(() {});
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

  // Future openFilter() => showDialog(
  //     context: context,
  //     builder: (context) {
  //       return StatefulBuilder(builder: (context, setState) {
  //         state = setState;
  //         Size size = MediaQuery.of(context).size;
  //         return AlertDialog(
  //           content: SingleChildScrollView(
  //               child: Column(
  //             children: [
  //               Container(
  //                 margin: const EdgeInsets.only(top: 10),
  //                 child: Column(children: [
  //                   Padding(
  //                     padding: const EdgeInsets.only(
  //                         top: 10, bottom: 2, left: 2, right: 2),
  //                     child: Column(
  //                       children: [
  //                         Visibility(
  //                           visible: _isVisibleMonthly,
  //                           child: Column(
  //                             children: [
  //                               Padding(
  //                                 padding: const EdgeInsets.only(
  //                                     top: 10, bottom: 2, left: 2, right: 2),
  //                                 child: Column(
  //                                   children: [
  //                                     const Align(
  //                                         alignment: Alignment.centerLeft,
  //                                         child: Padding(
  //                                           padding: EdgeInsets.all(2.0),
  //                                           child: Text(
  //                                             "YEAR",
  //                                             style: TextStyle(
  //                                               fontSize: 16.0,
  //                                               color: AppColors.baseColor,
  //                                               fontWeight: FontWeight.bold,
  //                                             ),
  //                                           ),
  //                                         )),
  //                                     Align(
  //                                       alignment: Alignment.centerLeft,
  //                                       child: Padding(
  //                                         padding: const EdgeInsets.all(2.0),
  //                                         child:
  //                                             DropdownButtonFormField<String>(
  //                                           hint: const Text('-Select-'),
  //                                           dropdownColor: Colors.white,
  //                                           value: year,
  //                                           // =
  //                                           //     currentYear.toString(),
  //                                           style: const TextStyle(
  //                                             color: Color.fromARGB(
  //                                                 255, 7, 59, 120),
  //                                             fontSize: 16,
  //                                           ),
  //                                           icon: const Icon(
  //                                             Icons.arrow_drop_down,
  //                                             color: Color.fromARGB(
  //                                                 255, 7, 59, 120),
  //                                             size: 40,
  //                                           ),
  //                                           decoration: const InputDecoration(
  //                                             enabledBorder: OutlineInputBorder(
  //                                               borderSide: BorderSide(
  //                                                 color: Color.fromARGB(
  //                                                     255, 7, 59, 120),
  //                                               ),
  //                                             ),
  //                                             focusedBorder: OutlineInputBorder(
  //                                               borderSide: BorderSide(
  //                                                 color: Color.fromARGB(
  //                                                     255, 7, 59, 120),
  //                                               ),
  //                                             ),
  //                                           ),
  //                                           isExpanded: true,
  //                                           items: select_year
  //                                               .map(buildMenuItem)
  //                                               .toList(),
  //                                           onChanged: (String? newValue) {
  //                                             setState(() {
  //                                               year = newValue;
  //                                             });
  //                                             dynamicYear = year.toString();
  //                                             if (selectedMonth != null ||
  //                                                 selectedSubstation != null) {
  //                                               selectedMonth = null;
  //                                               selectedSubstation = null;
  //                                             }
  //                                             loadingFlag = 0;
  //                                             vegetationManagementDashboardViewModel
  //                                                 .fetchVegetationManagementDashboardListApi(
  //                                                     context,
  //                                                     'TYPE',
  //                                                     bSpray,
  //                                                     aMowing,
  //                                                     cMowingNoSpray,
  //                                                     dJaraffMowingSprayWork,
  //                                                     eGroundWork,
  //                                                     fJaraffMowingNoSpray,
  //                                                     gBucketWork,
  //                                                     '',
  //                                                     dynamicYear,
  //                                                     '',
  //                                                     '',
  //                                                     '')
  //                                                 .then((value) async {
  //                                               Navigator.pop(context);
  //                                             });
  //                                           },
  //                                           validator: (value) => value == null
  //                                               ? 'Field required'
  //                                               : null,
  //                                         ),
  //                                       ),
  //                                     )
  //                                   ],
  //                                 ),
  //                               ),
  //                               Padding(
  //                                 padding: const EdgeInsets.only(
  //                                     top: 10, bottom: 2, left: 2, right: 2),
  //                                 child: Column(
  //                                   children: [
  //                                     const Align(
  //                                         alignment: Alignment.centerLeft,
  //                                         child: Padding(
  //                                           padding: EdgeInsets.all(2.0),
  //                                           child: Text(
  //                                             "MONTH",
  //                                             style: TextStyle(
  //                                               fontSize: 16.0,
  //                                               color: AppColors.baseColor,
  //                                               fontWeight: FontWeight.bold,
  //                                             ),
  //                                           ),
  //                                         )),
  //                                     Align(
  //                                       alignment: Alignment.centerLeft,
  //                                       child: Padding(
  //                                         padding: const EdgeInsets.all(2.0),
  //                                         child: Container(
  //                                           padding: const EdgeInsets.symmetric(
  //                                               horizontal: 12, vertical: 4),
  //                                           width: size.width * 0.9,
  //                                           decoration: BoxDecoration(
  //                                             border: Border.all(
  //                                               color: AppColors.baseColor,
  //                                             ),
  //                                           ),
  //                                           child: MultiSelectDialogField(
  //                                               items: vegetationManagementDashboardViewModel
  //                                                   .vegetationManagementDashboardList
  //                                                   .data!
  //                                                   .monthList!
  //                                                   .map((e) => MultiSelectItem(
  //                                                       e.month.toString(),
  //                                                       e.month.toString()))
  //                                                   .toList(),
  //                                               initialValue: (selectedMonth ==
  //                                                           null ||
  //                                                       selectedMonth
  //                                                           .toString()
  //                                                           .isEmpty)
  //                                                   ? []
  //                                                   : selectedMonth!.split(','),
  //                                               buttonIcon: const Icon(
  //                                                   Icons.arrow_drop_down,
  //                                                   color: Color.fromARGB(
  //                                                       255, 7, 59, 120),
  //                                                   size: 40),
  //                                               listType:
  //                                                   MultiSelectListType.CHIP,
  //                                               onConfirm: (value) {
  //                                                 selectedMonth =
  //                                                     value.join(',');

  //                                                 monthNo = '';

  //                                                 List<String> monthNumbers =
  //                                                     value.map((month) {
  //                                                   switch (month) {
  //                                                     case 'January':
  //                                                       return '1';
  //                                                     case 'February':
  //                                                       return '2';
  //                                                     case 'March':
  //                                                       return '3';
  //                                                     case 'April':
  //                                                       return '4';
  //                                                     case 'May':
  //                                                       return '5';
  //                                                     case 'June':
  //                                                       return '6';
  //                                                     case 'July':
  //                                                       return '7';
  //                                                     case 'August':
  //                                                       return '8';
  //                                                     case 'September':
  //                                                       return '9';
  //                                                     case 'October':
  //                                                       return '10';
  //                                                     case 'November':
  //                                                       return '11';
  //                                                     case 'December':
  //                                                       return '12';
  //                                                     default:
  //                                                       return '';
  //                                                   }
  //                                                 }).toList();
  //                                                 monthNo =
  //                                                     monthNumbers.join(',');

  //                                                 print(
  //                                                     'monthNo11111 $monthNo');
  //                                                 if (selectedSubstation !=
  //                                                     null) {
  //                                                   selectedSubstation = null;
  //                                                 }
  //                                                 loadingFlag = 0;
  //                                                 vegetationManagementDashboardViewModel
  //                                                     .fetchVegetationManagementDashboardListApi(
  //                                                         context,
  //                                                         'TYPE',
  //                                                         bSpray,
  //                                                         aMowing,
  //                                                         cMowingNoSpray,
  //                                                         dJaraffMowingSprayWork,
  //                                                         eGroundWork,
  //                                                         fJaraffMowingNoSpray,
  //                                                         gBucketWork,
  //                                                         '',
  //                                                         dynamicYear,
  //                                                         monthNo,
  //                                                         '',
  //                                                         '')
  //                                                     .then((value) async {
  //                                                   Navigator.pop(context);
  //                                                 });
  //                                                 (value) => value == null
  //                                                     ? 'field required'
  //                                                     : null;
  //                                               }),
  //                                         ),
  //                                       ),
  //                                     ),
  //                                   ],
  //                                 ),
  //                               ),
  //                               const Align(
  //                                   alignment: Alignment.centerLeft,
  //                                   child: Padding(
  //                                     padding: EdgeInsets.only(
  //                                         left: 2.0,
  //                                         right: 2.0,
  //                                         top: 10.0,
  //                                         bottom: 8),
  //                                     child: Text(
  //                                       "SUBSTATION",
  //                                       style: TextStyle(
  //                                         fontSize: 16.0,
  //                                         color: AppColors.baseColor,
  //                                         fontWeight: FontWeight.bold,
  //                                       ),
  //                                     ),
  //                                   )),
  //                               Align(
  //                                 alignment: Alignment.centerLeft,
  //                                 child: Padding(
  //                                   padding: const EdgeInsets.all(2.0),
  //                                   child: Container(
  //                                     padding: const EdgeInsets.symmetric(
  //                                         horizontal: 12, vertical: 4),
  //                                     width: size.width * 0.9,
  //                                     decoration: BoxDecoration(
  //                                       border: Border.all(
  //                                         color: const Color.fromARGB(
  //                                             255, 7, 59, 120),
  //                                       ),
  //                                     ),
  //                                     child: MultiSelectDialogField(
  //                                         items: vegetationManagementDashboardViewModel
  //                                             .vegetationManagementDashboardList
  //                                             .data!
  //                                             .substationList!
  //                                             .map((e) => MultiSelectItem(
  //                                                 e.substationName.toString(),
  //                                                 e.substationName.toString()))
  //                                             .toList(),
  //                                         initialValue: (selectedSubstation ==
  //                                                     null ||
  //                                                 selectedSubstation
  //                                                     .toString()
  //                                                     .isEmpty)
  //                                             ? []
  //                                             : selectedSubstation!.split(','),
  //                                         buttonIcon: const Icon(
  //                                             Icons.arrow_drop_down,
  //                                             color: Color.fromARGB(
  //                                                 255, 7, 59, 120),
  //                                             size: 40),
  //                                         listType: MultiSelectListType.CHIP,
  //                                         onConfirm: (value) {
  //                                           selectedSubstation =
  //                                               value.join(',');
  //                                           print(
  //                                               'selectedSubstation111 $selectedSubstation');
  //                                           loadingFlag = 0;
  //                                           vegetationManagementDashboardViewModel
  //                                               .fetchVegetationManagementDashboardListApi(
  //                                                   context,
  //                                                   'TYPE',
  //                                                   bSpray,
  //                                                   aMowing,
  //                                                   cMowingNoSpray,
  //                                                   dJaraffMowingSprayWork,
  //                                                   eGroundWork,
  //                                                   fJaraffMowingNoSpray,
  //                                                   gBucketWork,
  //                                                   selectedSubstation
  //                                                       .toString(),
  //                                                   dynamicYear,
  //                                                   monthNo,
  //                                                   '',
  //                                                   '')
  //                                               .then((value) async {
  //                                             Navigator.pop(context);
  //                                           });
  //                                           (value) => value == null
  //                                               ? 'field required'
  //                                               : null;
  //                                         }),
  //                                   ),
  //                                 ),
  //                               ),
  //                             ],
  //                           ),
  //                         ),
  //                         Visibility(
  //                           visible: _isVisibleDaily,
  //                           child: Column(
  //                             children: [
  //                               const Align(
  //                                   alignment: Alignment.centerLeft,
  //                                   child: Padding(
  //                                     padding: EdgeInsets.only(
  //                                       left: 2.0,
  //                                       right: 2.0,
  //                                       top: 10.0,
  //                                     ),
  //                                     child: Text(
  //                                       "DATE RANGE",
  //                                       style: TextStyle(
  //                                         fontSize: 16.0,
  //                                         color: AppColors.baseColor,
  //                                         fontWeight: FontWeight.bold,
  //                                       ),
  //                                     ),
  //                                   )),
  //                               InkWell(
  //                                 onTap: () async {
  //                                   await selectDateRange(context);
  //                                   setState(() {
  //                                     dateSelected1 =
  //                                         '$startDateSelected - $endDateSelected';
  //                                   });
  //                                 },
  //                                 child: Padding(
  //                                   padding: const EdgeInsets.only(
  //                                       left: 2, right: 2),
  //                                   child: Container(
  //                                     height: 65,
  //                                     // width: 240,
  //                                     // padding: const EdgeInsets.only(left: 14, right: 14),
  //                                     decoration: BoxDecoration(
  //                                       // borderRadius: BorderRadius.circular(14),
  //                                       border: Border.all(
  //                                         color: const Color.fromARGB(
  //                                             255, 7, 59, 120),
  //                                       ),
  //                                       color: Colors.transparent,
  //                                     ),
  //                                     child: Padding(
  //                                       padding: const EdgeInsets.all(1.0),
  //                                       child: Padding(
  //                                         padding:
  //                                             const EdgeInsets.only(left: 8.0),
  //                                         child: Row(
  //                                           children: [
  //                                             Expanded(
  //                                               child: Row(
  //                                                 children: [
  //                                                   Expanded(
  //                                                     child: Padding(
  //                                                       padding:
  //                                                           const EdgeInsets
  //                                                               .only(left: 2),
  //                                                       child: Text(
  //                                                           dateSelected1,
  //                                                           // '$startDateSelected - $endDateSelected',
  //                                                           // : 'Select Date Range',
  //                                                           style:
  //                                                               const TextStyle(
  //                                                                   // fontSize: 20,
  //                                                                   color: Color
  //                                                                       .fromARGB(
  //                                                                           255,
  //                                                                           7,
  //                                                                           59,
  //                                                                           120))),
  //                                                     ),
  //                                                   ),
  //                                                   Padding(
  //                                                     padding:
  //                                                         const EdgeInsets.only(
  //                                                             top: 2),
  //                                                     child: IconButton(
  //                                                       icon: const Icon(Icons
  //                                                           .calendar_month),
  //                                                       iconSize: 18,
  //                                                       color: const Color
  //                                                           .fromARGB(
  //                                                           255, 7, 59, 120),
  //                                                       onPressed: () async {
  //                                                         await selectDateRange(
  //                                                             context);
  //                                                         setState(() {
  //                                                           dateSelected1 =
  //                                                               '$startDateSelected - $endDateSelected';
  //                                                           // }
  //                                                         });
  //                                                         if (selectedSubstation !=
  //                                                             null) {
  //                                                           selectedSubstation =
  //                                                               null;
  //                                                         }
  //                                                         loadingFlag = 0;
  //                                                         vegetationManagementDashboardViewModel
  //                                                             .fetchVegetationManagementDashboardListApi(
  //                                                                 context,
  //                                                                 'TYPE',
  //                                                                 bSpray,
  //                                                                 aMowing,
  //                                                                 cMowingNoSpray,
  //                                                                 dJaraffMowingSprayWork,
  //                                                                 eGroundWork,
  //                                                                 fJaraffMowingNoSpray,
  //                                                                 gBucketWork,
  //                                                                 '',
  //                                                                 '',
  //                                                                 '',
  //                                                                 startDateSelected,
  //                                                                 endDateSelected)
  //                                                             .then(
  //                                                                 (value) async {
  //                                                           Navigator.pop(
  //                                                               context);
  //                                                         });
  //                                                       },
  //                                                     ),
  //                                                   ),
  //                                                 ],
  //                                               ),
  //                                             ),
  //                                           ],
  //                                         ),
  //                                       ),
  //                                     ),
  //                                   ),
  //                                 ),
  //                               ),
  //                               const Align(
  //                                   alignment: Alignment.centerLeft,
  //                                   child: Padding(
  //                                     padding: EdgeInsets.only(
  //                                         left: 2.0,
  //                                         right: 2.0,
  //                                         top: 10.0,
  //                                         bottom: 8),
  //                                     child: Text(
  //                                       "SUBSTATION",
  //                                       style: TextStyle(
  //                                         fontSize: 16.0,
  //                                         color: AppColors.baseColor,
  //                                         fontWeight: FontWeight.bold,
  //                                       ),
  //                                     ),
  //                                   )),
  //                               Align(
  //                                 alignment: Alignment.centerLeft,
  //                                 child: Padding(
  //                                   padding: const EdgeInsets.all(2.0),
  //                                   child: Container(
  //                                     padding: const EdgeInsets.symmetric(
  //                                         horizontal: 12, vertical: 4),
  //                                     width: size.width * 0.9,
  //                                     decoration: BoxDecoration(
  //                                       border: Border.all(
  //                                         color: const Color.fromARGB(
  //                                             255, 7, 59, 120),
  //                                       ),
  //                                     ),
  //                                     child: MultiSelectDialogField(
  //                                         items: vegetationManagementDashboardViewModel
  //                                             .vegetationManagementDashboardList
  //                                             .data!
  //                                             .substationList!
  //                                             .map((e) => MultiSelectItem(
  //                                                 e.substationName.toString(),
  //                                                 e.substationName.toString()))
  //                                             .toList(),
  //                                         initialValue: (selectedSubstation ==
  //                                                     null ||
  //                                                 selectedSubstation
  //                                                     .toString()
  //                                                     .isEmpty)
  //                                             ? []
  //                                             : selectedSubstation!.split(','),
  //                                         listType: MultiSelectListType.CHIP,
  //                                         buttonIcon: const Icon(
  //                                             Icons.arrow_drop_down,
  //                                             color: Color.fromARGB(
  //                                                 255, 7, 59, 120),
  //                                             size: 40),
  //                                         onConfirm: (value) {
  //                                           selectedSubstation =
  //                                               value.join(',');
  //                                           print(
  //                                               'selectedSubstation $selectedSubstation');
  //                                           loadingFlag = 0;
  //                                           vegetationManagementDashboardViewModel
  //                                               .fetchVegetationManagementDashboardListApi(
  //                                                   context,
  //                                                   'TYPE',
  //                                                   bSpray,
  //                                                   aMowing,
  //                                                   cMowingNoSpray,
  //                                                   dJaraffMowingSprayWork,
  //                                                   eGroundWork,
  //                                                   fJaraffMowingNoSpray,
  //                                                   gBucketWork,
  //                                                   selectedSubstation
  //                                                       .toString(),
  //                                                   '',
  //                                                   '',
  //                                                   startDateSelected,
  //                                                   endDateSelected)
  //                                               .then((value) async {
  //                                             Navigator.pop(context);
  //                                           });
  //                                           (value) => value == null
  //                                               ? 'field required'
  //                                               : null;
  //                                         }),
  //                                   ),
  //                                 ),
  //                               ),
  //                             ],
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 ]),
  //               ),
  //             ],
  //           )),
  //         );
  //       });
  //     });

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
  // String? _imagePath;

  @override
  void initState() {
    setUserName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
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
                    title: const Text('Dashboard'),
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
                    title: const Text('Work Order'),
                    textColor: AppColors.baseColor,
                    iconColor: AppColors.baseColor,
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const ChangeOrderNewInDrawer()));
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
                              const ServiceOrder()));
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.rowing,
                    ),
                    title: const Text('Job List'),
                    textColor: AppColors.baseColor,
                    iconColor: AppColors.baseColor,
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              SupervisorAddNewRowTable(index: '0')));
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.inventory,
                    ),
                    title: const Text('IVM Maintenance Progress'),
                    textColor: AppColors.baseColor,
                    iconColor: AppColors.baseColor,
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const SupervisorRowMaintenanceProgress()));
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
                    leading: Icon(
                      Icons.list,
                    ),
                    title: const Text('Invoice List'),
                    textColor: AppColors.baseColor,
                    iconColor: AppColors.baseColor,
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              SupInvoiceList()));
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
                  //  ListTile(
                  //   leading: const Icon(
                  //     Icons.map,
                  //   ),
                  //  title: const Text('Location Map LeafLat1'),
                  //   textColor: AppColors.baseColor,
                  //   iconColor: AppColors.baseColor,
                  //   onTap: () {
                  //     provider.getLocation();
                  //     Navigator.of(context).push(MaterialPageRoute(
                  //         builder: (context) => const MapScreenLeafLat1()));
                  //   },
                  // ),

                  ListTile(
                    leading: const Icon(
                      Icons.approval,
                    ),
                    title: const Text('Approve CIVM Access'),
                    textColor: AppColors.baseColor,
                    iconColor: AppColors.baseColor,
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const SupervisorApproveCIVMAccess()));
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
                              const SupervisorAddCrewMember()));
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
                      // Navigator.of(context).pushReplacement(MaterialPageRoute(
                      //     builder: (BuildContext context) => const LoginPage()));

                      userPreferences.remove().then((value) {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
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
    // String imageUrl =
    //     'https://atsdev2test.ariespro.com/assets/clientuploads/${data.user!.profilePhoto}';
    // _imagePath = imageUrl;
    setState(() {
      userName = '${data.user!.fName} ${data.user!.lName}';
    });
  }
}



class YourData {
  final String feeder;
  final String subStationName;

  YourData(
    this.feeder,
    this.subStationName,
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is YourData &&
          runtimeType == other.runtimeType &&
          feeder == other.feeder &&
          subStationName == other.subStationName;

  @override
  int get hashCode => feeder.hashCode ^ subStationName.hashCode;
}
