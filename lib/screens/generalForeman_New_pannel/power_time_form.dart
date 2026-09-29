// import 'dart:convert';
// import 'dart:io';
// import 'package:civm/screens/contractor_pannel/change_order_contractor.dart';
// import 'package:civm/screens/contractor_pannel/contractor_dispatch_dashboard.dart';
// import 'package:civm/screens/contractor_pannel/daily_herbicide_application_form.dart';
// import 'package:civm/screens/contractor_pannel/invoice_form_contractor.dart';
// import 'package:civm/screens/contractor_pannel/mixing_inventory_form_contractor.dart';
// import 'package:civm/screens/contractor_pannel/row_maintenance_progress_contractor.dart';
// import 'package:civm/screens/contractor_pannel/change_order_pending_contractor.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
// import 'package:image_picker/image_picker.dart';
// import 'package:flutter_profile_picture/flutter_profile_picture.dart';

// import '../login_page.dart';

// class PowerTimeFormContractor extends StatefulWidget {
//   const PowerTimeFormContractor({Key? key}) : super(key: key);

//   @override
//   State<PowerTimeFormContractor> createState() =>
//       _PowerTimeFormContractorState();
// }

// class _PowerTimeFormContractorState extends State<PowerTimeFormContractor> {
//   // final List<Widget> _children = [
//   //   RowMaintenancePlan(),
//   //   // BottomNavigationHomePage(),
//   //   // BottomNavigationAccountPage()
//   // ];

//   final TextEditingController _contractor = TextEditingController();
//   final TextEditingController _crewNumber = TextEditingController();
//   final TextEditingController _jobNumber = TextEditingController();
//   final TextEditingController _weekendDate = TextEditingController();
//   final TextEditingController _generalForeman = TextEditingController();
//   final TextEditingController _foremanDigitalSignature =
//       TextEditingController();
//   final TextEditingController _contractor2 = TextEditingController();
//   final TextEditingController _pesticideLICNumber = TextEditingController();

//   final TextEditingController _remarks = TextEditingController();
//   final TextEditingController _foremanDigitalSignature2 =
//       TextEditingController();

//   final TextEditingController _empNo = TextEditingController();
//   final TextEditingController _empName = TextEditingController();
//   final TextEditingController _otherCrewEmployee = TextEditingController();
//   final TextEditingController _classCodeEmployee = TextEditingController();

//   final TextEditingController _hoursSundayEmployee = TextEditingController();
//   final TextEditingController _hoursMondayEmployee = TextEditingController();
//   final TextEditingController _hoursTuesdayEmployee = TextEditingController();
//   final TextEditingController _hoursWednesdayEmployee = TextEditingController();
//   final TextEditingController _hoursThursdayEmployee = TextEditingController();
//   final TextEditingController _hoursFridayEmployee = TextEditingController();
//   final TextEditingController _hoursSaturdayEmployee = TextEditingController();
//   final TextEditingController _hoursTotalEmployee = TextEditingController();

//   final TextEditingController _equipmentType = TextEditingController();
//   final TextEditingController _equipmentCode = TextEditingController();
//   final TextEditingController _otherCrewEquipment = TextEditingController();
//   final TextEditingController _classCodeEquipment = TextEditingController();

//   final TextEditingController _hoursSundayEquipment = TextEditingController();
//   final TextEditingController _hoursMondayEquipment = TextEditingController();
//   final TextEditingController _hoursTuesdayEquipment = TextEditingController();
//   final TextEditingController _hoursWednesdayEquipment =
//       TextEditingController();
//   final TextEditingController _hoursThursdayEquipment = TextEditingController();
//   final TextEditingController _hoursFridayEquipment = TextEditingController();
//   final TextEditingController _hoursSaturdayEquipment = TextEditingController();
//   final TextEditingController _hoursTotalEquipment = TextEditingController();

//   final TextEditingController _daysOfWeek = TextEditingController();
//   final TextEditingController _feederId = TextEditingController();
//   final TextEditingController _accountWoNumber = TextEditingController();
//   final TextEditingController _sectionAddress = TextEditingController();
//   final TextEditingController _notesActivityCode = TextEditingController();
//   final TextEditingController _spans = TextEditingController();
//   final TextEditingController _width = TextEditingController();
//   final TextEditingController _chemicalQuantity = TextEditingController();
//   final TextEditingController _substationId = TextEditingController();
//   final TextEditingController _workType = TextEditingController();
//   final TextEditingController _mapNumber = TextEditingController();
//   final TextEditingController _poleNumber = TextEditingController();
//   final TextEditingController _manHours = TextEditingController();
//   final TextEditingController _length = TextEditingController();
//   final TextEditingController _chemicalCode = TextEditingController();

//   int numberOfEmployeesLength = 0;
//   int numberOfEquipmentLength = 0;
//   int numberOfActivityLength = 0;

//   List<String> menu = [];

//   String datetime = DateTime.now().toString();

//   File? image;
// // ignore: non_constant_identifier_names
//   final select_numberOfEmployees = [
//     '1',
//     '2',
//     '3',
//     '4',
//     '5',
//     '6',
//     '7',
//     '8',
//     '9',
//     '10'
//   ];
//   // ignore: non_constant_identifier_names
//   String? numberOfEmployees;

//   // ignore: non_constant_identifier_names
//   final select_numberOfEquipment = [
//     '1',
//     '2',
//     '3',
//     '4',
//     '5',
//     '6',
//     '7',
//     '8',
//     '9',
//     '10'
//   ];
//   // ignore: non_constant_identifier_names
//   String? numberOfEquipment;

//   // ignore: non_constant_identifier_names
//   final select_numberOfActivities = [
//     '1',
//     '2',
//     '3',
//     '4',
//     '5',
//     '6',
//     '7',
//     '8',
//     '9',
//     '10'
//   ];
//   // ignore: non_constant_identifier_names
//   String? numberOfActivities;

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
//         appBar: AppBar(iconTheme: const IconThemeData(color: Colors.white),
//           title: const Text('Power Time Form'),
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
//                           left: 2.0, right: 2.0, bottom: 2.0, top: 20.0),
//                       child: Text(
//                         "Contractor",
//                         style: TextStyle(
//                           fontSize: 16,
//                           color: Color.fromARGB(255, 7, 59, 120),
//                           //fontWeight: FontWeight.bold
//                         ),
//                       ),
//                     )),
//                 Align(
//                   alignment: Alignment.centerRight,
//                   child: Padding(
//                     padding: const EdgeInsets.all(2.0),
//                     child: TextFormField(
//                       //key: formkey4,
//                       controller: _contractor,
//                       style: const TextStyle(color: Color.fromARGB(255, 7, 59, 120), fontSize: 16),
//                       obscureText: false,
//                       keyboardType: TextInputType.number,
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(25),
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                           borderSide: const BorderSide(
//                             color: Color.fromARGB(255, 7, 59, 120),
//                           ),
//                           borderRadius: BorderRadius.circular(25),
//                         ),
//                         hintText: 'Enter Contractor',
//                       ),
//                       validator: (value) {
//                         if (value!.isEmpty) {
//                           return "Please enter Contractor";
//                         } else {
//                           return null;
//                         }
//                       },
//                     ),
//                   ),
//                 ),
//                 const Align(
//                     alignment: Alignment.centerLeft,
//                     child: Padding(
//                       padding: EdgeInsets.only(
//                           left: 2.0, right: 2.0, bottom: 2.0, top: 20.0),
//                       child: Text(
//                         "Crew Number",
//                         style: TextStyle(
//                           fontSize: 16.0,
//                           color: Color.fromARGB(255, 7, 59, 120),
//                           //fontWeight: FontWeight.bold
//                         ),
//                       ),
//                     )),
//                 Align(
//                   alignment: Alignment.centerRight,
//                   child: Padding(
//                     padding: const EdgeInsets.all(2.0),
//                     child: TextFormField(
//                       //key: formkey4,
//                       controller: _crewNumber,
//                       style: const TextStyle(color: Color.fromARGB(255, 7, 59, 120), fontSize: 16),
//                       obscureText: false,
//                       keyboardType: TextInputType.number,
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(25),
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                           borderSide: const BorderSide(
//                             color: Color.fromARGB(255, 7, 59, 120),
//                           ),
//                           borderRadius: BorderRadius.circular(25),
//                         ),
//                         hintText: 'Enter Crew Number',
//                       ),
//                       validator: (value) {
//                         if (value!.isEmpty) {
//                           return "Please enter Crew Number";
//                         } else {
//                           return null;
//                         }
//                       },
//                     ),
//                   ),
//                 ),
//                 const Align(
//                     alignment: Alignment.centerLeft,
//                     child: Padding(
//                       padding: EdgeInsets.only(
//                           left: 2.0, right: 2.0, bottom: 2.0, top: 20.0),
//                       child: Text(
//                         "Job Number",
//                         style: TextStyle(
//                           fontSize: 16.0,
//                           color: Color.fromARGB(255, 7, 59, 120),
//                           //fontWeight: FontWeight.bold
//                         ),
//                       ),
//                     )),
//                 Align(
//                   alignment: Alignment.centerRight,
//                   child: Padding(
//                     padding: const EdgeInsets.all(2.0),
//                     child: TextFormField(
//                       //key: formkey4,
//                       controller: _jobNumber,
//                       style: const TextStyle(color: Color.fromARGB(255, 7, 59, 120), fontSize: 16),
//                       obscureText: false,
//                       keyboardType: TextInputType.number,
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(25),
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                           borderSide: const BorderSide(
//                             color: Color.fromARGB(255, 7, 59, 120),
//                           ),
//                           borderRadius: BorderRadius.circular(25),
//                         ),
//                         hintText: 'Enter Job Number',
//                       ),
//                       validator: (value) {
//                         if (value!.isEmpty) {
//                           return "Please enter Job Number";
//                         } else {
//                           return null;
//                         }
//                       },
//                     ),
//                   ),
//                 ),
//                 const Align(
//                     alignment: Alignment.centerLeft,
//                     child: Padding(
//                       padding: EdgeInsets.only(
//                           left: 2.0, right: 2.0, bottom: 2.0, top: 20.0),
//                       child: Text(
//                         "Weekend Date",
//                         style: TextStyle(
//                           fontSize: 16.0,
//                           color: Color.fromARGB(255, 7, 59, 120),
//                           //fontWeight: FontWeight.bold
//                         ),
//                       ),
//                     )),
//                 Align(
//                   alignment: Alignment.centerRight,
//                   child: Padding(
//                     padding: const EdgeInsets.all(2.0),
//                     child: TextFormField(
//                       //  key: formkey5,
//                       controller: _weekendDate,
//                       style: const TextStyle(color: Color.fromARGB(255, 7, 59, 120), fontSize: 16),
//                       obscureText: false,
//                       keyboardType: TextInputType.number,
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(25),
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                           borderSide: const BorderSide(
//                             color: Color.fromARGB(255, 7, 59, 120),
//                           ),
//                           borderRadius: BorderRadius.circular(25),
//                         ),
//                         hintText: 'Enter Weekend Date',
//                       ),
//                       validator: (value) {
//                         if (value!.isEmpty) {
//                           return "Please enter Weekend Date";
//                         } else {
//                           return null;
//                         }
//                       },
//                     ),
//                   ),
//                 ),
//                 const Align(
//                     alignment: Alignment.centerLeft,
//                     child: Padding(
//                       padding: EdgeInsets.only(
//                           left: 2.0, right: 2.0, bottom: 2.0, top: 20.0),
//                       child: Text(
//                         "General Foreman",
//                         style: TextStyle(
//                           fontSize: 16.0,
//                           color: Color.fromARGB(255, 7, 59, 120),
//                           //fontWeight: FontWeight.bold
//                         ),
//                       ),
//                     )),
//                 Align(
//                   alignment: Alignment.centerRight,
//                   child: Padding(
//                     padding: const EdgeInsets.all(2.0),
//                     child: TextFormField(
//                       //  key: formkey5,
//                       controller: _generalForeman,
//                       style: const TextStyle(color: Color.fromARGB(255, 7, 59, 120), fontSize: 16),
//                       obscureText: false,
//                       keyboardType: TextInputType.number,
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(25),
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                           borderSide: const BorderSide(
//                             color: Color.fromARGB(255, 7, 59, 120),
//                           ),
//                           borderRadius: BorderRadius.circular(25),
//                         ),
//                         hintText: 'Enter General Foreman',
//                       ),
//                       validator: (value) {
//                         if (value!.isEmpty) {
//                           return "Please enter General Foreman";
//                         } else {
//                           return null;
//                         }
//                       },
//                     ),
//                   ),
//                 ),
//                 const Align(
//                     alignment: Alignment.centerLeft,
//                     child: Padding(
//                       padding: EdgeInsets.only(
//                           left: 2.0, right: 2.0, bottom: 2.0, top: 20.0),
//                       child: Text(
//                         "Foreman Digital Signature",
//                         style: TextStyle(
//                           fontSize: 16.0,
//                           color: Color.fromARGB(255, 7, 59, 120),
//                           //fontWeight: FontWeight.bold
//                         ),
//                       ),
//                     )),
//                 Align(
//                   alignment: Alignment.centerRight,
//                   child: Padding(
//                     padding: const EdgeInsets.all(2.0),
//                     child: TextFormField(
//                       //  key: formkey5,
//                       controller: _foremanDigitalSignature,
//                       style: const TextStyle(color: Color.fromARGB(255, 7, 59, 120), fontSize: 16),
//                       obscureText: false,
//                       keyboardType: TextInputType.number,
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(25),
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                           borderSide: const BorderSide(
//                             color: Color.fromARGB(255, 7, 59, 120),
//                           ),
//                           borderRadius: BorderRadius.circular(25),
//                         ),
//                         hintText: 'Enter Foreman Digital Signature',
//                       ),
//                       validator: (value) {
//                         if (value!.isEmpty) {
//                           return "Please enter Foreman Digital Signature";
//                         } else {
//                           return null;
//                         }
//                       },
//                     ),
//                   ),
//                 ),
//                 const Align(
//                     alignment: Alignment.centerLeft,
//                     child: Padding(
//                       padding: EdgeInsets.only(
//                           left: 2.0, right: 2.0, bottom: 2.0, top: 20.0),
//                       child: Text(
//                         "Contractor",
//                         style: TextStyle(
//                           fontSize: 16.0,
//                           color: Color.fromARGB(255, 7, 59, 120),
//                           //fontWeight: FontWeight.bold
//                         ),
//                       ),
//                     )),
//                 Align(
//                   alignment: Alignment.centerRight,
//                   child: Padding(
//                     padding: const EdgeInsets.all(2.0),
//                     child: TextFormField(
//                       //  key: formkey5,
//                       controller: _contractor2,
//                       style: const TextStyle(color: Color.fromARGB(255, 7, 59, 120), fontSize: 16),
//                       obscureText: false,
//                       keyboardType: TextInputType.number,
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(25),
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                           borderSide: const BorderSide(
//                             color: Color.fromARGB(255, 7, 59, 120),
//                           ),
//                           borderRadius: BorderRadius.circular(25),
//                         ),
//                         hintText: 'Enter Contractor',
//                       ),
//                       validator: (value) {
//                         if (value!.isEmpty) {
//                           return "Please enter Contractor";
//                         } else {
//                           return null;
//                         }
//                       },
//                     ),
//                   ),
//                 ),
//                 const Align(
//                     alignment: Alignment.centerLeft,
//                     child: Padding(
//                       padding: EdgeInsets.only(
//                           left: 2.0, right: 2.0, bottom: 2.0, top: 20.0),
//                       child: Text(
//                         "Pesticide LIC Number",
//                         style: TextStyle(
//                           fontSize: 16.0,
//                           color: Color.fromARGB(255, 7, 59, 120),
//                           //fontWeight: FontWeight.bold
//                         ),
//                       ),
//                     )),
//                 Align(
//                   alignment: Alignment.centerRight,
//                   child: Padding(
//                     padding: const EdgeInsets.all(2.0),
//                     child: TextFormField(
//                       //  key: formkey5,
//                       controller: _pesticideLICNumber,
//                       style: const TextStyle(color: Color.fromARGB(255, 7, 59, 120), fontSize: 16),
//                       obscureText: false,
//                       keyboardType: TextInputType.number,
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(25),
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                           borderSide: const BorderSide(
//                             color: Color.fromARGB(255, 7, 59, 120),
//                           ),
//                           borderRadius: BorderRadius.circular(25),
//                         ),
//                         hintText: 'Enter Pesticide LIC Number',
//                       ),
//                       validator: (value) {
//                         if (value!.isEmpty) {
//                           return "Please enter Pesticide LIC Number";
//                         } else {
//                           return null;
//                         }
//                       },
//                     ),
//                   ),
//                 ),
//                 Container(
//                     margin: const EdgeInsets.only(
//                         left: 8, right: 8, top: 10, bottom: 8),
//                     padding: const EdgeInsets.all(8),
//                     alignment: Alignment.center,
//                     // height: size.height * 0.5,
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
//                           // height: 40,
//                           decoration: const BoxDecoration(
//                               // shape: BoxShape.circle,
//                               //borderRadius: BorderRadius.circular(25),
//                               boxShadow: [
//                                 BoxShadow(
//                                      color: Color.fromARGB(
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
//                           child: const Row(children: [
//                             Align(
//                               alignment: Alignment.centerLeft,
//                               child: Text(
//                                 "Employees",
//                                 textAlign: TextAlign.left,
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 20,
//                                 ),
//                               ),
//                             ),
//                           ]),
//                         ),
//                         Column(
//                           children: [
//                             Align(
//                               alignment: Alignment.centerLeft,
//                               child: Padding(
//                                 padding: const EdgeInsets.only(top: 10.0),
//                                 child: DropdownButtonFormField<String>(
//                                   hint:
//                                       const Text('Select Number Of Employees'),
//                                   dropdownColor:
//                                       Colors.white,
//                                   value: numberOfEmployees,
//                                   style: const TextStyle(
//                                       color: Color.fromARGB(255, 7, 59, 120), fontSize: 16),
//                                   icon: const Icon(
//                                     Icons.arrow_drop_down,
//                                     color: Color.fromARGB(255, 7, 59, 120),
//                                     size: 40,
//                                   ),
//                                   decoration: InputDecoration(
//                                     enabledBorder: OutlineInputBorder(
//                                       borderSide: const BorderSide(
//                                         color: Color.fromARGB(255, 7, 59, 120),
//                                       ),
//                                       borderRadius: BorderRadius.circular(25),
//                                     ),
//                                     focusedBorder: OutlineInputBorder(
//                                       borderSide: const BorderSide(
//                                         color: Color.fromARGB(255, 7, 59, 120),
//                                       ),
//                                       borderRadius: BorderRadius.circular(25),
//                                     ),
//                                   ),
//                                   isExpanded: true,
//                                   items: select_numberOfEmployees
//                                       .map(buildMenuItem)
//                                       .toList(),
//                                   onChanged: (value) {
//                                     numberOfEmployees = value;
//                                     setState(() {
//                                       getNumberOfEmployeesLength();
//                                     });
//                                   },
//                                   // onChanged: (value) => setState(
//                                   //     () => numberOfEmployees = value),
//                                   validator: (value) =>
//                                       value == null ? 'field required' : null,
//                                 ),
//                               ),
//                             ),
//                             ListView.builder(
//                               shrinkWrap: true,
//                               itemCount: numberOfEmployeesLength,
//                               // itemCount:  getDaysInBetween().attractions.length,
//                               // itemCount: numberOfDays.length,
//                               physics: const NeverScrollableScrollPhysics(),
//                               itemBuilder: (BuildContext context, int index) {
//                                 return Container(
//                                   margin: const EdgeInsets.only(
//                                       left: 4, right: 4, top: 10, bottom: 8),
//                                   padding: const EdgeInsets.all(8),
//                                   alignment: Alignment.center,
//                                   // height: size.height * 0.5,
//                                   width: size.width * 0.99,
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
//                                           Color.fromARGB(255, 255, 255, 255),
//                                           Color.fromARGB(255, 255, 255, 255),
//                                         ],
//                                       )),
//                                   child: Column(
//                                     children: [
//                                       Row(
//                                         children: [
//                                           Expanded(
//                                             child: Container(
//                                               margin: const EdgeInsets.only(
//                                                 left: 8,
//                                                 right: 8,
//                                                 top: 8,
//                                               ),
//                                               padding: const EdgeInsets.all(8),
//                                               alignment: Alignment.center,
//                                               height: size.height * 0.05,
//                                               // width: size.width * 0.99,
//                                               decoration: BoxDecoration(
//                                                   // shape: BoxShape.circle,
//                                                   borderRadius:
//                                                       BorderRadius.circular(10),
//                                                   boxShadow: const [
//                                                     BoxShadow(
//                                                         color: Color.fromARGB(255, 7, 59, 120),
//                                                         blurRadius: 10,
//                                                         offset:
//                                                             Offset(2.0, 5.0))
//                                                   ],
//                                                   gradient:
//                                                       const LinearGradient(
//                                                     colors: [
//                                                       Colors.white,
//                                                       Colors.white,
//                                                     ],
//                                                   )),

//                                               child: Align(
//                                                 alignment:
//                                                     Alignment.centerRight,
//                                                 child: Padding(
//                                                   padding:
//                                                       const EdgeInsets.all(4.0),
//                                                   child: TextFormField(
//                                                     //key: formkey4,
//                                                     controller: _empNo,
//                                                     style: const TextStyle(
//                                                         color: Color.fromARGB(255, 7, 59, 120),
//                                                         fontSize: 16),
//                                                     obscureText: false,
//                                                     keyboardType:
//                                                         TextInputType.number,
//                                                     decoration:
//                                                         const InputDecoration(
//                                                       // border: OutlineInputBorder(
//                                                       //   borderRadius: BorderRadius.circular(25),
//                                                       // ),
//                                                       // enabledBorder: OutlineInputBorder(
//                                                       //   borderSide: const BorderSide(
//                                                       //     color: Color.fromARGB(255, 7, 59, 120),
//                                                       //   ),
//                                                       //   borderRadius: BorderRadius.circular(25),
//                                                       // ),
//                                                       hintText: 'Employee No.',
//                                                     ),
//                                                     validator: (value) {
//                                                       if (value!.isEmpty) {
//                                                         return "Please enter emp no.";
//                                                       } else {
//                                                         return null;
//                                                       }
//                                                     },
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                           IconButton(
//                                               icon: const Icon(Icons.delete),
//                                               iconSize: 30,
//                                               color: const Color.fromARGB(255, 7, 59, 120),
//                                               onPressed: () {
//                                                 // setState(() {
//                                                 //   numberOfDays.removeAt(index);
//                                                 // });
//                                               }),
//                                         ],
//                                       ),
//                                       Row(
//                                         children: [
//                                           Expanded(
//                                             child: Align(
//                                                 alignment: Alignment.centerLeft,
//                                                 child: Padding(
//                                                   padding:
//                                                       const EdgeInsets.only(
//                                                     left: 2.0,
//                                                     right: 2.0,
//                                                   ),
//                                                   child: Container(
//                                                     margin:
//                                                         const EdgeInsets.only(
//                                                       left: 8,
//                                                       right: 8,
//                                                       top: 8,
//                                                     ),
//                                                     padding:
//                                                         const EdgeInsets.all(8),
//                                                     alignment: Alignment.center,
//                                                     // height: size.height * 0.5,
//                                                     // width: size.width * 0.99,
//                                                     decoration: BoxDecoration(
//                                                         // shape: BoxShape.circle,
//                                                         borderRadius:
//                                                             BorderRadius
//                                                                 .circular(10),
//                                                         boxShadow: const [
//                                                           BoxShadow(
//                                                               color:
//                                                                   Color.fromARGB(255, 7, 59, 120),
//                                                               blurRadius: 10,
//                                                               offset: Offset(
//                                                                   2.0, 5.0))
//                                                         ],
//                                                         gradient:
//                                                             const LinearGradient(
//                                                           colors: [
//                                                             Color.fromARGB(255,
//                                                                 2, 92, 249),
//                                                             Color.fromARGB(255,
//                                                                 16, 1, 135),
//                                                           ],
//                                                         )),

//                                                     child: const Text(
//                                                       "Employee Name",
//                                                       style: TextStyle(
//                                                         fontSize: 16.0,
//                                                         color: Colors.white,
//                                                         //fontWeight: FontWeight.bold
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 )),
//                                           ),
//                                           Expanded(
//                                             child: Container(
//                                               margin: const EdgeInsets.only(
//                                                 left: 8,
//                                                 right: 8,
//                                                 top: 8,
//                                               ),
//                                               padding: const EdgeInsets.all(8),
//                                               alignment: Alignment.center,
//                                               height: size.height * 0.05,
//                                               // width: size.width * 0.99,
//                                               decoration: BoxDecoration(
//                                                   // shape: BoxShape.circle,
//                                                   borderRadius:
//                                                       BorderRadius.circular(10),
//                                                   boxShadow: const [
//                                                     BoxShadow(
//                                                         color: Color.fromARGB(255, 7, 59, 120),
//                                                         blurRadius: 10,
//                                                         offset:
//                                                             Offset(2.0, 5.0))
//                                                   ],
//                                                   gradient:
//                                                       const LinearGradient(
//                                                     colors: [
//                                                       Colors.white,
//                                                       Colors.white,
//                                                     ],
//                                                   )),

//                                               child: Align(
//                                                 alignment:
//                                                     Alignment.centerRight,
//                                                 child: Padding(
//                                                   padding:
//                                                       const EdgeInsets.all(2.0),
//                                                   child: TextFormField(
//                                                     //key: formkey4,
//                                                     controller: _empName,
//                                                     style: const TextStyle(
//                                                         color: Color.fromARGB(255, 7, 59, 120),
//                                                         fontSize: 16),
//                                                     obscureText: false,
//                                                     keyboardType:
//                                                         TextInputType.number,
//                                                     // decoration: InputDecoration(
//                                                     //   border: OutlineInputBorder(
//                                                     //     borderRadius: BorderRadius.circular(25),
//                                                     //   ),
//                                                     //   enabledBorder: OutlineInputBorder(
//                                                     //     borderSide: const BorderSide(
//                                                     //       color: Color.fromARGB(255, 7, 59, 120),
//                                                     //     ),
//                                                     //     borderRadius: BorderRadius.circular(25),
//                                                     //   ),
//                                                     //   hintText: 'Enter Amount',
//                                                     // ),
//                                                     validator: (value) {
//                                                       if (value!.isEmpty) {
//                                                         return "Please enter emp no.";
//                                                       } else {
//                                                         return null;
//                                                       }
//                                                     },
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                       Row(
//                                         children: [
//                                           Expanded(
//                                             child: Align(
//                                                 alignment: Alignment.centerLeft,
//                                                 child: Padding(
//                                                   padding:
//                                                       const EdgeInsets.only(
//                                                     left: 2.0,
//                                                     right: 2.0,
//                                                   ),
//                                                   child: Container(
//                                                     margin:
//                                                         const EdgeInsets.only(
//                                                       left: 8,
//                                                       right: 8,
//                                                       top: 8,
//                                                     ),
//                                                     padding:
//                                                         const EdgeInsets.all(8),
//                                                     alignment: Alignment.center,
//                                                     // height: size.height * 0.5,
//                                                     // width: size.width * 0.99,
//                                                     decoration: BoxDecoration(
//                                                         // shape: BoxShape.circle,
//                                                         borderRadius:
//                                                             BorderRadius
//                                                                 .circular(10),
//                                                         boxShadow: const [
//                                                           BoxShadow(
//                                                               color:
//                                                                   Color.fromARGB(255, 7, 59, 120),
//                                                               blurRadius: 10,
//                                                               offset: Offset(
//                                                                   2.0, 5.0))
//                                                         ],
//                                                         gradient:
//                                                             const LinearGradient(
//                                                           colors: [
//                                                             Color.fromARGB(255,
//                                                                 2, 92, 249),
//                                                             Color.fromARGB(255,
//                                                                 16, 1, 135),
//                                                           ],
//                                                         )),

//                                                     child: const Text(
//                                                       "Other Crew",
//                                                       style: TextStyle(
//                                                         fontSize: 16.0,
//                                                         color: Colors.white,
//                                                         //fontWeight: FontWeight.bold
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 )),
//                                           ),
//                                           Expanded(
//                                             child: Container(
//                                               margin: const EdgeInsets.only(
//                                                 left: 8,
//                                                 right: 8,
//                                                 top: 8,
//                                               ),
//                                               padding: const EdgeInsets.all(8),
//                                               alignment: Alignment.center,
//                                               height: size.height * 0.05,
//                                               // width: size.width * 0.99,
//                                               decoration: BoxDecoration(
//                                                   // shape: BoxShape.circle,
//                                                   borderRadius:
//                                                       BorderRadius.circular(10),
//                                                   boxShadow: const [
//                                                     BoxShadow(
//                                                         color: Color.fromARGB(255, 7, 59, 120),
//                                                         blurRadius: 10,
//                                                         offset:
//                                                             Offset(2.0, 5.0))
//                                                   ],
//                                                   gradient:
//                                                       const LinearGradient(
//                                                     colors: [
//                                                       Colors.white,
//                                                       Colors.white,
//                                                     ],
//                                                   )),

//                                               child: Align(
//                                                 alignment:
//                                                     Alignment.centerRight,
//                                                 child: Padding(
//                                                   padding:
//                                                       const EdgeInsets.all(2.0),
//                                                   child: TextFormField(
//                                                     //key: formkey4,
//                                                     controller:
//                                                         _otherCrewEmployee,
//                                                     style: const TextStyle(
//                                                         color: Color.fromARGB(255, 7, 59, 120),
//                                                         fontSize: 16),
//                                                     obscureText: false,
//                                                     keyboardType:
//                                                         TextInputType.number,
//                                                     // decoration: InputDecoration(
//                                                     //   border: OutlineInputBorder(
//                                                     //     borderRadius: BorderRadius.circular(25),
//                                                     //   ),
//                                                     //   enabledBorder: OutlineInputBorder(
//                                                     //     borderSide: const BorderSide(
//                                                     //       color: Color.fromARGB(255, 7, 59, 120),
//                                                     //     ),
//                                                     //     borderRadius: BorderRadius.circular(25),
//                                                     //   ),
//                                                     //   hintText: 'Enter Amount',
//                                                     // ),
//                                                     validator: (value) {
//                                                       if (value!.isEmpty) {
//                                                         return "Please enter other crew";
//                                                       } else {
//                                                         return null;
//                                                       }
//                                                     },
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                       Row(
//                                         children: [
//                                           Expanded(
//                                             child: Align(
//                                                 alignment: Alignment.centerLeft,
//                                                 child: Padding(
//                                                   padding:
//                                                       const EdgeInsets.only(
//                                                     left: 2.0,
//                                                     right: 2.0,
//                                                   ),
//                                                   child: Container(
//                                                     margin:
//                                                         const EdgeInsets.only(
//                                                       left: 8,
//                                                       right: 8,
//                                                       top: 8,
//                                                     ),
//                                                     padding:
//                                                         const EdgeInsets.all(8),
//                                                     alignment: Alignment.center,
//                                                     // height: size.height * 0.5,
//                                                     // width: size.width * 0.99,
//                                                     decoration: BoxDecoration(
//                                                         // shape: BoxShape.circle,
//                                                         borderRadius:
//                                                             BorderRadius
//                                                                 .circular(10),
//                                                         boxShadow: const [
//                                                           BoxShadow(
//                                                               color:
//                                                                   Color.fromARGB(255, 7, 59, 120),
//                                                               blurRadius: 10,
//                                                               offset: Offset(
//                                                                   2.0, 5.0))
//                                                         ],
//                                                         gradient:
//                                                             const LinearGradient(
//                                                           colors: [
//                                                             Color.fromARGB(255,
//                                                                 2, 92, 249),
//                                                             Color.fromARGB(255,
//                                                                 16, 1, 135),
//                                                           ],
//                                                         )),

//                                                     child: const Text(
//                                                       "Class Code",
//                                                       style: TextStyle(
//                                                         fontSize: 16.0,
//                                                         color: Colors.white,
//                                                         //fontWeight: FontWeight.bold
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 )),
//                                           ),
//                                           Expanded(
//                                             child: Container(
//                                               margin: const EdgeInsets.only(
//                                                 left: 8,
//                                                 right: 8,
//                                                 top: 8,
//                                               ),
//                                               padding: const EdgeInsets.all(8),
//                                               alignment: Alignment.center,
//                                               height: size.height * 0.05,
//                                               // width: size.width * 0.99,
//                                               decoration: BoxDecoration(
//                                                   // shape: BoxShape.circle,
//                                                   borderRadius:
//                                                       BorderRadius.circular(10),
//                                                   boxShadow: const [
//                                                     BoxShadow(
//                                                         color: Color.fromARGB(255, 7, 59, 120),
//                                                         blurRadius: 10,
//                                                         offset:
//                                                             Offset(2.0, 5.0))
//                                                   ],
//                                                   gradient:
//                                                       const LinearGradient(
//                                                     colors: [
//                                                       Colors.white,
//                                                       Colors.white,
//                                                     ],
//                                                   )),

//                                               child: Align(
//                                                 alignment:
//                                                     Alignment.centerRight,
//                                                 child: Padding(
//                                                   padding:
//                                                       const EdgeInsets.all(2.0),
//                                                   child: TextFormField(
//                                                     //key: formkey4,
//                                                     controller:
//                                                         _classCodeEmployee,
//                                                     style: const TextStyle(
//                                                         color: Color.fromARGB(255, 7, 59, 120),
//                                                         fontSize: 16),
//                                                     obscureText: false,
//                                                     // keyboardType: TextInputType.number,
//                                                     // decoration: InputDecoration(
//                                                     //   border: OutlineInputBorder(
//                                                     //     borderRadius: BorderRadius.circular(25),
//                                                     //   ),
//                                                     //   enabledBorder: OutlineInputBorder(
//                                                     //     borderSide: const BorderSide(
//                                                     //       color: Color.fromARGB(255, 7, 59, 120),
//                                                     //     ),
//                                                     //     borderRadius: BorderRadius.circular(25),
//                                                     //   ),
//                                                     //   hintText: 'Enter Amount',
//                                                     // ),
//                                                     validator: (value) {
//                                                       if (value!.isEmpty) {
//                                                         return "Please enter class code";
//                                                       } else {
//                                                         return null;
//                                                       }
//                                                     },
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                       Row(
//                                         children: [
//                                           Expanded(
//                                             child: Align(
//                                                 alignment: Alignment.centerLeft,
//                                                 child: Padding(
//                                                   padding:
//                                                       const EdgeInsets.only(
//                                                     left: 2.0,
//                                                     right: 2.0,
//                                                   ),
//                                                   child: Container(
//                                                     margin:
//                                                         const EdgeInsets.only(
//                                                       left: 8,
//                                                       right: 8,
//                                                       top: 8,
//                                                     ),
//                                                     padding:
//                                                         const EdgeInsets.all(8),
//                                                     alignment: Alignment.center,
//                                                     // height: size.height * 0.5,
//                                                     // width: size.width * 0.99,
//                                                     decoration: BoxDecoration(
//                                                         // shape: BoxShape.circle,
//                                                         borderRadius:
//                                                             BorderRadius
//                                                                 .circular(10),
//                                                         boxShadow: const [
//                                                           BoxShadow(
//                                                               color:
//                                                                   Color.fromARGB(255, 7, 59, 120),
//                                                               blurRadius: 10,
//                                                               offset: Offset(
//                                                                   2.0, 5.0))
//                                                         ],
//                                                         gradient:
//                                                             const LinearGradient(
//                                                           colors: [
//                                                             Color.fromARGB(255,
//                                                                 2, 92, 249),
//                                                             Color.fromARGB(255,
//                                                                 16, 1, 135),
//                                                           ],
//                                                         )),

//                                                     child: const Text(
//                                                       "Days",
//                                                       style: TextStyle(
//                                                         fontSize: 16.0,
//                                                         color: Colors.white,
//                                                         //fontWeight: FontWeight.bold
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 )),
//                                           ),
//                                           Expanded(
//                                             child: Align(
//                                                 alignment: Alignment.centerLeft,
//                                                 child: Padding(
//                                                   padding:
//                                                       const EdgeInsets.only(
//                                                     left: 2.0,
//                                                     right: 2.0,
//                                                   ),
//                                                   child: Container(
//                                                     margin:
//                                                         const EdgeInsets.only(
//                                                       left: 8,
//                                                       right: 8,
//                                                       top: 8,
//                                                     ),
//                                                     padding:
//                                                         const EdgeInsets.all(8),
//                                                     alignment: Alignment.center,
//                                                     // height: size.height * 0.5,
//                                                     // width: size.width * 0.99,
//                                                     decoration: BoxDecoration(
//                                                         // shape: BoxShape.circle,
//                                                         borderRadius:
//                                                             BorderRadius
//                                                                 .circular(10),
//                                                         boxShadow: const [
//                                                           BoxShadow(
//                                                               color:
//                                                                   Color.fromARGB(255, 7, 59, 120),
//                                                               blurRadius: 10,
//                                                               offset: Offset(
//                                                                   2.0, 5.0))
//                                                         ],
//                                                         gradient:
//                                                             const LinearGradient(
//                                                           colors: [
//                                                             Color.fromARGB(255,
//                                                                 2, 92, 249),
//                                                             Color.fromARGB(255,
//                                                                 16, 1, 135),
//                                                           ],
//                                                         )),

//                                                     child: const Text(
//                                                       "Hours",
//                                                       style: TextStyle(
//                                                         fontSize: 16.0,
//                                                         color: Colors.white,
//                                                         //fontWeight: FontWeight.bold
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 )),
//                                           ),
//                                         ],
//                                       ),
//                                       Row(
//                                         children: [
//                                           Expanded(
//                                             child: Align(
//                                                 alignment: Alignment.centerLeft,
//                                                 child: Padding(
//                                                   padding:
//                                                       const EdgeInsets.only(
//                                                     left: 2.0,
//                                                     right: 2.0,
//                                                   ),
//                                                   child: Container(
//                                                     margin:
//                                                         const EdgeInsets.only(
//                                                       left: 8,
//                                                       right: 8,
//                                                       top: 8,
//                                                     ),
//                                                     padding:
//                                                         const EdgeInsets.all(8),
//                                                     alignment: Alignment.center,
//                                                     // height: size.height * 0.5,
//                                                     // width: size.width * 0.99,
//                                                     decoration: BoxDecoration(
//                                                         // shape: BoxShape.circle,
//                                                         borderRadius:
//                                                             BorderRadius
//                                                                 .circular(10),
//                                                         boxShadow: const [
//                                                           BoxShadow(
//                                                               color:
//                                                                   Color.fromARGB(255, 7, 59, 120),
//                                                               blurRadius: 10,
//                                                               offset: Offset(
//                                                                   2.0, 5.0))
//                                                         ],
//                                                         gradient:
//                                                             const LinearGradient(
//                                                           colors: [
//                                                             Color.fromARGB(255,
//                                                                 2, 92, 249),
//                                                             Color.fromARGB(255,
//                                                                 16, 1, 135),
//                                                           ],
//                                                         )),

//                                                     child: const Text(
//                                                       "Sunday",
//                                                       style: TextStyle(
//                                                         fontSize: 16.0,
//                                                         color: Colors.white,
//                                                         //fontWeight: FontWeight.bold
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 )),
//                                           ),
//                                           Expanded(
//                                             child: Container(
//                                               margin: const EdgeInsets.only(
//                                                 left: 8,
//                                                 right: 8,
//                                                 top: 8,
//                                               ),
//                                               padding: const EdgeInsets.all(8),
//                                               alignment: Alignment.center,
//                                               height: size.height * 0.05,
//                                               // width: size.width * 0.99,
//                                               decoration: BoxDecoration(
//                                                   // shape: BoxShape.circle,
//                                                   borderRadius:
//                                                       BorderRadius.circular(10),
//                                                   boxShadow: const [
//                                                     BoxShadow(
//                                                         color: Color.fromARGB(255, 7, 59, 120),
//                                                         blurRadius: 10,
//                                                         offset:
//                                                             Offset(2.0, 5.0))
//                                                   ],
//                                                   gradient:
//                                                       const LinearGradient(
//                                                     colors: [
//                                                       Colors.white,
//                                                       Colors.white,
//                                                     ],
//                                                   )),

