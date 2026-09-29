// import 'dart:convert';
// import 'dart:io';
// import 'package:civm/data/response/status.dart';
// import 'package:civm/models/user_model.dart';
// import 'package:civm/screens/contractor_pannel/change_order_contractor.dart';
// import 'package:civm/screens/contractor_pannel/contractor_bottom_navigation.dart';
// import 'package:civm/screens/contractor_pannel/create_invoice_contractor.dart';
// import 'package:civm/screens/contractor_pannel/invoice_form_contractor.dart';
// import 'package:civm/screens/contractor_pannel/invoice_list_contractor.dart';
// import 'package:civm/screens/contractor_pannel/row_maintenance_progress_table.dart';
// import 'package:civm/screens/contractor_pannel/row_maintenance_update_map.dart';
// import 'package:civm/screens/contractor_pannel/change_order_pending_contractor.dart';
// import 'package:civm/screens/my_chrome_safari_map_recording.dart';
// import 'package:civm/utils/custom_toast_snackbar_progressdialog.dart';
// import 'package:civm/utils/user_pref.dart';
// import 'package:civm/view_model/contractor_row_maintenance_progress_view_model.dart';
// import 'package:device_info_plus/device_info_plus.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:intl/intl.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:provider/provider.dart';
// import '../login_page.dart';
// import 'package:http/http.dart' as http;
// import 'package:path/path.dart' as path;

// class RowMaintenanceProgressContractor extends StatefulWidget {
//   const RowMaintenanceProgressContractor({Key? key}) : super(key: key);

//   @override
//   State<RowMaintenanceProgressContractor> createState() =>
//       _RowMaintenanceProgressContractorState();
// }

// class _RowMaintenanceProgressContractorState
//     extends State<RowMaintenanceProgressContractor> {
//   final TextEditingController _totalMiles = TextEditingController();
//   final TextEditingController _milesCompleted = TextEditingController();
//   final TextEditingController _milesInProgress = TextEditingController();
//   final TextEditingController _milesPending = TextEditingController();
//   final TextEditingController _milesCompleted2 = TextEditingController();
//   final TextEditingController _milesInProgress2 = TextEditingController();
//   final TextEditingController _milesPending2 = TextEditingController();
//   final TextEditingController _affectedDays = TextEditingController();

//   List<String> menu = [];
//   final browser = MyChromeSafariBrowser();
//   // ignore: non_constant_identifier_names
//   final select_rowMethod = [
//     'Mechanical Bucket',
//     'Jarraff',
//     'Shear',
//     'Mulching Head',
//     'Mowing',
//     'Herbicide'
//   ];
//   // ignore: non_constant_identifier_names
//   String? rowMethod;

//   // ignore: non_constant_identifier_names
//   final select_delayCause = ['Weather Delay', 'Other Issues'];
//   // ignore: non_constant_identifier_names
//   String? delayCause;

//   // ignore: prefer_typing_uninitialized_variables, non_constant_identifier_names
//   var select_reason = ['', ''];
//   // ignore: non_constant_identifier_names
//   String? reason;

//   String datetime = DateTime.now().toString();

//   File? image;

//   bool _isVisibleImage = false;
//   bool _isVisibleImage2 = false;
//   bool _isVisibleImage3 = false;

//   bool _isVisibleUpdateMap = false;

//   // ignore: prefer_typing_uninitialized_variables
//   var deleteImage1;
//   // ignore: prefer_typing_uninitialized_variables
//   var deleteImage2;
//   // ignore: prefer_typing_uninitialized_variables
//   var deleteImage3;

//   onTappedBar(int index) {
//     setState(() {
//       // _currentIndex = index;
//     });
//   }

//   ContractorRowMaintenanceProgressViewModelViewModel
//       contractorRowMaintenanceProgressViewModelViewModel =
//       ContractorRowMaintenanceProgressViewModelViewModel();
//   // ignore: prefer_typing_uninitialized_variables
//   var selectedYear;
//   // ignore: prefer_typing_uninitialized_variables
//   var selectedSubstation;
//   late int subId;
//   // ignore: prefer_typing_uninitialized_variables
//   var selectedFeeder;
//   late int feederId;
//   // ignore: prefer_typing_uninitialized_variables
//   var selectedChangeOrderNo;
//   late int changeOrderNoId;
//   // ignore: prefer_typing_uninitialized_variables
//   var selectedCrew;
//   late int crewId;

//   File? image1;
//   File? image2;
//   File? image3;
//   String _imagePath = '';
//   String _imagePath2 = '';
//   String _imagePath3 = '';
//   // List<String> _imagePaths = [];
//   final _formkey = GlobalKey<FormState>();

//   @override
//   void initState() {
//     fetchData('', '', '', '');
//     setDataForCalculation();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//         appBar: AppBar(
//           iconTheme: const IconThemeData(color: Colors.white),
//           title: const Text(
//             'Row Progress Status',
//             style: TextStyle(color: Colors.white),
//           ),
//           backgroundColor: const Color.fromARGB(255, 7, 59, 120),
//           actions: <Widget>[
//             IconButton(
//               icon: const Icon(
//                 Icons.view_column,
//                 color: Colors.white,
//               ),
//               onPressed: () {
//                 Navigator.of(context).push(MaterialPageRoute(
//                     builder: (BuildContext context) =>
//                         const RowMaintenanceProgressContractorTable()));
//               },
//             )
//           ],
//         ),
//         drawer: DrawerManu(menu: menu),
//         body: ChangeNotifierProvider<
//                 ContractorRowMaintenanceProgressViewModelViewModel>(
//             create: (BuildContext context) =>
//                 contractorRowMaintenanceProgressViewModelViewModel,
//             child: Consumer<ContractorRowMaintenanceProgressViewModelViewModel>(
//                 builder: (context, value, _) {
//               switch (value
//                   .contractorRowMaintenanceProgressViewModelGetTabularData
//                   .status) {
//                 case Status.LOADING:
//                   return const Center(child: CircularProgressIndicator());
//                 case Status.ERROR:
//                   return CustomToastSnackBarProgressDialog.flushBarErrorMessage(
//                       value
//                           .contractorRowMaintenanceProgressViewModelGetTabularData
//                           .message
//                           .toString(),
//                       context);

