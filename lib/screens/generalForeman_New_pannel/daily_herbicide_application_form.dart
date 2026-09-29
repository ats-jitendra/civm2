// import 'dart:convert';
// import 'dart:io';
// import 'package:civm/screens/contractor_pannel/change_order_contractor.dart';
// import 'package:civm/screens/contractor_pannel/contractor_dispatch_dashboard.dart';
// import 'package:civm/screens/contractor_pannel/invoice_form_contractor.dart';
// import 'package:civm/screens/contractor_pannel/mixing_inventory_form_contractor.dart';
// import 'package:civm/screens/contractor_pannel/power_time_form.dart';
// import 'package:civm/screens/contractor_pannel/row_maintenance_progress_contractor.dart';
// import 'package:civm/screens/contractor_pannel/change_order_pending_contractor.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
// import 'package:image_picker/image_picker.dart';
// import 'package:flutter_profile_picture/flutter_profile_picture.dart';

// import '../login_page.dart';

// class DailyHerbicideApplicationFormContractor extends StatefulWidget {
//   const DailyHerbicideApplicationFormContractor({Key? key}) : super(key: key);

//   @override
//   State<DailyHerbicideApplicationFormContractor> createState() =>
//       _DailyHerbicideApplicationFormContractorState();
// }

// class _DailyHerbicideApplicationFormContractorState
//     extends State<DailyHerbicideApplicationFormContractor> {
//   // final List<Widget> _children = [
//   //   RowMaintenancePlan(),
//   //   // BottomNavigationHomePage(),
//   //   // BottomNavigationAccountPage()
//   // ];

//   List<List<Map<String, dynamic>>> tablesList = [];
//   List<String> numberOfDays = [];
//   List<List<List<TextEditingController>>> controllerList = [];
//   // ignore: non_constant_identifier_names
//   List<String> select_numberOfHerbicides = [
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
//   String? numberOfHerbicides;

//   int numberOfHerbicidesLength = 0;
//   int numberOfEquipmentLength = 0;
//   int numberOfLobourLength = 0;
//   int numberOfNumberOfApplicationsLength = 0;
//   int numberOfWeatherConditionsAtSiteLength = 0;
//   int numberOfNumberOfApplicantsLength = 0;
//   // ignore: non_constant_identifier_names
//   List<String> select_numberOfEquipment = [
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
//   String? numberOfEquipment;

//   // ignore: non_constant_identifier_names
//   List<String> select_numberOfLabours = [
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
//   String? numberOfLabours;

//   // ignore: non_constant_identifier_names
//   List<String> select_weatherConditionsAtSite = [
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
//   String? weatherConditionsAtSite;

//   // ignore: non_constant_identifier_names
//   List<String> select_numberOfApplications = [
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
//   String? numberOfApplications;

//   // ignore: non_constant_identifier_names
//   List<String> select_numberOfApplicants = [
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
//   String? numberOfApplicants;

//   final TextEditingController _jobNumber = TextEditingController();
//   final TextEditingController _foreman = TextEditingController();
//   final TextEditingController _substation = TextEditingController();
//   final TextEditingController _mapLineNumber = TextEditingController();
//   final TextEditingController _subNumber = TextEditingController();
//   final TextEditingController _circuitNumber = TextEditingController();

//   final TextEditingController _sectionTownshipRange = TextEditingController();
//   final TextEditingController _productName = TextEditingController();
//   final TextEditingController _epnNumber = TextEditingController();
//   final TextEditingController _appliedRatePerGallon = TextEditingController();
//   final TextEditingController _gallonOfSolution = TextEditingController();
//   final TextEditingController _rowWidth20 = TextEditingController();
//   final TextEditingController _rowWidth30 = TextEditingController();
//   final TextEditingController _rowWidth40 = TextEditingController();
//   final TextEditingController _rowWidth50 = TextEditingController();
//   final TextEditingController _rowWidth60 = TextEditingController();
//   final TextEditingController _rowWidth70 = TextEditingController();
//   final TextEditingController _rowWidth80 = TextEditingController();
//   final TextEditingController _acersPerSection = TextEditingController();
//   final TextEditingController _totalGallonsOfSolution = TextEditingController();
//   final TextEditingController _totalAcersApplied = TextEditingController();

//   final TextEditingController _equipment = TextEditingController();
//   final TextEditingController _equipmentNumber = TextEditingController();
//   final TextEditingController _quantityEquipment = TextEditingController();
//   final TextEditingController _hoursEachEquipment = TextEditingController();
//   final TextEditingController _totalHoursEquipment = TextEditingController();

//   final TextEditingController _labor = TextEditingController();
//   final TextEditingController _quantityLabor = TextEditingController();
//   final TextEditingController _hoursEachLabor = TextEditingController();
//   final TextEditingController _totalHoursLabor = TextEditingController();

//   final TextEditingController _applicationEndTime = TextEditingController();
//   final TextEditingController _applicationStartTime = TextEditingController();
//   final TextEditingController _breakStartTime = TextEditingController();
//   final TextEditingController _reasonTimeOfApplication =
//       TextEditingController();

//   final TextEditingController _time = TextEditingController();
//   final TextEditingController _temperature = TextEditingController();
//   final TextEditingController _windSpeed = TextEditingController();
//   final TextEditingController _windDirection = TextEditingController();

//   final TextEditingController _applicantsName = TextEditingController();
//   final TextEditingController _applicantLicenseNumber = TextEditingController();
//   final TextEditingController _applicantDigitalSignature =
//       TextEditingController();

//   List<String> menu = [];

//   String datetime = DateTime.now().toString();

