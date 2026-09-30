// import 'package:CIVM/piedmont/resources/app_colors.dart';
// import 'package:CIVM/piedmont/screens/admin_pannel/pemc_admin_new/adm_invoice_list.dart';
// import 'package:CIVM/piedmont/screens/admin_pannel/pemc_admin_new/adm_service_order.dart';
// import 'package:CIVM/piedmont/screens/admin_pannel/row_maintenance_view/add_crew_member.dart';
// import 'package:CIVM/piedmont/screens/admin_pannel/row_maintenance_view/add_new_row_table.dart';
// import 'package:CIVM/piedmont/screens/admin_pannel/row_maintenance_view/approve_civm_access.dart';
// import 'package:CIVM/piedmont/screens/admin_pannel/row_maintenance_view/budget_planning.dart';
// import 'package:CIVM/piedmont/screens/admin_pannel/row_maintenance_view/change_orderOld_inspectionNew.dart';
// import 'package:CIVM/piedmont/screens/admin_pannel/row_maintenance_view/lcp_document_approval_pending.dart';
// import 'package:CIVM/piedmont/screens/admin_pannel/row_maintenance_view/lcp_total_order_closed.dart';
// import 'package:CIVM/piedmont/screens/admin_pannel/row_maintenance_view/lcp_total_order_reject.dart';
// import 'package:CIVM/piedmont/screens/admin_pannel/row_maintenance_view/row_maintenance_plan.dart';
// import 'package:CIVM/piedmont/screens/admin_pannel/row_maintenance_view/ivm_maintenance_progress.dart';
// import 'package:CIVM/piedmont/screens/leaflat_map/leaf_lat_map_wakeLock.dart';
// import 'package:CIVM/piedmont/screens/map/provider/location_provider.dart';
// import 'package:CIVM/piedmont/utils/common_functions.dart';
// import 'package:CIVM/utils/user_pref.dart';
// import 'package:CIVM/models/user_model.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../../data/response/status.dart';
// import '../../../view_model/lcp_view_model.dart';
// import '../../login_page.dart';
// import 'package:CIVM/piedmont/repository/map_url.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// import 'package:CIVM/piedmont/screens/my_chrome_safari_map_recording.dart';

// class InsLCPIVM extends StatefulWidget {
//   const InsLCPIVM({Key? key}) : super(key: key);

//   @override
//   State<InsLCPIVM> createState() => _InsLCPIVMState();
// }

