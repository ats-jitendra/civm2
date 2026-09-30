
// import 'package:CIVM/piedmont/screens/admin_pannel/row_maintenance_view/ins_lcp_herbicide.dart';
// import 'package:CIVM/piedmont/screens/admin_pannel/row_maintenance_view/ins_lcp_ivm.dart';
// import 'package:CIVM/piedmont/screens/admin_pannel/row_maintenance_view/inspection_lcp_change_order.dart';

// import 'package:flutter/material.dart';

// import '../../../view_model/lcp_view_model.dart';
// import 'package:CIVM/piedmont/resources/app_colors.dart';


// class InspectionLCP extends StatefulWidget {
//   const InspectionLCP({Key? key}) : super(key: key);

//   @override
//   State<InspectionLCP> createState() => _InspectionLCPState();
// }

// class _InspectionLCPState extends State<InspectionLCP> {
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
//     //  lCPViewModel.fetchLCPcountApi(context, '', '');
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       backgroundColor: AppColors.backgroundColor,
//       appBar: AppBar(
//         iconTheme: const IconThemeData(color: Colors.white),
//         title: const Text(
//           'LCP',
//           style: TextStyle(color: Colors.white),
//         ),
//         backgroundColor: AppColors.baseColor,
//       ),
//       //   drawer: DrawerManu(menu: menu),
//       body: Stack(fit: StackFit.expand, children: [
//         SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(4.0),
//             child: Column(
//               children: [
//                 Container(
//                   margin: const EdgeInsets.only(
//                       left: 8, right: 8, top: 10, bottom: 8),
//                   decoration: const BoxDecoration(
//                       // shape: BoxShape.circle,
//                       borderRadius: BorderRadius.only(
//                           // topRight: Radius.circular(50),
//                           // bottomLeft: Radius.circular(50)
//                           ),
//                       boxShadow: [
//                         BoxShadow(
//                             color: Color.fromARGB(255, 3, 47, 97),
//                             blurRadius: 5,
//                             offset: Offset(2.0, 5.0))
//                       ],
//                       color: Color.fromARGB(255, 130, 193, 245),
//                       gradient: LinearGradient(
//                         colors: [
//                           AppColors.baseColor,
//                           Color.fromARGB(255, 7, 59, 120)
//                         ],
//                       )),
//                   child: InkWell(
//                     onTap: () {
//                       Navigator.of(context).push(MaterialPageRoute(
//                           builder: (BuildContext context) =>
//                               const InspectionLCPChangeOrder()));
//                     },
//                     child: Container(
//                         decoration: BoxDecoration(
//                           border: Border.all(
//                             color: Colors.white,
//                           ),
//                           boxShadow: const [
//                             BoxShadow(
//                                 color: Color.fromARGB(255, 3, 47, 97),
//                                 blurRadius: 10,
//                                 offset: Offset(2.0, 5.0))
//                           ],
//                           image: DecorationImage(
//                             image: const AssetImage('assets/Dash_2.jpg'),
//                             fit: BoxFit.cover,
//                             colorFilter: ColorFilter.mode(
//                                 Colors.black.withOpacity(0.45),
//                                 BlendMode.darken),
//                           ),
//                         ),
//                         margin: const EdgeInsets.only(
//                             left: 8, right: 8, top: 10, bottom: 8),
//                         padding: const EdgeInsets.all(8),
//                         alignment: Alignment.center,
//                         height: size.height * 0.15,
//                         width: size.width * 0.99,
//                         child: const Stack(children: [
//                           Text(
//                             'Change Order',
//                             style: TextStyle(
//                                 fontSize: 22,
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.w800),
//                           )
//                         ])),
//                   ),
//                 ),
//                 Container(
//                   margin: const EdgeInsets.only(
//                       left: 8, right: 8, top: 10, bottom: 8),
//                   decoration: const BoxDecoration(
//                       // shape: BoxShape.circle,
//                       borderRadius: BorderRadius.only(
//                           // topRight: Radius.circular(50),
//                           // bottomLeft: Radius.circular(50)
//                           ),
//                       boxShadow: [
//                         BoxShadow(
//                             color: Color.fromARGB(255, 3, 47, 97),
//                             blurRadius: 5,
//                             offset: Offset(2.0, 5.0))
//                       ],
//                       color: Color.fromARGB(255, 130, 193, 245),
//                       gradient: LinearGradient(
//                         colors: [
//                           AppColors.baseColor,
//                           Color.fromARGB(255, 7, 59, 120)
//                         ],
//                       )),
//                   child: InkWell(
//                     onTap: () {
//                       Navigator.of(context).push(MaterialPageRoute(
//                           builder: (BuildContext context) =>
//                               const InsLCPIVM()));
//                     },
//                     child: Container(
//                         decoration: BoxDecoration(
//                           border: Border.all(
//                             color: Colors.white,
//                           ),
//                           boxShadow: const [
//                             BoxShadow(
//                                 color: Color.fromARGB(255, 3, 47, 97),
//                                 blurRadius: 10,
//                                 offset: Offset(2.0, 5.0))
//                           ],
//                           image: DecorationImage(
//                             image: const AssetImage('assets/Dash_4.jpg'),
//                             fit: BoxFit.cover,
//                             colorFilter: ColorFilter.mode(
//                                 Colors.black.withOpacity(0.45),
//                                 BlendMode.darken),
//                           ),
//                         ),
//                         margin: const EdgeInsets.only(
//                             left: 8, right: 8, top: 10, bottom: 8),
//                         padding: const EdgeInsets.all(8),
//                         alignment: Alignment.center,
//                         height: size.height * 0.15,
//                         width: size.width * 0.99,
//                         child: const Stack(children: [
//                           Text(
//                             'IVM Maintenance',
//                             style: TextStyle(
//                                 fontSize: 22,
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.w800),
//                           )
//                         ])),
//                   ),
//                 ),
//                 Container(
//                   margin: const EdgeInsets.only(
//                       left: 8, right: 8, top: 10, bottom: 8),
//                   decoration: const BoxDecoration(
//                       // shape: BoxShape.circle,
//                       borderRadius: BorderRadius.only(
//                           // topRight: Radius.circular(50),
//                           // bottomLeft: Radius.circular(50)
//                           ),
//                       boxShadow: [
//                         BoxShadow(
//                             color: Color.fromARGB(255, 3, 47, 97),
//                             blurRadius: 5,
//                             offset: Offset(2.0, 5.0))
//                       ],
//                       color: Color.fromARGB(255, 130, 193, 245),
//                       gradient: LinearGradient(
//                         colors: [
//                           AppColors.baseColor,
//                           Color.fromARGB(255, 7, 59, 120)
//                         ],
//                       )),
//                   child: InkWell(
//                     onTap: () {
//                       Navigator.of(context).push(MaterialPageRoute(
//                           builder: (BuildContext context) =>
//                               const InsLCPHerbicide()));
//                     },
//                     child: Container(
//                         decoration: BoxDecoration(
//                           border: Border.all(
//                             color: Colors.white,
//                           ),
//                           boxShadow: const [
//                             BoxShadow(
//                                 color: Color.fromARGB(255, 3, 47, 97),
//                                 blurRadius: 10,
//                                 offset: Offset(2.0, 5.0))
//                           ],
//                           image: DecorationImage(
//                             image: const AssetImage('assets/Dash_3.png'),
//                             fit: BoxFit.cover,
//                             colorFilter: ColorFilter.mode(
//                                 Colors.black.withOpacity(0.45),
//                                 BlendMode.darken),
//                           ),
//                         ),
//                         margin: const EdgeInsets.only(
//                             left: 8, right: 8, top: 10, bottom: 8),
//                         padding: const EdgeInsets.all(8),
//                         alignment: Alignment.center,
//                         height: size.height * 0.15,
//                         width: size.width * 0.99,
//                         child: const Stack(children: [
//                           Text(
//                             'Herbicide',
//                             style: TextStyle(
//                                 fontSize: 22,
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.w800),
//                           )
//                         ])),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ]),
//     );
//   }
// }

