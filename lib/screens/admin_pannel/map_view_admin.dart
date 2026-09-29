// // import 'package:flutter/material.dart';
// // import 'package:webview_flutter/webview_flutter.dart';

// // // ignore: must_be_immutable
// // class MapViewAdmin extends StatefulWidget {
// //   String id;
// //   MapViewAdmin({Key? key, required this.id}) : super(key: key);

// //   @override
// //   State<MapViewAdmin> createState() => _MapViewAdminState();
// // }

// // class _MapViewAdminState extends State<MapViewAdmin> {
// //   late WebViewController _webViewController;
// //   @override
// //   void initState() {
// //     // initData();
// //     super.initState();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     Size size = MediaQuery.of(context).size;
// //     return Scaffold(
// //         appBar: AppBar(iconTheme: const IconThemeData(color: Colors.white),
// //           toolbarHeight: 5,
// //           // title: const Text('Map'),
// //           backgroundColor: const Color.fromARGB(255, 7, 59, 120),
// //         ),
// //         body: SingleChildScrollView(
// //           child: SizedBox(
// //             width: size.width * 1,
// //             height: size.height * 1,
// //             child: WebView(
// //               initialUrl:
// //                   'https://mapapi.ariespro.com/main/admin/CIVM_Map/${widget.id}/USRQWXH589Z',
// //               javascriptMode: JavascriptMode.unrestricted,
// //               // onWebResourceError: (WebResourceError error) {
// //               //   print(
// //               //       'https://mapapi.ariespro.com/main/admin/CIVM_Map/${widget.id}/USRQWXH589Z');
// //               //   print('Map Error in phone');
// //               //   print("WebView error: ${error.description}");
// //               // },

// //               onWebViewCreated: (WebViewController webViewController) {
// //                 _webViewController = webViewController;
// //                 _webViewController.clearCache();
// //                 _webViewController.loadUrl(
// //                   'https://mapapi.ariespro.com/main/admin/CIVM_Map/${widget.id}/USRQWXH589Z',
// //                   headers: {
// //                     "MicPermission": "true"
// //                   }, // Mic permission grant header
// //                 );

// //                 _webViewController.loadUrl(
// //                   'https://mapapi.ariespro.com/main/admin/CIVM_Map/${widget.id}/USRQWXH589Z',
// //                   headers: {
// //                     "MicPermission": "true"
// //                   }, // Mic permission grant header
// //                 );
// //               },

// //               javascriptChannels: <JavascriptChannel>{
// //                 JavascriptChannel(
// //                   name: 'MicPermission',
// //                   onMessageReceived: (JavascriptMessage message) {
// //                     // Handle mic permission response from JavaScript here
// //                     if (message.message == 'granted') {
// //                       // Mic access granted
// //                       // Handle mic access or perform actions requiring mic access
// //                     } else {
// //                       // Mic access denied
// //                       // Handle mic access denial
// //                     }
// //                   },
// //                 ),
// //               },
// //               navigationDelegate: (NavigationRequest request) {
// //                 if (request.url.contains('example.com')) {
// //                   return NavigationDecision.prevent;
// //                 }
// //                 return NavigationDecision.navigate;
// //               },
// //             ),
// //           ),
// //         ));
// //   }

// //   // Future<void> initData() async {
// //   //   final userPreferences1 = Provider.of<UserPref>(context, listen: false);
// //   //   UserModel data = await userPreferences1.getUser();
// //   //   id = data.user!.id.toString();
// //   // }
// // }















// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';

// // ignore: must_be_immutable
// class MapViewAdmin extends StatefulWidget {
//   String id;

//   MapViewAdmin({Key? key, required this.id}) : super(key: key);

//   @override
//   State<MapViewAdmin> createState() => _MapViewAdminState();
// }

// class _MapViewAdminState extends State<MapViewAdmin> {
//   late WebViewController _webViewController;

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       appBar: AppBar(
//         toolbarHeight: 5,
//         backgroundColor: const Color.fromARGB(255, 7, 59, 120),
//       ),
//       body: SingleChildScrollView(
//         child: SizedBox(
//           width: size.width * 1,
//           height: size.height * 1,
//           child: WebView(
//             initialUrl:
//                 'https://mapapi.ariespro.com/main/admin/CIVM_Map/${widget.id}/USRQWXH589Z',
//             javascriptMode: JavascriptMode.unrestricted,
//             onWebResourceError: (WebResourceError error) {
//               print("WebView error: ${error.description}");
//             },
//             onWebViewCreated: (WebViewController webViewController) {
//               _webViewController = webViewController;

//               // Remove unnecessary clearCache call
//               // _webViewController.clearCache();

//               // Load the URL with MicPermission header
//               _webViewController.loadUrl(
//                 'https://mapapi.ariespro.com/main/admin/CIVM_Map/${widget.id}/USRQWXH589Z',
//                 headers: {"MicPermission": "true"},
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
// }
