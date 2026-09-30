// import 'package:CIVM/piedmont/screens/generalForeman_New_pannel/contractor_dispatch_dashboard.dart';
// import 'package:CIVM/piedmont/screens/generalForeman_New_pannel/inspection.dart';
// import 'package:CIVM/piedmont/screens/leaflat_map/leaf_lat_map_wakeLock.dart';
// import 'package:CIVM/piedmont/screens/login_page.dart';
// import 'package:CIVM/piedmont/screens/map/provider/location_provider.dart';
// import 'package:CIVM/piedmont/screens/my_chrome_safari_map_recording.dart';
// import 'package:CIVM/piedmont/utils/common_functions.dart';
// import 'package:CIVM/sharedPrefs/constants.dart';
// import 'package:CIVM/piedmont/utils/custom_toast_snackbar_progressdialog.dart';
// import 'package:CIVM/utils/user_pref.dart';
// import 'package:CIVM/models/user_model.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
// import 'package:CIVM/piedmont/data/response/status.dart';
// import 'package:CIVM/piedmont/view_model/add_crew_member_view_model.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:CIVM/piedmont/resources/app_colors.dart';

// class EdkoAddCrewMember extends StatefulWidget {
//   const EdkoAddCrewMember({Key? key}) : super(key: key);

//   @override
//   State<EdkoAddCrewMember> createState() => _EdkoAddCrewMemberState();
// }

// class _EdkoAddCrewMemberState extends State<EdkoAddCrewMember> {
//   // final List<Widget> _children = [
//   //   RowMaintenancePlan(),
//   //   // BottomNavigationHomePage(),
//   //   // BottomNavigationAccountPage()
//   // ];

//   final TextEditingController _crewName = TextEditingController();
//   final TextEditingController _email = TextEditingController();
//   final TextEditingController _password = TextEditingController();
//   List<String> menu = [];

//   // ignore: prefer_typing_uninitialized_variables
//   var selectedAssignContractor;
//   int assignContratorId = 0;

//   bool? _active = false;

//   final TextEditingController _input = TextEditingController();
//   final GlobalKey<FormState> _addCrewFormKey = GlobalKey<FormState>();

//   onTappedBar(int index) {
//     setState(() {
//       // _currentIndex = index;
//     });
//   }

//   AddCrewMemberViewModel addCrewMemberViewModel = AddCrewMemberViewModel();
//   @override
//   void initState() {
//     addCrewMemberViewModel.fetchAddCrewMemberTabularListApi(context);
//     // getOwnPermissions();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: AppColors.backgroundColor,
//         appBar: AppBar(
//           iconTheme: const IconThemeData(color: Colors.white),
//           title: const Text(
//             'Add New Crew Member',
//             style: TextStyle(color: Colors.white),
//           ),
//           backgroundColor: AppColors.baseColor,
//           actions: <Widget>[
//             IconButton(
//               icon: const Icon(
//                 Icons.add,
//                 color: Colors.white,
//               ),
//               onPressed: () {
//                 openDailogAddCrewMember();
//                 // do something
//               },
//             )
//           ],
//         ),
//         drawer: DrawerManu(menu: menu),
//         body: ChangeNotifierProvider<AddCrewMemberViewModel>(
//             create: (BuildContext context) => addCrewMemberViewModel,
//             child:
//                 Consumer<AddCrewMemberViewModel>(builder: (context, value, _) {
//               switch (value.addCrewMemberTabularData.status) {
//                 case Status.LOADING:
//                   return const Center(child: CircularProgressIndicator());
//                 case Status.ERROR:
//                   return Padding(
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

//                 // CustomToastSnackBarProgressDialog.flushBarErrorMessage(
//                 //     value.addCrewMemberTabularData.message.toString(),
//                 //     context);

//                 case Status.COMPLETED:
//                   return RefreshIndicator(
//                     onRefresh: () async {
//                       _input.clear();
//                       await addCrewMemberViewModel
//                           .fetchAddCrewMemberTabularListApi(context);
//                     },
//                     child: Padding(
//                         padding: const EdgeInsets.all(4.0),
//                         child: Column(
//                           children: [
//                             Align(
//                               alignment: Alignment.centerRight,
//                               child: Padding(
//                                 padding: const EdgeInsets.only(
//                                     left: 8.0, right: 8.0),
//                                 child: TextFormField(
//                                   onChanged: (value) => _filterData(value),
//                                   //  key: formkey2,
//                                   controller: _input,
//                                   style: const TextStyle(
//                                       color: AppColors.baseColor, fontSize: 16),
//                                   obscureText: false,

