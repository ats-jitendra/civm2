// import 'dart:io';

// import 'package:CIVM/data/response/status.dart';
// import 'package:CIVM/models/user_model.dart';
// import 'package:CIVM/repository/map_url.dart';
// import 'package:CIVM/screens/admin_pannel/row_maintenance_view/pdf_view.dart';
// import 'package:CIVM/screens/chat_history.dart';
// import 'package:CIVM/screens/generalForeman_New_pannel/view_change_order.dart';
// import 'package:CIVM/screens/my_chrome_safari_map_recording.dart';
// import 'package:CIVM/screens/video_folder/fullVideo/full_screen_video_player.dart';
// // import 'package:CIVM/screens/contractor_pannel/map_view_for_contractor.dart';
// import 'package:CIVM/utils/custom_toast_snackbar_progressdialog.dart';
// import 'package:CIVM/utils/user_pref.dart';
// import 'package:CIVM/view_model/inicitedCancelWorkForApproval_view_model.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// // import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// import 'package:intl/intl.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:photo_view/photo_view.dart';
// import 'package:photo_view/photo_view_gallery.dart';
// import 'package:provider/provider.dart';
// import '../../../view_model/lcp_work_order_reject_view_model.dart';
// import 'package:http/http.dart' as http;

// // ignore: must_be_immutable
// class TotalOrderCanceledGF extends StatefulWidget {
//   String budgetType;
//   String maintenanceType;
//   String heading;

//   TotalOrderCanceledGF({
//     Key? key,
//     required this.budgetType,
//     required this.maintenanceType,
//     required this.heading,
//   }) : super(key: key);

//   @override
//   State<TotalOrderCanceledGF> createState() => _TotalOrderCanceledGFState();
// }

// class _TotalOrderCanceledGFState extends State<TotalOrderCanceledGF> {
//   List<String> menu = [];

//   int substationId = 0;
//   int feederId = 0;

//   // ignore: prefer_typing_uninitialized_variables
//   var selectedSubstation;
//   // ignore: prefer_typing_uninitialized_variables
//   var selectedFeeder;

//   String userName = '';

//   onTappedBar(int index) {
//     setState(() {
//       // _currentIndex = index;
//     });
//   }

//   final browser = MyChromeSafariBrowser();
//   LCPWorkOrderRejectViewModel lCPWorkOrderRejectViewModel =
//       LCPWorkOrderRejectViewModel();

//   String id = '';

//   final TextEditingController _input = TextEditingController();

//   String formattedContractYear = '';
//   String formattedNextMaintDue = '';

//   IniciatedCancelWorkForApprovalViewModel
//       iniciatedCancelWorkForApprovalViewModel =
//       IniciatedCancelWorkForApprovalViewModel();
//   String? rights;
//   @override
//   void initState() {
//     getContractorData();
//     // iniciatedCancelWorkForApprovalViewModel.fetchLCPWorkOrderRejectTabularListApi(
//     //     context, '', '', 'REJECTED', '', '', '');
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//         appBar: AppBar(
//           iconTheme: const IconThemeData(color: Colors.white),
//           title: Text(
//             widget.heading,
//             style: const TextStyle(color: Colors.white),
//           ),
//           backgroundColor: const Color.fromARGB(255, 7, 59, 120),
//           actions: const <Widget>[
//             // IconButton(
//             //   icon: const Icon(
//             //     Icons.filter_alt_outlined,
//             //     color: Colors.white,
//             //   ),
//             //   onPressed: () {
//             //     // openDailogTotalOrderPending();
//             //     // do something
//             //   },
//             // )
//           ],
//         ),
//         body: ChangeNotifierProvider<IniciatedCancelWorkForApprovalViewModel>(
//             create: (BuildContext context) =>
//                 iniciatedCancelWorkForApprovalViewModel,
//             child: Consumer<IniciatedCancelWorkForApprovalViewModel>(
//                 builder: (context, value, _) {
//               switch (value.iniciatedCancelWorkApprovalTabularData.status) {
//                 case Status.LOADING:
//                   return const Center(child: CircularProgressIndicator());
//                 case Status.ERROR:
//                   return
//                       // CustomToastSnackBarProgressDialog.flushBarErrorMessage(
//                       //     value.iniciatedCancelWorkApprovalTabularData.message.toString(),
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
//                       selectedSubstation = null;
//                       selectedFeeder = null;
//                       await getContractorData();
//                       _initializeScreen();
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
//                                 color: Color.fromARGB(255, 7, 59, 120),
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
//                           Padding(
//                             padding: const EdgeInsets.only(top: 8.0),
//                             child: Align(
//                               alignment: Alignment.bottomLeft,
//                               child: Text(
//                                 "TOTAL NO OF RECORDS : ${iniciatedCancelWorkForApprovalViewModel.iniciatedCancelWorkApprovalTabularData.data!.data!.length.toString()}",
//                                 style: const TextStyle(
//                                     fontSize: 16,
//                                     color: Color.fromARGB(255, 7, 59, 120),
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
//                                               Color.fromARGB(255, 7, 59, 120),
//                                           fontSize: 16),
//                                       obscureText: false,

