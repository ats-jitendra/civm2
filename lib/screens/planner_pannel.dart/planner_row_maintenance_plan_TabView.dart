// // ignore: file_names
// import 'dart:convert';
// import 'package:CIVM/models/row_maintenance_plan_tab_new.dart';
// import 'package:CIVM/screens/planner_pannel.dart/planner_add_new_row_maintenance_plan.dart';
// import 'package:CIVM/screens/planner_pannel.dart/view_page_change_order.dart';
// import 'package:flutter/material.dart';
// import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
// import 'package:multi_select_flutter/util/multi_select_item.dart';
// import 'package:multi_select_flutter/util/multi_select_list_type.dart';
// import 'package:provider/provider.dart';
// import '../../../data/response/status.dart';
// import '../../../utils/custom_icons.dart';
// import '../../../view_model/row_maintenance_plan_tab_view_model.dart';

// class PlannerRowMaintenancePlanTabView extends StatefulWidget {
//   const PlannerRowMaintenancePlanTabView({Key? key}) : super(key: key);

//   @override
//   State<PlannerRowMaintenancePlanTabView> createState() =>
//       _PlannerRowMaintenancePlanTabViewState();
// }

// class _PlannerRowMaintenancePlanTabViewState
//     extends State<PlannerRowMaintenancePlanTabView> {
//   Future? myFuture;
//   final TextEditingController _totalMiles = TextEditingController();
//   final TextEditingController _costPerMiles = TextEditingController();
//   final TextEditingController _cycle = TextEditingController();
//   final TextEditingController _budget = TextEditingController();
//   final TextEditingController _otherContractor = TextEditingController();
//   bool _visibilityOther = false;
// // ignore: non_constant_identifier_names
//   final List<String> rate_class = [];
//   String? rate;
//   String? rateID = '0';

//   // ignore: prefer_typing_uninitialized_variables
//   var selectedContractor;
//   // ignore: non_constant_identifier_names
//   final usage_range = [
//     'All',
//     '0-800',
//     '801-1600',
//     '1601-2400',
//     '2400+',
//   ];
//   String? range = 'All';
// // // ignore: non_constant_identifier_names
// //   final contractor_names = [
// //     'BRUCE',
// //     'JAMES',
// //     'JOSH',
// //     'ROBERT',
// //     'STEVE',
// //     'OTHER'
// //   ];
// //   String? contractor = 'ROBERT';
//   // bool? _SiteInspection = false;
// // ignore: non_constant_identifier_names
//   String? year;
//   // ignore: non_constant_identifier_names
//   String? cycle;
//   // ignore: non_constant_identifier_names
//   String? substation;
//   String? feeder;
// // ignore: non_constant_identifier_names
//   final List<String> select_month = ['1', '2', '3'];
//   String? month;
//   String mnth = '';

//   List nextMaintDue = [];
//   String nextMaintDueZeroIndex = '';

//   final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

//   // bool _isVisibleRecords = false;

//   // bool? _valueAll = false;

//   var state;

//   RowMaintenancePlanTabViewModel rowMaintenancePlanTabViewModel =
//       RowMaintenancePlanTabViewModel();

//   List<RowMaintenancePlanTabNewModel> updateData = [];

//   List<int> updatedIndex = [];

//   double totalCost = 0.0;

//   @override
//   void initState() {
//     rowMaintenancePlanTabViewModel.fetchRowMaintenancePlanTavViewListApi(
//         context, '0', '0', '0', '0');
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return FutureBuilder(
//         future: myFuture,
//         builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
//           // if (snapshot.connectionState == ConnectionState.done) {
//           return GestureDetector(
//               onTap: () {
//                 FocusScopeNode currentFocus = FocusScope.of(context);
//                 if (!currentFocus.hasPrimaryFocus) {
//                   currentFocus.unfocus();
//                 }
//               },
//               child: Scaffold(
//                   backgroundColor: Colors.white,
//                   body: ChangeNotifierProvider<RowMaintenancePlanTabViewModel>(
//                       create: (BuildContext context) =>
//                           rowMaintenancePlanTabViewModel,
//                       child: Consumer<RowMaintenancePlanTabViewModel>(
//                           builder: (context, value, _) {
//                         switch (value.rowMaintenancePlanTabList.status) {
//                           case Status.LOADING:
//                             return const Center(
//                                 child: CircularProgressIndicator());
//                           case Status.ERROR:
//                             return
//                                 // CustomToastSnackBarProgressDialog
//                                 //     .flushBarErrorMessage(
//                                 //         value.rowMaintenancePlanTabList.message
//                                 //             .toString(),
//                                 //         context);
//                                 Padding(
//                               padding: const EdgeInsets.only(
//                                   top: 16.0, bottom: 16, left: 8, right: 8),
//                               child: Center(
//                                 child: Column(
//                                   children: [
//                                     Image.asset(
//                                       'assets/empty_box.png',
//                                       height: 200,
//                                       width: 200,
//                                       fit: BoxFit.cover,
//                                     ),
//                                     const Center(
//                                       child: Text(
//                                         'Sorry, Data Not Found!',
//                                         textAlign: TextAlign.left,
//                                         style: TextStyle(
//                                           color:
//                                               Color.fromARGB(255, 7, 59, 120),
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 20,
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             );
//                           case Status.COMPLETED:
//                             return RefreshIndicator(
//                               onRefresh: () async {
//                                 await rowMaintenancePlanTabViewModel
//                                     .fetchRowMaintenancePlanTavViewListApi(
//                                         context, '0', '0', '0', '0');
//                               },
//                               child: Form(
//                                 key: _formkey,
//                                 child: Padding(
//                                   padding: const EdgeInsets.only(
//                                     left: 10.0,
//                                     right: 10.0,
//                                     bottom: 10,
//                                   ),
//                                   child: Column(
//                                     children: [
//                                       Visibility(
//                                         // visible: _isVisibleRecords,
//                                         child: Column(
//                                           children: [
//                                             Padding(
//                                               padding: const EdgeInsets.only(
//                                                   top: 8.0),
//                                               child: Container(
//                                                 color: const Color.fromARGB(
//                                                     255, 7, 59, 120),
//                                                 child: const Padding(
//                                                   padding: EdgeInsets.all(8.0),
//                                                   child: Text(
//                                                     'Important: You can modify only Total Mile, Cycle and Foreman. ',
//                                                     style: TextStyle(
//                                                       fontSize: 16.0,
//                                                       color: Colors.white,
//                                                       // fontWeight: FontWeight.bold,
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                             Row(
//                                               children: [
//                                                 Expanded(
//                                                   child: Padding(
//                                                     padding:
//                                                         const EdgeInsets.only(
//                                                             top: 10.0),
//                                                     child: Text(
//                                                       'Total No. of Records : ${value.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus!.length}',
//                                                       style: const TextStyle(
//                                                         fontSize: 20.0,
//                                                         color: Color.fromARGB(
//                                                             255, 7, 59, 120),
//                                                         fontWeight:
//                                                             FontWeight.bold,
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                                 Padding(
//                                                   padding:
//                                                       const EdgeInsets.only(
//                                                           top: 8.0),
//                                                   child: IconButton(
//                                                     icon: const Icon(
//                                                       CustomIcons
//                                                           .filter_alt_outlined,
//                                                       color: Color.fromARGB(
//                                                           255, 7, 59, 120),
//                                                     ),
//                                                     onPressed: () {
//                                                       openFilter();
//                                                     },
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                       Container(
//                                           margin: const EdgeInsets.only(
//                                               left: 2,
//                                               right: 10,
//                                               top: 6.0,
//                                               bottom: 10),
//                                           child: InkWell(
//                                             onTap: () {
//                                               //running code
//                                               List b = [];
//                                               for (var i = 0;
//                                                   i < updateData.length;
//                                                   i++) {
//                                                 b.add({
//                                                   "id": updateData[i].id,
//                                                   "totalMiles":
//                                                       updateData[i]
//                                                           .totalMiles,
//                                                   "costPerMile":
//                                                       updateData[i]
//                                                           .costPerMile,
//                                                   "totalCost":
//                                                       updateData[i]
//                                                           .totalCost,
//                                                   "budget": 0.0,
//                                                   // updateData[i].budget,
//                                                   "cycle":
//                                                       updateData[i].cycle,
//                                                   "nextMaintDue":
//                                                       updateData[i]
//                                                           .nextMaintDue,
//                                                   "supervisor":
//                                                       updateData[i]
//                                                           .supervisorId,
//                                                   "status": 'PENDING',
//                                                   "contractorCompay":
//                                                       updateData[i]
//                                                           .contractorCompany,
//                                                   // updateData[i].status
//                                                 });
//                                               }
//                                               var c = jsonEncode(b);
//                                               print(c);
                                      
//                                               var decodedList =
//                                                   jsonDecode(c);
//                                               print(decodedList);
//                                               rowMaintenancePlanTabViewModel
//                                                   .fetchRowMaintenancePlanTabViewUpdateListApi(
//                                                       context,
//                                                       decodedList
//                                                           as List);
//                                             },
//                                             child: Container(
//                                               alignment: Alignment.center,
//                                               height: 40,
//                                               width: size.width * 0.9,
//                                               decoration:
//                                                   const BoxDecoration(
//                                                       boxShadow: [
//                                                     BoxShadow(
//                                                         color: Color
//                                                             .fromARGB(
//                                                                 255,
//                                                                 133,
//                                                                 12,
//                                                                 3),
//                                                         blurRadius: 5,
//                                                         offset: Offset(
//                                                             2.0, 5.0))
//                                                   ],
//                                                       color: Colors.black,
//                                                       gradient:
//                                                           LinearGradient(
//                                                         colors: [
//                                                           Color.fromARGB(
//                                                               255,
//                                                               250,
//                                                               20,
//                                                               3),
//                                                           Color.fromARGB(
//                                                               255,
//                                                               193,
//                                                               15,
//                                                               3),
//                                                         ],
//                                                       )),
//                                               child: const Row(children: [
//                                                 Expanded(
//                                                   child: Align(
//                                                     alignment:
//                                                         Alignment.center,
//                                                     child: Text(
//                                                       "Submit Plan",
//                                                       textAlign:
//                                                           TextAlign.left,
//                                                       style: TextStyle(
//                                                         color:
//                                                             Colors.white,
//                                                         fontWeight:
//                                                             FontWeight
//                                                                 .bold,
//                                                         fontSize: 20,
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ]),
//                                             ),
//                                           )),
//                                       Expanded(
//                                         child: SingleChildScrollView(
//                                           physics:
//                                               const AlwaysScrollableScrollPhysics(),
//                                           child: ListView.builder(
//                                             shrinkWrap: true,
//                                             itemCount: value
//                                                 .rowMaintenancePlanTabList
//                                                 .data!
//                                                 .allVMARowMaintPlanListForAdminSupervisorWorkStatus!
//                                                 .length,
//                                             physics:
//                                                 const NeverScrollableScrollPhysics(),
//                                             // itemCount: energyhistory!.result!.length,
//                                             itemBuilder: (BuildContext context,
//                                                 int index) {
//                                               // contractor = (rowMaintenancePlanTabViewModel
//                                               //             .rowMaintenancePlanTabList
//                                               //             .data!
//                                               //             .allVMARowMaintPlanListForAdminSupervisorWorkStatus![
//                                               //                 index]
//                                               //             .contractor
//                                               //             .toString()
//                                               //             .isEmpty ||
//                                               //         rowMaintenancePlanTabViewModel
//                                               //                 .rowMaintenancePlanTabList
//                                               //                 .data!
//                                               //                 .allVMARowMaintPlanListForAdminSupervisorWorkStatus![
//                                               //                     index]
//                                               //                 .contractor ==
//                                               //             null ||
//                                               //         rowMaintenancePlanTabViewModel
//                                               //                 .rowMaintenancePlanTabList
//                                               //                 .data!
//                                               //                 .allVMARowMaintPlanListForAdminSupervisorWorkStatus![
//                                               //                     index]
//                                               //                 .contractor
//                                               //                 .toString() ==
//                                               //             'null')
//                                               //     ? 'ROBERT'
//                                               //     : rowMaintenancePlanTabViewModel
//                                               //         .rowMaintenancePlanTabList
//                                               //         .data!
//                                               //         .allVMARowMaintPlanListForAdminSupervisorWorkStatus![
//                                               //             index]
//                                               //         .contractor
//                                               //         .toString();

//                                               nextMaintDue =
//                                                   rowMaintenancePlanTabViewModel
//                                                       .rowMaintenancePlanTabList
//                                                       .data!
//                                                       .allVMARowMaintPlanListForAdminSupervisorWorkStatus![
//                                                           index]
//                                                       .nextMaintDue!
//                                                       .split('-');

//                                               nextMaintDueZeroIndex =
//                                                   nextMaintDue[0];
//                                               return Container(
//                                                 margin: const EdgeInsets.only(
//                                                     left: 2,
//                                                     right: 2,
//                                                     top: 10,
//                                                     bottom: 8),
//                                                 padding:
//                                                     const EdgeInsets.all(8),
//                                                 alignment: Alignment.center,
//                                                 // height: size.height * 0.5,
//                                                 width: size.width * 0.99,
//                                                 decoration: BoxDecoration(
//                                                     // shape: BoxShape.circle,
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             10),
//                                                     boxShadow: const [
//                                                       BoxShadow(
//                                                           color: Color.fromARGB(
//                                                               255, 7, 59, 120),
//                                                           blurRadius: 10,
//                                                           offset:
//                                                               Offset(2.0, 5.0))
//                                                     ],
//                                                     gradient:
//                                                         const LinearGradient(
//                                                       colors: [
//                                                         Color.fromARGB(
//                                                             255, 255, 255, 255),
//                                                         Color.fromARGB(
//                                                             255, 255, 255, 255),
//                                                       ],
//                                                     )),
//                                                 child: Column(
//                                                   children: [
//                                                     Container(
//                                                       padding:
//                                                           const EdgeInsets.all(
//                                                               10),
//                                                       alignment:
//                                                           Alignment.center,
//                                                       width: size.width * 0.99,
//                                                       // width: MediaQuery.of(context).size.width,
//                                                       // height: 50,
//                                                       decoration:
//                                                           const BoxDecoration(
//                                                               // shape: BoxShape.circle,
//                                                               //
//                                                               boxShadow: [
//                                                             BoxShadow(
//                                                                 color: Color
//                                                                     .fromARGB(
//                                                                         255,
//                                                                         3,
//                                                                         47,
//                                                                         97),
//                                                                 blurRadius: 5,
//                                                                 offset: Offset(
//                                                                     2.0, 5.0))
//                                                           ],
//                                                               color: Color
//                                                                   .fromARGB(
//                                                                       255,
//                                                                       130,
//                                                                       193,
//                                                                       245),
//                                                               gradient:
//                                                                   LinearGradient(
//                                                                 colors: [
//                                                                   Color
//                                                                       .fromARGB(
//                                                                           255,
//                                                                           7,
//                                                                           59,
//                                                                           120),
//                                                                   Color
//                                                                       .fromARGB(
//                                                                           255,
//                                                                           7,
//                                                                           59,
//                                                                           120)
//                                                                 ],
//                                                               )),
//                                                       child: Row(
//                                                           crossAxisAlignment:
//                                                               CrossAxisAlignment
//                                                                   .center,
//                                                           children: [
//                                                             const Text(
//                                                               "Serial No: ",
//                                                               textAlign:
//                                                                   TextAlign
//                                                                       .left,
//                                                               style: TextStyle(
//                                                                 color: Colors
//                                                                     .white,
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .bold,
//                                                                 fontSize: 20,
//                                                               ),
//                                                             ),
//                                                             Expanded(
//                                                               // flex: 1,
//                                                               child: Text(
//                                                                 (index + 1)
//                                                                     .toString(),
//                                                                 textAlign:
//                                                                     TextAlign
//                                                                         .left,
//                                                                 style:
//                                                                     const TextStyle(
//                                                                   color: Colors
//                                                                       .white,
//                                                                   fontWeight:
//                                                                       FontWeight
//                                                                           .bold,
//                                                                   fontSize: 20,
//                                                                 ),
//                                                               ),
//                                                             ),
//                                                             SizedBox(
//                                                               height: 30,
//                                                               width: 30,
//                                                               child: IconButton(
//                                                                 icon:
//                                                                     const Icon(
//                                                                   Icons.edit,
//                                                                   color: Colors
//                                                                       .white,
//                                                                 ),
//                                                                 onPressed: () {
//                                                                   setData1(
//                                                                       index);
//                                                                 },
//                                                               ),

