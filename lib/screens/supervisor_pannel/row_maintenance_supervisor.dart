import 'dart:convert';
import 'dart:io';
import 'package:CIVM/data/response/status.dart';
import 'package:CIVM/models/graph_vegetation_management_dashboard.dart';
import 'package:CIVM/models/user_model.dart';
import 'package:CIVM/models/vegetation_management_dashboard_model.dart';
import 'package:CIVM/resources/app_url.dart';
import 'package:CIVM/screens/supervisor_pannel/sup_change_order_all_status.dart';
import 'package:CIVM/screens/supervisor_pannel/supervisor_ivm_all_status.dart';
import 'package:CIVM/screens/supervisor_pannel/supervisor_user_management_tabs.dart';
import 'package:CIVM/utils/common_functions.dart';
import 'package:CIVM/screens/login_page.dart';
import 'package:CIVM/screens/map/provider/location_provider.dart';
import 'package:CIVM/screens/supervisor_pannel/supervisor_add_new_row_table.dart';
import 'package:CIVM/screens/supervisor_pannel/supervisor_inspection_zielies.dart';
import 'package:CIVM/screens/supervisor_pannel/supervisor_row_maintenance_progress.dart';
import 'package:CIVM/sharedPrefs/constants.dart';
import 'package:CIVM/utils/user_pref.dart';
import 'package:CIVM/view_model/vegetation_management_dashboard_view_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import 'package:provider/provider.dart';
import 'package:CIVM/screens/leaflat_map/leaf_lat_map_wakeLock.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

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
  // var _setState;
  bool _isVisibleDaily = false;
  bool _isVisibleMonthly = true;

  DateTimeRange? dateRange;
  String startDateSelected = DateFormat(
    'yyyy-MM-dd',
  ).format(DateTime.now().subtract(const Duration(days: 7)));
  String endDateSelected = DateFormat('yyyy-MM-dd').format(DateTime.now());

  late String dateSelected1 = '$startDateSelected - $endDateSelected';

  Future<void> selectDateRange(BuildContext context) async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2010),
      lastDate: DateTime(2050),
      initialDateRange:
          dateRange ??
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
    'Dec',
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
  String dJaraffMowingSprayWork = 'JARRAFF, MOWING, SPRAY WORK';
  String eGroundWork = 'GROUND WORK';
  String fJaraffMowingNoSpray = 'JARRAFF, MOWING, NO SPRAY';
  String gBucketWork = 'BUCKET WORK';

  String monthNo = '';
  String? selectedSubstation;

  List<String> years = ["2021", "2022", "2023", "2024", "2025", "2026", "2027"];
  String? selectedYear;
  var selectedYearCurrent;

  @override
  void initState() {
    selectedYear = selectedYearCurrent = currentYear.toString();
    dynamicYear = currentYear.toString();
    //  year = currentYear.toString();
    vegetationManagementDashboardViewModel
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
          '',
          '',
          '',
          selectedYearCurrent,
        );
    _initializeScreen();
    super.initState();
  }

  var _parentSetState;

  @override
  Widget build(BuildContext context) {
    _parentSetState = setState;
    Size size = MediaQuery.of(context).size;
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) {
          return;
        }
        showExitPopup(context);
      },
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text('Dashboard', style: TextStyle(color: Colors.white)),
          backgroundColor: const Color.fromARGB(255, 7, 59, 120),
          actions: [
            InkWell(
              onTap: () {
                _initializeScreen();
                showYearFilterDialog();
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  // width: 75,
                  height: kToolbarHeight,
                  margin: const EdgeInsets.only(right: 8),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromARGB(255, 17, 69, 129),
                        blurRadius: 10,
                        offset: Offset(2.0, 5.0),
                      ),
                    ],
                    gradient: const LinearGradient(
                      colors: [
                        Color.fromARGB(255, 30, 108, 196),
                        Color.fromARGB(255, 71, 152, 246),
                      ],
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8),
                    child: Text(
                      selectedYear ?? '',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        height: 1.0,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
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
                      top: 16.0,
                      bottom: 16,
                      left: 8,
                      right: 8,
                    ),
                    child: Center(
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/empty_box.png',
                              height: 200,
                              width: 200,
                              fit: BoxFit.cover,
                            ),
                            const Center(
                              child: Text(
                                'Sorry, Data Not Found!',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Color.fromARGB(255, 7, 59, 120),
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
                    
                vegetationManagementDashboardViewModel
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
                          '',
                          '',
                          '',
                          selectedYear.toString(),
                        );
                      _initializeScreen();
                    },
                    // Important when content is smaller than screen
                    displacement: 40,
                    edgeOffset: 10,
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(
                              top: 10,
                              bottom: 10,
                              left: 8,
                              right: 8,
                            ),
                            padding: const EdgeInsets.all(8),
                            alignment: Alignment.center,
                            // height: size.height * 0.55,
                            width: size.width * 0.99,
                            decoration: BoxDecoration(
                              // shape: BoxShape.circle,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color.fromARGB(255, 3, 47, 97),
                                  blurRadius: 10,
                                  offset: Offset(2.0, 5.0),
                                ),
                              ],
                              gradient: const LinearGradient(
                                colors: [
                                  Color.fromARGB(255, 255, 255, 255),
                                  Color.fromARGB(255, 255, 255, 255),
                                ],
                              ),
                            ),
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
                                        color: Color.fromARGB(255, 3, 47, 97),
                                        blurRadius: 5,
                                        offset: Offset(2.0, 5.0),
                                      ),
                                    ],
                                    gradient: LinearGradient(
                                      colors: [
                                        Color.fromARGB(255, 7, 59, 120),
                                        Color.fromARGB(255, 7, 59, 120),
                                      ],
                                    ),
                                  ),
                                  child: const Row(
                                    children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Change Order For Review",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    right: 8,
                                    left: 8,
                                  ),
                                  child: Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          // Navigator.of(context).push(
                                          //     MaterialPageRoute(
                                          //         builder: (BuildContext
                                          //                 context) =>
                                          //             WorkForApprovalSupervisor(
                                          //               budgetType: '',
                                          //               maintenanceType:
                                          //                   'Change Order',
                                          //               heading: 'CO',
                                          //             )));
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  SupChangeOrderAllStatus(
                                                    source: '',
                                                    year: selectedYear
                                                        .toString(),
                                                  ),
                                            ),
                                          );
                                        },
                                        child: DashboardCard(
                                          cardIcon: 'assets/Orders_Pending.png',
                                          cardColor: const Color.fromRGBO(
                                            79,
                                            130,
                                            156,
                                            1,
                                          ),
                                          cardTitle: 'Pending LCP Approval',
                                          cardCount:
                                              (vegetationManagementDashboardViewModel
                                                          .vegetationManagementDashboardList
                                                          .data!
                                                          .getChangeOrderWFACount ==
                                                      null ||
                                                  vegetationManagementDashboardViewModel
                                                          .vegetationManagementDashboardList
                                                          .data!
                                                          .getChangeOrderWFACount
                                                          .toString() ==
                                                      'null')
                                              ? ''
                                              : vegetationManagementDashboardViewModel
                                                    .vegetationManagementDashboardList
                                                    .data!
                                                    .getChangeOrderWFACount
                                                    .toString(),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      // InkWell(
                                      //   onTap: () {
                                      //     Navigator.of(context).push(
                                      //         MaterialPageRoute(
                                      //             builder: (BuildContext
                                      //                     context) =>
                                      //                 SupervisorZIELIESDocumentApprovalPending(
                                      //                   budgetType: '',
                                      //                   maintenanceType:
                                      //                       'Change Order',
                                      //                   heading: 'Change Order',
                                      //                 )));
                                      //   },
                                      //   child: DashboardCard(
                                      //     cardIcon: 'assets/Orders_Pending.png',
                                      //     cardColor: const Color.fromRGBO(
                                      //         157, 79, 79, 1),
                                      //     cardTitle: 'Ready For Review',
                                      //     cardCount: (vegetationManagementDashboardViewModel
                                      //                     .vegetationManagementDashboardList
                                      //                     .data!
                                      //                     .getChangeOrdercount ==
                                      //                 null ||
                                      //             vegetationManagementDashboardViewModel
                                      //                     .vegetationManagementDashboardList
                                      //                     .data!
                                      //                     .getChangeOrdercount
                                      //                     .toString() ==
                                      //                 'null')
                                      //         ? ''
                                      //         : vegetationManagementDashboardViewModel
                                      //             .vegetationManagementDashboardList
                                      //             .data!
                                      //             .getChangeOrdercount
                                      //             .toString(),
                                      //   ),
                                      // ),
                                      InkWell(
                                        onTap: () {
                                          // Navigator.of(context).push(
                                          //   MaterialPageRoute(
                                          //     builder: (BuildContext context) =>
                                          //         SupervisorZIELIESTotalOrderPending(
                                          //           budgetType: '',
                                          //           maintenanceType:
                                          //               'Change Order',
                                          //           heading: 'Change Order',
                                          //         ),
                                          //   ),
                                          // );
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  SupChangeOrderAllStatus(
                                                    source: '',
                                                    year: selectedYear
                                                        .toString(),
                                                  ),
                                            ),
                                          );
                                        },
                                        child: DashboardCard(
                                          cardIcon: 'assets/Orders_Pending.png',
                                          cardColor: const Color.fromRGBO(
                                            157,
                                            79,
                                            79,
                                            1,
                                          ),
                                          cardTitle: 'Crew In Progress',
                                          cardCount:
                                              (vegetationManagementDashboardViewModel
                                                          .vegetationManagementDashboardList
                                                          .data!
                                                          .changeOrderPendingCount ==
                                                      null ||
                                                  vegetationManagementDashboardViewModel
                                                          .vegetationManagementDashboardList
                                                          .data!
                                                          .changeOrderPendingCount
                                                          .toString() ==
                                                      'null')
                                              ? ''
                                              : vegetationManagementDashboardViewModel
                                                    .vegetationManagementDashboardList
                                                    .data!
                                                    .changeOrderPendingCount
                                                    .toString(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    right: 8,
                                    left: 8,
                                  ),
                                  child: Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          // Navigator.of(context).push(
                                          //   MaterialPageRoute(
                                          //     builder: (BuildContext context) =>
                                          //         TotalOrderCanceledSupervisorCO(
                                          //           budgetType: '',
                                          //           maintenanceType:
                                          //               'Change Order',
                                          //           heading:
                                          //               'CO - Total Inspection (Cancelled)',
                                          //         ),
                                          //   ),
                                          // );
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  SupChangeOrderAllStatus(
                                                    source: '',
                                                    year: selectedYear
                                                        .toString(),
                                                  ),
                                            ),
                                          );
                                        },
                                        child: DashboardCard(
                                          cardIcon: 'assets/Orders_Pending.png',
                                          cardColor: const Color.fromRGBO(
                                            75,
                                            58,
                                            105,
                                            1,
                                          ),
                                          cardTitle: 'Rejected',
                                          cardCount:
                                              (vegetationManagementDashboardViewModel
                                                          .vegetationManagementDashboardList
                                                          .data!
                                                          .changeOrderCancelledCount ==
                                                      null ||
                                                  vegetationManagementDashboardViewModel
                                                          .vegetationManagementDashboardList
                                                          .data!
                                                          .changeOrderCancelledCount
                                                          .toString() ==
                                                      'null')
                                              ? ''
                                              : vegetationManagementDashboardViewModel
                                                    .vegetationManagementDashboardList
                                                    .data!
                                                    .changeOrderCancelledCount
                                                    .toString(),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      InkWell(
                                        onTap: () {
                                          // Navigator.of(context).push(
                                          //   MaterialPageRoute(
                                          //     builder: (BuildContext context) =>
                                          //         SupervisorZIELIESTotalOrderClosed(
                                          //           budgetType: '',
                                          //           maintenanceType:
                                          //               'Change Order',
                                          //           heading: 'CO',
                                          //         ),
                                          //   ),
                                          // );
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  SupChangeOrderAllStatus(
                                                    source: '',
                                                    year: selectedYear
                                                        .toString(),
                                                  ),
                                            ),
                                          );
                                        },
                                        child: DashboardCard(
                                          cardIcon: 'assets/Orders_Open.png',
                                          cardColor: const Color.fromRGBO(
                                            123,
                                            113,
                                            54,
                                            1,
                                          ),
                                          cardTitle: 'Completed',
                                          cardCount:
                                              (vegetationManagementDashboardViewModel
                                                          .vegetationManagementDashboardList
                                                          .data!
                                                          .changeOrderClosedCount ==
                                                      null ||
                                                  vegetationManagementDashboardViewModel
                                                          .vegetationManagementDashboardList
                                                          .data!
                                                          .changeOrderClosedCount
                                                          .toString() ==
                                                      'null')
                                              ? ''
                                              : vegetationManagementDashboardViewModel
                                                    .vegetationManagementDashboardList
                                                    .data!
                                                    .changeOrderClosedCount
                                                    .toString(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                              top: 10,
                              bottom: 10,
                              left: 8,
                              right: 8,
                            ),
                            padding: const EdgeInsets.all(8),
                            alignment: Alignment.center,
                            // height: size.height * 0.55,
                            width: size.width * 0.99,
                            decoration: BoxDecoration(
                              // shape: BoxShape.circle,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color.fromARGB(255, 3, 47, 97),
                                  blurRadius: 10,
                                  offset: Offset(2.0, 5.0),
                                ),
                              ],
                              gradient: const LinearGradient(
                                colors: [
                                  Color.fromARGB(255, 255, 255, 255),
                                  Color.fromARGB(255, 255, 255, 255),
                                ],
                              ),
                            ),
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
                                        color: Color.fromARGB(255, 3, 47, 97),
                                        blurRadius: 5,
                                        offset: Offset(2.0, 5.0),
                                      ),
                                    ],
                                    gradient: LinearGradient(
                                      colors: [
                                        Color.fromARGB(255, 7, 59, 120),
                                        Color.fromARGB(255, 7, 59, 120),
                                      ],
                                    ),
                                  ),
                                  child: const Row(
                                    children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "IVM Inspection",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    right: 8,
                                    left: 8,
                                  ),
                                  child: Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          // Navigator.of(context).push(
                                          //   MaterialPageRoute(
                                          //     builder: (BuildContext context) =>
                                          //         SupervisorZIELIESDocumentApprovalPending(
                                          //           budgetType:
                                          //               'Regular IVM maintenance',
                                          //           maintenanceType:
                                          //               'RegularMaint',
                                          //           heading: 'IVM maintenance',
                                          //         ),
                                          //   ),
                                          // );
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  SupervisorIvmAllStatus(
                                                    budgetType:
                                                        'Regular IVM maintenance',
                                                    maintenanceType:
                                                        'RegularMaint',
                                                    heading: 'IVM',
                                                    year: selectedYear
                                                        .toString(),
                                                  ),
                                            ),
                                          );
                                        },
                                        child: DashboardCard(
                                          cardIcon: 'assets/Orders_Pending.png',
                                          cardColor: const Color.fromRGBO(
                                            79,
                                            130,
                                            156,
                                            1,
                                          ),
                                          cardTitle: 'Ready For Inspection',
                                          cardCount:
                                              (vegetationManagementDashboardViewModel
                                                          .vegetationManagementDashboardList
                                                          .data!
                                                          .getRegularIVMMaintenanceCount ==
                                                      null ||
                                                  vegetationManagementDashboardViewModel
                                                          .vegetationManagementDashboardList
                                                          .data!
                                                          .getRegularIVMMaintenanceCount
                                                          .toString() ==
                                                      'null')
                                              ? ''
                                              : vegetationManagementDashboardViewModel
                                                    .vegetationManagementDashboardList
                                                    .data!
                                                    .getRegularIVMMaintenanceCount
                                                    .toString(),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      InkWell(
                                        onTap: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  SupervisorAddNewRowTable(
                                                    index: '0',
                                                    budgetType: "",
                                                    year: selectedYear
                                                        .toString(),
                                                  ),
                                            ),
                                          );
                                        },
                                        child: DashboardCard(
                                          cardIcon: 'assets/Orders_Pending.png',
                                          cardColor: const Color.fromRGBO(
                                            157,
                                            79,
                                            79,
                                            1,
                                          ),
                                          cardTitle: 'Crew In Progress',
                                          cardCount:
                                              (vegetationManagementDashboardViewModel
                                                          .vegetationManagementDashboardList
                                                          .data!
                                                          .iVMPendingCount ==
                                                      null ||
                                                  vegetationManagementDashboardViewModel
                                                          .vegetationManagementDashboardList
                                                          .data!
                                                          .iVMPendingCount
                                                          .toString() ==
                                                      'null')
                                              ? ''
                                              : vegetationManagementDashboardViewModel
                                                    .vegetationManagementDashboardList
                                                    .data!
                                                    .iVMPendingCount
                                                    .toString(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    right: 8,
                                    left: 8,
                                  ),
                                  child: Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  SupervisorAddNewRowTable(
                                                    index: '0',
                                                    budgetType: "",
                                                    year: selectedYear
                                                        .toString(),
                                                  ),
                                            ),
                                          );
                                        },
                                        child: DashboardCard(
                                          cardIcon: 'assets/Orders_Open.png',
                                          cardColor: const Color.fromRGBO(
                                            123,
                                            113,
                                            54,
                                            1,
                                          ),
                                          cardTitle: 'Completed',
                                          cardCount:
                                              (vegetationManagementDashboardViewModel
                                                          .vegetationManagementDashboardList
                                                          .data!
                                                          .iVMClosedCount ==
                                                      null ||
                                                  vegetationManagementDashboardViewModel
                                                          .vegetationManagementDashboardList
                                                          .data!
                                                          .iVMClosedCount
                                                          .toString() ==
                                                      'null')
                                              ? ''
                                              : vegetationManagementDashboardViewModel
                                                    .vegetationManagementDashboardList
                                                    .data!
                                                    .iVMClosedCount
                                                    .toString(),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Spacer(),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10),
                              ],
                            ),
                          ),

                          // Container(
                          //   margin: const EdgeInsets.only(
                          //     top: 10,
                          //     bottom: 10,
                          //     left: 8,
                          //     right: 8,
                          //   ),
                          //   padding: const EdgeInsets.all(8),
                          //   alignment: Alignment.center,
                          //   // height: size.height * 0.55,
                          //   width: size.width * 0.99,
                          //   decoration: BoxDecoration(
                          //     // shape: BoxShape.circle,
                          //     borderRadius: BorderRadius.circular(10),
                          //     boxShadow: const [
                          //       BoxShadow(
                          //         color: Color.fromARGB(255, 3, 47, 97),
                          //         blurRadius: 10,
                          //         offset: Offset(2.0, 5.0),
                          //       ),
                          //     ],
                          //     gradient: const LinearGradient(
                          //       colors: [
                          //         Color.fromARGB(255, 255, 255, 255),
                          //         Color.fromARGB(255, 255, 255, 255),
                          //       ],
                          //     ),
                          //   ),
                          //   child: Column(
                          //     children: [
                          //       Container(
                          //         margin: EdgeInsets.only(
                          //           left: 4,
                          //           right: 4,
                          //           bottom: 4,
                          //           top: 4,
                          //         ),
                          //         padding: EdgeInsets.only(
                          //           left: 4,
                          //           right: 4,
                          //           bottom: 4,
                          //           top: 4,
                          //         ),
                          //         alignment: Alignment.center,
                          //         width: size.width * 0.99,
                          //         // width: MediaQuery.of(context).size.width,
                          //         // height: 40,
                          //         decoration: const BoxDecoration(
                          //           // shape: BoxShape.circle,
                          //           //borderRadius: BorderRadius.circular(25),
                          //           boxShadow: [
                          //             BoxShadow(
                          //               color: Color.fromARGB(255, 3, 47, 97),
                          //               blurRadius: 5,
                          //               offset: Offset(2.0, 5.0),
                          //             ),
                          //           ],
                          //           color: Color.fromARGB(255, 130, 193, 245),
                          //           gradient: LinearGradient(
                          //             colors: [
                          //               Color.fromARGB(255, 7, 59, 120),
                          //               Color.fromARGB(255, 7, 59, 120),
                          //             ],
                          //           ),
                          //         ),
                          //         child: Row(
                          //           crossAxisAlignment: CrossAxisAlignment.center,
                          //           mainAxisAlignment:
                          //               MainAxisAlignment.spaceBetween,
                          //           children: [
                          //             const Align(
                          //               alignment: Alignment.centerLeft,
                          //               child: Text(
                          //                 "IVM Status",
                          //                 textAlign: TextAlign.left,
                          //                 style: TextStyle(
                          //                   color: Colors.white,
                          //                   fontWeight: FontWeight.bold,
                          //                   fontSize: 20,
                          //                 ),
                          //               ),
                          //             ),
                          //             InkWell(
                          //               onTap: () async {
                          //                 Navigator.of(context).push(
                          //                   MaterialPageRoute(
                          //                     builder: (BuildContext context) =>
                          //                         const SupervisorRowMaintenanceProgress(),
                          //                   ),
                          //                 );
                          //               },
                          //               child: Padding(
                          //                 padding: const EdgeInsets.only(
                          //                   left: 8.0,
                          //                   right: 8,
                          //                   bottom: 8,
                          //                   top: 8,
                          //                 ),
                          //                 child: Align(
                          //                   alignment: Alignment.centerRight,
                          //                   child: Container(
                          //                     width: 120,
                          //                     padding: const EdgeInsets.all(4),
                          //                     alignment: Alignment.center,
                          //                     decoration: BoxDecoration(
                          //                       // shape: BoxShape.circle,
                          //                       borderRadius:
                          //                           BorderRadius.circular(10),
                          //                       boxShadow: const [
                          //                         BoxShadow(
                          //                           color: Color.fromARGB(
                          //                             255,
                          //                             3,
                          //                             47,
                          //                             97,
                          //                           ),
                          //                           blurRadius: 5,
                          //                           offset: Offset(2.0, 5.0),
                          //                         ),
                          //                       ],
                          //                       color: const Color.fromARGB(
                          //                         255,
                          //                         130,
                          //                         193,
                          //                         245,
                          //                       ),
                          //                       gradient: const LinearGradient(
                          //                         colors: [
                          //                           Colors.white,
                          //                           Colors.white,
                          //                         ],
                          //                       ),
                          //                     ),
                          //                     child: const Row(
                          //                       children: [
                          //                         Expanded(
                          //                           child: Align(
                          //                             alignment: Alignment.center,
                          //                             child: Text(
                          //                               'View More',
                          //                               textAlign: TextAlign.left,
                          //                               style: TextStyle(
                          //                                 color: Color.fromARGB(
                          //                                   255,
                          //                                   7,
                          //                                   59,
                          //                                   120,
                          //                                 ),
                          //                                 fontWeight:
                          //                                     FontWeight.bold,
                          //                                 fontSize: 20,
                          //                               ),
                          //                             ),
                          //                           ),
                          //                         ),
                          //                       ],
                          //                     ),
                          //                   ),
                          //                 ),
                          //               ),
                          //             ),
                          //           ],
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),

                          // Container(
                          //   margin: const EdgeInsets.only(
                          //     top: 10,
                          //     bottom: 10,
                          //     left: 8,
                          //     right: 8,
                          //   ),
                          //   padding: const EdgeInsets.all(8),
                          //   alignment: Alignment.center,
                          //   height: size.height * 0.7,
                          //   width: size.width * 0.99,
                          //   decoration: BoxDecoration(
                          //     // shape: BoxShape.circle,
                          //     borderRadius: BorderRadius.circular(10),
                          //     boxShadow: const [
                          //       BoxShadow(
                          //         color: Color.fromARGB(255, 3, 47, 97),
                          //         blurRadius: 10,
                          //         offset: Offset(2.0, 5.0),
                          //       ),
                          //     ],
                          //     gradient: const LinearGradient(
                          //       colors: [
                          //         Color.fromARGB(255, 255, 255, 255),
                          //         Color.fromARGB(255, 255, 255, 255),
                          //       ],
                          //     ),
                          //   ),
                          //   child: Column(
                          //     children: [
                          //       Container(
                          //         padding: const EdgeInsets.all(10),
                          //         alignment: Alignment.center,
                          //         width: size.width * 0.99,
                          //         // width: MediaQuery.of(context).size.width,
                          //         height:
                          //             MediaQuery.of(context).size.height * 0.059,
                          //         decoration: const BoxDecoration(
                          //           // shape: BoxShape.circle,
                          //           //borderRadius: BorderRadius.circular(25),
                          //           boxShadow: [
                          //             BoxShadow(
                          //               color: Color.fromARGB(255, 3, 47, 97),
                          //               blurRadius: 5,
                          //               offset: Offset(2.0, 5.0),
                          //             ),
                          //           ],
                          //           color: Color.fromARGB(255, 130, 193, 245),
                          //           gradient: LinearGradient(
                          //             colors: [
                          //               Color.fromARGB(255, 7, 59, 120),
                          //               Color.fromARGB(255, 7, 59, 120),
                          //             ],
                          //           ),
                          //         ),
                          //         child: Row(
                          //           children: [
                          //             const Align(
                          //               alignment: Alignment.centerLeft,
                          //               child: Text(
                          //                 "IVM Summary",
                          //                 textAlign: TextAlign.left,
                          //                 style: TextStyle(
                          //                   color: Colors.white,
                          //                   fontWeight: FontWeight.bold,
                          //                   fontSize: 20,
                          //                 ),
                          //               ),
                          //             ),
                          //             Expanded(
                          //               child: Align(
                          //                 alignment: Alignment.centerRight,
                          //                 child: IconButton(
                          //                   icon: const Icon(
                          //                     Icons.filter_alt_outlined,
                          //                     color: Colors.white,
                          //                   ),
                          //                   onPressed: () {
                          //                     openDailogOverallSummary();
                          //                   },
                          //                 ),
                          //               ),
                          //             ),
                          //           ],
                          //         ),
                          //       ),
                          //       Expanded(
                          //         child: SingleChildScrollView(
                          //           child: Padding(
                          //             padding: const EdgeInsets.all(4.0),
                          //             child: ListView.builder(
                          //               shrinkWrap: true,
                          //               itemCount: dataset.length,
                          //               physics:
                          //                   const NeverScrollableScrollPhysics(),
                          //               // itemCount: energyhistory!.result!.length,
                          //               itemBuilder: (context, index) {
                          //                 return Container(
                          //                   margin: const EdgeInsets.only(
                          //                     top: 10,
                          //                     bottom: 10,
                          //                   ),
                          //                   padding: const EdgeInsets.all(8),
                          //                   alignment: Alignment.center,
                          //                   // height: size.height * 0.2,
                          //                   width: size.width - 40,
                          //                   decoration: BoxDecoration(
                          //                     // shape: BoxShape.circle,
                          //                     borderRadius: BorderRadius.circular(
                          //                       10,
                          //                     ),
                          //                     boxShadow: const [
                          //                       BoxShadow(
                          //                         color: Color.fromARGB(
                          //                           255,
                          //                           3,
                          //                           47,
                          //                           97,
                          //                         ),
                          //                         blurRadius: 10,
                          //                         offset: Offset(2.0, 5.0),
                          //                       ),
                          //                     ],
                          //                     gradient: const LinearGradient(
                          //                       colors: [
                          //                         Color.fromARGB(
                          //                           255,
                          //                           255,
                          //                           255,
                          //                           255,
                          //                         ),
                          //                         Color.fromARGB(
                          //                           255,
                          //                           255,
                          //                           255,
                          //                           255,
                          //                         ),
                          //                       ],
                          //                     ),
                          //                   ),
                          //                   child: Column(
                          //                     children: [
                          //                       Padding(
                          //                         padding: const EdgeInsets.only(
                          //                           top: 4.0,
                          //                           left: 8.0,
                          //                         ),
                          //                         child: Row(
                          //                           children: [
                          //                             const Expanded(
                          //                               child: Align(
                          //                                 alignment: Alignment
                          //                                     .centerLeft,
                          //                                 child: Text(
                          //                                   "Substation: ",
                          //                                   textAlign:
                          //                                       TextAlign.left,
                          //                                   style: TextStyle(
                          //                                     color:
                          //                                         Color.fromARGB(
                          //                                           255,
                          //                                           7,
                          //                                           59,
                          //                                           120,
                          //                                         ),
                          //                                     fontWeight:
                          //                                         FontWeight.bold,
                          //                                     fontSize: 16,
                          //                                   ),
                          //                                 ),
                          //                               ),
                          //                             ),
                          //                             Expanded(
                          //                               child: Align(
                          //                                 alignment: Alignment
                          //                                     .centerLeft,
                          //                                 child: Text(
                          //                                   (dataset[index]
                          //                                       .substation==null||dataset[index]
                          //                                             .substation.toString()=='null')?'':dataset[index]
                          //                                       .substation
                          //                                       .toString(),
                          //                                   textAlign:
                          //                                       TextAlign.left,
                          //                                   style: const TextStyle(
                          //                                     color:
                          //                                         Color.fromARGB(
                          //                                           255,
                          //                                           7,
                          //                                           59,
                          //                                           120,
                          //                                         ),
                          //                                     // fontWeight: FontWeight.bold,
                          //                                     fontSize: 16,
                          //                                   ),
                          //                                 ),
                          //                               ),
                          //                             ),
                          //                           ],
                          //                         ),
                          //                       ),
                          //                       Padding(
                          //                         padding: const EdgeInsets.only(
                          //                           top: 4.0,
                          //                           left: 8.0,
                          //                         ),
                          //                         child: Row(
                          //                           children: [
                          //                             const Expanded(
                          //                               child: Align(
                          //                                 alignment: Alignment
                          //                                     .centerLeft,
                          //                                 child: Text(
                          //                                   "Feeder: ",
                          //                                   textAlign:
                          //                                       TextAlign.left,
                          //                                   style: TextStyle(
                          //                                     color:
                          //                                         Color.fromARGB(
                          //                                           255,
                          //                                           7,
                          //                                           59,
                          //                                           120,
                          //                                         ),
                          //                                     fontWeight:
                          //                                         FontWeight.bold,
                          //                                     fontSize: 16,
                          //                                   ),
                          //                                 ),
                          //                               ),
                          //                             ),
                          //                             Expanded(
                          //                               child: Align(
                          //                                 alignment: Alignment
                          //                                     .centerLeft,
                          //                                 child: Text(
                          //                                   (dataset[index].feeder==null||dataset[index]
                          //                                             .feeder.toString()=='null')?'':dataset[index].feeder
                          //                                       .toString(),
                          //                                   textAlign:
                          //                                       TextAlign.left,
                          //                                   style: const TextStyle(
                          //                                     color:
                          //                                         Color.fromARGB(
                          //                                           255,
                          //                                           7,
                          //                                           59,
                          //                                           120,
                          //                                         ),
                          //                                     // fontWeight: FontWeight.bold,
                          //                                     fontSize: 16,
                          //                                   ),
                          //                                 ),
                          //                               ),
                          //                             ),
                          //                           ],
                          //                         ),
                          //                       ),
                          //                       const Padding(
                          //                         padding: EdgeInsets.only(
                          //                           top: 10.0,
                          //                           left: 8.0,
                          //                         ),
                          //                         child: Row(
                          //                           children: [
                          //                             Expanded(
                          //                               child: Align(
                          //                                 alignment: Alignment
                          //                                     .centerLeft,
                          //                                 child: Text(
                          //                                   "Row Maintenance Percentage: ",
                          //                                   textAlign:
                          //                                       TextAlign.left,
                          //                                   style: TextStyle(
                          //                                     color:
                          //                                         Color.fromARGB(
                          //                                           255,
                          //                                           7,
                          //                                           59,
                          //                                           120,
                          //                                         ),
                          //                                     fontWeight:
                          //                                         FontWeight.bold,
                          //                                     fontSize: 16,
                          //                                   ),
                          //                                 ),
                          //                               ),
                          //                             ),
                          //                           ],
                          //                         ),
                          //                       ),
                          //                       PrimerProgressBar(
                          //                         segments: [
                          //                           Segment(
                          //                             value:
                          //                                 (dataset[index].spray !=
                          //                                     null)
                          //                                 ? (double.parse(
                          //                                     dataset[index].spray
                          //                                         .toString(),
                          //                                   ).toInt())
                          //                                 : 0,
                          //                             color: Colors.purple,
                          //                             label: const Text("SPRAY"),
                          //                           ),
                          //                           Segment(
                          //                             value:
                          //                                 (dataset[index]
                          //                                         .mowing !=
                          //                                     null)
                          //                                 ? double.parse(
                          //                                     dataset[index]
                          //                                         .mowing
                          //                                         .toString(),
                          //                                   ).toInt()
                          //                                 : 0,
                          //                             color: const Color.fromARGB(
                          //                               255,
                          //                               121,
                          //                               10,
                          //                               2,
                          //                             ),
                          //                             label: const Text("MOWING"),
                          //                           ),
                          //                           Segment(
                          //                             value:
                          //                                 (dataset[index]
                          //                                         .mowingNoSpray !=
                          //                                     null)
                          //                                 ? double.parse(
                          //                                     dataset[index]
                          //                                         .mowingNoSpray
                          //                                         .toString(),
                          //                                   ).toInt()
                          //                                 : 0,
                          //                             color: const Color.fromARGB(
                          //                               255,
                          //                               249,
                          //                               135,
                          //                               173,
                          //                             ),
                          //                             label: const Text(
                          //                               "MOWING,NO SPRAY",
                          //                             ),
                          //                           ),
                          //                           Segment(
                          //                             value:
                          //                                 (dataset[index]
                          //                                         .jaraffMowingSprayWork !=
                          //                                     null)
                          //                                 ? double.parse(
                          //                                     dataset[index]
                          //                                         .jaraffMowingSprayWork
                          //                                         .toString(),
                          //                                   ).toInt()
                          //                                 : 0,
                          //                             color: Colors.green,
                          //                             label: const Text(
                          //                               "JARRAFF, MOWING, SPRAY WORK",
                          //                             ),
                          //                           ),
                          //                           Segment(
                          //                             value:
                          //                                 (dataset[index]
                          //                                         .groundWork !=
                          //                                     null)
                          //                                 ? double.parse(
                          //                                     dataset[index]
                          //                                         .groundWork
                          //                                         .toString(),
                          //                                   ).toInt()
                          //                                 : 0,
                          //                             color: Colors.yellow,
                          //                             label: const Text(
                          //                               "GROUND_WORK",
                          //                             ),
                          //                           ),
                          //                           Segment(
                          //                             value:
                          //                                 (dataset[index]
                          //                                         .jaraffMowingNoSpray !=
                          //                                     null)
                          //                                 ? double.parse(
                          //                                     dataset[index]
                          //                                         .jaraffMowingNoSpray
                          //                                         .toString(),
                          //                                   ).toInt()
                          //                                 : 0,
                          //                             color: Colors.red,
                          //                             label: const Text(
                          //                               "JARRAFF, MOWING, NO SPRAY",
                          //                             ),
                          //                           ),
                          //                           Segment(
                          //                             value:
                          //                                 (dataset[index]
                          //                                         .bucketWork !=
                          //                                     null)
                          //                                 ? double.parse(
                          //                                     dataset[index]
                          //                                         .bucketWork
                          //                                         .toString(),
                          //                                   ).toInt()
                          //                                 : 0,
                          //                             color: const Color.fromARGB(
                          //                               255,
                          //                               21,
                          //                               5,
                          //                               243,
                          //                             ),
                          //                             label: const Text(
                          //                               "BUCKET WORK",
                          //                             ),
                          //                           ),
                          //                         ],
                          //                         // legendStyle:
                          //                         //     const SegmentedBarLegendStyle(
                          //                         //         maxLines: 2),
                          //                       ),

                          //                       // TinyBarChart.stacked(
                          //                       //   data: <double>[
                          //                       //     dataset[index].spray ?? 0.0,
                          //                       //     dataset[index].mowing ??
                          //                       //         0.0,
                          //                       //     dataset[index]
                          //                       //             .mowingNoSpray ??
                          //                       //         0.0,
                          //                       //     dataset[index]
                          //                       //             .jaraffMowingSprayWork ??
                          //                       //         0.0,
                          //                       //     dataset[index].groundWork ??
                          //                       //         0.0,
                          //                       //     dataset[index]
                          //                       //             .jaraffMowingNoSpray ??
                          //                       //         0.0,
                          //                       //     dataset[index].bucketWork ??
                          //                       //         0.0
                          //                       //   ],
                          //                       //   options:
                          //                       //       const TinyBarChartOptions(
                          //                       //     colors: [
                          //                       //       Color.fromARGB(
                          //                       //           255, 2, 125, 6),
                          //                       //       Color.fromARGB(
                          //                       //           255, 138, 11, 2),
                          //                       //       Color.fromARGB(
                          //                       //           255, 249, 160, 190),
                          //                       //       Color.fromARGB(
                          //                       //           255, 94, 1, 110),
                          //                       //       Colors.yellow,
                          //                       //       Colors.red,
                          //                       //       Colors.blue
                          //                       //     ],
                          //                       //   ),
                          //                       //   width: size.width * 0.9,
                          //                       //   height: 28,
                          //                       // ),
                          //                     ],
                          //                   ),
                          //                 );
                          //               },
                          //             ),
                          //           ),
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
            },
          ),
        ),
      ),
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
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: CheckboxListTile(
                          title: const Text(
                            "SPRAY",
                            style: TextStyle(
                              color: Color.fromARGB(255, 7, 59, 120),
                              fontSize: 20,
                            ),
                          ),
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
                          checkColor: const Color.fromARGB(255, 7, 59, 120),
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
                            colors: [Colors.purple, Colors.purple],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CheckboxListTile(
                          title: const Text(
                            "MOWING",
                            style: TextStyle(
                              color: Color.fromARGB(255, 7, 59, 120),
                              fontSize: 20,
                            ),
                          ),
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
                          checkColor: const Color.fromARGB(255, 7, 59, 120),
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
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CheckboxListTile(
                          title: const Text(
                            "MOWING, NO SPRAY",
                            style: TextStyle(
                              color: Color.fromARGB(255, 7, 59, 120),
                              fontSize: 20,
                            ),
                          ),
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
                          checkColor: const Color.fromARGB(255, 7, 59, 120),
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
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CheckboxListTile(
                          title: const Text(
                            "JARRAFF, MOWING, SPRAY WORK",
                            style: TextStyle(
                              color: Color.fromARGB(255, 7, 59, 120),
                              fontSize: 20,
                            ),
                          ),
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
                          checkColor: const Color.fromARGB(255, 7, 59, 120),
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
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CheckboxListTile(
                          title: const Text(
                            "GROUND WORK",
                            style: TextStyle(
                              color: Color.fromARGB(255, 7, 59, 120),
                              fontSize: 20,
                            ),
                          ),
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
                          checkColor: const Color.fromARGB(255, 7, 59, 120),
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
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CheckboxListTile(
                          title: const Text(
                            "JARRAFF, MOWING, NO SPRAY",
                            style: TextStyle(
                              color: Color.fromARGB(255, 7, 59, 120),
                              fontSize: 20,
                            ),
                          ),
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
                          checkColor: const Color.fromARGB(255, 7, 59, 120),
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
                            colors: [Colors.red, Colors.red],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CheckboxListTile(
                          title: const Text(
                            "BUCKET WORK",
                            style: TextStyle(
                              color: Color.fromARGB(255, 7, 59, 120),
                              fontSize: 20,
                            ),
                          ),
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
                          checkColor: const Color.fromARGB(255, 7, 59, 120),
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
                          ),
                        ),
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
                    color: Color.fromARGB(255, 7, 59, 120),
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          );
        },
      );
    },
  );

  _recreateDataMain() {
    dataset.clear();
    if (vegetationManagementDashboardViewModel
                .vegetationManagementDashboardList
                .data !=
            null &&
        vegetationManagementDashboardViewModel
                .vegetationManagementDashboardList
                .data!
                .getSPGETPERCENTAGEAll !=
            null) {
      List<GetSPGETPERCENTAGEAll> yourDataList =
          vegetationManagementDashboardViewModel
              .vegetationManagementDashboardList
              .data!
              .getSPGETPERCENTAGEAll!;

      Set<YourData> uniqueData = <YourData>{};
      for (var item in yourDataList) {
        final data = YourData(
          item.feeder.toString(),
          item.subStationName.toString(),
        );
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
            if (b.type1 == 'JARRAFF,MOWING,SPRAY WORK' &&
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
            if (b.type1 == "JARRAFF,MOWING,NO SPRAY" &&
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
                .vegetationManagementDashboardList
                .data !=
            null &&
        vegetationManagementDashboardViewModel
                .vegetationManagementDashboardList
                .data!
                .getSPGETPERCENTAGEAll !=
            null) {
      List<GetSPGETPERCENTAGEAll> yourDataList =
          vegetationManagementDashboardViewModel
              .vegetationManagementDashboardList
              .data!
              .getSPGETPERCENTAGEAll!;

      Set<YourData> uniqueData = <YourData>{};
      for (var item in yourDataList) {
        final data = YourData(
          item.feeder.toString(),
          item.subStationName.toString(),
        );
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
            if (b.type1 == 'JARRAFF,MOWING,SPRAY WORK' &&
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
            if (b.type1 == "JARRAFF,MOWING,NO SPRAY" &&
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

  // _recreateDataFilterData(data) {
  //   setState(() {
  //     dataset.clear();
  //   });
  //   List<GetSPGETPERCENTAGEAll> yourDataList = [];
  //   data.forEach((a) {
  //     print('a00000 $a');
  //     a.forEach((b) {
  //       print('b0000 $b');
  //       GetSPGETPERCENTAGEAll getSPGETPERCENTAGEAll = GetSPGETPERCENTAGEAll();

  //       getSPGETPERCENTAGEAll.subStationName = b['subStationName'];
  //       getSPGETPERCENTAGEAll.feeder = b['feeder'];
  //       getSPGETPERCENTAGEAll.type1 = b['type1'];
  //       getSPGETPERCENTAGEAll.growthPercentage = b['growthPercentage'];

  //       yourDataList.add(getSPGETPERCENTAGEAll);
  //     });
  //   });

  //   Set<YourData> uniqueData = <YourData>{};
  //   for (var item in yourDataList) {
  //     final data =
  //         YourData(item.feeder.toString(), item.subStationName.toString());
  //     uniqueData.add(data);
  //   }
  //   for (var a in uniqueData) {
  //     GraphVegetationManagementDashboard temp =
  //         GraphVegetationManagementDashboard();
  //     for (var b in yourDataList) {
  //       if (a.subStationName == b.subStationName && a.feeder == b.feeder) {
  //         if (b.type1 == 'SPRAY') {
  //           temp.substation = a.subStationName;
  //           temp.feeder = a.feeder;
  //           temp.spray = b.growthPercentage;
  //         }
  //         if (b.type1 == 'JARAFF,MOWING,SPRAY WORK') {
  //           temp.substation = a.subStationName;
  //           temp.feeder = a.feeder;
  //           temp.jaraffMowingSprayWork = b.growthPercentage;
  //         }
  //         if (b.type1 == 'MOWING,NO SPRAY') {
  //           temp.substation = a.subStationName;
  //           temp.feeder = a.feeder;
  //           temp.mowingNoSpray = b.growthPercentage;
  //         }
  //         if (b.type1 == 'GROUND WORK') {
  //           temp.substation = a.subStationName;
  //           temp.feeder = a.feeder;
  //           temp.groundWork = b.growthPercentage;
  //         }
  //         if (b.type1 == 'MOWING') {
  //           temp.substation = a.subStationName;
  //           temp.feeder = a.feeder;
  //           temp.mowing = b.growthPercentage;
  //         }
  //         if (b.type1 == 'BUCKET WORK') {
  //           temp.substation = a.subStationName;
  //           temp.feeder = a.feeder;
  //           temp.bucketWork = b.growthPercentage;
  //         }
  //         if (b.type1 == 'JARAFF,MOWING,NO SPRAY') {
  //           temp.substation = a.subStationName;
  //           temp.feeder = a.feeder;
  //           temp.jaraffMowingNoSpray = b.growthPercentage;
  //         }
  //       }
  //     }
  //     setState(() {
  //       dataset.add(temp);
  //     });
  //   }
  //   uniqueDataCount = uniqueData.length;
  // }

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
                        child: const Text(
                          "Yes",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red.shade800,
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          print('no selected');
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          "No",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future openFilter() => showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          state = setState;
          Size size = MediaQuery.of(context).size;
          return AlertDialog(
            content: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 10,
                            bottom: 2,
                            left: 2,
                            right: 2,
                          ),
                          child: Column(
                            children: [
                              // const Align(
                              //     alignment: Alignment.centerLeft,
                              //     child: Padding(
                              //       padding: EdgeInsets.all(2.0),
                              //       child: Text(
                              //         "SELECT TYPE",
                              //         style: TextStyle(
                              //           fontSize: 16.0,
                              //           color: Color.fromARGB(255, 7, 59, 120),
                              //           fontWeight: FontWeight.bold,
                              //         ),
                              //       ),
                              //     )),
                              // Padding(
                              //   padding:
                              //       const EdgeInsets.only(left: 2.0, right: 2.0),
                              //   child: Align(
                              //     alignment: Alignment.centerLeft,
                              //     child: DropdownButtonFormField<String>(
                              //       hint: const Text('--Select--'),
                              //       dropdownColor: Colors.white,
                              //       value: type,
                              //       style: const TextStyle(
                              //         color: Color.fromARGB(255, 7, 59, 120),
                              //         fontSize: 16,
                              //       ),
                              //       icon: const Icon(
                              //         Icons.arrow_drop_down,
                              //         color: Color.fromARGB(255, 7, 59, 120),
                              //         size: 40,
                              //       ),
                              //       decoration: const InputDecoration(
                              //         enabledBorder: OutlineInputBorder(
                              //           borderSide: BorderSide(
                              //             color: Color.fromARGB(255, 7, 59, 120),
                              //           ),
                              //         ),
                              //         focusedBorder: OutlineInputBorder(
                              //           borderSide: BorderSide(
                              //             color: Color.fromARGB(255, 7, 59, 120),
                              //           ),
                              //         ),
                              //       ),
                              //       isExpanded: true,
                              //       items: select_type.map(buildMenuItem).toList(),
                              //       onChanged: (value) {
                              //         setState(() {
                              //           type = value;
                              //         });
                              //         if (type == 'Daily') {
                              //           _isVisibleDaily = true;
                              //           _isVisibleMonthly = false;
                              //         } else if (type == 'Monthly') {
                              //           _isVisibleDaily = false;
                              //           _isVisibleMonthly = true;
                              //         }
                              //       },
                              //       validator: (value) =>
                              //           value == null ? 'field required' : null,
                              //     ),
                              //   ),
                              // ),
                              Visibility(
                                visible: _isVisibleMonthly,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        top: 10,
                                        bottom: 2,
                                        left: 2,
                                        right: 2,
                                      ),
                                      child: Column(
                                        children: [
                                          const Align(
                                            alignment: Alignment.centerLeft,
                                            child: Padding(
                                              padding: EdgeInsets.all(2.0),
                                              child: Text(
                                                "YEAR",
                                                style: TextStyle(
                                                  fontSize: 16.0,
                                                  color: Color.fromARGB(
                                                    255,
                                                    7,
                                                    59,
                                                    120,
                                                  ),
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Padding(
                                              padding: const EdgeInsets.all(
                                                2.0,
                                              ),
                                              child: DropdownButtonFormField<String>(
                                                hint: const Text('-Select-'),
                                                dropdownColor: Colors.white,
                                                value: year,
                                                // =
                                                //     currentYear.toString(),
                                                style: const TextStyle(
                                                  color: Color.fromARGB(
                                                    255,
                                                    7,
                                                    59,
                                                    120,
                                                  ),
                                                  fontSize: 16,
                                                ),
                                                icon: const Icon(
                                                  Icons.arrow_drop_down,
                                                  color: Color.fromARGB(
                                                    255,
                                                    7,
                                                    59,
                                                    120,
                                                  ),
                                                  size: 40,
                                                ),
                                                decoration: const InputDecoration(
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Color.fromARGB(
                                                            255,
                                                            7,
                                                            59,
                                                            120,
                                                          ),
                                                        ),
                                                      ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Color.fromARGB(
                                                            255,
                                                            7,
                                                            59,
                                                            120,
                                                          ),
                                                        ),
                                                      ),
                                                ),
                                                isExpanded: true,
                                                items: select_year
                                                    .map(buildMenuItem)
                                                    .toList(),
                                                onChanged: (String? newValue) {
                                                  setState(() {
                                                    year = newValue;
                                                  });
                                                  dynamicYear = year.toString();
                                                  if (selectedMonth != null ||
                                                      selectedSubstation !=
                                                          null) {
                                                    selectedMonth = null;
                                                    selectedSubstation = null;
                                                  }
                                                  loadingFlag = 0;
                                                  vegetationManagementDashboardViewModel
                                                      .fetchVegetationManagementDashboardListApi(
                                                        context,
                                                        'TYPE',
                                                        bSpray,
                                                        aMowing,
                                                        cMowingNoSpray,
                                                        dJaraffMowingSprayWork,
                                                        eGroundWork,
                                                        fJaraffMowingNoSpray,
                                                        gBucketWork,
                                                        '',
                                                        dynamicYear,
                                                        '',
                                                        '',
                                                        '',
                                                        selectedYear.toString(),
                                                      )
                                                      .then((value) async {
                                                        Navigator.pop(context);
                                                        //   await Future.delayed(
                                                        //       const Duration(seconds: 3));
                                                        //   fetchDataFromApiForGlobalFilters(
                                                        //       'TYPE',
                                                        //       bSpray,
                                                        //       aMowing,
                                                        //       cMowingNoSpray,
                                                        //       dJaraffMowingSprayWork,
                                                        //       eGroundWork,
                                                        //       fJaraffMowingNoSpray,
                                                        //       gBucketWork,
                                                        //       '',
                                                        //       dynamicYear,
                                                        //       '',
                                                        //       '',
                                                        //       '');
                                                      });
                                                },
                                                validator: (value) =>
                                                    value == null
                                                    ? 'Field required'
                                                    : null,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        top: 10,
                                        bottom: 2,
                                        left: 2,
                                        right: 2,
                                      ),
                                      child: Column(
                                        children: [
                                          const Align(
                                            alignment: Alignment.centerLeft,
                                            child: Padding(
                                              padding: EdgeInsets.all(2.0),
                                              child: Text(
                                                "MONTH",
                                                style: TextStyle(
                                                  fontSize: 16.0,
                                                  color: Color.fromARGB(
                                                    255,
                                                    7,
                                                    59,
                                                    120,
                                                  ),
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Padding(
                                              padding: const EdgeInsets.all(
                                                2.0,
                                              ),
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 12,
                                                      vertical: 4,
                                                    ),
                                                width: size.width * 0.9,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: const Color.fromARGB(
                                                      255,
                                                      7,
                                                      59,
                                                      120,
                                                    ),
                                                  ),
                                                ),
                                                child: MultiSelectDialogField(
                                                  items: vegetationManagementDashboardViewModel
                                                      .vegetationManagementDashboardList
                                                      .data!
                                                      .monthList!
                                                      .map(
                                                        (e) => MultiSelectItem(
                                                          e.month.toString(),
                                                          e.month.toString(),
                                                        ),
                                                      )
                                                      .toList(),
                                                  initialValue:
                                                      (selectedMonth == null ||
                                                          selectedMonth
                                                              .toString()
                                                              .isEmpty)
                                                      ? []
                                                      : selectedMonth!.split(
                                                          ',',
                                                        ),
                                                  buttonIcon: const Icon(
                                                    Icons.arrow_drop_down,
                                                    color: Color.fromARGB(
                                                      255,
                                                      7,
                                                      59,
                                                      120,
                                                    ),
                                                    size: 40,
                                                  ),
                                                  listType:
                                                      MultiSelectListType.CHIP,
                                                  onConfirm: (value) {
                                                    selectedMonth = value.join(
                                                      ',',
                                                    );

                                                    monthNo = '';

                                                    List<String> monthNumbers =
                                                        value.map((month) {
                                                          switch (month) {
                                                            case 'January':
                                                              return '1';
                                                            case 'February':
                                                              return '2';
                                                            case 'March':
                                                              return '3';
                                                            case 'April':
                                                              return '4';
                                                            case 'May':
                                                              return '5';
                                                            case 'June':
                                                              return '6';
                                                            case 'July':
                                                              return '7';
                                                            case 'August':
                                                              return '8';
                                                            case 'September':
                                                              return '9';
                                                            case 'October':
                                                              return '10';
                                                            case 'November':
                                                              return '11';
                                                            case 'December':
                                                              return '12';
                                                            default:
                                                              return '';
                                                          }
                                                        }).toList();
                                                    monthNo = monthNumbers.join(
                                                      ',',
                                                    );

                                                    print(
                                                      'monthNo11111 $monthNo',
                                                    );
                                                    if (selectedSubstation !=
                                                        null) {
                                                      selectedSubstation = null;
                                                    }
                                                    loadingFlag = 0;
                                                    vegetationManagementDashboardViewModel
                                                        .fetchVegetationManagementDashboardListApi(
                                                          context,
                                                          'TYPE',
                                                          bSpray,
                                                          aMowing,
                                                          cMowingNoSpray,
                                                          dJaraffMowingSprayWork,
                                                          eGroundWork,
                                                          fJaraffMowingNoSpray,
                                                          gBucketWork,
                                                          '',
                                                          dynamicYear,
                                                          monthNo,
                                                          '',
                                                          '',
                                                          selectedYear
                                                              .toString(),
                                                        )
                                                        .then((value) async {
                                                          Navigator.pop(
                                                            context,
                                                          );
                                                          // await Future.delayed(
                                                          //     const Duration(
                                                          //         seconds: 3));

                                                          // fetchDataFromApiForGlobalFilters(
                                                          //     'TYPE',
                                                          //     bSpray,
                                                          //     aMowing,
                                                          //     cMowingNoSpray,
                                                          //     dJaraffMowingSprayWork,
                                                          //     eGroundWork,
                                                          //     fJaraffMowingNoSpray,
                                                          //     gBucketWork,
                                                          //     '',
                                                          //     dynamicYear,
                                                          //     monthNo,
                                                          //     '',
                                                          //     '');
                                                        });
                                                    (value) => value == null
                                                        ? 'field required'
                                                        : null;
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          left: 2.0,
                                          right: 2.0,
                                          top: 10.0,
                                          bottom: 8,
                                        ),
                                        child: Text(
                                          "SUBSTATION",
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            color: Color.fromARGB(
                                              255,
                                              7,
                                              59,
                                              120,
                                            ),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 12,
                                            vertical: 4,
                                          ),
                                          width: size.width * 0.9,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: const Color.fromARGB(
                                                255,
                                                7,
                                                59,
                                                120,
                                              ),
                                            ),
                                          ),
                                          child: MultiSelectDialogField(
                                            items: vegetationManagementDashboardViewModel
                                                .vegetationManagementDashboardList
                                                .data!
                                                .substationList!
                                                .map(
                                                  (e) => MultiSelectItem(
                                                    e.substationName.toString(),
                                                    e.substationName.toString(),
                                                  ),
                                                )
                                                .toList(),
                                            initialValue:
                                                (selectedSubstation == null ||
                                                    selectedSubstation
                                                        .toString()
                                                        .isEmpty)
                                                ? []
                                                : selectedSubstation!.split(
                                                    ',',
                                                  ),
                                            buttonIcon: const Icon(
                                              Icons.arrow_drop_down,
                                              color: Color.fromARGB(
                                                255,
                                                7,
                                                59,
                                                120,
                                              ),
                                              size: 40,
                                            ),
                                            listType: MultiSelectListType.CHIP,
                                            onConfirm: (value) {
                                              selectedSubstation = value.join(
                                                ',',
                                              );
                                              print(
                                                'selectedSubstation111 $selectedSubstation',
                                              );
                                              loadingFlag = 0;
                                              vegetationManagementDashboardViewModel
                                                  .fetchVegetationManagementDashboardListApi(
                                                    context,
                                                    'TYPE',
                                                    bSpray,
                                                    aMowing,
                                                    cMowingNoSpray,
                                                    dJaraffMowingSprayWork,
                                                    eGroundWork,
                                                    fJaraffMowingNoSpray,
                                                    gBucketWork,
                                                    selectedSubstation
                                                        .toString(),
                                                    dynamicYear,
                                                    monthNo,
                                                    '',
                                                    '',
                                                    selectedYear.toString(),
                                                  )
                                                  .then((value) async {
                                                    Navigator.pop(context);
                                                    //   await Future.delayed(
                                                    //       const Duration(seconds: 3));
                                                    //   fetchDataFromApiForGlobalFilters(
                                                    //       'TYPE',
                                                    //       bSpray,
                                                    //       aMowing,
                                                    //       cMowingNoSpray,
                                                    //       dJaraffMowingSprayWork,
                                                    //       eGroundWork,
                                                    //       fJaraffMowingNoSpray,
                                                    //       gBucketWork,
                                                    //       selectedSubstation.toString(),
                                                    //       dynamicYear,
                                                    //       monthNo,
                                                    //       '',
                                                    //       '');
                                                  });
                                              (value) => value == null
                                                  ? 'field required'
                                                  : null;
                                            },
                                          ),
                                        ),
                                        // DropdownButtonFormField<String>(
                                        //   hint: const Text('-Select-'),
                                        //   dropdownColor: Colors.white,
                                        //   value: selectedSubstation,
                                        //   style: const TextStyle(
                                        //       color:
                                        //           Color.fromARGB(255, 7, 59, 120),
                                        //       fontSize: 16),
                                        //   icon: const Icon(
                                        //     Icons.arrow_drop_down,
                                        //     color: Color.fromARGB(255, 7, 59, 120),
                                        //     size: 40,
                                        //   ),
                                        //   decoration: const InputDecoration(
                                        //     enabledBorder: OutlineInputBorder(
                                        //       borderSide: BorderSide(
                                        //         color:
                                        //             Color.fromARGB(255, 7, 59, 120),
                                        //       ),
                                        //     ),
                                        //     focusedBorder: OutlineInputBorder(
                                        //       borderSide: BorderSide(
                                        //         color:
                                        //             Color.fromARGB(255, 7, 59, 120),
                                        //       ),
                                        //     ),
                                        //   ),
                                        //   isExpanded: true,
                                        //   items:
                                        //       vegetationManagementDashboardViewModel
                                        //           .vegetationManagementDashboardList
                                        //           .data!
                                        //           .substationList!
                                        //           .map((e) {
                                        //     return DropdownMenuItem(
                                        //       value: e.name.toString(),
                                        //       // e.getIdAndSubstationByCountId![0].subStation.toString(),
                                        //       child: Text(e.name.toString()),
                                        //     );
                                        //   }).toList(),
                                        //   onChanged: (val) {
                                        //     setState(() {
                                        //       selectedSubstation = val;
                                        //     });

                                        //     vegetationManagementDashboardViewModel
                                        //         .fetchVegetationManagementDashboardListApi(
                                        //             context,
                                        //             'TYPE',
                                        //             bSpray,
                                        //             aMowing,
                                        //             cMowingNoSpray,
                                        //             dJaraffMowingSprayWork,
                                        //             eGroundWork,
                                        //             fJaraffMowingNoSpray,
                                        //             gBucketWork,
                                        //             selectedSubstation,
                                        //             dynamicYear,
                                        //             monthNo,
                                        //             '',
                                        //             '')
                                        //         .then((value) async {
                                        //       Navigator.pop(context);
                                        //       await Future.delayed(
                                        //           Duration(seconds: 3));
                                        //       fetchDataFromApiForGlobalFilters(
                                        //           'TYPE',
                                        //           bSpray,
                                        //           aMowing,
                                        //           cMowingNoSpray,
                                        //           dJaraffMowingSprayWork,
                                        //           eGroundWork,
                                        //           fJaraffMowingNoSpray,
                                        //           gBucketWork,
                                        //           selectedSubstation,
                                        //           dynamicYear,
                                        //           monthNo,
                                        //           '',
                                        //           '');
                                        //     });
                                        //   },
                                        //   validator: (value) => value == null
                                        //       ? 'field required'
                                        //       : null,
                                        // ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Visibility(
                                visible: _isVisibleDaily,
                                child: Column(
                                  children: [
                                    const Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          left: 2.0,
                                          right: 2.0,
                                          top: 10.0,
                                        ),
                                        child: Text(
                                          "DATE RANGE",
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            color: Color.fromARGB(
                                              255,
                                              7,
                                              59,
                                              120,
                                            ),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        await selectDateRange(context);
                                        setState(() {
                                          dateSelected1 =
                                              '$startDateSelected - $endDateSelected';
                                        });
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          left: 2,
                                          right: 2,
                                        ),
                                        child: Container(
                                          height: 65,
                                          // width: 240,
                                          // padding: const EdgeInsets.only(left: 14, right: 14),
                                          decoration: BoxDecoration(
                                            // borderRadius: BorderRadius.circular(14),
                                            border: Border.all(
                                              color: const Color.fromARGB(
                                                255,
                                                7,
                                                59,
                                                120,
                                              ),
                                            ),
                                            color: Colors.transparent,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(1.0),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                left: 8.0,
                                              ),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets.only(
                                                                  left: 2,
                                                                ),
                                                            child: Text(
                                                              dateSelected1,
                                                              // '$startDateSelected - $endDateSelected',
                                                              // : 'Select Date Range',
                                                              style: const TextStyle(
                                                                // fontSize: 20,
                                                                color:
                                                                    Color.fromARGB(
                                                                      255,
                                                                      7,
                                                                      59,
                                                                      120,
                                                                    ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets.only(
                                                                top: 2,
                                                              ),
                                                          child: IconButton(
                                                            icon: const Icon(
                                                              Icons
                                                                  .calendar_month,
                                                            ),
                                                            iconSize: 18,
                                                            color:
                                                                const Color.fromARGB(
                                                                  255,
                                                                  7,
                                                                  59,
                                                                  120,
                                                                ),
                                                            onPressed: () async {
                                                              await selectDateRange(
                                                                context,
                                                              );
                                                              setState(() {
                                                                dateSelected1 =
                                                                    '$startDateSelected - $endDateSelected';
                                                                // }
                                                              });
                                                              if (selectedSubstation !=
                                                                  null) {
                                                                selectedSubstation =
                                                                    null;
                                                              }
                                                              loadingFlag = 0;
                                                              vegetationManagementDashboardViewModel
                                                                  .fetchVegetationManagementDashboardListApi(
                                                                    context,
                                                                    'TYPE',
                                                                    bSpray,
                                                                    aMowing,
                                                                    cMowingNoSpray,
                                                                    dJaraffMowingSprayWork,
                                                                    eGroundWork,
                                                                    fJaraffMowingNoSpray,
                                                                    gBucketWork,
                                                                    '',
                                                                    '',
                                                                    '',
                                                                    startDateSelected,
                                                                    endDateSelected,
                                                                    selectedYear
                                                                        .toString(),
                                                                  )
                                                                  .then((
                                                                    value,
                                                                  ) async {
                                                                    Navigator.pop(
                                                                      context,
                                                                    );
                                                                    // await Future.delayed(
                                                                    //     const Duration(
                                                                    //         seconds:
                                                                    //             3));
                                                                    // fetchDataFromApiForGlobalFilters(
                                                                    //     'TYPE',
                                                                    //     bSpray,
                                                                    //     aMowing,
                                                                    //     cMowingNoSpray,
                                                                    //     dJaraffMowingSprayWork,
                                                                    //     eGroundWork,
                                                                    //     fJaraffMowingNoSpray,
                                                                    //     gBucketWork,
                                                                    //     '',
                                                                    //     '',
                                                                    //     '',
                                                                    //     startDateSelected,
                                                                    //     endDateSelected);
                                                                  });
                                                            },
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          left: 2.0,
                                          right: 2.0,
                                          top: 10.0,
                                          bottom: 8,
                                        ),
                                        child: Text(
                                          "SUBSTATION",
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            color: Color.fromARGB(
                                              255,
                                              7,
                                              59,
                                              120,
                                            ),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 12,
                                            vertical: 4,
                                          ),
                                          width: size.width * 0.9,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: const Color.fromARGB(
                                                255,
                                                7,
                                                59,
                                                120,
                                              ),
                                            ),
                                          ),
                                          child: MultiSelectDialogField(
                                            items: vegetationManagementDashboardViewModel
                                                .vegetationManagementDashboardList
                                                .data!
                                                .substationList!
                                                .map(
                                                  (e) => MultiSelectItem(
                                                    e.substationName.toString(),
                                                    e.substationName.toString(),
                                                  ),
                                                )
                                                .toList(),
                                            initialValue:
                                                (selectedSubstation == null ||
                                                    selectedSubstation
                                                        .toString()
                                                        .isEmpty)
                                                ? []
                                                : selectedSubstation!.split(
                                                    ',',
                                                  ),
                                            listType: MultiSelectListType.CHIP,
                                            buttonIcon: const Icon(
                                              Icons.arrow_drop_down,
                                              color: Color.fromARGB(
                                                255,
                                                7,
                                                59,
                                                120,
                                              ),
                                              size: 40,
                                            ),
                                            onConfirm: (value) {
                                              selectedSubstation = value.join(
                                                ',',
                                              );
                                              print(
                                                'selectedSubstation $selectedSubstation',
                                              );
                                              loadingFlag = 0;
                                              vegetationManagementDashboardViewModel
                                                  .fetchVegetationManagementDashboardListApi(
                                                    context,
                                                    'TYPE',
                                                    bSpray,
                                                    aMowing,
                                                    cMowingNoSpray,
                                                    dJaraffMowingSprayWork,
                                                    eGroundWork,
                                                    fJaraffMowingNoSpray,
                                                    gBucketWork,
                                                    selectedSubstation
                                                        .toString(),
                                                    '',
                                                    '',
                                                    startDateSelected,
                                                    endDateSelected,
                                                    selectedYear.toString(),
                                                  )
                                                  .then((value) async {
                                                    Navigator.pop(context);
                                                    // await Future.delayed(
                                                    //     const Duration(seconds: 3));
                                                    // fetchDataFromApiForGlobalFilters(
                                                    //     'TYPE',
                                                    //     bSpray,
                                                    //     aMowing,
                                                    //     cMowingNoSpray,
                                                    //     dJaraffMowingSprayWork,
                                                    //     eGroundWork,
                                                    //     fJaraffMowingNoSpray,
                                                    //     gBucketWork,
                                                    //     selectedSubstation.toString(),
                                                    //     '',
                                                    //     '',
                                                    //     startDateSelected,
                                                    //     endDateSelected);
                                                  });
                                              (value) => value == null
                                                  ? 'field required'
                                                  : null;
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
    value: item,
    child: Text(
      item,
      style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 20),
    ),
  );

  static List<String> generateYearList() {
    DateTime now = DateTime.now();
    int currentYear = now.year;
    List<String> years = [];
    for (int i = currentYear - 4; i <= currentYear + 0; i++) {
      years.add(i.toString());
    }
    return years;
  }

  void showYearFilterDialog() {
    final String currentYear = DateTime.now().year.toString();

    if (selectedYear == null || !years.contains(selectedYear)) {
      selectedYear = years.contains(currentYear) ? currentYear : null;
    }
    String? tempSelectedYear = selectedYear;
    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (dialogContext, setDialogState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),

              title: const Text(
                "Filter",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),

              content: DropdownButtonFormField<String>(
                value: years.contains(tempSelectedYear)
                    ? tempSelectedYear
                    : null,

                isExpanded: true,

                decoration: InputDecoration(
                  labelText: "Select Year",
                  prefixIcon: const Icon(Icons.calendar_today_rounded),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 14,
                  ),
                ),

                items: years.map((year) {
                  return DropdownMenuItem<String>(
                    value: year,
                    child: Text(year),
                  );
                }).toList(),

                onChanged: (value) {
                  setDialogState(() {
                    tempSelectedYear = value;
                  });
                },
              ),

              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(dialogContext);
                  },
                  child: const Text("Cancel"),
                ),

                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectedYear = tempSelectedYear;
                    });

                    Navigator.pop(dialogContext);

                    print("Selected Year: $selectedYear");
                    vegetationManagementDashboardViewModel
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
                          '',
                          '',
                          '',
                          selectedYear.toString(),
                        );
                  },
                  child: const Text("Search"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> checkCurrentUser() async {
    print('planner authentication');

    try {
      final prefs = await SharedPreferences.getInstance();

      final fcmToken = prefs.getString('device_token_for_logOut');

      if (fcmToken == null || fcmToken.isEmpty) {
        print("FCM token not found in SharedPreferences");
        return;
      }
      final userPreferences1 = Provider.of<UserPref>(context, listen: false);

      UserModel data = await userPreferences1.getUser();

      final String id = data.user!.id.toString();

      final apiUrl =
          "${AppUrl.baseUrl}login_user/checkCurrentUser"
          "?fcmToken=${Uri.encodeQueryComponent(fcmToken)}"
          "&userId=${Uri.encodeQueryComponent(id)}";

      final url = Uri.parse(apiUrl);

      print("API URL for authentication: $url");
      print("Bearer Token: ${data.token}");

      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer ${data.token!}',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      print("Status Code: ${response.statusCode}");
      print("Response: ${response.body}");

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        print("Current User Response: $responseData");

        if (responseData == false) {
          final userPreferences = Provider.of<UserPref>(context, listen: false);

          await userPreferences.remove();

          if (!mounted) return;

          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (BuildContext context) => const LoginPage(),
            ),
            (route) => false,
          );
        }
      } else if (response.statusCode == 401) {
        print("Unauthorized - Bearer token is invalid or expired");
      } else {
        print(
          "checkCurrentUser failed: "
          "${response.statusCode} - ${response.body}",
        );
      }
    } catch (e) {
      print("checkCurrentUser Error: $e");
    }
  }

  Future<void> _initializeScreen() async {
    await Future.delayed(const Duration(seconds: 10));

    if (!mounted) return;

    await checkCurrentUser();
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

  @override
  void initState() {
    setUserName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    var provider = Provider.of<LocationProvider>(context, listen: true);
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
                  menuLogoLCP(),
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
                    leading: const Icon(Icons.computer),
                    title: const Text('Dashboard'),
                    textColor: const Color.fromARGB(255, 7, 59, 120),
                    iconColor: const Color.fromARGB(255, 7, 59, 120),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.change_circle),
                    title: const Text('Inspection'),
                    textColor: const Color.fromARGB(255, 7, 59, 120),
                    iconColor: const Color.fromARGB(255, 7, 59, 120),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              SupervisorInspectionZielies(year: ''),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.pending),
                    title: const Text('Change Order Job List'),
                    textColor: const Color.fromARGB(255, 7, 59, 120),
                    iconColor: const Color.fromARGB(255, 7, 59, 120),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              SupChangeOrderAllStatus(source: '', year: ''),
                        ),
                      );
                      // Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (BuildContext context) =>
                      //         const ChangeOrderNewInDrawer()));
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.rowing),
                    title: const Text('IVM Maintenance Job List'),
                    textColor: const Color.fromARGB(255, 7, 59, 120),
                    iconColor: const Color.fromARGB(255, 7, 59, 120),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              SupervisorAddNewRowTable(
                                index: '0',
                                budgetType: "",
                                year: '',
                              ),
                        ),
                      );
                    },
                  ),

                  ListTile(
                    leading: const Icon(Icons.inventory),
                    title: const Text('IVM Maintenance Progress'),
                    textColor: const Color.fromARGB(255, 7, 59, 120),
                    iconColor: const Color.fromARGB(255, 7, 59, 120),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const SupervisorRowMaintenanceProgress(),
                        ),
                      );
                    },
                  ),

                  ListTile(
                    leading: const Icon(Icons.location_on),
                    title: const Text('Live IVM System Map'),
                    textColor: const Color.fromARGB(255, 7, 59, 120),
                    iconColor: const Color.fromARGB(255, 7, 59, 120),
                    onTap: () {
                      provider.getLocation();
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const MapScreenLeafLat(),
                        ),
                      );
                    },
                  ),

                  ListTile(
                    leading: const Icon(Icons.group_add),
                    title: const Text('User Management'),
                    textColor: const Color.fromARGB(255, 7, 59, 120),
                    iconColor: const Color.fromARGB(255, 7, 59, 120),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const SupervisorUserManagementTabs(),
                        ),
                      );
                    },
                  ),

                  ListTile(
                    leading: const Icon(Icons.logout),
                    title: const Text('Log Out'),
                    textColor: const Color.fromARGB(255, 7, 59, 120),
                    iconColor: const Color.fromARGB(255, 7, 59, 120),
                    onTap: () {
                      // // Constants.prefs.setBool("LoggedIn", false);
                      // Navigator.of(context).pushReplacement(MaterialPageRoute(
                      //     builder: (BuildContext context) => const LoginPage()));

                      userPreferences.remove().then((value) {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const LoginPage(),
                          ),
                        );
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
    setState(() {
      userName = '${data.user!.fName} ${data.user!.lName}';
    });
  }
}

