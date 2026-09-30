// import 'dart:convert';

// import 'package:camera/camera.dart';
// import 'package:CIVM/piedmont/data/response/status.dart';
// import 'package:CIVM/piedmont/screens/admin_pannel/row_maintenance_view/zieles_total_order_pending.dart';
// import 'package:CIVM/piedmont/utils/custom_toast_snackbar_progressdialog.dart';
// import 'package:CIVM/piedmont/view_model/lcp_change_order_view_model.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:provider/provider.dart';
// import '../../../models/lcpChangeOrderModel.dart';
// import 'package:CIVM/piedmont/resources/app_colors.dart';
// import 'package:CIVM/utils/user_pref.dart';
// import 'package:CIVM/models/user_model.dart';
// import 'package:intl/intl.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'dart:io';
// import 'package:device_info_plus/device_info_plus.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:http/http.dart' as http;
// import 'package:path/path.dart' as path;
// import 'package:file_selector/file_selector.dart';

// // ignore: must_be_immutable
// class ZIELIESCreateOrder extends StatefulWidget {
//   String tokenNo;
//   String subStation;
//   String feeder;
//   String serviceStreetAddress;
//   dynamic serviceMapLocation;
//   String notes;
//   String type;
//   String maintType;
//   dynamic contractorCompany;
//   dynamic assignForeman;
//   String estimatedCost;
//   String estimatedTime;
//   String actualCost;
//   String crew;

//   ZIELIESCreateOrder({
//     Key? key,
//     required this.tokenNo,
//     required this.subStation,
//     required this.feeder,
//     required this.serviceStreetAddress,
//     required this.serviceMapLocation,
//     required this.notes,
//     required this.type,
//     required this.maintType,
//     required this.contractorCompany,
//     required this.assignForeman,
//     required this.estimatedCost,
//     required this.estimatedTime,
//     required this.actualCost,
//     required this.crew,
//   }) : super(key: key);

//   @override
//   State<ZIELIESCreateOrder> createState() => _ZIELIESCreateOrderState();
// }

// class _ZIELIESCreateOrderState extends State<ZIELIESCreateOrder> {
//   List<String> menu = [];
//   bool _isVisibleOtherServiceStreetAddress = false;
//   bool _isVisibleOtherServiceMapLocation = false;
//   bool _isVisibleOtherAssignForeman = false;

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

//   int substationId = 0;
//   // ignore: prefer_typing_uninitialized_variables
//   var selectedSubstation;

//   // ignore: prefer_typing_uninitialized_variables
//   var selectedFeeder;

//   String substationName = '';

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

//   // ignore: non_constant_identifier_names
//   List<String> select_maintenanceType = [
//     // 'JARAFF,MOWING,SPRAY WORK',
//     // 'JARAFF,MOWING,NO SPRAY',
//     // 'MOWING,NO SPRAY',
//     // 'MOWING',
//     // 'SPRAY',
//     // 'BUCKET WORK',
//     // 'GROUND WORK',
//     // 'NO SPRAY',
//     // 'DANGER TREE REMOVAL'
//     'JARAFF',
//     'MOWING',
// 	  'MINI JARAFF',
// 	  'BYL',
//    	'BUCKET',
// 	  'GROUND',
//     'CROSS COUNTRY SPRAY',
//     'ROADSIDE SPRAY',
//     'NO SPRAY',
//     'DANGER TREE REMOVAL'
//   ];
//   String? maintenanceType = 'JARAFF';

//   List<String> types = ['JARAFF'];

//   final _formkey = GlobalKey<FormState>();

//   onTappedBar(int index) {
//     setState(() {
//       // _currentIndex = index;
//     });
//   }

//   File? image;

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

//   int setDataFlag = 0;
//   int feederFlag = 0;
//   int serviceStreetFlag = 0;

//   LCPChangeOrderViewModel lcpChangeOrderViewModel = LCPChangeOrderViewModel();
//   TimeOfDay _selectedTime = TimeOfDay.now();

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

//   late List<CameraDescription> _cameras;
//   late CameraController _camerasController;
//   String imagePath = '';
//   String imagePath2 = '';
//   String imagePath3 = '';
//   var image1;
//   var image2;
//   var image3;

//   //   File? image1;
//   // File? image2;
//   // File? image3;
//   // String _imagePath = '';
//   // String _imagePath2 = '';
//   // String _imagePath3 = '';

