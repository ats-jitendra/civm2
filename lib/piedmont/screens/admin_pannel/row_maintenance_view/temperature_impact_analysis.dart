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
// import 'package:provider/provider.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';
// import '../../../data/response/status.dart';
// import '../../../view_model/temperature_impact_analysis_view_model.dart';
// import 'package:CIVM/piedmont/resources/app_colors.dart';

// // ignore: must_be_immutable
// class TemperatureImpactAnalysis extends StatefulWidget {
//   const TemperatureImpactAnalysis({Key? key}) : super(key: key);

//   @override
//   State<TemperatureImpactAnalysis> createState() =>
//       _TemperatureImpactAnalysisState();
// }

// class _TemperatureImpactAnalysisState extends State<TemperatureImpactAnalysis> {
// // ignore: prefer_typing_uninitialized_variables
//   var selectedSubstation;
//   int substationId = 0;

// // ignore: prefer_typing_uninitialized_variables
//   var selectedFeeder;
//   int feederId = 0;

//   // ignore: prefer_typing_uninitialized_variables
//   var selectedOutageCause;
//   int outageCauseId = 0;

//   // late final List<charts.Series> seriesList;
//   late final bool animate = true;
//   final TextEditingController _input = TextEditingController();
//   late final Future? myFuture;
//   var result = [];

//   List<_ChartDataSimpleColumnChart1> dataSimpleColumnChart1 = [];
//   DateTime date20 = DateTime.now();
//   late String dateSelected20 = DateFormat('MM/dd/yyyy').format(date20);

//   DateTime date21 = DateTime.now();
//   late String dateSelected21 = DateFormat('MM/dd/yyyy').format(date21);

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
//         dateSelected20 = DateFormat('MM/dd/yyyy').format(picked20);
//       });
//     }
//   }

//   Future<void> selectDate21(BuildContext context) async {
//     final DateTime? picked21 = await showDatePicker(
//         context: context,
//         initialDate: date21,
//         firstDate: DateTime(2010),
//         lastDate: DateTime(2050));
//     if (picked21 != null && picked21 != date21) {
//       setState(() {
//         date21 = picked21;
//         // print(date12.toString());
//         dateSelected21 = DateFormat('MM/dd/yyyy').format(picked21);
//       });
//     }
//   }

//   final browser = MyChromeSafariBrowser();
//   TemperatureImpactAnalysisViewModel temperatureImpactAnalysisViewModel =
//       TemperatureImpactAnalysisViewModel();

