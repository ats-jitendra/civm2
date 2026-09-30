// // import 'package:CIVM/piedmont/screens/admin_pannel/map_view_admin.dart';
// import 'dart:io';
// import 'package:CIVM/piedmont/models/user_model.dart';
// import 'package:CIVM/piedmont/repository/map_url.dart';
// import 'package:CIVM/piedmont/screens/admin_pannel/row_maintenance_view/daily_herbicide_application.dart';
// import 'package:CIVM/piedmont/screens/admin_pannel/row_maintenance_view/mixing_inventory.dart';
// import 'package:CIVM/piedmont/screens/admin_pannel/row_maintenance_view/pdf_view.dart';
// import 'package:CIVM/piedmont/screens/my_chrome_safari_map_recording.dart';
// import 'package:CIVM/piedmont/utils/user_pref.dart';
// import 'package:CIVM/utils/user_pref.dart';
// import 'package:CIVM/models/user_model.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// import 'package:CIVM/piedmont/resources/app_colors.dart';
// import 'package:intl/intl.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:photo_view/photo_view.dart';
// import 'package:photo_view/photo_view_gallery.dart';
// import 'package:provider/provider.dart';
// import '../../../data/response/status.dart';
// import '../../../utils/custom_toast_snackbar_progressdialog.dart';
// import '../../../view_model/lcp_total_orders_closed_view_model.dart';
// import 'ivm_time_sheet.dart';
// import 'package:http/http.dart' as http;
// import 'package:open_file/open_file.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// // import 'package:image/image.dart' as img;

// // ignore: must_be_immutable
// class LCPTotalOrderClosed extends StatefulWidget {
//   String budgetType;
//   String maintenanceType;
//   String heading;

//   LCPTotalOrderClosed({
//     Key? key,
//     required this.budgetType,
//     required this.maintenanceType,
//     required this.heading,
//   }) : super(key: key);

//   @override
//   State<LCPTotalOrderClosed> createState() => _LCPTotalOrderClosedState();
// }

// class _LCPTotalOrderClosedState extends State<LCPTotalOrderClosed> {
//   List<String> menu = [];

//   int substationId = 0;
//   int feederId = 0;
//   final TextEditingController _input = TextEditingController();
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

//   LCPWorkOrdersClosedViewModel lCPWorkOrdersClosedViewModel =
//       LCPWorkOrdersClosedViewModel();

//   final browser = MyChromeSafariBrowser();

