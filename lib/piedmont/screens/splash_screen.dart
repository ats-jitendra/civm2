// // ignore_for_file: use_build_context_synchronously

// import 'package:CIVM/piedmont/resources/app_colors.dart';
// import 'package:CIVM/piedmont/sharedPrefs/constants.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// import 'package:CIVM/piedmont/services/splash_services.dart';
// // import 'package:shared_preferences/shared_preferences.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({Key? key}) : super(key: key);

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   SplashServices splashServices = SplashServices();

//   @override
//   void initState() {
//     super.initState();
//     Constants.prefs.setString("VERSION", '1.0.0');
//     Constants.prefs.setString("VERSION_DATE", '03/20/2026');
//     splashServices.checkAuthentication(context);
//   }

//   @override
//   Widget build(BuildContext context) {
//     SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
//      systemNavigationBarColor:AppColors.baseColor, // navigation bar color
//         statusBarColor: AppColors.baseColor,));
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//         backgroundColor: Colors.white,
//         body: Container(
//           padding: const EdgeInsets.all(8),
//           decoration: const BoxDecoration(
//               image: DecorationImage(
//             image: AssetImage('assets/designNew update.jpg'),
//             fit: BoxFit.cover,
//           )),
//           child: Column(
//             children: [
//               Padding(
//                 padding: EdgeInsets.only(top: size.height * 0.45),
//                 child: const Align(
//                   alignment: Alignment.center,
//                   child: Text(
//                     "Piedmont Electric Cooperative",
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//               const Expanded(
//                 child: Center(
//                   child: Text(
//                     '',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//               const Align(
//                 alignment: Alignment.bottomCenter,
//                 child: Text(
//                   "Powered By AriesPro",
//                   style: TextStyle(
//                     color: AppColors.baseColor,
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ));
//   }
// }
