// import 'dart:convert';
// import 'dart:io';

// import 'package:CIVM/models/user_model.dart';
// import 'package:CIVM/resources/app_url.dart';
// import 'package:CIVM/screens/admin_pannel/row_maintenance_view/pdf_view.dart';
// import 'package:CIVM/screens/chat_history.dart';
// import 'package:CIVM/screens/generalForeman_New_pannel/create_order_contractor.dart';
// import 'package:CIVM/screens/generalForeman_New_pannel/view_change_order.dart';
// import 'package:CIVM/screens/my_chrome_safari_map_recording.dart';
// import 'package:CIVM/screens/video_folder/fullVideo/full_screen_video_player.dart';
// import 'package:CIVM/utils/common_functions.dart';
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
// import '../../../data/response/status.dart';
// import '../../../view_model/lcp_work_order_pending_view_model.dart';
// import 'package:http/http.dart' as http;

// import '../../repository/map_url.dart';

// // ignore: must_be_immutable
// class TotalOrderPendingContractor extends StatefulWidget {
//   String budgetType;
//   String maintenanceType;
//   String heading;

//   TotalOrderPendingContractor({
//     Key? key,
//     required this.budgetType,
//     required this.maintenanceType,
//     required this.heading,
//   }) : super(key: key);

//   @override
//   State<TotalOrderPendingContractor> createState() =>
//       _TotalOrderPendingContractorState();
// }

// class _TotalOrderPendingContractorState
//     extends State<TotalOrderPendingContractor> {
//   List<String> menu = [];

//   int workOrderNoId = 0;
//   // ignore: prefer_typing_uninitialized_variables
//   var selectedWorkOrderNo;

//   String userName = '';
//   final browser = MyChromeSafariBrowser();
//   LCPWorkOrderPendingViewModel lCPWorkOrderPendingViewModel =
//       LCPWorkOrderPendingViewModel();

//   final TextEditingController _input = TextEditingController();
//   final TextEditingController _notes = TextEditingController();
//   String id = '';

//   bool _isVisibleChangeOrder = true;

//   ContractorOrderPendingViewModel contractorOrderPendingViewModel =
//       ContractorOrderPendingViewModel();

//   String formattedContractYear = '';
//   String formattedNextMaintDue = '';

//   List<Map<String, dynamic>> crewList = [];
//   String? selectedCrew;
//   bool isLoading = false;

//   String selectedCrewLoginID = '';
//   String? rights;
//   @override
//   void initState() {
//     // lCPWorkOrderPendingViewModel.fetchLCPWorkOrderPendingTabularListApi(
//     //     context, 'PENDING', '', '', '', '');
//     fetchCrewList();
//     getContractorData();
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
//             style: TextStyle(color: Colors.white),
//           ),
//           backgroundColor: const Color.fromARGB(255, 7, 59, 120),
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
//                   if (widget.heading != 'Total Order Pending (Change Order)') {
//                     print('widget.heading ${widget.heading}');
//                     _isVisibleChangeOrder = true;
//                   }
//                   print('widget.heading11111 ${widget.heading}');
//                   return RefreshIndicator(
//                     onRefresh: () async {
//                       _input.clear();
//                       await getContractorData();
//                       if (widget.heading !=
//                           'Total Order Pending (Change Order)') {
//                         print('widget.heading ${widget.heading}');
//                         _isVisibleChangeOrder = true;
//                       }
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
//                           // const Align(
//                           //     alignment: Alignment.centerLeft,
//                           //     child: Padding(
//                           //       padding: EdgeInsets.only(
//                           //           left: 2.0, right: 2.0, bottom: 2.0, top: 4.0),
//                           //       child: Text(
//                           //         "CHANGE JOB NO",
//                           //         style: TextStyle(
//                           //             fontSize: 16,
//                           //             color: Color.fromARGB(255, 7, 59, 120),
//                           //             fontWeight: FontWeight.bold),
//                           //       ),
//                           //     )),
//                           // Align(
//                           //   alignment: Alignment.centerLeft,
//                           //   child: Padding(
//                           //     padding: const EdgeInsets.all(2.0),
//                           //     child: DropdownButtonFormField<String>(
//                           //       hint: const Text('-Select-'),
//                           //       dropdownColor: Colors.white,
//                           //       value: selectedWorkOrderNo,
//                           //       style: const TextStyle(
//                           //           color: Color.fromARGB(255, 7, 59, 120),
//                           //           fontSize: 16),
//                           //       icon: const Icon(
//                           //         Icons.arrow_drop_down,
//                           //         color: Color.fromARGB(255, 7, 59, 120),
//                           //         size: 40,
//                           //       ),
//                           //       decoration: const InputDecoration(
//                           //         enabledBorder: OutlineInputBorder(
//                           //           borderSide: BorderSide(
//                           //             color: Color.fromARGB(255, 7, 59, 120),
//                           //           ),
//                           //         ),
//                           //         focusedBorder: OutlineInputBorder(
//                           //           borderSide: BorderSide(
//                           //             color: Color.fromARGB(255, 7, 59, 120),
//                           //           ),
//                           //         ),
//                           //       ),
//                           //       isExpanded: true,
//                           //       items: lCPWorkOrderPendingViewModel
//                           //           .lcpWorkOrderPendingGetTabularData
//                           //           .data!
//                           //           .tokenNoLists!
//                           //           .map((e) {
//                           //         return DropdownMenuItem(
//                           //           value: e.tokenNo.toString(),
//                           //           // e.getIdAndSubstationByCountId![0].subStation.toString(),
//                           //           child: Text(e.tokenNo.toString()),
//                           //         );
//                           //       }).toList(),
//                           //       onChanged: (val) {
//                           //         // if (selectedFeeder != null) {
//                           //         //   selectedFeeder = null;
//                           //         // }
//                           //         fetchData(val!);
//                           //         // workOrderNoId = int.parse(val);
//                           //         setState(() {
//                           //           selectedWorkOrderNo = val;
//                           //         });
//                           //       },
//                           //       validator: (value) =>
//                           //           value == null ? 'field required' : null,
//                           //     ),
//                           //   ),
//                           // ),
//                           Padding(
//                             padding: const EdgeInsets.only(top: 8.0),
//                             child: Align(
//                               alignment: Alignment.bottomLeft,
//                               child: Text(
//                                 "TOTAL NO OF RECORDS : ${lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData!.length.toString()}",
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
//                                           .createDate;
//                                   String formattedDate = '';
//                                   if (dateString != null) {
//                                     DateTime date = DateTime.parse(dateString);
//                                     formattedDate =
//                                         DateFormat('MM/dd/yyyy').format(date);
//                                   } else {
//                                     formattedDate = '';
//                                   }
//                                   newDateFormat(index);
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
//                                                   (lCPWorkOrderPendingViewModel
//                                                               .lcpWorkOrderPendingGetTabularData
//                                                               .data!
//                                                               .findAllTableData![
//                                                                   index]
//                                                               .maintType ==
//                                                           'RegularMaint')
//                                                       ? Expanded(
//                                                           child: Column(
//                                                             children: [
//                                                               const Align(
//                                                                 alignment:
//                                                                     Alignment
//                                                                         .topLeft,
//                                                                 child: Text(
//                                                                   "VIEW: ",
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
//                                                               InkWell(
//                                                                   onTap: () {
//                                                                     Navigator.push(
//                                                                         context,
//                                                                         MaterialPageRoute(
//                                                                             builder: (context) => ViewChangeOrder(
//                                                                                   orderNo: (lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].tokenNo == null || lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].tokenNo == 'N/A') ? '' : lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].tokenNo.toString(),
//                                                                                   substation: (lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].substation == null) ? '' : lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].substation.toString(),
//                                                                                   feeder: (lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].fdrName == null) ? '' : lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].fdrName.toString(),
//                                                                                   maintenanceType: (lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].maintType == null) ? '' : lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].maintType.toString(),
//                                                                                   totalMiles: (lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].totalMiles == null) ? '' : lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].totalMiles.toString(),
//                                                                                   costPerMile: (lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].costPerMile == null) ? '' : lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].costPerMile.toString(),
//                                                                                   totalCost: (lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].totalCost == null) ? '' : lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].totalCost.toString(),
//                                                                                   type: (lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].type == null) ? '' : lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].type.toString(),
//                                                                                   contractYear: (lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].contractYear == null) ? '' : lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].contractYear.toString(),
//                                                                                   cycle: (lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].cycle == null) ? '' : lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].cycle.toString(),
//                                                                                   nextMaintDue: (lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].nextMaintDue == null) ? '' : lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].nextMaintDue.toString(),
//                                                                                   contractor: (lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].contractor == null) ? '' : lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].contractor.toString(),
//                                                                                   contractorCompany: (lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].contractorCompany == null) ? '' : lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].contractorCompany.toString(),
//                                                                                   status: (lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].status == null || lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].status == 'N/A') ? '' : lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].status.toString(),
//                                                                                   dailyHerbicideApplication: (lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].dailyHerbicide == null) ? '' : lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].dailyHerbicide.toString(),
//                                                                                   ivmTimesheet: (lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].ivmTimesheet == null) ? '' : lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].ivmTimesheet.toString(),
//                                                                                   mixingInventory: (lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].mixingInventory == null) ? '' : lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].mixingInventory.toString(),
//                                                                                   serviceStreetAddress: (lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].streetAddress == null) ? '' : lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].streetAddress.toString(),
//                                                                                   serviceMapLocation: (lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].mapLocation == null) ? '' : lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].mapLocation.toString(),
//                                                                                   adminNotes1: (lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].adminNotes1 == null) ? '' : lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].adminNotes1.toString(),
//                                                                                   dateOfInspection: (lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].dateOfInspection == null) ? '' : lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].dateOfInspection.toString(),
//                                                                                   followUpDate: (lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].followUpDate == null) ? '' : lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].followUpDate.toString(),
//                                                                                   createDate: (lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].createDate == null) ? '' : lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].createDate.toString(),
//                                                                                 )));
//                                                                   },
//                                                                   child:
//                                                                       const Align(
//                                                                     alignment:
//                                                                         Alignment
//                                                                             .topLeft,
//                                                                     child: Icon(
//                                                                       Icons
//                                                                           .remove_red_eye_outlined,
//                                                                       color: Colors
//                                                                           .red,
//                                                                     ),
//                                                                   )),
//                                                             ],
//                                                           ),
//                                                         )
//                                                       : Expanded(
//                                                           child: Column(
//                                                             children: [
//                                                               const Align(
//                                                                 alignment:
//                                                                     Alignment
//                                                                         .topLeft,
//                                                                 child: Text(
//                                                                   "EDIT: ",
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
//                                                                   alignment:
//                                                                       Alignment
//                                                                           .topLeft,
//                                                                   child:
//                                                                       InkWell(
//                                                                     onTap: () {
//                                                                       print(
//                                                                           '12345678');
//                                                                       print(lCPWorkOrderPendingViewModel
//                                                                           .lcpWorkOrderPendingGetTabularData
//                                                                           .data!
//                                                                           .findAllTableData![
//                                                                               index]
//                                                                           .contractorCompany
//                                                                           .toString());
//                                                                       Navigator.of(context).push(MaterialPageRoute(
//                                                                           builder: (BuildContext context) => CreateOrderContractor(
//                                                                                 tokenNo: (lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].tokenNo == null) ? '' : lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].tokenNo.toString(),
//                                                                                 subStation: (lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].substation == null) ? '' : lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].substation.toString(),
//                                                                                 feeder: (lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].fdrName == null) ? '' : lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].fdrName.toString(),
//                                                                                 serviceStreetAddress: (lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].streetAddress == null || lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].streetAddress == 'N/A') ? '' : lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].streetAddress.toString(),
//                                                                                 serviceMapLocation: (lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].mapLocation == null || lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].mapLocation == 'N/A') ? '' : lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].mapLocation.toString(),
//                                                                                 notes: (lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].adminNotes1 == null) ? '' : lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].adminNotes1.toString(),
//                                                                                 type: (lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].type == null) ? '' : lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].type.toString(),
//                                                                                 maintType: (lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].maintType == null) ? '' : lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].maintType.toString(),
//                                                                                 contractorCompany: (lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].contractorCompany == null) ? '' : lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].contractorCompany.toString(),
//                                                                                 assignForeman: lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].contractor == null ? '' : lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].contractor.toString(),
//                                                                                 estimatedCost: (lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].estCost == null) ? '' : lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].estCost.toString(),
//                                                                                 estimatedTime: (lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].estTime == null) ? '' : lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].estTime.toString(),
//                                                                                 actualCost: (lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].actualCost == null) ? '' : lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].actualCost.toString(),
//                                                                                 crew: (lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].crew == null) ? '' : lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].crew.toString(),
//                                                                                 crewName: (lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].crewName == null) ? '' : lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].crewName.toString(),
//                                                                               )));
//                                                                     },
//                                                                     child:
//                                                                         const Icon(
//                                                                       Icons
//                                                                           .edit,
//                                                                       color: Color.fromARGB(
//                                                                           255,
//                                                                           151,
//                                                                           249,
//                                                                           154),
//                                                                     ),
//                                                                   )),
//                                                             ],
//                                                           ),
//                                                         ),
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

