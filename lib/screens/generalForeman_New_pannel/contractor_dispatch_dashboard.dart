import 'dart:convert';
import 'dart:io';
import 'package:CIVM/data/response/status.dart';
import 'package:CIVM/models/contractor_dispatcher_dashboard_model.dart';
import 'package:CIVM/models/user_details.dart';
import 'package:CIVM/models/user_model.dart';
import 'package:CIVM/resources/app_url.dart';
import 'package:CIVM/screens/generalForeman_New_pannel/gf_change_order_all_status.dart';
import 'package:CIVM/screens/generalForeman_New_pannel/gf_ivm_all_status.dart';
import 'package:CIVM/screens/planner_pannel.dart/planner_bottom_navigation.dart';
import 'package:CIVM/utils/common_functions.dart';
import 'package:CIVM/screens/admin_pannel/row_maintenance_view/pdf_view.dart';
import 'package:CIVM/screens/generalForeman_New_pannel/gf_add_crew_member.dart';
import 'package:CIVM/screens/generalForeman_New_pannel/inspection.dart';
import 'package:CIVM/screens/leaflat_map/leaf_lat_map_wakeLock.dart';
import 'package:CIVM/screens/map/provider/location_provider.dart';
import 'package:CIVM/screens/video_folder/fullVideo/full_screen_video_player.dart';
import 'package:CIVM/sharedPrefs/constants.dart';
import 'package:http/http.dart' as http;
// import 'package:CIVM/screens/generalForeman_New_pannel/create_invoice_contractor.dart';
import 'package:CIVM/screens/generalForeman_New_pannel/gf_maintenance_report_view_new.dart';
// import 'package:CIVM/screens/generalForeman_New_pannel/invoice_form_contractor.dart';
// import 'package:CIVM/screens/generalForeman_New_pannel/invoice_list_contractor.dart';
import 'package:CIVM/utils/custom_toast_snackbar_progressdialog.dart';
import 'package:CIVM/utils/user_pref.dart';
import 'package:CIVM/view_model/contractor_dispatch_dashboard_view_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../login_page.dart';
import 'package:CIVM/screens/my_chrome_safari_map_recording.dart';

// ignore: must_be_immutable
class ContractorDispatchDashboard extends StatefulWidget {
  const ContractorDispatchDashboard({Key? key}) : super(key: key);

  @override
  State<ContractorDispatchDashboard> createState() =>
      _ContractorDispatchDashboardState();
}

