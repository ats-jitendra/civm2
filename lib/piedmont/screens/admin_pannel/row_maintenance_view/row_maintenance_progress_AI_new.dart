// // import 'package:CIVM/piedmont/screens/admin_pannel/map_view_admin.dart';
// import 'package:CIVM/piedmont/models/user_model.dart';
// import 'package:CIVM/piedmont/repository/map_url.dart';
// import 'package:CIVM/piedmont/screens/my_chrome_safari_map_recording.dart';
// import 'package:CIVM/piedmont/utils/user_pref.dart';
// import 'package:CIVM/utils/user_pref.dart';
// import 'package:CIVM/models/user_model.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// import 'package:CIVM/piedmont/resources/app_colors.dart';
// import 'package:pie_chart/pie_chart.dart';
// import 'package:provider/provider.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';

// import '../../../data/response/status.dart';
// // import '../../../utils/custom_toast_snackbar_progressdialog.dart';
// import '../../../view_model/maintenance_analysis_view_model.dart';

// // ignore: must_be_immutable
// class RowMaintenanceProgressAINew extends StatefulWidget {
//   const RowMaintenanceProgressAINew({Key? key}) : super(key: key);

//   @override
//   State<RowMaintenanceProgressAINew> createState() =>
//       _RowMaintenanceProgressAINewState();
// }

// class _RowMaintenanceProgressAINewState
//     extends State<RowMaintenanceProgressAINew> {
//   // ignore: prefer_typing_uninitialized_variables
//   var selectedSubstation;
//   int substationId = 0;
//   // ignore: prefer_typing_uninitialized_variables
//   var selectedFeeder;
//   int feederId = 0;
//   // ignore: prefer_typing_uninitialized_variables
//   var selectedNextMaintenanceDue;
//   int nextMaintenanceDue = 0;

//   // ignore: non_constant_identifier_names
//   final List<String> select_feeder = ['CARLTON', 'CASS', 'ITASCA', 'PINE'];
//   String? feeder;

//   // ignore: non_constant_identifier_names
//   final List<String> select_nextMaint = ['CARLTON', 'CASS', 'ITASCA', 'PINE'];
//   String? nextMaint;
//   List<_ChartDataSimpleColumnChart1> dataSimpleColumnChart1 = [];

//   // late final List<charts.Series> seriesList;
//   late final bool animate = true;

//   final TextEditingController _perdayCost = TextEditingController();
//   final TextEditingController _permonthCost = TextEditingController();
//   final TextEditingController _peryearCost = TextEditingController();
//   final TextEditingController _input = TextEditingController();
//   late final Future? myFuture;
//   var result = [];

//   // Map<String, double> dataMap = {"Closed": 25.2, "Pending": 1.15};
//   final gradientList = <List<Color>>[
//     [
//       const Color.fromARGB(255, 5, 74, 249),
//       const Color.fromARGB(255, 5, 74, 249),
//     ],
//     [
//       const Color.fromARGB(255, 245, 18, 1),
//       const Color.fromARGB(255, 245, 18, 1),
//     ],
//     [
//       Colors.orange,
//       Colors.orange,
//     ],
//   ];

//   Map<String, double> dataMap1 = {
//     "Under Performance": 73.2,
//     "Inline Performance": 25.2,
//     "Over Performance": 1.6,
//   };

//   late TooltipBehavior _tooltipBehavior1;

//   MaintenanceAnalysisViewModel maintenanceAnalysisViewModel =
//       MaintenanceAnalysisViewModel();

//   final browser = MyChromeSafariBrowser();

//   @override
//   void initState() {
//     maintenanceAnalysisViewModel.fetchMaintenanceAnanlysisListApi(
//         context, '', '', '');
//     super.initState();
//     _tooltipBehavior1 =
//         TooltipBehavior(enable: true, tooltipPosition: TooltipPosition.pointer);

//     _perdayCost.text = '0.0';
//     _permonthCost.text = '0.0';
//     _peryearCost.text = '0.0';
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//        backgroundColor:AppColors.backgroundColor,
//         appBar: AppBar(
//           iconTheme: const IconThemeData(color: Colors.white),
//           title: const Text(
//             'Row Maintenance Progress AI',
//             style: TextStyle(color: Colors.white),
//           ),
//           backgroundColor: AppColors.baseColor,
//           actions: const <Widget>[],
//         ),
//         body: ChangeNotifierProvider<MaintenanceAnalysisViewModel>(
//             create: (BuildContext context) => maintenanceAnalysisViewModel,
//             child: Consumer<MaintenanceAnalysisViewModel>(
//                 builder: (context, value, _) {
//               switch (value.maintenanceAnalysisList.status) {
//                 case Status.LOADING:
//                   return const Center(child: CircularProgressIndicator());
//                 case Status.ERROR:
//                   // return
//                   // Align(
//                   //     alignment: Alignment.topCenter,
//                   //     child: Padding(
//                   //       padding: const EdgeInsets.all(8.0),
//                   //       child: Text(
//                   //         value.maintenanceAnalysisList.message.toString(),
//                   //         style: const TextStyle(
//                   //           fontSize: 16.0,
//                   //           color: Colors.red,
//                   //           fontWeight: FontWeight.bold,
//                   //         ),
//                   //       ),
//                   //     ));

