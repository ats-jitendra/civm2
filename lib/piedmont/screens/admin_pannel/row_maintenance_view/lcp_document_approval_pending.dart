// // import 'package:CIVM/piedmont/screens/admin_pannel/map_view_admin.dart';
// import 'dart:io';
// import 'package:CIVM/piedmont/resources/app_colors.dart';
// import 'package:CIVM/piedmont/models/user_model.dart';
// import 'package:CIVM/piedmont/repository/map_url.dart';
// import 'package:CIVM/piedmont/screens/admin_pannel/row_maintenance_view/add_new_row_maintenance_plan.dart';
// import 'package:CIVM/piedmont/screens/admin_pannel/row_maintenance_view/dailyHerbicide_statusChange.dart';
// import 'package:CIVM/piedmont/screens/admin_pannel/row_maintenance_view/image_paint_screen.dart';
// import 'package:CIVM/piedmont/screens/admin_pannel/row_maintenance_view/ivm_timeSheet_changeStatus.dart';
// import 'package:CIVM/piedmont/screens/admin_pannel/row_maintenance_view/lcp_create_order.dart';
// import 'package:CIVM/piedmont/screens/admin_pannel/row_maintenance_view/mixing_inventory_changeStatus.dart';
// import 'package:CIVM/piedmont/screens/admin_pannel/row_maintenance_view/pdf_view.dart';
// import 'package:CIVM/piedmont/screens/my_chrome_safari_map_recording.dart';
// import 'package:CIVM/piedmont/utils/user_pref.dart';
// import 'package:CIVM/utils/user_pref.dart';
// import 'package:CIVM/models/user_model.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// // import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// import 'package:intl/intl.dart';
// import 'package:path_provider/path_provider.dart';
// // import 'package:photo_view/photo_view.dart';
// // import 'package:photo_view/photo_view_gallery.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../../../data/response/status.dart';
// import '../../../utils/custom_toast_snackbar_progressdialog.dart';
// import '../../../view_model/lcp_document_approval_view_model.dart';
// import 'package:http/http.dart' as http;
// import 'package:image_painter/image_painter.dart';

// // ignore: must_be_immutable
// class LCPDocumentApprovalPending extends StatefulWidget {
//   String budgetType;
//   String maintenanceType;
//   String heading;

//   LCPDocumentApprovalPending({
//     Key? key,
//     required this.budgetType,
//     required this.maintenanceType,
//     required this.heading,
//   }) : super(key: key);

//   @override
//   State<LCPDocumentApprovalPending> createState() =>
//       _LCPDocumentApprovalPendingState();
// }

// class _LCPDocumentApprovalPendingState
//     extends State<LCPDocumentApprovalPending> {
//   final ImagePainterController _controller = ImagePainterController(
//     color: Colors.green,
//     strokeWidth: 2,
//     mode: PaintMode.none,
//   );
//   List<String> menu = [];
//   final TextEditingController _input = TextEditingController();
//   int substationId = 0;
//   int feederId = 0;

//   // ignore: prefer_typing_uninitialized_variables
//   var selectedSubstation;
//   // ignore: prefer_typing_uninitialized_variables
//   var selectedFeeder;

//   String userName = '';

//   // ignore: non_constant_identifier_names
//   final select_status = ['APPROVE', 'REJECT'];
//   // ignore: non_constant_identifier_names
//   String? status;

//   final TextEditingController _notes = TextEditingController();

//   LCPDocumentApprovalPendingViewModel lCPDocumentApprovalPendingViewModel =
//       LCPDocumentApprovalPendingViewModel();

//   final browser = MyChromeSafariBrowser();

