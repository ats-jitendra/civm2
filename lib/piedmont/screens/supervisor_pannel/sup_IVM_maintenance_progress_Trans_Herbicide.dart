import 'dart:convert';

import 'package:CIVM/piedmont/models/ivm_maintenace_progress_transmission_model.dart';
import 'package:CIVM/piedmont/resources/app_url.dart';
import 'package:CIVM/piedmont/utils/common_functions.dart';
import 'package:CIVM/utils/user_pref.dart';
import 'package:CIVM/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:CIVM/piedmont/resources/app_colors.dart';
import 'package:http/http.dart' as http;

class SupIVMMaintenanceProgressTransHerbicide extends StatefulWidget {
  const SupIVMMaintenanceProgressTransHerbicide({Key? key}) : super(key: key);

  @override
  State<SupIVMMaintenanceProgressTransHerbicide> createState() =>
      _SupIVMMaintenanceProgressTransHerbicideState();
}

class _SupIVMMaintenanceProgressTransHerbicideState
    extends State<SupIVMMaintenanceProgressTransHerbicide> {
  // int _currentIndex = 0;
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

//////
  String? selectedDuration = "Yearly";
  String? selectedYear = DateTime.now().year.toString();

  List<String> selectedMonths = [];

  final List<String> durationList = [
    "Weekly",
    "Monthly",
    "Yearly",
  ];

  final List<String> monthsList = [
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
    // "January",
    // "February",
    // "March",
    // "April",
    // "May",
    // "June",
    // "July",
    // "August",
    // "September",
    // "October",
    // "November",
    // "December",
  ];
  List<dynamic> selectedmonth = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "10",
    "11",
    "12"
  ];
  String selectedmonthString = "";
  final List<String> yearsList = [
    "2023",
    "2024",
    "2025",
    "2026",
  ];
  String? month;
  List<dynamic> monthh = [
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

  ///weekly
  /// Generate Saturdays dynamically
  List<String> getSaturdayDates(int year) {
    List<String> saturdays = [];

    DateTime date = DateTime(year, 1, 1);

    /// Find first Saturday
    while (date.weekday != DateTime.saturday) {
      date = date.add(const Duration(days: 1));
    }

    /// Add all Saturdays
    while (date.year == year) {
      saturdays.add(
        DateFormat('MM/dd/yyyy').format(date),
        // DateFormat('yyyy-MM-dd').format(date),
      );

      date = date.add(const Duration(days: 7));
    }

    return saturdays;
  }

  List<String> saturdayList = [];
  String? selectedWeek;
  List<String> selectedWeeks = [];
  String selectedWeeksString = "";
//////
  List<MileageModel> data = [];

  /// ALL WEEK COLUMNS
  List<String> weekColumns = [];
  // List<MileageModel> data = [
  //   MileageModel(
  //     substation: "Red Mountain",
  //     circuitNo: "195",
  //     name: "Berea",
  //     ohPrimaryMiles: 52.14,
  //     weeks: {
  //       "1/10/2026": 8.5,
  //       "1/17/2026": 9,
  //       "1/24/2026": 8,
  //     },
  //   ),
  //   MileageModel(
  //     substation: "Red Mountain",
  //     circuitNo: "193",
  //     name: "Rougemont",
  //     ohPrimaryMiles: 54.72,
  //     weeks: {
  //       "2/21/2026": 10,
  //       "2/28/2026": 8.25,
  //     },
  //   ),
  // ];
  Future? myFuture;
  late TooltipBehavior tooltipBehavior;
  @override
  void initState() {
    myFuture = fetchWeeklyMilesData();
    fetchYearlyGraphData();
    tooltipBehavior = TooltipBehavior(
      enable: true,
      format: 'point.x : point.y%',
      color: Colors.black,
      textStyle: const TextStyle(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
    );
    // tooltipBehavior = TooltipBehavior(
    //   enable: true,
    //   builder: (dynamic data, dynamic point, dynamic series, int pointIndex,
    //       int seriesIndex) {
    //     final PieChartModel item = data;

    //     return Container(
    //       padding: const EdgeInsets.all(8),
    //       decoration: BoxDecoration(
    //         color: Colors.black,
    //         borderRadius: BorderRadius.circular(8),
    //       ),
    //       child: Text(
    //         '${item.title}\n'
    //         '${item.percentage.toStringAsFixed(2)}%\n'
    //         'Miles: ${item.miles.toStringAsFixed(2)}',
    //         style: const TextStyle(color: Colors.white),
    //       ),
    //     );
    //   },
    // );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    Set<String> weekSet = {};

    for (var item in data) {
      weekSet.addAll(item.weeks.keys);
    }

    List<String> weekColumns = weekSet.toList();
    ////
    // if (selectedDuration == "Weekly") {
    //   setState(() {
    //     selectedWeek = null;

    //     /// Generate Saturdays
    //     saturdayList = getSaturdayDates(
    //       int.parse(selectedYear!),
    //     );
    //   });
    // }
    // print('  saturdayList $saturdayList $selectedYear');
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        // appBar: AppBar(
        //   iconTheme: const IconThemeData(color: Colors.white),
        //   title: const Text(
        //     'IVM Maintenance Progress',
        //     style: TextStyle(color: Colors.white),
        //   ),
        //   backgroundColor: AppColors.baseColor,
        //   actions: [
        //     IconButton(
        //       icon: const Icon(Icons.filter_alt_outlined, color: Colors.white),
        //       onPressed: () {
        //         showFilterDialog(context);
        //       },
        //     ),
        //   ],
        // ),

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
                      await fetchWeeklyMilesData();
                      fetchYearlyGraphData();
                      print('RefreshIndicator called');
                    },
                    child: SafeArea(
                      child: Column(
                        children: [
                             progressHeader("Transmission Herbicide",
                                  onTap: () {
                                showFilterDialog(context);
                              }),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Column(
                                  children: [
                                    // Card(
                                    //       elevation: 5,
                                    //   shape: RoundedRectangleBorder(
                                    //     borderRadius: BorderRadius.circular(12),
                                    //   ),
                                    //   child: Padding(
                                    //     padding: const EdgeInsets.only(bottom:8.0),
                                    //     child:
                                 
                            
                                    Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 8, left: 8, top: 8),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: ProgressCard(
                                                  title: "Miles Completed",
                                                  value: milesCompleted
                                                      .toStringAsFixed(2),
                                                  icon: Icons.route,
                                                  startColor: const Color(0xFF4CAF50),
                                                  endColor: const Color(0xFF2E7D32),
                                                ),
                                              ),
                                              const SizedBox(width: 8),
                                              Expanded(
                                                child: ProgressCard(
                                                  title: "Cost",
                                                  value:
                                                      "\$${totalMilesCompletedCost.toStringAsFixed(2)}",
                                                  icon: Icons.attach_money,
                                                  startColor: const Color(0xFF2196F3),
                                                  endColor: const Color(0xFF1565C0),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 8, left: 8, top: 8),
                                          child: Row(children: [
                                            Expanded(
                                              child: ProgressCard(
                                                title: "Expected Miles",
                                                value:
                                                    "${expectedMiles.toStringAsFixed(2)} (${standardExpectedMiles.toStringAsFixed(2)}/W)",
                                                icon: Icons.flag,
                                                startColor: const Color(0xFFFF9800),
                                                endColor: const Color(0xFFEF6C00),
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            Expanded(
                                              child: ProgressCard(
                                                title: "Remaining Miles",
                                                value:
                                                    milesPending.toStringAsFixed(2),
                                                icon: Icons.speed,
                                                startColor: const Color(0xFFE91E63),
                                                endColor: const Color(0xFFAD1457),
                                              ),
                                            ),
                                          ]),
                                        ),
                                      ],
                                    ),
                                    //   ),
                                    // ),
                                    const SizedBox(height: 8),
                                    Card(
                                      elevation: 5,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(12),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            cardHeader(
                                                "Weekly Mileage Tracking Sheet"),
                                            const SizedBox(height: 12),
                                            SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Table(
                                                border: TableBorder.all(
                                                  color: Colors.grey,
                                                ),
                                                defaultVerticalAlignment:
                                                    TableCellVerticalAlignment.middle,
                                                columnWidths: {
                                                  0: const FixedColumnWidth(150),
                                                  1: const FixedColumnWidth(100),
                                                  2: const FixedColumnWidth(180),
                                                  3: const FixedColumnWidth(120),
                            
                                                  /// DYNAMIC WEEK COLUMNS
                                                  for (int i = 0;
                                                      i < weekColumns.length;
                                                      i++)
                                                    i + 4:
                                                        const FixedColumnWidth(110),
                                                },
                                                children: [
                                                  /// HEADER
                                                  TableRow(
                                                    decoration: const BoxDecoration(
                                                      color: Color.fromARGB(
                                                          255, 241, 174, 85),
                                                    ),
                                                    children: [
                                                      // headerCell("Substation"),
                                                      // headerCell("Circuit"),
                                                      headerCell("Name"),
                                                      headerCell("Total Miles"),
                                                      ...weekColumns.map(
                                                        (e) => headerCell(e),
                                                      ),
                                                    ],
                                                  ),
                            
                                                  /// DATA ROWS
                                                  // ...data.map((item) {
                                                  //   return TableRow(
                                                  //     children: [
                                                  //       tableCell(item.substation),
                                                  //       tableCell(item.circuitNo),
                                                  //       tableCell(item.feeder),
                                                  //       tableCell(
                                                  //         item.totalMiles.toString(),
                                                  //       ),
                                                  //       ...weekColumns.map(
                                                  //         (week) => tableCell(
                                                  //           (item.weeks[week] ==
                                                  //                       null ||
                                                  //                   item.weeks[
                                                  //                           week] ==
                                                  //                       0 ||
                                                  //                   item.weeks[
                                                  //                           week] ==
                                                  //                       0.0)
                                                  //               ? ''
                                                  //               : item.weeks[week]
                                                  //                   .toString(),
                                                  //         ),
                                                  //         // tableCell(
                                                  //         //   item.weeks[week]
                                                  //         //           ?.toString() ??
                                                  //         //       '0',
                                                  //         // ),
                                                  //       ),
                                                  //     ],
                                                  //   );
                                                  // }).toList(),
                                                  ...data
                                                      .asMap()
                                                      .entries
                                                      .map((entry) {
                                                    int index = entry.key;
                                                    var item = entry.value;
                            
                                                    bool isLastTwoRows =
                                                        index >= data.length - 2;
                            
                                                    return TableRow(
                                                      children: [
                                                        // tableCell(
                                                        //   item.substation,
                                                        //   textColor: isLastTwoRows
                                                        //       ? Colors.red
                                                        //       : Colors.black,
                                                        //   fontWeight: isLastTwoRows
                                                        //       ? FontWeight.bold
                                                        //       : FontWeight.normal,
                                                        // ),
                                                        // tableCell(
                                                        //   item.circuitNo,
                                                        //   textColor: isLastTwoRows
                                                        //       ? Colors.red
                                                        //       : Colors.black,
                                                        //   fontWeight: isLastTwoRows
                                                        //       ? FontWeight.bold
                                                        //       : FontWeight.normal,
                                                        // ),
                                                        tableCell(
                                                          item.name,
                                                          textColor: isLastTwoRows
                                                              ? Colors.red
                                                              : Colors.black,
                                                          fontWeight: isLastTwoRows
                                                              ? FontWeight.bold
                                                              : FontWeight.normal,
                                                        ),
                                                        tableCell(
                                                          item.totalMiles.toString(),
                                                          textColor: isLastTwoRows
                                                              ? Colors.red
                                                              : Colors.black,
                                                          fontWeight: isLastTwoRows
                                                              ? FontWeight.bold
                                                              : FontWeight.normal,
                                                        ),
                                                        ...weekColumns.map(
                                                          (week) => tableCell(
                                                            (item.weeks[week] ==
                                                                        null ||
                                                                    item.weeks[
                                                                            week] ==
                                                                        0 ||
                                                                    item.weeks[
                                                                            week] ==
                                                                        0.0)
                                                                ? ''
                                                                : item.weeks[week]
                                                                    .toString(),
                                                            textColor: isLastTwoRows
                                                                ? Colors.red
                                                                : Colors.black,
                                                            fontWeight: isLastTwoRows
                                                                ? FontWeight.bold
                                                                : FontWeight.normal,
                                                          ),
                                                        ),
                                                      ],
                                                    );
                                                  }).toList(),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                            
                                    // const SizedBox(height: 8),
                                    // Card(
                                    //   elevation: 5,
                                    //   shape: RoundedRectangleBorder(
                                    //     borderRadius: BorderRadius.circular(12),
                                    //   ),
                                    //   child: Padding(
                                    //     padding: const EdgeInsets.all(12),
                                    //     child: Column(
                                    //       crossAxisAlignment:
                                    //           CrossAxisAlignment.start,
                                    //       children: [
                                    //         cardHeader("Graph Data"),
                                    //         const SizedBox(height: 12),
                                    //         SfCartesianChart(
                                    //           primaryXAxis: CategoryAxis(
                                    //             title: AxisTitle(
                                    //                 text: 'Year',
                                    //                 textStyle: const TextStyle(
                                    //                     color: Colors.red,
                                    //                     fontFamily: 'Roboto',
                                    //                     fontSize: 16,
                                    //                     // fontStyle: FontStyle.italic,
                                    //                     fontWeight: FontWeight.bold)),
                                    //           ),
                                    //           primaryYAxis: NumericAxis(
                                    //             title: AxisTitle(
                                    //                 text: 'Miles',
                                    //                 textStyle: const TextStyle(
                                    //                     color: Colors.red,
                                    //                     fontFamily: 'Roboto',
                                    //                     fontSize: 16,
                                    //                     // fontStyle: FontStyle.italic,
                                    //                     fontWeight: FontWeight.bold)),
                                    //           ),
                                    //           legend: Legend(
                                    //             isVisible: true,
                                    //             overflowMode:
                                    //                 LegendItemOverflowMode.wrap,
                                    //             position: LegendPosition.top,
                                    //           ),
                                    //           //  tooltipBehavior: TooltipBehavior(enable: true),
                                    //           tooltipBehavior: TooltipBehavior(
                                    //             enable: true,
                                    //             builder: (dynamic data,
                                    //                 dynamic point,
                                    //                 dynamic series,
                                    //                 int pointIndex,
                                    //                 int seriesIndex) {
                                    //               final YearlyMilesModel item = data;
                            
                                    //               return Container(
                                    //                 padding: const EdgeInsets.all(8),
                                    //                 color: Colors.black,
                                    //                 child: Text(
                                    //                   item.subFdr,
                                    //                   style: const TextStyle(
                                    //                       color: Colors.white),
                                    //                 ),
                                    //               );
                                    //             },
                                    //           ),
                            
                                    //           series: <CartesianSeries>[
                                    //             StackedColumnSeries<YearlyMilesModel,
                                    //                 String>(
                                    //               dataSource: yearlyMilesList,
                                    //               xValueMapper:
                                    //                   (YearlyMilesModel data, _) =>
                                    //                       data.year,
                                    //               yValueMapper:
                                    //                   (YearlyMilesModel data, _) =>
                                    //                       data.milesCompleted,
                                    //               pointColorMapper:
                                    //                   (YearlyMilesModel data, _) =>
                                    //                       Colors.green,
                                    //               name: 'Completed',
                                    //               dataLabelSettings:
                                    //                   const DataLabelSettings(
                                    //                 isVisible: true,
                                    //               ),
                                    //             ),
                                    //             StackedColumnSeries<YearlyMilesModel,
                                    //                 String>(
                                    //               dataSource: yearlyMilesList,
                                    //               xValueMapper:
                                    //                   (YearlyMilesModel data, _) =>
                                    //                       data.year,
                                    //               yValueMapper:
                                    //                   (YearlyMilesModel data, _) =>
                                    //                       data.milesPending,
                                    //               pointColorMapper:
                                    //                   (YearlyMilesModel data, _) =>
                                    //                       Colors.orange,
                                    //               name: 'Pending',
                                    //               dataLabelSettings:
                                    //                   const DataLabelSettings(
                                    //                 isVisible: true,
                                    //               ),
                                    //             ),
                                    //           ],
                                    //         )
                                    //       ],
                                    //     ),
                                    //   ),
                                    // ),
                            
                                    const SizedBox(height: 8),
                                    Card(
                                      elevation: 5,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(12),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            cardHeader("Miles Completed"),
                                            const SizedBox(height: 12),
                                            SfCartesianChart(
                                              legend: Legend(
                                                isVisible: true,
                                                position: LegendPosition.top,
                                                overflowMode:
                                                    LegendItemOverflowMode.wrap,
                                              ),
                                              primaryXAxis: CategoryAxis(
                                                title: AxisTitle(
                                                    text: selectedDuration == "Yearly"
                                                        ? 'Year'
                                                        : selectedDuration ==
                                                                "Monthly"
                                                            ? 'Month'
                                                            : 'Week',
                                                    textStyle: const TextStyle(
                                                        color: Colors.red,
                                                        fontFamily: 'Roboto',
                                                        fontSize: 16,
                                                        // fontStyle: FontStyle.italic,
                                                        fontWeight: FontWeight.bold)),
                                              ),
                                              primaryYAxis: NumericAxis(
                                                title: AxisTitle(
                                                    text: 'Miles',
                                                    textStyle: const TextStyle(
                                                        color: Colors.red,
                                                        fontFamily: 'Roboto',
                                                        fontSize: 16,
                                                        // fontStyle: FontStyle.italic,
                                                        fontWeight: FontWeight.bold)),
                                              ),
                                              tooltipBehavior: TooltipBehavior(
                                                enable: true,
                                                builder: (dynamic data,
                                                    dynamic point,
                                                    dynamic series,
                                                    int pointIndex,
                                                    int seriesIndex) {
                                                  final DurationGraphModel item =
                                                      data;
                            
                                                  return Container(
                                                    padding: const EdgeInsets.all(10),
                                                    decoration: BoxDecoration(
                                                      color: Colors.black,
                                                      borderRadius:
                                                          BorderRadius.circular(8),
                                                    ),
                                                    child: Column(
                                                      mainAxisSize: MainAxisSize.min,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          item.subFdr,
                                                          style: const TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        const SizedBox(height: 5),
                                                        Text.rich(
                                                          TextSpan(
                                                            text: "Miles : ",
                                                            style: const TextStyle(
                                                              //  fontSize: 16,
                                                              color: Colors.white,
                                                              fontWeight:
                                                                  FontWeight.bold,
                                                            ),
                                                            children: [
                                                              TextSpan(
                                                                  text:
                                                                      "${item.milesCompleted}",
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal)),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                              ),
                                              palette: const <Color>[
                                                Colors.green,
                                                Colors.purple,
                                                Colors.blue,
                                                Color.fromARGB(255, 247, 79, 135),
                                                Colors.orange,
                                              ],
                                              series: <CartesianSeries>[
                                                StackedColumnSeries<
                                                    DurationGraphModel, String>(
                                                  dataSource: graphList,
                                                  xValueMapper:
                                                      (DurationGraphModel data, _) =>
                                                          getXAxisValue(data),
                                                  yValueMapper:
                                                      (DurationGraphModel data, _) =>
                                                          data.milesCompleted,
                                                  name: 'Completed',
                                                  markerSettings:
                                                      const MarkerSettings(
                                                    isVisible: true,
                                                    shape: DataMarkerType.diamond,
                                                  ),
                                                  dataLabelSettings:
                                                      const DataLabelSettings(
                                                    isVisible: true,
                                                  ),
                                                ),
                                                // StackedColumnSeries<
                                                //     DurationGraphModel, String>(
                                                //   dataSource: graphList,
                                                //   xValueMapper:
                                                //       (DurationGraphModel data,
                                                //               _) =>
                                                //           getXAxisValue(data),
                                                //   yValueMapper:
                                                //       (DurationGraphModel data,
                                                //               _) =>
                                                //           data.milesPending,
                                                //   name: 'Pending',
                                                //   dataLabelSettings:
                                                //       const DataLabelSettings(
                                                //     isVisible: true,
                                                //   ),
                                                // ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Card(
                                      elevation: 5,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(12),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            cardHeader("Miles Completed Cost"),
                                            const SizedBox(height: 12),
                                            SfCartesianChart(
                                              legend: Legend(
                                                isVisible: true,
                                                position: LegendPosition.top,
                                                overflowMode:
                                                    LegendItemOverflowMode.wrap,
                                              ),
                                              primaryXAxis: CategoryAxis(
                                                title: AxisTitle(
                                                    text: selectedDuration == "Yearly"
                                                        ? 'Year'
                                                        : selectedDuration ==
                                                                "Monthly"
                                                            ? 'Month'
                                                            : 'Week',
                                                    textStyle: const TextStyle(
                                                        color: Colors.red,
                                                        fontFamily: 'Roboto',
                                                        fontSize: 16,
                                                        // fontStyle: FontStyle.italic,
                                                        fontWeight: FontWeight.bold)),
                                              ),
                                              primaryYAxis: NumericAxis(
                                                title: AxisTitle(
                                                    text: 'Cost',
                                                    textStyle: const TextStyle(
                                                        color: Colors.red,
                                                        fontFamily: 'Roboto',
                                                        fontSize: 16,
                                                        // fontStyle: FontStyle.italic,
                                                        fontWeight: FontWeight.bold)),
                                              ),
                                              tooltipBehavior: TooltipBehavior(
                                                enable: true,
                                                builder: (dynamic data,
                                                    dynamic point,
                                                    dynamic series,
                                                    int pointIndex,
                                                    int seriesIndex) {
                                                  final DurationGraphModel item =
                                                      data;
                            
                                                  return Container(
                                                    padding: const EdgeInsets.all(10),
                                                    decoration: BoxDecoration(
                                                      color: Colors.black,
                                                      borderRadius:
                                                          BorderRadius.circular(8),
                                                    ),
                                                    child: Column(
                                                      mainAxisSize: MainAxisSize.min,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          item.subFdr,
                                                          style: const TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        const SizedBox(height: 5),
                                                        Text.rich(
                                                          TextSpan(
                                                            text: "Cost : ",
                                                            style: const TextStyle(
                                                              //  fontSize: 16,
                                                              color: Colors.white,
                                                              fontWeight:
                                                                  FontWeight.bold,
                                                            ),
                                                            children: [
                                                              TextSpan(
                                                                  text:
                                                                      "\$${item.cost}",
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal)),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                              ),
                                              series: <CartesianSeries>[
                                                // StackedColumnSeries<
                                                //     DurationGraphModel, String>(
                                                //   dataSource: graphList,
                                                //   xValueMapper:
                                                //       (DurationGraphModel data,
                                                //               _) =>
                                                //           getXAxisValue(data),
                                                //   yValueMapper:
                                                //       (DurationGraphModel data,
                                                //               _) =>
                                                //           data.milesCompleted,
                                                //   name: 'Completed',
                                                //   dataLabelSettings:
                                                //       const DataLabelSettings(
                                                //     isVisible: true,
                                                //   ),
                                                // ),
                                                StackedColumnSeries<
                                                    DurationGraphModel, String>(
                                                  dataSource: graphList,
                                                  xValueMapper:
                                                      (DurationGraphModel data, _) =>
                                                          getXAxisValue(data),
                                                  yValueMapper:
                                                      (DurationGraphModel data, _) =>
                                                          data.cost,
                                                  name: 'Cost',
                                                  markerSettings:
                                                      const MarkerSettings(
                                                    isVisible: true,
                                                    shape: DataMarkerType.diamond,
                                                  ),
                                                  dataLabelSettings:
                                                      const DataLabelSettings(
                                                    isVisible: true,
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                            
                                    const SizedBox(height: 8),
                                    Card(
                                      elevation: 5,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(12),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            cardHeader("Overall Status"),
                                            const SizedBox(height: 8),
                                            // SfCircularChart(
                                            //   annotations: <CircularChartAnnotation>[
                                            //     CircularChartAnnotation(
                                            //       widget: Column(
                                            //         mainAxisSize: MainAxisSize.min,
                                            //         children: [
                                            //           Text(
                                            //              totalMilesPieChart.toStringAsFixed(2),
                                            //             style: const TextStyle(
                                            //               fontSize: 20,
                                            //               fontWeight: FontWeight.bold,
                                            //             ),
                                            //           ),
                                            //           const Text('Total Miles'),
                                            //         ],
                                            //       ),
                                            //     ),
                                            //   ],
                                            //   series: <CircularSeries>[
                                            //     DoughnutSeries<PieChartModel, String>(
                                            //       dataSource: pieChartList,
                                            //       xValueMapper:
                                            //           (PieChartModel data, _) =>
                                            //               data.title,
                                            //       yValueMapper:
                                            //           (PieChartModel data, _) =>
                                            //               data.value,
                                            //       dataLabelMapper: (PieChartModel
                                            //                   data,
                                            //               _) =>
                                            //           '${data.percentage.toStringAsFixed(1)}%',
                                            //       dataLabelSettings:
                                            //           const DataLabelSettings(
                                            //         isVisible: true,
                                            //       ),
                                            //       innerRadius: '70%',
                                            //     ),
                                            //   ],
                                            // )
                                            SfCircularChart(
                                              tooltipBehavior: tooltipBehavior,
                                              legend: Legend(
                                                isVisible: true,
                                                position: LegendPosition.top,
                                              ),
                                              palette: const <Color>[
                                                Color.fromRGBO(76, 175, 80, 1),
                                                Colors.orange,
                                              ],
                                              series: <CircularSeries>[
                                                DoughnutSeries<PieChartModel, String>(
                                                  dataSource: pieChartList,
                                                  xValueMapper:
                                                      (PieChartModel data, _) =>
                                                          data.title,
                                                  yValueMapper:
                                                      (PieChartModel data, _) =>
                                                          data.percentage,
                                                  pointColorMapper:
                                                      (PieChartModel data, _) {
                                                    switch (
                                                        data.title.toUpperCase()) {
                                                      case "COMPLETED":
                                                        return Colors.green;
                            
                                                      case "PENDING":
                                                        return Colors.orange;
                            
                                                      case "IN PROGRESS":
                                                        return Colors.blue;
                            
                                                      default:
                                                        return Colors.grey;
                                                    }
                                                  },
                                                  dataLabelMapper: (PieChartModel
                                                              data,
                                                          _) =>
                                                      '${data.miles.toStringAsFixed(2)} (${data.percentage.toStringAsFixed(1)}%)',
                                                  dataLabelSettings:
                                                      const DataLabelSettings(
                                                    isVisible: true,
                                                    labelPosition:
                                                        ChartDataLabelPosition
                                                            .outside,
                                                    textStyle: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.black,
                                                    ),
                                                    connectorLineSettings:
                                                        ConnectorLineSettings(
                                                      type: ConnectorType.curve,
                                                      length: '15%',
                                                      width: 2,
                                                    ),
                                                  ),
                                                  enableTooltip: true,
                                                  innerRadius: '60%',
                                                  radius: '80%',
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Card(
                                      elevation: 5,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(12),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            cardHeader("Generalforeman's Status"),
                                            const SizedBox(height: 8),
                                            SfCartesianChart(
                                              tooltipBehavior:
                                                  TooltipBehavior(enable: true),
                                              primaryXAxis: CategoryAxis(
                                                title: AxisTitle(
                                                  text: 'General Foreman',
                                                  textStyle: const TextStyle(
                                                    color: Colors.red,
                                                    fontFamily: 'Roboto',
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                majorGridLines:
                                                    const MajorGridLines(width: 0),
                                              ),
                                              primaryYAxis: NumericAxis(
                                                title: AxisTitle(
                                                  text: 'VALUE (IN MILES)',
                                                  textStyle: const TextStyle(
                                                    color: Colors.red,
                                                    fontFamily: 'Roboto',
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                axisLine: const AxisLine(width: 0),
                                                labelFormat: '{value}',
                                                majorTickLines:
                                                    const MajorTickLines(size: 0),
                                              ),
                                              legend: Legend(
                                                  isVisible: true,
                                                  position: LegendPosition.top),
                                              series: <CartesianSeries>[
                                                /// COMPLETED
                                                ColumnSeries<CrewMilesModel, String>(
                                                  name: 'MILES COMPLETED',
                                                  dataSource: crewMilesList,
                                                  xValueMapper:
                                                      (CrewMilesModel data, _) =>
                                                          data.crew,
                                                  yValueMapper:
                                                      (CrewMilesModel data, _) =>
                                                          data.milesCompleted,
                                                  color: Colors.green,
                                                  enableTooltip: true,
                                                  markerSettings:
                                                      const MarkerSettings(
                                                    isVisible: true,
                                                    shape: DataMarkerType.diamond,
                                                  ),
                                                  dataLabelSettings:
                                                      const DataLabelSettings(
                                                          isVisible: true),
                                                ),
                            
                                                /// IN PROGRESS
                                                ColumnSeries<CrewMilesModel, String>(
                                                  name: 'MILES IN PROGRESS',
                                                  dataSource: crewMilesList,
                                                  xValueMapper:
                                                      (CrewMilesModel data, _) =>
                                                          data.crew,
                                                  yValueMapper:
                                                      (CrewMilesModel data, _) =>
                                                          data.milesInProgress,
                                                  color: Colors.orange,
                                                  enableTooltip: true,
                                                  markerSettings:
                                                      const MarkerSettings(
                                                    isVisible: true,
                                                    shape: DataMarkerType.diamond,
                                                  ),
                                                  dataLabelSettings:
                                                      const DataLabelSettings(
                                                          isVisible: true),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(color: AppColors.baseColor),
              );
            }
          },
        ));
  }

  List<DurationGraphModel> graphList = [];

  // String getXAxisValue(DurationGraphModel data) {
  //   switch (selectedDuration) {
  //     case "Yearly":
  //       return data.year;

  //     case "Monthly":
  //       return data.month ?? '';

  //     case "Weekly":
  //       return data.weekDate ?? '';

  //     default:
  //       return '';
  //   }
  // }
  String getXAxisValue(DurationGraphModel data) {
    switch (selectedDuration) {
      case "Yearly":
        return data.year;

      case "Monthly":
        const months = [
          '',
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

        int monthIndex = int.tryParse(data.month ?? '') ?? 0;

        return months[monthIndex];

      case "Weekly":
        return data.weekDate ?? '';

      default:
        return '';
    }
  }

  void showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return Dialog(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 10.0, top: 16, right: 10.0, bottom: 10.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                          alignment: Alignment.centerRight,
                          child: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Icon(
                                Icons.close,
                                color: Colors.red,
                              ))),
                      textWithOutStar("Select Duration"),

                      /// Duration Dropdown
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: AppColors.baseColor,
                          ),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButtonFormField<String>(
                            hint: const Text('Select Duration'),
                            value: selectedDuration,
                            style: const TextStyle(
                                color: AppColors.baseColor, fontSize: 18),
                            icon: const Icon(
                              Icons.arrow_drop_down,
                              color: AppColors.baseColor,
                              size: 30,
                            ),
                            decoration: InputDecoration(
                              // labelText: "Select Duration",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              contentPadding: const EdgeInsets.all(10),
                              enabledBorder: const UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent)),
                              focusedBorder: const UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent)),
                            ),
                            items: durationList.map((item) {
                              return DropdownMenuItem(
                                value: item,
                                child: Text(item),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setStateDialog(() {
                                selectedDuration = value;
                                if (selectedDuration == "Weekly") {
                                  action = "WEEKLY";
                                } else if (selectedDuration == "Monthly") {
                                  action = "MONTHLY";
                                } else if (selectedDuration == "Yearly") {
                                  action = "Yearly";
                                }

                                /// reset values
                                selectedWeeks.clear();
                                selectedWeeksString = "";
                                selectedMonths.clear();
                                selectedmonthString = "";
                                selectedYear = null;
                              });
                            },
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),

                      if (selectedDuration == "Weekly" ||
                          selectedDuration == "Monthly" ||
                          selectedDuration == "Yearly") ...[
                        textWithOutStar("Select Year"),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: AppColors.baseColor,
                            ),
                          ),
                          child: DropdownButtonFormField<String>(
                            hint: const Text('Select Year'),
                            value: selectedYear,
                            style: const TextStyle(
                                color: AppColors.baseColor, fontSize: 18),
                            icon: const Icon(
                              Icons.arrow_drop_down,
                              color: AppColors.baseColor,
                              size: 30,
                            ),
                            decoration: InputDecoration(
                              // labelText: "Select Duration",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              contentPadding: const EdgeInsets.all(10),
                              enabledBorder: const UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent)),
                              focusedBorder: const UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent)),
                            ),
                            items: yearsList.map((year) {
                              return DropdownMenuItem(
                                value: year,
                                child: Text(year),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setStateDialog(() {
                                selectedYear = value;
                                if (selectedDuration == "Weekly") {
                                  selectedWeek = null;

                                  /// Generate Saturdays
                                  saturdayList = getSaturdayDates(
                                    int.parse(value!),
                                  );
                                }
                              });
                            },
                          ),
                        ),
                      ],
                      /////weekly fields
                      if (selectedDuration == "Weekly") ...[
                        const SizedBox(height: 10),
                        textWithOutStar("Select Week"),
                        //dropdown
                        // Container(
                        //   decoration: BoxDecoration(
                        //     borderRadius: BorderRadius.circular(10),
                        //     border: Border.all(
                        //       color: AppColors.baseColor,
                        //     ),
                        //   ),
                        //   child: DropdownButtonFormField<String>(
                        //     hint: const Text('Select Week'),
                        //     value: selectedWeek,
                        //     style: const TextStyle(
                        //         color: AppColors.baseColor, fontSize: 18),
                        //     icon: const Icon(
                        //       Icons.arrow_drop_down,
                        //       color: AppColors.baseColor,
                        //       size: 30,
                        //     ),
                        //     decoration: InputDecoration(
                        //       // labelText: "Select Duration",
                        //       border: OutlineInputBorder(
                        //         borderRadius: BorderRadius.circular(10),
                        //       ),
                        //       contentPadding: const EdgeInsets.all(10),
                        //       enabledBorder: const UnderlineInputBorder(
                        //           borderSide:
                        //               BorderSide(color: Colors.transparent)),
                        //       focusedBorder: const UnderlineInputBorder(
                        //           borderSide:
                        //               BorderSide(color: Colors.transparent)),
                        //     ),
                        //     menuMaxHeight: 250,
                        //     items: saturdayList.map((date) {
                        //       return DropdownMenuItem(
                        //         value: date,
                        //         child: Text(date),
                        //       );
                        //     }).toList(),
                        //     onChanged: (value) {
                        //       setStateDialog(() {
                        //         selectedWeek = value;
                        //       });
                        //     },
                        //   ),
                        // ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: AppColors.baseColor,
                            ),
                          ),
                          child: MultiSelectDialogField<String>(
                            items: saturdayList
                                .map(
                                  (e) => MultiSelectItem<String>(e, e),
                                )
                                .toList(),

                            title: const Text("Select Week"),

                            buttonText: const Text(
                              "Select Week",
                              style: TextStyle(
                                color: AppColors.baseColor,
                                fontSize: 16,
                              ),
                            ),

                            //  selectedColor: AppColors.baseColor,

                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.transparent,
                              ),
                            ),

                            searchable: true,
                            buttonIcon: const Icon(
                              Icons.arrow_drop_down,
                              color: AppColors.baseColor,
                              size: 30,
                            ),
                            listType: MultiSelectListType.CHIP,
                            initialValue: selectedWeeks,

                            itemsTextStyle: const TextStyle(
                              color: Colors.black,
                            ),

                            selectedItemsTextStyle: const TextStyle(
                              color: AppColors.baseColor,
                              fontWeight: FontWeight.bold,
                            ),

                            onConfirm: (values) {
                              setStateDialog(() {
                                selectedWeeks = values;
                                selectedWeeksString =
                                    values.join(',').toString();
                                selectedWeeksString = values.map((date) {
                                  DateTime parsedDate =
                                      DateFormat('MM/dd/yyyy').parse(date);
                                  return DateFormat('yyyy-MM-dd')
                                      .format(parsedDate);
                                }).join(',');
                                print(
                                    'selectedWeeksString $selectedWeeksString');
                              });
                            },
                          ),
                        )
                      ],
                      const SizedBox(height: 10),

                      /// Monthly Fields
                      if (selectedDuration == "Monthly") ...[
                        textWithOutStar("Select Months"),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: AppColors.baseColor,
                            ),
                          ),
                          child: MultiSelectDialogField(
                            items: monthsList
                                .map((e) => MultiSelectItem(e, e))
                                .toList(),
                            title: const Text("Months"),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.transparent,
                              ),
                            ),
                            buttonText: const Text("Select Months"),
                            buttonIcon: const Icon(
                              Icons.arrow_drop_down,
                              color: AppColors.baseColor,
                              size: 30,
                            ),
                            listType: MultiSelectListType.CHIP,
                            initialValue: selectedMonths,
                            onConfirm: (values) {
                              selectedMonths = values.cast<String>();
                              this.month = values.join(',');
                              monthh = month!.split(',');
                              print(monthh.length);
                              print(month);
                              monthnumber();
                            },
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],

                      /// Yearly Fields

                      const SizedBox(height: 10),
                      Center(
                        child: CustomButton(
                            label: "Submit",
                            onTap: () {
                              myFuture = fetchWeeklyMilesData();
                              fetchYearlyGraphData();
                              Navigator.pop(context);
                            },
                            showGradientColor: true),
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
  }

  void monthnumber() {
    selectedmonth.clear();
    print(monthh.length);
    for (int i = 0; i < monthh.length; i++) {
      var m;
      if (monthh[i] == 'Jan') {
        m = '01';
      } else if (monthh[i] == 'Feb') {
        m = '02';
      } else if (monthh[i] == 'Mar') {
        m = '03';
      } else if (monthh[i] == 'Apr') {
        m = '04';
      } else if (monthh[i] == 'May') {
        m = '05';
      } else if (monthh[i] == 'Jun') {
        m = '06';
      } else if (monthh[i] == 'Jul') {
        m = '07';
      } else if (monthh[i] == 'Aug') {
        m = '08';
      } else if (monthh[i] == 'Sep') {
        m = '09';
      } else if (monthh[i] == 'Oct') {
        m = '10';
      } else if (monthh[i] == 'Nov') {
        m = '11';
      } else if (monthh[i] == 'Dec') {
        m = '12';
      }

      selectedmonth.add(m);
      print('11selectedmonth${selectedmonth}');
      print('selectedmonthString ${selectedmonth.join(',')}');
      selectedmonthString = "${selectedmonth.join(',')}";
      // minmonth = selectedmonth[0];

      // maxmonth = selectedmonth[selectedmonth.length - 1];
      // print('minmonthnew${minmonth},${maxmonth}');
    }
  }

  /// HEADER CELL
  Widget headerCell(String text) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  /// TABLE CELL
  Widget tableCell(
    String text, {
    Color textColor = Colors.black,
    FontWeight fontWeight = FontWeight.normal,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontWeight: fontWeight,
        ),
      ),
    );
  }

  double totalMiles = 0.0;
  double milesCompleted = 0.0;
  double milesPending = 0.0;
  double totalMilesCompletedCost = 0.0;
  double completionPercentage = 0.0;
  double expectedMiles = 0.0;
  double standardExpectedMiles = 0.0;

  /// FETCH API's
  Future<void> fetchWeeklyMilesData() async {
    final url =
        "${AppUrl.getTransmissionHerbDashboardWeeklyMilesData}?year=$selectedYear&date=$selectedWeeksString&month=$selectedmonthString"
        // 'http://localhost:5125/civmapi/getDashboardWeeklyMilesData?year=2026',
        ;
    print('progress data Url $url');
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel userData = await userPreferences.getUser();
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer ${userData.token}',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);

        /// TOTALS OBJECT
        final totals = jsonResponse['totals'];

        totalMiles = (totals['totalMiles'] ?? 0).toDouble();
        milesCompleted = (totals['milesCompleted'] ?? 0).toDouble();
        milesPending = (totals['milesPending'] ?? 0).toDouble();
        totalMilesCompletedCost =
            (totals['totalMilesCompletedCost'] ?? 0).toDouble();
        completionPercentage = (totals['completionPercentage'] ?? 0).toDouble();
        expectedMiles = (totals['expectedMiles'] ?? 0).toDouble();
        standardExpectedMiles =
            (totals['standardExpectedMiles'] ?? 0).toDouble();

        /// GET RESULT ARRAY
        List jsonData = jsonResponse['result'];

        data = jsonData.map((e) => MileageModel.fromJson(e)).toList();

        /// GET ALL UNIQUE WEEK DATES
        Set<String> allWeeks = {};

        for (var item in data) {
          allWeeks.addAll(item.weeks.keys);
        }

        weekColumns = allWeeks.toList();

        /// SORT DATE
        weekColumns.sort();

        setState(() {});
      }
    } catch (e) {
      debugPrint("ERROR : $e");
    }
  }

  String action = "Yearly";
  List<YearlyMilesModel> yearlyMilesList = [];
  List<PieChartModel> pieChartList = [];
  double totalMilesPieChart = 0.0;
  List<CrewMilesModel> crewMilesList = [];
  Future<void> fetchYearlyGraphData() async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel userData = await userPreferences.getUser();
    final url =
        "${AppUrl.getTransmissionHerbDashboardFirstGraphData}?action=$action&year=$selectedYear&month=$selectedmonthString&week=$selectedWeeksString";
    print('graph Url $url');
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer ${userData.token}',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);

        if (jsonData['success'] == true) {
          final List data = jsonData['data'];

          // yearlyMilesList =
          //     data.map((e) => YearlyMilesModel.fromJson(e)).toList();
          graphList = data.map((e) => DurationGraphModel.fromJson(e)).toList();
          print(graphList.length);

          /// pie chart data
          // final milesData = jsonData['miles_data'];

          // totalMiles = (milesData['TOTALMILES'] ?? 0).toDouble();

          // double completed = (milesData['MILES_COMPLETED'] ?? 0).toDouble();

          // double pending = (milesData['MILES_PENDING'] ?? 0).toDouble();

          // double completedPercentage =
          //     totalMiles == 0 ? 0 : (completed / totalMiles) * 100;

          // double pendingPercentage = 100 - completedPercentage;

          // pieChartList = [
          //   PieChartModel(
          //     title: "Completed",
          //     value: completedPercentage,
          //     percentage: completedPercentage,
          //   ),
          //   PieChartModel(
          //     title: "Pending",
          //     value: pendingPercentage,
          //     percentage: pendingPercentage,
          //   ),
          // ];
          /// PIE CHART FROM percentAndStatus
          /// =========================

          final List percentData = jsonData['percentAndStatus'];

          pieChartList = percentData
              .where((e) => e['percentage'] != null)
              .map<PieChartModel>((e) {
            return PieChartModel(
              title: e['status'].toString(),
              value: (e['percentage'] ?? 0).toDouble(),
              percentage: (e['percentage'] ?? 0).toDouble(),
              miles: (e['miles'] ?? 0).toDouble(),
            );
          }).toList();

          ///column graph
          final List crewData =
              jsonData['findCrewMilesCompletedAndMilesInProgress'];

          crewMilesList =
              crewData.map((e) => CrewMilesModel.fromJson(e)).toList();
          setState(() {});
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