//                                                               // Checkbox(
//                                                               //     value:
//                                                               //         _valueAll, //set variable for value
//                                                               //     onChanged: (bool?
//                                                               //         value) {
//                                                               //       setState(() {
//                                                               //         _valueAll =
//                                                               //             value;
//                                                               //         openDailogEditCardData(
//                                                               //             rowMaintenancePlanTabViewModel
//                                                               //                 .rowMaintenancePlanTabList
//                                                               //                 .data!
//                                                               //                 .allVMARowMaintPlanListForAdminSupervisorWorkStatus![
//                                                               //                     index]
//                                                               //                 .id
//                                                               //                 .toString(),
//                                                               //             '12',
//                                                               //             nextMaintDueZeroIndex,
//                                                               //             rowMaintenancePlanTabViewModel
//                                                               //                 .rowMaintenancePlanTabList
//                                                               //                 .data!
//                                                               //                 .allVMARowMaintPlanListForAdminSupervisorWorkStatus![
//                                                               //                     index]
//                                                               //                 .totalCost
//                                                               //                 .toString(),
//                                                               //                 rowMaintenancePlanTabViewModel
//                                                               //                 .rowMaintenancePlanTabList
//                                                               //                 .data!
//                                                               //                 .allVMARowMaintPlanListForAdminSupervisorWorkStatus![
//                                                               //                     index]
//                                                               //                 .supervisorId
//                                                               //                 .toString());
//                                                               //       });
//                                                               //     }),
//                                                             ),
//                                                           ]),
//                                                     ),
//                                                     Padding(
//                                                       padding:
//                                                           const EdgeInsets.only(
//                                                               top: 10.0,
//                                                               left: 8),
//                                                       child: Row(
//                                                         children: [
//                                                           Expanded(
//                                                             child: Column(
//                                                               crossAxisAlignment:
//                                                                   CrossAxisAlignment
//                                                                       .start,
//                                                               children: [
//                                                                 const Align(
//                                                                   alignment:
//                                                                       Alignment
//                                                                           .centerLeft,
//                                                                   child: Text(
//                                                                     "EDIT: ",
//                                                                     textAlign:
//                                                                         TextAlign
//                                                                             .left,
//                                                                     style:
//                                                                         TextStyle(
//                                                                       fontSize:
//                                                                           12,
//                                                                       fontWeight:
//                                                                           FontWeight
//                                                                               .bold,
//                                                                       color: Color.fromARGB(
//                                                                           255,
//                                                                           7,
//                                                                           59,
//                                                                           120),
//                                                                     ),
//                                                                   ),
//                                                                 ),
//                                                                 InkWell(
//                                                                     onTap: () {
//                                                                       if (rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].maintType == 'RegularMaint' &&
//                                                                           rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].rowYear !=
//                                                                               '' &&
//                                                                           rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].rowYear !=
//                                                                               'N/A') {
//                                                                         Navigator.push(
//                                                                             context,
//                                                                             MaterialPageRoute(
//                                                                                 builder: (context) => PlannerAddNewRowMaintenancePlan(
//                                                                                       tokenNo: rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].tokenNo == null ? '' : rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].tokenNo.toString(),
//                                                                                       index: '0',
//                                                                                       nextMaintYear: rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].nextMaintDueYear == null ? '' : rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].nextMaintDueYear.toString(),
//                                                                                       subStation: rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].substation == null ? '' : rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].substation.toString(),
//                                                                                       feeder: rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].feeder == null ? '' : rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].feeder.toString(),
//                                                                                       maintType: rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].type == null ? '' : rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].type.toString(),
//                                                                                       totalMiles: rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].totalMiles == null ? '' : rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].totalMiles.toString(),
//                                                                                       totalCost: rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].totalCost == null ? '' : rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].totalCost.toString(),
//                                                                                       costPerMile: rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].costPerMile == null ? '' : rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].costPerMile.toString(),
//                                                                                       budgetType: rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].budgetType == null ? '' : rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].budgetType.toString(),
//                                                                                       contractRowYear: rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].contractYear == null ? '' : rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].contractYear.toString(),
//                                                                                       rowCycle: rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].cycle == null ? '' : rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].cycle.toString(),
//                                                                                       rowYear: rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].rowYear == null ? '' : rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].rowYear.toString(),
//                                                                                       contractorCompany: rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].contractorCompay == null ? '' : rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].contractorCompay.toString(),
//                                                                                       assignForeman: rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].contractor == null ? '' : rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].contractor.toString(),
//                                                                                       task: 'edit',
//                                                                                     )));
//                                                                       } else if (rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].maintType == 'RegularMaint' &&
//                                                                           rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].rowYear ==
//                                                                               '' &&
//                                                                           rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].rowYear !=
//                                                                               'N/A') {
//                                                                         Navigator.push(
//                                                                             context,
//                                                                             MaterialPageRoute(
//                                                                                 builder: (context) => PlannerAddNewRowMaintenancePlan(
//                                                                                       tokenNo: rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].tokenNo == null ? '' : rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].tokenNo.toString(),
//                                                                                       index: '1',
//                                                                                       nextMaintYear: rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].nextMaintDueYear == null ? '' : rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].nextMaintDueYear.toString(),
//                                                                                       subStation: rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].substation == null ? '' : rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].substation.toString(),
//                                                                                       feeder: rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].feeder == null ? '' : rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].feeder.toString(),
//                                                                                       maintType: rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].type == null ? '' : rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].type.toString(),
//                                                                                       totalMiles: rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].totalMiles == null ? '' : rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].totalMiles.toString(),
//                                                                                       totalCost: rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].totalCost == null ? '' : rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].totalCost.toString(),
//                                                                                       costPerMile: rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].costPerMile == null ? '' : rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].costPerMile.toString(),
//                                                                                       budgetType: rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].budgetType == null ? '' : rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].budgetType.toString(),
//                                                                                       contractRowYear: rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].contractYear == null ? '' : rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].contractYear.toString(),
//                                                                                       rowCycle: rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].cycle == null ? '' : rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].cycle.toString(),
//                                                                                       rowYear: rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].rowYear == null ? '' : rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].rowYear.toString(),
//                                                                                       contractorCompany: rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].contractorCompay == null ? '' : rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].contractorCompay.toString(),
//                                                                                       assignForeman: rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].contractor == null ? '' : rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].contractor.toString(),
//                                                                                       task: 'edit',
//                                                                                     )));
//                                                                       } else {
//                                                                         Navigator.of(context).push(MaterialPageRoute(
//                                                                             builder: (BuildContext context) => ViewLCPCreateOrder(
//                                                                                   tokenNo: rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].tokenNo == null ? '' : rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].tokenNo.toString(),
//                                                                                   subStation: (rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].substation == null) ? '' : rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].substation.toString(),
//                                                                                   feeder: (rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].feeder == null) ? '' : rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].feeder.toString(),
//                                                                                   serviceStreetAddress: (rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].street == null || rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].street == 'N/A') ? '' : rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].street.toString(),
//                                                                                   serviceMapLocation: (rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].mapLocation == null || rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].mapLocation == 'N/A') ? '' : rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].mapLocation.toString(),
//                                                                                   notes: (rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].adminNotes1 == null || rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].adminNotes1 == 'N/A') ? '' : rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].adminNotes1.toString(),
//                                                                                   type: (rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].maintType == null) ? '' : rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].maintType.toString(),
//                                                                                   maintType: (rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].type == null) ? '' : rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].type.toString(),
//                                                                                   contractorCompany: (rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].contractorCompay == null) ? '' : rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].contractorCompay.toString(),
//                                                                                   assignForeman: rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].contractor == null ? '' : rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].contractor.toString(),
//                                                                                   estimatedCost: rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].estCost == null ? '' : rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].estCost.toString(),
//                                                                                   estimatedTime: rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].estTime == null ? '' : rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].estTime.toString(),
//                                                                                   actualCost: rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].actualCost == null ? '' : rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].actualCost.toString(),
//                                                                                 )));
//                                                                       }
//                                                                     },
//                                                                     child:
//                                                                         const Align(
//                                                                       alignment:
//                                                                           Alignment
//                                                                               .centerLeft,
//                                                                       child:
//                                                                           Icon(
//                                                                         Icons
//                                                                             .edit,
//                                                                         color: Colors
//                                                                             .green,
//                                                                       ),
//                                                                     )),
//                                                               ],
//                                                             ),
//                                                           ),
//                                                           Expanded(
//                                                             child: Column(
//                                                                 children: [
//                                                                   const Align(
//                                                                     alignment:
//                                                                         Alignment
//                                                                             .centerLeft,
//                                                                     child: Text(
//                                                                       "ID: ",
//                                                                       textAlign:
//                                                                           TextAlign
//                                                                               .left,
//                                                                       style:
//                                                                           TextStyle(
//                                                                         color: Color.fromARGB(
//                                                                             255,
//                                                                             7,
//                                                                             59,
//                                                                             120),
//                                                                         fontWeight:
//                                                                             FontWeight.bold,
//                                                                         fontSize:
//                                                                             16,
//                                                                       ),
//                                                                     ),
//                                                                   ),
//                                                                   Align(
//                                                                     alignment:
//                                                                         Alignment
//                                                                             .centerLeft,
//                                                                     child: Text(
//                                                                       (rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].id.toString().isEmpty ||
//                                                                               rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].id ==
//                                                                                   null ||
//                                                                               rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].id.toString() ==
//                                                                                   'null')
//                                                                           ? 'N/A'
//                                                                           : rowMaintenancePlanTabViewModel
//                                                                               .rowMaintenancePlanTabList
//                                                                               .data!
//                                                                               .allVMARowMaintPlanListForAdminSupervisorWorkStatus![index]
//                                                                               .id
//                                                                               .toString(),
//                                                                       textAlign:
//                                                                           TextAlign
//                                                                               .left,
//                                                                       style:
//                                                                           const TextStyle(
//                                                                         color: Color.fromARGB(
//                                                                             255,
//                                                                             7,
//                                                                             59,
//                                                                             120),
//                                                                         // fontWeight: FontWeight.bold,
//                                                                         fontSize:
//                                                                             16,
//                                                                       ),
//                                                                     ),
//                                                                   ),
//                                                                 ]),
//                                                           ),
//                                                         ],
//                                                       ),
//                                                     ),
//                                                     Padding(
//                                                       padding:
//                                                           const EdgeInsets.only(
//                                                               top: 10.0,
//                                                               left: 8),
//                                                       child: Row(
//                                                         children: [
//                                                           Expanded(
//                                                             child: Column(
//                                                                 crossAxisAlignment:
//                                                                     CrossAxisAlignment
//                                                                         .start,
//                                                                 children: [
//                                                                   const Text(
//                                                                     "Substation: ",
//                                                                     textAlign:
//                                                                         TextAlign
//                                                                             .left,
//                                                                     style:
//                                                                         TextStyle(
//                                                                       color: Color.fromARGB(
//                                                                           255,
//                                                                           7,
//                                                                           59,
//                                                                           120),
//                                                                       fontWeight:
//                                                                           FontWeight
//                                                                               .bold,
//                                                                       fontSize:
//                                                                           16,
//                                                                     ),
//                                                                   ),
//                                                                   Text(
//                                                                     (rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].substation.toString().isEmpty ||
//                                                                             rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].substation ==
//                                                                                 null ||
//                                                                             rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].substation.toString() ==
//                                                                                 'null')
//                                                                         ? 'N/A'
//                                                                         : rowMaintenancePlanTabViewModel
//                                                                             .rowMaintenancePlanTabList
//                                                                             .data!
//                                                                             .allVMARowMaintPlanListForAdminSupervisorWorkStatus![index]
//                                                                             .substation
//                                                                             .toString(),
//                                                                     textAlign:
//                                                                         TextAlign
//                                                                             .left,
//                                                                     style:
//                                                                         const TextStyle(
//                                                                       color: Color.fromARGB(
//                                                                           255,
//                                                                           7,
//                                                                           59,
//                                                                           120),
//                                                                       // fontWeight: FontWeight.bold,
//                                                                       fontSize:
//                                                                           16,
//                                                                     ),
//                                                                   ),
//                                                                 ]),
//                                                           ),
//                                                           Expanded(
//                                                             child: Column(
//                                                                 children: [
//                                                                   const Align(
//                                                                     alignment:
//                                                                         Alignment
//                                                                             .centerLeft,
//                                                                     child: Text(
//                                                                       "Feeder: ",
//                                                                       textAlign:
//                                                                           TextAlign
//                                                                               .left,
//                                                                       style:
//                                                                           TextStyle(
//                                                                         color: Color.fromARGB(
//                                                                             255,
//                                                                             7,
//                                                                             59,
//                                                                             120),
//                                                                         fontWeight:
//                                                                             FontWeight.bold,
//                                                                         fontSize:
//                                                                             16,
//                                                                       ),
//                                                                     ),
//                                                                   ),
//                                                                   Align(
//                                                                     alignment:
//                                                                         Alignment
//                                                                             .centerLeft,
//                                                                     child: Text(
//                                                                       (rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].feeder.toString().isEmpty ||
//                                                                               rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].feeder ==
//                                                                                   null ||
//                                                                               rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].feeder.toString() ==
//                                                                                   'null')
//                                                                           ? ''
//                                                                           : rowMaintenancePlanTabViewModel
//                                                                               .rowMaintenancePlanTabList
//                                                                               .data!
//                                                                               .allVMARowMaintPlanListForAdminSupervisorWorkStatus![index]
//                                                                               .feeder
//                                                                               .toString(),
//                                                                       textAlign:
//                                                                           TextAlign
//                                                                               .left,
//                                                                       style:
//                                                                           const TextStyle(
//                                                                         color: Color.fromARGB(
//                                                                             255,
//                                                                             7,
//                                                                             59,
//                                                                             120),
//                                                                         // fontWeight: FontWeight.bold,
//                                                                         fontSize:
//                                                                             16,
//                                                                       ),
//                                                                     ),
//                                                                   ),
//                                                                 ]),
//                                                           ),
//                                                         ],
//                                                       ),
//                                                     ),
//                                                     Padding(
//                                                       padding:
//                                                           const EdgeInsets.only(
//                                                               top: 10.0,
//                                                               left: 8),
//                                                       child: Row(
//                                                         children: [
//                                                           // Expanded(
//                                                           //   child: Column(
//                                                           //       crossAxisAlignment:
//                                                           //           CrossAxisAlignment
//                                                           //               .start,
//                                                           //       children: [
//                                                           //         const Text(
//                                                           //           "Contract Row Year: ",
//                                                           //           textAlign:
//                                                           //               TextAlign
//                                                           //                   .left,
//                                                           //           style:
//                                                           //               TextStyle(
//                                                           //             color: Color
//                                                           //                 .fromARGB(
//                                                           //                     255,
//                                                           //                     7,
//                                                           //                     59,
//                                                           //                     120),
//                                                           //             fontWeight:
//                                                           //                 FontWeight
//                                                           //                     .bold,
//                                                           //             fontSize:
//                                                           //                 16,
//                                                           //           ),
//                                                           //         ),
//                                                           //         Text(
//                                                           //           (rowMaintenancePlanTabViewModel
//                                                           //                       .rowMaintenancePlanTabList
//                                                           //                       .data!
//                                                           //                       .allVMARowMaintPlanListForAdminSupervisorWorkStatus![
//                                                           //                           index]
//                                                           //                       .contractYear
//                                                           //                       .toString()
//                                                           //                       .isEmpty ||
//                                                           //                   rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].contractYear ==
//                                                           //                       null ||
//                                                           //                   rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].contractYear.toString() ==
//                                                           //                       'null')
//                                                           //               ? 'N/A'
//                                                           //               : rowMaintenancePlanTabViewModel
//                                                           //                   .rowMaintenancePlanTabList
//                                                           //                   .data!
//                                                           //                   .allVMARowMaintPlanListForAdminSupervisorWorkStatus![
//                                                           //                       index]
//                                                           //                   .contractYear
//                                                           //                   .toString(),
//                                                           //           textAlign:
//                                                           //               TextAlign
//                                                           //                   .left,
//                                                           //           style:
//                                                           //               const TextStyle(
//                                                           //             color: Color
//                                                           //                 .fromARGB(
//                                                           //                     255,
//                                                           //                     7,
//                                                           //                     59,
//                                                           //                     120),
//                                                           //             // fontWeight: FontWeight.bold,
//                                                           //             fontSize:
//                                                           //                 16,
//                                                           //           ),
//                                                           //         ),
//                                                           //       ]),
//                                                           // ),

