// import 'dart:convert';
// import 'dart:io';
// import 'package:CIVM/utils/common_functions.dart';
// import 'package:CIVM/data/response/status.dart';
// import 'package:CIVM/models/user_model.dart';
// import 'package:CIVM/screens/admin_pannel/row_maintenance_view/pdf_view.dart';
// import 'package:CIVM/screens/generalForeman_New_pannel/contractor_bottom_navigation.dart';
// import 'package:CIVM/screens/generalForeman_New_pannel/create_invoice_contractor.dart';
// import 'package:CIVM/screens/generalForeman_New_pannel/create_order_contractor.dart';
// import 'package:CIVM/screens/generalForeman_New_pannel/gf_add_crew_member.dart';
// import 'package:CIVM/screens/generalForeman_New_pannel/gf_maintenance_report_view_new.dart';
// import 'package:CIVM/screens/generalForeman_New_pannel/invoice_form_contractor.dart';
// import 'package:CIVM/screens/generalForeman_New_pannel/invoice_list_contractor.dart';
// import 'package:CIVM/screens/generalForeman_New_pannel/view_change_order.dart';
// import 'package:CIVM/screens/leaflat_map/leaf_lat_map_wakeLock.dart';
// import 'package:CIVM/screens/login_page.dart';
// import 'package:CIVM/screens/map/provider/location_provider.dart';
// import 'package:CIVM/screens/my_chrome_safari_map_recording.dart';
// import 'package:CIVM/sharedPrefs/constants.dart';
// import 'package:CIVM/utils/custom_toast_snackbar_progressdialog.dart';
// import 'package:CIVM/utils/user_pref.dart';
// import 'package:CIVM/view_model/contractor_change_order_pending_view_model.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// // import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// import 'package:intl/intl.dart';
// import 'package:mailer/mailer.dart';
// import 'package:mailer/smtp_server/gmail.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:photo_view/photo_view.dart';
// import 'package:photo_view/photo_view_gallery.dart';
// import 'package:provider/provider.dart';
// import 'package:http/http.dart' as http;

// import '../../repository/map_url.dart';

// // ignore: must_be_immutable
// class WorkOrderPendingContractor extends StatefulWidget {
//   const WorkOrderPendingContractor({
//     Key? key,
//   }) : super(key: key);

//   @override
//   State<WorkOrderPendingContractor> createState() =>
//       _WorkOrderPendingContractorState();
// }

// class _WorkOrderPendingContractorState
//     extends State<WorkOrderPendingContractor> {
//   final TextEditingController _input = TextEditingController();
//   // ignore: non_constant_identifier_names
//   final select_status = ['APPROVE', 'REJECT'];
//   // ignore: non_constant_identifier_names
//   String? status;

//   final TextEditingController _notes = TextEditingController();

//   List<String> menu = [];

//   // ignore: prefer_typing_uninitialized_variables
//   var selectedWorkOrderNo;

//   onTappedBar(int index) {
//     setState(() {
//       // _currentIndex = index;
//     });
//   }

//   final browser = MyChromeSafariBrowser();
//   ContractorOrderPendingViewModel contractorOrderPendingViewModel =
//       ContractorOrderPendingViewModel();

//   @override
//   void initState() {
//     fetchData();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//         appBar: AppBar(
//           iconTheme: const IconThemeData(color: Colors.white),
//           title: const Text(
//             'Change Order Pending',
//             style: TextStyle(color: Colors.white),
//           ),
//           backgroundColor: const Color.fromARGB(255, 7, 59, 120),
//         ),
//         drawer: DrawerManu(menu: menu),
//         body: ChangeNotifierProvider<ContractorOrderPendingViewModel>(
//             create: (BuildContext context) => contractorOrderPendingViewModel,
//             child: Consumer<ContractorOrderPendingViewModel>(
//                 builder: (context, value, _) {
//               switch (value.contractorOrderPendingGetTabularData.status) {
//                 case Status.LOADING:
//                   return const Center(child: CircularProgressIndicator());
//                 case Status.ERROR:
//                   return
//                       // CustomToastSnackBarProgressDialog.flushBarErrorMessage(
//                       //     value.contractorOrderPendingGetTabularData.message
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
//                       await fetchData();
//                     },
//                     child: SingleChildScrollView(
//                       child: Column(
//                         children: [
//                           Container(
//                             margin: const EdgeInsets.only(
//                                 top: 4, bottom: 4, left: 4, right: 4),
//                             //  padding:  EdgeInsets.all(8),
//                             alignment: Alignment.center,
//                             height: size.height * 0.9,
//                             width: size.width * 0.99,
//                             decoration: BoxDecoration(
//                                 // shape: BoxShape.circle,
//                                 borderRadius: BorderRadius.circular(10),
//                                 boxShadow: const [
//                                   BoxShadow(
//                                       color: Color.fromARGB(255, 7, 59, 120),
//                                       blurRadius: 10,
//                                       offset: Offset(2.0, 5.0))
//                                 ],
//                                 gradient: const LinearGradient(
//                                   colors: [
//                                     Color.fromARGB(255, 255, 255, 255),
//                                     Color.fromARGB(255, 255, 255, 255),
//                                   ],
//                                 )),
//                             child: Column(
//                               children: [
//                                 // const Align(
//                                 //     alignment: Alignment.centerLeft,
//                                 //     child: Padding(
//                                 //       padding: EdgeInsets.only(
//                                 //           left: 8.0, right: 8.0, top: 10.0),
//                                 //       child: Text(
//                                 //         "CHANGE ORDER NO",
//                                 //         style: TextStyle(
//                                 //             fontSize: 16,
//                                 //             color:
//                                 //                 Color.fromARGB(255, 7, 59, 120),
//                                 //             fontWeight: FontWeight.bold),
//                                 //       ),
//                                 //     )),
//                                 // Padding(
//                                 //   padding: const EdgeInsets.all(8.0),
//                                 //   child: Align(
//                                 //     alignment: Alignment.centerLeft,
//                                 //     child: Padding(
//                                 //       padding: const EdgeInsets.all(2.0),
//                                 //       child: DropdownButtonFormField<String>(
//                                 //         hint: const Text('-Select-'),
//                                 //         dropdownColor: Colors.white,
//                                 //         value: selectedWorkOrderNo,
//                                 //         style: const TextStyle(
//                                 //             color:
//                                 //                 Color.fromARGB(255, 7, 59, 120),
//                                 //             fontSize: 16),
//                                 //         icon: const Icon(
//                                 //           Icons.arrow_drop_down,
//                                 //           color: Color.fromARGB(255, 7, 59, 120),
//                                 //           size: 40,
//                                 //         ),
//                                 //         decoration: const InputDecoration(
//                                 //           enabledBorder: OutlineInputBorder(
//                                 //             borderSide: BorderSide(
//                                 //               color:
//                                 //                   Color.fromARGB(255, 7, 59, 120),
//                                 //             ),
//                                 //           ),
//                                 //           focusedBorder: OutlineInputBorder(
//                                 //             borderSide: BorderSide(
//                                 //               color:
//                                 //                   Color.fromARGB(255, 7, 59, 120),
//                                 //             ),
//                                 //           ),
//                                 //         ),
//                                 //         isExpanded: true,
//                                 //         items: contractorOrderPendingViewModel
//                                 //             .contractorOrderPendingGetTabularData
//                                 //             .data!
//                                 //             .tokenNoLists!
//                                 //             .map((e) {
//                                 //           return DropdownMenuItem(
//                                 //             value: e.tokenNo.toString(),
//                                 //             // e.getIdAndSubstationByCountId![0].subStation.toString(),
//                                 //             child: Text(e.tokenNo.toString()),
//                                 //           );
//                                 //         }).toList(),
//                                 //         onChanged: (val) async {
//                                 //           // if (selectedFeeder != null) {
//                                 //           //   selectedFeeder = null;
//                                 //           // }
//                                 //           // fetchData(val!);
//                                 //           // workOrderNoId = int.parse(val);
//                                 //           setState(() {
//                                 //             selectedWorkOrderNo = val;
//                                 //           });
//                                 //           final userPreferences =
//                                 //               Provider.of<UserPref>(context,
//                                 //                   listen: false);
//                                 //           UserModel data =
//                                 //               await userPreferences.getUser();
//                                 //           contractorOrderPendingViewModel
//                                 //               .fetchContractorOrderPendingTabularListApi(
//                                 //                   context,
//                                 //                   data.user!.id.toString(),
//                                 //                   selectedWorkOrderNo);
//                                 //         },
//                                 //         validator: (value) => value == null
//                                 //             ? 'field required'
//                                 //             : null,
//                                 //       ),
//                                 //     ),
//                                 //   ),
//                                 // ),