//   var selectedCrew;
//   int crewId=0;

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
//         'PEMC');
//     _contratorComapny.text = 'PEMC';
//     getData();
//     cameraInit();
//     // getOwnPermissions();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//        backgroundColor:AppColors.backgroundColor,
//         appBar: AppBar(
//           iconTheme: const IconThemeData(color: Colors.white),
//           title:
//               const Text('Change Order', style: TextStyle(color: Colors.white)),
//           backgroundColor: AppColors.baseColor,
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
//                               'assets/empty_box_pemc.png',
//                               height: 200,
//                               width: 200,
//                               fit: BoxFit.cover,
//                             ),
//                             const Center(
//                               child: Text(
//                                 'Sorry, Data Not Found!',
//                                 textAlign: TextAlign.left,
//                                 style: TextStyle(
//                                   color: AppColors.baseColor,
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
//                                               AppColors.baseColor,
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
//                                                 color: AppColors.baseColor,
//                                                 fontWeight: FontWeight.bold),
//                                           ),
//                                         )),
//                                     Align(
//                                       alignment: Alignment.centerLeft,
//                                       child: Padding(
//                                         padding: const EdgeInsets.all(2.0),
//                                         child:
//                                             DropdownButtonFormField<String>(
//                                           hint: const Text('-Select-'),
//                                           dropdownColor: Colors.white,
//                                           value: selectedSubstation,
//                                           style: const TextStyle(
//                                               color: Color.fromARGB(
//                                                   255, 7, 59, 120),
//                                               fontSize: 16),
//                                           icon: const Icon(
//                                             Icons.arrow_drop_down,
//                                             color: AppColors.baseColor,
//                                             size: 40,
//                                           ),
//                                           decoration: const InputDecoration(
//                                             enabledBorder: OutlineInputBorder(
//                                               borderSide: BorderSide(
//                                                 color: AppColors.baseColor,
//                                               ),
//                                             ),
//                                             focusedBorder: OutlineInputBorder(
//                                               borderSide: BorderSide(
//                                                 color: AppColors.baseColor,
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
//                                               // e.getIdAndSubstationByCountId![0].subStation.toString(),
//                                               child: Text(
//                                                   e.subStation.toString()),
//                                             );
//                                           }).toList(),
//                                           onChanged: (val) {
//                                             setState(() {
//                                               selectedSubstation = val;
//                                             });
//                                             selectedFeeder = null;
//                                             selectedServiceStreet = null;
//                                             selectedMapLocation = null;
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
//                                                 color: AppColors.baseColor,
//                                                 fontWeight: FontWeight.bold),
//                                           ),
//                                         )),
//                                     Align(
//                                       alignment: Alignment.centerLeft,
//                                       child: Padding(
//                                         padding: const EdgeInsets.all(2.0),
//                                         child:
//                                             DropdownButtonFormField<String>(
//                                           hint: const Text('-Select-'),
//                                           dropdownColor: Colors.white,
//                                           value: selectedFeeder,
//                                           style: const TextStyle(
//                                               color: Color.fromARGB(
//                                                   255, 7, 59, 120),
//                                               fontSize: 16),
//                                           icon: const Icon(
//                                             Icons.arrow_drop_down,
//                                             color: AppColors.baseColor,
//                                             size: 40,
//                                           ),
//                                           decoration: const InputDecoration(
//                                             enabledBorder: OutlineInputBorder(
//                                               borderSide: BorderSide(
//                                                 color: AppColors.baseColor,
//                                               ),
//                                             ),
//                                             focusedBorder: OutlineInputBorder(
//                                               borderSide: BorderSide(
//                                                 color: AppColors.baseColor,
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
//                                               child:
//                                                   Text(e.feeder.toString()),
//                                             );
//                                           }).toList(),
//                                           onChanged: (val) {
//                                             setState(() {
//                                               selectedFeeder = val;
//                                             });
//                                             selectedServiceStreet = null;
//                                             selectedMapLocation = null;
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
//                                                 color: AppColors.baseColor,
//                                                 fontWeight: FontWeight.bold),
//                                           ),
//                                         )),
//                                     Align(
//                                       alignment: Alignment.centerLeft,
//                                       child: Padding(
//                                         padding: const EdgeInsets.all(2.0),
//                                         child:
//                                             DropdownButtonFormField<String>(
//                                           hint: const Text('-Select-'),
//                                           dropdownColor: Colors.white,
//                                           value: selectedServiceStreet,
//                                           style: const TextStyle(
//                                               color: Color.fromARGB(
//                                                   255, 7, 59, 120),
//                                               fontSize: 16),
//                                           icon: const Icon(
//                                             Icons.arrow_drop_down,
//                                             color: AppColors.baseColor,
//                                             size: 40,
//                                           ),
//                                           decoration: const InputDecoration(
//                                             enabledBorder: OutlineInputBorder(
//                                               borderSide: BorderSide(
//                                                 color: AppColors.baseColor,
//                                               ),
//                                             ),
//                                             focusedBorder: OutlineInputBorder(
//                                               borderSide: BorderSide(
//                                                 color: AppColors.baseColor,
//                                               ),
//                                             ),
//                                           ),
//                                           isExpanded: true,
//                                           items: lcpChangeOrderViewModel
//                                               .lcpChangeOrderList
//                                               .data!
//                                               .getAllStAddressListBySubstation!
//                                               .map((e) {
//                                             return DropdownMenuItem(
//                                               value:
//                                                   e.serviceAddress.toString(),
//                                               // e.getIdAndSubstationByCountId![0].subStation.toString(),
//                                               child: Text(e.serviceAddress
//                                                   .toString()),
//                                             );
//                                           }).toList(),
//                                           onChanged: (val) {
//                                             setState(() {
//                                               selectedServiceStreet = val;
//                                               selectedMapLocation = null;
//                                             });
//                                             if (selectedServiceStreet ==
//                                                 'OTHER') {
//                                               fetchData(
//                                                   substationName,
//                                                   '1',
//                                                   'Get',
//                                                   '',
//                                                   '',
//                                                   substationId.toString());
//                                               _isVisibleOtherServiceStreetAddress =
//                                                   true;
//                                             } else {
//                                               print(val);
//                                               fetchData(
//                                                   substationName,
//                                                   '1',
//                                                   'Get',
//                                                   val!,
//                                                   '',
//                                                   substationId.toString());
//                                               _isVisibleOtherServiceStreetAddress =
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
//                                                   color: AppColors.baseColor,
//                                                   fontSize: 16),
//                                               obscureText: false,
//                                               // keyboardType: TextInputType.number,
//                                               decoration:
//                                                   const InputDecoration(
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
//                                                       substationId
//                                                           .toString());
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
//                                                 color: AppColors.baseColor,
//                                                 fontWeight: FontWeight.bold),
//                                           ),
//                                         )),
//                                     Align(
//                                       alignment: Alignment.centerLeft,
//                                       child: Padding(
//                                         padding: const EdgeInsets.all(2.0),
//                                         child:
//                                             DropdownButtonFormField<String>(
//                                           hint: const Text('-Select-'),
//                                           dropdownColor: Colors.white,
//                                           value: selectedMapLocation,
//                                           style: const TextStyle(
//                                               color: Color.fromARGB(
//                                                   255, 7, 59, 120),
//                                               fontSize: 16),
//                                           icon: const Icon(
//                                             Icons.arrow_drop_down,
//                                             color: AppColors.baseColor,
//                                             size: 40,
//                                           ),
//                                           decoration: const InputDecoration(
//                                             enabledBorder: OutlineInputBorder(
//                                               borderSide: BorderSide(
//                                                 color: AppColors.baseColor,
//                                               ),
//                                             ),
//                                             focusedBorder: OutlineInputBorder(
//                                               borderSide: BorderSide(
//                                                 color: AppColors.baseColor,
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
//                                                   color: AppColors.baseColor,
//                                                   fontSize: 16),
//                                               obscureText: false,
//                                               // keyboardType: TextInputType.number,
//                                               decoration:
//                                                   const InputDecoration(
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
//                                                 color: AppColors.baseColor,
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
//                                                 color: AppColors.baseColor,
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
//                                                 color: AppColors.baseColor,
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
//                                             disabledBorder:
//                                                 OutlineInputBorder(
//                                               borderSide: BorderSide(
//                                                 color: AppColors.baseColor,
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
//                                                 color: AppColors.baseColor,
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
//                                           value: selectedCrew,
//                                           style: const TextStyle(
//                                               color: Color.fromARGB(
//                                                   255, 7, 59, 120),
//                                               fontSize: 16),
//                                           icon: const Icon(
//                                             Icons.arrow_drop_down,
//                                             color:
//                                                 AppColors.baseColor,
//                                             size: 40,
//                                           ),
//                                           decoration: const InputDecoration(
//                                             enabledBorder: OutlineInputBorder(
//                                               borderSide: BorderSide(
//                                                 color: AppColors.baseColor,
//                                               ),
//                                             ),
//                                             focusedBorder: OutlineInputBorder(
//                                               borderSide: BorderSide(
//                                                 color: AppColors.baseColor,
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
//                                     ),const Align(
//                                         alignment: Alignment.centerLeft,
//                                         child: Padding(
//                                           padding: EdgeInsets.only(
//                                               left: 2.0,
//                                               right: 2.0,
//                                               top: 8.0),
//                                           child: Text(
//                                             "ESTIMATED TIME*",
//                                             style: TextStyle(
//                                                 fontSize: 16,
//                                                 color: AppColors.baseColor,
//                                                 fontWeight: FontWeight.bold),
//                                           ),
//                                         )),
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
//                                                   border:
//                                                       OutlineInputBorder(),
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
//                                                   color: AppColors.baseColor,
//                                                 ),
//                                                 onPressed: _increment,
//                                               ),
//                                               IconButton(
//                                                 icon: const Icon(
//                                                   Icons.arrow_drop_down,
//                                                   color: AppColors.baseColor,
//                                                 ),
//                                                 onPressed: _decrement,
//                                               ),
//                                             ],
//                                           ),
//                                         ],
//                                       ),
//                                     ),
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

