// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;

// class TotalOrderOpen extends StatefulWidget {
//   const TotalOrderOpen({Key? key}) : super(key: key);

//   @override
//   State<TotalOrderOpen> createState() => _TotalOrderOpenState();
// }

// class _TotalOrderOpenState extends State<TotalOrderOpen> {
//   List<String> menu = [];

//   // ignore: non_constant_identifier_names
//   List<String> select_substation = [
//     'Ball Club',
//     'Bena',
//     'Bergen Lake',
//     'BlackBerry',
//     'Boy River',
//     'Liberty',
//     'Oakway',
//     'Powdersville'
//   ];
//   String? substation;

//   List<String> select_feeder = ['-N/A-'];
//   String? feeder;

//   List<String> select_street = ['-N/A-'];
//   String? street;

//   List<String> select_maintType = ['-N/A-'];
//   String? maintType;

//   List<String> select_supervisor = ['-N/A-'];
//   String? supervisor;

//   List<String> select_orderNo = ['-N/A-'];
//   String? orderNo;

//   String userName = '';

//   onTappedBar(int index) {
//     setState(() {
//       // _currentIndex = index;
//     });
//   }

//   @override
//   void initState() {
//     // getOwnPermissions();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//         appBar: AppBar( iconTheme: const IconThemeData(color: Colors.white),
//           title: const Text('Total Order (Open)',
//             style: TextStyle(color: Colors.white),),
//           backgroundColor: const AppColors.baseColor,
//           actions: <Widget>[
//             IconButton(
//               icon: const Icon(
//                 Icons.filter_alt_outlined,
//                 color: Colors.white,
//               ),
//               onPressed: () {
//                 openDailogTotalOrderOpen();
//                 // do something
//               },
//             )
//           ],
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(4.0),
//           child: ListView.builder(
//             itemCount: 10,
//             // itemCount: energyhistory!.result!.length,
//             itemBuilder: (context, index) {
//               return Container(
//                 margin: const EdgeInsets.only(
//                     left: 10, right: 10, top: 10, bottom: 10),
//                 padding: const EdgeInsets.all(8),
//                 alignment: Alignment.center,
//                 // height: size.height * 0.2,
//                 // width: size.width - 40,
//                 decoration: BoxDecoration(
//                     // shape: BoxShape.circle,
//                     borderRadius: BorderRadius.circular(10),
//                     boxShadow: const [
//                       BoxShadow(
//                           color: Color.fromARGB(255, 3, 47, 97),
//                           blurRadius: 10,
//                           offset: Offset(2.0, 5.0))
//                     ],
//                     gradient: const LinearGradient(
//                       colors: [
//                         Color.fromARGB(255, 255, 255, 255),
//                         Color.fromARGB(255, 255, 255, 255),
//                       ],
//                     )),
//                 child: Column(
//                   children: [
//                     Container(
//                       padding: const EdgeInsets.all(10),
//                       alignment: Alignment.center,
//                       width: size.width * 0.99,
//                       // width: MediaQuery.of(context).size.width,
//                       // height: 40,
//                       decoration: const BoxDecoration(
//                           // shape: BoxShape.circle,
//                           //borderRadius: BorderRadius.circular(25),
//                           boxShadow: [
//                             BoxShadow(
//                                 color: Color.fromARGB(255, 3, 47, 97),
//                                 blurRadius: 5,
//                                 offset: Offset(2.0, 5.0))
//                           ],
//                           color: Colors.black,
//                           gradient: LinearGradient(
//                             colors: [
//                               AppColors.baseColor,
//                               AppColors.baseColor,
//                             ],
//                           )),
//                       child: const Row(children: [
//                         Align(
//                           alignment: Alignment.centerLeft,
//                           child: Text(
//                             "Order No: ",
//                             textAlign: TextAlign.left,
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 20,
//                             ),
//                           ),
//                         ),
//                         Expanded(
//                           child: Align(
//                             alignment: Alignment.centerLeft,
//                             child: Text(
//                               '24',
//                               // energyhistory!.result![index].aUDITID!,
//                               textAlign: TextAlign.left,
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 20,
//                               ),
//                             ),
//                           ),
//                         ),

