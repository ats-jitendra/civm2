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
// import 'package:CIVM/piedmont/resources/app_colors.dart';
// import '../../../data/response/status.dart';
// import '../../../view_model/row_cost_analysis_by_month_view_model.dart';

// // ignore: must_be_immutable
// class RowCostAnalysisByMonth extends StatefulWidget {
//   const RowCostAnalysisByMonth({Key? key}) : super(key: key);

//   @override
//   State<RowCostAnalysisByMonth> createState() => _RowCostAnalysisByMonthState();
// }

// class _RowCostAnalysisByMonthState extends State<RowCostAnalysisByMonth> {
// // ignore: prefer_typing_uninitialized_variables
//   var selectedSubstation;
//   int substationId = 0;

// // ignore: prefer_typing_uninitialized_variables
//   var selectedFeeder;
//   int feederId = 0;

//   // ignore: prefer_typing_uninitialized_variables
//   var selectedMonth;
//   int monthId = 0;

//   // ignore: prefer_typing_uninitialized_variables
//   var selectedYear;
//   int yearId = 0;

//   // ignore: prefer_typing_uninitialized_variables
//   var selectedType;
//   int typeId = 0;

//   // late final List<charts.Series> seriesList;
//   late final bool animate = true;
//   final TextEditingController _input = TextEditingController();
//   late final Future? myFuture;
//   var result = [];

//   List<_ChartDataSimpleColumnChart1> chartDataSimpleColumnChart1 = [];
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
//   RowCostAnalysisByMonthViewModel rowCostAnalysisByMonthViewModel =
//       RowCostAnalysisByMonthViewModel();