//                                 Row(
//                                   children: [
//                                     Expanded(
//                                       child: Padding(
//                                         padding: const EdgeInsets.only(
//                                             left: 8.0, top: 8),
//                                         child: Row(
//                                           children: [
//                                             Container(
//                                               padding: const EdgeInsets.all(2),
//                                               alignment: Alignment.center,
//                                               width: size.width * 0.05,
//                                               // width: MediaQuery.of(context).size.width,
//                                               height: 30,
//                                               decoration: const BoxDecoration(
//                                                   shape: BoxShape.circle,
//                                                   //borderRadius: BorderRadius.circular(25),
//                                                   boxShadow: [
//                                                     BoxShadow(
//                                                         color: Color.fromARGB(
//                                                             255, 14, 80, 1),
//                                                         blurRadius: 5,
//                                                         offset:
//                                                             Offset(2.0, 5.0))
//                                                   ],
//                                                   color: Color.fromARGB(
//                                                       255, 130, 193, 245),
//                                                   gradient: LinearGradient(
//                                                     colors: [
//                                                       Color.fromARGB(
//                                                           255, 20, 108, 2),
//                                                       Color.fromARGB(
//                                                           255, 20, 108, 2),
//                                                     ],
//                                                   )),
//                                             ),
//                                             const Padding(
//                                               padding:
//                                                   EdgeInsets.only(left: 8.0),
//                                               child: Text(
//                                                 "APPROVED",
//                                                 style: TextStyle(
//                                                     fontSize: 16,
//                                                     color: Color.fromARGB(
//                                                         255, 7, 59, 120),
//                                                     fontWeight:
//                                                         FontWeight.bold),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                     Expanded(
//                                       child: Row(
//                                         children: [
//                                           Container(
//                                             padding: const EdgeInsets.all(2),
//                                             alignment: Alignment.center,
//                                             width: size.width * 0.05,
//                                             // width: MediaQuery.of(context).size.width,
//                                             height: 30,
//                                             decoration: const BoxDecoration(
//                                                 shape: BoxShape.circle,
//                                                 //borderRadius: BorderRadius.circular(25),
//                                                 boxShadow: [
//                                                   BoxShadow(
//                                                       color: Color.fromARGB(
//                                                           255, 138, 84, 2),
//                                                       blurRadius: 5,
//                                                       offset: Offset(2.0, 5.0))
//                                                 ],
//                                                 color: Color.fromARGB(
//                                                     255, 130, 193, 245),
//                                                 gradient: LinearGradient(
//                                                   colors: [
//                                                     Colors.orange,
//                                                     Colors.orange,
//                                                   ],
//                                                 )),
//                                           ),
//                                           const Padding(
//                                             padding: EdgeInsets.only(left: 8.0),
//                                             child: Text(
//                                               "PENDING",
//                                               style: TextStyle(
//                                                   fontSize: 16,
//                                                   color: Color.fromARGB(
//                                                       255, 7, 59, 120),
//                                                   fontWeight: FontWeight.bold),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                     Expanded(
//                                       child: Row(
//                                         children: [
//                                           Container(
//                                             padding: const EdgeInsets.all(2),
//                                             alignment: Alignment.center,
//                                             width: size.width * 0.05,
//                                             // width: MediaQuery.of(context).size.width,
//                                             height: 30,
//                                             decoration: const BoxDecoration(
//                                                 shape: BoxShape.circle,
//                                                 //borderRadius: BorderRadius.circular(25),
//                                                 boxShadow: [
//                                                   BoxShadow(
//                                                       color: Color.fromARGB(
//                                                           255, 128, 11, 2),
//                                                       blurRadius: 5,
//                                                       offset: Offset(2.0, 5.0))
//                                                 ],
//                                                 color: Color.fromARGB(
//                                                     255, 130, 193, 245),
//                                                 gradient: LinearGradient(
//                                                   colors: [
//                                                     Color.fromARGB(
//                                                         255, 201, 15, 2),
//                                                     Color.fromARGB(
//                                                         255, 201, 15, 2),
//                                                   ],
//                                                 )),
//                                           ),
//                                           const Padding(
//                                             padding: EdgeInsets.only(left: 8.0),
//                                             child: Text(
//                                               "REJECTED",
//                                               style: TextStyle(
//                                                   fontSize: 16,
//                                                   color: Color.fromARGB(
//                                                       255, 7, 59, 120),
//                                                   fontWeight: FontWeight.bold),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.only(left: 8.0),
//                                   child: Row(
//                                     children: [
//                                       Container(
//                                         padding: const EdgeInsets.all(2),
//                                         alignment: Alignment.center,
//                                         width: size.width * 0.05,
//                                         // width: MediaQuery.of(context).size.width,
//                                         height: 30,
//                                         decoration: const BoxDecoration(
//                                             shape: BoxShape.circle,
//                                             //borderRadius: BorderRadius.circular(25),
//                                             boxShadow: [
//                                               BoxShadow(
//                                                   color: Color.fromARGB(
//                                                       255, 3, 13, 86),
//                                                   blurRadius: 5,
//                                                   offset: Offset(2.0, 5.0))
//                                             ],
//                                             color: Color.fromARGB(
//                                                 255, 130, 193, 245),
//                                             gradient: LinearGradient(
//                                               colors: [
//                                                 Colors.blue,
//                                                 Colors.blue,
//                                               ],
//                                             )),
//                                       ),
//                                       const Padding(
//                                         padding: EdgeInsets.only(left: 8.0),
//                                         child: Text(
//                                           "NOT SUBMITTED",
//                                           style: TextStyle(
//                                               fontSize: 16,
//                                               color: Color.fromARGB(
//                                                   255, 7, 59, 120),
//                                               fontWeight: FontWeight.bold),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 Row(
//                                   children: [
//                                     const Padding(
//                                       padding:
//                                           EdgeInsets.only(top: 8.0, left: 8),
//                                       child: Align(
//                                         alignment: Alignment.topLeft,
//                                         child: Text(
//                                           "Total Order : ",
//                                           textAlign: TextAlign.left,
//                                           style: TextStyle(
//                                             color:
//                                                 Color.fromARGB(255, 7, 59, 120),
//                                             fontWeight: FontWeight.bold,
//                                             fontSize: 20,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                     Padding(
//                                       padding: const EdgeInsets.only(top: 8.0),
//                                       child: Text(
//                                         contractorOrderPendingViewModel
//                                             .contractorOrderPendingGetTabularData
//                                             .data!
//                                             .findAllTableData!
//                                             .length
//                                             .toString(),
//                                         // result.length.toString(),
//                                         textAlign: TextAlign.left,
//                                         style: const TextStyle(
//                                           color:
//                                               Color.fromARGB(255, 7, 59, 120),
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 20,
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 Align(
//                                   alignment: Alignment.centerRight,
//                                   child: Padding(
//                                     padding: const EdgeInsets.only(
//                                         left: 8.0,
//                                         right: 8.0,
//                                         top: 4,
//                                         bottom: 4),
//                                     child: TextFormField(
//                                       onChanged: (value) => _filterData(value),
//                                       controller: _input,
//                                       style: const TextStyle(
//                                         color: Color.fromARGB(255, 7, 59, 120),
//                                         fontSize: 16,
//                                       ),
//                                       obscureText: false,
//                                       decoration: const InputDecoration(
//                                         enabledBorder: OutlineInputBorder(
//                                           borderSide: BorderSide(
//                                             color:
//                                                 Color.fromARGB(255, 23, 1, 88),
//                                           ),
//                                         ),
//                                         focusedBorder: OutlineInputBorder(
//                                           borderSide: BorderSide(
//                                             color:
//                                                 Color.fromARGB(255, 23, 1, 88),
//                                           ),
//                                         ),
//                                         hintText: 'Search your input...',
//                                       ),
//                                       validator: (value) {
//                                         if (value!.isEmpty) {
//                                           return "Please search your input";
//                                         } else {
//                                           return null;
//                                         }
//                                       },
//                                     ),
//                                   ),
//                                 ),
//                                 Expanded(
//                                   child: ListView.builder(
//                                       itemCount: contractorOrderPendingViewModel
//                                           .contractorOrderPendingGetTabularData
//                                           .data!
//                                           .findAllTableData!
//                                           .length,
//                                       // itemCount: historyList.length,
//                                       itemBuilder:
//                                           (BuildContext ctxt, int index) {
//                                         String? dateStringCreateDate =
//                                             contractorOrderPendingViewModel
//                                                 .contractorOrderPendingGetTabularData
//                                                 .data!
//                                                 .findAllTableData![index]
//                                                 .createDate
//                                                 .toString();
//                                         DateTime date = DateTime.parse(
//                                             dateStringCreateDate);
//                                         String formattedDateCreateDate =
//                                             DateFormat('MM/dd/yyyy')
//                                                 .format(date);

//                                         DateTime? _parseCustomDate(
//                                             String dateString) {
//                                           dateString =
//                                               dateString.replaceFirstMapped(
//                                             RegExp(
//                                                 r'(\b\w{3})\s{1,2}(\d{1,2})\s*(\d{4})'),
//                                             (match) {
//                                               String month = match.group(1)!;
//                                               String day = match.group(2)!;
//                                               String year = match.group(3)!;
//                                               day = day.padLeft(2, '0');
//                                               return '$month $day $year';
//                                             },
//                                           );
//                                           return DateFormat(
//                                                   'MMM dd yyyy hh:mma')
//                                               .parse(dateString);
//                                         }

//                                         String? dateStringNextMaintDue =
//                                             contractorOrderPendingViewModel
//                                                 .contractorOrderPendingGetTabularData
//                                                 .data!
//                                                 .findAllTableData![index]
//                                                 .nextMaintDue
//                                                 ?.toString();

//                                         DateTime? date1;
//                                         String formattedDateNextMaintDue = '';

//                                         if (dateStringNextMaintDue != null) {
//                                           try {
//                                             date1 = _parseCustomDate(
//                                                 dateStringNextMaintDue);
//                                             formattedDateNextMaintDue =
//                                                 DateFormat('MM/dd/yyyy')
//                                                     .format(date1!);
//                                           } catch (e) {
//                                             print('Error parsing date: $e');
//                                           }
//                                         }

//                                         return Row(
//                                           children: [
//                                             Padding(
//                                               padding: const EdgeInsets.only(
//                                                   top: 4.0,
//                                                   bottom: 4,
//                                                   left: 4,
//                                                   right: 4),
//                                               child: Container(
//                                                 width: MediaQuery.of(context)
//                                                         .size
//                                                         .width *
//                                                     0.95,
//                                                 // height: MediaQuery.of(context)
//                                                 //         .size
//                                                 //         .height *
//                                                 //     0.73,
//                                                 // margin:  EdgeInsets.only(
//                                                 //     top: 5.0, bottom: 5.0, left: 2,right: 2),
//                                                 padding:
//                                                     const EdgeInsets.all(8),
//                                                 decoration: BoxDecoration(
//                                                     color: const Color.fromARGB(
//                                                         255, 7, 59, 120),
//                                                     border: Border.all(
//                                                       color: Colors.white,
//                                                     ),
//                                                     borderRadius:
//                                                         const BorderRadius.only(
//                                                       topRight:
//                                                           Radius.circular(10),
//                                                       bottomRight:
//                                                           Radius.circular(10),
//                                                       topLeft:
//                                                           Radius.circular(10),
//                                                       bottomLeft:
//                                                           Radius.circular(10),
//                                                     )),
//                                                 child: Column(children: [
//                                                   Padding(
//                                                     padding:
//                                                         const EdgeInsets.only(
//                                                             left: 8.0),
//                                                     child: Row(
//                                                       children: [
//                                                         Expanded(
//                                                             child: Column(
//                                                           children: [
//                                                             Align(
//                                                               alignment:
//                                                                   Alignment
//                                                                       .topLeft,
//                                                               child: (contractorOrderPendingViewModel
//                                                                           .contractorOrderPendingGetTabularData
//                                                                           .data!
//                                                                           .findAllTableData![
//                                                                               index]
//                                                                           .maintType ==
//                                                                       'RegularMaint')
//                                                                   ? const Text(
//                                                                       "VIEW: ",
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
//                                                                     )
//                                                                   : const Text(
//                                                                       "EDIT: ",
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
//                                                             ),
//                                                             (contractorOrderPendingViewModel
//                                                                         .contractorOrderPendingGetTabularData
//                                                                         .data!
//                                                                         .findAllTableData![
//                                                                             index]
//                                                                         .maintType ==
//                                                                     'RegularMaint')
//                                                                 ? InkWell(
//                                                                     onTap: () {
//                                                                       Navigator.push(
//                                                                           context,
//                                                                           MaterialPageRoute(
//                                                                               builder: (context) => ViewChangeOrder(orderNo: (contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].tokenNo == null || contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].tokenNo == 'N/A') ? '' : contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].tokenNo.toString(), substation: (contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].substation == null) ? '' : contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].substation.toString(), feeder: (contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].fdrName == null) ? '' : contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].fdrName.toString(), maintenanceType: (contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].maintType == null) ? '' : contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].maintType.toString(), totalMiles: (contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].totalMiles == null) ? '' : contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].totalMiles.toString(), costPerMile: (contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].costPerMile == null) ? '' : contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].costPerMile.toString(), totalCost: (contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].totalCost == null) ? '' : contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].totalCost.toString(), type: (contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].type == null) ? '' : contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].type.toString(), contractYear: (contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].contractYear == null) ? '' : contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].contractYear.toString(), cycle: (contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].cycle == null) ? '' : contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].cycle.toString(), nextMaintDue: (contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].nextMaintDue == null) ? '' : contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].nextMaintDue.toString(), contractor: (contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].contractor == null) ? '' : contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].contractor.toString(), contractorCompany: (contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].contractorCompany == null) ? '' : contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].contractorCompany.toString(), status: (contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].status == null || contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].status == 'N/A') ? '' : contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].status.toString(), dailyHerbicideApplication: '', ivmTimesheet: '', mixingInventory: '', serviceStreetAddress: (contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].streetAddress == null) ? '' : contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].streetAddress.toString(), serviceMapLocation: (contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].mapLocation == null) ? '' : contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].mapLocation.toString(), adminNotes1: (contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].adminNotes1 == null) ? '' : contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].adminNotes1.toString(), dateOfInspection: (contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].dateOfInspection == null) ? '' : contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].dateOfInspection.toString(), followUpDate: (contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].followUpDate == null) ? '' : contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].followUpDate.toString(), createDate: (contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].createDate == null) ? '' : contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].createDate.toString())));
//                                                                     },
//                                                                     child:
//                                                                         const Align(
//                                                                       alignment:
//                                                                           Alignment
//                                                                               .topLeft,
//                                                                       child:
//                                                                           Icon(
//                                                                         Icons
//                                                                             .remove_red_eye_outlined,
//                                                                         color: Colors
//                                                                             .red,
//                                                                       ),
//                                                                     ),
//                                                                   )
//                                                                 : InkWell(
//                                                                     onTap: () {
//                                                                       Navigator.push(
//                                                                           context,
//                                                                           MaterialPageRoute(
//                                                                               builder: (context) => CreateOrderContractor(
//                                                                                     tokenNo: (contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].tokenNo == null) ? '' : contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].tokenNo.toString(),
//                                                                                     subStation: (contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].substation == null) ? '' : contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].substation.toString(),
//                                                                                     feeder: (contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].fdrName == null) ? '' : contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].fdrName.toString(),
//                                                                                     serviceStreetAddress: (contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].streetAddress == null) ? '' : contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].streetAddress.toString(),
//                                                                                     serviceMapLocation: (contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].mapLocation == null) ? '' : contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].mapLocation.toString(),
//                                                                                     notes: (contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].contractorNotes == null) ? '' : contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].contractorNotes.toString(),
//                                                                                     type: (contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].type == null) ? '' : contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].type.toString(),
//                                                                                     maintType: (contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].maintType == null) ? '' : contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].maintType.toString(),
//                                                                                     contractorCompany: (contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].contractorCompany == null) ? '' : contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].contractorCompany.toString(),
//                                                                                     assignForeman: (contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].contractor == null) ? '' : contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].contractor.toString(),
//                                                                                     estimatedCost: (contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].estCost == null) ? '' : contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].estCost.toString(),
//                                                                                     estimatedTime: (contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].estTime == null) ? '' : contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].estTime.toString(),
//                                                                                     actualCost: (contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].actualCost == null) ? '' : contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].actualCost.toString(),
//                                                                                     crew: (contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].crew == null) ? '' : contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].crew.toString(),
//                                                                                     crewName: '',
//                                                                                   )));
//                                                                     },
//                                                                     child:
//                                                                         const Align(
//                                                                       alignment:
//                                                                           Alignment
//                                                                               .topLeft,
//                                                                       child:
//                                                                           Icon(
//                                                                         Icons
//                                                                             .edit,
//                                                                         color: Color.fromARGB(
//                                                                             255,
//                                                                             151,
//                                                                             249,
//                                                                             154),
//                                                                       ),
//                                                                     ),
//                                                                   )
//                                                           ],
//                                                         )),
//                                                         Expanded(
//                                                           // alignment: Alignment.topLeft,
//                                                           child: Column(
//                                                             children: [
//                                                               const Align(
//                                                                 alignment:
//                                                                     Alignment
//                                                                         .topLeft,
//                                                                 child: Text(
//                                                                   "IMAGE: ",
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
//                                                                 child: InkWell(
//                                                                   onTap:
//                                                                       () async {
//                                                                     await contractorOrderPendingViewModel
//                                                                         .fetchImageApi(
//                                                                       context,
//                                                                       contractorOrderPendingViewModel
//                                                                           .contractorOrderPendingGetTabularData
//                                                                           .data!
//                                                                           .findAllTableData![
//                                                                               index]
//                                                                           .id
//                                                                           .toString(),
//                                                                     );
//                                                                     await Future.delayed(const Duration(
//                                                                         seconds:
//                                                                             2));
//                                                                     openDialogPicture(contractorOrderPendingViewModel
//                                                                         .contractorOrderPendingGetTabularData
//                                                                         .data!
//                                                                         .findAllTableData![
//                                                                             index]
//                                                                         .id
//                                                                         .toString());
//                                                                   },
//                                                                   child: const Align(
//                                                                       alignment: Alignment.topLeft,
//                                                                       child: Icon(
//                                                                         Icons
//                                                                             .image,
//                                                                         color: Colors
//                                                                             .blue,
//                                                                       )),
//                                                                 ),
//                                                               )
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
//                                                                   "TYPE: ",
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
//                                                                   (contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].maintType ==
//                                                                               null ||
//                                                                           contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].maintType.toString() ==
//                                                                               'null')
//                                                                       ? ''
//                                                                       : contractorOrderPendingViewModel
//                                                                           .contractorOrderPendingGetTabularData
//                                                                           .data!
//                                                                           .findAllTableData![
//                                                                               index]
//                                                                           .maintType
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
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                   const Divider(
//                                                     color: Colors.grey,
//                                                   ),
//                                                   Padding(
//                                                     padding:
//                                                         const EdgeInsets.only(
//                                                             left: 8.0),
//                                                     child: Row(
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
//                                                                   "JOB NO: ",
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
//                                                                   (contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].tokenNo ==
//                                                                               null ||
//                                                                           contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].tokenNo.toString() ==
//                                                                               'null')
//                                                                       ? ''
//                                                                       : contractorOrderPendingViewModel
//                                                                           .contractorOrderPendingGetTabularData
//                                                                           .data!
//                                                                           .findAllTableData![
//                                                                               index]
//                                                                           .tokenNo
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
//                                                                   "STATUS: ",
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
//                                                               (contractorOrderPendingViewModel
//                                                                           .contractorOrderPendingGetTabularData
//                                                                           .data!
//                                                                           .findAllTableData![
//                                                                               index]
//                                                                           .maintType ==
//                                                                       'RegularMaint')
//                                                                   ? Align(
//                                                                       alignment:
//                                                                           Alignment
//                                                                               .topLeft,
//                                                                       child:
//                                                                           Text(
//                                                                         (contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].status == null ||
//                                                                                 contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].status.toString() == 'null')
//                                                                             ? ''
//                                                                             : contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].status.toString(),
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
//                                                                     )
//                                                                   : InkWell(
//                                                                       onTap:
//                                                                           () {
//                                                                         openDailogPendingApproval(contractorOrderPendingViewModel
//                                                                             .contractorOrderPendingGetTabularData
//                                                                             .data!
//                                                                             .findAllTableData![index]
//                                                                             .id
//                                                                             .toString());
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
//                                                                           decoration: BoxDecoration(
//                                                                               // shape: BoxShape.circle,
//                                                                               color: const Color.fromARGB(255, 122, 12, 4),
//                                                                               gradient: (contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].status == 'REJECTED')
//                                                                                   ? const LinearGradient(
//                                                                                       colors: [
//                                                                                         Colors.red,
//                                                                                         Colors.red
//                                                                                       ],
//                                                                                     )
//                                                                                   : const LinearGradient(
//                                                                                       colors: [
//                                                                                         Color.fromARGB(255, 0, 79, 215),
//                                                                                         Colors.blue,
//                                                                                         Color.fromARGB(255, 0, 79, 215),
//                                                                                       ],
//                                                                                     )),
//                                                                           child:
//                                                                               Align(
//                                                                             alignment:
//                                                                                 Alignment.center,
//                                                                             child:
//                                                                                 Text(
//                                                                               (contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].status == null || contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].status.toString() == 'null') ? '' : contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].status.toString(),
//                                                                               style: const TextStyle(
//                                                                                 color: Colors.white,
//                                                                                 fontWeight: FontWeight.bold,
//                                                                                 fontSize: 10,
//                                                                               ),
//                                                                             ),
//                                                                           ),
//                                                                         ),
//                                                                       ),
//                                                                     )
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
//                                                                   "SUBSTATION: ",
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
//                                                                   (contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].substation ==
//                                                                               null ||
//                                                                           contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].substation.toString() ==
//                                                                               'null')
//                                                                       ? ''
//                                                                       : contractorOrderPendingViewModel
//                                                                           .contractorOrderPendingGetTabularData
//                                                                           .data!
//                                                                           .findAllTableData![
//                                                                               index]
//                                                                           .substation
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
//                                                   ),
//                                                   // const Divider(
//                                                   //   color: Colors.grey,
//                                                   // ),
//                                                   // Padding(
//                                                   //   padding:
//                                                   //       const EdgeInsets.only(
//                                                   //           left: 8.0),
//                                                   //   child: Row(
//                                                   //     children: [
//                                                   //          Expanded(
//                                                   //         // alignment: Alignment.topLeft,
//                                                   //         child: Column(
//                                                   //           children: [
//                                                   //             const Align(
//                                                   //               alignment:
//                                                   //                   Alignment
//                                                   //                       .topLeft,
//                                                   //               child: Text(
//                                                   //                 "DAILY HERBICIDE APPLICATION: ",
//                                                   //                 textAlign:
//                                                   //                     TextAlign
//                                                   //                         .left,
//                                                   //                 style:
//                                                   //                     TextStyle(
//                                                   //                   fontSize: 12,
//                                                   //                   fontWeight:
//                                                   //                       FontWeight
//                                                   //                           .bold,
//                                                   //                   color: Colors
//                                                   //                       .white,
//                                                   //                 ),
//                                                   //               ),
//                                                   //             ),
//                                                   //             (contractorOrderPendingViewModel
//                                                   //                         .contractorOrderPendingGetTabularData
//                                                   //                         .data!
//                                                   //                         .findAllTableData![
//                                                   //                             index]
//                                                   //                         .dailyHerbicide
//                                                   //                         .toString() ==
//                                                   //                     'APPROVED')
//                                                   //                 ? Align(
//                                                   //                     alignment:
//                                                   //                         Alignment
//                                                   //                             .topLeft,
//                                                   //                     child:
//                                                   //                         InkWell(
//                                                   //                       onTap:
//                                                   //                           () {
//                                                   //                         Navigator.of(context).push(MaterialPageRoute(
//                                                   //                             builder: (BuildContext context) =>
//                                                   //                                 DailyHerbicideApplicationContractor(id: contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].id.toString())));
//                                                   //                       },
//                                                   //                       child:
//                                                   //                           Container(
//                                                   //                         padding: const EdgeInsets
//                                                   //                             .all(
//                                                   //                             2),
//                                                   //                         alignment:
//                                                   //                             Alignment.center,
//                                                   //                         width: size.width *
//                                                   //                             0.1,
//                                                   //                         height:
//                                                   //                             30,
//                                                   //                         decoration: BoxDecoration(
//                                                   //                             // shape: BoxShape.circle,
//                                                   //                             borderRadius: BorderRadius.circular(10),
//                                                   //                             color: const Color.fromARGB(255, 130, 193, 245),
//                                                   //                             gradient: const LinearGradient(
//                                                   //                               colors: [
//                                                   //                                 Colors.green,
//                                                   //                                 Colors.green,
//                                                   //                               ],
//                                                   //                             )),
//                                                   //                         child: const Align(
//                                                   //                             alignment: Alignment.center,
//                                                   //                             child: Icon(
//                                                   //                               Icons.remove_red_eye,
//                                                   //                               color: Colors.white,
//                                                   //                             )),
//                                                   //                       ),
//                                                   //                     ),
//                                                   //                   )
//                                                   //                 : (contractorOrderPendingViewModel
//                                                   //                             .contractorOrderPendingGetTabularData
//                                                   //                             .data!
//                                                   //                             .findAllTableData![
//                                                   //                                 index]
//                                                   //                             .dailyHerbicide
//                                                   //                             .toString() ==
//                                                   //                         'PENDING')
//                                                   //                     ? Align(
//                                                   //                         alignment:
//                                                   //                             Alignment.topLeft,
//                                                   //                         child:
//                                                   //                             InkWell(
//                                                   //                           onTap:
//                                                   //                               () {
//                                                   //                             Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => DailyHerbicideApplicationContractor(id: contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].id.toString())));
//                                                   //                           },
//                                                   //                           child:
//                                                   //                               Container(
//                                                   //                             padding:
//                                                   //                                 const EdgeInsets.all(2),
//                                                   //                             alignment:
//                                                   //                                 Alignment.center,
//                                                   //                             width:
//                                                   //                                 size.width * 0.1,
//                                                   //                             height:
//                                                   //                                 30,
//                                                   //                             decoration: BoxDecoration(
//                                                   //                                 // shape: BoxShape.circle,
//                                                   //                                 borderRadius: BorderRadius.circular(10),
//                                                   //                                 color: const Color.fromARGB(255, 130, 193, 245),
//                                                   //                                 gradient: const LinearGradient(
//                                                   //                                   colors: [
//                                                   //                                     Colors.orange,
//                                                   //                                     Colors.orange,
//                                                   //                                   ],
//                                                   //                                 )),
//                                                   //                             child: const Align(
//                                                   //                                 alignment: Alignment.center,
//                                                   //                                 child: Icon(
//                                                   //                                   Icons.remove_red_eye,
//                                                   //                                   color: Colors.white,
//                                                   //                                 )),
//                                                   //                           ),
//                                                   //                         ),
//                                                   //                       )
//                                                   //                     : (contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].dailyHerbicide.toString() ==
//                                                   //                             'REJECTED')
//                                                   //                         ? Align(
//                                                   //                             alignment:
//                                                   //                                 Alignment.topLeft,
//                                                   //                             child:
//                                                   //                                 InkWell(
//                                                   //                               onTap: () {
//                                                   //                                 Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => DailyHerbicideApplicationContractor(id: contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].id.toString())));
//                                                   //                               },
//                                                   //                               child: Container(
//                                                   //                                 padding: const EdgeInsets.all(2),
//                                                   //                                 alignment: Alignment.center,
//                                                   //                                 width: size.width * 0.1,
//                                                   //                                 height: 30,
//                                                   //                                 decoration: BoxDecoration(
//                                                   //                                     // shape: BoxShape.circle,
//                                                   //                                     borderRadius: BorderRadius.circular(10),
//                                                   //                                     color: const Color.fromARGB(255, 130, 193, 245),
//                                                   //                                     gradient: const LinearGradient(
//                                                   //                                       colors: [
//                                                   //                                         Colors.red,
//                                                   //                                         Colors.red,
//                                                   //                                       ],
//                                                   //                                     )),
//                                                   //                                 child: const Align(
//                                                   //                                     alignment: Alignment.center,
//                                                   //                                     child: Icon(
//                                                   //                                       Icons.remove_red_eye,
//                                                   //                                       color: Colors.white,
//                                                   //                                     )),
//                                                   //                               ),
//                                                   //                             ),
//                                                   //                           )
//                                                   //                         : (contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].maintType.toString() !=
//                                                   //                                 'RegularMaint')
//                                                   //                             ? Align(
//                                                   //                                 alignment: Alignment.topLeft,
//                                                   //                                 child: InkWell(
//                                                   //                                   onTap: () {
//                                                   //                                     Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => EditDailyHerbicideApplicationContractor(id: contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].id.toString())));
//                                                   //                                   },
//                                                   //                                   child: Container(
//                                                   //                                     padding: const EdgeInsets.all(2),
//                                                   //                                     alignment: Alignment.center,
//                                                   //                                     width: size.width * 0.1,
//                                                   //                                     height: 30,
//                                                   //                                     decoration: BoxDecoration(
//                                                   //                                         // shape: BoxShape.circle,
//                                                   //                                         borderRadius: BorderRadius.circular(10),
//                                                   //                                         color: const Color.fromARGB(255, 130, 193, 245),
//                                                   //                                         gradient: const LinearGradient(
//                                                   //                                           colors: [
//                                                   //                                             Colors.blue,
//                                                   //                                             Colors.blue,
//                                                   //                                           ],
//                                                   //                                         )),
//                                                   //                                     child: const Align(
//                                                   //                                         alignment: Alignment.center,
//                                                   //                                         child: Icon(
//                                                   //                                           Icons.edit,
//                                                   //                                           color: Colors.white,
//                                                   //                                         )),
//                                                   //                                   ),
//                                                   //                                 ),
//                                                   //                               )
//                                                   //                             : const Text(
//                                                   //                                 "",
//                                                   //                                 textAlign: TextAlign.left,
//                                                   //                                 style: TextStyle(
//                                                   //                                   fontSize: 12,
//                                                   //                                   fontWeight: FontWeight.bold,
//                                                   //                                   color: Colors.white,
//                                                   //                                 ),
//                                                   //                               ),
//                                                   //           ],
//                                                   //         ),
//                                                   //       ),

//                                                   //       Expanded(
//                                                   //         // alignment: Alignment.topLeft,
//                                                   //         child: Column(
//                                                   //           children: [
//                                                   //             const Align(
//                                                   //               alignment:
//                                                   //                   Alignment
//                                                   //                       .topLeft,
//                                                   //               child: Text(
//                                                   //                 "IVM TIMESHEET: ",
//                                                   //                 textAlign:
//                                                   //                     TextAlign
//                                                   //                         .left,
//                                                   //                 style:
//                                                   //                     TextStyle(
//                                                   //                   fontSize: 12,
//                                                   //                   fontWeight:
//                                                   //                       FontWeight
//                                                   //                           .bold,
//                                                   //                   color: Colors
//                                                   //                       .white,
//                                                   //                 ),
//                                                   //               ),
//                                                   //             ),
//                                                   //             (contractorOrderPendingViewModel
//                                                   //                         .contractorOrderPendingGetTabularData
//                                                   //                         .data!
//                                                   //                         .findAllTableData![
//                                                   //                             index]
//                                                   //                         .ivmTimesheet
//                                                   //                         .toString() ==
//                                                   //                     'APPROVED')
//                                                   //                 ? Align(
//                                                   //                     alignment:
//                                                   //                         Alignment
//                                                   //                             .topLeft,
//                                                   //                     child:
//                                                   //                         InkWell(
//                                                   //                       onTap:
//                                                   //                           () {
//                                                   //                         Navigator.of(context).push(MaterialPageRoute(
//                                                   //                             builder: (BuildContext context) =>
//                                                   //                                 IVMTimeSheetContractor(id: contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].id.toString())));
//                                                   //                       },
//                                                   //                       child:
//                                                   //                           Container(
//                                                   //                         padding: const EdgeInsets
//                                                   //                             .all(
//                                                   //                             2),
//                                                   //                         alignment:
//                                                   //                             Alignment.center,
//                                                   //                         width: size.width *
//                                                   //                             0.1,
//                                                   //                         height:
//                                                   //                             30,
//                                                   //                         decoration: BoxDecoration(
//                                                   //                             // shape: BoxShape.circle,
//                                                   //                             borderRadius: BorderRadius.circular(10),
//                                                   //                             color: const Color.fromARGB(255, 130, 193, 245),
//                                                   //                             gradient: const LinearGradient(
//                                                   //                               colors: [
//                                                   //                                 Colors.green,
//                                                   //                                 Colors.green,
//                                                   //                               ],
//                                                   //                             )),
//                                                   //                         child: const Align(
//                                                   //                             alignment: Alignment.center,
//                                                   //                             child: Icon(
//                                                   //                               Icons.remove_red_eye,
//                                                   //                               color: Colors.white,
//                                                   //                             )),
//                                                   //                       ),
//                                                   //                     ),
//                                                   //                   )
//                                                   //                 : (contractorOrderPendingViewModel
//                                                   //                             .contractorOrderPendingGetTabularData
//                                                   //                             .data!
//                                                   //                             .findAllTableData![
//                                                   //                                 index]
//                                                   //                             .ivmTimesheet
//                                                   //                             .toString() ==
//                                                   //                         'PENDING')
//                                                   //                     ? Align(
//                                                   //                         alignment:
//                                                   //                             Alignment.topLeft,
//                                                   //                         child:
//                                                   //                             InkWell(
//                                                   //                           onTap:
//                                                   //                               () {
//                                                   //                             Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => IVMTimeSheetContractor(id: contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].id.toString())));
//                                                   //                           },
//                                                   //                           child:
//                                                   //                               Container(
//                                                   //                             padding:
//                                                   //                                 const EdgeInsets.all(2),
//                                                   //                             alignment:
//                                                   //                                 Alignment.center,
//                                                   //                             width:
//                                                   //                                 size.width * 0.1,
//                                                   //                             height:
//                                                   //                                 30,
//                                                   //                             decoration: BoxDecoration(
//                                                   //                                 // shape: BoxShape.circle,
//                                                   //                                 borderRadius: BorderRadius.circular(10),
//                                                   //                                 color: const Color.fromARGB(255, 130, 193, 245),
//                                                   //                                 gradient: const LinearGradient(
//                                                   //                                   colors: [
//                                                   //                                     Colors.orange,
//                                                   //                                     Colors.orange,
//                                                   //                                   ],
//                                                   //                                 )),
//                                                   //                             child: const Align(
//                                                   //                                 alignment: Alignment.center,
//                                                   //                                 child: Icon(
//                                                   //                                   Icons.remove_red_eye,
//                                                   //                                   color: Colors.white,
//                                                   //                                 )),
//                                                   //                           ),
//                                                   //                         ),
//                                                   //                       )
//                                                   //                     : (contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].ivmTimesheet.toString() ==
//                                                   //                             'REJECTED')
//                                                   //                         ? Align(
//                                                   //                             alignment:
//                                                   //                                 Alignment.topLeft,
//                                                   //                             child:
//                                                   //                                 InkWell(
//                                                   //                               onTap: () {
//                                                   //                                 Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => IVMTimeSheetContractor(id: contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].id.toString())));
//                                                   //                               },
//                                                   //                               child: Container(
//                                                   //                                 padding: const EdgeInsets.all(2),
//                                                   //                                 alignment: Alignment.center,
//                                                   //                                 width: size.width * 0.1,
//                                                   //                                 height: 30,
//                                                   //                                 decoration: BoxDecoration(
//                                                   //                                     // shape: BoxShape.circle,
//                                                   //                                     borderRadius: BorderRadius.circular(10),
//                                                   //                                     color: const Color.fromARGB(255, 130, 193, 245),
//                                                   //                                     gradient: const LinearGradient(
//                                                   //                                       colors: [
//                                                   //                                         Colors.red,
//                                                   //                                         Colors.red,
//                                                   //                                       ],
//                                                   //                                     )),
//                                                   //                                 child: const Align(
//                                                   //                                     alignment: Alignment.center,
//                                                   //                                     child: Icon(
//                                                   //                                       Icons.remove_red_eye,
//                                                   //                                       color: Colors.white,
//                                                   //                                     )),
//                                                   //                               ),
//                                                   //                             ),
//                                                   //                           )
//                                                   //                         : (contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].maintType.toString() !=
//                                                   //                                 'RegularMaint')
//                                                   //                             ? Align(
//                                                   //                                 alignment: Alignment.topLeft,
//                                                   //                                 child: InkWell(
//                                                   //                                   onTap: () {
//                                                   //                                     Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => EditIVMTimeSheetContractor(id: contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].id.toString())));
//                                                   //                                   },
//                                                   //                                   child: Container(
//                                                   //                                     padding: const EdgeInsets.all(2),
//                                                   //                                     alignment: Alignment.center,
//                                                   //                                     width: size.width * 0.1,
//                                                   //                                     height: 30,
//                                                   //                                     decoration: BoxDecoration(
//                                                   //                                         // shape: BoxShape.circle,
//                                                   //                                         borderRadius: BorderRadius.circular(10),
//                                                   //                                         color: const Color.fromARGB(255, 130, 193, 245),
//                                                   //                                         gradient: const LinearGradient(
//                                                   //                                           colors: [
//                                                   //                                             Colors.blue,
//                                                   //                                             Colors.blue,
//                                                   //                                           ],
//                                                   //                                         )),
//                                                   //                                     child: const Align(
//                                                   //                                         alignment: Alignment.center,
//                                                   //                                         child: Icon(
//                                                   //                                           Icons.edit,
//                                                   //                                           color: Colors.white,
//                                                   //                                         )),
//                                                   //                                   ),
//                                                   //                                 ),
//                                                   //                               )
//                                                   //                             : const Text(
//                                                   //                                 "",
//                                                   //                                 textAlign: TextAlign.left,
//                                                   //                                 style: TextStyle(
//                                                   //                                   fontSize: 12,
//                                                   //                                   fontWeight: FontWeight.bold,
//                                                   //                                   color: Colors.white,
//                                                   //                                 ),
//                                                   //                               ),
//                                                   //           ],
//                                                   //         ),
//                                                   //       ),
//                                                   //       Expanded(
//                                                   //         // alignment: Alignment.topLeft,
//                                                   //         child: Column(
//                                                   //           children: [
//                                                   //             const Align(
//                                                   //               alignment:
//                                                   //                   Alignment
//                                                   //                       .topLeft,
//                                                   //               child: Text(
//                                                   //                 "MIXING INVENTORY: ",
//                                                   //                 textAlign:
//                                                   //                     TextAlign
//                                                   //                         .left,
//                                                   //                 style:
//                                                   //                     TextStyle(
//                                                   //                   fontSize: 12,
//                                                   //                   fontWeight:
//                                                   //                       FontWeight
//                                                   //                           .bold,
//                                                   //                   color: Colors
//                                                   //                       .white,
//                                                   //                 ),
//                                                   //               ),
//                                                   //             ),
//                                                   //             (contractorOrderPendingViewModel
//                                                   //                         .contractorOrderPendingGetTabularData
//                                                   //                         .data!
//                                                   //                         .findAllTableData![
//                                                   //                             index]
//                                                   //                         .mixingInventory
//                                                   //                         .toString() ==
//                                                   //                     'APPROVED')
//                                                   //                 ? Align(
//                                                   //                     alignment:
//                                                   //                         Alignment
//                                                   //                             .topLeft,
//                                                   //                     child:
//                                                   //                         InkWell(
//                                                   //                       onTap:
//                                                   //                           () {
//                                                   //                         Navigator.of(context).push(MaterialPageRoute(
//                                                   //                             builder: (BuildContext context) =>
//                                                   //                                 MixingInventoryContractor(id: contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].id.toString())));
//                                                   //                       },
//                                                   //                       child:
//                                                   //                           Container(
//                                                   //                         padding: const EdgeInsets
//                                                   //                             .all(
//                                                   //                             2),
//                                                   //                         alignment:
//                                                   //                             Alignment.center,
//                                                   //                         width: size.width *
//                                                   //                             0.1,
//                                                   //                         height:
//                                                   //                             30,
//                                                   //                         decoration: BoxDecoration(
//                                                   //                             // shape: BoxShape.circle,
//                                                   //                             borderRadius: BorderRadius.circular(10),
//                                                   //                             color: const Color.fromARGB(255, 130, 193, 245),
//                                                   //                             gradient: const LinearGradient(
//                                                   //                               colors: [
//                                                   //                                 Colors.green,
//                                                   //                                 Colors.green,
//                                                   //                               ],
//                                                   //                             )),
//                                                   //                         child: const Align(
//                                                   //                             alignment: Alignment.center,
//                                                   //                             child: Icon(
//                                                   //                               Icons.remove_red_eye,
//                                                   //                               color: Colors.white,
//                                                   //                             )),
//                                                   //                       ),
//                                                   //                     ),
//                                                   //                   )
//                                                   //                 : (contractorOrderPendingViewModel
//                                                   //                             .contractorOrderPendingGetTabularData
//                                                   //                             .data!
//                                                   //                             .findAllTableData![
//                                                   //                                 index]
//                                                   //                             .mixingInventory
//                                                   //                             .toString() ==
//                                                   //                         'PENDING')
//                                                   //                     ? Align(
//                                                   //                         alignment:
//                                                   //                             Alignment.topLeft,
//                                                   //                         child:
//                                                   //                             InkWell(
//                                                   //                           onTap:
//                                                   //                               () {
//                                                   //                             Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => MixingInventoryContractor(id: contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].id.toString())));
//                                                   //                           },
//                                                   //                           child:
//                                                   //                               Container(
//                                                   //                             padding:
//                                                   //                                 const EdgeInsets.all(2),
//                                                   //                             alignment:
//                                                   //                                 Alignment.center,
//                                                   //                             width:
//                                                   //                                 size.width * 0.1,
//                                                   //                             height:
//                                                   //                                 30,
//                                                   //                             decoration: BoxDecoration(
//                                                   //                                 // shape: BoxShape.circle,
//                                                   //                                 borderRadius: BorderRadius.circular(10),
//                                                   //                                 color: const Color.fromARGB(255, 130, 193, 245),
//                                                   //                                 gradient: const LinearGradient(
//                                                   //                                   colors: [
//                                                   //                                     Colors.orange,
//                                                   //                                     Colors.orange,
//                                                   //                                   ],
//                                                   //                                 )),
//                                                   //                             child: const Align(
//                                                   //                                 alignment: Alignment.center,
//                                                   //                                 child: Icon(
//                                                   //                                   Icons.remove_red_eye,
//                                                   //                                   color: Colors.white,
//                                                   //                                 )),
//                                                   //                           ),
//                                                   //                         ),
//                                                   //                       )
//                                                   //                     : (contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].mixingInventory.toString() ==
//                                                   //                             'REJECTED')
//                                                   //                         ? Align(
//                                                   //                             alignment:
//                                                   //                                 Alignment.topLeft,
//                                                   //                             child:
//                                                   //                                 InkWell(
//                                                   //                               onTap: () {
//                                                   //                                 Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => MixingInventoryContractor(id: contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].id.toString())));
//                                                   //                               },
//                                                   //                               child: Container(
//                                                   //                                 padding: const EdgeInsets.all(2),
//                                                   //                                 alignment: Alignment.center,
//                                                   //                                 width: size.width * 0.1,
//                                                   //                                 height: 30,
//                                                   //                                 decoration: BoxDecoration(
//                                                   //                                     // shape: BoxShape.circle,
//                                                   //                                     borderRadius: BorderRadius.circular(10),
//                                                   //                                     color: const Color.fromARGB(255, 130, 193, 245),
//                                                   //                                     gradient: const LinearGradient(
//                                                   //                                       colors: [
//                                                   //                                         Colors.red,
//                                                   //                                         Colors.red,
//                                                   //                                       ],
//                                                   //                                     )),
//                                                   //                                 child: const Align(
//                                                   //                                     alignment: Alignment.center,
//                                                   //                                     child: Icon(
//                                                   //                                       Icons.remove_red_eye,
//                                                   //                                       color: Colors.white,
//                                                   //                                     )),
//                                                   //                               ),
//                                                   //                             ),
//                                                   //                           )
//                                                   //                         : (contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].maintType.toString() !=
//                                                   //                                 'RegularMaint')
//                                                   //                             ? Align(
//                                                   //                                 alignment: Alignment.topLeft,
//                                                   //                                 child: InkWell(
//                                                   //                                   onTap: () {
//                                                   //                                     Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => EditMixingInventoryContractor(id: contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].id.toString())));
//                                                   //                                   },
//                                                   //                                   child: Container(
//                                                   //                                     padding: const EdgeInsets.all(2),
//                                                   //                                     alignment: Alignment.center,
//                                                   //                                     width: size.width * 0.1,
//                                                   //                                     height: 30,
//                                                   //                                     decoration: BoxDecoration(
//                                                   //                                         // shape: BoxShape.circle,
//                                                   //                                         borderRadius: BorderRadius.circular(10),
//                                                   //                                         color: const Color.fromARGB(255, 130, 193, 245),
//                                                   //                                         gradient: const LinearGradient(
//                                                   //                                           colors: [
//                                                   //                                             Colors.blue,
//                                                   //                                             Colors.blue,
//                                                   //                                           ],
//                                                   //                                         )),
//                                                   //                                     child: const Align(
//                                                   //                                         alignment: Alignment.center,
//                                                   //                                         child: Icon(
//                                                   //                                           Icons.edit,
//                                                   //                                           color: Colors.white,
//                                                   //                                         )),
//                                                   //                                   ),
//                                                   //                                 ),
//                                                   //                               )
//                                                   //                             : const Text(
//                                                   //                                 "",
//                                                   //                                 textAlign: TextAlign.left,
//                                                   //                                 style: TextStyle(
//                                                   //                                   fontSize: 12,
//                                                   //                                   fontWeight: FontWeight.bold,
//                                                   //                                   color: Colors.white,
//                                                   //                                 ),
//                                                   //                               ),
//                                                   //           ],
//                                                   //         ),
//                                                   //       ),
//                                                   //           ],
//                                                   //   ),
//                                                   // ),

//                                                   const Divider(
//                                                     color: Colors.grey,
//                                                   ),
//                                                   Padding(
//                                                     padding:
//                                                         const EdgeInsets.only(
//                                                             left: 8.0),
//                                                     child: Row(
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
//                                                                   "FEEDER: ",
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
//                                                                   (contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].fdrName ==
//                                                                               null ||
//                                                                           contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].fdrName.toString() ==
//                                                                               'null')
//                                                                       ? ''
//                                                                       : contractorOrderPendingViewModel
//                                                                           .contractorOrderPendingGetTabularData
//                                                                           .data!
//                                                                           .findAllTableData![
//                                                                               index]
//                                                                           .fdrName
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
//                                                                   (contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].maintType ==
//                                                                               null ||
//                                                                           contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].maintType.toString() ==
//                                                                               'null')
//                                                                       ? ''
//                                                                       : contractorOrderPendingViewModel
//                                                                           .contractorOrderPendingGetTabularData
//                                                                           .data!
//                                                                           .findAllTableData![
//                                                                               index]
//                                                                           .maintType
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
//                                                                   "CONTRACTOR: ",
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
//                                                                   (contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].contractor ==
//                                                                               null ||
//                                                                           contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].contractor.toString() ==
//                                                                               'null')
//                                                                       ? ''
//                                                                       : contractorOrderPendingViewModel
//                                                                           .contractorOrderPendingGetTabularData
//                                                                           .data!
//                                                                           .findAllTableData![
//                                                                               index]
//                                                                           .contractor
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
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                   const Divider(
//                                                     color: Colors.grey,
//                                                   ),
//                                                   Padding(
//                                                     padding:
//                                                         const EdgeInsets.only(
//                                                             left: 8.0),
//                                                     child: Row(
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
//                                                                   "TOTAL MILES: ",
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
//                                                                   (contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].totalMiles ==
//                                                                               null ||
//                                                                           contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].totalMiles.toString() ==
//                                                                               'null')
//                                                                       ? ''
//                                                                       : contractorOrderPendingViewModel
//                                                                           .contractorOrderPendingGetTabularData
//                                                                           .data!
//                                                                           .findAllTableData![
//                                                                               index]
//                                                                           .totalMiles
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
//                                                                   "CONTRACT YEAR: ",
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
//                                                                   (contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].contractYear ==
//                                                                               null ||
//                                                                           contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].contractYear.toString() ==
//                                                                               'null')
//                                                                       ? ''
//                                                                       : contractorOrderPendingViewModel
//                                                                           .contractorOrderPendingGetTabularData
//                                                                           .data!
//                                                                           .findAllTableData![
//                                                                               index]
//                                                                           .contractYear
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
//                                                                   (contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].cycle ==
//                                                                               null ||
//                                                                           contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].cycle.toString() ==
//                                                                               'null')
//                                                                       ? ''
//                                                                       : contractorOrderPendingViewModel
//                                                                           .contractorOrderPendingGetTabularData
//                                                                           .data!
//                                                                           .findAllTableData![
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
//                                                   ),
//                                                   const Divider(
//                                                     color: Colors.grey,
//                                                   ),
//                                                   Padding(
//                                                     padding:
//                                                         const EdgeInsets.only(
//                                                             left: 8.0),
//                                                     child: Row(
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
//                                                                   "SERVICE STREET ADDRESS: ",
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
//                                                                   (contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].streetAddress ==
//                                                                               null ||
//                                                                           contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].streetAddress.toString() ==
//                                                                               'null')
//                                                                       ? ''
//                                                                       : contractorOrderPendingViewModel
//                                                                           .contractorOrderPendingGetTabularData
//                                                                           .data!
//                                                                           .findAllTableData![
//                                                                               index]
//                                                                           .streetAddress
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
//                                                                   "SERVICE MAP LOCATION: ",
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
//                                                                   (contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].mapLocation ==
//                                                                               null ||
//                                                                           contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].mapLocation.toString() ==
//                                                                               'null')
//                                                                       ? ''
//                                                                       : contractorOrderPendingViewModel
//                                                                           .contractorOrderPendingGetTabularData
//                                                                           .data!
//                                                                           .findAllTableData![
//                                                                               index]
//                                                                           .mapLocation
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
//                                                                   "ADMIN NOTES 1: ",
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
//                                                                   (contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].adminNotes1 ==
//                                                                               null ||
//                                                                           contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].adminNotes1.toString() ==
//                                                                               'null')
//                                                                       ? ''
//                                                                       : contractorOrderPendingViewModel
//                                                                           .contractorOrderPendingGetTabularData
//                                                                           .data!
//                                                                           .findAllTableData![
//                                                                               index]
//                                                                           .adminNotes1
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
//                                                   ),
//                                                   const Divider(
//                                                     color: Colors.grey,
//                                                   ),
//                                                   Padding(
//                                                     padding:
//                                                         const EdgeInsets.only(
//                                                             left: 8.0),
//                                                     child: Row(
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
//                                                                   "CONTRACTOR COMPANY: ",
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
//                                                                   (contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].contractorCompany ==
//                                                                               null ||
//                                                                           contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].contractorCompany.toString() ==
//                                                                               'null')
//                                                                       ? ''
//                                                                       : contractorOrderPendingViewModel
//                                                                           .contractorOrderPendingGetTabularData
//                                                                           .data!
//                                                                           .findAllTableData![
//                                                                               index]
//                                                                           .contractorCompany
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
//                                                                   (contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].dateOfInspection ==
//                                                                               null ||
//                                                                           contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].dateOfInspection.toString() ==
//                                                                               'null')
//                                                                       ? ''
//                                                                       : contractorOrderPendingViewModel
//                                                                           .contractorOrderPendingGetTabularData
//                                                                           .data!
//                                                                           .findAllTableData![
//                                                                               index]
//                                                                           .dateOfInspection
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
//                                                                   "FOLLOW UP DATE: ",
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
//                                                                   (contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].followUpDate ==
//                                                                               null ||
//                                                                           contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].followUpDate.toString() ==
//                                                                               'null')
//                                                                       ? ''
//                                                                       : contractorOrderPendingViewModel
//                                                                           .contractorOrderPendingGetTabularData
//                                                                           .data!
//                                                                           .findAllTableData![
//                                                                               index]
//                                                                           .followUpDate
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
//                                                   ),
//                                                   const Divider(
//                                                     color: Colors.grey,
//                                                   ),
//                                                   Padding(
//                                                     padding:
//                                                         const EdgeInsets.only(
//                                                             left: 8.0),
//                                                     child: Row(
//                                                       children: [
//                                                         // Expanded(
//                                                         //   // alignment: Alignment.topLeft,
//                                                         //   child: Column(
//                                                         //     children: [
//                                                         //       const Align(
//                                                         //         alignment:
//                                                         //             Alignment
//                                                         //                 .topLeft,
//                                                         //         child: Text(
//                                                         //           "COST PER MILE: ",
//                                                         //           textAlign:
//                                                         //               TextAlign
//                                                         //                   .left,
//                                                         //           style:
//                                                         //               TextStyle(
//                                                         //             fontSize: 12,
//                                                         //             fontWeight:
//                                                         //                 FontWeight
//                                                         //                     .bold,
//                                                         //             color: Colors
//                                                         //                 .white,
//                                                         //           ),
//                                                         //         ),
//                                                         //       ),
//                                                         //       Align(
//                                                         //         alignment:
//                                                         //             Alignment
//                                                         //                 .topLeft,
//                                                         //         child: Text(
//                                                         //           (contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].costPerMile ==
//                                                         //                       null ||
//                                                         //                   contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].costPerMile.toString() ==
//                                                         //                       'null')
//                                                         //               ? ''
//                                                         //               : contractorOrderPendingViewModel
//                                                         //                   .contractorOrderPendingGetTabularData
//                                                         //                   .data!
//                                                         //                   .findAllTableData![
//                                                         //                       index]
//                                                         //                   .costPerMile
//                                                         //                   .toString(),
//                                                         //           textAlign:
//                                                         //               TextAlign
//                                                         //                   .left,
//                                                         //           style:
//                                                         //               const TextStyle(
//                                                         //             fontSize: 12,
//                                                         //             color: Colors
//                                                         //                 .white,
//                                                         //           ),
//                                                         //         ),
//                                                         //       ),
//                                                         //     ],
//                                                         //   ),
//                                                         // ),
//                                                         // Expanded(
//                                                         //   // alignment: Alignment.topLeft,
//                                                         //   child: Column(
//                                                         //     children: [
//                                                         //       const Align(
//                                                         //         alignment:
//                                                         //             Alignment
//                                                         //                 .topLeft,
//                                                         //         child: Text(
//                                                         //           "TOTAL COST: ",
//                                                         //           textAlign:
//                                                         //               TextAlign
//                                                         //                   .left,
//                                                         //           style:
//                                                         //               TextStyle(
//                                                         //             fontSize: 12,
//                                                         //             fontWeight:
//                                                         //                 FontWeight
//                                                         //                     .bold,
//                                                         //             color: Colors
//                                                         //                 .white,
//                                                         //           ),
//                                                         //         ),
//                                                         //       ),
//                                                         //       Align(
//                                                         //         alignment:
//                                                         //             Alignment
//                                                         //                 .topLeft,
//                                                         //         child: Text(
//                                                         //           (contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].totalCost ==
//                                                         //                       null ||
//                                                         //                   contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].totalCost.toString() ==
//                                                         //                       'null')
//                                                         //               ? ''
//                                                         //               : contractorOrderPendingViewModel
//                                                         //                   .contractorOrderPendingGetTabularData
//                                                         //                   .data!
//                                                         //                   .findAllTableData![
//                                                         //                       index]
//                                                         //                   .totalCost
//                                                         //                   .toString(),
//                                                         //           textAlign:
//                                                         //               TextAlign
//                                                         //                   .left,
//                                                         //           style:
//                                                         //               const TextStyle(
//                                                         //             fontSize: 12,
//                                                         //             color: Colors
//                                                         //                 .white,
//                                                         //           ),
//                                                         //         ),
//                                                         //       ),
//                                                         //     ],
//                                                         //   ),
//                                                         // ),

//                                                         Expanded(
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
//                                                                   (contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].nextMaintDue ==
//                                                                               null ||
//                                                                           contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].nextMaintDue.toString() ==
//                                                                               'null')
//                                                                       ? ''
//                                                                       : formattedDateNextMaintDue,
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

//                                                         // Expanded(
//                                                         //   // alignment: Alignment.topLeft,
//                                                         //   child: Column(
//                                                         //     children: [
//                                                         //       const Align(
//                                                         //         alignment:
//                                                         //             Alignment
//                                                         //                 .topLeft,
//                                                         //         child: Text(
//                                                         //           "ESTIMATED COST: ",
//                                                         //           textAlign:
//                                                         //               TextAlign
//                                                         //                   .left,
//                                                         //           style:
//                                                         //               TextStyle(
//                                                         //             fontSize: 12,
//                                                         //             fontWeight:
//                                                         //                 FontWeight
//                                                         //                     .bold,
//                                                         //             color: Colors
//                                                         //                 .white,
//                                                         //           ),
//                                                         //         ),
//                                                         //       ),
//                                                         //       Align(
//                                                         //         alignment:
//                                                         //             Alignment
//                                                         //                 .topLeft,
//                                                         //         child: Text(
//                                                         //           (contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].estCost ==
//                                                         //                       null ||
//                                                         //                   contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].estCost.toString() ==
//                                                         //                       'null')
//                                                         //               ? ''
//                                                         //               : contractorOrderPendingViewModel
//                                                         //                   .contractorOrderPendingGetTabularData
//                                                         //                   .data!
//                                                         //                   .findAllTableData![
//                                                         //                       index]
//                                                         //                   .estCost
//                                                         //                   .toString(),
//                                                         //           textAlign:
//                                                         //               TextAlign
//                                                         //                   .left,
//                                                         //           style:
//                                                         //               const TextStyle(
//                                                         //             fontSize: 12,
//                                                         //             color: Colors
//                                                         //                 .white,
//                                                         //           ),
//                                                         //         ),
//                                                         //       ),
//                                                         //     ],
//                                                         //   ),
//                                                         // ),

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
//                                                                   (contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].estTime ==
//                                                                               null ||
//                                                                           contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].estTime.toString() ==
//                                                                               'null')
//                                                                       ? ''
//                                                                       : contractorOrderPendingViewModel
//                                                                           .contractorOrderPendingGetTabularData
//                                                                           .data!
//                                                                           .findAllTableData![
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
//                                                           flex: 1,
//                                                           // alignment: Alignment.topLeft,
//                                                           child: Column(
//                                                             children: [
//                                                               const Align(
//                                                                 alignment:
//                                                                     Alignment
//                                                                         .topLeft,
//                                                                 child: Text(
//                                                                   "CREATE DATE: ",
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
//                                                                   (contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].createDate ==
//                                                                               null ||
//                                                                           contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].createDate.toString() ==
//                                                                               'null')
//                                                                       ? ''
//                                                                       : formattedDateCreateDate,
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
//                                                   ),
//                                                   const Divider(
//                                                     color: Colors.grey,
//                                                   ),
//                                                   Padding(
//                                                     padding:
//                                                         const EdgeInsets.only(
//                                                             left: 8.0),
//                                                     child: Row(
//                                                       children: [
//                                                         // Expanded(
//                                                         //   // alignment: Alignment.topLeft,
//                                                         //   child: Column(
//                                                         //     children: [
//                                                         //       const Align(
//                                                         //         alignment:
//                                                         //             Alignment
//                                                         //                 .topLeft,
//                                                         //         child: Text(
//                                                         //           "ACTUAL COST: ",
//                                                         //           textAlign:
//                                                         //               TextAlign
//                                                         //                   .left,
//                                                         //           style:
//                                                         //               TextStyle(
//                                                         //             fontSize: 12,
//                                                         //             fontWeight:
//                                                         //                 FontWeight
//                                                         //                     .bold,
//                                                         //             color: Colors
//                                                         //                 .white,
//                                                         //           ),
//                                                         //         ),
//                                                         //       ),
//                                                         //       Align(
//                                                         //         alignment:
//                                                         //             Alignment
//                                                         //                 .topLeft,
//                                                         //         child: Text(
//                                                         //           (contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].actualCost ==
//                                                         //                       null ||
//                                                         //                   contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].actualCost.toString() ==
//                                                         //                       'null')
//                                                         //               ? ''
//                                                         //               : contractorOrderPendingViewModel
//                                                         //                   .contractorOrderPendingGetTabularData
//                                                         //                   .data!
//                                                         //                   .findAllTableData![
//                                                         //                       index]
//                                                         //                   .actualCost
//                                                         //                   .toString(),
//                                                         //           textAlign:
//                                                         //               TextAlign
//                                                         //                   .left,
//                                                         //           style:
//                                                         //               const TextStyle(
//                                                         //             fontSize: 12,
//                                                         //             color: Colors
//                                                         //                 .white,
//                                                         //           ),
//                                                         //         ),
//                                                         //       ),
//                                                         //     ],
//                                                         //   ),
//                                                         // ),
//                                                         Expanded(
//                                                           // alignment: Alignment.topLeft,
//                                                           child: Column(
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
//                                                               (contractorOrderPendingViewModel
//                                                                           .contractorOrderPendingGetTabularData
//                                                                           .data!
//                                                                           .findAllTableData![
//                                                                               index]
//                                                                           .maintType
//                                                                           .toString() ==
//                                                                       'RegularMaint')
//                                                                   ? (contractorOrderPendingViewModel
//                                                                               .contractorOrderPendingGetTabularData
//                                                                               .data!
//                                                                               .findAllTableData![index]
//                                                                               .visibilityflag
//                                                                               .toString() ==
//                                                                           '2')
//                                                                       ? Align(
//                                                                           alignment:
//                                                                               Alignment.topLeft,
//                                                                           child:
//                                                                               InkWell(
//                                                                             onTap:
//                                                                                 () async {
//                                                                               CustomToastSnackBarProgressDialog.flushBarSuccessMessage('Job no : ${contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].tokenNo.toString()} already shared with Crew', context);
//                                                                             },
//                                                                             child: const Align(
//                                                                                 alignment: Alignment.topLeft,
//                                                                                 child: Icon(
//                                                                                   Icons.share,
//                                                                                   color: Colors.green,
//                                                                                 )),
//                                                                           ),
//                                                                         )
//                                                                       : Align(
//                                                                           alignment:
//                                                                               Alignment.topLeft,
//                                                                           child:
//                                                                               InkWell(
//                                                                             onTap:
//                                                                                 () async {
//                                                                               // updateFlagValue(contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].tokenNo.toString(),
//                                                                               //     2);
//                                                                               openDialogFlag(contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].tokenNo.toString());
//                                                                             },
//                                                                             child: const Align(
//                                                                                 alignment: Alignment.topLeft,
//                                                                                 child: Icon(
//                                                                                   Icons.share,
//                                                                                   color: Colors.blue,
//                                                                                 )),
//                                                                           ),
//                                                                         )
//                                                                   : const Text(
//                                                                       "",
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
//                                                             ],
//                                                           ),
//                                                         ),

//                                                         Expanded(
//                                                           flex: 2,
//                                                           child: InkWell(
//                                                             onTap: () async {
//                                                               String id = '';
//                                                               final userPreferences1 =
//                                                                   Provider.of<
//                                                                           UserPref>(
//                                                                       context,
//                                                                       listen:
//                                                                           false);
//                                                               UserModel data =
//                                                                   await userPreferences1
//                                                                       .getUser();
//                                                               id = data.user!.id
//                                                                   .toString();
//                                                               // Navigator.of(context).push(
//                                                               //     MaterialPageRoute(
//                                                               //         builder: (BuildContext
//                                                               //                 context) =>
//                                                               // MapViewContractor(
//                                                               //   id: contractorOrderPendingViewModel
//                                                               //       .contractorOrderPendingGetTabularData
//                                                               //       .data!
//                                                               //       .findAllTableData![index]
//                                                               //       .id
//                                                               //       .toString(),
//                                                               // )));
//                                                               // Navigator.push(
//                                                               //   context,
//                                                               //   MaterialPageRoute(
//                                                               //     builder:
//                                                               //         (context) =>
//                                                               //             MapViewPage(
//                                                               //       url: MapUrl.getGfEndPoint(
//                                                               //           contractorOrderPendingViewModel
//                                                               //               .contractorOrderPendingGetTabularData
//                                                               //               .data!
//                                                               //               .findAllTableData![index]
//                                                               //               .tokenNo
//                                                               //               .toString(),
//                                                               //           id),
//                                                               //     ),
//                                                               //   ),
//                                                               // );

//                                                               await browser.open(
//                                                                   url: WebUri(
//                                                                       // "https://mapapi.ariespro.com/main/contractor/CIVM_Map/${contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].tokenNo.toString()}/USRQWXH589Z"),
//                                                                    MapUrl.getGfEndPoint(contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData![index].tokenNo.toString(),id)),
//                                                                    settings: ChromeSafariBrowserSettings(
//                                                                       shareState:
//                                                                           CustomTabsShareState
//                                                                               .SHARE_STATE_OFF,
//                                                                       barCollapsingEnabled:
//                                                                           true));
//                                                             },
//                                                             child: Align(
//                                                               alignment: Alignment
//                                                                   .centerLeft,
//                                                               child: Container(
//                                                                 // margin: const EdgeInsets.only(
//                                                                 //     left: 40, right: 40, bottom: 10.0),
//                                                                 padding:
//                                                                     const EdgeInsets
//                                                                         .all(8),
//                                                                 alignment: Alignment
//                                                                     .centerLeft,
//                                                                 width: 80,
//                                                                 // MediaQuery.of(context).size.width,
//                                                                 // height: MediaQuery.of(context).size.height * 0.4,
//                                                                 decoration:
//                                                                     const BoxDecoration(
//                                                                         // shape: BoxShape.circle,

//                                                                         color: Color.fromARGB(
//                                                                             255,
//                                                                             0,
//                                                                             58,
//                                                                             106),
//                                                                         gradient:
//                                                                             LinearGradient(
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
//                                                                 child:
//                                                                     const Align(
//                                                                   alignment:
//                                                                       Alignment
//                                                                           .center,
//                                                                   child: Text(
//                                                                     "VIEW MAP",
//                                                                     style:
//                                                                         TextStyle(
//                                                                       color: Colors
//                                                                           .white,
//                                                                       fontWeight:
//                                                                           FontWeight
//                                                                               .bold,
//                                                                       fontSize:
//                                                                           10,
//                                                                     ),
//                                                                   ),
//                                                                 ),
//                                                               ),
//                                                             ),
//                                                           ),
//                                                         )
//                                                       ],
//                                                     ),
//                                                   ),
//                                                 ]),
//                                               ),
//                                             ),
//                                           ],
//                                         );
//                                       }),
//                                 ),
//                               ],
//                             ),
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

//   void openDialogFlag(String tokenNo) => showDialog(
//       context: context,
//       builder: (context) {
//         return StatefulBuilder(builder: (context, setState) {
//           return AlertDialog(
//             content: SingleChildScrollView(
//                 child: Column(
//               children: [
//                 Container(
//                   margin: const EdgeInsets.only(top: 10),
//                   child: Column(children: [
//                     Column(children: [
//                       Align(
//                         alignment: Alignment.centerLeft,
//                         child: Text(
//                           "Are you sure to share job no : $tokenNo with Crew?",
//                           textAlign: TextAlign.left,
//                           style: const TextStyle(
//                             color: Color.fromARGB(255, 7, 59, 120),
//                             fontWeight: FontWeight.bold,
//                             fontSize: 16,
//                           ),
//                         ),
//                       ),
//                     ]),
//                   ]),
//                 ),
//               ],
//             )),
//             actions: [
//               Align(
//                 alignment: Alignment.center,
//                 child: Row(
//                   children: [
//                     Container(
//                         margin: EdgeInsets.only(
//                             left: MediaQuery.of(context).size.width * 0.15,
//                             top: 6.0,
//                             bottom: 10,
//                             right: 2),
//                         child: InkWell(
//                           onTap: () {
//                             Navigator.pop(context);
//                           },
//                           child: Container(
//                             margin: const EdgeInsets.only(bottom: 10.0),
//                             // padding: const EdgeInsets.all(8),
//                             alignment: Alignment.center,
//                             width: MediaQuery.of(context).size.width * 0.25,
//                             height: 40,
//                             decoration: BoxDecoration(
//                                 // shape: BoxShape.circle,
//                                 borderRadius: BorderRadius.circular(10),
//                                 boxShadow: const [
//                                   BoxShadow(
//                                       color: Color.fromARGB(255, 84, 7, 2),
//                                       blurRadius: 5,
//                                       offset: Offset(2.0, 5.0))
//                                 ],
//                                 color: Colors.black,
//                                 gradient: const LinearGradient(
//                                   colors: [Colors.red, Colors.red],
//                                 )),
//                             child: const Align(
//                               alignment: Alignment.center,
//                               child: Text(
//                                 "NO",
//                                 textAlign: TextAlign.left,
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 20,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         )),
//                     Container(
//                         margin: const EdgeInsets.only(
//                             left: 6, top: 6.0, bottom: 10),
//                         child: InkWell(
//                           onTap: () {
//                             updateFlagValue(tokenNo, 2);
//                           },
//                           child: Container(
//                             margin: const EdgeInsets.only(bottom: 10.0),
//                             // padding: const EdgeInsets.all(8),
//                             alignment: Alignment.center,
//                             width: MediaQuery.of(context).size.width * 0.25,
//                             height: 40,
//                             decoration: BoxDecoration(
//                                 // shape: BoxShape.circle,

//                                 borderRadius: BorderRadius.circular(10),
//                                 boxShadow: const [
//                                   BoxShadow(
//                                       color: Color.fromARGB(255, 1, 91, 4),
//                                       blurRadius: 5,
//                                       offset: Offset(2.0, 5.0))
//                                 ],
//                                 color: Colors.black,
//                                 gradient: const LinearGradient(
//                                   colors: [Colors.green, Colors.green],
//                                 )),
//                             child: const Align(
//                               alignment: Alignment.center,
//                               child: Text(
//                                 "YES",
//                                 textAlign: TextAlign.left,
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 20,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         )),
//                   ],
//                 ),
//               ),
//             ],
//           );
//         });
//       });

