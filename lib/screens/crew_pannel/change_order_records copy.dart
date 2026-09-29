// import 'dart:io';
// import 'package:CIVM/models/user_model.dart';
// import 'package:CIVM/repository/map_url.dart';
// import 'package:CIVM/screens/admin_pannel/row_maintenance_view/pdf_view.dart';
// import 'package:CIVM/screens/chat_history.dart';
// import 'package:CIVM/utils/common_functions.dart';
// import 'package:CIVM/screens/crew_pannel/crew_bottom_navigation_pannel.dart';
// import 'package:CIVM/screens/crew_pannel/crew_change_order_form.dart';
// import 'package:CIVM/screens/leaflat_map/leaf_lat_map_wakeLock.dart';
// import 'package:CIVM/screens/login_page.dart';
// import 'package:CIVM/screens/map/provider/location_provider.dart';
// import 'package:CIVM/screens/my_chrome_safari_map_recording.dart';
// import 'package:CIVM/utils/common_functions.dart';
// import 'package:CIVM/utils/custom_toast_snackbar_progressdialog.dart';
// import 'package:CIVM/utils/user_pref.dart';
// import 'package:CIVM/view_model/crew_change_order_records_view_model.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// // import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// import 'package:intl/intl.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:photo_view/photo_view.dart';
// import 'package:photo_view/photo_view_gallery.dart';
// import 'package:provider/provider.dart';
// import '../../../data/response/status.dart';
// import 'package:http/http.dart' as http;

// class ChangeOrderTableCopy extends StatefulWidget {
//   const ChangeOrderTableCopy({Key? key}) : super(key: key);
//   @override
//   State<ChangeOrderTableCopy> createState() => _ChangeOrderTableCopyState();
// }

// class _ChangeOrderTableCopyState extends State<ChangeOrderTableCopy> {
//   List<String> menu = [];

//   int workOrderNoId = 0;
//   // ignore: prefer_typing_uninitialized_variables
//   var selectedWorkOrderNo;

//   final browser = MyChromeSafariBrowser();
//   String userName = '';
//   final TextEditingController _input = TextEditingController();
//   CrewChangeOrderRecordsViewModel crewChangeOrderRecordsViewModel =
//       CrewChangeOrderRecordsViewModel();
//   String id = '';

//   @override
//   void initState() {
//     getData();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//         appBar: AppBar(
//           iconTheme: const IconThemeData(color: Colors.white),
//           title: const Text(
//             'Change Order (Assigned)',
//             style: TextStyle(color: Colors.white),
//           ),
//           backgroundColor: const Color.fromARGB(255, 7, 59, 120),
//         ),
//         body: ChangeNotifierProvider<CrewChangeOrderRecordsViewModel>(
//             create: (BuildContext context) => crewChangeOrderRecordsViewModel,
//             child: Consumer<CrewChangeOrderRecordsViewModel>(
//                 builder: (context, value, _) {
//               switch (value.crewChangeOrderRecordsGetTabularData.status) {
//                 case Status.LOADING:
//                   return const Center(child: CircularProgressIndicator());
//                 case Status.ERROR:
//                   return
//                       //  CustomToastSnackBarProgressDialog.flushBarErrorMessage(
//                       //     value.crewChangeOrderRecordsGetTabularData.message
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
//                       selectedWorkOrderNo = null;
//                       await crewChangeOrderRecordsViewModel
//                           .fetchCrewChangeOrderRecordsTabularListApi(
//                               context, id, "0,1,2");
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
//                                 "TOTAL CHANGE ORDER : ${crewChangeOrderRecordsViewModel.crewChangeOrderRecordsGetTabularData.data!.data!.where((record) => record.status == 'ASSIGNED' || record.status == 'REJECTED' || record.status == 'PENDING ZIELIES APPROVAL').length}",
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

