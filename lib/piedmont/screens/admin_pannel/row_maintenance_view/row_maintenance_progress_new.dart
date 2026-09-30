// // import 'package:CIVM/piedmont/screens/admin_pannel/map_view_admin.dart';
// import 'package:CIVM/piedmont/models/user_model.dart';
// import 'package:CIVM/piedmont/repository/map_url.dart';
// import 'package:CIVM/piedmont/screens/my_chrome_safari_map_recording.dart';
// import 'package:CIVM/piedmont/utils/user_pref.dart';
// import 'package:CIVM/utils/user_pref.dart';
// import 'package:CIVM/models/user_model.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// // import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// import 'package:intl/intl.dart';
// import 'package:pie_chart/pie_chart.dart';
// import 'package:provider/provider.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';
// import '../../../data/response/status.dart';
// import '../../../view_model/row_maintenance_progress_new_view_model.dart';
// import 'package:pie_chart/pie_chart.dart' as pie_chart;
// import 'package:CIVM/piedmont/resources/app_colors.dart';

// // ignore: must_be_immutable
// class RowMaintenanceReportNew extends StatefulWidget {
//   const RowMaintenanceReportNew({Key? key}) : super(key: key);

//   @override
//   State<RowMaintenanceReportNew> createState() =>
//       _RowMaintenanceReportNewState();
// }

// class _RowMaintenanceReportNewState extends State<RowMaintenanceReportNew> {
//   // ignore: prefer_typing_uninitialized_variables
//   var selectedSubstation;
//   String substationId = '';
//   // ignore: prefer_typing_uninitialized_variables
//   var selectedFeeder;
//   String feederId = '';
//   // ignore: prefer_typing_uninitialized_variables
//   var selectedCycle;
//   String cycleId = '';
//   // ignore: prefer_typing_uninitialized_variables
//   var selectedMonth;
//   String monthId = '';
//   // ignore: prefer_typing_uninitialized_variables
//   var selectedYear;
//   String yearId = '';

//   List<_ChartDataSimpleColumnChart1> dataSimpleColumnChart1 = [];
//   List<_ChartDataSimpleColumnChart2> dataSimpleColumnChart2 = [];

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
//       const Color.fromARGB(255, 6, 46, 245),
//       const Color.fromARGB(255, 6, 46, 245),
//     ],
//     [
//       Colors.red,
//       Colors.red,
//     ],
//     [
//       Colors.purple,
//       Colors.purple,
//     ],
//     [
//       const Color.fromARGB(255, 1, 172, 7),
//       const Color.fromARGB(255, 1, 172, 7),
//     ],
//     [
//       Colors.blue,
//       Colors.blue,
//     ],
//     [
//       const Color.fromARGB(255, 248, 3, 211),
//       const Color.fromARGB(255, 248, 3, 211),
//     ],
//     [
//       Colors.yellow,
//       Colors.yellow,
//     ],
//     [
//       const Color.fromARGB(255, 1, 84, 120),
//       const Color.fromARGB(255, 1, 84, 120),
//     ],
//     [
//       const Color.fromARGB(255, 174, 14, 2),
//       const Color.fromARGB(255, 174, 14, 2),
//     ],
//     [
//       Colors.orange,
//       Colors.orange,
//     ],
//     [
//       const Color.fromARGB(255, 121, 61, 2),
//       const Color.fromARGB(255, 121, 61, 2),
//     ],
//     [
//       const Color.fromARGB(255, 1, 134, 85),
//       const Color.fromARGB(255, 1, 134, 85),
//     ],
//     [
//       const Color.fromARGB(255, 80, 1, 94),
//       const Color.fromARGB(255, 80, 1, 94),
//     ],
//     [
//       const Color.fromARGB(255, 102, 3, 147),
//       const Color.fromARGB(255, 102, 3, 147),
//     ],
//     [
//       const Color.fromARGB(255, 106, 2, 90),
//       const Color.fromARGB(255, 106, 2, 90),
//     ],
//     [
//       const Color.fromARGB(255, 120, 253, 3),
//       const Color.fromARGB(255, 120, 253, 3),
//     ],
//     [
//       const Color.fromARGB(255, 42, 35, 105),
//       const Color.fromARGB(255, 42, 35, 105),
//     ],
//     [
//       const Color.fromARGB(255, 249, 5, 119),
//       const Color.fromARGB(255, 249, 5, 119),
//     ],
//   ];

//   late TooltipBehavior _tooltipBehavior1;
//   final browser = MyChromeSafariBrowser();
//   RowMaintenanceProgressNewViewModel rowMaintenanceProgressNewViewModel =
//       RowMaintenanceProgressNewViewModel();