//                   // CustomToastSnackBarProgressDialog.flushBarErrorMessage(
//                   //     value.maintenanceAnalysisList.message.toString(),
//                   //     context);
//                   // _showSnackbar(context,
//                   //     value.maintenanceAnalysisList.message.toString());
//                   // return Container();
//                   return Padding(
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
//                       await maintenanceAnalysisViewModel
//                           .fetchMaintenanceAnanlysisListApi(
//                               context, '', '', '');
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
//                                                   fontWeight: FontWeight.bold,
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
//                                                 // borderRadius:
//                                                 //     BorderRadius.circular(25),
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
//                                                 items:
//                                                     maintenanceAnalysisViewModel
//                                                         .maintenanceAnalysisList
//                                                         .data!
//                                                         .findSubstations!
//                                                         .map((e) {
//                                                   return DropdownMenuItem(
//                                                     value: e.id.toString(),
//                                                     child: Text(e.substation
//                                                         .toString()),
//                                                   );
//                                                 }).toList(),
//                                                 onChanged: (val) {
//                                                   if (selectedFeeder != null ||
//                                                       selectedNextMaintenanceDue !=
//                                                           null) {
//                                                     selectedFeeder = null;
//                                                     selectedNextMaintenanceDue =
//                                                         null;
//                                                   }
//                                                   print('val');
//                                                   print(val);
//                                                   fetchData(val!, '', '');
//                                                   substationId =
//                                                       int.parse(val.toString());
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
//                                                 "Feeder",
//                                                 style: TextStyle(
//                                                   fontSize: 16.0,
//                                                   color: Color.fromARGB(
//                                                       255, 7, 59, 120),
//                                                   fontWeight: FontWeight.bold,
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
//                                                 // borderRadius:
//                                                 //     BorderRadius.circular(25),
//                                                 border: Border.all(
//                                                   color: const Color.fromARGB(
//                                                       255, 7, 59, 120),
//                                                 ),
//                                               ),
//                                               child: DropdownButtonFormField<
//                                                   String>(
//                                                 hint: const Text('-Select-'),
//                                                 dropdownColor: Colors.white,
//                                                 value: selectedFeeder,
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
//                                                 items:
//                                                     maintenanceAnalysisViewModel
//                                                         .maintenanceAnalysisList
//                                                         .data!
//                                                         .findFdrNamesBySubstation!
//                                                         .map((e) {
//                                                   return DropdownMenuItem(
//                                                     value: e.id.toString(),
//                                                     child: Text(
//                                                         e.fdrName.toString()),
//                                                   );
//                                                 }).toList(),
//                                                 onChanged: (val) {
//                                                   if (selectedNextMaintenanceDue !=
//                                                       null) {
//                                                     selectedNextMaintenanceDue =
//                                                         null;
//                                                   }
//                                                   print('val');
//                                                   print(val);
//                                                   fetchData(
//                                                       substationId.toString(),
//                                                       val!,
//                                                       '');
//                                                   feederId =
//                                                       int.parse(val.toString());
//                                                   print('111111111111111');
//                                                   // print(id.text.toString());
//                                                   setState(() {
//                                                     selectedFeeder = val;
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
//                                                 "Next Maintenance Due",
//                                                 style: TextStyle(
//                                                   fontSize: 16.0,
//                                                   color: Color.fromARGB(
//                                                       255, 7, 59, 120),
//                                                   fontWeight: FontWeight.bold,
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
//                                                 // borderRadius:
//                                                 //     BorderRadius.circular(25),
//                                                 border: Border.all(
//                                                   color: const Color.fromARGB(
//                                                       255, 7, 59, 120),
//                                                 ),
//                                               ),
//                                               child: DropdownButtonFormField<
//                                                   String>(
//                                                 hint: const Text('-Select-'),
//                                                 dropdownColor: Colors.white,
//                                                 value:
//                                                     selectedNextMaintenanceDue,
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
//                                                 items: maintenanceAnalysisViewModel
//                                                     .maintenanceAnalysisList
//                                                     .data!
//                                                     .findNextMaintDueBySubstationAndFeeder!
//                                                     .map((e) {
//                                                   return DropdownMenuItem(
//                                                     value: e.nextMaintDue
//                                                         .toString(),
//                                                     child: Text(e.nextMaintDue
//                                                         .toString()),
//                                                   );
//                                                 }).toList(),
//                                                 onChanged: (val) {
//                                                   print('val');
//                                                   print(val);
//                                                   fetchData(
//                                                       substationId.toString(),
//                                                       feederId.toString(),
//                                                       val!);
//                                                   nextMaintenanceDue =
//                                                       int.parse(val.toString());
//                                                   print('111111111111111');
//                                                   // print(id.text.toString());
//                                                   setState(() {
//                                                     selectedNextMaintenanceDue =
//                                                         val;
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
//                             Padding(
//                               padding: const EdgeInsets.only(
//                                   top: 16.0, left: 16, right: 16),
//                               child: Container(
//                                 padding: const EdgeInsets.all(10),
//                                 alignment: Alignment.center,
//                                 // width: size.width * 0.8,
//                                 // height: 40,
//                                 decoration: const BoxDecoration(
//                                     boxShadow: [
//                                       BoxShadow(
//                                           color: Color.fromARGB(255, 3, 47, 97),
//                                           blurRadius: 5,
//                                           offset: Offset(2.0, 5.0))
//                                     ],
//                                     gradient: LinearGradient(
//                                       colors: [Colors.white, Colors.white],
//                                     )),
//                                 child: Row(children: [
//                                   Align(
//                                     alignment: Alignment.centerLeft,
//                                     child: Row(
//                                       children: [
//                                         const Padding(
//                                           padding: EdgeInsets.only(left: 8.0),
//                                           child: Text(
//                                             "TOTAL MILES: ",
//                                             textAlign: TextAlign.left,
//                                             style: TextStyle(
//                                               color: Color.fromARGB(
//                                                   255, 7, 59, 120),
//                                               fontWeight: FontWeight.bold,
//                                               fontSize: 20,
//                                             ),
//                                           ),
//                                         ),
//                                         Padding(
//                                           padding:
//                                               const EdgeInsets.only(right: 8.0),
//                                           child: Text(
//                                             maintenanceAnalysisViewModel
//                                                 .maintenanceAnalysisList
//                                                 .data!
//                                                 .findAllSumOfTotalMiles![0]
//                                                 .sumOfTotalMiles!
//                                                 .toStringAsFixed(0),
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
//                                   ),
//                                 ]),
//                               ),
//                             ),
//                             Container(
//                               margin: const EdgeInsets.only(
//                                   top: 10, bottom: 10, left: 8, right: 8),
//                               padding: const EdgeInsets.all(8),
//                               alignment: Alignment.center,
//                               height: size.height * 0.55,
//                               width: size.width * 0.99,
//                               decoration: const BoxDecoration(
//                                   // shape: BoxShape.circle,
//                                   // borderRadius: BorderRadius.circular(10),
//                                   boxShadow: [
//                                     BoxShadow(
//                                         color: Color.fromARGB(255, 3, 47, 97),
//                                         blurRadius: 10,
//                                         offset: Offset(2.0, 5.0))
//                                   ],
//                                   gradient: LinearGradient(
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
//                                     child: const Row(children: [
//                                       Align(
//                                         alignment: Alignment.centerLeft,
//                                         child: Text(
//                                           "Miles By Substation/Feeder",
//                                           textAlign: TextAlign.left,
//                                           style: TextStyle(
//                                             color: Colors.white,
//                                             fontWeight: FontWeight.bold,
//                                             fontSize: 20,
//                                           ),
//                                         ),
//                                       ),
//                                     ]),
//                                   ),
//                                   Expanded(
//                                     child: SfCartesianChart(
//                                       tooltipBehavior: _tooltipBehavior1,
//                                       primaryXAxis: CategoryAxis(
//                                         title: AxisTitle(
//                                             text: 'Substation/Feeder',
//                                             textStyle: const TextStyle(
//                                                 color: Colors.red,
//                                                 fontFamily: 'Roboto',
//                                                 fontSize: 16,
//                                                 fontStyle: FontStyle.italic,
//                                                 fontWeight: FontWeight.bold)),
//                                       ),
//                                       // primaryYAxis: CategoryAxis(
//                                       //   title: AxisTitle(
//                                       //       text: 'Miles of Lines',
//                                       //       textStyle: const TextStyle(
//                                       //           color: Colors.red,
//                                       //           fontFamily: 'Roboto',
//                                       //           fontSize: 16,
//                                       //           fontStyle: FontStyle.italic,
//                                       //           fontWeight: FontWeight.bold)),
//                                       // ),
//                                       legend: Legend(isVisible: true),
//                                       palette: const <Color>[
//                                         AppColors.baseColor,
//                                       ],
//                                       series: <CartesianSeries>[
//                                         ColumnSeries<
//                                             _ChartDataSimpleColumnChart1,
//                                             String>(
//                                           name: 'MILES_OF_LINE',
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
//                               // height: size.height * 0.2,
//                               width: size.width * 0.99,
//                               decoration: const BoxDecoration(
//                                   // shape: BoxShape.circle,
//                                   // borderRadius: BorderRadius.circular(10),
//                                   boxShadow: [
//                                     BoxShadow(
//                                         color: Color.fromARGB(255, 3, 47, 97),
//                                         blurRadius: 10,
//                                         offset: Offset(2.0, 5.0))
//                                   ],
//                                   gradient: LinearGradient(
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
//                                     child: const Row(children: [
//                                       Align(
//                                         alignment: Alignment.centerLeft,
//                                         child: Text(
//                                           "Maintenance Status",
//                                           textAlign: TextAlign.left,
//                                           style: TextStyle(
//                                             color: Colors.white,
//                                             fontWeight: FontWeight.bold,
//                                             fontSize: 20,
//                                           ),
//                                         ),
//                                       ),
//                                     ]),
//                                   ),
//                                   Column(
//                                     children: [
//                                       Padding(
//                                         padding: const EdgeInsets.only(
//                                             top: 18.0, bottom: 18),
//                                         child: PieChart(
//                                           dataMap: {
//                                             (maintenanceAnalysisViewModel.maintenanceAnalysisList.data!.getSPMAINTENANCEANALYSISPROGRESS![0].status == null ||
//                                                     maintenanceAnalysisViewModel
//                                                             .maintenanceAnalysisList
//                                                             .data!
//                                                             .getSPMAINTENANCEANALYSISPROGRESS![
//                                                                 0]
//                                                             .status
//                                                             .toString() ==
//                                                         'null' ||
//                                                     maintenanceAnalysisViewModel
//                                                         .maintenanceAnalysisList
//                                                         .data!
//                                                         .getSPMAINTENANCEANALYSISPROGRESS![
//                                                             0]
//                                                         .status!
//                                                         .isEmpty)
//                                                 ? ''
//                                                 : maintenanceAnalysisViewModel
//                                                     .maintenanceAnalysisList
//                                                     .data!
//                                                     .getSPMAINTENANCEANALYSISPROGRESS![
//                                                         0]
//                                                     .status
//                                                     .toString(): (maintenanceAnalysisViewModel
//                                                             .maintenanceAnalysisList
//                                                             .data!
//                                                             .getSPMAINTENANCEANALYSISPROGRESS![0]
//                                                             .cnt ==
//                                                         null ||
//                                                     maintenanceAnalysisViewModel.maintenanceAnalysisList.data!.getSPMAINTENANCEANALYSISPROGRESS![0].cnt.toString() == 'null')
//                                                 ? 0.0
//                                                 : double.parse(maintenanceAnalysisViewModel.maintenanceAnalysisList.data!.getSPMAINTENANCEANALYSISPROGRESS![0].cnt.toString()),
//                                             (maintenanceAnalysisViewModel.maintenanceAnalysisList.data!.getSPMAINTENANCEANALYSISPROGRESS![1].status == null ||
//                                                     maintenanceAnalysisViewModel
//                                                             .maintenanceAnalysisList
//                                                             .data!
//                                                             .getSPMAINTENANCEANALYSISPROGRESS![
//                                                                 1]
//                                                             .status
//                                                             .toString() ==
//                                                         'null' ||
//                                                     maintenanceAnalysisViewModel
//                                                         .maintenanceAnalysisList
//                                                         .data!
//                                                         .getSPMAINTENANCEANALYSISPROGRESS![
//                                                             1]
//                                                         .status!
//                                                         .isEmpty)
//                                                 ? ''
//                                                 : maintenanceAnalysisViewModel
//                                                     .maintenanceAnalysisList
//                                                     .data!
//                                                     .getSPMAINTENANCEANALYSISPROGRESS![
//                                                         1]
//                                                     .status
//                                                     .toString(): (maintenanceAnalysisViewModel
//                                                             .maintenanceAnalysisList
//                                                             .data!
//                                                             .getSPMAINTENANCEANALYSISPROGRESS![1]
//                                                             .cnt ==
//                                                         null ||
//                                                     maintenanceAnalysisViewModel.maintenanceAnalysisList.data!.getSPMAINTENANCEANALYSISPROGRESS![1].cnt.toString() == 'null')
//                                                 ? 0.0
//                                                 : double.parse(maintenanceAnalysisViewModel.maintenanceAnalysisList.data!.getSPMAINTENANCEANALYSISPROGRESS![1].cnt.toString()),
//                                             (maintenanceAnalysisViewModel.maintenanceAnalysisList.data!.getSPMAINTENANCEANALYSISPROGRESS![2].status == null ||
//                                                     maintenanceAnalysisViewModel
//                                                             .maintenanceAnalysisList
//                                                             .data!
//                                                             .getSPMAINTENANCEANALYSISPROGRESS![
//                                                                 2]
//                                                             .status
//                                                             .toString() ==
//                                                         'null' ||
//                                                     maintenanceAnalysisViewModel
//                                                         .maintenanceAnalysisList
//                                                         .data!
//                                                         .getSPMAINTENANCEANALYSISPROGRESS![
//                                                             2]
//                                                         .status!
//                                                         .isEmpty)
//                                                 ? ''
//                                                 : maintenanceAnalysisViewModel
//                                                     .maintenanceAnalysisList
//                                                     .data!
//                                                     .getSPMAINTENANCEANALYSISPROGRESS![
//                                                         2]
//                                                     .status
//                                                     .toString(): (maintenanceAnalysisViewModel
//                                                             .maintenanceAnalysisList
//                                                             .data!
//                                                             .getSPMAINTENANCEANALYSISPROGRESS![2]
//                                                             .cnt ==
//                                                         null ||
//                                                     maintenanceAnalysisViewModel.maintenanceAnalysisList.data!.getSPMAINTENANCEANALYSISPROGRESS![2].cnt.toString() == 'null')
//                                                 ? 0.0
//                                                 : double.parse(maintenanceAnalysisViewModel.maintenanceAnalysisList.data!.getSPMAINTENANCEANALYSISPROGRESS![2].cnt.toString()),
//                                           },
//                                           animationDuration:
//                                               const Duration(milliseconds: 800),
//                                           chartLegendSpacing: 32,
//                                           chartRadius: MediaQuery.of(context)
//                                                   .size
//                                                   .width /
//                                               3.2,
//                                           // colorList: colorList,

