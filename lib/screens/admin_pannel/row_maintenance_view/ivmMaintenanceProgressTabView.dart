// import 'package:flutter/material.dart';
// import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
// import 'package:multi_select_flutter/util/multi_select_item.dart';
// import 'package:multi_select_flutter/util/multi_select_list_type.dart';
// import 'package:pie_chart/pie_chart.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';
// import '../../../data/response/status.dart';
// import '../../../view_model/row_maintenance_progress_tab_view_model.dart';
// import 'package:pie_chart/pie_chart.dart' as pie_chart;

// class IVMMaintenanceProgressTabView extends StatefulWidget {
//   const IVMMaintenanceProgressTabView({Key? key}) : super(key: key);

//   @override
//   State<IVMMaintenanceProgressTabView> createState() =>
//       _IVMMaintenanceProgressTabViewState();
// }

// class _IVMMaintenanceProgressTabViewState
//     extends State<IVMMaintenanceProgressTabView> {
//   Future? myFuture;
// // ignore: non_constant_identifier_names
//   final List<String> rate_class = [];
//   String? rate;
//   String? rateID = '0';

//   String? year;
//   String? cycle;
//   String? substation;
//   String? feeder;
//   String? crew;
// // ignore: non_constant_identifier_names
//   final List<String> select_month = ['5', '6', '7'];
//   String? month;

//   List<_ChartDataSimpleColumnChart1> dataSimpleColumnChart1 = [];

//   // ignore: non_constant_identifier_names
//   final List<String> select_week = ['5', '6', '7'];
//   String? week;

//   DateTime date = DateTime.now();
//   DateTime date12 = DateTime.now();
//   Future<void> selectDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//         context: context,
//         initialDate: date,
//         firstDate: DateTime(2010),
//         lastDate: DateTime(2050));
//     if (picked != null && picked != date) {
//       setState(() {
//         date = picked;
//         // print(date.toString());
//       });
//     }
//   }

//   Future<void> selectDate12(BuildContext context) async {
//     final DateTime? picked12 = await showDatePicker(
//         context: context,
//         initialDate: date12,
//         firstDate: DateTime(2010),
//         lastDate: DateTime(2050));
//     if (picked12 != null && picked12 != date12) {
//       setState(() {
//         date12 = picked12;
//         // print(date12.toString());
//       });
//     }
//   }

//   RowMaintenanceProgressTabViewModel rowMaintenanceProgressTabViewModel =
//       RowMaintenanceProgressTabViewModel();

//   var state;

//   late TooltipBehavior _tooltipBehavior6;
//   final gradientList = <List<Color>>[
//     [
//       const Color.fromARGB(255, 1, 158, 1),
//       const Color.fromARGB(255, 1, 158, 1),
//     ],
//     [
//       const Color.fromARGB(255, 255, 123, 0),
//       const Color.fromARGB(255, 255, 123, 0),
//     ],
//     [
//       const Color.fromARGB(255, 245, 18, 2),
//       const Color.fromARGB(255, 245, 18, 2),
//     ],
//   ];

//   double progressTotal = 0.0;
//   double pendingTotal = 0.0;
//   double completedTotal = 0.0;
//   double totalMiles = 0.0;

//   Map<String, double> dataMap = {};

