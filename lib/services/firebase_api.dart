import 'dart:convert';
import 'dart:io';
import 'package:CIVM/sharedPrefs/constants.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../resources/app_url.dart';

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

//method to initialize notifications
  Future<void> initNotifications() async {
    //request permission for user (will promt user)
    await _firebaseMessaging.requestPermission();
    //fetch the FCM token for this device
    final fCMToken = await _firebaseMessaging.getToken();
    print('Token: $fCMToken');
    initPushNotifications();
    updateLoginToken(fCMToken);
  }

//method to handle message
  void handleMessage(RemoteMessage? message) {
    if (message == null)
      return;
    else {}
  }

//method to initialize background settings
  Future initPushNotifications() async {
    //handle notifications if the app was terminated and now opened
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    //attach event listeners for when a notifications opens the app
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
  }

  Future<void> updateLoginToken(token) async {
    const String baseUrl =
        'api/crew_api/UpdateLoginToken';
    // const String email = 'marry.rose@ariespro.com';
    await Constants.init();
    String emailDynamic = Constants.getEmail();
    print("emailDynamic: $emailDynamic");
    final Uri uri = Uri.parse('$baseUrl?email=$emailDynamic&token=$token');
    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        print('Token updated successfully');
      } else {
        print('Error: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }




//////////////////////////////////////////to send notification in web////////////////////////////////////
  Future<void> fetchWebDeviceToken(String location,String jobCode, String serviceNo, String action) async {
  const String url = 'api/Crew_api/DeviceToken';
  
  try {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List<dynamic> responseData = jsonDecode(response.body);
      List<String> deviceTokens2 = [];

      for (var token in responseData) {
        if (token != null) {
          deviceTokens2.add(token.toString());
        }
      }
       if (deviceTokens2.isNotEmpty) {
        sendNotifications(deviceTokens2, location,  jobCode,  serviceNo, action);
      }

      print("Device Tokens (Flutter): $deviceTokens2");
    } else {
      print("Error: ${response.statusCode} - ${response.body}");
    }
  } catch (e) {
    print("Error retrieving device tokens: $e");
  }
}

Future<void> sendNotifications(
    List<String> tokens, String location, String jobCode, String serviceNoController, String status) async {
  
  // String completionNote = completionNoteController.isNotEmpty ? completionNoteController : "-";
  // String status = statusController;
  String serviceNo = serviceNoController;
  // String notifTitle = "Service order $serviceNo has been created";

  // notifTitle = "$jobCode order for $location was $status";

  final String notifTitle = status;
  final String notifBody  = "$jobCode order for $location was $status";


  try {
    List<Future<void>> notificationRequests = tokens.map((token) async {
      final response = await http.post(
        Uri.parse("api/serviceorder/sendnotification?devicetoken=$token&title=$notifTitle&body=$notifBody"),
        headers: {'Content-Type': 'application/json; charset=utf-8'},
      );

      // **Check for Status Code 200**
      if (response.statusCode == 200) {
        print("Notification sent successfully to: $token");
      } else {
        print("Failed to send notification to $token. Status Code: ${response.statusCode}, Response: ${response.body}");
      }
    }).toList();

    await Future.wait(notificationRequests);
  } catch (error) {
    print("Error sending notifications: $error");
  }
}

 Future<void> fetchWebDeviceTokenOutage(String location,String source, String serviceNo, String action) async {
  const String url = 'api/Crew_api/DeviceToken';
  
  try {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List<dynamic> responseData = jsonDecode(response.body);
      List<String> deviceTokens2 = [];

      for (var token in responseData) {
        if (token != null) {
          deviceTokens2.add(token.toString());
        }
      }
       if (deviceTokens2.isNotEmpty) {
        sendNotificationsOutage(deviceTokens2, location,  source,  serviceNo, action);
      }

      print("Device Tokens (Flutter): $deviceTokens2");
    } else {
      print("Error: ${response.statusCode} - ${response.body}");
    }
  } catch (e) {
    print("Error retrieving device tokens: $e");
  }
}

Future<void> sendNotificationsOutage(
    List<String> tokens, String location, String source, String serviceNoController, String status) async {

  String notifTitle = "A Trouble Call came from $location";
  if(source!='edit outage'){
   notifTitle = "A Trouble Call came from $location";
  }else{
    notifTitle = "A Trouble Call $serviceNoController has been $status from $location";
  }

  try {
    List<Future<void>> notificationRequests = tokens.map((token) async {
      final response = await http.post(
        Uri.parse("api/serviceorder/sendnotification?devicetoken=$token&title=$notifTitle&body=location"),
        headers: {'Content-Type': 'application/json; charset=utf-8'},
      );

      // **Check for Status Code 200**
      if (response.statusCode == 200) {
        print("Notification sent successfully to: $token");
      } else {
        print("Failed to send notification to $token. Status Code: ${response.statusCode}, Response: ${response.body}");
      }
    }).toList();

    await Future.wait(notificationRequests);
  } catch (error) {
    print("Error sending notifications: $error");
  }
}
//////// FirebaseApi().fetchWebDeviceToken('duncanDMS', 'Service Order Created','bkjnj','Pending','123');
///
///
///////////////method to get device token/////////////////////
//method to initialize notifications
/////////////////final running code/////////////////////
// Future<String?> getMobileDeviceToken(String text, String email) async {
//   try {
//     // Request notification permission
//     NotificationSettings settings =
//         await FirebaseMessaging.instance.requestPermission(
//       alert: true,
//       badge: true,
//       sound: true,
//     );
//     print("Permission: ${settings.authorizationStatus}");
//     if (settings.authorizationStatus != AuthorizationStatus.authorized &&
//         settings.authorizationStatus != AuthorizationStatus.provisional) {
//       print("Notification permission not granted");
//       return null;
//     }
//     // iOS: wait for APNs token
//     if (Platform.isIOS) {
//       String? apnsToken;
//       for (int i = 0; i < 10; i++) {
//         apnsToken = await FirebaseMessaging.instance.getAPNSToken();
//         if (apnsToken != null) {
//           break;
//         }
//         print("Waiting for APNs token...");
//         await Future.delayed(const Duration(seconds: 1));
//       }
//       print("APNs Token: $apnsToken");
//       if (apnsToken == null) {
//         print("APNs token not available");
//         return null;
//       }
//     }
//     // Android and iOS
//     final String? fcmToken = await FirebaseMessaging.instance.getToken();
//     print("FCM Token22: $fcmToken");
//     if (text == 'password' && fcmToken != null) {
//       await updateDeviceToken(fcmToken, email);
//     }
//     return fcmToken;
//   } catch (e) {
//     print("Error: $e");
//     return null;
//   }
// }//////////////////////////////////////////////////////////////////////////////////////////////

