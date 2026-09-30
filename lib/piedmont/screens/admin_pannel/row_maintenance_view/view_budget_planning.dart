import 'package:CIVM/piedmont/screens/admin_pannel/pemc_admin_new/adm_invoice_list.dart';
import 'package:CIVM/piedmont/screens/admin_pannel/pemc_admin_new/adm_service_order.dart';
import 'package:CIVM/piedmont/screens/admin_pannel/row_maintenance_view/add_crew_member.dart';
import 'package:CIVM/piedmont/screens/admin_pannel/row_maintenance_view/add_new_row_table.dart';
import 'package:CIVM/piedmont/screens/admin_pannel/row_maintenance_view/admin_pannel.dart';
import 'package:CIVM/piedmont/screens/admin_pannel/row_maintenance_view/approve_civm_access.dart';
import 'package:CIVM/piedmont/screens/admin_pannel/row_maintenance_view/budget_planning_add_second.dart';
import 'package:CIVM/piedmont/screens/admin_pannel/pemc_admin_new/inspection_zielies.dart';
import 'package:CIVM/piedmont/screens/admin_pannel/row_maintenance_view/ivm_maintenance_progress.dart';
import 'package:CIVM/piedmont/screens/leaflat_map/leaf_lat_map_wakeLock.dart';
import 'package:CIVM/piedmont/screens/map/provider/location_provider.dart';
import 'package:CIVM/piedmont/utils/common_functions.dart';
import 'package:CIVM/sharedPrefs/constants.dart';
import 'package:CIVM/utils/user_pref.dart';
import 'package:CIVM/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data/response/status.dart';
import '../../../view_model/add_budget_planning_view_model.dart';
import '../../login_page.dart';
import 'package:CIVM/piedmont/resources/app_colors.dart';
import 'package:CIVM/piedmont/repository/map_url.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:CIVM/piedmont/screens/my_chrome_safari_map_recording.dart';

// ignore: must_be_immutable
class ViewBudgetPlanning extends StatefulWidget {
  String year;
  ViewBudgetPlanning({Key? key, required this.year}) : super(key: key);

  @override
  State<ViewBudgetPlanning> createState() => _ViewBudgetPlanningState();
}

class _ViewBudgetPlanningState extends State<ViewBudgetPlanning> {
  List<String> menu = [];

  int sumChangeOrders = 0;
  int sumMidCycleLinePatrol = 0;
  int sumMidCycleSpray = 0;
  int sumMidCycleWorkOrder = 0;
  int sumWorkOrders = 0;
  int sumStormWork = 0;
  int sumSubSpray = 0;
  int grandTotal = 0;
  int sumAmount = 0;
  int totalGrandTotal = 0;
  double currentRemaining = 0;

  // ignore: non_ant_identifier_names, non_constant_identifier_names
  final select_year = ['2020', '2021', '2022', '2023', '2024', '2025', '2026'];
  String? year;

  List numbers = [];

  final TextEditingController _changeOrders = TextEditingController();
  final TextEditingController _midCycleLine = TextEditingController();
  final TextEditingController _midCycleSpray = TextEditingController();
  final TextEditingController _midCycleWork = TextEditingController();
  final TextEditingController _workOrders = TextEditingController();
  final TextEditingController _stormWork = TextEditingController();
  final TextEditingController _subSpray = TextEditingController();
  final TextEditingController _grandTotal = TextEditingController();

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

  AddBudgetPlanningViewModel addBudgetPlanningViewModel =
      AddBudgetPlanningViewModel();

  int loadingFlag = 0;