//   @override
//   void initState() {
//     rowCostAnalysisByMonthViewModel.fetchRowCostAnalysisByMonthListApi(
//         context, '', '', '', '');
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
//             'Row Cost Analysis By Month',
//             style: TextStyle(color: Colors.white),
//           ),
//           backgroundColor: AppColors.baseColor,
//           actions: const <Widget>[],
//         ),
//         body: ChangeNotifierProvider<RowCostAnalysisByMonthViewModel>(
//             create: (BuildContext context) => rowCostAnalysisByMonthViewModel,
//             child: Consumer<RowCostAnalysisByMonthViewModel>(
//                 builder: (context, value, _) {
//               switch (value.rowCostAnalysisByMonthList.status) {
//                 case Status.LOADING:
//                   return const Center(child: CircularProgressIndicator());
//                 case Status.ERROR:
//                   return
//                       // CustomToastSnackBarProgressDialog.flushBarErrorMessage(
//                       //     value.rowCostAnalysisByMonthList.message.toString(),
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
//                   return RefreshIndicator(
//                     onRefresh: () async {
//                       _input.clear();
//                       selectedSubstation = null;
//                       selectedFeeder = null;
//                       selectedType = null;
//                       selectedYear = null;
//                       selectedMonth = null;
//                       await rowCostAnalysisByMonthViewModel
//                           .fetchRowCostAnalysisByMonthListApi(
//                               context, '', '', '', '');
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
//                                                 dropdownColor: Colors.white,
//                                                 value: selectedSubstation,
//                                                 style: const TextStyle(
//                                                     color: Color.fromARGB(
//                                                         255, 7, 59, 120),
//                                                     fontSize: 16),
//                                                 icon: const Icon(
//                                                   Icons.arrow_downward_rounded,
//                                                   color: Color.fromARGB(
//                                                       255, 7, 59, 120),
//                                                   size: 25,
//                                                 ),
//                                                 isExpanded: true,
//                                                 items: rowCostAnalysisByMonthViewModel
//                                                     .rowCostAnalysisByMonthList
//                                                     .data!
//                                                     .findsAllSubstation!
//                                                     .map((e) {
//                                                   return DropdownMenuItem(
//                                                     value: e.id.toString(),
//                                                     child: Text(e.substation
//                                                         .toString()),
//                                                   );
//                                                 }).toList(),
//                                                 onChanged: (val) {
//                                                   if (selectedFeeder != null ||
//                                                       selectedType != null ||
//                                                       selectedYear != null ||
//                                                       selectedMonth != null) {
//                                                     selectedFeeder = null;
//                                                     selectedType = null;
//                                                     selectedYear = null;
//                                                     selectedMonth = null;
//                                                   }
//                                                   print('val');
//                                                   print(val);
//                                                   fetchData(val!, '', '', '');
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
//                                                 dropdownColor: Colors.white,
//                                                 value: selectedFeeder,
//                                                 style: const TextStyle(
//                                                     color: Color.fromARGB(
//                                                         255, 7, 59, 120),
//                                                     fontSize: 16),
//                                                 icon: const Icon(
//                                                   Icons.arrow_downward_rounded,
//                                                   color: Color.fromARGB(
//                                                       255, 7, 59, 120),
//                                                   size: 25,
//                                                 ),
//                                                 isExpanded: true,
//                                                 items: rowCostAnalysisByMonthViewModel
//                                                     .rowCostAnalysisByMonthList
//                                                     .data!
//                                                     .findsFeederAndIdBySubstation!
//                                                     .map((e) {
//                                                   return DropdownMenuItem(
//                                                     value: e.id.toString(),
//                                                     child: Text(e.feederName
//                                                         .toString()),
//                                                   );
//                                                 }).toList(),
//                                                 onChanged: (val) {
//                                                   if (selectedType != null ||
//                                                       selectedYear != null ||
//                                                       selectedMonth != null) {
//                                                     selectedType = null;
//                                                     selectedYear = null;
//                                                     selectedMonth = null;
//                                                   }
//                                                   print('val');
//                                                   print(val);
//                                                   fetchData(
//                                                       substationId.toString(),
//                                                       val!,
//                                                       '',
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
//                                                 "Month",
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
//                                                 dropdownColor: Colors.white,
//                                                 value: selectedMonth,
//                                                 style: const TextStyle(
//                                                     color: Color.fromARGB(
//                                                         255, 7, 59, 120),
//                                                     fontSize: 16),
//                                                 icon: const Icon(
//                                                   Icons.arrow_downward_rounded,
//                                                   color: Color.fromARGB(
//                                                       255, 7, 59, 120),
//                                                   size: 25,
//                                                 ),
//                                                 isExpanded: true,
//                                                 items: rowCostAnalysisByMonthViewModel
//                                                     .rowCostAnalysisByMonthList
//                                                     .data!
//                                                     .findsNextMaintDueAndMonthIdBySubstationAndFeeder!
//                                                     .map((e) {
//                                                   return DropdownMenuItem(
//                                                     value: e.monthId.toString(),
//                                                     child: Text(e.nextMaintDue
//                                                         .toString()),
//                                                   );
//                                                 }).toList(),
//                                                 onChanged: (val) {
//                                                   if (selectedType != null ||
//                                                       selectedYear != null) {
//                                                     selectedType = null;
//                                                     selectedYear = null;
//                                                   }
//                                                   print('val');
//                                                   print(val);
//                                                   fetchData(
//                                                       substationId.toString(),
//                                                       feederId.toString(),
//                                                       '',
//                                                       val!);
//                                                   monthId =
//                                                       int.parse(val.toString());
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
//                                                 dropdownColor: Colors.white,
//                                                 value: selectedYear,
//                                                 style: const TextStyle(
//                                                     color: Color.fromARGB(
//                                                         255, 7, 59, 120),
//                                                     fontSize: 16),
//                                                 icon: const Icon(
//                                                   Icons.arrow_downward_rounded,
//                                                   color: Color.fromARGB(
//                                                       255, 7, 59, 120),
//                                                   size: 25,
//                                                 ),
//                                                 isExpanded: true,
//                                                 items: rowCostAnalysisByMonthViewModel
//                                                     .rowCostAnalysisByMonthList
//                                                     .data!
//                                                     .findsNextMaintDueBySubstationAndFeederAndNextMaintDueMonth!
//                                                     .map((e) {
//                                                   return DropdownMenuItem(
//                                                     value: e.id.toString(),
//                                                     child:
//                                                         Text(e.year.toString()),
//                                                   );
//                                                 }).toList(),
//                                                 onChanged: (val) {
//                                                   if (selectedType != null) {
//                                                     selectedType = null;
//                                                   }
//                                                   print('val');
//                                                   print(val);
//                                                   fetchData(
//                                                       substationId.toString(),
//                                                       feederId.toString(),
//                                                       val!,
//                                                       monthId.toString());
//                                                   yearId =
//                                                       int.parse(val.toString());
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
//                                                 "Maintenance Type",
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
//                                                 dropdownColor: Colors.white,
//                                                 value: selectedType,
//                                                 style: const TextStyle(
//                                                     color: Color.fromARGB(
//                                                         255, 7, 59, 120),
//                                                     fontSize: 16),
//                                                 icon: const Icon(
//                                                   Icons.arrow_downward_rounded,
//                                                   color: Color.fromARGB(
//                                                       255, 7, 59, 120),
//                                                   size: 25,
//                                                 ),
//                                                 isExpanded: true,
//                                                 items: rowCostAnalysisByMonthViewModel
//                                                     .rowCostAnalysisByMonthList
//                                                     .data!
//                                                     .findsAllSubstation!
//                                                     .map((e) {
//                                                   return DropdownMenuItem(
//                                                     value: e.id.toString(),
//                                                     child: Text(e.substation
//                                                         .toString()),
//                                                   );
//                                                 }).toList(),
//                                                 onChanged: (val) {
//                                                   print('val');
//                                                   print(val);
//                                                   fetchData(
//                                                       substationId.toString(),
//                                                       feederId.toString(),
//                                                       yearId.toString(),
//                                                       monthId.toString());
//                                                   // yearId =
//                                                   //     int.parse(val.toString());
//                                                   print('111111111111111');
//                                                   // print(id.text.toString());
//                                                   setState(() {
//                                                     selectedType = val;
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
//                                             "ESTIMATED BUDGET (\$): ",
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
//                                             rowCostAnalysisByMonthViewModel
//                                                 .rowCostAnalysisByMonthList
//                                                 .data!
//                                                 .findsEstimatedBudget
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
//                                   ),
//                                 ]),
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
//                                       "Vegetation Maintenance Cost By Year/Month",
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
//                                             text: 'YEAR/MONTH',
//                                             textStyle: const TextStyle(
//                                                 color: Colors.red,
//                                                 fontFamily: 'Roboto',
//                                                 fontSize: 16,
//                                                 fontStyle: FontStyle.italic,
//                                                 fontWeight: FontWeight.bold)),
//                                       ),
//                                       primaryYAxis: CategoryAxis(
//                                         title: AxisTitle(
//                                             text: 'ESTIMATED BUDGET(\$)',
//                                             textStyle: const TextStyle(
//                                                 color: Colors.red,
//                                                 fontFamily: 'Roboto',
//                                                 fontSize: 16,
//                                                 fontStyle: FontStyle.italic,
//                                                 fontWeight: FontWeight.bold)),
//                                       ),
//                                       legend: Legend(isVisible: true),
//                                       palette: const <Color>[
//                                         Color.fromARGB(255, 46, 0, 247),
//                                         Colors.red,
//                                         Colors.orange,
//                                         Colors.green,
//                                         Colors.purple,
//                                         Color.fromARGB(255, 5, 173, 245),
//                                       ],
//                                       series: <CartesianSeries>[
//                                         ColumnSeries<
//                                             _ChartDataSimpleColumnChart1,
//                                             String>(
//                                           name: 'HERBICIDES',
//                                           dataSource:
//                                               recreateDataVegetationMaintenanceCostByYearMonth(
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
//                                         ),
//                                         ColumnSeries<
//                                             _ChartDataSimpleColumnChart1,
//                                             String>(
//                                           name: 'MECHANICAL CLEARING',
//                                           dataSource:
//                                               recreateDataVegetationMaintenanceCostByYearMonth(
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
//                                                   data.y1,
//                                           markerSettings: const MarkerSettings(
//                                               isVisible: true,
//                                               shape: DataMarkerType.diamond),
//                                         ),
//                                         ColumnSeries<
//                                             _ChartDataSimpleColumnChart1,
//                                             String>(
//                                           name: 'MECHANICAL PRUNING',
//                                           dataSource:
//                                               recreateDataVegetationMaintenanceCostByYearMonth(
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
//                                                   data.y2,
//                                           markerSettings: const MarkerSettings(
//                                               isVisible: true,
//                                               shape: DataMarkerType.diamond),
//                                         ),
//                                         ColumnSeries<
//                                             _ChartDataSimpleColumnChart1,
//                                             String>(
//                                           name: 'ARIEL PRUNING',
//                                           dataSource:
//                                               recreateDataVegetationMaintenanceCostByYearMonth(
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
//                                                   data.y3,
//                                           markerSettings: const MarkerSettings(
//                                               isVisible: true,
//                                               shape: DataMarkerType.diamond),
//                                         ),
//                                         ColumnSeries<
//                                             _ChartDataSimpleColumnChart1,
//                                             String>(
//                                           name: 'PRUNING',
//                                           dataSource:
//                                               recreateDataVegetationMaintenanceCostByYearMonth(
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
//                                                   data.y4,
//                                           markerSettings: const MarkerSettings(
//                                               isVisible: true,
//                                               shape: DataMarkerType.diamond),
//                                         ),
//                                         ColumnSeries<
//                                             _ChartDataSimpleColumnChart1,
//                                             String>(
//                                           name: 'MECHANICAL TREE REMOVAL',
//                                           dataSource:
//                                               recreateDataVegetationMaintenanceCostByYearMonth(
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
//                                                   data.y5,
//                                           markerSettings: const MarkerSettings(
//                                               isVisible: true,
//                                               shape: DataMarkerType.diamond),
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
//                                             rowCostAnalysisByMonthViewModel
//                                                 .rowCostAnalysisByMonthList
//                                                 .data!
//                                                 .findsTableDataOfRowCosAnalysisPage!
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
//                                             itemCount:
//                                                 rowCostAnalysisByMonthViewModel
//                                                     .rowCostAnalysisByMonthList
//                                                     .data!
//                                                     .findsTableDataOfRowCosAnalysisPage!
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
//                                                                   (rowCostAnalysisByMonthViewModel.rowCostAnalysisByMonthList.data!.findsTableDataOfRowCosAnalysisPage![index].type == null ||
//                                                                           rowCostAnalysisByMonthViewModel.rowCostAnalysisByMonthList.data!.findsTableDataOfRowCosAnalysisPage![index].type.toString() ==
//                                                                               'null' ||
//                                                                           rowCostAnalysisByMonthViewModel
//                                                                               .rowCostAnalysisByMonthList
//                                                                               .data!
//                                                                               .findsTableDataOfRowCosAnalysisPage![
//                                                                                   index]
//                                                                               .type!
//                                                                               .isEmpty)
//                                                                       ? 'N/A'
//                                                                       : rowCostAnalysisByMonthViewModel
//                                                                           .rowCostAnalysisByMonthList
//                                                                           .data!
//                                                                           .findsTableDataOfRowCosAnalysisPage![
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
//                                                                   (rowCostAnalysisByMonthViewModel.rowCostAnalysisByMonthList.data!.findsTableDataOfRowCosAnalysisPage![index].tokenNo == null ||
//                                                                           rowCostAnalysisByMonthViewModel.rowCostAnalysisByMonthList.data!.findsTableDataOfRowCosAnalysisPage![index].tokenNo.toString() ==
//                                                                               'null' ||
//                                                                           rowCostAnalysisByMonthViewModel
//                                                                               .rowCostAnalysisByMonthList
//                                                                               .data!
//                                                                               .findsTableDataOfRowCosAnalysisPage![
//                                                                                   index]
//                                                                               .tokenNo!
//                                                                               .isEmpty)
//                                                                       ? 'N/A'
//                                                                       : rowCostAnalysisByMonthViewModel
//                                                                           .rowCostAnalysisByMonthList
//                                                                           .data!
//                                                                           .findsTableDataOfRowCosAnalysisPage![
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
//                                                                   (rowCostAnalysisByMonthViewModel.rowCostAnalysisByMonthList.data!.findsTableDataOfRowCosAnalysisPage![index].status == null ||
//                                                                           rowCostAnalysisByMonthViewModel.rowCostAnalysisByMonthList.data!.findsTableDataOfRowCosAnalysisPage![index].status.toString() ==
//                                                                               'null' ||
//                                                                           rowCostAnalysisByMonthViewModel
//                                                                               .rowCostAnalysisByMonthList
//                                                                               .data!
//                                                                               .findsTableDataOfRowCosAnalysisPage![
//                                                                                   index]
//                                                                               .status!
//                                                                               .isEmpty)
//                                                                       ? 'N/A'
//                                                                       : rowCostAnalysisByMonthViewModel
//                                                                           .rowCostAnalysisByMonthList
//                                                                           .data!
//                                                                           .findsTableDataOfRowCosAnalysisPage![
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
//                                                                   (rowCostAnalysisByMonthViewModel.rowCostAnalysisByMonthList.data!.findsTableDataOfRowCosAnalysisPage![index].substation == null ||
//                                                                           rowCostAnalysisByMonthViewModel.rowCostAnalysisByMonthList.data!.findsTableDataOfRowCosAnalysisPage![index].substation.toString() ==
//                                                                               'null' ||
//                                                                           rowCostAnalysisByMonthViewModel
//                                                                               .rowCostAnalysisByMonthList
//                                                                               .data!
//                                                                               .findsTableDataOfRowCosAnalysisPage![
//                                                                                   index]
//                                                                               .substation!
//                                                                               .isEmpty)
//                                                                       ? 'N/A'
//                                                                       : rowCostAnalysisByMonthViewModel
//                                                                           .rowCostAnalysisByMonthList
//                                                                           .data!
//                                                                           .findsTableDataOfRowCosAnalysisPage![
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
//                                                                   (rowCostAnalysisByMonthViewModel.rowCostAnalysisByMonthList.data!.findsTableDataOfRowCosAnalysisPage![index].createDate == null ||
//                                                                           rowCostAnalysisByMonthViewModel.rowCostAnalysisByMonthList.data!.findsTableDataOfRowCosAnalysisPage![index].createDate.toString() ==
//                                                                               'null' ||
//                                                                           rowCostAnalysisByMonthViewModel
//                                                                               .rowCostAnalysisByMonthList
//                                                                               .data!
//                                                                               .findsTableDataOfRowCosAnalysisPage![
//                                                                                   index]
//                                                                               .createDate!
//                                                                               .isEmpty)
//                                                                       ? 'N/A'
//                                                                       : rowCostAnalysisByMonthViewModel
//                                                                           .rowCostAnalysisByMonthList
//                                                                           .data!
//                                                                           .findsTableDataOfRowCosAnalysisPage![
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
//                                                                   String id =
//                                                                       '';
//                                                                   final userPreferences1 = Provider.of<
//                                                                           UserPref>(
//                                                                       context,
//                                                                       listen:
//                                                                           false);
//                                                                   UserModel
//                                                                       data =
//                                                                       await userPreferences1
//                                                                           .getUser();
//                                                                   id = data
//                                                                       .user!.id
//                                                                       .toString();
//                                                                   // Navigator.of(context).push(
//                                                                   //     MaterialPageRoute(
//                                                                   //         builder: (BuildContext
//                                                                   //                 context) =>
//                                                                   //             MapViewAdmin(
//                                                                   //               id: rowCostAnalysisByMonthViewModel
//                                                                   //                     .rowCostAnalysisByMonthList
//                                                                   //                     .data!
//                                                                   //                     .findsTableDataOfRowCosAnalysisPage![
//                                                                   //                         index]
//                                                                   //                   .id
//                                                                   //                   .toString(),
//                                                                   //             )));
//                                                                   // Navigator
//                                                                   //     .push(
//                                                                   //   context,
//                                                                   //   MaterialPageRoute(
//                                                                   //     builder:
//                                                                   //         (context) =>
//                                                                   //             MapViewPage(
//                                                                   //       url: MapUrl.getAdminEndPoint(
//                                                                   //           rowCostAnalysisByMonthViewModel.rowCostAnalysisByMonthList.data!.findsTableDataOfRowCosAnalysisPage![index].tokenNo.toString(),
//                                                                   //           id),
//                                                                   //     ),
//                                                                   //   ),
//                                                                   // );

