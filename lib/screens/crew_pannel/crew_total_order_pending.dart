// // import 'package:CIVM/screens/admin_pannel/map_view_admin.dart';
// import 'dart:io';

// import 'package:CIVM/models/user_model.dart';
// import 'package:CIVM/repository/map_url.dart';
// import 'package:CIVM/screens/admin_pannel/row_maintenance_view/image_paint_screen.dart';
// import 'package:CIVM/screens/admin_pannel/row_maintenance_view/pdf_view.dart';
// import 'package:CIVM/screens/chat_history.dart';
// import 'package:CIVM/screens/my_chrome_safari_map_recording.dart';
// import 'package:CIVM/screens/video_folder/fullVideo/full_screen_video_player.dart';
// import 'package:CIVM/utils/common_functions.dart';
// import 'package:CIVM/utils/user_pref.dart';
// import 'package:CIVM/view_model/crew_pending_view_model.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// // import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// import 'package:intl/intl.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:photo_view/photo_view.dart';
// import 'package:photo_view/photo_view_gallery.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../../../data/response/status.dart';
// import '../../../utils/custom_toast_snackbar_progressdialog.dart';
// import 'package:http/http.dart' as http;

// // ignore: must_be_immutable
// class CrewTotalOrderPending extends StatefulWidget {
//   String budgetType;
//   String maintenanceType;
//   String heading;

//   CrewTotalOrderPending(
//       {Key? key,
//       required this.budgetType,
//       required this.maintenanceType,
//       required this.heading})
//       : super(key: key);

//   @override
//   State<CrewTotalOrderPending> createState() =>
//       _CrewTotalOrderPendingState();
// }

// class _CrewTotalOrderPendingState extends State<CrewTotalOrderPending> {
//   List<String> menu = [];

//   int substationId = 0;
//   int feederId = 0;

//   // ignore: prefer_typing_uninitialized_variables
//   var selectedSubstation;
//   // ignore: prefer_typing_uninitialized_variables
//   var selectedFeeder;

//   String userName = '';

//   final TextEditingController _input = TextEditingController();
//   final browser = MyChromeSafariBrowser();

//   String formattedContractYear = '';
//   String formattedNextMaintDue = '';

//   CrewPendingViewModel crewPendingViewModel = CrewPendingViewModel();

//   String id = '';