//                 case Status.COMPLETED:
//                   printValue();
//                   return SingleChildScrollView(
//                       child: Form(
//                     key: _formkey,
//                     child: Column(children: [
//                       Container(
//                         margin: const EdgeInsets.only(
//                             left: 8, right: 8, top: 10, bottom: 8),
//                         padding: const EdgeInsets.all(8),
//                         alignment: Alignment.center,
//                         // height: size.height * 0.5,
//                         width: size.width * 0.99,
//                         decoration: BoxDecoration(
//                             // shape: BoxShape.circle,
//                             borderRadius: BorderRadius.circular(10),
//                             boxShadow: const [
//                               BoxShadow(
//                                   color: Color.fromARGB(255, 7, 59, 120),
//                                   blurRadius: 10,
//                                   offset: Offset(2.0, 5.0))
//                             ],
//                             gradient: const LinearGradient(
//                               colors: [
//                                 Color.fromARGB(255, 255, 255, 255),
//                                 Color.fromARGB(255, 255, 255, 255),
//                               ],
//                             )),
//                         child: Column(
//                           children: [
//                             Container(
//                               padding: const EdgeInsets.all(10),
//                               alignment: Alignment.center,
//                               width: size.width * 0.99,
//                               // width: MediaQuery.of(context).size.width,
//                               // height: 40,
//                               decoration: const BoxDecoration(
//                                   // shape: BoxShape.circle,
//                                   //borderRadius: BorderRadius.circular(25),
//                                   boxShadow: [
//                                     BoxShadow(
//                                         color: Color.fromARGB(255, 3, 47, 97),
//                                         blurRadius: 5,
//                                         offset: Offset(2.0, 5.0))
//                                   ],
//                                   gradient: LinearGradient(
//                                     colors: [
//                                       Color.fromARGB(255, 7, 59, 120),
//                                       Color.fromARGB(255, 7, 59, 120)
//                                     ],
//                                   )),
//                               child: const Row(children: [
//                                 Align(
//                                   alignment: Alignment.centerLeft,
//                                   child: Text(
//                                     "Filters",
//                                     textAlign: TextAlign.left,
//                                     style: TextStyle(
//                                       color: Colors.white,
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 20,
//                                     ),
//                                   ),
//                                 ),
//                               ]),
//                             ),
//                             SingleChildScrollView(
//                               scrollDirection: Axis.horizontal,
//                               child: Row(
//                                 children: [
//                                   Container(
//                                     margin: const EdgeInsets.only(top: 10),
//                                     child: Column(
//                                       children: [
//                                         const Align(
//                                             alignment: Alignment.centerLeft,
//                                             child: Padding(
//                                               padding: EdgeInsets.all(2.0),
//                                               child: Text(
//                                                 "YEAR",
//                                                 style: TextStyle(
//                                                   fontSize: 16.0,
//                                                   color: Color.fromARGB(
//                                                       255, 7, 59, 120),
//                                                   fontWeight: FontWeight.bold,
//                                                 ),
//                                               ),
//                                             )),
//                                         Align(
//                                           alignment: Alignment.centerLeft,
//                                           child: Padding(
//                                             padding: const EdgeInsets.all(2.0),
//                                             child: SizedBox(
//                                               width: 200,
//                                               child: DropdownButtonFormField<
//                                                   String>(
//                                                 hint: const Text('-Select-'),
//                                                 dropdownColor: Colors.white,
//                                                 value: selectedYear,
//                                                 style: const TextStyle(
//                                                     color: Color.fromARGB(
//                                                         255, 7, 59, 120),
//                                                     fontSize: 16),
//                                                 icon: const Icon(
//                                                   Icons.arrow_drop_down,
//                                                   color: Color.fromARGB(
//                                                       255, 7, 59, 120),
//                                                   size: 40,
//                                                 ),
//                                                 decoration:
//                                                     const InputDecoration(
//                                                   enabledBorder:
//                                                       OutlineInputBorder(
//                                                     borderSide: BorderSide(
//                                                       color: Color.fromARGB(
//                                                           255, 7, 59, 120),
//                                                     ),
//                                                   ),
//                                                   focusedBorder:
//                                                       OutlineInputBorder(
//                                                     borderSide: BorderSide(
//                                                       color: Color.fromARGB(
//                                                           255, 7, 59, 120),
//                                                     ),
//                                                   ),
//                                                 ),
//                                                 isExpanded: true,
//                                                 items: contractorRowMaintenanceProgressViewModelViewModel
//                                                     .contractorRowMaintenanceProgressViewModelGetTabularData
//                                                     .data!
//                                                     .findNextMaintDueBuyContractors!
//                                                     .map((e) {
//                                                   return DropdownMenuItem(
//                                                     value: e.nextMaintDues
//                                                         .toString(),
//                                                     // e.getIdAndSubstationByCountId![0].subStation.toString(),
//                                                     child: Text(e.nextMaintDues
//                                                         .toString()),
//                                                   );
//                                                 }).toList(),
//                                                 onChanged: (val) {
//                                                   if (selectedSubstation !=
//                                                           null ||
//                                                       selectedFeeder != null ||
//                                                       selectedChangeOrderNo !=
//                                                           null ||
//                                                       selectedCrew != null) {
//                                                     selectedSubstation = null;
//                                                     selectedFeeder = null;
//                                                     selectedChangeOrderNo =
//                                                         null;
//                                                     selectedCrew = null;
//                                                   }
//                                                   fetchData('', '', val!, '');
//                                                   setState(() {
//                                                     selectedYear = val;
//                                                   });
//                                                 },
//                                                 validator: (value) =>
//                                                     value == null
//                                                         ? 'field required'
//                                                         : null,
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   Container(
//                                     margin: const EdgeInsets.only(top: 10),
//                                     child: Column(
//                                       children: [
//                                         const Align(
//                                             alignment: Alignment.centerLeft,
//                                             child: Padding(
//                                               padding: EdgeInsets.all(2.0),
//                                               child: Text(
//                                                 "SUBSTATION",
//                                                 style: TextStyle(
//                                                   fontSize: 16.0,
//                                                   color: Color.fromARGB(
//                                                       255, 7, 59, 120),
//                                                   fontWeight: FontWeight.bold,
//                                                 ),
//                                               ),
//                                             )),
//                                         Align(
//                                           alignment: Alignment.centerLeft,
//                                           child: Padding(
//                                             padding: const EdgeInsets.all(2.0),
//                                             child: SizedBox(
//                                               width: 200,
//                                               child: DropdownButtonFormField<
//                                                   String>(
//                                                 hint: const Text('-Select-'),
//                                                 dropdownColor:
//                                                     const Color.fromRGBO(
//                                                         255, 255, 255, 1),
//                                                 value: selectedSubstation,
//                                                 style: const TextStyle(
//                                                     color: Color.fromARGB(
//                                                         255, 7, 59, 120),
//                                                     fontSize: 16),
//                                                 icon: const Icon(
//                                                   Icons.arrow_drop_down,
//                                                   color: Color.fromARGB(
//                                                       255, 7, 59, 120),
//                                                   size: 40,
//                                                 ),
//                                                 decoration:
//                                                     const InputDecoration(
//                                                   enabledBorder:
//                                                       OutlineInputBorder(
//                                                     borderSide: BorderSide(
//                                                       color: Color.fromARGB(
//                                                           255, 7, 59, 120),
//                                                     ),
//                                                   ),
//                                                   focusedBorder:
//                                                       OutlineInputBorder(
//                                                     borderSide: BorderSide(
//                                                       color: Color.fromARGB(
//                                                           255, 7, 59, 120),
//                                                     ),
//                                                   ),
//                                                 ),
//                                                 isExpanded: true,
//                                                 items: contractorRowMaintenanceProgressViewModelViewModel
//                                                     .contractorRowMaintenanceProgressViewModelGetTabularData
//                                                     .data!
//                                                     .findSubstationByContractorAndNextMaintDues!
//                                                     .map((e) {
//                                                   return DropdownMenuItem(
//                                                     value: e.subId.toString(),
//                                                     // e.getIdAndSubstationByCountId![0].subStation.toString(),
//                                                     child: Text(e.subStation
//                                                         .toString()),
//                                                   );
//                                                 }).toList(),
//                                                 onChanged: (val) {
//                                                   if (selectedFeeder != null ||
//                                                       selectedChangeOrderNo !=
//                                                           null ||
//                                                       selectedCrew != null) {
//                                                     selectedFeeder = null;
//                                                     selectedChangeOrderNo =
//                                                         null;
//                                                     selectedCrew = null;
//                                                   }
//                                                   fetchData(val!, '',
//                                                       selectedYear, '');
//                                                   subId = int.parse(val);
//                                                   setState(() {
//                                                     selectedSubstation = val;
//                                                   });
//                                                 },
//                                                 validator: (value) =>
//                                                     value == null
//                                                         ? 'field required'
//                                                         : null,
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   Container(
//                                     margin: const EdgeInsets.only(top: 10),
//                                     child: Column(
//                                       children: [
//                                         const Align(
//                                             alignment: Alignment.centerLeft,
//                                             child: Padding(
//                                               padding: EdgeInsets.all(2.0),
//                                               child: Text(
//                                                 "FEEDER",
//                                                 style: TextStyle(
//                                                   fontSize: 16.0,
//                                                   color: Color.fromARGB(
//                                                       255, 7, 59, 120),
//                                                   fontWeight: FontWeight.bold,
//                                                 ),
//                                               ),
//                                             )),
//                                         Align(
//                                           alignment: Alignment.centerLeft,
//                                           child: Padding(
//                                             padding: const EdgeInsets.all(2.0),
//                                             child: SizedBox(
//                                               width: 200,
//                                               child: DropdownButtonFormField<
//                                                   String>(
//                                                 hint: const Text('-Select-'),
//                                                 dropdownColor: Colors.white,
//                                                 value: selectedFeeder,
//                                                 style: const TextStyle(
//                                                     color: Color.fromARGB(
//                                                         255, 7, 59, 120),
//                                                     fontSize: 16),
//                                                 icon: const Icon(
//                                                   Icons.arrow_drop_down,
//                                                   color: Color.fromARGB(
//                                                       255, 7, 59, 120),
//                                                   size: 40,
//                                                 ),
//                                                 decoration:
//                                                     const InputDecoration(
//                                                   enabledBorder:
//                                                       OutlineInputBorder(
//                                                     borderSide: BorderSide(
//                                                       color: Color.fromARGB(
//                                                           255, 7, 59, 120),
//                                                     ),
//                                                   ),
//                                                   focusedBorder:
//                                                       OutlineInputBorder(
//                                                     borderSide: BorderSide(
//                                                       color: Color.fromARGB(
//                                                           255, 7, 59, 120),
//                                                     ),
//                                                   ),
//                                                 ),
//                                                 isExpanded: true,
//                                                 items: contractorRowMaintenanceProgressViewModelViewModel
//                                                     .contractorRowMaintenanceProgressViewModelGetTabularData
//                                                     .data!
//                                                     .findAllByContractorAndNextMaintDueAndSubstation!
//                                                     .map((e) {
//                                                   return DropdownMenuItem(
//                                                     value: e.fdrId.toString(),
//                                                     // e.getIdAndSubstationByCountId![0].subStation.toString(),
//                                                     child: Text(
//                                                         e.fdrName.toString()),
//                                                   );
//                                                 }).toList(),
//                                                 onChanged: (val) {
//                                                   if (selectedChangeOrderNo !=
//                                                           null ||
//                                                       selectedCrew != null) {
//                                                     selectedChangeOrderNo =
//                                                         null;
//                                                     selectedCrew = null;
//                                                   }
//                                                   fetchData(subId.toString(),
//                                                       val!, selectedYear, '');
//                                                   feederId = int.parse(val);
//                                                   setState(() {
//                                                     selectedFeeder = val;
//                                                   });
//                                                 },
//                                                 validator: (value) =>
//                                                     value == null
//                                                         ? 'field required'
//                                                         : null,
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   Container(
//                                     margin: const EdgeInsets.only(top: 10),
//                                     child: Column(
//                                       children: [
//                                         const Align(
//                                             alignment: Alignment.centerLeft,
//                                             child: Padding(
//                                               padding: EdgeInsets.all(2.0),
//                                               child: Text(
//                                                 "CHANGE ORDER NO",
//                                                 style: TextStyle(
//                                                   fontSize: 16.0,
//                                                   color: Color.fromARGB(
//                                                       255, 7, 59, 120),
//                                                   fontWeight: FontWeight.bold,
//                                                 ),
//                                               ),
//                                             )),
//                                         Align(
//                                           alignment: Alignment.centerLeft,
//                                           child: Padding(
//                                             padding: const EdgeInsets.all(2.0),
//                                             child: SizedBox(
//                                               width: 200,
//                                               child: DropdownButtonFormField<
//                                                   String>(
//                                                 hint: const Text('-Select-'),
//                                                 dropdownColor: Colors.white,
//                                                 value: selectedChangeOrderNo,
//                                                 style: const TextStyle(
//                                                     color: Color.fromARGB(
//                                                         255, 7, 59, 120),
//                                                     fontSize: 16),
//                                                 icon: const Icon(
//                                                   Icons.arrow_drop_down,
//                                                   color: Color.fromARGB(
//                                                       255, 7, 59, 120),
//                                                   size: 40,
//                                                 ),
//                                                 decoration:
//                                                     const InputDecoration(
//                                                   enabledBorder:
//                                                       OutlineInputBorder(
//                                                     borderSide: BorderSide(
//                                                       color: Color.fromARGB(
//                                                           255, 7, 59, 120),
//                                                     ),
//                                                   ),
//                                                   focusedBorder:
//                                                       OutlineInputBorder(
//                                                     borderSide: BorderSide(
//                                                       color: Color.fromARGB(
//                                                           255, 7, 59, 120),
//                                                     ),
//                                                   ),
//                                                 ),
//                                                 isExpanded: true,
//                                                 items: contractorRowMaintenanceProgressViewModelViewModel
//                                                     .contractorRowMaintenanceProgressViewModelGetTabularData
//                                                     .data!
//                                                     .findTokenNoBySubstationAndFeederAndNextMaintsDue!
//                                                     .map((e) {
//                                                   return DropdownMenuItem(
//                                                     value: e.tokenNo.toString(),
//                                                     // e.getIdAndSubstationByCountId![0].subStation.toString(),
//                                                     child: Text(
//                                                         e.tokenNo.toString()),
//                                                   );
//                                                 }).toList(),
//                                                 onChanged: (val) {
//                                                   if (selectedCrew != null) {
//                                                     selectedCrew = null;
//                                                   }
//                                                   fetchData(
//                                                       selectedSubstation,
//                                                       selectedFeeder,
//                                                       selectedYear,
//                                                       val!);
//                                                   // workOrderNoId = int.parse(val);
//                                                   setState(() {
//                                                     selectedChangeOrderNo = val;
//                                                   });
//                                                   _isVisibleUpdateMap = true;
//                                                 },
//                                                 validator: (value) =>
//                                                     value == null
//                                                         ? 'field required'
//                                                         : null,
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   Container(
//                                     margin: const EdgeInsets.only(top: 10),
//                                     child: Column(
//                                       children: [
//                                         const Align(
//                                             alignment: Alignment.centerLeft,
//                                             child: Padding(
//                                               padding: EdgeInsets.all(2.0),
//                                               child: Text(
//                                                 "CREW",
//                                                 style: TextStyle(
//                                                   fontSize: 16.0,
//                                                   color: Color.fromARGB(
//                                                       255, 7, 59, 120),
//                                                   fontWeight: FontWeight.bold,
//                                                 ),
//                                               ),
//                                             )),
//                                         Align(
//                                           alignment: Alignment.centerLeft,
//                                           child: Padding(
//                                             padding: const EdgeInsets.all(2.0),
//                                             child: SizedBox(
//                                               width: 200,
//                                               child: DropdownButtonFormField<
//                                                       String>(
//                                                   hint: const Text('-Select-'),
//                                                   dropdownColor: Colors.white,
//                                                   value: selectedCrew,
//                                                   style: const TextStyle(
//                                                       color: Color.fromARGB(
//                                                           255, 7, 59, 120),
//                                                       fontSize: 16),
//                                                   icon: const Icon(
//                                                     Icons.arrow_drop_down,
//                                                     color: Color.fromARGB(
//                                                         255, 7, 59, 120),
//                                                     size: 40,
//                                                   ),
//                                                   decoration:
//                                                       const InputDecoration(
//                                                     enabledBorder:
//                                                         OutlineInputBorder(
//                                                       borderSide: BorderSide(
//                                                         color: Color.fromARGB(
//                                                             255, 7, 59, 120),
//                                                       ),
//                                                     ),
//                                                     focusedBorder:
//                                                         OutlineInputBorder(
//                                                       borderSide: BorderSide(
//                                                         color: Color.fromARGB(
//                                                             255, 7, 59, 120),
//                                                       ),
//                                                     ),
//                                                   ),
//                                                   isExpanded: true,
//                                                   items: contractorRowMaintenanceProgressViewModelViewModel
//                                                       .contractorRowMaintenanceProgressViewModelGetTabularData
//                                                       .data!
//                                                       .findCrewOrderNo!
//                                                       .map((e) {
//                                                     return DropdownMenuItem(
//                                                       value: e.crew.toString(),
//                                                       // e.getIdAndSubstationByCountId![0].subStation.toString(),
//                                                       child: Text(
//                                                           e.crew.toString()),
//                                                     );
//                                                   }).toList(),
//                                                   onChanged: (val) {
//                                                     setState(() {
//                                                       selectedCrew = val;
//                                                     });
//                                                     fetchData(
//                                                         selectedSubstation,
//                                                         selectedFeeder,
//                                                         selectedYear,
//                                                         selectedChangeOrderNo);
//                                                     // crewId = int.parse(val!);
//                                                   },
//                                                   validator: (value) {
//                                                     value == null
//                                                         ? 'field required'
//                                                         : null;
//                                                   }),
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       Container(
//                           margin: const EdgeInsets.only(
//                               left: 8, right: 8, top: 10, bottom: 8),
//                           padding: const EdgeInsets.all(8),
//                           alignment: Alignment.center,
//                           // height: size.height * 0.5,
//                           width: size.width * 0.99,
//                           decoration: BoxDecoration(
//                               // shape: BoxShape.circle,
//                               borderRadius: BorderRadius.circular(10),
//                               boxShadow: const [
//                                 BoxShadow(
//                                     color: Color.fromARGB(255, 7, 59, 120),
//                                     blurRadius: 10,
//                                     offset: Offset(2.0, 5.0))
//                               ],
//                               gradient: const LinearGradient(
//                                 colors: [
//                                   Color.fromARGB(255, 255, 255, 255),
//                                   Color.fromARGB(255, 255, 255, 255),
//                                 ],
//                               )),
//                           child: Column(
//                             children: [
//                               Container(
//                                 padding: const EdgeInsets.all(10),
//                                 alignment: Alignment.center,
//                                 width: size.width * 0.99,
//                                 // width: MediaQuery.of(context).size.width,
//                                 // height: 40,
//                                 decoration: const BoxDecoration(
//                                     // shape: BoxShape.circle,
//                                     //borderRadius: BorderRadius.circular(25),
//                                     boxShadow: [
//                                       BoxShadow(
//                                           color: Color.fromARGB(255, 3, 47, 97),
//                                           blurRadius: 5,
//                                           offset: Offset(2.0, 5.0))
//                                     ],
//                                     gradient: LinearGradient(
//                                       colors: [
//                                         Color.fromARGB(255, 7, 59, 120),
//                                         Color.fromARGB(255, 7, 59, 120)
//                                       ],
//                                     )),
//                                 child: const Row(children: [
//                                   Align(
//                                     alignment: Alignment.centerLeft,
//                                     child: Text(
//                                       "Prev Progress",
//                                       textAlign: TextAlign.left,
//                                       style: TextStyle(
//                                         color: Colors.white,
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 20,
//                                       ),
//                                     ),
//                                   ),
//                                 ]),
//                               ),
//                               Column(
//                                 children: [
//                                   const Align(
//                                       alignment: Alignment.centerLeft,
//                                       child: Padding(
//                                         padding: EdgeInsets.only(
//                                             left: 2.0,
//                                             right: 2.0,
//                                             bottom: 2.0,
//                                             top: 20.0),
//                                         child: Text(
//                                           "TOTAL MILES",
//                                           style: TextStyle(
//                                               fontSize: 16,
//                                               color: Color.fromARGB(
//                                                   255, 7, 59, 120),
//                                               fontWeight: FontWeight.bold),
//                                         ),
//                                       )),
//                                   Align(
//                                     alignment: Alignment.centerRight,
//                                     child: Padding(
//                                       padding: const EdgeInsets.all(2.0),
//                                       child: TextFormField(
//                                         enabled: false,
//                                         //key: formkey4,
//                                         controller: _totalMiles,
//                                         style: const TextStyle(
//                                             color:
//                                                 Color.fromARGB(255, 7, 59, 120),
//                                             fontSize: 16),
//                                         obscureText: false,
//                                         keyboardType: TextInputType.number,
//                                         decoration: const InputDecoration(
//                                           border: OutlineInputBorder(
//                                               // borderRadius:
//                                               //     BorderRadius.circular(25),
//                                               ),
//                                           enabledBorder: OutlineInputBorder(
//                                             borderSide: BorderSide(
//                                               color: Color.fromARGB(
//                                                   255, 7, 59, 120),
//                                             ),
//                                             // borderRadius:
//                                             //     BorderRadius.circular(25),
//                                           ),
//                                           disabledBorder: OutlineInputBorder(
//                                             borderSide: BorderSide(
//                                               color: Color.fromARGB(
//                                                   255, 7, 59, 120),
//                                             ),

//                                             // borderRadius:
//                                             //     BorderRadius.circular(25),
//                                           ),
//                                           hintText: 'TOTAL MILES',
//                                         ),
//                                         validator: (value) {
//                                           if (value!.isEmpty) {
//                                             return "Please enter Total Miles";
//                                           } else {
//                                             return null;
//                                           }
//                                         },
//                                       ),
//                                     ),
//                                   ),
//                                   const Align(
//                                       alignment: Alignment.centerLeft,
//                                       child: Padding(
//                                         padding: EdgeInsets.only(
//                                             left: 2.0,
//                                             right: 2.0,
//                                             bottom: 2.0,
//                                             top: 20.0),
//                                         child: Text(
//                                           "MILES COMPLETED",
//                                           style: TextStyle(
//                                             fontSize: 16.0,
//                                             color:
//                                                 Color.fromARGB(255, 7, 59, 120),
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                         ),
//                                       )),
//                                   Align(
//                                     alignment: Alignment.centerRight,
//                                     child: Padding(
//                                       padding: const EdgeInsets.all(2.0),
//                                       child: TextFormField(
//                                         enabled: false,
//                                         //key: formkey4,
//                                         controller: _milesCompleted,
//                                         style: const TextStyle(
//                                             color:
//                                                 Color.fromARGB(255, 7, 59, 120),
//                                             fontSize: 16),
//                                         obscureText: false,
//                                         keyboardType: TextInputType.number,
//                                         decoration: const InputDecoration(
//                                           border: OutlineInputBorder(
//                                               // borderRadius:
//                                               //     BorderRadius.circular(25),
//                                               ),
//                                           enabledBorder: OutlineInputBorder(
//                                             borderSide: BorderSide(
//                                               color: Color.fromARGB(
//                                                   255, 7, 59, 120),
//                                             ),
//                                             // borderRadius:
//                                             //     BorderRadius.circular(25),
//                                           ),
//                                           disabledBorder: OutlineInputBorder(
//                                             borderSide: BorderSide(
//                                               color: Color.fromARGB(
//                                                   255, 7, 59, 120),
//                                             ),

//                                             // borderRadius:
//                                             //     BorderRadius.circular(25),
//                                           ),
//                                           hintText: 'Miles Completed',
//                                         ),
//                                         validator: (value) {
//                                           if (value!.isEmpty) {
//                                             return "Please enter Miles Completed";
//                                           } else {
//                                             return null;
//                                           }
//                                         },
//                                       ),
//                                     ),
//                                   ),
//                                   const Align(
//                                       alignment: Alignment.centerLeft,
//                                       child: Padding(
//                                         padding: EdgeInsets.only(
//                                             left: 2.0,
//                                             right: 2.0,
//                                             bottom: 2.0,
//                                             top: 20.0),
//                                         child: Text(
//                                           "MILES IN PROGRESS",
//                                           style: TextStyle(
//                                             fontSize: 16.0,
//                                             color:
//                                                 Color.fromARGB(255, 7, 59, 120),
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                         ),
//                                       )),
//                                   Align(
//                                     alignment: Alignment.centerRight,
//                                     child: Padding(
//                                       padding: const EdgeInsets.all(2.0),
//                                       child: TextFormField(
//                                         enabled: false,
//                                         //key: formkey4,
//                                         controller: _milesInProgress,
//                                         style: const TextStyle(
//                                             color:
//                                                 Color.fromARGB(255, 7, 59, 120),
//                                             fontSize: 16),
//                                         obscureText: false,
//                                         keyboardType: TextInputType.number,
//                                         decoration: const InputDecoration(
//                                           border: OutlineInputBorder(
//                                               // borderRadius:
//                                               //     BorderRadius.circular(25),
//                                               ),
//                                           enabledBorder: OutlineInputBorder(
//                                             borderSide: BorderSide(
//                                               color: Color.fromARGB(
//                                                   255, 7, 59, 120),
//                                             ),
//                                             // borderRadius:
//                                             //     BorderRadius.circular(25),
//                                           ),
//                                           disabledBorder: OutlineInputBorder(
//                                             borderSide: BorderSide(
//                                               color: Color.fromARGB(
//                                                   255, 7, 59, 120),
//                                             ),

//                                             // borderRadius:
//                                             //     BorderRadius.circular(25),
//                                           ),
//                                           hintText: 'Miles In Progress',
//                                         ),
//                                         validator: (value) {
//                                           if (value!.isEmpty) {
//                                             return "Please enter Miles In Progress";
//                                           } else {
//                                             return null;
//                                           }
//                                         },
//                                       ),
//                                     ),
//                                   ),
//                                   const Align(
//                                       alignment: Alignment.centerLeft,
//                                       child: Padding(
//                                         padding: EdgeInsets.only(
//                                             left: 2.0,
//                                             right: 2.0,
//                                             bottom: 2.0,
//                                             top: 20.0),
//                                         child: Text(
//                                           "MILES PENDING",
//                                           style: TextStyle(
//                                             fontSize: 16.0,
//                                             color:
//                                                 Color.fromARGB(255, 7, 59, 120),
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                         ),
//                                       )),
//                                   Align(
//                                     alignment: Alignment.centerRight,
//                                     child: Padding(
//                                       padding: const EdgeInsets.all(2.0),
//                                       child: TextFormField(
//                                         enabled: false,
//                                         //  key: formkey5,
//                                         controller: _milesPending,
//                                         style: const TextStyle(
//                                             color:
//                                                 Color.fromARGB(255, 7, 59, 120),
//                                             fontSize: 16),
//                                         obscureText: false,
//                                         keyboardType: TextInputType.number,
//                                         decoration: const InputDecoration(
//                                           border: OutlineInputBorder(
//                                               // borderRadius:
//                                               //     BorderRadius.circular(25),
//                                               ),
//                                           enabledBorder: OutlineInputBorder(
//                                             borderSide: BorderSide(
//                                               color: Color.fromARGB(
//                                                   255, 7, 59, 120),
//                                             ),

//                                             // borderRadius:
//                                             //     BorderRadius.circular(25),
//                                           ),
//                                           disabledBorder: OutlineInputBorder(
//                                             borderSide: BorderSide(
//                                               color: Color.fromARGB(
//                                                   255, 7, 59, 120),
//                                             ),

//                                             // borderRadius:
//                                             //     BorderRadius.circular(25),
//                                           ),
//                                           hintText: 'Miles Pending',
//                                         ),
//                                         validator: (value) {
//                                           if (value!.isEmpty) {
//                                             return "Please enter Miles Pending";
//                                           } else {
//                                             return null;
//                                           }
//                                         },
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           )),
//                       Container(
//                           margin: const EdgeInsets.only(
//                               left: 8, right: 8, top: 10, bottom: 8),
//                           padding: const EdgeInsets.all(8),
//                           alignment: Alignment.center,
//                           // height: size.height * 0.5,
//                           width: size.width * 0.99,
//                           decoration: BoxDecoration(
//                               // shape: BoxShape.circle,
//                               borderRadius: BorderRadius.circular(10),
//                               boxShadow: const [
//                                 BoxShadow(
//                                     color: Color.fromARGB(255, 7, 59, 120),
//                                     blurRadius: 10,
//                                     offset: Offset(2.0, 5.0))
//                               ],
//                               gradient: const LinearGradient(
//                                 colors: [
//                                   Color.fromARGB(255, 255, 255, 255),
//                                   Color.fromARGB(255, 255, 255, 255),
//                                 ],
//                               )),
//                           child: Column(
//                             children: [
//                               Container(
//                                 padding: const EdgeInsets.all(10),
//                                 alignment: Alignment.center,
//                                 width: size.width * 0.99,
//                                 // width: MediaQuery.of(context).size.width,
//                                 // height: 40,
//                                 decoration: const BoxDecoration(
//                                     // shape: BoxShape.circle,
//                                     //borderRadius: BorderRadius.circular(25),
//                                     boxShadow: [
//                                       BoxShadow(
//                                           color: Color.fromARGB(255, 3, 47, 97),
//                                           blurRadius: 5,
//                                           offset: Offset(2.0, 5.0))
//                                     ],
//                                     gradient: LinearGradient(
//                                       colors: [
//                                         Color.fromARGB(255, 7, 59, 120),
//                                         Color.fromARGB(255, 7, 59, 120)
//                                       ],
//                                     )),
//                                 child: const Row(children: [
//                                   Align(
//                                     alignment: Alignment.centerLeft,
//                                     child: Text(
//                                       "(+) Add Current Progress",
//                                       textAlign: TextAlign.left,
//                                       style: TextStyle(
//                                         color: Colors.white,
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 20,
//                                       ),
//                                     ),
//                                   ),
//                                 ]),
//                               ),
//                               Column(
//                                 children: [
//                                   (contractorRowMaintenanceProgressViewModelViewModel
//                                               .contractorRowMaintenanceProgressViewModelGetTabularData
//                                               .data!
//                                               .findAllByTokenNumbers!
//                                               .isNotEmpty &&
//                                           contractorRowMaintenanceProgressViewModelViewModel
//                                                   .contractorRowMaintenanceProgressViewModelGetTabularData
//                                                   .data!
//                                                   .findAllByTokenNumbers !=
//                                               null &&
//                                           contractorRowMaintenanceProgressViewModelViewModel
//                                               .contractorRowMaintenanceProgressViewModelGetTabularData
//                                               .data!
//                                               .findAllByTokenNumbers![0]
//                                               .totalMiles!
//                                               .isNotEmpty &&
//                                           contractorRowMaintenanceProgressViewModelViewModel
//                                                   .contractorRowMaintenanceProgressViewModelGetTabularData
//                                                   .data!
//                                                   .findAllByTokenNumbers![0]
//                                                   .totalMiles !=
//                                               null &&
//                                           contractorRowMaintenanceProgressViewModelViewModel
//                                                   .contractorRowMaintenanceProgressViewModelGetTabularData
//                                                   .data!
//                                                   .findAllByTokenNumbers![0]
//                                                   .milesCompleted !=
//                                               null &&
//                                           (double.parse(
//                                                   contractorRowMaintenanceProgressViewModelViewModel
//                                                       .contractorRowMaintenanceProgressViewModelGetTabularData
//                                                       .data!
//                                                       .findAllByTokenNumbers![0]
//                                                       .totalMiles
//                                                       .toString()) ==
//                                               double.parse(
//                                                   contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.findAllByTokenNumbers![0].milesCompleted.toString())))
//                                       ? const Align(
//                                           alignment: Alignment.centerLeft,
//                                           child: Padding(
//                                             padding: EdgeInsets.only(
//                                                 left: 2.0,
//                                                 right: 2.0,
//                                                 bottom: 2.0,
//                                                 top: 20.0),
//                                             child: Text(
//                                               "Your MILES are already COMPLETED!",
//                                               style: TextStyle(
//                                                 fontSize: 16.0,
//                                                 color: Colors.red,
//                                                 fontWeight: FontWeight.bold,
//                                               ),
//                                             ),
//                                           ))
//                                       : const Text(
//                                           "",
//                                           style: TextStyle(
//                                             fontSize: 0.0,
//                                             color: Colors.white,
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                         ),
//                                   const Align(
//                                       alignment: Alignment.centerLeft,
//                                       child: Padding(
//                                         padding: EdgeInsets.only(
//                                             left: 2.0,
//                                             right: 2.0,
//                                             bottom: 2.0,
//                                             top: 20.0),
//                                         child: Text(
//                                           "MILES COMPLETED*",
//                                           style: TextStyle(
//                                             fontSize: 16.0,
//                                             color:
//                                                 Color.fromARGB(255, 7, 59, 120),
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                         ),
//                                       )),
//                                   Align(
//                                     alignment: Alignment.centerRight,
//                                     child: Padding(
//                                       padding: const EdgeInsets.all(2.0),
//                                       child: TextFormField(
//                                         //key: formkey4,
//                                         controller: _milesCompleted2,
//                                         style: const TextStyle(
//                                             color:
//                                                 Color.fromARGB(255, 7, 59, 120),
//                                             fontSize: 16),
//                                         obscureText: false,
//                                         // keyboardType: TextInputType.number,
//                                         keyboardType: const TextInputType
//                                             .numberWithOptions(
//                                           decimal: true,
//                                           signed: false,
//                                         ),
//                                         decoration: const InputDecoration(
//                                           border: OutlineInputBorder(
//                                               // borderRadius:
//                                               //     BorderRadius.circular(25),
//                                               ),
//                                           enabledBorder: OutlineInputBorder(
//                                             borderSide: BorderSide(
//                                               color: Color.fromARGB(
//                                                   255, 7, 59, 120),
//                                             ),
//                                             // borderRadius:
//                                             //     BorderRadius.circular(25),
//                                           ),
//                                           hintText: 'Miles Completed',
//                                         ),
//                                         onChanged: (value) {
//                                           setState(() {
//                                             // int milesInProgress = int.tryParse(_milesInProgress2.text) ?? 0;
//                                             calculateMilesPending(
//                                               double.parse(value),
//                                               double.parse(
//                                                   _milesInProgress2.text),
//                                               _milesPending2,
//                                             );
//                                           });
//                                         },
//                                         validator: (value) {
//                                           if (value!.isEmpty) {
//                                             print('111111111111');
//                                             return "Please enter Miles Completed";
//                                           } else if (double.parse((double.parse(value) +
//                                                       double.parse(
//                                                           contractorRowMaintenanceProgressViewModelViewModel
//                                                               .contractorRowMaintenanceProgressViewModelGetTabularData
//                                                               .data!
//                                                               .findAllByTokenNumbers![
//                                                                   0]
//                                                               .milesCompleted
//                                                               .toString()) +
//                                                       double.parse(
//                                                           contractorRowMaintenanceProgressViewModelViewModel
//                                                               .contractorRowMaintenanceProgressViewModelGetTabularData
//                                                               .data!
//                                                               .findAllByTokenNumbers![
//                                                                   0]
//                                                               .milesInProgress
//                                                               .toString()))
//                                                   .toStringAsFixed(2)) >
//                                               double.parse(
//                                                   contractorRowMaintenanceProgressViewModelViewModel
//                                                       .contractorRowMaintenanceProgressViewModelGetTabularData
//                                                       .data!
//                                                       .findAllByTokenNumbers![0]
//                                                       .totalMiles
//                                                       .toString())) {
//                                             print('12345678899');
//                                             print(double.parse(value) +
//                                                 double.parse(
//                                                     contractorRowMaintenanceProgressViewModelViewModel
//                                                         .contractorRowMaintenanceProgressViewModelGetTabularData
//                                                         .data!
//                                                         .findAllByTokenNumbers![
//                                                             0]
//                                                         .milesCompleted
//                                                         .toString()) +
//                                                 double.parse(
//                                                     contractorRowMaintenanceProgressViewModelViewModel
//                                                         .contractorRowMaintenanceProgressViewModelGetTabularData
//                                                         .data!
//                                                         .findAllByTokenNumbers![
//                                                             0]
//                                                         .milesInProgress
//                                                         .toString()));
//                                             print(double.parse(
//                                                 contractorRowMaintenanceProgressViewModelViewModel
//                                                     .contractorRowMaintenanceProgressViewModelGetTabularData
//                                                     .data!
//                                                     .findAllByTokenNumbers![0]
//                                                     .totalMiles
//                                                     .toString()));
//                                             return "Incorrect value in miles completed";
//                                           }

