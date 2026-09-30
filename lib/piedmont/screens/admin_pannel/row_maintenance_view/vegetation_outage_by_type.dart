// import 'package:flutter/material.dart';
// import 'package:pie_chart/pie_chart.dart';
// import 'package:provider/provider.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';
// import 'package:pie_chart/pie_chart.dart' as pie_chart;
// import '../../../data/response/status.dart';
// import '../../../view_model/vegetation_outage_by_type_view_model.dart';
// import 'package:CIVM/piedmont/resources/app_colors.dart';

// // ignore: must_be_immutable
// class VegetationOutageByType extends StatefulWidget {
//   const VegetationOutageByType({Key? key}) : super(key: key);

//   @override
//   State<VegetationOutageByType> createState() => _VegetationOutageByTypeState();
// }

// class _VegetationOutageByTypeState extends State<VegetationOutageByType> {
// // ignore: prefer_typing_uninitialized_variables
//   var selectedSubstation;
//   int substationId = 0;

// // ignore: prefer_typing_uninitialized_variables
//   var selectedFeeder;
//   int feederId = 0;

//   // ignore: prefer_typing_uninitialized_variables
//   var selectedOutageCause;
//   int outageCauseId = 0;

//   List<_ChartDataSimpleColumnChart1> dataSimpleColumnChart1 = [];

//   List<_ChartDataSimpleColumnChart3> dataSimpleColumnChart3 = [];

//   List<_ChartDataSplinArea> chartDataSplinArea = [];

//   final TextEditingController _input = TextEditingController();
//   late final Future? myFuture;
//   var result = [];

//   Map<String, double> dataMap = {};
//   final gradientList = <List<Color>>[
//     [
//       const Color.fromARGB(255, 3, 79, 211),
//       const Color.fromARGB(255, 3, 79, 211)
//     ],
//     [
//       const Color.fromARGB(255, 245, 18, 1),
//       const Color.fromARGB(255, 245, 18, 1),
//     ],
//     [
//       Colors.orange,
//       Colors.orange,
//     ],
//     [
//       Colors.green,
//       Colors.green,
//     ]
//   ];

//   VegetationOutageByTypeViewModel vegetationOutageByTypeViewModel =
//       VegetationOutageByTypeViewModel();
//   late TooltipBehavior _tooltipBehavior1;
//   late TooltipBehavior _tooltipBehavior2;
//   late TooltipBehavior _tooltipBehavior3;

//   @override
//   void initState() {
//     vegetationOutageByTypeViewModel.fetchVegetationOutageByTypeListApi(
//         context, '', '', '', '');
//     super.initState();

//     _tooltipBehavior1 =
//         TooltipBehavior(enable: true, tooltipPosition: TooltipPosition.pointer);
//     _tooltipBehavior2 =
//         TooltipBehavior(enable: true, tooltipPosition: TooltipPosition.pointer);
//     _tooltipBehavior3 =
//         TooltipBehavior(enable: true, tooltipPosition: TooltipPosition.pointer);
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//        backgroundColor:AppColors.backgroundColor,
//         appBar: AppBar(
//           iconTheme: const IconThemeData(color: Colors.white),
//           title: const Text(
//             'Vegetation Outage By Type',
//             style: TextStyle(color: Colors.white),
//           ),
//           backgroundColor: AppColors.baseColor,
//           actions: const <Widget>[],
//         ),
//         body: ChangeNotifierProvider<VegetationOutageByTypeViewModel>(
//             create: (BuildContext context) => vegetationOutageByTypeViewModel,
//             child: Consumer<VegetationOutageByTypeViewModel>(
//                 builder: (context, value, _) {
//               switch (value.vegetationOutageByTypeList.status) {
//                 case Status.LOADING:
//                   return const Center(child: CircularProgressIndicator());
//                 case Status.ERROR:
//                   return
//                       // CustomToastSnackBarProgressDialog.flushBarErrorMessage(
//                       //     value.vegetationOutageByTypeList.message.toString(),
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
//                       selectedOutageCause = null;
//                       await vegetationOutageByTypeViewModel
//                           .fetchVegetationOutageByTypeListApi(
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
//                                                   vegetationOutageByTypeViewModel
//                                                       .vegetationOutageByTypeList
//                                                       .data!
//                                                       .findSubstationsAndIds!
//                                                       .map((e) {
//                                                 return DropdownMenuItem(
//                                                   value:
//                                                       e.substation.toString(),
//                                                   // e.getIdAndSubstationByCountId![0].subStation.toString(),
//                                                   child: Text(
//                                                       e.substation.toString()),
//                                                 );
//                                               }).toList(),
//                                               onChanged: (val) {
//                                                 setState(() {
//                                                   selectedSubstation = val;
//                                                 });
//                                                 if (selectedFeeder != null ||
//                                                     selectedOutageCause !=
//                                                         null) {
//                                                   selectedFeeder = null;
//                                                   selectedOutageCause = null;
//                                                 }
//                                                 print('val');
//                                                 print(val);
//                                                 fetchData(val!, '', '');
//                                                 substationId = int.parse(val);
//                                                 print('111111111111111');
//                                                 print(substationId);
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
//                                               items: vegetationOutageByTypeViewModel
//                                                   .vegetationOutageByTypeList
//                                                   .data!
//                                                   .findFdrNamesIdBySubstation!
//                                                   .map((e) {
//                                                 return DropdownMenuItem(
//                                                   value: e.fdrName.toString(),
//                                                   // e.getIdAndSubstationByCountId![0].subStation.toString(),
//                                                   child: Text(
//                                                       e.fdrName.toString()),
//                                                 );
//                                               }).toList(),
//                                               onChanged: (val) {
//                                                 setState(() {
//                                                   selectedFeeder = val;
//                                                 });
//                                                 if (selectedOutageCause !=
//                                                     null) {
//                                                   selectedOutageCause = null;
//                                                 }
//                                                 fetchData(selectedSubstation,
//                                                     val!, '');
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
//                                               items:
//                                                   vegetationOutageByTypeViewModel
//                                                       .vegetationOutageByTypeList
//                                                       .data!
//                                                       .findOutageCause!
//                                                       .map((e) {
//                                                 return DropdownMenuItem(
//                                                   value:
//                                                       e.outageCause.toString(),
//                                                   // e.getIdAndSubstationByCountId![0].subStation.toString(),
//                                                   child: Text(
//                                                       e.outageCause.toString()),
//                                                 );
//                                               }).toList(),
//                                               onChanged: (val) {
//                                                 setState(() {
//                                                   selectedOutageCause = val;
//                                                 });

