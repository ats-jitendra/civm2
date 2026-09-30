// // import 'package:CIVM/piedmont/screens/admin_pannel/map_view_admin.dart';
// import 'package:CIVM/piedmont/repository/map_url.dart';
// import 'package:CIVM/piedmont/screens/admin_pannel/row_maintenance_view/add_new_row_maintenance_plan.dart';
// import 'package:CIVM/piedmont/screens/admin_pannel/row_maintenance_view/lcp_create_order.dart';
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
// import '../../../view_model/vegetation_normalize_view_model.dart';
// import 'package:CIVM/piedmont/resources/app_colors.dart';

// // ignore: must_be_immutable
// class VegetationNormalize extends StatefulWidget {
//   const VegetationNormalize({Key? key}) : super(key: key);

//   @override
//   State<VegetationNormalize> createState() => _VegetationNormalizeState();
// }

// class _VegetationNormalizeState extends State<VegetationNormalize> {
// // ignore: prefer_typing_uninitialized_variables
//   var selectedSubstation;
//   String substationId = '';

// // ignore: prefer_typing_uninitialized_variables
//   var selectedFeeder;
//   String feederId = '';

// // ignore: prefer_typing_uninitialized_variables
//   var selectedOutageCause;
//   String outageCauseId = '';

//   // late final List<charts.Series> seriesList;
//   late final bool animate = true;
//   late final Future? myFuture;
//   var result = [];

//   int flag = 0;
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
//         print('11111111111111111111111111111111111111111111111111');
//         print(date20);
//         print(dateSelected20);
//         fetchData(substationId.toString(), feederId.toString(), dateSelected20,
//             dateSelected21, outageCauseId);
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
//         dateSelected21 = DateFormat('MM/dd/yyyy').format(picked21);
//         fetchData(substationId.toString(), feederId.toString(), dateSelected20,
//             dateSelected21, outageCauseId);
//         // String substationNew = '';
//         // String feederNew = '';
//         // if (substationId == 0) {
//         //   substationNew = '';
//         // }
//         // if (feederId == 0) {
//         //   feederNew = '';
//         // }
//         // if (substationId == 0 && feederId == 0) {
//         //   substationNew = '';
//         //   feederNew = '';

//         // }fetchData(substationNew,feederNew, dateSelected20, dateSelected21, outageCauseId);
//       });
//     }
//   }

//   final browser = MyChromeSafariBrowser();
//   VegetationNormalizeViewModel vegetationNormalizeViewModel =
//       VegetationNormalizeViewModel();
//   DateTime now = DateTime.now();
//   String _addLeadingZero(int value) {
//     if (value < 10) {
//       return '0$value';
//     }
//     return '$value';
//   }