//                                       //  keyboardType: TextInputType.number,
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
//                                 itemCount: crewChangeOrderRecordsViewModel
//                                     .crewChangeOrderRecordsGetTabularData
//                                     .data!
//                                     .data!
//                                     .where((record) =>
//                                         // record.status == 'PENDING' ||
//                                         record.status == 'ASSIGNED' ||
//                                         record.status == 'REJECTED' ||
//                                         record.status ==
//                                             'PENDING ZIELIES APPROVAL')
//                                     .length, // Count only filtered records
//                                 itemBuilder: (BuildContext ctxt, int index) {
//                                   // Filter the list first
//                                   var filteredList = crewChangeOrderRecordsViewModel
//                                       .crewChangeOrderRecordsGetTabularData
//                                       .data!
//                                       .data!
//                                       .where((record) =>
//                                           // record.status == 'PENDING' ||
//                                           record.status == 'ASSIGNED' ||
//                                           record.status == 'REJECTED' ||
//                                           record.status ==
//                                               'PENDING ZIELIES APPROVAL')
//                                       .toList(); // Convert to list after filtering

//                                   String? dateString =
//                                       filteredList[index].createDate;
//                                   String formattedDate = dateString != null
//                                       ? DateFormat('MM/dd/yyyy')
//                                           .format(DateTime.parse(dateString))
//                                       : '';
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
//                                           // height:
//                                           //     MediaQuery.of(context).size.height *
//                                           //         0.73,
//                                           // margin:  EdgeInsets.only(
//                                           //     top: 5.0, bottom: 5.0, left: 2,right: 2),
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
//                                                         Align(
//                                                             alignment: Alignment
//                                                                 .topLeft,
//                                                             child: InkWell(
//                                                               onTap: () {
//                                                                 Navigator.of(context).push(MaterialPageRoute(
//                                                                     builder: (BuildContext context) => CrewChangeOrderForm(
//                                                                         jobNo: filteredList[index]
//                                                                             .tokenNo
//                                                                             .toString(),
//                                                                         substation: filteredList[index]
//                                                                             .substation
//                                                                             .toString(),
//                                                                         feeder: filteredList[index]
//                                                                             .feeder
//                                                                             .toString(),
//                                                                         streetAddress: filteredList[index]
//                                                                             .streetAddress
//                                                                             .toString(),
//                                                                         mapLocation: filteredList[index]
//                                                                             .mapLocation
//                                                                             .toString(),
//                                                                         substationId: filteredList[index]
//                                                                             .substationId
//                                                                             .toString(),
//                                                                         feederId: filteredList[index]
//                                                                             .feeder
//                                                                             .toString(),
//                                                                         maintenanceType: filteredList[index]
//                                                                             .type
//                                                                             .toString(),
//                                                                         inspectionDate: filteredList[index]
//                                                                             .followUpDate
//                                                                             .toString(),
//                                                                         followUpDate: filteredList[index]
//                                                                             .dateOfInspection
//                                                                             .toString())));
//                                                               },
//                                                               child: filteredList[
//                                                                               index]
//                                                                           .status ==
//                                                                       'PENDING ZIELIES APPROVAL'
//                                                                   ? SizedBox()
//                                                                   : const Icon(
//                                                                       Icons
//                                                                           .edit,
//                                                                       color: Color.fromARGB(
//                                                                           255,
//                                                                           151,
//                                                                           249,
//                                                                           154),
//                                                                     ),
//                                                             )),
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
//                                                             await crewChangeOrderRecordsViewModel
//                                                                 .fetchImageApi(
//                                                               context,
//                                                               filteredList[
//                                                                       index]
//                                                                   .id
//                                                                   .toString(),
//                                                             );
//                                                             await Future.delayed(
//                                                                 const Duration(
//                                                                     seconds:
//                                                                         2));
//                                                             openDialogPicture(
//                                                                 filteredList[
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
//                                                             (filteredList[index]
//                                                                             .maintType ==
//                                                                         null ||
//                                                                     filteredList[index]
//                                                                             .maintType
//                                                                             .toString() ==
//                                                                         'null')
//                                                                 ? ''
//                                                                 : filteredList[
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
//                                                             (filteredList[index]
//                                                                             .tokenNo ==
//                                                                         null ||
//                                                                     filteredList[index]
//                                                                             .tokenNo
//                                                                             .toString() ==
//                                                                         'null')
//                                                                 ? ''
//                                                                 : filteredList[
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
//                                                             "STATUS:",
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
//                                                             (filteredList[index]
//                                                                             .status ==
//                                                                         null ||
//                                                                     filteredList[index]
//                                                                             .status
//                                                                             .toString() ==
//                                                                         'null')
//                                                                 ? ''
//                                                                 : filteredList[
//                                                                         index]
//                                                                     .status
//                                                                     .toString(),
//                                                             textAlign:
//                                                                 TextAlign.left,
//                                                             style: TextStyle(
//                                                                 fontSize: 12,
//                                                                 color: getStatusColor(
//                                                                     filteredList[
//                                                                             index]
//                                                                         .status)),
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
//                                                             (filteredList[index]
//                                                                             .substation ==
//                                                                         null ||
//                                                                     filteredList[index]
//                                                                             .substation
//                                                                             .toString() ==
//                                                                         'null')
//                                                                 ? ''
//                                                                 : filteredList[
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
//                                                             (filteredList[index]
//                                                                             .feeder ==
//                                                                         null ||
//                                                                     filteredList[index]
//                                                                             .feeder
//                                                                             .toString() ==
//                                                                         'null')
//                                                                 ? ''
//                                                                 : filteredList[
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
//                                                             (filteredList[index]
//                                                                             .streetAddress ==
//                                                                         null ||
//                                                                     filteredList[index]
//                                                                             .streetAddress
//                                                                             .toString() ==
//                                                                         'null')
//                                                                 ? ''
//                                                                 : filteredList[
//                                                                         index]
//                                                                     .streetAddress
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
//                                                             (filteredList[index]
//                                                                             .mapLocation ==
//                                                                         null ||
//                                                                     filteredList[index]
//                                                                             .mapLocation
//                                                                             .toString() ==
//                                                                         'null')
//                                                                 ? ''
//                                                                 : filteredList[
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
//                                                             (filteredList[index]
//                                                                             .contractorNotes ==
//                                                                         null ||
//                                                                     filteredList[index]
//                                                                             .contractorNotes
//                                                                             .toString() ==
//                                                                         'null')
//                                                                 ? ''
//                                                                 : filteredList[
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
//                                                             (filteredList[index]
//                                                                             .supervisorNotes ==
//                                                                         null ||
//                                                                     filteredList[index]
//                                                                             .supervisorNotes
//                                                                             .toString() ==
//                                                                         'null')
//                                                                 ? ''
//                                                                 : filteredList[
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
//                                                   Expanded(
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
//                                                             (filteredList[index]
//                                                                             .plannerNotes ==
//                                                                         null ||
//                                                                     filteredList[index]
//                                                                             .plannerNotes
//                                                                             .toString() ==
//                                                                         'null')
//                                                                 ? ''
//                                                                 : filteredList[
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
//                                                             (filteredList[index]
//                                                                             .adminNotes1 ==
//                                                                         null ||
//                                                                     filteredList[index]
//                                                                             .adminNotes1
//                                                                             .toString() ==
//                                                                         'null')
//                                                                 ? ''
//                                                                 : filteredList[
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
//                                                             (filteredList[index]
//                                                                             .contractYear ==
//                                                                         null ||
//                                                                     filteredList[index]
//                                                                             .contractYear
//                                                                             .toString() ==
//                                                                         'null')
//                                                                 ? ''
//                                                                 : getYearOrNA(filteredList[
//                                                                         index]
//                                                                     .contractYear
//                                                                     .toString()),
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
//                                                             (filteredList[index]
//                                                                             .contractor ==
//                                                                         null ||
//                                                                     filteredList[index]
//                                                                             .contractor
//                                                                             .toString() ==
//                                                                         'null')
//                                                                 ? ''
//                                                                 : filteredList[
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
//                                                             (filteredList[index]
//                                                                             .createDate ==
//                                                                         null ||
//                                                                     filteredList[index]
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
//                                                             (filteredList[index]
//                                                                             .initiatedBy ==
//                                                                         null ||
//                                                                     filteredList[index]
//                                                                             .initiatedBy
//                                                                             .toString() ==
//                                                                         'null')
//                                                                 ? ''
//                                                                 : filteredList[
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
//                                                                   tokenNo: filteredList[
//                                                                           index]
//                                                                       .tokenNo
//                                                                       .toString()),
//                                                             );
//                                                           },
//                                                           child: Align(
//                                                             alignment: Alignment
//                                                                 .topLeft,
//                                                             child: Text(
//                                                               (filteredList[index]
//                                                                               .addChatNotes ==
//                                                                           null ||
//                                                                       filteredList[index]
//                                                                               .addChatNotes
//                                                                               .toString() ==
//                                                                           'null')
//                                                                   ? ''
//                                                                   : filteredList[
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
//                                                      Align(
//                                                           alignment:
//                                                               Alignment.topLeft,
//                                                           child: Text(
//                                                             "REWORK: ",
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
//                                                             (filteredList[index]
//                                                                             .reWork ==
//                                                                         null ||
//                                                                     filteredList[index]
//                                                                             .reWork
//                                                                             .toString() ==
//                                                                         'null')
//                                                                 ? ''
//                                                                 : filteredList[
//                                                                         index]
//                                                                     .reWork
//                                                                     .toString(),
//                                                             textAlign:
//                                                                 TextAlign.left,
//                                                             style:
//                                                                  TextStyle(
//                                                               fontSize: 12,
//                                                               //  fontWeight:
//                                                               //      FontWeight.bold,
//                                                               color:(filteredList[
//                                                                         index]
//                                                                     .reWork=="REWORK")?
//                                                                   Colors.red:Colors.white,
//                                                             ),
//                                                           ),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ),
                                                
