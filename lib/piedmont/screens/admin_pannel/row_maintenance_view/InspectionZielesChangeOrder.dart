// import 'package:CIVM/piedmont/screens/admin_pannel/row_maintenance_view/total_order_cancelled_CO.dart';
// import 'package:CIVM/piedmont/screens/admin_pannel/row_maintenance_view/total_work_for_approval_CO.dart';
// import 'package:CIVM/piedmont/screens/admin_pannel/row_maintenance_view/zielies_document_approval_pending_CO.dart';
// import 'package:CIVM/piedmont/screens/admin_pannel/row_maintenance_view/zielies_total_order_reject_CO.dart';
// import 'package:CIVM/piedmont/screens/admin_pannel/row_maintenance_view/zielies_total_orders_closed_CO.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../../data/response/status.dart';
// import '../../../view_model/lcp_view_model.dart';
// import 'package:CIVM/piedmont/resources/app_colors.dart';

// class InspectionZieliesChangeOrder extends StatefulWidget {
//   const InspectionZieliesChangeOrder({Key? key}) : super(key: key);

//   @override
//   State<InspectionZieliesChangeOrder> createState() =>
//       _InspectionZieliesChangeOrderState();
// }

// class _InspectionZieliesChangeOrderState
//     extends State<InspectionZieliesChangeOrder> {
//   // int _currentIndex = 0;
//   // final List<Widget> _children = [
//   //   RowMaintenancePlan(),
//   //   // BottomNavigationHomePage(),
//   //   // BottomNavigationAccountPage()
//   // ];
//   List<String> menu = [];

//   onTappedBar(int index) {
//     setState(() {
//       // _currentIndex = index;
//     });
//   }

//   LCPViewModel lCPViewModel = LCPViewModel();

//   @override
//   void initState() {
//     lCPViewModel.fetchLCPcountApi(
//         context, 'PEMC', '', '', 'Change Order', '', '');
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//         backgroundColor: AppColors.backgroundColor,
//         appBar: AppBar(
//           iconTheme: const IconThemeData(color: Colors.white),
//           title: const Text(
//             'PEMC (Change Order)',
//             style: TextStyle(color: Colors.white),
//           ),
//           backgroundColor: AppColors.baseColor,
//         ),
//         // drawer: DrawerManu(menu: menu),
//         body: ChangeNotifierProvider<LCPViewModel>(
//             create: (BuildContext context) => lCPViewModel,
//             child: Consumer<LCPViewModel>(builder: (context, value, _) {
//               switch (value.lcpCountList.status) {
//                 case Status.LOADING:
//                   return const Center(child: CircularProgressIndicator());
//                 case Status.ERROR:
//                   return
//                       // CustomToastSnackBarProgressDialog.flushBarErrorMessage(
//                       //     value.lcpCountList.message.toString(), context);
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
//                       await lCPViewModel.fetchLCPcountApi(
//                           context, 'PEMC', '', '', 'Change Order', '', '');
//                     },
//                     child: Stack(fit: StackFit.expand, children: [
//                       SingleChildScrollView(
//                         physics: const AlwaysScrollableScrollPhysics(),
//                         child: Padding(
//                           padding: const EdgeInsets.all(4.0),
//                           child: Column(
//                             children: [
//                               // Container(
//                               //   margin: const EdgeInsets.only(
//                               //       left: 8, right: 8, top: 10, bottom: 8),
//                               //   decoration: const BoxDecoration(
//                               //       // shape: BoxShape.circle,
//                               //       borderRadius: BorderRadius.only(
//                               //           // topRight: Radius.circular(50),
//                               //           // bottomLeft: Radius.circular(50)
//                               //           ),
//                               //       boxShadow: [
//                               //         BoxShadow(
//                               //             color: Color.fromARGB(255, 3, 47, 97),
//                               //             blurRadius: 5,
//                               //             offset: Offset(2.0, 5.0))
//                               //       ],
//                               //       color: Color.fromARGB(255, 130, 193, 245),
//                               //       gradient: LinearGradient(
//                               //         colors: [
//                               //           AppColors.baseColor,
//                               //           AppColors.buttonOrange,
//                               //         ],
//                               //       )),
//                               //   child: InkWell(
//                               //     onTap: () {
//                               //       Navigator.of(context).push(MaterialPageRoute(
//                               //           builder: (BuildContext context) =>
//                               //               ZIELIESCreateOrderWithoutData(
//                               //                   subStation: '',
//                               //                   serviceStreetAddress: '',
//                               //                   serviceMapLocation: '',
//                               //                   notes: '',
//                               //                   type: '',
//                               //                   maintType: '',
//                               //                   contractorCompany: '',
//                               //                   assignForeman: '')));
//                               //     },
//                               //     child: Container(
//                               //         decoration: BoxDecoration(
//                               //           border: Border.all(
//                               //             color: Colors.white,
//                               //           ),
//                               //           boxShadow: const [
//                               //             BoxShadow(
//                               //                 color:
//                               //                     Color.fromARGB(255, 3, 47, 97),
//                               //                 blurRadius: 10,
//                               //                 offset: Offset(2.0, 5.0))
//                               //           ],
//                               //           image: DecorationImage(
//                               //             image: const AssetImage(
//                               //                 'assets/Dash_6.jpg'),
//                               //             fit: BoxFit.cover,
//                               //             colorFilter: ColorFilter.mode(
//                               //                 Colors.black.withOpacity(0.45),
//                               //                 BlendMode.darken),
//                               //           ),
//                               //         ),
//                               //         margin: const EdgeInsets.only(
//                               //             left: 8, right: 8, top: 10, bottom: 8),
//                               //         padding: const EdgeInsets.all(8),
//                               //         alignment: Alignment.center,
//                               //         height: size.height * 0.15,
//                               //         width: size.width * 0.99,
//                               //         child: const Stack(children: [
//                               //           Text(
//                               //             'Create a Change Order(Real Time)',
//                               //             style: TextStyle(
//                               //                 fontSize: 22,
//                               //                 color: Colors.white,
//                               //                 fontWeight: FontWeight.w800),
//                               //           ),
//                               //         ])),
//                               //   ),
//                               // ),

