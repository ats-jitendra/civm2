// import 'package:CIVM/models/user_model.dart';
// import 'package:CIVM/utils/user_pref.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:webview_flutter/webview_flutter.dart';

// // ignore: must_be_immutable
// class RowMaintenanceUpdateMap extends StatefulWidget {
//   String id;
//   RowMaintenanceUpdateMap({Key? key, required this.id}) : super(key: key);

//   @override
//   State<RowMaintenanceUpdateMap> createState() =>
//       _RowMaintenanceUpdateMapState();
// }

// class _RowMaintenanceUpdateMapState extends State<RowMaintenanceUpdateMap> {
//   String id = '';
//   @override
//   void initState() {
//     initData();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//         appBar: AppBar(iconTheme: const IconThemeData(color: Colors.white),
//           title: const Text('Map',
//             style: TextStyle(color: Colors.white),),
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
//                 print("WebView error: ${error.description}");
//               },
//             ),
//           ),
//         ));
//   }

//   Future<void> initData() async {
//     final userPreferences1 = Provider.of<UserPref>(context, listen: false);
//     UserModel data = await userPreferences1.getUser();
//     id = data.user!.id.toString();
//   }

//   // _launchURL(String url) async {
//   //   if (await canLaunch(url)) {
//   //     await launch(url);
//   //   } else {
//   //     throw 'Could not launch $url';
//   //   }
//   // }
// }