//   Future openDailogPendingApproval(String id) => showDialog(
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
//                       "Work Order No. : ${id}",
//                       style: const TextStyle(
//                         fontSize: 16.0,
//                         color: Color.fromARGB(255, 7, 59, 120),
//                       ),
//                     ),
//                   ),
//                   Container(
//                     margin: const EdgeInsets.only(top: 10),
//                     child: Column(
//                       children: [
//                         const Align(
//                             alignment: Alignment.centerLeft,
//                             child: Padding(
//                               padding: EdgeInsets.all(2.0),
//                               child: Text(
//                                 "Notes",
//                                 style: TextStyle(
//                                   fontSize: 16.0,
//                                   color: Color.fromARGB(255, 7, 59, 120),
//                                 ),
//                               ),
//                             )),
//                         Align(
//                           alignment: Alignment.centerRight,
//                           child: Padding(
//                             padding: const EdgeInsets.all(2.0),
//                             child: TextFormField(
//                               //  key: formkey2,
//                               controller: _notes,
//                               style: const TextStyle(
//                                   color: Color.fromARGB(255, 7, 59, 120),
//                                   fontSize: 16),
//                               obscureText: false,
//                               // keyboardType: TextInputType.number,
//                               decoration: const InputDecoration(
//                                 border: OutlineInputBorder(),
//                                 enabledBorder: OutlineInputBorder(
//                                   borderSide: BorderSide(
//                                     color: Color.fromARGB(255, 7, 59, 120),
//                                   ),
//                                 ),
//                                 hintText: 'notes',
//                               ),