//                                                         // (lCPWorkOrderPendingViewModel
//                                                         //             .lcpWorkOrderPendingGetTabularData
//                                                         //             .data!
//                                                         //             .findAllTableData![
//                                                         //                 index]
//                                                         //             .maintType ==
//                                                         //         'RegularMaint')
//                                                         //     ? Align(
//                                                         //         alignment:
//                                                         //             Alignment
//                                                         //                 .topLeft,
//                                                         //         child: Text(
//                                                         //           (lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].status ==
//                                                         //                       null ||
//                                                         //                   lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].status.toString() ==
//                                                         //                       'null')
//                                                         //               ? ''
//                                                         //               : lCPWorkOrderPendingViewModel
//                                                         //                   .lcpWorkOrderPendingGetTabularData
//                                                         //                   .data!
//                                                         //                   .findAllTableData![
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
//                                                         //           openDailogPendingApproval(lCPWorkOrderPendingViewModel
//                                                         //               .lcpWorkOrderPendingGetTabularData
//                                                         //               .data!
//                                                         //               .findAllTableData![
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
//                                                         //                 gradient: (lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].status == 'REJECTED')
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
//                                                         //                 (lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].status == null ||
//                                                         //                         lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].status.toString() == 'null')
//                                                         //                     ? ''
//                                                         //                     : lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].status.toString(),
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
//                                                         //       )
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
//                                                   //           "DAILY HERBICIDE APPLICATION: ",
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
//                                                   //                   .dailyHerbicide
//                                                   //                   .toString() ==
//                                                   //               'true')
//                                                   //           ? Align(
//                                                   //               alignment:
//                                                   //                   Alignment
//                                                   //                       .topLeft,
//                                                   //               child: InkWell(
//                                                   //                 onTap: () {
//                                                   //                   print(
//                                                   //                       'id00000000000000000000');
//                                                   //                   print(lCPWorkOrderPendingViewModel
//                                                   //                       .lcpWorkOrderPendingGetTabularData
//                                                   //                       .data!
//                                                   //                       .findAllTableData![
//                                                   //                           index]
//                                                   //                       .id
//                                                   //                       .toString());
//                                                   //                   Navigator.of(context).push(MaterialPageRoute(
//                                                   //                       builder: (BuildContext context) => DailyHerbicideApplicationContractor(
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
//                                             // const Divider(
//                                             //   color: Colors.grey,
//                                             // ),
//                                             // Padding(
//                                             //   padding: const EdgeInsets.only(
//                                             //       left: 8.0),
//                                             //   child: Row(
//                                             //     children: [    Expanded(
//                                             //         // alignment: Alignment.topLeft,
//                                             //         child: Column(
//                                             //           children: [
//                                             //             const Align(
//                                             //               alignment:
//                                             //                   Alignment.topLeft,
//                                             //               child: Text(
//                                             //                 "DAILY HERBICIDE APPLICATION: ",
//                                             //                 textAlign:
//                                             //                     TextAlign.left,
//                                             //                 style: TextStyle(
//                                             //                   fontSize: 12,
//                                             //                   fontWeight:
//                                             //                       FontWeight.bold,
//                                             //                   color: Colors.white,
//                                             //                 ),
//                                             //               ),
//                                             //             ),
//                                             //             (lCPWorkOrderPendingViewModel
//                                             //                         .lcpWorkOrderPendingGetTabularData
//                                             //                         .data!
//                                             //                         .findAllTableData![
//                                             //                             index]
//                                             //                         .dailyHerbicide
//                                             //                         .toString() ==
//                                             //                     'APPROVED')
//                                             //                 ? Align(
//                                             //                     alignment:
//                                             //                         Alignment
//                                             //                             .topLeft,
//                                             //                     child: InkWell(
//                                             //                       onTap: () {
//                                             //                         Navigator.of(context).push(MaterialPageRoute(
//                                             //                             builder: (BuildContext context) => DailyHerbicideWithOutEditOptionApplicationContractor(
//                                             //                                 id: lCPWorkOrderPendingViewModel
//                                             //                                     .lcpWorkOrderPendingGetTabularData
//                                             //                                     .data!
//                                             //                                     .findAllTableData![index]
//                                             //                                     .id
//                                             //                                     .toString())));
//                                             //                       },
//                                             //                       child:
//                                             //                           Container(
//                                             //                         padding:
//                                             //                             const EdgeInsets
//                                             //                                 .all(
//                                             //                                 2),
//                                             //                         alignment:
//                                             //                             Alignment
//                                             //                                 .center,
//                                             //                         width:
//                                             //                             size.width *
//                                             //                                 0.1,
//                                             //                         height: 30,
//                                             //                         decoration:
//                                             //                             BoxDecoration(
//                                             //                                 // shape: BoxShape.circle,
//                                             //                                 borderRadius: BorderRadius.circular(
//                                             //                                     10),
//                                             //                                 color: const Color
//                                             //                                     .fromARGB(
//                                             //                                     255,
//                                             //                                     130,
//                                             //                                     193,
//                                             //                                     245),
//                                             //                                 gradient:
//                                             //                                     const LinearGradient(
//                                             //                                   colors: [
//                                             //                                     Colors.green,
//                                             //                                     Colors.green,
//                                             //                                   ],
//                                             //                                 )),
//                                             //                         child: const Align(
//                                             //                             alignment: Alignment.center,
//                                             //                             child: Icon(
//                                             //                               Icons
//                                             //                                   .remove_red_eye,
//                                             //                               color: Colors
//                                             //                                   .white,
//                                             //                             )),
//                                             //                       ),
//                                             //                     ),
//                                             //                   )
//                                             //                 : (lCPWorkOrderPendingViewModel
//                                             //                             .lcpWorkOrderPendingGetTabularData
//                                             //                             .data!
//                                             //                             .findAllTableData![
//                                             //                                 index]
//                                             //                             .dailyHerbicide
//                                             //                             .toString() ==
//                                             //                         'PENDING')
//                                             //                     ? Align(
//                                             //                         alignment:
//                                             //                             Alignment
//                                             //                                 .topLeft,
//                                             //                         child:
//                                             //                             InkWell(
//                                             //                           onTap: () {
//                                             //                             Navigator.of(
//                                             //                                     context)
//                                             //                                 .push(
//                                             //                                     MaterialPageRoute(builder: (BuildContext context) => DailyHerbicideWithOutEditOptionApplicationContractor(id: lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].id.toString())));
//                                             //                           },
//                                             //                           child:
//                                             //                               Container(
//                                             //                             padding:
//                                             //                                 const EdgeInsets
//                                             //                                     .all(
//                                             //                                     2),
//                                             //                             alignment:
//                                             //                                 Alignment
//                                             //                                     .center,
//                                             //                             width: size
//                                             //                                     .width *
//                                             //                                 0.1,
//                                             //                             height:
//                                             //                                 30,
//                                             //                             decoration: BoxDecoration(
//                                             //                                 // shape: BoxShape.circle,
//                                             //                                 borderRadius: BorderRadius.circular(10),
//                                             //                                 color: const Color.fromARGB(255, 130, 193, 245),
//                                             //                                 gradient: const LinearGradient(
//                                             //                                   colors: [
//                                             //                                     Colors.orange,
//                                             //                                     Colors.orange,
//                                             //                                   ],
//                                             //                                 )),
//                                             //                             child: const Align(
//                                             //                                 alignment: Alignment.center,
//                                             //                                 child: Icon(
//                                             //                                   Icons.remove_red_eye,
//                                             //                                   color:
//                                             //                                       Colors.white,
//                                             //                                 )),
//                                             //                           ),
//                                             //                         ),
//                                             //                       )
//                                             //                     : (lCPWorkOrderPendingViewModel
//                                             //                                 .lcpWorkOrderPendingGetTabularData
//                                             //                                 .data!
//                                             //                                 .findAllTableData![
//                                             //                                     index]
//                                             //                                 .dailyHerbicide
//                                             //                                 .toString() ==
//                                             //                             'REJECTED')
//                                             //                         ? Align(
//                                             //                             alignment:
//                                             //                                 Alignment
//                                             //                                     .topLeft,
//                                             //                             child:
//                                             //                                 InkWell(
//                                             //                               onTap:
//                                             //                                   () {
//                                             //                                 Navigator.of(context)
//                                             //                                     .push(MaterialPageRoute(builder: (BuildContext context) => DailyHerbicideWithOutEditOptionApplicationContractor(id: lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].id.toString())));
//                                             //                               },
//                                             //                               child:
//                                             //                                   Container(
//                                             //                                 padding: const EdgeInsets
//                                             //                                     .all(
//                                             //                                     2),
//                                             //                                 alignment:
//                                             //                                     Alignment.center,
//                                             //                                 width:
//                                             //                                     size.width * 0.1,
//                                             //                                 height:
//                                             //                                     30,
//                                             //                                 decoration: BoxDecoration(
//                                             //                                     // shape: BoxShape.circle,
//                                             //                                     borderRadius: BorderRadius.circular(10),
//                                             //                                     color: const Color.fromARGB(255, 130, 193, 245),
//                                             //                                     gradient: const LinearGradient(
//                                             //                                       colors: [
//                                             //                                         Colors.red,
//                                             //                                         Colors.red,
//                                             //                                       ],
//                                             //                                     )),
//                                             //                                 child: const Align(
//                                             //                                     alignment: Alignment.center,
//                                             //                                     child: Icon(
//                                             //                                       Icons.remove_red_eye,
//                                             //                                       color: Colors.white,
//                                             //                                     )),
//                                             //                               ),
//                                             //                             ),
//                                             //                           )
//                                             //                         : const Text(
//                                             //                             "",
//                                             //                             textAlign:
//                                             //                                 TextAlign
//                                             //                                     .left,
//                                             //                             style:
//                                             //                                 TextStyle(
//                                             //                               fontSize:
//                                             //                                   12,
//                                             //                               //  fontWeight:
//                                             //                               //      FontWeight.bold,
//                                             //                               color: Colors
//                                             //                                   .white,
//                                             //                             ),
//                                             //                           )
//                                             //           ],
//                                             //         ),
//                                             //       ),

