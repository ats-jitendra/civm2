// import 'dart:convert';

// import 'package:CIVM/data/response/status.dart';
// import 'package:CIVM/models/user_model.dart';
// import 'package:CIVM/screens/planner_pannel.dart/total_order_pending_planner.dart';
// import 'package:CIVM/utils/custom_toast_snackbar_progressdialog.dart';
// import 'package:CIVM/utils/user_pref.dart';
// import 'package:CIVM/view_model/lcp_change_order_view_model.dart';
// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_typeahead/flutter_typeahead.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:intl/intl.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:provider/provider.dart';
// import '../../../models/lcpChangeOrderModel.dart';
// import 'dart:io';
// import 'package:device_info_plus/device_info_plus.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:http/http.dart' as http;
// import 'package:path/path.dart' as path;
// import 'package:file_selector/file_selector.dart';

// // ignore: must_be_immutable
// class CreateOrderPlanner extends StatefulWidget {
//   String tokenNo;
//   String subStation;
//   String feeder;
//   String serviceStreetAddress;
//   String serviceMapLocation;
//   String notes;
//   String type;
//   String maintType;
//   String contractorCompany;
//   String assignForeman;
//   String estimatedTime;
//   String estimatedCost;
//   String actualCost;
//   String crew;

//   CreateOrderPlanner(
//       {Key? key,
//       required this.tokenNo,
//       required this.subStation,
//       required this.feeder,
//       required this.serviceStreetAddress,
//       required this.serviceMapLocation,
//       required this.notes,
//       required this.type,
//       required this.maintType,
//       required this.contractorCompany,
//       required this.assignForeman,
//       required this.estimatedTime,
//       required this.estimatedCost,
//       required this.actualCost,
//       required this. crew})
//       : super(key: key);

//   @override
//   State<CreateOrderPlanner> createState() => _CreateOrderPlannerState();
// }

// class _CreateOrderPlannerState extends State<CreateOrderPlanner> {
//   List<String> menu = [];
//   bool _isVisibleOtherServiceStreetAddress = false;
//   bool _isVisibleOtherServiceMapLocation = false;

//   final TextEditingController _notes = TextEditingController();
//   final TextEditingController _otherServiceStreetAddress =
//       TextEditingController();
//   final TextEditingController _otherServiceMapLocation =
//       TextEditingController();
//   final TextEditingController _otherAssignForeman = TextEditingController();
//   final TextEditingController _estimatedCost = TextEditingController();
//   final TextEditingController _actualCost = TextEditingController();
//   final TextEditingController _contratorComapny = TextEditingController();

//   final TextEditingController _controllerTime = TextEditingController();
//   double _value = 0.0;

//   // int substationId = 0;
//   // ignore: prefer_typing_uninitialized_variables
//   var selectedSubstation;

//   var selectedFeeder;

//   String serviceStreetId = '';
//   // ignore: prefer_typing_uninitialized_variables
//   var selectedServiceStreet;

//   int mapLocationId = 0;
//   // ignore: prefer_typing_uninitialized_variables
//   var selectedMapLocation;

//   int maintenanceTypeId = 0;
//   // ignore: prefer_typing_uninitialized_variables
//   var selectedMaintenanceType;
//   // ignore: non_constant_identifier_names

//   int assignFormanId = 0;

//   // ignore: prefer_typing_uninitialized_variables
//   var selectedAssignForman;

//   File? image;
//   int setDataFlag = 0;
//   int feederFlag = 0;
//   int serviceStreetFlag = 0;
//   String substationName = '';
//   int substationId = 0;

//   bool _isVisibleImage = false;
//   bool _isVisibleImage2 = false;
//   bool _isVisibleImage3 = false;
//   bool _isVisibleImageDoc = false;
//   bool _isVisibleImage2Doc = false;
//   bool _isVisibleImage3Doc = false;
//   // bool _isVisibleUpdateMap = false;
//   // ignore: prefer_typing_uninitialized_variables
//   var deleteImage1;
//   // ignore: prefer_typing_uninitialized_variables
//   var deleteImage2;
//   // ignore: prefer_typing_uninitialized_variables
//   var deleteImage3;

//   // File? image1;
//   // File? image2;
//   // File? image3;
//   // String _imagePath = '';
//   // String _imagePath2 = '';
//   // String _imagePath3 = '';

//   List<String> imagePaths = [];
//   List<XFile> images = [];
//   String imagePath = '';
//   String imagePath2 = '';
//   String imagePath3 = '';

//   late List<CameraDescription> _cameras;
//   late CameraController _camerasController;

//   // ignore: non_constant_identifier_names
//   List<String> select_maintenanceType = [
//     // 'JARAFF',
//     // 'MOWING',
// 	  // 'MINI JARAFF',
// 	  // 'BYL',
//    	// 'BUCKET',
// 	  // 'GROUND',
//     // 'CROSS COUNTRY SPRAY',
//     // 'ROADSIDE SPRAY',
//     // 'NO SPRAY',
//     'DANGER TREE REMOVAL'
//   ];
//   String? maintenanceType = 'DANGER TREE REMOVAL';

//   List<String> types = ['DANGER TREE REMOVAL'];

//   final _formkey = GlobalKey<FormState>();

//   onTappedBar(int index) {
//     setState(() {
//       // _currentIndex = index;
//     });
//   }

//   LCPChangeOrderViewModel lcpChangeOrderViewModel = LCPChangeOrderViewModel();

//   final TextEditingController _typeAheadController = TextEditingController();

//   TimeOfDay _selectedTime = TimeOfDay.now();

//    var selectedCrew;
//     int crewId=0;

//   Future<void> _selectTime(BuildContext context) async {
//     final TimeOfDay? pickedTime = await showTimePicker(
//       context: context,
//       initialTime: _selectedTime,
//     );

//     if (pickedTime != null && pickedTime != _selectedTime) {
//       setState(() {
//         _selectedTime = pickedTime;
//       });
//     }
//   }

//   @override
//   void initState() {
//     lcpChangeOrderViewModel.fetchLCPChangeOrderViewListApi(
//         context,
//         widget.subStation,
//         '1',
//         'Get',
//         widget.serviceStreetAddress,
//         widget.serviceMapLocation,
//         substationId.toString(),
//         widget.contractorCompany);
//     cameraInit();
//     getData();
//     // getOwnPermissions();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//         appBar: AppBar(
//           iconTheme: const IconThemeData(color: Colors.white),
//           title:
//               const Text('Change Order', style: TextStyle(color: Colors.white)),
//           backgroundColor: const Color.fromARGB(255, 7, 59, 120),
//         ),
//         // drawer: DrawerManu(menu: menu),
//         body: ChangeNotifierProvider<LCPChangeOrderViewModel>(
//             create: (BuildContext context) => lcpChangeOrderViewModel,
//             child:
//                 Consumer<LCPChangeOrderViewModel>(builder: (context, value, _) {
//               switch (value.lcpChangeOrderList.status) {
//                 case Status.LOADING:
//                   return const Center(child: CircularProgressIndicator());
//                 case Status.ERROR:
//                   return
//                       // CustomToastSnackBarProgressDialog.flushBarErrorMessage(
//                       //     value.lcpChangeOrderList.message.toString(), context);
//                       Padding(
//                     padding: const EdgeInsets.only(
//                         top: 16.0, bottom: 16, left: 8, right: 8),
//                     child: Center(
//                       child: Align(
//                         alignment: Alignment.topCenter,
//                         child: Column(
//                           children: [
//                             Image.asset(
//                               'assets/empty_box.png',
//                               height: 200,
//                               width: 200,
//                               fit: BoxFit.cover,
//                             ),
//                             const Center(
//                               child: Text(
//                                 'Sorry, Data Not Found!',
//                                 textAlign: TextAlign.left,
//                                 style: TextStyle(
//                                   color: Color.fromARGB(255, 7, 59, 120),
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 20,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   );
//                 case Status.COMPLETED:
//                   String valueToAdd = 'OTHER';
//                   String valueToAddSecond = 'OTHER';
//                   List<GetAllStAddressListBySubstation> streetAddressList =
//                       lcpChangeOrderViewModel.lcpChangeOrderList.data!
//                           .getAllStAddressListBySubstation!;
//                   if (!streetAddressList
//                       .any((address) => address.serviceAddress == valueToAdd)) {
//                     streetAddressList.add(GetAllStAddressListBySubstation(
//                         serviceAddress: valueToAdd));
//                   }
//                   List<GetAllLocationsListBySubstationAndStAddress>
//                       mapLocationList = lcpChangeOrderViewModel
//                           .lcpChangeOrderList
//                           .data!
//                           .getAllLocationsListBySubstationAndStAddress!;
//                   if (!mapLocationList.any((address) =>
//                       address.serviceAddressLocation == valueToAddSecond)) {
//                     mapLocationList.add(
//                         GetAllLocationsListBySubstationAndStAddress(
//                             serviceAddressLocation: valueToAddSecond));
//                   }

//                   if (setDataFlag == 0) {
//                     getIdBySubstationName(widget.subStation);
//                     setDataFlag = 1;
//                   }

//                   // image upload API called after Update Order
//                   // if (imageFlag == 0) {
//                   //   print('check imageFlag');

//                   //   if (lcpChangeOrderViewModel
//                   //           .lcpCreateOrderSubmitData.data!.response![0].message
//                   //           .toString() ==
//                   //       'Successfully created') {
//                   //     print(lcpChangeOrderViewModel
//                   //         .lcpCreateOrderSubmitData.data!.response![0].message
//                   //         .toString());
//                   //     print(lcpChangeOrderViewModel
//                   //         .lcpCreateOrderSubmitData.data!.response![0].tokenNo
//                   //         .toString());
//                   //     submitImage(
//                   //         _imagePath!,
//                   //         lcpChangeOrderViewModel.lcpCreateOrderSubmitData.data!
//                   //             .response![0].tokenNo
//                   //             .toString());
//                   //   }
//                   // }
//                   return SingleChildScrollView(
//                     child: DefaultTabController(
//                       length: 2,
//                       child: Padding(
//                         padding: const EdgeInsets.all(4.0),
//                         child: Form(
//                           key: _formkey,
//                           child: Column(
//                             children: [
//                               Container(
//                                 margin: const EdgeInsets.only(
//                                     left: 8, right: 8, top: 10, bottom: 8),
//                                 padding: const EdgeInsets.all(8),
//                                 alignment: Alignment.center,
//                                 // height: size.height * 0.5,
//                                 width: size.width * 0.99,
//                                 decoration: BoxDecoration(
//                                     // shape: BoxShape.circle,
//                                     borderRadius: BorderRadius.circular(10),
//                                     boxShadow: const [
//                                       BoxShadow(
//                                           color:
//                                               Color.fromARGB(255, 7, 59, 120),
//                                           blurRadius: 10,
//                                           offset: Offset(2.0, 5.0))
//                                     ],
//                                     gradient: const LinearGradient(
//                                       colors: [
//                                         Color.fromARGB(255, 255, 255, 255),
//                                         Color.fromARGB(255, 255, 255, 255),
//                                       ],
//                                     )),
//                                 child: Column(
//                                   children: [
//                                     const Align(
//                                         alignment: Alignment.centerLeft,
//                                         child: Padding(
//                                           padding: EdgeInsets.only(
//                                               left: 2.0,
//                                               right: 2.0,
//                                               bottom: 2.0,
//                                               top: 8.0),
//                                           child: Text(
//                                             "SUBSTATION*",
//                                             style: TextStyle(
//                                                 fontSize: 16,
//                                                 color: Color.fromARGB(
//                                                     255, 7, 59, 120),
//                                                 fontWeight: FontWeight.bold),
//                                           ),
//                                         )),
//                                     Align(
//                                       alignment: Alignment.centerLeft,
//                                       child: Padding(
//                                         padding: const EdgeInsets.all(2.0),
//                                         child: DropdownButtonFormField<String>(
//                                           hint: const Text('-Select-'),
//                                           dropdownColor: Colors.white,
//                                           value: selectedSubstation,
//                                           style: const TextStyle(
//                                               color: Color.fromARGB(
//                                                   255, 7, 59, 120),
//                                               fontSize: 16),
//                                           icon: const Icon(
//                                             Icons.arrow_drop_down,
//                                             color:
//                                                 Color.fromARGB(255, 7, 59, 120),
//                                             size: 40,
//                                           ),
//                                           decoration: const InputDecoration(
//                                             enabledBorder: OutlineInputBorder(
//                                               borderSide: BorderSide(
//                                                 color: Color.fromARGB(
//                                                     255, 7, 59, 120),
//                                               ),
//                                             ),
//                                             focusedBorder: OutlineInputBorder(
//                                               borderSide: BorderSide(
//                                                 color: Color.fromARGB(
//                                                     255, 7, 59, 120),
//                                               ),
//                                             ),
//                                           ),
//                                           isExpanded: true,
//                                           items: lcpChangeOrderViewModel
//                                               .lcpChangeOrderList
//                                               .data!
//                                               .findAllIdAndSubstation!
//                                               .map((e) {
//                                             return DropdownMenuItem(
//                                               value: e.id.toString(),
//                                               child:
//                                                   Text(e.subStation.toString()),
//                                             );
//                                           }).toList(),
//                                           onChanged: (val) {
//                                             setState(() {
//                                               selectedSubstation = val;
//                                             });
//                                             selectedFeeder = null;
//                                             selectedServiceStreet = null;
//                                             selectedMapLocation = null;
//                                             _typeAheadController.clear();
//                                             substationId = int.parse(val!);