//                                       // keyboardType: TextInputType.number,
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
//                                 itemCount:
//                                     iniciatedCancelWorkForApprovalViewModel
//                                         .iniciatedCancelWorkApprovalTabularData
//                                         .data!
//                                         .data!
//                                         .length,
//                                 itemBuilder: (BuildContext ctxt, int index) {
//                                   String formattedDateCreateDate = '';
//                                   if (iniciatedCancelWorkForApprovalViewModel
//                                           .iniciatedCancelWorkApprovalTabularData
//                                           .data!
//                                           .data![index]
//                                           .createDate
//                                           .toString() !=
//                                       'N/A') {
//                                     String? dateStringCreateDate =
//                                         iniciatedCancelWorkForApprovalViewModel
//                                             .iniciatedCancelWorkApprovalTabularData
//                                             .data!
//                                             .data![index]
//                                             .createDate
//                                             .toString();
//                                     DateTime date =
//                                         DateTime.parse(dateStringCreateDate);
//                                     formattedDateCreateDate =
//                                         DateFormat('MM/dd/yyyy').format(date);
//                                     newDateFormat(index);
//                                   }
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
//                                           padding: const EdgeInsets.all(8),
//                                           decoration: BoxDecoration(
//                                               color: const Color.fromARGB(
//                                                   255, 7, 59, 120),
//                                               border: Border.all(
//                                                 color: Colors.white,
//                                               ),
//                                               borderRadius:
//                                                   const BorderRadius.only(
//                                                 topRight: Radius.circular(10),
//                                                 bottomRight:
//                                                     Radius.circular(10),
//                                                 topLeft: Radius.circular(10),
//                                                 bottomLeft: Radius.circular(10),
//                                               )),
//                                           child: Column(children: [
//                                             Padding(
//                                               padding: const EdgeInsets.only(
//                                                   left: 8.0),
//                                               child: Row(
//                                                 children: [
//                                                   Expanded(
//                                                       child: Column(
//                                                     children: [
//                                                       const Align(
//                                                         alignment:
//                                                             Alignment.topLeft,
//                                                         child: Text(
//                                                           "VIEW: ",
//                                                           textAlign:
//                                                               TextAlign.left,
//                                                           style: TextStyle(
//                                                             fontSize: 12,
//                                                             fontWeight:
//                                                                 FontWeight.bold,
//                                                             color: Colors.white,
//                                                           ),
//                                                         ),
//                                                       ),
//                                                       InkWell(
//                                                         onTap: () {
//                                                           Navigator.push(
//                                                               context,
//                                                               MaterialPageRoute(
//                                                                   builder: (context) => ViewChangeOrder(
//                                                                       orderNo: (iniciatedCancelWorkForApprovalViewModel.iniciatedCancelWorkApprovalTabularData.data!.data![index].tokenNo == null || iniciatedCancelWorkForApprovalViewModel.iniciatedCancelWorkApprovalTabularData.data!.data![index].tokenNo == 'N/A')
//                                                                           ? ''
//                                                                           : iniciatedCancelWorkForApprovalViewModel.iniciatedCancelWorkApprovalTabularData.data!.data![index].tokenNo
//                                                                               .toString(),
//                                                                       substation: (iniciatedCancelWorkForApprovalViewModel.iniciatedCancelWorkApprovalTabularData.data!.data![index].substation == null)
//                                                                           ? ''
//                                                                           : iniciatedCancelWorkForApprovalViewModel.iniciatedCancelWorkApprovalTabularData.data!.data![index].substation
//                                                                               .toString(),
//                                                                       feeder: (iniciatedCancelWorkForApprovalViewModel.iniciatedCancelWorkApprovalTabularData.data!.data![index].feeder == null)
//                                                                           ? ''
//                                                                           : iniciatedCancelWorkForApprovalViewModel.iniciatedCancelWorkApprovalTabularData.data!.data![index].feeder
//                                                                               .toString(),
//                                                                       maintenanceType: (iniciatedCancelWorkForApprovalViewModel.iniciatedCancelWorkApprovalTabularData.data!.data![index].maintType == null)
//                                                                           ? ''
//                                                                           : iniciatedCancelWorkForApprovalViewModel.iniciatedCancelWorkApprovalTabularData.data!.data![index].maintType
//                                                                               .toString(),
//                                                                       totalMiles:
//                                                                           (iniciatedCancelWorkForApprovalViewModel.iniciatedCancelWorkApprovalTabularData.data!.data![index].totalMiles == null)
//                                                                               ? ''
//                                                                               : iniciatedCancelWorkForApprovalViewModel.iniciatedCancelWorkApprovalTabularData.data!.data![index].totalMiles.toString(),
//                                                                       costPerMile: (iniciatedCancelWorkForApprovalViewModel.iniciatedCancelWorkApprovalTabularData.data!.data![index].costPerMile == null) ? '' : iniciatedCancelWorkForApprovalViewModel.iniciatedCancelWorkApprovalTabularData.data!.data![index].costPerMile.toString(),
//                                                                       totalCost: (iniciatedCancelWorkForApprovalViewModel.iniciatedCancelWorkApprovalTabularData.data!.data![index].totalCost == null) ? '' : iniciatedCancelWorkForApprovalViewModel.iniciatedCancelWorkApprovalTabularData.data!.data![index].totalCost.toString(),
//                                                                       type: (iniciatedCancelWorkForApprovalViewModel.iniciatedCancelWorkApprovalTabularData.data!.data![index].type == null) ? '' : iniciatedCancelWorkForApprovalViewModel.iniciatedCancelWorkApprovalTabularData.data!.data![index].type.toString(),
//                                                                       contractYear: (iniciatedCancelWorkForApprovalViewModel.iniciatedCancelWorkApprovalTabularData.data!.data![index].contractYear == null) ? '' : iniciatedCancelWorkForApprovalViewModel.iniciatedCancelWorkApprovalTabularData.data!.data![index].contractYear.toString(),
//                                                                       cycle: (iniciatedCancelWorkForApprovalViewModel.iniciatedCancelWorkApprovalTabularData.data!.data![index].cycle == null) ? '' : iniciatedCancelWorkForApprovalViewModel.iniciatedCancelWorkApprovalTabularData.data!.data![index].cycle.toString(),
//                                                                       nextMaintDue: (iniciatedCancelWorkForApprovalViewModel.iniciatedCancelWorkApprovalTabularData.data!.data![index].nextMaintDue == null) ? '' : iniciatedCancelWorkForApprovalViewModel.iniciatedCancelWorkApprovalTabularData.data!.data![index].nextMaintDue.toString(),
//                                                                       contractor: (iniciatedCancelWorkForApprovalViewModel.iniciatedCancelWorkApprovalTabularData.data!.data![index].contractor == null) ? '' : iniciatedCancelWorkForApprovalViewModel.iniciatedCancelWorkApprovalTabularData.data!.data![index].contractor.toString(),
//                                                                       contractorCompany: (iniciatedCancelWorkForApprovalViewModel.iniciatedCancelWorkApprovalTabularData.data!.data![index].contractorCompany == null) ? '' : iniciatedCancelWorkForApprovalViewModel.iniciatedCancelWorkApprovalTabularData.data!.data![index].contractorCompany.toString(),
//                                                                       status: (iniciatedCancelWorkForApprovalViewModel.iniciatedCancelWorkApprovalTabularData.data!.data![index].status == null || iniciatedCancelWorkForApprovalViewModel.iniciatedCancelWorkApprovalTabularData.data!.data![index].status == 'N/A') ? '' : iniciatedCancelWorkForApprovalViewModel.iniciatedCancelWorkApprovalTabularData.data!.data![index].status.toString(),
//                                                                       dailyHerbicideApplication: '',
//                                                                       ivmTimesheet: '',
//                                                                       mixingInventory: '',
//                                                                       serviceStreetAddress: (iniciatedCancelWorkForApprovalViewModel.iniciatedCancelWorkApprovalTabularData.data!.data![index].streetAddress == null) ? '' : iniciatedCancelWorkForApprovalViewModel.iniciatedCancelWorkApprovalTabularData.data!.data![index].streetAddress.toString(),
//                                                                       serviceMapLocation: (iniciatedCancelWorkForApprovalViewModel.iniciatedCancelWorkApprovalTabularData.data!.data![index].mapLocation == null) ? '' : iniciatedCancelWorkForApprovalViewModel.iniciatedCancelWorkApprovalTabularData.data!.data![index].mapLocation.toString(),
//                                                                       adminNotes1: (iniciatedCancelWorkForApprovalViewModel.iniciatedCancelWorkApprovalTabularData.data!.data![index].adminNotes1 == null) ? '' : iniciatedCancelWorkForApprovalViewModel.iniciatedCancelWorkApprovalTabularData.data!.data![index].adminNotes1.toString(),
//                                                                       dateOfInspection: (iniciatedCancelWorkForApprovalViewModel.iniciatedCancelWorkApprovalTabularData.data!.data![index].dateOfInspection == null) ? '' : iniciatedCancelWorkForApprovalViewModel.iniciatedCancelWorkApprovalTabularData.data!.data![index].dateOfInspection.toString(),
//                                                                       followUpDate: (iniciatedCancelWorkForApprovalViewModel.iniciatedCancelWorkApprovalTabularData.data!.data![index].followUpDate == null) ? '' : iniciatedCancelWorkForApprovalViewModel.iniciatedCancelWorkApprovalTabularData.data!.data![index].followUpDate.toString(),
//                                                                       createDate: (iniciatedCancelWorkForApprovalViewModel.iniciatedCancelWorkApprovalTabularData.data!.data![index].createDate == null) ? '' : iniciatedCancelWorkForApprovalViewModel.iniciatedCancelWorkApprovalTabularData.data!.data![index].createDate.toString())));
//                                                         },
//                                                         child: const Align(
//                                                           alignment:
//                                                               Alignment.topLeft,
//                                                           child: Icon(
//                                                             Icons
//                                                                 .remove_red_eye_outlined,
//                                                             color: Colors.red,
//                                                           ),
//                                                         ),
//                                                       ),
//                                                     ],
//                                                   )),
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
//                                                         Align(
//                                                           alignment:
//                                                               Alignment.topLeft,
//                                                           child: InkWell(
//                                                             onTap: () async {
//                                                               await iniciatedCancelWorkForApprovalViewModel
//                                                                   .fetchImageApi(
//                                                                 context,
//                                                                 iniciatedCancelWorkForApprovalViewModel
//                                                                     .iniciatedCancelWorkApprovalTabularData
//                                                                     .data!
//                                                                     .data![
//                                                                         index]
//                                                                     .id
//                                                                     .toString(),
//                                                               );
//                                                               await Future.delayed(
//                                                                   const Duration(
//                                                                       seconds:
//                                                                           2));
//                                                               openDialogPicture(
//                                                                   iniciatedCancelWorkForApprovalViewModel
//                                                                       .iniciatedCancelWorkApprovalTabularData
//                                                                       .data!
//                                                                       .data![
//                                                                           index]
//                                                                       .id
//                                                                       .toString());
//                                                             },
//                                                             child: const Align(
//                                                                 alignment:
//                                                                     Alignment
//                                                                         .topLeft,
//                                                                 child: Icon(
//                                                                   Icons.image,
//                                                                   color: Colors
//                                                                       .blue,
//                                                                 )),
//                                                           ),
//                                                         )
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
//                                                             (iniciatedCancelWorkForApprovalViewModel
//                                                                             .iniciatedCancelWorkApprovalTabularData
//                                                                             .data!
//                                                                             .data![
//                                                                                 index]
//                                                                             .maintType ==
//                                                                         null ||
//                                                                     iniciatedCancelWorkForApprovalViewModel
//                                                                             .iniciatedCancelWorkApprovalTabularData
//                                                                             .data!
//                                                                             .data![
//                                                                                 index]
//                                                                             .maintType
//                                                                             .toString() ==
//                                                                         'null')
//                                                                 ? ''
//                                                                 : iniciatedCancelWorkForApprovalViewModel
//                                                                     .iniciatedCancelWorkApprovalTabularData
//                                                                     .data!
//                                                                     .data![
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
//                                                             (iniciatedCancelWorkForApprovalViewModel
//                                                                             .iniciatedCancelWorkApprovalTabularData
//                                                                             .data!
//                                                                             .data![
//                                                                                 index]
//                                                                             .tokenNo ==
//                                                                         null ||
//                                                                     iniciatedCancelWorkForApprovalViewModel
//                                                                             .iniciatedCancelWorkApprovalTabularData
//                                                                             .data!
//                                                                             .data![
//                                                                                 index]
//                                                                             .tokenNo
//                                                                             .toString() ==
//                                                                         'null')
//                                                                 ? ''
//                                                                 : iniciatedCancelWorkForApprovalViewModel
//                                                                     .iniciatedCancelWorkApprovalTabularData
//                                                                     .data!
//                                                                     .data![
//                                                                         index]
//                                                                     .tokenNo
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
//                                                             (iniciatedCancelWorkForApprovalViewModel
//                                                                             .iniciatedCancelWorkApprovalTabularData
//                                                                             .data!
//                                                                             .data![
//                                                                                 index]
//                                                                             .status ==
//                                                                         null ||
//                                                                     iniciatedCancelWorkForApprovalViewModel
//                                                                             .iniciatedCancelWorkApprovalTabularData
//                                                                             .data!
//                                                                             .data![
//                                                                                 index]
//                                                                             .status
//                                                                             .toString() ==
//                                                                         'null')
//                                                                 ? ''
//                                                                 : iniciatedCancelWorkForApprovalViewModel
//                                                                     .iniciatedCancelWorkApprovalTabularData
//                                                                     .data!
//                                                                     .data![
//                                                                         index]
//                                                                     .status
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