//   File? image;

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
//           title: const Text('Daily Herbicide Application Form'),
//           backgroundColor: const Color.fromARGB(255, 7, 59, 120),
//         ),
//         drawer: DrawerManu(menu: menu),
//         body: SingleChildScrollView(
//             child: Column(children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Container(
//               padding: const EdgeInsets.all(10),
//               alignment: Alignment.center,
//               width: size.width * 0.99,
//               // width: MediaQuery.of(context).size.width,
//               // height: 40,
//               decoration: const BoxDecoration(
//                   // shape: BoxShape.circle,
//                   //borderRadius: BorderRadius.circular(25),
//                   boxShadow: [
//                     BoxShadow(
//                         color: Color.fromARGB(255, 7, 59, 120),
//                         blurRadius: 5,
//                         offset: Offset(2.0, 5.0))
//                   ],
//                   color: Colors.black,
//                   gradient: LinearGradient(
//                     colors: [
//                       Colors.white,
//                       Colors.white,
//                     ],
//                   )),
//               child: Row(children: [
//                 Align(
//                   alignment: Alignment.centerLeft,
//                   child: Text(
//                     datetime,
//                     textAlign: TextAlign.left,
//                     style: const TextStyle(
//                       color: Color.fromARGB(255, 7, 59, 120),
//                       fontWeight: FontWeight.bold,
//                       fontSize: 20,
//                     ),
//                   ),
//                 ),
//               ]),
//             ),
//           ),
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
//                         "Job Number",
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
//                         hintText: 'Enter Job number',
//                       ),
//                       validator: (value) {
//                         if (value!.isEmpty) {
//                           return "Please enter Job number";
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
//                         "Foreman",
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
//                       controller: _foreman,
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
//                         hintText: 'Enter Foreman',
//                       ),
//                       validator: (value) {
//                         if (value!.isEmpty) {
//                           return "Please enter Foreman";
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
//                         "Substation",
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
//                       controller: _substation,
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
//                         hintText: 'Enter Substation',
//                       ),
//                       validator: (value) {
//                         if (value!.isEmpty) {
//                           return "Please enter Substation";
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
//                         "Map/Line Number",
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
//                       controller: _mapLineNumber,
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
//                         hintText: 'Enter Map/Line Number',
//                       ),
//                       validator: (value) {
//                         if (value!.isEmpty) {
//                           return "Please enter Map/Line Number";
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
//                         "Sub Number",
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
//                       controller: _subNumber,
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
//                         hintText: 'Enter Sub Number',
//                       ),
//                       validator: (value) {
//                         if (value!.isEmpty) {
//                           return "Please enter Sub Number";
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
//                         "Circuit Number",
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
//                       controller: _circuitNumber,
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
//                         hintText: 'Enter Circuit Number',
//                       ),
//                       validator: (value) {
//                         if (value!.isEmpty) {
//                           return "Please enter Circuit Number";
//                         } else {
//                           return null;
//                         }
//                       },
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Container(
//               margin:
//                   const EdgeInsets.only(left: 8, right: 8, top: 10, bottom: 8),
//               padding: const EdgeInsets.all(8),
//               alignment: Alignment.center,
//               // height: size.height * 0.5,
//               width: size.width * 0.99,
//               decoration: BoxDecoration(
//                   // shape: BoxShape.circle,
//                   borderRadius: BorderRadius.circular(10),
//                   boxShadow: const [
//                     BoxShadow(
//                         color: Color.fromARGB(255, 7, 59, 120),
//                         blurRadius: 10,
//                         offset: Offset(2.0, 5.0))
//                   ],
//                   gradient: const LinearGradient(
//                     colors: [
//                       Color.fromARGB(255, 255, 255, 255),
//                       Color.fromARGB(255, 255, 255, 255),
//                     ],
//                   )),
//               child: Column(
//                 children: [
//                   Container(
//                     padding: const EdgeInsets.all(10),
//                     alignment: Alignment.center,
//                     width: size.width * 0.99,
//                     // width: MediaQuery.of(context).size.width,
//                     // height: 40,
//                     decoration: const BoxDecoration(
//                         // shape: BoxShape.circle,
//                         //borderRadius: BorderRadius.circular(25),
//                         boxShadow: [
//                           BoxShadow(
//                               color: Color.fromARGB(
//                                                   255, 3, 47, 97),
//                                               blurRadius: 5,
//                                               offset: Offset(2.0, 5.0))
//                                         ],
//                                         gradient: LinearGradient(
//                                           colors: [
//                                             Color.fromARGB(255, 7, 59, 120),
//                                             Color.fromARGB(255, 7, 59, 120)
//                           ],
//                         )),
//                     child: const Row(children: [
//                       Align(
//                         alignment: Alignment.centerLeft,
//                         child: Text(
//                           "Herbicide",
//                           textAlign: TextAlign.left,
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 20,
//                           ),
//                         ),
//                       ),
//                     ]),
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
//                                 "Select Number Of Herbicides",
//                                 style: TextStyle(
//                                     fontSize: 16.0, color: Color.fromARGB(255, 7, 59, 120)),
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
//                                   color: const Color.fromARGB(255, 7, 59, 120),
//                                 ),
//                               ),

//                               child: DropdownButtonHideUnderline(
//                                 child: DropdownButtonFormField<String>(
//                                   hint: const Text('Select'),
//                                   dropdownColor:
//                                       Colors.white,
//                                   value: numberOfHerbicides,
//                                   style: const TextStyle(
//                                       color: Color.fromARGB(255, 7, 59, 120), fontSize: 16),
//                                   icon: const Icon(
//                                     Icons.arrow_drop_down,
//                                     color: Color.fromARGB(255, 7, 59, 120),
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
//                                   items: select_numberOfHerbicides
//                                       .map(buildMenuItem)
//                                       .toList(),
//                                   onChanged: (value) {
//                                     numberOfHerbicides = value;
//                                     setState(() {
//                                       getNumberOfHerbicideLength();
//                                     });
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
//                   ListView.builder(
//                     shrinkWrap: true,
//                     // itemCount: 1,
//                     // itemCount:  getDaysInBetween().attractions.length,
//                     itemCount: numberOfHerbicidesLength,
//                     physics: const NeverScrollableScrollPhysics(),
//                     itemBuilder: (BuildContext context, int index) {
//                       return Container(
//                         margin: const EdgeInsets.only(
//                             left: 8, right: 8, top: 10, bottom: 8),
//                         padding: const EdgeInsets.all(8),
//                         alignment: Alignment.center,
//                         // height: size.height * 0.5,
//                         width: size.width * 0.99,
//                         decoration: BoxDecoration(
//                             // shape: BoxShape.circle,
//                             borderRadius: BorderRadius.circular(10),
//                             boxShadow: const [
//                               BoxShadow(
//                                   color: Color.fromARGB(255, 7, 59, 120),
//                                   blurRadius: 10,
//                                   offset: Offset(2.0, 5.0))
//                             ],
//                             gradient: const LinearGradient(
//                               colors: [
//                                 Color.fromARGB(255, 255, 255, 255),
//                                 Color.fromARGB(255, 255, 255, 255),
//                               ],
//                             )),

//                         child: Column(
//                           children: [
//                             const Align(
//                                 alignment: Alignment.centerLeft,
//                                 child: Padding(
//                                   padding: EdgeInsets.only(
//                                       left: 2.0,
//                                       right: 2.0,
//                                       bottom: 2.0,
//                                       top: 20.0),
//                                   child: Text(
//                                     "Section township Range",
//                                     style: TextStyle(
//                                       fontSize: 16.0,
//                                       color: Color.fromARGB(255, 7, 59, 120),
//                                       //fontWeight: FontWeight.bold
//                                     ),
//                                   ),
//                                 )),
//                             Align(
//                               alignment: Alignment.centerRight,
//                               child: Padding(
//                                 padding: const EdgeInsets.all(2.0),
//                                 child: TextFormField(
//                                   //key: formkey4,
//                                   controller: _sectionTownshipRange,
//                                   style: const TextStyle(
//                                       color: Color.fromARGB(255, 7, 59, 120), fontSize: 16),
//                                   obscureText: false,
//                                   keyboardType: TextInputType.number,
//                                   decoration: InputDecoration(
//                                     border: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(25),
//                                     ),
//                                     enabledBorder: OutlineInputBorder(
//                                       borderSide: const BorderSide(
//                                         color: Color.fromARGB(255, 7, 59, 120),
//                                       ),
//                                       borderRadius: BorderRadius.circular(25),
//                                     ),
//                                     hintText: 'Enter Section township Range',
//                                   ),
//                                   validator: (value) {
//                                     if (value!.isEmpty) {
//                                       return "Please enter Section township Range";
//                                     } else {
//                                       return null;
//                                     }
//                                   },
//                                 ),
//                               ),
//                             ),
//                             const Align(
//                                 alignment: Alignment.centerLeft,
//                                 child: Padding(
//                                   padding: EdgeInsets.only(
//                                       left: 2.0,
//                                       right: 2.0,
//                                       bottom: 2.0,
//                                       top: 20.0),
//                                   child: Text(
//                                     "Product Name",
//                                     style: TextStyle(
//                                       fontSize: 16.0,
//                                       color: Color.fromARGB(255, 7, 59, 120),
//                                       //fontWeight: FontWeight.bold
//                                     ),
//                                   ),
//                                 )),
//                             Align(
//                               alignment: Alignment.centerRight,
//                               child: Padding(
//                                 padding: const EdgeInsets.all(2.0),
//                                 child: TextFormField(
//                                   //key: formkey4,
//                                   controller: _productName,
//                                   style: const TextStyle(
//                                       color: Color.fromARGB(255, 7, 59, 120), fontSize: 16),
//                                   obscureText: false,
//                                   keyboardType: TextInputType.number,
//                                   decoration: InputDecoration(
//                                     border: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(25),
//                                     ),
//                                     enabledBorder: OutlineInputBorder(
//                                       borderSide: const BorderSide(
//                                         color: Color.fromARGB(255, 7, 59, 120),
//                                       ),
//                                       borderRadius: BorderRadius.circular(25),
//                                     ),
//                                     hintText: 'Enter Product Name',
//                                   ),
//                                   validator: (value) {
//                                     if (value!.isEmpty) {
//                                       return "Please enter Product Name";
//                                     } else {
//                                       return null;
//                                     }
//                                   },
//                                 ),
//                               ),
//                             ),
//                             const Align(
//                                 alignment: Alignment.centerLeft,
//                                 child: Padding(
//                                   padding: EdgeInsets.only(
//                                       left: 2.0,
//                                       right: 2.0,
//                                       bottom: 2.0,
//                                       top: 20.0),
//                                   child: Text(
//                                     "EPN Number",
//                                     style: TextStyle(
//                                       fontSize: 16.0,
//                                       color: Color.fromARGB(255, 7, 59, 120),
//                                       //fontWeight: FontWeight.bold
//                                     ),
//                                   ),
//                                 )),
//                             Align(
//                               alignment: Alignment.centerRight,
//                               child: Padding(
//                                 padding: const EdgeInsets.all(2.0),
//                                 child: TextFormField(
//                                   //  key: formkey5,
//                                   controller: _epnNumber,
//                                   style: const TextStyle(
//                                       color: Color.fromARGB(255, 7, 59, 120), fontSize: 16),
//                                   obscureText: false,
//                                   keyboardType: TextInputType.number,
//                                   decoration: InputDecoration(
//                                     border: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(25),
//                                     ),
//                                     enabledBorder: OutlineInputBorder(
//                                       borderSide: const BorderSide(
//                                         color: Color.fromARGB(255, 7, 59, 120),
//                                       ),
//                                       borderRadius: BorderRadius.circular(25),
//                                     ),
//                                     hintText: 'Enter EPN Number',
//                                   ),
//                                   validator: (value) {
//                                     if (value!.isEmpty) {
//                                       return "Please enter EPN Number";
//                                     } else {
//                                       return null;
//                                     }
//                                   },
//                                 ),
//                               ),
//                             ),
//                             const Align(
//                                 alignment: Alignment.centerLeft,
//                                 child: Padding(
//                                   padding: EdgeInsets.only(
//                                       left: 2.0,
//                                       right: 2.0,
//                                       bottom: 2.0,
//                                       top: 20.0),
//                                   child: Text(
//                                     "Applied Rate Per Gallon",
//                                     style: TextStyle(
//                                       fontSize: 16.0,
//                                       color: Color.fromARGB(255, 7, 59, 120),
//                                       //fontWeight: FontWeight.bold
//                                     ),
//                                   ),
//                                 )),
//                             Align(
//                               alignment: Alignment.centerRight,
//                               child: Padding(
//                                 padding: const EdgeInsets.all(2.0),
//                                 child: TextFormField(
//                                   //  key: formkey5,
//                                   controller: _appliedRatePerGallon,
//                                   style: const TextStyle(
//                                       color: Color.fromARGB(255, 7, 59, 120), fontSize: 16),
//                                   obscureText: false,
//                                   keyboardType: TextInputType.number,
//                                   decoration: InputDecoration(
//                                     border: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(25),
//                                     ),
//                                     enabledBorder: OutlineInputBorder(
//                                       borderSide: const BorderSide(
//                                         color: Color.fromARGB(255, 7, 59, 120),
//                                       ),
//                                       borderRadius: BorderRadius.circular(25),
//                                     ),
//                                     hintText: 'Enter Rate Per Gallon',
//                                   ),
//                                   validator: (value) {
//                                     if (value!.isEmpty) {
//                                       return "Please enter Rate Per Gallon";
//                                     } else {
//                                       return null;
//                                     }
//                                   },
//                                 ),
//                               ),
//                             ),
//                             const Align(
//                                 alignment: Alignment.centerLeft,
//                                 child: Padding(
//                                   padding: EdgeInsets.only(
//                                       left: 2.0,
//                                       right: 2.0,
//                                       bottom: 2.0,
//                                       top: 20.0),
//                                   child: Text(
//                                     "Gallon oF Solution",
//                                     style: TextStyle(
//                                       fontSize: 16.0,
//                                       color: Color.fromARGB(255, 7, 59, 120),
//                                       //fontWeight: FontWeight.bold
//                                     ),
//                                   ),
//                                 )),
//                             Align(
//                               alignment: Alignment.centerRight,
//                               child: Padding(
//                                 padding: const EdgeInsets.all(2.0),
//                                 child: TextFormField(
//                                   //  key: formkey5,
//                                   controller: _gallonOfSolution,
//                                   style: const TextStyle(
//                                       color: Color.fromARGB(255, 7, 59, 120), fontSize: 16),
//                                   obscureText: false,
//                                   keyboardType: TextInputType.number,
//                                   decoration: InputDecoration(
//                                     border: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(25),
//                                     ),
//                                     enabledBorder: OutlineInputBorder(
//                                       borderSide: const BorderSide(
//                                         color: Color.fromARGB(255, 7, 59, 120),
//                                       ),
//                                       borderRadius: BorderRadius.circular(25),
//                                     ),
//                                     hintText: 'Enter Gallon oF Solution',
//                                   ),
//                                   validator: (value) {
//                                     if (value!.isEmpty) {
//                                       return "Please enter Gallon oF Solution";
//                                     } else {
//                                       return null;
//                                     }
//                                   },
//                                 ),
//                               ),
//                             ),
//                             const Align(
//                                 alignment: Alignment.centerLeft,
//                                 child: Padding(
//                                   padding: EdgeInsets.only(
//                                       left: 2.0,
//                                       right: 2.0,
//                                       bottom: 2.0,
//                                       top: 20.0),
//                                   child: Text(
//                                     "Row Width 20",
//                                     style: TextStyle(
//                                       fontSize: 16.0,
//                                       color: Color.fromARGB(255, 7, 59, 120),
//                                       //fontWeight: FontWeight.bold
//                                     ),
//                                   ),
//                                 )),
//                             Align(
//                               alignment: Alignment.centerRight,
//                               child: Padding(
//                                 padding: const EdgeInsets.all(2.0),
//                                 child: TextFormField(
//                                   //  key: formkey5,
//                                   controller: _rowWidth20,
//                                   style: const TextStyle(
//                                       color: Color.fromARGB(255, 7, 59, 120), fontSize: 16),
//                                   obscureText: false,
//                                   keyboardType: TextInputType.number,
//                                   decoration: InputDecoration(
//                                     border: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(25),
//                                     ),
//                                     enabledBorder: OutlineInputBorder(
//                                       borderSide: const BorderSide(
//                                         color: Color.fromARGB(255, 7, 59, 120),
//                                       ),
//                                       borderRadius: BorderRadius.circular(25),
//                                     ),
//                                     hintText: 'Enter Row Width 20',
//                                   ),
//                                   validator: (value) {
//                                     if (value!.isEmpty) {
//                                       return "Please enter Row Width 20";
//                                     } else {
//                                       return null;
//                                     }
//                                   },
//                                 ),
//                               ),
//                             ),
//                             const Align(
//                                 alignment: Alignment.centerLeft,
//                                 child: Padding(
//                                   padding: EdgeInsets.only(
//                                       left: 2.0,
//                                       right: 2.0,
//                                       bottom: 2.0,
//                                       top: 20.0),
//                                   child: Text(
//                                     "Row Width 30",
//                                     style: TextStyle(
//                                       fontSize: 16.0,
//                                       color: Color.fromARGB(255, 7, 59, 120),
//                                       //fontWeight: FontWeight.bold
//                                     ),
//                                   ),
//                                 )),
//                             Align(
//                               alignment: Alignment.centerRight,
//                               child: Padding(
//                                 padding: const EdgeInsets.all(2.0),
//                                 child: TextFormField(
//                                   //  key: formkey5,
//                                   controller: _rowWidth30,
//                                   style: const TextStyle(
//                                       color: Color.fromARGB(255, 7, 59, 120), fontSize: 16),
//                                   obscureText: false,
//                                   keyboardType: TextInputType.number,
//                                   decoration: InputDecoration(
//                                     border: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(25),
//                                     ),
//                                     enabledBorder: OutlineInputBorder(
//                                       borderSide: const BorderSide(
//                                         color: Color.fromARGB(255, 7, 59, 120),
//                                       ),
//                                       borderRadius: BorderRadius.circular(25),
//                                     ),
//                                     hintText: 'Enter Row Width 30',
//                                   ),
//                                   validator: (value) {
//                                     if (value!.isEmpty) {
//                                       return "Please enter Row Width 30";
//                                     } else {
//                                       return null;
//                                     }
//                                   },
//                                 ),
//                               ),
//                             ),
//                             const Align(
//                                 alignment: Alignment.centerLeft,
//                                 child: Padding(
//                                   padding: EdgeInsets.only(
//                                       left: 2.0,
//                                       right: 2.0,
//                                       bottom: 2.0,
//                                       top: 20.0),
//                                   child: Text(
//                                     "Row Width 40",
//                                     style: TextStyle(
//                                       fontSize: 16.0,
//                                       color: Color.fromARGB(255, 7, 59, 120),
//                                       //fontWeight: FontWeight.bold
//                                     ),
//                                   ),
//                                 )),
//                             Align(
//                               alignment: Alignment.centerRight,
//                               child: Padding(
//                                 padding: const EdgeInsets.all(2.0),
//                                 child: TextFormField(
//                                   //  key: formkey5,
//                                   controller: _rowWidth40,
//                                   style: const TextStyle(
//                                       color: Color.fromARGB(255, 7, 59, 120), fontSize: 16),
//                                   obscureText: false,
//                                   keyboardType: TextInputType.number,
//                                   decoration: InputDecoration(
//                                     border: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(25),
//                                     ),
//                                     enabledBorder: OutlineInputBorder(
//                                       borderSide: const BorderSide(
//                                         color: Color.fromARGB(255, 7, 59, 120),
//                                       ),
//                                       borderRadius: BorderRadius.circular(25),
//                                     ),
//                                     hintText: 'Enter Row Width 40',
//                                   ),
//                                   validator: (value) {
//                                     if (value!.isEmpty) {
//                                       return "Please enter Row Width 40";
//                                     } else {
//                                       return null;
//                                     }
//                                   },
//                                 ),
//                               ),
//                             ),
//                             const Align(
//                                 alignment: Alignment.centerLeft,
//                                 child: Padding(
//                                   padding: EdgeInsets.only(
//                                       left: 2.0,
//                                       right: 2.0,
//                                       bottom: 2.0,
//                                       top: 20.0),
//                                   child: Text(
//                                     "Row Width 50",
//                                     style: TextStyle(
//                                       fontSize: 16.0,
//                                       color: Color.fromARGB(255, 7, 59, 120),
//                                       //fontWeight: FontWeight.bold
//                                     ),
//                                   ),
//                                 )),
//                             Align(
//                               alignment: Alignment.centerRight,
//                               child: Padding(
//                                 padding: const EdgeInsets.all(2.0),
//                                 child: TextFormField(
//                                   //  key: formkey5,
//                                   controller: _rowWidth50,
//                                   style: const TextStyle(
//                                       color: Color.fromARGB(255, 7, 59, 120), fontSize: 16),
//                                   obscureText: false,
//                                   keyboardType: TextInputType.number,
//                                   decoration: InputDecoration(
//                                     border: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(25),
//                                     ),
//                                     enabledBorder: OutlineInputBorder(
//                                       borderSide: const BorderSide(
//                                         color: Color.fromARGB(255, 7, 59, 120),
//                                       ),
//                                       borderRadius: BorderRadius.circular(25),
//                                     ),
//                                     hintText: 'Enter Row Width 50',
//                                   ),
//                                   validator: (value) {
//                                     if (value!.isEmpty) {
//                                       return "Please enter Row Width 50";
//                                     } else {
//                                       return null;
//                                     }
//                                   },
//                                 ),
//                               ),
//                             ),
//                             const Align(
//                                 alignment: Alignment.centerLeft,
//                                 child: Padding(
//                                   padding: EdgeInsets.only(
//                                       left: 2.0,
//                                       right: 2.0,
//                                       bottom: 2.0,
//                                       top: 20.0),
//                                   child: Text(
//                                     "Row Width 60",
//                                     style: TextStyle(
//                                       fontSize: 16.0,
//                                       color: Color.fromARGB(255, 7, 59, 120),
//                                       //fontWeight: FontWeight.bold
//                                     ),
//                                   ),
//                                 )),
//                             Align(
//                               alignment: Alignment.centerRight,
//                               child: Padding(
//                                 padding: const EdgeInsets.all(2.0),
//                                 child: TextFormField(
//                                   //  key: formkey5,
//                                   controller: _rowWidth60,
//                                   style: const TextStyle(
//                                       color: Color.fromARGB(255, 7, 59, 120), fontSize: 16),
//                                   obscureText: false,
//                                   keyboardType: TextInputType.number,
//                                   decoration: InputDecoration(
//                                     border: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(25),
//                                     ),
//                                     enabledBorder: OutlineInputBorder(
//                                       borderSide: const BorderSide(
//                                         color: Color.fromARGB(255, 7, 59, 120),
//                                       ),
//                                       borderRadius: BorderRadius.circular(25),
//                                     ),
//                                     hintText: 'Enter Row Width 60',
//                                   ),
//                                   validator: (value) {
//                                     if (value!.isEmpty) {
//                                       return "Please enter Row Width 60";
//                                     } else {
//                                       return null;
//                                     }
//                                   },
//                                 ),
//                               ),
//                             ),
//                             const Align(
//                                 alignment: Alignment.centerLeft,
//                                 child: Padding(
//                                   padding: EdgeInsets.only(
//                                       left: 2.0,
//                                       right: 2.0,
//                                       bottom: 2.0,
//                                       top: 20.0),
//                                   child: Text(
//                                     "Row Width 70",
//                                     style: TextStyle(
//                                       fontSize: 16.0,
//                                       color: Color.fromARGB(255, 7, 59, 120),
//                                       //fontWeight: FontWeight.bold
//                                     ),
//                                   ),
//                                 )),
//                             Align(
//                               alignment: Alignment.centerRight,
//                               child: Padding(
//                                 padding: const EdgeInsets.all(2.0),
//                                 child: TextFormField(
//                                   //  key: formkey5,
//                                   controller: _rowWidth70,
//                                   style: const TextStyle(
//                                       color: Color.fromARGB(255, 7, 59, 120), fontSize: 16),
//                                   obscureText: false,
//                                   keyboardType: TextInputType.number,
//                                   decoration: InputDecoration(
//                                     border: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(25),
//                                     ),
//                                     enabledBorder: OutlineInputBorder(
//                                       borderSide: const BorderSide(
//                                         color: Color.fromARGB(255, 7, 59, 120),
//                                       ),
//                                       borderRadius: BorderRadius.circular(25),
//                                     ),
//                                     hintText: 'Enter Row Width 70',
//                                   ),
//                                   validator: (value) {
//                                     if (value!.isEmpty) {
//                                       return "Please enter Row Width 70";
//                                     } else {
//                                       return null;
//                                     }
//                                   },
//                                 ),
//                               ),
//                             ),
//                             const Align(
//                                 alignment: Alignment.centerLeft,
//                                 child: Padding(
//                                   padding: EdgeInsets.only(
//                                       left: 2.0,
//                                       right: 2.0,
//                                       bottom: 2.0,
//                                       top: 20.0),
//                                   child: Text(
//                                     "Row Width 80",
//                                     style: TextStyle(
//                                       fontSize: 16.0,
//                                       color: Color.fromARGB(255, 7, 59, 120),
//                                       //fontWeight: FontWeight.bold
//                                     ),
//                                   ),
//                                 )),
//                             Align(
//                               alignment: Alignment.centerRight,
//                               child: Padding(
//                                 padding: const EdgeInsets.all(2.0),
//                                 child: TextFormField(
//                                   //  key: formkey5,
//                                   controller: _rowWidth80,
//                                   style: const TextStyle(
//                                       color: Color.fromARGB(255, 7, 59, 120), fontSize: 16),
//                                   obscureText: false,
//                                   keyboardType: TextInputType.number,
//                                   decoration: InputDecoration(
//                                     border: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(25),
//                                     ),
//                                     enabledBorder: OutlineInputBorder(
//                                       borderSide: const BorderSide(
//                                         color: Color.fromARGB(255, 7, 59, 120),
//                                       ),
//                                       borderRadius: BorderRadius.circular(25),
//                                     ),
//                                     hintText: 'Enter Row Width 80',
//                                   ),
//                                   validator: (value) {
//                                     if (value!.isEmpty) {
//                                       return "Please enter Row Width 80";
//                                     } else {
//                                       return null;
//                                     }
//                                   },
//                                 ),
//                               ),
//                             ),
//                             const Align(
//                                 alignment: Alignment.centerLeft,
//                                 child: Padding(
//                                   padding: EdgeInsets.only(
//                                       left: 2.0,
//                                       right: 2.0,
//                                       bottom: 2.0,
//                                       top: 20.0),
//                                   child: Text(
//                                     "Acers Per Section",
//                                     style: TextStyle(
//                                       fontSize: 16.0,
//                                       color: Color.fromARGB(255, 7, 59, 120),
//                                       //fontWeight: FontWeight.bold
//                                     ),
//                                   ),
//                                 )),
//                             Align(
//                               alignment: Alignment.centerRight,
//                               child: Padding(
//                                 padding: const EdgeInsets.all(2.0),
//                                 child: TextFormField(
//                                   //  key: formkey5,
//                                   controller: _acersPerSection,
//                                   style: const TextStyle(
//                                       color: Color.fromARGB(255, 7, 59, 120), fontSize: 16),
//                                   obscureText: false,
//                                   keyboardType: TextInputType.number,
//                                   decoration: InputDecoration(
//                                     border: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(25),
//                                     ),
//                                     enabledBorder: OutlineInputBorder(
//                                       borderSide: const BorderSide(
//                                         color: Color.fromARGB(255, 7, 59, 120),
//                                       ),
//                                       borderRadius: BorderRadius.circular(25),
//                                     ),
//                                     hintText: 'Enter Acers Per Section',
//                                   ),
//                                   validator: (value) {
//                                     if (value!.isEmpty) {
//                                       return "Please enter Acers Per Section";
//                                     } else {
//                                       return null;
//                                     }
//                                   },
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       );
//                     },
//                   ),
//                   const Align(
//                       alignment: Alignment.centerLeft,
//                       child: Padding(
//                         padding: EdgeInsets.only(
//                             left: 2.0, right: 2.0, bottom: 2.0, top: 10),
//                         child: Text(
//                           "Total Gallons Of Solution",
//                           style: TextStyle(
//                             fontSize: 16.0,
//                             color: Color.fromARGB(255, 7, 59, 120),
//                             //fontWeight: FontWeight.bold
//                           ),
//                         ),
//                       )),
//                   Align(
//                     alignment: Alignment.centerRight,
//                     child: Padding(
//                       padding: const EdgeInsets.all(2.0),
//                       child: TextFormField(
//                         //  key: formkey5,
//                         controller: _totalGallonsOfSolution,
//                         style:
//                             const TextStyle(color: Color.fromARGB(255, 7, 59, 120), fontSize: 16),
//                         obscureText: false,
//                         keyboardType: TextInputType.number,
//                         decoration: InputDecoration(
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(25),
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                             borderSide: const BorderSide(
//                               color: Color.fromARGB(255, 7, 59, 120),
//                             ),
//                             borderRadius: BorderRadius.circular(25),
//                           ),
//                           hintText: 'Enter Total Gallons Of Solution',
//                         ),
//                         validator: (value) {
//                           if (value!.isEmpty) {
//                             return "Please enter Total Gallons Of Solution";
//                           } else {
//                             return null;
//                           }
//                         },
//                       ),
//                     ),
//                   ),
//                   const Align(
//                       alignment: Alignment.centerLeft,
//                       child: Padding(
//                         padding: EdgeInsets.only(
//                             left: 2.0, right: 2.0, bottom: 2.0, top: 10.0),
//                         child: Text(
//                           "Total Acers Applied",
//                           style: TextStyle(
//                             fontSize: 16.0,
//                             color: Color.fromARGB(255, 7, 59, 120),
//                             //fontWeight: FontWeight.bold
//                           ),
//                         ),
//                       )),
//                   Align(
//                     alignment: Alignment.centerRight,
//                     child: Padding(
//                       padding: const EdgeInsets.all(2.0),
//                       child: TextFormField(
//                         //  key: formkey5,
//                         controller: _totalAcersApplied,
//                         style:
//                             const TextStyle(color: Color.fromARGB(255, 7, 59, 120), fontSize: 16),
//                         obscureText: false,
//                         keyboardType: TextInputType.number,
//                         decoration: InputDecoration(
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(25),
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                             borderSide: const BorderSide(
//                               color: Color.fromARGB(255, 7, 59, 120),
//                             ),
//                             borderRadius: BorderRadius.circular(25),
//                           ),
//                           hintText: 'Enter Total Acers Applied',
//                         ),
//                         validator: (value) {
//                           if (value!.isEmpty) {
//                             return "Please enter Total Acers Applied";
//                           } else {
//                             return null;
//                           }
//                         },
//                       ),
//                     ),
//                   ),
//                   Container(
//                       margin: const EdgeInsets.only(
//                           left: 6, right: 6, top: 20.0, bottom: 10),
//                       child: InkWell(
//                         onTap: () {
//                           setState(() {});
//                         },
//                         child: Container(
//                           margin: const EdgeInsets.only(
//                               left: 40, right: 40, bottom: 10.0),
//                           // padding: const EdgeInsets.all(8),
//                           alignment: Alignment.center,
//                           width: MediaQuery.of(context).size.width,
//                           height: 40,
//                           decoration: BoxDecoration(
//                               // shape: BoxShape.circle,
//                               borderRadius: BorderRadius.circular(25),
//                               boxShadow: const [
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
//                           child: const Row(children: [
//                             Expanded(
//                               child: Align(
//                                 alignment: Alignment.center,
//                                 child: Text(
//                                   "Add Another Herbicide",
//                                   textAlign: TextAlign.left,
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 20,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ]),
//                         ),
//                       )),
//                 ],
//               )),
//           Container(
//               margin:
//                   const EdgeInsets.only(left: 8, right: 8, top: 10, bottom: 8),
//               padding: const EdgeInsets.all(8),
//               alignment: Alignment.center,
//               // height: size.height * 0.5,
//               width: size.width * 0.99,
//               decoration: BoxDecoration(
//                   // shape: BoxShape.circle,
//                   borderRadius: BorderRadius.circular(10),
//                   boxShadow: const [
//                     BoxShadow(
//                         color: Color.fromARGB(255, 7, 59, 120),
//                         blurRadius: 10,
//                         offset: Offset(2.0, 5.0))
//                   ],
//                   gradient: const LinearGradient(
//                     colors: [
//                       Color.fromARGB(255, 255, 255, 255),
//                       Color.fromARGB(255, 255, 255, 255),
//                     ],
//                   )),
//               child: Column(
//                 children: [
//                   Container(
//                     padding: const EdgeInsets.all(10),
//                     alignment: Alignment.center,
//                     width: size.width * 0.99,
//                     // width: MediaQuery.of(context).size.width,
//                     // height: 40,
//                     decoration: const BoxDecoration(
//                         // shape: BoxShape.circle,
//                         //borderRadius: BorderRadius.circular(25),
//                         boxShadow: [
//                           BoxShadow(
//                               color: Color.fromARGB(
//                                                   255, 3, 47, 97),
//                                               blurRadius: 5,
//                                               offset: Offset(2.0, 5.0))
//                                         ],
//                                         gradient: LinearGradient(
//                                           colors: [
//                                             Color.fromARGB(255, 7, 59, 120),
//                                             Color.fromARGB(255, 7, 59, 120)
//                           ],
//                         )),
//                     child: const Row(children: [
//                       Align(
//                         alignment: Alignment.centerLeft,
//                         child: Text(
//                           "Equipment",
//                           textAlign: TextAlign.left,
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 20,
//                           ),
//                         ),
//                       ),
//                     ]),
//                   ),
//                   Column(
//                     children: [
//                       Container(
//                         margin: const EdgeInsets.only(top: 10),
//                         child: Column(
//                           children: [
//                             const Align(
//                                 alignment: Alignment.centerLeft,
//                                 child: Padding(
//                                   padding: EdgeInsets.all(2.0),
//                                   child: Text(
//                                     "Select Number Of Equipment",
//                                     style: TextStyle(
//                                         fontSize: 16.0, color: Color.fromARGB(255, 7, 59, 120)),
//                                   ),
//                                 )),
//                             Align(
//                               alignment: Alignment.centerRight,
//                               child: Padding(
//                                 padding: const EdgeInsets.all(2.0),
//                                 child: Container(
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 12, vertical: 4),
//                                   // border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(25),
//                                     border: Border.all(
//                                       color: const Color.fromARGB(255, 7, 59, 120),
//                                     ),
//                                   ),