//                               validator: (value) {
//                                 if (value.toString() == '') {
//                                   return "Please enter notes";
//                                 } else {
//                                   return null;
//                                 }
//                               },
//                             ),
//                           ),
//                         )
//                       ],
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
//                             print('a');
//                             contractorOrderPendingViewModel
//                                 .fetchStatusChangeApi(
//                                     context,
//                                     'PENDING APPROVAL',
//                                     _notes.text.toString(),
//                                     int.parse(id))
//                                 .then((value) {
//                               print('Success');
//                               Navigator.pop(context);
//                               fetchData();
//                             });
//                             // print(updatedCard);
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
//                                     "Submit",
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
//                                     "Close",
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

//   fetchData() async {
//     final userPreferences = Provider.of<UserPref>(context, listen: false);
//     UserModel data = await userPreferences.getUser();
//     contractorOrderPendingViewModel.fetchContractorOrderPendingTabularListApi(
//         context, data.user!.id.toString(), '');
//     print('object');
//     print(data.user!.id.toString());
//   }

//   Future<void> _filterData(String query) async {
//     if (query.isEmpty) {
//       final userPreferences = Provider.of<UserPref>(context, listen: false);
//       UserModel data = await userPreferences.getUser();
//       contractorOrderPendingViewModel.fetchContractorOrderPendingTabularListApi(
//           context, data.user!.id.toString(), '');
//     } else {
//       contractorOrderPendingViewModel.contractorOrderPendingGetTabularData.data!.findAllTableData = contractorOrderPendingViewModel
//           .contractorOrderPendingGetTabularData.data!.findAllTableData!
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
//             int length = contractorOrderPendingViewModel
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
//     String? imageLocation = contractorOrderPendingViewModel
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
//         fetchData();
//       } else {
//         print('API request failed with status code: ${response.statusCode}');
//         print('Response body: ${response.body}');
//       }
//     } catch (e) {
//       print('Error: $e');
//     }
//   }