//                                               child: Align(
//                                                 alignment:
//                                                     Alignment.centerRight,
//                                                 child: Padding(
//                                                   padding:
//                                                       const EdgeInsets.all(2.0),
//                                                   child: TextFormField(
//                                                     //key: formkey4,
//                                                     controller:
//                                                         _hoursSundayEmployee,
//                                                     style: const TextStyle(
//                                                         color: Color.fromARGB(255, 7, 59, 120),
//                                                         fontSize: 16),
//                                                     obscureText: false,
//                                                     // keyboardType: TextInputType.number,
//                                                     // decoration: InputDecoration(
//                                                     //   border: OutlineInputBorder(
//                                                     //     borderRadius: BorderRadius.circular(25),
//                                                     //   ),
//                                                     //   enabledBorder: OutlineInputBorder(
//                                                     //     borderSide: const BorderSide(
//                                                     //       color: Color.fromARGB(255, 7, 59, 120),
//                                                     //     ),
//                                                     //     borderRadius: BorderRadius.circular(25),
//                                                     //   ),
//                                                     //   hintText: 'Enter Amount',
//                                                     // ),
//                                                     validator: (value) {
//                                                       if (value!.isEmpty) {
//                                                         return "Please enter hours";
//                                                       } else {
//                                                         return null;
//                                                       }
//                                                     },
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                       Row(
//                                         children: [
//                                           Expanded(
//                                             child: Align(
//                                                 alignment: Alignment.centerLeft,
//                                                 child: Padding(
//                                                   padding:
//                                                       const EdgeInsets.only(
//                                                     left: 2.0,
//                                                     right: 2.0,
//                                                   ),
//                                                   child: Container(
//                                                     margin:
//                                                         const EdgeInsets.only(
//                                                       left: 8,
//                                                       right: 8,
//                                                       top: 8,
//                                                     ),
//                                                     padding:
//                                                         const EdgeInsets.all(8),
//                                                     alignment: Alignment.center,
//                                                     // height: size.height * 0.5,
//                                                     // width: size.width * 0.99,
//                                                     decoration: BoxDecoration(
//                                                         // shape: BoxShape.circle,
//                                                         borderRadius:
//                                                             BorderRadius
//                                                                 .circular(10),
//                                                         boxShadow: const [
//                                                           BoxShadow(
//                                                               color:
//                                                                   Color.fromARGB(255, 7, 59, 120),
//                                                               blurRadius: 10,
//                                                               offset: Offset(
//                                                                   2.0, 5.0))
//                                                         ],
//                                                         gradient:
//                                                             const LinearGradient(
//                                                           colors: [
//                                                             Color.fromARGB(255,
//                                                                 2, 92, 249),
//                                                             Color.fromARGB(255,
//                                                                 16, 1, 135),
//                                                           ],
//                                                         )),

//                                                     child: const Text(
//                                                       "Monday",
//                                                       style: TextStyle(
//                                                         fontSize: 16.0,
//                                                         color: Colors.white,
//                                                         //fontWeight: FontWeight.bold
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 )),
//                                           ),
//                                           Expanded(
//                                             child: Container(
//                                               margin: const EdgeInsets.only(
//                                                 left: 8,
//                                                 right: 8,
//                                                 top: 8,
//                                               ),
//                                               padding: const EdgeInsets.all(8),
//                                               alignment: Alignment.center,
//                                               height: size.height * 0.05,
//                                               // width: size.width * 0.99,
//                                               decoration: BoxDecoration(
//                                                   // shape: BoxShape.circle,
//                                                   borderRadius:
//                                                       BorderRadius.circular(10),
//                                                   boxShadow: const [
//                                                     BoxShadow(
//                                                         color: Color.fromARGB(255, 7, 59, 120),
//                                                         blurRadius: 10,
//                                                         offset:
//                                                             Offset(2.0, 5.0))
//                                                   ],
//                                                   gradient:
//                                                       const LinearGradient(
//                                                     colors: [
//                                                       Colors.white,
//                                                       Colors.white,
//                                                     ],
//                                                   )),

//                                               child: Align(
//                                                 alignment:
//                                                     Alignment.centerRight,
//                                                 child: Padding(
//                                                   padding:
//                                                       const EdgeInsets.all(2.0),
//                                                   child: TextFormField(
//                                                     //key: formkey4,
//                                                     controller:
//                                                         _hoursMondayEmployee,
//                                                     style: const TextStyle(
//                                                         color: Color.fromARGB(255, 7, 59, 120),
//                                                         fontSize: 16),
//                                                     obscureText: false,
//                                                     // keyboardType: TextInputType.number,
//                                                     // decoration: InputDecoration(
//                                                     //   border: OutlineInputBorder(
//                                                     //     borderRadius: BorderRadius.circular(25),
//                                                     //   ),
//                                                     //   enabledBorder: OutlineInputBorder(
//                                                     //     borderSide: const BorderSide(
//                                                     //       color: Color.fromARGB(255, 7, 59, 120),
//                                                     //     ),
//                                                     //     borderRadius: BorderRadius.circular(25),
//                                                     //   ),
//                                                     //   hintText: 'Enter Amount',
//                                                     // ),
//                                                     validator: (value) {
//                                                       if (value!.isEmpty) {
//                                                         return "Please enter hours";
//                                                       } else {
//                                                         return null;
//                                                       }
//                                                     },
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                       Row(
//                                         children: [
//                                           Expanded(
//                                             child: Align(
//                                                 alignment: Alignment.centerLeft,
//                                                 child: Padding(
//                                                   padding:
//                                                       const EdgeInsets.only(
//                                                     left: 2.0,
//                                                     right: 2.0,
//                                                   ),
//                                                   child: Container(
//                                                     margin:
//                                                         const EdgeInsets.only(
//                                                       left: 8,
//                                                       right: 8,
//                                                       top: 8,
//                                                     ),
//                                                     padding:
//                                                         const EdgeInsets.all(8),
//                                                     alignment: Alignment.center,
//                                                     // height: size.height * 0.5,
//                                                     // width: size.width * 0.99,
//                                                     decoration: BoxDecoration(
//                                                         // shape: BoxShape.circle,
//                                                         borderRadius:
//                                                             BorderRadius
//                                                                 .circular(10),
//                                                         boxShadow: const [
//                                                           BoxShadow(
//                                                               color:
//                                                                   Color.fromARGB(255, 7, 59, 120),
//                                                               blurRadius: 10,
//                                                               offset: Offset(
//                                                                   2.0, 5.0))
//                                                         ],
//                                                         gradient:
//                                                             const LinearGradient(
//                                                           colors: [
//                                                             Color.fromARGB(255,
//                                                                 2, 92, 249),
//                                                             Color.fromARGB(255,
//                                                                 16, 1, 135),
//                                                           ],
//                                                         )),

//                                                     child: const Text(
//                                                       "Tuesday",
//                                                       style: TextStyle(
//                                                         fontSize: 16.0,
//                                                         color: Colors.white,
//                                                         //fontWeight: FontWeight.bold
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 )),
//                                           ),
//                                           Expanded(
//                                             child: Container(
//                                               margin: const EdgeInsets.only(
//                                                 left: 8,
//                                                 right: 8,
//                                                 top: 8,
//                                               ),
//                                               padding: const EdgeInsets.all(8),
//                                               alignment: Alignment.center,
//                                               height: size.height * 0.05,
//                                               // width: size.width * 0.99,
//                                               decoration: BoxDecoration(
//                                                   // shape: BoxShape.circle,
//                                                   borderRadius:
//                                                       BorderRadius.circular(10),
//                                                   boxShadow: const [
//                                                     BoxShadow(
//                                                         color: Color.fromARGB(255, 7, 59, 120),
//                                                         blurRadius: 10,
//                                                         offset:
//                                                             Offset(2.0, 5.0))
//                                                   ],
//                                                   gradient:
//                                                       const LinearGradient(
//                                                     colors: [
//                                                       Colors.white,
//                                                       Colors.white,
//                                                     ],
//                                                   )),