//                         Align(
//                           alignment: Alignment.centerLeft,
//                           child: Text(
//                             "Status: ",
//                             textAlign: TextAlign.left,
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 20,
//                             ),
//                           ),
//                         ),
//                         Expanded(
//                           child: Align(
//                             alignment: Alignment.centerLeft,
//                             child: Text(
//                               'Open',
//                               // energyhistory!.result![index].aUDITID!,
//                               textAlign: TextAlign.left,
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 20,
//                               ),
//                             ),
//                           ),
//                         ),
//                         // Container(
//                         //     // margin: const EdgeInsets.only(
//                         //     //     left: 6, right: 6, top: 8.0),
//                         //     child: InkWell(
//                         //   onTap: () {
//                         //     // if (_formkey.currentState!.validate()) {
//                         //     //   final snackBar = SnackBar(
//                         //     //       content: Text('Submitting Form'));

//                         //     //   _showSubmitDataDialog();
//                         //     // } else {
//                         //     //   print(
//                         //     //       "Please fill all mandetory fields!!!");
//                         //     // }
//                         //   },
//                         //   child: Container(
//                         //     // margin: const EdgeInsets.only(
//                         //     //     left: 40, right: 40, bottom: 10.0),
//                         //     padding: const EdgeInsets.all(8),
//                         //     alignment: Alignment.center,
//                         //     width: 80,
//                         //     // MediaQuery.of(context).size.width,
//                         //     // height: MediaQuery.of(context).size.height * 0.4,
//                         //     decoration: BoxDecoration(
//                         //         // shape: BoxShape.circle,
//                         //         borderRadius: BorderRadius.circular(25),
//                         //         boxShadow: const [
//                         //           BoxShadow(
//                         //               color: Color.fromARGB(255, 0, 58, 106),
//                         //               blurRadius: 5,
//                         //               offset: Offset(2.0, 5.0))
//                         //         ],
//                         //         color: const Color.fromARGB(255, 0, 58, 106),
//                         //         gradient: const LinearGradient(
//                         //           colors: [
//                         //             Color.fromARGB(255, 0, 79, 215),
//                         //             Colors.blue,
//                         //             Color.fromARGB(255, 0, 79, 215),
//                         //           ],
//                         //         )),
//                         //     child: const Text(
//                         //       "Edit",
//                         //       style: TextStyle(
//                         //         color: Colors.white,
//                         //         // fontWeight: FontWeight.bold,
//                         //         fontSize: 10,
//                         //       ),
//                         //     ),
//                         //   ),
//                         // )),
//                         //     Container(
//                         //         // margin: const EdgeInsets.only(
//                         //         //     left: 6, right: 6, top: 8.0),
//                         //         child: InkWell(
//                         //       onTap: () {
//                         //         // if (_formkey.currentState!.validate()) {
//                         //         //   final snackBar = SnackBar(
//                         //         //       content: Text('Submitting Form'));