//                                                           Expanded(
//                                                             child: Column(
//                                                                 children: [
//                                                                   const Align(
//                                                                     alignment:
//                                                                         Alignment
//                                                                             .centerLeft,
//                                                                     child: Text(
//                                                                       "Maintenance Type: ",
//                                                                       textAlign:
//                                                                           TextAlign
//                                                                               .left,
//                                                                       style:
//                                                                           TextStyle(
//                                                                         color: Color.fromARGB(
//                                                                             255,
//                                                                             7,
//                                                                             59,
//                                                                             120),
//                                                                         fontWeight:
//                                                                             FontWeight.bold,
//                                                                         fontSize:
//                                                                             16,
//                                                                       ),
//                                                                     ),
//                                                                   ),
//                                                                   Align(
//                                                                     alignment:
//                                                                         Alignment
//                                                                             .centerLeft,
//                                                                     child: Text(
//                                                                       (rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].type.toString().isEmpty ||
//                                                                               rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].type ==
//                                                                                   null ||
//                                                                               rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].type.toString() ==
//                                                                                   'null')
//                                                                           ? 'N/A'
//                                                                           : rowMaintenancePlanTabViewModel
//                                                                               .rowMaintenancePlanTabList
//                                                                               .data!
//                                                                               .allVMARowMaintPlanListForAdminSupervisorWorkStatus![index]
//                                                                               .type
//                                                                               .toString(),
//                                                                       textAlign:
//                                                                           TextAlign
//                                                                               .left,
//                                                                       style:
//                                                                           const TextStyle(
//                                                                         color: Color.fromARGB(
//                                                                             255,
//                                                                             7,
//                                                                             59,
//                                                                             120),
//                                                                         // fontWeight: FontWeight.bold,
//                                                                         fontSize:
//                                                                             16,
//                                                                       ),
//                                                                     ),
//                                                                   ),
//                                                                 ]),
//                                                           ),
//                                                           Expanded(
//                                                             child: Column(
//                                                                 crossAxisAlignment:
//                                                                     CrossAxisAlignment
//                                                                         .start,
//                                                                 children: [
//                                                                   const Text(
//                                                                     "Total Miles: ",
//                                                                     textAlign:
//                                                                         TextAlign
//                                                                             .left,
//                                                                     style:
//                                                                         TextStyle(
//                                                                       color: Color.fromARGB(
//                                                                           255,
//                                                                           7,
//                                                                           59,
//                                                                           120),
//                                                                       fontWeight:
//                                                                           FontWeight
//                                                                               .bold,
//                                                                       fontSize:
//                                                                           16,
//                                                                     ),
//                                                                   ),
//                                                                   Text(
//                                                                     (rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].totalMiles.toString().isEmpty ||
//                                                                             rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].totalMiles ==
//                                                                                 null ||
//                                                                             rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].totalMiles.toString() ==
//                                                                                 'null')
//                                                                         ? 'N/A'
//                                                                         : rowMaintenancePlanTabViewModel
//                                                                             .rowMaintenancePlanTabList
//                                                                             .data!
//                                                                             .allVMARowMaintPlanListForAdminSupervisorWorkStatus![index]
//                                                                             .totalMiles
//                                                                             .toString(),
//                                                                     textAlign:
//                                                                         TextAlign
//                                                                             .left,
//                                                                     style:
//                                                                         const TextStyle(
//                                                                       color: Color.fromARGB(
//                                                                           255,
//                                                                           7,
//                                                                           59,
//                                                                           120),
//                                                                       // fontWeight: FontWeight.bold,
//                                                                       fontSize:
//                                                                           16,
//                                                                     ),
//                                                                   ),
//                                                                 ]),
//                                                           ),
//                                                         ],
//                                                       ),
//                                                     ),
//                                                     Padding(
//                                                       padding:
//                                                           const EdgeInsets.only(
//                                                               top: 10.0,
//                                                               left: 8),
//                                                       child: Row(
//                                                         children: [
//                                                           // Expanded(
//                                                           //   child: Column(
//                                                           //       crossAxisAlignment:
//                                                           //           CrossAxisAlignment
//                                                           //               .start,
//                                                           //       children: [
//                                                           //         const Text(
//                                                           //           "Total Miles: ",
//                                                           //           textAlign:
//                                                           //               TextAlign
//                                                           //                   .left,
//                                                           //           style:
//                                                           //               TextStyle(
//                                                           //             color: Color
//                                                           //                 .fromARGB(
//                                                           //                     255,
//                                                           //                     7,
//                                                           //                     59,
//                                                           //                     120),
//                                                           //             fontWeight:
//                                                           //                 FontWeight
//                                                           //                     .bold,
//                                                           //             fontSize:
//                                                           //                 16,
//                                                           //           ),
//                                                           //         ),
//                                                           //         Text(
//                                                           //           (rowMaintenancePlanTabViewModel
//                                                           //                       .rowMaintenancePlanTabList
//                                                           //                       .data!
//                                                           //                       .allVMARowMaintPlanListForAdminSupervisorWorkStatus![
//                                                           //                           index]
//                                                           //                       .totalMiles
//                                                           //                       .toString()
//                                                           //                       .isEmpty ||
//                                                           //                   rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].totalMiles ==
//                                                           //                       null ||
//                                                           //                   rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].totalMiles.toString() ==
//                                                           //                       'null')
//                                                           //               ? 'N/A'
//                                                           //               : rowMaintenancePlanTabViewModel
//                                                           //                   .rowMaintenancePlanTabList
//                                                           //                   .data!
//                                                           //                   .allVMARowMaintPlanListForAdminSupervisorWorkStatus![
//                                                           //                       index]
//                                                           //                   .totalMiles
//                                                           //                   .toString(),
//                                                           //           textAlign:
//                                                           //               TextAlign
//                                                           //                   .left,
//                                                           //           style:
//                                                           //               const TextStyle(
//                                                           //             color: Color
//                                                           //                 .fromARGB(
//                                                           //                     255,
//                                                           //                     7,
//                                                           //                     59,
//                                                           //                     120),
//                                                           //             // fontWeight: FontWeight.bold,
//                                                           //             fontSize:
//                                                           //                 16,
//                                                           //           ),
//                                                           //         ),
//                                                           //       ]),
//                                                           // ),

