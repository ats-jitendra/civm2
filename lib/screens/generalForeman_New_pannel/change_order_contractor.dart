// import 'package:CIVM/data/response/status.dart';
// import 'package:CIVM/models/user_model.dart';
// // import 'package:CIVM/repository/map_url.dart';
// import 'package:CIVM/screens/generalForeman_New_pannel/contractor_bottom_navigation.dart';
// import 'package:CIVM/screens/generalForeman_New_pannel/create_invoice_contractor.dart';
// import 'package:CIVM/screens/generalForeman_New_pannel/create_order_contractor_withoutData.dart';
// import 'package:CIVM/screens/generalForeman_New_pannel/gf_add_crew_member.dart';
// import 'package:CIVM/screens/generalForeman_New_pannel/gf_maintenance_report_view_new.dart';
// import 'package:CIVM/screens/generalForeman_New_pannel/gf_total_order_cancelled.dart';
// import 'package:CIVM/screens/generalForeman_New_pannel/invoice_form_contractor.dart';
// import 'package:CIVM/screens/generalForeman_New_pannel/invoice_list_contractor.dart';
// import 'package:CIVM/screens/generalForeman_New_pannel/total_order_closed_CO.dart';
// import 'package:CIVM/screens/generalForeman_New_pannel/total_order_closed_contractor.dart';
// import 'package:CIVM/screens/generalForeman_New_pannel/total_order_completed_contractor.dart';
// import 'package:CIVM/screens/generalForeman_New_pannel/total_order_iniciated_gf.dart';
// import 'package:CIVM/screens/generalForeman_New_pannel/total_order_pending_CO.dart';
// import 'package:CIVM/screens/generalForeman_New_pannel/total_order_pending_contractor.dart';
// import 'package:CIVM/screens/generalForeman_New_pannel/total_order_pending_lcp_inspection.dart';
// import 'package:CIVM/screens/generalForeman_New_pannel/total_order_pending_zielies_assignment.dart';
// import 'package:CIVM/screens/generalForeman_New_pannel/total_order_rejected_CO.dart';
// import 'package:CIVM/screens/generalForeman_New_pannel/total_order_rejected_contractor.dart';
// import 'package:CIVM/screens/leaflat_map/leaf_lat_map_wakeLock.dart';
// import 'package:CIVM/screens/map/provider/location_provider.dart';
// import 'package:CIVM/screens/my_chrome_safari_map_recording.dart';
// import 'package:CIVM/utils/common_functions.dart';
// import 'package:CIVM/utils/user_pref.dart';
// import 'package:CIVM/view_model/lcp_view_model.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// // import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// import 'package:provider/provider.dart';
// import '../login_page.dart';

// // ignore: must_be_immutable
// class ChangeOrderContractor extends StatefulWidget {
//   String budgetType;
//   String maintenanceType;
//   String heading;

//   ChangeOrderContractor(
//       {Key? key,
//       required this.budgetType,
//       required this.maintenanceType,
//       required this.heading})
//       : super(key: key);

//   @override
//   State<ChangeOrderContractor> createState() => _ChangeOrderContractorState();
// }

// class _ChangeOrderContractorState extends State<ChangeOrderContractor> {
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
//   bool _isVisibleCancel = false;
//   bool _isVisibleInitiated = false;
//   bool _isVisibleChangeOrderMap = false;
//   bool _isVisibleIVMMap = false;
//   bool _isVisibleSprayMap = false;
//   bool _isVisibleComplete = false;
//   TextEditingController searchController = TextEditingController();
//   bool isSearchActive = false;
//   bool isSearching = false;
//   @override
//   void initState() {
//     // contractorChangeOrderViewModel.fetchContractorChangeOrdercountApi(context);
//     getContractorDataCount();

//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     final browser = MyChromeSafariBrowser();
//     return Scaffold(
//         appBar: AppBar(
//           iconTheme: const IconThemeData(color: Colors.white),
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