//                                                                   await browser.open(url: WebUri(
//                                                                       //             "https://mapapi.ariespro.com/main/admin/CIVM_Map/${rowCostAnalysisByMonthViewModel
//                                                                       //   .rowCostAnalysisByMonthList
//                                                                       //   .data!
//                                                                       //   .findsTableDataOfRowCosAnalysisPage![
//                                                                       //       index]
//                                                                       // .tokenNo
//                                                                       // .toString()}/USRQWXH589Z"),

//                                                                       MapUrl.getAdminEndPoint(rowCostAnalysisByMonthViewModel.rowCostAnalysisByMonthList.data!.findsTableDataOfRowCosAnalysisPage![index].tokenNo.toString(),id)), settings: ChromeSafariBrowserSettings(shareState: CustomTabsShareState.SHARE_STATE_OFF, barCollapsingEnabled: true));
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
//                                                                             (rowCostAnalysisByMonthViewModel.rowCostAnalysisByMonthList.data!.findsTableDataOfRowCosAnalysisPage![index].fdrName == null || rowCostAnalysisByMonthViewModel.rowCostAnalysisByMonthList.data!.findsTableDataOfRowCosAnalysisPage![index].fdrName.toString() == 'null' || rowCostAnalysisByMonthViewModel.rowCostAnalysisByMonthList.data!.findsTableDataOfRowCosAnalysisPage![index].fdrName!.isEmpty)
//                                                                                 ? 'N/A'
//                                                                                 : rowCostAnalysisByMonthViewModel.rowCostAnalysisByMonthList.data!.findsTableDataOfRowCosAnalysisPage![index].fdrName.toString(),
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
//                                                                             (rowCostAnalysisByMonthViewModel.rowCostAnalysisByMonthList.data!.findsTableDataOfRowCosAnalysisPage![index].maintType == null || rowCostAnalysisByMonthViewModel.rowCostAnalysisByMonthList.data!.findsTableDataOfRowCosAnalysisPage![index].maintType.toString() == 'null' || rowCostAnalysisByMonthViewModel.rowCostAnalysisByMonthList.data!.findsTableDataOfRowCosAnalysisPage![index].maintType!.isEmpty)
//                                                                                 ? 'N/A'
//                                                                                 : rowCostAnalysisByMonthViewModel.rowCostAnalysisByMonthList.data!.findsTableDataOfRowCosAnalysisPage![index].maintType.toString(),
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
//                                                                             (rowCostAnalysisByMonthViewModel.rowCostAnalysisByMonthList.data!.findsTableDataOfRowCosAnalysisPage![index].budget == null || rowCostAnalysisByMonthViewModel.rowCostAnalysisByMonthList.data!.findsTableDataOfRowCosAnalysisPage![index].budget.toString() == 'null' || rowCostAnalysisByMonthViewModel.rowCostAnalysisByMonthList.data!.findsTableDataOfRowCosAnalysisPage![index].budget!.isEmpty)
//                                                                                 ? 'N/A'
//                                                                                 : rowCostAnalysisByMonthViewModel.rowCostAnalysisByMonthList.data!.findsTableDataOfRowCosAnalysisPage![index].budget.toString(),
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
//                                                                             (rowCostAnalysisByMonthViewModel.rowCostAnalysisByMonthList.data!.findsTableDataOfRowCosAnalysisPage![index].contractor == null || rowCostAnalysisByMonthViewModel.rowCostAnalysisByMonthList.data!.findsTableDataOfRowCosAnalysisPage![index].contractor.toString() == 'null' || rowCostAnalysisByMonthViewModel.rowCostAnalysisByMonthList.data!.findsTableDataOfRowCosAnalysisPage![index].contractor!.isEmpty)
//                                                                                 ? 'N/A'
//                                                                                 : rowCostAnalysisByMonthViewModel.rowCostAnalysisByMonthList.data!.findsTableDataOfRowCosAnalysisPage![index].contractor.toString(),
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
//                                                                             (rowCostAnalysisByMonthViewModel.rowCostAnalysisByMonthList.data!.findsTableDataOfRowCosAnalysisPage![index].totalMiles == null || rowCostAnalysisByMonthViewModel.rowCostAnalysisByMonthList.data!.findsTableDataOfRowCosAnalysisPage![index].totalMiles.toString() == 'null' || rowCostAnalysisByMonthViewModel.rowCostAnalysisByMonthList.data!.findsTableDataOfRowCosAnalysisPage![index].totalMiles!.isEmpty)
//                                                                                 ? 'N/A'
//                                                                                 : rowCostAnalysisByMonthViewModel.rowCostAnalysisByMonthList.data!.findsTableDataOfRowCosAnalysisPage![index].totalMiles.toString(),
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
//                                                                             (rowCostAnalysisByMonthViewModel.rowCostAnalysisByMonthList.data!.findsTableDataOfRowCosAnalysisPage![index].contractYear == null || rowCostAnalysisByMonthViewModel.rowCostAnalysisByMonthList.data!.findsTableDataOfRowCosAnalysisPage![index].contractYear.toString() == 'null' || rowCostAnalysisByMonthViewModel.rowCostAnalysisByMonthList.data!.findsTableDataOfRowCosAnalysisPage![index].contractYear!.isEmpty)
//                                                                                 ? 'N/A'
//                                                                                 : rowCostAnalysisByMonthViewModel.rowCostAnalysisByMonthList.data!.findsTableDataOfRowCosAnalysisPage![index].contractYear.toString(),
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
//                                                                             (rowCostAnalysisByMonthViewModel.rowCostAnalysisByMonthList.data!.findsTableDataOfRowCosAnalysisPage![index].cycle == null || rowCostAnalysisByMonthViewModel.rowCostAnalysisByMonthList.data!.findsTableDataOfRowCosAnalysisPage![index].cycle.toString() == 'null' || rowCostAnalysisByMonthViewModel.rowCostAnalysisByMonthList.data!.findsTableDataOfRowCosAnalysisPage![index].cycle!.isEmpty)
//                                                                                 ? 'N/A'
//                                                                                 : rowCostAnalysisByMonthViewModel.rowCostAnalysisByMonthList.data!.findsTableDataOfRowCosAnalysisPage![index].cycle.toString(),
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
//                                                                             (rowCostAnalysisByMonthViewModel.rowCostAnalysisByMonthList.data!.findsTableDataOfRowCosAnalysisPage![index].streetAddress == null || rowCostAnalysisByMonthViewModel.rowCostAnalysisByMonthList.data!.findsTableDataOfRowCosAnalysisPage![index].streetAddress.toString() == 'null' || rowCostAnalysisByMonthViewModel.rowCostAnalysisByMonthList.data!.findsTableDataOfRowCosAnalysisPage![index].streetAddress!.isEmpty)
//                                                                                 ? 'N/A'
//                                                                                 : rowCostAnalysisByMonthViewModel.rowCostAnalysisByMonthList.data!.findsTableDataOfRowCosAnalysisPage![index].streetAddress.toString(),
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
//                                                                             (rowCostAnalysisByMonthViewModel.rowCostAnalysisByMonthList.data!.findsTableDataOfRowCosAnalysisPage![index].mapLocation == null || rowCostAnalysisByMonthViewModel.rowCostAnalysisByMonthList.data!.findsTableDataOfRowCosAnalysisPage![index].mapLocation.toString() == 'null' || rowCostAnalysisByMonthViewModel.rowCostAnalysisByMonthList.data!.findsTableDataOfRowCosAnalysisPage![index].mapLocation!.isEmpty)
//                                                                                 ? 'N/A'
//                                                                                 : rowCostAnalysisByMonthViewModel.rowCostAnalysisByMonthList.data!.findsTableDataOfRowCosAnalysisPage![index].mapLocation.toString(),
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
//                                                                             (rowCostAnalysisByMonthViewModel.rowCostAnalysisByMonthList.data!.findsTableDataOfRowCosAnalysisPage![index].adminNotes1 == null || rowCostAnalysisByMonthViewModel.rowCostAnalysisByMonthList.data!.findsTableDataOfRowCosAnalysisPage![index].adminNotes1.toString() == 'null' || rowCostAnalysisByMonthViewModel.rowCostAnalysisByMonthList.data!.findsTableDataOfRowCosAnalysisPage![index].adminNotes1!.isEmpty)
//                                                                                 ? 'N/A'
//                                                                                 : rowCostAnalysisByMonthViewModel.rowCostAnalysisByMonthList.data!.findsTableDataOfRowCosAnalysisPage![index].adminNotes1.toString(),
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
//                                                                             (rowCostAnalysisByMonthViewModel.rowCostAnalysisByMonthList.data!.findsTableDataOfRowCosAnalysisPage![index].contactorCompany == null || rowCostAnalysisByMonthViewModel.rowCostAnalysisByMonthList.data!.findsTableDataOfRowCosAnalysisPage![index].contactorCompany.toString() == 'null' || rowCostAnalysisByMonthViewModel.rowCostAnalysisByMonthList.data!.findsTableDataOfRowCosAnalysisPage![index].contactorCompany!.isEmpty)
//                                                                                 ? 'N/A'
//                                                                                 : rowCostAnalysisByMonthViewModel.rowCostAnalysisByMonthList.data!.findsTableDataOfRowCosAnalysisPage![index].contactorCompany.toString(),
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
//                                                                             (rowCostAnalysisByMonthViewModel.rowCostAnalysisByMonthList.data!.findsTableDataOfRowCosAnalysisPage![index].dateOfInspection == null || rowCostAnalysisByMonthViewModel.rowCostAnalysisByMonthList.data!.findsTableDataOfRowCosAnalysisPage![index].dateOfInspection.toString() == 'null' || rowCostAnalysisByMonthViewModel.rowCostAnalysisByMonthList.data!.findsTableDataOfRowCosAnalysisPage![index].dateOfInspection!.isEmpty)
//                                                                                 ? 'N/A'
//                                                                                 : rowCostAnalysisByMonthViewModel.rowCostAnalysisByMonthList.data!.findsTableDataOfRowCosAnalysisPage![index].dateOfInspection.toString(),
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
//                                                                             (rowCostAnalysisByMonthViewModel.rowCostAnalysisByMonthList.data!.findsTableDataOfRowCosAnalysisPage![index].followUpDate == null || rowCostAnalysisByMonthViewModel.rowCostAnalysisByMonthList.data!.findsTableDataOfRowCosAnalysisPage![index].followUpDate.toString() == 'null' || rowCostAnalysisByMonthViewModel.rowCostAnalysisByMonthList.data!.findsTableDataOfRowCosAnalysisPage![index].followUpDate!.isEmpty)
//                                                                                 ? 'N/A'
//                                                                                 : rowCostAnalysisByMonthViewModel.rowCostAnalysisByMonthList.data!.findsTableDataOfRowCosAnalysisPage![index].followUpDate.toString(),
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
//                                                                             (rowCostAnalysisByMonthViewModel.rowCostAnalysisByMonthList.data!.findsTableDataOfRowCosAnalysisPage![index].costPerMile == null || rowCostAnalysisByMonthViewModel.rowCostAnalysisByMonthList.data!.findsTableDataOfRowCosAnalysisPage![index].costPerMile.toString() == 'null' || rowCostAnalysisByMonthViewModel.rowCostAnalysisByMonthList.data!.findsTableDataOfRowCosAnalysisPage![index].costPerMile!.isEmpty)
//                                                                                 ? 'N/A'
//                                                                                 : rowCostAnalysisByMonthViewModel.rowCostAnalysisByMonthList.data!.findsTableDataOfRowCosAnalysisPage![index].costPerMile.toString(),
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
//                                                                             (rowCostAnalysisByMonthViewModel.rowCostAnalysisByMonthList.data!.findsTableDataOfRowCosAnalysisPage![index].totalCost == null || rowCostAnalysisByMonthViewModel.rowCostAnalysisByMonthList.data!.findsTableDataOfRowCosAnalysisPage![index].totalCost.toString() == 'null' || rowCostAnalysisByMonthViewModel.rowCostAnalysisByMonthList.data!.findsTableDataOfRowCosAnalysisPage![index].totalCost!.isEmpty)
//                                                                                 ? 'N/A'
//                                                                                 : rowCostAnalysisByMonthViewModel.rowCostAnalysisByMonthList.data!.findsTableDataOfRowCosAnalysisPage![index].totalCost.toString(),
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
//                                                                             (rowCostAnalysisByMonthViewModel.rowCostAnalysisByMonthList.data!.findsTableDataOfRowCosAnalysisPage![index].nextMaintDue == null || rowCostAnalysisByMonthViewModel.rowCostAnalysisByMonthList.data!.findsTableDataOfRowCosAnalysisPage![index].nextMaintDue.toString() == 'null' || rowCostAnalysisByMonthViewModel.rowCostAnalysisByMonthList.data!.findsTableDataOfRowCosAnalysisPage![index].nextMaintDue!.isEmpty)
//                                                                                 ? 'N/A'
//                                                                                 : rowCostAnalysisByMonthViewModel.rowCostAnalysisByMonthList.data!.findsTableDataOfRowCosAnalysisPage![index].nextMaintDue.toString(),
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

