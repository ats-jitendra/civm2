// ignore: file_names
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:CIVM/piedmont/resources/app_colors.dart';
import '../../../data/response/status.dart';
import '../../../view_model/row_maintenance_progress_dashboard_view_model.dart';

// ignore: must_be_immutable
class IVMMaintenanceProgressDashboard extends StatefulWidget {
  const IVMMaintenanceProgressDashboard({Key? key}) : super(key: key);

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

  late final bool animate = true;

  final TextEditingController _perdayCost = TextEditingController();
  final TextEditingController _permonthCost = TextEditingController();
  final TextEditingController _peryearCost = TextEditingController();
  final TextEditingController _input = TextEditingController();
  late final Future? myFuture;
  var result = [];

  String name = '';
  // ignore: non_constant_identifier_names
  final select_year = [
    '2026',
    '2025',
    '2024',
    '2023',
    '2022',
    '2021',
    '2020',
  ];
  String? year = '2026';

  final gradientList = <List<Color>>[
    // [
    //   const Color.fromARGB(255, 248, 223, 5),
    //   Colors.yellow,
    // ],
    [
      Colors.red,
      const Color.fromARGB(255, 245, 18, 1),
    ],
    [
      const Color.fromARGB(255, 1, 113, 5),
      const Color.fromARGB(255, 1, 113, 5),
    ],
  ];

  final colorList = <Color>[
    Colors.greenAccent,
  ];

  Map<String, double> dataMap1 = {
    "Under Performance": 73.2,
    "Inline Performance": 25.2,
    "Over Performance": 1.6,
  };
  final gradientList1 = <List<Color>>[
    [
      Colors.purpleAccent,
      Colors.purple,
    ],
    [
      Colors.pinkAccent,
      Colors.pink,
    ],
    [
      AppColors.baseColor,
      const Color.fromARGB(255, 1, 182, 7),
    ]
  ];

  final colorList1 = <Color>[
    Colors.greenAccent,
  ];

  List<Map<String, dynamic>> listOfColumns = [];
  List<Map<String, dynamic>> listOfColumns1 = [];
  double onePercent = 0;

  // final List<Chart6HorizontalStacked> chart6HorizontalStacked = [
  //   Chart6HorizontalStacked('2015', 20, 30, 40, 50),
  //   Chart6HorizontalStacked('2016', 40, 20, 10, 16),
  //   Chart6HorizontalStacked('2017', 10, 20, 12, 22),
  // ];

  RowMaintenanceProgressDashboardViewModel
      rowMaintenanceProgressDasboardViewModel =
      RowMaintenanceProgressDashboardViewModel();

  late TooltipBehavior _tooltipBehavior1;
  late TooltipBehavior _tooltipBehavior2;
  late TooltipBehavior _tooltipBehavior3;
  late TooltipBehavior _tooltipBehavior4;
  late TooltipBehavior _tooltipBehavior5;
  late TooltipBehavior _tooltipBehavior6;
  late TooltipBehavior _tooltipBehavior;

  DateTime now = DateTime.now();