//                                               child: Align(
//                                                 alignment:
//                                                     Alignment.centerRight,
//                                                 child: Padding(
//                                                   padding:
//                                                       const EdgeInsets.all(2.0),
//                                                   child: TextFormField(
//                                                     //key: formkey4,
//                                                     controller:
//                                                         _hoursTuesdayEmployee,
//                                                     style: const TextStyle(
//                                                         color: Color.fromARGB(255, 7, 59, 120),
//                                                         fontSize: 16),
//                                                     obscureText: false,
//                                                     // keyboardType: TextInputType.number,
//                                                     // decoration: InputDecoration(
//                                                     //   border: OutlineInputBorder(
//                                                     //     borderRadius: BorderRadius.circular(25),
//                                                     //   ),
//                                                     //   enabledBorder: OutlineInputBorder(
//                                                     //     borderSide: const BorderSide(
//                                                     //       color: Color.fromARGB(255, 7, 59, 120),
//                                                     //     ),
//                                                     //     borderRadius: BorderRadius.circular(25),
//                                                     //   ),
//                                                     //   hintText: 'Enter Amount',
//                                                     // ),
//                                                     validator: (value) {
//                                                       if (value!.isEmpty) {
//                                                         return "Please enter hours";
//                                                       } else {
//                                                         return null;
//                                                       }
//                                                     },
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                       Row(
//                                         children: [
//                                           Expanded(
//                                             child: Align(
//                                                 alignment: Alignment.centerLeft,
//                                                 child: Padding(
//                                                   padding:
//                                                       const EdgeInsets.only(
//                                                     left: 2.0,
//                                                     right: 2.0,
//                                                   ),
//                                                   child: Container(
//                                                     margin:
//                                                         const EdgeInsets.only(
//                                                       left: 8,
//                                                       right: 8,
//                                                       top: 8,
//                                                     ),
//                                                     padding:
//                                                         const EdgeInsets.all(8),
//                                                     alignment: Alignment.center,
//                                                     // height: size.height * 0.5,
//                                                     // width: size.width * 0.99,
//                                                     decoration: BoxDecoration(
//                                                         // shape: BoxShape.circle,
//                                                         borderRadius:
//                                                             BorderRadius
//                                                                 .circular(10),
//                                                         boxShadow: const [
//                                                           BoxShadow(
//                                                               color:
//                                                                   Color.fromARGB(255, 7, 59, 120),
//                                                               blurRadius: 10,
//                                                               offset: Offset(
//                                                                   2.0, 5.0))
//                                                         ],
//                                                         gradient:
//                                                             const LinearGradient(
//                                                           colors: [
//                                                             Color.fromARGB(255,
//                                                                 2, 92, 249),
//                                                             Color.fromARGB(255,
//                                                                 16, 1, 135),
//                                                           ],
//                                                         )),

//                                                     child: const Text(
//                                                       "Wednesday",
//                                                       style: TextStyle(
//                                                         fontSize: 16.0,
//                                                         color: Colors.white,
//                                                         //fontWeight: FontWeight.bold
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 )),
//                                           ),
//                                           Expanded(
//                                             child: Container(
//                                               margin: const EdgeInsets.only(
//                                                 left: 8,
//                                                 right: 8,
//                                                 top: 8,
//                                               ),
//                                               padding: const EdgeInsets.all(8),
//                                               alignment: Alignment.center,
//                                               height: size.height * 0.05,
//                                               // width: size.width * 0.99,
//                                               decoration: BoxDecoration(
//                                                   // shape: BoxShape.circle,
//                                                   borderRadius:
//                                                       BorderRadius.circular(10),
//                                                   boxShadow: const [
//                                                     BoxShadow(
//                                                         color: Color.fromARGB(255, 7, 59, 120),
//                                                         blurRadius: 10,
//                                                         offset:
//                                                             Offset(2.0, 5.0))
//                                                   ],
//                                                   gradient:
//                                                       const LinearGradient(
//                                                     colors: [
//                                                       Colors.white,
//                                                       Colors.white,
//                                                     ],
//                                                   )),

//                                               child: Align(
//                                                 alignment:
//                                                     Alignment.centerRight,
//                                                 child: Padding(
//                                                   padding:
//                                                       const EdgeInsets.all(2.0),
//                                                   child: TextFormField(
//                                                     //key: formkey4,
//                                                     controller:
//                                                         _hoursWednesdayEmployee,
//                                                     style: const TextStyle(
//                                                         color: Color.fromARGB(255, 7, 59, 120),
//                                                         fontSize: 16),
//                                                     obscureText: false,
//                                                     // keyboardType: TextInputType.number,
//                                                     // decoration: InputDecoration(
//                                                     //   border: OutlineInputBorder(
//                                                     //     borderRadius: BorderRadius.circular(25),
//                                                     //   ),
//                                                     //   enabledBorder: OutlineInputBorder(
//                                                     //     borderSide: const BorderSide(
//                                                     //       color: Color.fromARGB(255, 7, 59, 120),
//                                                     //     ),
//                                                     //     borderRadius: BorderRadius.circular(25),
//                                                     //   ),
//                                                     //   hintText: 'Enter Amount',
//                                                     // ),
//                                                     validator: (value) {
//                                                       if (value!.isEmpty) {
//                                                         return "Please enter hours";
//                                                       } else {
//                                                         return null;
//                                                       }
//                                                     },
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                       Row(
//                                         children: [
//                                           Expanded(
//                                             child: Align(
//                                                 alignment: Alignment.centerLeft,
//                                                 child: Padding(
//                                                   padding:
//                                                       const EdgeInsets.only(
//                                                     left: 2.0,
//                                                     right: 2.0,
//                                                   ),
//                                                   child: Container(
//                                                     margin:
//                                                         const EdgeInsets.only(
//                                                       left: 8,
//                                                       right: 8,
//                                                       top: 8,
//                                                     ),
//                                                     padding:
//                                                         const EdgeInsets.all(8),
//                                                     alignment: Alignment.center,
//                                                     // height: size.height * 0.5,
//                                                     // width: size.width * 0.99,
//                                                     decoration: BoxDecoration(
//                                                         // shape: BoxShape.circle,
//                                                         borderRadius:
//                                                             BorderRadius
//                                                                 .circular(10),
//                                                         boxShadow: const [
//                                                           BoxShadow(
//                                                               color:
//                                                                   Color.fromARGB(255, 7, 59, 120),
//                                                               blurRadius: 10,
//                                                               offset: Offset(
//                                                                   2.0, 5.0))
//                                                         ],
//                                                         gradient:
//                                                             const LinearGradient(
//                                                           colors: [
//                                                             Color.fromARGB(255,
//                                                                 2, 92, 249),
//                                                             Color.fromARGB(255,
//                                                                 16, 1, 135),
//                                                           ],
//                                                         )),

//                                                     child: const Text(
//                                                       "Thursday",
//                                                       style: TextStyle(
//                                                         fontSize: 16.0,
//                                                         color: Colors.white,
//                                                         //fontWeight: FontWeight.bold
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 )),
//                                           ),
//                                           Expanded(
//                                             child: Container(
//                                               margin: const EdgeInsets.only(
//                                                 left: 8,
//                                                 right: 8,
//                                                 top: 8,
//                                               ),
//                                               padding: const EdgeInsets.all(8),
//                                               alignment: Alignment.center,
//                                               height: size.height * 0.05,
//                                               // width: size.width * 0.99,
//                                               decoration: BoxDecoration(
//                                                   // shape: BoxShape.circle,
//                                                   borderRadius:
//                                                       BorderRadius.circular(10),
//                                                   boxShadow: const [
//                                                     BoxShadow(
//                                                         color: Color.fromARGB(255, 7, 59, 120),
//                                                         blurRadius: 10,
//                                                         offset:
//                                                             Offset(2.0, 5.0))
//                                                   ],
//                                                   gradient:
//                                                       const LinearGradient(
//                                                     colors: [
//                                                       Colors.white,
//                                                       Colors.white,
//                                                     ],
//                                                   )),

//                                               child: Align(
//                                                 alignment:
//                                                     Alignment.centerRight,
//                                                 child: Padding(
//                                                   padding:
//                                                       const EdgeInsets.all(2.0),
//                                                   child: TextFormField(
//                                                     //key: formkey4,
//                                                     controller:
//                                                         _hoursThursdayEmployee,
//                                                     style: const TextStyle(
//                                                         color: Color.fromARGB(255, 7, 59, 120),
//                                                         fontSize: 16),
//                                                     obscureText: false,
//                                                     // keyboardType: TextInputType.number,
//                                                     // decoration: InputDecoration(
//                                                     //   border: OutlineInputBorder(
//                                                     //     borderRadius: BorderRadius.circular(25),
//                                                     //   ),
//                                                     //   enabledBorder: OutlineInputBorder(
//                                                     //     borderSide: const BorderSide(
//                                                     //       color: Color.fromARGB(255, 7, 59, 120),
//                                                     //     ),
//                                                     //     borderRadius: BorderRadius.circular(25),
//                                                     //   ),
//                                                     //   hintText: 'Enter Amount',
//                                                     // ),
//                                                     validator: (value) {
//                                                       if (value!.isEmpty) {
//                                                         return "Please enter hours";
//                                                       } else {
//                                                         return null;
//                                                       }
//                                                     },
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                       Row(
//                                         children: [
//                                           Expanded(
//                                             child: Align(
//                                                 alignment: Alignment.centerLeft,
//                                                 child: Padding(
//                                                   padding:
//                                                       const EdgeInsets.only(
//                                                     left: 2.0,
//                                                     right: 2.0,
//                                                   ),
//                                                   child: Container(
//                                                     margin:
//                                                         const EdgeInsets.only(
//                                                       left: 8,
//                                                       right: 8,
//                                                       top: 8,
//                                                     ),
//                                                     padding:
//                                                         const EdgeInsets.all(8),
//                                                     alignment: Alignment.center,
//                                                     // height: size.height * 0.5,
//                                                     // width: size.width * 0.99,
//                                                     decoration: BoxDecoration(
//                                                         // shape: BoxShape.circle,
//                                                         borderRadius:
//                                                             BorderRadius
//                                                                 .circular(10),
//                                                         boxShadow: const [
//                                                           BoxShadow(
//                                                               color:
//                                                                   Color.fromARGB(255, 7, 59, 120),
//                                                               blurRadius: 10,
//                                                               offset: Offset(
//                                                                   2.0, 5.0))
//                                                         ],
//                                                         gradient:
//                                                             const LinearGradient(
//                                                           colors: [
//                                                             Color.fromARGB(255,
//                                                                 2, 92, 249),
//                                                             Color.fromARGB(255,
//                                                                 16, 1, 135),
//                                                           ],
//                                                         )),

//                                                     child: const Text(
//                                                       "Friday",
//                                                       style: TextStyle(
//                                                         fontSize: 16.0,
//                                                         color: Colors.white,
//                                                         //fontWeight: FontWeight.bold
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 )),
//                                           ),
//                                           Expanded(
//                                             child: Container(
//                                               margin: const EdgeInsets.only(
//                                                 left: 8,
//                                                 right: 8,
//                                                 top: 8,
//                                               ),
//                                               padding: const EdgeInsets.all(8),
//                                               alignment: Alignment.center,
//                                               height: size.height * 0.05,
//                                               // width: size.width * 0.99,
//                                               decoration: BoxDecoration(
//                                                   // shape: BoxShape.circle,
//                                                   borderRadius:
//                                                       BorderRadius.circular(10),
//                                                   boxShadow: const [
//                                                     BoxShadow(
//                                                         color: Color.fromARGB(255, 7, 59, 120),
//                                                         blurRadius: 10,
//                                                         offset:
//                                                             Offset(2.0, 5.0))
//                                                   ],
//                                                   gradient:
//                                                       const LinearGradient(
//                                                     colors: [
//                                                       Colors.white,
//                                                       Colors.white,
//                                                     ],
//                                                   )),

//                                               child: Align(
//                                                 alignment:
//                                                     Alignment.centerRight,
//                                                 child: Padding(
//                                                   padding:
//                                                       const EdgeInsets.all(2.0),
//                                                   child: TextFormField(
//                                                     //key: formkey4,
//                                                     controller:
//                                                         _hoursFridayEmployee,
//                                                     style: const TextStyle(
//                                                         color: Color.fromARGB(255, 7, 59, 120),
//                                                         fontSize: 16),
//                                                     obscureText: false,
//                                                     // keyboardType: TextInputType.number,
//                                                     // decoration: InputDecoration(
//                                                     //   border: OutlineInputBorder(
//                                                     //     borderRadius: BorderRadius.circular(25),
//                                                     //   ),
//                                                     //   enabledBorder: OutlineInputBorder(
//                                                     //     borderSide: const BorderSide(
//                                                     //       color: Color.fromARGB(255, 7, 59, 120),
//                                                     //     ),
//                                                     //     borderRadius: BorderRadius.circular(25),
//                                                     //   ),
//                                                     //   hintText: 'Enter Amount',
//                                                     // ),
//                                                     validator: (value) {
//                                                       if (value!.isEmpty) {
//                                                         return "Please enter hours";
//                                                       } else {
//                                                         return null;
//                                                       }
//                                                     },
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                       Row(
//                                         children: [
//                                           Expanded(
//                                             child: Align(
//                                                 alignment: Alignment.centerLeft,
//                                                 child: Padding(
//                                                   padding:
//                                                       const EdgeInsets.only(
//                                                     left: 2.0,
//                                                     right: 2.0,
//                                                   ),
//                                                   child: Container(
//                                                     margin:
//                                                         const EdgeInsets.only(
//                                                       left: 8,
//                                                       right: 8,
//                                                       top: 8,
//                                                     ),
//                                                     padding:
//                                                         const EdgeInsets.all(8),
//                                                     alignment: Alignment.center,
//                                                     // height: size.height * 0.5,
//                                                     // width: size.width * 0.99,
//                                                     decoration: BoxDecoration(
//                                                         // shape: BoxShape.circle,
//                                                         borderRadius:
//                                                             BorderRadius
//                                                                 .circular(10),
//                                                         boxShadow: const [
//                                                           BoxShadow(
//                                                               color:
//                                                                   Color.fromARGB(255, 7, 59, 120),
//                                                               blurRadius: 10,
//                                                               offset: Offset(
//                                                                   2.0, 5.0))
//                                                         ],
//                                                         gradient:
//                                                             const LinearGradient(
//                                                           colors: [
//                                                             Color.fromARGB(255,
//                                                                 2, 92, 249),
//                                                             Color.fromARGB(255,
//                                                                 16, 1, 135),
//                                                           ],
//                                                         )),

//                                                     child: const Text(
//                                                       "Saturday",
//                                                       style: TextStyle(
//                                                         fontSize: 16.0,
//                                                         color: Colors.white,
//                                                         //fontWeight: FontWeight.bold
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 )),
//                                           ),
//                                           Expanded(
//                                             child: Container(
//                                               margin: const EdgeInsets.only(
//                                                 left: 8,
//                                                 right: 8,
//                                                 top: 8,
//                                               ),
//                                               padding: const EdgeInsets.all(8),
//                                               alignment: Alignment.center,
//                                               height: size.height * 0.05,
//                                               // width: size.width * 0.99,
//                                               decoration: BoxDecoration(
//                                                   // shape: BoxShape.circle,
//                                                   borderRadius:
//                                                       BorderRadius.circular(10),
//                                                   boxShadow: const [
//                                                     BoxShadow(
//                                                         color: Color.fromARGB(255, 7, 59, 120),
//                                                         blurRadius: 10,
//                                                         offset:
//                                                             Offset(2.0, 5.0))
//                                                   ],
//                                                   gradient:
//                                                       const LinearGradient(
//                                                     colors: [
//                                                       Colors.white,
//                                                       Colors.white,
//                                                     ],
//                                                   )),

//                                               child: Align(
//                                                 alignment:
//                                                     Alignment.centerRight,
//                                                 child: Padding(
//                                                   padding:
//                                                       const EdgeInsets.all(2.0),
//                                                   child: TextFormField(
//                                                     //key: formkey4,
//                                                     controller:
//                                                         _hoursSaturdayEmployee,
//                                                     style: const TextStyle(
//                                                         color: Color.fromARGB(255, 7, 59, 120),
//                                                         fontSize: 16),
//                                                     obscureText: false,
//                                                     // keyboardType: TextInputType.number,
//                                                     // decoration: InputDecoration(
//                                                     //   border: OutlineInputBorder(
//                                                     //     borderRadius: BorderRadius.circular(25),
//                                                     //   ),
//                                                     //   enabledBorder: OutlineInputBorder(
//                                                     //     borderSide: const BorderSide(
//                                                     //       color: Color.fromARGB(255, 7, 59, 120),
//                                                     //     ),
//                                                     //     borderRadius: BorderRadius.circular(25),
//                                                     //   ),
//                                                     //   hintText: 'Enter Amount',
//                                                     // ),
//                                                     validator: (value) {
//                                                       if (value!.isEmpty) {
//                                                         return "Please enter hours";
//                                                       } else {
//                                                         return null;
//                                                       }
//                                                     },
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                       Row(
//                                         children: [
//                                           Expanded(
//                                             child: Align(
//                                                 alignment: Alignment.centerLeft,
//                                                 child: Padding(
//                                                   padding:
//                                                       const EdgeInsets.only(
//                                                     left: 2.0,
//                                                     right: 2.0,
//                                                   ),
//                                                   child: Container(
//                                                     margin:
//                                                         const EdgeInsets.only(
//                                                       left: 8,
//                                                       right: 8,
//                                                       top: 8,
//                                                     ),
//                                                     padding:
//                                                         const EdgeInsets.all(8),
//                                                     alignment: Alignment.center,
//                                                     // height: size.height * 0.5,
//                                                     // width: size.width * 0.99,
//                                                     decoration: BoxDecoration(
//                                                         // shape: BoxShape.circle,
//                                                         borderRadius:
//                                                             BorderRadius
//                                                                 .circular(10),
//                                                         boxShadow: const [
//                                                           BoxShadow(
//                                                               color:
//                                                                   Color.fromARGB(255, 7, 59, 120),
//                                                               blurRadius: 10,
//                                                               offset: Offset(
//                                                                   2.0, 5.0))
//                                                         ],
//                                                         gradient:
//                                                             const LinearGradient(
//                                                           colors: [
//                                                             Color.fromARGB(255,
//                                                                 2, 92, 249),
//                                                             Color.fromARGB(255,
//                                                                 16, 1, 135),
//                                                           ],
//                                                         )),

//                                                     child: const Text(
//                                                       "Total Hours",
//                                                       style: TextStyle(
//                                                         fontSize: 16.0,
//                                                         color: Colors.white,
//                                                         //fontWeight: FontWeight.bold
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 )),
//                                           ),
//                                           Expanded(
//                                             child: Container(
//                                               margin: const EdgeInsets.only(
//                                                 left: 8,
//                                                 right: 8,
//                                                 top: 8,
//                                               ),
//                                               padding: const EdgeInsets.all(8),
//                                               alignment: Alignment.center,
//                                               height: size.height * 0.05,
//                                               // width: size.width * 0.99,
//                                               decoration: BoxDecoration(
//                                                   // shape: BoxShape.circle,
//                                                   borderRadius:
//                                                       BorderRadius.circular(10),
//                                                   boxShadow: const [
//                                                     BoxShadow(
//                                                         color: Color.fromARGB(255, 7, 59, 120),
//                                                         blurRadius: 10,
//                                                         offset:
//                                                             Offset(2.0, 5.0))
//                                                   ],
//                                                   gradient:
//                                                       const LinearGradient(
//                                                     colors: [
//                                                       Colors.white,
//                                                       Colors.white,
//                                                     ],
//                                                   )),

//                                               child: Align(
//                                                 alignment:
//                                                     Alignment.centerRight,
//                                                 child: Padding(
//                                                   padding:
//                                                       const EdgeInsets.all(2.0),
//                                                   child: TextFormField(
//                                                     //key: formkey4,
//                                                     controller:
//                                                         _hoursTotalEmployee,
//                                                     style: const TextStyle(
//                                                         color: Color.fromARGB(255, 7, 59, 120),
//                                                         fontSize: 16),
//                                                     obscureText: false,
//                                                     // keyboardType: TextInputType.number,
//                                                     // decoration: InputDecoration(
//                                                     //   border: OutlineInputBorder(
//                                                     //     borderRadius: BorderRadius.circular(25),
//                                                     //   ),
//                                                     //   enabledBorder: OutlineInputBorder(
//                                                     //     borderSide: const BorderSide(
//                                                     //       color: Color.fromARGB(255, 7, 59, 120),
//                                                     //     ),
//                                                     //     borderRadius: BorderRadius.circular(25),
//                                                     //   ),
//                                                     //   hintText: 'Enter Amount',
//                                                     // ),
//                                                     validator: (value) {
//                                                       if (value!.isEmpty) {
//                                                         return "Please enter hours";
//                                                       } else {
//                                                         return null;
//                                                       }
//                                                     },
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                 );
//                               },
//                             ),
//                           ],
//                         ),
//                       ],
//                     )),
//                 Container(
//                     margin: const EdgeInsets.only(
//                         left: 8, right: 8, top: 10, bottom: 8),
//                     padding: const EdgeInsets.all(8),
//                     alignment: Alignment.center,
//                     // height: size.height * 0.5,
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
//                           // height: 40,
//                           decoration: const BoxDecoration(
//                               // shape: BoxShape.circle,
//                               //borderRadius: BorderRadius.circular(25),
//                               boxShadow: [
//                                 BoxShadow(
//                                      color: Color.fromARGB(
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
//                           child: const Row(children: [
//                             Align(
//                               alignment: Alignment.centerLeft,
//                               child: Text(
//                                 "Equipment",
//                                 textAlign: TextAlign.left,
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 20,
//                                 ),
//                               ),
//                             ),
//                           ]),
//                         ),
//                         Column(
//                           children: [
//                             Align(
//                               alignment: Alignment.centerLeft,
//                               child: Padding(
//                                 padding: const EdgeInsets.only(top: 10.0),
//                                 child: DropdownButtonFormField<String>(
//                                   hint:
//                                       const Text('Select Number Of Equipment'),
//                                   dropdownColor:
//                                       Colors.white,
//                                   value: numberOfEquipment,
//                                   style: const TextStyle(
//                                       color: Color.fromARGB(255, 7, 59, 120), fontSize: 16),
//                                   icon: const Icon(
//                                     Icons.arrow_drop_down,
//                                     color: Color.fromARGB(255, 7, 59, 120),
//                                     size: 40,
//                                   ),
//                                   decoration: InputDecoration(
//                                     enabledBorder: OutlineInputBorder(
//                                       borderSide: const BorderSide(
//                                         color: Color.fromARGB(255, 7, 59, 120),
//                                       ),
//                                       borderRadius: BorderRadius.circular(25),
//                                     ),
//                                     focusedBorder: OutlineInputBorder(
//                                       borderSide: const BorderSide(
//                                         color: Color.fromARGB(255, 7, 59, 120),
//                                       ),
//                                       borderRadius: BorderRadius.circular(25),
//                                     ),
//                                   ),
//                                   isExpanded: true,
//                                   items: select_numberOfEquipment
//                                       .map(buildMenuItem)
//                                       .toList(),
//                                   onChanged: (value) {
//                                     numberOfEquipment = value;
//                                     setState(() {
//                                       getNumberOfEquipmentLength();
//                                     });
//                                   },
//                                   // onChanged: (value) => setState(
//                                   //     () => this.numberOfEquipmnet = value),
//                                   validator: (value) =>
//                                       value == null ? 'field required' : null,
//                                 ),
//                               ),
//                             ),
//                             ListView.builder(
//                               shrinkWrap: true,
//                               itemCount: numberOfEquipmentLength,
//                               // itemCount:  getDaysInBetween().attractions.length,
//                               // itemCount: numberOfDays.length,
//                               physics: const NeverScrollableScrollPhysics(),
//                               itemBuilder: (BuildContext context, int index) {
//                                 return Container(
//                                   margin: const EdgeInsets.only(
//                                       left: 4, right: 4, top: 10, bottom: 8),
//                                   padding: const EdgeInsets.all(8),
//                                   alignment: Alignment.center,
//                                   // height: size.height * 0.5,
//                                   width: size.width * 0.99,
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
//                                           Color.fromARGB(255, 255, 255, 255),
//                                           Color.fromARGB(255, 255, 255, 255),
//                                         ],
//                                       )),
//                                   child: Column(
//                                     children: [
//                                       Row(
//                                         children: [
//                                           Expanded(
//                                             child: Container(
//                                               margin: const EdgeInsets.only(
//                                                 left: 8,
//                                                 right: 8,
//                                                 top: 8,
//                                               ),
//                                               padding: const EdgeInsets.all(8),
//                                               alignment: Alignment.center,
//                                               height: size.height * 0.05,
//                                               // width: size.width * 0.99,
//                                               decoration: BoxDecoration(
//                                                   // shape: BoxShape.circle,
//                                                   borderRadius:
//                                                       BorderRadius.circular(10),
//                                                   boxShadow: const [
//                                                     BoxShadow(
//                                                         color: Color.fromARGB(255, 7, 59, 120),
//                                                         blurRadius: 10,
//                                                         offset:
//                                                             Offset(2.0, 5.0))
//                                                   ],
//                                                   gradient:
//                                                       const LinearGradient(
//                                                     colors: [
//                                                       Colors.white,
//                                                       Colors.white,
//                                                     ],
//                                                   )),

