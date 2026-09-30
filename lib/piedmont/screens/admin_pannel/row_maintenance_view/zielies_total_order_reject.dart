// import 'dart:io';
// import 'package:CIVM/piedmont/resources/app_colors.dart';
// import 'package:CIVM/piedmont/data/response/status.dart';
// import 'package:CIVM/piedmont/repository/map_url.dart';
// import 'package:CIVM/piedmont/screens/admin_pannel/row_maintenance_view/pdf_view.dart';
// import 'package:CIVM/piedmont/screens/my_chrome_safari_map_recording.dart';
// import 'package:CIVM/piedmont/screens/video_folder/fullVideo/full_screen_video_player.dart';
// // import 'package:CIVM/piedmont/screens/admin_pannel/map_view_admin.dart';
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
// import '../../../view_model/lcp_work_order_reject_view_model.dart';
// import 'package:http/http.dart' as http;

// // ignore: must_be_immutable
// class ZIELIESTotalOrderReject extends StatefulWidget {
//   String budgetType;
//   String maintenanceType;
//   String heading;

//   ZIELIESTotalOrderReject(
//       {Key? key,
//       required this.budgetType,
//       required this.maintenanceType,
//       required this.heading})
//       : super(key: key);

//   @override
//   State<ZIELIESTotalOrderReject> createState() =>
//       _ZIELIESTotalOrderRejectState();
// }

// class _ZIELIESTotalOrderRejectState extends State<ZIELIESTotalOrderReject> {
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
//   final TextEditingController _input = TextEditingController();
//   LCPWorkOrderRejectViewModel lCPWorkOrderRejectViewModel =
//       LCPWorkOrderRejectViewModel();
//   String formattedContractYear = '';
//   String formattedNextMaintDue = '';