//                                   //keyboardType: TextInputType.number,
//                                   decoration: const InputDecoration(
//                                     border: OutlineInputBorder(
//                                         // borderRadius: BorderRadius.circular(25),
//                                         ),
//                                     enabledBorder: OutlineInputBorder(
//                                       borderSide: BorderSide(
//                                           color:
//                                               Color.fromARGB(255, 7, 59, 120)),
//                                       // borderRadius: BorderRadius.circular(25),
//                                     ),
//                                     hintText: 'Search your input...',
//                                     hintStyle: TextStyle(color: Colors.grey),
//                                   ),
//                                   validator: (value) {
//                                     if (value!.isEmpty) {
//                                       return "Please search your input";
//                                     } else {
//                                       return null;
//                                     }
//                                   },
//                                 ),
//                               ),
//                             ),
//                             Expanded(
//                               child: SingleChildScrollView(
//                                 physics: const AlwaysScrollableScrollPhysics(),
//                                 child: ListView.builder(
//                                   physics: const NeverScrollableScrollPhysics(),
//                                   scrollDirection: Axis.vertical,
//                                   shrinkWrap: true,
//                                   itemCount: addCrewMemberViewModel
//                                       .addCrewMemberTabularData
//                                       .data!
//                                       .getaAllCewMemberTableDatas!
//                                       .length,
//                                   itemBuilder: (context, index) {
//                                     return Row(
//                                       children: [
//                                         Expanded(
//                                           flex: 1,
//                                           child: Container(
//                                             width: MediaQuery.of(context)
//                                                     .size
//                                                     .width *
//                                                 0.285,
//                                             // height: MediaQuery.of(context)
//                                             //         .size
//                                             //         .height *
//                                             //     0.25,
//                                             // height: 190,
//                                             margin: const EdgeInsets.only(
//                                                 left: 8.0,
//                                                 right: 8.0,
//                                                 top: 5.0,
//                                                 bottom: 5.0),
//                                             padding: const EdgeInsets.all(8),
//                                             decoration: BoxDecoration(
//                                               gradient: LinearGradient(
//                                                 colors: [
//                                                   AppColors.green1
//                                                       .withOpacity(0.9),
//                                                   AppColors.green2
//                                                       .withOpacity(0.7),
//                                                   AppColors.green1
//                                                       .withOpacity(0.9),
//                                                 ],
//                                                 begin: Alignment.topLeft,
//                                                 end: Alignment.bottomRight,
//                                               ),
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
//                                               ),
//                                             ),
//                                             child: Column(children: [
//                                               Row(
//                                                 children: [
//                                                   Expanded(
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
//                                                                     color: AppColors
//                                                                         .white,
//                                                                   ),
//                                                                 ),
//                                                               ),
//                                                               Align(
//                                                                 alignment:
//                                                                     Alignment
//                                                                         .topLeft,
//                                                                 child: Text(
//                                                                   (addCrewMemberViewModel.addCrewMemberTabularData.data!.getaAllCewMemberTableDatas![index].id ==
//                                                                               null ||
//                                                                           addCrewMemberViewModel.addCrewMemberTabularData.data!.getaAllCewMemberTableDatas![index].id.toString() ==
//                                                                               'null')
//                                                                       ? ''
//                                                                       : addCrewMemberViewModel
//                                                                           .addCrewMemberTabularData
//                                                                           .data!
//                                                                           .getaAllCewMemberTableDatas![
//                                                                               index]
//                                                                           .id
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
//                                                                     color: AppColors
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
//                                                                   "CREW NAME: ",
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
//                                                                     color: AppColors
//                                                                         .white,
//                                                                   ),
//                                                                 ),
//                                                               ),
//                                                               Align(
//                                                                 alignment:
//                                                                     Alignment
//                                                                         .topLeft,
//                                                                 child: Text(
//                                                                   (addCrewMemberViewModel.addCrewMemberTabularData.data!.getaAllCewMemberTableDatas![index].name ==
//                                                                               null ||
//                                                                           addCrewMemberViewModel.addCrewMemberTabularData.data!.getaAllCewMemberTableDatas![index].name.toString() ==
//                                                                               'null')
//                                                                       ? ''
//                                                                       : addCrewMemberViewModel
//                                                                           .addCrewMemberTabularData
//                                                                           .data!
//                                                                           .getaAllCewMemberTableDatas![
//                                                                               index]
//                                                                           .name
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
//                                                                     color: AppColors
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
//                                                 ],
//                                               ),
//                                               const Divider(
//                                                 color: Colors.grey,
//                                               ),
//                                               Row(
//                                                 children: [
//                                                   Expanded(
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
//                                                                   "GENERAL FOREMAN NAME: ",
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
//                                                                     color: AppColors
//                                                                         .white,
//                                                                   ),
//                                                                 ),
//                                                               ),
//                                                               Align(
//                                                                 alignment:
//                                                                     Alignment
//                                                                         .topLeft,
//                                                                 child: Text(
//                                                                   (addCrewMemberViewModel.addCrewMemberTabularData.data!.getaAllCewMemberTableDatas![index].contractor ==
//                                                                               null ||
//                                                                           addCrewMemberViewModel.addCrewMemberTabularData.data!.getaAllCewMemberTableDatas![index].contractor.toString() ==
//                                                                               'null')
//                                                                       ? ''
//                                                                       : addCrewMemberViewModel
//                                                                           .addCrewMemberTabularData
//                                                                           .data!
//                                                                           .getaAllCewMemberTableDatas![
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
//                                                                     color: AppColors
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
//                                                                   "SUPERVISOR NAME: ",
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
//                                                                     color: AppColors
//                                                                         .white,
//                                                                   ),
//                                                                 ),
//                                                               ),
//                                                               Align(
//                                                                 alignment:
//                                                                     Alignment
//                                                                         .topLeft,
//                                                                 child: Text(
//                                                                   (addCrewMemberViewModel.addCrewMemberTabularData.data!.getaAllCewMemberTableDatas![index].supervisor ==
//                                                                               null ||
//                                                                           addCrewMemberViewModel.addCrewMemberTabularData.data!.getaAllCewMemberTableDatas![index].supervisor.toString() ==
//                                                                               'null')
//                                                                       ? ''
//                                                                       : addCrewMemberViewModel
//                                                                           .addCrewMemberTabularData
//                                                                           .data!
//                                                                           .getaAllCewMemberTableDatas![
//                                                                               index]
//                                                                           .supervisor
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
//                                                                     color: AppColors
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
//                                                 ],
//                                               ),
//                                               const Divider(
//                                                 color: Colors.grey,
//                                               ),
//                                               Row(
//                                                 children: [
//                                                   Expanded(
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
//                                                                     color: AppColors
//                                                                         .white,
//                                                                   ),
//                                                                 ),
//                                                               ),
//                                                               Align(
//                                                                 alignment:
//                                                                     Alignment
//                                                                         .topLeft,
//                                                                 child: Text(
//                                                                   (addCrewMemberViewModel.addCrewMemberTabularData.data!.getaAllCewMemberTableDatas![index].status ==
//                                                                               null ||
//                                                                           addCrewMemberViewModel.addCrewMemberTabularData.data!.getaAllCewMemberTableDatas![index].status.toString() ==
//                                                                               'null')
//                                                                       ? ''
//                                                                       : addCrewMemberViewModel
//                                                                           .addCrewMemberTabularData
//                                                                           .data!
//                                                                           .getaAllCewMemberTableDatas![
//                                                                               index]
//                                                                           .status
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
//                                                                     color: AppColors
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
//                                                   Expanded(
//                                                     child: Row(
//                                                       children: [
//                                                         Expanded(
//                                                           // alignment: Alignment.topLeft,
//                                                           child: Row(
//                                                             children: [
//                                                               const Align(
//                                                                 alignment:
//                                                                     Alignment
//                                                                         .topLeft,
//                                                                 child: Text(
//                                                                   "ACTION: ",
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
//                                                                     color: AppColors
//                                                                         .white,
//                                                                   ),
//                                                                 ),
//                                                               ),
//                                                               Align(
//                                                                 alignment:
//                                                                     Alignment
//                                                                         .topLeft,
//                                                                 child: InkWell(
//                                                                   onTap: () {
//                                                                     deny(
//                                                                         (addCrewMemberViewModel.addCrewMemberTabularData.data!.getaAllCewMemberTableDatas![index].status!.isNotEmpty && addCrewMemberViewModel.addCrewMemberTabularData.data!.getaAllCewMemberTableDatas![index].status!.toString() == 'PENDING')
//                                                                             ? 'ALLOW'
//                                                                             : 'DENY',
//                                                                         index,
//                                                                         addCrewMemberViewModel
//                                                                             .addCrewMemberTabularData
//                                                                             .data!
//                                                                             .getaAllCewMemberTableDatas![
//                                                                                 index]
//                                                                             .id
//                                                                             .toString(),
//                                                                         addCrewMemberViewModel
//                                                                             .addCrewMemberTabularData
//                                                                             .data!
//                                                                             .getaAllCewMemberTableDatas![index]
//                                                                             .status
//                                                                             .toString());
//                                                                   },
//                                                                   child:
//                                                                       Container(
//                                                                     // padding: const EdgeInsets.all(2),
//                                                                     alignment:
//                                                                         Alignment
//                                                                             .center,
//                                                                     height: 30,
//                                                                     width: 90,
//                                                                     decoration: BoxDecoration(
//                                                                         // shape: BoxShape.circle,
//                                                                         // borderRadius: BorderRadius.circular(10),
//                                                                         boxShadow: (addCrewMemberViewModel.addCrewMemberTabularData.data!.getaAllCewMemberTableDatas![index].status!.toString().isNotEmpty && addCrewMemberViewModel.addCrewMemberTabularData.data!.getaAllCewMemberTableDatas![index].status!.toString() == 'PENDING')
//                                                                             ? [
//                                                                                 const BoxShadow(color: Color.fromARGB(255, 2, 43, 113), blurRadius: 5, offset: Offset(2.0, 5.0))
//                                                                               ]
//                                                                             : [
//                                                                                 const BoxShadow(color: Color.fromARGB(255, 117, 10, 2), blurRadius: 5, offset: Offset(2.0, 5.0))
//                                                                               ],
//                                                                         color: Colors.black,
//                                                                         gradient: LinearGradient(
//                                                                           colors: (addCrewMemberViewModel.addCrewMemberTabularData.data!.getaAllCewMemberTableDatas![index].status!.toString().isNotEmpty &&
//                                                                                   addCrewMemberViewModel.addCrewMemberTabularData.data!.getaAllCewMemberTableDatas![index].status.toString() ==
//                                                                                       'ACTIVE')
//                                                                               ? (addCrewMemberViewModel.addCrewMemberTabularData.data!.getaAllCewMemberTableDatas![index].status!.toString().isNotEmpty &&
//                                                                                       addCrewMemberViewModel.addCrewMemberTabularData.data!.getaAllCewMemberTableDatas![index].status.toString() ==
//                                                                                           'PENDING')
//                                                                                   ? [
//                                                                                       const Color.fromARGB(255, 243, 128, 119),
//                                                                                       const Color.fromARGB(255, 243, 128, 119),
//                                                                                       const Color.fromARGB(255, 243, 128, 119)
//                                                                                     ]
//                                                                                   : [
//                                                                                       Colors.red,
//                                                                                       Colors.red,
//                                                                                       Colors.red
//                                                                                     ]
//                                                                               : [
//                                                                                   Colors.blueAccent,
//                                                                                   const Color.fromARGB(255, 3, 91, 242),
//                                                                                   Colors.blueAccent,
//                                                                                 ],
//                                                                         )),
//                                                                     child: Column(
//                                                                         children: [
//                                                                           Expanded(
//                                                                             child:
//                                                                                 Align(
//                                                                               alignment: Alignment.center,
//                                                                               child: Text(
//                                                                                 (addCrewMemberViewModel.addCrewMemberTabularData.data!.getaAllCewMemberTableDatas![index].status!.toString().isNotEmpty && addCrewMemberViewModel.addCrewMemberTabularData.data!.getaAllCewMemberTableDatas![index].status!.toString() == 'PENDING') ? 'ALLOW' : 'DENY',
//                                                                                 textAlign: TextAlign.center,
//                                                                                 style: const TextStyle(
//                                                                                   color: Colors.white,
//                                                                                   fontWeight: FontWeight.bold,
//                                                                                   fontSize: 15,
//                                                                                 ),
//                                                                               ),
//                                                                             ),
//                                                                           ),
//                                                                         ]),
//                                                                   ),
//                                                                 ),
//                                                               ),
//                                                             ],
//                                                           ),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ]),
//                                           ),
//                                         ),
//                                       ],
//                                     );
//                                   },
//                                 ),
//                               ),
//                             ),
//                           ],
//                         )),
//                   );

