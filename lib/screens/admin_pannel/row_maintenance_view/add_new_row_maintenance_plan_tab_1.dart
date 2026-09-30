import 'dart:convert';
import 'dart:io';
import 'package:CIVM/screens/admin_pannel/row_maintenance_view/admin_change_order_all_status.dart';
import 'package:CIVM/screens/admin_pannel/row_maintenance_view/user_management_tabs.dart';
import 'package:CIVM/utils/common_functions.dart';
import 'package:CIVM/models/add_new_row_maintenance_plan_model.dart';
import 'package:CIVM/models/user_model.dart';
import 'package:CIVM/screens/admin_pannel/row_maintenance_view/add_new_row_table.dart';
import 'package:CIVM/screens/admin_pannel/row_maintenance_view/admin_pannel.dart';
import 'package:CIVM/screens/leaflat_map/leaf_lat_map_wakeLock.dart';
import 'package:CIVM/screens/map/provider/location_provider.dart';
import 'package:CIVM/utils/user_pref.dart';
import 'package:device_info_plus/device_info_plus.dart';
// import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import '../../../data/response/status.dart';
import '../../../utils/custom_toast_snackbar_progressdialog.dart';
import '../../../view_model/add_new_row_maintenance_plan_view_model.dart';
import '../../login_page.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:file_selector/file_selector.dart';

// ignore: must_be_immutable
class AddNewRowMaintenancePlanTab1 extends StatefulWidget {
  String tokenNo;
  String index;
  String subStation;
  String feeder;
  String nextMaintYear;
  String maintType;
  String totalMiles;
  String costPerMile;
  String totalCost;
  dynamic budgetType;
  String contractRowYear;
  String rowCycle;
  String rowYear;
  String contractorCompany;
  dynamic assignForeman;
  AddNewRowMaintenancePlanTab1({
    Key? key,
    required this.tokenNo,
    required this.index,
    required this.subStation,
    required this.feeder,
    required this.nextMaintYear,
    required this.maintType,
    required this.totalMiles,
    required this.costPerMile,
    required this.totalCost,
    required this.budgetType,
    required this.contractRowYear,
    required this.rowCycle,
    required this.rowYear,
    required this.contractorCompany,
    required this.assignForeman,
  }) : super(key: key);

  @override
  State<AddNewRowMaintenancePlanTab1> createState() =>
      _AddNewRowMaintenancePlanTab1State();
}

