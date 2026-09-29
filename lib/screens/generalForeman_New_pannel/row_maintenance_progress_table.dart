// import 'package:civm/models/user_model.dart';
// import 'package:civm/utils/custom_toast_snackbar_progressdialog.dart';
// import 'package:civm/utils/user_pref.dart';
// import 'package:civm/view_model/contractor_row_maintenance_progress_view_model.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../../data/response/status.dart';

// class RowMaintenanceProgressContractorTable extends StatefulWidget {
//   const RowMaintenanceProgressContractorTable({Key? key}) : super(key: key);

//   @override
//   State<RowMaintenanceProgressContractorTable> createState() =>
//       _RowMaintenanceProgressContractorTableState();
// }

// class _RowMaintenanceProgressContractorTableState
//     extends State<RowMaintenanceProgressContractorTable> {
//   List<String> menu = [];

//   int workOrderNoId = 0;
//   // ignore: prefer_typing_uninitialized_variables
//   var selectedWorkOrderNo;

//   String userName = '';

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

//   @override
//   void initState() {
//     fetchData('', '', '', '');
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//         appBar: AppBar(iconTheme: const IconThemeData(color: Colors.white),
//           title: const Text('Row Maintenance Status Data',
//             style: TextStyle(color: Colors.white),),
//           backgroundColor: const Color.fromARGB(255, 7, 59, 120),
//         ),
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
//                   return SingleChildScrollView(
//                     child: Column(
//                       children: [
//                         Container(
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
//                                       "Filters",
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
//                               SingleChildScrollView(
//                                 scrollDirection: Axis.horizontal,
//                                 child: Row(
//                                   children: [
//                                     Container(
//                                       margin: const EdgeInsets.only(top: 10),
//                                       child: Column(
//                                         children: [
//                                           const Align(
//                                               alignment: Alignment.centerLeft,
//                                               child: Padding(
//                                                 padding: EdgeInsets.all(2.0),
//                                                 child: Text(
//                                                   "YEAR",
//                                                   style: TextStyle(
//                                                       fontSize: 16.0,
//                                                       color: Color.fromARGB(
//                                                           255, 7, 59, 120),fontWeight: FontWeight.bold,),
//                                                 ),
//                                               )),
//                                           Align(
//                                             alignment: Alignment.centerLeft,
//                                             child: Padding(
//                                               padding:
//                                                   const EdgeInsets.all(2.0),
//                                               child: SizedBox(
//                                                 width: 200,
//                                                 child: DropdownButtonFormField<
//                                                     String>(
//                                                   hint: const Text('-Select-'),
//                                                   dropdownColor: Colors.white,
//                                                   value: selectedYear,
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
//                                                       .findNextMaintDueBuyContractors!
//                                                       .map((e) {
//                                                     return DropdownMenuItem(
//                                                       value: e.nextMaintDues
//                                                           .toString(),
//                                                       // e.getIdAndSubstationByCountId![0].subStation.toString(),
//                                                       child: Text(e
//                                                           .nextMaintDues
//                                                           .toString()),
//                                                     );
//                                                   }).toList(),
//                                                   onChanged: (val) {
//                                                     if (selectedSubstation !=
//                                                             null ||
//                                                         selectedFeeder !=
//                                                             null ||
//                                                         selectedChangeOrderNo !=
//                                                             null ||
//                                                         selectedCrew != null) {
//                                                       selectedSubstation = null;
//                                                       selectedFeeder = null;
//                                                       selectedChangeOrderNo =
//                                                           null;
//                                                       selectedCrew = null;
//                                                     }
//                                                     fetchData('', '', val!, '');
//                                                     setState(() {
//                                                       selectedYear = val;
//                                                     });
//                                                   },
//                                                   validator: (value) =>
//                                                       value == null
//                                                           ? 'field required'
//                                                           : null,
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                     Container(
//                                       margin: const EdgeInsets.only(top: 10),
//                                       child: Column(
//                                         children: [
//                                           const Align(
//                                               alignment: Alignment.centerLeft,
//                                               child: Padding(
//                                                 padding: EdgeInsets.all(2.0),
//                                                 child: Text(
//                                                   "SUBSTATION",
//                                                   style: TextStyle(
//                                                       fontSize: 16.0,
//                                                       color: Color.fromARGB(
//                                                           255, 7, 59, 120),fontWeight: FontWeight.bold,),
//                                                 ),
//                                               )),
//                                           Align(
//                                             alignment: Alignment.centerLeft,
//                                             child: Padding(
//                                               padding:
//                                                   const EdgeInsets.all(2.0),
//                                               child: SizedBox(
//                                                 width: 200,
//                                                 child: DropdownButtonFormField<
//                                                     String>(
//                                                   hint: const Text('-Select-'),
//                                                   dropdownColor:
//                                                       const Color.fromRGBO(
//                                                           255, 255, 255, 1),
//                                                   value: selectedSubstation,
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
//                                                       .findSubstationByContractorAndNextMaintDues!
//                                                       .map((e) {
//                                                     return DropdownMenuItem(
//                                                       value: e.subId.toString(),
//                                                       // e.getIdAndSubstationByCountId![0].subStation.toString(),
//                                                       child: Text(e.subStation
//                                                           .toString()),
//                                                     );
//                                                   }).toList(),
//                                                   onChanged: (val) {
//                                                     if (selectedFeeder !=
//                                                             null ||
//                                                         selectedChangeOrderNo !=
//                                                             null ||
//                                                         selectedCrew != null) {
//                                                       selectedFeeder = null;
//                                                       selectedChangeOrderNo =
//                                                           null;
//                                                       selectedCrew = null;
//                                                     }
//                                                     fetchData(val!, '',
//                                                         selectedYear, '');
//                                                     subId = int.parse(val);
//                                                     setState(() {
//                                                       selectedSubstation = val;
//                                                     });
//                                                   },
//                                                   validator: (value) =>
//                                                       value == null
//                                                           ? 'field required'
//                                                           : null,
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                     Container(
//                                       margin: const EdgeInsets.only(top: 10),
//                                       child: Column(
//                                         children: [
//                                           const Align(
//                                               alignment: Alignment.centerLeft,
//                                               child: Padding(
//                                                 padding: EdgeInsets.all(2.0),
//                                                 child: Text(
//                                                   "FEEDER",
//                                                   style: TextStyle(
//                                                       fontSize: 16.0,
//                                                       color: Color.fromARGB(
//                                                           255, 7, 59, 120),fontWeight: FontWeight.bold,),
//                                                 ),
//                                               )),
//                                           Align(
//                                             alignment: Alignment.centerLeft,
//                                             child: Padding(
//                                               padding:
//                                                   const EdgeInsets.all(2.0),
//                                               child: SizedBox(
//                                                 width: 200,
//                                                 child: DropdownButtonFormField<
//                                                     String>(
//                                                   hint: const Text('-Select-'),
//                                                   dropdownColor: Colors.white,
//                                                   value: selectedFeeder,
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
//                                                       .findAllByContractorAndNextMaintDueAndSubstation!
//                                                       .map((e) {
//                                                     return DropdownMenuItem(
//                                                       value: e.fdrId.toString(),
//                                                       // e.getIdAndSubstationByCountId![0].subStation.toString(),
//                                                       child: Text(
//                                                           e.fdrName.toString()),
//                                                     );
//                                                   }).toList(),
//                                                   onChanged: (val) {
//                                                     if (selectedChangeOrderNo !=
//                                                             null ||
//                                                         selectedCrew != null) {
//                                                       selectedChangeOrderNo =
//                                                           null;
//                                                       selectedCrew = null;
//                                                     }
//                                                     fetchData(
//                                                         selectedSubstation,
//                                                         val!,
//                                                         selectedYear,
//                                                         '');
//                                                     feederId = int.parse(val);
//                                                     setState(() {
//                                                       selectedFeeder = val;
//                                                     });
//                                                   },
//                                                   validator: (value) =>
//                                                       value == null
//                                                           ? 'field required'
//                                                           : null,
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                     Container(
//                                       margin: const EdgeInsets.only(top: 10),
//                                       child: Column(
//                                         children: [
//                                           const Align(
//                                               alignment: Alignment.centerLeft,
//                                               child: Padding(
//                                                 padding: EdgeInsets.all(2.0),
//                                                 child: Text(
//                                                   "CHANGE ORDER NO",
//                                                   style: TextStyle(
//                                                       fontSize: 16.0,
//                                                       color: Color.fromARGB(
//                                                           255, 7, 59, 120),fontWeight: FontWeight.bold,),
//                                                 ),
//                                               )),
//                                           Align(
//                                             alignment: Alignment.centerLeft,
//                                             child: Padding(
//                                               padding:
//                                                   const EdgeInsets.all(2.0),
//                                               child: SizedBox(
//                                                 width: 200,
//                                                 child: DropdownButtonFormField<
//                                                     String>(
//                                                   hint: const Text('-Select-'),
//                                                   dropdownColor: Colors.white,
//                                                   value: selectedChangeOrderNo,
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
//                                                       .findTokenNoBySubstationAndFeederAndNextMaintsDue!
//                                                       .map((e) {
//                                                     return DropdownMenuItem(
//                                                       value:
//                                                           e.tokenNo.toString(),
//                                                       // e.getIdAndSubstationByCountId![0].subStation.toString(),
//                                                       child: Text(
//                                                           e.tokenNo.toString()),
//                                                     );
//                                                   }).toList(),
//                                                   onChanged: (val) {
//                                                     if (selectedCrew != null) {
//                                                       selectedCrew = null;
//                                                     }
//                                                     fetchData(
//                                                         selectedSubstation,
//                                                         selectedFeeder,
//                                                         selectedYear,
//                                                         val!);
//                                                     // workOrderNoId = int.parse(val);
//                                                     setState(() {
//                                                       selectedChangeOrderNo =
//                                                           val;
//                                                     });
//                                                   },
//                                                   validator: (value) =>
//                                                       value == null
//                                                           ? 'field required'
//                                                           : null,
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                     Container(
//                                       margin: const EdgeInsets.only(top: 10),
//                                       child: Column(
//                                         children: [
//                                           const Align(
//                                               alignment: Alignment.centerLeft,
//                                               child: Padding(
//                                                 padding: EdgeInsets.all(2.0),
//                                                 child: Text(
//                                                   "CREW",
//                                                   style: TextStyle(
//                                                       fontSize: 16.0,
//                                                       color: Color.fromARGB(
//                                                           255, 7, 59, 120),fontWeight: FontWeight.bold,),
//                                                 ),
//                                               )),
//                                           Align(
//                                             alignment: Alignment.centerLeft,
//                                             child: Padding(
//                                               padding:
//                                                   const EdgeInsets.all(2.0),
//                                               child: SizedBox(
//                                                 width: 200,
//                                                 child: DropdownButtonFormField<
//                                                     String>(
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
//                                                     fetchData(
//                                                         selectedSubstation,
//                                                         selectedFeeder,
//                                                         selectedYear,
//                                                         selectedChangeOrderNo);
//                                                     // workOrderNoId = int.parse(val);
//                                                     setState(() {
//                                                       selectedCrew = val;
//                                                     });
//                                                   },
//                                                   validator: (value) =>
//                                                       value == null
//                                                           ? 'field required'
//                                                           : null,
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Container(
//                           margin: const EdgeInsets.only(
//                               left: 8, right: 8, top: 10, bottom: 8),
//                           padding: const EdgeInsets.all(8),
//                           alignment: Alignment.center,
//                           height: size.height * 0.6,
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
//                               Expanded(
//                                 child: ListView.builder(
//                                     itemCount: contractorRowMaintenanceProgressViewModelViewModel
//                                         .contractorRowMaintenanceProgressViewModelGetTabularData
//                                         .data!
//                                         .getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList!
//                                         .length,
//                                     // itemCount: historyList.length,
//                                     itemBuilder:
//                                         (BuildContext ctxt, int index) {
//                                       return Row(
//                                         children: [
//                                           Padding(
//                                             padding: const EdgeInsets.only(
//                                                 top: 4.0, bottom: 4, left: 4),
//                                             child: Container(
//                                               width: MediaQuery.of(context)
//                                                       .size
//                                                       .width *
//                                                   0.9,
//                                               // height:
//                                               //     MediaQuery.of(context).size.height *
//                                               //         0.73,
//                                               // margin:  EdgeInsets.only(
//                                               //     top: 5.0, bottom: 5.0, left: 2,right: 2),
//                                               padding: const EdgeInsets.all(8),
//                                               decoration: BoxDecoration(
//                                                   color: const Color.fromARGB(
//                                                       255, 7, 59, 120),
//                                                   border: Border.all(
//                                                     color: Colors.white,
//                                                   ),
//                                                   borderRadius:
//                                                       const BorderRadius.only(
//                                                     topRight:
//                                                         Radius.circular(10),
//                                                     bottomRight:
//                                                         Radius.circular(10),
//                                                     topLeft:
//                                                         Radius.circular(10),
//                                                     bottomLeft:
//                                                         Radius.circular(10),
//                                                   )),
//                                               child: Column(children: [
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
//                                                                 "SERIAL: ",
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
//                                                                 (index + 1)
//                                                                     .toString(),
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
//                                                                 "SUBSTATION: ",
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
//                                                                 (contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList![index].substation ==
//                                                                             null ||
//                                                                         contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList![index].substation.toString() ==
//                                                                             'null')
//                                                                     ? ''
//                                                                     : contractorRowMaintenanceProgressViewModelViewModel
//                                                                         .contractorRowMaintenanceProgressViewModelGetTabularData
//                                                                         .data!
//                                                                         .getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList![
//                                                                             index]
//                                                                         .substation
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
//                                                                 "FEEDER: ",
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
//                                                                 (contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList![index].feeder ==
//                                                                             null ||
//                                                                         contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList![index].feeder.toString() ==
//                                                                             'null')
//                                                                     ? ''
//                                                                     : contractorRowMaintenanceProgressViewModelViewModel
//                                                                         .contractorRowMaintenanceProgressViewModelGetTabularData
//                                                                         .data!
//                                                                         .getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList![
//                                                                             index]
//                                                                         .feeder
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
//                                                 const Divider(
//                                                   color: Colors.grey,
//                                                 ),
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
//                                                                 (contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList![index].totalMiles ==
//                                                                             null ||
//                                                                         contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList![index].totalMiles.toString() ==
//                                                                             'null')
//                                                                     ? ''
//                                                                     : contractorRowMaintenanceProgressViewModelViewModel
//                                                                         .contractorRowMaintenanceProgressViewModelGetTabularData
//                                                                         .data!
//                                                                         .getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList![
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
//                                                                 "MILES COMPLETED: ",
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
//                                                                 (contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList![index].milesCompleted ==
//                                                                             null ||
//                                                                         contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList![index].milesCompleted.toString() ==
//                                                                             'null')
//                                                                     ? ''
//                                                                     : contractorRowMaintenanceProgressViewModelViewModel
//                                                                         .contractorRowMaintenanceProgressViewModelGetTabularData
//                                                                         .data!
//                                                                         .getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList![
//                                                                             index]
//                                                                         .milesCompleted
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
//                                                                 "ROW METHOD: ",
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
//                                                                 (contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList![index].rowMethod ==
//                                                                             null ||
//                                                                         contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList![index].rowMethod.toString() ==
//                                                                             'null')
//                                                                     ? ''
//                                                                     : contractorRowMaintenanceProgressViewModelViewModel
//                                                                         .contractorRowMaintenanceProgressViewModelGetTabularData
//                                                                         .data!
//                                                                         .getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList![
//                                                                             index]
//                                                                         .rowMethod
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
//                                                         ),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ),
//                                                 const Divider(
//                                                   color: Colors.grey,
//                                                 ),
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
//                                                                 "DELAY CAUSE: ",
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
//                                                                 (contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList![index].delayCause ==
//                                                                             null ||
//                                                                         contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList![index].delayCause.toString() ==
//                                                                             'null')
//                                                                     ? ''
//                                                                     : contractorRowMaintenanceProgressViewModelViewModel
//                                                                         .contractorRowMaintenanceProgressViewModelGetTabularData
//                                                                         .data!
//                                                                         .getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList![
//                                                                             index]
//                                                                         .delayCause
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
//                                                                 "DELAY REASON: ",
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
//                                                                 (contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList![index].delayReason ==
//                                                                             null ||
//                                                                         contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList![index].delayReason.toString() ==
//                                                                             'null')
//                                                                     ? ''
//                                                                     : contractorRowMaintenanceProgressViewModelViewModel
//                                                                         .contractorRowMaintenanceProgressViewModelGetTabularData
//                                                                         .data!
//                                                                         .getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList![
//                                                                             index]
//                                                                         .delayReason
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
//                                                                 "EFFECTED NO. of DAYS: ",
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
//                                                                 (contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList![index].effectedNoOfDays ==
//                                                                             null ||
//                                                                         contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList![index].effectedNoOfDays.toString() ==
//                                                                             'null')
//                                                                     ? ''
//                                                                     : contractorRowMaintenanceProgressViewModelViewModel
//                                                                         .contractorRowMaintenanceProgressViewModelGetTabularData
//                                                                         .data!
//                                                                         .getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList![
//                                                                             index]
//                                                                         .effectedNoOfDays
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
//                                                         ),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ),
//                                                 const Divider(
//                                                   color: Colors.grey,
//                                                 ),
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
//                                                                 "STATUS: ",
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
//                                                                 (contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList![index].status ==
//                                                                             null ||
//                                                                         contractorRowMaintenanceProgressViewModelViewModel.contractorRowMaintenanceProgressViewModelGetTabularData.data!.getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList![index].status.toString() ==
//                                                                             'null')
//                                                                     ? ''
//                                                                     : contractorRowMaintenanceProgressViewModelViewModel
//                                                                         .contractorRowMaintenanceProgressViewModelGetTabularData
//                                                                         .data!
//                                                                         .getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList![
//                                                                             index]
//                                                                         .status
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
//                                                         ),
//                                                       ),
//                                                       const Expanded(
//                                                         // alignment: Alignment.topLeft,
//                                                         child: Column(
//                                                           children: [
//                                                             Align(
//                                                               alignment:
//                                                                   Alignment
//                                                                       .topLeft,
//                                                               child: Text(
//                                                                 "ACTION: ",
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
//                                                                 '',
//                                                                 //                         (contractorRowMaintenanceProgressViewModelViewModel
//                                                                 //               .contractorRowMaintenanceProgressViewModelGetTabularData
//                                                                 //               .data!
//                                                                 // .getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList![
//                                                                 //                                             index]
//                                                                 //                                         .actions ==
//                                                                 //                                     null ||
//                                                                 //                                 contractorRowMaintenanceProgressViewModelViewModel
//                                                                 //               .contractorRowMaintenanceProgressViewModelGetTabularData
//                                                                 //               .data!
//                                                                 // .getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList![
//                                                                 //                                             index]
//                                                                 //                                         .dateOfInspection
//                                                                 //                                         .toString() ==
//                                                                 //                                     'null')
//                                                                 //                             ? ''
//                                                                 //                             : contractorRowMaintenanceProgressViewModelViewModel
//                                                                 //               .contractorRowMaintenanceProgressViewModelGetTabularData
//                                                                 //               .data!
//                                                                 // .getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList![
//                                                                 //                                     index]
//                                                                 //                                 .dateOfInspection
//                                                                 //                                 .toString(),
//                                                                 textAlign:
//                                                                     TextAlign
//                                                                         .left,
//                                                                 style:
//                                                                     TextStyle(
//                                                                   fontSize: 12,
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
//                                               ]),
//                                             ),
//                                           ),
//                                         ],
//                                       );
//                                     }),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   );

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
//   }

//   void _filterData(String query) {
//     if (query.isEmpty) {
//       fetchData('', '', '', '');
//     } else {
//       contractorRowMaintenanceProgressViewModelViewModel
//               .contractorRowMaintenanceProgressViewModelGetTabularData
//               .data!
//               .getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList =
//           contractorRowMaintenanceProgressViewModelViewModel
//               .contractorRowMaintenanceProgressViewModelGetTabularData
//               .data!
//               .getAllVMAVEGETATIONCREWFORMBySubMilesCostIdList!
//               .where((item) =>
//                   item.feeder!.toLowerCase().contains(query.toLowerCase()) ||
//                   item.substation!
//                       .toString()
//                       .toLowerCase()
//                       .contains(query.toLowerCase()))
//               .toList();
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
// }