//                 default:
//                   return const Text('data');
//               }
//             })));
//   }

//   Future<void> _filterData(String query) async {
//     if (query.isEmpty) {
//       addCrewMemberViewModel.fetchAddCrewMemberTabularListApi(context);
//     } else {
//       addCrewMemberViewModel
//               .addCrewMemberTabularData.data?.getaAllCewMemberTableDatas =
//           addCrewMemberViewModel
//               .addCrewMemberTabularData.data?.getaAllCewMemberTableDatas
//               ?.where((item) =>
//                   item.status
//                       .toString()
//                       .toLowerCase()
//                       .contains(query.toLowerCase()) ||
//                   item.name
//                       .toString()
//                       .toLowerCase()
//                       .contains(query.toLowerCase()) ||
//                   item.contractor
//                       .toString()
//                       .toLowerCase()
//                       .contains(query.toLowerCase()) ||
//                   item.supervisor
//                       .toString()
//                       .toLowerCase()
//                       .contains(query.toLowerCase()) ||
//                   item.id
//                       .toString()
//                       .toLowerCase()
//                       .contains(query.toLowerCase()))
//               .toList();
//     }
//     setState(() {});
//   }

//   Future openDailogAddCrewMember() => showDialog(
//       context: context,
//       builder: (context) {
//         // setDataCrew();
//         bool _obscurePassword = true;
//         return StatefulBuilder(builder: (context, setState) {
//           return AlertDialog(
//             content: Form(
//               key: _addCrewFormKey,
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     Container(
//                       margin: const EdgeInsets.only(top: 10),
//                       child: Column(
//                         children: [
//                           const Align(
//                               alignment: Alignment.centerLeft,
//                               child: Padding(
//                                 padding: EdgeInsets.all(2.0),
//                                 child: Text(
//                                   "Crew Name",
//                                   style: TextStyle(
//                                     fontSize: 16.0,
//                                     color: AppColors.baseColor,
//                                   ),
//                                 ),
//                               )),
//                           Align(
//                             alignment: Alignment.centerRight,
//                             child: Padding(
//                               padding: const EdgeInsets.all(2.0),
//                               child: TextFormField(
//                                 //  key: formkey2,
//                                 controller: _crewName,
//                                 style: const TextStyle(
//                                     color: AppColors.baseColor, fontSize: 16),
//                                 obscureText: false,
//                                 // keyboardType: TextInputType.number,
//                                 decoration: const InputDecoration(
//                                   border: OutlineInputBorder(
//                                       // borderRadius: BorderRadius.circular(25),
//                                       ),
//                                   enabledBorder: OutlineInputBorder(
//                                     borderSide: BorderSide(
//                                       color: AppColors.baseColor,
//                                     ),
//                                     // borderRadius: BorderRadius.circular(25),
//                                   ),
//                                   hintText: 'Crew Name',
//                                   // prefixIcon: const Icon(
//                                   //   Icons.person,
//                                   //   color: AppColors.baseColor,
//                                   // ),
//                                 ),

//                                 validator: (value) {
//                                   if (value.toString() == '') {
//                                     return "Please enter crew name";
//                                   } else {
//                                     return null;
//                                   }
//                                 },
//                               ),
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                     Container(
//                       margin: const EdgeInsets.only(top: 10),
//                       child: Column(
//                         children: [
//                           const Align(
//                               alignment: Alignment.centerLeft,
//                               child: Padding(
//                                 padding: EdgeInsets.all(2.0),
//                                 child: Text(
//                                   "Email",
//                                   style: TextStyle(
//                                     fontSize: 16.0,
//                                     color: AppColors.baseColor,
//                                   ),
//                                 ),
//                               )),
//                           Align(
//                             alignment: Alignment.centerRight,
//                             child: Padding(
//                               padding: const EdgeInsets.all(2.0),
//                               child: TextFormField(
//                                 //  key: formkey2,
//                                 controller: _email,
//                                 style: const TextStyle(
//                                     color: AppColors.baseColor, fontSize: 16),
//                                 obscureText: false,
//                                 // keyboardType: TextInputType.number,
//                                 decoration: const InputDecoration(
//                                   border: OutlineInputBorder(
//                                       // borderRadius: BorderRadius.circular(25),
//                                       ),
//                                   enabledBorder: OutlineInputBorder(
//                                     borderSide: BorderSide(
//                                       color: AppColors.baseColor,
//                                     ),
//                                     // borderRadius: BorderRadius.circular(25),
//                                   ),
//                                   hintText: 'Email',
//                                   // prefixIcon: const Icon(
//                                   //   Icons.person,
//                                   //   color: AppColors.baseColor,
//                                   // ),
//                                 ),

//                                 validator: (value) {
//                                   if (value == null || value.trim().isEmpty) {
//                                     return "Please enter email";
//                                   }

//                                   if (value.contains(' ')) {
//                                     return "Email should not contain spaces";
//                                   }

//                                   // // Optional: Proper email format validation
//                                   // if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
//                                   //     .hasMatch(value)) {
//                                   //   return "Enter a valid email address";
//                                   // }

//                                   return null;
//                                 },
//                               ),
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                     Container(
//                       margin: const EdgeInsets.only(top: 10),
//                       child: Column(
//                         children: [
//                           const Align(
//                               alignment: Alignment.centerLeft,
//                               child: Padding(
//                                 padding: EdgeInsets.all(2.0),
//                                 child: Text(
//                                   "Password",
//                                   style: TextStyle(
//                                     fontSize: 16.0,
//                                     color: AppColors.baseColor,
//                                   ),
//                                 ),
//                               )),
//                           Align(
//                             alignment: Alignment.centerRight,
//                             child: Padding(
//                               padding: const EdgeInsets.all(2.0),
//                               child: TextFormField(
//                                 controller: _password,
//                                 style: const TextStyle(
//                                   color: AppColors.baseColor,
//                                   fontSize: 16,
//                                 ),
//                                 obscureText: _obscurePassword,
//                                 decoration: InputDecoration(
//                                   border: const OutlineInputBorder(),
//                                   enabledBorder: const OutlineInputBorder(
//                                     borderSide: BorderSide(
//                                       color: AppColors.baseColor,
//                                     ),
//                                   ),
//                                   hintText: 'Password',
//                                   suffixIcon: IconButton(
//                                     icon: Icon(
//                                       _obscurePassword
//                                           ? Icons.visibility_off
//                                           : Icons.visibility,
//                                       color: AppColors.baseColor,
//                                     ),
//                                     onPressed: () {
//                                       setState(() {
//                                         _obscurePassword = !_obscurePassword;
//                                       });
//                                     },
//                                   ),
//                                 ),
//                                 validator: (value) {
//                                   if (value == null || value.isEmpty) {
//                                     return "Please enter password";
//                                   }
//                                   return null;
//                                 },
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Container(
//                       margin: const EdgeInsets.only(top: 10),
//                       child: Column(
//                         children: [
//                           const Align(
//                               alignment: Alignment.centerLeft,
//                               child: Padding(
//                                 padding: EdgeInsets.all(2.0),
//                                 child: Text(
//                                   "Assign Foreman",
//                                   style: TextStyle(
//                                     fontSize: 16.0,
//                                     color: AppColors.baseColor,
//                                   ),
//                                 ),
//                               )),
//                           Align(
//                             alignment: Alignment.centerLeft,
//                             child: Padding(
//                               padding: const EdgeInsets.all(2.0),
//                               child: DropdownButtonFormField<String>(
//                                 hint: const Text('-Select-'),
//                                 dropdownColor: Colors.white,
//                                 value: selectedAssignContractor,
//                                 style: const TextStyle(
//                                     color: AppColors.baseColor, fontSize: 16),
//                                 icon: const Icon(
//                                   Icons.arrow_drop_down,
//                                   color: AppColors.baseColor,
//                                   size: 40,
//                                 ),
//                                 decoration: const InputDecoration(
//                                   enabledBorder: OutlineInputBorder(
//                                     borderSide: BorderSide(
//                                       color: AppColors.baseColor,
//                                     ),
//                                     // borderRadius: BorderRadius.circular(25),
//                                   ),
//                                   focusedBorder: OutlineInputBorder(
//                                     borderSide: BorderSide(
//                                       color: AppColors.baseColor,
//                                     ),
//                                     // borderRadius: BorderRadius.circular(25),
//                                   ),
//                                 ),
//                                 isExpanded: true,
//                                 items: addCrewMemberViewModel
//                                     .addCrewMemberTabularData
//                                     .data!
//                                     .contractorListNameId!
//                                     .map((e) {
//                                   return DropdownMenuItem(
//                                     value: e.id.toString(),
//                                     child: Text(e.name.toString()),
//                                   );
//                                 }).toList(),
//                                 onChanged: (val) {
//                                   assignContratorId = int.parse(val!);
//                                   setState(() {
//                                     selectedAssignContractor = val;
//                                   });
//                                 },
//                                 validator: (value) =>
//                                     value == null ? 'field required' : null,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Align(
//                       alignment: Alignment.centerLeft,
//                       child: CheckboxListTile(
//                         title: const Text("Active",
//                             style: TextStyle(
//                                 color: AppColors.baseColor, fontSize: 20)),
//                         //secondary: Icon(Icons.beach_access),
//                         controlAffinity: ListTileControlAffinity.leading,
//                         value: _active,
//                         onChanged: (val) {
//                           setState(() {
//                             _active = val;
//                           });
//                         },
//                         activeColor: const Color.fromARGB(255, 80, 157, 244),
//                         checkColor: AppColors.baseColor,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             actions: [
//               Container(
//                   margin: const EdgeInsets.only(left: 6, right: 6, bottom: 10),
//                   child: InkWell(
//                     onTap: () {
//                       print("bb");
//                       if (!_addCrewFormKey.currentState!.validate()) {
//                         return; // ❌ Stop if validation fails
//                       }
//                       Map<String, dynamic> mapData = {
//                         "fName": (_crewName.text.toString() == 'null' ||
//                                 _crewName.text.toString() == '')
//                             ? 'N/A'
//                             : _crewName.text.toString(),
//                         "status": (_active == true) ? 'ACTIVE' : 'PENDING',
//                         // "userName": (_crewName.text.toString() == 'null' ||
//                         //         _crewName.text.toString() == '')
//                         //     ? 'N/A'
//                         //     : _crewName.text.toString(),
//                         "email": (_email.text.toString() == 'null' ||
//                                 _email.text.toString() == '')
//                             ? 'N/A'
//                             : _email.text.toString(),
//                         "password": (_password.text.toString() == 'null' ||
//                                 _password.text.toString() == '')
//                             ? 'N/A'
//                             : _password.text.toString(),
//                         "contractor": assignContratorId.toString(),
//                       };
//                       print(mapData);
//                       createCrew(context, mapData);
//                       // addCrewMemberViewModel
//                       //     .fetchAddCrewMemberInsertApi(context, mapData)
//                       //     .then((value) {
//                       //   Navigator.pop(context);
//                       //   addCrewMemberViewModel
//                       //       .fetchAddCrewMemberTabularListApi(context);
//                       // });
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
//                           // borderRadius: BorderRadius.circular(25),
//                           boxShadow: [
//                             BoxShadow(
//                                 color: AppColors.black,
//                                 blurRadius: 5,
//                                 offset: Offset(2.0, 5.0))
//                           ],
//                           color: Colors.black,
//                           gradient: LinearGradient(
//                             colors: [
//                               AppColors.baseColor,
//                               AppColors.buttonOrange,
//                               AppColors.baseColor,
//                             ],
//                           )),
//                       child: const Row(children: [
//                         Expanded(
//                           child: Align(
//                             alignment: Alignment.center,
//                             child: Text(
//                               "Save",
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

//   Future deny(var data, int ind, String userName, String status) => showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//               title: Column(
//                 children: [
//                   Text(
//                     'Are you sure you want to ${data} this user?',
//                     style: const TextStyle(
//                         color: AppColors.baseColor,
//                         fontWeight: FontWeight.bold),
//                   ),
//                 ],
//               ),
//               actions: [
//                 Padding(
//                   padding: const EdgeInsets.only(bottom: 15.0, left: 60),
//                   child: Align(
//                     alignment: Alignment.centerRight,
//                     child: Row(
//                       children: [
//                         InkWell(
//                           onTap: (() {
//                             if (data == 'DENY') {
//                               addCrewMemberViewModel
//                                   .addCrewMemberTabularData
//                                   .data!
//                                   .getaAllCewMemberTableDatas![ind]
//                                   .status = 'PENDING';
//                             } else {
//                               addCrewMemberViewModel
//                                   .addCrewMemberTabularData
//                                   .data!
//                                   .getaAllCewMemberTableDatas![ind]
//                                   .status = 'ACTIVE';
//                             }
//                             addCrewMemberViewModel
//                                 .fetchApproveCIVMUpdatePutListApi(
//                                     context,
//                                     (data == 'DENY') ? 'PENDING' : 'ACTIVE',
//                                     userName);
//                             Navigator.of(context).pop();
//                           }),
//                           child: Container(
//                             width: MediaQuery.of(context).size.width * 0.2,
//                             height: MediaQuery.of(context).size.height * 0.052,
//                             decoration: const BoxDecoration(
//                                 // shape: BoxShape.circle,

//                                 boxShadow: [
//                                   BoxShadow(
//                                       color: Color.fromARGB(255, 142, 209, 145),
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
//                                     "Yes",
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
//                         ),
//                         InkWell(
//                           onTap: (() {
//                             Navigator.of(context).pop();
//                           }),
//                           child: Padding(
//                             padding: const EdgeInsets.only(left: 20.0),
//                             child: Container(
//                               width: MediaQuery.of(context).size.width * 0.2,
//                               height:
//                                   MediaQuery.of(context).size.height * 0.052,
//                               decoration: const BoxDecoration(
//                                   // shape: BoxShape.circle,

//                                   boxShadow: [
//                                     BoxShadow(
//                                         color:
//                                             Color.fromARGB(255, 253, 138, 176),
//                                         blurRadius: 5,
//                                         offset: Offset(2.0, 5.0))
//                                   ],
//                                   color: Colors.black,
//                                   gradient: LinearGradient(
//                                     colors: [
//                                       Colors.red,
//                                       Colors.red,
//                                     ],
//                                   )),
//                               child: const Row(children: [
//                                 Expanded(
//                                   child: Align(
//                                     alignment: Alignment.center,
//                                     child: Text(
//                                       "Cancel",
//                                       textAlign: TextAlign.left,
//                                       style: TextStyle(
//                                         color: Colors.white,
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 20,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ]),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 )
//               ]));

//   DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
//       value: item,
//       child: Text(item,
//           style: const TextStyle(
//             fontWeight: FontWeight.normal,
//             fontSize: 20,
//           )));

//   Future<void> setDataCrew() async {
//     final userPreferences = Provider.of<UserPref>(context, listen: false);
//     UserModel data = await userPreferences.getUser();
//     _email.text = data.user!.email.toString();
//     _password.text = data.user!.password.toString();
//   }

//   Future<bool> createCrew(
//     BuildContext context,
//     Map<String, dynamic> mappedData,
//   ) async {
//     try {
//       final response = await http.post(
//         Uri.parse('https://atsdev3test.ariespro.com/main/create_crew'),
//         headers: {
//           'Content-Type': 'application/json',
//         },
//         body: jsonEncode(mappedData),
//       );

//       final decoded = jsonDecode(response.body);

//       // ✅ SUCCESS
//       if (response.statusCode >= 200 && response.statusCode < 300) {
//         if (context.mounted) {
//           CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
//             decoded['message'] ?? 'Crew Inserted Successfully!',
//             context,
//           );
//           addCrewMemberViewModel.fetchAddCrewMemberTabularListApi(context);
//           Future.delayed(const Duration(seconds: 5), () {
//             if (context.mounted) {
//               Navigator.of(context, rootNavigator: true).pop();
//               Navigator.of(context, rootNavigator: true).pop();
//             }
//           });
//           // Navigator.pop(context);
//           // Navigator.pop(context);
//         }
//         return true;
//       }

//       // ❌ ERROR
//       else {
//         if (context.mounted) {
//           CustomToastSnackBarProgressDialog.flushBarErrorMessage(
//             decoded['message'] ?? 'Something went wrong',
//             context,
//           );
//         }
//         return false;
//       }
//     } catch (e) {
//       if (context.mounted) {
//         CustomToastSnackBarProgressDialog.flushBarErrorMessage(
//           'Network error. Please try again.',
//           context,
//         );
//       }
//       return false;
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
//     var provider = Provider.of<LocationProviderPemc>(context, listen: true);
//     final browser = MyChromeSafariBrowser();
//     return Drawer(
//       child: SafeArea(
//         child: Column(
//           // Important: Remove any padding from the ListView.
//           // padding: EdgeInsets.zero,
//           children: [
//             Container(
//               width: double.infinity,
//               height: 180,
//               color: AppColors.lighterBaseColor,
//               padding: const EdgeInsets.only(top: 24),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                     MenuLogo(),
//                   const SizedBox(height: 6),
//                   Text(
//                     userName,
//                     style: const TextStyle(fontSize: 18, color: Colors.white),
//                   ),
//                 ],
//               ),
//             ),
//             Expanded(
//               child: ListView(
//                 children: [
//                   ListTile(
//                     leading: const Icon(
//                       Icons.computer,
//                     ),
//                     title: const Text('General Foreman / Dispatch Dashboard'),
//                     textColor: AppColors.baseColor,
//                     iconColor: AppColors.baseColor,
//                     onTap: () {
//                       Navigator.of(context).push(MaterialPageRoute(
//                           builder: (BuildContext context) =>
//                               const ContractorDispatchDashboard()));
//                     },
//                   ),
//                   // ListTile(
//                   //   leading: const Icon(
//                   //     Icons.open_in_browser,
//                   //   ),
//                   //   title: const Text('Change Order Pending'),
//                   //   textColor: AppColors.baseColor,
//                   //   iconColor: AppColors.baseColor,
//                   //   onTap: () {
//                   //     Navigator.of(context).push(MaterialPageRoute(
//                   //         builder: (BuildContext context) =>
//                   //             const WorkOrderPendingContractor()));
//                   //   },
//                   // ),
//                   // Visibility(
//                   //   visible: (widget.menu.isNotEmpty &&
//                   //           widget.menu.contains('Energy Audit Ticket'))
//                   //       ? true
//                   //       : false,
//                   // child:
//                   // ListTile(
//                   //   leading: const Icon(
//                   //     Icons.pending,
//                   //   ),
//                   //   title: const Text('IVM Maintenance Progress'),
//                   //   textColor: AppColors.baseColor,
//                   //   iconColor: AppColors.baseColor,
//                   //   onTap: () {
//                   //     Navigator.of(context).push(MaterialPageRoute(
//                   //         builder: (BuildContext context) =>
//                   //             const RowMaintenanceProgressContractor()));
//                   //   },
//                   // ),
//                   // ),
//                   // ListTile(
//                   //   leading: const Icon(
//                   //     Icons.report,
//                   //   ),
//                   //   title: const Text('Maintenance Report View'),
//                   //   textColor: AppColors.baseColor,
//                   //   iconColor: AppColors.baseColor,
//                   //   onTap: () {
//                   //     Navigator.of(context).push(MaterialPageRoute(
//                   //         builder: (BuildContext context) =>
//                   //             const GfMaintenanceReportViewNew()));
//                   //   },
//                   // ),
//                   ListTile(
//                     leading: const Icon(
//                       Icons.closed_caption_off,
//                     ),
//                     title: const Text('IVM/Herbicide/Change Order'),
//                     textColor: AppColors.baseColor,
//                     iconColor: AppColors.baseColor,
//                     onTap: () {
//                       // Navigator.of(context).push(MaterialPageRoute(
//                       //     builder: (BuildContext context) =>
//                       //         const ChangeOrderContractor()));
//                       Navigator.of(context).push(MaterialPageRoute(
//                           builder: (BuildContext context) =>
//                               const Inspection()));
//                     },
//                   ),

//                   // ListTile(
//                   //   leading: const Icon(
//                   //     Icons.inventory,
//                   //   ),
//                   //   title: const Text('Daily Herbicide Application Form'),
//                   //   textColor: AppColors.baseColor,
//                   //   iconColor: AppColors.baseColor,
//                   //   onTap: () {
//                   //     Navigator.of(context).push(MaterialPageRoute(
//                   //         builder: (BuildContext context) =>
//                   //             const DailyHerbicideApplicationFormContractor()));
//                   //   },
//                   // ),

//                   // ListTile(
//                   //   leading: const Icon(
//                   //     Icons.list_alt,
//                   //   ),
//                   //   title: const Text('Power Time Form'),
//                   //   textColor: AppColors.baseColor,
//                   //   iconColor: AppColors.baseColor,
//                   //   onTap: () {
//                   //     Navigator.of(context).push(MaterialPageRoute(
//                   //         builder: (BuildContext context) =>
//                   //             const PowerTimeFormContractor()));
//                   //   },
//                   // ),

//                   // ListTile(
//                   //   leading: const Icon(
//                   //     Icons.list_alt,
//                   //   ),
//                   //   title: const Text('Invoice Form'),
//                   //   textColor: AppColors.baseColor,
//                   //   iconColor: AppColors.baseColor,
//                   //   onTap: () {
//                   //     Navigator.of(context).push(MaterialPageRoute(
//                   //         builder: (BuildContext context) =>
//                   //             const InvoiceFormContractor()));
//                   //   },
//                   // ),
//                   // ListTile(
//                   //   leading: const Icon(
//                   //     Icons.list_alt,
//                   //   ),
//                   //   title: const Text('Mixing Inventory Form'),
//                   //   textColor: AppColors.baseColor,
//                   //   iconColor: AppColors.baseColor,
//                   //   onTap: () {
//                   //     Navigator.of(context).push(MaterialPageRoute(
//                   //         builder: (BuildContext context) =>
//                   //             const MixingInventoryFormContractor()));
//                   //   },
//                   // ),
//                   // ListTile(
//                   //   leading: const Icon(
//                   //     Icons.pin_invoke_outlined,
//                   //   ),
//                   //   title: const Text('Create Invoice'),
//                   //   textColor: AppColors.baseColor,
//                   //   iconColor: AppColors.baseColor,
//                   //   onTap: () {
//                   //     Navigator.of(context).push(MaterialPageRoute(
//                   //         builder: (BuildContext context) =>
//                   //             const CreateInvoiceContractor()));
//                   //   },
//                   // ),
//                   // ListTile(
//                   //     leading: const Icon(
//                   //       Icons.list,
//                   //     ),
//                   //     title: const Text('Invoice List'),
//                   //     textColor: AppColors.baseColor,
//                   //     iconColor: AppColors.baseColor,
//                   //     onTap: () {
//                   //       Navigator.of(context).push(MaterialPageRoute(
//                   //           builder: (BuildContext context) =>
//                   //               const InvoiceListContrator()));
//                   //     }),
//                   ListTile(
//                       leading: const Icon(
//                         Icons.map,
//                       ),
//                       title: const Text('IVM Offline Map'),
//                       textColor: AppColors.baseColor,
//                       iconColor: AppColors.baseColor,
//                       onTap: () async {
//                         String id = '';
//                         final userPreferences1 =
//                             Provider.of<UserPref>(context, listen: false);
//                         UserModel data = await userPreferences1.getUser();
//                         id = data.user!.id.toString();
//                         // Navigator.push(
//                         //   context,
//                         //   MaterialPageRoute(
//                         //     builder: (context) => MapViewPage(
//                         //       url:
//                         //           "https://atsdev3test.ariespro.com/main/ivm_map_view/CIVM_Map/USRQWXH589Z/$id",
//                         //     ),
//                         //   ),
//                         // );
//                         await browser.open(
//                             url: WebUri(
//                                 "https://atsdev3test.ariespro.com/main/ivm_map_view/CIVM_Map/USRQWXH589Z/$id"),
//                             //crew id in place of id in above line
//                             settings: ChromeSafariBrowserSettings(
//                                 shareState:
//                                     CustomTabsShareState.SHARE_STATE_OFF,
//                                 barCollapsingEnabled: true));
//                       }),
//                   ListTile(
//                       leading: const Icon(
//                         Icons.map_outlined,
//                       ),
//                       title: const Text('Herbicide Offline Map'),
//                       textColor: AppColors.baseColor,
//                       iconColor: AppColors.baseColor,
//                       onTap: () async {
//                         String id = '';
//                         final userPreferences1 =
//                             Provider.of<UserPref>(context, listen: false);
//                         UserModel data = await userPreferences1.getUser();
//                         id = data.user!.id.toString();
//                         //   Navigator.push(
//                         //   context,
//                         //   MaterialPageRoute(
//                         //     builder: (context) => MapViewPage(
//                         //       url:
//                         //           "https://atsdev3test.ariespro.com/main/mid_cycle/CIVM_Map/USRQWXH589Z/$id",
//                         //     ),
//                         //   ),
//                         // );
//                         await browser.open(
//                             url: WebUri(
//                                 "https://atsdev3test.ariespro.com/main/mid_cycle/CIVM_Map/USRQWXH589Z/$id"),
//                             //crew id in place of id in above line
//                             settings: ChromeSafariBrowserSettings(
//                                 shareState:
//                                     CustomTabsShareState.SHARE_STATE_OFF,
//                                 barCollapsingEnabled: true));
//                       }),
//                   ListTile(
//                       leading: const Icon(
//                         Icons.location_searching,
//                       ),
//                       title: const Text('Change Order Offline Map'),
//                       textColor: AppColors.baseColor,
//                       iconColor: AppColors.baseColor,
//                       onTap: () async {
//                         String id = '';
//                         final userPreferences1 =
//                             Provider.of<UserPref>(context, listen: false);
//                         UserModel data = await userPreferences1.getUser();
//                         id = data.user!.id.toString();
//                         //    Navigator.push(
//                         //   context,
//                         //   MaterialPageRoute(
//                         //     builder: (context) => MapViewPage(
//                         //       url:
//                         //           "https://atsdev3test.ariespro.com/main/change_order_view/CIVM_Map/USRQWXH589Z/$id",
//                         //     ),
//                         //   ),
//                         // );
//                         await browser.open(
//                             url: WebUri(
//                                 "https://atsdev3test.ariespro.com/main/change_order_view/CIVM_Map/USRQWXH589Z/$id"),
//                             //crew id in place of id in above line
//                             settings: ChromeSafariBrowserSettings(
//                                 shareState:
//                                     CustomTabsShareState.SHARE_STATE_OFF,
//                                 barCollapsingEnabled: true));
//                       }),
//                   ListTile(
//                     leading: Icon(
//                       Icons.location_on,
//                     ),
//                     title: const Text('Live IVM System Map'),
//                     textColor: AppColors.baseColor,
//                     iconColor: AppColors.baseColor,
//                     onTap: () {
//                       provider.getLocation();
//                       Navigator.of(context).push(MaterialPageRoute(
//                           builder: (context) => const MapScreenLeafLat()));
//                     },
//                   ),
                
//                   ListTile(
//                     leading: const Icon(
//                       Icons.logout,
//                     ),
//                     title: const Text('Log Out'),
//                     textColor: AppColors.baseColor,
//                     iconColor: AppColors.baseColor,
//                     onTap: () {
//                       // // Constants.prefs.setBool("LoggedIn", false);
//                       userPreferences.remove().then((value) {
//                         Navigator.of(context).push(MaterialPageRoute(
//                             builder: (BuildContext context) =>
//                                 const LoginPagePemc()));
//                       });
//                       // Navigator.of(context).pushReplacement(MaterialPageRoute(
//                       //     builder: (BuildContext context) => const LoginPage()));
//                     },
//                   ),
//                 ],
//               ),
//             ),
//             Container(
//               padding: const EdgeInsets.symmetric(vertical: 12),
//               alignment: Alignment.center,
//               child: Column(
//                 children: [
//                   Text(
//                     'Version: ${Constants.prefs.getString('VERSION') ?? ''}',
//                     style: const TextStyle(
//                       fontSize: 13,
//                       color: Colors.grey,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                   Text(
//                     'Updated: ${Constants.prefs.getString('VERSION_DATE') ?? ''}',
//                     style: const TextStyle(
//                       fontSize: 13,
//                       color: Colors.grey,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Future<void> setUserName() async {
//     final userPreferences = Provider.of<UserPref>(context, listen: false);
//     UserModel data = await userPreferences.getUser();
//     Image.network(
//       'https://atsdev2test.ariespro.com/assets/clientuploads/${data.user!.profilePhoto}',
//     );
//     String imageUrl =
//         'https://atsdev2test.ariespro.com/assets/clientuploads/${data.user!.profilePhoto}';
//     _imagePath = imageUrl;
//     setState(() {
//       userName = '${data.user!.fName} ${data.user!.lName}';
//     });
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

// class ChartData {
//   ChartData(this.x, this.y, this.color);
//   final String x;
//   final double y;
//   final Color color;
// }

// // class _ChartDataSimpleColumnChart1 {
// //   _ChartDataSimpleColumnChart1(this.x, this.y1,this.y2,this.y3);

// //   final String x;
// //   final double y1;
// //    final String y2;
// //     final String y3;
// //   // final Color? color;
// // }
// class _ChartDataSimpleColumnChart1 {
//   _ChartDataSimpleColumnChart1(this.x, this.y1);

//   final String x;
//   final double y1;
//   // final Color? color;
// }

// //new
// class ChartDataNew {
//   final String month;
//   final int miles;

//   ChartDataNew(this.month, this.miles);
// }

// // ignore: must_be_immutable
// class DashboardCard extends StatefulWidget {
//   String cardTitle;
//   String cardCount;
//   dynamic cardIcon;
//   Color? iconColor;
//   Color? cardColor;

//   DashboardCard({
//     Key? key,
//     required this.cardTitle,
//     required this.cardCount,
//     this.cardIcon,
//     this.iconColor,
//     this.cardColor,
//   }) : super(key: key);

//   @override
//   State<DashboardCard> createState() => _DashboardCardState();
// }

// class _DashboardCardState extends State<DashboardCard> {
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Container(
//         margin: const EdgeInsets.only(top: 10),
//         padding: const EdgeInsets.only(top: 8, bottom: 8, left: 8, right: 8),
//         alignment: Alignment.center,
//         width: size.width * 0.425,
//         height: MediaQuery.of(context).size.height * 0.12,
//         decoration: BoxDecoration(
//           color: widget.cardColor,
//           // shape: BoxShape.circle,
//           borderRadius: BorderRadius.circular(10),
//           boxShadow: const [
//             BoxShadow(
//                 color: Colors.black, blurRadius: 5, offset: Offset(0.0, 2.0))
//           ],
//           // gradient:  LinearGradient(
//           //   colors: [
//           //      cardColor,
//           //      cardColor
//           //     //  Color.fromARGB(255, 255, 255, 255),
//           //     //  Color.fromARGB(255, 255, 255, 255),
//           //   ],
//           // )
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               widget.cardTitle,
//               textAlign: TextAlign.center,
//               style: const TextStyle(
//                   fontSize: 16,
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold),
//             ),
//             Text(
//               widget.cardCount,
//               style: const TextStyle(
//                   fontSize: 18,
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold),
//             ),
//           ],
//         ));
//   }
// }