//   Future<void> _pickImagesCamera() async {
//     final ImagePicker picker = ImagePicker();
//     const ImageSource source = ImageSource.camera;
//     List<String> chosenImagePaths = [];

//     for (int i = 0; i < 3; i++) {
//       final XFile? image = await picker.pickImage(
//         source: source,
//         maxWidth: 1024,
//         maxHeight: 1024,
//         imageQuality: 100,
//       );

//       if (image != null) {
//         chosenImagePaths.add(image.path);
//       }
//     }

//     setState(() {
//       for (int i = 0; i < chosenImagePaths.length; i++) {
//         if (imagePath.isEmpty) {
//           imagePath = chosenImagePaths[i];
//           setState(() {
//             _isVisibleImage = true;
//           });
//         } else if (imagePath2.isEmpty) {
//           imagePath2 = chosenImagePaths[i];
//           setState(() {
//             _isVisibleImage2 = true;
//           });
//         } else if (imagePath3.isEmpty) {
//           imagePath3 = chosenImagePaths[i];
//           setState(() {
//             _isVisibleImage3 = true;
//           });
//         } else {
//           CustomToastSnackBarProgressDialog.toastMessage(
//             'You can select a maximum of 3 images!',
//           );
//           break;
//         }
//       }
//     });
//   }

