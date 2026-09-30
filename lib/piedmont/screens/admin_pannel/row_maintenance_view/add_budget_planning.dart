import 'dart:convert';
import 'package:CIVM/models/user_model.dart';
import 'package:CIVM/piedmont/models/add_budget_planning_model.dart';

import 'package:CIVM/piedmont/resources/app_colors.dart';
import 'package:CIVM/piedmont/screens/admin_pannel/pemc_admin_new/adm_invoice_list.dart';
import 'package:CIVM/piedmont/screens/admin_pannel/pemc_admin_new/adm_service_order.dart';
import 'package:CIVM/piedmont/screens/admin_pannel/pemc_admin_new/inspection_zielies.dart';
import 'package:CIVM/piedmont/screens/admin_pannel/row_maintenance_view/add_crew_member.dart';
import 'package:CIVM/piedmont/screens/admin_pannel/row_maintenance_view/add_new_row_table.dart';
import 'package:CIVM/piedmont/screens/admin_pannel/row_maintenance_view/admin_pannel.dart';
import 'package:CIVM/piedmont/screens/admin_pannel/row_maintenance_view/approve_civm_access.dart';
import 'package:CIVM/piedmont/screens/admin_pannel/row_maintenance_view/budget_planning_add_second.dart';

import 'package:CIVM/piedmont/screens/admin_pannel/row_maintenance_view/ivm_maintenance_progress.dart';
import 'package:CIVM/piedmont/screens/admin_pannel/row_maintenance_view/view_budget_planning.dart';
import 'package:CIVM/piedmont/screens/leaflat_map/leaf_lat_map_wakeLock.dart';
import 'package:CIVM/piedmont/screens/map/provider/location_provider.dart';
import 'package:CIVM/piedmont/sharedPrefs/constants.dart';
import 'package:CIVM/piedmont/utils/common_functions.dart';

import 'package:CIVM/piedmont/view_model/add_budget_planning_view_model.dart';
import 'package:CIVM/sharedPrefs/constants.dart';
import 'package:CIVM/utils/user_pref.dart';

import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../data/response/status.dart';
import '../../../utils/custom_toast_snackbar_progressdialog.dart';
import '../../login_page.dart';
import 'package:http/http.dart' as http;
import 'package:CIVM/piedmont/repository/map_url.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:CIVM/piedmont/screens/my_chrome_safari_map_recording.dart';

class AddBudgetPlanning extends StatefulWidget {
  const AddBudgetPlanning({Key? key}) : super(key: key);

  @override
  State<AddBudgetPlanning> createState() => _AddBudgetPlanningState();
}

class _AddBudgetPlanningState extends State<AddBudgetPlanning> {
  List<AddBudgetPlanningModel> insertData = [];
  // ignore: prefer_typing_uninitialized_variables
  var selectedSubstation;
  int substationId = 0;

  // ignore: prefer_typing_uninitialized_variables
  var selectedFeeder;
  int feederId = 0;
  List<String> menu = [];

  String substationName = '';
  int flag = 0;
  int flagAPI = 0;

  // ignore: prefer_typing_uninitialized_variables

  List<Map<String, dynamic>> listOfColumns = [];
  List<Map<String, dynamic>> listOfColumns1 = [];

  List updatedCard = [];

  GetLocalCardList? updatedCardNew;
  List<GetLocalCardList> cardList = [];

  List<_ChartDataSimpleColumnChart1> dataSimpleColumnChart1 = [];

  // final TextEditingController _input = TextEditingController();
  // final TextEditingController _substation = TextEditingController();
  // final TextEditingController _ivmBudget = TextEditingController();
  // final TextEditingController _midCycleBudget = TextEditingController();

  // ignore: non_constant_identifier_names
  final select_year = ['2020', '2021', '2022', '2023', '2024', '2025', '2026'];
  String? year = '2025';
  final TextEditingController _budget = TextEditingController();

  onTappedBar(int index) {
    setState(() {
      // _currentIndex = index;
    });
  }

  final gradientList = <List<Color>>[
    [
      const Color.fromARGB(255, 14, 2, 252),
      const Color.fromARGB(255, 14, 2, 252),
    ],
    [
      const Color.fromARGB(255, 245, 18, 1),
      const Color.fromARGB(255, 245, 18, 1),
    ],
    [
      Colors.orange,
      Colors.orange,
    ],
    [
      const Color.fromARGB(255, 1, 113, 5),
      Colors.green,
    ],
  ];
  AddBudgetPlanningViewModel addBudgetPlanningViewModel =
      AddBudgetPlanningViewModel();

  List<Map<String, dynamic>> cardListMaps = [];
  int currentYear = DateTime.now().year;