//   @override
//   void initState() {
//     rowMaintenanceProgressTabViewModel.fetchRowMaintenanceProgressTabListApi(
//         context, '', '', '', '', '');
//     _tooltipBehavior6 =
//         TooltipBehavior(enable: true, tooltipPosition: TooltipPosition.pointer);
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return FutureBuilder(
//         future: myFuture,
//         builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
//           // if (snapshot.connectionState == ConnectionState.done) {
//           return GestureDetector(
//               onTap: () {
//                 FocusScopeNode currentFocus = FocusScope.of(context);
//                 if (!currentFocus.hasPrimaryFocus) {
//                   currentFocus.unfocus();
//                 }
//               },
//               child: Scaffold(
//                   backgroundColor: Colors.white,
//                   body:
//                       ChangeNotifierProvider<
//                               RowMaintenanceProgressTabViewModel>(
//                           create: (BuildContext context) =>
//                               rowMaintenanceProgressTabViewModel,
//                           child: Consumer<RowMaintenanceProgressTabViewModel>(
//                               builder: (context, value, _) {
//                             switch (
//                                 value.rowMaintenanceProgressTabList.status) {
//                               case Status.LOADING:
//                                 return const Center(
//                                     child: CircularProgressIndicator());
//                               case Status.ERROR:
//                                 return
//                                     // CustomToastSnackBarProgressDialog
//                                     //     .flushBarErrorMessage(
//                                     //         value.rowMaintenanceProgressTabList.message
//                                     //             .toString(),
//                                     //         context);
//                                     Padding(
//                                   padding: const EdgeInsets.only(
//                                       top: 16.0, bottom: 16, left: 8, right: 8),
//                                   child: Center(
//                                     child: Align(
//                                       alignment: Alignment.topCenter,
//                                       child: Column(
//                                         children: [
//                                           Image.asset(
//                                             'assets/empty_box.png',
//                                             height: 200,
//                                             width: 200,
//                                             fit: BoxFit.cover,
//                                           ),
//                                           const Center(
//                                             child: Text(
//                                               'Sorry, Data Not Found!',
//                                               textAlign: TextAlign.left,
//                                               style: TextStyle(
//                                                 color: Color.fromARGB(
//                                                     255, 7, 59, 120),
//                                                 fontWeight: FontWeight.bold,
//                                                 fontSize: 20,
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 );
//                               case Status.COMPLETED:
//                                 createPieChartValues();
//                                 return RefreshIndicator(
//                                   onRefresh: () async {
//                                     await rowMaintenanceProgressTabViewModel
//                                         .fetchRowMaintenanceProgressTabListApi(
//                                             context, '', '', '', '', '');
//                                   },
//                                   child: SingleChildScrollView(
//                                     child: Column(
//                                       children: [
//                                         Padding(
//                                           padding: const EdgeInsets.all(8.0),
//                                           child: InkWell(
//                                             onTap: () {
//                                               openFilter();
//                                             },
//                                             child: Container(
//                                               padding: const EdgeInsets.all(10),
//                                               // width: size.width * 0.5,
//                                               decoration: const BoxDecoration(
//                                                   // shape: BoxShape.circle,
//                                                   // borderRadius:
//                                                   //     BorderRadius.circular(25),
//                                                   borderRadius:
//                                                       BorderRadius.only(
//                                                           topRight:
//                                                               Radius.circular(
//                                                                   25),
//                                                           bottomLeft:
//                                                               Radius.circular(
//                                                                   25),
//                                                           topLeft:
//                                                               Radius.circular(
//                                                                   25),
//                                                           bottomRight:
//                                                               Radius.circular(
//                                                                   25)),
//                                                   boxShadow: [
//                                                     BoxShadow(
//                                                         color: Color.fromARGB(
//                                                             255, 3, 47, 97),
//                                                         blurRadius: 5,
//                                                         offset:
//                                                             Offset(2.0, 5.0))
//                                                   ],
//                                                   color: Color.fromARGB(
//                                                       255, 130, 193, 245),
//                                                   gradient: LinearGradient(
//                                                     colors: [
//                                                       Color.fromARGB(
//                                                           255, 7, 59, 120),
//                                                       Color.fromARGB(
//                                                           255, 7, 59, 120)
//                                                     ],
//                                                   )),
//                                               child: const Align(
//                                                 alignment: Alignment.center,
//                                                 child: Text(
//                                                   "SELECT FILTER",
//                                                   textAlign: TextAlign.left,
//                                                   style: TextStyle(
//                                                     color: Colors.white,
//                                                     fontWeight: FontWeight.bold,
//                                                     fontSize: 20,
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                         Container(
//                                           margin: const EdgeInsets.only(
//                                               top: 10,
//                                               bottom: 10,
//                                               left: 8,
//                                               right: 8),
//                                           padding: const EdgeInsets.all(8),
//                                           alignment: Alignment.center,
//                                           // height: size.height * 0.2,
//                                           width: size.width * 0.99,
//                                           decoration: BoxDecoration(
//                                               // shape: BoxShape.circle,
//                                               borderRadius:
//                                                   BorderRadius.circular(10),
//                                               boxShadow: const [
//                                                 BoxShadow(
//                                                     color: Color.fromARGB(
//                                                         255, 3, 47, 97),
//                                                     blurRadius: 10,
//                                                     offset: Offset(2.0, 5.0))
//                                               ],
//                                               gradient: const LinearGradient(
//                                                 colors: [
//                                                   Color.fromARGB(
//                                                       255, 255, 255, 255),
//                                                   Color.fromARGB(
//                                                       255, 255, 255, 255),
//                                                 ],
//                                               )),
//                                           child: Column(
//                                             children: [
//                                               // Container(
//                                               //   padding: const EdgeInsets.all(10),
//                                               //   alignment: Alignment.center,
//                                               //   width: size.width * 0.99,
//                                               //   // width: MediaQuery.of(context).size.width,
//                                               //   // height: 40,
//                                               //   decoration: const BoxDecoration(
//                                               //       // shape: BoxShape.circle,
//                                               //       //borderRadius: BorderRadius.circular(25),
//                                               //       boxShadow: [
//                                               //         BoxShadow(
//                                               //             color: Color.fromARGB(
//                                               //                 255, 3, 47, 97),
//                                               //             blurRadius: 5,
//                                               //             offset: Offset(2.0, 5.0))
//                                               //       ],
//                                               //       color: Color.fromARGB(
//                                               //           255, 130, 193, 245),
//                                               //       gradient: LinearGradient(
//                                               //         colors: [
//                                               //           Color.fromARGB(
//                                               //               255, 7, 59, 120),
//                                               //           Color.fromARGB(
//                                               //               255, 7, 59, 120)
//                                               //         ],
//                                               //       )),
//                                               //   child: const Row(children: [
//                                               //     Align(
//                                               //       alignment: Alignment.centerLeft,
//                                               //       child: Text(
//                                               //         "Pie Chart",
//                                               //         textAlign: TextAlign.left,
//                                               //         style: TextStyle(
//                                               //           color: Colors.white,
//                                               //           fontWeight: FontWeight.bold,
//                                               //           fontSize: 20,
//                                               //         ),
//                                               //       ),
//                                               //     ),
//                                               //   ]),
//                                               // ),

//                                               Padding(
//                                                 padding:
//                                                     const EdgeInsets.all(8.0),
//                                                 child: Column(
//                                                   children: [
//                                                     Padding(
//                                                       padding:
//                                                           const EdgeInsets.only(
//                                                               top: 8.0),
//                                                       child: Row(
//                                                         children: [
//                                                           Expanded(
//                                                             child: Column(
//                                                               children: [
//                                                                 Text(
//                                                                   (rowMaintenanceProgressTabViewModel
//                                                                               .rowMaintenanceProgressTabList
//                                                                               .data!
//                                                                               .completeProgressAndPending![
//                                                                                   0]
//                                                                               .progress ==
//                                                                           null)
//                                                                       ? '0.0'
//                                                                       : rowMaintenanceProgressTabViewModel
//                                                                           .rowMaintenanceProgressTabList
//                                                                           .data!
//                                                                           .completeProgressAndPending![
//                                                                               0]
//                                                                           .progress
//                                                                           .toString(),
//                                                                   style:
//                                                                       const TextStyle(
//                                                                     color: Colors
//                                                                         .black,
//                                                                     fontWeight:
//                                                                         FontWeight
//                                                                             .bold,
//                                                                     fontSize:
//                                                                         16,
//                                                                   ),
//                                                                 ),
//                                                                 const Text(
//                                                                   'IN PROGRESS',
//                                                                   style:
//                                                                       TextStyle(
//                                                                     color: Colors
//                                                                         .red,
//                                                                     fontWeight:
//                                                                         FontWeight
//                                                                             .bold,
//                                                                     fontSize:
//                                                                         14,
//                                                                   ),
//                                                                 ),
//                                                               ],
//                                                             ),
//                                                           ),
//                                                           Expanded(
//                                                             child: Column(
//                                                               children: [
//                                                                 Text(
//                                                                   (rowMaintenanceProgressTabViewModel
//                                                                               .rowMaintenanceProgressTabList
//                                                                               .data!
//                                                                               .completeProgressAndPending![0]
//                                                                               .completed ==
//                                                                           null)
//                                                                       ? '0.0'
//                                                                       : ' ${rowMaintenanceProgressTabViewModel.rowMaintenanceProgressTabList.data!.completeProgressAndPending![0].completed.toString()}',
//                                                                   style:
//                                                                       const TextStyle(
//                                                                     color: Colors
//                                                                         .black,
//                                                                     fontWeight:
//                                                                         FontWeight
//                                                                             .bold,
//                                                                     fontSize:
//                                                                         16,
//                                                                   ),
//                                                                 ),
//                                                                 const Text(
//                                                                   'COMPLETED',
//                                                                   style:
//                                                                       TextStyle(
//                                                                     color: Colors
//                                                                         .red,
//                                                                     fontWeight:
//                                                                         FontWeight
//                                                                             .bold,
//                                                                     fontSize:
//                                                                         14,
//                                                                   ),
//                                                                 ),
//                                                               ],
//                                                             ),
//                                                           ),
//                                                           Expanded(
//                                                             child: Column(
//                                                               children: [
//                                                                 Text(
//                                                                   (rowMaintenanceProgressTabViewModel
//                                                                               .rowMaintenanceProgressTabList
//                                                                               .data!
//                                                                               .completeProgressAndPending![
//                                                                                   0]
//                                                                               .pending ==
//                                                                           null)
//                                                                       ? '0.0'
//                                                                       : (rowMaintenanceProgressTabViewModel.rowMaintenanceProgressTabList.data!.completeProgressAndPending![0].pending == 0.0 &&
//                                                                               rowMaintenanceProgressTabViewModel.rowMaintenanceProgressTabList.data!.completeProgressAndPending![0].progress ==
//                                                                                   0.0 &&
//                                                                               rowMaintenanceProgressTabViewModel.rowMaintenanceProgressTabList.data!.completeProgressAndPending![0].completed ==
//                                                                                   0.0)
//                                                                           ? rowMaintenanceProgressTabViewModel
//                                                                               .rowMaintenanceProgressTabList
//                                                                               .data!
//                                                                               .completeProgressAndPending![0]
//                                                                               .totalMiles
//                                                                               .toString()
//                                                                           : ' ${rowMaintenanceProgressTabViewModel.rowMaintenanceProgressTabList.data!.completeProgressAndPending![0].pending.toString()}',
//                                                                   style:
//                                                                       const TextStyle(
//                                                                     color: Colors
//                                                                         .black,
//                                                                     fontWeight:
//                                                                         FontWeight
//                                                                             .bold,
//                                                                     fontSize:
//                                                                         16,
//                                                                   ),
//                                                                 ),
//                                                                 const Text(
//                                                                   'PENDING',
//                                                                   style:
//                                                                       TextStyle(
//                                                                     color: Colors
//                                                                         .red,
//                                                                     fontWeight:
//                                                                         FontWeight
//                                                                             .bold,
//                                                                     fontSize:
//                                                                         14,
//                                                                   ),
//                                                                 ),
//                                                               ],
//                                                             ),
//                                                           ),
//                                                         ],
//                                                       ),
//                                                     ),
//                                                     Padding(
//                                                       padding:
//                                                           const EdgeInsets.only(
//                                                               top: 18.0,
//                                                               bottom: 18),
//                                                       child: PieChart(
//                                                         dataMap: dataMap,
//                                                         animationDuration:
//                                                             const Duration(
//                                                                 milliseconds:
//                                                                     800),
//                                                         chartLegendSpacing: 32,
//                                                         chartRadius:
//                                                             MediaQuery.of(
//                                                                         context)
//                                                                     .size
//                                                                     .width /
//                                                                 2,
//                                                         // colorList: colorList,
//                                                         initialAngleInDegree: 0,
//                                                         chartType:
//                                                             ChartType.disc,
//                                                         ringStrokeWidth: 32,
//                                                         // centerText: "HYBRID",
//                                                         legendOptions:
//                                                             const LegendOptions(
//                                                           showLegendsInRow:
//                                                               false,
//                                                           // legendPosition: LegendPosition.right,
//                                                           showLegends: true,
//                                                           legendPosition:
//                                                               pie_chart
//                                                                   .LegendPosition
//                                                                   .bottom,
//                                                           legendTextStyle:
//                                                               TextStyle(
//                                                             fontWeight:
//                                                                 FontWeight.bold,
//                                                           ),
//                                                         ),
//                                                         chartValuesOptions:
//                                                             const ChartValuesOptions(
//                                                           showChartValueBackground:
//                                                               false,
//                                                           showChartValues: true,
//                                                           showChartValuesInPercentage:
//                                                               true,
//                                                           showChartValuesOutside:
//                                                               true,
//                                                           decimalPlaces: 1,
//                                                         ),
//                                                         gradientList:
//                                                             gradientList,
//                                                         // emptyColorGradient: ---Empty Color gradient---
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               )
//                                             ],
//                                           ),
//                                         ),
//                                         Container(
//                                           margin: const EdgeInsets.only(
//                                               top: 10,
//                                               bottom: 10,
//                                               left: 8,
//                                               right: 8),
//                                           padding: const EdgeInsets.all(8),
//                                           alignment: Alignment.center,
//                                           // height: size.height * 0.55,
//                                           width: size.width * 0.99,
//                                           decoration: BoxDecoration(
//                                               // shape: BoxShape.circle,
//                                               borderRadius:
//                                                   BorderRadius.circular(10),
//                                               boxShadow: const [
//                                                 BoxShadow(
//                                                     color: Color.fromARGB(
//                                                         255, 3, 47, 97),
//                                                     blurRadius: 10,
//                                                     offset: Offset(2.0, 5.0))
//                                               ],
//                                               gradient: const LinearGradient(
//                                                 colors: [
//                                                   Color.fromARGB(
//                                                       255, 255, 255, 255),
//                                                   Color.fromARGB(
//                                                       255, 255, 255, 255),
//                                                 ],
//                                               )),
//                                           child: Column(
//                                             children: [
//                                               // Container(
//                                               //   padding: const EdgeInsets.all(10),
//                                               //   alignment: Alignment.center,
//                                               //   width: size.width * 0.99,
//                                               //   // width: MediaQuery.of(context).size.width,
//                                               //   // height: 40,
//                                               //   decoration: const BoxDecoration(
//                                               //       // shape: BoxShape.circle,
//                                               //       //borderRadius: BorderRadius.circular(25),
//                                               //       boxShadow: [
//                                               //         BoxShadow(
//                                               //             color: Color.fromARGB(
//                                               //                 255, 3, 47, 97),
//                                               //             blurRadius: 5,
//                                               //             offset: Offset(2.0, 5.0))
//                                               //       ],
//                                               //       color: Color.fromARGB(
//                                               //           255, 130, 193, 245),
//                                               //       gradient: LinearGradient(
//                                               //         colors: [
//                                               //           Color.fromARGB(
//                                               //               255, 7, 59, 120),
//                                               //           Color.fromARGB(
//                                               //               255, 7, 59, 120)
//                                               //         ],
//                                               //       )),
//                                               //   child: const Align(
//                                               //     alignment: Alignment.centerLeft,
//                                               //     child: Text(
//                                               //       "Bar Chart",
//                                               //       textAlign: TextAlign.left,
//                                               //       style: TextStyle(
//                                               //         color: Colors.white,
//                                               //         fontWeight: FontWeight.bold,
//                                               //         fontSize: 20,
//                                               //       ),
//                                               //     ),
//                                               //   ),
//                                               // ),