//                                   child: DropdownButtonHideUnderline(
//                                     child: DropdownButtonFormField<String>(
//                                       hint: const Text('Select'),
//                                       dropdownColor: Colors.white,
//                                       value: numberOfEquipment,
//                                       style: const TextStyle(
//                                           color: Color.fromARGB(255, 7, 59, 120), fontSize: 16),
//                                       icon: const Icon(
//                                         Icons.arrow_drop_down,
//                                         color: Color.fromARGB(255, 7, 59, 120),
//                                         size: 20,
//                                       ),
//                                       decoration: const InputDecoration(
//                                         enabledBorder: UnderlineInputBorder(
//                                             borderSide: BorderSide(
//                                                 color: Colors.transparent)),
//                                         focusedBorder: UnderlineInputBorder(
//                                             borderSide: BorderSide(
//                                                 color: Colors.transparent)),
//                                       ),
//                                       isExpanded: true,
//                                       items: select_numberOfEquipment
//                                           .map(buildMenuItem)
//                                           .toList(),
//                                       onChanged: (value) {
//                                         numberOfEquipment = value;
//                                         setState(() {
//                                           getNumberOfEqipmentLength();
//                                         });
//                                         // showLoaderDialog(context);
//                                         // getYear();
//                                         // getMonth();
//                                         // getData(program.toString(), year.toString(),
//                                         //     '0', '0');
//                                       },
//                                       validator: (value) => value == null
//                                           ? 'field required'
//                                           : null,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),

//                       ListView.builder(
//                         shrinkWrap: true,
//                         itemCount: numberOfEquipmentLength,
//                         // itemCount:  getDaysInBetween().attractions.length,
//                         // itemCount: numberOfDays.length,
//                         physics: const NeverScrollableScrollPhysics(),
//                         itemBuilder: (BuildContext context, int index) {
//                           return Container(
//                             margin: const EdgeInsets.only(
//                                 left: 4, right: 4, top: 10, bottom: 8),
//                             padding: const EdgeInsets.all(8),
//                             alignment: Alignment.center,
//                             // height: size.height * 0.5,
//                             width: size.width * 0.99,
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
//                                     Color.fromARGB(255, 255, 255, 255),
//                                     Color.fromARGB(255, 255, 255, 255),
//                                   ],
//                                 )),
//                             child: Column(
//                               children: [
//                                 Row(
//                                   children: [
//                                     Expanded(
//                                       child: Container(
//                                         margin: const EdgeInsets.only(
//                                           left: 8,
//                                           right: 8,
//                                           top: 8,
//                                         ),
//                                         padding: const EdgeInsets.all(8),
//                                         alignment: Alignment.center,
//                                         height: size.height * 0.05,
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
//                                                 Colors.white,
//                                                 Colors.white,
//                                               ],
//                                             )),

