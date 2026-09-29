// // import 'package:CIVM/screens/admin_pannel/map_view_admin.dart';
// import 'package:CIVM/screens/my_chrome_safari_map_recording.dart';
// import 'package:CIVM/screens/planner_pannel.dart/planner_row_maintenance_plan_job_details_screen.dart';
// import 'package:CIVM/utils/common_functions.dart';
// import 'package:CIVM/utils/custom_toast_snackbar_progressdialog.dart';
// import 'package:CIVM/utils/user_pref.dart';
// import 'package:flutter/material.dart';
// // import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// import 'package:provider/provider.dart';
// import 'package:tiny_charts/tiny_charts.dart';
// import '../../../data/response/status.dart';
// import '../../../view_model/row_maintenance_plan_dashboard_view_model.dart';
// import 'package:dio/dio.dart';

// // ignore: must_be_immutable
// class PlannerRowMaintenancePlanDashboard extends StatefulWidget {
//   const PlannerRowMaintenancePlanDashboard({super.key});

//   @override
//   State<PlannerRowMaintenancePlanDashboard> createState() =>
//       _PlannerRowMaintenancePlanDashboardState();
// }

// class _PlannerRowMaintenancePlanDashboardState
//     extends State<PlannerRowMaintenancePlanDashboard> {
//   final TextEditingController _input = TextEditingController();
//   late final Future? myFuture;
//   var result = [];
//   List<ChartData> pieChartData = [];

//   final browser = MyChromeSafariBrowser();
//   // late TooltipBehavior _tooltipBehavior = TooltipBehavior(enable: true);
//   // late ZoomPanBehavior _zoomPanBehavior;

//   List<Map<String, dynamic>> listOfColumns = [];
//   List<Map<String, dynamic>> listOfColumns1 = [];

//   RowMaintenancePlanViewModel rowMaintenancePlanViewModel =
//       RowMaintenancePlanViewModel();