//                                               child: Align(
//                                                 alignment:
//                                                     Alignment.centerRight,
//                                                 child: Padding(
//                                                   padding:
//                                                       const EdgeInsets.all(4.0),
//                                                   child: TextFormField(
//                                                     //key: formkey4,
//                                                     controller: _equipmentType,
//                                                     style: const TextStyle(
//                                                         color: Color.fromARGB(255, 7, 59, 120),
//                                                         fontSize: 16),
//                                                     obscureText: false,
//                                                     keyboardType:
//                                                         TextInputType.number,
//                                                     decoration:
//                                                         const InputDecoration(
//                                                       // border: OutlineInputBorder(
//                                                       //   borderRadius: BorderRadius.circular(25),
//                                                       // ),
//                                                       // enabledBorder: OutlineInputBorder(
//                                                       //   borderSide: const BorderSide(
//                                                       //     color: Color.fromARGB(255, 7, 59, 120),
//                                                       //   ),
//                                                       //   borderRadius: BorderRadius.circular(25),
//                                                       // ),
//                                                       hintText:
//                                                           'Equipment Type',
//                                                     ),
//                                                     validator: (value) {
//                                                       if (value!.isEmpty) {
//                                                         return "Please enter equipment type";
//                                                       } else {
//                                                         return null;
//                                                       }
//                                                     },
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                           IconButton(
//                                               icon: const Icon(Icons.delete),
//                                               iconSize: 30,
//                                               color: const Color.fromARGB(255, 7, 59, 120),
//                                               onPressed: () {
//                                                 // setState(() {
//                                                 //   numberOfDays.removeAt(index);
//                                                 // });
//                                               }),
//                                         ],
//                                       ),
//                                       Row(
//                                         children: [
//                                           Expanded(
//                                             child: Align(
//                                                 alignment: Alignment.centerLeft,
//                                                 child: Padding(
//                                                   padding:
//                                                       const EdgeInsets.only(
//                                                     left: 2.0,
//                                                     right: 2.0,
//                                                   ),
//                                                   child: Container(
//                                                     margin:
//                                                         const EdgeInsets.only(
//                                                       left: 8,
//                                                       right: 8,
//                                                       top: 8,
//                                                     ),
//                                                     padding:
//                                                         const EdgeInsets.all(8),
//                                                     alignment: Alignment.center,
//                                                     // height: size.height * 0.5,
//                                                     // width: size.width * 0.99,
//                                                     decoration: BoxDecoration(
//                                                         // shape: BoxShape.circle,
//                                                         borderRadius:
//                                                             BorderRadius
//                                                                 .circular(10),
//                                                         boxShadow: const [
//                                                           BoxShadow(
//                                                               color:
//                                                                   Color.fromARGB(255, 7, 59, 120),
//                                                               blurRadius: 10,
//                                                               offset: Offset(
//                                                                   2.0, 5.0))
//                                                         ],
//                                                         gradient:
//                                                             const LinearGradient(
//                                                           colors: [
//                                                             Color.fromARGB(255,
//                                                                 2, 92, 249),
//                                                             Color.fromARGB(255,
//                                                                 16, 1, 135),
//                                                           ],
//                                                         )),

//                                                     child: const Text(
//                                                       "Equipment Code",
//                                                       style: TextStyle(
//                                                         fontSize: 16.0,
//                                                         color: Colors.white,
//                                                         //fontWeight: FontWeight.bold
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 )),
//                                           ),
//                                           Expanded(
//                                             child: Container(
//                                               margin: const EdgeInsets.only(
//                                                 left: 8,
//                                                 right: 8,
//                                                 top: 8,
//                                               ),
//                                               padding: const EdgeInsets.all(8),
//                                               alignment: Alignment.center,
//                                               height: size.height * 0.05,
//                                               // width: size.width * 0.99,
//                                               decoration: BoxDecoration(
//                                                   // shape: BoxShape.circle,
//                                                   borderRadius:
//                                                       BorderRadius.circular(10),
//                                                   boxShadow: const [
//                                                     BoxShadow(
//                                                         color: Color.fromARGB(255, 7, 59, 120),
//                                                         blurRadius: 10,
//                                                         offset:
//                                                             Offset(2.0, 5.0))
//                                                   ],
//                                                   gradient:
//                                                       const LinearGradient(
//                                                     colors: [
//                                                       Colors.white,
//                                                       Colors.white,
//                                                     ],
//                                                   )),

//                                               child: Align(
//                                                 alignment:
//                                                     Alignment.centerRight,
//                                                 child: Padding(
//                                                   padding:
//                                                       const EdgeInsets.all(2.0),
//                                                   child: TextFormField(
//                                                     //key: formkey4,
//                                                     controller: _equipmentCode,
//                                                     style: const TextStyle(
//                                                         color: Color.fromARGB(255, 7, 59, 120),
//                                                         fontSize: 16),
//                                                     obscureText: false,
//                                                     keyboardType:
//                                                         TextInputType.number,
//                                                     // decoration: InputDecoration(
//                                                     //   border: OutlineInputBorder(
//                                                     //     borderRadius: BorderRadius.circular(25),
//                                                     //   ),
//                                                     //   enabledBorder: OutlineInputBorder(
//                                                     //     borderSide: const BorderSide(
//                                                     //       color: Color.fromARGB(255, 7, 59, 120),
//                                                     //     ),
//                                                     //     borderRadius: BorderRadius.circular(25),
//                                                     //   ),
//                                                     //   hintText: 'Enter Amount',
//                                                     // ),
//                                                     validator: (value) {
//                                                       if (value!.isEmpty) {
//                                                         return "Please enter equipment code";
//                                                       } else {
//                                                         return null;
//                                                       }
//                                                     },
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                       Row(
//                                         children: [
//                                           Expanded(
//                                             child: Align(
//                                                 alignment: Alignment.centerLeft,
//                                                 child: Padding(
//                                                   padding:
//                                                       const EdgeInsets.only(
//                                                     left: 2.0,
//                                                     right: 2.0,
//                                                   ),
//                                                   child: Container(
//                                                     margin:
//                                                         const EdgeInsets.only(
//                                                       left: 8,
//                                                       right: 8,
//                                                       top: 8,
//                                                     ),
//                                                     padding:
//                                                         const EdgeInsets.all(8),
//                                                     alignment: Alignment.center,
//                                                     // height: size.height * 0.5,
//                                                     // width: size.width * 0.99,
//                                                     decoration: BoxDecoration(
//                                                         // shape: BoxShape.circle,
//                                                         borderRadius:
//                                                             BorderRadius
//                                                                 .circular(10),
//                                                         boxShadow: const [
//                                                           BoxShadow(
//                                                               color:
//                                                                   Color.fromARGB(255, 7, 59, 120),
//                                                               blurRadius: 10,
//                                                               offset: Offset(
//                                                                   2.0, 5.0))
//                                                         ],
//                                                         gradient:
//                                                             const LinearGradient(
//                                                           colors: [
//                                                             Color.fromARGB(255,
//                                                                 2, 92, 249),
//                                                             Color.fromARGB(255,
//                                                                 16, 1, 135),
//                                                           ],
//                                                         )),

//                                                     child: const Text(
//                                                       "Other Crew",
//                                                       style: TextStyle(
//                                                         fontSize: 16.0,
//                                                         color: Colors.white,
//                                                         //fontWeight: FontWeight.bold
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 )),
//                                           ),
//                                           Expanded(
//                                             child: Container(
//                                               margin: const EdgeInsets.only(
//                                                 left: 8,
//                                                 right: 8,
//                                                 top: 8,
//                                               ),
//                                               padding: const EdgeInsets.all(8),
//                                               alignment: Alignment.center,
//                                               height: size.height * 0.05,
//                                               // width: size.width * 0.99,
//                                               decoration: BoxDecoration(
//                                                   // shape: BoxShape.circle,
//                                                   borderRadius:
//                                                       BorderRadius.circular(10),
//                                                   boxShadow: const [
//                                                     BoxShadow(
//                                                         color: Color.fromARGB(255, 7, 59, 120),
//                                                         blurRadius: 10,
//                                                         offset:
//                                                             Offset(2.0, 5.0))
//                                                   ],
//                                                   gradient:
//                                                       const LinearGradient(
//                                                     colors: [
//                                                       Colors.white,
//                                                       Colors.white,
//                                                     ],
//                                                   )),

//                                               child: Align(
//                                                 alignment:
//                                                     Alignment.centerRight,
//                                                 child: Padding(
//                                                   padding:
//                                                       const EdgeInsets.all(2.0),
//                                                   child: TextFormField(
//                                                     //key: formkey4,
//                                                     controller:
//                                                         _otherCrewEquipment,
//                                                     style: const TextStyle(
//                                                         color: Color.fromARGB(255, 7, 59, 120),
//                                                         fontSize: 16),
//                                                     obscureText: false,
//                                                     // keyboardType: TextInputType.number,
//                                                     // decoration: InputDecoration(
//                                                     //   border: OutlineInputBorder(
//                                                     //     borderRadius: BorderRadius.circular(25),
//                                                     //   ),
//                                                     //   enabledBorder: OutlineInputBorder(
//                                                     //     borderSide: const BorderSide(
//                                                     //       color: Color.fromARGB(255, 7, 59, 120),
//                                                     //     ),
//                                                     //     borderRadius: BorderRadius.circular(25),
//                                                     //   ),
//                                                     //   hintText: 'Enter Amount',
//                                                     // ),
//                                                     validator: (value) {
//                                                       if (value!.isEmpty) {
//                                                         return "Please enter other crew";
//                                                       } else {
//                                                         return null;
//                                                       }
//                                                     },
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                       Row(
//                                         children: [
//                                           Expanded(
//                                             child: Align(
//                                                 alignment: Alignment.centerLeft,
//                                                 child: Padding(
//                                                   padding:
//                                                       const EdgeInsets.only(
//                                                     left: 2.0,
//                                                     right: 2.0,
//                                                   ),
//                                                   child: Container(
//                                                     margin:
//                                                         const EdgeInsets.only(
//                                                       left: 8,
//                                                       right: 8,
//                                                       top: 8,
//                                                     ),
//                                                     padding:
//                                                         const EdgeInsets.all(8),
//                                                     alignment: Alignment.center,
//                                                     // height: size.height * 0.5,
//                                                     // width: size.width * 0.99,
//                                                     decoration: BoxDecoration(
//                                                         // shape: BoxShape.circle,
//                                                         borderRadius:
//                                                             BorderRadius
//                                                                 .circular(10),
//                                                         boxShadow: const [
//                                                           BoxShadow(
//                                                               color:
//                                                                   Color.fromARGB(255, 7, 59, 120),
//                                                               blurRadius: 10,
//                                                               offset: Offset(
//                                                                   2.0, 5.0))
//                                                         ],
//                                                         gradient:
//                                                             const LinearGradient(
//                                                           colors: [
//                                                             Color.fromARGB(255,
//                                                                 2, 92, 249),
//                                                             Color.fromARGB(255,
//                                                                 16, 1, 135),
//                                                           ],
//                                                         )),

//                                                     child: const Text(
//                                                       "Class Code",
//                                                       style: TextStyle(
//                                                         fontSize: 16.0,
//                                                         color: Colors.white,
//                                                         //fontWeight: FontWeight.bold
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 )),
//                                           ),
//                                           Expanded(
//                                             child: Container(
//                                               margin: const EdgeInsets.only(
//                                                 left: 8,
//                                                 right: 8,
//                                                 top: 8,
//                                               ),
//                                               padding: const EdgeInsets.all(8),
//                                               alignment: Alignment.center,
//                                               height: size.height * 0.05,
//                                               // width: size.width * 0.99,
//                                               decoration: BoxDecoration(
//                                                   // shape: BoxShape.circle,
//                                                   borderRadius:
//                                                       BorderRadius.circular(10),
//                                                   boxShadow: const [
//                                                     BoxShadow(
//                                                         color: Color.fromARGB(255, 7, 59, 120),
//                                                         blurRadius: 10,
//                                                         offset:
//                                                             Offset(2.0, 5.0))
//                                                   ],
//                                                   gradient:
//                                                       const LinearGradient(
//                                                     colors: [
//                                                       Colors.white,
//                                                       Colors.white,
//                                                     ],
//                                                   )),

//                                               child: Align(
//                                                 alignment:
//                                                     Alignment.centerRight,
//                                                 child: Padding(
//                                                   padding:
//                                                       const EdgeInsets.all(2.0),
//                                                   child: TextFormField(
//                                                     //key: formkey4,
//                                                     controller:
//                                                         _classCodeEquipment,
//                                                     style: const TextStyle(
//                                                         color: Color.fromARGB(255, 7, 59, 120),
//                                                         fontSize: 16),
//                                                     obscureText: false,
//                                                     // keyboardType: TextInputType.number,
//                                                     // decoration: InputDecoration(
//                                                     //   border: OutlineInputBorder(
//                                                     //     borderRadius: BorderRadius.circular(25),
//                                                     //   ),
//                                                     //   enabledBorder: OutlineInputBorder(
//                                                     //     borderSide: const BorderSide(
//                                                     //       color: Color.fromARGB(255, 7, 59, 120),
//                                                     //     ),
//                                                     //     borderRadius: BorderRadius.circular(25),
//                                                     //   ),
//                                                     //   hintText: 'Enter Amount',
//                                                     // ),
//                                                     validator: (value) {
//                                                       if (value!.isEmpty) {
//                                                         return "Please enter class code";
//                                                       } else {
//                                                         return null;
//                                                       }
//                                                     },
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                       Row(
//                                         children: [
//                                           Expanded(
//                                             child: Align(
//                                                 alignment: Alignment.centerLeft,
//                                                 child: Padding(
//                                                   padding:
//                                                       const EdgeInsets.only(
//                                                     left: 2.0,
//                                                     right: 2.0,
//                                                   ),
//                                                   child: Container(
//                                                     margin:
//                                                         const EdgeInsets.only(
//                                                       left: 8,
//                                                       right: 8,
//                                                       top: 8,
//                                                     ),
//                                                     padding:
//                                                         const EdgeInsets.all(8),
//                                                     alignment: Alignment.center,
//                                                     // height: size.height * 0.5,
//                                                     // width: size.width * 0.99,
//                                                     decoration: BoxDecoration(
//                                                         // shape: BoxShape.circle,
//                                                         borderRadius:
//                                                             BorderRadius
//                                                                 .circular(10),
//                                                         boxShadow: const [
//                                                           BoxShadow(
//                                                               color:
//                                                                   Color.fromARGB(255, 7, 59, 120),
//                                                               blurRadius: 10,
//                                                               offset: Offset(
//                                                                   2.0, 5.0))
//                                                         ],
//                                                         gradient:
//                                                             const LinearGradient(
//                                                           colors: [
//                                                             Color.fromARGB(255,
//                                                                 2, 92, 249),
//                                                             Color.fromARGB(255,
//                                                                 16, 1, 135),
//                                                           ],
//                                                         )),

//                                                     child: const Text(
//                                                       "Days",
//                                                       style: TextStyle(
//                                                         fontSize: 16.0,
//                                                         color: Colors.white,
//                                                         //fontWeight: FontWeight.bold
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 )),
//                                           ),
//                                           Expanded(
//                                             child: Align(
//                                                 alignment: Alignment.centerLeft,
//                                                 child: Padding(
//                                                   padding:
//                                                       const EdgeInsets.only(
//                                                     left: 2.0,
//                                                     right: 2.0,
//                                                   ),
//                                                   child: Container(
//                                                     margin:
//                                                         const EdgeInsets.only(
//                                                       left: 8,
//                                                       right: 8,
//                                                       top: 8,
//                                                     ),
//                                                     padding:
//                                                         const EdgeInsets.all(8),
//                                                     alignment: Alignment.center,
//                                                     // height: size.height * 0.5,
//                                                     // width: size.width * 0.99,
//                                                     decoration: BoxDecoration(
//                                                         // shape: BoxShape.circle,
//                                                         borderRadius:
//                                                             BorderRadius
//                                                                 .circular(10),
//                                                         boxShadow: const [
//                                                           BoxShadow(
//                                                               color:
//                                                                   Color.fromARGB(255, 7, 59, 120),
//                                                               blurRadius: 10,
//                                                               offset: Offset(
//                                                                   2.0, 5.0))
//                                                         ],
//                                                         gradient:
//                                                             const LinearGradient(
//                                                           colors: [
//                                                             Color.fromARGB(255,
//                                                                 2, 92, 249),
//                                                             Color.fromARGB(255,
//                                                                 16, 1, 135),
//                                                           ],
//                                                         )),

//                                                     child: const Text(
//                                                       "Hours",
//                                                       style: TextStyle(
//                                                         fontSize: 16.0,
//                                                         color: Colors.white,
//                                                         //fontWeight: FontWeight.bold
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 )),
//                                           ),
//                                         ],
//                                       ),
//                                       Row(
//                                         children: [
//                                           Expanded(
//                                             child: Align(
//                                                 alignment: Alignment.centerLeft,
//                                                 child: Padding(
//                                                   padding:
//                                                       const EdgeInsets.only(
//                                                     left: 2.0,
//                                                     right: 2.0,
//                                                   ),
//                                                   child: Container(
//                                                     margin:
//                                                         const EdgeInsets.only(
//                                                       left: 8,
//                                                       right: 8,
//                                                       top: 8,
//                                                     ),
//                                                     padding:
//                                                         const EdgeInsets.all(8),
//                                                     alignment: Alignment.center,
//                                                     // height: size.height * 0.5,
//                                                     // width: size.width * 0.99,
//                                                     decoration: BoxDecoration(
//                                                         // shape: BoxShape.circle,
//                                                         borderRadius:
//                                                             BorderRadius
//                                                                 .circular(10),
//                                                         boxShadow: const [
//                                                           BoxShadow(
//                                                               color:
//                                                                   Color.fromARGB(255, 7, 59, 120),
//                                                               blurRadius: 10,
//                                                               offset: Offset(
//                                                                   2.0, 5.0))
//                                                         ],
//                                                         gradient:
//                                                             const LinearGradient(
//                                                           colors: [
//                                                             Color.fromARGB(255,
//                                                                 2, 92, 249),
//                                                             Color.fromARGB(255,
//                                                                 16, 1, 135),
//                                                           ],
//                                                         )),

//                                                     child: const Text(
//                                                       "Sunday",
//                                                       style: TextStyle(
//                                                         fontSize: 16.0,
//                                                         color: Colors.white,
//                                                         //fontWeight: FontWeight.bold
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 )),
//                                           ),
//                                           Expanded(
//                                             child: Container(
//                                               margin: const EdgeInsets.only(
//                                                 left: 8,
//                                                 right: 8,
//                                                 top: 8,
//                                               ),
//                                               padding: const EdgeInsets.all(8),
//                                               alignment: Alignment.center,
//                                               height: size.height * 0.05,
//                                               // width: size.width * 0.99,
//                                               decoration: BoxDecoration(
//                                                   // shape: BoxShape.circle,
//                                                   borderRadius:
//                                                       BorderRadius.circular(10),
//                                                   boxShadow: const [
//                                                     BoxShadow(
//                                                         color: Color.fromARGB(255, 7, 59, 120),
//                                                         blurRadius: 10,
//                                                         offset:
//                                                             Offset(2.0, 5.0))
//                                                   ],
//                                                   gradient:
//                                                       const LinearGradient(
//                                                     colors: [
//                                                       Colors.white,
//                                                       Colors.white,
//                                                     ],
//                                                   )),

//                                               child: Align(
//                                                 alignment:
//                                                     Alignment.centerRight,
//                                                 child: Padding(
//                                                   padding:
//                                                       const EdgeInsets.all(2.0),
//                                                   child: TextFormField(
//                                                     //key: formkey4,
//                                                     controller:
//                                                         _hoursSundayEquipment,
//                                                     style: const TextStyle(
//                                                         color: Color.fromARGB(255, 7, 59, 120),
//                                                         fontSize: 16),
//                                                     obscureText: false,
//                                                     // keyboardType: TextInputType.number,
//                                                     // decoration: InputDecoration(
//                                                     //   border: OutlineInputBorder(
//                                                     //     borderRadius: BorderRadius.circular(25),
//                                                     //   ),
//                                                     //   enabledBorder: OutlineInputBorder(
//                                                     //     borderSide: const BorderSide(
//                                                     //       color: Color.fromARGB(255, 7, 59, 120),
//                                                     //     ),
//                                                     //     borderRadius: BorderRadius.circular(25),
//                                                     //   ),
//                                                     //   hintText: 'Enter Amount',
//                                                     // ),
//                                                     validator: (value) {
//                                                       if (value!.isEmpty) {
//                                                         return "Please enter hours";
//                                                       } else {
//                                                         return null;
//                                                       }
//                                                     },
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                       Row(
//                                         children: [
//                                           Expanded(
//                                             child: Align(
//                                                 alignment: Alignment.centerLeft,
//                                                 child: Padding(
//                                                   padding:
//                                                       const EdgeInsets.only(
//                                                     left: 2.0,
//                                                     right: 2.0,
//                                                   ),
//                                                   child: Container(
//                                                     margin:
//                                                         const EdgeInsets.only(
//                                                       left: 8,
//                                                       right: 8,
//                                                       top: 8,
//                                                     ),
//                                                     padding:
//                                                         const EdgeInsets.all(8),
//                                                     alignment: Alignment.center,
//                                                     // height: size.height * 0.5,
//                                                     // width: size.width * 0.99,
//                                                     decoration: BoxDecoration(
//                                                         // shape: BoxShape.circle,
//                                                         borderRadius:
//                                                             BorderRadius
//                                                                 .circular(10),
//                                                         boxShadow: const [
//                                                           BoxShadow(
//                                                               color:
//                                                                   Color.fromARGB(255, 7, 59, 120),
//                                                               blurRadius: 10,
//                                                               offset: Offset(
//                                                                   2.0, 5.0))
//                                                         ],
//                                                         gradient:
//                                                             const LinearGradient(
//                                                           colors: [
//                                                             Color.fromARGB(255,
//                                                                 2, 92, 249),
//                                                             Color.fromARGB(255,
//                                                                 16, 1, 135),
//                                                           ],
//                                                         )),

//                                                     child: const Text(
//                                                       "Monday",
//                                                       style: TextStyle(
//                                                         fontSize: 16.0,
//                                                         color: Colors.white,
//                                                         //fontWeight: FontWeight.bold
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 )),
//                                           ),
//                                           Expanded(
//                                             child: Container(
//                                               margin: const EdgeInsets.only(
//                                                 left: 8,
//                                                 right: 8,
//                                                 top: 8,
//                                               ),
//                                               padding: const EdgeInsets.all(8),
//                                               alignment: Alignment.center,
//                                               height: size.height * 0.05,
//                                               // width: size.width * 0.99,
//                                               decoration: BoxDecoration(
//                                                   // shape: BoxShape.circle,
//                                                   borderRadius:
//                                                       BorderRadius.circular(10),
//                                                   boxShadow: const [
//                                                     BoxShadow(
//                                                         color: Color.fromARGB(255, 7, 59, 120),
//                                                         blurRadius: 10,
//                                                         offset:
//                                                             Offset(2.0, 5.0))
//                                                   ],
//                                                   gradient:
//                                                       const LinearGradient(
//                                                     colors: [
//                                                       Colors.white,
//                                                       Colors.white,
//                                                     ],
//                                                   )),