//   @override
//   void initState() {
//     lCPWorkOrdersClosedViewModel.fetchLCPWorkOrderClosedTabularListApi(
//         context,
//         '',
//         '',
//         'CLOSED',
//         '',
//         widget.budgetType,
//         widget.maintenanceType,
//         '',
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
//           title: Text(
//             '${widget.heading} (Closed)',
//             style: const TextStyle(color: Colors.white),
//           ),
//           backgroundColor: AppColors.baseColor,
//         ),
//         body: ChangeNotifierProvider<LCPWorkOrdersClosedViewModel>(
//             create: (BuildContext context) => lCPWorkOrdersClosedViewModel,
//             child: Consumer<LCPWorkOrdersClosedViewModel>(
//                 builder: (context, value, _) {
//               switch (value.lcpWorkOrderClosedGetTabularData.status) {
//                 case Status.LOADING:
//                   return const Center(child: CircularProgressIndicator());
//                 case Status.ERROR:
//                   return
//                       // CustomToastSnackBarProgressDialog.flushBarErrorMessage(
//                       //     value.lcpWorkOrderClosedGetTabularData.message.toString(),
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
//                       await lCPWorkOrdersClosedViewModel
//                           .fetchLCPWorkOrderClosedTabularListApi(
//                               context,
//                               '',
//                               '',
//                               'CLOSED',
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
//                       height: size.height * 1,
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
//                           SingleChildScrollView(
//                             scrollDirection: Axis.horizontal,
//                             child: Row(
//                               children: [
//                                 Column(
//                                   children: [
//                                     const Align(
//                                         alignment: Alignment.centerLeft,
//                                         child: Padding(
//                                           padding: EdgeInsets.only(
//                                               left: 2.0,
//                                               right: 2.0,
//                                               bottom: 2.0,
//                                               top: 4.0),
//                                           child: Text(
//                                             "SUBSTATION",
//                                             style: TextStyle(
//                                                 fontSize: 16,
//                                                 color: AppColors.baseColor,
//                                                 fontWeight: FontWeight.bold),
//                                           ),
//                                         )),
//                                     Align(
//                                       alignment: Alignment.centerLeft,
//                                       child: SizedBox(
//                                         width: 200,
//                                         child: DropdownButtonFormField<String>(
//                                           hint: const Text('-Select-'),
//                                           dropdownColor: Colors.white,
//                                           value: selectedSubstation,
//                                           style: const TextStyle(
//                                               color: Color.fromARGB(
//                                                   255, 7, 59, 120),
//                                               fontSize: 16),
//                                           icon: const Icon(
//                                             Icons.arrow_drop_down,
//                                             color:
//                                                 AppColors.baseColor,
//                                             size: 40,
//                                           ),
//                                           decoration: const InputDecoration(
//                                             enabledBorder: OutlineInputBorder(
//                                               borderSide: BorderSide(
//                                                 color: AppColors.baseColor,
//                                               ),
//                                               // borderRadius: BorderRadius.circular(25),
//                                             ),
//                                             focusedBorder: OutlineInputBorder(
//                                               borderSide: BorderSide(
//                                                 color: AppColors.baseColor,
//                                               ),
//                                               // borderRadius: BorderRadius.circular(25),
//                                             ),
//                                           ),
//                                           isExpanded: true,
//                                           items: lCPWorkOrdersClosedViewModel
//                                               .lcpWorkOrderClosedGetTabularData
//                                               .data!
//                                               .findAllSubstationAndSubIdByStatus!
//                                               .map((e) {
//                                             return DropdownMenuItem(
//                                               value: e.subId.toString(),
//                                               // e.getIdAndSubstationByCountId![0].subStation.toString(),
//                                               child:
//                                                   Text(e.subStation.toString()),
//                                             );
//                                           }).toList(),
//                                           onChanged: (val) {
//                                             setState(() {
//                                               selectedSubstation = val;
//                                             });
//                                             if (selectedFeeder != null) {
//                                               selectedFeeder = null;
//                                             }
//                                             print('val');
//                                             print(val);
//                                             fetchData('', val!, '');
//                                             substationId = int.parse(val);
//                                             print('111111111111111');
//                                             print(substationId);
//                                           },
//                                           validator: (value) => value == null
//                                               ? 'field required'
//                                               : null,
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 const SizedBox(
//                                   width: 5,
//                                 ),
//                                 Column(
//                                   children: [
//                                     const Align(
//                                         alignment: Alignment.centerLeft,
//                                         child: Padding(
//                                           padding: EdgeInsets.only(
//                                               left: 2.0,
//                                               right: 2.0,
//                                               bottom: 2.0,
//                                               top: 4.0),
//                                           child: Text(
//                                             "FEEDER",
//                                             style: TextStyle(
//                                                 fontSize: 16,
//                                                 color: AppColors.baseColor,
//                                                 fontWeight: FontWeight.bold),
//                                           ),
//                                         )),
//                                     Align(
//                                       alignment: Alignment.centerLeft,
//                                       child: SizedBox(
//                                         width: 200,
//                                         child: DropdownButtonFormField<String>(
//                                           hint: const Text('-Select-'),
//                                           dropdownColor: const Color.fromRGBO(
//                                               255, 255, 255, 1),
//                                           value: selectedFeeder,
//                                           style: const TextStyle(
//                                               color: Color.fromARGB(
//                                                   255, 7, 59, 120),
//                                               fontSize: 16),
//                                           icon: const Icon(
//                                             Icons.arrow_drop_down,
//                                             color:
//                                                 AppColors.baseColor,
//                                             size: 40,
//                                           ),
//                                           decoration: const InputDecoration(
//                                             enabledBorder: OutlineInputBorder(
//                                               borderSide: BorderSide(
//                                                 color: AppColors.baseColor,
//                                               ),
//                                               // borderRadius: BorderRadius.circular(25),
//                                             ),
//                                             focusedBorder: OutlineInputBorder(
//                                               borderSide: BorderSide(
//                                                 color: AppColors.baseColor,
//                                               ),
//                                               // borderRadius: BorderRadius.circular(25),
//                                             ),
//                                           ),
//                                           isExpanded: true,
//                                           items: lCPWorkOrdersClosedViewModel
//                                               .lcpWorkOrderClosedGetTabularData
//                                               .data!
//                                               .findAllFeederNameAndFeederByCountyAndSubstationAndStatus!
//                                               .map((e) {
//                                             return DropdownMenuItem(
//                                               value: e.feeder.toString(),
//                                               // e.getIdAndSubstationByCountId![0].subStation.toString(),
//                                               child:
//                                                   Text(e.feederName.toString()),
//                                             );
//                                           }).toList(),
//                                           onChanged: (val) {
//                                             print('val');
//                                             print(val);
//                                             fetchData(val!,
//                                                 substationId.toString(), '');
//                                             feederId = int.parse(val);
//                                             print('111111111111111');
//                                             print(substationId);
//                                             setState(() {
//                                               selectedFeeder = val;
//                                             });
//                                           },
//                                           validator: (value) => value == null
//                                               ? 'field required'
//                                               : null,
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.only(top: 8.0),
//                             child: Align(
//                               alignment: Alignment.bottomLeft,
//                               child: Text(
//                                 "TOTAL NO OF RECORDS : ${lCPWorkOrdersClosedViewModel.lcpWorkOrderClosedGetTabularData.data!.findAllTableData!.length.toString()}",
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
//                             child: Align(
//                               alignment: Alignment.center,
//                               child: ListView.builder(
//                                   itemCount: lCPWorkOrdersClosedViewModel
//                                       .lcpWorkOrderClosedGetTabularData
//                                       .data!
//                                       .findAllTableData!
//                                       .length,
//                                   // itemCount: historyList.length,
//                                   itemBuilder: (BuildContext ctxt, int index) {
//                                     String? dateStringCreateDate =
//                                         lCPWorkOrdersClosedViewModel
//                                             .lcpWorkOrderClosedGetTabularData
//                                             .data!
//                                             .findAllTableData![index]
//                                             .createDate
//                                             .toString();
//                                     DateTime date =
//                                         DateTime.parse(dateStringCreateDate);
//                                     String formattedDateCreateDate =
//                                         DateFormat('MM/dd/yyyy').format(date);
//                                     return Row(
//                                       children: [
//                                         Padding(
//                                           padding: const EdgeInsets.only(
//                                               top: 4.0, bottom: 4, left: 4),
//                                           child: Container(
//                                             width: MediaQuery.of(context)
//                                                     .size
//                                                     .width *
//                                                 0.9,

//                                             // margin:  EdgeInsets.only(
//                                             //     top: 5.0, bottom: 5.0, left: 2,right: 2),
//                                             padding: const EdgeInsets.all(8),
//                                             decoration: BoxDecoration(
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
//                                             child: Column(children: [
//                                               Padding(
//                                                 padding: const EdgeInsets.only(
//                                                     left: 8.0),
//                                                 child: Row(
//                                                   children: [
//                                                     Expanded(
//                                                       // alignment: Alignment.topLeft,
//                                                       child: Column(
//                                                         children: [
//                                                           const Align(
//                                                             alignment: Alignment
//                                                                 .topLeft,
//                                                             child: Text(
//                                                               "DOWNLOAD REPORT: ",
//                                                               textAlign:
//                                                                   TextAlign
//                                                                       .left,
//                                                               style: TextStyle(
//                                                                 fontSize: 12,
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .bold,
//                                                                 color: Colors
//                                                                     .white,
//                                                               ),
//                                                             ),
//                                                           ),
//                                                           (lCPWorkOrdersClosedViewModel
//                                                                       .lcpWorkOrderClosedGetTabularData
//                                                                       .data!
//                                                                       .findAllTableData![
//                                                                           index]
//                                                                       .maintType ==
//                                                                   'RegularMaint')
//                                                               ? const Text(
//                                                                   "",
//                                                                   textAlign:
//                                                                       TextAlign
//                                                                           .left,
//                                                                   style:
//                                                                       TextStyle(
//                                                                     fontSize: 0,
//                                                                     fontWeight:
//                                                                         FontWeight
//                                                                             .bold,
//                                                                     color: Color
//                                                                         .fromARGB(
//                                                                             255,
//                                                                             7,
//                                                                             59,
//                                                                             120),
//                                                                   ),
//                                                                 )
//                                                               : Align(
//                                                                   alignment:
//                                                                       Alignment
//                                                                           .topLeft,
//                                                                   child:
//                                                                       InkWell(
//                                                                     onTap: () {
//                                                                       openPdf(
//                                                                         lCPWorkOrdersClosedViewModel
//                                                                             .lcpWorkOrderClosedGetTabularData
//                                                                             .data!
//                                                                             .findAllTableData![index]
//                                                                             .tokenNo,
//                                                                         lCPWorkOrdersClosedViewModel
//                                                                             .lcpWorkOrderClosedGetTabularData
//                                                                             .data!
//                                                                             .findAllTableData![index]
//                                                                             .followUpDate,
//                                                                         lCPWorkOrdersClosedViewModel
//                                                                             .lcpWorkOrderClosedGetTabularData
//                                                                             .data!
//                                                                             .findAllTableData![index]
//                                                                             .substation,
//                                                                         lCPWorkOrdersClosedViewModel
//                                                                             .lcpWorkOrderClosedGetTabularData
//                                                                             .data!
//                                                                             .findAllTableData![index]
//                                                                             .contractorCompany,
//                                                                         lCPWorkOrdersClosedViewModel
//                                                                             .lcpWorkOrderClosedGetTabularData
//                                                                             .data!
//                                                                             .findAllTableData![index]
//                                                                             .mapLocation,
//                                                                         lCPWorkOrdersClosedViewModel
//                                                                             .lcpWorkOrderClosedGetTabularData
//                                                                             .data!
//                                                                             .findAllTableData![index]
//                                                                             .maintType,
//                                                                         lCPWorkOrdersClosedViewModel
//                                                                             .lcpWorkOrderClosedGetTabularData
//                                                                             .data!
//                                                                             .findAllTableData![index]
//                                                                             .contractorNotes,
//                                                                         lCPWorkOrdersClosedViewModel
//                                                                             .lcpWorkOrderClosedGetTabularData
//                                                                             .data!
//                                                                             .findAllTableData![index]
//                                                                             .dateOfInspection,
//                                                                         lCPWorkOrdersClosedViewModel
//                                                                             .lcpWorkOrderClosedGetTabularData
//                                                                             .data!
//                                                                             .findAllTableData![index]
//                                                                             .county,
//                                                                         lCPWorkOrdersClosedViewModel
//                                                                             .lcpWorkOrderClosedGetTabularData
//                                                                             .data!
//                                                                             .findAllTableData![index]
//                                                                             .contractor,
//                                                                         lCPWorkOrdersClosedViewModel
//                                                                             .lcpWorkOrderClosedGetTabularData
//                                                                             .data!
//                                                                             .findAllTableData![index]
//                                                                             .streetAddress,
//                                                                         lCPWorkOrdersClosedViewModel
//                                                                             .lcpWorkOrderClosedGetTabularData
//                                                                             .data!
//                                                                             .findAllTableData![index]
//                                                                             .type,
//                                                                         lCPWorkOrdersClosedViewModel
//                                                                             .lcpWorkOrderClosedGetTabularData
//                                                                             .data!
//                                                                             .findAllTableData![index]
//                                                                             .adminNotes1,
//                                                                         lCPWorkOrdersClosedViewModel
//                                                                             .lcpWorkOrderClosedGetTabularData
//                                                                             .data!
//                                                                             .findAllTableData![index]
//                                                                             .adminNotes2,
//                                                                       );
//                                                                     },
//                                                                     child:
//                                                                         const Icon(
//                                                                       Icons
//                                                                           .download,
//                                                                       color: Color.fromARGB(
//                                                                           255,
//                                                                           151,
//                                                                           249,
//                                                                           154),
//                                                                     ),
//                                                                   ))
//                                                         ],
//                                                       ),
//                                                     ),
//                                                     Expanded(
//                                                       // alignment: Alignment.topLeft,
//                                                       child: Column(
//                                                         children: [
//                                                           const Align(
//                                                             alignment: Alignment
//                                                                 .topLeft,
//                                                             child: Text(
//                                                               "IMAGE: ",
//                                                               textAlign:
//                                                                   TextAlign
//                                                                       .left,
//                                                               style: TextStyle(
//                                                                 fontSize: 12,
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .bold,
//                                                                 color: Colors
//                                                                     .white,
//                                                               ),
//                                                             ),
//                                                           ),
//                                                           Align(
//                                                               alignment:
//                                                                   Alignment
//                                                                       .topLeft,
//                                                               child: InkWell(
//                                                                 onTap:
//                                                                     () async {
//                                                                   await lCPWorkOrdersClosedViewModel
//                                                                       .fetchImageApi(
//                                                                     context,
//                                                                     lCPWorkOrdersClosedViewModel
//                                                                         .lcpWorkOrderClosedGetTabularData
//                                                                         .data!
//                                                                         .findAllTableData![
//                                                                             index]
//                                                                         .id
//                                                                         .toString(),
//                                                                   );
//                                                                   await Future.delayed(
//                                                                       const Duration(
//                                                                           seconds:
//                                                                               2));
//                                                                   openDialogPicture(lCPWorkOrdersClosedViewModel
//                                                                       .lcpWorkOrderClosedGetTabularData
//                                                                       .data!
//                                                                       .findAllTableData![
//                                                                           index]
//                                                                       .id
//                                                                       .toString());
//                                                                 },
//                                                                 child:
//                                                                     const Icon(
//                                                                   Icons.image,
//                                                                   color: Colors
//                                                                       .blue,
//                                                                 ),
//                                                               )),
//                                                         ],
//                                                       ),
//                                                     ),
//                                                     Expanded(
//                                                       // alignment: Alignment.topLeft,
//                                                       child: Column(
//                                                         children: [
//                                                           const Align(
//                                                             alignment: Alignment
//                                                                 .topLeft,
//                                                             child: Text(
//                                                               "TYPE: ",
//                                                               textAlign:
//                                                                   TextAlign
//                                                                       .left,
//                                                               style: TextStyle(
//                                                                 fontSize: 12,
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .bold,
//                                                                 color: Colors
//                                                                     .white,
//                                                               ),
//                                                             ),
//                                                           ),
//                                                           Align(
//                                                             alignment: Alignment
//                                                                 .topLeft,
//                                                             child: Text(
//                                                               (lCPWorkOrdersClosedViewModel
//                                                                               .lcpWorkOrderClosedGetTabularData
//                                                                               .data!
//                                                                               .findAllTableData![
//                                                                                   index]
//                                                                               .maintType ==
//                                                                           null ||
//                                                                       lCPWorkOrdersClosedViewModel
//                                                                               .lcpWorkOrderClosedGetTabularData
//                                                                               .data!
//                                                                               .findAllTableData![
//                                                                                   index]
//                                                                               .maintType
//                                                                               .toString() ==
//                                                                           'null')
//                                                                   ? ''
//                                                                   : lCPWorkOrdersClosedViewModel
//                                                                       .lcpWorkOrderClosedGetTabularData
//                                                                       .data!
//                                                                       .findAllTableData![
//                                                                           index]
//                                                                       .maintType
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
//                                                         ],
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                               const Divider(
//                                                 color: Colors.grey,
//                                               ),
//                                               Padding(
//                                                 padding: const EdgeInsets.only(
//                                                     left: 8.0),
//                                                 child: Row(
//                                                   children: [
//                                                     Expanded(
//                                                       // alignment: Alignment.topLeft,
//                                                       child: Column(
//                                                         children: [
//                                                           const Align(
//                                                             alignment: Alignment
//                                                                 .topLeft,
//                                                             child: Text(
//                                                               "JOB NO: ",
//                                                               textAlign:
//                                                                   TextAlign
//                                                                       .left,
//                                                               style: TextStyle(
//                                                                 fontSize: 12,
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .bold,
//                                                                 color: Colors
//                                                                     .white,
//                                                               ),
//                                                             ),
//                                                           ),
//                                                           Align(
//                                                             alignment: Alignment
//                                                                 .topLeft,
//                                                             child: Text(
//                                                               (lCPWorkOrdersClosedViewModel
//                                                                               .lcpWorkOrderClosedGetTabularData
//                                                                               .data!
//                                                                               .findAllTableData![
//                                                                                   index]
//                                                                               .tokenNo ==
//                                                                           null ||
//                                                                       lCPWorkOrdersClosedViewModel
//                                                                               .lcpWorkOrderClosedGetTabularData
//                                                                               .data!
//                                                                               .findAllTableData![
//                                                                                   index]
//                                                                               .tokenNo
//                                                                               .toString() ==
//                                                                           'null')
//                                                                   ? ''
//                                                                   : lCPWorkOrdersClosedViewModel
//                                                                       .lcpWorkOrderClosedGetTabularData
//                                                                       .data!
//                                                                       .findAllTableData![
//                                                                           index]
//                                                                       .tokenNo
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
//                                                         ],
//                                                       ),
//                                                     ),
//                                                     Expanded(
//                                                       // alignment: Alignment.topLeft,
//                                                       child: Column(
//                                                         children: [
//                                                           const Align(
//                                                             alignment: Alignment
//                                                                 .topLeft,
//                                                             child: Text(
//                                                               "STATUS: ",
//                                                               textAlign:
//                                                                   TextAlign
//                                                                       .left,
//                                                               style: TextStyle(
//                                                                 fontSize: 12,
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .bold,
//                                                                 color: Colors
//                                                                     .white,
//                                                               ),
//                                                             ),
//                                                           ),
//                                                           Align(
//                                                             alignment: Alignment
//                                                                 .topLeft,
//                                                             child: Text(
//                                                               (lCPWorkOrdersClosedViewModel
//                                                                               .lcpWorkOrderClosedGetTabularData
//                                                                               .data!
//                                                                               .findAllTableData![
//                                                                                   index]
//                                                                               .status ==
//                                                                           null ||
//                                                                       lCPWorkOrdersClosedViewModel
//                                                                               .lcpWorkOrderClosedGetTabularData
//                                                                               .data!
//                                                                               .findAllTableData![
//                                                                                   index]
//                                                                               .status
//                                                                               .toString() ==
//                                                                           'null')
//                                                                   ? ''
//                                                                   : lCPWorkOrdersClosedViewModel
//                                                                       .lcpWorkOrderClosedGetTabularData
//                                                                       .data!
//                                                                       .findAllTableData![
//                                                                           index]
//                                                                       .status
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
//                                                         ],
//                                                       ),
//                                                     ),
//                                                     Expanded(
//                                                       // alignment: Alignment.topLeft,
//                                                       child: Column(
//                                                         children: [
//                                                           const Align(
//                                                             alignment: Alignment
//                                                                 .topLeft,
//                                                             child: Text(
//                                                               "DAILY HERBICIDE APPLICATION: ",
//                                                               textAlign:
//                                                                   TextAlign
//                                                                       .left,
//                                                               style: TextStyle(
//                                                                 fontSize: 12,
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .bold,
//                                                                 color: Colors
//                                                                     .white,
//                                                               ),
//                                                             ),
//                                                           ),
//                                                           (lCPWorkOrdersClosedViewModel
//                                                                       .lcpWorkOrderClosedGetTabularData
//                                                                       .data!
//                                                                       .findAllTableData![
//                                                                           index]
//                                                                       .dailyHerbicide
//                                                                       .toString() ==
//                                                                   'APPROVED')
//                                                               ? Align(
//                                                                   alignment:
//                                                                       Alignment
//                                                                           .topLeft,
//                                                                   child:
//                                                                       InkWell(
//                                                                     onTap: () {
//                                                                       Navigator.of(
//                                                                               context)
//                                                                           .push(
//                                                                               MaterialPageRoute(builder: (BuildContext context) => DailyHerbicideApplication(id: lCPWorkOrdersClosedViewModel.lcpWorkOrderClosedGetTabularData.data!.findAllTableData![index].id.toString())));
//                                                                     },
//                                                                     child:
//                                                                         Container(
//                                                                       padding:
//                                                                           const EdgeInsets
//                                                                               .all(
//                                                                               2),
//                                                                       alignment:
//                                                                           Alignment
//                                                                               .center,
//                                                                       width: size
//                                                                               .width *
//                                                                           0.1,
//                                                                       height:
//                                                                           30,
//                                                                       decoration: BoxDecoration(
//                                                                           // shape: BoxShape.circle,
//                                                                           borderRadius: BorderRadius.circular(10),
//                                                                           color: const Color.fromARGB(255, 130, 193, 245),
//                                                                           gradient: const LinearGradient(
//                                                                             colors: [
//                                                                               Colors.green,
//                                                                               Colors.green,
//                                                                             ],
//                                                                           )),
//                                                                       child: const Align(
//                                                                           alignment: Alignment.center,
//                                                                           child: Icon(
//                                                                             Icons.remove_red_eye,
//                                                                             color:
//                                                                                 Colors.white,
//                                                                           )),
//                                                                     ),
//                                                                   ),
//                                                                 )
//                                                               : (lCPWorkOrdersClosedViewModel
//                                                                           .lcpWorkOrderClosedGetTabularData
//                                                                           .data!
//                                                                           .findAllTableData![
//                                                                               index]
//                                                                           .dailyHerbicide
//                                                                           .toString() ==
//                                                                       'PENDING')
//                                                                   ? Align(
//                                                                       alignment:
//                                                                           Alignment
//                                                                               .topLeft,
//                                                                       child:
//                                                                           InkWell(
//                                                                         onTap:
//                                                                             () {
//                                                                           Navigator.of(context)
//                                                                               .push(MaterialPageRoute(builder: (BuildContext context) => DailyHerbicideApplication(id: lCPWorkOrdersClosedViewModel.lcpWorkOrderClosedGetTabularData.data!.findAllTableData![index].id.toString())));
//                                                                         },
//                                                                         child:
//                                                                             Container(
//                                                                           padding: const EdgeInsets
//                                                                               .all(
//                                                                               2),
//                                                                           alignment:
//                                                                               Alignment.center,
//                                                                           width:
//                                                                               size.width * 0.1,
//                                                                           height:
//                                                                               30,
//                                                                           decoration: BoxDecoration(
//                                                                               // shape: BoxShape.circle,
//                                                                               borderRadius: BorderRadius.circular(10),
//                                                                               color: const Color.fromARGB(255, 130, 193, 245),
//                                                                               gradient: const LinearGradient(
//                                                                                 colors: [
//                                                                                   Colors.orange,
//                                                                                   Colors.orange,
//                                                                                 ],
//                                                                               )),
//                                                                           child: const Align(
//                                                                               alignment: Alignment.center,
//                                                                               child: Icon(
//                                                                                 Icons.remove_red_eye,
//                                                                                 color: Colors.white,
//                                                                               )),
//                                                                         ),
//                                                                       ),
//                                                                     )
//                                                                   : (lCPWorkOrdersClosedViewModel
//                                                                               .lcpWorkOrderClosedGetTabularData
//                                                                               .data!
//                                                                               .findAllTableData![
//                                                                                   index]
//                                                                               .dailyHerbicide
//                                                                               .toString() ==
//                                                                           'REJECTED')
//                                                                       ? Align(
//                                                                           alignment:
//                                                                               Alignment.topLeft,
//                                                                           child:
//                                                                               InkWell(
//                                                                             onTap:
//                                                                                 () {
//                                                                               Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => DailyHerbicideApplication(id: lCPWorkOrdersClosedViewModel.lcpWorkOrderClosedGetTabularData.data!.findAllTableData![index].id.toString())));
//                                                                             },
//                                                                             child:
//                                                                                 Container(
//                                                                               padding: const EdgeInsets.all(2),
//                                                                               alignment: Alignment.center,
//                                                                               width: size.width * 0.1,
//                                                                               height: 30,
//                                                                               decoration: BoxDecoration(
//                                                                                   // shape: BoxShape.circle,
//                                                                                   borderRadius: BorderRadius.circular(10),
//                                                                                   color: const Color.fromARGB(255, 130, 193, 245),
//                                                                                   gradient: const LinearGradient(
//                                                                                     colors: [
//                                                                                       Colors.red,
//                                                                                       Colors.red,
//                                                                                     ],
//                                                                                   )),
//                                                                               child: const Align(
//                                                                                   alignment: Alignment.center,
//                                                                                   child: Icon(
//                                                                                     Icons.remove_red_eye,
//                                                                                     color: Colors.white,
//                                                                                   )),
//                                                                             ),
//                                                                           ),
//                                                                         )
//                                                                       : (lCPWorkOrdersClosedViewModel.lcpWorkOrderClosedGetTabularData.data!.findAllTableData![index].maintType ==
//                                                                               'RegularMaint')
//                                                                           ? const Text(
//                                                                               "",
//                                                                               textAlign: TextAlign.left,
//                                                                               style: TextStyle(
//                                                                                 fontSize: 0,
//                                                                                 fontWeight: FontWeight.bold,
//                                                                                 color: AppColors.baseColor,
//                                                                               ),
//                                                                             )
//                                                                           : const Text(
//                                                                               "",
//                                                                               textAlign: TextAlign.left,
//                                                                               style: TextStyle(
//                                                                                 fontSize: 12,
//                                                                                 //  fontWeight:
//                                                                                 //      FontWeight.bold,
//                                                                                 color: Colors.white,
//                                                                               ),
//                                                                             )
//                                                         ],
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                               const Divider(
//                                                 color: Colors.grey,
//                                               ),
//                                               Padding(
//                                                 padding: const EdgeInsets.only(
//                                                     left: 8.0),
//                                                 child: Row(
//                                                   children: [
//                                                     Expanded(
//                                                       // alignment: Alignment.topLeft,
//                                                       child: Column(
//                                                         children: [
//                                                           const Align(
//                                                             alignment: Alignment
//                                                                 .topLeft,
//                                                             child: Text(
//                                                               "IVM TIMESHEET: ",
//                                                               textAlign:
//                                                                   TextAlign
//                                                                       .left,
//                                                               style: TextStyle(
//                                                                 fontSize: 12,
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .bold,
//                                                                 color: Colors
//                                                                     .white,
//                                                               ),
//                                                             ),
//                                                           ),
//                                                           (lCPWorkOrdersClosedViewModel
//                                                                       .lcpWorkOrderClosedGetTabularData
//                                                                       .data!
//                                                                       .findAllTableData![
//                                                                           index]
//                                                                       .ivmTimesheet
//                                                                       .toString() ==
//                                                                   'APPROVED')
//                                                               ? Align(
//                                                                   alignment:
//                                                                       Alignment
//                                                                           .topLeft,
//                                                                   child:
//                                                                       InkWell(
//                                                                     onTap: () {
//                                                                       Navigator.of(
//                                                                               context)
//                                                                           .push(
//                                                                               MaterialPageRoute(builder: (BuildContext context) => IVMTimeSheet(id: lCPWorkOrdersClosedViewModel.lcpWorkOrderClosedGetTabularData.data!.findAllTableData![index].id.toString())));
//                                                                     },
//                                                                     child:
//                                                                         Container(
//                                                                       padding:
//                                                                           const EdgeInsets
//                                                                               .all(
//                                                                               2),
//                                                                       alignment:
//                                                                           Alignment
//                                                                               .center,
//                                                                       width: size
//                                                                               .width *
//                                                                           0.1,
//                                                                       height:
//                                                                           30,
//                                                                       decoration: BoxDecoration(
//                                                                           // shape: BoxShape.circle,
//                                                                           borderRadius: BorderRadius.circular(10),
//                                                                           color: const Color.fromARGB(255, 130, 193, 245),
//                                                                           gradient: const LinearGradient(
//                                                                             colors: [
//                                                                               Colors.green,
//                                                                               Colors.green,
//                                                                             ],
//                                                                           )),
//                                                                       child: const Align(
//                                                                           alignment: Alignment.center,
//                                                                           child: Icon(
//                                                                             Icons.remove_red_eye,
//                                                                             color:
//                                                                                 Colors.white,
//                                                                           )),
//                                                                     ),
//                                                                   ),
//                                                                 )
//                                                               : (lCPWorkOrdersClosedViewModel
//                                                                           .lcpWorkOrderClosedGetTabularData
//                                                                           .data!
//                                                                           .findAllTableData![
//                                                                               index]
//                                                                           .ivmTimesheet
//                                                                           .toString() ==
//                                                                       'PENDING')
//                                                                   ? Align(
//                                                                       alignment:
//                                                                           Alignment
//                                                                               .topLeft,
//                                                                       child:
//                                                                           InkWell(
//                                                                         onTap:
//                                                                             () {
//                                                                           Navigator.of(context)
//                                                                               .push(MaterialPageRoute(builder: (BuildContext context) => IVMTimeSheet(id: lCPWorkOrdersClosedViewModel.lcpWorkOrderClosedGetTabularData.data!.findAllTableData![index].id.toString())));
//                                                                         },
//                                                                         child:
//                                                                             Container(
//                                                                           padding: const EdgeInsets
//                                                                               .all(
//                                                                               2),
//                                                                           alignment:
//                                                                               Alignment.center,
//                                                                           width:
//                                                                               size.width * 0.1,
//                                                                           height:
//                                                                               30,
//                                                                           decoration: BoxDecoration(
//                                                                               // shape: BoxShape.circle,
//                                                                               borderRadius: BorderRadius.circular(10),
//                                                                               color: const Color.fromARGB(255, 130, 193, 245),
//                                                                               gradient: const LinearGradient(
//                                                                                 colors: [
//                                                                                   Colors.orange,
//                                                                                   Colors.orange,
//                                                                                 ],
//                                                                               )),
//                                                                           child: const Align(
//                                                                               alignment: Alignment.center,
//                                                                               child: Icon(
//                                                                                 Icons.remove_red_eye,
//                                                                                 color: Colors.white,
//                                                                               )),
//                                                                         ),
//                                                                       ),
//                                                                     )
//                                                                   : (lCPWorkOrdersClosedViewModel
//                                                                               .lcpWorkOrderClosedGetTabularData
//                                                                               .data!
//                                                                               .findAllTableData![
//                                                                                   index]
//                                                                               .ivmTimesheet
//                                                                               .toString() ==
//                                                                           'REJECTED')
//                                                                       ? Align(
//                                                                           alignment:
//                                                                               Alignment.topLeft,
//                                                                           child:
//                                                                               InkWell(
//                                                                             onTap:
//                                                                                 () {
//                                                                               Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => IVMTimeSheet(id: lCPWorkOrdersClosedViewModel.lcpWorkOrderClosedGetTabularData.data!.findAllTableData![index].id.toString())));
//                                                                             },
//                                                                             child:
//                                                                                 Container(
//                                                                               padding: const EdgeInsets.all(2),
//                                                                               alignment: Alignment.center,
//                                                                               width: size.width * 0.1,
//                                                                               height: 30,
//                                                                               decoration: BoxDecoration(
//                                                                                   // shape: BoxShape.circle,
//                                                                                   borderRadius: BorderRadius.circular(10),
//                                                                                   color: const Color.fromARGB(255, 130, 193, 245),
//                                                                                   gradient: const LinearGradient(
//                                                                                     colors: [
//                                                                                       Colors.red,
//                                                                                       Colors.red,
//                                                                                     ],
//                                                                                   )),
//                                                                               child: const Align(
//                                                                                   alignment: Alignment.center,
//                                                                                   child: Icon(
//                                                                                     Icons.remove_red_eye,
//                                                                                     color: Colors.white,
//                                                                                   )),
//                                                                             ),
//                                                                           ),
//                                                                         )
//                                                                       : (lCPWorkOrdersClosedViewModel.lcpWorkOrderClosedGetTabularData.data!.findAllTableData![index].maintType ==
//                                                                               'RegularMaint')
//                                                                           ? const Text(
//                                                                               "",
//                                                                               textAlign: TextAlign.left,
//                                                                               style: TextStyle(
//                                                                                 fontSize: 0,
//                                                                                 fontWeight: FontWeight.bold,
//                                                                                 color: AppColors.baseColor,
//                                                                               ),
//                                                                             )
//                                                                           : const Text(
//                                                                               "",
//                                                                               textAlign: TextAlign.left,
//                                                                               style: TextStyle(
//                                                                                 fontSize: 12,
//                                                                                 //  fontWeight:
//                                                                                 //      FontWeight.bold,
//                                                                                 color: Colors.white,
//                                                                               ),
//                                                                             )
//                                                         ],
//                                                       ),
//                                                     ),
//                                                     Expanded(
//                                                       // alignment: Alignment.topLeft,
//                                                       child: Column(
//                                                         children: [
//                                                           const Align(
//                                                             alignment: Alignment
//                                                                 .topLeft,
//                                                             child: Text(
//                                                               "MIXING INVENTORY: ",
//                                                               textAlign:
//                                                                   TextAlign
//                                                                       .left,
//                                                               style: TextStyle(
//                                                                 fontSize: 12,
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .bold,
//                                                                 color: Colors
//                                                                     .white,
//                                                               ),
//                                                             ),
//                                                           ),
//                                                           (lCPWorkOrdersClosedViewModel
//                                                                       .lcpWorkOrderClosedGetTabularData
//                                                                       .data!
//                                                                       .findAllTableData![
//                                                                           index]
//                                                                       .mixingInventory
//                                                                       .toString() ==
//                                                                   'APPROVED')
//                                                               ? Align(
//                                                                   alignment:
//                                                                       Alignment
//                                                                           .topLeft,
//                                                                   child:
//                                                                       InkWell(
//                                                                     onTap: () {
//                                                                       Navigator.of(
//                                                                               context)
//                                                                           .push(
//                                                                               MaterialPageRoute(builder: (BuildContext context) => MixingInventory(id: lCPWorkOrdersClosedViewModel.lcpWorkOrderClosedGetTabularData.data!.findAllTableData![index].id.toString())));
//                                                                     },
//                                                                     child:
//                                                                         Container(
//                                                                       padding:
//                                                                           const EdgeInsets
//                                                                               .all(
//                                                                               2),
//                                                                       alignment:
//                                                                           Alignment
//                                                                               .center,
//                                                                       width: size
//                                                                               .width *
//                                                                           0.1,
//                                                                       height:
//                                                                           30,
//                                                                       decoration: BoxDecoration(
//                                                                           // shape: BoxShape.circle,
//                                                                           borderRadius: BorderRadius.circular(10),
//                                                                           color: const Color.fromARGB(255, 130, 193, 245),
//                                                                           gradient: const LinearGradient(
//                                                                             colors: [
//                                                                               Colors.green,
//                                                                               Colors.green,
//                                                                             ],
//                                                                           )),
//                                                                       child: const Align(
//                                                                           alignment: Alignment.center,
//                                                                           child: Icon(
//                                                                             Icons.remove_red_eye,
//                                                                             color:
//                                                                                 Colors.white,
//                                                                           )),
//                                                                     ),
//                                                                   ),
//                                                                 )
//                                                               : (lCPWorkOrdersClosedViewModel
//                                                                           .lcpWorkOrderClosedGetTabularData
//                                                                           .data!
//                                                                           .findAllTableData![
//                                                                               index]
//                                                                           .mixingInventory
//                                                                           .toString() ==
//                                                                       'PENDING')
//                                                                   ? Align(
//                                                                       alignment:
//                                                                           Alignment
//                                                                               .topLeft,
//                                                                       child:
//                                                                           InkWell(
//                                                                         onTap:
//                                                                             () {
//                                                                           Navigator.of(context)
//                                                                               .push(MaterialPageRoute(builder: (BuildContext context) => MixingInventory(id: lCPWorkOrdersClosedViewModel.lcpWorkOrderClosedGetTabularData.data!.findAllTableData![index].id.toString())));
//                                                                         },
//                                                                         child:
//                                                                             Container(
//                                                                           padding: const EdgeInsets
//                                                                               .all(
//                                                                               2),
//                                                                           alignment:
//                                                                               Alignment.center,
//                                                                           width:
//                                                                               size.width * 0.1,
//                                                                           height:
//                                                                               30,
//                                                                           decoration: BoxDecoration(
//                                                                               // shape: BoxShape.circle,
//                                                                               borderRadius: BorderRadius.circular(10),
//                                                                               color: const Color.fromARGB(255, 130, 193, 245),
//                                                                               gradient: const LinearGradient(
//                                                                                 colors: [
//                                                                                   Colors.orange,
//                                                                                   Colors.orange,
//                                                                                 ],
//                                                                               )),
//                                                                           child: const Align(
//                                                                               alignment: Alignment.center,
//                                                                               child: Icon(
//                                                                                 Icons.remove_red_eye,
//                                                                                 color: Colors.white,
//                                                                               )),
//                                                                         ),
//                                                                       ),
//                                                                     )
//                                                                   : (lCPWorkOrdersClosedViewModel
//                                                                               .lcpWorkOrderClosedGetTabularData
//                                                                               .data!
//                                                                               .findAllTableData![
//                                                                                   index]
//                                                                               .mixingInventory
//                                                                               .toString() ==
//                                                                           'REJECTED')
//                                                                       ? Align(
//                                                                           alignment:
//                                                                               Alignment.topLeft,
//                                                                           child:
//                                                                               InkWell(
//                                                                             onTap:
//                                                                                 () {
//                                                                               Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => MixingInventory(id: lCPWorkOrdersClosedViewModel.lcpWorkOrderClosedGetTabularData.data!.findAllTableData![index].id.toString())));
//                                                                             },
//                                                                             child:
//                                                                                 Container(
//                                                                               padding: const EdgeInsets.all(2),
//                                                                               alignment: Alignment.center,
//                                                                               width: size.width * 0.1,
//                                                                               height: 30,
//                                                                               decoration: BoxDecoration(
//                                                                                   // shape: BoxShape.circle,
//                                                                                   borderRadius: BorderRadius.circular(10),
//                                                                                   color: const Color.fromARGB(255, 130, 193, 245),
//                                                                                   gradient: const LinearGradient(
//                                                                                     colors: [
//                                                                                       Colors.red,
//                                                                                       Colors.red,
//                                                                                     ],
//                                                                                   )),
//                                                                               child: const Align(
//                                                                                   alignment: Alignment.center,
//                                                                                   child: Icon(
//                                                                                     Icons.remove_red_eye,
//                                                                                     color: Colors.white,
//                                                                                   )),
//                                                                             ),
//                                                                           ),
//                                                                         )
//                                                                       : (lCPWorkOrdersClosedViewModel.lcpWorkOrderClosedGetTabularData.data!.findAllTableData![index].maintType ==
//                                                                               'RegularMaint')
//                                                                           ? const Text(
//                                                                               "",
//                                                                               textAlign: TextAlign.left,
//                                                                               style: TextStyle(
//                                                                                 fontSize: 0,
//                                                                                 fontWeight: FontWeight.bold,
//                                                                                 color: AppColors.baseColor,
//                                                                               ),
//                                                                             )
//                                                                           : const Text(
//                                                                               "",
//                                                                               textAlign: TextAlign.left,
//                                                                               style: TextStyle(
//                                                                                 fontSize: 12,
//                                                                                 //  fontWeight:
//                                                                                 //      FontWeight.bold,
//                                                                                 color: Colors.white,
//                                                                               ),
//                                                                             )
//                                                         ],
//                                                       ),
//                                                     ),
//                                                     Expanded(
//                                                       // alignment: Alignment.topLeft,
//                                                       child: Column(
//                                                         children: [
//                                                           const Align(
//                                                             alignment: Alignment
//                                                                 .topLeft,
//                                                             child: Text(
//                                                               "SUBSTATION: ",
//                                                               textAlign:
//                                                                   TextAlign
//                                                                       .left,
//                                                               style: TextStyle(
//                                                                 fontSize: 12,
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .bold,
//                                                                 color: Colors
//                                                                     .white,
//                                                               ),
//                                                             ),
//                                                           ),
//                                                           Align(
//                                                             alignment: Alignment
//                                                                 .topLeft,
//                                                             child: Text(
//                                                               (lCPWorkOrdersClosedViewModel
//                                                                               .lcpWorkOrderClosedGetTabularData
//                                                                               .data!
//                                                                               .findAllTableData![
//                                                                                   index]
//                                                                               .substation ==
//                                                                           null ||
//                                                                       lCPWorkOrdersClosedViewModel
//                                                                               .lcpWorkOrderClosedGetTabularData
//                                                                               .data!
//                                                                               .findAllTableData![
//                                                                                   index]
//                                                                               .substation
//                                                                               .toString() ==
//                                                                           'null')
//                                                                   ? ''
//                                                                   : lCPWorkOrdersClosedViewModel
//                                                                       .lcpWorkOrderClosedGetTabularData
//                                                                       .data!
//                                                                       .findAllTableData![
//                                                                           index]
//                                                                       .substation
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
//                                                         ],
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                               const Divider(
//                                                 color: Colors.grey,
//                                               ),
//                                               Padding(
//                                                 padding: const EdgeInsets.only(
//                                                     left: 8.0),
//                                                 child: Row(
//                                                   children: [
//                                                     Expanded(
//                                                       // alignment: Alignment.topLeft,
//                                                       child: Column(
//                                                         children: [
//                                                           const Align(
//                                                             alignment: Alignment
//                                                                 .topLeft,
//                                                             child: Text(
//                                                               "FEEDER: ",
//                                                               textAlign:
//                                                                   TextAlign
//                                                                       .left,
//                                                               style: TextStyle(
//                                                                 fontSize: 12,
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .bold,
//                                                                 color: Colors
//                                                                     .white,
//                                                               ),
//                                                             ),
//                                                           ),
//                                                           Align(
//                                                             alignment: Alignment
//                                                                 .topLeft,
//                                                             child: Text(
//                                                               (lCPWorkOrdersClosedViewModel
//                                                                               .lcpWorkOrderClosedGetTabularData
//                                                                               .data!
//                                                                               .findAllTableData![
//                                                                                   index]
//                                                                               .fdrName ==
//                                                                           null ||
//                                                                       lCPWorkOrdersClosedViewModel
//                                                                               .lcpWorkOrderClosedGetTabularData
//                                                                               .data!
//                                                                               .findAllTableData![
//                                                                                   index]
//                                                                               .fdrName
//                                                                               .toString() ==
//                                                                           'null')
//                                                                   ? ''
//                                                                   : lCPWorkOrdersClosedViewModel
//                                                                       .lcpWorkOrderClosedGetTabularData
//                                                                       .data!
//                                                                       .findAllTableData![
//                                                                           index]
//                                                                       .fdrName
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
//                                                         ],
//                                                       ),
//                                                     ),
//                                                     Expanded(
//                                                       // alignment: Alignment.topLeft,
//                                                       child: Column(
//                                                         children: [
//                                                           const Align(
//                                                             alignment: Alignment
//                                                                 .topLeft,
//                                                             child: Text(
//                                                               "MAINTENANCE TYPE: ",
//                                                               textAlign:
//                                                                   TextAlign
//                                                                       .left,
//                                                               style: TextStyle(
//                                                                 fontSize: 12,
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .bold,
//                                                                 color: Colors
//                                                                     .white,
//                                                               ),
//                                                             ),
//                                                           ),
//                                                           Align(
//                                                             alignment: Alignment
//                                                                 .topLeft,
//                                                             child: Text(
//                                                               (lCPWorkOrdersClosedViewModel
//                                                                               .lcpWorkOrderClosedGetTabularData
//                                                                               .data!
//                                                                               .findAllTableData![
//                                                                                   index]
//                                                                               .type ==
//                                                                           null ||
//                                                                       lCPWorkOrdersClosedViewModel
//                                                                               .lcpWorkOrderClosedGetTabularData
//                                                                               .data!
//                                                                               .findAllTableData![
//                                                                                   index]
//                                                                               .type
//                                                                               .toString() ==
//                                                                           'null')
//                                                                   ? ''
//                                                                   : lCPWorkOrdersClosedViewModel
//                                                                       .lcpWorkOrderClosedGetTabularData
//                                                                       .data!
//                                                                       .findAllTableData![
//                                                                           index]
//                                                                       .type
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
//                                                         ],
//                                                       ),
//                                                     ),
//                                                     Expanded(
//                                                       // alignment: Alignment.topLeft,
//                                                       child: Column(
//                                                         children: [
//                                                           const Align(
//                                                             alignment: Alignment
//                                                                 .topLeft,
//                                                             child: Text(
//                                                               "CONTRACTOR: ",
//                                                               textAlign:
//                                                                   TextAlign
//                                                                       .left,
//                                                               style: TextStyle(
//                                                                 fontSize: 12,
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .bold,
//                                                                 color: Colors
//                                                                     .white,
//                                                               ),
//                                                             ),
//                                                           ),
//                                                           Align(
//                                                             alignment: Alignment
//                                                                 .topLeft,
//                                                             child: Text(
//                                                               (lCPWorkOrdersClosedViewModel
//                                                                               .lcpWorkOrderClosedGetTabularData
//                                                                               .data!
//                                                                               .findAllTableData![
//                                                                                   index]
//                                                                               .contractor ==
//                                                                           null ||
//                                                                       lCPWorkOrdersClosedViewModel
//                                                                               .lcpWorkOrderClosedGetTabularData
//                                                                               .data!
//                                                                               .findAllTableData![
//                                                                                   index]
//                                                                               .contractor
//                                                                               .toString() ==
//                                                                           'null')
//                                                                   ? ''
//                                                                   : lCPWorkOrdersClosedViewModel
//                                                                       .lcpWorkOrderClosedGetTabularData
//                                                                       .data!
//                                                                       .findAllTableData![
//                                                                           index]
//                                                                       .contractor
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
//                                                         ],
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                               const Divider(
//                                                 color: Colors.grey,
//                                               ),
//                                               Padding(
//                                                 padding: const EdgeInsets.only(
//                                                     left: 8.0),
//                                                 child: Row(
//                                                   children: [
//                                                     Expanded(
//                                                       // alignment: Alignment.topLeft,
//                                                       child: Column(
//                                                         children: [
//                                                           const Align(
//                                                             alignment: Alignment
//                                                                 .topLeft,
//                                                             child: Text(
//                                                               "TOTAL MILES: ",
//                                                               textAlign:
//                                                                   TextAlign
//                                                                       .left,
//                                                               style: TextStyle(
//                                                                 fontSize: 12,
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .bold,
//                                                                 color: Colors
//                                                                     .white,
//                                                               ),
//                                                             ),
//                                                           ),
//                                                           Align(
//                                                             alignment: Alignment
//                                                                 .topLeft,
//                                                             child: Text(
//                                                               (lCPWorkOrdersClosedViewModel
//                                                                               .lcpWorkOrderClosedGetTabularData
//                                                                               .data!
//                                                                               .findAllTableData![
//                                                                                   index]
//                                                                               .totalMiles ==
//                                                                           null ||
//                                                                       lCPWorkOrdersClosedViewModel
//                                                                               .lcpWorkOrderClosedGetTabularData
//                                                                               .data!
//                                                                               .findAllTableData![
//                                                                                   index]
//                                                                               .totalMiles
//                                                                               .toString() ==
//                                                                           'null')
//                                                                   ? ''
//                                                                   : lCPWorkOrdersClosedViewModel
//                                                                       .lcpWorkOrderClosedGetTabularData
//                                                                       .data!
//                                                                       .findAllTableData![
//                                                                           index]
//                                                                       .totalMiles
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
//                                                         ],
//                                                       ),
//                                                     ),
//                                                     Expanded(
//                                                       // alignment: Alignment.topLeft,
//                                                       child: Column(
//                                                         children: [
//                                                           const Align(
//                                                             alignment: Alignment
//                                                                 .topLeft,
//                                                             child: Text(
//                                                               "CONTRACT YEAR: ",
//                                                               textAlign:
//                                                                   TextAlign
//                                                                       .left,
//                                                               style: TextStyle(
//                                                                 fontSize: 12,
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .bold,
//                                                                 color: Colors
//                                                                     .white,
//                                                               ),
//                                                             ),
//                                                           ),
//                                                           Align(
//                                                             alignment: Alignment
//                                                                 .topLeft,
//                                                             child: Text(
//                                                               (lCPWorkOrdersClosedViewModel
//                                                                               .lcpWorkOrderClosedGetTabularData
//                                                                               .data!
//                                                                               .findAllTableData![
//                                                                                   index]
//                                                                               .contractYear ==
//                                                                           null ||
//                                                                       lCPWorkOrdersClosedViewModel
//                                                                               .lcpWorkOrderClosedGetTabularData
//                                                                               .data!
//                                                                               .findAllTableData![
//                                                                                   index]
//                                                                               .contractYear
//                                                                               .toString() ==
//                                                                           'null')
//                                                                   ? ''
//                                                                   : lCPWorkOrdersClosedViewModel
//                                                                       .lcpWorkOrderClosedGetTabularData
//                                                                       .data!
//                                                                       .findAllTableData![
//                                                                           index]
//                                                                       .contractYear
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
//                                                         ],
//                                                       ),
//                                                     ),
//                                                     Expanded(
//                                                       // alignment: Alignment.topLeft,
//                                                       child: Column(
//                                                         children: [
//                                                           const Align(
//                                                             alignment: Alignment
//                                                                 .topLeft,
//                                                             child: Text(
//                                                               "CYCLE: ",
//                                                               textAlign:
//                                                                   TextAlign
//                                                                       .left,
//                                                               style: TextStyle(
//                                                                 fontSize: 12,
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .bold,
//                                                                 color: Colors
//                                                                     .white,
//                                                               ),
//                                                             ),
//                                                           ),
//                                                           Align(
//                                                             alignment: Alignment
//                                                                 .topLeft,
//                                                             child: Text(
//                                                               (lCPWorkOrdersClosedViewModel
//                                                                               .lcpWorkOrderClosedGetTabularData
//                                                                               .data!
//                                                                               .findAllTableData![
//                                                                                   index]
//                                                                               .cycle ==
//                                                                           null ||
//                                                                       lCPWorkOrdersClosedViewModel
//                                                                               .lcpWorkOrderClosedGetTabularData
//                                                                               .data!
//                                                                               .findAllTableData![
//                                                                                   index]
//                                                                               .cycle
//                                                                               .toString() ==
//                                                                           'null')
//                                                                   ? ''
//                                                                   : lCPWorkOrdersClosedViewModel
//                                                                       .lcpWorkOrderClosedGetTabularData
//                                                                       .data!
//                                                                       .findAllTableData![
//                                                                           index]
//                                                                       .cycle
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
//                                                         ],
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                               const Divider(
//                                                 color: Colors.grey,
//                                               ),
//                                               Padding(
//                                                 padding: const EdgeInsets.only(
//                                                     left: 8.0),
//                                                 child: Row(
//                                                   children: [
//                                                     Expanded(
//                                                       // alignment: Alignment.topLeft,
//                                                       child: Column(
//                                                         children: [
//                                                           const Align(
//                                                             alignment: Alignment
//                                                                 .topLeft,
//                                                             child: Text(
//                                                               "SERVICE STREET ADDRESS: ",
//                                                               textAlign:
//                                                                   TextAlign
//                                                                       .left,
//                                                               style: TextStyle(
//                                                                 fontSize: 12,
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .bold,
//                                                                 color: Colors
//                                                                     .white,
//                                                               ),
//                                                             ),
//                                                           ),
//                                                           Align(
//                                                             alignment: Alignment
//                                                                 .topLeft,
//                                                             child: Text(
//                                                               (lCPWorkOrdersClosedViewModel
//                                                                               .lcpWorkOrderClosedGetTabularData
//                                                                               .data!
//                                                                               .findAllTableData![
//                                                                                   index]
//                                                                               .streetAddress ==
//                                                                           null ||
//                                                                       lCPWorkOrdersClosedViewModel
//                                                                               .lcpWorkOrderClosedGetTabularData
//                                                                               .data!
//                                                                               .findAllTableData![
//                                                                                   index]
//                                                                               .streetAddress
//                                                                               .toString() ==
//                                                                           'null')
//                                                                   ? ''
//                                                                   : lCPWorkOrdersClosedViewModel
//                                                                       .lcpWorkOrderClosedGetTabularData
//                                                                       .data!
//                                                                       .findAllTableData![
//                                                                           index]
//                                                                       .streetAddress
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
//                                                         ],
//                                                       ),
//                                                     ),
//                                                     Expanded(
//                                                       // alignment: Alignment.topLeft,
//                                                       child: Column(
//                                                         children: [
//                                                           const Align(
//                                                             alignment: Alignment
//                                                                 .topLeft,
//                                                             child: Text(
//                                                               "SERVICE MAP LOCATION: ",
//                                                               textAlign:
//                                                                   TextAlign
//                                                                       .left,
//                                                               style: TextStyle(
//                                                                 fontSize: 12,
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .bold,
//                                                                 color: Colors
//                                                                     .white,
//                                                               ),
//                                                             ),
//                                                           ),
//                                                           Align(
//                                                             alignment: Alignment
//                                                                 .topLeft,
//                                                             child: Text(
//                                                               (lCPWorkOrdersClosedViewModel
//                                                                               .lcpWorkOrderClosedGetTabularData
//                                                                               .data!
//                                                                               .findAllTableData![
//                                                                                   index]
//                                                                               .mapLocation ==
//                                                                           null ||
//                                                                       lCPWorkOrdersClosedViewModel
//                                                                               .lcpWorkOrderClosedGetTabularData
//                                                                               .data!
//                                                                               .findAllTableData![
//                                                                                   index]
//                                                                               .mapLocation
//                                                                               .toString() ==
//                                                                           'null')
//                                                                   ? ''
//                                                                   : lCPWorkOrdersClosedViewModel
//                                                                       .lcpWorkOrderClosedGetTabularData
//                                                                       .data!
//                                                                       .findAllTableData![
//                                                                           index]
//                                                                       .mapLocation
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
//                                                         ],
//                                                       ),
//                                                     ),
//                                                     Expanded(
//                                                       // alignment: Alignment.topLeft,
//                                                       child: Column(
//                                                         children: [
//                                                           const Align(
//                                                             alignment: Alignment
//                                                                 .topLeft,
//                                                             child: Text(
//                                                               "ADMIN NOTES 1: ",
//                                                               textAlign:
//                                                                   TextAlign
//                                                                       .left,
//                                                               style: TextStyle(
//                                                                 fontSize: 12,
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .bold,
//                                                                 color: Colors
//                                                                     .white,
//                                                               ),
//                                                             ),
//                                                           ),
//                                                           Align(
//                                                             alignment: Alignment
//                                                                 .topLeft,
//                                                             child: Text(
//                                                               (lCPWorkOrdersClosedViewModel
//                                                                               .lcpWorkOrderClosedGetTabularData
//                                                                               .data!
//                                                                               .findAllTableData![
//                                                                                   index]
//                                                                               .adminNotes1 ==
//                                                                           null ||
//                                                                       lCPWorkOrdersClosedViewModel
//                                                                               .lcpWorkOrderClosedGetTabularData
//                                                                               .data!
//                                                                               .findAllTableData![
//                                                                                   index]
//                                                                               .adminNotes1
//                                                                               .toString() ==
//                                                                           'null')
//                                                                   ? ''
//                                                                   : lCPWorkOrdersClosedViewModel
//                                                                       .lcpWorkOrderClosedGetTabularData
//                                                                       .data!
//                                                                       .findAllTableData![
//                                                                           index]
//                                                                       .adminNotes1
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
//                                                         ],
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                               const Divider(
//                                                 color: Colors.grey,
//                                               ),
//                                               Padding(
//                                                 padding: const EdgeInsets.only(
//                                                     left: 8.0),
//                                                 child: Row(
//                                                   children: [
//                                                     Expanded(
//                                                       // alignment: Alignment.topLeft,
//                                                       child: Column(
//                                                         children: [
//                                                           const Align(
//                                                             alignment: Alignment
//                                                                 .topLeft,
//                                                             child: Text(
//                                                               "CONTRACTOR NOTES: ",
//                                                               textAlign:
//                                                                   TextAlign
//                                                                       .left,
//                                                               style: TextStyle(
//                                                                 fontSize: 12,
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .bold,
//                                                                 color: Colors
//                                                                     .white,
//                                                               ),
//                                                             ),
//                                                           ),
//                                                           Align(
//                                                             alignment: Alignment
//                                                                 .topLeft,
//                                                             child: Text(
//                                                               (lCPWorkOrdersClosedViewModel
//                                                                               .lcpWorkOrderClosedGetTabularData
//                                                                               .data!
//                                                                               .findAllTableData![
//                                                                                   index]
//                                                                               .contractorNotes ==
//                                                                           null ||
//                                                                       lCPWorkOrdersClosedViewModel
//                                                                               .lcpWorkOrderClosedGetTabularData
//                                                                               .data!
//                                                                               .findAllTableData![
//                                                                                   index]
//                                                                               .contractorNotes
//                                                                               .toString() ==
//                                                                           'null')
//                                                                   ? ''
//                                                                   : lCPWorkOrdersClosedViewModel
//                                                                       .lcpWorkOrderClosedGetTabularData
//                                                                       .data!
//                                                                       .findAllTableData![
//                                                                           index]
//                                                                       .contractorNotes
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
//                                                         ],
//                                                       ),
//                                                     ),
//                                                     Expanded(
//                                                       // alignment: Alignment.topLeft,
//                                                       child: Column(
//                                                         children: [
//                                                           const Align(
//                                                             alignment: Alignment
//                                                                 .topLeft,
//                                                             child: Text(
//                                                               "ADMIN NOTES 2: ",
//                                                               textAlign:
//                                                                   TextAlign
//                                                                       .left,
//                                                               style: TextStyle(
//                                                                 fontSize: 12,
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .bold,
//                                                                 color: Colors
//                                                                     .white,
//                                                               ),
//                                                             ),
//                                                           ),
//                                                           Align(
//                                                             alignment: Alignment
//                                                                 .topLeft,
//                                                             child: Text(
//                                                               (lCPWorkOrdersClosedViewModel
//                                                                               .lcpWorkOrderClosedGetTabularData
//                                                                               .data!
//                                                                               .findAllTableData![
//                                                                                   index]
//                                                                               .adminNotes2 ==
//                                                                           null ||
//                                                                       lCPWorkOrdersClosedViewModel
//                                                                               .lcpWorkOrderClosedGetTabularData
//                                                                               .data!
//                                                                               .findAllTableData![
//                                                                                   index]
//                                                                               .adminNotes2
//                                                                               .toString() ==
//                                                                           'null')
//                                                                   ? ''
//                                                                   : lCPWorkOrdersClosedViewModel
//                                                                       .lcpWorkOrderClosedGetTabularData
//                                                                       .data!
//                                                                       .findAllTableData![
//                                                                           index]
//                                                                       .adminNotes2
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
//                                                         ],
//                                                       ),
//                                                     ),
//                                                     Expanded(
//                                                       // alignment: Alignment.topLeft,
//                                                       child: Column(
//                                                         children: [
//                                                           const Align(
//                                                             alignment: Alignment
//                                                                 .topLeft,
//                                                             child: Text(
//                                                               "CONTRACTOR COMPANY: ",
//                                                               textAlign:
//                                                                   TextAlign
//                                                                       .left,
//                                                               style: TextStyle(
//                                                                 fontSize: 12,
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .bold,
//                                                                 color: Colors
//                                                                     .white,
//                                                               ),
//                                                             ),
//                                                           ),
//                                                           Align(
//                                                             alignment: Alignment
//                                                                 .topLeft,
//                                                             child: Text(
//                                                               (lCPWorkOrdersClosedViewModel
//                                                                               .lcpWorkOrderClosedGetTabularData
//                                                                               .data!
//                                                                               .findAllTableData![
//                                                                                   index]
//                                                                               .contractorCompany ==
//                                                                           null ||
//                                                                       lCPWorkOrdersClosedViewModel
//                                                                               .lcpWorkOrderClosedGetTabularData
//                                                                               .data!
//                                                                               .findAllTableData![
//                                                                                   index]
//                                                                               .contractorCompany
//                                                                               .toString() ==
//                                                                           'null')
//                                                                   ? ''
//                                                                   : lCPWorkOrdersClosedViewModel
//                                                                       .lcpWorkOrderClosedGetTabularData
//                                                                       .data!
//                                                                       .findAllTableData![
//                                                                           index]
//                                                                       .contractorCompany
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
//                                                         ],
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                               const Divider(
//                                                 color: Colors.grey,
//                                               ),
//                                               Padding(
//                                                 padding: const EdgeInsets.only(
//                                                     left: 8.0),
//                                                 child: Row(
//                                                   children: [
//                                                     Expanded(
//                                                       // alignment: Alignment.topLeft,
//                                                       child: Column(
//                                                         children: [
//                                                           const Align(
//                                                             alignment: Alignment
//                                                                 .topLeft,
//                                                             child: Text(
//                                                               "DATE OF INSPECTION: ",
//                                                               textAlign:
//                                                                   TextAlign
//                                                                       .left,
//                                                               style: TextStyle(
//                                                                 fontSize: 12,
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .bold,
//                                                                 color: Colors
//                                                                     .white,
//                                                               ),
//                                                             ),
//                                                           ),
//                                                           Align(
//                                                             alignment: Alignment
//                                                                 .topLeft,
//                                                             child: Text(
//                                                               (lCPWorkOrdersClosedViewModel
//                                                                               .lcpWorkOrderClosedGetTabularData
//                                                                               .data!
//                                                                               .findAllTableData![
//                                                                                   index]
//                                                                               .dateOfInspection ==
//                                                                           null ||
//                                                                       lCPWorkOrdersClosedViewModel
//                                                                               .lcpWorkOrderClosedGetTabularData
//                                                                               .data!
//                                                                               .findAllTableData![
//                                                                                   index]
//                                                                               .dateOfInspection
//                                                                               .toString() ==
//                                                                           'null')
//                                                                   ? ''
//                                                                   : lCPWorkOrdersClosedViewModel
//                                                                       .lcpWorkOrderClosedGetTabularData
//                                                                       .data!
//                                                                       .findAllTableData![
//                                                                           index]
//                                                                       .dateOfInspection
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
//                                                         ],
//                                                       ),
//                                                     ),
//                                                     Expanded(
//                                                       // alignment: Alignment.topLeft,
//                                                       child: Column(
//                                                         children: [
//                                                           const Align(
//                                                             alignment: Alignment
//                                                                 .topLeft,
//                                                             child: Text(
//                                                               "FOLLOW UP DATE: ",
//                                                               textAlign:
//                                                                   TextAlign
//                                                                       .left,
//                                                               style: TextStyle(
//                                                                 fontSize: 12,
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .bold,
//                                                                 color: Colors
//                                                                     .white,
//                                                               ),
//                                                             ),
//                                                           ),
//                                                           Align(
//                                                             alignment: Alignment
//                                                                 .topLeft,
//                                                             child: Text(
//                                                               (lCPWorkOrdersClosedViewModel
//                                                                               .lcpWorkOrderClosedGetTabularData
//                                                                               .data!
//                                                                               .findAllTableData![
//                                                                                   index]
//                                                                               .followUpDate ==
//                                                                           null ||
//                                                                       lCPWorkOrdersClosedViewModel
//                                                                               .lcpWorkOrderClosedGetTabularData
//                                                                               .data!
//                                                                               .findAllTableData![
//                                                                                   index]
//                                                                               .followUpDate
//                                                                               .toString() ==
//                                                                           'null')
//                                                                   ? ''
//                                                                   : lCPWorkOrdersClosedViewModel
//                                                                       .lcpWorkOrderClosedGetTabularData
//                                                                       .data!
//                                                                       .findAllTableData![
//                                                                           index]
//                                                                       .followUpDate
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
//                                                         ],
//                                                       ),
//                                                     ),
//                                                     Expanded(
//                                                       // alignment: Alignment.topLeft,
//                                                       child: Column(
//                                                         children: [
//                                                           const Align(
//                                                             alignment: Alignment
//                                                                 .topLeft,
//                                                             child: Text(
//                                                               "COST PER MILE: ",
//                                                               textAlign:
//                                                                   TextAlign
//                                                                       .left,
//                                                               style: TextStyle(
//                                                                 fontSize: 12,
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .bold,
//                                                                 color: Colors
//                                                                     .white,
//                                                               ),
//                                                             ),
//                                                           ),
//                                                           Align(
//                                                             alignment: Alignment
//                                                                 .topLeft,
//                                                             child: Text(
//                                                               (lCPWorkOrdersClosedViewModel
//                                                                               .lcpWorkOrderClosedGetTabularData
//                                                                               .data!
//                                                                               .findAllTableData![
//                                                                                   index]
//                                                                               .costPerMile ==
//                                                                           null ||
//                                                                       lCPWorkOrdersClosedViewModel
//                                                                               .lcpWorkOrderClosedGetTabularData
//                                                                               .data!
//                                                                               .findAllTableData![
//                                                                                   index]
//                                                                               .costPerMile
//                                                                               .toString() ==
//                                                                           'null')
//                                                                   ? ''
//                                                                   : lCPWorkOrdersClosedViewModel
//                                                                       .lcpWorkOrderClosedGetTabularData
//                                                                       .data!
//                                                                       .findAllTableData![
//                                                                           index]
//                                                                       .costPerMile
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
//                                                         ],
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                               const Divider(
//                                                 color: Colors.grey,
//                                               ),
//                                               Padding(
//                                                 padding: const EdgeInsets.only(
//                                                     left: 8.0),
//                                                 child: Row(
//                                                   children: [
//                                                     Expanded(
//                                                       // alignment: Alignment.topLeft,
//                                                       child: Column(
//                                                         children: [
//                                                           const Align(
//                                                             alignment: Alignment
//                                                                 .topLeft,
//                                                             child: Text(
//                                                               "TOTAL COST: ",
//                                                               textAlign:
//                                                                   TextAlign
//                                                                       .left,
//                                                               style: TextStyle(
//                                                                 fontSize: 12,
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .bold,
//                                                                 color: Colors
//                                                                     .white,
//                                                               ),
//                                                             ),
//                                                           ),
//                                                           Align(
//                                                             alignment: Alignment
//                                                                 .topLeft,
//                                                             child: Text(
//                                                               (lCPWorkOrdersClosedViewModel
//                                                                               .lcpWorkOrderClosedGetTabularData
//                                                                               .data!
//                                                                               .findAllTableData![
//                                                                                   index]
//                                                                               .totalCost ==
//                                                                           null ||
//                                                                       lCPWorkOrdersClosedViewModel
//                                                                               .lcpWorkOrderClosedGetTabularData
//                                                                               .data!
//                                                                               .findAllTableData![
//                                                                                   index]
//                                                                               .totalCost
//                                                                               .toString() ==
//                                                                           'null')
//                                                                   ? ''
//                                                                   : lCPWorkOrdersClosedViewModel
//                                                                       .lcpWorkOrderClosedGetTabularData
//                                                                       .data!
//                                                                       .findAllTableData![
//                                                                           index]
//                                                                       .totalCost
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
//                                                         ],
//                                                       ),
//                                                     ),
//                                                     Expanded(
//                                                       // alignment: Alignment.topLeft,
//                                                       child: Column(
//                                                         children: [
//                                                           const Align(
//                                                             alignment: Alignment
//                                                                 .topLeft,
//                                                             child: Text(
//                                                               "NEXT MAINT DUE: ",
//                                                               textAlign:
//                                                                   TextAlign
//                                                                       .left,
//                                                               style: TextStyle(
//                                                                 fontSize: 12,
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .bold,
//                                                                 color: Colors
//                                                                     .white,
//                                                               ),
//                                                             ),
//                                                           ),
//                                                           Align(
//                                                             alignment: Alignment
//                                                                 .topLeft,
//                                                             child: Text(
//                                                               (lCPWorkOrdersClosedViewModel
//                                                                               .lcpWorkOrderClosedGetTabularData
//                                                                               .data!
//                                                                               .findAllTableData![
//                                                                                   index]
//                                                                               .nextMaintDue ==
//                                                                           null ||
//                                                                       lCPWorkOrdersClosedViewModel
//                                                                               .lcpWorkOrderClosedGetTabularData
//                                                                               .data!
//                                                                               .findAllTableData![
//                                                                                   index]
//                                                                               .nextMaintDue
//                                                                               .toString() ==
//                                                                           'null')
//                                                                   ? ''
//                                                                   : lCPWorkOrdersClosedViewModel
//                                                                       .lcpWorkOrderClosedGetTabularData
//                                                                       .data!
//                                                                       .findAllTableData![
//                                                                           index]
//                                                                       .nextMaintDue
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
//                                                         ],
//                                                       ),
//                                                     ),
//                                                     Expanded(
//                                                       // alignment: Alignment.topLeft,
//                                                       child: Column(
//                                                         children: [
//                                                           const Align(
//                                                             alignment: Alignment
//                                                                 .topLeft,
//                                                             child: Text(
//                                                               "CREATE DATE: ",
//                                                               textAlign:
//                                                                   TextAlign
//                                                                       .left,
//                                                               style: TextStyle(
//                                                                 fontSize: 12,
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .bold,
//                                                                 color: Colors
//                                                                     .white,
//                                                               ),
//                                                             ),
//                                                           ),
//                                                           Align(
//                                                             alignment: Alignment
//                                                                 .topLeft,
//                                                             child: Text(
//                                                               (lCPWorkOrdersClosedViewModel
//                                                                               .lcpWorkOrderClosedGetTabularData
//                                                                               .data!
//                                                                               .findAllTableData![
//                                                                                   index]
//                                                                               .createDate ==
//                                                                           null ||
//                                                                       lCPWorkOrdersClosedViewModel
//                                                                               .lcpWorkOrderClosedGetTabularData
//                                                                               .data!
//                                                                               .findAllTableData![index]
//                                                                               .createDate
//                                                                               .toString() ==
//                                                                           'null')
//                                                                   ? ''
//                                                                   : formattedDateCreateDate,
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
//                                                         ],
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                               const Divider(
//                                                 color: Colors.grey,
//                                               ),
//                                               Padding(
//                                                 padding: const EdgeInsets.only(
//                                                     left: 8.0),
//                                                 child: Row(
//                                                   children: [
//                                                     Expanded(
//                                                       // alignment: Alignment.topLeft,
//                                                       child: Column(
//                                                         children: [
//                                                           const Align(
//                                                             alignment: Alignment
//                                                                 .topLeft,
//                                                             child: Text(
//                                                               "ESTIMATED COST: ",
//                                                               textAlign:
//                                                                   TextAlign
//                                                                       .left,
//                                                               style: TextStyle(
//                                                                 fontSize: 12,
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .bold,
//                                                                 color: Colors
//                                                                     .white,
//                                                               ),
//                                                             ),
//                                                           ),
//                                                           Align(
//                                                             alignment: Alignment
//                                                                 .topLeft,
//                                                             child: Text(
//                                                               (lCPWorkOrdersClosedViewModel
//                                                                               .lcpWorkOrderClosedGetTabularData
//                                                                               .data!
//                                                                               .findAllTableData![
//                                                                                   index]
//                                                                               .estCost ==
//                                                                           null ||
//                                                                       lCPWorkOrdersClosedViewModel
//                                                                               .lcpWorkOrderClosedGetTabularData
//                                                                               .data!
//                                                                               .findAllTableData![
//                                                                                   index]
//                                                                               .estCost
//                                                                               .toString() ==
//                                                                           'null')
//                                                                   ? ''
//                                                                   : lCPWorkOrdersClosedViewModel
//                                                                       .lcpWorkOrderClosedGetTabularData
//                                                                       .data!
//                                                                       .findAllTableData![
//                                                                           index]
//                                                                       .estCost
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
//                                                         ],
//                                                       ),
//                                                     ),
//                                                     Expanded(
//                                                       // alignment: Alignment.topLeft,
//                                                       child: Column(
//                                                         children: [
//                                                           const Align(
//                                                             alignment: Alignment
//                                                                 .topLeft,
//                                                             child: Text(
//                                                               "ESTIMATED TIME: ",
//                                                               textAlign:
//                                                                   TextAlign
//                                                                       .left,
//                                                               style: TextStyle(
//                                                                 fontSize: 12,
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .bold,
//                                                                 color: Colors
//                                                                     .white,
//                                                               ),
//                                                             ),
//                                                           ),
//                                                           Align(
//                                                             alignment: Alignment
//                                                                 .topLeft,
//                                                             child: Text(
//                                                               (lCPWorkOrdersClosedViewModel
//                                                                               .lcpWorkOrderClosedGetTabularData
//                                                                               .data!
//                                                                               .findAllTableData![
//                                                                                   index]
//                                                                               .estTime ==
//                                                                           null ||
//                                                                       lCPWorkOrdersClosedViewModel
//                                                                               .lcpWorkOrderClosedGetTabularData
//                                                                               .data!
//                                                                               .findAllTableData![
//                                                                                   index]
//                                                                               .estTime
//                                                                               .toString() ==
//                                                                           'null')
//                                                                   ? ''
//                                                                   : lCPWorkOrdersClosedViewModel
//                                                                       .lcpWorkOrderClosedGetTabularData
//                                                                       .data!
//                                                                       .findAllTableData![
//                                                                           index]
//                                                                       .estTime
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
//                                                         ],
//                                                       ),
//                                                     ),
//                                                     Expanded(
//                                                       flex: 1,
//                                                       // alignment: Alignment.topLeft,
//                                                       child: Column(
//                                                         children: [
//                                                           const Align(
//                                                             alignment: Alignment
//                                                                 .topLeft,
//                                                             child: Text(
//                                                               "ACTUAL COST: ",
//                                                               textAlign:
//                                                                   TextAlign
//                                                                       .left,
//                                                               style: TextStyle(
//                                                                 fontSize: 12,
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .bold,
//                                                                 color: Colors
//                                                                     .white,
//                                                               ),
//                                                             ),
//                                                           ),
//                                                           Align(
//                                                             alignment: Alignment
//                                                                 .topLeft,
//                                                             child: Text(
//                                                               (lCPWorkOrdersClosedViewModel
//                                                                               .lcpWorkOrderClosedGetTabularData
//                                                                               .data!
//                                                                               .findAllTableData![
//                                                                                   index]
//                                                                               .actualCost ==
//                                                                           null ||
//                                                                       lCPWorkOrdersClosedViewModel
//                                                                               .lcpWorkOrderClosedGetTabularData
//                                                                               .data!
//                                                                               .findAllTableData![
//                                                                                   index]
//                                                                               .actualCost
//                                                                               .toString() ==
//                                                                           'null')
//                                                                   ? ''
//                                                                   : lCPWorkOrdersClosedViewModel
//                                                                       .lcpWorkOrderClosedGetTabularData
//                                                                       .data!
//                                                                       .findAllTableData![
//                                                                           index]
//                                                                       .actualCost
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
//                                                         ],
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                               const Divider(
//                                                 color: Colors.grey,
//                                               ),
//                                               Padding(
//                                                 padding: const EdgeInsets.only(
//                                                     left: 0.0),
//                                                 child: Row(
//                                                   children: [
//                                                     Expanded(
//                                                       // flex: 2,
//                                                       // alignment: Alignment.topLeft,
//                                                       child: Padding(
//                                                         padding:
//                                                             const EdgeInsets
//                                                                 .only(
//                                                                 left: 8.0),
//                                                         child: Row(
//                                                           children: [
//                                                             Expanded(
//                                                               //  flex: 3,
//                                                               child: Column(
//                                                                 children: [
//                                                                   InkWell(
//                                                                     onTap:
//                                                                         () async {
//                                                                       String
//                                                                           id =
//                                                                           '';
//                                                                       final userPreferences1 = Provider.of<
//                                                                               UserPref>(
//                                                                           context,
//                                                                           listen:
//                                                                               false);
//                                                                       UserModel
//                                                                           data =
//                                                                           await userPreferences1
//                                                                               .getUser();
//                                                                       id = data
//                                                                           .user!
//                                                                           .id
//                                                                           .toString();
//                                                                       // Navigator.of(
//                                                                       //         context)
//                                                                       //     .push(MaterialPageRoute(
//                                                                       //         builder: (BuildContext context) => MapViewAdmin(
//                                                                       //               id: lCPWorkOrdersClosedViewModel.lcpWorkOrderClosedGetTabularData.data!.findAllTableData![index].id.toString(),
//                                                                       //             )));
//                                                                       // Navigator
//                                                                       //     .push(
//                                                                       //   context,
//                                                                       //   MaterialPageRoute(
//                                                                       //     builder: (context) =>
//                                                                       //         MapViewPage(
//                                                                       //       url:
//                                                                       //           MapUrl.getAdminEndPoint(lCPWorkOrdersClosedViewModel.lcpWorkOrderClosedGetTabularData.data!.findAllTableData![index].tokenNo.toString(), id),
//                                                                       //     ),
//                                                                       //   ),
//                                                                       // );

//                                                                       await browser.open(
//                                                                           url: WebUri(
//                                                                               // "https://mapapi.ariespro.com/main/admin/CIVM_Map/${lCPWorkOrdersClosedViewModel.lcpWorkOrderClosedGetTabularData.data!.findAllTableData![index].tokenNo.toString()}/USRQWXH589Z"
//                                                                               MapUrl.getAdminEndPoint(lCPWorkOrdersClosedViewModel.lcpWorkOrderClosedGetTabularData.data!.findAllTableData![index].tokenNo.toString(),id)),
//                                                                           settings: ChromeSafariBrowserSettings(shareState: CustomTabsShareState.SHARE_STATE_OFF, barCollapsingEnabled: true));
//                                                                     },
//                                                                     child:
//                                                                         Align(
//                                                                       alignment:
//                                                                           Alignment
//                                                                               .centerLeft,
//                                                                       child:
//                                                                           Container(
//                                                                         // margin: const EdgeInsets.only(
//                                                                         //     left: 40, right: 40, bottom: 10.0),
//                                                                         padding: const EdgeInsets
//                                                                             .all(
//                                                                             8),
//                                                                         alignment:
//                                                                             Alignment.centerLeft,
//                                                                         width:
//                                                                             80,
//                                                                         // MediaQuery.of(context).size.width,
//                                                                         // height: MediaQuery.of(context).size.height * 0.4,
//                                                                         decoration: const BoxDecoration(
//                                                                             // shape: BoxShape.circle,

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
//                                                                             "VIEW MAP",
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
//                                                                 ],
//                                                               ),
//                                                             ),
//                                                           ],
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                             ]),
//                                           ),
//                                         ),
//                                       ],
//                                     );
//                                   }),
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

//   Future<void> _filterData(String query) async {
//     if (query.isEmpty) {
//       selectedSubstation = null;
//       selectedFeeder = null;
//       lCPWorkOrdersClosedViewModel.fetchLCPWorkOrderClosedTabularListApi(
//           context,
//           '',
//           '',
//           'CLOSED',
//           '',
//           widget.budgetType,
//           widget.maintenanceType,
//           '',
//           '');
//     } else {
//       lCPWorkOrdersClosedViewModel.lcpWorkOrderClosedGetTabularData.data!.findAllTableData = lCPWorkOrdersClosedViewModel
//           .lcpWorkOrderClosedGetTabularData.data!.findAllTableData
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

//   DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
//       value: item,
//       child: Text(item,
//           style: const TextStyle(
//             fontWeight: FontWeight.normal,
//             fontSize: 20,
//           )));

//   fetchData(String feeder, String substation, String contractorCompany) {
//     lCPWorkOrdersClosedViewModel.fetchLCPWorkOrderClosedTabularListApi(
//         context,
//         feeder,
//         substation,
//         'CLOSED',
//         '',
//         widget.budgetType,
//         widget.maintenanceType,
//         '',
//         '');
//   }

//   Future openDialogPicture(String tokenNo) => showDialog(
//         context: context,
//         builder: (context) {
//           return StatefulBuilder(builder: (context, setState) {
//             // lCPWorkOrdersClosedViewModel.fetchImageApi(
//             //     context,
//             //     //  '1');
//             //     tokenNo.toString());
//             int length =
//                 lCPWorkOrdersClosedViewModel.imageData.data?.images?.length ??
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
//         lCPWorkOrdersClosedViewModel.imageData.data?.images![i].imageLocation;

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
//         lCPWorkOrdersClosedViewModel.fetchLCPWorkOrderClosedTabularListApi(
//             context,
//             '',
//             '',
//             'CLOSED',
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

//   Future<void> openPdf(
//       String? tokenNo,
//       String? followUpDate,
//       String? substation,
//       String? contactorCompany,
//       String? mapLocation,
//       String? maintType,
//       String? contractorNotes,
//       String? dateOfInspection,
//       String? county,
//       String? contractor,
//       String? streetAddress,
//       String? type,
//       String? adminNotes1,
//       String? adminNotes2) async {
//     writeOnPdf(
//         tokenNo,
//         followUpDate,
//         substation,
//         contactorCompany,
//         mapLocation,
//         maintType,
//         contractorNotes,
//         dateOfInspection,
//         county,
//         contractor,
//         streetAddress,
//         type,
//         adminNotes1,
//         adminNotes2);

//     // final output = await getExternalStorageDirectory();
//     // final file = File("${output!.path}/example.pdf");
//     // OpenFile.open(file.path);
//     final output = await getExternalStorageDirectory();
//     final file = File("${output!.path}/report.pdf");
//     await file.writeAsBytes(await pdf.save());
//     OpenFile.open(file.path);
//   }

//   final pdf = pw.Document();
//   List<Map<String, dynamic>> tableData = [];
//   String total = '';
//   String laborTotal = '';
//   String invoiceTotal = '';
//   String invoiceData = '';
//   String formattedDate = '';

//   writeOnPdf(
//       String? tokenNo,
//       String? followUpDate,
//       String? substation,
//       String? contactorCompany,
//       String? mapLocation,
//       String? maintType,
//       String? contractorNotes,
//       String? dateOfInspection,
//       String? county,
//       String? contractor,
//       String? streetAddress,
//       String? type,
//       String? adminNotes1,
//       String? adminNotes2) async {
//     // final ByteData data = await rootBundle.load('assets/civm_logo.png');
//     // final Uint8List bytes = data.buffer.asUint8List();
//     // final image = img.decodeImage(bytes)!;
//     List<Map<String, dynamic>> tableData = [
//       {
//         'CHANGE ORDER NO.': tokenNo,
//         'FOLLOW UP DATE': followUpDate,
//         'SUBSTATION': substation,
//         'CONTRACTOR COMPANY': contactorCompany,
//         'MAP LOCATION': mapLocation,
//         'MAINTENANCE TYPE': maintType,
//         'CONTRACTOR NOTES': contractorNotes,
//         'DATE OF INSPECTION': dateOfInspection,
//         'COUNTY': county,
//         'CONTRACTOR': contractor,
//         'STREET ADDRESS': streetAddress,
//         'TYPE': type,
//         'ADMIN NOTES 1': adminNotes1,
//         'ADMIN NOTES 2': adminNotes2
//       },
//     ];

//     pdf.addPage(
//       pw.Page(
//         build: (pw.Context context) => pw.Center(
//           child: pw.Table.fromTextArray(
//             context: context,
//             cellAlignment: pw.Alignment.centerLeft,
//             headerDecoration: const pw.BoxDecoration(
//               color: PdfColors.grey,
//             ),
//             cellHeight: 30,
//             headerHeight: 40,
//             cellAlignments: {
//               0: pw.Alignment.center,
//             },
//             headerStyle:
//                 pw.TextStyle(fontSize: 30, fontWeight: pw.FontWeight.bold),
//             cellStyle: const pw.TextStyle(fontSize: 20),
//             headers: ['Change Order'], // A single header for the vertical table
//             data: tableData
//                 .expand((row) =>
//                     row.entries.map((entry) => [entry.key, entry.value]))
//                 .toList(),
//           ),
//         ),
//       ),
//     );
//   }

//   Future<String> savePdf(pw.Document pdf, String tokenNo) async {
//     final Directory appDocDir = await getApplicationDocumentsDirectory();
//     final String appDocPath = appDocDir.path;
//     final String pdfPath = '$appDocPath/your_invoice.pdf';
//     final File pdfFile = File(pdfPath);
//     await pdfFile.writeAsBytes(pdf.save() as List<int>);
//     OpenFile.open(pdfPath);
//     return pdfPath;
//   }
// // Future domnload(
//   //     Dio dio, String url, String savePath, int idNotification) async {
//   //   Map<String, dynamic> result = {
//   //     'isSuccess': false,
//   //     'filePath': null,
//   //     'error': null,
//   //     'id': null
//   //   };

//   //   result['id'] = idNotification;
//   //   setState(() {
//   //     _loading = true;
//   //   });
//   //   try {
//   //     Response response = await dio.get(url,
//   //         onReceiveProgress: showDownloadProgress,
//   //         options: Options(
//   //             responseType: ResponseType.bytes,
//   //             followRedirects: false,
//   //             validateStatus: (status) {
//   //               return status! < 500;
//   //             }));
//   //     if (response.statusCode == 200) {
//   //       setState(() {
//   //         _loading = false;
//   //       });
//   //       result['isSuccess'] = response.statusCode == 200;
//   //       result['filePath'] = savePath;
//   //     } else {
//   //       setState(() {
//   //         _loading = false;
//   //       });
//   //     }

//   //     File file = File(savePath);
//   //     var raf = file.openSync(mode: FileMode.write);
//   //     raf.writeFromSync(response.data);

//   //     await raf.close();
//   //   } catch (e) {
//   //     result['error'] = e.toString();
//   //   } finally {
//   //     setState(() {
//   //       _loading = false;
//   //       percentDownload = "";
//   //     });

//   //     showNotifcation(result);
//   //   }
//   // }
// }