// ignore: must_be_immutable
class DashboardCard extends StatefulWidget {
  String cardTitle;
  String cardCount;
  dynamic cardIcon;
  Color? iconColor;
  Color? cardColor;

  DashboardCard({
    Key? key,
    required this.cardTitle,
    required this.cardCount,
    this.cardIcon,
    this.iconColor,
    this.cardColor,
  }) : super(key: key);

  @override
  State<DashboardCard> createState() => _DashboardCardState();
}

class _DashboardCardState extends State<DashboardCard> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(top: 10),
      //  padding: const EdgeInsets.only(top: 4, bottom: 4, left: 8, right: 8),
      alignment: Alignment.center,
      width: size.width * 0.425,
      height: MediaQuery.of(context).size.height * 0.10,
      decoration: BoxDecoration(
        color: widget.cardColor,
        // shape: BoxShape.circle,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black,
            blurRadius: 5,
            offset: Offset(0.0, 2.0),
          ),
        ],
        // gradient:  LinearGradient(
        //   colors: [
        //      cardColor,
        //      cardColor
        //     //  Color.fromARGB(255, 255, 255, 255),
        //     //  Color.fromARGB(255, 255, 255, 255),
        //   ],
        // )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            widget.cardTitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            widget.cardCount,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         appBar: AppBar(title: const Text("Google Maps Sample")),
//         body: Center(child: EntryToMap()),
//       ),
//     );
//   }
// }

class YourData {
  final String feeder;
  final String subStationName;

  YourData(this.feeder, this.subStationName);

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