//                                               Column(
//                                                 children: [
//                                                   Padding(
//                                                     padding:
//                                                         const EdgeInsets.only(
//                                                             top: 20.0),
//                                                     child: Row(
//                                                       children: [
//                                                         Padding(
//                                                           padding:
//                                                               const EdgeInsets
//                                                                   .only(
//                                                                   left: 8.0,
//                                                                   top: 8),
//                                                           child: Container(
//                                                             width: 15,
//                                                             height: 200,
//                                                             color: Colors.white,
//                                                             child: const Center(
//                                                               child: Text(
//                                                                 "VALUE (IN MILES)",
//                                                                 textAlign:
//                                                                     TextAlign
//                                                                         .left,
//                                                                 style:
//                                                                     TextStyle(
//                                                                   color: Colors
//                                                                       .red,
//                                                                   fontWeight:
//                                                                       FontWeight
//                                                                           .w900,
//                                                                   fontSize: 14,
//                                                                 ),
//                                                               ),
//                                                             ),
//                                                           ),
//                                                         ),
//                                                         Expanded(
//                                                           child:
//                                                               SfCartesianChart(
//                                                             tooltipBehavior:
//                                                                 _tooltipBehavior6,
//                                                             primaryXAxis:
//                                                                 CategoryAxis(
//                                                               majorGridLines:
//                                                                   const MajorGridLines(
//                                                                       width: 0),
//                                                             ),
//                                                             primaryYAxis:
//                                                                 NumericAxis(
//                                                                     axisLine:
//                                                                         const AxisLine(
//                                                                             width:
//                                                                                 0),
//                                                                     labelFormat:
//                                                                         '{value}',
//                                                                     // maximum: 2000,
//                                                                     majorTickLines:
//                                                                         const MajorTickLines(
//                                                                             size:
//                                                                                 0)),
//                                                             // legend: Legend(isVisible: true),
//                                                             series: <CartesianSeries>[
//                                                               ColumnSeries<
//                                                                       _ChartDataSimpleColumnChart1,
//                                                                       String>(
//                                                                   name: '',
//                                                                   dataSource:
//                                                                       recreateDataStatus(
//                                                                           value),
//                                                                   xValueMapper: (_ChartDataSimpleColumnChart1 data,
//                                                                           _) =>
//                                                                       data.x,
//                                                                   yValueMapper: (_ChartDataSimpleColumnChart1 data,
//                                                                           _) =>
//                                                                       data.y1,
//                                                                   pointColorMapper:
//                                                                       (_ChartDataSimpleColumnChart1 data, _) =>
//                                                                           data
//                                                                               .color,
//                                                                   enableTooltip:
//                                                                       true,
//                                                                   markerSettings: const MarkerSettings(
//                                                                       isVisible:
//                                                                           true,
//                                                                       shape: DataMarkerType
//                                                                           .diamond),
//                                                                   dataLabelSettings:
//                                                                       const DataLabelSettings(
//                                                                           isVisible:
//                                                                               true)),
//                                                             ],
//                                                           ),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                   const Text(
//                                                     "CREW",
//                                                     // textAlign: TextAlign.left,
//                                                     style: TextStyle(
//                                                       color: Colors.red,
//                                                       fontWeight:
//                                                           FontWeight.w900,
//                                                       fontSize: 14,
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                         Container(
//                                           margin: const EdgeInsets.only(
//                                               top: 10,
//                                               bottom: 10,
//                                               left: 8,
//                                               right: 8),
//                                           padding: const EdgeInsets.all(8),
//                                           alignment: Alignment.center,
//                                           height: size.height * 0.5,
//                                           width: size.width * 0.99,
//                                           decoration: BoxDecoration(
//                                               // shape: BoxShape.circle,
//                                               borderRadius:
//                                                   BorderRadius.circular(10),
//                                               boxShadow: const [
//                                                 BoxShadow(
//                                                     color: Color.fromARGB(
//                                                         255, 3, 47, 97),
//                                                     blurRadius: 10,
//                                                     offset: Offset(2.0, 5.0))
//                                               ],
//                                               gradient: const LinearGradient(
//                                                 colors: [
//                                                   Color.fromARGB(
//                                                       255, 255, 255, 255),
//                                                   Color.fromARGB(
//                                                       255, 255, 255, 255),
//                                                 ],
//                                               )),
//                                           child: SingleChildScrollView(
//                                             child: Column(
//                                               children: [
//                                                 Padding(
//                                                     padding:
//                                                         const EdgeInsets.only(
//                                                             bottom: 10, top: 4),
//                                                     child: ListView.builder(
//                                                       shrinkWrap: true,
//                                                       physics:
//                                                           const NeverScrollableScrollPhysics(),
//                                                       itemCount: rowMaintenanceProgressTabViewModel
//                                                           .rowMaintenanceProgressTabList
//                                                           .data!
//                                                           .rowMAINTENANCEPROGRESSData!
//                                                           .length,
//                                                       itemBuilder:
//                                                           (context, index) {
//                                                         return Container(
//                                                           margin:
//                                                               const EdgeInsets
//                                                                   .only(
//                                                                   left: 20,
//                                                                   right: 20,
//                                                                   top: 10,
//                                                                   bottom: 10),
//                                                           padding:
//                                                               const EdgeInsets
//                                                                   .all(8),
//                                                           alignment:
//                                                               Alignment.center,
//                                                           // height: size.height * 0.2,
//                                                           width:
//                                                               size.width - 40,
//                                                           decoration:
//                                                               BoxDecoration(
//                                                                   // shape: BoxShape.circle,
//                                                                   borderRadius:
//                                                                       BorderRadius
//                                                                           .circular(
//                                                                               10),
//                                                                   boxShadow: const [
//                                                                     BoxShadow(
//                                                                         color: Color.fromARGB(
//                                                                             255,
//                                                                             3,
//                                                                             47,
//                                                                             97),
//                                                                         blurRadius:
//                                                                             10,
//                                                                         offset: Offset(
//                                                                             2.0,
//                                                                             5.0))
//                                                                   ],
//                                                                   gradient:
//                                                                       const LinearGradient(
//                                                                     colors: [
//                                                                       Color.fromARGB(
//                                                                           255,
//                                                                           255,
//                                                                           255,
//                                                                           255),
//                                                                       Color.fromARGB(
//                                                                           255,
//                                                                           255,
//                                                                           255,
//                                                                           255),
//                                                                       Color.fromARGB(
//                                                                           255,
//                                                                           115,
//                                                                           174,
//                                                                           242),
//                                                                       // Color.fromARGB(255, 3, 224, 10),
//                                                                     ],
//                                                                   )),
//                                                           child: Column(
//                                                             children: [
//                                                               Align(
//                                                                 alignment: Alignment
//                                                                     .centerLeft,
//                                                                 child:
//                                                                     Container(
//                                                                   padding:
//                                                                       const EdgeInsets
//                                                                           .all(
//                                                                           10),
//                                                                   // width: size.width * 0.5,
//                                                                   decoration: const BoxDecoration(
//                                                                       // shape: BoxShape.circle,
//                                                                       // borderRadius:
//                                                                       //     BorderRadius.circular(25),
//                                                                       borderRadius: BorderRadius.only(topRight: Radius.circular(25), bottomLeft: Radius.circular(25)),
//                                                                       boxShadow: [
//                                                                         BoxShadow(
//                                                                             color: Color.fromARGB(
//                                                                                 255,
//                                                                                 3,
//                                                                                 47,
//                                                                                 97),
//                                                                             blurRadius:
//                                                                                 5,
//                                                                             offset:
//                                                                                 Offset(2.0, 5.0))
//                                                                       ],
//                                                                       color: Color.fromARGB(255, 130, 193, 245),
//                                                                       gradient: LinearGradient(
//                                                                         colors: [
//                                                                           Color.fromARGB(
//                                                                               255,
//                                                                               7,
//                                                                               59,
//                                                                               120),
//                                                                           Color.fromARGB(
//                                                                               255,
//                                                                               7,
//                                                                               59,
//                                                                               120)
//                                                                         ],
//                                                                       )),
//                                                                   child: Row(
//                                                                       children: [
//                                                                         const Align(
//                                                                           alignment:
//                                                                               Alignment.centerLeft,
//                                                                           child:
//                                                                               Text(
//                                                                             "CREW: ",
//                                                                             textAlign:
//                                                                                 TextAlign.left,
//                                                                             style:
//                                                                                 TextStyle(
//                                                                               color: Colors.white,
//                                                                               fontWeight: FontWeight.bold,
//                                                                               fontSize: 20,
//                                                                             ),
//                                                                           ),
//                                                                         ),
//                                                                         Expanded(
//                                                                           child:
//                                                                               Align(
//                                                                             alignment:
//                                                                                 Alignment.centerLeft,
//                                                                             child:
//                                                                                 Text(
//                                                                               (rowMaintenanceProgressTabViewModel.rowMaintenanceProgressTabList.data!.rowMAINTENANCEPROGRESSData![index].crew == null || rowMaintenanceProgressTabViewModel.rowMaintenanceProgressTabList.data!.rowMAINTENANCEPROGRESSData![index].crew.toString() == 'null') ? '' : rowMaintenanceProgressTabViewModel.rowMaintenanceProgressTabList.data!.rowMAINTENANCEPROGRESSData![index].crew.toString(),
//                                                                               textAlign: TextAlign.left,
//                                                                               style: const TextStyle(
//                                                                                 color: Colors.white,
//                                                                                 fontWeight: FontWeight.bold,
//                                                                                 fontSize: 20,
//                                                                               ),
//                                                                             ),
//                                                                           ),
//                                                                         ),
//                                                                         // SizedBox(width: 10),
//                                                                         Align(
//                                                                           alignment:
//                                                                               Alignment.centerLeft,
//                                                                           child:
//                                                                               Text(
//                                                                             (rowMaintenanceProgressTabViewModel.rowMaintenanceProgressTabList.data!.rowMAINTENANCEPROGRESSData![index].tokenNo == null || rowMaintenanceProgressTabViewModel.rowMaintenanceProgressTabList.data!.rowMAINTENANCEPROGRESSData![index].tokenNo.toString() == 'null')
//                                                                                 ? ''
//                                                                                 : rowMaintenanceProgressTabViewModel.rowMaintenanceProgressTabList.data!.rowMAINTENANCEPROGRESSData![index].tokenNo.toString(),
//                                                                             textAlign:
//                                                                                 TextAlign.left,
//                                                                             style:
//                                                                                 const TextStyle(
//                                                                               color: Colors.white,
//                                                                               fontWeight: FontWeight.bold,
//                                                                               fontSize: 20,
//                                                                             ),
//                                                                           ),
//                                                                         ),
//                                                                       ]),
//                                                                 ),
//                                                               ),
//                                                               Padding(
//                                                                 padding:
//                                                                     const EdgeInsets
//                                                                         .only(
//                                                                         top:
//                                                                             16.0,
//                                                                         left:
//                                                                             8.0),
//                                                                 child: Row(
//                                                                     children: [
//                                                                       const Expanded(
//                                                                         child:
//                                                                             Align(
//                                                                           alignment:
//                                                                               Alignment.centerLeft,
//                                                                           child:
//                                                                               Text(
//                                                                             "Substations: ",
//                                                                             textAlign:
//                                                                                 TextAlign.left,
//                                                                             style:
//                                                                                 TextStyle(
//                                                                               color: Color.fromARGB(255, 7, 59, 120),
//                                                                               fontWeight: FontWeight.bold,
//                                                                               fontSize: 16,
//                                                                             ),
//                                                                           ),
//                                                                         ),
//                                                                       ),
//                                                                       Expanded(
//                                                                         child:
//                                                                             Align(
//                                                                           alignment:
//                                                                               Alignment.centerLeft,
//                                                                           child:
//                                                                               Text(
//                                                                             (rowMaintenanceProgressTabViewModel.rowMaintenanceProgressTabList.data!.rowMAINTENANCEPROGRESSData![index].substation == null || rowMaintenanceProgressTabViewModel.rowMaintenanceProgressTabList.data!.rowMAINTENANCEPROGRESSData![index].substation.toString() == 'null')
//                                                                                 ? ''
//                                                                                 : rowMaintenanceProgressTabViewModel.rowMaintenanceProgressTabList.data!.rowMAINTENANCEPROGRESSData![index].substation.toString(),
//                                                                             textAlign:
//                                                                                 TextAlign.left,
//                                                                             style:
//                                                                                 const TextStyle(
//                                                                               color: Color.fromARGB(255, 7, 59, 120),
//                                                                               // fontWeight: FontWeight.bold,
//                                                                               fontSize: 16,
//                                                                             ),
//                                                                           ),
//                                                                         ),
//                                                                       ),
//                                                                     ]),
//                                                               ),
//                                                               Padding(
//                                                                 padding:
//                                                                     const EdgeInsets
//                                                                         .only(
//                                                                         top:
//                                                                             4.0,
//                                                                         left:
//                                                                             8.0),
//                                                                 child: Row(
//                                                                     children: [
//                                                                       const Expanded(
//                                                                         child:
//                                                                             Align(
//                                                                           alignment:
//                                                                               Alignment.centerLeft,
//                                                                           child:
//                                                                               Text(
//                                                                             "Feeder: ",
//                                                                             textAlign:
//                                                                                 TextAlign.left,
//                                                                             style:
//                                                                                 TextStyle(
//                                                                               color: Color.fromARGB(255, 7, 59, 120),
//                                                                               fontWeight: FontWeight.bold,
//                                                                               fontSize: 16,
//                                                                             ),
//                                                                           ),
//                                                                         ),
//                                                                       ),
//                                                                       Expanded(
//                                                                         child:
//                                                                             Align(
//                                                                           alignment:
//                                                                               Alignment.centerLeft,
//                                                                           child:
//                                                                               Text(
//                                                                             (rowMaintenanceProgressTabViewModel.rowMaintenanceProgressTabList.data!.rowMAINTENANCEPROGRESSData![index].feeder == null || rowMaintenanceProgressTabViewModel.rowMaintenanceProgressTabList.data!.rowMAINTENANCEPROGRESSData![index].feeder.toString() == 'null')
//                                                                                 ? ''
//                                                                                 : rowMaintenanceProgressTabViewModel.rowMaintenanceProgressTabList.data!.rowMAINTENANCEPROGRESSData![index].feeder.toString(),
//                                                                             textAlign:
//                                                                                 TextAlign.left,
//                                                                             style:
//                                                                                 const TextStyle(
//                                                                               color: Color.fromARGB(255, 7, 59, 120),
//                                                                               // fontWeight: FontWeight.bold,
//                                                                               fontSize: 16,
//                                                                             ),
//                                                                           ),
//                                                                         ),
//                                                                       ),
//                                                                     ]),
//                                                               ),
//                                                               Padding(
//                                                                 padding:
//                                                                     const EdgeInsets
//                                                                         .only(
//                                                                         top:
//                                                                             4.0,
//                                                                         left:
//                                                                             8.0),
//                                                                 child: Row(
//                                                                     children: [
//                                                                       const Expanded(
//                                                                         child:
//                                                                             Align(
//                                                                           alignment:
//                                                                               Alignment.centerLeft,
//                                                                           child:
//                                                                               Text(
//                                                                             "Cycle: ",
//                                                                             textAlign:
//                                                                                 TextAlign.left,
//                                                                             style:
//                                                                                 TextStyle(
//                                                                               color: Color.fromARGB(255, 7, 59, 120),
//                                                                               fontWeight: FontWeight.bold,
//                                                                               fontSize: 16,
//                                                                             ),
//                                                                           ),
//                                                                         ),
//                                                                       ),
//                                                                       Expanded(
//                                                                         child:
//                                                                             Align(
//                                                                           alignment:
//                                                                               Alignment.centerLeft,
//                                                                           child:
//                                                                               Text(
//                                                                             (rowMaintenanceProgressTabViewModel.rowMaintenanceProgressTabList.data!.rowMAINTENANCEPROGRESSData![index].cycle == null || rowMaintenanceProgressTabViewModel.rowMaintenanceProgressTabList.data!.rowMAINTENANCEPROGRESSData![index].cycle.toString() == 'null')
//                                                                                 ? ''
//                                                                                 : rowMaintenanceProgressTabViewModel.rowMaintenanceProgressTabList.data!.rowMAINTENANCEPROGRESSData![index].cycle.toString(),
//                                                                             textAlign:
//                                                                                 TextAlign.left,
//                                                                             style:
//                                                                                 const TextStyle(
//                                                                               color: Color.fromARGB(255, 7, 59, 120),
//                                                                               // fontWeight: FontWeight.bold,
//                                                                               fontSize: 16,
//                                                                             ),
//                                                                           ),
//                                                                         ),
//                                                                       ),
//                                                                     ]),
//                                                               ),
//                                                               InkWell(
//                                                                 onTap: () {
//                                                                   openDailogProgress(
//                                                                       (rowMaintenanceProgressTabViewModel.rowMaintenanceProgressTabList.data!.rowMAINTENANCEPROGRESSData![index].substation.toString() == 'null')
//                                                                           ? ''
//                                                                           : rowMaintenanceProgressTabViewModel.rowMaintenanceProgressTabList.data!.rowMAINTENANCEPROGRESSData![index].substation
//                                                                               .toString(),
//                                                                       rowMaintenanceProgressTabViewModel
//                                                                           .rowMaintenanceProgressTabList
//                                                                           .data!
//                                                                           .rowMAINTENANCEPROGRESSData![
//                                                                               index]
//                                                                           .crew
//                                                                           .toString(),
//                                                                       (rowMaintenanceProgressTabViewModel.rowMaintenanceProgressTabList.data!.rowMAINTENANCEPROGRESSData![index].totalMiles.toString() == 'null')
//                                                                           ? ''
//                                                                           : rowMaintenanceProgressTabViewModel.rowMaintenanceProgressTabList.data!.rowMAINTENANCEPROGRESSData![index].totalMiles
//                                                                               .toString(),
//                                                                       // double.parse(rowMaintenanceProgressTabViewModel
//                                                                       //         .rowMaintenanceProgressTabList
//                                                                       //         .data!
//                                                                       //         .rowMAINTENANCEPROGRESSData![
//                                                                       //             index]
//                                                                       //         .totalMiles
//                                                                       //         .toString())
//                                                                       //     .toStringAsFixed(
//                                                                       //         2),
//                                                                       (rowMaintenanceProgressTabViewModel.rowMaintenanceProgressTabList.data!.rowMAINTENANCEPROGRESSData![index].milesCompleted == null)
//                                                                           ? '0.0'
//                                                                           : double.parse(rowMaintenanceProgressTabViewModel.rowMaintenanceProgressTabList.data!.rowMAINTENANCEPROGRESSData![index].milesCompleted.toString()).toStringAsFixed(
//                                                                               2),
//                                                                       (rowMaintenanceProgressTabViewModel.rowMaintenanceProgressTabList.data!.rowMAINTENANCEPROGRESSData![index].milesProgress == null)
//                                                                           ? '0.0'
//                                                                           : double.parse(rowMaintenanceProgressTabViewModel.rowMaintenanceProgressTabList.data!.rowMAINTENANCEPROGRESSData![index].milesProgress.toString()).toStringAsFixed(
//                                                                               2),
//                                                                       (rowMaintenanceProgressTabViewModel.rowMaintenanceProgressTabList.data!.rowMAINTENANCEPROGRESSData![index].milesPending == null)
//                                                                           ? '0.0'
//                                                                           : double.parse(rowMaintenanceProgressTabViewModel.rowMaintenanceProgressTabList.data!.rowMAINTENANCEPROGRESSData![index].milesPending.toString()).toStringAsFixed(
//                                                                               2),
//                                                                       (rowMaintenanceProgressTabViewModel.rowMaintenanceProgressTabList.data!.rowMAINTENANCEPROGRESSData![index].milesCompleted ==
//                                                                               null)
//                                                                           ? '0.0'
//                                                                           : double.parse(rowMaintenanceProgressTabViewModel.rowMaintenanceProgressTabList.data!.rowMAINTENANCEPROGRESSData![index].milesCompleted.toString()).toStringAsFixed(2),
//                                                                       (rowMaintenanceProgressTabViewModel.rowMaintenanceProgressTabList.data!.rowMAINTENANCEPROGRESSData![index].milesProgress == null) ? '0.0' : double.parse(rowMaintenanceProgressTabViewModel.rowMaintenanceProgressTabList.data!.rowMAINTENANCEPROGRESSData![index].milesProgress.toString()).toStringAsFixed(2),
//                                                                       (rowMaintenanceProgressTabViewModel.rowMaintenanceProgressTabList.data!.rowMAINTENANCEPROGRESSData![index].milesPending == null) ? '0.0' : double.parse(rowMaintenanceProgressTabViewModel.rowMaintenanceProgressTabList.data!.rowMAINTENANCEPROGRESSData![index].milesPending.toString()).toStringAsFixed(2));
//                                                                 },
//                                                                 child:
//                                                                     Container(
//                                                                   // margin: const EdgeInsets.only(
//                                                                   //     left: 40, right: 40, bottom: 10.0),
//                                                                   padding:
//                                                                       const EdgeInsets
//                                                                           .all(
//                                                                           8),
//                                                                   alignment:
//                                                                       Alignment
//                                                                           .center,
//                                                                   width: 80,
//                                                                   // MediaQuery.of(context).size.width,
//                                                                   // height: MediaQuery.of(context).size.height * 0.4,
//                                                                   decoration:
//                                                                       const BoxDecoration(
//                                                                           // shape: BoxShape.circle,
//                                                                           boxShadow: [
//                                                                         BoxShadow(
//                                                                             color: Color.fromARGB(
//                                                                                 255,
//                                                                                 3,
//                                                                                 47,
//                                                                                 97),
//                                                                             blurRadius:
//                                                                                 5,
//                                                                             offset:
//                                                                                 Offset(2.0, 5.0))
//                                                                       ],
//                                                                           color: Color.fromARGB(
//                                                                               255,
//                                                                               130,
//                                                                               193,
//                                                                               245),
//                                                                           gradient:
//                                                                               LinearGradient(
//                                                                             colors: [
//                                                                               Color.fromARGB(255, 7, 59, 120),
//                                                                               Color.fromARGB(255, 7, 59, 120)
//                                                                             ],
//                                                                           )),
//                                                                   child:
//                                                                       const Text(
//                                                                     "View",
//                                                                     style:
//                                                                         TextStyle(
//                                                                       color: Colors
//                                                                           .white,
//                                                                       // fontWeight: FontWeight.bold,
//                                                                       fontSize:
//                                                                           16,
//                                                                     ),
//                                                                   ),
//                                                                 ),
//                                                               ),
//                                                             ],
//                                                           ),
//                                                         );
//                                                       },
//                                                     )),
//                                               ],
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 );