//                                                         // (iniciatedCancelWorkForApprovalViewModel
//                                                         //             .iniciatedCancelWorkApprovalTabularData
//                                                         //             .data!
//                                                         //             .data![
//                                                         //                 index]
//                                                         //             .maintType ==
//                                                         //         'RegularMaint')
//                                                         //     ? Align(
//                                                         //         alignment:
//                                                         //             Alignment
//                                                         //                 .topLeft,
//                                                         //         child: Text(
//                                                         //           (iniciatedCancelWorkForApprovalViewModel.iniciatedCancelWorkApprovalTabularData.data!.data![index].status ==
//                                                         //                       null ||
//                                                         //                   iniciatedCancelWorkForApprovalViewModel.iniciatedCancelWorkApprovalTabularData.data!.data![index].status.toString() ==
//                                                         //                       'null')
//                                                         //               ? ''
//                                                         //               : iniciatedCancelWorkForApprovalViewModel
//                                                         //                   .iniciatedCancelWorkApprovalTabularData
//                                                         //                   .data!
//                                                         //                   .data![
//                                                         //                       index]
//                                                         //                   .status
//                                                         //                   .toString(),
//                                                         //           textAlign:
//                                                         //               TextAlign
//                                                         //                   .left,
//                                                         //           style:
//                                                         //               const TextStyle(
//                                                         //             fontSize:
//                                                         //                 12,
//                                                         //             color: Colors
//                                                         //                 .white,
//                                                         //           ),
//                                                         //         ),
//                                                         //       )
//                                                         //     : InkWell(
//                                                         //         onTap: () {
//                                                         //           openDailogPendingApproval(iniciatedCancelWorkForApprovalViewModel
//                                                         //               .iniciatedCancelWorkApprovalTabularData
//                                                         //               .data!
//                                                         //               .data![
//                                                         //                   index]
//                                                         //               .id
//                                                         //               .toString());
//                                                         //         },
//                                                         //         child: Align(
//                                                         //           alignment:
//                                                         //               Alignment
//                                                         //                   .centerLeft,
//                                                         //           child:
//                                                         //               Container(
//                                                         //             // margin: const EdgeInsets.only(
//                                                         //             //     left: 40, right: 40, bottom: 10.0),
//                                                         //             padding:
//                                                         //                 const EdgeInsets
//                                                         //                     .all(
//                                                         //                     8),
//                                                         //             alignment:
//                                                         //                 Alignment
//                                                         //                     .centerLeft,
//                                                         //             width: 80,
//                                                         //             // MediaQuery.of(context).size.width,
//                                                         //             // height: MediaQuery.of(context).size.height * 0.4,
//                                                         //             decoration: BoxDecoration(
//                                                         //                 // shape: BoxShape.circle,
//                                                         //                 color: const Color.fromARGB(255, 122, 12, 4),
//                                                         //                 gradient: (iniciatedCancelWorkForApprovalViewModel.iniciatedCancelWorkApprovalTabularData.data!.data![index].status == 'REJECTED')
//                                                         //                     ? const LinearGradient(
//                                                         //                         colors: [
//                                                         //                           Colors.red,
//                                                         //                           Colors.red
//                                                         //                         ],
//                                                         //                       )
//                                                         //                     : const LinearGradient(
//                                                         //                         colors: [
//                                                         //                           Color.fromARGB(255, 0, 79, 215),
//                                                         //                           Colors.blue,
//                                                         //                           Color.fromARGB(255, 0, 79, 215),
//                                                         //                         ],
//                                                         //                       )),
//                                                         //             child:
//                                                         //                 Align(
//                                                         //               alignment:
//                                                         //                   Alignment
//                                                         //                       .center,
//                                                         //               child:
//                                                         //                   Text(
//                                                         //                 (iniciatedCancelWorkForApprovalViewModel.iniciatedCancelWorkApprovalTabularData.data!.data![index].status == null ||
//                                                         //                         iniciatedCancelWorkForApprovalViewModel.iniciatedCancelWorkApprovalTabularData.data!.data![index].status.toString() == 'null')
//                                                         //                     ? ''
//                                                         //                     : iniciatedCancelWorkForApprovalViewModel.iniciatedCancelWorkApprovalTabularData.data!.data![index].status.toString(),
//                                                         //                 style:
//                                                         //                     const TextStyle(
//                                                         //                   color:
//                                                         //                       Colors.white,
//                                                         //                   fontWeight:
//                                                         //                       FontWeight.bold,
//                                                         //                   fontSize:
//                                                         //                       10,
//                                                         //                 ),
//                                                         //               ),
//                                                         //             ),
//                                                         //           ),
//                                                         //         ),
//                                                         // )
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
//                                                             (iniciatedCancelWorkForApprovalViewModel
//                                                                             .iniciatedCancelWorkApprovalTabularData
//                                                                             .data!
//                                                                             .data![
//                                                                                 index]
//                                                                             .substation ==
//                                                                         null ||
//                                                                     iniciatedCancelWorkForApprovalViewModel
//                                                                             .iniciatedCancelWorkApprovalTabularData
//                                                                             .data!
//                                                                             .data![
//                                                                                 index]
//                                                                             .substation
//                                                                             .toString() ==
//                                                                         'null')
//                                                                 ? ''
//                                                                 : iniciatedCancelWorkForApprovalViewModel
//                                                                     .iniciatedCancelWorkApprovalTabularData
//                                                                     .data!
//                                                                     .data![
//                                                                         index]
//                                                                     .substation
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
//                                                             (iniciatedCancelWorkForApprovalViewModel
//                                                                             .iniciatedCancelWorkApprovalTabularData
//                                                                             .data!
//                                                                             .data![
//                                                                                 index]
//                                                                             .feeder ==
//                                                                         null ||
//                                                                     iniciatedCancelWorkForApprovalViewModel
//                                                                             .iniciatedCancelWorkApprovalTabularData
//                                                                             .data!
//                                                                             .data![
//                                                                                 index]
//                                                                             .feeder
//                                                                             .toString() ==
//                                                                         'null')
//                                                                 ? ''
//                                                                 : iniciatedCancelWorkForApprovalViewModel
//                                                                     .iniciatedCancelWorkApprovalTabularData
//                                                                     .data!
//                                                                     .data![
//                                                                         index]
//                                                                     .feeder
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
//                                                             (iniciatedCancelWorkForApprovalViewModel
//                                                                             .iniciatedCancelWorkApprovalTabularData
//                                                                             .data!
//                                                                             .data![
//                                                                                 index]
//                                                                             .contractorCompany ==
//                                                                         null ||
//                                                                     iniciatedCancelWorkForApprovalViewModel
//                                                                             .iniciatedCancelWorkApprovalTabularData
//                                                                             .data!
//                                                                             .data![
//                                                                                 index]
//                                                                             .contractorCompany
//                                                                             .toString() ==
//                                                                         'null')
//                                                                 ? ''
//                                                                 : iniciatedCancelWorkForApprovalViewModel
//                                                                     .iniciatedCancelWorkApprovalTabularData
//                                                                     .data!
//                                                                     .data![
//                                                                         index]
//                                                                     .contractorCompany
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

//                                                   // Expanded(
//                                                   //   // alignment: Alignment.topLeft,
//                                                   //   child: Column(
//                                                   //     children: [
//                                                   //       const Align(
//                                                   //         alignment:
//                                                   //             Alignment.topLeft,
//                                                   //         child: Text(
//                                                   //           "MAINTENANCE TYPE: ",
//                                                   //           textAlign:
//                                                   //               TextAlign.left,
//                                                   //           style: TextStyle(
//                                                   //             fontSize: 12,
//                                                   //             fontWeight:
//                                                   //                 FontWeight
//                                                   //                     .bold,
//                                                   //             color:
//                                                   //                 Colors.white,
//                                                   //           ),
//                                                   //         ),
//                                                   //       ),
//                                                   //       Align(
//                                                   //         alignment:
//                                                   //             Alignment.topLeft,
//                                                   //         child: Text(
//                                                   //           (iniciatedCancelWorkForApprovalViewModel
//                                                   //                           .iniciatedCancelWorkApprovalTabularData
//                                                   //                           .data!
//                                                   //                           .data![
//                                                   //                               index]
//                                                   //                           .type ==
//                                                   //                       null ||
//                                                   //                   iniciatedCancelWorkForApprovalViewModel
//                                                   //                           .iniciatedCancelWorkApprovalTabularData
//                                                   //                           .data!
//                                                   //                           .data![
//                                                   //                               index]
//                                                   //                           .type
//                                                   //                           .toString() ==
//                                                   //                       'null')
//                                                   //               ? ''
//                                                   //               : iniciatedCancelWorkForApprovalViewModel
//                                                   //                   .iniciatedCancelWorkApprovalTabularData
//                                                   //                   .data!
//                                                   //                   .data![
//                                                   //                       index]
//                                                   //                   .type
//                                                   //                   .toString(),
//                                                   //           textAlign:
//                                                   //               TextAlign.left,
//                                                   //           style:
//                                                   //               const TextStyle(
//                                                   //             fontSize: 12,
//                                                   //             //  fontWeight:
//                                                   //             //      FontWeight.bold,
//                                                   //             color:
//                                                   //                 Colors.white,
//                                                   //           ),
//                                                   //         ),
//                                                   //       ),
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
//                                                             (iniciatedCancelWorkForApprovalViewModel
//                                                                             .iniciatedCancelWorkApprovalTabularData
//                                                                             .data!
//                                                                             .data![
//                                                                                 index]
//                                                                             .contractor ==
//                                                                         null ||
//                                                                     iniciatedCancelWorkForApprovalViewModel
//                                                                             .iniciatedCancelWorkApprovalTabularData
//                                                                             .data!
//                                                                             .data![
//                                                                                 index]
//                                                                             .contractor
//                                                                             .toString() ==
//                                                                         'null')
//                                                                 ? ''
//                                                                 : iniciatedCancelWorkForApprovalViewModel
//                                                                     .iniciatedCancelWorkApprovalTabularData
//                                                                     .data!
//                                                                     .data![
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
//                                             const Padding(
//                                               padding:
//                                                   EdgeInsets.only(left: 8.0),
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
//                                                   //           "TOTAL MILES: ",
//                                                   //           textAlign:
//                                                   //               TextAlign.left,
//                                                   //           style: TextStyle(
//                                                   //             fontSize: 12,
//                                                   //             fontWeight:
//                                                   //                 FontWeight
//                                                   //                     .bold,
//                                                   //             color:
//                                                   //                 Colors.white,
//                                                   //           ),
//                                                   //         ),
//                                                   //       ),
//                                                   //       Align(
//                                                   //         alignment:
//                                                   //             Alignment.topLeft,
//                                                   //         child: Text(
//                                                   //           (iniciatedCancelWorkForApprovalViewModel
//                                                   //                           .iniciatedCancelWorkApprovalTabularData
//                                                   //                           .data!
//                                                   //                           .data![
//                                                   //                               index]
//                                                   //                           .totalMiles ==
//                                                   //                       null ||
//                                                   //                   iniciatedCancelWorkForApprovalViewModel
//                                                   //                           .iniciatedCancelWorkApprovalTabularData
//                                                   //                           .data!
//                                                   //                           .data![
//                                                   //                               index]
//                                                   //                           .totalMiles
//                                                   //                           .toString() ==
//                                                   //                       'null')
//                                                   //               ? ''
//                                                   //               : iniciatedCancelWorkForApprovalViewModel
//                                                   //                   .iniciatedCancelWorkApprovalTabularData
//                                                   //                   .data!
//                                                   //                   .data![
//                                                   //                       index]
//                                                   //                   .totalMiles
//                                                   //                   .toString(),
//                                                   //           textAlign:
//                                                   //               TextAlign.left,
//                                                   //           style:
//                                                   //               const TextStyle(
//                                                   //             fontSize: 12,
//                                                   //             //  fontWeight:
//                                                   //             //      FontWeight.bold,
//                                                   //             color:
//                                                   //                 Colors.white,
//                                                   //           ),
//                                                   //         ),
//                                                   //       ),
//                                                   //     ],
//                                                   //   ),
//                                                   // ),