//                         //         //   _showSubmitDataDialog();
//                         //         // } else {
//                         //         //   print(
//                         //         //       "Please fill all mandetory fields!!!");
//                         //         // }
//                         //       },
//                         //       child: Container(
//                         //         // margin: const EdgeInsets.only(
//                         //         //     left: 40, right: 40, bottom: 10.0),
//                         //         padding: const EdgeInsets.all(8),
//                         //         alignment: Alignment.center,
//                         //         width: 80,
//                         //         // MediaQuery.of(context).size.width,
//                         //         // height: MediaQuery.of(context).size.height * 0.4,
//                         //         decoration: BoxDecoration(
//                         //             // shape: BoxShape.circle,
//                         //             borderRadius: BorderRadius.circular(25),
//                         //             boxShadow: const [
//                         //               BoxShadow(
//                         //                   color: Color.fromARGB(255, 104, 8, 1),
//                         //                   blurRadius: 5,
//                         //                   offset: Offset(2.0, 5.0))
//                         //             ],
//                         //             color: const Color.fromARGB(255, 130, 193, 245),
//                         //             gradient: const LinearGradient(
//                         //               colors: [
//                         //                 Colors.red,
//                         //                 Colors.pink,
//                         //                 Colors.pinkAccent,
//                         //               ],
//                         //             )),
//                         //         child: const Text(
//                         //           "Delete",
//                         //           style: TextStyle(
//                         //             color: Colors.white,
//                         //             // fontWeight: FontWeight.bold,
//                         //             fontSize: 10,
//                         //           ),
//                         //         ),
//                         //       ),
//                         //     )),
//                       ]),
//                     ),
//                     const Padding(
//                       padding: EdgeInsets.only(top: 16.0, left: 8.0),
//                       child: Row(children: [
//                         Expanded(
//                           child: Align(
//                             alignment: Alignment.centerLeft,
//                             child: Text(
//                               "Document Upload: ",
//                               textAlign: TextAlign.left,
//                               style: TextStyle(
//                                 color: AppColors.baseColor,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 16,
//                               ),
//                             ),
//                           ),
//                         ),
//                         Expanded(
//                           child: Align(
//                             alignment: Alignment.centerLeft,
//                             child: Icon(
//                               Icons.keyboard_double_arrow_right_rounded,
//                               color: Colors.pink,
//                               size: 24.0,
//                               semanticLabel:
//                                   'Text to announce in accessibility modes',
//                             ),
//                             // child: Text(
//                             //   'Tony Albert',
//                             //   // energyhistory!.result![index].dATE!,
//                             //   textAlign: TextAlign.left,
//                             //   style: TextStyle(
//                             //     color: AppColors.baseColor,
//                             //     // fontWeight: FontWeight.bold,
//                             //     fontSize: 16,
//                             //   ),
//                             // ),
//                           ),
//                         ),
//                       ]),
//                     ),
//                     const Padding(
//                       padding: EdgeInsets.only(top: 4.0, left: 8.0),
//                       child: Row(children: [
//                         Expanded(
//                           child: Align(
//                             alignment: Alignment.centerLeft,
//                             child: Text(
//                               "View: ",
//                               textAlign: TextAlign.left,
//                               style: TextStyle(
//                                 color: AppColors.baseColor,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 16,
//                               ),
//                             ),
//                           ),
//                         ),
//                         Expanded(
//                           child: Align(
//                             alignment: Alignment.centerLeft,
//                             child: Text(
//                               '0',
//                               // energyhistory!.result![index].aCCOUNT!,
//                               textAlign: TextAlign.left,
//                               style: TextStyle(
//                                 color: AppColors.baseColor,
//                                 // fontWeight: FontWeight.bold,
//                                 fontSize: 16,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ]),
//                     ),
//                     const Padding(
//                       padding: EdgeInsets.only(top: 4.0, left: 8.0),
//                       child: Row(children: [
//                         Expanded(
//                           child: Align(
//                             alignment: Alignment.centerLeft,
//                             child: Text(
//                               "Substation: ",
//                               textAlign: TextAlign.left,
//                               style: TextStyle(
//                                 color: AppColors.baseColor,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 16,
//                               ),
//                             ),
//                           ),
//                         ),
//                         Expanded(
//                           child: Align(
//                             alignment: Alignment.centerLeft,
//                             child: Text(
//                               'Bena',
//                               // energyhistory!.result![index].cUSTOMERNAME!,
//                               textAlign: TextAlign.left,
//                               style: TextStyle(
//                                 color: AppColors.baseColor,
//                                 // fontWeight: FontWeight.bold,
//                                 fontSize: 16,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ]),
//                     ),
//                     const Padding(
//                       padding: EdgeInsets.only(top: 4.0, left: 8.0),
//                       child: Row(children: [
//                         Expanded(
//                           child: Align(
//                             alignment: Alignment.centerLeft,
//                             child: Text(
//                               "Feeder: ",
//                               textAlign: TextAlign.left,
//                               style: TextStyle(
//                                 color: AppColors.baseColor,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 16,
//                               ),
//                             ),
//                           ),
//                         ),
//                         Expanded(
//                           child: Align(
//                             alignment: Alignment.centerLeft,
//                             child: Text(
//                               'FDR1',
//                               // energyhistory!.result![index].cUSTOMERNAME!,
//                               textAlign: TextAlign.left,
//                               style: TextStyle(
//                                 color: AppColors.baseColor,
//                                 // fontWeight: FontWeight.bold,
//                                 fontSize: 16,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ]),
//                     ),
//                     const Padding(
//                       padding: EdgeInsets.only(top: 4.0, left: 8.0),
//                       child: Row(children: [
//                         Expanded(
//                           child: Align(
//                             alignment: Alignment.centerLeft,
//                             child: Text(
//                               "Street: ",
//                               textAlign: TextAlign.left,
//                               style: TextStyle(
//                                 color: AppColors.baseColor,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 16,
//                               ),
//                             ),
//                           ),
//                         ),
//                         Expanded(
//                           child: Align(
//                             alignment: Alignment.centerLeft,
//                             child: Text(
//                               'Benton',
//                               // energyhistory!.result![index].cUSTOMERNAME!,
//                               textAlign: TextAlign.left,
//                               style: TextStyle(
//                                 color: AppColors.baseColor,
//                                 // fontWeight: FontWeight.bold,
//                                 fontSize: 16,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ]),
//                     ),
//                     const Padding(
//                       padding: EdgeInsets.only(top: 4.0, left: 8.0),
//                       child: Row(children: [
//                         Expanded(
//                           child: Align(
//                             alignment: Alignment.centerLeft,
//                             child: Text(
//                               "Type: ",
//                               textAlign: TextAlign.left,
//                               style: TextStyle(
//                                 color: AppColors.baseColor,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 16,
//                               ),
//                             ),
//                           ),
//                         ),
//                         Expanded(
//                           child: Align(
//                             alignment: Alignment.centerLeft,
//                             child: Text(
//                               'Selective Mechanical Tree Removal',
//                               // energyhistory!.result![index].cUSTOMERNAME!,
//                               textAlign: TextAlign.left,
//                               style: TextStyle(
//                                 color: AppColors.baseColor,
//                                 // fontWeight: FontWeight.bold,
//                                 fontSize: 16,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ]),
//                     ),
//                     const Padding(
//                       padding: EdgeInsets.only(top: 4.0, left: 8.0),
//                       child: Row(children: [
//                         Expanded(
//                           child: Align(
//                             alignment: Alignment.centerLeft,
//                             child: Text(
//                               "Assigned Supervisor: ",
//                               textAlign: TextAlign.left,
//                               style: TextStyle(
//                                 color: AppColors.baseColor,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 16,
//                               ),
//                             ),
//                           ),
//                         ),
//                         Expanded(
//                           child: Align(
//                             alignment: Alignment.centerLeft,
//                             child: Text(
//                               'Nicks Johns',
//                               // energyhistory!.result![index].cUSTOMERNAME!,
//                               textAlign: TextAlign.left,
//                               style: TextStyle(
//                                 color: AppColors.baseColor,
//                                 // fontWeight: FontWeight.bold,
//                                 fontSize: 16,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ]),
//                     ),
//                     const Padding(
//                       padding: EdgeInsets.only(top: 4.0, left: 8.0),
//                       child: Row(children: [
//                         Expanded(
//                           child: Align(
//                             alignment: Alignment.centerLeft,
//                             child: Text(
//                               "Total Miles: ",
//                               textAlign: TextAlign.left,
//                               style: TextStyle(
//                                 color: AppColors.baseColor,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 16,
//                               ),
//                             ),
//                           ),
//                         ),
//                         Expanded(
//                           child: Align(
//                             alignment: Alignment.centerLeft,
//                             child: Text(
//                               '38',
//                               // energyhistory!.result![index].cUSTOMERNAME!,
//                               textAlign: TextAlign.left,
//                               style: TextStyle(
//                                 color: AppColors.baseColor,
//                                 // fontWeight: FontWeight.bold,
//                                 fontSize: 16,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ]),
//                     ),
//                     const Padding(
//                       padding: EdgeInsets.only(top: 4.0, left: 8.0),
//                       child: Row(children: [
//                         Expanded(
//                           child: Align(
//                             alignment: Alignment.centerLeft,
//                             child: Text(
//                               "Contract Year: ",
//                               textAlign: TextAlign.left,
//                               style: TextStyle(
//                                 color: AppColors.baseColor,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 16,
//                               ),
//                             ),
//                           ),
//                         ),
//                         Expanded(
//                           child: Align(
//                             alignment: Alignment.centerLeft,
//                             child: Text(
//                               '2022',
//                               // energyhistory!.result![index].cUSTOMERNAME!,
//                               textAlign: TextAlign.left,
//                               style: TextStyle(
//                                 color: AppColors.baseColor,
//                                 // fontWeight: FontWeight.bold,
//                                 fontSize: 16,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ]),
//                     ),
//                     const Padding(
//                       padding: EdgeInsets.only(top: 4.0, left: 8.0),
//                       child: Row(children: [
//                         Expanded(
//                           child: Align(
//                             alignment: Alignment.centerLeft,
//                             child: Text(
//                               "Cycle: ",
//                               textAlign: TextAlign.left,
//                               style: TextStyle(
//                                 color: AppColors.baseColor,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 16,
//                               ),
//                             ),
//                           ),
//                         ),
//                         Expanded(
//                           child: Align(
//                             alignment: Alignment.centerLeft,
//                             child: Text(
//                               '5',
//                               // energyhistory!.result![index].cUSTOMERNAME!,
//                               textAlign: TextAlign.left,
//                               style: TextStyle(
//                                 color: AppColors.baseColor,
//                                 // fontWeight: FontWeight.bold,
//                                 fontSize: 16,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ]),
//                     ),
//                   ],
//                 ),
//               );
//             },
//           ),
//         ));
//   }