//                                         child: Align(
//                                           alignment: Alignment.centerRight,
//                                           child: Padding(
//                                             padding: const EdgeInsets.all(4.0),
//                                             child: TextFormField(
//                                               //key: formkey4,
//                                               controller: _equipment,
//                                               style: const TextStyle(
//                                                   color: Color.fromARGB(255, 7, 59, 120),
//                                                   fontSize: 16),
//                                               obscureText: false,
//                                               // keyboardType: TextInputType.number,
//                                               decoration: const InputDecoration(
//                                                 // border: OutlineInputBorder(
//                                                 //   borderRadius: BorderRadius.circular(25),
//                                                 // ),
//                                                 // enabledBorder: OutlineInputBorder(
//                                                 //   borderSide: const BorderSide(
//                                                 //     color: Color.fromARGB(255, 7, 59, 120),
//                                                 //   ),
//                                                 //   borderRadius: BorderRadius.circular(25),
//                                                 // ),
//                                                 hintText: 'Equipment',
//                                               ),
//                                               validator: (value) {
//                                                 if (value!.isEmpty) {
//                                                   return "Please enter Amount";
//                                                 } else {
//                                                   return null;
//                                                 }
//                                               },
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                     IconButton(
//                                         icon: const Icon(Icons.delete),
//                                         iconSize: 30,
//                                         color: const Color.fromARGB(255, 7, 59, 120),
//                                         onPressed: () {
//                                           // setState(() {
//                                           //   numberOfDays.removeAt(index);
//                                           // });
//                                         }),
//                                   ],
//                                 ),
//                                 Row(
//                                   children: [
//                                     Expanded(
//                                       child: Align(
//                                           alignment: Alignment.centerLeft,
//                                           child: Padding(
//                                             padding: const EdgeInsets.only(
//                                               left: 2.0,
//                                               right: 2.0,
//                                             ),
//                                             child: Container(
//                                               margin: const EdgeInsets.only(
//                                                 left: 8,
//                                                 right: 8,
//                                                 top: 8,
//                                               ),
//                                               padding: const EdgeInsets.all(8),
//                                               alignment: Alignment.center,
//                                               // height: size.height * 0.5,
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
//                                                       Color.fromARGB(
//                                                           255, 2, 92, 249),
//                                                       Color.fromARGB(
//                                                           255, 16, 1, 135),
//                                                     ],
//                                                   )),

//                                               child: const Text(
//                                                 "Equipment No.",
//                                                 style: TextStyle(
//                                                   fontSize: 16.0,
//                                                   color: Colors.white,
//                                                   //fontWeight: FontWeight.bold
//                                                 ),
//                                               ),
//                                             ),
//                                           )),
//                                     ),
//                                     Expanded(
//                                       child: Container(
//                                         margin: const EdgeInsets.only(
//                                           left: 8,
//                                           right: 8,
//                                           top: 8,
//                                         ),
//                                         padding: const EdgeInsets.all(8),
//                                         alignment: Alignment.center,
//                                         height: size.height * 0.05,
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
//                                                 Colors.white,
//                                                 Colors.white,
//                                               ],
//                                             )),

//                                         child: Align(
//                                           alignment: Alignment.centerRight,
//                                           child: Padding(
//                                             padding: const EdgeInsets.all(2.0),
//                                             child: TextFormField(
//                                               //key: formkey4,
//                                               controller: _equipmentNumber,
//                                               style: const TextStyle(
//                                                   color: Color.fromARGB(255, 7, 59, 120),
//                                                   fontSize: 16),
//                                               obscureText: false,
//                                               keyboardType:
//                                                   TextInputType.number,
//                                               // decoration: InputDecoration(
//                                               //   border: OutlineInputBorder(
//                                               //     borderRadius: BorderRadius.circular(25),
//                                               //   ),
//                                               //   enabledBorder: OutlineInputBorder(
//                                               //     borderSide: const BorderSide(
//                                               //       color: Color.fromARGB(255, 7, 59, 120),
//                                               //     ),
//                                               //     borderRadius: BorderRadius.circular(25),
//                                               //   ),
//                                               //   hintText: 'Enter Amount',
//                                               // ),
//                                               validator: (value) {
//                                                 if (value!.isEmpty) {
//                                                   return "Please enter Amount";
//                                                 } else {
//                                                   return null;
//                                                 }
//                                               },
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 Row(
//                                   children: [
//                                     Expanded(
//                                       child: Align(
//                                           alignment: Alignment.centerLeft,
//                                           child: Padding(
//                                             padding: const EdgeInsets.only(
//                                               left: 2.0,
//                                               right: 2.0,
//                                             ),
//                                             child: Container(
//                                               margin: const EdgeInsets.only(
//                                                 left: 8,
//                                                 right: 8,
//                                                 top: 8,
//                                               ),
//                                               padding: const EdgeInsets.all(8),
//                                               alignment: Alignment.center,
//                                               // height: size.height * 0.5,
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
//                                                       Color.fromARGB(
//                                                           255, 2, 92, 249),
//                                                       Color.fromARGB(
//                                                           255, 16, 1, 135),
//                                                     ],
//                                                   )),

//                                               child: const Text(
//                                                 "Quantity",
//                                                 style: TextStyle(
//                                                   fontSize: 16.0,
//                                                   color: Colors.white,
//                                                   //fontWeight: FontWeight.bold
//                                                 ),
//                                               ),
//                                             ),
//                                           )),
//                                     ),
//                                     Expanded(
//                                       child: Container(
//                                         margin: const EdgeInsets.only(
//                                           left: 8,
//                                           right: 8,
//                                           top: 8,
//                                         ),
//                                         padding: const EdgeInsets.all(8),
//                                         alignment: Alignment.center,
//                                         height: size.height * 0.05,
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
//                                                 Colors.white,
//                                                 Colors.white,
//                                               ],
//                                             )),

//                                         child: Align(
//                                           alignment: Alignment.centerRight,
//                                           child: Padding(
//                                             padding: const EdgeInsets.all(2.0),
//                                             child: TextFormField(
//                                               //key: formkey4,
//                                               controller: _quantityEquipment,
//                                               style: const TextStyle(
//                                                   color: Color.fromARGB(255, 7, 59, 120),
//                                                   fontSize: 16),
//                                               obscureText: false,
//                                               keyboardType:
//                                                   TextInputType.number,
//                                               // decoration: InputDecoration(
//                                               //   border: OutlineInputBorder(
//                                               //     borderRadius: BorderRadius.circular(25),
//                                               //   ),
//                                               //   enabledBorder: OutlineInputBorder(
//                                               //     borderSide: const BorderSide(
//                                               //       color: Color.fromARGB(255, 7, 59, 120),
//                                               //     ),
//                                               //     borderRadius: BorderRadius.circular(25),
//                                               //   ),
//                                               //   hintText: 'Enter Amount',
//                                               // ),
//                                               validator: (value) {
//                                                 if (value!.isEmpty) {
//                                                   return "Please enter Amount";
//                                                 } else {
//                                                   return null;
//                                                 }
//                                               },
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 Row(
//                                   children: [
//                                     Expanded(
//                                       child: Align(
//                                           alignment: Alignment.centerLeft,
//                                           child: Padding(
//                                             padding: const EdgeInsets.only(
//                                               left: 2.0,
//                                               right: 2.0,
//                                             ),
//                                             child: Container(
//                                               margin: const EdgeInsets.only(
//                                                 left: 8,
//                                                 right: 8,
//                                                 top: 8,
//                                               ),
//                                               padding: const EdgeInsets.all(8),
//                                               alignment: Alignment.center,
//                                               // height: size.height * 0.5,
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
//                                                       Color.fromARGB(
//                                                           255, 2, 92, 249),
//                                                       Color.fromARGB(
//                                                           255, 16, 1, 135),
//                                                     ],
//                                                   )),

//                                               child: const Text(
//                                                 "Hours Each",
//                                                 style: TextStyle(
//                                                   fontSize: 16.0,
//                                                   color: Colors.white,
//                                                   //fontWeight: FontWeight.bold
//                                                 ),
//                                               ),
//                                             ),
//                                           )),
//                                     ),
//                                     Expanded(
//                                       child: Container(
//                                         margin: const EdgeInsets.only(
//                                           left: 8,
//                                           right: 8,
//                                           top: 8,
//                                         ),
//                                         padding: const EdgeInsets.all(8),
//                                         alignment: Alignment.center,
//                                         height: size.height * 0.05,
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
//                                                 Colors.white,
//                                                 Colors.white,
//                                               ],
//                                             )),

//                                         child: Align(
//                                           alignment: Alignment.centerRight,
//                                           child: Padding(
//                                             padding: const EdgeInsets.all(2.0),
//                                             child: TextFormField(
//                                               //key: formkey4,
//                                               controller: _hoursEachEquipment,
//                                               style: const TextStyle(
//                                                   color: Color.fromARGB(255, 7, 59, 120),
//                                                   fontSize: 16),
//                                               obscureText: false,
//                                               keyboardType:
//                                                   TextInputType.number,
//                                               // decoration: InputDecoration(
//                                               //   border: OutlineInputBorder(
//                                               //     borderRadius: BorderRadius.circular(25),
//                                               //   ),
//                                               //   enabledBorder: OutlineInputBorder(
//                                               //     borderSide: const BorderSide(
//                                               //       color: Color.fromARGB(255, 7, 59, 120),
//                                               //     ),
//                                               //     borderRadius: BorderRadius.circular(25),
//                                               //   ),
//                                               //   hintText: 'Enter Amount',
//                                               // ),
//                                               validator: (value) {
//                                                 if (value!.isEmpty) {
//                                                   return "Please enter Amount";
//                                                 } else {
//                                                   return null;
//                                                 }
//                                               },
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 Row(
//                                   children: [
//                                     Expanded(
//                                       child: Align(
//                                           alignment: Alignment.centerLeft,
//                                           child: Padding(
//                                             padding: const EdgeInsets.only(
//                                               left: 2.0,
//                                               right: 2.0,
//                                             ),
//                                             child: Container(
//                                               margin: const EdgeInsets.only(
//                                                 left: 8,
//                                                 right: 8,
//                                                 top: 8,
//                                               ),
//                                               padding: const EdgeInsets.all(8),
//                                               alignment: Alignment.center,
//                                               // height: size.height * 0.5,
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
//                                                       Color.fromARGB(
//                                                           255, 2, 92, 249),
//                                                       Color.fromARGB(
//                                                           255, 16, 1, 135),
//                                                     ],
//                                                   )),

//                                               child: const Text(
//                                                 "Total Hours",
//                                                 style: TextStyle(
//                                                   fontSize: 16.0,
//                                                   color: Colors.white,
//                                                   //fontWeight: FontWeight.bold
//                                                 ),
//                                               ),
//                                             ),
//                                           )),
//                                     ),
//                                     Expanded(
//                                       child: Container(
//                                         margin: const EdgeInsets.only(
//                                           left: 8,
//                                           right: 8,
//                                           top: 8,
//                                         ),
//                                         padding: const EdgeInsets.all(8),
//                                         alignment: Alignment.center,
//                                         height: size.height * 0.05,
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
//                                                 Colors.white,
//                                                 Colors.white,
//                                               ],
//                                             )),

//                                         child: Align(
//                                           alignment: Alignment.centerRight,
//                                           child: Padding(
//                                             padding: const EdgeInsets.all(2.0),
//                                             child: TextFormField(
//                                               //key: formkey4,
//                                               controller: _totalHoursEquipment,
//                                               style: const TextStyle(
//                                                   color: Color.fromARGB(255, 7, 59, 120),
//                                                   fontSize: 16),
//                                               obscureText: false,
//                                               keyboardType:
//                                                   TextInputType.number,
//                                               // decoration: InputDecoration(
//                                               //   border: OutlineInputBorder(
//                                               //     borderRadius: BorderRadius.circular(25),
//                                               //   ),
//                                               //   enabledBorder: OutlineInputBorder(
//                                               //     borderSide: const BorderSide(
//                                               //       color: Color.fromARGB(255, 7, 59, 120),
//                                               //     ),
//                                               //     borderRadius: BorderRadius.circular(25),
//                                               //   ),
//                                               //   hintText: 'Enter Amount',
//                                               // ),
//                                               validator: (value) {
//                                                 if (value!.isEmpty) {
//                                                   return "Please enter Amount";
//                                                 } else {
//                                                   return null;
//                                                 }
//                                               },
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           );
//                         },
//                       ),

//                       //
//                       Container(
//                           margin: const EdgeInsets.only(
//                               left: 6, right: 6, top: 20.0, bottom: 10),
//                           child: InkWell(
//                             onTap: () {
//                               // Navigator.pop(context);
//                             },
//                             child: Container(
//                               margin: const EdgeInsets.only(
//                                   left: 40, right: 40, bottom: 10.0),
//                               // padding: const EdgeInsets.all(8),
//                               alignment: Alignment.center,
//                               width: MediaQuery.of(context).size.width,
//                               height: 40,
//                               decoration: BoxDecoration(
//                                   // shape: BoxShape.circle,
//                                   borderRadius: BorderRadius.circular(25),
//                                   boxShadow: const [
//                                     BoxShadow(
//                                          color: Color.fromARGB(
//                                                   255, 3, 47, 97),
//                                               blurRadius: 5,
//                                               offset: Offset(2.0, 5.0))
//                                         ],
//                                         gradient: const LinearGradient(
//                                           colors: [
//                                             Color.fromARGB(255, 7, 59, 120),
//                                             Color.fromARGB(255, 7, 59, 120)
//                                     ],
//                                   )),
//                               child: const Row(children: [
//                                 Expanded(
//                                   child: Align(
//                                     alignment: Alignment.center,
//                                     child: Text(
//                                       "Add Another Euipment",
//                                       textAlign: TextAlign.left,
//                                       style: TextStyle(
//                                         color: Colors.white,
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 20,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ]),
//                             ),
//                           )),
//                     ],
//                   ),
//                 ],
//               )),
//           Container(
//               margin:
//                   const EdgeInsets.only(left: 8, right: 8, top: 10, bottom: 8),
//               padding: const EdgeInsets.all(8),
//               alignment: Alignment.center,
//               // height: size.height * 0.5,
//               width: size.width * 0.99,
//               decoration: BoxDecoration(
//                   // shape: BoxShape.circle,
//                   borderRadius: BorderRadius.circular(10),
//                   boxShadow: const [
//                     BoxShadow(
//                         color: Color.fromARGB(255, 7, 59, 120),
//                         blurRadius: 10,
//                         offset: Offset(2.0, 5.0))
//                   ],
//                   gradient: const LinearGradient(
//                     colors: [
//                       Color.fromARGB(255, 255, 255, 255),
//                       Color.fromARGB(255, 255, 255, 255),
//                     ],
//                   )),
//               child: Column(
//                 children: [
//                   Container(
//                     padding: const EdgeInsets.all(10),
//                     alignment: Alignment.center,
//                     width: size.width * 0.99,
//                     // width: MediaQuery.of(context).size.width,
//                     // height: 40,
//                     decoration: const BoxDecoration(
//                         // shape: BoxShape.circle,
//                         //borderRadius: BorderRadius.circular(25),
//                         boxShadow: [
//                           BoxShadow(
//                               color: Color.fromARGB(
//                                                   255, 3, 47, 97),
//                                               blurRadius: 5,
//                                               offset: Offset(2.0, 5.0))
//                                         ],
//                                         gradient: LinearGradient(
//                                           colors: [
//                                             Color.fromARGB(255, 7, 59, 120),
//                                             Color.fromARGB(255, 7, 59, 120)
//                           ],
//                         )),
//                     child: const Row(children: [
//                       Align(
//                         alignment: Alignment.centerLeft,
//                         child: Text(
//                           "Labor",
//                           textAlign: TextAlign.left,
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 20,
//                           ),
//                         ),
//                       ),
//                     ]),
//                   ),
//                   Column(
//                     children: [
//                       Container(
//                         margin: const EdgeInsets.only(top: 10),
//                         child: Column(
//                           children: [
//                             const Align(
//                                 alignment: Alignment.centerLeft,
//                                 child: Padding(
//                                   padding: EdgeInsets.all(2.0),
//                                   child: Text(
//                                     "Select Number Of Labours",
//                                     style: TextStyle(
//                                         fontSize: 16.0, color: Color.fromARGB(255, 7, 59, 120)),
//                                   ),
//                                 )),
//                             Align(
//                               alignment: Alignment.centerRight,
//                               child: Padding(
//                                 padding: const EdgeInsets.all(2.0),
//                                 child: Container(
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 12, vertical: 4),
//                                   // border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(25),
//                                     border: Border.all(
//                                       color: const Color.fromARGB(255, 7, 59, 120),
//                                     ),
//                                   ),

//                                   child: DropdownButtonHideUnderline(
//                                     child: DropdownButtonFormField<String>(
//                                       hint: const Text('Select'),
//                                       dropdownColor: Colors.white,
//                                       value: numberOfLabours,
//                                       style: const TextStyle(
//                                           color: Color.fromARGB(255, 7, 59, 120), fontSize: 16),
//                                       icon: const Icon(
//                                         Icons.arrow_drop_down,
//                                         color: Color.fromARGB(255, 7, 59, 120),
//                                         size: 20,
//                                       ),
//                                       decoration: const InputDecoration(
//                                         enabledBorder: UnderlineInputBorder(
//                                             borderSide: BorderSide(
//                                                 color: Colors.transparent)),
//                                         focusedBorder: UnderlineInputBorder(
//                                             borderSide: BorderSide(
//                                                 color: Colors.transparent)),
//                                       ),
//                                       isExpanded: true,
//                                       items: select_numberOfLabours
//                                           .map(buildMenuItem)
//                                           .toList(),
//                                       onChanged: (value) {
//                                         numberOfLabours = value;
//                                         setState(() {
//                                           getNumberOfLaborLength();
//                                         });
//                                         // showLoaderDialog(context);
//                                         // getYear();
//                                         // getMonth();
//                                         // getData(program.toString(), year.toString(),
//                                         //     '0', '0');
//                                       },
//                                       validator: (value) => value == null
//                                           ? 'field required'
//                                           : null,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       ListView.builder(
//                         shrinkWrap: true,
//                         itemCount: numberOfLobourLength,
//                         // itemCount:  getDaysInBetween().attractions.length,
//                         // itemCount: numberOfDays.length,
//                         physics: const NeverScrollableScrollPhysics(),
//                         itemBuilder: (BuildContext context, int index) {
//                           return Container(
//                             margin: const EdgeInsets.only(
//                                 left: 4, right: 4, top: 10, bottom: 8),
//                             padding: const EdgeInsets.all(8),
//                             alignment: Alignment.center,
//                             // height: size.height * 0.5,
//                             width: size.width * 0.99,
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
//                                     Color.fromARGB(255, 255, 255, 255),
//                                     Color.fromARGB(255, 255, 255, 255),
//                                   ],
//                                 )),
//                             child: Column(
//                               children: [
//                                 Row(
//                                   children: [
//                                     Expanded(
//                                       child: Container(
//                                         margin: const EdgeInsets.only(
//                                           left: 8,
//                                           right: 8,
//                                           top: 8,
//                                         ),
//                                         padding: const EdgeInsets.all(8),
//                                         alignment: Alignment.center,
//                                         height: size.height * 0.05,
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
//                                                 Colors.white,
//                                                 Colors.white,
//                                               ],
//                                             )),