//                                           // try {
//                                           //   double parsedValue =
//                                           //       double.parse(value);
//                                           //   if (parsedValue % 1 != 0) {
//                                           //     return "Entered value should be an integer, not a float value";
//                                           //   }
//                                           // } catch (e) {
//                                           //   return "Invalid input. Please enter a numeric value.";
//                                           // }
//                                           if (double.parse(
//                                                   contractorRowMaintenanceProgressViewModelViewModel
//                                                       .contractorRowMaintenanceProgressViewModelGetTabularData
//                                                       .data!
//                                                       .findAllByTokenNumbers![0]
//                                                       .totalMiles
//                                                       .toString()) ==
//                                               double.parse(
//                                                   contractorRowMaintenanceProgressViewModelViewModel
//                                                       .contractorRowMaintenanceProgressViewModelGetTabularData
//                                                       .data!
//                                                       .findAllByTokenNumbers![0]
//                                                       .milesCompleted
//                                                       .toString())) {
//                                             return "Your MILES are already COMPLETED!";
//                                           } else {
//                                             print('success in validation');
//                                             return null;
//                                           }
//                                         },
//                                       ),
//                                     ),
//                                   ),
//                                   const Align(
//                                       alignment: Alignment.centerLeft,
//                                       child: Padding(
//                                         padding: EdgeInsets.only(
//                                             left: 2.0,
//                                             right: 2.0,
//                                             bottom: 2.0,
//                                             top: 20.0),
//                                         child: Text(
//                                           "MILES IN PROGRESS*",
//                                           style: TextStyle(
//                                             fontSize: 16.0,
//                                             color:
//                                                 Color.fromARGB(255, 7, 59, 120),
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                         ),
//                                       )),
//                                   Align(
//                                     alignment: Alignment.centerRight,
//                                     child: Padding(
//                                       padding: const EdgeInsets.all(2.0),
//                                       child: TextFormField(
//                                         //key: formkey4,
//                                         controller: _milesInProgress2,
//                                         style: const TextStyle(
//                                             color:
//                                                 Color.fromARGB(255, 7, 59, 120),
//                                             fontSize: 16),
//                                         obscureText: false,
//                                         // keyboardType: TextInputType.number,
//                                         keyboardType: const TextInputType
//                                             .numberWithOptions(
//                                           decimal: true,
//                                           signed: false,
//                                         ),
//                                         decoration: const InputDecoration(
//                                           border: OutlineInputBorder(
//                                               // borderRadius:
//                                               //     BorderRadius.circular(25),
//                                               ),
//                                           enabledBorder: OutlineInputBorder(
//                                             borderSide: BorderSide(
//                                               color: Color.fromARGB(
//                                                   255, 7, 59, 120),
//                                             ),
//                                             // borderRadius:
//                                             //     BorderRadius.circular(25),
//                                           ),
//                                           hintText: 'Miles In Progress',
//                                         ),
//                                         onChanged: (value) {
//                                           setState(() {
//                                             calculateMilesPending(
//                                               double.parse(
//                                                   _milesCompleted2.text),
//                                               double.parse(value),
//                                               _milesPending2,
//                                             );
//                                           });
//                                         },
//                                         validator: (value) {
//                                           if (value!.isEmpty) {
//                                             return "Please enter Miles In Progress";
//                                           }
//                                           // try {
//                                           //   double parsedValue =
//                                           //       double.parse(value);
//                                           //   if (parsedValue % 1 != 0) {
//                                           //     return "Entered value should be an integer, not a float value";
//                                           //   }
//                                           // } catch (e) {
//                                           //   return "Invalid input. Please enter a numeric value.";
//                                           // }
//                                           // ;
//                                           // return null;
//                                         },
//                                       ),
//                                     ),
//                                   ),
//                                   const Align(
//                                       alignment: Alignment.centerLeft,
//                                       child: Padding(
//                                         padding: EdgeInsets.only(
//                                             left: 2.0,
//                                             right: 2.0,
//                                             bottom: 2.0,
//                                             top: 20.0),
//                                         child: Text(
//                                           "MILES PENDING*",
//                                           style: TextStyle(
//                                             fontSize: 16.0,
//                                             color:
//                                                 Color.fromARGB(255, 7, 59, 120),
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                         ),
//                                       )),
//                                   Align(
//                                     alignment: Alignment.centerRight,
//                                     child: Padding(
//                                       padding: const EdgeInsets.all(2.0),
//                                       child: TextFormField(
//                                         //  key: formkey5,
//                                         enabled: false,
//                                         controller: _milesPending2,
//                                         style: const TextStyle(
//                                             color:
//                                                 Color.fromARGB(255, 7, 59, 120),
//                                             fontSize: 16),
//                                         obscureText: false,
//                                         // keyboardType: TextInputType.number,
//                                         keyboardType: const TextInputType
//                                             .numberWithOptions(
//                                           decimal: true,
//                                           signed: false,
//                                         ),
//                                         decoration: const InputDecoration(
//                                           border: OutlineInputBorder(
//                                               // borderRadius:
//                                               //     BorderRadius.circular(25),
//                                               ),
//                                           disabledBorder: OutlineInputBorder(
//                                             borderSide: BorderSide(
//                                               color: Color.fromARGB(
//                                                   255, 7, 59, 120),
//                                             ),
//                                             // borderRadius:
//                                             //     BorderRadius.circular(25),
//                                           ),
//                                           hintText: 'Miles Pending',
//                                         ),
//                                         validator: (value) {
//                                           if (value!.isEmpty) {
//                                             return "Please enter Miles Pending";
//                                           } else {
//                                             return null;
//                                           }
//                                         },
//                                       ),
//                                     ),
//                                   ),
//                                   Visibility(
//                                     visible: _isVisibleUpdateMap,
//                                     child: Container(
//                                         margin: const EdgeInsets.only(
//                                             left: 6,
//                                             right: 6,
//                                             top: 10.0,
//                                             bottom: 10),
//                                         child: InkWell(
//                                           onTap: () async {
//                                             // Navigator.of(context).push(
//                                             //     MaterialPageRoute(
//                                             //         builder: (BuildContext
//                                             //                 context) =>
//                                             //             RowMaintenanceUpdateMap(
//                                             //                 id: selectedChangeOrderNo)));