//                         lCPViewModel.fetchLCPcountApi(context, 'ZIELIES', '',
//                             '', 'Change Order', '', '', value);
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
//               : Text(
//                   widget.heading,
//                   style: const TextStyle(color: Colors.white),
//                 ),
//           backgroundColor: const Color.fromARGB(255, 7, 59, 120),
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
//                     lCPViewModel.fetchLCPcountApi(
//                         context, 'ZIELIES', '', '', 'Change Order', '', '', '');
//                     // getContractorDataCount('');
//                   }
//                   isSearching = !isSearching;
//                 });
//               },
//             )
//           ],
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
//                   if (widget.maintenanceType == 'ChangeOrder') {
//                     _isVisibleChangeOrder = true;
//                     _isVisibleInitiated = true;
//                     _isVisibleCancel = true;
//                     _isVisibleChangeOrderMap = true;
//                     _isVisibleComplete = true;
//                   } else {
//                     _isVisibleChangeOrder = false;
//                     _isVisibleInitiated = false;
//                     _isVisibleCancel = false;
//                     _isVisibleComplete = false;
//                     if (widget.budgetType == 'Regular IVM maintenance') {
//                       _isVisibleIVMMap = true;
//                     } else if (widget.budgetType == 'Mid Cycle maintenance') {
//                       _isVisibleSprayMap = true;
//                     }
//                   }
//                   return Stack(fit: StackFit.expand, children: [
//                     RefreshIndicator(
//                       onRefresh: () async {
//                         await getContractorDataCount();
//                         print('RefreshIndicator called');
//                       },
//                       child: SingleChildScrollView(
//                         physics: const AlwaysScrollableScrollPhysics(),
//                         child: Padding(
//                           padding: const EdgeInsets.all(4.0),
//                           child: Column(
//                             children: [
//                               Visibility(
//                                 visible: _isVisibleChangeOrderMap,
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
//                                     onTap: () async {
//                                       String id = '';
//                                       final userPreferences1 =
//                                           Provider.of<UserPref>(context,
//                                               listen: false);
//                                       UserModel data =
//                                           await userPreferences1.getUser();
//                                       id = data.user!.id.toString();
//                                       // Navigator.push(
//                                       //   context,
//                                       //   MaterialPageRoute(
//                                       //     builder: (context) => MapViewPage(
//                                       //       url:
//                                       //           "https://lcpmapapi.ariespro.com/main/change_order_view/CIVM_Map/USRQWXH589Z/$id",
//                                       //     ),
//                                       //   ),
//                                       // );
//                                       await browser.open(
//                                           url: WebUri(
//                                               "https://lcpmapapi.ariespro.com/main/change_order_view/CIVM_Map/USRQWXH589Z/$id"),
//                                           //crew id in place of id in above line
//                                           settings: ChromeSafariBrowserSettings(
//                                               shareState: CustomTabsShareState
//                                                   .SHARE_STATE_OFF,
//                                               barCollapsingEnabled: true));
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
//                                         child: const Align(
//                                           alignment: Alignment.centerLeft,
//                                           child: Text(
//                                             'Offline Maintenance Map',
//                                             style: TextStyle(
//                                                 fontSize: 22,
//                                                 color: Colors.white,
//                                                 fontWeight: FontWeight.w800),
//                                           ),
//                                         )),
//                                   ),
//                                 ),
//                               ),

//                               Visibility(
//                                 visible: _isVisibleIVMMap,
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
//                                     onTap: () async {
//                                       String id = '';
//                                       final userPreferences1 =
//                                           Provider.of<UserPref>(context,
//                                               listen: false);
//                                       UserModel data =
//                                           await userPreferences1.getUser();
//                                       id = data.user!.id.toString();
//                                       //  Navigator.push(
//                                       //   context,
//                                       //   MaterialPageRoute(
//                                       //     builder: (context) => MapViewPage(
//                                       //       url:
//                                       //           "https://lcpmapapi.ariespro.com/main/ivm_map_view/CIVM_Map/USRQWXH589Z/$id",
//                                       //     ),
//                                       //   ),
//                                       // );
//                                       await browser.open(
//                                           url: WebUri(
//                                               "https://lcpmapapi.ariespro.com/main/ivm_map_view/CIVM_Map/USRQWXH589Z/$id"),
//                                           //crew id in place of id in above line
//                                           settings: ChromeSafariBrowserSettings(
//                                               shareState: CustomTabsShareState
//                                                   .SHARE_STATE_OFF,
//                                               barCollapsingEnabled: true));
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
//                                         child: const Align(
//                                           alignment: Alignment.centerLeft,
//                                           child: Text(
//                                             'IVM Offline Map',
//                                             style: TextStyle(
//                                                 fontSize: 22,
//                                                 color: Colors.white,
//                                                 fontWeight: FontWeight.w800),
//                                           ),
//                                         )),
//                                   ),
//                                 ),
//                               ),