  @override
  void initState() {
    super.initState();
    _tooltipBehavior = TooltipBehavior(enable: true);
    _tooltipBehavior1 =
        TooltipBehavior(enable: true, tooltipPosition: TooltipPosition.pointer);
    _tooltipBehavior2 =
        TooltipBehavior(enable: true, tooltipPosition: TooltipPosition.pointer);
    _tooltipBehavior3 =
        TooltipBehavior(enable: true, tooltipPosition: TooltipPosition.pointer);
    _tooltipBehavior4 =
        TooltipBehavior(enable: true, tooltipPosition: TooltipPosition.pointer);
    _tooltipBehavior5 =
        TooltipBehavior(enable: true, tooltipPosition: TooltipPosition.pointer);
    _tooltipBehavior6 =
        TooltipBehavior(enable: true, tooltipPosition: TooltipPosition.pointer);
    rowMaintenanceProgressDasboardViewModel
        .fetchRowMaintenanceProgressDashboardDataApi(
            context, now.year.toString());
    _perdayCost.text = '0.0';
    _permonthCost.text = '0.0';
    _peryearCost.text = '0.0';
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
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
                      await rowMaintenanceProgressDasboardViewModel
                          .fetchRowMaintenanceProgressDashboardDataApi(
                              context, now.year.toString());
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
                              // height: size.height * 0.2,
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
                                        color:
                                            Color.fromARGB(255, 130, 193, 245),
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
                                          "Overall Status",
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
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8.0),
                                          child: Row(
                                            children: [
                                              // Expanded(
                                              //   child: Column(
                                              //     children: [
                                              //       Text(
                                              //         (rowMaintenanceProgressDasboardViewModel
                                              //                     .rowMaintenanceProgressGetDataList
                                              //                     .data!
                                              //                     .percentAndStatus![
                                              //                         1]
                                              //                     .percentage ==
                                              //                 null)
                                              //             ? '0.0 %'
                                              //             : '${rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.percentAndStatus![1].percentage.toString()} %',
                                              //         style: const TextStyle(
                                              //           color: Colors.black,
                                              //           fontWeight:
                                              //               FontWeight.bold,
                                              //           fontSize: 16,
                                              //         ),
                                              //       ),
                                              //       const Text(
                                              //         'IN PROGRESS',
                                              //         style: TextStyle(
                                              //           color: Colors.red,
                                              //           fontWeight:
                                              //               FontWeight.bold,
                                              //           fontSize: 14,
                                              //         ),
                                              //       ),
                                              //     ],
                                              //   ),
                                              // ),

                                              Expanded(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      (rowMaintenanceProgressDasboardViewModel
                                                                  .rowMaintenanceProgressGetDataList
                                                                  .data!
                                                                  .percentAndStatus![
                                                                      1]
                                                                  .percentage ==
                                                              null)
                                                          ? '0.0 %'
                                                          : '${rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.percentAndStatus![1].percentage.toString()} %',
                                                      // (rowMaintenanceProgressDasboardViewModel
                                                      //             .rowMaintenanceProgressGetDataList
                                                      //             .data!
                                                      //             .percentAndStatus![
                                                      //                 0]
                                                      //             .percentage ==
                                                      //         null)
                                                      //     ? '0.0 %'
                                                      //     : ' ${rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.percentAndStatus![0].percentage.toString()} %',
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
                                                                  .percentAndStatus![
                                                                      2]
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
                                              top: 18.0, bottom: 18),
                                          child: PieChart(
                                            // dataMap: Map.fromEntries(
                                            //   List.generate(
                                            //     rowMaintenanceProgressDasboardViewModel
                                            //         .rowMaintenanceProgressGetDataList
                                            //         .data!
                                            //         .percentAndStatus!
                                            //         .length,
                                            //     (i) => MapEntry(
                                            //       rowMaintenanceProgressDasboardViewModel
                                            //           .rowMaintenanceProgressGetDataList
                                            //           .data!
                                            //           .percentAndStatus![i]
                                            //           .status
                                            //           .toString(),
                                            //       double.tryParse(
                                            //             rowMaintenanceProgressDasboardViewModel
                                            //                 .rowMaintenanceProgressGetDataList
                                            //                 .data!
                                            //                 .percentAndStatus![
                                            //                     i]
                                            //                 .percentage
                                            //                 .toString(),
                                            //           ) ??
                                            //           0.0,
                                            //     ),
                                            //   ),
                                            // ),
                                            dataMap: Map.fromEntries(
                                              rowMaintenanceProgressDasboardViewModel
                                                  .rowMaintenanceProgressGetDataList
                                                  .data!
                                                  .percentAndStatus!
                                                  .where((item) =>
                                                      item.status !=
                                                      "IN PROGRESS") // added here
                                                  .map(
                                                    (item) => MapEntry(
                                                      item.status.toString(),
                                                      double.tryParse(item
                                                              .percentage
                                                              .toString()) ??
                                                          0.0,
                                                    ),
                                                  ),
                                            ),
                                            animationDuration: const Duration(
                                                milliseconds: 800),
                                            chartLegendSpacing: 32,
                                            chartRadius: MediaQuery.of(context)
                                                    .size
                                                    .width /
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
                                              showChartValuesInPercentage: true,
                                              showChartValuesOutside: false,
                                              decimalPlaces: 1,
                                            ),
                                            gradientList: gradientList,
                                            // emptyColorGradient: ---Empty Color gradient---
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
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
                                        color:
                                            Color.fromARGB(255, 130, 193, 245),
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
                                          "GeneralForeman's Status",
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
                                      // primaryXAxis: CategoryAxis(
                                      //   title: AxisTitle(
                                      //       text: 'Crew',
                                      //       textStyle: const TextStyle(
                                      //           color: Colors.red,
                                      //           fontFamily: 'Roboto',
                                      //           fontSize: 16,
                                      //           //// fontStyle: FontStyle.italic,
                                      //           fontWeight: FontWeight.bold)),
                                      // ),
                                      // primaryYAxis: CategoryAxis(
                                      //   title: AxisTitle(
                                      //       text: 'Value(in miles)',
                                      //       textStyle: const TextStyle(
                                      //           color: Colors.red,
                                      //           fontFamily: 'Roboto',
                                      //           fontSize: 16,
                                      //           //// fontStyle: FontStyle.italic,
                                      //           fontWeight: FontWeight.bold)),
                                      // ),
                                      tooltipBehavior: _tooltipBehavior6,
                                      primaryXAxis: CategoryAxis(
                                        title: AxisTitle(
                                            text: 'GeneralForeman',
                                            textStyle: const TextStyle(
                                                color: Colors.red,
                                                fontFamily: 'Roboto',
                                                fontSize: 16,
                                                //// fontStyle: FontStyle.italic,
                                                fontWeight: FontWeight.bold)),
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
                                                  //// fontStyle: FontStyle.italic,
                                                  fontWeight: FontWeight.bold)),
                                          axisLine: const AxisLine(width: 0),
                                          labelFormat: '{value}',
                                          //maximum: 2000,
                                          majorTickLines:
                                              const MajorTickLines(size: 0)),
                                      legend: Legend(isVisible: true),
                                      palette: const <Color>[
                                        Color.fromARGB(255, 2, 127, 6),
                                        Colors.red
                                      ],
                                      series: <CartesianSeries>[
                                        ColumnSeries<
                                                _ChartDataSimpleColumnChart1,
                                                String>(
                                            name: 'MILES_COMPLETED',
                                            dataSource:
                                                recreateDataCrewStatus(value),
                                            xValueMapper:
                                                (_ChartDataSimpleColumnChart1
                                                            data,
                                                        _) =>
                                                    data.x,
                                            yValueMapper:
                                                (_ChartDataSimpleColumnChart1
                                                            data,
                                                        _) =>
                                                    data.y1,
                                            enableTooltip: true,
                                            markerSettings:
                                                const MarkerSettings(
                                                    isVisible: true,
                                                    shape:
                                                        DataMarkerType.diamond),
                                            dataLabelSettings:
                                                const DataLabelSettings(
                                                    isVisible: true)),
                                        ColumnSeries<
                                                _ChartDataSimpleColumnChart1,
                                                String>(
                                            name: 'MILES_IN_PROGRESS',
                                            dataSource:
                                                recreateDataCrewStatus(value),
                                            xValueMapper:
                                                (_ChartDataSimpleColumnChart1
                                                            data,
                                                        _) =>
                                                    data.x,
                                            yValueMapper:
                                                (_ChartDataSimpleColumnChart1
                                                            data,
                                                        _) =>
                                                    data.y2,
                                            enableTooltip: true,
                                            markerSettings:
                                                const MarkerSettings(
                                                    isVisible: true,
                                                    shape:
                                                        DataMarkerType.diamond),
                                            dataLabelSettings:
                                                const DataLabelSettings(
                                                    isVisible: true)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            /////////////////range error////////////////////////////////////////
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
                                        color:
                                            Color.fromARGB(255, 130, 193, 245),
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
                                          "Affected Days By Cause",
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
                                      tooltipBehavior: _tooltipBehavior5,
                                      primaryXAxis: CategoryAxis(
                                        title: AxisTitle(
                                            text: 'CAUSE',
                                            textStyle: const TextStyle(
                                                color: Colors.red,
                                                fontFamily: 'Roboto',
                                                fontSize: 16,
                                                // fontStyle: FontStyle.italic,
                                                fontWeight: FontWeight.bold)),
                                        majorGridLines:
                                            const MajorGridLines(width: 0),
                                      ),
                                      primaryYAxis: NumericAxis(
                                          title: AxisTitle(
                                              text: 'NUMBER OF AFFECTED DAYS',
                                              textStyle: const TextStyle(
                                                  color: Colors.red,
                                                  fontFamily: 'Roboto',
                                                  fontSize: 16,
                                                  // fontStyle: FontStyle.italic,
                                                  fontWeight: FontWeight.bold)),
                                          axisLine: const AxisLine(width: 0),
                                          labelFormat: '{value}',
                                          //maximum: 50,
                                          majorTickLines:
                                              const MajorTickLines(size: 0)),
                                      legend: Legend(isVisible: true),
                                      palette: const <Color>[
                                        Color.fromARGB(255, 2, 108, 138),
                                        Color.fromARGB(255, 235, 109, 63),
                                        Colors.orange,
                                        Colors.green,
                                        Colors.purple,
                                      ],
                                      series: <CartesianSeries>[
                                        if (value
                                            .rowMaintenanceProgressGetDataList
                                            .data!
                                            .affectedDaysByCausesList!
                                            .isNotEmpty)
                                          ColumnSeries<_ChartDataSimpleColumnChart2, String>(
                                              name: value
                                                  .rowMaintenanceProgressGetDataList
                                                  .data!
                                                  .affectedDaysByCausesList![0]
                                                  .crew1,
                                              dataSource:
                                                  recreateDataAffectedDaysByClause(
                                                      value),
                                              xValueMapper:
                                                  (_ChartDataSimpleColumnChart2 data, _) =>
                                                      data.x,
                                              yValueMapper:
                                                  (_ChartDataSimpleColumnChart2 data,
                                                          _) =>
                                                      data.y,
                                              enableTooltip: true,
                                              markerSettings: const MarkerSettings(
                                                  isVisible: true,
                                                  shape:
                                                      DataMarkerType.diamond),
                                              dataLabelSettings:
                                                  const DataLabelSettings(isVisible: true)),
                                        if (value
                                            .rowMaintenanceProgressGetDataList
                                            .data!
                                            .affectedDaysByCausesList!
                                            .isNotEmpty)
                                          ColumnSeries<_ChartDataSimpleColumnChart2, String>(
                                              name: value
                                                  .rowMaintenanceProgressGetDataList
                                                  .data!
                                                  .affectedDaysByCausesList![0]
                                                  .crew2,
                                              dataSource:
                                                  recreateDataAffectedDaysByClause(
                                                      value),
                                              xValueMapper:
                                                  (_ChartDataSimpleColumnChart2 data, _) =>
                                                      data.x,
                                              yValueMapper:
                                                  (_ChartDataSimpleColumnChart2 data,
                                                          _) =>
                                                      data.y1,
                                              enableTooltip: true,
                                              markerSettings: const MarkerSettings(
                                                  isVisible: true,
                                                  shape:
                                                      DataMarkerType.diamond),
                                              dataLabelSettings:
                                                  const DataLabelSettings(isVisible: true)),
                                        if (value
                                            .rowMaintenanceProgressGetDataList
                                            .data!
                                            .affectedDaysByCausesList!
                                            .isNotEmpty)
                                          ColumnSeries<_ChartDataSimpleColumnChart2, String>(
                                              name: value
                                                  .rowMaintenanceProgressGetDataList
                                                  .data!
                                                  .affectedDaysByCausesList![0]
                                                  .crew3,
                                              dataSource:
                                                  recreateDataAffectedDaysByClause(
                                                      value),
                                              xValueMapper:
                                                  (_ChartDataSimpleColumnChart2 data, _) =>
                                                      data.x,
                                              yValueMapper:
                                                  (_ChartDataSimpleColumnChart2 data,
                                                          _) =>
                                                      data.y2,
                                              enableTooltip: true,
                                              markerSettings: const MarkerSettings(
                                                  isVisible: true,
                                                  shape:
                                                      DataMarkerType.diamond),
                                              dataLabelSettings:
                                                  const DataLabelSettings(isVisible: true)),
                                        if (value
                                            .rowMaintenanceProgressGetDataList
                                            .data!
                                            .affectedDaysByCausesList!
                                            .isNotEmpty)
                                          ColumnSeries<_ChartDataSimpleColumnChart2, String>(
                                              name: value
                                                  .rowMaintenanceProgressGetDataList
                                                  .data!
                                                  .affectedDaysByCausesList![0]
                                                  .crew4,
                                              dataSource:
                                                  recreateDataAffectedDaysByClause(
                                                      value),
                                              xValueMapper:
                                                  (_ChartDataSimpleColumnChart2 data, _) =>
                                                      data.x,
                                              yValueMapper:
                                                  (_ChartDataSimpleColumnChart2 data,
                                                          _) =>
                                                      data.y3,
                                              enableTooltip: true,
                                              markerSettings: const MarkerSettings(
                                                  isVisible: true,
                                                  shape:
                                                      DataMarkerType.diamond),
                                              dataLabelSettings:
                                                  const DataLabelSettings(isVisible: true)),
                                        if (value
                                            .rowMaintenanceProgressGetDataList
                                            .data!
                                            .affectedDaysByCausesList!
                                            .isNotEmpty)
                                          ColumnSeries<_ChartDataSimpleColumnChart2, String>(
                                              name: value
                                                  .rowMaintenanceProgressGetDataList
                                                  .data!
                                                  .affectedDaysByCausesList![0]
                                                  .crew5,
                                              dataSource:
                                                  recreateDataAffectedDaysByClause(
                                                      value),
                                              xValueMapper:
                                                  (_ChartDataSimpleColumnChart2 data, _) =>
                                                      data.x,
                                              yValueMapper:
                                                  (_ChartDataSimpleColumnChart2 data,
                                                          _) =>
                                                      data.y4,
                                              enableTooltip: true,
                                              markerSettings: const MarkerSettings(
                                                  isVisible: true,
                                                  shape:
                                                      DataMarkerType.diamond),
                                              dataLabelSettings:
                                                  const DataLabelSettings(isVisible: true)),
                                      ],
                                    ),
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
                                        color:
                                            Color.fromARGB(255, 130, 193, 245),
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
                                          "Affected Days By Weather Delay",
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
                                      child: Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: SfCartesianChart(
                                      tooltipBehavior: _tooltipBehavior4,
                                      primaryXAxis: CategoryAxis(
                                        title: AxisTitle(
                                            text: 'DELAY REASON',
                                            textStyle: const TextStyle(
                                                color: Colors.red,
                                                fontFamily: 'Roboto',
                                                fontSize: 16,
                                                // fontStyle: FontStyle.italic,
                                                fontWeight: FontWeight.bold)),
                                        majorGridLines:
                                            const MajorGridLines(width: 0),
                                      ),
                                      primaryYAxis: NumericAxis(
                                          title: AxisTitle(
                                              text: 'NUMBER OF AFFECTED DAYS',
                                              textStyle: const TextStyle(
                                                  color: Colors.red,
                                                  fontFamily: 'Roboto',
                                                  fontSize: 16,
                                                  // fontStyle: FontStyle.italic,
                                                  fontWeight: FontWeight.bold)),
                                          axisLine: const AxisLine(width: 0),
                                          labelFormat: '{value}',
                                          //maximum: 50,
                                          majorTickLines:
                                              const MajorTickLines(size: 0)),
                                      legend: Legend(isVisible: true),
                                      palette: const <Color>[
                                        Color.fromARGB(255, 2, 109, 197),
                                        Color.fromARGB(255, 255, 94, 0),
                                        Colors.orange,
                                        Colors.green,
                                        Colors.purple,
                                      ],
                                      series: <CartesianSeries>[
                                        ColumnSeries<Chart4ColumnStacked,
                                            String>(
                                          name: 'EFFECTED_NO_OF_DAYS',
                                          dataSource:
                                              recreateDataAffectedDaysByWeatherDelay(
                                                  value),
                                          xValueMapper:
                                              (Chart4ColumnStacked ch, _) =>
                                                  ch.x,
                                          yValueMapper:
                                              (Chart4ColumnStacked ch, _) =>
                                                  ch.y,
                                          enableTooltip: true,
                                          markerSettings: const MarkerSettings(
                                            isVisible: true,
                                            shape: DataMarkerType.diamond,
                                          ),
                                          dataLabelSettings:
                                              const DataLabelSettings(
                                                  isVisible: true),
                                        ),
                                      ],
                                    ),
                                  )),
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
                                        color:
                                            Color.fromARGB(255, 130, 193, 245),
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
                                          "Affected Days By Other Issues",
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
                                      child: Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: SfCartesianChart(
                                      // primaryXAxis: CategoryAxis(
                                      //   title: AxisTitle(
                                      //       text: 'Other Issues',
                                      //       textStyle: const TextStyle(
                                      //           color: Colors.red,
                                      //           fontFamily: 'Roboto',
                                      //           fontSize: 16,
                                      //           // fontStyle: FontStyle.italic,
                                      //           fontWeight: FontWeight.bold)),
                                      // ),
                                      // primaryYAxis: CategoryAxis(
                                      //   title: AxisTitle(
                                      //       text: 'Number Of Affected Days',
                                      //       textStyle: const TextStyle(
                                      //           color: Colors.red,
                                      //           fontFamily: 'Roboto',
                                      //           fontSize: 16,
                                      //           // fontStyle: FontStyle.italic,
                                      //           fontWeight: FontWeight.bold)),
                                      // ),

                                      tooltipBehavior: _tooltipBehavior3,
                                      primaryXAxis: CategoryAxis(
                                        title: AxisTitle(
                                            text: 'OTHER ISSUES',
                                            textStyle: const TextStyle(
                                                color: Colors.red,
                                                fontFamily: 'Roboto',
                                                fontSize: 16,
                                                // fontStyle: FontStyle.italic,
                                                fontWeight: FontWeight.bold)),
                                        majorGridLines:
                                            const MajorGridLines(width: 0),
                                      ),
                                      primaryYAxis: NumericAxis(
                                          title: AxisTitle(
                                              text: 'NUMBER OF AFFECTED DAYS',
                                              textStyle: const TextStyle(
                                                  color: Colors.red,
                                                  fontFamily: 'Roboto',
                                                  fontSize: 16,
                                                  // fontStyle: FontStyle.italic,
                                                  fontWeight: FontWeight.bold)),
                                          axisLine: const AxisLine(width: 0),
                                          labelFormat: '{value}',
                                          //maximum: 20,
                                          majorTickLines:
                                              const MajorTickLines(size: 0)),
                                      legend: Legend(isVisible: true),
                                      palette: const <Color>[
                                        Color.fromARGB(255, 2, 109, 197),
                                        Colors.red,
                                        Colors.orange,
                                        Colors.green,
                                        Colors.purple,
                                      ],
                                      series: <CartesianSeries>[
                                        if (value
                                            .rowMaintenanceProgressGetDataList
                                            .data!
                                            .affectedDaysByOtherIssuesList!
                                            .isNotEmpty)
                                          StackedBarSeries<
                                              Chart6HorizontalStacked, String>(
                                            dataSource:
                                                recreateAffectedDaysByOtherCause(
                                                    value),
                                            xValueMapper:
                                                (Chart6HorizontalStacked ch,
                                                        _) =>
                                                    ch.x,
                                            yValueMapper:
                                                (Chart6HorizontalStacked ch,
                                                        _) =>
                                                    ch.y1,
                                            enableTooltip: true,
                                            markerSettings:
                                                const MarkerSettings(
                                                    isVisible: true,
                                                    shape:
                                                        DataMarkerType.diamond),
                                            name: value
                                                .rowMaintenanceProgressGetDataList
                                                .data!
                                                .affectedDaysByOtherIssuesList![
                                                    0]
                                                .crew1,
                                          ),
                                        if (value
                                            .rowMaintenanceProgressGetDataList
                                            .data!
                                            .affectedDaysByOtherIssuesList!
                                            .isNotEmpty)
                                          StackedBarSeries<
                                              Chart6HorizontalStacked, String>(
                                            dataSource:
                                                recreateAffectedDaysByOtherCause(
                                                    value),
                                            xValueMapper:
                                                (Chart6HorizontalStacked ch,
                                                        _) =>
                                                    ch.x,
                                            yValueMapper:
                                                (Chart6HorizontalStacked ch,
                                                        _) =>
                                                    ch.y2,
                                            enableTooltip: true,
                                            markerSettings:
                                                const MarkerSettings(
                                                    isVisible: true,
                                                    shape:
                                                        DataMarkerType.diamond),
                                            name: value
                                                .rowMaintenanceProgressGetDataList
                                                .data!
                                                .affectedDaysByOtherIssuesList![
                                                    0]
                                                .crew2,
                                          ),
                                        if (value
                                            .rowMaintenanceProgressGetDataList
                                            .data!
                                            .affectedDaysByOtherIssuesList!
                                            .isNotEmpty)
                                          StackedBarSeries<
                                              Chart6HorizontalStacked, String>(
                                            dataSource:
                                                recreateAffectedDaysByOtherCause(
                                                    value),
                                            xValueMapper:
                                                (Chart6HorizontalStacked ch,
                                                        _) =>
                                                    ch.x,
                                            yValueMapper:
                                                (Chart6HorizontalStacked ch,
                                                        _) =>
                                                    ch.y3,
                                            enableTooltip: true,
                                            markerSettings:
                                                const MarkerSettings(
                                                    isVisible: true,
                                                    shape:
                                                        DataMarkerType.diamond),
                                            name: value
                                                .rowMaintenanceProgressGetDataList
                                                .data!
                                                .affectedDaysByOtherIssuesList![
                                                    0]
                                                .crew3,
                                          ),
                                        if (value
                                            .rowMaintenanceProgressGetDataList
                                            .data!
                                            .affectedDaysByOtherIssuesList!
                                            .isNotEmpty)
                                          StackedBarSeries<
                                              Chart6HorizontalStacked, String>(
                                            dataSource:
                                                recreateAffectedDaysByOtherCause(
                                                    value),
                                            xValueMapper:
                                                (Chart6HorizontalStacked ch,
                                                        _) =>
                                                    ch.x,
                                            yValueMapper:
                                                (Chart6HorizontalStacked ch,
                                                        _) =>
                                                    ch.y4,
                                            enableTooltip: true,
                                            markerSettings:
                                                const MarkerSettings(
                                                    isVisible: true,
                                                    shape:
                                                        DataMarkerType.diamond),
                                            name: value
                                                .rowMaintenanceProgressGetDataList
                                                .data!
                                                .affectedDaysByOtherIssuesList![
                                                    0]
                                                .crew4,
                                          ),
                                        if (value
                                            .rowMaintenanceProgressGetDataList
                                            .data!
                                            .affectedDaysByOtherIssuesList!
                                            .isNotEmpty)
                                          StackedBarSeries<
                                              Chart6HorizontalStacked, String>(
                                            dataSource:
                                                recreateAffectedDaysByOtherCause(
                                                    value),
                                            xValueMapper:
                                                (Chart6HorizontalStacked ch,
                                                        _) =>
                                                    ch.x,
                                            yValueMapper:
                                                (Chart6HorizontalStacked ch,
                                                        _) =>
                                                    ch.y5,
                                            enableTooltip: true,
                                            markerSettings:
                                                const MarkerSettings(
                                                    isVisible: true,
                                                    shape:
                                                        DataMarkerType.diamond),
                                            name: value
                                                .rowMaintenanceProgressGetDataList
                                                .data!
                                                .affectedDaysByOtherIssuesList![
                                                    0]
                                                .crew5,
                                          ),
                                      ],
                                    ),
                                  )),
                                ],
                              ),
                            ),

                            //////////////error range ended///////////////

                            Container(
                              margin: const EdgeInsets.only(
                                  top: 10, bottom: 10, left: 8, right: 8),
                              // padding: const EdgeInsets.all(8),
                              alignment: Alignment.center,
                              height: size.height * 0.6,
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
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, right: 8, top: 8),
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
                                                color: AppColors.buttonShadow,
                                                blurRadius: 5,
                                                offset: Offset(2.0, 5.0))
                                          ],
                                          color: Color.fromARGB(
                                              255, 130, 193, 245),
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
                                                fontWeight: FontWeight.bold)),
                                        majorGridLines:
                                            const MajorGridLines(width: 0),
                                      ),
                                      primaryYAxis: NumericAxis(
                                          title: AxisTitle(
                                              text: 'PERFORMANCE(%)',
                                              textStyle: const TextStyle(
                                                  color: Colors.red,
                                                  fontFamily: 'Roboto',
                                                  fontSize: 16,
                                                  // fontStyle: FontStyle.italic,
                                                  fontWeight: FontWeight.bold)),
                                          axisLine: const AxisLine(width: 0),
                                          labelFormat: '{value}',
                                          // //maximum: 300,
                                          majorTickLines:
                                              const MajorTickLines(size: 0)),
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
                                            value)) ...[
                                          StackedColumnSeries<
                                              Chart9ColumnStacked, String>(
                                            dataSource:
                                                recreateDataYearlyPerformanceMatricsByMaintenanceType(
                                                    value, type.toString()),
                                            xValueMapper:
                                                (Chart9ColumnStacked ch, _) =>
                                                    ch.x,
                                            yValueMapper:
                                                (Chart9ColumnStacked ch, _) =>
                                                    ch.y1,
                                            name: type,
                                            enableTooltip: true,
                                          ),
                                        ]
                                      ],
                                    ),
                                  )),
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                  top: 10, bottom: 10, left: 8, right: 8),
                              padding: const EdgeInsets.all(8),
                              alignment: Alignment.center,
                              height: size.height * 0.7,
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
                                              top: 10.0),
                                          child: Column(
                                            children: [
                                              const Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    "Year",
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: Color.fromARGB(
                                                          255, 7, 59, 120),
                                                      //fontWeight: FontWeight.bold
                                                    ),
                                                  )),
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(2.0),
                                                  child:
                                                      DropdownButtonFormField<
                                                          String>(
                                                    hint:
                                                        const Text('-Select-'),
                                                    dropdownColor: Colors.white,
                                                    value: year,
                                                    style: const TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 7, 59, 120),
                                                        fontSize: 16),
                                                    icon: const Icon(
                                                      Icons.arrow_drop_down,
                                                      color: Color.fromARGB(
                                                          255, 7, 59, 120),
                                                      size: 40,
                                                    ),
                                                    decoration:
                                                        const InputDecoration(
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Color.fromARGB(
                                                              255, 7, 59, 120),
                                                        ),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Color.fromARGB(
                                                              255, 7, 59, 120),
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
                                                              year.toString());
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
                                          padding:
                                              const EdgeInsets.only(top: 8.0),
                                          child: SfCartesianChart(
                                              tooltipBehavior:
                                                  _tooltipBehavior2,
                                              primaryXAxis: CategoryAxis(
                                                title: AxisTitle(
                                                    text: 'YEAR',
                                                    textStyle: const TextStyle(
                                                        color: Colors.red,
                                                        fontFamily: 'Roboto',
                                                        fontSize: 16,
                                                        // fontStyle: FontStyle.italic,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                majorGridLines:
                                                    const MajorGridLines(
                                                        width: 0),
                                              ),
                                              primaryYAxis: NumericAxis(
                                                  title: AxisTitle(
                                                      text: 'PERFORMANCE(%)',
                                                      textStyle:
                                                          const TextStyle(
                                                              color: Colors.red,
                                                              fontFamily:
                                                                  'Roboto',
                                                              fontSize: 16,
                                                              // fontStyle: FontStyle.italic,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                  axisLine:
                                                      const AxisLine(width: 0),
                                                  labelFormat: '{value}',
                                                  // //maximum: 30000,
                                                  majorTickLines:
                                                      const MajorTickLines(
                                                          size: 0)),
                                              legend: Legend(isVisible: true),
                                              palette: const <Color>[
                                                Color.fromARGB(255, 38, 2, 217),
                                                Colors.red,
                                                Colors.orange,
                                                Colors.green,
                                                Colors.purple,
                                                Colors.blue,
                                                Color.fromARGB(
                                                    255, 247, 79, 135),
                                              ],
                                              series: <CartesianSeries>[
                                                for (var type
                                                    in getTypeMonthlyListList(
                                                        value)) ...[
                                                  StackedColumnSeries<
                                                      Chart10ColumnStacked,
                                                      String>(
                                                    dataSource:
                                                        recreateDataMonthlyPerformanceMatricsByMaintenanceType(
                                                      value,
                                                      type.toString(),
                                                    ),
                                                    xValueMapper:
                                                        (Chart10ColumnStacked
                                                                    ch,
                                                                _) =>
                                                            ch.x,
                                                    yValueMapper:
                                                        (Chart10ColumnStacked
                                                                    ch,
                                                                _) =>
                                                            ch.y1,
                                                    name: type.toString(),
                                                  ),
                                                ],
                                              ]),
                                        )),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                  top: 10, bottom: 10, left: 8, right: 8),
                              // padding: const EdgeInsets.all(8),
                              alignment: Alignment.center,
                              height: size.height * 0.6,
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
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, right: 8, top: 8),
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
                                                color: AppColors.buttonShadow,
                                                blurRadius: 5,
                                                offset: Offset(2.0, 5.0))
                                          ],
                                          color: Color.fromARGB(
                                              255, 130, 193, 245),
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
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              majorGridLines:
                                                  const MajorGridLines(
                                                      width: 0),
                                            ),
                                            primaryYAxis: NumericAxis(
                                                title: AxisTitle(
                                                    text: 'PERFORMANCE(%)',
                                                    textStyle: const TextStyle(
                                                        color: Colors.red,
                                                        fontFamily: 'Roboto',
                                                        fontSize: 16,
                                                        // fontStyle: FontStyle.italic,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                axisLine:
                                                    const AxisLine(width: 0),
                                                labelFormat: '{value}',
                                                // //maximum: 300,
                                                majorTickLines:
                                                    const MajorTickLines(
                                                        size: 0)),
                                            legend: Legend(isVisible: true),
                                            palette: const <Color>[
                                              Color.fromARGB(255, 38, 2, 217),
                                              Colors.red,
                                              Colors.orange,
                                            ],
                                            series: <CartesianSeries>[
                                              StackedColumnSeries<
                                                  Chart11ColumnStacked, String>(
                                                dataSource:
                                                    recreateDataYearlyPerformanceMatrics(
                                                        value),
                                                xValueMapper:
                                                    (Chart11ColumnStacked ch,
                                                            _) =>
                                                        ch.label,
                                                yValueMapper:
                                                    (Chart11ColumnStacked ch,
                                                            _) =>
                                                        ch.y1,
                                                name: 'UnderPerformance',
                                                enableTooltip: true,
                                                markerSettings:
                                                    const MarkerSettings(
                                                        isVisible: true),
                                              ),
                                              StackedColumnSeries<
                                                  Chart11ColumnStacked, String>(
                                                dataSource:
                                                    recreateDataYearlyPerformanceMatrics(
                                                        value),
                                                xValueMapper:
                                                    (Chart11ColumnStacked ch,
                                                            _) =>
                                                        ch.label,
                                                yValueMapper:
                                                    (Chart11ColumnStacked ch,
                                                            _) =>
                                                        ch.y2,
                                                name: 'InlinePerformance',
                                                enableTooltip: true,
                                                markerSettings:
                                                    const MarkerSettings(
                                                        isVisible: true),
                                              ),
                                              StackedColumnSeries<
                                                  Chart11ColumnStacked, String>(
                                                dataSource:
                                                    recreateDataYearlyPerformanceMatrics(
                                                        value),
                                                xValueMapper:
                                                    (Chart11ColumnStacked ch,
                                                            _) =>
                                                        ch.label,
                                                yValueMapper:
                                                    (Chart11ColumnStacked ch,
                                                            _) =>
                                                        ch.y3,
                                                name: 'OverPerformance',
                                                enableTooltip: true,
                                                markerSettings:
                                                    const MarkerSettings(
                                                        isVisible: true),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 8.0, left: 8, right: 8),
                              child: Container(
                                //  margin:  EdgeInsets.only(
                                //      top: 10, bottom: 10, left: 8, right: 8),
                                //  padding:  EdgeInsets.all(8),
                                alignment: Alignment.center,
                                height: size.height * 0.8,
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
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0, right: 8, top: 8),
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
                                                  color: AppColors.buttonShadow,
                                                  blurRadius: 5,
                                                  offset: Offset(2.0, 5.0))
                                            ],
                                            color: Color.fromARGB(
                                                255, 130, 193, 245),
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
                                              "Row Maintenance Progress Data",
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
                                    ),
                                    Row(
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(
                                              top: 8.0, left: 8),
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
                                            rowMaintenanceProgressDasboardViewModel
                                                .rowMaintenanceProgressGetDataList
                                                .data!
                                                .rowMaintenanceData!
                                                .length
                                                .toString(),
                                            // result.length.toString(),
                                            textAlign: TextAlign.left,
                                            style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 7, 59, 120),
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
                                        ),
                                      ],
                                    ),
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: ListView.builder(
                                            itemCount:
                                                rowMaintenanceProgressDasboardViewModel
                                                    .rowMaintenanceProgressGetDataList
                                                    .data!
                                                    .rowMaintenanceData!
                                                    .length,
                                            // itemCount: historyList.length,
                                            itemBuilder:
                                                (BuildContext ctxt, int index) {
                                              return Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 4.0,
                                                            bottom: 4,
                                                            left: 4),
                                                    child: Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.92,
                                                      // margin:  EdgeInsets.only(
                                                      //     top: 5.0, bottom: 5.0, left: 2,right: 2),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8),
                                                      decoration: BoxDecoration(
                                                        gradient:
                                                            LinearGradient(
                                                          colors: [
                                                            AppColors.green1
                                                                .withOpacity(
                                                                    0.9),
                                                            AppColors.green2
                                                                .withOpacity(
                                                                    0.7),
                                                            AppColors.green1
                                                                .withOpacity(
                                                                    0.9),
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
                                                              Radius.circular(
                                                                  10),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  10),
                                                          topLeft:
                                                              Radius.circular(
                                                                  10),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  10),
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
                                                              // Expanded(
                                                              //   child: Column(
                                                              //     crossAxisAlignment:
                                                              //         CrossAxisAlignment
                                                              //             .start,
                                                              //     children: [
                                                              //       const Align(
                                                              //         alignment:
                                                              //             Alignment
                                                              //                 .centerLeft,
                                                              //         child:
                                                              //             Text(
                                                              //           "EDIT: ",
                                                              //           textAlign:
                                                              //               TextAlign.left,
                                                              //           style:
                                                              //               TextStyle(
                                                              //             fontSize:
                                                              //                 12,
                                                              //             fontWeight:
                                                              //                 FontWeight.bold,
                                                              //             color:
                                                              //                 Colors.white,
                                                              //           ),
                                                              //         ),
                                                              //       ),
                                                              //       InkWell(
                                                              //           onTap:
                                                              //               () {
                                                              //             if (rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].maintType == 'RegularMaint' &&
                                                              //                 rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].rowYear !=
                                                              //                     '' &&
                                                              //                 rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].rowYear !=
                                                              //                     'N/A') {
                                                              //               Navigator.push(
                                                              //                   context,
                                                              //                   MaterialPageRoute(
                                                              //                       builder: (context) => SupervisorAddNewRowMaintenancePlan(
                                                              //                             tokenNo: rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].tokenNo == null ? '' : rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].tokenNo.toString(),
                                                              //                             nextMaintYear: rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].nextMaintYear == null ? '' : rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].nextMaintYear.toString(),
                                                              //                             subStation: rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].subStationName == null ? '' : rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].subStationName.toString(),
                                                              //                             feeder: rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].feeder == null ? '' : rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].feeder.toString(),
                                                              //                             maintType: rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].type == null ? '' : rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].type.toString(),
                                                              //                             totalMiles: rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].totalMiles == null ? '' : rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].totalMiles.toString(),
                                                              //                             totalCost: rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].totalCost == null ? '' : rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].totalCost.toString(),
                                                              //                             costPerMile: rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].costPerMile == null ? '' : rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].costPerMile.toString(),
                                                              //                             budgetType: rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].budgetType == null ? '' : rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].budgetType.toString(),
                                                              //                             contractRowYear: rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].contractYear == null ? '' : rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].contractYear.toString(),
                                                              //                             rowCycle: rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].cycle == null ? '' : rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].cycle.toString(),
                                                              //                             rowYear: rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].rowYear == null ? '' : rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].rowYear.toString(),
                                                              //                             contractorCompany: rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].contractorCompay == null ? '' : rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].contractorCompay.toString(),
                                                              //                             assignForeman: rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].contractor == null ? '' : rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].contractor.toString(),
                                                              //                             index: '0',
                                                              //                           )));
                                                              //             } else if (rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].maintType == 'RegularMaint' &&
                                                              //                 rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].rowYear == '' &&
                                                              //                 rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].rowYear != 'N/A') {
                                                              //               Navigator.push(
                                                              //                   context,
                                                              //                   MaterialPageRoute(
                                                              //                       builder: (context) => SupervisorAddNewRowMaintenancePlan(
                                                              //                             tokenNo: rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].tokenNo == null ? '' : rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].tokenNo.toString(),
                                                              //                             nextMaintYear: rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].nextMaintYear == null ? '' : rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].nextMaintYear.toString(),
                                                              //                             subStation: rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].subStationName == null ? '' : rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].subStationName.toString(),
                                                              //                             feeder: rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].feeder == null ? '' : rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].feeder.toString(),
                                                              //                             maintType: rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].type == null ? '' : rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].type.toString(),
                                                              //                             totalMiles: rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].totalMiles == null ? '' : rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].totalMiles.toString(),
                                                              //                             totalCost: rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].totalCost == null ? '' : rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].totalCost.toString(),
                                                              //                             costPerMile: rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].costPerMile == null ? '' : rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].costPerMile.toString(),
                                                              //                             budgetType: rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].budgetType == null ? '' : rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].budgetType.toString(),
                                                              //                             contractRowYear: rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].contractYear == null ? '' : rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].contractYear.toString(),
                                                              //                             rowCycle: rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].cycle == null ? '' : rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].cycle.toString(),
                                                              //                             rowYear: rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].rowYear == null ? '' : rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].rowYear.toString(),
                                                              //                             contractorCompany: rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].contractorCompay == null ? '' : rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].contractorCompay.toString(),
                                                              //                             assignForeman: rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].contractor == null ? '' : rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].contractor.toString(),
                                                              //                             index: '1',
                                                              //                           )));
                                                              //             } else {
                                                              //               Navigator.of(context).push(MaterialPageRoute(
                                                              //                   builder: (BuildContext context) => SupervisorZIELIESCreateOrder(
                                                              //                         tokenNo: rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].tokenNo == null ? '' : rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].tokenNo.toString(),
                                                              //                         subStation: (rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].subStationName == null) ? '' : rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].subStationName.toString(),
                                                              //                         feeder: (rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].feeder == null) ? '' : rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].feeder.toString(),
                                                              //                         serviceStreetAddress: (rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].street == null || rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].street == 'N/A') ? '' : rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].street.toString(),
                                                              //                         serviceMapLocation: (rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].mapLocation == null || rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].mapLocation == 'N/A') ? '' : rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].mapLocation.toString(),
                                                              //                         notes: (rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].adminNotes1 == null) ? '' : rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].adminNotes1.toString(),
                                                              //                         type: (rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].type == null) ? '' : rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].type.toString(),
                                                              //                         maintType: (rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].maintType == null) ? '' : rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].maintType.toString(),
                                                              //                         contractorCompany: (rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].contractorCompay == null) ? '' : rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].contractorCompay.toString(),
                                                              //                         assignForeman: rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].contractor == null ? '' : rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].contractor.toString(),
                                                              //                         estimatedCost: rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].estCost == null ? '' : rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].estCost.toString(),
                                                              //                         estimatedTime: rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].estTime == null ? '' : rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].estTime.toString(),
                                                              //                         actualCost: rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].actualCost == null ? '' : rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].actualCost.toString(),
                                                              //                         crew:  rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].actualCost == null ? '' : rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].crew.toString()
                                                              //                       )));
                                                              //             }
                                                              //           },
                                                              //           child:
                                                              //               const Align(
                                                              //             alignment:
                                                              //                 Alignment.centerLeft,
                                                              //             child:
                                                              //                 Icon(
                                                              //               Icons.edit,
                                                              //               color: Color.fromARGB(
                                                              //                   255,
                                                              //                   151,
                                                              //                   249,
                                                              //                   154),
                                                              //             ),
                                                              //           )),
                                                              //     ],
                                                              //   ),
                                                              // ),
                                                              // Expanded(
                                                              //   // alignment: Alignment.topLeft,
                                                              //   child: Column(
                                                              //     children: [
                                                              //       const Align(
                                                              //         alignment:
                                                              //             Alignment
                                                              //                 .topLeft,
                                                              //         child:
                                                              //             Text(
                                                              //           "SERIAL: ",
                                                              //           textAlign:
                                                              //               TextAlign.left,
                                                              //           style:
                                                              //               TextStyle(
                                                              //             fontSize:
                                                              //                 12,
                                                              //             fontWeight:
                                                              //                 FontWeight.bold,
                                                              //             color:
                                                              //                 Colors.white,
                                                              //           ),
                                                              //         ),
                                                              //       ),
                                                              //       Align(
                                                              //         alignment:
                                                              //             Alignment
                                                              //                 .topLeft,
                                                              //         child:
                                                              //             Text(
                                                              //           (index +
                                                              //                   1)
                                                              //               .toString(),
                                                              //           textAlign:
                                                              //               TextAlign.left,
                                                              //           style:
                                                              //               const TextStyle(
                                                              //             fontSize:
                                                              //                 12,
                                                              //             //  fontWeight:
                                                              //             //      FontWeight.bold,
                                                              //             color:
                                                              //                 Colors.white,
                                                              //           ),
                                                              //         ),
                                                              //       ),
                                                              //     ],
                                                              //   ),
                                                              // ),
                                                              Expanded(
                                                                // alignment: Alignment.topLeft,
                                                                child: Column(
                                                                  children: [
                                                                    const Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .topLeft,
                                                                      child:
                                                                          Text(
                                                                        "TOKEN NO: ",
                                                                        textAlign:
                                                                            TextAlign.left,
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .topLeft,
                                                                      child:
                                                                          Text(
                                                                        (rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].tokenNo == null ||
                                                                                rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].tokenNo.toString() == 'null')
                                                                            ? ''
                                                                            : rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].tokenNo.toString(),
                                                                        textAlign:
                                                                            TextAlign.left,
                                                                        style:
                                                                            const TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          //  fontWeight:
                                                                          //      FontWeight.bold,
                                                                          color:
                                                                              Colors.white,
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
                                                                      child:
                                                                          Text(
                                                                        "SUBSTATION: ",
                                                                        textAlign:
                                                                            TextAlign.left,
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .topLeft,
                                                                      child:
                                                                          Text(
                                                                        (rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].subStationName == null ||
                                                                                rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].subStationName.toString() == 'null')
                                                                            ? ''
                                                                            : rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].subStationName.toString(),
                                                                        textAlign:
                                                                            TextAlign.left,
                                                                        style:
                                                                            const TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          //  fontWeight:
                                                                          //      FontWeight.bold,
                                                                          color:
                                                                              Colors.white,
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
                                                                      child:
                                                                          Text(
                                                                        "FEEDER: ",
                                                                        textAlign:
                                                                            TextAlign.left,
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .topLeft,
                                                                      child:
                                                                          Text(
                                                                        (rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].feeder == null ||
                                                                                rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].feeder.toString() == 'null')
                                                                            ? ''
                                                                            : rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].feeder.toString(),
                                                                        textAlign:
                                                                            TextAlign.left,
                                                                        style:
                                                                            const TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          //  fontWeight:
                                                                          //      FontWeight.bold,
                                                                          color:
                                                                              Colors.white,
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
                                                                      child:
                                                                          Text(
                                                                        "TRANSMISSION NAME: ",
                                                                        textAlign:
                                                                            TextAlign.left,
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .topLeft,
                                                                      child:
                                                                          Text(
                                                                        (rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].transmissionName == null ||
                                                                                rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].transmissionName.toString() == 'null')
                                                                            ? ''
                                                                            : rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].transmissionName.toString(),
                                                                        textAlign:
                                                                            TextAlign.left,
                                                                        style:
                                                                            const TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          //  fontWeight:
                                                                          //      FontWeight.bold,
                                                                          color:
                                                                              Colors.white,
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
                                                                      child:
                                                                          Text(
                                                                        "CONTRACTOR: ",
                                                                        textAlign:
                                                                            TextAlign.left,
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .topLeft,
                                                                      child:
                                                                          Text(
                                                                        (rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].contractor == null ||
                                                                                rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].contractor.toString() == 'null')
                                                                            ? ''
                                                                            : rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].contractor.toString(),
                                                                        textAlign:
                                                                            TextAlign.left,
                                                                        style:
                                                                            const TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          //  fontWeight:
                                                                          //      FontWeight.bold,
                                                                          color:
                                                                              Colors.white,
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
                                                                      child:
                                                                          Text(
                                                                        "MAINTTYPE: ",
                                                                        textAlign:
                                                                            TextAlign.left,
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .topLeft,
                                                                      child:
                                                                          Text(
                                                                        (rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].maintType == null ||
                                                                                rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].maintType.toString() == 'null')
                                                                            ? ''
                                                                            : rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].maintType.toString(),
                                                                        textAlign:
                                                                            TextAlign.left,
                                                                        style:
                                                                            const TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          //  fontWeight:
                                                                          //      FontWeight.bold,
                                                                          color:
                                                                              Colors.white,
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
                                                                      child:
                                                                          Text(
                                                                        "STATUS: ",
                                                                        textAlign:
                                                                            TextAlign.left,
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .topLeft,
                                                                      child:
                                                                          Text(
                                                                        (rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].status == null ||
                                                                                rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].status.toString() == 'null')
                                                                            ? ''
                                                                            : rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].status.toString(),
                                                                        textAlign:
                                                                            TextAlign.left,
                                                                        style:
                                                                            const TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          //  fontWeight:
                                                                          //      FontWeight.bold,
                                                                          color:
                                                                              Colors.white,
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
                                                                      child:
                                                                          Text(
                                                                        "LAST ROW YEAR: ",
                                                                        textAlign:
                                                                            TextAlign.left,
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .topLeft,
                                                                      child:
                                                                          Text(
                                                                        (rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].lastRowYear == null ||
                                                                                rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].lastRowYear.toString() == 'null')
                                                                            ? ''
                                                                            : rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].lastRowYear.toString(),
                                                                        textAlign:
                                                                            TextAlign.left,
                                                                        style:
                                                                            const TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          //  fontWeight:
                                                                          //      FontWeight.bold,
                                                                          color:
                                                                              Colors.white,
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
                                                                      child:
                                                                          Text(
                                                                        "CYCLE: ",
                                                                        textAlign:
                                                                            TextAlign.left,
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .topLeft,
                                                                      child:
                                                                          Text(
                                                                        (rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].cycle == null ||
                                                                                rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].cycle.toString() == 'null')
                                                                            ? ''
                                                                            : rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].cycle.toString(),
                                                                        textAlign:
                                                                            TextAlign.left,
                                                                        style:
                                                                            const TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          //  fontWeight:
                                                                          //      FontWeight.bold,
                                                                          color:
                                                                              Colors.white,
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
                                                                      child:
                                                                          Text(
                                                                        "ROW METHOD: ",
                                                                        textAlign:
                                                                            TextAlign.left,
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .topLeft,
                                                                      child:
                                                                          Text(
                                                                        (rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].rowMethod == null ||
                                                                                rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].rowMethod.toString() == 'null')
                                                                            ? ''
                                                                            : rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].rowMethod.toString(),
                                                                        textAlign:
                                                                            TextAlign.left,
                                                                        style:
                                                                            const TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          //  fontWeight:
                                                                          //      FontWeight.bold,
                                                                          color:
                                                                              Colors.white,
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
                                                                      child:
                                                                          Text(
                                                                        "NEXT MAINT YEAR: ",
                                                                        textAlign:
                                                                            TextAlign.left,
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .topLeft,
                                                                      child:
                                                                          Text(
                                                                        (rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].nextMaintYear == null ||
                                                                                rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].nextMaintYear.toString() == 'null')
                                                                            ? ''
                                                                            : rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].nextMaintYear.toString(),
                                                                        textAlign:
                                                                            TextAlign.left,
                                                                        style:
                                                                            const TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          //  fontWeight:
                                                                          //      FontWeight.bold,
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),

                                                              // Expanded(
                                                              //   // alignment: Alignment.topLeft,
                                                              //   child: Column(
                                                              //     children: [
                                                              //       const Align(
                                                              //         alignment:
                                                              //             Alignment
                                                              //                 .topLeft,
                                                              //         child:
                                                              //             Text(
                                                              //           "COST PER MILE: ",
                                                              //           textAlign:
                                                              //               TextAlign.left,
                                                              //           style:
                                                              //               TextStyle(
                                                              //             fontSize:
                                                              //                 12,
                                                              //             fontWeight:
                                                              //                 FontWeight.bold,
                                                              //             color:
                                                              //                 Colors.white,
                                                              //           ),
                                                              //         ),
                                                              //       ),
                                                              //       Align(
                                                              //         alignment:
                                                              //             Alignment
                                                              //                 .topLeft,
                                                              //         child:
                                                              //             Text(
                                                              //           (rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].costPerMile == null ||
                                                              //                   rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].costPerMile.toString() == 'null')
                                                              //               ? ''
                                                              //               : rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].costPerMile.toString(),
                                                              //           textAlign:
                                                              //               TextAlign.left,
                                                              //           style:
                                                              //               const TextStyle(
                                                              //             fontSize:
                                                              //                 12,
                                                              //             //  fontWeight:
                                                              //             //      FontWeight.bold,
                                                              //             color:
                                                              //                 Colors.white,
                                                              //           ),
                                                              //         ),
                                                              //       ),
                                                              //     ],
                                                              //   ),
                                                              // ),

                                                              Expanded(
                                                                // alignment: Alignment.topLeft,
                                                                child: Column(
                                                                  children: [
                                                                    const Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .topLeft,
                                                                      child:
                                                                          Text(
                                                                        "TOTAL MILES:",
                                                                        textAlign:
                                                                            TextAlign.left,
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .topLeft,
                                                                      child:
                                                                          Text(
                                                                        (rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].totalMiles == null ||
                                                                                rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].totalMiles.toString() == 'null')
                                                                            ? ''
                                                                            : rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].totalMiles.toString(),
                                                                        textAlign:
                                                                            TextAlign.left,
                                                                        style:
                                                                            const TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          //  fontWeight:
                                                                          //      FontWeight.bold,
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              // Expanded(
                                                              //   // alignment: Alignment.topLeft,
                                                              //   child: Column(
                                                              //     children: [
                                                              //       const Align(
                                                              //         alignment:
                                                              //             Alignment
                                                              //                 .topLeft,
                                                              //         child:
                                                              //             Text(
                                                              //           "CREW: ",
                                                              //           textAlign:
                                                              //               TextAlign.left,
                                                              //           style:
                                                              //               TextStyle(
                                                              //             fontSize:
                                                              //                 12,
                                                              //             fontWeight:
                                                              //                 FontWeight.bold,
                                                              //             color:
                                                              //                 Colors.white,
                                                              //           ),
                                                              //         ),
                                                              //       ),
                                                              //       Align(
                                                              //         alignment:
                                                              //             Alignment
                                                              //                 .topLeft,
                                                              //         child:
                                                              //             Text(
                                                              //           (rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].crew == null ||
                                                              //                   rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].crew.toString() == 'null')
                                                              //               ? ''
                                                              //               : rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].crew.toString(),
                                                              //           textAlign:
                                                              //               TextAlign.left,
                                                              //           style:
                                                              //               const TextStyle(
                                                              //             fontSize:
                                                              //                 12,
                                                              //             //  fontWeight:
                                                              //             //      FontWeight.bold,
                                                              //             color:
                                                              //                 Colors.white,
                                                              //           ),
                                                              //         ),
                                                              //       ),
                                                              //     ],
                                                              //   ),
                                                              // ),
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
                                                                      child:
                                                                          Text(
                                                                        "MILES COMPLETED: ",
                                                                        textAlign:
                                                                            TextAlign.left,
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .topLeft,
                                                                      child:
                                                                          Text(
                                                                        (rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].milesCompleted == null ||
                                                                                rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].milesCompleted.toString() == 'null')
                                                                            ? ''
                                                                            : rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].milesCompleted.toString(),
                                                                        textAlign:
                                                                            TextAlign.left,
                                                                        style:
                                                                            const TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          //  fontWeight:
                                                                          //      FontWeight.bold,
                                                                          color:
                                                                              Colors.white,
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
                                                                      child:
                                                                          Text(
                                                                        "MILES IN-PROGRESS: ",
                                                                        textAlign:
                                                                            TextAlign.left,
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .topLeft,
                                                                      child:
                                                                          Text(
                                                                        (rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].milesInProgress == null ||
                                                                                rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].milesInProgress.toString() == 'null')
                                                                            ? ''
                                                                            : rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].milesInProgress.toString(),
                                                                        textAlign:
                                                                            TextAlign.left,
                                                                        style:
                                                                            const TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          //  fontWeight:
                                                                          //      FontWeight.bold,
                                                                          color:
                                                                              Colors.white,
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
                                                                      child:
                                                                          Text(
                                                                        "MILES PENDING: ",
                                                                        textAlign:
                                                                            TextAlign.left,
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .topLeft,
                                                                      child:
                                                                          Text(
                                                                        (rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].milesPending == null ||
                                                                                rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].milesPending.toString() == 'null')
                                                                            ? ''
                                                                            : rowMaintenanceProgressDasboardViewModel.rowMaintenanceProgressGetDataList.data!.rowMaintenanceData![index].milesPending.toString(),
                                                                        textAlign:
                                                                            TextAlign.left,
                                                                        style:
                                                                            const TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          //  fontWeight:
                                                                          //      FontWeight.bold,
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                      ),
                                                                    ),
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

  Future<void> _filterData(String query) async {
    if (query.isEmpty) {
      rowMaintenanceProgressDasboardViewModel
          .fetchRowMaintenanceProgressDashboardDataApi(context, '2023');
    } else {
      rowMaintenanceProgressDasboardViewModel
              .rowMaintenanceProgressGetDataList.data!.rowMaintenanceData =
          rowMaintenanceProgressDasboardViewModel
              .rowMaintenanceProgressGetDataList.data!.rowMaintenanceData
              ?.where((item) =>
                  item.subStationName.toString().toLowerCase().contains(query.toLowerCase()) ||
                  item.lastRowYear
                      .toString()
                      .toLowerCase()
                      .contains(query.toLowerCase()) ||
                  item.cycle
                      .toString()
                      .toLowerCase()
                      .contains(query.toLowerCase()) ||
                  item.costPerMile
                      .toString()
                      .toLowerCase()
                      .contains(query.toLowerCase()) ||
                  item.totalMiles
                      .toString()
                      .toLowerCase()
                      .contains(query.toLowerCase()) ||
                  item.crew
                      .toString()
                      .toLowerCase()
                      .contains(query.toLowerCase()) ||
                  item.milesCompleted
                      .toString()
                      .toLowerCase()
                      .contains(query.toLowerCase()) ||
                  item.milesInProgress.toString().toLowerCase().contains(query.toLowerCase()) ||
                  item.milesPending.toString().toLowerCase().contains(query.toLowerCase()) ||
                  item.wtdProgress.toString().toLowerCase().contains(query.toLowerCase()) ||
                  item.mtdProgress.toString().toLowerCase().contains(query.toLowerCase()) ||
                  item.ytdProgress.toString().toLowerCase().contains(query.toLowerCase()) ||
                  item.rowMethod.toString().toLowerCase().contains(query.toLowerCase()) ||
                  item.delayCause.toString().toLowerCase().contains(query.toLowerCase()) ||
                  item.delayReason.toString().toLowerCase().contains(query.toLowerCase()) ||
                  item.effectedNoOfDays.toString().toLowerCase().contains(query.toLowerCase()) ||
                  item.nextMaintYear.toString().toLowerCase().contains(query.toLowerCase()))
              .toList();
    }
    setState(() {});
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
      value: item,
      child: Text(item,
          style: const TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 20,
          )));

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
      RowMaintenanceProgressDashboardViewModel value) {
    chartDataSimpleColumnChart2.clear();

    for (var i = 0;
        i <
            rowMaintenanceProgressDasboardViewModel
                .rowMaintenanceProgressGetDataList
                .data!
                .affectedDaysByCausesList!
                .length;
        i++) {
      chartDataSimpleColumnChart2.add(_ChartDataSimpleColumnChart2(
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
      ));
    }
    return chartDataSimpleColumnChart2;
  }

  // List<Chart4ColumnStacked> recreateDataAffectedDaysByWeatherDelay(
  //     RowMaintenanceProgressDashboardViewModel value) {
  //   chart4ColumnStacked.clear();
  //   for (var i = 0;
  //       i <
  //           rowMaintenanceProgressDasboardViewModel
  //               .rowMaintenanceProgressGetDataList
  //               .data!
  //               .affectedDaysByWeatherDelayList!
  //               .length;
  //       i++) {
  //     chart4ColumnStacked.add(Chart4ColumnStacked(
  //       (rowMaintenanceProgressDasboardViewModel
  //                   .rowMaintenanceProgressGetDataList
  //                   .data!
  //                   .affectedDaysByWeatherDelayList![i]
  //                   .delayCause ==
  //               null)
  //           ? ''
  //           : rowMaintenanceProgressDasboardViewModel
  //               .rowMaintenanceProgressGetDataList
  //               .data!
  //               .affectedDaysByWeatherDelayList![i]
  //               .delayCause
  //               .toString(),
  //       (rowMaintenanceProgressDasboardViewModel
  //                   .rowMaintenanceProgressGetDataList
  //                   .data!
  //                   .affectedDaysByWeatherDelayList![i]
  //                   .effectedNoOfDays1 ==
  //               null)
  //           ? 0.0
  //           : double.parse(rowMaintenanceProgressDasboardViewModel
  //               .rowMaintenanceProgressGetDataList
  //               .data!
  //               .affectedDaysByWeatherDelayList![i]
  //               .effectedNoOfDays1
  //               .toString()),
  //       (rowMaintenanceProgressDasboardViewModel
  //                   .rowMaintenanceProgressGetDataList
  //                   .data!
  //                   .affectedDaysByWeatherDelayList![i]
  //                   .effectedNoOfDays2 ==
  //               null)
  //           ? 0.0
  //           : double.parse(rowMaintenanceProgressDasboardViewModel
  //               .rowMaintenanceProgressGetDataList
  //               .data!
  //               .affectedDaysByWeatherDelayList![i]
  //               .effectedNoOfDays2
  //               .toString()),
  //       (rowMaintenanceProgressDasboardViewModel
  //                   .rowMaintenanceProgressGetDataList
  //                   .data!
  //                   .affectedDaysByWeatherDelayList![i]
  //                   .effectedNoOfDays3 ==
  //               null)
  //           ? 0.0
  //           : double.parse(rowMaintenanceProgressDasboardViewModel
  //               .rowMaintenanceProgressGetDataList
  //               .data!
  //               .affectedDaysByWeatherDelayList![i]
  //               .effectedNoOfDays3
  //               .toString()),
  //       (rowMaintenanceProgressDasboardViewModel
  //                   .rowMaintenanceProgressGetDataList
  //                   .data!
  //                   .affectedDaysByWeatherDelayList![i]
  //                   .effectedNoOfDays4 ==
  //               null)
  //           ? 0.0
  //           : double.parse(rowMaintenanceProgressDasboardViewModel
  //               .rowMaintenanceProgressGetDataList
  //               .data!
  //               .affectedDaysByWeatherDelayList![i]
  //               .effectedNoOfDays4
  //               .toString()),
  //       (rowMaintenanceProgressDasboardViewModel
  //                   .rowMaintenanceProgressGetDataList
  //                   .data!
  //                   .affectedDaysByWeatherDelayList![i]
  //                   .effectedNoOfDays5 ==
  //               null)
  //           ? 0.0
  //           : double.parse(rowMaintenanceProgressDasboardViewModel
  //               .rowMaintenanceProgressGetDataList
  //               .data!
  //               .affectedDaysByWeatherDelayList![i]
  //               .effectedNoOfDays5
  //               .toString()),
  //     ));
  //   }
  //   return chart4ColumnStacked;
  // }
  List<Chart4ColumnStacked> recreateDataAffectedDaysByWeatherDelay(
      RowMaintenanceProgressDashboardViewModel value) {
    chart4ColumnStacked.clear();

    for (var i = 0;
        i <
            value.rowMaintenanceProgressGetDataList.data!
                .affectedDaysByWeatherDelayList!.length;
        i++) {
      chart4ColumnStacked.add(
        Chart4ColumnStacked(
          // X AXIS
          value.rowMaintenanceProgressGetDataList.data!
                  .affectedDaysByWeatherDelayList![i].delayCause ??
              '',

          // Y AXIS
          double.tryParse(
                value.rowMaintenanceProgressGetDataList.data!
                        .affectedDaysByWeatherDelayList![i].crew1
                        ?.toString() ??
                    '0',
              ) ??
              0.0,
        ),
      );
    }

    return chart4ColumnStacked;
  }

  List<Chart6HorizontalStacked> recreateAffectedDaysByOtherCause(
      RowMaintenanceProgressDashboardViewModel value) {
    chart6HorizontalStacked.clear();
    for (var i = 0;
        i <
            rowMaintenanceProgressDasboardViewModel
                .rowMaintenanceProgressGetDataList
                .data!
                .affectedDaysByOtherIssuesList!
                .length;
        i++) {
      chart6HorizontalStacked.add(Chart6HorizontalStacked(
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
            : double.parse(rowMaintenanceProgressDasboardViewModel
                .rowMaintenanceProgressGetDataList
                .data!
                .affectedDaysByOtherIssuesList![i]
                .effectedNoOfDays1
                .toString()),
        (rowMaintenanceProgressDasboardViewModel
                    .rowMaintenanceProgressGetDataList
                    .data!
                    .affectedDaysByOtherIssuesList![i]
                    .effectedNoOfDays2 ==
                null)
            ? 0.0
            : double.parse(rowMaintenanceProgressDasboardViewModel
                .rowMaintenanceProgressGetDataList
                .data!
                .affectedDaysByOtherIssuesList![i]
                .effectedNoOfDays2
                .toString()),
        (rowMaintenanceProgressDasboardViewModel
                    .rowMaintenanceProgressGetDataList
                    .data!
                    .affectedDaysByOtherIssuesList![i]
                    .effectedNoOfDays3 ==
                null)
            ? 0.0
            : double.parse(rowMaintenanceProgressDasboardViewModel
                .rowMaintenanceProgressGetDataList
                .data!
                .affectedDaysByOtherIssuesList![i]
                .effectedNoOfDays3
                .toString()),
        (rowMaintenanceProgressDasboardViewModel
                    .rowMaintenanceProgressGetDataList
                    .data!
                    .affectedDaysByOtherIssuesList![i]
                    .effectedNoOfDays4 ==
                null)
            ? 0.0
            : double.parse(rowMaintenanceProgressDasboardViewModel
                .rowMaintenanceProgressGetDataList
                .data!
                .affectedDaysByOtherIssuesList![i]
                .effectedNoOfDays4
                .toString()),
        (rowMaintenanceProgressDasboardViewModel
                    .rowMaintenanceProgressGetDataList
                    .data!
                    .affectedDaysByOtherIssuesList![i]
                    .effectedNoOfDays5 ==
                null)
            ? 0.0
            : double.parse(rowMaintenanceProgressDasboardViewModel
                .rowMaintenanceProgressGetDataList
                .data!
                .affectedDaysByOtherIssuesList![i]
                .effectedNoOfDays5
                .toString()),
      ));
    }
    return chart6HorizontalStacked;
  }

  List<Chart9ColumnStacked>
      recreateDataYearlyPerformanceMatricsByMaintenanceType(
          RowMaintenanceProgressDashboardViewModel value, String type) {
    List<Chart9ColumnStacked> chart9ColumnStacked = [];

    for (var i = 0;
        i <
            value.rowMaintenanceProgressGetDataList.data!
                .getSPAGGMILESFORDISTINCTTYPE!.length;
        i++) {
      var data = value.rowMaintenanceProgressGetDataList.data!
          .getSPAGGMILESFORDISTINCTTYPE![i];

      if (data.type == type) {
        chart9ColumnStacked.add(Chart9ColumnStacked(
            data.year.toString(),
            data.aggMiles ?? 0.0,
            data.percentage.toString(),
            data.type.toString()));
        print(
            'dataaaa ${data.year.toString()}/${data.aggMiles ?? 0}/${data.percentage.toString()}/${data.type.toString()}');
      }
    }

    return chart9ColumnStacked;
  }

  List<Chart10ColumnStacked>
      recreateDataMonthlyPerformanceMatricsByMaintenanceType(
          RowMaintenanceProgressDashboardViewModel value, String type) {
    List<Chart10ColumnStacked> chart10ColumnStacked = [];

    for (var i = 0;
        i <
            value.rowMaintenanceProgressGetDataList.data!
                .getSPAGGMILESFORDISTINCTTYPEBYMNTH!.length;
        i++) {
      var data = value.rowMaintenanceProgressGetDataList.data!
          .getSPAGGMILESFORDISTINCTTYPEBYMNTH![i];

      if (data.type == type) {
        chart10ColumnStacked.add(Chart10ColumnStacked(
          data.monthName.toString(),
          data.aggMiles ?? 0.0,
        ));
      }
    }

    return chart10ColumnStacked;
  }

  List<String?> getTypeMonthlyListList(
      RowMaintenanceProgressDashboardViewModel value) {
    return value.rowMaintenanceProgressGetDataList.data!
        .getSPAGGMILESFORDISTINCTTYPEBYMNTH!
        .map((data) => data.type)
        .toSet()
        .toList();
  }

  List<String?> getTypeYearlyListList(
      RowMaintenanceProgressDashboardViewModel value) {
    return value
        .rowMaintenanceProgressGetDataList.data!.getSPAGGMILESFORDISTINCTTYPE!
        .map((data) => data.type)
        .toSet()
        .toList();
  }

  List<Chart11ColumnStacked> recreateDataYearlyPerformanceMatrics(
      RowMaintenanceProgressDashboardViewModel value) {
    List<Chart11ColumnStacked> chartData = [];
    Map<int, Chart11ColumnStacked> yearWiseData = {};
    Map<int, int> yearWiseCount = {};

    for (var i = 0;
        i <
            value
                .rowMaintenanceProgressGetDataList
                .data!
                .findUNDERPERFORMANCEAndINLINEPERFORMANCEOVERPERFORMANCE!
                .length;
        i++) {
      var data = value.rowMaintenanceProgressGetDataList.data!
          .findUNDERPERFORMANCEAndINLINEPERFORMANCEOVERPERFORMANCE![i];

      int year = data.lastRowYear ?? 0;

      if (!yearWiseData.containsKey(year)) {
        yearWiseData[year] =
            Chart11ColumnStacked(year.toString(), 0.0, 0.0, 0.0);
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
      RowMaintenanceProgressDashboardViewModel value) {
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

      dataSimpleColumnChart1.add(_ChartDataSimpleColumnChart1(
          (crew?.isEmpty ?? true) ? '' : crew.toString(),
          (milesCompleted == null || milesCompleted.toString() == 'null')
              ? 0
              : double.parse(milesCompleted.toString()),
          (milesInProgress == null || milesInProgress.toString() == 'null')
              ? 0
              : double.parse(milesInProgress.toString())));
    }

    return dataSimpleColumnChart1;
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
      this.x, this.y, this.y1, this.y2, this.y3, this.y4);

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

// class Chart4ColumnStacked {
//   final String x;
//   final double y1;
//   final double y2;
//   final double y3;
//   final double y4;
//   final double y5;
//   Chart4ColumnStacked(this.x, this.y1, this.y2, this.y3, this.y4, this.y5);
// }
class Chart4ColumnStacked {
  final String x;
  final double y;

  Chart4ColumnStacked(this.x, this.y);
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
  Chart10ColumnStacked(
    this.x,
    this.y1,
  );
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