// class _InsLCPIVMState extends State<InsLCPIVM> {
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
//         context, '', '', 'Regular IVM maintenance', 'RegularMaint', '', '');
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
//             'LCP (IVM Maintenance)',
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
//                       await lCPViewModel.fetchLCPcountApi(context, '', '',
//                           'Regular IVM maintenance', 'RegularMaint', '', '');
//                     },
//                     child: Stack(fit: StackFit.expand, children: [
//                       SingleChildScrollView(
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
//                               //           Color.fromARGB(255, 7, 59, 120)
//                               //         ],
//                               //       )),
//                               //   child: InkWell(
//                               //     onTap: () {
//                               //       Navigator.of(context).push(MaterialPageRoute(
//                               //           builder: (BuildContext context) =>
//                               //               LCPTotalOrderPending(
//                               //                 budgetType:
//                               //                     'Regular IVM maintenance',
//                               //                 maintenanceType: 'RegularMaint',
//                               //                 heading: 'IVM Maintenance',
//                               //               )));
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
//                               //                   'Total Order (Pending)',
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
//                                           color: Color.fromARGB(255, 3, 47, 97),
//                                           blurRadius: 5,
//                                           offset: Offset(2.0, 5.0))
//                                     ],
//                                     color: Color.fromARGB(255, 130, 193, 245),
//                                     gradient: LinearGradient(
//                                       colors: [
//                                         AppColors.baseColor,
//                                         Color.fromARGB(255, 7, 59, 120)
//                                       ],
//                                     )),
//                                 child: InkWell(
//                                   onTap: () {
//                                     Navigator.of(context).push(
//                                         MaterialPageRoute(
//                                             builder: (BuildContext context) =>
//                                                 LCPTotalOrderReject(
//                                                   budgetType:
//                                                       'Regular IVM maintenance',
//                                                   maintenanceType:
//                                                       'RegularMaint',
//                                                   heading: 'IVM',
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
//                                                 'Total Order (Reject)',
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
//                                           color: Color.fromARGB(255, 3, 47, 97),
//                                           blurRadius: 5,
//                                           offset: Offset(2.0, 5.0))
//                                     ],
//                                     color: Color.fromARGB(255, 130, 193, 245),
//                                     gradient: LinearGradient(
//                                       colors: [
//                                         AppColors.baseColor,
//                                         Color.fromARGB(255, 7, 59, 120)
//                                       ],
//                                     )),
//                                 child: InkWell(
//                                   onTap: () {
//                                     Navigator.of(context).push(
//                                         MaterialPageRoute(
//                                             builder: (BuildContext context) =>
//                                                 LCPDocumentApprovalPending(
//                                                   budgetType:
//                                                       'Regular IVM maintenance',
//                                                   maintenanceType:
//                                                       'RegularMaint',
//                                                   heading: 'IVM',
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
//                                                 'Document Approval Pending',
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
//                                           color: Color.fromARGB(255, 3, 47, 97),
//                                           blurRadius: 5,
//                                           offset: Offset(2.0, 5.0))
//                                     ],
//                                     color: Color.fromARGB(255, 130, 193, 245),
//                                     gradient: LinearGradient(
//                                       colors: [
//                                         AppColors.baseColor,
//                                         Color.fromARGB(255, 7, 59, 120)
//                                       ],
//                                     )),
//                                 child: InkWell(
//                                   onTap: () {
//                                     Navigator.of(context).push(
//                                         MaterialPageRoute(
//                                             builder: (BuildContext context) =>
//                                                 LCPTotalOrderClosed(
//                                                   budgetType:
//                                                       'Regular IVM maintenance',
//                                                   maintenanceType:
//                                                       'RegularMaint',
//                                                   heading: 'IVM',
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
//                                                 'Total Orders (Closed)',
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
//      final browser = MyChromeSafariBrowser();
//     return Drawer(
//       child: ListView(
//         // Important: Remove any padding from the ListView.
//         padding: EdgeInsets.zero,
//         children: [
//           DrawerHeader(
//             decoration: const BoxDecoration(
//               color: AppColors.lighterBaseColor,
//             ),
//             child: Column(
//               children: [
//                 menuLogo(),
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
//             title: const Text('Row Maintenance Plan'),
//             textColor: AppColors.baseColor,
//             iconColor: AppColors.baseColor,
//             onTap: () {
//               Navigator.of(context).push(MaterialPageRoute(
//                   builder: (BuildContext context) =>
//                       const RowMaintenanceView()));
//             },
//           ),
//           ListTile(
//             leading: const Icon(
//               Icons.compare,
//             ),
//             title: const Text('Inspection'),
//             textColor: AppColors.baseColor,
//             iconColor: AppColors.baseColor,
//             onTap: () {
//               Navigator.of(context).push(MaterialPageRoute(
//                   builder: (BuildContext context) => const ChangeOrder()));
//             },
//           ),
//           ListTile(
//             leading: const Icon(
//               Icons.pending,
//             ),
//             title: const Text('Service Order'),
//             textColor: AppColors.baseColor,
//             iconColor: AppColors.baseColor,
//             onTap: () {
//               Navigator.of(context).push(MaterialPageRoute(
//                   builder: (BuildContext context) => const AdmServiceOrder()));
//             },
//           ),
//           ListTile(
//             leading: const Icon(
//               Icons.airplane_ticket_sharp,
//             ),
//             title: const Text('Job List'),
//             textColor: AppColors.baseColor,
//             iconColor: AppColors.baseColor,
//             onTap: () {
//               Navigator.of(context).push(MaterialPageRoute(
//                   builder: (BuildContext context) =>
//                      AdminAddNewRowTable(index:'0')));
//               // Navigator.of(context).push(MaterialPageRoute(
//               //     builder: (BuildContext context) => AddNewRowMaintenancePlan(
//               //           tokenNo: '',
//               //           index: '0',
//               //           subStation: '',
//               //           feeder: '',
//               //           nextMaintYear: '',
//               //           maintType: '',
//               //           totalMiles: '',
//               //           costPerMile: '',
//               //           totalCost: '',
//               //           budgetType: '',
//               //           contractRowYear: '',
//               //           rowCycle: '',
//               //           rowYear: '',
//               //           contractorCompany: '',
//               //           assignForeman: '',
//               //         )));
//             },
//           ),
//           // Visibility(
//           //   visible: (widget.menu.isNotEmpty &&
//           //           widget.menu.contains('Energy Audit Ticket'))
//           //       ? true
//           //       : false,
//           // child:
//               ///////////new added maps for PEMC
//                   ListTile(
//                     leading: const Icon(
//                       Icons.vertical_distribute,
//                     ),
//                     title: const Text('Add ROW Distribution Map'),
//                     textColor: AppColors.baseColor,
//                     iconColor: AppColors.baseColor,
//                     onTap: () async {
//                       String id = '';
//                       final userPreferences1 =
//                           Provider.of<UserPref>(context, listen: false);
//                       UserModel data = await userPreferences1.getUser();
//                       id = data.user!.id.toString();
//                       await browser.open(
//                           url: WebUri(
//                               MapUrl.getPlannerDistributionMapEndPoint(id)),
//                           settings: ChromeSafariBrowserSettings(
//                               shareState: CustomTabsShareState.SHARE_STATE_OFF,
//                               barCollapsingEnabled: true));
//                     },
//                   ),
//                   ListTile(
//                     leading: const Icon(
//                       Icons.maps_ugc,
//                     ),
//                     title: const Text('Add ROW Transmission Map'),
//                     textColor: AppColors.baseColor,
//                     iconColor: AppColors.baseColor,
//                     onTap: () async {
//                       String id = '';
//                       final userPreferences1 =
//                           Provider.of<UserPref>(context, listen: false);
//                       UserModel data = await userPreferences1.getUser();
//                       id = data.user!.id.toString();
//                       await browser.open(
//                           url: WebUri(
//                               MapUrl.getPlannerTransmissionMapEndPoint(id)),
//                           settings: ChromeSafariBrowserSettings(
//                               shareState: CustomTabsShareState.SHARE_STATE_OFF,
//                               barCollapsingEnabled: true));
//                     },
//                   ),
//                   ListTile(
//                     leading: const Icon(
//                       Icons.map,
//                     ),
//                     title: const Text('Add Herbicide Transmission Map'),
//                     textColor: AppColors.baseColor,
//                     iconColor: AppColors.baseColor,
//                     onTap: () async {
//                       String id = '';
//                       final userPreferences1 =
//                           Provider.of<UserPref>(context, listen: false);
//                       UserModel data = await userPreferences1.getUser();
//                       id = data.user!.id.toString();
//                       await browser.open(
//                           url: WebUri(MapUrl.midTransmissionMapEndPoint(id)),
//                           settings: ChromeSafariBrowserSettings(
//                               shareState: CustomTabsShareState.SHARE_STATE_OFF,
//                               barCollapsingEnabled: true));
//                     },
//                   ),
//                   ListTile(
//                     leading: const Icon(
//                       Icons.maps_ugc_rounded,
//                     ),
//                     title: const Text('Add Annual Herbicide Map'),
//                     textColor: AppColors.baseColor,
//                     iconColor: AppColors.baseColor,
//                     onTap: () async {
//                       String id = '';
//                       final userPreferences1 =
//                           Provider.of<UserPref>(context, listen: false);
//                       UserModel data = await userPreferences1.getUser();
//                       id = data.user!.id.toString();
//                       await browser.open(
//                           url: WebUri(MapUrl.officeTransmissionMapEndPoint(id)),
//                           settings: ChromeSafariBrowserSettings(
//                               shareState: CustomTabsShareState.SHARE_STATE_OFF,
//                               barCollapsingEnabled: true));
//                     },
//                   ),