//                                         child: Align(
//                                           alignment: Alignment.centerRight,
//                                           child: Padding(
//                                             padding: const EdgeInsets.all(4.0),
//                                             child: TextFormField(
//                                               //key: formkey4,
//                                               controller: _labor,
//                                               style: const TextStyle(
//                                                   color: Color.fromARGB(255, 7, 59, 120),
//                                                   fontSize: 16),
//                                               obscureText: false,
//                                               // keyboardType: TextInputType.number,
//                                               decoration: const InputDecoration(
//                                                 // border: OutlineInputBorder(
//                                                 //   borderRadius: BorderRadius.circular(25),
//                                                 // ),
//                                                 // enabledBorder: OutlineInputBorder(
//                                                 //   borderSide: const BorderSide(
//                                                 //     color: Color.fromARGB(255, 7, 59, 120),
//                                                 //   ),
//                                                 //   borderRadius: BorderRadius.circular(25),
//                                                 // ),
//                                                 hintText: 'Labor',
//                                               ),
//                                               validator: (value) {
//                                                 if (value!.isEmpty) {
//                                                   return "Please enter Labor";
//                                                 } else {
//                                                   return null;
//                                                 }
//                                               },
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                     IconButton(
//                                         icon: const Icon(Icons.delete),
//                                         iconSize: 30,
//                                         color: const Color.fromARGB(255, 7, 59, 120),
//                                         onPressed: () {
//                                           // setState(() {
//                                           //   numberOfDays.removeAt(index);
//                                           // });
//                                         }),
//                                   ],
//                                 ),
//                                 Row(
//                                   children: [
//                                     Expanded(
//                                       child: Align(
//                                           alignment: Alignment.centerLeft,
//                                           child: Padding(
//                                             padding: const EdgeInsets.only(
//                                               left: 2.0,
//                                               right: 2.0,
//                                             ),
//                                             child: Container(
//                                               margin: const EdgeInsets.only(
//                                                 left: 8,
//                                                 right: 8,
//                                                 top: 8,
//                                               ),
//                                               padding: const EdgeInsets.all(8),
//                                               alignment: Alignment.center,
//                                               // height: size.height * 0.5,
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
//                                                       Color.fromARGB(
//                                                           255, 2, 92, 249),
//                                                       Color.fromARGB(
//                                                           255, 16, 1, 135),
//                                                     ],
//                                                   )),

//                                               child: const Text(
//                                                 "Quantity",
//                                                 style: TextStyle(
//                                                   fontSize: 16.0,
//                                                   color: Colors.white,
//                                                   //fontWeight: FontWeight.bold
//                                                 ),
//                                               ),
//                                             ),
//                                           )),
//                                     ),
//                                     Expanded(
//                                       child: Container(
//                                         margin: const EdgeInsets.only(
//                                           left: 8,
//                                           right: 8,
//                                           top: 8,
//                                         ),
//                                         padding: const EdgeInsets.all(8),
//                                         alignment: Alignment.center,
//                                         height: size.height * 0.05,
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
//                                                 Colors.white,
//                                                 Colors.white,
//                                               ],
//                                             )),

//                                         child: Align(
//                                           alignment: Alignment.centerRight,
//                                           child: Padding(
//                                             padding: const EdgeInsets.all(2.0),
//                                             child: TextFormField(
//                                               //key: formkey4,
//                                               controller: _quantityLabor,
//                                               style: const TextStyle(
//                                                   color: Color.fromARGB(255, 7, 59, 120),
//                                                   fontSize: 16),
//                                               obscureText: false,
//                                               keyboardType:
//                                                   TextInputType.number,
//                                               // decoration: InputDecoration(
//                                               //   border: OutlineInputBorder(
//                                               //     borderRadius: BorderRadius.circular(25),
//                                               //   ),
//                                               //   enabledBorder: OutlineInputBorder(
//                                               //     borderSide: const BorderSide(
//                                               //       color: Color.fromARGB(255, 7, 59, 120),
//                                               //     ),
//                                               //     borderRadius: BorderRadius.circular(25),
//                                               //   ),
//                                               //   hintText: 'Enter Amount',
//                                               // ),
//                                               validator: (value) {
//                                                 if (value!.isEmpty) {
//                                                   return "Please enter Quantity";
//                                                 } else {
//                                                   return null;
//                                                 }
//                                               },
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 Row(
//                                   children: [
//                                     Expanded(
//                                       child: Align(
//                                           alignment: Alignment.centerLeft,
//                                           child: Padding(
//                                             padding: const EdgeInsets.only(
//                                               left: 2.0,
//                                               right: 2.0,
//                                             ),
//                                             child: Container(
//                                               margin: const EdgeInsets.only(
//                                                 left: 8,
//                                                 right: 8,
//                                                 top: 8,
//                                               ),
//                                               padding: const EdgeInsets.all(8),
//                                               alignment: Alignment.center,
//                                               // height: size.height * 0.5,
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
//                                                       Color.fromARGB(
//                                                           255, 2, 92, 249),
//                                                       Color.fromARGB(
//                                                           255, 16, 1, 135),
//                                                     ],
//                                                   )),

//                                               child: const Text(
//                                                 "Hours Each",
//                                                 style: TextStyle(
//                                                   fontSize: 16.0,
//                                                   color: Colors.white,
//                                                   //fontWeight: FontWeight.bold
//                                                 ),
//                                               ),
//                                             ),
//                                           )),
//                                     ),
//                                     Expanded(
//                                       child: Container(
//                                         margin: const EdgeInsets.only(
//                                           left: 8,
//                                           right: 8,
//                                           top: 8,
//                                         ),
//                                         padding: const EdgeInsets.all(8),
//                                         alignment: Alignment.center,
//                                         height: size.height * 0.05,
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
//                                                 Colors.white,
//                                                 Colors.white,
//                                               ],
//                                             )),

//                                         child: Align(
//                                           alignment: Alignment.centerRight,
//                                           child: Padding(
//                                             padding: const EdgeInsets.all(2.0),
//                                             child: TextFormField(
//                                               //key: formkey4,
//                                               controller: _hoursEachLabor,
//                                               style: const TextStyle(
//                                                   color: Color.fromARGB(255, 7, 59, 120),
//                                                   fontSize: 16),
//                                               obscureText: false,
//                                               keyboardType:
//                                                   TextInputType.number,
//                                               // decoration: InputDecoration(
//                                               //   border: OutlineInputBorder(
//                                               //     borderRadius: BorderRadius.circular(25),
//                                               //   ),
//                                               //   enabledBorder: OutlineInputBorder(
//                                               //     borderSide: const BorderSide(
//                                               //       color: Color.fromARGB(255, 7, 59, 120),
//                                               //     ),
//                                               //     borderRadius: BorderRadius.circular(25),
//                                               //   ),
//                                               //   hintText: 'Enter Amount',
//                                               // ),
//                                               validator: (value) {
//                                                 if (value!.isEmpty) {
//                                                   return "Please enter Hour Each";
//                                                 } else {
//                                                   return null;
//                                                 }
//                                               },
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 Row(
//                                   children: [
//                                     Expanded(
//                                       child: Align(
//                                           alignment: Alignment.centerLeft,
//                                           child: Padding(
//                                             padding: const EdgeInsets.only(
//                                               left: 2.0,
//                                               right: 2.0,
//                                             ),
//                                             child: Container(
//                                               margin: const EdgeInsets.only(
//                                                 left: 8,
//                                                 right: 8,
//                                                 top: 8,
//                                               ),
//                                               padding: const EdgeInsets.all(8),
//                                               alignment: Alignment.center,
//                                               // height: size.height * 0.5,
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
//                                                       Color.fromARGB(
//                                                           255, 2, 92, 249),
//                                                       Color.fromARGB(
//                                                           255, 16, 1, 135),
//                                                     ],
//                                                   )),

//                                               child: const Text(
//                                                 "Total Hours",
//                                                 style: TextStyle(
//                                                   fontSize: 16.0,
//                                                   color: Colors.white,
//                                                   //fontWeight: FontWeight.bold
//                                                 ),
//                                               ),
//                                             ),
//                                           )),
//                                     ),
//                                     Expanded(
//                                       child: Container(
//                                         margin: const EdgeInsets.only(
//                                           left: 8,
//                                           right: 8,
//                                           top: 8,
//                                         ),
//                                         padding: const EdgeInsets.all(8),
//                                         alignment: Alignment.center,
//                                         height: size.height * 0.05,
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
//                                                 Colors.white,
//                                                 Colors.white,
//                                               ],
//                                             )),

//                                         child: Align(
//                                           alignment: Alignment.centerRight,
//                                           child: Padding(
//                                             padding: const EdgeInsets.all(2.0),
//                                             child: TextFormField(
//                                               //key: formkey4,
//                                               controller: _totalHoursLabor,
//                                               style: const TextStyle(
//                                                   color: Color.fromARGB(255, 7, 59, 120),
//                                                   fontSize: 16),
//                                               obscureText: false,
//                                               keyboardType:
//                                                   TextInputType.number,
//                                               // decoration: InputDecoration(
//                                               //   border: OutlineInputBorder(
//                                               //     borderRadius: BorderRadius.circular(25),
//                                               //   ),
//                                               //   enabledBorder: OutlineInputBorder(
//                                               //     borderSide: const BorderSide(
//                                               //       color: Color.fromARGB(255, 7, 59, 120),
//                                               //     ),
//                                               //     borderRadius: BorderRadius.circular(25),
//                                               //   ),
//                                               //   hintText: 'Enter Amount',
//                                               // ),
//                                               validator: (value) {
//                                                 if (value!.isEmpty) {
//                                                   return "Please enter Total Hours";
//                                                 } else {
//                                                   return null;
//                                                 }
//                                               },
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           );
//                         },
//                       ),
//                       Container(
//                           margin: const EdgeInsets.only(
//                               left: 6, right: 6, top: 20.0, bottom: 10),
//                           child: InkWell(
//                             onTap: () {
//                               // Navigator.pop(context);
//                             },
//                             child: Container(
//                               margin: const EdgeInsets.only(
//                                   left: 40, right: 40, bottom: 10.0),
//                               // padding: const EdgeInsets.all(8),
//                               alignment: Alignment.center,
//                               width: MediaQuery.of(context).size.width,
//                               height: 40,
//                               decoration: BoxDecoration(
//                                   // shape: BoxShape.circle,
//                                   borderRadius: BorderRadius.circular(25),
//                                   boxShadow: const [
//                                     BoxShadow(
//                                          color: Color.fromARGB(
//                                                   255, 3, 47, 97),
//                                               blurRadius: 5,
//                                               offset: Offset(2.0, 5.0))
//                                         ],
//                                         gradient: const LinearGradient(
//                                           colors: [
//                                             Color.fromARGB(255, 7, 59, 120),
//                                             Color.fromARGB(255, 7, 59, 120)
//                                     ],
//                                   )),
//                               child: const Row(children: [
//                                 Expanded(
//                                   child: Align(
//                                     alignment: Alignment.center,
//                                     child: Text(
//                                       "Add Another Loabour",
//                                       textAlign: TextAlign.left,
//                                       style: TextStyle(
//                                         color: Colors.white,
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 20,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ]),
//                             ),
//                           )),
//                     ],
//                   ),
//                 ],
//               )),
//           Container(
//               margin:
//                   const EdgeInsets.only(left: 8, right: 8, top: 10, bottom: 8),
//               padding: const EdgeInsets.all(8),
//               alignment: Alignment.center,
//               // height: size.height * 0.5,
//               width: size.width * 0.99,
//               decoration: BoxDecoration(
//                   // shape: BoxShape.circle,
//                   borderRadius: BorderRadius.circular(10),
//                   boxShadow: const [
//                     BoxShadow(
//                         color: Color.fromARGB(255, 7, 59, 120),
//                         blurRadius: 10,
//                         offset: Offset(2.0, 5.0))
//                   ],
//                   gradient: const LinearGradient(
//                     colors: [
//                       Color.fromARGB(255, 255, 255, 255),
//                       Color.fromARGB(255, 255, 255, 255),
//                     ],
//                   )),
//               child: Column(
//                 children: [
//                   Container(
//                     padding: const EdgeInsets.all(10),
//                     alignment: Alignment.center,
//                     width: size.width * 0.99,
//                     // width: MediaQuery.of(context).size.width,
//                     height: 40,
//                     decoration: const BoxDecoration(
//                         // shape: BoxShape.circle,
//                         //borderRadius: BorderRadius.circular(25),
//                         boxShadow: [
//                           BoxShadow(
//                               color: Color.fromARGB(
//                                                   255, 3, 47, 97),
//                                               blurRadius: 5,
//                                               offset: Offset(2.0, 5.0))
//                                         ],
//                                         gradient: LinearGradient(
//                                           colors: [
//                                             Color.fromARGB(255, 7, 59, 120),
//                                             Color.fromARGB(255, 7, 59, 120)
//                           ],
//                         )),
//                     child: const Row(children: [
//                       Align(
//                         alignment: Alignment.centerLeft,
//                         child: Text(
//                           "Time Of Application",
//                           textAlign: TextAlign.left,
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 20,
//                           ),
//                         ),
//                       ),
//                     ]),
//                   ),
//                   Column(
//                     children: [
//                       const Align(
//                           alignment: Alignment.centerLeft,
//                           child: Padding(
//                             padding:
//                                 EdgeInsets.only(top: 10.0, bottom: 2, left: 2),
//                             child: Text(
//                               "Select Time Of Applications",
//                               style: TextStyle(
//                                   fontSize: 16.0, color: Color.fromARGB(255, 7, 59, 120)),
//                             ),
//                           )),
//                       Align(
//                         alignment: Alignment.centerRight,
//                         child: Padding(
//                           padding: const EdgeInsets.all(2.0),
//                           child: Container(
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 12, vertical: 4),
//                             // border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(25),
//                               border: Border.all(
//                                 color: const Color.fromARGB(255, 7, 59, 120),
//                               ),
//                             ),

//                             child: DropdownButtonHideUnderline(
//                               child: DropdownButtonFormField<String>(
//                                 hint: const Text('Select'),
//                                 dropdownColor:
//                                     Colors.white,
//                                 value: numberOfApplications,
//                                 style: const TextStyle(
//                                     color: Color.fromARGB(255, 7, 59, 120), fontSize: 16),
//                                 icon: const Icon(
//                                   Icons.arrow_drop_down,
//                                   color: Color.fromARGB(255, 7, 59, 120),
//                                   size: 20,
//                                 ),
//                                 decoration: const InputDecoration(
//                                   enabledBorder: UnderlineInputBorder(
//                                       borderSide: BorderSide(
//                                           color: Colors.transparent)),
//                                   focusedBorder: UnderlineInputBorder(
//                                       borderSide: BorderSide(
//                                           color: Colors.transparent)),
//                                 ),
//                                 isExpanded: true,
//                                 items: select_numberOfApplications
//                                     .map(buildMenuItem)
//                                     .toList(),
//                                 onChanged: (value) {
//                                   numberOfApplications = value;
//                                   setState(() {
//                                     getNumberOfTimeOfApplicationLength();
//                                   });
//                                   // showLoaderDialog(context);
//                                   // getYear();
//                                   // getMonth();
//                                   // getData(program.toString(), year.toString(),
//                                   //     '0', '0');
//                                 },
//                                 validator: (value) =>
//                                     value == null ? 'field required' : null,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       ListView.builder(
//                         shrinkWrap: true,
//                         itemCount: numberOfNumberOfApplicationsLength,
//                         // itemCount:  getDaysInBetween().attractions.length,
//                         // itemCount: numberOfDays.length,
//                         physics: const NeverScrollableScrollPhysics(),
//                         itemBuilder: (BuildContext context, int index) {
//                           return Container(
//                             margin: const EdgeInsets.only(
//                                 left: 4, right: 4, top: 10, bottom: 8),
//                             padding: const EdgeInsets.all(8),
//                             alignment: Alignment.center,
//                             // height: size.height * 0.5,
//                             width: size.width * 0.99,
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
//                                     Color.fromARGB(255, 255, 255, 255),
//                                     Color.fromARGB(255, 255, 255, 255),
//                                   ],
//                                 )),
//                             child: Column(
//                               children: [
//                                 Row(
//                                   children: [
//                                     Expanded(
//                                       child: Container(
//                                         margin: const EdgeInsets.only(
//                                           left: 8,
//                                           right: 8,
//                                           top: 8,
//                                         ),
//                                         padding: const EdgeInsets.all(8),
//                                         alignment: Alignment.center,
//                                         height: size.height * 0.05,
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
//                                                 Colors.white,
//                                                 Colors.white,
//                                               ],
//                                             )),