//                                             //       // Expanded(
//                                             //       //   // alignment: Alignment.topLeft,
//                                             //       //   child: Column(
//                                             //       //     children: [
//                                             //       //       const Align(
//                                             //       //         alignment:
//                                             //       //             Alignment.topLeft,
//                                             //       //         child: Text(
//                                             //       //           "IVM TIMESHEET: ",
//                                             //       //           textAlign:
//                                             //       //               TextAlign.left,
//                                             //       //           style: TextStyle(
//                                             //       //             fontSize: 12,
//                                             //       //             fontWeight:
//                                             //       //                 FontWeight.bold,
//                                             //       //             color: Colors.white,
//                                             //       //           ),
//                                             //       //         ),
//                                             //       //       ),
//                                             //       //       (lCPWorkOrderPendingViewModel
//                                             //       //                   .lcpWorkOrderPendingGetTabularData
//                                             //       //                   .data!
//                                             //       //                   .findAllTableData![
//                                             //       //                       index]
//                                             //       //                   .ivmTimesheet
//                                             //       //                   .toString() ==
//                                             //       //               'true')
//                                             //       //           ? Align(
//                                             //       //               alignment:
//                                             //       //                   Alignment
//                                             //       //                       .topLeft,
//                                             //       //               child: InkWell(
//                                             //       //                 onTap: () {
//                                             //       //                   Navigator.of(context).push(MaterialPageRoute(
//                                             //       //                       builder: (BuildContext context) => IVMTimeSheetContractor(
//                                             //       //                           id: lCPWorkOrderPendingViewModel
//                                             //       //                               .lcpWorkOrderPendingGetTabularData
//                                             //       //                               .data!
//                                             //       //                               .findAllTableData![index]
//                                             //       //                               .id
//                                             //       //                               .toString())));
//                                             //       //                 },
//                                             //       //                 child:
//                                             //       //                     Container(
//                                             //       //                   padding:
//                                             //       //                       const EdgeInsets
//                                             //       //                           .all(
//                                             //       //                           2),
//                                             //       //                   alignment:
//                                             //       //                       Alignment
//                                             //       //                           .center,
//                                             //       //                   width:
//                                             //       //                       size.width *
//                                             //       //                           0.1,
//                                             //       //                   height: 30,
//                                             //       //                   decoration:
//                                             //       //                       BoxDecoration(
//                                             //       //                           // shape: BoxShape.circle,
//                                             //       //                           borderRadius: BorderRadius.circular(
//                                             //       //                               10),
//                                             //       //                           color: const Color
//                                             //       //                               .fromARGB(
//                                             //       //                               255,
//                                             //       //                               130,
//                                             //       //                               193,
//                                             //       //                               245),
//                                             //       //                           gradient:
//                                             //       //                               const LinearGradient(
//                                             //       //                             colors: [
//                                             //       //                               Colors.orange,
//                                             //       //                               Colors.orange,
//                                             //       //                             ],
//                                             //       //                           )),
//                                             //       //                   child: const Align(
//                                             //       //                       alignment: Alignment.center,
//                                             //       //                       child: Icon(
//                                             //       //                         Icons
//                                             //       //                             .remove_red_eye,
//                                             //       //                         color: Colors
//                                             //       //                             .white,
//                                             //       //                       )),
//                                             //       //                 ),
//                                             //       //               ),
//                                             //       //             )
//                                             //       //           : const Text(
//                                             //       //               "",
//                                             //       //               textAlign:
//                                             //       //                   TextAlign
//                                             //       //                       .left,
//                                             //       //               style: TextStyle(
//                                             //       //                 fontSize: 12,
//                                             //       //                 //  fontWeight:
//                                             //       //                 //      FontWeight.bold,
//                                             //       //                 color: Colors
//                                             //       //                     .white,
//                                             //       //               ),
//                                             //       //             )
//                                             //       //     ],
//                                             //       //   ),
//                                             //       // ),

