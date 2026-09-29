// import 'dart:collection';
// import 'dart:convert';
// import 'dart:io';
// import 'package:civm/screens/contractor_pannel/change_order_contractor.dart';
// import 'package:civm/screens/contractor_pannel/contractor_bottom_navigation.dart';
// import 'package:civm/screens/contractor_pannel/invoice_form_contractor.dart';
// import 'package:civm/screens/contractor_pannel/row_maintenance_progress_contractor.dart';
// import 'package:civm/screens/contractor_pannel/change_order_pending_contractor.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
// import 'package:image_picker/image_picker.dart';
// import 'package:flutter_profile_picture/flutter_profile_picture.dart';

// import '../login_page.dart';

// class EditMixingInventoryContractor extends StatefulWidget {
//   const EditMixingInventoryContractor({Key? key, required String id}) : super(key: key);

//   @override
//   State<EditMixingInventoryContractor> createState() =>
//       _EditMixingInventoryContractorState();
// }

// class _EditMixingInventoryContractorState
//     extends State<EditMixingInventoryContractor> {
//   // final List<Widget> _children = [
//   //   RowMaintenancePlan(),
//   //   // BottomNavigationHomePage(),
//   //   // BottomNavigationAccountPage()
//   // ];
//   List<String> numberOfDays = [];
//   List<List<Map<String, dynamic>>> tablesList = [];
//   List<List<List<TextEditingController>>> controllerList = [];

//   var result = [];

//   final TextEditingController _utility = TextEditingController();
//   final TextEditingController _batch = TextEditingController();
//   final TextEditingController _waterAmount = TextEditingController();

//   final TextEditingController _chemicalName = TextEditingController();
//   final TextEditingController _startOfWeekAmount = TextEditingController();
//   final TextEditingController _endOfWeekAmount = TextEditingController();

//   List<String> menu = [];
//   List<Map<String, dynamic>> listOfColumns = [];
//   List<Map<String, dynamic>> listOfColumns1 = [];

//   String datetime = DateTime.now().toString();

//   int selectedDateFlag = 0;

//   File? image;
// // ignore: non_constant_identifier_names
//   final select_foreman = [
//     'Adam',
//     'Chris',
//     'David',
//     'Gustavo',
//     'James',
//     'Jesse',
//     'Saul',
//     'Walter',
//     'Other',
//   ];
//   // ignore: non_constant_identifier_names
//   String? foreman;

//   onTappedBar(int index) {
//     setState(() {
//       // _currentIndex = index;
//     });
//   }

//   DateTime date1 = DateTime.now();
//   late String dateSelected1 = 'Week Start Date';
//   Future<void> selectDate1(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//         context: context,
//         initialDate: date1,
//         firstDate: DateTime(2010),
//         lastDate: DateTime(2050));
//     if (picked != null && picked != date1) {
//       setState(() {
//         date1 = picked;
//         dateSelected1 = DateFormat('dd/MM/yyyy').format(picked);
//       });
//     }
//   }

//   DateTime date2 = DateTime.now();
//   late String dateSelected2 = 'Week End Date';
//   Future<void> selectDate2(BuildContext context) async {
//     final DateTime? picked2 = await showDatePicker(
//         context: context,
//         initialDate: date2,
//         firstDate: DateTime(2010),
//         lastDate: DateTime(2050));
//     if (picked2 != null && picked2 != date2) {
//       setState(() {
//         date2 = picked2;
//         dateSelected2 = DateFormat('dd/MM/yyyy').format(picked2);
//       });
//     }
//   }

//   DateTime date3 = DateTime.now();
//   late String dateSelected3 = 'dd/MM/yyyy';
//   Future<void> selectDate3(BuildContext context) async {
//     final DateTime? picked3 = await showDatePicker(
//         context: context,
//         initialDate: date3,
//         firstDate: DateTime(2010),
//         lastDate: DateTime(2050));
//     if (picked3 != null && picked3 != date3) {
//       setState(() {
//         date3 = picked3;
//         dateSelected3 = DateFormat('dd/MM/yyyy').format(picked3);
//       });
//     }
//   }

//   // getDaysInBetween() {
//   //   String tempDate = dateSelected1;
//   //   final int difference = date1.difference(date2).inDays;
//   //   print("Diff:");
//   //   print(difference);

//   //   for (int i = 0; i < difference; i++) {
//   //     if (i == 0) {
//   //       numberOfDays.add(dateSelected1);
//   //       var temp = dateSelected1.split('/');
//   //     } else {}
//   //   }

//   //   return difference;
//   // }

//   DateTimeRange dateRange =
//       DateTimeRange(start: DateTime(2022, 11, 5), end: DateTime(2022, 12, 24));

//   @override
//   void initState() {
//     print("difference");
//     // getOwnPermissions();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final start = dateRange.start;
//     final end = dateRange.end;
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//         appBar: AppBar(iconTheme: const IconThemeData(color: Colors.white),
//           title: const Text('Mixing Inventory Form'),
//           backgroundColor: const Color.fromARGB(255, 7, 59, 120),
//         ),
//         drawer: DrawerManu(menu: menu),
//         body: SingleChildScrollView(
//             child: Column(children: [
//           Container(
//             margin:
//                 const EdgeInsets.only(left: 8, right: 8, top: 10, bottom: 8),
//             padding: const EdgeInsets.all(8),
//             alignment: Alignment.center,
//             // height: size.height * 0.5,
//             width: size.width * 0.99,
//             decoration: BoxDecoration(
//                 // shape: BoxShape.circle,
//                 borderRadius: BorderRadius.circular(10),
//                 boxShadow: const [
//                   BoxShadow(
//                       color: Color.fromARGB(255, 7, 59, 120),
//                       blurRadius: 10,
//                       offset: Offset(2.0, 5.0))
//                 ],
//                 gradient: const LinearGradient(
//                   colors: [
//                     Color.fromARGB(255, 255, 255, 255),
//                     Color.fromARGB(255, 255, 255, 255),
//                   ],
//                 )),
//             child: Column(
//               children: [
//                 const Align(
//                     alignment: Alignment.centerLeft,
//                     child: Padding(
//                       padding: EdgeInsets.only(
//                         left: 8.0,
//                         right: 2.0,
//                         bottom: 2.0,
//                       ),
//                       child: Text(
//                         "Utility",
//                         style: TextStyle(
//                           fontSize: 16,
//                           color: Color.fromARGB(255, 7, 59, 120),
//                           //fontWeight: FontWeight.bold
//                         ),
//                       ),
//                     )),
//                 Align(
//                   alignment: Alignment.centerRight,
//                   child: TextFormField(
//                     //key: formkey4,
//                     controller: _utility,
//                     style: const TextStyle(color: Color.fromARGB(255, 7, 59, 120), fontSize: 16),
//                     obscureText: false,
//                     // keyboardType: TextInputType.number,
//                     decoration: InputDecoration(
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(25),
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderSide: const BorderSide(
//                           color: Color.fromARGB(255, 7, 59, 120),
//                         ),
//                         borderRadius: BorderRadius.circular(25),
//                       ),
//                       hintText: 'Enter Utility',
//                     ),
//                     validator: (value) {
//                       if (value!.isEmpty) {
//                         return "Please enter Utility";
//                       } else {
//                         return null;
//                       }
//                     },
//                   ),
//                 ),
//                 const Align(
//                     alignment: Alignment.centerLeft,
//                     child: Padding(
//                       padding: EdgeInsets.only(
//                           left: 8.0, right: 2.0, bottom: 2.0, top: 8),
//                       child: Text(
//                         "Foreman",
//                         style: TextStyle(
//                           fontSize: 16,
//                           color: Color.fromARGB(255, 7, 59, 120),
//                           //fontWeight: FontWeight.bold
//                         ),
//                       ),
//                     )),
//                 Align(
//                   alignment: Alignment.centerLeft,
//                   child: DropdownButtonFormField<String>(
//                     hint: const Text('Select Number Of Employees'),
//                     dropdownColor: Colors.white,
//                     value: foreman,
//                     style: const TextStyle(color: Color.fromARGB(255, 7, 59, 120), fontSize: 16),
//                     icon: const Icon(
//                       Icons.arrow_drop_down,
//                       color: Color.fromARGB(255, 7, 59, 120),
//                       size: 40,
//                     ),
//                     decoration: InputDecoration(
//                       enabledBorder: OutlineInputBorder(
//                         borderSide: const BorderSide(
//                           color: Color.fromARGB(255, 7, 59, 120),
//                         ),
//                         borderRadius: BorderRadius.circular(25),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderSide: const BorderSide(
//                           color: Color.fromARGB(255, 7, 59, 120),
//                         ),
//                         borderRadius: BorderRadius.circular(25),
//                       ),
//                     ),
//                     isExpanded: true,
//                     items: select_foreman.map(buildMenuItem).toList(),
//                     onChanged: (value) => setState(() => this.foreman = value),
//                     validator: (value) =>
//                         value == null ? 'field required' : null,
//                   ),
//                 ),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: Padding(
//                         padding: const EdgeInsets.only(top: 8.0),
//                         child: InkWell(
//                           onTap: () {
//                             pickDateRange();
//                           },
//                           child: Container(
//                             margin: const EdgeInsets.only(
//                                 left: 4, right: 4, top: 10, bottom: 8),
//                             padding: const EdgeInsets.all(2),
//                             alignment: Alignment.center,
//                             height: size.height * 0.055,
//                             // width: size.width * 0.41,
//                             decoration: BoxDecoration(
//                                 // shape: BoxShape.circle,
//                                 borderRadius: BorderRadius.circular(10),
//                                 boxShadow: const [
//                                   BoxShadow(
//                                       color: Color.fromARGB(255, 7, 59, 120),
//                                       blurRadius: 10,
//                                       offset: Offset(2.0, 5.0))
//                                 ],
//                                 gradient: const LinearGradient(
//                                   colors: [
//                                     Colors.white,
//                                     Colors.white,
//                                   ],
//                                 )),
//                             child: Padding(
//                               padding: const EdgeInsets.only(right: 2.0),
//                               child: Row(
//                                 children: [
//                                   IconButton(
//                                     icon: const Icon(Icons.calendar_month),
//                                     iconSize: 15,
//                                     color: const Color.fromARGB(255, 7, 59, 120),
//                                     onPressed: () {
//                                       // pickDateRange();
//                                       // print(date);
//                                     },
//                                   ),
//                                   Text(
//                                       (selectedDateFlag == 0)
//                                           ? 'Start Date'
//                                           : '${start.day}/${start.month}/${start.year}',
//                                       style: const TextStyle(
//                                         fontSize: 16,
//                                         color: Color.fromARGB(255, 7, 59, 120),
//                                       )),
//                                   Row(
//                                     children: [
//                                       IconButton(
//                                         icon: const Icon(Icons.linear_scale),
//                                         iconSize: 15,
//                                         color: const Color.fromARGB(255, 7, 59, 120),
//                                         onPressed: () {
//                                           // pickDateRange();
//                                           // selectDate2(context);
//                                           // print(date);
//                                         },
//                                       ),
//                                       Text(
//                                           (selectedDateFlag == 0)
//                                               ? 'End Date'
//                                               : '${end.day}/${end.month}/${end.year}',
//                                           style: const TextStyle(
//                                             fontSize: 16,
//                                             color: Color.fromARGB(255, 7, 59, 120),
//                                           )),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(top: 8.0),
//                       child: InkWell(
//                         onTap: () {},
//                         child: Container(
//                           margin: const EdgeInsets.only(
//                               left: 4, right: 4, top: 10, bottom: 8),
//                           padding: const EdgeInsets.all(2),
//                           alignment: Alignment.center,
//                           height: size.height * 0.055,
//                           // width: size.width * 0.1,
//                           decoration: BoxDecoration(
//                               // shape: BoxShape.circle,
//                               borderRadius: BorderRadius.circular(10),
//                               boxShadow: const [
//                                 BoxShadow(
//                                     color: Color.fromARGB(255, 7, 59, 120),
//                                     blurRadius: 10,
//                                     offset: Offset(2.0, 5.0))
//                               ],
//                               gradient: const LinearGradient(
//                                 colors: [
//                                   Colors.white,
//                                   Colors.white,
//                                 ],
//                               )),
//                           child: Padding(
//                             padding: const EdgeInsets.all(0),
//                             child: IconButton(
//                               icon: const Icon(Icons.add),
//                               iconSize: 30,
//                               color: const Color.fromARGB(255, 7, 59, 120),
//                               onPressed: () {
//                                 setState(() {
//                                   // adding card
//                                   if (numberOfDays.isNotEmpty) {
//                                     var addNumberOfDays =
//                                         numberOfDays[numberOfDays.length - 1]
//                                             .split('-');
//                                     numberOfDays.add(addNumberOfDays[0] +
//                                         '-' +
//                                         addNumberOfDays[1] +
//                                         '-' +
//                                         (int.parse(addNumberOfDays[2]) + 1)
//                                             .toString());

//                                     //adding the row in table
//                                     List<Map<String, dynamic>>
//                                         listOfColumnsTemp = [];
//                                     // Map<String, dynamic> item = HashMap();
//                                     // item.addAll(
//                                     //     {'CHEMICAL_NAME': 'CHEMICAL NAME'});
//                                     // item.addAll(
//                                     //     {'CHEMICAL_AMOUNT': 'CHEMICAL AMOUNT'});
//                                     // listOfColumnsTemp.add(item);

//                                     Map<String, dynamic> item1 = HashMap();
//                                     item1.addAll({'CHEMICAL_NAME': ''});
//                                     item1.addAll({'CHEMICAL_AMOUNT': ''});
//                                     listOfColumnsTemp.add(item1);
//                                     tablesList.add(listOfColumnsTemp);

//                                     List<TextEditingController> contItem = [];
//                                     TextEditingController _chemicalName =
//                                         TextEditingController();
//                                     TextEditingController _chemicalAmount =
//                                         TextEditingController();
//                                     contItem.add(_chemicalName);
//                                     contItem.add(_chemicalAmount);
//                                     List<List<TextEditingController>> contList =
//                                         [];
//                                     contList.add(contItem);
//                                     controllerList.add(contList);
//                                   }
//                                 });
//                               },
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),