//                                                   // Expanded(
//                                                   //   // alignment: Alignment.topLeft,
//                                                   //   child: Column(
//                                                   //     children: [
//                                                   //       const Align(
//                                                   //         alignment:
//                                                   //             Alignment.topLeft,
//                                                   //         child: Text(
//                                                   //           "CONTRACT YEAR: ",
//                                                   //           textAlign:
//                                                   //               TextAlign.left,
//                                                   //           style: TextStyle(
//                                                   //             fontSize: 12,
//                                                   //             fontWeight:
//                                                   //                 FontWeight
//                                                   //                     .bold,
//                                                   //             color:
//                                                   //                 Colors.white,
//                                                   //           ),
//                                                   //         ),
//                                                   //       ),
//                                                   //       Align(
//                                                   //         alignment:
//                                                   //             Alignment.topLeft,
//                                                   //         child: Text(
//                                                   //           (iniciatedCancelWorkForApprovalViewModel
//                                                   //                           .iniciatedCancelWorkApprovalTabularData
//                                                   //                           .data!
//                                                   //                           .data![
//                                                   //                               index]
//                                                   //                           .contractYear ==
//                                                   //                       null ||
//                                                   //                   iniciatedCancelWorkForApprovalViewModel
//                                                   //                           .iniciatedCancelWorkApprovalTabularData
//                                                   //                           .data!
//                                                   //                           .data![index]
//                                                   //                           .contractYear
//                                                   //                           .toString() ==
//                                                   //                       'null')
//                                                   //               ? ''
//                                                   //               : formattedContractYear,
//                                                   //           textAlign:
//                                                   //               TextAlign.left,
//                                                   //           style:
//                                                   //               const TextStyle(
//                                                   //             fontSize: 12,
//                                                   //             //  fontWeight:
//                                                   //             //      FontWeight.bold,
//                                                   //             color:
//                                                   //                 Colors.white,
//                                                   //           ),
//                                                   //         ),
//                                                   //       ),
//                                                   //     ],
//                                                   //   ),
//                                                   // ),
//                                                 ],
//                                               ),
//                                             ),
//                                             (widget.heading ==
//                                                     'Total Order Rejected (Change Order)')
//                                                 ? Column(
//                                                     children: [
//                                                       const Divider(
//                                                         color: Colors.grey,
//                                                       ),
//                                                       Padding(
//                                                         padding:
//                                                             const EdgeInsets
//                                                                 .only(
//                                                                 left: 8.0),
//                                                         child: Row(
//                                                           children: [
//                                                             Expanded(
//                                                               // alignment: Alignment.topLeft,
//                                                               child: Column(
//                                                                 children: [
//                                                                   const Align(
//                                                                     alignment:
//                                                                         Alignment
//                                                                             .topLeft,
//                                                                     child: Text(
//                                                                       "SERVICE STREET ADDRESS: ",
//                                                                       textAlign:
//                                                                           TextAlign
//                                                                               .left,
//                                                                       style:
//                                                                           TextStyle(
//                                                                         fontSize:
//                                                                             12,
//                                                                         fontWeight:
//                                                                             FontWeight.bold,
//                                                                         color: Colors
//                                                                             .white,
//                                                                       ),
//                                                                     ),
//                                                                   ),
//                                                                   Align(
//                                                                     alignment:
//                                                                         Alignment
//                                                                             .topLeft,
//                                                                     child: Text(
//                                                                       (iniciatedCancelWorkForApprovalViewModel.iniciatedCancelWorkApprovalTabularData.data!.data![index].streetAddress == null ||
//                                                                               iniciatedCancelWorkForApprovalViewModel.iniciatedCancelWorkApprovalTabularData.data!.data![index].streetAddress.toString() ==
//                                                                                   'null')
//                                                                           ? ''
//                                                                           : iniciatedCancelWorkForApprovalViewModel
//                                                                               .iniciatedCancelWorkApprovalTabularData
//                                                                               .data!
//                                                                               .data![index]
//                                                                               .streetAddress
//                                                                               .toString(),
//                                                                       textAlign:
//                                                                           TextAlign
//                                                                               .left,
//                                                                       style:
//                                                                           const TextStyle(
//                                                                         fontSize:
//                                                                             12,
//                                                                         //  fontWeight:
//                                                                         //      FontWeight.bold,
//                                                                         color: Colors
//                                                                             .white,
//                                                                       ),
//                                                                     ),
//                                                                   ),
//                                                                 ],
//                                                               ),
//                                                             ),
//                                                             Expanded(
//                                                               // alignment: Alignment.topLeft,
//                                                               child: Column(
//                                                                 children: [
//                                                                   const Align(
//                                                                     alignment:
//                                                                         Alignment
//                                                                             .topLeft,
//                                                                     child: Text(
//                                                                       "SERVICE MAP LOCATION: ",
//                                                                       textAlign:
//                                                                           TextAlign
//                                                                               .left,
//                                                                       style:
//                                                                           TextStyle(
//                                                                         fontSize:
//                                                                             12,
//                                                                         fontWeight:
//                                                                             FontWeight.bold,
//                                                                         color: Colors
//                                                                             .white,
//                                                                       ),
//                                                                     ),
//                                                                   ),
//                                                                   Align(
//                                                                     alignment:
//                                                                         Alignment
//                                                                             .topLeft,
//                                                                     child: Text(
//                                                                       (iniciatedCancelWorkForApprovalViewModel.iniciatedCancelWorkApprovalTabularData.data!.data![index].mapLocation == null ||
//                                                                               iniciatedCancelWorkForApprovalViewModel.iniciatedCancelWorkApprovalTabularData.data!.data![index].mapLocation.toString() ==
//                                                                                   'null')
//                                                                           ? ''
//                                                                           : iniciatedCancelWorkForApprovalViewModel
//                                                                               .iniciatedCancelWorkApprovalTabularData
//                                                                               .data!
//                                                                               .data![index]
//                                                                               .mapLocation
//                                                                               .toString(),
//                                                                       textAlign:
//                                                                           TextAlign
//                                                                               .left,
//                                                                       style:
//                                                                           const TextStyle(
//                                                                         fontSize:
//                                                                             12,
//                                                                         //  fontWeight:
//                                                                         //      FontWeight.bold,
//                                                                         color: Colors
//                                                                             .white,
//                                                                       ),
//                                                                     ),
//                                                                   ),
//                                                                 ],
//                                                               ),
//                                                             ),
//                                                             Expanded(
//                                                               // alignment: Alignment.topLeft,
//                                                               child: Column(
//                                                                 children: [
//                                                                   const Align(
//                                                                     alignment:
//                                                                         Alignment
//                                                                             .topLeft,
//                                                                     child: Text(
//                                                                       "ADMIN NOTES 1: ",
//                                                                       textAlign:
//                                                                           TextAlign
//                                                                               .left,
//                                                                       style:
//                                                                           TextStyle(
//                                                                         fontSize:
//                                                                             12,
//                                                                         fontWeight:
//                                                                             FontWeight.bold,
//                                                                         color: Colors
//                                                                             .white,
//                                                                       ),
//                                                                     ),
//                                                                   ),
//                                                                   Align(
//                                                                     alignment:
//                                                                         Alignment
//                                                                             .topLeft,
//                                                                     child: Text(
//                                                                       (iniciatedCancelWorkForApprovalViewModel.iniciatedCancelWorkApprovalTabularData.data!.data![index].adminNotes1 == null ||
//                                                                               iniciatedCancelWorkForApprovalViewModel.iniciatedCancelWorkApprovalTabularData.data!.data![index].adminNotes1.toString() ==
//                                                                                   'null')
//                                                                           ? ''
//                                                                           : iniciatedCancelWorkForApprovalViewModel
//                                                                               .iniciatedCancelWorkApprovalTabularData
//                                                                               .data!
//                                                                               .data![index]
//                                                                               .adminNotes1
//                                                                               .toString(),
//                                                                       textAlign:
//                                                                           TextAlign
//                                                                               .left,
//                                                                       style:
//                                                                           const TextStyle(
//                                                                         fontSize:
//                                                                             12,
//                                                                         //  fontWeight:
//                                                                         //      FontWeight.bold,
//                                                                         color: Colors
//                                                                             .white,
//                                                                       ),
//                                                                     ),
//                                                                   ),
//                                                                 ],
//                                                               ),
//                                                             ),
//                                                           ],
//                                                         ),
//                                                       ),
//                                                       const Divider(
//                                                         color: Colors.grey,
//                                                       ),
//                                                       Padding(
//                                                         padding:
//                                                             const EdgeInsets
//                                                                 .only(
//                                                                 left: 8.0),
//                                                         child: Row(
//                                                           children: [
//                                                             Expanded(
//                                                               // alignment: Alignment.topLeft,
//                                                               child: Column(
//                                                                 children: [
//                                                                   const Align(
//                                                                     alignment:
//                                                                         Alignment
//                                                                             .topLeft,
//                                                                     child: Text(
//                                                                       "ESTIMATED TIME: ",
//                                                                       textAlign:
//                                                                           TextAlign
//                                                                               .left,
//                                                                       style:
//                                                                           TextStyle(
//                                                                         fontSize:
//                                                                             12,
//                                                                         fontWeight:
//                                                                             FontWeight.bold,
//                                                                         color: Colors
//                                                                             .white,
//                                                                       ),
//                                                                     ),
//                                                                   ),
//                                                                   Align(
//                                                                     alignment:
//                                                                         Alignment
//                                                                             .topLeft,
//                                                                     child: Text(
//                                                                       (iniciatedCancelWorkForApprovalViewModel.iniciatedCancelWorkApprovalTabularData.data!.data![index].estTime == null ||
//                                                                               iniciatedCancelWorkForApprovalViewModel.iniciatedCancelWorkApprovalTabularData.data!.data![index].estTime.toString() ==
//                                                                                   'null')
//                                                                           ? ''
//                                                                           : iniciatedCancelWorkForApprovalViewModel
//                                                                               .iniciatedCancelWorkApprovalTabularData
//                                                                               .data!
//                                                                               .data![index]
//                                                                               .estTime
//                                                                               .toString(),
//                                                                       textAlign:
//                                                                           TextAlign
//                                                                               .left,
//                                                                       style:
//                                                                           const TextStyle(
//                                                                         fontSize:
//                                                                             12,
//                                                                         color: Colors
//                                                                             .white,
//                                                                       ),
//                                                                     ),
//                                                                   ),
//                                                                 ],
//                                                               ),
//                                                             ),
//                                                             Expanded(
//                                                               // alignment: Alignment.topLeft,
//                                                               child: Column(
//                                                                 children: [
//                                                                   const Align(
//                                                                     alignment:
//                                                                         Alignment
//                                                                             .topLeft,
//                                                                     child: Text(
//                                                                       "DATE OF INSPECTION: ",
//                                                                       textAlign:
//                                                                           TextAlign
//                                                                               .left,
//                                                                       style:
//                                                                           TextStyle(
//                                                                         fontSize:
//                                                                             12,
//                                                                         fontWeight:
//                                                                             FontWeight.bold,
//                                                                         color: Colors
//                                                                             .white,
//                                                                       ),
//                                                                     ),
//                                                                   ),
//                                                                   Align(
//                                                                     alignment:
//                                                                         Alignment
//                                                                             .topLeft,
//                                                                     child: Text(
//                                                                       (iniciatedCancelWorkForApprovalViewModel.iniciatedCancelWorkApprovalTabularData.data!.data![index].dateOfInspection == null ||
//                                                                               iniciatedCancelWorkForApprovalViewModel.iniciatedCancelWorkApprovalTabularData.data!.data![index].dateOfInspection.toString() ==
//                                                                                   'null')
//                                                                           ? ''
//                                                                           : iniciatedCancelWorkForApprovalViewModel
//                                                                               .iniciatedCancelWorkApprovalTabularData
//                                                                               .data!
//                                                                               .data![index]
//                                                                               .dateOfInspection
//                                                                               .toString(),
//                                                                       textAlign:
//                                                                           TextAlign
//                                                                               .left,
//                                                                       style:
//                                                                           const TextStyle(
//                                                                         fontSize:
//                                                                             12,
//                                                                         //  fontWeight:
//                                                                         //      FontWeight.bold,
//                                                                         color: Colors
//                                                                             .white,
//                                                                       ),
//                                                                     ),
//                                                                   ),
//                                                                 ],
//                                                               ),
//                                                             ),
//                                                             Expanded(
//                                                               // alignment: Alignment.topLeft,
//                                                               child: Column(
//                                                                 children: [
//                                                                   const Align(
//                                                                     alignment:
//                                                                         Alignment
//                                                                             .topLeft,
//                                                                     child: Text(
//                                                                       "FOLLOW UP DATE: ",
//                                                                       textAlign:
//                                                                           TextAlign
//                                                                               .left,
//                                                                       style:
//                                                                           TextStyle(
//                                                                         fontSize:
//                                                                             12,
//                                                                         fontWeight:
//                                                                             FontWeight.bold,
//                                                                         color: Colors
//                                                                             .white,
//                                                                       ),
//                                                                     ),
//                                                                   ),
//                                                                   Align(
//                                                                     alignment:
//                                                                         Alignment
//                                                                             .topLeft,
//                                                                     child: Text(
//                                                                       (iniciatedCancelWorkForApprovalViewModel.iniciatedCancelWorkApprovalTabularData.data!.data![index].followUpDate == null ||
//                                                                               iniciatedCancelWorkForApprovalViewModel.iniciatedCancelWorkApprovalTabularData.data!.data![index].followUpDate.toString() ==
//                                                                                   'null')
//                                                                           ? ''
//                                                                           : iniciatedCancelWorkForApprovalViewModel
//                                                                               .iniciatedCancelWorkApprovalTabularData
//                                                                               .data!
//                                                                               .data![index]
//                                                                               .followUpDate
//                                                                               .toString(),
//                                                                       textAlign:
//                                                                           TextAlign
//                                                                               .left,
//                                                                       style:
//                                                                           const TextStyle(
//                                                                         fontSize:
//                                                                             12,
//                                                                         //  fontWeight:
//                                                                         //      FontWeight.bold,
//                                                                         color: Colors
//                                                                             .white,
//                                                                       ),
//                                                                     ),
//                                                                   ),
//                                                                 ],
//                                                               ),
//                                                             ),
//                                                           ],
//                                                         ),
//                                                       ),
//                                                     ],
//                                                   )
//                                                 : const Text(
//                                                     "",
//                                                     textAlign: TextAlign.left,
//                                                     style: TextStyle(
//                                                       fontSize: 0,
//                                                       fontWeight:
//                                                           FontWeight.bold,
//                                                       color: Colors.white,
//                                                     ),
//                                                   ),
//                                             // const Divider(
//                                             //   color: Colors.grey,
//                                             // ),
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
//                                                   //           "COST PER MILE: ",
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
//                                                   //       Align(
//                                                   //         alignment:
//                                                   //             Alignment.topLeft,
//                                                   //         child: Text(
//                                                   //           (iniciatedCancelWorkForApprovalViewModel
//                                                   //                           .iniciatedCancelWorkApprovalTabularData
//                                                   //                           .data!
//                                                   //                           .data![
//                                                   //                               index]
//                                                   //                           .costPerMile ==
//                                                   //                       null ||
//                                                   //                   iniciatedCancelWorkForApprovalViewModel
//                                                   //                           .iniciatedCancelWorkApprovalTabularData
//                                                   //                           .data!
//                                                   //                           .data![
//                                                   //                               index]
//                                                   //                           .costPerMile
//                                                   //                           .toString() ==
//                                                   //                       'null')
//                                                   //               ? ''
//                                                   //               : iniciatedCancelWorkForApprovalViewModel
//                                                   //                   .iniciatedCancelWorkApprovalTabularData
//                                                   //                   .data!
//                                                   //                   .data![
//                                                   //                       index]
//                                                   //                   .costPerMile
//                                                   //                   .toString(),
//                                                   //           textAlign:
//                                                   //               TextAlign.left,
//                                                   //           style:
//                                                   //               const TextStyle(
//                                                   //             fontSize: 12,
//                                                   //             //  fontWeight:
//                                                   //             //      FontWeight.bold,
//                                                   //             color: Colors.white,
//                                                   //           ),
//                                                   //         ),
//                                                   //       ),
//                                                   //     ],
//                                                   //   ),
//                                                   // ),
//                                                   // Expanded(
//                                                   //   // alignment: Alignment.topLeft,
//                                                   //   child: Column(
//                                                   //     children: [
//                                                   //       const Align(
//                                                   //         alignment:
//                                                   //             Alignment.topLeft,
//                                                   //         child: Text(
//                                                   //           "TOTAL COST: ",
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
//                                                   //       Align(
//                                                   //         alignment:
//                                                   //             Alignment.topLeft,
//                                                   //         child: Text(
//                                                   //           (iniciatedCancelWorkForApprovalViewModel
//                                                   //                           .iniciatedCancelWorkApprovalTabularData
//                                                   //                           .data!
//                                                   //                           .data![
//                                                   //                               index]
//                                                   //                           .totalCost ==
//                                                   //                       null ||
//                                                   //                   iniciatedCancelWorkForApprovalViewModel
//                                                   //                           .iniciatedCancelWorkApprovalTabularData
//                                                   //                           .data!
//                                                   //                           .data![
//                                                   //                               index]
//                                                   //                           .totalCost
//                                                   //                           .toString() ==
//                                                   //                       'null')
//                                                   //               ? ''
//                                                   //               : iniciatedCancelWorkForApprovalViewModel
//                                                   //                   .iniciatedCancelWorkApprovalTabularData
//                                                   //                   .data!
//                                                   //                   .data![
//                                                   //                       index]
//                                                   //                   .totalCost
//                                                   //                   .toString(),
//                                                   //           textAlign:
//                                                   //               TextAlign.left,
//                                                   //           style:
//                                                   //               const TextStyle(
//                                                   //             fontSize: 12,
//                                                   //             //  fontWeight:
//                                                   //             //      FontWeight.bold,
//                                                   //             color: Colors.white,
//                                                   //           ),
//                                                   //         ),
//                                                   //       ),
//                                                   //     ],
//                                                   //   ),
//                                                   // ),
//                                                   (widget.heading !=
//                                                           'Total Order Rejected (Change Order)')
//                                                       ? Expanded(
//                                                           // alignment: Alignment.topLeft,
//                                                           child: Column(
//                                                             children: [
//                                                               const Align(
//                                                                 alignment:
//                                                                     Alignment
//                                                                         .topLeft,
//                                                                 child: Text(
//                                                                   "CYCLE: ",
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
//                                                               Align(
//                                                                 alignment:
//                                                                     Alignment
//                                                                         .topLeft,
//                                                                 child: Text(
//                                                                   (iniciatedCancelWorkForApprovalViewModel.iniciatedCancelWorkApprovalTabularData.data!.data![index].cycle ==
//                                                                               null ||
//                                                                           iniciatedCancelWorkForApprovalViewModel.iniciatedCancelWorkApprovalTabularData.data!.data![index].cycle.toString() ==
//                                                                               'null')
//                                                                       ? ''
//                                                                       : iniciatedCancelWorkForApprovalViewModel
//                                                                           .iniciatedCancelWorkApprovalTabularData
//                                                                           .data!
//                                                                           .data![
//                                                                               index]
//                                                                           .cycle
//                                                                           .toString(),
//                                                                   textAlign:
//                                                                       TextAlign
//                                                                           .left,
//                                                                   style:
//                                                                       const TextStyle(
//                                                                     fontSize:
//                                                                         12,
//                                                                     //  fontWeight:
//                                                                     //      FontWeight.bold,
//                                                                     color: Colors
//                                                                         .white,
//                                                                   ),
//                                                                 ),
//                                                               ),
//                                                             ],
//                                                           ),
//                                                         )
//                                                       : const Text(
//                                                           "",
//                                                           textAlign:
//                                                               TextAlign.left,
//                                                           style: TextStyle(
//                                                             fontSize: 0,
//                                                             fontWeight:
//                                                                 FontWeight.bold,
//                                                             color: Colors.white,
//                                                           ),
//                                                         ),