//   @override
//   void initState() {
//     temperatureImpactAnalysisViewModel.fetchTemperatureImpactAnalysisListApi(
//         context, '', '', '', '', '');
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
//             'Temperature Impact Analysis',
//             style: TextStyle(color: Colors.white),
//           ),
//           backgroundColor: AppColors.baseColor,
//           actions: const <Widget>[],
//         ),
//         body: ChangeNotifierProvider<TemperatureImpactAnalysisViewModel>(
//             create: (BuildContext context) =>
//                 temperatureImpactAnalysisViewModel,
//             child: Consumer<TemperatureImpactAnalysisViewModel>(
//                 builder: (context, value, _) {
//               switch (value.temperatureImpactAnalysisList.status) {
//                 case Status.LOADING:
//                   return const Center(child: CircularProgressIndicator());
//                 case Status.ERROR:
//                   return
//                       // CustomToastSnackBarProgressDialog.flushBarErrorMessage(
//                       //     value.temperatureImpactAnalysisList.message.toString(),
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
//                               onRefresh: () async {
//                                 await   temperatureImpactAnalysisViewModel.fetchTemperatureImpactAnalysisListApi(
//         context, '', '', '', '', '');
//                               },
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
//                                               padding: const EdgeInsets.symmetric(
//                                                   horizontal: 12, vertical: 4),
//                                               width: size.width * 0.4,
//                                               decoration: BoxDecoration(
//                                                 borderRadius:
//                                                     BorderRadius.circular(25),
//                                                 border: Border.all(
//                                                   color: const Color.fromARGB(
//                                                       255, 7, 59, 120),
//                                                 ),
//                                               ),
//                                               child:
//                                                   DropdownButtonFormField<String>(
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
//                                                 items: temperatureImpactAnalysisViewModel
//                                                     .temperatureImpactAnalysisList
//                                                     .data!
//                                                     .findSubstationsByCountyOfTmpImpactAnalysisPage!
//                                                     .map((e) {
//                                                   return DropdownMenuItem(
//                                                     value: e.id.toString(),
//                                                     child: Text(
//                                                         e.substation.toString()),
//                                                   );
//                                                 }).toList(),
//                                                 onChanged: (val) {
//                                                   if (selectedFeeder != null ||
//                                                       selectedOutageCause !=
//                                                           null) {
//                                                     selectedFeeder = null;
//                                                     selectedOutageCause = null;
//                                                   }
//                                                   print('val');
//                                                   print(val);
//                                                   fetchData(
//                                                       val!,
//                                                       '',
//                                                       dateSelected20,
//                                                       dateSelected21,
//                                                       '');
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
//                                               padding: const EdgeInsets.symmetric(
//                                                   horizontal: 12, vertical: 4),
//                                               width: size.width * 0.4,
//                                               decoration: BoxDecoration(
//                                                 borderRadius:
//                                                     BorderRadius.circular(25),
//                                                 border: Border.all(
//                                                   color: const Color.fromARGB(
//                                                       255, 7, 59, 120),
//                                                 ),
//                                               ),
//                                               child:
//                                                   DropdownButtonFormField<String>(
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
//                                                 items: temperatureImpactAnalysisViewModel
//                                                     .temperatureImpactAnalysisList
//                                                     .data!
//                                                     .findsFdrNameAndIdsBySubstation!
//                                                     .map((e) {
//                                                   return DropdownMenuItem(
//                                                     value: e.id.toString(),
//                                                     child: Text(
//                                                         e.fdrName.toString()),
//                                                   );
//                                                 }).toList(),
//                                                 onChanged: (val) {
//                                                   if (selectedOutageCause !=
//                                                       null) {
//                                                     selectedOutageCause = null;
//                                                   }
//                                                   print('val');
//                                                   print(val);
//                                                   fetchData(
//                                                       substationId.toString(),
//                                                       val!,
//                                                       dateSelected20,
//                                                       dateSelected21,
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
//                                                 "Outage Cause",
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
//                                               padding: const EdgeInsets.symmetric(
//                                                   horizontal: 12, vertical: 4),
//                                               width: size.width * 0.4,
//                                               decoration: BoxDecoration(
//                                                 borderRadius:
//                                                     BorderRadius.circular(25),
//                                                 border: Border.all(
//                                                   color: const Color.fromARGB(
//                                                       255, 7, 59, 120),
//                                                 ),
//                                               ),
//                                               child:
//                                                   DropdownButtonFormField<String>(
//                                                 dropdownColor: Colors.white,
//                                                 value: selectedOutageCause,
//                                                 style: const TextStyle(
//                                                     color: Color.fromARGB(
//                                                         255, 7, 59, 120),
//                                                     fontSize: 16),
//                                                 icon: const Icon(
//                                                   Icons.arrow_downward_rounded,
//                                                   color: Color.fromARGB(
//                                                       255, 47, 62, 74),
//                                                   size: 25,
//                                                 ),
//                                                 isExpanded: true,
//                                                 items: temperatureImpactAnalysisViewModel
//                                                     .temperatureImpactAnalysisList
//                                                     .data!
//                                                     .findsDelayCauseBySubstationAndFdrOfTmpImpactAnalysisPage!
//                                                     .map((e) {
//                                                   return DropdownMenuItem(
//                                                     value:
//                                                         e.delayCause.toString(),
//                                                     child: Text(
//                                                         e.delayCause.toString()),
//                                                   );
//                                                 }).toList(),
//                                                 onChanged: (val) {
//                                                   print('val');
//                                                   print(val);
//                                                   fetchData(
//                                                       substationId.toString(),
//                                                       feederId.toString(),
//                                                       dateSelected20,
//                                                       dateSelected21,
//                                                       val!);
//                                                   substationId =
//                                                       int.parse(val.toString());
//                                                   print('111111111111111');
//                                                   // print(id.text.toString());
//                                                   setState(() {
//                                                     selectedOutageCause = val;
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
//                                   // Padding(
//                                   //   padding: const EdgeInsets.only(
//                                   //       top: 10, bottom: 2, left: 2, right: 2),
//                                   //   child: Column(
//                                   //     children: [
//                                   //       const Align(
//                                   //           alignment: Alignment.centerLeft,
//                                   //           child: Padding(
//                                   //             padding: EdgeInsets.all(2.0),
//                                   //             child: Text(
//                                   //               "Maintenance Type",
//                                   //               style: TextStyle(
//                                   //                 fontSize: 16.0,
//                                   //                 color: Color.fromARGB(
//                                   //                     255, 7, 59, 120),
//                                   //                 // fontWeight: FontWeight.bold,
//                                   //               ),
//                                   //             ),
//                                   //           )),
//                                   //       Align(
//                                   //         alignment: Alignment.centerLeft,
//                                   //         child: Padding(
//                                   //           padding: const EdgeInsets.all(2.0),
//                                   //           child: Container(
//                                   //             padding: const EdgeInsets.symmetric(
//                                   //                 horizontal: 12, vertical: 4),
//                                   //             width: size.width * 0.4,
//                                   //             decoration: BoxDecoration(
//                                   //               borderRadius:
//                                   //                   BorderRadius.circular(25),
//                                   //               border: Border.all(
//                                   //                 color: const Color.fromARGB(
//                                   //                     255, 7, 59, 120),
//                                   //               ),
//                                   //             ),
//                                   //             child:
//                                   //                 DropdownButtonFormField<String>(
//                                   //               dropdownColor: Colors.white,
//                                   //               value: nextMaint,
//                                   //               style: const TextStyle(
//                                   //                   color: Color.fromARGB(
//                                   //                       255, 7, 59, 120),
//                                   //                   fontSize: 16),
//                                   //               icon: const Icon(
//                                   //                 Icons.arrow_downward_rounded,
//                                   //                 color: Color.fromARGB(
//                                   //                     255, 7, 59, 120),
//                                   //                 size: 25,
//                                   //               ),
//                                   //               isExpanded: true,
//                                   //               items: select_nextMaint
//                                   //                   .map(buildMenuItem)
//                                   //                   .toList(),
//                                   //               onChanged: (value) => setState(
//                                   //                   () => nextMaint = value),
//                                   //               validator: (value) =>
//                                   //                   value == null
//                                   //                       ? 'field required'
//                                   //                       : null,
//                                   //             ),
//                                   //           ),
//                                   //         ),
//                                   //       ),
//                                   //     ],
//                                   //   ),
//                                   // ),
//                                 ],
//                               ),
//                             ),
//                             const Align(
//                               alignment: Alignment.bottomLeft,
//                               child: Padding(
//                                 padding: EdgeInsets.only(left: 8.0, top: 8),
//                                 child: Text(
//                                   "Date:",
//                                   style: TextStyle(
//                                     fontSize: 16.0,
//                                     color: AppColors.baseColor,
//                                     //fontWeight: FontWeight.bold
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             Row(
//                               children: [
//                                 Expanded(
//                                   child: Column(
//                                     children: [
//                                       Padding(
//                                         padding: const EdgeInsets.only(
//                                             left: 4.0, right: 4, top: 4),
//                                         child: Container(
//                                           height: 60,
//                                           decoration: BoxDecoration(
//                                               // shape: BoxShape.circle,
//                                               borderRadius:
//                                                   BorderRadius.circular(25),
//                                               boxShadow: const [],
//                                               gradient: const LinearGradient(
//                                                 colors: [
//                                                   AppColors.baseColor,
//                                                   AppColors.baseColor,
//                                                 ],
//                                               )),
//                                           child: Padding(
//                                             padding: const EdgeInsets.all(1.0),
//                                             child: Container(
//                                               decoration: BoxDecoration(
//                                                   // shape: BoxShape.circle,
//                                                   borderRadius:
//                                                       BorderRadius.circular(25),
//                                                   boxShadow: const [],
//                                                   gradient: const LinearGradient(
//                                                     colors: [
//                                                       Colors.white,
//                                                       Colors.white,
//                                                     ],
//                                                   )),
//                                               child: Padding(
//                                                 padding: const EdgeInsets.only(
//                                                     left: 8.0),
//                                                 child: Expanded(
//                                                   child: Row(
//                                                     children: [
//                                                       Padding(
//                                                         padding:
//                                                             const EdgeInsets.only(
//                                                                 top: 2),
//                                                         child: IconButton(
//                                                           icon: const Icon(Icons
//                                                               .calendar_month),
//                                                           iconSize: 22,
//                                                           color: const Color
//                                                               .fromARGB(
//                                                               255, 7, 59, 120),
//                                                           onPressed: () {
//                                                             selectDate20(context);
//                                                             // print(date);
//                                                           },
//                                                         ),
//                                                       ),
//                                                       Padding(
//                                                         padding:
//                                                             const EdgeInsets.only(
//                                                                 left: 2),
//                                                         child: Text(
//                                                             dateSelected20,
//                                                             style:
//                                                                 const TextStyle(
//                                                               fontSize: 16,
//                                                               color:
//                                                                   Color.fromARGB(
//                                                                       255,
//                                                                       7,
//                                                                       59,
//                                                                       120),
//                                                             )),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 Expanded(
//                                   child: Padding(
//                                     padding: const EdgeInsets.only(
//                                         left: 4.0, right: 4, top: 4),
//                                     child: Container(
//                                       height: 60,
//                                       decoration: BoxDecoration(
//                                           // shape: BoxShape.circle,
//                                           borderRadius: BorderRadius.circular(25),
//                                           boxShadow: const [],
//                                           gradient: const LinearGradient(
//                                             colors: [
//                                               AppColors.baseColor,
//                                               AppColors.baseColor,
//                                             ],
//                                           )),
//                                       child: Padding(
//                                         padding: const EdgeInsets.all(1.0),
//                                         child: Container(
//                                           decoration: BoxDecoration(
//                                               // shape: BoxShape.circle,
//                                               borderRadius:
//                                                   BorderRadius.circular(25),
//                                               boxShadow: const [],
//                                               gradient: const LinearGradient(
//                                                 colors: [
//                                                   Colors.white,
//                                                   Colors.white,
//                                                 ],
//                                               )),
//                                           child: Padding(
//                                             padding:
//                                                 const EdgeInsets.only(left: 8.0),
//                                             child: Expanded(
//                                               child: Row(
//                                                 children: [
//                                                   Padding(
//                                                     padding:
//                                                         const EdgeInsets.only(
//                                                             top: 2),
//                                                     child: IconButton(
//                                                       icon: const Icon(
//                                                           Icons.calendar_month),
//                                                       iconSize: 22,
//                                                       color: const Color.fromARGB(
//                                                           255, 7, 59, 120),
//                                                       onPressed: () {
//                                                         selectDate21(context);
//                                                         // print(date);
//                                                       },
//                                                     ),
//                                                   ),
//                                                   Padding(
//                                                     padding:
//                                                         const EdgeInsets.only(
//                                                             left: 2),
//                                                     child: Text(dateSelected21,
//                                                         style: const TextStyle(
//                                                           fontSize: 16,
//                                                           color: Color.fromARGB(
//                                                               255, 7, 59, 120),
//                                                         )),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(
//                                   top: 16.0, left: 16, right: 16),
//                               child: Container(
//                                 padding: const EdgeInsets.all(10),
//                                 alignment: Alignment.center,
//                                 width: size.width * 0.7,
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
//                                             "COMPLETED MILES: ",
//                                             textAlign: TextAlign.left,
//                                             style: TextStyle(
//                                               color:
//                                                   AppColors.baseColor,
//                                               fontWeight: FontWeight.bold,
//                                               fontSize: 20,
//                                             ),
//                                           ),
//                                         ),
//                                         Padding(
//                                           padding:
//                                               const EdgeInsets.only(right: 8.0),
//                                           child: Text(
//                                             temperatureImpactAnalysisViewModel
//                                                 .temperatureImpactAnalysisList
//                                                 .data!
//                                                 .findCustomerCountOfTmpImpactAnalysisPages![
//                                                     0]
//                                                 .customerCount!
//                                                 .toStringAsFixed(0),
//                                             textAlign: TextAlign.left,
//                                             style: const TextStyle(
//                                               color:
//                                                   AppColors.baseColor,
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
//                                               color:
//                                                   Color.fromARGB(255, 3, 47, 97),
//                                               blurRadius: 5,
//                                               offset: Offset(2.0, 5.0))
//                                         ],
//                                         color: Color.fromARGB(255, 130, 193, 245),
//                                         gradient: LinearGradient(
//                                           colors: [
//                                             AppColors.baseColor,
//                                             Color.fromARGB(255, 7, 59, 120)
//                                           ],
//                                         )),
//                                     child: const Align(
//                                       alignment: Alignment.centerLeft,
//                                       child: Text(
//                                         "Outage Count and Temperature by Substation",
//                                         textAlign: TextAlign.left,
//                                         style: TextStyle(
//                                           color: Colors.white,
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 20,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   Expanded(
//                                     child: SfCartesianChart(
//                                       primaryXAxis: CategoryAxis(
//                                         title: AxisTitle(
//                                             text: 'Substation',
//                                             textStyle: const TextStyle(
//                                                 color: Colors.red,
//                                                 fontFamily: 'Roboto',
//                                                 fontSize: 16,
//                                                 fontStyle: FontStyle.italic,
//                                                 fontWeight: FontWeight.bold)),
//                                       ),
//                                       primaryYAxis: CategoryAxis(
//                                         title: AxisTitle(
//                                             text: 'Outage Count',
//                                             textStyle: const TextStyle(
//                                                 color: Colors.red,
//                                                 fontFamily: 'Roboto',
//                                                 fontSize: 16,
//                                                 fontStyle: FontStyle.italic,
//                                                 fontWeight: FontWeight.bold)),
//                                       ),
//                                       legend: Legend(isVisible: true),
//                                       palette: const <Color>[
//                                         Colors.red,
//                                         Color.fromARGB(255, 15, 3, 182),
//                                       ],
//                                       series: <CartesianSeries>[
//                                         ColumnSeries<_ChartDataSimpleColumnChart1,
//                                                 String>(
//                                             name: 'OUTAGE COUNT',
//                                             dataSource:
//                                                 recreateDataOutageCountByTemperature(
//                                                     value),
//                                             xValueMapper:
//                                                 (_ChartDataSimpleColumnChart1
//                                                             data,
//                                                         _) =>
//                                                     data.x,
//                                             yValueMapper:
//                                                 (_ChartDataSimpleColumnChart1
//                                                             data,
//                                                         _) =>
//                                                     data.y),
//                                         ColumnSeries<_ChartDataSimpleColumnChart1,
//                                                 String>(
//                                             name: 'TEMPERATURE',
//                                             dataSource: dataSimpleColumnChart1,
//                                             xValueMapper:
//                                                 (_ChartDataSimpleColumnChart1
//                                                             data,
//                                                         _) =>
//                                                     data.x,
//                                             yValueMapper:
//                                                 (_ChartDataSimpleColumnChart1
//                                                             data,
//                                                         _) =>
//                                                     data.y1)
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
//                                           color: AppColors.baseColor,
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
//                                           padding:
//                                               EdgeInsets.only(top: 8.0, left: 8),
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
//                                             temperatureImpactAnalysisViewModel
//                                                 .temperatureImpactAnalysisList
//                                                 .data!
//                                                 .getVMAVEGETATIONCREWFORM!
//                                                 .length
//                                                 .toString(),
//                                             textAlign: TextAlign.left,
//                                             style: const TextStyle(
//                                               color:
//                                                   AppColors.baseColor,
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
//                                                         BorderRadius.circular(25),
//                                                   ),
//                                                   enabledBorder:
//                                                       OutlineInputBorder(
//                                                     borderSide: const BorderSide(
//                                                       color: Color.fromARGB(
//                                                           255, 23, 1, 88),
//                                                     ),
//                                                     borderRadius:
//                                                         BorderRadius.circular(25),
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
//                                                 temperatureImpactAnalysisViewModel
//                                                     .temperatureImpactAnalysisList
//                                                     .data!
//                                                     .getVMAVEGETATIONCREWFORM!
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
//                                                           const EdgeInsets.all(8),
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
//                                                                   (temperatureImpactAnalysisViewModel
//                                                                                   .temperatureImpactAnalysisList
//                                                                                   .data!
//                                                                                   .getVMAVEGETATIONCREWFORM![
//                                                                                       index]
//                                                                                   .type ==
//                                                                               null ||
//                                                                           temperatureImpactAnalysisViewModel.temperatureImpactAnalysisList.data!.getVMAVEGETATIONCREWFORM![index].type.toString() ==
//                                                                               'null' ||
//                                                                           temperatureImpactAnalysisViewModel
//                                                                               .temperatureImpactAnalysisList
//                                                                               .data!
//                                                                               .getVMAVEGETATIONCREWFORM![
//                                                                                   index]
//                                                                               .type!
//                                                                               .isEmpty)
//                                                                       ? 'N/A'
//                                                                       : temperatureImpactAnalysisViewModel
//                                                                           .temperatureImpactAnalysisList
//                                                                           .data!
//                                                                           .getVMAVEGETATIONCREWFORM![
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
//                                                                   (temperatureImpactAnalysisViewModel.temperatureImpactAnalysisList.data!.getVMAVEGETATIONCREWFORM![index].tblSubMilesCostId ==
//                                                                               null ||
//                                                                           temperatureImpactAnalysisViewModel.temperatureImpactAnalysisList.data!.getVMAVEGETATIONCREWFORM![index].tblSubMilesCostId.toString() ==
//                                                                               'null')
//                                                                       ? 'N/A'
//                                                                       : temperatureImpactAnalysisViewModel
//                                                                           .temperatureImpactAnalysisList
//                                                                           .data!
//                                                                           .getVMAVEGETATIONCREWFORM![
//                                                                               index]
//                                                                           .tblSubMilesCostId
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
//                                                                   (temperatureImpactAnalysisViewModel
//                                                                                   .temperatureImpactAnalysisList
//                                                                                   .data!
//                                                                                   .getVMAVEGETATIONCREWFORM![
//                                                                                       index]
//                                                                                   .status ==
//                                                                               null ||
//                                                                           temperatureImpactAnalysisViewModel.temperatureImpactAnalysisList.data!.getVMAVEGETATIONCREWFORM![index].status.toString() ==
//                                                                               'null' ||
//                                                                           temperatureImpactAnalysisViewModel
//                                                                               .temperatureImpactAnalysisList
//                                                                               .data!
//                                                                               .getVMAVEGETATIONCREWFORM![
//                                                                                   index]
//                                                                               .status!
//                                                                               .isEmpty)
//                                                                       ? 'N/A'
//                                                                       : temperatureImpactAnalysisViewModel
//                                                                           .temperatureImpactAnalysisList
//                                                                           .data!
//                                                                           .getVMAVEGETATIONCREWFORM![
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
//                                                                   (temperatureImpactAnalysisViewModel
//                                                                                   .temperatureImpactAnalysisList
//                                                                                   .data!
//                                                                                   .getVMAVEGETATIONCREWFORM![
//                                                                                       index]
//                                                                                   .substation ==
//                                                                               null ||
//                                                                           temperatureImpactAnalysisViewModel.temperatureImpactAnalysisList.data!.getVMAVEGETATIONCREWFORM![index].substation.toString() ==
//                                                                               'null' ||
//                                                                           temperatureImpactAnalysisViewModel
//                                                                               .temperatureImpactAnalysisList
//                                                                               .data!
//                                                                               .getVMAVEGETATIONCREWFORM![
//                                                                                   index]
//                                                                               .substation!
//                                                                               .isEmpty)
//                                                                       ? 'N/A'
//                                                                       : temperatureImpactAnalysisViewModel
//                                                                           .temperatureImpactAnalysisList
//                                                                           .data!
//                                                                           .getVMAVEGETATIONCREWFORM![
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
//                                                                   (temperatureImpactAnalysisViewModel
//                                                                                   .temperatureImpactAnalysisList
//                                                                                   .data!
//                                                                                   .getVMAVEGETATIONCREWFORM![
//                                                                                       index]
//                                                                                   .createDate ==
//                                                                               null ||
//                                                                           temperatureImpactAnalysisViewModel.temperatureImpactAnalysisList.data!.getVMAVEGETATIONCREWFORM![index].createDate.toString() ==
//                                                                               'null' ||
//                                                                           temperatureImpactAnalysisViewModel
//                                                                               .temperatureImpactAnalysisList
//                                                                               .data!
//                                                                               .getVMAVEGETATIONCREWFORM![
//                                                                                   index]
//                                                                               .createDate!
//                                                                               .isEmpty)
//                                                                       ? 'N/A'
//                                                                       : temperatureImpactAnalysisViewModel
//                                                                           .temperatureImpactAnalysisList
//                                                                           .data!
//                                                                           .getVMAVEGETATIONCREWFORM![
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
//                                                                 onTap: () async {
//                                                                     String id = '';
//               final userPreferences1 =
//                   Provider.of<UserPref>(context, listen: false);
//               UserModel data = await userPreferences1.getUser();
//               id = data.user!.id.toString();
//                                                                   // Navigator.of(context).push(
//                                                                   //     MaterialPageRoute(
//                                                                   //         builder: (BuildContext
//                                                                   //                 context) =>
//                                                                   //             MapViewAdmin(
//                                                                   //               id: temperatureImpactAnalysisViewModel
//                                                                   //         .temperatureImpactAnalysisList
//                                                                   //         .data!
//                                                                   //         .getVMAVEGETATIONCREWFORM![
//                                                                   //             index].id.toString(),
//                                                                   //             )));
//                                                                     //  Navigator.push(
//                                                                     //           context,
//                                                                     //           MaterialPageRoute(
//                                                                     //             builder: (context) => MapViewPage(
//                                                                     //               url: MapUrl.getAdminEndPoint(temperatureImpactAnalysisViewModel.temperatureImpactAnalysisList.data!.getVMAVEGETATIONCREWFORM![index].id.toString(),id),
//                                                                     //             ),
//                                                                     //           ),
//                                                                     //         );
                    
//                                                                   await browser.open(
//                                                                       url: WebUri(
//                                                                           // "https://mapapi.ariespro.com/main/admin/CIVM_Map/${temperatureImpactAnalysisViewModel.temperatureImpactAnalysisList.data!.getVMAVEGETATIONCREWFORM![index].id.toString()}/USRQWXH589Z"),
//                                                                             MapUrl.getAdminEndPoint(temperatureImpactAnalysisViewModel.temperatureImpactAnalysisList.data!.getVMAVEGETATIONCREWFORM![index].id.toString(),id)),
//                                                                       settings: ChromeSafariBrowserSettings(
//                                                                           shareState:
//                                                                               CustomTabsShareState
//                                                                                   .SHARE_STATE_OFF,
//                                                                           barCollapsingEnabled:
//                                                                               true));
//                                                                 },
//                                                                 child: Align(
//                                                                   alignment: Alignment
//                                                                       .centerLeft,
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
//                                                                     decoration:
//                                                                         const BoxDecoration(
//                                                                             // shape: BoxShape.circle,
                    
//                                                                             color: Color.fromARGB(
//                                                                                 255,
//                                                                                 0,
//                                                                                 58,
//                                                                                 106),
//                                                                             gradient:
//                                                                                 LinearGradient(
//                                                                               colors: [
//                                                                                 Color.fromARGB(255, 0, 79, 215),
//                                                                                 Colors.blue,
//                                                                                 Color.fromARGB(255, 0, 79, 215),
//                                                                               ],
//                                                                             )),
//                                                                     child:
//                                                                         const Align(
//                                                                       alignment:
//                                                                           Alignment
//                                                                               .center,
//                                                                       child: Text(
//                                                                         "VIEW MAP",
//                                                                         style:
//                                                                             TextStyle(
//                                                                           color: Colors
//                                                                               .white,
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
//                                                           const EdgeInsets.all(8),
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
//                                                                   bottomRight: Radius
//                                                                       .circular(
//                                                                           10))),
//                                                       child: Column(children: [
//                                                         Row(
//                                                           children: [
//                                                             Expanded(
//                                                               child: Row(
//                                                                 children: [
//                                                                   Expanded(
//                                                                     // alignment: Alignment.topLeft,
//                                                                     child: Column(
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
//                                                                               fontSize:
//                                                                                   12,
//                                                                               fontWeight:
//                                                                                   FontWeight.bold,
//                                                                               color: Color.fromARGB(
//                                                                                   255,
//                                                                                   7,
//                                                                                   59,
//                                                                                   120),
//                                                                             ),
//                                                                           ),
//                                                                         ),
//                                                                         Align(
//                                                                           alignment:
//                                                                               Alignment.topLeft,
//                                                                           child:
//                                                                               Text(
//                                                                             (temperatureImpactAnalysisViewModel.temperatureImpactAnalysisList.data!.getVMAVEGETATIONCREWFORM![index].feeder == null || temperatureImpactAnalysisViewModel.temperatureImpactAnalysisList.data!.getVMAVEGETATIONCREWFORM![index].feeder.toString() == 'null' || temperatureImpactAnalysisViewModel.temperatureImpactAnalysisList.data!.getVMAVEGETATIONCREWFORM![index].feeder!.isEmpty)
//                                                                                 ? 'N/A'
//                                                                                 : temperatureImpactAnalysisViewModel.temperatureImpactAnalysisList.data!.getVMAVEGETATIONCREWFORM![index].feeder.toString(),
//                                                                             textAlign:
//                                                                                 TextAlign.left,
//                                                                             style:
//                                                                                 const TextStyle(
//                                                                               fontSize:
//                                                                                   12,
//                                                                               //  fontWeight:
//                                                                               //      FontWeight.bold,
//                                                                               color: Color.fromARGB(
//                                                                                   255,
//                                                                                   7,
//                                                                                   59,
//                                                                                   120),
//                                                                             ),
//                                                                           ),
//                                                                         ),
//                                                                       ],
//                                                                     ),
//                                                                   ),
//                                                                   Expanded(
//                                                                     // alignment: Alignment.topLeft,
//                                                                     child: Column(
//                                                                       children: [
//                                                                         const Align(
//                                                                           alignment:
//                                                                               Alignment.topLeft,
//                                                                           child:
//                                                                               Text(
//                                                                             "TEMPERATURE: ",
//                                                                             textAlign:
//                                                                                 TextAlign.left,
//                                                                             style:
//                                                                                 TextStyle(
//                                                                               fontSize:
//                                                                                   12,
//                                                                               fontWeight:
//                                                                                   FontWeight.bold,
//                                                                               color: Color.fromARGB(
//                                                                                   255,
//                                                                                   7,
//                                                                                   59,
//                                                                                   120),
//                                                                             ),
//                                                                           ),
//                                                                         ),
//                                                                         Align(
//                                                                           alignment:
//                                                                               Alignment.topLeft,
//                                                                           child:
//                                                                               Text(
//                                                                             (temperatureImpactAnalysisViewModel.temperatureImpactAnalysisList.data!.getVMAVEGETATIONCREWFORM![index].temp == null || temperatureImpactAnalysisViewModel.temperatureImpactAnalysisList.data!.getVMAVEGETATIONCREWFORM![index].temp.toString() == 'null' || temperatureImpactAnalysisViewModel.temperatureImpactAnalysisList.data!.getVMAVEGETATIONCREWFORM![index].temp!.isEmpty)
//                                                                                 ? 'N/A'
//                                                                                 : temperatureImpactAnalysisViewModel.temperatureImpactAnalysisList.data!.getVMAVEGETATIONCREWFORM![index].temp.toString(),
//                                                                             textAlign:
//                                                                                 TextAlign.left,
//                                                                             style:
//                                                                                 const TextStyle(
//                                                                               fontSize:
//                                                                                   12,
//                                                                               //  fontWeight:
//                                                                               //      FontWeight.bold,
//                                                                               color: Color.fromARGB(
//                                                                                   255,
//                                                                                   7,
//                                                                                   59,
//                                                                                   120),
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
//                                                                     child: Column(
//                                                                       children: [
//                                                                         const Align(
//                                                                           alignment:
//                                                                               Alignment.topLeft,
//                                                                           child:
//                                                                               Text(
//                                                                             "PRECIPITATION: ",
//                                                                             textAlign:
//                                                                                 TextAlign.left,
//                                                                             style:
//                                                                                 TextStyle(
//                                                                               fontSize:
//                                                                                   12,
//                                                                               fontWeight:
//                                                                                   FontWeight.bold,
//                                                                               color: Color.fromARGB(
//                                                                                   255,
//                                                                                   7,
//                                                                                   59,
//                                                                                   120),
//                                                                             ),
//                                                                           ),
//                                                                         ),
//                                                                         Align(
//                                                                           alignment:
//                                                                               Alignment.topLeft,
//                                                                           child:
//                                                                               Text(
//                                                                             (temperatureImpactAnalysisViewModel.temperatureImpactAnalysisList.data!.getVMAVEGETATIONCREWFORM![index].precip == null || temperatureImpactAnalysisViewModel.temperatureImpactAnalysisList.data!.getVMAVEGETATIONCREWFORM![index].precip.toString() == 'null' || temperatureImpactAnalysisViewModel.temperatureImpactAnalysisList.data!.getVMAVEGETATIONCREWFORM![index].precip!.isEmpty)
//                                                                                 ? 'N/A'
//                                                                                 : temperatureImpactAnalysisViewModel.temperatureImpactAnalysisList.data!.getVMAVEGETATIONCREWFORM![index].precip.toString(),
//                                                                             textAlign:
//                                                                                 TextAlign.left,
//                                                                             style:
//                                                                                 const TextStyle(
//                                                                               fontSize:
//                                                                                   12,
//                                                                               //  fontWeight:
//                                                                               //      FontWeight.bold,
//                                                                               color: Color.fromARGB(
//                                                                                   255,
//                                                                                   7,
//                                                                                   59,
//                                                                                   120),
//                                                                             ),
//                                                                           ),
//                                                                         ),
//                                                                       ],
//                                                                     ),
//                                                                   ),
//                                                                   Expanded(
//                                                                     // alignment: Alignment.topLeft,
//                                                                     child: Column(
//                                                                       children: [
//                                                                         const Align(
//                                                                           alignment:
//                                                                               Alignment.topLeft,
//                                                                           child:
//                                                                               Text(
//                                                                             "DELAY CAUSE: ",
//                                                                             textAlign:
//                                                                                 TextAlign.left,
//                                                                             style:
//                                                                                 TextStyle(
//                                                                               fontSize:
//                                                                                   12,
//                                                                               fontWeight:
//                                                                                   FontWeight.bold,
//                                                                               color: Color.fromARGB(
//                                                                                   255,
//                                                                                   7,
//                                                                                   59,
//                                                                                   120),
//                                                                             ),
//                                                                           ),
//                                                                         ),
//                                                                         Align(
//                                                                           alignment:
//                                                                               Alignment.topLeft,
//                                                                           child:
//                                                                               Text(
//                                                                             (temperatureImpactAnalysisViewModel.temperatureImpactAnalysisList.data!.getVMAVEGETATIONCREWFORM![index].delayCause == null || temperatureImpactAnalysisViewModel.temperatureImpactAnalysisList.data!.getVMAVEGETATIONCREWFORM![index].delayCause.toString() == 'null' || temperatureImpactAnalysisViewModel.temperatureImpactAnalysisList.data!.getVMAVEGETATIONCREWFORM![index].delayCause!.isEmpty)
//                                                                                 ? 'N/A'
//                                                                                 : temperatureImpactAnalysisViewModel.temperatureImpactAnalysisList.data!.getVMAVEGETATIONCREWFORM![index].delayCause.toString(),
//                                                                             textAlign:
//                                                                                 TextAlign.left,
//                                                                             style:
//                                                                                 const TextStyle(
//                                                                               fontSize:
//                                                                                   12,
//                                                                               //  fontWeight:
//                                                                               //      FontWeight.bold,
//                                                                               color: Color.fromARGB(
//                                                                                   255,
//                                                                                   7,
//                                                                                   59,
//                                                                                   120),
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
//                                                                     child: Column(
//                                                                       children: [
//                                                                         const Align(
//                                                                           alignment:
//                                                                               Alignment.topLeft,
//                                                                           child:
//                                                                               Text(
//                                                                             "DELAY REASON: ",
//                                                                             textAlign:
//                                                                                 TextAlign.left,
//                                                                             style:
//                                                                                 TextStyle(
//                                                                               fontSize:
//                                                                                   12,
//                                                                               fontWeight:
//                                                                                   FontWeight.bold,
//                                                                               color: Color.fromARGB(
//                                                                                   255,
//                                                                                   7,
//                                                                                   59,
//                                                                                   120),
//                                                                             ),
//                                                                           ),
//                                                                         ),
//                                                                         Align(
//                                                                           alignment:
//                                                                               Alignment.topLeft,
//                                                                           child:
//                                                                               Text(
//                                                                             (temperatureImpactAnalysisViewModel.temperatureImpactAnalysisList.data!.getVMAVEGETATIONCREWFORM![index].delayReason == null || temperatureImpactAnalysisViewModel.temperatureImpactAnalysisList.data!.getVMAVEGETATIONCREWFORM![index].delayReason.toString() == 'null' || temperatureImpactAnalysisViewModel.temperatureImpactAnalysisList.data!.getVMAVEGETATIONCREWFORM![index].delayReason!.isEmpty)
//                                                                                 ? 'N/A'
//                                                                                 : temperatureImpactAnalysisViewModel.temperatureImpactAnalysisList.data!.getVMAVEGETATIONCREWFORM![index].delayReason.toString(),
//                                                                             textAlign:
//                                                                                 TextAlign.left,
//                                                                             style:
//                                                                                 const TextStyle(
//                                                                               fontSize:
//                                                                                   12,
//                                                                               //  fontWeight:
//                                                                               //      FontWeight.bold,
//                                                                               color: Color.fromARGB(
//                                                                                   255,
//                                                                                   7,
//                                                                                   59,
//                                                                                   120),
//                                                                             ),
//                                                                           ),
//                                                                         ),
//                                                                       ],
//                                                                     ),
//                                                                   ),
//                                                                   Expanded(
//                                                                     // alignment: Alignment.topLeft,
//                                                                     child: Column(
//                                                                       children: [
//                                                                         const Align(
//                                                                           alignment:
//                                                                               Alignment.topLeft,
//                                                                           child:
//                                                                               Text(
//                                                                             "EFFECTED NO OF DAYS: ",
//                                                                             textAlign:
//                                                                                 TextAlign.left,
//                                                                             style:
//                                                                                 TextStyle(
//                                                                               fontSize:
//                                                                                   12,
//                                                                               fontWeight:
//                                                                                   FontWeight.bold,
//                                                                               color: Color.fromARGB(
//                                                                                   255,
//                                                                                   7,
//                                                                                   59,
//                                                                                   120),
//                                                                             ),
//                                                                           ),
//                                                                         ),
//                                                                         Align(
//                                                                           alignment:
//                                                                               Alignment.topLeft,
//                                                                           child:
//                                                                               Text(
//                                                                             (temperatureImpactAnalysisViewModel.temperatureImpactAnalysisList.data!.getVMAVEGETATIONCREWFORM![index].effectedNoOfDays == null || temperatureImpactAnalysisViewModel.temperatureImpactAnalysisList.data!.getVMAVEGETATIONCREWFORM![index].effectedNoOfDays.toString() == 'null')
//                                                                                 ? 'N/A'
//                                                                                 : temperatureImpactAnalysisViewModel.temperatureImpactAnalysisList.data!.getVMAVEGETATIONCREWFORM![index].effectedNoOfDays.toString(),
//                                                                             textAlign:
//                                                                                 TextAlign.left,
//                                                                             style:
//                                                                                 const TextStyle(
//                                                                               fontSize:
//                                                                                   12,
//                                                                               //  fontWeight:
//                                                                               //      FontWeight.bold,
//                                                                               color: Color.fromARGB(
//                                                                                   255,
//                                                                                   7,
//                                                                                   59,
//                                                                                   120),
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
//                                                                     child: Column(
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
//                                                                               fontSize:
//                                                                                   12,
//                                                                               fontWeight:
//                                                                                   FontWeight.bold,
//                                                                               color: Color.fromARGB(
//                                                                                   255,
//                                                                                   7,
//                                                                                   59,
//                                                                                   120),
//                                                                             ),
//                                                                           ),
//                                                                         ),
//                                                                         Align(
//                                                                           alignment:
//                                                                               Alignment.topLeft,
//                                                                           child:
//                                                                               Text(
//                                                                             (temperatureImpactAnalysisViewModel.temperatureImpactAnalysisList.data!.getVMAVEGETATIONCREWFORM![index].totalMiles == null || temperatureImpactAnalysisViewModel.temperatureImpactAnalysisList.data!.getVMAVEGETATIONCREWFORM![index].totalMiles.toString() == 'null')
//                                                                                 ? 'N/A'
//                                                                                 : temperatureImpactAnalysisViewModel.temperatureImpactAnalysisList.data!.getVMAVEGETATIONCREWFORM![index].totalMiles.toString(),
//                                                                             textAlign:
//                                                                                 TextAlign.left,
//                                                                             style:
//                                                                                 const TextStyle(
//                                                                               fontSize:
//                                                                                   12,
//                                                                               //  fontWeight:
//                                                                               //      FontWeight.bold,
//                                                                               color: Color.fromARGB(
//                                                                                   255,
//                                                                                   7,
//                                                                                   59,
//                                                                                   120),
//                                                                             ),
//                                                                           ),
//                                                                         ),
//                                                                       ],
//                                                                     ),
//                                                                   ),
//                                                                   Expanded(
//                                                                     // alignment: Alignment.topLeft,
//                                                                     child: Column(
//                                                                       children: [
//                                                                         const Align(
//                                                                           alignment:
//                                                                               Alignment.topLeft,
//                                                                           child:
//                                                                               Text(
//                                                                             "MILES COMPLETED: ",
//                                                                             textAlign:
//                                                                                 TextAlign.left,
//                                                                             style:
//                                                                                 TextStyle(
//                                                                               fontSize:
//                                                                                   12,
//                                                                               fontWeight:
//                                                                                   FontWeight.bold,
//                                                                               color: Color.fromARGB(
//                                                                                   255,
//                                                                                   7,
//                                                                                   59,
//                                                                                   120),
//                                                                             ),
//                                                                           ),
//                                                                         ),
//                                                                         Align(
//                                                                           alignment:
//                                                                               Alignment.topLeft,
//                                                                           child:
//                                                                               Text(
//                                                                             (temperatureImpactAnalysisViewModel.temperatureImpactAnalysisList.data!.getVMAVEGETATIONCREWFORM![index].milesCompleted == null || temperatureImpactAnalysisViewModel.temperatureImpactAnalysisList.data!.getVMAVEGETATIONCREWFORM![index].milesCompleted.toString() == 'null')
//                                                                                 ? 'N/A'
//                                                                                 : temperatureImpactAnalysisViewModel.temperatureImpactAnalysisList.data!.getVMAVEGETATIONCREWFORM![index].milesCompleted.toString(),
//                                                                             textAlign:
//                                                                                 TextAlign.left,
//                                                                             style:
//                                                                                 const TextStyle(
//                                                                               fontSize:
//                                                                                   12,
//                                                                               //  fontWeight:
//                                                                               //      FontWeight.bold,
//                                                                               color: Color.fromARGB(
//                                                                                   255,
//                                                                                   7,
//                                                                                   59,
//                                                                                   120),
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
//                                                                     child: Column(
//                                                                       children: [
//                                                                         const Align(
//                                                                           alignment:
//                                                                               Alignment.topLeft,
//                                                                           child:
//                                                                               Text(
//                                                                             "MILES PENDING: ",
//                                                                             textAlign:
//                                                                                 TextAlign.left,
//                                                                             style:
//                                                                                 TextStyle(
//                                                                               fontSize:
//                                                                                   12,
//                                                                               fontWeight:
//                                                                                   FontWeight.bold,
//                                                                               color: Color.fromARGB(
//                                                                                   255,
//                                                                                   7,
//                                                                                   59,
//                                                                                   120),
//                                                                             ),
//                                                                           ),
//                                                                         ),
//                                                                         Align(
//                                                                           alignment:
//                                                                               Alignment.topLeft,
//                                                                           child:
//                                                                               Text(
//                                                                             (temperatureImpactAnalysisViewModel.temperatureImpactAnalysisList.data!.getVMAVEGETATIONCREWFORM![index].milesPending == null || temperatureImpactAnalysisViewModel.temperatureImpactAnalysisList.data!.getVMAVEGETATIONCREWFORM![index].milesPending.toString() == 'null')
//                                                                                 ? 'N/A'
//                                                                                 : temperatureImpactAnalysisViewModel.temperatureImpactAnalysisList.data!.getVMAVEGETATIONCREWFORM![index].milesPending.toString(),
//                                                                             textAlign:
//                                                                                 TextAlign.left,
//                                                                             style:
//                                                                                 const TextStyle(
//                                                                               fontSize:
//                                                                                   12,
//                                                                               //  fontWeight:
//                                                                               //      FontWeight.bold,
//                                                                               color: Color.fromARGB(
//                                                                                   255,
//                                                                                   7,
//                                                                                   59,
//                                                                                   120),
//                                                                             ),
//                                                                           ),
//                                                                         ),
//                                                                       ],
//                                                                     ),
//                                                                   ),
//                                                                   Expanded(
//                                                                     // alignment: Alignment.topLeft,
//                                                                     child: Column(
//                                                                       children: [
//                                                                         const Align(
//                                                                           alignment:
//                                                                               Alignment.topLeft,
//                                                                           child:
//                                                                               Text(
//                                                                             "MILES IN PROGRESS: ",
//                                                                             textAlign:
//                                                                                 TextAlign.left,
//                                                                             style:
//                                                                                 TextStyle(
//                                                                               fontSize:
//                                                                                   12,
//                                                                               fontWeight:
//                                                                                   FontWeight.bold,
//                                                                               color: Color.fromARGB(
//                                                                                   255,
//                                                                                   7,
//                                                                                   59,
//                                                                                   120),
//                                                                             ),
//                                                                           ),
//                                                                         ),
//                                                                         Align(
//                                                                           alignment:
//                                                                               Alignment.topLeft,
//                                                                           child:
//                                                                               Text(
//                                                                             (temperatureImpactAnalysisViewModel.temperatureImpactAnalysisList.data!.getVMAVEGETATIONCREWFORM![index].milesInProgress == null || temperatureImpactAnalysisViewModel.temperatureImpactAnalysisList.data!.getVMAVEGETATIONCREWFORM![index].milesInProgress.toString() == 'null')
//                                                                                 ? 'N/A'
//                                                                                 : temperatureImpactAnalysisViewModel.temperatureImpactAnalysisList.data!.getVMAVEGETATIONCREWFORM![index].milesInProgress.toString(),
//                                                                             textAlign:
//                                                                                 TextAlign.left,
//                                                                             style:
//                                                                                 const TextStyle(
//                                                                               fontSize:
//                                                                                   12,
//                                                                               //  fontWeight:
//                                                                               //      FontWeight.bold,
//                                                                               color: Color.fromARGB(
//                                                                                   255,
//                                                                                   7,
//                                                                                   59,
//                                                                                   120),
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
//                                                                     child: Column(
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
//                                                                               fontSize:
//                                                                                   12,
//                                                                               fontWeight:
//                                                                                   FontWeight.bold,
//                                                                               color: Color.fromARGB(
//                                                                                   255,
//                                                                                   7,
//                                                                                   59,
//                                                                                   120),
//                                                                             ),
//                                                                           ),
//                                                                         ),
//                                                                         Align(
//                                                                           alignment:
//                                                                               Alignment.topLeft,
//                                                                           child:
//                                                                               Text(
//                                                                             (temperatureImpactAnalysisViewModel.temperatureImpactAnalysisList.data!.getVMAVEGETATIONCREWFORM![index].contractYear == null || temperatureImpactAnalysisViewModel.temperatureImpactAnalysisList.data!.getVMAVEGETATIONCREWFORM![index].contractYear.toString() == 'null' || temperatureImpactAnalysisViewModel.temperatureImpactAnalysisList.data!.getVMAVEGETATIONCREWFORM![index].contractYear!.isEmpty)
//                                                                                 ? 'N/A'
//                                                                                 : temperatureImpactAnalysisViewModel.temperatureImpactAnalysisList.data!.getVMAVEGETATIONCREWFORM![index].contractYear.toString(),
//                                                                             textAlign:
//                                                                                 TextAlign.left,
//                                                                             style:
//                                                                                 const TextStyle(
//                                                                               fontSize:
//                                                                                   12,
//                                                                               //  fontWeight:
//                                                                               //      FontWeight.bold,
//                                                                               color: Color.fromARGB(
//                                                                                   255,
//                                                                                   7,
//                                                                                   59,
//                                                                                   120),
//                                                                             ),
//                                                                           ),
//                                                                         ),
//                                                                       ],
//                                                                     ),
//                                                                   ),
//                                                                   Expanded(
//                                                                     // alignment: Alignment.topLeft,
//                                                                     child: Column(
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
//                                                                               fontSize:
//                                                                                   12,
//                                                                               fontWeight:
//                                                                                   FontWeight.bold,
//                                                                               color: Color.fromARGB(
//                                                                                   255,
//                                                                                   7,
//                                                                                   59,
//                                                                                   120),
//                                                                             ),
//                                                                           ),
//                                                                         ),
//                                                                         Align(
//                                                                           alignment:
//                                                                               Alignment.topLeft,
//                                                                           child:
//                                                                               Text(
//                                                                             (temperatureImpactAnalysisViewModel.temperatureImpactAnalysisList.data!.getVMAVEGETATIONCREWFORM![index].cycle == null || temperatureImpactAnalysisViewModel.temperatureImpactAnalysisList.data!.getVMAVEGETATIONCREWFORM![index].cycle.toString() == 'null' || temperatureImpactAnalysisViewModel.temperatureImpactAnalysisList.data!.getVMAVEGETATIONCREWFORM![index].cycle!.isEmpty)
//                                                                                 ? 'N/A'
//                                                                                 : temperatureImpactAnalysisViewModel.temperatureImpactAnalysisList.data!.getVMAVEGETATIONCREWFORM![index].cycle.toString(),
//                                                                             textAlign:
//                                                                                 TextAlign.left,
//                                                                             style:
//                                                                                 const TextStyle(
//                                                                               fontSize:
//                                                                                   12,
//                                                                               //  fontWeight:
//                                                                               //      FontWeight.bold,
//                                                                               color: Color.fromARGB(
//                                                                                   255,
//                                                                                   7,
//                                                                                   59,
//                                                                                   120),
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
//                                                                     child: Column(
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
//                                                                               fontSize:
//                                                                                   12,
//                                                                               fontWeight:
//                                                                                   FontWeight.bold,
//                                                                               color: Color.fromARGB(
//                                                                                   255,
//                                                                                   7,
//                                                                                   59,
//                                                                                   120),
//                                                                             ),
//                                                                           ),
//                                                                         ),
//                                                                         Align(
//                                                                           alignment:
//                                                                               Alignment.topLeft,
//                                                                           child:
//                                                                               Text(
//                                                                             (temperatureImpactAnalysisViewModel.temperatureImpactAnalysisList.data!.getVMAVEGETATIONCREWFORM![index].adminNotes1 == null || temperatureImpactAnalysisViewModel.temperatureImpactAnalysisList.data!.getVMAVEGETATIONCREWFORM![index].adminNotes1.toString() == 'null' || temperatureImpactAnalysisViewModel.temperatureImpactAnalysisList.data!.getVMAVEGETATIONCREWFORM![index].adminNotes1!.isEmpty)
//                                                                                 ? 'N/A'
//                                                                                 : temperatureImpactAnalysisViewModel.temperatureImpactAnalysisList.data!.getVMAVEGETATIONCREWFORM![index].adminNotes1.toString(),
//                                                                             textAlign:
//                                                                                 TextAlign.left,
//                                                                             style:
//                                                                                 const TextStyle(
//                                                                               fontSize:
//                                                                                   12,
//                                                                               //  fontWeight:
//                                                                               //      FontWeight.bold,
//                                                                               color: Color.fromARGB(
//                                                                                   255,
//                                                                                   7,
//                                                                                   59,
//                                                                                   120),
//                                                                             ),
//                                                                           ),
//                                                                         ),
//                                                                       ],
//                                                                     ),
//                                                                   ),
//                                                                   Expanded(
//                                                                     // alignment: Alignment.topLeft,
//                                                                     child: Column(
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
//                                                                               fontSize:
//                                                                                   12,
//                                                                               fontWeight:
//                                                                                   FontWeight.bold,
//                                                                               color: Color.fromARGB(
//                                                                                   255,
//                                                                                   7,
//                                                                                   59,
//                                                                                   120),
//                                                                             ),
//                                                                           ),
//                                                                         ),
//                                                                         Align(
//                                                                           alignment:
//                                                                               Alignment.topLeft,
//                                                                           child:
//                                                                               Text(
//                                                                             (temperatureImpactAnalysisViewModel.temperatureImpactAnalysisList.data!.getVMAVEGETATIONCREWFORM![index].contractorCompany == null || temperatureImpactAnalysisViewModel.temperatureImpactAnalysisList.data!.getVMAVEGETATIONCREWFORM![index].contractorCompany.toString() == 'null' || temperatureImpactAnalysisViewModel.temperatureImpactAnalysisList.data!.getVMAVEGETATIONCREWFORM![index].contractorCompany!.isEmpty)
//                                                                                 ? 'N/A'
//                                                                                 : temperatureImpactAnalysisViewModel.temperatureImpactAnalysisList.data!.getVMAVEGETATIONCREWFORM![index].contractorCompany.toString(),
//                                                                             textAlign:
//                                                                                 TextAlign.left,
//                                                                             style:
//                                                                                 const TextStyle(
//                                                                               fontSize:
//                                                                                   12,
//                                                                               //  fontWeight:
//                                                                               //      FontWeight.bold,
//                                                                               color: Color.fromARGB(
//                                                                                   255,
//                                                                                   7,
//                                                                                   59,
//                                                                                   120),
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
//                                                                     child: Column(
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
//                                                                               fontSize:
//                                                                                   12,
//                                                                               fontWeight:
//                                                                                   FontWeight.bold,
//                                                                               color: Color.fromARGB(
//                                                                                   255,
//                                                                                   7,
//                                                                                   59,
//                                                                                   120),
//                                                                             ),
//                                                                           ),
//                                                                         ),
//                                                                         Align(
//                                                                           alignment:
//                                                                               Alignment.topLeft,
//                                                                           child:
//                                                                               Text(
//                                                                             (temperatureImpactAnalysisViewModel.temperatureImpactAnalysisList.data!.getVMAVEGETATIONCREWFORM![index].maintType == null || temperatureImpactAnalysisViewModel.temperatureImpactAnalysisList.data!.getVMAVEGETATIONCREWFORM![index].maintType.toString() == 'null' || temperatureImpactAnalysisViewModel.temperatureImpactAnalysisList.data!.getVMAVEGETATIONCREWFORM![index].maintType!.isEmpty)
//                                                                                 ? 'N/A'
//                                                                                 : temperatureImpactAnalysisViewModel.temperatureImpactAnalysisList.data!.getVMAVEGETATIONCREWFORM![index].maintType.toString(),
//                                                                             textAlign:
//                                                                                 TextAlign.left,
//                                                                             style:
//                                                                                 const TextStyle(
//                                                                               fontSize:
//                                                                                   12,
//                                                                               //  fontWeight:
//                                                                               //      FontWeight.bold,
//                                                                               color: Color.fromARGB(
//                                                                                   255,
//                                                                                   7,
//                                                                                   59,
//                                                                                   120),
//                                                                             ),
//                                                                           ),
//                                                                         ),
//                                                                       ],
//                                                                     ),
//                                                                   ),
//                                                                   Expanded(
//                                                                     // alignment: Alignment.topLeft,
//                                                                     child: Column(
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
//                                                                               fontSize:
//                                                                                   12,
//                                                                               fontWeight:
//                                                                                   FontWeight.bold,
//                                                                               color: Color.fromARGB(
//                                                                                   255,
//                                                                                   7,
//                                                                                   59,
//                                                                                   120),
//                                                                             ),
//                                                                           ),
//                                                                         ),
//                                                                         Align(
//                                                                           alignment:
//                                                                               Alignment.topLeft,
//                                                                           child:
//                                                                               Text(
//                                                                             (temperatureImpactAnalysisViewModel.temperatureImpactAnalysisList.data!.getVMAVEGETATIONCREWFORM![index].nextMaintDue == null || temperatureImpactAnalysisViewModel.temperatureImpactAnalysisList.data!.getVMAVEGETATIONCREWFORM![index].nextMaintDue.toString() == 'null' || temperatureImpactAnalysisViewModel.temperatureImpactAnalysisList.data!.getVMAVEGETATIONCREWFORM![index].nextMaintDue!.isEmpty)
//                                                                                 ? 'N/A'
//                                                                                 : temperatureImpactAnalysisViewModel.temperatureImpactAnalysisList.data!.getVMAVEGETATIONCREWFORM![index].nextMaintDue.toString(),
//                                                                             textAlign:
//                                                                                 TextAlign.left,
//                                                                             style:
//                                                                                 const TextStyle(
//                                                                               fontSize:
//                                                                                   12,
//                                                                               //  fontWeight:
//                                                                               //      FontWeight.bold,
//                                                                               color: Color.fromARGB(
//                                                                                   255,
//                                                                                   7,
//                                                                                   59,
//                                                                                   120),
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

//   List<_ChartDataSimpleColumnChart1> recreateDataOutageCountByTemperature(
//       TemperatureImpactAnalysisViewModel value) {
//     dataSimpleColumnChart1.clear();
//     for (var i = 0;
//         i <
//             temperatureImpactAnalysisViewModel.temperatureImpactAnalysisList
//                 .data!.getSPOUTAGECOUNTBYTEMPBYSUBSTATION!.length;
//         i++) {
//       dataSimpleColumnChart1.add(_ChartDataSimpleColumnChart1(
//           (temperatureImpactAnalysisViewModel.temperatureImpactAnalysisList.data!.getSPOUTAGECOUNTBYTEMPBYSUBSTATION![i].substation!.isEmpty ||
//                   temperatureImpactAnalysisViewModel
//                           .temperatureImpactAnalysisList
//                           .data!
//                           .getSPOUTAGECOUNTBYTEMPBYSUBSTATION![i]
//                           .substation!
//                           .toString() ==
//                       'null')
//               ? ''
//               : temperatureImpactAnalysisViewModel.temperatureImpactAnalysisList
//                   .data!.getSPOUTAGECOUNTBYTEMPBYSUBSTATION![i].substation!
//                   .toString(),
//           (temperatureImpactAnalysisViewModel.temperatureImpactAnalysisList.data!.getSPOUTAGECOUNTBYTEMPBYSUBSTATION![i].precipitation.toString() == 'null')
//               ? 0
//               : double.parse(temperatureImpactAnalysisViewModel
//                   .temperatureImpactAnalysisList
//                   .data!
//                   .getSPOUTAGECOUNTBYTEMPBYSUBSTATION![i]
//                   .precipitation
//                   .toString()),
//           (temperatureImpactAnalysisViewModel.temperatureImpactAnalysisList.data!.getSPOUTAGECOUNTBYTEMPBYSUBSTATION![i].countDelayCause.toString() == 'null')
//               ? 0
//               : double.parse(temperatureImpactAnalysisViewModel.temperatureImpactAnalysisList.data!.getSPOUTAGECOUNTBYTEMPBYSUBSTATION![i].countDelayCause.toString().toString())));
//     }
//     return dataSimpleColumnChart1;
//   }

//   void fetchData(String substation, String fdrName, String sDate, String eDate,
//       String delayCause) {
//     temperatureImpactAnalysisViewModel.fetchTemperatureImpactAnalysisListApi(
//         context, substation, fdrName, sDate, eDate, delayCause);
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
//   _ChartDataSimpleColumnChart1(this.x, this.y, this.y1);

//   final String x;
//   final double y;
//   final double y1;
// }