//                                             substationName =
//                                                 getSubstationNameById(val);
//                                             fetchData(
//                                                 substationName,
//                                                 '',
//                                                 '',
//                                                 '',
//                                                 '',
//                                                 substationId.toString());
//                                           },
//                                           validator: (value) => value == null
//                                               ? 'field required'
//                                               : null,
//                                         ),
//                                       ),
//                                     ),
//                                     const Align(
//                                         alignment: Alignment.centerLeft,
//                                         child: Padding(
//                                           padding: EdgeInsets.only(
//                                               left: 2.0,
//                                               right: 2.0,
//                                               bottom: 2.0,
//                                               top: 8.0),
//                                           child: Text(
//                                             "FEEDER*",
//                                             style: TextStyle(
//                                                 fontSize: 16,
//                                                 color: Color.fromARGB(
//                                                     255, 7, 59, 120),
//                                                 fontWeight: FontWeight.bold),
//                                           ),
//                                         )),
//                                     Align(
//                                       alignment: Alignment.centerLeft,
//                                       child: Padding(
//                                         padding: const EdgeInsets.all(2.0),
//                                         child: DropdownButtonFormField<String>(
//                                           hint: const Text('-Select-'),
//                                           dropdownColor: Colors.white,
//                                           value: selectedFeeder,
//                                           style: const TextStyle(
//                                               color: Color.fromARGB(
//                                                   255, 7, 59, 120),
//                                               fontSize: 16),
//                                           icon: const Icon(
//                                             Icons.arrow_drop_down,
//                                             color:
//                                                 Color.fromARGB(255, 7, 59, 120),
//                                             size: 40,
//                                           ),
//                                           decoration: const InputDecoration(
//                                             enabledBorder: OutlineInputBorder(
//                                               borderSide: BorderSide(
//                                                 color: Color.fromARGB(
//                                                     255, 7, 59, 120),
//                                               ),
//                                             ),
//                                             focusedBorder: OutlineInputBorder(
//                                               borderSide: BorderSide(
//                                                 color: Color.fromARGB(
//                                                     255, 7, 59, 120),
//                                               ),
//                                             ),
//                                           ),
//                                           isExpanded: true,
//                                           items: lcpChangeOrderViewModel
//                                               .lcpChangeOrderList
//                                               .data!
//                                               .getIdAndFeederBySubstationId!
//                                               .map((e) {
//                                             return DropdownMenuItem(
//                                               value: e.id.toString(),
//                                               child: Text(e.feeder.toString()),
//                                             );
//                                           }).toList(),
//                                           onChanged: (val) {
//                                             setState(() {
//                                               selectedFeeder = val;
//                                             });
//                                             selectedServiceStreet = null;
//                                             selectedMapLocation = null;
//                                             _typeAheadController.clear();
//                                             // substationId = int.parse(val!);

//                                             // substationName =
//                                             //     getSubstationNameById(val);
//                                             fetchData(
//                                                 substationName,
//                                                 '',
//                                                 '',
//                                                 '',
//                                                 '',
//                                                 substationId.toString());
//                                           },
//                                           validator: (value) => value == null
//                                               ? 'field required'
//                                               : null,
//                                         ),
//                                       ),
//                                     ),
//                                     const Align(
//                                         alignment: Alignment.centerLeft,
//                                         child: Padding(
//                                           padding: EdgeInsets.only(
//                                               left: 2.0,
//                                               right: 2.0,
//                                               bottom: 2.0,
//                                               top: 8.0),
//                                           child: Text(
//                                             "SERVICE STREET ADDRESS*",
//                                             style: TextStyle(
//                                                 fontSize: 16,
//                                                 color: Color.fromARGB(
//                                                     255, 7, 59, 120),
//                                                 fontWeight: FontWeight.bold),
//                                           ),
//                                         )),
//                                     // Align(
//                                     //   alignment: Alignment.centerLeft,
//                                     //   child: Padding(
//                                     //     padding: const EdgeInsets.all(2.0),
//                                     //     child: DropdownButtonFormField<String>(
//                                     //       hint: const Text('-Select-'),
//                                     //       dropdownColor: Colors.white,
//                                     //       value: selectedServiceStreet,
//                                     //       style: const TextStyle(
//                                     //           color: Color.fromARGB(
//                                     //               255, 7, 59, 120),
//                                     //           fontSize: 16),
//                                     //       icon: const Icon(
//                                     //         Icons.arrow_drop_down,
//                                     //         color:
//                                     //             Color.fromARGB(255, 7, 59, 120),
//                                     //         size: 40,
//                                     //       ),
//                                     //       decoration: const InputDecoration(
//                                     //         enabledBorder: OutlineInputBorder(
//                                     //           borderSide: BorderSide(
//                                     //             color: Color.fromARGB(
//                                     //                 255, 7, 59, 120),
//                                     //           ),
//                                     //         ),
//                                     //         focusedBorder: OutlineInputBorder(
//                                     //           borderSide: BorderSide(
//                                     //             color: Color.fromARGB(
//                                     //                 255, 7, 59, 120),
//                                     //           ),
//                                     //         ),
//                                     //       ),
//                                     //       isExpanded: true,
//                                     //       items: lcpChangeOrderViewModel
//                                     //           .lcpChangeOrderList
//                                     //           .data!
//                                     //           .getAllStAddressListBySubstation!
//                                     //           .map((e) {
//                                     //         return DropdownMenuItem(
//                                     //           value:
//                                     //               e.serviceAddress.toString(),
//                                     //           // e.getIdAndSubstationByCountId![0].subStation.toString(),
//                                     //           child: Text(
//                                     //               e.serviceAddress.toString()),
//                                     //         );
//                                     //       }).toList(),
//                                     //       onChanged: (val) {
//                                     //         setState(() {
//                                     //           selectedServiceStreet = val;
//                                     //           selectedMapLocation = null;
//                                     //         });
//                                     //         if (selectedServiceStreet ==
//                                     //             'OTHER') {
//                                     //           fetchData(
//                                     //               substationName,
//                                     //               '1',
//                                     //               'Get',
//                                     //               '',
//                                     //               '',
//                                     //               substationId.toString());
//                                     //           _isVisibleOtherServiceStreetAddress =
//                                     //               true;
//                                     //         } else {
//                                     //           fetchData(
//                                     //               substationName,
//                                     //               '1',
//                                     //               'Get',
//                                     //               val!,
//                                     //               '',
//                                     //               substationId.toString());
//                                     //           _isVisibleOtherServiceStreetAddress =
//                                     //               false;
//                                     //         }
//                                     //       },
//                                     //       validator: (value) => value == null
//                                     //           ? 'field required'
//                                     //           : null,
//                                     //     ),
//                                     //   ),
//                                     // ),
                                  
//                                     TypeAheadField<String>(
//   controller: _typeAheadController,

//   builder: (context, controller, focusNode) {
//     return TextField(
//       controller: controller,
//       focusNode: focusNode,
//       style: const TextStyle(
//         color: Color.fromARGB(255, 7, 59, 120),
//       ),
//       decoration: const InputDecoration(
//         hintText: '-Select-',
//         enabledBorder: OutlineInputBorder(
//           borderSide: BorderSide(
//             color: Color.fromARGB(255, 7, 59, 120),
//           ),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderSide: BorderSide(
//             color: Color.fromARGB(255, 7, 59, 120),
//           ),
//         ),
//       ),
//     );
//   },

//   suggestionsCallback: (pattern) {
//     return lcpChangeOrderViewModel
//         .lcpChangeOrderList.data!
//         .getAllStAddressListBySubstation!
//         .where((e) =>
//             e.serviceAddress != null &&
//             e.serviceAddress!
//                 .toLowerCase()
//                 .contains(pattern.toLowerCase()))
//         .map((e) => e.serviceAddress!)
//         .toList();
//   },

//   itemBuilder: (context, String suggestion) {
//     return ListTile(
//       title: Text(
//         suggestion,
//         style: const TextStyle(
//           color: Color.fromARGB(255, 7, 59, 120),
//         ),
//       ),
//     );
//   },

//   onSelected: (String suggestion) {
//     setState(() {
//       selectedServiceStreet = suggestion;
//       selectedMapLocation = null;
//       _typeAheadController.text = suggestion;
//     });