//                                                   (widget.heading !=
//                                                           'Total Order Rejected (Change Order)')
//                                                       ? Expanded(
//                                                           // alignment: Alignment.topLeft,
//                                                           child: Column(
//                                                             children: [
//                                                               const Align(
//                                                                 alignment:
//                                                                     Alignment
//                                                                         .topLeft,
//                                                                 child: Text(
//                                                                   "NEXT MAINT DUE: ",
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
//                                                               Align(
//                                                                 alignment:
//                                                                     Alignment
//                                                                         .topLeft,
//                                                                 child: Text(
//                                                                   (iniciatedCancelWorkForApprovalViewModel.iniciatedCancelWorkApprovalTabularData.data!.data![index].nextMaintDue ==
//                                                                               null ||
//                                                                           iniciatedCancelWorkForApprovalViewModel.iniciatedCancelWorkApprovalTabularData.data!.data![index].nextMaintDue.toString() ==
//                                                                               'null')
//                                                                       ? ''
//                                                                       : formattedNextMaintDue,
//                                                                   textAlign:
//                                                                       TextAlign
//                                                                           .left,
//                                                                   style:
//                                                                       const TextStyle(
//                                                                     fontSize:
//                                                                         12,
//                                                                     //  fontWeight:
//                                                                     //      FontWeight.bold,
//                                                                     color: Colors
//                                                                         .white,
//                                                                   ),
//                                                                 ),
//                                                               ),
//                                                             ],
//                                                           ),
//                                                         )
//                                                       : const Text(
//                                                           "",
//                                                           textAlign:
//                                                               TextAlign.left,
//                                                           style: TextStyle(
//                                                             fontSize: 0,
//                                                             fontWeight:
//                                                                 FontWeight.bold,
//                                                             color: Colors.white,
//                                                           ),
//                                                         ),