class _AddNewRowMaintenancePlanTab1State
    extends State<AddNewRowMaintenancePlanTab1> {
  // int _currentIndex = 0;
  // final List<Widget> _children = [
  //   RowMaintenancePlan(),
  //   // BottomNavigationHomePage(),
  //   // BottomNavigationAccountPage()
  // ];
  List<String> menu = [];

  List<Map<String, dynamic>> listOfColumns = [];
  List<Map<String, dynamic>> listOfColumns1 = [];
  DateTime currentDate = DateTime.now();
  var result = [];

  int feederId = 0;
  int substationId = 0;
  int assignFormanId = 0;
  String supervisorId = '';
  String supervisorIdGlobal = '';

  String feederName = '';
  String substationName = '';
  int loadingIndex = 0;
  bool _isVisibleAssignForeman = true;

  // ignore: prefer_typing_uninitialized_variables
  var deleteImage1;
  // ignore: prefer_typing_uninitialized_variables
  var deleteImage2;
  // ignore: prefer_typing_uninitialized_variables
  var deleteImage3;

  File? image1;
  File? image2;
  File? image3;
  String _imagePath = '';
  String _imagePath2 = '';
  String _imagePath3 = '';
  File? image;

  bool _isVisibleImage = false;
  bool _isVisibleImage2 = false;
  bool _isVisibleImage3 = false;

  bool _isVisibleImageDoc = false;
  bool _isVisibleImage2Doc = false;
  bool _isVisibleImage3Doc = false;

  // ignore: non_constant_identifier_names
  // final select_Month = [
  //   'Jan',
  //   'Feb',
  //   'Mar',
  //   'Apr',
  //   'May',
  //   'Jun',
  //   'Jul',
  //   'Aug',
  //   'Sep',
  //   'Oct',
  //   'Nov',
  //   'Dec'
  // ];
  // String? month;
  // int monthNumber = 0;

  final TextEditingController _totalMiles = TextEditingController();
  final TextEditingController _costPerMile = TextEditingController();
  final TextEditingController _totalCost = TextEditingController();
  // final TextEditingController _budget = TextEditingController();
  late final TextEditingController _contractRowYear = TextEditingController();
  // final TextEditingController _contractEndYear = TextEditingController();
  final TextEditingController _rowCycle = TextEditingController();
  final TextEditingController _assignOtherForeman = TextEditingController();
  // final TextEditingController _nextMaintYear = TextEditingController();
  final TextEditingController _rowYear = TextEditingController();

  bool _isVisibleAssignOtherForeman = false;

  String name1 = '';

  // ignore: non_constant_identifier_names
  final select_contractorCompany = [
    // 'LCP',
    'ZIELIES',
  ];

  // ignore: non_constant_identifier_names
  final select_budgetType = [
    'Regular IVM maintenance',
    // 'Mid Cycle maintenance'
  ];
  var budgetType;

  String a = '';

  final _formkey = GlobalKey<FormState>();
  List countyList = [];
  List substationList = [];
  List feederList = [];
  // // ignore: non_constant_identifier_names
  // List<String> select_year = [
  //   '2021',
  //   '2022',
  //   '2023',
  //   '2024',
  //   '2025',
  //   '2026',
  //   '2027'
  // ];
  // String? year;
  // ignore: prefer_typing_uninitialized_variables
  String? contractorCompany;
  // ignore: prefer_typing_uninitialized_variables
  var selectedSubstation;
  // ignore: prefer_typing_uninitialized_variables
  var selectedFeeder;
  // ignore: prefer_typing_uninitialized_variables
  var selectedAssignForman;

  // ignore: prefer_typing_uninitialized_variables
  var selectedyear;

  // ignore: non_constant_identifier_names
  List<String> select_maintenanceType = [
    // 'JARAFF,MOWING,SPRAY WORK',
    // 'JARAFF,MOWING,NO SPRAY',
    // 'MOWING,NO SPRAY',
    // 'MOWING',
    // // 'SPRAY',
    // 'BUCKET WORK',
    // 'GROUND WORK'
    'JARRAFF',
    'MOWING',
    'MINI JARRAFF',
    'BYL',
    'BUCKET',
    'GROUND',
    'CROSS-COUNTRY SPRAY',
    'ROADSIDE SPRAY',
    'NO SPRAY',
  ];
  String? maintenanceType = 'JARRAFF';

  List<String> types = ['JARRAFF'];

  onTappedBar(int index) {
    setState(() {
      // _currentIndex = index;
    });
  }

  String now = DateFormat("yyyy-MM-dd hh:mm:ss").format(DateTime.now());

  AddNewRowMaintenancePlanViewModel addNewRowMaintenancePlanViewModel =
      AddNewRowMaintenancePlanViewModel();

  DateTime date20 = DateTime.now();
  late String dateSelected20 = DateFormat('yyyy-MM-dd').format(date20);
  String dynamicYear = '';
  String? year;
  List<String> select_year = generateYearList();

  @override
  void initState() {
    print('widget.tokenNo ${widget.tokenNo}');
    addNewRowMaintenancePlanViewModel.fetchAddNewRowMaintenancePlanViewListApi(
      context,
      '0',
      'Get',
      '',
      '',
      '',
      '',
      '',
      '',
      '',
    );

    super.initState();
    _contractRowYear.text = DateFormat("yyyy").format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // appBar: AppBar(
      //   iconTheme: const IconThemeData(color: Colors.white),
      //   title: const Text(
      //     'Add New Row Maintenance Plan',
      //     style: TextStyle(
      //       color: Colors.white,
      //     ),
      //   ),
      //   backgroundColor: const Color.fromARGB(255, 7, 59, 120),
      //   actions: [
      //     IconButton(
      //       icon: const Icon(
      //         Icons.table_chart_outlined,
      //         color: Colors.white,
      //       ),
      //       onPressed: () {
      //         Navigator.of(context).push(MaterialPageRoute(
      //             builder: (BuildContext context) =>
      //                 const AddNewRowMaintenancePlanTable()));
      //       },
      //     ),
      //   ],
      // ),

      // drawer: DrawerManu(
      //   menu: menu,
      // ),
      body: ChangeNotifierProvider<AddNewRowMaintenancePlanViewModel>(
        create: (BuildContext context) => addNewRowMaintenancePlanViewModel,
        child: Consumer<AddNewRowMaintenancePlanViewModel>(
          builder: (context, value, _) {
            switch (value.addNewRowMaintenancePlanList.status) {
              case Status.LOADING:
                return const Center(child: CircularProgressIndicator());
              case Status.ERROR:
                return Padding(
                  padding: const EdgeInsets.only(
                    top: 16.0,
                    bottom: 16,
                    left: 8,
                    right: 8,
                  ),
                  child: Center(
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/empty_box.png',
                            height: 200,
                            width: 200,
                            fit: BoxFit.cover,
                          ),
                          const Center(
                            child: Text(
                              'Sorry, Data Not Found!',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Color.fromARGB(255, 7, 59, 120),
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );

              //  CustomToastSnackBarProgressDialog.flushBarErrorMessage(
              //     value.addNewRowMaintenancePlanList.message.toString(),
              //     context);

              case Status.COMPLETED:
                if (loadingIndex == 0) {
                  getData();
                  // getMonthFromNextMaintDue(widget.tokenNo);
                  loadingIndex = 1;
                }
                return SingleChildScrollView(
                  child: DefaultTabController(
                    length: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(
                              left: 8,
                              right: 8,
                              top: 10,
                              bottom: 8,
                            ),
                            padding: const EdgeInsets.all(8),
                            alignment: Alignment.center,
                            // height: size.height * 0.5,
                            width: size.width * 0.99,
                            decoration: const BoxDecoration(
                              // shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromARGB(255, 7, 59, 120),
                                  blurRadius: 10,
                                  offset: Offset(2.0, 5.0),
                                ),
                              ],
                              gradient: LinearGradient(
                                colors: [
                                  Color.fromARGB(255, 255, 255, 255),
                                  Color.fromARGB(255, 255, 255, 255),
                                ],
                              ),
                            ),
                            child: Form(
                              key: _formkey,
                              child: Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    alignment: Alignment.center,
                                    width: size.width * 0.99,
                                    // width: MediaQuery.of(context).size.width,
                                    height: 50,
                                    decoration: const BoxDecoration(
                                      // shape: BoxShape.circle,
                                      //borderRadius: BorderRadius.circular(25),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color.fromARGB(255, 3, 47, 97),
                                          blurRadius: 5,
                                          offset: Offset(2.0, 5.0),
                                        ),
                                      ],
                                      color: Color.fromARGB(255, 130, 193, 245),
                                      gradient: LinearGradient(
                                        colors: [
                                          Color.fromARGB(255, 7, 59, 120),
                                          Color.fromARGB(255, 7, 59, 120),
                                        ],
                                      ),
                                    ),
                                    child: const Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "IVM MAINTENANCE PLAN",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 2.0,
                                      right: 2.0,
                                      bottom: 2.0,
                                      top: 10.0,
                                    ),
                                    child: Row(
                                      children: [
                                        const Expanded(
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "NEXT MAINT YEAR*",
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Color.fromARGB(
                                                  255,
                                                  7,
                                                  59,
                                                  120,
                                                ),
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),

                                        // Expanded(
                                        //   child: Align(
                                        //     alignment: Alignment.centerLeft,
                                        //     child: Padding(
                                        //       padding:
                                        //           const EdgeInsets.all(2.0),
                                        //       child: DropdownButtonFormField<
                                        //           String>(
                                        //         hint: const Text('-Select-'),
                                        //         dropdownColor: Colors.white,
                                        //         value: year,
                                        //         style: const TextStyle(
                                        //           color: Color.fromARGB(
                                        //               255, 7, 59, 120),
                                        //           fontSize: 16,
                                        //         ),
                                        //         icon: const Icon(
                                        //           Icons.arrow_drop_down,
                                        //           color: Color.fromARGB(
                                        //               255, 7, 59, 120),
                                        //           size: 40,
                                        //         ),
                                        //         decoration:
                                        //             const InputDecoration(
                                        //           enabledBorder:
                                        //               OutlineInputBorder(
                                        //             borderSide: BorderSide(
                                        //               color: Color.fromARGB(
                                        //                   255, 7, 59, 120),
                                        //             ),
                                        //           ),
                                        //           focusedBorder:
                                        //               OutlineInputBorder(
                                        //             borderSide: BorderSide(
                                        //               color: Color.fromARGB(
                                        //                   255, 7, 59, 120),
                                        //             ),
                                        //           ),
                                        //         ),
                                        //         isExpanded: true,
                                        //         items: select_year
                                        //             .map(buildMenuItem)
                                        //             .toList(),
                                        //         onChanged: (String? newValue) {
                                        //           setState(() {
                                        //             year = newValue;
                                        //           });
                                        //           dynamicYear = year.toString();
                                        //           setCycleAndYear(
                                        //               year.toString());
                                        //         },
                                        //         validator: (value) =>
                                        //             value == null
                                        //                 ? 'Field required'
                                        //                 : null,
                                        //       ),
                                        //     ),
                                        //   ),
                                        // )
                                        Expanded(
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Padding(
                                              padding: const EdgeInsets.all(
                                                2.0,
                                              ),
                                              child: DropdownButtonFormField<String>(
                                                hint: const Text('-Select-'),
                                                dropdownColor: Colors.white,
                                                value: selectedyear,
                                                style: const TextStyle(
                                                  color: Color.fromARGB(
                                                    255,
                                                    7,
                                                    59,
                                                    120,
                                                  ),
                                                  fontSize: 16,
                                                ),
                                                icon: const Icon(
                                                  Icons.arrow_drop_down,
                                                  color: Color.fromARGB(
                                                    255,
                                                    7,
                                                    59,
                                                    120,
                                                  ),
                                                  size: 40,
                                                ),
                                                decoration: const InputDecoration(
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Color.fromARGB(
                                                            255,
                                                            7,
                                                            59,
                                                            120,
                                                          ),
                                                        ),
                                                      ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Color.fromARGB(
                                                            255,
                                                            7,
                                                            59,
                                                            120,
                                                          ),
                                                        ),
                                                      ),
                                                ),
                                                isExpanded: true,
                                                items: addNewRowMaintenancePlanViewModel
                                                    .addNewRowMaintenancePlanList
                                                    .data!
                                                    .yearList!
                                                    .map((e) {
                                                      return DropdownMenuItem(
                                                        value: e.year
                                                            .toString(),
                                                        // e.getIdAndSubstationByCountId![0].subStation.toString(),
                                                        child: Text(
                                                          e.year.toString(),
                                                        ),
                                                      );
                                                    })
                                                    .toList(),
                                                onChanged: (val) async {
                                                  if (selectedFeeder != null ||
                                                      selectedSubstation !=
                                                          null) {
                                                    selectedFeeder = null;
                                                    selectedSubstation = null;
                                                  }

                                                  selectedyear = val;
                                                  fetchData(
                                                    '',
                                                    'Get',
                                                    '',
                                                    '',
                                                    '',
                                                    '',
                                                    val.toString(),
                                                    '',
                                                    '',
                                                  );
                                                  setCycleAndYear(selectedyear);
                                                  dynamicYear = val.toString();
                                                },
                                                validator: (value) =>
                                                    value == null
                                                    ? 'field required'
                                                    : null,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  //---month dropdown field-----
                                  // Padding(
                                  //   padding: const EdgeInsets.only(
                                  //       left: 2.0,
                                  //       right: 2.0,
                                  //       bottom: 2.0,
                                  //       top: 10.0),
                                  //   child: Row(
                                  //     children: [
                                  //       const Expanded(
                                  //         child: Align(
                                  //             alignment: Alignment.centerLeft,
                                  //             child: Text(
                                  //               "MONTH",
                                  //               style: TextStyle(
                                  //                   fontSize: 16,
                                  //                   color: Color.fromARGB(
                                  //                       255, 7, 59, 120),
                                  //                   fontWeight:
                                  //                       FontWeight.bold),
                                  //             )),
                                  //       ),
                                  //       Expanded(
                                  //         child: Align(
                                  //           alignment: Alignment.centerLeft,
                                  //           child: Padding(
                                  //             padding:
                                  //                 const EdgeInsets.all(2.0),
                                  //             child: DropdownButtonFormField<
                                  //                 String>(
                                  //               hint: const Text('-Select-'),
                                  //               dropdownColor: Colors.white,
                                  //               value: month,
                                  //               style: const TextStyle(
                                  //                   color: Color.fromARGB(
                                  //                       255, 7, 59, 120),
                                  //                   fontSize: 16),
                                  //               icon: const Icon(
                                  //                 Icons.arrow_drop_down,
                                  //                 color: Color.fromARGB(
                                  //                     255, 7, 59, 120),
                                  //                 size: 40,
                                  //               ),
                                  //               decoration:
                                  //                   const InputDecoration(
                                  //                 enabledBorder:
                                  //                     OutlineInputBorder(
                                  //                   borderSide: BorderSide(
                                  //                     color: Color.fromARGB(
                                  //                         255, 7, 59, 120),
                                  //                   ),
                                  //                 ),
                                  //                 focusedBorder:
                                  //                     OutlineInputBorder(
                                  //                   borderSide: BorderSide(
                                  //                     color: Color.fromARGB(
                                  //                         255, 7, 59, 120),
                                  //                   ),
                                  //                 ),
                                  //               ),
                                  //               isExpanded: true,
                                  //               items: select_Month
                                  //                   .map(buildMenuItem)
                                  //                   .toList(),
                                  //               onChanged: (value) {
                                  //                 setState(() {
                                  //                   month = value;
                                  //                 });
                                  //                 if (month == 'Jan') {
                                  //                   monthNumber = 01;
                                  //                 } else if (month == 'Feb') {
                                  //                   monthNumber = 02;
                                  //                 } else if (month == 'Mar') {
                                  //                   monthNumber = 03;
                                  //                 } else if (month == 'Apr') {
                                  //                   monthNumber = 04;
                                  //                 } else if (month == 'May') {
                                  //                   monthNumber = 05;
                                  //                 } else if (month == 'Jun') {
                                  //                   monthNumber = 06;
                                  //                 } else if (month == 'Jul') {
                                  //                   monthNumber = 07;
                                  //                 } else if (month == 'Aug') {
                                  //                   monthNumber = 08;
                                  //                 } else if (month == 'Sep') {
                                  //                   monthNumber = 09;
                                  //                 } else if (month == 'Oct') {
                                  //                   monthNumber = 10;
                                  //                 } else if (month == 'Nov') {
                                  //                   monthNumber = 11;
                                  //                 } else if (month == 'Dec') {
                                  //                   monthNumber = 12;
                                  //                 }
                                  //                 print(
                                  //                     'monthNumber $monthNumber');
                                  //               },
                                  //               //  => setState(
                                  //               //     () => month = value),
                                  //               validator: (value) =>
                                  //                   value == null
                                  //                       ? 'field required'
                                  //                       : null,
                                  //             ),
                                  //           ),
                                  //         ),
                                  //       ),
                                  //     ],
                                  //   ),
                                  // ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 2.0,
                                      right: 2.0,
                                      bottom: 2.0,
                                      top: 10.0,
                                    ),
                                    child: Row(
                                      children: [
                                        const Expanded(
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "SUBSTATION*",
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Color.fromARGB(
                                                  255,
                                                  7,
                                                  59,
                                                  120,
                                                ),
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Padding(
                                              padding: const EdgeInsets.all(
                                                2.0,
                                              ),
                                              child: DropdownButtonFormField<String>(
                                                hint: const Text('-Select-'),
                                                dropdownColor: Colors.white,
                                                value: selectedSubstation,
                                                style: const TextStyle(
                                                  color: Color.fromARGB(
                                                    255,
                                                    7,
                                                    59,
                                                    120,
                                                  ),
                                                  fontSize: 16,
                                                ),
                                                icon: const Icon(
                                                  Icons.arrow_drop_down,
                                                  color: Color.fromARGB(
                                                    255,
                                                    7,
                                                    59,
                                                    120,
                                                  ),
                                                  size: 40,
                                                ),
                                                decoration: const InputDecoration(
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Color.fromARGB(
                                                            255,
                                                            7,
                                                            59,
                                                            120,
                                                          ),
                                                        ),
                                                      ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Color.fromARGB(
                                                            255,
                                                            7,
                                                            59,
                                                            120,
                                                          ),
                                                        ),
                                                      ),
                                                ),
                                                isExpanded: true,
                                                items: addNewRowMaintenancePlanViewModel
                                                    .addNewRowMaintenancePlanList
                                                    .data!
                                                    .substationList!
                                                    .map((e) {
                                                      return DropdownMenuItem(
                                                        value: e.substationId
                                                            .toString(),
                                                        // e.getIdAndSubstationByCountId![0].subStation.toString(),
                                                        child: Text(
                                                          e.substationName
                                                              .toString(),
                                                        ),
                                                      );
                                                    })
                                                    .toList(),
                                                onChanged: (val) async {
                                                  if (selectedFeeder != null) {
                                                    selectedFeeder = null;
                                                  }
                                                  print(
                                                    getSubstationNameById(val!),
                                                  );
                                                  substationName =
                                                      getSubstationNameById(
                                                        val,
                                                      );
                                                  print('val');
                                                  print(val);
                                                  fetchData(
                                                    val,
                                                    'Get',
                                                    '',
                                                    '',
                                                    '',
                                                    substationName,
                                                    selectedyear,
                                                    '',
                                                    '',
                                                  );
                                                  substationId = int.parse(val);
                                                  // print('111111111111111');
                                                  // print(addNewRowMaintenancePlanViewModel
                                                  //     .addNewRowMaintenancePlanList
                                                  //     .data!
                                                  //     .getCostPerMileBySubstation
                                                  //     .toString());
                                                  // setState(() async {
                                                  selectedSubstation = val;
                                                  print(
                                                    'selectedSubstation11111111111111 $selectedSubstation',
                                                  );
                                                  print(
                                                    'substationId0000000000 $substationId',
                                                  );
                                                  print(
                                                    'substationName00000000000 $substationName',
                                                  );
                                                  await Future.delayed(
                                                    const Duration(seconds: 5),
                                                  );
                                                  getTotalMiles();
                                                  _costPerMile.text =
                                                      (addNewRowMaintenancePlanViewModel
                                                              .addNewRowMaintenancePlanList
                                                              .data!
                                                              .getCostPerMileBySubstation ==
                                                          null)
                                                      ? '0'
                                                      : addNewRowMaintenancePlanViewModel
                                                            .addNewRowMaintenancePlanList
                                                            .data!
                                                            .getCostPerMileBySubstation
                                                            .toString();
                                                  // });
                                                },
                                                validator: (value) =>
                                                    value == null
                                                    ? 'field required'
                                                    : null,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 2.0,
                                      right: 2.0,
                                      bottom: 2.0,
                                      top: 10.0,
                                    ),
                                    child: Row(
                                      children: [
                                        const Expanded(
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "FEEDER*",
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Color.fromARGB(
                                                  255,
                                                  7,
                                                  59,
                                                  120,
                                                ),
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Padding(
                                              padding: const EdgeInsets.all(
                                                2.0,
                                              ),
                                              child: DropdownButtonFormField<String>(
                                                hint: const Text('-Select-'),
                                                dropdownColor: Colors.white,
                                                value: selectedFeeder,
                                                style: const TextStyle(
                                                  color: Color.fromARGB(
                                                    255,
                                                    7,
                                                    59,
                                                    120,
                                                  ),
                                                  fontSize: 16,
                                                ),
                                                icon: const Icon(
                                                  Icons.arrow_drop_down,
                                                  color: Color.fromARGB(
                                                    255,
                                                    7,
                                                    59,
                                                    120,
                                                  ),
                                                  size: 40,
                                                ),
                                                decoration: const InputDecoration(
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Color.fromARGB(
                                                            255,
                                                            7,
                                                            59,
                                                            120,
                                                          ),
                                                        ),
                                                      ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Color.fromARGB(
                                                            255,
                                                            7,
                                                            59,
                                                            120,
                                                          ),
                                                        ),
                                                      ),
                                                ),
                                                isExpanded: true,
                                                items: addNewRowMaintenancePlanViewModel
                                                    .addNewRowMaintenancePlanList
                                                    .data!
                                                    .feederList!
                                                    .map((e) {
                                                      return DropdownMenuItem(
                                                        value: e.feederName
                                                            .toString(),
                                                        child: Text(
                                                          e.feederName
                                                              .toString(),
                                                        ),
                                                      );
                                                    })
                                                    .toList(),
                                                onChanged: (val) async {
                                                  print('val');
                                                  print(val);
                                                  // print(
                                                  //     getFeederNameById(val!));
                                                  fetchData(
                                                    selectedSubstation,
                                                    'Get',
                                                    '',
                                                    '',
                                                    '',
                                                    substationName,
                                                    selectedyear,
                                                    val.toString(),
                                                    '',
                                                  );

                                                  feederId = int.parse(
                                                    getFeederIdNameByName(
                                                      val.toString(),
                                                    ),
                                                  );

                                                  feederName = val.toString();
                                                  print(
                                                    'feederName00000000000 $feederName',
                                                  );
                                                  print(
                                                    'feederId00000000000 $feederId',
                                                  );

                                                  setState(() {
                                                    selectedFeeder = val;
                                                    print(selectedFeeder);
                                                  });
                                                  await Future.delayed(
                                                    const Duration(seconds: 5),
                                                  );
                                                  getTotalMiles();
                                                },
                                                validator: (value) =>
                                                    value == null
                                                    ? 'field required'
                                                    : null,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 2.0,
                                      right: 2.0,
                                      bottom: 2.0,
                                      top: 10.0,
                                    ),
                                    child: Row(
                                      children: [
                                        const Expanded(
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "MAINTENANCE TYPE*",
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Color.fromARGB(
                                                  255,
                                                  7,
                                                  59,
                                                  120,
                                                ),
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: Padding(
                                              padding: const EdgeInsets.all(
                                                2.0,
                                              ),
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 12,
                                                      vertical: 4,
                                                    ),
                                                decoration: BoxDecoration(
                                                  // borderRadius:
                                                  //     BorderRadius.circular(25),
                                                  border: Border.all(
                                                    color: const Color.fromARGB(
                                                      255,
                                                      7,
                                                      59,
                                                      120,
                                                    ),
                                                  ),
                                                ),
                                                child: MultiSelectDialogField(
                                                  initialValue:
                                                      types, // Ensure this list is correct
                                                  items: select_maintenanceType
                                                      .map(
                                                        (e) => MultiSelectItem(
                                                          e,
                                                          e,
                                                        ),
                                                      )
                                                      .toList(),
                                                  listType:
                                                      MultiSelectListType.CHIP,
                                                  onConfirm: (List<dynamic> value) {
                                                    // Use List<dynamic> as the type
                                                    setState(() {
                                                      maintenanceType = value
                                                          .join(', ');
                                                      // types.add(
                                                      //     value.toString());
                                                    });
                                                    print(
                                                      'maintenanceType $maintenanceType',
                                                    ); // This should print the selected values
                                                  },
                                                  validator: (value) =>
                                                      value == null
                                                      ? 'Field required'
                                                      : null, // Basic validation example
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 2.0,
                                      right: 2.0,
                                      bottom: 2.0,
                                      top: 10.0,
                                    ),
                                    child: Row(
                                      children: [
                                        const Expanded(
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "TOTAL MILES",
                                              style: TextStyle(
                                                fontSize: 16.0,
                                                color: Color.fromARGB(
                                                  255,
                                                  7,
                                                  59,
                                                  120,
                                                ),
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: Padding(
                                              padding: const EdgeInsets.all(
                                                2.0,
                                              ),
                                              child: TextFormField(
                                                inputFormatters: [
                                                  FilteringTextInputFormatter.deny(
                                                    RegExp(r'-'),
                                                  ),
                                                ],
                                                //key: formkey4,
                                                controller: _totalMiles,
                                                style: const TextStyle(
                                                  color: Color.fromARGB(
                                                    255,
                                                    7,
                                                    59,
                                                    120,
                                                  ),
                                                  fontSize: 16,
                                                ),
                                                obscureText: false,
                                                // keyboardType:
                                                //     TextInputType.number,
                                                keyboardType:
                                                    const TextInputType.numberWithOptions(
                                                      decimal: true,
                                                      signed: false,
                                                    ),
                                                decoration: const InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Color.fromARGB(
                                                            255,
                                                            7,
                                                            59,
                                                            120,
                                                          ),
                                                        ),
                                                      ),
                                                  hintText: '0',
                                                ),
                                                onChanged: (value) {
                                                  setState(() {
                                                    calculateTotalCost(
                                                      double.parse(value),
                                                      double.parse(
                                                        _costPerMile.text,
                                                      ),
                                                      _totalCost,
                                                    );
                                                  });
                                                },
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return "Please enter total cost";
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 2.0,
                                      right: 2.0,
                                      bottom: 2.0,
                                      top: 10.0,
                                    ),
                                    child: Row(
                                      children: [
                                        const Expanded(
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "COST PER MILE",
                                              style: TextStyle(
                                                fontSize: 16.0,
                                                color: Color.fromARGB(
                                                  255,
                                                  7,
                                                  59,
                                                  120,
                                                ),
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: Padding(
                                              padding: const EdgeInsets.all(
                                                2.0,
                                              ),
                                              child: TextFormField(
                                                inputFormatters: [
                                                  FilteringTextInputFormatter.deny(
                                                    RegExp(r'-'),
                                                  ),
                                                ],
                                                //  key: formkey5,
                                                controller: _costPerMile,
                                                style: const TextStyle(
                                                  color: Color.fromARGB(
                                                    255,
                                                    7,
                                                    59,
                                                    120,
                                                  ),
                                                  fontSize: 16,
                                                ),
                                                obscureText: false,
                                                // keyboardType:
                                                //     TextInputType.number,
                                                keyboardType:
                                                    const TextInputType.numberWithOptions(
                                                      decimal: true,
                                                      signed: false,
                                                    ),
                                                decoration: const InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Color.fromARGB(
                                                            255,
                                                            7,
                                                            59,
                                                            120,
                                                          ),
                                                        ),
                                                      ),
                                                  hintText: '0',
                                                ),
                                                onChanged: (value) {
                                                  setState(() {
                                                    calculateTotalCost(
                                                      double.parse(
                                                        _totalMiles.text,
                                                      ),
                                                      double.parse(value),
                                                      _totalCost,
                                                    );
                                                  });
                                                },
                                                // validator: (value) {
                                                //   if (value!.isEmpty) {
                                                //     return "Please enter cost per mile";
                                                //   } else {
                                                //     return null;
                                                //   }
                                                // },
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 2.0,
                                      right: 2.0,
                                      bottom: 2.0,
                                      top: 10.0,
                                    ),
                                    child: Row(
                                      children: [
                                        const Expanded(
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "TOTAL COST",
                                              style: TextStyle(
                                                fontSize: 16.0,
                                                color: Color.fromARGB(
                                                  255,
                                                  7,
                                                  59,
                                                  120,
                                                ),
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: Padding(
                                              padding: const EdgeInsets.all(
                                                2.0,
                                              ),
                                              child: TextFormField(
                                                enabled: false,
                                                // key: formkey6,
                                                controller: _totalCost,
                                                style: const TextStyle(
                                                  color: Color.fromARGB(
                                                    255,
                                                    7,
                                                    59,
                                                    120,
                                                  ),
                                                  fontSize: 16,
                                                ),
                                                obscureText: false,
                                                keyboardType:
                                                    TextInputType.number,
                                                decoration: const InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  disabledBorder:
                                                      OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Color.fromARGB(
                                                            255,
                                                            7,
                                                            59,
                                                            120,
                                                          ),
                                                        ),
                                                      ),
                                                  hintText: '0',
                                                ),
                                                // validator: (value) {
                                                //   if (value!.isEmpty) {
                                                //     return "Please enter total cost";
                                                //   } else {
                                                //     return null;
                                                //   }
                                                // },
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 2.0,
                                      right: 2.0,
                                      bottom: 2.0,
                                      top: 10.0,
                                    ),
                                    child: Row(
                                      children: [
                                        const Expanded(
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "BUDGET TYPE*",
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Color.fromARGB(
                                                  255,
                                                  7,
                                                  59,
                                                  120,
                                                ),
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Padding(
                                              padding: const EdgeInsets.all(
                                                2.0,
                                              ),
                                              child: DropdownButtonFormField<String>(
                                                hint: const Text('-Select-'),
                                                dropdownColor: Colors.white,
                                                value: budgetType,
                                                style: const TextStyle(
                                                  color: Color.fromARGB(
                                                    255,
                                                    7,
                                                    59,
                                                    120,
                                                  ),
                                                  fontSize: 16,
                                                ),
                                                icon: const Icon(
                                                  Icons.arrow_drop_down,
                                                  color: Color.fromARGB(
                                                    255,
                                                    7,
                                                    59,
                                                    120,
                                                  ),
                                                  size: 40,
                                                ),
                                                decoration: const InputDecoration(
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Color.fromARGB(
                                                            255,
                                                            7,
                                                            59,
                                                            120,
                                                          ),
                                                        ),
                                                      ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Color.fromARGB(
                                                            255,
                                                            7,
                                                            59,
                                                            120,
                                                          ),
                                                        ),
                                                      ),
                                                ),
                                                isExpanded: true,
                                                items: select_budgetType
                                                    .map(buildMenuItem)
                                                    .toList(),
                                                onChanged: (value) => setState(
                                                  () => budgetType = value,
                                                ),
                                                validator: (value) =>
                                                    value == null
                                                    ? 'field required'
                                                    : null,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  // Padding(
                                  //   padding: const EdgeInsets.only(
                                  //       left: 2.0,
                                  //       right: 2.0,
                                  //       bottom: 2.0,
                                  //       top: 10.0),
                                  //   child: Row(
                                  //     children: [
                                  //       const Expanded(
                                  //         child: Align(
                                  //             alignment: Alignment.centerLeft,
                                  //             child: Text(
                                  //               "Budget",
                                  //               style: TextStyle(
                                  //                 fontSize: 16.0,
                                  //                 color: Color.fromARGB(
                                  //                     255, 7, 59, 120),
                                  //                 //  fontWeight: FontWeight.bold
                                  //               ),
                                  //             )),
                                  //       ),
                                  //       Expanded(
                                  //         child: Align(
                                  //           alignment: Alignment.centerRight,
                                  //           child: Padding(
                                  //             padding:
                                  //                 const EdgeInsets.all(2.0),
                                  //             child: TextFormField(
                                  //               // key: formkey7,
                                  //               controller: _budget,
                                  //               style: const TextStyle(
                                  //                   color: Color.fromARGB(
                                  //                       255, 7, 59, 120),
                                  //                   fontSize: 16),
                                  //               obscureText: false,
                                  //               keyboardType:
                                  //                   TextInputType.number,
                                  //               decoration:
                                  //                   const InputDecoration(
                                  //                 border: OutlineInputBorder(),
                                  //                 enabledBorder:
                                  //                     OutlineInputBorder(
                                  //                   borderSide: BorderSide(
                                  //                     color: Color.fromARGB(
                                  //                         255, 7, 59, 120),
                                  //                   ),
                                  //                 ),
                                  //                 hintText: 'Budget',
                                  //               ),
                                  //               validator: (value) {
                                  //                 if (value!.isEmpty) {
                                  //                   return "Please Enter Budget again";
                                  //                 }
                                  //                 int a =
                                  //                     (_totalCost.text.isEmpty)
                                  //                         ? 0
                                  //                         : int.parse(_totalCost
                                  //                             .text
                                  //                             .toString());
                                  //                 int b = (_budget.text.isEmpty)
                                  //                     ? 0
                                  //                     : int.parse(_budget.text
                                  //                         .toString());
                                  //                 if (b <= a) {
                                  //                   return "Budget > Total Cost";
                                  //                 }
                                  //                 return null;
                                  //               },
                                  //             ),
                                  //           ),
                                  //         ),
                                  //       ),
                                  //     ],
                                  //   ),
                                  // ),

                                  // Padding(
                                  //   padding: const EdgeInsets.only(
                                  //       left: 2.0,
                                  //       right: 2.0,
                                  //       bottom: 2.0,
                                  //       top: 10.0),
                                  //   child: Row(
                                  //     children: [
                                  //       const Expanded(
                                  //         child: Align(
                                  //             alignment: Alignment.centerLeft,
                                  //             child: Text(
                                  //               "CONTRACT ROW YEAR",
                                  //               style: TextStyle(
                                  //                   fontSize: 16.0,
                                  //                   color: Color.fromARGB(
                                  //                       255, 7, 59, 120),
                                  //                   fontWeight:
                                  //                       FontWeight.bold),
                                  //             )),
                                  //       ),
                                  //       Expanded(
                                  //         child: Align(
                                  //           alignment: Alignment.centerRight,
                                  //           child: Padding(
                                  //             padding:
                                  //                 const EdgeInsets.all(2.0),
                                  //             child: TextFormField(
                                  //               // enabled: false,
                                  //               //key: formkey8,
                                  //               controller: _contractRowYear,
                                  //               style: const TextStyle(
                                  //                   color: Color.fromARGB(
                                  //                       255, 7, 59, 120),
                                  //                   fontSize: 16),
                                  //               obscureText: false,
                                  //               keyboardType:
                                  //                   TextInputType.number,
                                  //               decoration:
                                  //                   const InputDecoration(
                                  //                 border: OutlineInputBorder(),
                                  //                 disabledBorder:
                                  //                     OutlineInputBorder(
                                  //                   borderSide: BorderSide(
                                  //                     color: Color.fromARGB(
                                  //                         255, 7, 59, 120),
                                  //                   ),
                                  //                 ),
                                  //               ),

                                  //               onChanged: (value) {
                                  //                 setState(() {
                                  //                   // calculateNextMaintenanceYear(
                                  //                   //   int.parse(value),
                                  //                   //   // 2023,
                                  //                   //   // 7,
                                  //                   //   int.parse(_rowCycle.text),
                                  //                   //   _nextMaintYear,
                                  //                   // );
                                  //                 });
                                  //               },
                                  //               validator: (value) {
                                  //                 if (value!.isEmpty) {
                                  //                   return "Please enter contract row year";
                                  //                 }
                                  //                 try {
                                  //                   double parsedValue =
                                  //                       double.parse(value);
                                  //                   if (parsedValue % 1 != 0) {
                                  //                     return "Integer value required!";
                                  //                   }
                                  //                 } catch (e) {
                                  //                   return "Invalid input. Please enter a numeric value.";
                                  //                 }
                                  //                 return null;
                                  //               },
                                  //             ),
                                  //           ),
                                  //         ),
                                  //       ),
                                  //     ],
                                  //   ),
                                  // ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 2.0,
                                      right: 2.0,
                                      bottom: 2.0,
                                      top: 10.0,
                                    ),
                                    child: Row(
                                      children: [
                                        const Expanded(
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "ROW CYCLE ",
                                              style: TextStyle(
                                                fontSize: 16.0,
                                                color: Color.fromARGB(
                                                  255,
                                                  7,
                                                  59,
                                                  120,
                                                ),
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: Padding(
                                              padding: const EdgeInsets.all(
                                                2.0,
                                              ),
                                              child: TextFormField(
                                                enabled: false,
                                                inputFormatters: [
                                                  FilteringTextInputFormatter.deny(
                                                    RegExp(r'-'),
                                                  ),
                                                ],
                                                // key: formkey9,
                                                controller: _rowCycle,
                                                style: const TextStyle(
                                                  color: Color.fromARGB(
                                                    255,
                                                    7,
                                                    59,
                                                    120,
                                                  ),
                                                  fontSize: 16,
                                                ),
                                                obscureText: false,
                                                keyboardType:
                                                    TextInputType.number,
                                                decoration: const InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  disabledBorder:
                                                      OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Color.fromARGB(
                                                            255,
                                                            7,
                                                            59,
                                                            120,
                                                          ),
                                                        ),
                                                      ),
                                                  hintText: '0',
                                                ),
                                                onChanged: (value) {
                                                  setState(() {
                                                    // calculateNextMaintenanceYear(
                                                    //   int.parse(_contractRowYear
                                                    //       .text),
                                                    //   // 2023,
                                                    //   int.parse(value),
                                                    //   _nextMaintYear,
                                                    // );
                                                  });
                                                },
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return "Please enter row cycle ";
                                                  }
                                                  try {
                                                    double parsedValue =
                                                        double.parse(value);
                                                    if (parsedValue % 1 != 0) {
                                                      return "Integer value required!";
                                                    }
                                                  } catch (e) {
                                                    return "Invalid input. Please enter a numeric value.";
                                                  }
                                                  return null;
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 2.0,
                                      right: 2.0,
                                      bottom: 2.0,
                                      top: 10.0,
                                    ),
                                    child: Row(
                                      children: [
                                        const Expanded(
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "ROW YEAR ",
                                              style: TextStyle(
                                                fontSize: 16.0,
                                                color: Color.fromARGB(
                                                  255,
                                                  7,
                                                  59,
                                                  120,
                                                ),
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: Padding(
                                              padding: const EdgeInsets.all(
                                                2.0,
                                              ),
                                              child: TextFormField(
                                                enabled: false,
                                                inputFormatters: [
                                                  FilteringTextInputFormatter.deny(
                                                    RegExp(r'-'),
                                                  ),
                                                ],
                                                // key: formkey9,
                                                controller: _rowYear,
                                                style: const TextStyle(
                                                  color: Color.fromARGB(
                                                    255,
                                                    7,
                                                    59,
                                                    120,
                                                  ),
                                                  fontSize: 16,
                                                ),
                                                obscureText: false,
                                                keyboardType:
                                                    TextInputType.number,
                                                decoration: const InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  disabledBorder:
                                                      OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Color.fromARGB(
                                                            255,
                                                            7,
                                                            59,
                                                            120,
                                                          ),
                                                        ),
                                                      ),
                                                  hintText: '0',
                                                ),
                                                onChanged: (value) {
                                                  setState(() {
                                                    // calculateNextMaintenanceYear(
                                                    //   int.parse(_contractRowYear
                                                    //       .text),
                                                    //   // 2023,
                                                    //   int.parse(value),
                                                    //   _nextMaintYear,
                                                    // );
                                                  });
                                                },
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return "Please enter row year ";
                                                  }
                                                  // try {
                                                  //   double parsedValue =
                                                  //       double.parse(value);
                                                  //   if (parsedValue % 1 != 0) {
                                                  //     return "Integer value required!";
                                                  //   }
                                                  // } catch (e) {
                                                  //   return "Invalid input. Please enter a numeric value.";
                                                  // }
                                                  return null;
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  // Padding(
                                  //   padding: const EdgeInsets.only(
                                  //       left: 2.0,
                                  //       right: 2.0,
                                  //       bottom: 2.0,
                                  //       top: 10.0),
                                  //   child: Row(
                                  //     children: [
                                  //       const Expanded(
                                  //         child: Align(
                                  //             alignment: Alignment.centerLeft,
                                  //             child: Text(
                                  //               "NEXT MAINT YEAR",
                                  //               style: TextStyle(
                                  //                   fontSize: 16.0,
                                  //                   color: Color.fromARGB(
                                  //                       255, 7, 59, 120),
                                  //                   fontWeight:
                                  //                       FontWeight.bold),
                                  //             )),
                                  //       ),
                                  //       Expanded(
                                  //         child: Align(
                                  //           alignment: Alignment.centerRight,
                                  //           child: Padding(
                                  //             padding:
                                  //                 const EdgeInsets.all(2.0),
                                  //             child: TextFormField(
                                  //               enabled: false,
                                  //               // key: formkey10,
                                  //               controller: _nextMaintYear,
                                  //               style: const TextStyle(
                                  //                   color: Color.fromARGB(
                                  //                       255, 7, 59, 120),
                                  //                   fontSize: 16),
                                  //               obscureText: false,
                                  //               decoration:
                                  //                   const InputDecoration(
                                  //                 border: OutlineInputBorder(),
                                  //                 disabledBorder:
                                  //                     OutlineInputBorder(
                                  //                   borderSide: BorderSide(
                                  //                     color: Color.fromARGB(
                                  //                         255, 7, 59, 120),
                                  //                   ),
                                  //                 ),
                                  //                 hintText: '0',
                                  //               ),
                                  //               validator: (value) {
                                  //                 if (value!.isEmpty) {
                                  //                   return "Please enter next maint year";
                                  //                 } else {
                                  //                   return null;
                                  //                 }
                                  //               },
                                  //             ),
                                  //           ),
                                  //         ),
                                  //       ),
                                  //     ],
                                  //   ),
                                  // ),
                                  // Padding(
                                  //   padding: const EdgeInsets.only(
                                  //       left: 2.0,
                                  //       right: 2.0,
                                  //       bottom: 2.0,
                                  //       top: 10.0),
                                  //   child: Row(
                                  //     children: [
                                  //       const Expanded(
                                  //         child: Align(
                                  //             alignment: Alignment.centerLeft,
                                  //             child: Text(
                                  //               "CONTRACT END YEAR",
                                  //               style: TextStyle(
                                  //                   fontSize: 16.0,
                                  //                   color: Color.fromARGB(
                                  //                       255, 7, 59, 120),
                                  //                   fontWeight:
                                  //                       FontWeight.bold),
                                  //             )),
                                  //       ),
                                  //       Expanded(
                                  //         child: Align(
                                  //           alignment: Alignment.centerRight,
                                  //           child: Padding(
                                  //             padding:
                                  //                 const EdgeInsets.all(2.0),
                                  //             child: TextFormField(
                                  //               keyboardType:
                                  //                   TextInputType.number,
                                  //               // key: formkey10,
                                  //               controller: _contractEndYear,
                                  //               style: const TextStyle(
                                  //                   color: Color.fromARGB(
                                  //                       255, 7, 59, 120),
                                  //                   fontSize: 16),
                                  //               obscureText: false,
                                  //               decoration:
                                  //                   const InputDecoration(
                                  //                 border: OutlineInputBorder(),
                                  //                 enabledBorder:
                                  //                     OutlineInputBorder(
                                  //                   borderSide: BorderSide(
                                  //                     color: Color.fromARGB(
                                  //                         255, 7, 59, 120),
                                  //                   ),
                                  //                 ),
                                  //                 hintText: 'Contract End Year',
                                  //               ),
                                  //               validator: (value) {
                                  //                 if (value!.isEmpty) {
                                  //                   return "Please enter your Contract End Year";
                                  //                 }

                                  //                 if (value.compareTo(
                                  //                         _nextMaintYear.text
                                  //                             .toString()) <
                                  //                     0) {
                                  //                   return "Invalid Year..!";
                                  //                 }
                                  //                 try {
                                  //                   double parsedValue =
                                  //                       double.parse(value);
                                  //                   if (parsedValue % 1 != 0) {
                                  //                     return "Integer value required!";
                                  //                   }
                                  //                 } catch (e) {
                                  //                   return "Invalid input..!";
                                  //                 }
                                  //                 return null;
                                  //               },
                                  //             ),
                                  //           ),
                                  //         ),
                                  //       ),
                                  //     ],
                                  //   ),
                                  // ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 2.0,
                                      right: 2.0,
                                      bottom: 2.0,
                                      top: 10.0,
                                    ),
                                    child: Row(
                                      children: [
                                        const Expanded(
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "CONTRACTOR COMPANY*",
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Color.fromARGB(
                                                  255,
                                                  7,
                                                  59,
                                                  120,
                                                ),
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Padding(
                                              padding: const EdgeInsets.all(
                                                2.0,
                                              ),
                                              child: DropdownButtonFormField<String>(
                                                hint: const Text('-Select-'),
                                                dropdownColor: Colors.white,
                                                value: contractorCompany,
                                                style: const TextStyle(
                                                  color: Color.fromARGB(
                                                    255,
                                                    7,
                                                    59,
                                                    120,
                                                  ),
                                                  fontSize: 16,
                                                ),
                                                icon: const Icon(
                                                  Icons.arrow_drop_down,
                                                  color: Color.fromARGB(
                                                    255,
                                                    7,
                                                    59,
                                                    120,
                                                  ),
                                                  size: 40,
                                                ),
                                                decoration: const InputDecoration(
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Color.fromARGB(
                                                            255,
                                                            7,
                                                            59,
                                                            120,
                                                          ),
                                                        ),
                                                      ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: Color.fromARGB(
                                                            255,
                                                            7,
                                                            59,
                                                            120,
                                                          ),
                                                        ),
                                                      ),
                                                ),
                                                isExpanded: true,
                                                items: select_contractorCompany
                                                    .map(buildMenuItem)
                                                    .toList(),
                                                onChanged: (value) {
                                                  setState(() {
                                                    contractorCompany = value;
                                                  });
                                                  if (contractorCompany ==
                                                      'LCP') {
                                                    _isVisibleAssignForeman =
                                                        false;
                                                  } else {
                                                    _isVisibleAssignForeman =
                                                        true;
                                                  }
                                                  fetchData(
                                                    selectedSubstation,
                                                    'Get',
                                                    '',
                                                    '',
                                                    '',
                                                    substationName,
                                                    selectedyear,
                                                    selectedFeeder,
                                                    contractorCompany
                                                        .toString(),
                                                  );
                                                },
                                                validator: (value) =>
                                                    value == null
                                                    ? 'field required'
                                                    : null,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Visibility(
                                    visible: _isVisibleAssignForeman,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        left: 2.0,
                                        right: 2.0,
                                        bottom: 2.0,
                                        top: 10.0,
                                      ),
                                      child: Row(
                                        children: [
                                          const Expanded(
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "ASSIGN FOREMAN*",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Color.fromARGB(
                                                    255,
                                                    7,
                                                    59,
                                                    120,
                                                  ),
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Padding(
                                                padding: const EdgeInsets.all(
                                                  2.0,
                                                ),
                                                child: DropdownButtonFormField<String>(
                                                  hint: const Text('-Select-'),
                                                  dropdownColor: Colors.white,
                                                  value: selectedAssignForman,
                                                  style: const TextStyle(
                                                    color: Color.fromARGB(
                                                      255,
                                                      7,
                                                      59,
                                                      120,
                                                    ),
                                                    fontSize: 16,
                                                  ),
                                                  icon: const Icon(
                                                    Icons.arrow_drop_down,
                                                    color: Color.fromARGB(
                                                      255,
                                                      7,
                                                      59,
                                                      120,
                                                    ),
                                                    size: 40,
                                                  ),
                                                  decoration: const InputDecoration(
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                            color:
                                                                Color.fromARGB(
                                                                  255,
                                                                  7,
                                                                  59,
                                                                  120,
                                                                ),
                                                          ),
                                                        ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                            color:
                                                                Color.fromARGB(
                                                                  255,
                                                                  7,
                                                                  59,
                                                                  120,
                                                                ),
                                                          ),
                                                        ),
                                                  ),
                                                  isExpanded: true,
                                                  items: addNewRowMaintenancePlanViewModel
                                                      .addNewRowMaintenancePlanList
                                                      .data!
                                                      .contractorGetInsert!
                                                      .map((e) {
                                                        return DropdownMenuItem(
                                                          value: e.name
                                                              .toString(),
                                                          child: Text(
                                                            e.name.toString(),
                                                          ),
                                                        );
                                                      })
                                                      .toList(),
                                                  onChanged: (val) {
                                                    setState(() {
                                                      selectedAssignForman =
                                                          val;
                                                    });
                                                    print('val1111111111');
                                                    print(selectedAssignForman);
                                                    print(val);
                                                    List<ContractorGetInsert>?
                                                    loginIdList =
                                                        addNewRowMaintenancePlanViewModel
                                                            .addNewRowMaintenancePlanList
                                                            .data!
                                                            .contractorGetInsert;
                                                    print('111111111111111');
                                                    print('loginIdList');
                                                    print(loginIdList);
                                                    print(selectedAssignForman);
                                                    print(
                                                      '22222222222222222222222',
                                                    );
                                                    print(selectedAssignForman);
                                                    loginIdList?.forEach((
                                                      ContractorGetInsert a,
                                                    ) {
                                                      if (a.name ==
                                                          selectedAssignForman) {
                                                        assignFormanId =
                                                            a.loginId!;
                                                        print(
                                                          'assignFormanId11111111111111111111111',
                                                        );
                                                        print(assignFormanId);
                                                        print(
                                                          'selectedAssignForman.............',
                                                        );
                                                        print(
                                                          selectedAssignForman,
                                                        );
                                                      }
                                                    });
                                                    if (selectedAssignForman !=
                                                        'Other') {
                                                      _isVisibleAssignOtherForeman =
                                                          false;
                                                      name1 =
                                                          selectedAssignForman
                                                              .toString();
                                                      print(
                                                        'name1....other not selected',
                                                      );
                                                      print(name1);

                                                      print(
                                                        'Getting Supervisor Id............',
                                                      );

                                                      print(
                                                        '11111111111111111111111111111111',
                                                      );
                                                    } else {
                                                      _isVisibleAssignOtherForeman =
                                                          true;
                                                      name1 =
                                                          _assignOtherForeman
                                                              .text
                                                              .toString();
                                                      print(
                                                        'name1....other selected',
                                                      );
                                                      print(name1);
                                                      print(
                                                        'before other foreman entered',
                                                      );

                                                      print(
                                                        'after other foreman entered',
                                                      );
                                                      print(
                                                        _assignOtherForeman.text
                                                            .toString(),
                                                      );
                                                    }
                                                    print(
                                                      'aaaaaaaaaaaaaaaaaaaaaa',
                                                    );
                                                  },
                                                  validator: (value) =>
                                                      value == null
                                                      ? 'field required'
                                                      : null,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                    visible: _isVisibleAssignOtherForeman,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                            right: 2.0,
                                            top: 2,
                                            bottom: 2,
                                            left: 180,
                                          ),
                                          child: TextFormField(
                                            //  key: formkey5,
                                            controller: _assignOtherForeman,
                                            onEditingComplete: onTextChanged,
                                            style: const TextStyle(
                                              color: Color.fromARGB(
                                                255,
                                                7,
                                                59,
                                                120,
                                              ),
                                              fontSize: 16,
                                            ),
                                            obscureText: false,
                                            // keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                  color: Color.fromARGB(
                                                    255,
                                                    7,
                                                    59,
                                                    120,
                                                  ),
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                              ),
                                              hintText:
                                                  'Assign Other Foreman Name',
                                            ),

                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return "Please enter Assign Other Foreman Name";
                                              } else {
                                                return null;
                                              }
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),

                                  // const Align(
                                  //     alignment: Alignment.centerLeft,
                                  //     child: Padding(
                                  //       padding: EdgeInsets.only(
                                  //           left: 2.0,
                                  //           right: 2.0,
                                  //           bottom: 2.0,
                                  //           top: 8.0),
                                  //       child: Text(
                                  //         "UPLOAD (IMAGE, PDF)*",
                                  //         style: TextStyle(
                                  //             fontSize: 16,
                                  //             color: Color.fromARGB(
                                  //                 255, 7, 59, 120),
                                  //             fontWeight: FontWeight.bold),
                                  //       ),
                                  //     )),
                                  // Container(
                                  //   margin: const EdgeInsets.only(
                                  //       bottom: 10.0, top: 2),
                                  //   padding: const EdgeInsets.all(8),
                                  //   alignment: Alignment.center,
                                  //   width: size.width * 1,
                                  //   height: 50,
                                  //   decoration: const BoxDecoration(
                                  //       boxShadow: [
                                  //         BoxShadow(
                                  //             color: Color.fromARGB(
                                  //                 255, 3, 47, 97),
                                  //             blurRadius: 5,
                                  //             offset: Offset(2.0, 5.0))
                                  //       ],
                                  //       color:
                                  //           Color.fromARGB(255, 130, 193, 245),
                                  //       gradient: LinearGradient(
                                  //         colors: [
                                  //           Colors.white,
                                  //           Colors.white,
                                  //         ],
                                  //       )),
                                  //   child: Row(
                                  //     children: [
                                  //       InkWell(
                                  //           onTap: () {
                                  //             _checkPermission(context);
                                  //           },
                                  //           child: const Text(
                                  //             'Choose File',
                                  //             style: TextStyle(
                                  //               fontSize: 16,
                                  //               color: Color.fromARGB(
                                  //                   255, 7, 59, 120),
                                  //               //fontWeight: FontWeight.bold
                                  //             ),
                                  //           )),
                                  //       // Padding(
                                  //       //   padding:
                                  //       //       const EdgeInsets.only(left: 8.0),
                                  //       //   child: Container(
                                  //       //     width: 1,
                                  //       //     height: 50,
                                  //       //     color: Colors.black,
                                  //       //   ),
                                  //       // ),
                                  //       // Expanded(
                                  //       //   child: Padding(
                                  //       //     padding: const EdgeInsets.only(
                                  //       //         left: 8.0),
                                  //       //     child: Text(
                                  //       //       ((_imagePath.isEmpty) &&
                                  //       //               (_imagePath2.isEmpty) &&
                                  //       //               (_imagePath3.isEmpty))
                                  //       //           ? 'No file selected'
                                  //       //           : (_imagePath.isNotEmpty ||
                                  //       //                   _imagePath2
                                  //       //                       .isNotEmpty ||
                                  //       //                   _imagePath3
                                  //       //                       .isNotEmpty)
                                  //       //               ? '3 files selected'
                                  //       //               : (_imagePath
                                  //       //                           .isNotEmpty ||
                                  //       //                       _imagePath2
                                  //       //                           .isEmpty ||
                                  //       //                       _imagePath3
                                  //       //                           .isEmpty)
                                  //       //                   ? '1 file selected'
                                  //       //                   : (_imagePath
                                  //       //                               .isEmpty ||
                                  //       //                           _imagePath2
                                  //       //                               .isNotEmpty ||
                                  //       //                           _imagePath3
                                  //       //                               .isEmpty)
                                  //       //                       ? '1 file selected'
                                  //       //                       : (_imagePath
                                  //       //                                   .isNotEmpty &&
                                  //       //                               _imagePath2
                                  //       //                                   .isEmpty &&
                                  //       //                               _imagePath3
                                  //       //                                   .isEmpty)
                                  //       //                           ? '1 file selected'
                                  //       //                           : (_imagePath
                                  //       //                                       .isEmpty &&
                                  //       //                                   _imagePath2
                                  //       //                                       .isNotEmpty &&
                                  //       //                                   _imagePath3
                                  //       //                                       .isEmpty)
                                  //       //                               ? '1 file selected'
                                  //       //                               : (_imagePath.isEmpty &&
                                  //       //                                       _imagePath2.isEmpty &&
                                  //       //                                       _imagePath3.isNotEmpty)
                                  //       //                                   ? '1 file selected'
                                  //       //                                   : (_imagePath.isNotEmpty && _imagePath2.isNotEmpty && _imagePath3.isEmpty)
                                  //       //                                       ? '2 files selected'
                                  //       //                                       : (_imagePath.isNotEmpty && _imagePath2.isEmpty && _imagePath3.isNotEmpty)
                                  //       //                                           ? '2 files selected'
                                  //       //                                           : (_imagePath.isEmpty && _imagePath2.isNotEmpty && _imagePath3.isNotEmpty)
                                  //       //                                               ? '2 files selected'
                                  //       //                                               : 'No File selected',
                                  //       //       style: const TextStyle(
                                  //       //         fontSize: 16,
                                  //       //         color: Color.fromARGB(
                                  //       //             255, 7, 59, 120),
                                  //       //       ),
                                  //       //     ),
                                  //       //   ),
                                  //       // ),
                                  //     ],
                                  //   ),
                                  // ),
                                  // Row(
                                  //   children: [
                                  //     Expanded(
                                  //       child: Visibility(
                                  //         visible: _isVisibleImageDoc,
                                  //         child: Stack(
                                  //           children: [
                                  //             if (_imagePath.isNotEmpty)
                                  //               Center(
                                  //                 child: Icon(
                                  //                   getFileTypeIcon(_imagePath),
                                  //                   size: 100,
                                  //                 ),
                                  //               ),
                                  //             InkWell(
                                  //               onTap: () async {
                                  //                 setState(() {
                                  //                   _isVisibleImageDoc = false;
                                  //                 });
                                  //                 deleteOnlineImageApi(
                                  //                     _imagePath);
                                  //               },
                                  //               child: const Icon(Icons.delete,
                                  //                   color: Colors.red,
                                  //                   size: 50),
                                  //             ),
                                  //           ],
                                  //         ),
                                  //       ),
                                  //     ),
                                  //     Expanded(
                                  //       child: Visibility(
                                  //         visible: _isVisibleImage2Doc,
                                  //         child: Stack(
                                  //           children: [
                                  //             if (_imagePath2.isNotEmpty)
                                  //               Center(
                                  //                 child: Icon(
                                  //                   getFileTypeIcon(
                                  //                       _imagePath2),
                                  //                   size: 100,
                                  //                 ),
                                  //               ),
                                  //             InkWell(
                                  //               onTap: () {
                                  //                 setState(() {
                                  //                   _isVisibleImage2Doc = false;
                                  //                 });
                                  //                 deleteOnlineImageApi(
                                  //                     _imagePath2);
                                  //               },
                                  //               child: const Icon(Icons.delete,
                                  //                   color: Colors.red,
                                  //                   size: 50),
                                  //             ),
                                  //           ],
                                  //         ),
                                  //       ),
                                  //     ),
                                  //     Expanded(
                                  //       child: Visibility(
                                  //         visible: _isVisibleImage3Doc,
                                  //         child: Stack(
                                  //           children: [
                                  //             if (_imagePath3.isNotEmpty)
                                  //               Center(
                                  //                 child: Icon(
                                  //                   getFileTypeIcon(
                                  //                       _imagePath3),
                                  //                   size: 100,
                                  //                 ),
                                  //               ),
                                  //             InkWell(
                                  //               onTap: () {
                                  //                 setState(() {
                                  //                   _isVisibleImage3Doc = false;
                                  //                 });
                                  //                 deleteOnlineImageApi(
                                  //                     _imagePath3);
                                  //               },
                                  //               child: const Icon(Icons.delete,
                                  //                   color: Colors.red,
                                  //                   size: 50),
                                  //             ),
                                  //           ],
                                  //         ),
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),
                                  // Row(
                                  //   children: [
                                  //     Expanded(
                                  //       child: Visibility(
                                  //         visible: _isVisibleImage,
                                  //         child: Stack(
                                  //           children: [
                                  //             if (_imagePath.isNotEmpty)
                                  //               Image.file(
                                  //                 File(_imagePath),
                                  //                 height: 200,
                                  //                 width: 200,
                                  //                 fit: BoxFit.cover,
                                  //               ),
                                  //             InkWell(
                                  //               onTap: () async {
                                  //                 setState(() {
                                  //                   _isVisibleImage = false;
                                  //                 });
                                  //                 deleteOnlineImageApi(
                                  //                     deleteImage1);
                                  //               },
                                  //               child: const Icon(Icons.delete,
                                  //                   color: Colors.red,
                                  //                   size: 50),
                                  //             ),
                                  //           ],
                                  //         ),
                                  //       ),
                                  //     ),
                                  //     Expanded(
                                  //       child: Visibility(
                                  //         visible: _isVisibleImage2,
                                  //         child: Stack(
                                  //           children: [
                                  //             if (_imagePath2.isNotEmpty)
                                  //               Image.file(
                                  //                 File(_imagePath),
                                  //                 height: 200,
                                  //                 width: 200,
                                  //                 fit: BoxFit.cover,
                                  //               ),
                                  //             InkWell(
                                  //               onTap: () {
                                  //                 setState(() {
                                  //                   _isVisibleImage2 = false;
                                  //                 });
                                  //                 deleteOnlineImageApi(
                                  //                     deleteImage2);
                                  //               },
                                  //               child: const Icon(Icons.delete,
                                  //                   color: Colors.red,
                                  //                   size: 50),
                                  //             ),
                                  //           ],
                                  //         ),
                                  //       ),
                                  //     ),
                                  //     Expanded(
                                  //       child: Visibility(
                                  //         visible: _isVisibleImage3,
                                  //         child: Stack(
                                  //           children: [
                                  //             if (_imagePath3.isNotEmpty)
                                  //               Image.file(
                                  //                 File(_imagePath3),
                                  //                 height: 200,
                                  //                 width: 200,
                                  //                 fit: BoxFit.cover,
                                  //               ),
                                  //             InkWell(
                                  //               onTap: () {
                                  //                 setState(() {
                                  //                   _isVisibleImage3 = false;
                                  //                 });
                                  //                 deleteOnlineImageApi(
                                  //                     deleteImage3);
                                  //               },
                                  //               child: const Icon(Icons.delete,
                                  //                   color: Colors.red,
                                  //                   size: 50),
                                  //             ),
                                  //           ],
                                  //         ),
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),

                                  // Container(
                                  //     margin: const EdgeInsets.only(
                                  //         left: 6, right: 6, top: 8.0),
                                  //     child: Padding(
                                  //       padding: const EdgeInsets.only(
                                  //           left: 2.0,
                                  //           right: 2.0,
                                  //           bottom: 2.0,
                                  //           top: 20.0),
                                  //       child: InkWell(
                                  //         onTap: () async {
                                  //           print('click on add new before');
                                  //           // print(dynamicYear);
                                  //           print('substation $substationId');
                                  //           print("feeder: $feederId");
                                  //           print(
                                  //               'contractorCompay $contractorCompany');
                                  //           print(
                                  //               'assignFormanId $assignFormanId');
                                  //           // "contractor":
                                  //           //     (contractorCompany == 'LCP')
                                  //           //         ? '48'
                                  //           //         : assignFormanId,
                                  //           print('type $maintenanceType');
                                  //           print(
                                  //               'cycle ${_rowCycle.text.toString()}');

                                  //           print(
                                  //               'supervisor : $selectedAssignForman');
                                  //           print(
                                  //               'totalCost : ${double.parse((double.parse(_totalCost.text.toString())).toStringAsFixed(2))}');
                                  //           print(
                                  //               'costPerMile ${double.parse((double.parse(_costPerMile.text.toString())).toStringAsFixed(2))}');
                                  //           print(
                                  //               'totalMiles ${double.parse((double.parse(_totalMiles.text.toString())).toStringAsFixed(2))}');
                                  //           print(
                                  //               'contractendYear ${_contractRowYear.text.toString()}');
                                  //           // print(
                                  //           //     'nextMaintDue ${DateFormat('yyyy-MM-dd').format(DateTime(
                                  //           //   int.parse(dynamicYear),
                                  //           //   currentDate.month,
                                  //           //   currentDate.day,
                                  //           // ))}');

                                  //           // print(
                                  //           //     'lastMaintDone ${DateFormat('yyyy-MM-dd').format(DateTime(
                                  //           //   int.parse(_contractRowYear.text
                                  //           //       .toString()),
                                  //           //   currentDate.month,
                                  //           //   currentDate.day,
                                  //           // ))}');

                                  //           // print(
                                  //           //     'contractYear ${DateFormat('MM/dd/yyyy').format(DateTime(
                                  //           //   int.parse(_contractRowYear.text
                                  //           //       .toString()),
                                  //           //   currentDate.month,
                                  //           //   currentDate.day,
                                  //           // ))}');
                                  //           print('budgetType $budgetType');
                                  //           print(
                                  //               'actionNeeded $substationName');
                                  //           print(
                                  //               'rowYear ${_rowYear.text.toString()}');
                                  //           print('tokenNo ${widget.tokenNo}');

                                  //           if (_formkey.currentState!
                                  //               .validate()) {
                                  //             print('substation $substationId');

                                  //             final userPreferences =
                                  //                 Provider.of<UserPref>(context,
                                  //                     listen: false);
                                  //             UserModel data =
                                  //                 await userPreferences
                                  //                     .getUser();

                                  //             String id =
                                  //                 data.user!.id.toString();

                                  //             Map mapData = {
                                  //               "substation": substationId,
                                  //               "feeder": feederId,
                                  //               "contractorCompay":
                                  //                   contractorCompany,
                                  //               "contractor":
                                  //                   (contractorCompany == 'LCP')
                                  //                       ? '48'
                                  //                       : assignFormanId,
                                  //               // "name1":_assignOtherForeman.toString(),
                                  //               "maintType": 'RegularMaint',
                                  //               "type": (maintenanceType ==
                                  //                       null)
                                  //                   ? 'JARAFF,MOWING,SPRAY WORK, JARAFF,MOWING,NO SPRAY, MOWING,NO SPRAY, MOWING, SPRAY, BUCKET WORK, GROUND WORK'
                                  //                   : maintenanceType,
                                  //               "cycle":
                                  //                   _rowCycle.text.toString(),
                                  //               "county": '',
                                  //               //modified on 23/04/2024 that '' will be passed in county
                                  //               //feederName need to be passed in county
                                  //               "maintDateHistory": "NA",
                                  //               "supervisor":
                                  //                   (contractorCompany == 'LCP')
                                  //                       ? 'ROBERT'
                                  //                       : selectedAssignForman,
                                  //               // (selectedAssignForman ==
                                  //               //         'Other')
                                  //               //     ? _assignOtherForeman
                                  //               //         .text
                                  //               //         .toString()
                                  //               //     : selectedAssignForman,
                                  //               "district": '',
                                  //               "planType":
                                  //                   "CUSTOM MAINTENANCE PLAN",
                                  //               "street": '',
                                  //               "createdBy": id.toString(),
                                  //               "budget": 0,
                                  //               // _budget.text.toString(),
                                  //               "totalCost": (_totalCost
                                  //                           .text.isEmpty ||
                                  //                       _totalCost.text == '')
                                  //                   ? 0.0
                                  //                   : double.parse((double
                                  //                           .parse(_totalCost
                                  //                               .text
                                  //                               .toString()))
                                  //                       .toStringAsFixed(2)),
                                  //               "costPerMile": (_costPerMile
                                  //                           .text.isEmpty ||
                                  //                       _costPerMile.text == '')
                                  //                   ? 0.0
                                  //                   : double.parse((double
                                  //                           .parse(_costPerMile
                                  //                               .text
                                  //                               .toString()))
                                  //                       .toStringAsFixed(2)),
                                  //               "totalMiles": double.parse(
                                  //                   (double.parse(_totalMiles
                                  //                           .text
                                  //                           .toString()))
                                  //                       .toStringAsFixed(2)),
                                  //               "maintCount": '',
                                  //               ////////////doubt//////////
                                  //               "contractEndYear":
                                  //                   _contractRowYear.text
                                  //                       .toString(),
                                  //               "nextMaintDue":
                                  //                   // year,
                                  //                   DateFormat('yyyy-MM-dd')
                                  //                       .format(DateTime(
                                  //                 int.parse(dynamicYear),
                                  //                 monthNumber,
                                  //                 // currentDate.month,
                                  //                 1,
                                  //                 // currentDate.day,
                                  //               )),
                                  //               /////////////commented on 04/05/2024/////////////////////////
                                  //               //   DateFormat('yyyy-MM-dd')
                                  //               //       .format(DateTime(
                                  //               // int.parse(_contractRowYear
                                  //               //     .text
                                  //               //     .toString()),
                                  //               // currentDate.month,
                                  //               // currentDate.day,
                                  //               // )),
                                  //               // '${_nextMaintYear.text.toString()}-02-09',//contract year---current year
                                  //               "lastMaintDone":
                                  //                   DateFormat('yyyy-MM-dd')
                                  //                       .format(DateTime(
                                  //                 int.parse(_contractRowYear
                                  //                     .text
                                  //                     .toString()),
                                  //                 currentDate.month,
                                  //                 currentDate.day,
                                  //               )),
                                  //               //contract year---current year
                                  //               "contractYear":
                                  //                   DateFormat('MM/dd/yyyy')
                                  //                       .format(DateTime(
                                  //                 int.parse(_contractRowYear
                                  //                     .text
                                  //                     .toString()),
                                  //                 currentDate.month,
                                  //                 currentDate.day,
                                  //               )), //contract year---current year
                                  //               "status": "PENDING",
                                  //               "budgetType": budgetType,
                                  //               "actionNeeded":
                                  //                   substationName, //substation Name need to be passed in actionNeeded
                                  //               "rowYear":
                                  //                   _rowYear.text.toString(),
                                  //               "tokenNo":
                                  //                   (widget.tokenNo == '')
                                  //                       ? '0'
                                  //                       : widget.tokenNo,
                                  //               /////////modified tokenNo on 7/05/2024 ///////////
                                  //             };
                                  //             print('API called.........');
                                  //             print(mapData);
                                  //             // addNewRowMaintenancePlanViewModel
                                  //             //     .fetchAddNewRowMaintenancePlanSubmitListApi(
                                  //             //         context, mapData);
                                  //             // addNewApi(mapData);

                                  //             print('name1');
                                  //             print((selectedAssignForman ==
                                  //                     'Other')
                                  //                 ? _assignOtherForeman.text
                                  //                     .toString()
                                  //                 : selectedAssignForman);
                                  //             // Future.delayed(
                                  //             //     const Duration(seconds: 5));
                                  //             // Future.delayed(
                                  //             //     const Duration(seconds: 2),
                                  //             //     () {
                                  //             //   setState(() {
                                  //             //     selectedSubstation = null;
                                  //             //     selectedFeeder = null;
                                  //             //     maintenanceType = null;
                                  //             //     _totalMiles.clear();
                                  //             //     _costPerMile.clear();
                                  //             //     _totalCost.clear();
                                  //             //     budgetType = null;
                                  //             //     _rowCycle.clear();
                                  //             //     _nextMaintYear.clear();
                                  //             //     _contractEndYear.clear();
                                  //             //     contractorCompany = null;
                                  //             //     selectedAssignForman = null;
                                  //             //   });
                                  //             // });
                                  //           } else {
                                  //             print(
                                  //                 "Please fill all mendetory fields!!!");
                                  //           }
                                  //         },
                                  //         child: Container(
                                  //           margin: const EdgeInsets.only(
                                  //               left: 40,
                                  //               right: 40,
                                  //               bottom: 10.0),
                                  //           padding: const EdgeInsets.all(8),
                                  //           alignment: Alignment.center,
                                  //           width: MediaQuery.of(context)
                                  //               .size
                                  //               .width,
                                  //           height: 40,
                                  //           decoration: BoxDecoration(
                                  //               // shape: BoxShape.circle,
                                  //               borderRadius:
                                  //                   BorderRadius.circular(10),
                                  //               boxShadow: const [
                                  //                 BoxShadow(
                                  //                     color: Color.fromARGB(
                                  //                         255, 3, 47, 97),
                                  //                     blurRadius: 5,
                                  //                     offset: Offset(2.0, 5.0))
                                  //               ],
                                  //               color: const Color.fromARGB(
                                  //                   255, 130, 193, 245),
                                  //               gradient: const LinearGradient(
                                  //                 colors: [
                                  //                   Color.fromARGB(
                                  //                       255, 7, 59, 120),
                                  //                   Color.fromARGB(
                                  //                       255, 7, 59, 120)
                                  //                 ],
                                  //               )),
                                  //           child: const Row(children: [
                                  //             Expanded(
                                  //               child: Align(
                                  //                 alignment: Alignment.center,
                                  //                 child: Text(
                                  //                   'Save Plan',
                                  //                   textAlign: TextAlign.left,
                                  //                   style: TextStyle(
                                  //                     color: Colors.white,
                                  //                     fontWeight:
                                  //                         FontWeight.bold,
                                  //                     fontSize: 20,
                                  //                   ),
                                  //                 ),
                                  //               ),
                                  //             ),
                                  //           ]),
                                  //         ),
                                  //       ),
                                  //     )),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );

              default:
                return const Text('data');
            }
          },
        ),
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
    value: item,
    child: Text(
      item,
      style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 20),
    ),
  );

  calculateTotalCost(
    double totalMiles,
    double costPerMiles,
    TextEditingController totalCostCTLR,
  ) {
    setState(() {
      double totalCost = 0.0;
      totalCost = totalMiles * costPerMiles;
      totalCostCTLR.text = totalCost.toStringAsFixed(2);
    });
  }

  calculateNextMaintenanceYear(
    int contractRowYear,
    int rowCycle,
    TextEditingController nextMaintenanceYearCTRL,
  ) {
    setState(() {
      int nextMaintenanceYear = 0;
      // contractRowYear = DateFormat("yyyy").format(DateTime.now()) as int;
      print(contractRowYear);
      nextMaintenanceYear = contractRowYear + rowCycle;
      nextMaintenanceYearCTRL.text = nextMaintenanceYear.toString();
    });
  }

  void onTextChanged() {
    print('Other selected on assign foreman11111111111111111111');
    name1 = _assignOtherForeman.text.toString();
    print('Other selected on assign foreman');
    print('name1');
    print('a');
    print(name1);
  }

  Future<void> fetchData(
    String substationId,
    String action,
    String name1,
    String supervisorId,
    String loginId,
    String substationName,
    String year,
    String feeder,
    String contractorCompany,
  ) async {
    addNewRowMaintenancePlanViewModel.fetchAddNewRowMaintenancePlanViewListApi(
      context,
      substationId,
      action,
      name1,
      supervisorId,
      loginId,
      substationName,
      year,
      feeder,
      'ZIELIES',
    );
    await Future.delayed(Duration(seconds: 2));
    // getTotalMiles();
  }

  String getFeederIdNameByName(String feederName) {
    var feederList = addNewRowMaintenancePlanViewModel
        .addNewRowMaintenancePlanList
        .data!
        .getIdAndFeederBySubstationId!;

    for (var feeder in feederList) {
      if (feeder.feeder.toString() == feederName) {
        feederName = feeder.feeder.toString();
        return feeder.id.toString();
      }
    }
    return 'Feeder Not Found';
  }

  String getSubstationNameById(String id) {
    var substationList = addNewRowMaintenancePlanViewModel
        .addNewRowMaintenancePlanList
        .data!
        .getIdAndSubstation!;

    for (var subStation in substationList) {
      if (subStation.id.toString() == id) {
        return subStation.subStation.toString();
      }
    }
    return 'Substation Not Found';
  }

  Future<String> getSubstationIdByName(String substationName) async {
    print('substationName000000000000000 $substationName');
    var substationList = addNewRowMaintenancePlanViewModel
        .addNewRowMaintenancePlanList
        .data!
        .getIdAndSubstation!;
    for (var subStation in substationList) {
      if (subStation.subStation.toString() == substationName) {
        print('subStation.id.toString() ${subStation.id.toString()}');
        substationId = int.parse(subStation.id.toString());
        print('newSubId : $substationId');
        // await Future.delayed(Duration(seconds: 5));
        if (widget.contractorCompany == 'LCP') {
          fetchData(
            subStation.id.toString(),
            'Get',
            '',
            '',
            '',
            substationName,
            widget.nextMaintYear,
            '',
            'LCP',
          );
        } else if (widget.contractorCompany == 'ZIELIES') {
          await fetchData(
            subStation.id.toString(),
            'Get',
            '',
            '',
            '',
            substationName,
            widget.nextMaintYear,
            '',
            'ZIELIES',
          );
        }
        await Future.delayed(Duration(seconds: 5));
        // fetchData(subStation.substationId.toString(), 'Get', '', '', '',
        //     substationName, widget.nextMaintYear, '', '');
        print('widget.feeder22 ${widget.feeder}');
        // if (widget.feeder != '' && widget.feeder != 'null') {
        //   String feeder = widget.feeder;

        //   int indexOfOpeningBracket = feeder.indexOf('(');
        //   if (indexOfOpeningBracket != -1) {
        //     feeder = feeder.substring(0, indexOfOpeningBracket).trim();
        //   }
        //   print('widget.feeder $feeder');

        //   //////////////////////////
        //   Future.delayed(const Duration(seconds: 6), () {
        //     if (addNewRowMaintenancePlanViewModel
        //                 .addNewRowMaintenancePlanList.data !=
        //             null &&
        //         addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanList
        //                 .data!.getIdAndFeederBySubstationId !=
        //             null) {
        //       if (widget.feeder != '') {
        //         addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanList
        //             .data!.getIdAndFeederBySubstationId!
        //             .forEach((a) {
        //           if (a.feeder == feeder.toString()) {
        //             setState(() {
        //               selectedFeeder = a.id.toString();
        //               feederId = int.parse(selectedFeeder);
        //             });
        //           }
        //         });
        //       }
        //     }
        //   });

        // }
        await fetchData(
          subStation.id.toString(),
          'Get',
          '',
          '',
          '',
          substationName,
          widget.nextMaintYear,
          '',
          widget.contractorCompany,
        );

        // ✅ NOW DATA IS GUARANTEED

        var feederList = addNewRowMaintenancePlanViewModel
            .addNewRowMaintenancePlanList
            .data!
            .getIdAndFeederBySubstationId;

        print("Feeder list length: ${feederList?.length}");

        if (widget.feeder != '' &&
            widget.feeder != 'null' &&
            feederList != null &&
            feederList.isNotEmpty) {
          String feeder = widget.feeder;

          if (feeder.contains('(')) {
            feeder = feeder.split('(')[0].trim();
          }

          for (var a in feederList) {
            String apiFeeder = a.feeder.toString();

            if (apiFeeder.contains('(')) {
              apiFeeder = apiFeeder.split('(')[0].trim();
            }

            print("Comparing API: $apiFeeder with Widget: $feeder");

            if (apiFeeder == feeder) {
              // ✅ FIXED LINE
              setState(() {
                selectedFeeder = a.feeder.toString();
                // feederId = int.parse(selectedFeeder);
                feederId = int.parse(a.id.toString()); // ✅ correct
              });

              print("✅ Feeder SET SUCCESS: $selectedFeeder");
              break;
            }
          }
        } else {
          print("❌ Feeder list EMPTY or NULL");
        }
        // Future.delayed(const Duration(seconds: 2), () {
        //   if (addNewRowMaintenancePlanViewModel
        //               .addNewRowMaintenancePlanList.data !=
        //           null &&
        //       addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanList
        //               .data!.getIdAndFeederBySubstationId !=
        //           null) {
        //     if (widget.feeder != '') {
        //       addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanList
        //           .data!.getIdAndFeederBySubstationId!
        //           .forEach((a) {
        //         if (a.feeder == feeder.toString()) {
        //           setState(() {
        //             selectedFeeder = a.id.toString();
        //             feederId = int.parse(selectedFeeder);
        //           });
        //         }
        //         print(
        //             'selectedFeeder111111111111111111111111111111 $selectedFeeder');
        //       });
        // }
        // }
        // });
        // ///////////////////////////////////////////
        return subStation.id.toString();
      }
    }
    return 'Substation Id Not Found';
  }

  static List<String> generateYearList() {
    DateTime now = DateTime.now();
    int currentYear = now.year;
    List<String> years = [];
    for (int i = currentYear - 5; i <= currentYear + 9; i++) {
      years.add(i.toString());
    }
    return years;
  }

  Future<void> _checkPermission(BuildContext context) async {
    FocusScope.of(context).requestFocus(FocusNode());
    Map<Permission, PermissionStatus> statues = await [
      Permission.camera,
      Permission.storage,
      Permission.photos,
    ].request();
    PermissionStatus? statusCamera = statues[Permission.camera];
    PermissionStatus? statusStorage;
    PermissionStatus? statusPhotos;
    if (Platform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      if (androidInfo.version.sdkInt <= 32) {
        statusStorage = statues[Permission.storage];

        /// use [Permissions.storage.status]
      } else {
        statusPhotos = statues[Permission.photos];

        /// use [Permissions.photos.status]
      }
    }

    bool isGranted =
        statusCamera == PermissionStatus.granted &&
            statusStorage == PermissionStatus.granted ||
        statusCamera == PermissionStatus.granted &&
            statusPhotos == PermissionStatus.granted;
    if (isGranted) {
      pickImageOptions();
      // _pickImages();
    }
    bool isPermanentlyDenied =
        statusCamera == PermissionStatus.permanentlyDenied ||
        statusStorage == PermissionStatus.permanentlyDenied ||
        statusPhotos == PermissionStatus.permanentlyDenied;
    if (isPermanentlyDenied) {
      // _showSettingsDialog(context);
    }
  }

  Future pickImageOptions() => showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            content: const SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    "Select image from",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Color.fromARGB(255, 7, 59, 120),
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        _pickImagesCamera();
                        Navigator.pop(context);
                      },
                      child: Container(
                        margin: const EdgeInsets.only(
                          left: 4,
                          right: 4,
                          bottom: 10.0,
                        ),
                        // padding: const EdgeInsets.all(8),
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        height: 40,
                        decoration: const BoxDecoration(
                          // shape: BoxShape.circle,
                          // borderRadius: BorderRadius.circular(25),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(255, 112, 68, 1),
                              blurRadius: 5,
                              offset: Offset(2.0, 5.0),
                            ),
                          ],
                          color: Colors.black,
                          gradient: LinearGradient(
                            colors: [Colors.orange, Colors.orange],
                          ),
                        ),
                        child: const Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Camera",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        _pickImagesGallery();
                        // _pickImagesAndDocuments();
                        Navigator.pop(context);
                      },
                      child: Container(
                        margin: const EdgeInsets.only(
                          left: 4,
                          right: 4,
                          bottom: 10.0,
                        ),
                        // padding: const EdgeInsets.all(8),
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        height: 40,
                        decoration: const BoxDecoration(
                          // shape: BoxShape.circle,
                          // borderRadius: BorderRadius.circular(25),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(255, 112, 68, 1),
                              blurRadius: 5,
                              offset: Offset(2.0, 5.0),
                            ),
                          ],
                          color: Colors.black,
                          gradient: LinearGradient(
                            colors: [Colors.orange, Colors.orange],
                          ),
                        ),
                        child: const Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Gallery",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        _uploadDocuments();
                        Navigator.pop(context);
                      },
                      child: Container(
                        margin: const EdgeInsets.only(
                          left: 4,
                          right: 4,
                          bottom: 10.0,
                        ),
                        // padding: const EdgeInsets.all(8),
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        height: 40,
                        decoration: const BoxDecoration(
                          // shape: BoxShape.circle,
                          // borderRadius: BorderRadius.circular(25),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(255, 112, 68, 1),
                              blurRadius: 5,
                              offset: Offset(2.0, 5.0),
                            ),
                          ],
                          color: Colors.black,
                          gradient: LinearGradient(
                            colors: [Colors.orange, Colors.orange],
                          ),
                        ),
                        child: const Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Document",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      );
    },
  );
  Future<void> _pickImagesCamera() async {
    final ImagePicker picker = ImagePicker();
    const ImageSource source = ImageSource.camera;
    List<String> chosenImagePaths = [];

    for (int i = 0; i < 3; i++) {
      final XFile? image = await picker.pickImage(
        source: source,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 100,
      );

      if (image != null) {
        chosenImagePaths.add(image.path);
      }
    }

    setState(() {
      for (int i = 0; i < chosenImagePaths.length; i++) {
        if (_imagePath.isEmpty) {
          _imagePath = chosenImagePaths[i];
          setState(() {
            _isVisibleImage = true;
          });
        } else if (_imagePath2.isEmpty) {
          _imagePath2 = chosenImagePaths[i];
          setState(() {
            _isVisibleImage2 = true;
          });
        } else if (_imagePath3.isEmpty) {
          _imagePath3 = chosenImagePaths[i];
          setState(() {
            _isVisibleImage3 = true;
          });
        } else {
          CustomToastSnackBarProgressDialog.toastMessage(
            'You can select a maximum of 3 images!',
          );
          break;
        }
      }
    });
  }

  Future<void> _pickImagesGallery() async {
    final ImagePicker picker = ImagePicker();
    List<String> chosenImagePaths = [];

    for (int i = 0; i < 3; i++) {
      final XFile? image = await picker.pickImage(
        source: ImageSource.gallery, // Set source to ImageSource.gallery only
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 100,
      );

      if (image != null) {
        chosenImagePaths.add(image.path);
      }
    }

    setState(() {
      for (int i = 0; i < chosenImagePaths.length; i++) {
        if (_imagePath.isEmpty) {
          _imagePath = chosenImagePaths[i];
          setState(() {
            _isVisibleImage = true;
          });
        } else if (_imagePath2.isEmpty) {
          _imagePath2 = chosenImagePaths[i];
          setState(() {
            _isVisibleImage2 = true;
          });
        } else if (_imagePath3.isEmpty) {
          _imagePath3 = chosenImagePaths[i];
          setState(() {
            _isVisibleImage3 = true;
          });
        } else {
          CustomToastSnackBarProgressDialog.toastMessage(
            'You can select a maximum of 3 images!',
          );
          break;
        }
      }
    });
  }

  // Future<void> _uploadDocuments() async {
  //   print('document upload');
  //   final FilePickerResult? documentResult =
  //       await FilePicker.platform.pickFiles(
  //     type: FileType.custom,
  //     allowedExtensions: ['pdf', 'doc', 'docx'],
  //     allowMultiple: true,
  //   );

  //   if (documentResult != null && documentResult.files.isNotEmpty) {
  //     List<String> chosenImagePaths = [];

  //     for (int i = 0; i < documentResult.files.length; i++) {
  //       if (chosenImagePaths.length < 3) {
  //         chosenImagePaths.add(documentResult.files[i].path!);
  //       } else {
  //         CustomToastSnackBarProgressDialog.toastMessage(
  //           'You can select a maximum of 3 documents!',
  //         );
  //         return;
  //       }
  //     }

  //     setState(() {
  //       for (int i = 0; i < chosenImagePaths.length; i++) {
  //         if (_imagePath.isEmpty) {
  //           _imagePath = chosenImagePaths[i];
  //           setState(() {
  //             _isVisibleImage = true;
  //           });
  //         } else if (_imagePath2.isEmpty) {
  //           _imagePath2 = chosenImagePaths[i];
  //           setState(() {
  //             _isVisibleImage2 = true;
  //           });
  //         } else if (_imagePath3.isEmpty) {
  //           _imagePath3 = chosenImagePaths[i];
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
  //   } else {
  //     CustomToastSnackBarProgressDialog.toastMessage(
  //       'Please select at least one document.',
  //     );
  //   }
  // }

  Future<void> _uploadDocuments() async {
    print('document upload');

    const XTypeGroup typeGroup = XTypeGroup(
      label: 'documents',
      extensions: ['pdf', 'doc', 'docx'],
    );

    try {
      final List<XFile> documentResult = await openFiles(
        acceptedTypeGroups: [typeGroup],
      );

      if (documentResult.isNotEmpty) {
        List<String> chosenDocumentPaths = [];

        for (int i = 0; i < documentResult.length; i++) {
          if (chosenDocumentPaths.length < 3) {
            chosenDocumentPaths.add(documentResult[i].path);
          } else {
            CustomToastSnackBarProgressDialog.toastMessage(
              'You can select a maximum of 3 documents!',
            );
            return;
          }
        }
        setState(() {
          for (int i = 0; i < chosenDocumentPaths.length; i++) {
            if (_imagePath.isEmpty) {
              _imagePath = chosenDocumentPaths[i];
              setState(() {
                _isVisibleImageDoc = true;
              });
            } else if (_imagePath2.isEmpty) {
              _imagePath2 = chosenDocumentPaths[i];
              setState(() {
                _isVisibleImage2Doc = true;
              });
            } else if (_imagePath3.isEmpty) {
              _imagePath3 = chosenDocumentPaths[i];
              setState(() {
                _isVisibleImage3Doc = true;
              });
            } else {
              CustomToastSnackBarProgressDialog.toastMessage(
                'You can select a maximum of 3 documents!',
              );
              break;
            }
          }
        });
      } else {
        CustomToastSnackBarProgressDialog.toastMessage(
          'Please select at least one document.',
        );
      }
    } catch (e) {
      print('Error occurred while picking documents: $e');
      CustomToastSnackBarProgressDialog.toastMessage(
        'Error occurred while picking documents: $e',
      );
    }
  }

  Future<void> deleteOnlineImageApi(String fileName) async {
    final apiUrl =
        'http://civmapi.ariespro.com/civmapi/changeOrderLcpCreateOrder/deleteFile?fileName=$fileName';
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();

    try {
      final response = await http.delete(
        Uri.parse(apiUrl),
        headers: {"Authorization": 'Bearer ${data.token!}'},
      );

      if (response.statusCode == 200) {
        setState(() {});
      } else {}
    } catch (e) {}
  }

  void setCycleAndYear(String year) {
    int yearValue = int.tryParse(year) ?? 0;
    int cycle = ((yearValue - 2014) ~/ 7) + 1;
    int yearInCycle = ((yearValue - 2014) % 7) + 1;
    _rowCycle.text = cycle.toString();
    _rowYear.text = yearInCycle.toString();
    getTotalMiles();
  }

  Future<void> addNewApi(Map mappedData) async {
    String apiUrl =
        'http://civmapi.ariespro.com/civmapi/vma_row_custom_main_plan/VMA_ROW_CUSTOMMAINTPLAN_INSERT';

    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${data.token}',
        },
        body: jsonEncode(mappedData),
      );

      if (response.statusCode == 200) {
        print('2000000000000000000000000000000000000000');
        CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
          'Successfully Submitted',
          context,
        );
        print('response.body ${response.body}');
        setState(() {
          selectedSubstation = null;
          selectedFeeder = null;
          maintenanceType = null;
          _totalMiles.clear();
          _costPerMile.clear();
          _totalCost.clear();
          budgetType = null;
          _rowCycle.clear();
          // _nextMaintYear.clear();
          _contractRowYear.clear();
          contractorCompany = null;
          selectedAssignForman = null;
        });

        if (_imagePath != '') {
          print('image path $_imagePath');
          Map<String, dynamic> jsonResponse = json.decode(response.body);
          print('jsonResponse: $jsonResponse');
          print('jsonResponse[message]: ${jsonResponse['message']}');
          if (jsonResponse['message'] == 'Successfully created civm map') {
            print('tokenNo111111 ${jsonResponse['tokenNo']}');
            print('00000000000000000000000000000000000000000');
            int tokenNo = jsonResponse['tokenNo'];
            print(tokenNo);
            print(_imagePath);
            submitImage(_imagePath, tokenNo.toString());
            // submitImage(_imagePath, jsonResponse['tokenNo']);
            print('1111111111111111111111111');
          }
        }
      } else {
        print('else case: ${response.body}');
      }
    } catch (error) {
      print('inside catch $error');
    }
  }

  Future<void> submitImage(String fileName, String tokenNo) async {
    print('submit image api11111111111');
    Directory tempDir = await getTemporaryDirectory();
    print('submit image 22222222222222222');
    String tempPath = tempDir.path;
    try {
      print('submit image 333333333333333333333');
      var uri = Uri.parse(
        "https://civm2.ariespro.com/civm2/contractorPanel/updateImageVEGETATION_CREW_FORMs",
      );
      var request = http.MultipartRequest("POST", uri);
      final userPreferences = Provider.of<UserPref>(context, listen: false);
      UserModel data = await userPreferences.getUser();
      print('submit image 4444444444444444444');
      var headers = {
        "Content-Type": "multipart/form-data",
        "Accept": "*/*",
        "Authorization": 'Bearer ${data.token!}',
      };
      // var stream1 = http.ByteStream(image.openRead());
      // // Get the file length
      // var length = await image.length();
      // Create a multipart file from the byte stream
      // var multipartFile1 = http.MultipartFile(
      //   'ClientDoc1', // Field name for the file
      //   stream1, // Byte stream of the file
      //   length, // Length of the file
      //   filename: basename(image.path), // Original file name
      // );
      // request.files.add(multipartFile1); // Add the single file to the request
      List<http.MultipartFile> newList = [];
      if (_imagePath != '') {
        print('submit image 4555555555555555555555');
        File img1 = new File(_imagePath);
        File file = await img1.copy(
          '${tempPath}/img_${DateFormat('yyyyMMddHHmmss').format(DateTime.now())}${_imagePath.contains('.pdf') ? '.pdf' : '.jpg'}',
        );
        print('submit image 666666666666666');
        var stream1 = http.ByteStream(file.openRead());
        var length1 = await file.length();
        // Get the file length
        var multipartFile = http.MultipartFile(
          "files",
          stream1,
          length1,
          filename: path.basename(file.path),
        );
        deleteImage1 = path.basename(file.path);
        newList.add(multipartFile);
      }

      if (_imagePath2 != '') {
        File img2 = new File(_imagePath2);
        File file2 = await img2.copy(
          '${tempPath}/img_${DateFormat('yyyyMMddHHmmss').format(DateTime.now())}2${_imagePath2.contains('.pdf') ? '.pdf' : '.jpg'}',
        );

        var stream2 = http.ByteStream(file2.openRead());
        var length2 = await file2.length();
        // Get the file length
        var multipartFile2 = http.MultipartFile(
          "files",
          stream2,
          length2,
          filename: path.basename(file2.path),
        );

        deleteImage2 = path.basename(file2.path);

        newList.add(multipartFile2);
      }

      if (_imagePath3 != '') {
        File img3 = new File(_imagePath3);
        File file3 = await img3.copy(
          '${tempPath}/img_${DateFormat('yyyyMMddHHmmss').format(DateTime.now())}3${_imagePath3.contains('.pdf') ? '.pdf' : '.jpg'}',
        );

        var stream3 = http.ByteStream(file3.openRead());
        var length3 = await file3.length();
        // Get the file length
        var multipartFile3 = http.MultipartFile(
          "files",
          stream3,
          length3,
          filename: path.basename(file3.path),
        );
        deleteImage3 = path.basename(file3.path);
        newList.add(multipartFile3);
      }

      if (newList.isNotEmpty) {
        request.files.addAll(newList); // Add the multiple file to the request
      }
      request.headers.addAll(headers);
      request.fields['tokenNo'] = tokenNo;
      // Send the request
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      // listen for response
      // streamedResponse.stream.transform(utf8.decoder).listen((value) {
      //   print(value);
      // });
      if (response.statusCode == 200) {
        print('image successfully uploaded...........');
        print(response.body);
        if (_imagePath != '') {
          setState(() {
            _isVisibleImage = true;
          });
        }

        if (_imagePath2 != '') {
          setState(() {
            _isVisibleImage2 = true;
          });
        }

        if (_imagePath3 != '') {
          setState(() {
            _isVisibleImage3 = true;
          });
        }
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) => const AdminAddNewRowTable(),
          ),
        );
      }
    } catch (e) {
      print('inside catch of image upload api.................');
    }
    _isVisibleImage = true;
  }

  Future<void> getData() async {
    print('widget.substaionName ${widget.subStation}');
    print('widget.nextMaintYear ${widget.nextMaintYear}');
    selectedyear = (widget.nextMaintYear == '') ? null : widget.nextMaintYear;
    fetchData(
      '',
      'Get',
      '',
      '',
      '',
      '',
      selectedyear,
      '',
      widget.contractorCompany,
    );
    await Future.delayed(Duration(seconds: 4));
    if (addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanList.data !=
            null &&
        addNewRowMaintenancePlanViewModel
                .addNewRowMaintenancePlanList
                .data!
                .substationList !=
            null) {
      print('widget.subStation00000000 ${widget.subStation}');
      // if (widget.subStation != '') {
      //   addNewRowMaintenancePlanViewModel
      //       .addNewRowMaintenancePlanList.data!.substationList!
      //       .forEach((a) {
      //     if (a.substationName == widget.subStation.toString()) {
      //       setState(() {
      //         selectedSubstation = a.substationId.toString();
      //       });
      //       print('selectedSubstation1234556 $selectedSubstation');
      //     }
      //   });
      //   substationName = getSubstationNameById(selectedSubstation);
      // }
      if (widget.subStation != '') {
        addNewRowMaintenancePlanViewModel
            .addNewRowMaintenancePlanList
            .data!
            .getIdAndSubstation!
            .forEach((a) {
              if (a.subStation == widget.subStation.toString()) {
                setState(() {
                  selectedSubstation = a.id.toString();
                });
              }
            });
        substationName = getSubstationNameById(selectedSubstation);
        print('substationName: $substationName');
      }
    }

    getSubstationIdByName(widget.subStation);
    print('widget.maintType ${widget.maintType}');
    _totalMiles.text = widget.totalMiles;
    _costPerMile.text = widget.costPerMile;
    _totalCost.text = widget.totalCost;
    print('widget.contractRowYear222222 ${widget.contractRowYear}');
    if (widget.contractRowYear.isNotEmpty) {
      DateTime parsedDate;
      String formattedYear;
      String processedInput = widget.contractRowYear.replaceAll(
        RegExp(r'[^0-9]'),
        '',
      );
      if (processedInput.length == 4 && int.tryParse(processedInput) != null) {
        parsedDate = DateTime(int.parse(processedInput));
        formattedYear = processedInput;
      } else {
        try {
          parsedDate = DateFormat(
            "MM/dd/yyyy",
          ).parseStrict(widget.contractRowYear);
          formattedYear = DateFormat("yyyy").format(parsedDate);
        } catch (e) {
          print("Error parsing date: $e");
          formattedYear = DateFormat("yyyy").format(DateTime.now());
        }
      }
      _contractRowYear.text = formattedYear;
    } else {
      _contractRowYear.text = DateFormat("yyyy").format(DateTime.now());
    }

    if (widget.nextMaintYear != '') {
      dynamicYear = widget.nextMaintYear.toString();
    }

    _rowYear.text = widget.rowYear;
    _rowCycle.text = widget.rowCycle;
    contractorCompany = 'ZIELIES';
    // (widget.contractorCompany == '' ||
    //         widget.contractorCompany == 'N/A' ||
    //         widget.contractorCompany == 'SELECT HERE')
    //     ? null
    //     : widget.contractorCompany;
    // fetchData(widget.subStation, 'Get', '', '', '', substationName,
    //     selectedyear, selectedFeeder, contractorCompany.toString());
    print('widget.assignForeman ${widget.assignForeman}');
    if (widget.contractorCompany == 'LCP') {
      _isVisibleAssignForeman = false;
    } else if (widget.contractorCompany == 'ZILIES') {
      _isVisibleAssignForeman = true;
    }
    await Future.delayed(const Duration(seconds: 3));
    // setState(() {
    //   selectedAssignForman = selectedAssignForman =
    //       (widget.assignForeman == '' || widget.assignForeman == 'N/A')
    //           ? null
    //           : widget.assignForeman;
    // });
    setState(() {
      final list = addNewRowMaintenancePlanViewModel
          .addNewRowMaintenancePlanList
          .data!
          .contractorGetInsert!;

      final exists = list.any((e) => e.name.toString() == widget.assignForeman);

      selectedAssignForman =
          (widget.assignForeman == '' ||
              widget.assignForeman == 'N/A' ||
              !exists)
          ? null
          : widget.assignForeman;
    });
    if (widget.budgetType != 'Mid Cycle maintenance' ||
        widget.budgetType != 'Mid Cycle Maintenance') {
      if (widget.budgetType == 'Regular IVM Maintenance') {
        setState(() {
          budgetType = 'Regular IVM maintenance';
        });
      } else {
        setState(() {
          budgetType =
              (widget.budgetType == '' ||
                  widget.budgetType == 'N/A' ||
                  widget.budgetType == 'SELECT HERE')
              ? null
              : widget.budgetType;
        });
      }
    }
    ///////////////////////////////////
    types = widget.maintType.split(', ').map((e) => e.trim()).toList();
    print('widget.maintType ${widget.maintType}');
    print('types $types');
    maintenanceType = widget.maintType;
    String? newMaintenanceType = types.isEmpty ? null : types.join(', ');
    print('newMaintenanceType $newMaintenanceType');
    if (newMaintenanceType != maintenanceType) {
      setState(() {
        maintenanceType = newMaintenanceType;
      });
    }
    ///////////////////////////////////
  }

  IconData getFileTypeIcon(String filePath) {
    if (filePath.endsWith('.pdf')) {
      return Icons.picture_as_pdf;
    } else if (filePath.endsWith('.doc') || filePath.endsWith('.docx')) {
      return Icons.description;
    } else {
      return Icons.insert_drive_file;
    }
  }

  getTotalMiles() {
    print('inside getTotalMiles');
    _totalMiles.text =
        (addNewRowMaintenancePlanViewModel
                .addNewRowMaintenancePlanList
                .data!
                .totalMiles ==
            null)
        ? ''
        : double.parse(
            addNewRowMaintenancePlanViewModel
                .addNewRowMaintenancePlanList
                .data!
                .totalMiles
                .toString(),
          ).toStringAsFixed(2);

    print('_totalMiles.text ${_totalMiles.text}');
  }

  // Future<String?> getMonthFromNextMaintDue(String tokenNo) async {
  //   final url =
  //       'https://civm2.ariespro.com/civm2/rowMaintenancePlanTabViewAndDashboard/getMonthFromNextMaintDueFromTokenNo?tokenNo=$tokenNo';
  //   final userPreferences = Provider.of<UserPref>(context, listen: false);
  //   UserModel data = await userPreferences.getUser();
  //   final headers = {
  //     'Authorization': 'Bearer ${data.token!}',
  //   };

  //   try {
  //     final response = await http.get(Uri.parse(url), headers: headers);

  //     if (response.statusCode == 200) {
  //       final data = json.decode(response.body);
  //       final monthDynamic = data['month'];
  //       print('month11111111111111: $monthDynamic');
  //       if (monthDynamic != null && monthDynamic != 'null') {
  //         if (monthDynamic == 'Jan' ||
  //             monthDynamic == 'Feb' ||
  //             monthDynamic == 'Mar' ||
  //             monthDynamic == 'Apr' ||
  //             monthDynamic == 'May' ||
  //             monthDynamic == 'Jun' ||
  //             monthDynamic == 'Jul' ||
  //             monthDynamic == 'Aug' ||
  //             monthDynamic == 'Sep' ||
  //             monthDynamic == 'Oct' ||
  //             monthDynamic == 'Nov' ||
  //             monthDynamic == 'Dec') {
  //           setState(() {
  //             month = monthDynamic;
  //           });

  //           if (monthDynamic == 'Jan') {
  //             monthNumber = 01;
  //           } else if (monthDynamic == 'Feb') {
  //             monthNumber = 02;
  //           } else if (monthDynamic == 'Mar') {
  //             monthNumber = 03;
  //           } else if (monthDynamic == 'Apr') {
  //             monthNumber = 04;
  //           } else if (monthDynamic == 'May') {
  //             monthNumber = 05;
  //           } else if (monthDynamic == 'Jun') {
  //             monthNumber = 06;
  //           } else if (monthDynamic == 'Jul') {
  //             monthNumber = 07;
  //           } else if (monthDynamic == 'Aug') {
  //             monthNumber = 08;
  //           } else if (monthDynamic == 'Sep') {
  //             monthNumber = 09;
  //           } else if (monthDynamic == 'Oct') {
  //             monthNumber = 10;
  //           } else if (monthDynamic == 'Nov') {
  //             monthNumber = 11;
  //           } else if (monthDynamic == 'Dec') {
  //             monthNumber = 12;
  //           }
  //         }
  //       }
  //       return month;
  //     } else {
  //       print('Failed to load data: ${response.statusCode}');
  //       return null;
  //     }
  //   } catch (e) {
  //     print('Error: $e');
  //     return null;
  //   }
  // }
}