//   Future<void> updateFlagValue(String token, int flag) async {
//     const String url =
//         'https://civmapi.ariespro.com/civmapi/vma_row_custom_main_plan/updateFlagValue';
//     final userPreferences = Provider.of<UserPref>(context, listen: false);
//     UserModel data = await userPreferences.getUser();
//     try {
//       final response = await http.post(
//         Uri.parse(url),
//         headers: {
//           'Authorization': 'Bearer ${data.token}',
//           'Content-Type': 'application/x-www-form-urlencoded',
//         },
//         body: {
//           'token': token,
//           'flag': flag.toString(),
//         },
//       );

//       if (response.statusCode == 200) {
//         var responseBody = json.decode(response.body);
//         print('responseBody $responseBody');
//         String crewEmailId = responseBody['crewEmailId'];
//         print('API call successful');
//         CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
//             'Job no : $token successfully shared with Crew', context);
//         DateTime now = DateTime.now();
//         var formatter = DateFormat('MM-dd-yyyy HH:mm:ss');
//         String formattedDate = formatter.format(now);
//         var subject = 'CIVM ROW';
//         var msg =
//             'Job No. $token Row Maintenance Successfully Shared with you on $formattedDate.';
//         _sendMail(subject, msg, crewEmailId);
//         fetchData();
//         await Future.delayed(Duration(seconds: 3));
//         Navigator.pop(context);
//         Navigator.pop(context);
//       } else {
//         print('Failed to update flag: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Error occurred: $e');
//     }
//   }