//   @override
//   void initState() {
//     vegetationNormalizeViewModel.fetchVegetationNormalizeListApi(
//         context,
//         '',
//         '',
//         '',
//         '01/01/${now.year - 1}',
//         '${now.year}/${_addLeadingZero(now.month)}/${_addLeadingZero(now.day)}',
//         '');
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
//             'Vegetation Normalize',
//             style: TextStyle(color: Colors.white),
//           ),
//           backgroundColor: AppColors.baseColor,
//           actions: const <Widget>[],
//         ),
//         body: ChangeNotifierProvider<VegetationNormalizeViewModel>(
//             create: (BuildContext context) => vegetationNormalizeViewModel,
//             child: Consumer<VegetationNormalizeViewModel>(
//                 builder: (context, value, _) {
//               switch (value.vegetationNormalizeList.status) {
//                 case Status.LOADING:
//                   return const Center(child: CircularProgressIndicator());
//                 case Status.ERROR:
//                   return
//                       // CustomToastSnackBarProgressDialog.flushBarErrorMessage(
//                       //     value.vegetationNormalizeList.message.toString(),
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
//                   if (flag == 0) {
//                     setData();
//                     flag = 1;
//                   }
//                   return RefreshIndicator(
//                     onRefresh: () async {
//                       selectedSubstation = null;
//                       selectedFeeder = null;
//                       selectedOutageCause=null;
//                       await vegetationNormalizeViewModel
//                           .fetchVegetationNormalizeListApi(
//                               context,
//                               '',
//                               '',
//                               '',
//                               '01/01/${now.year - 1}',
//                               '${now.year}/${_addLeadingZero(now.month)}/${_addLeadingZero(now.day)}',
//                               '');
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
//                                           child: SizedBox(
//                                             width: 200,
//                                             child:
//                                                 DropdownButtonFormField<String>(
//                                               hint: const Text('-Select-'),
//                                               dropdownColor: Colors.white,
//                                               value: selectedSubstation,
//                                               style: const TextStyle(
//                                                   color: Color.fromARGB(
//                                                       255, 7, 59, 120),
//                                                   fontSize: 16),
//                                               icon: const Icon(
//                                                 Icons.arrow_drop_down,
//                                                 color: AppColors.baseColor,
//                                                 size: 40,
//                                               ),
//                                               decoration: const InputDecoration(
//                                                 enabledBorder:
//                                                     OutlineInputBorder(
//                                                   borderSide: BorderSide(
//                                                     color: Color.fromARGB(
//                                                         255, 7, 59, 120),
//                                                   ),
//                                                   // borderRadius: BorderRadius.circular(25),
//                                                 ),
//                                                 focusedBorder:
//                                                     OutlineInputBorder(
//                                                   borderSide: BorderSide(
//                                                     color: Color.fromARGB(
//                                                         255, 7, 59, 120),
//                                                   ),
//                                                   // borderRadius: BorderRadius.circular(25),
//                                                 ),
//                                               ),
//                                               isExpanded: true,
//                                               items:
//                                                   vegetationNormalizeViewModel
//                                                       .vegetationNormalizeList
//                                                       .data!
//                                                       .findsSubstationAndId!
//                                                       .map((e) {
//                                                 return DropdownMenuItem(
//                                                   value: e.id.toString(),
//                                                   child: Text(
//                                                       e.substation.toString()),
//                                                 );
//                                               }).toList(),
//                                               onChanged: (val) {
//                                                 if (selectedFeeder != null ||
//                                                     selectedOutageCause !=
//                                                         null) {
//                                                   selectedFeeder = null;
//                                                   selectedOutageCause = null;
//                                                 }
//                                                 fetchData(
//                                                     val!,
//                                                     '',
//                                                     dateSelected20,
//                                                     dateSelected21,
//                                                     '');
//                                                 substationId = val.toString();
//                                                 print('111111111111111');
//                                                 // print(id.text.toString());
//                                                 setState(() {
//                                                   selectedSubstation = val;
//                                                 });
//                                               },
//                                               validator: (value) =>
//                                                   value == null
//                                                       ? 'field required'
//                                                       : null,
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
//                                           child: SizedBox(
//                                             width: 200,
//                                             child:
//                                                 DropdownButtonFormField<String>(
//                                               hint: const Text('-Select-'),
//                                               dropdownColor: Colors.white,
//                                               value: selectedFeeder,
//                                               style: const TextStyle(
//                                                   color: Color.fromARGB(
//                                                       255, 7, 59, 120),
//                                                   fontSize: 16),
//                                               icon: const Icon(
//                                                 Icons.arrow_drop_down,
//                                                 color: AppColors.baseColor,
//                                                 size: 40,
//                                               ),
//                                               decoration: const InputDecoration(
//                                                 enabledBorder:
//                                                     OutlineInputBorder(
//                                                   borderSide: BorderSide(
//                                                     color: Color.fromARGB(
//                                                         255, 7, 59, 120),
//                                                   ),
//                                                   // borderRadius: BorderRadius.circular(25),
//                                                 ),
//                                                 focusedBorder:
//                                                     OutlineInputBorder(
//                                                   borderSide: BorderSide(
//                                                     color: Color.fromARGB(
//                                                         255, 7, 59, 120),
//                                                   ),
//                                                   // borderRadius: BorderRadius.circular(25),
//                                                 ),
//                                               ),
//                                               isExpanded: true,
//                                               items: vegetationNormalizeViewModel
//                                                   .vegetationNormalizeList
//                                                   .data!
//                                                   .findsFdrNameAndIdBySubstation!
//                                                   .map((e) {
//                                                 return DropdownMenuItem(
//                                                   value: e.id.toString(),
//                                                   child: Text(
//                                                       e.fdrName.toString()),
//                                                 );
//                                               }).toList(),
//                                               onChanged: (val) {
//                                                 if (selectedOutageCause !=
//                                                     null) {
//                                                   selectedOutageCause = null;
//                                                 }
//                                                 fetchData(
//                                                     substationId.toString(),
//                                                     val!,
//                                                     dateSelected20,
//                                                     dateSelected21,
//                                                     '');
//                                                 feederId = val.toString();
//                                                 setState(() {
//                                                   selectedFeeder = val;
//                                                 });
//                                               },
//                                               validator: (value) =>
//                                                   value == null
//                                                       ? 'field required'
//                                                       : null,
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
//                                                   fontWeight: FontWeight.bold,
//                                                 ),
//                                               ),
//                                             )),
//                                         Align(
//                                           alignment: Alignment.centerLeft,
//                                           child: SizedBox(
//                                             width: 200,
//                                             child:
//                                                 DropdownButtonFormField<String>(
//                                               hint: const Text('-Select-'),
//                                               dropdownColor: Colors.white,
//                                               value: selectedOutageCause,
//                                               style: const TextStyle(
//                                                   color: Color.fromARGB(
//                                                       255, 7, 59, 120),
//                                                   fontSize: 16),
//                                               icon: const Icon(
//                                                 Icons.arrow_drop_down,
//                                                 color: AppColors.baseColor,
//                                                 size: 40,
//                                               ),
//                                               decoration: const InputDecoration(
//                                                 enabledBorder:
//                                                     OutlineInputBorder(
//                                                   borderSide: BorderSide(
//                                                     color: Color.fromARGB(
//                                                         255, 7, 59, 120),
//                                                   ),
//                                                   // borderRadius: BorderRadius.circular(25),
//                                                 ),
//                                                 focusedBorder:
//                                                     OutlineInputBorder(
//                                                   borderSide: BorderSide(
//                                                     color: Color.fromARGB(
//                                                         255, 7, 59, 120),
//                                                   ),
//                                                   // borderRadius: BorderRadius.circular(25),
//                                                 ),
//                                               ),
//                                               isExpanded: true,
//                                               items: vegetationNormalizeViewModel
//                                                   .vegetationNormalizeList
//                                                   .data!
//                                                   .findsDelayCauseBySubstationAndFdr!
//                                                   .map((e) {
//                                                 return DropdownMenuItem(
//                                                   value:
//                                                       e.delayCause.toString(),
//                                                   child: Text(
//                                                       e.delayCause.toString()),
//                                                 );
//                                               }).toList(),
//                                               onChanged: (val) {
//                                                 fetchData(
//                                                     substationId.toString(),
//                                                     feederId.toString(),
//                                                     dateSelected20,
//                                                     dateSelected21,
//                                                     val!);
//                                                 outageCauseId = val.toString();
//                                                 setState(() {
//                                                   selectedOutageCause = val;
//                                                 });
//                                               },
//                                               validator: (value) =>
//                                                   value == null
//                                                       ? 'field required'
//                                                       : null,
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
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
//                                             left: 4.0, right: 2, top: 4),
//                                         child: Container(
//                                           height: 60,
//                                           decoration: const BoxDecoration(
//                                               boxShadow: [],
//                                               gradient: LinearGradient(
//                                                 colors: [
//                                                   Color.fromARGB(
//                                                       255, 7, 59, 120),
//                                                   Color.fromARGB(
//                                                       255, 7, 59, 120),
//                                                 ],
//                                               )),
//                                           child: Padding(
//                                             padding: const EdgeInsets.all(1.0),
//                                             child: Container(
//                                               decoration: const BoxDecoration(
//                                                   boxShadow: [],
//                                                   gradient: LinearGradient(
//                                                     colors: [
//                                                       Colors.white,
//                                                       Colors.white,
//                                                     ],
//                                                   )),
//                                               child: Padding(
//                                                 padding: const EdgeInsets.only(
//                                                     left: 8.0),
//                                                 child: Row(
//                                                   children: [
//                                                     Padding(
//                                                       padding:
//                                                           const EdgeInsets.only(
//                                                               top: 2),
//                                                       child: IconButton(
//                                                         icon: const Icon(Icons
//                                                             .calendar_month),
//                                                         iconSize: 22,
//                                                         color: const Color
//                                                             .fromARGB(
//                                                             255, 7, 59, 120),
//                                                         onPressed: () {
//                                                           selectDate20(context);
//                                                         },
//                                                       ),
//                                                     ),
//                                                     Padding(
//                                                       padding:
//                                                           const EdgeInsets.only(
//                                                               left: 2),
//                                                       child: Text(
//                                                           dateSelected20,
//                                                           style:
//                                                               const TextStyle(
//                                                             fontSize: 16,
//                                                             color:
//                                                                 Color.fromARGB(
//                                                                     255,
//                                                                     7,
//                                                                     59,
//                                                                     120),
//                                                           )),
//                                                     ),
//                                                   ],
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
//                                         left: 2.0, right: 4, top: 4),
//                                     child: Container(
//                                       height: 60,
//                                       decoration: const BoxDecoration(
//                                           boxShadow: [],
//                                           gradient: LinearGradient(
//                                             colors: [
//                                               AppColors.baseColor,
//                                               AppColors.baseColor,
//                                             ],
//                                           )),
//                                       child: Padding(
//                                         padding: const EdgeInsets.all(1.0),
//                                         child: Container(
//                                           decoration: const BoxDecoration(
//                                               boxShadow: [],
//                                               gradient: LinearGradient(
//                                                 colors: [
//                                                   Colors.white,
//                                                   Colors.white,
//                                                 ],
//                                               )),
//                                           child: Padding(
//                                             padding: const EdgeInsets.only(
//                                                 left: 8.0),
//                                             child: Row(
//                                               children: [
//                                                 Padding(
//                                                   padding:
//                                                       const EdgeInsets.only(
//                                                           top: 2),
//                                                   child: IconButton(
//                                                     icon: const Icon(
//                                                         Icons.calendar_month),
//                                                     iconSize: 22,
//                                                     color: const Color.fromARGB(
//                                                         255, 7, 59, 120),
//                                                     onPressed: () {
//                                                       selectDate21(context);
//                                                       // print(date);
//                                                     },
//                                                   ),
//                                                 ),
//                                                 Padding(
//                                                   padding:
//                                                       const EdgeInsets.only(
//                                                           left: 2),
//                                                   child: Text(dateSelected21,
//                                                       style: const TextStyle(
//                                                         fontSize: 16,
//                                                         color: Color.fromARGB(
//                                                             255, 7, 59, 120),
//                                                       )),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             // Padding(
//                             //   padding: const EdgeInsets.only(
//                             //       top: 16.0, left: 16, right: 16),
//                             //   child: Container(
//                             //     padding: const EdgeInsets.all(10),
//                             //     alignment: Alignment.center,
//                             //     // width: size.width * 0.68,
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
//                             //                 "Miles Completed: ",
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
//                             //                 (vegetationNormalizeViewModel
//                             //                                 .vegetationNormalizeList
//                             //                                 .data!
//                             //                                 .findCompletedMile![0]
//                             //                                 .completedMiles ==
//                             //                             null ||
//                             //                         vegetationNormalizeViewModel
//                             //                                 .vegetationNormalizeList
//                             //                                 .data!
//                             //                                 .findCompletedMile![0]
//                             //                                 .completedMiles!
//                             //                                 .toString() ==
//                             //                             'null')
//                             //                     ? 'N/A'
//                             //                     : vegetationNormalizeViewModel
//                             //                         .vegetationNormalizeList
//                             //                         .data!
//                             //                         .findCompletedMile![0]
//                             //                         .completedMiles!
//                             //                         .toStringAsFixed(0),
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
//                                         "MILES COMPLETED: ",
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
//                                         (vegetationNormalizeViewModel
//                                                         .vegetationNormalizeList
//                                                         .data!
//                                                         .findCompletedMile![0]
//                                                         .completedMiles ==
//                                                     null ||
//                                                 vegetationNormalizeViewModel
//                                                         .vegetationNormalizeList
//                                                         .data!
//                                                         .findCompletedMile![0]
//                                                         .completedMiles
//                                                         .toString() ==
//                                                     'null')
//                                             ? ''
//                                             : double.parse(
//                                                     vegetationNormalizeViewModel
//                                                         .vegetationNormalizeList
//                                                         .data!
//                                                         .findCompletedMile![0]
//                                                         .completedMiles
//                                                         .toString())
//                                                 .toStringAsFixed(2),
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
//                                           "Vegetation Outage Cause",
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
//                                       primaryXAxis: CategoryAxis(
//                                         title: AxisTitle(
//                                             text: 'OUTAGE ID',
//                                             textStyle: const TextStyle(
//                                                 color: Colors.red,
//                                                 fontFamily: 'Roboto',
//                                                 fontSize: 16,
//                                                 fontStyle: FontStyle.italic,
//                                                 fontWeight: FontWeight.bold)),
//                                       ),
//                                       primaryYAxis: CategoryAxis(
//                                         title: AxisTitle(
//                                             text: 'SAIDI, SAIFI AND CAIDI',
//                                             textStyle: const TextStyle(
//                                                 color: Colors.red,
//                                                 fontFamily: 'Roboto',
//                                                 fontSize: 16,
//                                                 fontStyle: FontStyle.italic,
//                                                 fontWeight: FontWeight.bold)),
//                                       ),
//                                       legend: Legend(isVisible: true),
//                                       palette: const <Color>[
//                                         Color.fromARGB(255, 15, 3, 182),
//                                         Colors.red,
//                                         Colors.orange,
//                                       ],
//                                       series: <CartesianSeries>[
//                                         ColumnSeries<
//                                             _ChartDataSimpleColumnChart1,
//                                             String>(
//                                           name: 'CAIDI',
//                                           dataSource:
//                                               recreateDataVegetationOutageCause(
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
//                                         ColumnSeries<
//                                             _ChartDataSimpleColumnChart1,
//                                             String>(
//                                           name: 'SAIDI',
//                                           dataSource:
//                                               recreateDataVegetationOutageCause(
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
//                                           dataLabelSettings:
//                                               const DataLabelSettings(
//                                                   isVisible: true),
//                                         ),
//                                         ColumnSeries<
//                                             _ChartDataSimpleColumnChart1,
//                                             String>(
//                                           name: 'SAIFI',
//                                           dataSource:
//                                               recreateDataVegetationOutageCause(
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
//                                           dataLabelSettings:
//                                               const DataLabelSettings(
//                                                   isVisible: true),
//                                         )
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
//                                             vegetationNormalizeViewModel
//                                                 .vegetationNormalizeList
//                                                 .data!
//                                                 .getSPVMAVEGETATIONNORMALIZEDYNAMIC!
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