//                                             await browser.open(
//                                                 url: WebUri(
//                                                     "https://mapapi.ariespro.com/main/contractor/CIVM_Map/$selectedChangeOrderNo/USRQWXH589Z"),
//                                                 settings:
//                                                     ChromeSafariBrowserSettings(
//                                                         shareState:
//                                                             CustomTabsShareState
//                                                                 .SHARE_STATE_OFF,
//                                                         barCollapsingEnabled:
//                                                             true));
//                                           },
//                                           child: Container(
//                                             margin: const EdgeInsets.only(
//                                                 left: 40,
//                                                 right: 40,
//                                                 bottom: 10.0),
//                                             // padding: const EdgeInsets.all(8),
//                                             alignment: Alignment.center,
//                                             width: MediaQuery.of(context)
//                                                 .size
//                                                 .width,
//                                             height: 40,
//                                             decoration: const BoxDecoration(
//                                                 // shape: BoxShape.circle,
//                                                 // borderRadius:
//                                                 //     BorderRadius.circular(25),
//                                                 boxShadow: [
//                                                   BoxShadow(
//                                                       color: Color.fromARGB(
//                                                           255, 3, 47, 97),
//                                                       blurRadius: 5,
//                                                       offset: Offset(2.0, 5.0))
//                                                 ],
//                                                 gradient: LinearGradient(
//                                                   colors: [
//                                                     Color.fromARGB(
//                                                         255, 7, 59, 120),
//                                                     Color.fromARGB(
//                                                         255, 7, 59, 120)
//                                                   ],
//                                                 )),
//                                             child: const Row(children: [
//                                               Expanded(
//                                                 child: Align(
//                                                   alignment: Alignment.center,
//                                                   child: Text(
//                                                     "Update Map",
//                                                     textAlign: TextAlign.left,
//                                                     style: TextStyle(
//                                                       color: Colors.white,
//                                                       fontWeight:
//                                                           FontWeight.bold,
//                                                       fontSize: 20,
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ]),
//                                           ),
//                                         )),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           )),
//                       Container(
//                           margin: const EdgeInsets.only(
//                               left: 8, right: 8, top: 10, bottom: 8),
//                           padding: const EdgeInsets.all(8),
//                           alignment: Alignment.center,
//                           // height: size.height * 0.5,
//                           width: size.width * 0.99,
//                           decoration: BoxDecoration(
//                               // shape: BoxShape.circle,
//                               borderRadius: BorderRadius.circular(10),
//                               boxShadow: const [
//                                 BoxShadow(
//                                     color: Color.fromARGB(255, 7, 59, 120),
//                                     blurRadius: 10,
//                                     offset: Offset(2.0, 5.0))
//                               ],
//                               gradient: const LinearGradient(
//                                 colors: [
//                                   Color.fromARGB(255, 255, 255, 255),
//                                   Color.fromARGB(255, 255, 255, 255),
//                                 ],
//                               )),
//                           child: Column(
//                             children: [
//                               Column(
//                                 children: [
//                                   const Align(
//                                       alignment: Alignment.centerLeft,
//                                       child: Padding(
//                                         padding: EdgeInsets.only(
//                                             left: 2.0,
//                                             right: 2.0,
//                                             bottom: 2.0,
//                                             top: 20.0),
//                                         child: Text(
//                                           "ROW METHOD",
//                                           style: TextStyle(
//                                             fontSize: 16.0,
//                                             color:
//                                                 Color.fromARGB(255, 7, 59, 120),
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                         ),
//                                       )),
//                                   Align(
//                                     alignment: Alignment.centerLeft,
//                                     child: Padding(
//                                       padding: const EdgeInsets.all(2.0),
//                                       child: DropdownButtonFormField<String>(
//                                         hint: const Text('-Select-'),
//                                         dropdownColor: Colors.white,
//                                         value: rowMethod,
//                                         style: const TextStyle(
//                                             color:
//                                                 Color.fromARGB(255, 7, 59, 120),
//                                             fontSize: 16),
//                                         icon: const Icon(
//                                           Icons.arrow_drop_down,
//                                           color:
//                                               Color.fromARGB(255, 7, 59, 120),
//                                           size: 40,
//                                         ),
//                                         decoration: const InputDecoration(
//                                           enabledBorder: OutlineInputBorder(
//                                             borderSide: BorderSide(
//                                               color: Color.fromARGB(
//                                                   255, 7, 59, 120),
//                                             ),
//                                           ),
//                                           focusedBorder: OutlineInputBorder(
//                                             borderSide: BorderSide(
//                                               color: Color.fromARGB(
//                                                   255, 7, 59, 120),
//                                             ),
//                                           ),
//                                         ),
//                                         isExpanded: true,
//                                         items: select_rowMethod
//                                             .map(buildMenuItem)
//                                             .toList(),
//                                         onChanged: (value) =>
//                                             setState(() => rowMethod = value),
//                                         // validator: (value) => value == null
//                                         //     ? 'field required'
//                                         //     : null,
//                                       ),
//                                     ),
//                                   ),
//                                   const Align(
//                                       alignment: Alignment.centerLeft,
//                                       child: Padding(
//                                         padding: EdgeInsets.only(
//                                             left: 2.0,
//                                             right: 2.0,
//                                             bottom: 2.0,
//                                             top: 20.0),
//                                         child: Text(
//                                           "DELAY CAUSE",
//                                           style: TextStyle(
//                                             fontSize: 16.0,
//                                             color:
//                                                 Color.fromARGB(255, 7, 59, 120),
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                         ),
//                                       )),
//                                   Align(
//                                     alignment: Alignment.centerLeft,
//                                     child: Padding(
//                                       padding: const EdgeInsets.all(2.0),
//                                       child: DropdownButtonFormField<String>(
//                                         hint: const Text('-Select-'),
//                                         dropdownColor: Colors.white,
//                                         value: delayCause,
//                                         style: const TextStyle(
//                                             color:
//                                                 Color.fromARGB(255, 7, 59, 120),
//                                             fontSize: 16),
//                                         icon: const Icon(
//                                           Icons.arrow_drop_down,
//                                           color:
//                                               Color.fromARGB(255, 7, 59, 120),
//                                           size: 40,
//                                         ),
//                                         decoration: const InputDecoration(
//                                           enabledBorder: OutlineInputBorder(
//                                             borderSide: BorderSide(
//                                               color: Color.fromARGB(
//                                                   255, 7, 59, 120),
//                                             ),
//                                             // borderRadius:
//                                             //     BorderRadius.circular(25),
//                                           ),
//                                           focusedBorder: OutlineInputBorder(
//                                             borderSide: BorderSide(
//                                               color: Color.fromARGB(
//                                                   255, 7, 59, 120),
//                                             ),
//                                             // borderRadius:
//                                             //     BorderRadius.circular(25),
//                                           ),
//                                         ),
//                                         isExpanded: true,
//                                         items: select_delayCause
//                                             .map(buildMenuItem)
//                                             .toList(),
//                                         onChanged: (value) {
//                                           reason = null;
//                                           setState(() => delayCause = value);
//                                           dropDownValues();
//                                         },
//                                         // validator: (value) => value == null
//                                         //     ? 'field required'
//                                         //     : null,
//                                       ),
//                                     ),
//                                   ),
//                                   const Align(
//                                       alignment: Alignment.centerLeft,
//                                       child: Padding(
//                                         padding: EdgeInsets.only(
//                                             left: 2.0,
//                                             right: 2.0,
//                                             bottom: 2.0,
//                                             top: 20.0),
//                                         child: Text(
//                                           "REASON",
//                                           style: TextStyle(
//                                             fontSize: 16.0,
//                                             color:
//                                                 Color.fromARGB(255, 7, 59, 120),
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                         ),
//                                       )),
//                                   Align(
//                                     alignment: Alignment.centerLeft,
//                                     child: Padding(
//                                       padding: const EdgeInsets.all(2.0),
//                                       child: DropdownButtonFormField<String>(
//                                         hint: const Text('-Select-'),
//                                         dropdownColor: Colors.white,
//                                         value: reason,
//                                         style: const TextStyle(
//                                             color:
//                                                 Color.fromARGB(255, 7, 59, 120),
//                                             fontSize: 16),
//                                         icon: const Icon(
//                                           Icons.arrow_drop_down,
//                                           color:
//                                               Color.fromARGB(255, 7, 59, 120),
//                                           size: 40,
//                                         ),
//                                         decoration: const InputDecoration(
//                                           enabledBorder: OutlineInputBorder(
//                                             borderSide: BorderSide(
//                                               color: Color.fromARGB(
//                                                   255, 7, 59, 120),
//                                             ),
//                                             // borderRadius:
//                                             //     BorderRadius.circular(25),
//                                           ),
//                                           focusedBorder: OutlineInputBorder(
//                                             borderSide: BorderSide(
//                                               color: Color.fromARGB(
//                                                   255, 7, 59, 120),
//                                             ),
//                                             // borderRadius:
//                                             //     BorderRadius.circular(25),
//                                           ),
//                                         ),
//                                         isExpanded: true,
//                                         items: select_reason
//                                             .map(buildMenuItem)
//                                             .toList(),
//                                         onChanged: (value) =>
//                                             setState(() => reason = value),
//                                         // validator: (value) => value == null
//                                         //     ? 'field required'
//                                         //     : null,
//                                       ),
//                                     ),
//                                   ),
//                                   const Align(
//                                       alignment: Alignment.centerLeft,
//                                       child: Padding(
//                                         padding: EdgeInsets.only(
//                                             left: 2.0,
//                                             right: 2.0,
//                                             bottom: 2.0,
//                                             top: 20.0),
//                                         child: Text(
//                                           "AFFECTED DAYS*",
//                                           style: TextStyle(
//                                             fontSize: 16.0,
//                                             color:
//                                                 Color.fromARGB(255, 7, 59, 120),
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                         ),
//                                       )),
//                                   Align(
//                                     alignment: Alignment.centerRight,
//                                     child: Padding(
//                                       padding: const EdgeInsets.all(2.0),
//                                       child: TextFormField(
//                                         //  key: formkey5,
//                                         controller: _affectedDays,
//                                         style: const TextStyle(
//                                             color:
//                                                 Color.fromARGB(255, 7, 59, 120),
//                                             fontSize: 16),
//                                         obscureText: false,
//                                         keyboardType: TextInputType.number,
//                                         decoration: const InputDecoration(
//                                           border: OutlineInputBorder(
//                                               // borderRadius:
//                                               //     BorderRadius.circular(25),
//                                               ),
//                                           enabledBorder: OutlineInputBorder(
//                                             borderSide: BorderSide(
//                                               color: Color.fromARGB(
//                                                   255, 7, 59, 120),
//                                             ),
//                                             // borderRadius:
//                                             //     BorderRadius.circular(25),
//                                           ),
//                                           hintText: 'Affected Days',
//                                         ),
//                                         validator: (value) {
//                                           if (value!.isEmpty) {
//                                             return "Please enter Affected Days";
//                                           }
//                                           try {
//                                             double parsedValue =
//                                                 double.parse(value);
//                                             if (parsedValue % 1 != 0) {
//                                               return "Entered value should be an integer, not a float value";
//                                             }
//                                           } catch (e) {
//                                             return "Invalid input. Please enter a numeric value.";
//                                           }
//                                           return null;
//                                         },
//                                       ),
//                                     ),
//                                   ),
//                                   const Align(
//                                       alignment: Alignment.centerLeft,
//                                       child: Padding(
//                                         padding: EdgeInsets.only(
//                                             left: 2.0,
//                                             right: 2.0,
//                                             bottom: 2.0,
//                                             top: 20.0),
//                                         child: Text(
//                                           "UPLOAD (IMAGE, PDF)*",
//                                           style: TextStyle(
//                                             fontSize: 16,
//                                             color:
//                                                 Color.fromARGB(255, 7, 59, 120),
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                         ),
//                                       )),
//                                   Container(
//                                     margin: const EdgeInsets.only(
//                                         bottom: 10.0, top: 2),
//                                     padding: const EdgeInsets.all(8),
//                                     alignment: Alignment.center,
//                                     width: size.width * 1,
//                                     decoration: const BoxDecoration(
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
//                                             Colors.white,
//                                             Colors.white,
//                                           ],
//                                         )),
//                                     child: Row(
//                                       children: [
//                                         InkWell(
//                                             onTap: () {
//                                               _checkPermission(context);
//                                             },
//                                             child: const Text(
//                                               'Choose File',
//                                               style: TextStyle(
//                                                 fontSize: 16,
//                                                 color: Color.fromARGB(
//                                                     255, 7, 59, 120),
//                                                 fontWeight: FontWeight.bold,
//                                               ),
//                                             )),
//                                         Padding(
//                                           padding:
//                                               const EdgeInsets.only(left: 8.0),
//                                           child: Container(
//                                             width: 1,
//                                             height: 50,
//                                             color: Colors.black,
//                                           ),
//                                         ),
//                                         Expanded(
//                                           child: Padding(
//                                             padding: const EdgeInsets.only(
//                                                 left: 8.0),
//                                             child: Text(
//                                               ((_imagePath.isEmpty) &&
//                                                       (_imagePath2.isEmpty) &&
//                                                       (_imagePath3.isEmpty))
//                                                   ? 'No file selected'
//                                                   : (_imagePath.isNotEmpty ||
//                                                           _imagePath2
//                                                               .isNotEmpty ||
//                                                           _imagePath3
//                                                               .isNotEmpty)
//                                                       ? '3 files selected'
//                                                       : (_imagePath
//                                                                   .isNotEmpty ||
//                                                               _imagePath2
//                                                                   .isEmpty ||
//                                                               _imagePath3
//                                                                   .isEmpty)
//                                                           ? '1 file selected'
//                                                           : (_imagePath
//                                                                       .isEmpty ||
//                                                                   _imagePath2
//                                                                       .isNotEmpty ||
//                                                                   _imagePath3
//                                                                       .isEmpty)
//                                                               ? '1 file selected'
//                                                               : (_imagePath
//                                                                           .isNotEmpty &&
//                                                                       _imagePath2
//                                                                           .isEmpty &&
//                                                                       _imagePath3
//                                                                           .isEmpty)
//                                                                   ? '1 file selected'
//                                                                   : (_imagePath
//                                                                               .isEmpty &&
//                                                                           _imagePath2
//                                                                               .isNotEmpty &&
//                                                                           _imagePath3
//                                                                               .isEmpty)
//                                                                       ? '1 file selected'
//                                                                       : (_imagePath.isEmpty &&
//                                                                               _imagePath2.isEmpty &&
//                                                                               _imagePath3.isNotEmpty)
//                                                                           ? '1 file selected'
//                                                                           : (_imagePath.isNotEmpty && _imagePath2.isNotEmpty && _imagePath3.isEmpty)
//                                                                               ? '2 files selected'
//                                                                               : (_imagePath.isNotEmpty && _imagePath2.isEmpty && _imagePath3.isNotEmpty)
//                                                                                   ? '2 files selected'
//                                                                                   : (_imagePath.isEmpty && _imagePath2.isNotEmpty && _imagePath3.isNotEmpty)
//                                                                                       ? '2 files selected'
//                                                                                       : 'No File selected',
//                                               style: const TextStyle(
//                                                 fontSize: 16,
//                                                 color: Color.fromARGB(
//                                                     255, 7, 59, 120),
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                         // Expanded(
//                                         //   child: Padding(
//                                         //     padding: const EdgeInsets.only(
//                                         //         left: 8.0),
//                                         //     child: Text(
//                                         //       (_imagePath == '')
//                                         //           ? 'No File Chosen'
//                                         //           : path.basename(_imagePath),
//                                         //       style: const TextStyle(
//                                         //         fontSize: 16,
//                                         //         color: Color.fromARGB(
//                                         //             255, 7, 59, 120),
//                                         //       ),
//                                         //     ),
//                                         //   ),
//                                         // ),
//                                       ],
//                                     ),
//                                   ),
//                                   Row(
//                                     children: [
//                                       Expanded(
//                                         child: Visibility(
//                                           visible: _isVisibleImage,
//                                           child: Stack(
//                                             children: [
//                                               if (_imagePath.isNotEmpty)
//                                                 Image.file(
//                                                   File(_imagePath),
//                                                   height: 200,
//                                                   width: 200,
//                                                   fit: BoxFit.cover,
//                                                 ),
//                                               InkWell(
//                                                 onTap: () async {
//                                                   deleteOnlineImageApi(
//                                                       deleteImage1,
//                                                       selectedChangeOrderNo);
//                                                   _isVisibleImage = false;
//                                                 },
//                                                 child: const Icon(Icons.delete,
//                                                     color: Colors.red,
//                                                     size: 50),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//                                       Expanded(
//                                         child: Visibility(
//                                           visible: _isVisibleImage2,
//                                           child: Stack(
//                                             children: [
//                                               if (_imagePath2.isNotEmpty)
//                                                 Image.file(
//                                                   File(_imagePath),
//                                                   height: 200,
//                                                   width: 200,
//                                                   fit: BoxFit.cover,
//                                                 ),
//                                               InkWell(
//                                                 onTap: () {
//                                                   deleteOnlineImageApi(
//                                                       deleteImage2,
//                                                       selectedChangeOrderNo);
//                                                   _isVisibleImage2 = false;
//                                                 },
//                                                 child: const Icon(Icons.delete,
//                                                     color: Colors.red,
//                                                     size: 50),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//                                       Expanded(
//                                         child: Visibility(
//                                           visible: _isVisibleImage3,
//                                           child: Stack(
//                                             children: [
//                                               if (_imagePath3.isNotEmpty)
//                                                 Image.file(
//                                                   File(_imagePath3),
//                                                   height: 200,
//                                                   width: 200,
//                                                   fit: BoxFit.cover,
//                                                 ),
//                                               InkWell(
//                                                 onTap: () {
//                                                   deleteOnlineImageApi(
//                                                       deleteImage3,
//                                                       selectedChangeOrderNo);
//                                                   _isVisibleImage3 = false;
//                                                 },
//                                                 child: const Icon(Icons.delete,
//                                                     color: Colors.red,
//                                                     size: 50),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   Container(
//                                       margin: const EdgeInsets.only(
//                                           left: 6,
//                                           right: 6,
//                                           top: 20.0,
//                                           bottom: 10),
//                                       child: InkWell(
//                                         onTap: () {
//                                           print('123In inkwell');
//                                           submitImage(
//                                               _imagePath!,
//                                               // path.basename(_imagePath),
//                                               selectedChangeOrderNo!);
//                                           print('_imagePath');
//                                           print(_imagePath);
//                                           print('selectedChangeOrderNo');
//                                           print(selectedChangeOrderNo);
//                                           // FormData formData = FormData.fromMap({
//                                           //   'files': _imagePath.toString(),
//                                           //   'tokenNo': 77,
//                                           // });
//                                           // print('formData');
//                                           // formData.fields.forEach(
//                                           //     (MapEntry<String, dynamic>
//                                           //         entry) {
//                                           //   print(
//                                           //       '${entry.key}: ${entry.value}');
//                                           // });
//                                           // contractorRowMaintenanceProgressViewModelViewModel
//                                           //     .fetchRowMaintenanceImageUploadApi(
//                                           //         context, formData);
//                                         },
//                                         child: Container(
//                                           margin: const EdgeInsets.only(
//                                               left: 40,
//                                               right: 40,
//                                               bottom: 10.0),
//                                           // padding: const EdgeInsets.all(8),
//                                           alignment: Alignment.center,
//                                           width: MediaQuery.of(context)
//                                                   .size
//                                                   .width *
//                                               0.4,
//                                           height: 40,
//                                           decoration: const BoxDecoration(
//                                               // shape: BoxShape.circle,
//                                               // borderRadius:
//                                               //     BorderRadius.circular(25),
//                                               boxShadow: [
//                                                 BoxShadow(
//                                                     color: Color.fromARGB(
//                                                         255, 1, 119, 5),
//                                                     blurRadius: 5,
//                                                     offset: Offset(2.0, 5.0))
//                                               ],
//                                               gradient: LinearGradient(
//                                                 colors: [
//                                                   Colors.green,
//                                                   Colors.green,
//                                                 ],
//                                               )),
//                                           child: const Row(children: [
//                                             Expanded(
//                                               child: Align(
//                                                 alignment: Alignment.center,
//                                                 child: Text(
//                                                   "Upload & Save",
//                                                   textAlign: TextAlign.left,
//                                                   style: TextStyle(
//                                                     color: Colors.white,
//                                                     fontWeight: FontWeight.bold,
//                                                     fontSize: 20,
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ]),
//                                         ),
//                                       )),
//                                   Container(
//                                       margin: const EdgeInsets.only(
//                                           left: 6,
//                                           right: 6,
//                                           top: 10.0,
//                                           bottom: 10),
//                                       child: InkWell(
//                                         onTap: () {
//                                           print('before formkey validation');
//                                           if (_formkey.currentState!
//                                               .validate()) {
//                                             print('after formkey validation');
//                                             Map mapData = {
//                                               "tblSubMilesCostId":
//                                                   (selectedChangeOrderNo ==
//                                                           null)
//                                                       ? ''
//                                                       : selectedChangeOrderNo,
//                                               "subStateName":
//                                                   (subId.toString() == 'null')
//                                                       ? 0
//                                                       : subId,
//                                               "feeder": (feederId.toString() ==
//                                                       'null')
//                                                   ? 0
//                                                   : feederId,
//                                               "street": "N/A",
//                                               "crew":
//                                                   (selectedCrew.toString() ==
//                                                           'null')
//                                                       ? 0
//                                                       : selectedCrew,
//                                               "totalMiles": (_totalMiles.text
//                                                           .toString() ==
//                                                       'null')
//                                                   ? ''
//                                                   : double.parse(
//                                                           _totalMiles.text)
//                                                       .toStringAsFixed(2),
//                                               "milesCompleted": double.parse(
//                                                       _milesCompleted2.text
//                                                           .toString())
//                                                   .toStringAsFixed(2),
//                                               // (double.parse(
//                                               //             _milesCompleted.text
//                                               //                 .toString()) +
//                                               //         double.parse(
//                                               //             _milesCompleted2.text
//                                               //                 .toString()))
//                                               //     .toStringAsFixed(2),
//                                               // (_milesCompleted2.text
//                                               //             .toString() ==
//                                               //         'null')
//                                               //     ? ''
//                                               //     : _milesCompleted2.text
//                                               //         .toString(),
//                                               "milesInProgress":
//                                                   (_milesInProgress2.text
//                                                               .toString() ==
//                                                           'null')
//                                                       ? ''
//                                                       : double.parse(
//                                                               _milesInProgress2
//                                                                   .text)
//                                                           .toStringAsFixed(2),
//                                               "milesPending": (_milesPending2
//                                                           .text
//                                                           .toString() ==
//                                                       'null')
//                                                   ? ''
//                                                   : double.parse(
//                                                           _milesPending2.text)
//                                                       .toStringAsFixed(2),
//                                               "performanceType": 'N/A',
//                                               "wtdProgress": 0.0,
//                                               "mtdProgress": 0.0,
//                                               "ytdProgress": 0.0,
//                                               "rowMethod": rowMethod ?? '',
//                                               "delayCause": delayCause ?? '',
//                                               "delayReason": reason ?? '',
//                                               "effectedNoOfDays": (_affectedDays
//                                                           .text
//                                                           .toString() ==
//                                                       'null')
//                                                   ? 0
//                                                   : _affectedDays.text
//                                                       .toString(),
//                                               "fileUpload": "N/A",
//                                               "createDate":
//                                                   "2023-12-13T12:19:29.427+00:00",
//                                               "status": "PENDING"
//                                             };
//                                             print('API called.........');
//                                             contractorRowMaintenanceProgressViewModelViewModel
//                                                 .fetchRowMaintenanceProgressContractorSubmitListApi(
//                                                     context, mapData);
//                                             print('mapData');
//                                             print(mapData);
//                                             print('name1');
//                                             fetchData('', '', '', '');
//                                             Future.delayed(
//                                                 const Duration(seconds: 5), () {
//                                               //    Future.delayed(
//                                               // const Duration(seconds: 2));