//   Future<void> _sendMail(
//       String subject, String content, String crewEmailId) async {
//     List<String> recipientsList = [];
//     for (int i = 0; i < recipientsList.length; i++) {
//       recipientsList.add(recipientsList[i]);
//     }

//     String username = 'ats.ariespro@gmail.com';
//     String password = 'ahbfhcshjujvkgge';

//     final smtpServer = gmail(username, password);
//     final message = Message()
//       ..from = Address(username, 'CIVM')
//       ..recipients.addAll([
//         // 'jitendra.kushwaha@ariespro.com',
//         // 'preetika.patel@ariespro.com',
//         crewEmailId
//       ])
//       ..subject = subject
//       // ..html = "<h4>Hi,</h4>\n<p>${content}</p>";
//       ..html =
//           "<h4>Hi,</h4>\n<p>$content</p>\n<p>Note: DO NOT REPLY TO THIS EMAIL. </p>\n<p>Thank you, </p>\n<p>AriesPro Utilities</p>";

//     try {
//       final sendReport = await send(message, smtpServer);
//       print('Message sent: ' + sendReport.toString());
//     } on MailerException catch (e) {
//       print('Message not sent.');
//       for (var p in e.problems) {
//         print('Problem: ${p.code}: ${p.msg}');
//       }
//     }
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
//       child: SafeArea(
//         child: Column(
//           // Important: Remove any padding from the ListView.
//           // padding: EdgeInsets.zero,
//           children: [
//              Container(
//           width: double.infinity,
//           height: 180,
//           color: const Color.fromARGB(
//                                                   255, 3, 47, 97),
//           padding: const EdgeInsets.only(top: 24),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
// menuLogoLCP(), const SizedBox(height: 6),
//         Text(
//           userName,
//           style: const TextStyle(fontSize: 18, color: Colors.white),
//         ),
//             ],
//           ),
//         ),
//            Expanded(
//              child: ListView(
//                children: [
//                  ListTile(
//                     leading: const Icon(
//                       Icons.computer,
//                     ),
//                     title: const Text('General Foreman Dashboard'),
//                     textColor: const Color.fromARGB(255, 7, 59, 120),
//                     iconColor: const Color.fromARGB(255, 7, 59, 120),
//                     onTap: () {
//                       Navigator.of(context).push(MaterialPageRoute(
//                           builder: (BuildContext context) =>
//                               const ContractorBottomNavigationPannel()));
//                     },
//                   ),
//                   // ListTile(
//             //   leading: const Icon(
//             //     Icons.pending,
//             //   ),
//             //   title: const Text('Change Order Pending'),
//             //   textColor: const Color.fromARGB(255, 7, 59, 120),
//             //   iconColor: const Color.fromARGB(255, 7, 59, 120),
//             //   onTap: () {
//             //     Navigator.pop(context);
//             //   },
//             // ),
//             // Visibility(
//             //   visible: (widget.menu.isNotEmpty &&
//             //           widget.menu.contains('Energy Audit Ticket'))
//             //       ? true
//             //       : false,
//             // child:
//             // ListTile(
//             //   leading: const Icon(
//             //     Icons.running_with_errors,
//             //   ),
//             //   title: const Text('IVM Maintenance Progress'),
//             //   textColor: const Color.fromARGB(255, 7, 59, 120),
//             //   iconColor: const Color.fromARGB(255, 7, 59, 120),
//             //   onTap: () {
//             //     Navigator.of(context).push(MaterialPageRoute(
//             //         builder: (BuildContext context) =>
//             //             const RowMaintenanceProgressContractor()));
//             //   },
//             // ),
//             ListTile(
//               leading: const Icon(
//                 Icons.settings_applications_sharp,
//               ),
//               title: const Text('Maintenance Report View'),
//               textColor: const Color.fromARGB(255, 7, 59, 120),
//               iconColor: const Color.fromARGB(255, 7, 59, 120),
//               onTap: () {
//                 Navigator.of(context).push(MaterialPageRoute(
//                     builder: (BuildContext context) =>
//                          GfMaintenanceReportViewNew(year:'')));
//               },
//             ),
//             // ),
//             ListTile(
//               leading: const Icon(
//                 Icons.change_circle,
//               ),
//               title: const Text('Change Order'),
//               textColor: const Color.fromARGB(255, 7, 59, 120),
//               iconColor: const Color.fromARGB(255, 7, 59, 120),
//               onTap: () {
//                 // Navigator.of(context).push(MaterialPageRoute(
//                 //     builder: (BuildContext context) =>
//                 //         const ChangeOrderContractor()));
//               },
//             ),
        
