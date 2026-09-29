import 'package:CIVM/firebase_options.dart';
import 'package:CIVM/piedmont/screens/map/provider/location_provider.dart';
import 'package:CIVM/piedmont/view_model/login_view_model.dart';
import 'package:CIVM/screens/map/provider/location_provider.dart';
import 'package:CIVM/screens/offline_map/backgroung_sync.dart';
import 'package:CIVM/screens/splash_screen.dart';
import 'package:CIVM/sharedPrefs/constants.dart';
import 'package:CIVM/utils/routes/route.dart';
import 'package:CIVM/utils/routes/route_name.dart';
import 'package:CIVM/utils/user_pref.dart';
import 'package:CIVM/view_model/login_view_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initializeNotifications();
   Constants.prefs = await SharedPreferences.getInstance();
//  Background worker
  await Workmanager().initialize(
    callbackDispatcher,
    // isInDebugMode: true,
  );
  await Workmanager().registerPeriodicTask(
    "syncTask",
    "syncOfflineData",
    frequency: const Duration(minutes: 15),
  );
  await Constants.init();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => LoginViewModel()),
       ChangeNotifierProvider(create: (_) => LoginViewModelPemc()),
      ChangeNotifierProvider(create: (_) => UserPref()),
      // ChangeNotifierProvider(create: (_) => UserPrefPemc()),
      ChangeNotifierProvider(create: (context) => LocationProvider()),
      ChangeNotifierProvider(create: (context) => LocationProviderPemc()),
    ],
    child: const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "CIVM",
      home: SplashScreen(),
      initialRoute: RoutesName.splash,
      onGenerateRoute: Routes.generateRoute,
    ),
  ));
}

// Future<void> initializeNotifications() async {
//   FirebaseMessaging messaging = FirebaseMessaging.instance;

//   NotificationSettings settings =
//       await messaging.getNotificationSettings();

//   print('Permission Status: ${settings.authorizationStatus}');

//   if (settings.authorizationStatus ==
//       AuthorizationStatus.notDetermined) {
//     await messaging.requestPermission(
//       alert: true,
//       badge: true,
//       sound: true,
//     );
//   }

  // String? token = await messaging.getToken();
  // print("FCM Token: $token");
// }

Future<void> initializeNotifications() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  // Request permission
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );
  print("Permission: ${settings.authorizationStatus}");
  // Enable auto init
  await messaging.setAutoInitEnabled(true);
  // Wait a little for APNS registration
  await Future.delayed(const Duration(seconds: 2));
  String? apns = await messaging.getAPNSToken();
  print("APNS Token: $apns");
  if (apns != null) {
    String? token = await messaging.getToken();
    print("FCM Token: $token");
  } else {
    print("APNS token is NULL");
  }
}

/////
// import 'dart:io';
// import 'package:CIVM/screens/splash_screen.dart';
// import 'package:CIVM/utils/routes/route.dart';
// import 'package:CIVM/utils/routes/route_name.dart';
// import 'package:CIVM/utils/user_pref.dart';
// import 'package:CIVM/view_model/login_view_model.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:provider/provider.dart';

// Future main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   const String oldGenHeapSize = '--old_gen_heap_size=2048';
//   const String maxOldGenHeapSize = '--max_old_gen_heap_size=4096';
//   List<String> args = [oldGenHeapSize, maxOldGenHeapSize, 'your_app.dart'];

//   runApp(MultiProvider(
//     providers: [
//       ChangeNotifierProvider(create: (_) => LoginViewModel()),
//       ChangeNotifierProvider(create: (_) => UserPref())
//     ],
//     child: const GetMaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: "Energy Services",
//       home: SplashScreen(),
//       initialRoute: RoutesName.splash,
//       onGenerateRoute: Routes.generateRoute,
//     ),
//   ));

//   Process.run('dart', args).then((ProcessResult result) {
//     // Handle process result if needed
//     print(result.stdout);
//     print(result.stderr);
//   });
// }