//   @override
//   void initState() {
//     getPendingRecords();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//         appBar: AppBar(
//           iconTheme: const IconThemeData(color: Colors.white),
//           title: const Text(
//             'Change Order (Total Order Pending)',
//             style: TextStyle(color: Colors.white),
//           ),
//           backgroundColor: const Color.fromARGB(255, 7, 59, 120),
//         ),
//         body: ChangeNotifierProvider<CrewPendingViewModel>(
//             create: (BuildContext context) => crewPendingViewModel,
//             child:
//                 Consumer<CrewPendingViewModel>(builder: (context, value, _) {
//               switch (value.iniciatedCancelWorkApprovalTabularData.status) {
//                 case Status.LOADING:
//                   return const Center(child: CircularProgressIndicator());
//                 case Status.ERROR:
//                   return
//                       // CustomToastSnackBarProgressDialog.flushBarErrorMessage(
//                       //     value.iniciatedCancelWorkApprovalTabularData.message
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
//                   print('widget.heading ${widget.heading}');
//                   return RefreshIndicator(
//                     onRefresh: () async {
//                       _input.clear();
//                       selectedSubstation = null;
//                       selectedFeeder = null;
//                       await crewPendingViewModel
//                           .fetchPendingCancelWorkApprovalTabularListApi(
//                               context, 'PENDING','0', id);
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
//                                 "TOTAL NO OF RECORDS : ${crewPendingViewModel.iniciatedCancelWorkApprovalTabularData.data!.data!.length.toString()}",
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
//                                 itemCount: crewPendingViewModel
//                                     .iniciatedCancelWorkApprovalTabularData
//                                     .data!
//                                     .data!
//                                     .length,
//                                 itemBuilder: (BuildContext ctxt, int index) {
//                                   String formattedDateCreateDate = '';
//                                   if (crewPendingViewModel
//                                           .iniciatedCancelWorkApprovalTabularData
//                                           .data!
//                                           .data![index]
//                                           .createDate
//                                           .toString() !=
//                                       'N/A') {
//                                     String? dateStringCreateDate =
//                                         crewPendingViewModel
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
//                                                               await crewPendingViewModel
//                                                                   .fetchImageApi(
//                                                                 context,
//                                                                 crewPendingViewModel
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
//                                                                   crewPendingViewModel
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
//                                                             (crewPendingViewModel
//                                                                             .iniciatedCancelWorkApprovalTabularData
//                                                                             .data!
//                                                                             .data![
//                                                                                 index]
//                                                                             .maintType ==
//                                                                         null ||
//                                                                     crewPendingViewModel
//                                                                             .iniciatedCancelWorkApprovalTabularData
//                                                                             .data!
//                                                                             .data![
//                                                                                 index]
//                                                                             .maintType
//                                                                             .toString() ==
//                                                                         'null')
//                                                                 ? ''
//                                                                 : crewPendingViewModel
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
//                                                             (crewPendingViewModel
//                                                                             .iniciatedCancelWorkApprovalTabularData
//                                                                             .data!
//                                                                             .data![
//                                                                                 index]
//                                                                             .tokenNo ==
//                                                                         null ||
//                                                                     crewPendingViewModel
//                                                                             .iniciatedCancelWorkApprovalTabularData
//                                                                             .data!
//                                                                             .data![
//                                                                                 index]
//                                                                             .tokenNo
//                                                                             .toString() ==
//                                                                         'null')
//                                                                 ? ''
//                                                                 : crewPendingViewModel
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
//                                                         // (crewPendingViewModel
//                                                         //             .iniciatedCancelWorkApprovalTabularData
//                                                         //             .data!
//                                                         //             .data![
//                                                         //                 index]
//                                                         //             .status ==
//                                                         //         'INITIATED')
//                                                         //     ? Column(
//                                                         //         children: [
//                                                         //           Align(
//                                                         //             alignment:
//                                                         //                 Alignment
//                                                         //                     .topLeft,
//                                                         //             child:
//                                                         //                 Padding(
//                                                         //               padding: const EdgeInsets
//                                                         //                   .only(
//                                                         //                   top:
//                                                         //                       4.0),
//                                                         //               child:
//                                                         //                   InkWell(
//                                                         //                 onTap:
//                                                         //                     () async {
//                                                         //                   approveOrCancelOrder(
//                                                         //                       crewPendingViewModel.iniciatedCancelWorkApprovalTabularData.data!.data![index].tokenNo.toString(),
//                                                         //                       'WORK FOR APPROVAL');
//                                                         //                 },
//                                                         //                 child:
//                                                         //                     Container(
//                                                         //                   padding: const EdgeInsets
//                                                         //                       .all(
//                                                         //                       2),
//                                                         //                   alignment:
//                                                         //                       Alignment.center,
//                                                         //                   width:
//                                                         //                       size.width * 0.2,
//                                                         //                   // width: MediaQuery.of(context).size.width,
//                                                         //                   // height: 35,
//                                                         //                   decoration: const BoxDecoration(
//                                                         //                       // shape: BoxShape.circle,
//                                                         //                       //borderRadius: BorderRadius.circular(25),
//                                                         //                       boxShadow: [
//                                                         //                         BoxShadow(color: Color.fromARGB(255, 3, 47, 97), blurRadius: 5, offset: Offset(2.0, 5.0))
//                                                         //                       ],
//                                                         //                       color: Color.fromARGB(255, 130, 193, 245),
//                                                         //                       gradient: LinearGradient(
//                                                         //                         colors: [
//                                                         //                           Color.fromARGB(255, 49, 150, 232),
//                                                         //                           Color.fromARGB(255, 49, 150, 232),
//                                                         //                         ],
//                                                         //                       )),
//                                                         //                   child:
//                                                         //                       const Padding(
//                                                         //                     padding:
//                                                         //                         EdgeInsets.all(2.0),
//                                                         //                     child:
//                                                         //                         Align(
//                                                         //                       alignment: Alignment.center,
//                                                         //                       child: Text(
//                                                         //                         "APPROVE",
//                                                         //                         textAlign: TextAlign.left,
//                                                         //                         style: TextStyle(
//                                                         //                           color: Colors.white,
//                                                         //                           fontWeight: FontWeight.bold,
//                                                         //                           fontSize: 12,
//                                                         //                         ),
//                                                         //                       ),
//                                                         //                     ),
//                                                         //                   ),
//                                                         //                 ),
//                                                         //               ),
//                                                         //             ),
//                                                         //           ),
//                                                         //           Align(
//                                                         //             alignment:
//                                                         //                 Alignment
//                                                         //                     .topLeft,
//                                                         //             child:
//                                                         //                 Padding(
//                                                         //               padding: const EdgeInsets
//                                                         //                   .only(
//                                                         //                   top:
//                                                         //                       4.0),
//                                                         //               child:
//                                                         //                   InkWell(
//                                                         //                 onTap:
//                                                         //                     () async {
//                                                         //                   approveOrCancelOrder(
//                                                         //                       crewPendingViewModel.iniciatedCancelWorkApprovalTabularData.data!.data![index].tokenNo.toString(),
//                                                         //                       'CANCELLED');
//                                                         //                 },
//                                                         //                 child:
//                                                         //                     Container(
//                                                         //                   padding: const EdgeInsets
//                                                         //                       .all(
//                                                         //                       2),
//                                                         //                   alignment:
//                                                         //                       Alignment.center,
//                                                         //                   width:
//                                                         //                       size.width * 0.2,
//                                                         //                   // width: MediaQuery.of(context).size.width,
//                                                         //                   // height: 35,
//                                                         //                   decoration: const BoxDecoration(
//                                                         //                       // shape: BoxShape.circle,
//                                                         //                       //borderRadius: BorderRadius.circular(25),
//                                                         //                       boxShadow: [
//                                                         //                         BoxShadow(color: Color.fromARGB(255, 3, 47, 97), blurRadius: 5, offset: Offset(2.0, 5.0))
//                                                         //                       ],
//                                                         //                       color: Color.fromARGB(255, 130, 193, 245),
//                                                         //                       gradient: LinearGradient(
//                                                         //                         colors: [
//                                                         //                           Colors.red,
//                                                         //                           Colors.red,
//                                                         //                         ],
//                                                         //                       )),
//                                                         //                   child:
//                                                         //                       const Padding(
//                                                         //                     padding:
//                                                         //                         EdgeInsets.all(2.0),
//                                                         //                     child:
//                                                         //                         Align(
//                                                         //                       alignment: Alignment.center,
//                                                         //                       child: Text(
//                                                         //                         "CANCEL",
//                                                         //                         textAlign: TextAlign.left,
//                                                         //                         style: TextStyle(
//                                                         //                           color: Colors.white,
//                                                         //                           fontWeight: FontWeight.bold,
//                                                         //                           fontSize: 12,
//                                                         //                         ),
//                                                         //                       ),
//                                                         //                     ),
//                                                         //                   ),
//                                                         //                 ),
//                                                         //               ),
//                                                         //             ),
//                                                         //           ),
//                                                         //         ],
//                                                         //       )
//                                                         //     :
//                                                         Align(
//                                                           alignment:
//                                                               Alignment.topLeft,
//                                                           child: Text(
//                                                             (crewPendingViewModel
//                                                                             .iniciatedCancelWorkApprovalTabularData
//                                                                             .data!
//                                                                             .data![
//                                                                                 index]
//                                                                             .status ==
//                                                                         null ||
//                                                                     crewPendingViewModel
//                                                                             .iniciatedCancelWorkApprovalTabularData
//                                                                             .data!
//                                                                             .data![
//                                                                                 index]
//                                                                             .status
//                                                                             .toString() ==
//                                                                         'null')
//                                                                 ? ''
//                                                                 : crewPendingViewModel
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
//                                                             (crewPendingViewModel
//                                                                             .iniciatedCancelWorkApprovalTabularData
//                                                                             .data!
//                                                                             .data![
//                                                                                 index]
//                                                                             .substation ==
//                                                                         null ||
//                                                                     crewPendingViewModel
//                                                                             .iniciatedCancelWorkApprovalTabularData
//                                                                             .data!
//                                                                             .data![
//                                                                                 index]
//                                                                             .substation
//                                                                             .toString() ==
//                                                                         'null')
//                                                                 ? ''
//                                                                 : crewPendingViewModel
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
//                                                             (crewPendingViewModel
//                                                                             .iniciatedCancelWorkApprovalTabularData
//                                                                             .data!
//                                                                             .data![
//                                                                                 index]
//                                                                             .feeder ==
//                                                                         null ||
//                                                                     crewPendingViewModel
//                                                                             .iniciatedCancelWorkApprovalTabularData
//                                                                             .data!
//                                                                             .data![
//                                                                                 index]
//                                                                             .feeder
//                                                                             .toString() ==
//                                                                         'null')
//                                                                 ? ''
//                                                                 : crewPendingViewModel
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
//                                                             (crewPendingViewModel
//                                                                             .iniciatedCancelWorkApprovalTabularData
//                                                                             .data!
//                                                                             .data![
//                                                                                 index]
//                                                                             .contractor ==
//                                                                         null ||
//                                                                     crewPendingViewModel
//                                                                             .iniciatedCancelWorkApprovalTabularData
//                                                                             .data!
//                                                                             .data![
//                                                                                 index]
//                                                                             .contractor
//                                                                             .toString() ==
//                                                                         'null')
//                                                                 ? ''
//                                                                 : crewPendingViewModel
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
//                                                             (crewPendingViewModel
//                                                                             .iniciatedCancelWorkApprovalTabularData
//                                                                             .data!
//                                                                             .data![
//                                                                                 index]
//                                                                             .createDate ==
//                                                                         null ||
//                                                                     crewPendingViewModel
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
//                                                             (crewPendingViewModel
//                                                                             .iniciatedCancelWorkApprovalTabularData
//                                                                             .data!
//                                                                             .data![
//                                                                                 index]
//                                                                             .followUpDate ==
//                                                                         null ||
//                                                                     crewPendingViewModel
//                                                                             .iniciatedCancelWorkApprovalTabularData
//                                                                             .data!
//                                                                             .data![
//                                                                                 index]
//                                                                             .followUpDate
//                                                                             .toString() ==
//                                                                         'null')
//                                                                 ? ''
//                                                                 : formatDateIfNeeded(crewPendingViewModel
//                                                                     .iniciatedCancelWorkApprovalTabularData
//                                                                     .data!
//                                                                     .data![
//                                                                         index]
//                                                                     .followUpDate
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