//   @override
//   void initState() {
//     lCPWorkOrderRejectViewModel.fetchLCPWorkOrderRejectTabularListApi(
//         context,
//         '',
//         '',
//         'REJECTED',
//         'PEMC',
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
//             '${widget.heading} - Total Inspection (Reject)',
//             style: const TextStyle(color: Colors.white),
//           ),
//           backgroundColor: AppColors.baseColor,
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
//         body: ChangeNotifierProvider<LCPWorkOrderRejectViewModel>(
//             create: (BuildContext context) => lCPWorkOrderRejectViewModel,
//             child: Consumer<LCPWorkOrderRejectViewModel>(
//                 builder: (context, value, _) {
//               switch (value.lcpWorkOrderRejectGetTabularData.status) {
//                 case Status.LOADING:
//                   return const Center(child: CircularProgressIndicator());
//                 case Status.ERROR:
//                   return
//                       // CustomToastSnackBarProgressDialog.flushBarErrorMessage(
//                       //     value.lcpWorkOrderRejectGetTabularData.message.toString(),
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
//                       await lCPWorkOrderRejectViewModel
//                           .fetchLCPWorkOrderRejectTabularListApi(
//                               context,
//                               '',
//                               '',
//                               'REJECTED',
//                               'PEMC',
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
//                                           items: lCPWorkOrderRejectViewModel
//                                               .lcpWorkOrderRejectGetTabularData
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
//                                             if (selectedFeeder != null) {
//                                               selectedFeeder = null;
//                                             }
//                                             print('val');
//                                             print(val);
//                                             fetchData('', val!, 'REJECTED');
//                                             substationId = int.parse(val);
//                                             print('111111111111111');
//                                             print(substationId);
//                                             setState(() {
//                                               selectedSubstation = val;
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
//                                           dropdownColor: Colors.white,
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
//                                           items: lCPWorkOrderRejectViewModel
//                                               .lcpWorkOrderRejectGetTabularData
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
//                                             fetchData(
//                                                 val!,
//                                                 substationId.toString(),
//                                                 'REJECTED');
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
//                                 "TOTAL NO OF RECORDS : ${lCPWorkOrderRejectViewModel.lcpWorkOrderRejectGetTabularData.data!.findAllTableData!.length.toString()}",
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
//                                 itemCount: lCPWorkOrderRejectViewModel
//                                     .lcpWorkOrderRejectGetTabularData
//                                     .data!
//                                     .findAllTableData!
//                                     .length,
//                                 itemBuilder: (BuildContext ctxt, int index) {
//                                   String? dateStringCreateDate =
//                                       lCPWorkOrderRejectViewModel
//                                           .lcpWorkOrderRejectGetTabularData
//                                           .data!
//                                           .findAllTableData![index]
//                                           .createDate
//                                           .toString();
//                                   DateTime date =
//                                       DateTime.parse(dateStringCreateDate);
//                                   String formattedDateCreateDate =
//                                       DateFormat('MM/dd/yyyy').format(date);

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
//                                                               await lCPWorkOrderRejectViewModel
//                                                                   .fetchImageApi(
//                                                                 context,
//                                                                 lCPWorkOrderRejectViewModel
//                                                                     .lcpWorkOrderRejectGetTabularData
//                                                                     .data!
//                                                                     .findAllTableData![
//                                                                         index]
//                                                                     .id
//                                                                     .toString(),
//                                                               );
//                                                               await Future.delayed(
//                                                                   const Duration(
//                                                                       seconds:
//                                                                           2));
//                                                               openDialogPicture(
//                                                                   lCPWorkOrderRejectViewModel
//                                                                       .lcpWorkOrderRejectGetTabularData
//                                                                       .data!
//                                                                       .findAllTableData![
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
//                                                             (lCPWorkOrderRejectViewModel
//                                                                             .lcpWorkOrderRejectGetTabularData
//                                                                             .data!
//                                                                             .findAllTableData![
//                                                                                 index]
//                                                                             .maintType ==
//                                                                         null ||
//                                                                     lCPWorkOrderRejectViewModel
//                                                                             .lcpWorkOrderRejectGetTabularData
//                                                                             .data!
//                                                                             .findAllTableData![
//                                                                                 index]
//                                                                             .maintType
//                                                                             .toString() ==
//                                                                         'null')
//                                                                 ? ''
//                                                                 : lCPWorkOrderRejectViewModel
//                                                                     .lcpWorkOrderRejectGetTabularData
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
//                                                             (lCPWorkOrderRejectViewModel
//                                                                             .lcpWorkOrderRejectGetTabularData
//                                                                             .data!
//                                                                             .findAllTableData![
//                                                                                 index]
//                                                                             .tokenNo ==
//                                                                         null ||
//                                                                     lCPWorkOrderRejectViewModel
//                                                                             .lcpWorkOrderRejectGetTabularData
//                                                                             .data!
//                                                                             .findAllTableData![
//                                                                                 index]
//                                                                             .tokenNo
//                                                                             .toString() ==
//                                                                         'null')
//                                                                 ? ''
//                                                                 : lCPWorkOrderRejectViewModel
//                                                                     .lcpWorkOrderRejectGetTabularData
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
//                                                         Align(
//                                                           alignment:
//                                                               Alignment.topLeft,
//                                                           child: Text(
//                                                             (lCPWorkOrderRejectViewModel
//                                                                             .lcpWorkOrderRejectGetTabularData
//                                                                             .data!
//                                                                             .findAllTableData![
//                                                                                 index]
//                                                                             .status ==
//                                                                         null ||
//                                                                     lCPWorkOrderRejectViewModel
//                                                                             .lcpWorkOrderRejectGetTabularData
//                                                                             .data!
//                                                                             .findAllTableData![
//                                                                                 index]
//                                                                             .status
//                                                                             .toString() ==
//                                                                         'null')
//                                                                 ? ''
//                                                                 : lCPWorkOrderRejectViewModel
//                                                                     .lcpWorkOrderRejectGetTabularData
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
//                                                             (lCPWorkOrderRejectViewModel
//                                                                             .lcpWorkOrderRejectGetTabularData
//                                                                             .data!
//                                                                             .findAllTableData![
//                                                                                 index]
//                                                                             .substation ==
//                                                                         null ||
//                                                                     lCPWorkOrderRejectViewModel
//                                                                             .lcpWorkOrderRejectGetTabularData
//                                                                             .data!
//                                                                             .findAllTableData![
//                                                                                 index]
//                                                                             .substation
//                                                                             .toString() ==
//                                                                         'null')
//                                                                 ? ''
//                                                                 : lCPWorkOrderRejectViewModel
//                                                                     .lcpWorkOrderRejectGetTabularData
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
//                                                             (lCPWorkOrderRejectViewModel
//                                                                             .lcpWorkOrderRejectGetTabularData
//                                                                             .data!
//                                                                             .findAllTableData![
//                                                                                 index]
//                                                                             .fdrName ==
//                                                                         null ||
//                                                                     lCPWorkOrderRejectViewModel
//                                                                             .lcpWorkOrderRejectGetTabularData
//                                                                             .data!
//                                                                             .findAllTableData![
//                                                                                 index]
//                                                                             .fdrName
//                                                                             .toString() ==
//                                                                         'null')
//                                                                 ? ''
//                                                                 : lCPWorkOrderRejectViewModel
//                                                                     .lcpWorkOrderRejectGetTabularData
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
//                                                   (widget.heading == "IVM" ||
//                                                           widget.heading ==
//                                                               "Mid Cycle")
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
//                                                                   (lCPWorkOrderRejectViewModel.lcpWorkOrderRejectGetTabularData.data!.findAllTableData![index].type ==
//                                                                               null ||
//                                                                           lCPWorkOrderRejectViewModel.lcpWorkOrderRejectGetTabularData.data!.findAllTableData![index].type.toString() ==
//                                                                               'null')
//                                                                       ? ''
//                                                                       : lCPWorkOrderRejectViewModel
//                                                                           .lcpWorkOrderRejectGetTabularData
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
//                                                       : SizedBox(),
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
//                                                             (lCPWorkOrderRejectViewModel
//                                                                             .lcpWorkOrderRejectGetTabularData
//                                                                             .data!
//                                                                             .findAllTableData![
//                                                                                 index]
//                                                                             .contractor ==
//                                                                         null ||
//                                                                     lCPWorkOrderRejectViewModel
//                                                                             .lcpWorkOrderRejectGetTabularData
//                                                                             .data!
//                                                                             .findAllTableData![
//                                                                                 index]
//                                                                             .contractor
//                                                                             .toString() ==
//                                                                         'null')
//                                                                 ? ''
//                                                                 : lCPWorkOrderRejectViewModel
//                                                                     .lcpWorkOrderRejectGetTabularData
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
//                                                   (widget.heading == "IVM" ||
//                                                           widget.heading ==
//                                                               "Mid Cycle")
//                                                       ? Expanded(
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
//                                                                   (lCPWorkOrderRejectViewModel.lcpWorkOrderRejectGetTabularData.data!.findAllTableData![index].totalMiles ==
//                                                                               null ||
//                                                                           lCPWorkOrderRejectViewModel.lcpWorkOrderRejectGetTabularData.data!.findAllTableData![index].totalMiles.toString() ==
//                                                                               'null')
//                                                                       ? ''
//                                                                       : lCPWorkOrderRejectViewModel
//                                                                           .lcpWorkOrderRejectGetTabularData
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
//                                                       : SizedBox(),
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
//                                                             (lCPWorkOrderRejectViewModel
//                                                                             .lcpWorkOrderRejectGetTabularData
//                                                                             .data!
//                                                                             .findAllTableData![
//                                                                                 index]
//                                                                             .contractYear ==
//                                                                         null ||
//                                                                     lCPWorkOrderRejectViewModel
//                                                                             .lcpWorkOrderRejectGetTabularData
//                                                                             .data!
//                                                                             .findAllTableData![index]
//                                                                             .contractYear
//                                                                             .toString() ==
//                                                                         'null')
//                                                                 ? ''
//                                                                 : formattedContractYear,
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
//                                                             (lCPWorkOrderRejectViewModel
//                                                                             .lcpWorkOrderRejectGetTabularData
//                                                                             .data!
//                                                                             .findAllTableData![
//                                                                                 index]
//                                                                             .contractorCompany ==
//                                                                         null ||
//                                                                     lCPWorkOrderRejectViewModel
//                                                                             .lcpWorkOrderRejectGetTabularData
//                                                                             .data!
//                                                                             .findAllTableData![
//                                                                                 index]
//                                                                             .contractorCompany
//                                                                             .toString() ==
//                                                                         'null')
//                                                                 ? ''
//                                                                 : lCPWorkOrderRejectViewModel
//                                                                     .lcpWorkOrderRejectGetTabularData
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
//                                                             (lCPWorkOrderRejectViewModel
//                                                                             .lcpWorkOrderRejectGetTabularData
//                                                                             .data!
//                                                                             .findAllTableData![
//                                                                                 index]
//                                                                             .createDate ==
//                                                                         null ||
//                                                                     lCPWorkOrderRejectViewModel
//                                                                             .lcpWorkOrderRejectGetTabularData
//                                                                             .data!
//                                                                             .findAllTableData![index]
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
//                                             (widget.heading == 'CO')
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
//                                                                       (lCPWorkOrderRejectViewModel.lcpWorkOrderRejectGetTabularData.data!.findAllTableData![index].streetAddress == null ||
//                                                                               lCPWorkOrderRejectViewModel.lcpWorkOrderRejectGetTabularData.data!.findAllTableData![index].streetAddress.toString() ==
//                                                                                   'null')
//                                                                           ? ''
//                                                                           : lCPWorkOrderRejectViewModel
//                                                                               .lcpWorkOrderRejectGetTabularData
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
//                                                                       (lCPWorkOrderRejectViewModel.lcpWorkOrderRejectGetTabularData.data!.findAllTableData![index].mapLocation == null ||
//                                                                               lCPWorkOrderRejectViewModel.lcpWorkOrderRejectGetTabularData.data!.findAllTableData![index].mapLocation.toString() ==
//                                                                                   'null')
//                                                                           ? ''
//                                                                           : lCPWorkOrderRejectViewModel
//                                                                               .lcpWorkOrderRejectGetTabularData
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
//                                                                       (lCPWorkOrderRejectViewModel.lcpWorkOrderRejectGetTabularData.data!.findAllTableData![index].adminNotes1 == null ||
//                                                                               lCPWorkOrderRejectViewModel.lcpWorkOrderRejectGetTabularData.data!.findAllTableData![index].adminNotes1.toString() ==
//                                                                                   'null')
//                                                                           ? ''
//                                                                           : lCPWorkOrderRejectViewModel
//                                                                               .lcpWorkOrderRejectGetTabularData
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
//                                             Padding(
//                                               padding: const EdgeInsets.only(
//                                                   left: 8.0),
//                                               child: (widget.heading == 'CO')
//                                                   ? Column(
//                                                       children: [
//                                                         const Divider(
//                                                           color: Colors.grey,
//                                                         ),
//                                                         Row(
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
//                                                                       (lCPWorkOrderRejectViewModel.lcpWorkOrderRejectGetTabularData.data!.findAllTableData![index].dateOfInspection == null ||
//                                                                               lCPWorkOrderRejectViewModel.lcpWorkOrderRejectGetTabularData.data!.findAllTableData![index].dateOfInspection.toString() ==
//                                                                                   'null')
//                                                                           ? ''
//                                                                           : lCPWorkOrderRejectViewModel
//                                                                               .lcpWorkOrderRejectGetTabularData
//                                                                               .data!
//                                                                               .findAllTableData![index]
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
//                                                                       (lCPWorkOrderRejectViewModel.lcpWorkOrderRejectGetTabularData.data!.findAllTableData![index].followUpDate == null ||
//                                                                               lCPWorkOrderRejectViewModel.lcpWorkOrderRejectGetTabularData.data!.findAllTableData![index].followUpDate.toString() ==
//                                                                                   'null')
//                                                                           ? ''
//                                                                           : lCPWorkOrderRejectViewModel
//                                                                               .lcpWorkOrderRejectGetTabularData
//                                                                               .data!
//                                                                               .findAllTableData![index]
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
//                                                                       (lCPWorkOrderRejectViewModel.lcpWorkOrderRejectGetTabularData.data!.findAllTableData![index].estTime == null ||
//                                                                               lCPWorkOrderRejectViewModel.lcpWorkOrderRejectGetTabularData.data!.findAllTableData![index].estTime.toString() ==
//                                                                                   'null')
//                                                                           ? ''
//                                                                           : lCPWorkOrderRejectViewModel
//                                                                               .lcpWorkOrderRejectGetTabularData
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
//                                                       ],
//                                                     )
//                                                   : const Text(
//                                                       "",
//                                                       textAlign: TextAlign.left,
//                                                       style: TextStyle(
//                                                         fontSize: 0,
//                                                         fontWeight:
//                                                             FontWeight.bold,
//                                                         color: Colors.white,
//                                                       ),
//                                                     ),
//                                             ),
//                                             (widget.heading != 'CO')
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
//                                                                       "TOTAL COST: ",
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
//                                                                       (lCPWorkOrderRejectViewModel.lcpWorkOrderRejectGetTabularData.data!.findAllTableData![index].totalCost == null ||
//                                                                               lCPWorkOrderRejectViewModel.lcpWorkOrderRejectGetTabularData.data!.findAllTableData![index].totalCost.toString() ==
//                                                                                   'null')
//                                                                           ? ''
//                                                                           : lCPWorkOrderRejectViewModel
//                                                                               .lcpWorkOrderRejectGetTabularData
//                                                                               .data!
//                                                                               .findAllTableData![index]
//                                                                               .totalCost
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
//                                                             (widget.heading ==
//                                                                         "IVM" ||
//                                                                     widget.heading ==
//                                                                         "Mid Cycle")
//                                                                 ? Expanded(
//                                                                     // alignment: Alignment.topLeft,
//                                                                     child:
//                                                                         Column(
//                                                                       children: [
//                                                                         const Align(
//                                                                           alignment:
//                                                                               Alignment.topLeft,
//                                                                           child:
//                                                                               Text(
//                                                                             "COST PER MILE: ",
//                                                                             textAlign:
//                                                                                 TextAlign.left,
//                                                                             style:
//                                                                                 TextStyle(
//                                                                               fontSize: 12,
//                                                                               fontWeight: FontWeight.bold,
//                                                                               color: Colors.white,
//                                                                             ),
//                                                                           ),
//                                                                         ),
//                                                                         Align(
//                                                                           alignment:
//                                                                               Alignment.topLeft,
//                                                                           child:
//                                                                               Text(
//                                                                             (lCPWorkOrderRejectViewModel.lcpWorkOrderRejectGetTabularData.data!.findAllTableData![index].costPerMile == null || lCPWorkOrderRejectViewModel.lcpWorkOrderRejectGetTabularData.data!.findAllTableData![index].costPerMile.toString() == 'null')
//                                                                                 ? ''
//                                                                                 : lCPWorkOrderRejectViewModel.lcpWorkOrderRejectGetTabularData.data!.findAllTableData![index].costPerMile.toString(),
//                                                                             textAlign:
//                                                                                 TextAlign.left,
//                                                                             style:
//                                                                                 const TextStyle(
//                                                                               fontSize: 12,
//                                                                               //  fontWeight:
//                                                                               //      FontWeight.bold,
//                                                                               color: Colors.white,
//                                                                             ),
//                                                                           ),
//                                                                         ),
//                                                                       ],
//                                                                     ),
//                                                                   )
//                                                                 : SizedBox(),
//                                                             Expanded(
//                                                               // alignment: Alignment.topLeft,
//                                                               child: Column(
//                                                                 children: [
//                                                                   const Align(
//                                                                     alignment:
//                                                                         Alignment
//                                                                             .topLeft,
//                                                                     child: Text(
//                                                                       "CYCLE: ",
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
//                                                                       (lCPWorkOrderRejectViewModel.lcpWorkOrderRejectGetTabularData.data!.findAllTableData![index].cycle == null ||
//                                                                               lCPWorkOrderRejectViewModel.lcpWorkOrderRejectGetTabularData.data!.findAllTableData![index].cycle.toString() ==
//                                                                                   'null')
//                                                                           ? ''
//                                                                           : lCPWorkOrderRejectViewModel
//                                                                               .lcpWorkOrderRejectGetTabularData
//                                                                               .data!
//                                                                               .findAllTableData![index]
//                                                                               .cycle
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
//                                             const Divider(
//                                               color: Colors.grey,
//                                             ),
//                                             Padding(
//                                               padding: const EdgeInsets.only(
//                                                   left: 8.0),
//                                               child: Row(
//                                                 children: [
//                                                   (widget.heading != 'CO')
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
//                                                                   (lCPWorkOrderRejectViewModel.lcpWorkOrderRejectGetTabularData.data!.findAllTableData![index].nextMaintDue ==
//                                                                               null ||
//                                                                           lCPWorkOrderRejectViewModel.lcpWorkOrderRejectGetTabularData.data!.findAllTableData![index].nextMaintDue.toString() ==
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
//                                                     flex: 2,
//                                                     child: InkWell(
//                                                       onTap: () async {
//                                                         String id = '';
//                                                         final userPreferences1 =
//                                                             Provider.of<
//                                                                     UserPref>(
//                                                                 context,
//                                                                 listen: false);
//                                                         UserModel data =
//                                                             await userPreferences1
//                                                                 .getUser();
//                                                         id = data.user!.id
//                                                             .toString();
//                                                         // Navigator.of(context).push(
//                                                         //     MaterialPageRoute(
//                                                         //         builder: (BuildContext
//                                                         //                 context) =>
//                                                         //             MapViewAdmin(
//                                                         //               id: lCPWorkOrderRejectViewModel
//                                                         //                   .lcpWorkOrderRejectGetTabularData
//                                                         //                   .data!
//                                                         //                   .findAllTableData![
//                                                         //                       index]
//                                                         //                   .id
//                                                         //                   .toString(),
//                                                         //             )));
//                                                         // Navigator.push(
//                                                         //   context,
//                                                         //   MaterialPageRoute(
//                                                         //     builder:
//                                                         //         (context) =>
//                                                         //             MapViewPage(
//                                                         //       url: MapUrl.getAdminEndPoint(
//                                                         //           lCPWorkOrderRejectViewModel
//                                                         //               .lcpWorkOrderRejectGetTabularData
//                                                         //               .data!
//                                                         //               .findAllTableData![
//                                                         //                   index]
//                                                         //               .tokenNo
//                                                         //               .toString(),
//                                                         //           id),
//                                                         //     ),
//                                                         //   ),
//                                                         // );