//   Future<void> _pickImagesGallery() async {
//     final ImagePicker picker = ImagePicker();
//     List<String> chosenImagePaths = [];

//     for (int i = 0; i < 3; i++) {
//       final XFile? image = await picker.pickImage(
//         source: ImageSource.gallery, // Set source to ImageSource.gallery only
//         maxWidth: 1024,
//         maxHeight: 1024,
//         imageQuality: 100,
//       );

//       if (image != null) {
//         chosenImagePaths.add(image.path);
//       }
//     }

//     setState(() {
//       for (int i = 0; i < chosenImagePaths.length; i++) {
//         if (imagePath.isEmpty) {
//           imagePath = chosenImagePaths[i];
//           setState(() {
//             _isVisibleImage = true;
//           });
//         } else if (imagePath2.isEmpty) {
//           imagePath2 = chosenImagePaths[i];
//           setState(() {
//             _isVisibleImage2 = true;
//           });
//         } else if (imagePath3.isEmpty) {
//           imagePath3 = chosenImagePaths[i];
//           setState(() {
//             _isVisibleImage3 = true;
//           });
//         } else {
//           CustomToastSnackBarProgressDialog.toastMessage(
//             'You can select a maximum of 3 images!',
//           );
//           break;
//         }
//       }
//     });
//   }

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