class _ContractorDispatchDashboardState
    extends State<ContractorDispatchDashboard> {
  var result = [];
  List<String> menu = [];
  List<_ChartDataSimpleColumnChart1> chartDataSimpleColumnChart1 = [];
  final TextEditingController _input = TextEditingController();

  late TooltipBehavior _tooltipBehavior;
  // late TooltipBehavior _tooltip1;
  // TooltipBehavior _tooltipBehavior = TooltipBehavior(enable: true);
  ContractorDispatcherDashboardViewModel
  contractorDispatcherDashboardViewModel =
      ContractorDispatcherDashboardViewModel();

  String formattedContractYear = '';
  String contractorId = "";
  Map<String, List<ChartDataNew>> chartDataMap = {}; // Stores all category data
  List<String> categories = []; // Stores dynamic category names
  Set<String> uniqueMonths = {}; // Stores unique months for sorting
  List<String> sortedMonths = []; // Stores sorted months
  /// Predefined colors for categories
  final Map<String, Color> categoryColors = {
    "JARRAFF": const Color.fromARGB(255, 96, 0, 113),
    "MOWING": const Color.fromARGB(255, 113, 68, 1),
    "MINI JARRAFF": const Color.fromARGB(255, 247, 19, 2),
    "BYL": const Color.fromARGB(255, 2, 212, 249),
    "BUCKET": Colors.orange,
    "GROUND": Colors.yellow,
    "CROSS-COUNTRY SPRAY": const Color.fromARGB(255, 38, 1, 247),
    "ROADSIDE SPRAY": const Color.fromARGB(255, 1, 127, 5),
    "NO SPRAY": const Color.fromARGB(255, 252, 199, 249),
  };

  String userTypeText = '';
  String primaryRoleText = '';

  List<FindSmMaintTestResultRequestDatas> allData = [];
  List<FindSmMaintTestResultRequestDatas> filteredList = [];

  List<String> years = ["2021", "2022", "2023", "2024", "2025", "2026", "2027"];
  String? selectedYear;
  var selectedYearCurrent;
  int currentYear = DateTime.now().year;
  List<VegetationChartData> vegetationChartData = [];

  @override
  void initState() {
    selectedYear = selectedYearCurrent = currentYear.toString();
    getInitData(selectedYearCurrent);
    getUserType();
    super.initState();
    _initializeScreen();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // ignore: deprecated_member_use
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) {
          return;
        }
        showExitPopup(context);
      },
      child: Scaffold(
        // appBar: AppBar(
        //   title: const Text('Contractor / Dispatch Dashboard',
        // style: TextStyle(color: Colors.white),),
        //   backgroundColor: const Color.fromARGB(255, 7, 59, 120),
        //   actions: const <Widget>[],
        // ),
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text(
            'General Foreman Dashboard',
            style: TextStyle(color: Colors.white),
          ),
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
        body: ChangeNotifierProvider<ContractorDispatcherDashboardViewModel>(
          create: (BuildContext context) =>
              contractorDispatcherDashboardViewModel,
          child: Consumer<ContractorDispatcherDashboardViewModel>(
            builder: (context, value, _) {
              switch (value
                  .contractorDispatcherDashboardGetTabularData
                  .status) {
                case Status.LOADING:
                  return const Center(child: CircularProgressIndicator());
                case Status.ERROR:
                  return
                  //  CustomToastSnackBarProgressDialog
                  //     .flushBarErrorMessage(
                  //         value.contractorDispatcherDashboardGetTabularData
                  //             .message
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
                  if (allData.isEmpty) {
                    allData = List.from(
                      value
                          .contractorDispatcherDashboardGetTabularData
                          .data!
                          .findSmMaintTestResultRequestDatas!,
                    );

                    filteredList = List.from(allData);
                  }

                  final List<GroupedVegetationData> groupedChartData = [];

                  for (int i = 0; i < sortedMonths.length; i++) {
                    final String month = sortedMonths[i];

                    final List<VegetationChartData> monthData =
                        vegetationChartData
                            .where((data) => data.month == month)
                            .toList();

                    // Add all maintenance types belonging to this month
                    for (final data in monthData) {
                      groupedChartData.add(
                        GroupedVegetationData(
                          month: data.month,
                          category: data.category,
                          miles: data.miles,
                        ),
                      );
                    }

                    // Add ONE transparent position between months
                    if (i < sortedMonths.length - 1) {
                      groupedChartData.add(
                        GroupedVegetationData(
                          month: '',
                          category: '',
                          miles: 0,
                          isSpacer: true,
                        ),
                      );
                    }
                  }
                  return RefreshIndicator(
                    onRefresh: () async {
                      _input.clear();
                      allData.clear();
                      filteredList.clear();
                      await getInitData(selectedYear.toString());
                      _initializeScreen();
                    },
                    child: SingleChildScrollView(
                      child: Center(
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
                                  (primaryRoleText != userTypeText)
                                      ? Padding(
                                          padding: EdgeInsets.only(top: 2.0),
                                          child: Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "$primaryRoleText, acting as $userTypeText.",
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                color: Colors.red,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                        )
                                      : Container(),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Container(
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
                                            color: Color.fromARGB(
                                              255,
                                              3,
                                              47,
                                              97,
                                            ),
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
                                              "Vegetation Management Progress",
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
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (BuildContext context) =>
                                                    GfMaintenanceReportViewNew(
                                                      year: selectedYear
                                                          .toString(),
                                                    ),
                                              ),
                                            );
                                          },
                                          child: DashboardCard(
                                            cardIcon:
                                                'assets/Orders_Pending.png',
                                            iconColor: Colors.red,
                                            cardColor: const Color.fromRGBO(
                                              79,
                                              130,
                                              156,
                                              1,
                                            ),
                                            cardTitle: 'IVM Inspection Pending',
                                            cardCount: contractorDispatcherDashboardViewModel
                                                .contractorDispatcherDashboardGetTabularData
                                                .data!
                                                .iVMAndHerbicideInspectionPending
                                                .toString(),
                                            // "${(contractorDispatcherDashboardViewModel.contractorDispatcherDashboardGetTabularData.data!.regularIVMPendingApproval ?? 0) + (contractorDispatcherDashboardViewModel.contractorDispatcherDashboardGetTabularData.data!.midCyclePendingApproval ?? 0)}"
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        InkWell(
                                          onTap: () {
                                            // Navigator.of(context).push(MaterialPageRoute(
                                            //     builder: (BuildContext
                                            //             context) =>
                                            //         TotalOrderPendingContractor(
                                            //             budgetType:
                                            //                 "Regular IVM maintenance",
                                            //             maintenanceType:
                                            //                 "RegularMaint",
                                            //             heading:
                                            //                 'Total Order Pending (IVM Maintenance)')));
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder:
                                                    (
                                                      BuildContext context,
                                                    ) => GFIvmAllStatus(
                                                      budgetType:
                                                          'Regular IVM maintenance',
                                                      maintenanceType:
                                                          'RegularMaint',
                                                      heading:
                                                          'IVM Maintenance',
                                                      year: selectedYear
                                                          .toString(),
                                                    ),
                                              ),
                                            );
                                          },
                                          child: DashboardCard(
                                            cardIcon:
                                                'assets/Orders_Pending.png',
                                            iconColor: Colors.red,
                                            cardColor: const Color.fromRGBO(
                                              75,
                                              58,
                                              105,
                                              1,
                                            ),
                                            cardTitle: 'IVM Pending',
                                            cardCount:
                                                (contractorDispatcherDashboardViewModel
                                                            .contractorDispatcherDashboardGetTabularData
                                                            .data!
                                                            .regularIVMPending ==
                                                        null ||
                                                    contractorDispatcherDashboardViewModel
                                                            .contractorDispatcherDashboardGetTabularData
                                                            .data!
                                                            .regularIVMPending
                                                            .toString() ==
                                                        'null')
                                                ? ''
                                                : contractorDispatcherDashboardViewModel
                                                      .contractorDispatcherDashboardGetTabularData
                                                      .data!
                                                      .regularIVMPending
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
                                                builder:
                                                    (
                                                      BuildContext context,
                                                    ) => GFIvmAllStatus(
                                                      budgetType:
                                                          'Regular IVM maintenance',
                                                      maintenanceType:
                                                          'RegularMaint',
                                                      heading:
                                                          'IVM Maintenance',
                                                      year: selectedYear
                                                          .toString(),
                                                    ),
                                              ),
                                            );
                                          },
                                          child: DashboardCard(
                                            cardIcon: 'assets/Orders_Open.png',
                                            iconColor: Colors.green,
                                            cardColor: const Color.fromRGBO(
                                              127,
                                              71,
                                              45,
                                              1,
                                            ),
                                            cardTitle: 'IVM Completed',
                                            cardCount:
                                                (contractorDispatcherDashboardViewModel
                                                            .contractorDispatcherDashboardGetTabularData
                                                            .data!
                                                            .regularIVMCompleted ==
                                                        null ||
                                                    contractorDispatcherDashboardViewModel
                                                            .contractorDispatcherDashboardGetTabularData
                                                            .data!
                                                            .regularIVMCompleted
                                                            .toString() ==
                                                        'null')
                                                ? ''
                                                : contractorDispatcherDashboardViewModel
                                                      .contractorDispatcherDashboardGetTabularData
                                                      .data!
                                                      .regularIVMCompleted
                                                      .toString(),
                                          ),
                                        ),
                                        const SizedBox(width: 10),

                                        InkWell(
                                          onTap: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        GfChangeOrderAllStatus(
                                                          year: selectedYear
                                                              .toString(),
                                                        ),
                                              ),
                                            );
                                          },
                                          child: DashboardCard(
                                            cardIcon:
                                                'assets/Orders_Pending.png',
                                            iconColor: Colors.red,
                                            cardColor: Colors.teal,
                                            cardTitle: 'Change Order',
                                            cardCount:
                                                (contractorDispatcherDashboardViewModel
                                                            .contractorDispatcherDashboardGetTabularData
                                                            .data!
                                                            .countChangeOrders ==
                                                        null ||
                                                    contractorDispatcherDashboardViewModel
                                                            .contractorDispatcherDashboardGetTabularData
                                                            .data!
                                                            .countChangeOrders
                                                            .toString() ==
                                                        'null')
                                                ? ''
                                                : contractorDispatcherDashboardViewModel
                                                      .contractorDispatcherDashboardGetTabularData
                                                      .data!
                                                      .countChangeOrders
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
                              height: size.height * 0.6,
                              width: size.width * 0.99,
                              decoration: BoxDecoration(
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
                                  // ============================================================
                                  // CHART TITLE
                                  // ============================================================
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 4.0),
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      alignment: Alignment.center,
                                      width: size.width * 0.99,
                                      decoration: const BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Color.fromARGB(
                                              255,
                                              3,
                                              47,
                                              97,
                                            ),
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
                                              "Vegetation Management Chart",
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
                                  ),

                                  Expanded(
                                    child: LayoutBuilder(
                                      builder:
                                          (
                                            BuildContext context,
                                            BoxConstraints constraints,
                                          ) {
                                            // Width of each position/bar
                                            const double barWidth = 55.0;

                                            // Total width including spacer positions
                                            final double chartWidth =
                                                (groupedChartData.length * 70.0)
                                                    .clamp(
                                                      constraints.maxWidth,
                                                      5000.0,
                                                    );

                                            return SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,

                                              child: SizedBox(
                                                width: chartWidth,

                                                child: SfCartesianChart(
                                                  title: ChartTitle(
                                                    text: '',
                                                    textStyle: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  primaryXAxis: CategoryAxis(
                                                    interval: 1,

                                                    title: AxisTitle(
                                                      text: 'MAINTENANCE TYPE',
                                                      textStyle:
                                                          const TextStyle(
                                                            color: Colors.red,
                                                            fontFamily:
                                                                'Roboto',
                                                            fontSize: 14,
                                                            fontStyle: FontStyle
                                                                .italic,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                    ),

                                                    labelRotation: -45,

                                                    edgeLabelPlacement:
                                                        EdgeLabelPlacement
                                                            .shift,

                                                    majorGridLines:
                                                        const MajorGridLines(
                                                          width: 0,
                                                        ),

                                                    axisLabelFormatter:
                                                        (
                                                          AxisLabelRenderDetails
                                                          details,
                                                        ) {
                                                          final int index =
                                                              details.value
                                                                  .toInt();

                                                          if (index >= 0 &&
                                                              index <
                                                                  groupedChartData
                                                                      .length) {
                                                            final GroupedVegetationData
                                                            item =
                                                                groupedChartData[index];

                                                            // Spacer
                                                            if (item.isSpacer) {
                                                              return ChartAxisLabel(
                                                                '',
                                                                const TextStyle(
                                                                  fontSize: 0,
                                                                ),
                                                              );
                                                            }

                                                            // Show every actual maintenance type
                                                            return ChartAxisLabel(
                                                              item.category,
                                                              const TextStyle(
                                                                fontSize: 10,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                            );
                                                          }

                                                          return ChartAxisLabel(
                                                            details.text,
                                                            const TextStyle(
                                                              fontSize: 10,
                                                            ),
                                                          );
                                                        },
                                                  ),

                                                  // ==================================================
                                                  // Y AXIS
                                                  // ==================================================
                                                  primaryYAxis: NumericAxis(
                                                    title: AxisTitle(
                                                      text: 'MILES COMPLETED',
                                                      textStyle:
                                                          const TextStyle(
                                                            color: Colors.red,
                                                            fontFamily:
                                                                'Roboto',
                                                            fontSize: 14,
                                                            fontStyle: FontStyle
                                                                .italic,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                    ),

                                                    minimum: 0,

                                                    majorGridLines:
                                                        const MajorGridLines(
                                                          width: 0.5,
                                                        ),

                                                    numberFormat: NumberFormat(
                                                      '0.00',
                                                    ),
                                                  ),

                                                  // ==================================================
                                                  // LEGEND
                                                  // ==================================================
                                                  legend: const Legend(
                                                    isVisible: false,
                                                  ),

                                                  // ==================================================
                                                  // TOOLTIP
                                                  // ==================================================
                                                  tooltipBehavior: TooltipBehavior(
                                                    enable: true,

                                                    shared: false,

                                                    canShowMarker: true,

                                                    builder:
                                                        (
                                                          dynamic data,
                                                          dynamic point,
                                                          dynamic series,
                                                          int pointIndex,
                                                          int seriesIndex,
                                                        ) {
                                                          final GroupedVegetationData
                                                          chartData =
                                                              data
                                                                  as GroupedVegetationData;

                                                          // Don't show tooltip for spacer
                                                          if (chartData
                                                              .isSpacer) {
                                                            return const SizedBox();
                                                          }

                                                          return Container(
                                                            padding:
                                                                const EdgeInsets.all(
                                                                  10,
                                                                ),

                                                            decoration:
                                                                BoxDecoration(
                                                                  color: Colors
                                                                      .black87,
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                        6,
                                                                      ),
                                                                ),

                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,

                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,

                                                              children: [
                                                                // ==================================================
                                                                // MONTH / YEAR
                                                                // ==================================================
                                                                Text(
                                                                  chartData
                                                                      .month,
                                                                  style: const TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        14,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                ),

                                                                const SizedBox(
                                                                  height: 4,
                                                                ),

                                                                // ==================================================
                                                                // MAINTENANCE TYPE
                                                                // ==================================================
                                                                Text(
                                                                  'Maintenance Type: '
                                                                  '${chartData.category}',
                                                                  style: const TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                ),

                                                                // ==================================================
                                                                // MILES
                                                                // ==================================================
                                                                Text(
                                                                  'Miles: '
                                                                  '${chartData.miles.toStringAsFixed(2)}',
                                                                  style: const TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        },
                                                  ),

                                                  // ==================================================
                                                  // ONE COLUMN SERIES
                                                  // ==================================================
                                                  series: [
                                                    ColumnSeries<
                                                      GroupedVegetationData,
                                                      String
                                                    >(
                                                      name: 'Vegetation',

                                                      dataSource:
                                                          groupedChartData,

                                                      // ==================================================
                                                      // X POSITION
                                                      // ==================================================
                                                      //
                                                      // Every maintenance type gets a unique position.
                                                      //
                                                      xValueMapper:
                                                          (
                                                            GroupedVegetationData
                                                            data,
                                                            int index,
                                                          ) {
                                                            return index
                                                                .toString();
                                                          },

                                                      // ==================================================
                                                      // Y VALUE
                                                      // ==================================================
                                                      yValueMapper:
                                                          (
                                                            GroupedVegetationData
                                                            data,
                                                            _,
                                                          ) {
                                                            if (data.isSpacer) {
                                                              return 0;
                                                            }

                                                            return data.miles;
                                                          },

                                                      // ==================================================
                                                      // BAR COLOR
                                                      // ==================================================
                                                      pointColorMapper:
                                                          (
                                                            GroupedVegetationData
                                                            data,
                                                            _,
                                                          ) {
                                                            // Spacer is invisible
                                                            if (data.isSpacer) {
                                                              return Colors
                                                                  .transparent;
                                                            }

                                                            return categoryColors[data
                                                                    .category] ??
                                                                Colors.grey;
                                                          },

                                                      // ==================================================
                                                      // NO GAP BETWEEN MAINTENANCE TYPES
                                                      // ==================================================
                                                      width: 1.0,

                                                      spacing: 0.0,

                                                      // ==================================================
                                                      // DATA LABEL
                                                      // ==================================================
                                                      dataLabelSettings:
                                                          const DataLabelSettings(
                                                            isVisible: true,

                                                            labelAlignment:
                                                                ChartDataLabelAlignment
                                                                    .middle,

                                                            textStyle:
                                                                TextStyle(
                                                                  fontSize: 9,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                          ),

                                                      // ==================================================
                                                      // TOOLTIP
                                                      // ==================================================
                                                      enableTooltip: true,

                                                      // ==================================================
                                                      // BAR CORNERS
                                                      // ==================================================
                                                      borderRadius:
                                                          const BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                  3,
                                                                ),
                                                            topRight:
                                                                Radius.circular(
                                                                  3,
                                                                ),
                                                          ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
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

  List<_ChartDataSimpleColumnChart1> recreateGraphData(
    ContractorDispatcherDashboardViewModel value,
  ) {
    chartDataSimpleColumnChart1.clear();
    for (
      var i = 0;
      i <
          contractorDispatcherDashboardViewModel
              .contractorDispatcherDashboardGetTabularData
              .data!
              .findMonthAndMiles!
              .length;
      i++
    ) {
      chartDataSimpleColumnChart1.add(
        _ChartDataSimpleColumnChart1(
          (contractorDispatcherDashboardViewModel
                          .contractorDispatcherDashboardGetTabularData
                          .data!
                          .findMonthAndMiles![i]
                          .month ==
                      null ||
                  contractorDispatcherDashboardViewModel
                          .contractorDispatcherDashboardGetTabularData
                          .data!
                          .findMonthAndMiles![i]
                          .month
                          .toString() ==
                      'null' ||
                  contractorDispatcherDashboardViewModel
                      .contractorDispatcherDashboardGetTabularData
                      .data!
                      .findMonthAndMiles![i]
                      .month!
                      .isEmpty)
              ? ''
              : contractorDispatcherDashboardViewModel
                    .contractorDispatcherDashboardGetTabularData
                    .data!
                    .findMonthAndMiles![i]
                    .month
                    .toString(),
          (contractorDispatcherDashboardViewModel
                          .contractorDispatcherDashboardGetTabularData
                          .data!
                          .findMonthAndMiles![i]
                          .miles ==
                      null ||
                  contractorDispatcherDashboardViewModel
                          .contractorDispatcherDashboardGetTabularData
                          .data!
                          .findMonthAndMiles![i]
                          .miles
                          .toString() ==
                      'null')
              ? 0.0
              : double.parse(
                  contractorDispatcherDashboardViewModel
                      .contractorDispatcherDashboardGetTabularData
                      .data!
                      .findMonthAndMiles![i]
                      .miles
                      .toString(),
                ),
        ),
      );
    }

    /// **Sort the list in reverse order**
    chartDataSimpleColumnChart1 = chartDataSimpleColumnChart1.reversed.toList();
    return chartDataSimpleColumnChart1;
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
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red.shade800,
                        ),
                        child: const Text(
                          "Yes",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
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
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                        child: const Text(
                          "No",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
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

  void _filterData(String query) {
    setState(() {
      if (query.trim().isEmpty) {
        filteredList = List.from(allData);
      } else {
        final q = query.toLowerCase();

        filteredList = allData.where((item) {
          return item.tokenNo.toString().toLowerCase().contains(q) ||
              (item.masterJobNo ?? "").toLowerCase().contains(q) ||
              (item.substation ?? "").toLowerCase().contains(q) ||
              (item.fdrName ?? "").toLowerCase().contains(q) ||
              (item.maintType ?? "").toLowerCase().contains(q) ||
              (item.status ?? "").toLowerCase().contains(q);
        }).toList();
      }
    });
  }

  Future openDialogPicture(String tokenNo) => showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          // lCPWorkOrdersClosedViewModel.fetchImageApi(
          //     context,
          //     //  '1');
          //     tokenNo.toString());
          int length =
              contractorDispatcherDashboardViewModel
                  .imageData
                  .data
                  ?.images
                  ?.length ??
              0;

          return AlertDialog(
            content: Container(
              width: MediaQuery.of(context).size.width * 0.99,
              padding: const EdgeInsets.only(top: 8.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    if (length == 0)
                      const Center(
                        child: Text(
                          "No image found!",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 7, 59, 120),
                          ),
                        ),
                      )
                    else
                      for (int i = 0; i < length; i += 2)
                        Row(
                          children: [
                            if (i < length) ...[
                              buildImageWidget(i, tokenNo.toString()),
                            ],
                            if (i + 1 < length) ...[
                              // const SizedBox(width: 8),
                              buildImageWidget(i + 1, tokenNo.toString()),
                            ],
                          ],
                        ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    },
  );

  Widget buildImageWidget(int i, String tokenNo) {
    String? fileLocation = contractorDispatcherDashboardViewModel
        .imageData
        .data
        ?.images![i]
        .imageLocation;

    bool isVideo(String file) {
      return file.endsWith('.mp4') || file.endsWith('.mov');
    }

    return Expanded(
      child: (fileLocation != null)
          ? Container(
              //  margin: const EdgeInsets.only(top:8, bottom:8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 2),
              ),
              child: Stack(
                children: [
                  if (isPDF(fileLocation))
                    Center(
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) => PDFViewer(
                                pdfUrl:
                                    'https://civm.ariespro.com/assets/clientuploads/$fileLocation',
                              ),
                            ),
                          );
                        },
                        child: Image.asset(
                          'assets/pdflogo.jpg',
                          height: 150,
                          width: 150,
                        ),
                      ),
                    )
                  else if (isVideo(fileLocation))
                    InkWell(
                      onTap: () {
                        openFullSizeVideoDialog(fileLocation);
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                          5,
                        ), // Optional rounded corners
                        child: SizedBox(
                          height: 150,
                          width: double.infinity,
                          child: VideoPlayerWidget(
                            videoUrl:
                                'https://civm.ariespro.com/assets/clientuploads/$fileLocation',
                          ),
                        ),
                      ),
                    )
                  else
                    InkWell(
                      onTap: () {
                        openFullSizeImageDialog(fileLocation);
                      },
                      child: Image.network(
                        'https://civm.ariespro.com/assets/clientuploads/$fileLocation',
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            if (!isPDF(fileLocation)) {
                              downloadFile(
                                'https://civm.ariespro.com/assets/clientuploads/$fileLocation',
                                'File',
                              );
                              Navigator.pop(context);
                            } else {
                              downloadFile(
                                'https://civm.ariespro.com/assets/clientuploads/$fileLocation',
                                'PDF',
                              );
                              Navigator.pop(context);
                            }
                          },
                          child: const Icon(
                            Icons.download,
                            color: Colors.blue,
                            size: 20,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            deleteOnlineImageApi(fileLocation, tokenNo);
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.delete,
                            color: Colors.red,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          : const Center(
              child: Text(
                "NO IMAGE",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 7, 59, 120),
                ),
              ),
            ),
    );
  }

  void openFullSizeVideoDialog(String videoUrl) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: EdgeInsets.zero,
          child: FullScreenVideoPlayer(videoUrl: videoUrl),
        );
      },
    );
  }

  Future<void> downloadFile(String fileUrl, String fileType) async {
    final response = await http.get(Uri.parse(fileUrl));
    if (response.statusCode == 200) {
      final appDir = await getApplicationDocumentsDirectory();
      final fileName = fileUrl.split('/').last;
      final file = File('${appDir.path}/$fileName');
      await file.writeAsBytes(response.bodyBytes);
      print('$fileType downloaded to: ${file.path}');
      CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
        '$fileType Downloaded',
        context,
      );
    } else {
      print(
        'Failed to download $fileType. Status code: ${response.statusCode}',
      );
    }
  }

  bool isPDF(String fileLocation) {
    return fileLocation.toLowerCase().endsWith('.pdf');
  }

  void openFullSizeImageDialog(String imageUrl) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: EdgeInsets.zero,
          child: Stack(
            children: [
              PhotoViewGallery(
                pageController: PageController(),
                backgroundDecoration: const BoxDecoration(color: Colors.black),
                onPageChanged: (index) {},
                scrollPhysics: const BouncingScrollPhysics(),
                pageOptions: [
                  PhotoViewGalleryPageOptions(
                    imageProvider: NetworkImage(
                      'https://civm.ariespro.com/assets/clientuploads/$imageUrl',
                    ),
                    minScale: PhotoViewComputedScale.contained * 0.5,
                    maxScale: PhotoViewComputedScale.covered * 0.5,
                  ),
                ],
              ),
              Positioned(
                top: 30,
                right: 20,
                child: IconButton(
                  icon: const Icon(Icons.close, color: Colors.white, size: 30),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> deleteOnlineImageApi(String fileName, String tokenNo) async {
    final apiUrl =
        'http://civmapi.ariespro.com/civmapi/changeOrderLcpCreateOrder/deleteFile?fileName=$fileName&tokenNo=$tokenNo';
    print(apiUrl);
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();

    try {
      final response = await http.delete(
        Uri.parse(apiUrl),
        headers: {"Authorization": 'Bearer ${data.token!}'},
      );

      if (response.statusCode == 200) {
        print('API response: ${response.body}');
        setState(() {});
        print('Image deleted successfully');
        CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
          'Image deleted Successfully',
          context,
        );
        // Navigator.pop(context);
        await Future.delayed(const Duration(seconds: 2));
        fetchData();
      } else {
        print('API request failed with status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  fetchData() async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    getInitData(selectedYear.toString());
    print('object');
    print(data.user!.id.toString());
  }

  void dateFormatNew(int index) {
    String? rawCreateDate = contractorDispatcherDashboardViewModel
        .contractorDispatcherDashboardGetTabularData
        .data!
        .findSmMaintTestResultRequestDatas![index]
        .contractYear
        ?.toString();
    formattedContractYear = extractYear(rawCreateDate);
    print('rawCreateDate $rawCreateDate');
    print('formattedContractYear: $formattedContractYear');
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
        String normalizedDate = date.replaceAll(
          RegExp(r'\s+'),
          ' ',
        ); // Remove extra spaces
        DateTime parsedDate = DateFormat(
          "MMM d yyyy h:mma",
        ).parse(normalizedDate);
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

  Future<void> getInitData(String year) async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    setState(() {});
    contractorId = '${data.user!.id}';
    print('contractorId${contractorId}');
    contractorDispatcherDashboardViewModel
        .fetchContractorDispatcherDashboardTabularListApi(
          context,
          contractorId,
          year,
        );
    fetchChartData(year);
    _tooltipBehavior = TooltipBehavior(
      enable: true,
      format: 'point.x : point.y miles', // Ensure proper formatting
    );
  }

  Future<void> fetchChartData(String year) async {
    final String apiUrl =
        "https://civm2.ariespro.com/civm2/contractorDashboard/contractorDisPacherPageData?contractorId=$contractorId&year=$year";
    try {
      final userPreferences = Provider.of<UserPref>(context, listen: false);
      UserModel data = await userPreferences.getUser();
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          "Authorization": "Bearer ${data.token}", // Add Bearer Token
          "Content-Type": "application/json", // Specify JSON format
        },
      );
      print('chart URl$apiUrl');
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        parseChartData(data);
      } else {
        print("Failed to load data: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching data: $e");
    }
  }

  void parseChartData(Map<String, dynamic> data) {
    try {
      if (!data.containsKey("findMonthMilesByRowMethod")) {
        print("findMonthMilesByRowMethod not found");
        return;
      }

      final extractedData = data["findMonthMilesByRowMethod"];

      if (extractedData == null || extractedData is! Map) {
        print("Invalid chart data");
        return;
      }

      chartDataMap.clear();
      categories.clear();
      uniqueMonths.clear();
      vegetationChartData.clear();
      extractedData.forEach((category, entries) {
        if (category == null ||
            category.toString().isEmpty ||
            entries == null ||
            entries is! List) {
          return;
        }

        for (var entry in entries) {
          if (entry is Map && entry["month"] != null) {
            uniqueMonths.add(entry["month"].toString());
          }
        }
      });

      print("uniqueMonths = $uniqueMonths");

      sortedMonths = uniqueMonths.toList()
        ..sort(
          (a, b) => _convertMonthToDate(a).compareTo(_convertMonthToDate(b)),
        );

      print("sortedMonths = $sortedMonths");

      extractedData.forEach((category, entries) {
        if (category == null ||
            category.toString().isEmpty ||
            entries == null ||
            entries is! List ||
            entries.isEmpty) {
          return;
        }

        final Map<String, double> monthMilesMap = {};

        // ------------------------------------------------------------
        // Store ONLY months returned by API
        // ------------------------------------------------------------

        for (var entry in entries) {
          if (entry is Map) {
            final String? month = entry["month"]?.toString();
            final dynamic miles = entry["total miles"];

            if (month != null && month.isNotEmpty) {
              monthMilesMap[month] = miles is num ? miles.toDouble() : 0.0;
            }
          }
        }

        // ------------------------------------------------------------
        // IMPORTANT:
        // Only create data for months that actually exist
        // for this maintenance type.
        // ------------------------------------------------------------

        final List<ChartDataNew> chartData = [];

        for (final month in sortedMonths) {
          if (monthMilesMap.containsKey(month)) {
            chartData.add(ChartDataNew(month, monthMilesMap[month]!));
          }
        }

        if (chartData.isNotEmpty) {
          chartDataMap[category.toString()] = chartData;
          categories.add(category.toString());
        }
      });

      // ============================================================
      // CREATE DATA FOR COLUMN CHART
      // ============================================================

      vegetationChartData.clear();

      chartDataMap.forEach((category, dataList) {
        for (final data in dataList) {
          vegetationChartData.add(
            VegetationChartData(
              category: category,
              month: data.month,
              miles: data.miles,
            ),
          );
        }
      });

      // ============================================================
      // DEBUG
      // ============================================================

      print("categories = $categories");

      print("chartDataMap = $chartDataMap");

      print("vegetationChartData = $vegetationChartData");

      // ============================================================
      // REFRESH UI
      // ============================================================

      if (mounted) {
        setState(() {});
      }
    } catch (e, stackTrace) {
      print("ERROR parsing chart data: $e");
      print(stackTrace);
    }
  }

  DateTime _convertMonthToDate(String monthString) {
    List<String> parts = monthString.split('/');
    return DateTime(
      int.parse(parts[1]),
      int.parse(parts[0]),
    ); // Format: MM/YYYY
  }

  Future<void> getUserType() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String userType = pref.getString('userType').toString();
    String primaryRole = pref.getString('primaryRole').toString();
    if (userType == '3') {
      userTypeText = 'General Foreman';
    } else if (userType == '6') {
      userTypeText = 'Planner';
    }
    if (primaryRole == '3') {
      primaryRoleText = 'General Foreman';
    } else if (primaryRole == '6') {
      primaryRoleText = 'Planner';
    }
  }

  void showYearFilterDialog() {
    allData.clear();
    filteredList.clear();
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

                    getInitData(selectedYear.toString());
                  },
                  child: const Text("Search"),
                ),
              ],
            );
          },
        );
      },
    );
  } //----

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

class VegetationChartData {
  final String category;
  final String month;
  final double miles;

  VegetationChartData({
    required this.category,
    required this.month,
    required this.miles,
  });
}

class GroupedVegetationData {
  final String month;
  final String category;
  final double miles;
  final bool isSpacer;

  GroupedVegetationData({
    required this.month,
    required this.category,
    required this.miles,
    this.isSpacer = false,
  });
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
  bool isDrawerLoading = true;

  @override
  void initState() {
    setUserName();
    _loadData();
    super.initState();
  }

  Future<void> _loadData() async {
    await setUserName();
    await getUserDetailsByUsername();

    setState(() {
      isDrawerLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final userPreferences = Provider.of<UserPref>(context);
    var provider = Provider.of<LocationProvider>(context, listen: true);
    final browser = MyChromeSafariBrowser();
    if (isDrawerLoading) {
      return const Drawer(child: Center(child: CircularProgressIndicator()));
    }
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
                    title: const Text('General Foreman Dashboard'),
                    textColor: const Color.fromARGB(255, 7, 59, 120),
                    iconColor: const Color.fromARGB(255, 7, 59, 120),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  // ListTile(
                  //   leading: const Icon(
                  //     Icons.open_in_browser,
                  //   ),
                  //   title: const Text('Change Order Pending'),
                  //   textColor: const Color.fromARGB(255, 7, 59, 120),
                  //   iconColor: const Color.fromARGB(255, 7, 59, 120),
                  //   onTap: () {
                  //     Navigator.of(context).push(MaterialPageRoute(
                  //         builder: (BuildContext context) =>
                  //             const WorkOrderPendingContractor()));
                  //   },
                  // ),
                  // Visibility(
                  //   visible: (widget.menu.isNotEmpty &&
                  //           widget.menu.contains('Energy Audit Ticket'))
                  //       ? true
                  //       : false,
                  // child:
                  // ListTile(
                  //   leading: const Icon(
                  //     Icons.pending,
                  //   ),
                  //   title: const Text('IVM Maintenance Progress'),
                  //   textColor: const Color.fromARGB(255, 7, 59, 120),
                  //   iconColor: const Color.fromARGB(255, 7, 59, 120),
                  //   onTap: () {
                  //     Navigator.of(context).push(MaterialPageRoute(
                  //         builder: (BuildContext context) =>
                  //             const RowMaintenanceProgressContractor()));
                  //   },
                  // ),
                  // ),
                  ListTile(
                    leading: const Icon(Icons.settings_applications_sharp),
                    title: const Text('Maintenance Report View'),
                    textColor: const Color.fromARGB(255, 7, 59, 120),
                    iconColor: const Color.fromARGB(255, 7, 59, 120),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              GfMaintenanceReportViewNew(year: ''),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.closed_caption_off),
                    title: const Text('IVM/Change Order'),
                    textColor: const Color.fromARGB(255, 7, 59, 120),
                    iconColor: const Color.fromARGB(255, 7, 59, 120),
                    onTap: () {
                      // Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (BuildContext context) =>
                      //         const ChangeOrderContractor()));
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              Inspection(year: ''),
                        ),
                      );
                    },
                  ),

                  // ListTile(
                  //   leading: const Icon(
                  //     Icons.inventory,
                  //   ),
                  //   title: const Text('Daily Herbicide Application Form'),
                  //   textColor: const Color.fromARGB(255, 7, 59, 120),
                  //   iconColor: const Color.fromARGB(255, 7, 59, 120),
                  //   onTap: () {
                  //     Navigator.of(context).push(MaterialPageRoute(
                  //         builder: (BuildContext context) =>
                  //             const DailyHerbicideApplicationFormContractor()));
                  //   },
                  // ),

                  // ListTile(
                  //   leading: const Icon(
                  //     Icons.list_alt,
                  //   ),
                  //   title: const Text('Power Time Form'),
                  //   textColor: const Color.fromARGB(255, 7, 59, 120),
                  //   iconColor: const Color.fromARGB(255, 7, 59, 120),
                  //   onTap: () {
                  //     Navigator.of(context).push(MaterialPageRoute(
                  //         builder: (BuildContext context) =>
                  //             const PowerTimeFormContractor()));
                  //   },
                  // ),

                  // ListTile(
                  //   leading: const Icon(
                  //     Icons.list_alt,
                  //   ),
                  //   title: const Text('Invoice Form'),
                  //   textColor: const Color.fromARGB(255, 7, 59, 120),
                  //   iconColor: const Color.fromARGB(255, 7, 59, 120),
                  //   onTap: () {
                  //     Navigator.of(context).push(MaterialPageRoute(
                  //         builder: (BuildContext context) =>
                  //             const InvoiceFormContractor()));
                  //   },
                  // ),
                  // ListTile(
                  //   leading: const Icon(
                  //     Icons.list_alt,
                  //   ),
                  //   title: const Text('Mixing Inventory Form'),
                  //   textColor: const Color.fromARGB(255, 7, 59, 120),
                  //   iconColor: const Color.fromARGB(255, 7, 59, 120),
                  //   onTap: () {
                  //     Navigator.of(context).push(MaterialPageRoute(
                  //         builder: (BuildContext context) =>
                  //             const MixingInventoryFormContractor()));
                  //   },
                  // ),
                  // ListTile(
                  //   leading: const Icon(
                  //     Icons.pin_invoke_outlined,
                  //   ),
                  //   title: const Text('Create Invoice'),
                  //   textColor: const Color.fromARGB(255, 7, 59, 120),
                  //   iconColor: const Color.fromARGB(255, 7, 59, 120),
                  //   onTap: () {
                  //     Navigator.of(context).push(MaterialPageRoute(
                  //         builder: (BuildContext context) =>
                  //             const CreateInvoiceContractor()));
                  //   },
                  // ),
                  // ListTile(
                  //     leading: const Icon(
                  //       Icons.list,
                  //     ),
                  //     title: const Text('Invoice List'),
                  //     textColor: const Color.fromARGB(255, 7, 59, 120),
                  //     iconColor: const Color.fromARGB(255, 7, 59, 120),
                  //     onTap: () {
                  //       Navigator.of(context).push(MaterialPageRoute(
                  //           builder: (BuildContext context) =>
                  //               const InvoiceListContrator()));
                  //     }),
                  // ListTile(
                  //   leading: const Icon(Icons.map),
                  //   title: const Text('IVM Offline Map'),
                  //   textColor: const Color.fromARGB(255, 7, 59, 120),
                  //   iconColor: const Color.fromARGB(255, 7, 59, 120),
                  //   onTap: () async {
                  //     String id = '';
                  //     final userPreferences1 = Provider.of<UserPref>(
                  //       context,
                  //       listen: false,
                  //     );
                  //     UserModel data = await userPreferences1.getUser();
                  //     id = data.user!.id.toString();
                  //     // Navigator.push(
                  //     //   context,
                  //     //   MaterialPageRoute(
                  //     //     builder: (context) => MapViewPage(
                  //     //       url:
                  //     //           "https://lcpmapapi.ariespro.com/main/ivm_map_view/CIVM_Map/USRQWXH589Z/$id",
                  //     //     ),
                  //     //   ),
                  //     // );
                  //     await browser.open(
                  //       url: WebUri(
                  //         "https://lcpmapapi.ariespro.com/main/ivm_map_view/CIVM_Map/USRQWXH589Z/$id",
                  //       ),
                  //       //crew id in place of id in above line
                  //       settings: ChromeSafariBrowserSettings(
                  //         shareState: CustomTabsShareState.SHARE_STATE_OFF,
                  //         barCollapsingEnabled: true,
                  //       ),
                  //     );
                  //   },
                  // ),
                  // ListTile(
                  //   leading: const Icon(Icons.map_outlined),
                  //   title: const Text('Herbicide Offline Map'),
                  //   textColor: const Color.fromARGB(255, 7, 59, 120),
                  //   iconColor: const Color.fromARGB(255, 7, 59, 120),
                  //   onTap: () async {
                  //     String id = '';
                  //     final userPreferences1 = Provider.of<UserPref>(
                  //       context,
                  //       listen: false,
                  //     );
                  //     UserModel data = await userPreferences1.getUser();
                  //     id = data.user!.id.toString();
                  //     //   Navigator.push(
                  //     //   context,
                  //     //   MaterialPageRoute(
                  //     //     builder: (context) => MapViewPage(
                  //     //       url:
                  //     //           "https://lcpmapapi.ariespro.com/main/mid_cycle/CIVM_Map/USRQWXH589Z/$id",
                  //     //     ),
                  //     //   ),
                  //     // );
                  //     await browser.open(
                  //       url: WebUri(
                  //         "https://lcpmapapi.ariespro.com/main/mid_cycle/CIVM_Map/USRQWXH589Z/$id",
                  //       ),
                  //       //crew id in place of id in above line
                  //       settings: ChromeSafariBrowserSettings(
                  //         shareState: CustomTabsShareState.SHARE_STATE_OFF,
                  //         barCollapsingEnabled: true,
                  //       ),
                  //     );
                  //   },
                  // ),

                  // ListTile(
                  //   leading: const Icon(Icons.location_searching),
                  //   title: const Text('Offline Maintenance Map'),
                  //   textColor: const Color.fromARGB(255, 7, 59, 120),
                  //   iconColor: const Color.fromARGB(255, 7, 59, 120),
                  //   onTap: () async {
                  //     String id = '';
                  //     final userPreferences1 = Provider.of<UserPref>(
                  //       context,
                  //       listen: false,
                  //     );
                  //     UserModel data = await userPreferences1.getUser();
                  //     id = data.user!.id.toString();
                  //     //    Navigator.push(
                  //     //   context,
                  //     //   MaterialPageRoute(
                  //     //     builder: (context) => MapViewPage(
                  //     //       url:
                  //     //           "https://lcpmapapi.ariespro.com/main/change_order_view/CIVM_Map/USRQWXH589Z/$id",
                  //     //     ),
                  //     //   ),
                  //     // );
                  //     await browser.open(
                  //       url: WebUri(
                  //         "https://lcpmapapi.ariespro.com/main/change_order_view/CIVM_Map/USRQWXH589Z/$id",
                  //       ),
                  //       //crew id in place of id in above line
                  //       settings: ChromeSafariBrowserSettings(
                  //         shareState: CustomTabsShareState.SHARE_STATE_OFF,
                  //         barCollapsingEnabled: true,
                  //       ),
                  //     );
                  //   },
                  // ),
                  ListTile(
                    leading: Icon(Icons.location_on),
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
                    leading: const Icon(Icons.add),
                    title: const Text('Add Crew Member'),
                    textColor: const Color.fromARGB(255, 7, 59, 120),
                    iconColor: const Color.fromARGB(255, 7, 59, 120),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const GFAddCrewMember(),
                        ),
                      );
                    },
                  ),
                  // ignore: unnecessary_null_comparison
                  (Constants.prefs
                              .getString('additionalUserType')
                              .toString()
                              .isNotEmpty &&
                          Constants.prefs
                                  .getString('additionalUserType')
                                  .toString() !=
                              'null')
                      ? ListTile(
                          leading: const Icon(Icons.refresh),
                          title: const Text('Switch Panel'),
                          textColor: const Color.fromARGB(255, 7, 59, 120),
                          iconColor: const Color.fromARGB(255, 7, 59, 120),
                          onTap: () {
                            _openLoginDialog(context);
                          },
                        )
                      : Container(),
                  ListTile(
                    leading: const Icon(Icons.logout),
                    title: const Text('Log Out'),
                    textColor: const Color.fromARGB(255, 7, 59, 120),
                    iconColor: const Color.fromARGB(255, 7, 59, 120),
                    onTap: () {
                      // // Constants.prefs.setBool("LoggedIn", false);
                      userPreferences.remove().then((value) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const LoginPage(),
                          ),
                        );
                      });
                      // Navigator.of(context).pushReplacement(MaterialPageRoute(
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
      'https://civm.ariespro.com/assets/clientuploads/${data.user!.profilePhoto}',
    );
    String imageUrl =
        'https://civm.ariespro.com/assets/clientuploads/${data.user!.profilePhoto}';
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
        String normalizedDate = date.replaceAll(
          RegExp(r'\s+'),
          ' ',
        ); // Remove extra spaces
        DateTime parsedDate = DateFormat(
          "MMM d yyyy h:mma",
        ).parse(normalizedDate);
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

  Future<void> _openLoginDialog(BuildContext context) async {
    // Show loader
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return const Center(child: CircularProgressIndicator());
      },
    );

    // Wait for API
    final bool isValid = await checkCurrentUserDrawer();

    if (!mounted) return;

    // Close loader
    Navigator.of(context, rootNavigator: true).pop();

    // API returned false
    if (!isValid) {
      Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const LoginPage()),
        (route) => false,
      );

      return;
    }

    // API returned true
    bool isLoading = false;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              titlePadding: const EdgeInsets.fromLTRB(24, 20, 12, 0),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Switch Panel',
                    style: TextStyle(
                      color: Color.fromARGB(255, 7, 59, 120),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.grey),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              content: SizedBox(
                width: 280,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (isLoading) ...[
                      const Padding(
                        padding: EdgeInsets.only(bottom: 20),
                        child: CircularProgressIndicator(),
                      ),
                      const Text(
                        "Switching panel...",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 20),
                    ],

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 45),
                        backgroundColor: const Color.fromARGB(255, 7, 59, 120),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: isLoading
                          ? null
                          : () async {
                              setDialogState(() {
                                isLoading = true;
                              });

                              bool success = await switchUser();

                              setDialogState(() {
                                isLoading = false;
                              });

                              if (success) {
                                Navigator.pop(context);

                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        PlannerBottomNavigationPannel(),
                                  ),
                                );
                              } else {
                                // Navigator.pop(context);
                                // showAccessDeniedDialog(this.context);
                                Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        const LoginPage(),
                                  ),
                                  (route) => false,
                                );
                              }
                            },
                      child: const Text(
                        "Work as Planner",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),

                    const SizedBox(height: 12),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 45),
                        backgroundColor: const Color.fromARGB(255, 7, 59, 120),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () async {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Work as General Foreman",
                        style: TextStyle(
                          color: Color.fromARGB(255, 151, 228, 248),
                        ),
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
  }

  // Future<bool> switchUser() async {
  //   try {
  //     final userPreferences = Provider.of<UserPref>(context, listen: false);

  //     UserModel user = await userPreferences.getUser();
  //     String id = '';
  //     UserModel data = await userPreferences.getUser();
  //     id = data.user!.id.toString();

  //     final uri =
  //         "${AppUrl.baseUrl}login_user/switchUser"
  //         "?loginId=$id"
  //         "&switchTo=6";
  //     print('uriuri:: $uri');
  //     final response = await http.put(
  //       Uri.parse(uri),
  //       headers: {
  //         "Authorization": "Bearer ${user.token}",
  //         "Content-Type": "application/json",
  //       },
  //     );

  //     print("Switch User Status : ${response.statusCode}");
  //     print("Switch User Response : ${response.body}");

  //     if (response.statusCode == 200) {
  //       final SharedPreferences pref = await SharedPreferences.getInstance();
  //       pref.setString('userType', '6');
  //       //  Navigator.of(context).push(
  //       //                 MaterialPageRoute(
  //       //                   builder: (BuildContext context) =>
  //       //                       PlannerBottomNavigationPannel(),
  //       //                 ),
  //       //               );
  //       return true;
  //     } else {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text(response.body), backgroundColor: Colors.red),
  //       );

  //       return false;
  //     }
  //   } catch (e) {
  //     print("switchUser Error : $e");

  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Access Denied!'), backgroundColor: Colors.red),
  //     );

  //     return false;
  //   }
  // }
  Future<bool> switchUser() async {
    try {
      final userPreferences = Provider.of<UserPref>(context, listen: false);

      UserModel user = await userPreferences.getUser();

      final String id = user.user!.id.toString();

      final uri =
          "${AppUrl.baseUrl}login_user/switchUser"
          "?loginId=$id"
          "&switchTo=6";

      print('uriuri:: $uri');

      final response = await http.put(
        Uri.parse(uri),
        headers: {
          "Authorization": "Bearer ${user.token}",
          "Content-Type": "application/json",
        },
      );

      print("Switch User Status : ${response.statusCode}");
      print("Switch User Response : ${response.body}");

      if (response.statusCode == 200) {
        final SharedPreferences pref = await SharedPreferences.getInstance();

        await pref.setString('userType', '6');

        print('userType:: ${pref.getString('userType')}');

        return true;
      }

      // // ============================================================
      // // SWITCH FAILED - SHOW ACCESS DENIED DIALOG
      // // ============================================================
      // if (response.statusCode == 400) {
      //   showAccessDeniedDialog(context);
      //   return false;
      // }

      // // Any other error
      // showAccessDeniedDialog(context);
      return false;
    } catch (e) {
      print("switchUser Error : $e");

      // showAccessDeniedDialog(context);

      return false;
    }
  }

  void showAccessDeniedDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.cancel, color: Colors.red, size: 80),

              const SizedBox(height: 12),

              const Text(
                'Switch Failed',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 7, 59, 120),
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'Access Denied!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.red,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: 100,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(dialogContext).pop();
                  },
                  child: const Text('OK'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<UserDetails?> getUserDetailsByUsername() async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    String email = data.user!.email.toString();
    var url = "${AppUrl.baseUrl}login_user/get_userDetails_by_username/$email";
    print('url: $url');
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          "Authorization": "Bearer ${data.token}",
          "Content-Type": "application/json",
        },
      );
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        String? userType = responseData["userDetails"]["userType"]?.toString();
        String? additionalUserType =
            responseData["userDetails"]["additionalUserType"]?.toString();
        final SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setString('userType', userType.toString());
        pref.setString('additionalUserType', additionalUserType.toString());
        print('additionalUserType:: $additionalUserType');
        return UserDetails.fromJson(responseData["userDetails"]);
      } else {
        print("Error : ${response.statusCode}");
        print(response.body);
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

Future<bool> checkCurrentUserDrawer() async {
    print('planner authentication');

    try {
      final prefs = await SharedPreferences.getInstance();

      final fcmToken = prefs.getString('device_token_for_logOut');

      if (fcmToken == null || fcmToken.isEmpty) {
        print("FCM token not found in SharedPreferences");
        return false;
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

        if (responseData == true) {
          return true;
        }

        // API returned false
        if (responseData == false) {
          final userPreferences = Provider.of<UserPref>(context, listen: false);

          await userPreferences.remove();

          return false;
        }

        return false;
      }

      if (response.statusCode == 401) {
        print("Unauthorized - Bearer token is invalid or expired");
        return false;
      }

      print(
        "checkCurrentUser failed: "
        "${response.statusCode} - ${response.body}",
      );

      return false;
    } catch (e) {
      print("checkCurrentUser Error: $e");
      return false;
    }
  }

}

class ChartData {
  ChartData(this.x, this.y, this.color);
  final String x;
  final double y;
  final Color color;
}

// class _ChartDataSimpleColumnChart1 {
//   _ChartDataSimpleColumnChart1(this.x, this.y1,this.y2,this.y3);

//   final String x;
//   final double y1;
//    final String y2;
//     final String y3;
//   // final Color? color;
// }
class _ChartDataSimpleColumnChart1 {
  _ChartDataSimpleColumnChart1(this.x, this.y1);

  final String x;
  final double y1;
  // final Color? color;
}

//new
class ChartDataNew {
  final String month;
  final double miles;

  ChartDataNew(this.month, this.miles);
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
      padding: const EdgeInsets.only(top: 8, bottom: 8, left: 8, right: 8),
      alignment: Alignment.center,
      width: size.width * 0.425,
      height: MediaQuery.of(context).size.height * 0.12,
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