//   Future<void> getOwnPermissions() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     var APIURL =
//         "http://oemapi.ariespro.com/api/MenuAuthentication/userDetails";

//     Map mappedData = {
//       'id': prefs.getString('USER_NAME'),
//     };
//     print("Json data: ${mappedData}");
//     http.Response response =
//         await http.post(Uri.parse(APIURL), body: mappedData);
//     var data = jsonDecode(response.body);
//     print(" data: ${data}");
//     var status = "${data['code']}";

//     if (status.contains("SUCCESS")) {
//       setState(() {
//         var result = data["result"];
//         var temp = result['User Menu Access'] as List;
//         for (int i = 0; i < temp.length; i++) {
//           menu.add(temp[i]['MENU']);
//         }
//       });
//     } else if (status.contains("ERROR")) {
//       final snackBar = SnackBar(
//         content: Text("${data['message']}"),
//         action: SnackBarAction(
//           label: '',
//           onPressed: () {
//             // Some code to undo the change.
//           },
//         ),
//       );
//       ScaffoldMessenger.of(context).showSnackBar(snackBar);
//     } else {
//       final snackBar = SnackBar(
//         content: const Text('Somthing went wrong!!!'),
//         action: SnackBarAction(
//           label: '',
//           onPressed: () {
//             // Some code to undo the change.
//           },
//         ),
//       );