//                                                   // Expanded(
//                                                   //   // alignment: Alignment.topLeft,
//                                                   //   child: Column(
//                                                   //     children: [
//                                                   //       const Align(
//                                                   //         alignment:
//                                                   //             Alignment.topLeft,
//                                                   //         child: Text(
//                                                   //           "NEXT MAINT DUE: ",
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
//                                                   //                           .nextMaintDue ==
//                                                   //                       null ||
//                                                   //                   iniciatedCancelWorkForApprovalViewModel
//                                                   //                           .iniciatedCancelWorkApprovalTabularData
//                                                   //                           .data!
//                                                   //                           .data![index]
//                                                   //                           .nextMaintDue
//                                                   //                           .toString() ==
//                                                   //                       'null')
//                                                   //               ? ''
//                                                   //               : formattedNextMaintDue,
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
//                                             Column(
//                                               children: [
//                                                 // const Divider(
//                                                 //   color: Colors.grey,
//                                                 // ),
//                                                 Padding(
//                                                   padding:
//                                                       const EdgeInsets.only(
//                                                           left: 8.0),
//                                                   child: Row(
//                                                     children: [
//                                                       Expanded(
//                                                         // alignment: Alignment.topLeft,
//                                                         child: Column(
//                                                           children: [
//                                                             const Align(
//                                                               alignment:
//                                                                   Alignment
//                                                                       .topLeft,
//                                                               child: Text(
//                                                                 "SERVICE STREET ADDRESS: ",
//                                                                 textAlign:
//                                                                     TextAlign
//                                                                         .left,
//                                                                 style:
//                                                                     TextStyle(
//                                                                   fontSize: 12,
//                                                                   fontWeight:
//                                                                       FontWeight
//                                                                           .bold,
//                                                                   color: Colors
//                                                                       .white,
//                                                                 ),
//                                                               ),
//                                                             ),
//                                                             Align(
//                                                               alignment:
//                                                                   Alignment
//                                                                       .topLeft,
//                                                               child: Text(
//                                                                 (crewPendingViewModel.iniciatedCancelWorkApprovalTabularData.data!.data![index].streetAddress ==
//                                                                             null ||
//                                                                         crewPendingViewModel.iniciatedCancelWorkApprovalTabularData.data!.data![index].streetAddress.toString() ==
//                                                                             'null')
//                                                                     ? ''
//                                                                     : crewPendingViewModel
//                                                                         .iniciatedCancelWorkApprovalTabularData
//                                                                         .data!
//                                                                         .data![
//                                                                             index]
//                                                                         .streetAddress
//                                                                         .toString(),
//                                                                 textAlign:
//                                                                     TextAlign
//                                                                         .left,
//                                                                 style:
//                                                                     const TextStyle(
//                                                                   fontSize: 12,
//                                                                   //  fontWeight:
//                                                                   //      FontWeight.bold,
//                                                                   color: Colors
//                                                                       .white,
//                                                                 ),
//                                                               ),
//                                                             ),
//                                                           ],
//                                                         ),
//                                                       ),
//                                                       Expanded(
//                                                         // alignment: Alignment.topLeft,
//                                                         child: Column(
//                                                           children: [
//                                                             const Align(
//                                                               alignment:
//                                                                   Alignment
//                                                                       .topLeft,
//                                                               child: Text(
//                                                                 "SERVICE MAP LOCATION: ",
//                                                                 textAlign:
//                                                                     TextAlign
//                                                                         .left,
//                                                                 style:
//                                                                     TextStyle(
//                                                                   fontSize: 12,
//                                                                   fontWeight:
//                                                                       FontWeight
//                                                                           .bold,
//                                                                   color: Colors
//                                                                       .white,
//                                                                 ),
//                                                               ),
//                                                             ),
//                                                             Align(
//                                                               alignment:
//                                                                   Alignment
//                                                                       .topLeft,
//                                                               child: Text(
//                                                                 (crewPendingViewModel.iniciatedCancelWorkApprovalTabularData.data!.data![index].mapLocation ==
//                                                                             null ||
//                                                                         crewPendingViewModel.iniciatedCancelWorkApprovalTabularData.data!.data![index].mapLocation.toString() ==
//                                                                             'null')
//                                                                     ? ''
//                                                                     : crewPendingViewModel
//                                                                         .iniciatedCancelWorkApprovalTabularData
//                                                                         .data!
//                                                                         .data![
//                                                                             index]
//                                                                         .mapLocation
//                                                                         .toString(),
//                                                                 textAlign:
//                                                                     TextAlign
//                                                                         .left,
//                                                                 style:
//                                                                     const TextStyle(
//                                                                   fontSize: 12,
//                                                                   //  fontWeight:
//                                                                   //      FontWeight.bold,
//                                                                   color: Colors
//                                                                       .white,
//                                                                 ),
//                                                               ),
//                                                             ),
//                                                           ],
//                                                         ),
//                                                       ),
//                                                       Expanded(
//                                                         // alignment: Alignment.topLeft,
//                                                         child: Column(
//                                                           children: [
//                                                             const Align(
//                                                               alignment:
//                                                                   Alignment
//                                                                       .topLeft,
//                                                               child: Text(
//                                                                 "ADMIN NOTES 1: ",
//                                                                 textAlign:
//                                                                     TextAlign
//                                                                         .left,
//                                                                 style:
//                                                                     TextStyle(
//                                                                   fontSize: 12,
//                                                                   fontWeight:
//                                                                       FontWeight
//                                                                           .bold,
//                                                                   color: Colors
//                                                                       .white,
//                                                                 ),
//                                                               ),
//                                                             ),
//                                                             Align(
//                                                               alignment:
//                                                                   Alignment
//                                                                       .topLeft,
//                                                               child: Text(
//                                                                 (crewPendingViewModel.iniciatedCancelWorkApprovalTabularData.data!.data![index].adminNotes1 ==
//                                                                             null ||
//                                                                         crewPendingViewModel.iniciatedCancelWorkApprovalTabularData.data!.data![index].adminNotes1.toString() ==
//                                                                             'null')
//                                                                     ? ''
//                                                                     : crewPendingViewModel
//                                                                         .iniciatedCancelWorkApprovalTabularData
//                                                                         .data!
//                                                                         .data![
//                                                                             index]
//                                                                         .adminNotes1
//                                                                         .toString(),
//                                                                 textAlign:
//                                                                     TextAlign
//                                                                         .left,
//                                                                 style:
//                                                                     const TextStyle(
//                                                                   fontSize: 12,
//                                                                   //  fontWeight:
//                                                                   //      FontWeight.bold,
//                                                                   color: Colors
//                                                                       .white,
//                                                                 ),
//                                                               ),
//                                                             ),
//                                                           ],
//                                                         ),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ),
//                                               ],
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
//                                                             (crewPendingViewModel
//                                                                             .iniciatedCancelWorkApprovalTabularData
//                                                                             .data!
//                                                                             .data![
//                                                                                 index]
//                                                                             .contractorNotes ==
//                                                                         null ||
//                                                                     crewPendingViewModel
//                                                                             .iniciatedCancelWorkApprovalTabularData
//                                                                             .data!
//                                                                             .data![
//                                                                                 index]
//                                                                             .contractorNotes
//                                                                             .toString() ==
//                                                                         'null')
//                                                                 ? ''
//                                                                 : crewPendingViewModel
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
//                                                             (crewPendingViewModel
//                                                                             .iniciatedCancelWorkApprovalTabularData
//                                                                             .data!
//                                                                             .data![
//                                                                                 index]
//                                                                             .supervisorNotes ==
//                                                                         null ||
//                                                                     crewPendingViewModel
//                                                                             .iniciatedCancelWorkApprovalTabularData
//                                                                             .data!
//                                                                             .data![
//                                                                                 index]
//                                                                             .supervisorNotes
//                                                                             .toString() ==
//                                                                         'null')
//                                                                 ? ''
//                                                                 : crewPendingViewModel
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
//                                                             (crewPendingViewModel
//                                                                             .iniciatedCancelWorkApprovalTabularData
//                                                                             .data!
//                                                                             .data![
//                                                                                 index]
//                                                                             .plannerNotes ==
//                                                                         null ||
//                                                                     crewPendingViewModel
//                                                                             .iniciatedCancelWorkApprovalTabularData
//                                                                             .data!
//                                                                             .data![
//                                                                                 index]
//                                                                             .plannerNotes
//                                                                             .toString() ==
//                                                                         'null')
//                                                                 ? ''
//                                                                 : crewPendingViewModel
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
//                                                   )
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
//                                                             (crewPendingViewModel
//                                                                             .iniciatedCancelWorkApprovalTabularData
//                                                                             .data!
//                                                                             .data![
//                                                                                 index]
//                                                                             .contractYear ==
//                                                                         null ||
//                                                                     crewPendingViewModel
//                                                                             .iniciatedCancelWorkApprovalTabularData
//                                                                             .data!
//                                                                             .data![
//                                                                                 index]
//                                                                             .contractYear
//                                                                             .toString() ==
//                                                                         'null')
//                                                                 ? ''
//                                                                 : getYearOrNA(crewPendingViewModel
//                                                                     .iniciatedCancelWorkApprovalTabularData
//                                                                     .data!
//                                                                     .data![
//                                                                         index]
//                                                                     .contractYear
//                                                                     .toString()),
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
//                                                             (crewPendingViewModel
//                                                                             .iniciatedCancelWorkApprovalTabularData
//                                                                             .data!
//                                                                             .data![
//                                                                                 index]
//                                                                             .contractorCompany ==
//                                                                         null ||
//                                                                     crewPendingViewModel
//                                                                             .iniciatedCancelWorkApprovalTabularData
//                                                                             .data!
//                                                                             .data![
//                                                                                 index]
//                                                                             .contractorCompany
//                                                                             .toString() ==
//                                                                         'null')
//                                                                 ? ''
//                                                                 : crewPendingViewModel
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
//                                                             (crewPendingViewModel
//                                                                             .iniciatedCancelWorkApprovalTabularData
//                                                                             .data!
//                                                                             .data![
//                                                                                 index]
//                                                                             .totalCost ==
//                                                                         null ||
//                                                                     crewPendingViewModel
//                                                                             .iniciatedCancelWorkApprovalTabularData
//                                                                             .data!
//                                                                             .data![
//                                                                                 index]
//                                                                             .totalCost
//                                                                             .toString() ==
//                                                                         'null')
//                                                                 ? ''
//                                                                 : crewPendingViewModel
//                                                                     .iniciatedCancelWorkApprovalTabularData
//                                                                     .data!
//                                                                     .data![
//                                                                         index]
//                                                                     .totalCost
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
//                                                   )
//                                                 ],
//                                               ),
//                                             ),