//     if (suggestion == 'OTHER') {
//       fetchData(substationName, '1', 'Get', '', '', substationId.toString());
//       setState(() {
//         _isVisibleOtherServiceStreetAddress = true;
//       });
//     } else {
//       fetchData(substationName, '1', 'Get', suggestion, '', substationId.toString());
//       setState(() {
//         _isVisibleOtherServiceStreetAddress = false;
//       });
//     }
//   },
// ),
//                                     Visibility(
//                                       visible:
//                                           _isVisibleOtherServiceStreetAddress,
//                                       child: Padding(
//                                         padding:
//                                             const EdgeInsets.only(top: 10.0),
//                                         child: Align(
//                                           alignment: Alignment.centerRight,
//                                           child: Padding(
//                                             padding: const EdgeInsets.only(
//                                                 right: 2.0,
//                                                 top: 2,
//                                                 bottom: 2,
//                                                 left: 2),
//                                             child: TextFormField(
//                                               //  key: formkey5,
//                                               controller:
//                                                   _otherServiceStreetAddress,
//                                               // onEditingComplete: fetchData(
//                                               //     substationId.toString(),
//                                               //     '1',
//                                               //     'INSERT',
//                                               //     _otherServiceStreetAddress.text
//                                               //         .toString(),
//                                               //     ''),
//                                               style: const TextStyle(
//                                                   color: Color.fromARGB(
//                                                       255, 7, 59, 120),
//                                                   fontSize: 16),
//                                               obscureText: false,
//                                               // keyboardType: TextInputType.number,
//                                               decoration: const InputDecoration(
//                                                 border: OutlineInputBorder(),
//                                                 enabledBorder:
//                                                     OutlineInputBorder(
//                                                   borderSide: BorderSide(
//                                                     color: Color.fromARGB(
//                                                         255, 7, 59, 120),
//                                                   ),
//                                                 ),
//                                                 hintText: '',
//                                               ),
//                                               onChanged: (value) {},
//                                               validator: (value) {
//                                                 if (value!.isEmpty) {
//                                                   return "";
//                                                 } else {
//                                                   fetchData(
//                                                       substationName,
//                                                       '1',
//                                                       'INSERT',
//                                                       _otherServiceStreetAddress
//                                                           .text
//                                                           .toString(),
//                                                       '',
//                                                       substationId.toString());
//                                                   return null;
//                                                 }
//                                               },
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                     const Align(
//                                         alignment: Alignment.centerLeft,
//                                         child: Padding(
//                                           padding: EdgeInsets.only(
//                                               left: 2.0,
//                                               right: 2.0,
//                                               bottom: 2.0,
//                                               top: 8.0),
//                                           child: Text(
//                                             "SERVICE MAP LOCATION*",
//                                             style: TextStyle(
//                                                 fontSize: 16,
//                                                 color: Color.fromARGB(
//                                                     255, 7, 59, 120),
//                                                 fontWeight: FontWeight.bold),
//                                           ),
//                                         )),
//                                     Align(
//                                       alignment: Alignment.centerLeft,
//                                       child: Padding(
//                                         padding: const EdgeInsets.all(2.0),
//                                         child: DropdownButtonFormField<String>(
//                                           hint: const Text('-Select-'),
//                                           dropdownColor: Colors.white,
//                                           value: selectedMapLocation,
//                                           style: const TextStyle(
//                                               color: Color.fromARGB(
//                                                   255, 7, 59, 120),
//                                               fontSize: 16),
//                                           icon: const Icon(
//                                             Icons.arrow_drop_down,
//                                             color:
//                                                 Color.fromARGB(255, 7, 59, 120),
//                                             size: 40,
//                                           ),
//                                           decoration: const InputDecoration(
//                                             enabledBorder: OutlineInputBorder(
//                                               borderSide: BorderSide(
//                                                 color: Color.fromARGB(
//                                                     255, 7, 59, 120),
//                                               ),
//                                             ),
//                                             focusedBorder: OutlineInputBorder(
//                                               borderSide: BorderSide(
//                                                 color: Color.fromARGB(
//                                                     255, 7, 59, 120),
//                                               ),
//                                             ),
//                                           ),
//                                           isExpanded: true,
//                                           items: lcpChangeOrderViewModel
//                                               .lcpChangeOrderList
//                                               .data!
//                                               .getAllLocationsListBySubstationAndStAddress!
//                                               .map((e) {
//                                             return DropdownMenuItem(
//                                               value: e.serviceAddressLocation
//                                                   .toString(),
//                                               // e.getIdAndSubstationByCountId![0].subStation.toString(),
//                                               child: Text(e
//                                                   .serviceAddressLocation
//                                                   .toString()),
//                                             );
//                                           }).toList(),
//                                           onChanged: (val) {
//                                             setState(() {
//                                               selectedMapLocation = val;
//                                             });
//                                             if (selectedMapLocation ==
//                                                 'OTHER') {
//                                               _isVisibleOtherServiceMapLocation =
//                                                   true;
//                                             } else {
//                                               fetchData(
//                                                   substationName,
//                                                   '1',
//                                                   'Get',
//                                                   selectedServiceStreet,
//                                                   val!,
//                                                   substationId.toString());
//                                               _isVisibleOtherServiceMapLocation =
//                                                   false;
//                                             }
//                                           },
//                                           validator: (value) => value == null
//                                               ? 'field required'
//                                               : null,
//                                         ),
//                                       ),
//                                     ),
//                                     Visibility(
//                                       visible:
//                                           _isVisibleOtherServiceMapLocation,
//                                       child: Padding(
//                                         padding:
//                                             const EdgeInsets.only(top: 10.0),
//                                         child: Align(
//                                           alignment: Alignment.centerRight,
//                                           child: Padding(
//                                             padding: const EdgeInsets.only(
//                                                 right: 2.0,
//                                                 top: 2,
//                                                 bottom: 2,
//                                                 left: 2),
//                                             child: TextFormField(
//                                               //  key: formkey5,
//                                               controller:
//                                                   _otherServiceMapLocation,
//                                               // onEditingComplete: onTextChanged,
//                                               style: const TextStyle(
//                                                   color: Color.fromARGB(
//                                                       255, 7, 59, 120),
//                                                   fontSize: 16),
//                                               obscureText: false,
//                                               // keyboardType: TextInputType.number,
//                                               decoration: const InputDecoration(
//                                                 border: OutlineInputBorder(),
//                                                 enabledBorder:
//                                                     OutlineInputBorder(
//                                                   borderSide: BorderSide(
//                                                     color: Color.fromARGB(
//                                                         255, 7, 59, 120),
//                                                   ),
//                                                 ),
//                                                 hintText: '',
//                                               ),

//                                               validator: (value) {
//                                                 if (value!.isEmpty) {
//                                                   return "";
//                                                 } else {
//                                                   return null;
//                                                 }
//                                               },
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                     const Align(
//                                         alignment: Alignment.centerLeft,
//                                         child: Padding(
//                                           padding: EdgeInsets.only(
//                                               left: 2.0,
//                                               right: 2.0,
//                                               bottom: 2.0,
//                                               top: 8.0),
//                                           child: Text(
//                                             "DESCRIPTION*",
//                                             style: TextStyle(
//                                                 fontSize: 16.0,
//                                                 color: Color.fromARGB(
//                                                     255, 7, 59, 120),
//                                                 fontWeight: FontWeight.bold),
//                                           ),
//                                         )),
//                                     Align(
//                                       alignment: Alignment.centerRight,
//                                       child: Padding(
//                                         padding: const EdgeInsets.all(2.0),
//                                         child: TextFormField(
//                                           //  key: formkey5,
//                                           controller: _notes,
//                                           style: const TextStyle(
//                                               color: Color.fromARGB(
//                                                   255, 7, 59, 120),
//                                               fontSize: 16),
//                                           obscureText: false,
//                                           // keyboardType: TextInputType.number,
//                                           decoration: const InputDecoration(
//                                             border: OutlineInputBorder(),
//                                             enabledBorder: OutlineInputBorder(
//                                               borderSide: BorderSide(
//                                                 color: Color.fromARGB(
//                                                     255, 7, 59, 120),
//                                               ),
//                                             ),
//                                             hintText: 'Description',
//                                           ),
//                                           validator: (value) {
//                                             if (value!.isEmpty) {
//                                               return "Please enter Description";
//                                             } else {
//                                               return null;
//                                             }
//                                           },
//                                         ),
//                                       ),
//                                     ),
//                                     // const Align(
//                                     //     alignment: Alignment.centerLeft,
//                                     //     child: Padding(
//                                     //       padding: EdgeInsets.only(
//                                     //           left: 2.0,
//                                     //           right: 2.0,
//                                     //           bottom: 2.0,
//                                     //           top: 8.0),
//                                     //       child: Text(
//                                     //         "MAINTENANCE TYPE*",
//                                     //         style: TextStyle(
//                                     //             fontSize: 16,
//                                     //             color: Color.fromARGB(
//                                     //                 255, 7, 59, 120),
//                                     //             fontWeight: FontWeight.bold),
//                                     //       ),
//                                     //     )),
//                                     // Align(
//                                     //   alignment: Alignment.centerRight,
//                                     //   child: Padding(
//                                     //     padding: const EdgeInsets.all(2.0),
//                                     //     child: Container(
//                                     //       padding: const EdgeInsets.symmetric(
//                                     //           horizontal: 12, vertical: 4),
//                                     //       decoration: BoxDecoration(
//                                     //         // borderRadius:
//                                     //         //     BorderRadius.circular(25),
//                                     //         border: Border.all(
//                                     //           color: const Color.fromARGB(
//                                     //               255, 7, 59, 120),
//                                     //         ),
//                                     //       ),
//                                     //       child: MultiSelectDialogField(
//                                     //         initialValue:
//                                     //             types, // Ensure this list is correct
//                                     //         items: select_maintenanceType
//                                     //             .map((e) =>
//                                     //                 MultiSelectItem(e, e))
//                                     //             .toList(),
//                                     //         listType: MultiSelectListType.CHIP,
//                                     //         onConfirm: (List<dynamic> value) {
//                                     //           // Use List<dynamic> as the type
//                                     //           setState(() {
//                                     //             maintenanceType =
//                                     //                 value.join(', ');
//                                     //             //  types.add(value.toString());
//                                     //           });
//                                     //           print(
//                                     //               maintenanceType); // This should print the selected values
//                                     //         },
//                                     //         validator: (value) => value == null
//                                     //             ? 'Field required'
//                                     //             : null, // Basic validation example
//                                     //       ),
//                                     //     ),
//                                     //   ),
//                                     // ),
                                  
//                                     const Align(
//                                         alignment: Alignment.centerLeft,
//                                         child: Padding(
//                                           padding: EdgeInsets.only(
//                                               left: 2.0,
//                                               right: 2.0,
//                                               bottom: 2.0,
//                                               top: 8.0),
//                                           child: Text(
//                                             "CONTRACTOR COMPANY*",
//                                             style: TextStyle(
//                                                 fontSize: 16,
//                                                 color: Color.fromARGB(
//                                                     255, 7, 59, 120),
//                                                 fontWeight: FontWeight.bold),
//                                           ),
//                                         )),
//                                     Align(
//                                       alignment: Alignment.centerRight,
//                                       child: Padding(
//                                         padding: const EdgeInsets.only(
//                                             right: 2.0,
//                                             top: 2,
//                                             bottom: 2,
//                                             left: 2),
//                                         child: TextFormField(
//                                           enabled: false,
//                                           //  key: formkey5,
//                                           controller: _contratorComapny,
//                                           style: const TextStyle(
//                                               color: Color.fromARGB(
//                                                   255, 7, 59, 120),
//                                               fontSize: 16),
//                                           obscureText: false,
//                                           // keyboardType: TextInputType.number,
//                                           decoration: const InputDecoration(
//                                             border: OutlineInputBorder(),
//                                             disabledBorder: OutlineInputBorder(
//                                               borderSide: BorderSide(
//                                                 color: Color.fromARGB(
//                                                     255, 7, 59, 120),
//                                               ),
//                                             ),
//                                             hintText: '',
//                                           ),
//                                           onChanged: (value) {},
//                                           validator: (value) {
//                                             if (value!.isEmpty) {
//                                               return "Please enter Contractor Company";
//                                             } else {
//                                               return null;
//                                             }
//                                           },
//                                         ),
//                                       ),
//                                     ),
//                                     const Align(
//                                         alignment: Alignment.centerLeft,
//                                         child: Padding(
//                                           padding: EdgeInsets.only(
//                                               left: 2.0,
//                                               right: 2.0,
//                                               bottom: 2.0,
//                                               top: 8.0),
//                                           child: Text(
//                                             "ASSIGN CREW TYPE*",
//                                             style: TextStyle(
//                                                 fontSize: 16,
//                                                 color: Color.fromARGB(
//                                                     255, 7, 59, 120),
//                                                 fontWeight: FontWeight.bold),
//                                           ),
//                                         )),
//                                     // Align(
//                                     //   alignment: Alignment.centerLeft,
//                                     //   child: Padding(
//                                     //     padding: const EdgeInsets.all(2.0),
//                                     //     child: DropdownButtonFormField<String>(
//                                     //       hint: const Text('-Select-'),
//                                     //       dropdownColor: Colors.white,
//                                     //       value: selectedAssignForman,
//                                     //       style: const TextStyle(
//                                     //           color: Color.fromARGB(
//                                     //               255, 7, 59, 120),
//                                     //           fontSize: 16),
//                                     //       icon: const Icon(
//                                     //         Icons.arrow_drop_down,
//                                     //         color:
//                                     //             Color.fromARGB(255, 7, 59, 120),
//                                     //         size: 40,
//                                     //       ),
//                                     //       decoration: const InputDecoration(
//                                     //         enabledBorder: OutlineInputBorder(
//                                     //           borderSide: BorderSide(
//                                     //             color: Color.fromARGB(
//                                     //                 255, 7, 59, 120),
//                                     //           ),
//                                     //         ),
//                                     //         focusedBorder: OutlineInputBorder(
//                                     //           borderSide: BorderSide(
//                                     //             color: Color.fromARGB(
//                                     //                 255, 7, 59, 120),
//                                     //           ),
//                                     //         ),
//                                     //       ),
//                                     //       isExpanded: true,
//                                     //       items: lcpChangeOrderViewModel
//                                     //           .lcpChangeOrderList
//                                     //           .data!
//                                     //           .contractorGetInsert!
//                                     //           .map((e) {
//                                     //         return DropdownMenuItem(
//                                     //           value: e.name.toString(),
//                                     //           // e.getIdAndSubstationByCountId![0].subStation.toString(),
//                                     //           child: Text(e.name.toString()),
//                                     //         );
//                                     //       }).toList(),
//                                     //       onChanged: (val) {
//                                     //         setState(() {
//                                     //           selectedAssignForman = val;
//                                     //         });
//                                     //         if (selectedAssignForman ==
//                                     //             'Other') {
//                                     //           _isVisibleOtherAssignForeman =
//                                     //               true;
//                                     //         } else {
//                                     //           _isVisibleOtherAssignForeman =
//                                     //               false;
//                                     //         }

//                                     //         List<ContractorGetInsert>?
//                                     //             loginIdList =
//                                     //             lcpChangeOrderViewModel
//                                     //                 .lcpChangeOrderList
//                                     //                 .data!
//                                     //                 .contractorGetInsert;
//                                     //         loginIdList?.forEach(
//                                     //             (ContractorGetInsert a) {
//                                     //           if (a.name ==
//                                     //               selectedAssignForman) {
//                                     //             assignFormanId = a.loginId!;
//                                     //           }
//                                     //         });
//                                     //       },
//                                     //       validator: (value) => value == null
//                                     //           ? 'field required'
//                                     //           : null,
//                                     //     ),
//                                     //   ),
//                                     // ),
//                                     // Visibility(
//                                     //   visible: _isVisibleOtherAssignForeman,
//                                     //   child: Padding(
//                                     //     padding:
//                                     //         const EdgeInsets.only(top: 10.0),
//                                     //     child: Align(
//                                     //       alignment: Alignment.centerRight,
//                                     //       child: Padding(
//                                     //         padding: const EdgeInsets.only(
//                                     //             right: 2.0,
//                                     //             top: 2,
//                                     //             bottom: 2,
//                                     //             left: 2),
//                                     //         child: TextFormField(
//                                     //           //  key: formkey5,
//                                     //           controller: _otherAssignForeman,
//                                     //           // onEditingComplete: onTextChanged,
//                                     //           style: const TextStyle(
//                                     //               color: Color.fromARGB(
//                                     //                   255, 7, 59, 120),
//                                     //               fontSize: 16),
//                                     //           obscureText: false,
//                                     //           // keyboardType: TextInputType.number,
//                                     //           decoration: const InputDecoration(
//                                     //             border: OutlineInputBorder(),
//                                     //             enabledBorder:
//                                     //                 OutlineInputBorder(
//                                     //               borderSide: BorderSide(
//                                     //                 color: Color.fromARGB(
//                                     //                     255, 7, 59, 120),
//                                     //               ),
//                                     //             ),
//                                     //             hintText: '',
//                                     //           ),

//                                     //           validator: (value) {
//                                     //             if (value!.isEmpty) {
//                                     //               return "";
//                                     //             } else {
//                                     //               return null;
//                                     //             }
//                                     //           },
//                                     //         ),
//                                     //       ),
//                                     //     ),
//                                     //   ),
//                                     // ),
//                                      Align(
//                                       alignment: Alignment.centerLeft,
//                                       child: Padding(
//                                         padding: const EdgeInsets.all(2.0),
//                                         child: DropdownButtonFormField<String>(
//                                           hint: const Text('-Select-'),
//                                           dropdownColor: Colors.white,
//                                           value: selectedCrew,
//                                           style: const TextStyle(
//                                               color: Color.fromARGB(
//                                                   255, 7, 59, 120),
//                                               fontSize: 16),
//                                           icon: const Icon(
//                                             Icons.arrow_drop_down,
//                                             color:
//                                                 Color.fromARGB(255, 7, 59, 120),
//                                             size: 40,
//                                           ),
//                                           decoration: const InputDecoration(
//                                             enabledBorder: OutlineInputBorder(
//                                               borderSide: BorderSide(
//                                                 color: Color.fromARGB(
//                                                     255, 7, 59, 120),
//                                               ),
//                                             ),
//                                             focusedBorder: OutlineInputBorder(
//                                               borderSide: BorderSide(
//                                                 color: Color.fromARGB(
//                                                     255, 7, 59, 120),
//                                               ),
//                                             ),
//                                           ),
//                                           isExpanded: true,
//                                           items: lcpChangeOrderViewModel
//                                               .lcpChangeOrderList
//                                               .data!
//                                               .allCrewListOfCrewMASTER!
//                                               .map((e) {
//                                             return DropdownMenuItem(
//                                               value: e.loginId.toString(),
//                                               // e.getIdAndSubstationByCountId![0].subStation.toString(),
//                                               child: Text(e.name.toString()),
//                                             );
//                                           }).toList(),
//                                           onChanged: (val) {
//                                             setState(() {
//                                               crewId = int.parse(val.toString());
//                                               print('crewId $crewId');
//                                             });
//                                           },
//                                           validator: (value) => value == null
//                                               ? 'field required'
//                                               : null,
//                                         ),
//                                       ),
//                                     ),
                                 
//                                     // const Align(
//                                     //     alignment: Alignment.centerLeft,
//                                     //     child: Padding(
//                                     //       padding: EdgeInsets.only(
//                                     //           left: 2.0,
//                                     //           right: 2.0,
//                                     //           bottom: 2.0,
//                                     //           top: 8.0),
//                                     //       child: Text(
//                                     //         "ESTIMATED COST*",
//                                     //         style: TextStyle(
//                                     //             fontSize: 16,
//                                     //             color: Color.fromARGB(
//                                     //                 255, 7, 59, 120),
//                                     //             fontWeight: FontWeight.bold),
//                                     //       ),
//                                     //     )),
//                                     // Align(
//                                     //   alignment: Alignment.centerRight,
//                                     //   child: Padding(
//                                     //     padding: const EdgeInsets.only(
//                                     //         right: 2.0,
//                                     //         top: 2,
//                                     //         bottom: 2,
//                                     //         left: 2),
//                                     //     child: TextFormField(
//                                     //       //  key: formkey5,
//                                     //       controller: _estimatedCost,
//                                     //       style: const TextStyle(
//                                     //           color: Color.fromARGB(
//                                     //               255, 7, 59, 120),
//                                     //           fontSize: 16),
//                                     //       obscureText: false,
//                                     //       keyboardType: TextInputType.number,
//                                     //       decoration: const InputDecoration(
//                                     //         border: OutlineInputBorder(),
//                                     //         enabledBorder: OutlineInputBorder(
//                                     //           borderSide: BorderSide(
//                                     //             color: Color.fromARGB(
//                                     //                 255, 7, 59, 120),
//                                     //           ),
//                                     //         ),
//                                     //         hintText: '',
//                                     //       ),
//                                     //       onChanged: (value) {},
//                                     //       validator: (value) {
//                                     //         if (value!.isEmpty) {
//                                     //           return "Please enter Estimated Cost";
//                                     //         } else {
//                                     //           return null;
//                                     //         }
//                                     //       },
//                                     //     ),
//                                     //   ),
//                                     // ),
//                                     const Align(
//                                         alignment: Alignment.centerLeft,
//                                         child: Padding(
//                                           padding: EdgeInsets.only(
//                                               left: 2.0, right: 2.0, top: 8.0),
//                                           child: Text(
//                                             "ESTIMATED TIME (HOURS)*",
//                                             style: TextStyle(
//                                                 fontSize: 16,
//                                                 color: Color.fromARGB(
//                                                     255, 7, 59, 120),
//                                                 fontWeight: FontWeight.bold),
//                                           ),
//                                         )),
//                                     // Padding(
//                                     //   padding: const EdgeInsets.all(2.0),
//                                     //   child: InkWell(
//                                     //     onTap: () async {
//                                     //       await _selectTime(context);
//                                     //     },
//                                     //     child: Container(
//                                     //       decoration: BoxDecoration(
//                                     //         border: Border.all(
//                                     //           color: const Color.fromARGB(
//                                     //               255, 7, 59, 120),
//                                     //         ),
//                                     //       ),
//                                     //       child: Padding(
//                                     //         padding: const EdgeInsets.all(2.0),
//                                     //         child: Padding(
//                                     //           padding: const EdgeInsets.only(
//                                     //               left: 8.0),
//                                     //           child: Row(
//                                     //             children: [
//                                     //               Expanded(
//                                     //                 child: Row(
//                                     //                   children: [
//                                     //                     Padding(
//                                     //                       padding:
//                                     //                           const EdgeInsets
//                                     //                               .only(top: 2),
//                                     //                       child: IconButton(
//                                     //                         icon: const Icon(
//                                     //                             Icons
//                                     //                                 .lock_clock),
//                                     //                         iconSize: 40,
//                                     //                         color: const Color
//                                     //                             .fromARGB(255,
//                                     //                             7, 59, 120),
//                                     //                         onPressed:
//                                     //                             () async {
//                                     //                           await _selectTime(
//                                     //                               context);
//                                     //                         },
//                                     //                       ),
//                                     //                     ),
//                                     //                     Expanded(
//                                     //                       child: Padding(
//                                     //                         padding:
//                                     //                             const EdgeInsets
//                                     //                                 .only(
//                                     //                                 left: 2),
//                                     //                         child: Text(
//                                     //                             _selectedTime
//                                     //                                 .format(
//                                     //                                     context),
//                                     //                             style:
//                                     //                                 const TextStyle(
//                                     //                               fontSize: 16,
//                                     //                               color: Color
//                                     //                                   .fromARGB(
//                                     //                                       255,
//                                     //                                       7,
//                                     //                                       59,
//                                     //                                       120),
//                                     //                             )),
//                                     //                       ),
//                                     //                     ),
//                                     //                   ],
//                                     //                 ),
//                                     //               ),
//                                     //             ],
//                                     //           ),
//                                     //         ),
//                                     //       ),
//                                     //     ),
//                                     //   ),
//                                     // ),

//                                     Padding(
//                                       padding: const EdgeInsets.only(left: 2),
//                                       child: Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceEvenly,
//                                         children: <Widget>[
//                                           Expanded(
//                                             flex: 3,
//                                             child: SizedBox(
//                                               child: TextFormField(
//                                                 controller: _controllerTime,
//                                                 style: const TextStyle(
//                                                     color: Color.fromARGB(
//                                                         255, 7, 59, 120),
//                                                     fontSize: 16),
//                                                 obscureText: false,
//                                                 // keyboardType: TextInputType.number,
//                                                 decoration:
//                                                     const InputDecoration(
//                                                   border: OutlineInputBorder(),
//                                                   enabledBorder:
//                                                       OutlineInputBorder(
//                                                     borderSide: BorderSide(
//                                                       color: Color.fromARGB(
//                                                           255, 7, 59, 120),
//                                                     ),
//                                                   ),
//                                                   hintText: '',
//                                                 ),
//                                                 keyboardType:
//                                                     const TextInputType
//                                                         .numberWithOptions(
//                                                         decimal: true),
//                                                 onChanged: (value) {
//                                                   setState(() {
//                                                     _value = double.tryParse(
//                                                             value) ??
//                                                         0.1;
//                                                     _value = _value.clamp(0.1,
//                                                         100000000.0); // Clamping value between 0.1 and 10.0
//                                                   });
//                                                 },
//                                               ),
//                                             ),
//                                           ),
//                                           Column(
//                                             children: [
//                                               IconButton(
//                                                 icon: const Icon(
//                                                   Icons.arrow_drop_up,
//                                                   color: Color.fromARGB(
//                                                       255, 7, 59, 120),
//                                                 ),
//                                                 onPressed: _increment,
//                                               ),
//                                               IconButton(
//                                                 icon: const Icon(
//                                                   Icons.arrow_drop_down,
//                                                   color: Color.fromARGB(
//                                                       255, 7, 59, 120),
//                                                 ),
//                                                 onPressed: _decrement,
//                                               ),
//                                             ],
//                                           ),
//                                         ],
//                                       ),
//                                     ),

//                                     // const Align(
//                                     //     alignment: Alignment.centerLeft,
//                                     //     child: Padding(
//                                     //       padding: EdgeInsets.only(
//                                     //           left: 2.0,
//                                     //           right: 2.0,
//                                     //           bottom: 2.0),
//                                     //       child: Text(
//                                     //         "ACTUAL COST",
//                                     //         style: TextStyle(
//                                     //             fontSize: 16,
//                                     //             color: Color.fromARGB(
//                                     //                 255, 7, 59, 120),
//                                     //             fontWeight: FontWeight.bold),
//                                     //       ),
//                                     //     )),
//                                     // Align(
//                                     //   alignment: Alignment.centerRight,
//                                     //   child: Padding(
//                                     //     padding: const EdgeInsets.only(
//                                     //         right: 2.0,
//                                     //         top: 2,
//                                     //         bottom: 2,
//                                     //         left: 2),
//                                     //     child: TextFormField(
//                                     //       //  key: formkey5,
//                                     //       controller: _actualCost,
//                                     //       style: const TextStyle(
//                                     //           color: Color.fromARGB(
//                                     //               255, 7, 59, 120),
//                                     //           fontSize: 16),
//                                     //       obscureText: false,
//                                     //        keyboardType: TextInputType.number,
//                                     //       decoration: const InputDecoration(
//                                     //         border: OutlineInputBorder(),
//                                     //         enabledBorder: OutlineInputBorder(
//                                     //           borderSide: BorderSide(
//                                     //             color: Color.fromARGB(
//                                     //                 255, 7, 59, 120),
//                                     //           ),
//                                     //         ),
//                                     //         hintText: '',
//                                     //       ),
//                                     //       onChanged: (value) {},
//                                     //       validator: (value) {
//                                     //         if (value!.isEmpty) {
//                                     //           return "Please enter Actual Cost";
//                                     //         } else {
//                                     //           return null;
//                                     //         }
//                                     //       },
//                                     //     ),
//                                     //   ),
//                                     // ),
//                                     /////////////running code of image uploading/////////////
//                                     // const Align(
//                                     //     alignment: Alignment.centerLeft,
//                                     //     child: Padding(
//                                     //       padding: EdgeInsets.only(
//                                     //           left: 2.0,
//                                     //           right: 2.0,
//                                     //           bottom: 2.0,
//                                     //           top: 8.0),
//                                     //       child: Text(
//                                     //         "UPLOAD (IMAGE, PDF)*",
//                                     //         style: TextStyle(
//                                     //             fontSize: 16,
//                                     //             color: Color.fromARGB(
//                                     //                 255, 7, 59, 120),
//                                     //             fontWeight: FontWeight.bold),
//                                     //       ),
//                                     //     )),
//                                     // Container(
//                                     //   margin: const EdgeInsets.only(
//                                     //       bottom: 10.0, top: 2),
//                                     //   padding: const EdgeInsets.all(8),
//                                     //   alignment: Alignment.center,
//                                     //   width: size.width * 1,
//                                     //   height: 50,
//                                     //   decoration: const BoxDecoration(
//                                     //       boxShadow: [
//                                     //         BoxShadow(
//                                     //             color: Color.fromARGB(
//                                     //                 255, 3, 47, 97),
//                                     //             blurRadius: 5,
//                                     //             offset: Offset(2.0, 5.0))
//                                     //       ],
//                                     //       color: Color.fromARGB(
//                                     //           255, 130, 193, 245),
//                                     //       gradient: LinearGradient(
//                                     //         colors: [
//                                     //           Colors.white,
//                                     //           Colors.white,
//                                     //         ],
//                                     //       )),
//                                     //   child: Row(
//                                     //     children: [
//                                     //       InkWell(
//                                     //           onTap: () {
//                                     //             _checkPermission(context);
//                                     //           },
//                                     //           child: const Text(
//                                     //             'Choose File',
//                                     //             style: TextStyle(
//                                     //               fontSize: 16,
//                                     //               color: Color.fromARGB(
//                                     //                   255, 7, 59, 120),
//                                     //               //fontWeight: FontWeight.bold
//                                     //             ),
//                                     //           )),
//                                     //       // Padding(
//                                     //       //   padding:
//                                     //       //       const EdgeInsets.only(left: 8.0),
//                                     //       //   child: Container(
//                                     //       //     width: 1,
//                                     //       //     height: 50,
//                                     //       //     color: Colors.black,
//                                     //       //   ),
//                                     //       // ),
//                                     //       // Expanded(
//                                     //       //   child: Padding(
//                                     //       //     padding: const EdgeInsets.only(
//                                     //       //         left: 8.0),
//                                     //       //     child: Text(
//                                     //       //       ((_imagePath.isEmpty) &&
//                                     //       //               (_imagePath2.isEmpty) &&
//                                     //       //               (_imagePath3.isEmpty))
//                                     //       //           ? 'No file selected'
//                                     //       //           : (_imagePath.isNotEmpty ||
//                                     //       //                   _imagePath2
//                                     //       //                       .isNotEmpty ||
//                                     //       //                   _imagePath3
//                                     //       //                       .isNotEmpty)
//                                     //       //               ? '3 files selected'
//                                     //       //               : (_imagePath
//                                     //       //                           .isNotEmpty ||
//                                     //       //                       _imagePath2
//                                     //       //                           .isEmpty ||
//                                     //       //                       _imagePath3
//                                     //       //                           .isEmpty)
//                                     //       //                   ? '1 file selected'
//                                     //       //                   : (_imagePath
//                                     //       //                               .isEmpty ||
//                                     //       //                           _imagePath2
//                                     //       //                               .isNotEmpty ||
//                                     //       //                           _imagePath3
//                                     //       //                               .isEmpty)
//                                     //       //                       ? '1 file selected'
//                                     //       //                       : (_imagePath
//                                     //       //                                   .isNotEmpty &&
//                                     //       //                               _imagePath2
//                                     //       //                                   .isEmpty &&
//                                     //       //                               _imagePath3
//                                     //       //                                   .isEmpty)
//                                     //       //                           ? '1 file selected'
//                                     //       //                           : (_imagePath
//                                     //       //                                       .isEmpty &&
//                                     //       //                                   _imagePath2
//                                     //       //                                       .isNotEmpty &&
//                                     //       //                                   _imagePath3
//                                     //       //                                       .isEmpty)
//                                     //       //                               ? '1 file selected'
//                                     //       //                               : (_imagePath.isEmpty &&
//                                     //       //                                       _imagePath2.isEmpty &&
//                                     //       //                                       _imagePath3.isNotEmpty)
//                                     //       //                                   ? '1 file selected'
//                                     //       //                                   : (_imagePath.isNotEmpty && _imagePath2.isNotEmpty && _imagePath3.isEmpty)
//                                     //       //                                       ? '2 files selected'
//                                     //       //                                       : (_imagePath.isNotEmpty && _imagePath2.isEmpty && _imagePath3.isNotEmpty)
//                                     //       //                                           ? '2 files selected'
//                                     //       //                                           : (_imagePath.isEmpty && _imagePath2.isNotEmpty && _imagePath3.isNotEmpty)
//                                     //       //                                               ? '2 files selected'
//                                     //       //                                               : 'No File selected',
//                                     //       //       style: const TextStyle(
//                                     //       //         fontSize: 16,
//                                     //       //         color: Color.fromARGB(
//                                     //       //             255, 7, 59, 120),
//                                     //       //       ),
//                                     //       //     ),
//                                     //       //   ),
//                                     //       // ),
//                                     //     ],
//                                     //   ),
//                                     // ),
//                                     // Row(
//                                     //   children: [
//                                     //     Expanded(
//                                     //       child: Visibility(
//                                     //         visible: _isVisibleImageDoc,
//                                     //         child: Stack(
//                                     //           children: [
//                                     //             if (_imagePath.isNotEmpty)
//                                     //               Center(
//                                     //                 child: Icon(
//                                     //                   getFileTypeIcon(
//                                     //                       _imagePath),
//                                     //                   size: 100,
//                                     //                 ),
//                                     //               ),
//                                     //             InkWell(
//                                     //               onTap: () async {
//                                     //                 setState(() {
//                                     //                   _isVisibleImageDoc =
//                                     //                       false;
//                                     //                 });
//                                     //                 deleteOnlineImageApi(
//                                     //                     _imagePath);
//                                     //               },
//                                     //               child: const Icon(
//                                     //                   Icons.delete,
//                                     //                   color: Colors.red,
//                                     //                   size: 50),
//                                     //             ),
//                                     //           ],
//                                     //         ),
//                                     //       ),
//                                     //     ),
//                                     //     Expanded(
//                                     //       child: Visibility(
//                                     //         visible: _isVisibleImage2Doc,
//                                     //         child: Stack(
//                                     //           children: [
//                                     //             if (_imagePath2.isNotEmpty)
//                                     //               Center(
//                                     //                 child: Icon(
//                                     //                   getFileTypeIcon(
//                                     //                       _imagePath2),
//                                     //                   size: 100,
//                                     //                 ),
//                                     //               ),
//                                     //             InkWell(
//                                     //               onTap: () {
//                                     //                 setState(() {
//                                     //                   _isVisibleImage2Doc =
//                                     //                       false;
//                                     //                 });
//                                     //                 deleteOnlineImageApi(
//                                     //                     _imagePath2);
//                                     //               },
//                                     //               child: const Icon(
//                                     //                   Icons.delete,
//                                     //                   color: Colors.red,
//                                     //                   size: 50),
//                                     //             ),
//                                     //           ],
//                                     //         ),
//                                     //       ),
//                                     //     ),
//                                     //     Expanded(
//                                     //       child: Visibility(
//                                     //         visible: _isVisibleImage3Doc,
//                                     //         child: Stack(
//                                     //           children: [
//                                     //             if (_imagePath3.isNotEmpty)
//                                     //               Center(
//                                     //                 child: Icon(
//                                     //                   getFileTypeIcon(
//                                     //                       _imagePath3),
//                                     //                   size: 100,
//                                     //                 ),
//                                     //               ),
//                                     //             InkWell(
//                                     //               onTap: () {
//                                     //                 setState(() {
//                                     //                   _isVisibleImage3Doc =
//                                     //                       false;
//                                     //                 });
//                                     //                 deleteOnlineImageApi(
//                                     //                     _imagePath3);
//                                     //               },
//                                     //               child: const Icon(
//                                     //                   Icons.delete,
//                                     //                   color: Colors.red,
//                                     //                   size: 50),
//                                     //             ),
//                                     //           ],
//                                     //         ),
//                                     //       ),
//                                     //     ),
//                                     //   ],
//                                     // ),

//                                     // Row(
//                                     //   children: [
//                                     //     Expanded(
//                                     //       child: Visibility(
//                                     //         visible: _isVisibleImage,
//                                     //         child: Stack(
//                                     //           children: [
//                                     //             if (_imagePath.isNotEmpty)
//                                     //               Image.file(
//                                     //                 File(_imagePath),
//                                     //                 height: 200,
//                                     //                 width: 200,
//                                     //                 fit: BoxFit.cover,
//                                     //               ),
//                                     //             InkWell(
//                                     //               onTap: () async {
//                                     //                 setState(() {
//                                     //                   _isVisibleImage = false;
//                                     //                 });
//                                     //                 deleteOnlineImageApi(
//                                     //                     deleteImage1);
//                                     //               },
//                                     //               child: const Icon(
//                                     //                   Icons.delete,
//                                     //                   color: Colors.red,
//                                     //                   size: 50),
//                                     //             ),
//                                     //           ],
//                                     //         ),
//                                     //       ),
//                                     //     ),
//                                     //     Expanded(
//                                     //       child: Visibility(
//                                     //         visible: _isVisibleImage2,
//                                     //         child: Stack(
//                                     //           children: [
//                                     //             if (_imagePath2.isNotEmpty)
//                                     //               Image.file(
//                                     //                 File(_imagePath),
//                                     //                 height: 200,
//                                     //                 width: 200,
//                                     //                 fit: BoxFit.cover,
//                                     //               ),
//                                     //             InkWell(
//                                     //               onTap: () {
//                                     //                 setState(() {
//                                     //                   _isVisibleImage2 = false;
//                                     //                 });
//                                     //                 deleteOnlineImageApi(
//                                     //                     deleteImage2);
//                                     //               },
//                                     //               child: const Icon(
//                                     //                   Icons.delete,
//                                     //                   color: Colors.red,
//                                     //                   size: 50),
//                                     //             ),
//                                     //           ],
//                                     //         ),
//                                     //       ),
//                                     //     ),
//                                     //     Expanded(
//                                     //       child: Visibility(
//                                     //         visible: _isVisibleImage3,
//                                     //         child: Stack(
//                                     //           children: [
//                                     //             if (_imagePath3.isNotEmpty)
//                                     //               Image.file(
//                                     //                 File(_imagePath3),
//                                     //                 height: 200,
//                                     //                 width: 200,
//                                     //                 fit: BoxFit.cover,
//                                     //               ),
//                                     //             InkWell(
//                                     //               onTap: () {
//                                     //                 setState(() {
//                                     //                   _isVisibleImage3 = false;
//                                     //                 });
//                                     //                 deleteOnlineImageApi(
//                                     //                     deleteImage3);
//                                     //               },
//                                     //               child: const Icon(
//                                     //                   Icons.delete,
//                                     //                   color: Colors.red,
//                                     //                   size: 50),
//                                     //             ),
//                                     //           ],
//                                     //         ),
//                                     //       ),
//                                     //     ),
//                                     //   ],
//                                     // ),

//                                     Row(
//                                       children: [
//                                         const Expanded(
//                                           child: Align(
//                                               alignment: Alignment.centerLeft,
//                                               child: Padding(
//                                                 padding: EdgeInsets.only(
//                                                     left: 2.0,
//                                                     right: 2.0,
//                                                     bottom: 2.0,
//                                                     top: 8.0),
//                                                 child: Text(
//                                                   "UPLOAD (IMAGE, PDF)*",
//                                                   style: TextStyle(
//                                                       fontSize: 16,
//                                                       color: Color.fromARGB(
//                                                           255, 7, 59, 120),
//                                                       fontWeight:
//                                                           FontWeight.bold),
//                                                 ),
//                                               )),
//                                         ),
//                                         Expanded(
//                                           child: Align(
//                                             alignment: Alignment.bottomLeft,
//                                             child: InkWell(
//                                               onTap: () {
//                                                 pickImageOptions();
//                                               },
//                                               child: Container(
//                                                 margin: const EdgeInsets.only(
//                                                     bottom: 10.0, top: 2),
//                                                 padding:
//                                                     const EdgeInsets.all(8),
//                                                 alignment: Alignment.center,
//                                                 // width: size.width * 0.5,
//                                                 height: 40,
//                                                 decoration: BoxDecoration(
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             10),
//                                                     boxShadow: const [
//                                                       BoxShadow(
//                                                           color: Color.fromARGB(
//                                                               255, 1, 29, 62),
//                                                           blurRadius: 5,
//                                                           offset:
//                                                               Offset(2.0, 5.0))
//                                                     ],
//                                                     color: const Color.fromARGB(
//                                                         255, 1, 29, 62),
//                                                     gradient:
//                                                         const LinearGradient(
//                                                       colors: [
//                                                         Color.fromARGB(
//                                                             255, 7, 59, 120),
//                                                         Color.fromARGB(
//                                                             255, 7, 59, 120)
//                                                       ],
//                                                     )),
//                                                 child: const Row(
//                                                   children: [
//                                                     Text(
//                                                       'Choose File',
//                                                       style: TextStyle(
//                                                         fontSize: 16,
//                                                         color: Colors.white,
//                                                         //fontWeight: FontWeight.bold
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                     SingleChildScrollView(
//                                       scrollDirection: Axis.horizontal,
//                                       child: Row(
//                                         children: List.generate(
//                                             imagePaths.length, (index) {
//                                           return Container(
//                                             margin: const EdgeInsets.symmetric(
//                                                 horizontal:
//                                                     5), // Optional: Add margin for spacing
//                                             width:
//                                                 100, // Set a fixed width for each image/icon
//                                             child: Stack(
//                                               children: [
//                                                 Center(
//                                                   child: Image.file(
//                                                     File(imagePaths[index]),
//                                                     height:
//                                                         100, // Set a height for the image
//                                                     width:
//                                                         100, // Set a width for the image
//                                                     fit: BoxFit
//                                                         .cover, // Ensure the image covers the container without distortion
//                                                   ),
//                                                 ),
//                                                 Positioned(
//                                                   top: 0,
//                                                   right: 0,
//                                                   child: InkWell(
//                                                     onTap: () {
//                                                       setState(() {
//                                                         // Remove the image path from the list
//                                                         imagePaths
//                                                             .removeAt(index);
//                                                         images.removeAt(
//                                                             index); // Also remove from images list
//                                                       });
//                                                       // Call your API to delete the image
//                                                       deleteOnlineImageApi(
//                                                           imagePaths[index]);
//                                                     },
//                                                     child: const Icon(
//                                                         Icons.delete,
//                                                         color: Colors.red,
//                                                         size: 30),
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           );
//                                         }),
//                                       ),
//                                     ),

//                                     Row(
//                                       children: [
//                                         Expanded(
//                                           child: Visibility(
//                                             visible: _isVisibleImageDoc,
//                                             child: Stack(
//                                               children: [
//                                                 if (imagePath.isNotEmpty)
//                                                   Center(
//                                                     child: Icon(
//                                                       getFileTypeIcon(
//                                                           imagePath),
//                                                       size: 100,
//                                                     ),
//                                                   ),
//                                                 InkWell(
//                                                   onTap: () async {
//                                                     setState(() {
//                                                       _isVisibleImageDoc =
//                                                           false;
//                                                     });
//                                                     deleteOnlineImageApi(
//                                                         imagePath);
//                                                   },
//                                                   child: const Icon(
//                                                       Icons.delete,
//                                                       color: Colors.red,
//                                                       size: 50),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                         ),
//                                         Expanded(
//                                           child: Visibility(
//                                             visible: _isVisibleImage2Doc,
//                                             child: Stack(
//                                               children: [
//                                                 if (imagePath2.isNotEmpty)
//                                                   Center(
//                                                     child: Icon(
//                                                       getFileTypeIcon(
//                                                           imagePath2),
//                                                       size: 100,
//                                                     ),
//                                                   ),
//                                                 InkWell(
//                                                   onTap: () {
//                                                     setState(() {
//                                                       _isVisibleImage2Doc =
//                                                           false;
//                                                     });
//                                                     deleteOnlineImageApi(
//                                                         imagePath2);
//                                                   },
//                                                   child: const Icon(
//                                                       Icons.delete,
//                                                       color: Colors.red,
//                                                       size: 50),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                         ),
//                                         Expanded(
//                                           child: Visibility(
//                                             visible: _isVisibleImage3Doc,
//                                             child: Stack(
//                                               children: [
//                                                 if (imagePath3.isNotEmpty)
//                                                   Center(
//                                                     child: Icon(
//                                                       getFileTypeIcon(
//                                                           imagePath3),
//                                                       size: 100,
//                                                     ),
//                                                   ),
//                                                 InkWell(
//                                                   onTap: () {
//                                                     setState(() {
//                                                       _isVisibleImage3Doc =
//                                                           false;
//                                                     });
//                                                     deleteOnlineImageApi(
//                                                         imagePath3);
//                                                   },
//                                                   child: const Icon(
//                                                       Icons.delete,
//                                                       color: Colors.red,
//                                                       size: 50),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                     Row(
//                                       children: [
//                                         Expanded(
//                                           child: Visibility(
//                                             visible: _isVisibleImage,
//                                             child: Stack(
//                                               children: [
//                                                 if (imagePath.isNotEmpty)
//                                                   Image.file(
//                                                     File(imagePath),
//                                                     height: 200,
//                                                     width: 200,
//                                                     fit: BoxFit.cover,
//                                                   ),
//                                                 InkWell(
//                                                   onTap: () async {
//                                                     setState(() {
//                                                       _isVisibleImage = false;
//                                                     });
//                                                     deleteOnlineImageApi(
//                                                         deleteImage1);
//                                                   },
//                                                   child: const Icon(
//                                                       Icons.delete,
//                                                       color: Colors.red,
//                                                       size: 50),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                         ),
//                                         Expanded(
//                                           child: Visibility(
//                                             visible: _isVisibleImage2,
//                                             child: Stack(
//                                               children: [
//                                                 if (imagePath2.isNotEmpty)
//                                                   Image.file(
//                                                     File(imagePath),
//                                                     height: 200,
//                                                     width: 200,
//                                                     fit: BoxFit.cover,
//                                                   ),
//                                                 InkWell(
//                                                   onTap: () {
//                                                     setState(() {
//                                                       _isVisibleImage2 = false;
//                                                     });
//                                                     deleteOnlineImageApi(
//                                                         deleteImage2);
//                                                   },
//                                                   child: const Icon(
//                                                       Icons.delete,
//                                                       color: Colors.red,
//                                                       size: 50),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                         ),
//                                         Expanded(
//                                           child: Visibility(
//                                             visible: _isVisibleImage3,
//                                             child: Stack(
//                                               children: [
//                                                 if (imagePath3.isNotEmpty)
//                                                   Image.file(
//                                                     File(imagePath3),
//                                                     height: 200,
//                                                     width: 200,
//                                                     fit: BoxFit.cover,
//                                                   ),
//                                                 InkWell(
//                                                   onTap: () {
//                                                     setState(() {
//                                                       _isVisibleImage3 = false;
//                                                     });
//                                                     deleteOnlineImageApi(
//                                                         deleteImage3);
//                                                   },
//                                                   child: const Icon(
//                                                       Icons.delete,
//                                                       color: Colors.red,
//                                                       size: 50),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),

//                                     Container(
//                                         margin: const EdgeInsets.only(
//                                             left: 6, right: 6, top: 8.0),
//                                         child: Padding(
//                                           padding: const EdgeInsets.only(
//                                               left: 2.0,
//                                               right: 2.0,
//                                               bottom: 2.0,
//                                               top: 2.0),
//                                           child: InkWell(
//                                             onTap: () async {
//                                               if (_formkey.currentState!
//                                                   .validate()) {
//                                                 // ***********get API**************//
//                                                 // fetchData(
//                                                 //   selectedSubstation,
//                                                 //   '1',
//                                                 //   'INSERT',
//                                                 //   (selectedServiceStreet ==
//                                                 //           'OTHER')
//                                                 //       ? 'OTHER'
//                                                 //       // _otherServiceStreetAddress
//                                                 //       //     .text
//                                                 //       //     .toString()
//                                                 //       : selectedServiceStreet,
//                                                 //   (selectedMapLocation ==
//                                                 //           'OTHER')
//                                                 //       ? 'OTHER'
//                                                 //       // _otherServiceMapLocation
//                                                 //       //     .text
//                                                 //       //     .toString()
//                                                 //       : selectedMapLocation,
//                                                 // );
//                                                 final userPreferences =
//                                                   Provider.of<UserPref>(context,
//                                                       listen: false);
//                                                UserModel data =
//                                                   await userPreferences
//                                                       .getUser();
//                                                String id =
//                                                   data.user!.id.toString();

//                                                 Map<String, dynamic> mapData = {
//                                                   "county": '',
//                                                   "substation": substationId,
//                                                   "streetAddress":
//                                                       (selectedServiceStreet ==
//                                                               'OTHER')
//                                                           ? 'OTHER'
//                                                           // _otherServiceStreetAddress
//                                                           //     .text
//                                                           //     .toString()
//                                                           : selectedServiceStreet,
//                                                   "mapLocation":
//                                                       (selectedMapLocation ==
//                                                               'OTHER')
//                                                           ? 'OTHER'
//                                                           // _otherServiceMapLocation
//                                                           //     .text
//                                                           //     .toString()
//                                                           : selectedMapLocation,
//                                                   "changeOrderImage": '',
//                                                   "adminNotes1":
//                                                       _notes.text.toString(),
//                                                   "dateOfInspection": "N/A",
//                                                   "type": (widget.maintType ==
//                                                           'Change Order')
//                                                       ? 'Change Order'
//                                                       : 'EXCEPTION MAINTENANCE',
//                                                   "followUpDate": "N/A",
//                                                   "maintType": maintenanceType,
//                                                   // (maintenanceType == null)
//                                                   //     ? ''
//                                                   //     : maintenanceType,
//                                                   "contractorCompay":
//                                                       _contratorComapny.text,
//                                                   "contractor": '',
//                                                   "supervisor":'',
//                                                       // (selectedAssignForman ==
//                                                       //         'Other')
//                                                       //     ? 'OTHER'
//                                                       //     // _otherAssignForeman
//                                                       //     //     .text
//                                                       //     //     .toString()
//                                                       //     : selectedAssignForman,
//                                                   /////////////new added///////////
//                                                   "tokenNo": widget.tokenNo,
//                                                   // "",
//                                                   //////////modified on 07/05/2024 ////////////
//                                                   "estCost": 0,
//                                                   // _estimatedCost.text
//                                                   //     .toString(),
//                                                   "estTime":
//                                                       _controllerTime.text,
//                                                   //  _selectedTime
//                                                   //     .format(context),
//                                                   "actualCost": 0,
//                                                   // _actualCost.text
//                                                   //     .toString(),
//                                                   "feeder": selectedFeeder,
//                                                   ///////////////////////////////
//                                                   "actionNeeded":
//                                                       substationName,
//                                                   "status" :"WORK FOR APPROVAL",
//                                                   "createdBy":id,
//                                                   "visibilityFlag":0,
//                                                   "crew": crewId
//                                                 };
//                                                 createOrderApi(mapData);

//                                                 // var response =
//                                                 //     await lcpChangeOrderViewModel
//                                                 //         .fetchLCPCreateOrderSubmitListApi(
//                                                 //             context, mapData);
//                                                 // print(response.toString());
//                                               } else {
//                                                 _showValidationErrorSnackBar(
//                                                     context);
//                                               }
//                                             },
//                                             child: Container(
//                                               margin: const EdgeInsets.only(
//                                                   left: 40,
//                                                   right: 40,
//                                                   bottom: 10.0),
//                                               padding: const EdgeInsets.all(8),
//                                               alignment: Alignment.center,
//                                               width: MediaQuery.of(context)
//                                                   .size
//                                                   .width,
//                                               height: 40,
//                                               decoration: const BoxDecoration(
//                                                   // shape: BoxShape.circle,
//                                                   // borderRadius:
//                                                   //     BorderRadius.circular(25),
//                                                   boxShadow: [
//                                                     BoxShadow(
//                                                         color: Color.fromARGB(
//                                                             255, 3, 47, 97),
//                                                         blurRadius: 5,
//                                                         offset:
//                                                             Offset(2.0, 5.0))
//                                                   ],
//                                                   color: Color.fromARGB(
//                                                       255, 130, 193, 245),
//                                                   gradient: LinearGradient(
//                                                     colors: [
//                                                       Color.fromARGB(
//                                                           255, 7, 59, 120),
//                                                       Color.fromARGB(
//                                                           255, 7, 59, 120)
//                                                     ],
//                                                   )),
//                                               child: const Row(children: [
//                                                 Expanded(
//                                                   child: Align(
//                                                     alignment: Alignment.center,
//                                                     child: Text(
//                                                       'Update Order',
//                                                       textAlign: TextAlign.left,
//                                                       style: TextStyle(
//                                                         color: Colors.white,
//                                                         fontWeight:
//                                                             FontWeight.bold,
//                                                         fontSize: 20,
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ]),
//                                             ),
//                                           ),
//                                         )),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   );