//   Future<void> submitImage(String fileName, String tokenNo) async {
//     print('submit image api11111111111');
//     Directory tempDir = await getTemporaryDirectory();
//     print('submit image 22222222222222222');
//     String tempPath = tempDir.path;
//     try {
//       print('submit image 333333333333333333333');
//       var uri = Uri.parse(
//           "https://atsdev2test.ariespro.com/civmapi/contractorPanel/updateImageVEGETATION_CREW_FORMs");
//       var request = http.MultipartRequest("POST", uri);
//       final userPreferences = Provider.of<UserPref>(context, listen: false);
//       UserModel data = await userPreferences.getUser();
//       print('submit image 4444444444444444444');
//       var headers = {
//         "Content-Type": "multipart/form-data",
//         "Accept": "*/*",
//         "Authorization": 'Bearer ${data.token!}'
//       };
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
//             builder: (BuildContext context) => ZIELIESTotalOrderPending(
//                   budgetType: '',
//                   maintenanceType: 'Change Order',
//                   heading: 'Change Order',
//                 )));
//       }
//     } catch (e) {
//       print('inside catch of image upload api.................');
//     }
//     _isVisibleImage = true;
//   }

//   Future<void> deleteOnlineImageApi(String fileName) async {
//     final apiUrl =
//         'https://atsdev2test.ariespro.com/civmapi/changeOrderLcpCreateOrder/deleteFile?fileName=$fileName';
//     print(apiUrl);
//     final userPreferences = Provider.of<UserPref>(context, listen: false);
//     UserModel data = await userPreferences.getUser();

//     try {
//       final response = await http.delete(
//         Uri.parse(apiUrl),
//         headers: {"Authorization": 'Bearer ${data.token!}'},
//       );

//       if (response.statusCode == 200) {
//         print('API response: ${response.body}');
//         setState(() {});
//         print('Image deleted successfully');
//       } else {
//         print('API request failed with status code: ${response.statusCode}');
//         print('Response body: ${response.body}');
//       }
//     } catch (e) {
//       print('Error: $e');
//     }
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
//     lcpChangeOrderViewModel.fetchLCPChangeOrderViewListApi(context, substation,
//         userType, action, streetAddress, location, substationId, 'PEMC');
//   }

//   void _setData() {
//     print('widget.type ${widget.type}');
//     print('widget.maintType ${widget.maintType}');
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
//     //updateMaintenanceType();
//     ///////////////////////////////////
//   }

//   // void updateMaintenanceType() {
//   //   String typeFromBackend = widget.type;
//   //   print('widget.types111: $typeFromBackend');

//   //   List<String> widgetTypes111 = typeFromBackend.split(', ');
//   //   widgetTypes111 = widgetTypes111.map((e) => e.trim()).toList();
//   //   print('widgetTypes111: $widgetTypes111');

//   //   Set<String> typesSet = widgetTypes111.toSet();
//   //   List<String> types = typesSet.toList();
//   //   String newMaintenanceType = types.isEmpty ? '' : types.join(', ');

//   //   print('newMaintenanceType: $newMaintenanceType');

//   //   WidgetsBinding.instance.addPostFrameCallback((_) {
//   //     print('Current maintenanceType: $maintenanceType');
//   //     print('Comparing with newMaintenanceType: $newMaintenanceType');

//   //     if (newMaintenanceType != maintenanceType) {
//   //       setState(() {
//   //         print('Updating maintenanceType...');
//   //         maintenanceType = newMaintenanceType;
//   //         print('Updated maintenanceType: $maintenanceType');
//   //       });
//   //     }
//   //   });
//   // }

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
//         'https://atsdev2test.ariespro.com/civmapi/changeOrderLcpCreateOrder/SP_INSERT_SM_MAINT_TEST_RESULT_REQUEST';

//     final userPreferences = Provider.of<UserPref>(context, listen: false);
//     UserModel data = await userPreferences.getUser();
//     try {
//       final response = await http.post(
//         Uri.parse(apiUrl),
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer ${data.token}',
//         },
//         body: jsonEncode(mappedData),
//       );