//                                                   Expanded(
//                                                     flex: 1,
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
//                                                             (iniciatedCancelWorkForApprovalViewModel
//                                                                             .iniciatedCancelWorkApprovalTabularData
//                                                                             .data!
//                                                                             .data![
//                                                                                 index]
//                                                                             .createDate ==
//                                                                         null ||
//                                                                     iniciatedCancelWorkForApprovalViewModel
//                                                                             .iniciatedCancelWorkApprovalTabularData
//                                                                             .data!
//                                                                             .data![index]
//                                                                             .createDate
//                                                                             .toString() ==
//                                                                         'null')
//                                                                 ? ''
//                                                                 : formattedDateCreateDate,
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
//                                                     //  flex: 1,
//                                                     // alignment: Alignment.topLeft,
//                                                     child: Column(
//                                                       children: [
//                                                         const Align(
//                                                           alignment:
//                                                               Alignment.topLeft,
//                                                           child: Text(
//                                                             "GENERAL FOREMAN NOTES: ",
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
//                                                             (iniciatedCancelWorkForApprovalViewModel
//                                                                             .iniciatedCancelWorkApprovalTabularData
//                                                                             .data!
//                                                                             .data![
//                                                                                 index]
//                                                                             .contractorNotes ==
//                                                                         null ||
//                                                                     iniciatedCancelWorkForApprovalViewModel
//                                                                             .iniciatedCancelWorkApprovalTabularData
//                                                                             .data!
//                                                                             .data![
//                                                                                 index]
//                                                                             .contractorNotes
//                                                                             .toString() ==
//                                                                         'null')
//                                                                 ? ''
//                                                                 : iniciatedCancelWorkForApprovalViewModel
//                                                                     .iniciatedCancelWorkApprovalTabularData
//                                                                     .data!
//                                                                     .data![
//                                                                         index]
//                                                                     .contractorNotes
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
//                                                             (iniciatedCancelWorkForApprovalViewModel
//                                                                             .iniciatedCancelWorkApprovalTabularData
//                                                                             .data!
//                                                                             .data![
//                                                                                 index]
//                                                                             .adminNotes1 ==
//                                                                         null ||
//                                                                     iniciatedCancelWorkForApprovalViewModel
//                                                                             .iniciatedCancelWorkApprovalTabularData
//                                                                             .data!
//                                                                             .data![
//                                                                                 index]
//                                                                             .adminNotes1
//                                                                             .toString() ==
//                                                                         'null')
//                                                                 ? ''
//                                                                 : iniciatedCancelWorkForApprovalViewModel
//                                                                     .iniciatedCancelWorkApprovalTabularData
//                                                                     .data!
//                                                                     .data![
//                                                                         index]
//                                                                     .adminNotes1
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
//                                                             "SUPERVISOR NOTES: ",
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
//                                                             (iniciatedCancelWorkForApprovalViewModel
//                                                                             .iniciatedCancelWorkApprovalTabularData
//                                                                             .data!
//                                                                             .data![
//                                                                                 index]
//                                                                             .supervisorNotes ==
//                                                                         null ||
//                                                                     iniciatedCancelWorkForApprovalViewModel
//                                                                             .iniciatedCancelWorkApprovalTabularData
//                                                                             .data!
//                                                                             .data![
//                                                                                 index]
//                                                                             .supervisorNotes
//                                                                             .toString() ==
//                                                                         'null')
//                                                                 ? ''
//                                                                 : iniciatedCancelWorkForApprovalViewModel
//                                                                     .iniciatedCancelWorkApprovalTabularData
//                                                                     .data!
//                                                                     .data![
//                                                                         index]
//                                                                     .supervisorNotes
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
//                                                             "INITIATED BY: ",
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
//                                                             (iniciatedCancelWorkForApprovalViewModel
//                                                                             .iniciatedCancelWorkApprovalTabularData
//                                                                             .data!
//                                                                             .data![
//                                                                                 index]
//                                                                             .initiatedBy ==
//                                                                         null ||
//                                                                     iniciatedCancelWorkForApprovalViewModel
//                                                                             .iniciatedCancelWorkApprovalTabularData
//                                                                             .data!
//                                                                             .data![
//                                                                                 index]
//                                                                             .initiatedBy
//                                                                             .toString() ==
//                                                                         'null')
//                                                                 ? ''
//                                                                 : iniciatedCancelWorkForApprovalViewModel
//                                                                     .iniciatedCancelWorkApprovalTabularData
//                                                                     .data!
//                                                                     .data![
//                                                                         index]
//                                                                     .initiatedBy
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
//                                                     //  flex: 1,
//                                                     // alignment: Alignment.topLeft,
//                                                     child: Column(
//                                                       children: [
//                                                         const Align(
//                                                           alignment:
//                                                               Alignment.topLeft,
//                                                           child: Text(
//                                                             "PLANNER NOTES: ",
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
//                                                             (iniciatedCancelWorkForApprovalViewModel
//                                                                             .iniciatedCancelWorkApprovalTabularData
//                                                                             .data!
//                                                                             .data![
//                                                                                 index]
//                                                                             .plannerNotes ==
//                                                                         null ||
//                                                                     iniciatedCancelWorkForApprovalViewModel
//                                                                             .iniciatedCancelWorkApprovalTabularData
//                                                                             .data!
//                                                                             .data![
//                                                                                 index]
//                                                                             .plannerNotes
//                                                                             .toString() ==
//                                                                         'null')
//                                                                 ? ''
//                                                                 : iniciatedCancelWorkForApprovalViewModel
//                                                                     .iniciatedCancelWorkApprovalTabularData
//                                                                     .data!
//                                                                     .data![
//                                                                         index]
//                                                                     .plannerNotes
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
//                                                     child: Column(
//                                                       children: [
//                                                         Align(
//                                                             alignment: Alignment
//                                                                 .topLeft,
//                                                             child: InkWell(
//                                                               onTap: () async {
//                                                                 String id = '';
//                                                                 final userPreferences1 =
//                                                                     Provider.of<
//                                                                             UserPref>(
//                                                                         context,
//                                                                         listen:
//                                                                             false);
//                                                                 UserModel data =
//                                                                     await userPreferences1
//                                                                         .getUser();
//                                                                 id = data
//                                                                     .user!.id
//                                                                     .toString();
//                                                                 // Navigator.of(context).push(
//                                                                 //     MaterialPageRoute(
//                                                                 //         builder: (BuildContext
//                                                                 //                 context) =>
//                                                                 //             MapViewContractor(
//                                                                 //               id: iniciatedCancelWorkForApprovalViewModel.iniciatedCancelWorkApprovalTabularData.data!.data![index].id.toString(),
//                                                                 //             )));
//                                                                 // Navigator.push(
//                                                                 //   context,
//                                                                 //   MaterialPageRoute(
//                                                                 //     builder:
//                                                                 //         (context) =>
//                                                                 //             MapViewPage(
//                                                                 //       url: MapUrl.getGfEndPoint(
//                                                                 //           iniciatedCancelWorkForApprovalViewModel
//                                                                 //               .iniciatedCancelWorkApprovalTabularData
//                                                                 //               .data!
//                                                                 //               .data![index]
//                                                                 //               .tokenNo
//                                                                 //               .toString(),
//                                                                 //           id),
//                                                                 //     ),
//                                                                 //   ),
//                                                                 // );

//                                                                 await browser.open(
//                                                                     url: WebUri(
//                                                                         // "https://mapapi.ariespro.com/main/contractor/CIVM_Map/${iniciatedCancelWorkForApprovalViewModel.iniciatedCancelWorkApprovalTabularData.data!.data![index].tokenNo.toString()}/USRQWXH589Z"),
//                                                                         MapUrl.getGfEndPoint(
//                                                                             iniciatedCancelWorkForApprovalViewModel.iniciatedCancelWorkApprovalTabularData.data!.data![index].tokenNo
//                                                                                 .toString(),
//                                                                             id)),
//                                                                     settings: ChromeSafariBrowserSettings(
//                                                                         shareState:
//                                                                             CustomTabsShareState
//                                                                                 .SHARE_STATE_OFF,
//                                                                         barCollapsingEnabled:
//                                                                             true));
//                                                               },
//                                                               child: Align(
//                                                                 alignment: Alignment
//                                                                     .centerLeft,
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
//                                                                           .centerLeft,
//                                                                   width: 80,
//                                                                   // MediaQuery.of(context).size.width,
//                                                                   // height: MediaQuery.of(context).size.height * 0.4,
//                                                                   decoration:
//                                                                       const BoxDecoration(
//                                                                           // shape: BoxShape.circle,