//                                             Padding(
//                                                 padding: const EdgeInsets.only(
//                                                     left: 8.0),
//                                                 child: Column(
//                                                   children: [
//                                                     const Divider(
//                                                       color: Colors.grey,
//                                                     ),
//                                                     Row(
//                                                       children: [
//                                                         Expanded(
//                                                           // alignment: Alignment.topLeft,
//                                                           child: Column(
//                                                             children: [
//                                                               const Align(
//                                                                 alignment:
//                                                                     Alignment
//                                                                         .topLeft,
//                                                                 child: Text(
//                                                                   "DATE OF INSPECTION: ",
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
//                                                                   (crewPendingViewModel.iniciatedCancelWorkApprovalTabularData.data!.data![index].dateOfInspection ==
//                                                                               null ||
//                                                                           crewPendingViewModel.iniciatedCancelWorkApprovalTabularData.data!.data![index].dateOfInspection.toString() ==
//                                                                               'null')
//                                                                       ? ''
//                                                                       : formatDateIfNeeded(crewPendingViewModel
//                                                                           .iniciatedCancelWorkApprovalTabularData
//                                                                           .data!
//                                                                           .data![
//                                                                               index]
//                                                                           .dateOfInspection
//                                                                           .toString()),
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
//                                                         ),
//                                                         Expanded(
//                                                           // alignment: Alignment.topLeft,
//                                                           child: Column(
//                                                             children: [
//                                                               const Align(
//                                                                 alignment:
//                                                                     Alignment
//                                                                         .topLeft,
//                                                                 child: Text(
//                                                                   "ESTIMATED TIME: ",
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
//                                                                   (crewPendingViewModel.iniciatedCancelWorkApprovalTabularData.data!.data![index].estTime ==
//                                                                               null ||
//                                                                           crewPendingViewModel.iniciatedCancelWorkApprovalTabularData.data!.data![index].estTime.toString() ==
//                                                                               'null')
//                                                                       ? ''
//                                                                       : crewPendingViewModel
//                                                                           .iniciatedCancelWorkApprovalTabularData
//                                                                           .data!
//                                                                           .data![
//                                                                               index]
//                                                                           .estTime
//                                                                           .toString(),
//                                                                   textAlign:
//                                                                       TextAlign
//                                                                           .left,
//                                                                   style:
//                                                                       const TextStyle(
//                                                                     fontSize:
//                                                                         12,
//                                                                     color: Colors
//                                                                         .white,
//                                                                   ),
//                                                                 ),
//                                                               ),
//                                                             ],
//                                                           ),
//                                                         ),
//                                                         Expanded(
//                                                           // alignment: Alignment.topLeft,
//                                                           child: Column(
//                                                             children: [
//                                                               const Align(
//                                                                 alignment:
//                                                                     Alignment
//                                                                         .topLeft,
//                                                                 child: Text(
//                                                                   "MAINTENANCE TYPE: ",
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
//                                                                   (crewPendingViewModel.iniciatedCancelWorkApprovalTabularData.data!.data![index].type ==
//                                                                               null ||
//                                                                           crewPendingViewModel.iniciatedCancelWorkApprovalTabularData.data!.data![index].type.toString() ==
//                                                                               'null')
//                                                                       ? ''
//                                                                       : crewPendingViewModel
//                                                                           .iniciatedCancelWorkApprovalTabularData
//                                                                           .data!
//                                                                           .data![
//                                                                               index]
//                                                                           .type
//                                                                           .toString(),
//                                                                   textAlign:
//                                                                       TextAlign
//                                                                           .left,
//                                                                   style:
//                                                                       const TextStyle(
//                                                                     fontSize:
//                                                                         12,
//                                                                     color: Colors
//                                                                         .white,
//                                                                   ),
//                                                                 ),
//                                                               ),
//                                                             ],
//                                                           ),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ],
//                                                 )),
//                                             Column(
//                                               children: [
//                                                 const Divider(
//                                                   color: Colors.grey,
//                                                 ),
//                                                 Padding(
//                                                   padding:
//                                                       const EdgeInsets.only(
//                                                           left: 8.0),
//                                                   child: Row(
//                                                     children: [
//                                                         Expanded(
//                                                         // alignment: Alignment.topLeft,
//                                                         child: Column(
//                                                           children: [
//                                                             const Align(
//                                                               alignment:
//                                                                   Alignment
//                                                                       .topLeft,
//                                                               child: Text(
//                                                                 "INITIATED BY: ",
//                                                                 textAlign:
//                                                                     TextAlign
//                                                                         .left,
//                                                                 style:
//                                                                     TextStyle(
//                                                                   fontSize: 12,
//                                                                   fontWeight:
//                                                                       FontWeight
//                                                                           .bold,
//                                                                   color: Colors
//                                                                       .white,
//                                                                 ),
//                                                               ),
//                                                             ),
//                                                             Align(
//                                                               alignment:
//                                                                   Alignment
//                                                                       .topLeft,
//                                                               child: Text(
//                                                                 (crewPendingViewModel
//                                                                           .iniciatedCancelWorkApprovalTabularData
//                                                                           .data!
//                                                                           .data![index].initiatedBy ==
//                                                                             null ||
//                                                                         crewPendingViewModel
//                                                                           .iniciatedCancelWorkApprovalTabularData
//                                                                           .data!
//                                                                           .data![index].initiatedBy.toString() ==
//                                                                             'null')
//                                                                     ? ''
//                                                                     : crewPendingViewModel
//                                                                           .iniciatedCancelWorkApprovalTabularData
//                                                                           .data!
//                                                                           .data![
//                                                                             index]
//                                                                         .initiatedBy
//                                                                         .toString(),
//                                                                 textAlign:
//                                                                     TextAlign
//                                                                         .left,
//                                                                 style:
//                                                                     const TextStyle(
//                                                                   fontSize: 12,
//                                                                   //  fontWeight:
//                                                                   //      FontWeight.bold,
//                                                                   color: Colors
//                                                                       .white,
//                                                                 ),
//                                                               ),
//                                                             ),
//                                                           ],
//                                                         ),
//                                                       ),
//                                                              Expanded(
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
//                                                                   tokenNo: crewPendingViewModel
//                                                                           .iniciatedCancelWorkApprovalTabularData
//                                                                           .data!
//                                                                           .data![index]
//                                                                       .tokenNo
//                                                                       .toString()),
//                                                             );
//                                                           },
//                                                           child: Align(
//                                                             alignment: Alignment
//                                                                 .topLeft,
//                                                             child: Text(
//                                                               (crewPendingViewModel
//                                                                           .iniciatedCancelWorkApprovalTabularData
//                                                                           .data!
//                                                                           .data![index]
//                                                                               .addChatNotes ==
//                                                                           null ||
//                                                                       crewPendingViewModel
//                                                                           .iniciatedCancelWorkApprovalTabularData
//                                                                           .data!
//                                                                           .data![index]
//                                                                               .addChatNotes
//                                                                               .toString() ==
//                                                                           'null')
//                                                                   ? ''
//                                                                   : crewPendingViewModel
//                                                                           .iniciatedCancelWorkApprovalTabularData
//                                                                           .data!
//                                                                           .data![index]
//                                                                       .addChatNotes
//                                                                       .toString(),
//                                                               textAlign:
//                                                                   TextAlign
//                                                                       .left,
//                                                               style: const TextStyle(
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
                                               