//                               default:
//                                 return const Text('data');
//                             }
//                           }))));
//         });
//   }

//   Future openDailogProgress(
//     String substation,
//     String crew,
//     String totalMiles,
//     String milesCompleted,
//     String miilesInProgress,
//     String milesPending,
//     String completedPercent,
//     String progressPercent,
//     String progressPending,
//   ) =>
//       showDialog(
//           context: context,
//           builder: (context) {
//             return StatefulBuilder(builder: (context, setState) {
//               return AlertDialog(
//                 content: SingleChildScrollView(
//                     child: Column(
//                   children: [
//                     Container(
//                       margin: const EdgeInsets.only(top: 10),
//                       child: Column(children: [
//                         Container(
//                           padding: const EdgeInsets.all(10),
//                           // width: size.width * 0.5,
//                           decoration: const BoxDecoration(
//                               // shape: BoxShape.circle,
//                               // borderRadius:
//                               //     BorderRadius.circular(25),
//                               borderRadius: BorderRadius.only(
//                                   topRight: Radius.circular(25),
//                                   bottomLeft: Radius.circular(25)),
//                               boxShadow: [
//                                 BoxShadow(
//                                     color: Color.fromARGB(255, 1, 17, 36),
//                                     blurRadius: 5,
//                                     offset: Offset(2.0, 5.0))
//                               ],
//                               color: Color.fromARGB(255, 130, 193, 245),
//                               gradient: LinearGradient(
//                                 colors: [
//                                   Color.fromARGB(255, 7, 59, 120),
//                                   Color.fromARGB(255, 7, 59, 120)
//                                 ],
//                               )),
//                           child: const Align(
//                             alignment: Alignment.center,
//                             child: Text(
//                               'PROGRESS DETAIL',
//                               textAlign: TextAlign.left,
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 20,
//                               ),
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(top: 20.0, left: 30),
//                           child: Row(children: [
//                             const Align(
//                               alignment: Alignment.center,
//                               child: Text(
//                                 "SUBSTATION : ",
//                                 textAlign: TextAlign.left,
//                                 style: TextStyle(
//                                   color: Color.fromARGB(255, 7, 59, 120),
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 16,
//                                 ),
//                               ),
//                             ),
//                             Align(
//                               alignment: Alignment.center,
//                               child: Text(
//                                 substation,
//                                 textAlign: TextAlign.left,
//                                 style: const TextStyle(
//                                   color: Color.fromARGB(255, 7, 59, 120),
//                                   // fontWeight: FontWeight.bold,
//                                   fontSize: 16,
//                                 ),
//                               ),
//                             ),
//                           ]),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(top: 8.0, left: 30),
//                           child: Row(children: [
//                             const Align(
//                               alignment: Alignment.center,
//                               child: Text(
//                                 "CREW NAME : ",
//                                 textAlign: TextAlign.left,
//                                 style: TextStyle(
//                                   color: Color.fromARGB(255, 7, 59, 120),
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 16,
//                                 ),
//                               ),
//                             ),
//                             Align(
//                               alignment: Alignment.center,
//                               child: Text(
//                                 crew,
//                                 textAlign: TextAlign.left,
//                                 style: const TextStyle(
//                                   color: Color.fromARGB(255, 7, 59, 120),
//                                   // fontWeight: FontWeight.bold,
//                                   fontSize: 16,
//                                 ),
//                               ),
//                             ),
//                           ]),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(top: 8.0, left: 30),
//                           child: Row(children: [
//                             const Align(
//                               alignment: Alignment.center,
//                               child: Text(
//                                 "TOTAL MILES : ",
//                                 textAlign: TextAlign.left,
//                                 style: TextStyle(
//                                   color: Color.fromARGB(255, 7, 59, 120),
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 16,
//                                 ),
//                               ),
//                             ),
//                             Align(
//                               alignment: Alignment.center,
//                               child: Text(
//                                 totalMiles,
//                                 textAlign: TextAlign.left,
//                                 style: const TextStyle(
//                                   color: Color.fromARGB(255, 7, 59, 120),
//                                   // fontWeight: FontWeight.bold,
//                                   fontSize: 16,
//                                 ),
//                               ),
//                             ),
//                           ]),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(top: 8.0, left: 30),
//                           child: Row(children: [
//                             const Align(
//                               alignment: Alignment.center,
//                               child: Text(
//                                 "MILES 'COMPLETED' : ",
//                                 textAlign: TextAlign.left,
//                                 style: TextStyle(
//                                   color: Color.fromARGB(255, 7, 59, 120),
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 16,
//                                 ),
//                               ),
//                             ),
//                             Align(
//                               alignment: Alignment.center,
//                               child: Text(
//                                 milesCompleted,
//                                 textAlign: TextAlign.left,
//                                 style: const TextStyle(
//                                   color: Color.fromARGB(255, 7, 59, 120),
//                                   // fontWeight: FontWeight.bold,
//                                   fontSize: 16,
//                                 ),
//                               ),
//                             ),
//                           ]),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(top: 8.0, left: 30),
//                           child: Row(children: [
//                             const Align(
//                               alignment: Alignment.center,
//                               child: Text(
//                                 "MILES 'IN PROGRESS' : ",
//                                 textAlign: TextAlign.left,
//                                 style: TextStyle(
//                                   color: Color.fromARGB(255, 7, 59, 120),
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 16,
//                                 ),
//                               ),
//                             ),
//                             Align(
//                               alignment: Alignment.center,
//                               child: Text(
//                                 miilesInProgress,
//                                 textAlign: TextAlign.left,
//                                 style: const TextStyle(
//                                   color: Color.fromARGB(255, 7, 59, 120),
//                                   // fontWeight: FontWeight.bold,
//                                   fontSize: 16,
//                                 ),
//                               ),
//                             ),
//                           ]),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(top: 8.0, left: 30),
//                           child: Row(children: [
//                             const Align(
//                               alignment: Alignment.center,
//                               child: Text(
//                                 "MILES 'PENDING' : ",
//                                 textAlign: TextAlign.left,
//                                 style: TextStyle(
//                                   color: Color.fromARGB(255, 7, 59, 120),
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 16,
//                                 ),
//                               ),
//                             ),
//                             Align(
//                               alignment: Alignment.center,
//                               child: Text(
//                                 milesPending,
//                                 textAlign: TextAlign.left,
//                                 style: const TextStyle(
//                                   color: Color.fromARGB(255, 7, 59, 120),
//                                   // fontWeight: FontWeight.bold,
//                                   fontSize: 16,
//                                 ),
//                               ),
//                             ),
//                           ]),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(top: 8.0, left: 30),
//                           child: Row(children: [
//                             const Align(
//                               alignment: Alignment.center,
//                               child: Text(
//                                 "COMPLETED (%) : ",
//                                 textAlign: TextAlign.left,
//                                 style: TextStyle(
//                                   color: Color.fromARGB(255, 7, 59, 120),
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 16,
//                                 ),
//                               ),
//                             ),
//                             Align(
//                               alignment: Alignment.center,
//                               child: Text(
//                                 completedPercent,
//                                 textAlign: TextAlign.left,
//                                 style: const TextStyle(
//                                   color: Color.fromARGB(255, 7, 59, 120),
//                                   // fontWeight: FontWeight.bold,
//                                   fontSize: 16,
//                                 ),
//                               ),
//                             ),
//                           ]),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(top: 8.0, left: 30),
//                           child: Row(children: [
//                             const Align(
//                               alignment: Alignment.center,
//                               child: Text(
//                                 "PROGRESS IN (%) : ",
//                                 textAlign: TextAlign.left,
//                                 style: TextStyle(
//                                   color: Color.fromARGB(255, 7, 59, 120),
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 16,
//                                 ),
//                               ),
//                             ),
//                             Align(
//                               alignment: Alignment.center,
//                               child: Text(
//                                 progressPercent,
//                                 textAlign: TextAlign.left,
//                                 style: const TextStyle(
//                                   color: Color.fromARGB(255, 7, 59, 120),
//                                   // fontWeight: FontWeight.bold,
//                                   fontSize: 16,
//                                 ),
//                               ),
//                             ),
//                           ]),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(top: 8.0, left: 30),
//                           child: Row(children: [
//                             const Align(
//                               alignment: Alignment.center,
//                               child: Text(
//                                 "PROGRESS PENDING (%) :",
//                                 textAlign: TextAlign.left,
//                                 style: TextStyle(
//                                   color: Color.fromARGB(255, 7, 59, 120),
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 16,
//                                 ),
//                               ),
//                             ),
//                             Align(
//                               alignment: Alignment.center,
//                               child: Text(
//                                 progressPending,
//                                 textAlign: TextAlign.left,
//                                 style: const TextStyle(
//                                   color: Color.fromARGB(255, 7, 59, 120),
//                                   // fontWeight: FontWeight.bold,
//                                   fontSize: 16,
//                                 ),
//                               ),
//                             ),
//                           ]),
//                         ),
//                       ]),
//                     ),
//                   ],
//                 )),
//                 actions: [
//                   Container(
//                       margin:
//                           const EdgeInsets.only(left: 6, right: 6, bottom: 10),
//                       child: InkWell(
//                         onTap: () {
//                           Navigator.pop(context);
//                         },
//                         child: Container(
//                           margin: const EdgeInsets.only(
//                               left: 40, right: 40, bottom: 10.0),
//                           // padding: const EdgeInsets.all(8),
//                           alignment: Alignment.center,
//                           width: MediaQuery.of(context).size.width,
//                           height: 40,
//                           decoration: const BoxDecoration(
//                               // shape: BoxShape.circle,