//                   ////////////////////////////////////
//           ListTile(
//             leading: const Icon(
//               Icons.open_in_new,
//             ),
//             title: const Text('IVM Maintenance Progress'),
//             textColor: AppColors.baseColor,
//             iconColor: AppColors.baseColor,
//             onTap: () {
//               Navigator.of(context).push(MaterialPageRoute(
//                   builder: (BuildContext context) =>
//                       const RowMaintenanceProgress()));
//             },
//           ),
//           // ),
//           // ListTile(
//           //   leading: const Icon(
//           //     Icons.closed_caption_off,
//           //   ),
//           //   title: const Text('Row Analytics Dashboard'),
//           //   textColor: AppColors.baseColor,
//           //   iconColor: AppColors.baseColor,
//           //   onTap: () {
//           //     Navigator.of(context).push(MaterialPageRoute(
//           //         builder: (BuildContext context) =>
//           //             const RowAnalyticsDashboard()));
//           //   },
//           // ),
//                   ListTile(
//                     leading: const Icon(
//                       Icons.list,
//                     ),
//                     title: const Text('Invoice List'),
//                     textColor: AppColors.baseColor,
//                     iconColor: AppColors.baseColor,
//                     onTap: () {
//                       Navigator.of(context).push(MaterialPageRoute(
//                           builder: (BuildContext context) =>
//                               const AdmInvoiceList()));
//                     },
//                   ),
//           ListTile(
//             leading: const Icon(
//               Icons.data_usage,
//             ),
//             title: const Text('Budget Planning'),
//             textColor: AppColors.baseColor,
//             iconColor: AppColors.baseColor,
//             onTap: () {
//               Navigator.of(context).push(MaterialPageRoute(
//                   builder: (BuildContext context) => const BudgetPlanning()));
//             },
//           ),