//                                                                           color: Color.fromARGB(
//                                                                               255,
//                                                                               0,
//                                                                               58,
//                                                                               106),
//                                                                           gradient:
//                                                                               LinearGradient(
//                                                                             colors: [
//                                                                               Color.fromARGB(255, 0, 79, 215),
//                                                                               Colors.blue,
//                                                                               Color.fromARGB(255, 0, 79, 215),
//                                                                             ],
//                                                                           )),
//                                                                   child:
//                                                                       const Align(
//                                                                     alignment:
//                                                                         Alignment
//                                                                             .center,
//                                                                     child: Text(
//                                                                       "VIEW MAP",
//                                                                       style:
//                                                                           TextStyle(
//                                                                         color: Colors
//                                                                             .white,
//                                                                         fontWeight:
//                                                                             FontWeight.bold,
//                                                                         fontSize:
//                                                                             10,
//                                                                       ),
//                                                                     ),
//                                                                   ),
//                                                                 ),
//                                                               ),
//                                                             )),
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
//                                                             "CHAT HISTORY: ",
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
//                                                         GestureDetector(
//                                                           onTap: () {
//                                                             showModalBottomSheet(
//                                                               context: context,
//                                                               isScrollControlled:
//                                                                   true,
//                                                               backgroundColor:
//                                                                   Colors
//                                                                       .transparent,
//                                                               builder: (_) => ChatHistoryScreen(
//                                                                   tokenNo: iniciatedCancelWorkForApprovalViewModel
//                                                                       .iniciatedCancelWorkApprovalTabularData
//                                                                       .data!
//                                                                       .data![
//                                                                           index]
//                                                                       .tokenNo
//                                                                       .toString()),
//                                                             );
//                                                           },
//                                                           child: Align(
//                                                             alignment: Alignment
//                                                                 .topLeft,
//                                                             child: Text(
//                                                               (iniciatedCancelWorkForApprovalViewModel
//                                                                               .iniciatedCancelWorkApprovalTabularData
//                                                                               .data!
//                                                                               .data![
//                                                                                   index]
//                                                                               .addChatNotes ==
//                                                                           null ||
//                                                                       iniciatedCancelWorkForApprovalViewModel
//                                                                               .iniciatedCancelWorkApprovalTabularData
//                                                                               .data!
//                                                                               .data![
//                                                                                   index]
//                                                                               .addChatNotes
//                                                                               .toString() ==
//                                                                           'null')
//                                                                   ? ''
//                                                                   : iniciatedCancelWorkForApprovalViewModel
//                                                                       .iniciatedCancelWorkApprovalTabularData
//                                                                       .data!
//                                                                       .data![
//                                                                           index]
//                                                                       .addChatNotes
//                                                                       .toString(),
//                                                               textAlign:
//                                                                   TextAlign
//                                                                       .left,
//                                                               style:
//                                                                   const TextStyle(
//                                                                 fontSize: 12,
//                                                                 //  fontWeight:
//                                                                 //      FontWeight.bold,
//                                                                 color: Colors
//                                                                     .white,
//                                                               ),
//                                                             ),
//                                                           ),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                   Expanded(
//                                                     //  flex: 2,
//                                                     // alignment: Alignment.topLeft,
//                                                     child: Column(
//                                                       children: [
//                                                         const Align(
//                                                           alignment:
//                                                               Alignment.topLeft,
//                                                           child: Text(
//                                                             "ACTION: ",
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
//                                                         (rights != "READ ONLY")
//                                                             ? (iniciatedCancelWorkForApprovalViewModel
//                                                                         .iniciatedCancelWorkApprovalTabularData
//                                                                         .data!
//                                                                         .data![
//                                                                             index]
//                                                                         .maintType ==
//                                                                     'Change Order')
//                                                                 ? const Text(
//                                                                     "",
//                                                                     textAlign:
//                                                                         TextAlign
//                                                                             .left,
//                                                                     style:
//                                                                         TextStyle(
//                                                                       fontSize:
//                                                                           12,
//                                                                       fontWeight:
//                                                                           FontWeight
//                                                                               .bold,
//                                                                       color: Colors
//                                                                           .white,
//                                                                     ),
//                                                                   )
//                                                                 : InkWell(
//                                                                     onTap: () {
//                                                                       openDailogSubmitApproval(iniciatedCancelWorkForApprovalViewModel
//                                                                           .iniciatedCancelWorkApprovalTabularData
//                                                                           .data!
//                                                                           .data![
//                                                                               index]
//                                                                           .id
//                                                                           .toString());
//                                                                     },
//                                                                     child:
//                                                                         Align(
//                                                                       alignment:
//                                                                           Alignment
//                                                                               .centerLeft,
//                                                                       child:
//                                                                           Container(
//                                                                         padding: const EdgeInsets
//                                                                             .all(
//                                                                             8),
//                                                                         alignment:
//                                                                             Alignment.centerLeft,
//                                                                         width:
//                                                                             80,
//                                                                         decoration: const BoxDecoration(
//                                                                             color: Color.fromARGB(255, 0, 58, 106),
//                                                                             gradient: LinearGradient(
//                                                                               colors: [
//                                                                                 Color.fromARGB(255, 0, 79, 215),
//                                                                                 Colors.blue,
//                                                                                 Color.fromARGB(255, 0, 79, 215),
//                                                                               ],
//                                                                             )),
//                                                                         child:
//                                                                             const Align(
//                                                                           alignment:
//                                                                               Alignment.center,
//                                                                           child:
//                                                                               Text(
//                                                                             'SUBMIT FOR APPROVAL',
//                                                                             style:
//                                                                                 TextStyle(
//                                                                               color: Colors.white,
//                                                                               fontWeight: FontWeight.bold,
//                                                                               fontSize: 10,
//                                                                             ),
//                                                                           ),
//                                                                         ),
//                                                                       ),
//                                                                     ),
//                                                                   )
//                                                             : const SizedBox(),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                   const Expanded(
//                                                     // flex: 2,
//                                                     // alignment: Alignment.topLeft,
//                                                     child: Column(
//                                                       children: [],
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

//   Future openDailogSubmitApproval(String id) => showDialog(
//       context: context,
//       builder: (context) {
//         return StatefulBuilder(builder: (context, setState) {
//           return AlertDialog(
//             content: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   const Text(
//                     "SUBMIT FOR APPROVAL",
//                     style: TextStyle(
//                       fontSize: 20.0,
//                       color: Color.fromARGB(255, 7, 59, 120),
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(top: 20.0),
//                     child: Text(
//                       "Change Order No. : $id",
//                       style: const TextStyle(
//                         fontSize: 16.0,
//                         color: Color.fromARGB(255, 7, 59, 120),
//                       ),
//                     ),
//                   ),
//                   const Padding(
//                     padding: EdgeInsets.only(top: 20.0),
//                     child: Text(
//                       "Are you sure to submit for Approval?",
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         fontSize: 16.0,
//                         color: Color.fromARGB(255, 7, 59, 120),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             actions: [
//               Row(
//                 children: [
//                   Expanded(
//                     child: Container(
//                         margin: const EdgeInsets.only(
//                             left: 6, right: 6, bottom: 10),
//                         child: InkWell(
//                           onTap: () {
//                             // contractorOrderPendingViewModel
//                             //     .fetchStatusChangeApi(
//                             //         context,
//                             //         'PENDING APPROVAL',
//                             //         _notes.text.toString(),
//                             //         int.parse(id))
//                             //     .then((value) {
//                             //   print('Success');
//                             //   Navigator.pop(context);
//                             //   fetchData();
//                             // });
//                             // print(updatedCard);
//                             updateSubmitForApprovalStatus(id);
//                           },
//                           child: Container(
//                             margin: const EdgeInsets.only(bottom: 10.0),
//                             // padding: const EdgeInsets.all(8),
//                             alignment: Alignment.center,
//                             width: MediaQuery.of(context).size.width,
//                             height: 40,
//                             decoration: const BoxDecoration(
//                                 // shape: BoxShape.circle,
//                                 // borderRadius: BorderRadius.circular(25),
//                                 boxShadow: [
//                                   BoxShadow(
//                                       color: Color.fromARGB(255, 1, 106, 5),
//                                       blurRadius: 5,
//                                       offset: Offset(2.0, 5.0))
//                                 ],
//                                 color: Colors.black,
//                                 gradient: LinearGradient(
//                                   colors: [
//                                     Colors.green,
//                                     Colors.green,
//                                   ],
//                                 )),
//                             child: const Row(children: [
//                               Expanded(
//                                 child: Align(
//                                   alignment: Alignment.center,
//                                   child: Text(
//                                     "Yes",
//                                     textAlign: TextAlign.left,
//                                     style: TextStyle(
//                                       color: Colors.white,
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 20,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ]),
//                           ),
//                         )),
//                   ),
//                   Expanded(
//                     child: Container(
//                         margin: const EdgeInsets.only(
//                             left: 6, right: 6, bottom: 10),
//                         child: InkWell(
//                           onTap: () {
//                             Navigator.pop(context);
//                           },
//                           child: Container(
//                             margin: const EdgeInsets.only(bottom: 10.0),
//                             // padding: const EdgeInsets.all(8),
//                             alignment: Alignment.center,
//                             width: MediaQuery.of(context).size.width,
//                             height: 40,
//                             decoration: const BoxDecoration(
//                                 // shape: BoxShape.circle,
//                                 // borderRadius: BorderRadius.circular(25),
//                                 boxShadow: [
//                                   BoxShadow(
//                                       color: Color.fromARGB(255, 139, 10, 0),
//                                       blurRadius: 5,
//                                       offset: Offset(2.0, 5.0))
//                                 ],
//                                 color: Colors.black,
//                                 gradient: LinearGradient(
//                                   colors: [
//                                     Colors.red,
//                                     Colors.red,
//                                   ],
//                                 )),
//                             child: const Row(children: [
//                               Expanded(
//                                 child: Align(
//                                   alignment: Alignment.center,
//                                   child: Text(
//                                     "No",
//                                     textAlign: TextAlign.left,
//                                     style: TextStyle(
//                                       color: Colors.white,
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 20,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ]),
//                           ),
//                         )),
//                   ),
//                 ],
//               ),
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