//                                                           // Expanded(
//                                                           //   child: Column(
//                                                           //       children: [
//                                                           //         const Align(
//                                                           //           alignment:
//                                                           //               Alignment
//                                                           //                   .centerLeft,
//                                                           //           child: Text(
//                                                           //             "Cost Per Miles: ",
//                                                           //             // textAlign: TextAlign.left,
//                                                           //             style:
//                                                           //                 TextStyle(
//                                                           //               color: Color.fromARGB(
//                                                           //                   255,
//                                                           //                   7,
//                                                           //                   59,
//                                                           //                   120),
//                                                           //               fontWeight:
//                                                           //                   FontWeight
//                                                           //                       .bold,
//                                                           //               fontSize:
//                                                           //                   16,
//                                                           //             ),
//                                                           //           ),
//                                                           //         ),
//                                                           //         Align(
//                                                           //           alignment:
//                                                           //               Alignment
//                                                           //                   .centerLeft,
//                                                           //           child: Text(
//                                                           //             (rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].costPerMile.toString().isEmpty ||
//                                                           //                     rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].costPerMile ==
//                                                           //                         null ||
//                                                           //                     rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].costPerMile.toString() ==
//                                                           //                         'null')
//                                                           //                 ? 'N/A'
//                                                           //                 : rowMaintenancePlanTabViewModel
//                                                           //                     .rowMaintenancePlanTabList
//                                                           //                     .data!
//                                                           //                     .allVMARowMaintPlanListForAdminSupervisorWorkStatus![index]
//                                                           //                     .costPerMile
//                                                           //                     .toString(),
//                                                           //             textAlign:
//                                                           //                 TextAlign
//                                                           //                     .left,
//                                                           //             style:
//                                                           //                 const TextStyle(
//                                                           //               color: Color.fromARGB(
//                                                           //                   255,
//                                                           //                   7,
//                                                           //                   59,
//                                                           //                   120),
//                                                           //               // fontWeight: FontWeight.bold,
//                                                           //               fontSize:
//                                                           //                   16,
//                                                           //             ),
//                                                           //           ),
//                                                           //         ),
//                                                           //       ]),
//                                                           // ),
//                                                         ],
//                                                       ),
//                                                     ),
//                                                     // Padding(
//                                                     //   padding:
//                                                     //       const EdgeInsets.only(
//                                                     //           top: 10.0, left: 8),
//                                                     //   child: Row(
//                                                     //     children: [
//                                                     //       Expanded(
//                                                     //         child: Column(
//                                                     //             children: [
//                                                     //               const Align(
//                                                     //                 alignment:
//                                                     //                     Alignment
//                                                     //                         .centerLeft,
//                                                     //                 child: Text(
//                                                     //                   "Budget: ",
//                                                     //                   textAlign:
//                                                     //                       TextAlign
//                                                     //                           .left,
//                                                     //                   style:
//                                                     //                       TextStyle(
//                                                     //                     color: Color.fromARGB(
//                                                     //                         255,
//                                                     //                         7,
//                                                     //                         59,
//                                                     //                         120),
//                                                     //                     fontWeight:
//                                                     //                         FontWeight
//                                                     //                             .bold,
//                                                     //                     fontSize:
//                                                     //                         16,
//                                                     //                   ),
//                                                     //                 ),
//                                                     //               ),
//                                                     //               Align(
//                                                     //                 alignment:
//                                                     //                     Alignment
//                                                     //                         .centerLeft,
//                                                     //                 child: Text(
//                                                     //                   (rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].budget.toString().isEmpty ||
//                                                     //                           rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].budget ==
//                                                     //                               null ||
//                                                     //                           rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].budget.toString() ==
//                                                     //                               'null')
//                                                     //                       ? 'N/A'
//                                                     //                       : rowMaintenancePlanTabViewModel
//                                                     //                           .rowMaintenancePlanTabList
//                                                     //                           .data!
//                                                     //                           .allVMARowMaintPlanListForAdminSupervisorWorkStatus![index]
//                                                     //                           .budget
//                                                     //                           .toString(),
//                                                     //                   textAlign:
//                                                     //                       TextAlign
//                                                     //                           .left,
//                                                     //                   style:
//                                                     //                       const TextStyle(
//                                                     //                     color: Color.fromARGB(
//                                                     //                         255,
//                                                     //                         7,
//                                                     //                         59,
//                                                     //                         120),
//                                                     //                     // fontWeight: FontWeight.bold,
//                                                     //                     fontSize:
//                                                     //                         16,
//                                                     //                   ),
//                                                     //                 ),
//                                                     //               ),
//                                                     //             ]),
//                                                     //       ),
//                                                     //      ],
//                                                     //   ),
//                                                     // ),
//                                                     Padding(
//                                                       padding:
//                                                           const EdgeInsets.only(
//                                                               top: 10.0,
//                                                               left: 8),
//                                                       child: Row(
//                                                         children: [
//                                                           // Expanded(
//                                                           //   child: Column(
//                                                           //       crossAxisAlignment:
//                                                           //           CrossAxisAlignment
//                                                           //               .start,
//                                                           //       children: [
//                                                           //         const Text(
//                                                           //           "Total Cost: ",
//                                                           //           textAlign:
//                                                           //               TextAlign
//                                                           //                   .left,
//                                                           //           style:
//                                                           //               TextStyle(
//                                                           //             color: Color
//                                                           //                 .fromARGB(
//                                                           //                     255,
//                                                           //                     7,
//                                                           //                     59,
//                                                           //                     120),
//                                                           //             fontWeight:
//                                                           //                 FontWeight
//                                                           //                     .bold,
//                                                           //             fontSize:
//                                                           //                 16,
//                                                           //           ),
//                                                           //         ),
//                                                           //         Text(
//                                                           //           (rowMaintenancePlanTabViewModel
//                                                           //                       .rowMaintenancePlanTabList
//                                                           //                       .data!
//                                                           //                       .allVMARowMaintPlanListForAdminSupervisorWorkStatus![
//                                                           //                           index]
//                                                           //                       .totalCost
//                                                           //                       .toString()
//                                                           //                       .isEmpty ||
//                                                           //                   rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].totalCost ==
//                                                           //                       null ||
//                                                           //                   rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].totalCost.toString() ==
//                                                           //                       'null')
//                                                           //               ? 'N/A'
//                                                           //               : rowMaintenancePlanTabViewModel
//                                                           //                   .rowMaintenancePlanTabList
//                                                           //                   .data!
//                                                           //                   .allVMARowMaintPlanListForAdminSupervisorWorkStatus![
//                                                           //                       index]
//                                                           //                   .totalCost
//                                                           //                   .toString(),
//                                                           //           textAlign:
//                                                           //               TextAlign
//                                                           //                   .left,
//                                                           //           style:
//                                                           //               const TextStyle(
//                                                           //             color: Color
//                                                           //                 .fromARGB(
//                                                           //                     255,
//                                                           //                     7,
//                                                           //                     59,
//                                                           //                     120),
//                                                           //             // fontWeight: FontWeight.bold,
//                                                           //             fontSize:
//                                                           //                 16,
//                                                           //           ),
//                                                           //         ),
//                                                           //       ]),
//                                                           // ),

