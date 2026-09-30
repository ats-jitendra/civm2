import 'package:CIVM/piedmont/models/add_budget_planning_model.dart';
import 'package:CIVM/piedmont/models/user_model.dart';
import 'package:CIVM/piedmont/resources/app_colors.dart';
import 'package:CIVM/piedmont/screens/admin_pannel/pemc_admin_new/adm_invoice_list.dart';
import 'package:CIVM/piedmont/screens/admin_pannel/pemc_admin_new/adm_service_order.dart';
import 'package:CIVM/piedmont/screens/admin_pannel/row_maintenance_view/add_crew_member.dart';
import 'package:CIVM/piedmont/screens/admin_pannel/row_maintenance_view/add_new_row_table.dart';
import 'package:CIVM/piedmont/screens/admin_pannel/row_maintenance_view/admin_pannel.dart';
import 'package:CIVM/piedmont/screens/admin_pannel/row_maintenance_view/approve_civm_access.dart';
import 'package:CIVM/piedmont/screens/admin_pannel/pemc_admin_new/inspection_zielies.dart';
import 'package:CIVM/piedmont/screens/admin_pannel/row_maintenance_view/ivm_maintenance_progress.dart';
import 'package:CIVM/piedmont/screens/admin_pannel/row_maintenance_view/view_budget_planning.dart';
import 'package:CIVM/piedmont/screens/leaflat_map/leaf_lat_map_wakeLock.dart';
import 'package:CIVM/piedmont/screens/map/provider/location_provider.dart';
import 'package:CIVM/piedmont/utils/common_functions.dart';
import 'package:CIVM/sharedPrefs/constants.dart';
import 'package:CIVM/piedmont/utils/user_pref.dart';
import 'package:CIVM/utils/user_pref.dart';
import 'package:CIVM/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../data/response/status.dart';
import '../../../view_model/add_budget_planning_third_view_model.dart';
import '../../login_page.dart';
import 'package:CIVM/piedmont/repository/map_url.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:CIVM/piedmont/screens/my_chrome_safari_map_recording.dart';

// ignore: must_be_immutable
class BudgetPlanningAdd extends StatefulWidget {
  String year;
  String date;
  String changeOrders;
  String midCycleLinePetrol;
  String midCycleSpray;
  String midCycleWorkOrder;
  String workOrders;
  String stormWork;
  String subSpray;
  List<L1>? l1;
  int id;
  BudgetPlanningAdd({
    Key? key,
    required this.year,
    required this.date,
    required this.changeOrders,
    required this.midCycleLinePetrol,
    required this.midCycleSpray,
    required this.midCycleWorkOrder,
    required this.workOrders,
    required this.stormWork,
    required this.subSpray,
    required this.l1,
    required this.id,
  }) : super(key: key);

  @override
  State<BudgetPlanningAdd> createState() => _BudgetPlanningAddState();
}

class _BudgetPlanningAddState extends State<BudgetPlanningAdd> {
  // int _currentIndex = 0;
  // final List<Widget> _children = [
  //   RowMaintenancePlan(),
  //   // BottomNavigationHomePage(),
  //   // BottomNavigationAccountPage()
  // ];
  List<String> menu = [];
  List updatedCard = [];

  // ignore: prefer_typing_uninitialized_variables
  var selectedSubstation;
  int substationId = 0;

  // ignore: prefer_typing_uninitialized_variables
  var selectedFeeder;
  int feederId = 0;

  final TextEditingController _changeOrders = TextEditingController();
  final TextEditingController _midCycleSpray = TextEditingController();
  final TextEditingController _forYear = TextEditingController();
  final TextEditingController _workOrders = TextEditingController();
  final TextEditingController _stormWork = TextEditingController();
  final TextEditingController _subSpray = TextEditingController();
  final TextEditingController _midCycleWorkOrder = TextEditingController();
  final TextEditingController _midCycleLinePetrol = TextEditingController();

  final TextEditingController _budget = TextEditingController();

  onTappedBar(int index) {
    setState(() {
      // _currentIndex = index;
    });
  }

  final gradientList = <List<Color>>[
    [
      const Color.fromARGB(255, 248, 223, 5),
      Colors.yellow,
    ],
    [
      const Color.fromARGB(255, 1, 113, 5),
      Colors.green,
    ],
    [
      Colors.red,
      const Color.fromARGB(255, 245, 18, 1),
    ],
    [
      Colors.blue,
      Colors.blue,
    ],
  ];

  AddBudgetPlanningThirdViewModel addBudgetPlanningThirdViewModel =
      AddBudgetPlanningThirdViewModel();

  DateTime date12 = DateTime.now();
  late String dateSelected12 = 'MM-dd-yyyy';
  Future<void> selectDate12(BuildContext context) async {
    final DateTime? picked12 = await showDatePicker(
        context: context,
        initialDate: date12,
        firstDate: DateTime(2010),
        lastDate: DateTime(2050));
    if (picked12 != null && picked12 != date12) {
      setState(() {
        date12 = picked12;
        // print(date12.toString());
        dateSelected12 = DateFormat('MM-dd-yyyy').format(picked12);
        // dateSelected13 =
        //     "${picked12.month.toString().padLeft(2, '0')}-${picked12.day.toString().padLeft(2, '0')}-${picked12.year - 2}";
      });
      // calculateKwReadDate();
    }
  }