// ignore: must_be_immutable
class DrawerManu extends StatefulWidget {
  List<String> menu;
  DrawerManu({Key? key, required this.menu}) : super(key: key);

  @override
  State<DrawerManu> createState() => _DrawerManuState();
}

class _DrawerManuState extends State<DrawerManu> {
  String userName = '';
  String? _imagePath;

  @override
  void initState() {
    setUserName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userPreferences = Provider.of<UserPref>(context);
    var provider = Provider.of<LocationProvider>(context, listen: true);
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 7, 59, 120),
            ),
            child: Column(
              children: [
                menuLogoLCP(),
                Padding(
                  padding: const EdgeInsets.only(top: 6.0),
                  child: Text(
                    userName,
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          // ListTile(
          //   leading: const Icon(
          //     Icons.computer,
          //   ),
          //   title: const Text('Row Maintenance Plan'),
          //   textColor: const Color.fromARGB(255, 7, 59, 120),
          //   iconColor: const Color.fromARGB(255, 7, 59, 120),
          //   onTap: () {
          //     Navigator.of(context).push(MaterialPageRoute(
          //         builder: (BuildContext context) =>
          //             const EnergyAuditPannel()));
          //   },
          // ),
          // ListTile(
          //   leading: const Icon(
          //     Icons.compare,
          //   ),
          //   title: const Text('Inspection'),
          //   textColor: const Color.fromARGB(255, 7, 59, 120),
          //   iconColor: const Color.fromARGB(255, 7, 59, 120),
          //   onTap: () {
          //     Navigator.of(context).push(MaterialPageRoute(
          //         builder: (BuildContext context) =>
          //             const InspectionZielies()));
          //   },
          // ),
           ListTile(
            leading: const Icon(Icons.open_in_new),
            title: const Text('IVM Maintenance Progress'),
            textColor: const Color.fromARGB(255, 7, 59, 120),
            iconColor: const Color.fromARGB(255, 7, 59, 120),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => const EnergyAuditPannel(),
                ),
              );
              // Navigator.of(context).push(MaterialPageRoute(
              //     builder: (BuildContext context) =>
              //         const RowMaintenanceProgress()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.pending),
            title: const Text('Change Order Job List'),
            textColor: const Color.fromARGB(255, 7, 59, 120),
            iconColor: const Color.fromARGB(255, 7, 59, 120),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) =>
                      AdminChangeOrderAllStatus(source: ''),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.airplane_ticket_sharp),
            title: const Text('IVM Maintenance Job List'),
            textColor: const Color.fromARGB(255, 7, 59, 120),
            iconColor: const Color.fromARGB(255, 7, 59, 120),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          //  ListTile(
          //     leading: const Icon(
          //       Icons.settings_applications_sharp,
          //     ),
          //     title: const Text('Maintenance Report View'),
          //     textColor: const Color.fromARGB(255, 7, 59, 120),
          //     iconColor: const Color.fromARGB(255, 7, 59, 120),
          //     onTap: () {
          //      Navigator.of(context).push(MaterialPageRoute(
          //           builder: (BuildContext context) =>
          //               const AdminMaintenanceReportViewNew()));
          //     },
          //   ),
         

          // ),
          // ListTile(
          //   leading: const Icon(
          //     Icons.closed_caption_off,
          //   ),
          //   title: const Text('Row Analytics Dashboard'),
          //   textColor: const Color.fromARGB(255, 7, 59, 120),
          //   iconColor: const Color.fromARGB(255, 7, 59, 120),
          //   onTap: () {
          //     Navigator.of(context).push(MaterialPageRoute(
          //         builder: (BuildContext context) =>
          //             const RowAnalyticsDashboard()));
          //   },
          // ),
          // ListTile(
          //   leading: const Icon(
          //     Icons.data_usage,
          //   ),
          //   title: const Text('Budget Planning'),
          //   textColor: const Color.fromARGB(255, 7, 59, 120),
          //   iconColor: const Color.fromARGB(255, 7, 59, 120),
          //   onTap: () {
          //     Navigator.of(context).push(MaterialPageRoute(
          //         builder: (BuildContext context) => const BudgetPlanning()));
          //   },
          // ),
          ListTile(
            leading: const Icon(Icons.location_on),
            title: const Text('Live IVM System Map'),
            textColor: const Color.fromARGB(255, 7, 59, 120),
            iconColor: const Color.fromARGB(255, 7, 59, 120),
            onTap: () {
              provider.getLocation();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const MapScreenLeafLat(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.group_add),
            title: const Text('User Management'),
            textColor: const Color.fromARGB(255, 7, 59, 120),
            iconColor: const Color.fromARGB(255, 7, 59, 120),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => const UserManagementTabs(),
                ),
              );
            },
          ),
          // ListTile(
          //   leading: const Icon(
          //     Icons.check,
          //   ),
          //   title: const Text('Approve CIVM Access'),
          //   textColor: const Color.fromARGB(255, 7, 59, 120),
          //   iconColor: const Color.fromARGB(255, 7, 59, 120),
          //   onTap: () {
          //     Navigator.of(context).push(MaterialPageRoute(
          //         builder: (BuildContext context) =>
          //             const ApproveCIVMAccess()));
          //   },
          // ),
          // ListTile(
          //   leading: const Icon(
          //     Icons.add,
          //   ),
          //   title: const Text('Add Crew Member'),
          //   textColor: const Color.fromARGB(255, 7, 59, 120),
          //   iconColor: const Color.fromARGB(255, 7, 59, 120),
          //   onTap: () {
          //     Navigator.of(context).push(MaterialPageRoute(
          //         builder: (BuildContext context) => const AddCrewMember()));
          //   },
          // ),
          // ListTile(
          //     leading: const Icon(
          //       Icons.group_add,
          //     ),
          //     title: const Text('Add Planner/GF'),
          //     textColor: const Color.fromARGB(255, 7, 59, 120),
          //     iconColor: const Color.fromARGB(255, 7, 59, 120),
          //     onTap: () {
          //       Navigator.of(context).push(MaterialPageRoute(
          //           builder: (BuildContext context) => const AdminAddPlannerGFMemberCardData()));
          //     },
          //   ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            textColor: const Color.fromARGB(255, 7, 59, 120),
            iconColor: const Color.fromARGB(255, 7, 59, 120),
            onTap: () {
              // Constants.prefs.setBool("LoggedIn", false);
              userPreferences.remove().then((value) {
                // ignore: use_build_context_synchronously
                // Navigator.pushReplacement(context, RoutesName.login);
                // Navigator.pushNamed(
                //     context, RoutesName.login);
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) => const LoginPage(),
                  ),
                );
              });
              // Navigator.of(context).push(MaterialPageRoute(
              //     builder: (BuildContext context) => const LoginPage()));
            },
          ),
        ],
      ),
    );
  }

  Future<void> setUserName() async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();

    Image.network(
      'https://civm.ariespro.com/assets/clientuploads/${data.user!.profilePhoto}',
    );
    String imageUrl =
        'https://civm.ariespro.com/assets/clientuploads/${data.user!.profilePhoto}';
    _imagePath = imageUrl;
    setState(() {
      userName = '${data.user!.fName} ${data.user!.lName}';
    });
  }
}