//   List<_ChartDataSimpleColumnChart1>
//       recreateDataVegetationMaintenanceCostByYearMonth(
//           RowCostAnalysisByMonthViewModel value) {
//     chartDataSimpleColumnChart1.clear();

//     for (var i = 0;
//         i <
//             rowCostAnalysisByMonthViewModel.rowCostAnalysisByMonthList.data!
//                 .getSPROWCOSTANALYSISBYMONTH!.length;
//         i++) {
//       chartDataSimpleColumnChart1.add(_ChartDataSimpleColumnChart1(
//           (rowCostAnalysisByMonthViewModel.rowCostAnalysisByMonthList.data!.getSPROWCOSTANALYSISBYMONTH![i].yrMonth == null || rowCostAnalysisByMonthViewModel.rowCostAnalysisByMonthList.data!.getSPROWCOSTANALYSISBYMONTH![i].yrMonth.toString() == 'null')
//               ? 'N/A'
//               : rowCostAnalysisByMonthViewModel.rowCostAnalysisByMonthList.data!
//                   .getSPROWCOSTANALYSISBYMONTH![i].yrMonth
//                   .toString(),
//           (rowCostAnalysisByMonthViewModel.rowCostAnalysisByMonthList.data!.getSPROWCOSTANALYSISBYMONTH![i].herbicide == null ||
//                   rowCostAnalysisByMonthViewModel.rowCostAnalysisByMonthList
//                           .data!.getSPROWCOSTANALYSISBYMONTH![i].herbicide
//                           .toString() ==
//                       'null')
//               ? 0.0
//               : double.parse(
//                   rowCostAnalysisByMonthViewModel.rowCostAnalysisByMonthList
//                       .data!.getSPROWCOSTANALYSISBYMONTH![i].herbicide
//                       .toString(),
//                 ),
//           (rowCostAnalysisByMonthViewModel.rowCostAnalysisByMonthList.data!.getSPROWCOSTANALYSISBYMONTH![i].mechanicalCleaning == null ||
//                   rowCostAnalysisByMonthViewModel
//                           .rowCostAnalysisByMonthList
//                           .data!
//                           .getSPROWCOSTANALYSISBYMONTH![i]
//                           .mechanicalCleaning
//                           .toString() ==
//                       'null')
//               ? 0.0
//               : double.parse(
//                   rowCostAnalysisByMonthViewModel.rowCostAnalysisByMonthList
//                       .data!.getSPROWCOSTANALYSISBYMONTH![i].mechanicalCleaning
//                       .toString(),
//                 ),
//           (rowCostAnalysisByMonthViewModel.rowCostAnalysisByMonthList.data!.getSPROWCOSTANALYSISBYMONTH![i].mechanicalPruning == null ||
//                   rowCostAnalysisByMonthViewModel
//                           .rowCostAnalysisByMonthList
//                           .data!
//                           .getSPROWCOSTANALYSISBYMONTH![i]
//                           .mechanicalPruning
//                           .toString() ==
//                       'null')
//               ? 0.0
//               : double.parse(
//                   rowCostAnalysisByMonthViewModel.rowCostAnalysisByMonthList
//                       .data!.getSPROWCOSTANALYSISBYMONTH![i].mechanicalPruning
//                       .toString(),
//                 ),
//           (rowCostAnalysisByMonthViewModel.rowCostAnalysisByMonthList.data!.getSPROWCOSTANALYSISBYMONTH![i].arealPruning == null ||
//                   rowCostAnalysisByMonthViewModel.rowCostAnalysisByMonthList.data!.getSPROWCOSTANALYSISBYMONTH![i].arealPruning.toString() == 'null')
//               ? 0.0
//               : double.parse(
//                   rowCostAnalysisByMonthViewModel.rowCostAnalysisByMonthList
//                       .data!.getSPROWCOSTANALYSISBYMONTH![i].arealPruning
//                       .toString(),
//                 ),
//           (rowCostAnalysisByMonthViewModel.rowCostAnalysisByMonthList.data!.getSPROWCOSTANALYSISBYMONTH![i].pruning == null || rowCostAnalysisByMonthViewModel.rowCostAnalysisByMonthList.data!.getSPROWCOSTANALYSISBYMONTH![i].pruning.toString() == 'null')
//               ? 0.0
//               : double.parse(
//                   rowCostAnalysisByMonthViewModel.rowCostAnalysisByMonthList
//                       .data!.getSPROWCOSTANALYSISBYMONTH![i].pruning
//                       .toString(),
//                 ),
//           (rowCostAnalysisByMonthViewModel.rowCostAnalysisByMonthList.data!.getSPROWCOSTANALYSISBYMONTH![i].selectiveMechanicalTreeRemoval == null || rowCostAnalysisByMonthViewModel.rowCostAnalysisByMonthList.data!.getSPROWCOSTANALYSISBYMONTH![i].selectiveMechanicalTreeRemoval.toString() == 'null')
//               ? 0.0
//               : double.parse(
//                   rowCostAnalysisByMonthViewModel
//                       .rowCostAnalysisByMonthList
//                       .data!
//                       .getSPROWCOSTANALYSISBYMONTH![i]
//                       .selectiveMechanicalTreeRemoval
//                       .toString(),
//                 )));

//       print('Herbicides1111111111111111');
//       print(rowCostAnalysisByMonthViewModel.rowCostAnalysisByMonthList.data!
//           .getSPROWCOSTANALYSISBYMONTH![0].herbicide
//           .toString());
//     }
//     return chartDataSimpleColumnChart1;
//   }

//   void fetchData(String substation, String feeder, String nextMaintDueYr,
//       String nextMaintDueMonth) {
//     rowCostAnalysisByMonthViewModel.fetchRowCostAnalysisByMonthListApi(
//         context, substation, feeder, nextMaintDueYr, nextMaintDueMonth);
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
// }

// class _ChartDataSimpleColumnChart1 {
//   _ChartDataSimpleColumnChart1(
//       this.x, this.y, this.y1, this.y2, this.y3, this.y4, this.y5);

//   final String x;
//   final double y;
//   final double y1;
//   final double y2;
//   final double y3;
//   final double y4;
//   final double y5;
// }
