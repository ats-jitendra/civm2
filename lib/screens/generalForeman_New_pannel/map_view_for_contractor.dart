// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';

// // ignore: must_be_immutable
// class MapViewContractor extends StatefulWidget {
//   String id;
//   MapViewContractor({Key? key, required this.id}) : super(key: key);

//   @override
//   State<MapViewContractor> createState() => _MapViewContractorState();
// }

// class _MapViewContractorState extends State<MapViewContractor> {
//   @override
//   void initState() {
//     // initData();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//          appBar: AppBar(iconTheme: const IconThemeData(color: Colors.white),
//           toolbarHeight: 5,
//           // title: const Text('Map'),
//           backgroundColor: const Color.fromARGB(255, 7, 59, 120),
//         ),
//         body: SingleChildScrollView(
//           child: SizedBox(
//             width: size.width * 0.99,
//             height: size.height * 0.99,
//             child: WebView(
//               initialUrl:
//                   'https://mapapi.ariespro.com/main/contractor/CIVM_Map/${widget.id}/USRQWXH589Z',
//               javascriptMode: JavascriptMode.unrestricted,
//               onWebResourceError: (WebResourceError error) {
//                 print(
//                     'https://mapapi.ariespro.com/main/contractor/CIVM_Map/${widget.id}/USRQWXH589Z');
//                 print('Map Error in phone');
//                 print("WebView error: ${error.description}");
//               },
//             ),
//           ),
//         ));
//   }

//   // Future<void> initData() async {
//   //   final userPreferences1 = Provider.of<UserPref>(context, listen: false);
//   //   UserModel data = await userPreferences1.getUser();
//   //   id = data.user!.id.toString();
//   // }
// }