//             // ListTile(
//             //   leading: const Icon(
//             //     Icons.inventory,
//             //   ),
//             //   title: const Text('Daily Herbicide Application Form'),
//             //   textColor: const Color.fromARGB(255, 7, 59, 120),
//             //   iconColor: const Color.fromARGB(255, 7, 59, 120),
//             //   onTap: () {
//             //     Navigator.of(context).push(MaterialPageRoute(
//             //         builder: (BuildContext context) =>
//             //             const DailyHerbicideApplicationFormContractor()));
//             //   },
//             // ),
        
//             // ListTile(
//             //   leading: const Icon(
//             //     Icons.list_alt,
//             //   ),
//             //   title: const Text('Power Time Form'),
//             //   textColor: const Color.fromARGB(255, 7, 59, 120),
//             //   iconColor: const Color.fromARGB(255, 7, 59, 120),
//             //   onTap: () {
//             //     Navigator.of(context).push(MaterialPageRoute(
//             //         builder: (BuildContext context) =>
//             //             const PowerTimeFormContractor()));
//             //   },
//             // ),
        
//             ListTile(
//               leading: const Icon(
//                 Icons.list_alt,
//               ),
//               title: const Text('Invoice Form'),
//               textColor: const Color.fromARGB(255, 7, 59, 120),
//               iconColor: const Color.fromARGB(255, 7, 59, 120),
//               onTap: () {
//                 Navigator.of(context).push(MaterialPageRoute(
//                     builder: (BuildContext context) =>
//                         const InvoiceFormContractor()));
//               },
//             ),
        