//                                               setState(() {
//                                                 selectedYear = null;
//                                                 selectedSubstation = null;
//                                                 selectedFeeder = null;
//                                                 selectedChangeOrderNo = null;
//                                                 selectedCrew = null;
//                                                 _totalMiles.clear();
//                                                 _milesCompleted.clear();
//                                                 _milesInProgress.clear();
//                                                 _milesPending.clear();
//                                                 _milesPending2.clear();
//                                                 rowMethod = null;
//                                                 delayCause = null;
//                                                 reason = null;
//                                                 _affectedDays.clear();
//                                                 _imagePath = '';
//                                                 _imagePath2 = '';
//                                                 _imagePath3 = '';
//                                                 _isVisibleImage = false;
//                                                 _isVisibleImage2 = false;
//                                                 _isVisibleImage3 = false;
//                                                 _milesCompleted2.text = '0';
//                                                 _milesInProgress2.text = '0';
//                                               });
//                                             });

//                                             // _showUpdateDataDialog();
//                                           } else {
//                                             print(
//                                                 "Please fill all mendetory fields!!!");
//                                           }
//                                         },
//                                         child: Container(
//                                           margin: const EdgeInsets.only(
//                                               left: 40,
//                                               right: 40,
//                                               bottom: 10.0),
//                                           // padding: const EdgeInsets.all(8),
//                                           alignment: Alignment.center,
//                                           width:
//                                               MediaQuery.of(context).size.width,
//                                           height: 40,
//                                           decoration: const BoxDecoration(
//                                               // shape: BoxShape.circle,
//                                               // borderRadius:
//                                               //     BorderRadius.circular(25),
//                                               boxShadow: [
//                                                 BoxShadow(
//                                                     color: Color.fromARGB(
//                                                         255, 3, 47, 97),
//                                                     blurRadius: 5,
//                                                     offset: Offset(2.0, 5.0))
//                                               ],
//                                               gradient: LinearGradient(
//                                                 colors: [
//                                                   Color.fromARGB(
//                                                       255, 7, 59, 120),
//                                                   Color.fromARGB(
//                                                       255, 7, 59, 120)
//                                                 ],
//                                               )),
//                                           child: const Row(children: [
//                                             Expanded(
//                                               child: Align(
//                                                 alignment: Alignment.center,
//                                                 child: Text(
//                                                   "Update",
//                                                   textAlign: TextAlign.left,
//                                                   style: TextStyle(
//                                                     color: Colors.white,
//                                                     fontWeight: FontWeight.bold,
//                                                     fontSize: 20,
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ]),
//                                         ),
//                                       )),
//                                   Container(
//                                     margin: const EdgeInsets.only(
//                                         left: 4, right: 4, top: 10, bottom: 8),
//                                     padding: const EdgeInsets.all(8),
//                                     alignment: Alignment.center,
//                                     height: size.height * 0.6,
//                                     width: size.width * 0.99,
//                                     decoration: BoxDecoration(
//                                         // shape: BoxShape.circle,
//                                         borderRadius: BorderRadius.circular(10),
//                                         boxShadow: const [
//                                           BoxShadow(
//                                               color: Color.fromARGB(
//                                                   255, 7, 59, 120),
//                                               blurRadius: 10,
//                                               offset: Offset(2.0, 5.0))
//                                         ],
//                                         gradient: const LinearGradient(
//                                           colors: [
//                                             Color.fromARGB(255, 255, 255, 255),
//                                             Color.fromARGB(255, 255, 255, 255),
//                                           ],
//                                         )),
//                                     child: Column(
//                                       children: [
//                                         Expanded(
//                                           child: ListView.builder(
//                                               itemCount: contractorRowMaintenanceProgressViewModelViewModel
//                                                   .contractorRowMaintenanceProgressViewModelGetTabularData
//                                                   .data!
//                                                   .getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList!
//                                                   .length,
//                                               // itemCount: historyList.length,
//                                               itemBuilder: (BuildContext ctxt,
//                                                   int index) {
//                                                 return Row(
//                                                   children: [
//                                                     Padding(
//                                                       padding:
//                                                           const EdgeInsets.only(
//                                                               top: 4.0,
//                                                               bottom: 4,
//                                                               left: 2,
//                                                               right: 0),
//                                                       child: Container(
//                                                         width: MediaQuery.of(
//                                                                     context)
//                                                                 .size
//                                                                 .width *
//                                                             0.85,
//                                                         // height:
//                                                         //     MediaQuery.of(context).size.height *
//                                                         //         0.73,
//                                                         // margin:  EdgeInsets.only(
//                                                         //     top: 5.0, bottom: 5.0, left: 2,right: 2),
//                                                         padding:
//                                                             const EdgeInsets
//                                                                 .all(8),
//                                                         decoration:
//                                                             BoxDecoration(
//                                                                 color: const Color
//                                                                     .fromARGB(
//                                                                     255,
//                                                                     7,
//                                                                     59,
//                                                                     120),
//                                                                 border:
//                                                                     Border.all(
//                                                                   color: Colors
//                                                                       .white,
//                                                                 ),
//                                                                 borderRadius:
//                                                                     const BorderRadius
//                                                                         .only(
//                                                                   topRight: Radius
//                                                                       .circular(
//                                                                           10),
//                                                                   bottomRight: Radius
//                                                                       .circular(
//                                                                           10),
//                                                                   topLeft: Radius
//                                                                       .circular(
//                                                                           10),
//                                                                   bottomLeft: Radius
//                                                                       .circular(
//                                                                           10),
//                                                                 )),
//                                                         child: Column(
//                                                             children: [
//                                                               Padding(
//                                                                 padding:
//                                                                     const EdgeInsets
//                                                                         .only(
//                                                                         left:
//                                                                             8.0),
//                                                                 child: Row(
//                                                                   children: [
//                                                                     Expanded(
//                                                                       // alignment: Alignment.topLeft,
//                                                                       child:
//                                                                           Column(
//                                                                         children: [
//                                                                           const Align(
//                                                                             alignment:
//                                                                                 Alignment.topLeft,
//                                                                             child:
//                                                                                 Text(
//                                                                               "SERIAL: ",
//                                                                               textAlign: TextAlign.left,
//                                                                               style: TextStyle(
//                                                                                 fontSize: 12,
//                                                                                 fontWeight: FontWeight.bold,
//                                                                                 color: Colors.white,
//                                                                               ),
//                                                                             ),
//                                                                           ),
//                                                                           Align(
//                                                                             alignment:
//                                                                                 Alignment.topLeft,
//                                                                             child:
//                                                                                 Text(
//                                                                               (index + 1).toString(),
//                                                                               textAlign: TextAlign.left,
//                                                                               style: const TextStyle(
//                                                                                 fontSize: 12,
//                                                                                 //  fontWeight:
//                                                                                 //      FontWeight.bold,
//                                                                                 color: Colors.white,
//                                                                               ),
//                                                                             ),
//                                                                           ),
//                                                                         ],
//                                                                       ),
//                                                                     ),
//                                                                     Expanded(
//                                                                       // alignment: Alignment.topLeft,
//                                                                       child:
//                                                                           Column(
//                                                                         children: [
//                                                                           const Align(
//                                                                             alignment:
//                                                                                 Alignment.topLeft,
//                                                                             child:
//                                                                                 Text(
//                                                                               "SUBSTATION: ",
//                                                                               textAlign: TextAlign.left,
//                                                                               style: TextStyle(
//                                                                                 fontSize: 12,
//                                                                                 fontWeight: FontWeight.bold,
//                                                                                 color: Colors.white,
//                                                                               ),
//                                                                             ),
//                                                                           ),
//                                                                           Align(
//                                                                             alignment:
//                                                                                 Alignment.topLeft,
//                                                                             child:
//                                                                                 Text(
//                                                                               (contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList![index].substation == null || contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList![index].substation.toString() == 'null') ? '' : contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList![index].substation.toString(),
//                                                                               textAlign: TextAlign.left,
//                                                                               style: const TextStyle(
//                                                                                 fontSize: 12,
//                                                                                 //  fontWeight:
//                                                                                 //      FontWeight.bold,
//                                                                                 color: Colors.white,
//                                                                               ),
//                                                                             ),
//                                                                           ),
//                                                                         ],
//                                                                       ),
//                                                                     ),
//                                                                     Expanded(
//                                                                       // alignment: Alignment.topLeft,
//                                                                       child:
//                                                                           Column(
//                                                                         children: [
//                                                                           const Align(
//                                                                             alignment:
//                                                                                 Alignment.topLeft,
//                                                                             child:
//                                                                                 Text(
//                                                                               "FEEDER: ",
//                                                                               textAlign: TextAlign.left,
//                                                                               style: TextStyle(
//                                                                                 fontSize: 12,
//                                                                                 fontWeight: FontWeight.bold,
//                                                                                 color: Colors.white,
//                                                                               ),
//                                                                             ),
//                                                                           ),
//                                                                           Align(
//                                                                             alignment:
//                                                                                 Alignment.topLeft,
//                                                                             child:
//                                                                                 Text(
//                                                                               (contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList![index].feeder == null || contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList![index].feeder.toString() == 'null') ? '' : contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList![index].feeder.toString(),
//                                                                               textAlign: TextAlign.left,
//                                                                               style: const TextStyle(
//                                                                                 fontSize: 12,
//                                                                                 //  fontWeight:
//                                                                                 //      FontWeight.bold,
//                                                                                 color: Colors.white,
//                                                                               ),
//                                                                             ),
//                                                                           ),
//                                                                         ],
//                                                                       ),
//                                                                     ),
//                                                                   ],
//                                                                 ),
//                                                               ),
//                                                               const Divider(
//                                                                 color:
//                                                                     Colors.grey,
//                                                               ),
//                                                               Padding(
//                                                                 padding:
//                                                                     const EdgeInsets
//                                                                         .only(
//                                                                         left:
//                                                                             8.0),
//                                                                 child: Row(
//                                                                   children: [
//                                                                     Expanded(
//                                                                       // alignment: Alignment.topLeft,
//                                                                       child:
//                                                                           Column(
//                                                                         children: [
//                                                                           const Align(
//                                                                             alignment:
//                                                                                 Alignment.topLeft,
//                                                                             child:
//                                                                                 Text(
//                                                                               "TOTAL MILES: ",
//                                                                               textAlign: TextAlign.left,
//                                                                               style: TextStyle(
//                                                                                 fontSize: 12,
//                                                                                 fontWeight: FontWeight.bold,
//                                                                                 color: Colors.white,
//                                                                               ),
//                                                                             ),
//                                                                           ),
//                                                                           Align(
//                                                                             alignment:
//                                                                                 Alignment.topLeft,
//                                                                             child:
//                                                                                 Text(
//                                                                               (contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList![index].totalMiles == null || contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList![index].totalMiles.toString() == 'null') ? '' : double.parse(contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList![index].totalMiles.toString()).toStringAsFixed(2),
//                                                                               textAlign: TextAlign.left,
//                                                                               style: const TextStyle(
//                                                                                 fontSize: 12,
//                                                                                 color: Colors.white,
//                                                                               ),
//                                                                             ),
//                                                                           ),
//                                                                         ],
//                                                                       ),
//                                                                     ),
//                                                                     Expanded(
//                                                                       // alignment: Alignment.topLeft,
//                                                                       child:
//                                                                           Column(
//                                                                         children: [
//                                                                           const Align(
//                                                                             alignment:
//                                                                                 Alignment.topLeft,
//                                                                             child:
//                                                                                 Text(
//                                                                               "MILES COMPLETED: ",
//                                                                               textAlign: TextAlign.left,
//                                                                               style: TextStyle(
//                                                                                 fontSize: 12,
//                                                                                 fontWeight: FontWeight.bold,
//                                                                                 color: Colors.white,
//                                                                               ),
//                                                                             ),
//                                                                           ),
//                                                                           Align(
//                                                                             alignment:
//                                                                                 Alignment.topLeft,
//                                                                             child:
//                                                                                 Text(
//                                                                               (contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList![index].milesCompleted == null || contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList![index].milesCompleted.toString() == 'null') ? '' : double.parse(contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList![index].milesCompleted.toString()).toStringAsFixed(2),
//                                                                               textAlign: TextAlign.left,
//                                                                               style: const TextStyle(
//                                                                                 fontSize: 12,
//                                                                                 color: Colors.white,
//                                                                               ),
//                                                                             ),
//                                                                           ),
//                                                                         ],
//                                                                       ),
//                                                                     ),
//                                                                     Expanded(
//                                                                       // alignment: Alignment.topLeft,
//                                                                       child:
//                                                                           Column(
//                                                                         children: [
//                                                                           const Align(
//                                                                             alignment:
//                                                                                 Alignment.topLeft,
//                                                                             child:
//                                                                                 Text(
//                                                                               "ROW METHOD: ",
//                                                                               textAlign: TextAlign.left,
//                                                                               style: TextStyle(
//                                                                                 fontSize: 12,
//                                                                                 fontWeight: FontWeight.bold,
//                                                                                 color: Colors.white,
//                                                                               ),
//                                                                             ),
//                                                                           ),
//                                                                           Align(
//                                                                             alignment:
//                                                                                 Alignment.topLeft,
//                                                                             child:
//                                                                                 Text(
//                                                                               (contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList![index].rowMethod == null || contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList![index].rowMethod.toString() == 'null') ? '' : contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList![index].rowMethod.toString(),
//                                                                               textAlign: TextAlign.left,
//                                                                               style: const TextStyle(
//                                                                                 fontSize: 12,
//                                                                                 color: Colors.white,
//                                                                               ),
//                                                                             ),
//                                                                           ),
//                                                                         ],
//                                                                       ),
//                                                                     ),
//                                                                   ],
//                                                                 ),
//                                                               ),
//                                                               const Divider(
//                                                                 color:
//                                                                     Colors.grey,
//                                                               ),
//                                                               Padding(
//                                                                 padding:
//                                                                     const EdgeInsets
//                                                                         .only(
//                                                                         left:
//                                                                             8.0),
//                                                                 child: Row(
//                                                                   children: [
//                                                                     Expanded(
//                                                                       // alignment: Alignment.topLeft,
//                                                                       child:
//                                                                           Column(
//                                                                         children: [
//                                                                           const Align(
//                                                                             alignment:
//                                                                                 Alignment.topLeft,
//                                                                             child:
//                                                                                 Text(
//                                                                               "DELAY CAUSE: ",
//                                                                               textAlign: TextAlign.left,
//                                                                               style: TextStyle(
//                                                                                 fontSize: 12,
//                                                                                 fontWeight: FontWeight.bold,
//                                                                                 color: Colors.white,
//                                                                               ),
//                                                                             ),
//                                                                           ),
//                                                                           Align(
//                                                                             alignment:
//                                                                                 Alignment.topLeft,
//                                                                             child:
//                                                                                 Text(
//                                                                               (contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList![index].delayCause == null || contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList![index].delayCause.toString() == 'null') ? '' : contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList![index].delayCause.toString(),
//                                                                               textAlign: TextAlign.left,
//                                                                               style: const TextStyle(
//                                                                                 fontSize: 12,
//                                                                                 color: Colors.white,
//                                                                               ),
//                                                                             ),
//                                                                           ),
//                                                                         ],
//                                                                       ),
//                                                                     ),
//                                                                     Expanded(
//                                                                       // alignment: Alignment.topLeft,
//                                                                       child:
//                                                                           Column(
//                                                                         children: [
//                                                                           const Align(
//                                                                             alignment:
//                                                                                 Alignment.topLeft,
//                                                                             child:
//                                                                                 Text(
//                                                                               "DELAY REASON: ",
//                                                                               textAlign: TextAlign.left,
//                                                                               style: TextStyle(
//                                                                                 fontSize: 12,
//                                                                                 fontWeight: FontWeight.bold,
//                                                                                 color: Colors.white,
//                                                                               ),
//                                                                             ),
//                                                                           ),
//                                                                           Align(
//                                                                             alignment:
//                                                                                 Alignment.topLeft,
//                                                                             child:
//                                                                                 Text(
//                                                                               (contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList![index].delayReason == null || contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList![index].delayReason.toString() == 'null') ? '' : contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList![index].delayReason.toString(),
//                                                                               textAlign: TextAlign.left,
//                                                                               style: const TextStyle(
//                                                                                 fontSize: 12,
//                                                                                 //  fontWeight:
//                                                                                 //      FontWeight.bold,
//                                                                                 color: Colors.white,
//                                                                               ),
//                                                                             ),
//                                                                           ),
//                                                                         ],
//                                                                       ),
//                                                                     ),
//                                                                     Expanded(
//                                                                       // alignment: Alignment.topLeft,
//                                                                       child:
//                                                                           Column(
//                                                                         children: [
//                                                                           const Align(
//                                                                             alignment:
//                                                                                 Alignment.topLeft,
//                                                                             child:
//                                                                                 Text(
//                                                                               "EFFECTED NO. of DAYS: ",
//                                                                               textAlign: TextAlign.left,
//                                                                               style: TextStyle(
//                                                                                 fontSize: 12,
//                                                                                 fontWeight: FontWeight.bold,
//                                                                                 color: Colors.white,
//                                                                               ),
//                                                                             ),
//                                                                           ),
//                                                                           Align(
//                                                                             alignment:
//                                                                                 Alignment.topLeft,
//                                                                             child:
//                                                                                 Text(
//                                                                               (contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList![index].effectedNoOfDays == null || contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList![index].effectedNoOfDays.toString() == 'null') ? '' : contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList![index].effectedNoOfDays.toString(),
//                                                                               textAlign: TextAlign.left,
//                                                                               style: const TextStyle(
//                                                                                 fontSize: 12,
//                                                                                 color: Colors.white,
//                                                                               ),
//                                                                             ),
//                                                                           ),
//                                                                         ],
//                                                                       ),
//                                                                     ),
//                                                                   ],
//                                                                 ),
//                                                               ),
//                                                               const Divider(
//                                                                 color:
//                                                                     Colors.grey,
//                                                               ),
//                                                               Padding(
//                                                                 padding:
//                                                                     const EdgeInsets
//                                                                         .only(
//                                                                         left:
//                                                                             8.0),
//                                                                 child: Row(
//                                                                   children: [
//                                                                     Expanded(
//                                                                       // alignment: Alignment.topLeft,
//                                                                       child:
//                                                                           Column(
//                                                                         children: [
//                                                                           const Align(
//                                                                             alignment:
//                                                                                 Alignment.topLeft,
//                                                                             child:
//                                                                                 Text(
//                                                                               "STATUS: ",
//                                                                               textAlign: TextAlign.left,
//                                                                               style: TextStyle(
//                                                                                 fontSize: 12,
//                                                                                 fontWeight: FontWeight.bold,
//                                                                                 color: Colors.white,
//                                                                               ),
//                                                                             ),
//                                                                           ),
//                                                                           Align(
//                                                                             alignment:
//                                                                                 Alignment.topLeft,
//                                                                             child:
//                                                                                 Text(
//                                                                               (contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList![index].status == null || contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList![index].status.toString() == 'null') ? '' : contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList![index].status.toString(),
//                                                                               textAlign: TextAlign.left,
//                                                                               style: const TextStyle(
//                                                                                 fontSize: 12,
//                                                                                 color: Colors.white,
//                                                                               ),
//                                                                             ),
//                                                                           ),
//                                                                         ],
//                                                                       ),
//                                                                     ),
//                                                                     Expanded(
//                                                                       // alignment: Alignment.topLeft,
//                                                                       child:
//                                                                           Column(
//                                                                         children: [
//                                                                           const Align(
//                                                                             alignment:
//                                                                                 Alignment.topLeft,
//                                                                             child:
//                                                                                 Text(
//                                                                               "ACTION: ",
//                                                                               textAlign: TextAlign.left,
//                                                                               style: TextStyle(
//                                                                                 fontSize: 12,
//                                                                                 fontWeight: FontWeight.bold,
//                                                                                 color: Colors.white,
//                                                                               ),
//                                                                             ),
//                                                                           ),
//                                                                           (contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList![index].status == 'REJECTED')
//                                                                               ? Container(
//                                                                                   margin: const EdgeInsets.only(bottom: 10),
//                                                                                   child: InkWell(
//                                                                                     onTap: () {
//                                                                                       updateStatus(contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList![index].id.toString());
//                                                                                     },
//                                                                                     child: Container(
//                                                                                       margin: const EdgeInsets.only(top: 2, bottom: 10.0),
//                                                                                       // padding: const EdgeInsets.all(8),
//                                                                                       alignment: Alignment.center,
//                                                                                       // width: MediaQuery.of(context).size.width,
//                                                                                       // height: 40,
//                                                                                       decoration: const BoxDecoration(
//                                                                                           // shape: BoxShape.circle,
//                                                                                           // borderRadius:
//                                                                                           //     BorderRadius.circular(25),
//                                                                                           boxShadow: [
//                                                                                             BoxShadow(color: Color.fromARGB(255, 3, 47, 97), blurRadius: 5, offset: Offset(2.0, 5.0))
//                                                                                           ],
//                                                                                           gradient: LinearGradient(
//                                                                                             colors: [
//                                                                                               Color.fromARGB(255, 3, 118, 249),
//                                                                                               Color.fromARGB(255, 3, 118, 249),
//                                                                                             ],
//                                                                                           )),
//                                                                                       child: const Padding(
//                                                                                         padding: EdgeInsets.all(2.0),
//                                                                                         child: Align(
//                                                                                           alignment: Alignment.center,
//                                                                                           child: Text(
//                                                                                             "Submit for Review",
//                                                                                             textAlign: TextAlign.left,
//                                                                                             style: TextStyle(
//                                                                                               color: Colors.white,
//                                                                                               fontWeight: FontWeight.bold,
//                                                                                               fontSize: 16,
//                                                                                             ),
//                                                                                           ),
//                                                                                         ),
//                                                                                       ),
//                                                                                     ),
//                                                                                   ))
//                                                                               : const Text(''),
//                                                                         ],
//                                                                       ),
//                                                                     ),
//                                                                   ],
//                                                                 ),
//                                                               ),
//                                                             ]),
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 );
//                                               }),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           )),
//                     ]),
//                   ));