//                 // ),
//                 // Padding(
//                 //   padding: const EdgeInsets.only(top: 8.0),
//                 //   child: Text('Difference: ${difference.inDays} days',
//                 //       style: const TextStyle(
//                 //         fontSize: 16,
//                 //         color: Color.fromARGB(255, 7, 59, 120),
//                 //       )),
//                 // ),
//                 ListView.builder(
//                   shrinkWrap: true,
//                   // itemCount: 1,
//                   // itemCount:  getDaysInBetween().attractions.length,
//                   itemCount: numberOfDays.length,
//                   physics: const NeverScrollableScrollPhysics(),
//                   itemBuilder: (BuildContext context, int index) {
//                     return Container(
//                       margin: const EdgeInsets.only(
//                           left: 4, right: 4, top: 10, bottom: 8),
//                       padding: const EdgeInsets.all(8),
//                       alignment: Alignment.center,
//                       // height: size.height * 0.5,
//                       width: size.width * 0.99,
//                       decoration: BoxDecoration(
//                           // shape: BoxShape.circle,
//                           borderRadius: BorderRadius.circular(10),
//                           boxShadow: const [
//                             BoxShadow(
//                                 color: Color.fromARGB(255, 7, 59, 120),
//                                 blurRadius: 10,
//                                 offset: Offset(2.0, 5.0))
//                           ],
//                           gradient: const LinearGradient(
//                             colors: [
//                               Color.fromARGB(255, 255, 255, 255),
//                               Color.fromARGB(255, 255, 255, 255),
//                             ],
//                           )),
//                       child: Column(
//                         children: [
//                           Row(
//                             children: [
//                               Expanded(
//                                 child: Container(
//                                   margin: const EdgeInsets.only(
//                                       left: 8, right: 8, top: 10, bottom: 8),
//                                   padding: const EdgeInsets.all(2),
//                                   alignment: Alignment.center,
//                                   height: size.height * 0.047,
//                                   // width: size.width * 0.35,
//                                   decoration: BoxDecoration(
//                                       // shape: BoxShape.circle,
//                                       borderRadius: BorderRadius.circular(10),
//                                       boxShadow: const [
//                                         BoxShadow(
//                                             color: Color.fromARGB(255, 7, 59, 120),
//                                             blurRadius: 10,
//                                             offset: Offset(2.0, 5.0))
//                                       ],
//                                       gradient: const LinearGradient(
//                                         colors: [
//                                           Colors.white,
//                                           Colors.white,
//                                         ],
//                                       )),
//                                   child: Expanded(
//                                     child: Row(
//                                       children: [
//                                         IconButton(
//                                           icon:
//                                               const Icon(Icons.calendar_month),
//                                           iconSize: 15,
//                                           color: const Color.fromARGB(255, 7, 59, 120),
//                                           onPressed: () {
//                                             // selectDate3(context);
//                                             // print(date);
//                                           },
//                                         ),
//                                         Text(numberOfDays[index],
//                                             style: const TextStyle(
//                                               fontSize: 16,
//                                               color: Color.fromARGB(255, 7, 59, 120),
//                                             )),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               IconButton(
//                                   icon: const Icon(Icons.delete),
//                                   iconSize: 30,
//                                   color: const Color.fromARGB(255, 7, 59, 120),
//                                   onPressed: () {
//                                     setState(() {
//                                       numberOfDays.removeAt(index);
//                                     });
//                                   }),
//                             ],
//                           ),
//                           Row(
//                             children: [
//                               Expanded(
//                                 child: Align(
//                                     alignment: Alignment.centerLeft,
//                                     child: Padding(
//                                       padding: const EdgeInsets.only(
//                                         left: 2.0,
//                                         right: 2.0,
//                                       ),
//                                       child: Container(
//                                         margin: const EdgeInsets.only(
//                                           left: 8,
//                                           right: 8,
//                                           top: 8,
//                                         ),
//                                         padding: const EdgeInsets.all(8),
//                                         alignment: Alignment.center,
//                                         // height: size.height * 0.5,
//                                         // width: size.width * 0.99,
//                                         decoration: BoxDecoration(
//                                             // shape: BoxShape.circle,
//                                             borderRadius:
//                                                 BorderRadius.circular(10),
//                                             boxShadow: const [
//                                               BoxShadow(
//                                                   color: Color.fromARGB(255, 7, 59, 120),
//                                                   blurRadius: 10,
//                                                   offset: Offset(2.0, 5.0))
//                                             ],
//                                             gradient: const LinearGradient(
//                                               colors: [
//                                                 Color.fromARGB(255, 2, 92, 249),
//                                                 Color.fromARGB(255, 16, 1, 135),
//                                               ],
//                                             )),

//                                         child: const Text(
//                                           "Water Amount",
//                                           style: TextStyle(
//                                             fontSize: 16.0,
//                                             color: Colors.white,
//                                             //fontWeight: FontWeight.bold
//                                           ),
//                                         ),
//                                       ),
//                                     )),
//                               ),
//                               Expanded(
//                                 child: Container(
//                                   margin: const EdgeInsets.only(
//                                     left: 8,
//                                     right: 8,
//                                     top: 8,
//                                   ),
//                                   padding: const EdgeInsets.all(8),
//                                   alignment: Alignment.center,
//                                   height: size.height * 0.05,
//                                   // width: size.width * 0.99,
//                                   decoration: BoxDecoration(
//                                       // shape: BoxShape.circle,
//                                       borderRadius: BorderRadius.circular(10),
//                                       boxShadow: const [
//                                         BoxShadow(
//                                             color: Color.fromARGB(255, 7, 59, 120),
//                                             blurRadius: 10,
//                                             offset: Offset(2.0, 5.0))
//                                       ],
//                                       gradient: const LinearGradient(
//                                         colors: [
//                                           Colors.white,
//                                           Colors.white,
//                                         ],
//                                       )),

