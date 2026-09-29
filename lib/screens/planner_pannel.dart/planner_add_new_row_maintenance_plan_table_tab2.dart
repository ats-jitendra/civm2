// import 'dart:convert';

// import 'package:CIVM/models/add_new_row_maint_model.dart';
// import 'package:CIVM/models/user_model.dart';
// import 'package:CIVM/repository/map_url.dart';
// import 'package:CIVM/resources/app_url.dart';
// import 'package:CIVM/screens/my_chrome_safari_map_recording.dart';
// import 'package:CIVM/screens/planner_pannel.dart/planner_add_new_row_maintenance_plan.dart';
// import 'package:CIVM/utils/user_pref.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// // import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// import 'package:intl/intl.dart';
// import 'package:mailer/mailer.dart';
// import 'package:mailer/smtp_server/gmail.dart';
// import 'package:provider/provider.dart';
// import '../../../data/response/status.dart';
// import '../../../utils/custom_toast_snackbar_progressdialog.dart';
// import '../../../view_model/add_new_row_maintenance_plan_view_model.dart';
// import 'package:http/http.dart' as http;

// class PlannerAddNewRowMaintenancePlanTableSpray extends StatefulWidget {
//   const PlannerAddNewRowMaintenancePlanTableSpray({Key? key}) : super(key: key);

//   @override
//   State<PlannerAddNewRowMaintenancePlanTableSpray> createState() =>
//       _PlannerAddNewRowMaintenancePlanTableSprayState();
// }

// class _PlannerAddNewRowMaintenancePlanTableSprayState
//     extends State<PlannerAddNewRowMaintenancePlanTableSpray> {
//   // int _currentIndex = 0;

//   AddNewRowMaintModel? addNewRowMaintModel;

//   final TextEditingController _input = TextEditingController();

//   onTappedBar(int index) {
//     setState(() {
//       // _currentIndex = index;
//     });
//   }

//   String now = DateFormat("yyyy-MM-dd hh:mm:ss").format(DateTime.now());

//   AddNewRowMaintenancePlanViewModel addNewRowMaintenancePlanViewModel =
//       AddNewRowMaintenancePlanViewModel();

//   final browser = MyChromeSafariBrowser();
//   int currentYear = DateTime.now().year;
//   // ignore: prefer_typing_uninitialized_variables
//   var selectedYear;

//   String selectedCrewLoginID = '';
//   List<Map<String, dynamic>> crewList = [];
//   String? selectedCrew;
//   bool isLoading = false;
//   final TextEditingController _workOrder = TextEditingController();
//   final select_crewOrGF = ['Crew', 'General Foreman'];
//   var crewOrGF = 'General Foreman';
//   bool _isVisibleCrewList = false;

//   @override
//   void initState() {
//     selectedYear = currentYear.toString();
//     addNewRowMaintenancePlanViewModel
//         .fetchAddNewRowMaintenancePlanSprayTabularListApi(
//             context, currentYear.toString());
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     // Filter the data based on maintType == 'NO SPRAY'

//     return Scaffold(

//         // drawer: DrawerManu(menu: menu),
//         body: ChangeNotifierProvider<AddNewRowMaintenancePlanViewModel>(
//             create: (BuildContext context) => addNewRowMaintenancePlanViewModel,
//             child: Consumer<AddNewRowMaintenancePlanViewModel>(
//                 builder: (context, value, _) {
//               switch (value.addNewRowMaintenancePlanGetTabularData.status) {
//                 case Status.LOADING:
//                   return const Center(child: CircularProgressIndicator());
//                 case Status.ERROR:
//                   return
//                       // CustomToastSnackBarProgressDialog.flushBarErrorMessage(
//                       //     value.addNewRowMaintenancePlanGetTabularData.message
//                       //         .toString(),
//                       //     context);
//                       Padding(
//                     padding: const EdgeInsets.only(
//                         top: 16.0, bottom: 16, left: 8, right: 8),
//                     child: Center(
//                       child: Column(
//                         children: [
//                           Image.asset(
//                             'assets/empty_box.png',
//                             height: 200,
//                             width: 200,
//                             fit: BoxFit.cover,
//                           ),
//                           const Center(
//                             child: Text(
//                               'Sorry, Data Not Found!',
//                               textAlign: TextAlign.left,
//                               style: TextStyle(
//                                 color: Color.fromARGB(255, 7, 59, 120),
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 20,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 case Status.COMPLETED:
//                   return RefreshIndicator(
//                     onRefresh: () async {
//                       _input.clear();
//                       selectedYear = currentYear.toString();
//                       await addNewRowMaintenancePlanViewModel
//                           .fetchAddNewRowMaintenancePlanSprayTabularListApi(
//                               context, currentYear.toString());
//                     },
//                     child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Container(
//                           alignment: Alignment.center,
//                           height: size.height * 1,
//                           width: size.width * 0.99,
//                           decoration: const BoxDecoration(
//                               // shape: BoxShape.circle,