//                                                       Expanded(
//                                                        // flex: 2,
//                                                         child: Column(
//                                                           children: [
//                                                             InkWell(
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
//                                                                 // Navigator.of(
//                                                                 //         context)
//                                                                 //     .push(MaterialPageRoute(
//                                                                 //         builder: (BuildContext context) => MapViewAdmin(
//                                                                 //               id: iniciatedCancelWorkForApprovalViewModel.iniciatedCancelWorkApprovalTabularData.data!.data![index].id.toString(),
//                                                                 //             )));
//                                                                 // Navigator
//                                                                 //     .push(
//                                                                 //   context,
//                                                                 //   MaterialPageRoute(
//                                                                 //     builder:
//                                                                 //         (context) =>
//                                                                 //             MapViewPage(
//                                                                 //       url: MapUrl.getAdminEndPoint(
//                                                                 //           iniciatedCancelWorkForApprovalViewModel.iniciatedCancelWorkApprovalTabularData.data!.data![index].tokenNo.toString(),
//                                                                 //           id),
//                                                                 //     ),
//                                                                 //   ),
//                                                                 // );
//                                                                 await browser.open(
//                                                                     url: WebUri(
//                                                                         // "https://mapapi.ariespro.com/main/admin/CIVM_Map/${iniciatedCancelWorkForApprovalViewModel.iniciatedCancelWorkApprovalTabularData.data!.data![index].tokenNo.toString()}/USRQWXH589Z"),
//                                                                         MapUrl.getPlannerWithTokenEndPoint(
//                                                                             crewPendingViewModel.iniciatedCancelWorkApprovalTabularData.data!.data![index].tokenNo
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
//                                                             )
//                                                           ],
//                                                         ),
//                                                       ),

