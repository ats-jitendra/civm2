// import 'package:civm/models/user_model.dart';
// import 'package:civm/screens/login_page.dart';
// import 'package:civm/screens/planner_pannel.dart/planner_add_new_row_maintenance_plan.dart';
// import 'package:civm/screens/planner_pannel.dart/planner_row_maintenance_plan.dart';
// import 'package:civm/utils/user_pref.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class PlannerAddNewRowMaintenanceMap extends StatefulWidget {
//   const PlannerAddNewRowMaintenanceMap({super.key});

//   @override
//   State<PlannerAddNewRowMaintenanceMap> createState() =>
//       _PlannerAddNewRowMaintenanceMapState();
// }

// class _PlannerAddNewRowMaintenanceMapState
//     extends State<PlannerAddNewRowMaintenanceMap> {
//       List<String> menu = [];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(   iconTheme: const IconThemeData(color: Colors.white),
//           title: const Text(
//             'Map',
//             style: TextStyle(
//               color: Colors.white,
//             ),
//           ),
//           backgroundColor: const Color.fromARGB(255, 7, 59, 120),),
//       drawer: DrawerManu(menu: menu),
       
//         body: Container(),
//     );
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
//             title: const Text('Row Maintenance Plan'),
//             textColor: const Color.fromARGB(255, 7, 59, 120),
//             iconColor: const Color.fromARGB(255, 7, 59, 120),
//             onTap: () {
//                Navigator.of(context).push(MaterialPageRoute(
//                   builder: (BuildContext context) =>
//                       const PlannerRowMaintenanceView()));
//             },
//           ),
//           ListTile(
//             leading: const Icon(
//               Icons.airplane_ticket_sharp,
//             ),
//             title: const Text('Add New Row Maintenance Plan'),
//             textColor: const Color.fromARGB(255, 7, 59, 120),
//             iconColor: const Color.fromARGB(255, 7, 59, 120),
//             onTap: () {
//               Navigator.of(context).push(MaterialPageRoute(
//                   builder: (BuildContext context) =>
//                       PlannerAddNewRowMaintenancePlan(
//                         tokenNo: '',
//                         index: '0',
//                         subStation: '',
//                         feeder: '',
//                         nextMaintYear: '',
//                         maintType: '',
//                         totalMiles: '',
//                         costPerMile: '',
//                         totalCost: '',
//                         budgetType: '',
//                         contractRowYear: '',
//                         rowCycle: '',
//                         rowYear: '',
//                         contractorCompany: '',
//                         assignForeman: '',
//                       )));
//             },
//           ),
//                ListTile(
//             leading: const Icon(
//               Icons.open_in_new,
//             ),
//             title: const Text('Add New Row Maintenance Map'),
//             textColor: const Color.fromARGB(255, 7, 59, 120),
//             iconColor: const Color.fromARGB(255, 7, 59, 120),
//             onTap: () {
//                Navigator.pop(context);
          
//             },
//           ),
       

//           ListTile(
//             leading: const Icon(
//               Icons.logout,
//             ),
//             title: const Text('Logout'),
//             textColor: const Color.fromARGB(255, 7, 59, 120),
//             iconColor: const Color.fromARGB(255, 7, 59, 120),
//             onTap: () {
//               // Constants.prefs.setBool("LoggedIn", false);
//               userPreferences.remove().then((value) {
//                 // ignore: use_build_context_synchronously
//                 // Navigator.pushReplacement(context, RoutesName.login);
//                 // Navigator.pushNamed(
//                 //     context, RoutesName.login);
//                 Navigator.of(context).push(MaterialPageRoute(
//                     builder: (BuildContext context) => const LoginPage()));
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