//                               boxShadow: [
//                                 BoxShadow(
//                                     color: Color.fromARGB(255, 118, 10, 2),
//                                     blurRadius: 5,
//                                     offset: Offset(2.0, 5.0))
//                               ],
//                               color: Color.fromARGB(255, 118, 10, 2),
//                               gradient: LinearGradient(
//                                 colors: [
//                                   Colors.red,
//                                   Colors.red,
//                                 ],
//                               )),
//                           child: const Row(children: [
//                             Expanded(
//                               child: Align(
//                                 alignment: Alignment.center,
//                                 child: Text(
//                                   "Close",
//                                   textAlign: TextAlign.left,
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 20,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ]),
//                         ),
//                       )),
//                 ],
//               );
//             });
//           });

//   Future openFilter() => showDialog(
//       context: context,
//       builder: (context) {
//         return StatefulBuilder(builder: (context, setState) {
//           state = setState;
//           // Size size = MediaQuery.of(context).size;
//           return AlertDialog(
//             content: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   Padding(
//                     padding:
//                         const EdgeInsets.only(bottom: 2, left: 2, right: 2),
//                     child: Column(
//                       children: [
//                         const Align(
//                             alignment: Alignment.centerLeft,
//                             child: Padding(
//                               padding: EdgeInsets.all(2.0),
//                               child: Text(
//                                 "Year",
//                                 style: TextStyle(
//                                   fontSize: 16.0,
//                                   color: Color.fromARGB(255, 7, 59, 120),
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             )),
//                         Align(
//                           alignment: Alignment.centerLeft,
//                           child: Padding(
//                             padding: const EdgeInsets.all(2.0),
//                             child: Container(
//                               padding: const EdgeInsets.symmetric(
//                                   horizontal: 12, vertical: 4),
//                               // width: size.width * 0.4,
//                               decoration: BoxDecoration(
//                                 // borderRadius:
//                                 //     BorderRadius.circular(
//                                 //         25),
//                                 border: Border.all(
//                                   color: const Color.fromARGB(255, 7, 59, 120),
//                                 ),
//                               ),
//                               child: MultiSelectDialogField(
//                                   items: rowMaintenanceProgressTabViewModel
//                                       .rowMaintenanceProgressTabList
//                                       .data!
//                                       .nextMaintDueYear!
//                                       .map((e) => MultiSelectItem(
//                                           e.nextMaintDue.toString(),
//                                           e.nextMaintDue.toString()))
//                                       .toList(),
//                                   initialValue:
//                                       (year == null || year.toString().isEmpty)
//                                           ? []
//                                           : year!.split(','),
//                                   listType: MultiSelectListType.CHIP,
//                                   onConfirm: (value) {
//                                     year = value.join(',');
//                                     fetchData('', '', '', '', year!);
//                                     Navigator.pop(context);
//                                     (value) =>
//                                         value == null ? 'field required' : null;
//                                   }),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Padding(
//                     padding:
//                         const EdgeInsets.only(bottom: 2, left: 2, right: 2),
//                     child: Column(
//                       children: [
//                         const Align(
//                             alignment: Alignment.centerLeft,
//                             child: Padding(
//                               padding: EdgeInsets.all(2.0),
//                               child: Text(
//                                 "Cycle",
//                                 style: TextStyle(
//                                   fontSize: 16.0,
//                                   color: Color.fromARGB(255, 7, 59, 120),
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             )),
//                         Align(
//                           alignment: Alignment.centerLeft,
//                           child: Padding(
//                             padding: const EdgeInsets.all(2.0),
//                             child: Container(
//                               padding: const EdgeInsets.symmetric(
//                                   horizontal: 12, vertical: 4),
//                               // width: size.width * 0.4,
//                               decoration: BoxDecoration(
//                                 // borderRadius:
//                                 //     BorderRadius.circular(
//                                 //         25),
//                                 border: Border.all(
//                                   color: const Color.fromARGB(255, 7, 59, 120),
//                                 ),
//                               ),
//                               child: MultiSelectDialogField(
//                                   items: rowMaintenanceProgressTabViewModel
//                                       .rowMaintenanceProgressTabList
//                                       .data!
//                                       .cycleLists!
//                                       .map((e) => MultiSelectItem(
//                                           e.cycle.toString(),
//                                           e.cycle.toString()))
//                                       .toList(),
//                                   initialValue: (cycle == null ||
//                                           cycle.toString().isEmpty)
//                                       ? []
//                                       : cycle!.split(','),
//                                   listType: MultiSelectListType.CHIP,
//                                   onConfirm: (value) {
//                                     cycle = value.join(',');
//                                     fetchData(cycle!, '', '', '', year!);
//                                     Navigator.pop(context);
//                                     (value) =>
//                                         value == null ? 'field required' : null;
//                                   }),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Padding(
//                     padding:
//                         const EdgeInsets.only(bottom: 2, left: 2, right: 2),
//                     child: Column(
//                       children: [
//                         const Align(
//                             alignment: Alignment.centerLeft,
//                             child: Padding(
//                               padding: EdgeInsets.all(2.0),
//                               child: Text(
//                                 "Substation",
//                                 style: TextStyle(
//                                   fontSize: 16.0,
//                                   color: Color.fromARGB(255, 7, 59, 120),
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             )),
//                         Align(
//                           alignment: Alignment.centerLeft,
//                           child: Padding(
//                             padding: const EdgeInsets.all(2.0),
//                             child: Container(
//                               padding: const EdgeInsets.symmetric(
//                                   horizontal: 12, vertical: 4),
//                               // width: size.width * 0.4,
//                               decoration: BoxDecoration(
//                                 // borderRadius:
//                                 //     BorderRadius.circular(
//                                 //         25),
//                                 border: Border.all(
//                                   color: const Color.fromARGB(255, 7, 59, 120),
//                                 ),
//                               ),
//                               child: MultiSelectDialogField(
//                                   items: rowMaintenanceProgressTabViewModel
//                                       .rowMaintenanceProgressTabList
//                                       .data!
//                                       .subStations!
//                                       .map((e) => MultiSelectItem(
//                                           e.subStation.toString(),
//                                           e.subStation.toString()))
//                                       .toList(),
//                                   initialValue: (substation == null ||
//                                           substation.toString().isEmpty)
//                                       ? []
//                                       : substation!.split(','),
//                                   listType: MultiSelectListType.CHIP,
//                                   onConfirm: (value) {
//                                     substation = value.join(',');
//                                     fetchData(cycle!, substation!, '', '',
//                                         year!.toString());
//                                     Navigator.pop(context);
//                                     (value) =>
//                                         value == null ? 'field required' : null;
//                                   }),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Padding(
//                     padding:
//                         const EdgeInsets.only(bottom: 2, left: 2, right: 2),
//                     child: Column(
//                       children: [
//                         const Align(
//                             alignment: Alignment.centerLeft,
//                             child: Padding(
//                               padding: EdgeInsets.all(2.0),
//                               child: Text(
//                                 "Feeder",
//                                 style: TextStyle(
//                                   fontSize: 16.0,
//                                   color: Color.fromARGB(255, 7, 59, 120),
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             )),
//                         Align(
//                           alignment: Alignment.centerLeft,
//                           child: Padding(
//                             padding: const EdgeInsets.all(2.0),
//                             child: Container(
//                               padding: const EdgeInsets.symmetric(
//                                   horizontal: 12, vertical: 4),
//                               // width: size.width * 0.4,
//                               decoration: BoxDecoration(
//                                 // borderRadius:
//                                 //     BorderRadius.circular(
//                                 //         25),
//                                 border: Border.all(
//                                   color: const Color.fromARGB(255, 7, 59, 120),
//                                 ),
//                               ),
//                               child: MultiSelectDialogField(
//                                   items: rowMaintenanceProgressTabViewModel
//                                       .rowMaintenanceProgressTabList
//                                       .data!
//                                       .feederLists!
//                                       .map((e) => MultiSelectItem(
//                                           e.feeder.toString(),
//                                           e.feeder.toString()))
//                                       .toList(),
//                                   initialValue: (feeder == null ||
//                                           feeder.toString().isEmpty)
//                                       ? []
//                                       : feeder!.split(','),
//                                   listType: MultiSelectListType.CHIP,
//                                   onConfirm: (value) {
//                                     feeder = value.join(',');
//                                     fetchData(cycle!, substation!, feeder!, '',
//                                         year!);
//                                     Navigator.pop(context);
//                                     (value) =>
//                                         value == null ? 'field required' : null;
//                                   }),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Padding(
//                     padding:
//                         const EdgeInsets.only(bottom: 2, left: 2, right: 2),
//                     child: Column(
//                       children: [
//                         const Align(
//                             alignment: Alignment.centerLeft,
//                             child: Padding(
//                               padding: EdgeInsets.all(2.0),
//                               child: Text(
//                                 "Crew",
//                                 style: TextStyle(
//                                   fontSize: 16.0,
//                                   color: Color.fromARGB(255, 7, 59, 120),
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             )),
//                         Align(
//                           alignment: Alignment.centerLeft,
//                           child: Padding(
//                             padding: const EdgeInsets.all(2.0),
//                             child: Container(
//                               padding: const EdgeInsets.symmetric(
//                                   horizontal: 12, vertical: 4),
//                               // width: size.width * 0.4,
//                               decoration: BoxDecoration(
//                                 // borderRadius:
//                                 //     BorderRadius.circular(
//                                 //         25),
//                                 border: Border.all(
//                                   color: const Color.fromARGB(255, 7, 59, 120),
//                                 ),
//                               ),
//                               child: MultiSelectDialogField(
//                                   items: rowMaintenanceProgressTabViewModel
//                                       .rowMaintenanceProgressTabList
//                                       .data!
//                                       .crewsData!
//                                       .map((e) => MultiSelectItem(
//                                           e.crew.toString(), e.crew.toString()))
//                                       .toList(),
//                                   initialValue:
//                                       (crew == null || crew.toString().isEmpty)
//                                           ? []
//                                           : crew!.split(','),
//                                   listType: MultiSelectListType.CHIP,
//                                   onConfirm: (value) {
//                                     crew = value.join(',');
//                                     fetchData(cycle!, substation!, feeder!,
//                                         crew!, year!);
//                                     Navigator.pop(context);
//                                     (value) =>
//                                         value == null ? 'field required' : null;
//                                   }),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             actions: [
//               Container(
//                   margin: const EdgeInsets.only(
//                       left: 6, right: 6, top: 6.0, bottom: 10),
//                   child: InkWell(
//                     onTap: () {
//                       Navigator.pop(context);
//                     },
//                     child: Container(
//                       margin: const EdgeInsets.only(
//                           left: 40, right: 40, bottom: 10.0),
//                       // padding: const EdgeInsets.all(8),
//                       alignment: Alignment.center,
//                       width: MediaQuery.of(context).size.width,
//                       height: 40,
//                       decoration: const BoxDecoration(
//                           // shape: BoxShape.circle,