//   @override
//   void initState() {
//     rowMaintenancePlanViewModel.fetchProgressBarRowMaintDataApi(context);
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//         body: ChangeNotifierProvider<RowMaintenancePlanViewModel>(
//             create: (BuildContext context) => rowMaintenancePlanViewModel,
//             child: Consumer<RowMaintenancePlanViewModel>(
//                 builder: (context, value, _) {
//               switch (value.rowMaintenancePlanGetData.status) {
//                 case Status.LOADING:
//                   return const Center(child: CircularProgressIndicator());
//                 case Status.ERROR:
//                   return
//                       // CustomToastSnackBarProgressDialog.flushBarErrorMessage(
//                       //     value.rowMaintenancePlanGetData.message.toString(),
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
//                               'assets/empty_box.png',
//                               height: 200,
//                               width: 200,
//                               fit: BoxFit.cover,
//                             ),
//                             const Center(
//                               child: Text(
//                                 'Sorry, Data Not Found!',
//                                 textAlign: TextAlign.left,
//                                 style: TextStyle(
//                                   color: Color.fromARGB(255, 7, 59, 120),
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
//                       await rowMaintenancePlanViewModel
//                           .fetchProgressBarRowMaintDataApi(context);
//                     },
//                     child: SingleChildScrollView(
//                       child: Center(
//                         child: Column(
//                           children: [
//                             Container(
//                               margin: const EdgeInsets.only(
//                                   left: 8, right: 8, top: 10, bottom: 8),
//                               padding: const EdgeInsets.all(8),
//                               alignment: Alignment.center,
//                               // height: size.height * 0.5,
//                               width: size.width * 0.99,
//                               decoration: BoxDecoration(
//                                   // shape: BoxShape.circle,
//                                   borderRadius: BorderRadius.circular(10),
//                                   boxShadow: const [
//                                     BoxShadow(
//                                         color: Color.fromARGB(255, 7, 59, 120),
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
//                                     height: 50,
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
//                                             Color.fromARGB(255, 7, 59, 120),
//                                             Color.fromARGB(255, 7, 59, 120)
//                                           ],
//                                         )),
//                                     child: const Align(
//                                       alignment: Alignment.centerLeft,
//                                       child: Text(
//                                         "Progress Bars ",
//                                         textAlign: TextAlign.left,
//                                         style: TextStyle(
//                                           color: Colors.white,
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 20,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   Row(
//                                     children: [
//                                       const Padding(
//                                         padding:
//                                             EdgeInsets.only(top: 8.0, left: 8),
//                                         child: Align(
//                                           alignment: Alignment.topLeft,
//                                           child: Text(
//                                             "PENDING: ",
//                                             textAlign: TextAlign.left,
//                                             style: TextStyle(
//                                               color: Color.fromARGB(
//                                                   255, 7, 59, 120),
//                                               fontWeight: FontWeight.bold,
//                                               fontSize: 16,
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                       Padding(
//                                         padding:
//                                             const EdgeInsets.only(top: 8.0),
//                                         child: Text(
//                                           (value
//                                                       .rowMaintenancePlanGetData
//                                                       .data!
//                                                       .costTotalMilesMilesCmpltedMilesInProgressMilesPending![
//                                                           0]
//                                                       .milesPending
//                                                       .toString()
//                                                       .isEmpty ||
//                                                   value
//                                                           .rowMaintenancePlanGetData
//                                                           .data!
//                                                           .costTotalMilesMilesCmpltedMilesInProgressMilesPending![
//                                                               0]
//                                                           .milesPending ==
//                                                       null)
//                                               ? '0%'
//                                               : '${value.rowMaintenancePlanGetData.data!.costTotalMilesMilesCmpltedMilesInProgressMilesPending![0].milesPending.toString()}%',
//                                           textAlign: TextAlign.left,
//                                           style: const TextStyle(
//                                             color:
//                                                 Color.fromARGB(255, 7, 59, 120),
//                                             fontWeight: FontWeight.bold,
//                                             fontSize: 16,
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   TinyBarChart.stacked(
//                                     data: <double>[
//                                       double.parse(value
//                                               .rowMaintenancePlanGetData
//                                               .data!
//                                               .costTotalMilesMilesCmpltedMilesInProgressMilesPending![
//                                                   0]
//                                               .milesPending
//                                               ?.toString() ??
//                                           '0.0'),
//                                       100.00 -
//                                           double.parse(value
//                                                   .rowMaintenancePlanGetData
//                                                   .data!
//                                                   .costTotalMilesMilesCmpltedMilesInProgressMilesPending![
//                                                       0]
//                                                   .milesPending
//                                                   ?.toString() ??
//                                               '0.0')
//                                     ],
//                                     options: const TinyBarChartOptions(
//                                       colors: [
//                                         Color.fromARGB(255, 60, 200, 243),
//                                         Color.fromARGB(255, 222, 220, 220),
//                                       ],
//                                     ),
//                                     width: size.width * 0.9,
//                                     height: 28,
//                                   ),
//                                   Row(
//                                     children: [
//                                       const Padding(
//                                         padding:
//                                             EdgeInsets.only(top: 8.0, left: 8),
//                                         child: Align(
//                                           alignment: Alignment.topLeft,
//                                           child: Text(
//                                             "IN PROGRESS: ",
//                                             textAlign: TextAlign.left,
//                                             style: TextStyle(
//                                               color: Color.fromARGB(
//                                                   255, 7, 59, 120),
//                                               fontWeight: FontWeight.bold,
//                                               fontSize: 16,
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                       Padding(
//                                         padding:
//                                             const EdgeInsets.only(top: 8.0),
//                                         child: Text(
//                                           (value
//                                                       .rowMaintenancePlanGetData
//                                                       .data!
//                                                       .costTotalMilesMilesCmpltedMilesInProgressMilesPending![
//                                                           0]
//                                                       .milesInProgress
//                                                       .toString()
//                                                       .isEmpty ||
//                                                   value
//                                                           .rowMaintenancePlanGetData
//                                                           .data!
//                                                           .costTotalMilesMilesCmpltedMilesInProgressMilesPending![
//                                                               0]
//                                                           .milesInProgress ==
//                                                       null)
//                                               ? '0%'
//                                               : '${value.rowMaintenancePlanGetData.data!.costTotalMilesMilesCmpltedMilesInProgressMilesPending![0].milesInProgress.toString()}%',
//                                           // "18.48%",
//                                           textAlign: TextAlign.left,
//                                           style: const TextStyle(
//                                             color:
//                                                 Color.fromARGB(255, 7, 59, 120),
//                                             fontWeight: FontWeight.bold,
//                                             fontSize: 16,
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   TinyBarChart.stacked(
//                                     data: <double>[
//                                       double.parse(value
//                                               .rowMaintenancePlanGetData
//                                               .data!
//                                               .costTotalMilesMilesCmpltedMilesInProgressMilesPending![
//                                                   0]
//                                               .milesInProgress
//                                               ?.toString() ??
//                                           '0.0'),
//                                       100.00 -
//                                           double.parse(value
//                                                   .rowMaintenancePlanGetData
//                                                   .data!
//                                                   .costTotalMilesMilesCmpltedMilesInProgressMilesPending![
//                                                       0]
//                                                   .milesInProgress
//                                                   ?.toString() ??
//                                               '0.0')
//                                     ],
//                                     options: const TinyBarChartOptions(
//                                       colors: [
//                                         Colors.orange,
//                                         Color.fromARGB(255, 222, 220, 220),
//                                       ],
//                                     ),
//                                     width: size.width * 0.9,
//                                     height: 28,
//                                   ),
//                                   Row(
//                                     children: [
//                                       const Padding(
//                                         padding:
//                                             EdgeInsets.only(top: 8.0, left: 8),
//                                         child: Align(
//                                           alignment: Alignment.topLeft,
//                                           child: Text(
//                                             "COMPLETED: ",
//                                             textAlign: TextAlign.left,
//                                             style: TextStyle(
//                                               color: Color.fromARGB(
//                                                   255, 7, 59, 120),
//                                               fontWeight: FontWeight.bold,
//                                               fontSize: 16,
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                       Padding(
//                                         padding:
//                                             const EdgeInsets.only(top: 8.0),
//                                         child: Text(
//                                           (value
//                                                       .rowMaintenancePlanGetData
//                                                       .data!
//                                                       .costTotalMilesMilesCmpltedMilesInProgressMilesPending![
//                                                           0]
//                                                       .milesCompleted
//                                                       .toString()
//                                                       .isEmpty ||
//                                                   value
//                                                           .rowMaintenancePlanGetData
//                                                           .data!
//                                                           .costTotalMilesMilesCmpltedMilesInProgressMilesPending![
//                                                               0]
//                                                           .milesCompleted ==
//                                                       null)
//                                               ? '0%'
//                                               : '${value.rowMaintenancePlanGetData.data!.costTotalMilesMilesCmpltedMilesInProgressMilesPending![0].milesCompleted.toString()}%',
//                                           // "53.58%",
//                                           textAlign: TextAlign.left,
//                                           style: const TextStyle(
//                                             color:
//                                                 Color.fromARGB(255, 7, 59, 120),
//                                             fontWeight: FontWeight.bold,
//                                             fontSize: 16,
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   TinyBarChart.stacked(
//                                     data: <double>[
//                                       double.parse(value
//                                               .rowMaintenancePlanGetData
//                                               .data!
//                                               .costTotalMilesMilesCmpltedMilesInProgressMilesPending![
//                                                   0]
//                                               .milesCompleted
//                                               ?.toString() ??
//                                           '0.0'),
//                                       100.00 -
//                                           double.parse(value
//                                                   .rowMaintenancePlanGetData
//                                                   .data!
//                                                   .costTotalMilesMilesCmpltedMilesInProgressMilesPending![
//                                                       0]
//                                                   .milesCompleted
//                                                   ?.toString() ??
//                                               '0.0')
//                                     ],
//                                     options: const TinyBarChartOptions(
//                                       colors: [
//                                         Colors.red,
//                                         Color.fromARGB(255, 222, 220, 220),
//                                       ],
//                                     ),
//                                     width: size.width * 0.9,
//                                     height: 28,
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.only(top: 30.0),
//                                     child: TinyBarChart.stacked(
//                                       data: <double>[
//                                         double.parse(value
//                                                 .rowMaintenancePlanGetData
//                                                 .data!
//                                                 .costTotalMilesMilesCmpltedMilesInProgressMilesPending![
//                                                     0]
//                                                 .milesPending
//                                                 ?.toString() ??
//                                             '0.0'),
//                                         double.parse(value
//                                                 .rowMaintenancePlanGetData
//                                                 .data!
//                                                 .costTotalMilesMilesCmpltedMilesInProgressMilesPending![
//                                                     0]
//                                                 .milesInProgress
//                                                 ?.toString() ??
//                                             '0.0'),
//                                         double.parse(value
//                                                 .rowMaintenancePlanGetData
//                                                 .data!
//                                                 .costTotalMilesMilesCmpltedMilesInProgressMilesPending![
//                                                     0]
//                                                 .milesCompleted
//                                                 ?.toString() ??
//                                             '0.0')
//                                       ],
//                                       options: const TinyBarChartOptions(
//                                         colors: [
//                                           Color.fromARGB(255, 60, 200, 243),
//                                           Colors.orange,
//                                           Colors.red,
//                                           Color.fromARGB(255, 235, 233, 233)
//                                         ],
//                                       ),
//                                       width: size.width * 0.9,
//                                       height: 28,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Container(
//                               // margin: EdgeInsets.only(
//                               //     top: 10, bottom: 10, left: 8, right: 8),
//                               //padding: EdgeInsets.all(8),
//                               alignment: Alignment.center,
//                               height: size.height * 0.75,
//                               width: size.width * 0.95,
//                               decoration: BoxDecoration(
//                                   // shape: BoxShape.circle,
//                                   borderRadius: BorderRadius.circular(10),
//                                   boxShadow: const [
//                                     BoxShadow(
//                                         color: Color.fromARGB(255, 7, 59, 120),
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
//                                   Row(
//                                     children: [
//                                       const Padding(
//                                         padding:
//                                             EdgeInsets.only(top: 8.0, left: 8),
//                                         child: Align(
//                                           alignment: Alignment.topLeft,
//                                           child: Text(
//                                             "Total Record: ", 
//                                             textAlign: TextAlign.left,
//                                             style: TextStyle(
//                                               color: Color.fromARGB(
//                                                   255, 7, 59, 120),
//                                               fontWeight: FontWeight.bold,
//                                               fontSize: 20,
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                       Padding(
//                                         padding:
//                                             const EdgeInsets.only(top: 8.0),
//                                         child: Text(
//                                           value.rowMaintenancePlanGetData.data!
//                                               .rowMaintenancePlanList!.length
//                                               .toString(),
//                                           // result.length.toString(),
//                                           textAlign: TextAlign.left,
//                                           style: const TextStyle(
//                                             color:
//                                                 Color.fromARGB(255, 7, 59, 120),
//                                             fontWeight: FontWeight.bold,
//                                             fontSize: 20,
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   Row(
//                                     children: [
//                                       Expanded(
//                                         child: Align(
//                                           alignment: Alignment.centerRight,
//                                           child: Padding(
//                                             padding: const EdgeInsets.only(
//                                                 right: 5,
//                                                 left: 4.0,
//                                                 top: 4,
//                                                 bottom: 4),
//                                             child: TextFormField(
//                                               onChanged: (value) =>
//                                                   _filterData(value),
//                                               //  key: formkey2,
//                                               controller: _input,
//                                               style: const TextStyle(
//                                                   color: Color.fromARGB(
//                                                       255, 7, 59, 120),
//                                                   fontSize: 16),
//                                               obscureText: false,

//                                               //keyboardType: TextInputType.number,
//                                               decoration: const InputDecoration(
//                                                 border: OutlineInputBorder(),
//                                                 enabledBorder:
//                                                     OutlineInputBorder(
//                                                   borderSide: BorderSide(
//                                                     color: Color.fromARGB(
//                                                         255, 23, 1, 88),
//                                                   ),
//                                                 ),
//                                                 hintText:
//                                                     'Search your input...',
//                                               ),
//                                               validator: (value) {
//                                                 if (value!.isEmpty) {
//                                                   return "Please search your input";
//                                                 } else {
//                                                   return null;
//                                                 }
//                                               },
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),


//          Expanded(
//                           child: ListView.builder(
//                             physics: const AlwaysScrollableScrollPhysics(),
//                             itemCount: value
//                                               .rowMaintenancePlanGetData
//                                               .data!
//                                               .rowMaintenancePlanList!
//                                               .length,
//                             itemBuilder: (BuildContext ctxt, int index) {
//                               var item = rowMaintenancePlanViewModel
//                                                     .rowMaintenancePlanGetData
//                                                     .data!
//                                                     .rowMaintenancePlanList![
//                                                         index];
//                               return Padding(
//                                 padding: const EdgeInsets.symmetric(
//                                     horizontal: 8, vertical: 6),
//                                 child: InkWell(
//                                   onTap: () {
//                                     Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                         builder: (_) => PlannerRowMaintenancePlanJobDetailsScreen(
//                                           tokenNo: item.tokenNo.toString(),
//                                         ),
//                                       ),
//                                     );
//                                   },
//                                   child: Container(
//                                     decoration: BoxDecoration(
//                                       color: getCardColor(item.status),
//                                       borderRadius: BorderRadius.circular(12),
//                                       boxShadow: [
//                                         BoxShadow(
//                                           color: Colors.black.withOpacity(0.2),
//                                           blurRadius: 6,
//                                           offset: const Offset(2, 4),
//                                         ),
//                                       ],
//                                     ),
//                                     child: Padding(
//                                       padding: const EdgeInsets.all(12),
//                                       child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           /// 🔹 TOP ROW (Job No + Status Badge)
//                                           Row(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.spaceBetween,
//                                             children: [
//                                               Text(
//                                                 "JOB NO: ${item.tokenNo}",
//                                                 style: const TextStyle(
//                                                   fontSize: 14,
//                                                   fontWeight: FontWeight.bold,
//                                                   color: Colors.black,
//                                                 ),
//                                               ),

//                                               /// STATUS BADGE
//                                               Container(
//                                                 padding:
//                                                     const EdgeInsets.symmetric(
//                                                         horizontal: 10,
//                                                         vertical: 4),
//                                                 decoration: BoxDecoration(
//                                                   color: getStatusColor(
//                                                       item.status),
//                                                   borderRadius:
//                                                       BorderRadius.circular(20),
//                                                 ),
//                                                 child: Text(
//                                                   item.status ?? "",
//                                                   style: const TextStyle(
//                                                     fontSize: 11,
//                                                     fontWeight: FontWeight.bold,
//                                                     color: Colors.black,
//                                                   ),
//                                                 ),
//                                               ),
//                                             ],
//                                           ),

//                                           const SizedBox(height: 10),
//                                            (item.maintType == 'RegularMaint')? Column(
//                                                             children: [
//                                                               Row(
//                                                                 children: [
//                                                                   const Icon(
//                                                                     Icons.numbers,
//                                                                     size: 16,
//                                                                     color: Colors
//                                                                         .black,
//                                                                   ),
//                                                                   const SizedBox(
//                                                                     width: 6,
//                                                                   ),
//                                                                   Expanded(
//                                                                     child: Text(
//                                                                       "MASTER JOB NO. : ${(item.masterJobNo == null || item.masterJobNo.toString().trim().isEmpty || item.masterJobNo.toString().trim().toLowerCase() == 'null' || item.masterJobNo.toString().trim().toUpperCase() == 'N/A') ? '' : item.masterJobNo.toString()}",
//                                                                       style: const TextStyle(
//                                                                         fontSize:
//                                                                             13,
//                                                                         color: Colors
//                                                                             .black,
//                                                                       ),
//                                                                     ),
//                                                                   ),
//                                                                 ],
//                                                               ),
//                                                               const SizedBox(
//                                                             height: 4,
//                                                           ),
//                                                             ],
//                                                           ):SizedBox(),
//                                           ///  SUBSTATION ROW
//                                           Row(
//                                             children: [
//                                               const Icon(
//                                                 Icons.location_on,
//                                                 size: 16,
//                                                 color: Colors.black,
//                                               ),
//                                               const SizedBox(width: 6),
//                                               Expanded(
//                                                 child: Text(
//                                                   "SUBSTATION : ${item.substation ?? ""}",
//                                                   style: const TextStyle(
//                                                     fontSize: 13,
//                                                     color: Colors.black,
//                                                   ),
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//            const SizedBox(height: 4),
//                                            ///  FEEDER ROW
//                                           Row(
//                                             children: [
//                                               const Icon(
//                                               Icons.work,
//                                                 size: 16,
//                                                 color: Colors.black,
//                                               ),
//                                               const SizedBox(width: 6),
//                                               Expanded(
//                                                 child: Text(
//                                                   "FEEDER : ${item.fdrName ?? ""}",
//                                                   style: const TextStyle(
//                                                     fontSize: 13,
//                                                     color: Colors.black,
//                                                   ),
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
         
//           const SizedBox(height: 4),
//           ///  TYPE ROW
//                                           Row(
//                                             children: [
//                                               const Icon(
//                                               Icons.build,
//                                                 size: 16,
//                                                 color: Colors.black,
//                                               ),
//                                               const SizedBox(width: 6),
//                                               Expanded(
//                                                 child: Text(
//                                                   "TYPE : ${item.maintType ?? ""}",
//                                                   style: const TextStyle(
//                                                     fontSize: 13,
//                                                     color: Colors.black,
//                                                   ),
//                                                 ),
//                                               ),
//                                             ],
//                                           ),

//                                           const SizedBox(height: 8),

//                                           ///  DIVIDER
//                                           Container(
//                                             height: 1,
//                                             color: Colors.black12,
//                                           ),

//                                           const SizedBox(height: 8),

//                                           ///  BOTTOM ROW
//                                           const Row(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.spaceBetween,
//                                             children: [
//                                               Text(
//                                                 "View Details",
//                                                 style: TextStyle(
//                                                   fontSize: 11,
//                                                   color: Colors.black,
//                                                 ),
//                                               ),
//                                               Icon(
//                                                 Icons.arrow_forward_ios,
//                                                 size: 14,
//                                                 color: Colors.black,
//                                               ),
//                                             ],
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               );

//                             },
//                           ),
//                         ),
                   

                      
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   );

//                 default:
//                   return const Center(
//                     child: Text(
//                       "Progress Bars ",
//                       textAlign: TextAlign.left,
//                       style: TextStyle(
//                         color: Color.fromARGB(255, 7, 59, 120),
//                         fontWeight: FontWeight.bold,
//                         fontSize: 20,
//                       ),
//                     ),
//                   );
//               }
//             })));
//   }

//   Future<void> _filterData(String query) async {
//     if (query.isEmpty) {
//       rowMaintenancePlanViewModel.fetchProgressBarRowMaintDataApi(context);
//     } else {
//       rowMaintenancePlanViewModel.rowMaintenancePlanGetData.data!.rowMaintenancePlanList = rowMaintenancePlanViewModel
//           .rowMaintenancePlanGetData.data!.rowMaintenancePlanList
//           ?.where((item) =>
//               item.tokenNo.toString().toLowerCase().contains(query.toLowerCase()) ||
//               item.status
//                   .toString()
//                   .toLowerCase()
//                   .contains(query.toLowerCase()) ||
//               item.substation
//                   .toString()
//                   .toLowerCase()
//                   .contains(query.toLowerCase()) ||
//               item.maintType
//                   .toString()
//                   .toLowerCase()
//                   .contains(query.toLowerCase()) ||
//               item.contractor
//                   .toString()
//                   .toLowerCase()
//                   .contains(query.toLowerCase()) ||
//               item.cycle
//                   .toString()
//                   .toLowerCase()
//                   .contains(query.toLowerCase()) ||
//               item.streetAddress
//                   .toString()
//                   .toLowerCase()
//                   .contains(query.toLowerCase()) ||
//               item.mapLocation
//                   .toString()
//                   .toLowerCase()
//                   .contains(query.toLowerCase()) ||
//               item.adminNotes1
//                   .toString()
//                   .toLowerCase()
//                   .contains(query.toLowerCase()) ||
//               item.contractorCompay
//                   .toString()
//                   .toLowerCase()
//                   .contains(query.toLowerCase()) ||
//               item.nextMaintDue.toString().toLowerCase().contains(query.toLowerCase()) ||
//               item.dateOfInspection.toString().toLowerCase().contains(query.toLowerCase()) ||
//               item.costPerMile.toString().toLowerCase().contains(query.toLowerCase()) ||
//               item.totalCost.toString().toLowerCase().contains(query.toLowerCase()) ||
//               item.nextMaintDue.toString().toLowerCase().contains(query.toLowerCase()) ||
//               item.fdrName.toString().toLowerCase().contains(query.toLowerCase()))
//           .toList();
//     }
//     setState(() {});
//   }

//   void showDeleteDialog(
//     BuildContext context,
//     String tokenNo,
//   ) async {
//     showDialog(
//       context: context,
//       builder: (BuildContext dialogContext) {
//         return StatefulBuilder(
//           builder: (context, setStateDialog) {
//             return AlertDialog(
//               content: const Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Align(
//                       alignment: Alignment.center,
//                       child: Text(
//                         "Are you sure you want to delete this record?",
//                         style: TextStyle(
//                             fontSize: 16.0,
//                             color: Color.fromARGB(255, 7, 59, 120),
//                             fontWeight: FontWeight.bold),
//                       )),
//                 ],
//               ),
//               actions: [
//                 Align(
//                   alignment: Alignment.center,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       // NO Button
//                       _buildDialogButton(
//                         context,
//                         text: "NO",
//                         color: Colors.red,
//                         onTap: () => Navigator.pop(dialogContext),
//                       ),

//                       // YES Button (with validation)
//                       _buildDialogButton(
//                         context,
//                         text: "YES",
//                         color: Colors.green,
//                         onTap: () {
//                           deleteByTokenNoMethod(context, tokenNo);
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             );
//           },
//         );
//       },
//     );
//   }

// // Helper function for dialog buttons
//   Widget _buildDialogButton(BuildContext context,
//       {required String text,
//       required Color color,
//       required VoidCallback onTap}) {
//     return Container(
//       margin: const EdgeInsets.only(left: 6, top: 6.0, bottom: 10),
//       child: InkWell(
//         onTap: onTap,
//         child: Container(
//           margin: const EdgeInsets.only(bottom: 10.0),
//           alignment: Alignment.center,
//           width: MediaQuery.of(context).size.width * 0.25,
//           height: 40,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(10),
//             boxShadow: [
//               BoxShadow(
//                 color: color.withOpacity(0.8),
//                 blurRadius: 5,
//                 offset: const Offset(2.0, 5.0),
//               ),
//             ],
//             gradient: LinearGradient(colors: [color, color]),
//           ),
//           child: Align(
//             alignment: Alignment.center,
//             child: Text(
//               text,
//               style: const TextStyle(
//                 color: Colors.white,
//                 fontWeight: FontWeight.bold,
//                 fontSize: 20,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Future<void> deleteByTokenNoMethod(
//       BuildContext context, String tokenNo) async {
//     try {
//       String apiUrl =
//           "https://pythonapi.ariespro.com/api/lcp_civm/delete_record_civm";

//       Dio dio = Dio();
//       UserPref userPref = UserPref();
//       var userData = await userPref.getUser();

//       // Create FormData
//       FormData formData = FormData.fromMap({"token_no": tokenNo});
//       print('1111');
//       print('formdata ${formData}');
//       formData.fields.forEach((field) {
//         print('${field.key}: ${field.value}');
//       });
//       print('2222');
//       // Send POST request with FormData
//       Response response = await dio.post(
//         apiUrl,
//         data: formData,
//         options: Options(
//           headers: {
//             'Content-Type': 'multipart/form-data',
//           },
//         ),
//       );
//       print('3333');
//       if (response.statusCode == 200) {
//         Map<String, dynamic> data = response.data;
//         print('4444');
//         var status = data['message'];
//         if (status == "success") {
//           Navigator.pop(context);
//           print("Deleted Successfully new: ${response.data}");
//           rowMaintenancePlanViewModel.fetchProgressBarRowMaintDataApi(context);
//           CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
//               "Record Deleted Successfully", context);
//         } else if (status == "error") {
//           Navigator.pop(context);
//           CustomToastSnackBarProgressDialog.flushBarErrorMessage(
//               "Failed to delete the Record", context);
//           print("Failed to delete: ${response.data}");
//         }
//       } else {
//         print("Failed to Delete: ${response.statusCode}");
//       }
//     } catch (e) {
//       print("Error occurred:$e");
//     }
//   }
//   //   Future rowMaintednancePlanDashboardData() async {
// //     SharedPreferences prefs = await SharedPreferences.getInstance();
// //     var APIURL = "http://oemapi.ariespro.com/api/MenuAuthentication/data";

// //     Map mappedData = {'id': prefs.getString('EMAIL')};

// //     http.Response response =
// //         await http.post(Uri.parse(APIURL), body: mappedData);
// //     var data = jsonDecode(response.body);
// //     print(" data: $data");
// //     var status = "${data['code']}";
// //     if (status.contains("SUCCESS")) {
// //       setState(() {
// //         result = data["result"] as List;

// //         if (result.isNotEmpty) {
// //           if (listOfColumns.isNotEmpty) {
// //             listOfColumns.clear();
// //           }
// //           for (int i = 0; i < result.length; i++) {
// //             if (i == 0) {
// //               Map<String, dynamic> item = HashMap();
// //               item.addAll({'USER_NAME': 'USER NAME'});
// //               item.addAll({'USER_TYPE': 'USER TYPE'});
// //               item.addAll({'DEPARTMENT': 'DEPARTMENT'});
// //               item.addAll({'DESIGNATION': 'DESIGNATION'});
// //               item.addAll({'NAME': 'NAME'});
// //               item.addAll({'MOBILE': 'MOBILE'});
// //               item.addAll({'EMAIL': 'EMAIL'});
// //               item.addAll({'ADDRESS': 'ADDRESS'});

// //               item.addAll({'NAME': 'NAME'});
// //               item.addAll({'MOBILE': 'MOBILE'});
// //               item.addAll({'EMAIL': 'EMAIL'});
// //               item.addAll({'ADDRESS': 'ADDRESS'});
// //               listOfColumns.add(item);
// //             }
// //             Map<String, dynamic> item = HashMap();

// //             item.addAll({'USER_NAME': result[i]['USER_NAME'].toString()});
// //             item.addAll({'USER_TYPE': result[i]['USER_TYPE'].toString()});
// //             item.addAll({'DEPARTMENT': result[i]['DEPARTMENT'].toString()});
// //             item.addAll({'DESIGNATION': result[i]['DESIGNATION'].toString()});
// //             item.addAll({'NAME': result[i]['NAME'].toString()});
// //             item.addAll({'MOBILE': result[i]['MOBILE'].toString()});
// //             item.addAll({'EMAIL': result[i]['EMAIL'].toString()});
// //             item.addAll({'ADDRESS': result[i]['ADDRESS'].toString()});

// //             item.addAll({'NAME': result[i]['NAME'].toString()});
// //             item.addAll({'MOBILE': result[i]['MOBILE'].toString()});
// //             item.addAll({'EMAIL': result[i]['EMAIL'].toString()});
// //             item.addAll({'ADDRESS': result[i]['ADDRESS'].toString()});
// //             listOfColumns.add(item);
// //           }
// //           listOfColumns1 = listOfColumns;
// //         } else {
// //           showSnackBar(data['message']);
// //         }
// //       });
// //     } else if (status.contains("ERROR")) {
// //       showSnackBar(data['message']);
// //     } else {
// //       showSnackBar('Somthing went wrong!!!');
// //     }
// //   }

// //   showSnackBar(String msg) {
// //     final snackBar = SnackBar(
// //       content: Text(msg),
// //       action: SnackBarAction(
// //         label: '',
// //         onPressed: () {
// //           // Some code to undo the change.
// //         },
// //       ),
// //     );
// //     ScaffoldMessenger.of(context).showSnackBar(snackBar);
// //   }
// }

// // double roundValue(double val, int places) {
// //   num mod = pow(10.0, places);
// //   return ((val * mod).round().toDouble() / mod);
// // }

// class ChartData {
//   ChartData(this.x, this.y, this.color);
//   final String x;
//   final double y;
//   final Color color;
// }