//                               Visibility(
//                                 visible: _isVisibleSprayMap,
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
//                                     onTap: () async {
//                                       String id = '';
//                                       final userPreferences1 =
//                                           Provider.of<UserPref>(context,
//                                               listen: false);
//                                       UserModel data =
//                                           await userPreferences1.getUser();
//                                       id = data.user!.id.toString();
//                                       //  Navigator.push(
//                                       //   context,
//                                       //   MaterialPageRoute(
//                                       //     builder: (context) => MapViewPage(
//                                       //       url:
//                                       //            "https://lcpmapapi.ariespro.com/main/mid_cycle/CIVM_Map/USRQWXH589Z/$id",
//                                       //     ),
//                                       //   ),
//                                       // );
//                                       await browser.open(
//                                           url: WebUri(
//                                               "https://lcpmapapi.ariespro.com/main/mid_cycle/CIVM_Map/USRQWXH589Z/$id"),
//                                           //crew id in place of id in above line
//                                           settings: ChromeSafariBrowserSettings(
//                                               shareState: CustomTabsShareState
//                                                   .SHARE_STATE_OFF,
//                                               barCollapsingEnabled: true));
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
//                                         child: const Align(
//                                           alignment: Alignment.centerLeft,
//                                           child: Text(
//                                             'Herbicide Offline Map',
//                                             style: TextStyle(
//                                                 fontSize: 22,
//                                                 color: Colors.white,
//                                                 fontWeight: FontWeight.w800),
//                                           ),
//                                         )),
//                                   ),
//                                 ),
//                               ),

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
//                                       Navigator.of(context).push(MaterialPageRoute(
//                                           builder: (BuildContext context) =>
//                                               CreateOrderContractorWithoutData(
//                                                   subStation: '',
//                                                   serviceStreetAddress: '',
//                                                   serviceMapLocation: '',
//                                                   notes: '',
//                                                   type: '',
//                                                   maintType: '',
//                                                   contractorCompany: '',
//                                                   assignForeman: '')));
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
//                                 Visibility(
//                                   visible: _isVisibleInitiated,
//                                   child: Container(
//                                     margin: const EdgeInsets.only(
//                                         left: 8, right: 8, top: 10, bottom: 8),
//                                     decoration: const BoxDecoration(
//                                         // shape: BoxShape.circle,
//                                         borderRadius: BorderRadius.only(
//                                             // topRight: Radius.circular(50),
//                                             // bottomLeft: Radius.circular(50)
//                                             ),
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
//                                             Color.fromARGB(255, 7, 59, 120),
//                                             Color.fromARGB(255, 7, 59, 120)
//                                           ],
//                                         )),
//                                     child: InkWell(
//                                       onTap: () {
//                                         Navigator.of(context).push(
//                                             MaterialPageRoute(
//                                                 builder: (BuildContext
//                                                         context) =>
//                                                     TotalOrderIniciatedGF(
//                                                         budgetType:
//                                                             widget.budgetType,
//                                                         maintenanceType: widget
//                                                             .maintenanceType,
//                                                         heading:
//                                                             'Total Order Initiated (${widget.heading})')));
//                                       },
//                                       child: Container(
//                                           decoration: BoxDecoration(
//                                             border: Border.all(
//                                               color: Colors.white,
//                                             ),
//                                             boxShadow: const [
//                                               BoxShadow(
//                                                   color: Color.fromARGB(
//                                                       255, 3, 47, 97),
//                                                   blurRadius: 10,
//                                                   offset: Offset(2.0, 5.0))
//                                             ],
//                                             image: DecorationImage(
//                                               image: const AssetImage(
//                                                   'assets/Dash_1.jpg'),
//                                               fit: BoxFit.cover,
//                                               colorFilter: ColorFilter.mode(
//                                                   Colors.black
//                                                       .withOpacity(0.45),
//                                                   BlendMode.darken),
//                                             ),
//                                           ),
//                                           margin: const EdgeInsets.only(
//                                               left: 8,
//                                               right: 8,
//                                               top: 10,
//                                               bottom: 8),
//                                           padding: const EdgeInsets.all(8),
//                                           alignment: Alignment.center,
//                                           height: size.height * 0.15,
//                                           width: size.width * 0.99,
//                                           child: Stack(children: [
//                                             Row(
//                                               children: [
//                                                 const Expanded(
//                                                   child: Text(
//                                                     'Total Order (Initiated)',
//                                                     style: TextStyle(
//                                                         fontSize: 22,
//                                                         color: Colors.white,
//                                                         fontWeight:
//                                                             FontWeight.w800),
//                                                   ),
//                                                 ),
//                                                 Text(
//                                                   (lCPViewModel
//                                                               .lcpCountList
//                                                               .data!
//                                                               .countOfInitiatedOrder![
//                                                                   0]
//                                                               .toString() ==
//                                                           'null')
//                                                       ? ''
//                                                       : lCPViewModel
//                                                           .lcpCountList
//                                                           .data!
//                                                           .countOfInitiatedOrder![
//                                                               0]
//                                                           .toString(),
//                                                   style: const TextStyle(
//                                                       fontSize: 22,
//                                                       color: Colors.white,
//                                                       fontWeight:
//                                                           FontWeight.w800),
//                                                 ),
//                                               ],
//                                             )
//                                           ])),
//                                     ),
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
//                                       if (widget.maintenanceType ==
//                                           'ChangeOrder') {
//                                         Navigator.of(context).push(
//                                             MaterialPageRoute(
//                                                 builder: (BuildContext
//                                                         context) =>
//                                                     TotalOrderPendingCO(
//                                                         budgetType:
//                                                             widget.budgetType,
//                                                         maintenanceType: widget
//                                                             .maintenanceType,
//                                                         heading:
//                                                             'Total Order Pending (${widget.heading})')));
//                                       } else {
//                                         Navigator.of(context).push(
//                                             MaterialPageRoute(
//                                                 builder: (BuildContext
//                                                         context) =>
//                                                     TotalOrderPendingContractor(
//                                                       budgetType:
//                                                           widget.budgetType,
//                                                       maintenanceType: widget
//                                                           .maintenanceType,
//                                                       heading:
//                                                           'Total Order Pending (${widget.heading})',
//                                                     )));
//                                         print(
//                                             "required data pending${widget.budgetType},${widget.maintenanceType},${'Total Order Pending (${widget.heading})'}");
//                                       }
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
//                                           .countOfPendingZieliesAssignment![0] >
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
//                                       Navigator.of(context).push(
//                                           MaterialPageRoute(
//                                               builder: (BuildContext context) =>
//                                                   TotalOrderPendingZieliesAssignment(
//                                                     budgetType:
//                                                         widget.budgetType,
//                                                     maintenanceType:
//                                                         widget.maintenanceType,
//                                                     heading:
//                                                         'Pending Zielies Assignment(${widget.heading})',
//                                                   )));
//                                       print(
//                                           "required data pending${widget.budgetType},${widget.maintenanceType},${'Total Order Pending (${widget.heading})'}");
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
//                                               Expanded(
//                                                 child: Text(
//                                                   'Pending Zielies Assignment',
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
//                                                             .countOfPendingZieliesAssignment![
//                                                                 0]
//                                                             .toString() ==
//                                                         'null')
//                                                     ? ''
//                                                     : lCPViewModel
//                                                         .lcpCountList
//                                                         .data!
//                                                         .countOfPendingZieliesAssignment![
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
//                                           .countOfPendingZieliesAssignment![0] >
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
//                                       Navigator.of(context).push(
//                                           MaterialPageRoute(
//                                               builder: (BuildContext context) =>
//                                                   TotalOrderPendingLCPInspection(
//                                                     budgetType:
//                                                         widget.budgetType,
//                                                     maintenanceType:
//                                                         widget.maintenanceType,
//                                                     heading:
//                                                         'Pending LCP Inspection(${widget.heading})',
//                                                   )));
//                                       print(
//                                           "required data pending${widget.budgetType},${widget.maintenanceType},${'Total Order Pending (${widget.heading})'}");
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
//                                               Expanded(
//                                                 child: Text(
//                                                   'Pending LCP Inspection',
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
//                                                             .countOfPendingLCPInspection![
//                                                                 0]
//                                                             .toString() ==
//                                                         'null')
//                                                     ? ''
//                                                     : lCPViewModel
//                                                         .lcpCountList
//                                                         .data!
//                                                         .countOfPendingLCPInspection![
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
//                                           .countOfCompletedOrder![0] >
//                                       0)
//                                 Visibility(
//                                   visible: _isVisibleComplete,
//                                   child: Container(
//                                     margin: const EdgeInsets.only(
//                                         left: 8, right: 8, top: 10, bottom: 8),
//                                     decoration: const BoxDecoration(
//                                         // shape: BoxShape.circle,
//                                         borderRadius: BorderRadius.only(
//                                             // topRight: Radius.circular(50),
//                                             // bottomLeft: Radius.circular(50)
//                                             ),
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
//                                             Color.fromARGB(255, 7, 59, 120),
//                                             Color.fromARGB(255, 7, 59, 120)
//                                           ],
//                                         )),
//                                     child: InkWell(
//                                       onTap: () {
//                                         Navigator.of(context).push(MaterialPageRoute(
//                                             builder: (BuildContext context) =>
//                                                 TotalOrderCompletedContractor(
//                                                     budgetType:
//                                                         widget.budgetType,
//                                                     maintenanceType:
//                                                         widget.maintenanceType,
//                                                     heading:
//                                                         'Total Order Inspection (${widget.heading})')));
//                                         print(
//                                             "required data${widget.budgetType},${widget.maintenanceType},${'Total Order Completed (${widget.heading})'}");
//                                       },
//                                       child: Container(
//                                           decoration: BoxDecoration(
//                                             border: Border.all(
//                                               color: Colors.white,
//                                             ),
//                                             boxShadow: const [
//                                               BoxShadow(
//                                                   color: Color.fromARGB(
//                                                       255, 3, 47, 97),
//                                                   blurRadius: 10,
//                                                   offset: Offset(2.0, 5.0))
//                                             ],
//                                             image: DecorationImage(
//                                               image: const AssetImage(
//                                                   'assets/Dash_5.jpg'),
//                                               fit: BoxFit.cover,
//                                               colorFilter: ColorFilter.mode(
//                                                   Colors.black
//                                                       .withOpacity(0.45),
//                                                   BlendMode.darken),
//                                             ),
//                                           ),
//                                           margin: const EdgeInsets.only(
//                                               left: 8,
//                                               right: 8,
//                                               top: 10,
//                                               bottom: 8),
//                                           padding: const EdgeInsets.all(8),
//                                           alignment: Alignment.center,
//                                           height: size.height * 0.15,
//                                           width: size.width * 0.99,
//                                           child: Stack(children: [
//                                             Row(
//                                               children: [
//                                                 const Expanded(
//                                                   child: Text(
//                                                     'Total Order (Inspection pending)',
//                                                     style: TextStyle(
//                                                         fontSize: 22,
//                                                         color: Colors.white,
//                                                         fontWeight:
//                                                             FontWeight.w800),
//                                                   ),
//                                                 ),
//                                                 Text(
//                                                   (lCPViewModel
//                                                               .lcpCountList
//                                                               .data!
//                                                               .countOfCompletedOrder![
//                                                                   0]
//                                                               .toString() ==
//                                                           'null')
//                                                       ? ''
//                                                       : lCPViewModel
//                                                           .lcpCountList
//                                                           .data!
//                                                           .countOfCompletedOrder![
//                                                               0]
//                                                           .toString(),
//                                                   style: const TextStyle(
//                                                       fontSize: 22,
//                                                       color: Colors.white,
//                                                       fontWeight:
//                                                           FontWeight.w800),
//                                                 ),
//                                               ],
//                                             )
//                                           ])),
//                                     ),
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
//                                       if (widget.maintenanceType ==
//                                           'ChangeOrder') {
//                                         Navigator.of(context).push(
//                                             MaterialPageRoute(
//                                                 builder: (BuildContext
//                                                         context) =>
//                                                     TotalOrderRejectedCO(
//                                                         budgetType:
//                                                             widget.budgetType,
//                                                         maintenanceType: widget
//                                                             .maintenanceType,
//                                                         heading:
//                                                             'Total Order Rejected (${widget.heading})')));
//                                       } else {
//                                         Navigator.of(context).push(MaterialPageRoute(
//                                             builder: (BuildContext context) =>
//                                                 TotalOrderRejectedContractor(
//                                                     budgetType:
//                                                         widget.budgetType,
//                                                     maintenanceType:
//                                                         widget.maintenanceType,
//                                                     heading:
//                                                         'Total Order Rejected (${widget.heading})')));
//                                       }
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
//                                                   'Zielies Order (Rejected)',
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
//                                       if (widget.maintenanceType ==
//                                           'ChangeOrder') {
//                                         Navigator.of(context).push(
//                                             MaterialPageRoute(
//                                                 builder: (BuildContext
//                                                         context) =>
//                                                     TotalOrderClosedCO(
//                                                         budgetType:
//                                                             widget.budgetType,
//                                                         maintenanceType: widget
//                                                             .maintenanceType,
//                                                         heading:
//                                                             'Total Order Closed (${widget.heading})')));
//                                       } else {
//                                         Navigator.of(
//                                                 context)
//                                             .push(MaterialPageRoute(
//                                                 builder: (BuildContext
//                                                         context) =>
//                                                     TotalOrderClosedContractor(
//                                                         budgetType:
//                                                             widget.budgetType,
//                                                         maintenanceType: widget
//                                                             .maintenanceType,
//                                                         heading:
//                                                             'Total Order Completed (${widget.heading})')));
//                                         print(
//                                             "required data closed${widget.budgetType},${widget.maintenanceType},${'Total Order Closed (${widget.heading})'}");
//                                       }
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
//                                                 'assets/Dash_1.jpg'),
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
//                                                   'Total Orders (Completed)',
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
//                                                             .countOfCompletedOrder![
//                                                                 0]
//                                                             .toString() ==
//                                                         'null')
//                                                     ? ''
//                                                     : lCPViewModel
//                                                         .lcpCountList
//                                                         .data!
//                                                         .countOfCompletedOrder![
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
//                                           .countOfCancelledOrder![0] >
//                                       0)
//                                 Visibility(
//                                   visible: _isVisibleCancel,
//                                   child: Container(
//                                     margin: const EdgeInsets.only(
//                                         left: 8, right: 8, top: 10, bottom: 8),
//                                     decoration: const BoxDecoration(
//                                         // shape: BoxShape.circle,
//                                         borderRadius: BorderRadius.only(
//                                             // topRight: Radius.circular(50),
//                                             // bottomLeft: Radius.circular(50)
//                                             ),
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
//                                             Color.fromARGB(255, 7, 59, 120),
//                                             Color.fromARGB(255, 7, 59, 120)
//                                           ],
//                                         )),
//                                     child: InkWell(
//                                       onTap: () {
//                                         Navigator.of(context).push(
//                                             MaterialPageRoute(
//                                                 builder: (BuildContext
//                                                         context) =>
//                                                     TotalOrderCanceledGF(
//                                                         budgetType:
//                                                             widget.budgetType,
//                                                         maintenanceType: widget
//                                                             .maintenanceType,
//                                                         heading:
//                                                             'Total Order Cancelled (${widget.heading})')));
//                                       },
//                                       child: Container(
//                                           decoration: BoxDecoration(
//                                             border: Border.all(
//                                               color: Colors.white,
//                                             ),
//                                             boxShadow: const [
//                                               BoxShadow(
//                                                   color: Color.fromARGB(
//                                                       255, 3, 47, 97),
//                                                   blurRadius: 10,
//                                                   offset: Offset(2.0, 5.0))
//                                             ],
//                                             image: DecorationImage(
//                                               image: const AssetImage(
//                                                   'assets/Dash_6.jpg'),
//                                               fit: BoxFit.cover,
//                                               colorFilter: ColorFilter.mode(
//                                                   Colors.black
//                                                       .withOpacity(0.45),
//                                                   BlendMode.darken),
//                                             ),
//                                           ),
//                                           margin: const EdgeInsets.only(
//                                               left: 8,
//                                               right: 8,
//                                               top: 10,
//                                               bottom: 8),
//                                           padding: const EdgeInsets.all(8),
//                                           alignment: Alignment.center,
//                                           height: size.height * 0.15,
//                                           width: size.width * 0.99,
//                                           child: Stack(children: [
//                                             Row(
//                                               children: [
//                                                 const Expanded(
//                                                   child: Text(
//                                                     'Total Orders (Cancelled)',
//                                                     style: TextStyle(
//                                                         fontSize: 22,
//                                                         color: Colors.white,
//                                                         fontWeight:
//                                                             FontWeight.w800),
//                                                   ),
//                                                 ),
//                                                 Text(
//                                                   (lCPViewModel
//                                                               .lcpCountList
//                                                               .data!
//                                                               .countOfCancelledOrder![
//                                                                   0]
//                                                               .toString() ==
//                                                           'null')
//                                                       ? ''
//                                                       : lCPViewModel
//                                                           .lcpCountList
//                                                           .data!
//                                                           .countOfCancelledOrder![
//                                                               0]
//                                                           .toString(),
//                                                   style: const TextStyle(
//                                                       fontSize: 22,
//                                                       color: Colors.white,
//                                                       fontWeight:
//                                                           FontWeight.w800),
//                                                 ),
//                                               ],
//                                             )
//                                           ])),
//                                     ),
//                                   ),
//                                 ),
//                               //  'CO - Total Inspection (Canceled)
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