//                                                           Expanded(
//                                                             child: Column(
//                                                                 children: [
//                                                                   const Align(
//                                                                     alignment:
//                                                                         Alignment
//                                                                             .centerLeft,
//                                                                     child: Text(
//                                                                       "Cycle: ",
//                                                                       textAlign:
//                                                                           TextAlign
//                                                                               .left,
//                                                                       style:
//                                                                           TextStyle(
//                                                                         color: Color.fromARGB(
//                                                                             255,
//                                                                             7,
//                                                                             59,
//                                                                             120),
//                                                                         fontWeight:
//                                                                             FontWeight.bold,
//                                                                         fontSize:
//                                                                             16,
//                                                                       ),
//                                                                     ),
//                                                                   ),
//                                                                   Align(
//                                                                     alignment:
//                                                                         Alignment
//                                                                             .centerLeft,
//                                                                     child: Text(
//                                                                       (rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].cycle.toString().isEmpty ||
//                                                                               rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].cycle ==
//                                                                                   null ||
//                                                                               rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].cycle.toString() ==
//                                                                                   'null')
//                                                                           ? 'N/A'
//                                                                           : rowMaintenancePlanTabViewModel
//                                                                               .rowMaintenancePlanTabList
//                                                                               .data!
//                                                                               .allVMARowMaintPlanListForAdminSupervisorWorkStatus![index]
//                                                                               .cycle
//                                                                               .toString(),
//                                                                       textAlign:
//                                                                           TextAlign
//                                                                               .left,
//                                                                       style:
//                                                                           const TextStyle(
//                                                                         color: Color.fromARGB(
//                                                                             255,
//                                                                             7,
//                                                                             59,
//                                                                             120),
//                                                                         // fontWeight: FontWeight.bold,
//                                                                         fontSize:
//                                                                             16,
//                                                                       ),
//                                                                     ),
//                                                                   ),
//                                                                 ]),
//                                                           ),
//                                                           Expanded(
//                                                             child: Column(
//                                                                 crossAxisAlignment:
//                                                                     CrossAxisAlignment
//                                                                         .start,
//                                                                 children: [
//                                                                   const Text(
//                                                                     "Next Maint Year: ",
//                                                                     textAlign:
//                                                                         TextAlign
//                                                                             .left,
//                                                                     style:
//                                                                         TextStyle(
//                                                                       color: Color.fromARGB(
//                                                                           255,
//                                                                           7,
//                                                                           59,
//                                                                           120),
//                                                                       fontWeight:
//                                                                           FontWeight
//                                                                               .bold,
//                                                                       fontSize:
//                                                                           16,
//                                                                     ),
//                                                                   ),
//                                                                   Text(
//                                                                     nextMaintDueZeroIndex,
//                                                                     textAlign:
//                                                                         TextAlign
//                                                                             .left,
//                                                                     style:
//                                                                         const TextStyle(
//                                                                       color: Color.fromARGB(
//                                                                           255,
//                                                                           7,
//                                                                           59,
//                                                                           120),
//                                                                       // fontWeight: FontWeight.bold,
//                                                                       fontSize:
//                                                                           16,
//                                                                     ),
//                                                                   ),
//                                                                 ]),
//                                                           ),
//                                                         ],
//                                                       ),
//                                                     ),
//                                                     Padding(
//                                                       padding:
//                                                           const EdgeInsets.only(
//                                                               top: 10.0,
//                                                               left: 8),
//                                                       child: Row(
//                                                         children: [
//                                                           // Expanded(
//                                                           //   child: Column(
//                                                           //       crossAxisAlignment:
//                                                           //           CrossAxisAlignment
//                                                           //               .start,
//                                                           //       children: [
//                                                           //         const Text(
//                                                           //           "Next Maint Year: ",
//                                                           //           textAlign:
//                                                           //               TextAlign
//                                                           //                   .left,
//                                                           //           style:
//                                                           //               TextStyle(
//                                                           //             color: Color
//                                                           //                 .fromARGB(
//                                                           //                     255,
//                                                           //                     7,
//                                                           //                     59,
//                                                           //                     120),
//                                                           //             fontWeight:
//                                                           //                 FontWeight
//                                                           //                     .bold,
//                                                           //             fontSize:
//                                                           //                 16,
//                                                           //           ),
//                                                           //         ),
//                                                           //         Text(
//                                                           //           nextMaintDueZeroIndex,
//                                                           //           textAlign:
//                                                           //               TextAlign
//                                                           //                   .left,
//                                                           //           style:
//                                                           //               const TextStyle(
//                                                           //             color: Color
//                                                           //                 .fromARGB(
//                                                           //                     255,
//                                                           //                     7,
//                                                           //                     59,
//                                                           //                     120),
//                                                           //             // fontWeight: FontWeight.bold,
//                                                           //             fontSize:
//                                                           //                 16,
//                                                           //           ),
//                                                           //         ),
//                                                           //       ]),
//                                                           // ),

//                                                           Expanded(
//                                                             child: Column(
//                                                                 children: [
//                                                                   const Align(
//                                                                     alignment:
//                                                                         Alignment
//                                                                             .centerLeft,
//                                                                     child: Text(
//                                                                       "Foreman: ",
//                                                                       textAlign:
//                                                                           TextAlign
//                                                                               .left,
//                                                                       style:
//                                                                           TextStyle(
//                                                                         color: Color.fromARGB(
//                                                                             255,
//                                                                             7,
//                                                                             59,
//                                                                             120),
//                                                                         fontWeight:
//                                                                             FontWeight.bold,
//                                                                         fontSize:
//                                                                             16,
//                                                                       ),
//                                                                     ),
//                                                                   ),
//                                                                   Align(
//                                                                     alignment:
//                                                                         Alignment
//                                                                             .centerLeft,
//                                                                     child: Text(
//                                                                       (rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].contractorName.toString().isEmpty ||
//                                                                               rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].contractorName ==
//                                                                                   null ||
//                                                                               rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].contractorName.toString() ==
//                                                                                   'null')
//                                                                           ? ''
//                                                                           : rowMaintenancePlanTabViewModel
//                                                                               .rowMaintenancePlanTabList
//                                                                               .data!
//                                                                               .allVMARowMaintPlanListForAdminSupervisorWorkStatus![index]
//                                                                               .contractorName
//                                                                               .toString(),
//                                                                       textAlign:
//                                                                           TextAlign
//                                                                               .left,
//                                                                       style:
//                                                                           const TextStyle(
//                                                                         color: Color.fromARGB(
//                                                                             255,
//                                                                             7,
//                                                                             59,
//                                                                             120),
//                                                                         // fontWeight: FontWeight.bold,
//                                                                         fontSize:
//                                                                             16,
//                                                                       ),
//                                                                     ),
//                                                                   ),
//                                                                 ]),
//                                                           ),
//                                                         ],
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               );
//                                             },
//                                           ),
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             );

//                           default:
//                             return const Text('data');
//                         }
//                       }))));
//         });
//   }

//   DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
//       value: item,
//       child: Text(item,
//           style: const TextStyle(
//             fontWeight: FontWeight.normal,
//             fontSize: 20,
//           )));