//                 default:
//                   return const Text('data');
//               }
//             })));
//   }

//   fetchData(String substation, String feeder, String nextMaintDue,
//       String tokenNo) async {
//     final userPreferences = Provider.of<UserPref>(context, listen: false);
//     UserModel data = await userPreferences.getUser();
//     contractorRowMaintenanceProgressViewModelViewModel
//         .fetchContractorRowMaintenanceProgressViewModelTabularListApi(
//             context,
//             data.user!.id.toString(),
//             substation,
//             feeder,
//             nextMaintDue,
//             tokenNo);
//     setData();
//   }

//   setData() {
//     _totalMiles.text = (contractorRowMaintenanceProgressViewModelViewModel
//                     .contractorRowMaintenanceProgressViewModelGetTabularData
//                     .data!
//                     .findAllByTokenNumbers![0]
//                     .totalMiles ==
//                 null ||
//             contractorRowMaintenanceProgressViewModelViewModel
//                     .contractorRowMaintenanceProgressViewModelGetTabularData
//                     .data!
//                     .findAllByTokenNumbers![0]
//                     .totalMiles
//                     .toString() ==
//                 'null')
//         ? '0'
//         : double.parse(contractorRowMaintenanceProgressViewModelViewModel
//                 .contractorRowMaintenanceProgressViewModelGetTabularData
//                 .data!
//                 .findAllByTokenNumbers![0]
//                 .totalMiles
//                 .toString())
//             .toStringAsFixed(2);