  @override
  void initState() {
    addBudgetPlanningViewModel.fetchAddBudgetPlanningGetListApi(
        context, '', widget.year, '', '');

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
            'View Budget Planning',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: AppColors.baseColor,
        ),
       // drawer: DrawerManu(menu: menu),
        body: ChangeNotifierProvider<AddBudgetPlanningViewModel>(
            create: (BuildContext context) => addBudgetPlanningViewModel,
            child: Consumer<AddBudgetPlanningViewModel>(
                builder: (context, value, _) {
              switch (value.addBudgetPlanningGetData.status) {
                case Status.LOADING:
                  return const Center(child: CircularProgressIndicator());
                case Status.ERROR:
                  return
                      // CustomToastSnackBarProgressDialog.flushBarErrorMessage(
                      //     value.addBudgetPlanningGetData.message.toString(),
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
                  if (loadingFlag == 0) {
                    _calculateSum();
                    _setValue();
                    loadingFlag = 1;
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
                              height: size.height * 0.6,
                              width: size.width * 0.99,
                              decoration: BoxDecoration(
                                  // shape: BoxShape.circle,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: AppColors.baseColor,
                                        blurRadius: 10,
                                        offset: Offset(2.0, 5.0))
                                  ],
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color.fromARGB(255, 255, 255, 255),
                                      Color.fromARGB(255, 255, 255, 255),
                                    ],
                                  )),
                              child: Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    alignment: Alignment.center,
                                    width: size.width * 0.99,
                                    // width: MediaQuery.of(context).size.width,
                                    // height: 40,
                                    decoration: const BoxDecoration(
                                        // shape: BoxShape.circle,
                                        //borderRadius: BorderRadius.circular(25),
                                        boxShadow: [
                                          BoxShadow(
                                          color:  AppColors.buttonShadow,
                                              blurRadius: 5,
                                              offset: Offset(2.0, 5.0))
                                        ],
                                        color:
                                            Color.fromARGB(255, 130, 193, 245),
                                        gradient: LinearGradient(
                                          colors: [
                                            AppColors.baseColor,
                                          AppColors.buttonOrange,
                                          AppColors.baseColor,
                                          ],
                                        )),
                                    child: Row(children: [
                                      const Expanded(
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "PEMC WORK SUMMARY",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (BuildContext
                                                          context) =>
                                                      BudgetPlanningAdd(
                                                        year: year!,
                                                        date: "",
                                                        changeOrders: "",
                                                        midCycleLinePetrol: "",
                                                        midCycleSpray: "",
                                                        midCycleWorkOrder: "",
                                                        workOrders: "",
                                                        stormWork: "",
                                                        subSpray: "",
                                                        l1: [],
                                                        id: 0,
                                                      )));
                                        },
                                        child: const Icon(
                                          Icons.add,
                                          color: Colors.red,
                                          size: 30,
                                        ),
                                      )
                                    ]),
                                  ),
                                  const Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 2.0,
                                            right: 2.0,
                                            bottom: 2.0,
                                            top: 8.0),
                                        child: Text(
                                          "Year",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color:  AppColors.baseColor,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: DropdownButtonFormField<String>(
                                      hint: const Text('Select Year'),
                                      dropdownColor: Colors.white,
                                      value: year,
                                      style: const TextStyle(
                                          color: AppColors.baseColor,
                                          fontSize: 16),
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
                                          // borderRadius: BorderRadius.circular(25),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: AppColors.baseColor,
                                          ),
                                          // borderRadius: BorderRadius.circular(25),
                                        ),
                                      ),
                                      isExpanded: true,
                                      items: select_year
                                          .map(buildMenuItem)
                                          .toList(),
                                      onChanged: (value) async {
                                        WidgetsBinding.instance
                                            .addPostFrameCallback((_) {
                                          setState(() {
                                            year = value;
                                          });
                                        });
                                        // setState(() {
                                        //   year = value;
                                        // });

                                        print('c');
                                        await addBudgetPlanningViewModel
                                            .fetchAddBudgetPlanningGetListApi(
                                                context,
                                                '10',
                                                year.toString(),
                                                '11',
                                                '31');
                                        await Future.delayed(
                                            const Duration(seconds: 5));
                                        print('b');
                                        _calculateSum();
                                        _setValue();
                                        print('a');
                                      },
                                      validator: (value) => value == null
                                          ? 'field required'
                                          : null,
                                    ),
                                  ),
                                  Expanded(
                                    child: ListView.builder(
                                        itemCount: addBudgetPlanningViewModel
                                            .addBudgetPlanningGetData
                                            .data!
                                            .getAllBUDGETPLANDTLSByYrList!
                                            .length,
                                        // itemCount: historyList.length,
                                        itemBuilder:
                                            (BuildContext ctxt, int index) {
                                          return Row(
                                            children: [
                                              Expanded(
                                                flex: 1,
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.28,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.4,
                                                  // height: 190,
                                                  margin: const EdgeInsets.only(
                                                      left: 4.0,
                                                      top: 5.0,
                                                      bottom: 5.0),
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  decoration: BoxDecoration(
                                                    gradient: LinearGradient(
                                                      colors: [
                                                        AppColors.green1
                                                            .withOpacity(0.9),
                                                        AppColors.green2
                                                            .withOpacity(0.7),
                                                        AppColors.green1
                                                            .withOpacity(0.9),
                                                      ],
                                                      begin: Alignment.topLeft,
                                                      end:
                                                          Alignment.bottomRight,
                                                    ),
                                                    border: Border.all(
                                                      color: Colors.white,
                                                    ),
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                      topRight:
                                                          Radius.circular(10),
                                                      bottomRight:
                                                          Radius.circular(10),
                                                      topLeft:
                                                          Radius.circular(10),
                                                      bottomLeft:
                                                          Radius.circular(10),
                                                    ),
                                                  ),
                                                  child: Column(children: [
                                                    Expanded(
                                                      // alignment: Alignment.topLeft,
                                                      child: Column(
                                                        children: [
                                                          const Align(
                                                            alignment: Alignment
                                                                .topLeft,
                                                            child: Text(
                                                              "EDIT: ",
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: TextStyle(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                          ),
                                                          Align(
                                                              alignment:
                                                                  Alignment
                                                                      .topLeft,
                                                              child: InkWell(
                                                                onTap: () {
                                                                  Navigator.of(context).push(MaterialPageRoute(
                                                                      builder: (BuildContext context) => BudgetPlanningAdd(
                                                                          year: year
                                                                              .toString(),
                                                                          date: addBudgetPlanningViewModel.addBudgetPlanningGetData.data!.getAllBUDGETPLANDTLSByYrList![index].date
                                                                              .toString(),
                                                                          changeOrders: addBudgetPlanningViewModel.addBudgetPlanningGetData.data!.getAllBUDGETPLANDTLSByYrList![index].changeOrders
                                                                              .toString(),
                                                                          midCycleLinePetrol: addBudgetPlanningViewModel
                                                                              .addBudgetPlanningGetData
                                                                              .data!
                                                                              .getAllBUDGETPLANDTLSByYrList![
                                                                                  index]
                                                                              .midCycleLinePatrol
                                                                              .toString(),
                                                                          midCycleSpray: addBudgetPlanningViewModel
                                                                              .addBudgetPlanningGetData
                                                                              .data!
                                                                              .getAllBUDGETPLANDTLSByYrList![index]
                                                                              .midCycleSpray
                                                                              .toString(),
                                                                          midCycleWorkOrder: addBudgetPlanningViewModel.addBudgetPlanningGetData.data!.getAllBUDGETPLANDTLSByYrList![index].midCycleWorkOrders.toString(),
                                                                          workOrders: addBudgetPlanningViewModel.addBudgetPlanningGetData.data!.getAllBUDGETPLANDTLSByYrList![index].workOrders.toString(),
                                                                          stormWork: addBudgetPlanningViewModel.addBudgetPlanningGetData.data!.getAllBUDGETPLANDTLSByYrList![index].stormWork.toString(),
                                                                          subSpray: addBudgetPlanningViewModel.addBudgetPlanningGetData.data!.getAllBUDGETPLANDTLSByYrList![index].subSpray.toString(),
                                                                          l1: addBudgetPlanningViewModel.addBudgetPlanningGetData.data!.getAllBUDGETPLANDTLSByYrList![index].l1,
                                                                          id: int.parse(addBudgetPlanningViewModel.addBudgetPlanningGetData.data!.getAllBUDGETPLANDTLSByYrList![index].id.toString()))));
                                                                },
                                                                child:
                                                                    const Icon(
                                                                  Icons
                                                                      .edit_calendar_outlined,
                                                                  color: Colors
                                                                      .blue,
                                                                  size: 20,
                                                                ),
                                                              )),
                                                        ],
                                                      ),
                                                    ),
                                                    Expanded(
                                                      // alignment: Alignment.topLeft,
                                                      child: Column(
                                                        children: [
                                                          const Align(
                                                            alignment: Alignment
                                                                .topLeft,
                                                            child: Text(
                                                              "DELETE: ",
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: TextStyle(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                          ),
                                                          Align(
                                                              alignment:
                                                                  Alignment
                                                                      .topLeft,
                                                              child: InkWell(
                                                                onTap:
                                                                    () async {
                                                                  addBudgetPlanningViewModel.fetchAddBudgetPlanningDeleteThirdDataApi(
                                                                      context,
                                                                      addBudgetPlanningViewModel
                                                                          .addBudgetPlanningGetData
                                                                          .data!
                                                                          .getAllBUDGETPLANDTLSByYrList![
                                                                              index]
                                                                          .id
                                                                          .toString());
                                                                  print(addBudgetPlanningViewModel
                                                                      .addBudgetPlanningGetData
                                                                      .data!
                                                                      .getAllBUDGETPLANDTLSByYrList![
                                                                          index]
                                                                      .id
                                                                      .toString());
                                                                  await Future.delayed(
                                                                      const Duration(
                                                                          seconds:
                                                                              5));
                                                                  addBudgetPlanningViewModel
                                                                      .fetchAddBudgetPlanningGetListApi(
                                                                          context,
                                                                          '10',
                                                                          year.toString(),
                                                                          '11',
                                                                          '31');
                                                                },
                                                                child:
                                                                    const Icon(
                                                                  Icons.delete,
                                                                  color: Colors
                                                                      .red,
                                                                  size: 20,
                                                                ),
                                                              )),
                                                        ],
                                                      ),
                                                    ),
                                                    Expanded(
                                                      //  flex: 4,
                                                      child: Column(
                                                        children: [
                                                          const Align(
                                                            alignment: Alignment
                                                                .topLeft,
                                                            child: Text(
                                                              "DATE :",
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ),
                                                          Align(
                                                            alignment: Alignment
                                                                .topLeft,
                                                            child: Text(
                                                              (addBudgetPlanningViewModel
                                                                              .addBudgetPlanningGetData
                                                                              .data!
                                                                              .getAllBUDGETPLANDTLSByYrList![
                                                                                  index]
                                                                              .date ==
                                                                          null ||
                                                                      addBudgetPlanningViewModel
                                                                              .addBudgetPlanningGetData
                                                                              .data!
                                                                              .getAllBUDGETPLANDTLSByYrList![
                                                                                  index]
                                                                              .date
                                                                              .toString() ==
                                                                          'null' ||
                                                                      addBudgetPlanningViewModel
                                                                          .addBudgetPlanningGetData
                                                                          .data!
                                                                          .getAllBUDGETPLANDTLSByYrList![
                                                                              index]
                                                                          .date
                                                                          .toString()
                                                                          .isEmpty)
                                                                  ? 'N/A'
                                                                  : addBudgetPlanningViewModel
                                                                      .addBudgetPlanningGetData
                                                                      .data!
                                                                      .getAllBUDGETPLANDTLSByYrList![
                                                                          index]
                                                                      .date
                                                                      .toString(),
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
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
                                                    Expanded(
                                                      //  flex: 4,
                                                      child: Column(
                                                        children: [
                                                          const Align(
                                                            alignment: Alignment
                                                                .topLeft,
                                                            child: Text(
                                                              "CHANGE ORDERS :",
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ),
                                                          Align(
                                                            alignment: Alignment
                                                                .topLeft,
                                                            child: Text(
                                                              (addBudgetPlanningViewModel
                                                                              .addBudgetPlanningGetData
                                                                              .data!
                                                                              .getAllBUDGETPLANDTLSByYrList![
                                                                                  index]
                                                                              .changeOrders ==
                                                                          null ||
                                                                      addBudgetPlanningViewModel
                                                                              .addBudgetPlanningGetData
                                                                              .data!
                                                                              .getAllBUDGETPLANDTLSByYrList![
                                                                                  index]
                                                                              .changeOrders
                                                                              .toString() ==
                                                                          'null' ||
                                                                      addBudgetPlanningViewModel
                                                                          .addBudgetPlanningGetData
                                                                          .data!
                                                                          .getAllBUDGETPLANDTLSByYrList![
                                                                              index]
                                                                          .changeOrders
                                                                          .toString()
                                                                          .isEmpty)
                                                                  ? 'N/A'
                                                                  : '\$ ${addBudgetPlanningViewModel.addBudgetPlanningGetData.data!.getAllBUDGETPLANDTLSByYrList![index].changeOrders.toString()}',
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
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
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.25,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.4,
                                                  margin: const EdgeInsets.only(
                                                      right: 4.0,
                                                      top: 5.0,
                                                      bottom: 5.0),
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      border: Border.all(
                                                        color: AppColors.baseColor,
                                                      ),
                                                      borderRadius:
                                                          const BorderRadius
                                                              .only(
                                                              topRight: Radius
                                                                  .circular(10),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          10))),
                                                  child: Column(children: [
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child: Row(
                                                            children: [
                                                              Expanded(
                                                                // alignment: Alignment.topLeft,
                                                                child: Column(
                                                                  children: [
                                                                    const Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .topLeft,
                                                                      child:
                                                                          Text(
                                                                        "MIDCYCLE LINE PATROL: ",
                                                                        textAlign:
                                                                            TextAlign.left,
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          color: AppColors.baseColor,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .topLeft,
                                                                      child:
                                                                          Text(
                                                                        (addBudgetPlanningViewModel.addBudgetPlanningGetData.data!.getAllBUDGETPLANDTLSByYrList![index].midCycleLinePatrol == null ||
                                                                                addBudgetPlanningViewModel.addBudgetPlanningGetData.data!.getAllBUDGETPLANDTLSByYrList![index].midCycleLinePatrol.toString() == 'null' ||
                                                                                addBudgetPlanningViewModel.addBudgetPlanningGetData.data!.getAllBUDGETPLANDTLSByYrList![index].midCycleLinePatrol.toString().isEmpty)
                                                                            ? 'N/A'
                                                                            : addBudgetPlanningViewModel.addBudgetPlanningGetData.data!.getAllBUDGETPLANDTLSByYrList![index].midCycleLinePatrol.toString(),
                                                                        textAlign:
                                                                            TextAlign.left,
                                                                        style:
                                                                            const TextStyle(
                                                                          fontSize:
                                                                              12,
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
                                                                      alignment:
                                                                          Alignment
                                                                              .topLeft,
                                                                      child:
                                                                          Text(
                                                                        "MIDCYCLE SPRAY: ",
                                                                        textAlign:
                                                                            TextAlign.left,
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          color: AppColors.baseColor,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .topLeft,
                                                                      child:
                                                                          Text(
                                                                        (addBudgetPlanningViewModel.addBudgetPlanningGetData.data!.getAllBUDGETPLANDTLSByYrList![index].midCycleSpray == null ||
                                                                                addBudgetPlanningViewModel.addBudgetPlanningGetData.data!.getAllBUDGETPLANDTLSByYrList![index].midCycleSpray.toString() == 'null' ||
                                                                                addBudgetPlanningViewModel.addBudgetPlanningGetData.data!.getAllBUDGETPLANDTLSByYrList![index].midCycleSpray.toString().isEmpty)
                                                                            ? 'N/A'
                                                                            : addBudgetPlanningViewModel.addBudgetPlanningGetData.data!.getAllBUDGETPLANDTLSByYrList![index].midCycleSpray.toString(),
                                                                        textAlign:
                                                                            TextAlign.left,
                                                                        style:
                                                                            const TextStyle(
                                                                          fontSize:
                                                                              12,
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
                                                    const Divider(
                                                      color: Colors.grey,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child: Row(
                                                            children: [
                                                              Expanded(
                                                                // alignment: Alignment.topLeft,
                                                                child: Column(
                                                                  children: [
                                                                    const Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .topLeft,
                                                                      child:
                                                                          Text(
                                                                        "MIDCYCLE CHANGE ORDERS: ",
                                                                        textAlign:
                                                                            TextAlign.left,
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          color: AppColors.baseColor,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .topLeft,
                                                                      child:
                                                                          Text(
                                                                        (addBudgetPlanningViewModel.addBudgetPlanningGetData.data!.getAllBUDGETPLANDTLSByYrList![index].midCycleWorkOrders == null ||
                                                                                addBudgetPlanningViewModel.addBudgetPlanningGetData.data!.getAllBUDGETPLANDTLSByYrList![index].midCycleWorkOrders.toString() == 'null' ||
                                                                                addBudgetPlanningViewModel.addBudgetPlanningGetData.data!.getAllBUDGETPLANDTLSByYrList![index].midCycleWorkOrders.toString().isEmpty)
                                                                            ? 'N/A'
                                                                            : addBudgetPlanningViewModel.addBudgetPlanningGetData.data!.getAllBUDGETPLANDTLSByYrList![index].midCycleWorkOrders.toString(),
                                                                        textAlign:
                                                                            TextAlign.left,
                                                                        style:
                                                                            const TextStyle(
                                                                          fontSize:
                                                                              12,
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
                                                                      alignment:
                                                                          Alignment
                                                                              .topLeft,
                                                                      child:
                                                                          Text(
                                                                        "WORK ORDERS: ",
                                                                        textAlign:
                                                                            TextAlign.left,
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          color:  AppColors.baseColor,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .topLeft,
                                                                      child:
                                                                          Text(
                                                                        (addBudgetPlanningViewModel.addBudgetPlanningGetData.data!.getAllBUDGETPLANDTLSByYrList![index].workOrders == null ||
                                                                                addBudgetPlanningViewModel.addBudgetPlanningGetData.data!.getAllBUDGETPLANDTLSByYrList![index].workOrders.toString() == 'null' ||
                                                                                addBudgetPlanningViewModel.addBudgetPlanningGetData.data!.getAllBUDGETPLANDTLSByYrList![index].workOrders.toString().isEmpty)
                                                                            ? 'N/A'
                                                                            : addBudgetPlanningViewModel.addBudgetPlanningGetData.data!.getAllBUDGETPLANDTLSByYrList![index].workOrders.toString(),
                                                                        textAlign:
                                                                            TextAlign.left,
                                                                        style:
                                                                            const TextStyle(
                                                                          fontSize:
                                                                              12,
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
                                                    const Divider(
                                                      color: Colors.grey,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child: Row(
                                                            children: [
                                                              Expanded(
                                                                // alignment: Alignment.topLeft,
                                                                child: Column(
                                                                  children: [
                                                                    const Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .topLeft,
                                                                      child:
                                                                          Text(
                                                                        "STORM WORK: ",
                                                                        textAlign:
                                                                            TextAlign.left,
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          color: AppColors.baseColor,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .topLeft,
                                                                      child:
                                                                          Text(
                                                                        (addBudgetPlanningViewModel.addBudgetPlanningGetData.data!.getAllBUDGETPLANDTLSByYrList![index].stormWork == null ||
                                                                                addBudgetPlanningViewModel.addBudgetPlanningGetData.data!.getAllBUDGETPLANDTLSByYrList![index].stormWork.toString() == 'null' ||
                                                                                addBudgetPlanningViewModel.addBudgetPlanningGetData.data!.getAllBUDGETPLANDTLSByYrList![index].stormWork.toString().isEmpty)
                                                                            ? 'N/A'
                                                                            : addBudgetPlanningViewModel.addBudgetPlanningGetData.data!.getAllBUDGETPLANDTLSByYrList![index].stormWork.toString(),
                                                                        textAlign:
                                                                            TextAlign.left,
                                                                        style:
                                                                            const TextStyle(
                                                                          fontSize:
                                                                              12,
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
                                                                      alignment:
                                                                          Alignment
                                                                              .topLeft,
                                                                      child:
                                                                          Text(
                                                                        "SUB SPRAY: ",
                                                                        textAlign:
                                                                            TextAlign.left,
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          color: AppColors.baseColor,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .topLeft,
                                                                      child:
                                                                          Text(
                                                                        (addBudgetPlanningViewModel.addBudgetPlanningGetData.data!.getAllBUDGETPLANDTLSByYrList![index].subSpray == null ||
                                                                                addBudgetPlanningViewModel.addBudgetPlanningGetData.data!.getAllBUDGETPLANDTLSByYrList![index].subSpray.toString() == 'null' ||
                                                                                addBudgetPlanningViewModel.addBudgetPlanningGetData.data!.getAllBUDGETPLANDTLSByYrList![index].subSpray.toString().isEmpty)
                                                                            ? 'N/A'
                                                                            : addBudgetPlanningViewModel.addBudgetPlanningGetData.data!.getAllBUDGETPLANDTLSByYrList![index].subSpray.toString(),
                                                                        textAlign:
                                                                            TextAlign.left,
                                                                        style:
                                                                            const TextStyle(
                                                                          fontSize:
                                                                              12,
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
                                                    Expanded(
                                                      child: ListView.builder(
                                                          itemCount: addBudgetPlanningViewModel
                                                              .addBudgetPlanningGetData
                                                              .data!
                                                              .getAllBUDGETPLANDTLSByYrList![
                                                                  index]
                                                              .l1!
                                                              .length,
                                                          itemBuilder:
                                                              (BuildContext
                                                                      ctxt,
                                                                  int i) {
                                                            return Row(
                                                              children: [
                                                                Container(
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.52,
                                                                  height: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .height *
                                                                      0.13,
                                                                  margin: const EdgeInsets
                                                                      .only(
                                                                      right:
                                                                          4.0,
                                                                      top: 5.0,
                                                                      bottom:
                                                                          5.0),
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          8),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    gradient:
                                                                        LinearGradient(
                                                                      colors: [
                                                                        AppColors
                                                                            .green1
                                                                            .withOpacity(0.9),
                                                                        AppColors
                                                                            .green2
                                                                            .withOpacity(0.7),
                                                                        AppColors
                                                                            .green1
                                                                            .withOpacity(0.9),
                                                                      ],
                                                                      begin: Alignment
                                                                          .topLeft,
                                                                      end: Alignment
                                                                          .bottomRight,
                                                                    ),
                                                                    border:
                                                                        Border
                                                                            .all(
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                    borderRadius:
                                                                        const BorderRadius
                                                                            .only(
                                                                      topRight:
                                                                          Radius.circular(
                                                                              10),
                                                                      bottomRight:
                                                                          Radius.circular(
                                                                              10),
                                                                      topLeft: Radius
                                                                          .circular(
                                                                              10),
                                                                      bottomLeft:
                                                                          Radius.circular(
                                                                              10),
                                                                    ),
                                                                  ),
                                                                  child: Column(
                                                                      children: [
                                                                        Row(
                                                                          children: [
                                                                            Expanded(
                                                                              child: Row(
                                                                                children: [
                                                                                  Expanded(
                                                                                    // alignment: Alignment.topLeft,
                                                                                    child: Column(
                                                                                      children: [
                                                                                        const Align(
                                                                                          alignment: Alignment.topLeft,
                                                                                          child: Text(
                                                                                            "SUBSTATION: ",
                                                                                            textAlign: TextAlign.left,
                                                                                            style: TextStyle(
                                                                                              fontSize: 12,
                                                                                              fontWeight: FontWeight.bold,
                                                                                              color: Colors.white,
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        Align(
                                                                                          alignment: Alignment.topLeft,
                                                                                          child: Text(
                                                                                            (addBudgetPlanningViewModel.addBudgetPlanningGetData.data!.getAllBUDGETPLANDTLSByYrList![index].l1![i].substation == null || addBudgetPlanningViewModel.addBudgetPlanningGetData.data!.getAllBUDGETPLANDTLSByYrList![index].l1![i].substation.toString() == 'null' || addBudgetPlanningViewModel.addBudgetPlanningGetData.data!.getAllBUDGETPLANDTLSByYrList![index].l1![i].substation.toString().isEmpty) ? 'N/A' : addBudgetPlanningViewModel.addBudgetPlanningGetData.data!.getAllBUDGETPLANDTLSByYrList![index].l1![i].substation.toString(),
                                                                                            textAlign: TextAlign.left,
                                                                                            style: const TextStyle(
                                                                                              fontSize: 12,
                                                                                              //  fontWeight:
                                                                                              //      FontWeight.bold,
                                                                                              color: Colors.white,
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
                                                                                            "FEEDER: ",
                                                                                            textAlign: TextAlign.left,
                                                                                            style: TextStyle(
                                                                                              fontSize: 12,
                                                                                              fontWeight: FontWeight.bold,
                                                                                              color: Colors.white,
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        Align(
                                                                                          alignment: Alignment.topLeft,
                                                                                          child: Text(
                                                                                            (addBudgetPlanningViewModel.addBudgetPlanningGetData.data!.getAllBUDGETPLANDTLSByYrList![index].l1![i].feeder == null || addBudgetPlanningViewModel.addBudgetPlanningGetData.data!.getAllBUDGETPLANDTLSByYrList![index].l1![i].feeder.toString() == 'null' || addBudgetPlanningViewModel.addBudgetPlanningGetData.data!.getAllBUDGETPLANDTLSByYrList![index].l1![i].feeder.toString().isEmpty) ? 'N/A' : addBudgetPlanningViewModel.addBudgetPlanningGetData.data!.getAllBUDGETPLANDTLSByYrList![index].l1![i].feeder.toString(),
                                                                                            textAlign: TextAlign.left,
                                                                                            style: const TextStyle(
                                                                                              fontSize: 12,
                                                                                              //  fontWeight:
                                                                                              //      FontWeight.bold,
                                                                                              color: Colors.white,
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
                                                                        const Divider(
                                                                          color:
                                                                              Colors.grey,
                                                                        ),
                                                                        Row(
                                                                          children: [
                                                                            Expanded(
                                                                              child: Row(
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
                                                                                              color: Colors.white,
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        Align(
                                                                                          alignment: Alignment.topLeft,
                                                                                          child: Text(
                                                                                            (addBudgetPlanningViewModel.addBudgetPlanningGetData.data!.getAllBUDGETPLANDTLSByYrList![index].l1![i].amount == null || addBudgetPlanningViewModel.addBudgetPlanningGetData.data!.getAllBUDGETPLANDTLSByYrList![index].l1![i].amount.toString() == 'null' || addBudgetPlanningViewModel.addBudgetPlanningGetData.data!.getAllBUDGETPLANDTLSByYrList![index].l1![i].amount.toString().isEmpty) ? 'N/A' : '\$ ${addBudgetPlanningViewModel.addBudgetPlanningGetData.data!.getAllBUDGETPLANDTLSByYrList![index].l1![i].amount.toString()}',
                                                                                            textAlign: TextAlign.left,
                                                                                            style: const TextStyle(
                                                                                              fontSize: 12,
                                                                                              //  fontWeight:
                                                                                              //      FontWeight.bold,
                                                                                              color: Colors.white,
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
                                                              ],
                                                            );
                                                          }),
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
                                  left: 8, right: 8, top: 10, bottom: 8),
                              padding: const EdgeInsets.all(8),
                              alignment: Alignment.center,
                              height: size.height * 0.55,
                              width: size.width * 0.99,
                              decoration: BoxDecoration(
                                  // shape: BoxShape.circle,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: AppColors.baseColor,
                                        blurRadius: 10,
                                        offset: Offset(2.0, 5.0))
                                  ],
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color.fromARGB(255, 255, 255, 255),
                                      Color.fromARGB(255, 255, 255, 255),
                                    ],
                                  )),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8.0, bottom: 8),
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      alignment: Alignment.center,
                                      width: size.width * 0.99,
                                      // width: MediaQuery.of(context).size.width,
                                      // height: 40,
                                      decoration: const BoxDecoration(
                                          // shape: BoxShape.circle,
                                          //borderRadius: BorderRadius.circular(25),
                                          boxShadow: [
                                            BoxShadow(
                                                color: AppColors.baseColor,
                                                blurRadius: 5,
                                                offset: Offset(2.0, 5.0))
                                          ],
                                          color: Color.fromARGB(
                                              255, 130, 193, 245),
                                          gradient: LinearGradient(
                                            colors: [
                                              AppColors.baseColor,
                                          AppColors.buttonOrange,
                                          AppColors.baseColor,
                                            ],
                                          )),
                                      child: const Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "TOTALS",
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
                                  Expanded(
                                    child: SingleChildScrollView(
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
                                                        "CHANGE ORDERS",
                                                        style: TextStyle(
                                                          fontSize: 16.0,
                                                          color:AppColors.baseColor,
                                                          fontWeight:
                                                              FontWeight.bold,
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
                                                      controller: _changeOrders,
                                                      style: const TextStyle(
                                                          color:AppColors.baseColor,
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
                                                          borderSide:
                                                              BorderSide(
                                                            color:
                                                             AppColors.baseColor
                                                          ),
                                                          // borderRadius: BorderRadius.circular(25),
                                                        ),
                                                        hintText:
                                                            'change orders',
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
                                                          color:AppColors.baseColor,
                                                          fontWeight:
                                                              FontWeight.bold,
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
                                                      controller: _midCycleLine,
                                                      style: const TextStyle(
                                                          color: AppColors.baseColor,
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
                                                          borderSide:
                                                              BorderSide(
                                                            color:
                                                              AppColors.baseColor
                                                          ),
                                                          // borderRadius: BorderRadius.circular(25),
                                                        ),
                                                        hintText:
                                                            'mid cycle line',
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
                                                          color:AppColors.baseColor,
                                                          fontWeight:
                                                              FontWeight.bold,
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
                                                      controller:
                                                          _midCycleSpray,
                                                      style: const TextStyle(
                                                          color: AppColors.baseColor,
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
                                                          borderSide:
                                                              BorderSide(
                                                            color:
                                                             AppColors.baseColor,
                                                          ),
                                                          // borderRadius: BorderRadius.circular(25),
                                                        ),
                                                        hintText:
                                                            'mid cycle spray',
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
                                                        "MIDCYCLE CHANGE ORDERS",
                                                        style: TextStyle(
                                                          fontSize: 16.0,
                                                          color: AppColors.baseColor,
                                                          fontWeight:
                                                              FontWeight.bold,
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
                                                      controller: _midCycleWork,
                                                      style: const TextStyle(
                                                          color: AppColors.baseColor,
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
                                                          borderSide:
                                                              BorderSide(
                                                            color:
                                                               AppColors.baseColor,
                                                          ),
                                                          // borderRadius: BorderRadius.circular(25),
                                                        ),
                                                        hintText:
                                                            'mid cycle work',
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
                                                        "CHANGE ORDERS",
                                                        style: TextStyle(
                                                          fontSize: 16.0,
                                                          color:AppColors.baseColor,
                                                          fontWeight:
                                                              FontWeight.bold,
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
                                                      controller: _workOrders,
                                                      style: const TextStyle(
                                                          color:AppColors.baseColor,
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
                                                          borderSide:
                                                              BorderSide(
                                                            color:
                                                               AppColors.baseColor,
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
                                                          color:AppColors.baseColor,
                                                          fontWeight:
                                                              FontWeight.bold,
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
                                                      controller: _stormWork,
                                                      style: const TextStyle(
                                                          color:AppColors.baseColor,
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
                                                          borderSide:
                                                              BorderSide(
                                                            color:
                                                               AppColors.baseColor,
                                                          ),
                                                          // borderRadius: BorderRadius.circular(25),
                                                        ),
                                                        hintText: 'strom work',
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
                                                          color:AppColors.baseColor,
                                                          fontWeight:
                                                              FontWeight.bold,
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
                                                      controller: _subSpray,
                                                      style: const TextStyle(
                                                          color:AppColors.baseColor,
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
                                                          borderSide:
                                                              BorderSide(
                                                            color:
                                                               AppColors.baseColor,
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
                                                        "GRAND TOTAL",
                                                        style: TextStyle(
                                                          fontSize: 16.0,
                                                          color:AppColors.baseColor,
                                                          fontWeight:
                                                              FontWeight.bold,
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
                                                      controller: _grandTotal,
                                                      style: const TextStyle(
                                                          color:AppColors.baseColor,
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
                                                          borderSide:
                                                              BorderSide(
                                                            color:
                                                               AppColors.baseColor,
                                                          ),
                                                          // borderRadius: BorderRadius.circular(25),
                                                        ),
                                                        hintText: 'grand total',
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
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                  left: 8, right: 8, top: 10, bottom: 8),
                              padding: const EdgeInsets.all(8),
                              alignment: Alignment.center,
                              height: size.height * 0.4,
                              width: size.width * 0.99,
                              decoration: BoxDecoration(
                                  // shape: BoxShape.circle,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: AppColors.baseColor,
                                        blurRadius: 10,
                                        offset: Offset(2.0, 5.0))
                                  ],
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color.fromARGB(255, 255, 255, 255),
                                      Color.fromARGB(255, 255, 255, 255),
                                    ],
                                  )),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8.0, bottom: 8),
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      alignment: Alignment.center,
                                      width: size.width * 0.99,
                                      // width: MediaQuery.of(context).size.width,
                                      // height: 40,
                                      decoration: const BoxDecoration(
                                          // shape: BoxShape.circle,
                                          //borderRadius: BorderRadius.circular(25),
                                          boxShadow: [
                                            BoxShadow(
                                                color:AppColors.buttonShadow,
                                                blurRadius: 5,
                                                offset: Offset(2.0, 5.0))
                                          ],
                                          color: Color.fromARGB(
                                              255, 130, 193, 245),
                                          gradient: LinearGradient(
                                            colors: [
                                             AppColors.baseColor,
                                          AppColors.buttonOrange,
                                          AppColors.baseColor,
                                            ],
                                          )),
                                      child: const Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "SUMMARY",
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
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 20.0),
                                      child: Row(children: [
                                        Column(
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              alignment: Alignment.center,
                                              width: size.width * 0.6,
                                              height: 45,
                                              decoration: BoxDecoration(
                                                boxShadow: const [
                                                  BoxShadow(
                                                    color: Colors.white,
                                                    blurRadius: 5,
                                                    offset: Offset(2.0, 5.0),
                                                  ),
                                                ],
                                                color: Colors.white,
                                                gradient: const LinearGradient(
                                                  colors: [
                                                  
                                          AppColors.baseColor,
                                          AppColors.buttonOrange,
                                          AppColors.baseColor,
                                                  ],
                                                ),
                                                border: Border.all(
                                                  // Add this to add a border
                                                  color: Colors
                                                      .white, // Choose your border color
                                                  width:
                                                      2.0, // Adjust the border width as needed
                                                ),
                                              ),
                                              child: const Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  '',
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              alignment: Alignment.center,
                                              width: size.width * 0.6,
                                              height: 45,
                                              decoration: BoxDecoration(
                                                boxShadow: const [
                                                  BoxShadow(
                                                    color: Colors.white,
                                                    blurRadius: 5,
                                                    offset: Offset(2.0, 5.0),
                                                  ),
                                                ],
                                                color: Colors.white,
                                                gradient: const LinearGradient(
                                                  colors: [
                                                  
                                          AppColors.baseColor,
                                          AppColors.buttonOrange,
                                          AppColors.baseColor,
                                                  ],
                                                ),
                                                border: Border.all(
                                                  // Add this to add a border
                                                  color: Colors
                                                      .white, // Choose your border color
                                                  width:
                                                      2.0, // Adjust the border width as needed
                                                ),
                                              ),
                                              child: const Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  'IVM',
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              alignment: Alignment.center,
                                              width: size.width * 0.6,
                                              height: 45,
                                              decoration: BoxDecoration(
                                                boxShadow: const [
                                                  BoxShadow(
                                                    color: Colors.white,
                                                    blurRadius: 5,
                                                    offset: Offset(2.0, 5.0),
                                                  ),
                                                ],
                                                color: Colors.white,
                                                gradient: const LinearGradient(
                                                  colors: [
                                                  
                                          AppColors.baseColor,
                                          AppColors.buttonOrange,
                                          AppColors.baseColor,
                                                  ],
                                                ),
                                                border: Border.all(
                                                  // Add this to add a border
                                                  color: Colors
                                                      .white, // Choose your border color
                                                  width:
                                                      2.0, // Adjust the border width as needed
                                                ),
                                              ),
                                              child: const Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  'MIDCYCLE/CH-OR',
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              alignment: Alignment.center,
                                              width: size.width * 0.6,
                                              height: 45,
                                              decoration: const BoxDecoration(
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.white,
                                                      blurRadius: 5,
                                                      offset: Offset(2.0, 5.0),
                                                    ),
                                                  ],
                                                  color: Colors.white,
                                                  gradient: LinearGradient(
                                                    colors: [
                                                  
                                          AppColors.baseColor,
                                          AppColors.buttonOrange,
                                          AppColors.baseColor,
                                                    ],
                                                  ),
                                                  border: Border(
                                                    top: BorderSide(
                                                      color: Colors
                                                          .white, // Top border color (white)
                                                      width:
                                                          2.0, // Top border width
                                                    ),
                                                    bottom: BorderSide(
                                                      color:AppColors.baseColor,
                                                      // Bottom border color (white)
                                                      width:
                                                          2.0, // Bottom border width
                                                    ),
                                                    left: BorderSide(
                                                      color: Colors
                                                          .white, // Left border color (white)
                                                      width:
                                                          2.0, // Left border width
                                                    ),
                                                    right: BorderSide(
                                                      color: Colors.white,
                                                      width:
                                                          2.0, // Right border width
                                                    ),
                                                  )),
                                              child: const Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  'TOTAL',
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              alignment: Alignment.center,
                                              width: size.width * 0.6,
                                              height: 45,
                                              decoration: BoxDecoration(
                                                boxShadow: const [
                                                  BoxShadow(
                                                    color: Colors.white,
                                                    blurRadius: 5,
                                                    offset: Offset(2.0, 5.0),
                                                  ),
                                                ],
                                                color: Colors.white,
                                                gradient: const LinearGradient(
                                                  colors: [
                                                     AppColors.baseColor,
                                          AppColors.buttonOrange,
                                          AppColors.baseColor
                                                  ],
                                                ),
                                                border: Border.all(
                                                  // Add this to add a border
                                                  color: Colors
                                                      .white, // Choose your border color
                                                  width:
                                                      2.0, // Adjust the border width as needed
                                                ),
                                              ),
                                              child: const Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  'BUDGET',
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              alignment: Alignment.center,
                                              width: size.width * 0.6,
                                              height: 45,
                                              decoration: BoxDecoration(
                                                boxShadow: const [
                                                  BoxShadow(
                                                    color: Colors.white,
                                                    blurRadius: 5,
                                                    offset: Offset(2.0, 5.0),
                                                  ),
                                                ],
                                                color: Colors.white,
                                                gradient: const LinearGradient(
                                                  colors: [
                                                    Colors.white,
                                                    Color.fromARGB(
                                                        255, 146, 159, 246),
                                                  ],
                                                ),
                                                border: Border.all(
                                                  // Add this to add a border
                                                  color: Colors
                                                      .white, // Choose your border color
                                                  width:
                                                      2.0, // Adjust the border width as needed
                                                ),
                                              ),
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  '\$ ${addBudgetPlanningViewModel.addBudgetPlanningGetData.data!.getSumOfAllBudgetByYr.toString()}',
                                                  textAlign: TextAlign.left,
                                                  style: const TextStyle(
                                                    color:  AppColors.baseColor,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              alignment: Alignment.center,
                                              width: size.width * 0.6,
                                              height: 45,
                                              decoration: BoxDecoration(
                                                boxShadow: const [
                                                  BoxShadow(
                                                    color: Colors.white,
                                                    blurRadius: 5,
                                                    offset: Offset(2.0, 5.0),
                                                  ),
                                                ],
                                                color: Colors.white,
                                                gradient: const LinearGradient(
                                                  colors: [
                                                    Colors.white,
                                                    Color.fromARGB(
                                                        255, 146, 159, 246),
                                                  ],
                                                ),
                                                border: Border.all(
                                                  // Add this to add a border
                                                  color: Colors
                                                      .white, // Choose your border color
                                                  width:
                                                      2.0, // Adjust the border width as needed
                                                ),
                                              ),
                                              child: const Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  '\$ - ',
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    color:  AppColors.baseColor,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              alignment: Alignment.center,
                                              width: size.width * 0.6,
                                              height: 45,
                                              decoration: BoxDecoration(
                                                boxShadow: const [
                                                  BoxShadow(
                                                    color: Colors.white,
                                                    blurRadius: 5,
                                                    offset: Offset(2.0, 5.0),
                                                  ),
                                                ],
                                                color: Colors.white,
                                                gradient: const LinearGradient(
                                                  colors: [
                                                    Colors.white,
                                                    Color.fromARGB(
                                                        255, 146, 159, 246),
                                                  ],
                                                ),
                                                border: Border.all(
                                                  // Add this to add a border
                                                  color:  AppColors.baseColor, // Choose your border color
                                                  width:
                                                      2.0, // Adjust the border width as needed
                                                ),
                                              ),
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  '\$ ${addBudgetPlanningViewModel.addBudgetPlanningGetData.data!.getSumOfAllBudgetByYr.toString()}',
                                                  textAlign: TextAlign.left,
                                                  style: const TextStyle(
                                                    color:  AppColors.baseColor,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              alignment: Alignment.center,
                                              width: size.width * 0.6,
                                              height: 45,
                                              decoration: BoxDecoration(
                                                boxShadow: const [
                                                  BoxShadow(
                                                    color: Colors.white,
                                                    blurRadius: 5,
                                                    offset: Offset(2.0, 5.0),
                                                  ),
                                                ],
                                                color: Colors.white,
                                                gradient: const LinearGradient(
                                                  colors: [
                                                    AppColors.baseColor,
                                          AppColors.buttonOrange,
                                          AppColors.baseColor,
                                                  ],
                                                ),
                                                border: Border.all(
                                                  // Add this to add a border
                                                  color: Colors
                                                      .white, // Choose your border color
                                                  width:
                                                      2.0, // Adjust the border width as needed
                                                ),
                                              ),
                                              child: const Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  'BILLED',
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              alignment: Alignment.center,
                                              width: size.width * 0.6,
                                              height: 45,
                                              decoration: BoxDecoration(
                                                boxShadow: const [
                                                  BoxShadow(
                                                    color: Colors.white,
                                                    blurRadius: 5,
                                                    offset: Offset(2.0, 5.0),
                                                  ),
                                                ],
                                                color: Colors.white,
                                                gradient: const LinearGradient(
                                                  colors: [
                                                    Colors.white,
                                                    Color.fromARGB(
                                                        255, 146, 159, 246),
                                                  ],
                                                ),
                                                border: Border.all(
                                                  // Add this to add a border
                                                  color: Colors
                                                      .white, // Choose your border color
                                                  width:
                                                      2.0, // Adjust the border width as needed
                                                ),
                                              ),
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  '\$ $sumAmount',
                                                  textAlign: TextAlign.left,
                                                  style: const TextStyle(
                                                    color:  AppColors.baseColor,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              alignment: Alignment.center,
                                              width: size.width * 0.6,
                                              height: 45,
                                              decoration: BoxDecoration(
                                                boxShadow: const [
                                                  BoxShadow(
                                                    color: Colors.white,
                                                    blurRadius: 5,
                                                    offset: Offset(2.0, 5.0),
                                                  ),
                                                ],
                                                color: Colors.white,
                                                gradient: const LinearGradient(
                                                  colors: [
                                                    Colors.white,
                                                    Color.fromARGB(
                                                        255, 146, 159, 246),
                                                  ],
                                                ),
                                                border: Border.all(
                                                  // Add this to add a border
                                                  color: Colors
                                                      .white, // Choose your border color
                                                  width:
                                                      2.0, // Adjust the border width as needed
                                                ),
                                              ),
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  '\$ $grandTotal',
                                                  textAlign: TextAlign.left,
                                                  style: const TextStyle(
                                                    color:  AppColors.baseColor,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              alignment: Alignment.center,
                                              width: size.width * 0.6,
                                              height: 45,
                                              decoration: BoxDecoration(
                                                boxShadow: const [
                                                  BoxShadow(
                                                    color: Colors.white,
                                                    blurRadius: 5,
                                                    offset: Offset(2.0, 5.0),
                                                  ),
                                                ],
                                                color: Colors.white,
                                                gradient: const LinearGradient(
                                                  colors: [
                                                    Colors.white,
                                                    Color.fromARGB(
                                                        255, 146, 159, 246),
                                                  ],
                                                ),
                                                border: Border.all(
                                                  // Add this to add a border
                                                  color:  AppColors.baseColor, // Choose your border color
                                                  width:
                                                      2.0, // Adjust the border width as needed
                                                ),
                                              ),
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  '\$ $totalGrandTotal',
                                                  textAlign: TextAlign.left,
                                                  style: const TextStyle(
                                                    color:  AppColors.baseColor,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              alignment: Alignment.center,
                                              width: size.width * 0.6,
                                              height: 45,
                                              decoration: const BoxDecoration(
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.white,
                                                      blurRadius: 5,
                                                      offset: Offset(2.0, 5.0),
                                                    ),
                                                  ],
                                                  color: Colors.white,
                                                  gradient: LinearGradient(
                                                    colors: [
                                                        AppColors.baseColor,
                                          AppColors.buttonOrange,
                                          AppColors.baseColor,
                                                    ],
                                                  ),
                                                  border: Border(
                                                    top: BorderSide(
                                                      color: Colors
                                                          .white, // Top border color (white)
                                                      width:
                                                          2.0, // Top border width
                                                    ),
                                                    bottom: BorderSide(
                                                      color: Colors
                                                          .white, // Bottom border color (white)
                                                      width:
                                                          2.0, // Bottom border width
                                                    ),
                                                    left: BorderSide(
                                                      color: Colors
                                                          .white, // Left border color (white)
                                                      width:
                                                          2.0, // Left border width
                                                    ),
                                                    right: BorderSide(
                                                      color:  AppColors.baseColor,// Right border color (blue)
                                                      width:
                                                          2.0, // Right border width
                                                    ),
                                                  )),
                                              child: const Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  'CURRENT REMAINING',
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              alignment: Alignment.center,
                                              width: size.width * 0.6,
                                              height: 45,
                                              decoration: const BoxDecoration(
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.white,
                                                      blurRadius: 5,
                                                      offset: Offset(2.0, 5.0),
                                                    ),
                                                  ],
                                                  color: Colors.white,
                                                  gradient: LinearGradient(
                                                    colors: [
                                                      Colors.white,
                                                      Color.fromARGB(
                                                          255, 146, 159, 246),
                                                    ],
                                                  ),
                                                  border: Border(
                                                    top: BorderSide(
                                                      color: Colors
                                                          .white, // Top border color (white)
                                                      width:
                                                          2.0, // Top border width
                                                    ),
                                                    bottom: BorderSide(
                                                      color: Colors
                                                          .white, // Bottom border color (white)
                                                      width:
                                                          2.0, // Bottom border width
                                                    ),
                                                    left: BorderSide(
                                                      color: Colors
                                                          .white, // Left border color (white)
                                                      width:
                                                          2.0, // Left border width
                                                    ),
                                                    right: BorderSide(
                                                      color:   AppColors.baseColor,// Right border color (blue)
                                                      width:
                                                          2.0, // Right border width
                                                    ),
                                                  )),
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  '\$ $currentRemaining',
                                                  textAlign: TextAlign.left,
                                                  style: const TextStyle(
                                                    color:  AppColors.baseColor,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              alignment: Alignment.center,
                                              width: size.width * 0.6,
                                              height: 45,
                                              decoration: const BoxDecoration(
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.white,
                                                      blurRadius: 5,
                                                      offset: Offset(2.0, 5.0),
                                                    ),
                                                  ],
                                                  color: Colors.white,
                                                  gradient: LinearGradient(
                                                    colors: [
                                                      Colors.white,
                                                      Color.fromARGB(
                                                          255, 146, 159, 246),
                                                    ],
                                                  ),
                                                  border: Border(
                                                    top: BorderSide(
                                                      color: Colors
                                                          .white, // Top border color (white)
                                                      width:
                                                          2.0, // Top border width
                                                    ),
                                                    bottom: BorderSide(
                                                      color: Colors
                                                          .white, // Bottom border color (white)
                                                      width:
                                                          2.0, // Bottom border width
                                                    ),
                                                    left: BorderSide(
                                                      color: Colors
                                                          .white, // Left border color (white)
                                                      width:
                                                          2.0, // Left border width
                                                    ),
                                                    right: BorderSide(
                                                      color:   AppColors.baseColor,// Right border color (blue)
                                                      width:
                                                          2.0, // Right border width
                                                    ),
                                                  )),
                                              child: const Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  '\$ - ',
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    color:  AppColors.baseColor,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              alignment: Alignment.center,
                                              width: size.width * 0.6,
                                              height: 45,
                                              decoration: BoxDecoration(
                                                boxShadow: const [
                                                  BoxShadow(
                                                    color: Colors.white,
                                                    blurRadius: 5,
                                                    offset: Offset(2.0, 5.0),
                                                  ),
                                                ],
                                                color: Colors.white,
                                                gradient: const LinearGradient(
                                                  colors: [
                                                    Colors.white,
                                                    Color.fromARGB(
                                                        255, 146, 159, 246),
                                                  ],
                                                ),
                                                border: Border.all(
                                                  // Add this to add a border
                                                  color:  AppColors.baseColor,
                                                  width:
                                                      2.0, // Adjust the border width as needed
                                                ),
                                              ),
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  '\$ $currentRemaining',
                                                  textAlign: TextAlign.left,
                                                  style: const TextStyle(
                                                    color:  AppColors.baseColor,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ]),
                                    ),
                                  ),
                                ],
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
            })));
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
      value: item,
      child: Text(item,
          style: const TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 20,
          )));

  _calculateSum() {
    sumChangeOrders = 0;
    sumMidCycleLinePatrol = 0;
    sumMidCycleSpray = 0;
    sumMidCycleWorkOrder = 0;
    sumWorkOrders = 0;
    sumStormWork = 0;
    sumSubSpray = 0;
    grandTotal = 0;
    sumAmount = 0;
    totalGrandTotal = 0;
    currentRemaining = 0;
    var dataList = addBudgetPlanningViewModel
        .addBudgetPlanningGetData.data?.getAllBUDGETPLANDTLSByYrList;
    // dataList!.clear();
    if (dataList != null && dataList.isNotEmpty) {
      for (var item in dataList) {
        int changeOrders = int.tryParse(item.changeOrders ?? "0") ?? 0;
        sumChangeOrders += changeOrders;

        int midCycleLinePatrol =
            int.tryParse(item.midCycleLinePatrol ?? "0") ?? 0;

        sumMidCycleLinePatrol += midCycleLinePatrol;
        int midCycleSpray = int.tryParse(item.midCycleSpray ?? "0") ?? 0;
        sumMidCycleSpray += midCycleSpray;

        int midCycleWorkOrder =
            int.tryParse(item.midCycleWorkOrders ?? "0") ?? 0;
        sumMidCycleWorkOrder += midCycleWorkOrder;

        int workOrders = int.tryParse(item.workOrders ?? "0") ?? 0;
        sumWorkOrders += workOrders;

        int stormWork = int.tryParse(item.stormWork ?? "0") ?? 0;
        sumStormWork += stormWork;

        int subSpray = int.tryParse(item.subSpray ?? "0") ?? 0;
        sumSubSpray += subSpray;

        grandTotal = sumChangeOrders +
            sumMidCycleLinePatrol +
            sumMidCycleSpray +
            sumMidCycleWorkOrder +
            sumWorkOrders +
            sumStormWork +
            sumSubSpray;

        if (item.l1 != null && item.l1!.isNotEmpty) {
          int amt = int.tryParse(item.l1![0].amount ?? "0") ?? 0;
          sumAmount += amt;
        }

        double a = double.parse(addBudgetPlanningViewModel
            .addBudgetPlanningGetData.data!.getSumOfAllBudgetByYr
            .toString());

        totalGrandTotal = grandTotal + sumAmount;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          setState(() {
            currentRemaining = a - sumAmount;
          });
        });
        // setState(() {
        //   currentRemaining = a - sumAmount;
        // });
      }
    }

    print("The sum of amount is: $sumAmount");
  }

  _setValue() {
    print('sumChangeOrders');
    print(sumChangeOrders);
    year = widget.year;
    _changeOrders.text = sumChangeOrders.toString();
    _midCycleLine.text = sumMidCycleLinePatrol.toString();
    _midCycleSpray.text = sumMidCycleSpray.toString();
    _midCycleWork.text = sumMidCycleWorkOrder.toString();
    _workOrders.text = sumWorkOrders.toString();
    _stormWork.text = sumStormWork.toString();
    _subSpray.text = sumSubSpray.toString();
    _grandTotal.text = grandTotal.toString();
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
                              AdminAddNewRowTable(index:'0')));
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