//                                           initialAngleInDegree: 0,
//                                           chartType: ChartType.disc,
//                                           ringStrokeWidth: 50,
//                                           // centerText: "HYBRID",
//                                           legendOptions: const LegendOptions(
//                                             showLegendsInRow: false,
//                                             // legendPosition: LegendPosition.right,
//                                             showLegends: true,
//                                             // legendShape: _BoxShape.circle,
//                                             legendTextStyle: TextStyle(
//                                               fontWeight: FontWeight.bold,
//                                             ),
//                                           ),
//                                           chartValuesOptions:
//                                               const ChartValuesOptions(
//                                             showChartValueBackground: true,
//                                             showChartValues: true,
//                                             showChartValuesInPercentage: false,
//                                             showChartValuesOutside: false,
//                                             decimalPlaces: 1,
//                                           ),
//                                           gradientList: gradientList,
//                                           // emptyColorGradient: ---Empty Color gradient---
//                                         ),
//                                       ),
//                                     ],
//                                   )
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
//                                 height: size.height * 0.8,
//                                 width: size.width * 0.99,
//                                 decoration: const BoxDecoration(
//                                     // shape: BoxShape.circle,
//                                     // borderRadius: BorderRadius.circular(10),
//                                     boxShadow: [
//                                       BoxShadow(
//                                           color:
//                                               AppColors.baseColor,
//                                           blurRadius: 10,
//                                           offset: Offset(2.0, 5.0))
//                                     ],
//                                     gradient: LinearGradient(
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
//                                             maintenanceAnalysisViewModel
//                                                 .maintenanceAnalysisList
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
//                                                 decoration:
//                                                     const InputDecoration(
//                                                   border: OutlineInputBorder(
//                                                       // borderRadius:
//                                                       //     BorderRadius.circular(25),
//                                                       ),
//                                                   enabledBorder:
//                                                       OutlineInputBorder(
//                                                     borderSide: BorderSide(
//                                                       color: Color.fromARGB(
//                                                           255, 23, 1, 88),
//                                                     ),
//                                                     // borderRadius:
//                                                     //     BorderRadius.circular(25),
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
//                                         onTap: () {},
//                                         child: ListView.builder(
//                                             itemCount:
//                                                 maintenanceAnalysisViewModel
//                                                     .maintenanceAnalysisList
//                                                     .data!
//                                                     .getSPMAINTENANCEANALYSIS!
//                                                     .length,
//                                             // itemCount: historyList.length,
//                                             itemBuilder:
//                                                 (BuildContext ctxt, int index) {
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
//                                                               0.57,
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
//                                                                   // 'RegularMaint',
//                                                                   (maintenanceAnalysisViewModel.maintenanceAnalysisList.data!.getSPMAINTENANCEANALYSIS![index].type.toString() ==
//                                                                               'null' ||
//                                                                           maintenanceAnalysisViewModel
//                                                                               .maintenanceAnalysisList
//                                                                               .data!
//                                                                               .getSPMAINTENANCEANALYSIS![
//                                                                                   index]
//                                                                               .type!
//                                                                               .isEmpty)
//                                                                       ? 'N/A'
//                                                                       : maintenanceAnalysisViewModel
//                                                                           .maintenanceAnalysisList
//                                                                           .data!
//                                                                           .getSPMAINTENANCEANALYSIS![
//                                                                               index]
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
//                                                                   (maintenanceAnalysisViewModel.maintenanceAnalysisList.data!.getSPMAINTENANCEANALYSIS![index].tokenNo.toString() ==
//                                                                               'null' ||
//                                                                           maintenanceAnalysisViewModel
//                                                                               .maintenanceAnalysisList
//                                                                               .data!
//                                                                               .getSPMAINTENANCEANALYSIS![
//                                                                                   index]
//                                                                               .tokenNo!
//                                                                               .isEmpty)
//                                                                       ? 'N/A'
//                                                                       : maintenanceAnalysisViewModel
//                                                                           .maintenanceAnalysisList
//                                                                           .data!
//                                                                           .getSPMAINTENANCEANALYSIS![
//                                                                               index]
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
//                                                                   (maintenanceAnalysisViewModel.maintenanceAnalysisList.data!.getSPMAINTENANCEANALYSIS![index].status.toString() ==
//                                                                               'null' ||
//                                                                           maintenanceAnalysisViewModel
//                                                                               .maintenanceAnalysisList
//                                                                               .data!
//                                                                               .getSPMAINTENANCEANALYSIS![
//                                                                                   index]
//                                                                               .status!
//                                                                               .isEmpty)
//                                                                       ? 'N/A'
//                                                                       : maintenanceAnalysisViewModel
//                                                                           .maintenanceAnalysisList
//                                                                           .data!
//                                                                           .getSPMAINTENANCEANALYSIS![
//                                                                               index]
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
//                                                                   (maintenanceAnalysisViewModel.maintenanceAnalysisList.data!.getSPMAINTENANCEANALYSIS![index].substation.toString() ==
//                                                                               'null' ||
//                                                                           maintenanceAnalysisViewModel
//                                                                               .maintenanceAnalysisList
//                                                                               .data!
//                                                                               .getSPMAINTENANCEANALYSIS![
//                                                                                   index]
//                                                                               .substation!
//                                                                               .isEmpty)
//                                                                       ? 'N/A'
//                                                                       : maintenanceAnalysisViewModel
//                                                                           .maintenanceAnalysisList
//                                                                           .data!
//                                                                           .getSPMAINTENANCEANALYSIS![
//                                                                               index]
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
//                                                                   (maintenanceAnalysisViewModel.maintenanceAnalysisList.data!.getSPMAINTENANCEANALYSIS![index].createDate.toString() ==
//                                                                               'null' ||
//                                                                           maintenanceAnalysisViewModel
//                                                                               .maintenanceAnalysisList
//                                                                               .data!
//                                                                               .getSPMAINTENANCEANALYSIS![
//                                                                                   index]
//                                                                               .createDate!
//                                                                               .isEmpty)
//                                                                       ? 'N/A'
//                                                                       : maintenanceAnalysisViewModel
//                                                                           .maintenanceAnalysisList
//                                                                           .data!
//                                                                           .getSPMAINTENANCEANALYSIS![
//                                                                               index]
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
//                                                                   //               id: maintenanceAnalysisViewModel
//                                                                   //                     .maintenanceAnalysisList
//                                                                   //                     .data!
//                                                                   //                     .getSPMAINTENANCEANALYSIS![
//                                                                   //                         index]
//                                                                   //                   .id
//                                                                   //                   .toString(),
//                                                                   //             )));
//                                                                   //  Navigator
//                                                                   //             .push(
//                                                                   //           context,
//                                                                   //           MaterialPageRoute(
//                                                                   //             builder: (context) => MapViewPage(
//                                                                   //               url: MapUrl.getAdminEndPoint(maintenanceAnalysisViewModel.maintenanceAnalysisList.data!.getSPMAINTENANCEANALYSIS![index].tokenNo.toString(),id),
//                                                                   //             ),
//                                                                   //           ),
//                                                                   //         );