Future<void> checkNotificationPermission(BuildContext context) async {
  NotificationSettings settings =
      await FirebaseMessaging.instance.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );
  print("Status: ${settings.authorizationStatus}");
  if (settings.authorizationStatus == AuthorizationStatus.denied) {
    if (!context.mounted) return;
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: const Text('Notifications Disabled'),
        content: const Text(
          'Please enable notifications in Settings to receive updates.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              await openAppSettings();
            },
            child: const Text('Open Settings'),
          ),
        ],
      ),
    );
  }
}
//   Future<String?> getMobileDeviceToken(String text, String email) async {
//   // await _firebaseMessaging.requestPermission();
//   final String? fCMToken = await _firebaseMessaging.getToken();
//   print('Token: $fCMToken');

//   if (text == 'password' && fCMToken != null) {
//     updateDeviceToken(fCMToken, email);
//   }
//   return fCMToken;
// }

/////////////////final running code/////////////////////
//  Future<void> updateDeviceToken(String token, String id) async {
//      String baseUrl = AppUrl.updateFirebaseToken;
//     await Constants.init();
//     String idDynamic = id;
//     print("idDynamic: $idDynamic");
//     final Uri uri = Uri.parse('$baseUrl?id=$idDynamic&firebaseToken=$token');
//     print('update token: $uri');
//     try {
//       final response = await http.post(uri);

//       if (response.statusCode == 200) {
//         print('Token updated successfully');
//       } else {
//         print('Error: ${response.statusCode} - ${response.body}');
//       }
//     } catch (e) {
//       print('Error: $e');
//     }
//   }
 
// Future<void> checkNotificationPermission(
//     BuildContext context) async {

//   NotificationSettings settings =
//       await FirebaseMessaging.instance.getNotificationSettings();

//   print(
//       'checkNotificationPermission Status: ${settings.authorizationStatus}');

//   if (settings.authorizationStatus ==
//       AuthorizationStatus.denied) {

//     print('Showing notification dialog');

//     if (!context.mounted) {
//       print('Context not mounted');
//       return;
//     }

//     await showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (_) => AlertDialog(
//         title: const Text('Notifications Disabled'),
//         content: const Text(
//           'Please enable notifications in Settings to receive updates.',
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('Cancel'),
//           ),
//           ElevatedButton(
//             onPressed: () async {
//               Navigator.pop(context);
//               await openAppSettings();
//             },
//             child: const Text('Open Settings'),
//           ),
//         ],
//       ),
//     );
//   }
// }
Future<String?> getMobileDeviceToken(String text, String id) async {
  try {
    // Request notification permission
    NotificationSettings settings =
        await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    print("Permission Status: ${settings.authorizationStatus}");
    if (settings.authorizationStatus != AuthorizationStatus.authorized &&
        settings.authorizationStatus != AuthorizationStatus.provisional) {
      print("Notification permission denied");
      return null;
    }
    // iOS: Wait until APNs token is available
    if (Platform.isIOS) {
      String? apnsToken;
      for (int i = 0; i < 20; i++) {
        apnsToken = await FirebaseMessaging.instance.getAPNSToken();
        if (apnsToken != null) {
          // await updateDeviceToken(apnsToken, id);//added to save token for IOS devices
          break;
        }
        print("Waiting for APNs Token...");
        await Future.delayed(const Duration(seconds: 1));
      }
      print("APNs Token: $apnsToken");
      if (apnsToken == null) {
        print("APNs Token is still null.");
        return null;
      }
    }
    // Get FCM Token
    String? fcmToken = await FirebaseMessaging.instance.getToken();
    // Retry once if null
    if (fcmToken == null) {
      await Future.delayed(const Duration(seconds: 2));
      fcmToken = await FirebaseMessaging.instance.getToken();
    }
    print("FCM Token: $fcmToken");
    if (fcmToken != null && text == "password") {
      print("Updating token to server...");
      await updateDeviceToken(fcmToken, id);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('device_token_for_logOut', fcmToken);
    }
    return fcmToken;
  } catch (e) {
    print("getMobileDeviceToken Error: $e");
    return null;
  }
}
/////////////////////////////////////////////////////////////////////
Future<void> updateDeviceToken(String token, String id) async {
  await Constants.init();
  final Uri uri = Uri.parse(AppUrl.updateFirebaseToken).replace(
    queryParameters: {
      "id": id,
      "firebaseToken": token,
    },
  );
  print("Update URL: $uri");
  try {
    final response = await http.post(uri);
    print("Status Code: ${response.statusCode}");
    print("Response: ${response.body}");
    if (response.statusCode == 200) {
      print("Device token updated successfully.");
    } else {
      print("Failed to update token.");
    }
  } catch (e) {
    print("updateDeviceToken Error: $e");
  }
}
}
