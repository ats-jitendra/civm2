// import 'package:flutter/material.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// import 'package:permission_handler/permission_handler.dart'; // 👈 for runtime permission handling

// class MapViewPage extends StatefulWidget {
//   final String url;

//   const MapViewPage({super.key, required this.url});

//   @override
//   State<MapViewPage> createState() => _MapViewPageState();
// }

// class _MapViewPageState extends State<MapViewPage> {
//   bool _isLoading = true; // loader flag

//   @override
//   void initState() {
//     super.initState();
//     _requestMediaPermissions(); // 👈 Request camera + mic before opening webview
//   }

//   /// Request camera and microphone permissions explicitly (older Androids need this)
//   Future<void> _requestMediaPermissions() async {
//     await [
//       Permission.camera,
//       Permission.microphone,
//     ].request();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: Stack(
//           children: [
//             InAppWebView(
//               initialUrlRequest: URLRequest(
//                 url: WebUri(widget.url),
//               ),
//               initialSettings: InAppWebViewSettings(
//                 mediaPlaybackRequiresUserGesture: false,
//                 allowsInlineMediaPlayback: true,
//                 javaScriptEnabled: true,
//                 useHybridComposition: true, // smoother rendering
//               ),
      
//               // ✅ Works on all Android versions (and iOS)
//               onPermissionRequest: (controller, request) async {
//                 debugPrint("Permission requested for: ${request.resources}");
//                 return PermissionResponse(
//                   resources: request.resources,
//                   action: PermissionResponseAction.GRANT,
//                 );
//               },
      
//               onReceivedServerTrustAuthRequest: (controller, challenge) async {
//                 // ⚠️ Only for debugging — validate certs in production
//                 return ServerTrustAuthResponse(
//                   action: ServerTrustAuthResponseAction.PROCEED,
//                 );
//               },
      
//               onLoadStart: (controller, url) {
//                 setState(() => _isLoading = true);
//               },
//               onLoadStop: (controller, url) async {
//                 setState(() => _isLoading = false);
//               },
//               onLoadError: (controller, url, code, message) {
//                 setState(() => _isLoading = false);
//               },
//             ),
      
//             if (_isLoading)
//               const Center(
//                 child: CircularProgressIndicator(
//                   color: Color.fromARGB(255, 7, 59, 120),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }