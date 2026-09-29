// ignore_for_file: use_build_context_synchronously

import 'package:CIVM/screens/offline_map/map_data_base_helper.dart';
import 'package:CIVM/sharedPrefs/constants.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:CIVM/services/splash_services.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashServices splashServices = SplashServices();

  @override
  void initState() {
    super.initState();
    Constants.prefs.setString("VERSION", '1.0.80');
    Constants.prefs.setString("VERSION_DATE", '09/22/2026');
    splashServices.checkAuthentication(context);
    listenToConnectivity();
  }

 void listenToConnectivity() {
    Connectivity().onConnectivityChanged.listen((result) async {
      if (!result.contains(ConnectivityResult.none)) {
        print("Internet Restored ");

        int syncedCount = await DatabaseHelper.instance.syncPendingMapData();
        await DatabaseHelper.instance.syncPendingMessages();
        await DatabaseHelper.instance.syncPendingMarkAsRead();
          await DatabaseHelper.instance.syncPendingChangeOrder();
          await DatabaseHelper.instance.syncPendingReworkCompleted();
            await DatabaseHelper.instance.syncPendingComments();

        print("syncedCount $syncedCount");
        // Show notification
        if (syncedCount > 0) {
          // await NotificationService.showNotification(
          //   title: "Sync Complete*",
          //   body: "$syncedCount offline record(s) uploaded successfully.",
          // );
          // print("$syncedCount offline record(s) uploaded successfully");
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: Color.fromARGB(
          255,
          7,
          59,
          120,
        ), // navigation bar color
        statusBarColor: Color.fromARGB(255, 7, 59, 120),
      ),
    );
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/designNew.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: size.height * 0.45),
              child: const Align(
                alignment: Alignment.center,
                child: Text(
                  "Cloud Integrated Vegetation Management",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const Expanded(
              child: Center(
                child: Text(
                  '',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                "Powered By AriesPro",
                style: TextStyle(
                  color: Color.fromARGB(255, 47, 62, 74),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