//                                   child: Align(
//                                     alignment: Alignment.centerRight,
//                                     child: Padding(
//                                       padding: const EdgeInsets.all(2.0),
//                                       child: TextFormField(
//                                         //key: formkey4,
//                                         controller: _waterAmount,
//                                         style: const TextStyle(
//                                             color: Color.fromARGB(255, 7, 59, 120), fontSize: 16),
//                                         obscureText: false,
//                                         keyboardType: TextInputType.number,
//                                         // decoration: InputDecoration(
//                                         //   border: OutlineInputBorder(
//                                         //     borderRadius: BorderRadius.circular(25),
//                                         //   ),
//                                         //   enabledBorder: OutlineInputBorder(
//                                         //     borderSide: const BorderSide(
//                                         //       color: Color.fromARGB(255, 7, 59, 120),
//                                         //     ),
//                                         //     borderRadius: BorderRadius.circular(25),
//                                         //   ),
//                                         //   hintText: 'Enter Amount',
//                                         // ),
//                                         validator: (value) {
//                                           if (value!.isEmpty) {
//                                             return "Please enter Amount";
//                                           } else {
//                                             return null;
//                                           }
//                                         },
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           Row(
//                             children: [
//                               Expanded(
//                                 child: Align(
//                                     alignment: Alignment.centerLeft,
//                                     child: Padding(
//                                       padding: const EdgeInsets.only(
//                                         left: 2.0,
//                                         right: 2.0,
//                                       ),
//                                       child: Container(
//                                         margin: const EdgeInsets.only(
//                                           left: 8,
//                                           right: 8,
//                                           top: 8,
//                                         ),
//                                         padding: const EdgeInsets.all(8),
//                                         alignment: Alignment.center,
//                                         // height: size.height * 0.5,
//                                         // width: size.width * 0.99,
//                                         decoration: BoxDecoration(
//                                             // shape: BoxShape.circle,
//                                             borderRadius:
//                                                 BorderRadius.circular(10),
//                                             boxShadow: const [
//                                               BoxShadow(
//                                                   color: Color.fromARGB(255, 7, 59, 120),
//                                                   blurRadius: 10,
//                                                   offset: Offset(2.0, 5.0))
//                                             ],
//                                             gradient: const LinearGradient(
//                                               colors: [
//                                                 Color.fromARGB(255, 2, 92, 249),
//                                                 Color.fromARGB(255, 16, 1, 135),
//                                               ],
//                                             )),

//                                         child: const Text(
//                                           "Batch",
//                                           style: TextStyle(
//                                             fontSize: 16.0,
//                                             color: Colors.white,
//                                             //fontWeight: FontWeight.bold
//                                           ),
//                                         ),
//                                       ),
//                                     )),
//                               ),
//                               Expanded(
//                                 child: Container(
//                                   margin: const EdgeInsets.only(
//                                       left: 8, right: 8, top: 10, bottom: 8),
//                                   padding: const EdgeInsets.all(8),
//                                   alignment: Alignment.center,
//                                   height: size.height * 0.05,
//                                   // width: size.width * 0.99,
//                                   decoration: BoxDecoration(
//                                       // shape: BoxShape.circle,
//                                       borderRadius: BorderRadius.circular(10),
//                                       boxShadow: const [
//                                         BoxShadow(
//                                             color: Color.fromARGB(255, 7, 59, 120),
//                                             blurRadius: 10,
//                                             offset: Offset(2.0, 5.0))
//                                       ],
//                                       gradient: const LinearGradient(
//                                         colors: [
//                                           Colors.white,
//                                           Colors.white,
//                                         ],
//                                       )),

//                                   child: Align(
//                                     alignment: Alignment.centerRight,
//                                     child: Padding(
//                                       padding: const EdgeInsets.all(2.0),
//                                       child: TextFormField(
//                                         //key: formkey4,
//                                         controller: _batch,
//                                         style: const TextStyle(
//                                             color: Color.fromARGB(255, 7, 59, 120), fontSize: 16),
//                                         obscureText: false,
//                                         keyboardType: TextInputType.number,
//                                         decoration: const InputDecoration(
//                                             // border: OutlineInputBorder(
//                                             //   borderRadius: BorderRadius.circular(25),
//                                             // ),
//                                             // enabledBorder: OutlineInputBorder(
//                                             //   borderSide: const BorderSide(
//                                             //     color: Color.fromARGB(255, 7, 59, 120),
//                                             //   ),
//                                             //   borderRadius: BorderRadius.circular(25),
//                                             // ),
//                                             // hintText: 'Enter Amount',
//                                             ),
//                                         validator: (value) {
//                                           if (value!.isEmpty) {
//                                             return "Please enter Batch";
//                                           } else {
//                                             return null;
//                                           }
//                                         },
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           ListView.builder(
//                               shrinkWrap: true,
//                               itemCount: tablesList[index].length,
//                               physics: const NeverScrollableScrollPhysics(),
//                               itemBuilder: (BuildContext context, int indx) {
//                                 return Row(
//                                   children: [
//                                     if (indx == 0) ...[
//                                       Expanded(
//                                         child: Container(
//                                           margin: const EdgeInsets.only(
//                                             // left: 8,
//                                             right: 2,
//                                             top: 4,
//                                           ),
//                                           padding: const EdgeInsets.only(
//                                               left: 4, right: 2),
//                                           alignment: Alignment.center,
//                                           height: size.height * 0.08,
//                                           // width: size.width * 0.99,
//                                           decoration: BoxDecoration(
//                                               // shape: BoxShape.circle,
//                                               borderRadius:
//                                                   BorderRadius.circular(10),
//                                               boxShadow: const [
//                                                 BoxShadow(
//                                                     color: Color.fromARGB(255, 7, 59, 120),
//                                                     blurRadius: 10,
//                                                     offset: Offset(2.0, 5.0))
//                                               ],
//                                               gradient: const LinearGradient(
//                                                 colors: [
//                                                   Colors.white,
//                                                   Colors.white,
//                                                 ],
//                                               )),

//                                           child: Align(
//                                             alignment: Alignment.centerRight,
//                                             child: Padding(
//                                               padding:
//                                                   const EdgeInsets.all(2.0),
//                                               child: TextFormField(
//                                                 //key: formkey4,
//                                                 controller:
//                                                     controllerList[index][indx]
//                                                         [0],
//                                                 style: const TextStyle(
//                                                     color: Color.fromARGB(255, 7, 59, 120),
//                                                     fontSize: 16),
//                                                 obscureText: false,
//                                                 // keyboardType:
//                                                 //     TextInputType.number,
//                                                 maxLines: 2,
//                                                 decoration:
//                                                     const InputDecoration(
//                                                   // border: OutlineInputBorder(
//                                                   //   borderRadius:
//                                                   //       BorderRadius.circular(25),
//                                                   // ),
//                                                   // enabledBorder: OutlineInputBorder(
//                                                   //   borderSide: const BorderSide(
//                                                   //     color: Color.fromARGB(255, 7, 59, 120),
//                                                   //   ),
//                                                   //   borderRadius: BorderRadius.circular(25),
//                                                   // ),
//                                                   hintText: 'Chemical Name',
//                                                 ),
//                                                 validator: (value) {
//                                                   if (value!.isEmpty) {
//                                                     return "Please enter chemical name";
//                                                   } else {
//                                                     return null;
//                                                   }
//                                                 },
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                       Expanded(
//                                         child: Container(
//                                           margin: const EdgeInsets.only(
//                                             left: 2,
//                                             // right: 8,
//                                             top: 4,
//                                           ),
//                                           padding: const EdgeInsets.only(
//                                               left: 4, right: 2),
//                                           alignment: Alignment.center,
//                                           height: size.height * 0.08,
//                                           // width: size.width * 0.99,
//                                           decoration: BoxDecoration(
//                                               // shape: BoxShape.circle,
//                                               borderRadius:
//                                                   BorderRadius.circular(10),
//                                               boxShadow: const [
//                                                 BoxShadow(
//                                                     color: Color.fromARGB(255, 7, 59, 120),
//                                                     blurRadius: 10,
//                                                     offset: Offset(2.0, 5.0))
//                                               ],
//                                               gradient: const LinearGradient(
//                                                 colors: [
//                                                   Colors.white,
//                                                   Colors.white,
//                                                 ],
//                                               )),

//                                           child: Align(
//                                             alignment: Alignment.centerRight,
//                                             child: Padding(
//                                               padding:
//                                                   const EdgeInsets.all(2.0),
//                                               child: TextFormField(
//                                                 //key: formkey4,
//                                                 controller:
//                                                     controllerList[index][indx]
//                                                         [1],
//                                                 style: const TextStyle(
//                                                     color: Color.fromARGB(255, 7, 59, 120),
//                                                     fontSize: 16),
//                                                 obscureText: false,
//                                                 keyboardType:
//                                                     TextInputType.number,
//                                                 maxLines: 2,
//                                                 decoration:
//                                                     const InputDecoration(
//                                                   // border: OutlineInputBorder(
//                                                   //   borderRadius: BorderRadius.circular(25),
//                                                   // ),
//                                                   // enabledBorder: OutlineInputBorder(
//                                                   //   borderSide: const BorderSide(
//                                                   //     color: Color.fromARGB(255, 7, 59, 120),
//                                                   //   ),
//                                                   //   borderRadius: BorderRadius.circular(25),
//                                                   // ),
//                                                   hintText: 'Chemical Amount',
//                                                 ),
//                                                 validator: (value) {
//                                                   if (value!.isEmpty) {
//                                                     return "Please enter chemical name";
//                                                   } else {
//                                                     return null;
//                                                   }
//                                                 },
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                       SizedBox(
//                                         height: 30,
//                                         width: 30,
//                                         child: IconButton(
//                                             icon: const Icon(Icons.add),
//                                             iconSize: 20,
//                                             color: const Color.fromARGB(
//                                                 255, 16, 1, 135),
//                                             onPressed: () {
//                                               setState(
//                                                 () {
//                                                   Map<String, dynamic> item1 =
//                                                       HashMap();
//                                                   item1.addAll(
//                                                       {'CHEMICAL_NAME': ''});
//                                                   item1.addAll(
//                                                       {'CHEMICAL_AMOUNT': ''});
//                                                   tablesList[index].add(item1);

//                                                   List<TextEditingController>
//                                                       contItem = [];
//                                                   TextEditingController
//                                                       _chemicalName =
//                                                       TextEditingController();
//                                                   TextEditingController
//                                                       _chemicalAmount =
//                                                       TextEditingController();
//                                                   contItem.add(_chemicalName);
//                                                   contItem.add(_chemicalAmount);
//                                                   List<List<TextEditingController>>
//                                                       contList = [];
//                                                   contList.add(contItem);
//                                                   controllerList[index]
//                                                       .add(contItem);
//                                                 },
//                                               );
//                                             }),
//                                       ),
//                                       SizedBox(
//                                         height: 30,
//                                         width: 30,
//                                         child: IconButton(
//                                             icon: const Icon(Icons.delete),
//                                             iconSize: 20,
//                                             color: const Color.fromARGB(
//                                                 255, 16, 1, 135),
//                                             onPressed: () {
//                                               setState(() {
//                                                 tablesList[index].removeLast();
//                                               });
//                                             }),
//                                       ),
//                                     ] else ...[
//                                       Expanded(
//                                         child: Container(
//                                           margin: const EdgeInsets.only(
//                                             // left: 8,
//                                             right: 2,
//                                             top: 4,
//                                           ),
//                                           padding: const EdgeInsets.only(
//                                               left: 4, right: 2),
//                                           alignment: Alignment.center,
//                                           height: size.height * 0.08,
//                                           // width: size.width * 0.99,
//                                           decoration: BoxDecoration(
//                                               // shape: BoxShape.circle,
//                                               borderRadius:
//                                                   BorderRadius.circular(10),
//                                               boxShadow: const [
//                                                 BoxShadow(
//                                                     color: Color.fromARGB(255, 7, 59, 120),
//                                                     blurRadius: 10,
//                                                     offset: Offset(2.0, 5.0))
//                                               ],
//                                               gradient: const LinearGradient(
//                                                 colors: [
//                                                   Colors.white,
//                                                   Colors.white,
//                                                 ],
//                                               )),

//                                           child: Align(
//                                             alignment: Alignment.centerRight,
//                                             child: Padding(
//                                               padding:
//                                                   const EdgeInsets.all(2.0),
//                                               child: TextFormField(
//                                                 //key: formkey4,
//                                                 controller:
//                                                     controllerList[index][indx]
//                                                         [0],
//                                                 style: const TextStyle(
//                                                     color: Color.fromARGB(255, 7, 59, 120),
//                                                     fontSize: 16),
//                                                 obscureText: false,
//                                                 // keyboardType:
//                                                 //     TextInputType.number,
//                                                 maxLines: 2,
//                                                 decoration:
//                                                     const InputDecoration(
//                                                   hintText: 'Chemical Name',
//                                                 ),
//                                                 validator: (value) {
//                                                   if (value!.isEmpty) {
//                                                     return "Please enter chemical name";
//                                                   } else {
//                                                     return null;
//                                                   }
//                                                 },
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                       Expanded(
//                                         child: Container(
//                                           margin: const EdgeInsets.only(
//                                             left: 2,
//                                             // right: 8,
//                                             top: 4,
//                                           ),
//                                           padding: const EdgeInsets.only(
//                                               left: 4, right: 2),
//                                           alignment: Alignment.center,
//                                           height: size.height * 0.08,
//                                           // width: size.width * 0.99,
//                                           decoration: BoxDecoration(
//                                               // shape: BoxShape.circle,
//                                               borderRadius:
//                                                   BorderRadius.circular(10),
//                                               boxShadow: const [
//                                                 BoxShadow(
//                                                     color: Color.fromARGB(255, 7, 59, 120),
//                                                     blurRadius: 10,
//                                                     offset: Offset(2.0, 5.0))
//                                               ],
//                                               gradient: const LinearGradient(
//                                                 colors: [
//                                                   Colors.white,
//                                                   Colors.white,
//                                                 ],
//                                               )),

//                                           child: Align(
//                                             alignment: Alignment.centerRight,
//                                             child: Padding(
//                                               padding:
//                                                   const EdgeInsets.all(2.0),
//                                               child: TextFormField(
//                                                 //key: formkey4,
//                                                 controller:
//                                                     controllerList[index][indx]
//                                                         [1],
//                                                 style: const TextStyle(
//                                                     color: Color.fromARGB(255, 7, 59, 120),
//                                                     fontSize: 16),
//                                                 obscureText: false,
//                                                 keyboardType:
//                                                     TextInputType.number,
//                                                 maxLines: 2,
//                                                 decoration:
//                                                     const InputDecoration(
//                                                   hintText: 'Chemical Amount',
//                                                 ),
//                                                 validator: (value) {
//                                                   if (value!.isEmpty) {
//                                                     return "Please enter chemical name";
//                                                   } else {
//                                                     return null;
//                                                   }
//                                                 },
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                       const SizedBox(
//                                         height: 30,
//                                         width: 30,
//                                         // child: IconButton(
//                                         //     icon: const Icon(Icons.add),
//                                         //     iconSize: 20,
//                                         //     color: const Color.fromARGB(
//                                         //         255, 16, 1, 135),
//                                         //     onPressed: () {
//                                         //       setState(
//                                         //         () {
//                                         //           Map<String, dynamic> item1 =
//                                         //               HashMap();
//                                         //           item1.addAll(
//                                         //               {'CHEMICAL_NAME': ''});
//                                         //           item1.addAll(
//                                         //               {'CHEMICAL_AMOUNT': ''});
//                                         //           tablesList[index].add(item1);

//                                         //           List<TextEditingController>
//                                         //               contItem = [];
//                                         //           TextEditingController
//                                         //               _chemicalName =
//                                         //               TextEditingController();
//                                         //           TextEditingController
//                                         //               _chemicalAmount =
//                                         //               TextEditingController();
//                                         //           contItem.add(_chemicalName);
//                                         //           contItem.add(_chemicalAmount);
//                                         //           controllerList.add(contItem);
//                                         //         },
//                                         //       );
//                                         //     }),
//                                       ),
//                                       const SizedBox(
//                                         height: 30,
//                                         width: 30,
//                                         // child: IconButton(
//                                         //     icon: const Icon(Icons.delete),
//                                         //     iconSize: 20,
//                                         //     color: const Color.fromARGB(
//                                         //         255, 16, 1, 135),
//                                         //     onPressed: () {
//                                         //       setState(() {
//                                         //         tablesList[index].removeLast();
//                                         //       });
//                                         //     }),
//                                       ),
//                                     ],
//                                   ],
//                                 );
//                               }),
//                         ],
//                       ),
//                     );
//                   },
//                 ),

//                 Padding(
//                   padding: const EdgeInsets.only(top: 8.0),
//                   child: Container(
//                     //  margin:  EdgeInsets.only(
//                     //      top: 10, bottom: 10, left: 8, right: 8),
//                     //  padding:  EdgeInsets.all(8),
//                     alignment: Alignment.center,
//                     height: size.height * 0.5,
//                     width: size.width * 0.99,
//                     decoration: BoxDecoration(
//                         // shape: BoxShape.circle,
//                         borderRadius: BorderRadius.circular(10),
//                         boxShadow: const [
//                           BoxShadow(
//                               color: Color.fromARGB(255, 7, 59, 120),
//                               blurRadius: 10,
//                               offset: Offset(2.0, 5.0))
//                         ],
//                         gradient: const LinearGradient(
//                           colors: [
//                             Color.fromARGB(255, 255, 255, 255),
//                             Color.fromARGB(255, 255, 255, 255),
//                           ],
//                         )),
//                     child: Column(
//                       children: [
//                         Container(
//                           padding: const EdgeInsets.all(10),
//                           alignment: Alignment.center,
//                           width: size.width * 0.99,
//                           // width: MediaQuery.of(context).size.width,
//                           // height: size.height * 0.5,
//                           decoration: const BoxDecoration(
//                               // shape: BoxShape.circle,
//                               //borderRadius: BorderRadius.circular(25),
//                               boxShadow: [
//                                 BoxShadow(
//                                    color: Color.fromARGB(
//                                                   255, 3, 47, 97),
//                                               blurRadius: 5,
//                                               offset: Offset(2.0, 5.0))
//                                         ],
//                                         gradient: LinearGradient(
//                                           colors: [
//                                             Color.fromARGB(255, 7, 59, 120),
//                                             Color.fromARGB(255, 7, 59, 120)
//                                 ],
//                               )),
//                           child: const Align(
//                             alignment: Alignment.centerLeft,
//                             child: Text(
//                               "Chemical Description",
//                               textAlign: TextAlign.left,
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 20,
//                               ),
//                             ),
//                           ),
//                         ),
//                         Expanded(
//                           child: InkWell(
//                             onTap: () {
//                               // Navigator.pushNamed(context,
//                               //    RoutesName.detailedServiceOrders);
//                             },
//                             child: ListView.builder(
//                                 itemCount: 10,
//                                 // itemCount: historyList.length,
//                                 itemBuilder: (BuildContext ctxt, int Index) {
//                                   return Container(
//                                     margin: const EdgeInsets.only(
//                                         left: 4, right: 4, top: 10, bottom: 8),
//                                     padding: const EdgeInsets.all(8),
//                                     alignment: Alignment.center,
//                                     // height: size.height * 0.5,
//                                     width: size.width * 0.99,
//                                     decoration: BoxDecoration(
//                                         // shape: BoxShape.circle,
//                                         borderRadius: BorderRadius.circular(10),
//                                         boxShadow: const [
//                                           BoxShadow(
//                                               color: Color.fromARGB(255, 7, 59, 120),
//                                               blurRadius: 10,
//                                               offset: Offset(2.0, 5.0))
//                                         ],
//                                         gradient: const LinearGradient(
//                                           colors: [
//                                             Color.fromARGB(255, 255, 255, 255),
//                                             Color.fromARGB(255, 255, 255, 255),
//                                           ],
//                                         )),
//                                     child: Column(
//                                       children: [
//                                         Row(
//                                           children: [
//                                             Expanded(
//                                               child: Align(
//                                                   alignment:
//                                                       Alignment.centerLeft,
//                                                   child: Padding(
//                                                     padding:
//                                                         const EdgeInsets.only(
//                                                       left: 2.0,
//                                                       right: 2.0,
//                                                     ),
//                                                     child: Container(
//                                                       margin:
//                                                           const EdgeInsets.only(
//                                                         left: 8,
//                                                         right: 8,
//                                                         top: 8,
//                                                       ),
//                                                       padding:
//                                                           const EdgeInsets.all(
//                                                               8),
//                                                       alignment:
//                                                           Alignment.center,
//                                                       // height: size.height * 0.5,
//                                                       // width: size.width * 0.99,
//                                                       decoration: BoxDecoration(
//                                                           // shape: BoxShape.circle,
//                                                           borderRadius:
//                                                               BorderRadius
//                                                                   .circular(10),
//                                                           boxShadow: const [
//                                                             BoxShadow(
//                                                                 color: Color.fromARGB(255, 7, 59, 120),
//                                                                 blurRadius: 10,
//                                                                 offset: Offset(
//                                                                     2.0, 5.0))
//                                                           ],
//                                                           gradient:
//                                                               const LinearGradient(
//                                                             colors: [
//                                                               Color.fromARGB(
//                                                                   255,
//                                                                   2,
//                                                                   92,
//                                                                   249),
//                                                               Color.fromARGB(
//                                                                   255,
//                                                                   16,
//                                                                   1,
//                                                                   135),
//                                                             ],
//                                                           )),

//                                                       child: const Text(
//                                                         "Chemical Name",
//                                                         style: TextStyle(
//                                                           fontSize: 16.0,
//                                                           color: Colors.white,
//                                                           //fontWeight: FontWeight.bold
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   )),
//                                             ),
//                                             Expanded(
//                                               child: Container(
//                                                 margin: const EdgeInsets.only(
//                                                   left: 8,
//                                                   right: 8,
//                                                   top: 8,
//                                                 ),
//                                                 padding:
//                                                     const EdgeInsets.all(8),
//                                                 alignment: Alignment.center,
//                                                 height: size.height * 0.05,
//                                                 // width: size.width * 0.99,
//                                                 decoration: BoxDecoration(
//                                                     // shape: BoxShape.circle,
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             10),
//                                                     boxShadow: const [
//                                                       BoxShadow(
//                                                           color: Color.fromARGB(255, 7, 59, 120),
//                                                           blurRadius: 10,
//                                                           offset:
//                                                               Offset(2.0, 5.0))
//                                                     ],
//                                                     gradient:
//                                                         const LinearGradient(
//                                                       colors: [
//                                                         Colors.white,
//                                                         Colors.white,
//                                                       ],
//                                                     )),

//                                                 child: Align(
//                                                   alignment:
//                                                       Alignment.centerRight,
//                                                   child: Padding(
//                                                     padding:
//                                                         const EdgeInsets.all(
//                                                             2.0),
//                                                     child: TextFormField(
//                                                       //key: formkey4,
//                                                       controller: _chemicalName,
//                                                       style: const TextStyle(
//                                                           color: Color.fromARGB(255, 7, 59, 120),
//                                                           fontSize: 16),
//                                                       obscureText: false,
//                                                       keyboardType:
//                                                           TextInputType.number,
//                                                       // decoration: InputDecoration(
//                                                       //   border: OutlineInputBorder(
//                                                       //     borderRadius: BorderRadius.circular(25),
//                                                       //   ),
//                                                       //   enabledBorder: OutlineInputBorder(
//                                                       //     borderSide: const BorderSide(
//                                                       //       color: Color.fromARGB(255, 7, 59, 120),
//                                                       //     ),
//                                                       //     borderRadius: BorderRadius.circular(25),
//                                                       //   ),
//                                                       //   hintText: 'Enter Amount',
//                                                       // ),
//                                                       validator: (value) {
//                                                         if (value!.isEmpty) {
//                                                           return "Please enter chemical name";
//                                                         } else {
//                                                           return null;
//                                                         }
//                                                       },
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                         Row(
//                                           children: [
//                                             Expanded(
//                                               child: Align(
//                                                   alignment:
//                                                       Alignment.centerLeft,
//                                                   child: Padding(
//                                                     padding:
//                                                         const EdgeInsets.only(
//                                                       left: 2.0,
//                                                       right: 2.0,
//                                                     ),
//                                                     child: Container(
//                                                       margin:
//                                                           const EdgeInsets.only(
//                                                         left: 8,
//                                                         right: 8,
//                                                         top: 8,
//                                                       ),
//                                                       padding:
//                                                           const EdgeInsets.all(
//                                                               8),
//                                                       alignment:
//                                                           Alignment.center,
//                                                       // height: size.height * 0.5,
//                                                       // width: size.width * 0.99,
//                                                       decoration: BoxDecoration(
//                                                           // shape: BoxShape.circle,
//                                                           borderRadius:
//                                                               BorderRadius
//                                                                   .circular(10),
//                                                           boxShadow: const [
//                                                             BoxShadow(
//                                                                 color: Color.fromARGB(255, 7, 59, 120),
//                                                                 blurRadius: 10,
//                                                                 offset: Offset(
//                                                                     2.0, 5.0))
//                                                           ],
//                                                           gradient:
//                                                               const LinearGradient(
//                                                             colors: [
//                                                               Color.fromARGB(
//                                                                   255,
//                                                                   2,
//                                                                   92,
//                                                                   249),
//                                                               Color.fromARGB(
//                                                                   255,
//                                                                   16,
//                                                                   1,
//                                                                   135),
//                                                             ],
//                                                           )),

//                                                       child: const Text(
//                                                         "Start Of Week Amount",
//                                                         style: TextStyle(
//                                                           fontSize: 16.0,
//                                                           color: Colors.white,
//                                                           //fontWeight: FontWeight.bold
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   )),
//                                             ),
//                                             Expanded(
//                                               child: Container(
//                                                 margin: const EdgeInsets.only(
//                                                   left: 8,
//                                                   right: 8,
//                                                   top: 8,
//                                                 ),
//                                                 padding:
//                                                     const EdgeInsets.all(8),
//                                                 alignment: Alignment.center,
//                                                 height: size.height * 0.05,
//                                                 // width: size.width * 0.99,
//                                                 decoration: BoxDecoration(
//                                                     // shape: BoxShape.circle,
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             10),
//                                                     boxShadow: const [
//                                                       BoxShadow(
//                                                           color: Color.fromARGB(255, 7, 59, 120),
//                                                           blurRadius: 10,
//                                                           offset:
//                                                               Offset(2.0, 5.0))
//                                                     ],
//                                                     gradient:
//                                                         const LinearGradient(
//                                                       colors: [
//                                                         Colors.white,
//                                                         Colors.white,
//                                                       ],
//                                                     )),

//                                                 child: Align(
//                                                   alignment:
//                                                       Alignment.centerRight,
//                                                   child: Padding(
//                                                     padding:
//                                                         const EdgeInsets.all(
//                                                             2.0),
//                                                     child: TextFormField(
//                                                       //key: formkey4,
//                                                       controller:
//                                                           _startOfWeekAmount,
//                                                       style: const TextStyle(
//                                                           color: Color.fromARGB(255, 7, 59, 120),
//                                                           fontSize: 16),
//                                                       obscureText: false,
//                                                       keyboardType:
//                                                           TextInputType.number,
//                                                       // decoration: InputDecoration(
//                                                       //   border: OutlineInputBorder(
//                                                       //     borderRadius: BorderRadius.circular(25),
//                                                       //   ),
//                                                       //   enabledBorder: OutlineInputBorder(
//                                                       //     borderSide: const BorderSide(
//                                                       //       color: Color.fromARGB(255, 7, 59, 120),
//                                                       //     ),
//                                                       //     borderRadius: BorderRadius.circular(25),
//                                                       //   ),
//                                                       //   hintText: 'Enter Amount',
//                                                       // ),
//                                                       validator: (value) {
//                                                         if (value!.isEmpty) {
//                                                           return "Please enter start of week amount";
//                                                         } else {
//                                                           return null;
//                                                         }
//                                                       },
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                         Row(
//                                           children: [
//                                             Expanded(
//                                               child: Align(
//                                                   alignment:
//                                                       Alignment.centerLeft,
//                                                   child: Padding(
//                                                     padding:
//                                                         const EdgeInsets.only(
//                                                       left: 2.0,
//                                                       right: 2.0,
//                                                     ),
//                                                     child: Container(
//                                                       margin:
//                                                           const EdgeInsets.only(
//                                                         left: 8,
//                                                         right: 8,
//                                                         top: 8,
//                                                       ),
//                                                       padding:
//                                                           const EdgeInsets.all(
//                                                               8),
//                                                       alignment:
//                                                           Alignment.center,
//                                                       // height: size.height * 0.5,
//                                                       // width: size.width * 0.99,
//                                                       decoration: BoxDecoration(
//                                                           // shape: BoxShape.circle,
//                                                           borderRadius:
//                                                               BorderRadius
//                                                                   .circular(10),
//                                                           boxShadow: const [
//                                                             BoxShadow(
//                                                                 color: Color.fromARGB(255, 7, 59, 120),
//                                                                 blurRadius: 10,
//                                                                 offset: Offset(
//                                                                     2.0, 5.0))
//                                                           ],
//                                                           gradient:
//                                                               const LinearGradient(
//                                                             colors: [
//                                                               Color.fromARGB(
//                                                                   255,
//                                                                   2,
//                                                                   92,
//                                                                   249),
//                                                               Color.fromARGB(
//                                                                   255,
//                                                                   16,
//                                                                   1,
//                                                                   135),
//                                                             ],
//                                                           )),

//                                                       child: const Text(
//                                                         "End Of Week Amount",
//                                                         style: TextStyle(
//                                                           fontSize: 16.0,
//                                                           color: Colors.white,
//                                                           //fontWeight: FontWeight.bold
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   )),
//                                             ),
//                                             Expanded(
//                                               child: Container(
//                                                 margin: const EdgeInsets.only(
//                                                   left: 8,
//                                                   right: 8,
//                                                   top: 8,
//                                                 ),
//                                                 padding:
//                                                     const EdgeInsets.all(8),
//                                                 alignment: Alignment.center,
//                                                 height: size.height * 0.05,
//                                                 // width: size.width * 0.99,
//                                                 decoration: BoxDecoration(
//                                                     // shape: BoxShape.circle,
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             10),
//                                                     boxShadow: const [
//                                                       BoxShadow(
//                                                           color: Color.fromARGB(255, 7, 59, 120),
//                                                           blurRadius: 10,
//                                                           offset:
//                                                               Offset(2.0, 5.0))
//                                                     ],
//                                                     gradient:
//                                                         const LinearGradient(
//                                                       colors: [
//                                                         Colors.white,
//                                                         Colors.white,
//                                                       ],
//                                                     )),