//                 default:
//                   return const Text('data');
//               }
//             })));
//   }

//   // Future<void> _pickImagesCamera() async {
//   //   final ImagePicker picker = ImagePicker();
//   //   const ImageSource source = ImageSource.camera;
//   //   List<String> chosenImagePaths = [];

//   //   for (int i = 0; i < 3; i++) {
//   //     final XFile? image = await picker.pickImage(
//   //       source: source,
//   //       maxWidth: 1024,
//   //       maxHeight: 1024,
//   //       imageQuality: 100,
//   //     );

//   //     if (image != null) {
//   //       chosenImagePaths.add(image.path);
//   //     }
//   //   }

//   //   setState(() {
//   //     for (int i = 0; i < chosenImagePaths.length; i++) {
//   //       if (_imagePath.isEmpty) {
//   //         _imagePath = chosenImagePaths[i];
//   //         setState(() {
//   //           _isVisibleImage = true;
//   //         });
//   //       } else if (_imagePath2.isEmpty) {
//   //         _imagePath2 = chosenImagePaths[i];
//   //         setState(() {
//   //           _isVisibleImage2 = true;
//   //         });
//   //       } else if (_imagePath3.isEmpty) {
//   //         _imagePath3 = chosenImagePaths[i];
//   //         setState(() {
//   //           _isVisibleImage3 = true;
//   //         });
//   //       } else {
//   //         CustomToastSnackBarProgressDialog.toastMessage(
//   //           'You can select a maximum of 3 images!',
//   //         );
//   //         break;
//   //       }
//   //     }
//   //   });
//   // }