  @override
  void initState() {
    addBudgetPlanningThirdViewModel.fetchAddBudgetPlanningThirdGetListApi(
        context, widget.id.toString(), '', widget.year);
    _setData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text(
            'Add Budget Planning',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: AppColors.baseColor,
        ),
        // drawer: DrawerManu(menu: menu),
        body: ChangeNotifierProvider<AddBudgetPlanningThirdViewModel>(
            create: (BuildContext context) => addBudgetPlanningThirdViewModel,
            child: Consumer<AddBudgetPlanningThirdViewModel>(
                builder: (context, value, _) {
              switch (value.addBudgetPlanningThirdGetData.status) {
                case Status.LOADING:
                  return const Center(child: CircularProgressIndicator());
                case Status.ERROR:
                  return
                      // CustomToastSnackBarProgressDialog.flushBarErrorMessage(
                      //     value.addBudgetPlanningThirdGetData.message.toString(),
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
                              'assets/empty_box_pemc.png',
                              height: 200,
                              width: 200,
                              fit: BoxFit.cover,
                            ),
                            const Center(
                              child: Text(
                                'Sorry, Data Not Found!',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: AppColors.baseColor,
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
                  return RefreshIndicator(
                    onRefresh: () async {
                      await addBudgetPlanningThirdViewModel
                          .fetchAddBudgetPlanningThirdGetListApi(
                              context, widget.id.toString(), '', widget.year);
                      _setData();
                    },
                    child: SingleChildScrollView(
                      child: DefaultTabController(
                        length: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Column(
                            children: [
                              Column(
                                children: [
                                  SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        Container(
                                          margin:
                                              const EdgeInsets.only(top: 10),
                                          child: Column(
                                            children: [
                                              const Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 2.0,
                                                        bottom: 2,
                                                        left: 8,
                                                        right: 8),
                                                    child: Text(
                                                      "FOR YEAR",
                                                      style: TextStyle(
                                                        fontSize: 16.0,
                                                        color:
                                                            AppColors.baseColor,
                                                      ),
                                                    ),
                                                  )),
                                              Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 2.0,
                                                          bottom: 2,
                                                          left: 8,
                                                          right: 8),
                                                  child: TextFormField(
                                                    enabled: false,
                                                    controller: _forYear,
                                                    style: const TextStyle(
                                                        color:
                                                            AppColors.baseColor,
                                                        fontSize: 16),
                                                    obscureText: false,
                                                    // keyboardType: TextInputType.number,
                                                    decoration:
                                                        const InputDecoration(
                                                      border: OutlineInputBorder(
                                                          // borderRadius: BorderRadius.circular(25),
                                                          ),
                                                      disabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: AppColors
                                                              .baseColor,
                                                        ),
                                                      ),
                                                      hintText: 'year',
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin:
                                              const EdgeInsets.only(top: 10),
                                          child: Column(
                                            children: [
                                              const Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 2.0,
                                                        bottom: 2,
                                                        left: 8,
                                                        right: 8),
                                                    child: Text(
                                                      "DATE",
                                                      style: TextStyle(
                                                        fontSize: 16.0,
                                                        color:
                                                            AppColors.baseColor,
                                                      ),
                                                    ),
                                                  )),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8.0,
                                                    right: 8,
                                                    top: 8),
                                                child: Container(
                                                  height: 60,
                                                  decoration: const BoxDecoration(
                                                      // shape: BoxShape.circle,
                                                      // borderRadius: BorderRadius.circular(25),
                                                      boxShadow: [],
                                                      gradient: LinearGradient(
                                                        colors: [
                                                          AppColors.baseColor,
                                                          AppColors.baseColor,
                                                        ],
                                                      )),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            1.0),
                                                    child: Container(
                                                      decoration: const BoxDecoration(
                                                          // shape: BoxShape.circle,
                                                          // borderRadius:
                                                          // BorderRadius.circular(25),
                                                          boxShadow: [],
                                                          gradient: LinearGradient(
                                                            colors: [
                                                              Color.fromARGB(
                                                                  255,
                                                                  253,
                                                                  249,
                                                                  249),
                                                              Color.fromARGB(
                                                                  255,
                                                                  253,
                                                                  249,
                                                                  249),
                                                            ],
                                                          )),
                                                      child: Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    top: 2),
                                                            child: IconButton(
                                                              icon: const Icon(Icons
                                                                  .calendar_month),
                                                              iconSize: 22,
                                                              color: AppColors
                                                                  .baseColor,
                                                              onPressed: () {
                                                                selectDate12(
                                                                    context);
                                                                // print(date);
                                                              },
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    left: 2),
                                                            child: Text(
                                                                dateSelected12,
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 16,
                                                                  color: AppColors
                                                                      .baseColor,
                                                                )),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin:
                                              const EdgeInsets.only(top: 10),
                                          child: Column(
                                            children: [
                                              const Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 2.0,
                                                        bottom: 2,
                                                        left: 8,
                                                        right: 8),
                                                    child: Text(
                                                      "CHANGE ORDERS",
                                                      style: TextStyle(
                                                        fontSize: 16.0,
                                                        color:
                                                            AppColors.baseColor,
                                                      ),
                                                    ),
                                                  )),
                                              Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 2.0,
                                                          bottom: 2,
                                                          left: 8,
                                                          right: 8),
                                                  child: TextFormField(
                                                    controller: _changeOrders,
                                                    style: const TextStyle(
                                                        color:
                                                            AppColors.baseColor,
                                                        fontSize: 16),
                                                    obscureText: false,
                                                    // keyboardType: TextInputType.number,
                                                    decoration:
                                                        const InputDecoration(
                                                      border: OutlineInputBorder(
                                                          // borderRadius: BorderRadius.circular(25),
                                                          ),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: AppColors
                                                              .baseColor,
                                                        ),
                                                        // borderRadius: BorderRadius.circular(25),
                                                      ),
                                                      hintText: 'change orders',
                                                      // prefixIcon:  Icon(
                                                      //   Icons.person,
                                                      //   color: AppColors.baseColor,
                                                      // ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin:
                                              const EdgeInsets.only(top: 10),
                                          child: Column(
                                            children: [
                                              const Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 2.0,
                                                        bottom: 2,
                                                        left: 8,
                                                        right: 8),
                                                    child: Text(
                                                      "MIDCYCLE LINE PATROL",
                                                      style: TextStyle(
                                                        fontSize: 16.0,
                                                        color:
                                                            AppColors.baseColor,
                                                      ),
                                                    ),
                                                  )),
                                              Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 2.0,
                                                          bottom: 2,
                                                          left: 8,
                                                          right: 8),
                                                  child: TextFormField(
                                                    controller:
                                                        _midCycleLinePetrol,
                                                    style: const TextStyle(
                                                        color:
                                                            AppColors.baseColor,
                                                        fontSize: 16),
                                                    obscureText: false,
                                                    // keyboardType: TextInputType.number,
                                                    decoration:
                                                        const InputDecoration(
                                                      border: OutlineInputBorder(
                                                          // borderRadius: BorderRadius.circular(25),
                                                          ),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: AppColors
                                                              .baseColor,
                                                        ),
                                                        // borderRadius: BorderRadius.circular(25),
                                                      ),
                                                      hintText:
                                                          'midcycle line petrol',
                                                      // prefixIcon:  Icon(
                                                      //   Icons.person,
                                                      //   color: AppColors.baseColor,
                                                      // ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin:
                                              const EdgeInsets.only(top: 10),
                                          child: Column(
                                            children: [
                                              const Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 2.0,
                                                        bottom: 2,
                                                        left: 8,
                                                        right: 8),
                                                    child: Text(
                                                      "MIDCYCLE SPRAY",
                                                      style: TextStyle(
                                                        fontSize: 16.0,
                                                        color:
                                                            AppColors.baseColor,
                                                      ),
                                                    ),
                                                  )),
                                              Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 2.0,
                                                          bottom: 2,
                                                          left: 8,
                                                          right: 8),
                                                  child: TextFormField(
                                                    controller: _midCycleSpray,
                                                    style: const TextStyle(
                                                        color:
                                                            AppColors.baseColor,
                                                        fontSize: 16),
                                                    obscureText: false,
                                                    // keyboardType: TextInputType.number,
                                                    decoration:
                                                        const InputDecoration(
                                                      border: OutlineInputBorder(
                                                          // borderRadius: BorderRadius.circular(25),
                                                          ),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: AppColors
                                                              .baseColor,
                                                        ),
                                                        // borderRadius: BorderRadius.circular(25),
                                                      ),
                                                      hintText:
                                                          'midcycle spray',
                                                      // prefixIcon:  Icon(
                                                      //   Icons.person,
                                                      //   color: AppColors.baseColor,
                                                      // ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin:
                                              const EdgeInsets.only(top: 10),
                                          child: Column(
                                            children: [
                                              const Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 2.0,
                                                        bottom: 2,
                                                        left: 8,
                                                        right: 8),
                                                    child: Text(
                                                      "MIDCYCLE WORK ORDERS",
                                                      style: TextStyle(
                                                        fontSize: 16.0,
                                                        color:
                                                            AppColors.baseColor,
                                                      ),
                                                    ),
                                                  )),
                                              Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 2.0,
                                                          bottom: 2,
                                                          left: 8,
                                                          right: 8),
                                                  child: TextFormField(
                                                    controller:
                                                        _midCycleWorkOrder,
                                                    style: const TextStyle(
                                                        color:
                                                            AppColors.baseColor,
                                                        fontSize: 16),
                                                    obscureText: false,
                                                    // keyboardType: TextInputType.number,
                                                    decoration:
                                                        const InputDecoration(
                                                      border: OutlineInputBorder(
                                                          // borderRadius: BorderRadius.circular(25),
                                                          ),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: AppColors
                                                              .baseColor,
                                                        ),
                                                        // borderRadius: BorderRadius.circular(25),
                                                      ),
                                                      hintText:
                                                          'midcycle work order',
                                                      // prefixIcon:  Icon(
                                                      //   Icons.person,
                                                      //   color: AppColors.baseColor,
                                                      // ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin:
                                              const EdgeInsets.only(top: 10),
                                          child: Column(
                                            children: [
                                              const Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 2.0,
                                                        bottom: 2,
                                                        left: 8,
                                                        right: 8),
                                                    child: Text(
                                                      "WORK ORDERS",
                                                      style: TextStyle(
                                                        fontSize: 16.0,
                                                        color:
                                                            AppColors.baseColor,
                                                      ),
                                                    ),
                                                  )),
                                              Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 2.0,
                                                          bottom: 2,
                                                          left: 8,
                                                          right: 8),
                                                  child: TextFormField(
                                                    controller: _workOrders,
                                                    style: const TextStyle(
                                                        color:
                                                            AppColors.baseColor,
                                                        fontSize: 16),
                                                    obscureText: false,
                                                    // keyboardType: TextInputType.number,
                                                    decoration:
                                                        const InputDecoration(
                                                      border: OutlineInputBorder(
                                                          // borderRadius: BorderRadius.circular(25),
                                                          ),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: AppColors
                                                              .baseColor,
                                                        ),
                                                        // borderRadius: BorderRadius.circular(25),
                                                      ),
                                                      hintText: 'work orders',
                                                      // prefixIcon:  Icon(
                                                      //   Icons.person,
                                                      //   color: AppColors.baseColor,
                                                      // ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin:
                                              const EdgeInsets.only(top: 10),
                                          child: Column(
                                            children: [
                                              const Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 2.0,
                                                        bottom: 2,
                                                        left: 8,
                                                        right: 8),
                                                    child: Text(
                                                      "STORM WORK",
                                                      style: TextStyle(
                                                        fontSize: 16.0,
                                                        color:
                                                            AppColors.baseColor,
                                                      ),
                                                    ),
                                                  )),
                                              Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 2.0,
                                                          bottom: 2,
                                                          left: 8,
                                                          right: 8),
                                                  child: TextFormField(
                                                    controller: _stormWork,
                                                    style: const TextStyle(
                                                        color:
                                                            AppColors.baseColor,
                                                        fontSize: 16),
                                                    obscureText: false,
                                                    // keyboardType: TextInputType.number,
                                                    decoration:
                                                        const InputDecoration(
                                                      border: OutlineInputBorder(
                                                          // borderRadius: BorderRadius.circular(25),
                                                          ),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: AppColors
                                                              .baseColor,
                                                        ),
                                                        // borderRadius: BorderRadius.circular(25),
                                                      ),
                                                      hintText: 'storm work',
                                                      // prefixIcon:  Icon(
                                                      //   Icons.person,
                                                      //   color: AppColors.baseColor,
                                                      // ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin:
                                              const EdgeInsets.only(top: 10),
                                          child: Column(
                                            children: [
                                              const Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 2.0,
                                                        bottom: 2,
                                                        left: 8,
                                                        right: 8),
                                                    child: Text(
                                                      "SUB SPRAY",
                                                      style: TextStyle(
                                                        fontSize: 16.0,
                                                        color:
                                                            AppColors.baseColor,
                                                      ),
                                                    ),
                                                  )),
                                              Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 2.0,
                                                          bottom: 2,
                                                          left: 8,
                                                          right: 8),
                                                  child: TextFormField(
                                                    controller: _subSpray,
                                                    style: const TextStyle(
                                                        color:
                                                            AppColors.baseColor,
                                                        fontSize: 16),
                                                    obscureText: false,
                                                    // keyboardType: TextInputType.number,
                                                    decoration:
                                                        const InputDecoration(
                                                      border: OutlineInputBorder(
                                                          // borderRadius: BorderRadius.circular(25),
                                                          ),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: AppColors
                                                              .baseColor,
                                                        ),
                                                        // borderRadius: BorderRadius.circular(25),
                                                      ),
                                                      hintText: 'sub spray',
                                                      // prefixIcon:  Icon(
                                                      //   Icons.person,
                                                      //   color: AppColors.baseColor,
                                                      // ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(
                                              left: 8,
                                              right: 8,
                                              top: 10,
                                              bottom: 8),
                                          padding: const EdgeInsets.all(8),
                                          alignment: Alignment.center,
                                          height: size.height * 0.6,
                                          width: size.width * 0.99,
                                          decoration: BoxDecoration(
                                              // shape: BoxShape.circle,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              boxShadow: const [
                                                BoxShadow(
                                                    color:
                                                        AppColors.buttonShadow,
                                                    blurRadius: 10,
                                                    offset: Offset(2.0, 5.0))
                                              ],
                                              gradient: const LinearGradient(
                                                colors: [
                                                  Color.fromARGB(
                                                      255, 255, 255, 255),
                                                  Color.fromARGB(
                                                      255, 255, 255, 255),
                                                ],
                                              )),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8.0, bottom: 8),
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  alignment: Alignment.center,
                                                  width: size.width * 0.99,
                                                  // width: MediaQuery.of(context).size.width,
                                                  // height: 40,
                                                  decoration:
                                                      const BoxDecoration(
                                                          // shape: BoxShape.circle,
                                                          //borderRadius: BorderRadius.circular(25),
                                                          boxShadow: [
                                                        BoxShadow(
                                                            color: AppColors
                                                                .buttonShadow,
                                                            blurRadius: 5,
                                                            offset: Offset(
                                                                2.0, 5.0))
                                                      ],
                                                          color: Color.fromARGB(
                                                              255,
                                                              130,
                                                              193,
                                                              245),
                                                          gradient:
                                                              LinearGradient(
                                                            colors: [
                                                              AppColors
                                                                  .baseColor,
                                                              AppColors
                                                                  .buttonOrange,
                                                              AppColors
                                                                  .baseColor,
                                                            ],
                                                          )),
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Row(
                                                      children: [
                                                        const Expanded(
                                                          child: Text(
                                                            "LCP WORK",
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 20,
                                                            ),
                                                          ),
                                                        ),
                                                        InkWell(
                                                          onTap: () {
                                                            openDailogAdd();
                                                          },
                                                          child: const Icon(
                                                            Icons.add,
                                                            color: Colors.red,
                                                            size: 30,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: ListView.builder(
                                                    itemCount:
                                                        widget.l1!.length,
                                                    itemBuilder:
                                                        (BuildContext ctxt,
                                                            int index) {
                                                      return Row(
                                                        children: [
                                                          Expanded(
                                                            flex: 1,
                                                            child: Container(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.28,
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height *
                                                                  0.15,
                                                              // height: 190,
                                                              margin:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      left: 4.0,
                                                                      top: 5.0,
                                                                      bottom:
                                                                          5.0),
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8),
                                                              decoration:
                                                                  BoxDecoration(
                                                                gradient:
                                                                    LinearGradient(
                                                                  colors: [
                                                                    AppColors
                                                                        .green1
                                                                        .withOpacity(
                                                                            0.9),
                                                                    AppColors
                                                                        .green2
                                                                        .withOpacity(
                                                                            0.7),
                                                                    AppColors
                                                                        .green1
                                                                        .withOpacity(
                                                                            0.9),
                                                                  ],
                                                                  begin: Alignment
                                                                      .topLeft,
                                                                  end: Alignment
                                                                      .bottomRight,
                                                                ),
                                                                border:
                                                                    Border.all(
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                                borderRadius:
                                                                    const BorderRadius
                                                                        .only(
                                                                  topRight: Radius
                                                                      .circular(
                                                                          10),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          10),
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          10),
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          10),
                                                                ),
                                                              ),
                                                              child: Column(
                                                                  children: [
                                                                    Expanded(
                                                                      //  flex: 4,
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          const Align(
                                                                            alignment:
                                                                                Alignment.topLeft,
                                                                            child:
                                                                                Text(
                                                                              "SUBSTATION :",
                                                                              textAlign: TextAlign.left,
                                                                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
                                                                            ),
                                                                          ),
                                                                          Align(
                                                                            alignment:
                                                                                Alignment.topLeft,
                                                                            child:
                                                                                Text(
                                                                              (widget.l1![index].substation == null || widget.l1![index].substation.toString() == 'null' || widget.l1![index].substation.toString().isEmpty) ? '' : widget.l1![index].substation.toString(),
                                                                              textAlign: TextAlign.left,
                                                                              style: const TextStyle(
                                                                                  fontSize: 12,
                                                                                  // fontWeight:
                                                                                  //     FontWeight.bold,
                                                                                  color: Colors.white),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ]),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 2,
                                                            child: Container(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.25,
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height *
                                                                  0.15,
                                                              margin:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      right:
                                                                          4.0,
                                                                      top: 5.0,
                                                                      bottom:
                                                                          5.0),
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8),
                                                              decoration:
                                                                  BoxDecoration(
                                                                      color: Colors
                                                                          .white,
                                                                      border:
                                                                          Border
                                                                              .all(
                                                                        color: AppColors
                                                                            .baseColor,
                                                                      ),
                                                                      borderRadius: const BorderRadius
                                                                          .only(
                                                                          topRight: Radius.circular(
                                                                              10),
                                                                          bottomRight:
                                                                              Radius.circular(10))),
                                                              child: Column(
                                                                  children: [
                                                                    Row(
                                                                      children: [
                                                                        Expanded(
                                                                          child:
                                                                              Row(
                                                                            children: [
                                                                              Expanded(
                                                                                // alignment: Alignment.topLeft,
                                                                                child: Column(
                                                                                  children: [
                                                                                    const Align(
                                                                                      alignment: Alignment.topLeft,
                                                                                      child: Text(
                                                                                        "AMOUNT: ",
                                                                                        textAlign: TextAlign.left,
                                                                                        style: TextStyle(
                                                                                          fontSize: 12,
                                                                                          fontWeight: FontWeight.bold,
                                                                                          color: AppColors.baseColor,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    Align(
                                                                                      alignment: Alignment.topLeft,
                                                                                      child: Text(
                                                                                        (widget.l1![index].amount == null || widget.l1![index].amount.toString() == 'null' || widget.l1![index].amount.toString().isEmpty) ? '' : widget.l1![index].amount.toString(),
                                                                                        textAlign: TextAlign.left,
                                                                                        style: const TextStyle(
                                                                                          fontSize: 12,
                                                                                          //  fontWeight:
                                                                                          //      FontWeight.bold,
                                                                                          color: AppColors.baseColor,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                              Expanded(
                                                                                // alignment: Alignment.topLeft,
                                                                                child: Column(
                                                                                  children: [
                                                                                    const Align(
                                                                                      alignment: Alignment.topLeft,
                                                                                      child: Text(
                                                                                        "DELETE: ",
                                                                                        textAlign: TextAlign.left,
                                                                                        style: TextStyle(
                                                                                          fontSize: 12,
                                                                                          fontWeight: FontWeight.bold,
                                                                                          color: AppColors.baseColor,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    Align(
                                                                                        alignment: Alignment.topLeft,
                                                                                        child: InkWell(
                                                                                          onTap: () {
                                                                                            setState(() {
                                                                                              widget.l1!.removeAt(index);
                                                                                              // addBudgetPlanningThirdViewModel.fetchAddBudgetPlanningDeleteDataApi(context, widget.id.toString());
                                                                                            });
                                                                                          },
                                                                                          child: const Icon(
                                                                                            Icons.delete,
                                                                                            color: Colors.red,
                                                                                            size: 20,
                                                                                          ),
                                                                                        )),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    const Divider(
                                                                      color: Colors
                                                                          .grey,
                                                                    ),
                                                                    Row(
                                                                      children: [
                                                                        Expanded(
                                                                          child:
                                                                              Row(
                                                                            children: [
                                                                              Expanded(
                                                                                // alignment: Alignment.topLeft,
                                                                                child: Column(
                                                                                  children: [
                                                                                    const Align(
                                                                                      alignment: Alignment.topLeft,
                                                                                      child: Text(
                                                                                        "FEEDER: ",
                                                                                        textAlign: TextAlign.left,
                                                                                        style: TextStyle(
                                                                                          fontSize: 12,
                                                                                          fontWeight: FontWeight.bold,
                                                                                          color: AppColors.baseColor,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    Align(
                                                                                      alignment: Alignment.topLeft,
                                                                                      child: Text(
                                                                                        (widget.l1![index].feeder == null || widget.l1![index].feeder.toString() == 'null' || widget.l1![index].feeder.toString().isEmpty) ? '' : widget.l1![index].feeder.toString(),
                                                                                        textAlign: TextAlign.left,
                                                                                        style: const TextStyle(
                                                                                          fontSize: 12,
                                                                                          //  fontWeight:
                                                                                          //      FontWeight.bold,
                                                                                          color: AppColors.baseColor,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ]),
                                                            ),
                                                          ),
                                                        ],
                                                      );
                                                    }),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                            margin: const EdgeInsets.only(
                                                left: 6,
                                                right: 6,
                                                bottom: 10,
                                                top: 8),
                                            child: InkWell(
                                              onTap: () async {
                                                Map mappedData = {
                                                  "budgetId": (addBudgetPlanningThirdViewModel
                                                              .addBudgetPlanningThirdGetData
                                                              .data!
                                                              .getInsertedBudgetId![
                                                                  0]
                                                              .toString() ==
                                                          'null')
                                                      ? ''
                                                      : addBudgetPlanningThirdViewModel
                                                          .addBudgetPlanningThirdGetData
                                                          .data!
                                                          .getInsertedBudgetId![
                                                              0]
                                                          .toString(),
                                                  "date":
                                                      (dateSelected12 == 'null')
                                                          ? ''
                                                          : dateSelected12,
                                                  "changeOrders": (_changeOrders
                                                              .text
                                                              .toString() ==
                                                          'null')
                                                      ? ''
                                                      : _changeOrders.text
                                                          .toString(),
                                                  "midCycleLinePatrol":
                                                      (_midCycleLinePetrol.text
                                                                  .toString() ==
                                                              'null')
                                                          ? ''
                                                          : _midCycleLinePetrol
                                                              .text
                                                              .toString(),
                                                  "midCycleSpray":
                                                      (_midCycleSpray.text
                                                                  .toString() ==
                                                              'null')
                                                          ? ''
                                                          : _midCycleSpray.text
                                                              .toString(),
                                                  "midCycleWorkOrders":
                                                      (_midCycleWorkOrder.text
                                                                  .toString() ==
                                                              'null')
                                                          ? ''
                                                          : _midCycleWorkOrder
                                                              .text
                                                              .toString(),
                                                  "workOrders": (_workOrders
                                                              .text
                                                              .toString() ==
                                                          'null')
                                                      ? ''
                                                      : _workOrders.text
                                                          .toString(),
                                                  "stormWork": (_stormWork.text
                                                              .toString() ==
                                                          'null')
                                                      ? ''
                                                      : _stormWork.text
                                                          .toString(),
                                                  "subSpray": (_subSpray.text
                                                              .toString() ==
                                                          'null')
                                                      ? ''
                                                      : _subSpray.text
                                                          .toString(),
                                                  "year": widget.year
                                                };
                                                print(mappedData);

                                                addBudgetPlanningThirdViewModel
                                                    .fetchAddBudgedtPlanningThirdBoxInsertListApi(
                                                        context, mappedData);

                                                // await Future.delayed(
                                                //     const Duration(seconds: 5));
                                                // addBudgetPlanningThirdViewModel
                                                //     .fetchAddBudgetPlanningThirdGetListApi(
                                                //         context,
                                                //         widget.id.toString(),
                                                //         selectedSubstation,
                                                //         widget.year);
                                                await Future.delayed(
                                                    const Duration(seconds: 5));
                                                updatedCard.clear();
                                                for (var element
                                                    in widget.l1!) {
                                                  updatedCard.add({
                                                    "planDtlsId": '0',
                                                    "substation":
                                                        element.substation,
                                                    "feeder": element.feeder,
                                                    "amount": element.amount,
                                                    "year": widget.year
                                                  });
                                                }

                                                print(updatedCard);
                                                await Future.delayed(
                                                    const Duration(seconds: 5));
                                                addBudgetPlanningThirdViewModel
                                                    .fetchAddBudgedtPlanningThirdInsertListApi(
                                                        context, updatedCard);
                                                Future.delayed(
                                                    const Duration(seconds: 1),
                                                    () {
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (BuildContext
                                                                  context) =>
                                                              ViewBudgetPlanning(
                                                                  year: widget
                                                                      .year)));
                                                });
                                              },
                                              child: Container(
                                                margin: const EdgeInsets.only(
                                                    left: 40,
                                                    right: 40,
                                                    bottom: 10.0),
                                                // padding: const EdgeInsets.all(8),
                                                alignment: Alignment.center,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: 40,
                                                decoration: const BoxDecoration(
                                                    // shape: BoxShape.circle,
                                                    // borderRadius: BorderRadius.circular(25),
                                                    boxShadow: [
                                                      BoxShadow(
                                                          color: AppColors
                                                              .buttonShadow,
                                                          blurRadius: 5,
                                                          offset:
                                                              Offset(2.0, 5.0))
                                                    ],
                                                    color: Colors.black,
                                                    gradient: LinearGradient(
                                                      colors: [
                                                        AppColors.baseColor,
                                                        AppColors.baseColor,
                                                      ],
                                                    )),
                                                child: const Row(children: [
                                                  Expanded(
                                                    child: Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                        "Submit",
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 20,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ]),
                                              ),
                                            )),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );

                default:
                  return const Text('data');
              }
            })));
  }

  _setData() {
    _forYear.text = widget.year;
    dateSelected12 = widget.date;
    _changeOrders.text = widget.changeOrders;
    _midCycleLinePetrol.text = widget.midCycleLinePetrol;
    _midCycleSpray.text = widget.midCycleSpray;
    _midCycleWorkOrder.text = widget.midCycleWorkOrder;
    _workOrders.text = widget.workOrders;
    _stormWork.text = widget.stormWork;
    _subSpray.text = widget.subSpray;
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
      value: item,
      child: Text(item,
          style: const TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 20,
          )));

  Future openDailogAdd() => showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: Column(
                      children: [
                        const Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.all(2.0),
                              child: Text(
                                "SUBSTATION",
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: AppColors.baseColor,
                                ),
                              ),
                            )),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: DropdownButtonFormField<String>(
                              hint: const Text('-Select-'),
                              dropdownColor: Colors.white,
                              value: selectedSubstation,
                              style: const TextStyle(
                                  color: AppColors.baseColor, fontSize: 16),
                              icon: const Icon(
                                Icons.arrow_drop_down,
                                color: AppColors.baseColor,
                                size: 40,
                              ),
                              decoration: const InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColors.baseColor,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColors.baseColor,
                                  ),
                                ),
                              ),
                              isExpanded: true,
                              items: addBudgetPlanningThirdViewModel
                                  .addBudgetPlanningThirdGetData
                                  .data!
                                  .getDistinctSubstationbdgtPage3List!
                                  .map((e) {
                                return DropdownMenuItem(
                                  value: e.substation.toString(),
                                  child: Text(e.substation.toString()),
                                );
                              }).toList(),
                              onChanged: (val) {
                                Navigator.pop(context);
                                if (selectedFeeder != null) {
                                  selectedFeeder = null;
                                }
                                setState(() {
                                  selectedSubstation = val;
                                });
                                fetchData(selectedSubstation);
                              },
                              validator: (value) =>
                                  value == null ? 'field required' : null,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: Column(
                      children: [
                        const Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.all(2.0),
                              child: Text(
                                "FEEDER",
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: AppColors.baseColor,
                                ),
                              ),
                            )),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: DropdownButtonFormField<String>(
                              hint: const Text('-Select-'),
                              dropdownColor: Colors.white,
                              value: selectedFeeder,
                              style: const TextStyle(
                                  color: AppColors.baseColor, fontSize: 16),
                              icon: const Icon(
                                Icons.arrow_drop_down,
                                color: AppColors.baseColor,
                                size: 40,
                              ),
                              decoration: const InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColors.baseColor,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColors.baseColor,
                                  ),
                                ),
                              ),
                              isExpanded: true,
                              items: addBudgetPlanningThirdViewModel
                                  .addBudgetPlanningThirdGetData
                                  .data!
                                  .getDistinctFeederList!
                                  .map((e) {
                                return DropdownMenuItem(
                                  value: e.feeder.toString(),
                                  child: Text(e.feeder.toString()),
                                );
                              }).toList(),
                              onChanged: (val) {
                                setState(() {
                                  selectedFeeder = val;
                                });
                              },
                              validator: (value) =>
                                  value == null ? 'field required' : null,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: Column(
                      children: [
                        const Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.all(2.0),
                              child: Text(
                                "BUDGET",
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: AppColors.baseColor,
                                ),
                              ),
                            )),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: TextFormField(
                              //  key: formkey2,
                              controller: _budget,
                              style: const TextStyle(
                                  color: AppColors.baseColor, fontSize: 16),
                              obscureText: false,
                              // keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColors.baseColor,
                                  ),
                                ),
                                hintText: 'budget',
                              ),

                              validator: (value) {
                                if (value.toString() == '') {
                                  return "Please enter budget";
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              Container(
                  margin: const EdgeInsets.only(left: 6, right: 6, bottom: 10),
                  child: InkWell(
                    onTap: () {
                      print('a');
                      widget.l1!.add(L1(
                          amount: _budget.text.toString(),
                          feeder: selectedFeeder.toString(),
                          substation: selectedSubstation.toString()));

                      // print(addBudgetPlanningViewModel
                      //     .addBudgetPlanningGetData
                      //     .data!
                      //     .getBudgetPlanningOfSubstationFdrAmtByBudgetIdList!
                      //     .length);

                      print(updatedCard);
                      Navigator.pop(context);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(
                          left: 40, right: 40, bottom: 10.0),
                      // padding: const EdgeInsets.all(8),
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      height: 40,
                      decoration: const BoxDecoration(
                          // shape: BoxShape.circle,
                          // borderRadius: BorderRadius.circular(25),
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromARGB(255, 1, 87, 3),
                                blurRadius: 5,
                                offset: Offset(2.0, 5.0))
                          ],
                          color: Colors.black,
                          gradient: LinearGradient(
                            colors: [
                              Colors.green,
                              Colors.green,
                            ],
                          )),
                      child: const Row(children: [
                        Expanded(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Add",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      ]),
                    ),
                  )),
            ],
          );
        });
      });

  void fetchData(selectedSubstation) {
    addBudgetPlanningThirdViewModel.fetchAddBudgetPlanningThirdGetListApi(
        context, widget.id.toString(), selectedSubstation, widget.year);
  }
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
    var provider = Provider.of<LocationProviderPemc>(context, listen: true);
    final browser = MyChromeSafariBrowser();
    return Drawer(
      child: SafeArea(
        child: Column(
          // Important: Remove any padding from the ListView.
          // padding: EdgeInsets.zero,
          children: [
            Container(
              width: double.infinity,
              height: 180,
              color: AppColors.lighterBaseColor,
              padding: const EdgeInsets.only(top: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  menuLogo(),
                  const SizedBox(height: 6),
                  Text(
                    userName,
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    leading: const Icon(
                      Icons.computer,
                    ),
                    title: const Text('Row Maintenance Plan'),
                    textColor: AppColors.baseColor,
                    iconColor: AppColors.baseColor,
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const EnergyAuditPannel()));
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.compare,
                    ),
                    title: const Text('Inspection'),
                    textColor: AppColors.baseColor,
                    iconColor: AppColors.baseColor,
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const InspectionZielies()));
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.pending,
                    ),
                    title: const Text('Service Order'),
                    textColor: AppColors.baseColor,
                    iconColor: AppColors.baseColor,
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const AdmServiceOrder()));
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.airplane_ticket_sharp,
                    ),
                    title: const Text('Job List'),
                    textColor: AppColors.baseColor,
                    iconColor: AppColors.baseColor,
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              AdminAddNewRowTable(index: '0')));
                      // Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (BuildContext context) => AddNewRowMaintenancePlan(
                      //           tokenNo: '',
                      //           index: '0',
                      //           subStation: '',
                      //           feeder: '',
                      //           nextMaintYear: '',
                      //           maintType: '',
                      //           totalMiles: '',
                      //           costPerMile: '',
                      //           totalCost: '',
                      //           budgetType: '',
                      //           contractRowYear: '',
                      //           rowCycle: '',
                      //           rowYear: '',
                      //           contractorCompany: '',
                      //           assignForeman: '',
                      //         )));
                    },
                  ),
                  // Visibility(
                  //   visible: (widget.menu.isNotEmpty &&
                  //           widget.menu.contains('Energy Audit Ticket'))
                  //       ? true
                  //       : false,
                  // child:
                  ///////////new added maps for PEMC
                  ListTile(
                    leading: const Icon(
                      Icons.vertical_distribute,
                    ),
                    title: const Text('Add ROW Distribution Map'),
                    textColor: AppColors.baseColor,
                    iconColor: AppColors.baseColor,
                    onTap: () async {
                      String id = '';
                      final userPreferences1 =
                          Provider.of<UserPref>(context, listen: false);
                      UserModel data = await userPreferences1.getUser();
                      id = data.user!.id.toString();
                      await browser.open(
                          url: WebUri(
                              MapUrl.getPlannerDistributionMapEndPoint(id)),
                          settings: ChromeSafariBrowserSettings(
                              shareState: CustomTabsShareState.SHARE_STATE_OFF,
                              barCollapsingEnabled: true));
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.maps_ugc,
                    ),
                    title: const Text('Add ROW Transmission Map'),
                    textColor: AppColors.baseColor,
                    iconColor: AppColors.baseColor,
                    onTap: () async {
                      String id = '';
                      final userPreferences1 =
                          Provider.of<UserPref>(context, listen: false);
                      UserModel data = await userPreferences1.getUser();
                      id = data.user!.id.toString();
                      await browser.open(
                          url: WebUri(
                              MapUrl.getPlannerTransmissionMapEndPoint(id)),
                          settings: ChromeSafariBrowserSettings(
                              shareState: CustomTabsShareState.SHARE_STATE_OFF,
                              barCollapsingEnabled: true));
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.map,
                    ),
                    title: const Text('Add Herbicide Transmission Map'),
                    textColor: AppColors.baseColor,
                    iconColor: AppColors.baseColor,
                    onTap: () async {
                      String id = '';
                      final userPreferences1 =
                          Provider.of<UserPref>(context, listen: false);
                      UserModel data = await userPreferences1.getUser();
                      id = data.user!.id.toString();
                      await browser.open(
                          url: WebUri(MapUrl.midTransmissionMapEndPoint(id)),
                          settings: ChromeSafariBrowserSettings(
                              shareState: CustomTabsShareState.SHARE_STATE_OFF,
                              barCollapsingEnabled: true));
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.maps_ugc_rounded,
                    ),
                    title: const Text('Add Annual Herbicide Map'),
                    textColor: AppColors.baseColor,
                    iconColor: AppColors.baseColor,
                    onTap: () async {
                      String id = '';
                      final userPreferences1 =
                          Provider.of<UserPref>(context, listen: false);
                      UserModel data = await userPreferences1.getUser();
                      id = data.user!.id.toString();
                      await browser.open(
                          url: WebUri(MapUrl.officeTransmissionMapEndPoint(id)),
                          settings: ChromeSafariBrowserSettings(
                              shareState: CustomTabsShareState.SHARE_STATE_OFF,
                              barCollapsingEnabled: true));
                    },
                  ),

                  ////////////////////////////////////
                  ListTile(
                    leading: const Icon(
                      Icons.open_in_new,
                    ),
                    title: const Text('IVM Maintenance Progress'),
                    textColor: AppColors.baseColor,
                    iconColor: AppColors.baseColor,
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const RowMaintenanceProgress()));
                    },
                  ),
                  // ),
                  // ListTile(
                  //   leading: const Icon(
                  //     Icons.closed_caption_off,
                  //   ),
                  //   title: const Text('Row Analytics Dashboard'),
                  //   textColor: AppColors.baseColor,
                  //   iconColor: AppColors.baseColor,
                  //   onTap: () {
                  //     Navigator.of(context).push(MaterialPageRoute(
                  //         builder: (BuildContext context) =>
                  //             const RowAnalyticsDashboard()));
                  //   },
                  // ),
                  ListTile(
                    leading: const Icon(
                      Icons.list,
                    ),
                    title: const Text('Invoice List'),
                    textColor: AppColors.baseColor,
                    iconColor: AppColors.baseColor,
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const AdmInvoiceList()));
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.data_usage,
                    ),
                    title: const Text('Budget Planning'),
                    textColor: AppColors.baseColor,
                    iconColor: AppColors.baseColor,
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),

                  ListTile(
                    leading: const Icon(
                      Icons.location_on,
                    ),
                    title: const Text('Live IVM System Map'),
                    textColor: AppColors.baseColor,
                    iconColor: AppColors.baseColor,
                    onTap: () {
                      provider.getLocation();
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const MapScreenLeafLat()));
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.check,
                    ),
                    title: const Text('Approve CIVM Access'),
                    textColor: AppColors.baseColor,
                    iconColor: AppColors.baseColor,
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const ApproveCIVMAccess()));
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.add,
                    ),
                    title: const Text('Add Crew Member'),
                    textColor: AppColors.baseColor,
                    iconColor: AppColors.baseColor,
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const AddCrewMember()));
                    },
                  ),

                  ListTile(
                    leading: const Icon(
                      Icons.logout,
                    ),
                    title: const Text('Logout'),
                    textColor: AppColors.baseColor,
                    iconColor: AppColors.baseColor,
                    onTap: () {
                      // ants.prefs.setBool("LoggedIn", false);
                      userPreferences.remove().then((value) {
                        // ignore: use_build_context_synchronously
                        // Navigator.pushReplacement(context, RoutesName.login);
                        // Navigator.pushNamed(
                        //     context, RoutesName.login);
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const LoginPagePemc()));
                      });
                      // Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (BuildContext context) => const LoginPage()));
                    },
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Text(
                    'Version: ${Constants.prefs.getString('VERSION') ?? ''}',
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    'Updated: ${Constants.prefs.getString('VERSION_DATE') ?? ''}',
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> setUserName() async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    Image.network(
      'https://atsdev2test.ariespro.com/assets/clientuploads/${data.user!.profilePhoto}',
    );
    String imageUrl =
        'https://atsdev2test.ariespro.com/assets/clientuploads/${data.user!.profilePhoto}';
    _imagePath = imageUrl;
    setState(() {
      userName = '${data.user!.fName} ${data.user!.lName}';
    });
  }
}