//                                               child: Align(
//                                                 alignment:
//                                                     Alignment.centerRight,
//                                                 child: Padding(
//                                                   padding:
//                                                       const EdgeInsets.all(2.0),
//                                                   child: TextFormField(
//                                                     //key: formkey4,
//                                                     controller:
//                                                         _hoursMondayEquipment,
//                                                     style: const TextStyle(
//                                                         color: Color.fromARGB(255, 7, 59, 120),
//                                                         fontSize: 16),
//                                                     obscureText: false,
//                                                     // keyboardType: TextInputType.number,
//                                                     // decoration: InputDecoration(
//                                                     //   border: OutlineInputBorder(
//                                                     //     borderRadius: BorderRadius.circular(25),
//                                                     //   ),
//                                                     //   enabledBorder: OutlineInputBorder(
//                                                     //     borderSide: const BorderSide(
//                                                     //       color: Color.fromARGB(255, 7, 59, 120),
//                                                     //     ),
//                                                     //     borderRadius: BorderRadius.circular(25),
//                                                     //   ),
//                                                     //   hintText: 'Enter Amount',
//                                                     // ),
//                                                     validator: (value) {
//                                                       if (value!.isEmpty) {
//                                                         return "Please enter hours";
//                                                       } else {
//                                                         return null;
//                                                       }
//                                                     },
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                       Row(
//                                         children: [
//                                           Expanded(
//                                             child: Align(
//                                                 alignment: Alignment.centerLeft,
//                                                 child: Padding(
//                                                   padding:
//                                                       const EdgeInsets.only(
//                                                     left: 2.0,
//                                                     right: 2.0,
//                                                   ),
//                                                   child: Container(
//                                                     margin:
//                                                         const EdgeInsets.only(
//                                                       left: 8,
//                                                       right: 8,
//                                                       top: 8,
//                                                     ),
//                                                     padding:
//                                                         const EdgeInsets.all(8),
//                                                     alignment: Alignment.center,
//                                                     // height: size.height * 0.5,
//                                                     // width: size.width * 0.99,
//                                                     decoration: BoxDecoration(
//                                                         // shape: BoxShape.circle,
//                                                         borderRadius:
//                                                             BorderRadius
//                                                                 .circular(10),
//                                                         boxShadow: const [
//                                                           BoxShadow(
//                                                               color:
//                                                                   Color.fromARGB(255, 7, 59, 120),
//                                                               blurRadius: 10,
//                                                               offset: Offset(
//                                                                   2.0, 5.0))
//                                                         ],
//                                                         gradient:
//                                                             const LinearGradient(
//                                                           colors: [
//                                                             Color.fromARGB(255,
//                                                                 2, 92, 249),
//                                                             Color.fromARGB(255,
//                                                                 16, 1, 135),
//                                                           ],
//                                                         )),

//                                                     child: const Text(
//                                                       "Tuesday",
//                                                       style: TextStyle(
//                                                         fontSize: 16.0,
//                                                         color: Colors.white,
//                                                         //fontWeight: FontWeight.bold
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 )),
//                                           ),
//                                           Expanded(
//                                             child: Container(
//                                               margin: const EdgeInsets.only(
//                                                 left: 8,
//                                                 right: 8,
//                                                 top: 8,
//                                               ),
//                                               padding: const EdgeInsets.all(8),
//                                               alignment: Alignment.center,
//                                               height: size.height * 0.05,
//                                               // width: size.width * 0.99,
//                                               decoration: BoxDecoration(
//                                                   // shape: BoxShape.circle,
//                                                   borderRadius:
//                                                       BorderRadius.circular(10),
//                                                   boxShadow: const [
//                                                     BoxShadow(
//                                                         color: Color.fromARGB(255, 7, 59, 120),
//                                                         blurRadius: 10,
//                                                         offset:
//                                                             Offset(2.0, 5.0))
//                                                   ],
//                                                   gradient:
//                                                       const LinearGradient(
//                                                     colors: [
//                                                       Colors.white,
//                                                       Colors.white,
//                                                     ],
//                                                   )),

//                                               child: Align(
//                                                 alignment:
//                                                     Alignment.centerRight,
//                                                 child: Padding(
//                                                   padding:
//                                                       const EdgeInsets.all(2.0),
//                                                   child: TextFormField(
//                                                     //key: formkey4,
//                                                     controller:
//                                                         _hoursTuesdayEquipment,
//                                                     style: const TextStyle(
//                                                         color: Color.fromARGB(255, 7, 59, 120),
//                                                         fontSize: 16),
//                                                     obscureText: false,
//                                                     // keyboardType: TextInputType.number,
//                                                     // decoration: InputDecoration(
//                                                     //   border: OutlineInputBorder(
//                                                     //     borderRadius: BorderRadius.circular(25),
//                                                     //   ),
//                                                     //   enabledBorder: OutlineInputBorder(
//                                                     //     borderSide: const BorderSide(
//                                                     //       color: Color.fromARGB(255, 7, 59, 120),
//                                                     //     ),
//                                                     //     borderRadius: BorderRadius.circular(25),
//                                                     //   ),
//                                                     //   hintText: 'Enter Amount',
//                                                     // ),
//                                                     validator: (value) {
//                                                       if (value!.isEmpty) {
//                                                         return "Please enter hours";
//                                                       } else {
//                                                         return null;
//                                                       }
//                                                     },
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                       Row(
//                                         children: [
//                                           Expanded(
//                                             child: Align(
//                                                 alignment: Alignment.centerLeft,
//                                                 child: Padding(
//                                                   padding:
//                                                       const EdgeInsets.only(
//                                                     left: 2.0,
//                                                     right: 2.0,
//                                                   ),
//                                                   child: Container(
//                                                     margin:
//                                                         const EdgeInsets.only(
//                                                       left: 8,
//                                                       right: 8,
//                                                       top: 8,
//                                                     ),
//                                                     padding:
//                                                         const EdgeInsets.all(8),
//                                                     alignment: Alignment.center,
//                                                     // height: size.height * 0.5,
//                                                     // width: size.width * 0.99,
//                                                     decoration: BoxDecoration(
//                                                         // shape: BoxShape.circle,
//                                                         borderRadius:
//                                                             BorderRadius
//                                                                 .circular(10),
//                                                         boxShadow: const [
//                                                           BoxShadow(
//                                                               color:
//                                                                   Color.fromARGB(255, 7, 59, 120),
//                                                               blurRadius: 10,
//                                                               offset: Offset(
//                                                                   2.0, 5.0))
//                                                         ],
//                                                         gradient:
//                                                             const LinearGradient(
//                                                           colors: [
//                                                             Color.fromARGB(255,
//                                                                 2, 92, 249),
//                                                             Color.fromARGB(255,
//                                                                 16, 1, 135),
//                                                           ],
//                                                         )),

//                                                     child: const Text(
//                                                       "Wednesday",
//                                                       style: TextStyle(
//                                                         fontSize: 16.0,
//                                                         color: Colors.white,
//                                                         //fontWeight: FontWeight.bold
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 )),
//                                           ),
//                                           Expanded(
//                                             child: Container(
//                                               margin: const EdgeInsets.only(
//                                                 left: 8,
//                                                 right: 8,
//                                                 top: 8,
//                                               ),
//                                               padding: const EdgeInsets.all(8),
//                                               alignment: Alignment.center,
//                                               height: size.height * 0.05,
//                                               // width: size.width * 0.99,
//                                               decoration: BoxDecoration(
//                                                   // shape: BoxShape.circle,
//                                                   borderRadius:
//                                                       BorderRadius.circular(10),
//                                                   boxShadow: const [
//                                                     BoxShadow(
//                                                         color: Color.fromARGB(255, 7, 59, 120),
//                                                         blurRadius: 10,
//                                                         offset:
//                                                             Offset(2.0, 5.0))
//                                                   ],
//                                                   gradient:
//                                                       const LinearGradient(
//                                                     colors: [
//                                                       Colors.white,
//                                                       Colors.white,
//                                                     ],
//                                                   )),

//                                               child: Align(
//                                                 alignment:
//                                                     Alignment.centerRight,
//                                                 child: Padding(
//                                                   padding:
//                                                       const EdgeInsets.all(2.0),
//                                                   child: TextFormField(
//                                                     //key: formkey4,
//                                                     controller:
//                                                         _hoursWednesdayEquipment,
//                                                     style: const TextStyle(
//                                                         color: Color.fromARGB(255, 7, 59, 120),
//                                                         fontSize: 16),
//                                                     obscureText: false,
//                                                     // keyboardType: TextInputType.number,
//                                                     // decoration: InputDecoration(
//                                                     //   border: OutlineInputBorder(
//                                                     //     borderRadius: BorderRadius.circular(25),
//                                                     //   ),
//                                                     //   enabledBorder: OutlineInputBorder(
//                                                     //     borderSide: const BorderSide(
//                                                     //       color: Color.fromARGB(255, 7, 59, 120),
//                                                     //     ),
//                                                     //     borderRadius: BorderRadius.circular(25),
//                                                     //   ),
//                                                     //   hintText: 'Enter Amount',
//                                                     // ),
//                                                     validator: (value) {
//                                                       if (value!.isEmpty) {
//                                                         return "Please enter hours";
//                                                       } else {
//                                                         return null;
//                                                       }
//                                                     },
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                       Row(
//                                         children: [
//                                           Expanded(
//                                             child: Align(
//                                                 alignment: Alignment.centerLeft,
//                                                 child: Padding(
//                                                   padding:
//                                                       const EdgeInsets.only(
//                                                     left: 2.0,
//                                                     right: 2.0,
//                                                   ),
//                                                   child: Container(
//                                                     margin:
//                                                         const EdgeInsets.only(
//                                                       left: 8,
//                                                       right: 8,
//                                                       top: 8,
//                                                     ),
//                                                     padding:
//                                                         const EdgeInsets.all(8),
//                                                     alignment: Alignment.center,
//                                                     // height: size.height * 0.5,
//                                                     // width: size.width * 0.99,
//                                                     decoration: BoxDecoration(
//                                                         // shape: BoxShape.circle,
//                                                         borderRadius:
//                                                             BorderRadius
//                                                                 .circular(10),
//                                                         boxShadow: const [
//                                                           BoxShadow(
//                                                               color:
//                                                                   Color.fromARGB(255, 7, 59, 120),
//                                                               blurRadius: 10,
//                                                               offset: Offset(
//                                                                   2.0, 5.0))
//                                                         ],
//                                                         gradient:
//                                                             const LinearGradient(
//                                                           colors: [
//                                                             Color.fromARGB(255,
//                                                                 2, 92, 249),
//                                                             Color.fromARGB(255,
//                                                                 16, 1, 135),
//                                                           ],
//                                                         )),

//                                                     child: const Text(
//                                                       "Thursday",
//                                                       style: TextStyle(
//                                                         fontSize: 16.0,
//                                                         color: Colors.white,
//                                                         //fontWeight: FontWeight.bold
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 )),
//                                           ),
//                                           Expanded(
//                                             child: Container(
//                                               margin: const EdgeInsets.only(
//                                                 left: 8,
//                                                 right: 8,
//                                                 top: 8,
//                                               ),
//                                               padding: const EdgeInsets.all(8),
//                                               alignment: Alignment.center,
//                                               height: size.height * 0.05,
//                                               // width: size.width * 0.99,
//                                               decoration: BoxDecoration(
//                                                   // shape: BoxShape.circle,
//                                                   borderRadius:
//                                                       BorderRadius.circular(10),
//                                                   boxShadow: const [
//                                                     BoxShadow(
//                                                         color: Color.fromARGB(255, 7, 59, 120),
//                                                         blurRadius: 10,
//                                                         offset:
//                                                             Offset(2.0, 5.0))
//                                                   ],
//                                                   gradient:
//                                                       const LinearGradient(
//                                                     colors: [
//                                                       Colors.white,
//                                                       Colors.white,
//                                                     ],
//                                                   )),

//                                               child: Align(
//                                                 alignment:
//                                                     Alignment.centerRight,
//                                                 child: Padding(
//                                                   padding:
//                                                       const EdgeInsets.all(2.0),
//                                                   child: TextFormField(
//                                                     //key: formkey4,
//                                                     controller:
//                                                         _hoursThursdayEquipment,
//                                                     style: const TextStyle(
//                                                         color: Color.fromARGB(255, 7, 59, 120),
//                                                         fontSize: 16),
//                                                     obscureText: false,
//                                                     // keyboardType: TextInputType.number,
//                                                     // decoration: InputDecoration(
//                                                     //   border: OutlineInputBorder(
//                                                     //     borderRadius: BorderRadius.circular(25),
//                                                     //   ),
//                                                     //   enabledBorder: OutlineInputBorder(
//                                                     //     borderSide: const BorderSide(
//                                                     //       color: Color.fromARGB(255, 7, 59, 120),
//                                                     //     ),
//                                                     //     borderRadius: BorderRadius.circular(25),
//                                                     //   ),
//                                                     //   hintText: 'Enter Amount',
//                                                     // ),
//                                                     validator: (value) {
//                                                       if (value!.isEmpty) {
//                                                         return "Please enter hours";
//                                                       } else {
//                                                         return null;
//                                                       }
//                                                     },
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                       Row(
//                                         children: [
//                                           Expanded(
//                                             child: Align(
//                                                 alignment: Alignment.centerLeft,
//                                                 child: Padding(
//                                                   padding:
//                                                       const EdgeInsets.only(
//                                                     left: 2.0,
//                                                     right: 2.0,
//                                                   ),
//                                                   child: Container(
//                                                     margin:
//                                                         const EdgeInsets.only(
//                                                       left: 8,
//                                                       right: 8,
//                                                       top: 8,
//                                                     ),
//                                                     padding:
//                                                         const EdgeInsets.all(8),
//                                                     alignment: Alignment.center,
//                                                     // height: size.height * 0.5,
//                                                     // width: size.width * 0.99,
//                                                     decoration: BoxDecoration(
//                                                         // shape: BoxShape.circle,
//                                                         borderRadius:
//                                                             BorderRadius
//                                                                 .circular(10),
//                                                         boxShadow: const [
//                                                           BoxShadow(
//                                                               color:
//                                                                   Color.fromARGB(255, 7, 59, 120),
//                                                               blurRadius: 10,
//                                                               offset: Offset(
//                                                                   2.0, 5.0))
//                                                         ],
//                                                         gradient:
//                                                             const LinearGradient(
//                                                           colors: [
//                                                             Color.fromARGB(255,
//                                                                 2, 92, 249),
//                                                             Color.fromARGB(255,
//                                                                 16, 1, 135),
//                                                           ],
//                                                         )),

//                                                     child: const Text(
//                                                       "Friday",
//                                                       style: TextStyle(
//                                                         fontSize: 16.0,
//                                                         color: Colors.white,
//                                                         //fontWeight: FontWeight.bold
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 )),
//                                           ),
//                                           Expanded(
//                                             child: Container(
//                                               margin: const EdgeInsets.only(
//                                                 left: 8,
//                                                 right: 8,
//                                                 top: 8,
//                                               ),
//                                               padding: const EdgeInsets.all(8),
//                                               alignment: Alignment.center,
//                                               height: size.height * 0.05,
//                                               // width: size.width * 0.99,
//                                               decoration: BoxDecoration(
//                                                   // shape: BoxShape.circle,
//                                                   borderRadius:
//                                                       BorderRadius.circular(10),
//                                                   boxShadow: const [
//                                                     BoxShadow(
//                                                         color: Color.fromARGB(255, 7, 59, 120),
//                                                         blurRadius: 10,
//                                                         offset:
//                                                             Offset(2.0, 5.0))
//                                                   ],
//                                                   gradient:
//                                                       const LinearGradient(
//                                                     colors: [
//                                                       Colors.white,
//                                                       Colors.white,
//                                                     ],
//                                                   )),

//                                               child: Align(
//                                                 alignment:
//                                                     Alignment.centerRight,
//                                                 child: Padding(
//                                                   padding:
//                                                       const EdgeInsets.all(2.0),
//                                                   child: TextFormField(
//                                                     //key: formkey4,
//                                                     controller:
//                                                         _hoursFridayEquipment,
//                                                     style: const TextStyle(
//                                                         color: Color.fromARGB(255, 7, 59, 120),
//                                                         fontSize: 16),
//                                                     obscureText: false,
//                                                     // keyboardType: TextInputType.number,
//                                                     // decoration: InputDecoration(
//                                                     //   border: OutlineInputBorder(
//                                                     //     borderRadius: BorderRadius.circular(25),
//                                                     //   ),
//                                                     //   enabledBorder: OutlineInputBorder(
//                                                     //     borderSide: const BorderSide(
//                                                     //       color: Color.fromARGB(255, 7, 59, 120),
//                                                     //     ),
//                                                     //     borderRadius: BorderRadius.circular(25),
//                                                     //   ),
//                                                     //   hintText: 'Enter Amount',
//                                                     // ),
//                                                     validator: (value) {
//                                                       if (value!.isEmpty) {
//                                                         return "Please enter hours";
//                                                       } else {
//                                                         return null;
//                                                       }
//                                                     },
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                       Row(
//                                         children: [
//                                           Expanded(
//                                             child: Align(
//                                                 alignment: Alignment.centerLeft,
//                                                 child: Padding(
//                                                   padding:
//                                                       const EdgeInsets.only(
//                                                     left: 2.0,
//                                                     right: 2.0,
//                                                   ),
//                                                   child: Container(
//                                                     margin:
//                                                         const EdgeInsets.only(
//                                                       left: 8,
//                                                       right: 8,
//                                                       top: 8,
//                                                     ),
//                                                     padding:
//                                                         const EdgeInsets.all(8),
//                                                     alignment: Alignment.center,
//                                                     // height: size.height * 0.5,
//                                                     // width: size.width * 0.99,
//                                                     decoration: BoxDecoration(
//                                                         // shape: BoxShape.circle,
//                                                         borderRadius:
//                                                             BorderRadius
//                                                                 .circular(10),
//                                                         boxShadow: const [
//                                                           BoxShadow(
//                                                               color:
//                                                                   Color.fromARGB(255, 7, 59, 120),
//                                                               blurRadius: 10,
//                                                               offset: Offset(
//                                                                   2.0, 5.0))
//                                                         ],
//                                                         gradient:
//                                                             const LinearGradient(
//                                                           colors: [
//                                                             Color.fromARGB(255,
//                                                                 2, 92, 249),
//                                                             Color.fromARGB(255,
//                                                                 16, 1, 135),
//                                                           ],
//                                                         )),

//                                                     child: const Text(
//                                                       "Saturday",
//                                                       style: TextStyle(
//                                                         fontSize: 16.0,
//                                                         color: Colors.white,
//                                                         //fontWeight: FontWeight.bold
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 )),
//                                           ),
//                                           Expanded(
//                                             child: Container(
//                                               margin: const EdgeInsets.only(
//                                                 left: 8,
//                                                 right: 8,
//                                                 top: 8,
//                                               ),
//                                               padding: const EdgeInsets.all(8),
//                                               alignment: Alignment.center,
//                                               height: size.height * 0.05,
//                                               // width: size.width * 0.99,
//                                               decoration: BoxDecoration(
//                                                   // shape: BoxShape.circle,
//                                                   borderRadius:
//                                                       BorderRadius.circular(10),
//                                                   boxShadow: const [
//                                                     BoxShadow(
//                                                         color: Color.fromARGB(255, 7, 59, 120),
//                                                         blurRadius: 10,
//                                                         offset:
//                                                             Offset(2.0, 5.0))
//                                                   ],
//                                                   gradient:
//                                                       const LinearGradient(
//                                                     colors: [
//                                                       Colors.white,
//                                                       Colors.white,
//                                                     ],
//                                                   )),

//                                               child: Align(
//                                                 alignment:
//                                                     Alignment.centerRight,
//                                                 child: Padding(
//                                                   padding:
//                                                       const EdgeInsets.all(2.0),
//                                                   child: TextFormField(
//                                                     //key: formkey4,
//                                                     controller:
//                                                         _hoursSaturdayEquipment,
//                                                     style: const TextStyle(
//                                                         color: Color.fromARGB(255, 7, 59, 120),
//                                                         fontSize: 16),
//                                                     obscureText: false,
//                                                     // keyboardType: TextInputType.number,
//                                                     // decoration: InputDecoration(
//                                                     //   border: OutlineInputBorder(
//                                                     //     borderRadius: BorderRadius.circular(25),
//                                                     //   ),
//                                                     //   enabledBorder: OutlineInputBorder(
//                                                     //     borderSide: const BorderSide(
//                                                     //       color: Color.fromARGB(255, 7, 59, 120),
//                                                     //     ),
//                                                     //     borderRadius: BorderRadius.circular(25),
//                                                     //   ),
//                                                     //   hintText: 'Enter Amount',
//                                                     // ),
//                                                     validator: (value) {
//                                                       if (value!.isEmpty) {
//                                                         return "Please enter hours";
//                                                       } else {
//                                                         return null;
//                                                       }
//                                                     },
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                       Row(
//                                         children: [
//                                           Expanded(
//                                             child: Align(
//                                                 alignment: Alignment.centerLeft,
//                                                 child: Padding(
//                                                   padding:
//                                                       const EdgeInsets.only(
//                                                     left: 2.0,
//                                                     right: 2.0,
//                                                   ),
//                                                   child: Container(
//                                                     margin:
//                                                         const EdgeInsets.only(
//                                                       left: 8,
//                                                       right: 8,
//                                                       top: 8,
//                                                     ),
//                                                     padding:
//                                                         const EdgeInsets.all(8),
//                                                     alignment: Alignment.center,
//                                                     // height: size.height * 0.5,
//                                                     // width: size.width * 0.99,
//                                                     decoration: BoxDecoration(
//                                                         // shape: BoxShape.circle,
//                                                         borderRadius:
//                                                             BorderRadius
//                                                                 .circular(10),
//                                                         boxShadow: const [
//                                                           BoxShadow(
//                                                               color:
//                                                                   Color.fromARGB(255, 7, 59, 120),
//                                                               blurRadius: 10,
//                                                               offset: Offset(
//                                                                   2.0, 5.0))
//                                                         ],
//                                                         gradient:
//                                                             const LinearGradient(
//                                                           colors: [
//                                                             Color.fromARGB(255,
//                                                                 2, 92, 249),
//                                                             Color.fromARGB(255,
//                                                                 16, 1, 135),
//                                                           ],
//                                                         )),

//                                                     child: const Text(
//                                                       "Total Hours",
//                                                       style: TextStyle(
//                                                         fontSize: 16.0,
//                                                         color: Colors.white,
//                                                         //fontWeight: FontWeight.bold
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 )),
//                                           ),
//                                           Expanded(
//                                             child: Container(
//                                               margin: const EdgeInsets.only(
//                                                 left: 8,
//                                                 right: 8,
//                                                 top: 8,
//                                               ),
//                                               padding: const EdgeInsets.all(8),
//                                               alignment: Alignment.center,
//                                               height: size.height * 0.05,
//                                               // width: size.width * 0.99,
//                                               decoration: BoxDecoration(
//                                                   // shape: BoxShape.circle,
//                                                   borderRadius:
//                                                       BorderRadius.circular(10),
//                                                   boxShadow: const [
//                                                     BoxShadow(
//                                                         color: Color.fromARGB(255, 7, 59, 120),
//                                                         blurRadius: 10,
//                                                         offset:
//                                                             Offset(2.0, 5.0))
//                                                   ],
//                                                   gradient:
//                                                       const LinearGradient(
//                                                     colors: [
//                                                       Colors.white,
//                                                       Colors.white,
//                                                     ],
//                                                   )),