//   @override
//   void initState() {
//     lCPDocumentApprovalPendingViewModel
//         .fetchLCPDocumentApprovalPendingTabularListApi(
//             context,
//             '',
//             'PENDING APPROVAL',
//             '',
//             '',
//             widget.budgetType,
//             widget.maintenanceType);
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
//             '${widget.heading} (Document Approval Pending)',
//             style: const TextStyle(color: Colors.white),
//           ),
//           backgroundColor: AppColors.baseColor,
//         ),
//         body: ChangeNotifierProvider<LCPDocumentApprovalPendingViewModel>(
//             create: (BuildContext context) =>
//                 lCPDocumentApprovalPendingViewModel,
//             child: Consumer<LCPDocumentApprovalPendingViewModel>(
//                 builder: (context, value, _) {
//               switch (value.lcpDocumentApprovalPendingGetTabularData.status) {
//                 case Status.LOADING:
//                   return const Center(child: CircularProgressIndicator());
//                 case Status.ERROR:
//                   return
//                       // CustomToastSnackBarProgressDialog.flushBarErrorMessage(
//                       //     value.lcpDocumentApprovalPendingGetTabularData.message
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
//                       selectedSubstation = null;
//                       selectedFeeder = null;
//                       await lCPDocumentApprovalPendingViewModel
//                           .fetchLCPDocumentApprovalPendingTabularListApi(
//                               context,
//                               '',
//                               'PENDING APPROVAL',
//                               '',
//                               '',
//                               widget.budgetType,
//                               widget.maintenanceType);
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
//                           const Align(
//                               alignment: Alignment.centerLeft,
//                               child: Padding(
//                                 padding: EdgeInsets.only(
//                                     left: 2.0,
//                                     right: 2.0,
//                                     bottom: 2.0,
//                                     top: 4.0),
//                                 child: Text(
//                                   "SUBSTATION",
//                                   style: TextStyle(
//                                       fontSize: 16,
//                                       color: AppColors.baseColor,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                               )),
//                           Align(
//                             alignment: Alignment.centerLeft,
//                             child: DropdownButtonFormField<String>(
//                               hint: const Text('-Select-'),
//                               dropdownColor: Colors.white,
//                               value: selectedSubstation,
//                               style: const TextStyle(
//                                   color: AppColors.baseColor,
//                                   fontSize: 16),
//                               icon: const Icon(
//                                 Icons.arrow_drop_down,
//                                 color: AppColors.baseColor,
//                                 size: 40,
//                               ),
//                               decoration: const InputDecoration(
//                                 enabledBorder: OutlineInputBorder(
//                                   borderSide: BorderSide(
//                                     color: AppColors.baseColor,
//                                   ),
//                                   // borderRadius: BorderRadius.circular(25),
//                                 ),
//                                 focusedBorder: OutlineInputBorder(
//                                   borderSide: BorderSide(
//                                     color: AppColors.baseColor,
//                                   ),
//                                   // borderRadius: BorderRadius.circular(25),
//                                 ),
//                               ),
//                               isExpanded: true,
//                               items: lCPDocumentApprovalPendingViewModel
//                                   .lcpDocumentApprovalPendingGetTabularData
//                                   .data!
//                                   .findAllSubstationAndSubIdByStatus!
//                                   .map((e) {
//                                 return DropdownMenuItem(
//                                   value: e.subId.toString(),
//                                   // e.getIdAndSubstationByCountId![0].subStation.toString(),
//                                   child: Text(e.subStation.toString()),
//                                 );
//                               }).toList(),
//                               onChanged: (val) {
//                                 if (selectedFeeder != null) {
//                                   selectedFeeder = null;
//                                 }
//                                 print('val');
//                                 print(val);
//                                 fetchData(val!, 'PENDING APPROVAL', '');
//                                 substationId = int.parse(val);
//                                 print('111111111111111');
//                                 print(substationId);
//                                 setState(() {
//                                   selectedSubstation = val;
//                                 });
//                               },
//                               validator: (value) =>
//                                   value == null ? 'field required' : null,
//                             ),
//                           ),
//                           const Align(
//                               alignment: Alignment.centerLeft,
//                               child: Padding(
//                                 padding: EdgeInsets.only(
//                                     left: 2.0,
//                                     right: 2.0,
//                                     bottom: 2.0,
//                                     top: 4.0),
//                                 child: Text(
//                                   "FEEDER",
//                                   style: TextStyle(
//                                       fontSize: 16,
//                                       color: AppColors.baseColor,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                               )),
//                           Align(
//                             alignment: Alignment.centerLeft,
//                             child: DropdownButtonFormField<String>(
//                               hint: const Text('-Select-'),
//                               dropdownColor: Colors.white,
//                               value: selectedFeeder,
//                               style: const TextStyle(
//                                   color: AppColors.baseColor,
//                                   fontSize: 16),
//                               icon: const Icon(
//                                 Icons.arrow_drop_down,
//                                 color: AppColors.baseColor,
//                                 size: 40,
//                               ),
//                               decoration: const InputDecoration(
//                                 enabledBorder: OutlineInputBorder(
//                                   borderSide: BorderSide(
//                                     color: AppColors.baseColor,
//                                   ),
//                                   // borderRadius: BorderRadius.circular(25),
//                                 ),
//                                 focusedBorder: OutlineInputBorder(
//                                   borderSide: BorderSide(
//                                     color: AppColors.baseColor,
//                                   ),
//                                   // borderRadius: BorderRadius.circular(25),
//                                 ),
//                               ),
//                               isExpanded: true,
//                               items: lCPDocumentApprovalPendingViewModel
//                                   .lcpDocumentApprovalPendingGetTabularData
//                                   .data!
//                                   .findAllFeederNameAndFeederByCountyAndSubstationAndStatus!
//                                   .map((e) {
//                                 return DropdownMenuItem(
//                                   value: e.feeder.toString(),
//                                   // e.getIdAndSubstationByCountId![0].subStation.toString(),
//                                   child: Text(e.feederName.toString()),
//                                 );
//                               }).toList(),
//                               onChanged: (val) {
//                                 print('val');
//                                 print(val);
//                                 fetchData(substationId.toString(),
//                                     'PENDING APPROVAL', val!);
//                                 feederId = int.parse(val);
//                                 print('111111111111111');
//                                 print(substationId);
//                                 setState(() {
//                                   selectedFeeder = val;
//                                 });
//                               },
//                               validator: (value) =>
//                                   value == null ? 'field required' : null,
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.only(top: 8.0),
//                             child: Align(
//                               alignment: Alignment.bottomLeft,
//                               child: Text(
//                                 "TOTAL NO OF RECORDS : ${lCPDocumentApprovalPendingViewModel.lcpDocumentApprovalPendingGetTabularData.data!.findAllTableData!.length.toString()}",
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
//                                 itemCount: lCPDocumentApprovalPendingViewModel
//                                     .lcpDocumentApprovalPendingGetTabularData
//                                     .data!
//                                     .findAllTableData!
//                                     .length,
//                                 itemBuilder: (BuildContext ctxt, int index) {
//                                   String? dateStringCreateDate =
//                                       lCPDocumentApprovalPendingViewModel
//                                           .lcpDocumentApprovalPendingGetTabularData
//                                           .data!
//                                           .findAllTableData![index]
//                                           .createDate
//                                           .toString();
//                                   DateTime date =
//                                       DateTime.parse(dateStringCreateDate);
//                                   String formattedDateCreateDate =
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
//                                                             if (lCPDocumentApprovalPendingViewModel
//                                                                         .lcpDocumentApprovalPendingGetTabularData
//                                                                         .data!
//                                                                         .findAllTableData![
//                                                                             index]
//                                                                         .maintType ==
//                                                                     'RegularMaint' &&
//                                                                 lCPDocumentApprovalPendingViewModel
//                                                                         .lcpDocumentApprovalPendingGetTabularData
//                                                                         .data!
//                                                                         .findAllTableData![
//                                                                             index]
//                                                                         .rowYear !=
//                                                                     '' &&
//                                                                 lCPDocumentApprovalPendingViewModel
//                                                                         .lcpDocumentApprovalPendingGetTabularData
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
//                                                                             tokenNo: (lCPDocumentApprovalPendingViewModel.lcpDocumentApprovalPendingGetTabularData.data!.findAllTableData![index].tokenNo == null)
//                                                                                 ? ''
//                                                                                 : lCPDocumentApprovalPendingViewModel.lcpDocumentApprovalPendingGetTabularData.data!.findAllTableData![index].tokenNo.toString(),
//                                                                             index:
//                                                                                 '0',
//                                                                             nextMaintYear: lCPDocumentApprovalPendingViewModel.lcpDocumentApprovalPendingGetTabularData.data!.findAllTableData![index].nextMaintDue == null
//                                                                                 ? ''
//                                                                                 : lCPDocumentApprovalPendingViewModel.lcpDocumentApprovalPendingGetTabularData.data!.findAllTableData![index].nextMaintDue.toString(),
//                                                                             subStation: lCPDocumentApprovalPendingViewModel.lcpDocumentApprovalPendingGetTabularData.data!.findAllTableData![index].substation == null
//                                                                                 ? ''
//                                                                                 : lCPDocumentApprovalPendingViewModel.lcpDocumentApprovalPendingGetTabularData.data!.findAllTableData![index].substation.toString(),
//                                                                             feeder: lCPDocumentApprovalPendingViewModel.lcpDocumentApprovalPendingGetTabularData.data!.findAllTableData![index].fdrName == null
//                                                                                 ? ''
//                                                                                 : lCPDocumentApprovalPendingViewModel.lcpDocumentApprovalPendingGetTabularData.data!.findAllTableData![index].fdrName.toString(),
//                                                                             maintType: lCPDocumentApprovalPendingViewModel.lcpDocumentApprovalPendingGetTabularData.data!.findAllTableData![index].type == null
//                                                                                 ? ''
//                                                                                 : lCPDocumentApprovalPendingViewModel.lcpDocumentApprovalPendingGetTabularData.data!.findAllTableData![index].type.toString(),
//                                                                             totalMiles: lCPDocumentApprovalPendingViewModel.lcpDocumentApprovalPendingGetTabularData.data!.findAllTableData![index].totalMiles == null
//                                                                                 ? ''
//                                                                                 : lCPDocumentApprovalPendingViewModel.lcpDocumentApprovalPendingGetTabularData.data!.findAllTableData![index].totalMiles.toString(),
//                                                                             totalCost: lCPDocumentApprovalPendingViewModel.lcpDocumentApprovalPendingGetTabularData.data!.findAllTableData![index].totalCost == null
//                                                                                 ? ''
//                                                                                 : lCPDocumentApprovalPendingViewModel.lcpDocumentApprovalPendingGetTabularData.data!.findAllTableData![index].totalCost.toString(),
//                                                                             costPerMile: lCPDocumentApprovalPendingViewModel.lcpDocumentApprovalPendingGetTabularData.data!.findAllTableData![index].costPerMile == null
//                                                                                 ? ''
//                                                                                 : lCPDocumentApprovalPendingViewModel.lcpDocumentApprovalPendingGetTabularData.data!.findAllTableData![index].costPerMile.toString(),
//                                                                             budgetType: lCPDocumentApprovalPendingViewModel.lcpDocumentApprovalPendingGetTabularData.data!.findAllTableData![index].budgetType == null
//                                                                                 ? ''
//                                                                                 : lCPDocumentApprovalPendingViewModel.lcpDocumentApprovalPendingGetTabularData.data!.findAllTableData![index].budgetType.toString(),
//                                                                             contractRowYear: lCPDocumentApprovalPendingViewModel.lcpDocumentApprovalPendingGetTabularData.data!.findAllTableData![index].contractYear == null
//                                                                                 ? ''
//                                                                                 : lCPDocumentApprovalPendingViewModel.lcpDocumentApprovalPendingGetTabularData.data!.findAllTableData![index].contractYear.toString(),
//                                                                             rowCycle: lCPDocumentApprovalPendingViewModel.lcpDocumentApprovalPendingGetTabularData.data!.findAllTableData![index].cycle == null
//                                                                                 ? ''
//                                                                                 : lCPDocumentApprovalPendingViewModel.lcpDocumentApprovalPendingGetTabularData.data!.findAllTableData![index].cycle.toString(),
//                                                                             rowYear: lCPDocumentApprovalPendingViewModel.lcpDocumentApprovalPendingGetTabularData.data!.findAllTableData![index].rowYear == null
//                                                                                 ? ''
//                                                                                 : lCPDocumentApprovalPendingViewModel.lcpDocumentApprovalPendingGetTabularData.data!.findAllTableData![index].rowYear.toString(),
//                                                                             contractorCompany: lCPDocumentApprovalPendingViewModel.lcpDocumentApprovalPendingGetTabularData.data!.findAllTableData![index].contractorCompany == null
//                                                                                 ? ''
//                                                                                 : lCPDocumentApprovalPendingViewModel.lcpDocumentApprovalPendingGetTabularData.data!.findAllTableData![index].contractorCompany.toString(),
//                                                                             assignForeman: lCPDocumentApprovalPendingViewModel.lcpDocumentApprovalPendingGetTabularData.data!.findAllTableData![index].contractor == null
//                                                                                 ? ''
//                                                                                 : lCPDocumentApprovalPendingViewModel.lcpDocumentApprovalPendingGetTabularData.data!.findAllTableData![index].contractor.toString(),
//                                                                           )));
//                                                             } else if (lCPDocumentApprovalPendingViewModel
//                                                                         .lcpDocumentApprovalPendingGetTabularData
//                                                                         .data!
//                                                                         .findAllTableData![
//                                                                             index]
//                                                                         .maintType ==
//                                                                     'RegularMaint' &&
//                                                                 lCPDocumentApprovalPendingViewModel
//                                                                         .lcpDocumentApprovalPendingGetTabularData
//                                                                         .data!
//                                                                         .findAllTableData![
//                                                                             index]
//                                                                         .rowYear ==
//                                                                     '' &&
//                                                                 lCPDocumentApprovalPendingViewModel
//                                                                         .lcpDocumentApprovalPendingGetTabularData
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
//                                                                             tokenNo: (lCPDocumentApprovalPendingViewModel.lcpDocumentApprovalPendingGetTabularData.data!.findAllTableData![index].tokenNo == null)
//                                                                                 ? ''
//                                                                                 : lCPDocumentApprovalPendingViewModel.lcpDocumentApprovalPendingGetTabularData.data!.findAllTableData![index].tokenNo.toString(),
//                                                                             index:
//                                                                                 '1',
//                                                                             nextMaintYear: lCPDocumentApprovalPendingViewModel.lcpDocumentApprovalPendingGetTabularData.data!.findAllTableData![index].nextMaintDue == null
//                                                                                 ? ''
//                                                                                 : lCPDocumentApprovalPendingViewModel.lcpDocumentApprovalPendingGetTabularData.data!.findAllTableData![index].nextMaintDue.toString(),
//                                                                             subStation: lCPDocumentApprovalPendingViewModel.lcpDocumentApprovalPendingGetTabularData.data!.findAllTableData![index].substation == null
//                                                                                 ? ''
//                                                                                 : lCPDocumentApprovalPendingViewModel.lcpDocumentApprovalPendingGetTabularData.data!.findAllTableData![index].substation.toString(),
//                                                                             feeder: lCPDocumentApprovalPendingViewModel.lcpDocumentApprovalPendingGetTabularData.data!.findAllTableData![index].fdrName == null
//                                                                                 ? ''
//                                                                                 : lCPDocumentApprovalPendingViewModel.lcpDocumentApprovalPendingGetTabularData.data!.findAllTableData![index].fdrName.toString(),
//                                                                             maintType: lCPDocumentApprovalPendingViewModel.lcpDocumentApprovalPendingGetTabularData.data!.findAllTableData![index].type == null
//                                                                                 ? ''
//                                                                                 : lCPDocumentApprovalPendingViewModel.lcpDocumentApprovalPendingGetTabularData.data!.findAllTableData![index].type.toString(),
//                                                                             totalMiles: lCPDocumentApprovalPendingViewModel.lcpDocumentApprovalPendingGetTabularData.data!.findAllTableData![index].totalMiles == null
//                                                                                 ? ''
//                                                                                 : lCPDocumentApprovalPendingViewModel.lcpDocumentApprovalPendingGetTabularData.data!.findAllTableData![index].totalMiles.toString(),
//                                                                             totalCost: lCPDocumentApprovalPendingViewModel.lcpDocumentApprovalPendingGetTabularData.data!.findAllTableData![index].totalCost == null
//                                                                                 ? ''
//                                                                                 : lCPDocumentApprovalPendingViewModel.lcpDocumentApprovalPendingGetTabularData.data!.findAllTableData![index].totalCost.toString(),
//                                                                             costPerMile: lCPDocumentApprovalPendingViewModel.lcpDocumentApprovalPendingGetTabularData.data!.findAllTableData![index].costPerMile == null
//                                                                                 ? ''
//                                                                                 : lCPDocumentApprovalPendingViewModel.lcpDocumentApprovalPendingGetTabularData.data!.findAllTableData![index].costPerMile.toString(),
//                                                                             budgetType: lCPDocumentApprovalPendingViewModel.lcpDocumentApprovalPendingGetTabularData.data!.findAllTableData![index].budgetType == null
//                                                                                 ? ''
//                                                                                 : lCPDocumentApprovalPendingViewModel.lcpDocumentApprovalPendingGetTabularData.data!.findAllTableData![index].budgetType.toString(),
//                                                                             contractRowYear: lCPDocumentApprovalPendingViewModel.lcpDocumentApprovalPendingGetTabularData.data!.findAllTableData![index].contractYear == null
//                                                                                 ? ''
//                                                                                 : lCPDocumentApprovalPendingViewModel.lcpDocumentApprovalPendingGetTabularData.data!.findAllTableData![index].contractYear.toString(),
//                                                                             rowCycle: lCPDocumentApprovalPendingViewModel.lcpDocumentApprovalPendingGetTabularData.data!.findAllTableData![index].cycle == null
//                                                                                 ? ''
//                                                                                 : lCPDocumentApprovalPendingViewModel.lcpDocumentApprovalPendingGetTabularData.data!.findAllTableData![index].cycle.toString(),
//                                                                             rowYear: lCPDocumentApprovalPendingViewModel.lcpDocumentApprovalPendingGetTabularData.data!.findAllTableData![index].rowYear == null
//                                                                                 ? ''
//                                                                                 : lCPDocumentApprovalPendingViewModel.lcpDocumentApprovalPendingGetTabularData.data!.findAllTableData![index].rowYear.toString(),
//                                                                             contractorCompany: lCPDocumentApprovalPendingViewModel.lcpDocumentApprovalPendingGetTabularData.data!.findAllTableData![index].contractorCompany == null
//                                                                                 ? ''
//                                                                                 : lCPDocumentApprovalPendingViewModel.lcpDocumentApprovalPendingGetTabularData.data!.findAllTableData![index].contractorCompany.toString(),
//                                                                             assignForeman: lCPDocumentApprovalPendingViewModel.lcpDocumentApprovalPendingGetTabularData.data!.findAllTableData![index].contractor == null
//                                                                                 ? ''
//                                                                                 : lCPDocumentApprovalPendingViewModel.lcpDocumentApprovalPendingGetTabularData.data!.findAllTableData![index].contractor.toString(),
//                                                                           )));
//                                                             } else {
//                                                               Navigator.of(context).push(
//                                                                   MaterialPageRoute(
//                                                                       builder: (BuildContext
//                                                                               context) =>
//                                                                           LCPCreateOrder(
//                                                                             tokenNo: (lCPDocumentApprovalPendingViewModel.lcpDocumentApprovalPendingGetTabularData.data!.findAllTableData![index].tokenNo == null)
//                                                                                 ? ''
//                                                                                 : lCPDocumentApprovalPendingViewModel.lcpDocumentApprovalPendingGetTabularData.data!.findAllTableData![index].tokenNo.toString(),
//                                                                             subStation: (lCPDocumentApprovalPendingViewModel.lcpDocumentApprovalPendingGetTabularData.data!.findAllTableData![index].substation == null)
//                                                                                 ? ''
//                                                                                 : lCPDocumentApprovalPendingViewModel.lcpDocumentApprovalPendingGetTabularData.data!.findAllTableData![index].substation.toString(),
//                                                                             feeder: (lCPDocumentApprovalPendingViewModel.lcpDocumentApprovalPendingGetTabularData.data!.findAllTableData![index].fdrName == null)
//                                                                                 ? ''
//                                                                                 : lCPDocumentApprovalPendingViewModel.lcpDocumentApprovalPendingGetTabularData.data!.findAllTableData![index].fdrName.toString(),
//                                                                             serviceStreetAddress: (lCPDocumentApprovalPendingViewModel.lcpDocumentApprovalPendingGetTabularData.data!.findAllTableData![index].streetAddress == null || lCPDocumentApprovalPendingViewModel.lcpDocumentApprovalPendingGetTabularData.data!.findAllTableData![index].streetAddress == 'N/A')
//                                                                                 ? ''
//                                                                                 : lCPDocumentApprovalPendingViewModel.lcpDocumentApprovalPendingGetTabularData.data!.findAllTableData![index].streetAddress.toString(),
//                                                                             serviceMapLocation: (lCPDocumentApprovalPendingViewModel.lcpDocumentApprovalPendingGetTabularData.data!.findAllTableData![index].mapLocation == null || lCPDocumentApprovalPendingViewModel.lcpDocumentApprovalPendingGetTabularData.data!.findAllTableData![index].mapLocation == 'N/A')
//                                                                                 ? ''
//                                                                                 : lCPDocumentApprovalPendingViewModel.lcpDocumentApprovalPendingGetTabularData.data!.findAllTableData![index].mapLocation.toString(),
//                                                                             notes: (lCPDocumentApprovalPendingViewModel.lcpDocumentApprovalPendingGetTabularData.data!.findAllTableData![index].adminNotes1 == null)
//                                                                                 ? ''
//                                                                                 : lCPDocumentApprovalPendingViewModel.lcpDocumentApprovalPendingGetTabularData.data!.findAllTableData![index].adminNotes1.toString(),
//                                                                             type: (lCPDocumentApprovalPendingViewModel.lcpDocumentApprovalPendingGetTabularData.data!.findAllTableData![index].type == null)
//                                                                                 ? ''
//                                                                                 : lCPDocumentApprovalPendingViewModel.lcpDocumentApprovalPendingGetTabularData.data!.findAllTableData![index].type.toString(),
//                                                                             maintType: (lCPDocumentApprovalPendingViewModel.lcpDocumentApprovalPendingGetTabularData.data!.findAllTableData![index].maintType == null)
//                                                                                 ? ''
//                                                                                 : lCPDocumentApprovalPendingViewModel.lcpDocumentApprovalPendingGetTabularData.data!.findAllTableData![index].maintType.toString(),
//                                                                             contractorCompany: (lCPDocumentApprovalPendingViewModel.lcpDocumentApprovalPendingGetTabularData.data!.findAllTableData![index].contractorCompany == null)
//                                                                                 ? ''
//                                                                                 : lCPDocumentApprovalPendingViewModel.lcpDocumentApprovalPendingGetTabularData.data!.findAllTableData![index].contractorCompany.toString(),
//                                                                             assignForeman: lCPDocumentApprovalPendingViewModel.lcpDocumentApprovalPendingGetTabularData.data!.findAllTableData![index].contractor == null
//                                                                                 ? ''
//                                                                                 : lCPDocumentApprovalPendingViewModel.lcpDocumentApprovalPendingGetTabularData.data!.findAllTableData![index].contractor.toString(),
//                                                                             estimatedCost: lCPDocumentApprovalPendingViewModel.lcpDocumentApprovalPendingGetTabularData.data!.findAllTableData![index].estCost == null
//                                                                                 ? ''
//                                                                                 : lCPDocumentApprovalPendingViewModel.lcpDocumentApprovalPendingGetTabularData.data!.findAllTableData![index].estCost.toString(),
//                                                                             estimatedTime: lCPDocumentApprovalPendingViewModel.lcpDocumentApprovalPendingGetTabularData.data!.findAllTableData![index].estTime == null
//                                                                                 ? ''
//                                                                                 : lCPDocumentApprovalPendingViewModel.lcpDocumentApprovalPendingGetTabularData.data!.findAllTableData![index].estTime.toString(),
//                                                                             actualCost: lCPDocumentApprovalPendingViewModel.lcpDocumentApprovalPendingGetTabularData.data!.findAllTableData![index].actualCost == null
//                                                                                 ? ''
//                                                                                 : lCPDocumentApprovalPendingViewModel.lcpDocumentApprovalPendingGetTabularData.data!.findAllTableData![index].actualCost.toString(),
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
//                                                         // ignore: prefer_const_constructors
//                                                         Align(
//                                                           alignment:
//                                                               Alignment.topLeft,
//                                                           child: const Text(
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
//                                                               await lCPDocumentApprovalPendingViewModel
//                                                                   .fetchImageApi(
//                                                                 context,
//                                                                 lCPDocumentApprovalPendingViewModel
//                                                                     .lcpDocumentApprovalPendingGetTabularData
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
//                                                                   lCPDocumentApprovalPendingViewModel
//                                                                       .lcpDocumentApprovalPendingGetTabularData
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
//                                                             (lCPDocumentApprovalPendingViewModel
//                                                                             .lcpDocumentApprovalPendingGetTabularData
//                                                                             .data!
//                                                                             .findAllTableData![
//                                                                                 index]
//                                                                             .maintType ==
//                                                                         null ||
//                                                                     lCPDocumentApprovalPendingViewModel
//                                                                             .lcpDocumentApprovalPendingGetTabularData
//                                                                             .data!
//                                                                             .findAllTableData![
//                                                                                 index]
//                                                                             .maintType
//                                                                             .toString() ==
//                                                                         'null')
//                                                                 ? ''
//                                                                 : lCPDocumentApprovalPendingViewModel
//                                                                     .lcpDocumentApprovalPendingGetTabularData
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
//                                                             (lCPDocumentApprovalPendingViewModel
//                                                                             .lcpDocumentApprovalPendingGetTabularData
//                                                                             .data!
//                                                                             .findAllTableData![
//                                                                                 index]
//                                                                             .tokenNo ==
//                                                                         null ||
//                                                                     lCPDocumentApprovalPendingViewModel
//                                                                             .lcpDocumentApprovalPendingGetTabularData
//                                                                             .data!
//                                                                             .findAllTableData![
//                                                                                 index]
//                                                                             .tokenNo
//                                                                             .toString() ==
//                                                                         'null')
//                                                                 ? ''
//                                                                 : lCPDocumentApprovalPendingViewModel
//                                                                     .lcpDocumentApprovalPendingGetTabularData
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
//                                                         (lCPDocumentApprovalPendingViewModel
//                                                                     .lcpDocumentApprovalPendingGetTabularData
//                                                                     .data!
//                                                                     .findAllTableData![
//                                                                         index]
//                                                                     .maintType
//                                                                     .toString() ==
//                                                                 'RegularMaint')
//                                                             ? Column(
//                                                                 children: [
//                                                                   Align(
//                                                                     alignment:
//                                                                         Alignment
//                                                                             .topLeft,
//                                                                     child:
//                                                                         Padding(
//                                                                       padding: const EdgeInsets
//                                                                           .only(
//                                                                           top:
//                                                                               4.0),
//                                                                       child:
//                                                                           InkWell(
//                                                                         onTap:
//                                                                             () async {
//                                                                           // lCPDocumentApprovalPendingViewModel
//                                                                           // .fetchLCPDocumentPendingApprovalChangeStatusListApi(
//                                                                           //     context,
//                                                                           //     lCPDocumentApprovalPendingViewModel.lcpDocumentApprovalPendingGetTabularData.data!.findAllTableData![index].tokenNo.toString(),
//                                                                           //     'CLOSED');
//                                                                           await lCPDocumentApprovalPendingViewModel
//                                                                               .fetchLCPDocumentPendingApprovalChangeStatusListApi(context, lCPDocumentApprovalPendingViewModel.lcpDocumentApprovalPendingGetTabularData.data!.findAllTableData![index].tokenNo.toString(), 'CLOSED')
//                                                                               .then((value) {
//                                                                             Future.delayed(const Duration(seconds: 5));