//                                                         await browser.open(
//                                                             url: WebUri(
//                                                                 // "https://mapapi.ariespro.com/main/admin/CIVM_Map/${lCPWorkOrderRejectViewModel.lcpWorkOrderRejectGetTabularData.data!.findAllTableData![index].tokenNo.toString()}/USRQWXH589Z"),
//                                                                 MapUrl.getAdminEndPoint(lCPWorkOrderRejectViewModel
//                                                                     .lcpWorkOrderRejectGetTabularData
//                                                                     .data!
//                                                                     .findAllTableData![
//                                                                         index]
//                                                                     .tokenNo
//                                                                     .toString(),id)),
//                                                             settings: ChromeSafariBrowserSettings(
//                                                                 shareState:
//                                                                     CustomTabsShareState
//                                                                         .SHARE_STATE_OFF,
//                                                                 barCollapsingEnabled:
//                                                                     true));
//                                                       },
//                                                       child: Align(
//                                                         alignment: Alignment
//                                                             .centerLeft,
//                                                         child: Container(
//                                                           // margin: const EdgeInsets.only(
//                                                           //     left: 40, right: 40, bottom: 10.0),
//                                                           padding:
//                                                               const EdgeInsets
//                                                                   .all(8),
//                                                           alignment: Alignment
//                                                               .centerLeft,
//                                                           width: 80,
//                                                           // MediaQuery.of(context).size.width,
//                                                           // height: MediaQuery.of(context).size.height * 0.4,
//                                                           decoration:
//                                                               const BoxDecoration(
//                                                                   // shape: BoxShape.circle,

