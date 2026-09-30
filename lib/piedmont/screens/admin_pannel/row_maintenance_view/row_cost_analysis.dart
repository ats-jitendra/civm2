// // import 'package:CIVM/piedmont/screens/admin_pannel/map_view_admin.dart';
// import 'package:CIVM/piedmont/repository/map_url.dart';
// import 'package:CIVM/piedmont/screens/my_chrome_safari_map_recording.dart';
// import 'package:CIVM/utils/user_pref.dart';
// import 'package:CIVM/models/user_model.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// // import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';
// import '../../../data/response/status.dart';
// import '../../../view_model/row_cost_analysis_view_model.dart';
// import 'package:CIVM/piedmont/resources/app_colors.dart';
// // ignore: must_be_immutable
// class RowCostAnalysis extends StatefulWidget {
//   const RowCostAnalysis({Key? key}) : super(key: key);

//   @override
//   State<RowCostAnalysis> createState() => _RowCostAnalysisState();
// }

// class _RowCostAnalysisState extends State<RowCostAnalysis> {
// // ignore: prefer_typing_uninitialized_variables
//   var selectedSubstation;
//   int substationId = 0;

//   // ignore: prefer_typing_uninitialized_variables
//   var selectedDueYear;

//   // ignore: non_constant_identifier_names
//   final List<String> select_feeder = ['CARLTON', 'CASS', 'ITASCA', 'PINE'];
//   String? feeder;

//   // ignore: non_constant_identifier_names
//   final List<String> select_nextMaint = ['CARLTON', 'CASS', 'ITASCA', 'PINE'];
//   String? nextMaint;

//   // late final List<charts.Series> seriesList;
//   late final bool animate = true;
//   final TextEditingController _input = TextEditingController();
//   late final Future? myFuture;
//   var result = [];

//   List<_ChartDataSimpleColumnChart1> chartDataSimpleColumnChart1 = [];
//   List<_ChartDataSimpleColumnChart2> chartDataSimpleColumnChart2 = [];

//   DateTime date20 = DateTime.now();
//   late String dateSelected20 = DateFormat('MM-dd-yyyy').format(date20);

//   DateTime date21 = DateTime.now();
//   late String dateSelected21 = DateFormat('MM-dd-yyyy').format(date21);

//   Future<void> selectDate20(BuildContext context) async {
//     final DateTime? picked20 = await showDatePicker(
//         context: context,
//         initialDate: date20,
//         firstDate: DateTime(2010),
//         lastDate: DateTime(2050));
//     if (picked20 != null && picked20 != date20) {
//       setState(() {
//         date20 = picked20;
//         // print(date12.toString());
//         dateSelected20 = DateFormat('MM-dd-yyyy').format(picked20);
//       });
//     }
//   }

//   Future<void> selectDate21(BuildContext context) async {
//     final DateTime? picked21 = await showDatePicker(
//         context: context,
//         initialDate: date20,
//         firstDate: DateTime(2010),
//         lastDate: DateTime(2050));
//     if (picked21 != null && picked21 != date20) {
//       setState(() {
//         date20 = picked21;
//         // print(date12.toString());
//         dateSelected20 = DateFormat('MM-dd-yyyy').format(picked21);
//       });
//     }
//   }

//   final browser = MyChromeSafariBrowser();
//   RowCostAnalysisViewModel rowCostAnalysisViewModel =
//       RowCostAnalysisViewModel();