//                                               child: Align(
//                                                 alignment:
//                                                     Alignment.centerRight,
//                                                 child: Padding(
//                                                   padding:
//                                                       const EdgeInsets.all(2.0),
//                                                   child: TextFormField(
//                                                     //key: formkey4,
//                                                     controller:
//                                                         _hoursTotalEquipment,
//                                                     style: const TextStyle(
//                                                         color: Color.fromARGB(255, 7, 59, 120),
//                                                         fontSize: 16),
//                                                     obscureText: false,
//                                                     // keyboardType: TextInputType.number,
//                                                     // decoration: InputDecoration(
//                                                     //   border: OutlineInputBorder(
//                                                     //     borderRadius: BorderRadius.circular(25),
//                                                     //   ),
//                                                     //   enabledBorder: OutlineInputBorder(
//                                                     //     borderSide: const BorderSide(
//                                                     //       color: Color.fromARGB(255, 7, 59, 120),
//                                                     //     ),
//                                                     //     borderRadius: BorderRadius.circular(25),
//                                                     //   ),
//                                                     //   hintText: 'Enter Amount',
//                                                     // ),
//                                                     validator: (value) {
//                                                       if (value!.isEmpty) {
//                                                         return "Please enter hours";
//                                                       } else {
//                                                         return null;
//                                                       }
//                                                     },
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                 );
//                               },
//                             ),
//                           ],
//                         ),
//                       ],
//                     )),
//                 Container(
//                     margin: const EdgeInsets.only(
//                         left: 8, right: 8, top: 10, bottom: 8),
//                     padding: const EdgeInsets.all(8),
//                     alignment: Alignment.center,
//                     // height: size.height * 0.5,
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
//                           // height: 40,
//                           decoration: const BoxDecoration(
//                               // shape: BoxShape.circle,
//                               //borderRadius: BorderRadius.circular(25),
//                               boxShadow: [
//                                 BoxShadow(
//                                      color: Color.fromARGB(
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
//                           child: const Row(children: [
//                             Align(
//                               alignment: Alignment.centerLeft,
//                               child: Text(
//                                 "Activities",
//                                 textAlign: TextAlign.left,
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 20,
//                                 ),
//                               ),
//                             ),
//                           ]),
//                         ),
//                         Column(
//                           children: [
//                             Align(
//                               alignment: Alignment.centerLeft,
//                               child: Padding(
//                                 padding: const EdgeInsets.only(top: 10.0),
//                                 child: DropdownButtonFormField<String>(
//                                   hint:
//                                       const Text('Select Number Of Activities'),
//                                   dropdownColor:
//                                       Colors.white,
//                                   value: numberOfActivities,
//                                   style: const TextStyle(
//                                       color: Color.fromARGB(255, 7, 59, 120), fontSize: 16),
//                                   icon: const Icon(
//                                     Icons.arrow_drop_down,
//                                     color: Color.fromARGB(255, 7, 59, 120),
//                                     size: 40,
//                                   ),
//                                   decoration: InputDecoration(
//                                     enabledBorder: OutlineInputBorder(
//                                       borderSide: const BorderSide(
//                                         color: Color.fromARGB(255, 7, 59, 120),
//                                       ),
//                                       borderRadius: BorderRadius.circular(25),
//                                     ),
//                                     focusedBorder: OutlineInputBorder(
//                                       borderSide: const BorderSide(
//                                         color: Color.fromARGB(255, 7, 59, 120),
//                                       ),
//                                       borderRadius: BorderRadius.circular(25),
//                                     ),
//                                   ),
//                                   isExpanded: true,
//                                   items: select_numberOfActivities
//                                       .map(buildMenuItem)
//                                       .toList(),
//                                   onChanged: (value) {
//                                     numberOfActivities = value;
//                                     setState(() {
//                                       getNumberOfActivityLength();
//                                     });
//                                   },
//                                   // onChanged: (value) => setState(
//                                   //     () => this.numberOfActivities = value),
//                                   validator: (value) =>
//                                       value == null ? 'field required' : null,
//                                 ),
//                               ),
//                             ),
//                             ListView.builder(
//                               shrinkWrap: true,
//                               itemCount: numberOfActivityLength,
//                               // itemCount:  getDaysInBetween().attractions.length,
//                               // itemCount: numberOfDays.length,
//                               physics: const NeverScrollableScrollPhysics(),
//                               itemBuilder: (BuildContext context, int index) {
//                                 return Container(
//                                   margin: const EdgeInsets.only(
//                                       left: 4, right: 4, top: 10, bottom: 8),
//                                   padding: const EdgeInsets.all(8),
//                                   alignment: Alignment.center,
//                                   // height: size.height * 0.5,
//                                   width: size.width * 0.99,
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
//                                           Color.fromARGB(255, 255, 255, 255),
//                                           Color.fromARGB(255, 255, 255, 255),
//                                         ],
//                                       )),
//                                   child: Column(
//                                     children: [
//                                       Row(
//                                         children: [
//                                           Expanded(
//                                             child: Align(
//                                                 alignment: Alignment.centerLeft,
//                                                 child: Padding(
//                                                   padding:
//                                                       const EdgeInsets.only(
//                                                     left: 2.0,
//                                                     right: 2.0,
//                                                   ),
//                                                   child: Container(
//                                                     margin:
//                                                         const EdgeInsets.only(
//                                                       left: 8,
//                                                       right: 8,
//                                                       top: 8,
//                                                     ),
//                                                     padding:
//                                                         const EdgeInsets.all(8),
//                                                     alignment: Alignment.center,
//                                                     // height: size.height * 0.5,
//                                                     // width: size.width * 0.99,
//                                                     decoration: BoxDecoration(
//                                                         // shape: BoxShape.circle,
//                                                         borderRadius:
//                                                             BorderRadius
//                                                                 .circular(10),
//                                                         boxShadow: const [
//                                                           BoxShadow(
//                                                               color:
//                                                                   Color.fromARGB(255, 7, 59, 120),
//                                                               blurRadius: 10,
//                                                               offset: Offset(
//                                                                   2.0, 5.0))
//                                                         ],
//                                                         gradient:
//                                                             const LinearGradient(
//                                                           colors: [
//                                                             Color.fromARGB(255,
//                                                                 2, 92, 249),
//                                                             Color.fromARGB(255,
//                                                                 16, 1, 135),
//                                                           ],
//                                                         )),

//                                                     child: const Text(
//                                                       "Days Of Week",
//                                                       style: TextStyle(
//                                                         fontSize: 16.0,
//                                                         color: Colors.white,
//                                                         //fontWeight: FontWeight.bold
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 )),
//                                           ),
//                                           Expanded(
//                                             child: Container(
//                                               margin: const EdgeInsets.only(
//                                                 left: 8,
//                                                 right: 8,
//                                                 top: 8,
//                                               ),
//                                               padding: const EdgeInsets.all(8),
//                                               alignment: Alignment.center,
//                                               height: size.height * 0.05,
//                                               // width: size.width * 0.99,
//                                               decoration: BoxDecoration(
//                                                   // shape: BoxShape.circle,
//                                                   borderRadius:
//                                                       BorderRadius.circular(10),
//                                                   boxShadow: const [
//                                                     BoxShadow(
//                                                         color: Color.fromARGB(255, 7, 59, 120),
//                                                         blurRadius: 10,
//                                                         offset:
//                                                             Offset(2.0, 5.0))
//                                                   ],
//                                                   gradient:
//                                                       const LinearGradient(
//                                                     colors: [
//                                                       Colors.white,
//                                                       Colors.white,
//                                                     ],
//                                                   )),

//                                               child: Align(
//                                                 alignment:
//                                                     Alignment.centerRight,
//                                                 child: Padding(
//                                                   padding:
//                                                       const EdgeInsets.all(2.0),
//                                                   child: TextFormField(
//                                                     //key: formkey4,
//                                                     controller: _daysOfWeek,
//                                                     style: const TextStyle(
//                                                         color: Color.fromARGB(255, 7, 59, 120),
//                                                         fontSize: 16),
//                                                     obscureText: false,
//                                                     keyboardType:
//                                                         TextInputType.number,
//                                                     // decoration: InputDecoration(
//                                                     //   border: OutlineInputBorder(
//                                                     //     borderRadius: BorderRadius.circular(25),
//                                                     //   ),
//                                                     //   enabledBorder: OutlineInputBorder(
//                                                     //     borderSide: const BorderSide(
//                                                     //       color: Color.fromARGB(255, 7, 59, 120),
//                                                     //     ),
//                                                     //     borderRadius: BorderRadius.circular(25),
//                                                     //   ),
//                                                     //   hintText: 'Enter Amount',
//                                                     // ),
//                                                     validator: (value) {
//                                                       if (value!.isEmpty) {
//                                                         return "Please enter day";
//                                                       } else {
//                                                         return null;
//                                                       }
//                                                     },
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                       Row(
//                                         children: [
//                                           Expanded(
//                                             child: Align(
//                                                 alignment: Alignment.centerLeft,
//                                                 child: Padding(
//                                                   padding:
//                                                       const EdgeInsets.only(
//                                                     left: 2.0,
//                                                     right: 2.0,
//                                                   ),
//                                                   child: Container(
//                                                     margin:
//                                                         const EdgeInsets.only(
//                                                       left: 8,
//                                                       right: 8,
//                                                       top: 8,
//                                                     ),
//                                                     padding:
//                                                         const EdgeInsets.all(8),
//                                                     alignment: Alignment.center,
//                                                     // height: size.height * 0.5,
//                                                     // width: size.width * 0.99,
//                                                     decoration: BoxDecoration(
//                                                         // shape: BoxShape.circle,
//                                                         borderRadius:
//                                                             BorderRadius
//                                                                 .circular(10),
//                                                         boxShadow: const [
//                                                           BoxShadow(
//                                                               color:
//                                                                   Color.fromARGB(255, 7, 59, 120),
//                                                               blurRadius: 10,
//                                                               offset: Offset(
//                                                                   2.0, 5.0))
//                                                         ],
//                                                         gradient:
//                                                             const LinearGradient(
//                                                           colors: [
//                                                             Color.fromARGB(255,
//                                                                 2, 92, 249),
//                                                             Color.fromARGB(255,
//                                                                 16, 1, 135),
//                                                           ],
//                                                         )),

//                                                     child: const Text(
//                                                       "Feeder ID",
//                                                       style: TextStyle(
//                                                         fontSize: 16.0,
//                                                         color: Colors.white,
//                                                         //fontWeight: FontWeight.bold
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 )),
//                                           ),
//                                           Expanded(
//                                             child: Container(
//                                               margin: const EdgeInsets.only(
//                                                 left: 8,
//                                                 right: 8,
//                                                 top: 8,
//                                               ),
//                                               padding: const EdgeInsets.all(8),
//                                               alignment: Alignment.center,
//                                               height: size.height * 0.05,
//                                               // width: size.width * 0.99,
//                                               decoration: BoxDecoration(
//                                                   // shape: BoxShape.circle,
//                                                   borderRadius:
//                                                       BorderRadius.circular(10),
//                                                   boxShadow: const [
//                                                     BoxShadow(
//                                                         color: Color.fromARGB(255, 7, 59, 120),
//                                                         blurRadius: 10,
//                                                         offset:
//                                                             Offset(2.0, 5.0))
//                                                   ],
//                                                   gradient:
//                                                       const LinearGradient(
//                                                     colors: [
//                                                       Colors.white,
//                                                       Colors.white,
//                                                     ],
//                                                   )),

//                                               child: Align(
//                                                 alignment:
//                                                     Alignment.centerRight,
//                                                 child: Padding(
//                                                   padding:
//                                                       const EdgeInsets.all(2.0),
//                                                   child: TextFormField(
//                                                     //key: formkey4,
//                                                     controller: _feederId,
//                                                     style: const TextStyle(
//                                                         color: Color.fromARGB(255, 7, 59, 120),
//                                                         fontSize: 16),
//                                                     obscureText: false,
//                                                     // keyboardType: TextInputType.number,
//                                                     // decoration: InputDecoration(
//                                                     //   border: OutlineInputBorder(
//                                                     //     borderRadius: BorderRadius.circular(25),
//                                                     //   ),
//                                                     //   enabledBorder: OutlineInputBorder(
//                                                     //     borderSide: const BorderSide(
//                                                     //       color: Color.fromARGB(255, 7, 59, 120),
//                                                     //     ),
//                                                     //     borderRadius: BorderRadius.circular(25),
//                                                     //   ),
//                                                     //   hintText: 'Enter Amount',
//                                                     // ),
//                                                     validator: (value) {
//                                                       if (value!.isEmpty) {
//                                                         return "Please enter feeder id";
//                                                       } else {
//                                                         return null;
//                                                       }
//                                                     },
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                       Row(
//                                         children: [
//                                           Expanded(
//                                             child: Align(
//                                                 alignment: Alignment.centerLeft,
//                                                 child: Padding(
//                                                   padding:
//                                                       const EdgeInsets.only(
//                                                     left: 2.0,
//                                                     right: 2.0,
//                                                   ),
//                                                   child: Container(
//                                                     margin:
//                                                         const EdgeInsets.only(
//                                                       left: 8,
//                                                       right: 8,
//                                                       top: 8,
//                                                     ),
//                                                     padding:
//                                                         const EdgeInsets.all(8),
//                                                     alignment: Alignment.center,
//                                                     // height: size.height * 0.5,
//                                                     // width: size.width * 0.99,
//                                                     decoration: BoxDecoration(
//                                                         // shape: BoxShape.circle,
//                                                         borderRadius:
//                                                             BorderRadius
//                                                                 .circular(10),
//                                                         boxShadow: const [
//                                                           BoxShadow(
//                                                               color:
//                                                                   Color.fromARGB(255, 7, 59, 120),
//                                                               blurRadius: 10,
//                                                               offset: Offset(
//                                                                   2.0, 5.0))
//                                                         ],
//                                                         gradient:
//                                                             const LinearGradient(
//                                                           colors: [
//                                                             Color.fromARGB(255,
//                                                                 2, 92, 249),
//                                                             Color.fromARGB(255,
//                                                                 16, 1, 135),
//                                                           ],
//                                                         )),

//                                                     child: const Text(
//                                                       "Account/Wo Number",
//                                                       style: TextStyle(
//                                                         fontSize: 16.0,
//                                                         color: Colors.white,
//                                                         //fontWeight: FontWeight.bold
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 )),
//                                           ),
//                                           Expanded(
//                                             child: Container(
//                                               margin: const EdgeInsets.only(
//                                                 left: 8,
//                                                 right: 8,
//                                                 top: 8,
//                                               ),
//                                               padding: const EdgeInsets.all(8),
//                                               alignment: Alignment.center,
//                                               height: size.height * 0.05,
//                                               // width: size.width * 0.99,
//                                               decoration: BoxDecoration(
//                                                   // shape: BoxShape.circle,
//                                                   borderRadius:
//                                                       BorderRadius.circular(10),
//                                                   boxShadow: const [
//                                                     BoxShadow(
//                                                         color: Color.fromARGB(255, 7, 59, 120),
//                                                         blurRadius: 10,
//                                                         offset:
//                                                             Offset(2.0, 5.0))
//                                                   ],
//                                                   gradient:
//                                                       const LinearGradient(
//                                                     colors: [
//                                                       Colors.white,
//                                                       Colors.white,
//                                                     ],
//                                                   )),

//                                               child: Align(
//                                                 alignment:
//                                                     Alignment.centerRight,
//                                                 child: Padding(
//                                                   padding:
//                                                       const EdgeInsets.all(2.0),
//                                                   child: TextFormField(
//                                                     //key: formkey4,
//                                                     controller:
//                                                         _accountWoNumber,
//                                                     style: const TextStyle(
//                                                         color: Color.fromARGB(255, 7, 59, 120),
//                                                         fontSize: 16),
//                                                     obscureText: false,
//                                                     // keyboardType: TextInputType.number,
//                                                     // decoration: InputDecoration(
//                                                     //   border: OutlineInputBorder(
//                                                     //     borderRadius: BorderRadius.circular(25),
//                                                     //   ),
//                                                     //   enabledBorder: OutlineInputBorder(
//                                                     //     borderSide: const BorderSide(
//                                                     //       color: Color.fromARGB(255, 7, 59, 120),
//                                                     //     ),
//                                                     //     borderRadius: BorderRadius.circular(25),
//                                                     //   ),
//                                                     //   hintText: 'Enter Amount',
//                                                     // ),
//                                                     validator: (value) {
//                                                       if (value!.isEmpty) {
//                                                         return "Please enter account/wo no.";
//                                                       } else {
//                                                         return null;
//                                                       }
//                                                     },
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                       Row(
//                                         children: [
//                                           Expanded(
//                                             child: Align(
//                                                 alignment: Alignment.centerLeft,
//                                                 child: Padding(
//                                                   padding:
//                                                       const EdgeInsets.only(
//                                                     left: 2.0,
//                                                     right: 2.0,
//                                                   ),
//                                                   child: Container(
//                                                     margin:
//                                                         const EdgeInsets.only(
//                                                       left: 8,
//                                                       right: 8,
//                                                       top: 8,
//                                                     ),
//                                                     padding:
//                                                         const EdgeInsets.all(8),
//                                                     alignment: Alignment.center,
//                                                     // height: size.height * 0.5,
//                                                     // width: size.width * 0.99,
//                                                     decoration: BoxDecoration(
//                                                         // shape: BoxShape.circle,
//                                                         borderRadius:
//                                                             BorderRadius
//                                                                 .circular(10),
//                                                         boxShadow: const [
//                                                           BoxShadow(
//                                                               color:
//                                                                   Color.fromARGB(255, 7, 59, 120),
//                                                               blurRadius: 10,
//                                                               offset: Offset(
//                                                                   2.0, 5.0))
//                                                         ],
//                                                         gradient:
//                                                             const LinearGradient(
//                                                           colors: [
//                                                             Color.fromARGB(255,
//                                                                 2, 92, 249),
//                                                             Color.fromARGB(255,
//                                                                 16, 1, 135),
//                                                           ],
//                                                         )),

//                                                     child: const Text(
//                                                       "Section Address",
//                                                       style: TextStyle(
//                                                         fontSize: 16.0,
//                                                         color: Colors.white,
//                                                         //fontWeight: FontWeight.bold
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 )),
//                                           ),
//                                           Expanded(
//                                             child: Container(
//                                               margin: const EdgeInsets.only(
//                                                 left: 8,
//                                                 right: 8,
//                                                 top: 8,
//                                               ),
//                                               padding: const EdgeInsets.all(8),
//                                               alignment: Alignment.center,
//                                               height: size.height * 0.05,
//                                               // width: size.width * 0.99,
//                                               decoration: BoxDecoration(
//                                                   // shape: BoxShape.circle,
//                                                   borderRadius:
//                                                       BorderRadius.circular(10),
//                                                   boxShadow: const [
//                                                     BoxShadow(
//                                                         color: Color.fromARGB(255, 7, 59, 120),
//                                                         blurRadius: 10,
//                                                         offset:
//                                                             Offset(2.0, 5.0))
//                                                   ],
//                                                   gradient:
//                                                       const LinearGradient(
//                                                     colors: [
//                                                       Colors.white,
//                                                       Colors.white,
//                                                     ],
//                                                   )),

//                                               child: Align(
//                                                 alignment:
//                                                     Alignment.centerRight,
//                                                 child: Padding(
//                                                   padding:
//                                                       const EdgeInsets.all(2.0),
//                                                   child: TextFormField(
//                                                     //key: formkey4,
//                                                     controller: _sectionAddress,
//                                                     style: const TextStyle(
//                                                         color: Color.fromARGB(255, 7, 59, 120),
//                                                         fontSize: 16),
//                                                     obscureText: false,
//                                                     // keyboardType: TextInputType.number,
//                                                     // decoration: InputDecoration(
//                                                     //   border: OutlineInputBorder(
//                                                     //     borderRadius: BorderRadius.circular(25),
//                                                     //   ),
//                                                     //   enabledBorder: OutlineInputBorder(
//                                                     //     borderSide: const BorderSide(
//                                                     //       color: Color.fromARGB(255, 7, 59, 120),
//                                                     //     ),
//                                                     //     borderRadius: BorderRadius.circular(25),
//                                                     //   ),
//                                                     //   hintText: 'Enter Amount',
//                                                     // ),
//                                                     validator: (value) {
//                                                       if (value!.isEmpty) {
//                                                         return "Please enter section address";
//                                                       } else {
//                                                         return null;
//                                                       }
//                                                     },
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                       Row(
//                                         children: [
//                                           Expanded(
//                                             child: Align(
//                                                 alignment: Alignment.centerLeft,
//                                                 child: Padding(
//                                                   padding:
//                                                       const EdgeInsets.only(
//                                                     left: 2.0,
//                                                     right: 2.0,
//                                                   ),
//                                                   child: Container(
//                                                     margin:
//                                                         const EdgeInsets.only(
//                                                       left: 8,
//                                                       right: 8,
//                                                       top: 8,
//                                                     ),
//                                                     padding:
//                                                         const EdgeInsets.all(8),
//                                                     alignment: Alignment.center,
//                                                     // height: size.height * 0.5,
//                                                     // width: size.width * 0.99,
//                                                     decoration: BoxDecoration(
//                                                         // shape: BoxShape.circle,
//                                                         borderRadius:
//                                                             BorderRadius
//                                                                 .circular(10),
//                                                         boxShadow: const [
//                                                           BoxShadow(
//                                                               color:
//                                                                   Color.fromARGB(255, 7, 59, 120),
//                                                               blurRadius: 10,
//                                                               offset: Offset(
//                                                                   2.0, 5.0))
//                                                         ],
//                                                         gradient:
//                                                             const LinearGradient(
//                                                           colors: [
//                                                             Color.fromARGB(255,
//                                                                 2, 92, 249),
//                                                             Color.fromARGB(255,
//                                                                 16, 1, 135),
//                                                           ],
//                                                         )),

//                                                     child: const Text(
//                                                       "Notes Activity Code",
//                                                       style: TextStyle(
//                                                         fontSize: 16.0,
//                                                         color: Colors.white,
//                                                         //fontWeight: FontWeight.bold
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 )),
//                                           ),
//                                           Expanded(
//                                             child: Container(
//                                               margin: const EdgeInsets.only(
//                                                 left: 8,
//                                                 right: 8,
//                                                 top: 8,
//                                               ),
//                                               padding: const EdgeInsets.all(8),
//                                               alignment: Alignment.center,
//                                               height: size.height * 0.05,
//                                               // width: size.width * 0.99,
//                                               decoration: BoxDecoration(
//                                                   // shape: BoxShape.circle,
//                                                   borderRadius:
//                                                       BorderRadius.circular(10),
//                                                   boxShadow: const [
//                                                     BoxShadow(
//                                                         color: Color.fromARGB(255, 7, 59, 120),
//                                                         blurRadius: 10,
//                                                         offset:
//                                                             Offset(2.0, 5.0))
//                                                   ],
//                                                   gradient:
//                                                       const LinearGradient(
//                                                     colors: [
//                                                       Colors.white,
//                                                       Colors.white,
//                                                     ],
//                                                   )),