//                                                                             lCPDocumentApprovalPendingViewModel.fetchLCPDocumentApprovalPendingTabularListApi(
//                                                                                 context,
//                                                                                 '',
//                                                                                 'PENDING APPROVAL',
//                                                                                 '',
//                                                                                 '',
//                                                                                 widget.budgetType,
//                                                                                 widget.maintenanceType);
//                                                                           });
//                                                                         },
//                                                                         child:
//                                                                             Container(
//                                                                           padding: const EdgeInsets
//                                                                               .all(
//                                                                               2),
//                                                                           alignment:
//                                                                               Alignment.center,
//                                                                           width:
//                                                                               size.width * 0.2,
//                                                                           // width: MediaQuery.of(context).size.width,
//                                                                           // height: 35,
//                                                                           decoration: const BoxDecoration(
//                                                                               // shape: BoxShape.circle,
//                                                                               //borderRadius: BorderRadius.circular(25),
//                                                                               boxShadow: [
//                                                                                 BoxShadow(color: Color.fromARGB(255, 3, 47, 97), blurRadius: 5, offset: Offset(2.0, 5.0))
//                                                                               ],
//                                                                               color: Color.fromARGB(255, 130, 193, 245),
//                                                                               gradient: LinearGradient(
//                                                                                 colors: [
//                                                                                   Color.fromARGB(255, 49, 150, 232),
//                                                                                   Color.fromARGB(255, 49, 150, 232),
//                                                                                 ],
//                                                                               )),
//                                                                           child:
//                                                                               const Padding(
//                                                                             padding:
//                                                                                 EdgeInsets.all(2.0),
//                                                                             child:
//                                                                                 Align(
//                                                                               alignment: Alignment.center,
//                                                                               child: Text(
//                                                                                 "APPROVE",
//                                                                                 textAlign: TextAlign.left,
//                                                                                 style: TextStyle(
//                                                                                   color: Colors.white,
//                                                                                   fontWeight: FontWeight.bold,
//                                                                                   fontSize: 12,
//                                                                                 ),
//                                                                               ),
//                                                                             ),
//                                                                           ),
//                                                                         ),
//                                                                       ),
//                                                                     ),
//                                                                   ),
//                                                                   Align(
//                                                                     alignment:
//                                                                         Alignment
//                                                                             .topLeft,
//                                                                     child:
//                                                                         Padding(
//                                                                       padding: const EdgeInsets
//                                                                           .only(
//                                                                           top:
//                                                                               4.0),
//                                                                       child:
//                                                                           InkWell(
//                                                                         onTap:
//                                                                             () async {
//                                                                           //  lCPDocumentApprovalPendingViewModel
//                                                                           // .fetchLCPDocumentPendingApprovalChangeStatusListApi(
//                                                                           //     context,
//                                                                           //     lCPDocumentApprovalPendingViewModel.lcpDocumentApprovalPendingGetTabularData.data!.findAllTableData![index].tokenNo.toString(),
//                                                                           //     'REJECTED');
//                                                                           await lCPDocumentApprovalPendingViewModel
//                                                                               .fetchLCPDocumentPendingApprovalChangeStatusListApi(context, lCPDocumentApprovalPendingViewModel.lcpDocumentApprovalPendingGetTabularData.data!.findAllTableData![index].tokenNo.toString(), 'REJECTED')
//                                                                               .then((value) {
//                                                                             Future.delayed(const Duration(seconds: 5));

