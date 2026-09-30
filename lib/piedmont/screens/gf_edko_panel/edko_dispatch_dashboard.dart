import 'dart:convert';
import 'dart:io';
import 'package:CIVM/piedmont/data/response/status.dart';
import 'package:CIVM/piedmont/models/gf_edko_dashboard_data_list_model.dart';
import 'package:CIVM/piedmont/repository/map_url.dart';
import 'package:CIVM/piedmont/resources/app_url.dart';

import 'package:CIVM/piedmont/screens/gf_edko_panel/edko_annual_Herbicide_TO_closed.dart';
import 'package:CIVM/piedmont/screens/gf_edko_panel/edko_annual_Herbicide_TO_pending.dart';
import 'package:CIVM/piedmont/screens/gf_edko_panel/edko_annual_herbicide_editpage_new.dart';
import 'package:CIVM/piedmont/screens/gf_edko_panel/edko_inspection.dart';
import 'package:CIVM/piedmont/screens/gf_edko_panel/edko_trans_Herbicide_TO_closed.dart';
import 'package:CIVM/piedmont/screens/gf_edko_panel/edko_trans_Herbicide_TO_pending.dart';

import 'package:CIVM/piedmont/screens/gf_edko_panel/edko_trans_herbicide_view.dart';

import 'package:CIVM/piedmont/screens/login_page.dart';
import 'package:CIVM/piedmont/utils/common_functions.dart';
import 'package:CIVM/utils/user_pref.dart';
import 'package:CIVM/models/user_model.dart';
import 'package:CIVM/piedmont/resources/app_colors.dart';
import 'package:CIVM/piedmont/screens/admin_pannel/row_maintenance_view/pdf_view.dart';

import 'package:CIVM/piedmont/screens/leaflat_map/leaf_lat_map_wakeLock.dart';
import 'package:CIVM/piedmont/screens/map/provider/location_provider.dart';
import 'package:CIVM/piedmont/screens/video_folder/fullVideo/full_screen_video_player.dart';
import 'package:CIVM/sharedPrefs/constants.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'package:http/http.dart' as http;
import 'package:CIVM/piedmont/utils/custom_toast_snackbar_progressdialog.dart';
import 'package:CIVM/piedmont/view_model/contractor_dispatch_dashboard_view_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:CIVM/piedmont/screens/my_chrome_safari_map_recording.dart';

// ignore: must_be_immutable
class EdkoDispatchDashboard extends StatefulWidget {
  const EdkoDispatchDashboard({Key? key}) : super(key: key);

  @override
  State<EdkoDispatchDashboard> createState() => _EdkoDispatchDashboardState();
}