//   Future openDialogPicture(String tokenNo) => showDialog(
//         context: context,
//         builder: (context) {
//           return StatefulBuilder(builder: (context, setState) {
//             // lCPWorkOrdersClosedViewModel.fetchImageApi(
//             //     context,
//             //     //  '1');
//             //     tokenNo.toString());
//             int length = iniciatedCancelWorkForApprovalViewModel
//                     .imageData.data?.images?.length ??
//                 0;

//             return AlertDialog(
//               content: Container(
//                 width: MediaQuery.of(context).size.width * 0.99,
//                 padding: const EdgeInsets.only(top: 8.0),
//                 child: SingleChildScrollView(
//                   child: Column(
//                     children: [
//                       if (length == 0)
//                         const Center(
//                           child: Text(
//                             "No image found!",
//                             style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                               color: Color.fromARGB(255, 7, 59, 120),
//                             ),
//                           ),
//                         )
//                       else
//                         for (int i = 0; i < length; i += 2)
//                           Row(
//                             children: [
//                               if (i < length) ...[
//                                 buildImageWidget(i, tokenNo.toString()),
//                               ],
//                               if (i + 1 < length) ...[
//                                 // const SizedBox(width: 8),
//                                 buildImageWidget(i + 1, tokenNo.toString()),
//                               ],
//                             ],
//                           ),
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           });
//         },
//       );

//   Widget buildImageWidget(int i, String tokenNo) {
//     String? fileLocation = iniciatedCancelWorkForApprovalViewModel
//         .imageData.data?.images![i].imageLocation;

//     bool isVideo(String file) {
//       return file.endsWith('.mp4') || file.endsWith('.mov');
//     }

//     return Expanded(
//       child: (fileLocation != null)
//           ? Container(
//               //  margin: const EdgeInsets.only(top:8, bottom:8),
//               decoration: BoxDecoration(
//                 border: Border.all(
//                   color: Colors.black,
//                   width: 2,
//                 ),
//               ),
//               child: Stack(
//                 children: [
//                   if (isPDF(fileLocation))
//                     Center(
//                       child: InkWell(
//                         onTap: () {
//                           Navigator.of(context).push(MaterialPageRoute(
//                               builder: (BuildContext context) => PDFViewer(
//                                   pdfUrl:
//                                       'https://civm.ariespro.com/assets/clientuploads/$fileLocation')));
//                         },
//                         child: Image.asset(
//                           'assets/pdflogo.jpg',
//                           height: 150,
//                           width: 150,
//                         ),
//                       ),
//                     )
//                   else if (isVideo(fileLocation))
//                     InkWell(
//                         onTap: () {
//                           openFullSizeVideoDialog(fileLocation);
//                         },
//                         child: ClipRRect(
//                           borderRadius: BorderRadius.circular(
//                               5), // Optional rounded corners
//                           child: SizedBox(
//                             height: 150,
//                             width: double.infinity,
//                             child: VideoPlayerWidget(
//                               videoUrl:
//                                   'https://civm.ariespro.com/assets/clientuploads/$fileLocation',
//                             ),
//                           ),
//                         ))
//                   else
//                     InkWell(
//                       onTap: () {
//                         openFullSizeImageDialog(fileLocation);
//                       },
//                       child: Image.network(
//                         'https://civm.ariespro.com/assets/clientuploads/$fileLocation',
//                       ),
//                     ),
//                   Padding(
//                     padding: const EdgeInsets.only(top: 8.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         InkWell(
//                           onTap: () {
//                             if (!isPDF(fileLocation)) {
//                               downloadFile(
//                                   'https://civm.ariespro.com/assets/clientuploads/$fileLocation',
//                                   'File');
//                               Navigator.pop(context);
//                             } else {
//                               downloadFile(
//                                   'https://civm.ariespro.com/assets/clientuploads/$fileLocation',
//                                   'PDF');
//                               Navigator.pop(context);
//                             }
//                           },
//                           child: const Icon(
//                             Icons.download,
//                             color: Colors.blue,
//                             size: 20,
//                           ),
//                         ),
//                         InkWell(
//                           onTap: () {
//                             deleteOnlineImageApi(fileLocation, tokenNo);
//                             Navigator.pop(context);
//                           },
//                           child: const Icon(
//                             Icons.delete,
//                             color: Colors.red,
//                             size: 20,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             )
//           : const Center(
//               child: Text(
//                 "NO IMAGE",
//                 textAlign: TextAlign.left,
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                   color: Color.fromARGB(255, 7, 59, 120),
//                 ),
//               ),
//             ),
//     );
//   }

//   void openFullSizeVideoDialog(String videoUrl) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return Dialog(
//           insetPadding: EdgeInsets.zero,
//           child: FullScreenVideoPlayer(videoUrl: videoUrl),
//         );
//       },
//     );
//   }

//   Future<void> downloadFile(String fileUrl, String fileType) async {
//     final response = await http.get(Uri.parse(fileUrl));
//     if (response.statusCode == 200) {
//       final appDir = await getApplicationDocumentsDirectory();
//       final fileName = fileUrl.split('/').last;
//       final file = File('${appDir.path}/$fileName');
//       await file.writeAsBytes(response.bodyBytes);
//       print('$fileType downloaded to: ${file.path}');
//       CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
//           '$fileType Downloaded', context);
//     } else {
//       print(
//           'Failed to download $fileType. Status code: ${response.statusCode}');
//     }
//   }

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
//                       'https://civm.ariespro.com/assets/clientuploads/$imageUrl',
//                     ),
//                     minScale: PhotoViewComputedScale.contained * 0.5,
//                     maxScale: PhotoViewComputedScale.covered * 0.5,
//                   ),
//                 ],
//               ),
//                   Positioned(
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
//         'http://civmapi.ariespro.com/civmapi/changeOrderLcpCreateOrder/deleteFile?fileName=$fileName&tokenNo=$tokenNo';
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
//         getContractorData();
//       } else {
//         print('API request failed with status code: ${response.statusCode}');
//         print('Response body: ${response.body}');
//       }
//     } catch (e) {
//       print('Error: $e');
//     }
//   }

//   Future<void> getContractorData() async {
//     final userPreferences = Provider.of<UserPref>(context, listen: false);
//     UserModel data = await userPreferences.getUser();

//     id = data.user!.id.toString();

//     iniciatedCancelWorkForApprovalViewModel
//         .fetchIniciatedCancelWorkApprovalTabularListApi(
//             context, 'CANCELLED', id);
//     rights = data.user!.rights;
//   }

//   Future<void> updateSubmitForApprovalStatus(String tokenNo) async {
//     String baseUrl =
//         'https://civmapi.ariespro.com/civmapi/workOrderPendingAndReject/updateStatusFromRejectedToPendingApproval';
//     final userPreferences = Provider.of<UserPref>(context, listen: false);
//     UserModel data = await userPreferences.getUser();
//     final Map<String, String> queryParams = {
//       'status': 'WORK FOR APPROVAL',
//       // 'PENDING APPROVAL',
//       'tokenNo': tokenNo,
//     };
//     final String url =
//         Uri.parse(baseUrl).replace(queryParameters: queryParams).toString();
//     print('url: $url');
//     Map<String, String> headers = {
//       "Content-Type": "application/json",
//       "Accept": "application/json",
//       "Authorization": 'Bearer ${data.token!}',
//     };

//     try {
//       final response = await http.put(
//         Uri.parse(url),
//         headers: headers,
//       );

//       if (response.statusCode == 200) {
//         print('Status updated successfully');
//         Navigator.pop(context);
//         CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
//             '$tokenNo Submitted for approval successfully', context);
//         getContractorData();
//         // iniciatedCancelWorkForApprovalViewModel.fetchLCPWorkOrderRejectTabularListApi(
//         //     context,
//         //     '',
//         //     '',
//         //     'REJECTED',
//         //     '',
//         //     '',
//         //     'Change Order',
//         //     id,
//         //     'generalforeman');
//       } else {
//         print('Failed to update status: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Error: $e');
//     }
//   }

//   void _filterData(String query) {
//     if (query.isEmpty) {
//       selectedSubstation = null;
//       selectedFeeder = null;
//       getContractorData();
//     } else {
//       iniciatedCancelWorkForApprovalViewModel.iniciatedCancelWorkApprovalTabularData.data!.data = iniciatedCancelWorkForApprovalViewModel
//           .iniciatedCancelWorkApprovalTabularData.data!.data!
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
//               item.feeder
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
//               item.adminNotes1.toString().toLowerCase().contains(query.toLowerCase()) ||
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

//   void newDateFormat(
//     int index,
//   ) {
//     String? rawContractYear = iniciatedCancelWorkForApprovalViewModel
//         .iniciatedCancelWorkApprovalTabularData.data!.data![index].contractYear
//         ?.toString();

//     String? rawNextMaintDue = iniciatedCancelWorkForApprovalViewModel
//         .iniciatedCancelWorkApprovalTabularData.data!.data![index].nextMaintDue
//         ?.toString();
//     formattedContractYear = extractYear(rawContractYear);
//     formattedNextMaintDue = extractYear(rawNextMaintDue);
//     print('rawCreateDate $rawContractYear');
//     print('formattedContractYear: $formattedContractYear');
//     print('formattedNextMaintDue: $formattedNextMaintDue');
//   }

//   String extractYear(String? date) {
//     if (date == null || date.isEmpty || date == "N/A") {
//       return ""; // Handle null or invalid dates
//     }
//     try {
//       if (date.contains('T')) {
//         // ISO 8601 format (e.g., 2024-12-07T11:37:16.750+00:00)
//         DateTime parsedDate = DateTime.parse(date);
//         return parsedDate.year.toString();
//       } else if (date.contains(' ')) {
//         // Formats like "Dec  7 2024 12:00AM"
//         String normalizedDate =
//             date.replaceAll(RegExp(r'\s+'), ' '); // Remove extra spaces
//         DateTime parsedDate =
//             DateFormat("MMM d yyyy h:mma").parse(normalizedDate);
//         return parsedDate.year.toString();
//       } else if (date.contains('/')) {
//         // Format MM/dd/yyyy
//         DateTime parsedDate = DateFormat("MM/dd/yyyy").parse(date);
//         return parsedDate.year.toString();
//       }
//     } catch (e) {
//       print("Error parsing date: $date, Error: $e");
//     }
//     return ""; // Default if parsing fails
//   }
// }
