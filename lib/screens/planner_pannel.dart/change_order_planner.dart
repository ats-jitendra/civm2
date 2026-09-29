// import 'package:CIVM/data/response/status.dart';
// import 'package:CIVM/models/user_model.dart';
// import 'package:CIVM/repository/map_url.dart';
// import 'package:CIVM/utils/common_functions.dart';
// import 'package:CIVM/screens/leaflat_map/leaf_lat_map_wakeLock.dart';
// import 'package:CIVM/screens/map/provider/location_provider.dart';
// import 'package:CIVM/screens/my_chrome_safari_map_recording.dart';
// import 'package:CIVM/screens/planner_pannel.dart/create_order_withoutDataPlanner.dart';
// import 'package:CIVM/screens/planner_pannel.dart/planner_add_crew_memeber.dart';
// import 'package:CIVM/screens/planner_pannel.dart/planner_add_new_row_table.dart';
// import 'package:CIVM/screens/planner_pannel.dart/planner_total_order_cancelled.dart';
// import 'package:CIVM/screens/planner_pannel.dart/total_order_closed_planner.dart';
// import 'package:CIVM/screens/planner_pannel.dart/total_order_iniciated_planner.dart';
// import 'package:CIVM/screens/planner_pannel.dart/total_order_pending_planner.dart';
// import 'package:CIVM/screens/planner_pannel.dart/total_order_reject_planner.dart';
// import 'package:CIVM/sharedPrefs/constants.dart';
// import 'package:CIVM/utils/user_pref.dart';
// import 'package:CIVM/view_model/lcp_view_model.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// // import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// import 'package:provider/provider.dart';
// import '../login_page.dart';

// // ignore: must_be_immutable
// class ChangeOrderPlanner extends StatefulWidget {
//   String budgetType;
//   String maintenanceType;
//   String heading;

//   ChangeOrderPlanner(
//       {Key? key,
//       required this.budgetType,
//       required this.maintenanceType,
//       required this.heading})
//       : super(key: key);

//   @override
//   State<ChangeOrderPlanner> createState() => _ChangeOrderPlannerState();
// }

// class _ChangeOrderPlannerState extends State<ChangeOrderPlanner> {
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

//   // ignore: prefer_typing_uninitialized_variables
//   var selectedWorkOrderNo;

//   // ContractorChangeOrderViewModel contractorChangeOrderViewModel =
//   //     ContractorChangeOrderViewModel();
//   LCPViewModel lCPViewModel = LCPViewModel();

//   bool _isVisibleChangeOrder = false;
//   TextEditingController searchController = TextEditingController();
//   bool isSearchActive = false;
//   bool isSearching = false;