//                               boxShadow: [
//                                 BoxShadow(
//                                     color: Color.fromARGB(255, 7, 59, 120),
//                                     blurRadius: 10,
//                                     offset: Offset(2.0, 5.0))
//                               ],
//                               gradient: LinearGradient(
//                                 colors: [
//                                   Color.fromARGB(255, 255, 255, 255),
//                                   Color.fromARGB(255, 255, 255, 255),
//                                 ],
//                               )),
//                           child: Column(
//                             children: [
//                               Align(
//                                 alignment: Alignment.centerLeft,
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(4.0),
//                                   child: DropdownButtonFormField<String>(
//                                     hint: const Text('-Select Year-'),
//                                     dropdownColor: Colors.white,
//                                     value: selectedYear,
//                                     style: const TextStyle(
//                                         color: Color.fromARGB(255, 7, 59, 120),
//                                         fontSize: 16),
//                                     icon: const Icon(
//                                       Icons.arrow_drop_down,
//                                       color: Color.fromARGB(255, 7, 59, 120),
//                                       size: 40,
//                                     ),
//                                     decoration: const InputDecoration(
//                                       enabledBorder: OutlineInputBorder(
//                                         borderSide: BorderSide(
//                                           color:
//                                               Color.fromARGB(255, 7, 59, 120),
//                                         ),
//                                       ),
//                                       focusedBorder: OutlineInputBorder(
//                                         borderSide: BorderSide(
//                                           color:
//                                               Color.fromARGB(255, 7, 59, 120),
//                                         ),
//                                       ),
//                                     ),
//                                     isExpanded: true,
//                                     items: addNewRowMaintenancePlanViewModel
//                                         .addNewRowMaintenancePlanGetTabularData
//                                         .data!
//                                         .yearList!
//                                         .map((e) {
//                                       return DropdownMenuItem(
//                                         value: e.year.toString(),
//                                         child: Text(e.year.toString()),
//                                       );
//                                     }).toList(),
//                                     onChanged: (val) {
//                                       setState(() {
//                                         selectedYear = val;
//                                       });