//                                                       // Expanded(
//                                                       //   // alignment: Alignment.topLeft,
//                                                       //   child: Column(
//                                                       //     children: [
//                                                       //       const Align(
//                                                       //         alignment:
//                                                       //             Alignment
//                                                       //                 .topLeft,
//                                                       //         child: Text(
//                                                       //           "CYCLE: ",
//                                                       //           textAlign:
//                                                       //               TextAlign
//                                                       //                   .left,
//                                                       //           style:
//                                                       //               TextStyle(
//                                                       //             fontSize:
//                                                       //                 12,
//                                                       //             fontWeight:
//                                                       //                 FontWeight.bold,
//                                                       //             color: Colors
//                                                       //                 .white,
//                                                       //           ),
//                                                       //         ),
//                                                       //       ),
//                                                       //       Align(
//                                                       //         alignment:
//                                                       //             Alignment
//                                                       //                 .topLeft,
//                                                       //         child: Text(
//                                                       //           (iniciatedCancelWorkForApprovalViewModel.iniciatedCancelWorkApprovalTabularData.data!.data![index].cycle == null ||
//                                                       //                   iniciatedCancelWorkForApprovalViewModel.iniciatedCancelWorkApprovalTabularData.data!.data![index].cycle.toString() ==
//                                                       //                       'null')
//                                                       //               ? ''
//                                                       //               : iniciatedCancelWorkForApprovalViewModel
//                                                       //                   .iniciatedCancelWorkApprovalTabularData
//                                                       //                   .data!
//                                                       //                   .data![index]
//                                                       //                   .cycle
//                                                       //                   .toString(),
//                                                       //           textAlign:
//                                                       //               TextAlign
//                                                       //                   .left,
//                                                       //           style:
//                                                       //               const TextStyle(
//                                                       //             fontSize:
//                                                       //                 12,
//                                                       //             //  fontWeight:
//                                                       //             //      FontWeight.bold,
//                                                       //             color: Colors
//                                                       //                 .white,
//                                                       //           ),
//                                                       //         ),
//                                                       //       ),
//                                                       //     ],
//                                                       //   ),
//                                                       // ),
//                                                       // Expanded(
//                                                       //   // alignment: Alignment.topLeft,
//                                                       //   child: Column(
//                                                       //     children: [
//                                                       //       const Align(
//                                                       //         alignment:
//                                                       //             Alignment
//                                                       //                 .topLeft,
//                                                       //         child: Text(
//                                                       //           "COST PER MILE: ",
//                                                       //           textAlign:
//                                                       //               TextAlign
//                                                       //                   .left,
//                                                       //           style:
//                                                       //               TextStyle(
//                                                       //             fontSize:
//                                                       //                 12,
//                                                       //             fontWeight:
//                                                       //                 FontWeight.bold,
//                                                       //             color: Colors
//                                                       //                 .white,
//                                                       //           ),
//                                                       //         ),
//                                                       //       ),
//                                                       //       Align(
//                                                       //         alignment:
//                                                       //             Alignment
//                                                       //                 .topLeft,
//                                                       //         child: Text(
//                                                       //           (iniciatedCancelWorkForApprovalViewModel.iniciatedCancelWorkApprovalTabularData.data!.data![index].costPerMile == null ||
//                                                       //                   iniciatedCancelWorkForApprovalViewModel.iniciatedCancelWorkApprovalTabularData.data!.data![index].costPerMile.toString() ==
//                                                       //                       'null')
//                                                       //               ? ''
//                                                       //               : iniciatedCancelWorkForApprovalViewModel
//                                                       //                   .iniciatedCancelWorkApprovalTabularData
//                                                       //                   .data!
//                                                       //                   .data![index]
//                                                       //                   .costPerMile
//                                                       //                   .toString(),
//                                                       //           textAlign:
//                                                       //               TextAlign
//                                                       //                   .left,
//                                                       //           style:
//                                                       //               const TextStyle(
//                                                       //             fontSize:
//                                                       //                 12,
//                                                       //             //  fontWeight:
//                                                       //             //      FontWeight.bold,
//                                                       //             color: Colors
//                                                       //                 .white,
//                                                       //           ),
//                                                       //         ),
//                                                       //       ),
//                                                       //     ],
//                                                       //   ),
//                                                       // ),
//                                                     ],
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                             // const Divider(
//                                             //   color: Colors.grey,
//                                             // ),
//                                             const Padding(
//                                               padding:
//                                                   EdgeInsets.only(left: 8.0),
//                                               child: Row(
//                                                 children: [],
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

