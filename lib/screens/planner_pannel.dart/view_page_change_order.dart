// import 'package:CIVM/data/response/status.dart';
// import 'package:CIVM/view_model/lcp_change_order_view_model.dart';
// import 'package:flutter/material.dart';
// import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
// import 'package:multi_select_flutter/util/multi_select_item.dart';
// import 'package:multi_select_flutter/util/multi_select_list_type.dart';
// import 'package:provider/provider.dart';
// import '../../../models/lcpChangeOrderModel.dart';

// import 'dart:io';

// // ignore: must_be_immutable
// class ViewLCPCreateOrder extends StatefulWidget {
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

//   ViewLCPCreateOrder({
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
//   }) : super(key: key);

//   @override
//   State<ViewLCPCreateOrder> createState() => _ViewLCPCreateOrderState();
// }

// class _ViewLCPCreateOrderState extends State<ViewLCPCreateOrder> {
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
//     'JARAFF,MOWING,SPRAY WORK',
//     'JARAFF,MOWING,NO SPRAY',
//     'MOWING,NO SPRAY',
//     'MOWING',
//     'SPRAY',
//     'BUCKET WORK',
//     'GROUND WORK',
//     'NO SPRAY',
//     'DANGER TREE REMOVAL'
//   ];
//   String? maintenanceType = 'JARAFF,MOWING,SPRAY WORK';

//   List<String> types = ['JARAFF,MOWING,SPRAY WORK'];

//   final _formkey = GlobalKey<FormState>();

//   File? image;

//   // bool _isVisibleImage = false;
//   // bool _isVisibleImage2 = false;
//   // bool _isVisibleImage3 = false;
//   // bool _isVisibleImageDoc = false;
//   // bool _isVisibleImage2Doc = false;
//   // bool _isVisibleImage3Doc = false;
//   // bool _isVisibleUpdateMap = false;
//   // ignore: prefer_typing_uninitialized_variables
//   var deleteImage1;
//   // ignore: prefer_typing_uninitialized_variables
//   var deleteImage2;
//   // ignore: prefer_typing_uninitialized_variables
//   var deleteImage3;

//   File? image1;
//   File? image2;
//   File? image3;
//   // String _imagePath = '';
//   // String _imagePath2 = '';
//   // String _imagePath3 = '';

//   onTappedBar(int index) {
//     setState(() {
//       // _currentIndex = index;
//     });
//   }

//   // int imageFlag = 1;
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
//           title: const Text('View Change Order',
//               style: TextStyle(color: Colors.white)),
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
//                       child: Column(
//                         children: [
//                           Image.asset(
//                             'assets/empty_box.png',
//                             height: 200,
//                             width: 200,
//                             fit: BoxFit.cover,
//                           ),
//                           const Center(
//                             child: Text(
//                               'Sorry, Data Not Found!',
//                               textAlign: TextAlign.left,
//                               style: TextStyle(
//                                 color: Color.fromARGB(255, 7, 59, 120),
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 20,
//                               ),
//                             ),
//                           ),
//                         ],
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

//                   // image upload API called after create order
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
//                   return RefreshIndicator(
//                     onRefresh: () async {
//                       await lcpChangeOrderViewModel
//                           .fetchLCPChangeOrderViewListApi(
//                               context,
//                               widget.subStation,
//                               '1',
//                               'Get',
//                               widget.serviceStreetAddress,
//                               widget.serviceMapLocation,
//                               substationId.toString(),
//                               widget.contractorCompany);
//                       getData();
//                     },
//                     child: SingleChildScrollView(
//                       child: DefaultTabController(
//                         length: 2,
//                         child: Padding(
//                           padding: const EdgeInsets.all(4.0),
//                           child: Form(
//                             key: _formkey,
//                             child: Column(
//                               children: [
//                                 Container(
//                                   margin: const EdgeInsets.only(
//                                       left: 8, right: 8, top: 10, bottom: 8),
//                                   padding: const EdgeInsets.all(8),
//                                   alignment: Alignment.center,
//                                   // height: size.height * 0.5,
//                                   width: size.width * 0.99,
//                                   decoration: BoxDecoration(
//                                       // shape: BoxShape.circle,
//                                       borderRadius: BorderRadius.circular(10),
//                                       boxShadow: const [
//                                         BoxShadow(
//                                             color:
//                                                 Color.fromARGB(255, 7, 59, 120),
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
//                                       const Align(
//                                           alignment: Alignment.centerLeft,
//                                           child: Padding(
//                                             padding: EdgeInsets.only(
//                                                 left: 2.0,
//                                                 right: 2.0,
//                                                 bottom: 2.0,
//                                                 top: 8.0),
//                                             child: Text(
//                                               "SUBSTATION*",
//                                               style: TextStyle(
//                                                   fontSize: 16,
//                                                   color: Color.fromARGB(
//                                                       255, 7, 59, 120),
//                                                   fontWeight: FontWeight.bold),
//                                             ),
//                                           )),
//                                       Align(
//                                         alignment: Alignment.centerLeft,
//                                         child: Padding(
//                                           padding: const EdgeInsets.all(2.0),
//                                           child:
//                                               DropdownButtonFormField<String>(
//                                             hint: const Text('-Select-'),
//                                             dropdownColor: Colors.white,
//                                             value: selectedSubstation,
//                                             style: const TextStyle(
//                                                 color: Color.fromARGB(
//                                                     255, 7, 59, 120),
//                                                 fontSize: 16),
//                                             icon: const Icon(
//                                               Icons.arrow_drop_down,
//                                               color: Color.fromARGB(
//                                                   255, 7, 59, 120),
//                                               size: 40,
//                                             ),
//                                             decoration: const InputDecoration(
//                                               enabledBorder: OutlineInputBorder(
//                                                 borderSide: BorderSide(
//                                                   color: Color.fromARGB(
//                                                       255, 7, 59, 120),
//                                                 ),
//                                               ),
//                                               focusedBorder: OutlineInputBorder(
//                                                 borderSide: BorderSide(
//                                                   color: Color.fromARGB(
//                                                       255, 7, 59, 120),
//                                                 ),
//                                               ),
//                                             ),
//                                             isExpanded: true,
//                                             items: lcpChangeOrderViewModel
//                                                 .lcpChangeOrderList
//                                                 .data!
//                                                 .findAllIdAndSubstation!
//                                                 .map((e) {
//                                               return DropdownMenuItem(
//                                                 value: e.id.toString(),
//                                                 child: Text(
//                                                     e.subStation.toString()),
//                                               );
//                                             }).toList(),
//                                             onChanged: (val) {
//                                               setState(() {
//                                                 selectedSubstation = val;
//                                               });
//                                               selectedFeeder = null;
//                                               selectedServiceStreet = null;
//                                               selectedMapLocation = null;
//                                               substationId = int.parse(val!);

//                                               substationName =
//                                                   getSubstationNameById(val);
//                                               fetchData(
//                                                   substationName,
//                                                   '',
//                                                   '',
//                                                   '',
//                                                   '',
//                                                   substationId.toString());
//                                             },
//                                             validator: (value) => value == null
//                                                 ? 'field required'
//                                                 : null,
//                                           ),
//                                         ),
//                                       ),
//                                       const Align(
//                                           alignment: Alignment.centerLeft,
//                                           child: Padding(
//                                             padding: EdgeInsets.only(
//                                                 left: 2.0,
//                                                 right: 2.0,
//                                                 bottom: 2.0,
//                                                 top: 8.0),
//                                             child: Text(
//                                               "FEEDER*",
//                                               style: TextStyle(
//                                                   fontSize: 16,
//                                                   color: Color.fromARGB(
//                                                       255, 7, 59, 120),
//                                                   fontWeight: FontWeight.bold),
//                                             ),
//                                           )),
//                                       Align(
//                                         alignment: Alignment.centerLeft,
//                                         child: Padding(
//                                           padding: const EdgeInsets.all(2.0),
//                                           child:
//                                               DropdownButtonFormField<String>(
//                                             hint: const Text('-Select-'),
//                                             dropdownColor: Colors.white,
//                                             value: selectedFeeder,
//                                             style: const TextStyle(
//                                                 color: Color.fromARGB(
//                                                     255, 7, 59, 120),
//                                                 fontSize: 16),
//                                             icon: const Icon(
//                                               Icons.arrow_drop_down,
//                                               color: Color.fromARGB(
//                                                   255, 7, 59, 120),
//                                               size: 40,
//                                             ),
//                                             decoration: const InputDecoration(
//                                               enabledBorder: OutlineInputBorder(
//                                                 borderSide: BorderSide(
//                                                   color: Color.fromARGB(
//                                                       255, 7, 59, 120),
//                                                 ),
//                                               ),
//                                               focusedBorder: OutlineInputBorder(
//                                                 borderSide: BorderSide(
//                                                   color: Color.fromARGB(
//                                                       255, 7, 59, 120),
//                                                 ),
//                                               ),
//                                             ),
//                                             isExpanded: true,
//                                             items: lcpChangeOrderViewModel
//                                                 .lcpChangeOrderList
//                                                 .data!
//                                                 .getIdAndFeederBySubstationId!
//                                                 .map((e) {
//                                               return DropdownMenuItem(
//                                                 value: e.id.toString(),
//                                                 child:
//                                                     Text(e.feeder.toString()),
//                                               );
//                                             }).toList(),
//                                             onChanged: (val) {
//                                               setState(() {
//                                                 selectedFeeder = val;
//                                               });
//                                               selectedServiceStreet = null;
//                                               selectedMapLocation = null;
//                                               // substationId = int.parse(val!);

