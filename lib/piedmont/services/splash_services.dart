// // ignore_for_file: use_build_context_synchronously

// import 'package:CIVM/piedmont/screens/admin_pannel/row_maintenance_view/admin_pannel.dart';
// import 'package:CIVM/piedmont/screens/crew_pannel/crew_bottom_navigation_pannel.dart';
// import 'package:CIVM/piedmont/screens/generalForeman_New_pannel/contractor_bottom_navigation.dart';
// import 'package:CIVM/piedmont/screens/login_page.dart';
// import 'package:CIVM/piedmont/screens/planner_pannel.dart/planner_bottom_navigation.dart';
// import 'package:CIVM/piedmont/screens/supervisor_pannel/supervisor_bottom_navigation_pannel.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';

// import 'package:CIVM/piedmont/models/user_model.dart';
// import 'package:CIVM/piedmont/utils/routes/route_name.dart';
// import 'package:CIVM/piedmont/utils/user_pref.dart';

// class SplashServices {
//   Future<UserModel> getUserData() => UserPrefPemc().getUser();

//   void checkAuthentication(BuildContext context) async {
//     getUserData().then((value) async {
//       if (value.token == 'null' || value.token == '') {
//         await Future.delayed(const Duration(seconds: 3));
//         Navigator.of(context).pop();
//          Navigator.pushReplacement(
//                   context,
//                   MaterialPageRoute(
//                       builder: (BuildContext contex) => const LoginPagePemc()));
//        // Navigator.pushNamed(context, RoutesNamePemc.loginPemc);
//       } else {
//         await Future.delayed(const Duration(seconds: 3));

//         if (value.user!.userType == '1' && value.user!.status == 'ACTIVE') {
//           print('1111111111');
//           print(value.user!.userType);
//           print(value.user!.status);
//           Navigator.of(context).pop();
//          // Navigator.pushNamed(context, RoutesNamePemc.adminHome);
//            Navigator.pushReplacement(
//                   context,
//                   MaterialPageRoute(
//                       builder: (BuildContext contex) =>
//                           const EnergyAuditPannel()));
//         } else if (value.user!.userType == '2' &&
//             value.user!.status == 'ACTIVE') {
//           print('22222222222');
//           Navigator.of(context).pop();
//         //  Navigator.pushNamed(context, RoutesNamePemc.supervisorHome);
//          Navigator.pushReplacement(
//                   context,
//                   MaterialPageRoute(
//                       builder: (BuildContext contex) =>
//                           const SupervisorBottomNavigationPannel()));
//         } else if (value.user!.userType == '3' &&
//             value.user!.status == 'ACTIVE') {
//           print('333333333');
//           Navigator.of(context).pop();
//          // Navigator.pushNamed(context, RoutesNamePemc.contractorHome);
//           Navigator.pushReplacement(
//                   context,
//                   MaterialPageRoute(
//                       builder: (BuildContext contex) =>
//                           const ContractorBottomNavigationPannel()));
//         } else if (value.user!.userType == '4' &&
//             value.user!.status == 'ACTIVE') {
//           print('44444444444');
//           Navigator.of(context).pop();
//         //  Navigator.pushNamed(context, RoutesNamePemc.crewHome);
//          Navigator.pushReplacement(
//                   context,
//                   MaterialPageRoute(
//                       builder: (BuildContext contex) =>
//                           const CrewBottomNavigationPannel()));
//         } else if (value.user!.userType == '6' &&
//             value.user!.status == 'ACTIVE') {
//         //  Navigator.pushNamed(context, RoutesNamePemc.plannerHome);
//            Navigator.pushReplacement(
//                   context,
//                   MaterialPageRoute(
//                       builder: (BuildContext contex) =>
//                           const PlannerBottomNavigationPannel()));
//         } else {
//           print('Logged Out');
//           Navigator.of(context).pop();
//           // Navigator.pushNamed(context, RoutesNamePemc.loginPemc);
//             Navigator.pushReplacement(
//                   context,
//                   MaterialPageRoute(
//                       builder: (BuildContext contex) => const LoginPagePemc()));
//         }
//       }
//     }).onError(((error, stackTrace) {
//       if (kDebugMode) {
//         print(error.toString());
//       }
//     }));
//   }
// }