//                                     //newcode
//                                     Expanded(
//                                       child: Align(
//                                         alignment: Alignment.center,
//                                         child: ListView.builder(
//                                             itemCount: vegetationNormalizeViewModel
//                                                 .vegetationNormalizeList
//                                                 .data!
//                                                 .getSPVMAVEGETATIONNORMALIZEDYNAMIC!
//                                                 .length,
//                                             // itemCount: historyList.length,
//                                             itemBuilder:
//                                                 (BuildContext ctxt, int index) {
//                                               String? dateStringCreateDate =
//                                                   vegetationNormalizeViewModel
//                                                       .vegetationNormalizeList
//                                                       .data!
//                                                       .getSPVMAVEGETATIONNORMALIZEDYNAMIC![
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
//                                                               Expanded(
//                                                                 child: Column(
//                                                                   children: [
//                                                                     const Align(
//                                                                       alignment:
//                                                                           Alignment
//                                                                               .topLeft,
//                                                                       child:
//                                                                           Text(
//                                                                         "EDIT: ",
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
//                                                                     InkWell(
//                                                                         onTap:
//                                                                             () {
//                                                                           if (vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].maintType == 'RegularMaint' &&
//                                                                               vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].rowYear !=
//                                                                                   '' &&
//                                                                               vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].rowYear !=
//                                                                                   'N/A') {
//                                                                             Navigator.push(
//                                                                                 context,
//                                                                                 MaterialPageRoute(
//                                                                                     builder: (context) => AddNewRowMaintenancePlan(
//                                                                                           tokenNo: vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].tokenNo == null ? '' : vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].tokenNo.toString(),
//                                                                                           index: '0',
//                                                                                           nextMaintYear: vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].nextMaintDue == null ? '' : vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].nextMaintDue.toString(),
//                                                                                           subStation: vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].substation == null ? '' : vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].substation.toString(),
//                                                                                           feeder: vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].fdrName == null ? '' : vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].fdrName.toString(),
//                                                                                           maintType: vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].maintType == null ? '' : vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].maintType.toString(),
//                                                                                           totalMiles: vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].totalMiles == null ? '' : vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].totalMiles.toString(),
//                                                                                           totalCost: vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].totalCost == null ? '' : vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].totalCost.toString(),
//                                                                                           costPerMile: vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].costPerMile == null ? '' : vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].costPerMile.toString(),
//                                                                                           budgetType: vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].budgetType == null ? '' : vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].budgetType.toString(),
//                                                                                           contractRowYear: vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].contractYear == null ? '' : vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].contractYear.toString(),
//                                                                                           rowCycle: vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].cycle == null ? '' : vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].cycle.toString(),
//                                                                                           rowYear: vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].rowYear == null ? '' : vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].rowYear.toString(),
//                                                                                           contractorCompany: vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].contractorCompany == null ? '' : vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].contractorCompany.toString(),
//                                                                                           assignForeman: vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].contractorName == null ? '' : vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].contractorName.toString(),
//                                                                                         )));
//                                                                           } else if (vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].maintType == 'RegularMaint' &&
//                                                                               vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].rowYear == '' &&
//                                                                               vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].rowYear != 'N/A') {
//                                                                             Navigator.push(
//                                                                                 context,
//                                                                                 MaterialPageRoute(
//                                                                                     builder: (context) => AddNewRowMaintenancePlan(
//                                                                                           tokenNo: vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].tokenNo == null ? '' : vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].tokenNo.toString(),
//                                                                                           index: '1',
//                                                                                           nextMaintYear: vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].nextMaintDue == null ? '' : vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].nextMaintDue.toString(),
//                                                                                           subStation: vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].substation == null ? '' : vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].substation.toString(),
//                                                                                           feeder: vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].fdrName == null ? '' : vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].fdrName.toString(),
//                                                                                           maintType: vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].maintType == null ? '' : vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].maintType.toString(),
//                                                                                           totalMiles: vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].totalMiles == null ? '' : vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].totalMiles.toString(),
//                                                                                           totalCost: vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].totalCost == null ? '' : vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].totalCost.toString(),
//                                                                                           costPerMile: vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].costPerMile == null ? '' : vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].costPerMile.toString(),
//                                                                                           budgetType: vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].budgetType == null ? '' : vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].budgetType.toString(),
//                                                                                           contractRowYear: vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].contractYear == null ? '' : vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].contractYear.toString(),
//                                                                                           rowCycle: vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].cycle == null ? '' : vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].cycle.toString(),
//                                                                                           rowYear: vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].rowYear == null ? '' : vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].rowYear.toString(),
//                                                                                           contractorCompany: vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].contractorCompany == null ? '' : vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].contractorCompany.toString(),
//                                                                                           assignForeman: vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].contractorName == null ? '' : vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].contractorName.toString(),
//                                                                                         )));
//                                                                           } else {
//                                                                             Navigator.of(context).push(MaterialPageRoute(
//                                                                                 builder: (BuildContext context) => LCPCreateOrder(
//                                                                                       tokenNo: vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].tokenNo == null ? '' : vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].tokenNo.toString(),
//                                                                                       subStation: (vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].substation == null) ? '' : vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].substation.toString(),
//                                                                                       feeder: (vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].fdrName == null) ? '' : vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].fdrName.toString(),
//                                                                                       serviceStreetAddress: (vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].streetAddress == null || vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].streetAddress == 'N/A') ? '' : vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].streetAddress.toString(),
//                                                                                       serviceMapLocation: (vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].mapLocation == null || vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].mapLocation == 'N/A') ? '' : vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].mapLocation.toString(),
//                                                                                       notes: (vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].adminNotes1 == null) ? '' : vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].adminNotes1.toString(),
//                                                                                       type: (vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].type == null) ? '' : vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].type.toString(),
//                                                                                       maintType: (vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].maintType == null) ? '' : vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].maintType.toString(),
//                                                                                       contractorCompany: (vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].contractorCompany == null) ? '' : vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].contractorCompany.toString(),
//                                                                                       assignForeman: (vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].contractor == null) ? '' : vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].contractor.toString(),
//                                                                                       estimatedCost: (vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].estCost == null) ? '' : vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].estCost.toString(),
//                                                                                       estimatedTime: (vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].estTime == null) ? '' : vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].estTime.toString(),
//                                                                                       actualCost: (vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].actualCost == null) ? '' : vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].actualCost.toString(),
//                                                                                     )));
//                                                                           }
//                                                                         },
//                                                                         child:
//                                                                             const Align(
//                                                                           alignment:
//                                                                               Alignment.topLeft,
//                                                                           child:
//                                                                               Icon(
//                                                                             Icons.edit,
//                                                                             color: Color.fromARGB(
//                                                                                 255,
//                                                                                 151,
//                                                                                 249,
//                                                                                 154),
//                                                                           ),
//                                                                         )),
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
//                                                                         (vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].maintType == null ||
//                                                                                 vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].maintType.toString() == 'null' ||
//                                                                                 vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].maintType!.isEmpty)
//                                                                             ? 'N/A'
//                                                                             : vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].maintType.toString(),
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
//                                                                         (vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].tokenNo == null ||
//                                                                                 vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].tokenNo.toString() == 'null')
//                                                                             ? ''
//                                                                             : vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].tokenNo.toString(),
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
//                                                                 //  flex: 3,
//                                                                 child: Column(
//                                                                   children: [
//                                                                     const Align(
//                                                                       alignment:
//                                                                           Alignment
//                                                                               .topLeft,
//                                                                       child:
//                                                                           Text(
//                                                                         "STATUS:",
//                                                                         textAlign:
//                                                                             TextAlign.left,
//                                                                         style: TextStyle(
//                                                                             fontSize:
//                                                                                 12,
//                                                                             fontWeight:
//                                                                                 FontWeight.bold,
//                                                                             color: Colors.white),
//                                                                       ),
//                                                                     ),
//                                                                     Align(
//                                                                       alignment:
//                                                                           Alignment
//                                                                               .topLeft,
//                                                                       child:
//                                                                           Text(
//                                                                         (vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].status == null ||
//                                                                                 vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].status.toString() == 'null' ||
//                                                                                 vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].status!.isEmpty)
//                                                                             ? 'N/A'
//                                                                             : vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].status.toString(),
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
//                                                                         (vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].substation == null ||
//                                                                                 vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].substation.toString() == 'null' ||
//                                                                                 vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].substation!.isEmpty)
//                                                                             ? 'N/A'
//                                                                             : vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].substation.toString(),
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
//                                                                         (vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].fdrName == null ||
//                                                                                 vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].fdrName.toString() == 'null' ||
//                                                                                 vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].fdrName!.isEmpty)
//                                                                             ? 'N/A'
//                                                                             : vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].fdrName.toString(),
//                                                                         textAlign:
//                                                                             TextAlign.left,
//                                                                         style:
//                                                                             const TextStyle(
//                                                                           fontSize:
//                                                                               12,
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
//                                                                         "DELAY CAUSE: ",
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
//                                                                         (vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].delayCause == null ||
//                                                                                 vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].delayCause.toString() == 'null' ||
//                                                                                 vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].delayCause!.isEmpty)
//                                                                             ? 'N/A'
//                                                                             : vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].delayCause.toString(),
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
//                                                                         "DELAY REASON: ",
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
//                                                                         (vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].delayReason == null ||
//                                                                                 vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].delayReason.toString() == 'null' ||
//                                                                                 vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].delayReason!.isEmpty)
//                                                                             ? 'N/A'
//                                                                             : vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].delayReason.toString(),
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
//                                                                         "EFFECTED NO OF DAYS: ",
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
//                                                                         (vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].effectedNoOfDays == null ||
//                                                                                 vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].effectedNoOfDays.toString() == 'null')
//                                                                             ? 'N/A'
//                                                                             : vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].effectedNoOfDays.toString(),
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
//                                                                         (vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].type == null ||
//                                                                                 vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].type.toString() == 'null' ||
//                                                                                 vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].type!.isEmpty)
//                                                                             ? 'N/A'
//                                                                             : vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].type.toString(),
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
//                                                                         "SAIDI: ",
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
//                                                                         (vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].sAIDI == null ||
//                                                                                 vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].sAIDI.toString() == 'null')
//                                                                             ? 'N/A'
//                                                                             : vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].sAIDI.toString(),
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
//                                                                         "SAIFI: ",
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
//                                                                         (vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].sAIFI == null ||
//                                                                                 vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].sAIFI.toString() == 'null')
//                                                                             ? 'N/A'
//                                                                             : vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].sAIFI.toString(),
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
//                                                                         "CAIDI: ",
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
//                                                                         (vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].cAIDI == null ||
//                                                                                 vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].cAIDI.toString() == 'null')
//                                                                             ? 'N/A'
//                                                                             : vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].cAIDI.toString(),
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
//                                                                         (vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].totalMiles == null ||
//                                                                                 vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].totalMiles.toString() == 'null')
//                                                                             ? 'N/A'
//                                                                             : vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].totalMiles.toString(),
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
//                                                                         "MILES COMPLETED: ",
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
//                                                                         (vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].milesCompleted == null ||
//                                                                                 vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].milesCompleted.toString() == 'null')
//                                                                             ? 'N/A'
//                                                                             : vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].milesCompleted.toString(),
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
//                                                                         "MILES PENDING: ",
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
//                                                                         (vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].milesPending == null ||
//                                                                                 vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].milesPending.toString() == 'null')
//                                                                             ? 'N/A'
//                                                                             : vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].milesPending.toString(),
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
//                                                                         "MILES IN PROGRESS: ",
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
//                                                                         (vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].milesInProgress == null ||
//                                                                                 vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].milesInProgress.toString() == 'null')
//                                                                             ? 'N/A'
//                                                                             : vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].milesInProgress.toString(),
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
//                                                                         (vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].adminNotes1!.isEmpty ||
//                                                                                 vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].adminNotes1 == null ||
//                                                                                 vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].adminNotes1.toString() == 'null')
//                                                                             ? 'N/A'
//                                                                             : vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].adminNotes1.toString(),
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
//                                                                         (vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].contractorCompany!.isEmpty ||
//                                                                                 vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].contractorCompany == null ||
//                                                                                 vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].contractorCompany.toString() == 'null')
//                                                                             ? 'N/A'
//                                                                             : vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].contractorCompany.toString(),
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
//                                                                 //  flex: 3,
//                                                                 child: Column(
//                                                                   children: [
//                                                                     const Align(
//                                                                       alignment:
//                                                                           Alignment
//                                                                               .topLeft,
//                                                                       child:
//                                                                           Text(
//                                                                         "CREATE DATE:",
//                                                                         textAlign:
//                                                                             TextAlign.left,
//                                                                         style: TextStyle(
//                                                                             fontSize:
//                                                                                 12,
//                                                                             fontWeight:
//                                                                                 FontWeight.bold,
//                                                                             color: Colors.white),
//                                                                       ),
//                                                                     ),
//                                                                     Align(
//                                                                       alignment:
//                                                                           Alignment
//                                                                               .topLeft,
//                                                                       child:
//                                                                           Text(
//                                                                         (vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].createDate == null ||
//                                                                                 vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].createDate.toString() == 'null' ||
//                                                                                 vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].createDate!.isEmpty)
//                                                                             ? 'N/A'
//                                                                             : formattedDateCreateDate,
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
//                                                               Expanded(
//                                                                 //  flex: 3,
//                                                                 child: Column(
//                                                                   children: [
//                                                                     InkWell(
//                                                                       onTap:
//                                                                           () async {
//                                                                               String id = '';
//               final userPreferences1 =
//                   Provider.of<UserPref>(context, listen: false);
//               UserModel data = await userPreferences1.getUser();
//               id = data.user!.id.toString();
//                                                                         // Navigator.of(context).push(
//                                                                         //     MaterialPageRoute(
//                                                                         //         builder: (BuildContext
//                                                                         //                 context) =>
//                                                                         //             MapViewAdmin(
//                                                                         //               id: vegetationNormalizeViewModel
//                                                                         //         .vegetationNormalizeList
//                                                                         //         .data!
//                                                                         //         .getSPVMAVEGETATIONNORMALIZEDYNAMIC![
//                                                                         //             index].id.toString(),
//                                                                         //             )));
//                                                                         // Navigator
//                                                                         //       .push(
//                                                                         //     context,
//                                                                         //     MaterialPageRoute(
//                                                                         //       builder: (context) => MapViewPage(
//                                                                         //         url: MapUrl.getAdminEndPoint(vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].tblSubMilesCostId.toString(),id),
//                                                                         //       ),
//                                                                         //     ),
//                                                                         //   );

