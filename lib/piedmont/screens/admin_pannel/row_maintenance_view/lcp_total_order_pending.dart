// import 'dart:io';
// import 'package:CIVM/piedmont/resources/app_colors.dart';
// import 'package:CIVM/piedmont/repository/map_url.dart';
// import 'package:CIVM/piedmont/screens/admin_pannel/row_maintenance_view/add_new_row_maintenance_plan.dart';
// import 'package:CIVM/piedmont/screens/admin_pannel/row_maintenance_view/daily_herbicide_application.dart';
// import 'package:CIVM/piedmont/screens/admin_pannel/row_maintenance_view/ivm_time_sheet.dart';
// import 'package:CIVM/piedmont/screens/admin_pannel/row_maintenance_view/lcp_create_order.dart';
// import 'package:CIVM/piedmont/screens/admin_pannel/row_maintenance_view/mixing_inventory.dart';
// import 'package:CIVM/piedmont/screens/admin_pannel/row_maintenance_view/pdf_view.dart';
// import 'package:CIVM/piedmont/screens/my_chrome_safari_map_recording.dart';
// import 'package:CIVM/piedmont/utils/custom_toast_snackbar_progressdialog.dart';
// import 'package:CIVM/utils/user_pref.dart';
// import 'package:CIVM/models/user_model.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// // import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// import 'package:intl/intl.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:photo_view/photo_view.dart';
// import 'package:photo_view/photo_view_gallery.dart';
// import 'package:provider/provider.dart';
// import '../../../data/response/status.dart';
// import '../../../view_model/lcp_work_order_pending_view_model.dart';
// import 'package:http/http.dart' as http;

// // ignore: must_be_immutable
// class LCPTotalOrderPending extends StatefulWidget {
//   String budgetType;
//   String maintenanceType;
//   String heading;

//   LCPTotalOrderPending({
//     Key? key,
//     required this.budgetType,
//     required this.maintenanceType,
//     required this.heading,
//   }) : super(key: key);

//   @override
//   State<LCPTotalOrderPending> createState() => _LCPTotalOrderPendingState();
// }

// class _LCPTotalOrderPendingState extends State<LCPTotalOrderPending> {
//   List<String> menu = [];

//   int workOrderNoId = 0;
//   // ignore: prefer_typing_uninitialized_variables
//   var selectedWorkOrderNo;

//   String userName = '';
//   final TextEditingController _input = TextEditingController();

//   LCPWorkOrderPendingViewModel lCPWorkOrderPendingViewModel =
//       LCPWorkOrderPendingViewModel();

//   final browser = MyChromeSafariBrowser();