//                                                   Expanded(
//                                                     flex: 2,
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
                                                              

//                                                                 await browser.open(
//                                                                     url: WebUri(
//                                                                         // "https://mapapi.ariespro.com/main/contractor/CIVM_Map/${lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].tokenNo.toString()}/USRQWXH589Z"),
//                                                                         MapUrl.getGfEndPoint(
//                                                                             filteredList[index]
//                                                                                 .tokenNo
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

//   void _filterData(String query) {
//     if (query.isEmpty) {
//       selectedWorkOrderNo = null;
//       crewChangeOrderRecordsViewModel.fetchCrewChangeOrderRecordsTabularListApi(
//           context, id, "0,1,2");
//     } else {
//       crewChangeOrderRecordsViewModel.crewChangeOrderRecordsGetTabularData.data!.data = crewChangeOrderRecordsViewModel
//           .crewChangeOrderRecordsGetTabularData.data!.data!
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
//             int length = crewChangeOrderRecordsViewModel
//                     .imageData.data?.images?.length ??
//                 0;

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
//     String? imageLocation = crewChangeOrderRecordsViewModel
//         .imageData.data?.images![i].imageLocation;

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
//                                     'https://civm.ariespro.com/assets/clientuploads/$imageLocation')));
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
//                       'https://civm.ariespro.com/assets/clientuploads/$imageLocation',
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
//                                 'https://civm.ariespro.com/assets/clientuploads/$imageLocation',
//                                 'Image');
//                             Navigator.pop(context);
//                           } else {
//                             print('pdf');
//                             downloadFile(
//                                 'https://civm.ariespro.com/assets/clientuploads/$imageLocation',
//                                 'PDF');
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
//                   color: Color.fromARGB(255, 7, 59, 120),
//                 ),
//               ),
//             ),
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
//               Positioned(
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
//         crewChangeOrderRecordsViewModel
//             .fetchCrewChangeOrderRecordsTabularListApi(context, id, "0,1,2");
//       } else {
//         print('API request failed with status code: ${response.statusCode}');
//         print('Response body: ${response.body}');
//       }
//     } catch (e) {
//       print('Error: $e');
//     }
//   }