//   Future openFilter() => showDialog(
//       context: context,
//       builder: (context) {
//         return StatefulBuilder(builder: (context, setState) {
//           state = setState;
//           Size size = MediaQuery.of(context).size;
//           return AlertDialog(
//             content: SingleChildScrollView(
//                 child: Column(
//               children: [
//                 Container(
//                   margin: const EdgeInsets.only(top: 10),
//                   child: Column(children: [
//                     Padding(
//                       padding: const EdgeInsets.only(
//                           top: 10, bottom: 2, left: 2, right: 2),
//                       child: Column(
//                         children: [
//                           const Align(
//                               alignment: Alignment.centerLeft,
//                               child: Padding(
//                                 padding: EdgeInsets.all(2.0),
//                                 child: Text(
//                                   "Year",
//                                   style: TextStyle(
//                                     fontSize: 16.0,
//                                     color: Color.fromARGB(255, 7, 59, 120),
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               )),
//                           Align(
//                             alignment: Alignment.centerLeft,
//                             child: Padding(
//                               padding: const EdgeInsets.all(2.0),
//                               child: Container(
//                                 padding: const EdgeInsets.symmetric(
//                                     horizontal: 12, vertical: 4),
//                                 width: size.width * 0.9,
//                                 decoration: BoxDecoration(
//                                   border: Border.all(
//                                     color:
//                                         const Color.fromARGB(255, 7, 59, 120),
//                                   ),
//                                 ),
//                                 child: MultiSelectDialogField(
//                                     items: rowMaintenancePlanTabViewModel
//                                         .rowMaintenancePlanTabList
//                                         .data!
//                                         .nextMaintDueYear!
//                                         .map((e) => MultiSelectItem(
//                                             e.nextMaintDue.toString(),
//                                             e.nextMaintDue.toString()))
//                                         .toList(),
//                                     initialValue: (year == null ||
//                                             year.toString().isEmpty)
//                                         ? []
//                                         : year!.split(','),
//                                     listType: MultiSelectListType.CHIP,
//                                     onConfirm: (value) {
//                                       year = value.join(',');
//                                       fetchData(year!, '0', '0', '0');
//                                       (value) => value == null
//                                           ? 'field required'
//                                           : null;
//                                     }),
//                               ),
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.only(
//                                 top: 10, bottom: 2, left: 2, right: 2),
//                             child: Column(
//                               children: [
//                                 const Align(
//                                     alignment: Alignment.centerLeft,
//                                     child: Padding(
//                                       padding: EdgeInsets.all(2.0),
//                                       child: Text(
//                                         "Cycle",
//                                         style: TextStyle(
//                                           fontSize: 16.0,
//                                           color:
//                                               Color.fromARGB(255, 7, 59, 120),
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       ),
//                                     )),
//                                 Align(
//                                   alignment: Alignment.centerLeft,
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(2.0),
//                                     child: Container(
//                                       padding: const EdgeInsets.symmetric(
//                                           horizontal: 12, vertical: 4),
//                                       width: size.width * 0.9,
//                                       decoration: BoxDecoration(
//                                         border: Border.all(
//                                           color: const Color.fromARGB(
//                                               255, 7, 59, 120),
//                                         ),
//                                       ),
//                                       child: DropdownButtonHideUnderline(
//                                         child: MultiSelectDialogField(
//                                             items:
//                                                 rowMaintenancePlanTabViewModel
//                                                     .rowMaintenancePlanTabList
//                                                     .data!
//                                                     .cycleLists!
//                                                     .map((e) => MultiSelectItem(
//                                                         e.cycle.toString(),
//                                                         e.cycle.toString()))
//                                                     .toList(),
//                                             initialValue: (cycle == null ||
//                                                     cycle.toString().isEmpty)
//                                                 ? []
//                                                 : cycle!.split(','),
//                                             listType: MultiSelectListType.CHIP,
//                                             onConfirm: (value) {
//                                               cycle = value.join(',');
//                                               fetchData(
//                                                   year!, cycle!, '0', '0');
//                                               (value) => value == null
//                                                   ? 'field required'
//                                                   : null;
//                                             }),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.only(
//                                 top: 10, bottom: 2, left: 2, right: 2),
//                             child: Column(
//                               children: [
//                                 const Align(
//                                     alignment: Alignment.centerLeft,
//                                     child: Padding(
//                                       padding: EdgeInsets.all(2.0),
//                                       child: Text(
//                                         "Substation",
//                                         style: TextStyle(
//                                           fontSize: 16.0,
//                                           color:
//                                               Color.fromARGB(255, 7, 59, 120),
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       ),
//                                     )),
//                                 Align(
//                                   alignment: Alignment.centerLeft,
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(2.0),
//                                     child: Container(
//                                       padding: const EdgeInsets.symmetric(
//                                           horizontal: 12, vertical: 4),
//                                       width: size.width * 0.9,
//                                       decoration: BoxDecoration(
//                                         border: Border.all(
//                                           color: const Color.fromARGB(
//                                               255, 7, 59, 120),
//                                         ),
//                                       ),
//                                       child: MultiSelectDialogField(
//                                           items: rowMaintenancePlanTabViewModel
//                                               .rowMaintenancePlanTabList
//                                               .data!
//                                               .subStations!
//                                               .map((e) => MultiSelectItem(
//                                                   e.subId.toString(),
//                                                   e.subStation.toString()))
//                                               .toList(),
//                                           initialValue: (substation == null ||
//                                                   substation.toString().isEmpty)
//                                               ? []
//                                               : substation!.split(','),
//                                           listType: MultiSelectListType.CHIP,
//                                           onConfirm: (value) {
//                                             substation = value.join(',');
//                                             fetchData(year!, cycle!,
//                                                 substation!, '0');
//                                             (value) => value == null
//                                                 ? 'field required'
//                                                 : null;
//                                           }),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.only(
//                                 top: 10, bottom: 2, left: 2, right: 2),
//                             child: Column(
//                               children: [
//                                 const Align(
//                                     alignment: Alignment.centerLeft,
//                                     child: Padding(
//                                       padding: EdgeInsets.all(2.0),
//                                       child: Text(
//                                         "Feeder",
//                                         style: TextStyle(
//                                           fontSize: 16.0,
//                                           color:
//                                               Color.fromARGB(255, 7, 59, 120),
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       ),
//                                     )),
//                                 Align(
//                                   alignment: Alignment.centerLeft,
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(2.0),
//                                     child: Container(
//                                       padding: const EdgeInsets.symmetric(
//                                           horizontal: 12, vertical: 4),
//                                       width: size.width * 0.9,
//                                       decoration: BoxDecoration(
//                                         border: Border.all(
//                                           color: const Color.fromARGB(
//                                               255, 7, 59, 120),
//                                         ),
//                                       ),
//                                       child: MultiSelectDialogField(
//                                           items: rowMaintenancePlanTabViewModel
//                                               .rowMaintenancePlanTabList
//                                               .data!
//                                               .feeders!
//                                               .map((e) => MultiSelectItem(
//                                                   e.fdrId.toString(),
//                                                   e.feeder.toString()))
//                                               .toList(),
//                                           initialValue: (feeder == null ||
//                                                   feeder.toString().isEmpty)
//                                               ? []
//                                               : feeder!.split(','),
//                                           listType: MultiSelectListType.CHIP,
//                                           onConfirm: (value) {
//                                             feeder = value.join(',');
//                                             fetchData(year!, cycle!,
//                                                 substation!, feeder!);
//                                             (value) => value == null
//                                                 ? 'field required'
//                                                 : null;
//                                           }),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ]),
//                 ),
//               ],
//             )),
//             actions: [
//               Container(
//                   margin: const EdgeInsets.only(
//                       left: 6, right: 6, top: 6.0, bottom: 10),
//                   child: InkWell(
//                     onTap: () {
//                       Navigator.pop(context);
//                     },
//                     child: Container(
//                       margin: const EdgeInsets.only(
//                           left: 40, right: 40, bottom: 10.0),
//                       // padding: const EdgeInsets.all(8),
//                       alignment: Alignment.center,
//                       width: MediaQuery.of(context).size.width,
//                       height: 40,
//                       decoration: const BoxDecoration(
//                           // shape: BoxShape.circle,

//                           boxShadow: [
//                             BoxShadow(
//                                 color: Color.fromARGB(255, 132, 11, 2),
//                                 blurRadius: 5,
//                                 offset: Offset(2.0, 5.0))
//                           ],
//                           color: Colors.black,
//                           gradient: LinearGradient(
//                             colors: [
//                               Color.fromARGB(255, 250, 6, 42),
//                               Color.fromARGB(255, 216, 19, 5),
//                               Color.fromARGB(255, 250, 6, 42),
//                             ],
//                           )),
//                       child: const Row(children: [
//                         Expanded(
//                           child: Align(
//                             alignment: Alignment.center,
//                             child: Text(
//                               "Close",
//                               textAlign: TextAlign.left,
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 20,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ]),
//                     ),
//                   )),
//             ],
//           );
//         });
//       });
//   Future openDailogEditCardData(
//           String mainId,
//           String insStatus,
//           String nextMaintDue,
//           // String totalCost,
//           String supervisor,
//           int index) =>
//       showDialog(
//           context: context,
//           builder: (context) {
//             return StatefulBuilder(builder: (context, setState) {
//               return AlertDialog(
//                 content: SingleChildScrollView(
//                     child: Column(
//                   children: [
//                     Container(
//                       margin: const EdgeInsets.only(top: 10),
//                       child: Column(children: [
//                         Row(
//                           children: [
//                             // Expanded(
//                             //   child: Column(children: [
//                             //     const Align(
//                             //       alignment: Alignment.centerLeft,
//                             //       child: Text(
//                             //         "Cost Per Miles: ",
//                             //         textAlign: TextAlign.left,
//                             //         style: TextStyle(
//                             //           color: Color.fromARGB(255, 7, 59, 120),
//                             //           fontWeight: FontWeight.bold,
//                             //           fontSize: 16,
//                             //         ),
//                             //       ),
//                             //     ),
//                             //     TextFormField(
//                             //       onChanged: (value) {
//                             //         setState(
//                             //           () {
//                             //             calculateTotalCost();
//                             //           },
//                             //         );
//                             //       },
//                             //       controller: _costPerMiles,
//                             //       style: const TextStyle(
//                             //           color: Color.fromARGB(255, 7, 59, 120),
//                             //           fontSize: 20),
//                             //       obscureText: false,
//                             //       // keyboardType: TextInputType.number,
//                             //       keyboardType:
//                             //           const TextInputType.numberWithOptions(
//                             //         decimal: true,
//                             //         signed: false,
//                             //       ),
//                             //       decoration: const InputDecoration(
//                             //         border: OutlineInputBorder(),
//                             //         enabledBorder: OutlineInputBorder(
//                             //             borderSide: BorderSide(
//                             //           color: Color.fromARGB(255, 7, 59, 120),
//                             //         )),
//                             //       ),
//                             //     ),
//                             //   ]),
//                             // ),

//                             Expanded(
//                               child: Column(children: [
//                                 const Align(
//                                   alignment: Alignment.centerLeft,
//                                   child: Text(
//                                     "Total Miles: ",
//                                     textAlign: TextAlign.left,
//                                     style: TextStyle(
//                                       color: Color.fromARGB(255, 7, 59, 120),
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 16,
//                                     ),
//                                   ),
//                                 ),
//                                 TextFormField(
//                                   controller: _totalMiles,
//                                   style: const TextStyle(
//                                     color: Color.fromARGB(255, 7, 59, 120),
//                                     fontSize: 20,
//                                   ),
//                                   // keyboardType: TextInputType.number,
//                                   keyboardType:
//                                       const TextInputType.numberWithOptions(
//                                     decimal: true,
//                                     signed: false,
//                                   ),
//                                   onChanged: (value) {
//                                     calculateTotalCost();
//                                   },
//                                   obscureText: false,
//                                   decoration: const InputDecoration(
//                                     border: OutlineInputBorder(),
//                                     enabledBorder: OutlineInputBorder(
//                                         borderSide: BorderSide(
//                                       color: Color.fromARGB(255, 7, 59, 120),
//                                     )),
//                                     // labelText: 'Account Number ',
//                                   ),
//                                 ),
//                               ]),
//                             ),
//                           ],
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(top: 10.0),
//                           child: Column(children: [
//                             const Align(
//                               alignment: Alignment.centerLeft,
//                               child: Text(
//                                 "Cycle: ",
//                                 textAlign: TextAlign.left,
//                                 style: TextStyle(
//                                   color: Color.fromARGB(255, 7, 59, 120),
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 16,
//                                 ),
//                               ),
//                             ),
//                             TextFormField(
//                               controller: _cycle,
//                               style: const TextStyle(
//                                   color: Color.fromARGB(255, 7, 59, 120),
//                                   fontSize: 20),
//                               obscureText: false,
//                               keyboardType: TextInputType.number,
//                               decoration: const InputDecoration(
//                                 border: OutlineInputBorder(),
//                                 enabledBorder: OutlineInputBorder(
//                                     borderSide: BorderSide(
//                                   color: Color.fromARGB(255, 7, 59, 120),
//                                 )),
//                                 // labelText: 'Account Number ',
//                               ),
//                             ),
//                           ]),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(top: 10.0),
//                           child: Column(children: [
//                             const Align(
//                               alignment: Alignment.centerLeft,
//                               child: Text(
//                                 "Foreman: ",
//                                 textAlign: TextAlign.left,
//                                 style: TextStyle(
//                                   color: Color.fromARGB(255, 7, 59, 120),
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 16,
//                                 ),
//                               ),
//                             ),
//                             Container(
//                               padding: const EdgeInsets.symmetric(
//                                   horizontal: 12, vertical: 4),
//                               decoration: BoxDecoration(
//                                 border: Border.all(
//                                   color: const Color.fromARGB(255, 7, 59, 120),
//                                 ),
//                               ),
//                               child: DropdownButtonFormField<String>(
//                                 hint: const Text('-Select-'),
//                                 dropdownColor: Colors.white,
//                                 value: selectedContractor,
//                                 style: const TextStyle(
//                                     color: Color.fromARGB(255, 7, 59, 120),
//                                     fontSize: 16),
//                                 icon: const Icon(
//                                   Icons.arrow_drop_down,
//                                   color: Color.fromARGB(255, 7, 59, 120),
//                                   size: 40,
//                                 ),
//                                 // decoration: const InputDecoration(
//                                 //   enabledBorder: OutlineInputBorder(
//                                 //     borderSide: BorderSide(
//                                 //       color: Color.fromARGB(255, 7, 59, 120),
//                                 //     ),
//                                 //   ),
//                                 //   focusedBorder: OutlineInputBorder(
//                                 //     borderSide: BorderSide(
//                                 //       color: Color.fromARGB(255, 7, 59, 120),
//                                 //     ),
//                                 //   ),
//                                 // ),
//                                 isExpanded: true,
//                                 items: rowMaintenancePlanTabViewModel
//                                     .rowMaintenancePlanTabList
//                                     .data!
//                                     .getAllContractorList!
//                                     .map((e) {
//                                   return DropdownMenuItem(
//                                     value: e.name.toString(),
//                                     // e.getIdAndSubstationByCountId![0].subStation.toString(),
//                                     child: Text(e.name.toString()),
//                                   );
//                                 }).toList(),
//                                 onChanged: (val) {
//                                   print('val');
//                                   print(val);