//                               // Container(
//                               //   margin: const EdgeInsets.only(
//                               //       left: 8, right: 8, top: 10, bottom: 8),
//                               //   decoration: const BoxDecoration(
//                               //       // shape: BoxShape.circle,
//                               //       borderRadius: BorderRadius.only(
//                               //           // topRight: Radius.circular(50),
//                               //           // bottomLeft: Radius.circular(50)
//                               //           ),
//                               //       boxShadow: [
//                               //         BoxShadow(
//                               //             color: Color.fromARGB(255, 3, 47, 97),
//                               //             blurRadius: 5,
//                               //             offset: Offset(2.0, 5.0))
//                               //       ],
//                               //       color: Color.fromARGB(255, 130, 193, 245),
//                               //       gradient: LinearGradient(
//                               //         colors: [
//                               //           AppColors.baseColor,
//                               //           AppColors.buttonOrange,
//                               //         ],
//                               //       )),
//                               //   child: InkWell(
//                               //     onTap: () {
//                               //       Navigator.of(context).push(MaterialPageRoute(
//                               //           builder: (BuildContext context) =>
//                               //               ZIELIESTotalOrderPending(
//                               //                   budgetType: '',
//                               //                   maintenanceType:
//                               //                       'Change Order',
//                               //                       heading: 'Change Order',)));
//                               //     },
//                               //     child: Container(
//                               //         decoration: BoxDecoration(
//                               //           border: Border.all(
//                               //             color: Colors.white,
//                               //           ),
//                               //           boxShadow: const [
//                               //             BoxShadow(
//                               //                 color:
//                               //                     Color.fromARGB(255, 3, 47, 97),
//                               //                 blurRadius: 10,
//                               //                 offset: Offset(2.0, 5.0))
//                               //           ],
//                               //           image: DecorationImage(
//                               //             image: const AssetImage(
//                               //                 'assets/Dash_2.jpg'),
//                               //             fit: BoxFit.cover,
//                               //             colorFilter: ColorFilter.mode(
//                               //                 Colors.black.withOpacity(0.45),
//                               //                 BlendMode.darken),
//                               //           ),
//                               //         ),
//                               //         margin: const EdgeInsets.only(
//                               //             left: 8, right: 8, top: 10, bottom: 8),
//                               //         padding: const EdgeInsets.all(8),
//                               //         alignment: Alignment.center,
//                               //         height: size.height * 0.15,
//                               //         width: size.width * 0.99,
//                               //         child: Stack(children: [
//                               //           Row(
//                               //             children: [
//                               //               const Expanded(
//                               //                 child: Text(
//                               //                   'Total Inspection (Pending)',
//                               //                   style: TextStyle(
//                               //                       fontSize: 22,
//                               //                       color: Colors.white,
//                               //                       fontWeight: FontWeight.w800),
//                               //                 ),
//                               //               ),
//                               //               Text(
//                               //                 (lCPViewModel.lcpCountList.data!
//                               //                             .countOfPendingOrder![0]
//                               //                             .toString() ==
//                               //                         'null')
//                               //                     ? ''
//                               //                     : lCPViewModel
//                               //                         .lcpCountList
//                               //                         .data!
//                               //                         .countOfPendingOrder![0]
//                               //                         .toString(),
//                               //                 style: const TextStyle(
//                               //                     fontSize: 22,
//                               //                     color: Colors.white,
//                               //                     fontWeight: FontWeight.w800),
//                               //               ),
//                               //             ],
//                               //           )
//                               //         ])),
//                               //   ),
//                               // ),