//                                         child: Align(
//                                           alignment: Alignment.centerRight,
//                                           child: Padding(
//                                             padding: const EdgeInsets.all(4.0),
//                                             child: TextFormField(
//                                               //key: formkey4,
//                                               controller: _applicationStartTime,
//                                               style: const TextStyle(
//                                                   color: Color.fromARGB(255, 7, 59, 120),
//                                                   fontSize: 16),
//                                               obscureText: false,
//                                               keyboardType:
//                                                   TextInputType.number,
//                                               decoration: const InputDecoration(
//                                                 // border: OutlineInputBorder(
//                                                 //   borderRadius: BorderRadius.circular(25),
//                                                 // ),
//                                                 // enabledBorder: OutlineInputBorder(
//                                                 //   borderSide: const BorderSide(
//                                                 //     color: Color.fromARGB(255, 7, 59, 120),
//                                                 //   ),
//                                                 //   borderRadius: BorderRadius.circular(25),
//                                                 // ),
//                                                 hintText:
//                                                     'Application Start Time',
//                                               ),
//                                               validator: (value) {
//                                                 if (value!.isEmpty) {
//                                                   return "Please enter application start time";
//                                                 } else {
//                                                   return null;
//                                                 }
//                                               },
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                     IconButton(
//                                         icon: const Icon(Icons.delete),
//                                         iconSize: 30,
//                                         color: const Color.fromARGB(255, 7, 59, 120),
//                                         onPressed: () {
//                                           // setState(() {
//                                           //   numberOfDays.removeAt(index);
//                                           // });
//                                         }),
//                                   ],
//                                 ),
//                                 Row(
//                                   children: [
//                                     Expanded(
//                                       child: Align(
//                                           alignment: Alignment.centerLeft,
//                                           child: Padding(
//                                             padding: const EdgeInsets.only(
//                                               left: 2.0,
//                                               right: 2.0,
//                                             ),
//                                             child: Container(
//                                               margin: const EdgeInsets.only(
//                                                 left: 8,
//                                                 right: 8,
//                                                 top: 8,
//                                               ),
//                                               padding: const EdgeInsets.all(8),
//                                               alignment: Alignment.center,
//                                               // height: size.height * 0.5,
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
//                                                       Color.fromARGB(
//                                                           255, 2, 92, 249),
//                                                       Color.fromARGB(
//                                                           255, 16, 1, 135),
//                                                     ],
//                                                   )),

//                                               child: const Text(
//                                                 "Application End Time",
//                                                 style: TextStyle(
//                                                   fontSize: 16.0,
//                                                   color: Colors.white,
//                                                   //fontWeight: FontWeight.bold
//                                                 ),
//                                               ),
//                                             ),
//                                           )),
//                                     ),
//                                     Expanded(
//                                       child: Container(
//                                         margin: const EdgeInsets.only(
//                                           left: 8,
//                                           right: 8,
//                                           top: 8,
//                                         ),
//                                         padding: const EdgeInsets.all(8),
//                                         alignment: Alignment.center,
//                                         height: size.height * 0.05,
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
//                                                 Colors.white,
//                                                 Colors.white,
//                                               ],
//                                             )),

//                                         child: Align(
//                                           alignment: Alignment.centerRight,
//                                           child: Padding(
//                                             padding: const EdgeInsets.all(2.0),
//                                             child: TextFormField(
//                                               //key: formkey4,
//                                               controller: _applicationEndTime,
//                                               style: const TextStyle(
//                                                   color: Color.fromARGB(255, 7, 59, 120),
//                                                   fontSize: 16),
//                                               obscureText: false,
//                                               keyboardType:
//                                                   TextInputType.number,
//                                               // decoration: InputDecoration(
//                                               //   border: OutlineInputBorder(
//                                               //     borderRadius: BorderRadius.circular(25),
//                                               //   ),
//                                               //   enabledBorder: OutlineInputBorder(
//                                               //     borderSide: const BorderSide(
//                                               //       color: Color.fromARGB(255, 7, 59, 120),
//                                               //     ),
//                                               //     borderRadius: BorderRadius.circular(25),
//                                               //   ),
//                                               //   hintText: 'Enter Amount',
//                                               // ),
//                                               validator: (value) {
//                                                 if (value!.isEmpty) {
//                                                   return "Please application end time";
//                                                 } else {
//                                                   return null;
//                                                 }
//                                               },
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 Row(
//                                   children: [
//                                     Expanded(
//                                       child: Align(
//                                           alignment: Alignment.centerLeft,
//                                           child: Padding(
//                                             padding: const EdgeInsets.only(
//                                               left: 2.0,
//                                               right: 2.0,
//                                             ),
//                                             child: Container(
//                                               margin: const EdgeInsets.only(
//                                                 left: 8,
//                                                 right: 8,
//                                                 top: 8,
//                                               ),
//                                               padding: const EdgeInsets.all(8),
//                                               alignment: Alignment.center,
//                                               // height: size.height * 0.5,
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
//                                                       Color.fromARGB(
//                                                           255, 2, 92, 249),
//                                                       Color.fromARGB(
//                                                           255, 16, 1, 135),
//                                                     ],
//                                                   )),

//                                               child: const Text(
//                                                 "Break Start Time",
//                                                 style: TextStyle(
//                                                   fontSize: 16.0,
//                                                   color: Colors.white,
//                                                   //fontWeight: FontWeight.bold
//                                                 ),
//                                               ),
//                                             ),
//                                           )),
//                                     ),
//                                     Expanded(
//                                       child: Container(
//                                         margin: const EdgeInsets.only(
//                                           left: 8,
//                                           right: 8,
//                                           top: 8,
//                                         ),
//                                         padding: const EdgeInsets.all(8),
//                                         alignment: Alignment.center,
//                                         height: size.height * 0.05,
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
//                                                 Colors.white,
//                                                 Colors.white,
//                                               ],
//                                             )),

//                                         child: Align(
//                                           alignment: Alignment.centerRight,
//                                           child: Padding(
//                                             padding: const EdgeInsets.all(2.0),
//                                             child: TextFormField(
//                                               //key: formkey4,
//                                               controller: _breakStartTime,
//                                               style: const TextStyle(
//                                                   color: Color.fromARGB(255, 7, 59, 120),
//                                                   fontSize: 16),
//                                               obscureText: false,
//                                               keyboardType:
//                                                   TextInputType.number,
//                                               // decoration: InputDecoration(
//                                               //   border: OutlineInputBorder(
//                                               //     borderRadius: BorderRadius.circular(25),
//                                               //   ),
//                                               //   enabledBorder: OutlineInputBorder(
//                                               //     borderSide: const BorderSide(
//                                               //       color: Color.fromARGB(255, 7, 59, 120),
//                                               //     ),
//                                               //     borderRadius: BorderRadius.circular(25),
//                                               //   ),
//                                               //   hintText: 'Enter Amount',
//                                               // ),
//                                               validator: (value) {
//                                                 if (value!.isEmpty) {
//                                                   return "Please enter break start time";
//                                                 } else {
//                                                   return null;
//                                                 }
//                                               },
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 Row(
//                                   children: [
//                                     Expanded(
//                                       child: Align(
//                                           alignment: Alignment.centerLeft,
//                                           child: Padding(
//                                             padding: const EdgeInsets.only(
//                                               left: 2.0,
//                                               right: 2.0,
//                                             ),
//                                             child: Container(
//                                               margin: const EdgeInsets.only(
//                                                 left: 8,
//                                                 right: 8,
//                                                 top: 8,
//                                               ),
//                                               padding: const EdgeInsets.all(8),
//                                               alignment: Alignment.center,
//                                               // height: size.height * 0.5,
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
//                                                       Color.fromARGB(
//                                                           255, 2, 92, 249),
//                                                       Color.fromARGB(
//                                                           255, 16, 1, 135),
//                                                     ],
//                                                   )),

//                                               child: const Text(
//                                                 "Reason",
//                                                 style: TextStyle(
//                                                   fontSize: 16.0,
//                                                   color: Colors.white,
//                                                   //fontWeight: FontWeight.bold
//                                                 ),
//                                               ),
//                                             ),
//                                           )),
//                                     ),
//                                     Expanded(
//                                       child: Container(
//                                         margin: const EdgeInsets.only(
//                                           left: 8,
//                                           right: 8,
//                                           top: 8,
//                                         ),
//                                         padding: const EdgeInsets.all(8),
//                                         alignment: Alignment.center,
//                                         height: size.height * 0.05,
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
//                                                 Colors.white,
//                                                 Colors.white,
//                                               ],
//                                             )),

//                                         child: Align(
//                                           alignment: Alignment.centerRight,
//                                           child: Padding(
//                                             padding: const EdgeInsets.all(2.0),
//                                             child: TextFormField(
//                                               //key: formkey4,
//                                               controller:
//                                                   _reasonTimeOfApplication,
//                                               style: const TextStyle(
//                                                   color: Color.fromARGB(255, 7, 59, 120),
//                                                   fontSize: 16),
//                                               obscureText: false,
//                                               // keyboardType: TextInputType.number,
//                                               // decoration: InputDecoration(
//                                               //   border: OutlineInputBorder(
//                                               //     borderRadius: BorderRadius.circular(25),
//                                               //   ),
//                                               //   enabledBorder: OutlineInputBorder(
//                                               //     borderSide: const BorderSide(
//                                               //       color: Color.fromARGB(255, 7, 59, 120),
//                                               //     ),
//                                               //     borderRadius: BorderRadius.circular(25),
//                                               //   ),
//                                               //   hintText: 'Enter Amount',
//                                               // ),
//                                               validator: (value) {
//                                                 if (value!.isEmpty) {
//                                                   return "Please enter reason";
//                                                 } else {
//                                                   return null;
//                                                 }
//                                               },
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 Row(
//                                   children: [
//                                     Expanded(
//                                       child: Align(
//                                           alignment: Alignment.centerLeft,
//                                           child: Padding(
//                                             padding: const EdgeInsets.only(
//                                               left: 2.0,
//                                               right: 2.0,
//                                             ),
//                                             child: Container(
//                                               margin: const EdgeInsets.only(
//                                                 left: 8,
//                                                 right: 8,
//                                                 top: 8,
//                                               ),
//                                               padding: const EdgeInsets.all(8),
//                                               alignment: Alignment.center,
//                                               // height: size.height * 0.5,
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
//                                                       Color.fromARGB(
//                                                           255, 2, 92, 249),
//                                                       Color.fromARGB(
//                                                           255, 16, 1, 135),
//                                                     ],
//                                                   )),

//                                               child: const Text(
//                                                 "Total Hours",
//                                                 style: TextStyle(
//                                                   fontSize: 16.0,
//                                                   color: Colors.white,
//                                                   //fontWeight: FontWeight.bold
//                                                 ),
//                                               ),
//                                             ),
//                                           )),
//                                     ),
//                                     Expanded(
//                                       child: Container(
//                                         margin: const EdgeInsets.only(
//                                           left: 8,
//                                           right: 8,
//                                           top: 8,
//                                         ),
//                                         padding: const EdgeInsets.all(8),
//                                         alignment: Alignment.center,
//                                         height: size.height * 0.05,
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
//                                                 Colors.white,
//                                                 Colors.white,
//                                               ],
//                                             )),

//                                         child: Align(
//                                           alignment: Alignment.centerRight,
//                                           child: Padding(
//                                             padding: const EdgeInsets.all(2.0),
//                                             child: TextFormField(
//                                               //key: formkey4,
//                                               controller: _totalHoursEquipment,
//                                               style: const TextStyle(
//                                                   color: Color.fromARGB(255, 7, 59, 120),
//                                                   fontSize: 16),
//                                               obscureText: false,
//                                               keyboardType:
//                                                   TextInputType.number,
//                                               // decoration: InputDecoration(
//                                               //   border: OutlineInputBorder(
//                                               //     borderRadius: BorderRadius.circular(25),
//                                               //   ),
//                                               //   enabledBorder: OutlineInputBorder(
//                                               //     borderSide: const BorderSide(
//                                               //       color: Color.fromARGB(255, 7, 59, 120),
//                                               //     ),
//                                               //     borderRadius: BorderRadius.circular(25),
//                                               //   ),
//                                               //   hintText: 'Enter Amount',
//                                               // ),
//                                               validator: (value) {
//                                                 if (value!.isEmpty) {
//                                                   return "Please enter Amount";
//                                                 } else {
//                                                   return null;
//                                                 }
//                                               },
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           );
//                         },
//                       ),
//                       Container(
//                           margin: const EdgeInsets.only(
//                               left: 6, right: 6, top: 20.0, bottom: 10),
//                           child: InkWell(
//                             onTap: () {
//                               // Navigator.pop(context);
//                             },
//                             child: Container(
//                               margin: const EdgeInsets.only(bottom: 10.0),
//                               // padding: const EdgeInsets.all(8),
//                               alignment: Alignment.center,
//                               width: size.width * 0.99,
//                               height: 40,
//                               decoration: BoxDecoration(
//                                   // shape: BoxShape.circle,
//                                   borderRadius: BorderRadius.circular(25),
//                                   boxShadow: const [
//                                     BoxShadow(
//                                          color: Color.fromARGB(
//                                                   255, 3, 47, 97),
//                                               blurRadius: 5,
//                                               offset: Offset(2.0, 5.0))
//                                         ],
//                                         gradient: const LinearGradient(
//                                           colors: [
//                                             Color.fromARGB(255, 7, 59, 120),
//                                             Color.fromARGB(255, 7, 59, 120)
//                                     ],
//                                   )),
//                               child: const Row(children: [
//                                 Expanded(
//                                   child: Align(
//                                     alignment: Alignment.center,
//                                     child: Text(
//                                       "Add Another Time of Applications",
//                                       textAlign: TextAlign.left,
//                                       style: TextStyle(
//                                         color: Colors.white,
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 20,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ]),
//                             ),
//                           )),
//                     ],
//                   ),
//                 ],
//               )),
//           Container(
//               margin:
//                   const EdgeInsets.only(left: 8, right: 8, top: 10, bottom: 8),
//               padding: const EdgeInsets.all(8),
//               alignment: Alignment.center,
//               // height: size.height * 0.5,
//               width: size.width * 0.99,
//               decoration: BoxDecoration(
//                   // shape: BoxShape.circle,
//                   borderRadius: BorderRadius.circular(10),
//                   boxShadow: const [
//                     BoxShadow(
//                         color: Color.fromARGB(255, 7, 59, 120),
//                         blurRadius: 10,
//                         offset: Offset(2.0, 5.0))
//                   ],
//                   gradient: const LinearGradient(
//                     colors: [
//                       Color.fromARGB(255, 255, 255, 255),
//                       Color.fromARGB(255, 255, 255, 255),
//                     ],
//                   )),
//               child: Column(children: [
//                 Container(
//                   padding: const EdgeInsets.all(10),
//                   alignment: Alignment.center,
//                   width: size.width * 0.99,
//                   // width: MediaQuery.of(context).size.width,
//                   // height: 40,
//                   decoration: const BoxDecoration(
//                       // shape: BoxShape.circle,
//                       //borderRadius: BorderRadius.circular(25),
//                       boxShadow: [
//                         BoxShadow(
//                             color: Color.fromARGB(
//                                                   255, 3, 47, 97),
//                                               blurRadius: 5,
//                                               offset: Offset(2.0, 5.0))
//                                         ],
//                                         gradient: LinearGradient(
//                                           colors: [
//                                             Color.fromARGB(255, 7, 59, 120),
//                                             Color.fromARGB(255, 7, 59, 120)
//                         ],
//                       )),
//                   child: const Row(children: [
//                     Align(
//                       alignment: Alignment.centerLeft,
//                       child: Text(
//                         "Weather Condition At Site",
//                         textAlign: TextAlign.left,
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 20,
//                         ),
//                       ),
//                     ),
//                   ]),
//                 ),
//                 Column(
//                   children: [
//                     const Align(
//                         alignment: Alignment.centerLeft,
//                         child: Padding(
//                           padding:
//                               EdgeInsets.only(top: 10.0, bottom: 2, left: 2),
//                           child: Text(
//                             "Select Weather Condition at Site",
//                             style:
//                                 TextStyle(fontSize: 16.0, color: Color.fromARGB(255, 7, 59, 120)),
//                           ),
//                         )),
//                     Align(
//                       alignment: Alignment.centerRight,
//                       child: Padding(
//                         padding: const EdgeInsets.all(2.0),
//                         child: Container(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 12, vertical: 4),
//                           // border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(25),
//                             border: Border.all(
//                               color: const Color.fromARGB(255, 7, 59, 120),
//                             ),
//                           ),

//                           child: DropdownButtonHideUnderline(
//                             child: DropdownButtonFormField<String>(
//                               hint: const Text('Select'),
//                               dropdownColor:
//                                   Colors.white,
//                               value: weatherConditionsAtSite,
//                               style: const TextStyle(
//                                   color: Color.fromARGB(255, 7, 59, 120), fontSize: 16),
//                               icon: const Icon(
//                                 Icons.arrow_drop_down,
//                                 color: Color.fromARGB(255, 7, 59, 120),
//                                 size: 20,
//                               ),
//                               decoration: const InputDecoration(
//                                 enabledBorder: UnderlineInputBorder(
//                                     borderSide:
//                                         BorderSide(color: Colors.transparent)),
//                                 focusedBorder: UnderlineInputBorder(
//                                     borderSide:
//                                         BorderSide(color: Colors.transparent)),
//                               ),
//                               isExpanded: true,
//                               items: select_weatherConditionsAtSite
//                                   .map(buildMenuItem)
//                                   .toList(),
//                               onChanged: (value) {
//                                 weatherConditionsAtSite = value;
//                                 setState(() {
//                                   getNumberOfWeatherConditionAtSiteLength();
//                                 });
//                                 // showLoaderDialog(context);
//                                 // getYear();
//                                 // getMonth();
//                                 // getData(program.toString(), year.toString(),
//                                 //     '0', '0');
//                               },
//                               validator: (value) =>
//                                   value == null ? 'field required' : null,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     ListView.builder(
//                       shrinkWrap: true,
//                       itemCount: numberOfWeatherConditionsAtSiteLength,
//                       // itemCount:  getDaysInBetween().attractions.length,
//                       // itemCount: numberOfDays.length,
//                       physics: const NeverScrollableScrollPhysics(),
//                       itemBuilder: (BuildContext context, int index) {
//                         return Container(
//                           margin: const EdgeInsets.only(
//                               left: 4, right: 4, top: 10, bottom: 8),
//                           padding: const EdgeInsets.all(8),
//                           alignment: Alignment.center,
//                           // height: size.height * 0.5,
//                           width: size.width * 0.99,
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
//                                 Color.fromARGB(255, 255, 255, 255),
//                                   Color.fromARGB(255, 255, 255, 255),
//                                 ],
//                               )),
//                           child: Column(
//                             children: [
//                               Row(
//                                 children: [
//                                   Expanded(
//                                     child: Container(
//                                       margin: const EdgeInsets.only(
//                                         left: 8,
//                                         right: 8,
//                                         top: 8,
//                                       ),
//                                       padding: const EdgeInsets.all(8),
//                                       alignment: Alignment.center,
//                                       height: size.height * 0.05,
//                                       // width: size.width * 0.99,
//                                       decoration: BoxDecoration(
//                                           // shape: BoxShape.circle,
//                                           borderRadius:
//                                               BorderRadius.circular(10),
//                                           boxShadow: const [
//                                             BoxShadow(
//                                                 color: Color.fromARGB(255, 7, 59, 120),
//                                                 blurRadius: 10,
//                                                 offset: Offset(2.0, 5.0))
//                                           ],
//                                           gradient: const LinearGradient(
//                                             colors: [
//                                               Colors.white,
//                                               Colors.white,
//                                             ],
//                                           )),

//                                       child: Align(
//                                         alignment: Alignment.centerRight,
//                                         child: Padding(
//                                           padding: const EdgeInsets.all(4.0),
//                                           child: TextFormField(
//                                             //key: formkey4,
//                                             controller: _time,
//                                             style: const TextStyle(
//                                                 color: Color.fromARGB(255, 7, 59, 120),
//                                                 fontSize: 16),
//                                             obscureText: false,
//                                             // keyboardType: TextInputType.number,
//                                             decoration: const InputDecoration(
//                                               // border: OutlineInputBorder(
//                                               //   borderRadius: BorderRadius.circular(25),
//                                               // ),
//                                               // enabledBorder: OutlineInputBorder(
//                                               //   borderSide: const BorderSide(
//                                               //     color: Color.fromARGB(255, 7, 59, 120),
//                                               //   ),
//                                               //   borderRadius: BorderRadius.circular(25),
//                                               // ),
//                                               hintText: 'Time',
//                                             ),
//                                             validator: (value) {
//                                               if (value!.isEmpty) {
//                                                 return "Please enter time";
//                                               } else {
//                                                 return null;
//                                               }
//                                             },
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   IconButton(
//                                       icon: const Icon(Icons.delete),
//                                       iconSize: 30,
//                                       color: const Color.fromARGB(255, 7, 59, 120),
//                                       onPressed: () {
//                                         // setState(() {
//                                         //   numberOfDays.removeAt(index);
//                                         // });
//                                       }),
//                                 ],
//                               ),
//                               Row(
//                                 children: [
//                                   Expanded(
//                                     child: Align(
//                                         alignment: Alignment.centerLeft,
//                                         child: Padding(
//                                           padding: const EdgeInsets.only(
//                                             left: 2.0,
//                                             right: 2.0,
//                                           ),
//                                           child: Container(
//                                             margin: const EdgeInsets.only(
//                                               left: 8,
//                                               right: 8,
//                                               top: 8,
//                                             ),
//                                             padding: const EdgeInsets.all(8),
//                                             alignment: Alignment.center,
//                                             // height: size.height * 0.5,
//                                             // width: size.width * 0.99,
//                                             decoration: BoxDecoration(
//                                                 // shape: BoxShape.circle,
//                                                 borderRadius:
//                                                     BorderRadius.circular(10),
//                                                 boxShadow: const [
//                                                   BoxShadow(
//                                                       color: Color.fromARGB(255, 7, 59, 120),
//                                                       blurRadius: 10,
//                                                       offset: Offset(2.0, 5.0))
//                                                 ],
//                                                 gradient: const LinearGradient(
//                                                   colors: [
//                                                     Color.fromARGB(
//                                                         255, 2, 92, 249),
//                                                     Color.fromARGB(
//                                                         255, 16, 1, 135),
//                                                   ],
//                                                 )),

//                                             child: const Text(
//                                               "Temperature (F)",
//                                               style: TextStyle(
//                                                 fontSize: 16.0,
//                                                 color: Colors.white,
//                                                 //fontWeight: FontWeight.bold
//                                               ),
//                                             ),
//                                           ),
//                                         )),
//                                   ),
//                                   Expanded(
//                                     child: Container(
//                                       margin: const EdgeInsets.only(
//                                         left: 8,
//                                         right: 8,
//                                         top: 8,
//                                       ),
//                                       padding: const EdgeInsets.all(8),
//                                       alignment: Alignment.center,
//                                       height: size.height * 0.05,
//                                       // width: size.width * 0.99,
//                                       decoration: BoxDecoration(
//                                           // shape: BoxShape.circle,
//                                           borderRadius:
//                                               BorderRadius.circular(10),
//                                           boxShadow: const [
//                                             BoxShadow(
//                                                 color: Color.fromARGB(255, 7, 59, 120),
//                                                 blurRadius: 10,
//                                                 offset: Offset(2.0, 5.0))
//                                           ],
//                                           gradient: const LinearGradient(
//                                             colors: [
//                                               Colors.white,
//                                               Colors.white,
//                                             ],
//                                           )),

//                                       child: Align(
//                                         alignment: Alignment.centerRight,
//                                         child: Padding(
//                                           padding: const EdgeInsets.all(2.0),
//                                           child: TextFormField(
//                                             //key: formkey4,
//                                             controller: _temperature,
//                                             style: const TextStyle(
//                                                 color: Color.fromARGB(255, 7, 59, 120),
//                                                 fontSize: 16),
//                                             obscureText: false,
//                                             keyboardType: TextInputType.number,
//                                             // decoration: InputDecoration(
//                                             //   border: OutlineInputBorder(
//                                             //     borderRadius: BorderRadius.circular(25),
//                                             //   ),
//                                             //   enabledBorder: OutlineInputBorder(
//                                             //     borderSide: const BorderSide(
//                                             //       color: Color.fromARGB(255, 7, 59, 120),
//                                             //     ),
//                                             //     borderRadius: BorderRadius.circular(25),
//                                             //   ),
//                                             //   hintText: 'Enter Amount',
//                                             // ),
//                                             validator: (value) {
//                                               if (value!.isEmpty) {
//                                                 return "Please temperature";
//                                               } else {
//                                                 return null;
//                                               }
//                                             },
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               Row(
//                                 children: [
//                                   Expanded(
//                                     child: Align(
//                                         alignment: Alignment.centerLeft,
//                                         child: Padding(
//                                           padding: const EdgeInsets.only(
//                                             left: 2.0,
//                                             right: 2.0,
//                                           ),
//                                           child: Container(
//                                             margin: const EdgeInsets.only(
//                                               left: 8,
//                                               right: 8,
//                                               top: 8,
//                                             ),
//                                             padding: const EdgeInsets.all(8),
//                                             alignment: Alignment.center,
//                                             // height: size.height * 0.5,
//                                             // width: size.width * 0.99,
//                                             decoration: BoxDecoration(
//                                                 // shape: BoxShape.circle,
//                                                 borderRadius:
//                                                     BorderRadius.circular(10),
//                                                 boxShadow: const [
//                                                   BoxShadow(
//                                                       color: Color.fromARGB(255, 7, 59, 120),
//                                                       blurRadius: 10,
//                                                       offset: Offset(2.0, 5.0))
//                                                 ],
//                                                 gradient: const LinearGradient(
//                                                   colors: [
//                                                     Color.fromARGB(
//                                                         255, 2, 92, 249),
//                                                     Color.fromARGB(
//                                                         255, 16, 1, 135),
//                                                   ],
//                                                 )),

//                                             child: const Text(
//                                               "Wind Speed (MPH)",
//                                               style: TextStyle(
//                                                 fontSize: 16.0,
//                                                 color: Colors.white,
//                                                 //fontWeight: FontWeight.bold
//                                               ),
//                                             ),
//                                           ),
//                                         )),
//                                   ),
//                                   Expanded(
//                                     child: Container(
//                                       margin: const EdgeInsets.only(
//                                         left: 8,
//                                         right: 8,
//                                         top: 8,
//                                       ),
//                                       padding: const EdgeInsets.all(8),
//                                       alignment: Alignment.center,
//                                       height: size.height * 0.05,
//                                       // width: size.width * 0.99,
//                                       decoration: BoxDecoration(
//                                           // shape: BoxShape.circle,
//                                           borderRadius:
//                                               BorderRadius.circular(10),
//                                           boxShadow: const [
//                                             BoxShadow(
//                                                 color: Color.fromARGB(255, 7, 59, 120),
//                                                 blurRadius: 10,
//                                                 offset: Offset(2.0, 5.0))
//                                           ],
//                                           gradient: const LinearGradient(
//                                             colors: [
//                                               Colors.white,
//                                               Colors.white,
//                                             ],
//                                           )),

//                                       child: Align(
//                                         alignment: Alignment.centerRight,
//                                         child: Padding(
//                                           padding: const EdgeInsets.all(2.0),
//                                           child: TextFormField(
//                                             //key: formkey4,
//                                             controller: _windSpeed,
//                                             style: const TextStyle(
//                                                 color: Color.fromARGB(255, 7, 59, 120),
//                                                 fontSize: 16),
//                                             obscureText: false,
//                                             keyboardType: TextInputType.number,
//                                             // decoration: InputDecoration(
//                                             //   border: OutlineInputBorder(
//                                             //     borderRadius: BorderRadius.circular(25),
//                                             //   ),
//                                             //   enabledBorder: OutlineInputBorder(
//                                             //     borderSide: const BorderSide(
//                                             //       color: Color.fromARGB(255, 7, 59, 120),
//                                             //     ),
//                                             //     borderRadius: BorderRadius.circular(25),
//                                             //   ),
//                                             //   hintText: 'Enter Amount',
//                                             // ),
//                                             validator: (value) {
//                                               if (value!.isEmpty) {
//                                                 return "Please enter wind speed";
//                                               } else {
//                                                 return null;
//                                               }
//                                             },
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               Row(
//                                 children: [
//                                   Expanded(
//                                     child: Align(
//                                         alignment: Alignment.centerLeft,
//                                         child: Padding(
//                                           padding: const EdgeInsets.only(
//                                             left: 2.0,
//                                             right: 2.0,
//                                           ),
//                                           child: Container(
//                                             margin: const EdgeInsets.only(
//                                               left: 8,
//                                               right: 8,
//                                               top: 8,
//                                             ),
//                                             padding: const EdgeInsets.all(8),
//                                             alignment: Alignment.center,
//                                             // height: size.height * 0.5,
//                                             // width: size.width * 0.99,
//                                             decoration: BoxDecoration(
//                                                 // shape: BoxShape.circle,
//                                                 borderRadius:
//                                                     BorderRadius.circular(10),
//                                                 boxShadow: const [
//                                                   BoxShadow(
//                                                       color: Color.fromARGB(255, 7, 59, 120),
//                                                       blurRadius: 10,
//                                                       offset: Offset(2.0, 5.0))
//                                                 ],
//                                                 gradient: const LinearGradient(
//                                                   colors: [
//                                                     Color.fromARGB(
//                                                         255, 2, 92, 249),
//                                                     Color.fromARGB(
//                                                         255, 16, 1, 135),
//                                                   ],
//                                                 )),

//                                             child: const Text(
//                                               "Wind Direction",
//                                               style: TextStyle(
//                                                 fontSize: 16.0,
//                                                 color: Colors.white,
//                                                 //fontWeight: FontWeight.bold
//                                               ),
//                                             ),
//                                           ),
//                                         )),
//                                   ),
//                                   Expanded(
//                                     child: Container(
//                                       margin: const EdgeInsets.only(
//                                         left: 8,
//                                         right: 8,
//                                         top: 8,
//                                       ),
//                                       padding: const EdgeInsets.all(8),
//                                       alignment: Alignment.center,
//                                       height: size.height * 0.05,
//                                       // width: size.width * 0.99,
//                                       decoration: BoxDecoration(
//                                           // shape: BoxShape.circle,
//                                           borderRadius:
//                                               BorderRadius.circular(10),
//                                           boxShadow: const [
//                                             BoxShadow(
//                                                 color: Color.fromARGB(255, 7, 59, 120),
//                                                 blurRadius: 10,
//                                                 offset: Offset(2.0, 5.0))
//                                           ],
//                                           gradient: const LinearGradient(
//                                             colors: [
//                                               Colors.white,
//                                               Colors.white,
//                                             ],
//                                           )),

//                                       child: Align(
//                                         alignment: Alignment.centerRight,
//                                         child: Padding(
//                                           padding: const EdgeInsets.all(2.0),
//                                           child: TextFormField(
//                                             //key: formkey4,
//                                             controller: _windDirection,
//                                             style: const TextStyle(
//                                                 color: Color.fromARGB(255, 7, 59, 120),
//                                                 fontSize: 16),
//                                             obscureText: false,
//                                             // keyboardType: TextInputType.number,
//                                             // decoration: InputDecoration(
//                                             //   border: OutlineInputBorder(
//                                             //     borderRadius: BorderRadius.circular(25),
//                                             //   ),
//                                             //   enabledBorder: OutlineInputBorder(
//                                             //     borderSide: const BorderSide(
//                                             //       color: Color.fromARGB(255, 7, 59, 120),
//                                             //     ),
//                                             //     borderRadius: BorderRadius.circular(25),
//                                             //   ),
//                                             //   hintText: 'Enter Amount',
//                                             // ),
//                                             validator: (value) {
//                                               if (value!.isEmpty) {
//                                                 return "Please enter reason";
//                                               } else {
//                                                 return null;
//                                               }
//                                             },
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         );
//                       },
//                     ),
//                     Container(
//                         margin: const EdgeInsets.only(
//                             left: 6, right: 6, top: 20.0, bottom: 10),
//                         child: InkWell(
//                           onTap: () {
//                             // Navigator.pop(context);
//                           },
//                           child: Container(
//                             margin: const EdgeInsets.only(bottom: 10.0),
//                             // padding: const EdgeInsets.all(8),
//                             alignment: Alignment.center,
//                             width: size.width * 0.99,
//                             height: 40,
//                             decoration: BoxDecoration(
//                                 // shape: BoxShape.circle,
//                                 borderRadius: BorderRadius.circular(25),
//                                 boxShadow: const [
//                                   BoxShadow(
//                                      color: Color.fromARGB(
//                                                   255, 3, 47, 97),
//                                               blurRadius: 5,
//                                               offset: Offset(2.0, 5.0))
//                                         ],
//                                         gradient: LinearGradient(
//                                           colors: [
//                                             Color.fromARGB(255, 7, 59, 120),
//                                             Color.fromARGB(255, 7, 59, 120)
//                                   ],
//                                 )),
//                             child: const Row(children: [
//                               Expanded(
//                                 child: Align(
//                                   alignment: Alignment.center,
//                                   child: Text(
//                                     "Add Another Weather Condition",
//                                     textAlign: TextAlign.left,
//                                     style: TextStyle(
//                                       color: Colors.white,
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 20,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ]),
//                           ),
//                         )),
//                   ],
//                 ),
//               ])),
//           Container(
//               margin:
//                   const EdgeInsets.only(left: 8, right: 8, top: 10, bottom: 8),
//               padding: const EdgeInsets.all(8),
//               alignment: Alignment.center,
//               // height: size.height * 0.5,
//               width: size.width * 0.99,
//               decoration: BoxDecoration(
//                   // shape: BoxShape.circle,
//                   borderRadius: BorderRadius.circular(10),
//                   boxShadow: const [
//                     BoxShadow(
//                         color: Color.fromARGB(255, 7, 59, 120),
//                         blurRadius: 10,
//                         offset: Offset(2.0, 5.0))
//                   ],
//                   gradient: const LinearGradient(
//                     colors: [
//                       Color.fromARGB(255, 255, 255, 255),
//                       Color.fromARGB(255, 255, 255, 255),
//                     ],
//                   )),
//               child: Column(
//                 children: [
//                   Container(
//                     padding: const EdgeInsets.all(10),
//                     alignment: Alignment.center,
//                     width: size.width * 0.99,
//                     // width: MediaQuery.of(context).size.width,
//                     // height: 40,
//                     decoration: const BoxDecoration(
//                         // shape: BoxShape.circle,
//                         //borderRadius: BorderRadius.circular(25),
//                         boxShadow: [
//                           BoxShadow(
//                               color: Color.fromARGB(
//                                                   255, 3, 47, 97),
//                                               blurRadius: 5,
//                                               offset: Offset(2.0, 5.0))
//                                         ],
//                                         gradient: LinearGradient(
//                                           colors: [
//                                             Color.fromARGB(255, 7, 59, 120),
//                                             Color.fromARGB(255, 7, 59, 120)
//                           ],
//                         )),
//                     child: const Row(children: [
//                       Align(
//                         alignment: Alignment.centerLeft,
//                         child: Text(
//                           "Applicant's",
//                           textAlign: TextAlign.left,
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 20,
//                           ),
//                         ),
//                       ),
//                     ]),
//                   ),
//                   Column(
//                     children: [
//                       const Align(
//                           alignment: Alignment.centerLeft,
//                           child: Padding(
//                             padding:
//                                 EdgeInsets.only(top: 10.0, bottom: 2, left: 2),
//                             child: Text(
//                               "Select Number of Applicants",
//                               style: TextStyle(
//                                   fontSize: 16.0, color: Color.fromARGB(255, 7, 59, 120)),
//                             ),
//                           )),
//                       Align(
//                         alignment: Alignment.centerRight,
//                         child: Padding(
//                           padding: const EdgeInsets.all(2.0),
//                           child: Container(
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 12, vertical: 4),
//                             // border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(25),
//                               border: Border.all(
//                                 color: const Color.fromARGB(255, 7, 59, 120),
//                               ),
//                             ),