//                                   setState(() {
//                                     selectedContractor = val;
//                                   });
//                                   if (selectedContractor == 'OTHER') {
//                                     _visibilityOther = true;
//                                   } else {
//                                     _visibilityOther = false;
//                                   }
//                                 },
//                                 validator: (value) =>
//                                     value == null ? 'field required' : null,
//                               ),

//                               //  DropdownButtonHideUnderline(
//                               //   child: DropdownButtonFormField<String>(
//                               //     hint: const Text('Select'),
//                               //     dropdownColor: Colors.white,
//                               //     value: contractor,
//                               //     style: const TextStyle(
//                               //         color: Color.fromARGB(255, 7, 59, 120),
//                               //         fontSize: 16),
//                               //     icon: const Icon(
//                               //       Icons.arrow_drop_down,
//                               //       color: Color.fromARGB(255, 7, 59, 120),
//                               //       size: 40,
//                               //     ),
//                               //     decoration: const InputDecoration(
//                               //       enabledBorder: UnderlineInputBorder(
//                               //           borderSide: BorderSide(
//                               //               color: Colors.transparent)),
//                               //       focusedBorder: UnderlineInputBorder(
//                               //           borderSide: BorderSide(
//                               //               color: Colors.transparent)),
//                               //     ),
//                               //     isExpanded: true,
//                               //     items: contractor_names
//                               //         .map(buildMenuItem)
//                               //         .toList(),
//                               //     onChanged: (value) => setState(() {
//                               //       contractor = value;
//                               //       if (contractor == 'OTHER') {
//                               //         _visibilityOther = true;
//                               //       } else {
//                               //         _visibilityOther = false;
//                               //       }
//                               //     }),
//                               //     validator: (value) =>
//                               //         value == null ? 'field required' : null,
//                               //   ),
//                             ),
//                             Visibility(
//                               visible: _visibilityOther,
//                               child: Padding(
//                                 padding: const EdgeInsets.only(top: 8.0),
//                                 child: Align(
//                                   alignment: Alignment.centerRight,
//                                   child: Padding(
//                                     padding: const EdgeInsets.only(bottom: 2.0),
//                                     child: TextFormField(
//                                       //key: formkey4,
//                                       controller: _otherContractor,
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
//                                                 Color.fromARGB(255, 7, 59, 120),
//                                           ),
//                                         ),
//                                         labelText: 'Other Contractor',
//                                         isDense: true, // Added this
//                                         contentPadding: EdgeInsets.all(22),
//                                         labelStyle:
//                                             TextStyle(color: Colors.grey),
//                                       ),
//                                       validator: (value) {
//                                         if (value!.isEmpty) {
//                                           return "Please enter other contractor";
//                                         } else {
//                                           return null;
//                                         }
//                                       },
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ]),
//                         ),
//                       ]),
//                     ),
//                   ],
//                 )),
//                 actions: [
//                   Container(
//                       margin: const EdgeInsets.only(
//                           left: 6, right: 6, top: 6.0, bottom: 10),
//                       child: InkWell(
//                         onTap: () {
//                           print("object");
//                           print('00000000000000000000');
//                           print(rowMaintenancePlanTabViewModel
//                               .rowMaintenancePlanTabList
//                               .data!
//                               .allVMARowMaintPlanListForAdminSupervisorWorkStatus![
//                                   index]
//                               .contractor
//                               .toString());
//                           //running code
//                           // updateData.clear();
//                           print('mainId');
//                           print(mainId);
//                           if (updateData.isNotEmpty &&
//                               updateData.any((element) =>
//                                   element.id == int.parse(mainId))) {
//                             print(mainId);
//                             print('existingId');
//                             updateData.removeWhere(
//                                 (element) => element.id == int.parse(mainId));
//                             updateData.add(RowMaintenancePlanTabNewModel(
//                                 (rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].id
//                                         .toString()
//                                         .isEmpty)
//                                     ? 0
//                                     : rowMaintenancePlanTabViewModel
//                                         .rowMaintenancePlanTabList
//                                         .data!
//                                         .allVMARowMaintPlanListForAdminSupervisorWorkStatus![
//                                             index]
//                                         .id,
//                                 (_totalMiles.text.toString() == 'null')
//                                     ? '0'
//                                     : _totalMiles.text.toString(),
//                                 (_costPerMiles.text.toString() == 'null' ||
//                                         _costPerMiles.text.toString().isEmpty)
//                                     ? 0
//                                     : double.parse(_costPerMiles.text),
//                                 ((totalCost.toString() == 'null') ? 0 : totalCost)
//                                     as double?,
//                                 (_budget.text.toString().isEmpty)
//                                     ? 0.0
//                                     : double.parse(_budget.text),
//                                 _cycle.text.toString(),
//                                 (rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].nextMaintDue.toString().isEmpty || rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].nextMaintDue == null || rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].nextMaintDue.toString() == 'null')
//                                     ? 'N/A'
//                                     : rowMaintenancePlanTabViewModel
//                                         .rowMaintenancePlanTabList
//                                         .data!
//                                         .allVMARowMaintPlanListForAdminSupervisorWorkStatus![
//                                             index]
//                                         .nextMaintDue,
//                                 (selectedContractor == 'OTHER')
//                                     ? _otherContractor.text.toString()
//                                     : selectedContractor,
//                                 // (rowMaintenancePlanTabViewModel
//                                 //             .rowMaintenancePlanTabList
//                                 //             .data!
//                                 //             .allVMARowMaintPlanListForAdminSupervisorWorkStatus![index]
//                                 //             .contractor
//                                 //             .toString()
//                                 //             .isEmpty ||
//                                 //         rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].contractor == null ||
//                                 //         rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].contractor.toString() == 'null')
//                                 //     ? 'N/A'
//                                 //     : rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].contractor,
//                                 'Pending',
//                                 (rowMaintenancePlanTabViewModel
//                                             .rowMaintenancePlanTabList
//                                             .data!
//                                             .allVMARowMaintPlanListForAdminSupervisorWorkStatus![index]
//                                             .contractorCompay
//                                             .toString()
//                                             .isEmpty ||
//                                         rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].contractorCompay == null ||
//                                         rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].contractorCompay.toString() == 'null')
//                                     ? 'N/A'
//                                     : rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].contractorCompay));
//                           } else {
//                             print('newId');
//                             print(mainId);
//                             updateData.add(RowMaintenancePlanTabNewModel(
//                                 (rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].id
//                                         .toString()
//                                         .isEmpty)
//                                     ? 0
//                                     : rowMaintenancePlanTabViewModel
//                                         .rowMaintenancePlanTabList
//                                         .data!
//                                         .allVMARowMaintPlanListForAdminSupervisorWorkStatus![
//                                             index]
//                                         .id,
//                                 (_totalMiles.text.toString() == 'null')
//                                     ? '0'
//                                     : _totalMiles.text.toString(),
//                                 (_costPerMiles.text.toString() == 'null' ||
//                                         _costPerMiles.text.toString().isEmpty)
//                                     ? 0
//                                     : double.parse(_costPerMiles.text),
//                                 ((totalCost.toString() == 'null') ? 0 : totalCost)
//                                     as double?,
//                                 (_budget.text.toString().isEmpty)
//                                     ? 0.0
//                                     : double.parse(_budget.text),
//                                 _cycle.text.toString(),
//                                 (rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].nextMaintDue.toString().isEmpty || rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].nextMaintDue == null || rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].nextMaintDue.toString() == 'null')
//                                     ? 'N/A'
//                                     : rowMaintenancePlanTabViewModel
//                                         .rowMaintenancePlanTabList
//                                         .data!
//                                         .allVMARowMaintPlanListForAdminSupervisorWorkStatus![
//                                             index]
//                                         .nextMaintDue,
//                                 // (rowMaintenancePlanTabViewModel
//                                 //             .rowMaintenancePlanTabList
//                                 //             .data!
//                                 //             .allVMARowMaintPlanListForAdminSupervisorWorkStatus![index]
//                                 //             .supervisorId
//                                 //             .toString()
//                                 //             .isEmpty ||
//                                 //         rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].supervisorId == null ||
//                                 //         rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].supervisorId.toString() == 'null')
//                                 //     ? 'N/A'
//                                 //     : rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].supervisorId,
//                                 (selectedContractor == 'OTHER')
//                                     ? _otherContractor.text.toString()
//                                     : selectedContractor,
//                                 'PENDING',
//                                 (rowMaintenancePlanTabViewModel
//                                             .rowMaintenancePlanTabList
//                                             .data!
//                                             .allVMARowMaintPlanListForAdminSupervisorWorkStatus![index]
//                                             .contractorCompay
//                                             .toString()
//                                             .isEmpty ||
//                                         rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].contractorCompay == null ||
//                                         rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].contractorCompay.toString() == 'null')
//                                     ? 'N/A'
//                                     : rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].contractorCompay));
//                           }

//                           rowMaintenancePlanTabViewModel
//                               .rowMaintenancePlanTabList
//                               .data!
//                               .allVMARowMaintPlanListForAdminSupervisorWorkStatus![
//                                   index]
//                               .budget = double.parse(_budget.text);
//                           rowMaintenancePlanTabViewModel
//                               .rowMaintenancePlanTabList
//                               .data!
//                               .allVMARowMaintPlanListForAdminSupervisorWorkStatus![
//                                   index]
//                               .costPerMile = double.parse((double.parse(
//                                   _costPerMiles.text.toString()))
//                               .toStringAsFixed(2));
//                           // double.parse(_costPerMiles.text);