//                                                 child: Align(
//                                                   alignment:
//                                                       Alignment.centerRight,
//                                                   child: Padding(
//                                                     padding:
//                                                         const EdgeInsets.all(
//                                                             2.0),
//                                                     child: TextFormField(
//                                                       //key: formkey4,
//                                                       controller:
//                                                           _endOfWeekAmount,
//                                                       style: const TextStyle(
//                                                           color: Color.fromARGB(255, 7, 59, 120),
//                                                           fontSize: 16),
//                                                       obscureText: false,
//                                                       keyboardType:
//                                                           TextInputType.number,
//                                                       // decoration: InputDecoration(
//                                                       //   border: OutlineInputBorder(
//                                                       //     borderRadius: BorderRadius.circular(25),
//                                                       //   ),
//                                                       //   enabledBorder: OutlineInputBorder(
//                                                       //     borderSide: const BorderSide(
//                                                       //       color: Color.fromARGB(255, 7, 59, 120),
//                                                       //     ),
//                                                       //     borderRadius: BorderRadius.circular(25),
//                                                       //   ),
//                                                       //   hintText: 'Enter Amount',
//                                                       // ),
//                                                       validator: (value) {
//                                                         if (value!.isEmpty) {
//                                                           return "Please enter end of week amount";
//                                                         } else {
//                                                           return null;
//                                                         }
//                                                       },
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                         Row(
//                                           children: [
//                                             IconButton(
//                                                 icon: const Icon(Icons.delete),
//                                                 iconSize: 30,
//                                                 color: const Color.fromARGB(255, 7, 59, 120),
//                                                 onPressed: () {
//                                                   // setState(() {
//                                                   //   numberOfDays.removeAt(index);
//                                                   // });
//                                                 }),
//                                           ],
//                                         ),
//                                       ],
//                                     ),
//                                   );
//                                 }),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),

//                 //  Container(

//                 //     margin: const EdgeInsets.only(
//                 //                 left: 4, right: 4, top: 10, bottom: 8),
//                 //             padding: const EdgeInsets.all(8),
//                 //             alignment: Alignment.center,
//                 //             height: size.height * 0.8,
//                 //        width: size.width * 0.99,
//                 //             decoration: BoxDecoration(
//                 //                 // shape: BoxShape.circle,
//                 //                 borderRadius: BorderRadius.circular(10),
//                 //                 boxShadow: const [
//                 //                   BoxShadow(
//                 //                       color: Color.fromARGB(255, 7, 59, 120),
//                 //                       blurRadius: 10,
//                 //                       offset: Offset(2.0, 5.0))
//                 //                 ],
//                 //                 gradient: const LinearGradient(
//                 //                   colors: [
//                 //                     Color.fromARGB(255, 255, 255, 255),
//                 //                     Color.fromARGB(255, 255, 255, 255),
//                 //                   ],
//                 //                 )),

//                 //    child: Column(
//                 //      children: [
//                 //            Container(
//                 //       padding: const EdgeInsets.all(10),
//                 //       alignment: Alignment.center,
//                 //       width: size.width * 0.99,
//                 //       // width: MediaQuery.of(context).size.width,
//                 //       // height: size.height * 0.5,
//                 //       decoration: const BoxDecoration(
//                 //           // shape: BoxShape.circle,
//                 //           //borderRadius: BorderRadius.circular(25),
//                 //           boxShadow: [
//                 //             BoxShadow(
//                 //                 color: Color.fromARGB(255, 1, 84, 3),
//                 //                 blurRadius: 5,
//                 //                 offset: Offset(2.0, 5.0))
//                 //           ],
//                 //           color: Colors.black,
//                 //           gradient: LinearGradient(
//                 //             colors: [
//                 //               Color.fromARGB(255, 7, 59, 120),
//                 //               Color.fromARGB(255, 2, 111, 5),
//                 //               Color.fromARGB(255, 7, 59, 120),
//                 //             ],
//                 //           )),
//                 //       child: const Align(
//                 //         alignment: Alignment.centerLeft,
//                 //         child: Text(
//                 //           "Chemical Description",
//                 //           textAlign: TextAlign.left,
//                 //           style: TextStyle(
//                 //             color: Colors.white,
//                 //             fontWeight: FontWeight.bold,
//                 //             fontSize: 20,
//                 //           ),
//                 //         ),
//                 //       ),
//                 //     ),

//                 //        Padding(
//                 //          padding: const EdgeInsets.only(top:8.0),
//                 //          child: ListView.builder(
//                 //               // shrinkWrap: true,
//                 //               itemCount: 3,
//                 //               // itemCount:  getDaysInBetween().attractions.length,
//                 //               // itemCount: numberOfDays.length,
//                 //               // physics: const NeverScrollableScrollPhysics(),
//                 //               itemBuilder: (BuildContext context, int index) {
//                 //                 return Container(
//                 //                   margin: const EdgeInsets.only(
//                 //                       left: 4, right: 4, top: 10, bottom: 8),
//                 //                   padding: const EdgeInsets.all(8),
//                 //                   alignment: Alignment.center,
//                 //                   // height: size.height * 0.5,
//                 //                   width: size.width * 0.99,
//                 //                   decoration: BoxDecoration(
//                 //                       // shape: BoxShape.circle,
//                 //                       borderRadius: BorderRadius.circular(10),
//                 //                       boxShadow: const [
//                 //                         BoxShadow(
//                 //                             color: Color.fromARGB(255, 7, 59, 120),
//                 //                             blurRadius: 10,
//                 //                             offset: Offset(2.0, 5.0))
//                 //                       ],
//                 //                       gradient: const LinearGradient(
//                 //                         colors: [
//                 //                           Color.fromARGB(255, 255, 255, 255),
//                 //                           Color.fromARGB(255, 255, 255, 255),
//                 //                         ],
//                 //                       )),
//                 //                   child: Column(
//                 //                     children: [
//                 //                      Row(
//                 //                         children: [
//                 //                           Expanded(
//                 //                             child: Align(
//                 //                                 alignment: Alignment.centerLeft,
//                 //                                 child: Padding(
//                 //                                   padding: const EdgeInsets.only(
//                 //                                     left: 2.0,
//                 //                                     right: 2.0,
//                 //                                   ),
//                 //                                   child: Container(
//                 //                                     margin: const EdgeInsets.only(
//                 //                                       left: 8,
//                 //                                       right: 8,
//                 //                                       top: 8,
//                 //                                     ),
//                 //                                     padding: const EdgeInsets.all(8),
//                 //                                     alignment: Alignment.center,
//                 //                                     // height: size.height * 0.5,
//                 //                                     // width: size.width * 0.99,
//                 //                                     decoration: BoxDecoration(
//                 //                                         // shape: BoxShape.circle,
//                 //                                         borderRadius:
//                 //                                             BorderRadius.circular(10),
//                 //                                         boxShadow: const [
//                 //                                           BoxShadow(
//                 //                                               color: Color.fromARGB(255, 7, 59, 120),
//                 //                                               blurRadius: 10,
//                 //                                               offset:
//                 //                                                   Offset(2.0, 5.0))
//                 //                                         ],
//                 //                                         gradient:
//                 //                                             const LinearGradient(
//                 //                                           colors: [
//                 //                                             Color.fromARGB(
//                 //                                                 255, 2, 92, 249),
//                 //                                             Color.fromARGB(
//                 //                                                 255, 16, 1, 135),
//                 //                                           ],
//                 //                                         )),

//                 //                                     child: const Text(
//                 //                                       "Chemical Name",
//                 //                                       style: TextStyle(
//                 //                                         fontSize: 16.0,
//                 //                                         color: Colors.white,
//                 //                                         //fontWeight: FontWeight.bold
//                 //                                       ),
//                 //                                     ),
//                 //                                   ),
//                 //                                 )),
//                 //                           ),
//                 //                           Expanded(
//                 //                             child: Container(
//                 //                               margin: const EdgeInsets.only(
//                 //                                 left: 8,
//                 //                                 right: 8,
//                 //                                 top: 8,
//                 //                               ),
//                 //                               padding: const EdgeInsets.all(8),
//                 //                               alignment: Alignment.center,
//                 //                               height: size.height * 0.05,
//                 //                               // width: size.width * 0.99,
//                 //                               decoration: BoxDecoration(
//                 //                                   // shape: BoxShape.circle,
//                 //                                   borderRadius:
//                 //                                       BorderRadius.circular(10),
//                 //                                   boxShadow: const [
//                 //                                     BoxShadow(
//                 //                                         color: Color.fromARGB(255, 7, 59, 120),
//                 //                                         blurRadius: 10,
//                 //                                         offset: Offset(2.0, 5.0))
//                 //                                   ],
//                 //                                   gradient: const LinearGradient(
//                 //                                     colors: [
//                 //                                       Colors.white,
//                 //                                       Colors.white,
//                 //                                     ],
//                 //                                   )),

//                 //                               child: Align(
//                 //                                 alignment: Alignment.centerRight,
//                 //                                 child: Padding(
//                 //                                   padding: const EdgeInsets.all(2.0),
//                 //                                   child: TextFormField(
//                 //                                     //key: formkey4,
//                 //                                     controller: _chemicalName,
//                 //                                     style: const TextStyle(
//                 //                                         color: Color.fromARGB(255, 7, 59, 120),
//                 //                                         fontSize: 16),
//                 //                                     obscureText: false,
//                 //                                     keyboardType:
//                 //                                         TextInputType.number,
//                 //                                     // decoration: InputDecoration(
//                 //                                     //   border: OutlineInputBorder(
//                 //                                     //     borderRadius: BorderRadius.circular(25),
//                 //                                     //   ),
//                 //                                     //   enabledBorder: OutlineInputBorder(
//                 //                                     //     borderSide: const BorderSide(
//                 //                                     //       color: Color.fromARGB(255, 7, 59, 120),
//                 //                                     //     ),
//                 //                                     //     borderRadius: BorderRadius.circular(25),
//                 //                                     //   ),
//                 //                                     //   hintText: 'Enter Amount',
//                 //                                     // ),
//                 //                                     validator: (value) {
//                 //                                       if (value!.isEmpty) {
//                 //                                         return "Please enter chemical name";
//                 //                                       } else {
//                 //                                         return null;
//                 //                                       }
//                 //                                     },
//                 //                                   ),
//                 //                                 ),
//                 //                               ),
//                 //                             ),
//                 //                           ),
//                 //                         ],
//                 //                       ),
//                 //                       Row(
//                 //                         children: [
//                 //                           Expanded(
//                 //                             child: Align(
//                 //                                 alignment: Alignment.centerLeft,
//                 //                                 child: Padding(
//                 //                                   padding: const EdgeInsets.only(
//                 //                                     left: 2.0,
//                 //                                     right: 2.0,
//                 //                                   ),
//                 //                                   child: Container(
//                 //                                     margin: const EdgeInsets.only(
//                 //                                       left: 8,
//                 //                                       right: 8,
//                 //                                       top: 8,
//                 //                                     ),
//                 //                                     padding: const EdgeInsets.all(8),
//                 //                                     alignment: Alignment.center,
//                 //                                     // height: size.height * 0.5,
//                 //                                     // width: size.width * 0.99,
//                 //                                     decoration: BoxDecoration(
//                 //                                         // shape: BoxShape.circle,
//                 //                                         borderRadius:
//                 //                                             BorderRadius.circular(10),
//                 //                                         boxShadow: const [
//                 //                                           BoxShadow(
//                 //                                               color: Color.fromARGB(255, 7, 59, 120),
//                 //                                               blurRadius: 10,
//                 //                                               offset:
//                 //                                                   Offset(2.0, 5.0))
//                 //                                         ],
//                 //                                         gradient:
//                 //                                             const LinearGradient(
//                 //                                           colors: [
//                 //                                             Color.fromARGB(
//                 //                                                 255, 2, 92, 249),
//                 //                                             Color.fromARGB(
//                 //                                                 255, 16, 1, 135),
//                 //                                           ],
//                 //                                         )),

//                 //                                     child: const Text(
//                 //                                       "Start Of Week Amount",
//                 //                                       style: TextStyle(
//                 //                                         fontSize: 16.0,
//                 //                                         color: Colors.white,
//                 //                                         //fontWeight: FontWeight.bold
//                 //                                       ),
//                 //                                     ),
//                 //                                   ),
//                 //                                 )),
//                 //                           ),
//                 //                           Expanded(
//                 //                             child: Container(
//                 //                               margin: const EdgeInsets.only(
//                 //                                 left: 8,
//                 //                                 right: 8,
//                 //                                 top: 8,
//                 //                               ),
//                 //                               padding: const EdgeInsets.all(8),
//                 //                               alignment: Alignment.center,
//                 //                               height: size.height * 0.05,
//                 //                               // width: size.width * 0.99,
//                 //                               decoration: BoxDecoration(
//                 //                                   // shape: BoxShape.circle,
//                 //                                   borderRadius:
//                 //                                       BorderRadius.circular(10),
//                 //                                   boxShadow: const [
//                 //                                     BoxShadow(
//                 //                                         color: Color.fromARGB(255, 7, 59, 120),
//                 //                                         blurRadius: 10,
//                 //                                         offset: Offset(2.0, 5.0))
//                 //                                   ],
//                 //                                   gradient: const LinearGradient(
//                 //                                     colors: [
//                 //                                       Colors.white,
//                 //                                       Colors.white,
//                 //                                     ],
//                 //                                   )),

//                 //                               child: Align(
//                 //                                 alignment: Alignment.centerRight,
//                 //                                 child: Padding(
//                 //                                   padding: const EdgeInsets.all(2.0),
//                 //                                   child: TextFormField(
//                 //                                     //key: formkey4,
//                 //                                     controller: _startOfWeekAmount,
//                 //                                     style: const TextStyle(
//                 //                                         color: Color.fromARGB(255, 7, 59, 120),
//                 //                                         fontSize: 16),
//                 //                                     obscureText: false,
//                 //                                     keyboardType:
//                 //                                         TextInputType.number,
//                 //                                     // decoration: InputDecoration(
//                 //                                     //   border: OutlineInputBorder(
//                 //                                     //     borderRadius: BorderRadius.circular(25),
//                 //                                     //   ),
//                 //                                     //   enabledBorder: OutlineInputBorder(
//                 //                                     //     borderSide: const BorderSide(
//                 //                                     //       color: Color.fromARGB(255, 7, 59, 120),
//                 //                                     //     ),
//                 //                                     //     borderRadius: BorderRadius.circular(25),
//                 //                                     //   ),
//                 //                                     //   hintText: 'Enter Amount',
//                 //                                     // ),
//                 //                                     validator: (value) {
//                 //                                       if (value!.isEmpty) {
//                 //                                         return "Please enter start of week amount";
//                 //                                       } else {
//                 //                                         return null;
//                 //                                       }
//                 //                                     },
//                 //                                   ),
//                 //                                 ),
//                 //                               ),
//                 //                             ),
//                 //                           ),
//                 //                         ],
//                 //                       ),
//                 //                       Row(
//                 //                         children: [
//                 //                           Expanded(
//                 //                             child: Align(
//                 //                                 alignment: Alignment.centerLeft,
//                 //                                 child: Padding(
//                 //                                   padding: const EdgeInsets.only(
//                 //                                     left: 2.0,
//                 //                                     right: 2.0,
//                 //                                   ),
//                 //                                   child: Container(
//                 //                                     margin: const EdgeInsets.only(
//                 //                                       left: 8,
//                 //                                       right: 8,
//                 //                                       top: 8,
//                 //                                     ),
//                 //                                     padding: const EdgeInsets.all(8),
//                 //                                     alignment: Alignment.center,
//                 //                                     // height: size.height * 0.5,
//                 //                                     // width: size.width * 0.99,
//                 //                                     decoration: BoxDecoration(
//                 //                                         // shape: BoxShape.circle,
//                 //                                         borderRadius:
//                 //                                             BorderRadius.circular(10),
//                 //                                         boxShadow: const [
//                 //                                           BoxShadow(
//                 //                                               color: Color.fromARGB(255, 7, 59, 120),
//                 //                                               blurRadius: 10,
//                 //                                               offset:
//                 //                                                   Offset(2.0, 5.0))
//                 //                                         ],
//                 //                                         gradient:
//                 //                                             const LinearGradient(
//                 //                                           colors: [
//                 //                                             Color.fromARGB(
//                 //                                                 255, 2, 92, 249),
//                 //                                             Color.fromARGB(
//                 //                                                 255, 16, 1, 135),
//                 //                                           ],
//                 //                                         )),

//                 //                                     child: const Text(
//                 //                                       "End Of Week Amount",
//                 //                                       style: TextStyle(
//                 //                                         fontSize: 16.0,
//                 //                                         color: Colors.white,
//                 //                                         //fontWeight: FontWeight.bold
//                 //                                       ),
//                 //                                     ),
//                 //                                   ),
//                 //                                 )),
//                 //                           ),
//                 //                           Expanded(
//                 //                             child: Container(
//                 //                               margin: const EdgeInsets.only(
//                 //                                 left: 8,
//                 //                                 right: 8,
//                 //                                 top: 8,
//                 //                               ),
//                 //                               padding: const EdgeInsets.all(8),
//                 //                               alignment: Alignment.center,
//                 //                               height: size.height * 0.05,
//                 //                               // width: size.width * 0.99,
//                 //                               decoration: BoxDecoration(
//                 //                                   // shape: BoxShape.circle,
//                 //                                   borderRadius:
//                 //                                       BorderRadius.circular(10),
//                 //                                   boxShadow: const [
//                 //                                     BoxShadow(
//                 //                                         color: Color.fromARGB(255, 7, 59, 120),
//                 //                                         blurRadius: 10,
//                 //                                         offset: Offset(2.0, 5.0))
//                 //                                   ],
//                 //                                   gradient: const LinearGradient(
//                 //                                     colors: [
//                 //                                       Colors.white,
//                 //                                       Colors.white,
//                 //                                     ],
//                 //                                   )),

//                 //                               child: Align(
//                 //                                 alignment: Alignment.centerRight,
//                 //                                 child: Padding(
//                 //                                   padding: const EdgeInsets.all(2.0),
//                 //                                   child: TextFormField(
//                 //                                     //key: formkey4,
//                 //                                     controller: _endOfWeekAmount,
//                 //                                     style: const TextStyle(
//                 //                                         color: Color.fromARGB(255, 7, 59, 120),
//                 //                                         fontSize: 16),
//                 //                                     obscureText: false,
//                 //                                     keyboardType:
//                 //                                         TextInputType.number,
//                 //                                     // decoration: InputDecoration(
//                 //                                     //   border: OutlineInputBorder(
//                 //                                     //     borderRadius: BorderRadius.circular(25),
//                 //                                     //   ),
//                 //                                     //   enabledBorder: OutlineInputBorder(
//                 //                                     //     borderSide: const BorderSide(
//                 //                                     //       color: Color.fromARGB(255, 7, 59, 120),
//                 //                                     //     ),
//                 //                                     //     borderRadius: BorderRadius.circular(25),
//                 //                                     //   ),
//                 //                                     //   hintText: 'Enter Amount',
//                 //                                     // ),
//                 //                                     validator: (value) {
//                 //                                       if (value!.isEmpty) {
//                 //                                         return "Please enter end of week amount";
//                 //                                       } else {
//                 //                                         return null;
//                 //                                       }
//                 //                                     },
//                 //                                   ),
//                 //                                 ),
//                 //                               ),
//                 //                             ),
//                 //                           ),
//                 //                         ],
//                 //                       ),
//                 //                 Row(
//                 //                         children: [
//                 //                         IconButton(
//                 //                               icon: const Icon(Icons.delete),
//                 //                               iconSize: 30,
//                 //                               color: Color.fromARGB(255, 7, 59, 120),
//                 //                               onPressed: () {
//                 //                                 // setState(() {
//                 //                                 //   numberOfDays.removeAt(index);
//                 //                                 // });
//                 //                               }),
//                 //                         ],
//                 //                       ),

//                 //                     ],
//                 //                   ),
//                 //                 );
//                 //               },
//                 //             ),
//                 //        ),
//                 //      ],
//                 //    ),
//                 //  ),

//                 //     //
//                 Container(
//                     margin: const EdgeInsets.only(
//                         left: 6, right: 6, top: 20.0, bottom: 10),
//                     child: InkWell(
//                       onTap: () {
//                         // getDaysInBetween();
//                         // Navigator.pop(context);
//                       },
//                       child: Container(
//                         margin: const EdgeInsets.only(
//                             left: 40, right: 40, bottom: 10.0),
//                         // padding: const EdgeInsets.all(8),
//                         alignment: Alignment.center,
//                         width: MediaQuery.of(context).size.width,
//                         height: 40,
//                         decoration: BoxDecoration(
//                             // shape: BoxShape.circle,
//                             borderRadius: BorderRadius.circular(25),
//                             boxShadow: const [
//                               BoxShadow(
//                                   color: Color.fromARGB(255, 1, 65, 3),
//                                   blurRadius: 5,
//                                   offset: Offset(2.0, 5.0))
//                             ],
//                             color: Colors.black,
//                             gradient: const LinearGradient(
//                               colors: [
//                                 Color.fromARGB(255, 7, 59, 120),
//                                 Color.fromARGB(255, 2, 111, 5),
//                                 Color.fromARGB(255, 7, 59, 120),
//                               ],
//                             )),
//                         child: const Row(children: [
//                           Expanded(
//                             child: Align(
//                               alignment: Alignment.center,
//                               child: Text(
//                                 "Submit",
//                                 textAlign: TextAlign.left,
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 20,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ]),
//                       ),
//                     )),
//                 Container(
//                   margin: const EdgeInsets.only(
//                       left: 4, right: 4, top: 10, bottom: 8),
//                   padding: const EdgeInsets.all(8),
//                   alignment: Alignment.center,
//                   // height: size.height * 0.5,
//                   width: size.width * 0.99,
//                   decoration: BoxDecoration(
//                       // shape: BoxShape.circle,
//                       borderRadius: BorderRadius.circular(10),
//                       boxShadow: const [
//                         BoxShadow(
//                             color: Color.fromARGB(255, 7, 59, 120),
//                             blurRadius: 10,
//                             offset: Offset(2.0, 5.0))
//                       ],
//                       gradient: const LinearGradient(
//                         colors: [
//                           Color.fromARGB(255, 255, 255, 255),
//                           Color.fromARGB(255, 255, 255, 255),
//                         ],
//                       )),
//                   child: Column(
//                     children: [
//                       Container(
//                         padding: const EdgeInsets.all(10),
//                         alignment: Alignment.center,
//                         width: size.width * 0.99,
//                         // width: MediaQuery.of(context).size.width,
//                         // height: 40,
//                         decoration: const BoxDecoration(
//                             // shape: BoxShape.circle,
//                             //borderRadius: BorderRadius.circular(25),
//                             boxShadow: [
//                               BoxShadow(
//                                   color: Color.fromARGB(255, 1, 84, 3),
//                                   blurRadius: 5,
//                                   offset: Offset(2.0, 5.0))
//                             ],
//                             color: Colors.black,
//                             gradient: LinearGradient(
//                               colors: [
//                                 Color.fromARGB(255, 7, 59, 120),
//                                 Color.fromARGB(255, 2, 111, 5),
//                                 Color.fromARGB(255, 7, 59, 120),
//                               ],
//                             )),
//                         child: const Align(
//                           alignment: Alignment.centerLeft,
//                           child: Text(
//                             "PREMIX 5: ",
//                             textAlign: TextAlign.left,
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 20,
//                             ),
//                           ),
//                         ),
//                       ),
//                       const Row(
//                         children: [
//                           Expanded(
//                             child: Align(
//                                 alignment: Alignment.centerLeft,
//                                 child: Padding(
//                                   padding: EdgeInsets.only(
//                                       left: 2.0,
//                                       right: 2.0,
//                                       bottom: 2.0,
//                                       top: 10.0),
//                                   child: Text(
//                                     "Garlon 3A",
//                                     style: TextStyle(
//                                       fontSize: 16,
//                                       color: Color.fromARGB(255, 7, 59, 120),
//                                       //fontWeight: FontWeight.bold
//                                     ),
//                                   ),
//                                 )),
//                           ),
//                           Expanded(
//                             child: Align(
//                                 alignment: Alignment.centerLeft,
//                                 child: Padding(
//                                   padding: EdgeInsets.only(
//                                       left: 2.0,
//                                       right: 2.0,
//                                       bottom: 2.0,
//                                       top: 10.0),
//                                   child: Text(
//                                     "50%",
//                                     style: TextStyle(
//                                       fontSize: 16,
//                                       color: Color.fromARGB(255, 7, 59, 120),
//                                       //fontWeight: FontWeight.bold
//                                     ),
//                                   ),
//                                 )),
//                           ),
//                         ],
//                       ),
//                       const Row(
//                         children: [
//                           Expanded(
//                             child: Align(
//                                 alignment: Alignment.centerLeft,
//                                 child: Padding(
//                                   padding: EdgeInsets.only(
//                                       left: 2.0, right: 2.0, bottom: 2.0),
//                                   child: Text(
//                                     "Polaris 3A",
//                                     style: TextStyle(
//                                       fontSize: 16,
//                                       color: Color.fromARGB(255, 7, 59, 120),
//                                       //fontWeight: FontWeight.bold
//                                     ),
//                                   ),
//                                 )),
//                           ),
//                           Expanded(
//                             child: Align(
//                                 alignment: Alignment.centerLeft,
//                                 child: Padding(
//                                   padding: EdgeInsets.only(
//                                     left: 2.0,
//                                     right: 2.0,
//                                     bottom: 2.0,
//                                   ),
//                                   child: Text(
//                                     "50%",
//                                     style: TextStyle(
//                                       fontSize: 16,
//                                       color: Color.fromARGB(255, 7, 59, 120),
//                                       //fontWeight: FontWeight.bold
//                                     ),
//                                   ),
//                                 )),
//                           ),
//                         ],
//                       ),
//                       Container(
//                         padding: const EdgeInsets.all(10),
//                         alignment: Alignment.center,
//                         width: size.width * 0.99,
//                         // width: MediaQuery.of(context).size.width,
//                         // height: 40,
//                         decoration: const BoxDecoration(
//                             // shape: BoxShape.circle,
//                             //borderRadius: BorderRadius.circular(25),
//                             boxShadow: [
//                               BoxShadow(
//                                   color: Color.fromARGB(255, 1, 84, 3),
//                                   blurRadius: 5,
//                                   offset: Offset(2.0, 5.0))
//                             ],
//                             color: Colors.black,
//                             gradient: LinearGradient(
//                               colors: [
//                                 Color.fromARGB(255, 7, 59, 120),
//                                 Color.fromARGB(255, 2, 111, 5),
//                                 Color.fromARGB(255, 7, 59, 120),
//                               ],
//                             )),
//                         child: const Align(
//                           alignment: Alignment.centerLeft,
//                           child: Text(
//                             "PREMIX 2:: ",
//                             textAlign: TextAlign.left,
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 20,
//                             ),
//                           ),
//                         ),
//                       ),
//                       const Row(
//                         children: [
//                           Expanded(
//                             child: Align(
//                                 alignment: Alignment.centerLeft,
//                                 child: Padding(
//                                   padding: EdgeInsets.only(
//                                       left: 2.0,
//                                       right: 2.0,
//                                       bottom: 2.0,
//                                       top: 10.0),
//                                   child: Text(
//                                     "Tardon K",
//                                     style: TextStyle(
//                                       fontSize: 16,
//                                       color: Color.fromARGB(255, 7, 59, 120),
//                                       //fontWeight: FontWeight.bold
//                                     ),
//                                   ),
//                                 )),
//                           ),
//                           Expanded(
//                             child: Align(
//                                 alignment: Alignment.centerLeft,
//                                 child: Padding(
//                                   padding: EdgeInsets.only(
//                                       left: 2.0,
//                                       right: 2.0,
//                                       bottom: 2.0,
//                                       top: 10.0),
//                                   child: Text(
//                                     "25%",
//                                     style: TextStyle(
//                                       fontSize: 16,
//                                       color: Color.fromARGB(255, 7, 59, 120),
//                                       //fontWeight: FontWeight.bold
//                                     ),
//                                   ),
//                                 )),
//                           ),
//                         ],
//                       ),
//                       const Row(
//                         children: [
//                           Expanded(
//                             child: Align(
//                                 alignment: Alignment.centerLeft,
//                                 child: Padding(
//                                   padding: EdgeInsets.only(
//                                       left: 2.0, right: 2.0, bottom: 2.0),
//                                   child: Text(
//                                     "Garlon 3A ",
//                                     style: TextStyle(
//                                       fontSize: 16,
//                                       color: Color.fromARGB(255, 7, 59, 120),
//                                       //fontWeight: FontWeight.bold
//                                     ),
//                                   ),
//                                 )),
//                           ),
//                           Expanded(
//                             child: Align(
//                                 alignment: Alignment.centerLeft,
//                                 child: Padding(
//                                   padding: EdgeInsets.only(
//                                     left: 2.0,
//                                     right: 2.0,
//                                     bottom: 2.0,
//                                   ),
//                                   child: Text(
//                                     "71.8%",
//                                     style: TextStyle(
//                                       fontSize: 16,
//                                       color: Color.fromARGB(255, 7, 59, 120),
//                                       //fontWeight: FontWeight.bold
//                                     ),
//                                   ),
//                                 )),
//                           ),
//                         ],
//                       ),
//                       const Row(
//                         children: [
//                           Expanded(
//                             child: Align(
//                                 alignment: Alignment.centerLeft,
//                                 child: Padding(
//                                   padding: EdgeInsets.only(
//                                       left: 2.0, right: 2.0, bottom: 2.0),
//                                   child: Text(
//                                     "Arsenal PowerLine",
//                                     style: TextStyle(
//                                       fontSize: 16,
//                                       color: Color.fromARGB(255, 7, 59, 120),
//                                       //fontWeight: FontWeight.bold
//                                     ),
//                                   ),
//                                 )),
//                           ),
//                           Expanded(
//                             child: Align(
//                                 alignment: Alignment.centerLeft,
//                                 child: Padding(
//                                   padding: EdgeInsets.only(
//                                     left: 2.0,
//                                     right: 2.0,
//                                     bottom: 2.0,
//                                   ),
//                                   child: Text(
//                                     "3.2%",
//                                     style: TextStyle(
//                                       fontSize: 16,
//                                       color: Color.fromARGB(255, 7, 59, 120),
//                                       //fontWeight: FontWeight.bold
//                                     ),
//                                   ),
//                                 )),
//                           ),
//                         ],
//                       ),
//                       Container(
//                         padding: const EdgeInsets.all(10),
//                         alignment: Alignment.center,
//                         width: size.width * 0.99,
//                         // width: MediaQuery.of(context).size.width,
//                         // height: 40,
//                         decoration: const BoxDecoration(
//                             // shape: BoxShape.circle,
//                             //borderRadius: BorderRadius.circular(25),
//                             boxShadow: [
//                               BoxShadow(
//                                   color: Color.fromARGB(255, 1, 84, 3),
//                                   blurRadius: 5,
//                                   offset: Offset(2.0, 5.0))
//                             ],
//                             color: Colors.black,
//                             gradient: LinearGradient(
//                               colors: [
//                                 Color.fromARGB(255, 7, 59, 120),
//                                 Color.fromARGB(255, 2, 111, 5),
//                                 Color.fromARGB(255, 7, 59, 120),
//                               ],
//                             )),
//                         child: const Align(
//                           alignment: Alignment.centerLeft,
//                           child: Text(
//                             "PREMIX 3: ",
//                             textAlign: TextAlign.left,
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 20,
//                             ),
//                           ),
//                         ),
//                       ),
//                       const Row(
//                         children: [
//                           Expanded(
//                             child: Align(
//                                 alignment: Alignment.centerLeft,
//                                 child: Padding(
//                                   padding: EdgeInsets.only(
//                                       left: 2.0,
//                                       right: 2.0,
//                                       bottom: 2.0,
//                                       top: 10.0),
//                                   child: Text(
//                                     "Tardon K ",
//                                     style: TextStyle(
//                                       fontSize: 16,
//                                       color: Color.fromARGB(255, 7, 59, 120),
//                                       //fontWeight: FontWeight.bold
//                                     ),
//                                   ),
//                                 )),
//                           ),
//                           Expanded(
//                             child: Align(
//                                 alignment: Alignment.centerLeft,
//                                 child: Padding(
//                                   padding: EdgeInsets.only(
//                                       left: 2.0,
//                                       right: 2.0,
//                                       bottom: 2.0,
//                                       top: 10.0),
//                                   child: Text(
//                                     "38%",
//                                     style: TextStyle(
//                                       fontSize: 16,
//                                       color: Color.fromARGB(255, 7, 59, 120),
//                                       //fontWeight: FontWeight.bold
//                                     ),
//                                   ),
//                                 )),
//                           ),
//                         ],
//                       ),
//                       const Row(
//                         children: [
//                           Expanded(
//                             child: Align(
//                                 alignment: Alignment.centerLeft,
//                                 child: Padding(
//                                   padding: EdgeInsets.only(
//                                       left: 2.0, right: 2.0, bottom: 2.0),
//                                   child: Text(
//                                     "Arsenal PowerLine 4 oz.",
//                                     style: TextStyle(
//                                       fontSize: 16,
//                                       color: Color.fromARGB(255, 7, 59, 120),
//                                       //fontWeight: FontWeight.bold
//                                     ),
//                                   ),
//                                 )),
//                           ),
//                           Expanded(
//                             child: Align(
//                                 alignment: Alignment.centerLeft,
//                                 child: Padding(
//                                   padding: EdgeInsets.only(
//                                     left: 2.0,
//                                     right: 2.0,
//                                     bottom: 2.0,
//                                   ),
//                                   child: Text(
//                                     "3%",
//                                     style: TextStyle(
//                                       fontSize: 16,
//                                       color: Color.fromARGB(255, 7, 59, 120),
//                                       //fontWeight: FontWeight.bold
//                                     ),
//                                   ),
//                                 )),
//                           ),
//                         ],
//                       ),
//                       const Row(
//                         children: [
//                           Expanded(
//                             child: Align(
//                                 alignment: Alignment.centerLeft,
//                                 child: Padding(
//                                   padding: EdgeInsets.only(
//                                       left: 2.0, right: 2.0, bottom: 2.0),
//                                   child: Text(
//                                     "Escort XP 1.5 oz.",
//                                     style: TextStyle(
//                                       fontSize: 16,
//                                       color: Color.fromARGB(255, 7, 59, 120),
//                                       //fontWeight: FontWeight.bold
//                                     ),
//                                   ),
//                                 )),
//                           ),
//                           Expanded(
//                             child: Align(
//                                 alignment: Alignment.centerLeft,
//                                 child: Padding(
//                                   padding: EdgeInsets.only(
//                                     left: 2.0,
//                                     right: 2.0,
//                                     bottom: 2.0,
//                                   ),
//                                   child: Text(
//                                     "3%",
//                                     style: TextStyle(
//                                       fontSize: 16,
//                                       color: Color.fromARGB(255, 7, 59, 120),
//                                       //fontWeight: FontWeight.bold
//                                     ),
//                                   ),
//                                 )),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ])));
//   }