//                             child: DropdownButtonHideUnderline(
//                               child: DropdownButtonFormField<String>(
//                                 hint: const Text('Select'),
//                                 dropdownColor:
//                                     Colors.white,
//                                 value: numberOfApplicants,
//                                 style: const TextStyle(
//                                     color: Color.fromARGB(255, 7, 59, 120), fontSize: 16),
//                                 icon: const Icon(
//                                   Icons.arrow_drop_down,
//                                   color: Color.fromARGB(255, 7, 59, 120),
//                                   size: 20,
//                                 ),
//                                 decoration: const InputDecoration(
//                                   enabledBorder: UnderlineInputBorder(
//                                       borderSide: BorderSide(
//                                           color: Colors.transparent)),
//                                   focusedBorder: UnderlineInputBorder(
//                                       borderSide: BorderSide(
//                                           color: Colors.transparent)),
//                                 ),
//                                 isExpanded: true,
//                                 items: select_numberOfApplicants
//                                     .map(buildMenuItem)
//                                     .toList(),
//                                 onChanged: (value) {
//                                   numberOfApplicants = value;
//                                   setState(() {
//                                     getNumberOfApplicantsLength();
//                                   });
//                                   // showLoaderDialog(context);
//                                   // getYear();
//                                   // getMonth();
//                                   // getData(program.toString(), year.toString(),
//                                   //     '0', '0');
//                                 },
//                                 validator: (value) =>
//                                     value == null ? 'field required' : null,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       ListView.builder(
//                         shrinkWrap: true,
//                         itemCount: numberOfNumberOfApplicantsLength,
//                         // itemCount:  getDaysInBetween().attractions.length,
//                         // itemCount: numberOfDays.length,
//                         physics: const NeverScrollableScrollPhysics(),
//                         itemBuilder: (BuildContext context, int index) {
//                           return Container(
//                             margin: const EdgeInsets.only(
//                                 left: 4, right: 4, top: 10, bottom: 8),
//                             padding: const EdgeInsets.all(8),
//                             alignment: Alignment.center,
//                             // height: size.height * 0.5,
//                             width: size.width * 0.99,
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
//                                     Color.fromARGB(255, 255, 255, 255),
//                                     Color.fromARGB(255, 255, 255, 255),
//                                   ],
//                                 )),
//                             child: Column(
//                               children: [
//                                 Row(
//                                   children: [
//                                     Expanded(
//                                       child: Container(
//                                         margin: const EdgeInsets.only(
//                                           left: 8,
//                                           right: 8,
//                                           top: 8,
//                                         ),
//                                         padding: const EdgeInsets.all(8),
//                                         alignment: Alignment.center,
//                                         height: size.height * 0.05,
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
//                                                 Colors.white,
//                                                 Colors.white,
//                                               ],
//                                             )),