//                                                                   await browser.open(
//                                                                       url: WebUri(
//                                                                           // "https://mapapi.ariespro.com/main/admin/CIVM_Map/${maintenanceAnalysisViewModel.maintenanceAnalysisList.data!.getSPMAINTENANCEANALYSIS![index].tokenNo.toString()}/USRQWXH589Z"),
//                                                                         MapUrl.getAdminEndPoint(maintenanceAnalysisViewModel.maintenanceAnalysisList.data!.getSPMAINTENANCEANALYSIS![index].tokenNo.toString(),id)),
//                                                                         settings: ChromeSafariBrowserSettings(
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
//                                                               0.57,
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
//                                                                             (maintenanceAnalysisViewModel.maintenanceAnalysisList.data!.getSPMAINTENANCEANALYSIS![index].fdrName.toString() == 'null' || maintenanceAnalysisViewModel.maintenanceAnalysisList.data!.getSPMAINTENANCEANALYSIS![index].fdrName!.isEmpty)
//                                                                                 ? 'N/A'
//                                                                                 : maintenanceAnalysisViewModel.maintenanceAnalysisList.data!.getSPMAINTENANCEANALYSIS![index].fdrName.toString(),
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
//                                                                             (maintenanceAnalysisViewModel.maintenanceAnalysisList.data!.getSPMAINTENANCEANALYSIS![index].maintType.toString() == 'null' || maintenanceAnalysisViewModel.maintenanceAnalysisList.data!.getSPMAINTENANCEANALYSIS![index].maintType!.isEmpty)
//                                                                                 ? 'N/A'
//                                                                                 : maintenanceAnalysisViewModel.maintenanceAnalysisList.data!.getSPMAINTENANCEANALYSIS![index].maintType.toString(),
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
//                                                                             (maintenanceAnalysisViewModel.maintenanceAnalysisList.data!.getSPMAINTENANCEANALYSIS![index].contractor.toString() == 'null' || maintenanceAnalysisViewModel.maintenanceAnalysisList.data!.getSPMAINTENANCEANALYSIS![index].contractor!.isEmpty)
//                                                                                 ? 'N/A'
//                                                                                 : maintenanceAnalysisViewModel.maintenanceAnalysisList.data!.getSPMAINTENANCEANALYSIS![index].contractor.toString(),
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
//                                                                             (maintenanceAnalysisViewModel.maintenanceAnalysisList.data!.getSPMAINTENANCEANALYSIS![index].totalMiles.toString() == 'null' || maintenanceAnalysisViewModel.maintenanceAnalysisList.data!.getSPMAINTENANCEANALYSIS![index].totalMiles!.isEmpty)
//                                                                                 ? 'N/A'
//                                                                                 : maintenanceAnalysisViewModel.maintenanceAnalysisList.data!.getSPMAINTENANCEANALYSIS![index].totalMiles.toString(),
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
//                                                                             (maintenanceAnalysisViewModel.maintenanceAnalysisList.data!.getSPMAINTENANCEANALYSIS![index].contractYear.toString() == 'null' || maintenanceAnalysisViewModel.maintenanceAnalysisList.data!.getSPMAINTENANCEANALYSIS![index].contractYear!.isEmpty)
//                                                                                 ? 'N/A'
//                                                                                 : maintenanceAnalysisViewModel.maintenanceAnalysisList.data!.getSPMAINTENANCEANALYSIS![index].contractYear.toString(),
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
//                                                                             (maintenanceAnalysisViewModel.maintenanceAnalysisList.data!.getSPMAINTENANCEANALYSIS![index].cycle.toString() == 'null' || maintenanceAnalysisViewModel.maintenanceAnalysisList.data!.getSPMAINTENANCEANALYSIS![index].cycle!.isEmpty)
//                                                                                 ? 'N/A'
//                                                                                 : maintenanceAnalysisViewModel.maintenanceAnalysisList.data!.getSPMAINTENANCEANALYSIS![index].cycle.toString(),
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
//                                                                             (maintenanceAnalysisViewModel.maintenanceAnalysisList.data!.getSPMAINTENANCEANALYSIS![index].streetAddress.toString() == 'null' || maintenanceAnalysisViewModel.maintenanceAnalysisList.data!.getSPMAINTENANCEANALYSIS![index].streetAddress!.isEmpty)
//                                                                                 ? 'N/A'
//                                                                                 : maintenanceAnalysisViewModel.maintenanceAnalysisList.data!.getSPMAINTENANCEANALYSIS![index].streetAddress.toString(),
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
//                                                                             (maintenanceAnalysisViewModel.maintenanceAnalysisList.data!.getSPMAINTENANCEANALYSIS![index].mapLocation.toString() == 'null' || maintenanceAnalysisViewModel.maintenanceAnalysisList.data!.getSPMAINTENANCEANALYSIS![index].mapLocation!.isEmpty)
//                                                                                 ? 'N/A'
//                                                                                 : maintenanceAnalysisViewModel.maintenanceAnalysisList.data!.getSPMAINTENANCEANALYSIS![index].mapLocation.toString(),
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
//                                                                             (maintenanceAnalysisViewModel.maintenanceAnalysisList.data!.getSPMAINTENANCEANALYSIS![index].adminNotes1.toString() == 'null' || maintenanceAnalysisViewModel.maintenanceAnalysisList.data!.getSPMAINTENANCEANALYSIS![index].adminNotes1!.isEmpty)
//                                                                                 ? 'N/A'
//                                                                                 : maintenanceAnalysisViewModel.maintenanceAnalysisList.data!.getSPMAINTENANCEANALYSIS![index].adminNotes1.toString(),
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
//                                                                             (maintenanceAnalysisViewModel.maintenanceAnalysisList.data!.getSPMAINTENANCEANALYSIS![index].contractorCompny.toString() == 'null' || maintenanceAnalysisViewModel.maintenanceAnalysisList.data!.getSPMAINTENANCEANALYSIS![index].contractorCompny!.isEmpty)
//                                                                                 ? 'N/A'
//                                                                                 : maintenanceAnalysisViewModel.maintenanceAnalysisList.data!.getSPMAINTENANCEANALYSIS![index].contractorCompny.toString(),
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
//                                                                             (maintenanceAnalysisViewModel.maintenanceAnalysisList.data!.getSPMAINTENANCEANALYSIS![index].dateOfInspection.toString() == 'null' || maintenanceAnalysisViewModel.maintenanceAnalysisList.data!.getSPMAINTENANCEANALYSIS![index].dateOfInspection!.isEmpty)
//                                                                                 ? 'N/A'
//                                                                                 : maintenanceAnalysisViewModel.maintenanceAnalysisList.data!.getSPMAINTENANCEANALYSIS![index].dateOfInspection.toString(),
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
//                                                                             (maintenanceAnalysisViewModel.maintenanceAnalysisList.data!.getSPMAINTENANCEANALYSIS![index].followUpDate.toString() == 'null' || maintenanceAnalysisViewModel.maintenanceAnalysisList.data!.getSPMAINTENANCEANALYSIS![index].followUpDate!.isEmpty)
//                                                                                 ? 'N/A'
//                                                                                 : maintenanceAnalysisViewModel.maintenanceAnalysisList.data!.getSPMAINTENANCEANALYSIS![index].followUpDate.toString(),
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
//                                                                             (maintenanceAnalysisViewModel.maintenanceAnalysisList.data!.getSPMAINTENANCEANALYSIS![index].costPerMiles.toString() == 'null' || maintenanceAnalysisViewModel.maintenanceAnalysisList.data!.getSPMAINTENANCEANALYSIS![index].costPerMiles!.isEmpty)
//                                                                                 ? 'N/A'
//                                                                                 : maintenanceAnalysisViewModel.maintenanceAnalysisList.data!.getSPMAINTENANCEANALYSIS![index].costPerMiles.toString(),
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
//                                                                             (maintenanceAnalysisViewModel.maintenanceAnalysisList.data!.getSPMAINTENANCEANALYSIS![index].totalMiles.toString() == 'null' || maintenanceAnalysisViewModel.maintenanceAnalysisList.data!.getSPMAINTENANCEANALYSIS![index].totalMiles!.isEmpty)
//                                                                                 ? 'N/A'
//                                                                                 : maintenanceAnalysisViewModel.maintenanceAnalysisList.data!.getSPMAINTENANCEANALYSIS![index].totalMiles.toString(),
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
//                                                                             (maintenanceAnalysisViewModel.maintenanceAnalysisList.data!.getSPMAINTENANCEANALYSIS![index].nextMaintDue.toString() == 'null' || maintenanceAnalysisViewModel.maintenanceAnalysisList.data!.getSPMAINTENANCEANALYSIS![index].nextMaintDue!.isEmpty)
//                                                                                 ? 'N/A'
//                                                                                 : maintenanceAnalysisViewModel.maintenanceAnalysisList.data!.getSPMAINTENANCEANALYSIS![index].nextMaintDue.toString(),
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
//     maintenanceAnalysisViewModel.fetchMaintenanceAnanlysisListApi(
//         context, subStation, fdrName, nextMaintenanceDue);
//   }