//   // Future<void> _pickImagesGallery() async {
//   //   final ImagePicker picker = ImagePicker();
//   //   List<String> chosenImagePaths = [];

//   //   for (int i = 0; i < 3; i++) {
//   //     final XFile? image = await picker.pickImage(
//   //       source: ImageSource.gallery, // Set source to ImageSource.gallery only
//   //       maxWidth: 1024,
//   //       maxHeight: 1024,
//   //       imageQuality: 100,
//   //     );

//   //     if (image != null) {
//   //       chosenImagePaths.add(image.path);
//   //     }
//   //   }

//   //   setState(() {
//   //     for (int i = 0; i < chosenImagePaths.length; i++) {
//   //       if (_imagePath.isEmpty) {
//   //         _imagePath = chosenImagePaths[i];
//   //         setState(() {
//   //           _isVisibleImage = true;
//   //         });
//   //       } else if (_imagePath2.isEmpty) {
//   //         _imagePath2 = chosenImagePaths[i];
//   //         setState(() {
//   //           _isVisibleImage2 = true;
//   //         });
//   //       } else if (_imagePath3.isEmpty) {
//   //         _imagePath3 = chosenImagePaths[i];
//   //         setState(() {
//   //           _isVisibleImage3 = true;
//   //         });
//   //       } else {
//   //         CustomToastSnackBarProgressDialog.toastMessage(
//   //           'You can select a maximum of 3 images!',
//   //         );
//   //         break;
//   //       }
//   //     }
//   //   });
//   // }

