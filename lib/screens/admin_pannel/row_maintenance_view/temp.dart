// ignore: file_names
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
// import 'package:charts_flutter/flutter.dart' as charts;
import '../../../data/response/status.dart';
import '../../../view_model/row_maintenance_progress_dashboard_view_model.dart';
import 'package:CIVM/models/user_model.dart';
import 'package:CIVM/screens/admin_pannel/row_maintenance_view/add_new_row_table.dart';
import 'package:CIVM/screens/admin_pannel/row_maintenance_view/admin_change_order_all_status.dart';
import 'package:CIVM/screens/admin_pannel/row_maintenance_view/user_management_tabs.dart';
import 'package:CIVM/screens/leaflat_map/leaf_lat_map_wakeLock.dart';
import 'package:CIVM/screens/map/provider/location_provider.dart';
import 'package:CIVM/sharedPrefs/constants.dart';
import 'package:CIVM/utils/user_pref.dart';
import '../../login_page.dart';
import 'package:CIVM/utils/common_functions.dart';

// ignore: must_be_immutable
class IVMMaintenanceProgressDashboard extends StatefulWidget {
  const IVMMaintenanceProgressDashboard({super.key});

  @override
  State<IVMMaintenanceProgressDashboard> createState() =>
      _IVMMaintenanceProgressDashboardState();
}

