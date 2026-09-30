// import 'package:CIVM/piedmont/screens/admin_pannel/map_view_admin.dart';
import 'dart:convert';

import 'package:CIVM/piedmont/models/admin_dashboard_data_list_model.dart';
import 'package:CIVM/piedmont/models/graph_vegetation_management_dashboard.dart';
import 'package:CIVM/piedmont/models/vegetation_management_dashboard_model.dart';
import 'package:CIVM/piedmont/repository/map_url.dart';
import 'package:CIVM/piedmont/resources/app_colors.dart';
import 'package:CIVM/piedmont/resources/app_url.dart';
import 'package:CIVM/piedmont/screens/admin_pannel/pemc_admin_new/adm_job_list_annual_Herbicide_view.dart';
import 'package:CIVM/piedmont/screens/admin_pannel/pemc_admin_new/adm_job_list_distri_IVM_view.dart';
import 'package:CIVM/piedmont/screens/admin_pannel/pemc_admin_new/adm_job_list_trans_Herbicide_view.dart';
import 'package:CIVM/piedmont/screens/admin_pannel/pemc_admin_new/adm_job_list_trans_IVM_view.dart';
import 'package:CIVM/piedmont/screens/admin_pannel/pemc_admin_new/adm_job_list_work_order_view.dart';

import 'package:CIVM/piedmont/screens/my_chrome_safari_map_recording.dart';
import 'package:CIVM/piedmont/utils/common_functions.dart';
import 'package:CIVM/utils/user_pref.dart';
import 'package:CIVM/models/user_model.dart';
import 'package:CIVM/piedmont/view_model/vegetation_management_dashboard_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'package:primer_progress_bar/primer_progress_bar.dart';
import 'package:provider/provider.dart';
import 'package:tiny_charts/tiny_charts.dart';
import '../../../data/response/status.dart';
import '../../../view_model/row_maintenance_plan_dashboard_view_model.dart';
import 'package:http/http.dart' as http;
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';

// ignore: must_be_immutable
class RowMaintenancePlanDashboard extends StatefulWidget {
  const RowMaintenancePlanDashboard({Key? key}) : super(key: key);

  @override
  State<RowMaintenancePlanDashboard> createState() =>
      _RowMaintenancePlanDashboardState();
}