//                                       addNewRowMaintenancePlanViewModel
//                                           .fetchAddNewRowMaintenancePlanSprayTabularListApi(
//                                               context, selectedYear);
//                                     },
//                                     validator: (value) =>
//                                         value == null ? 'field required' : null,
//                                   ),
//                                 ),
//                               ),
//                               Row(
//                                 children: [
//                                   const Padding(
//                                     padding: EdgeInsets.only(top: 8.0, left: 8),
//                                     child: Align(
//                                       alignment: Alignment.topLeft,
//                                       child: Text(
//                                         "Total Record : ",
//                                         textAlign: TextAlign.left,
//                                         style: TextStyle(
//                                           color:
//                                               Color.fromARGB(255, 7, 59, 120),
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 20,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.only(top: 8.0),
//                                     child: Text(
//                                       addNewRowMaintenancePlanViewModel
//                                           .addNewRowMaintenancePlanGetTabularData
//                                           .data!
//                                           .getAlls!
//                                           .length
//                                           .toString(),
//                                       textAlign: TextAlign.left,
//                                       style: const TextStyle(
//                                         color: Color.fromARGB(255, 7, 59, 120),
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 20,
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               Align(
//                                 alignment: Alignment.centerRight,
//                                 child: Padding(
//                                   padding: const EdgeInsets.only(
//                                       left: 4.0, right: 4.0, top: 4, bottom: 4),
//                                   child: TextFormField(
//                                     onChanged: (value) => _filterData(value),
//                                     //  key: formkey2,
//                                     controller: _input,
//                                     style: const TextStyle(
//                                         color: Color.fromARGB(255, 7, 59, 120),
//                                         fontSize: 16),
//                                     obscureText: false,

//                                     //keyboardType: TextInputType.number,
//                                     decoration: const InputDecoration(
//                                       border: OutlineInputBorder(),
//                                       enabledBorder: OutlineInputBorder(
//                                         borderSide: BorderSide(
//                                           color: Color.fromARGB(255, 23, 1, 88),
//                                         ),
//                                       ),
//                                       hintText: 'Search your input...',
//                                     ),
//                                     validator: (value) {
//                                       if (value!.isEmpty) {
//                                         return "Please search your input";
//                                       } else {
//                                         return null;
//                                       }
//                                     },
//                                   ),
//                                 ),
//                               ),
//                               Expanded(
//                                 child: Align(
//                                   alignment: Alignment.center,
//                                   child: ListView.builder(
//                                       itemCount: addNewRowMaintenancePlanViewModel
//                                           .addNewRowMaintenancePlanGetTabularData
//                                           .data!
//                                           .getAlls!
//                                           .length,
//                                       // itemCount: historyList.length,
//                                       itemBuilder:
//                                           (BuildContext ctxt, int index) {
//                                         // String formattedDate = '';
//                                         // if (addNewRowMaintenancePlanViewModel
//                                         //         .addNewRowMaintenancePlanGetTabularData
//                                         //         .data!
//                                         //         .getAlls![index]
//                                         //         .nextMaintDue !=
//                                         //     null) {
//                                         //   print('not null next maint due');
//                                         //   String? dateString =
//                                         //       addNewRowMaintenancePlanViewModel
//                                         //           .addNewRowMaintenancePlanGetTabularData
//                                         //           .data!
//                                         //           .getAlls![index]
//                                         //           .nextMaintDue.toString();
//                                         //   DateTime date =
//                                         //       DateTime.parse(dateString);
//                                         //   formattedDate = DateFormat('MM/dd/yyyy')
//                                         //       .format(date);
//                                         // }
//                                         return Row(
//                                           children: [
//                                             Padding(
//                                               padding: const EdgeInsets.only(
//                                                   top: 4.0, bottom: 4, left: 4),
//                                               child: Container(
//                                                 width: MediaQuery.of(context)
//                                                         .size
//                                                         .width *
//                                                     0.919,
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
//                                                           // alignment: Alignment.topLeft,
//                                                           child: Column(
//                                                             children: [
//                                                               const Align(
//                                                                 alignment:
//                                                                     Alignment
//                                                                         .topLeft,
//                                                                 child: Text(
//                                                                   "SERIAL: ",
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
//                                                                   (index + 1)
//                                                                       .toString(),
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
//                                                               InkWell(
//                                                                 onTap: () {
//                                                                   if (addNewRowMaintenancePlanViewModel
//                                                                               .addNewRowMaintenancePlanGetTabularData
//                                                                               .data!
//                                                                               .getAlls![
//                                                                                   index]
//                                                                               .maintType ==
//                                                                           'RegularMaint' &&
//                                                                       addNewRowMaintenancePlanViewModel
//                                                                               .addNewRowMaintenancePlanGetTabularData
//                                                                               .data!
//                                                                               .getAlls![
//                                                                                   index]
//                                                                               .rowYear !=
//                                                                           '' &&
//                                                                       addNewRowMaintenancePlanViewModel
//                                                                               .addNewRowMaintenancePlanGetTabularData
//                                                                               .data!
//                                                                               .getAlls![
//                                                                                   index]
//                                                                               .rowYear !=
//                                                                           'N/A') {
//                                                                     Navigator.push(
//                                                                         context,
//                                                                         MaterialPageRoute(
//                                                                             builder: (context) => PlannerAddNewRowMaintenancePlan(
//                                                                                   tokenNo: (addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].tokenNo == null) ? '' : addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].tokenNo.toString(),
//                                                                                   nextMaintYear: addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].nextMaintDue == null ? '' : addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].nextMaintDue.toString(),
//                                                                                   subStation: addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].substation == null ? '' : addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].substation.toString(),
//                                                                                   feeder: addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].feeder == null ? '' : addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].feeder.toString(),
//                                                                                   maintType: addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].type == null ? '' : addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].type.toString(),
//                                                                                   totalMiles: addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].totalMiles == null ? '' : addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].totalMiles.toString(),
//                                                                                   totalCost: addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].totalCost == null ? '' : addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].totalCost.toString(),
//                                                                                   costPerMile: addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].costPerMile == null ? '' : addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].costPerMile.toString(),
//                                                                                   budgetType: addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].budgetType == null ? '' : addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].budgetType.toString(),
//                                                                                   contractRowYear: addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].contractYear == null ? '' : addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].contractYear.toString(),
//                                                                                   rowCycle: addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].cycle == null ? '' : addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].cycle.toString(),
//                                                                                   rowYear: addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].rowYear == null ? '' : addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].rowYear.toString(),
//                                                                                   contractorCompany: addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].contractorCompany == null ? '' : addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].contractorCompany.toString(),
//                                                                                   assignForeman: addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].contractor == null ? '' : addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].contractor.toString(),
//                                                                                   index: '0',
//                                                                                   task: 'edit',
//                                                                                 )));
//                                                                   } else if (addNewRowMaintenancePlanViewModel
//                                                                               .addNewRowMaintenancePlanGetTabularData
//                                                                               .data!
//                                                                               .getAlls![
//                                                                                   index]
//                                                                               .maintType ==
//                                                                           'RegularMaint' &&
//                                                                       addNewRowMaintenancePlanViewModel
//                                                                               .addNewRowMaintenancePlanGetTabularData
//                                                                               .data!
//                                                                               .getAlls![
//                                                                                   index]
//                                                                               .rowYear ==
//                                                                           '' &&
//                                                                       addNewRowMaintenancePlanViewModel
//                                                                               .addNewRowMaintenancePlanGetTabularData
//                                                                               .data!
//                                                                               .getAlls![index]
//                                                                               .rowYear !=
//                                                                           'N/A') {
//                                                                     Navigator.push(
//                                                                         context,
//                                                                         MaterialPageRoute(
//                                                                             builder: (context) => PlannerAddNewRowMaintenancePlan(
//                                                                                   tokenNo: (addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].tokenNo == null) ? '' : addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].tokenNo.toString(),
//                                                                                   nextMaintYear: addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].nextMaintDue == null ? '' : addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].nextMaintDue.toString(),
//                                                                                   subStation: addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].substation == null ? '' : addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].substation.toString(),
//                                                                                   feeder: addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].feeder == null ? '' : addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].feeder.toString(),
//                                                                                   maintType: addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].type == null ? '' : addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].type.toString(),
//                                                                                   totalMiles: addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].totalMiles == null ? '' : addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].totalMiles.toString(),
//                                                                                   totalCost: addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].totalCost == null ? '' : addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].totalCost.toString(),
//                                                                                   costPerMile: addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].costPerMile == null ? '' : addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].costPerMile.toString(),
//                                                                                   budgetType: addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].budgetType == null ? '' : addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].budgetType.toString(),
//                                                                                   contractRowYear: addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].contractYear == null ? '' : addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].contractYear.toString(),
//                                                                                   rowCycle: addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].cycle == null ? '' : addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].cycle.toString(),
//                                                                                   rowYear: addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].rowYear == null ? '' : addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].rowYear.toString(),
//                                                                                   contractorCompany: addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].contractorCompany == null ? '' : addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].contractorCompany.toString(),
//                                                                                   assignForeman: addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].contractor == null ? '' : addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].contractor.toString(),
//                                                                                   index: '1',
//                                                                                   task: 'edit',
//                                                                                 )));
//                                                                   }
//                                                                 },
//                                                                 child:
//                                                                     const Align(
//                                                                   alignment:
//                                                                       Alignment
//                                                                           .topLeft,
//                                                                   child: Icon(
//                                                                     Icons.edit,
//                                                                     color: Color
//                                                                         .fromARGB(
//                                                                             255,
//                                                                             151,
//                                                                             249,
//                                                                             154),
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
//                                                                   (addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].tokenNo ==
//                                                                               null ||
//                                                                           addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].tokenNo.toString() ==
//                                                                               'null')
//                                                                       ? ''
//                                                                       : addNewRowMaintenancePlanViewModel
//                                                                           .addNewRowMaintenancePlanGetTabularData
//                                                                           .data!
//                                                                           .getAlls![
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
//                                                                   (addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].substation ==
//                                                                               null ||
//                                                                           addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].substation.toString() ==
//                                                                               'null')
//                                                                       ? ''
//                                                                       : addNewRowMaintenancePlanViewModel
//                                                                           .addNewRowMaintenancePlanGetTabularData
//                                                                           .data!
//                                                                           .getAlls![
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
//                                                                   (addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].feeder ==
//                                                                               null ||
//                                                                           addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].feeder.toString() ==
//                                                                               'null')
//                                                                       ? ''
//                                                                       : addNewRowMaintenancePlanViewModel
//                                                                           .addNewRowMaintenancePlanGetTabularData
//                                                                           .data!
//                                                                           .getAlls![
//                                                                               index]
//                                                                           .feeder
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
//                                                                   (addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].type ==
//                                                                               null ||
//                                                                           addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].type.toString() ==
//                                                                               'null')
//                                                                       ? ''
//                                                                       : addNewRowMaintenancePlanViewModel
//                                                                           .addNewRowMaintenancePlanGetTabularData
//                                                                           .data!
//                                                                           .getAlls![
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
//                                                                   "SUPERVISER: ",
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
//                                                                   (addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].superviser ==
//                                                                               null ||
//                                                                           addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].superviser.toString() ==
//                                                                               'null')
//                                                                       ? ''
//                                                                       : addNewRowMaintenancePlanViewModel
//                                                                           .addNewRowMaintenancePlanGetTabularData
//                                                                           .data!
//                                                                           .getAlls![
//                                                                               index]
//                                                                           .superviser
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
//                                                                   "TOTAL MILES:",
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
//                                                                   (addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].totalMiles ==
//                                                                               null ||
//                                                                           addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].totalMiles.toString() ==
//                                                                               'null')
//                                                                       ? ''
//                                                                       : addNewRowMaintenancePlanViewModel
//                                                                           .addNewRowMaintenancePlanGetTabularData
//                                                                           .data!
//                                                                           .getAlls![
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
//                                                         //           (addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].costPerMile ==
//                                                         //                       null ||
//                                                         //                   addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].costPerMile.toString() ==
//                                                         //                       'null')
//                                                         //               ? ''
//                                                         //               : addNewRowMaintenancePlanViewModel
//                                                         //                   .addNewRowMaintenancePlanGetTabularData
//                                                         //                   .data!
//                                                         //                   .getAlls![
//                                                         //                       index]
//                                                         //                   .costPerMile
//                                                         //                   .toString(),
//                                                         //           textAlign:
//                                                         //               TextAlign
//                                                         //                   .left,
//                                                         //           style:
//                                                         //               const TextStyle(
//                                                         //             fontSize: 12,
//                                                         //             //  fontWeight:
//                                                         //             //      FontWeight.bold,
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
//                                                         //           (addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].totalCost ==
//                                                         //                       null ||
//                                                         //                   addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].totalCost.toString() ==
//                                                         //                       'null')
//                                                         //               ? ''
//                                                         //               : addNewRowMaintenancePlanViewModel
//                                                         //                   .addNewRowMaintenancePlanGetTabularData
//                                                         //                   .data!
//                                                         //                   .getAlls![
//                                                         //                       index]
//                                                         //                   .totalCost
//                                                         //                   .toString(),
//                                                         //           textAlign:
//                                                         //               TextAlign
//                                                         //                   .left,
//                                                         //           style:
//                                                         //               const TextStyle(
//                                                         //             fontSize: 12,
//                                                         //             //  fontWeight:
//                                                         //             //      FontWeight.bold,
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
//                                                                   (addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].budgetType ==
//                                                                               null ||
//                                                                           addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].budgetType.toString() ==
//                                                                               'null')
//                                                                       ? ''
//                                                                       : addNewRowMaintenancePlanViewModel
//                                                                           .addNewRowMaintenancePlanGetTabularData
//                                                                           .data!
//                                                                           .getAlls![
//                                                                               index]
//                                                                           .budgetType
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
//                                                         // Expanded(
//                                                         //   // alignment: Alignment.topLeft,
//                                                         //   child: Column(
//                                                         //     children: [
//                                                         //       const Align(
//                                                         //         alignment:
//                                                         //             Alignment
//                                                         //                 .topLeft,
//                                                         //         child: Text(
//                                                         //           "CONTRACT ROW YEAR: ",
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
//                                                         //           (addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].contractYear ==
//                                                         //                       null ||
//                                                         //                   addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].contractYear.toString() ==
//                                                         //                       'null')
//                                                         //               ? ''
//                                                         //               : addNewRowMaintenancePlanViewModel
//                                                         //                   .addNewRowMaintenancePlanGetTabularData
//                                                         //                   .data!
//                                                         //                   .getAlls![
//                                                         //                       index]
//                                                         //                   .contractYear
//                                                         //                   .toString(),
//                                                         //           textAlign:
//                                                         //               TextAlign
//                                                         //                   .left,
//                                                         //           style:
//                                                         //               const TextStyle(
//                                                         //             fontSize: 12,
//                                                         //             //  fontWeight:
//                                                         //             //      FontWeight.bold,
//                                                         //             color: Colors
//                                                         //                 .white,
//                                                         //           ),
//                                                         //         ),
//                                                         //       ),
//                                                         //     ],
//                                                         //   ),
//                                                         // ),
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
//                                                                   (addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].cycle ==
//                                                                               null ||
//                                                                           addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].cycle.toString() ==
//                                                                               'null')
//                                                                       ? ''
//                                                                       : addNewRowMaintenancePlanViewModel
//                                                                           .addNewRowMaintenancePlanGetTabularData
//                                                                           .data!
//                                                                           .getAlls![
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
//                                                                   "NEXT MAINT YEAR: ",
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
//                                                                   (addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].nextMaintDue ==
//                                                                               null ||
//                                                                           addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].nextMaintDue.toString() ==
//                                                                               'null')
//                                                                       ? ''
//                                                                       : addNewRowMaintenancePlanViewModel
//                                                                           .addNewRowMaintenancePlanGetTabularData
//                                                                           .data!
//                                                                           .getAlls![
//                                                                               index]
//                                                                           .nextMaintDue
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
//                                                               (addNewRowMaintenancePlanViewModel
//                                                                               .addNewRowMaintenancePlanGetTabularData
//                                                                               .data!
//                                                                               .getAlls![
//                                                                                   index]
//                                                                               .visibilityFlag
//                                                                               .toString() ==
//                                                                           '1' ||
//                                                                       addNewRowMaintenancePlanViewModel
//                                                                               .addNewRowMaintenancePlanGetTabularData
//                                                                               .data!
//                                                                               .getAlls![index]
//                                                                               .visibilityFlag
//                                                                               .toString() ==
//                                                                           '2')
//                                                                   ? Align(
//                                                                       alignment:
//                                                                           Alignment
//                                                                               .topLeft,
//                                                                       child:
//                                                                           InkWell(
//                                                                         onTap:
//                                                                             () async {
//                                                                           CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
//                                                                               'Job no : ${addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].tokenNo.toString()} already shared with General Foreman',
//                                                                               context);
//                                                                         },
//                                                                         child: const Align(
//                                                                             alignment: Alignment.topLeft,
//                                                                             child: Icon(
//                                                                               Icons.share,
//                                                                               color: Colors.green,
//                                                                             )),
//                                                                       ),
//                                                                     )
//                                                                   : Align(
//                                                                       alignment:
//                                                                           Alignment
//                                                                               .topLeft,
//                                                                       child:
//                                                                           InkWell(
//                                                                         onTap:
//                                                                             () async {
//                                                                           // openDialogFlag(
//                                                                           //   addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].tokenNo.toString(),
//                                                                           // );
//                                                                           showCrewDialog(
//                                                                               context,
//                                                                               addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].tokenNo.toString(),
//                                                                               addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].type.toString());
//                                                                           // updateFlagValue(
//                                                                           //     addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].tokenNo.toString(),
//                                                                           //     1);
//                                                                         },
//                                                                         child: const Align(
//                                                                             alignment: Alignment.topLeft,
//                                                                             child: Icon(
//                                                                               Icons.share,
//                                                                               color: Colors.blue,
//                                                                             )),
//                                                                       ),
//                                                                     )
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
//                                                           //  flex: 2,
//                                                           child: Column(
//                                                             children: [
//                                                               Align(
//                                                                   alignment:
//                                                                       Alignment
//                                                                           .topLeft,
//                                                                   child:
//                                                                       InkWell(
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
//                                                                       //      Navigator
//                                                                       //     .push(
//                                                                       //   context,
//                                                                       //   MaterialPageRoute(
//                                                                       //     builder: (context) =>
//                                                                       //         MapViewPage(
//                                                                       //       url:
//                                                                       //           MapUrl.getPlannerWithTokenEndPoint(addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].tokenNo.toString(), id),
//                                                                       //     ),
//                                                                       //   ),
//                                                                       // );
//                                                                       await browser.open(
//                                                                           url: WebUri(MapUrl.getPlannerWithTokenEndPoint(addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].tokenNo.toString(), id)),
//                                                                           // "https://mapapi.ariespro.com/main/planner/CIVM_Map/${addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].tokenNo.toString()}/USRQWXH589Z"),
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
//                                                                   )),
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
//                                                         //           "CONTRACT END YEAR : ",
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
//                                                         //           (addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].contractEndYear ==
//                                                         //                       null ||
//                                                         //                   addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].contractEndYear.toString() ==
//                                                         //                       'null')
//                                                         //               ? ''
//                                                         //               : addNewRowMaintenancePlanViewModel
//                                                         //                   .addNewRowMaintenancePlanGetTabularData
//                                                         //                   .data!
//                                                         //                   .getAlls![
//                                                         //                       index]
//                                                         //                   .contractEndYear
//                                                         //                   .toString(),
//                                                         //           textAlign:
//                                                         //               TextAlign
//                                                         //                   .left,
//                                                         //           style:
//                                                         //               const TextStyle(
//                                                         //             fontSize: 12,
//                                                         //             //  fontWeight:
//                                                         //             //      FontWeight.bold,
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
//                                                         //           "ESTIMATED COST : ",
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
//                                                         //           (addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].estCost ==
//                                                         //                       null ||
//                                                         //                   addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].estCost.toString() ==
//                                                         //                       'null')
//                                                         //               ? ''
//                                                         //               : addNewRowMaintenancePlanViewModel
//                                                         //                   .addNewRowMaintenancePlanGetTabularData
//                                                         //                   .data!
//                                                         //                   .getAlls![
//                                                         //                       index]
//                                                         //                   .estCost
//                                                         //                   .toString(),
//                                                         //           textAlign:
//                                                         //               TextAlign
//                                                         //                   .left,
//                                                         //           style:
//                                                         //               const TextStyle(
//                                                         //             fontSize: 12,
//                                                         //             //  fontWeight:
//                                                         //             //      FontWeight.bold,
//                                                         //             color: Colors
//                                                         //                 .white,
//                                                         //           ),
//                                                         //         ),
//                                                         //       ),
//                                                         //     ],
//                                                         //   ),
//                                                         // ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                   const Padding(
//                                                     padding: EdgeInsets.only(
//                                                         left: 8.0),
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
//                                                         //           "ESTIMATED TIME : ",
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
//                                                         //           (addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].estTime ==
//                                                         //                       null ||
//                                                         //                   addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].estTime.toString() ==
//                                                         //                       'null')
//                                                         //               ? ''
//                                                         //               : addNewRowMaintenancePlanViewModel
//                                                         //                   .addNewRowMaintenancePlanGetTabularData
//                                                         //                   .data!
//                                                         //                   .getAlls![
//                                                         //                       index]
//                                                         //                   .estTime
//                                                         //                   .toString(),
//                                                         //           textAlign:
//                                                         //               TextAlign
//                                                         //                   .left,
//                                                         //           style:
//                                                         //               const TextStyle(
//                                                         //             fontSize: 12,
//                                                         //             //  fontWeight:
//                                                         //             //      FontWeight.bold,
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
//                                                         //           "ACTUAL COST : ",
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
//                                                         //           (addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].actualCost ==
//                                                         //                       null ||
//                                                         //                   addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].actualCost.toString() ==
//                                                         //                       'null')
//                                                         //               ? ''
//                                                         //               : addNewRowMaintenancePlanViewModel
//                                                         //                   .addNewRowMaintenancePlanGetTabularData
//                                                         //                   .data!
//                                                         //                   .getAlls![
//                                                         //                       index]
//                                                         //                   .actualCost
//                                                         //                   .toString(),
//                                                         //           textAlign:
//                                                         //               TextAlign
//                                                         //                   .left,
//                                                         //           style:
//                                                         //               const TextStyle(
//                                                         //             fontSize: 12,
//                                                         //             //  fontWeight:
//                                                         //             //      FontWeight.bold,
//                                                         //             color: Colors
//                                                         //                 .white,
//                                                         //           ),
//                                                         //         ),
//                                                         //       ),
//                                                         //     ],
//                                                         //   ),
//                                                         // ),

//                                                         // Expanded(
//                                                         //   //  flex: 3,
//                                                         //   child: Column(
//                                                         //     children: [
//                                                         //       Align(
//                                                         //           alignment:
//                                                         //               Alignment
//                                                         //                   .topLeft,
//                                                         //           child: InkWell(
//                                                         //             onTap:
//                                                         //                 () async {
//                                                         //               await browser.open(
//                                                         //                   url:
//                                                         //                       WebUri(
//                                                         //                           // "https://mapapi.ariespro.com/main/admin/CIVM_Map/${addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].tokenNo.toString()}/USRQWXH589Z"
//                                                         //                           "https://mapapi.ariespro.com/main/planner/CIVM_Map/${addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data!.getAlls![index].tokenNo.toString()}/USRQWXH589Z"),
//                                                         //                   settings: ChromeSafariBrowserSettings(
//                                                         //                       shareState:
//                                                         //                           CustomTabsShareState.SHARE_STATE_OFF,
//                                                         //                       barCollapsingEnabled: true));
//                                                         //             },
//                                                         //             child: Align(
//                                                         //               alignment:
//                                                         //                   Alignment
//                                                         //                       .centerLeft,
//                                                         //               child:
//                                                         //                   Container(
//                                                         //                 // margin: const EdgeInsets.only(
//                                                         //                 //     left: 40, right: 40, bottom: 10.0),
//                                                         //                 padding:
//                                                         //                     const EdgeInsets
//                                                         //                         .all(
//                                                         //                         8),
//                                                         //                 alignment:
//                                                         //                     Alignment
//                                                         //                         .centerLeft,
//                                                         //                 width: 80,
//                                                         //                 // MediaQuery.of(context).size.width,
//                                                         //                 // height: MediaQuery.of(context).size.height * 0.4,
//                                                         //                 decoration: const BoxDecoration(
//                                                         //                     // shape: BoxShape.circle,

//                                                         //                     color: Color.fromARGB(255, 0, 58, 106),
//                                                         //                     gradient: LinearGradient(
//                                                         //                       colors: [
//                                                         //                         Color.fromARGB(255, 0, 79, 215),
//                                                         //                         Colors.blue,
//                                                         //                         Color.fromARGB(255, 0, 79, 215),
//                                                         //                       ],
//                                                         //                     )),
//                                                         //                 child:
//                                                         //                     const Align(
//                                                         //                   alignment:
//                                                         //                       Alignment.center,
//                                                         //                   child:
//                                                         //                       Text(
//                                                         //                     "VIEW MAP",
//                                                         //                     style:
//                                                         //                         TextStyle(
//                                                         //                       color:
//                                                         //                           Colors.white,
//                                                         //                       fontWeight:
//                                                         //                           FontWeight.bold,
//                                                         //                       fontSize:
//                                                         //                           10,
//                                                         //                     ),
//                                                         //                   ),
//                                                         //                 ),
//                                                         //               ),
//                                                         //             ),
//                                                         //           )),
//                                                         //     ],
//                                                         //   ),
//                                                         // ),
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
//                               ),
//                             ],
//                           ),
//                         )),
//                   );

//                 default:
//                   return const Text('data');
//               }
//             })));
//   }

//   Future<void> _filterData(String query) async {
//     if (query.isEmpty) {
//       addNewRowMaintenancePlanViewModel
//           .fetchAddNewRowMaintenancePlanSprayTabularListApi(
//               context, selectedYear);
//     } else {
//       addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanGetTabularData.data?.getAlls = addNewRowMaintenancePlanViewModel
//           .addNewRowMaintenancePlanGetTabularData.data?.getAlls
//           ?.where((item) =>
//               item.tokenNo.toString().toLowerCase().contains(query.toLowerCase()) ||
//               item.status
//                   .toString()
//                   .toLowerCase()
//                   .contains(query.toLowerCase()) ||
//               item.substation
//                   .toString()
//                   .toLowerCase()
//                   .contains(query.toLowerCase()) ||
//               item.type
//                   .toString()
//                   .toLowerCase()
//                   .contains(query.toLowerCase()) ||
//               item.superviser
//                   .toString()
//                   .toLowerCase()
//                   .contains(query.toLowerCase()) ||
//               item.cycle
//                   .toString()
//                   .toLowerCase()
//                   .contains(query.toLowerCase()) ||
//               item.costPerMile
//                   .toString()
//                   .toLowerCase()
//                   .contains(query.toLowerCase()) ||
//               item.budgetType
//                   .toString()
//                   .toLowerCase()
//                   .contains(query.toLowerCase()) ||
//               item.contractEndYear.toString().toLowerCase().contains(query.toLowerCase()) ||
//               item.totalMiles.toString().toLowerCase().contains(query.toLowerCase()) ||
//               item.totalCost.toString().toLowerCase().contains(query.toLowerCase()) ||
//               item.contractYear.toString().toLowerCase().contains(query.toLowerCase()) ||
//               item.costPerMile.toString().toLowerCase().contains(query.toLowerCase()) ||
//               item.totalCost.toString().toLowerCase().contains(query.toLowerCase()) ||
//               item.nextMaintDue.toString().toLowerCase().contains(query.toLowerCase()) ||
//               item.feeder.toString().toLowerCase().contains(query.toLowerCase()))
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
//         String generalForemanEmailId = responseBody['generalForemanEmailId'];
//         print('API call successful');
//         // CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
//         //     'Job no : $token successfully shared with General Foreman',
//         //     context);
//           if (crewOrGF == 'Crew') {
//           CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
//               '$token Mid cycle Herbicide Successfully Shared with Crew', context);
//         } else {
//           CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
//               '$token Mid cycle Herbicide Successfully Shared with General Foreman',
//               context);
//         }
//         // CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
//         //     '$token Mid cycle Herbicide Successfully Shared with General Foreman',
//         //     context);
//         DateTime now = DateTime.now();
//         var formatter = DateFormat('MM-dd-yyyy HH:mm:ss');
//         String formattedDate = formatter.format(now);
//         var subject = 'CIVM ROW';
//         // var msg =
//         //     'Job No. $token Row Maintenance Successfully Shared with you on $formattedDate.';
//         var msg =
//             'Job No. $token Mid cycle Herbicide Successfully Shared with you on $formattedDate.';

//         _sendMail(subject, msg, generalForemanEmailId);
//         addNewRowMaintenancePlanViewModel
//             .fetchAddNewRowMaintenancePlanSprayTabularListApi(
//                 context, currentYear.toString());
//         selectedYear = currentYear.toString();
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
//       String subject, String content, String generalForemanEmailId) async {
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
//         generalForemanEmailId
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
//                   child: Align(
//                     alignment: Alignment.centerLeft,
//                     child: Text(
//                       "Are you sure to share job no : $tokenNo with General Foreman?",
//                       // textAlign: TextAlign.left,
//                       style: const TextStyle(
//                         color: Color.fromARGB(255, 7, 59, 120),
//                         fontWeight: FontWeight.bold,
//                         fontSize: 14,
//                       ),
//                     ),
//                   ),
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
//                                 "CANCEL",
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
//                             updateFlagValue(tokenNo, 1);
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
//   bool isSubmitting = false; 
//   void showCrewDialog(BuildContext context, String tokenNo, String type) async {
//     await fetchCrewList(); // Fetch crew list before showing the dialog

//     String? selectedCrew; // Local state for dropdown selection
//     String? errorMessage; // To show validation error message
//     _workOrder.text = '${tokenNo} - ${type}';
//     print('_workOrder.text ${_workOrder.text}');
//     showDialog(
//       context: context,
//       builder: (BuildContext dialogContext) {
//         return StatefulBuilder(
//           builder: (context, setStateDialog) {
//             return AlertDialog(
//               title: const Text(
//                 "SELECT CREW",
//                 style: TextStyle(
//                     fontSize: 20.0,
//                     color: Color.fromARGB(255, 7, 59, 120),
//                     fontWeight: FontWeight.bold),
//               ),
//               content: isLoading
//                   ? const Center(child: CircularProgressIndicator())
//                   : Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         const Align(
//                             alignment: Alignment.centerLeft,
//                             child: Text(
//                               "WORK ORDER",
//                               style: TextStyle(
//                                   fontSize: 16.0,
//                                   color: Color.fromARGB(255, 7, 59, 120),
//                                   fontWeight: FontWeight.bold),
//                             )),
//                         Align(
//                           alignment: Alignment.centerRight,
//                           child: Padding(
//                             padding: const EdgeInsets.all(2.0),
//                             child: TextFormField(
//                               enabled: false,
//                               controller: _workOrder,
//                               style: const TextStyle(
//                                   color: Color.fromARGB(255, 7, 59, 120),
//                                   fontSize: 16),
//                               obscureText: false,
//                               // keyboardType:
//                               //     TextInputType.number,
//                               keyboardType:
//                                   const TextInputType.numberWithOptions(
//                                 decimal: true,
//                                 signed: false,
//                               ),
//                               decoration: const InputDecoration(
//                                 border: OutlineInputBorder(),
//                                 disabledBorder: OutlineInputBorder(
//                                   borderSide: BorderSide(
//                                     color: Color.fromARGB(255, 7, 59, 120),
//                                   ),
//                                 ),
//                                 hintText: '',
//                               ),
//                               maxLines: null,
//                               minLines: 1,
//                               expands: false,
//                             ),
//                           ),
//                         ),
//                         const Padding(
//                           padding: EdgeInsets.only(top: 8.0),
//                           child: Align(
//                               alignment: Alignment.centerLeft,
//                               child: Text(
//                                 // "BUDGET TYPE*",
//                                 "SHARE WITH*",
//                                 style: TextStyle(
//                                     fontSize: 16,
//                                     color: Color.fromARGB(255, 7, 59, 120),
//                                     fontWeight: FontWeight.bold),
//                               )),
//                         ),
//                         Align(
//                           alignment: Alignment.centerLeft,
//                           child: Padding(
//                             padding: const EdgeInsets.all(2.0),
//                             child: DropdownButtonFormField<String>(
//                               hint: const Text('-Select-'),
//                               dropdownColor: Colors.white,
//                               value: crewOrGF,
//                               style: const TextStyle(
//                                   color: Color.fromARGB(255, 7, 59, 120),
//                                   fontSize: 16),
//                               icon: const Icon(
//                                 Icons.arrow_drop_down,
//                                 color: Color.fromARGB(255, 7, 59, 120),
//                                 size: 40,
//                               ),
//                               decoration: const InputDecoration(
//                                 enabledBorder: OutlineInputBorder(
//                                   borderSide: BorderSide(
//                                     color: Color.fromARGB(255, 7, 59, 120),
//                                   ),
//                                 ),
//                                 focusedBorder: OutlineInputBorder(
//                                   borderSide: BorderSide(
//                                     color: Color.fromARGB(255, 7, 59, 120),
//                                   ),
//                                 ),
//                               ),
//                               isExpanded: true,
//                               items:
//                                   select_crewOrGF.map(buildMenuItem).toList(),
//                               onChanged: (value) {
//                                 setStateDialog(() {
//                                   crewOrGF = value!;
//                                   _isVisibleCrewList = (crewOrGF ==
//                                       'Crew'); // Correct way to update visibility
//                                 });
//                               },
//                               validator: (value) =>
//                                   value == null ? 'field required' : null,
//                             ),
//                           ),
//                         ),
//                         Visibility(
//                           visible: _isVisibleCrewList,
//                           child: Padding(
//                             padding: const EdgeInsets.only(top: 8.0),
//                             child: Column(
//                               children: [
//                                 const Align(
//                                     alignment: Alignment.centerLeft,
//                                     child: Text(
//                                       "CREW NAME",
//                                       style: TextStyle(
//                                           fontSize: 16,
//                                           color:
//                                               Color.fromARGB(255, 7, 59, 120),
//                                           fontWeight: FontWeight.bold),
//                                     )),
//                                 DropdownButtonFormField<String>(
//                                   value: selectedCrew,
//                                   hint: const Text("Select Crew"),
//                                   isExpanded: true,
//                                   icon: const Icon(
//                                     Icons.arrow_drop_down,
//                                     color: Color.fromARGB(255, 7, 59, 120),
//                                     size: 40,
//                                   ),
//                                   decoration: const InputDecoration(
//                                     border: OutlineInputBorder(),
//                                     enabledBorder: OutlineInputBorder(
//                                       borderSide: BorderSide(
//                                         color: Color.fromARGB(255, 7, 59, 120),
//                                       ),
//                                     ),
//                                     focusedBorder: OutlineInputBorder(
//                                       borderSide: BorderSide(
//                                         color: Color.fromARGB(255, 7, 59, 120),
//                                         width: 2.0,
//                                       ),
//                                     ),
//                                   ),
//                                   items: crewList.map((crew) {
//                                     return DropdownMenuItem(
//                                       value: crew["loginId"].toString(),
//                                       child: Text(crew["name"]),
//                                     );
//                                   }).toList(),
//                                   onChanged: (value) {
//                                     setStateDialog(() {
//                                       selectedCrew = value;
//                                       errorMessage =
//                                           null; // Clear error when selected
//                                     });
//                                     selectedCrewLoginID = value.toString();
//                                   },
//                                 ),
//                                 if (errorMessage !=
//                                     null) // Show error if exists
//                                   Padding(
//                                     padding: const EdgeInsets.only(top: 8.0),
//                                     child: Text(
//                                       errorMessage!,
//                                       style: const TextStyle(
//                                         color: Colors.red,
//                                         fontSize: 14,
//                                       ),
//                                     ),
//                                   ),
//                               ],
//                             ),
//                           ),
//                         )
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
//                          isLoading: isSubmitting,
//                         onTap: () async{
//                           if (crewOrGF == 'Crew' && selectedCrew == null) {
//                             print('22222222');
//                             setStateDialog(() {
//                               print('3333333');
//                               errorMessage = "Please select a crew.";
//                             });
//                             print('44444');
//                             return;
//                           }
//   setStateDialog(() {
//                             isSubmitting = true; // START LOADER
//                           });
//                           print('55555');

//                           // // Updating flag value based on selection
//                           // if (crewOrGF == 'Crew') {
//                           //   print('if condition');
//                           //   updateFlagValue(tokenNo, 2);
//                           // } else {
//                           //   print('else condition');
//                           //   updateFlagValue(tokenNo, 1);
//                           // }
//                             try {
//                             if (crewOrGF == 'Crew') {
//                               await updateFlagValue(tokenNo, 2);
//                             } else {
//                               await updateFlagValue(tokenNo, 1);
//                             }

//                             Navigator.pop(
//                                 dialogContext); // close dialog after success
//                           } catch (e) {
//                             print(e);
//                           } finally {
//                             setStateDialog(() {
//                               isSubmitting = false; // STOP LOADER
//                             });
//                           }
//                           //
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

//   Future<void> fetchCrewList() async {
//     setState(() {
//       isLoading = true;
//     });

//     final userPreferences = Provider.of<UserPref>(context, listen: false);
//     UserModel data = await userPreferences.getUser();
//     // String contractorId = "";
//     // data.user!.id.toString();

//     String url = AppUrl.crewList;
//         // "https://civmapi.ariespro.com/civmapi/login_user/getAllCrewFromCREWMASTER?contractorId=$contractorId";

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

// // Helper function for dialog buttons
//   Widget _buildDialogButton(BuildContext context,
//       {required String text,
//       required Color color,
//       required VoidCallback onTap,
//        bool isLoading = false,}) {
//     return Container(
//       margin: const EdgeInsets.only(left: 6, top: 6.0, bottom: 10),
//       child: InkWell(
//         onTap: isLoading ? null : onTap, // disable while loading onTap,
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
//             child:isLoading
//                 ? const SizedBox(
//                     height: 20,
//                     width: 20,
//                     child: CircularProgressIndicator(
//                       strokeWidth: 2,
//                       color: Colors.white,
//                     ),
//                   )
//                 : Text(
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
// }