//                           boxShadow: [
//                             BoxShadow(
//                                 color: Color.fromARGB(255, 132, 11, 2),
//                                 blurRadius: 5,
//                                 offset: Offset(2.0, 5.0))
//                           ],
//                           color: Colors.black,
//                           gradient: LinearGradient(
//                             colors: [
//                               Color.fromARGB(255, 250, 6, 42),
//                               Color.fromARGB(255, 216, 19, 5),
//                               Color.fromARGB(255, 250, 6, 42),
//                             ],
//                           )),
//                       child: const Row(children: [
//                         Expanded(
//                           child: Align(
//                             alignment: Alignment.center,
//                             child: Text(
//                               "Close",
//                               textAlign: TextAlign.left,
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 20,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ]),
//                     ),
//                   )),
//             ],
//           );
//         });
//       });

//   DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
//       value: item,
//       child: Text(item,
//           style: const TextStyle(
//             fontWeight: FontWeight.normal,
//             fontSize: 20,
//           )));

//   String getCurrentDate() {
//     var date = DateTime.now().toString();

//     var dateParse = DateTime.parse(date);

//     var formattedDate = "${dateParse.day}-${dateParse.month}-${dateParse.year}";
//     return formattedDate.toString();
//   }

//   String getCurrentTime() {
//     var time = DateTime.now().toString();
//     var dateParse = DateTime.parse(time);
//     var formattedTime =
//         "${dateParse.hour}.${dateParse.minute}.${dateParse.second}";
//     return formattedTime.toString();
//   }