//   @override
//   void initState() {
//     rowCostAnalysisViewModel.fetchRowCostAnalysisListApi(context, '', '', '');
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//        backgroundColor:AppColors.backgroundColor,
//         appBar: AppBar(
//           iconTheme: const IconThemeData(color: Colors.white),
//           title: const Text(
//             'Row Cost Analysis',
//             style: TextStyle(color: Colors.white),
//           ),
//           backgroundColor: AppColors.baseColor,
//           actions: const <Widget>[],
//         ),
//         body: ChangeNotifierProvider<RowCostAnalysisViewModel>(
//             create: (BuildContext context) => rowCostAnalysisViewModel,
//             child: Consumer<RowCostAnalysisViewModel>(
//                 builder: (context, value, _) {
//               switch (value.rowCostAnalysisList.status) {
//                 case Status.LOADING:
//                   return const Center(child: CircularProgressIndicator());
//                 case Status.ERROR:
//                   return
//                       // CustomToastSnackBarProgressDialog.flushBarErrorMessage(
//                       //     value.rowCostAnalysisList.message.toString(), context);
//                       Padding(
//                     padding: const EdgeInsets.only(
//                         top: 16.0, bottom: 16, left: 8, right: 8),
//                     child: Center(
//                       child: Align(
//                         alignment: Alignment.topCenter,
//                         child: Column(
//                           children: [
//                             Image.asset(
//                               'assets/empty_box_pemc.png',
//                               height: 200,
//                               width: 200,
//                               fit: BoxFit.cover,
//                             ),
//                             const Center(
//                               child: Text(
//                                 'Sorry, Data Not Found!',
//                                 textAlign: TextAlign.left,
//                                 style: TextStyle(
//                                   color: AppColors.baseColor,
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 20,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   );
//                 case Status.COMPLETED:
//                   return RefreshIndicator(
//                     onRefresh: () async {
//                       _input.clear();
//                       selectedSubstation = null;
//                       selectedDueYear=null;
//                       await rowCostAnalysisViewModel
//                           .fetchRowCostAnalysisListApi(context, '', '', '');
//                     },
//                     child: SingleChildScrollView(
//                       child: Center(
//                         child: Column(
//                           children: [
//                             SingleChildScrollView(
//                               scrollDirection: Axis.horizontal,
//                               child: Row(
//                                 children: [
//                                   Padding(
//                                     padding: const EdgeInsets.only(
//                                         top: 10, bottom: 2, left: 2, right: 2),
//                                     child: Column(
//                                       children: [
//                                         const Align(
//                                             alignment: Alignment.centerLeft,
//                                             child: Padding(
//                                               padding: EdgeInsets.all(2.0),
//                                               child: Text(
//                                                 "Substation",
//                                                 style: TextStyle(
//                                                   fontSize: 16.0,
//                                                   color: Color.fromARGB(
//                                                       255, 7, 59, 120),
//                                                   // fontWeight: FontWeight.bold,
//                                                 ),
//                                               ),
//                                             )),
//                                         Align(
//                                           alignment: Alignment.centerLeft,
//                                           child: Padding(
//                                             padding: const EdgeInsets.all(2.0),
//                                             child: Container(
//                                               padding:
//                                                   const EdgeInsets.symmetric(
//                                                       horizontal: 12,
//                                                       vertical: 4),
//                                               width: size.width * 0.4,
//                                               decoration: BoxDecoration(
//                                                 borderRadius:
//                                                     BorderRadius.circular(25),
//                                                 border: Border.all(
//                                                   color: const Color.fromARGB(
//                                                       255, 7, 59, 120),
//                                                 ),
//                                               ),
//                                               child: DropdownButtonFormField<
//                                                   String>(
//                                                 hint: const Text('-Select-'),
//                                                 dropdownColor: Colors.white,
//                                                 value: selectedSubstation,
//                                                 style: const TextStyle(
//                                                     color: Color.fromARGB(
//                                                         255, 7, 59, 120),
//                                                     fontSize: 16),
//                                                 icon: const Icon(
//                                                   Icons.arrow_drop_down,
//                                                   color: Color.fromARGB(
//                                                       255, 7, 59, 120),
//                                                   size: 40,
//                                                 ),
//                                                 isExpanded: true,
//                                                 items: rowCostAnalysisViewModel
//                                                     .rowCostAnalysisList
//                                                     .data!
//                                                     .findsSubstation!
//                                                     .map((e) {
//                                                   return DropdownMenuItem(
//                                                     value: e.id.toString(),
//                                                     child: Text(e.substation
//                                                         .toString()),
//                                                   );
//                                                 }).toList(),
//                                                 onChanged: (val) {
//                                                   if (selectedDueYear != null) {
//                                                     selectedDueYear = null;
//                                                   }
//                                                   print('val');
//                                                   print(val);
//                                                   fetchData(val!, '', '');
//                                                   substationId = int.parse(val);
//                                                   print('111111111111111');
//                                                   // print(id.text.toString());
//                                                   setState(() {
//                                                     selectedSubstation = val;
//                                                   });
//                                                 },
//                                                 validator: (value) =>
//                                                     value == null
//                                                         ? 'field required'
//                                                         : null,
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.only(
//                                         top: 10, bottom: 2, left: 2, right: 2),
//                                     child: Column(
//                                       children: [
//                                         const Align(
//                                             alignment: Alignment.centerLeft,
//                                             child: Padding(
//                                               padding: EdgeInsets.all(2.0),
//                                               child: Text(
//                                                 "Due Year",
//                                                 style: TextStyle(
//                                                   fontSize: 16.0,
//                                                   color: Color.fromARGB(
//                                                       255, 7, 59, 120),
//                                                   // fontWeight: FontWeight.bold,
//                                                 ),
//                                               ),
//                                             )),
//                                         Align(
//                                           alignment: Alignment.centerLeft,
//                                           child: Padding(
//                                             padding: const EdgeInsets.all(2.0),
//                                             child: Container(
//                                               padding:
//                                                   const EdgeInsets.symmetric(
//                                                       horizontal: 12,
//                                                       vertical: 4),
//                                               width: size.width * 0.4,
//                                               decoration: BoxDecoration(
//                                                 borderRadius:
//                                                     BorderRadius.circular(25),
//                                                 border: Border.all(
//                                                   color: const Color.fromARGB(
//                                                       255, 7, 59, 120),
//                                                 ),
//                                               ),
//                                               child: DropdownButtonFormField<
//                                                   String>(
//                                                 hint: const Text('-Select-'),
//                                                 dropdownColor: Colors.white,
//                                                 value: selectedDueYear,
//                                                 style: const TextStyle(
//                                                     color: Color.fromARGB(
//                                                         255, 7, 59, 120),
//                                                     fontSize: 16),
//                                                 icon: const Icon(
//                                                   Icons.arrow_drop_down,
//                                                   color: Color.fromARGB(
//                                                       255, 7, 59, 120),
//                                                   size: 40,
//                                                 ),
//                                                 isExpanded: true,
//                                                 items: rowCostAnalysisViewModel
//                                                     .rowCostAnalysisList
//                                                     .data!
//                                                     .findsNextMaintDueBySubstation!
//                                                     .map((e) {
//                                                   return DropdownMenuItem(
//                                                     value: e.nextMaintDue
//                                                         .toString(),
//                                                     // e.getIdAndSubstationByCountId![0].subStation.toString(),
//                                                     child: Text(e.nextMaintDue
//                                                         .toString()),
//                                                   );
//                                                 }).toList(),
//                                                 onChanged: (val) {
//                                                   print('val');
//                                                   print(val);
//                                                   fetchData(
//                                                       substationId.toString(),
//                                                       '',
//                                                       val!);
//                                                   // substationId = int.parse(val);
//                                                   print('111111111111111');
//                                                   // print(substationId);
//                                                   setState(() {
//                                                     selectedDueYear = val;
//                                                   });
//                                                 },
//                                                 validator: (value) =>
//                                                     value == null
//                                                         ? 'field required'
//                                                         : null,
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             // Padding(
//                             //   padding: const EdgeInsets.only(
//                             //       top: 16.0, left: 16, right: 16),
//                             //   child: Container(
//                             //     padding: const EdgeInsets.all(10),
//                             //     alignment: Alignment.center,
//                             //     // width: size.width * 0.8,
//                             //     // height: 40,
//                             //     decoration: const BoxDecoration(
//                             //         boxShadow: [
//                             //           BoxShadow(
//                             //               color: Color.fromARGB(255, 3, 47, 97),
//                             //               blurRadius: 5,
//                             //               offset: Offset(2.0, 5.0))
//                             //         ],
//                             //         gradient: LinearGradient(
//                             //           colors: [Colors.white, Colors.white],
//                             //         )),
//                             //     child: Row(children: [
//                             //       Align(
//                             //         alignment: Alignment.centerLeft,
//                             //         child: Row(
//                             //           children: [
//                             //             const Padding(
//                             //               padding: EdgeInsets.only(left: 8.0),
//                             //               child: Text(
//                             //                 "ESTIMATED BUDGET (\$): ",
//                             //                 textAlign: TextAlign.left,
//                             //                 style: TextStyle(
//                             //                   color:
//                             //                       AppColors.baseColor,
//                             //                   fontWeight: FontWeight.bold,
//                             //                   fontSize: 20,
//                             //                 ),
//                             //               ),
//                             //             ),
//                             //             Padding(
//                             //               padding:
//                             //                   const EdgeInsets.only(right: 8.0),
//                             //               child: Text(
//                             //                 rowCostAnalysisViewModel
//                             //                     .rowCostAnalysisList
//                             //                     .data!
//                             //                     .findEstimatedBudgetBYSubstation
//                             //                     .toString(),
//                             //                 textAlign: TextAlign.left,
//                             //                 style: const TextStyle(
//                             //                   color:
//                             //                       AppColors.baseColor,
//                             //                   fontWeight: FontWeight.bold,
//                             //                   fontSize: 20,
//                             //                 ),
//                             //               ),
//                             //             ),
//                             //           ],
//                             //         ),
//                             //       ),
//                             //     ]),
//                             //   ),
//                             // ),

//                             Container(
//                               margin: const EdgeInsets.only(
//                                   top: 10, bottom: 10, left: 8, right: 8),
//                               padding: const EdgeInsets.all(8),
//                               alignment: Alignment.center,
//                               height: size.height * 0.6,
//                               width: size.width * 0.99,
//                               decoration: BoxDecoration(
//                                   // shape: BoxShape.circle,
//                                   borderRadius: BorderRadius.circular(10),
//                                   boxShadow: const [
//                                     BoxShadow(
//                                         color: Color.fromARGB(255, 3, 47, 97),
//                                         blurRadius: 10,
//                                         offset: Offset(2.0, 5.0))
//                                   ],
//                                   gradient: const LinearGradient(
//                                     colors: [
//                                       Color.fromARGB(255, 255, 255, 255),
//                                       Color.fromARGB(255, 255, 255, 255),
//                                     ],
//                                   )),
//                               child: Column(
//                                 children: [
//                                   Container(
//                                     padding: const EdgeInsets.all(10),
//                                     alignment: Alignment.center,
//                                     width: size.width * 0.99,
//                                     // width: MediaQuery.of(context).size.width,
//                                     // height: 40,
//                                     decoration: const BoxDecoration(
//                                         // shape: BoxShape.circle,
//                                         //borderRadius: BorderRadius.circular(25),
//                                         boxShadow: [
//                                           BoxShadow(
//                                               color: Color.fromARGB(
//                                                   255, 3, 47, 97),
//                                               blurRadius: 5,
//                                               offset: Offset(2.0, 5.0))
//                                         ],
//                                         color:
//                                             Color.fromARGB(255, 130, 193, 245),
//                                         gradient: LinearGradient(
//                                           colors: [
//                                             AppColors.baseColor,
//                                             Color.fromARGB(255, 7, 59, 120)
//                                           ],
//                                         )),
//                                     child: const Text(
//                                       "Total Miles By Substation",
//                                       textAlign: TextAlign.left,
//                                       style: TextStyle(
//                                         color: Colors.white,
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 20,
//                                       ),
//                                     ),
//                                   ),
//                                   Expanded(
//                                     child: SfCartesianChart(
//                                       primaryXAxis: CategoryAxis(
//                                         title: AxisTitle(
//                                             text: 'SUBSTATION',
//                                             textStyle: const TextStyle(
//                                                 color: Colors.red,
//                                                 fontFamily: 'Roboto',
//                                                 fontSize: 16,
//                                                 fontStyle: FontStyle.italic,
//                                                 fontWeight: FontWeight.bold)),
//                                       ),
//                                       primaryYAxis: CategoryAxis(
//                                         title: AxisTitle(
//                                             text: 'TOTAL MILES',
//                                             textStyle: const TextStyle(
//                                                 color: Colors.red,
//                                                 fontFamily: 'Roboto',
//                                                 fontSize: 16,
//                                                 fontStyle: FontStyle.italic,
//                                                 fontWeight: FontWeight.bold)),
//                                       ),
//                                       legend: Legend(isVisible: true),
//                                       palette: const <Color>[
//                                         Color.fromARGB(255, 21, 80, 218)
//                                       ],
//                                       series: <CartesianSeries>[
//                                         ColumnSeries<
//                                             _ChartDataSimpleColumnChart1,
//                                             String>(
//                                           name: 'MILES OF LINE',
//                                           dataSource:
//                                               recreateDataTotalMilesBySubstation(
//                                                   value),
//                                           xValueMapper:
//                                               (_ChartDataSimpleColumnChart1
//                                                           data,
//                                                       _) =>
//                                                   data.x,
//                                           yValueMapper:
//                                               (_ChartDataSimpleColumnChart1
//                                                           data,
//                                                       _) =>
//                                                   data.y,
//                                           markerSettings: const MarkerSettings(
//                                               isVisible: true,
//                                               shape: DataMarkerType.diamond),
//                                           dataLabelSettings:
//                                               const DataLabelSettings(
//                                                   isVisible: true),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Container(
//                               margin: const EdgeInsets.only(
//                                   top: 10, bottom: 10, left: 8, right: 8),
//                               padding: const EdgeInsets.all(8),
//                               alignment: Alignment.center,
//                               height: size.height * 0.6,
//                               width: size.width * 0.99,
//                               decoration: BoxDecoration(
//                                   // shape: BoxShape.circle,
//                                   borderRadius: BorderRadius.circular(10),
//                                   boxShadow: const [
//                                     BoxShadow(
//                                         color: Color.fromARGB(255, 3, 47, 97),
//                                         blurRadius: 10,
//                                         offset: Offset(2.0, 5.0))
//                                   ],
//                                   gradient: const LinearGradient(
//                                     colors: [
//                                       Color.fromARGB(255, 255, 255, 255),
//                                       Color.fromARGB(255, 255, 255, 255),
//                                     ],
//                                   )),
//                               child: Column(
//                                 children: [
//                                   Container(
//                                     padding: const EdgeInsets.all(10),
//                                     alignment: Alignment.center,
//                                     width: size.width * 0.99,
//                                     // width: MediaQuery.of(context).size.width,
//                                     // height: 40,
//                                     decoration: const BoxDecoration(
//                                         // shape: BoxShape.circle,
//                                         //borderRadius: BorderRadius.circular(25),
//                                         boxShadow: [
//                                           BoxShadow(
//                                               color: Color.fromARGB(
//                                                   255, 3, 47, 97),
//                                               blurRadius: 5,
//                                               offset: Offset(2.0, 5.0))
//                                         ],
//                                         color:
//                                             Color.fromARGB(255, 130, 193, 245),
//                                         gradient: LinearGradient(
//                                           colors: [
//                                             AppColors.baseColor,
//                                             Color.fromARGB(255, 7, 59, 120)
//                                           ],
//                                         )),
//                                     child: const Text(
//                                       "Total Cost(\$) By Substation",
//                                       textAlign: TextAlign.left,
//                                       style: TextStyle(
//                                         color: Colors.white,
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 20,
//                                       ),
//                                     ),
//                                   ),
//                                   Expanded(
//                                     child: SfCartesianChart(
//                                       primaryXAxis: CategoryAxis(
//                                         title: AxisTitle(
//                                             text: 'SUBSTATION',
//                                             textStyle: const TextStyle(
//                                                 color: Colors.red,
//                                                 fontFamily: 'Roboto',
//                                                 fontSize: 16,
//                                                 fontStyle: FontStyle.italic,
//                                                 fontWeight: FontWeight.bold)),
//                                       ),
//                                       primaryYAxis: CategoryAxis(
//                                         title: AxisTitle(
//                                             text: 'TOTAL MILES',
//                                             textStyle: const TextStyle(
//                                                 color: Colors.red,
//                                                 fontFamily: 'Roboto',
//                                                 fontSize: 16,
//                                                 fontStyle: FontStyle.italic,
//                                                 fontWeight: FontWeight.bold)),
//                                       ),
//                                       legend: Legend(isVisible: true),
//                                       palette: const <Color>[
//                                         Color.fromARGB(255, 21, 80, 218)
//                                       ],
//                                       series: <CartesianSeries>[
//                                         ColumnSeries<
//                                             _ChartDataSimpleColumnChart2,
//                                             String>(
//                                           name: 'MILES OF LINE',
//                                           dataSource:
//                                               recreateDataTotalCostBySubstation(
//                                                   value),
//                                           xValueMapper:
//                                               (_ChartDataSimpleColumnChart2
//                                                           data,
//                                                       _) =>
//                                                   data.x,
//                                           yValueMapper:
//                                               (_ChartDataSimpleColumnChart2
//                                                           data,
//                                                       _) =>
//                                                   data.y,
//                                           markerSettings: const MarkerSettings(
//                                               isVisible: true,
//                                               shape: DataMarkerType.diamond),
//                                           dataLabelSettings:
//                                               const DataLabelSettings(
//                                                   isVisible: true),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(
//                                   bottom: 8.0, left: 8, right: 8),
//                               child: Container(
//                                 //  margin:  EdgeInsets.only(
//                                 //      top: 10, bottom: 10, left: 8, right: 8),
//                                 //  padding:  EdgeInsets.all(8),
//                                 alignment: Alignment.center,
//                                 height: size.height * 0.75,
//                                 width: size.width * 0.99,
//                                 decoration: BoxDecoration(
//                                     // shape: BoxShape.circle,
//                                     borderRadius: BorderRadius.circular(10),
//                                     boxShadow: const [
//                                       BoxShadow(
//                                           color:
//                                               AppColors.baseColor,
//                                           blurRadius: 10,
//                                           offset: Offset(2.0, 5.0))
//                                     ],
//                                     gradient: const LinearGradient(
//                                       colors: [
//                                         Color.fromARGB(255, 255, 255, 255),
//                                         Color.fromARGB(255, 255, 255, 255),
//                                       ],
//                                     )),
//                                 child: Column(
//                                   children: [
//                                     Row(
//                                       children: [
//                                         const Padding(
//                                           padding: EdgeInsets.only(
//                                               top: 8.0, left: 8),
//                                           child: Align(
//                                             alignment: Alignment.topLeft,
//                                             child: Text(
//                                               "Total Record : ",
//                                               textAlign: TextAlign.left,
//                                               style: TextStyle(
//                                                 color: AppColors.baseColor,
//                                                 fontWeight: FontWeight.bold,
//                                                 fontSize: 20,
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                         Padding(
//                                           padding:
//                                               const EdgeInsets.only(top: 8.0),
//                                           child: Text(
//                                             rowCostAnalysisViewModel
//                                                 .rowCostAnalysisList
//                                                 .data!
//                                                 .getSPMAINTENANCEANALYSIS!
//                                                 .length
//                                                 .toString(),
//                                             textAlign: TextAlign.left,
//                                             style: const TextStyle(
//                                               color: Color.fromARGB(
//                                                   255, 7, 59, 120),
//                                               fontWeight: FontWeight.bold,
//                                               fontSize: 20,
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                     Row(
//                                       children: [
//                                         Expanded(
//                                           child: Align(
//                                             alignment: Alignment.centerRight,
//                                             child: Padding(
//                                               padding: const EdgeInsets.only(
//                                                   left: 4.0,
//                                                   right: 4.0,
//                                                   top: 4,
//                                                   bottom: 4),
//                                               child: TextFormField(
//                                                 onChanged: (value) =>
//                                                     _runFilter(value),
//                                                 //  key: formkey2,
//                                                 controller: _input,
//                                                 style: const TextStyle(
//                                                     color: Color.fromARGB(
//                                                         255, 7, 59, 120),
//                                                     fontSize: 16),
//                                                 obscureText: false,

//                                                 //keyboardType: TextInputType.number,
//                                                 decoration: InputDecoration(
//                                                   border: OutlineInputBorder(
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             25),
//                                                   ),
//                                                   enabledBorder:
//                                                       OutlineInputBorder(
//                                                     borderSide:
//                                                         const BorderSide(
//                                                       color: Color.fromARGB(
//                                                           255, 23, 1, 88),
//                                                     ),
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             25),
//                                                   ),
//                                                   hintText:
//                                                       'Search your input...',
//                                                 ),
//                                                 validator: (value) {
//                                                   if (value!.isEmpty) {
//                                                     return "Please search your input";
//                                                   } else {
//                                                     return null;
//                                                   }
//                                                 },
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                     Expanded(
//                                       child: InkWell(
//                                         onTap: () {
//                                           // Navigator.pushNamed(context,
//                                           //    RoutesName.detailedServiceOrders);
//                                         },
//                                         child: ListView.builder(
//                                             itemCount: rowCostAnalysisViewModel
//                                                 .rowCostAnalysisList
//                                                 .data!
//                                                 .getSPMAINTENANCEANALYSIS!
//                                                 .length,
//                                             // itemCount: historyList.length,
//                                             itemBuilder:
//                                                 (BuildContext ctxt, int Index) {
//                                               return Row(
//                                                 children: [
//                                                   Expanded(
//                                                     flex: 1,
//                                                     child: Container(
//                                                       width:
//                                                           MediaQuery.of(context)
//                                                                   .size
//                                                                   .width *
//                                                               0.28,
//                                                       height:
//                                                           MediaQuery.of(context)
//                                                                   .size
//                                                                   .height *
//                                                               0.6,
//                                                       // height: 190,
//                                                       margin:
//                                                           const EdgeInsets.only(
//                                                               left: 4.0,
//                                                               top: 5.0,
//                                                               bottom: 5.0),
//                                                       padding:
//                                                           const EdgeInsets.all(
//                                                               8),
//                                                       decoration: BoxDecoration(
//                                                       gradient: LinearGradient(
//                                                         colors: [
//                                                           AppColors.green1
//                                                               .withOpacity(0.9),
//                                                           AppColors.green2
//                                                               .withOpacity(0.7),
//                                                           AppColors.green1
//                                                               .withOpacity(0.9),
//                                                         ],
//                                                         begin:
//                                                             Alignment.topLeft,
//                                                         end: Alignment
//                                                             .bottomRight,
//                                                       ),
//                                                       border: Border.all(
//                                                         color: Colors.white,
//                                                       ),
//                                                       borderRadius:
//                                                           const BorderRadius
//                                                               .only(
//                                                         topRight:
//                                                             Radius.circular(10),
//                                                         bottomRight:
//                                                             Radius.circular(10),
//                                                         topLeft:
//                                                             Radius.circular(10),
//                                                         bottomLeft:
//                                                             Radius.circular(10),
//                                                       ),
//                                                     ),
//                                                       child: Column(children: [
//                                                         Expanded(
//                                                           //  flex: 3,
//                                                           child: Column(
//                                                             children: [
//                                                               const Align(
//                                                                 alignment:
//                                                                     Alignment
//                                                                         .topLeft,
//                                                                 child: Text(
//                                                                   "TYPE:",
//                                                                   textAlign:
//                                                                       TextAlign
//                                                                           .left,
//                                                                   style: TextStyle(
//                                                                       fontSize:
//                                                                           12,
//                                                                       fontWeight:
//                                                                           FontWeight
//                                                                               .bold,
//                                                                       color: Colors
//                                                                           .white),
//                                                                 ),
//                                                               ),
//                                                               Align(
//                                                                 alignment:
//                                                                     Alignment
//                                                                         .topLeft,
//                                                                 child: Text(
//                                                                   (rowCostAnalysisViewModel.rowCostAnalysisList.data!.getSPMAINTENANCEANALYSIS![Index].type.toString() ==
//                                                                               'null' ||
//                                                                           rowCostAnalysisViewModel
//                                                                               .rowCostAnalysisList
//                                                                               .data!
//                                                                               .getSPMAINTENANCEANALYSIS![
//                                                                                   Index]
//                                                                               .type
//                                                                               .toString()
//                                                                               .isEmpty)
//                                                                       ? 'N/A'
//                                                                       : rowCostAnalysisViewModel
//                                                                           .rowCostAnalysisList
//                                                                           .data!
//                                                                           .getSPMAINTENANCEANALYSIS![
//                                                                               Index]
//                                                                           .type
//                                                                           .toString(),
//                                                                   textAlign:
//                                                                       TextAlign
//                                                                           .left,
//                                                                   style: const TextStyle(
//                                                                       fontSize: 12,
//                                                                       // fontWeight:
//                                                                       //     FontWeight.bold,
//                                                                       color: Colors.white),
//                                                                 ),
//                                                               ),
//                                                             ],
//                                                           ),
//                                                         ),
//                                                         Expanded(
//                                                           //  flex: 4,
//                                                           child: Column(
//                                                             children: [
//                                                               const Align(
//                                                                 alignment:
//                                                                     Alignment
//                                                                         .topLeft,
//                                                                 child: Text(
//                                                                   "JOB NO:",
//                                                                   textAlign:
//                                                                       TextAlign
//                                                                           .left,
//                                                                   style: TextStyle(
//                                                                       fontSize:
//                                                                           12,
//                                                                       fontWeight:
//                                                                           FontWeight
//                                                                               .bold,
//                                                                       color: Colors
//                                                                           .white),
//                                                                 ),
//                                                               ),
//                                                               Align(
//                                                                 alignment:
//                                                                     Alignment
//                                                                         .topLeft,
//                                                                 child: Text(
//                                                                   (rowCostAnalysisViewModel.rowCostAnalysisList.data!.getSPMAINTENANCEANALYSIS![Index].tokenNo.toString() ==
//                                                                               'null' ||
//                                                                           rowCostAnalysisViewModel
//                                                                               .rowCostAnalysisList
//                                                                               .data!
//                                                                               .getSPMAINTENANCEANALYSIS![
//                                                                                   Index]
//                                                                               .tokenNo
//                                                                               .toString()
//                                                                               .isEmpty)
//                                                                       ? 'N/A'
//                                                                       : rowCostAnalysisViewModel
//                                                                           .rowCostAnalysisList
//                                                                           .data!
//                                                                           .getSPMAINTENANCEANALYSIS![
//                                                                               Index]
//                                                                           .tokenNo
//                                                                           .toString(),
//                                                                   textAlign:
//                                                                       TextAlign
//                                                                           .left,
//                                                                   style: const TextStyle(
//                                                                       fontSize: 12,
//                                                                       // fontWeight:
//                                                                       //     FontWeight.bold,
//                                                                       color: Colors.white),
//                                                                 ),
//                                                               ),
//                                                             ],
//                                                           ),
//                                                         ),
//                                                         Expanded(
//                                                           //  flex: 3,
//                                                           child: Column(
//                                                             children: [
//                                                               const Align(
//                                                                 alignment:
//                                                                     Alignment
//                                                                         .topLeft,
//                                                                 child: Text(
//                                                                   "STATUS:",
//                                                                   textAlign:
//                                                                       TextAlign
//                                                                           .left,
//                                                                   style: TextStyle(
//                                                                       fontSize:
//                                                                           12,
//                                                                       fontWeight:
//                                                                           FontWeight
//                                                                               .bold,
//                                                                       color: Colors
//                                                                           .white),
//                                                                 ),
//                                                               ),
//                                                               Align(
//                                                                 alignment:
//                                                                     Alignment
//                                                                         .topLeft,
//                                                                 child: Text(
//                                                                   (rowCostAnalysisViewModel.rowCostAnalysisList.data!.getSPMAINTENANCEANALYSIS![Index].status.toString() ==
//                                                                               'null' ||
//                                                                           rowCostAnalysisViewModel
//                                                                               .rowCostAnalysisList
//                                                                               .data!
//                                                                               .getSPMAINTENANCEANALYSIS![
//                                                                                   Index]
//                                                                               .status
//                                                                               .toString()
//                                                                               .isEmpty)
//                                                                       ? 'N/A'
//                                                                       : rowCostAnalysisViewModel
//                                                                           .rowCostAnalysisList
//                                                                           .data!
//                                                                           .getSPMAINTENANCEANALYSIS![
//                                                                               Index]
//                                                                           .status
//                                                                           .toString(),
//                                                                   textAlign:
//                                                                       TextAlign
//                                                                           .left,
//                                                                   style: const TextStyle(
//                                                                       fontSize: 12,
//                                                                       // fontWeight:
//                                                                       //     FontWeight.bold,
//                                                                       color: Colors.white),
//                                                                 ),
//                                                               ),
//                                                             ],
//                                                           ),
//                                                         ),
//                                                         Expanded(
//                                                           //  flex: 3,
//                                                           child: Column(
//                                                             children: [
//                                                               const Align(
//                                                                 alignment:
//                                                                     Alignment
//                                                                         .topLeft,
//                                                                 child: Text(
//                                                                   "COUNTY:",
//                                                                   textAlign:
//                                                                       TextAlign
//                                                                           .left,
//                                                                   style: TextStyle(
//                                                                       fontSize:
//                                                                           12,
//                                                                       fontWeight:
//                                                                           FontWeight
//                                                                               .bold,
//                                                                       color: Colors
//                                                                           .white),
//                                                                 ),
//                                                               ),
//                                                               Align(
//                                                                 alignment:
//                                                                     Alignment
//                                                                         .topLeft,
//                                                                 child: Text(
//                                                                   (rowCostAnalysisViewModel.rowCostAnalysisList.data!.getSPMAINTENANCEANALYSIS![Index].county.toString() ==
//                                                                               'null' ||
//                                                                           rowCostAnalysisViewModel
//                                                                               .rowCostAnalysisList
//                                                                               .data!
//                                                                               .getSPMAINTENANCEANALYSIS![
//                                                                                   Index]
//                                                                               .county
//                                                                               .toString()
//                                                                               .isEmpty)
//                                                                       ? 'N/A'
//                                                                       : rowCostAnalysisViewModel
//                                                                           .rowCostAnalysisList
//                                                                           .data!
//                                                                           .getSPMAINTENANCEANALYSIS![
//                                                                               Index]
//                                                                           .county
//                                                                           .toString(),
//                                                                   textAlign:
//                                                                       TextAlign
//                                                                           .left,
//                                                                   style: const TextStyle(
//                                                                       fontSize: 12,
//                                                                       // fontWeight:
//                                                                       //     FontWeight.bold,
//                                                                       color: Colors.white),
//                                                                 ),
//                                                               ),
//                                                             ],
//                                                           ),
//                                                         ),
//                                                         Expanded(
//                                                           //  flex: 3,
//                                                           child: Column(
//                                                             children: [
//                                                               const Align(
//                                                                 alignment:
//                                                                     Alignment
//                                                                         .topLeft,
//                                                                 child: Text(
//                                                                   "SUBSTATION:",
//                                                                   textAlign:
//                                                                       TextAlign
//                                                                           .left,
//                                                                   style: TextStyle(
//                                                                       fontSize:
//                                                                           12,
//                                                                       fontWeight:
//                                                                           FontWeight
//                                                                               .bold,
//                                                                       color: Colors
//                                                                           .white),
//                                                                 ),
//                                                               ),
//                                                               Align(
//                                                                 alignment:
//                                                                     Alignment
//                                                                         .topLeft,
//                                                                 child: Text(
//                                                                   (rowCostAnalysisViewModel.rowCostAnalysisList.data!.getSPMAINTENANCEANALYSIS![Index].substation.toString() ==
//                                                                               'null' ||
//                                                                           rowCostAnalysisViewModel
//                                                                               .rowCostAnalysisList
//                                                                               .data!
//                                                                               .getSPMAINTENANCEANALYSIS![
//                                                                                   Index]
//                                                                               .substation
//                                                                               .toString()
//                                                                               .isEmpty)
//                                                                       ? 'N/A'
//                                                                       : rowCostAnalysisViewModel
//                                                                           .rowCostAnalysisList
//                                                                           .data!
//                                                                           .getSPMAINTENANCEANALYSIS![
//                                                                               Index]
//                                                                           .substation
//                                                                           .toString(),
//                                                                   textAlign:
//                                                                       TextAlign
//                                                                           .left,
//                                                                   style: const TextStyle(
//                                                                       fontSize: 12,
//                                                                       // fontWeight:
//                                                                       //     FontWeight.bold,
//                                                                       color: Colors.white),
//                                                                 ),
//                                                               ),
//                                                             ],
//                                                           ),
//                                                         ),
//                                                         Expanded(
//                                                           //  flex: 3,
//                                                           child: Column(
//                                                             children: [
//                                                               const Align(
//                                                                 alignment:
//                                                                     Alignment
//                                                                         .topLeft,
//                                                                 child: Text(
//                                                                   "CREATE DATE:",
//                                                                   textAlign:
//                                                                       TextAlign
//                                                                           .left,
//                                                                   style: TextStyle(
//                                                                       fontSize:
//                                                                           12,
//                                                                       fontWeight:
//                                                                           FontWeight
//                                                                               .bold,
//                                                                       color: Colors
//                                                                           .white),
//                                                                 ),
//                                                               ),
//                                                               Align(
//                                                                 alignment:
//                                                                     Alignment
//                                                                         .topLeft,
//                                                                 child: Text(
//                                                                   (rowCostAnalysisViewModel.rowCostAnalysisList.data!.getSPMAINTENANCEANALYSIS![Index].createDate.toString() ==
//                                                                               'null' ||
//                                                                           rowCostAnalysisViewModel
//                                                                               .rowCostAnalysisList
//                                                                               .data!
//                                                                               .getSPMAINTENANCEANALYSIS![
//                                                                                   Index]
//                                                                               .createDate
//                                                                               .toString()
//                                                                               .isEmpty)
//                                                                       ? 'N/A'
//                                                                       : rowCostAnalysisViewModel
//                                                                           .rowCostAnalysisList
//                                                                           .data!
//                                                                           .getSPMAINTENANCEANALYSIS![
//                                                                               Index]
//                                                                           .createDate
//                                                                           .toString(),
//                                                                   textAlign:
//                                                                       TextAlign
//                                                                           .left,
//                                                                   style: const TextStyle(
//                                                                       fontSize: 12,
//                                                                       // fontWeight:
//                                                                       //     FontWeight.bold,
//                                                                       color: Colors.white),
//                                                                 ),
//                                                               ),
//                                                             ],
//                                                           ),
//                                                         ),
//                                                         Expanded(
//                                                           //  flex: 3,
//                                                           child: Column(
//                                                             children: [
//                                                               InkWell(
//                                                                 onTap:
//                                                                     () async {
//                                                                         String id = '';
//               final userPreferences1 =
//                   Provider.of<UserPref>(context, listen: false);
//               UserModel data = await userPreferences1.getUser();
//               id = data.user!.id.toString();
//                                                                   // Navigator.of(context).push(
//                                                                   //     MaterialPageRoute(
//                                                                   //         builder: (BuildContext
//                                                                   //                 context) =>
//                                                                   //             MapViewAdmin(
//                                                                   //               id: rowCostAnalysisViewModel.rowCostAnalysisList.data!.getSPMAINTENANCEANALYSIS![Index].id.toString(),
//                                                                   //             )));
//                                                                   //  Navigator
//                                                                   //     .push(
//                                                                   //   context,
//                                                                   //   MaterialPageRoute(
//                                                                   //     builder:
//                                                                   //         (context) =>
//                                                                   //             MapViewPage(
//                                                                   //       url: MapUrl.getAdminEndPoint(rowCostAnalysisViewModel.rowCostAnalysisList.data!.getSPMAINTENANCEANALYSIS![Index].tokenNo
//                                                                   //                 .toString(),id),
//                                                                   //     ),
//                                                                   //   ),
//                                                                   // );

//                                                                   await browser.open(
//                                                                       url:
//                                                                           WebUri(
//                                                                               // "https://mapapi.ariespro.com/main/admin/CIVM_Map/${rowCostAnalysisViewModel.rowCostAnalysisList.data!.getSPMAINTENANCEANALYSIS![Index].tokenNo.toString()}/USRQWXH589Z"),
//                                                                               MapUrl.getAdminEndPoint(rowCostAnalysisViewModel.rowCostAnalysisList.data!.getSPMAINTENANCEANALYSIS![Index].tokenNo
//                                                                                   .toString(),id)),
//                                                                       settings: ChromeSafariBrowserSettings(
//                                                                           shareState: CustomTabsShareState
//                                                                               .SHARE_STATE_OFF,
//                                                                           barCollapsingEnabled:
//                                                                               true));
//                                                                 },
//                                                                 child: Align(
//                                                                   alignment:
//                                                                       Alignment
//                                                                           .centerLeft,
//                                                                   child:
//                                                                       Container(
//                                                                     // margin: const EdgeInsets.only(
//                                                                     //     left: 40, right: 40, bottom: 10.0),
//                                                                     padding:
//                                                                         const EdgeInsets
//                                                                             .all(
//                                                                             8),
//                                                                     alignment:
//                                                                         Alignment
//                                                                             .centerLeft,
//                                                                     width: 80,
//                                                                     // MediaQuery.of(context).size.width,
//                                                                     // height: MediaQuery.of(context).size.height * 0.4,
//                                                                     decoration: const BoxDecoration(
//                                                                         // shape: BoxShape.circle,

//                                                                         color: Color.fromARGB(255, 0, 58, 106),
//                                                                         gradient: LinearGradient(
//                                                                           colors: [
//                                                                             Color.fromARGB(
//                                                                                 255,
//                                                                                 0,
//                                                                                 79,
//                                                                                 215),
//                                                                             Colors.blue,
//                                                                             Color.fromARGB(
//                                                                                 255,
//                                                                                 0,
//                                                                                 79,
//                                                                                 215),
//                                                                           ],
//                                                                         )),
//                                                                     child:
//                                                                         const Align(
//                                                                       alignment:
//                                                                           Alignment
//                                                                               .center,
//                                                                       child:
//                                                                           Text(
//                                                                         "VIEW MAP",
//                                                                         style:
//                                                                             TextStyle(
//                                                                           color:
//                                                                               Colors.white,
//                                                                           fontWeight:
//                                                                               FontWeight.bold,
//                                                                           fontSize:
//                                                                               10,
//                                                                         ),
//                                                                       ),
//                                                                     ),
//                                                                   ),
//                                                                 ),
//                                                               )
//                                                             ],
//                                                           ),
//                                                         ),
//                                                       ]),
//                                                     ),
//                                                   ),
//                                                   Expanded(
//                                                     flex: 2,
//                                                     child: Container(
//                                                       width:
//                                                           MediaQuery.of(context)
//                                                                   .size
//                                                                   .width *
//                                                               0.25,
//                                                       height:
//                                                           MediaQuery.of(context)
//                                                                   .size
//                                                                   .height *
//                                                               0.6,
//                                                       margin:
//                                                           const EdgeInsets.only(
//                                                               right: 4.0,
//                                                               top: 5.0,
//                                                               bottom: 5.0),
//                                                       padding:
//                                                           const EdgeInsets.all(
//                                                               8),
//                                                       decoration: BoxDecoration(
//                                                           color: Colors.white,
//                                                           border: Border.all(
//                                                               color: const Color
//                                                                   .fromARGB(255,
//                                                                   7, 59, 120)),
//                                                           borderRadius:
//                                                               const BorderRadius
//                                                                   .only(
//                                                                   topRight: Radius
//                                                                       .circular(
//                                                                           10),
//                                                                   bottomRight:
//                                                                       Radius.circular(
//                                                                           10))),
//                                                       child: Column(children: [
//                                                         Row(
//                                                           children: [
//                                                             Expanded(
//                                                               child: Row(
//                                                                 children: [
//                                                                   Expanded(
//                                                                     // alignment: Alignment.topLeft,
//                                                                     child:
//                                                                         Column(
//                                                                       children: [
//                                                                         const Align(
//                                                                           alignment:
//                                                                               Alignment.topLeft,
//                                                                           child:
//                                                                               Text(
//                                                                             "FEEDER: ",
//                                                                             textAlign:
//                                                                                 TextAlign.left,
//                                                                             style:
//                                                                                 TextStyle(
//                                                                               fontSize: 12,
//                                                                               fontWeight: FontWeight.bold,
//                                                                               color: AppColors.baseColor,
//                                                                             ),
//                                                                           ),
//                                                                         ),
//                                                                         Align(
//                                                                           alignment:
//                                                                               Alignment.topLeft,
//                                                                           child:
//                                                                               Text(
//                                                                             (rowCostAnalysisViewModel.rowCostAnalysisList.data!.getSPMAINTENANCEANALYSIS![Index].fdrName.toString() == 'null' || rowCostAnalysisViewModel.rowCostAnalysisList.data!.getSPMAINTENANCEANALYSIS![Index].fdrName.toString().isEmpty)
//                                                                                 ? 'N/A'
//                                                                                 : rowCostAnalysisViewModel.rowCostAnalysisList.data!.getSPMAINTENANCEANALYSIS![Index].fdrName.toString(),
//                                                                             textAlign:
//                                                                                 TextAlign.left,
//                                                                             style:
//                                                                                 const TextStyle(
//                                                                               fontSize: 12,
//                                                                               //  fontWeight:
//                                                                               //      FontWeight.bold,
//                                                                               color: AppColors.baseColor,
//                                                                             ),
//                                                                           ),
//                                                                         ),
//                                                                       ],
//                                                                     ),
//                                                                   ),
//                                                                   Expanded(
//                                                                     // alignment: Alignment.topLeft,
//                                                                     child:
//                                                                         Column(
//                                                                       children: [
//                                                                         const Align(
//                                                                           alignment:
//                                                                               Alignment.topLeft,
//                                                                           child:
//                                                                               Text(
//                                                                             "MAINTENANCE TYPE: ",
//                                                                             textAlign:
//                                                                                 TextAlign.left,
//                                                                             style:
//                                                                                 TextStyle(
//                                                                               fontSize: 12,
//                                                                               fontWeight: FontWeight.bold,
//                                                                               color: AppColors.baseColor,
//                                                                             ),
//                                                                           ),
//                                                                         ),
//                                                                         Align(
//                                                                           alignment:
//                                                                               Alignment.topLeft,
//                                                                           child:
//                                                                               Text(
//                                                                             (rowCostAnalysisViewModel.rowCostAnalysisList.data!.getSPMAINTENANCEANALYSIS![Index].maintType.toString() == 'null' || rowCostAnalysisViewModel.rowCostAnalysisList.data!.getSPMAINTENANCEANALYSIS![Index].maintType.toString().isEmpty)
//                                                                                 ? 'N/A'
//                                                                                 : rowCostAnalysisViewModel.rowCostAnalysisList.data!.getSPMAINTENANCEANALYSIS![Index].maintType.toString(),
//                                                                             textAlign:
//                                                                                 TextAlign.left,
//                                                                             style:
//                                                                                 const TextStyle(
//                                                                               fontSize: 12,
//                                                                               //  fontWeight:
//                                                                               //      FontWeight.bold,
//                                                                               color: AppColors.baseColor,
//                                                                             ),
//                                                                           ),
//                                                                         ),
//                                                                       ],
//                                                                     ),
//                                                                   ),
//                                                                 ],
//                                                               ),
//                                                             ),
//                                                           ],
//                                                         ),
//                                                         const Divider(
//                                                           color: Colors.grey,
//                                                         ),
//                                                         Row(
//                                                           children: [
//                                                             Expanded(
//                                                               child: Row(
//                                                                 children: [
//                                                                   Expanded(
//                                                                     // alignment: Alignment.topLeft,
//                                                                     child:
//                                                                         Column(
//                                                                       children: [
//                                                                         const Align(
//                                                                           alignment:
//                                                                               Alignment.topLeft,
//                                                                           child:
//                                                                               Text(
//                                                                             "BUDGET: ",
//                                                                             textAlign:
//                                                                                 TextAlign.left,
//                                                                             style:
//                                                                                 TextStyle(
//                                                                               fontSize: 12,
//                                                                               fontWeight: FontWeight.bold,
//                                                                               color: AppColors.baseColor,
//                                                                             ),
//                                                                           ),
//                                                                         ),
//                                                                         Align(
//                                                                           alignment:
//                                                                               Alignment.topLeft,
//                                                                           child:
//                                                                               Text(
//                                                                             (rowCostAnalysisViewModel.rowCostAnalysisList.data!.getSPMAINTENANCEANALYSIS![Index].budget.toString() == 'null' || rowCostAnalysisViewModel.rowCostAnalysisList.data!.getSPMAINTENANCEANALYSIS![Index].budget.toString().isEmpty)
//                                                                                 ? 'N/A'
//                                                                                 : rowCostAnalysisViewModel.rowCostAnalysisList.data!.getSPMAINTENANCEANALYSIS![Index].budget.toString(),
//                                                                             textAlign:
//                                                                                 TextAlign.left,
//                                                                             style:
//                                                                                 const TextStyle(
//                                                                               fontSize: 12,
//                                                                               //  fontWeight:
//                                                                               //      FontWeight.bold,
//                                                                               color: AppColors.baseColor,
//                                                                             ),
//                                                                           ),
//                                                                         ),
//                                                                       ],
//                                                                     ),
//                                                                   ),
//                                                                   Expanded(
//                                                                     // alignment: Alignment.topLeft,
//                                                                     child:
//                                                                         Column(
//                                                                       children: [
//                                                                         const Align(
//                                                                           alignment:
//                                                                               Alignment.topLeft,
//                                                                           child:
//                                                                               Text(
//                                                                             "CONTRACTOR: ",
//                                                                             textAlign:
//                                                                                 TextAlign.left,
//                                                                             style:
//                                                                                 TextStyle(
//                                                                               fontSize: 12,
//                                                                               fontWeight: FontWeight.bold,
//                                                                               color: AppColors.baseColor,
//                                                                             ),
//                                                                           ),
//                                                                         ),
//                                                                         Align(
//                                                                           alignment:
//                                                                               Alignment.topLeft,
//                                                                           child:
//                                                                               Text(
//                                                                             (rowCostAnalysisViewModel.rowCostAnalysisList.data!.getSPMAINTENANCEANALYSIS![Index].contractor.toString() == 'null' || rowCostAnalysisViewModel.rowCostAnalysisList.data!.getSPMAINTENANCEANALYSIS![Index].contractor.toString().isEmpty)
//                                                                                 ? 'N/A'
//                                                                                 : rowCostAnalysisViewModel.rowCostAnalysisList.data!.getSPMAINTENANCEANALYSIS![Index].contractor.toString(),
//                                                                             textAlign:
//                                                                                 TextAlign.left,
//                                                                             style:
//                                                                                 const TextStyle(
//                                                                               fontSize: 12,
//                                                                               //  fontWeight:
//                                                                               //      FontWeight.bold,
//                                                                               color: AppColors.baseColor,
//                                                                             ),
//                                                                           ),
//                                                                         ),
//                                                                       ],
//                                                                     ),
//                                                                   ),
//                                                                 ],
//                                                               ),
//                                                             ),
//                                                           ],
//                                                         ),
//                                                         const Divider(
//                                                           color: Colors.grey,
//                                                         ),
//                                                         Row(
//                                                           children: [
//                                                             Expanded(
//                                                               child: Row(
//                                                                 children: [
//                                                                   Expanded(
//                                                                     // alignment: Alignment.topLeft,
//                                                                     child:
//                                                                         Column(
//                                                                       children: [
//                                                                         const Align(
//                                                                           alignment:
//                                                                               Alignment.topLeft,
//                                                                           child:
//                                                                               Text(
//                                                                             "TOTAL MILES: ",
//                                                                             textAlign:
//                                                                                 TextAlign.left,
//                                                                             style:
//                                                                                 TextStyle(
//                                                                               fontSize: 12,
//                                                                               fontWeight: FontWeight.bold,
//                                                                               color: AppColors.baseColor,
//                                                                             ),
//                                                                           ),
//                                                                         ),
//                                                                         Align(
//                                                                           alignment:
//                                                                               Alignment.topLeft,
//                                                                           child:
//                                                                               Text(
//                                                                             (rowCostAnalysisViewModel.rowCostAnalysisList.data!.getSPMAINTENANCEANALYSIS![Index].totalMiles.toString() == 'null' || rowCostAnalysisViewModel.rowCostAnalysisList.data!.getSPMAINTENANCEANALYSIS![Index].totalMiles.toString().isEmpty)
//                                                                                 ? 'N/A'
//                                                                                 : rowCostAnalysisViewModel.rowCostAnalysisList.data!.getSPMAINTENANCEANALYSIS![Index].totalMiles.toString(),
//                                                                             textAlign:
//                                                                                 TextAlign.left,
//                                                                             style:
//                                                                                 const TextStyle(
//                                                                               fontSize: 12,
//                                                                               //  fontWeight:
//                                                                               //      FontWeight.bold,
//                                                                               color: AppColors.baseColor,
//                                                                             ),
//                                                                           ),
//                                                                         ),
//                                                                       ],
//                                                                     ),
//                                                                   ),
//                                                                   Expanded(
//                                                                     // alignment: Alignment.topLeft,
//                                                                     child:
//                                                                         Column(
//                                                                       children: [
//                                                                         const Align(
//                                                                           alignment:
//                                                                               Alignment.topLeft,
//                                                                           child:
//                                                                               Text(
//                                                                             "CONTRACT YEAR: ",
//                                                                             textAlign:
//                                                                                 TextAlign.left,
//                                                                             style:
//                                                                                 TextStyle(
//                                                                               fontSize: 12,
//                                                                               fontWeight: FontWeight.bold,
//                                                                               color: AppColors.baseColor,
//                                                                             ),
//                                                                           ),
//                                                                         ),
//                                                                         Align(
//                                                                           alignment:
//                                                                               Alignment.topLeft,
//                                                                           child:
//                                                                               Text(
//                                                                             (rowCostAnalysisViewModel.rowCostAnalysisList.data!.getSPMAINTENANCEANALYSIS![Index].contractYear.toString() == 'null' || rowCostAnalysisViewModel.rowCostAnalysisList.data!.getSPMAINTENANCEANALYSIS![Index].contractYear.toString().isEmpty)
//                                                                                 ? 'N/A'
//                                                                                 : rowCostAnalysisViewModel.rowCostAnalysisList.data!.getSPMAINTENANCEANALYSIS![Index].contractYear.toString(),
//                                                                             textAlign:
//                                                                                 TextAlign.left,
//                                                                             style:
//                                                                                 const TextStyle(
//                                                                               fontSize: 12,
//                                                                               //  fontWeight:
//                                                                               //      FontWeight.bold,
//                                                                               color: AppColors.baseColor,
//                                                                             ),
//                                                                           ),
//                                                                         ),
//                                                                       ],
//                                                                     ),
//                                                                   ),
//                                                                 ],
//                                                               ),
//                                                             ),
//                                                           ],
//                                                         ),
//                                                         const Divider(
//                                                           color: Colors.grey,
//                                                         ),
//                                                         Row(
//                                                           children: [
//                                                             Expanded(
//                                                               child: Row(
//                                                                 children: [
//                                                                   Expanded(
//                                                                     // alignment: Alignment.topLeft,
//                                                                     child:
//                                                                         Column(
//                                                                       children: [
//                                                                         const Align(
//                                                                           alignment:
//                                                                               Alignment.topLeft,
//                                                                           child:
//                                                                               Text(
//                                                                             "CYCLE: ",
//                                                                             textAlign:
//                                                                                 TextAlign.left,
//                                                                             style:
//                                                                                 TextStyle(
//                                                                               fontSize: 12,
//                                                                               fontWeight: FontWeight.bold,
//                                                                               color: AppColors.baseColor,
//                                                                             ),
//                                                                           ),
//                                                                         ),
//                                                                         Align(
//                                                                           alignment:
//                                                                               Alignment.topLeft,
//                                                                           child:
//                                                                               Text(
//                                                                             (rowCostAnalysisViewModel.rowCostAnalysisList.data!.getSPMAINTENANCEANALYSIS![Index].cycle.toString() == 'null' || rowCostAnalysisViewModel.rowCostAnalysisList.data!.getSPMAINTENANCEANALYSIS![Index].cycle.toString().isEmpty)
//                                                                                 ? 'N/A'
//                                                                                 : rowCostAnalysisViewModel.rowCostAnalysisList.data!.getSPMAINTENANCEANALYSIS![Index].cycle.toString(),
//                                                                             textAlign:
//                                                                                 TextAlign.left,
//                                                                             style:
//                                                                                 const TextStyle(
//                                                                               fontSize: 12,
//                                                                               //  fontWeight:
//                                                                               //      FontWeight.bold,
//                                                                               color: AppColors.baseColor,
//                                                                             ),
//                                                                           ),
//                                                                         ),
//                                                                       ],
//                                                                     ),
//                                                                   ),
//                                                                   Expanded(
//                                                                     // alignment: Alignment.topLeft,
//                                                                     child:
//                                                                         Column(
//                                                                       children: [
//                                                                         const Align(
//                                                                           alignment:
//                                                                               Alignment.topLeft,
//                                                                           child:
//                                                                               Text(
//                                                                             "SERVICE STREET ADDRESS: ",
//                                                                             textAlign:
//                                                                                 TextAlign.left,
//                                                                             style:
//                                                                                 TextStyle(
//                                                                               fontSize: 12,
//                                                                               fontWeight: FontWeight.bold,
//                                                                               color: AppColors.baseColor,
//                                                                             ),
//                                                                           ),
//                                                                         ),
//                                                                         Align(
//                                                                           alignment:
//                                                                               Alignment.topLeft,
//                                                                           child:
//                                                                               Text(
//                                                                             (rowCostAnalysisViewModel.rowCostAnalysisList.data!.getSPMAINTENANCEANALYSIS![Index].streetAddress.toString() == 'null' || rowCostAnalysisViewModel.rowCostAnalysisList.data!.getSPMAINTENANCEANALYSIS![Index].streetAddress.toString().isEmpty)
//                                                                                 ? 'N/A'
//                                                                                 : rowCostAnalysisViewModel.rowCostAnalysisList.data!.getSPMAINTENANCEANALYSIS![Index].streetAddress.toString(),
//                                                                             textAlign:
//                                                                                 TextAlign.left,
//                                                                             style:
//                                                                                 const TextStyle(
//                                                                               fontSize: 12,
//                                                                               //  fontWeight:
//                                                                               //      FontWeight.bold,
//                                                                               color: AppColors.baseColor,
//                                                                             ),
//                                                                           ),
//                                                                         ),
//                                                                       ],
//                                                                     ),
//                                                                   ),
//                                                                 ],
//                                                               ),
//                                                             ),
//                                                           ],
//                                                         ),
//                                                         const Divider(
//                                                           color: Colors.grey,
//                                                         ),
//                                                         Row(
//                                                           children: [
//                                                             Expanded(
//                                                               child: Row(
//                                                                 children: [
//                                                                   Expanded(
//                                                                     // alignment: Alignment.topLeft,
//                                                                     child:
//                                                                         Column(
//                                                                       children: [
//                                                                         const Align(
//                                                                           alignment:
//                                                                               Alignment.topLeft,
//                                                                           child:
//                                                                               Text(
//                                                                             "SERVICE MAP LOCATION: ",
//                                                                             textAlign:
//                                                                                 TextAlign.left,
//                                                                             style:
//                                                                                 TextStyle(
//                                                                               fontSize: 12,
//                                                                               fontWeight: FontWeight.bold,
//                                                                               color: AppColors.baseColor,
//                                                                             ),
//                                                                           ),
//                                                                         ),
//                                                                         Align(
//                                                                           alignment:
//                                                                               Alignment.topLeft,
//                                                                           child:
//                                                                               Text(
//                                                                             (rowCostAnalysisViewModel.rowCostAnalysisList.data!.getSPMAINTENANCEANALYSIS![Index].mapLocation.toString() == 'null' || rowCostAnalysisViewModel.rowCostAnalysisList.data!.getSPMAINTENANCEANALYSIS![Index].mapLocation.toString().isEmpty)
//                                                                                 ? 'N/A'
//                                                                                 : rowCostAnalysisViewModel.rowCostAnalysisList.data!.getSPMAINTENANCEANALYSIS![Index].mapLocation.toString(),
//                                                                             textAlign:
//                                                                                 TextAlign.left,
//                                                                             style:
//                                                                                 const TextStyle(
//                                                                               fontSize: 12,
//                                                                               //  fontWeight:
//                                                                               //      FontWeight.bold,
//                                                                               color: AppColors.baseColor,
//                                                                             ),
//                                                                           ),
//                                                                         ),
//                                                                       ],
//                                                                     ),
//                                                                   ),
//                                                                   const Expanded(
//                                                                     // alignment: Alignment.topLeft,
//                                                                     child:
//                                                                         Column(
//                                                                       children: [
//                                                                         Align(
//                                                                           alignment:
//                                                                               Alignment.topLeft,
//                                                                           child:
//                                                                               Text(
//                                                                             "UPLOAD IMAGE: ",
//                                                                             textAlign:
//                                                                                 TextAlign.left,
//                                                                             style:
//                                                                                 TextStyle(
//                                                                               fontSize: 12,
//                                                                               fontWeight: FontWeight.bold,
//                                                                               color: AppColors.baseColor,
//                                                                             ),
//                                                                           ),
//                                                                         ),
//                                                                         Align(
//                                                                             alignment:
//                                                                                 Alignment.topLeft,
//                                                                             child: Icon(Icons.cancel, color: Colors.red)),
//                                                                       ],
//                                                                     ),
//                                                                   ),
//                                                                 ],
//                                                               ),
//                                                             ),
//                                                           ],
//                                                         ),
//                                                         const Divider(
//                                                           color: Colors.grey,
//                                                         ),
//                                                         Row(
//                                                           children: [
//                                                             Expanded(
//                                                               child: Row(
//                                                                 children: [
//                                                                   Expanded(
//                                                                     // alignment: Alignment.topLeft,
//                                                                     child:
//                                                                         Column(
//                                                                       children: [
//                                                                         const Align(
//                                                                           alignment:
//                                                                               Alignment.topLeft,
//                                                                           child:
//                                                                               Text(
//                                                                             "ADMIN NOTES 1: ",
//                                                                             textAlign:
//                                                                                 TextAlign.left,
//                                                                             style:
//                                                                                 TextStyle(
//                                                                               fontSize: 12,
//                                                                               fontWeight: FontWeight.bold,
//                                                                               color: AppColors.baseColor,
//                                                                             ),
//                                                                           ),
//                                                                         ),
//                                                                         Align(
//                                                                           alignment:
//                                                                               Alignment.topLeft,
//                                                                           child:
//                                                                               Text(
//                                                                             (rowCostAnalysisViewModel.rowCostAnalysisList.data!.getSPMAINTENANCEANALYSIS![Index].adminNotes1.toString() == 'null' || rowCostAnalysisViewModel.rowCostAnalysisList.data!.getSPMAINTENANCEANALYSIS![Index].adminNotes1.toString().isEmpty)
//                                                                                 ? 'N/A'
//                                                                                 : rowCostAnalysisViewModel.rowCostAnalysisList.data!.getSPMAINTENANCEANALYSIS![Index].adminNotes1.toString(),
//                                                                             textAlign:
//                                                                                 TextAlign.left,
//                                                                             style:
//                                                                                 const TextStyle(
//                                                                               fontSize: 12,
//                                                                               //  fontWeight:
//                                                                               //      FontWeight.bold,
//                                                                               color: AppColors.baseColor,
//                                                                             ),
//                                                                           ),
//                                                                         ),
//                                                                       ],
//                                                                     ),
//                                                                   ),
//                                                                   Expanded(
//                                                                     // alignment: Alignment.topLeft,
//                                                                     child:
//                                                                         Column(
//                                                                       children: [
//                                                                         const Align(
//                                                                           alignment:
//                                                                               Alignment.topLeft,
//                                                                           child:
//                                                                               Text(
//                                                                             "CONTRACTOR COMPANY: ",
//                                                                             textAlign:
//                                                                                 TextAlign.left,
//                                                                             style:
//                                                                                 TextStyle(
//                                                                               fontSize: 12,
//                                                                               fontWeight: FontWeight.bold,
//                                                                               color: AppColors.baseColor,
//                                                                             ),
//                                                                           ),
//                                                                         ),
//                                                                         Align(
//                                                                           alignment:
//                                                                               Alignment.topLeft,
//                                                                           child:
//                                                                               Text(
//                                                                             (rowCostAnalysisViewModel.rowCostAnalysisList.data!.getSPMAINTENANCEANALYSIS![Index].contactorCompany.toString() == 'null' || rowCostAnalysisViewModel.rowCostAnalysisList.data!.getSPMAINTENANCEANALYSIS![Index].contactorCompany.toString().isEmpty)
//                                                                                 ? 'N/A'
//                                                                                 : rowCostAnalysisViewModel.rowCostAnalysisList.data!.getSPMAINTENANCEANALYSIS![Index].contactorCompany.toString(),
//                                                                             textAlign:
//                                                                                 TextAlign.left,
//                                                                             style:
//                                                                                 const TextStyle(
//                                                                               fontSize: 12,
//                                                                               //  fontWeight:
//                                                                               //      FontWeight.bold,
//                                                                               color: AppColors.baseColor,
//                                                                             ),
//                                                                           ),
//                                                                         ),
//                                                                       ],
//                                                                     ),
//                                                                   ),
//                                                                 ],
//                                                               ),
//                                                             ),
//                                                           ],
//                                                         ),
//                                                         const Divider(
//                                                           color: Colors.grey,
//                                                         ),
//                                                         Row(
//                                                           children: [
//                                                             Expanded(
//                                                               child: Row(
//                                                                 children: [
//                                                                   Expanded(
//                                                                     // alignment: Alignment.topLeft,
//                                                                     child:
//                                                                         Column(
//                                                                       children: [
//                                                                         const Align(
//                                                                           alignment:
//                                                                               Alignment.topLeft,
//                                                                           child:
//                                                                               Text(
//                                                                             "DATE OF INSPECTION: ",
//                                                                             textAlign:
//                                                                                 TextAlign.left,
//                                                                             style:
//                                                                                 TextStyle(
//                                                                               fontSize: 12,
//                                                                               fontWeight: FontWeight.bold,
//                                                                               color: AppColors.baseColor,
//                                                                             ),
//                                                                           ),
//                                                                         ),
//                                                                         Align(
//                                                                           alignment:
//                                                                               Alignment.topLeft,
//                                                                           child:
//                                                                               Text(
//                                                                             (rowCostAnalysisViewModel.rowCostAnalysisList.data!.getSPMAINTENANCEANALYSIS![Index].dateOfInspection.toString() == 'null' || rowCostAnalysisViewModel.rowCostAnalysisList.data!.getSPMAINTENANCEANALYSIS![Index].dateOfInspection.toString().isEmpty)
//                                                                                 ? 'N/A'
//                                                                                 : rowCostAnalysisViewModel.rowCostAnalysisList.data!.getSPMAINTENANCEANALYSIS![Index].dateOfInspection.toString(),
//                                                                             textAlign:
//                                                                                 TextAlign.left,
//                                                                             style:
//                                                                                 const TextStyle(
//                                                                               fontSize: 12,
//                                                                               //  fontWeight:
//                                                                               //      FontWeight.bold,
//                                                                               color: AppColors.baseColor,
//                                                                             ),
//                                                                           ),
//                                                                         ),
//                                                                       ],
//                                                                     ),
//                                                                   ),
//                                                                   Expanded(
//                                                                     // alignment: Alignment.topLeft,
//                                                                     child:
//                                                                         Column(
//                                                                       children: [
//                                                                         const Align(
//                                                                           alignment:
//                                                                               Alignment.topLeft,
//                                                                           child:
//                                                                               Text(
//                                                                             "FOLLOW UP DATE: ",
//                                                                             textAlign:
//                                                                                 TextAlign.left,
//                                                                             style:
//                                                                                 TextStyle(
//                                                                               fontSize: 12,
//                                                                               fontWeight: FontWeight.bold,
//                                                                               color: AppColors.baseColor,
//                                                                             ),
//                                                                           ),
//                                                                         ),
//                                                                         Align(
//                                                                           alignment:
//                                                                               Alignment.topLeft,
//                                                                           child:
//                                                                               Text(
//                                                                             (rowCostAnalysisViewModel.rowCostAnalysisList.data!.getSPMAINTENANCEANALYSIS![Index].followUpDate.toString() == 'null' || rowCostAnalysisViewModel.rowCostAnalysisList.data!.getSPMAINTENANCEANALYSIS![Index].followUpDate.toString().isEmpty)
//                                                                                 ? 'N/A'
//                                                                                 : rowCostAnalysisViewModel.rowCostAnalysisList.data!.getSPMAINTENANCEANALYSIS![Index].followUpDate.toString(),
//                                                                             textAlign:
//                                                                                 TextAlign.left,
//                                                                             style:
//                                                                                 const TextStyle(
//                                                                               fontSize: 12,
//                                                                               //  fontWeight:
//                                                                               //      FontWeight.bold,
//                                                                               color: AppColors.baseColor,
//                                                                             ),
//                                                                           ),
//                                                                         ),
//                                                                       ],
//                                                                     ),
//                                                                   ),
//                                                                 ],
//                                                               ),
//                                                             ),
//                                                           ],
//                                                         ),
//                                                         const Divider(
//                                                           color: Colors.grey,
//                                                         ),
//                                                         Row(
//                                                           children: [
//                                                             Expanded(
//                                                               child: Row(
//                                                                 children: [
//                                                                   Expanded(
//                                                                     // alignment: Alignment.topLeft,
//                                                                     child:
//                                                                         Column(
//                                                                       children: [
//                                                                         const Align(
//                                                                           alignment:
//                                                                               Alignment.topLeft,
//                                                                           child:
//                                                                               Text(
//                                                                             "COST PER MILE: ",
//                                                                             textAlign:
//                                                                                 TextAlign.left,
//                                                                             style:
//                                                                                 TextStyle(
//                                                                               fontSize: 12,
//                                                                               fontWeight: FontWeight.bold,
//                                                                               color: AppColors.baseColor,
//                                                                             ),
//                                                                           ),
//                                                                         ),
//                                                                         Align(
//                                                                           alignment:
//                                                                               Alignment.topLeft,
//                                                                           child:
//                                                                               Text(
//                                                                             (rowCostAnalysisViewModel.rowCostAnalysisList.data!.getSPMAINTENANCEANALYSIS![Index].costPerMile.toString() == 'null' || rowCostAnalysisViewModel.rowCostAnalysisList.data!.getSPMAINTENANCEANALYSIS![Index].costPerMile.toString().isEmpty)
//                                                                                 ? 'N/A'
//                                                                                 : rowCostAnalysisViewModel.rowCostAnalysisList.data!.getSPMAINTENANCEANALYSIS![Index].costPerMile.toString(),
//                                                                             textAlign:
//                                                                                 TextAlign.left,
//                                                                             style:
//                                                                                 const TextStyle(
//                                                                               fontSize: 12,
//                                                                               //  fontWeight:
//                                                                               //      FontWeight.bold,
//                                                                               color: AppColors.baseColor,
//                                                                             ),
//                                                                           ),
//                                                                         ),
//                                                                       ],
//                                                                     ),
//                                                                   ),
//                                                                   Expanded(
//                                                                     // alignment: Alignment.topLeft,
//                                                                     child:
//                                                                         Column(
//                                                                       children: [
//                                                                         const Align(
//                                                                           alignment:
//                                                                               Alignment.topLeft,
//                                                                           child:
//                                                                               Text(
//                                                                             "TOTAL COST: ",
//                                                                             textAlign:
//                                                                                 TextAlign.left,
//                                                                             style:
//                                                                                 TextStyle(
//                                                                               fontSize: 12,
//                                                                               fontWeight: FontWeight.bold,
//                                                                               color: AppColors.baseColor,
//                                                                             ),
//                                                                           ),
//                                                                         ),
//                                                                         Align(
//                                                                           alignment:
//                                                                               Alignment.topLeft,
//                                                                           child:
//                                                                               Text(
//                                                                             (rowCostAnalysisViewModel.rowCostAnalysisList.data!.getSPMAINTENANCEANALYSIS![Index].totalCost.toString() == 'null' || rowCostAnalysisViewModel.rowCostAnalysisList.data!.getSPMAINTENANCEANALYSIS![Index].totalCost.toString().isEmpty)
//                                                                                 ? 'N/A'
//                                                                                 : rowCostAnalysisViewModel.rowCostAnalysisList.data!.getSPMAINTENANCEANALYSIS![Index].totalCost.toString(),
//                                                                             textAlign:
//                                                                                 TextAlign.left,
//                                                                             style:
//                                                                                 const TextStyle(
//                                                                               fontSize: 12,
//                                                                               //  fontWeight:
//                                                                               //      FontWeight.bold,
//                                                                               color: AppColors.baseColor,
//                                                                             ),
//                                                                           ),
//                                                                         ),
//                                                                       ],
//                                                                     ),
//                                                                   ),
//                                                                 ],
//                                                               ),
//                                                             ),
//                                                           ],
//                                                         ),
//                                                         const Divider(
//                                                           color: Colors.grey,
//                                                         ),
//                                                         Row(
//                                                           children: [
//                                                             Expanded(
//                                                               child: Row(
//                                                                 children: [
//                                                                   Expanded(
//                                                                     // alignment: Alignment.topLeft,
//                                                                     child:
//                                                                         Column(
//                                                                       children: [
//                                                                         const Align(
//                                                                           alignment:
//                                                                               Alignment.topLeft,
//                                                                           child:
//                                                                               Text(
//                                                                             "NEXT MAINT DUE: ",
//                                                                             textAlign:
//                                                                                 TextAlign.left,
//                                                                             style:
//                                                                                 TextStyle(
//                                                                               fontSize: 12,
//                                                                               fontWeight: FontWeight.bold,
//                                                                               color: AppColors.baseColor,
//                                                                             ),
//                                                                           ),
//                                                                         ),
//                                                                         Align(
//                                                                           alignment:
//                                                                               Alignment.topLeft,
//                                                                           child:
//                                                                               Text(
//                                                                             (rowCostAnalysisViewModel.rowCostAnalysisList.data!.getSPMAINTENANCEANALYSIS![Index].nextMaintDue.toString() == 'null' || rowCostAnalysisViewModel.rowCostAnalysisList.data!.getSPMAINTENANCEANALYSIS![Index].nextMaintDue.toString().isEmpty)
//                                                                                 ? 'N/A'
//                                                                                 : rowCostAnalysisViewModel.rowCostAnalysisList.data!.getSPMAINTENANCEANALYSIS![Index].nextMaintDue.toString(),
//                                                                             textAlign:
//                                                                                 TextAlign.left,
//                                                                             style:
//                                                                                 const TextStyle(
//                                                                               fontSize: 12,
//                                                                               //  fontWeight:
//                                                                               //      FontWeight.bold,
//                                                                               color: AppColors.baseColor,
//                                                                             ),
//                                                                           ),
//                                                                         ),
//                                                                       ],
//                                                                     ),
//                                                                   ),
//                                                                 ],
//                                                               ),
//                                                             ),
//                                                           ],
//                                                         ),
//                                                       ]),
//                                                     ),
//                                                   ),
//                                                 ],
//                                               );
//                                             }),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   );

//                 default:
//                   return const Text('data');
//               }
//             })));
//   }

//   void fetchData(String subStation, String fdrName, String nextMaintenanceDue) {
//     rowCostAnalysisViewModel.fetchRowCostAnalysisListApi(
//         context, subStation, fdrName, nextMaintenanceDue);
//   }

//   void _runFilter(String enteredKeyword) {
//     // List<Map<String, dynamic>> results = [];
//     if (enteredKeyword.isEmpty) {
//       // if the search field is empty or only contains white-space, we'll display all users
//       // results = listOfColumns1;
//     } else {
//       // results = listOfColumns1
//       // .where((user) =>
//       //     user["USER_NAME"]!
//       //         .toLowerCase()
//       //         .contains(enteredKeyword.toLowerCase()) ||
//       //     user["NAME"]!
//       //         .toLowerCase()
//       //         .contains(enteredKeyword.toLowerCase()) ||
//       //     user["USER_NAME"]!.contains('USER NAME'))
//       // .toList();
//       // we use the toLowerCase() method to make it case-insensitive
//     }

//     // Refresh the UI
//     setState(() {
//       // listOfColumns = results;
//     });
//   }

//   showSnackBar(String msg) {
//     final snackBar = SnackBar(
//       content: Text(msg),
//       action: SnackBarAction(
//         label: '',
//         onPressed: () {
//           // Some code to undo the change.
//         },
//       ),
//     );
//     ScaffoldMessenger.of(context).showSnackBar(snackBar);
//   }

//   List<_ChartDataSimpleColumnChart1> recreateDataTotalMilesBySubstation(
//       RowCostAnalysisViewModel value) {
//     chartDataSimpleColumnChart1.clear();

//     for (var i = 0;
//         i <
//             rowCostAnalysisViewModel.rowCostAnalysisList.data!
//                 .getSPROWCOSTANALYSISTotalMilesBySubstation!.length;
//         i++) {
//       chartDataSimpleColumnChart1.add(_ChartDataSimpleColumnChart1(
//           rowCostAnalysisViewModel.rowCostAnalysisList.data!
//               .getSPROWCOSTANALYSISTotalMilesBySubstation![i].substationName
//               .toString(),
//           double.parse(rowCostAnalysisViewModel.rowCostAnalysisList.data!
//               .getSPROWCOSTANALYSISTotalMilesBySubstation![i].totalMiles
//               .toString())));
//     }
//     return chartDataSimpleColumnChart1;
//   }

//   List<_ChartDataSimpleColumnChart2> recreateDataTotalCostBySubstation(
//       RowCostAnalysisViewModel value) {
//     chartDataSimpleColumnChart2.clear();

//     for (var i = 0;
//         i <
//             rowCostAnalysisViewModel.rowCostAnalysisList.data!
//                 .getSPROWCOSTANALYSISTotalCostBySubstation!.length;
//         i++) {
//       chartDataSimpleColumnChart2.add(_ChartDataSimpleColumnChart2(
//           rowCostAnalysisViewModel.rowCostAnalysisList.data!
//               .getSPROWCOSTANALYSISTotalCostBySubstation![i].substationName
//               .toString(),
//           double.parse(rowCostAnalysisViewModel.rowCostAnalysisList.data!
//               .getSPROWCOSTANALYSISTotalCostBySubstation![i].totalCost
//               .toString())));
//     }
//     return chartDataSimpleColumnChart2;
//   }
// }

// class _ChartDataSimpleColumnChart1 {
//   _ChartDataSimpleColumnChart1(this.x, this.y);

//   final String x;
//   final double y;
// }

// class _ChartDataSimpleColumnChart2 {
//   _ChartDataSimpleColumnChart2(this.x, this.y);

//   final String x;
//   final double y;
// }