//   Future<void> getData() async {
//     final userPreferences = Provider.of<UserPref>(context, listen: false);
//     UserModel data = await userPreferences.getUser();

//     id = data.user!.id.toString();

//     crewChangeOrderRecordsViewModel.fetchCrewChangeOrderRecordsTabularListApi(
//         context, id, "0,1,2");
//   }
// }

// // ignore: must_be_immutable
// class DrawerManu extends StatefulWidget {
//   List<String> menu;
//   DrawerManu({Key? key, required this.menu}) : super(key: key);
//   @override
//   State<DrawerManu> createState() => _DrawerManuState();
// }

// class _DrawerManuState extends State<DrawerManu> {
//   String userName = '';
//   String? _imagePath;
//   final browser = MyChromeSafariBrowser();
//   @override
//   void initState() {
//     setUserName();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final userPreferences = Provider.of<UserPref>(context);
//     var provider = Provider.of<LocationProvider>(context, listen: true);
//     return Drawer(
//       child: ListView(
// // Important: Remove any padding from the ListView.
//         padding: EdgeInsets.zero,
//         children: [
//           DrawerHeader(
//             decoration: const BoxDecoration(
//               color: Color.fromARGB(255, 7, 59, 120),
//             ),
//             child: Column(
//               children: [
//                 menuLogoLCP(),
//                 Padding(
//                   padding: const EdgeInsets.only(top: 6.0),
//                   child: Text(
//                     userName,
//                     style: const TextStyle(fontSize: 18, color: Colors.white),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           ListTile(
//             leading: const Icon(
//               Icons.computer,
//             ),
//             title: const Text('Crew Dashboard'),
//             textColor: const Color.fromARGB(255, 7, 59, 120),
//             iconColor: const Color.fromARGB(255, 7, 59, 120),
//             onTap: () {
//               Navigator.of(context).push(MaterialPageRoute(
//                   builder: (BuildContext context) =>
//                       const CrewBottomNavigationPannel()));
//             },
//           ),
//           ListTile(
//             leading: const Icon(
//               Icons.running_with_errors,
//             ),
//             title: const Text('IVM Maintenance Progress'),
//             textColor: const Color.fromARGB(255, 7, 59, 120),
//             iconColor: const Color.fromARGB(255, 7, 59, 120),
//             onTap: () {
//               Navigator.pop(context);
//             },
//           ),
//           ListTile(
//             leading: const Icon(
//               Icons.map,
//             ),
//             title: const Text('Map View'),
//             textColor: const Color.fromARGB(255, 7, 59, 120),
//             iconColor: const Color.fromARGB(255, 7, 59, 120),
//             onTap: () async {
//               String id = '';
//               final userPreferences1 =
//                   Provider.of<UserPref>(context, listen: false);
//               UserModel data = await userPreferences1.getUser();
//               id = data.user!.id.toString();
//               // Navigator.push(
//               //   context,
//               //   MaterialPageRoute(
//               //     builder: (context) => MapViewPage(
//               //       url: MapUrl.getCrewWithIdEndPoint(id),
//               //     ),
//               //   ),
//               // );