//   final RegExp _numeric = RegExp(r'^-?[0-9]+$');

//   /// check if the string contains only numbers
//   bool isNumeric(String str) {
//     return _numeric.hasMatch(str);
//   }

//   savePageNum(int pages) async {
//     SharedPreferences preferences = await SharedPreferences.getInstance();
//     preferences.setInt('pages', pages);
//   }

//   showLoaderDialog(BuildContext context) {
//     AlertDialog alert = AlertDialog(
//       content: Row(
//         children: [
//           const CircularProgressIndicator(),
//           Container(
//               margin: const EdgeInsets.only(left: 7),
//               child: const Text("Loading...")),
//         ],
//       ),
//     );
//     showDialog(
//       barrierDismissible: false,
//       context: context,
//       builder: (BuildContext context) {
//         return alert;
//       },
//     );
//   }

//   void fetchData(String cycleList, String subStationList, String feeder,
//       String crew, String yearList) {
//     rowMaintenanceProgressTabViewModel.fetchRowMaintenanceProgressTabListApi(
//         context, cycleList, subStationList, feeder, crew, yearList);
//   }

//   // List<_ChartDataSimpleColumnChart1> recreateDataStatus(
//   //     RowMaintenanceProgressTabViewModel value) {
//   //   List<_ChartDataSimpleColumnChart1> dataSimpleColumnChart1 = [];
//   //   var rowMaintenanceProgressTabList = value.rowMaintenanceProgressTabList;
//   //   if (rowMaintenanceProgressTabList.data?.completeProgressAndPendingData !=
//   //       null) {
//   //     List<Color> colors = [
//   //       const Color.fromARGB(255, 1, 158, 1),
//   //       const Color.fromARGB(255, 255, 123, 0),
//   //       const Color.fromARGB(255, 245, 18, 2),
//   //       Colors.yellow,
//   //     ];
//   //     for (var i = 0;
//   //         i <
//   //             rowMaintenanceProgressTabList
//   //                 .data!.completeProgressAndPendingData!.length;
//   //         i++) {
//   //       var currentData = rowMaintenanceProgressTabList
//   //           .data!.completeProgressAndPendingData![i];
//   //       var status = currentData.status;
//   //       var percent = currentData.value;