//                               Container(
//                                 margin: const EdgeInsets.only(
//                                     left: 8, right: 8, top: 10, bottom: 8),
//                                 decoration: const BoxDecoration(
//                                     // shape: BoxShape.circle,
//                                     borderRadius: BorderRadius.only(
//                                         // topRight: Radius.circular(50),
//                                         // bottomLeft: Radius.circular(50)
//                                         ),
//                                     boxShadow: [
//                                       BoxShadow(
//                                           color: AppColors.black,
//                                           blurRadius: 5,
//                                           offset: Offset(2.0, 5.0))
//                                     ],
//                                     color: Color.fromARGB(255, 130, 193, 245),
//                                     gradient: LinearGradient(
//                                       colors: [
//                                         AppColors.baseColor,
//                                         AppColors.buttonOrange,
//                                       ],
//                                     )),
//                                 child: InkWell(
//                                   onTap: () {
//                                     Navigator.of(context).push(
//                                         MaterialPageRoute(
//                                             builder: (BuildContext context) =>
//                                                 ZIELIESTotalOrderRejectCO(
//                                                   budgetType: '',
//                                                   maintenanceType:
//                                                       'Change Order',
//                                                   heading: 'CO',
//                                                 )));
//                                   },
//                                   child: Container(
//                                       decoration: BoxDecoration(
//                                         border: Border.all(
//                                           color: Colors.white,
//                                         ),
//                                         boxShadow: const [
//                                           BoxShadow(
//                                               color: Color.fromARGB(
//                                                   255, 3, 47, 97),
//                                               blurRadius: 10,
//                                               offset: Offset(2.0, 5.0))
//                                         ],
//                                         image: DecorationImage(
//                                           image: const AssetImage(
//                                               'assets/Dash_4.jpg'),
//                                           fit: BoxFit.cover,
//                                           colorFilter: ColorFilter.mode(
//                                               Colors.black.withOpacity(0.45),
//                                               BlendMode.darken),
//                                         ),
//                                       ),
//                                       margin: const EdgeInsets.only(
//                                           left: 8,
//                                           right: 8,
//                                           top: 10,
//                                           bottom: 8),
//                                       padding: const EdgeInsets.all(8),
//                                       alignment: Alignment.center,
//                                       height: size.height * 0.15,
//                                       width: size.width * 0.99,
//                                       child: Stack(children: [
//                                         Row(
//                                           children: [
//                                             const Expanded(
//                                               child: Text(
//                                                 'Total Inspection (Reject)',
//                                                 style: TextStyle(
//                                                     fontSize: 22,
//                                                     color: Colors.white,
//                                                     fontWeight:
//                                                         FontWeight.w800),
//                                               ),
//                                             ),
//                                             Text(
//                                               (lCPViewModel
//                                                           .lcpCountList
//                                                           .data!
//                                                           .countOfRejectOrder![
//                                                               0]
//                                                           .toString() ==
//                                                       'null')
//                                                   ? ''
//                                                   : lCPViewModel
//                                                       .lcpCountList
//                                                       .data!
//                                                       .countOfRejectOrder![0]
//                                                       .toString(),
//                                               style: const TextStyle(
//                                                   fontSize: 22,
//                                                   color: Colors.white,
//                                                   fontWeight: FontWeight.w800),
//                                             ),
//                                           ],
//                                         )
//                                       ])),
//                                 ),
//                               ),
//                               Container(
//                                 margin: const EdgeInsets.only(
//                                     left: 8, right: 8, top: 10, bottom: 8),
//                                 decoration: const BoxDecoration(
//                                     // shape: BoxShape.circle,
//                                     borderRadius: BorderRadius.only(
//                                         // topRight: Radius.circular(50),
//                                         // bottomLeft: Radius.circular(50)
//                                         ),
//                                     boxShadow: [
//                                       BoxShadow(
//                                           color: AppColors.black,
//                                           blurRadius: 5,
//                                           offset: Offset(2.0, 5.0))
//                                     ],
//                                     color: Color.fromARGB(255, 130, 193, 245),
//                                     gradient: LinearGradient(
//                                       colors: [
//                                         AppColors.baseColor,
//                                         AppColors.buttonOrange,
//                                       ],
//                                     )),
//                                 child: InkWell(
//                                   onTap: () {
//                                     Navigator.of(context).push(
//                                         MaterialPageRoute(
//                                             builder: (BuildContext context) =>
//                                                 WorkForApprovalAdminCO(
//                                                   budgetType: '',
//                                                   maintenanceType:
//                                                       'Change Order',
//                                                   heading:
//                                                       'CO - Total Inspection (Work For Approval)',
//                                                 )));
//                                   },
//                                   child: Container(
//                                       decoration: BoxDecoration(
//                                         border: Border.all(
//                                           color: Colors.white,
//                                         ),
//                                         boxShadow: const [
//                                           BoxShadow(
//                                               color: Color.fromARGB(
//                                                   255, 3, 47, 97),
//                                               blurRadius: 10,
//                                               offset: Offset(2.0, 5.0))
//                                         ],
//                                         image: DecorationImage(
//                                           image: const AssetImage(
//                                               'assets/Dash_5.jpg'),
//                                           fit: BoxFit.cover,
//                                           colorFilter: ColorFilter.mode(
//                                               Colors.black.withOpacity(0.45),
//                                               BlendMode.darken),
//                                         ),
//                                       ),
//                                       margin: const EdgeInsets.only(
//                                           left: 8,
//                                           right: 8,
//                                           top: 10,
//                                           bottom: 8),
//                                       padding: const EdgeInsets.all(8),
//                                       alignment: Alignment.center,
//                                       height: size.height * 0.15,
//                                       width: size.width * 0.99,
//                                       child: Stack(children: [
//                                         Row(
//                                           children: [
//                                             const Expanded(
//                                               child: Text(
//                                                 'Total Inspection (Work For Approval)',
//                                                 style: TextStyle(
//                                                     fontSize: 22,
//                                                     color: Colors.white,
//                                                     fontWeight:
//                                                         FontWeight.w800),
//                                               ),
//                                             ),
//                                             Text(
//                                               (lCPViewModel
//                                                           .lcpCountList
//                                                           .data!
//                                                           .countOfWorkForApprovalOrder![
//                                                               0]
//                                                           .toString() ==
//                                                       'null')
//                                                   ? ''
//                                                   : lCPViewModel
//                                                       .lcpCountList
//                                                       .data!
//                                                       .countOfWorkForApprovalOrder![
//                                                           0]
//                                                       .toString(),
//                                               style: const TextStyle(
//                                                   fontSize: 22,
//                                                   color: Colors.white,
//                                                   fontWeight: FontWeight.w800),
//                                             ),
//                                           ],
//                                         )
//                                       ])),
//                                 ),
//                               ),
//                               Container(
//                                 margin: const EdgeInsets.only(
//                                     left: 8, right: 8, top: 10, bottom: 8),
//                                 decoration: const BoxDecoration(
//                                     // shape: BoxShape.circle,
//                                     borderRadius: BorderRadius.only(
//                                         // topRight: Radius.circular(50),
//                                         // bottomLeft: Radius.circular(50)
//                                         ),
//                                     boxShadow: [
//                                       BoxShadow(
//                                           color: AppColors.black,
//                                           blurRadius: 5,
//                                           offset: Offset(2.0, 5.0))
//                                     ],
//                                     color: Color.fromARGB(255, 130, 193, 245),
//                                     gradient: LinearGradient(
//                                       colors: [
//                                         AppColors.baseColor,
//                                         AppColors.buttonOrange,
//                                       ],
//                                     )),
//                                 child: InkWell(
//                                   onTap: () {
//                                     Navigator.of(context).push(
//                                         MaterialPageRoute(
//                                             builder: (BuildContext context) =>
//                                                 ZIELIESDocumentApprovalPendingCO(
//                                                   budgetType: '',
//                                                   maintenanceType:
//                                                       'Change Order',
//                                                   heading: 'CO',
//                                                 )));
//                                   },
//                                   child: Container(
//                                       decoration: BoxDecoration(
//                                         border: Border.all(
//                                           color: Colors.white,
//                                         ),
//                                         boxShadow: const [
//                                           BoxShadow(
//                                               color: Color.fromARGB(
//                                                   255, 3, 47, 97),
//                                               blurRadius: 10,
//                                               offset: Offset(2.0, 5.0))
//                                         ],
//                                         image: DecorationImage(
//                                           image: const AssetImage(
//                                               'assets/Dash_3.png'),
//                                           fit: BoxFit.cover,
//                                           colorFilter: ColorFilter.mode(
//                                               Colors.black.withOpacity(0.45),
//                                               BlendMode.darken),
//                                         ),
//                                       ),
//                                       margin: const EdgeInsets.only(
//                                           left: 8,
//                                           right: 8,
//                                           top: 10,
//                                           bottom: 8),
//                                       padding: const EdgeInsets.all(8),
//                                       alignment: Alignment.center,
//                                       height: size.height * 0.15,
//                                       width: size.width * 0.99,
//                                       child: Stack(children: [
//                                         Row(
//                                           children: [
//                                             const Expanded(
//                                               child: Text(
//                                                 'Inspection Approval (Pending)',
//                                                 style: TextStyle(
//                                                     fontSize: 22,
//                                                     color: Colors.white,
//                                                     fontWeight:
//                                                         FontWeight.w800),
//                                               ),
//                                             ),
//                                             Text(
//                                               (lCPViewModel
//                                                           .lcpCountList
//                                                           .data!
//                                                           .countOfPendingApprovalOrder![
//                                                               0]
//                                                           .toString() ==
//                                                       'null')
//                                                   ? ''
//                                                   : lCPViewModel
//                                                       .lcpCountList
//                                                       .data!
//                                                       .countOfPendingApprovalOrder![
//                                                           0]
//                                                       .toString(),
//                                               style: const TextStyle(
//                                                   fontSize: 22,
//                                                   color: Colors.white,
//                                                   fontWeight: FontWeight.w800),
//                                             ),
//                                           ],
//                                         )
//                                       ])),
//                                 ),
//                               ),
//                               Container(
//                                 margin: const EdgeInsets.only(
//                                     left: 8, right: 8, top: 10, bottom: 8),
//                                 decoration: const BoxDecoration(
//                                     // shape: BoxShape.circle,
//                                     borderRadius: BorderRadius.only(
//                                         // topRight: Radius.circular(50),
//                                         // bottomLeft: Radius.circular(50)
//                                         ),
//                                     boxShadow: [
//                                       BoxShadow(
//                                           color: AppColors.black,
//                                           blurRadius: 5,
//                                           offset: Offset(2.0, 5.0))
//                                     ],
//                                     color: Color.fromARGB(255, 130, 193, 245),
//                                     gradient: LinearGradient(
//                                       colors: [
//                                         AppColors.baseColor,
//                                         AppColors.buttonOrange,
//                                       ],
//                                     )),
//                                 child: InkWell(
//                                   onTap: () {
//                                     Navigator.of(context).push(
//                                         MaterialPageRoute(
//                                             builder: (BuildContext context) =>
//                                                 ZIELIESTotalOrderClosedCO(
//                                                   budgetType: '',
//                                                   maintenanceType:
//                                                       'Change Order',
//                                                   heading: 'CO',
//                                                 )));
//                                   },
//                                   child: Container(
//                                       decoration: BoxDecoration(
//                                         border: Border.all(
//                                           color: Colors.white,
//                                         ),
//                                         boxShadow: const [
//                                           BoxShadow(
//                                               color: Color.fromARGB(
//                                                   255, 3, 47, 97),
//                                               blurRadius: 10,
//                                               offset: Offset(2.0, 5.0))
//                                         ],
//                                         image: DecorationImage(
//                                           image: const AssetImage(
//                                               'assets/Dash_2.jpg'),
//                                           fit: BoxFit.cover,
//                                           colorFilter: ColorFilter.mode(
//                                               Colors.black.withOpacity(0.45),
//                                               BlendMode.darken),
//                                         ),
//                                       ),
//                                       margin: const EdgeInsets.only(
//                                           left: 8,
//                                           right: 8,
//                                           top: 10,
//                                           bottom: 8),
//                                       padding: const EdgeInsets.all(8),
//                                       alignment: Alignment.center,
//                                       height: size.height * 0.15,
//                                       width: size.width * 0.99,
//                                       child: Stack(children: [
//                                         Row(
//                                           children: [
//                                             const Expanded(
//                                               child: Text(
//                                                 'Total Inspection (Completed)',
//                                                 style: TextStyle(
//                                                     fontSize: 22,
//                                                     color: Colors.white,
//                                                     fontWeight:
//                                                         FontWeight.w800),
//                                               ),
//                                             ),
//                                             Text(
//                                               (lCPViewModel.lcpCountList.data!
//                                                           .countOfCloseOrder![0]
//                                                           .toString() ==
//                                                       'null')
//                                                   ? ''
//                                                   : lCPViewModel
//                                                       .lcpCountList
//                                                       .data!
//                                                       .countOfCloseOrder![0]
//                                                       .toString(),
//                                               style: const TextStyle(
//                                                   fontSize: 22,
//                                                   color: Colors.white,
//                                                   fontWeight: FontWeight.w800),
//                                             ),
//                                           ],
//                                         )
//                                       ])),
//                                 ),
//                               ),

