// ignore: file_names
import 'dart:convert';

import 'package:CIVM/models/iVMMaintenanceProgressDashboardModel.dart';
import 'package:CIVM/resources/app_url.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:CIVM/models/user_model.dart';
import 'package:CIVM/screens/leaflat_map/leaf_lat_map_wakeLock.dart';
import 'package:CIVM/screens/map/provider/location_provider.dart';
import 'package:CIVM/sharedPrefs/constants.dart';
import 'package:CIVM/utils/user_pref.dart';
import 'package:CIVM/utils/common_functions.dart';
import 'package:CIVM/screens/supervisor_pannel/sup_change_order_all_status.dart';
import 'package:CIVM/screens/supervisor_pannel/supervisor_user_management_tabs.dart';
import 'package:CIVM/screens/login_page.dart';
import 'package:CIVM/screens/supervisor_pannel/supervisor_add_new_row_table.dart';
import 'package:CIVM/screens/supervisor_pannel/supervisor_bottom_navigation_pannel.dart';
import 'package:CIVM/screens/supervisor_pannel/supervisor_inspection_zielies.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';

// ignore: must_be_immutable
class SupervisorRowMaintenanceProgressDashboard extends StatefulWidget {
  const SupervisorRowMaintenanceProgressDashboard({super.key});

  @override
  State<SupervisorRowMaintenanceProgressDashboard> createState() =>
      _SupervisorRowMaintenanceProgressDashboardState();
}