//   // Future<void> _pickImages() async {
//   //   final ImagePicker picker = ImagePicker();
//   //   List<String> chosenImagePaths = [];

//   //   for (int i = 0; i < 3; i++) {
//   //     final XFile? image = await picker.pickImage(
//   //       source: i == 0 ? ImageSource.camera : ImageSource.gallery,
//   //       maxWidth: 100,
//   //       maxHeight: 100,
//   //       imageQuality: 80,
//   //     );

//   //     if (image != null) {
//   //       chosenImagePaths.add(image.path);
//   //     }
//   //   }

//   //   setState(() {
//   //     for (int i = 0; i < chosenImagePaths.length; i++) {
//   //       if (_imagePath.isEmpty) {
//   //         _imagePath = chosenImagePaths[i];
//   //       } else if (_imagePath2.isEmpty) {
//   //         _imagePath2 = chosenImagePaths[i];
//   //       } else if (_imagePath3.isEmpty) {
//   //         _imagePath3 = chosenImagePaths[i];
//   //       } else {
//   //         CustomToastSnackBarProgressDialog.toastMessage(
//   //           'You can select a maximum of 3 images!',
//   //         );
//   //         break;
//   //       }
//   //     }
//   //   });
//   // }

//   Future<void> _checkPermission(BuildContext context) async {
//     FocusScope.of(context).requestFocus(FocusNode());
//     Map<Permission, PermissionStatus> statues = await [
//       Permission.camera,
//       Permission.storage,
//       Permission.photos
//     ].request();
//     PermissionStatus? statusCamera = statues[Permission.camera];
//     PermissionStatus? statusStorage;
//     PermissionStatus? statusPhotos;
//     if (Platform.isAndroid) {
//       final androidInfo = await DeviceInfoPlugin().androidInfo;
//       if (androidInfo.version.sdkInt <= 32) {
//         statusStorage = statues[Permission.storage];

//         /// use [Permissions.storage.status]
//       } else {
//         statusPhotos = statues[Permission.photos];

//         /// use [Permissions.photos.status]
//       }
//     }

//     bool isGranted = statusCamera == PermissionStatus.granted &&
//             statusStorage == PermissionStatus.granted ||
//         statusCamera == PermissionStatus.granted &&
//             statusPhotos == PermissionStatus.granted;
//     if (isGranted) {
//       pickImageOptions();
//       // _pickImages();
//     }
//     bool isPermanentlyDenied =
//         statusCamera == PermissionStatus.permanentlyDenied ||
//             statusStorage == PermissionStatus.permanentlyDenied ||
//             statusPhotos == PermissionStatus.permanentlyDenied;
//     if (isPermanentlyDenied) {
//       // _showSettingsDialog(context);
//     }
//   }

//   // Future<void> submitImage(String fileName, String tokenNo) async {
//   //   Directory tempDir = await getTemporaryDirectory();
//   //   String tempPath = tempDir.path;
//   //   try {
//   //     var uri = Uri.parse(
//   //         "https://civm2.ariespro.com/civm2/contractorPanel/updateImageVEGETATION_CREW_FORMs");
//   //     var request = http.MultipartRequest("POST", uri);
//   //     final userPreferences = Provider.of<UserPref>(context, listen: false);
//   //     UserModel data = await userPreferences.getUser();
//   //     var headers = {
//   //       "Content-Type": "multipart/form-data",
//   //       "Accept": "*/*",
//   //       "Authorization": 'Bearer ${data.token!}'
//   //     };
//   //     // var stream1 = http.ByteStream(image.openRead());
//   //     // // Get the file length
//   //     // var length = await image.length();
//   //     // Create a multipart file from the byte stream
//   //     // var multipartFile1 = http.MultipartFile(
//   //     //   'ClientDoc1', // Field name for the file
//   //     //   stream1, // Byte stream of the file
//   //     //   length, // Length of the file
//   //     //   filename: basename(image.path), // Original file name
//   //     // );
//   //     // request.files.add(multipartFile1); // Add the single file to the request
//   //     List<http.MultipartFile> newList = [];
//   //     if (_imagePath != '') {
//   //       File img1 = new File(_imagePath);
//   //       File file = await img1.copy(
//   //           '${tempPath}/img_${DateFormat('yyyyMMddHHmmss').format(DateTime.now())}${_imagePath.contains('.pdf') ? '.pdf' : '.jpg'}');

//   //       var stream1 = http.ByteStream(file.openRead());
//   //       var length1 = await file.length();
//   //       // Get the file length
//   //       var multipartFile = http.MultipartFile("files", stream1, length1,
//   //           filename: path.basename(file.path));
//   //       deleteImage1 = path.basename(file.path);
//   //       newList.add(multipartFile);
//   //     }

//   //     if (_imagePath2 != '') {
//   //       File img2 = new File(_imagePath2);
//   //       File file2 = await img2.copy(
//   //           '${tempPath}/img_${DateFormat('yyyyMMddHHmmss').format(DateTime.now())}2${_imagePath2.contains('.pdf') ? '.pdf' : '.jpg'}');

//   //       var stream2 = http.ByteStream(file2.openRead());
//   //       var length2 = await file2.length();
//   //       // Get the file length
//   //       var multipartFile2 = http.MultipartFile("files", stream2, length2,
//   //           filename: path.basename(file2.path));

//   //       deleteImage2 = path.basename(file2.path);

//   //       newList.add(multipartFile2);
//   //     }

//   //     if (_imagePath3 != '') {
//   //       File img3 = new File(_imagePath3);
//   //       File file3 = await img3.copy(
//   //           '${tempPath}/img_${DateFormat('yyyyMMddHHmmss').format(DateTime.now())}3${_imagePath3.contains('.pdf') ? '.pdf' : '.jpg'}');

//   //       var stream3 = http.ByteStream(file3.openRead());
//   //       var length3 = await file3.length();
//   //       // Get the file length
//   //       var multipartFile3 = http.MultipartFile("files", stream3, length3,
//   //           filename: path.basename(file3.path));
//   //       deleteImage3 = path.basename(file3.path);
//   //       newList.add(multipartFile3);
//   //     }

//   //     if (newList.isNotEmpty) {
//   //       request.files.addAll(newList); // Add the multiple file to the request
//   //     }
//   //     request.headers.addAll(headers);
//   //     request.fields['tokenNo'] = tokenNo;
//   //     // Send the request
//   //     var streamedResponse = await request.send();
//   //     var response = await http.Response.fromStream(streamedResponse);
//   //     // listen for response
//   //     // streamedResponse.stream.transform(utf8.decoder).listen((value) {
//   //     //   print(value);
//   //     // });
//   //     if (response.statusCode == 200) {
//   //       if (_imagePath != '') {
//   //         setState(() {
//   //           _isVisibleImage = true;
//   //         });
//   //       }

//   //       if (_imagePath2 != '') {
//   //         setState(() {
//   //           _isVisibleImage2 = true;
//   //         });
//   //       }

//   //       if (_imagePath3 != '') {
//   //         setState(() {
//   //           _isVisibleImage3 = true;
//   //         });
//   //       }
//   //     }
//   //   } catch (e) {}
//   //   _isVisibleImage = true;
//   // }