class _RowMaintenancePlanDashboardState
    extends State<RowMaintenancePlanDashboard> {
  final TextEditingController _input = TextEditingController();
  late final Future? myFuture;
  var result = [];
  List<ChartData> pieChartData = [];

  final browser = MyChromeSafariBrowser();
  // late TooltipBehavior _tooltipBehavior = TooltipBehavior(enable: true);
  // late ZoomPanBehavior _zoomPanBehavior;

  List<Map<String, dynamic>> listOfColumns = [];
  List<Map<String, dynamic>> listOfColumns1 = [];

  RowMaintenancePlanViewModel rowMaintenancePlanViewModel =
      RowMaintenancePlanViewModel();

  bool? _selectJaraffMowingNoSpray = true;
  bool? _selectSpray = true;
  bool? _selectMowing = true;
  bool? _selectMowingNoSpray = true;
  bool? _selectJaraffMowingSprayWork = true;
  bool? _selectGroundWork = true;
  bool? _selectBucketWork = true;

  List<GraphVegetationManagementDashboard> dataset = [];
  var _parentSetState;

  VegetationManagementDashboardViewModel
      vegetationManagementDashboardViewModel =
      VegetationManagementDashboardViewModel();

  int loadingFlag = 0;

  int uniqueDataCount = 0;

  String dynamicYear = '';

  int currentYear = DateTime.now().year;
  String? year;
  List<AdminDashboardDataListdata> dataList = [];
  List<AdminDashboardDataListdata> filteredList = [];
  @override
  void initState() {
    fetchData();
    rowMaintenancePlanViewModel.fetchProgressBarRowMaintDataApi(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    _parentSetState = setState;
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: ChangeNotifierProvider<RowMaintenancePlanViewModel>(
            create: (BuildContext context) => rowMaintenancePlanViewModel,
            child: Consumer<RowMaintenancePlanViewModel>(
                builder: (context, value, _) {
              switch (value.rowMaintenancePlanGetData.status) {
                case Status.LOADING:
                  return const Center(child: CircularProgressIndicator());
                case Status.ERROR:
                  return
                      // CustomToastSnackBarProgressDialog.flushBarErrorMessage(
                      //     value.rowMaintenancePlanGetData.message.toString(),
                      //     context);
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
                  dynamicYear = currentYear.toString();
                  year = currentYear.toString();
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
                          currentYear.toString(),
                          '',
                          '',
                          '');
                  _recreateDataMain();
                  // _recreateDataCopyFilter();

                  print('bhbjhnjnj');
                  if (loadingFlag == 0) {
                    loadGraphData();
                  }

                  return RefreshIndicator(
                    onRefresh: () async {
                      _input.clear();
                      await rowMaintenancePlanViewModel
                          .fetchProgressBarRowMaintDataApi(context);
                    },
                    child: SingleChildScrollView(
                      child: Center(
                        child: Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(
                                  left: 8, right: 8, top: 10, bottom: 8),
                              padding: const EdgeInsets.all(8),
                              alignment: Alignment.center,
                              // height: size.height * 0.5,
                              width: size.width * 0.99,
                              decoration: BoxDecoration(
                                  // shape: BoxShape.circle,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: AppColors.baseColor,
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
                                    height: 50,
                                    decoration: const BoxDecoration(
                                        // shape: BoxShape.circle,
                                        //borderRadius: BorderRadius.circular(25),
                                        boxShadow: [
                                          BoxShadow(
                                              color: AppColors.buttonShadow,
                                              blurRadius: 5,
                                              offset: Offset(2.0, 5.0))
                                        ],
                                        color:
                                            Color.fromARGB(255, 130, 193, 245),
                                        gradient: LinearGradient(
                                          colors: [
                                            AppColors.baseColor,
                                            AppColors.buttonOrange,
                                            AppColors.baseColor,
                                          ],
                                        )),
                                    child: const Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Progress Bars ",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      const Padding(
                                        padding:
                                            EdgeInsets.only(top: 8.0, left: 8),
                                        child: Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            "PENDING: ",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              color: AppColors.baseColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: Text(
                                          (value
                                                      .rowMaintenancePlanGetData
                                                      .data!
                                                      .costTotalMilesMilesCmpltedMilesInProgressMilesPending![
                                                          0]
                                                      .milesPending
                                                      .toString()
                                                      .isEmpty ||
                                                  value
                                                          .rowMaintenancePlanGetData
                                                          .data!
                                                          .costTotalMilesMilesCmpltedMilesInProgressMilesPending![
                                                              0]
                                                          .milesPending ==
                                                      null)
                                              ? '0%'
                                              : '${value.rowMaintenancePlanGetData.data!.costTotalMilesMilesCmpltedMilesInProgressMilesPending![0].milesPending.toString()}%',
                                          textAlign: TextAlign.left,
                                          style: const TextStyle(
                                            color: AppColors.baseColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  TinyBarChart.stacked(
                                    data: <double>[
                                      double.parse(value
                                              .rowMaintenancePlanGetData
                                              .data!
                                              .costTotalMilesMilesCmpltedMilesInProgressMilesPending![
                                                  0]
                                              .milesPending
                                              ?.toString() ??
                                          '0.0'),
                                      100.00 -
                                          double.parse(value
                                                  .rowMaintenancePlanGetData
                                                  .data!
                                                  .costTotalMilesMilesCmpltedMilesInProgressMilesPending![
                                                      0]
                                                  .milesPending
                                                  ?.toString() ??
                                              '0.0')
                                    ],
                                    options: const TinyBarChartOptions(
                                      colors: [
                                        Color.fromARGB(255, 60, 200, 243),
                                        Color.fromARGB(255, 222, 220, 220),
                                      ],
                                    ),
                                    width: size.width * 0.9,
                                    height: 28,
                                  ),
                                  Row(
                                    children: [
                                      const Padding(
                                        padding:
                                            EdgeInsets.only(top: 8.0, left: 8),
                                        child: Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            "IN PROGRESS: ",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              color: AppColors.baseColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: Text(
                                          (value
                                                      .rowMaintenancePlanGetData
                                                      .data!
                                                      .costTotalMilesMilesCmpltedMilesInProgressMilesPending![
                                                          0]
                                                      .milesInProgress
                                                      .toString()
                                                      .isEmpty ||
                                                  value
                                                          .rowMaintenancePlanGetData
                                                          .data!
                                                          .costTotalMilesMilesCmpltedMilesInProgressMilesPending![
                                                              0]
                                                          .milesInProgress ==
                                                      null)
                                              ? '0%'
                                              : '${value.rowMaintenancePlanGetData.data!.costTotalMilesMilesCmpltedMilesInProgressMilesPending![0].milesInProgress.toString()}%',
                                          // "18.48%",
                                          textAlign: TextAlign.left,
                                          style: const TextStyle(
                                            color: AppColors.baseColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  TinyBarChart.stacked(
                                    data: <double>[
                                      double.parse(value
                                              .rowMaintenancePlanGetData
                                              .data!
                                              .costTotalMilesMilesCmpltedMilesInProgressMilesPending![
                                                  0]
                                              .milesInProgress
                                              ?.toString() ??
                                          '0.0'),
                                      100.00 -
                                          double.parse(value
                                                  .rowMaintenancePlanGetData
                                                  .data!
                                                  .costTotalMilesMilesCmpltedMilesInProgressMilesPending![
                                                      0]
                                                  .milesInProgress
                                                  ?.toString() ??
                                              '0.0')
                                    ],
                                    options: const TinyBarChartOptions(
                                      colors: [
                                        Colors.orange,
                                        Color.fromARGB(255, 222, 220, 220),
                                      ],
                                    ),
                                    width: size.width * 0.9,
                                    height: 28,
                                  ),
                                  Row(
                                    children: [
                                      const Padding(
                                        padding:
                                            EdgeInsets.only(top: 8.0, left: 8),
                                        child: Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            "COMPLETED: ",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              color: AppColors.baseColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: Text(
                                          (value
                                                      .rowMaintenancePlanGetData
                                                      .data!
                                                      .costTotalMilesMilesCmpltedMilesInProgressMilesPending![
                                                          0]
                                                      .milesCompleted
                                                      .toString()
                                                      .isEmpty ||
                                                  value
                                                          .rowMaintenancePlanGetData
                                                          .data!
                                                          .costTotalMilesMilesCmpltedMilesInProgressMilesPending![
                                                              0]
                                                          .milesCompleted ==
                                                      null)
                                              ? '0%'
                                              : '${value.rowMaintenancePlanGetData.data!.costTotalMilesMilesCmpltedMilesInProgressMilesPending![0].milesCompleted.toString()}%',
                                          // "53.58%",
                                          textAlign: TextAlign.left,
                                          style: const TextStyle(
                                            color: AppColors.baseColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  TinyBarChart.stacked(
                                    data: <double>[
                                      double.parse(value
                                              .rowMaintenancePlanGetData
                                              .data!
                                              .costTotalMilesMilesCmpltedMilesInProgressMilesPending![
                                                  0]
                                              .milesCompleted
                                              ?.toString() ??
                                          '0.0'),
                                      100.00 -
                                          double.parse(value
                                                  .rowMaintenancePlanGetData
                                                  .data!
                                                  .costTotalMilesMilesCmpltedMilesInProgressMilesPending![
                                                      0]
                                                  .milesCompleted
                                                  ?.toString() ??
                                              '0.0')
                                    ],
                                    options: const TinyBarChartOptions(
                                      colors: [
                                        Colors.red,
                                        Color.fromARGB(255, 222, 220, 220),
                                      ],
                                    ),
                                    width: size.width * 0.9,
                                    height: 28,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 30.0),
                                    child: TinyBarChart.stacked(
                                      data: <double>[
                                        double.parse(value
                                                .rowMaintenancePlanGetData
                                                .data!
                                                .costTotalMilesMilesCmpltedMilesInProgressMilesPending![
                                                    0]
                                                .milesPending
                                                ?.toString() ??
                                            '0.0'),
                                        double.parse(value
                                                .rowMaintenancePlanGetData
                                                .data!
                                                .costTotalMilesMilesCmpltedMilesInProgressMilesPending![
                                                    0]
                                                .milesInProgress
                                                ?.toString() ??
                                            '0.0'),
                                        double.parse(value
                                                .rowMaintenancePlanGetData
                                                .data!
                                                .costTotalMilesMilesCmpltedMilesInProgressMilesPending![
                                                    0]
                                                .milesCompleted
                                                ?.toString() ??
                                            '0.0')
                                      ],
                                      options: const TinyBarChartOptions(
                                        colors: [
                                          Color.fromARGB(255, 60, 200, 243),
                                          Colors.orange,
                                          Colors.red,
                                          Color.fromARGB(255, 235, 233, 233)
                                        ],
                                      ),
                                      width: size.width * 0.9,
                                      height: 28,
                                    ),
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
                            //             color: Color.fromARGB(255, 3, 47, 97),
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
                            //             color:
                            //                 Color.fromARGB(255, 130, 193, 245),
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

                            //                           // TinyBarChart.stacked(
                            //                           //   data: <double>[
                            //                           //     dataset[index].spray ?? 0.0,
                            //                           //     dataset[index].mowing ??
                            //                           //         0.0,
                            //                           //     dataset[index]
                            //                           //             .mowingNoSpray ??
                            //                           //         0.0,
                            //                           //     dataset[index]
                            //                           //             .jaraffMowingSprayWork ??
                            //                           //         0.0,
                            //                           //     dataset[index].groundWork ??
                            //                           //         0.0,
                            //                           //     dataset[index]
                            //                           //             .jaraffMowingNoSpray ??
                            //                           //         0.0,
                            //                           //     dataset[index].bucketWork ??
                            //                           //         0.0
                            //                           //   ],
                            //                           //   options:
                            //                           //       const TinyBarChartOptions(
                            //                           //     colors: [
                            //                           //       Color.fromARGB(
                            //                           //           255, 2, 125, 6),
                            //                           //       Color.fromARGB(
                            //                           //           255, 138, 11, 2),
                            //                           //       Color.fromARGB(
                            //                           //           255, 249, 160, 190),
                            //                           //       Color.fromARGB(
                            //                           //           255, 94, 1, 110),
                            //                           //       Colors.yellow,
                            //                           //       Colors.red,
                            //                           //       Colors.blue
                            //                           //     ],
                            //                           //   ),
                            //                           //   width: size.width * 0.9,
                            //                           //   height: 28,
                            //                           // ),
                            //                         ],
                            //                       ),
                            //                     );
                            //                   })),
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                          
                            Container(
                              // margin: EdgeInsets.only(
                              //     top: 10, bottom: 10, left: 8, right: 8),
                              //padding: EdgeInsets.all(8),
                              alignment: Alignment.center,
                              height: size.height * 0.75,
                              width: size.width * 0.95,
                              decoration: BoxDecoration(
                                  // shape: BoxShape.circle,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: AppColors.baseColor,
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
                                  Row(
                                    children: [
                                      const Padding(
                                        padding:
                                            EdgeInsets.only(top: 8.0, left: 8),
                                        child: Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            "Total Record : ",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              color: AppColors.baseColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: Text(
                                          dataList.length.toString(),
                                          // result.length.toString(),
                                          textAlign: TextAlign.left,
                                          style: const TextStyle(
                                            color: AppColors.baseColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                right: 5,
                                                left: 4.0,
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
                                              decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Color.fromARGB(
                                                        255, 23, 1, 88),
                                                  ),
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
                                      ),
                                    ],
                                  ),
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: ListView.builder(
                                          itemCount: filteredList.length,
                                          // itemCount: historyList.length,
                                          itemBuilder:
                                              (BuildContext ctxt, int index) {
                                            var item = filteredList[index];

                                            return Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    top: 4.0,
                                                    bottom: 4,
                                                    left: 4,
                                                  ),
                                                  child: Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.93,
                                                    // margin:  EdgeInsets.only(
                                                    //     top: 5.0, bottom: 5.0, left: 2,right: 2),
                                                    padding:
                                                        const EdgeInsets.all(8),
                                                    decoration: BoxDecoration(
                                                      gradient: LinearGradient(
                                                        colors: [
                                                          AppColors.green1
                                                              .withOpacity(0.9),
                                                          AppColors.green2
                                                              .withOpacity(0.7),
                                                          AppColors.green1
                                                              .withOpacity(0.9),
                                                        ],
                                                        begin:
                                                            Alignment.topLeft,
                                                        end: Alignment
                                                            .bottomRight,
                                                      ),
                                                      border: Border.all(
                                                        color: Colors.white,
                                                      ),
                                                      borderRadius:
                                                          const BorderRadius
                                                              .only(
                                                        topRight:
                                                            Radius.circular(10),
                                                        bottomRight:
                                                            Radius.circular(10),
                                                        topLeft:
                                                            Radius.circular(10),
                                                        bottomLeft:
                                                            Radius.circular(10),
                                                      ),
                                                    ),
                                                    child: Column(children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 8.0),
                                                        child: Row(
                                                          children: [
                                                            Expanded(
                                                              child: Column(
                                                                children: [
                                                                  const Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .topLeft,
                                                                    child: Text(
                                                                      "VIEW: ",
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  InkWell(
                                                                      onTap:
                                                                          () {
                                                                        if (item.budgetType ==
                                                                            "Regular IVM maintenance") {
                                                                          Navigator.push(
                                                                              context,
                                                                              MaterialPageRoute(
                                                                                  builder: (context) => AdmJobListDistriIVMView(
                                                                                        tokenNo: item.jobno.toString(),
                                                                                      )));
                                                                        } else if (item.budgetType ==
                                                                            "Transmission maintenance") {
                                                                          Navigator.push(
                                                                              context,
                                                                              MaterialPageRoute(
                                                                                  builder: (context) => AdmJobListtransIVMView(
                                                                                        tokenNo: item.jobno.toString(),
                                                                                      )));
                                                                        } else if (item.budgetType ==
                                                                            "Mid Transmission maintenance") {
                                                                          Navigator.push(
                                                                              context,
                                                                              MaterialPageRoute(
                                                                                  builder: (context) => AdmJobListtransHerbicideView(
                                                                                        tokenNo: item.jobno.toString(),
                                                                                      )));
                                                                        } else if (item.annualHerbicide !=
                                                                            "N/A") {
                                                                          Navigator.push(
                                                                              context,
                                                                              MaterialPageRoute(
                                                                                  builder: (context) => AdmJobListAnnualHerbicideView(
                                                                                        tokenNo: item.jobno.toString(),
                                                                                      )));
                                                                        } else if (item.annualHerbicide ==
                                                                            "Work Order") {
                                                                          Navigator.push(
                                                                              context,
                                                                              MaterialPageRoute(
                                                                                  builder: (context) => AdmJobListWorkOrderView(
                                                                                        tokenNo: item.jobno.toString(),
                                                                                      )));
                                                                        }
                                                                      },
                                                                      child:
                                                                          const Align(
                                                                        alignment:
                                                                            Alignment.topLeft,
                                                                        child:
                                                                            Icon(
                                                                          Icons
                                                                              .visibility,
                                                                          color: Color.fromARGB(
                                                                              255,
                                                                              151,
                                                                              249,
                                                                              154),
                                                                        ),
                                                                      )),
                                                                ],
                                                              ),
                                                            ),
                                                            Expanded(
                                                              // alignment: Alignment.topLeft,
                                                              child: Column(
                                                                children: [
                                                                  const Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .topLeft,
                                                                    child: Text(
                                                                      "TYPE: ",
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .topLeft,
                                                                    child: Text(
                                                                      (item.type == null ||
                                                                              item.type.toString() ==
                                                                                  'null')
                                                                          ? ''
                                                                          : item
                                                                              .type
                                                                              .toString(),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                      style:
                                                                          const TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        //  fontWeight:
                                                                        //      FontWeight.bold,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Expanded(
                                                              // alignment: Alignment.topLeft,
                                                              child: Column(
                                                                children: [
                                                                  const Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .topLeft,
                                                                    child: Text(
                                                                      "JOB NO: ",
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .topLeft,
                                                                    child: Text(
                                                                      (item.jobno == null ||
                                                                              item.jobno.toString() ==
                                                                                  'null')
                                                                          ? ''
                                                                          : item
                                                                              .jobno
                                                                              .toString(),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                      style:
                                                                          const TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        //  fontWeight:
                                                                        //      FontWeight.bold,
                                                                        color: Colors
                                                                            .white,
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
                                                        color: Colors.grey,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 8.0),
                                                        child: Row(
                                                          children: [
                                                            Expanded(
                                                              // alignment: Alignment.topLeft,
                                                              child: Column(
                                                                children: [
                                                                  const Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .topLeft,
                                                                    child: Text(
                                                                      "SERVICE ORDER NO: ",
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .topLeft,
                                                                    child: Text(
                                                                      (item.serviceOrderNo == null ||
                                                                              item.serviceOrderNo.toString() ==
                                                                                  'null')
                                                                          ? ''
                                                                          : item
                                                                              .serviceOrderNo
                                                                              .toString(),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                      style:
                                                                          const TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        //  fontWeight:
                                                                        //      FontWeight.bold,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Expanded(
                                                              // alignment: Alignment.topLeft,
                                                              child: Column(
                                                                children: [
                                                                  const Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .topLeft,
                                                                    child: Text(
                                                                      "ANNUAL HERBICIDE: ",
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .topLeft,
                                                                    child: Text(
                                                                      (item.annualHerbicide == null ||
                                                                              item.annualHerbicide.toString() ==
                                                                                  'null')
                                                                          ? ''
                                                                          : item
                                                                              .annualHerbicide
                                                                              .toString(),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                      style:
                                                                          const TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        //  fontWeight:
                                                                        //      FontWeight.bold,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Expanded(
                                                              // alignment: Alignment.topLeft,
                                                              child: Column(
                                                                children: [
                                                                  const Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .topLeft,
                                                                    child: Text(
                                                                      "STATUS: ",
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .topLeft,
                                                                    child: Text(
                                                                      (item.status == null ||
                                                                              item.status.toString() ==
                                                                                  'null')
                                                                          ? ''
                                                                          : item
                                                                              .status
                                                                              .toString(),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                      style:
                                                                          const TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        //  fontWeight:
                                                                        //      FontWeight.bold,
                                                                        color: Colors
                                                                            .white,
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
                                                        color: Colors.grey,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 8.0),
                                                        child: Row(
                                                          children: [
                                                            Expanded(
                                                              // alignment: Alignment.topLeft,
                                                              child: Column(
                                                                children: [
                                                                  const Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .topLeft,
                                                                    child: Text(
                                                                      "SUBSTATION: ",
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .topLeft,
                                                                    child: Text(
                                                                      (item.substation == null ||
                                                                              item.substation.toString() ==
                                                                                  'null')
                                                                          ? ''
                                                                          : item
                                                                              .substation
                                                                              .toString(),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                      style:
                                                                          const TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        //  fontWeight:
                                                                        //      FontWeight.bold,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Expanded(
                                                              // alignment: Alignment.topLeft,
                                                              child: Column(
                                                                children: [
                                                                  const Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .topLeft,
                                                                    child: Text(
                                                                      "FEEDER: ",
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .topLeft,
                                                                    child: Text(
                                                                      (item.feeder == null ||
                                                                              item.feeder.toString() ==
                                                                                  'null')
                                                                          ? ''
                                                                          : item
                                                                              .feeder
                                                                              .toString(),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                      style:
                                                                          const TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        //  fontWeight:
                                                                        //      FontWeight.bold,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Expanded(
                                                              // alignment: Alignment.topLeft,
                                                              child: Column(
                                                                children: [
                                                                  const Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .topLeft,
                                                                    child: Text(
                                                                      "MAINTENANCE TYPE: ",
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .topLeft,
                                                                    child: Text(
                                                                      (item.maintenanceType == null ||
                                                                              item.maintenanceType.toString() ==
                                                                                  'null')
                                                                          ? ''
                                                                          : item
                                                                              .maintenanceType
                                                                              .toString(),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                      style:
                                                                          const TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        //  fontWeight:
                                                                        //      FontWeight.bold,
                                                                        color: Colors
                                                                            .white,
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
                                                        color: Colors.grey,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 8.0),
                                                        child: Row(
                                                          children: [
                                                            Expanded(
                                                              // alignment: Alignment.topLeft,
                                                              child: Column(
                                                                children: [
                                                                  const Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .topLeft,
                                                                    child: Text(
                                                                      "CREATED BY: ",
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .topLeft,
                                                                    child: Text(
                                                                      item.createdBy
                                                                          .toString(),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                      style:
                                                                          const TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        //  fontWeight:
                                                                        //      FontWeight.bold,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Expanded(
                                                              // alignment: Alignment.topLeft,
                                                              child: Column(
                                                                children: [
                                                                  const Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .topLeft,
                                                                    child: Text(
                                                                      "TRANSMISSION NAME: ",
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .topLeft,
                                                                    child: Text(
                                                                      item.transmissionName
                                                                          .toString(),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                      style:
                                                                          const TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        //  fontWeight:
                                                                        //      FontWeight.bold,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Expanded(
                                                              // alignment: Alignment.topLeft,
                                                              child: Column(
                                                                children: [
                                                                  const Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .topLeft,
                                                                    child: Text(
                                                                      "CREATE DATE: ",
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .topLeft,
                                                                    child: Text(
                                                                      formatDateIfNeeded(item
                                                                          .createDate
                                                                          .toString()),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                      style:
                                                                          const TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        //  fontWeight:
                                                                        //      FontWeight.bold,
                                                                        color: Colors
                                                                            .white,
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
                                                        color: Colors.grey,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 8.0),
                                                        child: Row(
                                                          children: [
                                                            Expanded(
                                                              // alignment: Alignment.topLeft,
                                                              child: Column(
                                                                children: [
                                                                  const Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .topLeft,
                                                                    child: Text(
                                                                      "FOREMAN: ",
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .topLeft,
                                                                    child: Text(
                                                                      item.foreman
                                                                          .toString(),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                      style:
                                                                          const TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        //  fontWeight:
                                                                        //      FontWeight.bold,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Expanded(
                                                              // alignment: Alignment.topLeft,
                                                              child: Column(
                                                                children: [
                                                                  const Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .topLeft,
                                                                    child: Text(
                                                                      "CONTRACTOR COMPANY: ",
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .topLeft,
                                                                    child: Text(
                                                                      item.contractorCompany
                                                                          .toString(),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                      style:
                                                                          const TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        //  fontWeight:
                                                                        //      FontWeight.bold,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Expanded(
                                                              // alignment: Alignment.topLeft,
                                                              child: Column(
                                                                children: [
                                                                  const Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .topLeft,
                                                                    child: Text(
                                                                      "CONTRACT YEAR: ",
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .topLeft,
                                                                    child: Text(
                                                                      getYearOrNA(item
                                                                          .contractYear
                                                                          .toString()),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                      style:
                                                                          const TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        //  fontWeight:
                                                                        //      FontWeight.bold,
                                                                        color: Colors
                                                                            .white,
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
                                                        color: Colors.grey,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 8.0),
                                                        child: Row(
                                                          children: [
                                                            Expanded(
                                                              // alignment: Alignment.topLeft,
                                                              child: Column(
                                                                children: [
                                                                  const Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .topLeft,
                                                                    child: Text(
                                                                      "ADMIN NOTES: ",
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .topLeft,
                                                                    child: Text(
                                                                      (item.adminNotes == null ||
                                                                              item.adminNotes.toString() ==
                                                                                  'null')
                                                                          ? ''
                                                                          : item
                                                                              .adminNotes
                                                                              .toString(),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                      style:
                                                                          const TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        //  fontWeight:
                                                                        //      FontWeight.bold,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Expanded(
                                                              // alignment: Alignment.topLeft,
                                                              child: Column(
                                                                children: [
                                                                  const Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .topLeft,
                                                                    child: Text(
                                                                      "GENERAL FOREMAN NOTES: ",
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .topLeft,
                                                                    child: Text(
                                                                      item.generalForemanNotes
                                                                          .toString(),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                      style:
                                                                          const TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        //  fontWeight:
                                                                        //      FontWeight.bold,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Expanded(
                                                              // alignment: Alignment.topLeft,
                                                              child: Column(
                                                                children: [
                                                                  const Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .topLeft,
                                                                    child: Text(
                                                                      "TOTAL MILES: ",
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .topLeft,
                                                                    child: Text(
                                                                      item.totalMiles
                                                                          .toString(),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                      style:
                                                                          const TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        //  fontWeight:
                                                                        //      FontWeight.bold,
                                                                        color: Colors
                                                                            .white,
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
                                                        color: Colors.grey,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 8.0),
                                                        child: Row(
                                                          children: [
                                                            Expanded(
                                                              // alignment: Alignment.topLeft,
                                                              child: Column(
                                                                children: [
                                                                  const Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .topLeft,
                                                                    child: Text(
                                                                      "CYCLE: ",
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .topLeft,
                                                                    child: Text(
                                                                      item.cycle
                                                                          .toString(),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                      style:
                                                                          const TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        //  fontWeight:
                                                                        //      FontWeight.bold,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Expanded(
                                                              // alignment: Alignment.topLeft,
                                                              child: Column(
                                                                children: [
                                                                  const Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .topLeft,
                                                                    child: Text(
                                                                      "NEXT MAINT DUE: ",
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .topLeft,
                                                                    child: Text(
                                                                      (item.nextMaintDue == null ||
                                                                              item.nextMaintDue.toString() ==
                                                                                  'null')
                                                                          ? ''
                                                                          : formatDateIfNeeded(item
                                                                              .nextMaintDue
                                                                              .toString()),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                      style:
                                                                          const TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        //  fontWeight:
                                                                        //      FontWeight.bold,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Expanded(
                                                              // alignment: Alignment.topLeft,
                                                              child: Column(
                                                                children: [
                                                                  const Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .topLeft,
                                                                    child: Text(
                                                                      "DATE OF INSPECTION: ",
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .topLeft,
                                                                    child: Text(
                                                                      (item.dateOfInspection == null ||
                                                                              item.dateOfInspection.toString() ==
                                                                                  'null')
                                                                          ? ''
                                                                          : formatDateIfNeeded(item
                                                                              .dateOfInspection
                                                                              .toString()),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                      style:
                                                                          const TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        //  fontWeight:
                                                                        //      FontWeight.bold,
                                                                        color: Colors
                                                                            .white,
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
                                                        color: Colors.grey,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 8.0),
                                                        child: Row(
                                                          children: [
                                                            Expanded(
                                                              // alignment: Alignment.topLeft,
                                                              child: Column(
                                                                children: [
                                                                  const Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .topLeft,
                                                                    child: Text(
                                                                      "FOLLOW UP DATE: ",
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .topLeft,
                                                                    child: Text(
                                                                      (item.followUpDate == null ||
                                                                              item.followUpDate.toString() ==
                                                                                  'null')
                                                                          ? ''
                                                                          : formatDateIfNeeded(item
                                                                              .followUpDate
                                                                              .toString()),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                      style:
                                                                          const TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        //  fontWeight:
                                                                        //      FontWeight.bold,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Expanded(
                                                              // alignment: Alignment.topLeft,
                                                              child: Column(
                                                                children: [
                                                                  const Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .topLeft,
                                                                    child: Text(
                                                                      "COST PER MILE : ",
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .topLeft,
                                                                    child: Text(
                                                                      (item.costPerMile == null ||
                                                                              item.costPerMile.toString() ==
                                                                                  'null')
                                                                          ? ''
                                                                          : item
                                                                              .costPerMile
                                                                              .toString(),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                      style:
                                                                          const TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        //  fontWeight:
                                                                        //      FontWeight.bold,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Expanded(
                                                              // alignment: Alignment.topLeft,
                                                              child: Column(
                                                                children: [
                                                                  const Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .topLeft,
                                                                    child: Text(
                                                                      "TOTAL COST: ",
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .topLeft,
                                                                    child: Text(
                                                                      (item.totalCost == null ||
                                                                              item.totalCost.toString() ==
                                                                                  'null')
                                                                          ? ''
                                                                          : item
                                                                              .totalCost
                                                                              .toString(),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                      style:
                                                                          const TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        //  fontWeight:
                                                                        //      FontWeight.bold,
                                                                        color: Colors
                                                                            .white,
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
                                                        color: Colors.grey,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 8.0),
                                                        child: Row(
                                                          children: [
                                                            Expanded(
                                                              flex: 2,
                                                              child: Column(
                                                                children: [
                                                                  Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .topLeft,
                                                                      child:
                                                                          InkWell(
                                                                        onTap:
                                                                            () async {
                                                                          String
                                                                              id =
                                                                              '';
                                                                          final userPreferences1 = Provider.of<UserPref>(
                                                                              context,
                                                                              listen: false);
                                                                          UserModel
                                                                              data =
                                                                              await userPreferences1.getUser();
                                                                          id = data
                                                                              .user!
                                                                              .id
                                                                              .toString();
                                                                          // Navigator.of(context).push(MaterialPageRoute(
                                                                          //     builder: (BuildContext context) => MapViewAdmin(
                                                                          //           id: rowMaintenancePlanViewModel.rowMaintenancePlanGetData.data!.rowMaintenancePlanList![index].tokenNo.toString(),
                                                                          //         )));
                                                                          // Navigator
                                                                          //     .push(
                                                                          //   context,
                                                                          //   MaterialPageRoute(
                                                                          //     builder: (context) => MapViewPage(
                                                                          //       url: MapUrl.getAdminEndPoint(rowMaintenancePlanViewModel.rowMaintenancePlanGetData.data!.rowMaintenancePlanList![index].tokenNo.toString(), id),
                                                                          //     ),
                                                                          //   ),
                                                                          // );
                                                                          await browser.open(url: WebUri(
                                                                              // "https://mapapi.ariespro.com/main/admin/CIVM_Map/${rowMaintenancePlanViewModel.rowMaintenancePlanGetData.data!.rowMaintenancePlanList![index].tokenNo.toString()}/USRQWXH589Z"),

                                                                              MapUrl.getAdminEndPoint(rowMaintenancePlanViewModel.rowMaintenancePlanGetData.data!.rowMaintenancePlanList![index].tokenNo.toString(), id)), settings: ChromeSafariBrowserSettings(shareState: CustomTabsShareState.SHARE_STATE_OFF, barCollapsingEnabled: true));
                                                                        },
                                                                        child:
                                                                            Align(
                                                                          alignment:
                                                                              Alignment.centerLeft,
                                                                          child:
                                                                              Container(
                                                                            // margin: const EdgeInsets.only(
                                                                            //     left: 40, right: 40, bottom: 10.0),
                                                                            padding:
                                                                                const EdgeInsets.all(8),
                                                                            alignment:
                                                                                Alignment.centerLeft,
                                                                            width:
                                                                                80,
                                                                            // MediaQuery.of(context).size.width,
                                                                            // height: MediaQuery.of(context).size.height * 0.4,
                                                                            decoration: const BoxDecoration(
                                                                                // shape: BoxShape.circle,

                                                                                color: Color.fromARGB(255, 0, 58, 106),
                                                                                gradient: LinearGradient(
                                                                                  colors: [
                                                                                    Color.fromARGB(255, 0, 79, 215),
                                                                                    Colors.blue,
                                                                                    Color.fromARGB(255, 0, 79, 215),
                                                                                  ],
                                                                                )),
                                                                            child:
                                                                                const Align(
                                                                              alignment: Alignment.center,
                                                                              child: Text(
                                                                                "VIEW MAP",
                                                                                style: TextStyle(
                                                                                  color: Colors.white,
                                                                                  fontWeight: FontWeight.bold,
                                                                                  fontSize: 10,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      )),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ]),
                                                  ),
                                                ),
                                              ],
                                            );
                                          }),
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
            })));
  }

  // Future<void> _filterData(String query) async {
  //   if (query.isEmpty) {
  //     rowMaintenancePlanViewModel.fetchProgressBarRowMaintDataApi(context);
  //   } else {
  //     rowMaintenancePlanViewModel.rowMaintenancePlanGetData.data!.rowMaintenancePlanList = rowMaintenancePlanViewModel
  //         .rowMaintenancePlanGetData.data!.rowMaintenancePlanList
  //         ?.where((item) =>
  //             item.tokenNo.toString().toLowerCase().contains(query.toLowerCase()) ||
  //             item.status
  //                 .toString()
  //                 .toLowerCase()
  //                 .contains(query.toLowerCase()) ||
  //             item.substation
  //                 .toString()
  //                 .toLowerCase()
  //                 .contains(query.toLowerCase()) ||
  //             item.maintType
  //                 .toString()
  //                 .toLowerCase()
  //                 .contains(query.toLowerCase()) ||
  //             item.contractor
  //                 .toString()
  //                 .toLowerCase()
  //                 .contains(query.toLowerCase()) ||
  //             item.cycle
  //                 .toString()
  //                 .toLowerCase()
  //                 .contains(query.toLowerCase()) ||
  //             item.streetAddress
  //                 .toString()
  //                 .toLowerCase()
  //                 .contains(query.toLowerCase()) ||
  //             item.mapLocation
  //                 .toString()
  //                 .toLowerCase()
  //                 .contains(query.toLowerCase()) ||
  //             item.adminNotes1
  //                 .toString()
  //                 .toLowerCase()
  //                 .contains(query.toLowerCase()) ||
  //             item.contractorCompay
  //                 .toString()
  //                 .toLowerCase()
  //                 .contains(query.toLowerCase()) ||
  //             item.nextMaintDue.toString().toLowerCase().contains(query.toLowerCase()) ||
  //             item.dateOfInspection.toString().toLowerCase().contains(query.toLowerCase()) ||
  //             item.costPerMile.toString().toLowerCase().contains(query.toLowerCase()) ||
  //             item.totalCost.toString().toLowerCase().contains(query.toLowerCase()) ||
  //             item.nextMaintDue.toString().toLowerCase().contains(query.toLowerCase()) ||
  //             item.fdrName.toString().toLowerCase().contains(query.toLowerCase()))
  //         .toList();
  //   }
  //   setState(() {});
  // }

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
          final annualHerbicide =
              item.annualHerbicide?.toString().toLowerCase() ?? '';
          final maintType =
              item.maintenanceType?.toString().toLowerCase() ?? '';

          return type.contains(query.toLowerCase()) ||
              tokenNo.contains(query.toLowerCase()) ||
              status.contains(query.toLowerCase()) ||
              substation.contains(query.toLowerCase()) ||
              feeder.contains(query.toLowerCase()) ||
              budgetType.contains(query.toLowerCase()) ||
              annualHerbicide.contains(query.toLowerCase()) ||
              maintType.contains(query.toLowerCase());
        }).toList();
      });
    }
  }

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

  Future<void> loadGraphData() async {
    await Future.delayed(Duration(seconds: 10));
    loadingFlag = 1;
    rowMaintenancePlanViewModel.fetchProgressBarRowMaintDataApi(context);
  }

  String id = '';
  Future<void> fetchData() async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel userdata = await userPreferences.getUser();
    id = userdata.user!.id.toString();
    var url =
        "${AppUrl.baseUrl}rowVegetationManagementDashboard/Admindatalist?contractorId=$id";

    print('dashboard list api url::: $url');

    var headers = {
      "Content-Type": "application/json",
      // "Authorization": "Bearer $token", //  Add this line
      "Authorization": 'Bearer ${userdata.token!}'
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
              list.map((e) => AdminDashboardDataListdata.fromJson(e)).toList();

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

// double roundValue(double val, int places) {
//   num mod = pow(10.0, places);
//   return ((val * mod).round().toDouble() / mod);
// }

class ChartData {
  ChartData(this.x, this.y, this.color);
  final String x;
  final double y;
  final Color color;
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