  @override
  void initState() {
    addBudgetPlanningViewModel.fetchAddBudgetPlanningGetListApi(
        context, '', currentYear.toString(), '', '');
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
        //drawer: DrawerManu(menu: menu),
        body: ChangeNotifierProvider<AddBudgetPlanningViewModel>(
            create: (BuildContext context) => addBudgetPlanningViewModel,
            child: Consumer<AddBudgetPlanningViewModel>(
                builder: (context, value, _) {
              switch (value.addBudgetPlanningGetData.status) {
                case Status.LOADING:
                  return const Center(child: CircularProgressIndicator());
                case Status.ERROR:
                  return Padding(
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

                // CustomToastSnackBarProgressDialog.flushBarErrorMessage(
                //     value.addBudgetPlanningGetData.message.toString(),
                //     context);

                case Status.COMPLETED:
                  if (flag == 0) {
                    flag = 1;
                    cardList.clear();
                    cardList.addAll(addBudgetPlanningViewModel
                        .addBudgetPlanningGetData
                        .data!
                        .getBudgetPlanningOfSubstationFdrAmtByBudgetIdList!
                        .map((item) => GetLocalCardList(
                            year: year,
                            substation: item.substation,
                            feeder: item.feeder,
                            budget: (item.budget == null) ? '0' : item.budget,
                            insertedBudgetAndYearOfGetId:
                                addBudgetPlanningViewModel
                                    .addBudgetPlanningGetData
                                    .data!
                                    .getInsertedBudgetId![0]
                                    .toString())));
                    cardListMaps = cardList
                        .map((card) => {
                              'year': card.year,
                              'substation': card.substation,
                              'feeder': card.feeder,
                              'budget':
                                  (card.budget == null) ? '0' : card.budget,
                              'insertedBudgetAndYearOfGetId':
                                  card.insertedBudgetAndYearOfGetId
                            })
                        .toList();
                  }

                  // _pieChartData();
                  return RefreshIndicator(
                    onRefresh: () async {
                      await addBudgetPlanningViewModel
                          .fetchAddBudgetPlanningGetListApi(
                              context, '', year.toString(), '', '');
                    },
                    child: SingleChildScrollView(
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
                              // height: size.height * 0.9,
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
                                  const Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 2.0,
                                            right: 2.0,
                                            bottom: 2.0,
                                            top: 2.0),
                                        child: Text(
                                          "Year",
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: AppColors.baseColor,
                                            //fontWeight: FontWeight.bold
                                          ),
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
                                        fontSize: 16,
                                      ),
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
                                      items: select_year
                                          .map(buildMenuItem)
                                          .toList(),
                                      onChanged: (value) async {
                                        flag = 0;
                                        setState(() {
                                          year = value;
                                        });
                                        addBudgetPlanningViewModel
                                            .fetchAddBudgetPlanningGetListApi(
                                                context,
                                                '',
                                                year.toString(),
                                                '',
                                                '');
                                        // cardList.clear();
                                        // await Future.delayed(Duration(seconds: 2));
                                        // setState(() {
                                        //   cardList.addAll(addBudgetPlanningViewModel
                                        //       .addBudgetPlanningGetData
                                        //       .data!
                                        //       .getBudgetPlanningOfSubstationFdrAmtByBudgetIdList!
                                        //       .map((item) => GetLocalCardList(
                                        //           year: item.year,
                                        //           substation: item.substation,
                                        //           feeder: item.feeder,
                                        //           amount: item.amount)));
                                        // });
                                      },

                                      // onChanged: (value) async {
                                      //   setState(() {
                                      //     year = value;
                                      //   });

                                      //   print('11111111');
                                      //   await addBudgetPlanningViewModel
                                      //       .fetchAddBudgetPlanningGetListApi(
                                      //           context,
                                      //           '',
                                      //           year.toString(),
                                      //           '',
                                      //           '');
                                      //   print('2222222222');

                                      //   cardList.clear();
                                      //   print('3333333333');

                                      //   if (addBudgetPlanningViewModel
                                      //               .addBudgetPlanningGetData
                                      //               .data !=
                                      //           null &&
                                      //       addBudgetPlanningViewModel
                                      //               .addBudgetPlanningGetData
                                      //               .data!
                                      //               .getBudgetPlanningOfSubstationFdrAmtByBudgetIdList !=
                                      //           null) {
                                      //     print('inside if condition');
                                      //     setState(() {
                                      //       cardList.addAll(addBudgetPlanningViewModel
                                      //           .addBudgetPlanningGetData
                                      //           .data!
                                      //           .getBudgetPlanningOfSubstationFdrAmtByBudgetIdList!
                                      //           .map((item) => GetLocalCardList(
                                      //                 year: item.year,
                                      //                 substation: item.substation,
                                      //                 feeder: item.feeder,
                                      //                 amount: item.amount,
                                      //               )));
                                      //     });
                                      //   }

                                      //   print('44444444444');
                                      // },
                                      validator: (value) => value == null
                                          ? 'field required'
                                          : null,
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                        top: 10, bottom: 10, left: 8, right: 8),
                                    padding: const EdgeInsets.all(8),
                                    alignment: Alignment.center,
                                    // height: size.height * 0.2,
                                    width: size.width * 0.99,
                                    decoration: BoxDecoration(
                                        // shape: BoxShape.circle,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: const [
                                          BoxShadow(
                                              color: AppColors.buttonShadow,
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
                                                    color: AppColors.buttonShadow,
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
                                          child: const Row(children: [
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "BILLED 2021,2022,2023",
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ),
                                          ]),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 18.0, bottom: 18),
                                                child: PieChart(
                                                  dataMap: _pieChartData(),
                                                  // {
                                                  //   for (var item
                                                  //       in addBudgetPlanningViewModel
                                                  //           .addBudgetPlanningGetData
                                                  //           .data!
                                                  //           .getAllSPBUDGETTOTALBILLINGList!)
                                                  //     item.yr.toString(): item
                                                  //         .totalBilling!
                                                  //         .toDouble(),
                                                  // },
                                                  animationDuration:
                                                      const Duration(
                                                          milliseconds: 800),
                                                  chartLegendSpacing: 32,
                                                  chartRadius:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width /
                                                          3.2,
                                                  // colorList: colorList,
                                                  initialAngleInDegree: 0,
                                                  chartType: ChartType.ring,
                                                  ringStrokeWidth: 32,
                                                  // centerText: "HYBRID",
                                                  legendOptions:
                                                      const LegendOptions(
                                                    showLegendsInRow: false,
                                                    // legendPosition: LegendPosition.right,
                                                    showLegends: true,
                                                    // legendShape: _BoxShape.circle,
                                                    legendTextStyle: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  chartValuesOptions:
                                                      const ChartValuesOptions(
                                                    showChartValueBackground:
                                                        true,
                                                    showChartValues: true,
                                                    showChartValuesInPercentage:
                                                        true,
                                                    showChartValuesOutside:
                                                        false,
                                                    decimalPlaces: 1,
                                                  ),
                                                  gradientList: gradientList,
                                                  // emptyColorGradient: ---Empty Color gradient---
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                        top: 10, bottom: 10, left: 8, right: 8),
                                    padding: const EdgeInsets.all(8),
                                    alignment: Alignment.center,
                                    height: size.height * 0.6,
                                    width: size.width * 0.99,
                                    decoration: BoxDecoration(
                                        // shape: BoxShape.circle,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: const [
                                          BoxShadow(
                                              color:AppColors.buttonShadow,
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
                                              "BUDGET V/S BILLED",
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: SfCartesianChart(
                                            primaryXAxis: CategoryAxis(
                                                // title: AxisTitle(
                                                //     text: 'Substation',
                                                //     textStyle: const TextStyle(
                                                //         color: Colors.red,
                                                //         fontFamily: 'Roboto',
                                                //         fontSize: 16,
                                                //         fontStyle: FontStyle.italic,
                                                //         fontWeight: FontWeight.bold)),
                                                ),
                                            primaryYAxis: CategoryAxis(
                                                // title: AxisTitle(
                                                //     text: 'Outage Count',
                                                //     textStyle: const TextStyle(
                                                //         color: Colors.red,
                                                //         fontFamily: 'Roboto',
                                                //         fontSize: 16,
                                                //         fontStyle: FontStyle.italic,
                                                //         fontWeight: FontWeight.bold)),
                                                ),
                                            legend: Legend(isVisible: true),
                                            palette: const <Color>[
                                              Color.fromARGB(255, 15, 3, 182),
                                              Colors.red,
                                            ],
                                            series: <CartesianSeries>[
                                              ColumnSeries<
                                                  _ChartDataSimpleColumnChart1,
                                                  String>(
                                                name: 'BILLED',
                                                dataSource:
                                                    dataSimpleColumnChart1,
                                                xValueMapper:
                                                    (_ChartDataSimpleColumnChart1
                                                                data,
                                                            _) =>
                                                        data.x,
                                                yValueMapper:
                                                    (_ChartDataSimpleColumnChart1
                                                                data,
                                                            _) =>
                                                        data.y1,
                                                markerSettings:
                                                    const MarkerSettings(
                                                        isVisible: true,
                                                        shape: DataMarkerType
                                                            .diamond),
                                                dataLabelSettings:
                                                    const DataLabelSettings(
                                                        isVisible: true),
                                              ),
                                              ColumnSeries<
                                                  _ChartDataSimpleColumnChart1,
                                                  String>(
                                                name: 'BUDGET',
                                                dataSource:
                                                    recreateDataBudget(value),
                                                xValueMapper:
                                                    (_ChartDataSimpleColumnChart1
                                                                data,
                                                            _) =>
                                                        data.x,
                                                yValueMapper:
                                                    (_ChartDataSimpleColumnChart1
                                                                data,
                                                            _) =>
                                                        data.y,
                                                markerSettings:
                                                    const MarkerSettings(
                                                        isVisible: true,
                                                        shape: DataMarkerType
                                                            .diamond),
                                                dataLabelSettings:
                                                    const DataLabelSettings(
                                                        isVisible: true),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
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
                                                color: AppColors.buttonShadow,
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
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Row(
                                          children: [
                                            const Expanded(
                                              child: Text(
                                                "ORIGINAL BIDS",
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
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
                                        itemCount: cardList.length,
                                        //  addBudgetPlanningViewModel
                                        //     .addBudgetPlanningGetData
                                        //     .data!
                                        //     .getBudgetPlanningOfSubstationFdrAmtByBudgetIdList!
                                        //     .length,
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
                                                      0.15,
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
                                                      //  flex: 4,
                                                      child: Column(
                                                        children: [
                                                          const Align(
                                                            alignment: Alignment
                                                                .topLeft,
                                                            child: Text(
                                                              "SUBSTATION :",
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
                                                              (cardList[index]
                                                                              .substation ==
                                                                          null ||
                                                                      cardList[index]
                                                                              .substation
                                                                              .toString() ==
                                                                          'null' ||
                                                                      cardList[
                                                                              index]
                                                                          .substation
                                                                          .toString()
                                                                          .isEmpty)
                                                                  ? ''
                                                                  : cardList[
                                                                          index]
                                                                      .substation
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
                                                      0.15,
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
                                                                        "AMOUNT: ",
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
                                                                        (cardList[index].budget == null ||
                                                                                cardList[index].budget.toString() == 'null' ||
                                                                                cardList[index].budget.toString().isEmpty)
                                                                            ? ''
                                                                            : cardList[index].budget.toString(),
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
                                                                        "DELETE: ",
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
                                                                            InkWell(
                                                                          onTap:
                                                                              () {
                                                                            setState(() {
                                                                              cardList.removeAt(index);
                                                                            });
                                                                          },
                                                                          child:
                                                                              const Icon(
                                                                            Icons.delete,
                                                                            color:
                                                                                Colors.red,
                                                                            size:
                                                                                20,
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
                                                                        "FEEDER: ",
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
                                                                        (cardList[index].feeder == null ||
                                                                                cardList[index].feeder.toString() == 'null' ||
                                                                                cardList[index].feeder.toString().isEmpty)
                                                                            ? ''
                                                                            : cardList[index].feeder.toString(),
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
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () async {
                                  insertCardDataApi();
                                  // secondPageInsertApi();
                                  // secondPageCardApi();
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  alignment: Alignment.center,
                                  width: size.width * 0.5,
                                  // width: MediaQuery.of(context).size.width,
                                  // height: 40,
                                  decoration: const BoxDecoration(
                                      // shape: BoxShape.circle,
                                      //borderRadius: BorderRadius.circular(25),
                                      boxShadow: [
                                        BoxShadow(
                                            color:
                                              AppColors.buttonShadow,
                                            blurRadius: 5,
                                            offset: Offset(2.0, 5.0))
                                      ],
                                      color: Color.fromARGB(255, 130, 193, 245),
                                      gradient: LinearGradient(
                                        colors: [
                                        AppColors.baseColor,
                                          AppColors.buttonOrange,
                                          AppColors.baseColor,
                                        ],
                                      )),
                                  child: const Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Next",
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
                            ),
                          ],
                        ),
                      ),
                    )),
                  );

                default:
                  return const Text('data');
              }
            })));
  }

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
                              items: addBudgetPlanningViewModel
                                  .addBudgetPlanningGetData
                                  .data!
                                  .getAllBudgetPlanningOfSubstationAndIdList!
                                  .map((e) {
                                return DropdownMenuItem(
                                  value: e.id.toString(),
                                  child: Text(e.substation.toString()),
                                );
                              }).toList(),
                              onChanged: (val) {
                                Navigator.pop(context);
                                if (selectedFeeder != null) {
                                  selectedFeeder = null;
                                }
                                substationId = int.parse(val!);
                                substationName = getSubstationNameById(val);
                                setState(() {
                                  selectedSubstation = val;
                                });
                                fetchData(
                                    '', year!, '', substationId.toString());
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
                              items: addBudgetPlanningViewModel
                                  .addBudgetPlanningGetData
                                  .data!
                                  .getFeederBySubstationIdList!
                                  .map((e) {
                                return DropdownMenuItem(
                                  value: e.feeder.toString(),
                                  child: Text(e.feeder.toString()),
                                );
                              }).toList(),
                              onChanged: (val) {
                                // feederId = int.parse(val!);
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
                              keyboardType: TextInputType.number,
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
                      if (selectedSubstation != null &&
                          selectedFeeder != null) {
                        updatedCardNew = GetLocalCardList(
                            year: year.toString(),
                            substation:
                                getSubstationNameById(selectedSubstation!),
                            feeder: selectedFeeder!,
                            budget: _budget.text,
                            insertedBudgetAndYearOfGetId:
                                addBudgetPlanningViewModel
                                    .addBudgetPlanningGetData
                                    .data!
                                    .getInsertedBudgetId![0]
                                    .toString());
                        setState(() {
                          cardList.add(updatedCardNew!);
                          cardListMaps = cardList
                              .map((card) => {
                                    'year': card.year,
                                    'substation': card.substation,
                                    'feeder': card.feeder,
                                    'budget': card.budget,
                                    'insertedBudgetAndYearOfGetId':
                                        card.insertedBudgetAndYearOfGetId
                                  })
                              .toList();
                        });

                        // Navigator.pop(context);
                      } else {
                        // Handle case where both substation and feeder are not selected
                        // You may want to show an error message or take appropriate action
                      }
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
                                color: Color.fromARGB(255, 112, 68, 1),
                                blurRadius: 5,
                                offset: Offset(2.0, 5.0))
                          ],
                          color: Colors.black,
                          gradient: LinearGradient(
                            colors: [
                              Colors.orange,
                              Colors.orange,
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

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
      value: item,
      child: Text(item,
          style: const TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 20,
          )));

  List<_ChartDataSimpleColumnChart1> recreateDataBudget(
      AddBudgetPlanningViewModel value) {
    dataSimpleColumnChart1.clear();
    for (var i = 0;
        i <
            addBudgetPlanningViewModel.addBudgetPlanningGetData.data!
                .getSPBUDGETTOTALDTLSBugetVsBilledList!.length;
        i++) {
      dataSimpleColumnChart1.add(_ChartDataSimpleColumnChart1(
          (addBudgetPlanningViewModel.addBudgetPlanningGetData.data!
                      .getSPBUDGETTOTALDTLSBugetVsBilledList![i].yr!.isEmpty ||
                  addBudgetPlanningViewModel.addBudgetPlanningGetData.data!
                          .getSPBUDGETTOTALDTLSBugetVsBilledList![i].yr!
                          .toString() ==
                      'null')
              ? ''
              : addBudgetPlanningViewModel.addBudgetPlanningGetData.data!
                  .getSPBUDGETTOTALDTLSBugetVsBilledList![i].yr!
                  .toString(),
          (addBudgetPlanningViewModel.addBudgetPlanningGetData.data!.getSPBUDGETTOTALDTLSBugetVsBilledList![i].totalBudget.toString() == 'null')
              ? 0
              : double.parse(addBudgetPlanningViewModel.addBudgetPlanningGetData
                  .data!.getSPBUDGETTOTALDTLSBugetVsBilledList![i].totalBudget
                  .toString()),
          (addBudgetPlanningViewModel.addBudgetPlanningGetData.data!.getSPBUDGETTOTALDTLSBugetVsBilledList![i].totalBilling.toString() == 'null')
              ? 0
              : double.parse(addBudgetPlanningViewModel.addBudgetPlanningGetData.data!.getSPBUDGETTOTALDTLSBugetVsBilledList![i].totalBilling.toString().toString())));
    }
    return dataSimpleColumnChart1;
  }

  Map<String, double> _pieChartData() {
    Map<String, double> dataMap = {};

    if (addBudgetPlanningViewModel.addBudgetPlanningGetData.data != null) {
      var dataList = addBudgetPlanningViewModel
          .addBudgetPlanningGetData.data!.getAllSPBUDGETTOTALBILLINGList;

      if (dataList != null && dataList.isNotEmpty) {
        // Create the dataMap
        dataMap = {
          for (var item in dataList)
            item.yr.toString(): (item.totalBilling == null &&
                    item.totalBilling.toString() == 'null')
                ? 0.0
                : item.totalBilling!.toDouble(),
        };
        print('Inside piechart');
        print(dataMap);
      } else {
        dataMap = {'No Record': 0.0};
      }
    } else {
      print('no data in paichart');
    }
    return dataMap;
  }

  void fetchData(
      String budgetId, String year, String planDtlsId, String substationId) {
    addBudgetPlanningViewModel.fetchAddBudgetPlanningGetListApi(
        context, budgetId, year, planDtlsId, substationId);
  }

  String getSubstationNameById(String id) {
    var substationList = addBudgetPlanningViewModel.addBudgetPlanningGetData
        .data?.getAllBudgetPlanningOfSubstationAndIdList!;

    for (var subStation in substationList!) {
      if (subStation.id.toString() == id) {
        return subStation.substation.toString();
      }
    }
    return 'Substation Not Found';
  }

  Future<void> insertCardDataApi() async {
    const apiUrl =
        'https://atsdev2test.ariespro.com/civmapi/budgetPlanning/insertBUDGET_BIDSValues';
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${data.token}',
        },
        body: jsonEncode(cardListMaps),
      );

      if (response.statusCode == 200) {
        CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
            'Successfully Submitted', context);
        Future.delayed(const Duration(seconds: 1), () {
          if (addBudgetPlanningViewModel.addBudgetPlanningGetData.data!
                      .getAllBUDGETPLANDTLSByYrList ==
                  null ||
              addBudgetPlanningViewModel.addBudgetPlanningGetData.data!
                  .getAllBUDGETPLANDTLSByYrList!.isEmpty) {
            print('if condition');
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => BudgetPlanningAdd(
                      year: year!,
                      date: addBudgetPlanningViewModel
                                  .addBudgetPlanningGetData
                                  .data
                                  ?.getAllBUDGETPLANDTLSByYrList
                                  ?.isNotEmpty ==
                              true
                          ? addBudgetPlanningViewModel.addBudgetPlanningGetData
                                  .data!.getAllBUDGETPLANDTLSByYrList![0].date
                                  ?.toString() ??
                              ""
                          : "",
                      changeOrders: addBudgetPlanningViewModel
                                  .addBudgetPlanningGetData
                                  .data
                                  ?.getAllBUDGETPLANDTLSByYrList
                                  ?.isNotEmpty ==
                              true
                          ? addBudgetPlanningViewModel
                                  .addBudgetPlanningGetData
                                  .data!
                                  .getAllBUDGETPLANDTLSByYrList![0]
                                  .changeOrders
                                  ?.toString() ??
                              ""
                          : "",
                      midCycleLinePetrol: addBudgetPlanningViewModel
                                  .addBudgetPlanningGetData
                                  .data
                                  ?.getAllBUDGETPLANDTLSByYrList
                                  ?.isNotEmpty ==
                              true
                          ? addBudgetPlanningViewModel
                                  .addBudgetPlanningGetData
                                  .data!
                                  .getAllBUDGETPLANDTLSByYrList![0]
                                  .midCycleLinePatrol
                                  ?.toString() ??
                              ""
                          : "",
                      midCycleSpray: addBudgetPlanningViewModel
                                  .addBudgetPlanningGetData
                                  .data
                                  ?.getAllBUDGETPLANDTLSByYrList
                                  ?.isNotEmpty ==
                              true
                          ? addBudgetPlanningViewModel
                                  .addBudgetPlanningGetData
                                  .data!
                                  .getAllBUDGETPLANDTLSByYrList![0]
                                  .midCycleSpray
                                  ?.toString() ??
                              ""
                          : "",
                      midCycleWorkOrder: addBudgetPlanningViewModel
                                  .addBudgetPlanningGetData
                                  .data
                                  ?.getAllBUDGETPLANDTLSByYrList
                                  ?.isNotEmpty ==
                              true
                          ? addBudgetPlanningViewModel
                                  .addBudgetPlanningGetData
                                  .data!
                                  .getAllBUDGETPLANDTLSByYrList![0]
                                  .midCycleWorkOrders
                                  ?.toString() ??
                              ""
                          : "",
                      workOrders: addBudgetPlanningViewModel
                                  .addBudgetPlanningGetData
                                  .data
                                  ?.getAllBUDGETPLANDTLSByYrList
                                  ?.isNotEmpty ==
                              true
                          ? addBudgetPlanningViewModel
                                  .addBudgetPlanningGetData
                                  .data!
                                  .getAllBUDGETPLANDTLSByYrList![0]
                                  .workOrders
                                  ?.toString() ??
                              ""
                          : "",
                      stormWork: addBudgetPlanningViewModel
                                  .addBudgetPlanningGetData
                                  .data
                                  ?.getAllBUDGETPLANDTLSByYrList
                                  ?.isNotEmpty ==
                              true
                          ? addBudgetPlanningViewModel
                                  .addBudgetPlanningGetData
                                  .data!
                                  .getAllBUDGETPLANDTLSByYrList![0]
                                  .stormWork
                                  ?.toString() ??
                              ""
                          : "",
                      subSpray: addBudgetPlanningViewModel
                                  .addBudgetPlanningGetData
                                  .data
                                  ?.getAllBUDGETPLANDTLSByYrList
                                  ?.isNotEmpty ==
                              true
                          ? addBudgetPlanningViewModel
                                  .addBudgetPlanningGetData
                                  .data!
                                  .getAllBUDGETPLANDTLSByYrList![0]
                                  .subSpray
                                  ?.toString() ??
                              ""
                          : "",
                      l1: [],
                      // addBudgetPlanningViewModel
                      //             .addBudgetPlanningGetData
                      //             .data
                      //             ?.getAllBUDGETPLANDTLSByYrList
                      //             ?.isNotEmpty ==
                      //         true
                      //     ? addBudgetPlanningViewModel.addBudgetPlanningGetData
                      //         .data!.getAllBUDGETPLANDTLSByYrList![0].l1
                      //     : null,
                      id: int.parse(addBudgetPlanningViewModel
                              .addBudgetPlanningGetData
                              .data
                              ?.getInsertedBudgetId?[0]
                              .toString() ??
                          "0"),
                    )));
          } else if (addBudgetPlanningViewModel.addBudgetPlanningGetData.data!
                      .getAllBUDGETPLANDTLSByYrList !=
                  null ||
              addBudgetPlanningViewModel.addBudgetPlanningGetData.data!
                  .getAllBUDGETPLANDTLSByYrList!.isNotEmpty) {
            print('else condition');
            // secondPageInsertApi();
            // print('else');
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) =>
                    ViewBudgetPlanning(year: year!)));
          }
        });
      } else {}
    } catch (error) {}
  }