//   DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
//       value: item,
//       child: Text(item,
//           style: const TextStyle(
//             fontWeight: FontWeight.normal,
//             fontSize: 20,
//           )));

//   Future<void> setUserName() async {
//     SharedPreferences preferences = await SharedPreferences.getInstance();
//     setState(() {
//       userName =
//           '${preferences.getString('FIRST_NAME')} ${preferences.getString('LAST_NAME')!}';
//     });
//   }

//   Future<void> _filterData(String query) async {
//     if (query.isEmpty) {
//       selectedSubstation = null;
//       selectedFeeder = null;
//       crewPendingViewModel.fetchPendingCancelWorkApprovalTabularListApi(
//           context, 'PENDING','0', id);
//     } else {
//       crewPendingViewModel.iniciatedCancelWorkApprovalTabularData.data!.data = crewPendingViewModel
//           .iniciatedCancelWorkApprovalTabularData.data!.data
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
//               item.totalMiles
//                   .toString()
//                   .toLowerCase()
//                   .contains(query.toLowerCase()) ||
//               item.contractYear.toString().toLowerCase().contains(query.toLowerCase()) ||
//               item.cycle.toString().toLowerCase().contains(query.toLowerCase()) ||
//               item.streetAddress.toString().toLowerCase().contains(query.toLowerCase()) ||
//               item.mapLocation.toString().toLowerCase().contains(query.toLowerCase()) ||
//               item.adminNotes1.toString().toLowerCase().contains(query.toLowerCase()) ||
//               item.dateOfInspection.toString().toLowerCase().contains(query.toLowerCase()) ||
//               item.followUpDate.toString().toLowerCase().contains(query.toLowerCase()) ||
//               item.costPerMile.toString().toLowerCase().contains(query.toLowerCase()) ||
//               item.totalCost.toString().toLowerCase().contains(query.toLowerCase()) ||
//               item.contractor.toString().toLowerCase().contains(query.toLowerCase()) ||
//               item.nextMaintDue.toString().toLowerCase().contains(query.toLowerCase()))
//           .toList();
//     }
//     setState(() {});
//   }