//   Future<void> submitImage(String fileName, String tokenNo) async {
//     print('submit image api11111111111');
//     Directory tempDir = await getTemporaryDirectory();
//     print('submit image 22222222222222222');
//     String tempPath = tempDir.path;
//     try {
//       print('submit image 333333333333333333333');
//       var uri = Uri.parse(
//           "https://civm2.ariespro.com/civm2/contractorPanel/updateImageVEGETATION_CREW_FORMs");
//       var request = http.MultipartRequest("POST", uri);
//       final userPreferences = Provider.of<UserPref>(context, listen: false);
//       UserModel data = await userPreferences.getUser();
//       print('submit image 4444444444444444444');
//       var headers = {
//         "Content-Type": "multipart/form-data",
//         "Accept": "*/*",
//         "Authorization": 'Bearer ${data.token!}'
//       };
//       // var stream1 = http.ByteStream(image.openRead());
//       // // Get the file length
//       // var length = await image.length();
//       // Create a multipart file from the byte stream
//       // var multipartFile1 = http.MultipartFile(
//       //   'ClientDoc1', // Field name for the file
//       //   stream1, // Byte stream of the file
//       //   length, // Length of the file
//       //   filename: basename(image.path), // Original file name
//       // );
//       // request.files.add(multipartFile1); // Add the single file to the request
//       List<http.MultipartFile> newList = [];
//       if (imagePath != '') {
//         print('submit image 4555555555555555555555');
//         File img1 = new File(imagePath);
//         File file = await img1.copy(
//             '${tempPath}/img_${DateFormat('yyyyMMddHHmmss').format(DateTime.now())}${imagePath.contains('.pdf') ? '.pdf' : '.jpg'}');
//         print('submit image 666666666666666');
//         var stream1 = http.ByteStream(file.openRead());
//         var length1 = await file.length();
//         // Get the file length
//         var multipartFile = http.MultipartFile("files", stream1, length1,
//             filename: path.basename(file.path));
//         deleteImage1 = path.basename(file.path);
//         newList.add(multipartFile);
//       }

//       if (imagePath2 != '') {
//         File img2 = new File(imagePath2);
//         File file2 = await img2.copy(
//             '${tempPath}/img_${DateFormat('yyyyMMddHHmmss').format(DateTime.now())}2${imagePath2.contains('.pdf') ? '.pdf' : '.jpg'}');

//         var stream2 = http.ByteStream(file2.openRead());
//         var length2 = await file2.length();
//         // Get the file length
//         var multipartFile2 = http.MultipartFile("files", stream2, length2,
//             filename: path.basename(file2.path));

//         deleteImage2 = path.basename(file2.path);

//         newList.add(multipartFile2);
//       }

//       if (imagePath3 != '') {
//         File img3 = new File(imagePath3);
//         File file3 = await img3.copy(
//             '${tempPath}/img_${DateFormat('yyyyMMddHHmmss').format(DateTime.now())}3${imagePath3.contains('.pdf') ? '.pdf' : '.jpg'}');

//         var stream3 = http.ByteStream(file3.openRead());
//         var length3 = await file3.length();
//         // Get the file length
//         var multipartFile3 = http.MultipartFile("files", stream3, length3,
//             filename: path.basename(file3.path));
//         deleteImage3 = path.basename(file3.path);
//         newList.add(multipartFile3);
//       }

//       if (newList.isNotEmpty) {
//         request.files.addAll(newList); // Add the multiple file to the request
//       }
//       request.headers.addAll(headers);
//       request.fields['tokenNo'] = tokenNo;
//       // Send the request
//       var streamedResponse = await request.send();
//       var response = await http.Response.fromStream(streamedResponse);
//       // listen for response
//       // streamedResponse.stream.transform(utf8.decoder).listen((value) {
//       //   print(value);
//       // });
//       if (response.statusCode == 200) {
//         print('image successfully uploaded...........');
//         print(response.body);
//         if (imagePath != '') {
//           setState(() {
//             _isVisibleImage = true;
//           });
//         }

//         if (imagePath2 != '') {
//           setState(() {
//             _isVisibleImage2 = true;
//           });
//         }

//         if (imagePath3 != '') {
//           setState(() {
//             _isVisibleImage3 = true;
//           });
//         }
//         Navigator.of(context).push(MaterialPageRoute(
//             builder: (BuildContext context) => TotalOrderPendingPlanner(
//                    budgetType: '',
//                                 maintenanceType: 'Change Order',
//                                 heading: 'Change Order',
//                 )));
//       }
//     } catch (e) {
//       print('inside catch of image upload api.................');
//     }
//     _isVisibleImage = true;
//   }

//   Future<void> deleteOnlineImageApi(String fileName) async {
//     final apiUrl =
//         'http://civmapi.ariespro.com/civmapi/changeOrderLcpCreateOrder/deleteFile?fileName=$fileName';
//     final userPreferences = Provider.of<UserPref>(context, listen: false);
//     UserModel data = await userPreferences.getUser();

//     try {
//       final response = await http.delete(
//         Uri.parse(apiUrl),
//         headers: {"Authorization": 'Bearer ${data.token!}'},
//       );

//       if (response.statusCode == 200) {
//         setState(() {});
//       } else {}
//     } catch (e) {}
//   }

//   DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
//       value: item,
//       child: Text(item,
//           style: const TextStyle(
//             fontWeight: FontWeight.normal,
//             fontSize: 20,
//           )));

//   fetchData(String substation, String userType, String action,
//       String streetAddress, String location, String substationId) {
//     lcpChangeOrderViewModel.fetchLCPChangeOrderViewListApi(
//         context,
//         substation,
//         userType,
//         action,
//         streetAddress,
//         location,
//         substationId,
//         widget.contractorCompany);
//   }

//   void _setData() {
//     print('widget.type ${widget.type}');
//     print('widget.crew ${widget.crew}');
//     selectedCrew = widget.crew;
//     if (widget.subStation != '') {
//       lcpChangeOrderViewModel.lcpChangeOrderList.data!.findAllIdAndSubstation!
//           .forEach((a) {
//         if (a.subStation == widget.subStation.toString()) {
//           selectedSubstation = a.id.toString();
//         }
//       });
//       substationName = getSubstationNameById(selectedSubstation);
//     }
//     getSubstationIdByName(widget.subStation);
//     // selectedMapLocation = widget.serviceMapLocation.toString();
//     _notes.text = widget.notes.toString();

//     print('object   ${widget.type.toString()}');
//     // dropDown();
//     _contratorComapny.text = widget.contractorCompany.toString();
//     lcpChangeOrderViewModel.lcpChangeOrderList.data!.contractorGetInsert!
//         .forEach(
//       (a) {
//         if (a.name == widget.assignForeman.toString()) {
//           selectedAssignForman = a.name;
//         }
//       },
//     );
//     List<ContractorGetInsert>? loginIdList =
//         lcpChangeOrderViewModel.lcpChangeOrderList.data!.contractorGetInsert;
//     loginIdList?.forEach((ContractorGetInsert a) {
//       if (a.name == selectedAssignForman) {
//         assignFormanId = a.loginId!;
//         print('assignFormanId11111111111111111111111');
//         print(assignFormanId);
//         print('selectedAssignForman.............');
//         print(selectedAssignForman);
//       }
//     });
// ///////////////////////////////////
//     types = widget.type.split(', ').map((e) => e.trim()).toList();
//     print('widget.maintType ${widget.type}');
//     print('types $types');
//     maintenanceType = widget.type;
//     String? newMaintenanceType = types.isEmpty ? null : types.join(', ');
//     print('newMaintenanceType $newMaintenanceType');
//     if (newMaintenanceType != maintenanceType) {
//       setState(() {
//         maintenanceType = newMaintenanceType;
//       });
//     }

//     ///////////////////////////////////

//     if (widget.contractorCompany == 'LCP') {
//       selectedAssignForman = 'LCP';
//     } else if (widget.contractorCompany == 'ZIELIES') {
//       selectedAssignForman = widget.assignForeman;
//     }
//   }

//   String getSubstationNameById(String id) {
//     var substationList = lcpChangeOrderViewModel
//         .lcpChangeOrderList.data!.findAllIdAndSubstation!;

//     for (var subStation in substationList) {
//       if (subStation.id.toString() == id) {
//         return subStation.subStation.toString();
//       }
//     }
//     return 'Substation Not Found';
//   }

//   Future<void> createOrderApi(Map<String, dynamic> mappedData) async {
//     String apiUrl =
//         'http://civmapi.ariespro.com/civmapi/changeOrderLcpCreateOrder/SP_INSERT_SM_MAINT_TEST_RESULT_REQUEST';

//     final userPreferences = Provider.of<UserPref>(context, listen: false);
//     UserModel data = await userPreferences.getUser();
//     try {
//       showDialog(
//         context: context,
//         barrierDismissible: false,
//         builder: (BuildContext context) {
//           return const Center(
//             child: CircularProgressIndicator(),
//           );
//         },
//       );
//       final response = await http.post(
//         Uri.parse(apiUrl),
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer ${data.token}',
//         },
//         body: jsonEncode(mappedData),
//       );

//       Navigator.pop(context);
//       if (response.statusCode == 200) {
//         print('API Response: ${response.body}');
//         CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
//             'Successfully Created', context);
//         Future.delayed(const Duration(seconds: 2), () {
//           setState(() {
//             _notes.clear();
//             selectedSubstation = null;
//             selectedServiceStreet = null;
//             _typeAheadController.clear();
//             selectedMapLocation = null;
//             maintenanceType = null;
//             selectedAssignForman = null;
//             imagePaths = [];
//             // _imagePath2 = '';
//             // _imagePath3 = '';
//             _isVisibleImage = false;
//             _isVisibleImage2 = false;
//             _isVisibleImage3 = false;
//             _estimatedCost.clear();
//             _actualCost.clear();
//           });
//         });

//         // if (_imagePath != '') {
//         //   Map<String, dynamic> jsonResponse = json.decode(response.body);
//         //   print(jsonResponse['message']);
//         //   if (jsonResponse['message'] == 'Successfully created') {
//         //     submitImage(_imagePath, jsonResponse['tokenNo']);
//         //   }
//         // }
//         // Navigator.of(context).push(MaterialPageRoute(
//         //     builder: (BuildContext context) =>
//         //         const TotalOrderPendingPlanner()));
//         if (imagePath != '') {
//           print('image path $imagePath');
//           Map<String, dynamic> jsonResponse = json.decode(response.body);
//           print('jsonResponse: $jsonResponse');
//           print('jsonResponse[message]: ${jsonResponse['message']}');
//           if (jsonResponse['message'] == 'Successfully created') {
//             print('tokenNo111111 ${jsonResponse['tokenNo']}');
//             print('00000000000000000000000000000000000000000');
//             print(imagePath);
//             submitImage(imagePath, jsonResponse['tokenNo']);
//             // submitImage(_imagePath, jsonResponse['tokenNo']);
//             print('1111111111111111111111111');
//           }
//           // else if (imagePaths.isNotEmpty) {
//           //   Map<String, dynamic> jsonResponse = json.decode(response.body);
//           //   // else if (imagePaths != []) {
//           //   print('inside cameraMultipleImage condition ${jsonResponse['tokenNo']}');
//           //   submitImages(imagePaths, jsonResponse['tokenNo']);
//           // }
//         } else if (imagePaths.isNotEmpty) {
//           Map<String, dynamic> jsonResponse = json.decode(response.body);
//           // else if (imagePaths != []) {
//           print(
//               'inside cameraMultipleImage condition ${jsonResponse['tokenNo']}');
//           submitImages(imagePaths, jsonResponse['tokenNo']);
//         } else {
//           Navigator.of(context).push(MaterialPageRoute(
//               builder: (BuildContext context) => TotalOrderPendingPlanner(
//                      budgetType: '',
//                                 maintenanceType: 'Change Order',
//                                 heading: 'Change Order',
//                   )));
//         }
//       } else {
//         print('API Request failed with status ${response.statusCode}.');
//         print('Error message: ${response.body}');
//       }
//     } catch (error) {
//       print('Error during API request: $error');
//     }
//   }

//   Future pickImageOptions() => showDialog(
//       context: context,
//       builder: (context) {
//         return StatefulBuilder(builder: (context, setState) {
//           return AlertDialog(
//             content: const SingleChildScrollView(
//               child: Column(
//                 children: [
//                   Text(
//                     "Select image from",
//                     textAlign: TextAlign.left,
//                     style: TextStyle(
//                       color: Color.fromARGB(255, 7, 59, 120),
//                       fontWeight: FontWeight.bold,
//                       fontSize: 20,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             actions: [
//               Align(
//                 alignment: Alignment.center,
//                 child: Column(
//                   children: [
//                     InkWell(
//                       onTap: () {
//                         // _pickImagesCamera();
//                         Navigator.pop(context);
//                         _takePictureDialog();
//                       },
//                       child: Container(
//                         margin: const EdgeInsets.only(
//                             left: 4, right: 4, bottom: 10.0),
//                         // padding: const EdgeInsets.all(8),
//                         alignment: Alignment.center,
//                         width: MediaQuery.of(context).size.width,
//                         height: 40,
//                         decoration: const BoxDecoration(
//                             // shape: BoxShape.circle,
//                             // borderRadius: BorderRadius.circular(25),
//                             boxShadow: [
//                               BoxShadow(
//                                   color: Color.fromARGB(255, 112, 68, 1),
//                                   blurRadius: 5,
//                                   offset: Offset(2.0, 5.0))
//                             ],
//                             color: Colors.black,
//                             gradient: LinearGradient(
//                               colors: [
//                                 Colors.orange,
//                                 Colors.orange,
//                               ],
//                             )),
//                         child: const Align(
//                           alignment: Alignment.center,
//                           child: Text(
//                             "Camera",
//                             textAlign: TextAlign.left,
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 20,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     InkWell(
//                       onTap: () {
//                         _uploadDocuments();
//                         Navigator.pop(context);
//                       },
//                       child: Container(
//                         margin: const EdgeInsets.only(
//                             left: 4, right: 4, bottom: 10.0),
//                         // padding: const EdgeInsets.all(8),
//                         alignment: Alignment.center,
//                         width: MediaQuery.of(context).size.width,
//                         height: 40,
//                         decoration: const BoxDecoration(
//                             // shape: BoxShape.circle,
//                             // borderRadius: BorderRadius.circular(25),
//                             boxShadow: [
//                               BoxShadow(
//                                   color: Color.fromARGB(255, 112, 68, 1),
//                                   blurRadius: 5,
//                                   offset: Offset(2.0, 5.0))
//                             ],
//                             color: Colors.black,
//                             gradient: LinearGradient(
//                               colors: [
//                                 Colors.orange,
//                                 Colors.orange,
//                               ],
//                             )),
//                         child: const Align(
//                           alignment: Alignment.center,
//                           child: Text(
//                             "Document",
//                             textAlign: TextAlign.left,
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 20,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           );
//         });
//       });