//               await browser.open(
//                   url: WebUri(MapUrl.getCrewWithIdEndPoint(id)),
//                   // "https://mapapi.ariespro.com/main/crew_main/CIVM_Map/USRQWXH589Z/${id}"),
//                   settings: ChromeSafariBrowserSettings(
//                       shareState: CustomTabsShareState.SHARE_STATE_OFF,
//                       barCollapsingEnabled: true));
//             },
//           ),
//           ListTile(
//             leading: const Icon(
//               Icons.location_on,
//             ),
//             title: const Text('Live IVM System Map'),
//             textColor: const Color.fromARGB(255, 7, 59, 120),
//             iconColor: const Color.fromARGB(255, 7, 59, 120),
//             onTap: () {
//               provider.getLocation();
//               Navigator.of(context).push(MaterialPageRoute(
//                   builder: (context) => const MapScreenLeafLat()));
//             },
//           ),
//           ListTile(
//             leading: const Icon(
//               Icons.logout,
//             ),
//             title: const Text('Log Out'),
//             textColor: const Color.fromARGB(255, 7, 59, 120),
//             iconColor: const Color.fromARGB(255, 7, 59, 120),
//             onTap: () {
// // // Constants.prefs.setBool("LoggedIn", false);
//               userPreferences.remove().then((value) {
//                 Navigator.of(context).push(MaterialPageRoute(
//                     builder: (BuildContext context) => const LoginPage()));
//               });
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   Future<void> setUserName() async {
//     final userPreferences = Provider.of<UserPref>(context, listen: false);
//     UserModel data = await userPreferences.getUser();
//     Image.network(
//       'https://civm.ariespro.com/assets/clientuploads/${data.user!.profilePhoto}',
//     );
//     String imageUrl =
//         'https://civm.ariespro.com/assets/clientuploads/${data.user!.profilePhoto}';
//     _imagePath = imageUrl;
//     setState(() {
//       String fName =
//           (data.user!.fName == 'null') ? '' : data.user!.fName.toString();
//       String lName =
//           (data.user!.lName == 'null') ? '' : data.user!.lName.toString();
//       // userName = '${data.user!.fName} ${(data.user!.lName) != null? data.user!.lName :''}';
//       userName = '$fName $lName';
//     });
//   }
// }