//   Future _pickImage() async {
//     final image = await ImagePicker().pickImage(source: ImageSource.gallery);
//     if (image == null) return;
//     final imageTemporary = File(image.path);

//     setState(() {
//       this.image = imageTemporary;
//     });
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

//   DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
//       value: item,
//       child: Text(item,
//           style: const TextStyle(
//             fontWeight: FontWeight.normal,
//             fontSize: 20,
//           )));

//   Future pickDateRange() async {
//     DateTimeRange? newDateRange = await showDateRangePicker(
//         context: context, firstDate: DateTime(1900), lastDate: DateTime(2100));
//     if (newDateRange == null) return;

//     setState(() {
//       dateRange = newDateRange;
//       selectedDateFlag = 1;
//       if (selectedDateFlag != 0) {
//         numberOfDays.clear();
//         for (int i = 0;
//             i <= dateRange.end.difference(dateRange.start).inDays;
//             i++) {
//           numberOfDays.add((dateRange.start.add(Duration(days: i)))
//               .toString()
//               .split(' ')[0]);
//         }
//         print(numberOfDays);

//         for (int i = 0; i < numberOfDays.length; i++) {
//           List<Map<String, dynamic>> listOfColumnsTemp = [];
//           // Map<String, dynamic> item = HashMap();
//           // item.addAll({'CHEMICAL_NAME': 'CHEMICAL NAME'});
//           // item.addAll({'CHEMICAL_AMOUNT': 'CHEMICAL AMOUNT'});
//           // listOfColumnsTemp.add(item);