//   @override
//   void initState() {
//     rowMaintenanceProgressNewViewModel.fetchRowMaintenanceProgressNewListApi(
//         context, '', '', '', '', '');
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
//             'Row Maintenance Progress',
//             style: TextStyle(color: Colors.white),
//           ),
//           backgroundColor: AppColors.baseColor,
//           actions: const <Widget>[],
//         ),
//         body: ChangeNotifierProvider<RowMaintenanceProgressNewViewModel>(
//             create: (BuildContext context) =>
//                 rowMaintenanceProgressNewViewModel,
//             child: Consumer<RowMaintenanceProgressNewViewModel>(
//                 builder: (context, value, _) {
//               switch (value.rowMaintenanceProgressNewList.status) {
//                 case Status.LOADING:
//                   return const Center(child: CircularProgressIndicator());
//                 case Status.ERROR:
//                   return
//                       // CustomToastSnackBarProgressDialog.flushBarErrorMessage(
//                       //     value.rowMaintenanceProgressNewList.message.toString(),
//                       //     context);
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
//                   print(
//                       'rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSumOfTotalMilesBysubstation![0].toString()');
//                   print(rowMaintenanceProgressNewViewModel
//                       .rowMaintenanceProgressNewList
//                       .data!
//                       .getSumOfTotalMilesBysubstation![0]);
//                   return RefreshIndicator(
//                     onRefresh: () async {
//                       await rowMaintenanceProgressNewViewModel
//                           .fetchRowMaintenanceProgressNewListApi(
//                               context, '', '', '', '', '');
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
//                                                 //   BorderRadius.circular(25),
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
//                                                 items: rowMaintenanceProgressNewViewModel
//                                                     .rowMaintenanceProgressNewList
//                                                     .data!
//                                                     .getAllSubstations!
//                                                     .map((e) {
//                                                   return DropdownMenuItem(
//                                                     value:
//                                                         e.substation.toString(),
//                                                     child: Text(e.substation
//                                                         .toString()),
//                                                   );
//                                                 }).toList(),
//                                                 onChanged: (val) {
//                                                   if (selectedFeeder != null ||
//                                                       selectedCycle != null ||
//                                                       selectedYear != null ||
//                                                       selectedMonth != null) {
//                                                     selectedFeeder = null;
//                                                     selectedCycle = null;
//                                                     selectedYear = null;
//                                                     selectedMonth = null;
//                                                   }
//                                                   print('val');
//                                                   print(val);
//                                                   fetchData(
//                                                       val!, '', '', '', '');
//                                                   substationId = val.toString();
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
//                                                 //  BorderRadius.circular(25),
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
//                                                 items: rowMaintenanceProgressNewViewModel
//                                                     .rowMaintenanceProgressNewList
//                                                     .data!
//                                                     .getSPROWMAINTSUBSTIONFDRFLTRList!
//                                                     .map((e) {
//                                                   return DropdownMenuItem(
//                                                     value: e.fdrName.toString(),
//                                                     child: Text(
//                                                         e.fdrName.toString()),
//                                                   );
//                                                 }).toList(),
//                                                 onChanged: (val) {
//                                                   if (selectedCycle != null ||
//                                                       selectedYear != null ||
//                                                       selectedMonth != null) {
//                                                     selectedCycle = null;
//                                                     selectedYear = null;
//                                                     selectedMonth = null;
//                                                   }
//                                                   print('val');
//                                                   print(val);
//                                                   fetchData(substationId, val!,
//                                                       '', '', '');
//                                                   feederId = val.toString();
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
//                                                 "Cycle",
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
//                                                 //  BorderRadius.circular(25),
//                                                 border: Border.all(
//                                                   color: const Color.fromARGB(
//                                                       255, 7, 59, 120),
//                                                 ),
//                                               ),
//                                               child: DropdownButtonFormField<
//                                                   String>(
//                                                 hint: const Text('-Select-'),
//                                                 dropdownColor: Colors.white,
//                                                 value: selectedCycle,
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
//                                                 items: rowMaintenanceProgressNewViewModel
//                                                     .rowMaintenanceProgressNewList
//                                                     .data!
//                                                     .getCycleBySubstationAndFdr!
//                                                     .map((e) {
//                                                   return DropdownMenuItem(
//                                                     value: e.cycle.toString(),
//                                                     child: Text(
//                                                         e.cycle.toString()),
//                                                   );
//                                                 }).toList(),
//                                                 onChanged: (val) {
//                                                   if (selectedYear != null ||
//                                                       selectedMonth != null) {
//                                                     selectedYear = null;
//                                                     selectedMonth = null;
//                                                   }
//                                                   print('val');
//                                                   print(val);
//                                                   fetchData(substationId,
//                                                       feederId, val!, '', '');
//                                                   cycleId = val.toString();
//                                                   print('111111111111111');
//                                                   // print(id.text.toString());
//                                                   setState(() {
//                                                     selectedCycle = val;
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
//                                                 "Month",
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
//                                                 //  BorderRadius.circular(25),
//                                                 border: Border.all(
//                                                   color: const Color.fromARGB(
//                                                       255, 7, 59, 120),
//                                                 ),
//                                               ),
//                                               child: DropdownButtonFormField<
//                                                   String>(
//                                                 hint: const Text('-Select-'),
//                                                 dropdownColor: Colors.white,
//                                                 value: selectedMonth,
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
//                                                 items: rowMaintenanceProgressNewViewModel
//                                                     .rowMaintenanceProgressNewList
//                                                     .data!
//                                                     .getMonthBySubstationFdrCycle!
//                                                     .map((e) {
//                                                   return DropdownMenuItem(
//                                                     value: e.month.toString(),
//                                                     child: Text(
//                                                         e.month.toString()),
//                                                   );
//                                                 }).toList(),
//                                                 onChanged: (val) {
//                                                   if (selectedYear != null) {
//                                                     selectedYear = null;
//                                                   }
//                                                   print('val');
//                                                   print(val);
//                                                   fetchData(
//                                                       substationId,
//                                                       feederId,
//                                                       cycleId,
//                                                       val!,
//                                                       '');
//                                                   monthId = val.toString();
//                                                   print('111111111111111');
//                                                   // print(id.text.toString());
//                                                   setState(() {
//                                                     selectedMonth = val;
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
//                                                 "Year",
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
//                                                 //  BorderRadius.circular(25),
//                                                 border: Border.all(
//                                                   color: const Color.fromARGB(
//                                                       255, 7, 59, 120),
//                                                 ),
//                                               ),
//                                               child: DropdownButtonFormField<
//                                                   String>(
//                                                 hint: const Text('-Select-'),
//                                                 dropdownColor: Colors.white,
//                                                 value: selectedYear,
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
//                                                 items: rowMaintenanceProgressNewViewModel
//                                                     .rowMaintenanceProgressNewList
//                                                     .data!
//                                                     .getYearBySubstationFdrCycleMonth!
//                                                     .map((e) {
//                                                   return DropdownMenuItem(
//                                                     value: e.year.toString(),
//                                                     child:
//                                                         Text(e.year.toString()),
//                                                   );
//                                                 }).toList(),
//                                                 onChanged: (val) {
//                                                   print('val');
//                                                   print(val);
//                                                   fetchData(
//                                                       substationId,
//                                                       feederId,
//                                                       cycleId,
//                                                       monthId,
//                                                       val!);
//                                                   yearId = val.toString();
//                                                   print('111111111111111');
//                                                   // print(id.text.toString());
//                                                   setState(() {
//                                                     selectedYear = val;
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
//                                   top: 16.0, left: 10, right: 10),
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
//                                 child: Row(
//                                   children: [
//                                     Padding(
//                                       padding: EdgeInsets.only(
//                                           left: size.width * 0.15),
//                                       child: const Text(
//                                         "TOTAL MILES: ",
//                                         textAlign: TextAlign.left,
//                                         style: TextStyle(
//                                           color:
//                                               AppColors.baseColor,
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 20,
//                                         ),
//                                       ),
//                                     ),
//                                     Padding(
//                                       padding:
//                                           const EdgeInsets.only(right: 8.0),
//                                       child: Text(
//                                         (selectedSubstation == null)
//                                             ? (rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.findAllSumOfTotalMiles![0].sumOfTotalMiles == null ||
//                                                     rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.findAllSumOfTotalMiles![0].sumOfTotalMiles!.toStringAsFixed(2) ==
//                                                         'null')
//                                                 ? '0.0'
//                                                 : rowMaintenanceProgressNewViewModel
//                                                     .rowMaintenanceProgressNewList
//                                                     .data!
//                                                     .findAllSumOfTotalMiles![0]
//                                                     .sumOfTotalMiles!
//                                                     .toStringAsFixed(2)
//                                             : (selectedSubstation != null &&
//                                                     selectedFeeder == null &&
//                                                     selectedCycle == null &&
//                                                     selectedMonth == null &&
//                                                     selectedYear == null)
//                                                 ? (rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSumOfTotalMilesBysubstation == null ||
//                                                         rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSumOfTotalMilesBysubstation![0].toString() ==
//                                                             'null')
//                                                     ? '0.0'
//                                                     : rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSumOfTotalMilesBysubstation![0]
//                                                         .toStringAsFixed(2)
//                                                 : (selectedSubstation != null &&
//                                                         selectedFeeder !=
//                                                             null &&
//                                                         selectedCycle == null &&
//                                                         selectedMonth == null &&
//                                                         selectedYear == null)
//                                                     ? (rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.findSumOfTotalMileBySubstationAndFeeder![0].totalMiles == null ||
//                                                             rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.findSumOfTotalMileBySubstationAndFeeder![0].totalMiles.toString() ==
//                                                                 'null')
//                                                         ? '0.0'
//                                                         : rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.findSumOfTotalMileBySubstationAndFeeder![0].totalMiles!
//                                                             .toStringAsFixed(2)
//                                                     : (selectedSubstation != null &&
//                                                             selectedFeeder != null &&
//                                                             selectedCycle != null &&
//                                                             selectedMonth == null &&
//                                                             selectedYear == null)
//                                                         ? (rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.findSumOfTotalMileBySubstationAndFeederAndCycle![0].totalMiles == null || rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.findSumOfTotalMileBySubstationAndFeederAndCycle![0].totalMiles.toString() == 'null')
//                                                             ? '0.0'
//                                                             : rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.findSumOfTotalMileBySubstationAndFeederAndCycle![0].totalMiles!.toStringAsFixed(2)
//                                                         : (selectedSubstation != null && selectedFeeder != null && selectedCycle != null && selectedMonth != null && selectedYear == null)
//                                                             ? (rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.findSumOfTotalMilesBySubstationAndFeederCycleMonthList![0].totalMiles == null || rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.findSumOfTotalMilesBySubstationAndFeederCycleMonthList![0].totalMiles.toString() == 'null')
//                                                                 ? '0.0'
//                                                                 : rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.findSumOfTotalMilesBySubstationAndFeederCycleMonthList![0].totalMiles!.toStringAsFixed(2)
//                                                             : (rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.findSumOfTotalMilesBySubstationAndFeederCycleMonthYear![0].totalMiles == null || rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.findSumOfTotalMilesBySubstationAndFeederCycleMonthYear![0].totalMiles.toString() == 'null')
//                                                                 ? '0.0'
//                                                                 : rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.findSumOfTotalMilesBySubstationAndFeederCycleMonthYear![0].totalMiles!.toStringAsFixed(2),
//                                         textAlign: TextAlign.left,
//                                         style: const TextStyle(
//                                           color:
//                                               AppColors.baseColor,
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 20,
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                             Container(
//                               margin: const EdgeInsets.only(
//                                   top: 10, bottom: 10, left: 8, right: 8),
//                               padding: const EdgeInsets.all(8),
//                               alignment: Alignment.center,
//                               // height: size.height * 0.2,
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
//                                     child: const Row(children: [
//                                       Align(
//                                         alignment: Alignment.centerLeft,
//                                         child: Text(
//                                           "Total Miles By Maintenance Type",
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
//                                           padding: const EdgeInsets.only(
//                                               top: 30.0, bottom: 18),
//                                           child: PieChart(
//                                             dataMap: Map.fromEntries(
//                                               List.generate(
//                                                 rowMaintenanceProgressNewViewModel
//                                                     .rowMaintenanceProgressNewList
//                                                     .data!
//                                                     .getSPSMMAINTTOTALMILESBYTYPEFTRLIST!
//                                                     .length,
//                                                 (index) {
//                                                   final item =
//                                                       rowMaintenanceProgressNewViewModel
//                                                           .rowMaintenanceProgressNewList
//                                                           .data!
//                                                           .getSPSMMAINTTOTALMILESBYTYPEFTRLIST![index];
//                                                   final type =
//                                                       // ignore: unrelated_type_equality_checks
//                                                       item.type?.toString ==
//                                                               'null'
//                                                           ? ''
//                                                           : item.type
//                                                               .toString();
//                                                   final totalMiles = item
//                                                                   .totalMiles ==
//                                                               null ||
//                                                           item.totalMiles
//                                                                   .toString() ==
//                                                               'null'
//                                                       ? 0.0
//                                                       : double.parse(item
//                                                           .totalMiles
//                                                           .toString());

//                                                   return MapEntry(
//                                                       type.toString(),
//                                                       totalMiles);
//                                                 },
//                                               ),
//                                             ),
//                                             animationDuration: const Duration(
//                                                 milliseconds: 800),
//                                             chartLegendSpacing: 32,
//                                             chartRadius: MediaQuery.of(context)
//                                                     .size
//                                                     .width /
//                                                 2,
//                                             initialAngleInDegree: 0,
//                                             chartType: ChartType.disc,
//                                             ringStrokeWidth: 50,
//                                             legendOptions:
//                                                 const pie_chart.LegendOptions(
//                                               showLegendsInRow: false,
//                                               showLegends: true,
//                                               legendPosition: pie_chart
//                                                   .LegendPosition.bottom,
//                                               legendTextStyle: TextStyle(
//                                                 fontWeight: FontWeight.bold,
//                                               ),
//                                             ),
//                                             chartValuesOptions:
//                                                 const ChartValuesOptions(
//                                               showChartValueBackground: false,
//                                               showChartValues: true,
//                                               showChartValuesInPercentage:
//                                                   true, // Set this to true
//                                               showChartValuesOutside: true,
//                                               decimalPlaces: 1,
//                                             ),
//                                             gradientList: gradientList,
//                                           )),
//                                     ],
//                                   )
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
//                                     child: const Row(children: [
//                                       Align(
//                                         alignment: Alignment.centerLeft,
//                                         child: Text(
//                                           "Total Cost By Maintenance Type",
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
//                                           padding: const EdgeInsets.only(
//                                               top: 30.0, bottom: 18),
//                                           child: PieChart(
//                                             dataMap: Map.fromEntries(
//                                               List.generate(
//                                                 rowMaintenanceProgressNewViewModel
//                                                     .rowMaintenanceProgressNewList
//                                                     .data!
//                                                     .getSPSMMAINTTOTALCOSTBYTYPEFTRList!
//                                                     .length,
//                                                 (index) {
//                                                   final item =
//                                                       rowMaintenanceProgressNewViewModel
//                                                           .rowMaintenanceProgressNewList
//                                                           .data!
//                                                           .getSPSMMAINTTOTALCOSTBYTYPEFTRList![index];
//                                                   final type =
//                                                       // ignore: unrelated_type_equality_checks
//                                                       item.type?.toString ==
//                                                               'null'
//                                                           ? ''
//                                                           : item.type
//                                                               .toString();
//                                                   final totalCost = item
//                                                                   .totalCost ==
//                                                               null ||
//                                                           item.totalCost
//                                                                   .toString() ==
//                                                               'null'
//                                                       ? 0.0
//                                                       : double.parse(item
//                                                           .totalCost
//                                                           .toString());

//                                                   return MapEntry(
//                                                       type.toString(),
//                                                       totalCost);
//                                                 },
//                                               ),
//                                             ),
//                                             animationDuration: const Duration(
//                                                 milliseconds: 800),
//                                             chartLegendSpacing: 32,
//                                             chartRadius: MediaQuery.of(context)
//                                                     .size
//                                                     .width /
//                                                 2,
//                                             initialAngleInDegree: 0,
//                                             chartType: ChartType.disc,
//                                             ringStrokeWidth: 50,
//                                             legendOptions:
//                                                 const pie_chart.LegendOptions(
//                                               showLegendsInRow: false,
//                                               showLegends: true,
//                                               legendPosition: pie_chart
//                                                   .LegendPosition.bottom,
//                                               legendTextStyle: TextStyle(
//                                                 fontWeight: FontWeight.bold,
//                                               ),
//                                             ),
//                                             chartValuesOptions:
//                                                 const ChartValuesOptions(
//                                               showChartValueBackground: false,
//                                               showChartValues: true,
//                                               showChartValuesInPercentage:
//                                                   true, // Set this to true
//                                               showChartValuesOutside: true,
//                                               decimalPlaces: 1,
//                                             ),
//                                             gradientList: gradientList,
//                                           )),
//                                     ],
//                                   )
//                                 ],
//                               ),
//                             ),
//                             Container(
//                               margin: const EdgeInsets.only(
//                                   top: 10, bottom: 10, left: 8, right: 8),
//                               padding: const EdgeInsets.all(8),
//                               alignment: Alignment.center,
//                               height: size.height * 0.55,
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
//                                     child: const Row(children: [
//                                       Align(
//                                         alignment: Alignment.centerLeft,
//                                         child: Text(
//                                           "Total Miles by Maintenance Type",
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
//                                             text: 'SUBSTATION/FEEDER',
//                                             textStyle: const TextStyle(
//                                                 color: Colors.red,
//                                                 fontFamily: 'Roboto',
//                                                 fontSize: 16,
//                                                 fontStyle: FontStyle.italic,
//                                                 fontWeight: FontWeight.bold)),
//                                       ),
//                                       primaryYAxis: CategoryAxis(
//                                         title: AxisTitle(
//                                             text: 'MILES OF LINES',
//                                             textStyle: const TextStyle(
//                                                 color: Colors.red,
//                                                 fontFamily: 'Roboto',
//                                                 fontSize: 16,
//                                                 fontStyle: FontStyle.italic,
//                                                 fontWeight: FontWeight.bold)),
//                                       ),
//                                       legend: Legend(isVisible: true),
//                                       palette: const <Color>[
//                                         Color.fromARGB(255, 27, 7, 249),
//                                       ],
//                                       series: <CartesianSeries>[
//                                         ColumnSeries<
//                                             _ChartDataSimpleColumnChart1,
//                                             String>(
//                                           name: 'TOTAL MILES',
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
//                               height: size.height * 0.55,
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
//                                     child: const Row(children: [
//                                       Align(
//                                         alignment: Alignment.centerLeft,
//                                         child: Text(
//                                           "Total Cost by Maintenance Type",
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
//                                             text: 'SUBSTATION/FEEDER',
//                                             textStyle: const TextStyle(
//                                                 color: Colors.red,
//                                                 fontFamily: 'Roboto',
//                                                 fontSize: 16,
//                                                 fontStyle: FontStyle.italic,
//                                                 fontWeight: FontWeight.bold)),
//                                       ),
//                                       primaryYAxis: CategoryAxis(
//                                         title: AxisTitle(
//                                             text: 'MILES OF LINES',
//                                             textStyle: const TextStyle(
//                                                 color: Colors.red,
//                                                 fontFamily: 'Roboto',
//                                                 fontSize: 16,
//                                                 fontStyle: FontStyle.italic,
//                                                 fontWeight: FontWeight.bold)),
//                                       ),
//                                       legend: Legend(isVisible: true),
//                                       palette: const <Color>[
//                                         Color.fromARGB(255, 27, 7, 249),
//                                       ],
//                                       series: <CartesianSeries>[
//                                         ColumnSeries<
//                                             _ChartDataSimpleColumnChart2,
//                                             String>(
//                                           name: 'TOTAL COST',
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
//                                 height: size.height * 0.8,
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
//                                             rowMaintenanceProgressNewViewModel
//                                                 .rowMaintenanceProgressNewList
//                                                 .data!
//                                                 .getSPROWMAINTTBLFLTRList!
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
//                                                     _filterData(value),
//                                                 //  key: formkey2,
//                                                 controller: _input,
//                                                 style: const TextStyle(
//                                                     color: Color.fromARGB(
//                                                         255, 7, 59, 120),
//                                                     fontSize: 16),
//                                                 obscureText: false,

//                                                 keyboardType:
//                                                     TextInputType.number,
//                                                 decoration:
//                                                     const InputDecoration(
//                                                   border: OutlineInputBorder(),
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
//                                                   if (value!.toString ==
//                                                       'null') {
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
//                                     //newcode
//                                     Expanded(
//                                       child: Align(
//                                         alignment: Alignment.center,
//                                         child: ListView.builder(
//                                             itemCount:
//                                                 rowMaintenanceProgressNewViewModel
//                                                     .rowMaintenanceProgressNewList
//                                                     .data!
//                                                     .getSPROWMAINTTBLFLTRList!
//                                                     .length,
//                                             // itemCount: historyList.length,
//                                             itemBuilder:
//                                                 (BuildContext ctxt, int index) {
//                                               String? dateStringCreateDate =
//                                                   rowMaintenanceProgressNewViewModel
//                                                       .rowMaintenanceProgressNewList
//                                                       .data!
//                                                       .getSPROWMAINTTBLFLTRList![
//                                                           index]
//                                                       .createDate
//                                                       .toString();
//                                               DateTime date = DateTime.parse(
//                                                   dateStringCreateDate);
//                                               String formattedDateCreateDate =
//                                                   DateFormat('MM/dd/yyyy')
//                                                       .format(date);
//                                               return Row(
//                                                 children: [
//                                                   Padding(
//                                                     padding:
//                                                         const EdgeInsets.only(
//                                                       top: 4.0,
//                                                       bottom: 4,
//                                                       left: 4,
//                                                     ),
//                                                     child: Container(
//                                                       width:
//                                                           MediaQuery.of(context)
//                                                                   .size
//                                                                   .width *
//                                                               0.94,
//                                                       // margin:  EdgeInsets.only(
//                                                       //     top: 5.0, bottom: 5.0, left: 2,right: 2),
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
//                                                         Padding(
//                                                           padding:
//                                                               const EdgeInsets
//                                                                   .only(
//                                                                   left: 8.0),
//                                                           child: Row(
//                                                             children: [
//                                                               // Expanded(
//                                                               //   child: Column(
//                                                               //     children: [
//                                                               //       const Align(
//                                                               //         alignment:
//                                                               //             Alignment
//                                                               //                 .topLeft,
//                                                               //         child: Text(
//                                                               //           "EDIT: ",
//                                                               //           textAlign:
//                                                               //               TextAlign
//                                                               //                   .left,
//                                                               //           style:
//                                                               //               TextStyle(
//                                                               //             fontSize:
//                                                               //                 12,
//                                                               //             fontWeight:
//                                                               //                 FontWeight.bold,
//                                                               //             color: Colors
//                                                               //                 .white,
//                                                               //           ),
//                                                               //         ),
//                                                               //       ),
//                                                               //       InkWell(
//                                                               //           onTap:
//                                                               //               () {
//                                                               //             if (rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].maintType == 'RegularMaint' &&
//                                                               //                 rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].rowYear !=
//                                                               //                     '' &&
//                                                               //                 rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].rowYear !=
//                                                               //                     'N/A') {
//                                                               //               Navigator.push(
//                                                               //                   context,
//                                                               //                   MaterialPageRoute(
//                                                               //                       builder: (context) => AddNewRowMaintenancePlan(
//                                                               //                             tokenNo: rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].tokenNo == null ? '' : rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].tokenNo.toString(),
//                                                               //                             index: '0',
//                                                               //                             nextMaintYear: rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].nextMaintDue == null ? '' : rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].nextMaintDue.toString(),
//                                                               //                             subStation: rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].substationName == null ? '' : rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].substationName.toString(),
//                                                               //                             feeder: rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].fdrName == null ? '' : rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].fdrName.toString(),
//                                                               //                             maintType: rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].maintType == null ? '' : rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].maintType.toString(),
//                                                               //                             totalMiles: rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].totalMiles == null ? '' : rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].totalMiles.toString(),
//                                                               //                             totalCost: rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].totalCost == null ? '' : rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].totalCost.toString(),
//                                                               //                             costPerMile: rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].costPerMiles == null ? '' : rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].costPerMiles.toString(),
//                                                               //                             budgetType: rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].budgetType == null ? '' : rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].budgetType.toString(),
//                                                               //                             contractRowYear: rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].contractYear == null ? '' : rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].contractYear.toString(),
//                                                               //                             rowCycle: rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].cycle == null ? '' : rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].cycle.toString(),
//                                                               //                             rowYear: rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].rowYear == null ? '' : rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].rowYear.toString(),
//                                                               //                             contractorCompany: rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].contractorCompny == null ? '' : rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].contractorCompny.toString(),
//                                                               //                             assignForeman: rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].contractorName == null ? '' : rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].contractorName.toString(),
//                                                               //                           )));
//                                                               //             } else if (rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].maintType == 'RegularMaint' &&
//                                                               //                 rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].rowYear ==
//                                                               //                     '' &&
//                                                               //                 rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].rowYear !=
//                                                               //                     'N/A') {
//                                                               //               Navigator.push(
//                                                               //                   context,
//                                                               //                   MaterialPageRoute(
//                                                               //                       builder: (context) => AddNewRowMaintenancePlan(
//                                                               //                             tokenNo: rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].tokenNo == null ? '' : rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].tokenNo.toString(),
//                                                               //                             index: '1',
//                                                               //                             nextMaintYear: rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].nextMaintDue == null ? '' : rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].nextMaintDue.toString(),
//                                                               //                             subStation: rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].substationName == null ? '' : rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].substationName.toString(),
//                                                               //                             feeder: rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].fdrName == null ? '' : rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].fdrName.toString(),
//                                                               //                             maintType: rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].maintType == null ? '' : rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].maintType.toString(),
//                                                               //                             totalMiles: rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].totalMiles == null ? '' : rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].totalMiles.toString(),
//                                                               //                             totalCost: rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].totalCost == null ? '' : rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].totalCost.toString(),
//                                                               //                             costPerMile: rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].costPerMiles == null ? '' : rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].costPerMiles.toString(),
//                                                               //                             budgetType: rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].budgetType == null ? '' : rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].budgetType.toString(),
//                                                               //                             contractRowYear: rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].contractYear == null ? '' : rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].contractYear.toString(),
//                                                               //                             rowCycle: rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].cycle == null ? '' : rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].cycle.toString(),
//                                                               //                             rowYear: rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].rowYear == null ? '' : rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].rowYear.toString(),
//                                                               //                             contractorCompany: rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].contractorCompny == null ? '' : rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].contractorCompny.toString(),
//                                                               //                             assignForeman: rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].contractorName == null ? '' : rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].contractorName.toString(),
//                                                               //                           )));
//                                                               //             } else {
//                                                               //               Navigator.of(context).push(MaterialPageRoute(
//                                                               //                   builder: (BuildContext context) => LCPCreateOrder(
//                                                               //                         tokenNo: rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].tokenNo == null ? '' : rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].tokenNo.toString(),
//                                                               //                         subStation: (rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].substationName == null) ? '' : rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].substationName.toString(),
//                                                               //                         feeder: (rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].fdrName == null) ? '' : rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].fdrName.toString(),
//                                                               //                         serviceStreetAddress: (rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].streetAddress == null || rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].streetAddress == 'N/A') ? '' : rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].streetAddress.toString(),
//                                                               //                         serviceMapLocation: (rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].mapLocation == null || rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].mapLocation == 'N/A') ? '' : rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].mapLocation.toString(),
//                                                               //                         notes: (rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].adminNotes1 == null) ? '' : rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].adminNotes1.toString(),
//                                                               //                         type: (rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].type == null) ? '' : rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].type.toString(),
//                                                               //                         maintType: (rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].maintType == null) ? '' : rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].maintType.toString(),
//                                                               //                         contractorCompany: (rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].contractorCompny == null) ? '' : rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].contractorCompny.toString(),
//                                                               //                         assignForeman: rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].contractorName == null ? '' : rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].contractorName.toString(),
//                                                               //                         estimatedCost: rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].estCost == null ? '' : rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].estCost.toString(),
//                                                               //                         estimatedTime: rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].estTime == null ? '' : rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].estTime.toString(),
//                                                               //                         actualCost: rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].actualCost == null ? '' : rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].actualCost.toString(),
//                                                               //                       )));
//                                                               //             }
//                                                               //           },
//                                                               //           child:
//                                                               //               const Align(
//                                                               //             alignment:
//                                                               //                 Alignment.topLeft,
//                                                               //             child:
//                                                               //                 Icon(
//                                                               //               Icons
//                                                               //                   .edit,
//                                                               //               color: Color.fromARGB(
//                                                               //                   255,
//                                                               //                   151,
//                                                               //                   249,
//                                                               //                   154),
//                                                               //             ),
//                                                               //           )),
//                                                               //     ],
//                                                               //   ),
//                                                               // ),
//                                                               Expanded(
//                                                                 // alignment: Alignment.topLeft,
//                                                                 child: Column(
//                                                                   children: [
//                                                                     const Align(
//                                                                       alignment:
//                                                                           Alignment
//                                                                               .topLeft,
//                                                                       child:
//                                                                           Text(
//                                                                         "TYPE: ",
//                                                                         textAlign:
//                                                                             TextAlign.left,
//                                                                         style:
//                                                                             TextStyle(
//                                                                           fontSize:
//                                                                               12,
//                                                                           fontWeight:
//                                                                               FontWeight.bold,
//                                                                           color:
//                                                                               Colors.white,
//                                                                         ),
//                                                                       ),
//                                                                     ),
//                                                                     Align(
//                                                                       alignment:
//                                                                           Alignment
//                                                                               .topLeft,
//                                                                       child:
//                                                                           Text(
//                                                                         (rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].maintType == null ||
//                                                                                 rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].maintType.toString() == 'null')
//                                                                             ? 'N/A'
//                                                                             : rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].maintType.toString(),
//                                                                         textAlign:
//                                                                             TextAlign.left,
//                                                                         style:
//                                                                             const TextStyle(
//                                                                           fontSize:
//                                                                               12,
//                                                                           //  fontWeight:
//                                                                           //      FontWeight.bold,
//                                                                           color:
//                                                                               Colors.white,
//                                                                         ),
//                                                                       ),
//                                                                     ),
//                                                                   ],
//                                                                 ),
//                                                               ),
//                                                               Expanded(
//                                                                 // alignment: Alignment.topLeft,
//                                                                 child: Column(
//                                                                   children: [
//                                                                     const Align(
//                                                                       alignment:
//                                                                           Alignment
//                                                                               .topLeft,
//                                                                       child:
//                                                                           Text(
//                                                                         "JOB NO: ",
//                                                                         textAlign:
//                                                                             TextAlign.left,
//                                                                         style:
//                                                                             TextStyle(
//                                                                           fontSize:
//                                                                               12,
//                                                                           fontWeight:
//                                                                               FontWeight.bold,
//                                                                           color:
//                                                                               Colors.white,
//                                                                         ),
//                                                                       ),
//                                                                     ),
//                                                                     Align(
//                                                                       alignment:
//                                                                           Alignment
//                                                                               .topLeft,
//                                                                       child:
//                                                                           Text(
//                                                                         (rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].tokenNo == null ||
//                                                                                 rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].tokenNo.toString() == 'null')
//                                                                             ? 'N/A'
//                                                                             : rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].tokenNo.toString(),
//                                                                         textAlign:
//                                                                             TextAlign.left,
//                                                                         style:
//                                                                             const TextStyle(
//                                                                           fontSize:
//                                                                               12,
//                                                                           //  fontWeight:
//                                                                           //      FontWeight.bold,
//                                                                           color:
//                                                                               Colors.white,
//                                                                         ),
//                                                                       ),
//                                                                     ),
//                                                                   ],
//                                                                 ),
//                                                               ),
//                                                               Expanded(
//                                                                 // alignment: Alignment.topLeft,
//                                                                 child: Column(
//                                                                   children: [
//                                                                     const Align(
//                                                                       alignment:
//                                                                           Alignment
//                                                                               .topLeft,
//                                                                       child:
//                                                                           Text(
//                                                                         "STATUS: ",
//                                                                         textAlign:
//                                                                             TextAlign.left,
//                                                                         style:
//                                                                             TextStyle(
//                                                                           fontSize:
//                                                                               12,
//                                                                           fontWeight:
//                                                                               FontWeight.bold,
//                                                                           color:
//                                                                               Colors.white,
//                                                                         ),
//                                                                       ),
//                                                                     ),
//                                                                     Align(
//                                                                       alignment:
//                                                                           Alignment
//                                                                               .topLeft,
//                                                                       child:
//                                                                           Text(
//                                                                         rowMaintenanceProgressNewViewModel
//                                                                             .rowMaintenanceProgressNewList
//                                                                             .data!
//                                                                             .getSPROWMAINTTBLFLTRList![index]
//                                                                             .status
//                                                                             .toString(),
//                                                                         // (rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].status.toString() ==
//                                                                         //         'RegularMaint')
//                                                                         //     ? 'PENDING'
//                                                                         //     : '',
//                                                                         textAlign:
//                                                                             TextAlign.left,
//                                                                         style: const TextStyle(
//                                                                             fontSize: 12,
//                                                                             // fontWeight:
//                                                                             //     FontWeight.bold,
//                                                                             color: Colors.white),
//                                                                       ),
//                                                                     ),
//                                                                   ],
//                                                                 ),
//                                                               ),
//                                                             ],
//                                                           ),
//                                                         ),
//                                                         const Divider(
//                                                           color: Colors.grey,
//                                                         ),
//                                                         Padding(
//                                                           padding:
//                                                               const EdgeInsets
//                                                                   .only(
//                                                                   left: 8.0),
//                                                           child: Row(
//                                                             children: [
//                                                               Expanded(
//                                                                 // alignment: Alignment.topLeft,
//                                                                 child: Column(
//                                                                   children: [
//                                                                     const Align(
//                                                                       alignment:
//                                                                           Alignment
//                                                                               .topLeft,
//                                                                       child:
//                                                                           Text(
//                                                                         "SUBSTATION: ",
//                                                                         textAlign:
//                                                                             TextAlign.left,
//                                                                         style:
//                                                                             TextStyle(
//                                                                           fontSize:
//                                                                               12,
//                                                                           fontWeight:
//                                                                               FontWeight.bold,
//                                                                           color:
//                                                                               Colors.white,
//                                                                         ),
//                                                                       ),
//                                                                     ),
//                                                                     Align(
//                                                                       alignment:
//                                                                           Alignment
//                                                                               .topLeft,
//                                                                       child:
//                                                                           Text(
//                                                                         (rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].substationName == null ||
//                                                                                 rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].substationName.toString() == 'null')
//                                                                             ? 'N/A'
//                                                                             : rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].substationName.toString(),
//                                                                         textAlign:
//                                                                             TextAlign.left,
//                                                                         style:
//                                                                             const TextStyle(
//                                                                           fontSize:
//                                                                               12,
//                                                                           //  fontWeight:
//                                                                           //      FontWeight.bold,
//                                                                           color:
//                                                                               Colors.white,
//                                                                         ),
//                                                                       ),
//                                                                     ),
//                                                                   ],
//                                                                 ),
//                                                               ),
//                                                               Expanded(
//                                                                 // alignment: Alignment.topLeft,
//                                                                 child: Column(
//                                                                   children: [
//                                                                     const Align(
//                                                                       alignment:
//                                                                           Alignment
//                                                                               .topLeft,
//                                                                       child:
//                                                                           Text(
//                                                                         "FEEDER: ",
//                                                                         textAlign:
//                                                                             TextAlign.left,
//                                                                         style:
//                                                                             TextStyle(
//                                                                           fontSize:
//                                                                               12,
//                                                                           fontWeight:
//                                                                               FontWeight.bold,
//                                                                           color:
//                                                                               Colors.white,
//                                                                         ),
//                                                                       ),
//                                                                     ),
//                                                                     Align(
//                                                                       alignment:
//                                                                           Alignment
//                                                                               .topLeft,
//                                                                       child:
//                                                                           Text(
//                                                                         (rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].fdrName == null ||
//                                                                                 rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].fdrName.toString() == 'null')
//                                                                             ? 'N/A'
//                                                                             : rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].fdrName.toString(),
//                                                                         textAlign:
//                                                                             TextAlign.left,
//                                                                         style:
//                                                                             const TextStyle(
//                                                                           fontSize:
//                                                                               12,
//                                                                           //  fontWeight:
//                                                                           //      FontWeight.bold,
//                                                                           color:
//                                                                               Colors.white,
//                                                                         ),
//                                                                       ),
//                                                                     ),
//                                                                   ],
//                                                                 ),
//                                                               ),
//                                                               Expanded(
//                                                                 // alignment: Alignment.topLeft,
//                                                                 child: Column(
//                                                                   children: [
//                                                                     const Align(
//                                                                       alignment:
//                                                                           Alignment
//                                                                               .topLeft,
//                                                                       child:
//                                                                           Text(
//                                                                         "MAINTENANCE TYPE: ",
//                                                                         textAlign:
//                                                                             TextAlign.left,
//                                                                         style:
//                                                                             TextStyle(
//                                                                           fontSize:
//                                                                               12,
//                                                                           fontWeight:
//                                                                               FontWeight.bold,
//                                                                           color:
//                                                                               Colors.white,
//                                                                         ),
//                                                                       ),
//                                                                     ),
//                                                                     Align(
//                                                                       alignment:
//                                                                           Alignment
//                                                                               .topLeft,
//                                                                       child:
//                                                                           Text(
//                                                                         (rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].type == null ||
//                                                                                 rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].type.toString() == 'null')
//                                                                             ? 'N/A'
//                                                                             : rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].type.toString(),
//                                                                         textAlign:
//                                                                             TextAlign.left,
//                                                                         style:
//                                                                             const TextStyle(
//                                                                           fontSize:
//                                                                               12,
//                                                                           //  fontWeight:
//                                                                           //      FontWeight.bold,
//                                                                           color:
//                                                                               Colors.white,
//                                                                         ),
//                                                                       ),
//                                                                     ),
//                                                                   ],
//                                                                 ),
//                                                               ),
//                                                             ],
//                                                           ),
//                                                         ),
//                                                         const Divider(
//                                                           color: Colors.grey,
//                                                         ),
//                                                         Padding(
//                                                           padding:
//                                                               const EdgeInsets
//                                                                   .only(
//                                                                   left: 8.0),
//                                                           child: Row(
//                                                             children: [
//                                                               Expanded(
//                                                                 // alignment: Alignment.topLeft,
//                                                                 child: Column(
//                                                                   children: [
//                                                                     const Align(
//                                                                       alignment:
//                                                                           Alignment
//                                                                               .topLeft,
//                                                                       child:
//                                                                           Text(
//                                                                         "CONTRACTOR: ",
//                                                                         textAlign:
//                                                                             TextAlign.left,
//                                                                         style:
//                                                                             TextStyle(
//                                                                           fontSize:
//                                                                               12,
//                                                                           fontWeight:
//                                                                               FontWeight.bold,
//                                                                           color:
//                                                                               Colors.white,
//                                                                         ),
//                                                                       ),
//                                                                     ),
//                                                                     Align(
//                                                                       alignment:
//                                                                           Alignment
//                                                                               .topLeft,
//                                                                       child:
//                                                                           Text(
//                                                                         (rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].contractorName == null ||
//                                                                                 rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].contractorName.toString() == 'null')
//                                                                             ? 'N/A'
//                                                                             : rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].contractorName.toString(),
//                                                                         textAlign:
//                                                                             TextAlign.left,
//                                                                         style:
//                                                                             const TextStyle(
//                                                                           fontSize:
//                                                                               12,
//                                                                           //  fontWeight:
//                                                                           //      FontWeight.bold,
//                                                                           color:
//                                                                               Colors.white,
//                                                                         ),
//                                                                       ),
//                                                                     ),
//                                                                   ],
//                                                                 ),
//                                                               ),
//                                                               Expanded(
//                                                                 // alignment: Alignment.topLeft,
//                                                                 child: Column(
//                                                                   children: [
//                                                                     const Align(
//                                                                       alignment:
//                                                                           Alignment
//                                                                               .topLeft,
//                                                                       child:
//                                                                           Text(
//                                                                         "TOTAL MILES: ",
//                                                                         textAlign:
//                                                                             TextAlign.left,
//                                                                         style:
//                                                                             TextStyle(
//                                                                           fontSize:
//                                                                               12,
//                                                                           fontWeight:
//                                                                               FontWeight.bold,
//                                                                           color:
//                                                                               Colors.white,
//                                                                         ),
//                                                                       ),
//                                                                     ),
//                                                                     Align(
//                                                                       alignment:
//                                                                           Alignment
//                                                                               .topLeft,
//                                                                       child:
//                                                                           Text(
//                                                                         (rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].totalMiles == null ||
//                                                                                 rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].totalMiles.toString() == 'null')
//                                                                             ? 'N/A'
//                                                                             : rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].totalMiles.toString(),
//                                                                         textAlign:
//                                                                             TextAlign.left,
//                                                                         style:
//                                                                             const TextStyle(
//                                                                           fontSize:
//                                                                               12,
//                                                                           //  fontWeight:
//                                                                           //      FontWeight.bold,
//                                                                           color:
//                                                                               Colors.white,
//                                                                         ),
//                                                                       ),
//                                                                     ),
//                                                                   ],
//                                                                 ),
//                                                               ),
//                                                               Expanded(
//                                                                 // alignment: Alignment.topLeft,
//                                                                 child: Column(
//                                                                   children: [
//                                                                     const Align(
//                                                                       alignment:
//                                                                           Alignment
//                                                                               .topLeft,
//                                                                       child:
//                                                                           Text(
//                                                                         "CONTRACT YEAR: ",
//                                                                         textAlign:
//                                                                             TextAlign.left,
//                                                                         style:
//                                                                             TextStyle(
//                                                                           fontSize:
//                                                                               12,
//                                                                           fontWeight:
//                                                                               FontWeight.bold,
//                                                                           color:
//                                                                               Colors.white,
//                                                                         ),
//                                                                       ),
//                                                                     ),
//                                                                     Align(
//                                                                       alignment:
//                                                                           Alignment
//                                                                               .topLeft,
//                                                                       child:
//                                                                           Text(
//                                                                         (rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].contractYear == null ||
//                                                                                 rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].contractYear.toString() == 'null')
//                                                                             ? 'N/A'
//                                                                             : rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].contractYear.toString(),
//                                                                         textAlign:
//                                                                             TextAlign.left,
//                                                                         style:
//                                                                             const TextStyle(
//                                                                           fontSize:
//                                                                               12,
//                                                                           //  fontWeight:
//                                                                           //      FontWeight.bold,
//                                                                           color:
//                                                                               Colors.white,
//                                                                         ),
//                                                                       ),
//                                                                     ),
//                                                                   ],
//                                                                 ),
//                                                               ),
//                                                             ],
//                                                           ),
//                                                         ),
//                                                         const Divider(
//                                                           color: Colors.grey,
//                                                         ),
//                                                         Padding(
//                                                           padding:
//                                                               const EdgeInsets
//                                                                   .only(
//                                                                   left: 8.0),
//                                                           child: Row(
//                                                             children: [
//                                                               Expanded(
//                                                                 // alignment: Alignment.topLeft,
//                                                                 child: Column(
//                                                                   children: [
//                                                                     const Align(
//                                                                       alignment:
//                                                                           Alignment
//                                                                               .topLeft,
//                                                                       child:
//                                                                           Text(
//                                                                         "CYCLE: ",
//                                                                         textAlign:
//                                                                             TextAlign.left,
//                                                                         style:
//                                                                             TextStyle(
//                                                                           fontSize:
//                                                                               12,
//                                                                           fontWeight:
//                                                                               FontWeight.bold,
//                                                                           color:
//                                                                               Colors.white,
//                                                                         ),
//                                                                       ),
//                                                                     ),
//                                                                     Align(
//                                                                       alignment:
//                                                                           Alignment
//                                                                               .topLeft,
//                                                                       child:
//                                                                           Text(
//                                                                         (rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].cycle == null ||
//                                                                                 rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].cycle.toString() == 'null')
//                                                                             ? 'N/A'
//                                                                             : rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].cycle.toString(),
//                                                                         textAlign:
//                                                                             TextAlign.left,
//                                                                         style:
//                                                                             const TextStyle(
//                                                                           fontSize:
//                                                                               12,
//                                                                           //  fontWeight:
//                                                                           //      FontWeight.bold,
//                                                                           color:
//                                                                               Colors.white,
//                                                                         ),
//                                                                       ),
//                                                                     ),
//                                                                   ],
//                                                                 ),
//                                                               ),
//                                                               Expanded(
//                                                                 // alignment: Alignment.topLeft,
//                                                                 child: Column(
//                                                                   children: [
//                                                                     const Align(
//                                                                       alignment:
//                                                                           Alignment
//                                                                               .topLeft,
//                                                                       child:
//                                                                           Text(
//                                                                         "SERVICE STREET ADDRESS: ",
//                                                                         textAlign:
//                                                                             TextAlign.left,
//                                                                         style:
//                                                                             TextStyle(
//                                                                           fontSize:
//                                                                               12,
//                                                                           fontWeight:
//                                                                               FontWeight.bold,
//                                                                           color:
//                                                                               Colors.white,
//                                                                         ),
//                                                                       ),
//                                                                     ),
//                                                                     Align(
//                                                                       alignment:
//                                                                           Alignment
//                                                                               .topLeft,
//                                                                       child:
//                                                                           Text(
//                                                                         (rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].streetAddress == null ||
//                                                                                 rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].streetAddress.toString() == 'null')
//                                                                             ? 'N/A'
//                                                                             : rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].streetAddress.toString(),
//                                                                         textAlign:
//                                                                             TextAlign.left,
//                                                                         style:
//                                                                             const TextStyle(
//                                                                           fontSize:
//                                                                               12,
//                                                                           //  fontWeight:
//                                                                           //      FontWeight.bold,
//                                                                           color:
//                                                                               Colors.white,
//                                                                         ),
//                                                                       ),
//                                                                     ),
//                                                                   ],
//                                                                 ),
//                                                               ),
//                                                               Expanded(
//                                                                 // alignment: Alignment.topLeft,
//                                                                 child: Column(
//                                                                   children: [
//                                                                     const Align(
//                                                                       alignment:
//                                                                           Alignment
//                                                                               .topLeft,
//                                                                       child:
//                                                                           Text(
//                                                                         "SERVICE MAP LOCATION: ",
//                                                                         textAlign:
//                                                                             TextAlign.left,
//                                                                         style:
//                                                                             TextStyle(
//                                                                           fontSize:
//                                                                               12,
//                                                                           fontWeight:
//                                                                               FontWeight.bold,
//                                                                           color:
//                                                                               Colors.white,
//                                                                         ),
//                                                                       ),
//                                                                     ),
//                                                                     Align(
//                                                                       alignment:
//                                                                           Alignment
//                                                                               .topLeft,
//                                                                       child:
//                                                                           Text(
//                                                                         (rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].mapLocation == null ||
//                                                                                 rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].mapLocation.toString() == 'null')
//                                                                             ? 'N/A'
//                                                                             : rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].mapLocation.toString(),
//                                                                         textAlign:
//                                                                             TextAlign.left,
//                                                                         style:
//                                                                             const TextStyle(
//                                                                           fontSize:
//                                                                               12,
//                                                                           //  fontWeight:
//                                                                           //      FontWeight.bold,
//                                                                           color:
//                                                                               Colors.white,
//                                                                         ),
//                                                                       ),
//                                                                     ),
//                                                                   ],
//                                                                 ),
//                                                               ),
//                                                             ],
//                                                           ),
//                                                         ),
//                                                         const Divider(
//                                                           color: Colors.grey,
//                                                         ),
//                                                         Padding(
//                                                           padding:
//                                                               const EdgeInsets
//                                                                   .only(
//                                                                   left: 8.0),
//                                                           child: Row(
//                                                             children: [
//                                                               Expanded(
//                                                                 // alignment: Alignment.topLeft,
//                                                                 child: Column(
//                                                                   children: [
//                                                                     const Align(
//                                                                       alignment:
//                                                                           Alignment
//                                                                               .topLeft,
//                                                                       child:
//                                                                           Text(
//                                                                         "ADMIN NOTES 1: ",
//                                                                         textAlign:
//                                                                             TextAlign.left,
//                                                                         style:
//                                                                             TextStyle(
//                                                                           fontSize:
//                                                                               12,
//                                                                           fontWeight:
//                                                                               FontWeight.bold,
//                                                                           color:
//                                                                               Colors.white,
//                                                                         ),
//                                                                       ),
//                                                                     ),
//                                                                     Align(
//                                                                       alignment:
//                                                                           Alignment
//                                                                               .topLeft,
//                                                                       child:
//                                                                           Text(
//                                                                         (rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].adminNotes1 == null ||
//                                                                                 rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].adminNotes1.toString() == 'null')
//                                                                             ? 'N/A'
//                                                                             : rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].adminNotes1.toString(),
//                                                                         textAlign:
//                                                                             TextAlign.left,
//                                                                         style:
//                                                                             const TextStyle(
//                                                                           fontSize:
//                                                                               12,
//                                                                           //  fontWeight:
//                                                                           //      FontWeight.bold,
//                                                                           color:
//                                                                               Colors.white,
//                                                                         ),
//                                                                       ),
//                                                                     ),
//                                                                   ],
//                                                                 ),
//                                                               ),
//                                                               Expanded(
//                                                                 // alignment: Alignment.topLeft,
//                                                                 child: Column(
//                                                                   children: [
//                                                                     const Align(
//                                                                       alignment:
//                                                                           Alignment
//                                                                               .topLeft,
//                                                                       child:
//                                                                           Text(
//                                                                         "CONTRACTOR COMPANY: ",
//                                                                         textAlign:
//                                                                             TextAlign.left,
//                                                                         style:
//                                                                             TextStyle(
//                                                                           fontSize:
//                                                                               12,
//                                                                           fontWeight:
//                                                                               FontWeight.bold,
//                                                                           color:
//                                                                               Colors.white,
//                                                                         ),
//                                                                       ),
//                                                                     ),
//                                                                     Align(
//                                                                       alignment:
//                                                                           Alignment
//                                                                               .topLeft,
//                                                                       child:
//                                                                           Text(
//                                                                         (rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].contractorCompny == null ||
//                                                                                 rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].contractorCompny.toString() == 'null')
//                                                                             ? 'N/A'
//                                                                             : rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].contractorCompny.toString(),
//                                                                         textAlign:
//                                                                             TextAlign.left,
//                                                                         style:
//                                                                             const TextStyle(
//                                                                           fontSize:
//                                                                               12,
//                                                                           //  fontWeight:
//                                                                           //      FontWeight.bold,
//                                                                           color:
//                                                                               Colors.white,
//                                                                         ),
//                                                                       ),
//                                                                     ),
//                                                                   ],
//                                                                 ),
//                                                               ),
//                                                               Expanded(
//                                                                 // alignment: Alignment.topLeft,
//                                                                 child: Column(
//                                                                   children: [
//                                                                     const Align(
//                                                                       alignment:
//                                                                           Alignment
//                                                                               .topLeft,
//                                                                       child:
//                                                                           Text(
//                                                                         "DATE OF INSPECTION: ",
//                                                                         textAlign:
//                                                                             TextAlign.left,
//                                                                         style:
//                                                                             TextStyle(
//                                                                           fontSize:
//                                                                               12,
//                                                                           fontWeight:
//                                                                               FontWeight.bold,
//                                                                           color:
//                                                                               Colors.white,
//                                                                         ),
//                                                                       ),
//                                                                     ),
//                                                                     Align(
//                                                                       alignment:
//                                                                           Alignment
//                                                                               .topLeft,
//                                                                       child:
//                                                                           Text(
//                                                                         (rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].dateOfInspection == null ||
//                                                                                 rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].dateOfInspection.toString() == 'null')
//                                                                             ? 'N/A'
//                                                                             : rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].dateOfInspection.toString(),
//                                                                         textAlign:
//                                                                             TextAlign.left,
//                                                                         style:
//                                                                             const TextStyle(
//                                                                           fontSize:
//                                                                               12,
//                                                                           //  fontWeight:
//                                                                           //      FontWeight.bold,
//                                                                           color:
//                                                                               Colors.white,
//                                                                         ),
//                                                                       ),
//                                                                     ),
//                                                                   ],
//                                                                 ),
//                                                               ),
//                                                             ],
//                                                           ),
//                                                         ),
//                                                         const Divider(
//                                                           color: Colors.grey,
//                                                         ),
//                                                         Padding(
//                                                           padding:
//                                                               const EdgeInsets
//                                                                   .only(
//                                                                   left: 8.0),
//                                                           child: Row(
//                                                             children: [
//                                                               Expanded(
//                                                                 // alignment: Alignment.topLeft,
//                                                                 child: Column(
//                                                                   children: [
//                                                                     const Align(
//                                                                       alignment:
//                                                                           Alignment
//                                                                               .topLeft,
//                                                                       child:
//                                                                           Text(
//                                                                         "FOLLOW UP DATE: ",
//                                                                         textAlign:
//                                                                             TextAlign.left,
//                                                                         style:
//                                                                             TextStyle(
//                                                                           fontSize:
//                                                                               12,
//                                                                           fontWeight:
//                                                                               FontWeight.bold,
//                                                                           color:
//                                                                               Colors.white,
//                                                                         ),
//                                                                       ),
//                                                                     ),
//                                                                     Align(
//                                                                       alignment:
//                                                                           Alignment
//                                                                               .topLeft,
//                                                                       child:
//                                                                           Text(
//                                                                         (rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].followUpDate == null ||
//                                                                                 rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].followUpDate.toString() == 'null')
//                                                                             ? 'N/A'
//                                                                             : rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].followUpDate.toString(),
//                                                                         textAlign:
//                                                                             TextAlign.left,
//                                                                         style:
//                                                                             const TextStyle(
//                                                                           fontSize:
//                                                                               12,
//                                                                           //  fontWeight:
//                                                                           //      FontWeight.bold,
//                                                                           color:
//                                                                               Colors.white,
//                                                                         ),
//                                                                       ),
//                                                                     ),
//                                                                   ],
//                                                                 ),
//                                                               ),
//                                                               Expanded(
//                                                                 // alignment: Alignment.topLeft,
//                                                                 child: Column(
//                                                                   children: [
//                                                                     const Align(
//                                                                       alignment:
//                                                                           Alignment
//                                                                               .topLeft,
//                                                                       child:
//                                                                           Text(
//                                                                         "COST PER MILE : ",
//                                                                         textAlign:
//                                                                             TextAlign.left,
//                                                                         style:
//                                                                             TextStyle(
//                                                                           fontSize:
//                                                                               12,
//                                                                           fontWeight:
//                                                                               FontWeight.bold,
//                                                                           color:
//                                                                               Colors.white,
//                                                                         ),
//                                                                       ),
//                                                                     ),
//                                                                     Align(
//                                                                       alignment:
//                                                                           Alignment
//                                                                               .topLeft,
//                                                                       child:
//                                                                           Text(
//                                                                         (rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].costPerMiles == null ||
//                                                                                 rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].costPerMiles.toString() == 'null')
//                                                                             ? 'N/A'
//                                                                             : rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].costPerMiles.toString(),
//                                                                         textAlign:
//                                                                             TextAlign.left,
//                                                                         style:
//                                                                             const TextStyle(
//                                                                           fontSize:
//                                                                               12,
//                                                                           //  fontWeight:
//                                                                           //      FontWeight.bold,
//                                                                           color:
//                                                                               Colors.white,
//                                                                         ),
//                                                                       ),
//                                                                     ),
//                                                                   ],
//                                                                 ),
//                                                               ),
//                                                               Expanded(
//                                                                 // alignment: Alignment.topLeft,
//                                                                 child: Column(
//                                                                   children: [
//                                                                     const Align(
//                                                                       alignment:
//                                                                           Alignment
//                                                                               .topLeft,
//                                                                       child:
//                                                                           Text(
//                                                                         "TOTAL COST: ",
//                                                                         textAlign:
//                                                                             TextAlign.left,
//                                                                         style:
//                                                                             TextStyle(
//                                                                           fontSize:
//                                                                               12,
//                                                                           fontWeight:
//                                                                               FontWeight.bold,
//                                                                           color:
//                                                                               Colors.white,
//                                                                         ),
//                                                                       ),
//                                                                     ),
//                                                                     Align(
//                                                                       alignment:
//                                                                           Alignment
//                                                                               .topLeft,
//                                                                       child:
//                                                                           Text(
//                                                                         (rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].totalCost == null ||
//                                                                                 rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].totalCost!.toString() == 'null')
//                                                                             ? 'N/A'
//                                                                             : rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].totalCost.toString(),
//                                                                         textAlign:
//                                                                             TextAlign.left,
//                                                                         style:
//                                                                             const TextStyle(
//                                                                           fontSize:
//                                                                               12,
//                                                                           //  fontWeight:
//                                                                           //      FontWeight.bold,
//                                                                           color:
//                                                                               Colors.white,
//                                                                         ),
//                                                                       ),
//                                                                     ),
//                                                                   ],
//                                                                 ),
//                                                               ),
//                                                             ],
//                                                           ),
//                                                         ),
//                                                         const Divider(
//                                                           color: Colors.grey,
//                                                         ),
//                                                         Padding(
//                                                           padding:
//                                                               const EdgeInsets
//                                                                   .only(
//                                                                   left: 8.0),
//                                                           child: Row(
//                                                             children: [
//                                                               Expanded(
//                                                                 // alignment: Alignment.topLeft,
//                                                                 child: Column(
//                                                                   children: [
//                                                                     const Align(
//                                                                       alignment:
//                                                                           Alignment
//                                                                               .topLeft,
//                                                                       child:
//                                                                           Text(
//                                                                         "NEXT MAINT DUE: ",
//                                                                         textAlign:
//                                                                             TextAlign.left,
//                                                                         style:
//                                                                             TextStyle(
//                                                                           fontSize:
//                                                                               12,
//                                                                           fontWeight:
//                                                                               FontWeight.bold,
//                                                                           color:
//                                                                               Colors.white,
//                                                                         ),
//                                                                       ),
//                                                                     ),
//                                                                     Align(
//                                                                       alignment:
//                                                                           Alignment
//                                                                               .topLeft,
//                                                                       child:
//                                                                           Text(
//                                                                         (rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].nextMaintDue == null ||
//                                                                                 rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].nextMaintDue.toString() == 'null')
//                                                                             ? ''
//                                                                             : rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].nextMaintDue.toString(),
//                                                                         textAlign:
//                                                                             TextAlign.left,
//                                                                         style:
//                                                                             const TextStyle(
//                                                                           fontSize:
//                                                                               12,
//                                                                           //  fontWeight:
//                                                                           //      FontWeight.bold,
//                                                                           color:
//                                                                               Colors.white,
//                                                                         ),
//                                                                       ),
//                                                                     ),
//                                                                   ],
//                                                                 ),
//                                                               ),
//                                                               Expanded(
//                                                                 //  flex: 1,
//                                                                 // alignment: Alignment.topLeft,
//                                                                 child: Column(
//                                                                   children: [
//                                                                     const Align(
//                                                                       alignment:
//                                                                           Alignment
//                                                                               .topLeft,
//                                                                       child:
//                                                                           Text(
//                                                                         "CREATE DATE: ",
//                                                                         textAlign:
//                                                                             TextAlign.left,
//                                                                         style:
//                                                                             TextStyle(
//                                                                           fontSize:
//                                                                               12,
//                                                                           fontWeight:
//                                                                               FontWeight.bold,
//                                                                           color:
//                                                                               Colors.white,
//                                                                         ),
//                                                                       ),
//                                                                     ),
//                                                                     Align(
//                                                                       alignment:
//                                                                           Alignment
//                                                                               .topLeft,
//                                                                       child:
//                                                                           Text(
//                                                                         (rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].createDate == null ||
//                                                                                 rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].createDate.toString() == 'null')
//                                                                             ? ''
//                                                                             : formattedDateCreateDate,
//                                                                         textAlign:
//                                                                             TextAlign.left,
//                                                                         style:
//                                                                             const TextStyle(
//                                                                           fontSize:
//                                                                               12,
//                                                                           //  fontWeight:
//                                                                           //      FontWeight.bold,
//                                                                           color:
//                                                                               Colors.white,
//                                                                         ),
//                                                                       ),
//                                                                     ),
//                                                                   ],
//                                                                 ),
//                                                               ),
//                                                               Expanded(
//                                                                 // flex: 2,
//                                                                 child: Column(
//                                                                   children: [
//                                                                     Align(
//                                                                         alignment:
//                                                                             Alignment
//                                                                                 .topLeft,
//                                                                         child:
//                                                                             InkWell(
//                                                                           onTap:
//                                                                               () async {
//                                                                             String
//                                                                                 id =
//                                                                                 '';
//                                                                             final userPreferences1 =
//                                                                                 Provider.of<UserPref>(context, listen: false);
//                                                                             UserModel
//                                                                                 data =
//                                                                                 await userPreferences1.getUser();
//                                                                             id =
//                                                                                 data.user!.id.toString();
//                                                                             // Navigator.of(context).push(
//                                                                             //     MaterialPageRoute(
//                                                                             //         builder: (BuildContext
//                                                                             //                 context) =>
//                                                                             //             MapViewAdmin(
//                                                                             //               id: rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].id.toString(),
//                                                                             //             )));
//                                                                             // Navigator.push(
//                                                                             //   context,
//                                                                             //   MaterialPageRoute(
//                                                                             //     builder: (context) => MapViewPage(
//                                                                             //       url: MapUrl.getAdminEndPoint(rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].tokenNo.toString(), id),
//                                                                             //     ),
//                                                                             //   ),
//                                                                             // );

//                                                                             await browser.open(
//                                                                                 url: WebUri(
//                                                                                   // "https://mapapi.ariespro.com/main/admin/CIVM_Map/${rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].tokenNo.toString()}/USRQWXH589Z"),
//                                                                                   MapUrl.getAdminEndPoint(rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList![index].tokenNo.toString(),id)),
//                                                                                 settings: ChromeSafariBrowserSettings(shareState: CustomTabsShareState.SHARE_STATE_OFF, barCollapsingEnabled: true));
//                                                                           },
//                                                                           child:
//                                                                               Align(
//                                                                             alignment:
//                                                                                 Alignment.centerLeft,
//                                                                             child:
//                                                                                 Container(
//                                                                               // margin: const EdgeInsets.only(
//                                                                               //     left: 40, right: 40, bottom: 10.0),
//                                                                               padding: const EdgeInsets.all(8),
//                                                                               alignment: Alignment.centerLeft,
//                                                                               width: 80,
//                                                                               // MediaQuery.of(context).size.width,
//                                                                               // height: MediaQuery.of(context).size.height * 0.4,
//                                                                               decoration: const BoxDecoration(
//                                                                                   // shape: BoxShape.circle,

//                                                                                   color: Color.fromARGB(255, 0, 58, 106),
//                                                                                   gradient: LinearGradient(
//                                                                                     colors: [
//                                                                                       Color.fromARGB(255, 0, 79, 215),
//                                                                                       Colors.blue,
//                                                                                       Color.fromARGB(255, 0, 79, 215),
//                                                                                     ],
//                                                                                   )),
//                                                                               child: const Align(
//                                                                                 alignment: Alignment.center,
//                                                                                 child: Text(
//                                                                                   "VIEW MAP",
//                                                                                   style: TextStyle(
//                                                                                     color: Colors.white,
//                                                                                     fontWeight: FontWeight.bold,
//                                                                                     fontSize: 10,
//                                                                                   ),
//                                                                                 ),
//                                                                               ),
//                                                                             ),
//                                                                           ),
//                                                                         )),
//                                                                   ],
//                                                                 ),
//                                                               ),
//                                                             ],
//                                                           ),
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

//   void fetchData(String subStation, String fdrName, String cycle, String month,
//       String year) {
//     rowMaintenanceProgressNewViewModel.fetchRowMaintenanceProgressNewListApi(
//         context, subStation, fdrName, cycle, month, year);
//   }

//   List<_ChartDataSimpleColumnChart1> recreateDataTotalMilesBySubstation(
//       RowMaintenanceProgressNewViewModel value) {
//     dataSimpleColumnChart1.clear();

//     for (var i = 0;
//         i <
//             rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList
//                 .data!.getSPSMMAINTTOTALMILESBYTYPEFTRLIST!.length;
//         i++) {
//       dataSimpleColumnChart1.add(_ChartDataSimpleColumnChart1(
//           (rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList
//                           .data!.getSPSMMAINTTOTALMILESBYTYPEFTRLIST![i].type ==
//                       null ||
//                   rowMaintenanceProgressNewViewModel
//                           .rowMaintenanceProgressNewList
//                           .data!
//                           .getSPSMMAINTTOTALMILESBYTYPEFTRLIST![i]
//                           .type
//                           .toString() ==
//                       'null')
//               ? ''
//               : rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList
//                   .data!.getSPSMMAINTTOTALMILESBYTYPEFTRLIST![i].type
//                   .toString(),
//           (rowMaintenanceProgressNewViewModel
//                           .rowMaintenanceProgressNewList
//                           .data!
//                           .getSPSMMAINTTOTALMILESBYTYPEFTRLIST![i]
//                           .totalMiles ==
//                       null ||
//                   rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPSMMAINTTOTALMILESBYTYPEFTRLIST![i].totalMiles.toString() == 'null')
//               ? 0
//               : double.parse(rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPSMMAINTTOTALMILESBYTYPEFTRLIST![i].totalMiles.toString())));
//     }
//     return dataSimpleColumnChart1;
//   }

//   List<_ChartDataSimpleColumnChart2> recreateDataTotalCostBySubstation(
//       RowMaintenanceProgressNewViewModel value) {
//     dataSimpleColumnChart2.clear();

//     for (var i = 0;
//         i <
//             rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList
//                 .data!.getSPSMMAINTTOTALCOSTBYTYPEFTRList!.length;
//         i++) {
//       dataSimpleColumnChart2.add(_ChartDataSimpleColumnChart2(
//           (rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList
//                           .data!.getSPSMMAINTTOTALCOSTBYTYPEFTRList![i].type ==
//                       null ||
//                   rowMaintenanceProgressNewViewModel
//                           .rowMaintenanceProgressNewList
//                           .data!
//                           .getSPSMMAINTTOTALCOSTBYTYPEFTRList![i]
//                           .type
//                           .toString() ==
//                       'null')
//               ? ''
//               : rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList
//                   .data!.getSPSMMAINTTOTALCOSTBYTYPEFTRList![i].type
//                   .toString(),
//           (rowMaintenanceProgressNewViewModel
//                           .rowMaintenanceProgressNewList
//                           .data!
//                           .getSPSMMAINTTOTALCOSTBYTYPEFTRList![i]
//                           .totalCost ==
//                       null ||
//                   rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPSMMAINTTOTALCOSTBYTYPEFTRList![i].totalCost.toString() == 'null')
//               ? 0
//               : double.parse(rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPSMMAINTTOTALCOSTBYTYPEFTRList![i].totalCost.toString())));
//     }
//     return dataSimpleColumnChart2;
//   }

//   Future<void> _filterData(String query) async {
//     if (query.isEmpty) {
//       rowMaintenanceProgressNewViewModel.fetchRowMaintenanceProgressNewListApi(
//           context, '', '', '', '', '');
//     } else {
//       rowMaintenanceProgressNewViewModel.rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList = rowMaintenanceProgressNewViewModel
//           .rowMaintenanceProgressNewList.data!.getSPROWMAINTTBLFLTRList
//           ?.where((item) =>
//               item.tokenNo.toString().toLowerCase().contains(query.toLowerCase()) ||
//               item.maintType
//                   .toString()
//                   .toLowerCase()
//                   .contains(query.toLowerCase()) ||
//               item.status
//                   .toString()
//                   .toLowerCase()
//                   .contains(query.toLowerCase()) ||
//               item.substationName
//                   .toString()
//                   .toLowerCase()
//                   .contains(query.toLowerCase()) ||
//               item.fdrName
//                   .toString()
//                   .toLowerCase()
//                   .contains(query.toLowerCase()) ||
//               item.createDate
//                   .toString()
//                   .toLowerCase()
//                   .contains(query.toLowerCase()) ||
//               item.type
//                   .toString()
//                   .toLowerCase()
//                   .contains(query.toLowerCase()) ||
//               item.contractorName
//                   .toString()
//                   .toLowerCase()
//                   .contains(query.toLowerCase()) ||
//               item.adminNotes1
//                   .toString()
//                   .toLowerCase()
//                   .contains(query.toLowerCase()) ||
//               item.totalMiles.toString().toLowerCase().contains(query.toLowerCase()) ||
//               item.contractYear.toString().toLowerCase().contains(query.toLowerCase()) ||
//               item.cycle.toString().toLowerCase().contains(query.toLowerCase()) ||
//               item.streetAddress.toString().toLowerCase().contains(query.toLowerCase()) ||
//               item.mapLocation.toString().toLowerCase().contains(query.toLowerCase()) ||
//               item.adminNotes1.toString().toLowerCase().contains(query.toLowerCase()) ||
//               item.dateOfInspection.toString().toLowerCase().contains(query.toLowerCase()) ||
//               item.followUpDate.toString().toLowerCase().contains(query.toLowerCase()) ||
//               item.costPerMiles.toString().toLowerCase().contains(query.toLowerCase()) ||
//               item.totalCost.toString().toLowerCase().contains(query.toLowerCase()) ||
//               item.nextMaintDue.toString().toLowerCase().contains(query.toLowerCase()) ||
//               item.contractorCompny.toString().toLowerCase().contains(query.toLowerCase()))
//           .toList();
//     }
//     setState(() {});
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