//   @override
//   void initState() {
//     lCPWorkOrderPendingViewModel.fetchLCPWorkOrderPendingTabularListApi(context,
//         'PENDING', '', '', widget.budgetType, widget.maintenanceType, '', '');
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     print('heading ${widget.heading}');
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//        backgroundColor:AppColors.backgroundColor,
//         appBar: AppBar(
//           iconTheme: const IconThemeData(color: Colors.white),
//           title: Text(
//             '${widget.heading} (Pending)',
//             style: const TextStyle(color: Colors.white),
//           ),
//           backgroundColor: AppColors.baseColor,
//         ),
//         body: ChangeNotifierProvider<LCPWorkOrderPendingViewModel>(
//             create: (BuildContext context) => lCPWorkOrderPendingViewModel,
//             child: Consumer<LCPWorkOrderPendingViewModel>(
//                 builder: (context, value, _) {
//               switch (value.lcpWorkOrderPendingGetTabularData.status) {
//                 case Status.LOADING:
//                   return const Center(child: CircularProgressIndicator());
//                 case Status.ERROR:
//                   return
//                       // CustomToastSnackBarProgressDialog.flushBarErrorMessage(
//                       //     value.lcpWorkOrderPendingGetTabularData.message
//                       //         .toString(),
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
//                       selectedWorkOrderNo = null;
//                       await lCPWorkOrderPendingViewModel
//                           .fetchLCPWorkOrderPendingTabularListApi(
//                               context,
//                               'PENDING',
//                               '',
//                               '',
//                               widget.budgetType,
//                               widget.maintenanceType,
//                               '',
//                               '');
//                     },
//                     child: Container(
//                       margin: const EdgeInsets.only(
//                           left: 8, right: 8, top: 10, bottom: 8),
//                       padding: const EdgeInsets.all(8),
//                       alignment: Alignment.center,
//                       height: size.height * 0.9,
//                       width: size.width * 0.99,
//                       decoration: BoxDecoration(
//                           // shape: BoxShape.circle,
//                           borderRadius: BorderRadius.circular(10),
//                           boxShadow: const [
//                             BoxShadow(
//                                 color: AppColors.baseColor,
//                                 blurRadius: 10,
//                                 offset: Offset(2.0, 5.0))
//                           ],
//                           gradient: const LinearGradient(
//                             colors: [
//                               Color.fromARGB(255, 255, 255, 255),
//                               Color.fromARGB(255, 255, 255, 255),
//                             ],
//                           )),
//                       child: Column(
//                         children: [
//                           Align(
//                               alignment: Alignment.centerLeft,
//                               child: Padding(
//                                 padding: const EdgeInsets.only(
//                                     left: 2.0,
//                                     right: 2.0,
//                                     bottom: 2.0,
//                                     top: 4.0),
//                                 child: Text(
//                                   (widget.heading == 'Change Order')
//                                       ? "CHANGE ORDER NO"
//                                       : "JOB NO",
//                                   style: const TextStyle(
//                                       fontSize: 16,
//                                       color: AppColors.baseColor,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                               )),
//                           Align(
//                             alignment: Alignment.centerLeft,
//                             child: Padding(
//                               padding: const EdgeInsets.all(2.0),
//                               child: DropdownButtonFormField<String>(
//                                 hint: const Text('-Select-'),
//                                 dropdownColor: Colors.white,
//                                 value: selectedWorkOrderNo,
//                                 style: const TextStyle(
//                                     color: AppColors.baseColor,
//                                     fontSize: 16),
//                                 icon: const Icon(
//                                   Icons.arrow_drop_down,
//                                   color: AppColors.baseColor,
//                                   size: 40,
//                                 ),
//                                 decoration: const InputDecoration(
//                                   enabledBorder: OutlineInputBorder(
//                                     borderSide: BorderSide(
//                                       color: AppColors.baseColor,
//                                     ),
//                                   ),
//                                   focusedBorder: OutlineInputBorder(
//                                     borderSide: BorderSide(
//                                       color: AppColors.baseColor,
//                                     ),
//                                   ),
//                                 ),
//                                 isExpanded: true,
//                                 items: lCPWorkOrderPendingViewModel
//                                     .lcpWorkOrderPendingGetTabularData
//                                     .data!
//                                     .tokenNoLists!
//                                     .map((e) {
//                                   return DropdownMenuItem(
//                                     value: e.tokenNo.toString(),
//                                     // e.getIdAndSubstationByCountId![0].subStation.toString(),
//                                     child: Text(e.tokenNo.toString()),
//                                   );
//                                 }).toList(),
//                                 onChanged: (val) {
//                                   // if (selectedFeeder != null) {
//                                   //   selectedFeeder = null;
//                                   // }
//                                   fetchData(val!);
//                                   // workOrderNoId = int.parse(val);
//                                   setState(() {
//                                     selectedWorkOrderNo = val;
//                                   });
//                                 },
//                                 validator: (value) =>
//                                     value == null ? 'field required' : null,
//                               ),
//                             ),
//                           ),
//                           Row(
//                             children: [
//                               Expanded(
//                                 child: Row(
//                                   children: [
//                                     Container(
//                                       padding: const EdgeInsets.all(2),
//                                       alignment: Alignment.center,
//                                       width: size.width * 0.05,
//                                       // width: MediaQuery.of(context).size.width,
//                                       height: 30,
//                                       decoration: const BoxDecoration(
//                                           shape: BoxShape.circle,
//                                           //borderRadius: BorderRadius.circular(25),
//                                           boxShadow: [
//                                             BoxShadow(
//                                                 color: Color.fromARGB(
//                                                     255, 14, 80, 1),
//                                                 blurRadius: 5,
//                                                 offset: Offset(2.0, 5.0))
//                                           ],
//                                           color: Color.fromARGB(
//                                               255, 130, 193, 245),
//                                           gradient: LinearGradient(
//                                             colors: [
//                                               Color.fromARGB(255, 20, 108, 2),
//                                               Color.fromARGB(255, 20, 108, 2),
//                                             ],
//                                           )),
//                                     ),
//                                     const Padding(
//                                       padding: EdgeInsets.only(left: 8.0),
//                                       child: Text(
//                                         "APPROVED",
//                                         style: TextStyle(
//                                           fontSize: 16,
//                                           color:
//                                               AppColors.baseColor,
//                                           //fontWeight: FontWeight.bold
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               Expanded(
//                                 child: Row(
//                                   children: [
//                                     Container(
//                                       padding: const EdgeInsets.all(2),
//                                       alignment: Alignment.center,
//                                       width: size.width * 0.05,
//                                       // width: MediaQuery.of(context).size.width,
//                                       height: 30,
//                                       decoration: const BoxDecoration(
//                                           shape: BoxShape.circle,
//                                           //borderRadius: BorderRadius.circular(25),
//                                           boxShadow: [
//                                             BoxShadow(
//                                                 color: Color.fromARGB(
//                                                     255, 138, 84, 2),
//                                                 blurRadius: 5,
//                                                 offset: Offset(2.0, 5.0))
//                                           ],
//                                           color: Color.fromARGB(
//                                               255, 130, 193, 245),
//                                           gradient: LinearGradient(
//                                             colors: [
//                                               Colors.orange,
//                                               Colors.orange,
//                                             ],
//                                           )),
//                                     ),
//                                     const Padding(
//                                       padding: EdgeInsets.only(left: 8.0),
//                                       child: Text(
//                                         "PENDING",
//                                         style: TextStyle(
//                                           fontSize: 16,
//                                           color:
//                                               AppColors.baseColor,
//                                           //fontWeight: FontWeight.bold
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               Expanded(
//                                 child: Row(
//                                   children: [
//                                     Container(
//                                       padding: const EdgeInsets.all(2),
//                                       alignment: Alignment.center,
//                                       width: size.width * 0.05,
//                                       // width: MediaQuery.of(context).size.width,
//                                       height: 30,
//                                       decoration: const BoxDecoration(
//                                           shape: BoxShape.circle,
//                                           //borderRadius: BorderRadius.circular(25),
//                                           boxShadow: [
//                                             BoxShadow(
//                                                 color: Color.fromARGB(
//                                                     255, 128, 11, 2),
//                                                 blurRadius: 5,
//                                                 offset: Offset(2.0, 5.0))
//                                           ],
//                                           color: Color.fromARGB(
//                                               255, 130, 193, 245),
//                                           gradient: LinearGradient(
//                                             colors: [
//                                               Color.fromARGB(255, 201, 15, 2),
//                                               Color.fromARGB(255, 201, 15, 2),
//                                             ],
//                                           )),
//                                     ),
//                                     const Padding(
//                                       padding: EdgeInsets.only(left: 8.0),
//                                       child: Text(
//                                         "REJECTED",
//                                         style: TextStyle(
//                                           fontSize: 16,
//                                           color:
//                                               AppColors.baseColor,
//                                           //fontWeight: FontWeight.bold
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.only(top: 8.0),
//                             child: Align(
//                               alignment: Alignment.bottomLeft,
//                               child: Text(
//                                 "TOTAL CHANGE ORDER : ${lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData!.length.toString()}",
//                                 style: const TextStyle(
//                                     fontSize: 16,
//                                     color: AppColors.baseColor,
//                                     fontWeight: FontWeight.bold),
//                               ),
//                             ),
//                           ),
//                           Row(
//                             children: [
//                               Expanded(
//                                 child: Align(
//                                   alignment: Alignment.centerRight,
//                                   child: Padding(
//                                     padding: const EdgeInsets.only(
//                                         left: 4.0,
//                                         right: 4.0,
//                                         top: 4,
//                                         bottom: 4),
//                                     child: TextFormField(
//                                       onChanged: (value) => _filterData(value),
//                                       //  key: formkey2,
//                                       controller: _input,
//                                       style: const TextStyle(
//                                           color:
//                                               AppColors.baseColor,
//                                           fontSize: 16),
//                                       obscureText: false,

//                                       keyboardType: TextInputType.number,
//                                       decoration: const InputDecoration(
//                                         border: OutlineInputBorder(),
//                                         enabledBorder: OutlineInputBorder(
//                                           borderSide: BorderSide(
//                                             color:
//                                                 Color.fromARGB(255, 23, 1, 88),
//                                           ),
//                                           // borderRadius:
//                                           //     BorderRadius.circular(25),
//                                         ),
//                                         hintText: 'Search your input...',
//                                       ),
//                                       validator: (value) {
//                                         if (value!.toString == 'null') {
//                                           return "Please search your input";
//                                         } else {
//                                           return null;
//                                         }
//                                       },
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           Expanded(
//                             child: ListView.builder(
//                                 itemCount: lCPWorkOrderPendingViewModel
//                                     .lcpWorkOrderPendingGetTabularData
//                                     .data!
//                                     .findAllTableData!
//                                     .length,
//                                 // itemCount: historyList.length,
//                                 itemBuilder: (BuildContext ctxt, int index) {
//                                   String? dateString =
//                                       lCPWorkOrderPendingViewModel
//                                           .lcpWorkOrderPendingGetTabularData
//                                           .data!
//                                           .findAllTableData![index]
//                                           .createDate
//                                           .toString();
//                                   DateTime date = DateTime.parse(dateString);
//                                   String formattedDate =
//                                       DateFormat('MM/dd/yyyy').format(date);

//                                   return Row(
//                                     children: [
//                                       Padding(
//                                         padding: const EdgeInsets.only(
//                                             top: 4.0, bottom: 4, left: 4),
//                                         child: Container(
//                                           width: MediaQuery.of(context)
//                                                   .size
//                                                   .width *
//                                               0.9,

//                                           // margin:  EdgeInsets.only(
//                                           //     top: 5.0, bottom: 5.0, left: 2,right: 2),
//                                           padding: const EdgeInsets.all(8),
//                                           decoration: BoxDecoration(
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
//                                           child: Column(children: [
//                                             Padding(
//                                               padding: const EdgeInsets.only(
//                                                   left: 8.0),
//                                               child: Row(
//                                                 children: [
//                                                   Expanded(
//                                                     // alignment: Alignment.topLeft,
//                                                     child: Column(
//                                                       children: [
//                                                         const Align(
//                                                           alignment:
//                                                               Alignment.topLeft,
//                                                           child: Text(
//                                                             "EDIT: ",
//                                                             textAlign:
//                                                                 TextAlign.left,
//                                                             style: TextStyle(
//                                                               fontSize: 12,
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .bold,
//                                                               color:
//                                                                   Colors.white,
//                                                             ),
//                                                           ),
//                                                         ),
//                                                         InkWell(
//                                                           onTap: () {
//                                                             if (lCPWorkOrderPendingViewModel
//                                                                         .lcpWorkOrderPendingGetTabularData
//                                                                         .data!
//                                                                         .findAllTableData![
//                                                                             index]
//                                                                         .maintType ==
//                                                                     'RegularMaint' &&
//                                                                 lCPWorkOrderPendingViewModel
//                                                                         .lcpWorkOrderPendingGetTabularData
//                                                                         .data!
//                                                                         .findAllTableData![
//                                                                             index]
//                                                                         .rowYear !=
//                                                                     '' &&
//                                                                 lCPWorkOrderPendingViewModel
//                                                                         .lcpWorkOrderPendingGetTabularData
//                                                                         .data!
//                                                                         .findAllTableData![
//                                                                             index]
//                                                                         .rowYear !=
//                                                                     'N/A') {
//                                                               Navigator.push(
//                                                                   context,
//                                                                   MaterialPageRoute(
//                                                                       builder: (context) =>
//                                                                           AddNewRowMaintenancePlan(
//                                                                             tokenNo: (lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].tokenNo == null)
//                                                                                 ? ''
//                                                                                 : lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].tokenNo.toString(),
//                                                                             nextMaintYear: lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].nextMaintDue == null
//                                                                                 ? ''
//                                                                                 : lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].nextMaintDue.toString(),
//                                                                             subStation: lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].substation == null
//                                                                                 ? ''
//                                                                                 : lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].substation.toString(),
//                                                                             feeder: lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].fdrName == null
//                                                                                 ? ''
//                                                                                 : lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].fdrName.toString(),
//                                                                             maintType: lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].type == null
//                                                                                 ? ''
//                                                                                 : lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].type.toString(),
//                                                                             totalMiles: lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].totalMiles == null
//                                                                                 ? ''
//                                                                                 : lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].totalMiles.toString(),
//                                                                             totalCost: lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].totalCost == null
//                                                                                 ? ''
//                                                                                 : lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].totalCost.toString(),
//                                                                             costPerMile: lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].costPerMile == null
//                                                                                 ? ''
//                                                                                 : lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].costPerMile.toString(),
//                                                                             budgetType: lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].budgetType == null
//                                                                                 ? ''
//                                                                                 : lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].budgetType.toString(),
//                                                                             contractRowYear: lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].contractYear == null
//                                                                                 ? ''
//                                                                                 : lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].contractYear.toString(),
//                                                                             rowCycle: lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].cycle == null
//                                                                                 ? ''
//                                                                                 : lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].cycle.toString(),
//                                                                             rowYear: lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].rowYear == null
//                                                                                 ? ''
//                                                                                 : lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].rowYear.toString(),
//                                                                             contractorCompany: lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].contractorCompany == null
//                                                                                 ? ''
//                                                                                 : lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].contractorCompany.toString(),
//                                                                             assignForeman: lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].contractor == null
//                                                                                 ? ''
//                                                                                 : lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].contractor.toString(),
//                                                                             index:
//                                                                                 '0',
//                                                                           )));
//                                                             } else if (lCPWorkOrderPendingViewModel
//                                                                         .lcpWorkOrderPendingGetTabularData
//                                                                         .data!
//                                                                         .findAllTableData![
//                                                                             index]
//                                                                         .maintType ==
//                                                                     'RegularMaint' &&
//                                                                 lCPWorkOrderPendingViewModel
//                                                                         .lcpWorkOrderPendingGetTabularData
//                                                                         .data!
//                                                                         .findAllTableData![
//                                                                             index]
//                                                                         .rowYear ==
//                                                                     '' &&
//                                                                 lCPWorkOrderPendingViewModel
//                                                                         .lcpWorkOrderPendingGetTabularData
//                                                                         .data!
//                                                                         .findAllTableData![
//                                                                             index]
//                                                                         .rowYear !=
//                                                                     'N/A') {
//                                                               Navigator.push(
//                                                                   context,
//                                                                   MaterialPageRoute(
//                                                                       builder: (context) =>
//                                                                           AddNewRowMaintenancePlan(
//                                                                             tokenNo: (lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].tokenNo == null)
//                                                                                 ? ''
//                                                                                 : lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].tokenNo.toString(),
//                                                                             nextMaintYear: lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].nextMaintDue == null
//                                                                                 ? ''
//                                                                                 : lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].nextMaintDue.toString(),
//                                                                             subStation: lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].substation == null
//                                                                                 ? ''
//                                                                                 : lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].substation.toString(),
//                                                                             feeder: lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].fdrName == null
//                                                                                 ? ''
//                                                                                 : lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].fdrName.toString(),
//                                                                             maintType: lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].type == null
//                                                                                 ? ''
//                                                                                 : lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].type.toString(),
//                                                                             totalMiles: lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].totalMiles == null
//                                                                                 ? ''
//                                                                                 : lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].totalMiles.toString(),
//                                                                             totalCost: lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].totalCost == null
//                                                                                 ? ''
//                                                                                 : lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].totalCost.toString(),
//                                                                             costPerMile: lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].costPerMile == null
//                                                                                 ? ''
//                                                                                 : lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].costPerMile.toString(),
//                                                                             budgetType: lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].budgetType == null
//                                                                                 ? ''
//                                                                                 : lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].budgetType.toString(),
//                                                                             contractRowYear: lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].contractYear == null
//                                                                                 ? ''
//                                                                                 : lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].contractYear.toString(),
//                                                                             rowCycle: lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].cycle == null
//                                                                                 ? ''
//                                                                                 : lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].cycle.toString(),
//                                                                             rowYear: lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].rowYear == null
//                                                                                 ? ''
//                                                                                 : lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].rowYear.toString(),
//                                                                             contractorCompany: lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].contractorCompany == null
//                                                                                 ? ''
//                                                                                 : lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].contractorCompany.toString(),
//                                                                             assignForeman: lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].contractor == null
//                                                                                 ? ''
//                                                                                 : lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].contractor.toString(),
//                                                                             index:
//                                                                                 '1',
//                                                                           )));
//                                                             } else {
//                                                               Navigator.of(context).push(
//                                                                   MaterialPageRoute(
//                                                                       builder: (BuildContext
//                                                                               context) =>
//                                                                           LCPCreateOrder(
//                                                                             tokenNo: (lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].tokenNo == null)
//                                                                                 ? ''
//                                                                                 : lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].tokenNo.toString(),
//                                                                             subStation: (lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].substation == null)
//                                                                                 ? ''
//                                                                                 : lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].substation.toString(),
//                                                                             feeder: (lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].fdrName == null)
//                                                                                 ? ''
//                                                                                 : lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].fdrName.toString(),
//                                                                             serviceStreetAddress: (lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].streetAddress == null || lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].streetAddress == 'N/A')
//                                                                                 ? ''
//                                                                                 : lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].streetAddress.toString(),
//                                                                             serviceMapLocation: (lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].mapLocation == null || lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].mapLocation == 'N/A')
//                                                                                 ? ''
//                                                                                 : lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].mapLocation.toString(),
//                                                                             notes: (lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].adminNotes1 == null)
//                                                                                 ? ''
//                                                                                 : lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].adminNotes1.toString(),
//                                                                             type: (lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].type == null)
//                                                                                 ? ''
//                                                                                 : lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].type.toString(),
//                                                                             maintType: (lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].maintType == null)
//                                                                                 ? ''
//                                                                                 : lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].maintType.toString(),
//                                                                             contractorCompany: (lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].contractorCompany == null)
//                                                                                 ? ''
//                                                                                 : lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].contractorCompany.toString(),
//                                                                             assignForeman: lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].contractor == null
//                                                                                 ? ''
//                                                                                 : lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].contractor.toString(),
//                                                                             estimatedCost: (lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].estCost == null)
//                                                                                 ? ''
//                                                                                 : lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].estCost.toString(),
//                                                                             estimatedTime: (lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].estTime == null)
//                                                                                 ? ''
//                                                                                 : lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].estTime.toString(),
//                                                                             actualCost: (lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].actualCost == null)
//                                                                                 ? ''
//                                                                                 : lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].actualCost.toString(),
//                                                                           )));
//                                                             }
//                                                           },
//                                                           child: const Align(
//                                                             alignment: Alignment
//                                                                 .topLeft,
//                                                             child: Icon(
//                                                               Icons.edit,
//                                                               color: Color
//                                                                   .fromARGB(
//                                                                       255,
//                                                                       151,
//                                                                       249,
//                                                                       154),
//                                                             ),
//                                                           ),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                   Expanded(
//                                                     // alignment: Alignment.topLeft,
//                                                     child: Column(
//                                                       children: [
//                                                         const Align(
//                                                           alignment:
//                                                               Alignment.topLeft,
//                                                           child: Text(
//                                                             "IMAGE: ",
//                                                             textAlign:
//                                                                 TextAlign.left,
//                                                             style: TextStyle(
//                                                               fontSize: 12,
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .bold,
//                                                               color:
//                                                                   Colors.white,
//                                                             ),
//                                                           ),
//                                                         ),
//                                                         InkWell(
//                                                           onTap: () async {
//                                                             await lCPWorkOrderPendingViewModel
//                                                                 .fetchImageApi(
//                                                               context,
//                                                               lCPWorkOrderPendingViewModel
//                                                                   .lcpWorkOrderPendingGetTabularData
//                                                                   .data!
//                                                                   .findAllTableData![
//                                                                       index]
//                                                                   .id
//                                                                   .toString(),
//                                                             );
//                                                             await Future.delayed(
//                                                                 const Duration(
//                                                                     seconds:
//                                                                         2));
//                                                             openDialogPicture(
//                                                                 lCPWorkOrderPendingViewModel
//                                                                     .lcpWorkOrderPendingGetTabularData
//                                                                     .data!
//                                                                     .findAllTableData![
//                                                                         index]
//                                                                     .id
//                                                                     .toString());
//                                                           },
//                                                           child: const Align(
//                                                               alignment:
//                                                                   Alignment
//                                                                       .topLeft,
//                                                               child: Icon(
//                                                                 Icons.image,
//                                                                 color:
//                                                                     Colors.blue,
//                                                               )),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                   Expanded(
//                                                     // alignment: Alignment.topLeft,
//                                                     child: Column(
//                                                       children: [
//                                                         const Align(
//                                                           alignment:
//                                                               Alignment.topLeft,
//                                                           child: Text(
//                                                             "TYPE: ",
//                                                             textAlign:
//                                                                 TextAlign.left,
//                                                             style: TextStyle(
//                                                               fontSize: 12,
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .bold,
//                                                               color:
//                                                                   Colors.white,
//                                                             ),
//                                                           ),
//                                                         ),
//                                                         Align(
//                                                           alignment:
//                                                               Alignment.topLeft,
//                                                           child: Text(
//                                                             (lCPWorkOrderPendingViewModel
//                                                                             .lcpWorkOrderPendingGetTabularData
//                                                                             .data!
//                                                                             .findAllTableData![
//                                                                                 index]
//                                                                             .maintType ==
//                                                                         null ||
//                                                                     lCPWorkOrderPendingViewModel
//                                                                             .lcpWorkOrderPendingGetTabularData
//                                                                             .data!
//                                                                             .findAllTableData![
//                                                                                 index]
//                                                                             .maintType
//                                                                             .toString() ==
//                                                                         'null')
//                                                                 ? ''
//                                                                 : lCPWorkOrderPendingViewModel
//                                                                     .lcpWorkOrderPendingGetTabularData
//                                                                     .data!
//                                                                     .findAllTableData![
//                                                                         index]
//                                                                     .maintType
//                                                                     .toString(),
//                                                             textAlign:
//                                                                 TextAlign.left,
//                                                             style:
//                                                                 const TextStyle(
//                                                               fontSize: 12,
//                                                               //  fontWeight:
//                                                               //      FontWeight.bold,
//                                                               color:
//                                                                   Colors.white,
//                                                             ),
//                                                           ),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                             const Divider(
//                                               color: Colors.grey,
//                                             ),
//                                             Padding(
//                                               padding: const EdgeInsets.only(
//                                                   left: 8.0),
//                                               child: Row(
//                                                 children: [
//                                                   Expanded(
//                                                     // alignment: Alignment.topLeft,
//                                                     child: Column(
//                                                       children: [
//                                                         const Align(
//                                                           alignment:
//                                                               Alignment.topLeft,
//                                                           child: Text(
//                                                             "JOB NO: ",
//                                                             textAlign:
//                                                                 TextAlign.left,
//                                                             style: TextStyle(
//                                                               fontSize: 12,
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .bold,
//                                                               color:
//                                                                   Colors.white,
//                                                             ),
//                                                           ),
//                                                         ),
//                                                         Align(
//                                                           alignment:
//                                                               Alignment.topLeft,
//                                                           child: Text(
//                                                             (lCPWorkOrderPendingViewModel
//                                                                             .lcpWorkOrderPendingGetTabularData
//                                                                             .data!
//                                                                             .findAllTableData![
//                                                                                 index]
//                                                                             .tokenNo ==
//                                                                         null ||
//                                                                     lCPWorkOrderPendingViewModel
//                                                                             .lcpWorkOrderPendingGetTabularData
//                                                                             .data!
//                                                                             .findAllTableData![
//                                                                                 index]
//                                                                             .tokenNo
//                                                                             .toString() ==
//                                                                         'null')
//                                                                 ? ''
//                                                                 : lCPWorkOrderPendingViewModel
//                                                                     .lcpWorkOrderPendingGetTabularData
//                                                                     .data!
//                                                                     .findAllTableData![
//                                                                         index]
//                                                                     .tokenNo
//                                                                     .toString(),
//                                                             textAlign:
//                                                                 TextAlign.left,
//                                                             style:
//                                                                 const TextStyle(
//                                                               fontSize: 12,
//                                                               color:
//                                                                   Colors.white,
//                                                             ),
//                                                           ),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                   Expanded(
//                                                     // alignment: Alignment.topLeft,
//                                                     child: Column(
//                                                       children: [
//                                                         const Align(
//                                                           alignment:
//                                                               Alignment.topLeft,
//                                                           child: Text(
//                                                             "STATUS: ",
//                                                             textAlign:
//                                                                 TextAlign.left,
//                                                             style: TextStyle(
//                                                               fontSize: 12,
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .bold,
//                                                               color:
//                                                                   Colors.white,
//                                                             ),
//                                                           ),
//                                                         ),
//                                                         Align(
//                                                           alignment:
//                                                               Alignment.topLeft,
//                                                           child: Text(
//                                                             (lCPWorkOrderPendingViewModel
//                                                                             .lcpWorkOrderPendingGetTabularData
//                                                                             .data!
//                                                                             .findAllTableData![
//                                                                                 index]
//                                                                             .status ==
//                                                                         null ||
//                                                                     lCPWorkOrderPendingViewModel
//                                                                             .lcpWorkOrderPendingGetTabularData
//                                                                             .data!
//                                                                             .findAllTableData![
//                                                                                 index]
//                                                                             .status
//                                                                             .toString() ==
//                                                                         'null')
//                                                                 ? ''
//                                                                 : lCPWorkOrderPendingViewModel
//                                                                     .lcpWorkOrderPendingGetTabularData
//                                                                     .data!
//                                                                     .findAllTableData![
//                                                                         index]
//                                                                     .status
//                                                                     .toString(),
//                                                             textAlign:
//                                                                 TextAlign.left,
//                                                             style:
//                                                                 const TextStyle(
//                                                               fontSize: 12,
//                                                               color:
//                                                                   Colors.white,
//                                                             ),
//                                                           ),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                   Expanded(
//                                                     // alignment: Alignment.topLeft,
//                                                     child: Column(
//                                                       children: [
//                                                         const Align(
//                                                           alignment:
//                                                               Alignment.topLeft,
//                                                           child: Text(
//                                                             "DAILY HERBICIDE APPLICATION: ",
//                                                             textAlign:
//                                                                 TextAlign.left,
//                                                             style: TextStyle(
//                                                               fontSize: 12,
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .bold,
//                                                               color:
//                                                                   Colors.white,
//                                                             ),
//                                                           ),
//                                                         ),
//                                                         (lCPWorkOrderPendingViewModel
//                                                                     .lcpWorkOrderPendingGetTabularData
//                                                                     .data!
//                                                                     .findAllTableData![
//                                                                         index]
//                                                                     .dailyHerbicide
//                                                                     .toString() ==
//                                                                 'APPROVED')
//                                                             ? Align(
//                                                                 alignment:
//                                                                     Alignment
//                                                                         .topLeft,
//                                                                 child: InkWell(
//                                                                   onTap: () {
//                                                                     Navigator.of(
//                                                                             context)
//                                                                         .push(MaterialPageRoute(
//                                                                             builder: (BuildContext context) =>
//                                                                                 DailyHerbicideApplication(id: lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].id.toString())));
//                                                                   },
//                                                                   child:
//                                                                       Container(
//                                                                     padding:
//                                                                         const EdgeInsets
//                                                                             .all(
//                                                                             2),
//                                                                     alignment:
//                                                                         Alignment
//                                                                             .center,
//                                                                     width:
//                                                                         size.width *
//                                                                             0.1,
//                                                                     height: 30,
//                                                                     decoration: BoxDecoration(
//                                                                         // shape: BoxShape.circle,
//                                                                         borderRadius: BorderRadius.circular(10),
//                                                                         color: const Color.fromARGB(255, 130, 193, 245),
//                                                                         gradient: const LinearGradient(
//                                                                           colors: [
//                                                                             Colors.green,
//                                                                             Colors.green,
//                                                                           ],
//                                                                         )),
//                                                                     child: const Align(
//                                                                         alignment: Alignment.center,
//                                                                         child: Icon(
//                                                                           Icons
//                                                                               .remove_red_eye,
//                                                                           color:
//                                                                               Colors.white,
//                                                                         )),
//                                                                   ),
//                                                                 ),
//                                                               )
//                                                             : (lCPWorkOrderPendingViewModel
//                                                                         .lcpWorkOrderPendingGetTabularData
//                                                                         .data!
//                                                                         .findAllTableData![
//                                                                             index]
//                                                                         .dailyHerbicide
//                                                                         .toString() ==
//                                                                     'PENDING')
//                                                                 ? Align(
//                                                                     alignment:
//                                                                         Alignment
//                                                                             .topLeft,
//                                                                     child:
//                                                                         InkWell(
//                                                                       onTap:
//                                                                           () {
//                                                                         Navigator.of(context).push(MaterialPageRoute(
//                                                                             builder: (BuildContext context) =>
//                                                                                 DailyHerbicideApplication(id: lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].id.toString())));
//                                                                       },
//                                                                       child:
//                                                                           Container(
//                                                                         padding: const EdgeInsets
//                                                                             .all(
//                                                                             2),
//                                                                         alignment:
//                                                                             Alignment.center,
//                                                                         width: size.width *
//                                                                             0.1,
//                                                                         height:
//                                                                             30,
//                                                                         decoration: BoxDecoration(
//                                                                             // shape: BoxShape.circle,
//                                                                             borderRadius: BorderRadius.circular(10),
//                                                                             color: const Color.fromARGB(255, 130, 193, 245),
//                                                                             gradient: const LinearGradient(
//                                                                               colors: [
//                                                                                 Colors.orange,
//                                                                                 Colors.orange,
//                                                                               ],
//                                                                             )),
//                                                                         child: const Align(
//                                                                             alignment: Alignment.center,
//                                                                             child: Icon(
//                                                                               Icons.remove_red_eye,
//                                                                               color: Colors.white,
//                                                                             )),
//                                                                       ),
//                                                                     ),
//                                                                   )
//                                                                 : (lCPWorkOrderPendingViewModel
//                                                                             .lcpWorkOrderPendingGetTabularData
//                                                                             .data!
//                                                                             .findAllTableData![index]
//                                                                             .dailyHerbicide
//                                                                             .toString() ==
//                                                                         'REJECTED')
//                                                                     ? Align(
//                                                                         alignment:
//                                                                             Alignment.topLeft,
//                                                                         child:
//                                                                             InkWell(
//                                                                           onTap:
//                                                                               () {
//                                                                             Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => DailyHerbicideApplication(id: lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].id.toString())));
//                                                                           },
//                                                                           child:
//                                                                               Container(
//                                                                             padding:
//                                                                                 const EdgeInsets.all(2),
//                                                                             alignment:
//                                                                                 Alignment.center,
//                                                                             width:
//                                                                                 size.width * 0.1,
//                                                                             height:
//                                                                                 30,
//                                                                             decoration: BoxDecoration(
//                                                                                 // shape: BoxShape.circle,
//                                                                                 borderRadius: BorderRadius.circular(10),
//                                                                                 color: const Color.fromARGB(255, 130, 193, 245),
//                                                                                 gradient: const LinearGradient(
//                                                                                   colors: [
//                                                                                     Colors.red,
//                                                                                     Colors.red,
//                                                                                   ],
//                                                                                 )),
//                                                                             child: const Align(
//                                                                                 alignment: Alignment.center,
//                                                                                 child: Icon(
//                                                                                   Icons.remove_red_eye,
//                                                                                   color: Colors.white,
//                                                                                 )),
//                                                                           ),
//                                                                         ),
//                                                                       )
//                                                                     : const Text(
//                                                                         "",
//                                                                         textAlign:
//                                                                             TextAlign.left,
//                                                                         style:
//                                                                             TextStyle(
//                                                                           fontSize:
//                                                                               12,
//                                                                           //  fontWeight:
//                                                                           //      FontWeight.bold,
//                                                                           color:
//                                                                               Colors.white,
//                                                                         ),
//                                                                       )
//                                                       ],
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                             const Divider(
//                                               color: Colors.grey,
//                                             ),
//                                             Padding(
//                                               padding: const EdgeInsets.only(
//                                                   left: 8.0),
//                                               child: Row(
//                                                 children: [
//                                                   // Expanded(
//                                                   //   // alignment: Alignment.topLeft,
//                                                   //   child: Column(
//                                                   //     children: [
//                                                   //       const Align(
//                                                   //         alignment:
//                                                   //             Alignment.topLeft,
//                                                   //         child: Text(
//                                                   //           "IVM TIMESHEET: ",
//                                                   //           textAlign:
//                                                   //               TextAlign.left,
//                                                   //           style: TextStyle(
//                                                   //             fontSize: 12,
//                                                   //             fontWeight:
//                                                   //                 FontWeight.bold,
//                                                   //             color: Colors.white,
//                                                   //           ),
//                                                   //         ),
//                                                   //       ),
//                                                   //       (lCPWorkOrderPendingViewModel
//                                                   //                   .lcpWorkOrderPendingGetTabularData
//                                                   //                   .data!
//                                                   //                   .findAllTableData![
//                                                   //                       index]
//                                                   //                   .ivmTimeDateShit
//                                                   //                   .toString() ==
//                                                   //               'true')
//                                                   //           ? Align(
//                                                   //               alignment:
//                                                   //                   Alignment
//                                                   //                       .topLeft,
//                                                   //               child: InkWell(
//                                                   //                 onTap: () {
//                                                   //                   Navigator.of(context).push(MaterialPageRoute(
//                                                   //                       builder: (BuildContext context) => IVMTimeSheet(
//                                                   //                           id: lCPWorkOrderPendingViewModel
//                                                   //                               .lcpWorkOrderPendingGetTabularData
//                                                   //                               .data!
//                                                   //                               .findAllTableData![index]
//                                                   //                               .id
//                                                   //                               .toString())));
//                                                   //                 },
//                                                   //                 child:
//                                                   //                     Container(
//                                                   //                   padding:
//                                                   //                       const EdgeInsets
//                                                   //                           .all(
//                                                   //                           2),
//                                                   //                   alignment:
//                                                   //                       Alignment
//                                                   //                           .center,
//                                                   //                   width:
//                                                   //                       size.width *
//                                                   //                           0.1,
//                                                   //                   height: 30,
//                                                   //                   decoration:
//                                                   //                       BoxDecoration(
//                                                   //                           // shape: BoxShape.circle,
//                                                   //                           borderRadius: BorderRadius.circular(
//                                                   //                               10),
//                                                   //                           color: const Color
//                                                   //                               .fromARGB(
//                                                   //                               255,
//                                                   //                               130,
//                                                   //                               193,
//                                                   //                               245),
//                                                   //                           gradient:
//                                                   //                               const LinearGradient(
//                                                   //                             colors: [
//                                                   //                               Colors.orange,
//                                                   //                               Colors.orange,
//                                                   //                             ],
//                                                   //                           )),
//                                                   //                   child: const Align(
//                                                   //                       alignment: Alignment.center,
//                                                   //                       child: Icon(
//                                                   //                         Icons
//                                                   //                             .remove_red_eye,
//                                                   //                         color: Colors
//                                                   //                             .white,
//                                                   //                       )),
//                                                   //                 ),
//                                                   //               ),
//                                                   //             )
//                                                   //           : const Text(
//                                                   //               "",
//                                                   //               textAlign:
//                                                   //                   TextAlign
//                                                   //                       .left,
//                                                   //               style: TextStyle(
//                                                   //                 fontSize: 12,
//                                                   //                 //  fontWeight:
//                                                   //                 //      FontWeight.bold,
//                                                   //                 color: Colors
//                                                   //                     .white,
//                                                   //               ),
//                                                   //             )
//                                                   //     ],
//                                                   //   ),
//                                                   // ),

//                                                   Expanded(
//                                                     // alignment: Alignment.topLeft,
//                                                     child: Column(
//                                                       children: [
//                                                         const Align(
//                                                           alignment:
//                                                               Alignment.topLeft,
//                                                           child: Text(
//                                                             "IVM TIMESHEET: ",
//                                                             textAlign:
//                                                                 TextAlign.left,
//                                                             style: TextStyle(
//                                                               fontSize: 12,
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .bold,
//                                                               color:
//                                                                   Colors.white,
//                                                             ),
//                                                           ),
//                                                         ),
//                                                         (lCPWorkOrderPendingViewModel
//                                                                     .lcpWorkOrderPendingGetTabularData
//                                                                     .data!
//                                                                     .findAllTableData![
//                                                                         index]
//                                                                     .ivmTimesheet
//                                                                     .toString() ==
//                                                                 'APPROVED')
//                                                             ? Align(
//                                                                 alignment:
//                                                                     Alignment
//                                                                         .topLeft,
//                                                                 child: InkWell(
//                                                                   onTap: () {
//                                                                     Navigator.of(
//                                                                             context)
//                                                                         .push(MaterialPageRoute(
//                                                                             builder: (BuildContext context) =>
//                                                                                 IVMTimeSheet(id: lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].id.toString())));
//                                                                   },
//                                                                   child:
//                                                                       Container(
//                                                                     padding:
//                                                                         const EdgeInsets
//                                                                             .all(
//                                                                             2),
//                                                                     alignment:
//                                                                         Alignment
//                                                                             .center,
//                                                                     width:
//                                                                         size.width *
//                                                                             0.1,
//                                                                     height: 30,
//                                                                     decoration: BoxDecoration(
//                                                                         // shape: BoxShape.circle,
//                                                                         borderRadius: BorderRadius.circular(10),
//                                                                         color: const Color.fromARGB(255, 130, 193, 245),
//                                                                         gradient: const LinearGradient(
//                                                                           colors: [
//                                                                             Colors.green,
//                                                                             Colors.green,
//                                                                           ],
//                                                                         )),
//                                                                     child: const Align(
//                                                                         alignment: Alignment.center,
//                                                                         child: Icon(
//                                                                           Icons
//                                                                               .remove_red_eye,
//                                                                           color:
//                                                                               Colors.white,
//                                                                         )),
//                                                                   ),
//                                                                 ),
//                                                               )
//                                                             : (lCPWorkOrderPendingViewModel
//                                                                         .lcpWorkOrderPendingGetTabularData
//                                                                         .data!
//                                                                         .findAllTableData![
//                                                                             index]
//                                                                         .ivmTimesheet
//                                                                         .toString() ==
//                                                                     'PENDING')
//                                                                 ? Align(
//                                                                     alignment:
//                                                                         Alignment
//                                                                             .topLeft,
//                                                                     child:
//                                                                         InkWell(
//                                                                       onTap:
//                                                                           () {
//                                                                         Navigator.of(context).push(MaterialPageRoute(
//                                                                             builder: (BuildContext context) =>
//                                                                                 IVMTimeSheet(id: lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].id.toString())));
//                                                                       },
//                                                                       child:
//                                                                           Container(
//                                                                         padding: const EdgeInsets
//                                                                             .all(
//                                                                             2),
//                                                                         alignment:
//                                                                             Alignment.center,
//                                                                         width: size.width *
//                                                                             0.1,
//                                                                         height:
//                                                                             30,
//                                                                         decoration: BoxDecoration(
//                                                                             // shape: BoxShape.circle,
//                                                                             borderRadius: BorderRadius.circular(10),
//                                                                             color: const Color.fromARGB(255, 130, 193, 245),
//                                                                             gradient: const LinearGradient(
//                                                                               colors: [
//                                                                                 Colors.orange,
//                                                                                 Colors.orange,
//                                                                               ],
//                                                                             )),
//                                                                         child: const Align(
//                                                                             alignment: Alignment.center,
//                                                                             child: Icon(
//                                                                               Icons.remove_red_eye,
//                                                                               color: Colors.white,
//                                                                             )),
//                                                                       ),
//                                                                     ),
//                                                                   )
//                                                                 : (lCPWorkOrderPendingViewModel
//                                                                             .lcpWorkOrderPendingGetTabularData
//                                                                             .data!
//                                                                             .findAllTableData![
//                                                                                 index]
//                                                                             .ivmTimesheet
//                                                                             .toString() ==
//                                                                         'REJECTED')
//                                                                     ? Align(
//                                                                         alignment:
//                                                                             Alignment.topLeft,
//                                                                         child:
//                                                                             InkWell(
//                                                                           onTap:
//                                                                               () {
//                                                                             Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => IVMTimeSheet(id: lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].id.toString())));
//                                                                           },
//                                                                           child:
//                                                                               Container(
//                                                                             padding:
//                                                                                 const EdgeInsets.all(2),
//                                                                             alignment:
//                                                                                 Alignment.center,
//                                                                             width:
//                                                                                 size.width * 0.1,
//                                                                             height:
//                                                                                 30,
//                                                                             decoration: BoxDecoration(
//                                                                                 // shape: BoxShape.circle,
//                                                                                 borderRadius: BorderRadius.circular(10),
//                                                                                 color: const Color.fromARGB(255, 130, 193, 245),
//                                                                                 gradient: const LinearGradient(
//                                                                                   colors: [
//                                                                                     Colors.red,
//                                                                                     Colors.red,
//                                                                                   ],
//                                                                                 )),
//                                                                             child: const Align(
//                                                                                 alignment: Alignment.center,
//                                                                                 child: Icon(
//                                                                                   Icons.remove_red_eye,
//                                                                                   color: Colors.white,
//                                                                                 )),
//                                                                           ),
//                                                                         ),
//                                                                       )
//                                                                     : (lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].maintType ==
//                                                                             'RegularMaint')
//                                                                         ? const Text(
//                                                                             "",
//                                                                             textAlign:
//                                                                                 TextAlign.left,
//                                                                             style:
//                                                                                 TextStyle(
//                                                                               fontSize: 0,
//                                                                               fontWeight: FontWeight.bold,
//                                                                               color: AppColors.baseColor,
//                                                                             ),
//                                                                           )
//                                                                         : const Text(
//                                                                             "",
//                                                                             textAlign:
//                                                                                 TextAlign.left,
//                                                                             style:
//                                                                                 TextStyle(
//                                                                               fontSize: 12,
//                                                                               //  fontWeight:
//                                                                               //      FontWeight.bold,
//                                                                               color: Colors.white,
//                                                                             ),
//                                                                           )
//                                                       ],
//                                                     ),
//                                                   ),
//                                                   // Expanded(
//                                                   //   // alignment: Alignment.topLeft,
//                                                   //   child: Column(
//                                                   //     children: [
//                                                   //       const Align(
//                                                   //         alignment:
//                                                   //             Alignment.topLeft,
//                                                   //         child: Text(
//                                                   //           "MIXING INVENTORY: ",
//                                                   //           textAlign:
//                                                   //               TextAlign.left,
//                                                   //           style: TextStyle(
//                                                   //             fontSize: 12,
//                                                   //             fontWeight:
//                                                   //                 FontWeight.bold,
//                                                   //             color: Colors.white,
//                                                   //           ),
//                                                   //         ),
//                                                   //       ),
//                                                   //       (lCPWorkOrderPendingViewModel
//                                                   //                   .lcpWorkOrderPendingGetTabularData
//                                                   //                   .data!
//                                                   //                   .findAllTableData![
//                                                   //                       index]
//                                                   //                   .mixingInventorVisible
//                                                   //                   .toString() ==
//                                                   //               'true')
//                                                   //           ? Align(
//                                                   //               alignment:
//                                                   //                   Alignment
//                                                   //                       .topLeft,
//                                                   //               child: InkWell(
//                                                   //                 onTap: () {
//                                                   //                   Navigator.of(context).push(MaterialPageRoute(
//                                                   //                       builder: (BuildContext context) => MixingInventory(
//                                                   //                           id: lCPWorkOrderPendingViewModel
//                                                   //                               .lcpWorkOrderPendingGetTabularData
//                                                   //                               .data!
//                                                   //                               .findAllTableData![index]
//                                                   //                               .id
//                                                   //                               .toString())));
//                                                   //                 },
//                                                   //                 child:
//                                                   //                     Container(
//                                                   //                   padding:
//                                                   //                       const EdgeInsets
//                                                   //                           .all(
//                                                   //                           2),
//                                                   //                   alignment:
//                                                   //                       Alignment
//                                                   //                           .center,
//                                                   //                   width:
//                                                   //                       size.width *
//                                                   //                           0.1,
//                                                   //                   height: 30,
//                                                   //                   decoration:
//                                                   //                       BoxDecoration(
//                                                   //                           // shape: BoxShape.circle,
//                                                   //                           borderRadius: BorderRadius.circular(
//                                                   //                               10),
//                                                   //                           color: const Color
//                                                   //                               .fromARGB(
//                                                   //                               255,
//                                                   //                               130,
//                                                   //                               193,
//                                                   //                               245),
//                                                   //                           gradient:
//                                                   //                               const LinearGradient(
//                                                   //                             colors: [
//                                                   //                               Colors.orange,
//                                                   //                               Colors.orange,
//                                                   //                             ],
//                                                   //                           )),
//                                                   //                   child: const Align(
//                                                   //                       alignment: Alignment.center,
//                                                   //                       child: Icon(
//                                                   //                         Icons
//                                                   //                             .remove_red_eye,
//                                                   //                         color: Colors
//                                                   //                             .white,
//                                                   //                       )),
//                                                   //                 ),
//                                                   //               ),
//                                                   //             )
//                                                   //           : const Text(
//                                                   //               "",
//                                                   //               textAlign:
//                                                   //                   TextAlign
//                                                   //                       .left,
//                                                   //               style: TextStyle(
//                                                   //                 fontSize: 12,
//                                                   //                 //  fontWeight:
//                                                   //                 //      FontWeight.bold,
//                                                   //                 color: Colors
//                                                   //                     .white,
//                                                   //               ),
//                                                   //             )
//                                                   //     ],
//                                                   //   ),
//                                                   // ),

//                                                   Expanded(
//                                                     // alignment: Alignment.topLeft,
//                                                     child: Column(
//                                                       children: [
//                                                         const Align(
//                                                           alignment:
//                                                               Alignment.topLeft,
//                                                           child: Text(
//                                                             "MIXING INVENTORY: ",
//                                                             textAlign:
//                                                                 TextAlign.left,
//                                                             style: TextStyle(
//                                                               fontSize: 12,
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .bold,
//                                                               color:
//                                                                   Colors.white,
//                                                             ),
//                                                           ),
//                                                         ),
//                                                         (lCPWorkOrderPendingViewModel
//                                                                     .lcpWorkOrderPendingGetTabularData
//                                                                     .data!
//                                                                     .findAllTableData![
//                                                                         index]
//                                                                     .mixingInventory
//                                                                     .toString() ==
//                                                                 'APPROVED')
//                                                             ? Align(
//                                                                 alignment:
//                                                                     Alignment
//                                                                         .topLeft,
//                                                                 child: InkWell(
//                                                                   onTap: () {
//                                                                     Navigator.of(
//                                                                             context)
//                                                                         .push(MaterialPageRoute(
//                                                                             builder: (BuildContext context) =>
//                                                                                 MixingInventory(id: lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].id.toString())));
//                                                                   },
//                                                                   child:
//                                                                       Container(
//                                                                     padding:
//                                                                         const EdgeInsets
//                                                                             .all(
//                                                                             2),
//                                                                     alignment:
//                                                                         Alignment
//                                                                             .center,
//                                                                     width:
//                                                                         size.width *
//                                                                             0.1,
//                                                                     height: 30,
//                                                                     decoration: BoxDecoration(
//                                                                         // shape: BoxShape.circle,
//                                                                         borderRadius: BorderRadius.circular(10),
//                                                                         color: const Color.fromARGB(255, 130, 193, 245),
//                                                                         gradient: const LinearGradient(
//                                                                           colors: [
//                                                                             Colors.green,
//                                                                             Colors.green,
//                                                                           ],
//                                                                         )),
//                                                                     child: const Align(
//                                                                         alignment: Alignment.center,
//                                                                         child: Icon(
//                                                                           Icons
//                                                                               .remove_red_eye,
//                                                                           color:
//                                                                               Colors.white,
//                                                                         )),
//                                                                   ),
//                                                                 ),
//                                                               )
//                                                             : (lCPWorkOrderPendingViewModel
//                                                                         .lcpWorkOrderPendingGetTabularData
//                                                                         .data!
//                                                                         .findAllTableData![
//                                                                             index]
//                                                                         .mixingInventory
//                                                                         .toString() ==
//                                                                     'PENDING')
//                                                                 ? Align(
//                                                                     alignment:
//                                                                         Alignment
//                                                                             .topLeft,
//                                                                     child:
//                                                                         InkWell(
//                                                                       onTap:
//                                                                           () {
//                                                                         Navigator.of(context).push(MaterialPageRoute(
//                                                                             builder: (BuildContext context) =>
//                                                                                 MixingInventory(id: lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].id.toString())));
//                                                                       },
//                                                                       child:
//                                                                           Container(
//                                                                         padding: const EdgeInsets
//                                                                             .all(
//                                                                             2),
//                                                                         alignment:
//                                                                             Alignment.center,
//                                                                         width: size.width *
//                                                                             0.1,
//                                                                         height:
//                                                                             30,
//                                                                         decoration: BoxDecoration(
//                                                                             // shape: BoxShape.circle,
//                                                                             borderRadius: BorderRadius.circular(10),
//                                                                             color: const Color.fromARGB(255, 130, 193, 245),
//                                                                             gradient: const LinearGradient(
//                                                                               colors: [
//                                                                                 Colors.orange,
//                                                                                 Colors.orange,
//                                                                               ],
//                                                                             )),
//                                                                         child: const Align(
//                                                                             alignment: Alignment.center,
//                                                                             child: Icon(
//                                                                               Icons.remove_red_eye,
//                                                                               color: Colors.white,
//                                                                             )),
//                                                                       ),
//                                                                     ),
//                                                                   )
//                                                                 : (lCPWorkOrderPendingViewModel
//                                                                             .lcpWorkOrderPendingGetTabularData
//                                                                             .data!
//                                                                             .findAllTableData![
//                                                                                 index]
//                                                                             .mixingInventory
//                                                                             .toString() ==
//                                                                         'REJECTED')
//                                                                     ? Align(
//                                                                         alignment:
//                                                                             Alignment.topLeft,
//                                                                         child:
//                                                                             InkWell(
//                                                                           onTap:
//                                                                               () {
//                                                                             Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => MixingInventory(id: lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].id.toString())));
//                                                                           },
//                                                                           child:
//                                                                               Container(
//                                                                             padding:
//                                                                                 const EdgeInsets.all(2),
//                                                                             alignment:
//                                                                                 Alignment.center,
//                                                                             width:
//                                                                                 size.width * 0.1,
//                                                                             height:
//                                                                                 30,
//                                                                             decoration: BoxDecoration(
//                                                                                 // shape: BoxShape.circle,
//                                                                                 borderRadius: BorderRadius.circular(10),
//                                                                                 color: const Color.fromARGB(255, 130, 193, 245),
//                                                                                 gradient: const LinearGradient(
//                                                                                   colors: [
//                                                                                     Colors.red,
//                                                                                     Colors.red,
//                                                                                   ],
//                                                                                 )),
//                                                                             child: const Align(
//                                                                                 alignment: Alignment.center,
//                                                                                 child: Icon(
//                                                                                   Icons.remove_red_eye,
//                                                                                   color: Colors.white,
//                                                                                 )),
//                                                                           ),
//                                                                         ),
//                                                                       )
//                                                                     : (lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].maintType ==
//                                                                             'RegularMaint')
//                                                                         ? const Text(
//                                                                             "",
//                                                                             textAlign:
//                                                                                 TextAlign.left,
//                                                                             style:
//                                                                                 TextStyle(
//                                                                               fontSize: 0,
//                                                                               fontWeight: FontWeight.bold,
//                                                                               color: AppColors.baseColor,
//                                                                             ),
//                                                                           )
//                                                                         : const Text(
//                                                                             "",
//                                                                             textAlign:
//                                                                                 TextAlign.left,
//                                                                             style:
//                                                                                 TextStyle(
//                                                                               fontSize: 12,
//                                                                               //  fontWeight:
//                                                                               //      FontWeight.bold,
//                                                                               color: Colors.white,
//                                                                             ),
//                                                                           )
//                                                       ],
//                                                     ),
//                                                   ),
//                                                   Expanded(
//                                                     // alignment: Alignment.topLeft,
//                                                     child: Column(
//                                                       children: [
//                                                         const Align(
//                                                           alignment:
//                                                               Alignment.topLeft,
//                                                           child: Text(
//                                                             "SUBSTATION: ",
//                                                             textAlign:
//                                                                 TextAlign.left,
//                                                             style: TextStyle(
//                                                               fontSize: 12,
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .bold,
//                                                               color:
//                                                                   Colors.white,
//                                                             ),
//                                                           ),
//                                                         ),
//                                                         Align(
//                                                           alignment:
//                                                               Alignment.topLeft,
//                                                           child: Text(
//                                                             (lCPWorkOrderPendingViewModel
//                                                                             .lcpWorkOrderPendingGetTabularData
//                                                                             .data!
//                                                                             .findAllTableData![
//                                                                                 index]
//                                                                             .substation ==
//                                                                         null ||
//                                                                     lCPWorkOrderPendingViewModel
//                                                                             .lcpWorkOrderPendingGetTabularData
//                                                                             .data!
//                                                                             .findAllTableData![
//                                                                                 index]
//                                                                             .substation
//                                                                             .toString() ==
//                                                                         'null')
//                                                                 ? ''
//                                                                 : lCPWorkOrderPendingViewModel
//                                                                     .lcpWorkOrderPendingGetTabularData
//                                                                     .data!
//                                                                     .findAllTableData![
//                                                                         index]
//                                                                     .substation
//                                                                     .toString(),
//                                                             textAlign:
//                                                                 TextAlign.left,
//                                                             style:
//                                                                 const TextStyle(
//                                                               fontSize: 12,
//                                                               color:
//                                                                   Colors.white,
//                                                             ),
//                                                           ),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                             const Divider(
//                                               color: Colors.grey,
//                                             ),
//                                             Padding(
//                                               padding: const EdgeInsets.only(
//                                                   left: 8.0),
//                                               child: Row(
//                                                 children: [
//                                                   Expanded(
//                                                     // alignment: Alignment.topLeft,
//                                                     child: Column(
//                                                       children: [
//                                                         const Align(
//                                                           alignment:
//                                                               Alignment.topLeft,
//                                                           child: Text(
//                                                             "FEEDER: ",
//                                                             textAlign:
//                                                                 TextAlign.left,
//                                                             style: TextStyle(
//                                                               fontSize: 12,
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .bold,
//                                                               color:
//                                                                   Colors.white,
//                                                             ),
//                                                           ),
//                                                         ),
//                                                         Align(
//                                                           alignment:
//                                                               Alignment.topLeft,
//                                                           child: Text(
//                                                             (lCPWorkOrderPendingViewModel
//                                                                             .lcpWorkOrderPendingGetTabularData
//                                                                             .data!
//                                                                             .findAllTableData![
//                                                                                 index]
//                                                                             .fdrName ==
//                                                                         null ||
//                                                                     lCPWorkOrderPendingViewModel
//                                                                             .lcpWorkOrderPendingGetTabularData
//                                                                             .data!
//                                                                             .findAllTableData![
//                                                                                 index]
//                                                                             .fdrName
//                                                                             .toString() ==
//                                                                         'null')
//                                                                 ? ''
//                                                                 : lCPWorkOrderPendingViewModel
//                                                                     .lcpWorkOrderPendingGetTabularData
//                                                                     .data!
//                                                                     .findAllTableData![
//                                                                         index]
//                                                                     .fdrName
//                                                                     .toString(),
//                                                             textAlign:
//                                                                 TextAlign.left,
//                                                             style:
//                                                                 const TextStyle(
//                                                               fontSize: 12,
//                                                               //  fontWeight:
//                                                               //      FontWeight.bold,
//                                                               color:
//                                                                   Colors.white,
//                                                             ),
//                                                           ),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                   Expanded(
//                                                     // alignment: Alignment.topLeft,
//                                                     child: Column(
//                                                       children: [
//                                                         const Align(
//                                                           alignment:
//                                                               Alignment.topLeft,
//                                                           child: Text(
//                                                             "MAINTENANCE TYPE: ",
//                                                             textAlign:
//                                                                 TextAlign.left,
//                                                             style: TextStyle(
//                                                               fontSize: 12,
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .bold,
//                                                               color:
//                                                                   Colors.white,
//                                                             ),
//                                                           ),
//                                                         ),
//                                                         Align(
//                                                           alignment:
//                                                               Alignment.topLeft,
//                                                           child: Text(
//                                                             (lCPWorkOrderPendingViewModel
//                                                                             .lcpWorkOrderPendingGetTabularData
//                                                                             .data!
//                                                                             .findAllTableData![
//                                                                                 index]
//                                                                             .type ==
//                                                                         null ||
//                                                                     lCPWorkOrderPendingViewModel
//                                                                             .lcpWorkOrderPendingGetTabularData
//                                                                             .data!
//                                                                             .findAllTableData![
//                                                                                 index]
//                                                                             .type
//                                                                             .toString() ==
//                                                                         'null')
//                                                                 ? ''
//                                                                 : lCPWorkOrderPendingViewModel
//                                                                     .lcpWorkOrderPendingGetTabularData
//                                                                     .data!
//                                                                     .findAllTableData![
//                                                                         index]
//                                                                     .type
//                                                                     .toString(),
//                                                             textAlign:
//                                                                 TextAlign.left,
//                                                             style:
//                                                                 const TextStyle(
//                                                               fontSize: 12,
//                                                               //  fontWeight:
//                                                               //      FontWeight.bold,
//                                                               color:
//                                                                   Colors.white,
//                                                             ),
//                                                           ),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                   Expanded(
//                                                     // alignment: Alignment.topLeft,
//                                                     child: Column(
//                                                       children: [
//                                                         const Align(
//                                                           alignment:
//                                                               Alignment.topLeft,
//                                                           child: Text(
//                                                             "CONTRACTOR: ",
//                                                             textAlign:
//                                                                 TextAlign.left,
//                                                             style: TextStyle(
//                                                               fontSize: 12,
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .bold,
//                                                               color:
//                                                                   Colors.white,
//                                                             ),
//                                                           ),
//                                                         ),
//                                                         Align(
//                                                           alignment:
//                                                               Alignment.topLeft,
//                                                           child: Text(
//                                                             (lCPWorkOrderPendingViewModel
//                                                                             .lcpWorkOrderPendingGetTabularData
//                                                                             .data!
//                                                                             .findAllTableData![
//                                                                                 index]
//                                                                             .contractor ==
//                                                                         null ||
//                                                                     lCPWorkOrderPendingViewModel
//                                                                             .lcpWorkOrderPendingGetTabularData
//                                                                             .data!
//                                                                             .findAllTableData![
//                                                                                 index]
//                                                                             .contractor
//                                                                             .toString() ==
//                                                                         'null')
//                                                                 ? ''
//                                                                 : lCPWorkOrderPendingViewModel
//                                                                     .lcpWorkOrderPendingGetTabularData
//                                                                     .data!
//                                                                     .findAllTableData![
//                                                                         index]
//                                                                     .contractor
//                                                                     .toString(),
//                                                             textAlign:
//                                                                 TextAlign.left,
//                                                             style:
//                                                                 const TextStyle(
//                                                               fontSize: 12,
//                                                               //  fontWeight:
//                                                               //      FontWeight.bold,
//                                                               color:
//                                                                   Colors.white,
//                                                             ),
//                                                           ),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                             const Divider(
//                                               color: Colors.grey,
//                                             ),
//                                             Padding(
//                                               padding: const EdgeInsets.only(
//                                                   left: 8.0),
//                                               child: Row(
//                                                 children: [
//                                                   Expanded(
//                                                     // alignment: Alignment.topLeft,
//                                                     child: Column(
//                                                       children: [
//                                                         const Align(
//                                                           alignment:
//                                                               Alignment.topLeft,
//                                                           child: Text(
//                                                             "TOTAL MILES: ",
//                                                             textAlign:
//                                                                 TextAlign.left,
//                                                             style: TextStyle(
//                                                               fontSize: 12,
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .bold,
//                                                               color:
//                                                                   Colors.white,
//                                                             ),
//                                                           ),
//                                                         ),
//                                                         Align(
//                                                           alignment:
//                                                               Alignment.topLeft,
//                                                           child: Text(
//                                                             (lCPWorkOrderPendingViewModel
//                                                                             .lcpWorkOrderPendingGetTabularData
//                                                                             .data!
//                                                                             .findAllTableData![
//                                                                                 index]
//                                                                             .totalMiles ==
//                                                                         null ||
//                                                                     lCPWorkOrderPendingViewModel
//                                                                             .lcpWorkOrderPendingGetTabularData
//                                                                             .data!
//                                                                             .findAllTableData![
//                                                                                 index]
//                                                                             .totalMiles
//                                                                             .toString() ==
//                                                                         'null')
//                                                                 ? ''
//                                                                 : lCPWorkOrderPendingViewModel
//                                                                     .lcpWorkOrderPendingGetTabularData
//                                                                     .data!
//                                                                     .findAllTableData![
//                                                                         index]
//                                                                     .totalMiles
//                                                                     .toString(),
//                                                             textAlign:
//                                                                 TextAlign.left,
//                                                             style:
//                                                                 const TextStyle(
//                                                               fontSize: 12,
//                                                               color:
//                                                                   Colors.white,
//                                                             ),
//                                                           ),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                   Expanded(
//                                                     // alignment: Alignment.topLeft,
//                                                     child: Column(
//                                                       children: [
//                                                         const Align(
//                                                           alignment:
//                                                               Alignment.topLeft,
//                                                           child: Text(
//                                                             "CONTRACT YEAR: ",
//                                                             textAlign:
//                                                                 TextAlign.left,
//                                                             style: TextStyle(
//                                                               fontSize: 12,
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .bold,
//                                                               color:
//                                                                   Colors.white,
//                                                             ),
//                                                           ),
//                                                         ),
//                                                         Align(
//                                                           alignment:
//                                                               Alignment.topLeft,
//                                                           child: Text(
//                                                             (lCPWorkOrderPendingViewModel
//                                                                             .lcpWorkOrderPendingGetTabularData
//                                                                             .data!
//                                                                             .findAllTableData![
//                                                                                 index]
//                                                                             .contractYear ==
//                                                                         null ||
//                                                                     lCPWorkOrderPendingViewModel
//                                                                             .lcpWorkOrderPendingGetTabularData
//                                                                             .data!
//                                                                             .findAllTableData![
//                                                                                 index]
//                                                                             .contractYear
//                                                                             .toString() ==
//                                                                         'null')
//                                                                 ? ''
//                                                                 : lCPWorkOrderPendingViewModel
//                                                                     .lcpWorkOrderPendingGetTabularData
//                                                                     .data!
//                                                                     .findAllTableData![
//                                                                         index]
//                                                                     .contractYear
//                                                                     .toString(),
//                                                             textAlign:
//                                                                 TextAlign.left,
//                                                             style:
//                                                                 const TextStyle(
//                                                               fontSize: 12,
//                                                               color:
//                                                                   Colors.white,
//                                                             ),
//                                                           ),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                   Expanded(
//                                                     // alignment: Alignment.topLeft,
//                                                     child: Column(
//                                                       children: [
//                                                         const Align(
//                                                           alignment:
//                                                               Alignment.topLeft,
//                                                           child: Text(
//                                                             "CYCLE: ",
//                                                             textAlign:
//                                                                 TextAlign.left,
//                                                             style: TextStyle(
//                                                               fontSize: 12,
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .bold,
//                                                               color:
//                                                                   Colors.white,
//                                                             ),
//                                                           ),
//                                                         ),
//                                                         Align(
//                                                           alignment:
//                                                               Alignment.topLeft,
//                                                           child: Text(
//                                                             (lCPWorkOrderPendingViewModel
//                                                                             .lcpWorkOrderPendingGetTabularData
//                                                                             .data!
//                                                                             .findAllTableData![
//                                                                                 index]
//                                                                             .cycle ==
//                                                                         null ||
//                                                                     lCPWorkOrderPendingViewModel
//                                                                             .lcpWorkOrderPendingGetTabularData
//                                                                             .data!
//                                                                             .findAllTableData![
//                                                                                 index]
//                                                                             .cycle
//                                                                             .toString() ==
//                                                                         'null')
//                                                                 ? ''
//                                                                 : lCPWorkOrderPendingViewModel
//                                                                     .lcpWorkOrderPendingGetTabularData
//                                                                     .data!
//                                                                     .findAllTableData![
//                                                                         index]
//                                                                     .cycle
//                                                                     .toString(),
//                                                             textAlign:
//                                                                 TextAlign.left,
//                                                             style:
//                                                                 const TextStyle(
//                                                               fontSize: 12,
//                                                               color:
//                                                                   Colors.white,
//                                                             ),
//                                                           ),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                             const Divider(
//                                               color: Colors.grey,
//                                             ),
//                                             Padding(
//                                               padding: const EdgeInsets.only(
//                                                   left: 8.0),
//                                               child: Row(
//                                                 children: [
//                                                   Expanded(
//                                                     // alignment: Alignment.topLeft,
//                                                     child: Column(
//                                                       children: [
//                                                         const Align(
//                                                           alignment:
//                                                               Alignment.topLeft,
//                                                           child: Text(
//                                                             "SERVICE STREET ADDRESS: ",
//                                                             textAlign:
//                                                                 TextAlign.left,
//                                                             style: TextStyle(
//                                                               fontSize: 12,
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .bold,
//                                                               color:
//                                                                   Colors.white,
//                                                             ),
//                                                           ),
//                                                         ),
//                                                         Align(
//                                                           alignment:
//                                                               Alignment.topLeft,
//                                                           child: Text(
//                                                             (lCPWorkOrderPendingViewModel
//                                                                             .lcpWorkOrderPendingGetTabularData
//                                                                             .data!
//                                                                             .findAllTableData![
//                                                                                 index]
//                                                                             .streetAddress ==
//                                                                         null ||
//                                                                     lCPWorkOrderPendingViewModel
//                                                                             .lcpWorkOrderPendingGetTabularData
//                                                                             .data!
//                                                                             .findAllTableData![
//                                                                                 index]
//                                                                             .streetAddress
//                                                                             .toString() ==
//                                                                         'null')
//                                                                 ? ''
//                                                                 : lCPWorkOrderPendingViewModel
//                                                                     .lcpWorkOrderPendingGetTabularData
//                                                                     .data!
//                                                                     .findAllTableData![
//                                                                         index]
//                                                                     .streetAddress
//                                                                     .toString(),
//                                                             textAlign:
//                                                                 TextAlign.left,
//                                                             style:
//                                                                 const TextStyle(
//                                                               fontSize: 12,
//                                                               color:
//                                                                   Colors.white,
//                                                             ),
//                                                           ),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                   Expanded(
//                                                     // alignment: Alignment.topLeft,
//                                                     child: Column(
//                                                       children: [
//                                                         const Align(
//                                                           alignment:
//                                                               Alignment.topLeft,
//                                                           child: Text(
//                                                             "SERVICE MAP LOCATION: ",
//                                                             textAlign:
//                                                                 TextAlign.left,
//                                                             style: TextStyle(
//                                                               fontSize: 12,
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .bold,
//                                                               color:
//                                                                   Colors.white,
//                                                             ),
//                                                           ),
//                                                         ),
//                                                         Align(
//                                                           alignment:
//                                                               Alignment.topLeft,
//                                                           child: Text(
//                                                             (lCPWorkOrderPendingViewModel
//                                                                             .lcpWorkOrderPendingGetTabularData
//                                                                             .data!
//                                                                             .findAllTableData![
//                                                                                 index]
//                                                                             .mapLocation ==
//                                                                         null ||
//                                                                     lCPWorkOrderPendingViewModel
//                                                                             .lcpWorkOrderPendingGetTabularData
//                                                                             .data!
//                                                                             .findAllTableData![
//                                                                                 index]
//                                                                             .mapLocation
//                                                                             .toString() ==
//                                                                         'null')
//                                                                 ? ''
//                                                                 : lCPWorkOrderPendingViewModel
//                                                                     .lcpWorkOrderPendingGetTabularData
//                                                                     .data!
//                                                                     .findAllTableData![
//                                                                         index]
//                                                                     .mapLocation
//                                                                     .toString(),
//                                                             textAlign:
//                                                                 TextAlign.left,
//                                                             style:
//                                                                 const TextStyle(
//                                                               fontSize: 12,
//                                                               //  fontWeight:
//                                                               //      FontWeight.bold,
//                                                               color:
//                                                                   Colors.white,
//                                                             ),
//                                                           ),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                   Expanded(
//                                                     // alignment: Alignment.topLeft,
//                                                     child: Column(
//                                                       children: [
//                                                         const Align(
//                                                           alignment:
//                                                               Alignment.topLeft,
//                                                           child: Text(
//                                                             "ADMIN NOTES 1: ",
//                                                             textAlign:
//                                                                 TextAlign.left,
//                                                             style: TextStyle(
//                                                               fontSize: 12,
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .bold,
//                                                               color:
//                                                                   Colors.white,
//                                                             ),
//                                                           ),
//                                                         ),
//                                                         Align(
//                                                           alignment:
//                                                               Alignment.topLeft,
//                                                           child: Text(
//                                                             (lCPWorkOrderPendingViewModel
//                                                                             .lcpWorkOrderPendingGetTabularData
//                                                                             .data!
//                                                                             .findAllTableData![
//                                                                                 index]
//                                                                             .adminNotes1 ==
//                                                                         null ||
//                                                                     lCPWorkOrderPendingViewModel
//                                                                             .lcpWorkOrderPendingGetTabularData
//                                                                             .data!
//                                                                             .findAllTableData![
//                                                                                 index]
//                                                                             .adminNotes1
//                                                                             .toString() ==
//                                                                         'null')
//                                                                 ? ''
//                                                                 : lCPWorkOrderPendingViewModel
//                                                                     .lcpWorkOrderPendingGetTabularData
//                                                                     .data!
//                                                                     .findAllTableData![
//                                                                         index]
//                                                                     .adminNotes1
//                                                                     .toString(),
//                                                             textAlign:
//                                                                 TextAlign.left,
//                                                             style:
//                                                                 const TextStyle(
//                                                               fontSize: 12,
//                                                               color:
//                                                                   Colors.white,
//                                                             ),
//                                                           ),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                             const Divider(
//                                               color: Colors.grey,
//                                             ),
//                                             Padding(
//                                               padding: const EdgeInsets.only(
//                                                   left: 8.0),
//                                               child: Row(
//                                                 children: [
//                                                   Expanded(
//                                                     // alignment: Alignment.topLeft,
//                                                     child: Column(
//                                                       children: [
//                                                         const Align(
//                                                           alignment:
//                                                               Alignment.topLeft,
//                                                           child: Text(
//                                                             "CONTRACTOR COMPANY: ",
//                                                             textAlign:
//                                                                 TextAlign.left,
//                                                             style: TextStyle(
//                                                               fontSize: 12,
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .bold,
//                                                               color:
//                                                                   Colors.white,
//                                                             ),
//                                                           ),
//                                                         ),
//                                                         Align(
//                                                           alignment:
//                                                               Alignment.topLeft,
//                                                           child: Text(
//                                                             (lCPWorkOrderPendingViewModel
//                                                                             .lcpWorkOrderPendingGetTabularData
//                                                                             .data!
//                                                                             .findAllTableData![
//                                                                                 index]
//                                                                             .contractorCompany ==
//                                                                         null ||
//                                                                     lCPWorkOrderPendingViewModel
//                                                                             .lcpWorkOrderPendingGetTabularData
//                                                                             .data!
//                                                                             .findAllTableData![
//                                                                                 index]
//                                                                             .contractorCompany
//                                                                             .toString() ==
//                                                                         'null')
//                                                                 ? ''
//                                                                 : lCPWorkOrderPendingViewModel
//                                                                     .lcpWorkOrderPendingGetTabularData
//                                                                     .data!
//                                                                     .findAllTableData![
//                                                                         index]
//                                                                     .contractorCompany
//                                                                     .toString(),
//                                                             textAlign:
//                                                                 TextAlign.left,
//                                                             style:
//                                                                 const TextStyle(
//                                                               fontSize: 12,
//                                                               color:
//                                                                   Colors.white,
//                                                             ),
//                                                           ),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                   Expanded(
//                                                     // alignment: Alignment.topLeft,
//                                                     child: Column(
//                                                       children: [
//                                                         const Align(
//                                                           alignment:
//                                                               Alignment.topLeft,
//                                                           child: Text(
//                                                             "DATE OF INSPECTION: ",
//                                                             textAlign:
//                                                                 TextAlign.left,
//                                                             style: TextStyle(
//                                                               fontSize: 12,
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .bold,
//                                                               color:
//                                                                   Colors.white,
//                                                             ),
//                                                           ),
//                                                         ),
//                                                         Align(
//                                                           alignment:
//                                                               Alignment.topLeft,
//                                                           child: Text(
//                                                             (lCPWorkOrderPendingViewModel
//                                                                             .lcpWorkOrderPendingGetTabularData
//                                                                             .data!
//                                                                             .findAllTableData![
//                                                                                 index]
//                                                                             .dateOfInspection ==
//                                                                         null ||
//                                                                     lCPWorkOrderPendingViewModel
//                                                                             .lcpWorkOrderPendingGetTabularData
//                                                                             .data!
//                                                                             .findAllTableData![
//                                                                                 index]
//                                                                             .dateOfInspection
//                                                                             .toString() ==
//                                                                         'null')
//                                                                 ? ''
//                                                                 : lCPWorkOrderPendingViewModel
//                                                                     .lcpWorkOrderPendingGetTabularData
//                                                                     .data!
//                                                                     .findAllTableData![
//                                                                         index]
//                                                                     .dateOfInspection
//                                                                     .toString(),
//                                                             textAlign:
//                                                                 TextAlign.left,
//                                                             style:
//                                                                 const TextStyle(
//                                                               fontSize: 12,
//                                                               color:
//                                                                   Colors.white,
//                                                             ),
//                                                           ),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                   Expanded(
//                                                     // alignment: Alignment.topLeft,
//                                                     child: Column(
//                                                       children: [
//                                                         const Align(
//                                                           alignment:
//                                                               Alignment.topLeft,
//                                                           child: Text(
//                                                             "FOLLOW UP DATE: ",
//                                                             textAlign:
//                                                                 TextAlign.left,
//                                                             style: TextStyle(
//                                                               fontSize: 12,
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .bold,
//                                                               color:
//                                                                   Colors.white,
//                                                             ),
//                                                           ),
//                                                         ),
//                                                         Align(
//                                                           alignment:
//                                                               Alignment.topLeft,
//                                                           child: Text(
//                                                             (lCPWorkOrderPendingViewModel
//                                                                             .lcpWorkOrderPendingGetTabularData
//                                                                             .data!
//                                                                             .findAllTableData![
//                                                                                 index]
//                                                                             .followUpDate ==
//                                                                         null ||
//                                                                     lCPWorkOrderPendingViewModel
//                                                                             .lcpWorkOrderPendingGetTabularData
//                                                                             .data!
//                                                                             .findAllTableData![
//                                                                                 index]
//                                                                             .followUpDate
//                                                                             .toString() ==
//                                                                         'null')
//                                                                 ? ''
//                                                                 : lCPWorkOrderPendingViewModel
//                                                                     .lcpWorkOrderPendingGetTabularData
//                                                                     .data!
//                                                                     .findAllTableData![
//                                                                         index]
//                                                                     .followUpDate
//                                                                     .toString(),
//                                                             textAlign:
//                                                                 TextAlign.left,
//                                                             style:
//                                                                 const TextStyle(
//                                                               fontSize: 12,
//                                                               color:
//                                                                   Colors.white,
//                                                             ),
//                                                           ),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                             const Divider(
//                                               color: Colors.grey,
//                                             ),
//                                             Padding(
//                                               padding: const EdgeInsets.only(
//                                                   left: 8.0),
//                                               child: Row(
//                                                 children: [
//                                                   Expanded(
//                                                     // alignment: Alignment.topLeft,
//                                                     child: Column(
//                                                       children: [
//                                                         const Align(
//                                                           alignment:
//                                                               Alignment.topLeft,
//                                                           child: Text(
//                                                             "TOTAL COST: ",
//                                                             textAlign:
//                                                                 TextAlign.left,
//                                                             style: TextStyle(
//                                                               fontSize: 12,
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .bold,
//                                                               color:
//                                                                   Colors.white,
//                                                             ),
//                                                           ),
//                                                         ),
//                                                         Align(
//                                                           alignment:
//                                                               Alignment.topLeft,
//                                                           child: Text(
//                                                             (lCPWorkOrderPendingViewModel
//                                                                             .lcpWorkOrderPendingGetTabularData
//                                                                             .data!
//                                                                             .findAllTableData![
//                                                                                 index]
//                                                                             .totalCost ==
//                                                                         null ||
//                                                                     lCPWorkOrderPendingViewModel
//                                                                             .lcpWorkOrderPendingGetTabularData
//                                                                             .data!
//                                                                             .findAllTableData![
//                                                                                 index]
//                                                                             .totalCost
//                                                                             .toString() ==
//                                                                         'null')
//                                                                 ? ''
//                                                                 : lCPWorkOrderPendingViewModel
//                                                                     .lcpWorkOrderPendingGetTabularData
//                                                                     .data!
//                                                                     .findAllTableData![
//                                                                         index]
//                                                                     .totalCost
//                                                                     .toString(),
//                                                             textAlign:
//                                                                 TextAlign.left,
//                                                             style:
//                                                                 const TextStyle(
//                                                               fontSize: 12,
//                                                               color:
//                                                                   Colors.white,
//                                                             ),
//                                                           ),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                   Expanded(
//                                                     // alignment: Alignment.topLeft,
//                                                     child: Column(
//                                                       children: [
//                                                         const Align(
//                                                           alignment:
//                                                               Alignment.topLeft,
//                                                           child: Text(
//                                                             "NEXT MAINT DUE: ",
//                                                             textAlign:
//                                                                 TextAlign.left,
//                                                             style: TextStyle(
//                                                               fontSize: 12,
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .bold,
//                                                               color:
//                                                                   Colors.white,
//                                                             ),
//                                                           ),
//                                                         ),
//                                                         Align(
//                                                           alignment:
//                                                               Alignment.topLeft,
//                                                           child: Text(
//                                                             (lCPWorkOrderPendingViewModel
//                                                                             .lcpWorkOrderPendingGetTabularData
//                                                                             .data!
//                                                                             .findAllTableData![
//                                                                                 index]
//                                                                             .nextMaintDue ==
//                                                                         null ||
//                                                                     lCPWorkOrderPendingViewModel
//                                                                             .lcpWorkOrderPendingGetTabularData
//                                                                             .data!
//                                                                             .findAllTableData![
//                                                                                 index]
//                                                                             .nextMaintDue
//                                                                             .toString() ==
//                                                                         'null')
//                                                                 ? ''
//                                                                 : lCPWorkOrderPendingViewModel
//                                                                     .lcpWorkOrderPendingGetTabularData
//                                                                     .data!
//                                                                     .findAllTableData![
//                                                                         index]
//                                                                     .nextMaintDue
//                                                                     .toString(),
//                                                             textAlign:
//                                                                 TextAlign.left,
//                                                             style:
//                                                                 const TextStyle(
//                                                               fontSize: 12,
//                                                               color:
//                                                                   Colors.white,
//                                                             ),
//                                                           ),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                   Expanded(
//                                                     // alignment: Alignment.topLeft,
//                                                     child: Column(
//                                                       children: [
//                                                         const Align(
//                                                           alignment:
//                                                               Alignment.topLeft,
//                                                           child: Text(
//                                                             "CREATE DATE: ",
//                                                             textAlign:
//                                                                 TextAlign.left,
//                                                             style: TextStyle(
//                                                               fontSize: 12,
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .bold,
//                                                               color:
//                                                                   Colors.white,
//                                                             ),
//                                                           ),
//                                                         ),
//                                                         Align(
//                                                           alignment:
//                                                               Alignment.topLeft,
//                                                           child: Text(
//                                                             (lCPWorkOrderPendingViewModel
//                                                                             .lcpWorkOrderPendingGetTabularData
//                                                                             .data!
//                                                                             .findAllTableData![
//                                                                                 index]
//                                                                             .createDate ==
//                                                                         null ||
//                                                                     lCPWorkOrderPendingViewModel
//                                                                             .lcpWorkOrderPendingGetTabularData
//                                                                             .data!
//                                                                             .findAllTableData![index]
//                                                                             .createDate
//                                                                             .toString() ==
//                                                                         'null')
//                                                                 ? ''
//                                                                 : formattedDate,
//                                                             textAlign:
//                                                                 TextAlign.left,
//                                                             style:
//                                                                 const TextStyle(
//                                                               fontSize: 12,
//                                                               color:
//                                                                   Colors.white,
//                                                             ),
//                                                           ),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                             const Divider(
//                                               color: Colors.grey,
//                                             ),
//                                             Padding(
//                                               padding: const EdgeInsets.only(
//                                                   left: 8.0),
//                                               child: Row(
//                                                 children: [
//                                                   Expanded(
//                                                     // alignment: Alignment.topLeft,
//                                                     child: Column(
//                                                       children: [
//                                                         const Align(
//                                                           alignment:
//                                                               Alignment.topLeft,
//                                                           child: Text(
//                                                             "ESTIMATED COST: ",
//                                                             textAlign:
//                                                                 TextAlign.left,
//                                                             style: TextStyle(
//                                                               fontSize: 12,
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .bold,
//                                                               color:
//                                                                   Colors.white,
//                                                             ),
//                                                           ),
//                                                         ),
//                                                         Align(
//                                                           alignment:
//                                                               Alignment.topLeft,
//                                                           child: Text(
//                                                             (lCPWorkOrderPendingViewModel
//                                                                             .lcpWorkOrderPendingGetTabularData
//                                                                             .data!
//                                                                             .findAllTableData![
//                                                                                 index]
//                                                                             .estCost ==
//                                                                         null ||
//                                                                     lCPWorkOrderPendingViewModel
//                                                                             .lcpWorkOrderPendingGetTabularData
//                                                                             .data!
//                                                                             .findAllTableData![
//                                                                                 index]
//                                                                             .estCost
//                                                                             .toString() ==
//                                                                         'null')
//                                                                 ? ''
//                                                                 : lCPWorkOrderPendingViewModel
//                                                                     .lcpWorkOrderPendingGetTabularData
//                                                                     .data!
//                                                                     .findAllTableData![
//                                                                         index]
//                                                                     .estCost
//                                                                     .toString(),
//                                                             textAlign:
//                                                                 TextAlign.left,
//                                                             style:
//                                                                 const TextStyle(
//                                                               fontSize: 12,
//                                                               color:
//                                                                   Colors.white,
//                                                             ),
//                                                           ),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                   Expanded(
//                                                     // alignment: Alignment.topLeft,
//                                                     child: Column(
//                                                       children: [
//                                                         const Align(
//                                                           alignment:
//                                                               Alignment.topLeft,
//                                                           child: Text(
//                                                             "ESTIMATED TIME: ",
//                                                             textAlign:
//                                                                 TextAlign.left,
//                                                             style: TextStyle(
//                                                               fontSize: 12,
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .bold,
//                                                               color:
//                                                                   Colors.white,
//                                                             ),
//                                                           ),
//                                                         ),
//                                                         Align(
//                                                           alignment:
//                                                               Alignment.topLeft,
//                                                           child: Text(
//                                                             (lCPWorkOrderPendingViewModel
//                                                                             .lcpWorkOrderPendingGetTabularData
//                                                                             .data!
//                                                                             .findAllTableData![
//                                                                                 index]
//                                                                             .estTime ==
//                                                                         null ||
//                                                                     lCPWorkOrderPendingViewModel
//                                                                             .lcpWorkOrderPendingGetTabularData
//                                                                             .data!
//                                                                             .findAllTableData![
//                                                                                 index]
//                                                                             .estTime
//                                                                             .toString() ==
//                                                                         'null')
//                                                                 ? ''
//                                                                 : lCPWorkOrderPendingViewModel
//                                                                     .lcpWorkOrderPendingGetTabularData
//                                                                     .data!
//                                                                     .findAllTableData![
//                                                                         index]
//                                                                     .estTime
//                                                                     .toString(),
//                                                             textAlign:
//                                                                 TextAlign.left,
//                                                             style:
//                                                                 const TextStyle(
//                                                               fontSize: 12,
//                                                               color:
//                                                                   Colors.white,
//                                                             ),
//                                                           ),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                   Expanded(
//                                                     // alignment: Alignment.topLeft,
//                                                     child: Column(
//                                                       children: [
//                                                         const Align(
//                                                           alignment:
//                                                               Alignment.topLeft,
//                                                           child: Text(
//                                                             "ACTUAL COST: ",
//                                                             textAlign:
//                                                                 TextAlign.left,
//                                                             style: TextStyle(
//                                                               fontSize: 12,
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .bold,
//                                                               color:
//                                                                   Colors.white,
//                                                             ),
//                                                           ),
//                                                         ),
//                                                         Align(
//                                                           alignment:
//                                                               Alignment.topLeft,
//                                                           child: Text(
//                                                             (lCPWorkOrderPendingViewModel
//                                                                             .lcpWorkOrderPendingGetTabularData
//                                                                             .data!
//                                                                             .findAllTableData![
//                                                                                 index]
//                                                                             .actualCost ==
//                                                                         null ||
//                                                                     lCPWorkOrderPendingViewModel
//                                                                             .lcpWorkOrderPendingGetTabularData
//                                                                             .data!
//                                                                             .findAllTableData![
//                                                                                 index]
//                                                                             .actualCost
//                                                                             .toString() ==
//                                                                         'null')
//                                                                 ? ''
//                                                                 : lCPWorkOrderPendingViewModel
//                                                                     .lcpWorkOrderPendingGetTabularData
//                                                                     .data!
//                                                                     .findAllTableData![
//                                                                         index]
//                                                                     .actualCost
//                                                                     .toString(),
//                                                             textAlign:
//                                                                 TextAlign.left,
//                                                             style:
//                                                                 const TextStyle(
//                                                               fontSize: 12,
//                                                               color:
//                                                                   Colors.white,
//                                                             ),
//                                                           ),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                             const Divider(
//                                               color: Colors.grey,
//                                             ),
//                                             Padding(
//                                               padding: const EdgeInsets.only(
//                                                   left: 8.0),
//                                               child: Row(
//                                                 children: [
//                                                   Expanded(
//                                                     flex: 1,
//                                                     // alignment: Alignment.topLeft,
//                                                     child: Column(
//                                                       children: [
//                                                         const Align(
//                                                           alignment:
//                                                               Alignment.topLeft,
//                                                           child: Text(
//                                                             "COST PER MILE: ",
//                                                             textAlign:
//                                                                 TextAlign.left,
//                                                             style: TextStyle(
//                                                               fontSize: 12,
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .bold,
//                                                               color:
//                                                                   Colors.white,
//                                                             ),
//                                                           ),
//                                                         ),
//                                                         Align(
//                                                           alignment:
//                                                               Alignment.topLeft,
//                                                           child: Text(
//                                                             (lCPWorkOrderPendingViewModel
//                                                                             .lcpWorkOrderPendingGetTabularData
//                                                                             .data!
//                                                                             .findAllTableData![
//                                                                                 index]
//                                                                             .costPerMile ==
//                                                                         null ||
//                                                                     lCPWorkOrderPendingViewModel
//                                                                             .lcpWorkOrderPendingGetTabularData
//                                                                             .data!
//                                                                             .findAllTableData![
//                                                                                 index]
//                                                                             .costPerMile
//                                                                             .toString() ==
//                                                                         'null')
//                                                                 ? ''
//                                                                 : lCPWorkOrderPendingViewModel
//                                                                     .lcpWorkOrderPendingGetTabularData
//                                                                     .data!
//                                                                     .findAllTableData![
//                                                                         index]
//                                                                     .costPerMile
//                                                                     .toString(),
//                                                             textAlign:
//                                                                 TextAlign.left,
//                                                             style:
//                                                                 const TextStyle(
//                                                               fontSize: 12,
//                                                               color:
//                                                                   Colors.white,
//                                                             ),
//                                                           ),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                   Expanded(
//                                                     // alignment: Alignment.topLeft,
//                                                     child: (lCPWorkOrderPendingViewModel
//                                                                 .lcpWorkOrderPendingGetTabularData
//                                                                 .data!
//                                                                 .findAllTableData![
//                                                                     index]
//                                                                 .maintType
//                                                                 .toString() ==
//                                                             'RegularMaint')
//                                                         ? Column(
//                                                             children: [
//                                                               const Align(
//                                                                 alignment:
//                                                                     Alignment
//                                                                         .topLeft,
//                                                                 child: Text(
//                                                                   "SHARE: ",
//                                                                   textAlign:
//                                                                       TextAlign
//                                                                           .left,
//                                                                   style:
//                                                                       TextStyle(
//                                                                     fontSize:
//                                                                         12,
//                                                                     fontWeight:
//                                                                         FontWeight
//                                                                             .bold,
//                                                                     color: Colors
//                                                                         .white,
//                                                                   ),
//                                                                 ),
//                                                               ),
//                                                               (lCPWorkOrderPendingViewModel
//                                                                           .lcpWorkOrderPendingGetTabularData
//                                                                           .data!
//                                                                           .findAllTableData![
//                                                                               index]
//                                                                           .visibilityFlag
//                                                                           .toString() ==
//                                                                       '2')
//                                                                   ? Align(
//                                                                       alignment:
//                                                                           Alignment
//                                                                               .topLeft,
//                                                                       child:
//                                                                           InkWell(
//                                                                         onTap:
//                                                                             () async {
//                                                                           //   CustomToastSnackBarProgressDialog.flushBarSuccessMessage('${contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].tokenNo.toString()} Row Maintenance Already Shared with Crew',
//                                                                           //       context);
//                                                                         },
//                                                                         child: const Align(
//                                                                             alignment: Alignment.topLeft,
//                                                                             child: Icon(
//                                                                               Icons.share,
//                                                                               color: Colors.green,
//                                                                             )),
//                                                                       ),
//                                                                     )
//                                                                   : Align(
//                                                                       alignment:
//                                                                           Alignment
//                                                                               .topLeft,
//                                                                       child:
//                                                                           InkWell(
//                                                                         onTap:
//                                                                             () async {
//                                                                           // updateFlagValue(contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].tokenNo.toString(),
//                                                                           //     2);
//                                                                         },
//                                                                         child: const Align(
//                                                                             alignment: Alignment.topLeft,
//                                                                             child: Icon(
//                                                                               Icons.share,
//                                                                               color: Colors.blue,
//                                                                             )),
//                                                                       ),
//                                                                     )
//                                                             ],
//                                                           )
//                                                         : const Text(
//                                                             "",
//                                                             style: TextStyle(
//                                                               color:
//                                                                   Colors.white,
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .bold,
//                                                               fontSize: 10,
//                                                             ),
//                                                           ),
//                                                   ),
//                                                   Expanded(
//                                                     // flex: 2,
//                                                     child: Column(
//                                                       children: [
//                                                         InkWell(
//                                                           onTap: () async {
//                                                             String id = '';
//                                                             final userPreferences1 =
//                                                                 Provider.of<
//                                                                         UserPref>(
//                                                                     context,
//                                                                     listen:
//                                                                         false);
//                                                             UserModel data =
//                                                                 await userPreferences1
//                                                                     .getUser();
//                                                             id = data.user!.id
//                                                                 .toString();
//                                                             // Navigator.of(context).push(
//                                                             // MaterialPageRoute(
//                                                             //     builder: (BuildContext
//                                                             //             context) =>
//                                                             //         MapViewAdmin(
//                                                             //           id: lCPWorkOrderPendingViewModel
//                                                             //               .lcpWorkOrderPendingGetTabularData
//                                                             //               .data!
//                                                             //               .findAllTableData![index]
//                                                             //               .id
//                                                             //               .toString(),
//                                                             //         )));
//                                                             // Navigator.push(
//                                                             //   context,
//                                                             //   MaterialPageRoute(
//                                                             //     builder:
//                                                             //         (context) =>
//                                                             //             MapViewPage(
//                                                             //       url: MapUrl.getAdminEndPoint(
//                                                             //           lCPWorkOrderPendingViewModel
//                                                             //               .lcpWorkOrderPendingGetTabularData
//                                                             //               .data!
//                                                             //               .findAllTableData![
//                                                             //                   index]
//                                                             //               .tokenNo
//                                                             //               .toString(),
//                                                             //           id),
//                                                             //     ),
//                                                             //   ),
//                                                             // );
//                                                             await browser.open(
//                                                                 url: WebUri(
//                                                                     // "https://mapapi.ariespro.com/main/admin/CIVM_Map/${lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].tokenNo.toString()}/USRQWXH589Z"),
//                                                                     MapUrl.getAdminEndPoint(lCPWorkOrderPendingViewModel
//                                                                         .lcpWorkOrderPendingGetTabularData
//                                                                         .data!
//                                                                         .findAllTableData![
//                                                                             index]
//                                                                         .tokenNo
//                                                                         .toString(),id)),
//                                                                 settings: ChromeSafariBrowserSettings(
//                                                                     shareState:
//                                                                         CustomTabsShareState
//                                                                             .SHARE_STATE_OFF,
//                                                                     barCollapsingEnabled:
//                                                                         true));
//                                                           },
//                                                           child: Align(
//                                                             alignment: Alignment
//                                                                 .centerLeft,
//                                                             child: Container(
//                                                               // margin: const EdgeInsets.only(
//                                                               //     left: 40, right: 40, bottom: 10.0),
//                                                               padding:
//                                                                   const EdgeInsets
//                                                                       .all(8),
//                                                               alignment: Alignment
//                                                                   .centerLeft,
//                                                               width: 80,
//                                                               // MediaQuery.of(context).size.width,
//                                                               // height: MediaQuery.of(context).size.height * 0.4,
//                                                               decoration:
//                                                                   const BoxDecoration(
//                                                                       // shape: BoxShape.circle,

//                                                                       color: Color.fromARGB(
//                                                                           255,
//                                                                           0,
//                                                                           58,
//                                                                           106),
//                                                                       gradient:
//                                                                           LinearGradient(
//                                                                         colors: [
//                                                                           Color.fromARGB(
//                                                                               255,
//                                                                               0,
//                                                                               79,
//                                                                               215),
//                                                                           Colors
//                                                                               .blue,
//                                                                           Color.fromARGB(
//                                                                               255,
//                                                                               0,
//                                                                               79,
//                                                                               215),
//                                                                         ],
//                                                                       )),
//                                                               child:
//                                                                   const Align(
//                                                                 alignment:
//                                                                     Alignment
//                                                                         .center,
//                                                                 child: Text(
//                                                                   "VIEW MAP",
//                                                                   style:
//                                                                       TextStyle(
//                                                                     color: Colors
//                                                                         .white,
//                                                                     fontWeight:
//                                                                         FontWeight
//                                                                             .bold,
//                                                                     fontSize:
//                                                                         10,
//                                                                   ),
//                                                                 ),
//                                                               ),
//                                                             ),
//                                                           ),
//                                                         )
//                                                       ],
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                           ]),
//                                         ),
//                                       ),
//                                     ],
//                                   );
//                                 }),
//                           ),
//                         ],
//                       ),
//                     ),
//                   );

//                 default:
//                   return const Text('data');
//               }
//             })));
//   }

//   fetchData(String workOrderNoId) {
//     lCPWorkOrderPendingViewModel.fetchLCPWorkOrderPendingTabularListApi(
//         context,
//         'PENDING',
//         workOrderNoId,
//         '',
//         widget.budgetType,
//         widget.maintenanceType,
//         '',
//         '');
//   }

//   void _filterData(String query) {
//     if (query.isEmpty) {
//       lCPWorkOrderPendingViewModel.fetchLCPWorkOrderPendingTabularListApi(
//           context,
//           'PENDING',
//           '',
//           'LCP',
//           widget.budgetType,
//           widget.maintenanceType,
//           '',
//           '');
//     } else {
//       lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData = lCPWorkOrderPendingViewModel
//           .lcpWorkOrderPendingGetTabularData.data!.findAllTableData!
//           .where((item) =>
//               item.tokenNo.toString().toLowerCase().contains(query.toLowerCase()) ||
//               item.maintType
//                   .toString()
//                   .toLowerCase()
//                   .contains(query.toLowerCase()) ||
//               item.status
//                   .toString()
//                   .toLowerCase()
//                   .contains(query.toLowerCase()) ||
//               item.substation
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
//               item.contractorCompany
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
//               item.costPerMile.toString().toLowerCase().contains(query.toLowerCase()) ||
//               item.totalCost.toString().toLowerCase().contains(query.toLowerCase()) ||
//               item.nextMaintDue.toString().toLowerCase().contains(query.toLowerCase()))
//           .toList();
//     }
//     setState(() {});
//   }

//   DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
//       value: item,
//       child: Text(item,
//           style: const TextStyle(
//             fontWeight: FontWeight.normal,
//             fontSize: 20,
//           )));

//   Future openDialogPicture(String tokenNo) => showDialog(
//         context: context,
//         builder: (context) {
//           return StatefulBuilder(builder: (context, setState) {
//             // lCPWorkOrdersClosedViewModel.fetchImageApi(
//             //     context,
//             //     //  '1');
//             //     tokenNo.toString());
//             int length =
//                 lCPWorkOrderPendingViewModel.imageData.data?.images?.length ??
//                     0;

//             return AlertDialog(
//               content: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     for (int i = 0; i < length; i += 2)
//                       Row(
//                         children: [
//                           if (i < length) ...[
//                             buildImageWidget(i, tokenNo.toString()),
//                           ],
//                           if (i + 1 < length) ...[
//                             const SizedBox(width: 16),
//                             buildImageWidget(i + 1, tokenNo.toString()),
//                           ],
//                         ],
//                       ),
//                   ],
//                 ),
//               ),
//             );
//           });
//         },
//       );

//   Widget buildImageWidget(int i, String tokenNo) {
//     String? imageLocation =
//         lCPWorkOrderPendingViewModel.imageData.data?.images![i].imageLocation;

//     return Expanded(
//       child: (imageLocation != null)
//           ? Stack(
//               children: [
//                 // Check if the file type is PDF
//                 if (isPDF(imageLocation))
//                   Center(
//                     child: InkWell(
//                       onTap: () {
//                         Navigator.of(context).push(MaterialPageRoute(
//                             builder: (BuildContext context) => PDFViewer(
//                                 pdfUrl:
//                                     'https://atsdev2test.ariespro.com/assets/clientuploads/$imageLocation')));
//                       },
//                       child: Image.asset(
//                         'assets/pdflogo.jpg',
//                         height: 150,
//                         width: 150,
//                       ),
//                     ),
//                   )
//                 else
//                   InkWell(
//                     onTap: () {
//                       openFullSizeImageDialog(imageLocation);
//                     },
//                     child: Image.network(
//                       'https://atsdev2test.ariespro.com/assets/clientuploads/$imageLocation',
//                       // height: 400,
//                     ),
//                   ),
//                 Padding(
//                   padding: const EdgeInsets.only(top: 16.0),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       InkWell(
//                         onTap: () {
//                           print('111111111111111111111');
//                           if (!isPDF(imageLocation)) {
//                             print('image');
//                             downloadFile(
//                                 'https://atsdev2test.ariespro.com/assets/clientuploads/$imageLocation',
//                                 'Image',context);
//                             Navigator.pop(context);
//                           } else {
//                             print('pdf');
//                             downloadFile(
//                                 'https://atsdev2test.ariespro.com/assets/clientuploads/$imageLocation',
//                                 'PDF',context);
//                             Navigator.pop(context);
//                           }
//                         },
//                         child: const Icon(
//                           Icons.download,
//                           color: Colors.blue,
//                           size: 20,
//                         ),
//                       ),
//                       InkWell(
//                         onTap: () {
//                           deleteOnlineImageApi(imageLocation, tokenNo);
//                           Navigator.pop(context);
//                         },
//                         child: const Icon(
//                           Icons.delete,
//                           color: Colors.red,
//                           size: 20,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             )
//           : const Center(
//               child: Text(
//                 "NO IMAGE",
//                 textAlign: TextAlign.left,
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                   color: AppColors.baseColor,
//                 ),
//               ),
//             ),
//     );
//   }

//   // Future<void> downloadFile(String fileUrl, String fileType) async {
//   //   final response = await http.get(Uri.parse(fileUrl));
//   //   if (response.statusCode == 200) {
//   //     final appDir = await getApplicationDocumentsDirectory();
//   //     final fileName = fileUrl.split('/').last;
//   //     final file = File('${appDir.path}/$fileName');
//   //     await file.writeAsBytes(response.bodyBytes);
//   //     print('$fileType downloaded to: ${file.path}');
//   //     CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
//   //         '$fileType Downloaded', context);
//   //   } else {
//   //     print(
//   //         'Failed to download $fileType. Status code: ${response.statusCode}');
//   //   }
//   // }

//   bool isPDF(String fileLocation) {
//     return fileLocation.toLowerCase().endsWith('.pdf');
//   }

//   void openFullSizeImageDialog(String imageUrl) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return Dialog(
//           insetPadding: EdgeInsets.zero,
//           child: Stack(
//             children: [

//               PhotoViewGallery(
//                 pageController: PageController(),
//                 backgroundDecoration: const BoxDecoration(
//                   color: Colors.black,
//                 ),
//                 onPageChanged: (index) {},
//                 scrollPhysics: const BouncingScrollPhysics(),
//                 pageOptions: [
//                   PhotoViewGalleryPageOptions(
//                     imageProvider: NetworkImage(
//                       'https://atsdev2test.ariespro.com/assets/clientuploads/$imageUrl',
//                     ),
//                     minScale: PhotoViewComputedScale.contained * 0.5,
//                     maxScale: PhotoViewComputedScale.covered * 0.5,
//                   ),
//                 ],
//               ),
//                    Positioned(
//                 top: 30,
//                 right: 20,
//                 child: IconButton(
//                   icon: const Icon(Icons.close, color: Colors.white, size: 30),
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   Future<void> deleteOnlineImageApi(String fileName, String tokenNo) async {
//     final apiUrl =
//         'https://atsdev2test.ariespro.com/civmapi/changeOrderLcpCreateOrder/deleteFile?fileName=$fileName&tokenNo=$tokenNo';
//     print(apiUrl);
//     final userPreferences = Provider.of<UserPref>(context, listen: false);
//     UserModel data = await userPreferences.getUser();

//     try {
//       final response = await http.delete(
//         Uri.parse(apiUrl),
//         headers: {"Authorization": 'Bearer ${data.token!}'},
//       );

//       if (response.statusCode == 200) {
//         print('API response: ${response.body}');
//         setState(() {});
//         print('Image deleted successfully');
//         CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
//             'Image deleted Successfully', context);
//         // Navigator.pop(context);
//         await Future.delayed(const Duration(seconds: 2));
//         lCPWorkOrderPendingViewModel.fetchLCPWorkOrderPendingTabularListApi(
//             context,
//             'PENDING',
//             '',
//             '',
//             widget.budgetType,
//             widget.maintenanceType,
//             '',
//             '');
//       } else {
//         print('API request failed with status code: ${response.statusCode}');
//         print('Response body: ${response.body}');
//       }
//     } catch (e) {
//       print('Error: $e');
//     }
//   }
// }