//           Map<String, dynamic> item1 = HashMap();
//           item1.addAll({'CHEMICAL_NAME': ''});
//           item1.addAll({'CHEMICAL_AMOUNT': ''});
//           listOfColumnsTemp.add(item1);
//           tablesList.add(listOfColumnsTemp);

//           List<TextEditingController> contItem = [];
//           TextEditingController _chemicalName = TextEditingController();
//           TextEditingController _chemicalAmount = TextEditingController();
//           contItem.add(_chemicalName);
//           contItem.add(_chemicalAmount);
//           List<List<TextEditingController>> contList = [];
//           contList.add(contItem);
//           controllerList.add(contList);
//         }
//       }
//     });
//   }
// }

// // ignore: must_be_immutable
// class DrawerManu extends StatefulWidget {
//   List<String> menu;
//   DrawerManu({Key? key, required this.menu}) : super(key: key);

//   @override
//   State<DrawerManu> createState() => _DrawerManuState();
// }

// class _DrawerManuState extends State<DrawerManu> {
//   String userName = '';

//   @override
//   void initState() {
//     // setUserName();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: ListView(
//         // Important: Remove any padding from the ListView.
//         padding: EdgeInsets.zero,
//         children: [
//           const DrawerHeader(
//             decoration: BoxDecoration(
//               color: Color.fromARGB(255, 7, 59, 120),
//             ),
//             child: Column(
//               children: [
//                 ProfilePicture(
//                   name: 'ABC',
//                   // name: userName,
//                   radius: 50,
//                   fontsize: 25,
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(top: 6.0),
//                   child: Text(
//                     // userName,
//                     'abc@vhbhb.com',
//                     style: TextStyle(fontSize: 18, color: Colors.white),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           ListTile(
//             leading: const Icon(
//               Icons.computer,
//             ),
//             title: const Text('Contractor / Dispatch Dashboard'),
//             textColor: const Color.fromARGB(255, 7, 59, 120),
//             iconColor: const Color.fromARGB(255, 7, 59, 120),
//             onTap: () {
//               Navigator.of(context).push(MaterialPageRoute(
//                   builder: (BuildContext context) =>
//                       const ContractorBottomNavigationPannel()));
//             },
//           ),
//           ListTile(
//             leading: const Icon(
//               Icons.open_in_browser,
//             ),
//             title: const Text('Work Order Pending'),
//             textColor: const Color.fromARGB(255, 7, 59, 120),
//             iconColor: const Color.fromARGB(255, 7, 59, 120),
//             onTap: () {
//               Navigator.of(context).push(MaterialPageRoute(
//                   builder: (BuildContext context) =>
//                       const WorkOrderPendingContractor()));
//             },
//           ),
//           // Visibility(
//           //   visible: (widget.menu.isNotEmpty &&
//           //           widget.menu.contains('Energy Audit Ticket'))
//           //       ? true
//           //       : false,
//           // child:
//           ListTile(
//             leading: const Icon(
//               Icons.pending,
//             ),
//             title: const Text('Row Maintenance Progress'),
//             textColor: const Color.fromARGB(255, 7, 59, 120),
//             iconColor: const Color.fromARGB(255, 7, 59, 120),
//             onTap: () {
//               Navigator.of(context).push(MaterialPageRoute(
//                   builder: (BuildContext context) =>
//                       const RowMaintenanceProgressContractor()));
//             },
//           ),
//           // ),
//           ListTile(
//             leading: const Icon(
//               Icons.closed_caption_off,
//             ),
//             title: const Text('Change Order'),
//             textColor: const Color.fromARGB(255, 7, 59, 120),
//             iconColor: const Color.fromARGB(255, 7, 59, 120),
//             onTap: () {
//               Navigator.of(context).push(MaterialPageRoute(
//                   builder: (BuildContext context) =>
//                       const ChangeOrderContractor()));
//             },
//           ),