//                                         child: Align(
//                                           alignment: Alignment.centerRight,
//                                           child: Padding(
//                                             padding: const EdgeInsets.all(4.0),
//                                             child: TextFormField(
//                                               //key: formkey4,
//                                               controller: _applicantsName,
//                                               style: const TextStyle(
//                                                   color: Color.fromARGB(255, 7, 59, 120),
//                                                   fontSize: 16),
//                                               obscureText: false,
//                                               // keyboardType: TextInputType.number,
//                                               decoration: const InputDecoration(
//                                                 // border: OutlineInputBorder(
//                                                 //   borderRadius: BorderRadius.circular(25),
//                                                 // ),
//                                                 // enabledBorder: OutlineInputBorder(
//                                                 //   borderSide: const BorderSide(
//                                                 //     color: Color.fromARGB(255, 7, 59, 120),
//                                                 //   ),
//                                                 //   borderRadius: BorderRadius.circular(25),
//                                                 // ),
//                                                 hintText: 'Applicant Name',
//                                               ),
//                                               validator: (value) {
//                                                 if (value!.isEmpty) {
//                                                   return "Please enter applicant name";
//                                                 } else {
//                                                   return null;
//                                                 }
//                                               },
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                     IconButton(
//                                         icon: const Icon(Icons.delete),
//                                         iconSize: 30,
//                                         color: const Color.fromARGB(255, 7, 59, 120),
//                                         onPressed: () {
//                                           // setState(() {
//                                           //   numberOfDays.removeAt(index);
//                                           // });
//                                         }),
//                                   ],
//                                 ),
//                                 Row(
//                                   children: [
//                                     Expanded(
//                                       child: Align(
//                                           alignment: Alignment.centerLeft,
//                                           child: Padding(
//                                             padding: const EdgeInsets.only(
//                                               left: 2.0,
//                                               right: 2.0,
//                                             ),
//                                             child: Container(
//                                               margin: const EdgeInsets.only(
//                                                 left: 8,
//                                                 right: 8,
//                                                 top: 8,
//                                               ),
//                                               padding: const EdgeInsets.all(8),
//                                               alignment: Alignment.center,
//                                               // height: size.height * 0.5,
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
//                                                       Color.fromARGB(
//                                                           255, 2, 92, 249),
//                                                       Color.fromARGB(
//                                                           255, 16, 1, 135),
//                                                     ],
//                                                   )),

//                                               child: const Text(
//                                                 "Applicant's License Number",
//                                                 style: TextStyle(
//                                                   fontSize: 16.0,
//                                                   color: Colors.white,
//                                                   //fontWeight: FontWeight.bold
//                                                 ),
//                                               ),
//                                             ),
//                                           )),
//                                     ),
//                                     Expanded(
//                                       child: Container(
//                                         margin: const EdgeInsets.only(
//                                           left: 8,
//                                           right: 8,
//                                           top: 8,
//                                         ),
//                                         padding: const EdgeInsets.all(8),
//                                         alignment: Alignment.center,
//                                         height: size.height * 0.05,
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
//                                                 Colors.white,
//                                                 Colors.white,
//                                               ],
//                                             )),

//                                         child: Align(
//                                           alignment: Alignment.centerRight,
//                                           child: Padding(
//                                             padding: const EdgeInsets.all(2.0),
//                                             child: TextFormField(
//                                               //key: formkey4,
//                                               controller:
//                                                   _applicantLicenseNumber,
//                                               style: const TextStyle(
//                                                   color: Color.fromARGB(255, 7, 59, 120),
//                                                   fontSize: 16),
//                                               obscureText: false,
//                                               keyboardType:
//                                                   TextInputType.number,
//                                               // decoration: InputDecoration(
//                                               //   border: OutlineInputBorder(
//                                               //     borderRadius: BorderRadius.circular(25),
//                                               //   ),
//                                               //   enabledBorder: OutlineInputBorder(
//                                               //     borderSide: const BorderSide(
//                                               //       color: Color.fromARGB(255, 7, 59, 120),
//                                               //     ),
//                                               //     borderRadius: BorderRadius.circular(25),
//                                               //   ),
//                                               //   hintText: 'Enter Amount',
//                                               // ),
//                                               validator: (value) {
//                                                 if (value!.isEmpty) {
//                                                   return "Please license number";
//                                                 } else {
//                                                   return null;
//                                                 }
//                                               },
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 Row(
//                                   children: [
//                                     Expanded(
//                                       child: Align(
//                                           alignment: Alignment.centerLeft,
//                                           child: Padding(
//                                             padding: const EdgeInsets.only(
//                                               left: 2.0,
//                                               right: 2.0,
//                                             ),
//                                             child: Container(
//                                               margin: const EdgeInsets.only(
//                                                 left: 8,
//                                                 right: 8,
//                                                 top: 8,
//                                               ),
//                                               padding: const EdgeInsets.all(8),
//                                               alignment: Alignment.center,
//                                               // height: size.height * 0.5,
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
//                                                       Color.fromARGB(
//                                                           255, 2, 92, 249),
//                                                       Color.fromARGB(
//                                                           255, 16, 1, 135),
//                                                     ],
//                                                   )),

//                                               child: const Text(
//                                                 "Applicant's Digital Signature",
//                                                 style: TextStyle(
//                                                   fontSize: 16.0,
//                                                   color: Colors.white,
//                                                   //fontWeight: FontWeight.bold
//                                                 ),
//                                               ),
//                                             ),
//                                           )),
//                                     ),
//                                     Expanded(
//                                       child: Container(
//                                         margin: const EdgeInsets.only(
//                                           left: 8,
//                                           right: 8,
//                                           top: 8,
//                                         ),
//                                         padding: const EdgeInsets.all(8),
//                                         alignment: Alignment.center,
//                                         height: size.height * 0.05,
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
//                                                 Colors.white,
//                                                 Colors.white,
//                                               ],
//                                             )),

//                                         child: Align(
//                                           alignment: Alignment.centerRight,
//                                           child: Padding(
//                                             padding: const EdgeInsets.all(2.0),
//                                             child: TextFormField(
//                                               //key: formkey4,
//                                               controller:
//                                                   _applicantDigitalSignature,
//                                               style: const TextStyle(
//                                                   color: Color.fromARGB(255, 7, 59, 120),
//                                                   fontSize: 16),
//                                               obscureText: false,
//                                               // keyboardType: TextInputType.number,
//                                               // decoration: InputDecoration(
//                                               //   border: OutlineInputBorder(
//                                               //     borderRadius: BorderRadius.circular(25),
//                                               //   ),
//                                               //   enabledBorder: OutlineInputBorder(
//                                               //     borderSide: const BorderSide(
//                                               //       color: Color.fromARGB(255, 7, 59, 120),
//                                               //     ),
//                                               //     borderRadius: BorderRadius.circular(25),
//                                               //   ),
//                                               //   hintText: 'Enter Amount',
//                                               // ),
//                                               validator: (value) {
//                                                 if (value!.isEmpty) {
//                                                   return "Please enter applicant's digital signature";
//                                                 } else {
//                                                   return null;
//                                                 }
//                                               },
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           );
//                         },
//                       ),
//                       Container(
//                           margin: const EdgeInsets.only(
//                               left: 6, right: 6, top: 20.0, bottom: 10),
//                           child: InkWell(
//                             onTap: () {
//                               // Navigator.pop(context);
//                             },
//                             child: Container(
//                               margin: const EdgeInsets.only(
//                                   left: 40, right: 40, bottom: 10.0),
//                               // padding: const EdgeInsets.all(8),
//                               alignment: Alignment.center,
//                               width: MediaQuery.of(context).size.width,
//                               height: 40,
//                               decoration: BoxDecoration(
//                                   // shape: BoxShape.circle,
//                                   borderRadius: BorderRadius.circular(25),
//                                   boxShadow: const [
//                                     BoxShadow(
//                                          color: Color.fromARGB(
//                                                   255, 3, 47, 97),
//                                               blurRadius: 5,
//                                               offset: Offset(2.0, 5.0))
//                                         ],
//                                         gradient: const LinearGradient(
//                                           colors: [
//                                             Color.fromARGB(255, 7, 59, 120),
//                                             Color.fromARGB(255, 7, 59, 120)
//                                     ],
//                                   )),
//                               child: const Row(children: [
//                                 Expanded(
//                                   child: Align(
//                                     alignment: Alignment.center,
//                                     child: Text(
//                                       "Add Another Applicant",
//                                       textAlign: TextAlign.left,
//                                       style: TextStyle(
//                                         color: Colors.white,
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 20,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ]),
//                             ),
//                           )),
//                     ],
//                   ),
//                 ],
//               )),
//           Container(
//               margin: const EdgeInsets.only(
//                   left: 6, right: 6, top: 20.0, bottom: 10),
//               child: InkWell(
//                 onTap: () {
//                   // Navigator.pop(context);
//                 },
//                 child: Container(
//                   margin:
//                       const EdgeInsets.only(left: 40, right: 40, bottom: 10.0),
//                   // padding: const EdgeInsets.all(8),
//                   alignment: Alignment.center,
//                   width: MediaQuery.of(context).size.width,
//                   height: 40,
//                   decoration: BoxDecoration(
//                       // shape: BoxShape.circle,
//                       borderRadius: BorderRadius.circular(25),
//                       boxShadow: const [
//                         BoxShadow(
//                             color: Color.fromARGB(
//                                                   255, 3, 47, 97),
//                                               blurRadius: 5,
//                                               offset: Offset(2.0, 5.0))
//                                         ],
//                                         gradient: LinearGradient(
//                                           colors: [
//                                             Color.fromARGB(255, 7, 59, 120),
//                                             Color.fromARGB(255, 7, 59, 120)
//                         ],
//                       )),
//                   child: const Row(children: [
//                     Expanded(
//                       child: Align(
//                         alignment: Alignment.center,
//                         child: Text(
//                           "Submit",
//                           textAlign: TextAlign.left,
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 20,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ]),
//                 ),
//               )),
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

//   void getNumberOfHerbicideLength() {
//     if (numberOfHerbicides == '1') {
//       numberOfHerbicidesLength = 1;
//     } else if (numberOfHerbicides == '2') {
//       numberOfHerbicidesLength = 2;
//     } else if (numberOfHerbicides == '3') {
//       numberOfHerbicidesLength = 3;
//     } else if (numberOfHerbicides == '4') {
//       numberOfHerbicidesLength = 4;
//     } else if (numberOfHerbicides == '5') {
//       numberOfHerbicidesLength = 5;
//     } else if (numberOfHerbicides == '6') {
//       numberOfHerbicidesLength = 6;
//     } else if (numberOfHerbicides == '7') {
//       numberOfHerbicidesLength = 7;
//     } else if (numberOfHerbicides == '8') {
//       numberOfHerbicidesLength = 8;
//     } else if (numberOfHerbicides == '9') {
//       numberOfHerbicidesLength = 9;
//     } else if (numberOfHerbicides == '10') {
//       numberOfHerbicidesLength = 10;
//     }
//   }

//   void getNumberOfEqipmentLength() {
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

//   void getNumberOfLaborLength() {
//     if (numberOfLabours == '1') {
//       numberOfLobourLength = 1;
//     } else if (numberOfLabours == '2') {
//       numberOfLobourLength = 2;
//     } else if (numberOfLabours == '3') {
//       numberOfLobourLength = 3;
//     } else if (numberOfLabours == '4') {
//       numberOfLobourLength = 4;
//     } else if (numberOfLabours == '5') {
//       numberOfLobourLength = 5;
//     } else if (numberOfLabours == '6') {
//       numberOfLobourLength = 6;
//     } else if (numberOfLabours == '7') {
//       numberOfLobourLength = 7;
//     } else if (numberOfLabours == '8') {
//       numberOfLobourLength = 8;
//     } else if (numberOfLabours == '9') {
//       numberOfLobourLength = 9;
//     } else if (numberOfLabours == '10') {
//       numberOfLobourLength = 10;
//     }
//   }

//   void getNumberOfTimeOfApplicationLength() {
//     if (numberOfApplications == '1') {
//       numberOfNumberOfApplicationsLength = 1;
//     } else if (numberOfApplications == '2') {
//       numberOfNumberOfApplicationsLength = 2;
//     } else if (numberOfApplications == '3') {
//       numberOfNumberOfApplicationsLength = 3;
//     } else if (numberOfApplications == '4') {
//       numberOfNumberOfApplicationsLength = 4;
//     } else if (numberOfApplications == '5') {
//       numberOfNumberOfApplicationsLength = 5;
//     } else if (numberOfApplications == '6') {
//       numberOfNumberOfApplicationsLength = 6;
//     } else if (numberOfApplications == '7') {
//       numberOfNumberOfApplicationsLength = 7;
//     } else if (numberOfApplications == '8') {
//       numberOfNumberOfApplicationsLength = 8;
//     } else if (numberOfApplications == '9') {
//       numberOfNumberOfApplicationsLength = 9;
//     } else if (numberOfApplications == '10') {
//       numberOfNumberOfApplicationsLength = 10;
//     }
//   }

//   void getNumberOfWeatherConditionAtSiteLength() {
//     if (weatherConditionsAtSite == '1') {
//       numberOfWeatherConditionsAtSiteLength = 1;
//     } else if (weatherConditionsAtSite == '2') {
//       numberOfWeatherConditionsAtSiteLength = 2;
//     } else if (weatherConditionsAtSite == '3') {
//       numberOfWeatherConditionsAtSiteLength = 3;
//     } else if (weatherConditionsAtSite == '4') {
//       numberOfWeatherConditionsAtSiteLength = 4;
//     } else if (weatherConditionsAtSite == '5') {
//       numberOfWeatherConditionsAtSiteLength = 5;
//     } else if (weatherConditionsAtSite == '6') {
//       numberOfWeatherConditionsAtSiteLength = 6;
//     } else if (weatherConditionsAtSite == '7') {
//       numberOfWeatherConditionsAtSiteLength = 7;
//     } else if (weatherConditionsAtSite == '8') {
//       numberOfWeatherConditionsAtSiteLength = 8;
//     } else if (weatherConditionsAtSite == '9') {
//       numberOfWeatherConditionsAtSiteLength = 9;
//     } else if (weatherConditionsAtSite == '10') {
//       numberOfWeatherConditionsAtSiteLength = 10;
//     }
//   }

//   void getNumberOfApplicantsLength() {
//     if (numberOfApplicants == '1') {
//       numberOfNumberOfApplicantsLength = 1;
//     } else if (numberOfApplicants == '2') {
//       numberOfNumberOfApplicantsLength = 2;
//     } else if (numberOfApplicants == '3') {
//       numberOfNumberOfApplicantsLength = 3;
//     } else if (numberOfApplicants == '4') {
//       numberOfNumberOfApplicantsLength = 4;
//     } else if (numberOfApplicants == '5') {
//       numberOfNumberOfApplicantsLength = 5;
//     } else if (numberOfApplicants == '6') {
//       numberOfNumberOfApplicantsLength = 6;
//     } else if (numberOfApplicants == '7') {
//       numberOfNumberOfApplicantsLength = 7;
//     } else if (numberOfApplicants == '8') {
//       numberOfNumberOfApplicantsLength = 8;
//     } else if (numberOfApplicants == '9') {
//       numberOfNumberOfApplicantsLength = 9;
//     } else if (numberOfApplicants == '10') {
//       numberOfNumberOfApplicantsLength = 10;
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
//               Navigator.pop(context);
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
//               Navigator.of(context).push(MaterialPageRoute(
//                   builder: (BuildContext context) =>
//                       const PowerTimeFormContractor()));
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