//                                             //       Expanded(
//                                             //         // alignment: Alignment.topLeft,
//                                             //         child: Column(
//                                             //           children: [
//                                             //             const Align(
//                                             //               alignment:
//                                             //                   Alignment.topLeft,
//                                             //               child: Text(
//                                             //                 "IVM TIMESHEET: ",
//                                             //                 textAlign:
//                                             //                     TextAlign.left,
//                                             //                 style: TextStyle(
//                                             //                   fontSize: 12,
//                                             //                   fontWeight:
//                                             //                       FontWeight.bold,
//                                             //                   color: Colors.white,
//                                             //                 ),
//                                             //               ),
//                                             //             ),
//                                             //             (lCPWorkOrderPendingViewModel
//                                             //                         .lcpWorkOrderPendingGetTabularData
//                                             //                         .data!
//                                             //                         .findAllTableData![
//                                             //                             index]
//                                             //                         .ivmTimesheet
//                                             //                         .toString() ==
//                                             //                     'APPROVED')
//                                             //                 ? Align(
//                                             //                     alignment:
//                                             //                         Alignment
//                                             //                             .topLeft,
//                                             //                     child: InkWell(
//                                             //                       onTap: () {
//                                             //                         Navigator.of(context).push(MaterialPageRoute(
//                                             //                             builder: (BuildContext context) => IVMTimeSheetWithOutEditOptionContractor(
//                                             //                                 id: lCPWorkOrderPendingViewModel
//                                             //                                     .lcpWorkOrderPendingGetTabularData
//                                             //                                     .data!
//                                             //                                     .findAllTableData![index]
//                                             //                                     .id
//                                             //                                     .toString())));
//                                             //                       },
//                                             //                       child:
//                                             //                           Container(
//                                             //                         padding:
//                                             //                             const EdgeInsets
//                                             //                                 .all(
//                                             //                                 2),
//                                             //                         alignment:
//                                             //                             Alignment
//                                             //                                 .center,
//                                             //                         width:
//                                             //                             size.width *
//                                             //                                 0.1,
//                                             //                         height: 30,
//                                             //                         decoration:
//                                             //                             BoxDecoration(
//                                             //                                 // shape: BoxShape.circle,
//                                             //                                 borderRadius: BorderRadius.circular(
//                                             //                                     10),
//                                             //                                 color: const Color
//                                             //                                     .fromARGB(
//                                             //                                     255,
//                                             //                                     130,
//                                             //                                     193,
//                                             //                                     245),
//                                             //                                 gradient:
//                                             //                                     const LinearGradient(
//                                             //                                   colors: [
//                                             //                                     Colors.green,
//                                             //                                     Colors.green,
//                                             //                                   ],
//                                             //                                 )),
//                                             //                         child: const Align(
//                                             //                             alignment: Alignment.center,
//                                             //                             child: Icon(
//                                             //                               Icons
//                                             //                                   .remove_red_eye,
//                                             //                               color: Colors
//                                             //                                   .white,
//                                             //                             )),
//                                             //                       ),
//                                             //                     ),
//                                             //                   )
//                                             //                 : (lCPWorkOrderPendingViewModel
//                                             //                             .lcpWorkOrderPendingGetTabularData
//                                             //                             .data!
//                                             //                             .findAllTableData![
//                                             //                                 index]
//                                             //                             .ivmTimesheet
//                                             //                             .toString() ==
//                                             //                         'PENDING')
//                                             //                     ? Align(
//                                             //                         alignment:
//                                             //                             Alignment
//                                             //                                 .topLeft,
//                                             //                         child:
//                                             //                             InkWell(
//                                             //                           onTap: () {
//                                             //                             Navigator.of(
//                                             //                                     context)
//                                             //                                 .push(
//                                             //                                     MaterialPageRoute(builder: (BuildContext context) => IVMTimeSheetWithOutEditOptionContractor(id: lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].id.toString())));
//                                             //                           },
//                                             //                           child:
//                                             //                               Container(
//                                             //                             padding:
//                                             //                                 const EdgeInsets
//                                             //                                     .all(
//                                             //                                     2),
//                                             //                             alignment:
//                                             //                                 Alignment
//                                             //                                     .center,
//                                             //                             width: size
//                                             //                                     .width *
//                                             //                                 0.1,
//                                             //                             height:
//                                             //                                 30,
//                                             //                             decoration: BoxDecoration(
//                                             //                                 // shape: BoxShape.circle,
//                                             //                                 borderRadius: BorderRadius.circular(10),
//                                             //                                 color: const Color.fromARGB(255, 130, 193, 245),
//                                             //                                 gradient: const LinearGradient(
//                                             //                                   colors: [
//                                             //                                     Colors.orange,
//                                             //                                     Colors.orange,
//                                             //                                   ],
//                                             //                                 )),
//                                             //                             child: const Align(
//                                             //                                 alignment: Alignment.center,
//                                             //                                 child: Icon(
//                                             //                                   Icons.remove_red_eye,
//                                             //                                   color:
//                                             //                                       Colors.white,
//                                             //                                 )),
//                                             //                           ),
//                                             //                         ),
//                                             //                       )
//                                             //                     : (lCPWorkOrderPendingViewModel
//                                             //                                 .lcpWorkOrderPendingGetTabularData
//                                             //                                 .data!
//                                             //                                 .findAllTableData![
//                                             //                                     index]
//                                             //                                 .ivmTimesheet
//                                             //                                 .toString() ==
//                                             //                             'REJECTED')
//                                             //                         ? Align(
//                                             //                             alignment:
//                                             //                                 Alignment
//                                             //                                     .topLeft,
//                                             //                             child:
//                                             //                                 InkWell(
//                                             //                               onTap:
//                                             //                                   () {
//                                             //                                 Navigator.of(context)
//                                             //                                     .push(MaterialPageRoute(builder: (BuildContext context) => IVMTimeSheetWithOutEditOptionContractor(id: lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].id.toString())));
//                                             //                               },
//                                             //                               child:
//                                             //                                   Container(
//                                             //                                 padding: const EdgeInsets
//                                             //                                     .all(
//                                             //                                     2),
//                                             //                                 alignment:
//                                             //                                     Alignment.center,
//                                             //                                 width:
//                                             //                                     size.width * 0.1,
//                                             //                                 height:
//                                             //                                     30,
//                                             //                                 decoration: BoxDecoration(
//                                             //                                     // shape: BoxShape.circle,
//                                             //                                     borderRadius: BorderRadius.circular(10),
//                                             //                                     color: const Color.fromARGB(255, 130, 193, 245),
//                                             //                                     gradient: const LinearGradient(
//                                             //                                       colors: [
//                                             //                                         Colors.red,
//                                             //                                         Colors.red,
//                                             //                                       ],
//                                             //                                     )),
//                                             //                                 child: const Align(
//                                             //                                     alignment: Alignment.center,
//                                             //                                     child: Icon(
//                                             //                                       Icons.remove_red_eye,
//                                             //                                       color: Colors.white,
//                                             //                                     )),
//                                             //                               ),
//                                             //                             ),
//                                             //                           )
//                                             //                         : (lCPWorkOrderPendingViewModel
//                                             //                                     .lcpWorkOrderPendingGetTabularData
//                                             //                                     .data!
//                                             //                                     .findAllTableData![index]
//                                             //                                     .maintType ==
//                                             //                                 'RegularMaint')
//                                             //                             ? const Text(
//                                             //                                 "",
//                                             //                                 textAlign:
//                                             //                                     TextAlign.left,
//                                             //                                 style:
//                                             //                                     TextStyle(
//                                             //                                   fontSize:
//                                             //                                       0,
//                                             //                                   fontWeight:
//                                             //                                       FontWeight.bold,
//                                             //                                   color: Color.fromARGB(
//                                             //                                       255,
//                                             //                                       7,
//                                             //                                       59,
//                                             //                                       120),
//                                             //                                 ),
//                                             //                               )
//                                             //                             : const Text(
//                                             //                                 "",
//                                             //                                 textAlign:
//                                             //                                     TextAlign.left,
//                                             //                                 style:
//                                             //                                     TextStyle(
//                                             //                                   fontSize:
//                                             //                                       12,
//                                             //                                   //  fontWeight:
//                                             //                                   //      FontWeight.bold,
//                                             //                                   color:
//                                             //                                       Colors.white,
//                                             //                                 ),
//                                             //                               )
//                                             //           ],
//                                             //         ),
//                                             //       ),

