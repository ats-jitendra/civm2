import 'package:CIVM/piedmont/screens/supervisor_pannel/supervisor_add_new_row_maintenance_plan_tab1.dart';
import 'package:CIVM/piedmont/screens/supervisor_pannel/supervisor_add_new_row_maintenance_plan_tab2.dart';
import 'package:CIVM/piedmont/view_model/add_new_row_maintenance_plan_view_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:CIVM/piedmont/resources/app_colors.dart';

// ignore: must_be_immutable
class SupervisorAddNewRowMaintenancePlan extends StatefulWidget {
  // const SupervisorAddNewRowMaintenancePlan({Key? key}) : super(key: key);
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
  dynamic contractorCompany;
  dynamic assignForeman;

  SupervisorAddNewRowMaintenancePlan({
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
  State<SupervisorAddNewRowMaintenancePlan> createState() =>
      _SupervisorAddNewRowMaintenancePlanState();
}

class _SupervisorAddNewRowMaintenancePlanState
    extends State<SupervisorAddNewRowMaintenancePlan> {
  // int _currentIndex = 0;
  // final List<Widget> _children = [
  //   RowMaintenancePlan(),
  //   // BottomNavigationHomePage(),
  //   // BottomNavigationAccountPage()
  // ];
  List<String> menu = [];

  List<Map<String, dynamic>> listOfColumns = [];
  List<Map<String, dynamic>> listOfColumns1 = [];

  var result = [];
  DateTime currentDate = DateTime.now();
  int feederId = 0;
  int substationId = 0;
  int assignFormanId = 0;
  String supervisorId = '';
  String supervisorIdGlobal = '';

  late final TextEditingController _contractRowYear = TextEditingController();
  final TextEditingController _assignOtherForeman = TextEditingController();

  String name1 = '';

  // ignore: non_constant_identifier_names
  final select_contractorCompany = [
    'LCP',
    'PEMC',
  ];
  String? contractorCompany;

  // ignore: non_constant_identifier_names
  final select_budgetType = [
    'Regular IVM maintenance',
    'Mid Cycle maintenance'
  ];
  String? budgetType;

  String a = '';

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

  String feederName = '';
  String substationName = '';

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

  @override
  void initState() {
    // addNewRowMaintenancePlanViewModel.fetchAddNewRowMaintenancePlanViewListApi(
    //     context, '0', 'Get', '', '', '', '', '', '');
    super.initState();
    _contractRowYear.text = DateFormat("yyyy").format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return Scaffold(
       backgroundColor:AppColors.backgroundColor,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text(
            'View IVM, Spray Maintenance Plan',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: AppColors.baseColor,
          // actions: [
          //   IconButton(
          //     icon: const Icon(
          //       Icons.table_chart_outlined,
          //       color: Colors.white,
          //     ),
          //     onPressed: () {
          //       Navigator.of(context).push(MaterialPageRoute(
          //           builder: (BuildContext context) =>
          //               const SupervisorAddNewRowMaintenancePlanTable()));
          //     },
          //   ),
          // ],
        ),
      //  drawer: DrawerManu(menu: menu),
        body: DefaultTabController(
          length: 2,
          initialIndex: int.parse(widget.index),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(4),
                  height: 45,
                  decoration: const BoxDecoration(
                    color: AppColors.lightGreen,
                    // borderRadius: BorderRadius.circular(25.0)
                  ),
                  child: const TabBar(
                    indicator: BoxDecoration(
                      color: AppColors.baseColor,
                      // borderRadius: BorderRadius.circular(25.0),
                    ),
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelColor: Colors.white,
                    unselectedLabelColor: AppColors.baseColor,
                    tabs: [
                      Tab(
                        // icon: Icon(Icons.tab, color: Colors.white),
                        text: 'IVM WORK PLAN',
                      ),
                      Tab(
                        // icon: Icon(Icons.map, color: Colors.white),
                        text: 'MID CYCLE HERBICIDE WORK PLAN',
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      SupervisorAddNewRowMaintenancePlanTab1(
                        tokenNo: widget.tokenNo,
                        index: '0',
                        totalMiles:
                            (widget.index == '0') ? widget.totalMiles : '',
                        subStation:
                            (widget.index == '0') ? widget.subStation : '',
                        feeder: (widget.index == '0') ? widget.feeder : '',
                        nextMaintYear:
                            (widget.index == '0') ? widget.nextMaintYear : '',
                        maintType:
                            (widget.index == '0') ? widget.maintType : '',
                        totalCost:
                            (widget.index == '0') ? widget.totalCost : '',
                        costPerMile:
                            (widget.index == '0') ? widget.costPerMile : '',
                        budgetType:
                            (widget.index == '0') ? widget.budgetType : '',
                        contractRowYear:
                            (widget.index == '0') ? widget.contractRowYear : '',
                        rowCycle: (widget.index == '0') ? widget.rowCycle : '',
                        rowYear: (widget.index == '0') ? widget.rowYear : '',
                        contractorCompany: (widget.index == '0')
                            ? widget.contractorCompany
                            : '',
                        assignForeman:
                            (widget.index == '0') ? widget.assignForeman : '',
                      ),
                      SupervisorAddNewRowMaintenancePlanTab2(
                        tokenNo: widget.tokenNo,
                        index: '1',
                        totalMiles:
                            (widget.index == '1') ? widget.totalMiles : '',
                        subStation:
                            (widget.index == '1') ? widget.subStation : '',
                        feeder: (widget.index == '1') ? widget.feeder : '',
                        nextMaintYear:
                            (widget.index == '1') ? widget.nextMaintYear : '',
                        maintType:
                            (widget.index == '1') ? widget.maintType : '',
                        totalCost:
                            (widget.index == '1') ? widget.totalCost : '',
                        costPerMile:
                            (widget.index == '1') ? widget.costPerMile : '',
                        budgetType:
                            (widget.index == '1') ? widget.budgetType : '',
                        contractRowYear:
                            (widget.index == '1') ? widget.contractRowYear : '',
                        rowCycle: (widget.index == '1') ? widget.rowCycle : '',
                        rowYear: (widget.index == '1') ? widget.rowYear : '',
                        contractorCompany: (widget.index == '1')
                            ? widget.contractorCompany
                            : '',
                        assignForeman:
                            (widget.index == '1') ? widget.assignForeman : '',
                        task: 'edit',
                      ),
                      // EcAnalysisTabView(rateID: widget.rateID, ac: widget.ac),
                      // EcSavingTipsTabView(rateID: widget.rateID, ac: widget.ac),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }

  // @override
  // Widget build(BuildContext context) {
  //   Size size = MediaQuery.of(context).size;
  //   return Scaffold(
  //       appBar: AppBar(
  //         iconTheme: const IconThemeData(color: Colors.white),
  //         title: const Text(
  //           'Add New Row Maintenance Plan',
  //           style: TextStyle(
  //             color: Colors.white,
  //           ),
  //         ),
  //         backgroundColor: AppColors.baseColor,
  //         actions: [
  //           IconButton(
  //             icon: const Icon(
  //               Icons.table_chart_outlined,
  //               color: Colors.white,
  //             ),
  //             onPressed: () {
  //               Navigator.of(context).push(MaterialPageRoute(
  //                   builder: (BuildContext context) =>
  //                       const SupervisorAddNewRowMaintenancePlanTable()));
  //             },
  //           ),
  //         ],
  //       ),
  //       drawer: DrawerManu(
  //         menu: menu,
  //       ),
  //       body: ChangeNotifierProvider<AddNewRowMaintenancePlanViewModel>(
  //           create: (BuildContext context) => addNewRowMaintenancePlanViewModel,
  //           child: Consumer<AddNewRowMaintenancePlanViewModel>(
  //               builder: (context, value, _) {
  //             switch (value.addNewRowMaintenancePlanList.status) {
  //               case Status.LOADING:
  //                 return const Center(child: CircularProgressIndicator());
  //               case Status.ERROR:
  //                 return CustomToastSnackBarProgressDialog.flushBarErrorMessage(
  //                     value.addNewRowMaintenancePlanList.message.toString(),
  //                     context);

  //               case Status.COMPLETED:
  //                 return SingleChildScrollView(
  //                     child: DefaultTabController(
  //                   length: 2,
  //                   child: Padding(
  //                     padding: const EdgeInsets.all(4.0),
  //                     child: Column(
  //                       children: [
  //                         Container(
  //                           margin: const EdgeInsets.only(
  //                               left: 8, right: 8, top: 10, bottom: 8),
  //                           padding: const EdgeInsets.all(8),
  //                           alignment: Alignment.center,
  //                           // height: size.height * 0.5,
  //                           width: size.width * 0.99,
  //                           decoration: const BoxDecoration(
  //                               // shape: BoxShape.circle,

  //                               boxShadow: [
  //                                 BoxShadow(
  //                                     color: AppColors.baseColor,
  //                                     blurRadius: 10,
  //                                     offset: Offset(2.0, 5.0))
  //                               ],
  //                               gradient: LinearGradient(
  //                                 colors: [
  //                                   Color.fromARGB(255, 255, 255, 255),
  //                                   Color.fromARGB(255, 255, 255, 255),
  //                                 ],
  //                               )),
  //                           child: Form(
  //                             key: _formkey,
  //                             child: Column(
  //                               children: [
  //                                 Container(
  //                                   padding: const EdgeInsets.all(10),
  //                                   alignment: Alignment.center,
  //                                   width: size.width * 0.99,
  //                                   // width: MediaQuery.of(context).size.width,
  //                                   height: 50,
  //                                   decoration: const BoxDecoration(
  //                                       // shape: BoxShape.circle,
  //                                       //borderRadius: BorderRadius.circular(25),
  //                                       boxShadow: [
  //                                         BoxShadow(
  //                                             color: Color.fromARGB(
  //                                                 255, 3, 47, 97),
  //                                             blurRadius: 5,
  //                                             offset: Offset(2.0, 5.0))
  //                                       ],
  //                                       color:
  //                                           Color.fromARGB(255, 130, 193, 245),
  //                                       gradient: LinearGradient(
  //                                         colors: [
  //                                           AppColors.baseColor,
  //                                           Color.fromARGB(255, 7, 59, 120)
  //                                         ],
  //                                       )),
  //                                   child: const Align(
  //                                     alignment: Alignment.centerLeft,
  //                                     child: Text(
  //                                       "CUSTOM MAINTENANCE PLAN",
  //                                       textAlign: TextAlign.left,
  //                                       style: TextStyle(
  //                                         color: Colors.white,
  //                                         fontWeight: FontWeight.bold,
  //                                         fontSize: 20,
  //                                       ),
  //                                     ),
  //                                   ),
  //                                 ),
  //                                 Padding(
  //                                   padding: const EdgeInsets.only(
  //                                       left: 2.0,
  //                                       right: 2.0,
  //                                       bottom: 2.0,
  //                                       top: 10.0),
  //                                   child: Row(
  //                                     children: [
  //                                       const Expanded(
  //                                         child: Align(
  //                                             alignment: Alignment.centerLeft,
  //                                             child: Text(
  //                                               "SUBSTATION*",
  //                                               style: TextStyle(
  //                                                   fontSize: 16,
  //                                                   color: Color.fromARGB(
  //                                                       255, 7, 59, 120),
  //                                                   fontWeight:
  //                                                       FontWeight.bold),
  //                                             )),
  //                                       ),
  //                                       Expanded(
  //                                         child: Align(
  //                                           alignment: Alignment.centerLeft,
  //                                           child: Padding(
  //                                             padding:
  //                                                 const EdgeInsets.all(2.0),
  //                                             child: DropdownButtonFormField<
  //                                                 String>(
  //                                               hint: const Text('-Select-'),
  //                                               dropdownColor: Colors.white,
  //                                               value: selectedSubstation,
  //                                               style: const TextStyle(
  //                                                   color: Color.fromARGB(
  //                                                       255, 7, 59, 120),
  //                                                   fontSize: 16),
  //                                               icon: const Icon(
  //                                                 Icons.arrow_drop_down,
  //                                                 color: Color.fromARGB(
  //                                                     255, 7, 59, 120),
  //                                                 size: 40,
  //                                               ),
  //                                               decoration:
  //                                                   const InputDecoration(
  //                                                 enabledBorder:
  //                                                     OutlineInputBorder(
  //                                                   borderSide: BorderSide(
  //                                                     color: Color.fromARGB(
  //                                                         255, 7, 59, 120),
  //                                                   ),
  //                                                 ),
  //                                                 focusedBorder:
  //                                                     OutlineInputBorder(
  //                                                   borderSide: BorderSide(
  //                                                     color: Color.fromARGB(
  //                                                         255, 7, 59, 120),
  //                                                   ),
  //                                                 ),
  //                                               ),
  //                                               isExpanded: true,
  //                                               items: addNewRowMaintenancePlanViewModel
  //                                                   .addNewRowMaintenancePlanList
  //                                                   .data!
  //                                                   .getIdAndSubstation!
  //                                                   .map((e) {
  //                                                 return DropdownMenuItem(
  //                                                   value: e.id.toString(),
  //                                                   // e.getIdAndSubstationByCountId![0].subStation.toString(),
  //                                                   child: Text(e.subStation
  //                                                       .toString()),
  //                                                 );
  //                                               }).toList(),
  //                                              onChanged: (val) {
  //                                                 if (selectedFeeder != null) {
  //                                                   selectedFeeder = null;
  //                                                 }
  //                                                 print(getSubstationNameById(
  //                                                     val!));
  //                                                 substationName =
  //                                                     getSubstationNameById(
  //                                                         val);
  //                                                 print('val');
  //                                                 print(val);
  //                                                 fetchData(val, 'Get', '', '',
  //                                                     '', substationName);
  //                                                 substationId = int.parse(val);
  //                                                 print('111111111111111');
  //                                                 print(addNewRowMaintenancePlanViewModel
  //                                                     .addNewRowMaintenancePlanList
  //                                                     .data!
  //                                                     .getCostPerMileBySubstation
  //                                                     .toString());
  //                                                 setState(() async {
  //                                                   selectedSubstation = val;
  //                                                   await Future.delayed(
  //                                                       const Duration(
  //                                                           seconds: 5));
  //                                                   _costPerMile
  //                                                       .text = (addNewRowMaintenancePlanViewModel
  //                                                               .addNewRowMaintenancePlanList
  //                                                               .data!
  //                                                               .getCostPerMileBySubstation
  //                                                               .toString() ==
  //                                                           'null')
  //                                                       ? '0'
  //                                                       : addNewRowMaintenancePlanViewModel
  //                                                           .addNewRowMaintenancePlanList
  //                                                           .data!
  //                                                           .getCostPerMileBySubstation
  //                                                           .toString();
  //                                                 });
  //                                               },
  //                                               validator: (value) =>
  //                                                   value == null
  //                                                       ? 'field required'
  //                                                       : null,
  //                                             ),
  //                                           ),
  //                                         ),
  //                                       ),
  //                                     ],
  //                                   ),
  //                                 ),
  //                                 Padding(
  //                                   padding: const EdgeInsets.only(
  //                                       left: 2.0,
  //                                       right: 2.0,
  //                                       bottom: 2.0,
  //                                       top: 10.0),
  //                                   child: Row(
  //                                     children: [
  //                                       const Expanded(
  //                                         child: Align(
  //                                             alignment: Alignment.centerLeft,
  //                                             child: Text(
  //                                               "FEEDER*",
  //                                               style: TextStyle(
  //                                                   fontSize: 16,
  //                                                   color: Color.fromARGB(
  //                                                       255, 7, 59, 120),
  //                                                   fontWeight:
  //                                                       FontWeight.bold),
  //                                             )),
  //                                       ),
  //                                       Expanded(
  //                                         child: Align(
  //                                           alignment: Alignment.centerLeft,
  //                                           child: Padding(
  //                                             padding:
  //                                                 const EdgeInsets.all(2.0),
  //                                             child: DropdownButtonFormField<
  //                                                 String>(
  //                                               hint: const Text('-Select-'),
  //                                               dropdownColor: Colors.white,
  //                                               value: selectedFeeder,
  //                                               style: const TextStyle(
  //                                                   color: Color.fromARGB(
  //                                                       255, 7, 59, 120),
  //                                                   fontSize: 16),
  //                                               icon: const Icon(
  //                                                 Icons.arrow_drop_down,
  //                                                 color: Color.fromARGB(
  //                                                     255, 7, 59, 120),
  //                                                 size: 40,
  //                                               ),
  //                                               decoration:
  //                                                   const InputDecoration(
  //                                                 enabledBorder:
  //                                                     OutlineInputBorder(
  //                                                   borderSide: BorderSide(
  //                                                     color: Color.fromARGB(
  //                                                         255, 7, 59, 120),
  //                                                   ),
  //                                                 ),
  //                                                 focusedBorder:
  //                                                     OutlineInputBorder(
  //                                                   borderSide: BorderSide(
  //                                                     color: Color.fromARGB(
  //                                                         255, 7, 59, 120),
  //                                                   ),
  //                                                 ),
  //                                               ),
  //                                               isExpanded: true,
  //                                               items: addNewRowMaintenancePlanViewModel
  //                                                   .addNewRowMaintenancePlanList
  //                                                   .data!
  //                                                   .getIdAndFeederBySubstationId!
  //                                                   .map((e) {
  //                                                 return DropdownMenuItem(
  //                                                   value: e.id.toString(),
  //                                                   child: Text(
  //                                                       e.feeder.toString()),
  //                                                 );
  //                                               }).toList(),
  //                                               onChanged: (val) {
  //                                                 print('val');
  //                                                 print(
  //                                                     getFeederNameById(val!));
  //                                                 feederName =
  //                                                     getFeederNameById(val);
  //                                                 feederId = int.parse(val);
  //                                                 setState(() {
  //                                                   selectedFeeder = val;
  //                                                   print(selectedFeeder);
  //                                                 });
  //                                               },
  //                                               validator: (value) =>
  //                                                   value == null
  //                                                       ? 'field required'
  //                                                       : null,
  //                                             ),
  //                                           ),
  //                                         ),
  //                                       ),
  //                                     ],
  //                                   ),
  //                                 ),
  //                                 Padding(
  //                                   padding: const EdgeInsets.only(
  //                                       left: 2.0,
  //                                       right: 2.0,
  //                                       bottom: 2.0,
  //                                       top: 10.0),
  //                                   child: Row(
  //                                     children: [
  //                                       const Expanded(
  //                                         child: Align(
  //                                             alignment: Alignment.centerLeft,
  //                                             child: Text(
  //                                               "MAINTENANCE TYPE*",
  //                                               style: TextStyle(
  //                                                   fontSize: 16,
  //                                                   color: Color.fromARGB(
  //                                                       255, 7, 59, 120),
  //                                                   fontWeight:
  //                                                       FontWeight.bold),
  //                                             )),
  //                                       ),
  //                                       Expanded(
  //                                         child: Align(
  //                                           alignment: Alignment.centerRight,
  //                                           child: Padding(
  //                                             padding:
  //                                                 const EdgeInsets.all(2.0),
  //                                             child: Container(
  //                                               padding:
  //                                                   const EdgeInsets.symmetric(
  //                                                       horizontal: 12,
  //                                                       vertical: 4),
  //                                               decoration: BoxDecoration(
  //                                                 // borderRadius:
  //                                                 //     BorderRadius.circular(25),
  //                                                 border: Border.all(
  //                                                   color: const Color.fromARGB(
  //                                                       255, 7, 59, 120),
  //                                                 ),
  //                                               ),
  //                                               child: MultiSelectDialogField(
  //                                                 items: select_maintenanceType
  //                                                     .map((e) =>
  //                                                         MultiSelectItem(e, e))
  //                                                     .toList(),
  //                                                 listType:
  //                                                     MultiSelectListType.CHIP,
  //                                                 onConfirm: (value) {
  //                                                   setState(() =>
  //                                                       maintenanceType =
  //                                                           value.join(','));
  //                                                 },
  //                                                 validator: (value) =>
  //                                                     value == null
  //                                                         ? 'field required'
  //                                                         : null,
  //                                               ),
  //                                             ),
  //                                           ),
  //                                         ),
  //                                       ),
  //                                     ],
  //                                   ),
  //                                 ),
  //                                 Padding(
  //                                   padding: const EdgeInsets.only(
  //                                       left: 2.0,
  //                                       right: 2.0,
  //                                       bottom: 2.0,
  //                                       top: 10.0),
  //                                   child: Row(
  //                                     children: [
  //                                       const Expanded(
  //                                         child: Align(
  //                                             alignment: Alignment.centerLeft,
  //                                             child: Text(
  //                                               "TOTAL MILES",
  //                                               style: TextStyle(
  //                                                   fontSize: 16.0,
  //                                                   color: Color.fromARGB(
  //                                                       255, 7, 59, 120),
  //                                                   fontWeight:
  //                                                       FontWeight.bold),
  //                                             )),
  //                                       ),
  //                                       Expanded(
  //                                         child: Align(
  //                                           alignment: Alignment.centerRight,
  //                                           child: Padding(
  //                                             padding:
  //                                                 const EdgeInsets.all(2.0),
  //                                             child: TextFormField(
  //                                               inputFormatters: [
  //                                                 FilteringTextInputFormatter
  //                                                     .deny(RegExp(r'-')),
  //                                               ],
  //                                               //key: formkey4,
  //                                               controller: _totalMiles,
  //                                               style: const TextStyle(
  //                                                   color: Color.fromARGB(
  //                                                       255, 7, 59, 120),
  //                                                   fontSize: 16),
  //                                               obscureText: false,
  //                                               keyboardType:
  //                                                   const TextInputType
  //                                                       .numberWithOptions(
  //                                                 decimal: true,
  //                                                 signed: false,
  //                                               ),
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
  //                                                 hintText: '0',
  //                                               ),
  //                                               onChanged: (value) {
  //                                                 setState(() {
  //                                                   calculateTotalCost(
  //                                                     double.parse(value),
  //                                                     double.parse(
  //                                                         _costPerMile.text),
  //                                                     _totalCost,
  //                                                   );
  //                                                 });
  //                                               },
  //                                               validator: (value) {
  //                                                 if (value!.isEmpty) {
  //                                                   return "Please enter total cost";
  //                                                 } else {
  //                                                   return null;
  //                                                 }
  //                                               },
  //                                             ),
  //                                           ),
  //                                         ),
  //                                       ),
  //                                     ],
  //                                   ),
  //                                 ),
  //                                 Padding(
  //                                   padding: const EdgeInsets.only(
  //                                       left: 2.0,
  //                                       right: 2.0,
  //                                       bottom: 2.0,
  //                                       top: 10.0),
  //                                   child: Row(
  //                                     children: [
  //                                       const Expanded(
  //                                         child: Align(
  //                                             alignment: Alignment.centerLeft,
  //                                             child: Text(
  //                                               "COST PER MILE",
  //                                               style: TextStyle(
  //                                                   fontSize: 16.0,
  //                                                   color: Color.fromARGB(
  //                                                       255, 7, 59, 120),
  //                                                   fontWeight:
  //                                                       FontWeight.bold),
  //                                             )),
  //                                       ),
  //                                       Expanded(
  //                                         child: Align(
  //                                           alignment: Alignment.centerRight,
  //                                           child: Padding(
  //                                             padding:
  //                                                 const EdgeInsets.all(2.0),
  //                                             child: TextFormField(
  //                                               inputFormatters: [
  //                                                 FilteringTextInputFormatter
  //                                                     .deny(RegExp(r'-')),
  //                                               ],
  //                                               //  key: formkey5,
  //                                               controller: _costPerMile,
  //                                               style: const TextStyle(
  //                                                   color: Color.fromARGB(
  //                                                       255, 7, 59, 120),
  //                                                   fontSize: 16),
  //                                               obscureText: false,
  //                                               keyboardType:
  //                                                   const TextInputType
  //                                                       .numberWithOptions(
  //                                                 decimal: true,
  //                                                 signed: false,
  //                                               ),
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
  //                                                 hintText: '0',
  //                                               ),
  //                                               onChanged: (value) {
  //                                                 setState(() {
  //                                                   calculateTotalCost(
  //                                                     double.parse(
  //                                                         _totalMiles.text),
  //                                                     double.parse(value),
  //                                                     _totalCost,
  //                                                   );
  //                                                 });
  //                                               },
  //                                               // validator: (value) {
  //                                               //   if (value!.isEmpty) {
  //                                               //     return "Please enter cost per mile";
  //                                               //   } else {
  //                                               //     return null;
  //                                               //   }
  //                                               // },
  //                                             ),
  //                                           ),
  //                                         ),
  //                                       ),
  //                                     ],
  //                                   ),
  //                                 ),
  //                                 Padding(
  //                                   padding: const EdgeInsets.only(
  //                                       left: 2.0,
  //                                       right: 2.0,
  //                                       bottom: 2.0,
  //                                       top: 10.0),
  //                                   child: Row(
  //                                     children: [
  //                                       const Expanded(
  //                                         child: Align(
  //                                             alignment: Alignment.centerLeft,
  //                                             child: Text(
  //                                               "TOTAL COST",
  //                                               style: TextStyle(
  //                                                   fontSize: 16.0,
  //                                                   color: Color.fromARGB(
  //                                                       255, 7, 59, 120),
  //                                                   fontWeight:
  //                                                       FontWeight.bold),
  //                                             )),
  //                                       ),
  //                                       Expanded(
  //                                         child: Align(
  //                                           alignment: Alignment.centerRight,
  //                                           child: Padding(
  //                                             padding:
  //                                                 const EdgeInsets.all(2.0),
  //                                             child: TextFormField(
  //                                               enabled: false,
  //                                               // key: formkey6,
  //                                               controller: _totalCost,
  //                                               style: const TextStyle(
  //                                                   color: Color.fromARGB(
  //                                                       255, 7, 59, 120),
  //                                                   fontSize: 16),
  //                                               obscureText: false,
  //                                               keyboardType:
  //                                                   TextInputType.number,
  //                                               decoration:
  //                                                   const InputDecoration(
  //                                                 border: OutlineInputBorder(),
  //                                                 disabledBorder:
  //                                                     OutlineInputBorder(
  //                                                   borderSide: BorderSide(
  //                                                     color: Color.fromARGB(
  //                                                         255, 7, 59, 120),
  //                                                   ),
  //                                                 ),
  //                                                 hintText: '0',
  //                                               ),
  //                                               // validator: (value) {
  //                                               //   if (value!.isEmpty) {
  //                                               //     return "Please enter total cost";
  //                                               //   } else {
  //                                               //     return null;
  //                                               //   }
  //                                               // },
  //                                             ),
  //                                           ),
  //                                         ),
  //                                       ),
  //                                     ],
  //                                   ),
  //                                 ),
  //                                 Padding(
  //                                   padding: const EdgeInsets.only(
  //                                       left: 2.0,
  //                                       right: 2.0,
  //                                       bottom: 2.0,
  //                                       top: 10.0),
  //                                   child: Row(
  //                                     children: [
  //                                       const Expanded(
  //                                         child: Align(
  //                                             alignment: Alignment.centerLeft,
  //                                             child: Text(
  //                                               "BUDGET TYPE*",
  //                                               style: TextStyle(
  //                                                   fontSize: 16,
  //                                                   color: Color.fromARGB(
  //                                                       255, 7, 59, 120),
  //                                                   fontWeight:
  //                                                       FontWeight.bold),
  //                                             )),
  //                                       ),
  //                                       Expanded(
  //                                         child: Align(
  //                                           alignment: Alignment.centerLeft,
  //                                           child: Padding(
  //                                             padding:
  //                                                 const EdgeInsets.all(2.0),
  //                                             child: DropdownButtonFormField<
  //                                                 String>(
  //                                               hint: const Text('-Select-'),
  //                                               dropdownColor: Colors.white,
  //                                               value: budgetType,
  //                                               style: const TextStyle(
  //                                                   color: Color.fromARGB(
  //                                                       255, 7, 59, 120),
  //                                                   fontSize: 16),
  //                                               icon: const Icon(
  //                                                 Icons.arrow_drop_down,
  //                                                 color: Color.fromARGB(
  //                                                     255, 7, 59, 120),
  //                                                 size: 40,
  //                                               ),
  //                                               decoration:
  //                                                   const InputDecoration(
  //                                                 enabledBorder:
  //                                                     OutlineInputBorder(
  //                                                   borderSide: BorderSide(
  //                                                     color: Color.fromARGB(
  //                                                         255, 7, 59, 120),
  //                                                   ),
  //                                                 ),
  //                                                 focusedBorder:
  //                                                     OutlineInputBorder(
  //                                                   borderSide: BorderSide(
  //                                                     color: Color.fromARGB(
  //                                                         255, 7, 59, 120),
  //                                                   ),
  //                                                 ),
  //                                               ),
  //                                               isExpanded: true,
  //                                               items: select_budgetType
  //                                                   .map(buildMenuItem)
  //                                                   .toList(),
  //                                               onChanged: (value) => setState(
  //                                                   () => budgetType = value),
  //                                               validator: (value) =>
  //                                                   value == null
  //                                                       ? 'field required'
  //                                                       : null,
  //                                             ),
  //                                           ),
  //                                         ),
  //                                       ),
  //                                     ],
  //                                   ),
  //                                 ),
  //                                 // Padding(
  //                                 //   padding: const EdgeInsets.only(
  //                                 //       left: 2.0,
  //                                 //       right: 2.0,
  //                                 //       bottom: 2.0,
  //                                 //       top: 10.0),
  //                                 //   child: Row(
  //                                 //     children: [
  //                                 //       const Expanded(
  //                                 //         child: Align(
  //                                 //             alignment: Alignment.centerLeft,
  //                                 //             child: Text(
  //                                 //               "Budget",
  //                                 //               style: TextStyle(
  //                                 //                 fontSize: 16.0,
  //                                 //                 color: Color.fromARGB(
  //                                 //                     255, 7, 59, 120),
  //                                 //                 //  fontWeight: FontWeight.bold
  //                                 //               ),
  //                                 //             )),
  //                                 //       ),
  //                                 //       Expanded(
  //                                 //         child: Align(
  //                                 //           alignment: Alignment.centerRight,
  //                                 //           child: Padding(
  //                                 //             padding:
  //                                 //                 const EdgeInsets.all(2.0),
  //                                 //             child: TextFormField(
  //                                 //               // key: formkey7,
  //                                 //               controller: _budget,
  //                                 //               style: const TextStyle(
  //                                 //                   color: Color.fromARGB(
  //                                 //                       255, 7, 59, 120),
  //                                 //                   fontSize: 16),
  //                                 //               obscureText: false,
  //                                 //               keyboardType:
  //                                 //                   TextInputType.number,
  //                                 //               decoration:
  //                                 //                   const InputDecoration(
  //                                 //                 border: OutlineInputBorder(),
  //                                 //                 enabledBorder:
  //                                 //                     OutlineInputBorder(
  //                                 //                   borderSide: BorderSide(
  //                                 //                     color: Color.fromARGB(
  //                                 //                         255, 7, 59, 120),
  //                                 //                   ),
  //                                 //                 ),
  //                                 //                 hintText: 'Budget',
  //                                 //               ),
  //                                 //               validator: (value) {
  //                                 //                 if (value!.isEmpty) {
  //                                 //                   return "Please Enter Budget again";
  //                                 //                 }
  //                                 //                 int a =
  //                                 //                     (_totalCost.text.isEmpty)
  //                                 //                         ? 0
  //                                 //                         : int.parse(_totalCost
  //                                 //                             .text
  //                                 //                             .toString());
  //                                 //                 int b = (_budget.text.isEmpty)
  //                                 //                     ? 0
  //                                 //                     : int.parse(_budget.text
  //                                 //                         .toString());

  //                                 //                 if (b <= a) {
  //                                 //                   return "Budget > Total Cost";
  //                                 //                 }
  //                                 //                 return null;
  //                                 //               },
  //                                 //             ),
  //                                 //           ),
  //                                 //         ),
  //                                 //       ),
  //                                 //     ],
  //                                 //   ),
  //                                 // ),

  //                                 Padding(
  //                                   padding: const EdgeInsets.only(
  //                                       left: 2.0,
  //                                       right: 2.0,
  //                                       bottom: 2.0,
  //                                       top: 10.0),
  //                                   child: Row(
  //                                     children: [
  //                                       const Expanded(
  //                                         child: Align(
  //                                             alignment: Alignment.centerLeft,
  //                                             child: Text(
  //                                               "CONTRACT ROW YEAR",
  //                                               style: TextStyle(
  //                                                   fontSize: 16.0,
  //                                                   color: Color.fromARGB(
  //                                                       255, 7, 59, 120),
  //                                                   fontWeight:
  //                                                       FontWeight.bold),
  //                                             )),
  //                                       ),
  //                                       Expanded(
  //                                         child: Align(
  //                                           alignment: Alignment.centerRight,
  //                                           child: Padding(
  //                                             padding:
  //                                                 const EdgeInsets.all(2.0),
  //                                             child: TextFormField(
  //                                               // enabled: false,
  //                                               //key: formkey8,
  //                                               controller: _contractRowYear,
  //                                               style: const TextStyle(
  //                                                   color: Color.fromARGB(
  //                                                       255, 7, 59, 120),
  //                                                   fontSize: 16),
  //                                               obscureText: false,
  //                                               keyboardType:
  //                                                   TextInputType.number,
  //                                               decoration:
  //                                                   const InputDecoration(
  //                                                 border: OutlineInputBorder(),
  //                                                 disabledBorder:
  //                                                     OutlineInputBorder(
  //                                                   borderSide: BorderSide(
  //                                                     color: Color.fromARGB(
  //                                                         255, 7, 59, 120),
  //                                                   ),
  //                                                 ),
  //                                               ),

  //                                               onChanged: (value) {
  //                                                 setState(() {
  //                                                   calculateNextMaintenanceYear(
  //                                                     int.parse(value),
  //                                                     // 2023,
  //                                                     int.parse(_rowCycle.text),
  //                                                     _nextMaintYear,
  //                                                   );
  //                                                 });
  //                                               },
  //                                               validator: (value) {
  //                                                 if (value!.isEmpty) {
  //                                                   return "Please enter contract row year";
  //                                                 }
  //                                                 try {
  //                                                   double parsedValue =
  //                                                       double.parse(value);
  //                                                   if (parsedValue % 1 != 0) {
  //                                                     return "Integer value required!";
  //                                                   }
  //                                                 } catch (e) {
  //                                                   return "Invalid input. Please enter a numeric value.";
  //                                                 }
  //                                                 return null;
  //                                               },
  //                                             ),
  //                                           ),
  //                                         ),
  //                                       ),
  //                                     ],
  //                                   ),
  //                                 ),
  //                                 Padding(
  //                                   padding: const EdgeInsets.only(
  //                                       left: 2.0,
  //                                       right: 2.0,
  //                                       bottom: 2.0,
  //                                       top: 10.0),
  //                                   child: Row(
  //                                     children: [
  //                                       const Expanded(
  //                                         child: Align(
  //                                             alignment: Alignment.centerLeft,
  //                                             child: Text(
  //                                               "ROW CYCLE ",
  //                                               style: TextStyle(
  //                                                   fontSize: 16.0,
  //                                                   color: Color.fromARGB(
  //                                                       255, 7, 59, 120),
  //                                                   fontWeight:
  //                                                       FontWeight.bold),
  //                                             )),
  //                                       ),
  //                                       Expanded(
  //                                         child: Align(
  //                                           alignment: Alignment.centerRight,
  //                                           child: Padding(
  //                                             padding:
  //                                                 const EdgeInsets.all(2.0),
  //                                             child: TextFormField(
  //                                               inputFormatters: [
  //                                                 FilteringTextInputFormatter
  //                                                     .deny(RegExp(r'-')),
  //                                               ],
  //                                               // key: formkey9,
  //                                               controller: _rowCycle,
  //                                               style: const TextStyle(
  //                                                   color: Color.fromARGB(
  //                                                       255, 7, 59, 120),
  //                                                   fontSize: 16),
  //                                               obscureText: false,
  //                                               keyboardType:
  //                                                   TextInputType.number,
  //                                               decoration:
  //                                                   const InputDecoration(
  //                                                 border: OutlineInputBorder(),
  //                                                 enabledBorder:
  //                                                     OutlineInputBorder(
  //                                                   borderSide: BorderSide(
  //                                                       color: Color.fromARGB(
  //                                                           255, 7, 59, 120)),
  //                                                 ),
  //                                                 hintText: '0',
  //                                               ),
  //                                               onChanged: (value) {
  //                                                 setState(() {
  //                                                   calculateNextMaintenanceYear(
  //                                                     int.parse(_contractRowYear
  //                                                         .text),
  //                                                     // 2023,
  //                                                     int.parse(value),
  //                                                     _nextMaintYear,
  //                                                   );
  //                                                 });
  //                                               },
  //                                               validator: (value) {
  //                                                 if (value!.isEmpty) {
  //                                                   return "Please enter row cycle ";
  //                                                 }
  //                                                 try {
  //                                                   double parsedValue =
  //                                                       double.parse(value);
  //                                                   if (parsedValue % 1 != 0) {
  //                                                     return "Integer value required!";
  //                                                   }
  //                                                 } catch (e) {
  //                                                   return "Invalid input. Please enter a numeric value.";
  //                                                 }
  //                                                 return null;
  //                                               },
  //                                             ),
  //                                           ),
  //                                         ),
  //                                       ),
  //                                     ],
  //                                   ),
  //                                 ),
  //                                 Padding(
  //                                   padding: const EdgeInsets.only(
  //                                       left: 2.0,
  //                                       right: 2.0,
  //                                       bottom: 2.0,
  //                                       top: 10.0),
  //                                   child: Row(
  //                                     children: [
  //                                       const Expanded(
  //                                         child: Align(
  //                                             alignment: Alignment.centerLeft,
  //                                             child: Text(
  //                                               "NEXT MAINT YEAR",
  //                                               style: TextStyle(
  //                                                   fontSize: 16.0,
  //                                                   color: Color.fromARGB(
  //                                                       255, 7, 59, 120),
  //                                                   fontWeight:
  //                                                       FontWeight.bold),
  //                                             )),
  //                                       ),
  //                                       Expanded(
  //                                         child: Align(
  //                                           alignment: Alignment.centerRight,
  //                                           child: Padding(
  //                                             padding:
  //                                                 const EdgeInsets.all(2.0),
  //                                             child: TextFormField(
  //                                               enabled: false,
  //                                               // key: formkey10,
  //                                               controller: _nextMaintYear,
  //                                               style: const TextStyle(
  //                                                   color: Color.fromARGB(
  //                                                       255, 7, 59, 120),
  //                                                   fontSize: 16),
  //                                               obscureText: false,
  //                                               decoration:
  //                                                   const InputDecoration(
  //                                                 border: OutlineInputBorder(),
  //                                                 disabledBorder:
  //                                                     OutlineInputBorder(
  //                                                   borderSide: BorderSide(
  //                                                     color: Color.fromARGB(
  //                                                         255, 7, 59, 120),
  //                                                   ),
  //                                                 ),
  //                                                 hintText: '0',
  //                                               ),
  //                                               validator: (value) {
  //                                                 if (value!.isEmpty) {
  //                                                   return "Please enter next maint year";
  //                                                 } else {
  //                                                   return null;
  //                                                 }
  //                                               },
  //                                             ),
  //                                           ),
  //                                         ),
  //                                       ),
  //                                     ],
  //                                   ),
  //                                 ),
  //                                 Padding(
  //                                   padding: const EdgeInsets.only(
  //                                       left: 2.0,
  //                                       right: 2.0,
  //                                       bottom: 2.0,
  //                                       top: 10.0),
  //                                   child: Row(
  //                                     children: [
  //                                       const Expanded(
  //                                         child: Align(
  //                                             alignment: Alignment.centerLeft,
  //                                             child: Text(
  //                                               "CONTRACT END YEAR",
  //                                               style: TextStyle(
  //                                                   fontSize: 16.0,
  //                                                   color: Color.fromARGB(
  //                                                       255, 7, 59, 120),
  //                                                   fontWeight:
  //                                                       FontWeight.bold),
  //                                             )),
  //                                       ),
  //                                       Expanded(
  //                                         child: Align(
  //                                           alignment: Alignment.centerRight,
  //                                           child: Padding(
  //                                             padding:
  //                                                 const EdgeInsets.all(2.0),
  //                                             child: TextFormField(
  //                                               keyboardType:
  //                                                   TextInputType.number,
  //                                               // key: formkey10,
  //                                               controller: _contractEndYear,
  //                                               style: const TextStyle(
  //                                                   color: Color.fromARGB(
  //                                                       255, 7, 59, 120),
  //                                                   fontSize: 16),
  //                                               obscureText: false,
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
  //                                                 hintText: 'Contract End Year',
  //                                               ),
  //                                               validator: (value) {
  //                                                 if (value!.isEmpty) {
  //                                                   return "Please enter your Contract End Year";
  //                                                 }

  //                                                 if (value.compareTo(
  //                                                         _nextMaintYear.text
  //                                                             .toString()) <
  //                                                     0) {
  //                                                   return "Invalid Year..!";
  //                                                 }
  //                                                 try {
  //                                                   double parsedValue =
  //                                                       double.parse(value);
  //                                                   if (parsedValue % 1 != 0) {
  //                                                     return "Integer value required!";
  //                                                   }
  //                                                 } catch (e) {
  //                                                   return "Invalid input..!";
  //                                                 }
  //                                                 return null;
  //                                               },
  //                                             ),
  //                                           ),
  //                                         ),
  //                                       ),
  //                                     ],
  //                                   ),
  //                                 ),
  //                                 Padding(
  //                                   padding: const EdgeInsets.only(
  //                                       left: 2.0,
  //                                       right: 2.0,
  //                                       bottom: 2.0,
  //                                       top: 10.0),
  //                                   child: Row(
  //                                     children: [
  //                                       const Expanded(
  //                                         child: Align(
  //                                             alignment: Alignment.centerLeft,
  //                                             child: Text(
  //                                               "CONTRACTOR COMPANY*",
  //                                               style: TextStyle(
  //                                                   fontSize: 16,
  //                                                   color: Color.fromARGB(
  //                                                       255, 7, 59, 120),
  //                                                   fontWeight:
  //                                                       FontWeight.bold),
  //                                             )),
  //                                       ),
  //                                       Expanded(
  //                                         child: Align(
  //                                           alignment: Alignment.centerLeft,
  //                                           child: Padding(
  //                                             padding:
  //                                                 const EdgeInsets.all(2.0),
  //                                             child: DropdownButtonFormField<
  //                                                 String>(
  //                                               hint: const Text('-Select-'),
  //                                               dropdownColor: Colors.white,
  //                                               value: contractorCompany,
  //                                               style: const TextStyle(
  //                                                   color: Color.fromARGB(
  //                                                       255, 7, 59, 120),
  //                                                   fontSize: 16),
  //                                               icon: const Icon(
  //                                                 Icons.arrow_drop_down,
  //                                                 color: Color.fromARGB(
  //                                                     255, 7, 59, 120),
  //                                                 size: 40,
  //                                               ),
  //                                               decoration:
  //                                                   const InputDecoration(
  //                                                 enabledBorder:
  //                                                     OutlineInputBorder(
  //                                                   borderSide: BorderSide(
  //                                                     color: Color.fromARGB(
  //                                                         255, 7, 59, 120),
  //                                                   ),
  //                                                 ),
  //                                                 focusedBorder:
  //                                                     OutlineInputBorder(
  //                                                   borderSide: BorderSide(
  //                                                     color: Color.fromARGB(
  //                                                         255, 7, 59, 120),
  //                                                   ),
  //                                                 ),
  //                                               ),
  //                                               isExpanded: true,
  //                                               items: select_contractorCompany
  //                                                   .map(buildMenuItem)
  //                                                   .toList(),
  //                                               onChanged: (value) => setState(
  //                                                   () => contractorCompany =
  //                                                       value),
  //                                               validator: (value) =>
  //                                                   value == null
  //                                                       ? 'field required'
  //                                                       : null,
  //                                             ),
  //                                           ),
  //                                         ),
  //                                       ),
  //                                     ],
  //                                   ),
  //                                 ),
  //                                 Padding(
  //                                   padding: const EdgeInsets.only(
  //                                       left: 2.0,
  //                                       right: 2.0,
  //                                       bottom: 2.0,
  //                                       top: 10.0),
  //                                   child: Row(
  //                                     children: [
  //                                       const Expanded(
  //                                         child: Align(
  //                                             alignment: Alignment.centerLeft,
  //                                             child: Text(
  //                                               "ASSIGN FOREMAN*",
  //                                               style: TextStyle(
  //                                                   fontSize: 16,
  //                                                   color: Color.fromARGB(
  //                                                       255, 7, 59, 120),
  //                                                   fontWeight:
  //                                                       FontWeight.bold),
  //                                             )),
  //                                       ),
  //                                       Expanded(
  //                                         child: Align(
  //                                           alignment: Alignment.centerLeft,
  //                                           child: Padding(
  //                                             padding:
  //                                                 const EdgeInsets.all(2.0),
  //                                             child: DropdownButtonFormField<
  //                                                 String>(
  //                                               hint: const Text('-Select-'),
  //                                               dropdownColor: Colors.white,
  //                                               value: selectedAssignForman,
  //                                               style: const TextStyle(
  //                                                   color: Color.fromARGB(
  //                                                       255, 7, 59, 120),
  //                                                   fontSize: 16),
  //                                               icon: const Icon(
  //                                                 Icons.arrow_drop_down,
  //                                                 color: Color.fromARGB(
  //                                                     255, 7, 59, 120),
  //                                                 size: 40,
  //                                               ),
  //                                               decoration:
  //                                                   const InputDecoration(
  //                                                 enabledBorder:
  //                                                     OutlineInputBorder(
  //                                                   borderSide: BorderSide(
  //                                                     color: Color.fromARGB(
  //                                                         255, 7, 59, 120),
  //                                                   ),
  //                                                 ),
  //                                                 focusedBorder:
  //                                                     OutlineInputBorder(
  //                                                   borderSide: BorderSide(
  //                                                     color: Color.fromARGB(
  //                                                         255, 7, 59, 120),
  //                                                   ),
  //                                                 ),
  //                                               ),
  //                                               isExpanded: true,
  //                                               items: addNewRowMaintenancePlanViewModel
  //                                                   .addNewRowMaintenancePlanList
  //                                                   .data!
  //                                                   .contractorGetInsert!
  //                                                   .map((e) {
  //                                                 return DropdownMenuItem(
  //                                                   value: e.name.toString(),
  //                                                   child:
  //                                                       Text(e.name.toString()),
  //                                                 );
  //                                               }).toList(),
  //                                               onChanged: (val) {
  //                                                 setState(() {
  //                                                   selectedAssignForman = val;
  //                                                 });
  //                                                 print('val');
  //                                                 print(val);
  //                                                 List<ContractorGetInsert>?
  //                                                     loginIdList =
  //                                                     addNewRowMaintenancePlanViewModel
  //                                                         .addNewRowMaintenancePlanList
  //                                                         .data!
  //                                                         .contractorGetInsert;
  //                                                 print('111111111111111');
  //                                                 print('loginIdList');
  //                                                 print(loginIdList);
  //                                                 print(selectedAssignForman);
  //                                                 print(
  //                                                     '22222222222222222222222');
  //                                                 print(selectedAssignForman);
  //                                                 loginIdList?.forEach(
  //                                                     (ContractorGetInsert a) {
  //                                                   if (a.name ==
  //                                                       selectedAssignForman) {
  //                                                     assignFormanId =
  //                                                         a.loginId!;
  //                                                     print(
  //                                                         'assignFormanId11111111111111111111111');
  //                                                     print(assignFormanId);
  //                                                     print(
  //                                                         'selectedAssignForman.............');
  //                                                     print(
  //                                                         selectedAssignForman);
  //                                                   }
  //                                                 });
  //                                                 if (selectedAssignForman !=
  //                                                     'Other') {
  //                                                   _isVisibleAssignOtherForeman =
  //                                                       false;
  //                                                   name1 = selectedAssignForman
  //                                                       .toString();
  //                                                   print(
  //                                                       'name1....other not selected');
  //                                                   print(name1);

  //                                                   print(
  //                                                       'Getting Supervisor Id............');

  //                                                   print(
  //                                                       '11111111111111111111111111111111');
  //                                                 } else {
  //                                                   _isVisibleAssignOtherForeman =
  //                                                       true;
  //                                                   name1 = _assignOtherForeman
  //                                                       .text
  //                                                       .toString();
  //                                                   print(
  //                                                       'name1....other selected');
  //                                                   print(name1);
  //                                                   print(
  //                                                       'before other foreman entered');

  //                                                   print(
  //                                                       'after other foreman entered');
  //                                                   print(_assignOtherForeman
  //                                                       .text
  //                                                       .toString());
  //                                                 }
  //                                                 print(
  //                                                     'aaaaaaaaaaaaaaaaaaaaaa');
  //                                               },
  //                                               validator: (value) =>
  //                                                   value == null
  //                                                       ? 'field required'
  //                                                       : null,
  //                                             ),
  //                                           ),
  //                                         ),
  //                                       ),
  //                                     ],
  //                                   ),
  //                                 ),
  //                                 Visibility(
  //                                   visible: _isVisibleAssignOtherForeman,
  //                                   child: Padding(
  //                                     padding: const EdgeInsets.only(top: 10.0),
  //                                     child: Align(
  //                                       alignment: Alignment.centerRight,
  //                                       child: Padding(
  //                                         padding: const EdgeInsets.only(
  //                                             right: 2.0,
  //                                             top: 2,
  //                                             bottom: 2,
  //                                             left: 180),
  //                                         child: TextFormField(
  //                                           //  key: formkey5,
  //                                           controller: _assignOtherForeman,
  //                                           onEditingComplete: onTextChanged,
  //                                           style: const TextStyle(
  //                                               color: Color.fromARGB(
  //                                                   255, 7, 59, 120),
  //                                               fontSize: 16),
  //                                           obscureText: false,
  //                                           // keyboardType: TextInputType.number,
  //                                           decoration: InputDecoration(
  //                                             border: OutlineInputBorder(
  //                                               borderRadius:
  //                                                   BorderRadius.circular(25),
  //                                             ),
  //                                             enabledBorder: OutlineInputBorder(
  //                                               borderSide: const BorderSide(
  //                                                 color: Color.fromARGB(
  //                                                     255, 7, 59, 120),
  //                                               ),
  //                                               borderRadius:
  //                                                   BorderRadius.circular(25),
  //                                             ),
  //                                             hintText:
  //                                                 'Assign Other Foreman Name',
  //                                           ),

  //                                           validator: (value) {
  //                                             if (value!.isEmpty) {
  //                                               return "Please enter Assign Other Foreman Name";
  //                                             } else {
  //                                               return null;
  //                                             }
  //                                           },
  //                                         ),
  //                                       ),
  //                                     ),
  //                                   ),
  //                                 ),
  //                                 Container(
  //                                     margin: const EdgeInsets.only(
  //                                         left: 6, right: 6, top: 8.0),
  //                                     child: Padding(
  //                                       padding: const EdgeInsets.only(
  //                                           left: 2.0,
  //                                           right: 2.0,
  //                                           bottom: 2.0,
  //                                           top: 20.0),
  //                                       child: InkWell(
  //                                         onTap: () {
  //                                           print('click on add new before');
  //                                           if (_formkey.currentState!
  //                                               .validate()) {
  //                                             Map mapData = {
  //                                               "substation": substationId,
  //                                               "feeder": feederId,
  //                                               "contractorCompay":
  //                                                   contractorCompany,
  //                                               "contractor": assignFormanId,
  //                                               // "name1":_assignOtherForeman.toString(),
  //                                               "maintType": 'RegularMaint',
  //                                               "type": maintenanceType,
  //                                               "cycle":
  //                                                   _rowCycle.text.toString(),
  //                                               "county":
  //                                                   feederName, //feederName need to be passed in county
  //                                               "maintDateHistory": "NA",
  //                                               "supervisor":
  //                                                   (selectedAssignForman ==
  //                                                           'Other')
  //                                                       ? _assignOtherForeman
  //                                                           .text
  //                                                           .toString()
  //                                                       : selectedAssignForman,
  //                                               "district": '',
  //                                               "planType":
  //                                                   "CUSTOM MAINTENANCE PLAN",
  //                                               "street": '',
  //                                               "createdBy": 1,
  //                                               "budget": 0,
  //                                               // _budget.text.toString(),
  //                                               // "totalCost": double.parse(
  //                                               //     (double.parse(_totalCost
  //                                               //             .text
  //                                               //             .toString()))
  //                                               //         .toStringAsFixed(2)),
  //                                               // "costPerMile": double.parse(
  //                                               //     (double.parse(_costPerMile
  //                                               //             .text
  //                                               //             .toString()))
  //                                               //         .toStringAsFixed(2)),
  //                                               "totalCost": (_totalCost
  //                                                           .text.isEmpty ||
  //                                                       _totalCost.text == '')
  //                                                   ? 0.0
  //                                                   : double.parse((double
  //                                                           .parse(_totalCost
  //                                                               .text
  //                                                               .toString()))
  //                                                       .toStringAsFixed(2)),
  //                                               "costPerMile": (_costPerMile
  //                                                           .text.isEmpty ||
  //                                                       _costPerMile.text == '')
  //                                                   ? 0.0
  //                                                   : double.parse((double
  //                                                           .parse(_costPerMile
  //                                                               .text
  //                                                               .toString()))
  //                                                       .toStringAsFixed(2)),
  //                                               "totalMiles": double.parse(
  //                                                   (double.parse(_totalMiles
  //                                                           .text
  //                                                           .toString()))
  //                                                       .toStringAsFixed(2)),
  //                                               // _totalMiles.text.toString(),
  //                                               "maintCount": '',
  //                                               "contractEndYear":
  //                                                   _contractEndYear.text
  //                                                       .toString(),
  //                                               "nextMaintDue":
  //                                                   DateFormat('yyyy-MM-dd')
  //                                                       .format(DateTime(
  //                                                 int.parse(_contractRowYear
  //                                                     .text
  //                                                     .toString()),
  //                                                 currentDate.month,
  //                                                 currentDate.day,
  //                                               )),
  //                                               // '${_nextMaintYear.text.toString()}-02-09',//contract year---current year
  //                                               "lastMaintDone":
  //                                                   DateFormat('yyyy-MM-dd')
  //                                                       .format(DateTime(
  //                                                 int.parse(_contractRowYear
  //                                                     .text
  //                                                     .toString()),
  //                                                 currentDate.month,
  //                                                 currentDate.day,
  //                                               )),
  //                                               //contract year---current year
  //                                               "contractYear":
  //                                                   DateFormat('MM/dd/yyyy')
  //                                                       .format(DateTime(
  //                                                 int.parse(_contractRowYear
  //                                                     .text
  //                                                     .toString()),
  //                                                 currentDate.month,
  //                                                 currentDate.day,
  //                                               )), //contract year---current year
  //                                               "status": "PENDING",
  //                                               "budgetType": budgetType,
  //                                               "actionNeeded":
  //                                                   substationName, //substation Name need to be passed in actionNeeded
  //                                             };
  //                                             print('API called.........');
  //                                             print(mapData);
  //                                             addNewRowMaintenancePlanViewModel
  //                                                 .fetchAddNewRowMaintenancePlanSubmitListApi(
  //                                                     context, mapData);
  //                                             print('name1');
  //                                             print((selectedAssignForman ==
  //                                                     'Other')
  //                                                 ? _assignOtherForeman.text
  //                                                     .toString()
  //                                                 : selectedAssignForman);
  //                                             print('Success');
  //                                             print('clicked on add new');
  //                                             Future.delayed(
  //                                                 const Duration(seconds: 5));
  //                                             Future.delayed(
  //                                                 const Duration(seconds: 2),
  //                                                 () {
  //                                               setState(() {
  //                                                 selectedSubstation = null;
  //                                                 selectedFeeder = null;
  //                                                 maintenanceType = null;
  //                                                 _totalMiles.clear();
  //                                                 _costPerMile.clear();
  //                                                 _totalCost.clear();
  //                                                 budgetType = null;
  //                                                 _rowCycle.clear();
  //                                                 _nextMaintYear.clear();
  //                                                 _contractEndYear.clear();
  //                                                 contractorCompany = null;
  //                                                 selectedAssignForman = null;
  //                                               });
  //                                             });
  //                                             // Future.delayed(
  //                                             //     const Duration(seconds: 10));
  //                                             // Navigator.of(context).push(
  //                                             //     MaterialPageRoute(
  //                                             //         builder: (BuildContext
  //                                             //                 context) =>
  //                                             //             const AddNewRowMaintenancePlanTable()));
  //                                             // _showUpdateDataDialog();
  //                                           } else {
  //                                             print(
  //                                                 "Please fill all mendetory fields!!!");
  //                                           }
  //                                         },
  //                                         child: Container(
  //                                           margin: const EdgeInsets.only(
  //                                               left: 40,
  //                                               right: 40,
  //                                               bottom: 10.0),
  //                                           padding: const EdgeInsets.all(8),
  //                                           alignment: Alignment.center,
  //                                           width: MediaQuery.of(context)
  //                                               .size
  //                                               .width,
  //                                           height: 40,
  //                                           decoration: BoxDecoration(
  //                                               // shape: BoxShape.circle,
  //                                               borderRadius:
  //                                                   BorderRadius.circular(10),
  //                                               boxShadow: const [
  //                                                 BoxShadow(
  //                                                     color: Color.fromARGB(
  //                                                         255, 3, 47, 97),
  //                                                     blurRadius: 5,
  //                                                     offset: Offset(2.0, 5.0))
  //                                               ],
  //                                               color: const Color.fromARGB(
  //                                                   255, 130, 193, 245),
  //                                               gradient: const LinearGradient(
  //                                                 colors: [
  //                                                   Color.fromARGB(
  //                                                       255, 7, 59, 120),
  //                                                   Color.fromARGB(
  //                                                       255, 7, 59, 120)
  //                                                 ],
  //                                               )),
  //                                           child: const Row(children: [
  //                                             Expanded(
  //                                               child: Align(
  //                                                 alignment: Alignment.center,
  //                                                 child: Text(
  //                                                   'Add New',
  //                                                   textAlign: TextAlign.left,
  //                                                   style: TextStyle(
  //                                                     color: Colors.white,
  //                                                     fontWeight:
  //                                                         FontWeight.bold,
  //                                                     fontSize: 20,
  //                                                   ),
  //                                                 ),
  //                                               ),
  //                                             ),
  //                                           ]),
  //                                         ),
  //                                       ),
  //                                     )),
  //                               ],
  //                             ),
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 ));

  //               default:
  //                 return const Text('data');
  //             }
  //           })));
  // }

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

  // void fetchData(
  //     String substationId,
  //     String action,
  //     String name1,
  //     String supervisorId,
  //     String loginId,
  //     String substationName,
  //     String year,
  //     String feeder) {
  //   addNewRowMaintenancePlanViewModel.fetchAddNewRowMaintenancePlanViewListApi(
  //       context,
  //       substationId,
  //       action,
  //       name1,
  //       supervisorId,
  //       loginId,
  //       substationName,
  //       year,
  //       feeder);
  // }

  // String getFeederNameById(String id) {
  //   var feederList = addNewRowMaintenancePlanViewModel
  //       .addNewRowMaintenancePlanList.data!.getIdAndFeederBySubstationId!;

  //   for (var feeder in feederList) {
  //     if (feeder.id.toString() == id) {
  //       return feeder.feeder.toString();
  //     }
  //   }
  //   return 'Feeder Not Found';
  // }

  // String getSubstationNameById(String id) {
  //   var substationList = addNewRowMaintenancePlanViewModel
  //       .addNewRowMaintenancePlanList.data!.getIdAndSubstation!;

  //   for (var subStation in substationList) {
  //     if (subStation.id.toString() == id) {
  //       return subStation.subStation.toString();
  //     }
  //   }
  //   return 'Substation Not Found';
  // }
}