//     _milesCompleted.text = (contractorRowMaintenanceProgressViewModelViewModel
//                     .contractorRowMaintenanceProgressViewModelGetTabularData
//                     .data!
//                     .findAllByTokenNumbers![0]
//                     .milesCompleted ==
//                 null ||
//             contractorRowMaintenanceProgressViewModelViewModel
//                     .contractorRowMaintenanceProgressViewModelGetTabularData
//                     .data!
//                     .findAllByTokenNumbers![0]
//                     .milesCompleted
//                     .toString() ==
//                 'null')
//         ? '0'
//         : double.parse(contractorRowMaintenanceProgressViewModelViewModel
//                 .contractorRowMaintenanceProgressViewModelGetTabularData
//                 .data!
//                 .findAllByTokenNumbers![0]
//                 .milesCompleted
//                 .toString())
//             .toStringAsFixed(2);

//     _milesInProgress.text = (contractorRowMaintenanceProgressViewModelViewModel
//                     .contractorRowMaintenanceProgressViewModelGetTabularData
//                     .data!
//                     .findAllByTokenNumbers![0]
//                     .milesInProgress ==
//                 null ||
//             contractorRowMaintenanceProgressViewModelViewModel
//                     .contractorRowMaintenanceProgressViewModelGetTabularData
//                     .data!
//                     .findAllByTokenNumbers![0]
//                     .milesInProgress
//                     .toString() ==
//                 'null')
//         ? '0'
//         : double.parse(contractorRowMaintenanceProgressViewModelViewModel
//                 .contractorRowMaintenanceProgressViewModelGetTabularData
//                 .data!
//                 .findAllByTokenNumbers![0]
//                 .milesInProgress
//                 .toString())
//             .toStringAsFixed(2);

//     _milesPending.text = (contractorRowMaintenanceProgressViewModelViewModel
//                     .contractorRowMaintenanceProgressViewModelGetTabularData
//                     .data!
//                     .findAllByTokenNumbers![0]
//                     .milesPending ==
//                 null ||
//             contractorRowMaintenanceProgressViewModelViewModel
//                     .contractorRowMaintenanceProgressViewModelGetTabularData
//                     .data!
//                     .findAllByTokenNumbers![0]
//                     .milesPending
//                     .toString() ==
//                 'null')
//         ? '0'
//         : double.parse(contractorRowMaintenanceProgressViewModelViewModel
//                 .contractorRowMaintenanceProgressViewModelGetTabularData
//                 .data!
//                 .findAllByTokenNumbers![0]
//                 .milesPending
//                 .toString())
//             .toStringAsFixed(2);
//   }

//   setDataForCalculation() {
//     _milesCompleted2.text = '0';
//     _milesInProgress2.text = '0';
//   }

//   Future<void> _pickImagesCamera() async {
//     final ImagePicker picker = ImagePicker();
//     const ImageSource source = ImageSource.camera;
//     List<String> chosenImagePaths = [];

//     for (int i = 0; i < 3; i++) {
//       final XFile? image = await picker.pickImage(
//         source: source,
//         maxWidth: 100,
//         maxHeight: 100,
//         imageQuality: 80,
//       );

//       if (image != null) {
//         chosenImagePaths.add(image.path);
//       }
//     }

//     setState(() {
//       for (int i = 0; i < chosenImagePaths.length; i++) {
//         if (_imagePath.isEmpty) {
//           _imagePath = chosenImagePaths[i];
//         } else if (_imagePath2.isEmpty) {
//           _imagePath2 = chosenImagePaths[i];
//         } else if (_imagePath3.isEmpty) {
//           _imagePath3 = chosenImagePaths[i];
//         } else {
//           CustomToastSnackBarProgressDialog.toastMessage(
//             'You can select a maximum of 3 images!',
//           );
//           break;
//         }
//       }
//     });
//   }

//   Future<void> _pickImagesGallery() async {
//     final ImagePicker picker = ImagePicker();
//     List<String> chosenImagePaths = [];

//     for (int i = 0; i < 3; i++) {
//       final XFile? image = await picker.pickImage(
//         source: ImageSource.gallery, // Set source to ImageSource.gallery only
//         maxWidth: 100,
//         maxHeight: 100,
//         imageQuality: 80,
//       );

//       if (image != null) {
//         chosenImagePaths.add(image.path);
//       }
//     }

//     setState(() {
//       for (int i = 0; i < chosenImagePaths.length; i++) {
//         if (_imagePath.isEmpty) {
//           _imagePath = chosenImagePaths[i];
//         } else if (_imagePath2.isEmpty) {
//           _imagePath2 = chosenImagePaths[i];
//         } else if (_imagePath3.isEmpty) {
//           _imagePath3 = chosenImagePaths[i];
//         } else {
//           CustomToastSnackBarProgressDialog.toastMessage(
//             'You can select a maximum of 3 images!',
//           );
//           break;
//         }
//       }
//     });
//   }

//   // Future<void> _pickImages() async {
//   //   final ImagePicker picker = ImagePicker();
//   //   List<String> chosenImagePaths = [];

//   //   for (int i = 0; i < 3; i++) {
//   //     final XFile? image = await picker.pickImage(
//   //       source: i == 0 ? ImageSource.camera : ImageSource.gallery,
//   //       maxWidth: 100,
//   //       maxHeight: 100,
//   //       imageQuality: 80,
//   //     );

//   //     if (image != null) {
//   //       chosenImagePaths.add(image.path);
//   //     }
//   //   }

//   //   setState(() {
//   //     for (int i = 0; i < chosenImagePaths.length; i++) {
//   //       if (_imagePath.isEmpty) {
//   //         _imagePath = chosenImagePaths[i];
//   //       } else if (_imagePath2.isEmpty) {
//   //         _imagePath2 = chosenImagePaths[i];
//   //       } else if (_imagePath3.isEmpty) {
//   //         _imagePath3 = chosenImagePaths[i];
//   //       } else {
//   //         CustomToastSnackBarProgressDialog.toastMessage(
//   //           'You can select a maximum of 3 images!',
//   //         );
//   //         break;
//   //       }
//   //     }
//   //   });
//   // }

//   Future<void> _checkPermission(BuildContext context) async {
//     FocusScope.of(context).requestFocus(FocusNode());
//     Map<Permission, PermissionStatus> statues = await [
//       Permission.camera,
//       Permission.storage,
//       Permission.photos
//     ].request();
//     PermissionStatus? statusCamera = statues[Permission.camera];
//     PermissionStatus? statusStorage;
//     PermissionStatus? statusPhotos;
//     if (Platform.isAndroid) {
//       final androidInfo = await DeviceInfoPlugin().androidInfo;
//       if (androidInfo.version.sdkInt <= 32) {
//         statusStorage = statues[Permission.storage];

//         /// use [Permissions.storage.status]
//       } else {
//         statusPhotos = statues[Permission.photos];

//         /// use [Permissions.photos.status]
//       }
//     }

//     bool isGranted = statusCamera == PermissionStatus.granted &&
//             statusStorage == PermissionStatus.granted ||
//         statusCamera == PermissionStatus.granted &&
//             statusPhotos == PermissionStatus.granted;
//     if (isGranted) {
//       _pickImagesCamera();
//       // _pickImages();
//     }
//     bool isPermanentlyDenied =
//         statusCamera == PermissionStatus.permanentlyDenied ||
//             statusStorage == PermissionStatus.permanentlyDenied ||
//             statusPhotos == PermissionStatus.permanentlyDenied;
//     if (isPermanentlyDenied) {
//       // _showSettingsDialog(context);
//     }
//   }