class _IVMMaintenanceProgressDashboardState
    extends State<IVMMaintenanceProgressDashboard> {
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

  final TextEditingController _perdayCost = TextEditingController();
  final TextEditingController _permonthCost = TextEditingController();
  final TextEditingController _peryearCost = TextEditingController();
  late final Future? myFuture;
  var result = [];
  List<String> menu = [];

  String name = '';
  // ignore: non_constant_identifier_names
  final select_year = ['2026', '2025', '2024', '2023', '2022', '2021', '2020'];
  String? year = '2026';

  final gradientList = <List<Color>>[
    [
      const Color.fromARGB(255, 1, 113, 5),
      const Color.fromARGB(255, 1, 113, 5),
    ],
    [const Color.fromARGB(255, 248, 223, 5), Colors.yellow],
  ];

  final colorList = <Color>[Colors.greenAccent];

  Map<String, double> dataMap1 = {
    "Under Performance": 73.2,
    "Inline Performance": 25.2,
    "Over Performance": 1.6,
  };
  final gradientList1 = <List<Color>>[
    [Colors.purpleAccent, Colors.purple],
    [Colors.pinkAccent, Colors.pink],
    [
      const Color.fromARGB(255, 7, 59, 120),
      const Color.fromARGB(255, 1, 182, 7),
    ],
  ];

  final colorList1 = <Color>[Colors.greenAccent];

  List<Map<String, dynamic>> listOfColumns = [];
  List<Map<String, dynamic>> listOfColumns1 = [];
  double onePercent = 0;

  RowMaintenanceProgressDashboardViewModel
  rowMaintenanceProgressDasboardViewModel =
      RowMaintenanceProgressDashboardViewModel();

  late TooltipBehavior _tooltipBehavior1;
  late TooltipBehavior _tooltipBehavior2;
  late TooltipBehavior _tooltipBehavior6;
  late TooltipBehavior _tooltipBehavior;

  DateTime now = DateTime.now();

  String? selectedYear = "2026";

  List<String> yearList = ["2026", "2025", "2024"];

  List<String> substationList = [
    "All Substations",
    "Substation A",
    "Substation B",
    "Substation C",
  ];

  List<String> feederList = ["All Feeders", "Feeder 1", "Feeder 2", "Feeder 3"];

  List<String> selectedSubstations = [];
  List<String> selectedFeeders = [];

  final List<MaintenanceData> maintenanceList = [
  MaintenanceData(
    maintenanceType: "IVM Maintenance",
    coordinates: "2",
    totalMiles: 120,
    completedMiles: 85,
    pendingMiles: 35,
  ),
  MaintenanceData(
    maintenanceType: "Patrolling",
    coordinates: "10",
    totalMiles: 80,
    completedMiles: 40,
    pendingMiles: 40,
  ),
];

  @override
  void initState() {
    super.initState();
    _tooltipBehavior = TooltipBehavior(enable: true);
    _tooltipBehavior1 = TooltipBehavior(
      enable: true,
      tooltipPosition: TooltipPosition.pointer,
    );
    _tooltipBehavior2 = TooltipBehavior(
      enable: true,
      tooltipPosition: TooltipPosition.pointer,
    );
    _tooltipBehavior6 = TooltipBehavior(
      enable: true,
      tooltipPosition: TooltipPosition.pointer,
    );
    rowMaintenanceProgressDasboardViewModel
        .fetchRowMaintenanceProgressDashboardDataApi(
          context,
          now.year.toString(),
        );
    _perdayCost.text = '0.0';
    _permonthCost.text = '0.0';
    _peryearCost.text = '0.0';
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
          IconButton(
            icon: Icon(Icons.filter_alt_outlined, color: Colors.white),
            tooltip: 'Filter',
            onPressed: () {
              showFilterDialog(context);
            },
          ),
        ],
      ),
      drawer: DrawerManu(menu: menu),
      body: ChangeNotifierProvider<RowMaintenanceProgressDashboardViewModel>(
        create: (BuildContext context) =>
            rowMaintenanceProgressDasboardViewModel,
        child: Consumer<RowMaintenanceProgressDashboardViewModel>(
          builder: (context, value, _) {
            switch (value.rowMaintenanceProgressGetDataList.status) {
              case Status.LOADING:
                return const Center(child: CircularProgressIndicator());
              case Status.ERROR:
                return
                // CustomToastSnackBarProgressDialog.flushBarErrorMessage(
                //     value.rowMaintenanceProgressGetDataList.message
                //         .toString(),
                //     context);
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
                final filteredPercentStatus =
                    rowMaintenanceProgressDasboardViewModel
                        .rowMaintenanceProgressGetDataList
                        .data!
                        .percentAndStatus!
                        .where(
                          (item) => item.status?.toUpperCase() != "IN PROGRESS",
                        )
                        .toList();
                return RefreshIndicator(
                  onRefresh: () async {
                    
                  },
                  child: SingleChildScrollView(
                    child: Center(
                      child: Column(
                        children: [
                          const SizedBox(height: 8),
                             _summaryCard(
                                  title: "Total Miles",
                                  value: "16.04",
                                  subtitle: "21 Work Orders",
                                  progress: 1.0,
                                  color: const Color.fromARGB(255, 7, 59, 120),
                                ),
                                _summaryCard(
                                  title: "Completed",
                                  value: "1.06",
                                  subtitle: "6.6% of total",
                                  progress: 0.066,
                                  color: Colors.green,
                                ),
                                _summaryCard(
                                  title: "Pending",
                                  value: "14.98",
                                  subtitle: "93.4% of total",
                                  progress: 0.934,
                                  color: Colors.orange,
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
                            // height: size.height * 0.2,
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
                                          "Overall Status",
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
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          top: 8.0,
                                        ),
                                        child: Row(
                                          children: [
                                           Expanded(
                                              child: Column(
                                                children: [
                                                  Text(
                                                    (rowMaintenanceProgressDasboardViewModel
                                                                .rowMaintenanceProgressGetDataList
                                                                .data!
                                                                .percentAndStatus![1]
                                                                .percentage ==
                                                            null)
                                                        ? '0.0 %'
                                                        : ' ${rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.percentAndStatus![1].percentage.toString()} %',
                                                    style: const TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                  const Text(
                                                    'COMPLETED',
                                                    style: TextStyle(
                                                      color: Colors.red,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  Text(
                                                    (rowMaintenanceProgressDasboardViewModel
                                                                .rowMaintenanceProgressGetDataList
                                                                .data!
                                                                .percentAndStatus![2]
                                                                .percentage ==
                                                            null)
                                                        ? '0.0 %'
                                                        : ' ${rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.percentAndStatus![2].percentage.toString()} %',
                                                    style: const TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                  const Text(
                                                    'PENDING',
                                                    style: TextStyle(
                                                      color: Colors.red,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          top: 18.0,
                                          bottom: 18,
                                        ),
                                        child: PieChart(
                                          dataMap: Map.fromEntries(
                                            filteredPercentStatus.map(
                                              (item) => MapEntry(
                                                item.status.toString(),
                                                double.tryParse(
                                                      item.percentage
                                                          .toString(),
                                                    ) ??
                                                    0.0,
                                              ),
                                            ),
                                          ),
                                          animationDuration: const Duration(
                                            milliseconds: 800,
                                          ),
                                          chartLegendSpacing: 32,
                                          chartRadius:
                                              MediaQuery.of(
                                                context,
                                              ).size.width /
                                              2,
                                          // colorList: colorList,
                                          initialAngleInDegree: 0,
                                          chartType: ChartType.ring,
                                          ringStrokeWidth: 32,
                                          // centerText: "HYBRID",
                                          legendOptions: const LegendOptions(
                                            showLegendsInRow: false,
                                            // legendPosition: LegendPosition.right,
                                            showLegends: true,
                                            // legendShape: _BoxShape.circle,
                                            legendTextStyle: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          chartValuesOptions:
                                              const ChartValuesOptions(
                                                showChartValueBackground: false,
                                                showChartValues: true,
                                                showChartValuesInPercentage:
                                                    true,
                                                showChartValuesOutside: false,
                                                decimalPlaces: 1,
                                              ),
                                          gradientList: gradientList,
                                          // emptyColorGradient: ---Empty Color gradient---
                                        ),
                                      ),
                                    ],
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
                                  child: SfCartesianChart(
                                   tooltipBehavior: _tooltipBehavior6,
                                    primaryXAxis: CategoryAxis(
                                      title: AxisTitle(
                                        text: 'CREW',
                                        textStyle: const TextStyle(
                                          color: Colors.red,
                                          fontFamily: 'Roboto',
                                          fontSize: 16,
                                          //// fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      majorGridLines: const MajorGridLines(
                                        width: 0,
                                      ),
                                    ),
                                    primaryYAxis: NumericAxis(
                                      title: AxisTitle(
                                        text: 'VALUE (IN MILES)',
                                        textStyle: const TextStyle(
                                          color: Colors.red,
                                          fontFamily: 'Roboto',
                                          fontSize: 16,
                                          //// fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      axisLine: const AxisLine(width: 0),
                                      labelFormat: '{value}',
                                      //maximum: 2000,
                                      majorTickLines: const MajorTickLines(
                                        size: 0,
                                      ),
                                    ),
                                    legend: Legend(isVisible: true),
                                    palette: const <Color>[
                                      Color.fromARGB(255, 2, 127, 6),
                                      Colors.red,
                                    ],
                                    series: <CartesianSeries>[
                                      ColumnSeries<
                                        _ChartDataSimpleColumnChart1,
                                        String
                                      >(
                                        name: 'MILES_COMPLETED',
                                        dataSource: recreateDataCrewStatus(
                                          value,
                                        ),
                                        xValueMapper:
                                            (
                                              _ChartDataSimpleColumnChart1 data,
                                              _,
                                            ) => data.x,
                                        yValueMapper:
                                            (
                                              _ChartDataSimpleColumnChart1 data,
                                              _,
                                            ) => data.y1,
                                        enableTooltip: true,
                                        markerSettings: const MarkerSettings(
                                          isVisible: true,
                                          shape: DataMarkerType.diamond,
                                        ),
                                        dataLabelSettings:
                                            const DataLabelSettings(
                                              isVisible: true,
                                            ),
                                      ),
                                      ColumnSeries<
                                        _ChartDataSimpleColumnChart1,
                                        String
                                      >(
                                        name: 'MILES_IN_PROGRESS',
                                        dataSource: recreateDataCrewStatus(
                                          value,
                                        ),
                                        xValueMapper:
                                            (
                                              _ChartDataSimpleColumnChart1 data,
                                              _,
                                            ) => data.x,
                                        yValueMapper:
                                            (
                                              _ChartDataSimpleColumnChart1 data,
                                              _,
                                            ) => data.y2,
                                        enableTooltip: true,
                                        markerSettings: const MarkerSettings(
                                          isVisible: true,
                                          shape: DataMarkerType.diamond,
                                        ),
                                        dataLabelSettings:
                                            const DataLabelSettings(
                                              isVisible: true,
                                            ),
                                      ),
                                    ],
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
                                        "Yearly Performance Metrics by Maintenance Type",
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
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: SfCartesianChart(
                                      tooltipBehavior: _tooltipBehavior,
                                      primaryXAxis: CategoryAxis(
                                        title: AxisTitle(
                                          text: 'YEAR',
                                          textStyle: const TextStyle(
                                            color: Colors.red,
                                            fontFamily: 'Roboto',
                                            fontSize: 16,
                                            // fontStyle: FontStyle.italic,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        majorGridLines: const MajorGridLines(
                                          width: 0,
                                        ),
                                      ),
                                      primaryYAxis: NumericAxis(
                                        title: AxisTitle(
                                          text: 'PERFORMANCE(%)',
                                          textStyle: const TextStyle(
                                            color: Colors.red,
                                            fontFamily: 'Roboto',
                                            fontSize: 16,
                                            // fontStyle: FontStyle.italic,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        axisLine: const AxisLine(width: 0),
                                        labelFormat: '{value}',
                                        // //maximum: 300,
                                        majorTickLines: const MajorTickLines(
                                          size: 0,
                                        ),
                                      ),
                                      legend: Legend(isVisible: true),
                                      palette: const <Color>[
                                        Color.fromARGB(255, 38, 2, 217),
                                        Colors.red,
                                        Colors.orange,
                                        Colors.green,
                                        Colors.purple,
                                        Colors.blue,
                                        Color.fromARGB(255, 247, 79, 135),
                                      ],
                                      series: <CartesianSeries>[
                                        for (var type in getTypeYearlyListList(
                                          value,
                                        )) ...[
                                          StackedColumnSeries<
                                            Chart9ColumnStacked,
                                            String
                                          >(
                                            dataSource:
                                                recreateDataYearlyPerformanceMatricsByMaintenanceType(
                                                  value,
                                                  type.toString(),
                                                ),
                                            xValueMapper:
                                                (Chart9ColumnStacked ch, _) =>
                                                    ch.x,
                                            yValueMapper:
                                                (Chart9ColumnStacked ch, _) =>
                                                    ch.y1,
                                            name: type,
                                            enableTooltip: true,
                                          ),
                                        ],
                                      ],
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
                                        "Yearly Performance Metrics",
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
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: SfCartesianChart(
                                            tooltipBehavior: _tooltipBehavior1,
                                            primaryXAxis: CategoryAxis(
                                              title: AxisTitle(
                                                text: 'YEAR',
                                                textStyle: const TextStyle(
                                                  color: Colors.red,
                                                  fontFamily: 'Roboto',
                                                  fontSize: 16,
                                                  // fontStyle: FontStyle.italic,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              majorGridLines:
                                                  const MajorGridLines(
                                                    width: 0,
                                                  ),
                                            ),
                                            primaryYAxis: NumericAxis(
                                              title: AxisTitle(
                                                text: 'PERFORMANCE(%)',
                                                textStyle: const TextStyle(
                                                  color: Colors.red,
                                                  fontFamily: 'Roboto',
                                                  fontSize: 16,
                                                  // fontStyle: FontStyle.italic,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              axisLine: const AxisLine(
                                                width: 0,
                                              ),
                                              labelFormat: '{value}',
                                              // //maximum: 300,
                                              majorTickLines:
                                                  const MajorTickLines(size: 0),
                                            ),
                                            legend: Legend(isVisible: true),
                                            palette: const <Color>[
                                              Color.fromARGB(255, 38, 2, 217),
                                              Colors.red,
                                              Colors.orange,
                                            ],
                                            series: <CartesianSeries>[
                                              StackedColumnSeries<
                                                Chart11ColumnStacked,
                                                String
                                              >(
                                                dataSource:
                                                    recreateDataYearlyPerformanceMatrics(
                                                      value,
                                                    ),
                                                xValueMapper:
                                                    (
                                                      Chart11ColumnStacked ch,
                                                      _,
                                                    ) => ch.label,
                                                yValueMapper:
                                                    (
                                                      Chart11ColumnStacked ch,
                                                      _,
                                                    ) => ch.y1,
                                                name: 'UnderPerformance',
                                                enableTooltip: true,
                                                markerSettings:
                                                    const MarkerSettings(
                                                      isVisible: true,
                                                    ),
                                              ),
                                              StackedColumnSeries<
                                                Chart11ColumnStacked,
                                                String
                                              >(
                                                dataSource:
                                                    recreateDataYearlyPerformanceMatrics(
                                                      value,
                                                    ),
                                                xValueMapper:
                                                    (
                                                      Chart11ColumnStacked ch,
                                                      _,
                                                    ) => ch.label,
                                                yValueMapper:
                                                    (
                                                      Chart11ColumnStacked ch,
                                                      _,
                                                    ) => ch.y2,
                                                name: 'InlinePerformance',
                                                enableTooltip: true,
                                                markerSettings:
                                                    const MarkerSettings(
                                                      isVisible: true,
                                                    ),
                                              ),
                                              StackedColumnSeries<
                                                Chart11ColumnStacked,
                                                String
                                              >(
                                                dataSource:
                                                    recreateDataYearlyPerformanceMatrics(
                                                      value,
                                                    ),
                                                xValueMapper:
                                                    (
                                                      Chart11ColumnStacked ch,
                                                      _,
                                                    ) => ch.label,
                                                yValueMapper:
                                                    (
                                                      Chart11ColumnStacked ch,
                                                      _,
                                                    ) => ch.y3,
                                                name: 'OverPerformance',
                                                enableTooltip: true,
                                                markerSettings:
                                                    const MarkerSettings(
                                                      isVisible: true,
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
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
                            child: ListView.builder(
                              padding: const EdgeInsets.all(12),
                              itemCount: maintenanceList.length,
                              itemBuilder: (context, index) {
                                final item = maintenanceList[index];
                            
                                final progress = item.totalMiles == 0
                                    ? 0.0
                                    : item.completedMiles / item.totalMiles;
                            
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
                                          Row(
                                          children: [
                                            Expanded(
                                              child: _infoRow("MAINTENANCE TYPE", ''),
                                            ),
                                            Expanded(
                                              child: _infoRow("COORDINATES", item.coordinates),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 6),
                            
                                        Row(
                                          children: [
                                            Expanded(
                                              child: _infoRow(
                                                "TOTAL MILES",
                                                item.totalMiles.toStringAsFixed(1),
                                              ),
                                            ),
                                            Expanded(
                                              child: _infoRow(
                                                "COMPLETED",
                                                item.completedMiles.toStringAsFixed(1),
                                              ),
                                            ),
                                          ],
                                        ),
                            
                                        const SizedBox(height: 6),
                            
                                        Row(
                                          children: [
                                            Expanded(
                                              child: _infoRow(
                                                "PENDING",
                                                item.pendingMiles.toStringAsFixed(1),
                                              ),
                                            ),
                                            Expanded(
                                              child: _infoRow(
                                                "PROGRESS",
                                                "${(progress * 100).toStringAsFixed(0)}%",
                                              ),
                                            ),
                                          ],
                                        ),
                            
                                        const SizedBox(height: 12),
                            
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(6),
                                          child: LinearProgressIndicator(
                                            value: progress,
                                            minHeight: 8,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            )
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
                                      "Monthly Performance Metrics by Maintenance Type",
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
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 2.0,
                                          right: 2.0,
                                          bottom: 2.0,
                                          top: 10.0,
                                        ),
                                        child: Column(
                                          children: [
                                            const Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "Year",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Color.fromARGB(
                                                    255,
                                                    7,
                                                    59,
                                                    120,
                                                  ),
                                                  //fontWeight: FontWeight.bold
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
                                                            color:
                                                                Color.fromARGB(
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
                                                  isExpanded: true,
                                                  items: select_year
                                                      .map(buildMenuItem)
                                                      .toList(),

                                                  // onChanged: (value) =>
                                                  //     setState(
                                                  //         () => year = value),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      year = value;
                                                    });
                                                    rowMaintenanceProgressDasboardViewModel
                                                        .fetchRowMaintenanceProgressDashboardDataApi2(
                                                          context,
                                                          year.toString(),
                                                        );
                                                  },
                                                  validator: (value) =>
                                                      value == null
                                                      ? 'field required'
                                                      : null,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                            top: 8.0,
                                          ),
                                          child: SfCartesianChart(
                                            tooltipBehavior: _tooltipBehavior2,
                                            primaryXAxis: CategoryAxis(
                                              title: AxisTitle(
                                                text: 'YEAR',
                                                textStyle: const TextStyle(
                                                  color: Colors.red,
                                                  fontFamily: 'Roboto',
                                                  fontSize: 16,
                                                  // fontStyle: FontStyle.italic,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              majorGridLines:
                                                  const MajorGridLines(
                                                    width: 0,
                                                  ),
                                            ),
                                            primaryYAxis: NumericAxis(
                                              title: AxisTitle(
                                                text: 'PERFORMANCE(%)',
                                                textStyle: const TextStyle(
                                                  color: Colors.red,
                                                  fontFamily: 'Roboto',
                                                  fontSize: 16,
                                                  // fontStyle: FontStyle.italic,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              axisLine: const AxisLine(
                                                width: 0,
                                              ),
                                              labelFormat: '{value}',
                                              // //maximum: 30000,
                                              majorTickLines:
                                                  const MajorTickLines(size: 0),
                                            ),
                                            legend: Legend(isVisible: true),
                                            palette: const <Color>[
                                              Color.fromARGB(255, 38, 2, 217),
                                              Colors.red,
                                              Colors.orange,
                                              Colors.green,
                                              Colors.purple,
                                              Colors.blue,
                                              Color.fromARGB(255, 247, 79, 135),
                                            ],
                                            series: <CartesianSeries>[
                                              for (var type
                                                  in getTypeMonthlyListList(
                                                    value,
                                                  )) ...[
                                                StackedColumnSeries<
                                                  Chart10ColumnStacked,
                                                  String
                                                >(
                                                  dataSource:
                                                      recreateDataMonthlyPerformanceMatricsByMaintenanceType(
                                                        value,
                                                        type.toString(),
                                                      ),
                                                  xValueMapper:
                                                      (
                                                        Chart10ColumnStacked ch,
                                                        _,
                                                      ) => ch.x,
                                                  yValueMapper:
                                                      (
                                                        Chart10ColumnStacked ch,
                                                        _,
                                                      ) => ch.y1,
                                                  name: type.toString(),
                                                ),
                                              ],
                                            ],
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
                  ),
                );

              default:
                return const Text('data');
            }
          },
        ),
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

  List<_ChartDataSimpleColumnChart2> recreateDataAffectedDaysByClause(
    RowMaintenanceProgressDashboardViewModel value,
  ) {
    chartDataSimpleColumnChart2.clear();

    for (
      var i = 0;
      i <
          rowMaintenanceProgressDasboardViewModel
              .rowMaintenanceProgressGetDataList
              .data!
              .affectedDaysByCausesList!
              .length;
      i++
    ) {
      chartDataSimpleColumnChart2.add(
        _ChartDataSimpleColumnChart2(
          rowMaintenanceProgressDasboardViewModel
              .rowMaintenanceProgressGetDataList
              .data!
              .affectedDaysByCausesList![i]
              .delayCause
              .toString(),
          double.tryParse(
                rowMaintenanceProgressDasboardViewModel
                        .rowMaintenanceProgressGetDataList
                        .data!
                        .affectedDaysByCausesList![i]
                        .effectedNoOfDays1
                        ?.toString() ??
                    "",
              ) ??
              0.0,
          double.tryParse(
                rowMaintenanceProgressDasboardViewModel
                        .rowMaintenanceProgressGetDataList
                        .data!
                        .affectedDaysByCausesList![i]
                        .effectedNoOfDays2
                        ?.toString() ??
                    "",
              ) ??
              0.0,
          double.tryParse(
                rowMaintenanceProgressDasboardViewModel
                        .rowMaintenanceProgressGetDataList
                        .data!
                        .affectedDaysByCausesList![i]
                        .effectedNoOfDays3
                        ?.toString() ??
                    "",
              ) ??
              0.0,
          double.tryParse(
                rowMaintenanceProgressDasboardViewModel
                        .rowMaintenanceProgressGetDataList
                        .data!
                        .affectedDaysByCausesList![i]
                        .effectedNoOfDays4
                        ?.toString() ??
                    "",
              ) ??
              0.0,
          double.tryParse(
                rowMaintenanceProgressDasboardViewModel
                        .rowMaintenanceProgressGetDataList
                        .data!
                        .affectedDaysByCausesList![i]
                        .effectedNoOfDays5
                        ?.toString() ??
                    "",
              ) ??
              0.0,
        ),
      );
    }
    return chartDataSimpleColumnChart2;
  }

  List<Chart4ColumnStacked> recreateDataAffectedDaysByWeatherDelay(
    RowMaintenanceProgressDashboardViewModel value,
  ) {
    chart4ColumnStacked.clear();
    for (
      var i = 0;
      i <
          rowMaintenanceProgressDasboardViewModel
              .rowMaintenanceProgressGetDataList
              .data!
              .affectedDaysByWeatherDelayList!
              .length;
      i++
    ) {
      chart4ColumnStacked.add(
        Chart4ColumnStacked(
          (rowMaintenanceProgressDasboardViewModel
                      .rowMaintenanceProgressGetDataList
                      .data!
                      .affectedDaysByWeatherDelayList![i]
                      .delayCause ==
                  null)
              ? ''
              : rowMaintenanceProgressDasboardViewModel
                    .rowMaintenanceProgressGetDataList
                    .data!
                    .affectedDaysByWeatherDelayList![i]
                    .delayCause
                    .toString(),
          (rowMaintenanceProgressDasboardViewModel
                      .rowMaintenanceProgressGetDataList
                      .data!
                      .affectedDaysByWeatherDelayList![i]
                      .effectedNoOfDays1 ==
                  null)
              ? 0.0
              : double.parse(
                  rowMaintenanceProgressDasboardViewModel
                      .rowMaintenanceProgressGetDataList
                      .data!
                      .affectedDaysByWeatherDelayList![i]
                      .effectedNoOfDays1
                      .toString(),
                ),
          (rowMaintenanceProgressDasboardViewModel
                      .rowMaintenanceProgressGetDataList
                      .data!
                      .affectedDaysByWeatherDelayList![i]
                      .effectedNoOfDays2 ==
                  null)
              ? 0.0
              : double.parse(
                  rowMaintenanceProgressDasboardViewModel
                      .rowMaintenanceProgressGetDataList
                      .data!
                      .affectedDaysByWeatherDelayList![i]
                      .effectedNoOfDays2
                      .toString(),
                ),
          (rowMaintenanceProgressDasboardViewModel
                      .rowMaintenanceProgressGetDataList
                      .data!
                      .affectedDaysByWeatherDelayList![i]
                      .effectedNoOfDays3 ==
                  null)
              ? 0.0
              : double.parse(
                  rowMaintenanceProgressDasboardViewModel
                      .rowMaintenanceProgressGetDataList
                      .data!
                      .affectedDaysByWeatherDelayList![i]
                      .effectedNoOfDays3
                      .toString(),
                ),
          (rowMaintenanceProgressDasboardViewModel
                      .rowMaintenanceProgressGetDataList
                      .data!
                      .affectedDaysByWeatherDelayList![i]
                      .effectedNoOfDays4 ==
                  null)
              ? 0.0
              : double.parse(
                  rowMaintenanceProgressDasboardViewModel
                      .rowMaintenanceProgressGetDataList
                      .data!
                      .affectedDaysByWeatherDelayList![i]
                      .effectedNoOfDays4
                      .toString(),
                ),
          (rowMaintenanceProgressDasboardViewModel
                      .rowMaintenanceProgressGetDataList
                      .data!
                      .affectedDaysByWeatherDelayList![i]
                      .effectedNoOfDays5 ==
                  null)
              ? 0.0
              : double.parse(
                  rowMaintenanceProgressDasboardViewModel
                      .rowMaintenanceProgressGetDataList
                      .data!
                      .affectedDaysByWeatherDelayList![i]
                      .effectedNoOfDays5
                      .toString(),
                ),
        ),
      );
    }
    return chart4ColumnStacked;
  }

  List<Chart6HorizontalStacked> recreateAffectedDaysByOtherCause(
    RowMaintenanceProgressDashboardViewModel value,
  ) {
    chart6HorizontalStacked.clear();
    for (
      var i = 0;
      i <
          rowMaintenanceProgressDasboardViewModel
              .rowMaintenanceProgressGetDataList
              .data!
              .affectedDaysByOtherIssuesList!
              .length;
      i++
    ) {
      chart6HorizontalStacked.add(
        Chart6HorizontalStacked(
          (rowMaintenanceProgressDasboardViewModel
                      .rowMaintenanceProgressGetDataList
                      .data!
                      .affectedDaysByOtherIssuesList![i]
                      .delayCause ==
                  null)
              ? ''
              : rowMaintenanceProgressDasboardViewModel
                    .rowMaintenanceProgressGetDataList
                    .data!
                    .affectedDaysByOtherIssuesList![i]
                    .delayCause
                    .toString(),
          (rowMaintenanceProgressDasboardViewModel
                      .rowMaintenanceProgressGetDataList
                      .data!
                      .affectedDaysByOtherIssuesList![i]
                      .effectedNoOfDays1 ==
                  null)
              ? 0.0
              : double.parse(
                  rowMaintenanceProgressDasboardViewModel
                      .rowMaintenanceProgressGetDataList
                      .data!
                      .affectedDaysByOtherIssuesList![i]
                      .effectedNoOfDays1
                      .toString(),
                ),
          (rowMaintenanceProgressDasboardViewModel
                      .rowMaintenanceProgressGetDataList
                      .data!
                      .affectedDaysByOtherIssuesList![i]
                      .effectedNoOfDays2 ==
                  null)
              ? 0.0
              : double.parse(
                  rowMaintenanceProgressDasboardViewModel
                      .rowMaintenanceProgressGetDataList
                      .data!
                      .affectedDaysByOtherIssuesList![i]
                      .effectedNoOfDays2
                      .toString(),
                ),
          (rowMaintenanceProgressDasboardViewModel
                      .rowMaintenanceProgressGetDataList
                      .data!
                      .affectedDaysByOtherIssuesList![i]
                      .effectedNoOfDays3 ==
                  null)
              ? 0.0
              : double.parse(
                  rowMaintenanceProgressDasboardViewModel
                      .rowMaintenanceProgressGetDataList
                      .data!
                      .affectedDaysByOtherIssuesList![i]
                      .effectedNoOfDays3
                      .toString(),
                ),
          (rowMaintenanceProgressDasboardViewModel
                      .rowMaintenanceProgressGetDataList
                      .data!
                      .affectedDaysByOtherIssuesList![i]
                      .effectedNoOfDays4 ==
                  null)
              ? 0.0
              : double.parse(
                  rowMaintenanceProgressDasboardViewModel
                      .rowMaintenanceProgressGetDataList
                      .data!
                      .affectedDaysByOtherIssuesList![i]
                      .effectedNoOfDays4
                      .toString(),
                ),
          (rowMaintenanceProgressDasboardViewModel
                      .rowMaintenanceProgressGetDataList
                      .data!
                      .affectedDaysByOtherIssuesList![i]
                      .effectedNoOfDays5 ==
                  null)
              ? 0.0
              : double.parse(
                  rowMaintenanceProgressDasboardViewModel
                      .rowMaintenanceProgressGetDataList
                      .data!
                      .affectedDaysByOtherIssuesList![i]
                      .effectedNoOfDays5
                      .toString(),
                ),
        ),
      );
    }
    return chart6HorizontalStacked;
  }

  List<Chart9ColumnStacked>
  recreateDataYearlyPerformanceMatricsByMaintenanceType(
    RowMaintenanceProgressDashboardViewModel value,
    String type,
  ) {
    List<Chart9ColumnStacked> chart9ColumnStacked = [];

    for (
      var i = 0;
      i <
          value
              .rowMaintenanceProgressGetDataList
              .data!
              .getSPAGGMILESFORDISTINCTTYPE!
              .length;
      i++
    ) {
      var data = value
          .rowMaintenanceProgressGetDataList
          .data!
          .getSPAGGMILESFORDISTINCTTYPE![i];

      if (data.type == type) {
        chart9ColumnStacked.add(
          Chart9ColumnStacked(
            data.year.toString(),
            data.aggMiles ?? 0,
            data.percentage.toString(),
            data.type.toString(),
          ),
        );
        print(
          'dataaaa ${data.year.toString()}/${data.aggMiles ?? 0}/${data.percentage.toString()}/${data.type.toString()}',
        );
      }
    }

    return chart9ColumnStacked;
  }

  List<Chart10ColumnStacked>
  recreateDataMonthlyPerformanceMatricsByMaintenanceType(
    RowMaintenanceProgressDashboardViewModel value,
    String type,
  ) {
    List<Chart10ColumnStacked> chart10ColumnStacked = [];

    for (
      var i = 0;
      i <
          value
              .rowMaintenanceProgressGetDataList
              .data!
              .getSPAGGMILESFORDISTINCTTYPEBYMNTH!
              .length;
      i++
    ) {
      var data = value
          .rowMaintenanceProgressGetDataList
          .data!
          .getSPAGGMILESFORDISTINCTTYPEBYMNTH![i];

      if (data.type == type) {
        chart10ColumnStacked.add(
          Chart10ColumnStacked(data.monthName.toString(), data.aggMiles ?? 0),
        );
      }
    }

    return chart10ColumnStacked;
  }

  List<String?> getTypeMonthlyListList(
    RowMaintenanceProgressDashboardViewModel value,
  ) {
    return value
        .rowMaintenanceProgressGetDataList
        .data!
        .getSPAGGMILESFORDISTINCTTYPEBYMNTH!
        .map((data) => data.type)
        .toSet()
        .toList();
  }

  List<String?> getTypeYearlyListList(
    RowMaintenanceProgressDashboardViewModel value,
  ) {
    return value
        .rowMaintenanceProgressGetDataList
        .data!
        .getSPAGGMILESFORDISTINCTTYPE!
        .map((data) => data.type)
        .toSet()
        .toList();
  }

  List<Chart11ColumnStacked> recreateDataYearlyPerformanceMatrics(
    RowMaintenanceProgressDashboardViewModel value,
  ) {
    List<Chart11ColumnStacked> chartData = [];
    Map<int, Chart11ColumnStacked> yearWiseData = {};
    Map<int, int> yearWiseCount = {};

    for (
      var i = 0;
      i <
          value
              .rowMaintenanceProgressGetDataList
              .data!
              .findUNDERPERFORMANCEAndINLINEPERFORMANCEOVERPERFORMANCE!
              .length;
      i++
    ) {
      var data = value
          .rowMaintenanceProgressGetDataList
          .data!
          .findUNDERPERFORMANCEAndINLINEPERFORMANCEOVERPERFORMANCE![i];

      int year = data.lastRowYear ?? 0;

      if (!yearWiseData.containsKey(year)) {
        yearWiseData[year] = Chart11ColumnStacked(
          year.toString(),
          0.0,
          0.0,
          0.0,
        );
        yearWiseCount[year] = 0;
      }

      // Increment the count for each year
      yearWiseCount[year] = (yearWiseCount[year] ?? 0) + 1;

      // Update the sum when initializing the Chart11ColumnStacked object
      yearWiseData[year] = Chart11ColumnStacked(
        year.toString(),
        yearWiseData[year]!.y1 + (data.underPerformance ?? 0.0),
        yearWiseData[year]!.y2 + (data.inlinePerformance ?? 0.0),
        yearWiseData[year]!.y3 + (data.overPerformance ?? 0.0),
      );
    }

    // Update the averages based on the count for each year
    yearWiseData.forEach((year, chartData) {
      int count =
          yearWiseCount[year] ?? 1; // Default to 1 if count is not found

      // Calculate averages by dividing the sum by the count
      yearWiseData[year] = Chart11ColumnStacked(
        chartData.label,
        chartData.y1 / count,
        chartData.y2 / count,
        chartData.y3 / count,
      );
    });

    // Convert the Map values to a list
    chartData.addAll(yearWiseData.values);

    return chartData;
  }

  List<_ChartDataSimpleColumnChart1> recreateDataCrewStatus(
    RowMaintenanceProgressDashboardViewModel value,
  ) {
    dataSimpleColumnChart1.clear();
    var dataList = rowMaintenanceProgressDasboardViewModel
        .rowMaintenanceProgressGetDataList
        .data
        ?.findCrewMilesCompletedAndMilesInProgress;

    if (dataList == null) {
      return dataSimpleColumnChart1;
    }

    for (var i = 0; i < dataList.length; i++) {
      var crewMilesData = dataList[i];
      var crew = crewMilesData.crew;
      var milesCompleted = crewMilesData.milesCompleted;
      var milesInProgress = crewMilesData.milesInProgress;

      dataSimpleColumnChart1.add(
        _ChartDataSimpleColumnChart1(
          (crew?.isEmpty ?? true) ? '' : crew.toString(),
          (milesCompleted == null || milesCompleted.toString() == 'null')
              ? 0
              : double.parse(milesCompleted.toString()),
          (milesInProgress == null || milesInProgress.toString() == 'null')
              ? 0
              : double.parse(milesInProgress.toString()),
        ),
      );
    }

    return dataSimpleColumnChart1;
  }

  void showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
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
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              content: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// YEAR
                      const Text(
                        "Year",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 8),

                      DropdownButtonFormField<String>(
                        value: selectedYear,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                          ),
                        ),
                        items: yearList
                            .map(
                              (e) => DropdownMenuItem(value: e, child: Text(e)),
                            )
                            .toList(),
                        onChanged: (value) {
                          setDialogState(() {
                            selectedYear = value;
                          });
                        },
                      ),

                      const SizedBox(height: 20),

                      /// SUBSTATION
                      const Text(
                        "Substation",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 8),

                      MultiSelectDialogField<String>(
                        items: substationList
                            .map((e) => MultiSelectItem(e, e))
                            .toList(),
                        initialValue: selectedSubstations,
                        title: const Text("Substation"),
                        buttonText: const Text("All Substations"),
                        searchable: true,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        selectedColor: const Color.fromARGB(255, 7, 59, 120),
                        onConfirm: (values) {
                          setDialogState(() {
                            selectedSubstations = values;
                          });
                        },
                      ),

                      const SizedBox(height: 20),

                      /// FEEDER
                      const Text(
                        "Feeder",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 8),

                      MultiSelectDialogField<String>(
                        items: feederList
                            .map((e) => MultiSelectItem(e, e))
                            .toList(),
                        initialValue: selectedFeeders,
                        title: const Text("Feeder"),
                        buttonText: const Text("All Feeders"),
                        searchable: true,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        selectedColor: const Color.fromARGB(255, 7, 59, 120),
                        onConfirm: (values) {
                          setDialogState(() {
                            selectedFeeders = values;
                          });
                        },
                      ),

                      const SizedBox(height: 25),

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
                            print(selectedYear);
                            print(selectedSubstations);
                            print(selectedFeeders);

                            Navigator.pop(context);
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
  required double progress,
  required Color color,
}) {
  return Card(
    elevation: 4,
    shadowColor: color.withOpacity(.2),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(14),
    ),
    child: Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        gradient: LinearGradient(
          colors: [color, color.withOpacity(.85)],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          /// Title
          Text(
            title,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 4),

          /// Value
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 2),

          /// Subtitle
          Text(
            subtitle,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 11,
            ),
          ),

          const SizedBox(height: 8),

          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 5,
              backgroundColor: Colors.white24,
              valueColor:
                  const AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
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
  DrawerManu({super.key, required this.menu});

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
                    leading: const Icon(Icons.open_in_new),
                    title: const Text('IVM Maintenance Progress'),
                    textColor: const Color.fromARGB(255, 7, 59, 120),
                    iconColor: const Color.fromARGB(255, 7, 59, 120),
                    onTap: () {
                      Navigator.pop(context);
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
                              AdminChangeOrderAllStatus(source: ''),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.airplane_ticket_sharp),
                    title: const Text('IVM Maintenance Job List'),
                    textColor: const Color.fromARGB(255, 7, 59, 120),
                    iconColor: const Color.fromARGB(255, 7, 59, 120),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const AdminAddNewRowTable(),
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
                              const UserManagementTabs(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.logout),
                    title: const Text('Logout'),
                    textColor: const Color.fromARGB(255, 7, 59, 120),
                    iconColor: const Color.fromARGB(255, 7, 59, 120),
                    onTap: () {
                      // Constants.prefs.setBool("LoggedIn", false);
                      userPreferences.remove().then((value) {
                        Navigator.of(context).push(
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