//                                                                             lCPDocumentApprovalPendingViewModel.fetchLCPDocumentApprovalPendingTabularListApi(
//                                                                                 context,
//                                                                                 '',
//                                                                                 'PENDING APPROVAL',
//                                                                                 '',
//                                                                                 '',
//                                                                                 widget.budgetType,
//                                                                                 widget.maintenanceType);
//                                                                           });
//                                                                         },
//                                                                         child:
//                                                                             Container(
//                                                                           padding: const EdgeInsets
//                                                                               .all(
//                                                                               2),
//                                                                           alignment:
//                                                                               Alignment.center,
//                                                                           width:
//                                                                               size.width * 0.2,
//                                                                           // width: MediaQuery.of(context).size.width,
//                                                                           // height: 35,
//                                                                           decoration: const BoxDecoration(
//                                                                               // shape: BoxShape.circle,
//                                                                               //borderRadius: BorderRadius.circular(25),
//                                                                               boxShadow: [
//                                                                                 BoxShadow(color: Color.fromARGB(255, 3, 47, 97), blurRadius: 5, offset: Offset(2.0, 5.0))
//                                                                               ],
//                                                                               color: Color.fromARGB(255, 130, 193, 245),
//                                                                               gradient: LinearGradient(
//                                                                                 colors: [
//                                                                                   Colors.red,
//                                                                                   Colors.red,
//                                                                                 ],
//                                                                               )),
//                                                                           child:
//                                                                               const Padding(
//                                                                             padding:
//                                                                                 EdgeInsets.all(2.0),
//                                                                             child:
//                                                                                 Align(
//                                                                               alignment: Alignment.center,
//                                                                               child: Text(
//                                                                                 "REJECT",
//                                                                                 textAlign: TextAlign.left,
//                                                                                 style: TextStyle(
//                                                                                   color: Colors.white,
//                                                                                   fontWeight: FontWeight.bold,
//                                                                                   fontSize: 12,
//                                                                                 ),
//                                                                               ),
//                                                                             ),
//                                                                           ),
//                                                                         ),
//                                                                       ),
//                                                                     ),
//                                                                   ),
//                                                                 ],
//                                                               )
//                                                             : Align(
//                                                                 alignment:
//                                                                     Alignment
//                                                                         .topLeft,
//                                                                 child: Padding(
//                                                                   padding:
//                                                                       const EdgeInsets
//                                                                           .only(
//                                                                           top:
//                                                                               4.0),
//                                                                   child:
//                                                                       InkWell(
//                                                                     onTap: () {
//                                                                       openDailogPendingApproval(lCPDocumentApprovalPendingViewModel
//                                                                           .lcpDocumentApprovalPendingGetTabularData
//                                                                           .data!
//                                                                           .findAllTableData![
//                                                                               index]
//                                                                           .id
//                                                                           .toString());
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
//                                                                           0.2,
//                                                                       // width: MediaQuery.of(context).size.width,
//                                                                       // height: 35,
//                                                                       decoration: const BoxDecoration(
//                                                                           // shape: BoxShape.circle,
//                                                                           //borderRadius: BorderRadius.circular(25),
//                                                                           boxShadow: [
//                                                                             BoxShadow(
//                                                                                 color: Color.fromARGB(255, 3, 47, 97),
//                                                                                 blurRadius: 5,
//                                                                                 offset: Offset(2.0, 5.0))
//                                                                           ],
//                                                                           color: Color.fromARGB(255, 130, 193, 245),
//                                                                           gradient: LinearGradient(
//                                                                             colors: [
//                                                                               Color.fromARGB(255, 49, 150, 232),
//                                                                               Color.fromARGB(255, 49, 150, 232),
//                                                                             ],
//                                                                           )),
//                                                                       child:
//                                                                           const Padding(
//                                                                         padding:
//                                                                             EdgeInsets.all(2.0),
//                                                                         child:
//                                                                             Align(
//                                                                           alignment:
//                                                                               Alignment.center,
//                                                                           child:
//                                                                               Text(
//                                                                             "PENDING APPROVAL",
//                                                                             textAlign:
//                                                                                 TextAlign.left,
//                                                                             style:
//                                                                                 TextStyle(
//                                                                               color: Colors.white,
//                                                                               fontWeight: FontWeight.bold,
//                                                                               fontSize: 12,
//                                                                             ),
//                                                                           ),
//                                                                         ),
//                                                                       ),
//                                                                     ),
//                                                                   ),
//                                                                 ),
//                                                               ),
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
//                                                         (lCPDocumentApprovalPendingViewModel
//                                                                     .lcpDocumentApprovalPendingGetTabularData
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
//                                                                                 DailyHerbicideStatusChange(id: lCPDocumentApprovalPendingViewModel.lcpDocumentApprovalPendingGetTabularData.data!.findAllTableData![index].tokenNo.toString())));
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
//                                                             : (lCPDocumentApprovalPendingViewModel
//                                                                         .lcpDocumentApprovalPendingGetTabularData
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
//                                                                                 DailyHerbicideStatusChange(id: lCPDocumentApprovalPendingViewModel.lcpDocumentApprovalPendingGetTabularData.data!.findAllTableData![index].tokenNo.toString())));
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
//                                                                 : (lCPDocumentApprovalPendingViewModel
//                                                                             .lcpDocumentApprovalPendingGetTabularData
//                                                                             .data!
//                                                                             .findAllTableData![
//                                                                                 index]
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
//                                                                             Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => DailyHerbicideStatusChange(id: lCPDocumentApprovalPendingViewModel.lcpDocumentApprovalPendingGetTabularData.data!.findAllTableData![index].tokenNo.toString())));
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
//                                                                     : (lCPDocumentApprovalPendingViewModel.lcpDocumentApprovalPendingGetTabularData.data!.findAllTableData![index].maintType ==
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
//                                                         (lCPDocumentApprovalPendingViewModel
//                                                                     .lcpDocumentApprovalPendingGetTabularData
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
//                                                                                 IVMTimeSheetChangeStatus(id: lCPDocumentApprovalPendingViewModel.lcpDocumentApprovalPendingGetTabularData.data!.findAllTableData![index].id.toString())));
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
//                                                             : (lCPDocumentApprovalPendingViewModel
//                                                                         .lcpDocumentApprovalPendingGetTabularData
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
//                                                                                 IVMTimeSheetChangeStatus(id: lCPDocumentApprovalPendingViewModel.lcpDocumentApprovalPendingGetTabularData.data!.findAllTableData![index].id.toString())));
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
//                                                                 : (lCPDocumentApprovalPendingViewModel
//                                                                             .lcpDocumentApprovalPendingGetTabularData
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
//                                                                             Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => IVMTimeSheetChangeStatus(id: lCPDocumentApprovalPendingViewModel.lcpDocumentApprovalPendingGetTabularData.data!.findAllTableData![index].id.toString())));
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
//                                                                     : (lCPDocumentApprovalPendingViewModel.lcpDocumentApprovalPendingGetTabularData.data!.findAllTableData![index].maintType ==
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
//                                                         (lCPDocumentApprovalPendingViewModel
//                                                                     .lcpDocumentApprovalPendingGetTabularData
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
//                                                                                 MixingInventoryChangeStatus(id: lCPDocumentApprovalPendingViewModel.lcpDocumentApprovalPendingGetTabularData.data!.findAllTableData![index].id.toString())));
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
//                                                             : (lCPDocumentApprovalPendingViewModel
//                                                                         .lcpDocumentApprovalPendingGetTabularData
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
//                                                                                 MixingInventoryChangeStatus(id: lCPDocumentApprovalPendingViewModel.lcpDocumentApprovalPendingGetTabularData.data!.findAllTableData![index].id.toString())));
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
//                                                                 : (lCPDocumentApprovalPendingViewModel
//                                                                             .lcpDocumentApprovalPendingGetTabularData
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
//                                                                             Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => MixingInventoryChangeStatus(id: lCPDocumentApprovalPendingViewModel.lcpDocumentApprovalPendingGetTabularData.data!.findAllTableData![index].id.toString())));
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
//                                                                     : (lCPDocumentApprovalPendingViewModel.lcpDocumentApprovalPendingGetTabularData.data!.findAllTableData![index].maintType ==
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
//                                                             (lCPDocumentApprovalPendingViewModel
//                                                                             .lcpDocumentApprovalPendingGetTabularData
//                                                                             .data!
//                                                                             .findAllTableData![
//                                                                                 index]
//                                                                             .substation ==
//                                                                         null ||
//                                                                     lCPDocumentApprovalPendingViewModel
//                                                                             .lcpDocumentApprovalPendingGetTabularData
//                                                                             .data!
//                                                                             .findAllTableData![
//                                                                                 index]
//                                                                             .substation
//                                                                             .toString() ==
//                                                                         'null')
//                                                                 ? ''
//                                                                 : lCPDocumentApprovalPendingViewModel
//                                                                     .lcpDocumentApprovalPendingGetTabularData
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
//                                                             (lCPDocumentApprovalPendingViewModel
//                                                                             .lcpDocumentApprovalPendingGetTabularData
//                                                                             .data!
//                                                                             .findAllTableData![
//                                                                                 index]
//                                                                             .fdrName ==
//                                                                         null ||
//                                                                     lCPDocumentApprovalPendingViewModel
//                                                                             .lcpDocumentApprovalPendingGetTabularData
//                                                                             .data!
//                                                                             .findAllTableData![
//                                                                                 index]
//                                                                             .fdrName
//                                                                             .toString() ==
//                                                                         'null')
//                                                                 ? ''
//                                                                 : lCPDocumentApprovalPendingViewModel
//                                                                     .lcpDocumentApprovalPendingGetTabularData
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
//                                                             (lCPDocumentApprovalPendingViewModel
//                                                                             .lcpDocumentApprovalPendingGetTabularData
//                                                                             .data!
//                                                                             .findAllTableData![
//                                                                                 index]
//                                                                             .type ==
//                                                                         null ||
//                                                                     lCPDocumentApprovalPendingViewModel
//                                                                             .lcpDocumentApprovalPendingGetTabularData
//                                                                             .data!
//                                                                             .findAllTableData![
//                                                                                 index]
//                                                                             .type
//                                                                             .toString() ==
//                                                                         'null')
//                                                                 ? ''
//                                                                 : lCPDocumentApprovalPendingViewModel
//                                                                     .lcpDocumentApprovalPendingGetTabularData
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
//                                                             (lCPDocumentApprovalPendingViewModel
//                                                                             .lcpDocumentApprovalPendingGetTabularData
//                                                                             .data!
//                                                                             .findAllTableData![
//                                                                                 index]
//                                                                             .contractor ==
//                                                                         null ||
//                                                                     lCPDocumentApprovalPendingViewModel
//                                                                             .lcpDocumentApprovalPendingGetTabularData
//                                                                             .data!
//                                                                             .findAllTableData![
//                                                                                 index]
//                                                                             .contractor
//                                                                             .toString() ==
//                                                                         'null')
//                                                                 ? ''
//                                                                 : lCPDocumentApprovalPendingViewModel
//                                                                     .lcpDocumentApprovalPendingGetTabularData
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
//                                                             (lCPDocumentApprovalPendingViewModel
//                                                                             .lcpDocumentApprovalPendingGetTabularData
//                                                                             .data!
//                                                                             .findAllTableData![
//                                                                                 index]
//                                                                             .totalMiles ==
//                                                                         null ||
//                                                                     lCPDocumentApprovalPendingViewModel
//                                                                             .lcpDocumentApprovalPendingGetTabularData
//                                                                             .data!
//                                                                             .findAllTableData![
//                                                                                 index]
//                                                                             .totalMiles
//                                                                             .toString() ==
//                                                                         'null')
//                                                                 ? ''
//                                                                 : lCPDocumentApprovalPendingViewModel
//                                                                     .lcpDocumentApprovalPendingGetTabularData
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
//                                                             (lCPDocumentApprovalPendingViewModel
//                                                                             .lcpDocumentApprovalPendingGetTabularData
//                                                                             .data!
//                                                                             .findAllTableData![
//                                                                                 index]
//                                                                             .contractYear ==
//                                                                         null ||
//                                                                     lCPDocumentApprovalPendingViewModel
//                                                                             .lcpDocumentApprovalPendingGetTabularData
//                                                                             .data!
//                                                                             .findAllTableData![
//                                                                                 index]
//                                                                             .contractYear
//                                                                             .toString() ==
//                                                                         'null')
//                                                                 ? ''
//                                                                 : lCPDocumentApprovalPendingViewModel
//                                                                     .lcpDocumentApprovalPendingGetTabularData
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
//                                                             (lCPDocumentApprovalPendingViewModel
//                                                                             .lcpDocumentApprovalPendingGetTabularData
//                                                                             .data!
//                                                                             .findAllTableData![
//                                                                                 index]
//                                                                             .cycle ==
//                                                                         null ||
//                                                                     lCPDocumentApprovalPendingViewModel
//                                                                             .lcpDocumentApprovalPendingGetTabularData
//                                                                             .data!
//                                                                             .findAllTableData![
//                                                                                 index]
//                                                                             .cycle
//                                                                             .toString() ==
//                                                                         'null')
//                                                                 ? ''
//                                                                 : lCPDocumentApprovalPendingViewModel
//                                                                     .lcpDocumentApprovalPendingGetTabularData
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
//                                                             (lCPDocumentApprovalPendingViewModel
//                                                                             .lcpDocumentApprovalPendingGetTabularData
//                                                                             .data!
//                                                                             .findAllTableData![
//                                                                                 index]
//                                                                             .streetAddress ==
//                                                                         null ||
//                                                                     lCPDocumentApprovalPendingViewModel
//                                                                             .lcpDocumentApprovalPendingGetTabularData
//                                                                             .data!
//                                                                             .findAllTableData![
//                                                                                 index]
//                                                                             .streetAddress
//                                                                             .toString() ==
//                                                                         'null')
//                                                                 ? ''
//                                                                 : lCPDocumentApprovalPendingViewModel
//                                                                     .lcpDocumentApprovalPendingGetTabularData
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
//                                                             (lCPDocumentApprovalPendingViewModel
//                                                                             .lcpDocumentApprovalPendingGetTabularData
//                                                                             .data!
//                                                                             .findAllTableData![
//                                                                                 index]
//                                                                             .mapLocation ==
//                                                                         null ||
//                                                                     lCPDocumentApprovalPendingViewModel
//                                                                             .lcpDocumentApprovalPendingGetTabularData
//                                                                             .data!
//                                                                             .findAllTableData![
//                                                                                 index]
//                                                                             .mapLocation
//                                                                             .toString() ==
//                                                                         'null')
//                                                                 ? ''
//                                                                 : lCPDocumentApprovalPendingViewModel
//                                                                     .lcpDocumentApprovalPendingGetTabularData
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
//                                                             (lCPDocumentApprovalPendingViewModel
//                                                                             .lcpDocumentApprovalPendingGetTabularData
//                                                                             .data!
//                                                                             .findAllTableData![
//                                                                                 index]
//                                                                             .adminNotes1 ==
//                                                                         null ||
//                                                                     lCPDocumentApprovalPendingViewModel
//                                                                             .lcpDocumentApprovalPendingGetTabularData
//                                                                             .data!
//                                                                             .findAllTableData![
//                                                                                 index]
//                                                                             .adminNotes1
//                                                                             .toString() ==
//                                                                         'null')
//                                                                 ? ''
//                                                                 : lCPDocumentApprovalPendingViewModel
//                                                                     .lcpDocumentApprovalPendingGetTabularData
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
//                                                             "CONTRACTOR NOTES: ",
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
//                                                             (lCPDocumentApprovalPendingViewModel
//                                                                             .lcpDocumentApprovalPendingGetTabularData
//                                                                             .data!
//                                                                             .findAllTableData![
//                                                                                 index]
//                                                                             .contractYear ==
//                                                                         null ||
//                                                                     lCPDocumentApprovalPendingViewModel
//                                                                             .lcpDocumentApprovalPendingGetTabularData
//                                                                             .data!
//                                                                             .findAllTableData![
//                                                                                 index]
//                                                                             .contractYear
//                                                                             .toString() ==
//                                                                         'null')
//                                                                 ? ''
//                                                                 : lCPDocumentApprovalPendingViewModel
//                                                                     .lcpDocumentApprovalPendingGetTabularData
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
//                                                             (lCPDocumentApprovalPendingViewModel
//                                                                             .lcpDocumentApprovalPendingGetTabularData
//                                                                             .data!
//                                                                             .findAllTableData![
//                                                                                 index]
//                                                                             .contractorCompany ==
//                                                                         null ||
//                                                                     lCPDocumentApprovalPendingViewModel
//                                                                             .lcpDocumentApprovalPendingGetTabularData
//                                                                             .data!
//                                                                             .findAllTableData![
//                                                                                 index]
//                                                                             .contractorCompany
//                                                                             .toString() ==
//                                                                         'null')
//                                                                 ? ''
//                                                                 : lCPDocumentApprovalPendingViewModel
//                                                                     .lcpDocumentApprovalPendingGetTabularData
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
//                                                             (lCPDocumentApprovalPendingViewModel
//                                                                             .lcpDocumentApprovalPendingGetTabularData
//                                                                             .data!
//                                                                             .findAllTableData![
//                                                                                 index]
//                                                                             .dateOfInspection ==
//                                                                         null ||
//                                                                     lCPDocumentApprovalPendingViewModel
//                                                                             .lcpDocumentApprovalPendingGetTabularData
//                                                                             .data!
//                                                                             .findAllTableData![
//                                                                                 index]
//                                                                             .dateOfInspection
//                                                                             .toString() ==
//                                                                         'null')
//                                                                 ? ''
//                                                                 : lCPDocumentApprovalPendingViewModel
//                                                                     .lcpDocumentApprovalPendingGetTabularData
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
//                                                             (lCPDocumentApprovalPendingViewModel
//                                                                             .lcpDocumentApprovalPendingGetTabularData
//                                                                             .data!
//                                                                             .findAllTableData![
//                                                                                 index]
//                                                                             .followUpDate ==
//                                                                         null ||
//                                                                     lCPDocumentApprovalPendingViewModel
//                                                                             .lcpDocumentApprovalPendingGetTabularData
//                                                                             .data!
//                                                                             .findAllTableData![
//                                                                                 index]
//                                                                             .followUpDate
//                                                                             .toString() ==
//                                                                         'null')
//                                                                 ? ''
//                                                                 : lCPDocumentApprovalPendingViewModel
//                                                                     .lcpDocumentApprovalPendingGetTabularData
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
//                                                             (lCPDocumentApprovalPendingViewModel
//                                                                             .lcpDocumentApprovalPendingGetTabularData
//                                                                             .data!
//                                                                             .findAllTableData![
//                                                                                 index]
//                                                                             .costPerMile ==
//                                                                         null ||
//                                                                     lCPDocumentApprovalPendingViewModel
//                                                                             .lcpDocumentApprovalPendingGetTabularData
//                                                                             .data!
//                                                                             .findAllTableData![
//                                                                                 index]
//                                                                             .costPerMile
//                                                                             .toString() ==
//                                                                         'null')
//                                                                 ? ''
//                                                                 : lCPDocumentApprovalPendingViewModel
//                                                                     .lcpDocumentApprovalPendingGetTabularData
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
//                                                             (lCPDocumentApprovalPendingViewModel
//                                                                             .lcpDocumentApprovalPendingGetTabularData
//                                                                             .data!
//                                                                             .findAllTableData![
//                                                                                 index]
//                                                                             .totalCost ==
//                                                                         null ||
//                                                                     lCPDocumentApprovalPendingViewModel
//                                                                             .lcpDocumentApprovalPendingGetTabularData
//                                                                             .data!
//                                                                             .findAllTableData![
//                                                                                 index]
//                                                                             .totalCost
//                                                                             .toString() ==
//                                                                         'null')
//                                                                 ? ''
//                                                                 : lCPDocumentApprovalPendingViewModel
//                                                                     .lcpDocumentApprovalPendingGetTabularData
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
//                                                             (lCPDocumentApprovalPendingViewModel
//                                                                             .lcpDocumentApprovalPendingGetTabularData
//                                                                             .data!
//                                                                             .findAllTableData![
//                                                                                 index]
//                                                                             .estCost ==
//                                                                         null ||
//                                                                     lCPDocumentApprovalPendingViewModel
//                                                                             .lcpDocumentApprovalPendingGetTabularData
//                                                                             .data!
//                                                                             .findAllTableData![
//                                                                                 index]
//                                                                             .estCost
//                                                                             .toString() ==
//                                                                         'null')
//                                                                 ? ''
//                                                                 : lCPDocumentApprovalPendingViewModel
//                                                                     .lcpDocumentApprovalPendingGetTabularData
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
//                                                             (lCPDocumentApprovalPendingViewModel
//                                                                             .lcpDocumentApprovalPendingGetTabularData
//                                                                             .data!
//                                                                             .findAllTableData![
//                                                                                 index]
//                                                                             .estTime ==
//                                                                         null ||
//                                                                     lCPDocumentApprovalPendingViewModel
//                                                                             .lcpDocumentApprovalPendingGetTabularData
//                                                                             .data!
//                                                                             .findAllTableData![
//                                                                                 index]
//                                                                             .estTime
//                                                                             .toString() ==
//                                                                         'null')
//                                                                 ? ''
//                                                                 : lCPDocumentApprovalPendingViewModel
//                                                                     .lcpDocumentApprovalPendingGetTabularData
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
//                                                             (lCPDocumentApprovalPendingViewModel
//                                                                             .lcpDocumentApprovalPendingGetTabularData
//                                                                             .data!
//                                                                             .findAllTableData![
//                                                                                 index]
//                                                                             .actualCost ==
//                                                                         null ||
//                                                                     lCPDocumentApprovalPendingViewModel
//                                                                             .lcpDocumentApprovalPendingGetTabularData
//                                                                             .data!
//                                                                             .findAllTableData![
//                                                                                 index]
//                                                                             .actualCost
//                                                                             .toString() ==
//                                                                         'null')
//                                                                 ? ''
//                                                                 : lCPDocumentApprovalPendingViewModel
//                                                                     .lcpDocumentApprovalPendingGetTabularData
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
//                                                             (lCPDocumentApprovalPendingViewModel
//                                                                             .lcpDocumentApprovalPendingGetTabularData
//                                                                             .data!
//                                                                             .findAllTableData![
//                                                                                 index]
//                                                                             .nextMaintDue ==
//                                                                         null ||
//                                                                     lCPDocumentApprovalPendingViewModel
//                                                                             .lcpDocumentApprovalPendingGetTabularData
//                                                                             .data!
//                                                                             .findAllTableData![
//                                                                                 index]
//                                                                             .nextMaintDue
//                                                                             .toString() ==
//                                                                         'null')
//                                                                 ? ''
//                                                                 : lCPDocumentApprovalPendingViewModel
//                                                                     .lcpDocumentApprovalPendingGetTabularData
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
//                                                             (lCPDocumentApprovalPendingViewModel
//                                                                             .lcpDocumentApprovalPendingGetTabularData
//                                                                             .data!
//                                                                             .findAllTableData![
//                                                                                 index]
//                                                                             .createDate ==
//                                                                         null ||
//                                                                     lCPDocumentApprovalPendingViewModel
//                                                                             .lcpDocumentApprovalPendingGetTabularData
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
//                                                   Expanded(
//                                                     //  flex: 3,
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
//                                                             // Navigator.of(
//                                                             //         context)
//                                                             //     .push(MaterialPageRoute(
//                                                             //         builder: (BuildContext context) => MapViewAdmin(
//                                                             //               id: lCPDocumentApprovalPendingViewModel.lcpDocumentApprovalPendingGetTabularData.data!.findAllTableData![index].id.toString(),
//                                                             //             )));
//                                                             // Navigator.push(
//                                                             //   context,
//                                                             //   MaterialPageRoute(
//                                                             //     builder:
//                                                             //         (context) =>
//                                                             //             MapViewPage(
//                                                             //       url: MapUrl.getAdminEndPoint(
//                                                             //           lCPDocumentApprovalPendingViewModel
//                                                             //               .lcpDocumentApprovalPendingGetTabularData
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
//                                                                     // "https://mapapi.ariespro.com/main/admin/CIVM_Map/${lCPDocumentApprovalPendingViewModel.lcpDocumentApprovalPendingGetTabularData.data!.findAllTableData![index].tokenNo.toString()}/USRQWXH589Z"
//                                                                     MapUrl.getAdminEndPoint(lCPDocumentApprovalPendingViewModel
//                                                                         .lcpDocumentApprovalPendingGetTabularData
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
//       lCPDocumentApprovalPendingViewModel
//           .fetchLCPDocumentApprovalPendingTabularListApi(
//               context,
//               '',
//               'PENDING APPROVAL',
//               '',
//               '',
//               widget.budgetType,
//               widget.maintenanceType);
//     } else {
//       lCPDocumentApprovalPendingViewModel.lcpDocumentApprovalPendingGetTabularData.data!.findAllTableData = lCPDocumentApprovalPendingViewModel
//           .lcpDocumentApprovalPendingGetTabularData.data!.findAllTableData
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
//               item.contractor.toString().toLowerCase().contains(query.toLowerCase()) ||
//               item.nextMaintDue.toString().toLowerCase().contains(query.toLowerCase()))
//           .toList();
//     }
//     setState(() {});
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
//                     "Approve/Reject Work Order",
//                     style: TextStyle(
//                       fontSize: 20.0,
//                       color: AppColors.baseColor,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(top: 20.0),
//                     child: Text(
//                       "Work Order No. : ${id}",
//                       style: const TextStyle(
//                         fontSize: 16.0,
//                         color: AppColors.baseColor,
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
//                                 "Status",
//                                 style: TextStyle(
//                                   fontSize: 16.0,
//                                   color: AppColors.baseColor,
//                                 ),
//                               ),
//                             )),
//                         Align(
//                           alignment: Alignment.centerRight,
//                           child: Padding(
//                             padding: const EdgeInsets.all(2.0),
//                             child: Container(
//                               padding: const EdgeInsets.symmetric(
//                                   horizontal: 12, vertical: 4),
//                               // border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
//                               decoration: BoxDecoration(
//                                 // borderRadius: BorderRadius.circular(25),
//                                 border: Border.all(
//                                   color: AppColors.baseColor,
//                                 ),
//                               ),
//                               child: DropdownButtonHideUnderline(
//                                 child: DropdownButtonFormField<String>(
//                                   hint: const Text('-Select-'),
//                                   dropdownColor: Colors.white,
//                                   value: status,
//                                   style: const TextStyle(
//                                       color: AppColors.baseColor,
//                                       fontSize: 16),
//                                   icon: const Icon(
//                                     Icons.arrow_drop_down,
//                                     color: AppColors.baseColor,
//                                     size: 20,
//                                   ),
//                                   decoration: const InputDecoration(
//                                     enabledBorder: UnderlineInputBorder(
//                                         borderSide: BorderSide(
//                                             color: Colors.transparent)),
//                                     focusedBorder: UnderlineInputBorder(
//                                         borderSide: BorderSide(
//                                             color: Colors.transparent)),
//                                   ),
//                                   isExpanded: true,
//                                   items:
//                                       select_status.map(buildMenuItem).toList(),
//                                   onChanged: (value) {
//                                     setState(
//                                       () => status = value,
//                                     );
//                                     // String m = getMonthNum(month.toString());
//                                     // showLoaderDialog(context);
//                                     // print(m);
//                                     // print(m);
//                                     // getData(program.toString(), year.toString(),
//                                     //     (m.isEmpty) ? '0' : m, '0');
//                                   },
//                                   validator: (value) =>
//                                       value == null ? 'field required' : null,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         )
//                       ],
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
//                                   color: AppColors.baseColor,
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
//                                   color: AppColors.baseColor,
//                                   fontSize: 16),
//                               obscureText: false,
//                               // keyboardType: TextInputType.number,
//                               decoration: const InputDecoration(
//                                 border: OutlineInputBorder(),
//                                 enabledBorder: OutlineInputBorder(
//                                   borderSide: BorderSide(
//                                     color: AppColors.baseColor,
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
//                             lCPDocumentApprovalPendingViewModel
//                                 .fetchLCPDocumentPendingApprovalSubmitListApi(
//                                     context,
//                                     (status.toString() == 'APPROVE')
//                                         ? 'CLOSED'
//                                         // : 'PENDING',updated on 31/07/2024
//                                         : 'REJECTED',
//                                     _notes.text.toString(),
//                                     int.parse(id));
//                             print((status.toString() == 'APPROVE')
//                                 ? 'CLOSED'
//                                 : 'PENDING');
//                             // print(updatedCard);
//                             Navigator.pop(context);
//                             lCPDocumentApprovalPendingViewModel
//                                 .fetchLCPDocumentApprovalPendingTabularListApi(
//                                     context,
//                                     '',
//                                     'PENDING APPROVAL',
//                                     'LCP',
//                                     '',
//                                     widget.budgetType,
//                                     widget.maintenanceType);
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