class _EdkoDispatchDashboardState extends State<EdkoDispatchDashboard> {
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
    "JARAFF": const Color.fromARGB(255, 96, 0, 113),
    "MOWING": const Color.fromARGB(255, 113, 68, 1),
    "MINI JARAFF": const Color.fromARGB(255, 247, 19, 2),
    "BYL": const Color.fromARGB(255, 2, 212, 249),
    "BUCKET": Colors.orange,
    "GROUND": Colors.yellow,
    "CROSS-COUNTRY SPRAY": const Color.fromARGB(255, 38, 1, 247),
    "ROADSIDE SPRAY": const Color.fromARGB(255, 1, 127, 5),
    "NO SPRAY": const Color.fromARGB(255, 252, 199, 249),
  };
  List<GfEdkoDashboardDatadata> dataList = [];
  List<GfEdkoDashboardDatadata> filteredList = [];
  @override
  void initState() {
    fetchListData();
    getInitData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // ignore: deprecated_member_use
    return PopScope(
      canPop: false,
    onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          return;
        }
        showExitPopup(context);
      },
    // WillPopScope(
    //     onWillPop: () => showExitPopup(context),
        child: Scaffold(
            backgroundColor: AppColors.backgroundColor,
            // appBar: AppBar(
            //   title: const Text('Contractor Dashboard',
            // style: TextStyle(color: Colors.white),),
            //   backgroundColor: AppColors.baseColor,
            //   actions: const <Widget>[],
            // ),
            appBar: AppBar(
              iconTheme: const IconThemeData(color: Colors.white),
              title: const Text(
                'General Foreman Dashboard',
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: AppColors.baseColor,
              // actions: [
              //   IconButton(
              //     icon: const Icon(Icons.logout, color: Colors.white),
              //     onPressed: () {
              //       userPreferences.remove().then((value) {
              //         Navigator.of(context).push(MaterialPageRoute(
              //             builder: (BuildContext context) =>
              //                 const LoginPage()));
              //       });
              //       // Navigator.of(context).push(MaterialPageRoute(
              //       //     builder: (BuildContext context) => const LoginPage()));
              //     },
              //   ),
              // ],
            ),
            drawer: DrawerManu(menu: menu),
            body: ChangeNotifierProvider<
                    ContractorDispatcherDashboardViewModel>(
                create: (BuildContext context) =>
                    contractorDispatcherDashboardViewModel,
                child: Consumer<ContractorDispatcherDashboardViewModel>(
                    builder: (context, value, _) {
                  switch (value
                      .contractorDispatcherDashboardGetTabularData.status) {
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
                      return RefreshIndicator(
                        onRefresh: () async {
                          _input.clear();
                          await getInitData();
                        },
                        child: SingleChildScrollView(
                          child: Center(
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
                                           margin: const EdgeInsets.only(
                                      top: 0, bottom: 12, left: 0, right: 0),
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
                                              "Vegetation Progress",
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
                                      // Padding(
                                      //   padding: const EdgeInsets.only(
                                      //       right: 8, left: 8),
                                      //   child: Row(
                                      //     children: [
                                      //       InkWell(
                                      //         onTap: () {
                                      //           Navigator.of(context).push(
                                      //               MaterialPageRoute(
                                      //                   builder: (BuildContext
                                      //                           context) =>
                                      //                       const EdkoDistributionIVMpEnding()));
                                      //         },
                                      //         child: DashboardCard(
                                      //           cardIcon:
                                      //               'assets/Orders_Pending.png',
                                      //           iconColor: Colors.red,
                                      //           cardColor: const Color.fromRGBO(
                                      //               79, 130, 156, 1),
                                      //           cardTitle:
                                      //               'IVM Distribution Pending',
                                      //           cardCount: (contractorDispatcherDashboardViewModel
                                      //                           .contractorDispatcherDashboardGetTabularData
                                      //                           .data!
                                      //                           .distributionPending ==
                                      //                       null ||
                                      //                   contractorDispatcherDashboardViewModel
                                      //                           .contractorDispatcherDashboardGetTabularData
                                      //                           .data!
                                      //                           .distributionPending
                                      //                           .toString() ==
                                      //                       'null')
                                      //               ? ''
                                      //               : contractorDispatcherDashboardViewModel
                                      //                   .contractorDispatcherDashboardGetTabularData
                                      //                   .data!
                                      //                   .distributionPending
                                      //                   .toString(),
                                      //           // "${(contractorDispatcherDashboardViewModel.contractorDispatcherDashboardGetTabularData.data!.regularIVMPendingApproval ?? 0) + (contractorDispatcherDashboardViewModel.contractorDispatcherDashboardGetTabularData.data!.midCyclePendingApproval ?? 0)}"
                                      //         ),
                                      //       ),
                                      //       const SizedBox(
                                      //         width: 10,
                                      //       ),
                                      //       InkWell(
                                      //         onTap: () {
                                      //           Navigator.of(context).push(
                                      //               MaterialPageRoute(
                                      //                   builder: (BuildContext
                                      //                           context) =>
                                      //                       const EdkoDistributionIVMcLOSED()));
                                      //         },
                                      //         child: DashboardCard(
                                      //             cardIcon:
                                      //                 'assets/Orders_Pending.png',
                                      //             iconColor: Colors.red,
                                      //             cardColor:
                                      //                 const Color.fromARGB(
                                      //                     255, 48, 126, 52),
                                      //             cardTitle:
                                      //                 'IVM Distribution Closed',
                                      //             cardCount: (contractorDispatcherDashboardViewModel
                                      //                             .contractorDispatcherDashboardGetTabularData
                                      //                             .data!
                                      //                             .distributionClosed ==
                                      //                         null ||
                                      //                     contractorDispatcherDashboardViewModel
                                      //                             .contractorDispatcherDashboardGetTabularData
                                      //                             .data!
                                      //                             .distributionClosed
                                      //                             .toString() ==
                                      //                         'null')
                                      //                 ? ''
                                      //                 : contractorDispatcherDashboardViewModel
                                      //                     .contractorDispatcherDashboardGetTabularData
                                      //                     .data!
                                      //                     .distributionClosed
                                      //                     .toString()),
                                      //       ),
                                      //     ],
                                      //   ),
                                      // ),
                                      // Padding(
                                      //   padding: const EdgeInsets.only(
                                      //       right: 8, left: 8),
                                      //   child: Row(
                                      //     children: [
                                      //       InkWell(
                                      //         onTap: () {
                                      //           Navigator.of(context).push(
                                      //               MaterialPageRoute(
                                      //                   builder: (BuildContext
                                      //                           context) =>
                                      //                       const EdkoTransmissionIVMpEnding()));
                                      //         },
                                      //         child: DashboardCard(
                                      //             cardIcon:
                                      //                 'assets/Orders_Pending.png',
                                      //             iconColor: Colors.red,
                                      //             cardColor:
                                      //                 const Color.fromRGBO(
                                      //                     75, 58, 105, 1),
                                      //             cardTitle:
                                      //                 'Transmission IVM Pending',
                                      //             cardCount: (contractorDispatcherDashboardViewModel
                                      //                             .contractorDispatcherDashboardGetTabularData
                                      //                             .data!
                                      //                             .transmissionIVMPending ==
                                      //                         null ||
                                      //                     contractorDispatcherDashboardViewModel
                                      //                             .contractorDispatcherDashboardGetTabularData
                                      //                             .data!
                                      //                             .transmissionIVMPending
                                      //                             .toString() ==
                                      //                         'null')
                                      //                 ? ''
                                      //                 : contractorDispatcherDashboardViewModel
                                      //                     .contractorDispatcherDashboardGetTabularData
                                      //                     .data!
                                      //                     .transmissionIVMPending
                                      //                     .toString()),
                                      //       ),
                                      //       const SizedBox(
                                      //         width: 10,
                                      //       ),
                                      //       InkWell(
                                      //         onTap: () {
                                      //           Navigator.of(context).push(
                                      //               MaterialPageRoute(
                                      //                   builder: (BuildContext
                                      //                           context) =>
                                      //                       const EdkoTransmissionIVMcLOSED()));
                                      //         },
                                      //         child: DashboardCard(
                                      //             cardIcon:
                                      //                 'assets/Orders_Open.png',
                                      //             iconColor: Colors.green,
                                      //             cardColor:
                                      //                 const Color.fromRGBO(
                                      //                     127, 71, 45, 1),
                                      //             cardTitle:
                                      //                 'Transmission IVM Closed',
                                      //             cardCount: (contractorDispatcherDashboardViewModel
                                      //                             .contractorDispatcherDashboardGetTabularData
                                      //                             .data!
                                      //                             .transmissionIVMClosed ==
                                      //                         null ||
                                      //                     contractorDispatcherDashboardViewModel
                                      //                             .contractorDispatcherDashboardGetTabularData
                                      //                             .data!
                                      //                             .transmissionIVMClosed
                                      //                             .toString() ==
                                      //                         'null')
                                      //                 ? ''
                                      //                 : contractorDispatcherDashboardViewModel
                                      //                     .contractorDispatcherDashboardGetTabularData
                                      //                     .data!
                                      //                     .transmissionIVMClosed
                                      //                     .toString()),
                                      //       ),
                                      //     ],
                                      //   ),
                                      // ),
                                    
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
                                                    iconColor: Colors.red,
                                                    cardColor:
                                                        const Color.fromRGBO(
                                                            157, 79, 79, 1),
                                                    cardTitle:
                                                        'Transmission Herbicide Pending',
                                                    cardCount: (contractorDispatcherDashboardViewModel
                                                                    .contractorDispatcherDashboardGetTabularData
                                                                    .data!
                                                                    .transmissionHerbicidePending ==
                                                                null ||
                                                            contractorDispatcherDashboardViewModel
                                                                    .contractorDispatcherDashboardGetTabularData
                                                                    .data!
                                                                    .transmissionHerbicidePending
                                                                    .toString() ==
                                                                'null')
                                                        ? ''
                                                        : contractorDispatcherDashboardViewModel
                                                            .contractorDispatcherDashboardGetTabularData
                                                            .data!
                                                            .transmissionHerbicidePending
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
                                                              const EdkoTransmissionHerbicideIVMcLOSED()));
                                                },
                                                child: DashboardCard(
                                                    cardIcon:
                                                        'assets/Orders_Open.png',
                                                    iconColor: Colors.green,
                                                    cardColor:
                                                        const Color.fromRGBO(
                                                            123, 113, 54, 1),
                                                    cardTitle:
                                                        'Transmission Herbicide Closed',
                                                    cardCount: (contractorDispatcherDashboardViewModel
                                                                    .contractorDispatcherDashboardGetTabularData
                                                                    .data!
                                                                    .transmissionHerbicideClosed ==
                                                                null ||
                                                            contractorDispatcherDashboardViewModel
                                                                    .contractorDispatcherDashboardGetTabularData
                                                                    .data!
                                                                    .transmissionHerbicideClosed
                                                                    .toString() ==
                                                                'null')
                                                        ? ''
                                                        : contractorDispatcherDashboardViewModel
                                                            .contractorDispatcherDashboardGetTabularData
                                                            .data!
                                                            .transmissionHerbicideClosed
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
                                                              EdkoAnnualHerbicideTOPending()));
                                                },
                                                child: DashboardCard(
                                                    cardIcon:
                                                        'assets/Orders_Pending.png',
                                                    iconColor: Colors.red,
                                                    cardColor: Colors.teal,
                                                    cardTitle:
                                                        'Annual Herbicide Pending',
                                                    cardCount: (contractorDispatcherDashboardViewModel
                                                                    .contractorDispatcherDashboardGetTabularData
                                                                    .data!
                                                                    .annualHerbicidePending ==
                                                                null ||
                                                            contractorDispatcherDashboardViewModel
                                                                    .contractorDispatcherDashboardGetTabularData
                                                                    .data!
                                                                    .annualHerbicidePending
                                                                    .toString() ==
                                                                'null')
                                                        ? ''
                                                        : contractorDispatcherDashboardViewModel
                                                            .contractorDispatcherDashboardGetTabularData
                                                            .data!
                                                            .annualHerbicidePending
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
                                                              EdkoAnnualHerbicideTOClosed()));
                                                },
                                                child: DashboardCard(
                                                    cardIcon:
                                                        'assets/Orders_Open.png',
                                                    iconColor: Colors.green,
                                                    cardColor:
                                                        const Color.fromARGB(
                                                            255, 209, 68, 58),
                                                    cardTitle:
                                                        'Annual Herbicide Closed',
                                                    cardCount: (contractorDispatcherDashboardViewModel
                                                                    .contractorDispatcherDashboardGetTabularData
                                                                    .data!
                                                                    .annualHerbicideClosed ==
                                                                null ||
                                                            contractorDispatcherDashboardViewModel
                                                                    .contractorDispatcherDashboardGetTabularData
                                                                    .data!
                                                                    .annualHerbicideClosed
                                                                    .toString() ==
                                                                'null')
                                                        ? ''
                                                        : contractorDispatcherDashboardViewModel
                                                            .contractorDispatcherDashboardGetTabularData
                                                            .data!
                                                            .annualHerbicideClosed
                                                            .toString()),
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
                                  height: size.height * 0.55,
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
                                              "Vegetation Coverage Graph",
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
                                               Expanded(
                                        child: SfCartesianChart(
                                          primaryXAxis: CategoryAxis(
                                            title: AxisTitle(
                                              text: 'MONTH',
                                              textStyle: const TextStyle(
                                                color: Colors.red,
                                                fontFamily: 'Roboto',
                                                fontSize: 14,
                                                fontStyle: FontStyle.italic,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            labelRotation: -45,
                                            edgeLabelPlacement:
                                                EdgeLabelPlacement.shift,
                                          ),
                                          primaryYAxis: NumericAxis(
                                            title: AxisTitle(
                                              text: 'VEGETATION MILES',
                                              textStyle: const TextStyle(
                                                color: Colors.red,
                                                fontFamily: 'Roboto',
                                                fontSize: 14,
                                                fontStyle: FontStyle.italic,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          legend: Legend(
                                            isVisible: true,
                                            position: LegendPosition.top,
                                          ),
                                          tooltipBehavior: _tooltipBehavior,
                                          series:
                                              chartDataMap.entries.map((entry) {
                                            return AreaSeries<ChartDataNew,
                                                String>(
                                              name: entry.key,
                                              dataSource: entry.value,
                                              xValueMapper:
                                                  (ChartDataNew data, _) =>
                                                      data.month,
                                              yValueMapper:
                                                  (ChartDataNew data, _) =>
                                                      data.miles,
                                              color: Colors.blue,
                                              // Line color
                                              borderColor: Colors.blue,

                                              // Area color
                                              gradient: LinearGradient(
                                                colors: [
                                                  Colors.blue.withOpacity(0.4),
                                                  Colors.blue.withOpacity(0.1),
                                                ],
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                              ),

                                              borderWidth: 2,
                                              markerSettings:
                                                  const MarkerSettings(
                                                isVisible: true,
                                              ),
                                              dataLabelSettings:
                                                  const DataLabelSettings(
                                                isVisible: false,
                                              ),
                                              enableTooltip: true,
                                            );
                                          }).toList(),
                                        ),
                                      )
                                 
                                      ////LCP graph
                                      // Expanded(
                                      //   child: SfCartesianChart(
                                      //     primaryXAxis: CategoryAxis(
                                      //       title: AxisTitle(
                                      //           text: 'MONTH',
                                      //           textStyle: const TextStyle(
                                      //               color: Colors.red,
                                      //               fontFamily: 'Roboto',
                                      //               fontSize: 14,
                                      //               fontStyle: FontStyle.italic,
                                      //               fontWeight:
                                      //                   FontWeight.bold)),
                                      //       labelRotation:
                                      //           -45, // Rotate labels if needed
                                      //       edgeLabelPlacement: EdgeLabelPlacement
                                      //           .shift, // Prevent label overlap
                                      //     ),
                                      //     primaryYAxis: NumericAxis(
                                      //       title: AxisTitle(
                                      //           text: 'VEGETATION MILES',
                                      //           textStyle: const TextStyle(
                                      //               color: Colors.red,
                                      //               fontFamily: 'Roboto',
                                      //               fontSize: 14,
                                      //               fontStyle: FontStyle.italic,
                                      //               fontWeight:
                                      //                   FontWeight.bold)),
                                      //     ),
                                      //     legend: Legend(
                                      //         isVisible: true,
                                      //         position: LegendPosition.top),
                                      //     tooltipBehavior: _tooltipBehavior,
                                      //     series:
                                      //         chartDataMap.entries.map((entry) {
                                      //       return LineSeries<ChartDataNew,
                                      //           String>(
                                      //         name: entry.key,
                                      //         dataSource: entry.value,
                                      //         xValueMapper:
                                      //             (ChartDataNew data, _) =>
                                      //                 data.month,
                                      //         yValueMapper:
                                      //             (ChartDataNew data, _) =>
                                      //                 data.miles,
                                      //         color:
                                      //             categoryColors[entry.key] ??
                                      //                 Colors.grey,
                                      //         markerSettings:
                                      //             const MarkerSettings(
                                      //                 isVisible: true),
                                      //         dataLabelSettings:
                                      //             const DataLabelSettings(
                                      //                 isVisible: true),
                                      //         enableTooltip: true,
                                      //       );
                                      //     }).toList(),
                                      //   ),
                                      // ),
                                   
                                    ],
                                  ),
                                ),
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        //  margin:  EdgeInsets.only(
                                        //      top: 10, bottom: 10, left: 8, right: 8),
                                        //  padding:  EdgeInsets.all(8),
                                        alignment: Alignment.center,
                                        height: size.height * 0.8,
                                        width: size.width * 0.99,
                                        decoration: BoxDecoration(
                                            // shape: BoxShape.circle,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            boxShadow: const [
                                              BoxShadow(
                                                  color: AppColors.buttonShadow,
                                                  blurRadius: 10,
                                                  offset: Offset(2.0, 5.0))
                                            ],
                                            gradient: const LinearGradient(
                                              colors: [
                                                Color.fromARGB(
                                                    255, 255, 255, 255),
                                                Color.fromARGB(
                                                    255, 255, 255, 255),
                                              ],
                                            )),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                const Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 8.0, left: 8),
                                                  child: Align(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: Text(
                                                      "Total Record : ",
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                        color:
                                                            AppColors.baseColor,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 20,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 8.0),
                                                  child: Text(
                                                    filteredList.length
                                                        .toString(),
                                                    textAlign: TextAlign.left,
                                                    style: const TextStyle(
                                                      color:
                                                          AppColors.baseColor,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Align(
                                              alignment: Alignment.centerRight,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 4.0,
                                                    right: 4.0,
                                                    top: 4,
                                                    bottom: 4),
                                                child: TextFormField(
                                                  onChanged: (value) =>
                                                      _filterData(value),
                                                  //  key: formkey2,
                                                  controller: _input,
                                                  style: const TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 7, 59, 120),
                                                      fontSize: 16),
                                                  obscureText: false,

                                                  //keyboardType: TextInputType.number,
                                                  decoration:
                                                      const InputDecoration(
                                                    border: OutlineInputBorder(
                                                        // borderRadius:
                                                        //     BorderRadius.circular(25),
                                                        ),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Color.fromARGB(
                                                            255, 23, 1, 88),
                                                      ),
                                                      // borderRadius:
                                                      //     BorderRadius.circular(25),
                                                    ),
                                                    hintText:
                                                        'Search your input...',
                                                  ),
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return "Please search your input";
                                                    } else {
                                                      return null;
                                                    }
                                                  },
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: ListView.builder(
                                                  itemCount:
                                                      filteredList.length,
                                                  itemBuilder:
                                                      (BuildContext ctxt,
                                                          int index) {
                                                    var item =
                                                        filteredList[index];

                                                    return Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  top: 4.0,
                                                                  bottom: 4,
                                                                  left: 4,
                                                                  right: 4),
                                                          child: Container(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.935,
                                                            // height: MediaQuery.of(context)
                                                            //         .size
                                                            //         .height *
                                                            //     0.73,
                                                            // margin:  EdgeInsets.only(
                                                            //     top: 5.0, bottom: 5.0, left: 2,right: 2),
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8),
                                                            decoration:
                                                                BoxDecoration(
                                                              gradient:
                                                                  LinearGradient(
                                                                colors: [
                                                                  AppColors
                                                                      .green1
                                                                      .withOpacity(
                                                                          0.9),
                                                                  AppColors
                                                                      .green2
                                                                      .withOpacity(
                                                                          0.7),
                                                                  AppColors
                                                                      .green1
                                                                      .withOpacity(
                                                                          0.9),
                                                                ],
                                                                begin: Alignment
                                                                    .topLeft,
                                                                end: Alignment
                                                                    .bottomRight,
                                                              ),
                                                              border:
                                                                  Border.all(
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                              borderRadius:
                                                                  const BorderRadius
                                                                      .only(
                                                                topRight: Radius
                                                                    .circular(
                                                                        10),
                                                                bottomRight:
                                                                    Radius
                                                                        .circular(
                                                                            10),
                                                                topLeft: Radius
                                                                    .circular(
                                                                        10),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        10),
                                                              ),
                                                            ),
                                                            child: Column(
                                                                children: [
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                        .only(
                                                                        left:
                                                                            8.0),
                                                                    child: Row(
                                                                      children: [
                                                                        Expanded(
                                                                          child:
                                                                              Column(
                                                                            children: [
                                                                              const Align(
                                                                                alignment: Alignment.topLeft,
                                                                                child: Text(
                                                                                  "EDIT/VIEW: ",
                                                                                  textAlign: TextAlign.left,
                                                                                  style: TextStyle(
                                                                                    fontSize: 12,
                                                                                    fontWeight: FontWeight.bold,
                                                                                    color: Colors.white,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              InkWell(
                                                                                  onTap: () {
                                                                                if (item.budgetType == "Mid Transmission maintenance") {
                                                                                      Navigator.push(
                                                                                          context,
                                                                                          MaterialPageRoute(
                                                                                              builder: (context) => EdkotransHerbicideView(
                                                                                                    tokenNo: item.jobno.toString(),
                                                                                                  )));
                                                                                    } else if (item.type.toString() == "Office") {
                                                                                      Navigator.push(
                                                                                          context,
                                                                                          MaterialPageRoute(
                                                                                              builder: (context) => EdkoAnnualHerbicideEditpageNew(
                                                                                                    jobNo: item.jobno.toString(),
                                                                                                  )));
                                                                                    }
                                                                                  },
                                                                                  child:  Align(
                                                                                    alignment: Alignment.topLeft,
                                                                                    child: Icon(
                                                                                      (item.type.toString() == "Office")?Icons.edit:Icons.visibility,
                                                                                      color: Color.fromARGB(255, 151, 249, 154),
                                                                                    ),
                                                                                  )),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        Expanded(
                                                                          // alignment: Alignment.topLeft,
                                                                          child:
                                                                              Column(
                                                                            children: [
                                                                              const Align(
                                                                                alignment: Alignment.topLeft,
                                                                                child: Text(
                                                                                  "IMAGE: ",
                                                                                  textAlign: TextAlign.left,
                                                                                  style: TextStyle(
                                                                                    fontSize: 12,
                                                                                    fontWeight: FontWeight.bold,
                                                                                    color: Colors.white,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              Align(
                                                                                alignment: Alignment.topLeft,
                                                                                child: InkWell(
                                                                                  onTap: () async {
                                                                                    await contractorDispatcherDashboardViewModel.fetchImageApi(
                                                                                      context,
                                                                                      item.jobno.toString(),
                                                                                    );
                                                                                    await Future.delayed(const Duration(seconds: 2));
                                                                                    openDialogPicture(item.jobno.toString());
                                                                                  },
                                                                                  child: const Align(
                                                                                      alignment: Alignment.topLeft,
                                                                                      child: Icon(
                                                                                        Icons.image,
                                                                                        color: Colors.blue,
                                                                                      )),
                                                                                ),
                                                                              )
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        Expanded(
                                                                          // alignment: Alignment.topLeft,
                                                                          child:
                                                                              Column(
                                                                            children: [
                                                                              const Align(
                                                                                alignment: Alignment.topLeft,
                                                                                child: Text(
                                                                                  "TYPE: ",
                                                                                  textAlign: TextAlign.left,
                                                                                  style: TextStyle(
                                                                                    fontSize: 12,
                                                                                    fontWeight: FontWeight.bold,
                                                                                    color: Colors.white,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              Align(
                                                                                alignment: Alignment.topLeft,
                                                                                child: Text(
                                                                                  (item.type == null || item.type.toString() == 'null') ? '' : item.type.toString(),
                                                                                  textAlign: TextAlign.left,
                                                                                  style: const TextStyle(
                                                                                    fontSize: 12,
                                                                                    //  fontWeight:
                                                                                    //      FontWeight.bold,
                                                                                    color: Colors.white,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  const Divider(
                                                                    color: Colors
                                                                        .grey,
                                                                  ),
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                        .only(
                                                                        left:
                                                                            8.0),
                                                                    child: Row(
                                                                      children: [
                                                                        Expanded(
                                                                          // alignment: Alignment.topLeft,
                                                                          child:
                                                                              Column(
                                                                            children: [
                                                                              const Align(
                                                                                alignment: Alignment.topLeft,
                                                                                child: Text(
                                                                                  "JOB NO: ",
                                                                                  textAlign: TextAlign.left,
                                                                                  style: TextStyle(
                                                                                    fontSize: 12,
                                                                                    fontWeight: FontWeight.bold,
                                                                                    color: Colors.white,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              Align(
                                                                                alignment: Alignment.topLeft,
                                                                                child: Text(
                                                                                  (item.jobno == null || item.jobno.toString() == 'null') ? '' : item.jobno.toString(),
                                                                                  textAlign: TextAlign.left,
                                                                                  style: const TextStyle(
                                                                                    fontSize: 12,
                                                                                    //  fontWeight:
                                                                                    //      FontWeight.bold,
                                                                                    color: Colors.white,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        Expanded(
                                                                          // alignment: Alignment.topLeft,
                                                                          child:
                                                                              Column(
                                                                            children: [
                                                                              const Align(
                                                                                alignment: Alignment.topLeft,
                                                                                child: Text(
                                                                                  "STATUS: ",
                                                                                  textAlign: TextAlign.left,
                                                                                  style: TextStyle(
                                                                                    fontSize: 12,
                                                                                    fontWeight: FontWeight.bold,
                                                                                    color: Colors.white,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              Align(
                                                                                alignment: Alignment.topLeft,
                                                                                child: Text(
                                                                                  (item.status == null || item.status.toString() == 'null') ? '' : item.status.toString(),
                                                                                  textAlign: TextAlign.left,
                                                                                  style: const TextStyle(
                                                                                    fontSize: 12,
                                                                                    //  fontWeight:
                                                                                    //      FontWeight.bold,
                                                                                    color: Colors.white,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        Expanded(
                                                                          // alignment: Alignment.topLeft,
                                                                          child:
                                                                              Column(
                                                                            children: [
                                                                              const Align(
                                                                                alignment: Alignment.topLeft,
                                                                                child: Text(
                                                                                  "SUBSTATION: ",
                                                                                  textAlign: TextAlign.left,
                                                                                  style: TextStyle(
                                                                                    fontSize: 12,
                                                                                    fontWeight: FontWeight.bold,
                                                                                    color: Colors.white,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              Align(
                                                                                alignment: Alignment.topLeft,
                                                                                child: Text(
                                                                                  (item.substation == null || item.substation.toString() == 'null') ? '' : item.substation.toString(),
                                                                                  textAlign: TextAlign.left,
                                                                                  style: const TextStyle(
                                                                                    fontSize: 12,
                                                                                    //  fontWeight:
                                                                                    //      FontWeight.bold,
                                                                                    color: Colors.white,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  const Divider(
                                                                    color: Colors
                                                                        .grey,
                                                                  ),
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                        .only(
                                                                        left:
                                                                            8.0),
                                                                    child: Row(
                                                                      children: [
                                                                        Expanded(
                                                                          // alignment: Alignment.topLeft,
                                                                          child:
                                                                              Column(
                                                                            children: [
                                                                              const Align(
                                                                                alignment: Alignment.topLeft,
                                                                                child: Text(
                                                                                  "FEEDER: ",
                                                                                  textAlign: TextAlign.left,
                                                                                  style: TextStyle(
                                                                                    fontSize: 12,
                                                                                    fontWeight: FontWeight.bold,
                                                                                    color: Colors.white,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              Align(
                                                                                alignment: Alignment.topLeft,
                                                                                child: Text(
                                                                                  (item.feeder == null || item.feeder.toString() == 'null') ? '' : item.feeder.toString(),
                                                                                  textAlign: TextAlign.left,
                                                                                  style: const TextStyle(
                                                                                    fontSize: 12,
                                                                                    //  fontWeight:
                                                                                    //      FontWeight.bold,
                                                                                    color: Colors.white,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        Expanded(
                                                                          // alignment: Alignment.topLeft,
                                                                          child:
                                                                              Column(
                                                                            children: [
                                                                              const Align(
                                                                                alignment: Alignment.topLeft,
                                                                                child: Text(
                                                                                  "MAINTENANCE TYPE: ",
                                                                                  textAlign: TextAlign.left,
                                                                                  style: TextStyle(
                                                                                    fontSize: 12,
                                                                                    fontWeight: FontWeight.bold,
                                                                                    color: Colors.white,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              Align(
                                                                                alignment: Alignment.topLeft,
                                                                                child: Text(
                                                                                  (item.maintenanceType == null || item.maintenanceType.toString() == 'null') ? '' : item.maintenanceType.toString(),
                                                                                  textAlign: TextAlign.left,
                                                                                  style: const TextStyle(
                                                                                    fontSize: 12,
                                                                                    //  fontWeight:
                                                                                    //      FontWeight.bold,
                                                                                    color: Colors.white,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        Expanded(
                                                                          // alignment: Alignment.topLeft,
                                                                          child:
                                                                              Column(
                                                                            children: [
                                                                              const Align(
                                                                                alignment: Alignment.topLeft,
                                                                                child: Text(
                                                                                  "CONTRACTOR: ",
                                                                                  textAlign: TextAlign.left,
                                                                                  style: TextStyle(
                                                                                    fontSize: 12,
                                                                                    fontWeight: FontWeight.bold,
                                                                                    color: Colors.white,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              Align(
                                                                                alignment: Alignment.topLeft,
                                                                                child: Text(
                                                                                  (item.contractor == null || item.contractor.toString() == 'null') ? '' : item.contractor.toString(),
                                                                                  textAlign: TextAlign.left,
                                                                                  style: const TextStyle(
                                                                                    fontSize: 12,
                                                                                    //  fontWeight:
                                                                                    //      FontWeight.bold,
                                                                                    color: Colors.white,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  const Divider(
                                                                    color: Colors
                                                                        .grey,
                                                                  ),
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                        .only(
                                                                        left:
                                                                            8.0),
                                                                    child: Row(
                                                                      children: [
                                                                        Expanded(
                                                                          // alignment: Alignment.topLeft,
                                                                          child:
                                                                              Column(
                                                                            children: [
                                                                              const Align(
                                                                                alignment: Alignment.topLeft,
                                                                                child: Text(
                                                                                  "TOTAL MILES: ",
                                                                                  textAlign: TextAlign.left,
                                                                                  style: TextStyle(
                                                                                    fontSize: 12,
                                                                                    fontWeight: FontWeight.bold,
                                                                                    color: Colors.white,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              Align(
                                                                                alignment: Alignment.topLeft,
                                                                                child: Text(
                                                                                  (item.totalMiles == null || item.totalMiles.toString() == 'null') ? '' : item.totalMiles.toString(),
                                                                                  textAlign: TextAlign.left,
                                                                                  style: const TextStyle(
                                                                                    fontSize: 12,
                                                                                    //  fontWeight:
                                                                                    //      FontWeight.bold,
                                                                                    color: Colors.white,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        Expanded(
                                                                          // alignment: Alignment.topLeft,
                                                                          child:
                                                                              Column(
                                                                            children: [
                                                                              const Align(
                                                                                alignment: Alignment.topLeft,
                                                                                child: Text(
                                                                                  "CONTRACT YEAR: ",
                                                                                  textAlign: TextAlign.left,
                                                                                  style: TextStyle(
                                                                                    fontSize: 12,
                                                                                    fontWeight: FontWeight.bold,
                                                                                    color: Colors.white,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              Align(
                                                                                alignment: Alignment.topLeft,
                                                                                child: Text(
                                                                                  (item.contractYear == null || item.contractYear.toString() == 'null') ? '' : formattedContractYear,
                                                                                  textAlign: TextAlign.left,
                                                                                  style: const TextStyle(
                                                                                    fontSize: 12,
                                                                                    //  fontWeight:
                                                                                    //      FontWeight.bold,
                                                                                    color: Colors.white,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        Expanded(
                                                                          // alignment: Alignment.topLeft,
                                                                          child:
                                                                              Column(
                                                                            children: [
                                                                              const Align(
                                                                                alignment: Alignment.topLeft,
                                                                                child: Text(
                                                                                  "CYCLE: ",
                                                                                  textAlign: TextAlign.left,
                                                                                  style: TextStyle(
                                                                                    fontSize: 12,
                                                                                    fontWeight: FontWeight.bold,
                                                                                    color: Colors.white,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              Align(
                                                                                alignment: Alignment.topLeft,
                                                                                child: Text(
                                                                                  (item.cycle == null || item.cycle.toString() == 'null') ? '' : item.cycle.toString(),
                                                                                  textAlign: TextAlign.left,
                                                                                  style: const TextStyle(
                                                                                    fontSize: 12,
                                                                                    //  fontWeight:
                                                                                    //      FontWeight.bold,
                                                                                    color: Colors.white,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  const Divider(
                                                                    color: Colors
                                                                        .grey,
                                                                  ),
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                        .only(
                                                                        left:
                                                                            8.0),
                                                                    child: Row(
                                                                      children: [
                                                                        Expanded(
                                                                          // alignment: Alignment.topLeft,
                                                                          child:
                                                                              Column(
                                                                            children: [
                                                                              const Align(
                                                                                alignment: Alignment.topLeft,
                                                                                child: Text(
                                                                                  "SERVICE STREET ADDRESS: ",
                                                                                  textAlign: TextAlign.left,
                                                                                  style: TextStyle(
                                                                                    fontSize: 12,
                                                                                    fontWeight: FontWeight.bold,
                                                                                    color: Colors.white,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              Align(
                                                                                alignment: Alignment.topLeft,
                                                                                child: Text(
                                                                                  (item.serviceStreetAddress == null || item.serviceStreetAddress.toString() == 'null') ? '' : item.serviceStreetAddress.toString(),
                                                                                  textAlign: TextAlign.left,
                                                                                  style: const TextStyle(
                                                                                    fontSize: 12,
                                                                                    //  fontWeight:
                                                                                    //      FontWeight.bold,
                                                                                    color: Colors.white,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        Expanded(
                                                                          // alignment: Alignment.topLeft,
                                                                          child:
                                                                              Column(
                                                                            children: [
                                                                              const Align(
                                                                                alignment: Alignment.topLeft,
                                                                                child: Text(
                                                                                  "SERVICE MAP LOCATION: ",
                                                                                  textAlign: TextAlign.left,
                                                                                  style: TextStyle(
                                                                                    fontSize: 12,
                                                                                    fontWeight: FontWeight.bold,
                                                                                    color: Colors.white,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              Align(
                                                                                alignment: Alignment.topLeft,
                                                                                child: Text(
                                                                                  (item.serviceMapLocation == null || item.serviceMapLocation.toString() == 'null') ? '' : item.serviceMapLocation.toString(),
                                                                                  textAlign: TextAlign.left,
                                                                                  style: const TextStyle(
                                                                                    fontSize: 12,
                                                                                    //  fontWeight:
                                                                                    //      FontWeight.bold,
                                                                                    color: Colors.white,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        Expanded(
                                                                          // alignment: Alignment.topLeft,
                                                                          child:
                                                                              Column(
                                                                            children: [
                                                                              const Align(
                                                                                alignment: Alignment.topLeft,
                                                                                child: Text(
                                                                                  "GENERAL FOREMAN NOTES 1: ",
                                                                                  textAlign: TextAlign.left,
                                                                                  style: TextStyle(
                                                                                    fontSize: 12,
                                                                                    fontWeight: FontWeight.bold,
                                                                                    color: Colors.white,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              Align(
                                                                                alignment: Alignment.topLeft,
                                                                                child: Text(
                                                                                  (item.generalForemanNotes1 == null || item.generalForemanNotes1.toString() == 'null') ? '' : item.generalForemanNotes1.toString(),
                                                                                  textAlign: TextAlign.left,
                                                                                  style: const TextStyle(
                                                                                    fontSize: 12,
                                                                                    //  fontWeight:
                                                                                    //      FontWeight.bold,
                                                                                    color: Colors.white,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  const Divider(
                                                                    color: Colors
                                                                        .grey,
                                                                  ),
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                        .only(
                                                                        left:
                                                                            8.0),
                                                                    child: Row(
                                                                      children: [
                                                                        Expanded(
                                                                          // alignment: Alignment.topLeft,
                                                                          child:
                                                                              Column(
                                                                            children: [
                                                                              const Align(
                                                                                alignment: Alignment.topLeft,
                                                                                child: Text(
                                                                                  "GENERAL FOREMAN NOTES 2: ",
                                                                                  textAlign: TextAlign.left,
                                                                                  style: TextStyle(
                                                                                    fontSize: 12,
                                                                                    fontWeight: FontWeight.bold,
                                                                                    color: Colors.white,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              Align(
                                                                                alignment: Alignment.topLeft,
                                                                                child: Text(
                                                                                  (item.generalForemanNotes2 == null || item.generalForemanNotes2.toString() == 'null') ? '' : item.generalForemanNotes2.toString(),
                                                                                  textAlign: TextAlign.left,
                                                                                  style: const TextStyle(
                                                                                    fontSize: 12,
                                                                                    //  fontWeight:
                                                                                    //      FontWeight.bold,
                                                                                    color: Colors.white,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),

                                                                        Expanded(
                                                                          // alignment: Alignment.topLeft,
                                                                          child:
                                                                              Column(
                                                                            children: [
                                                                              const Align(
                                                                                alignment: Alignment.topLeft,
                                                                                child: Text(
                                                                                  "ADMIN NOTES 1: ",
                                                                                  textAlign: TextAlign.left,
                                                                                  style: TextStyle(
                                                                                    fontSize: 12,
                                                                                    fontWeight: FontWeight.bold,
                                                                                    color: Colors.white,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              Align(
                                                                                alignment: Alignment.topLeft,
                                                                                child: Text(
                                                                                  (item.adminNotes == null || item.adminNotes.toString() == 'null') ? '' : item.adminNotes.toString(),
                                                                                  textAlign: TextAlign.left,
                                                                                  style: const TextStyle(
                                                                                    fontSize: 12,
                                                                                    //  fontWeight:
                                                                                    //      FontWeight.bold,
                                                                                    color: Colors.white,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        // Expanded(
                                                                        //   // alignment: Alignment.topLeft,
                                                                        //   child:
                                                                        //       Column(
                                                                        //     children: [
                                                                        //       const Align(
                                                                        //         alignment: Alignment.topLeft,
                                                                        //         child: Text(
                                                                        //           "ADMIN NOTES 2: ",
                                                                        //           textAlign: TextAlign.left,
                                                                        //           style: TextStyle(
                                                                        //             fontSize: 12,
                                                                        //             fontWeight: FontWeight.bold,
                                                                        //             color: Colors.white,
                                                                        //           ),
                                                                        //         ),
                                                                        //       ),
                                                                        //       Align(
                                                                        //         alignment: Alignment.topLeft,
                                                                        //         child: Text(
                                                                        //           (item.adminNotes2 == null || item.adminNotes2.toString() == 'null') ? '' : item.adminNotes2.toString(),
                                                                        //           textAlign: TextAlign.left,
                                                                        //           style: const TextStyle(
                                                                        //             fontSize: 12,
                                                                        //             //  fontWeight:
                                                                        //             //      FontWeight.bold,
                                                                        //             color: Colors.white,
                                                                        //           ),
                                                                        //         ),
                                                                        //       ),
                                                                        //     ],
                                                                        //   ),
                                                                        // ),

                                                                        Expanded(
                                                                          // alignment: Alignment.topLeft,
                                                                          child:
                                                                              Column(
                                                                            children: [
                                                                              const Align(
                                                                                alignment: Alignment.topLeft,
                                                                                child: Text(
                                                                                  "CONTRACTOR COMPANY: ",
                                                                                  textAlign: TextAlign.left,
                                                                                  style: TextStyle(
                                                                                    fontSize: 12,
                                                                                    fontWeight: FontWeight.bold,
                                                                                    color: Colors.white,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              Align(
                                                                                alignment: Alignment.topLeft,
                                                                                child: Text(
                                                                                  (item.contractorCompany == null || item.contractorCompany.toString() == 'null') ? '' : item.contractorCompany.toString(),
                                                                                  textAlign: TextAlign.left,
                                                                                  style: const TextStyle(
                                                                                    fontSize: 12,
                                                                                    //  fontWeight:
                                                                                    //      FontWeight.bold,
                                                                                    color: Colors.white,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  const Divider(
                                                                    color: Colors
                                                                        .grey,
                                                                  ),
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                        .only(
                                                                        left:
                                                                            8.0),
                                                                    child: Row(
                                                                      children: [
                                                                        // Expanded(
                                                                        //   // flex:
                                                                        //   //     2,
                                                                        //   // alignment: Alignment.topLeft,
                                                                        //   child:
                                                                        //       Column(
                                                                        //     children: [
                                                                        //       const Align(
                                                                        //         alignment: Alignment.topLeft,
                                                                        //         child: Text(
                                                                        //           "ESTIMATED TIME: ",
                                                                        //           textAlign: TextAlign.left,
                                                                        //           style: TextStyle(
                                                                        //             fontSize: 12,
                                                                        //             fontWeight: FontWeight.bold,
                                                                        //             color: Colors.white,
                                                                        //           ),
                                                                        //         ),
                                                                        //       ),
                                                                        //       Align(
                                                                        //         alignment: Alignment.topLeft,
                                                                        //         child: Text(
                                                                        //           (item.est == null || item.estTime.toString() == 'null') ? '' : item.estTime.toString(),
                                                                        //           textAlign: TextAlign.left,
                                                                        //           style: const TextStyle(
                                                                        //             fontSize: 12,
                                                                        //             //  fontWeight:
                                                                        //             //      FontWeight.bold,
                                                                        //             color: Colors.white,
                                                                        //           ),
                                                                        //         ),
                                                                        //       ),
                                                                        //     ],
                                                                        //   ),
                                                                        // ),

                                                                        Expanded(
                                                                          // alignment: Alignment.topLeft,
                                                                          child:
                                                                              Column(
                                                                            children: [
                                                                              const Align(
                                                                                alignment: Alignment.topLeft,
                                                                                child: Text(
                                                                                  "DATE OF INSPECTION: ",
                                                                                  textAlign: TextAlign.left,
                                                                                  style: TextStyle(
                                                                                    fontSize: 12,
                                                                                    fontWeight: FontWeight.bold,
                                                                                    color: Colors.white,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              Align(
                                                                                alignment: Alignment.topLeft,
                                                                                child: Text(
                                                                                  (item.dateOfInspection == null || item.dateOfInspection.toString() == 'null') ? '' : formatDateIfNeeded(item.dateOfInspection.toString()),
                                                                                  textAlign: TextAlign.left,
                                                                                  style: const TextStyle(
                                                                                    fontSize: 12,
                                                                                    //  fontWeight:
                                                                                    //      FontWeight.bold,
                                                                                    color: Colors.white,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        Expanded(
                                                                          // alignment: Alignment.topLeft,
                                                                          child:
                                                                              Column(
                                                                            children: [
                                                                              const Align(
                                                                                alignment: Alignment.topLeft,
                                                                                child: Text(
                                                                                  "FOLLOW UP DATE: ",
                                                                                  textAlign: TextAlign.left,
                                                                                  style: TextStyle(
                                                                                    fontSize: 12,
                                                                                    fontWeight: FontWeight.bold,
                                                                                    color: Colors.white,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              Align(
                                                                                alignment: Alignment.topLeft,
                                                                                child: Text(
                                                                                  (item.followUpDate == null || item.followUpDate.toString() == 'null') ? '' : formatDateIfNeeded(item.followUpDate.toString()),
                                                                                  textAlign: TextAlign.left,
                                                                                  style: const TextStyle(
                                                                                    fontSize: 12,
                                                                                    //  fontWeight:
                                                                                    //      FontWeight.bold,
                                                                                    color: Colors.white,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                                  Expanded(
                                                                          // alignment: Alignment.topLeft,
                                                                          child:
                                                                              Column(
                                                                            children: [
                                                                              const Align(
                                                                                alignment: Alignment.topLeft,
                                                                                child: Text(
                                                                                  "NEXT MAINT DUE: ",
                                                                                  textAlign: TextAlign.left,
                                                                                  style: TextStyle(
                                                                                    fontSize: 12,
                                                                                    fontWeight: FontWeight.bold,
                                                                                    color: Colors.white,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              Align(
                                                                                alignment: Alignment.topLeft,
                                                                                child: Text(
                                                                                  (item.nextMaintDue == null || item.nextMaintDue.toString() == '0' || item.nextMaintDue.toString() == 'null') ? '' : getYearOrNA(item.nextMaintDue.toString()),
                                                                                  textAlign: TextAlign.left,
                                                                                  style: const TextStyle(
                                                                                    fontSize: 12,
                                                                                    //  fontWeight:
                                                                                    //      FontWeight.bold,
                                                                                    color: Colors.white,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                   
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  const Divider(
                                                                    color: Colors
                                                                        .grey,
                                                                  ),
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                        .only(
                                                                        left:
                                                                            8.0),
                                                                    child: Row(
                                                                      children: [
                                                                   Expanded(
                                                                          // flex:
                                                                          //     2,
                                                                          // alignment: Alignment.topLeft,
                                                                          child:
                                                                              Column(
                                                                            children: [
                                                                              const Align(
                                                                                alignment: Alignment.topLeft,
                                                                                child: Text(
                                                                                  "CREATE DATE: ",
                                                                                  textAlign: TextAlign.left,
                                                                                  style: TextStyle(
                                                                                    fontSize: 12,
                                                                                    fontWeight: FontWeight.bold,
                                                                                    color: Colors.white,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              Align(
                                                                                alignment: Alignment.topLeft,
                                                                                child: Text(
                                                                                  (item.createDate == null || item.createDate.toString() == 'null') ? '' : formatDateIfNeeded(item.createDate.toString()),
                                                                                  textAlign: TextAlign.left,
                                                                                  style: const TextStyle(
                                                                                    fontSize: 12,
                                                                                    //  fontWeight:
                                                                                    //      FontWeight.bold,
                                                                                    color: Colors.white,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  // const Divider(
                                                                  //   color: Colors
                                                                  //       .grey,
                                                                  // ),
                                                                  const Padding(
                                                                    padding: EdgeInsets
                                                                        .only(
                                                                            left:
                                                                                8.0),
                                                                    child: Row(
                                                                      children: [],
                                                                    ),
                                                                  ),
                                                                ]),
                                                          ),
                                                        ),
                                                      ],
                                                    );
                                                  }),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );

                    default:
                      return const Text('data');
                  }
                }))));
  }

  List<_ChartDataSimpleColumnChart1> recreateGraphData(
      ContractorDispatcherDashboardViewModel value) {
    chartDataSimpleColumnChart1.clear();
    for (var i = 0;
        i <
            contractorDispatcherDashboardViewModel
                .contractorDispatcherDashboardGetTabularData
                .data!
                .findMonthAndMiles!
                .length;
        i++) {
      chartDataSimpleColumnChart1.add(_ChartDataSimpleColumnChart1(
          (contractorDispatcherDashboardViewModel.contractorDispatcherDashboardGetTabularData.data!.findMonthAndMiles![i].month == null ||
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
                  contractorDispatcherDashboardViewModel.contractorDispatcherDashboardGetTabularData.data!.findMonthAndMiles![i].miles.toString() == 'null')
              ? 0.0
              : double.parse(contractorDispatcherDashboardViewModel.contractorDispatcherDashboardGetTabularData.data!.findMonthAndMiles![i].miles.toString())));
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

  Future<void> _filterData(String query) async {
    if (query.isEmpty) {
      // Reset full list when search is empty
      setState(() {
        filteredList = dataList;
      });
    } else {
      setState(() {
        filteredList = dataList.where((item) {
          final type = item.type?.toLowerCase() ?? '';
          final tokenNo = item.jobno?.toString().toLowerCase() ?? '';
          final status = item.status?.toString().toLowerCase() ?? '';
          final substation = item.jobno?.toString().toLowerCase() ?? '';
          final feeder = item.jobno?.toString().toLowerCase() ?? '';
             final budgetType = item.budgetType?.toString().toLowerCase() ?? '';
             final annualHerbicide= item.annualHerbicide?.toString().toLowerCase() ?? '';


          return type.contains(query.toLowerCase()) ||
              tokenNo.contains(query.toLowerCase()) ||
              status.contains(query.toLowerCase()) ||
              substation.contains(query.toLowerCase()) ||
              feeder.contains(query.toLowerCase())
               ||
              budgetType.contains(query.toLowerCase())
                  ||
              annualHerbicide.contains(query.toLowerCase());
        }).toList();
      });
    }
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

  Future openDialogPicture(String tokenNo) => showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            // lCPWorkOrdersClosedViewModel.fetchImageApi(
            //     context,
            //     //  '1');
            //     tokenNo.toString());
            int length = contractorDispatcherDashboardViewModel
                    .imageData.data?.images?.length ??
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
                              color: AppColors.baseColor,
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
          });
        },
      );

  Widget buildImageWidget(int i, String tokenNo) {
    String? fileLocation = contractorDispatcherDashboardViewModel
        .imageData.data?.images![i].imageLocation;

    bool isVideo(String file) {
      return file.endsWith('.mp4') || file.endsWith('.mov');
    }

    return Expanded(
      child: (fileLocation != null)
          ? Container(
              //  margin: const EdgeInsets.only(top:8, bottom:8),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 2,
                ),
              ),
              child: Stack(
                children: [
                  if (isPDF(fileLocation))
                    Center(
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) => PDFViewer(
                                  pdfUrl:
                                      'https://pemccivm.ariespro.com/assets/clientuploads/$fileLocation')));
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
                              5), // Optional rounded corners
                          child: SizedBox(
                            height: 150,
                            width: double.infinity,
                            child: VideoPlayerWidget(
                              videoUrl:
                                  'https://pemccivm.ariespro.com/assets/clientuploads/$fileLocation',
                            ),
                          ),
                        ))
                  else
                    InkWell(
                      onTap: () {
                        openFullSizeImageDialog(fileLocation);
                      },
                      child: Image.network(
                        'https://pemccivm.ariespro.com/assets/clientuploads/$fileLocation',
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
                                  'https://pemccivm.ariespro.com/assets/clientuploads/$fileLocation',
                                  'File',context);
                              Navigator.pop(context);
                            } else {
                              downloadFile(
                                  'https://pemccivm.ariespro.com/assets/clientuploads/$fileLocation',
                                  'PDF',context);
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
                  color: AppColors.baseColor,
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
                backgroundDecoration: const BoxDecoration(
                  color: Colors.black,
                ),
                onPageChanged: (index) {},
                scrollPhysics: const BouncingScrollPhysics(),
                pageOptions: [
                  PhotoViewGalleryPageOptions(
                    imageProvider: NetworkImage(
                      'https://pemccivm.ariespro.com/assets/clientuploads/$imageUrl',
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
        '${AppUrl.baseUrl}changeOrderLcpCreateOrder/deleteFile?fileName=$fileName&tokenNo=$tokenNo';
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
            'Image deleted Successfully', context);
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
    getInitData();
    print('object');
    print(data.user!.id.toString());
  }

  void dateFormatNew(
    int index,
  ) {
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

  Future<void> getInitData() async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    setState(() {});
    contractorId = '${data.user!.id}';
    print('contractorId${contractorId}');
    contractorDispatcherDashboardViewModel
        .fetchContractorDispatcherDashboardTabularListApi(
            context, contractorId, '');
    fetchChartData();
    _tooltipBehavior = TooltipBehavior(
      enable: true,
      format: 'point.x : point.y miles', // Ensure proper formatting
    );
  }

  Future<void> fetchChartData() async {
    final String apiUrl =
        "${AppUrl.baseUrl}contractorDashboard/contractorDisPacherPageData?contractorId=$contractorId";
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
    if (data.containsKey("findMonthAndMiles")) {
      final List<dynamic> extractedData = data["findMonthAndMiles"];

      chartDataMap.clear();
      categories.clear();

      // Sort months
      extractedData.sort((a, b) => _convertMonthToDate(a["month"])
          .compareTo(_convertMonthToDate(b["month"])));

      // Create chart data
      List<ChartDataNew> chartData = extractedData.map((entry) {
        return ChartDataNew(
          entry["month"].toString(),
          // int.parse(entry["miles"].toString()),
            // FIX HERE
        double.parse(entry["miles"].toString()),
        );
      }).toList();

      // Add single series
      chartDataMap["Miles"] = chartData;

      categories.add("Miles");

      setState(() {});
    }
  }

////LCP graph method
  // void parseChartData(Map<String, dynamic> data) {
  //   if (data.containsKey("findMonthMilesByRowMethod")) {
  //     final extractedData = data["findMonthMilesByRowMethod"];

  //     chartDataMap.clear();
  //     categories.clear();
  //     uniqueMonths.clear();

  //     extractedData.forEach((category, entries) {
  //       if (category.isEmpty ||
  //           entries == null ||
  //           (entries is List && entries.isEmpty)) {
  //         return;
  //       }
  //       for (var entry in entries) {
  //         uniqueMonths.add(entry["month"]);
  //       }
  //     });
  //     print('uniqueMonths${uniqueMonths}');
  //     sortedMonths = uniqueMonths.toList()
  //       ..sort(
  //           (a, b) => _convertMonthToDate(a).compareTo(_convertMonthToDate(b)));
  //     print('sortedMonths${sortedMonths}');

  //     extractedData.forEach((category, entries) {
  //       if (category.isEmpty ||
  //           entries == null ||
  //           (entries is List && entries.isEmpty)) {
  //         return;
  //       }
  //       Map<String, int> monthMilesMap = {}; // Store miles for each month
  //       for (var entry in entries) {
  //         monthMilesMap[entry["month"]] = entry["total miles"];
  //       }

  //       List<ChartDataNew> chartData = sortedMonths.map((month) {
  //         return ChartDataNew(month, monthMilesMap[month] ?? 0);
  //       }).toList();

  //       if (chartData.isNotEmpty) {
  //         chartDataMap[category] = chartData;
  //         categories.add(category);
  //       }
  //     });

  //     setState(() {}); // Refresh UI
  //   }
  // }

  /// **Helper function to convert month strings to DateTime for sorting**
  /// LCP graph
  // DateTime _convertMonthToDate(String monthString) {
  //   List<String> parts = monthString.split('/');
  //   return DateTime(
  //       int.parse(parts[1]), int.parse(parts[0])); // Format: MM/YYYY
  // }
 DateTime _convertMonthToDate(String monthYear) {
    final parts = monthYear.split('/');

    int month = int.parse(parts[0]);
    int year = int.parse(parts[1]);

    return DateTime(year, month);
  }
//----

  String id = '';
  Future<void> fetchListData() async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    id = data.user!.id.toString();
    var url =
        "${AppUrl.baseUrl}rowVegetationManagementDashboard/gf2Datalist?contractorId=$id";

    print('dashboard list api url::: $url');

    var headers = {
      "Content-Type": "application/json",
      // "Authorization": "Bearer $token", //  Add this line
      "Authorization": 'Bearer ${data.token!}'
    };

    try {
      var response = await http.get(
        Uri.parse(url),
        headers: headers,
      );

      if (response.statusCode == 200) {
        print(" API Success:");
        print(response.body);

        var data = jsonDecode(response.body);

        List list = data["gettabledata"] ?? [];

        setState(() {
          dataList =
              list.map((e) => GfEdkoDashboardDatadata.fromJson(e)).toList();

          filteredList = dataList;
          // isError = false;
        });

        print(data["success"]);
      } else {
        print("❌ API Error: ${response.statusCode}");
        print(response.body);
        setState(() {
          //  isError = true;
        });
      }
    } catch (e) {
      setState(() {
        // isError = true;
      });
      print("❌ Exception: $e");
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
                      Navigator.pop(context);
                    },
                  ),
                  // ListTile(
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
                      // Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (BuildContext context) =>
                      //         const ChangeOrderContractor()));
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const EdkoInspection()));
                    },
                  ),
                  ListTile(
                    leading: Icon(
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
      'https://pemccivm.ariespro.com/assets/clientuploads/${data.user!.profilePhoto}',
    );
    String imageUrl =
        'https://pemccivm.ariespro.com/assets/clientuploads/${data.user!.profilePhoto}';
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
        padding:
            const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
        alignment: Alignment.center,
        //  width: size.width * 0.418,
        height: 95,
        //MediaQuery.of(context).size.height * 0.12,
        decoration: BoxDecoration(
          color: widget.cardColor,
          // shape: BoxShape.circle,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
                color: Colors.black, blurRadius: 5, offset: Offset(0.0, 2.0))
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
                  fontWeight: FontWeight.bold),
            ),
            Text(
              widget.cardCount,
              style: const TextStyle(
                  fontSize: 18,
                 color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ));
  }
}