//                                                                         await browser.open(
//                                                                             url:
//                                                                                 WebUri(
//                                                                                   // "https://mapapi.ariespro.com/main/admin/CIVM_Map/${vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].tblSubMilesCostId.toString()}/USRQWXH589Z"),
//                                                                                     MapUrl.getAdminEndPoint(vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDYNAMIC![index].tokenNo.toString(),id)),
//                                                                             settings: ChromeSafariBrowserSettings(shareState: CustomTabsShareState.SHARE_STATE_OFF, barCollapsingEnabled: true));
//                                                                       },
//                                                                       child:
//                                                                           Align(
//                                                                         alignment:
//                                                                             Alignment.centerLeft,
//                                                                         child:
//                                                                             Container(
//                                                                           // margin: const EdgeInsets.only(
//                                                                           //     left: 40, right: 40, bottom: 10.0),
//                                                                           padding: const EdgeInsets
//                                                                               .all(
//                                                                               8),
//                                                                           alignment:
//                                                                               Alignment.centerLeft,
//                                                                           width:
//                                                                               80,
//                                                                           // MediaQuery.of(context).size.width,
//                                                                           // height: MediaQuery.of(context).size.height * 0.4,
//                                                                           decoration: const BoxDecoration(
//                                                                               // shape: BoxShape.circle,