// ////***************************************************************************** */
//                           rowMaintenancePlanTabViewModel
//                               .rowMaintenancePlanTabList
//                               .data!
//                               .allVMARowMaintPlanListForAdminSupervisorWorkStatus![
//                                   index]
//                               .totalMiles = double.parse((double.parse(
//                                   _totalMiles.text.toString()))
//                               .toStringAsFixed(2));
//                           //  double.parse(_totalMiles.text);

//                           rowMaintenancePlanTabViewModel
//                               .rowMaintenancePlanTabList
//                               .data!
//                               .allVMARowMaintPlanListForAdminSupervisorWorkStatus![
//                                   index]
//                               .cycle = _cycle.text;
//                           rowMaintenancePlanTabViewModel
//                               .rowMaintenancePlanTabList
//                               .data!
//                               .allVMARowMaintPlanListForAdminSupervisorWorkStatus![
//                                   index]
//                               .contractor = (selectedContractor ==
//                                   'OTHER')
//                               ? _otherContractor.text
//                               : selectedContractor;

//                           rowMaintenancePlanTabViewModel
//                               .rowMaintenancePlanTabList
//                               .data!
//                               .allVMARowMaintPlanListForAdminSupervisorWorkStatus![
//                                   index]
//                               .totalCost = double.parse(((double.parse(
//                                       _costPerMiles.text) *
//                                   double.parse(_totalMiles.text)))
//                               .toStringAsFixed(2));
//                           // double.parse(
//                           //     _costPerMiles.text) *
//                           // double.parse(_totalMiles.text);

//                           print(rowMaintenancePlanTabViewModel
//                               .rowMaintenancePlanTabList
//                               .data!
//                               .allVMARowMaintPlanListForAdminSupervisorWorkStatus![
//                                   index]
//                               .budget);

//                           print('555');
//                           print(updateData);
//                           Navigator.pop(context);
//                         },
//                         child: Container(
//                           margin: const EdgeInsets.only(
//                               left: 40, right: 40, bottom: 10.0),
//                           // padding: const EdgeInsets.all(8),
//                           alignment: Alignment.center,
//                           width: MediaQuery.of(context).size.width,
//                           height: 40,
//                           decoration: const BoxDecoration(
//                               // shape: BoxShape.circle,

//                               boxShadow: [
//                                 BoxShadow(
//                                     color: Color.fromARGB(255, 1, 56, 100),
//                                     blurRadius: 5,
//                                     offset: Offset(2.0, 5.0))
//                               ],
//                               color: Colors.black,
//                               gradient: LinearGradient(
//                                 colors: [
//                                   Color.fromARGB(255, 1, 45, 120),
//                                   Colors.blue,
//                                   Color.fromARGB(255, 0, 79, 215),
//                                 ],
//                               )),
//                           child: const Align(
//                             alignment: Alignment.center,
//                             child: Text(
//                               "Update",
//                               textAlign: TextAlign.left,
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 20,
//                               ),
//                             ),
//                           ),
//                         ),
//                       )),
//                 ],
//               );
//             });
//           });

//   void fetchData(String year, String cycle, String substation, String feeder) {
//     rowMaintenancePlanTabViewModel.fetchRowMaintenancePlanTavViewListApi(
//         context, year, cycle, substation, feeder);
//     Navigator.pop(context);
//   }

//   Future<void> setData1(int index) async {
//     _costPerMiles.text = (rowMaintenancePlanTabViewModel
//                 .rowMaintenancePlanTabList
//                 .data!
//                 .allVMARowMaintPlanListForAdminSupervisorWorkStatus![index]
//                 .costPerMile
//                 .toString()
//                 .isEmpty ||
//             rowMaintenancePlanTabViewModel
//                     .rowMaintenancePlanTabList
//                     .data!
//                     .allVMARowMaintPlanListForAdminSupervisorWorkStatus![index]
//                     .costPerMile ==
//                 null ||
//             rowMaintenancePlanTabViewModel
//                     .rowMaintenancePlanTabList
//                     .data!
//                     .allVMARowMaintPlanListForAdminSupervisorWorkStatus![index]
//                     .costPerMile
//                     .toString() ==
//                 'null')
//         ? 'N/A'
//         : rowMaintenancePlanTabViewModel
//             .rowMaintenancePlanTabList
//             .data!
//             .allVMARowMaintPlanListForAdminSupervisorWorkStatus![index]
//             .costPerMile
//             .toString();

//     _totalMiles.text = (rowMaintenancePlanTabViewModel
//                 .rowMaintenancePlanTabList
//                 .data!
//                 .allVMARowMaintPlanListForAdminSupervisorWorkStatus![index]
//                 .totalMiles
//                 .toString()
//                 .isEmpty ||
//             rowMaintenancePlanTabViewModel
//                     .rowMaintenancePlanTabList
//                     .data!
//                     .allVMARowMaintPlanListForAdminSupervisorWorkStatus![index]
//                     .totalMiles ==
//                 null ||
//             rowMaintenancePlanTabViewModel
//                     .rowMaintenancePlanTabList
//                     .data!
//                     .allVMARowMaintPlanListForAdminSupervisorWorkStatus![index]
//                     .totalMiles
//                     .toString() ==
//                 'null')
//         ? '0'
//         : rowMaintenancePlanTabViewModel
//             .rowMaintenancePlanTabList
//             .data!
//             .allVMARowMaintPlanListForAdminSupervisorWorkStatus![index]
//             .totalMiles
//             .toString();

//     _budget.text = (rowMaintenancePlanTabViewModel
//                 .rowMaintenancePlanTabList
//                 .data!
//                 .allVMARowMaintPlanListForAdminSupervisorWorkStatus![index]
//                 .budget
//                 .toString()
//                 .isEmpty ||
//             rowMaintenancePlanTabViewModel
//                     .rowMaintenancePlanTabList
//                     .data!
//                     .allVMARowMaintPlanListForAdminSupervisorWorkStatus![index]
//                     .budget ==
//                 null ||
//             rowMaintenancePlanTabViewModel
//                     .rowMaintenancePlanTabList
//                     .data!
//                     .allVMARowMaintPlanListForAdminSupervisorWorkStatus![index]
//                     .budget
//                     .toString() ==
//                 'null')
//         ? 'N/A'
//         : rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!
//             .allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].budget
//             .toString();

//     _cycle.text = (rowMaintenancePlanTabViewModel
//                 .rowMaintenancePlanTabList
//                 .data!
//                 .allVMARowMaintPlanListForAdminSupervisorWorkStatus![index]
//                 .cycle
//                 .toString()
//                 .isEmpty ||
//             rowMaintenancePlanTabViewModel
//                     .rowMaintenancePlanTabList
//                     .data!
//                     .allVMARowMaintPlanListForAdminSupervisorWorkStatus![index]
//                     .cycle ==
//                 null ||
//             rowMaintenancePlanTabViewModel
//                     .rowMaintenancePlanTabList
//                     .data!
//                     .allVMARowMaintPlanListForAdminSupervisorWorkStatus![index]
//                     .cycle
//                     .toString() ==
//                 'null')
//         ? 'N/A'
//         : rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!
//             .allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].cycle
//             .toString();

//     selectedContractor = (rowMaintenancePlanTabViewModel
//                 .rowMaintenancePlanTabList
//                 .data!
//                 .allVMARowMaintPlanListForAdminSupervisorWorkStatus![index]
//                 .contractorName
//                 .toString()
//                 .isEmpty ||
//             rowMaintenancePlanTabViewModel
//                     .rowMaintenancePlanTabList
//                     .data!
//                     .allVMARowMaintPlanListForAdminSupervisorWorkStatus![index]
//                     .contractorName ==
//                 null ||
//             rowMaintenancePlanTabViewModel
//                     .rowMaintenancePlanTabList
//                     .data!
//                     .allVMARowMaintPlanListForAdminSupervisorWorkStatus![index]
//                     .contractorName
//                     .toString() ==
//                 'null')
//         ? null
//         : rowMaintenancePlanTabViewModel
//             .rowMaintenancePlanTabList
//             .data!
//             .allVMARowMaintPlanListForAdminSupervisorWorkStatus![index]
//             .contractorName
//             .toString();
//     RowMaintenancePlanTabNewModel(
//         (rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!
//                 .allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].id
//                 .toString()
//                 .isEmpty)
//             ? 0
//             : rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!
//                 .allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].id,
//         (_totalMiles.text.toString() == 'null')
//             ? '0'
//             : _totalMiles.text.toString(),
//         (_costPerMiles.text.toString() == 'null' || _costPerMiles.text.toString().isEmpty)
//             ? 0
//             : double.parse(_costPerMiles.text),
//         (totalCost.toString() == 'null') ? 0 : totalCost,
//         (_budget.text.toString().isEmpty) ? 0.0 : double.parse(_budget.text),
//         _cycle.text.toString(),
//         (rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].nextMaintDue.toString().isEmpty || rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].nextMaintDue == null || rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].nextMaintDue.toString() == 'null')
//             ? 'N/A'
//             : rowMaintenancePlanTabViewModel
//                 .rowMaintenancePlanTabList
//                 .data!
//                 .allVMARowMaintPlanListForAdminSupervisorWorkStatus![index]
//                 .nextMaintDue,
//         (rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].supervisorId.toString().isEmpty || rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].supervisorId == null || rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].supervisorId.toString() == 'null')
//             ? 'N/A'
//             : rowMaintenancePlanTabViewModel
//                 .rowMaintenancePlanTabList
//                 .data!
//                 .allVMARowMaintPlanListForAdminSupervisorWorkStatus![index]
//                 .supervisorId,
//         '12',
//         (rowMaintenancePlanTabViewModel
//                     .rowMaintenancePlanTabList
//                     .data!
//                     .allVMARowMaintPlanListForAdminSupervisorWorkStatus![index]
//                     .contractorCompay
//                     .toString()
//                     .isEmpty ||
//                 rowMaintenancePlanTabViewModel
//                         .rowMaintenancePlanTabList
//                         .data!
//                         .allVMARowMaintPlanListForAdminSupervisorWorkStatus![index]
//                         .contractorCompay ==
//                     null ||
//                 rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].contractorCompay.toString() == 'null')
//             ? 'N/A'
//             : rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!.allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].contractorCompay);

//     await openDailogEditCardData(
//         rowMaintenancePlanTabViewModel.rowMaintenancePlanTabList.data!
//             .allVMARowMaintPlanListForAdminSupervisorWorkStatus![index].id
//             .toString(),
//         '12',
//         nextMaintDueZeroIndex,
//         rowMaintenancePlanTabViewModel
//             .rowMaintenancePlanTabList
//             .data!
//             .allVMARowMaintPlanListForAdminSupervisorWorkStatus![index]
//             .supervisorId
//             .toString(),
//         index);

//     setState(() {});
//   }

//   calculateTotalCost() {
//     Object totalMiles = _totalMiles.text.toString() == '' ||
//             _totalMiles.text.toString() == 'null'
//         ? 0
//         : _totalMiles.text.toString();

//     double.parse(_totalMiles.text);
//     Object costPerMile = _costPerMiles.text.toString() == '' ||
//             _costPerMiles.text.toString() == 'null'
//         ? 0
//         : _costPerMiles.text.toString();

//     double.parse(_costPerMiles.text);
//     totalCost = double.parse(totalMiles.toString()) *
//         double.parse(costPerMile.toString());
//     print('totalCost');
//     print(totalCost);
//   }
// }