//             // ListTile(
//             //   leading: const Icon(
//             //     Icons.list_alt,
//             //   ),
//             //   title: const Text('Mixing Inventory Form'),
//             //   textColor: const Color.fromARGB(255, 7, 59, 120),
//             //   iconColor: const Color.fromARGB(255, 7, 59, 120),
//             //   onTap: () {
//             //     Navigator.of(context).push(MaterialPageRoute(
//             //         builder: (BuildContext context) =>
//             //             const MixingInventoryFormContractor()));
//             //   },
//             // ),
//             ListTile(
//               leading: const Icon(
//                 Icons.create,
//               ),
//               title: const Text('Create Invoice'),
//               textColor: const Color.fromARGB(255, 7, 59, 120),
//               iconColor: const Color.fromARGB(255, 7, 59, 120),
//               onTap: () {
//                 Navigator.of(context).push(MaterialPageRoute(
//                     builder: (BuildContext context) =>
//                         const CreateInvoiceContractor()));
//               },
//             ),
//             ListTile(
//               leading: const Icon(
//                 Icons.list,
//               ),
//               title: const Text('Invoice List'),
//               textColor: const Color.fromARGB(255, 7, 59, 120),
//               iconColor: const Color.fromARGB(255, 7, 59, 120),
//               onTap: () {
//                 Navigator.of(context).push(MaterialPageRoute(
//                     builder: (BuildContext context) =>
//                         const InvoiceListContrator()));
//               },
//             ),
//             ListTile(
//               leading: const Icon(
//                 Icons.map,
//               ),
//               title: const Text('Live IVM System Map'),
//               textColor: const Color.fromARGB(255, 7, 59, 120),
//               iconColor: const Color.fromARGB(255, 7, 59, 120),
//               onTap: () {
//                 provider.getLocation();
//                 Navigator.of(context).push(MaterialPageRoute(
//                     builder: (context) => const MapScreenLeafLat()));
//               },
//             ),
//             ListTile(
//               leading: const Icon(
//                 Icons.add,
//               ),
//               title: const Text('Add Crew Member'),
//               textColor: const Color.fromARGB(255, 7, 59, 120),
//               iconColor: const Color.fromARGB(255, 7, 59, 120),
//               onTap: () {
//                 Navigator.of(context).push(MaterialPageRoute(
//                     builder: (BuildContext context) =>
//                         const GFAddCrewMember()));
//               },
//             ),
//             ListTile(
//               leading: const Icon(
//                 Icons.logout,
//               ),
//               title: const Text('Log Out'),
//               textColor: const Color.fromARGB(255, 7, 59, 120),
//               iconColor: const Color.fromARGB(255, 7, 59, 120),
//               onTap: () {
//                 // // Constants.prefs.setBool("LoggedIn", false);
//                 userPreferences.remove().then((value) {
//                   Navigator.of(context).push(MaterialPageRoute(
//                       builder: (BuildContext context) => const LoginPage()));
//                 });
//                 // Navigator.of(context).pushReplacement(MaterialPageRoute(
//                 //     builder: (BuildContext context) => const LoginPage()));
//               },
//             ),],
//              ),
//            ),
//            Container(
//           padding: const EdgeInsets.symmetric(vertical: 12),
//           alignment: Alignment.center,
//           child: Column(
//             children: [
//               Text(
//                 'Version: ${Constants.prefs.getString('VERSION') ?? ''}',
//                 style: const TextStyle(
//                   fontSize: 13,
//                   color: Colors.grey,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//               Text(
//                 'Updated: ${Constants.prefs.getString('VERSION_DATE') ?? ''}',
//                 style: const TextStyle(
//                   fontSize: 13,
//                   color: Colors.grey,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//             ],
//           ),
//         ),
           
//           ],
//         ),
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
//       userName = '${data.user!.fName} ${data.user!.lName}';
//     });
//   }
// }