//           ListTile(
//             leading: const Icon(
//               Icons.location_on,
//             ),
//             title: const Text('Live IVM System Map'),
//             textColor: AppColors.baseColor,
//             iconColor: AppColors.baseColor,
//             onTap: () {
//               provider.getLocation();
//               Navigator.of(context).push(MaterialPageRoute(
//                   builder: (context) => const MapScreenLeafLat()));
//             },
//           ),
//           ListTile(
//             leading: const Icon(
//               Icons.check,
//             ),
//             title: const Text('Approve CIVM Access'),
//             textColor: AppColors.baseColor,
//             iconColor: AppColors.baseColor,
//             onTap: () {
//               Navigator.of(context).push(MaterialPageRoute(
//                   builder: (BuildContext context) =>
//                       const ApproveCIVMAccess()));
//             },
//           ),
//           ListTile(
//             leading: const Icon(
//               Icons.add,
//             ),
//             title: const Text('Add Crew Member'),
//             textColor: AppColors.baseColor,
//             iconColor: AppColors.baseColor,
//             onTap: () {
//               Navigator.of(context).push(MaterialPageRoute(
//                   builder: (BuildContext context) => const AddCrewMember()));
//             },
//           ),

//           ListTile(
//             leading: const Icon(
//               Icons.logout,
//             ),
//             title: const Text('Logout'),
//             textColor: AppColors.baseColor,
//             iconColor: AppColors.baseColor,
//             onTap: () {
//               // ants.prefs.setBool("LoggedIn", false);
//               userPreferences.remove().then((value) {
//                 // ignore: use_build_context_synchronously
//                 // Navigator.pushReplacement(context, RoutesName.login);
//                 // Navigator.pushNamed(
//                 //     context, RoutesName.login);
//                 Navigator.of(context).push(MaterialPageRoute(
//                     builder: (BuildContext context) => const LoginPagePemc()));
//               });
//               // Navigator.of(context).push(MaterialPageRoute(
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
//       'https://atsdev2test.ariespro.com/assets/clientuploads/${data.user!.profilePhoto}',
//     );
//     String imageUrl =
//         'https://atsdev2test.ariespro.com/assets/clientuploads/${data.user!.profilePhoto}';
//     _imagePath = imageUrl;
//     setState(() {
//       userName = '${data.user!.fName} ${data.user!.lName}';
//     });
//   }
// }