//                                             //       // Expanded(
//                                             //       //   // alignment: Alignment.topLeft,
//                                             //       //   child: Column(
//                                             //       //     children: [
//                                             //       //       const Align(
//                                             //       //         alignment:
//                                             //       //             Alignment.topLeft,
//                                             //       //         child: Text(
//                                             //       //           "MIXING INVENTORY: ",
//                                             //       //           textAlign:
//                                             //       //               TextAlign.left,
//                                             //       //           style: TextStyle(
//                                             //       //             fontSize: 12,
//                                             //       //             fontWeight:
//                                             //       //                 FontWeight.bold,
//                                             //       //             color: Colors.white,
//                                             //       //           ),
//                                             //       //         ),
//                                             //       //       ),
//                                             //       //       (lCPWorkOrderPendingViewModel
//                                             //       //                   .lcpWorkOrderPendingGetTabularData
//                                             //       //                   .data!
//                                             //       //                   .findAllTableData![
//                                             //       //                       index]
//                                             //       //                   .mixingInventory
//                                             //       //                   .toString() ==
//                                             //       //               'true')
//                                             //       //           ? Align(
//                                             //       //               alignment:
//                                             //       //                   Alignment
//                                             //       //                       .topLeft,
//                                             //       //               child: InkWell(
//                                             //       //                 onTap: () {
//                                             //       //                   Navigator.of(context).push(MaterialPageRoute(
//                                             //       //                       builder: (BuildContext context) => MixingInventoryContractor(
//                                             //       //                           id: lCPWorkOrderPendingViewModel
//                                             //       //                               .lcpWorkOrderPendingGetTabularData
//                                             //       //                               .data!
//                                             //       //                               .findAllTableData![index]
//                                             //       //                               .id
//                                             //       //                               .toString())));
//                                             //       //                 },
//                                             //       //                 child:
//                                             //       //                     Container(
//                                             //       //                   padding:
//                                             //       //                       const EdgeInsets
//                                             //       //                           .all(
//                                             //       //                           2),
//                                             //       //                   alignment:
//                                             //       //                       Alignment
//                                             //       //                           .center,
//                                             //       //                   width:
//                                             //       //                       size.width *
//                                             //       //                           0.1,
//                                             //       //                   height: 30,
//                                             //       //                   decoration:
//                                             //       //                       BoxDecoration(
//                                             //       //                           // shape: BoxShape.circle,
//                                             //       //                           borderRadius: BorderRadius.circular(
//                                             //       //                               10),
//                                             //       //                           color: const Color
//                                             //       //                               .fromARGB(
//                                             //       //                               255,
//                                             //       //                               130,
//                                             //       //                               193,
//                                             //       //                               245),
//                                             //       //                           gradient:
//                                             //       //                               const LinearGradient(
//                                             //       //                             colors: [
//                                             //       //                               Colors.orange,
//                                             //       //                               Colors.orange,
//                                             //       //                             ],
//                                             //       //                           )),
//                                             //       //                   child: const Align(
//                                             //       //                       alignment: Alignment.center,
//                                             //       //                       child: Icon(
//                                             //       //                         Icons
//                                             //       //                             .remove_red_eye,
//                                             //       //                         color: Colors
//                                             //       //                             .white,
//                                             //       //                       )),
//                                             //       //                 ),
//                                             //       //               ),
//                                             //       //             )
//                                             //       //           : const Text(
//                                             //       //               "",
//                                             //       //               textAlign:
//                                             //       //                   TextAlign
//                                             //       //                       .left,
//                                             //       //               style: TextStyle(
//                                             //       //                 fontSize: 12,
//                                             //       //                 //  fontWeight:
//                                             //       //                 //      FontWeight.bold,
//                                             //       //                 color: Colors
//                                             //       //                     .white,
//                                             //       //               ),
//                                             //       //             )
//                                             //       //     ],
//                                             //       //   ),
//                                             //       // ),

//                                             //       Expanded(
//                                             //         // alignment: Alignment.topLeft,
//                                             //         child: Column(
//                                             //           children: [
//                                             //             const Align(
//                                             //               alignment:
//                                             //                   Alignment.topLeft,
//                                             //               child: Text(
//                                             //                 "MIXING INVENTORY: ",
//                                             //                 textAlign:
//                                             //                     TextAlign.left,
//                                             //                 style: TextStyle(
//                                             //                   fontSize: 12,
//                                             //                   fontWeight:
//                                             //                       FontWeight.bold,
//                                             //                   color: Colors.white,
//                                             //                 ),
//                                             //               ),
//                                             //             ),
//                                             //             (lCPWorkOrderPendingViewModel
//                                             //                         .lcpWorkOrderPendingGetTabularData
//                                             //                         .data!
//                                             //                         .findAllTableData![
//                                             //                             index]
//                                             //                         .mixingInventory
//                                             //                         .toString() ==
//                                             //                     'APPROVED')
//                                             //                 ? Align(
//                                             //                     alignment:
//                                             //                         Alignment
//                                             //                             .topLeft,
//                                             //                     child: InkWell(
//                                             //                       onTap: () {
//                                             //                         Navigator.of(context).push(MaterialPageRoute(
//                                             //                             builder: (BuildContext context) => MixingInventoryWithoutEditOptionContractor(
//                                             //                                 id: lCPWorkOrderPendingViewModel
//                                             //                                     .lcpWorkOrderPendingGetTabularData
//                                             //                                     .data!
//                                             //                                     .findAllTableData![index]
//                                             //                                     .id
//                                             //                                     .toString())));
//                                             //                       },
//                                             //                       child:
//                                             //                           Container(
//                                             //                         padding:
//                                             //                             const EdgeInsets
//                                             //                                 .all(
//                                             //                                 2),
//                                             //                         alignment:
//                                             //                             Alignment
//                                             //                                 .center,
//                                             //                         width:
//                                             //                             size.width *
//                                             //                                 0.1,
//                                             //                         height: 30,
//                                             //                         decoration:
//                                             //                             BoxDecoration(
//                                             //                                 // shape: BoxShape.circle,
//                                             //                                 borderRadius: BorderRadius.circular(
//                                             //                                     10),
//                                             //                                 color: const Color
//                                             //                                     .fromARGB(
//                                             //                                     255,
//                                             //                                     130,
//                                             //                                     193,
//                                             //                                     245),
//                                             //                                 gradient:
//                                             //                                     const LinearGradient(
//                                             //                                   colors: [
//                                             //                                     Colors.green,
//                                             //                                     Colors.green,
//                                             //                                   ],
//                                             //                                 )),
//                                             //                         child: const Align(
//                                             //                             alignment: Alignment.center,
//                                             //                             child: Icon(
//                                             //                               Icons
//                                             //                                   .remove_red_eye,
//                                             //                               color: Colors
//                                             //                                   .white,
//                                             //                             )),
//                                             //                       ),
//                                             //                     ),
//                                             //                   )
//                                             //                 : (lCPWorkOrderPendingViewModel
//                                             //                             .lcpWorkOrderPendingGetTabularData
//                                             //                             .data!
//                                             //                             .findAllTableData![
//                                             //                                 index]
//                                             //                             .mixingInventory
//                                             //                             .toString() ==
//                                             //                         'PENDING')
//                                             //                     ? Align(
//                                             //                         alignment:
//                                             //                             Alignment
//                                             //                                 .topLeft,
//                                             //                         child:
//                                             //                             InkWell(
//                                             //                           onTap: () {
//                                             //                             Navigator.of(
//                                             //                                     context)
//                                             //                                 .push(
//                                             //                                     MaterialPageRoute(builder: (BuildContext context) => MixingInventoryWithoutEditOptionContractor(id: lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].id.toString())));
//                                             //                           },
//                                             //                           child:
//                                             //                               Container(
//                                             //                             padding:
//                                             //                                 const EdgeInsets
//                                             //                                     .all(
//                                             //                                     2),
//                                             //                             alignment:
//                                             //                                 Alignment
//                                             //                                     .center,
//                                             //                             width: size
//                                             //                                     .width *
//                                             //                                 0.1,
//                                             //                             height:
//                                             //                                 30,
//                                             //                             decoration: BoxDecoration(
//                                             //                                 // shape: BoxShape.circle,
//                                             //                                 borderRadius: BorderRadius.circular(10),
//                                             //                                 color: const Color.fromARGB(255, 130, 193, 245),
//                                             //                                 gradient: const LinearGradient(
//                                             //                                   colors: [
//                                             //                                     Colors.orange,
//                                             //                                     Colors.orange,
//                                             //                                   ],
//                                             //                                 )),
//                                             //                             child: const Align(
//                                             //                                 alignment: Alignment.center,
//                                             //                                 child: Icon(
//                                             //                                   Icons.remove_red_eye,
//                                             //                                   color:
//                                             //                                       Colors.white,
//                                             //                                 )),
//                                             //                           ),
//                                             //                         ),
//                                             //                       )
//                                             //                     : (lCPWorkOrderPendingViewModel
//                                             //                                 .lcpWorkOrderPendingGetTabularData
//                                             //                                 .data!
//                                             //                                 .findAllTableData![
//                                             //                                     index]
//                                             //                                 .mixingInventory
//                                             //                                 .toString() ==
//                                             //                             'REJECTED')
//                                             //                         ? Align(
//                                             //                             alignment:
//                                             //                                 Alignment
//                                             //                                     .topLeft,
//                                             //                             child:
//                                             //                                 InkWell(
//                                             //                               onTap:
//                                             //                                   () {
//                                             //                                 Navigator.of(context)
//                                             //                                     .push(MaterialPageRoute(builder: (BuildContext context) => MixingInventoryWithoutEditOptionContractor(id: lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].id.toString())));
//                                             //                               },
//                                             //                               child:
//                                             //                                   Container(
//                                             //                                 padding: const EdgeInsets
//                                             //                                     .all(
//                                             //                                     2),
//                                             //                                 alignment:
//                                             //                                     Alignment.center,
//                                             //                                 width:
//                                             //                                     size.width * 0.1,
//                                             //                                 height:
//                                             //                                     30,
//                                             //                                 decoration: BoxDecoration(
//                                             //                                     // shape: BoxShape.circle,
//                                             //                                     borderRadius: BorderRadius.circular(10),
//                                             //                                     color: const Color.fromARGB(255, 130, 193, 245),
//                                             //                                     gradient: const LinearGradient(
//                                             //                                       colors: [
//                                             //                                         Colors.red,
//                                             //                                         Colors.red,
//                                             //                                       ],
//                                             //                                     )),
//                                             //                                 child: const Align(
//                                             //                                     alignment: Alignment.center,
//                                             //                                     child: Icon(
//                                             //                                       Icons.remove_red_eye,
//                                             //                                       color: Colors.white,
//                                             //                                     )),
//                                             //                               ),
//                                             //                             ),
//                                             //                           )
//                                             //                         : (lCPWorkOrderPendingViewModel
//                                             //                                     .lcpWorkOrderPendingGetTabularData
//                                             //                                     .data!
//                                             //                                     .findAllTableData![index]
//                                             //                                     .maintType ==
//                                             //                                 'RegularMaint')
//                                             //                             ? const Text(
//                                             //                                 "",
//                                             //                                 textAlign:
//                                             //                                     TextAlign.left,
//                                             //                                 style:
//                                             //                                     TextStyle(
//                                             //                                   fontSize:
//                                             //                                       0,
//                                             //                                   fontWeight:
//                                             //                                       FontWeight.bold,
//                                             //                                   color: Color.fromARGB(
//                                             //                                       255,
//                                             //                                       7,
//                                             //                                       59,
//                                             //                                       120),
//                                             //                                 ),
//                                             //                               )
//                                             //                             : const Text(
//                                             //                                 "",
//                                             //                                 textAlign:
//                                             //                                     TextAlign.left,
//                                             //                                 style:
//                                             //                                     TextStyle(
//                                             //                                   fontSize:
//                                             //                                       12,
//                                             //                                   //  fontWeight:
//                                             //                                   //      FontWeight.bold,
//                                             //                                   color:
//                                             //                                       Colors.white,
//                                             //                                 ),
//                                             //                               )
//                                             //           ],
//                                             //         ),
//                                             //       ),

