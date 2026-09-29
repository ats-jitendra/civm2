import 'package:CIVM/screens/offline_map/map_data_base_helper.dart';

import 'package:flutter/material.dart';

// import 'package:flutter_offline/db_get_save_folder/data_base_helper.dart';

import 'package:workmanager/workmanager.dart';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    WidgetsFlutterBinding.ensureInitialized();

    try {
      final syncedCount = await DatabaseHelper.instance.syncPendingMapData();
      await DatabaseHelper.instance.syncPendingMessages();
      await DatabaseHelper.instance.syncPendingMarkAsRead();
      await DatabaseHelper.instance.syncPendingChangeOrder();
      await DatabaseHelper.instance.syncPendingReworkCompleted();
      await DatabaseHelper.instance.syncPendingComments();

      if (syncedCount > 0) {
        // await NotificationService.showNotification(
        //   title: "Sync Complete",
        //   body: "$syncedCount record(s) uploaded successfully(work manager).",
        // );
      } else {
        // await NotificationService.showNotification(
        //   title: "Sync Checked",
        //   body: "No pending records found(work manager).",
        // );
      }

      return true;
    } catch (e, s) {
      print(e);
      print(s);
      return false;
    }
  });
}
//  List<Map<String, dynamic>> apiData = [];
//   Future<void> loadApiData() async {
//     final connectivityResult = await Connectivity().checkConnectivity();

//     if (!connectivityResult.contains(ConnectivityResult.none)) {
//       // Internet available
//       await DatabaseHelper.instance.fetchAndSaveApiData();
//       print("Fetched from API and saved to SQLite");
//     } else {
//       print("Offline - Loading from SQLite");
//     }

//     apiData = await DatabaseHelper.instance.getApiData();

//     // if (mounted) {
//     //   setState(() {});
//     // }
//   }