//                               Container(
//                                 margin: const EdgeInsets.only(
//                                     left: 8, right: 8, top: 10, bottom: 8),
//                                 decoration: const BoxDecoration(
//                                     // shape: BoxShape.circle,
//                                     borderRadius: BorderRadius.only(
//                                         // topRight: Radius.circular(50),
//                                         // bottomLeft: Radius.circular(50)
//                                         ),
//                                     boxShadow: [
//                                       BoxShadow(
//                                           color: AppColors.black,
//                                           blurRadius: 5,
//                                           offset: Offset(2.0, 5.0))
//                                     ],
//                                     color: Color.fromARGB(255, 130, 193, 245),
//                                     gradient: LinearGradient(
//                                       colors: [
//                                         AppColors.baseColor,
//                                         AppColors.buttonOrange,
//                                       ],
//                                     )),
//                                 child: InkWell(
//                                   onTap: () {
//                                     Navigator.of(context).push(
//                                         MaterialPageRoute(
//                                             builder: (BuildContext context) =>
//                                                 TotalOrderCanceledAdminCO(
//                                                   budgetType: '',
//                                                   maintenanceType:
//                                                       'Change Order',
//                                                   heading:
//                                                       'CO - Total Inspection (Cancelled)',
//                                                 )));
//                                   },
//                                   child: Container(
//                                       decoration: BoxDecoration(
//                                         border: Border.all(
//                                           color: Colors.white,
//                                         ),
//                                         boxShadow: const [
//                                           BoxShadow(
//                                               color: Color.fromARGB(
//                                                   255, 3, 47, 97),
//                                               blurRadius: 10,
//                                               offset: Offset(2.0, 5.0))
//                                         ],
//                                         image: DecorationImage(
//                                           image: const AssetImage(
//                                               'assets/Dash_1.jpg'),
//                                           fit: BoxFit.cover,
//                                           colorFilter: ColorFilter.mode(
//                                               Colors.black.withOpacity(0.45),
//                                               BlendMode.darken),
//                                         ),
//                                       ),
//                                       margin: const EdgeInsets.only(
//                                           left: 8,
//                                           right: 8,
//                                           top: 10,
//                                           bottom: 8),
//                                       padding: const EdgeInsets.all(8),
//                                       alignment: Alignment.center,
//                                       height: size.height * 0.15,
//                                       width: size.width * 0.99,
//                                       child: Stack(children: [
//                                         Row(
//                                           children: [
//                                             const Expanded(
//                                               child: Text(
//                                                 'Total Inspection (Canceled)',
//                                                 style: TextStyle(
//                                                     fontSize: 22,
//                                                     color: Colors.white,
//                                                     fontWeight:
//                                                         FontWeight.w800),
//                                               ),
//                                             ),
//                                             Text(
//                                               (lCPViewModel
//                                                           .lcpCountList
//                                                           .data!
//                                                           .countOfCancelledOrder![
//                                                               0]
//                                                           .toString() ==
//                                                       'null')
//                                                   ? ''
//                                                   : lCPViewModel
//                                                       .lcpCountList
//                                                       .data!
//                                                       .countOfCancelledOrder![0]
//                                                       .toString(),
//                                               style: const TextStyle(
//                                                   fontSize: 22,
//                                                   color: Colors.white,
//                                                   fontWeight: FontWeight.w800),
//                                             ),
//                                           ],
//                                         )
//                                       ])),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ]),
//                   );

//                 default:
//                   return const Text('data');
//               }
//             })));
//   }
// }

