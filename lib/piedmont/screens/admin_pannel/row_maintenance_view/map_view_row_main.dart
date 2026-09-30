// import 'dart:io';
// import 'package:CIVM/piedmont/resources/app_colors.dart';
// import 'package:device_info_plus/device_info_plus.dart';
// import 'package:flutter/material.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:webview_flutter/webview_flutter.dart';

// // ignore: must_be_immutable
// class MapViewRowMaintAdmin extends StatefulWidget {
//   String id;
//   MapViewRowMaintAdmin({Key? key, required this.id}) : super(key: key);

//   @override
//   State<MapViewRowMaintAdmin> createState() => _MapViewRowMaintAdminState();
// }

// class _MapViewRowMaintAdminState extends State<MapViewRowMaintAdmin> {
//   late WebViewController _webViewController;
//   @override
//   void initState() {
//     // initData();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     _checkPermission(context);
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//         appBar: AppBar( iconTheme: const IconThemeData(color: Colors.white),
//           toolbarHeight: 5,
//           // title: const Text('Map'),
//           backgroundColor: AppColors.baseColor,
//         ),
//       body: SingleChildScrollView(
//         child: SizedBox(
//           width: size.width * 0.99,
//           height: size.height * 0.99, 
//           child: WebView(
//             initialUrl:
//                 'https://mapapi.ariespro.com/main/admin/CIVM_Map/${widget.id}/USRQWXH589Z',
//             javascriptMode: JavascriptMode.unrestricted,
//             onWebViewCreated: (WebViewController webViewController) {
//               _webViewController = webViewController;
//               _webViewController.clearCache();
//               _webViewController.loadUrl(
//                 'https://mapapi.ariespro.com/main/admin/CIVM_Map/${widget.id}/USRQWXH589Z',
//                 headers: {
//                   "MicPermission": "true"
//                 }, // Mic permission grant header
//               );

//               _webViewController.loadUrl(
//                 'https://mapapi.ariespro.com/main/admin/CIVM_Map/${widget.id}/USRQWXH589Z',
//                 headers: {
//                   "MicPermission": "true"
//                 }, // Mic permission grant header
//               );
//             },
//             javascriptChannels: <JavascriptChannel>{
//               JavascriptChannel(
//                 name: 'MicPermission',
//                 onMessageReceived: (JavascriptMessage message) {
//                   // Handle mic permission response from JavaScript here
//                   if (message.message == 'granted') {
//                     // Mic access granted
//                     // Handle mic access or perform actions requiring mic access
//                   } else {
//                     // Mic access denied
//                     // Handle mic access denial
//                   }
//                 },
//               ),
//             },
//             navigationDelegate: (NavigationRequest request) {
//               if (request.url.contains('example.com')) {
//                 return NavigationDecision.prevent;
//               }
//               return NavigationDecision.navigate;
//             },
//           ),
//         ),
//       ),
//     );
//   }

//   Future<void> _checkPermission(BuildContext context) async {
//     FocusScope.of(context).requestFocus(FocusNode());

//     Map<Permission, PermissionStatus> statuses = await [
//       Permission.camera,
//       Permission.storage,
//       Permission.photos,
//       Permission.microphone, // Add microphone permission
//     ].request();

//     PermissionStatus? statusCamera = statuses[Permission.camera];
//     PermissionStatus? statusStorage = statuses[Permission.storage];
//     PermissionStatus? statusPhotos = statuses[Permission.photos];
//     PermissionStatus? statusMicrophone = statuses[Permission.microphone];

//     if (Platform.isAndroid) {
//       final androidInfo = await DeviceInfoPlugin().androidInfo;
//       if (androidInfo.version.sdkInt <= 32) {
//         // Handle storage permission based on Android version
//         statusStorage = statuses[Permission.storage];
//       } else {
//         // Handle photos permission based on Android version
//         statusPhotos = statuses[Permission.photos];
//       }
//     }

//     bool isCameraGranted = statusCamera == PermissionStatus.granted;
//     bool isStorageGranted = statusStorage == PermissionStatus.granted;
//     bool isPhotosGranted = statusPhotos == PermissionStatus.granted;
//     bool isMicrophoneGranted = statusMicrophone == PermissionStatus.granted;

//     bool isGranted = (isCameraGranted && isStorageGranted) ||
//         (isCameraGranted && isPhotosGranted) ||
//         (isCameraGranted && isMicrophoneGranted);

//     if (isGranted) {}

//     bool isPermanentlyDenied =
//         statusCamera == PermissionStatus.permanentlyDenied ||
//             statusStorage == PermissionStatus.permanentlyDenied ||
//             statusPhotos == PermissionStatus.permanentlyDenied ||
//             statusMicrophone == PermissionStatus.permanentlyDenied;

//     if (isPermanentlyDenied) {
//       // Handle the case where permission is permanently denied
//       // _showSettingsDialog(context);
//     }
//   }
//   // Future<void> initData() async {
//   //   final userPreferences1 = Provider.of<UserPref>(context, listen: false);
//   //   UserModel data = await userPreferences1.getUser();
//   //   id = data.user!.id.toString();
//   // }
// }