class _SupervisorRowMaintenanceProgressDashboardState
    extends State<SupervisorRowMaintenanceProgressDashboard> {
  List<_ChartDataSimpleColumnChart1> dataSimpleColumnChart1 = [];
  List<_ChartDataSimpleColumnChart2> chartDataSimpleColumnChart2 = [];
  List<Chart6HorizontalStacked> chart6HorizontalStacked = [];

  List<Chart4ColumnStacked> chart4ColumnStacked = [];

  List<Chart9ColumnStacked> chart9ColumnStacked = [];

  List<Chart10ColumnStacked> chart10ColumnStacked = [];

  List<Chart11ColumnStacked> chart11ColumnStacked = [];

  late List<_ChartDataSimpleColumnChart5> dataSimpleColumnChart5;

  late List<_ChartDataSimpleColumnChart8> dataSimpleColumnChart8;

  // late final List<charts.Series> seriesList;
  late final bool animate = true;
  late final Future? myFuture;
  var result = [];
  List<String> menu = [];

  String name = '';

  late Future<IVMMaintenanceProgressDashboardModel> dashboardFuture;

  String? selectedYear;

  List<String> selectedSubstations = [];
  List<String> selectedFeeders = [];

  List<String> yearList = [];

  List<DropdownItem> substationList = [];
  List<DropdownItem> feederList = [];
  DateTime now = DateTime.now();

  int currentYear = DateTime.now().year;

  @override
  void initState() {
    selectedYear = currentYear.toString();
    dashboardFuture = getDashboardData();
    _initializeScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'IVM Maintenance Progress',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 7, 59, 120),
        actions: [
          InkWell(
            onTap: () {
              _initializeScreen();
              showFilterDialog(context);
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
      body: FutureBuilder<IVMMaintenanceProgressDashboardModel>(
        future: dashboardFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          final data = snapshot.data!;
          yearList = data.years ?? [];
          substationList = data.substations ?? [];
          feederList = data.feeders ?? [];

          return RefreshIndicator(
              onRefresh: () async {
                dashboardFuture = getDashboardData(
                  year: selectedYear,
                  substations: selectedSubstations,
                  feeders: selectedFeeders,
                );
                _initializeScreen();
              },child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      children: [
                        Expanded(
                          child: _summaryCard(
                            title: "TOTAL",
                            value:
                                data.status?.totalMiles?.toStringAsFixed(2) ??
                                "0.00",
                            subtitle:
                                "${data.status?.workOrders ?? 0} Work Orders",
                            color: const Color.fromARGB(255, 7, 59, 120),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _summaryCard(
                            title: "COMPLETED",
                            value:
                                data.status?.completedMiles?.toStringAsFixed(2) ??
                                "0.00",
                            subtitle:
                                "${data.status?.completedPct?.toStringAsFixed(1) ?? "0.0"} %",
                            progress: (data.status?.completedPct ?? 0) / 100,
                            color: Colors.green,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _summaryCard(
                            title: "PENDING",
                            value:
                                data.status?.pendingMiles?.toStringAsFixed(2) ??
                                "0.00",
                            subtitle:
                                "${data.status?.pendingPct?.toStringAsFixed(1) ?? "0.0"} %",
                            progress: (data.status?.pendingPct ?? 0) / 100,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 10,
                    ),
                    padding: const EdgeInsets.all(8),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromARGB(255, 3, 47, 97),
                          blurRadius: 10,
                          offset: Offset(2, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        /// Header
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: const Color.fromARGB(255, 7, 59, 120),
                          ),
                          child: const Text(
                            "Overall Status",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
            
                        const SizedBox(height: 18),
            
                        /// Percentages
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    "${data.status?.completedPct?.toStringAsFixed(1) ?? "0.0"} %",
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  const Text(
                                    "COMPLETED",
                                    style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    "${data.status?.pendingPct?.toStringAsFixed(1) ?? "0.0"} %",
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  const Text(
                                    "PENDING",
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
            
                        const SizedBox(height: 25),
            
                        /// Pie Chart
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: PieChart(
                            dataMap: {
                              "Completed": data.status?.completedPct ?? 0,
                              "Pending": data.status?.pendingPct ?? 0,
                            },
                            colorList: const [Colors.green, Colors.red],
                            animationDuration: const Duration(milliseconds: 800),
                            chartType: ChartType.ring,
                            ringStrokeWidth: 32,
                            chartRadius: MediaQuery.of(context).size.width / 2.5,
                            legendOptions: const LegendOptions(
                              showLegends: true,
                              legendTextStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            chartValuesOptions: const ChartValuesOptions(
                              showChartValues: true,
                              showChartValuesInPercentage: true,
                              showChartValueBackground: false,
                              decimalPlaces: 1,
                            ),
                          ),
                        ),
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
                    height: size.height * 0.55,
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
                            color: Color.fromARGB(255, 130, 193, 245),
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
                                  "Crew's Work",
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
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: SizedBox(
                              width: 700,
                              child: SfCartesianChart(
                                primaryXAxis: CategoryAxis(
                                  title: AxisTitle(
                                    text: 'CREW',
                                    textStyle: const TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  majorGridLines: const MajorGridLines(width: 0),
                                ),
                                primaryYAxis: NumericAxis(
                                  interval: 1,
                                  title: AxisTitle(
                                    text: 'MILES',
                                    textStyle: const TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  majorTickLines: const MajorTickLines(size: 0),
                                  axisLine: const AxisLine(width: 0),
                                ),
                                legend: const Legend(isVisible: true),
                                palette: const [Colors.green, Colors.red],
                                tooltipBehavior: TooltipBehavior(enable: true),
                                series: [
                                  /// Completed
                                  ColumnSeries<
                                    _ChartDataSimpleColumnChart1,
                                    String
                                  >(
                                    name: "Completed",
                                    dataSource: recreateCrewChartData(data),
                                    xValueMapper: (d, _) => d.x,
                                    yValueMapper: (d, _) => d.y1,
                                    dataLabelSettings: const DataLabelSettings(
                                      isVisible: true,
                                    ),
                                    enableTooltip: true,
                                  ),
            
                                  /// Pending
                                  ColumnSeries<
                                    _ChartDataSimpleColumnChart1,
                                    String
                                  >(
                                    name: "Pending",
                                    dataSource: recreateCrewChartData(data),
                                    xValueMapper: (d, _) => d.x,
                                    yValueMapper: (d, _) => d.y2,
                                    dataLabelSettings: const DataLabelSettings(
                                      isVisible: true,
                                    ),
                                    enableTooltip: true,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
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
                    // padding: const EdgeInsets.all(8),
                    alignment: Alignment.center,
                    height: size.height * 0.6,
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
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 8.0,
                            right: 8,
                            top: 8,
                          ),
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
                                  color: Color.fromARGB(255, 3, 47, 97),
                                  blurRadius: 5,
                                  offset: Offset(2.0, 5.0),
                                ),
                              ],
                              color: Color.fromARGB(255, 130, 193, 245),
                              gradient: LinearGradient(
                                colors: [
                                  Color.fromARGB(255, 7, 59, 120),
                                  Color.fromARGB(255, 7, 59, 120),
                                ],
                              ),
                            ),
                            child: const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Performance by Maintenance Type",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: SizedBox(
                                width: 700,
                                child: SfCartesianChart(
                                  tooltipBehavior: TooltipBehavior(
                                    enable: true,
                                    header: '',
                                    format:
                                        'point.x\nseries.name : point.y Miles',
                                  ),
            
                                  primaryXAxis: CategoryAxis(
                                    interval: 1,
                                    maximumLabels: 20,
                                    labelsExtent: 30,
                                    labelRotation: 0,
                                    labelIntersectAction:
                                        AxisLabelIntersectAction.multipleRows,
                                    majorGridLines: const MajorGridLines(
                                      width: 0,
                                    ),
                                    title: AxisTitle(
                                      text: "MAINTENANCE TYPE",
                                      textStyle: const TextStyle(
                                        color: Colors.red,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
            
                                  primaryYAxis: NumericAxis(
                                    interval: 1,
                                    title: AxisTitle(
                                      text: "MILES",
                                      textStyle: const TextStyle(
                                        color: Colors.red,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    axisLine: const AxisLine(width: 0),
                                    majorTickLines: const MajorTickLines(size: 0),
                                  ),
            
                                  legend: const Legend(isVisible: true),
            
                                  series: <CartesianSeries>[
                                    ColumnSeries<MaintenanceTypeChart, String>(
                                      name: "Total Miles",
                                      dataSource: recreateMaintenanceTypeData(
                                        data,
                                      ),
            
                                      xValueMapper: (d, _) => d.type,
                                      yValueMapper: (d, _) => d.totalMiles,
            
                                      pointColorMapper: (d, _) =>
                                          getColorFromName(d.type),
            
                                      dataLabelSettings: const DataLabelSettings(
                                        isVisible: true,
                                      ),
            
                                      enableTooltip: true,
                                    ),
            
                                    ColumnSeries<MaintenanceTypeChart, String>(
                                      name: "Completed Miles",
                                      dataSource: recreateMaintenanceTypeData(
                                        data,
                                      ),
            
                                      xValueMapper: (d, _) => d.type,
                                      yValueMapper: (d, _) => d.completedMiles,
            
                                      pointColorMapper: (d, _) =>
                                          getColorFromName(
                                            d.type,
                                          ).withOpacity(0.55),
            
                                      dataLabelSettings: const DataLabelSettings(
                                        isVisible: true,
                                      ),
            
                                      enableTooltip: true,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 10,
                    ),
                    padding: const EdgeInsets.all(8),
                    height: size.height * 0.70,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromARGB(255, 3, 47, 97),
                          blurRadius: 10,
                          offset: Offset(2, 5),
                        ),
                      ],
                    ),
                    child: ListView.builder(
                      itemCount: data.types?.length ?? 0,
                      itemBuilder: (context, index) {
                        final item = data.types![index];
            
                        final total = item.totalMiles ?? 0;
                        final completed = item.completedMiles ?? 0;
                        final pending = item.pendingMiles ?? 0;
            
                        final progress = total == 0 ? 0.0 : completed / total;
            
                        return Card(
                          elevation: 3,
                          margin: const EdgeInsets.only(bottom: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(14),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                /// Maintenance Type
                                Row(
                                  children: [
                                    Container(
                                      width: 16,
                                      height: 16,
                                      decoration: BoxDecoration(
                                        color: getColorFromName(
                                          item.maintType ?? "",
                                        ),
                                        borderRadius: BorderRadius.circular(3),
                                      ),
                                    ),
            
                                    const SizedBox(width: 8),
            
                                    Expanded(
                                      child: Text(
                                        item.maintType ?? "",
                                        style: const TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromARGB(255, 7, 59, 120),
                                        ),
                                      ),
                                    ),
            
                                    Text(
                                      "${item.percent?.toStringAsFixed(1) ?? "0"}%",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
            
                                const Divider(height: 22),
            
                                Row(
                                  children: [
                                    Expanded(
                                      child: _infoRow(
                                        "TOTAL MILES",
                                        total.toStringAsFixed(2),
                                      ),
                                    ),
                                    Expanded(
                                      child: _infoRow(
                                        "COMPLETED",
                                        completed.toStringAsFixed(2),
                                      ),
                                    ),
                                  ],
                                ),
            
                                const SizedBox(height: 8),
            
                                Row(
                                  children: [
                                    Expanded(
                                      child: _infoRow(
                                        "PENDING",
                                        pending.toStringAsFixed(2),
                                      ),
                                    ),
                                    Expanded(
                                      child: _infoRow(
                                        "PROGRESS",
                                        "${(progress * 100).toStringAsFixed(1)}%",
                                      ),
                                    ),
                                  ],
                                ),
            
                                const SizedBox(height: 14),
            
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: LinearProgressIndicator(
                                    value: progress,
                                    minHeight: 9,
                                    backgroundColor: Colors.grey.shade300,
                                    valueColor: AlwaysStoppedAnimation(
                                      getColorFromName(item.maintType ?? ""),
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
            
                  Container(
                    margin: const EdgeInsets.only(
                      top: 10,
                      bottom: 10,
                      left: 8,
                      right: 8,
                    ),
                    padding: const EdgeInsets.all(8),
                    alignment: Alignment.center,
                    height: size.height * 0.7,
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
                            color: Color.fromARGB(255, 130, 193, 245),
                            gradient: LinearGradient(
                              colors: [
                                Color.fromARGB(255, 7, 59, 120),
                                Color.fromARGB(255, 7, 59, 120),
                              ],
                            ),
                          ),
                          child: const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Monthly Performance",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: SizedBox(
                                width: 700,
                                child: SfCartesianChart(
                                  tooltipBehavior: TooltipBehavior(
                                    enable: true,
                                    format:
                                        'point.x\nseries.name : point.y Miles',
                                  ),
            
                                  primaryXAxis: CategoryAxis(
                                    interval: 1,
                                    title: AxisTitle(
                                      text: 'Month',
                                      textStyle: const TextStyle(
                                        color: Colors.red,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    majorGridLines: const MajorGridLines(
                                      width: 0,
                                    ),
                                  ),
            
                                  primaryYAxis: NumericAxis(
                                    interval: 1,
                                    title: AxisTitle(
                                      text: 'Miles',
                                      textStyle: const TextStyle(
                                        color: Colors.red,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    axisLine: const AxisLine(width: 0),
                                    majorTickLines: const MajorTickLines(size: 0),
                                  ),
            
                                  legend: const Legend(isVisible: true),
            
                                  palette: const [
                                    Colors.grey, // Total Miles
                                    Colors.green, // Completed Miles
                                  ],
            
                                  series: <CartesianSeries>[
                                    ColumnSeries<MonthlyPerformanceChart, String>(
                                      name: "Total Miles",
                                      dataSource: recreateMonthlyData(data),
                                      xValueMapper: (d, _) => d.month,
                                      yValueMapper: (d, _) => d.plannedMiles,
                                      enableTooltip: true,
                                      dataLabelSettings: const DataLabelSettings(
                                        isVisible: true,
                                      ),
                                    ),
            
                                    ColumnSeries<MonthlyPerformanceChart, String>(
                                      name: "Completed Miles",
                                      dataSource: recreateMonthlyData(data),
                                      xValueMapper: (d, _) => d.month,
                                      yValueMapper: (d, _) => d.completedMiles,
                                      enableTooltip: true,
                                      dataLabelSettings: const DataLabelSettings(
                                        isVisible: true,
                                      ),
                                    ),
                                  ],
                                ),
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
          );
        },
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
    value: item,
    child: Text(
      item,
      style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 20),
    ),
  );

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

  Future<void> showFilterDialog(BuildContext context) async {
    bool isLoadingDefaults = true;
    bool isLoadingSubstations = false;
    bool isLoadingFeeders = false;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (dialogContext, setDialogState) {
            // ============================================================
            // LOAD DEFAULT FILTER DATA AFTER DIALOG IS ALREADY OPEN
            // ============================================================
            if (isLoadingDefaults) {
              Future.microtask(() async {
                try {
                  print("==============================");
                  print("Loading default dashboard filters");
                  print("Year: $selectedYear");
                  print("==============================");

                  // ========================================================
                  // GET SUBSTATIONS
                  // ========================================================
                  final data = await getDashboardData(
                    year: selectedYear,
                    substations: [],
                    feeders: [],
                  );

                  if (!dialogContext.mounted) {
                    return;
                  }

                  // All substations
                  substationList = data.substations ?? [];

                  if (selectedSubstations.isEmpty) {
                    selectedSubstations = substationList
                        .map((e) => e.id!)
                        .toList();
                  }

                  print("Selected substations: $selectedSubstations");

                  print("Default substations: $selectedSubstations");

                  // Start feeder loading
                  setDialogState(() {
                    isLoadingDefaults = false;
                    isLoadingFeeders = true;
                  });

                  // ========================================================
                  // GET FEEDERS FOR ALL SUBSTATIONS
                  // ========================================================
                  final feederData = await getDashboardData(
                    year: selectedYear,
                    substations: selectedSubstations,
                    feeders: [],
                  );

                  if (!dialogContext.mounted) {
                    return;
                  }

                  feederList = feederData.feeders ?? [];

                  // All feeders
                  if (selectedFeeders.isEmpty) {
                    selectedFeeders = feederList.map((e) => e.id!).toList();
                  }

                  print("Selected feeders: $selectedFeeders");

                  print("Default feeders: $selectedFeeders");

                  setDialogState(() {
                    isLoadingFeeders = false;
                  });

                  print("==============================");
                  print("Default filters loaded");
                  print("Year: $selectedYear");
                  print("Substations: $selectedSubstations");
                  print("Feeders: $selectedFeeders");
                  print("==============================");
                } catch (e) {
                  print("Error loading default filters: $e");

                  if (!dialogContext.mounted) {
                    return;
                  }

                  setDialogState(() {
                    isLoadingDefaults = false;
                    isLoadingFeeders = false;
                  });

                  substationList = [];
                  feederList = [];
                  selectedSubstations = [];
                  selectedFeeders = [];
                }
              });

              // ============================================================
              // LOADING UI
              // ============================================================
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),

                titlePadding: const EdgeInsets.fromLTRB(20, 18, 10, 0),

                title: Row(
                  children: [
                    const Icon(
                      Icons.filter_alt_rounded,
                      color: Color.fromARGB(255, 7, 59, 120),
                    ),

                    const SizedBox(width: 8),

                    const Expanded(
                      child: Text(
                        "Filters",
                        style: TextStyle(
                          color: Color.fromARGB(255, 7, 59, 120),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        Navigator.pop(dialogContext);
                      },
                    ),
                  ],
                ),

                content: const SizedBox(
                  width: 300,
                  height: 150,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),

                      SizedBox(height: 20),

                      Text(
                        "Loading filters...",
                        style: TextStyle(color: Colors.grey, fontSize: 15),
                      ),
                    ],
                  ),
                ),
              );
            }

            // ============================================================
            // NORMAL FILTER DIALOG
            // ============================================================

            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),

              titlePadding: const EdgeInsets.fromLTRB(20, 18, 10, 0),

              title: Row(
                children: [
                  const Icon(
                    Icons.filter_alt_rounded,
                    color: Color.fromARGB(255, 7, 59, 120),
                  ),

                  const SizedBox(width: 8),

                  const Expanded(
                    child: Text(
                      "Filters",
                      style: TextStyle(
                        color: Color.fromARGB(255, 7, 59, 120),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      Navigator.pop(dialogContext);
                    },
                  ),
                ],
              ),

              content: SizedBox(
                width: MediaQuery.of(dialogContext).size.width,

                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      // ====================================================
                      // YEAR
                      // ====================================================
                      const Text(
                        "Year",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),

                      const SizedBox(height: 8),

                      InkWell(
                        onTap: yearList.isEmpty
                            ? null
                            : () async {
                                final String? value =
                                    await showYearSelectionDialog(
                                      context: dialogContext,
                                      years: yearList,
                                      selectedYear: selectedYear,
                                    );

                                if (value == null) {
                                  return;
                                }

                                // ==========================================
                                // YEAR CHANGED
                                // ==========================================

                                setDialogState(() {
                                  selectedYear = value;

                                  selectedSubstations.clear();
                                  selectedFeeders.clear();

                                  substationList.clear();
                                  feederList.clear();

                                  isLoadingSubstations = true;
                                  isLoadingFeeders = false;
                                });

                                try {
                                  print("==============================");
                                  print("Getting substations");
                                  print("Year: $selectedYear");
                                  print("==============================");

                                  final data = await getDashboardData(
                                    year: selectedYear,
                                    substations: [],
                                    feeders: [],
                                  );

                                  if (!dialogContext.mounted) {
                                    return;
                                  }

                                  setDialogState(() {
                                    substationList = data.substations ?? [];

                                    feederList = [];

                                    isLoadingSubstations = false;
                                  });

                                  print(
                                    "Substations loaded: "
                                    "${substationList.length}",
                                  );
                                } catch (e) {
                                  print("Error loading substations: $e");

                                  if (!dialogContext.mounted) {
                                    return;
                                  }

                                  setDialogState(() {
                                    isLoadingSubstations = false;
                                  });
                                }
                              },

                        child: Container(
                          width: double.infinity,

                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 15,
                          ),

                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade400),
                            borderRadius: BorderRadius.circular(4),
                            color: Colors.white,
                          ),

                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  selectedYear == null || selectedYear!.isEmpty
                                      ? "Select Year"
                                      : selectedYear!,
                                  style: TextStyle(
                                    color:
                                        selectedYear == null ||
                                            selectedYear!.isEmpty
                                        ? Colors.grey
                                        : Colors.black87,
                                  ),
                                ),
                              ),

                              const Icon(
                                Icons.arrow_drop_down,
                                color: Colors.black54,
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // ====================================================
                      // SUBSTATION
                      // ====================================================
                      const Text(
                        "Substation",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),

                      const SizedBox(height: 8),

                      // ====================================================
                      // SUBSTATION LOADER
                      // ====================================================
                      if (isLoadingSubstations)
                        Container(
                          height: 55,
                          width: double.infinity,

                          padding: const EdgeInsets.symmetric(horizontal: 16),

                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade400),
                            borderRadius: BorderRadius.circular(4),
                          ),

                          child: const Row(
                            children: [
                              SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              ),

                              SizedBox(width: 12),

                              Text(
                                "Loading substations...",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        )
                      else
                        // ==================================================
                        // SUBSTATION BOX
                        // ==================================================
                        InkWell(
                          onTap: substationList.isEmpty
                              ? null
                              : () async {
                                  final values =
                                      await showCustomMultiSelectDialog(
                                        context: dialogContext,
                                        title: "Select Substation",
                                        items: substationList,
                                        getId: (e) => e.id!,
                                        getName: (e) => e.name!,
                                        initialSelected: selectedSubstations,
                                      );

                                  if (values == null) {
                                    return;
                                  }

                                  // ========================================
                                  // SAVE SUBSTATIONS
                                  // ========================================

                                  setDialogState(() {
                                    selectedSubstations = values;

                                    selectedFeeders.clear();
                                    feederList.clear();

                                    isLoadingFeeders = values.isNotEmpty;
                                  });

                                  // ========================================
                                  // NO SUBSTATION
                                  // ========================================

                                  if (values.isEmpty) {
                                    setDialogState(() {
                                      feederList = [];
                                      isLoadingFeeders = false;
                                    });

                                    return;
                                  }

                                  try {
                                    print("==============================");
                                    print("Getting feeders");
                                    print("Year: $selectedYear");
                                    print("Substations: $values");
                                    print("==============================");

                                    final data = await getDashboardData(
                                      year: selectedYear,
                                      substations: values,
                                      feeders: [],
                                    );

                                    if (!dialogContext.mounted) {
                                      return;
                                    }

                                    setDialogState(() {
                                      feederList = data.feeders ?? [];

                                      isLoadingFeeders = false;
                                    });

                                    print(
                                      "Feeders loaded: "
                                      "${feederList.length}",
                                    );
                                  } catch (e) {
                                    print("Error loading feeders: $e");

                                    if (!dialogContext.mounted) {
                                      return;
                                    }

                                    setDialogState(() {
                                      isLoadingFeeders = false;
                                    });
                                  }
                                },

                          child: Container(
                            width: double.infinity,

                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 15,
                            ),

                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade400),
                              borderRadius: BorderRadius.circular(4),
                              color: Colors.white,
                            ),

                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    selectedSubstations.isEmpty
                                        ? "Select Substation"
                                        : selectedSubstations.length ==
                                              substationList.length
                                        ? "All Substations"
                                        : "${selectedSubstations.length} selected",
                                    style: TextStyle(
                                      color: selectedSubstations.isEmpty
                                          ? Colors.grey
                                          : Colors.black87,
                                    ),
                                  ),
                                ),

                                const Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.black54,
                                ),
                              ],
                            ),
                          ),
                        ),

                      const SizedBox(height: 20),

                      // ====================================================
                      // FEEDER
                      // ====================================================
                      const Text(
                        "Feeder",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),

                      const SizedBox(height: 8),

                      // ====================================================
                      // FEEDER LOADER
                      // ====================================================
                      if (isLoadingFeeders)
                        Container(
                          height: 55,
                          width: double.infinity,

                          padding: const EdgeInsets.symmetric(horizontal: 16),

                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade400),
                            borderRadius: BorderRadius.circular(4),
                          ),

                          child: const Row(
                            children: [
                              SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              ),

                              SizedBox(width: 12),

                              Text(
                                "Loading feeders...",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        )
                      else
                        // ==================================================
                        // FEEDER BOX
                        // ==================================================
                        IgnorePointer(
                          ignoring: selectedSubstations.isEmpty,

                          child: Opacity(
                            opacity: selectedSubstations.isEmpty ? 0.5 : 1.0,

                            child: InkWell(
                              onTap: feederList.isEmpty
                                  ? null
                                  : () async {
                                      final values =
                                          await showCustomMultiSelectDialog(
                                            context: dialogContext,
                                            title: "Select Feeder",
                                            items: feederList,
                                            getId: (e) => e.id!,
                                            getName: (e) => e.name!,
                                            initialSelected: selectedFeeders,
                                          );

                                      if (values == null) {
                                        return;
                                      }

                                      setDialogState(() {
                                        selectedFeeders = values;
                                      });

                                      print(
                                        "Selected feeders: "
                                        "$selectedFeeders",
                                      );
                                    },

                              child: Container(
                                width: double.infinity,

                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 15,
                                ),

                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey.shade400,
                                  ),
                                  borderRadius: BorderRadius.circular(4),
                                  color: Colors.white,
                                ),

                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        selectedFeeders.isEmpty
                                            ? "Select Feeder"
                                            : selectedFeeders.length ==
                                                  feederList.length
                                            ? "All Feeders"
                                            : "${selectedFeeders.length} selected",
                                        style: TextStyle(
                                          color: selectedFeeders.isEmpty
                                              ? Colors.grey
                                              : Colors.black87,
                                        ),
                                      ),
                                    ),

                                    const Icon(
                                      Icons.arrow_drop_down,
                                      color: Colors.black54,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),

                      const SizedBox(height: 25),

                      // ====================================================
                      // APPLY BUTTON
                      // ====================================================
                      SizedBox(
                        width: double.infinity,
                        height: 48,

                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.check),

                          label: const Text(
                            "Apply",
                            style: TextStyle(fontSize: 16),
                          ),

                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(
                              255,
                              7,
                              59,
                              120,
                            ),
                            foregroundColor: Colors.white,

                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),

                          onPressed: () {
                            print("==============================");

                            print("Applying Dashboard Filters");

                            print("Year: $selectedYear");

                            print(
                              "Substations: "
                              "$selectedSubstations",
                            );

                            print(
                              "Feeders: "
                              "$selectedFeeders",
                            );

                            print("==============================");

                            Navigator.pop(dialogContext);

                            setState(() {
                              dashboardFuture = getDashboardData(
                                year: selectedYear,
                                substations: selectedSubstations,
                                feeders: selectedFeeders,
                              );
                            });
                          },
                        ),
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

  Widget _summaryCard({
    required String title,
    required String value,
    required String subtitle,
    double? progress,
    required Color color,
  }) {
    return Card(
      elevation: 4,
      shadowColor: color.withOpacity(.2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          gradient: LinearGradient(colors: [color, color.withOpacity(.85)]),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.white70,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),

            const SizedBox(height: 5),

            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),

            const SizedBox(height: 2),

            Text(
              subtitle,
              style: const TextStyle(color: Colors.white70, fontSize: 12),
            ),

            /// Show progress only when available
            if (progress != null) ...[
              const SizedBox(height: 10),
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: LinearProgressIndicator(
                  value: progress.clamp(0.0, 1.0),
                  minHeight: 6,
                  backgroundColor: Colors.white24,
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _infoRow(String title, String value) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(
          color: Color.fromARGB(255, 7, 59, 120),
          fontSize: 13,
        ),
        children: [
          TextSpan(
            text: "$title : ",
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Color.fromARGB(255, 7, 59, 120),
            ),
          ),
          TextSpan(
            text: value,
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              color: Color.fromARGB(255, 7, 59, 120),
            ),
          ),
        ],
      ),
    );
  }

  Future<IVMMaintenanceProgressDashboardModel> getDashboardData({
    String? year,
    List<String>? substations,
    List<String>? feeders,
  }) async {
    final token = Constants.prefs.getString('token');

    final uri =
        Uri.parse(
          "https://civm2.ariespro.com/civm2/row_maintenance_progress/row_maintenance_data_progress_dashboard",
        ).replace(
          queryParameters: {
            "year": year ?? "",
            "substations": substations == null ? "" : substations.join(","),
            "feeder": feeders == null ? "" : feeders.join(","),
          },
        );

    print(uri);

    final response = await http.get(
      uri,
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
    );

    print(response.body);

    if (response.statusCode == 200) {
      return IVMMaintenanceProgressDashboardModel.fromJson(
        jsonDecode(response.body),
      );
    }

    throw Exception("Unable to load dashboard");
  }

  List<_ChartDataSimpleColumnChart1> recreateCrewChartData(
    IVMMaintenanceProgressDashboardModel data,
  ) {
    return (data.crews ?? []).map((e) {
      return _ChartDataSimpleColumnChart1(
        e.name ?? "",
        e.completedMiles ?? 0,
        e.pendingMiles ?? 0,
      );
    }).toList();
  }

  List<MaintenanceTypeChart> recreateMaintenanceTypeData(
    IVMMaintenanceProgressDashboardModel data,
  ) {
    return (data.types ?? []).map((e) {
      return MaintenanceTypeChart(
        e.maintType ?? "",
        e.totalMiles ?? 0,
        e.completedMiles ?? 0,
      );
    }).toList();
  }

  Color getColorFromName(String color) {
    switch (color.toUpperCase().trim()) {
      case "JARRAFF":
        return Colors.purple;

      case "MINI JARRAFF":
        return Colors.red;

      case "NO SPRAY":
        return Colors.pink;

      case "MOWING":
        return Colors.brown;

      case "BUCKET":
        return Colors.orange;

      case "GROUND":
        return Colors.yellow;

      case "CROSS-COUNTRY SPRAY":
        return const Color.fromARGB(255, 59, 2, 248);

      case "ROADSIDE SPRAY":
        return Colors.green;

      case "BYL":
        return Colors.blue;

      default:
        return Colors.grey;
    }
  }

  List<MonthlyPerformanceChart> recreateMonthlyData(
    IVMMaintenanceProgressDashboardModel data,
  ) {
    return (data.months ?? [])
        .map(
          (e) => MonthlyPerformanceChart(
            month: e.monthName ?? "",
            plannedMiles: e.plannedMiles ?? 0,
            completedMiles: e.completedMiles ?? 0,
            pendingMiles: e.pendingMiles ?? 0,
          ),
        )
        .toList();
  }

  Future<List<String>?> showCustomMultiSelectDialog<T>({
    required BuildContext context,
    required String title,
    required List<T> items,
    required String Function(T) getId,
    required String Function(T) getName,
    required List<String> initialSelected,
  }) async {
    List<String> tempSelected = List<String>.from(initialSelected);

    return showDialog<List<String>>(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (dialogContext, setState) {
            final bool allSelected =
                items.isNotEmpty && tempSelected.length == items.length;

            void toggleSelectAll() {
              setState(() {
                if (allSelected) {
                  // Unselect everything
                  tempSelected.clear();
                } else {
                  // Select everything
                  tempSelected = items.map((e) => getId(e)).toList();
                }
              });
            }

            void toggleItem(String id) {
              setState(() {
                if (tempSelected.contains(id)) {
                  tempSelected.remove(id);
                } else {
                  tempSelected.add(id);
                }
              });
            }

            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              title: Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              content: SizedBox(
                width: 450,
                height: 400,
                child: Column(
                  children: [
                    CheckboxListTile(
                      value: allSelected,
                      tristate: true,

                      title: const Text(
                        "Select All",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),

                      controlAffinity: ListTileControlAffinity.leading,

                      onChanged: (_) {
                        toggleSelectAll();
                      },
                    ),

                    const Divider(),
                    Expanded(
                      child: ListView.builder(
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          final item = items[index];

                          final String id = getId(item);
                          final String name = getName(item);

                          final bool isSelected = tempSelected.contains(id);

                          return CheckboxListTile(
                            value: isSelected,

                            title: Text(name),

                            controlAffinity: ListTileControlAffinity.leading,

                            onChanged: (_) {
                              toggleItem(id);
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),

              // ===========================================================
              // ACTIONS
              // ===========================================================
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(dialogContext);
                  },
                  child: const Text("Cancel"),
                ),

                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(dialogContext, tempSelected);
                  },
                  child: const Text("Done"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<String?> showYearSelectionDialog({
    required BuildContext context,
    required List<String> years,
    required String? selectedYear,
  }) async {
    String? tempSelectedYear = selectedYear;

    return showDialog<String>(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (dialogContext, setDialogState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              title: const Text(
                "Select Year",
                style: TextStyle(
                  color: Color.fromARGB(255, 7, 59, 120),
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: SizedBox(
                width: 350,
                height: 300,
                child: ListView.builder(
                  itemCount: years.length,
                  itemBuilder: (context, index) {
                    final year = years[index];

                    return RadioListTile<String>(
                      value: year,
                      groupValue: tempSelectedYear,
                      title: Text(year),
                      activeColor: const Color.fromARGB(255, 7, 59, 120),
                      onChanged: (value) {
                        if (value == null) return;

                        setDialogState(() {
                          tempSelectedYear = value;
                        });

                        Navigator.pop(dialogContext, value);
                      },
                    );
                  },
                ),
              ),
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
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    await checkCurrentUser();
  }
}

class MonthlyPerformanceChart {
  final String month;
  final double plannedMiles;
  final double completedMiles;
  final double pendingMiles;

  MonthlyPerformanceChart({
    required this.month,
    required this.plannedMiles,
    required this.completedMiles,
    required this.pendingMiles,
  });
}

class MaintenanceTypeChart {
  final String type;
  final double totalMiles;
  final double completedMiles;

  MaintenanceTypeChart(this.type, this.totalMiles, this.completedMiles);
}

class MaintenanceData {
  final String maintenanceType;
  final String coordinates;
  final double totalMiles;
  final double completedMiles;
  final double pendingMiles;

  MaintenanceData({
    required this.maintenanceType,
    required this.coordinates,
    required this.totalMiles,
    required this.completedMiles,
    required this.pendingMiles,
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

  @override
  void initState() {
    setUserName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userPreferences = Provider.of<UserPref>(context);
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
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const SupervisorBottomNavigationPannel(),
                        ),
                      );
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
                      Navigator.pop(context);
                    },
                  ),
                  // ListTile(
                  //     leading: const Icon(
                  //       Icons.location_searching,
                  //     ),
                  //     title: const Text('Offline Maintenance Map'),
                  //     textColor: const Color.fromARGB(255, 7, 59, 120),
                  //     iconColor: const Color.fromARGB(255, 7, 59, 120),
                  //     onTap: () async {
                  //       String id = '';
                  //       final userPreferences1 =
                  //           Provider.of<UserPref>(context, listen: false);
                  //       UserModel data = await userPreferences1.getUser();
                  //       id = data.user!.id.toString();
                  //        await browser.open(
                  //           url: WebUri(
                  //               "https://lcpmapapi.ariespro.com/main/change_order_view/CIVM_Map/USRQWXH589Z/$id"),
                  //           //crew id in place of id in above line
                  //           settings: ChromeSafariBrowserSettings(
                  //               shareState: CustomTabsShareState.SHARE_STATE_OFF,
                  //               barCollapsingEnabled: true));

                  //     }),
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
    setState(() {
      userName = '${data.user!.fName} ${data.user!.lName}';
    });
  }
}

class _ChartDataSimpleColumnChart1 {
  _ChartDataSimpleColumnChart1(this.x, this.y1, this.y2);

  final String x;
  final double y1;
  final double y2;
}

class _ChartDataSimpleColumnChart2 {
  _ChartDataSimpleColumnChart2(
    this.x,
    this.y,
    this.y1,
    this.y2,
    this.y3,
    this.y4,
  );

  final String x;
  final double y;
  final double y1;
  final double y2;
  final double y3;
  final double y4;
  // final Color? color;
}

class _ChartDataSimpleColumnChart5 {
  _ChartDataSimpleColumnChart5(this.x, this.y, this.y1, this.y2);

  final String x;
  final double y;
  final double y1;
  final double y2;
  // final Color? color;
}

class _ChartDataSimpleColumnChart8 {
  _ChartDataSimpleColumnChart8(this.x, this.y, this.y1, this.y2);

  final String x;
  final double y;
  final double y1;
  final double y2;
  // final Color? color;
}

class BarChart {
  String place;
  int year;
  int quantity;

  BarChart(this.year, this.place, this.quantity);
}

class Chart2and {
  final String year;
  final int sales;

  Chart2and(this.year, this.sales);
}

class Chart4ColumnStacked {
  final String x;
  final double y1;
  final double y2;
  final double y3;
  final double y4;
  final double y5;
  Chart4ColumnStacked(this.x, this.y1, this.y2, this.y3, this.y4, this.y5);
}

class Chart5Horizontal {
  final String year;
  final int sales;

  Chart5Horizontal(this.year, this.sales);
}

class Chart6HorizontalStacked {
  final String x;
  final double y1;
  final double y2;
  final double y3;
  final double y4;
  final double y5;
  Chart6HorizontalStacked(this.x, this.y1, this.y2, this.y3, this.y4, this.y5);
}

class Chart9ColumnStacked {
  final String x;
  final double y1;
  final String y2;
  final String y3;
  Chart9ColumnStacked(this.x, this.y1, this.y2, this.y3);
}

class Chart10ColumnStacked {
  final String x;
  final double y1;
  // final String z;
  Chart10ColumnStacked(this.x, this.y1);
}

// class Chart11ColumnStacked {
//   final String x;
//   final double y1;
//   final double y2;
//   final double y3;
//   Chart11ColumnStacked(this.x, this.y1, this.y2, this.y3);
// }

class Chart11ColumnStacked {
  final String label;
  final double y1;
  final double y2;
  final double y3;

  Chart11ColumnStacked(this.label, this.y1, this.y2, this.y3);
}