//                                             //      ],
//                                             //   ),
//                                             // ),

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
//                                                   (widget.heading !=
//                                                           'Total Order Pending (Change Order)')
//                                                       ? Expanded(
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
//                                                                   (lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].type ==
//                                                                               null ||
//                                                                           lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].type.toString() ==
//                                                                               'null')
//                                                                       ? ''
//                                                                       : lCPWorkOrderPendingViewModel
//                                                                           .lcpWorkOrderPendingGetTabularData
//                                                                           .data!
//                                                                           .findAllTableData![
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
//                                                       : Text(''),
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
//                                                   (widget.heading !=
//                                                           'Total Order Pending (Change Order)')
//                                                       ? Expanded(
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
//                                                                   (lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].contractYear ==
//                                                                               null ||
//                                                                           lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].contractYear.toString() ==
//                                                                               'null')
//                                                                       ? ''
//                                                                       : formattedContractYear,
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
//                                                         )
//                                                       : Text(''),
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
//                                                   (widget.heading !=
//                                                           'Total Order Pending (Change Order)')
//                                                       ? Expanded(
//                                                           // alignment: Alignment.topLeft,
//                                                           child: Column(
//                                                           children: [
//                                                             const Align(
//                                                               alignment:
//                                                                   Alignment
//                                                                       .topLeft,
//                                                               child: Text(
//                                                                 "TOTAL MILES: ",
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
//                                                                 (lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].totalMiles ==
//                                                                             null ||
//                                                                         lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].totalMiles.toString() ==
//                                                                             'null')
//                                                                     ? ''
//                                                                     : lCPWorkOrderPendingViewModel
//                                                                         .lcpWorkOrderPendingGetTabularData
//                                                                         .data!
//                                                                         .findAllTableData![
//                                                                             index]
//                                                                         .totalMiles
//                                                                         .toString(),
//                                                                 textAlign:
//                                                                     TextAlign
//                                                                         .left,
//                                                                 style:
//                                                                     const TextStyle(
//                                                                   fontSize: 12,
//                                                                   color: Colors
//                                                                       .white,
//                                                                 ),
//                                                               ),
//                                                             ),
//                                                           ],
//                                                         ))
//                                                       : Text('')
//                                                 ],
//                                               ),
//                                             ),
//                                             (widget.heading ==
//                                                     'Total Order Pending (Change Order)')
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
//                                                                       (lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].streetAddress == null ||
//                                                                               lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].streetAddress.toString() ==
//                                                                                   'null')
//                                                                           ? ''
//                                                                           : lCPWorkOrderPendingViewModel
//                                                                               .lcpWorkOrderPendingGetTabularData
//                                                                               .data!
//                                                                               .findAllTableData![index]
//                                                                               .streetAddress
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
//                                                                       (lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].mapLocation == null ||
//                                                                               lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].mapLocation.toString() ==
//                                                                                   'null')
//                                                                           ? ''
//                                                                           : lCPWorkOrderPendingViewModel
//                                                                               .lcpWorkOrderPendingGetTabularData
//                                                                               .data!
//                                                                               .findAllTableData![index]
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
//                                                                       (lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].adminNotes1 == null ||
//                                                                               lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].adminNotes1.toString() ==
//                                                                                   'null')
//                                                                           ? ''
//                                                                           : lCPWorkOrderPendingViewModel
//                                                                               .lcpWorkOrderPendingGetTabularData
//                                                                               .data!
//                                                                               .findAllTableData![index]
//                                                                               .adminNotes1
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
//                                                                       (lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].dateOfInspection == null ||
//                                                                               lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].dateOfInspection.toString() ==
//                                                                                   'null')
//                                                                           ? ''
//                                                                           : formatDateIfNeeded(lCPWorkOrderPendingViewModel
//                                                                               .lcpWorkOrderPendingGetTabularData
//                                                                               .data!
//                                                                               .findAllTableData![index]
//                                                                               .dateOfInspection
//                                                                               .toString()),
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
//                                                                       (lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].followUpDate == null ||
//                                                                               lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].followUpDate.toString() ==
//                                                                                   'null')
//                                                                           ? ''
//                                                                           : formatDateIfNeeded(lCPWorkOrderPendingViewModel
//                                                                               .lcpWorkOrderPendingGetTabularData
//                                                                               .data!
//                                                                               .findAllTableData![index]
//                                                                               .followUpDate
//                                                                               .toString()),
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
//                                                                       (lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].estTime == null ||
//                                                                               lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].estTime.toString() ==
//                                                                                   'null')
//                                                                           ? ''
//                                                                           : lCPWorkOrderPendingViewModel
//                                                                               .lcpWorkOrderPendingGetTabularData
//                                                                               .data!
//                                                                               .findAllTableData![index]
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
//                                                   //           (lCPWorkOrderPendingViewModel
//                                                   //                           .lcpWorkOrderPendingGetTabularData
//                                                   //                           .data!
//                                                   //                           .findAllTableData![
//                                                   //                               index]
//                                                   //                           .totalCost ==
//                                                   //                       null ||
//                                                   //                   lCPWorkOrderPendingViewModel
//                                                   //                           .lcpWorkOrderPendingGetTabularData
//                                                   //                           .data!
//                                                   //                           .findAllTableData![
//                                                   //                               index]
//                                                   //                           .totalCost
//                                                   //                           .toString() ==
//                                                   //                       'null')
//                                                   //               ? ''
//                                                   //               : lCPWorkOrderPendingViewModel
//                                                   //                   .lcpWorkOrderPendingGetTabularData
//                                                   //                   .data!
//                                                   //                   .findAllTableData![
//                                                   //                       index]
//                                                   //                   .totalCost
//                                                   //                   .toString(),
//                                                   //           textAlign:
//                                                   //               TextAlign.left,
//                                                   //           style:
//                                                   //               const TextStyle(
//                                                   //             fontSize: 12,
//                                                   //             color: Colors.white,
//                                                   //           ),
//                                                   //         ),
//                                                   //       ),
//                                                   //     ],
//                                                   //   ),
//                                                   // ),
//                                                   (widget.heading !=
//                                                           'Total Order Pending (Change Order)')
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
//                                                                   (lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].cycle ==
//                                                                               null ||
//                                                                           lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].cycle.toString() ==
//                                                                               'null')
//                                                                       ? ''
//                                                                       : lCPWorkOrderPendingViewModel
//                                                                           .lcpWorkOrderPendingGetTabularData
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
//                                                           'Total Order Pending (Change Order)')
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
//                                                                   (lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].nextMaintDue ==
//                                                                               null ||
//                                                                           lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].nextMaintDue.toString() ==
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
//                                                         )
//                                                 ],
//                                               ),
//                                             ),
//                                               const Divider(
//                                               color: Colors.grey,
//                                             ),
//                                              Padding(
//                                               padding:
//                                                   EdgeInsets.only(left: 8.0),
//                                               child: Row(
//                                                 children: [
//                                                  Expanded(
//                                                           // alignment: Alignment.topLeft,
//                                                           child: Column(
//                                                             children: [
//                                                               const Align(
//                                                                 alignment:
//                                                                     Alignment
//                                                                         .topLeft,
//                                                                 child: Text(
//                                                                   "INITIATED BY: ",
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
//                                                                   (lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].initiatedBy ==
//                                                                               null ||
//                                                                           lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].initiatedBy.toString() ==
//                                                                               'null')
//                                                                       ? ''
//                                                                       : lCPWorkOrderPendingViewModel
//                                                                           .lcpWorkOrderPendingGetTabularData
//                                                                           .data!
//                                                                           .findAllTableData![
//                                                                               index]
//                                                                           .initiatedBy
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
//                                                         )
//                                                  , Expanded(
//                                                           // alignment: Alignment.topLeft,
//                                                           child: Column(
//                                                             children: [
//                                                               const Align(
//                                                                 alignment:
//                                                                     Alignment
//                                                                         .topLeft,
//                                                                 child: Text(
//                                                                   "SHARED WITH: ",
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
//                                                                   (lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].crewName ==
//                                                                               null ||
//                                                                           lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].crewName.toString() ==
//                                                                               'null')
//                                                                       ? ''
//                                                                       : lCPWorkOrderPendingViewModel
//                                                                           .lcpWorkOrderPendingGetTabularData
//                                                                           .data!
//                                                                           .findAllTableData![
//                                                                               index]
//                                                                           .crewName
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
//                                                   Expanded(
//                                                           // alignment: Alignment.topLeft,
//                                                           child: Column(
//                                                             children: [
//                                                               const Align(
//                                                                 alignment:
//                                                                     Alignment
//                                                                         .topLeft,
//                                                                 child: Text(
//                                                                   "CHAT HISTORY: ",
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
//                                                                 child: GestureDetector(
//                                                                       onTap: () {
//                                                             showModalBottomSheet(
//                                                               context: context,
//                                                               isScrollControlled:
//                                                                   true,
//                                                               backgroundColor:
//                                                                   Colors
//                                                                       .transparent,
//                                                               builder: (_) => ChatHistoryScreen(
//                                                                   tokenNo: lCPWorkOrderPendingViewModel
//                                                                       .lcpWorkOrderPendingGetTabularData
//                                                                       .data!
//                                                                       .findAllTableData![
//                                                                           index]
//                                                                       .tokenNo
//                                                                       .toString()),
//                                                             );
//                                                           },
//                                                                   child: Text(
//                                                                     (lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].addChatNotes ==
//                                                                                 null ||
//                                                                             lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].addChatNotes.toString() ==
//                                                                                 'null')
//                                                                         ? ''
//                                                                         : lCPWorkOrderPendingViewModel
//                                                                             .lcpWorkOrderPendingGetTabularData
//                                                                             .data!
//                                                                             .findAllTableData![
//                                                                                 index]
//                                                                             .addChatNotes
//                                                                             .toString(),
//                                                                     textAlign:
//                                                                         TextAlign
//                                                                             .left,
//                                                                     style:
//                                                                         const TextStyle(
//                                                                       fontSize:
//                                                                           12,
//                                                                       color: Colors
//                                                                           .white,
//                                                                     ),
//                                                                   ),
//                                                                 ),
//                                                               ),
//                                                             ],
//                                                           ),
//                                                         )
                                              
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
//                                                   // Visibility(
//                                                   //   visible:
//                                                   //       _isVisibleChangeOrder,
//                                                   //   child: Expanded(
//                                                   //     // alignment: Alignment.topLeft,
//                                                   //     child: Column(
//                                                   //       children: [
//                                                   //         const Align(
//                                                   //           alignment: Alignment
//                                                   //               .topLeft,
//                                                   //           child: Text(
//                                                   //             "SHARE: ",
//                                                   //             textAlign:
//                                                   //                 TextAlign
//                                                   //                     .left,
//                                                   //             style: TextStyle(
//                                                   //               fontSize: 12,
//                                                   //               fontWeight:
//                                                   //                   FontWeight
//                                                   //                       .bold,
//                                                   //               color: Colors
//                                                   //                   .white,
//                                                   //             ),
//                                                   //           ),
//                                                   //         ),
//                                                   //         (lCPWorkOrderPendingViewModel
//                                                   //                         .lcpWorkOrderPendingGetTabularData
//                                                   //                         .data!
//                                                   //                         .findAllTableData![
//                                                   //                             index]
//                                                   //                         .maintType
//                                                   //                         .toString() ==
//                                                   //                     'RegularMaint' ||
//                                                   //                 lCPWorkOrderPendingViewModel
//                                                   //                         .lcpWorkOrderPendingGetTabularData
//                                                   //                         .data!
//                                                   //                         .findAllTableData![
//                                                   //                             index]
//                                                   //                         .maintType
//                                                   //                         .toString() ==
//                                                   //                     'Change Order')
//                                                   //             ? (lCPWorkOrderPendingViewModel
//                                                   //                         .lcpWorkOrderPendingGetTabularData
//                                                   //                         .data!
//                                                   //                         .findAllTableData![
//                                                   //                             index]
//                                                   //                         .visibilityFlag
//                                                   //                         .toString() ==
//                                                   //                     '2')
//                                                   //                 ? Align(
//                                                   //                     alignment:
//                                                   //                         Alignment
//                                                   //                             .topLeft,
//                                                   //                     child:
//                                                   //                         InkWell(
//                                                   //                       onTap:
//                                                   //                           () async {
//                                                   //                              if (rights !=
//                                                   //                             "READ ONLY") {
//                                                   //                                 CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
//                                                   //                             '${lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].tokenNo.toString()} Row Maintenance Already Shared with Crew',
//                                                   //                             context);
//                                                   //                             }else{
//                                                   //                                 CustomToastSnackBarProgressDialog.flushBarErrorMessage("You are not authorized to share.",
//                                                   //                               context);
//                                                   //                             }
//                                                   //                       },
//                                                   //                       child: const Align(
//                                                   //                           alignment: Alignment.topLeft,
//                                                   //                           child: Icon(
//                                                   //                             Icons.share,
//                                                   //                             color: Colors.green,
//                                                   //                             //getCrewList
//                                                   //                           )),
//                                                   //                     ),
//                                                   //                   )
//                                                   //                 : Align(
//                                                   //                     alignment:
//                                                   //                         Alignment
//                                                   //                             .topLeft,
//                                                   //                     child:
//                                                   //                         InkWell(
//                                                   //                       onTap:
//                                                   //                           () async {
//                                                   //                         // print(
//                                                   //                         //     'job no ${lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].id}');
//                                                   //                         // openDialogFlag(lCPWorkOrderPendingViewModel
//                                                   //                         //     .lcpWorkOrderPendingGetTabularData
//                                                   //                         //     .data!
//                                                   //                         //     .findAllTableData![index]
//                                                   //                         //     .id
//                                                   //                         //     .toString());
//                                                   //                         if (rights !=
//                                                   //                             "READ ONLY") {
//                                                   //                           showCrewDialog(context,
//                                                   //                               lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].id.toString());
//                                                   //                         } else {
//                                                   //                          CustomToastSnackBarProgressDialog.flushBarErrorMessage(
//                                                   //                             "You are not authorized to share.",
//                                                   //                             context);
//                                                   //                         }
//                                                   //                       },
//                                                   //                       child: const Align(
//                                                   //                           alignment: Alignment.topLeft,
//                                                   //                           child: Icon(
//                                                   //                             Icons.share,
//                                                   //                             color: Colors.blue,
//                                                   //                           )),
//                                                   //                     ),
//                                                   //                   )
//                                                   //             : const Text(
//                                                   //                 "",
//                                                   //                 style:
//                                                   //                     TextStyle(
//                                                   //                   color: Colors
//                                                   //                       .white,
//                                                   //                   fontWeight:
//                                                   //                       FontWeight
//                                                   //                           .bold,
//                                                   //                   fontSize:
//                                                   //                       10,
//                                                   //                 ),
//                                                   //               )
//                                                   //       ],
//                                                   //     ),
//                                                   //   ),
//                                                   // ),

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
//                                                                 // Navigator.of(context).push(
//                                                                 //     MaterialPageRoute(
//                                                                 //         builder: (BuildContext
//                                                                 //                 context) =>
//                                                                 //             MapViewContractor(
//                                                                 //               id: lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].id.toString(),
//                                                                 //             )));
//                                                                 //       Navigator  .push(
//                                                                 //   context,
//                                                                 //   MaterialPageRoute(
//                                                                 //     builder:
//                                                                 //         (context) =>
//                                                                 //             MapViewPage(
//                                                                 //       url: MapUrl.getGfEndPoint(lCPWorkOrderPendingViewModel
//                                                                 //         .lcpWorkOrderPendingGetTabularData
//                                                                 //         .data!
//                                                                 //         .findAllTableData![
//                                                                 //             index]
//                                                                 //         .tokenNo
//                                                                 //         .toString(),id),
//                                                                 //     ),
//                                                                 //   ),
//                                                                 // );