//                                               child: Align(
//                                                 alignment:
//                                                     Alignment.centerRight,
//                                                 child: Padding(
//                                                   padding:
//                                                       const EdgeInsets.all(2.0),
//                                                   child: TextFormField(
//                                                     //key: formkey4,
//                                                     controller:
//                                                         _notesActivityCode,
//                                                     style: const TextStyle(
//                                                         color: Color.fromARGB(255, 7, 59, 120),
//                                                         fontSize: 16),
//                                                     obscureText: false,
//                                                     // keyboardType: TextInputType.number,
//                                                     // decoration: InputDecoration(
//                                                     //   border: OutlineInputBorder(
//                                                     //     borderRadius: BorderRadius.circular(25),
//                                                     //   ),
//                                                     //   enabledBorder: OutlineInputBorder(
//                                                     //     borderSide: const BorderSide(
//                                                     //       color: Color.fromARGB(255, 7, 59, 120),
//                                                     //     ),
//                                                     //     borderRadius: BorderRadius.circular(25),
//                                                     //   ),
//                                                     //   hintText: 'Enter Amount',
//                                                     // ),
//                                                     validator: (value) {
//                                                       if (value!.isEmpty) {
//                                                         return "Please enter notes activity code";
//                                                       } else {
//                                                         return null;
//                                                       }
//                                                     },
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                       Row(
//                                         children: [
//                                           Expanded(
//                                             child: Align(
//                                                 alignment: Alignment.centerLeft,
//                                                 child: Padding(
//                                                   padding:
//                                                       const EdgeInsets.only(
//                                                     left: 2.0,
//                                                     right: 2.0,
//                                                   ),
//                                                   child: Container(
//                                                     margin:
//                                                         const EdgeInsets.only(
//                                                       left: 8,
//                                                       right: 8,
//                                                       top: 8,
//                                                     ),
//                                                     padding:
//                                                         const EdgeInsets.all(8),
//                                                     alignment: Alignment.center,
//                                                     // height: size.height * 0.5,
//                                                     // width: size.width * 0.99,
//                                                     decoration: BoxDecoration(
//                                                         // shape: BoxShape.circle,
//                                                         borderRadius:
//                                                             BorderRadius
//                                                                 .circular(10),
//                                                         boxShadow: const [
//                                                           BoxShadow(
//                                                               color:
//                                                                   Color.fromARGB(255, 7, 59, 120),
//                                                               blurRadius: 10,
//                                                               offset: Offset(
//                                                                   2.0, 5.0))
//                                                         ],
//                                                         gradient:
//                                                             const LinearGradient(
//                                                           colors: [
//                                                             Color.fromARGB(255,
//                                                                 2, 92, 249),
//                                                             Color.fromARGB(255,
//                                                                 16, 1, 135),
//                                                           ],
//                                                         )),

//                                                     child: const Text(
//                                                       "Spans",
//                                                       style: TextStyle(
//                                                         fontSize: 16.0,
//                                                         color: Colors.white,
//                                                         //fontWeight: FontWeight.bold
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 )),
//                                           ),
//                                           Expanded(
//                                             child: Container(
//                                               margin: const EdgeInsets.only(
//                                                 left: 8,
//                                                 right: 8,
//                                                 top: 8,
//                                               ),
//                                               padding: const EdgeInsets.all(8),
//                                               alignment: Alignment.center,
//                                               height: size.height * 0.05,
//                                               // width: size.width * 0.99,
//                                               decoration: BoxDecoration(
//                                                   // shape: BoxShape.circle,
//                                                   borderRadius:
//                                                       BorderRadius.circular(10),
//                                                   boxShadow: const [
//                                                     BoxShadow(
//                                                         color: Color.fromARGB(255, 7, 59, 120),
//                                                         blurRadius: 10,
//                                                         offset:
//                                                             Offset(2.0, 5.0))
//                                                   ],
//                                                   gradient:
//                                                       const LinearGradient(
//                                                     colors: [
//                                                       Colors.white,
//                                                       Colors.white,
//                                                     ],
//                                                   )),

//                                               child: Align(
//                                                 alignment:
//                                                     Alignment.centerRight,
//                                                 child: Padding(
//                                                   padding:
//                                                       const EdgeInsets.all(2.0),
//                                                   child: TextFormField(
//                                                     //key: formkey4,
//                                                     controller: _spans,
//                                                     style: const TextStyle(
//                                                         color: Color.fromARGB(255, 7, 59, 120),
//                                                         fontSize: 16),
//                                                     obscureText: false,
//                                                     // keyboardType: TextInputType.number,
//                                                     // decoration: InputDecoration(
//                                                     //   border: OutlineInputBorder(
//                                                     //     borderRadius: BorderRadius.circular(25),
//                                                     //   ),
//                                                     //   enabledBorder: OutlineInputBorder(
//                                                     //     borderSide: const BorderSide(
//                                                     //       color: Color.fromARGB(255, 7, 59, 120),
//                                                     //     ),
//                                                     //     borderRadius: BorderRadius.circular(25),
//                                                     //   ),
//                                                     //   hintText: 'Enter Amount',
//                                                     // ),
//                                                     validator: (value) {
//                                                       if (value!.isEmpty) {
//                                                         return "Please enter spans";
//                                                       } else {
//                                                         return null;
//                                                       }
//                                                     },
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                       Row(
//                                         children: [
//                                           Expanded(
//                                             child: Align(
//                                                 alignment: Alignment.centerLeft,
//                                                 child: Padding(
//                                                   padding:
//                                                       const EdgeInsets.only(
//                                                     left: 2.0,
//                                                     right: 2.0,
//                                                   ),
//                                                   child: Container(
//                                                     margin:
//                                                         const EdgeInsets.only(
//                                                       left: 8,
//                                                       right: 8,
//                                                       top: 8,
//                                                     ),
//                                                     padding:
//                                                         const EdgeInsets.all(8),
//                                                     alignment: Alignment.center,
//                                                     // height: size.height * 0.5,
//                                                     // width: size.width * 0.99,
//                                                     decoration: BoxDecoration(
//                                                         // shape: BoxShape.circle,
//                                                         borderRadius:
//                                                             BorderRadius
//                                                                 .circular(10),
//                                                         boxShadow: const [
//                                                           BoxShadow(
//                                                               color:
//                                                                   Color.fromARGB(255, 7, 59, 120),
//                                                               blurRadius: 10,
//                                                               offset: Offset(
//                                                                   2.0, 5.0))
//                                                         ],
//                                                         gradient:
//                                                             const LinearGradient(
//                                                           colors: [
//                                                             Color.fromARGB(255,
//                                                                 2, 92, 249),
//                                                             Color.fromARGB(255,
//                                                                 16, 1, 135),
//                                                           ],
//                                                         )),

//                                                     child: const Text(
//                                                       "Width",
//                                                       style: TextStyle(
//                                                         fontSize: 16.0,
//                                                         color: Colors.white,
//                                                         //fontWeight: FontWeight.bold
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 )),
//                                           ),
//                                           Expanded(
//                                             child: Container(
//                                               margin: const EdgeInsets.only(
//                                                 left: 8,
//                                                 right: 8,
//                                                 top: 8,
//                                               ),
//                                               padding: const EdgeInsets.all(8),
//                                               alignment: Alignment.center,
//                                               height: size.height * 0.05,
//                                               // width: size.width * 0.99,
//                                               decoration: BoxDecoration(
//                                                   // shape: BoxShape.circle,
//                                                   borderRadius:
//                                                       BorderRadius.circular(10),
//                                                   boxShadow: const [
//                                                     BoxShadow(
//                                                         color: Color.fromARGB(255, 7, 59, 120),
//                                                         blurRadius: 10,
//                                                         offset:
//                                                             Offset(2.0, 5.0))
//                                                   ],
//                                                   gradient:
//                                                       const LinearGradient(
//                                                     colors: [
//                                                       Colors.white,
//                                                       Colors.white,
//                                                     ],
//                                                   )),

//                                               child: Align(
//                                                 alignment:
//                                                     Alignment.centerRight,
//                                                 child: Padding(
//                                                   padding:
//                                                       const EdgeInsets.all(2.0),
//                                                   child: TextFormField(
//                                                     //key: formkey4,
//                                                     controller: _width,
//                                                     style: const TextStyle(
//                                                         color: Color.fromARGB(255, 7, 59, 120),
//                                                         fontSize: 16),
//                                                     obscureText: false,
//                                                     // keyboardType: TextInputType.number,
//                                                     // decoration: InputDecoration(
//                                                     //   border: OutlineInputBorder(
//                                                     //     borderRadius: BorderRadius.circular(25),
//                                                     //   ),
//                                                     //   enabledBorder: OutlineInputBorder(
//                                                     //     borderSide: const BorderSide(
//                                                     //       color: Color.fromARGB(255, 7, 59, 120),
//                                                     //     ),
//                                                     //     borderRadius: BorderRadius.circular(25),
//                                                     //   ),
//                                                     //   hintText: 'Enter Amount',
//                                                     // ),
//                                                     validator: (value) {
//                                                       if (value!.isEmpty) {
//                                                         return "Please enter width";
//                                                       } else {
//                                                         return null;
//                                                       }
//                                                     },
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                       Row(
//                                         children: [
//                                           Expanded(
//                                             child: Align(
//                                                 alignment: Alignment.centerLeft,
//                                                 child: Padding(
//                                                   padding:
//                                                       const EdgeInsets.only(
//                                                     left: 2.0,
//                                                     right: 2.0,
//                                                   ),
//                                                   child: Container(
//                                                     margin:
//                                                         const EdgeInsets.only(
//                                                       left: 8,
//                                                       right: 8,
//                                                       top: 8,
//                                                     ),
//                                                     padding:
//                                                         const EdgeInsets.all(8),
//                                                     alignment: Alignment.center,
//                                                     // height: size.height * 0.5,
//                                                     // width: size.width * 0.99,
//                                                     decoration: BoxDecoration(
//                                                         // shape: BoxShape.circle,
//                                                         borderRadius:
//                                                             BorderRadius
//                                                                 .circular(10),
//                                                         boxShadow: const [
//                                                           BoxShadow(
//                                                               color:
//                                                                   Color.fromARGB(255, 7, 59, 120),
//                                                               blurRadius: 10,
//                                                               offset: Offset(
//                                                                   2.0, 5.0))
//                                                         ],
//                                                         gradient:
//                                                             const LinearGradient(
//                                                           colors: [
//                                                             Color.fromARGB(255,
//                                                                 2, 92, 249),
//                                                             Color.fromARGB(255,
//                                                                 16, 1, 135),
//                                                           ],
//                                                         )),

//                                                     child: const Text(
//                                                       "Chemical Quantity",
//                                                       style: TextStyle(
//                                                         fontSize: 16.0,
//                                                         color: Colors.white,
//                                                         //fontWeight: FontWeight.bold
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 )),
//                                           ),
//                                           Expanded(
//                                             child: Container(
//                                               margin: const EdgeInsets.only(
//                                                 left: 8,
//                                                 right: 8,
//                                                 top: 8,
//                                               ),
//                                               padding: const EdgeInsets.all(8),
//                                               alignment: Alignment.center,
//                                               height: size.height * 0.05,
//                                               // width: size.width * 0.99,
//                                               decoration: BoxDecoration(
//                                                   // shape: BoxShape.circle,
//                                                   borderRadius:
//                                                       BorderRadius.circular(10),
//                                                   boxShadow: const [
//                                                     BoxShadow(
//                                                         color: Color.fromARGB(255, 7, 59, 120),
//                                                         blurRadius: 10,
//                                                         offset:
//                                                             Offset(2.0, 5.0))
//                                                   ],
//                                                   gradient:
//                                                       const LinearGradient(
//                                                     colors: [
//                                                       Colors.white,
//                                                       Colors.white,
//                                                     ],
//                                                   )),

//                                               child: Align(
//                                                 alignment:
//                                                     Alignment.centerRight,
//                                                 child: Padding(
//                                                   padding:
//                                                       const EdgeInsets.all(2.0),
//                                                   child: TextFormField(
//                                                     //key: formkey4,
//                                                     controller:
//                                                         _chemicalQuantity,
//                                                     style: const TextStyle(
//                                                         color: Color.fromARGB(255, 7, 59, 120),
//                                                         fontSize: 16),
//                                                     obscureText: false,
//                                                     // keyboardType: TextInputType.number,
//                                                     // decoration: InputDecoration(
//                                                     //   border: OutlineInputBorder(
//                                                     //     borderRadius: BorderRadius.circular(25),
//                                                     //   ),
//                                                     //   enabledBorder: OutlineInputBorder(
//                                                     //     borderSide: const BorderSide(
//                                                     //       color: Color.fromARGB(255, 7, 59, 120),
//                                                     //     ),
//                                                     //     borderRadius: BorderRadius.circular(25),
//                                                     //   ),
//                                                     //   hintText: 'Enter Amount',
//                                                     // ),
//                                                     validator: (value) {
//                                                       if (value!.isEmpty) {
//                                                         return "Please enter chemical quantity";
//                                                       } else {
//                                                         return null;
//                                                       }
//                                                     },
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                       Row(
//                                         children: [
//                                           Expanded(
//                                             child: Align(
//                                                 alignment: Alignment.centerLeft,
//                                                 child: Padding(
//                                                   padding:
//                                                       const EdgeInsets.only(
//                                                     left: 2.0,
//                                                     right: 2.0,
//                                                   ),
//                                                   child: Container(
//                                                     margin:
//                                                         const EdgeInsets.only(
//                                                       left: 8,
//                                                       right: 8,
//                                                       top: 8,
//                                                     ),
//                                                     padding:
//                                                         const EdgeInsets.all(8),
//                                                     alignment: Alignment.center,
//                                                     // height: size.height * 0.5,
//                                                     // width: size.width * 0.99,
//                                                     decoration: BoxDecoration(
//                                                         // shape: BoxShape.circle,
//                                                         borderRadius:
//                                                             BorderRadius
//                                                                 .circular(10),
//                                                         boxShadow: const [
//                                                           BoxShadow(
//                                                               color:
//                                                                   Color.fromARGB(255, 7, 59, 120),
//                                                               blurRadius: 10,
//                                                               offset: Offset(
//                                                                   2.0, 5.0))
//                                                         ],
//                                                         gradient:
//                                                             const LinearGradient(
//                                                           colors: [
//                                                             Color.fromARGB(255,
//                                                                 2, 92, 249),
//                                                             Color.fromARGB(255,
//                                                                 16, 1, 135),
//                                                           ],
//                                                         )),

//                                                     child: const Text(
//                                                       "Substation Id",
//                                                       style: TextStyle(
//                                                         fontSize: 16.0,
//                                                         color: Colors.white,
//                                                         //fontWeight: FontWeight.bold
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 )),
//                                           ),
//                                           Expanded(
//                                             child: Container(
//                                               margin: const EdgeInsets.only(
//                                                 left: 8,
//                                                 right: 8,
//                                                 top: 8,
//                                               ),
//                                               padding: const EdgeInsets.all(8),
//                                               alignment: Alignment.center,
//                                               height: size.height * 0.05,
//                                               // width: size.width * 0.99,
//                                               decoration: BoxDecoration(
//                                                   // shape: BoxShape.circle,
//                                                   borderRadius:
//                                                       BorderRadius.circular(10),
//                                                   boxShadow: const [
//                                                     BoxShadow(
//                                                         color: Color.fromARGB(255, 7, 59, 120),
//                                                         blurRadius: 10,
//                                                         offset:
//                                                             Offset(2.0, 5.0))
//                                                   ],
//                                                   gradient:
//                                                       const LinearGradient(
//                                                     colors: [
//                                                       Colors.white,
//                                                       Colors.white,
//                                                     ],
//                                                   )),

//                                               child: Align(
//                                                 alignment:
//                                                     Alignment.centerRight,
//                                                 child: Padding(
//                                                   padding:
//                                                       const EdgeInsets.all(2.0),
//                                                   child: TextFormField(
//                                                     //key: formkey4,
//                                                     controller: _substationId,
//                                                     style: const TextStyle(
//                                                         color: Color.fromARGB(255, 7, 59, 120),
//                                                         fontSize: 16),
//                                                     obscureText: false,
//                                                     // keyboardType: TextInputType.number,
//                                                     // decoration: InputDecoration(
//                                                     //   border: OutlineInputBorder(
//                                                     //     borderRadius: BorderRadius.circular(25),
//                                                     //   ),
//                                                     //   enabledBorder: OutlineInputBorder(
//                                                     //     borderSide: const BorderSide(
//                                                     //       color: Color.fromARGB(255, 7, 59, 120),
//                                                     //     ),
//                                                     //     borderRadius: BorderRadius.circular(25),
//                                                     //   ),
//                                                     //   hintText: 'Enter Amount',
//                                                     // ),
//                                                     validator: (value) {
//                                                       if (value!.isEmpty) {
//                                                         return "Please enter substation id";
//                                                       } else {
//                                                         return null;
//                                                       }
//                                                     },
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                       Row(
//                                         children: [
//                                           Expanded(
//                                             child: Align(
//                                                 alignment: Alignment.centerLeft,
//                                                 child: Padding(
//                                                   padding:
//                                                       const EdgeInsets.only(
//                                                     left: 2.0,
//                                                     right: 2.0,
//                                                   ),
//                                                   child: Container(
//                                                     margin:
//                                                         const EdgeInsets.only(
//                                                       left: 8,
//                                                       right: 8,
//                                                       top: 8,
//                                                     ),
//                                                     padding:
//                                                         const EdgeInsets.all(8),
//                                                     alignment: Alignment.center,
//                                                     // height: size.height * 0.5,
//                                                     // width: size.width * 0.99,
//                                                     decoration: BoxDecoration(
//                                                         // shape: BoxShape.circle,
//                                                         borderRadius:
//                                                             BorderRadius
//                                                                 .circular(10),
//                                                         boxShadow: const [
//                                                           BoxShadow(
//                                                               color:
//                                                                   Color.fromARGB(255, 7, 59, 120),
//                                                               blurRadius: 10,
//                                                               offset: Offset(
//                                                                   2.0, 5.0))
//                                                         ],
//                                                         gradient:
//                                                             const LinearGradient(
//                                                           colors: [
//                                                             Color.fromARGB(255,
//                                                                 2, 92, 249),
//                                                             Color.fromARGB(255,
//                                                                 16, 1, 135),
//                                                           ],
//                                                         )),

//                                                     child: const Text(
//                                                       "Work Type",
//                                                       style: TextStyle(
//                                                         fontSize: 16.0,
//                                                         color: Colors.white,
//                                                         //fontWeight: FontWeight.bold
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 )),
//                                           ),
//                                           Expanded(
//                                             child: Container(
//                                               margin: const EdgeInsets.only(
//                                                 left: 8,
//                                                 right: 8,
//                                                 top: 8,
//                                               ),
//                                               padding: const EdgeInsets.all(8),
//                                               alignment: Alignment.center,
//                                               height: size.height * 0.05,
//                                               // width: size.width * 0.99,
//                                               decoration: BoxDecoration(
//                                                   // shape: BoxShape.circle,
//                                                   borderRadius:
//                                                       BorderRadius.circular(10),
//                                                   boxShadow: const [
//                                                     BoxShadow(
//                                                         color: Color.fromARGB(255, 7, 59, 120),
//                                                         blurRadius: 10,
//                                                         offset:
//                                                             Offset(2.0, 5.0))
//                                                   ],
//                                                   gradient:
//                                                       const LinearGradient(
//                                                     colors: [
//                                                       Colors.white,
//                                                       Colors.white,
//                                                     ],
//                                                   )),

//                                               child: Align(
//                                                 alignment:
//                                                     Alignment.centerRight,
//                                                 child: Padding(
//                                                   padding:
//                                                       const EdgeInsets.all(2.0),
//                                                   child: TextFormField(
//                                                     //key: formkey4,
//                                                     controller: _workType,
//                                                     style: const TextStyle(
//                                                         color: Color.fromARGB(255, 7, 59, 120),
//                                                         fontSize: 16),
//                                                     obscureText: false,
//                                                     // keyboardType: TextInputType.number,
//                                                     // decoration: InputDecoration(
//                                                     //   border: OutlineInputBorder(
//                                                     //     borderRadius: BorderRadius.circular(25),
//                                                     //   ),
//                                                     //   enabledBorder: OutlineInputBorder(
//                                                     //     borderSide: const BorderSide(
//                                                     //       color: Color.fromARGB(255, 7, 59, 120),
//                                                     //     ),
//                                                     //     borderRadius: BorderRadius.circular(25),
//                                                     //   ),
//                                                     //   hintText: 'Enter Amount',
//                                                     // ),
//                                                     validator: (value) {
//                                                       if (value!.isEmpty) {
//                                                         return "Please enter work type";
//                                                       } else {
//                                                         return null;
//                                                       }
//                                                     },
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                       Row(
//                                         children: [
//                                           Expanded(
//                                             child: Align(
//                                                 alignment: Alignment.centerLeft,
//                                                 child: Padding(
//                                                   padding:
//                                                       const EdgeInsets.only(
//                                                     left: 2.0,
//                                                     right: 2.0,
//                                                   ),
//                                                   child: Container(
//                                                     margin:
//                                                         const EdgeInsets.only(
//                                                       left: 8,
//                                                       right: 8,
//                                                       top: 8,
//                                                     ),
//                                                     padding:
//                                                         const EdgeInsets.all(8),
//                                                     alignment: Alignment.center,
//                                                     // height: size.height * 0.5,
//                                                     // width: size.width * 0.99,
//                                                     decoration: BoxDecoration(
//                                                         // shape: BoxShape.circle,
//                                                         borderRadius:
//                                                             BorderRadius
//                                                                 .circular(10),
//                                                         boxShadow: const [
//                                                           BoxShadow(
//                                                               color:
//                                                                   Color.fromARGB(255, 7, 59, 120),
//                                                               blurRadius: 10,
//                                                               offset: Offset(
//                                                                   2.0, 5.0))
//                                                         ],
//                                                         gradient:
//                                                             const LinearGradient(
//                                                           colors: [
//                                                             Color.fromARGB(255,
//                                                                 2, 92, 249),
//                                                             Color.fromARGB(255,
//                                                                 16, 1, 135),
//                                                           ],
//                                                         )),

//                                                     child: const Text(
//                                                       "Map Number",
//                                                       style: TextStyle(
//                                                         fontSize: 16.0,
//                                                         color: Colors.white,
//                                                         //fontWeight: FontWeight.bold
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 )),
//                                           ),
//                                           Expanded(
//                                             child: Container(
//                                               margin: const EdgeInsets.only(
//                                                 left: 8,
//                                                 right: 8,
//                                                 top: 8,
//                                               ),
//                                               padding: const EdgeInsets.all(8),
//                                               alignment: Alignment.center,
//                                               height: size.height * 0.05,
//                                               // width: size.width * 0.99,
//                                               decoration: BoxDecoration(
//                                                   // shape: BoxShape.circle,
//                                                   borderRadius:
//                                                       BorderRadius.circular(10),
//                                                   boxShadow: const [
//                                                     BoxShadow(
//                                                         color: Color.fromARGB(255, 7, 59, 120),
//                                                         blurRadius: 10,
//                                                         offset:
//                                                             Offset(2.0, 5.0))
//                                                   ],
//                                                   gradient:
//                                                       const LinearGradient(
//                                                     colors: [
//                                                       Colors.white,
//                                                       Colors.white,
//                                                     ],
//                                                   )),