//   @override
//   void initState() {
//     // contractorChangeOrderViewModel.fetchContractorChangeOrdercountApi(context);
//     getContractorDataCount('');
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//         appBar: AppBar(
//           iconTheme: const IconThemeData(color: Colors.white),
//           backgroundColor: const Color.fromARGB(255, 7, 59, 120),
//           title: isSearching
//               ? Container(
//                   height: 40,
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: TextField(
//                     controller: searchController,
//                     style: const TextStyle(
//                       color: Color.fromARGB(255, 7, 59, 120),
//                     ),
//                     onChanged: (value) {
//                       setState(() {
//                         isSearchActive = value.isNotEmpty;
//                         getContractorDataCount(value);
//                       });
//                     },
//                     decoration: const InputDecoration(
//                       hintText: "Search...",
//                       hintStyle: TextStyle(color: Colors.grey),
//                       border: InputBorder.none,
//                       prefixIcon: Icon(Icons.search, color: Colors.grey),
//                       contentPadding: EdgeInsets.only(top: 8),
//                     ),
//                   ),
//                 )
//               : const Text(
//                   'Change Order Job List',
//                   style: TextStyle(color: Colors.white),
//                 ),
//           actions: [
//             IconButton(
//               icon: Icon(
//                 isSearching ? Icons.close : Icons.search,
//                 color: Colors.white,
//               ),
//               onPressed: () {
//                 setState(() {
//                   if (isSearching) {
//                     searchController.clear();
//                     getContractorDataCount('');
//                   }
//                   isSearching = !isSearching;
//                 });
//               },
//             )
//           ],
//         ),
//         drawer: DrawerManu(menu: menu),
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
//                               'assets/empty_box.png',
//                               height: 200,
//                               width: 200,
//                               fit: BoxFit.cover,
//                             ),
//                             const Center(
//                               child: Text(
//                                 'Sorry, Data Not Found!',
//                                 textAlign: TextAlign.left,
//                                 style: TextStyle(
//                                   color: Color.fromARGB(255, 7, 59, 120),
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
//                   if (widget.maintenanceType == 'Change Order') {
//                     _isVisibleChangeOrder = true;
//                   } else {
//                     _isVisibleChangeOrder = false;
//                   }
//                   return Stack(fit: StackFit.expand, children: [
//                     RefreshIndicator(
//                       onRefresh: () async {
//                         await getContractorDataCount('');
//                         print('RefreshIndicator called');
//                       },
//                       child: SingleChildScrollView(
//                         physics: const AlwaysScrollableScrollPhysics(),
//                         child: Padding(
//                           padding: const EdgeInsets.all(4.0),
//                           child: Column(
//                             children: [
//                               Visibility(
//                                 visible: _isVisibleChangeOrder,
//                                 child: Container(
//                                   margin: const EdgeInsets.only(
//                                       left: 8, right: 8, top: 10, bottom: 8),
//                                   decoration: const BoxDecoration(
//                                       // shape: BoxShape.circle,
//                                       borderRadius: BorderRadius.only(
//                                           // topRight: Radius.circular(50),
//                                           // bottomLeft: Radius.circular(50)
//                                           ),
//                                       boxShadow: [
//                                         BoxShadow(
//                                             color:
//                                                 Color.fromARGB(255, 3, 47, 97),
//                                             blurRadius: 5,
//                                             offset: Offset(2.0, 5.0))
//                                       ],
//                                       color: Color.fromARGB(255, 130, 193, 245),
//                                       gradient: LinearGradient(
//                                         colors: [
//                                           Color.fromARGB(255, 7, 59, 120),
//                                           Color.fromARGB(255, 7, 59, 120)
//                                         ],
//                                       )),
//                                   child: InkWell(
//                                     onTap: () {
//                                       Navigator.of(context).push(
//                                           MaterialPageRoute(
//                                               builder: (BuildContext context) =>
//                                                   CreateOrderPlannerWithoutData(
//                                                       subStation: '',
//                                                       serviceStreetAddress: '',
//                                                       serviceMapLocation: '',
//                                                       notes: '',
//                                                       type: '',
//                                                       maintType: '',
//                                                       contractorCompany: '',
//                                                       assignForeman: '')));
//                                     },
//                                     child: Container(
//                                         decoration: BoxDecoration(
//                                           border: Border.all(
//                                             color: Colors.white,
//                                           ),
//                                           boxShadow: const [
//                                             BoxShadow(
//                                                 color: Color.fromARGB(
//                                                     255, 3, 47, 97),
//                                                 blurRadius: 10,
//                                                 offset: Offset(2.0, 5.0))
//                                           ],
//                                           image: DecorationImage(
//                                             image: const AssetImage(
//                                                 'assets/Dash_6.jpg'),
//                                             fit: BoxFit.cover,
//                                             colorFilter: ColorFilter.mode(
//                                                 Colors.black.withOpacity(0.45),
//                                                 BlendMode.darken),
//                                           ),
//                                         ),
//                                         margin: const EdgeInsets.only(
//                                             left: 8,
//                                             right: 8,
//                                             top: 10,
//                                             bottom: 8),
//                                         padding: const EdgeInsets.all(8),
//                                         alignment: Alignment.center,
//                                         height: size.height * 0.15,
//                                         width: size.width * 0.99,
//                                         child: const Stack(children: [
//                                           Text(
//                                             'Create a Change Order(Real Time)',
//                                             style: TextStyle(
//                                                 fontSize: 22,
//                                                 color: Colors.white,
//                                                 fontWeight: FontWeight.w800),
//                                           ),
//                                         ])),
//                                   ),
//                                 ),
//                               ),
//                               if (!isSearchActive ||
//                                   lCPViewModel.lcpCountList.data!
//                                           .countOfInitiatedOrder![0] >
//                                       0)
//                                 Container(
//                                   margin: const EdgeInsets.only(
//                                       left: 8, right: 8, top: 10, bottom: 8),
//                                   decoration: const BoxDecoration(
//                                       // shape: BoxShape.circle,
//                                       borderRadius: BorderRadius.only(
//                                           // topRight: Radius.circular(50),
//                                           // bottomLeft: Radius.circular(50)
//                                           ),
//                                       boxShadow: [
//                                         BoxShadow(
//                                             color:
//                                                 Color.fromARGB(255, 3, 47, 97),
//                                             blurRadius: 5,
//                                             offset: Offset(2.0, 5.0))
//                                       ],
//                                       color: Color.fromARGB(255, 130, 193, 245),
//                                       gradient: LinearGradient(
//                                         colors: [
//                                           Color.fromARGB(255, 7, 59, 120),
//                                           Color.fromARGB(255, 7, 59, 120)
//                                         ],
//                                       )),
//                                   child: InkWell(
//                                     onTap: () {
//                                       Navigator.of(context).push(MaterialPageRoute(
//                                           builder: (BuildContext context) =>
//                                               TotalOrderIniciatedPlanner(
//                                                   budgetType: widget.budgetType,
//                                                   maintenanceType:
//                                                       widget.maintenanceType,
//                                                   heading:
//                                                       'Total Order Initiated (${widget.heading})')));
//                                     },
//                                     child: Container(
//                                         decoration: BoxDecoration(
//                                           border: Border.all(
//                                             color: Colors.white,
//                                           ),
//                                           boxShadow: const [
//                                             BoxShadow(
//                                                 color: Color.fromARGB(
//                                                     255, 3, 47, 97),
//                                                 blurRadius: 10,
//                                                 offset: Offset(2.0, 5.0))
//                                           ],
//                                           image: DecorationImage(
//                                             image: const AssetImage(
//                                                 'assets/Dash_2.jpg'),
//                                             fit: BoxFit.cover,
//                                             colorFilter: ColorFilter.mode(
//                                                 Colors.black.withOpacity(0.45),
//                                                 BlendMode.darken),
//                                           ),
//                                         ),
//                                         margin: const EdgeInsets.only(
//                                             left: 8,
//                                             right: 8,
//                                             top: 10,
//                                             bottom: 8),
//                                         padding: const EdgeInsets.all(8),
//                                         alignment: Alignment.center,
//                                         height: size.height * 0.15,
//                                         width: size.width * 0.99,
//                                         child: Stack(children: [
//                                           Row(
//                                             children: [
//                                               const Expanded(
//                                                 child: Text(
//                                                   'Total Order (Initiated)',
//                                                   style: TextStyle(
//                                                       fontSize: 22,
//                                                       color: Colors.white,
//                                                       fontWeight:
//                                                           FontWeight.w800),
//                                                 ),
//                                               ),
//                                               Text(
//                                                 (lCPViewModel
//                                                             .lcpCountList
//                                                             .data!
//                                                             .countOfInitiatedOrder![
//                                                                 0]
//                                                             .toString() ==
//                                                         'null')
//                                                     ? ''
//                                                     : lCPViewModel
//                                                         .lcpCountList
//                                                         .data!
//                                                         .countOfInitiatedOrder![
//                                                             0]
//                                                         .toString(),
//                                                 style: const TextStyle(
//                                                     fontSize: 22,
//                                                     color: Colors.white,
//                                                     fontWeight:
//                                                         FontWeight.w800),
//                                               ),
//                                             ],
//                                           )
//                                         ])),
//                                   ),
//                                 ),
//                               if (!isSearchActive ||
//                                   lCPViewModel.lcpCountList.data!
//                                           .countOfPendingOrder![0] >
//                                       0)
//                                 Container(
//                                   margin: const EdgeInsets.only(
//                                       left: 8, right: 8, top: 10, bottom: 8),
//                                   decoration: const BoxDecoration(
//                                       // shape: BoxShape.circle,
//                                       borderRadius: BorderRadius.only(
//                                           // topRight: Radius.circular(50),
//                                           // bottomLeft: Radius.circular(50)
//                                           ),
//                                       boxShadow: [
//                                         BoxShadow(
//                                             color:
//                                                 Color.fromARGB(255, 3, 47, 97),
//                                             blurRadius: 5,
//                                             offset: Offset(2.0, 5.0))
//                                       ],
//                                       color: Color.fromARGB(255, 130, 193, 245),
//                                       gradient: LinearGradient(
//                                         colors: [
//                                           Color.fromARGB(255, 7, 59, 120),
//                                           Color.fromARGB(255, 7, 59, 120)
//                                         ],
//                                       )),
//                                   child: InkWell(
//                                     onTap: () {
//                                       Navigator.of(context).push(MaterialPageRoute(
//                                           builder: (BuildContext context) =>
//                                               TotalOrderPendingPlanner(
//                                                   budgetType: widget.budgetType,
//                                                   maintenanceType:
//                                                       widget.maintenanceType,
//                                                   heading:
//                                                       'Total Order Pending (${widget.heading})')));
//                                     },
//                                     child: Container(
//                                         decoration: BoxDecoration(
//                                           border: Border.all(
//                                             color: Colors.white,
//                                           ),
//                                           boxShadow: const [
//                                             BoxShadow(
//                                                 color: Color.fromARGB(
//                                                     255, 3, 47, 97),
//                                                 blurRadius: 10,
//                                                 offset: Offset(2.0, 5.0))
//                                           ],
//                                           image: DecorationImage(
//                                             image: const AssetImage(
//                                                 'assets/Dash_2.jpg'),
//                                             fit: BoxFit.cover,
//                                             colorFilter: ColorFilter.mode(
//                                                 Colors.black.withOpacity(0.45),
//                                                 BlendMode.darken),
//                                           ),
//                                         ),
//                                         margin: const EdgeInsets.only(
//                                             left: 8,
//                                             right: 8,
//                                             top: 10,
//                                             bottom: 8),
//                                         padding: const EdgeInsets.all(8),
//                                         alignment: Alignment.center,
//                                         height: size.height * 0.15,
//                                         width: size.width * 0.99,
//                                         child: Stack(children: [
//                                           Row(
//                                             children: [
//                                               const Expanded(
//                                                 child: Text(
//                                                   'Total Order (Pending)',
//                                                   style: TextStyle(
//                                                       fontSize: 22,
//                                                       color: Colors.white,
//                                                       fontWeight:
//                                                           FontWeight.w800),
//                                                 ),
//                                               ),
//                                               Text(
//                                                 (lCPViewModel
//                                                             .lcpCountList
//                                                             .data!
//                                                             .countOfPendingOrder![
//                                                                 0]
//                                                             .toString() ==
//                                                         'null')
//                                                     ? ''
//                                                     : lCPViewModel
//                                                         .lcpCountList
//                                                         .data!
//                                                         .countOfPendingOrder![0]
//                                                         .toString(),
//                                                 style: const TextStyle(
//                                                     fontSize: 22,
//                                                     color: Colors.white,
//                                                     fontWeight:
//                                                         FontWeight.w800),
//                                               ),
//                                             ],
//                                           )
//                                         ])),
//                                   ),
//                                 ),
//                               if (!isSearchActive ||
//                                   lCPViewModel.lcpCountList.data!
//                                           .countOfRejectOrder![0] >
//                                       0)
//                                 Container(
//                                   margin: const EdgeInsets.only(
//                                       left: 8, right: 8, top: 10, bottom: 8),
//                                   decoration: const BoxDecoration(
//                                       // shape: BoxShape.circle,
//                                       borderRadius: BorderRadius.only(
//                                           // topRight: Radius.circular(50),
//                                           // bottomLeft: Radius.circular(50)
//                                           ),
//                                       boxShadow: [
//                                         BoxShadow(
//                                             color:
//                                                 Color.fromARGB(255, 3, 47, 97),
//                                             blurRadius: 5,
//                                             offset: Offset(2.0, 5.0))
//                                       ],
//                                       color: Color.fromARGB(255, 130, 193, 245),
//                                       gradient: LinearGradient(
//                                         colors: [
//                                           Color.fromARGB(255, 7, 59, 120),
//                                           Color.fromARGB(255, 7, 59, 120)
//                                         ],
//                                       )),
//                                   child: InkWell(
//                                     onTap: () {
//                                       Navigator.of(context).push(MaterialPageRoute(
//                                           builder: (BuildContext context) =>
//                                               TotalOrderRejectedPlanner(
//                                                   budgetType: widget.budgetType,
//                                                   maintenanceType:
//                                                       widget.maintenanceType,
//                                                   heading:
//                                                       'Total Order Rejected (${widget.heading})')));
//                                     },
//                                     child: Container(
//                                         decoration: BoxDecoration(
//                                           border: Border.all(
//                                             color: Colors.white,
//                                           ),
//                                           boxShadow: const [
//                                             BoxShadow(
//                                                 color: Color.fromARGB(
//                                                     255, 3, 47, 97),
//                                                 blurRadius: 10,
//                                                 offset: Offset(2.0, 5.0))
//                                           ],
//                                           image: DecorationImage(
//                                             image: const AssetImage(
//                                                 'assets/Dash_4.jpg'),
//                                             fit: BoxFit.cover,
//                                             colorFilter: ColorFilter.mode(
//                                                 Colors.black.withOpacity(0.45),
//                                                 BlendMode.darken),
//                                           ),
//                                         ),
//                                         margin: const EdgeInsets.only(
//                                             left: 8,
//                                             right: 8,
//                                             top: 10,
//                                             bottom: 8),
//                                         padding: const EdgeInsets.all(8),
//                                         alignment: Alignment.center,
//                                         height: size.height * 0.15,
//                                         width: size.width * 0.99,
//                                         child: Stack(children: [
//                                           Row(
//                                             children: [
//                                               const Expanded(
//                                                 child: Text(
//                                                   'Total Order (Rejected)',
//                                                   style: TextStyle(
//                                                       fontSize: 22,
//                                                       color: Colors.white,
//                                                       fontWeight:
//                                                           FontWeight.w800),
//                                                 ),
//                                               ),
//                                               Text(
//                                                 (lCPViewModel
//                                                             .lcpCountList
//                                                             .data!
//                                                             .countOfRejectOrder![
//                                                                 0]
//                                                             .toString() ==
//                                                         'null')
//                                                     ? ''
//                                                     : lCPViewModel
//                                                         .lcpCountList
//                                                         .data!
//                                                         .countOfRejectOrder![0]
//                                                         .toString(),
//                                                 style: const TextStyle(
//                                                     fontSize: 22,
//                                                     color: Colors.white,
//                                                     fontWeight:
//                                                         FontWeight.w800),
//                                               ),
//                                             ],
//                                           )
//                                         ])),
//                                   ),
//                                 ),
//                               if (!isSearchActive ||
//                                   lCPViewModel.lcpCountList.data!
//                                           .countOfCloseOrder![0] >
//                                       0)
//                                 Container(
//                                   margin: const EdgeInsets.only(
//                                       left: 8, right: 8, top: 10, bottom: 8),
//                                   decoration: const BoxDecoration(
//                                       // shape: BoxShape.circle,
//                                       borderRadius: BorderRadius.only(
//                                           // topRight: Radius.circular(50),
//                                           // bottomLeft: Radius.circular(50)
//                                           ),
//                                       boxShadow: [
//                                         BoxShadow(
//                                             color:
//                                                 Color.fromARGB(255, 3, 47, 97),
//                                             blurRadius: 5,
//                                             offset: Offset(2.0, 5.0))
//                                       ],
//                                       color: Color.fromARGB(255, 130, 193, 245),
//                                       gradient: LinearGradient(
//                                         colors: [
//                                           Color.fromARGB(255, 7, 59, 120),
//                                           Color.fromARGB(255, 7, 59, 120)
//                                         ],
//                                       )),
//                                   child: InkWell(
//                                     onTap: () {
//                                       Navigator.of(context).push(MaterialPageRoute(
//                                           builder: (BuildContext context) =>
//                                               TotalOrderClosedPlanner(
//                                                   budgetType: widget.budgetType,
//                                                   maintenanceType:
//                                                       widget.maintenanceType,
//                                                   heading:
//                                                       'Total Order Closed (${widget.heading})')));
//                                     },
//                                     child: Container(
//                                         decoration: BoxDecoration(
//                                           border: Border.all(
//                                             color: Colors.white,
//                                           ),
//                                           boxShadow: const [
//                                             BoxShadow(
//                                                 color: Color.fromARGB(
//                                                     255, 3, 47, 97),
//                                                 blurRadius: 10,
//                                                 offset: Offset(2.0, 5.0))
//                                           ],
//                                           image: DecorationImage(
//                                             image: const AssetImage(
//                                                 'assets/Dash_5.jpg'),
//                                             fit: BoxFit.cover,
//                                             colorFilter: ColorFilter.mode(
//                                                 Colors.black.withOpacity(0.45),
//                                                 BlendMode.darken),
//                                           ),
//                                         ),
//                                         margin: const EdgeInsets.only(
//                                             left: 8,
//                                             right: 8,
//                                             top: 10,
//                                             bottom: 8),
//                                         padding: const EdgeInsets.all(8),
//                                         alignment: Alignment.center,
//                                         height: size.height * 0.15,
//                                         width: size.width * 0.99,
//                                         child: Stack(children: [
//                                           Row(
//                                             children: [
//                                               const Expanded(
//                                                 child: Text(
//                                                   'Total Orders (Closed)',
//                                                   style: TextStyle(
//                                                       fontSize: 22,
//                                                       color: Colors.white,
//                                                       fontWeight:
//                                                           FontWeight.w800),
//                                                 ),
//                                               ),
//                                               Text(
//                                                 (lCPViewModel
//                                                             .lcpCountList
//                                                             .data!
//                                                             .countOfCloseOrder![
//                                                                 0]
//                                                             .toString() ==
//                                                         'null')
//                                                     ? ''
//                                                     : lCPViewModel
//                                                         .lcpCountList
//                                                         .data!
//                                                         .countOfCloseOrder![0]
//                                                         .toString(),
//                                                 style: const TextStyle(
//                                                     fontSize: 22,
//                                                     color: Colors.white,
//                                                     fontWeight:
//                                                         FontWeight.w800),
//                                               ),
//                                             ],
//                                           )
//                                         ])),
//                                   ),
//                                 ),
//                               if (!isSearchActive ||
//                                   lCPViewModel.lcpCountList.data!
//                                           .countOfCancelledOrder![0] >
//                                       0)
//                                 Container(
//                                   margin: const EdgeInsets.only(
//                                       left: 8, right: 8, top: 10, bottom: 8),
//                                   decoration: const BoxDecoration(
//                                       // shape: BoxShape.circle,
//                                       borderRadius: BorderRadius.only(
//                                           // topRight: Radius.circular(50),
//                                           // bottomLeft: Radius.circular(50)
//                                           ),
//                                       boxShadow: [
//                                         BoxShadow(
//                                             color:
//                                                 Color.fromARGB(255, 3, 47, 97),
//                                             blurRadius: 5,
//                                             offset: Offset(2.0, 5.0))
//                                       ],
//                                       color: Color.fromARGB(255, 130, 193, 245),
//                                       gradient: LinearGradient(
//                                         colors: [
//                                           Color.fromARGB(255, 7, 59, 120),
//                                           Color.fromARGB(255, 7, 59, 120)
//                                         ],
//                                       )),
//                                   child: InkWell(
//                                     onTap: () {
//                                       Navigator.of(context).push(MaterialPageRoute(
//                                           builder: (BuildContext context) =>
//                                               TotalOrderCanceledPlanner(
//                                                   budgetType: widget.budgetType,
//                                                   maintenanceType:
//                                                       widget.maintenanceType,
//                                                   heading:
//                                                       'Total Order Cancelled (${widget.heading})')));
//                                     },
//                                     child: Container(
//                                         decoration: BoxDecoration(
//                                           border: Border.all(
//                                             color: Colors.white,
//                                           ),
//                                           boxShadow: const [
//                                             BoxShadow(
//                                                 color: Color.fromARGB(
//                                                     255, 3, 47, 97),
//                                                 blurRadius: 10,
//                                                 offset: Offset(2.0, 5.0))
//                                           ],
//                                           image: DecorationImage(
//                                             image: const AssetImage(
//                                                 'assets/Dash_5.jpg'),
//                                             fit: BoxFit.cover,
//                                             colorFilter: ColorFilter.mode(
//                                                 Colors.black.withOpacity(0.45),
//                                                 BlendMode.darken),
//                                           ),
//                                         ),
//                                         margin: const EdgeInsets.only(
//                                             left: 8,
//                                             right: 8,
//                                             top: 10,
//                                             bottom: 8),
//                                         padding: const EdgeInsets.all(8),
//                                         alignment: Alignment.center,
//                                         height: size.height * 0.15,
//                                         width: size.width * 0.99,
//                                         child: Stack(children: [
//                                           Row(
//                                             children: [
//                                               const Expanded(
//                                                 child: Text(
//                                                   'Total Orders (Cancelled)',
//                                                   style: TextStyle(
//                                                       fontSize: 22,
//                                                       color: Colors.white,
//                                                       fontWeight:
//                                                           FontWeight.w800),
//                                                 ),
//                                               ),
//                                               Text(
//                                                 (lCPViewModel
//                                                             .lcpCountList
//                                                             .data!
//                                                             .countOfCancelledOrder![
//                                                                 0]
//                                                             .toString() ==
//                                                         'null')
//                                                     ? ''
//                                                     : lCPViewModel
//                                                         .lcpCountList
//                                                         .data!
//                                                         .countOfCancelledOrder![
//                                                             0]
//                                                         .toString(),
//                                                 style: const TextStyle(
//                                                     fontSize: 22,
//                                                     color: Colors.white,
//                                                     fontWeight:
//                                                         FontWeight.w800),
//                                               ),
//                                             ],
//                                           )
//                                         ])),
//                                   ),
//                                 ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ]);

//                 default:
//                   return const Text('data');
//               }
//             })));
//   }

//   Future<void> getContractorDataCount(String search) async {
//     // final userPreferences = Provider.of<UserPref>(context, listen: false);
//     // UserModel data = await userPreferences.getUser();

//     // String id = data.user!.id.toString();

//     lCPViewModel.fetchLCPcountApi(
//         context,
//         'ZIELIES',
//         '',
//         widget.budgetType,
//         widget.maintenanceType,
//         // 'Change Order',
//         '',
//         '',
//         search);
//   }

//   // Future<void> _filterData(String query) async {
//   //   if (query.isEmpty) {
//   //     final userPreferences = Provider.of<UserPref>(context, listen: false);
//   //     UserModel data = await userPreferences.getUser();
//   //     supervisorOrderPendingViewModel.fetchSupervisorOrderPendingTabularListApi(
//   //         context, 'PENDING', data.user!.id.toString(), '');
//   //   } else {
//   //     supervisorOrderPendingViewModel
//   //             .supervisorOrderPendingGetTabularData.data!.findAllTableData =
//   //         supervisorOrderPendingViewModel
//   //             .supervisorOrderPendingGetTabularData.data!.findAllTableData!
//   //             .where((item) =>
//   //                 item.type!.toLowerCase().contains(query.toLowerCase()) ||
//   //                 item.tokenNo!
//   //                     .toString()
//   //                     .toLowerCase()
//   //                     .contains(query.toLowerCase()))
//   //             .toList();
//   //   }
//   //   setState(() {});
//   // }
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
//     var provider = Provider.of<LocationProvider>(context, listen: true);
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
//               color: const Color.fromARGB(255, 3, 47, 97),
//               padding: const EdgeInsets.only(top: 24),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                  menuLogoLCP(),const SizedBox(height: 6),
//                   Text(
//                     userName,
//                     style: const TextStyle(fontSize: 18, color: Colors.white),
//                   ),
//                 ],
//               ),
//             ),
//             Expanded(
//               child: ListView(
//                 padding: EdgeInsets.zero,
//                 children: [
//                   // ListTile(
//                   //   leading: const Icon(
//                   //     Icons.computer,
//                   //   ),
//                   //   title: const Text('Row Maintenance Plan'),
//                   //   textColor: const Color.fromARGB(255, 7, 59, 120),
//                   //   iconColor: const Color.fromARGB(255, 7, 59, 120),
//                   //   onTap: () {
//                   //     Navigator.of(context).push(MaterialPageRoute(
//                   //         builder: (BuildContext context) =>
//                   //             const PlannerRowMaintenanceView()));
//                   //   },
//                   // ),
//                   ListTile(
//                     leading: const Icon(
//                       Icons.computer,
//                     ),
//                     title: const Text('IVM Maintenance Job List'),
//                     textColor: const Color.fromARGB(255, 7, 59, 120),
//                     iconColor: const Color.fromARGB(255, 7, 59, 120),
//                     onTap: () {
//                       // Navigator.of(context).push(MaterialPageRoute(
//                       //   builder: (BuildContext context) =>
//                       //       PlannerAddNewRowMaintenancePlan(
//                       //         tokenNo: '',
//                       //         index: '0',
//                       //         subStation: '',
//                       //         feeder: '',
//                       //         nextMaintYear: '',
//                       //         maintType: '',
//                       //         totalMiles: '',
//                       //         costPerMile: '',
//                       //         totalCost: '',
//                       //         budgetType: '',
//                       //         contractRowYear: '',
//                       //         rowCycle: '',
//                       //         rowYear: '',
//                       //         contractorCompany: '',
//                       //         assignForeman: '',
//                       //         task: 'createOrder',
//                       //       )));
//                       Navigator.of(context).push(MaterialPageRoute(
//                           builder: (BuildContext context) =>
//                               const PlannerAddNewRowTable()));
//                     },
//                   ),
//                   ListTile(
//                     leading: const Icon(
//                       Icons.change_circle,
//                     ),
//                     title: const Text('Change Order Job List'),
//                     textColor: const Color.fromARGB(255, 7, 59, 120),
//                     iconColor: const Color.fromARGB(255, 7, 59, 120),
//                     onTap: () {
//                       Navigator.pop(context);
//                     },
//                   ),
//                   // ListTile(
//                   //   leading: const Icon(
//                   //     Icons.map,
//                   //   ),
//                   //   title: const Text('Add Change Order Map'),
//                   //   textColor: const Color.fromARGB(255, 7, 59, 120),
//                   //   iconColor: const Color.fromARGB(255, 7, 59, 120),
//                   //   onTap: () async {
//                   //     String id = '';
//                   //     final userPreferences1 =
//                   //         Provider.of<UserPref>(context, listen: false);
//                   //     UserModel data = await userPreferences1.getUser();
//                   //     id = data.user!.id.toString();
//                   //     // Navigator.push(
//                   //     //   context,
//                   //     //   MaterialPageRoute(
//                   //     //     builder: (context) => MapViewPage(
//                   //     //       url: MapUrl.getCreateChangeOrderFromPlannerEndPoint(id),
//                   //     //     ),
//                   //     //   ),
//                   //     // );
//                   //     await browser.open(
//                   //         url: WebUri(
//                   //             MapUrl.getCreateChangeOrderFromPlannerEndPoint(
//                   //                 id)),
//                   //         settings: ChromeSafariBrowserSettings(
//                   //             shareState: CustomTabsShareState.SHARE_STATE_OFF,
//                   //             barCollapsingEnabled: true));
//                   //   },
//                   // ),
//                   ListTile(
//                     leading: const Icon(
//                       Icons.location_searching,
//                     ),
//                     title: const Text('Add Row Maintenance Map'),
//                     textColor: const Color.fromARGB(255, 7, 59, 120),
//                     iconColor: const Color.fromARGB(255, 7, 59, 120),
//                     onTap: () async {
//                       String id = '';
//                       final userPreferences1 =
//                           Provider.of<UserPref>(context, listen: false);
//                       UserModel data = await userPreferences1.getUser();
//                       id = data.user!.id.toString();
//                       //  Navigator.push(
//                       //   context,
//                       //   MaterialPageRoute(
//                       //     builder: (context) => MapViewPage(
//                       //       url: MapUrl.getPlannerWithoutTokenEndPoint(id),
//                       //     ),
//                       //   ),
//                       // );
//                       await browser.open(
//                           url: WebUri(
//                               // "https://mapapi.ariespro.com/main/planner/CIVM_Map/USRQWXH589Z"),
//                               MapUrl.getPlannerWithoutTokenEndPoint(id)),
//                           settings: ChromeSafariBrowserSettings(
//                               shareState: CustomTabsShareState.SHARE_STATE_OFF,
//                               barCollapsingEnabled: true));
//                     },
//                   ),
//                   // ListTile(
//                   //   leading: const Icon(
//                   //     Icons.map_outlined,
//                   //   ),
//                   //   title: const Text('Add Spray Map'),
//                   //   textColor: const Color.fromARGB(255, 7, 59, 120),
//                   //   iconColor: const Color.fromARGB(255, 7, 59, 120),
//                   //   onTap: () async {
//                   //     String id = '';
//                   //     final userPreferences1 =
//                   //         Provider.of<UserPref>(context, listen: false);
//                   //     UserModel data = await userPreferences1.getUser();
//                   //     id = data.user!.id.toString();
//                   //     //    Navigator.push(
//                   //     //   context,
//                   //     //   MaterialPageRoute(
//                   //     //     builder: (context) => MapViewPage(
//                   //     //       url: MapUrl.getPlannerSprayWithoutTokenEndPoint(id),
//                   //     //     ),
//                   //     //   ),
//                   //     // );
//                   //     await browser.open(
//                   //         url: WebUri(
//                   //             // "https://mapapi.ariespro.com/main/spray_map/CIVM_Map/USRQWXH589Z"),
//                   //             MapUrl.getPlannerSprayWithoutTokenEndPoint(id)),
//                   //         settings: ChromeSafariBrowserSettings(
//                   //             shareState: CustomTabsShareState.SHARE_STATE_OFF,
//                   //             barCollapsingEnabled: true));
//                   //   },
//                   // ),
//                   ListTile(
//                     leading: const Icon(
//                       Icons.location_on,
//                     ),
//                     title: const Text('Live IVM System Map'),
//                     textColor: const Color.fromARGB(255, 7, 59, 120),
//                     iconColor: const Color.fromARGB(255, 7, 59, 120),
//                     onTap: () {
//                       provider.getLocation();
//                       Navigator.of(context).push(MaterialPageRoute(
//                           builder: (context) => const MapScreenLeafLat()));
//                     },
//                   ),
//                   // ListTile(
//                   //   leading: const Icon(
//                   //     Icons.my_location,
//                   //   ),
//                   //   title: const Text('AI Enable On Demand Area'),
//                   //   textColor: const Color.fromARGB(255, 7, 59, 120),
//                   //   iconColor: const Color.fromARGB(255, 7, 59, 120),
//                   //   onTap: () async {
//                   //     String id = '';
//                   //     final userPreferences1 =
//                   //         Provider.of<UserPref>(context, listen: false);
//                   //     UserModel data = await userPreferences1.getUser();
//                   //     id = data.user!.id.toString();
//                   //     await browser.open(
//                   //         url: WebUri("https://lcpmapapi.ariespro.com/main/Ai_enable_on_demand_Area"),
//                   //         settings: ChromeSafariBrowserSettings(
//                   //             shareState: CustomTabsShareState.SHARE_STATE_OFF,
//                   //             barCollapsingEnabled: true));
//                   //   },
//                   // ),
//                   ListTile(
//                     leading: const Icon(
//                       Icons.add,
//                     ),
//                     title: const Text('Add Crew Member'),
//                     textColor: const Color.fromARGB(255, 7, 59, 120),
//                     iconColor: const Color.fromARGB(255, 7, 59, 120),
//                     onTap: () {
//                       Navigator.of(context).push(MaterialPageRoute(
//                           builder: (BuildContext context) =>
//                               const PlannerAddCrewMember()));
//                     },
//                   ),
//                   ListTile(
//                     leading: const Icon(
//                       Icons.logout,
//                     ),
//                     title: const Text('Logout'),
//                     textColor: const Color.fromARGB(255, 7, 59, 120),
//                     iconColor: const Color.fromARGB(255, 7, 59, 120),
//                     onTap: () {
//                       // Constants.prefs.setBool("LoggedIn", false);
//                       userPreferences.remove().then((value) {
//                         // ignore: use_build_context_synchronously
//                         // Navigator.pushReplacement(context, RoutesName.login);
//                         // Navigator.pushNamed(
//                         //     context, RoutesName.login);
//                         Navigator.of(context).push(MaterialPageRoute(
//                             builder: (BuildContext context) =>
//                                 const LoginPage()));
//                       });
//                       // Navigator.of(context).push(MaterialPageRoute(
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
//       'https://civm.ariespro.com/assets/clientuploads/${data.user!.profilePhoto}',
//     );
//     String imageUrl =
//         'https://civm.ariespro.com/assets/clientuploads/${data.user!.profilePhoto}';
//     _imagePath = imageUrl;
//     setState(() {
//       String fName =
//           (data.user!.fName == 'null') ? '' : data.user!.fName.toString();
//       String lName =
//           (data.user!.lName == 'null') ? '' : data.user!.lName.toString();
//       // userName = '${data.user!.fName} ${(data.user!.lName) != null? data.user!.lName :''}';
//       userName = '$fName $lName';
//     });
//   }
// }