//   Future<void> getContractorDataCount() async {
//     final userPreferences = Provider.of<UserPref>(context, listen: false);
//     UserModel data = await userPreferences.getUser();

//     String id = data.user!.id.toString();

//     lCPViewModel.fetchLCPcountApi(
//         context,
//         '',
//         '',
//         widget.budgetType,
//         widget.maintenanceType,
//         // 'Change Order',
//         id,
//         'generalforeman',
//         '');
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
//                 menuLogoLCP(),
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
//           // ListTile(
//           //   leading: const Icon(
//           //     Icons.pending,
//           //   ),
//           //   title: const Text('Change Order Pending'),
//           //   textColor: const Color.fromARGB(255, 7, 59, 120),
//           //   iconColor: const Color.fromARGB(255, 7, 59, 120),
//           //   onTap: () {
//           //     Navigator.of(context).push(MaterialPageRoute(
//           //         builder: (BuildContext context) =>
//           //             const WorkOrderPendingContractor()));
//           //   },
//           // ),
//           // Visibility(
//           //   visible: (widget.menu.isNotEmpty &&
//           //           widget.menu.contains('Energy Audit Ticket'))
//           //       ? true
//           //       : false,
//           // child:
//           // ListTile(
//           //   leading: const Icon(
//           //     Icons.running_with_errors,
//           //   ),
//           //   title: const Text('IVM Maintenance Progress'),
//           //   textColor: const Color.fromARGB(255, 7, 59, 120),
//           //   iconColor: const Color.fromARGB(255, 7, 59, 120),
//           //   onTap: () {
//           //     Navigator.of(context).push(MaterialPageRoute(
//           //         builder: (BuildContext context) =>
//           //             const RowMaintenanceProgressContractor()));
//           //   },
//           // ),
//           // ),
//           ListTile(
//             leading: const Icon(
//               Icons.report,
//             ),
//             title: const Text('Maintenance Report View'),
//             textColor: const Color.fromARGB(255, 7, 59, 120),
//             iconColor: const Color.fromARGB(255, 7, 59, 120),
//             onTap: () {
//               Navigator.of(context).push(MaterialPageRoute(
//                   builder: (BuildContext context) =>
//                       const GfMaintenanceReportViewNew()));
//             },
//           ),
//           ListTile(
//             leading: const Icon(
//               Icons.change_circle,
//             ),
//             title: const Text('IVM/Change Order'),
//             textColor: const Color.fromARGB(255, 7, 59, 120),
//             iconColor: const Color.fromARGB(255, 7, 59, 120),
//             onTap: () {
//               Navigator.pop(context);
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
//               Icons.map,
//             ),
//             title: const Text('Live IVM System Map'),
//             textColor: const Color.fromARGB(255, 7, 59, 120),
//             iconColor: const Color.fromARGB(255, 7, 59, 120),
//             onTap: () {
//               provider.getLocation();
//               Navigator.of(context).push(MaterialPageRoute(
//                   builder: (context) => const MapScreenLeafLat()));
//             },
//           ),
//           ListTile(
//             leading: const Icon(
//               Icons.add,
//             ),
//             title: const Text('Add Crew Member'),
//             textColor: const Color.fromARGB(255, 7, 59, 120),
//             iconColor: const Color.fromARGB(255, 7, 59, 120),
//             onTap: () {
//               Navigator.of(context).push(MaterialPageRoute(
//                   builder: (BuildContext context) => const GFAddCrewMember()));
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