//                                                 fetchData(selectedSubstation,
//                                                     selectedFeeder, val!);
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
//                             // Padding(
//                             //   padding: const EdgeInsets.only(
//                             //       top: 16.0, left: 16, right: 16),
//                             //   child: Container(
//                             //     padding: const EdgeInsets.all(10),
//                             //     alignment: Alignment.center,
//                             //     // width: size.width * 0.72,
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
//                             //                 "COMPLETED MILES: ",
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
//                             //                 (vegetationOutageByTypeViewModel
//                             //                                 .vegetationOutageByTypeList
//                             //                                 .data!
//                             //                                 .findCompletedMiles![
//                             //                                     0]
//                             //                                 .completedMiles ==
//                             //                             null ||
//                             //                         vegetationOutageByTypeViewModel
//                             //                                 .vegetationOutageByTypeList
//                             //                                 .data!
//                             //                                 .findCompletedMiles![
//                             //                                     0]
//                             //                                 .completedMiles
//                             //                                 .toString() ==
//                             //                             'null')
//                             //                     ? '0'
//                             //                     : vegetationOutageByTypeViewModel
//                             //                         .vegetationOutageByTypeList
//                             //                         .data!
//                             //                         .findCompletedMiles![0]
//                             //                         .completedMiles
//                             //                         .toString(),
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
//                                   Column(
//                                     children: [
//                                       Padding(
//                                           padding: const EdgeInsets.only(
//                                               top: 18.0, bottom: 18),
//                                           child: PieChart(
//                                             dataMap: (vegetationOutageByTypeViewModel
//                                                             .vegetationOutageByTypeList
//                                                             .data
//                                                             ?.findCntAndTypes ==
//                                                         null ||
//                                                     vegetationOutageByTypeViewModel
//                                                         .vegetationOutageByTypeList
//                                                         .data!
//                                                         .findCntAndTypes!
//                                                         .isEmpty)
//                                                 ? {'No Record Found': 0.0}
//                                                 : Map.fromEntries(
//                                                     List.generate(
//                                                       vegetationOutageByTypeViewModel
//                                                           .vegetationOutageByTypeList
//                                                           .data!
//                                                           .findCntAndTypes!
//                                                           .length,
//                                                       (index) {
//                                                         final item =
//                                                             vegetationOutageByTypeViewModel
//                                                                 .vegetationOutageByTypeList
//                                                                 .data!
//                                                                 .findCntAndTypes![index];
//                                                         final outageCause =
//                                                             item.cnt?.isEmpty ??
//                                                                     true
//                                                                 ? ''
//                                                                 : item.cnt
//                                                                     .toString();
//                                                         final cnt = item.type ==
//                                                                     null ||
//                                                                 item.type
//                                                                         .toString() ==
//                                                                     'null'
//                                                             ? 0.0
//                                                             : double.parse(item
//                                                                 .type
//                                                                 .toString());