//   //       // Assign a color based on the index of the data point
//   //       Color color = i < colors.length ? colors[i] : Colors.grey;
//   //       dataSimpleColumnChart1.add(_ChartDataSimpleColumnChart1(
//   //         status?.isEmpty ?? true ? '' : status!.toString(),
//   //         percent == null || percent.toString() == 'null'
//   //             ? 0
//   //             : double.parse(percent.toString()),
//   //         color, // Assign the color to the data point
//   //       ));
//   //     }
//   //   }
//   //   return dataSimpleColumnChart1;
//   // }

//   List<_ChartDataSimpleColumnChart1> recreateDataStatus(
//       RowMaintenanceProgressTabViewModel value) {
//     List<_ChartDataSimpleColumnChart1> dataSimpleColumnChart1 = [];
//     var rowMaintenanceProgressTabList = value.rowMaintenanceProgressTabList;

//     if (rowMaintenanceProgressTabList.data?.completeProgressAndPending !=
//         null) {
//       List<Color> colors = [
//         const Color.fromARGB(255, 1, 158, 1), // Completed
//         const Color.fromARGB(255, 255, 123, 0), // In Progress
//         const Color.fromARGB(255, 245, 18, 2), // Pending
//         Colors.yellow, // Total Miles
//       ];

//       var currentData =
//           rowMaintenanceProgressTabList.data!.completeProgressAndPending!.first;

//       dataSimpleColumnChart1.add(_ChartDataSimpleColumnChart1(
//         "Completed",
//         currentData.completed ?? 0.0,
//         colors[0],
//       ));

//       dataSimpleColumnChart1.add(_ChartDataSimpleColumnChart1(
//         "In Progress",
//         currentData.progress ?? 0.0,
//         colors[1],
//       ));

//       dataSimpleColumnChart1.add(_ChartDataSimpleColumnChart1(
//         "Pending",
//         currentData.pending ?? 0.0,
//         colors[2],
//       ));

//       // dataSimpleColumnChart1.add(_ChartDataSimpleColumnChart1(
//       //   "Total Miles",
//       //   currentData.totalMiles ?? 0.0,
//       //   colors[3],
//       // ));
//     }

//     return dataSimpleColumnChart1;
//   }

//   createPieChartValues() {
//     for (var entry in rowMaintenanceProgressTabViewModel
//         .rowMaintenanceProgressTabList.data!.completeProgressAndPending!) {
//       progressTotal = entry.progress!;
//       pendingTotal = entry.pending!;
//       completedTotal = entry.completed!;
//       totalMiles = entry.totalMiles!;
//     }
//     dataMap = {
//       'Miles Completed': completedTotal,
//       'Miles in Progress': progressTotal,
//       'Miles Pending':
//           (completedTotal == 0.0 && progressTotal == 0.0 && pendingTotal == 0.0)
//               ? totalMiles
//               : pendingTotal,
//     };
//   }
// }

// class _ChartDataSimpleColumnChart1 {
//   _ChartDataSimpleColumnChart1(this.x, this.y1, this.color);

//   final String x;
//   final double y1;
//   final Color color; // Color field for each data point
// }
