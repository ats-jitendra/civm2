import 'dart:convert';
import 'package:CIVM/piedmont/data/response/status.dart';
import 'package:CIVM/piedmont/utils/custom_toast_snackbar_progressdialog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:CIVM/piedmont/view_model/ivm_timeSheet_view_model.dart';
import 'package:CIVM/piedmont/resources/app_colors.dart';
import 'package:CIVM/utils/user_pref.dart';
import 'package:CIVM/models/user_model.dart';

// ignore: must_be_immutable
class CrewEditIVMTimeSheetContractor extends StatefulWidget {
  String id;
  CrewEditIVMTimeSheetContractor({Key? key, required this.id})
      : super(key: key);

  @override
  State<CrewEditIVMTimeSheetContractor> createState() =>
      _CrewEditIVMTimeSheetContractorState();
}

class _CrewEditIVMTimeSheetContractorState
    extends State<CrewEditIVMTimeSheetContractor> {
  final TextEditingController _changeOrderNo = TextEditingController();
  final TextEditingController _contractor = TextEditingController();
  final TextEditingController _crewNumber = TextEditingController();
  final TextEditingController _jobNumber = TextEditingController();
  final TextEditingController _generalForeman = TextEditingController();
  final TextEditingController _foreman = TextEditingController();
  final TextEditingController _foremanTwo = TextEditingController();
  final TextEditingController _contractorTwo = TextEditingController();
  final TextEditingController _pesticide = TextEditingController();

  final TextEditingController _remarks = TextEditingController();
  final TextEditingController _foremanDigitalSignature =
      TextEditingController();

  final TextEditingController _value = TextEditingController();
  final TextEditingController _estimatedValue = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  bool isEmployeeSelected = true;
  bool isEquipmentSelected = false;
  bool isActivitiesSelected = false;

  IvmTimeSheetViewModel ivmTimeSheetViewModel = IvmTimeSheetViewModel();

  List<EmployeeClass> employee = [];
  List<EquipmentClass> equipment = [];
  List<ActivityClass> activity = [];

  // ignore: prefer_typing_uninitialized_variables
  var selectPersonnelName;
  // ignore: prefer_typing_uninitialized_variables
  var selectEquipmentType;

  DateTime date1 = DateTime.now();

     bool _isVisibleSubmittingButton = false;
  bool _isVisibleSubmitButton = true;

  late String dateSelected1 = 'MM-dd-yyyy';
  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: date1,
        firstDate: DateTime(2010),
        lastDate: DateTime(2050));
    if (picked != null && picked != date1) {
      setState(() {
        date1 = picked;
        dateSelected1 = DateFormat('MM-dd-yyyy').format(picked);
      });
    }
  }

  late String dateSelected2 = 'MM-dd-yyyy';
  DateTime date2 = DateTime.now();
  Future<void> selectDate2(BuildContext context) async {
    final DateTime? picked2 = await showDatePicker(
        context: context,
        initialDate: date2,
        firstDate: DateTime(2010),
        lastDate: DateTime(2050));
    if (picked2 != null && picked2 != date2) {
      setState(() {
        date2 = picked2;
        dateSelected2 = DateFormat('MM-dd-yyyy').format(picked2);
      });
    }
  }

  // ignore: non_constant_identifier_names
  final select_noOfEmployees = [
    '--SELECT--',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10'
  ];
  // ignore: non_constant_identifier_names
  String? noOfEmployees = '--SELECT--';

  // ignore: non_constant_identifier_names
  final select_noOfEquipment = [
    '--SELECT--',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10'
  ];
  // ignore: non_constant_identifier_names
  String? noOfEquipment = '--SELECT--';

  // ignore: non_constant_identifier_names
  final select_noOfActivities = [
    '--SELECT--',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10'
  ];
  // ignore: non_constant_identifier_names
  String? noOfActivities = '--SELECT--';

  // ignore: non_constant_identifier_names
  final select_personnelType = [
    '--SELECT--',
    'REGULAR',
    'OVERTIME',
    'DOUBLETIME'
  ];
  // ignore: non_constant_identifier_names
  String? personnelType = '--SELECT--';

  int flag = 0;
  DateTime currentDate = DateTime.now();

  @override
  void initState() {
    ivmTimeSheetViewModel.fetchivmTimeSheetTabularListApi(context, widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // dateSelected1 = DateFormat('dd-MM-yyyy').format(currentDate);
    dateSelected2 = DateFormat('MM-dd-yyyy').format(currentDate);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text(
            'IVM TIMESHEET',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: AppColors.baseColor,
        ),
        // drawer: DrawerManu(menu: menu),
        body: ChangeNotifierProvider<IvmTimeSheetViewModel>(
            create: (BuildContext context) => ivmTimeSheetViewModel,
            child:
                Consumer<IvmTimeSheetViewModel>(builder: (context, value, _) {
              switch (value.ivmTimeSheetGetTabularData.status) {
                case Status.LOADING:
                  return const Center(child: CircularProgressIndicator());
                case Status.ERROR:
                  return
                      // CustomToastSnackBarProgressDialog.flushBarErrorMessage(
                      //     value.ivmTimeSheetGetTabularData.message.toString(),
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
                  if (flag == 0) {
                    flag = 1;
                    setData(value);
                    setDataEmployeeNew(value);
                    setDataEquipmentNew(value);
                    setDataActivityNew(value);
                  }
                  return SingleChildScrollView(
                    child: DefaultTabController(
                      length: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Column(
                          children: [
                            Form(
                              key: _formkey,
                              child: Column(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(
                                        left: 4, right: 4, top: 10, bottom: 8),
                                    padding: const EdgeInsets.all(8),
                                    alignment: Alignment.center,
                                    height: size.height * 0.5,
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
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          const Align(
                                              alignment: Alignment.centerLeft,
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    left: 2.0,
                                                    right: 2.0,
                                                    bottom: 2.0,
                                                    top: 8.0),
                                                child: Text(
                                                  "CHANGE ORDER NUMBER",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Color.fromARGB(
                                                          255, 7, 59, 120),
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              )),
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              child: TextFormField(
                                                enabled: false,
                                                //  key: formkey5,
                                                controller: _changeOrderNo,
                                                style: const TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 7, 59, 120),
                                                    fontSize: 16),
                                                obscureText: false,
                                                // keyboardType: TextInputType.number,
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
                                                  hintText: 'change order no',
                                                ),
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return "Please enter change order no";
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                              ),
                                            ),
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
                                                  "DATE",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Color.fromARGB(
                                                          255, 7, 59, 120),
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              )),
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              child: Container(
                                                height: 65,
                                                width: size.width * 0.99,
                                                decoration: const BoxDecoration(
                                                    // shape: BoxShape.circle,
                                                    boxShadow: [],
                                                    gradient: LinearGradient(
                                                      colors: [
                                                        Color.fromARGB(
                                                            255, 7, 59, 120),
                                                        Color.fromARGB(
                                                            255, 7, 59, 120),
                                                      ],
                                                    )),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(1.0),
                                                  child: Container(
                                                    width: size.width * 0.99,
                                                    decoration:
                                                        const BoxDecoration(
                                                            // shape: BoxShape.circle,
                                                            boxShadow: [],
                                                            gradient:
                                                                LinearGradient(
                                                              colors: [
                                                                Colors.white,
                                                                Colors.white,
                                                              ],
                                                            )),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 8.0),
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                            child: Row(
                                                              children: [
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .only(
                                                                          top:
                                                                              2),
                                                                  child:
                                                                      IconButton(
                                                                    icon: const Icon(
                                                                        Icons
                                                                            .calendar_month),
                                                                    iconSize:
                                                                        22,
                                                                    color: const Color
                                                                        .fromARGB(
                                                                        255,
                                                                        7,
                                                                        59,
                                                                        120),
                                                                    onPressed:
                                                                        () {
                                                                      selectDate(
                                                                          context);
                                                                      // print(date);
                                                                    },
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .only(
                                                                          left:
                                                                              2),
                                                                  child: Text(
                                                                      dateSelected1,
                                                                      style:
                                                                          const TextStyle(
                                                                        fontSize:
                                                                            16,
                                                                        color: Color.fromARGB(
                                                                            255,
                                                                            7,
                                                                            59,
                                                                            120),
                                                                      )),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
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
                                                  "CONTRACTOR",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Color.fromARGB(
                                                          255, 7, 59, 120),
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              )),
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              child: TextFormField(
                                                // enabled: false,
                                                //  key: formkey5,
                                                controller: _contractor,
                                                style: const TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 7, 59, 120),
                                                    fontSize: 16),
                                                obscureText: false,
                                                // keyboardType: TextInputType.number,
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
                                                  hintText: 'contractor',
                                                ),
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return "Please enter contractor";
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                              ),
                                            ),
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
                                                  "CREW NUMBER",
                                                  style: TextStyle(
                                                      fontSize: 16.0,
                                                      color: Color.fromARGB(
                                                          255, 7, 59, 120),
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              )),
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              child: TextFormField(
                                                // enabled: false,
                                                //  key: formkey5,
                                                controller: _crewNumber,
                                                style: const TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 7, 59, 120),
                                                    fontSize: 16),
                                                obscureText: false,
                                                // keyboardType: TextInputType.number,
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
                                                  hintText: 'crew number',
                                                ),
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return "Please enter crew number";
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                              ),
                                            ),
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
                                                  "JOB NUMBER",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Color.fromARGB(
                                                          255, 7, 59, 120),
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              )),
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              child: TextFormField(
                                                // enabled: false,
                                                //  key: formkey5,
                                                controller: _jobNumber,
                                                style: const TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 7, 59, 120),
                                                    fontSize: 16),
                                                obscureText: false,
                                                // keyboardType: TextInputType.number,
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
                                                  hintText: 'job number',
                                                ),
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return "Please enter job number";
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                              ),
                                            ),
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
                                                  "WEEKEND DATE",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Color.fromARGB(
                                                          255, 7, 59, 120),
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              )),
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              child: Container(
                                                height: 65,
                                                width: size.width * 0.99,
                                                decoration: const BoxDecoration(
                                                    // shape: BoxShape.circle,
                                                    boxShadow: [],
                                                    gradient: LinearGradient(
                                                      colors: [
                                                        Color.fromARGB(
                                                            255, 7, 59, 120),
                                                        Color.fromARGB(
                                                            255, 7, 59, 120),
                                                      ],
                                                    )),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(1.0),
                                                  child: Container(
                                                    width: size.width * 0.99,
                                                    decoration:
                                                        const BoxDecoration(
                                                            // shape: BoxShape.circle,
                                                            boxShadow: [],
                                                            gradient:
                                                                LinearGradient(
                                                              colors: [
                                                                Colors.white,
                                                                Colors.white,
                                                              ],
                                                            )),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 8.0),
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                            child: Row(
                                                              children: [
                                                                // Padding(
                                                                //   padding:
                                                                //       const EdgeInsets
                                                                //           .only(
                                                                //           top:
                                                                //               2),
                                                                //   child:
                                                                //       IconButton(
                                                                //     icon: const Icon(
                                                                //         Icons
                                                                //             .calendar_month),
                                                                //     iconSize:
                                                                //         22,
                                                                //     color: const Color
                                                                //         .fromARGB(
                                                                //         255,
                                                                //         7,
                                                                //         59,
                                                                //         120),
                                                                //     onPressed:
                                                                //         () {
                                                                //       // selectDate2(
                                                                //       //     context);
                                                                //       // print(date);
                                                                //     },
                                                                //   ),
                                                                // ),
                                                              
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .only(
                                                                          left:
                                                                              2),
                                                                  child: Text(
                                                                      dateSelected2,
                                                                      style:
                                                                          const TextStyle(
                                                                        fontSize:
                                                                            16,
                                                                        color: Color.fromARGB(
                                                                            255,
                                                                            7,
                                                                            59,
                                                                            120),
                                                                      )),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
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
                                                  "GENERAL FOREMAN",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Color.fromARGB(
                                                          255, 7, 59, 120),
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              )),
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              child: TextFormField(
                                                // enabled: false,
                                                //  key: formkey5,
                                                controller: _generalForeman,
                                                style: const TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 7, 59, 120),
                                                    fontSize: 16),
                                                obscureText: false,
                                                // keyboardType: TextInputType.number,
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
                                                  hintText: 'general foremen',
                                                ),
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return "Please enter Notes";
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                              ),
                                            ),
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
                                                  "FOREMAN DIGITAL SIGNATURE",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Color.fromARGB(
                                                          255, 7, 59, 120),
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              )),
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              child: TextFormField(
                                                // enabled: false,
                                                //  key: formkey5,
                                                controller: _foreman,
                                                style: const TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 7, 59, 120),
                                                    fontSize: 16),
                                                obscureText: false,
                                                // keyboardType: TextInputType.number,
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
                                                  hintText:
                                                      'foreman digital signature',
                                                ),
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return "Please enter foreman digital signature";
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                              ),
                                            ),
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
                                                  "CONTRACTOR",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Color.fromARGB(
                                                          255, 7, 59, 120),
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              )),
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              child: TextFormField(
                                                // enabled: false,
                                                //  key: formkey5,
                                                controller: _contractorTwo,
                                                style: const TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 7, 59, 120),
                                                    fontSize: 16),
                                                obscureText: false,
                                                // keyboardType: TextInputType.number,
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
                                                  hintText: 'contractor',
                                                ),
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return "Please enter contractor";
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                              ),
                                            ),
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
                                                  "PESTICIDE LIC NUMBER",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Color.fromARGB(
                                                          255, 7, 59, 120),
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              )),
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              child: TextFormField(
                                                // enabled: false,
                                                //  key: formkey5,
                                                controller: _pesticide,
                                                style: const TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 7, 59, 120),
                                                    fontSize: 16),
                                                obscureText: false,
                                                // keyboardType: TextInputType.number,
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
                                                  hintText:
                                                      'pesticide lic number',
                                                ),
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return "Please enter pesticide lic number";
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                              ),
                                            ),
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.only(
                                                left: 2.0,
                                                right: 2.0,
                                                bottom: 2.0,
                                                top: 8.0),
                                            child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  "PERSONNEL NAME",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Color.fromARGB(
                                                          255, 7, 59, 120),
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )),
                                          ),

                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              child: DropdownButtonFormField<
                                                  String>(
                                                hint: const Text('-Select-'),
                                                dropdownColor: Colors.white,
                                                value: selectPersonnelName,
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
                                                items: ivmTimeSheetViewModel
                                                    .ivmTimeSheetGetTabularData
                                                    .data!
                                                    .getPERSONNELRATESDataList!
                                                    .map((e) {
                                                  return DropdownMenuItem(
                                                    value: e.personnelRates
                                                        .toString(),
                                                    child: Text(e.personnelRates
                                                        .toString()),
                                                  );
                                                }).toList(),
                                                onChanged: (val) {
                                                  print('val');
                                                  setState(() {
                                                    selectPersonnelName = val;
                                                  });
                                                },
                                                validator: (value) =>
                                                    value == null
                                                        ? 'field required'
                                                        : null,
                                              ),
                                            ),
                                          ),

                                          // Align(
                                          //   alignment: Alignment.centerLeft,
                                          //   child: Padding(
                                          //     padding:
                                          //         const EdgeInsets.all(2.0),
                                          //     child: DropdownButtonFormField<
                                          //         String>(
                                          //       hint: const Text('-Select-'),
                                          //       dropdownColor: Colors.white,
                                          //       value: personnelType,
                                          //       style: const TextStyle(
                                          //           color: Color.fromARGB(
                                          //               255, 7, 59, 120),
                                          //           fontSize: 16),
                                          //       icon: const Icon(
                                          //         Icons.arrow_drop_down,
                                          //         color: Color.fromARGB(
                                          //             255, 7, 59, 120),
                                          //         size: 40,
                                          //       ),
                                          //       decoration:
                                          //           const InputDecoration(
                                          //         enabledBorder:
                                          //             OutlineInputBorder(
                                          //           borderSide: BorderSide(
                                          //             color: Color.fromARGB(
                                          //                 255, 7, 59, 120),
                                          //           ),
                                          //         ),
                                          //         focusedBorder:
                                          //             OutlineInputBorder(
                                          //           borderSide: BorderSide(
                                          //             color: Color.fromARGB(
                                          //                 255, 7, 59, 120),
                                          //           ),
                                          //         ),
                                          //       ),
                                          //       isExpanded: true,
                                          //       items: select_personnelType
                                          //           .map(buildMenuItem)
                                          //           .toList(),
                                          //       onChanged: (value) => setState(
                                          //           () =>
                                          //               personnelType = value),
                                          //       validator: (value) =>
                                          //           value == null
                                          //               ? 'field required'
                                          //               : null,
                                          //     ),
                                          //   ),
                                          // ),

                                          const Padding(
                                            padding: EdgeInsets.only(
                                                left: 2.0,
                                                right: 2.0,
                                                bottom: 2.0,
                                                top: 8.0),
                                            child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  "PERSONNEL TYPE",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Color.fromARGB(
                                                          255, 7, 59, 120),
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )),
                                          ),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              child: DropdownButtonFormField<
                                                  String>(
                                                hint: const Text('-Select-'),
                                                dropdownColor: Colors.white,
                                                value: personnelType,
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
                                                items: select_personnelType
                                                    .map(buildMenuItem)
                                                    .toList(),
                                                onChanged: (value) => setState(
                                                    () =>
                                                        personnelType = value),
                                                validator: (value) =>
                                                    value == null
                                                        ? 'field required'
                                                        : null,
                                              ),
                                            ),
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
                                                  "VALUE",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Color.fromARGB(
                                                          255, 7, 59, 120),
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              )),
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              child: TextFormField(
                                                // enabled: false,
                                                //  key: formkey5,
                                                controller: _value,
                                                style: const TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 7, 59, 120),
                                                    fontSize: 16),
                                                obscureText: false,
                                                // keyboardType: TextInputType.number,
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
                                                  hintText: 'value',
                                                ),
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return "Please enter value";
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                              ),
                                            ),
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
                                                  "ESTIMATED VALUE",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Color.fromARGB(
                                                          255, 7, 59, 120),
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              )),
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              child: TextFormField(
                                                // enabled: false,
                                                //  key: formkey5,
                                                controller: _estimatedValue,
                                                style: const TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 7, 59, 120),
                                                    fontSize: 16),
                                                obscureText: false,
                                                // keyboardType: TextInputType.number,
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
                                                  hintText: 'estimated value',
                                                ),
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return "Please enter estimated value";
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                              ),
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
                                  left: 4, right: 4, top: 10, bottom: 8),
                              padding: const EdgeInsets.all(8),
                              alignment: Alignment.center,
                              // height: size.height * 0.5,
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
                                              color: Color.fromARGB(
                                                  255, 3, 47, 97),
                                              blurRadius: 5,
                                              offset: Offset(2.0, 5.0))
                                        ],
                                        gradient: LinearGradient(
                                          colors: [
                                            AppColors.baseColor,
                                            Color.fromARGB(255, 7, 59, 120)
                                          ],
                                        )),
                                    child: const Row(children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "EMPLOYEES",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                    ]),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: DropdownButtonFormField<String>(
                                          hint: const Text('-Select-'),
                                          dropdownColor: Colors.white,
                                          value: noOfEmployees,
                                          style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 7, 59, 120),
                                              fontSize: 16),
                                          icon: const Icon(
                                            Icons.arrow_drop_down,
                                            color:
                                                AppColors.baseColor,
                                            size: 40,
                                          ),
                                          decoration: const InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color.fromARGB(
                                                    255, 7, 59, 120),
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color.fromARGB(
                                                    255, 7, 59, 120),
                                              ),
                                            ),
                                          ),
                                          isExpanded: true,
                                          items: select_noOfEmployees
                                              .map(buildMenuItem)
                                              .toList(),
                                          onChanged: (value) {
                                            setState(() {
                                              noOfEmployees = value;
                                            });
                                            createEmployeesList(
                                                int.parse(value.toString()));
                                          },
                                          validator: (value) => value == null
                                              ? 'field required'
                                              : null,
                                        ),
                                      ),
                                    ),
                                  ),
                                  noOfEmployees.toString() != '--SELECT--'
                                      ? Container(
                                          margin: const EdgeInsets.only(
                                              left: 8,
                                              right: 8,
                                              top: 8,
                                              bottom: 8),
                                          padding: const EdgeInsets.all(8),
                                          alignment: Alignment.center,
                                          height: size.height * 0.35,
                                          width: size.width * 0.99,
                                          decoration: BoxDecoration(
                                              // shape: BoxShape.circle,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              boxShadow: const [
                                                BoxShadow(
                                                    color: AppColors.baseColor,
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
                                          child: ListView.builder(
                                              itemCount: employee.length,
                                              shrinkWrap: true,
                                              itemBuilder: (BuildContext ctxt,
                                                  int index) {
                                                return Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 4.0,
                                                              bottom: 4,
                                                              left: 4),
                                                      child: Container(
                                                        width:
                                                            size.width * 0.83,
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8),
                                                        decoration:
                                                            BoxDecoration(
                                                                color: const Color
                                                                    .fromARGB(
                                                                    255,
                                                                    7,
                                                                    59,
                                                                    120),
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
                                                                )),
                                                        child: Column(
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Expanded(
                                                                    child:
                                                                        Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .centerRight,
                                                                      child:
                                                                          Padding(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            2.0),
                                                                        child:
                                                                            TextFormField(
                                                                          //  key: formkey5,
                                                                          controller:
                                                                              employee[index].employeeNo,
                                                                          style: const TextStyle(
                                                                              color: Colors.white,
                                                                              fontSize: 12),
                                                                          obscureText:
                                                                              false,
                                                                          // keyboardType: TextInputType.number,
                                                                          decoration: const InputDecoration(
                                                                              border: OutlineInputBorder(
                                                                                  // borderRadius: BorderRadius.circular(25),
                                                                                  ),
                                                                              enabledBorder: OutlineInputBorder(
                                                                                borderSide: BorderSide(
                                                                                  color: Colors.white,
                                                                                ),
                                                                                // borderRadius: BorderRadius.circular(25),
                                                                              ),
                                                                              labelText: 'EMPLOYEE NUMBER',
                                                                              labelStyle: TextStyle(color: Colors.white, fontSize: 12)),

                                                                          validator:
                                                                              (value) {
                                                                            if (value!.isEmpty) {
                                                                              return "Please enter employee no";
                                                                            } else {
                                                                              return null;
                                                                            }
                                                                          },
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    child:
                                                                        Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .centerRight,
                                                                      child:
                                                                          Padding(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            2.0),
                                                                        child:
                                                                            TextFormField(
                                                                          //  key: formkey5,
                                                                          controller:
                                                                              employee[index].employeeName,
                                                                          style: const TextStyle(
                                                                              color: Colors.white,
                                                                              fontSize: 12),
                                                                          obscureText:
                                                                              false,
                                                                          // keyboardType: TextInputType.number,
                                                                          decoration: const InputDecoration(
                                                                              border: OutlineInputBorder(
                                                                                  // borderRadius: BorderRadius.circular(25),
                                                                                  ),
                                                                              enabledBorder: OutlineInputBorder(
                                                                                borderSide: BorderSide(
                                                                                  color: Colors.white,
                                                                                ),
                                                                                // borderRadius: BorderRadius.circular(25),
                                                                              ),
                                                                              labelText: 'EMPLOYEE NAME',
                                                                              labelStyle: TextStyle(color: Colors.white, fontSize: 12)),

                                                                          validator:
                                                                              (value) {
                                                                            if (value!.isEmpty) {
                                                                              return "Please enter employee name";
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
                                                              const Divider(
                                                                color:
                                                                    Colors.grey,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Expanded(
                                                                    child:
                                                                        Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .centerRight,
                                                                      child:
                                                                          Padding(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            2.0),
                                                                        child:
                                                                            TextFormField(
                                                                          //  key: formkey5,
                                                                          controller:
                                                                              employee[index].otherCrew,
                                                                          style: const TextStyle(
                                                                              color: Colors.white,
                                                                              fontSize: 12),
                                                                          obscureText:
                                                                              false,

                                                                          decoration: const InputDecoration(
                                                                              border: OutlineInputBorder(
                                                                                  // borderRadius: BorderRadius.circular(25),
                                                                                  ),
                                                                              enabledBorder: OutlineInputBorder(
                                                                                borderSide: BorderSide(
                                                                                  color: Colors.white,
                                                                                ),
                                                                                // borderRadius: BorderRadius.circular(25),
                                                                              ),
                                                                              labelText: 'OTHER CREW',
                                                                              labelStyle: TextStyle(color: Colors.white, fontSize: 12)),
                                                                          onChanged:
                                                                              (value) {
                                                                            // calculateTotalCost(
                                                                            //     index);
                                                                            print('123456');
                                                                          },
                                                                          validator:
                                                                              (value) {
                                                                            if (value!.isEmpty) {
                                                                              return "Please enter other crew";
                                                                            } else {
                                                                              return null;
                                                                            }
                                                                          },
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    child:
                                                                        Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .centerRight,
                                                                      child:
                                                                          Padding(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            2.0),
                                                                        child:
                                                                            TextFormField(
                                                                          //  key: formkey5,
                                                                          controller:
                                                                              employee[index].classCode,
                                                                          style: const TextStyle(
                                                                              color: Colors.white,
                                                                              fontSize: 12),
                                                                          obscureText:
                                                                              false,

                                                                          decoration: const InputDecoration(
                                                                              border: OutlineInputBorder(
                                                                                  // borderRadius: BorderRadius.circular(25),
                                                                                  ),
                                                                              enabledBorder: OutlineInputBorder(
                                                                                borderSide: BorderSide(
                                                                                  color: Colors.white,
                                                                                ),
                                                                                // borderRadius: BorderRadius.circular(25),
                                                                              ),
                                                                              labelText: 'CLASS CODE',
                                                                              labelStyle: TextStyle(color: Colors.white, fontSize: 12)),
                                                                          onChanged:
                                                                              (value) {
                                                                            // calculateTotalCost(
                                                                            //     index);
                                                                            print('123456');
                                                                          },
                                                                          validator:
                                                                              (value) {
                                                                            if (value!.isEmpty) {
                                                                              return "Please enter class code";
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
                                                              const Divider(
                                                                color:
                                                                    Colors.grey,
                                                              ),
                                                              SizedBox(
                                                                child: ListView
                                                                    .builder(
                                                                        itemCount: employee[index]
                                                                            .additionalData!
                                                                            .length,
                                                                        shrinkWrap:
                                                                            true,
                                                                        itemBuilder:
                                                                            (BuildContext ctxt,
                                                                                int index2) {
                                                                          return Column(
                                                                            children: [
                                                                              Container(
                                                                                width: size.width * 0.78,
                                                                                padding: const EdgeInsets.only(top: 4, bottom: 4, left: 4, right: 4),
                                                                                decoration: BoxDecoration(
                                                                                    color: const Color.fromARGB(255, 4, 172, 174),
                                                                                    border: Border.all(
                                                                                      color: Colors.white,
                                                                                    ),
                                                                                    borderRadius: const BorderRadius.only(
                                                                                      topRight: Radius.circular(10),
                                                                                      bottomRight: Radius.circular(10),
                                                                                      topLeft: Radius.circular(10),
                                                                                      bottomLeft: Radius.circular(10),
                                                                                    )),
                                                                                child: Column(children: [
                                                                                  Row(
                                                                                    children: [
                                                                                      Expanded(
                                                                                        flex: 4,
                                                                                        child: Align(
                                                                                          alignment: Alignment.centerRight,
                                                                                          child: Padding(
                                                                                            padding: const EdgeInsets.all(2.0),
                                                                                            child: TextFormField(
                                                                                              enabled: false,
                                                                                              //  key: formkey5,
                                                                                              controller: employee[index].additionalData![index2].day,
                                                                                              style: const TextStyle(color: AppColors.baseColor, fontSize: 16, fontWeight: FontWeight.bold),
                                                                                              obscureText: false,
                                                                                              // keyboardType: TextInputType.number,
                                                                                              decoration: const InputDecoration(
                                                                                                  border: OutlineInputBorder(
                                                                                                      // borderRadius: BorderRadius.circular(25),
                                                                                                      ),
                                                                                                  disabledBorder: OutlineInputBorder(
                                                                                                    borderSide: BorderSide(
                                                                                                      color: Colors.white,
                                                                                                    ),
                                                                                                    // borderRadius: BorderRadius.circular(25),
                                                                                                  ),
                                                                                                  labelText: 'DAY',
                                                                                                  labelStyle: TextStyle(color: Colors.white, fontSize: 12)),

                                                                                              validator: (value) {
                                                                                                if (value!.isEmpty) {
                                                                                                  return "Please enter day";
                                                                                                } else {
                                                                                                  return null;
                                                                                                }
                                                                                              },
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                      Expanded(
                                                                                        flex: 4,
                                                                                        child: Align(
                                                                                          alignment: Alignment.centerRight,
                                                                                          child: Padding(
                                                                                            padding: const EdgeInsets.all(2.0),
                                                                                            child: TextFormField(
                                                                                              //  key: formkey5,
                                                                                              controller: employee[index].additionalData![index2].hours,
                                                                                              style: const TextStyle(color: Colors.white, fontSize: 12),
                                                                                              obscureText: false,
                                                                                              // keyboardType: TextInputType.number,
                                                                                              decoration: const InputDecoration(
                                                                                                  border: OutlineInputBorder(
                                                                                                      // borderRadius: BorderRadius.circular(25),
                                                                                                      ),
                                                                                                  enabledBorder: OutlineInputBorder(
                                                                                                    borderSide: BorderSide(
                                                                                                      color: Colors.white,
                                                                                                    ),
                                                                                                    // borderRadius: BorderRadius.circular(25),
                                                                                                  ),
                                                                                                  labelText: 'HOURS',
                                                                                                  labelStyle: TextStyle(color: Colors.white, fontSize: 12)),

                                                                                              validator: (value) {
                                                                                                if (value!.isEmpty) {
                                                                                                  return "Please enter hours";
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
                                                                                ]),
                                                                              ),
                                                                              Container(
                                                                                width: size.width * 0.78,
                                                                                padding: const EdgeInsets.only(top: 4, bottom: 4, left: 4, right: 4),
                                                                                decoration: BoxDecoration(
                                                                                    color: const Color.fromARGB(255, 4, 172, 174),
                                                                                    border: Border.all(
                                                                                      color: Colors.white,
                                                                                    ),
                                                                                    borderRadius: const BorderRadius.only(
                                                                                      topRight: Radius.circular(10),
                                                                                      bottomRight: Radius.circular(10),
                                                                                      topLeft: Radius.circular(10),
                                                                                      bottomLeft: Radius.circular(10),
                                                                                    )),
                                                                                child: Column(children: [
                                                                                  Row(
                                                                                    children: [
                                                                                      Expanded(
                                                                                        flex: 4,
                                                                                        child: Align(
                                                                                          alignment: Alignment.centerRight,
                                                                                          child: Padding(
                                                                                            padding: const EdgeInsets.all(2.0),
                                                                                            child: TextFormField(
                                                                                              //  key: formkey5,
                                                                                              controller: employee[index].additionalData![index2].morningIn,
                                                                                              style: const TextStyle(color: Colors.white, fontSize: 12),
                                                                                              obscureText: false,
                                                                                              // keyboardType: TextInputType.number,
                                                                                              decoration: const InputDecoration(
                                                                                                  border: OutlineInputBorder(
                                                                                                      // borderRadius: BorderRadius.circular(25),
                                                                                                      ),
                                                                                                  enabledBorder: OutlineInputBorder(
                                                                                                    borderSide: BorderSide(
                                                                                                      color: Colors.white,
                                                                                                    ),
                                                                                                    // borderRadius: BorderRadius.circular(25),
                                                                                                  ),
                                                                                                  labelText: 'MORNING IN',
                                                                                                  labelStyle: TextStyle(color: Colors.white, fontSize: 12)),

                                                                                              validator: (value) {
                                                                                                if (value!.isEmpty) {
                                                                                                  return "Please enter morning in";
                                                                                                } else {
                                                                                                  return null;
                                                                                                }
                                                                                              },
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                      Expanded(
                                                                                        flex: 4,
                                                                                        child: Align(
                                                                                          alignment: Alignment.centerRight,
                                                                                          child: Padding(
                                                                                            padding: const EdgeInsets.all(2.0),
                                                                                            child: TextFormField(
                                                                                              //  key: formkey5,
                                                                                              controller: employee[index].additionalData![index2].morningOut,
                                                                                              style: const TextStyle(color: Colors.white, fontSize: 12),
                                                                                              obscureText: false,
                                                                                              // keyboardType: TextInputType.number,
                                                                                              decoration: const InputDecoration(
                                                                                                  border: OutlineInputBorder(
                                                                                                      // borderRadius: BorderRadius.circular(25),
                                                                                                      ),
                                                                                                  enabledBorder: OutlineInputBorder(
                                                                                                    borderSide: BorderSide(
                                                                                                      color: Colors.white,
                                                                                                    ),
                                                                                                    // borderRadius: BorderRadius.circular(25),
                                                                                                  ),
                                                                                                  labelText: 'MORNING OUT',
                                                                                                  labelStyle: TextStyle(color: Colors.white, fontSize: 12)),

                                                                                              validator: (value) {
                                                                                                if (value!.isEmpty) {
                                                                                                  return "Please enter morning out";
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
                                                                                ]),
                                                                              ),
                                                                              Container(
                                                                                width: size.width * 0.78,
                                                                                padding: const EdgeInsets.only(top: 4, bottom: 4, left: 4, right: 4),
                                                                                decoration: BoxDecoration(
                                                                                    color: const Color.fromARGB(255, 4, 172, 174),
                                                                                    border: Border.all(
                                                                                      color: Colors.white,
                                                                                    ),
                                                                                    borderRadius: const BorderRadius.only(
                                                                                      topRight: Radius.circular(10),
                                                                                      bottomRight: Radius.circular(10),
                                                                                      topLeft: Radius.circular(10),
                                                                                      bottomLeft: Radius.circular(10),
                                                                                    )),
                                                                                child: Column(children: [
                                                                                  Row(
                                                                                    children: [
                                                                                      Expanded(
                                                                                        flex: 4,
                                                                                        child: Align(
                                                                                          alignment: Alignment.centerRight,
                                                                                          child: Padding(
                                                                                            padding: const EdgeInsets.all(2.0),
                                                                                            child: TextFormField(
                                                                                              //  key: formkey5,
                                                                                              controller: employee[index].additionalData![index2].afetrnoonIn,
                                                                                              style: const TextStyle(color: Colors.white, fontSize: 12),
                                                                                              obscureText: false,
                                                                                              // keyboardType: TextInputType.number,
                                                                                              decoration: const InputDecoration(
                                                                                                  border: OutlineInputBorder(
                                                                                                      // borderRadius: BorderRadius.circular(25),
                                                                                                      ),
                                                                                                  enabledBorder: OutlineInputBorder(
                                                                                                    borderSide: BorderSide(
                                                                                                      color: Colors.white,
                                                                                                    ),
                                                                                                    // borderRadius: BorderRadius.circular(25),
                                                                                                  ),
                                                                                                  labelText: 'AFTERNOON IN',
                                                                                                  labelStyle: TextStyle(color: Colors.white, fontSize: 12)),

                                                                                              validator: (value) {
                                                                                                if (value!.isEmpty) {
                                                                                                  return "Please enter afternoon in";
                                                                                                } else {
                                                                                                  return null;
                                                                                                }
                                                                                              },
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                      Expanded(
                                                                                        flex: 4,
                                                                                        child: Align(
                                                                                          alignment: Alignment.centerRight,
                                                                                          child: Padding(
                                                                                            padding: const EdgeInsets.all(2.0),
                                                                                            child: TextFormField(
                                                                                              //  key: formkey5,
                                                                                              controller: employee[index].additionalData![index2].afetrnoonOut,
                                                                                              style: const TextStyle(color: Colors.white, fontSize: 12),
                                                                                              obscureText: false,
                                                                                              // keyboardType: TextInputType.number,
                                                                                              decoration: const InputDecoration(
                                                                                                  border: OutlineInputBorder(
                                                                                                      // borderRadius: BorderRadius.circular(25),
                                                                                                      ),
                                                                                                  enabledBorder: OutlineInputBorder(
                                                                                                    borderSide: BorderSide(
                                                                                                      color: Colors.white,
                                                                                                    ),
                                                                                                    // borderRadius: BorderRadius.circular(25),
                                                                                                  ),
                                                                                                  labelText: 'AFTERNOON OUT',
                                                                                                  labelStyle: TextStyle(color: Colors.white, fontSize: 12)),

                                                                                              validator: (value) {
                                                                                                if (value!.isEmpty) {
                                                                                                  return "Please enter afternoon out";
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
                                                                                ]),
                                                                              ),
                                                                            ],
                                                                          );
                                                                        }),
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Expanded(
                                                                    child:
                                                                        Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .centerRight,
                                                                      child: Padding(
                                                                          padding: const EdgeInsets.all(2.0),
                                                                          child: InkWell(
                                                                            onTap:
                                                                                () {
                                                                              setState(() {
                                                                                employee.removeAt(index);
                                                                                noOfEmployees = cardLength(noOfEmployees.toString());
                                                                              });
                                                                            },
                                                                            child:
                                                                                const Icon(Icons.delete, color: Colors.white),
                                                                          )),
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
                                        )
                                      : const Text(
                                          "",
                                          style: TextStyle(
                                            fontSize: 0.0,
                                            color: Colors.white,
                                          ),
                                        ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: InkWell(
                                      onTap: () {
                                        print('Add another herbicide');
                                        (noOfEmployees != '10' &&
                                                noOfEmployees != '--SELECT--')
                                            ? setState(() {
                                                noOfEmployees = (int.parse(
                                                            noOfEmployees
                                                                .toString()) +
                                                        1)
                                                    .toString();
                                              })
                                            : (noOfEmployees == '--SELECT--')
                                                ? setState(() {
                                                    noOfEmployees = '1';
                                                  })
                                                : CustomToastSnackBarProgressDialog
                                                    .snackBar(
                                                        'Maximum Limit of Employee is 10',
                                                        context);
                                        employee.add(EmployeeClass
                                            .createWithAdditionalData());
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(10),
                                        alignment: Alignment.center,
                                        // width: size.width * 0.6,
                                        // width: MediaQuery.of(context).size.width,
                                        // height: 40,
                                        decoration: const BoxDecoration(
                                            // shape: BoxShape.circle,
                                            //borderRadius: BorderRadius.circular(25),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Color.fromARGB(
                                                      255, 155, 69, 3),
                                                  blurRadius: 5,
                                                  offset: Offset(2.0, 5.0))
                                            ],
                                            gradient: LinearGradient(
                                              colors: [
                                                Color.fromARGB(
                                                    255, 255, 111, 0),
                                                Color.fromARGB(
                                                    255, 255, 111, 0),
                                              ],
                                            )),
                                        child: const Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            "Add Another EMPLOYEE",
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
                            Container(
                              margin: const EdgeInsets.only(
                                  left: 4, right: 4, top: 10, bottom: 8),
                              padding: const EdgeInsets.all(8),
                              alignment: Alignment.center,
                              // height: size.height * 0.5,
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
                                              color: Color.fromARGB(
                                                  255, 3, 47, 97),
                                              blurRadius: 5,
                                              offset: Offset(2.0, 5.0))
                                        ],
                                        gradient: LinearGradient(
                                          colors: [
                                            AppColors.baseColor,
                                            Color.fromARGB(255, 7, 59, 120)
                                          ],
                                        )),
                                    child: const Row(children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "EQUIPMENT",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                    ]),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: DropdownButtonFormField<String>(
                                          hint: const Text('-Select-'),
                                          dropdownColor: Colors.white,
                                          value: noOfEquipment,
                                          style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 7, 59, 120),
                                              fontSize: 16),
                                          icon: const Icon(
                                            Icons.arrow_drop_down,
                                            color:
                                                AppColors.baseColor,
                                            size: 40,
                                          ),
                                          decoration: const InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color.fromARGB(
                                                    255, 7, 59, 120),
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color.fromARGB(
                                                    255, 7, 59, 120),
                                              ),
                                            ),
                                          ),
                                          isExpanded: true,
                                          items: select_noOfEquipment
                                              .map(buildMenuItem)
                                              .toList(),
                                          onChanged: (value) {
                                            setState(() {
                                              noOfEquipment = value;
                                            });
                                            createEquipmentList(
                                                int.parse(value.toString()));
                                          },
                                          validator: (value) => value == null
                                              ? 'field required'
                                              : null,
                                        ),
                                      ),
                                    ),
                                  ),
                                  noOfEquipment.toString() != '--SELECT--'
                                      ? Container(
                                          margin: const EdgeInsets.only(
                                              left: 8,
                                              right: 8,
                                              top: 8,
                                              bottom: 8),
                                          padding: const EdgeInsets.all(8),
                                          alignment: Alignment.center,
                                          height: size.height * 0.35,
                                          width: size.width * 0.99,
                                          decoration: BoxDecoration(
                                              // shape: BoxShape.circle,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              boxShadow: const [
                                                BoxShadow(
                                                    color: Color.fromARGB(
                                                        255, 7, 59, 120),
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
                                          child: ListView.builder(
                                              itemCount: equipment.length,
                                              shrinkWrap: true,
                                              itemBuilder: (BuildContext ctxt,
                                                  int index) {
                                                return Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 4.0,
                                                              bottom: 4,
                                                              left: 4),
                                                      child: Container(
                                                        width:
                                                            size.width * 0.83,
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8),
                                                        decoration:
                                                            BoxDecoration(
                                                                color: const Color
                                                                    .fromARGB(
                                                                    255,
                                                                    7,
                                                                    59,
                                                                    120),
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
                                                                )),
                                                        child: Column(
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Expanded(
                                                                    child:
                                                                        Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .centerLeft,
                                                                      child:
                                                                          Padding(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            2.0),
                                                                        child:
                                                                            SizedBox(
                                                                          height:
                                                                              60,
                                                                          child:
                                                                              DropdownButtonFormField<String>(
                                                                            // hint:
                                                                            //     const Text(
                                                                            //   '--SELECT--',
                                                                            //   style:
                                                                            //       TextStyle(
                                                                            //     color: Colors.white,
                                                                            //     // fontWeight: FontWeight.bold,
                                                                            //     fontSize: 12,
                                                                            //   ),
                                                                            // ),
                                                                            dropdownColor: const Color.fromARGB(
                                                                                255,
                                                                                7,
                                                                                59,
                                                                                120),
                                                                            value:
                                                                                equipment[index].equipmentType,
                                                                            style:
                                                                                const TextStyle(color: Colors.white, fontSize: 16),
                                                                            icon:
                                                                                const Icon(
                                                                              Icons.arrow_drop_down,
                                                                              color: AppColors.baseColor,
                                                                              size: 40,
                                                                            ),
                                                                            decoration:
                                                                                const InputDecoration(
                                                                              border: OutlineInputBorder(
                                                                                  // borderRadius: BorderRadius.circular(25),
                                                                                  ),
                                                                              enabledBorder: OutlineInputBorder(
                                                                                borderSide: BorderSide(
                                                                                  color: Colors.white,
                                                                                ),
                                                                                // borderRadius: BorderRadius.circular(25),
                                                                              ),
                                                                              labelText: 'EQUIPMENT TYPE',
                                                                              labelStyle: TextStyle(color: Colors.white, fontSize: 12),
                                                                              contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 16), // Adjust padding for the box
                                                                              isDense: true,
                                                                            ),
                                                                            isExpanded:
                                                                                true,
                                                                            items:
                                                                                ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!.getEQUIPMENTRATESDataList!.map((e) {
                                                                              return DropdownMenuItem(
                                                                                value: e.equipmentType.toString(),
                                                                                //error/////////////////
                                                                                child: Text(e.equipmentType.toString()),
                                                                              );
                                                                            }).toList(),
                                                                            onChanged:
                                                                                (val) {
                                                                              // var newTextController = TextEditingController(text: val);
                                                                              setState(() {
                                                                                equipment[index].equipmentType = val;
                                                                                // equipment[index].rates = newTextController;
                                                                                var selectedEquipment = ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!.getEQUIPMENTRATESDataList!.firstWhere((e) => e.equipmentType.toString() == val);
                                                                                if (selectedEquipment.rates != null) {
                                                                                  equipment[index].rates = TextEditingController(
                                                                                    text: selectedEquipment.rates.toString(),
                                                                                  );
                                                                                } else {
                                                                                  equipment[index].rates = TextEditingController(
                                                                                    text: "N/A",
                                                                                  );
                                                                                }
                                                                              });
                                                                            },
                                                                            validator: (value) => value == null
                                                                                ? 'field required'
                                                                                : null,
                                                                          ),
                                                                        ),
                                                                      ),
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
                                                                    child:
                                                                        Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .centerRight,
                                                                      child:
                                                                          Padding(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            2.0),
                                                                        child:
                                                                            TextFormField(
                                                                          //  key: formkey5,
                                                                          controller:
                                                                              equipment[index].otherCrew,
                                                                          style: const TextStyle(
                                                                              color: Colors.white,
                                                                              fontSize: 12),
                                                                          obscureText:
                                                                              false,

                                                                          decoration: const InputDecoration(
                                                                              border: OutlineInputBorder(
                                                                                  // borderRadius: BorderRadius.circular(25),
                                                                                  ),
                                                                              enabledBorder: OutlineInputBorder(
                                                                                borderSide: BorderSide(
                                                                                  color: Colors.white,
                                                                                ),
                                                                                // borderRadius: BorderRadius.circular(25),
                                                                              ),
                                                                              labelText: 'OTHER CREW',
                                                                              labelStyle: TextStyle(color: Colors.white, fontSize: 12)),
                                                                          onChanged:
                                                                              (value) {
                                                                            // calculateTotalCost(
                                                                            //     index);
                                                                            print('123456');
                                                                          },
                                                                          validator:
                                                                              (value) {
                                                                            if (value!.isEmpty) {
                                                                              return "Please enter other crew";
                                                                            } else {
                                                                              return null;
                                                                            }
                                                                          },
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    child:
                                                                        Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .centerRight,
                                                                      child:
                                                                          Padding(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            2.0),
                                                                        child:
                                                                            TextFormField(
                                                                          //  key: formkey5,
                                                                          controller:
                                                                              equipment[index].equipmentCode,
                                                                          style: const TextStyle(
                                                                              color: Colors.white,
                                                                              fontSize: 12),
                                                                          obscureText:
                                                                              false,
                                                                          // keyboardType: TextInputType.number,
                                                                          decoration: const InputDecoration(
                                                                              border: OutlineInputBorder(
                                                                                  // borderRadius: BorderRadius.circular(25),
                                                                                  ),
                                                                              enabledBorder: OutlineInputBorder(
                                                                                borderSide: BorderSide(
                                                                                  color: Colors.white,
                                                                                ),
                                                                                // borderRadius: BorderRadius.circular(25),
                                                                              ),
                                                                              labelText: 'EQUIPMENT CODE',
                                                                              labelStyle: TextStyle(color: Colors.white, fontSize: 12)),

                                                                          validator:
                                                                              (value) {
                                                                            if (value!.isEmpty) {
                                                                              return "Please enter equipment code";
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
                                                              const Divider(
                                                                color:
                                                                    Colors.grey,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Expanded(
                                                                    child:
                                                                        Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .centerRight,
                                                                      child:
                                                                          Padding(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            2.0),
                                                                        child:
                                                                            TextFormField(
                                                                          //  key: formkey5,
                                                                          controller:
                                                                              equipment[index].classCode,
                                                                          style: const TextStyle(
                                                                              color: Colors.white,
                                                                              fontSize: 12),
                                                                          obscureText:
                                                                              false,

                                                                          decoration: const InputDecoration(
                                                                              border: OutlineInputBorder(
                                                                                  // borderRadius: BorderRadius.circular(25),
                                                                                  ),
                                                                              enabledBorder: OutlineInputBorder(
                                                                                borderSide: BorderSide(
                                                                                  color: Colors.white,
                                                                                ),
                                                                                // borderRadius: BorderRadius.circular(25),
                                                                              ),
                                                                              labelText: 'CLASS CODE',
                                                                              labelStyle: TextStyle(color: Colors.white, fontSize: 12)),
                                                                          onChanged:
                                                                              (value) {
                                                                            // calculateTotalCost(
                                                                            //     index);
                                                                            print('123456');
                                                                          },
                                                                          validator:
                                                                              (value) {
                                                                            if (value!.isEmpty) {
                                                                              return "Please enter class code";
                                                                            } else {
                                                                              return null;
                                                                            }
                                                                          },
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    child:
                                                                        Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .centerRight,
                                                                      child:
                                                                          Padding(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            2.0),
                                                                        child:
                                                                            TextFormField(
                                                                          //  key: formkey5,
                                                                          controller:
                                                                              equipment[index].rates,
                                                                          style: const TextStyle(
                                                                              color: Colors.white,
                                                                              fontSize: 12),
                                                                          obscureText:
                                                                              false,

                                                                          decoration: const InputDecoration(
                                                                              border: OutlineInputBorder(
                                                                                  // borderRadius: BorderRadius.circular(25),
                                                                                  ),
                                                                              enabledBorder: OutlineInputBorder(
                                                                                borderSide: BorderSide(
                                                                                  color: Colors.white,
                                                                                ),
                                                                                // borderRadius: BorderRadius.circular(25),
                                                                              ),
                                                                              labelText: 'RATES',
                                                                              labelStyle: TextStyle(color: Colors.white, fontSize: 12)),
                                                                          onChanged:
                                                                              (value) {
                                                                            // calculateTotalCost(
                                                                            //     index);
                                                                            print('123456');
                                                                          },
                                                                          validator:
                                                                              (value) {
                                                                            if (value!.isEmpty) {
                                                                              return "Please enter rates";
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
                                                              const Divider(
                                                                color:
                                                                    Colors.grey,
                                                              ),
                                                              SizedBox(
                                                                child: ListView
                                                                    .builder(
                                                                        itemCount: equipment[index]
                                                                            .additionalData!
                                                                            .length,
                                                                        shrinkWrap:
                                                                            true,
                                                                        itemBuilder:
                                                                            (BuildContext ctxt,
                                                                                int index2) {
                                                                          return Column(
                                                                            children: [
                                                                              Container(
                                                                                width: size.width * 0.78,
                                                                                padding: const EdgeInsets.only(top: 4, bottom: 4, left: 4, right: 4),
                                                                                decoration: BoxDecoration(
                                                                                    color: const Color.fromARGB(255, 4, 172, 174),
                                                                                    border: Border.all(
                                                                                      color: Colors.white,
                                                                                    ),
                                                                                    borderRadius: const BorderRadius.only(
                                                                                      topRight: Radius.circular(10),
                                                                                      bottomRight: Radius.circular(10),
                                                                                      topLeft: Radius.circular(10),
                                                                                      bottomLeft: Radius.circular(10),
                                                                                    )),
                                                                                child: Column(children: [
                                                                                  Row(
                                                                                    children: [
                                                                                      Expanded(
                                                                                        flex: 4,
                                                                                        child: Align(
                                                                                          alignment: Alignment.centerRight,
                                                                                          child: Padding(
                                                                                            padding: const EdgeInsets.all(2.0),
                                                                                            child: TextFormField(
                                                                                              enabled: false,
                                                                                              //  key: formkey5,
                                                                                              controller: equipment[index].additionalData![index2].day,
                                                                                              style: const TextStyle(color: AppColors.baseColor, fontSize: 16, fontWeight: FontWeight.bold),
                                                                                              obscureText: false,
                                                                                              // keyboardType: TextInputType.number,
                                                                                              decoration: const InputDecoration(
                                                                                                  border: OutlineInputBorder(
                                                                                                      // borderRadius: BorderRadius.circular(25),
                                                                                                      ),
                                                                                                  disabledBorder: OutlineInputBorder(
                                                                                                    borderSide: BorderSide(
                                                                                                      color: Colors.white,
                                                                                                    ),
                                                                                                    // borderRadius: BorderRadius.circular(25),
                                                                                                  ),
                                                                                                  labelText: 'DAY',
                                                                                                  labelStyle: TextStyle(color: Colors.white, fontSize: 12)),

                                                                                              validator: (value) {
                                                                                                if (value!.isEmpty) {
                                                                                                  return "Please enter day";
                                                                                                } else {
                                                                                                  return null;
                                                                                                }
                                                                                              },
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                      Expanded(
                                                                                        flex: 4,
                                                                                        child: Align(
                                                                                          alignment: Alignment.centerRight,
                                                                                          child: Padding(
                                                                                            padding: const EdgeInsets.all(2.0),
                                                                                            child: TextFormField(
                                                                                              //  key: formkey5,
                                                                                              controller: equipment[index].additionalData![index2].hours,
                                                                                              style: const TextStyle(color: Colors.white, fontSize: 12),
                                                                                              obscureText: false,
                                                                                              // keyboardType: TextInputType.number,
                                                                                              decoration: const InputDecoration(
                                                                                                  border: OutlineInputBorder(
                                                                                                      // borderRadius: BorderRadius.circular(25),
                                                                                                      ),
                                                                                                  enabledBorder: OutlineInputBorder(
                                                                                                    borderSide: BorderSide(
                                                                                                      color: Colors.white,
                                                                                                    ),
                                                                                                    // borderRadius: BorderRadius.circular(25),
                                                                                                  ),
                                                                                                  labelText: 'HOURS',
                                                                                                  labelStyle: TextStyle(color: Colors.white, fontSize: 12)),

                                                                                              validator: (value) {
                                                                                                if (value!.isEmpty) {
                                                                                                  return "Please enter hours";
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
                                                                                ]),
                                                                              ),
                                                                            ],
                                                                          );
                                                                        }),
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Expanded(
                                                                    child:
                                                                        Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .centerRight,
                                                                      child: Padding(
                                                                          padding: const EdgeInsets.all(2.0),
                                                                          child: InkWell(
                                                                            onTap:
                                                                                () {
                                                                              setState(() {
                                                                                equipment.removeAt(index);
                                                                                noOfEquipment = cardLength(noOfEquipment.toString());
                                                                              });
                                                                            },
                                                                            child:
                                                                                const Icon(Icons.delete, color: Colors.white),
                                                                          )),
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
                                        )
                                      : const Text(
                                          "",
                                          style: TextStyle(
                                            fontSize: 0.0,
                                            color: Colors.white,
                                          ),
                                        ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: InkWell(
                                      onTap: () {
                                        print('Add another herbicide');
                                        (noOfEquipment != '10' &&
                                                noOfEquipment != '--SELECT--')
                                            ? setState(() {
                                                noOfEquipment = (int.parse(
                                                            noOfEquipment
                                                                .toString()) +
                                                        1)
                                                    .toString();
                                              })
                                            : (noOfEquipment == '--SELECT--')
                                                ? setState(() {
                                                    noOfEquipment = '1';
                                                  })
                                                : CustomToastSnackBarProgressDialog
                                                    .snackBar(
                                                        'Maximum Limit of Equipment is 10',
                                                        context);
                                        equipment.add(EquipmentClass
                                            .createWithAdditionalData());
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(10),
                                        alignment: Alignment.center,
                                        // width: size.width * 0.6,
                                        // width: MediaQuery.of(context).size.width,
                                        // height: 40,
                                        decoration: const BoxDecoration(
                                            // shape: BoxShape.circle,
                                            //borderRadius: BorderRadius.circular(25),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Color.fromARGB(
                                                      255, 155, 69, 3),
                                                  blurRadius: 5,
                                                  offset: Offset(2.0, 5.0))
                                            ],
                                            gradient: LinearGradient(
                                              colors: [
                                                Color.fromARGB(
                                                    255, 255, 111, 0),
                                                Color.fromARGB(
                                                    255, 255, 111, 0),
                                              ],
                                            )),
                                        child: const Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            "Add Another EQUIPMENT",
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
                            Container(
                              margin: const EdgeInsets.only(
                                  left: 4, right: 4, top: 10, bottom: 8),
                              padding: const EdgeInsets.all(8),
                              alignment: Alignment.center,
                              // height: size.height * 0.5,
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
                                              color: Color.fromARGB(
                                                  255, 3, 47, 97),
                                              blurRadius: 5,
                                              offset: Offset(2.0, 5.0))
                                        ],
                                        gradient: LinearGradient(
                                          colors: [
                                            AppColors.baseColor,
                                            Color.fromARGB(255, 7, 59, 120)
                                          ],
                                        )),
                                    child: const Row(children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "ACTIVITIES",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                    ]),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: DropdownButtonFormField<String>(
                                          hint: const Text('-Select-'),
                                          dropdownColor: Colors.white,
                                          value: noOfActivities,
                                          style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 7, 59, 120),
                                              fontSize: 16),
                                          icon: const Icon(
                                            Icons.arrow_drop_down,
                                            color:
                                                AppColors.baseColor,
                                            size: 40,
                                          ),
                                          decoration: const InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color.fromARGB(
                                                    255, 7, 59, 120),
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color.fromARGB(
                                                    255, 7, 59, 120),
                                              ),
                                            ),
                                          ),
                                          isExpanded: true,
                                          items: select_noOfActivities
                                              .map(buildMenuItem)
                                              .toList(),
                                          onChanged: (value) {
                                            setState(() {
                                              noOfActivities = value;
                                            });
                                            createActivityList(
                                                int.parse(value.toString()));
                                          },
                                          validator: (value) => value == null
                                              ? 'field required'
                                              : null,
                                        ),
                                      ),
                                    ),
                                  ),
                                  noOfActivities.toString() != '--SELECT--'
                                      ? Container(
                                          margin: const EdgeInsets.only(
                                              left: 8,
                                              right: 8,
                                              top: 8,
                                              bottom: 8),
                                          padding: const EdgeInsets.all(8),
                                          alignment: Alignment.center,
                                          height: size.height * 0.35,
                                          width: size.width * 0.99,
                                          decoration: BoxDecoration(
                                              // shape: BoxShape.circle,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              boxShadow: const [
                                                BoxShadow(
                                                    color: Color.fromARGB(
                                                        255, 7, 59, 120),
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
                                          child: ListView.builder(
                                              itemCount: activity.length,
                                              itemBuilder: (BuildContext ctxt,
                                                  int index) {
                                                // setDataEquipment(index);
                                                return Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 4.0,
                                                              bottom: 4,
                                                              left: 4),
                                                      child: Container(
                                                        width:
                                                            size.width * 0.83,
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8),
                                                        decoration:
                                                            BoxDecoration(
                                                                color: const Color
                                                                    .fromARGB(
                                                                    255,
                                                                    7,
                                                                    59,
                                                                    120),
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
                                                                )),
                                                        child: Column(
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Expanded(
                                                                    child:
                                                                        Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .centerRight,
                                                                      child:
                                                                          Padding(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            2.0),
                                                                        child:
                                                                            TextFormField(
                                                                          //  key: formkey5,
                                                                          controller:
                                                                              activity[index].dayOfWeek,
                                                                          style: const TextStyle(
                                                                              color: Colors.white,
                                                                              fontSize: 12),
                                                                          obscureText:
                                                                              false,
                                                                          // keyboardType: TextInputType.number,
                                                                          decoration: const InputDecoration(
                                                                              border: OutlineInputBorder(
                                                                                  // borderRadius: BorderRadius.circular(25),
                                                                                  ),
                                                                              enabledBorder: OutlineInputBorder(
                                                                                borderSide: BorderSide(
                                                                                  color: Colors.white,
                                                                                ),
                                                                                // borderRadius: BorderRadius.circular(25),
                                                                              ),
                                                                              labelText: 'DAY OF WEEK',
                                                                              labelStyle: TextStyle(color: Colors.white, fontSize: 12)),

                                                                          validator:
                                                                              (value) {
                                                                            if (value!.isEmpty) {
                                                                              return "Please enter day of week";
                                                                            } else {
                                                                              return null;
                                                                            }
                                                                          },
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    child:
                                                                        Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .centerRight,
                                                                      child:
                                                                          Padding(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            2.0),
                                                                        child:
                                                                            TextFormField(
                                                                          //  key: formkey5,
                                                                          controller:
                                                                              activity[index].substationId,
                                                                          style: const TextStyle(
                                                                              color: Colors.white,
                                                                              fontSize: 12),
                                                                          obscureText:
                                                                              false,
                                                                          // keyboardType: TextInputType.number,
                                                                          decoration: const InputDecoration(
                                                                              border: OutlineInputBorder(
                                                                                  // borderRadius: BorderRadius.circular(25),
                                                                                  ),
                                                                              enabledBorder: OutlineInputBorder(
                                                                                borderSide: BorderSide(
                                                                                  color: Colors.white,
                                                                                ),
                                                                                // borderRadius: BorderRadius.circular(25),
                                                                              ),
                                                                              labelText: ' 	SUBSTATION ID',
                                                                              labelStyle: TextStyle(color: Colors.white, fontSize: 12)),

                                                                          validator:
                                                                              (value) {
                                                                            if (value!.isEmpty) {
                                                                              return "Please enter substation id";
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
                                                              const Divider(
                                                                color:
                                                                    Colors.grey,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Expanded(
                                                                    child:
                                                                        Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .centerRight,
                                                                      child:
                                                                          Padding(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            2.0),
                                                                        child:
                                                                            TextFormField(
                                                                          //  key: formkey5,
                                                                          controller:
                                                                              activity[index].feederId,
                                                                          style: const TextStyle(
                                                                              color: Colors.white,
                                                                              fontSize: 12),
                                                                          obscureText:
                                                                              false,

                                                                          decoration: const InputDecoration(
                                                                              border: OutlineInputBorder(
                                                                                  // borderRadius: BorderRadius.circular(25),
                                                                                  ),
                                                                              enabledBorder: OutlineInputBorder(
                                                                                borderSide: BorderSide(
                                                                                  color: Colors.white,
                                                                                ),
                                                                                // borderRadius: BorderRadius.circular(25),
                                                                              ),
                                                                              labelText: 'FEEDER ID',
                                                                              labelStyle: TextStyle(color: Colors.white, fontSize: 12)),
                                                                          onChanged:
                                                                              (value) {
                                                                            // calculateTotalCost(
                                                                            //     index);
                                                                            print('123456');
                                                                          },
                                                                          validator:
                                                                              (value) {
                                                                            if (value!.isEmpty) {
                                                                              return "Please enter feeder id";
                                                                            } else {
                                                                              return null;
                                                                            }
                                                                          },
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    child:
                                                                        Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .centerRight,
                                                                      child:
                                                                          Padding(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            2.0),
                                                                        child:
                                                                            TextFormField(
                                                                          controller:
                                                                              activity[index].workType,
                                                                          style: const TextStyle(
                                                                              color: Colors.white,
                                                                              fontSize: 12),
                                                                          obscureText:
                                                                              false,
                                                                          decoration: const InputDecoration(
                                                                              border: OutlineInputBorder(
                                                                                  // borderRadius: BorderRadius.circular(25),
                                                                                  ),
                                                                              enabledBorder: OutlineInputBorder(
                                                                                borderSide: BorderSide(
                                                                                  color: Colors.white,
                                                                                ),
                                                                                // borderRadius: BorderRadius.circular(25),
                                                                              ),
                                                                              labelText: 'WORK TYPE',
                                                                              labelStyle: TextStyle(color: Colors.white, fontSize: 12)),
                                                                          onChanged:
                                                                              (value) {
                                                                            // calculateTotalCost(
                                                                            //   index,
                                                                            // );
                                                                            print('789999999');
                                                                          },
                                                                          validator:
                                                                              (value) {
                                                                            if (value!.isEmpty) {
                                                                              return "Please enter work type";
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
                                                              const Divider(
                                                                color:
                                                                    Colors.grey,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Expanded(
                                                                    child:
                                                                        Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .centerRight,
                                                                      child:
                                                                          Padding(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            2.0),
                                                                        child:
                                                                            TextFormField(
                                                                          controller:
                                                                              activity[index].accountTwoNumber,
                                                                          style: const TextStyle(
                                                                              color: Colors.white,
                                                                              fontSize: 12),
                                                                          obscureText:
                                                                              false,
                                                                          decoration: const InputDecoration(
                                                                              border: OutlineInputBorder(
                                                                                  // borderRadius: BorderRadius.circular(25),
                                                                                  ),
                                                                              enabledBorder: OutlineInputBorder(
                                                                                borderSide: BorderSide(
                                                                                  color: Colors.white,
                                                                                ),
                                                                                // borderRadius: BorderRadius.circular(25),
                                                                              ),
                                                                              labelText: 'ACCOUNT/WO NUMBER',
                                                                              labelStyle: TextStyle(color: Colors.white, fontSize: 12)),
                                                                          onChanged:
                                                                              (value) {
                                                                            // calculateTotalCost(
                                                                            //   index,
                                                                            // );
                                                                            print('789999999');
                                                                          },
                                                                          validator:
                                                                              (value) {
                                                                            if (value!.isEmpty) {
                                                                              return "Please enter account/wo number";
                                                                            } else {
                                                                              return null;
                                                                            }
                                                                          },
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    child:
                                                                        Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .centerRight,
                                                                      child:
                                                                          Padding(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            2.0),
                                                                        child:
                                                                            TextFormField(
                                                                          controller:
                                                                              activity[index].mapNumber,
                                                                          style: const TextStyle(
                                                                              color: Colors.white,
                                                                              fontSize: 12),
                                                                          obscureText:
                                                                              false,
                                                                          decoration: const InputDecoration(
                                                                              border: OutlineInputBorder(
                                                                                  // borderRadius: BorderRadius.circular(25),
                                                                                  ),
                                                                              enabledBorder: OutlineInputBorder(
                                                                                borderSide: BorderSide(
                                                                                  color: Colors.white,
                                                                                ),
                                                                                // borderRadius: BorderRadius.circular(25),
                                                                              ),
                                                                              labelText: 'MAP NUMBER',
                                                                              labelStyle: TextStyle(color: Colors.white, fontSize: 12)),
                                                                          onChanged:
                                                                              (value) {
                                                                            // calculateTotalCost(
                                                                            //   index,
                                                                            // );
                                                                            print('789999999');
                                                                          },
                                                                          validator:
                                                                              (value) {
                                                                            if (value!.isEmpty) {
                                                                              return "Please enter map number";
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
                                                              const Divider(
                                                                color:
                                                                    Colors.grey,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Expanded(
                                                                    child:
                                                                        Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .centerRight,
                                                                      child:
                                                                          Padding(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            2.0),
                                                                        child:
                                                                            TextFormField(
                                                                          controller:
                                                                              activity[index].sectionAddress,
                                                                          style: const TextStyle(
                                                                              color: Colors.white,
                                                                              fontSize: 12),
                                                                          obscureText:
                                                                              false,
                                                                          decoration: const InputDecoration(
                                                                              border: OutlineInputBorder(
                                                                                  // borderRadius: BorderRadius.circular(25),
                                                                                  ),
                                                                              enabledBorder: OutlineInputBorder(
                                                                                borderSide: BorderSide(
                                                                                  color: Colors.white,
                                                                                ),
                                                                                // borderRadius: BorderRadius.circular(25),
                                                                              ),
                                                                              labelText: 'SECTION ADDRESS',
                                                                              labelStyle: TextStyle(color: Colors.white, fontSize: 12)),
                                                                          onChanged:
                                                                              (value) {
                                                                            // calculateTotalCost(
                                                                            //   index,
                                                                            // );
                                                                            print('789999999');
                                                                          },
                                                                          validator:
                                                                              (value) {
                                                                            if (value!.isEmpty) {
                                                                              return "Please enter section address";
                                                                            } else {
                                                                              return null;
                                                                            }
                                                                          },
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    child:
                                                                        Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .centerRight,
                                                                      child:
                                                                          Padding(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            2.0),
                                                                        child:
                                                                            TextFormField(
                                                                          controller:
                                                                              activity[index].poleNumber,
                                                                          style: const TextStyle(
                                                                              color: Colors.white,
                                                                              fontSize: 12),
                                                                          obscureText:
                                                                              false,
                                                                          decoration: const InputDecoration(
                                                                              border: OutlineInputBorder(
                                                                                  // borderRadius: BorderRadius.circular(25),
                                                                                  ),
                                                                              enabledBorder: OutlineInputBorder(
                                                                                borderSide: BorderSide(
                                                                                  color: Colors.white,
                                                                                ),
                                                                                // borderRadius: BorderRadius.circular(25),
                                                                              ),
                                                                              labelText: 'POLE NUMBER',
                                                                              labelStyle: TextStyle(color: Colors.white, fontSize: 12)),
                                                                          onChanged:
                                                                              (value) {
                                                                            // calculateTotalCost(
                                                                            //   index,
                                                                            // );
                                                                            print('789999999');
                                                                          },
                                                                          validator:
                                                                              (value) {
                                                                            if (value!.isEmpty) {
                                                                              return "Please enter pole number";
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
                                                              const Divider(
                                                                color:
                                                                    Colors.grey,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Expanded(
                                                                    child:
                                                                        Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .centerRight,
                                                                      child:
                                                                          Padding(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            2.0),
                                                                        child:
                                                                            TextFormField(
                                                                          controller:
                                                                              activity[index].noteActivityCode,
                                                                          style: const TextStyle(
                                                                              color: Colors.white,
                                                                              fontSize: 12),
                                                                          obscureText:
                                                                              false,
                                                                          decoration: const InputDecoration(
                                                                              border: OutlineInputBorder(
                                                                                  // borderRadius: BorderRadius.circular(25),
                                                                                  ),
                                                                              enabledBorder: OutlineInputBorder(
                                                                                borderSide: BorderSide(
                                                                                  color: Colors.white,
                                                                                ),
                                                                                // borderRadius: BorderRadius.circular(25),
                                                                              ),
                                                                              labelText: 'NOTES ACTIVITY CODE',
                                                                              labelStyle: TextStyle(color: Colors.white, fontSize: 12)),
                                                                          onChanged:
                                                                              (value) {
                                                                            // calculateTotalCost(
                                                                            //   index,
                                                                            // );
                                                                            print('789999999');
                                                                          },
                                                                          validator:
                                                                              (value) {
                                                                            if (value!.isEmpty) {
                                                                              return "Please enter notes activity code";
                                                                            } else {
                                                                              return null;
                                                                            }
                                                                          },
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    child:
                                                                        Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .centerRight,
                                                                      child:
                                                                          Padding(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            2.0),
                                                                        child:
                                                                            TextFormField(
                                                                          controller:
                                                                              activity[index].manHour,
                                                                          style: const TextStyle(
                                                                              color: Colors.white,
                                                                              fontSize: 12),
                                                                          obscureText:
                                                                              false,
                                                                          decoration: const InputDecoration(
                                                                              border: OutlineInputBorder(
                                                                                  // borderRadius: BorderRadius.circular(25),
                                                                                  ),
                                                                              enabledBorder: OutlineInputBorder(
                                                                                borderSide: BorderSide(
                                                                                  color: Colors.white,
                                                                                ),
                                                                                // borderRadius: BorderRadius.circular(25),
                                                                              ),
                                                                              labelText: 'MAN HOURS',
                                                                              labelStyle: TextStyle(color: Colors.white, fontSize: 12)),
                                                                          onChanged:
                                                                              (value) {
                                                                            // calculateTotalCost(
                                                                            //   index,
                                                                            // );
                                                                            print('789999999');
                                                                          },
                                                                          validator:
                                                                              (value) {
                                                                            if (value!.isEmpty) {
                                                                              return "Please enter man hours";
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
                                                              const Divider(
                                                                color:
                                                                    Colors.grey,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Expanded(
                                                                    child:
                                                                        Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .centerRight,
                                                                      child:
                                                                          Padding(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            2.0),
                                                                        child:
                                                                            TextFormField(
                                                                          controller:
                                                                              activity[index].spans,
                                                                          style: const TextStyle(
                                                                              color: Colors.white,
                                                                              fontSize: 12),
                                                                          obscureText:
                                                                              false,
                                                                          decoration: const InputDecoration(
                                                                              border: OutlineInputBorder(
                                                                                  // borderRadius: BorderRadius.circular(25),
                                                                                  ),
                                                                              enabledBorder: OutlineInputBorder(
                                                                                borderSide: BorderSide(
                                                                                  color: Colors.white,
                                                                                ),
                                                                                // borderRadius: BorderRadius.circular(25),
                                                                              ),
                                                                              labelText: 'SPANS',
                                                                              labelStyle: TextStyle(color: Colors.white, fontSize: 12)),
                                                                          onChanged:
                                                                              (value) {
                                                                            // calculateTotalCost(
                                                                            //   index,
                                                                            // );
                                                                            print('789999999');
                                                                          },
                                                                          validator:
                                                                              (value) {
                                                                            if (value!.isEmpty) {
                                                                              return "Please enter spans";
                                                                            } else {
                                                                              return null;
                                                                            }
                                                                          },
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    child:
                                                                        Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .centerRight,
                                                                      child:
                                                                          Padding(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            2.0),
                                                                        child:
                                                                            TextFormField(
                                                                          controller:
                                                                              activity[index].length,
                                                                          style: const TextStyle(
                                                                              color: Colors.white,
                                                                              fontSize: 12),
                                                                          obscureText:
                                                                              false,
                                                                          decoration: const InputDecoration(
                                                                              border: OutlineInputBorder(
                                                                                  // borderRadius: BorderRadius.circular(25),
                                                                                  ),
                                                                              enabledBorder: OutlineInputBorder(
                                                                                borderSide: BorderSide(
                                                                                  color: Colors.white,
                                                                                ),
                                                                                // borderRadius: BorderRadius.circular(25),
                                                                              ),
                                                                              labelText: 'LENGTH',
                                                                              labelStyle: TextStyle(color: Colors.white, fontSize: 12)),
                                                                          onChanged:
                                                                              (value) {
                                                                            // calculateTotalCost(
                                                                            //   index,
                                                                            // );
                                                                            print('789999999');
                                                                          },
                                                                          validator:
                                                                              (value) {
                                                                            if (value!.isEmpty) {
                                                                              return "Please enter length";
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
                                                              const Divider(
                                                                color:
                                                                    Colors.grey,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Expanded(
                                                                    child:
                                                                        Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .centerRight,
                                                                      child:
                                                                          Padding(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            2.0),
                                                                        child:
                                                                            TextFormField(
                                                                          controller:
                                                                              activity[index].width,
                                                                          style: const TextStyle(
                                                                              color: Colors.white,
                                                                              fontSize: 12),
                                                                          obscureText:
                                                                              false,
                                                                          decoration: const InputDecoration(
                                                                              border: OutlineInputBorder(
                                                                                  // borderRadius: BorderRadius.circular(25),
                                                                                  ),
                                                                              enabledBorder: OutlineInputBorder(
                                                                                borderSide: BorderSide(
                                                                                  color: Colors.white,
                                                                                ),
                                                                                // borderRadius: BorderRadius.circular(25),
                                                                              ),
                                                                              labelText: 'WIDTH',
                                                                              labelStyle: TextStyle(color: Colors.white, fontSize: 12)),
                                                                          onChanged:
                                                                              (value) {
                                                                            // calculateTotalCost(
                                                                            //   index,
                                                                            // );
                                                                            print('789999999');
                                                                          },
                                                                          validator:
                                                                              (value) {
                                                                            if (value!.isEmpty) {
                                                                              return "Please enter width";
                                                                            } else {
                                                                              return null;
                                                                            }
                                                                          },
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    child:
                                                                        Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .centerRight,
                                                                      child:
                                                                          Padding(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            2.0),
                                                                        child:
                                                                            TextFormField(
                                                                          controller:
                                                                              activity[index].chemicalCode,
                                                                          style: const TextStyle(
                                                                              color: Colors.white,
                                                                              fontSize: 12),
                                                                          obscureText:
                                                                              false,
                                                                          decoration: const InputDecoration(
                                                                              border: OutlineInputBorder(
                                                                                  // borderRadius: BorderRadius.circular(25),
                                                                                  ),
                                                                              enabledBorder: OutlineInputBorder(
                                                                                borderSide: BorderSide(
                                                                                  color: Colors.white,
                                                                                ),
                                                                                // borderRadius: BorderRadius.circular(25),
                                                                              ),
                                                                              labelText: 'CHEMICAL CODE',
                                                                              labelStyle: TextStyle(color: Colors.white, fontSize: 12)),
                                                                          onChanged:
                                                                              (value) {
                                                                            // calculateTotalCost(
                                                                            //   index,
                                                                            // );
                                                                            print('789999999');
                                                                          },
                                                                          validator:
                                                                              (value) {
                                                                            if (value!.isEmpty) {
                                                                              return "Please enter chemical code";
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
                                                              const Divider(
                                                                color:
                                                                    Colors.grey,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Expanded(
                                                                    child:
                                                                        Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .centerRight,
                                                                      child:
                                                                          Padding(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            2.0),
                                                                        child:
                                                                            TextFormField(
                                                                          controller:
                                                                              activity[index].chemicalQuantity,
                                                                          style: const TextStyle(
                                                                              color: Colors.white,
                                                                              fontSize: 12),
                                                                          obscureText:
                                                                              false,
                                                                          decoration: const InputDecoration(
                                                                              border: OutlineInputBorder(
                                                                                  // borderRadius: BorderRadius.circular(25),
                                                                                  ),
                                                                              enabledBorder: OutlineInputBorder(
                                                                                borderSide: BorderSide(
                                                                                  color: Colors.white,
                                                                                ),
                                                                                // borderRadius: BorderRadius.circular(25),
                                                                              ),
                                                                              labelText: 'CHEMICAL QUANTITY',
                                                                              labelStyle: TextStyle(color: Colors.white, fontSize: 12)),
                                                                          onChanged:
                                                                              (value) {
                                                                            // calculateTotalCost(
                                                                            //   index,
                                                                            // );
                                                                            print('789999999');
                                                                          },
                                                                          validator:
                                                                              (value) {
                                                                            if (value!.isEmpty) {
                                                                              return "Please enter chemical quantity";
                                                                            } else {
                                                                              return null;
                                                                            }
                                                                          },
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    child:
                                                                        Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .centerRight,
                                                                      child: Padding(
                                                                          padding: const EdgeInsets.all(2.0),
                                                                          child: InkWell(
                                                                            onTap:
                                                                                () {
                                                                              setState(() {
                                                                                activity.removeAt(index);
                                                                                noOfActivities = cardLength(noOfActivities.toString());
                                                                                // noOfHerbicide = (int.parse(noOfHerbicide.toString()) - 1).toString();
                                                                              });
                                                                            },
                                                                            child:
                                                                                const Icon(Icons.delete, color: Colors.white),
                                                                          )),
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
                                        )
                                      : const Text(
                                          "",
                                          style: TextStyle(
                                            fontSize: 0.0,
                                            color: Colors.white,
                                          ),
                                        ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: InkWell(
                                      onTap: () {
                                        print('Add another herbicide');
                                        (noOfActivities != '10' &&
                                                noOfActivities != '--SELECT--')
                                            ? setState(() {
                                                noOfActivities = (int.parse(
                                                            noOfActivities
                                                                .toString()) +
                                                        1)
                                                    .toString();
                                              })
                                            : (noOfActivities == '--SELECT--')
                                                ? setState(() {
                                                    noOfActivities = '1';
                                                  })
                                                : CustomToastSnackBarProgressDialog
                                                    .snackBar(
                                                        'Maximum Limit of Activity is 10',
                                                        context);
                                        activity.add(ActivityClass(
                                            TextEditingController(),
                                            TextEditingController(),
                                            TextEditingController(),
                                            TextEditingController(),
                                            TextEditingController(),
                                            TextEditingController(),
                                            TextEditingController(),
                                            TextEditingController(),
                                            TextEditingController(),
                                            TextEditingController(),
                                            TextEditingController(),
                                            TextEditingController(),
                                            TextEditingController(),
                                            TextEditingController(),
                                            TextEditingController()));
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(10),
                                        alignment: Alignment.center,
                                        // width: size.width * 0.6,
                                        // width: MediaQuery.of(context).size.width,
                                        // height: 40,
                                        decoration: const BoxDecoration(
                                            // shape: BoxShape.circle,
                                            //borderRadius: BorderRadius.circular(25),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Color.fromARGB(
                                                      255, 155, 69, 3),
                                                  blurRadius: 5,
                                                  offset: Offset(2.0, 5.0))
                                            ],
                                            gradient: LinearGradient(
                                              colors: [
                                                Color.fromARGB(
                                                    255, 255, 111, 0),
                                                Color.fromARGB(
                                                    255, 255, 111, 0),
                                              ],
                                            )),
                                        child: const Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            "Add Another ACTIVITY",
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
                            Container(
                              margin: const EdgeInsets.only(
                                  left: 4, right: 4, top: 10, bottom: 8),
                              padding: const EdgeInsets.all(8),
                              alignment: Alignment.center,
                              // height: size.height * 0.5,
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
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    const Align(
                                        alignment: Alignment.centerLeft,
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              left: 2.0,
                                              right: 2.0,
                                              bottom: 2.0,
                                              top: 8.0),
                                          child: Text(
                                            "REMARKS",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Color.fromARGB(
                                                    255, 7, 59, 120),
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: TextFormField(
                                          // enabled: false,
                                          //  key: formkey5,
                                          controller: _remarks,
                                          style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 7, 59, 120),
                                              fontSize: 16),
                                          obscureText: false,
                                          // keyboardType: TextInputType.number,
                                          decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color.fromARGB(
                                                    255, 7, 59, 120),
                                              ),
                                            ),
                                            hintText: 'remarks',
                                          ),
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "Please enter remarks";
                                            } else {
                                              return null;
                                            }
                                          },
                                        ),
                                      ),
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
                                            "FOREMAN DIGITAL SIGNATURE",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Color.fromARGB(
                                                    255, 7, 59, 120),
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: TextFormField(
                                          // enabled: false,
                                          //  key: formkey5,
                                          controller: _foremanDigitalSignature,
                                          style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 7, 59, 120),
                                              fontSize: 16),
                                          obscureText: false,
                                          // keyboardType: TextInputType.number,
                                          decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color.fromARGB(
                                                    255, 7, 59, 120),
                                              ),
                                            ),
                                            hintText:
                                                'forman digital signature',
                                          ),
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "Please enter foreman digital signature";
                                            } else {
                                              return null;
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                   Visibility(
                              visible: _isVisibleSubmitButton,
                                      child: Container(
                                          margin: const EdgeInsets.only(
                                              left: 6,
                                              right: 6,
                                              top: 20.0,
                                              bottom: 10),
                                          child: InkWell(
                                            onTap: () {
                                              if (_formkey.currentState!
                                                  .validate()) {
                                                     setState(() {
                                          _isVisibleSubmitButton = false;
                                          _isVisibleSubmittingButton = true;
                                        });
                                                submitDataMainTopData();
                                              } else {
                                                print(
                                                    "Please fill all mendetory fields!!!");
                                              }
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
                                                        color: Color.fromARGB(
                                                            255, 3, 47, 97),
                                                        blurRadius: 5,
                                                        offset: Offset(2.0, 5.0))
                                                  ],
                                                  gradient: LinearGradient(
                                                    colors: [
                                                      Color.fromARGB(
                                                          255, 7, 59, 120),
                                                      Color.fromARGB(
                                                          255, 7, 59, 120)
                                                    ],
                                                  )),
                                              child: const Row(children: [
                                                Expanded(
                                                  child: Align(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      "SUBMIT",
                                                      textAlign: TextAlign.left,
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
                                    ),
                                 Visibility(
                                    visible: _isVisibleSubmittingButton,
                                    child: Container(
                                        margin: const EdgeInsets.only(
                                            left: 6,
                                            right: 6,
                                            top: 10.0,
                                            bottom: 10),
                                        child: Container(
                                          margin: const EdgeInsets.only(
                                              left: 40,
                                              right: 40,
                                              bottom: 10.0),
                                          // padding: const EdgeInsets.all(8),
                                          alignment: Alignment.center,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 40,
                                          decoration: const BoxDecoration(
                                              // borderRadius:
                                              //     BorderRadius.circular(10),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Color.fromARGB(
                                                        255, 3, 47, 97),
                                                    blurRadius: 5,
                                                    offset: Offset(2.0, 5.0))
                                              ],
                                              gradient: LinearGradient(
                                                colors: [
                                                  Color.fromARGB(
                                                      255, 7, 59, 120),
                                                  Color.fromARGB(
                                                      255, 7, 59, 120)
                                                ],
                                              )),
                                          child: const Row(children: [
                                            Expanded(
                                              child: Align(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  "SUBMITTING...",
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
                                        )),
                                  ),
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
            })));
  }

  setData(IvmTimeSheetViewModel value) {
    _changeOrderNo.text = widget.id;
    if (ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!
                .getLAKECOUNTRYPOWERTIMEREPORTDataList !=
            null &&
        ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!
            .getLAKECOUNTRYPOWERTIMEREPORTDataList!.isNotEmpty) {
      print('if case');
      print(ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!
              .getLAKECOUNTRYPOWERTIMEREPORTDataList![0].personnelType
              .toString());
                 print(ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!
              .getLAKECOUNTRYPOWERTIMEREPORTDataList![0].personnelName
              .toString());

      _changeOrderNo.text = (ivmTimeSheetViewModel
                      .ivmTimeSheetGetTabularData
                      .data!
                      .getLAKECOUNTRYPOWERTIMEREPORTDataList![0]
                      .workOrderNo ==
                  null ||
              ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!
                      .getLAKECOUNTRYPOWERTIMEREPORTDataList![0].workOrderNo
                      .toString() ==
                  'null')
          ? ''
          : ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!
              .getLAKECOUNTRYPOWERTIMEREPORTDataList![0].workOrderNo
              .toString();

      dateSelected1 = (ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!
                      .getLAKECOUNTRYPOWERTIMEREPORTDataList![0].date ==
                  null ||
              ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!
                      .getLAKECOUNTRYPOWERTIMEREPORTDataList![0].date
                      .toString() ==
                  'null')
          ? ''
          : ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!
              .getLAKECOUNTRYPOWERTIMEREPORTDataList![0].date
              .toString();
          
//  : DateFormat('MM-dd-yyyy').format(
//                   DateTime.parse(ivmTimeSheetViewModel
//                       .ivmTimeSheetGetTabularData.data!
//                       .getLAKECOUNTRYPOWERTIMEREPORTDataList![0]
//                       .date
//                       .toString()),
//                 );

      _contractor.text = (ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!
                      .getLAKECOUNTRYPOWERTIMEREPORTDataList![0].contractor ==
                  null ||
              ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!
                      .getLAKECOUNTRYPOWERTIMEREPORTDataList![0].contractor
                      .toString() ==
                  'null')
          ? ''
          : ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!
              .getLAKECOUNTRYPOWERTIMEREPORTDataList![0].contractor
              .toString();

      _crewNumber.text = (ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!
                      .getLAKECOUNTRYPOWERTIMEREPORTDataList![0].crewMember ==
                  null ||
              ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!
                      .getLAKECOUNTRYPOWERTIMEREPORTDataList![0].crewMember
                      .toString() ==
                  'null')
          ? ''
          : ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!
              .getLAKECOUNTRYPOWERTIMEREPORTDataList![0].crewMember
              .toString();

      _jobNumber.text = (ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!
                      .getLAKECOUNTRYPOWERTIMEREPORTDataList![0].jobNo ==
                  null ||
              ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!
                      .getLAKECOUNTRYPOWERTIMEREPORTDataList![0].jobNo
                      .toString() ==
                  'null')
          ? ''
          : ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!
              .getLAKECOUNTRYPOWERTIMEREPORTDataList![0].jobNo
              .toString();

      dateSelected2 = (ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!
                      .getLAKECOUNTRYPOWERTIMEREPORTDataList![0].weekendDate ==
                  null ||
              ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!
                      .getLAKECOUNTRYPOWERTIMEREPORTDataList![0].weekendDate
                      .toString() ==
                  'null')
          ? ''
          : ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!
              .getLAKECOUNTRYPOWERTIMEREPORTDataList![0].weekendDate
              .toString();
        // :  DateFormat('MM-dd-yyyy').format(
        //           DateTime.parse(ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!
        //       .getLAKECOUNTRYPOWERTIMEREPORTDataList![0].weekendDate
        //       .toString()),
        //         );

      _generalForeman.text = (ivmTimeSheetViewModel
                      .ivmTimeSheetGetTabularData
                      .data!
                      .getLAKECOUNTRYPOWERTIMEREPORTDataList![0]
                      .generalforeMan ==
                  null ||
              ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!
                      .getLAKECOUNTRYPOWERTIMEREPORTDataList![0].generalforeMan
                      .toString() ==
                  'null')
          ? ''
          : ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!
              .getLAKECOUNTRYPOWERTIMEREPORTDataList![0].generalforeMan
              .toString();

      _foreman.text = (ivmTimeSheetViewModel
                      .ivmTimeSheetGetTabularData
                      .data!
                      .getLAKECOUNTRYPOWERTIMEREPORTDataList![0]
                      .foreManDigitalSignature ==
                  null ||
              ivmTimeSheetViewModel
                      .ivmTimeSheetGetTabularData
                      .data!
                      .getLAKECOUNTRYPOWERTIMEREPORTDataList![0]
                      .foreManDigitalSignature
                      .toString() ==
                  'null')
          ? ''
          : ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!
              .getLAKECOUNTRYPOWERTIMEREPORTDataList![0].foreManDigitalSignature
              .toString();

      _contractorTwo.text = (ivmTimeSheetViewModel
                      .ivmTimeSheetGetTabularData
                      .data!
                      .getLAKECOUNTRYPOWERTIMEREPORTDataList![0]
                      .contractor ==
                  null ||
              ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!
                      .getLAKECOUNTRYPOWERTIMEREPORTDataList![0].contractor
                      .toString() ==
                  'null')
          ? ''
          : ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!
              .getLAKECOUNTRYPOWERTIMEREPORTDataList![0].contractor
              .toString();

      _pesticide.text = (ivmTimeSheetViewModel
                      .ivmTimeSheetGetTabularData
                      .data!
                      .getLAKECOUNTRYPOWERTIMEREPORTDataList![0]
                      .pesticiedLicNo ==
                  null ||
              ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!
                      .getLAKECOUNTRYPOWERTIMEREPORTDataList![0].pesticiedLicNo
                      .toString() ==
                  'null')
          ? ''
          : ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!
              .getLAKECOUNTRYPOWERTIMEREPORTDataList![0].pesticiedLicNo
              .toString();

      _foremanTwo.text = (ivmTimeSheetViewModel
                      .ivmTimeSheetGetTabularData
                      .data!
                      .getLAKECOUNTRYPOWERTIMEREPORTDataList![0]
                      .foreManDigitalSign ==
                  null ||
              ivmTimeSheetViewModel
                      .ivmTimeSheetGetTabularData
                      .data!
                      .getLAKECOUNTRYPOWERTIMEREPORTDataList![0]
                      .foreManDigitalSign
                      .toString() ==
                  'null')
          ? ''
          : ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!
              .getLAKECOUNTRYPOWERTIMEREPORTDataList![0].foreManDigitalSign
              .toString();

      _remarks.text = (ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!
                      .getLAKECOUNTRYPOWERTIMEREPORTDataList![0].remarks ==
                  null ||
              ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!
                      .getLAKECOUNTRYPOWERTIMEREPORTDataList![0].remarks
                      .toString() ==
                  'null')
          ? ''
          : ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!
              .getLAKECOUNTRYPOWERTIMEREPORTDataList![0].remarks
              .toString();

      _foremanDigitalSignature.text = (ivmTimeSheetViewModel
                      .ivmTimeSheetGetTabularData
                      .data!
                      .getLAKECOUNTRYPOWERTIMEREPORTDataList![0]
                      .foreManDigitalSignature ==
                  null ||
              ivmTimeSheetViewModel
                      .ivmTimeSheetGetTabularData
                      .data!
                      .getLAKECOUNTRYPOWERTIMEREPORTDataList![0]
                      .foreManDigitalSignature
                      .toString() ==
                  'null')
          ? ''
          : ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!
              .getLAKECOUNTRYPOWERTIMEREPORTDataList![0].foreManDigitalSignature
              .toString();

      selectPersonnelName = (ivmTimeSheetViewModel
                      .ivmTimeSheetGetTabularData
                      .data!
                      .getLAKECOUNTRYPOWERTIMEREPORTDataList![0]
                      .personnelName ==
                  null ||
              ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!
                      .getLAKECOUNTRYPOWERTIMEREPORTDataList![0].personnelName
                      .toString() ==
                  'null'||ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!
                      .getLAKECOUNTRYPOWERTIMEREPORTDataList![0].personnelName
                      .toString() ==
                  '0')
          ? null
          : ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!
              .getLAKECOUNTRYPOWERTIMEREPORTDataList![0].personnelName
              .toString();
      personnelType = (ivmTimeSheetViewModel
                      .ivmTimeSheetGetTabularData
                      .data!
                      .getLAKECOUNTRYPOWERTIMEREPORTDataList![0]
                      .personnelType ==
                  null ||
              ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!
                      .getLAKECOUNTRYPOWERTIMEREPORTDataList![0].personnelType
                      .toString() ==
                  'null' ||ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!
                      .getLAKECOUNTRYPOWERTIMEREPORTDataList![0].personnelType
                      .toString() ==
                      '0')
          ? null
          : ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!
              .getLAKECOUNTRYPOWERTIMEREPORTDataList![0].personnelType
              .toString();

      _value.text = (ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!
                      .getLAKECOUNTRYPOWERTIMEREPORTDataList![0].ratesValue ==
                  null ||
              ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!
                      .getLAKECOUNTRYPOWERTIMEREPORTDataList![0].ratesValue
                      .toString() ==
                  'null')
          ? ''
          : ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!
              .getLAKECOUNTRYPOWERTIMEREPORTDataList![0].ratesValue
              .toString();

      _estimatedValue.text = (ivmTimeSheetViewModel
                      .ivmTimeSheetGetTabularData
                      .data!
                      .getLAKECOUNTRYPOWERTIMEREPORTDataList![0]
                      .estimatedValue ==
                  null ||
              ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!
                      .getLAKECOUNTRYPOWERTIMEREPORTDataList![0].estimatedValue
                      .toString() ==
                  'null')
          ? ''
          : ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!
              .getLAKECOUNTRYPOWERTIMEREPORTDataList![0].estimatedValue
              .toString();
    }
    print('else case');
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
      value: item,
      child: Text(item,
          style: const TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 20,
          )));

  void createEmployeesList(int noOfResoureces) {
    employee.clear();
    if (noOfResoureces != '--SELECT--') {
      for (int i = 0; i < noOfResoureces; i++) {
        employee.add(EmployeeClass.createWithAdditionalData());
      }
    }
    print(employee.length);
  }

  void createEquipmentList(int noOfResoureces) {
    equipment.clear();
    if (noOfResoureces != '--SELECT--') {
      for (int i = 0; i < noOfResoureces; i++) {
        equipment.add(EquipmentClass.createWithAdditionalData());
      }
    }
    print(equipment.length);
  }

  createActivityList(int noOfResoureces) {
    activity.clear();
    if (noOfResoureces != '--SELECT--') {
      for (int i = 0; i < noOfResoureces; i++) {
        activity.add(ActivityClass(
            TextEditingController(),
            TextEditingController(),
            TextEditingController(),
            TextEditingController(),
            TextEditingController(),
            TextEditingController(),
            TextEditingController(),
            TextEditingController(),
            TextEditingController(),
            TextEditingController(),
            TextEditingController(),
            TextEditingController(),
            TextEditingController(),
            TextEditingController(),
            TextEditingController()));
      }
    }
  }

  cardLength(String cardNo) {
    if (cardNo == '--SELECT--') {
      return '--SELECT--';
    } else if (cardNo == '1') {
      return '--SELECT--';
    } else if (cardNo == '2') {
      return '1';
    } else if (cardNo == '3') {
      return '2';
    } else if (cardNo == '4') {
      return '3';
    } else if (cardNo == '5') {
      return '4';
    } else if (cardNo == '6') {
      return '5';
    } else if (cardNo == '7') {
      return '6';
    } else if (cardNo == '8') {
      return '7';
    } else if (cardNo == '9') {
      return '8';
    } else if (cardNo == '10') {
      return '9';
    }
  }

  setDataEmployeeNew(IvmTimeSheetViewModel value) {
    employee.clear();
    if (ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!
            .getPOWERTIMEREPORTEMPLOYEESDataList !=
        null) {
      for (int i = 0;
          i <
              ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!
                  .getPOWERTIMEREPORTEMPLOYEESDataList!.length;
          i++) {
        String employeeName = ivmTimeSheetViewModel.ivmTimeSheetGetTabularData
            .data!.getPOWERTIMEREPORTEMPLOYEESDataList![i].empName
            .toString();
        String employeeNo = ivmTimeSheetViewModel.ivmTimeSheetGetTabularData
            .data!.getPOWERTIMEREPORTEMPLOYEESDataList![i].empNo
            .toString();
        String otherCrew = ivmTimeSheetViewModel.ivmTimeSheetGetTabularData
            .data!.getPOWERTIMEREPORTEMPLOYEESDataList![i].otherCew
            .toString();
        String classCode = ivmTimeSheetViewModel.ivmTimeSheetGetTabularData
            .data!.getPOWERTIMEREPORTEMPLOYEESDataList![i].classCode
            .toString();

        noOfEmployees = (ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!
                .getPOWERTIMEREPORTEMPLOYEESDataList!.isEmpty)
            ? '--SELECT--'
            : ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!
                .getPOWERTIMEREPORTEMPLOYEESDataList!.length
                .toString();
        print('employee.length');
        print(employee.length);
        List<EmployeeAdditionalData> employeeSub = [];
        String day = '';
        String hours = '';
        String morningIn = '';
        String morningOut = '';
        String afterNoonIn = '';
        String afterNoonOut = '';

        ivmTimeSheetViewModel
            .ivmTimeSheetGetTabularData
            .data!
            .getPOWERTIMEREPORTEMPLOYEESDataList![i]
            .getEMPWORKINGDATAByEmpNumberAndEmpNameAndClassCodeAndotherCewDataList!
            .forEach((a) {
          // for (int j = 0;
          //     j <
          //         ivmTimeSheetViewModel
          //             .ivmTimeSheetGetTabularData
          //             .data!
          //             .getPOWERTIMEREPORTEMPLOYEESDataList![i]
          //             .getEMPWORKINGDATAByEmpNumberAndEmpNameAndClassCodeAndotherCewDataList!
          //             .length;
          //     j++) {
          if (a.day == 'Sunday' || a.day == 'SUNDAY') {
            print('Sunday');
            day = a.day.toString();
            hours = a.hours.toString();
            morningIn = a.mIn.toString();
            morningOut = a.mOut.toString();
            afterNoonIn = a.eIn.toString();
            afterNoonOut = a.eOut.toString();
          }
          if (a.day == 'Monday' || a.day == 'MONDAY') {
            print('Monday');
            day = a.day.toString();
            hours = a.hours.toString();
            morningIn = a.mIn.toString();
            morningOut = a.mOut.toString();
            afterNoonIn = a.eIn.toString();
            afterNoonOut = a.eOut.toString();
          }
          if (a.day == 'Tuesday' || a.day == 'TUESDAY') {
            print('Monday');
            day = a.day.toString();
            hours = a.hours.toString();
            morningIn = a.mIn.toString();
            morningOut = a.mOut.toString();
            afterNoonIn = a.eIn.toString();
            afterNoonOut = a.eOut.toString();
          }
          if (a.day == 'Wednesday' || a.day == 'WEDNESDAY') {
            print('Monday');
            day = a.day.toString();
            hours = a.hours.toString();
            morningIn = a.mIn.toString();
            morningOut = a.mOut.toString();
            afterNoonIn = a.eIn.toString();
            afterNoonOut = a.eOut.toString();
          }
          if (a.day == 'Thursday' || a.day == 'THURSDAY') {
            print('Monday');
            day = a.day.toString();
            hours = a.hours.toString();
            morningIn = a.mIn.toString();
            morningOut = a.mOut.toString();
            afterNoonIn = a.eIn.toString();
            afterNoonOut = a.eOut.toString();
          }
          if (a.day == 'Friday' || a.day == 'FRIDAY') {
            print('Monday');
            day = a.day.toString();
            hours = a.hours.toString();
            morningIn = a.mIn.toString();
            morningOut = a.mOut.toString();
            afterNoonIn = a.eIn.toString();
            afterNoonOut = a.eOut.toString();
          }
          if (a.day == 'Saturday' || a.day == 'SATURDAY') {
            day = a.day.toString();
            hours = a.hours.toString();
            morningIn = a.mIn.toString();
            morningOut = a.mOut.toString();
            afterNoonIn = a.eIn.toString();
            afterNoonOut = a.eOut.toString();
          }
          employeeSub.add(EmployeeAdditionalData(
              TextEditingController(text: day),
              TextEditingController(text: hours),
              TextEditingController(text: morningIn),
              TextEditingController(text: morningOut),
              TextEditingController(text: afterNoonIn),
              TextEditingController(text: afterNoonOut)));

          // }
        });

        employee.add(EmployeeClass(
            TextEditingController(text: employeeNo),
            TextEditingController(text: employeeName),
            TextEditingController(text: otherCrew),
            TextEditingController(text: classCode),
            employeeSub));
      }
    }
  }

  setDataEquipmentNew(IvmTimeSheetViewModel value) {
    equipment.clear();
    if (ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!
            .getPOWERTIMEREPORTEQUIPMENTSDataList !=
        null) {
      for (int i = 0;
          i <
              ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!
                  .getPOWERTIMEREPORTEQUIPMENTSDataList!.length;
          i++) {
        String equipmentType =
            // 'null';
            ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!
                .getPOWERTIMEREPORTEQUIPMENTSDataList![i].equipmentType
                .toString();
        String equipmentNo = ivmTimeSheetViewModel.ivmTimeSheetGetTabularData
            .data!.getPOWERTIMEREPORTEQUIPMENTSDataList![i].equipmentNo
            .toString();
        String otherCrew = ivmTimeSheetViewModel.ivmTimeSheetGetTabularData
            .data!.getPOWERTIMEREPORTEQUIPMENTSDataList![i].otherEquipment
            .toString();
        String classCode = ivmTimeSheetViewModel.ivmTimeSheetGetTabularData
            .data!.getPOWERTIMEREPORTEQUIPMENTSDataList![i].code
            .toString();
        String rates = ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!
            .getPOWERTIMEREPORTEQUIPMENTSDataList![i].equipmentsRatesValue
            .toString();

        noOfEquipment = (ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!
                .getPOWERTIMEREPORTEQUIPMENTSDataList!.isEmpty)
            ? '--SELECT--'
            : ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!
                .getPOWERTIMEREPORTEQUIPMENTSDataList!.length
                .toString();
        print('equipment.length');
        print(equipment.length);
        List<EquipmentAditionalData> equipmentSub = [];
        String day = '';
        String hours = '';

        ivmTimeSheetViewModel
            .ivmTimeSheetGetTabularData
            .data!
            .getPOWERTIMEREPORTEQUIPMENTSDataList![i]
            .getSubPOWERTIMEREPORTEQUIPMENTSOfDayHrsList!
            .forEach((a) {
          if (a.day == 'Sunday' || a.day == 'SUNDAY') {
            day = a.day.toString();
            hours = a.hours.toString();
          }
          if (a.day == 'Monday' || a.day == 'MONDAY') {
            day = a.day.toString();
            hours = a.hours.toString();
          }
          if (a.day == 'Tuesday' || a.day == 'TUESDAY') {
            day = a.day.toString();
            hours = a.hours.toString();
          }
          if (a.day == 'Wednesday' || a.day == 'WEDNESDAY') {
            day = a.day.toString();
            hours = a.hours.toString();
          }
          if (a.day == 'Thursday' || a.day == 'THURSDAY') {
            day = a.day.toString();
            hours = a.hours.toString();
          }
          if (a.day == 'Friday' || a.day == 'FRIDAY') {
            day = a.day.toString();
            hours = a.hours.toString();
          }
          if (a.day == 'Saturday' || a.day == 'SATURDAY') {
            day = a.day.toString();
            hours = a.hours.toString();
          }
          equipmentSub.add(EquipmentAditionalData(
              TextEditingController(text: day),
              TextEditingController(text: hours)));

          // }
        });
        print('equipmentType $equipmentType');
        equipment.add(EquipmentClass(
            equipmentType,
            // TextEditingController(text: equipmentType),
            TextEditingController(text: equipmentNo),
            TextEditingController(text: otherCrew),
            TextEditingController(text: classCode),
            ///////////new added////////////////
            TextEditingController(text: rates),
            /////////////////////////////
            equipmentSub));
      }
    }
  }

  setDataActivityNew(IvmTimeSheetViewModel value) {
    activity.clear();
    if (ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!
            .getLCPTIMEREPORTACTIVITIESDataList !=
        null) {
      for (int i = 0;
          i <
              ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!
                  .getLCPTIMEREPORTACTIVITIESDataList!.length;
          i++) {
        noOfActivities = (ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!
                .getLCPTIMEREPORTACTIVITIESDataList!.isEmpty)
            ? '--SELECT--'
            : ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!
                .getLCPTIMEREPORTACTIVITIESDataList!.length
                .toString();
        String dayOfWeek = ivmTimeSheetViewModel.ivmTimeSheetGetTabularData
            .data!.getLCPTIMEREPORTACTIVITIESDataList![i].dayOfWeek
            .toString();
        String substationId = ivmTimeSheetViewModel.ivmTimeSheetGetTabularData
            .data!.getLCPTIMEREPORTACTIVITIESDataList![i].substationId
            .toString();
        String feederId = ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!
            .getLCPTIMEREPORTACTIVITIESDataList![i].feederId
            .toString();

        String workType = ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!
            .getLCPTIMEREPORTACTIVITIESDataList![i].workType
            .toString();
        String accountTwoNumber = ivmTimeSheetViewModel
            .ivmTimeSheetGetTabularData
            .data!
            .getLCPTIMEREPORTACTIVITIESDataList![i]
            .accountNo
            .toString();
        String mapNo = ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!
            .getLCPTIMEREPORTACTIVITIESDataList![i].mapNumber
            .toString();

        String sectionAddress = ivmTimeSheetViewModel.ivmTimeSheetGetTabularData
            .data!.getLCPTIMEREPORTACTIVITIESDataList![i].sectionAddress
            .toString();

        String poleNumber = ivmTimeSheetViewModel.ivmTimeSheetGetTabularData
            .data!.getLCPTIMEREPORTACTIVITIESDataList![i].poleNumber
            .toString();
        String noteOfActivities = ivmTimeSheetViewModel
            .ivmTimeSheetGetTabularData
            .data!
            .getLCPTIMEREPORTACTIVITIESDataList![i]
            .notesActivityCode
            .toString();
        String manHour = ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!
            .getLCPTIMEREPORTACTIVITIESDataList![i].manHours
            .toString();

        String spans = ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!
            .getLCPTIMEREPORTACTIVITIESDataList![i].spans
            .toString();

        String length = ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!
            .getLCPTIMEREPORTACTIVITIESDataList![i].lengths
            .toString();

        String width = ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!
            .getLCPTIMEREPORTACTIVITIESDataList![i].widths
            .toString();
        String chemicalCode = ivmTimeSheetViewModel.ivmTimeSheetGetTabularData
            .data!.getLCPTIMEREPORTACTIVITIESDataList![i].chemicalCode
            .toString();
        String chemicalQuantity = ivmTimeSheetViewModel
            .ivmTimeSheetGetTabularData
            .data!
            .getLCPTIMEREPORTACTIVITIESDataList![i]
            .chemicalQuantity
            .toString();

        activity.add(ActivityClass(
          TextEditingController(text: dayOfWeek),
          TextEditingController(text: substationId),
          TextEditingController(text: feederId),
          TextEditingController(text: workType),
          TextEditingController(text: accountTwoNumber),
          TextEditingController(text: mapNo),
          TextEditingController(text: sectionAddress),
          TextEditingController(text: poleNumber),
          TextEditingController(text: noteOfActivities),
          TextEditingController(text: manHour),
          TextEditingController(text: spans),
          TextEditingController(text: length),
          TextEditingController(text: width),
          TextEditingController(text: chemicalCode),
          TextEditingController(text: chemicalQuantity),
        ));
      }
    }
  }

  Future<void> submitDataMainTopData() async {
    const apiUrl =
        'http://civmapi.ariespro.com/civmapi/powerTimeForm/insertLCP_TIME_REPORT';
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    final requestData = {
      "contractor": (_contractor.text.isEmpty) ? '' : _contractor.text,
      "date": dateSelected1,
      "contractorType":
          (_contractorTwo.text.isEmpty) ? '' : _contractorTwo.text,
      "forManDigitalSign": (_foreman.text.isEmpty) ? '' : _foreman.text,
      "weekendDate": dateSelected2,
      "generalForMan":
          (_generalForeman.text.isEmpty) ? '' : _generalForeman.text,
      "jobNo": (_jobNumber.text.isEmpty) ? '' : _jobNumber.text,
      "crewMember": (_crewNumber.text.isEmpty) ? '' : _crewNumber.text,
      "pesticideLICNumber": (_pesticide.text.isEmpty) ? '' : _pesticide.text,
      "forManDigitalSignature": (_foremanDigitalSignature.text.isEmpty)
          ? ''
          : _foremanDigitalSignature.text,
      "workOrderNo": widget.id,
      "remarks": (_remarks.text.isEmpty) ? '' : _remarks.text,
      "personnelName": selectPersonnelName,
      "personnelType": personnelType,
      "ratesValue": (_value.text.isEmpty) ? '' : _value.text,
      "estimatedValue":
          (_estimatedValue.text.isEmpty) ? '' : _estimatedValue.text,
    };
    print(requestData);
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${data.token}',
        },
        body: jsonEncode(requestData),
      );

      if (response.statusCode == 200) {
        print('Request successful Main data');
        print('Response: ${response.body}');

        if (noOfEmployees.toString() != '--SELECT--') {
          submitDataEmployees();
        }

        if (noOfEquipment.toString() != '--SELECT--') {
          deleteData1();
          // submitDataEquipment();
        }
        if (noOfActivities.toString() != '--SELECT--') {
          deleteData2();
        }
if(noOfEmployees.toString() == '--SELECT--'&& noOfEquipment.toString() == '--SELECT--' && noOfActivities.toString() == '--SELECT--'){
   CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
            'Successfully Submitted', context);
        Future.delayed(const Duration(seconds: 3), () {
          print('navigation');
          Navigator.pop(context);
           Navigator.pop(context);
        });
}

      } else {
        print('Error: ${response.statusCode}');
        print('Response: ${response.body}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  Future<void> submitDataEmployees() async {
    print('12345');
    const apiUrl =
        'http://civmapi.ariespro.com/civmapi/powerTimeForm/insertLCP_TIME_REPORT_EMPLOYEE';
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    print('chemical');
    List<Map<String, dynamic>> mapDataList = [];
    print('444444444444444');
    for (int i = 0; i < employee.length; i++) {
      List<Map<String, dynamic>> mapSubDataList = [];

      for (int j = 0;
          j < int.parse(employee[i].additionalData!.length.toString());
          j++) {
        String dayValue =
            employee[i].additionalData![j].hours?.text.toString() ?? "";
        if (dayValue.isNotEmpty) {
          Map<String, dynamic> weekEntry = {
            "hours":
                employee[i].additionalData![j].hours?.text.toString() ?? "",
            "mIn":
                employee[i].additionalData![j].morningIn?.text.toString() ?? "",
            "mOut":
                employee[i].additionalData![j].morningOut?.text.toString() ??
                    "",
            "eOut":
                employee[i].additionalData![j].afetrnoonOut?.text.toString() ??
                    "",
            "eIn":
                employee[i].additionalData![j].afetrnoonIn?.text.toString() ??
                    "",
            "day": employee[i].additionalData![j].day?.text.toString() ?? "",
          };
          mapSubDataList.add(weekEntry);
        }
      }

      if (employee[i].classCode?.text.toString() != "" ||
          employee[i].otherCrew?.text.toString() != "" ||
          employee[i].employeeName?.text.toString() != "" ||
          employee[i].employeeNo?.text.toString() != "" ||
          (mapSubDataList.isNotEmpty)) {
        Map<String, dynamic> entry = {
          "classCode": employee[i].classCode?.text.toString() ?? "",
          "otherCrew": employee[i].otherCrew?.text.toString() ?? "",
          "employeeName": employee[i].employeeName?.text.toString() ?? "",
          "employeeNo": employee[i].employeeNo?.text.toString() ?? "",
          "workOrderNo": widget.id,
          "ivmEmpData": mapSubDataList,
        };
        mapDataList.add(entry);
      }
    }
    print('mapDataList');
    print(mapDataList);
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${data.token}',
        },
        body: jsonEncode(mapDataList),
      );

      if (response.statusCode == 200) {
        print('Request successful Employee11111');
        print('Response: ${response.body}');
        Future.delayed(const Duration(seconds: 3), () {
          print('navigation');
          Navigator.pop(context);
        });
      } else {
        print('Error: ${response.statusCode}');
        print('Response: ${response.body}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  Future<void> deleteData1() async {
    final apiUrl =
        'http://civmapi.ariespro.com/civmapi/powerTimeForm/deleteEmpAndEmpWorkingData/${widget.id}';
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    try {
      final response = await http.delete(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${data.token}',
        },
      );

      if (response.statusCode == 200) {
        // Successful response, you can handle the result here
        print('Delete request successful 1');
        print('Response: ${response.body}');

        submitDataEquipment();
      } else {
        // Handle errors
        print('Error: ${response.statusCode}');
        print('Response: ${response.body}');
      }
    } catch (error) {
      // Handle network errors
      print('Error: $error');
    }
  }

  Future<void> submitDataEquipment() async {
    print('12345');
    const apiUrl =
        'http://civmapi.ariespro.com/civmapi/powerTimeForm/insertLCP_TIME_REPORT_EQUIPMENTS';
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    print(apiUrl);
    List<Map<String, dynamic>> mapDataList = [];
    print('444444444444444');
    for (int i = 0; i < equipment.length; i++) {
      List<Map<String, dynamic>> mapSubDataList = [];

      for (int j = 0;
          j < int.parse(equipment[i].additionalData!.length.toString());
          j++) {
        String dayValue =
            equipment[i].additionalData![j].hours?.text.toString() ?? "";
        if (dayValue.isNotEmpty) {
          Map<String, dynamic> weekEntry = {
            "hours":
                equipment[i].additionalData![j].hours?.text.toString() ?? "",
            "day": equipment[i].additionalData![j].day?.text.toString() ?? "",
          };
          mapSubDataList.add(weekEntry);
        }
      }

      if (equipment[i].classCode?.text.toString() != "" ||
          equipment[i].otherCrew?.text.toString() != "" ||
          equipment[i].equipmentCode?.text.toString() != "" ||
          equipment[i].equipmentType?.toString() != "" ||
          ////////////////////////new added//////////////
          equipment[i].rates?.text.toString() != "" ||
          (mapSubDataList.isNotEmpty)) {
        Map<String, dynamic> entry = {
          "code": equipment[i].classCode?.text.toString() ?? "",
          "otherEqp": equipment[i].otherCrew?.text.toString() ?? "",
          "equipmentNo": equipment[i].equipmentCode?.text.toString() ?? "",
          "employeeType": equipment[i].equipmentType?.toString() ?? "",
          //////////////new added//////////////////////
          "equipmentsRatesValue": equipment[i].rates?.text.toString() ?? "",
          ///////////////////////////////////////
          "workOrderNo": widget.id,
          "workingDataHr": mapSubDataList,
        };
        mapDataList.add(entry);
      }
    }
    print('mapDataList11111111111111111');
    print(mapDataList);
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${data.token}',
        },
        body: jsonEncode(mapDataList),
      );

      if (response.statusCode == 200) {
        print('Request successful Equipment');
        print('Response: ${response.body}');
        Future.delayed(const Duration(seconds: 3), () {
          print('navigation');
          Navigator.pop(context);
        });
      } else {
        print('Error: ${response.statusCode}');
        print('Response: ${response.body}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  Future<void> deleteData2() async {
    final apiUrl =
        'http://civmapi.ariespro.com/civmapi/powerTimeForm/deletePowerTimeReportActivities/${widget.id}';
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    try {
      final response = await http.delete(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${data.token}',
        },
      );

      if (response.statusCode == 200) {
        // Successful response, you can handle the result here
        print('Delete request successful 2');
        print('Response: ${response.body}');
        submitDataActivities();
      } else {
        // Handle errors
        print('Error: ${response.statusCode}');
        print('Response: ${response.body}');
      }
    } catch (error) {
      // Handle network errors
      print('Error: $error');
    }
  }

  Future<void> submitDataActivities() async {
    const apiUrl =
        'http://civmapi.ariespro.com/civmapi/powerTimeForm/SP_INSERT_LCP_TIME_REPORT_ACTIVITIES';
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    Map<String, String?> a;
    List<Map<String, dynamic>> mapDataList = [];
    for (int i = 0; i < int.parse(noOfActivities.toString()); i++) {
      if (activity[i].spans?.text.toString() != "" ||
          activity[i].noteActivityCode?.text.toString() != "" ||
          activity[i].chemicalQuantity?.text.toString() != "" ||
          activity[i].mapNumber?.text.toString() != "" ||
          activity[i].manHour?.text.toString() != "" ||
          activity[i].width?.text.toString() != "" ||
          activity[i].sectionAddress?.text.toString() != "" ||
          activity[i].chemicalCode?.text.toString() != "" ||
          activity[i].substationId?.text.toString() != "" ||
          activity[i].feederId?.text.toString() != "" ||
          activity[i].dayOfWeek?.text.toString() != "" ||
          activity[i].length?.text.toString() != "" ||
          activity[i].accountTwoNumber?.text.toString() != "" ||
          activity[i].workType?.text.toString() != "" ||
          activity[i].poleNumber?.text.toString() != "") {
        a = {
          "spans": activity[i].spans?.text.toString() ?? "",
          "notesActivityCode":
              activity[i].noteActivityCode?.text.toString() ?? "",
          "chemicalQuantity":
              activity[i].chemicalQuantity?.text.toString() ?? "",
          "mapNumber": activity[i].mapNumber?.text.toString() ?? "",
          "manHours": activity[i].manHour?.text.toString() ?? "",
          "width": activity[i].width?.text.toString() ?? "",
          "sectionAddress": activity[i].sectionAddress?.text.toString() ?? "",
          "chemicalCode": activity[i].chemicalCode?.text.toString() ?? "",
          "substationId": activity[i].substationId?.text.toString() ?? "",
          "feederId": activity[i].feederId?.text.toString() ?? "",
          "dayOfWeek": activity[i].dayOfWeek?.text.toString() ?? "",
          "length": activity[i].length?.text.toString() ?? "",
          "accountNo": activity[i].accountTwoNumber?.text.toString() ?? "",
          "workType": activity[i].workType?.text.toString() ?? "",
          "poleNumber": activity[i].poleNumber?.text.toString() ?? "",
          "workOrderNo": widget.id
        };
        mapDataList.add(a);
      }
    }
    print(mapDataList);
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${data.token}',
        },
        body: jsonEncode(mapDataList),
      );

      if (response.statusCode == 200) {
        print('Request successful Activity');
        print('Response: ${response.body}');
        CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
            'Successfully Submitted', context);

        Future.delayed(const Duration(seconds: 3), () {
          print('navigation');
          Navigator.pop(context);
        });
      } else {
        print('Error: ${response.statusCode}');
        print('Response: ${response.body}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }
}

class ActivityClass {
  TextEditingController? dayOfWeek;
  TextEditingController? substationId;
  TextEditingController? feederId;
  TextEditingController? workType;
  TextEditingController? accountTwoNumber;
  TextEditingController? mapNumber;
  TextEditingController? sectionAddress;
  TextEditingController? poleNumber;
  TextEditingController? noteActivityCode;
  TextEditingController? manHour;
  TextEditingController? spans;
  TextEditingController? length;
  TextEditingController? width;
  TextEditingController? chemicalCode;
  TextEditingController? chemicalQuantity;

  ActivityClass(
      this.dayOfWeek,
      this.substationId,
      this.feederId,
      this.workType,
      this.accountTwoNumber,
      this.mapNumber,
      this.sectionAddress,
      this.poleNumber,
      this.noteActivityCode,
      this.manHour,
      this.spans,
      this.length,
      this.width,
      this.chemicalCode,
      this.chemicalQuantity);
}

class EquipmentClass {
  String? equipmentType;
  // TextEditingController? equipmentType;
  TextEditingController? equipmentCode;
  TextEditingController? otherCrew;
  TextEditingController? classCode;
  ////new added////////
  TextEditingController? rates;
  List<EquipmentAditionalData>? additionalData;

  EquipmentClass(this.equipmentType, this.equipmentCode, this.otherCrew,
      this.classCode, this.rates, this.additionalData);

  factory EquipmentClass.createWithAdditionalData() {
    List<EquipmentAditionalData> additionalDataList = List.generate(
      7,
      (index) => EquipmentAditionalData(
        TextEditingController(text: _getDay(index)),
        TextEditingController(),
      ),
    );

    return EquipmentClass(
      null,
      // TextEditingController(),
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
      ///////////new added for rates//////////////
      TextEditingController(),
      ////////////////////
      additionalDataList,
    );
  }

  static String _getDay(int index) {
    switch (index) {
      case 0:
        return 'SUNDAY';
      case 1:
        return 'MONDAY';
      case 2:
        return 'TUESDAY';
      case 3:
        return 'WEDNESDAY';
      case 4:
        return 'THURSDAY';
      case 5:
        return 'FRIDAY';
      case 6:
        return 'SATURDAY';
      default:
        return '';
    }
  }
}

class EquipmentAditionalData {
  TextEditingController? day;
  TextEditingController? hours;

  EquipmentAditionalData(this.day, this.hours);
}

class EmployeeClass {
  TextEditingController? employeeNo;
  TextEditingController? employeeName;
  TextEditingController? otherCrew;
  TextEditingController? classCode;
  List<EmployeeAdditionalData>? additionalData;

  EmployeeClass(this.employeeNo, this.employeeName, this.otherCrew,
      this.classCode, this.additionalData);

  factory EmployeeClass.createWithAdditionalData() {
    List<EmployeeAdditionalData> additionalDataList = List.generate(
      7,
      (index) => EmployeeAdditionalData(
        TextEditingController(text: _getDay(index)),
        TextEditingController(),
        TextEditingController(),
        TextEditingController(),
        TextEditingController(),
        TextEditingController(),
      ),
    );

    return EmployeeClass(
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
      additionalDataList,
    );
  }

  static String _getDay(int index) {
    switch (index) {
      case 0:
        return 'SUNDAY';
      case 1:
        return 'MONDAY';
      case 2:
        return 'TUESDAY';
      case 3:
        return 'WEDNESDAY';
      case 4:
        return 'THURSDAY';
      case 5:
        return 'FRIDAY';
      case 6:
        return 'SATURDAY';
      default:
        return '';
    }
  }
}

class EmployeeAdditionalData {
  TextEditingController? day;
  TextEditingController? hours;
  TextEditingController? morningIn;
  TextEditingController? morningOut;
  TextEditingController? afetrnoonIn;
  TextEditingController? afetrnoonOut;

  EmployeeAdditionalData(
    this.day,
    this.hours,
    this.morningIn,
    this.morningOut,
    this.afetrnoonIn,
    this.afetrnoonOut,
  );
}