//                                                                               color: Color.fromARGB(255, 0, 58, 106),
//                                                                               gradient: LinearGradient(
//                                                                                 colors: [
//                                                                                   Color.fromARGB(255, 0, 79, 215),
//                                                                                   Colors.blue,
//                                                                                   Color.fromARGB(255, 0, 79, 215),
//                                                                                 ],
//                                                                               )),
//                                                                           child:
//                                                                               const Align(
//                                                                             alignment:
//                                                                                 Alignment.center,
//                                                                             child:
//                                                                                 Text(
//                                                                               "VIEW MAP",
//                                                                               style: TextStyle(
//                                                                                 color: Colors.white,
//                                                                                 fontWeight: FontWeight.bold,
//                                                                                 fontSize: 10,
//                                                                               ),
//                                                                             ),
//                                                                           ),
//                                                                         ),
//                                                                       ),
//                                                                     )
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

//   setData() {
//     dateSelected20 = '01/01/${now.year - 1}';
//     dateSelected21 =
//         '${_addLeadingZero(now.month)}/${_addLeadingZero(now.day)}/${now.year}';
//   }

//   void fetchData(
//     String substation,
//     String fdrName,
//     String sDate,
//     String eDate,
//     String outageCause,
//   ) {
//     vegetationNormalizeViewModel.fetchVegetationNormalizeListApi(
//         context, substation, fdrName, outageCause, sDate, eDate, outageCause);
//   }