//                                                                   color: Color
//                                                                       .fromARGB(
//                                                                           255,
//                                                                           0,
//                                                                           58,
//                                                                           106),
//                                                                   gradient:
//                                                                       LinearGradient(
//                                                                     colors: [
//                                                                       Color.fromARGB(
//                                                                           255,
//                                                                           0,
//                                                                           79,
//                                                                           215),
//                                                                       Colors
//                                                                           .blue,
//                                                                       Color.fromARGB(
//                                                                           255,
//                                                                           0,
//                                                                           79,
//                                                                           215),
//                                                                     ],
//                                                                   )),
//                                                           child: const Align(
//                                                             alignment: Alignment
//                                                                 .center,
//                                                             child: Text(
//                                                               "VIEW MAP",
//                                                               style: TextStyle(
//                                                                 color: Colors
//                                                                     .white,
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .bold,
//                                                                 fontSize: 10,
//                                                               ),
//                                                             ),
//                                                           ),
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   )
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

//   Future<void> _filterData(String query) async {
//     if (query.isEmpty) {
//       selectedSubstation = null;
//       selectedFeeder = null;
//       lCPWorkOrderRejectViewModel.fetchLCPWorkOrderRejectTabularListApi(
//           context,
//           '',
//           '',
//           'REJECTED',
//           'PEMC',
//           widget.budgetType,
//           widget.maintenanceType,
//           '',
//           '');
//     } else {
//       lCPWorkOrderRejectViewModel.lcpWorkOrderRejectGetTabularData.data!.findAllTableData = lCPWorkOrderRejectViewModel
//           .lcpWorkOrderRejectGetTabularData.data!.findAllTableData
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