//   String getIdBySubstationName(String substationName) {
//     var substationList = lcpChangeOrderViewModel
//         .lcpChangeOrderList.data!.findAllIdAndSubstation!;

//     for (var subStation in substationList) {
//       if (subStation.subStation.toString() == substationName) {
//         substationId = int.parse(subStation.id.toString());
//         lcpChangeOrderViewModel.fetchLCPChangeOrderViewListApi(
//             context,
//             widget.subStation,
//             '1',
//             'Get',
//             widget.serviceStreetAddress,
//             widget.serviceMapLocation,
//             substationId.toString(),
//             widget.contractorCompany);
//         // return subStation.id.toString();
//         _setData();
//       }
//     }
//     return 'ID Not Found';
//   }

//   void getData() {
//     _otherServiceStreetAddress.text = widget.serviceStreetAddress;
//     _otherServiceMapLocation.text = widget.serviceMapLocation;
//     _notes.text = widget.notes;
//     _otherAssignForeman.text = widget.assignForeman;
//     _contratorComapny.text = widget.contractorCompany;
//     _actualCost.text = widget.actualCost;
//     _estimatedCost.text = widget.estimatedCost;
//     _controllerTime.text =
//         (widget.estimatedTime == '' || widget.estimatedTime == 'null')
//             ? '0.1'
//             : widget.estimatedTime.toString();
//   }

//   void _increment() {
//     setState(() {
//       _value = (_value + 0.1).clamp(
//           0.1, 100000000.0); // Clamping value between 0.1 and 100000000.0
//       _controllerTime.text = _value.toStringAsFixed(1); // Update text field
//     });
//   }

//   void _decrement() {
//     setState(() {
//       _value = (_value - 0.1).clamp(
//           0.1, 100000000.0); // Clamping value between 0.1 and 100000000.0
//       _controllerTime.text = _value.toStringAsFixed(1); // Update text field
//     });
//   }

//   IconData getFileTypeIcon(String filePath) {
//     if (filePath.endsWith('.pdf')) {
//       return Icons.picture_as_pdf;
//     } else if (filePath.endsWith('.doc') || filePath.endsWith('.docx')) {
//       return Icons.description;
//     } else {
//       return Icons.insert_drive_file;
//     }
//   }

//   Future<void> _uploadDocuments() async {
//     print('document upload');

//     const XTypeGroup typeGroup = XTypeGroup(
//       label: 'documents',
//       extensions: ['pdf', 'doc', 'docx'],
//     );

//     try {
//       final List<XFile> documentResult = await openFiles(
//         acceptedTypeGroups: [typeGroup],
//       );

//       if (documentResult.isNotEmpty) {
//         List<String> chosenDocumentPaths = [];

//         for (int i = 0; i < documentResult.length; i++) {
//           if (chosenDocumentPaths.length < 3) {
//             chosenDocumentPaths.add(documentResult[i].path);
//           } else {
//             CustomToastSnackBarProgressDialog.toastMessage(
//               'You can select a maximum of 3 documents!',
//             );
//             return;
//           }
//         }
//         setState(() {
//           for (int i = 0; i < chosenDocumentPaths.length; i++) {
//             if (imagePath.isEmpty) {
//               imagePath = chosenDocumentPaths[i];
//               setState(() {
//                 _isVisibleImageDoc = true;
//               });
//             } else if (imagePath2.isEmpty) {
//               imagePath2 = chosenDocumentPaths[i];
//               setState(() {
//                 _isVisibleImage2Doc = true;
//               });
//             } else if (imagePath3.isEmpty) {
//               imagePath3 = chosenDocumentPaths[i];
//               setState(() {
//                 _isVisibleImage3Doc = true;
//               });
//             } else {
//               CustomToastSnackBarProgressDialog.toastMessage(
//                 'You can select a maximum of 3 documents!',
//               );
//               break;
//             }
//           }
//         });
//       } else {
//         CustomToastSnackBarProgressDialog.toastMessage(
//           'Please select at least one document.',
//         );
//       }
//     } catch (e) {
//       print('Error occurred while picking documents: $e');
//       CustomToastSnackBarProgressDialog.toastMessage(
//         'Error occurred while picking documents: $e',
//       );
//     }
//   }

//   String getSubstationIdByName(String substationName) {
//     var substationList = lcpChangeOrderViewModel
//         .lcpChangeOrderList.data!.findAllIdAndSubstation!;
//     for (var subStation in substationList) {
//       if (subStation.subStation.toString() == substationName) {
//         print('subStation.id.toString() ${subStation.id.toString()}');
//         substationId = int.parse(subStation.id.toString());
//         print('newSubId : $substationId');

//         fetchData(substationName, '', '', '', '', substationId.toString());

//         String feeder = widget.feeder;
//         print('feeder $feeder');
//         int indexOfOpeningBracket = feeder.indexOf('(');
//         if (indexOfOpeningBracket != -1) {
//           feeder = feeder.substring(0, indexOfOpeningBracket).trim();
//         }
//         print('widget.feeder $feeder');

//         //////////////////////////
//         Future.delayed(const Duration(seconds: 5), () {
//           if (lcpChangeOrderViewModel.lcpChangeOrderList.data != null &&
//               lcpChangeOrderViewModel
//                       .lcpChangeOrderList.data!.getIdAndFeederBySubstationId !=
//                   null) {
//             if (widget.feeder != '') {
//               lcpChangeOrderViewModel
//                   .lcpChangeOrderList.data!.getIdAndFeederBySubstationId!
//                   .forEach((a) {
//                 if (a.feeder == feeder.toString()) {
//                   setState(() {
//                     selectedFeeder = a.id.toString();
//                     feederFlag = 1;
//                   });
//                   if (feederFlag == 1) {
//                     setState(() {
//                       selectedServiceStreet =
//                           widget.serviceStreetAddress.toString();
//                           _typeAheadController.text = widget.serviceStreetAddress.toString();
//                     });
//                     fetchData(substationName, '', '', selectedServiceStreet, '',
//                         substationId.toString());
//                     Future.delayed(const Duration(seconds: 5), () {
//                       serviceStreetFlag = 1;
//                     });
//                   }
//                   Future.delayed(const Duration(seconds: 6), () {
//                     if (serviceStreetFlag == 1) {
//                       setState(() {
//                         selectedMapLocation =
//                             widget.serviceMapLocation.toString();
//                       });
//                     }
//                   });
//                 }
//               });
//             }
//           }
//         });

//         //      Future.delayed(const Duration(seconds: 3), () {
//         //   setState(() {
//         //     selectedServiceStreet = widget.serviceStreetAddress.toString();
//         //   });
//         // });
//         // Future.delayed(const Duration(seconds: 4), () {
//         //   setState(() {
//         //     selectedMapLocation = widget.serviceMapLocation.toString();
//         //   });
//         // });
//         // ///////////////////////////////////////////
//         return subStation.id.toString();
//       }
//     }
//     return 'Substation Id Not Found';
//   }

//   Future<void> submitImages(List<String> imagePaths, String tokenNo) async {
//     print('imagePaths: $imagePaths');
//     Directory tempDir = await getTemporaryDirectory();
//     String tempPath = tempDir.path;

//     try {
//       var uri = Uri.parse(
//           "https://civm2.ariespro.com/civm2/contractorPanel/updateImageVEGETATION_CREW_FORMs");
//       var request = http.MultipartRequest("POST", uri);

//       // Get the user token
//       final userPreferences = Provider.of<UserPref>(context, listen: false);
//       UserModel data = await userPreferences.getUser();

//       // Set headers
//       var headers = {
//         "Content-Type": "multipart/form-data",
//         "Accept": "*/*",
//         "Authorization": 'Bearer ${data.token!}'
//       };

//       // List to hold MultipartFile objects
//       List<http.MultipartFile> multipartFiles = [];

//       // Loop through image paths and add them as MultipartFile
//       for (int i = 0; i < imagePaths.length; i++) {
//         String imagePath = imagePaths[i];

//         if (imagePath.isNotEmpty) {
//           File img = File(imagePath);

//           // Copy the file to the temporary directory
//           File file = await img.copy(
//               '$tempPath/img_${DateFormat('yyyyMMddHHmmss').format(DateTime.now())}_$i${imagePath.contains('.pdf') ? '.pdf' : '.jpg'}');

//           var stream = http.ByteStream(file.openRead());
//           var length = await file.length();

//           var multipartFile = http.MultipartFile("files", stream, length,
//               filename: path.basename(file.path));

//           // Add file to the list
//           multipartFiles.add(multipartFile);
//         }
//       }

//       if (multipartFiles.isNotEmpty) {
//         request.files.addAll(multipartFiles); // Add all the selected files
//       }

//       // Add tokenNo as a field
//       request.fields['tokenNo'] = tokenNo;
//       request.headers.addAll(headers);

//       // Send the request
//       var streamedResponse = await request.send();
//       var response = await http.Response.fromStream(streamedResponse);

//       if (response.statusCode == 200) {
//         print("Images submitted successfully.images more than 3");

//         Navigator.of(context).push(MaterialPageRoute(
//             builder: (BuildContext context) => TotalOrderPendingPlanner(
//                    budgetType: '',
//                                 maintenanceType: 'Change Order',
//                                 heading: 'Change Order',
//                 )));

//         // Handle the success response
//       } else {
//         print("Failed to submit images. Status code: ${response.statusCode}");
//         print("Failed to submit images. response body: ${response.body}");
//       }
//     } catch (e, stacktrace) {
//       print('Exception: $e\n$stacktrace');
//     }
//   }

//   Future<void> _takePictureDialog() async {
//     final ImagePicker _picker = ImagePicker(); // Initialize ImagePicker

//     return showDialog<void>(
//       context: context,
//       barrierDismissible: false, // user must tap button!
//       builder: (BuildContext context) {
//         return StatefulBuilder(builder: (context, setState) {
//           return AlertDialog(
//             title: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Text(
//                   'Take Picture',
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                     color: Color.fromARGB(255, 23, 1, 88),
//                   ),
//                 ),
//                 Align(
//                   alignment: Alignment.bottomRight,
//                   child: IconButton(
//                     icon: const Icon(Icons.close, color: Colors.red),
//                     onPressed: () {
//                       Navigator.of(context).pop(); // Close the dialog
//                     },
//                   ),
//                 ),
//               ],
//             ),
//             content: SingleChildScrollView(
//               child: Column(
//                 children: <Widget>[
//                   Container(
//                     margin: const EdgeInsets.only(top: 4.0),
//                     child: Padding(
//                       padding: const EdgeInsets.all(2.0),
//                       child:
//                           CameraPreview(_camerasController), // Camera Preview
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             actions: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   // Button to take picture using camera
//                   InkWell(
//                     onTap: (() async {
//                       XFile image = await _camerasController.takePicture();
//                       refreshPath(image.path, image);
//                       Navigator.of(context)
//                           .pop(); // Close dialog after taking picture
//                     }),
//                     child: Container(
//                       margin: const EdgeInsets.all(4.0),
//                       width: MediaQuery.of(context).size.width * 0.3,
//                       height: MediaQuery.of(context).size.height * 0.052,
//                       decoration: const BoxDecoration(
//                         boxShadow: [
//                           BoxShadow(
//                             color: Color.fromARGB(255, 60, 59, 59),
//                             blurRadius: 5,
//                             offset: Offset(2.0, 5.0),
//                           )
//                         ],
//                         color: Colors.black,
//                         gradient: LinearGradient(
//                           colors: [
//                             Color.fromARGB(255, 7, 40, 97),
//                             Color.fromARGB(255, 7, 40, 97),
//                             Color.fromARGB(255, 7, 40, 97),
//                           ],
//                         ),
//                       ),
//                       child: const Align(
//                         alignment: Alignment.center,
//                         child: Text(
//                           "Take Picture",
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 14,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   // Button to pick image from gallery
//                   InkWell(
//                     onTap: (() async {
//                       XFile? image = await _picker.pickImage(
//                         source: ImageSource.gallery,
//                       );
//                       if (image != null) {
//                         refreshPath(image.path, image); // Add to list
//                         Navigator.of(context)
//                             .pop(); // Close dialog after selecting
//                       }
//                     }),
//                     child: Container(
//                       margin: const EdgeInsets.all(4.0),
//                       width: MediaQuery.of(context).size.width * 0.3,
//                       height: MediaQuery.of(context).size.height * 0.052,
//                       decoration: const BoxDecoration(
//                         boxShadow: [
//                           BoxShadow(
//                             color: Color.fromARGB(255, 60, 59, 59),
//                             blurRadius: 5,
//                             offset: Offset(2.0, 5.0),
//                           )
//                         ],
//                         color: Colors.black,
//                         gradient: LinearGradient(
//                           colors: [
//                             Color.fromARGB(255, 97, 7, 40),
//                             Color.fromARGB(255, 97, 7, 40),
//                             Color.fromARGB(255, 97, 7, 40),
//                           ],
//                         ),
//                       ),
//                       child: const Align(
//                         alignment: Alignment.center,
//                         child: Text(
//                           "Gallery",
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 14,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           );
//         });
//       },
//     );
//   }

//   void refreshPath(String path, XFile imageARG) {
//     setState(() {
//       imagePaths.add(path);
//       images.add(imageARG);
//     });
//   }

//   Future<void> cameraInit() async {
//     _cameras = await availableCameras();
//     _camerasController = CameraController(_cameras[0], ResolutionPreset.max);
//     _camerasController.initialize().then((_) {
//       if (!mounted) {
//         return;
//       }
//       setState(() {});
//     }).catchError((Object e) {
//       if (e is CameraException) {
//         switch (e.code) {
//           case 'CameraAccessDenied':
//             // Handle access errors here.
//             break;
//           default:
//             // Handle other errors here.
//             break;
//         }
//       }
//     });
//   }

//   void _showValidationErrorSnackBar(BuildContext context) {
//     const snackBar = SnackBar(
//       content: Text('Please fill all the mandatory fields!'),
//       backgroundColor: Color.fromARGB(255, 219, 17, 2),
//       duration: Duration(seconds: 3), // Optional: Adjust duration
//     );

//     ScaffoldMessenger.of(context).showSnackBar(snackBar);
//   }
// }