//                                                                 await browser.open(
//                                                                     url: WebUri(
//                                                                         // "https://mapapi.ariespro.com/main/contractor/CIVM_Map/${lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].tokenNo.toString()}/USRQWXH589Z"),
//                                                                         MapUrl.getGfEndPoint(
//                                                                             lCPWorkOrderPendingViewModel.lcpWorkOrderPendingGetTabularData.data!.findAllTableData![index].tokenNo
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

//   fetchData(String workOrderNoId) {
//     lCPWorkOrderPendingViewModel.fetchLCPWorkOrderPendingTabularListApi(
//         context,
//         'PENDING',
//         workOrderNoId,
//         'LCP',
//         widget.budgetType,
//         // widget.maintenanceType
//         'Change Order',
//         id,
//         'generalforeman','0');
//   }

//   void _filterData(String query) {
//     if (query.isEmpty) {
//       getContractorData();
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
//         lCPWorkOrderPendingViewModel.imageData.data?.images![i].imageLocation;
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
//                       onTap: () {
//                         openFullSizeVideoDialog(fileLocation);
//                       },
//                       child: ClipRRect(
//                           borderRadius: BorderRadius.circular(
//                               5), // Optional rounded corners
//                           child: SizedBox(
//                             height: 150,
//                             width: double.infinity,
//                             child: VideoPlayerWidget(
//                               videoUrl:
//                                   'https://civm.ariespro.com/assets/clientuploads/$fileLocation',
//                             ),
//                           )),
//                     )
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

//     lCPWorkOrderPendingViewModel.fetchLCPWorkOrderPendingTabularListApi(
//         context,
//         'PENDING',
//         '',
//         '',
//         widget.budgetType,
//         widget.maintenanceType,
//         id,
//         'generalforeman','0');
//     rights = data.user!.rights.toString();
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
//           'crewId': selectedCrewLoginID,
//         },
//       );