//                                               child: Align(
//                                                 alignment:
//                                                     Alignment.centerRight,
//                                                 child: Padding(
//                                                   padding:
//                                                       const EdgeInsets.all(2.0),
//                                                   child: TextFormField(
//                                                     //key: formkey4,
//                                                     controller: _mapNumber,
//                                                     style: const TextStyle(
//                                                         color: Color.fromARGB(255, 7, 59, 120),
//                                                         fontSize: 16),
//                                                     obscureText: false,
//                                                     // keyboardType: TextInputType.number,
//                                                     // decoration: InputDecoration(
//                                                     //   border: OutlineInputBorder(
//                                                     //     borderRadius: BorderRadius.circular(25),
//                                                     //   ),
//                                                     //   enabledBorder: OutlineInputBorder(
//                                                     //     borderSide: const BorderSide(
//                                                     //       color: Color.fromARGB(255, 7, 59, 120),
//                                                     //     ),
//                                                     //     borderRadius: BorderRadius.circular(25),
//                                                     //   ),
//                                                     //   hintText: 'Enter Amount',
//                                                     // ),
//                                                     validator: (value) {
//                                                       if (value!.isEmpty) {
//                                                         return "Please enter map number";
//                                                       } else {
//                                                         return null;
//                                                       }
//                                                     },
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                       Row(
//                                         children: [
//                                           Expanded(
//                                             child: Align(
//                                                 alignment: Alignment.centerLeft,
//                                                 child: Padding(
//                                                   padding:
//                                                       const EdgeInsets.only(
//                                                     left: 2.0,
//                                                     right: 2.0,
//                                                   ),
//                                                   child: Container(
//                                                     margin:
//                                                         const EdgeInsets.only(
//                                                       left: 8,
//                                                       right: 8,
//                                                       top: 8,
//                                                     ),
//                                                     padding:
//                                                         const EdgeInsets.all(8),
//                                                     alignment: Alignment.center,
//                                                     // height: size.height * 0.5,
//                                                     // width: size.width * 0.99,
//                                                     decoration: BoxDecoration(
//                                                         // shape: BoxShape.circle,
//                                                         borderRadius:
//                                                             BorderRadius
//                                                                 .circular(10),
//                                                         boxShadow: const [
//                                                           BoxShadow(
//                                                               color:
//                                                                   Color.fromARGB(255, 7, 59, 120),
//                                                               blurRadius: 10,
//                                                               offset: Offset(
//                                                                   2.0, 5.0))
//                                                         ],
//                                                         gradient:
//                                                             const LinearGradient(
//                                                           colors: [
//                                                             Color.fromARGB(255,
//                                                                 2, 92, 249),
//                                                             Color.fromARGB(255,
//                                                                 16, 1, 135),
//                                                           ],
//                                                         )),

//                                                     child: const Text(
//                                                       "Pole Number",
//                                                       style: TextStyle(
//                                                         fontSize: 16.0,
//                                                         color: Colors.white,
//                                                         //fontWeight: FontWeight.bold
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 )),
//                                           ),
//                                           Expanded(
//                                             child: Container(
//                                               margin: const EdgeInsets.only(
//                                                 left: 8,
//                                                 right: 8,
//                                                 top: 8,
//                                               ),
//                                               padding: const EdgeInsets.all(8),
//                                               alignment: Alignment.center,
//                                               height: size.height * 0.05,
//                                               // width: size.width * 0.99,
//                                               decoration: BoxDecoration(
//                                                   // shape: BoxShape.circle,
//                                                   borderRadius:
//                                                       BorderRadius.circular(10),
//                                                   boxShadow: const [
//                                                     BoxShadow(
//                                                         color: Color.fromARGB(255, 7, 59, 120),
//                                                         blurRadius: 10,
//                                                         offset:
//                                                             Offset(2.0, 5.0))
//                                                   ],
//                                                   gradient:
//                                                       const LinearGradient(
//                                                     colors: [
//                                                       Colors.white,
//                                                       Colors.white,
//                                                     ],
//                                                   )),

//                                               child: Align(
//                                                 alignment:
//                                                     Alignment.centerRight,
//                                                 child: Padding(
//                                                   padding:
//                                                       const EdgeInsets.all(2.0),
//                                                   child: TextFormField(
//                                                     //key: formkey4,
//                                                     controller: _poleNumber,
//                                                     style: const TextStyle(
//                                                         color: Color.fromARGB(255, 7, 59, 120),
//                                                         fontSize: 16),
//                                                     obscureText: false,
//                                                     // keyboardType: TextInputType.number,
//                                                     // decoration: InputDecoration(
//                                                     //   border: OutlineInputBorder(
//                                                     //     borderRadius: BorderRadius.circular(25),
//                                                     //   ),
//                                                     //   enabledBorder: OutlineInputBorder(
//                                                     //     borderSide: const BorderSide(
//                                                     //       color: Color.fromARGB(255, 7, 59, 120),
//                                                     //     ),
//                                                     //     borderRadius: BorderRadius.circular(25),
//                                                     //   ),
//                                                     //   hintText: 'Enter Amount',
//                                                     // ),
//                                                     validator: (value) {
//                                                       if (value!.isEmpty) {
//                                                         return "Please enter pole number";
//                                                       } else {
//                                                         return null;
//                                                       }
//                                                     },
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                       Row(
//                                         children: [
//                                           Expanded(
//                                             child: Align(
//                                                 alignment: Alignment.centerLeft,
//                                                 child: Padding(
//                                                   padding:
//                                                       const EdgeInsets.only(
//                                                     left: 2.0,
//                                                     right: 2.0,
//                                                   ),
//                                                   child: Container(
//                                                     margin:
//                                                         const EdgeInsets.only(
//                                                       left: 8,
//                                                       right: 8,
//                                                       top: 8,
//                                                     ),
//                                                     padding:
//                                                         const EdgeInsets.all(8),
//                                                     alignment: Alignment.center,
//                                                     // height: size.height * 0.5,
//                                                     // width: size.width * 0.99,
//                                                     decoration: BoxDecoration(
//                                                         // shape: BoxShape.circle,
//                                                         borderRadius:
//                                                             BorderRadius
//                                                                 .circular(10),
//                                                         boxShadow: const [
//                                                           BoxShadow(
//                                                               color:
//                                                                   Color.fromARGB(255, 7, 59, 120),
//                                                               blurRadius: 10,
//                                                               offset: Offset(
//                                                                   2.0, 5.0))
//                                                         ],
//                                                         gradient:
//                                                             const LinearGradient(
//                                                           colors: [
//                                                             Color.fromARGB(255,
//                                                                 2, 92, 249),
//                                                             Color.fromARGB(255,
//                                                                 16, 1, 135),
//                                                           ],
//                                                         )),

//                                                     child: const Text(
//                                                       "Man Hours",
//                                                       style: TextStyle(
//                                                         fontSize: 16.0,
//                                                         color: Colors.white,
//                                                         //fontWeight: FontWeight.bold
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 )),
//                                           ),
//                                           Expanded(
//                                             child: Container(
//                                               margin: const EdgeInsets.only(
//                                                 left: 8,
//                                                 right: 8,
//                                                 top: 8,
//                                               ),
//                                               padding: const EdgeInsets.all(8),
//                                               alignment: Alignment.center,
//                                               height: size.height * 0.05,
//                                               // width: size.width * 0.99,
//                                               decoration: BoxDecoration(
//                                                   // shape: BoxShape.circle,
//                                                   borderRadius:
//                                                       BorderRadius.circular(10),
//                                                   boxShadow: const [
//                                                     BoxShadow(
//                                                         color: Color.fromARGB(255, 7, 59, 120),
//                                                         blurRadius: 10,
//                                                         offset:
//                                                             Offset(2.0, 5.0))
//                                                   ],
//                                                   gradient:
//                                                       const LinearGradient(
//                                                     colors: [
//                                                       Colors.white,
//                                                       Colors.white,
//                                                     ],
//                                                   )),

//                                               child: Align(
//                                                 alignment:
//                                                     Alignment.centerRight,
//                                                 child: Padding(
//                                                   padding:
//                                                       const EdgeInsets.all(2.0),
//                                                   child: TextFormField(
//                                                     //key: formkey4,
//                                                     controller: _manHours,
//                                                     style: const TextStyle(
//                                                         color: Color.fromARGB(255, 7, 59, 120),
//                                                         fontSize: 16),
//                                                     obscureText: false,
//                                                     // keyboardType: TextInputType.number,
//                                                     // decoration: InputDecoration(
//                                                     //   border: OutlineInputBorder(
//                                                     //     borderRadius: BorderRadius.circular(25),
//                                                     //   ),
//                                                     //   enabledBorder: OutlineInputBorder(
//                                                     //     borderSide: const BorderSide(
//                                                     //       color: Color.fromARGB(255, 7, 59, 120),
//                                                     //     ),
//                                                     //     borderRadius: BorderRadius.circular(25),
//                                                     //   ),
//                                                     //   hintText: 'Enter Amount',
//                                                     // ),
//                                                     validator: (value) {
//                                                       if (value!.isEmpty) {
//                                                         return "Please enter man hours";
//                                                       } else {
//                                                         return null;
//                                                       }
//                                                     },
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                       Row(
//                                         children: [
//                                           Expanded(
//                                             child: Align(
//                                                 alignment: Alignment.centerLeft,
//                                                 child: Padding(
//                                                   padding:
//                                                       const EdgeInsets.only(
//                                                     left: 2.0,
//                                                     right: 2.0,
//                                                   ),
//                                                   child: Container(
//                                                     margin:
//                                                         const EdgeInsets.only(
//                                                       left: 8,
//                                                       right: 8,
//                                                       top: 8,
//                                                     ),
//                                                     padding:
//                                                         const EdgeInsets.all(8),
//                                                     alignment: Alignment.center,
//                                                     // height: size.height * 0.5,
//                                                     // width: size.width * 0.99,
//                                                     decoration: BoxDecoration(
//                                                         // shape: BoxShape.circle,
//                                                         borderRadius:
//                                                             BorderRadius
//                                                                 .circular(10),
//                                                         boxShadow: const [
//                                                           BoxShadow(
//                                                               color:
//                                                                   Color.fromARGB(255, 7, 59, 120),
//                                                               blurRadius: 10,
//                                                               offset: Offset(
//                                                                   2.0, 5.0))
//                                                         ],
//                                                         gradient:
//                                                             const LinearGradient(
//                                                           colors: [
//                                                             Color.fromARGB(255,
//                                                                 2, 92, 249),
//                                                             Color.fromARGB(255,
//                                                                 16, 1, 135),
//                                                           ],
//                                                         )),

//                                                     child: const Text(
//                                                       "Length",
//                                                       style: TextStyle(
//                                                         fontSize: 16.0,
//                                                         color: Colors.white,
//                                                         //fontWeight: FontWeight.bold
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 )),
//                                           ),
//                                           Expanded(
//                                             child: Container(
//                                               margin: const EdgeInsets.only(
//                                                 left: 8,
//                                                 right: 8,
//                                                 top: 8,
//                                               ),
//                                               padding: const EdgeInsets.all(8),
//                                               alignment: Alignment.center,
//                                               height: size.height * 0.05,
//                                               // width: size.width * 0.99,
//                                               decoration: BoxDecoration(
//                                                   // shape: BoxShape.circle,
//                                                   borderRadius:
//                                                       BorderRadius.circular(10),
//                                                   boxShadow: const [
//                                                     BoxShadow(
//                                                         color: Color.fromARGB(255, 7, 59, 120),
//                                                         blurRadius: 10,
//                                                         offset:
//                                                             Offset(2.0, 5.0))
//                                                   ],
//                                                   gradient:
//                                                       const LinearGradient(
//                                                     colors: [
//                                                       Colors.white,
//                                                       Colors.white,
//                                                     ],
//                                                   )),

//                                               child: Align(
//                                                 alignment:
//                                                     Alignment.centerRight,
//                                                 child: Padding(
//                                                   padding:
//                                                       const EdgeInsets.all(2.0),
//                                                   child: TextFormField(
//                                                     //key: formkey4,
//                                                     controller: _length,
//                                                     style: const TextStyle(
//                                                         color: Color.fromARGB(255, 7, 59, 120),
//                                                         fontSize: 16),
//                                                     obscureText: false,
//                                                     // keyboardType: TextInputType.number,
//                                                     // decoration: InputDecoration(
//                                                     //   border: OutlineInputBorder(
//                                                     //     borderRadius: BorderRadius.circular(25),
//                                                     //   ),
//                                                     //   enabledBorder: OutlineInputBorder(
//                                                     //     borderSide: const BorderSide(
//                                                     //       color: Color.fromARGB(255, 7, 59, 120),
//                                                     //     ),
//                                                     //     borderRadius: BorderRadius.circular(25),
//                                                     //   ),
//                                                     //   hintText: 'Enter Amount',
//                                                     // ),
//                                                     validator: (value) {
//                                                       if (value!.isEmpty) {
//                                                         return "Please enter length";
//                                                       } else {
//                                                         return null;
//                                                       }
//                                                     },
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                       Row(
//                                         children: [
//                                           Expanded(
//                                             child: Align(
//                                                 alignment: Alignment.centerLeft,
//                                                 child: Padding(
//                                                   padding:
//                                                       const EdgeInsets.only(
//                                                     left: 2.0,
//                                                     right: 2.0,
//                                                   ),
//                                                   child: Container(
//                                                     margin:
//                                                         const EdgeInsets.only(
//                                                       left: 8,
//                                                       right: 8,
//                                                       top: 8,
//                                                     ),
//                                                     padding:
//                                                         const EdgeInsets.all(8),
//                                                     alignment: Alignment.center,
//                                                     // height: size.height * 0.5,
//                                                     // width: size.width * 0.99,
//                                                     decoration: BoxDecoration(
//                                                         // shape: BoxShape.circle,
//                                                         borderRadius:
//                                                             BorderRadius
//                                                                 .circular(10),
//                                                         boxShadow: const [
//                                                           BoxShadow(
//                                                               color:
//                                                                   Color.fromARGB(255, 7, 59, 120),
//                                                               blurRadius: 10,
//                                                               offset: Offset(
//                                                                   2.0, 5.0))
//                                                         ],
//                                                         gradient:
//                                                             const LinearGradient(
//                                                           colors: [
//                                                             Color.fromARGB(255,
//                                                                 2, 92, 249),
//                                                             Color.fromARGB(255,
//                                                                 16, 1, 135),
//                                                           ],
//                                                         )),

//                                                     child: const Text(
//                                                       "Chemical Code",
//                                                       style: TextStyle(
//                                                         fontSize: 16.0,
//                                                         color: Colors.white,
//                                                         //fontWeight: FontWeight.bold
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 )),
//                                           ),
//                                           Expanded(
//                                             child: Container(
//                                               margin: const EdgeInsets.only(
//                                                 left: 8,
//                                                 right: 8,
//                                                 top: 8,
//                                               ),
//                                               padding: const EdgeInsets.all(8),
//                                               alignment: Alignment.center,
//                                               height: size.height * 0.05,
//                                               // width: size.width * 0.99,
//                                               decoration: BoxDecoration(
//                                                   // shape: BoxShape.circle,
//                                                   borderRadius:
//                                                       BorderRadius.circular(10),
//                                                   boxShadow: const [
//                                                     BoxShadow(
//                                                         color: Color.fromARGB(255, 7, 59, 120),
//                                                         blurRadius: 10,
//                                                         offset:
//                                                             Offset(2.0, 5.0))
//                                                   ],
//                                                   gradient:
//                                                       const LinearGradient(
//                                                     colors: [
//                                                       Colors.white,
//                                                       Colors.white,
//                                                     ],
//                                                   )),

//                                               child: Align(
//                                                 alignment:
//                                                     Alignment.centerRight,
//                                                 child: Padding(
//                                                   padding:
//                                                       const EdgeInsets.all(2.0),
//                                                   child: TextFormField(
//                                                     //key: formkey4,
//                                                     controller: _chemicalCode,
//                                                     style: const TextStyle(
//                                                         color: Color.fromARGB(255, 7, 59, 120),
//                                                         fontSize: 16),
//                                                     obscureText: false,
//                                                     // keyboardType: TextInputType.number,
//                                                     // decoration: InputDecoration(
//                                                     //   border: OutlineInputBorder(
//                                                     //     borderRadius: BorderRadius.circular(25),
//                                                     //   ),
//                                                     //   enabledBorder: OutlineInputBorder(
//                                                     //     borderSide: const BorderSide(
//                                                     //       color: Color.fromARGB(255, 7, 59, 120),
//                                                     //     ),
//                                                     //     borderRadius: BorderRadius.circular(25),
//                                                     //   ),
//                                                     //   hintText: 'Enter Amount',
//                                                     // ),
//                                                     validator: (value) {
//                                                       if (value!.isEmpty) {
//                                                         return "Please enter chemical code";
//                                                       } else {
//                                                         return null;
//                                                       }
//                                                     },
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                       Row(
//                                         children: [
//                                           IconButton(
//                                               icon: const Icon(Icons.delete),
//                                               iconSize: 30,
//                                               color: const Color.fromARGB(255, 7, 59, 120),
//                                               onPressed: () {
//                                                 // setState(() {
//                                                 //   numberOfDays.removeAt(index);
//                                                 // });
//                                               }),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                 );
//                               },
//                             ),
//                           ],
//                         ),
//                       ],
//                     )),
//                 const Align(
//                     alignment: Alignment.centerLeft,
//                     child: Padding(
//                       padding: EdgeInsets.only(
//                           left: 2.0, right: 2.0, bottom: 2.0, top: 20.0),
//                       child: Text(
//                         "Remarks",
//                         style: TextStyle(
//                           fontSize: 16.0,
//                           color: Color.fromARGB(255, 7, 59, 120),
//                           //fontWeight: FontWeight.bold
//                         ),
//                       ),
//                     )),
//                 Align(
//                   alignment: Alignment.centerRight,
//                   child: Padding(
//                     padding: const EdgeInsets.all(2.0),
//                     child: TextFormField(
//                       //  key: formkey5,
//                       controller: _remarks,
//                       style: const TextStyle(color: Color.fromARGB(255, 7, 59, 120), fontSize: 16),
//                       obscureText: false,
//                       keyboardType: TextInputType.number,
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(25),
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                           borderSide: const BorderSide(
//                             color: Color.fromARGB(255, 7, 59, 120),
//                           ),
//                           borderRadius: BorderRadius.circular(25),
//                         ),
//                         hintText: 'Enter Remarks',
//                       ),
//                       validator: (value) {
//                         if (value!.isEmpty) {
//                           return "Please enter Remarks";
//                         } else {
//                           return null;
//                         }
//                       },
//                     ),
//                   ),
//                 ),
//                 const Align(
//                     alignment: Alignment.centerLeft,
//                     child: Padding(
//                       padding: EdgeInsets.only(
//                           left: 2.0, right: 2.0, bottom: 2.0, top: 20.0),
//                       child: Text(
//                         "Foreman Digital Signature",
//                         style: TextStyle(
//                           fontSize: 16.0,
//                           color: Color.fromARGB(255, 7, 59, 120),
//                           //fontWeight: FontWeight.bold
//                         ),
//                       ),
//                     )),
//                 Align(
//                   alignment: Alignment.centerRight,
//                   child: Padding(
//                     padding: const EdgeInsets.all(2.0),
//                     child: TextFormField(
//                       //  key: formkey5,
//                       controller: _foremanDigitalSignature2,
//                       style: const TextStyle(color: Color.fromARGB(255, 7, 59, 120), fontSize: 16),
//                       obscureText: false,
//                       keyboardType: TextInputType.number,
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(25),
//                         ),
//                         enabledBorder: OutlineInputBorder(
//                           borderSide: const BorderSide(
//                             color: Color.fromARGB(255, 7, 59, 120),
//                           ),
//                           borderRadius: BorderRadius.circular(25),
//                         ),
//                         hintText: 'Enter Foreman Digital Signature',
//                       ),
//                       validator: (value) {
//                         if (value!.isEmpty) {
//                           return "Please enter Foreman Digital Signature";
//                         } else {
//                           return null;
//                         }
//                       },
//                     ),
//                   ),
//                 ),
//                 Container(
//                     margin: const EdgeInsets.only(
//                         left: 6, right: 6, top: 20.0, bottom: 10),
//                     child: InkWell(
//                       onTap: () {
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
//                                   color: Color.fromARGB(
//                                                   255, 3, 47, 97),
//                                               blurRadius: 5,
//                                               offset: Offset(2.0, 5.0))
//                                         ],
//                                         gradient: const LinearGradient(
//                                           colors: [
//                                             Color.fromARGB(255, 7, 59, 120),
//                                             Color.fromARGB(255, 7, 59, 120)
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

//   void _runFilter(String enteredKeyword) {
//     // List<Map<String, dynamic>> results = [];
//     if (enteredKeyword.isEmpty) {
//       // if the search field is empty or only contains white-space, we'll display all users
//       // results = listOfColumns1;
//     } else {
//       // results = listOfColumns1
//       // .where((user) =>
//       //     user["USER_NAME"]!
//       //         .toLowerCase()
//       //         .contains(enteredKeyword.toLowerCase()) ||
//       //     user["NAME"]!
//       //         .toLowerCase()
//       //         .contains(enteredKeyword.toLowerCase()) ||
//       //     user["USER_NAME"]!.contains('USER NAME'))
//       // .toList();
//       // we use the toLowerCase() method to make it case-insensitive
//     }

//     // Refresh the UI
//     setState(() {
//       // listOfColumns = results;
//     });
//   }

//   DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
//       value: item,
//       child: Text(item,
//           style: const TextStyle(
//             fontWeight: FontWeight.normal,
//             fontSize: 20,
//           )));

//   void getNumberOfEmployeesLength() {
//     if (numberOfEmployees == '1') {
//       numberOfEmployeesLength = 1;
//     } else if (numberOfEmployees == '2') {
//       numberOfEmployeesLength = 2;
//     } else if (numberOfEmployees == '3') {
//       numberOfEmployeesLength = 3;
//     } else if (numberOfEmployees == '4') {
//       numberOfEmployeesLength = 4;
//     } else if (numberOfEmployees == '5') {
//       numberOfEmployeesLength = 5;
//     } else if (numberOfEmployees == '6') {
//       numberOfEmployeesLength = 6;
//     } else if (numberOfEmployees == '7') {
//       numberOfEmployeesLength = 7;
//     } else if (numberOfEmployees == '8') {
//       numberOfEmployeesLength = 8;
//     } else if (numberOfEmployees == '9') {
//       numberOfEmployeesLength = 9;
//     } else if (numberOfEmployees == '10') {
//       numberOfEmployeesLength = 10;
//     }
//   }

//   void getNumberOfEquipmentLength() {
//     if (numberOfEquipment == '1') {
//       numberOfEquipmentLength = 1;
//     } else if (numberOfEquipment == '2') {
//       numberOfEquipmentLength = 2;
//     } else if (numberOfEquipment == '3') {
//       numberOfEquipmentLength = 3;
//     } else if (numberOfEquipment == '4') {
//       numberOfEquipmentLength = 4;
//     } else if (numberOfEquipment == '5') {
//       numberOfEquipmentLength = 5;
//     } else if (numberOfEquipment == '6') {
//       numberOfEquipmentLength = 6;
//     } else if (numberOfEquipment == '7') {
//       numberOfEquipmentLength = 7;
//     } else if (numberOfEquipment == '8') {
//       numberOfEquipmentLength = 8;
//     } else if (numberOfEquipment == '9') {
//       numberOfEquipmentLength = 9;
//     } else if (numberOfEquipment == '10') {
//       numberOfEquipmentLength = 10;
//     }
//   }

//   void getNumberOfActivityLength() {
//     if (numberOfActivities == '1') {
//       numberOfActivityLength = 1;
//     } else if (numberOfActivities == '2') {
//       numberOfActivityLength = 2;
//     } else if (numberOfActivities == '3') {
//       numberOfActivityLength = 3;
//     } else if (numberOfActivities == '4') {
//       numberOfActivityLength = 4;
//     } else if (numberOfActivities == '5') {
//       numberOfActivityLength = 5;
//     } else if (numberOfActivities == '6') {
//       numberOfActivityLength = 6;
//     } else if (numberOfActivities == '7') {
//       numberOfActivityLength = 7;
//     } else if (numberOfActivities == '8') {
//       numberOfActivityLength = 8;
//     } else if (numberOfActivities == '9') {
//       numberOfActivityLength = 9;
//     } else if (numberOfActivities == '10') {
//       numberOfActivityLength = 10;
//     }
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
//                       const ContractorDispatchDashboard()));
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
//               Navigator.of(context).push(MaterialPageRoute(
//                   builder: (BuildContext context) =>
//                       const DailyHerbicideApplicationFormContractor()));
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
//               Navigator.pop(context);
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
//               Navigator.of(context).push(MaterialPageRoute(
//                   builder: (BuildContext context) =>
//                       const MixingInventoryFormContractor(id: '',)));
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
//               Navigator.of(context).pushReplacement(MaterialPageRoute(
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