//                                                         return MapEntry(
//                                                             outageCause
//                                                                 .toString(),
//                                                             cnt);
//                                                       },
//                                                     ),
//                                                   ),
//                                             animationDuration: const Duration(
//                                                 milliseconds: 800),
//                                             chartLegendSpacing: 32,
//                                             chartRadius: MediaQuery.of(context)
//                                                     .size
//                                                     .width /
//                                                 3.2,
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
//                                               showChartValueBackground: true,
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
//                                           "Vegetation Maintenance Type",
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
//                                             text: 'Type',
//                                             textStyle: const TextStyle(
//                                                 color: Colors.red,
//                                                 fontFamily: 'Roboto',
//                                                 fontSize: 16,
//                                                 fontStyle: FontStyle.italic,
//                                                 fontWeight: FontWeight.bold)),
//                                       ),
//                                       legend: Legend(isVisible: true),
//                                       palette: const <Color>[
//                                         Color.fromARGB(255, 3, 79, 211),
//                                       ],
//                                       series: <CartesianSeries>[
//                                         ColumnSeries<
//                                             _ChartDataSimpleColumnChart1,
//                                             String>(
//                                           name: 'CAUSE TYPE COUNT',
//                                           dataSource:
//                                               recreateDataVegetationMaintenanceType(
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
//                                           "Outage Duration(Hrs) By Year",
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
//                                       tooltipBehavior: _tooltipBehavior2,
//                                       primaryXAxis: CategoryAxis(
//                                         title: AxisTitle(
//                                             text: 'Year',
//                                             textStyle: const TextStyle(
//                                                 color: Colors.red,
//                                                 fontFamily: 'Roboto',
//                                                 fontSize: 16,
//                                                 fontStyle: FontStyle.italic,
//                                                 fontWeight: FontWeight.bold)),
//                                       ),
//                                       legend: Legend(isVisible: true),
//                                       palette: const <Color>[
//                                         Color.fromARGB(255, 3, 79, 211),
//                                       ],
//                                       series: <CartesianSeries>[
//                                         ColumnSeries<
//                                             _ChartDataSimpleColumnChart3,
//                                             String>(
//                                           name: 'OUTAGE COUNT BY YEAR',
//                                           dataSource:
//                                               recreateDataOutageCountByYear(
//                                                   value),
//                                           xValueMapper:
//                                               (_ChartDataSimpleColumnChart3
//                                                           data,
//                                                       _) =>
//                                                   data.x,
//                                           yValueMapper:
//                                               (_ChartDataSimpleColumnChart3
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
//                                     decoration: const BoxDecoration(
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
//                                           "Outage Duration(Hrs) By Vegetation",
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
//                                         tooltipBehavior: _tooltipBehavior3,
//                                         primaryXAxis: CategoryAxis(
//                                           title: AxisTitle(
//                                               text: 'OUTAGE CAUSE',
//                                               textStyle: const TextStyle(
//                                                   color: Colors.red,
//                                                   fontFamily: 'Roboto',
//                                                   fontSize: 16,
//                                                   fontStyle: FontStyle.italic,
//                                                   fontWeight: FontWeight.bold)),
//                                         ),
//                                         primaryYAxis: CategoryAxis(
//                                           title: AxisTitle(
//                                               text: 'OUTAGE DURATION',
//                                               textStyle: const TextStyle(
//                                                   color: Colors.red,
//                                                   fontFamily: 'Roboto',
//                                                   fontSize: 16,
//                                                   fontStyle: FontStyle.italic,
//                                                   fontWeight: FontWeight.bold)),
//                                         ),
//                                         legend: Legend(isVisible: true),
//                                         palette: const <Color>[
//                                           Color.fromARGB(255, 169, 220, 248),
//                                         ],
//                                         series: <ChartSeries>[
//                                           AreaSeries<_ChartDataSplinArea,
//                                               String>(
//                                             name: 'OUTAGE DURATION',
//                                             dataSource:
//                                                 recreateDataOutageDurationByVegetation(
//                                                     value),
//                                             borderDrawMode:
//                                                 BorderDrawMode.excludeBottom,
//                                             borderColor: const Color.fromARGB(
//                                                 255, 7, 59, 120),
//                                             borderWidth: 2,
//                                             xValueMapper:
//                                                 (_ChartDataSplinArea data, _) =>
//                                                     data.x,
//                                             yValueMapper:
//                                                 (_ChartDataSplinArea data, _) =>
//                                                     data.y,
//                                             enableTooltip: true,
//                                             markerSettings:
//                                                 const MarkerSettings(
//                                                     isVisible: true,
//                                                     shape:
//                                                         DataMarkerType.diamond),
//                                             dataLabelSettings:
//                                                 const DataLabelSettings(
//                                                     isVisible: true),
//                                           ),
//                                         ]),
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
//                                             vegetationOutageByTypeViewModel
//                                                 .vegetationOutageByTypeList
//                                                 .data!
//                                                 .getSPOUTAGESUBFDRTABLEDATA!
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
//                                                 controller: _input,
//                                                 style: const TextStyle(
//                                                     color: Color.fromARGB(
//                                                         255, 7, 59, 120),
//                                                     fontSize: 16),
//                                                 obscureText: false,
//                                                 decoration:
//                                                     const InputDecoration(
//                                                   border: OutlineInputBorder(),
//                                                   enabledBorder:
//                                                       OutlineInputBorder(
//                                                     borderSide: BorderSide(
//                                                       color: Color.fromARGB(
//                                                           255, 23, 1, 88),
//                                                     ),
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
//                                       child: Align(
//                                         alignment: Alignment.center,
//                                         child: ListView.builder(
//                                             itemCount:
//                                                 vegetationOutageByTypeViewModel
//                                                     .vegetationOutageByTypeList
//                                                     .data!
//                                                     .getSPOUTAGESUBFDRTABLEDATA!
//                                                     .length,
//                                             // itemCount: historyList.length,
//                                             itemBuilder:
//                                                 (BuildContext ctxt, int index) {
//                                               return Row(
//                                                 children: [
//                                                   Padding(
//                                                     padding:
//                                                         const EdgeInsets.only(
//                                                             top: 4.0,
//                                                             bottom: 4,
//                                                             left: 2,
//                                                             right: 2),
//                                                     child: Container(
//                                                       width:
//                                                           MediaQuery.of(context)
//                                                                   .size
//                                                                   .width *
//                                                               0.95,
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
//                                                                 // alignment: Alignment.topLeft,
//                                                                 child: Column(
//                                                                   children: [
//                                                                     const Align(
//                                                                       alignment:
//                                                                           Alignment
//                                                                               .topLeft,
//                                                                       child:
//                                                                           Text(
//                                                                         "SUBSTAT NAME : ",
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
//                                                                         (vegetationOutageByTypeViewModel.vegetationOutageByTypeList.data!.getSPOUTAGESUBFDRTABLEDATA![index].subStateName == null ||
//                                                                                 vegetationOutageByTypeViewModel.vegetationOutageByTypeList.data!.getSPOUTAGESUBFDRTABLEDATA![index].subStateName.toString() == 'null')
//                                                                             ? ''
//                                                                             : vegetationOutageByTypeViewModel.vegetationOutageByTypeList.data!.getSPOUTAGESUBFDRTABLEDATA![index].subStateName.toString(),
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
//                                                                         "FDR NAME: ",
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
//                                                                         (vegetationOutageByTypeViewModel.vegetationOutageByTypeList.data!.getSPOUTAGESUBFDRTABLEDATA![index].fdrName == null ||
//                                                                                 vegetationOutageByTypeViewModel.vegetationOutageByTypeList.data!.getSPOUTAGESUBFDRTABLEDATA![index].fdrName.toString() == 'null')
//                                                                             ? ''
//                                                                             : vegetationOutageByTypeViewModel.vegetationOutageByTypeList.data!.getSPOUTAGESUBFDRTABLEDATA![index].fdrName.toString(),
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
//                                                                         "OUTAGERECID: ",
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
//                                                                         (vegetationOutageByTypeViewModel.vegetationOutageByTypeList.data!.getSPOUTAGESUBFDRTABLEDATA![index].outagerecId == null ||
//                                                                                 vegetationOutageByTypeViewModel.vegetationOutageByTypeList.data!.getSPOUTAGESUBFDRTABLEDATA![index].outagerecId.toString() == 'null')
//                                                                             ? ''
//                                                                             : vegetationOutageByTypeViewModel.vegetationOutageByTypeList.data!.getSPOUTAGESUBFDRTABLEDATA![index].outagerecId.toString(),
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
//                                                                         "TRANSFORMER COUNT: ",
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
//                                                                         (vegetationOutageByTypeViewModel.vegetationOutageByTypeList.data!.getSPOUTAGESUBFDRTABLEDATA![index].transformerCount == null ||
//                                                                                 vegetationOutageByTypeViewModel.vegetationOutageByTypeList.data!.getSPOUTAGESUBFDRTABLEDATA![index].transformerCount.toString() == 'null')
//                                                                             ? ''
//                                                                             : vegetationOutageByTypeViewModel.vegetationOutageByTypeList.data!.getSPOUTAGESUBFDRTABLEDATA![index].transformerCount.toString(),
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
//                                                                         (vegetationOutageByTypeViewModel.vegetationOutageByTypeList.data!.getSPOUTAGESUBFDRTABLEDATA![index].feeder == null ||
//                                                                                 vegetationOutageByTypeViewModel.vegetationOutageByTypeList.data!.getSPOUTAGESUBFDRTABLEDATA![index].feeder.toString() == 'null')
//                                                                             ? ''
//                                                                             : vegetationOutageByTypeViewModel.vegetationOutageByTypeList.data!.getSPOUTAGESUBFDRTABLEDATA![index].feeder.toString(),
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
//                                                                         "DISTRICT: ",
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
//                                                                         (vegetationOutageByTypeViewModel.vegetationOutageByTypeList.data!.getSPOUTAGESUBFDRTABLEDATA![index].district == null ||
//                                                                                 vegetationOutageByTypeViewModel.vegetationOutageByTypeList.data!.getSPOUTAGESUBFDRTABLEDATA![index].district.toString() == 'null')
//                                                                             ? ''
//                                                                             : vegetationOutageByTypeViewModel.vegetationOutageByTypeList.data!.getSPOUTAGESUBFDRTABLEDATA![index].district.toString(),
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
//                                                                         "RDNG DT: ",
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
//                                                                         (vegetationOutageByTypeViewModel.vegetationOutageByTypeList.data!.getSPOUTAGESUBFDRTABLEDATA![index].redngDt == null ||
//                                                                                 vegetationOutageByTypeViewModel.vegetationOutageByTypeList.data!.getSPOUTAGESUBFDRTABLEDATA![index].redngDt.toString() == 'null')
//                                                                             ? ''
//                                                                             : vegetationOutageByTypeViewModel.vegetationOutageByTypeList.data!.getSPOUTAGESUBFDRTABLEDATA![index].redngDt.toString(),
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
//                                                                         "OUTAGE CUSTOMER: ",
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
//                                                                         (vegetationOutageByTypeViewModel.vegetationOutageByTypeList.data!.getSPOUTAGESUBFDRTABLEDATA![index].outageCustomer == null ||
//                                                                                 vegetationOutageByTypeViewModel.vegetationOutageByTypeList.data!.getSPOUTAGESUBFDRTABLEDATA![index].outageCustomer.toString() == 'null')
//                                                                             ? ''
//                                                                             : vegetationOutageByTypeViewModel.vegetationOutageByTypeList.data!.getSPOUTAGESUBFDRTABLEDATA![index].outageCustomer.toString(),
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
//                                                                         "OUTAGE DURATION: ",
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
//                                                                         (vegetationOutageByTypeViewModel.vegetationOutageByTypeList.data!.getSPOUTAGESUBFDRTABLEDATA![index].outageDuration == null ||
//                                                                                 vegetationOutageByTypeViewModel.vegetationOutageByTypeList.data!.getSPOUTAGESUBFDRTABLEDATA![index].outageDuration.toString() == 'null')
//                                                                             ? ''
//                                                                             : vegetationOutageByTypeViewModel.vegetationOutageByTypeList.data!.getSPOUTAGESUBFDRTABLEDATA![index].outageDuration.toString(),
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
//                                                                         "OTG HOURS: ",
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
//                                                                         (vegetationOutageByTypeViewModel.vegetationOutageByTypeList.data!.getSPOUTAGESUBFDRTABLEDATA![index].otgHours == null ||
//                                                                                 vegetationOutageByTypeViewModel.vegetationOutageByTypeList.data!.getSPOUTAGESUBFDRTABLEDATA![index].otgHours.toString() == 'null')
//                                                                             ? ''
//                                                                             : vegetationOutageByTypeViewModel.vegetationOutageByTypeList.data!.getSPOUTAGESUBFDRTABLEDATA![index].otgHours.toString(),
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
//                                                                         (vegetationOutageByTypeViewModel.vegetationOutageByTypeList.data!.getSPOUTAGESUBFDRTABLEDATA![index].type == null ||
//                                                                                 vegetationOutageByTypeViewModel.vegetationOutageByTypeList.data!.getSPOUTAGESUBFDRTABLEDATA![index].type.toString() == 'null')
//                                                                             ? ''
//                                                                             : vegetationOutageByTypeViewModel.vegetationOutageByTypeList.data!.getSPOUTAGESUBFDRTABLEDATA![index].type.toString(),
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
//                                                                         "OUTAGE CAUSE: ",
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
//                                                                         (vegetationOutageByTypeViewModel.vegetationOutageByTypeList.data!.getSPOUTAGESUBFDRTABLEDATA![index].outageCause == null ||
//                                                                                 vegetationOutageByTypeViewModel.vegetationOutageByTypeList.data!.getSPOUTAGESUBFDRTABLEDATA![index].outageCause.toString() == 'null')
//                                                                             ? ''
//                                                                             : vegetationOutageByTypeViewModel.vegetationOutageByTypeList.data!.getSPOUTAGESUBFDRTABLEDATA![index].outageCause.toString(),
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
//                                                                         "MILES OF LINE: ",
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
//                                                                         (vegetationOutageByTypeViewModel.vegetationOutageByTypeList.data!.getSPOUTAGESUBFDRTABLEDATA![index].milesOfLine == null ||
//                                                                                 vegetationOutageByTypeViewModel.vegetationOutageByTypeList.data!.getSPOUTAGESUBFDRTABLEDATA![index].milesOfLine.toString() == 'null')
//                                                                             ? ''
//                                                                             : vegetationOutageByTypeViewModel.vegetationOutageByTypeList.data!.getSPOUTAGESUBFDRTABLEDATA![index].milesOfLine.toString(),
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
//                                                                         "MNTH NO: ",
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
//                                                                         (vegetationOutageByTypeViewModel.vegetationOutageByTypeList.data!.getSPOUTAGESUBFDRTABLEDATA![index].mnthNo == null ||
//                                                                                 vegetationOutageByTypeViewModel.vegetationOutageByTypeList.data!.getSPOUTAGESUBFDRTABLEDATA![index].mnthNo.toString() == 'null')
//                                                                             ? ''
//                                                                             : vegetationOutageByTypeViewModel.vegetationOutageByTypeList.data!.getSPOUTAGESUBFDRTABLEDATA![index].mnthNo.toString(),
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
//                                                                         "MNTH NAME: ",
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
//                                                                         (vegetationOutageByTypeViewModel.vegetationOutageByTypeList.data!.getSPOUTAGESUBFDRTABLEDATA![index].mnthName == null ||
//                                                                                 vegetationOutageByTypeViewModel.vegetationOutageByTypeList.data!.getSPOUTAGESUBFDRTABLEDATA![index].mnthName.toString() == 'null')
//                                                                             ? ''
//                                                                             : vegetationOutageByTypeViewModel.vegetationOutageByTypeList.data!.getSPOUTAGESUBFDRTABLEDATA![index].mnthName.toString(),
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
//                                                                         "SEASON: ",
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
//                                                                         (vegetationOutageByTypeViewModel.vegetationOutageByTypeList.data!.getSPOUTAGESUBFDRTABLEDATA![index].season == null ||
//                                                                                 vegetationOutageByTypeViewModel.vegetationOutageByTypeList.data!.getSPOUTAGESUBFDRTABLEDATA![index].season.toString() == 'null')
//                                                                             ? ''
//                                                                             : vegetationOutageByTypeViewModel.vegetationOutageByTypeList.data!.getSPOUTAGESUBFDRTABLEDATA![index].season.toString(),
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
//                                                                         (vegetationOutageByTypeViewModel.vegetationOutageByTypeList.data!.getSPOUTAGESUBFDRTABLEDATA![index].saidi == null ||
//                                                                                 vegetationOutageByTypeViewModel.vegetationOutageByTypeList.data!.getSPOUTAGESUBFDRTABLEDATA![index].saidi.toString() == 'null')
//                                                                             ? ''
//                                                                             : vegetationOutageByTypeViewModel.vegetationOutageByTypeList.data!.getSPOUTAGESUBFDRTABLEDATA![index].saidi.toString(),
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
//                                                                         (vegetationOutageByTypeViewModel.vegetationOutageByTypeList.data!.getSPOUTAGESUBFDRTABLEDATA![index].saifi == null ||
//                                                                                 vegetationOutageByTypeViewModel.vegetationOutageByTypeList.data!.getSPOUTAGESUBFDRTABLEDATA![index].saifi.toString() == 'null')
//                                                                             ? ''
//                                                                             : vegetationOutageByTypeViewModel.vegetationOutageByTypeList.data!.getSPOUTAGESUBFDRTABLEDATA![index].saifi.toString(),
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
//                                                                         (vegetationOutageByTypeViewModel.vegetationOutageByTypeList.data!.getSPOUTAGESUBFDRTABLEDATA![index].caidi == null ||
//                                                                                 vegetationOutageByTypeViewModel.vegetationOutageByTypeList.data!.getSPOUTAGESUBFDRTABLEDATA![index].caidi.toString() == 'null')
//                                                                             ? ''
//                                                                             : vegetationOutageByTypeViewModel.vegetationOutageByTypeList.data!.getSPOUTAGESUBFDRTABLEDATA![index].caidi.toString(),
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
//                                                                         (vegetationOutageByTypeViewModel.vegetationOutageByTypeList.data!.getSPOUTAGESUBFDRTABLEDATA![index].totalMiles == null ||
//                                                                                 vegetationOutageByTypeViewModel.vegetationOutageByTypeList.data!.getSPOUTAGESUBFDRTABLEDATA![index].totalMiles.toString() == 'null')
//                                                                             ? ''
//                                                                             : vegetationOutageByTypeViewModel.vegetationOutageByTypeList.data!.getSPOUTAGESUBFDRTABLEDATA![index].totalMiles.toString(),
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
//                                                                         "COST PER MILE: ",
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
//                                                                         (vegetationOutageByTypeViewModel.vegetationOutageByTypeList.data!.getSPOUTAGESUBFDRTABLEDATA![index].costPerMile == null ||
//                                                                                 vegetationOutageByTypeViewModel.vegetationOutageByTypeList.data!.getSPOUTAGESUBFDRTABLEDATA![index].costPerMile.toString() == 'null')
//                                                                             ? ''
//                                                                             : vegetationOutageByTypeViewModel.vegetationOutageByTypeList.data!.getSPOUTAGESUBFDRTABLEDATA![index].costPerMile.toString(),
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
//                                                                         (vegetationOutageByTypeViewModel.vegetationOutageByTypeList.data!.getSPOUTAGESUBFDRTABLEDATA![index].totalCost == null ||
//                                                                                 vegetationOutageByTypeViewModel.vegetationOutageByTypeList.data!.getSPOUTAGESUBFDRTABLEDATA![index].totalCost.toString() == 'null')
//                                                                             ? ''
//                                                                             : vegetationOutageByTypeViewModel.vegetationOutageByTypeList.data!.getSPOUTAGESUBFDRTABLEDATA![index].totalCost.toString(),
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
//                                                                         "DUE YEAR: ",
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
//                                                                         (vegetationOutageByTypeViewModel.vegetationOutageByTypeList.data!.getSPOUTAGESUBFDRTABLEDATA![index].dueYr == null ||
//                                                                                 vegetationOutageByTypeViewModel.vegetationOutageByTypeList.data!.getSPOUTAGESUBFDRTABLEDATA![index].dueYr.toString() == 'null')
//                                                                             ? ''
//                                                                             : vegetationOutageByTypeViewModel.vegetationOutageByTypeList.data!.getSPOUTAGESUBFDRTABLEDATA![index].dueYr.toString(),
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
//                                                                         "BUDGET: ",
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
//                                                                         (vegetationOutageByTypeViewModel.vegetationOutageByTypeList.data!.getSPOUTAGESUBFDRTABLEDATA![index].budget == null ||
//                                                                                 vegetationOutageByTypeViewModel.vegetationOutageByTypeList.data!.getSPOUTAGESUBFDRTABLEDATA![index].budget.toString() == 'null')
//                                                                             ? ''
//                                                                             : vegetationOutageByTypeViewModel.vegetationOutageByTypeList.data!.getSPOUTAGESUBFDRTABLEDATA![index].budget.toString(),
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
//                                                                         "AGGR COST: ",
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
//                                                                         (vegetationOutageByTypeViewModel.vegetationOutageByTypeList.data!.getSPOUTAGESUBFDRTABLEDATA![index].aggrCost == null ||
//                                                                                 vegetationOutageByTypeViewModel.vegetationOutageByTypeList.data!.getSPOUTAGESUBFDRTABLEDATA![index].aggrCost.toString() == 'null')
//                                                                             ? ''
//                                                                             : vegetationOutageByTypeViewModel.vegetationOutageByTypeList.data!.getSPOUTAGESUBFDRTABLEDATA![index].aggrCost.toString(),
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