//   void fetchData(String substationId, String feederId, String status) {
//     lCPWorkOrderRejectViewModel.fetchLCPWorkOrderRejectTabularListApi(
//         context,
//         substationId,
//         feederId,
//         status,
//         'PEMC',
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
//                 lCPWorkOrderRejectViewModel.imageData.data?.images?.length ?? 0;

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
//                               color: AppColors.baseColor,
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
//         lCPWorkOrderRejectViewModel.imageData.data?.images![i].imageLocation;

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
//                                       'https://atsdev2test.ariespro.com/assets/clientuploads/$fileLocation')));
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
//                                   'https://atsdev2test.ariespro.com/assets/clientuploads/$fileLocation',
//                             ),
//                           ),
//                         ))
//                   else
//                     InkWell(
//                       onTap: () {
//                         openFullSizeImageDialog(fileLocation);
//                       },
//                       child: Image.network(
//                         'https://atsdev2test.ariespro.com/assets/clientuploads/$fileLocation',
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
//                                   'https://atsdev2test.ariespro.com/assets/clientuploads/$fileLocation',
//                                   'File',context);
//                               Navigator.pop(context);
//                             } else {
//                               downloadFile(
//                                   'https://atsdev2test.ariespro.com/assets/clientuploads/$fileLocation',
//                                   'PDF',context);
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
//                   color: AppColors.baseColor,
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
//         lCPWorkOrderRejectViewModel.fetchLCPWorkOrderRejectTabularListApi(
//             context,
//             '',
//             '',
//             'REJECTED',
//             'PEMC',
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

//   void newDateFormat(
//     int index,
//   ) {
//     String? rawCreateDate = lCPWorkOrderRejectViewModel
//         .lcpWorkOrderRejectGetTabularData
//         .data!
//         .findAllTableData![index]
//         .contractYear
//         ?.toString();

//     String? rawNextMaintDue = lCPWorkOrderRejectViewModel
//         .lcpWorkOrderRejectGetTabularData
//         .data!
//         .findAllTableData![index]
//         .nextMaintDue
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
// }