//   List<_ChartDataSimpleColumnChart1> recreateDataTotalMilesBySubstation(
//       MaintenanceAnalysisViewModel value) {
//     dataSimpleColumnChart1.clear();

//     for (var i = 0;
//         i <
//             maintenanceAnalysisViewModel
//                 .maintenanceAnalysisList.data!.getSPMAINTENANCEANALYSIS!.length;
//         i++) {
//       dataSimpleColumnChart1.add(_ChartDataSimpleColumnChart1(
//           maintenanceAnalysisViewModel.maintenanceAnalysisList.data!
//               .getSPMAINTENANCEANALYSIS![i].substation
//               .toString(),
//           double.parse(maintenanceAnalysisViewModel.maintenanceAnalysisList
//               .data!.getSPMAINTENANCEANALYSIS![i].totalMiles
//               .toString())));
//     }
//     return dataSimpleColumnChart1;
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

//   DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
//       value: item,
//       child: Text(item,
//           style: const TextStyle(
//             fontWeight: FontWeight.normal,
//             fontSize: 20,
//           )));

//   Future<void> _showSnackbar(BuildContext context, String message) async {
//     await Future.delayed(
//         Duration.zero); // Delay to ensure the build is complete
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//       ),
//     );
//   }
// }

// class _ChartDataSimpleColumnChart1 {
//   _ChartDataSimpleColumnChart1(this.x, this.y);

//   final String x;
//   final double y;
//   // final Color? color;
// }

// class _ChartDataSimpleColumnChart2 {
//   _ChartDataSimpleColumnChart2(this.x, this.y);

//   final String x;
//   final double y;
//   // final Color? color;
// }