//  Future openDialogPicture(String tokenNo) => showDialog(
//         context: context,
//         builder: (context) {
//           return StatefulBuilder(builder: (context, setState) {
//             // lCPWorkOrdersClosedViewModel.fetchImageApi(
//             //     context,
//             //     //  '1');
//             //     tokenNo.toString());
//             int length =
//                 crewPendingViewModel.imageData.data?.images?.length ?? 0;

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
//     String? fileLocation =
//         crewPendingViewModel.imageData.data?.images![i].imageLocation;

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
//                             borderRadius: BorderRadius.circular(
//                                 5), // Optional rounded corners
//                             child: SizedBox(
//                               height: 150,
//                               width: double.infinity,
//                               child: VideoPlayerWidget(
//                                 videoUrl:
//                                     'https://civm.ariespro.com/assets/clientuploads/$fileLocation',
//                               ),
//                             )))
//                   else
//                     InkWell(
//                       onTap: () {
//                         // openFullSizeImageDialog(imageLocation);
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => ImagePaintScreen(
//                                     imageUrl: fileLocation, tokenNo: tokenNo)));
//                       },
//                       child: Image.network(
//                         'https://civm.ariespro.com/assets/clientuploads/$fileLocation',
//                         // height: 400,
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
//         crewPendingViewModel.fetchPendingCancelWorkApprovalTabularListApi(
//             context, 'PENDING','0', id);
//       } else {
//         print('API request failed with status code: ${response.statusCode}');
//         print('Response body: ${response.body}');
//       }
//     } catch (e) {
//       print('Error: $e');
//     }
//   }

//   void newDateFormat(
//     int index,
//   ) {
//     String? rawCreateDate = crewPendingViewModel
//         .iniciatedCancelWorkApprovalTabularData.data!.data![index].contractYear
//         ?.toString();

//     String? rawNextMaintDue = crewPendingViewModel
//         .iniciatedCancelWorkApprovalTabularData.data!.data![index].nextMaintDue
//         ?.toString();
//     formattedContractYear = extractYear(rawCreateDate);
//     formattedNextMaintDue = extractYear(rawNextMaintDue);
//     print('rawCreateDate $rawCreateDate');
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

//   Future<void> getPendingRecords() async {
//     final userPreferences = Provider.of<UserPref>(context, listen: false);
//     UserModel data = await userPreferences.getUser();

//     id = data.user!.id.toString();
//     print("id test ${id}");
//     crewPendingViewModel.fetchPendingCancelWorkApprovalTabularListApi(
//         context, 'PENDING','0', id);
//   }

//   void approveOrCancelOrder(String tokenNo, String status) async {
//     final userPreferences = Provider.of<UserPref>(context, listen: false);
//     UserModel data = await userPreferences.getUser();
//     String id = data.user!.id.toString();
//     final String url =
//         'https://civmapi.ariespro.com/civmapi/changeOrderLcpCreateOrder/approveOrCancelByToken?tokenNo=$tokenNo&status=$status&id=$id';
//     print('url: $url');
//     try {
//       // showDialog(
//       //   context: context,
//       //   barrierDismissible: false,
//       //   builder: (BuildContext context) {
//       //     return const Center(
//       //       child: CircularProgressIndicator(),
//       //     );
//       //   },
//       // );
//       final response = await http.post(
//         Uri.parse(url),
//         headers: {
//           'Authorization': 'Bearer ${data.token}',
//           'Content-Type': 'application/json',
//         },
//       );

//       if (response.statusCode == 200) {
//         print('Success: ${response.body}');
//         Navigator.pop(context);
//         if (status == 'WORK FOR APPROVAL') {
//           CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
//               'Status of $tokenNo successfully changed to Work For Approval',
//               context);
//         } else if (status == 'CANCELLED') {
//           CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
//               'Status of $tokenNo successfully changed to Cancelled', context);
//         }

//         crewPendingViewModel.fetchPendingCancelWorkApprovalTabularListApi(
//             context, 'PENDING','0', id);
//         _input.clear();
//       } else {
//         print('Failed: ${response.statusCode} - ${response.body}');
//       }
//     } catch (e) {
//       print('Error: $e');
//     }
//   }
// }