//       if (response.statusCode == 200) {
//         var responseBody = json.decode(response.body);
//         print('responseBody $responseBody');
//         String crewEmailId = responseBody['crewEmailId'];
//         print('API call successful');
//         String message = '';
//         if (widget.heading == 'Total Order Pending (IVM Maintenance)') {
//           message = 'IVM Maintenance';
//         } else if (widget.heading ==
//             'Total Order Pending (Mid cycle Herbicide)') {
//           message = 'Mid cycle Herbicide';
//         }
//         CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
//             '$token $message Successfully Shared with Crew', context);
//         DateTime now = DateTime.now();
//         var formatter = DateFormat('MM-dd-yyyy HH:mm:ss');
//         String formattedDate = formatter.format(now);
//         var subject = 'CIVM ROW';
//         var msg =
//             'Job No. $token $message Successfully Shared with you on $formattedDate.';
//         _sendMail(subject, msg, crewEmailId);
//         getContractorData();
//         await Future.delayed(const Duration(seconds: 3));
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
//                               getContractorData();
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

//   void newDateFormat(
//     int index,
//   ) {
//     String? rawContractYear = lCPWorkOrderPendingViewModel
//         .lcpWorkOrderPendingGetTabularData
//         .data!
//         .findAllTableData![index]
//         .contractYear
//         ?.toString();

//     String? rawNextMaintDue = lCPWorkOrderPendingViewModel
//         .lcpWorkOrderPendingGetTabularData
//         .data!
//         .findAllTableData![index]
//         .nextMaintDue
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

// // void showCrewDialog(BuildContext context, String tokenNo) async {
// //   await fetchCrewList(); // Fetch crew list before showing the dialog

// //   String? selectedCrew; // Local state for dropdown selection

// //   showDialog(
// //     context: context,
// //     builder: (BuildContext dialogContext) {
// //       return StatefulBuilder(
// //         builder: (context, setStateDialog) {
// //           return AlertDialog(
// //             title: const Text("Select Crew"),
// //             content: isLoading
// //                 ? const Center(child: CircularProgressIndicator())
// //                 : DropdownButton<String>(
// //                     value: selectedCrew,
// //                     hint: const Text("Select Crew"),
// //                     isExpanded: true,
// //                     items: crewList.map((crew) {
// //                       return DropdownMenuItem(
// //                         value: crew["loginId"].toString(),
// //                         child: Text(crew["name"]),
// //                       );
// //                     }).toList(),
// //                     onChanged: (value) {
// //                       setStateDialog(() {
// //                         selectedCrew = value;
// //                       });
// //                       print("Selected Crew: $value");
// //                       selectedCrewLoginID = value.toString();
// //                     },
// //                   ),
// //             actions: [
// //               Align(
// //                 alignment: Alignment.center,
// //                 child: Row(
// //                   children: [
// //                     Container(
// //                         margin: EdgeInsets.only(
// //                             left: MediaQuery.of(context).size.width * 0.15,
// //                             top: 6.0,
// //                             bottom: 10,
// //                             right: 2),
// //                         child: InkWell(
// //                           onTap: () {
// //                             Navigator.pop(dialogContext);
// //                           },
// //                           child: Container(
// //                             margin: const EdgeInsets.only(bottom: 10.0),
// //                             alignment: Alignment.center,
// //                             width: MediaQuery.of(context).size.width * 0.25,
// //                             height: 40,
// //                             decoration: BoxDecoration(
// //                                 borderRadius: BorderRadius.circular(10),
// //                                 boxShadow: const [
// //                                   BoxShadow(
// //                                       color: Color.fromARGB(255, 84, 7, 2),
// //                                       blurRadius: 5,
// //                                       offset: Offset(2.0, 5.0))
// //                                 ],
// //                                 color: Colors.black,
// //                                 gradient: const LinearGradient(
// //                                   colors: [Colors.red, Colors.red],
// //                                 )),
// //                             child: const Align(
// //                               alignment: Alignment.center,
// //                               child: Text(
// //                                 "NO",
// //                                 style: TextStyle(
// //                                   color: Colors.white,
// //                                   fontWeight: FontWeight.bold,
// //                                   fontSize: 20,
// //                                 ),
// //                               ),
// //                             ),
// //                           ),
// //                         )),

// //                     // YES Button
// //                     Container(
// //                         margin: const EdgeInsets.only(left: 6, top: 6.0, bottom: 10),
// //                         child: InkWell(
// //                           onTap: () {
// //                             updateFlagValue(tokenNo, 2);
// //                             Navigator.pop(dialogContext);
// //                           },
// //                           child: Container(
// //                             margin: const EdgeInsets.only(bottom: 10.0),
// //                             alignment: Alignment.center,
// //                             width: MediaQuery.of(context).size.width * 0.25,
// //                             height: 40,
// //                             decoration: BoxDecoration(
// //                                 borderRadius: BorderRadius.circular(10),
// //                                 boxShadow: const [
// //                                   BoxShadow(
// //                                       color: Color.fromARGB(255, 1, 91, 4),
// //                                       blurRadius: 5,
// //                                       offset: Offset(2.0, 5.0))
// //                                 ],
// //                                 color: Colors.black,
// //                                 gradient: const LinearGradient(
// //                                   colors: [Colors.green, Colors.green],
// //                                 )),
// //                             child: const Align(
// //                               alignment: Alignment.center,
// //                               child: Text(
// //                                 "YES",
// //                                 style: TextStyle(
// //                                   color: Colors.white,
// //                                   fontWeight: FontWeight.bold,
// //                                   fontSize: 20,
// //                                 ),
// //                               ),
// //                             ),
// //                           ),
// //                         )),
// //                   ],
// //                 ),
// //               ),
// //             ],
// //           );
// //         },
// //       );
// //     },
// //   );
// // }

//   void showCrewDialog(BuildContext context, String tokenNo) async {
//     await fetchCrewList(); // Fetch crew list before showing the dialog

//     String? selectedCrew; // Local state for dropdown selection
//     String? errorMessage; // To show validation error message

//     showDialog(
//       context: context,
//       builder: (BuildContext dialogContext) {
//         return StatefulBuilder(
//           builder: (context, setStateDialog) {
//             return AlertDialog(
//               title: const Text("Select Crew"),
//               content: isLoading
//                   ? const Center(child: CircularProgressIndicator())
//                   : Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         DropdownButton<String>(
//                           value: selectedCrew,
//                           hint: const Text("Select Crew"),
//                           isExpanded: true,
//                           items: crewList.map((crew) {
//                             return DropdownMenuItem(
//                               value: crew["loginId"].toString(),
//                               child: Text(crew["name"]),
//                             );
//                           }).toList(),
//                           onChanged: (value) {
//                             setStateDialog(() {
//                               selectedCrew = value;
//                               errorMessage = null; // Clear error when selected
//                             });
//                             selectedCrewLoginID = value.toString();
//                           },
//                         ),
//                         if (errorMessage != null) // Show error if exists
//                           Padding(
//                             padding: const EdgeInsets.only(top: 8.0),
//                             child: Text(
//                               errorMessage!,
//                               style: const TextStyle(
//                                 color: Colors.red,
//                                 fontSize: 14,
//                               ),
//                             ),
//                           ),
//                       ],
//                     ),
//               actions: [
//                 Align(
//                   alignment: Alignment.center,
//                   child: Row(
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
//                           if (selectedCrew == null) {
//                             setStateDialog(() {
//                               errorMessage = "Please select a crew.";
//                             });
//                             return;
//                           }
//                           updateFlagValue(tokenNo, 2);
//                           Navigator.pop(dialogContext);
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

//   Future<void> fetchCrewList() async {
//     setState(() {
//       isLoading = true;
//     });

//     final userPreferences = Provider.of<UserPref>(context, listen: false);
//     UserModel data = await userPreferences.getUser();
//     // String contractorId = data.user!.id.toString();

//     String url = AppUrl.crewList;
//     // "https://civmapi.ariespro.com/civmapi/login_user/getAllCrewFromCREWMASTER?contractorId=$contractorId";

//     try {
//       final response = await http.get(
//         Uri.parse(url),
//         headers: {
//           "Authorization": 'Bearer ${data.token!}',
//           "Content-Type": "application/json",
//         },
//       );

//       if (response.statusCode == 200) {
//         final Map<String, dynamic> jsonResponse = json.decode(response.body);

//         if (jsonResponse.containsKey("AllCrewListOfCrewMASTER") &&
//             jsonResponse["AllCrewListOfCrewMASTER"] is List) {
//           final List<dynamic> crewData =
//               jsonResponse["AllCrewListOfCrewMASTER"];

//           print('dataCrewList $crewData');

//           setState(() {
//             crewList = crewData
//                 .map((e) => {"loginId": e["loginId"], "name": e["name"]})
//                 .toList();
//             // Optionally set a default value for selectedCrew (e.g., the first crew in the list)
//             if (crewList.isNotEmpty) {
//               selectedCrew = crewList[0]["loginId"].toString();
//             }
//           });
//         } else {
//           print("Unexpected response format: $jsonResponse");
//         }
//       } else {
//         print("Error fetching crew: ${response.statusCode}");
//       }
//     } catch (e) {
//       print("Error: $e");
//     } finally {
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }
// }