  Future<void> secondPageInsertApi() async {
    const apiUrl =
        'https://atsdev2test.ariespro.com/civmapi/budgetPlanning/insertBudgetPlanDtls';
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    // Map mappedData = {};
    List dynamicMapData = [];

    addBudgetPlanningViewModel
        .addBudgetPlanningGetData.data!.getAllBUDGETPLANDTLSByYrList!
        .forEach((a) async {
      Map mappedData = {
        "budgetId": (a.budgetId == 'null') ? '' : a.budgetId.toString(),
        "date": (a.date == 'null') ? '' : a.date.toString(),
        "changeOrders":
            (a.changeOrders == 'null') ? '' : a.changeOrders.toString(),
        "midCycleLinePatrol": (a.midCycleLinePatrol.toString() == 'null')
            ? ''
            : a.midCycleLinePatrol.toString().toString(),
        "midCycleSpray": (a.midCycleSpray.toString().toString() == 'null')
            ? ''
            : a.midCycleSpray.toString(),
        "midCycleWorkOrders": (a.midCycleWorkOrders.toString() == 'null')
            ? ''
            : a.midCycleWorkOrders.toString(),
        "workOrders":
            (a.workOrders.toString() == 'null') ? '' : a.workOrders.toString(),
        "stormWork": (a.stormWork.toString() == 'null')
            ? ''
            : a.stormWork.toString().toString(),
        "subSpray": (a.subSpray.toString().toString() == 'null')
            ? ''
            : a.subSpray.toString().toString(),
        "year": year.toString(),
      };
      dynamicMapData.add(mappedData);
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
          print('first api successfull');
          print('888888888888888888888888');
          if (a.l1 != null && a.l1!.isNotEmpty) {
            secondPageCardApi(a.l1);
          }

          // a.l1!.forEach((element) async {
          //   Map mappedDataCard = {
          //     "planDtlsId": '0',
          //     "substation": element.substation,
          //     "feeder": element.feeder,
          //     "budget": element.amount,
          //     "year": year
          //   };
          //   print('mappedDataCard');
          //   print(mappedDataCard);
          //   //try
          //   try {
          //     final response = await http.post(
          //       Uri.parse(apiUrlCard),
          //       headers: {
          //         'Content-Type': 'application/json',
          //         'Authorization': 'Bearer ${data.token}',
          //       },
          //       body: jsonEncode(mappedDataCard),
          //     );

          //     if (response.statusCode == 200) {
          //       CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
          //           'Successfully Submitted222222222222222', context);
          //       print('second api successfull');
          //       Navigator.of(context).push(MaterialPageRoute(
          //           builder: (BuildContext context) =>
          //               ViewBudgetPlanning(year: year!)));
          //     } else {}
          //   } catch (error) {
          //     print(error);
          //   }
          // });
          // secondPageCardApi();
        } else {}
      } catch (error) {}
    });
    // print(json.encode(dynamicMapData2));

    dynamicMapData.forEach((b) async {
      // try {
      //   final response = await http.post(
      //     Uri.parse(apiUrl),
      //     headers: {
      //       'Content-Type': 'application/json',
      //       'Authorization': 'Bearer ${data.token}',
      //     },
      //     body: jsonEncode(b),
      //   );

      //   if (response.statusCode == 200) {
      //     CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
      //         'Successfully Submitted', context);
      //     secondPageCardApi();
      //   } else {}
      // } catch (error) {}
    });
  }

  Future<void> secondPageCardApi(List<L1>? l1) async {
    print('third api11111111111');
    const apiUrl =
        'https://atsdev2test.ariespro.com/civmapi/budgetPlanning/insertBudgetPlanSubFdrDetls';
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    print(json.encode(l1));
    List<Map<dynamic, dynamic>> newCard = [];
    l1!.forEach((element) async {
      Map mappedDataCard = {
        "planDtlsId": '0',
        "substation": element.substation,
        "feeder": element.feeder,
        "budget": element.amount,
        "year": year
      };
      newCard.add(mappedDataCard);
      print('newCard');
      print(newCard);
      //try
      // try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${data.token}',
        },
        body: jsonEncode(newCard),
      );
      print('before 200');
      if (response.statusCode == 200) {
        print('second api successfull');
        CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
            'Successfully Submitted', context);

        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) =>
                ViewBudgetPlanning(year: year!)));
      } else {
        print('response');
        print(response.body);
      }
      // } catch (error) {
      //    print('error');
      //   print(error);
      // }
    });
  }
  // DL1.forEach((element) async {
  //   if (element != null && element != '') {
  //     print(json.encode(element));
  //     print('cardListMaps0000000000000000000000');
  //     try {
  //       final response = await http.post(
  //         Uri.parse(apiUrl),
  //         headers: {
  //           'Content-Type': 'application/json',
  //           'Authorization': 'Bearer ${data.token}',
  //         },
  //         body: jsonEncode(json.encode(element)),
  //       );

  //       if (response.statusCode == 200) {
  //         print('success');
  //         print('Response: ${response.body}');
  //         CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
  //             'Successfully Submitted222222222222222', context);
  //         Navigator.of(context).push(MaterialPageRoute(
  //             builder: (BuildContext context) =>
  //                 ViewBudgetPlanning(year: year!)));
  //       } else {
  //         print('Error: ${response.statusCode}');
  //         print('Response: ${response.body}');
  //       }
  //     } catch (error) {
  //       print('Error: $error');
  //     }
  //   }
  // });

  // print('cardListMaps0000000000000000000000');
  // print(cardListMaps);
  // try {
  //   final response = await http.post(
  //     Uri.parse(apiUrl),
  //     headers: {
  //       'Content-Type': 'application/json',
  //       'Authorization': 'Bearer ${data.token}',
  //     },
  //     body: jsonEncode(cardListMaps),
  //   );

  //   if (response.statusCode == 200) {
  //     print('success');
  //     print('Response: ${response.body}');
  //     CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
  //         'Successfully Submitted222222222222222', context);
  //     Navigator.of(context).push(MaterialPageRoute(
  //         builder: (BuildContext context) =>
  //             ViewBudgetPlanning(year: year!)));
  //   } else {
  //     print('Error: ${response.statusCode}');
  //     print('Response: ${response.body}');
  //   }
  // } catch (error) {
  //   print('Error: $error');
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
                  //   textColor: const AppColors.baseColor,
                  //   iconColor: const AppColors.baseColor,
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
                      // Constants.prefs.setBool("LoggedIn", false);
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
    // SharedPreferences preferences = await SharedPreferences.getInstance();
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

class _ChartDataSimpleColumnChart1 {
  _ChartDataSimpleColumnChart1(this.x, this.y, this.y1);

  final String x;
  final double y;
  final double y1;
}

class GetLocalCardList {
  String? year;
  String? substation;
  String? feeder;
  String? budget;
  String? insertedBudgetAndYearOfGetId;

  GetLocalCardList(
      {this.year,
      this.substation,
      this.feeder,
      this.budget,
      this.insertedBudgetAndYearOfGetId});

  @override
  String toString() {
    return 'GetLocalCardList{year: $year, substation: $substation, feeder: $feeder, budget: $budget, insertedBudgetAndYearOfGetId: $insertedBudgetAndYearOfGetId}';
  }

  // @override
  // String toString() {
  //   return toMap().toString();
  // }
}