//       if (response.statusCode == 200) {
//         print('API Response: ${response.body}');
//         CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
//             'Successfully Created', context);
//         Future.delayed(const Duration(seconds: 2), () {
//           setState(() {
//             _notes.clear();
//             selectedSubstation = null;
//             selectedServiceStreet = null;
//             selectedMapLocation = null;
//             maintenanceType = null;
//             selectedAssignForman = null;
//             imagePath = '';
//             imagePath2 = '';
//             imagePath3 = '';
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
//         //         const ZIELIESTotalOrderPending()));
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
//         } else {
//           Navigator.of(context).push(MaterialPageRoute(
//               builder: (BuildContext context) => ZIELIESTotalOrderPending(
//                     budgetType: '',
//                     maintenanceType: 'Change Order',
//                     heading: 'Change Order',
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
//                       color: AppColors.baseColor,
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
//                         _pickImagesGallery();
//                         // _pickImagesAndDocuments();
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
//                             "Gallery",
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
//             'PEMC');
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
//         Future.delayed(const Duration(seconds: 4), () {
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
//                     });
//                     fetchData(substationName, '', '', selectedServiceStreet, '',
//                         substationId.toString());
//                     Future.delayed(const Duration(seconds: 1), () {
//                       serviceStreetFlag = 1;
//                     });
//                   }
//                   Future.delayed(const Duration(seconds: 1), () {
//                     print(
//                         'widget.serviceMapLocation ${widget.serviceMapLocation}');
//                     if (serviceStreetFlag == 1) {
//                       setState(() {
//                         selectedMapLocation =
//                             widget.serviceMapLocation.toString();
//                       });
//                       print('selectedMapLocation1111 $selectedMapLocation');
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

//   Future<void> _takePictureDialog() async {
//     return showDialog<void>(
//         context: context,
//         barrierDismissible: false, // user must tap button!
//         builder: (BuildContext context) {
//           return StatefulBuilder(builder: (context, setState) {
//             return AlertDialog(
//                 content: SingleChildScrollView(
//                   child: Column(
//                     children: <Widget>[
//                       Container(
//                         margin: const EdgeInsets.only(top: 4.0),
//                         child: Padding(
//                           padding: const EdgeInsets.all(2.0),
//                           child: CameraPreview(_camerasController),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 actions: [
//                   Align(
//                     alignment: Alignment.center,
//                     child: Padding(
//                       padding: const EdgeInsets.all(2.0),
//                       child: InkWell(
//                         onTap: (() async {
//                           if (imagePath == '') {
//                             image1 = await _camerasController.takePicture();
//                             refreshPath(image1.path, image1);
//                           } else if (imagePath2 == '') {
//                             image2 = await _camerasController.takePicture();
//                             refreshPath(image2.path, image2);
//                           } else if (imagePath3 == '') {
//                             image3 = await _camerasController.takePicture();
//                             refreshPath(image3.path, image3);
//                           } else {
//                             CustomToastSnackBarProgressDialog.snackBar(
//                                 'You can take maximum 3 pictures!', context);
//                           }

//                           Navigator.of(context).pop();
//                         }),
//                         child: Container(
//                           margin: const EdgeInsets.all(4.0),
//                           width: MediaQuery.of(context).size.width * 0.4,
//                           height: MediaQuery.of(context).size.height * 0.052,
//                           decoration: const BoxDecoration(
//                               // shape: BoxShape.circle,

//                               boxShadow: [
//                                 BoxShadow(
//                                     color: Color.fromARGB(255, 60, 59, 59),
//                                     blurRadius: 5,
//                                     offset: Offset(2.0, 5.0))
//                               ],
//                               color: Colors.black,
//                               gradient: LinearGradient(
//                                 colors: [
//                                   Color.fromARGB(255, 7, 40, 97),
//                                   Color.fromARGB(255, 7, 40, 97),
//                                   Color.fromARGB(255, 7, 40, 97),
//                                 ],
//                               )),
//                           child: const Align(
//                             alignment: Alignment.center,
//                             child: Text(
//                               "Take Picture",
//                               textAlign: TextAlign.left,
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 14,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ]);
//           });
//         });
//   }

//   void refreshPath(String path, imageARG) {
//     setState(() {
//       if (imagePath == '') {
//         imagePath = path;
//         image1 = imageARG;
//         _isVisibleImage = true;
//       } else if (imagePath2 == '') {
//         imagePath2 = path;
//         image2 = imageARG;
//         _isVisibleImage2 = true;
//       } else if (imagePath3 == '') {
//         imagePath3 = path;
//         image3 = imageARG;
//         _isVisibleImage3 = true;
//       }
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
// }