//           ListTile(
//             leading: const Icon(
//               Icons.inventory,
//             ),
//             title: const Text('Daily Herbicide Application Form'),
//             textColor: const Color.fromARGB(255, 7, 59, 120),
//             iconColor: const Color.fromARGB(255, 7, 59, 120),
//             onTap: () {
//               // Navigator.of(context).push(MaterialPageRoute(
//               //     builder: (BuildContext context) =>
//               //         const DailyHerbicideApplicationFormContractor()));
//             },
//           ),

//           ListTile(
//             leading: const Icon(
//               Icons.list_alt,
//             ),
//             title: const Text('Power Time Form'),
//             textColor: const Color.fromARGB(255, 7, 59, 120),
//             iconColor: const Color.fromARGB(255, 7, 59, 120),
//             onTap: () {
//               // Navigator.of(context).push(MaterialPageRoute(
//               //     builder: (BuildContext context) =>
//               //         const PowerTimeFormContractor()));
//             },
//           ),

//           ListTile(
//             leading: const Icon(
//               Icons.list_alt,
//             ),
//             title: const Text('Invoice Form'),
//             textColor: const Color.fromARGB(255, 7, 59, 120),
//             iconColor: const Color.fromARGB(255, 7, 59, 120),
//             onTap: () {
//               Navigator.of(context).push(MaterialPageRoute(
//                   builder: (BuildContext context) =>
//                       const InvoiceFormContractor()));
//             },
//           ),

//           ListTile(
//             leading: const Icon(
//               Icons.list_alt,
//             ),
//             title: const Text('Mixing Inventory Form'),
//             textColor: const Color.fromARGB(255, 7, 59, 120),
//             iconColor: const Color.fromARGB(255, 7, 59, 120),
//             onTap: () {
//               Navigator.pop(context);
//             },
//           ),

//           ListTile(
//             leading: const Icon(
//               Icons.logout,
//             ),
//             title: const Text('Log Out'),
//             textColor: const Color.fromARGB(255, 7, 59, 120),
//             iconColor: const Color.fromARGB(255, 7, 59, 120),
//             onTap: () {
//               // // Constants.prefs.setBool("LoggedIn", false);
//              Navigator.of(context).pushReplacement(MaterialPageRoute(
//                   builder: (BuildContext context) => const LoginPage()));
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   Future<void> setUserName() async {
//     SharedPreferences preferences = await SharedPreferences.getInstance();
//     setState(() {
//       userName =
//           '${preferences.getString('FIRST_NAME')} ${preferences.getString('LAST_NAME')!}';
//     });
//   }
// }