//                                               // substationName =
//                                               //     getSubstationNameById(val);
//                                               fetchData(
//                                                   substationName,
//                                                   '',
//                                                   '',
//                                                   '',
//                                                   '',
//                                                   substationId.toString());
//                                             },
//                                             validator: (value) => value == null
//                                                 ? 'field required'
//                                                 : null,
//                                           ),
//                                         ),
//                                       ),
//                                       const Align(
//                                           alignment: Alignment.centerLeft,
//                                           child: Padding(
//                                             padding: EdgeInsets.only(
//                                                 left: 2.0,
//                                                 right: 2.0,
//                                                 bottom: 2.0,
//                                                 top: 8.0),
//                                             child: Text(
//                                               "SERVICE STREET ADDRESS*",
//                                               style: TextStyle(
//                                                   fontSize: 16,
//                                                   color: Color.fromARGB(
//                                                       255, 7, 59, 120),
//                                                   fontWeight: FontWeight.bold),
//                                             ),
//                                           )),
//                                       Align(
//                                         alignment: Alignment.centerLeft,
//                                         child: Padding(
//                                           padding: const EdgeInsets.all(2.0),
//                                           child:
//                                               DropdownButtonFormField<String>(
//                                             hint: const Text('-Select-'),
//                                             dropdownColor: Colors.white,
//                                             value: selectedServiceStreet,
//                                             style: const TextStyle(
//                                                 color: Color.fromARGB(
//                                                     255, 7, 59, 120),
//                                                 fontSize: 16),
//                                             icon: const Icon(
//                                               Icons.arrow_drop_down,
//                                               color: Color.fromARGB(
//                                                   255, 7, 59, 120),
//                                               size: 40,
//                                             ),
//                                             decoration: const InputDecoration(
//                                               enabledBorder: OutlineInputBorder(
//                                                 borderSide: BorderSide(
//                                                   color: Color.fromARGB(
//                                                       255, 7, 59, 120),
//                                                 ),
//                                               ),
//                                               focusedBorder: OutlineInputBorder(
//                                                 borderSide: BorderSide(
//                                                   color: Color.fromARGB(
//                                                       255, 7, 59, 120),
//                                                 ),
//                                               ),
//                                             ),
//                                             isExpanded: true,
//                                             items: lcpChangeOrderViewModel
//                                                 .lcpChangeOrderList
//                                                 .data!
//                                                 .getAllStAddressListBySubstation!
//                                                 .map((e) {
//                                               return DropdownMenuItem(
//                                                 value:
//                                                     e.serviceAddress.toString(),
//                                                 // e.getIdAndSubstationByCountId![0].subStation.toString(),
//                                                 child: Text(e.serviceAddress
//                                                     .toString()),
//                                               );
//                                             }).toList(),
//                                             onChanged: (val) {
//                                               setState(() {
//                                                 selectedServiceStreet = val;
//                                                 selectedMapLocation = null;
//                                               });
//                                               if (selectedServiceStreet ==
//                                                   'OTHER') {
//                                                 fetchData(
//                                                     substationName,
//                                                     '1',
//                                                     'Get',
//                                                     '',
//                                                     '',
//                                                     substationId.toString());
//                                                 _isVisibleOtherServiceStreetAddress =
//                                                     true;
//                                               } else {
//                                                 fetchData(
//                                                     substationName,
//                                                     '1',
//                                                     'Get',
//                                                     val!,
//                                                     '',
//                                                     substationId.toString());
//                                                 _isVisibleOtherServiceStreetAddress =
//                                                     false;
//                                               }
//                                             },
//                                             validator: (value) => value == null
//                                                 ? 'field required'
//                                                 : null,
//                                           ),
//                                         ),
//                                       ),
//                                       Visibility(
//                                         visible:
//                                             _isVisibleOtherServiceStreetAddress,
//                                         child: Padding(
//                                           padding:
//                                               const EdgeInsets.only(top: 10.0),
//                                           child: Align(
//                                             alignment: Alignment.centerRight,
//                                             child: Padding(
//                                               padding: const EdgeInsets.only(
//                                                   right: 2.0,
//                                                   top: 2,
//                                                   bottom: 2,
//                                                   left: 2),
//                                               child: TextFormField(
//                                                 //  key: formkey5,
//                                                 controller:
//                                                     _otherServiceStreetAddress,
//                                                 // onEditingComplete: fetchData(
//                                                 //     substationId.toString(),
//                                                 //     '1',
//                                                 //     'INSERT',
//                                                 //     _otherServiceStreetAddress.text
//                                                 //         .toString(),
//                                                 //     ''),
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
//                                                 onChanged: (value) {},
//                                                 validator: (value) {
//                                                   if (value!.isEmpty) {
//                                                     return "";
//                                                   } else {
//                                                     fetchData(
//                                                         substationName,
//                                                         '1',
//                                                         'INSERT',
//                                                         _otherServiceStreetAddress
//                                                             .text
//                                                             .toString(),
//                                                         '',
//                                                         substationId
//                                                             .toString());
//                                                     return null;
//                                                   }
//                                                 },
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                       const Align(
//                                           alignment: Alignment.centerLeft,
//                                           child: Padding(
//                                             padding: EdgeInsets.only(
//                                                 left: 2.0,
//                                                 right: 2.0,
//                                                 bottom: 2.0,
//                                                 top: 8.0),
//                                             child: Text(
//                                               "SERVICE MAP LOCATION*",
//                                               style: TextStyle(
//                                                   fontSize: 16,
//                                                   color: Color.fromARGB(
//                                                       255, 7, 59, 120),
//                                                   fontWeight: FontWeight.bold),
//                                             ),
//                                           )),
//                                       Align(
//                                         alignment: Alignment.centerLeft,
//                                         child: Padding(
//                                           padding: const EdgeInsets.all(2.0),
//                                           child:
//                                               DropdownButtonFormField<String>(
//                                             hint: const Text('-Select-'),
//                                             dropdownColor: Colors.white,
//                                             value: selectedMapLocation,
//                                             style: const TextStyle(
//                                                 color: Color.fromARGB(
//                                                     255, 7, 59, 120),
//                                                 fontSize: 16),
//                                             icon: const Icon(
//                                               Icons.arrow_drop_down,
//                                               color: Color.fromARGB(
//                                                   255, 7, 59, 120),
//                                               size: 40,
//                                             ),
//                                             decoration: const InputDecoration(
//                                               enabledBorder: OutlineInputBorder(
//                                                 borderSide: BorderSide(
//                                                   color: Color.fromARGB(
//                                                       255, 7, 59, 120),
//                                                 ),
//                                               ),
//                                               focusedBorder: OutlineInputBorder(
//                                                 borderSide: BorderSide(
//                                                   color: Color.fromARGB(
//                                                       255, 7, 59, 120),
//                                                 ),
//                                               ),
//                                             ),
//                                             isExpanded: true,
//                                             items: lcpChangeOrderViewModel
//                                                 .lcpChangeOrderList
//                                                 .data!
//                                                 .getAllLocationsListBySubstationAndStAddress!
//                                                 .map((e) {
//                                               return DropdownMenuItem(
//                                                 value: e.serviceAddressLocation
//                                                     .toString(),
//                                                 // e.getIdAndSubstationByCountId![0].subStation.toString(),
//                                                 child: Text(e
//                                                     .serviceAddressLocation
//                                                     .toString()),
//                                               );
//                                             }).toList(),
//                                             onChanged: (val) {
//                                               setState(() {
//                                                 selectedMapLocation = val;
//                                               });
//                                               if (selectedMapLocation ==
//                                                   'OTHER') {
//                                                 _isVisibleOtherServiceMapLocation =
//                                                     true;
//                                               } else {
//                                                 fetchData(
//                                                     substationName,
//                                                     '1',
//                                                     'Get',
//                                                     selectedServiceStreet,
//                                                     val!,
//                                                     substationId.toString());
//                                                 _isVisibleOtherServiceMapLocation =
//                                                     false;
//                                               }
//                                             },
//                                             validator: (value) => value == null
//                                                 ? 'field required'
//                                                 : null,
//                                           ),
//                                         ),
//                                       ),
//                                       Visibility(
//                                         visible:
//                                             _isVisibleOtherServiceMapLocation,
//                                         child: Padding(
//                                           padding:
//                                               const EdgeInsets.only(top: 10.0),
//                                           child: Align(
//                                             alignment: Alignment.centerRight,
//                                             child: Padding(
//                                               padding: const EdgeInsets.only(
//                                                   right: 2.0,
//                                                   top: 2,
//                                                   bottom: 2,
//                                                   left: 2),
//                                               child: TextFormField(
//                                                 //  key: formkey5,
//                                                 controller:
//                                                     _otherServiceMapLocation,
//                                                 // onEditingComplete: onTextChanged,
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

//                                                 validator: (value) {
//                                                   if (value!.isEmpty) {
//                                                     return "";
//                                                   } else {
//                                                     return null;
//                                                   }
//                                                 },
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                       const Align(
//                                           alignment: Alignment.centerLeft,
//                                           child: Padding(
//                                             padding: EdgeInsets.only(
//                                                 left: 2.0,
//                                                 right: 2.0,
//                                                 bottom: 2.0,
//                                                 top: 8.0),
//                                             child: Text(
//                                               "NOTES*",
//                                               style: TextStyle(
//                                                   fontSize: 16.0,
//                                                   color: Color.fromARGB(
//                                                       255, 7, 59, 120),
//                                                   fontWeight: FontWeight.bold),
//                                             ),
//                                           )),
//                                       Align(
//                                         alignment: Alignment.centerRight,
//                                         child: Padding(
//                                           padding: const EdgeInsets.all(2.0),
//                                           child: TextFormField(
//                                             //  key: formkey5,
//                                             controller: _notes,
//                                             style: const TextStyle(
//                                                 color: Color.fromARGB(
//                                                     255, 7, 59, 120),
//                                                 fontSize: 16),
//                                             obscureText: false,
//                                             // keyboardType: TextInputType.number,
//                                             decoration: const InputDecoration(
//                                               border: OutlineInputBorder(),
//                                               enabledBorder: OutlineInputBorder(
//                                                 borderSide: BorderSide(
//                                                   color: Color.fromARGB(
//                                                       255, 7, 59, 120),
//                                                 ),
//                                               ),
//                                               hintText: 'Notes',
//                                             ),
//                                             validator: (value) {
//                                               if (value!.isEmpty) {
//                                                 return "Please enter Notes";
//                                               } else {
//                                                 return null;
//                                               }
//                                             },
//                                           ),
//                                         ),
//                                       ),
//                                       const Align(
//                                           alignment: Alignment.centerLeft,
//                                           child: Padding(
//                                             padding: EdgeInsets.only(
//                                                 left: 2.0,
//                                                 right: 2.0,
//                                                 bottom: 2.0,
//                                                 top: 8.0),
//                                             child: Text(
//                                               "MAINTENANCE TYPE*",
//                                               style: TextStyle(
//                                                   fontSize: 16,
//                                                   color: Color.fromARGB(
//                                                       255, 7, 59, 120),
//                                                   fontWeight: FontWeight.bold),
//                                             ),
//                                           )),
//                                       Align(
//                                         alignment: Alignment.centerRight,
//                                         child: Padding(
//                                           padding: const EdgeInsets.all(2.0),
//                                           child: Container(
//                                             padding: const EdgeInsets.symmetric(
//                                                 horizontal: 12, vertical: 4),
//                                             decoration: BoxDecoration(
//                                               // borderRadius:
//                                               //     BorderRadius.circular(25),
//                                               border: Border.all(
//                                                 color: const Color.fromARGB(
//                                                     255, 7, 59, 120),
//                                               ),
//                                             ),
//                                             child: MultiSelectDialogField(
//                                               initialValue:
//                                                   types, // Ensure this list is correct
//                                               items: select_maintenanceType
//                                                   .map((e) =>
//                                                       MultiSelectItem(e, e))
//                                                   .toList(),
//                                               listType:
//                                                   MultiSelectListType.CHIP,
//                                               onConfirm: (List<dynamic> value) {
//                                                 // Use List<dynamic> as the type
//                                                 setState(() {
//                                                   maintenanceType =
//                                                       value.join(', ');
//                                                   //    types.add(value.toString());
//                                                 });
//                                                 print(
//                                                     'maintenanceType123$maintenanceType'); // This should print the selected values
//                                               },
//                                               validator: (value) => value ==
//                                                       null
//                                                   ? 'Field required'
//                                                   : null, // Basic validation example
//                                             ),
//                                           ),
//                                         ),
//                                       ),

//                                       const Align(
//                                           alignment: Alignment.centerLeft,
//                                           child: Padding(
//                                             padding: EdgeInsets.only(
//                                                 left: 2.0,
//                                                 right: 2.0,
//                                                 bottom: 2.0,
//                                                 top: 8.0),
//                                             child: Text(
//                                               "CONTRACTOR COMPANY*",
//                                               style: TextStyle(
//                                                   fontSize: 16,
//                                                   color: Color.fromARGB(
//                                                       255, 7, 59, 120),
//                                                   fontWeight: FontWeight.bold),
//                                             ),
//                                           )),
//                                       Align(
//                                         alignment: Alignment.centerRight,
//                                         child: Padding(
//                                           padding: const EdgeInsets.only(
//                                               right: 2.0,
//                                               top: 2,
//                                               bottom: 2,
//                                               left: 2),
//                                           child: TextFormField(
//                                             enabled: false,
//                                             //  key: formkey5,
//                                             controller: _contratorComapny,
//                                             style: const TextStyle(
//                                                 color: Color.fromARGB(
//                                                     255, 7, 59, 120),
//                                                 fontSize: 16),
//                                             obscureText: false,
//                                             // keyboardType: TextInputType.number,
//                                             decoration: const InputDecoration(
//                                               border: OutlineInputBorder(),
//                                               disabledBorder:
//                                                   OutlineInputBorder(
//                                                 borderSide: BorderSide(
//                                                   color: Color.fromARGB(
//                                                       255, 7, 59, 120),
//                                                 ),
//                                               ),
//                                               hintText: '',
//                                             ),
//                                             onChanged: (value) {},
//                                             validator: (value) {
//                                               if (value!.isEmpty) {
//                                                 return "Please enter Contractor Company";
//                                               } else {
//                                                 return null;
//                                               }
//                                             },
//                                           ),
//                                         ),
//                                       ),
//                                       const Align(
//                                           alignment: Alignment.centerLeft,
//                                           child: Padding(
//                                             padding: EdgeInsets.only(
//                                                 left: 2.0,
//                                                 right: 2.0,
//                                                 bottom: 2.0,
//                                                 top: 8.0),
//                                             child: Text(
//                                               "ASSIGN FOREMAN*",
//                                               style: TextStyle(
//                                                   fontSize: 16,
//                                                   color: Color.fromARGB(
//                                                       255, 7, 59, 120),
//                                                   fontWeight: FontWeight.bold),
//                                             ),
//                                           )),
//                                       Align(
//                                         alignment: Alignment.centerLeft,
//                                         child: Padding(
//                                           padding: const EdgeInsets.all(2.0),
//                                           child:
//                                               DropdownButtonFormField<String>(
//                                             hint: const Text('-Select-'),
//                                             dropdownColor: Colors.white,
//                                             value: selectedAssignForman,
//                                             style: const TextStyle(
//                                                 color: Color.fromARGB(
//                                                     255, 7, 59, 120),
//                                                 fontSize: 16),
//                                             icon: const Icon(
//                                               Icons.arrow_drop_down,
//                                               color: Color.fromARGB(
//                                                   255, 7, 59, 120),
//                                               size: 40,
//                                             ),
//                                             decoration: const InputDecoration(
//                                               enabledBorder: OutlineInputBorder(
//                                                 borderSide: BorderSide(
//                                                   color: Color.fromARGB(
//                                                       255, 7, 59, 120),
//                                                 ),
//                                               ),
//                                               focusedBorder: OutlineInputBorder(
//                                                 borderSide: BorderSide(
//                                                   color: Color.fromARGB(
//                                                       255, 7, 59, 120),
//                                                 ),
//                                               ),
//                                             ),
//                                             isExpanded: true,
//                                             items: lcpChangeOrderViewModel
//                                                 .lcpChangeOrderList
//                                                 .data!
//                                                 .contractorGetInsert!
//                                                 .map((e) {
//                                               return DropdownMenuItem(
//                                                 value: e.name.toString(),
//                                                 // e.getIdAndSubstationByCountId![0].subStation.toString(),
//                                                 child: Text(e.name.toString()),
//                                               );
//                                             }).toList(),
//                                             onChanged: (val) {
//                                               setState(() {
//                                                 selectedAssignForman = val;
//                                               });
//                                               if (selectedAssignForman ==
//                                                   'Other') {
//                                                 _isVisibleOtherAssignForeman =
//                                                     true;
//                                               } else {
//                                                 _isVisibleOtherAssignForeman =
//                                                     false;
//                                               }

//                                               List<ContractorGetInsert>?
//                                                   loginIdList =
//                                                   lcpChangeOrderViewModel
//                                                       .lcpChangeOrderList
//                                                       .data!
//                                                       .contractorGetInsert;
//                                               loginIdList?.forEach(
//                                                   (ContractorGetInsert a) {
//                                                 if (a.name ==
//                                                     selectedAssignForman) {
//                                                   assignFormanId = a.loginId!;
//                                                 }
//                                               });
//                                             },
//                                             validator: (value) => value == null
//                                                 ? 'field required'
//                                                 : null,
//                                           ),
//                                         ),
//                                       ),
//                                       Visibility(
//                                         visible: _isVisibleOtherAssignForeman,
//                                         child: Padding(
//                                           padding:
//                                               const EdgeInsets.only(top: 10.0),
//                                           child: Align(
//                                             alignment: Alignment.centerRight,
//                                             child: Padding(
//                                               padding: const EdgeInsets.only(
//                                                   right: 2.0,
//                                                   top: 2,
//                                                   bottom: 2,
//                                                   left: 2),
//                                               child: TextFormField(
//                                                 //  key: formkey5,
//                                                 controller: _otherAssignForeman,
//                                                 // onEditingComplete: onTextChanged,
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

//                                                 validator: (value) {
//                                                   if (value!.isEmpty) {
//                                                     return "";
//                                                   } else {
//                                                     return null;
//                                                   }
//                                                 },
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                       // const Align(
//                                       //     alignment: Alignment.centerLeft,
//                                       //     child: Padding(
//                                       //       padding: EdgeInsets.only(
//                                       //           left: 2.0,
//                                       //           right: 2.0,
//                                       //           bottom: 2.0,
//                                       //           top: 8.0),
//                                       //       child: Text(
//                                       //         "ESTIMATED COST*",
//                                       //         style: TextStyle(
//                                       //             fontSize: 16,
//                                       //             color: Color.fromARGB(
//                                       //                 255, 7, 59, 120),
//                                       //             fontWeight: FontWeight.bold),
//                                       //       ),
//                                       //     )),
//                                       // Align(
//                                       //   alignment: Alignment.centerRight,
//                                       //   child: Padding(
//                                       //     padding: const EdgeInsets.only(
//                                       //         right: 2.0,
//                                       //         top: 2,
//                                       //         bottom: 2,
//                                       //         left: 2),
//                                       //     child: TextFormField(
//                                       //       //  key: formkey5,
//                                       //       controller: _estimatedCost,
//                                       //       style: const TextStyle(
//                                       //           color: Color.fromARGB(
//                                       //               255, 7, 59, 120),
//                                       //           fontSize: 16),
//                                       //       obscureText: false,
//                                       //       keyboardType: TextInputType.number,
//                                       //       decoration: const InputDecoration(
//                                       //         border: OutlineInputBorder(),
//                                       //         enabledBorder: OutlineInputBorder(
//                                       //           borderSide: BorderSide(
//                                       //             color: Color.fromARGB(
//                                       //                 255, 7, 59, 120),
//                                       //           ),
//                                       //         ),
//                                       //         hintText: '',
//                                       //       ),
//                                       //       onChanged: (value) {},
//                                       //       validator: (value) {
//                                       //         if (value!.isEmpty) {
//                                       //           return "Please enter Estimated Cost";
//                                       //         } else {
//                                       //           return null;
//                                       //         }
//                                       //       },
//                                       //     ),
//                                       //   ),
//                                       // ),
                                     
                                     
//                                       const Align(
//                                           alignment: Alignment.centerLeft,
//                                           child: Padding(
//                                             padding: EdgeInsets.only(
//                                                 left: 2.0,
//                                                 right: 2.0,
//                                                 top: 8.0),
//                                             child: Text(
//                                               "ESTIMATED TIME*",
//                                               style: TextStyle(
//                                                   fontSize: 16,
//                                                   color: Color.fromARGB(
//                                                       255, 7, 59, 120),
//                                                   fontWeight: FontWeight.bold),
//                                             ),
//                                           )),
//                                       // Padding(
//                                       //   padding: const EdgeInsets.all(2.0),
//                                       //   child: InkWell(
//                                       //     onTap: () async {
//                                       //       await _selectTime(context);
//                                       //     },
//                                       //     child: Container(
//                                       //       decoration: BoxDecoration(
//                                       //         border: Border.all(
//                                       //           color: const Color.fromARGB(
//                                       //               255, 7, 59, 120),
//                                       //         ),
//                                       //       ),
//                                       //       child: Padding(
//                                       //         padding: const EdgeInsets.all(2.0),
//                                       //         child: Padding(
//                                       //           padding: const EdgeInsets.only(
//                                       //               left: 8.0),
//                                       //           child: Row(
//                                       //             children: [
//                                       //               Expanded(
//                                       //                 child: Row(
//                                       //                   children: [
//                                       //                     Padding(
//                                       //                       padding:
//                                       //                           const EdgeInsets
//                                       //                               .only(top: 2),
//                                       //                       child: IconButton(
//                                       //                         icon: const Icon(
//                                       //                             Icons
//                                       //                                 .lock_clock),
//                                       //                         iconSize: 40,
//                                       //                         color: const Color
//                                       //                             .fromARGB(255,
//                                       //                             7, 59, 120),
//                                       //                         onPressed:
//                                       //                             () async {
//                                       //                           await _selectTime(
//                                       //                               context);
//                                       //                         },
//                                       //                       ),
//                                       //                     ),
//                                       //                     Expanded(
//                                       //                       child: Padding(
//                                       //                         padding:
//                                       //                             const EdgeInsets
//                                       //                                 .only(
//                                       //                                 left: 2),
//                                       //                         child: Text(
//                                       //                             _selectedTime
//                                       //                                 .format(
//                                       //                                     context),
//                                       //                             style:
//                                       //                                 const TextStyle(
//                                       //                               fontSize: 16,
//                                       //                               color: Color
//                                       //                                   .fromARGB(
//                                       //                                       255,
//                                       //                                       7,
//                                       //                                       59,
//                                       //                                       120),
//                                       //                             )),
//                                       //                       ),
//                                       //                     ),
//                                       //                   ],
//                                       //                 ),
//                                       //               ),
//                                       //             ],
//                                       //           ),
//                                       //         ),
//                                       //       ),
//                                       //     ),
//                                       //   ),
//                                       // ),

//                                       Padding(
//                                         padding: const EdgeInsets.only(left: 2),
//                                         child: Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.spaceEvenly,
//                                           children: <Widget>[
//                                             Expanded(
//                                               flex: 3,
//                                               child: SizedBox(
//                                                 child: TextFormField(
//                                                   controller: _controllerTime,
//                                                   style: const TextStyle(
//                                                       color: Color.fromARGB(
//                                                           255, 7, 59, 120),
//                                                       fontSize: 16),
//                                                   obscureText: false,
//                                                   // keyboardType: TextInputType.number,
//                                                   decoration:
//                                                       const InputDecoration(
//                                                     border:
//                                                         OutlineInputBorder(),
//                                                     enabledBorder:
//                                                         OutlineInputBorder(
//                                                       borderSide: BorderSide(
//                                                         color: Color.fromARGB(
//                                                             255, 7, 59, 120),
//                                                       ),
//                                                     ),
//                                                     hintText: '',
//                                                   ),
//                                                   keyboardType:
//                                                       const TextInputType
//                                                           .numberWithOptions(
//                                                           decimal: true),
//                                                   onChanged: (value) {
//                                                     setState(() {
//                                                       _value = double.tryParse(
//                                                               value) ??
//                                                           0.1;
//                                                       _value = _value.clamp(0.1,
//                                                           100000000.0); // Clamping value between 0.1 and 10.0
//                                                     });
//                                                   },
//                                                 ),
//                                               ),
//                                             ),
//                                             Column(
//                                               children: [
//                                                 IconButton(
//                                                   icon: const Icon(
//                                                     Icons.arrow_drop_up,
//                                                     color: Color.fromARGB(
//                                                         255, 7, 59, 120),
//                                                   ),
//                                                   onPressed: _increment,
//                                                 ),
//                                                 IconButton(
//                                                   icon: const Icon(
//                                                     Icons.arrow_drop_down,
//                                                     color: Color.fromARGB(
//                                                         255, 7, 59, 120),
//                                                   ),
//                                                   onPressed: _decrement,
//                                                 ),
//                                               ],
//                                             ),
//                                           ],
//                                         ),
//                                       ),

//                                       // const Align(
//                                       //     alignment: Alignment.centerLeft,
//                                       //     child: Padding(
//                                       //       padding: EdgeInsets.only(
//                                       //           left: 2.0,
//                                       //           right: 2.0,
//                                       //           bottom: 2.0),
//                                       //       child: Text(
//                                       //         "ACTUAL COST",
//                                       //         style: TextStyle(
//                                       //             fontSize: 16,
//                                       //             color: Color.fromARGB(
//                                       //                 255, 7, 59, 120),
//                                       //             fontWeight: FontWeight.bold),
//                                       //       ),
//                                       //     )),
//                                       // Align(
//                                       //   alignment: Alignment.centerRight,
//                                       //   child: Padding(
//                                       //     padding: const EdgeInsets.only(
//                                       //         right: 2.0,
//                                       //         top: 2,
//                                       //         bottom: 2,
//                                       //         left: 2),
//                                       //     child: TextFormField(
//                                       //       //  key: formkey5,
//                                       //       controller: _actualCost,
//                                       //       style: const TextStyle(
//                                       //           color: Color.fromARGB(
//                                       //               255, 7, 59, 120),
//                                       //           fontSize: 16),
//                                       //       obscureText: false,
//                                       //       keyboardType: TextInputType.number,
//                                       //       decoration: const InputDecoration(
//                                       //         border: OutlineInputBorder(),
//                                       //         enabledBorder: OutlineInputBorder(
//                                       //           borderSide: BorderSide(
//                                       //             color: Color.fromARGB(
//                                       //                 255, 7, 59, 120),
//                                       //           ),
//                                       //         ),
//                                       //         hintText: '',
//                                       //       ),
//                                       //       onChanged: (value) {},
//                                       //       validator: (value) {
//                                       //         if (value!.isEmpty) {
//                                       //           return "Please enter Actual Cost";
//                                       //         } else {
//                                       //           return null;
//                                       //         }
//                                       //       },
//                                       //     ),
//                                       //   ),
//                                       // ),
                                     
                                     
//                                       // const Align(
//                                       //     alignment: Alignment.centerLeft,
//                                       //     child: Padding(
//                                       //       padding: EdgeInsets.only(
//                                       //           left: 2.0,
//                                       //           right: 2.0,
//                                       //           bottom: 2.0,
//                                       //           top: 8.0),
//                                       //       child: Text(
//                                       //         "UPLOAD (IMAGE, PDF)*",
//                                       //         style: TextStyle(
//                                       //             fontSize: 16,
//                                       //             color: Color.fromARGB(
//                                       //                 255, 7, 59, 120),
//                                       //             fontWeight: FontWeight.bold),
//                                       //       ),
//                                       //     )),
//                                       // Container(
//                                       //   margin: const EdgeInsets.only(
//                                       //       bottom: 10.0, top: 2),
//                                       //   padding: const EdgeInsets.all(8),
//                                       //   alignment: Alignment.center,
//                                       //   width: size.width * 1,
//                                       //   height: 50,
//                                       //   decoration: const BoxDecoration(
//                                       //       boxShadow: [
//                                       //         BoxShadow(
//                                       //             color: Color.fromARGB(
//                                       //                 255, 3, 47, 97),
//                                       //             blurRadius: 5,
//                                       //             offset: Offset(2.0, 5.0))
//                                       //       ],
//                                       //       color: Color.fromARGB(
//                                       //           255, 130, 193, 245),
//                                       //       gradient: LinearGradient(
//                                       //         colors: [
//                                       //           Colors.white,
//                                       //           Colors.white,
//                                       //         ],
//                                       //       )),
//                                       //   child: Row(
//                                       //     children: [
//                                       //       InkWell(
//                                       //           onTap: () {
//                                       //             _checkPermission(context);
//                                       //           },
//                                       //           child: const Text(
//                                       //             'Choose File',
//                                       //             style: TextStyle(
//                                       //               fontSize: 16,
//                                       //               color: Color.fromARGB(
//                                       //                   255, 7, 59, 120),
//                                       //               //fontWeight: FontWeight.bold
//                                       //             ),
//                                       //           )),
//                                       //       // Padding(
//                                       //       //   padding:
//                                       //       //       const EdgeInsets.only(left: 8.0),
//                                       //       //   child: Container(
//                                       //       //     width: 1,
//                                       //       //     height: 50,
//                                       //       //     color: Colors.black,
//                                       //       //   ),
//                                       //       // ),
//                                       //       // Expanded(
//                                       //       //   child: Padding(
//                                       //       //     padding: const EdgeInsets.only(
//                                       //       //         left: 8.0),
//                                       //       //     child: Text(
//                                       //       //       ((_imagePath.isEmpty) &&
//                                       //       //               (_imagePath2.isEmpty) &&
//                                       //       //               (_imagePath3.isEmpty))
//                                       //       //           ? 'No file selected'
//                                       //       //           : (_imagePath.isNotEmpty ||
//                                       //       //                   _imagePath2
//                                       //       //                       .isNotEmpty ||
//                                       //       //                   _imagePath3
//                                       //       //                       .isNotEmpty)
//                                       //       //               ? '3 files selected'
//                                       //       //               : (_imagePath
//                                       //       //                           .isNotEmpty ||
//                                       //       //                       _imagePath2
//                                       //       //                           .isEmpty ||
//                                       //       //                       _imagePath3
//                                       //       //                           .isEmpty)
//                                       //       //                   ? '1 file selected'
//                                       //       //                   : (_imagePath
//                                       //       //                               .isEmpty ||
//                                       //       //                           _imagePath2
//                                       //       //                               .isNotEmpty ||
//                                       //       //                           _imagePath3
//                                       //       //                               .isEmpty)
//                                       //       //                       ? '1 file selected'
//                                       //       //                       : (_imagePath
//                                       //       //                                   .isNotEmpty &&
//                                       //       //                               _imagePath2
//                                       //       //                                   .isEmpty &&
//                                       //       //                               _imagePath3
//                                       //       //                                   .isEmpty)
//                                       //       //                           ? '1 file selected'
//                                       //       //                           : (_imagePath
//                                       //       //                                       .isEmpty &&
//                                       //       //                                   _imagePath2
//                                       //       //                                       .isNotEmpty &&
//                                       //       //                                   _imagePath3
//                                       //       //                                       .isEmpty)
//                                       //       //                               ? '1 file selected'
//                                       //       //                               : (_imagePath.isEmpty &&
//                                       //       //                                       _imagePath2.isEmpty &&
//                                       //       //                                       _imagePath3.isNotEmpty)
//                                       //       //                                   ? '1 file selected'
//                                       //       //                                   : (_imagePath.isNotEmpty && _imagePath2.isNotEmpty && _imagePath3.isEmpty)
//                                       //       //                                       ? '2 files selected'
//                                       //       //                                       : (_imagePath.isNotEmpty && _imagePath2.isEmpty && _imagePath3.isNotEmpty)
//                                       //       //                                           ? '2 files selected'
//                                       //       //                                           : (_imagePath.isEmpty && _imagePath2.isNotEmpty && _imagePath3.isNotEmpty)
//                                       //       //                                               ? '2 files selected'
//                                       //       //                                               : 'No File selected',
//                                       //       //       style: const TextStyle(
//                                       //       //         fontSize: 16,
//                                       //       //         color: Color.fromARGB(
//                                       //       //             255, 7, 59, 120),
//                                       //       //       ),
//                                       //       //     ),
//                                       //       //   ),
//                                       //       // ),
//                                       //     ],
//                                       //   ),
//                                       // ),
//                                       // Row(
//                                       //   children: [
//                                       //     Expanded(
//                                       //       child: Visibility(
//                                       //         visible: _isVisibleImageDoc,
//                                       //         child: Stack(
//                                       //           children: [
//                                       //             if (_imagePath.isNotEmpty)
//                                       //               Center(
//                                       //                 child: Icon(
//                                       //                   getFileTypeIcon(
//                                       //                       _imagePath),
//                                       //                   size: 100,
//                                       //                 ),
//                                       //               ),
//                                       //             InkWell(
//                                       //               onTap: () async {
//                                       //                 setState(() {
//                                       //                   _isVisibleImageDoc =
//                                       //                       false;
//                                       //                 });
//                                       //                 deleteOnlineImageApi(
//                                       //                     _imagePath);
//                                       //               },
//                                       //               child: const Icon(
//                                       //                   Icons.delete,
//                                       //                   color: Colors.red,
//                                       //                   size: 50),
//                                       //             ),
//                                       //           ],
//                                       //         ),
//                                       //       ),
//                                       //     ),
//                                       //     Expanded(
//                                       //       child: Visibility(
//                                       //         visible: _isVisibleImage2Doc,
//                                       //         child: Stack(
//                                       //           children: [
//                                       //             if (_imagePath2.isNotEmpty)
//                                       //               Center(
//                                       //                 child: Icon(
//                                       //                   getFileTypeIcon(
//                                       //                       _imagePath2),
//                                       //                   size: 100,
//                                       //                 ),
//                                       //               ),
//                                       //             InkWell(
//                                       //               onTap: () {
//                                       //                 setState(() {
//                                       //                   _isVisibleImage2Doc =
//                                       //                       false;
//                                       //                 });
//                                       //                 deleteOnlineImageApi(
//                                       //                     _imagePath2);
//                                       //               },
//                                       //               child: const Icon(
//                                       //                   Icons.delete,
//                                       //                   color: Colors.red,
//                                       //                   size: 50),
//                                       //             ),
//                                       //           ],
//                                       //         ),
//                                       //       ),
//                                       //     ),
//                                       //     Expanded(
//                                       //       child: Visibility(
//                                       //         visible: _isVisibleImage3Doc,
//                                       //         child: Stack(
//                                       //           children: [
//                                       //             if (_imagePath3.isNotEmpty)
//                                       //               Center(
//                                       //                 child: Icon(
//                                       //                   getFileTypeIcon(
//                                       //                       _imagePath3),
//                                       //                   size: 100,
//                                       //                 ),
//                                       //               ),
//                                       //             InkWell(
//                                       //               onTap: () {
//                                       //                 setState(() {
//                                       //                   _isVisibleImage3Doc =
//                                       //                       false;
//                                       //                 });
//                                       //                 deleteOnlineImageApi(
//                                       //                     _imagePath3);
//                                       //               },
//                                       //               child: const Icon(
//                                       //                   Icons.delete,
//                                       //                   color: Colors.red,
//                                       //                   size: 50),
//                                       //             ),
//                                       //           ],
//                                       //         ),
//                                       //       ),
//                                       //     ),
//                                       //   ],
//                                       // ),

//                                       // Row(
//                                       //   children: [
//                                       //     Expanded(
//                                       //       child: Visibility(
//                                       //         visible: _isVisibleImage,
//                                       //         child: Stack(
//                                       //           children: [
//                                       //             if (_imagePath.isNotEmpty)
//                                       //               Image.file(
//                                       //                 File(_imagePath),
//                                       //                 height: 200,
//                                       //                 width: 200,
//                                       //                 fit: BoxFit.cover,
//                                       //               ),
//                                       //             InkWell(
//                                       //               onTap: () async {
//                                       //                 setState(() {
//                                       //                   _isVisibleImage = false;
//                                       //                 });
//                                       //                 deleteOnlineImageApi(
//                                       //                     deleteImage1);
//                                       //               },
//                                       //               child: const Icon(
//                                       //                   Icons.delete,
//                                       //                   color: Colors.red,
//                                       //                   size: 50),
//                                       //             ),
//                                       //           ],
//                                       //         ),
//                                       //       ),
//                                       //     ),
//                                       //     Expanded(
//                                       //       child: Visibility(
//                                       //         visible: _isVisibleImage2,
//                                       //         child: Stack(
//                                       //           children: [
//                                       //             if (_imagePath2.isNotEmpty)
//                                       //               Image.file(
//                                       //                 File(_imagePath),
//                                       //                 height: 200,
//                                       //                 width: 200,
//                                       //                 fit: BoxFit.cover,
//                                       //               ),
//                                       //             InkWell(
//                                       //               onTap: () {
//                                       //                 setState(() {
//                                       //                   _isVisibleImage2 = false;
//                                       //                 });
//                                       //                 deleteOnlineImageApi(
//                                       //                     deleteImage2);
//                                       //               },
//                                       //               child: const Icon(
//                                       //                   Icons.delete,
//                                       //                   color: Colors.red,
//                                       //                   size: 50),
//                                       //             ),
//                                       //           ],
//                                       //         ),
//                                       //       ),
//                                       //     ),
//                                       //     Expanded(
//                                       //       child: Visibility(
//                                       //         visible: _isVisibleImage3,
//                                       //         child: Stack(
//                                       //           children: [
//                                       //             if (_imagePath3.isNotEmpty)
//                                       //               Image.file(
//                                       //                 File(_imagePath3),
//                                       //                 height: 200,
//                                       //                 width: 200,
//                                       //                 fit: BoxFit.cover,
//                                       //               ),
//                                       //             InkWell(
//                                       //               onTap: () {
//                                       //                 setState(() {
//                                       //                   _isVisibleImage3 = false;
//                                       //                 });
//                                       //                 deleteOnlineImageApi(
//                                       //                     deleteImage3);
//                                       //               },
//                                       //               child: const Icon(
//                                       //                   Icons.delete,
//                                       //                   color: Colors.red,
//                                       //                   size: 50),
//                                       //             ),
//                                       //           ],
//                                       //         ),
//                                       //       ),
//                                       //     ),
//                                       //   ],
//                                       // ),

//                                       // Container(
//                                       //     margin: const EdgeInsets.only(
//                                       //         left: 6, right: 6, top: 8.0),
//                                       //     child: Padding(
//                                       //       padding: const EdgeInsets.only(
//                                       //           left: 2.0,
//                                       //           right: 2.0,
//                                       //           bottom: 2.0,
//                                       //           top: 2.0),
//                                       //       child: InkWell(
//                                       //         onTap: () async {
//                                       //           if (_formkey.currentState!
//                                       //               .validate()) {
//                                       //             // ***********get API**************//
//                                       //             // fetchData(
//                                       //             //   selectedSubstation,
//                                       //             //   '1',
//                                       //             //   'INSERT',
//                                       //             //   (selectedServiceStreet ==
//                                       //             //           'OTHER')
//                                       //             //       ? 'OTHER'
//                                       //             //       // _otherServiceStreetAddress
//                                       //             //       //     .text
//                                       //             //       //     .toString()
//                                       //             //       : selectedServiceStreet,
//                                       //             //   (selectedMapLocation ==
//                                       //             //           'OTHER')
//                                       //             //       ? 'OTHER'
//                                       //             //       // _otherServiceMapLocation
//                                       //             //       //     .text
//                                       //             //       //     .toString()
//                                       //             //       : selectedMapLocation,
//                                       //             // );

//                                       //             Map<String, dynamic> mapData = {
//                                       //               "county": '',
//                                       //               "substation": substationId,
//                                       //               "streetAddress":
//                                       //                   (selectedServiceStreet ==
//                                       //                           'OTHER')
//                                       //                       ? 'OTHER'
//                                       //                       // _otherServiceStreetAddress
//                                       //                       //     .text
//                                       //                       //     .toString()
//                                       //                       : selectedServiceStreet,
//                                       //               "mapLocation":
//                                       //                   (selectedMapLocation ==
//                                       //                           'OTHER')
//                                       //                       ? 'OTHER'
//                                       //                       // _otherServiceMapLocation
//                                       //                       //     .text
//                                       //                       //     .toString()
//                                       //                       : selectedMapLocation,
//                                       //               "changeOrderImage": '',
//                                       //               "adminNotes1":
//                                       //                   _notes.text.toString(),
//                                       //               "dateOfInspection": "N/A",
//                                       //               "type": 'Change Order',
//                                       //               "followUpDate": "N/A",
//                                       //               "maintType": maintenanceType,
//                                       //               // (maintenanceType == null)
//                                       //               //     ? ''
//                                       //               //     : maintenanceType,
//                                       //               "contractorCompay": 'LCP',
//                                       //               "contractor": assignFormanId,
//                                       //               "supervisor":
//                                       //                   (selectedAssignForman ==
//                                       //                           'Other')
//                                       //                       ? 'OTHER'
//                                       //                       // _otherAssignForeman
//                                       //                       //     .text
//                                       //                       //     .toString()
//                                       //                       : selectedAssignForman,
//                                       //               /////////////new added///////////
//                                       //               "tokenNo": widget.tokenNo,
//                                       //               // "",
//                                       //               //////////modified on 07/05/2024 ////////////
//                                       //               "estCost": _estimatedCost.text
//                                       //                   .toString(),
//                                       //               "estTime":
//                                       //                   _controllerTime.text,
//                                       //               // _selectedTime
//                                       //               //     .format(context),
//                                       //               "actualCost": _actualCost.text
//                                       //                   .toString(),
//                                       //               "feeder": selectedFeeder,
//                                       //               ///////////////////////////////
//                                       //               "actionNeeded":
//                                       //                   substationName,
//                                       //             };
//                                       //             createOrderApi(mapData);

//                                       //             // var response =
//                                       //             //     await lcpChangeOrderViewModel
//                                       //             //         .fetchLCPCreateOrderSubmitListApi(
//                                       //             //             context, mapData);
//                                       //             // print(response.toString());
//                                       //           } else {}
//                                       //         },
//                                       //         child: Container(
//                                       //           margin: const EdgeInsets.only(
//                                       //               left: 40,
//                                       //               right: 40,
//                                       //               bottom: 10.0),
//                                       //           padding: const EdgeInsets.all(8),
//                                       //           alignment: Alignment.center,
//                                       //           width: MediaQuery.of(context)
//                                       //               .size
//                                       //               .width,
//                                       //           height: 40,
//                                       //           decoration: const BoxDecoration(
//                                       //               // shape: BoxShape.circle,
//                                       //               // borderRadius:
//                                       //               //     BorderRadius.circular(25),
//                                       //               boxShadow: [
//                                       //                 BoxShadow(
//                                       //                     color: Color.fromARGB(
//                                       //                         255, 3, 47, 97),
//                                       //                     blurRadius: 5,
//                                       //                     offset:
//                                       //                         Offset(2.0, 5.0))
//                                       //               ],
//                                       //               color: Color.fromARGB(
//                                       //                   255, 130, 193, 245),
//                                       //               gradient: LinearGradient(
//                                       //                 colors: [
//                                       //                   Color.fromARGB(
//                                       //                       255, 7, 59, 120),
//                                       //                   Color.fromARGB(
//                                       //                       255, 7, 59, 120)
//                                       //                 ],
//                                       //               )),
//                                       //           child: const Row(children: [
//                                       //             Expanded(
//                                       //               child: Align(
//                                       //                 alignment: Alignment.center,
//                                       //                 child: Text(
//                                       //                   'Update Order',
//                                       //                   textAlign: TextAlign.left,
//                                       //                   style: TextStyle(
//                                       //                     color: Colors.white,
//                                       //                     fontWeight:
//                                       //                         FontWeight.bold,
//                                       //                     fontSize: 20,
//                                       //                   ),
//                                       //                 ),
//                                       //               ),
//                                       //             ),
//                                       //           ]),
//                                       //         ),
//                                       //       ),
//                                       //     )),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
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

//   // Future<void> _checkPermission(BuildContext context) async {
//   //   FocusScope.of(context).requestFocus(FocusNode());
//   //   Map<Permission, PermissionStatus> statues = await [
//   //     Permission.camera,
//   //     Permission.storage,
//   //     Permission.photos
//   //   ].request();
//   //   PermissionStatus? statusCamera = statues[Permission.camera];
//   //   PermissionStatus? statusStorage;
//   //   PermissionStatus? statusPhotos;
//   //   if (Platform.isAndroid) {
//   //     final androidInfo = await DeviceInfoPlugin().androidInfo;
//   //     if (androidInfo.version.sdkInt <= 32) {
//   //       statusStorage = statues[Permission.storage];

//   //       /// use [Permissions.storage.status]
//   //     } else {
//   //       statusPhotos = statues[Permission.photos];

//   //       /// use [Permissions.photos.status]
//   //     }
//   //   }

//   //   bool isGranted = statusCamera == PermissionStatus.granted &&
//   //           statusStorage == PermissionStatus.granted ||
//   //       statusCamera == PermissionStatus.granted &&
//   //           statusPhotos == PermissionStatus.granted;
//   //   if (isGranted) {
//   //     pickImageOptions();
//   //     // _pickImages();
//   //   }
//   //   bool isPermanentlyDenied =
//   //       statusCamera == PermissionStatus.permanentlyDenied ||
//   //           statusStorage == PermissionStatus.permanentlyDenied ||
//   //           statusPhotos == PermissionStatus.permanentlyDenied;
//   //   if (isPermanentlyDenied) {
//   //     // _showSettingsDialog(context);
//   //   }
//   // }

//   // Future<void> submitImage(String fileName, String tokenNo) async {
//   //   print('submit image api11111111111');
//   //   Directory tempDir = await getTemporaryDirectory();
//   //   print('submit image 22222222222222222');
//   //   String tempPath = tempDir.path;
//   //   try {
//   //     print('submit image 333333333333333333333');
//   //     var uri = Uri.parse(
//   //         "https://civm2.ariespro.com/civm2/contractorPanel/updateImageVEGETATION_CREW_FORMs");
//   //     var request = http.MultipartRequest("POST", uri);
//   //     final userPreferences = Provider.of<UserPref>(context, listen: false);
//   //     UserModel data = await userPreferences.getUser();
//   //     print('submit image 4444444444444444444');
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
//   //       print('submit image 4555555555555555555555');
//   //       File img1 = new File(_imagePath);
//   //       File file = await img1.copy(
//   //           '${tempPath}/img_${DateFormat('yyyyMMddHHmmss').format(DateTime.now())}${_imagePath.contains('.pdf') ? '.pdf' : '.jpg'}');
//   //       print('submit image 666666666666666');
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
//   //       print('image successfully uploaded...........');
//   //       print(response.body);
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
//   //       Navigator.of(context).push(MaterialPageRoute(
//   //           builder: (BuildContext context) => LCPTotalOrderPending(
//   //               budgetType: '',
//   //               maintenanceType: 'Change Order',
//   //               heading: 'Chanhe Order')));
//   //     }
//   //   } catch (e) {
//   //     print('inside catch of image upload api.................');
//   //   }
//   //   _isVisibleImage = true;
//   // }

//   // Future<void> deleteOnlineImageApi(String fileName) async {
//   //   final apiUrl =
//   //       'http://civmapi.ariespro.com/civmapi/changeOrderLcpCreateOrder/deleteFile?fileName=$fileName';
//   //   final userPreferences = Provider.of<UserPref>(context, listen: false);
//   //   UserModel data = await userPreferences.getUser();

//   //   try {
//   //     final response = await http.delete(
//   //       Uri.parse(apiUrl),
//   //       headers: {"Authorization": 'Bearer ${data.token!}'},
//   //     );

//   //     if (response.statusCode == 200) {
//   //       setState(() {});
//   //     } else {}
//   //   } catch (e) {}
//   // }

//   // DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
//   //     value: item,
//   //     child: Text(item,
//   //         style: const TextStyle(
//   //           fontWeight: FontWeight.normal,
//   //           fontSize: 20,
//   //         )));

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

//   // Future pickImageOptions() => showDialog(
//   //     context: context,
//   //     builder: (context) {
//   //       return StatefulBuilder(builder: (context, setState) {
//   //         return AlertDialog(
//   //           content: const SingleChildScrollView(
//   //             child: Column(
//   //               children: [
//   //                 Text(
//   //                   "Select image from",
//   //                   textAlign: TextAlign.left,
//   //                   style: TextStyle(
//   //                     color: Color.fromARGB(255, 7, 59, 120),
//   //                     fontWeight: FontWeight.bold,
//   //                     fontSize: 20,
//   //                   ),
//   //                 ),
//   //               ],
//   //             ),
//   //           ),
//   //           actions: [
//   //             Align(
//   //               alignment: Alignment.center,
//   //               child: Column(
//   //                 children: [
//   //                   InkWell(
//   //                     onTap: () {
//   //                       _pickImagesCamera();
//   //                       Navigator.pop(context);
//   //                     },
//   //                     child: Container(
//   //                       margin: const EdgeInsets.only(
//   //                           left: 4, right: 4, bottom: 10.0),
//   //                       // padding: const EdgeInsets.all(8),
//   //                       alignment: Alignment.center,
//   //                       width: MediaQuery.of(context).size.width,
//   //                       height: 40,
//   //                       decoration: const BoxDecoration(
//   //                           // shape: BoxShape.circle,
//   //                           // borderRadius: BorderRadius.circular(25),
//   //                           boxShadow: [
//   //                             BoxShadow(
//   //                                 color: Color.fromARGB(255, 112, 68, 1),
//   //                                 blurRadius: 5,
//   //                                 offset: Offset(2.0, 5.0))
//   //                           ],
//   //                           color: Colors.black,
//   //                           gradient: LinearGradient(
//   //                             colors: [
//   //                               Colors.orange,
//   //                               Colors.orange,
//   //                             ],
//   //                           )),
//   //                       child: const Align(
//   //                         alignment: Alignment.center,
//   //                         child: Text(
//   //                           "Camera",
//   //                           textAlign: TextAlign.left,
//   //                           style: TextStyle(
//   //                             color: Colors.white,
//   //                             fontWeight: FontWeight.bold,
//   //                             fontSize: 20,
//   //                           ),
//   //                         ),
//   //                       ),
//   //                     ),
//   //                   ),
//   //                   InkWell(
//   //                     onTap: () {
//   //                       _pickImagesGallery();
//   //                       // _pickImagesAndDocuments();
//   //                       Navigator.pop(context);
//   //                     },
//   //                     child: Container(
//   //                       margin: const EdgeInsets.only(
//   //                           left: 4, right: 4, bottom: 10.0),
//   //                       // padding: const EdgeInsets.all(8),
//   //                       alignment: Alignment.center,
//   //                       width: MediaQuery.of(context).size.width,
//   //                       height: 40,
//   //                       decoration: const BoxDecoration(
//   //                           // shape: BoxShape.circle,
//   //                           // borderRadius: BorderRadius.circular(25),
//   //                           boxShadow: [
//   //                             BoxShadow(
//   //                                 color: Color.fromARGB(255, 112, 68, 1),
//   //                                 blurRadius: 5,
//   //                                 offset: Offset(2.0, 5.0))
//   //                           ],
//   //                           color: Colors.black,
//   //                           gradient: LinearGradient(
//   //                             colors: [
//   //                               Colors.orange,
//   //                               Colors.orange,
//   //                             ],
//   //                           )),
//   //                       child: const Align(
//   //                         alignment: Alignment.center,
//   //                         child: Text(
//   //                           "Gallery",
//   //                           textAlign: TextAlign.left,
//   //                           style: TextStyle(
//   //                             color: Colors.white,
//   //                             fontWeight: FontWeight.bold,
//   //                             fontSize: 20,
//   //                           ),
//   //                         ),
//   //                       ),
//   //                     ),
//   //                   ),
//   //                   InkWell(
//   //                     onTap: () {
//   //                       _uploadDocuments();
//   //                       Navigator.pop(context);
//   //                     },
//   //                     child: Container(
//   //                       margin: const EdgeInsets.only(
//   //                           left: 4, right: 4, bottom: 10.0),
//   //                       // padding: const EdgeInsets.all(8),
//   //                       alignment: Alignment.center,
//   //                       width: MediaQuery.of(context).size.width,
//   //                       height: 40,
//   //                       decoration: const BoxDecoration(
//   //                           // shape: BoxShape.circle,
//   //                           // borderRadius: BorderRadius.circular(25),
//   //                           boxShadow: [
//   //                             BoxShadow(
//   //                                 color: Color.fromARGB(255, 112, 68, 1),
//   //                                 blurRadius: 5,
//   //                                 offset: Offset(2.0, 5.0))
//   //                           ],
//   //                           color: Colors.black,
//   //                           gradient: LinearGradient(
//   //                             colors: [
//   //                               Colors.orange,
//   //                               Colors.orange,
//   //                             ],
//   //                           )),
//   //                       child: const Align(
//   //                         alignment: Alignment.center,
//   //                         child: Text(
//   //                           "Document",
//   //                           textAlign: TextAlign.left,
//   //                           style: TextStyle(
//   //                             color: Colors.white,
//   //                             fontWeight: FontWeight.bold,
//   //                             fontSize: 20,
//   //                           ),
//   //                         ),
//   //                       ),
//   //                     ),
//   //                   ),
//   //                 ],
//   //               ),
//   //             ),
//   //           ],
//   //         );
//   //       });
//   //     });

//   void _setData() {
//     print('widget.type ${widget.type}');
//     print('widget.maintType ${widget.maintType}');

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

//   // Future<void> createOrderApi(Map<String, dynamic> mappedData) async {
//   //   String apiUrl =
//   //       'http://civmapi.ariespro.com/civmapi/changeOrderLcpCreateOrder/SP_INSERT_SM_MAINT_TEST_RESULT_REQUEST';

//   //   final userPreferences = Provider.of<UserPref>(context, listen: false);
//   //   UserModel data = await userPreferences.getUser();
//   //   try {
//   //     final response = await http.post(
//   //       Uri.parse(apiUrl),
//   //       headers: {
//   //         'Content-Type': 'application/json',
//   //         'Authorization': 'Bearer ${data.token}',
//   //       },
//   //       body: jsonEncode(mappedData),
//   //     );

//   //     if (response.statusCode == 200) {
//   //       CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
//   //           'Successfully Created', context);
//   //       Future.delayed(const Duration(seconds: 2), () {
//   //         setState(() {
//   //           _notes.clear();
//   //           selectedSubstation = null;
//   //           selectedServiceStreet = null;
//   //           selectedMapLocation = null;
//   //           maintenanceType = null;
//   //           selectedAssignForman = null;
//   //           _imagePath = '';
//   //           _imagePath2 = '';
//   //           _imagePath3 = '';
//   //           _isVisibleImage = false;
//   //           _isVisibleImage2 = false;
//   //           _isVisibleImage3 = false;
//   //           _estimatedCost.clear();
//   //           _actualCost.clear();
//   //         });
//   //       });

//   //       // if (_imagePath != '') {
//   //       //   Map<String, dynamic> jsonResponse = json.decode(response.body);
//   //       //   if (jsonResponse['message'] == 'Successfully created') {
//   //       //     submitImage(_imagePath, jsonResponse['tokenNo']);
//   //       //   }
//   //       // }
//   //       // Navigator.of(context).push(MaterialPageRoute(
//   //       //     builder: (BuildContext context) => const LCPTotalOrderPending()));
//   //       if (_imagePath != '') {
//   //         print('image path $_imagePath');
//   //         Map<String, dynamic> jsonResponse = json.decode(response.body);
//   //         print('jsonResponse: $jsonResponse');
//   //         print('jsonResponse[message]: ${jsonResponse['message']}');
//   //         if (jsonResponse['message'] == 'Successfully created') {
//   //           print('tokenNo111111 ${jsonResponse['tokenNo']}');
//   //           print('00000000000000000000000000000000000000000');
//   //           print(_imagePath);
//   //           submitImage(_imagePath, jsonResponse['tokenNo']);
//   //           // submitImage(_imagePath, jsonResponse['tokenNo']);
//   //           print('1111111111111111111111111');
//   //         }
//   //       } else {
//   //         Navigator.of(context).push(MaterialPageRoute(
//   //             builder: (BuildContext context) => LCPTotalOrderPending(
//   //                 budgetType: '',
//   //                 maintenanceType: 'Change Order',
//   //                 heading: 'Chanhe Order')));
//   //       }
//   //     } else {}
//   //   } catch (error) {}
//   // }

//   void getData() {
//     _otherServiceStreetAddress.text = widget.serviceStreetAddress;
//     _otherServiceMapLocation.text = widget.serviceMapLocation;
//     _notes.text = widget.notes;
//     _otherAssignForeman.text = widget.assignForeman;
//     _contratorComapny.text = widget.contractorCompany;
//     _actualCost.text = widget.actualCost;
//     _estimatedCost.text = widget.estimatedCost;
//     // _selectedTime =
//     //     (widget.estimatedTime == '' || widget.estimatedTime == 'null')
//     //         ? TimeOfDay.now()
//     //         : _parseEstimatedTime(widget.estimatedTime);
//     _controllerTime.text =
//         (widget.estimatedTime == '' || widget.estimatedTime == 'null')
//             ? '0.1'
//             : widget.estimatedTime.toString();
//   }

//   // TimeOfDay _parseEstimatedTime(String timeString) {
//   //   if (timeString.isEmpty || timeString.trim() == '') {
//   //     return TimeOfDay.now();
//   //   }
//   //   String timePart = timeString.split(',')[0];
//   //   List<String> timeParts = timePart.split(':');
//   //   if (timeParts.length != 2) {
//   //     return TimeOfDay.now();
//   //   }
//   //   int hour = int.tryParse(timeParts[0]) ?? 0;
//   //   int minute = int.tryParse(timeParts[1].split(' ')[0]) ?? 0;
//   //   String period = timeParts[1].split(' ')[1]; // AM or PM
//   //   if (period == 'PM' && hour < 12) {
//   //     hour += 12; // Adjust for PM time
//   //   } else if (period == 'AM' && hour == 12) {
//   //     hour = 0; // Handle 12 AM (midnight)
//   //   }
//   //   return TimeOfDay(hour: hour, minute: minute);
//   // }

//   void _increment() {
//     setState(() {
//       _value = (_value + 0.1)
//           .clamp(0.1, 100000.0); // Clamping value between 0.1 and 10.0
//       _controllerTime.text = _value.toStringAsFixed(1); // Update text field
//     });
//   }

//   void _decrement() {
//     setState(() {
//       _value = (_value - 0.1)
//           .clamp(0.1, 100000000000.0); // Clamping value between 0.1 and 10.0
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

//   // Future<void> _uploadDocuments() async {
//   //   print('document upload');

//   //   const XTypeGroup typeGroup = XTypeGroup(
//   //     label: 'documents',
//   //     extensions: ['pdf', 'doc', 'docx'],
//   //   );

//   //   try {
//   //     final List<XFile> documentResult = await openFiles(
//   //       acceptedTypeGroups: [typeGroup],
//   //     );

//   //     if (documentResult.isNotEmpty) {
//   //       List<String> chosenDocumentPaths = [];

//   //       for (int i = 0; i < documentResult.length; i++) {
//   //         if (chosenDocumentPaths.length < 3) {
//   //           chosenDocumentPaths.add(documentResult[i].path);
//   //         } else {
//   //           CustomToastSnackBarProgressDialog.toastMessage(
//   //             'You can select a maximum of 3 documents!',
//   //           );
//   //           return;
//   //         }
//   //       }
//   //       setState(() {
//   //         for (int i = 0; i < chosenDocumentPaths.length; i++) {
//   //           if (_imagePath.isEmpty) {
//   //             _imagePath = chosenDocumentPaths[i];
//   //             setState(() {
//   //               _isVisibleImageDoc = true;
//   //             });
//   //           } else if (_imagePath2.isEmpty) {
//   //             _imagePath2 = chosenDocumentPaths[i];
//   //             setState(() {
//   //               _isVisibleImage2Doc = true;
//   //             });
//   //           } else if (_imagePath3.isEmpty) {
//   //             _imagePath3 = chosenDocumentPaths[i];
//   //             setState(() {
//   //               _isVisibleImage3Doc = true;
//   //             });
//   //           } else {
//   //             CustomToastSnackBarProgressDialog.toastMessage(
//   //               'You can select a maximum of 3 documents!',
//   //             );
//   //             break;
//   //           }
//   //         }
//   //       });
//   //     } else {
//   //       CustomToastSnackBarProgressDialog.toastMessage(
//   //         'Please select at least one document.',
//   //       );
//   //     }
//   //   } catch (e) {
//   //     print('Error occurred while picking documents: $e');
//   //     CustomToastSnackBarProgressDialog.toastMessage(
//   //       'Error occurred while picking documents: $e',
//   //     );
//   //   }
//   // }

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
//         Future.delayed(const Duration(seconds: 6), () {
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
//                     Future.delayed(const Duration(seconds: 5), () {
//                       serviceStreetFlag = 1;
//                     });
//                   }
//                   Future.delayed(const Duration(seconds: 7), () {
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
// }
