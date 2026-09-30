// import 'package:CIVM/resources/component/round_button.dart';
// import 'package:CIVM/view_model/login_view_model.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// // ignore: must_be_immutable
// class MessageShowingError extends StatefulWidget {
//   String error;

//   MessageShowingError(
//       {Key? key,
//       required this.error})
//       : super(key: key);

//   @override
//   State<MessageShowingError> createState() => _MessageShowingErrorState();
// }

// class _MessageShowingErrorState extends State<MessageShowingError> {

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     final authViewModel = Provider.of<LoginViewModel>(context);
//     return Scaffold(
//       appBar: AppBar(
//         iconTheme: const IconThemeData(color: Colors.white),
//         title: const Text(
//           '',
//           style: TextStyle(color: Colors.white),
//         ),
//         backgroundColor: const Color.fromARGB(255, 7, 59, 120),
//         actions: const <Widget>[],
//       ),
//       body: SingleChildScrollView(
//           child: Center(
//               child: Column(children: [
//         const Padding(
//           padding: EdgeInsets.only(top: 20.0),
//           child: Text(
//             'OOPS!',
//             style: TextStyle(
//                 fontSize: 20,
//                 color: Color.fromARGB(255, 7, 59, 120),
//                 fontWeight: FontWeight.bold),
//           ),
//         ),
//         Text(
//           widget.error,
//           style: const TextStyle(
//               fontSize: 20,
//               color: Color.fromARGB(255, 7, 59, 120),
//               fontWeight: FontWeight.bold),
//         ),
//          Container(
//                                       margin: const EdgeInsets.only(
//                                           left: 6, right: 6, top: 8.0),
//                                       child: Padding(
//                                         padding: const EdgeInsets.only(
//                                             left: 2.0,
//                                             right: 2.0,
//                                             bottom: 2.0,
//                                             top: 20.0),
//                                         child: InkWell(
//                                           onTap: () {
                                           
//                                           },
//                                           child: Container(
//                                             margin: const EdgeInsets.only(
//                                                 left: 40,
//                                                 right: 40,
//                                                 bottom: 10.0),
//                                             padding: const EdgeInsets.all(8),
//                                             alignment: Alignment.center,
//                                             width: MediaQuery.of(context)
//                                                 .size
//                                                 .width,
//                                             height: 40,
//                                             decoration: BoxDecoration(
//                                                 // shape: BoxShape.circle,
//                                                 borderRadius:
//                                                     BorderRadius.circular(10),
//                                                 boxShadow: const [
//                                                   BoxShadow(
//                                                       color: Color.fromARGB(
//                                                           255, 3, 47, 97),
//                                                       blurRadius: 5,
//                                                       offset: Offset(2.0, 5.0))
//                                                 ],
//                                                 color: const Color.fromARGB(
//                                                     255, 130, 193, 245),
//                                                 gradient: const LinearGradient(
//                                                   colors: [
//                                                     Color.fromARGB(
//                                                         255, 7, 59, 120),
//                                                     Color.fromARGB(
//                                                         255, 7, 59, 120)
//                                                   ],
//                                                 )),
//                                             child: const Row(children: [
//                                               Expanded(
//                                                 child: Align(
//                                                   alignment: Alignment.center,
//                                                   child: Text(
//                                                     'Save Plan',
//                                                     textAlign: TextAlign.left,
//                                                     style: TextStyle(
//                                                       color: Colors.white,
//                                                       fontWeight:
//                                                           FontWeight.bold,
//                                                       fontSize: 20,
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ]),
//                                           ),
//                                         ),
//                                       )),
                              
//       ]))),
//     );
//   }
// }