//   List<_ChartDataSimpleColumnChart1> recreateDataVegetationMaintenanceType(
//       VegetationOutageByTypeViewModel value) {
//     dataSimpleColumnChart1.clear();

//     for (var i = 0;
//         i <
//             vegetationOutageByTypeViewModel
//                 .vegetationOutageByTypeList.data!.findCntAndTypes!.length;
//         i++) {
//       dataSimpleColumnChart1.add(_ChartDataSimpleColumnChart1(
//           vegetationOutageByTypeViewModel
//               .vegetationOutageByTypeList.data!.findCntAndTypes![i].cnt
//               .toString(),
//           double.parse(vegetationOutageByTypeViewModel
//               .vegetationOutageByTypeList.data!.findCntAndTypes![i].type
//               .toString())));
//     }
//     return dataSimpleColumnChart1;
//   }

//   List<_ChartDataSimpleColumnChart3> recreateDataOutageCountByYear(
//       VegetationOutageByTypeViewModel value) {
//     dataSimpleColumnChart3.clear();

//     for (var i = 0;
//         i <
//             vegetationOutageByTypeViewModel
//                 .vegetationOutageByTypeList.data!.findCntAndYears!.length;
//         i++) {
//       dataSimpleColumnChart3.add(_ChartDataSimpleColumnChart3(
//           vegetationOutageByTypeViewModel
//               .vegetationOutageByTypeList.data!.findCntAndYears![i].year
//               .toString(),
//           double.parse(vegetationOutageByTypeViewModel
//               .vegetationOutageByTypeList.data!.findCntAndYears![i].outAgeSum
//               .toString())));
//     }
//     return dataSimpleColumnChart3;
//   }