//   void fetchData(String substationId, String status, String feeder) {
//     lCPDocumentApprovalPendingViewModel
//         .fetchLCPDocumentApprovalPendingTabularListApi(context, substationId,
//             status, '', feeder, widget.budgetType, widget.maintenanceType);
//   }

//   Future openDialogPicture(String tokenNo) => showDialog(
//         context: context,
//         builder: (context) {
//           return StatefulBuilder(builder: (context, setState) {
//             // lCPWorkOrdersClosedViewModel.fetchImageApi(
//             //     context,
//             //     //  '1');
//             //     tokenNo.toString());
//             int length = lCPDocumentApprovalPendingViewModel
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
//     String? imageLocation = lCPDocumentApprovalPendingViewModel
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
//                       // openFullSizeImageDialog(imageLocation);
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => ImagePaintScreen(
//                                   imageUrl: imageLocation, tokenNo: tokenNo)));
//                       print('image location-----$imageLocation');
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
//           backgroundColor: Colors.black,
//           insetPadding: EdgeInsets.zero,
//           child: //newcode
//               ImagePainter.network(
//             'https://atsdev2test.ariespro.com/assets/clientuploads/$imageUrl',
//             controller: _controller,
//             scalable: true,
//             textDelegate: TextDelegate(),
//           ),
//           //oldcode
//           //  PhotoViewGallery(
//           //   pageController: PageController(),
//           //   backgroundDecoration: const BoxDecoration(
//           //     color: Colors.black,
//           //   ),
//           //   onPageChanged: (index) {},
//           //   scrollPhysics: const BouncingScrollPhysics(),
//           //   pageOptions: [
//           //     PhotoViewGalleryPageOptions(
//           //       imageProvider: NetworkImage(
//           //         'https://atsdev2test.ariespro.com/assets/clientuploads/$imageUrl',
//           //       ),
//           //       minScale: PhotoViewComputedScale.contained * 0.5,
//           //       maxScale: PhotoViewComputedScale.covered * 0.5,
//           //     ),

//           //   ],
//           // ),
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
//         lCPDocumentApprovalPendingViewModel
//             .fetchLCPDocumentApprovalPendingTabularListApi(
//                 context,
//                 '',
//                 'PENDING APPROVAL',
//                 '',
//                 '',
//                 widget.budgetType,
//                 widget.maintenanceType);
//       } else {
//         print('API request failed with status code: ${response.statusCode}');
//         print('Response body: ${response.body}');
//       }
//     } catch (e) {
//       print('Error: $e');
//     }
//   }
// }