//   List<_ChartDataSimpleColumnChart1> recreateDataVegetationOutageCause(
//       VegetationNormalizeViewModel value) {
//     dataSimpleColumnChart1.clear();
//     for (var i = 0;
//         i <
//             vegetationNormalizeViewModel.vegetationNormalizeList.data!
//                 .getSPVMAVEGETATIONNORMALIZEDATADYNAMIC!.length;
//         i++) {
//       dataSimpleColumnChart1.add(_ChartDataSimpleColumnChart1(
//           (vegetationNormalizeViewModel
//                       .vegetationNormalizeList
//                       .data!
//                       .getSPVMAVEGETATIONNORMALIZEDATADYNAMIC![i]
//                       .sDate!
//                       .isEmpty ||
//                   vegetationNormalizeViewModel.vegetationNormalizeList.data!
//                           .getSPVMAVEGETATIONNORMALIZEDATADYNAMIC![i].sDate
//                           .toString() ==
//                       'null')
//               ? ''
//               : DateFormat('yyyy-MM-dd').format(DateTime.parse(
//                   vegetationNormalizeViewModel.vegetationNormalizeList.data!
//                       .getSPVMAVEGETATIONNORMALIZEDATADYNAMIC![i].sDate
//                       .toString())),
//           (vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDATADYNAMIC![i].cAIDI.toString() ==
//                   'null')
//               ? 0
//               : double.parse(vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDATADYNAMIC![i].cAIDI.toString()),
//           (vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDATADYNAMIC![i].sAIDI.toString() == 'null') ? 0 : double.parse(vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDATADYNAMIC![i].sAIDI.toString()),
//           (vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDATADYNAMIC![i].sAIFI.toString() == 'null') ? 0 : double.parse(vegetationNormalizeViewModel.vegetationNormalizeList.data!.getSPVMAVEGETATIONNORMALIZEDATADYNAMIC![i].sAIFI.toString())));
//     }
//     return dataSimpleColumnChart1;
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
//   _ChartDataSimpleColumnChart1(this.x, this.y, this.y1, this.y2);

//   final String x;
//   final double y;
//   final double y1;
//   final double y2;
// }
