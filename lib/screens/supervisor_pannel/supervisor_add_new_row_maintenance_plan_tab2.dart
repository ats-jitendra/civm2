import 'package:CIVM/models/add_new_row_maintenance_plan_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import 'package:provider/provider.dart';
import '../../../data/response/status.dart';
import '../../../view_model/add_new_row_maintenance_plan_view_model.dart';

// ignore: must_be_immutable
class SupervisorAddNewRowMaintenancePlanTab2 extends StatefulWidget {
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
  SupervisorAddNewRowMaintenancePlanTab2({
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
  State<SupervisorAddNewRowMaintenancePlanTab2> createState() =>
      _SupervisorAddNewRowMaintenancePlanTab2State();
}

class _SupervisorAddNewRowMaintenancePlanTab2State
    extends State<SupervisorAddNewRowMaintenancePlanTab2> {
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

  bool _isVisibleAssignForeman = true;
  int loadingIndex = 0;

  final TextEditingController _totalMiles = TextEditingController();
  final TextEditingController _costPerMile = TextEditingController();
  final TextEditingController _totalCost = TextEditingController();
  // final TextEditingController _budget = TextEditingController();
  late final TextEditingController _contractRowYear = TextEditingController();
  // final TextEditingController _contractEndYear = TextEditingController();
  final TextEditingController _rowCycle = TextEditingController();
  final TextEditingController _assignOtherForeman = TextEditingController();
  final TextEditingController _nextMaintYear = TextEditingController();

  bool _isVisibleAssignOtherForeman = false;

  String name1 = '';

  // ignore: non_constant_identifier_names
  final select_contractorCompany = [
    // 'LCP',
    'ZIELIES',
  ];
  String? contractorCompany;

  // ignore: non_constant_identifier_names
  final select_budgetType = [
    // 'Regular IVM maintenance',
    'Mid Cycle maintenance'
  ];
  String? budgetType;

  String a = '';

  final _formkey = GlobalKey<FormState>();
  List countyList = [];
  List substationList = [];
  List feederList = [];
  // ignore: prefer_typing_uninitialized_variables
  var selectedSubstation;
  // ignore: prefer_typing_uninitialized_variables
  var selectedCounty;
  // ignore: prefer_typing_uninitialized_variables
  var selectedFeeder;
  // ignore: prefer_typing_uninitialized_variables
  var selectedAssignForman;

  // ignore: non_constant_identifier_names
  List<String> select_maintenanceType = [
    // 'JARAFF,MOWING,SPRAY WORK',
    // 'JARAFF,MOWING,NO SPRAY',
    // 'MOWING,NO SPRAY',
    // 'MOWING',
    // 'SPRAY',
    // 'BUCKET WORK',
    // 'GROUND WORK',
    'CROSS-COUNTRY SPRAY',
    'ROADSIDE SPRAY',
    'NO SPRAY',
  ];
  String? maintenanceType = 'CROSS-COUNTRY SPRAY';

  List<String> types = ['CROSS-COUNTRY SPRAY'];

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

  @override
  void initState() {
    addNewRowMaintenancePlanViewModel.fetchAddNewRowMaintenancePlanViewListApi(
        context, '0', 'Get', '', '', '', '', '', '', '');
    // getData();
    super.initState();
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
                  return
                      // CustomToastSnackBarProgressDialog.flushBarErrorMessage(
                      //     value.addNewRowMaintenancePlanList.message.toString(),
                      //     context);
                      Padding(
                    padding: const EdgeInsets.only(
                        top: 16.0, bottom: 16, left: 8, right: 8),
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
                                left: 8, right: 8, top: 10, bottom: 8),
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
                                      offset: Offset(2.0, 5.0))
                                ],
                                gradient: LinearGradient(
                                  colors: [
                                    Color.fromARGB(255, 255, 255, 255),
                                    Color.fromARGB(255, 255, 255, 255),
                                  ],
                                )),
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
                                              color: Color.fromARGB(
                                                  255, 3, 47, 97),
                                              blurRadius: 5,
                                              offset: Offset(2.0, 5.0))
                                        ],
                                        color:
                                            Color.fromARGB(255, 130, 193, 245),
                                        gradient: LinearGradient(
                                          colors: [
                                            Color.fromARGB(255, 7, 59, 120),
                                            Color.fromARGB(255, 7, 59, 120)
                                          ],
                                        )),
                                    child: const Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "MIDCYCLE HERBICIDE WORK PLAN",
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
                                        top: 10.0),
                                    child: Row(
                                      children: [
                                        const Expanded(
                                          child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "NEXT MAINT YEAR",
                                                style: TextStyle(
                                                    fontSize: 16.0,
                                                    color: Color.fromARGB(
                                                        255, 7, 59, 120),
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                        ),
                                        Expanded(
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              child: TextFormField(
                                                enabled: false,
                                                // key: formkey10,
                                                controller: _nextMaintYear,
                                                style: const TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 7, 59, 120),
                                                    fontSize: 16),
                                                obscureText: false,
                                                decoration:
                                                    const InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  disabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Color.fromARGB(
                                                          255, 7, 59, 120),
                                                    ),
                                                  ),
                                                  hintText: '0',
                                                ),
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return "Please enter next maint year";
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
                                        top: 10.0),
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
                                                        255, 7, 59, 120),
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                        ),
                                        Expanded(
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              child: DropdownButtonFormField<
                                                  String>(
                                                hint: const Text('-Select-'),
                                                dropdownColor: Colors.white,
                                                value: selectedSubstation,
                                                style: const TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 7, 59, 120),
                                                    fontSize: 16),
                                                icon: const Icon(
                                                  Icons.arrow_drop_down,
                                                  color: Color.fromARGB(
                                                      255, 7, 59, 120),
                                                  size: 40,
                                                ),
                                                decoration:
                                                    const InputDecoration(
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Color.fromARGB(
                                                          255, 7, 59, 120),
                                                    ),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Color.fromARGB(
                                                          255, 7, 59, 120),
                                                    ),
                                                  ),
                                                ),
                                                isExpanded: true,
                                                items: addNewRowMaintenancePlanViewModel
                                                    .addNewRowMaintenancePlanList
                                                    .data!
                                                    .getIdAndSubstation!
                                                    .map((e) {
                                                  return DropdownMenuItem(
                                                    value: e.id.toString(),
                                                    // e.getIdAndSubstationByCountId![0].subStation.toString(),
                                                    child: Text(e.subStation
                                                        .toString()),
                                                  );
                                                }).toList(),
                                                onChanged: (val) {
                                                  if (selectedFeeder != null) {
                                                    selectedFeeder = null;
                                                  }
                                                  print(getSubstationNameById(
                                                      val!));
                                                  substationName =
                                                      getSubstationNameById(
                                                          val);
                                                  print('val');
                                                  print(val);
                                                  fetchData(
                                                      val,
                                                      'Get',
                                                      '',
                                                      '',
                                                      '',
                                                      substationName,
                                                      '',
                                                      '',
                                                      '');
                                                  substationId = int.parse(val);
                                                  print('111111111111111');
                                                  print(addNewRowMaintenancePlanViewModel
                                                      .addNewRowMaintenancePlanList
                                                      .data!
                                                      .getCostPerMileBySubstation
                                                      .toString());
                                                  setState(() async {
                                                    selectedSubstation = val;
                                                    await Future.delayed(
                                                        const Duration(
                                                            seconds: 5));
                                                    _costPerMile
                                                        .text = (addNewRowMaintenancePlanViewModel
                                                                .addNewRowMaintenancePlanList
                                                                .data!
                                                                .getCostPerMileBySubstation
                                                                .toString() ==
                                                            'null')
                                                        ? '0'
                                                        : addNewRowMaintenancePlanViewModel
                                                            .addNewRowMaintenancePlanList
                                                            .data!
                                                            .getCostPerMileBySubstation
                                                            .toString();
                                                  });
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
                                        top: 10.0),
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
                                                        255, 7, 59, 120),
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                        ),
                                        Expanded(
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              child: DropdownButtonFormField<
                                                  String>(
                                                hint: const Text('-Select-'),
                                                dropdownColor: Colors.white,
                                                value: selectedFeeder,
                                                style: const TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 7, 59, 120),
                                                    fontSize: 16),
                                                icon: const Icon(
                                                  Icons.arrow_drop_down,
                                                  color: Color.fromARGB(
                                                      255, 7, 59, 120),
                                                  size: 40,
                                                ),
                                                decoration:
                                                    const InputDecoration(
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Color.fromARGB(
                                                          255, 7, 59, 120),
                                                    ),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Color.fromARGB(
                                                          255, 7, 59, 120),
                                                    ),
                                                  ),
                                                ),
                                                isExpanded: true,
                                                items: addNewRowMaintenancePlanViewModel
                                                    .addNewRowMaintenancePlanList
                                                    .data!
                                                    .getIdAndFeederBySubstationId!
                                                    .map((e) {
                                                  return DropdownMenuItem(
                                                    value: e.id.toString(),
                                                    child: Text(
                                                        e.feeder.toString()),
                                                  );
                                                }).toList(),
                                                onChanged: (val) {
                                                  print('val');
                                                  print(
                                                      getFeederNameById(val!));
                                                  feederName =
                                                      getFeederNameById(val);
                                                  feederId = int.parse(val);
                                                  setState(() {
                                                    selectedFeeder = val;
                                                    print(selectedFeeder);
                                                  });
                                                  fetchData(
                                                      selectedSubstation,
                                                      'Get',
                                                      '',
                                                      '',
                                                      '',
                                                      substationName,
                                                      '',
                                                      val,
                                                      '');
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
                                        top: 10.0),
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
                                                        255, 7, 59, 120),
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                        ),
                                        // Expanded(
                                        //   child: Align(
                                        //     alignment: Alignment.centerRight,
                                        //     child: Padding(
                                        //       padding:
                                        //           const EdgeInsets.all(2.0),
                                        //       child: Container(
                                        //         padding:
                                        //             const EdgeInsets.symmetric(
                                        //                 horizontal: 12,
                                        //                 vertical: 4),
                                        //         decoration: BoxDecoration(
                                        //           // borderRadius:
                                        //           //     BorderRadius.circular(25),
                                        //           border: Border.all(
                                        //             color: const Color.fromARGB(
                                        //                 255, 7, 59, 120),
                                        //           ),
                                        //         ),
                                        //         child: MultiSelectDialogField(
                                        //           initialValue: types,
                                        //           items: select_maintenanceType
                                        //               .map((e) =>
                                        //                   MultiSelectItem(e, e))
                                        //               .toList(),
                                        //           listType:
                                        //               MultiSelectListType.CHIP,
                                        //           onConfirm: (value) {
                                        //             setState(() {
                                        //               maintenanceType =
                                        //                   value.join(', ');
                                        //               types.add(
                                        //                   value.toString());
                                        //             });
                                        //           },
                                        //           validator: (value) =>
                                        //               value == null
                                        //                   ? 'field required'
                                        //                   : null,
                                        //         ),
                                        //       ),
                                        //     ),
                                        //   ),
                                        // ),

                                        Expanded(
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 12,
                                                        vertical: 4),
                                                decoration: BoxDecoration(
                                                  // borderRadius:
                                                  //     BorderRadius.circular(25),
                                                  border: Border.all(
                                                    color: const Color.fromARGB(
                                                        255, 7, 59, 120),
                                                  ),
                                                ),
                                                child: MultiSelectDialogField(
                                                  initialValue:
                                                      types, // Ensure this list is correct
                                                  items: select_maintenanceType
                                                      .map((e) =>
                                                          MultiSelectItem(e, e))
                                                      .toList(),
                                                  listType:
                                                      MultiSelectListType.CHIP,
                                                  onConfirm:
                                                      (List<dynamic> value) {
                                                    // Use List<dynamic> as the type
                                                    setState(() {
                                                      maintenanceType =
                                                          value.join(', ');
                                                      // types.add(
                                                      //     value.toString());
                                                    });
                                                    print(
                                                        maintenanceType); // This should print the selected values
                                                  },
                                                  validator: (value) => value ==
                                                          null
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
                                        top: 10.0),
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
                                                        255, 7, 59, 120),
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                        ),
                                        Expanded(
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              child: TextFormField(
                                                inputFormatters: [
                                                  FilteringTextInputFormatter
                                                      .deny(RegExp(r'-')),
                                                ],
                                                //key: formkey4,
                                                controller: _totalMiles,
                                                style: const TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 7, 59, 120),
                                                    fontSize: 16),
                                                obscureText: false,
                                                // keyboardType:
                                                //     TextInputType.number,
                                                keyboardType:
                                                    const TextInputType
                                                        .numberWithOptions(
                                                  decimal: true,
                                                  signed: false,
                                                ),
                                                decoration:
                                                    const InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Color.fromARGB(
                                                          255, 7, 59, 120),
                                                    ),
                                                  ),
                                                  hintText: '0',
                                                ),
                                                onChanged: (value) {
                                                  setState(() {
                                                    calculateTotalCost(
                                                      double.parse(value),
                                                      double.parse(
                                                          _costPerMile.text),
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
                                        top: 10.0),
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
                                                        255, 7, 59, 120),
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                        ),
                                        Expanded(
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              child: TextFormField(
                                                inputFormatters: [
                                                  FilteringTextInputFormatter
                                                      .deny(RegExp(r'-')),
                                                ],
                                                //  key: formkey5,
                                                controller: _costPerMile,
                                                style: const TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 7, 59, 120),
                                                    fontSize: 16),
                                                obscureText: false,
                                                // keyboardType:
                                                //     TextInputType.number,
                                                keyboardType:
                                                    const TextInputType
                                                        .numberWithOptions(
                                                  decimal: true,
                                                  signed: false,
                                                ),
                                                decoration:
                                                    const InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Color.fromARGB(
                                                          255, 7, 59, 120),
                                                    ),
                                                  ),
                                                  hintText: '0',
                                                ),
                                                onChanged: (value) {
                                                  setState(() {
                                                    calculateTotalCost(
                                                      double.parse(
                                                          _totalMiles.text),
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
                                        top: 10.0),
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
                                                        255, 7, 59, 120),
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                        ),
                                        Expanded(
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              child: TextFormField(
                                                enabled: false,
                                                // key: formkey6,
                                                controller: _totalCost,
                                                style: const TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 7, 59, 120),
                                                    fontSize: 16),
                                                obscureText: false,
                                                keyboardType:
                                                    TextInputType.number,
                                                decoration:
                                                    const InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  disabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Color.fromARGB(
                                                          255, 7, 59, 120),
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
                                        top: 10.0),
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
                                                        255, 7, 59, 120),
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                        ),
                                        Expanded(
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              child: DropdownButtonFormField<
                                                  String>(
                                                hint: const Text('-Select-'),
                                                dropdownColor: Colors.white,
                                                value: budgetType,
                                                style: const TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 7, 59, 120),
                                                    fontSize: 16),
                                                icon: const Icon(
                                                  Icons.arrow_drop_down,
                                                  color: Color.fromARGB(
                                                      255, 7, 59, 120),
                                                  size: 40,
                                                ),
                                                decoration:
                                                    const InputDecoration(
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Color.fromARGB(
                                                          255, 7, 59, 120),
                                                    ),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Color.fromARGB(
                                                          255, 7, 59, 120),
                                                    ),
                                                  ),
                                                ),
                                                isExpanded: true,
                                                items: select_budgetType
                                                    .map(buildMenuItem)
                                                    .toList(),
                                                onChanged: (value) => setState(
                                                    () => budgetType = value),
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
                                  //                   calculateNextMaintenanceYear(
                                  //                     int.parse(value),
                                  //                     // 2023,
                                  //                     7,
                                  //                     // int.parse(_rowCycle.text),
                                  //                     _nextMaintYear,
                                  //                   );
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
                                        top: 10.0),
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
                                                        255, 7, 59, 120),
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                        ),
                                        Expanded(
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              child: TextFormField(
                                                enabled: false,
                                                inputFormatters: [
                                                  FilteringTextInputFormatter
                                                      .deny(RegExp(r'-')),
                                                ],
                                                // key: formkey9,
                                                controller: _rowCycle,
                                                style: const TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 7, 59, 120),
                                                    fontSize: 16),
                                                obscureText: false,
                                                keyboardType:
                                                    TextInputType.number,
                                                decoration:
                                                    const InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  disabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Color.fromARGB(
                                                            255, 7, 59, 120)),
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
                                        top: 10.0),
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
                                                        255, 7, 59, 120),
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                        ),
                                        Expanded(
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              child: DropdownButtonFormField<
                                                  String>(
                                                hint: const Text('-Select-'),
                                                dropdownColor: Colors.white,
                                                value: contractorCompany,
                                                style: const TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 7, 59, 120),
                                                    fontSize: 16),
                                                icon: const Icon(
                                                  Icons.arrow_drop_down,
                                                  color: Color.fromARGB(
                                                      255, 7, 59, 120),
                                                  size: 40,
                                                ),
                                                decoration:
                                                    const InputDecoration(
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Color.fromARGB(
                                                          255, 7, 59, 120),
                                                    ),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Color.fromARGB(
                                                          255, 7, 59, 120),
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
                                                      '',
                                                      selectedFeeder,
                                                      contractorCompany
                                                          .toString());
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
                                          top: 10.0),
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
                                                          255, 7, 59, 120),
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )),
                                          ),
                                          Expanded(
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(2.0),
                                                child: DropdownButtonFormField<
                                                    String>(
                                                  hint: const Text('-Select-'),
                                                  dropdownColor: Colors.white,
                                                  value: selectedAssignForman,
                                                  style: const TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 7, 59, 120),
                                                      fontSize: 16),
                                                  icon: const Icon(
                                                    Icons.arrow_drop_down,
                                                    color: Color.fromARGB(
                                                        255, 7, 59, 120),
                                                    size: 40,
                                                  ),
                                                  decoration:
                                                      const InputDecoration(
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Color.fromARGB(
                                                            255, 7, 59, 120),
                                                      ),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Color.fromARGB(
                                                            255, 7, 59, 120),
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
                                                      value: e.name.toString(),
                                                      child: Text(
                                                          e.name.toString()),
                                                    );
                                                  }).toList(),
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
                                                        '22222222222222222222222');
                                                    print(selectedAssignForman);
                                                    loginIdList?.forEach(
                                                        (ContractorGetInsert
                                                            a) {
                                                      if (a.name ==
                                                          selectedAssignForman) {
                                                        assignFormanId =
                                                            a.loginId!;
                                                        print(
                                                            'assignFormanId11111111111111111111111');
                                                        print(assignFormanId);
                                                        print(
                                                            'selectedAssignForman.............');
                                                        print(
                                                            selectedAssignForman);
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
                                                          'name1....other not selected');
                                                      print(name1);

                                                      print(
                                                          'Getting Supervisor Id............');

                                                      print(
                                                          '11111111111111111111111111111111');
                                                    } else {
                                                      _isVisibleAssignOtherForeman =
                                                          true;
                                                      name1 =
                                                          _assignOtherForeman
                                                              .text
                                                              .toString();
                                                      print(
                                                          'name1....other selected');
                                                      print(name1);
                                                      print(
                                                          'before other foreman entered');

                                                      print(
                                                          'after other foreman entered');
                                                      print(_assignOtherForeman
                                                          .text
                                                          .toString());
                                                    }
                                                    print(
                                                        'aaaaaaaaaaaaaaaaaaaaaa');
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
                                              left: 180),
                                          child: TextFormField(
                                            //  key: formkey5,
                                            controller: _assignOtherForeman,
                                            onEditingComplete: onTextChanged,
                                            style: const TextStyle(
                                                color: Color.fromARGB(
                                                    255, 7, 59, 120),
                                                fontSize: 16),
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
                                                      255, 7, 59, 120),
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
                                  //           if (_formkey.currentState!
                                  //               .validate()) {
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
                                  //               "type": maintenanceType,
                                  //               "cycle": 7,
                                  //               //  0,
                                  //               // _rowCycle.text.toString(),
                                  //               "county": '',
                                  //               //  feederName,
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
                                  //               "contractEndYear": "null",
                                  //               // _contractEndYear.text
                                  //               //     .toString(),
                                  //               "nextMaintDue":
                                  //                   DateFormat('yyyy-MM-dd')
                                  //                       .format(DateTime(
                                  //                 int.parse(_contractRowYear
                                  //                     .text
                                  //                     .toString()),
                                  //                 currentDate.month,
                                  //                 currentDate.day,
                                  //               )),
                                  //               // '${_nextMaintYear.text.toString()}-02-09',//contract year---current year
                                  //               "lastMaintDone":
                                  //                   DateFormat('yyyy-MM-dd')
                                  //                       .format(DateTime(
                                  //                 int.parse(_nextMaintYear.text
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
                                  //               "actionNeeded": substationName,
                                  //               "rowYear": '',
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
                                  //             print('name1');
                                  //             print((selectedAssignForman ==
                                  //                     'Other')
                                  //                 ? _assignOtherForeman.text
                                  //                     .toString()
                                  //                 : selectedAssignForman);
                                  //             print('Success');
                                  //             print('clicked on add new');
                                  //             Future.delayed(
                                  //                 const Duration(seconds: 5));
                                  //             Future.delayed(
                                  //                 const Duration(seconds: 2),
                                  //                 () {
                                  //               setState(() {
                                  //                 selectedSubstation = null;
                                  //                 selectedFeeder = null;
                                  //                 maintenanceType = null;
                                  //                 _totalMiles.clear();
                                  //                 _costPerMile.clear();
                                  //                 _totalCost.clear();
                                  //                 budgetType = null;
                                  //                 // _rowCycle.clear();
                                  //                 // _nextMaintYear.clear();
                                  //                 _contractEndYear.clear();
                                  //                 contractorCompany = null;
                                  //                 selectedAssignForman = null;
                                  //               });
                                  //             });
                                  //             Future.delayed(
                                  //                 const Duration(seconds: 10));
                                  //             Navigator.of(context).push(
                                  //                 MaterialPageRoute(
                                  //                     builder: (BuildContext
                                  //                             context) =>
                                  //                         const PlannerAddNewRowMaintenancePlanTable()));
                                  //             // _showUpdateDataDialog();
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
                  ));

                default:
                  return const Text('data');
              }
            })));
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
      value: item,
      child: Text(item,
          style: const TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 20,
          )));

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
    _rowCycle.text = 7.toString();
    int nextMaintenanceYear = 0;
    nextMaintenanceYear = contractRowYear + rowCycle;
    nextMaintenanceYearCTRL.text = nextMaintenanceYear.toString();
  }

  void onTextChanged() {
    print('Other selected on assign foreman11111111111111111111');
    name1 = _assignOtherForeman.text.toString();
    print('Other selected on assign foreman');
    print('name1');
    print('a');
    print(name1);
  }

  void fetchData(
      String substationId,
      String action,
      String name1,
      String supervisorId,
      String loginId,
      String substationName,
      String year,
      String feeder,
      String contractorCompany) {
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
        contractorCompany);
  }

  String getFeederNameById(String id) {
    var feederList = addNewRowMaintenancePlanViewModel
        .addNewRowMaintenancePlanList.data!.getIdAndFeederBySubstationId!;

    for (var feeder in feederList) {
      if (feeder.id.toString() == id) {
        return feeder.feeder.toString();
      }
    }
    return 'Feeder Not Found';
  }

  String getSubstationNameById(String id) {
    var substationList = addNewRowMaintenancePlanViewModel
        .addNewRowMaintenancePlanList.data!.getIdAndSubstation!;

    for (var subStation in substationList) {
      if (subStation.id.toString() == id) {
        return subStation.subStation.toString();
      }
    }
    return 'Substation Not Found';
  }

  Future<void> getData() async {
    print('widget.budgetType ${widget.budgetType}');
    if (addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanList.data !=
            null &&
        addNewRowMaintenancePlanViewModel
                .addNewRowMaintenancePlanList.data!.getIdAndSubstation !=
            null) {
      if (widget.subStation != '') {
        addNewRowMaintenancePlanViewModel
            .addNewRowMaintenancePlanList.data!.getIdAndSubstation!
            .forEach((a) {
          if (a.subStation == widget.subStation.toString()) {
            selectedSubstation = a.id.toString();
          }
        });
        substationName = getSubstationNameById(selectedSubstation);
      }
    }
    getSubstationIdByName(widget.subStation);
    print(widget.feeder);
    _totalMiles.text = widget.totalMiles;
    _costPerMile.text = widget.costPerMile;
    _totalCost.text = widget.totalCost;
    print('widget.contractRowYear222222 ${widget.contractRowYear}');
    if (widget.contractRowYear.isNotEmpty) {
      DateTime parsedDate;
      String formattedYear;
      String processedInput =
          widget.contractRowYear.replaceAll(RegExp(r'[^0-9]'), '');
      if (processedInput.length == 4 && int.tryParse(processedInput) != null) {
        parsedDate = DateTime(int.parse(processedInput));
        formattedYear = processedInput;
      } else {
        try {
          parsedDate =
              DateFormat("MM/dd/yyyy").parseStrict(widget.contractRowYear);
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
    // _nextMaintYear.text = widget.nextMaintYear;
    // String dateString =
    //     widget.nextMaintYear; // Replace this with widget.nextMaintYear
    // DateTime dateTime = DateFormat('MMM dd yyyy hh:mma').parse(dateString);
    // _nextMaintYear.text = widget.nextMaintYear;

    if (widget.nextMaintYear.isNotEmpty &&
        RegExp(r'^\d{4}$').hasMatch(widget.nextMaintYear)) {
      try {
        int year = int.parse(widget.nextMaintYear);
        _nextMaintYear.text = year.toString();
        print("11Year: $year");
      } catch (e) {
        print("Error parsing year: $e");
      }
    } else {
      print("nextMaintYear is either empty or not in yyyy format");
      try {
        DateFormat format = DateFormat("MMM dd yyyy hh:mma");
        DateTime dateTime = format.parseStrict(widget.nextMaintYear);
        int year = dateTime.year;
        _nextMaintYear.text = year.toString();
        print("Year: $year");
      } catch (e) {
        print("Invalid date format: $e");
      }
    }
    // DateFormat('yyyy').format(dateTime);
    _rowCycle.text = (widget.rowCycle == '') ? 7.toString() : widget.rowCycle;
    contractorCompany =
        (widget.contractorCompany == '' || widget.contractorCompany == 'N/A')
            ? null
            : widget.contractorCompany;
    if (widget.contractorCompany == 'LCP') {
      _isVisibleAssignForeman = false;
    } else if (widget.contractorCompany == 'ZILIES') {
      _isVisibleAssignForeman = true;
    }
    await Future.delayed(const Duration(seconds: 3));
    selectedAssignForman =
        (widget.assignForeman == '' || widget.assignForeman == 'N/A')
            ? null
            : widget.assignForeman;
    List<ContractorGetInsert>? loginIdList = addNewRowMaintenancePlanViewModel
        .addNewRowMaintenancePlanList.data!.contractorGetInsert;
    loginIdList?.forEach((ContractorGetInsert a) {
      if (a.name == widget.assignForeman) {
        assignFormanId = a.loginId!;
      }
    });
    // year = widget.nextMaintYear;
    // selectedSubstation = widget.subStation;
    //selectedFeeder = (widget.feeder == '') ? null : widget.feeder;
    // maintenanceType = (widget.maintType == '') ? null : widget.maintType;
    if (widget.budgetType != 'Regular IVM maintenance' ||
        widget.budgetType != 'Regular IVM Maintenance') {
      if (widget.budgetType == 'Mid Cycle Maintenance') {
        budgetType = 'Mid Cycle maintenance';
      } else {
        budgetType = (widget.budgetType == '' ||
                widget.budgetType == 'N/A' ||
                widget.budgetType == 'SELECT HERE')
            ? null
            : widget.budgetType;
      }
    }
    if (widget.contractRowYear == '' && widget.rowCycle == '') {
      calculateNextMaintenanceYear(
        int.parse(_contractRowYear.text),
        // 2023,
        7,
        // int.parse(_rowCycle.text),
        _nextMaintYear,
      );
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

  String getSubstationIdByName(String substationName) {
    var substationList = addNewRowMaintenancePlanViewModel
        .addNewRowMaintenancePlanList.data!.getIdAndSubstation!;
    for (var subStation in substationList) {
      if (subStation.subStation.toString() == substationName) {
        print('subStation.id.toString() ${subStation.id.toString()}');
        substationId = int.parse(subStation.id.toString());
        print('newSubId : $substationId');
        fetchData(subStation.id.toString(), 'Get', '', '', '', substationName,
            '', '', widget.contractorCompany);
        if (widget.feeder != '' && widget.feeder != 'null') {
          String feeder = widget.feeder;

          int indexOfOpeningBracket = feeder.indexOf('(');
          if (indexOfOpeningBracket != -1) {
            feeder = feeder.substring(0, indexOfOpeningBracket).trim();
          }
          print('widget.feeder $feeder');

          //////////////////////////
          Future.delayed(const Duration(seconds: 4), () {
            if (addNewRowMaintenancePlanViewModel
                        .addNewRowMaintenancePlanList.data !=
                    null &&
                addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanList
                        .data!.getIdAndFeederBySubstationId !=
                    null) {
              if (widget.feeder != '') {
                addNewRowMaintenancePlanViewModel.addNewRowMaintenancePlanList
                    .data!.getIdAndFeederBySubstationId!
                    .forEach((a) {
                  if (a.feeder == feeder.toString()) {
                    setState(() {
                      selectedFeeder = a.id.toString();
                      feederId = int.parse(selectedFeeder);
                    });
                  }
                });
              }
            }
          });
          // ///////////////////////////////////////////
        }
        return subStation.id.toString();
      }
    }
    return 'Substation Id Not Found';
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