//       ScaffoldMessenger.of(context).showSnackBar(snackBar);
//     }
//   }

//   Future openDailogTotalOrderOpen() => showDialog(
//       context: context,
//       builder: (context) {
//         return StatefulBuilder(builder: (context, setState) {
//           return AlertDialog(
//             content: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   Container(
//                     margin: const EdgeInsets.only(top: 10),
//                     child: Column(
//                       children: [
//                         const Align(
//                             alignment: Alignment.centerLeft,
//                             child: Padding(
//                               padding: EdgeInsets.all(2.0),
//                               child: Text(
//                                 "Substation",
//                                 style: TextStyle(
//                                     fontSize: 16.0,
//                                     color: Color.fromARGB(255, 7, 59, 120)),
//                               ),
//                             )),
//                         Align(
//                           alignment: Alignment.centerRight,
//                           child: Padding(
//                             padding: const EdgeInsets.all(2.0),
//                             child: Container(
//                               padding: const EdgeInsets.symmetric(
//                                   horizontal: 12, vertical: 4),
//                               // border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(25),
//                                 border: Border.all(
//                                   color: const AppColors.baseColor,
//                                 ),
//                               ),
//                               child: DropdownButtonHideUnderline(
//                                 child: DropdownButtonFormField<String>(
//                                   hint: const Text('Select'),
//                                   dropdownColor: Colors.white,
//                                   value: substation,
//                                   style: const TextStyle(
//                                       color: AppColors.baseColor,
//                                       fontSize: 16),
//                                   icon: const Icon(
//                                     Icons.arrow_drop_down,
//                                     color: AppColors.baseColor,
//                                     size: 20,
//                                   ),
//                                   decoration: const InputDecoration(
//                                     enabledBorder: UnderlineInputBorder(
//                                         borderSide: BorderSide(
//                                             color: Colors.transparent)),
//                                     focusedBorder: UnderlineInputBorder(
//                                         borderSide: BorderSide(
//                                             color: Colors.transparent)),
//                                   ),
//                                   isExpanded: true,
//                                   items: select_substation
//                                       .map(buildMenuItem)
//                                       .toList(),
//                                   onChanged: (value) {
//                                     this.substation = value;
//                                     // showLoaderDialog(context);
//                                     // getYear();
//                                     // getMonth();
//                                     // getData(program.toString(), year.toString(),
//                                     //     '0', '0');
//                                   },
//                                   validator: (value) =>
//                                       value == null ? 'field required' : null,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Container(
//                     margin: const EdgeInsets.only(top: 10),
//                     child: Column(
//                       children: [
//                         const Align(
//                             alignment: Alignment.centerLeft,
//                             child: Padding(
//                               padding: EdgeInsets.all(2.0),
//                               child: Text(
//                                 "Feeder",
//                                 style: TextStyle(
//                                     fontSize: 16.0,
//                                     color: Color.fromARGB(255, 7, 59, 120)),
//                               ),
//                             )),
//                         Align(
//                           alignment: Alignment.centerRight,
//                           child: Padding(
//                             padding: const EdgeInsets.all(2.0),
//                             child: Container(
//                               padding: const EdgeInsets.symmetric(
//                                   horizontal: 12, vertical: 4),
//                               // border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(25),
//                                 border: Border.all(
//                                   color: const AppColors.baseColor,
//                                 ),
//                               ),
//                               child: DropdownButtonHideUnderline(
//                                 child: DropdownButtonFormField<String>(
//                                   hint: const Text('Select'),
//                                   dropdownColor: Colors.white,
//                                   value: feeder,
//                                   style: const TextStyle(
//                                       color: AppColors.baseColor,
//                                       fontSize: 16),
//                                   icon: const Icon(
//                                     Icons.arrow_drop_down,
//                                     color: AppColors.baseColor,
//                                     size: 20,
//                                   ),
//                                   decoration: const InputDecoration(
//                                     enabledBorder: UnderlineInputBorder(
//                                         borderSide: BorderSide(
//                                             color: Colors.transparent)),
//                                     focusedBorder: UnderlineInputBorder(
//                                         borderSide: BorderSide(
//                                             color: Colors.transparent)),
//                                   ),
//                                   isExpanded: true,
//                                   items:
//                                       select_feeder.map(buildMenuItem).toList(),
//                                   onChanged: (value) {
//                                     this.feeder = value;
//                                     // showLoaderDialog(context);
//                                     // getYear();
//                                     // getMonth();
//                                     // getData(program.toString(), year.toString(),
//                                     //     '0', '0');
//                                   },
//                                   validator: (value) =>
//                                       value == null ? 'field required' : null,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Container(
//                     margin: const EdgeInsets.only(top: 10),
//                     child: Column(
//                       children: [
//                         const Align(
//                             alignment: Alignment.centerLeft,
//                             child: Padding(
//                               padding: EdgeInsets.all(2.0),
//                               child: Text(
//                                 "Street",
//                                 style: TextStyle(
//                                     fontSize: 16.0,
//                                     color: Color.fromARGB(255, 7, 59, 120)),
//                               ),
//                             )),
//                         Align(
//                           alignment: Alignment.centerRight,
//                           child: Padding(
//                             padding: const EdgeInsets.all(2.0),
//                             child: Container(
//                               padding: const EdgeInsets.symmetric(
//                                   horizontal: 12, vertical: 4),
//                               // border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(25),
//                                 border: Border.all(
//                                   color: const AppColors.baseColor,
//                                 ),
//                               ),
//                               child: DropdownButtonHideUnderline(
//                                 child: DropdownButtonFormField<String>(
//                                   hint: const Text('Select'),
//                                   dropdownColor: Colors.white,
//                                   value: street,
//                                   style: const TextStyle(
//                                       color: AppColors.baseColor,
//                                       fontSize: 16),
//                                   icon: const Icon(
//                                     Icons.arrow_drop_down,
//                                     color: AppColors.baseColor,
//                                     size: 20,
//                                   ),
//                                   decoration: const InputDecoration(
//                                     enabledBorder: UnderlineInputBorder(
//                                         borderSide: BorderSide(
//                                             color: Colors.transparent)),
//                                     focusedBorder: UnderlineInputBorder(
//                                         borderSide: BorderSide(
//                                             color: Colors.transparent)),
//                                   ),
//                                   isExpanded: true,
//                                   items:
//                                       select_street.map(buildMenuItem).toList(),
//                                   onChanged: (value) {
//                                     setState(
//                                       () => this.street = value,
//                                     );
//                                     // String m = getMonthNum(month.toString());
//                                     // showLoaderDialog(context);
//                                     // print(m);
//                                     // print(m);
//                                     // getData(program.toString(), year.toString(),
//                                     //     (m.isEmpty) ? '0' : m, '0');
//                                   },
//                                   validator: (value) =>
//                                       value == null ? 'field required' : null,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                   Container(
//                     margin: const EdgeInsets.only(top: 10),
//                     child: Column(
//                       children: [
//                         const Align(
//                             alignment: Alignment.centerLeft,
//                             child: Padding(
//                               padding: EdgeInsets.all(2.0),
//                               child: Text(
//                                 "Maint Type",
//                                 style: TextStyle(
//                                     fontSize: 16.0,
//                                     color: Color.fromARGB(255, 7, 59, 120)),
//                               ),
//                             )),
//                         Align(
//                           alignment: Alignment.centerRight,
//                           child: Padding(
//                             padding: const EdgeInsets.all(2.0),
//                             child: Container(
//                               padding: const EdgeInsets.symmetric(
//                                   horizontal: 12, vertical: 4),
//                               // border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(25),
//                                 border: Border.all(
//                                   color: const AppColors.baseColor,
//                                 ),
//                               ),
//                               child: DropdownButtonHideUnderline(
//                                 child: DropdownButtonFormField<String>(
//                                   hint: const Text('Select'),
//                                   dropdownColor: Colors.white,
//                                   value: maintType,
//                                   style: const TextStyle(
//                                       color: AppColors.baseColor,
//                                       fontSize: 16),
//                                   icon: const Icon(
//                                     Icons.arrow_drop_down,
//                                     color: AppColors.baseColor,
//                                     size: 20,
//                                   ),
//                                   decoration: const InputDecoration(
//                                     enabledBorder: UnderlineInputBorder(
//                                         borderSide: BorderSide(
//                                             color: Colors.transparent)),
//                                     focusedBorder: UnderlineInputBorder(
//                                         borderSide: BorderSide(
//                                             color: Colors.transparent)),
//                                   ),
//                                   isExpanded: true,
//                                   items: select_maintType
//                                       .map(buildMenuItem)
//                                       .toList(),
//                                   onChanged: (value) {
//                                     setState(
//                                       () => this.maintType = value,
//                                     );
//                                     // String m = getMonthNum(month.toString());
//                                     // showLoaderDialog(context);
//                                     // print(m);
//                                     // print(m);
//                                     // getData(program.toString(), year.toString(),
//                                     //     (m.isEmpty) ? '0' : m, '0');
//                                   },
//                                   validator: (value) =>
//                                       value == null ? 'field required' : null,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                   Container(
//                     margin: const EdgeInsets.only(top: 10),
//                     child: Column(
//                       children: [
//                         const Align(
//                             alignment: Alignment.centerLeft,
//                             child: Padding(
//                               padding: EdgeInsets.all(2.0),
//                               child: Text(
//                                 "Supervisor",
//                                 style: TextStyle(
//                                     fontSize: 16.0,
//                                     color: Color.fromARGB(255, 7, 59, 120)),
//                               ),
//                             )),
//                         Align(
//                           alignment: Alignment.centerRight,
//                           child: Padding(
//                             padding: const EdgeInsets.all(2.0),
//                             child: Container(
//                               padding: const EdgeInsets.symmetric(
//                                   horizontal: 12, vertical: 4),
//                               // border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(25),
//                                 border: Border.all(
//                                   color: const AppColors.baseColor,
//                                 ),
//                               ),
//                               child: DropdownButtonHideUnderline(
//                                 child: DropdownButtonFormField<String>(
//                                   hint: const Text('Select'),
//                                   dropdownColor: Colors.white,
//                                   value: supervisor,
//                                   style: const TextStyle(
//                                       color: AppColors.baseColor,
//                                       fontSize: 16),
//                                   icon: const Icon(
//                                     Icons.arrow_drop_down,
//                                     color: AppColors.baseColor,
//                                     size: 20,
//                                   ),
//                                   decoration: const InputDecoration(
//                                     enabledBorder: UnderlineInputBorder(
//                                         borderSide: BorderSide(
//                                             color: Colors.transparent)),
//                                     focusedBorder: UnderlineInputBorder(
//                                         borderSide: BorderSide(
//                                             color: Colors.transparent)),
//                                   ),
//                                   isExpanded: true,
//                                   items: select_supervisor
//                                       .map(buildMenuItem)
//                                       .toList(),
//                                   onChanged: (value) {
//                                     setState(
//                                       () => this.supervisor = value,
//                                     );
//                                     // String m = getMonthNum(month.toString());
//                                     // showLoaderDialog(context);
//                                     // print(m);
//                                     // print(m);
//                                     // getData(program.toString(), year.toString(),
//                                     //     (m.isEmpty) ? '0' : m, '0');
//                                   },
//                                   validator: (value) =>
//                                       value == null ? 'field required' : null,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                   Container(
//                     margin: const EdgeInsets.only(top: 10),
//                     child: Column(
//                       children: [
//                         const Align(
//                             alignment: Alignment.centerLeft,
//                             child: Padding(
//                               padding: EdgeInsets.all(2.0),
//                               child: Text(
//                                 "Order No.",
//                                 style: TextStyle(
//                                     fontSize: 16.0,
//                                     color: Color.fromARGB(255, 7, 59, 120)),
//                               ),
//                             )),
//                         Align(
//                           alignment: Alignment.centerRight,
//                           child: Padding(
//                             padding: const EdgeInsets.all(2.0),
//                             child: Container(
//                               padding: const EdgeInsets.symmetric(
//                                   horizontal: 12, vertical: 4),
//                               // border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(25),
//                                 border: Border.all(
//                                   color: const AppColors.baseColor,
//                                 ),
//                               ),
//                               child: DropdownButtonHideUnderline(
//                                 child: DropdownButtonFormField<String>(
//                                   hint: const Text('Select'),
//                                   dropdownColor: Colors.white,
//                                   value: orderNo,
//                                   style: const TextStyle(
//                                       color: AppColors.baseColor,
//                                       fontSize: 16),
//                                   icon: const Icon(
//                                     Icons.arrow_drop_down,
//                                     color: AppColors.baseColor,
//                                     size: 20,
//                                   ),
//                                   decoration: const InputDecoration(
//                                     enabledBorder: UnderlineInputBorder(
//                                         borderSide: BorderSide(
//                                             color: Colors.transparent)),
//                                     focusedBorder: UnderlineInputBorder(
//                                         borderSide: BorderSide(
//                                             color: Colors.transparent)),
//                                   ),
//                                   isExpanded: true,
//                                   items: select_orderNo
//                                       .map(buildMenuItem)
//                                       .toList(),
//                                   onChanged: (value) {
//                                     setState(
//                                       () => this.orderNo = value,
//                                     );
//                                     // String m = getMonthNum(month.toString());
//                                     // showLoaderDialog(context);
//                                     // print(m);
//                                     // print(m);
//                                     // getData(program.toString(), year.toString(),
//                                     //     (m.isEmpty) ? '0' : m, '0');
//                                   },
//                                   validator: (value) =>
//                                       value == null ? 'field required' : null,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             actions: [],
//           );
//         });
//       });

//   DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
//       value: item,
//       child: Text(item,
//           style: const TextStyle(
//             fontWeight: FontWeight.normal,
//             fontSize: 20,
//           )));

//   Future<void> setUserName() async {
//     SharedPreferences preferences = await SharedPreferences.getInstance();
//     setState(() {
//       userName =
//           '${preferences.getString('FIRST_NAME')} ${preferences.getString('LAST_NAME')!}';
//     });
//   }
// }