//   Future<void> submitImage(String fileName, String tokenNo) async {
//     Directory tempDir = await getTemporaryDirectory();
//     String tempPath = tempDir.path;
//     print('object');
//     try {
//       var uri = Uri.parse(
//           "https://civmapi.ariespro.com/civmapi/contractorPanel/updateImageVEGETATION_CREW_FORMs");
//       var request = http.MultipartRequest("POST", uri);
//       print('object111');
//       final userPreferences = Provider.of<UserPref>(context, listen: false);
//       UserModel data = await userPreferences.getUser();
//       var headers = {
//         "Content-Type": "multipart/form-data",
//         "Accept": "*/*",
//         "Authorization": 'Bearer ${data.token!}'
//       };
//       // var stream1 = http.ByteStream(image.openRead());
//       // // Get the file length
//       // var length = await image.length();
//       // Create a multipart file from the byte stream
//       // var multipartFile1 = http.MultipartFile(
//       //   'ClientDoc1', // Field name for the file
//       //   stream1, // Byte stream of the file
//       //   length, // Length of the file
//       //   filename: basename(image.path), // Original file name
//       // );
//       // request.files.add(multipartFile1); // Add the single file to the request
//       List<http.MultipartFile> newList = [];
//       print('object22');
//       if (_imagePath != '') {
//         print('object333');
//         File img1 = new File(_imagePath);
//         File file = await img1.copy(
//             '$tempPath/img_${DateFormat('yyyyMMddHHmmss').format(DateTime.now())}${_imagePath.contains('.pdf') ? '.pdf' : '.jpg'}');

//         var stream1 = http.ByteStream(file.openRead());
//         var length1 = await file.length();
//         print('object666');
//         print(length1);
//         print(file.path);
//         // Get the file length
//         var multipartFile = http.MultipartFile("files", stream1, length1,
//             filename: path.basename(file.path));
//         deleteImage1 = path.basename(file.path);
//         newList.add(multipartFile);
//       }

//       if (_imagePath2 != '') {
//         File img2 = new File(_imagePath2);
//         File file2 = await img2.copy(
//             '$tempPath/img_${DateFormat('yyyyMMddHHmmss').format(DateTime.now())}2${_imagePath2.contains('.pdf') ? '.pdf' : '.jpg'}');

//         var stream2 = http.ByteStream(file2.openRead());
//         var length2 = await file2.length();
//         print(length2);
//         print(file2.path);
//         // Get the file length
//         var multipartFile2 = http.MultipartFile("files", stream2, length2,
//             filename: path.basename(file2.path));

//         deleteImage2 = path.basename(file2.path);

//         newList.add(multipartFile2);
//       }

//       if (_imagePath3 != '') {
//         File img3 = new File(_imagePath3);
//         File file3 = await img3.copy(
//             '$tempPath/img_${DateFormat('yyyyMMddHHmmss').format(DateTime.now())}3${_imagePath3.contains('.pdf') ? '.pdf' : '.jpg'}');

//         var stream3 = http.ByteStream(file3.openRead());
//         var length3 = await file3.length();
//         print(length3);
//         print(file3.path);
//         // Get the file length
//         var multipartFile3 = http.MultipartFile("files", stream3, length3,
//             filename: path.basename(file3.path));
//         deleteImage3 = path.basename(file3.path);
//         newList.add(multipartFile3);
//       }

//       if (newList.isNotEmpty) {
//         request.files.addAll(newList); // Add the multiple file to the request
//       }
//       print('222');
//       request.headers.addAll(headers);
//       request.fields['tokenNo'] = tokenNo;
//       print('333');
//       // Send the request
//       var streamedResponse = await request.send();
//       print(streamedResponse);
//       print(streamedResponse.statusCode);
//       var response = await http.Response.fromStream(streamedResponse);
//       print("xyz");
//       print(response.body);
//       // listen for response
//       // streamedResponse.stream.transform(utf8.decoder).listen((value) {
//       //   print(value);
//       // });
//       if (response.statusCode == 200) {
//         print('response');
//         print(response);
//         if (_imagePath != '') {
//           setState(() {
//             _isVisibleImage = true;
//           });
//         }

//         if (_imagePath2 != '') {
//           print('image2');
//           setState(() {
//             _isVisibleImage2 = true;
//           });
//         }

//         if (_imagePath3 != '') {
//           print('image3');
//           setState(() {
//             _isVisibleImage3 = true;
//           });
//         }
//       }
//     } catch (e, stacktrace) {
//       print('catch statement');
//       print('Exception: $e\n$stacktrace');
//     }
//     print('object');
//     print(_isVisibleImage);
//     _isVisibleImage = true;
//     print(_isVisibleImage);
//   }

//   Future<void> deleteOnlineImageApi(String fileName, String token) async {
//     final apiUrl =
//         'http://civmapi.ariespro.com/civmapi/changeOrderLcpCreateOrder/deleteFile?fileName=$fileName&tokenNo=$token';
//     print(apiUrl);
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
//       } else {
//         print('API request failed with status code: ${response.statusCode}');
//         print('Response body: ${response.body}');
//       }
//     } catch (e) {
//       print('Error: $e');
//     }
//   }

//   DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
//       value: item,
//       child: Text(item,
//           style: const TextStyle(
//             fontWeight: FontWeight.normal,
//             fontSize: 20,
//           )));

//   void dropDownValues() {
//     if (delayCause == 'Weather Delay') {
//       select_reason = [
//         'Hurricane',
//         'Ice',
//         'Major Storm',
//         'Rain',
//         'Snow',
//         'Wind'
//       ];
//     } else if (delayCause == 'Other Issues') {
//       select_reason = ['Crew', 'Machinery', 'Mishandling'];
//     }
//   }

//   // void calculateMilesPending(
//   //   double milesCompleted,
//   //   double milesInProgress,
//   //   TextEditingController milesPending,
//   // ) {
//   //   print('object');
//   //   setState(() {
//   //     // milesInProgress = 0;
//   //     double totalMilesFromBackend = 0.0;
//   //     double milesCompletedFromBackend = 0.0;
//   //     totalMilesFromBackend = double.parse(
//   //         contractorRowMaintenanceProgressViewModelViewModel
//   //             .contractorRowMaintenanceProgressViewModelGetTabularData
//   //             .data!
//   //             .findAllByTokenNumbers![0]
//   //             .totalMiles
//   //             .toString());

//   //     milesCompletedFromBackend = double.parse(
//   //         contractorRowMaintenanceProgressViewModelViewModel
//   //             .contractorRowMaintenanceProgressViewModelGetTabularData
//   //             .data!
//   //             .findAllByTokenNumbers![0]
//   //             .milesCompleted
//   //             .toString());
//   //     double milesPendingValue = 0;
//   //     milesPendingValue = totalMilesFromBackend -
//   //         milesCompletedFromBackend -
//   //         milesCompleted -
//   //         milesInProgress;
//   //         print(totalMilesFromBackend);
//   //         print(milesCompletedFromBackend);
//   //         print(milesCompleted);
//   //         print(milesInProgress);
//   //         print('milesPendingValue $milesPendingValue');
//   //     milesPending.text = milesPendingValue.toStringAsFixed(2);
//   //   });
//   // }

//   void calculateMilesPending(
//     double milesCompleted,
//     double milesInProgress,
//     TextEditingController milesPending,
//   ) {
//     setState(() {
//       double totalMilesFromBackend = double.parse(
//           contractorRowMaintenanceProgressViewModelViewModel
//               .contractorRowMaintenanceProgressViewModelGetTabularData
//               .data!
//               .findAllByTokenNumbers![0]
//               .totalMiles
//               .toString());

//       double milesCompletedFromBackend = double.parse(
//           contractorRowMaintenanceProgressViewModelViewModel
//               .contractorRowMaintenanceProgressViewModelGetTabularData
//               .data!
//               .findAllByTokenNumbers![0]
//               .milesCompleted
//               .toString());

//       double milesPendingValue = double.parse(
//         (totalMilesFromBackend -
//                 milesCompletedFromBackend -
//                 milesCompleted -
//                 milesInProgress)
//             .toStringAsFixed(2),
//       );
//       milesPendingValue = milesPendingValue.abs();
//       print('milesPendingValue $milesPendingValue');
//       milesPending.text = milesPendingValue.toStringAsFixed(2);
//     });
//   }

//   printValue() {
//     print('length of cards');
//     print(contractorRowMaintenanceProgressViewModelViewModel
//         .contractorRowMaintenanceProgressViewModelGetTabularData
//         .data!
//         .getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList!
//         .length);
//   }

//   Future<void> updateStatus(String id) async {
//     final userPreferences = Provider.of<UserPref>(context, listen: false);
//     UserModel data = await userPreferences.getUser();
//     final String apiUrl =
//         "https://civmapi.ariespro.com/civmapi/contractorPanel/updateStatusByIds/$id";
//     print(apiUrl);
//     Map<String, dynamic> updatedData = {
//       "status": "new_status",
//     };

//     final http.Response response = await http.put(
//       Uri.parse(apiUrl),
//       headers: <String, String>{
//         'Content-Type': 'application/json',
//         'Authorization': 'Bearer ${data.token}',
//       },
//       body: jsonEncode(updatedData),
//     );
//     if (response.statusCode == 200) {
//       print("Update successful");
//       CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
//           'Successfully Submitted for Review', context);
//       fetchData(selectedSubstation, selectedFeeder, selectedYear,
//           selectedChangeOrderNo);
//       if (response.body.isNotEmpty) {
//         print(jsonDecode(response.body));
//       } else {
//         print("Response body is empty");
//       }
//     } else {
//       print("Failed to update. Status code: ${response.statusCode}");
//       // Print the response body only if it is not empty
//       if (response.body.isNotEmpty) {
//         print(response.body);
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
//     return Drawer(
//       child: ListView(
//         // Important: Remove any padding from the ListView.
//         padding: EdgeInsets.zero,
//         children: [
//           DrawerHeader(
//             decoration: const BoxDecoration(
//               color: Color.fromARGB(255, 7, 59, 120),
//             ),
//             child: Column(
//               children: [
//                 ClipOval(
//                     child: _imagePath != null
//                         ? Image.network(
//                             _imagePath!,
//                             height: 100,
//                             width: 100,
//                             fit: BoxFit.cover,
//                           )
//                         : Image.asset(
//                             'assets/person_icon.jpg',
//                             height: 100,
//                             width: 100,
//                             fit: BoxFit.cover,
//                           )),
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
//             title: const Text('General Foreman / Dispatch Dashboard'),
//             textColor: const Color.fromARGB(255, 7, 59, 120),
//             iconColor: const Color.fromARGB(255, 7, 59, 120),
//             onTap: () {
//               Navigator.of(context).push(MaterialPageRoute(
//                   builder: (BuildContext context) =>
//                       const ContractorBottomNavigationPannel()));
//             },
//           ),
//           ListTile(
//             leading: const Icon(
//               Icons.pending,
//             ),
//             title: const Text('Change Order Pending'),
//             textColor: const Color.fromARGB(255, 7, 59, 120),
//             iconColor: const Color.fromARGB(255, 7, 59, 120),
//             onTap: () {
//               Navigator.of(context).push(MaterialPageRoute(
//                   builder: (BuildContext context) =>
//                       const WorkOrderPendingContractor()));
//             },
//           ),
//           // Visibility(
//           //   visible: (widget.menu.isNotEmpty &&
//           //           widget.menu.contains('Energy Audit Ticket'))
//           //       ? true
//           //       : false,
//           // child:
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
//           // ),
//           ListTile(
//             leading: const Icon(
//               Icons.change_circle,
//             ),
//             title: const Text('Change Order'),
//             textColor: const Color.fromARGB(255, 7, 59, 120),
//             iconColor: const Color.fromARGB(255, 7, 59, 120),
//             onTap: () {
//               Navigator.of(context).push(MaterialPageRoute(
//                   builder: (BuildContext context) =>
//                       const ChangeOrderContractor()));
//             },
//           ),

//           // ListTile(
//           //   leading: const Icon(
//           //     Icons.inventory,
//           //   ),
//           //   title: const Text('Daily Herbicide Application Form'),
//           //   textColor: const Color.fromARGB(255, 7, 59, 120),
//           //   iconColor: const Color.fromARGB(255, 7, 59, 120),
//           //   onTap: () {
//           //     Navigator.of(context).push(MaterialPageRoute(
//           //         builder: (BuildContext context) =>
//           //             const DailyHerbicideApplicationFormContractor()));
//           //   },
//           // ),

//           // ListTile(
//           //   leading: const Icon(
//           //     Icons.list_alt,
//           //   ),
//           //   title: const Text('Power Time Form'),
//           //   textColor: const Color.fromARGB(255, 7, 59, 120),
//           //   iconColor: const Color.fromARGB(255, 7, 59, 120),
//           //   onTap: () {
//           //     Navigator.of(context).push(MaterialPageRoute(
//           //         builder: (BuildContext context) =>
//           //             const PowerTimeFormContractor()));
//           //   },
//           // ),

//           ListTile(
//             leading: const Icon(
//               Icons.list_alt,
//             ),
//             title: const Text('Invoice Form'),
//             textColor: const Color.fromARGB(255, 7, 59, 120),
//             iconColor: const Color.fromARGB(255, 7, 59, 120),
//             onTap: () {
//               Navigator.of(context).push(MaterialPageRoute(
//                   builder: (BuildContext context) =>
//                       const InvoiceFormContractor()));
//             },
//           ),

//           // ListTile(
//           //   leading: const Icon(
//           //     Icons.list_alt,
//           //   ),
//           //   title: const Text('Mixing Inventory Form'),
//           //   textColor: const Color.fromARGB(255, 7, 59, 120),
//           //   iconColor: const Color.fromARGB(255, 7, 59, 120),
//           //   onTap: () {
//           //     Navigator.of(context).push(MaterialPageRoute(
//           //         builder: (BuildContext context) =>
//           //             const MixingInventoryFormContractor()));
//           //   },
//           // ),
//           ListTile(
//             leading: const Icon(
//               Icons.create,
//             ),
//             title: const Text('Create Invoice'),
//             textColor: const Color.fromARGB(255, 7, 59, 120),
//             iconColor: const Color.fromARGB(255, 7, 59, 120),
//             onTap: () {
//               Navigator.of(context).push(MaterialPageRoute(
//                   builder: (BuildContext context) =>
//                       const CreateInvoiceContractor()));
//             },
//           ),
//           ListTile(
//             leading: const Icon(
//               Icons.list,
//             ),
//             title: const Text('Invoice List'),
//             textColor: const Color.fromARGB(255, 7, 59, 120),
//             iconColor: const Color.fromARGB(255, 7, 59, 120),
//             onTap: () {
//               Navigator.of(context).push(MaterialPageRoute(
//                   builder: (BuildContext context) =>
//                       const InvoiceListContrator()));
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
//               // // Constants.prefs.setBool("LoggedIn", false);
//               userPreferences.remove().then((value) {
//                 Navigator.of(context).push(MaterialPageRoute(
//                     builder: (BuildContext context) => const LoginPage()));
//               });
//               // Navigator.of(context).pushReplacement(MaterialPageRoute(
//               //     builder: (BuildContext context) => const LoginPage()));
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
//       userName = '${data.user!.fName} ${data.user!.lName}';
//     });
//   }
// }