//   List<_ChartDataSplinArea> recreateDataOutageDurationByVegetation(
//       VegetationOutageByTypeViewModel value) {
//     chartDataSplinArea.clear();

//     for (var i = 0;
//         i <
//             vegetationOutageByTypeViewModel.vegetationOutageByTypeList.data!
//                 .outagesDurationByVegetation!.length;
//         i++) {
//       chartDataSplinArea.add(_ChartDataSplinArea(
//           vegetationOutageByTypeViewModel.vegetationOutageByTypeList.data!
//               .outagesDurationByVegetation![i].type
//               .toString(),
//           double.parse(vegetationOutageByTypeViewModel
//               .vegetationOutageByTypeList
//               .data!
//               .outagesDurationByVegetation![i]
//               .outageSum
//               .toString())));
//     }
//     return chartDataSplinArea;
//   }

//   void fetchData(String substation, String fdrName, String outageCause) {
//     vegetationOutageByTypeViewModel.fetchVegetationOutageByTypeListApi(
//       context,
//       outageCause,
//       substation,
//       fdrName,
//       outageCause,
//     );
//   }

//   Future<void> _filterData(String query) async {
//     if (query.isEmpty) {
//       vegetationOutageByTypeViewModel.fetchVegetationOutageByTypeListApi(
//           context, '', '', '', '');
//     } else {
//       vegetationOutageByTypeViewModel.vegetationOutageByTypeList.data!.getSPOUTAGESUBFDRTABLEDATA = vegetationOutageByTypeViewModel
//           .vegetationOutageByTypeList.data!.getSPOUTAGESUBFDRTABLEDATA!
//           .where((item) =>
//               item.subStateName!.toLowerCase().contains(query.toLowerCase()) ||
//               item.feeder!.toLowerCase().contains(query.toLowerCase()) ||
//               item.redngDt!.toLowerCase().contains(query.toLowerCase()) ||
//               item.outageCustomer!
//                   .toString()
//                   .toLowerCase()
//                   .contains(query.toLowerCase()) ||
//               item.outageDuration!
//                   .toString()
//                   .toLowerCase()
//                   .contains(query.toLowerCase()) ||
//               item.otgHours!
//                   .toString()
//                   .toLowerCase()
//                   .contains(query.toLowerCase()) ||
//               item.type!
//                   .toString()
//                   .toLowerCase()
//                   .contains(query.toLowerCase()) ||
//               item.outageCause!
//                   .toString()
//                   .toLowerCase()
//                   .contains(query.toLowerCase()) ||
//               item.milesOfLine!
//                   .toString()
//                   .toLowerCase()
//                   .contains(query.toLowerCase()) ||
//               item.mnthNo!
//                   .toString()
//                   .toLowerCase()
//                   .contains(query.toLowerCase()) ||
//               item.mnthName!
//                   .toString()
//                   .toLowerCase()
//                   .contains(query.toLowerCase()) ||
//               item.season!
//                   .toString()
//                   .toLowerCase()
//                   .contains(query.toLowerCase()) ||
//               item.saidi!.toString().toLowerCase().contains(query.toLowerCase()) ||
//               item.saifi!.toString().toLowerCase().contains(query.toLowerCase()) ||
//               item.caidi!.toString().toLowerCase().contains(query.toLowerCase()) ||
//               item.totalMiles!.toString().toLowerCase().contains(query.toLowerCase()) ||
//               item.costPerMile!.toString().toLowerCase().contains(query.toLowerCase()) ||
//               item.totalCost!.toString().toLowerCase().contains(query.toLowerCase()) ||
//               item.dueYr!.toString().toLowerCase().contains(query.toLowerCase()) ||
//               item.budget!.toString().toLowerCase().contains(query.toLowerCase()) ||
//               item.aggrCost!.toString().toLowerCase().contains(query.toLowerCase()) ||
//               item.fdrName!.toString().toLowerCase().contains(query.toLowerCase()))
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

// class _ChartDataSimpleColumnChart3 {
//   _ChartDataSimpleColumnChart3(this.x, this.y);

//   final String x;
//   final double y;
//   // final Color? color;
// }

// class _ChartDataSplinArea {
//   _ChartDataSplinArea(this.x, this.y);

//   final String x;
//   final double y;
//   // final Color? color;
// }
