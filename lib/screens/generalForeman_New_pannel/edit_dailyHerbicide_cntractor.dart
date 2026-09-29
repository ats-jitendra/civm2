// ignore: file_names
import 'dart:convert';
import 'package:CIVM/models/user_model.dart';
import 'package:CIVM/utils/user_pref.dart';
import 'package:http/http.dart' as http;
import 'package:CIVM/data/response/status.dart';
import 'package:CIVM/utils/custom_toast_snackbar_progressdialog.dart';
import 'package:CIVM/view_model/daily_herbicide_view_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class EditDailyHerbicideApplicationContractor extends StatefulWidget {
  String id;

  EditDailyHerbicideApplicationContractor({Key? key, required this.id})
      : super(key: key);
  @override
  State<EditDailyHerbicideApplicationContractor> createState() =>
      _EditDailyHerbicideApplicationContractorState();
}

class _EditDailyHerbicideApplicationContractorState
    extends State<EditDailyHerbicideApplicationContractor> {
  final TextEditingController _changeOrderNo = TextEditingController();
  final TextEditingController _foreman = TextEditingController();
  final TextEditingController _jobNumber = TextEditingController();
  final TextEditingController _substation = TextEditingController();
  final TextEditingController _map = TextEditingController();
  final TextEditingController _subnumber = TextEditingController();
  final TextEditingController _circuitNumber = TextEditingController();
  final TextEditingController _totalGallonsOfSolutions =
      TextEditingController();
  final TextEditingController _totalAcersApplied = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  List<EditDailyHerbicideApplicationClass> dailyHerbicide = [];
  List<EditEquipmentClass> equipment = [];
  List<EditLaborClass> labor = [];
  List<EditTimeOfApplicationClass> timeOfApplication = [];
  List<EditWeatherConditionAtSiteClass> weatherConditionAtSite = [];
  List<EditApplicantsClass> applicants = [];

  // ignore: non_constant_identifier_names
  final select_maintenanceType = [
    'IVM REGULAR MAINTENANCE',
    'MID CYCLE SPRAY TREATMENT'
  ];
  // ignore: non_constant_identifier_names
  String? maintenanceType;

  // ignore: non_constant_identifier_names
  final select_noOfHerbicide = [
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
  String? noOfHerbicide = '--SELECT--';

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
  final select_noOfLabor = [
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
  String? noOfLabor = '--SELECT--';

  // ignore: non_constant_identifier_names
  final select_noOfTimeOfApplication = [
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
  String? noOfTimeOfApplication = '--SELECT--';

  // ignore: non_constant_identifier_names
  final select_noOfWeatherConditionAtSite = [
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
  String? noOfWeatherConditionAtSite = '--SELECT--';

  // ignore: non_constant_identifier_names
  final select_noOfApplicants = [
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
  String? noOfApplicants = '--SELECT--';

  int flag = 0;

  late String dateSelected1 = 'dd-MM-yyyy';
  DateTime date1 = DateTime.now();
  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: date1,
        firstDate: DateTime(2010),
        lastDate: DateTime(2050));
    if (picked != null && picked != date1) {
      setState(() {
        date1 = picked;
        dateSelected1 = DateFormat('dd-MM-yyyy').format(picked);
      });
    }
  }

  DailyHerbicideViewModel dailyHerbicideViewModel = DailyHerbicideViewModel();
  @override
  void initState() {
    dailyHerbicideViewModel.fetchDailyHerbicideTabularListApi(
        context, widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text(
            'DAILY HERBICIDE APPLICATION',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: const Color.fromARGB(255, 7, 59, 120),
        ),
        body: ChangeNotifierProvider<DailyHerbicideViewModel>(
            create: (BuildContext context) => dailyHerbicideViewModel,
            child:
                Consumer<DailyHerbicideViewModel>(builder: (context, value, _) {
              switch (value.dailyHerbicideGetTabularData.status) {
                case Status.LOADING:
                  return const Center(child: CircularProgressIndicator());
                case Status.ERROR:
                  return
                      // CustomToastSnackBarProgressDialog.flushBarErrorMessage(
                      //     value.dailyHerbicideGetTabularData.message.toString(),
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
                  if (flag == 0) {
                    flag = 1;
                    setData(value);
                    setDataApplicants(value);
                    setDataWeatherCondition(value);
                    setDataTimeOfApplication(value);
                    setDataLabour(value);
                    setDataEquipment(value);
                    setDataHerbicide(value);
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
                              child: Container(
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
                                          color:
                                              Color.fromARGB(255, 7, 59, 120),
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
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Padding(
                                          padding: const EdgeInsets.all(2.0),
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
                                            decoration: const InputDecoration(
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
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Padding(
                                          padding: const EdgeInsets.all(2.0),
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
                                                decoration: const BoxDecoration(
                                                    // shape: BoxShape.circle,
                                                    boxShadow: [],
                                                    gradient: LinearGradient(
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
                                                                      top: 2),
                                                              child: IconButton(
                                                                icon: const Icon(
                                                                    Icons
                                                                        .calendar_month),
                                                                iconSize: 22,
                                                                color: const Color
                                                                    .fromARGB(
                                                                    255,
                                                                    7,
                                                                    59,
                                                                    120),
                                                                onPressed: () {
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
                                                                      left: 2),
                                                              child: Text(
                                                                  dateSelected1,
                                                                  style:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                    color: Color
                                                                        .fromARGB(
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
                                              "MAINTENANCE TYPE",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Color.fromARGB(
                                                      255, 7, 59, 120),
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8.0),
                                            child:
                                                DropdownButtonFormField<String>(
                                              hint: const Text('-Select-'),
                                              dropdownColor: Colors.white,
                                              value: maintenanceType,
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
                                              decoration: const InputDecoration(
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
                                              items: select_maintenanceType
                                                  .map(buildMenuItem)
                                                  .toList(),
                                              onChanged: (value) {
                                                setState(() {
                                                  maintenanceType = value;
                                                });
                                                // createDailyHerbicideList(
                                                //     int.parse(
                                                //         value.toString()));
                                              },
                                              validator: (value) =>
                                                  value == null
                                                      ? 'field required'
                                                      : null,
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
                                              "JOB NUMBER",
                                              style: TextStyle(
                                                  fontSize: 16.0,
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
                                            //  key: formkey5,
                                            controller: _jobNumber,
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
                                              "FOREMAN",
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
                                            //  key: formkey5,
                                            controller: _foreman,
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
                                              hintText: 'foreman',
                                            ),
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return "Please enter foreman";
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
                                              "SUBSTATION",
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
                                            //  key: formkey5,
                                            controller: _substation,
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
                                              hintText: 'substation',
                                            ),
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return "Please enter substation";
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
                                              "MAP/LINE NUMBER",
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
                                            //  key: formkey5,
                                            controller: _map,
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
                                              hintText: 'map/line number',
                                            ),
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return "Please enter map/line number";
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
                                              "SUBNUMBER",
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
                                            //  key: formkey5,
                                            controller: _subnumber,
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
                                              hintText: 'subnumber',
                                            ),
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return "Please enter subnumber";
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
                                              "CIRCUIT NUMBER",
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
                                            //  key: formkey5,
                                            controller: _circuitNumber,
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
                                              hintText: 'circuit number',
                                            ),
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return "Please enter circuit number";
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
                                        color: Color.fromARGB(255, 7, 59, 120),
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
                                            Color.fromARGB(255, 7, 59, 120),
                                            Color.fromARGB(255, 7, 59, 120)
                                          ],
                                        )),
                                    child: const Row(children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "HERBICIDE",
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
                                          value: noOfHerbicide,
                                          style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 7, 59, 120),
                                              fontSize: 16),
                                          icon: const Icon(
                                            Icons.arrow_drop_down,
                                            color:
                                                Color.fromARGB(255, 7, 59, 120),
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
                                          items: select_noOfHerbicide
                                              .map(buildMenuItem)
                                              .toList(),
                                          onChanged: (value) {
                                            setState(() {
                                              noOfHerbicide = value;
                                            });
                                            createDailyHerbicideList(
                                                int.parse(value.toString()));
                                          },
                                          validator: (value) => value == null
                                              ? 'field required'
                                              : null,
                                        ),
                                      ),
                                    ),
                                  ),
                                  noOfHerbicide.toString() != '--SELECT--'
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
                                              itemCount: dailyHerbicide.length,
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
                                                                              dailyHerbicide[index].sectionTowmShipRange,
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
                                                                              labelText: 'SECTION TOWNSHIP RANGE',
                                                                              labelStyle: TextStyle(color: Colors.white, fontSize: 12)),

                                                                          validator:
                                                                              (value) {
                                                                            if (value!.isEmpty) {
                                                                              return "Please enter section township range";
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
                                                                              dailyHerbicide[index].productName,
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
                                                                              labelText: 'PRODUCT NAME',
                                                                              labelStyle: TextStyle(color: Colors.white, fontSize: 12)),

                                                                          validator:
                                                                              (value) {
                                                                            if (value!.isEmpty) {
                                                                              return "Please enter product name";
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
                                                                              dailyHerbicide[index].epnNo,
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
                                                                              labelText: 'EPN NUMBER',
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
                                                                              return "Please epn number";
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
                                                                              dailyHerbicide[index].appliedRatePerGallon,
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
                                                                              labelText: 'APPLIED RATE PER GALLON',
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
                                                                              return "Please enter applied rate per gallon";
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
                                                                              dailyHerbicide[index].gallonOfSolution,
                                                                          style: const TextStyle(
                                                                              color: Colors.white,
                                                                              fontSize: 12),
                                                                          obscureText:
                                                                              false,
                                                                          // keyboardType:
                                                                          //     TextInputType
                                                                          //         .number,
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
                                                                              labelText: 'GALLON OF SOLUTION',
                                                                              labelStyle: TextStyle(color: Colors.white, fontSize: 12)),
                                                                          onChanged:
                                                                              (value) {
                                                                            calculateHerbicideGallons();
                                                                            print('123456');
                                                                          },
                                                                          validator:
                                                                              (value) {
                                                                            if (value!.isEmpty) {
                                                                              return "Please enter gallon of solution";
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
                                                                              dailyHerbicide[index].rowWidth20,
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
                                                                              labelText: 'ROW WIDTH 20',
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
                                                                              return "Please enter row width 20";
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
                                                                              dailyHerbicide[index].rowWidth30,
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
                                                                              labelText: 'ROW WIDTH 30',
                                                                              labelStyle: TextStyle(color: Colors.white, fontSize: 12)),
                                                                          onChanged:
                                                                              (value) {
                                                                            print('123456');
                                                                          },
                                                                          validator:
                                                                              (value) {
                                                                            if (value!.isEmpty) {
                                                                              return "Please enter row width 30";
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
                                                                              dailyHerbicide[index].rowWidth40,
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
                                                                              labelText: 'ROW WIDTH 40',
                                                                              labelStyle: TextStyle(color: Colors.white, fontSize: 12)),
                                                                          onChanged:
                                                                              (value) {
                                                                            print('789999999');
                                                                          },
                                                                          validator:
                                                                              (value) {
                                                                            if (value!.isEmpty) {
                                                                              return "Please enter row width 40";
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
                                                                              dailyHerbicide[index].rowWidth50,
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
                                                                              labelText: 'ROW WIDTH 50',
                                                                              labelStyle: TextStyle(color: Colors.white, fontSize: 12)),
                                                                          onChanged:
                                                                              (value) {
                                                                            print('123456');
                                                                          },
                                                                          validator:
                                                                              (value) {
                                                                            if (value!.isEmpty) {
                                                                              return "Please enter row width 50";
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
                                                                              dailyHerbicide[index].rowWidth60,
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
                                                                              labelText: 'ROW WIDTH 60',
                                                                              labelStyle: TextStyle(color: Colors.white, fontSize: 12)),
                                                                          onChanged:
                                                                              (value) {
                                                                            print('789999999');
                                                                          },
                                                                          validator:
                                                                              (value) {
                                                                            if (value!.isEmpty) {
                                                                              return "Please enter row width 60";
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
                                                                              dailyHerbicide[index].rowWidth70,
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
                                                                              labelText: 'ROW WIDTH 70',
                                                                              labelStyle: TextStyle(color: Colors.white, fontSize: 12)),
                                                                          onChanged:
                                                                              (value) {
                                                                            print('123456');
                                                                          },
                                                                          validator:
                                                                              (value) {
                                                                            if (value!.isEmpty) {
                                                                              return "Please enter row width 70";
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
                                                                              dailyHerbicide[index].rowWidth80,
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
                                                                              labelText: 'ROW WIDTH 80',
                                                                              labelStyle: TextStyle(color: Colors.white, fontSize: 12)),
                                                                          onChanged:
                                                                              (value) {
                                                                            print('789999999');
                                                                          },
                                                                          validator:
                                                                              (value) {
                                                                            if (value!.isEmpty) {
                                                                              return "Please enter row width 80";
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
                                                                              .centerLeft,
                                                                      child:
                                                                          Padding(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            2.0),
                                                                        child:
                                                                            TextFormField(
                                                                          //  key: formkey5,
                                                                          controller:
                                                                              dailyHerbicide[index].acersPerSection,
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
                                                                              labelText: 'ACRES PER SECTION',
                                                                              labelStyle: TextStyle(color: Colors.white, fontSize: 12)),
                                                                          onChanged:
                                                                              (value) {
                                                                            calculateHerbicideAcers();
                                                                          },
                                                                          validator:
                                                                              (value) {
                                                                            if (value!.isEmpty) {
                                                                              return "Please enter acers per section";
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
                                                                                dailyHerbicide.removeAt(index);
                                                                                noOfHerbicide = cardLength(noOfHerbicide.toString());
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
                                  const Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 2.0,
                                            right: 2.0,
                                            bottom: 2.0,
                                            top: 8.0),
                                        child: Text(
                                          "TOTAL GALLONS OF SOLUTION",
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
                                        //  key: formkey5,
                                        controller: _totalGallonsOfSolutions,
                                        style: const TextStyle(
                                            color:
                                                Color.fromARGB(255, 7, 59, 120),
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
                                              'total gallons of solutions',
                                        ),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Please enter total gallons of solutions";
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
                                          "TOTAL ACRES APPLIED",
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
                                        //  key: formkey5,
                                        controller: _totalAcersApplied,
                                        style: const TextStyle(
                                            color:
                                                Color.fromARGB(255, 7, 59, 120),
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
                                          hintText: 'total acers applies',
                                        ),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Please enter total acers applies";
                                          } else {
                                            return null;
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: InkWell(
                                      onTap: () {
                                        print('Add another herbicide');
                                        (noOfHerbicide != '10' &&
                                                noOfHerbicide != '--SELECT--')
                                            ? setState(() {
                                                noOfHerbicide = (int.parse(
                                                            noOfHerbicide
                                                                .toString()) +
                                                        1)
                                                    .toString();
                                              })
                                            : (noOfHerbicide == '--SELECT--')
                                                ? setState(() {
                                                    noOfHerbicide = '1';
                                                  })
                                                : CustomToastSnackBarProgressDialog
                                                    .snackBar(
                                                        'Maximum Limit of Herbicide is 10',
                                                        context);
                                        dailyHerbicide.add(
                                            EditDailyHerbicideApplicationClass(
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

                                        print(noOfHerbicide);
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
                                            "Add Another Herbicide",
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
                                        color: Color.fromARGB(255, 7, 59, 120),
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
                                            Color.fromARGB(255, 7, 59, 120),
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
                                                Color.fromARGB(255, 7, 59, 120),
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
                                                                              equipment[index].equipment,
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
                                                                              labelText: 'EQUIPMENT',
                                                                              labelStyle: TextStyle(color: Colors.white, fontSize: 12)),

                                                                          validator:
                                                                              (value) {
                                                                            if (value!.isEmpty) {
                                                                              return "Please enter equipment";
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
                                                                              equipment[index].equipmentNo,
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
                                                                              labelText: 'EQUIPMENT NUMBER',
                                                                              labelStyle: TextStyle(color: Colors.white, fontSize: 12)),

                                                                          validator:
                                                                              (value) {
                                                                            if (value!.isEmpty) {
                                                                              return "Please enter equipment no.";
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
                                                                              equipment[index].quantity,
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
                                                                              labelText: 'QUANTITY',
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
                                                                              return "Please enter quantity";
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
                                                                              equipment[index].hoursEach,
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
                                                                              labelText: 'HOURS EACH',
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
                                                                              return "Please enter hours each";
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
                                                                              .centerLeft,
                                                                      child:
                                                                          Padding(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            2.0),
                                                                        child:
                                                                            SizedBox(
                                                                          width:
                                                                              160,
                                                                          child:
                                                                              TextFormField(
                                                                            //  key: formkey5,
                                                                            controller:
                                                                                equipment[index].totalHours,
                                                                            style:
                                                                                const TextStyle(color: Colors.white, fontSize: 12),
                                                                            obscureText:
                                                                                false,
                                                                            // keyboardType:
                                                                            //     TextInputType
                                                                            //         .number,
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
                                                                                labelText: 'TOTAL HOURS',
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
                                                                                return "Please enter total hours";
                                                                              } else {
                                                                                return null;
                                                                              }
                                                                            },
                                                                          ),
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

                                        print(noOfEquipment);
                                        equipment.add(EditEquipmentClass(
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
                                            "Add Another Equipment",
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
                                        color: Color.fromARGB(255, 7, 59, 120),
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
                                            Color.fromARGB(255, 7, 59, 120),
                                            Color.fromARGB(255, 7, 59, 120)
                                          ],
                                        )),
                                    child: const Row(children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "LABOR",
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
                                          value: noOfLabor,
                                          style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 7, 59, 120),
                                              fontSize: 16),
                                          icon: const Icon(
                                            Icons.arrow_drop_down,
                                            color:
                                                Color.fromARGB(255, 7, 59, 120),
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
                                          items: select_noOfLabor
                                              .map(buildMenuItem)
                                              .toList(),
                                          onChanged: (value) {
                                            setState(() {
                                              noOfLabor = value;
                                            });
                                            createLaborList(
                                                int.parse(value.toString()));
                                          },
                                          validator: (value) => value == null
                                              ? 'field required'
                                              : null,
                                        ),
                                      ),
                                    ),
                                  ),
                                  noOfLabor.toString() != '--SELECT--'
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
                                              itemCount: labor.length,
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
                                                                              labor[index].labor,
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
                                                                              labelText: 'LABOR',
                                                                              labelStyle: TextStyle(color: Colors.white, fontSize: 12)),

                                                                          validator:
                                                                              (value) {
                                                                            if (value!.isEmpty) {
                                                                              return "Please enter labor";
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
                                                                              labor[index].quantity,
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
                                                                              labelText: 'QUANTITY',
                                                                              labelStyle: TextStyle(color: Colors.white, fontSize: 12)),

                                                                          validator:
                                                                              (value) {
                                                                            if (value!.isEmpty) {
                                                                              return "Please enter quantity";
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
                                                                              labor[index].hoursEach,
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
                                                                              labelText: 'HOURS EACH',
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
                                                                              return "Please enter hours each";
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
                                                                              labor[index].totalHours,
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
                                                                              labelText: 'TOTAL HOURS',
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
                                                                              return "Please enter total hours";
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
                                                                      child: Padding(
                                                                          padding: const EdgeInsets.all(2.0),
                                                                          child: InkWell(
                                                                            onTap:
                                                                                () {
                                                                              setState(() {
                                                                                labor.removeAt(index);
                                                                                noOfLabor = cardLength(noOfLabor.toString());
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
                                        (noOfLabor != '10' &&
                                                noOfLabor != '--SELECT--')
                                            ? setState(() {
                                                noOfLabor = (int.parse(noOfLabor
                                                            .toString()) +
                                                        1)
                                                    .toString();
                                              })
                                            : (noOfLabor == '--SELECT--')
                                                ? setState(() {
                                                    noOfLabor = '1';
                                                  })
                                                : CustomToastSnackBarProgressDialog
                                                    .snackBar(
                                                        'Maximum Limit of Labor is 10',
                                                        context);

                                        print(noOfLabor);

                                        labor.add(EditLaborClass(
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
                                            "Add Another Labor",
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
                                        color: Color.fromARGB(255, 7, 59, 120),
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
                                            Color.fromARGB(255, 7, 59, 120),
                                            Color.fromARGB(255, 7, 59, 120)
                                          ],
                                        )),
                                    child: const Row(children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "TIME OF APPLICATION",
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
                                          value: noOfTimeOfApplication,
                                          style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 7, 59, 120),
                                              fontSize: 16),
                                          icon: const Icon(
                                            Icons.arrow_drop_down,
                                            color:
                                                Color.fromARGB(255, 7, 59, 120),
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
                                          items: select_noOfTimeOfApplication
                                              .map(buildMenuItem)
                                              .toList(),
                                          onChanged: (value) {
                                            setState(() {
                                              noOfTimeOfApplication = value;
                                            });
                                            createTimeOfApplicationList(
                                                int.parse(value.toString()));
                                          },
                                          validator: (value) => value == null
                                              ? 'field required'
                                              : null,
                                        ),
                                      ),
                                    ),
                                  ),
                                  noOfTimeOfApplication.toString() !=
                                          '--SELECT--'
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
                                              itemCount:
                                                  timeOfApplication.length,
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
                                                                              timeOfApplication[index].applicationStartTime,
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
                                                                              labelText: 'APPLICATION START TIME',
                                                                              labelStyle: TextStyle(color: Colors.white, fontSize: 12)),

                                                                          validator:
                                                                              (value) {
                                                                            if (value!.isEmpty) {
                                                                              return "Please enter application start time";
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
                                                                              timeOfApplication[index].applicationEndTime,
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
                                                                              labelText: 'APPLICATION END TIME',
                                                                              labelStyle: TextStyle(color: Colors.white, fontSize: 12)),

                                                                          validator:
                                                                              (value) {
                                                                            if (value!.isEmpty) {
                                                                              return "Please enter application end time";
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
                                                                              timeOfApplication[index].breakStartTime,
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
                                                                              labelText: 'BREAK START TIME',
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
                                                                              return "Please enter break start time";
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
                                                                              timeOfApplication[index].breakEndTime,
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
                                                                              labelText: 'BREAK END TIME',
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
                                                                              return "Please enter break end time";
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
                                                                              .centerLeft,
                                                                      child:
                                                                          Padding(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            2.0),
                                                                        child:
                                                                            SizedBox(
                                                                          width:
                                                                              160,
                                                                          child:
                                                                              TextFormField(
                                                                            //  key: formkey5,
                                                                            controller:
                                                                                timeOfApplication[index].reason,
                                                                            style:
                                                                                const TextStyle(color: Colors.white, fontSize: 12),
                                                                            obscureText:
                                                                                false,
                                                                            // keyboardType:
                                                                            //     TextInputType
                                                                            //         .number,
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
                                                                                labelText: 'REASON',
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
                                                                                return "Please enter reason";
                                                                              } else {
                                                                                return null;
                                                                              }
                                                                            },
                                                                          ),
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
                                                                                timeOfApplication.removeAt(index);
                                                                                noOfTimeOfApplication = cardLength(noOfTimeOfApplication.toString());
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
                                        (noOfTimeOfApplication != '10' &&
                                                noOfTimeOfApplication !=
                                                    '--SELECT--')
                                            ? setState(() {
                                                noOfTimeOfApplication = (int.parse(
                                                            noOfTimeOfApplication
                                                                .toString()) +
                                                        1)
                                                    .toString();
                                              })
                                            : (noOfTimeOfApplication ==
                                                    '--SELECT--')
                                                ? setState(() {
                                                    noOfTimeOfApplication = '1';
                                                  })
                                                : CustomToastSnackBarProgressDialog
                                                    .snackBar(
                                                        'Maximum Limit of Time of Application is 10',
                                                        context);

                                        timeOfApplication.add(
                                            EditTimeOfApplicationClass(
                                                TextEditingController(),
                                                TextEditingController(),
                                                TextEditingController(),
                                                TextEditingController(),
                                                TextEditingController()));

                                        print(noOfTimeOfApplication);
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
                                            "Add Another Time of Application",
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
                                        color: Color.fromARGB(255, 7, 59, 120),
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
                                            Color.fromARGB(255, 7, 59, 120),
                                            Color.fromARGB(255, 7, 59, 120)
                                          ],
                                        )),
                                    child: const Row(children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "WEATHER CONDITION AT SITE",
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
                                          value: noOfWeatherConditionAtSite,
                                          style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 7, 59, 120),
                                              fontSize: 16),
                                          icon: const Icon(
                                            Icons.arrow_drop_down,
                                            color:
                                                Color.fromARGB(255, 7, 59, 120),
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
                                          items:
                                              select_noOfWeatherConditionAtSite
                                                  .map(buildMenuItem)
                                                  .toList(),
                                          onChanged: (value) {
                                            setState(() {
                                              noOfWeatherConditionAtSite =
                                                  value;
                                            });
                                            createWeatherConditionAtSiteList(
                                                int.parse(value.toString()));
                                          },
                                          validator: (value) => value == null
                                              ? 'field required'
                                              : null,
                                        ),
                                      ),
                                    ),
                                  ),
                                  noOfWeatherConditionAtSite.toString() !=
                                          '--SELECT--'
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
                                              itemCount:
                                                  weatherConditionAtSite.length,
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
                                                                              weatherConditionAtSite[index].time,
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
                                                                              labelText: 'TIME',
                                                                              labelStyle: TextStyle(color: Colors.white, fontSize: 12)),

                                                                          validator:
                                                                              (value) {
                                                                            if (value!.isEmpty) {
                                                                              return "Please enter time";
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
                                                                              weatherConditionAtSite[index].temperature,
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
                                                                              labelText: 'TEMPERATURE (F)',
                                                                              labelStyle: TextStyle(color: Colors.white, fontSize: 12)),

                                                                          validator:
                                                                              (value) {
                                                                            if (value!.isEmpty) {
                                                                              return "Please enter temperature";
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
                                                                              weatherConditionAtSite[index].windSpeed,
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
                                                                              labelText: 'WIND SPEED (MPH)',
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
                                                                              return "Please enter wind speed";
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
                                                                              weatherConditionAtSite[index].windDirection,
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
                                                                              labelText: 'WIND DIRECTION',
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
                                                                              return "Please enter wind direction";
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
                                                                              .centerLeft,
                                                                      child:
                                                                          Padding(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            2.0),
                                                                        child:
                                                                            InkWell(
                                                                          onTap:
                                                                              () {
                                                                            setState(() {
                                                                              weatherConditionAtSite.removeAt(index);
                                                                              noOfWeatherConditionAtSite = cardLength(noOfWeatherConditionAtSite.toString());
                                                                            });
                                                                          },
                                                                          child: const Icon(
                                                                              Icons.delete,
                                                                              color: Colors.white),
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
                                        (noOfWeatherConditionAtSite != '10' &&
                                                noOfWeatherConditionAtSite !=
                                                    '--SELECT--')
                                            ? setState(() {
                                                noOfWeatherConditionAtSite =
                                                    (int.parse(noOfWeatherConditionAtSite
                                                                .toString()) +
                                                            1)
                                                        .toString();
                                              })
                                            : (noOfWeatherConditionAtSite ==
                                                    '--SELECT--')
                                                ? setState(() {
                                                    noOfWeatherConditionAtSite =
                                                        '1';
                                                  })
                                                : CustomToastSnackBarProgressDialog
                                                    .snackBar(
                                                        'Maximum Limit of Weather Condition is 10',
                                                        context);

                                        weatherConditionAtSite.add(
                                            EditWeatherConditionAtSiteClass(
                                                TextEditingController(),
                                                TextEditingController(),
                                                TextEditingController(),
                                                TextEditingController()));

                                        print(noOfWeatherConditionAtSite);
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
                                            "Add Another Weather Condition",
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
                                        color: Color.fromARGB(255, 7, 59, 120),
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
                                            Color.fromARGB(255, 7, 59, 120),
                                            Color.fromARGB(255, 7, 59, 120)
                                          ],
                                        )),
                                    child: const Row(children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "APPLICANTS",
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
                                          value: noOfApplicants,
                                          style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 7, 59, 120),
                                              fontSize: 16),
                                          icon: const Icon(
                                            Icons.arrow_drop_down,
                                            color:
                                                Color.fromARGB(255, 7, 59, 120),
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
                                          items: select_noOfApplicants
                                              .map(buildMenuItem)
                                              .toList(),
                                          onChanged: (value) {
                                            setState(() {
                                              noOfApplicants = value;
                                            });
                                            createApplicantsList(
                                                int.parse(value.toString()));
                                          },
                                          validator: (value) => value == null
                                              ? 'field required'
                                              : null,
                                        ),
                                      ),
                                    ),
                                  ),
                                  noOfApplicants.toString() != '--SELECT--'
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
                                              itemCount: applicants.length,
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
                                                                              applicants[index].applicantsName,
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
                                                                              labelText: 'APPLICANT\'S NAME',
                                                                              labelStyle: TextStyle(color: Colors.white, fontSize: 12)),

                                                                          validator:
                                                                              (value) {
                                                                            if (value!.isEmpty) {
                                                                              return "Please enter applicant's name";
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
                                                                              applicants[index].applicantsLicenceNo,
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
                                                                              labelText: 'APPLICANT\'S LICENSE NUMBER ',
                                                                              labelStyle: TextStyle(color: Colors.white, fontSize: 12)),

                                                                          validator:
                                                                              (value) {
                                                                            if (value!.isEmpty) {
                                                                              return "Please enter applicants license number";
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
                                                                              applicants[index].applicantsDigitalSign,
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
                                                                              labelText: 'APPLICANT\'S DIGITAL SIGNATURE',
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
                                                                              return "Please enter applicants digital signature";
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
                                                                                applicants.removeAt(index);
                                                                                noOfApplicants = cardLength(noOfApplicants.toString());
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
                                        (noOfApplicants != '10' &&
                                                noOfApplicants != '--SELECT--')
                                            ? setState(() {
                                                noOfApplicants = (int.parse(
                                                            noOfApplicants
                                                                .toString()) +
                                                        1)
                                                    .toString();
                                              })
                                            : (noOfApplicants == '--SELECT--')
                                                ? setState(() {
                                                    noOfApplicants = '1';
                                                  })
                                                : CustomToastSnackBarProgressDialog
                                                    .snackBar(
                                                        'Maximum Limit of Applicants is 10',
                                                        context);

                                        applicants.add(EditApplicantsClass(
                                            TextEditingController(),
                                            TextEditingController(),
                                            TextEditingController()));

                                        print(noOfApplicants);
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
                                            "Add Another Applicants",
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
                                    left: 6, right: 6, top: 20.0, bottom: 10),
                                child: InkWell(
                                  onTap: () {
                                    if (_formkey.currentState!.validate()) {
                                      submitDataMainTopData();
                                    } else {}
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
                                              color: Color.fromARGB(
                                                  255, 3, 47, 97),
                                              blurRadius: 5,
                                              offset: Offset(2.0, 5.0))
                                        ],
                                        gradient: LinearGradient(
                                          colors: [
                                            Color.fromARGB(255, 7, 59, 120),
                                            Color.fromARGB(255, 7, 59, 120)
                                          ],
                                        )),
                                    child: const Row(children: [
                                      Expanded(
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            "Submit",
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

  createDailyHerbicideList(int noOfResoureces) {
    dailyHerbicide.clear();
    if (noOfResoureces != '--SELECT--') {
      for (int i = 0; i < noOfResoureces; i++) {
        dailyHerbicide.add(EditDailyHerbicideApplicationClass(
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
    print(dailyHerbicide.length);
  }

  createEquipmentList(int noOfResoureces) {
    equipment.clear();
    if (noOfResoureces != 0) {
      for (int i = 0; i < noOfResoureces; i++) {
        equipment.add(EditEquipmentClass(
            TextEditingController(),
            TextEditingController(),
            TextEditingController(),
            TextEditingController(),
            TextEditingController()));
      }
    }
    print(equipment.length);
  }

  createLaborList(int noOfResoureces) {
    labor.clear();
    if (noOfLabor != 0) {
      for (int i = 0; i < noOfResoureces; i++) {
        labor.add(EditLaborClass(
            TextEditingController(),
            TextEditingController(),
            TextEditingController(),
            TextEditingController()));
      }
    }
    print(labor.length);
  }

  createTimeOfApplicationList(int noOfResoureces) {
    timeOfApplication.clear();
    if (noOfTimeOfApplication != 0) {
      for (int i = 0; i < noOfResoureces; i++) {
        timeOfApplication.add(EditTimeOfApplicationClass(
            TextEditingController(),
            TextEditingController(),
            TextEditingController(),
            TextEditingController(),
            TextEditingController()));
      }
    }
    print(timeOfApplication.length);
  }

  createWeatherConditionAtSiteList(int noOfResoureces) {
    weatherConditionAtSite.clear();
    if (noOfWeatherConditionAtSite != 0) {
      for (int i = 0; i < noOfResoureces; i++) {
        weatherConditionAtSite.add(EditWeatherConditionAtSiteClass(
            TextEditingController(),
            TextEditingController(),
            TextEditingController(),
            TextEditingController()));
      }
    }
    print(timeOfApplication.length);
  }

  createApplicantsList(int noOfResoureces) {
    applicants.clear();
    if (noOfApplicants != 0) {
      for (int i = 0; i < noOfResoureces; i++) {
        applicants.add(EditApplicantsClass(TextEditingController(),
            TextEditingController(), TextEditingController()));
      }
    }
    print(timeOfApplication.length);
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

  setData(DailyHerbicideViewModel value) {
    _changeOrderNo.text = widget.id;
    print('before if case');
    if (dailyHerbicideViewModel
                .dailyHerbicideGetTabularData.data!.getDailyHerbicideDataList !=
            null &&
        dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!
            .getDailyHerbicideDataList!.isNotEmpty) {
      print('if case');
      print('dateSelected1');
      dateSelected1 = (dailyHerbicideViewModel.dailyHerbicideGetTabularData
                      .data!.getDailyHerbicideDataList![0].date ==
                  null ||
              dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!
                      .getDailyHerbicideDataList![0].date
                      .toString() ==
                  'null')
          ? ''
          : dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!
              .getDailyHerbicideDataList![0].date
              .toString();
      print('_maintenanceType');
      maintenanceType = (dailyHerbicideViewModel.dailyHerbicideGetTabularData
                      .data!.getDailyHerbicideDataList![0].maintenanceType ==
                  null ||
              dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!
                      .getDailyHerbicideDataList![0].maintenanceType
                      .toString() ==
                  'null')
          ? 'MID CYCLE SPRAY TREATMENT'
          : dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!
              .getDailyHerbicideDataList![0].maintenanceType
              .toString();
      print('_jobNumber');
      _jobNumber.text = (dailyHerbicideViewModel.dailyHerbicideGetTabularData
                      .data!.getDailyHerbicideDataList![0].jobNumber ==
                  null ||
              dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!
                      .getDailyHerbicideDataList![0].jobNumber
                      .toString() ==
                  'null')
          ? ''
          : dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!
              .getDailyHerbicideDataList![0].jobNumber
              .toString();
      print('_foreman');
      _foreman.text = (dailyHerbicideViewModel.dailyHerbicideGetTabularData
                      .data!.getDailyHerbicideDataList![0].foreman ==
                  null ||
              dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!
                      .getDailyHerbicideDataList![0].foreman
                      .toString() ==
                  'null')
          ? ''
          : dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!
              .getDailyHerbicideDataList![0].foreman
              .toString();
      print('_substation');
      _substation.text = (dailyHerbicideViewModel.dailyHerbicideGetTabularData
                      .data!.getDailyHerbicideDataList![0].substation ==
                  null ||
              dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!
                      .getDailyHerbicideDataList![0].substation
                      .toString() ==
                  'null')
          ? ''
          : dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!
              .getDailyHerbicideDataList![0].substation
              .toString();
      print('_map');
      _map.text = (dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!
                      .getDailyHerbicideDataList![0].mapLineNo ==
                  null ||
              dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!
                      .getDailyHerbicideDataList![0].mapLineNo
                      .toString() ==
                  'null')
          ? ''
          : dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!
              .getDailyHerbicideDataList![0].mapLineNo
              .toString();
      print('_subnumber');
      _subnumber.text = (dailyHerbicideViewModel.dailyHerbicideGetTabularData
                      .data!.getDailyHerbicideDataList![0].subNo ==
                  null ||
              dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!
                      .getDailyHerbicideDataList![0].subNo
                      .toString() ==
                  'null')
          ? ''
          : dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!
              .getDailyHerbicideDataList![0].subNo
              .toString();
      print('_circuitNumber');
      _circuitNumber.text = (dailyHerbicideViewModel
                      .dailyHerbicideGetTabularData
                      .data!
                      .getDailyHerbicideDataList![0]
                      .circuitNo ==
                  null ||
              dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!
                      .getDailyHerbicideDataList![0].circuitNo
                      .toString() ==
                  'null')
          ? ''
          : dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!
              .getDailyHerbicideDataList![0].circuitNo
              .toString();
    }
    print('else case');
  }

  setDataApplicants(DailyHerbicideViewModel value) {
    dailyHerbicide.clear();
    if (dailyHerbicideViewModel.dailyHerbicideGetTabularData.data != null &&
        dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!
                .getDailyHerbicideDHAPPLICANTSDataList !=
            null) {
      for (int i = 0;
          i <
              dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!
                  .getDailyHerbicideDHAPPLICANTSDataList!.length;
          i++) {
        noOfApplicants = (dailyHerbicideViewModel.dailyHerbicideGetTabularData
                .data!.getDailyHerbicideDHAPPLICANTSDataList!.isEmpty)
            ? '--SELECT--'
            : dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!
                .getDailyHerbicideDHAPPLICANTSDataList!.length
                .toString();
        String applicantsName = dailyHerbicideViewModel
            .dailyHerbicideGetTabularData
            .data!
            .getDailyHerbicideDHAPPLICANTSDataList![i]
            .applicantName
            .toString();
        String applicantsLicenceNo = dailyHerbicideViewModel
            .dailyHerbicideGetTabularData
            .data!
            .getDailyHerbicideDHAPPLICANTSDataList![i]
            .applicantLicense
            .toString();
        String applicantsDigitalSign = dailyHerbicideViewModel
            .dailyHerbicideGetTabularData
            .data!
            .getDailyHerbicideDHAPPLICANTSDataList![i]
            .applicantDigitalSignature
            .toString();

        applicants.add(EditApplicantsClass(
          TextEditingController(text: applicantsName),
          TextEditingController(text: applicantsLicenceNo),
          TextEditingController(text: applicantsDigitalSign),
        ));
      }
    }
  }

  setDataWeatherCondition(DailyHerbicideViewModel value) {
    weatherConditionAtSite.clear();
    if (dailyHerbicideViewModel.dailyHerbicideGetTabularData.data != null &&
        dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!
                .getDailyHerbicideDHWEATHERCONDITIONDataList !=
            null) {
      for (int i = 0;
          i <
              dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!
                  .getDailyHerbicideDHWEATHERCONDITIONDataList!.length;
          i++) {
        noOfWeatherConditionAtSite = (dailyHerbicideViewModel
                .dailyHerbicideGetTabularData
                .data!
                .getDailyHerbicideDHWEATHERCONDITIONDataList!
                .isEmpty)
            ? '--SELECT--'
            : dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!
                .getDailyHerbicideDHWEATHERCONDITIONDataList!.length
                .toString();
        String time = dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!
            .getDailyHerbicideDHWEATHERCONDITIONDataList![i].time
            .toString();
        String temperature = dailyHerbicideViewModel
            .dailyHerbicideGetTabularData
            .data!
            .getDailyHerbicideDHWEATHERCONDITIONDataList![i]
            .temperature
            .toString();
        String windSpeed = dailyHerbicideViewModel.dailyHerbicideGetTabularData
            .data!.getDailyHerbicideDHWEATHERCONDITIONDataList![i].windSpeed
            .toString();
        String windDirection = dailyHerbicideViewModel
            .dailyHerbicideGetTabularData
            .data!
            .getDailyHerbicideDHWEATHERCONDITIONDataList![i]
            .direction
            .toString();

        weatherConditionAtSite.add(EditWeatherConditionAtSiteClass(
          TextEditingController(text: time),
          TextEditingController(text: temperature),
          TextEditingController(text: windSpeed),
          TextEditingController(text: windDirection),
        ));
      }
    }
  }

  setDataTimeOfApplication(DailyHerbicideViewModel value) {
    timeOfApplication.clear();
    if (dailyHerbicideViewModel.dailyHerbicideGetTabularData.data != null &&
        dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!
                .getDailyHerbicideDHAPPLICATIONDataList !=
            null) {
      for (int i = 0;
          i <
              dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!
                  .getDailyHerbicideDHAPPLICATIONDataList!.length;
          i++) {
        noOfTimeOfApplication = (dailyHerbicideViewModel
                .dailyHerbicideGetTabularData
                .data!
                .getDailyHerbicideDHAPPLICATIONDataList!
                .isEmpty)
            ? '--SELECT--'
            : dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!
                .getDailyHerbicideDHAPPLICATIONDataList!.length
                .toString();
        String applicationStartTime = dailyHerbicideViewModel
            .dailyHerbicideGetTabularData
            .data!
            .getDailyHerbicideDHAPPLICATIONDataList![i]
            .applicationStartTime
            .toString();
        String applicationEndTime = dailyHerbicideViewModel
            .dailyHerbicideGetTabularData
            .data!
            .getDailyHerbicideDHAPPLICATIONDataList![i]
            .applicationEndTime
            .toString();
        String breakStartTime = dailyHerbicideViewModel
            .dailyHerbicideGetTabularData
            .data!
            .getDailyHerbicideDHAPPLICATIONDataList![i]
            .breakStartTime
            .toString();
        String breakEndTime = dailyHerbicideViewModel
            .dailyHerbicideGetTabularData
            .data!
            .getDailyHerbicideDHAPPLICATIONDataList![i]
            .breakEndTime
            .toString();
        String reason = dailyHerbicideViewModel.dailyHerbicideGetTabularData
            .data!.getDailyHerbicideDHAPPLICATIONDataList![i].reason
            .toString();

        timeOfApplication.add(EditTimeOfApplicationClass(
            TextEditingController(text: applicationStartTime),
            TextEditingController(text: applicationEndTime),
            TextEditingController(text: breakStartTime),
            TextEditingController(text: breakEndTime),
            TextEditingController(text: reason)));
      }
    }
  }

  setDataLabour(DailyHerbicideViewModel value) {
    labor.clear();
    if (dailyHerbicideViewModel.dailyHerbicideGetTabularData.data != null &&
        dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!
                .getDailyHerbicideDHLABORDataList !=
            null) {
      for (int i = 0;
          i <
              dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!
                  .getDailyHerbicideDHLABORDataList!.length;
          i++) {
        noOfLabor = (dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!
                .getDailyHerbicideDHLABORDataList!.isEmpty)
            ? '--SELECT--'
            : dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!
                .getDailyHerbicideDHLABORDataList!.length
                .toString();
        String labour = dailyHerbicideViewModel.dailyHerbicideGetTabularData
            .data!.getDailyHerbicideDHLABORDataList![i].labour
            .toString();
        String quantity = dailyHerbicideViewModel.dailyHerbicideGetTabularData
            .data!.getDailyHerbicideDHLABORDataList![i].quantity
            .toString();
        String hoursEach = dailyHerbicideViewModel.dailyHerbicideGetTabularData
            .data!.getDailyHerbicideDHLABORDataList![i].hoursEach
            .toString();
        String totalHours = dailyHerbicideViewModel.dailyHerbicideGetTabularData
            .data!.getDailyHerbicideDHLABORDataList![i].totalHours
            .toString();

        labor.add(EditLaborClass(
            TextEditingController(text: labour),
            TextEditingController(text: quantity),
            TextEditingController(text: hoursEach),
            TextEditingController(text: totalHours)));
      }
    }
  }

  setDataEquipment(DailyHerbicideViewModel value) {
    equipment.clear();
    if (dailyHerbicideViewModel.dailyHerbicideGetTabularData.data != null &&
        dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!
                .getDailyHerbicideDHEQUIPMENTDataList !=
            null) {
      for (int i = 0;
          i <
              dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!
                  .getDailyHerbicideDHEQUIPMENTDataList!.length;
          i++) {
        noOfEquipment = (dailyHerbicideViewModel.dailyHerbicideGetTabularData
                .data!.getDailyHerbicideDHEQUIPMENTDataList!.isEmpty)
            ? '--SELECT--'
            : dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!
                .getDailyHerbicideDHEQUIPMENTDataList!.length
                .toString();
        String equipmentName = dailyHerbicideViewModel
            .dailyHerbicideGetTabularData
            .data!
            .getDailyHerbicideDHEQUIPMENTDataList![i]
            .equipment
            .toString();
        String equipmentNo = dailyHerbicideViewModel
            .dailyHerbicideGetTabularData
            .data!
            .getDailyHerbicideDHEQUIPMENTDataList![i]
            .quantity
            .toString();
        String quantity = dailyHerbicideViewModel.dailyHerbicideGetTabularData
            .data!.getDailyHerbicideDHEQUIPMENTDataList![i].quantity
            .toString();
        String hoursEach = dailyHerbicideViewModel.dailyHerbicideGetTabularData
            .data!.getDailyHerbicideDHEQUIPMENTDataList![i].hoursEach
            .toString();
        String totalHours = dailyHerbicideViewModel.dailyHerbicideGetTabularData
            .data!.getDailyHerbicideDHEQUIPMENTDataList![i].totalHours
            .toString();

        equipment.add(EditEquipmentClass(
            TextEditingController(text: equipmentName),
            TextEditingController(text: equipmentNo),
            TextEditingController(text: quantity),
            TextEditingController(text: hoursEach),
            TextEditingController(text: totalHours)));
      }
    }
  }

  setDataHerbicide(DailyHerbicideViewModel value) {
    dailyHerbicide.clear();
    double totalGallons = 0.0;
    double totalAcers = 0.0;
    if (dailyHerbicideViewModel.dailyHerbicideGetTabularData.data != null &&
        dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!
                .getDailyHerbicideDetailsDataList !=
            null) {
      for (int i = 0;
          i <
              dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!
                  .getDailyHerbicideDetailsDataList!.length;
          i++) {
        String appliedRateText = dailyHerbicideViewModel
            .dailyHerbicideGetTabularData
            .data!
            .getDailyHerbicideDetailsDataList![i]
            .gallonsOfSolution
            .toString();
        String totalAcersText = dailyHerbicideViewModel
            .dailyHerbicideGetTabularData
            .data!
            .getDailyHerbicideDetailsDataList![i]
            .acrossPerSections
            .toString();
        double appliedRate = double.tryParse(appliedRateText) ?? 0.0;
        totalGallons += appliedRate;

        double acersApplied = double.tryParse(totalAcersText) ?? 0.0;
        totalAcers += acersApplied;

        noOfHerbicide = (dailyHerbicideViewModel.dailyHerbicideGetTabularData
                .data!.getDailyHerbicideDetailsDataList!.isEmpty)
            ? '--SELECT--'
            : dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!
                .getDailyHerbicideDetailsDataList!.length
                .toString();
        String sectionTowmShipRange = dailyHerbicideViewModel
            .dailyHerbicideGetTabularData
            .data!
            .getDailyHerbicideDetailsDataList![i]
            .sectionPage
            .toString();
        String productName = dailyHerbicideViewModel
            .dailyHerbicideGetTabularData
            .data!
            .getDailyHerbicideDetailsDataList![i]
            .productName
            .toString();
        String epnNo = dailyHerbicideViewModel.dailyHerbicideGetTabularData
            .data!.getDailyHerbicideDetailsDataList![i].epaNo
            .toString();
        String appliedRatePerGallon = dailyHerbicideViewModel
            .dailyHerbicideGetTabularData
            .data!
            .getDailyHerbicideDetailsDataList![i]
            .appliedRatePerGallon
            .toString();
        String gallonOfSolution = dailyHerbicideViewModel
            .dailyHerbicideGetTabularData
            .data!
            .getDailyHerbicideDetailsDataList![i]
            .gallonsOfSolution
            .toString();

        String rowWidth20 = dailyHerbicideViewModel.dailyHerbicideGetTabularData
            .data!.getDailyHerbicideDetailsDataList![i].rowWith20
            .toString();

        String rowWidth30 = dailyHerbicideViewModel.dailyHerbicideGetTabularData
            .data!.getDailyHerbicideDetailsDataList![i].rowWith30
            .toString();

        String rowWidth40 = dailyHerbicideViewModel.dailyHerbicideGetTabularData
            .data!.getDailyHerbicideDetailsDataList![i].rowWith40
            .toString();

        String rowWidth50 = dailyHerbicideViewModel.dailyHerbicideGetTabularData
            .data!.getDailyHerbicideDetailsDataList![i].rowWith50
            .toString();

        String rowWidth60 = dailyHerbicideViewModel.dailyHerbicideGetTabularData
            .data!.getDailyHerbicideDetailsDataList![i].rowWith60
            .toString();

        String rowWidth70 = dailyHerbicideViewModel.dailyHerbicideGetTabularData
            .data!.getDailyHerbicideDetailsDataList![i].rowWith70
            .toString();

        String rowWidth80 = dailyHerbicideViewModel.dailyHerbicideGetTabularData
            .data!.getDailyHerbicideDetailsDataList![i].rowWith80
            .toString();

        String acersPerSection = dailyHerbicideViewModel
            .dailyHerbicideGetTabularData
            .data!
            .getDailyHerbicideDetailsDataList![i]
            .acrossPerSections
            .toString();

        dailyHerbicide.add(EditDailyHerbicideApplicationClass(
          TextEditingController(text: sectionTowmShipRange),
          TextEditingController(text: productName),
          TextEditingController(text: epnNo),
          TextEditingController(text: appliedRatePerGallon),
          TextEditingController(text: gallonOfSolution),
          TextEditingController(text: rowWidth20),
          TextEditingController(text: rowWidth30),
          TextEditingController(text: rowWidth40),
          TextEditingController(text: rowWidth50),
          TextEditingController(text: rowWidth60),
          TextEditingController(text: rowWidth70),
          TextEditingController(text: rowWidth80),
          TextEditingController(text: acersPerSection),
        ));
      }
      _totalGallonsOfSolutions.text = totalGallons.toString();
      _totalAcersApplied.text = totalAcers.toString();
    }
  }

  void calculateHerbicideGallons() {
    double totalGallons = 0.0;
    int iterations = int.tryParse(noOfHerbicide ?? '0') ?? 0;
    for (int i = 0; i < iterations; i++) {
      double gallonsValue = double.tryParse(
              dailyHerbicide[i].gallonOfSolution!.text.toString()) ??
          0.0;
      totalGallons += gallonsValue;
    }
    _totalGallonsOfSolutions.text = totalGallons.toString();
  }

  void calculateHerbicideAcers() {
    double totalAcersApplied = 0.0;
    int iterations = int.tryParse(noOfHerbicide ?? '0') ?? 0;
    for (int i = 0; i < iterations; i++) {
      double acersValue =
          double.tryParse(dailyHerbicide[i].acersPerSection!.text.toString()) ??
              0.0;
      totalAcersApplied += acersValue;
    }
    _totalAcersApplied.text = totalAcersApplied.toString();
  }

  Future<void> submitDataMainTopData() async {
    const apiUrl =
        'http://civmapi.ariespro.com/civmapi/dailyHerbicideApplicationForm/insertSP_INSERT_DAILY_HERBICIDEs';
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    final requestData = {
      "date": dateSelected1,
      "circuitNo": _circuitNumber.text,
      "foreman": _foreman.text,
      "substation": _substation.text,
      "subNo": _subnumber.text,
      "mapLineNo": _map.text,
      "workOrderNumber": widget.id,
      "type": maintenanceType,
      "jobNumber": _jobNumber.text
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
        print('Request successful');
        print('Response: ${response.body}');
        deleteData();
      } else {
        print('Error: ${response.statusCode}');
        print('Response: ${response.body}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  Future<void> deleteData() async {
    final apiUrl =
        'http://civmapi.ariespro.com/civmapi/dailyHerbicideApplicationForm/delete/${widget.id}';
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
        print('Delete request successful');
        print('Response: ${response.body}');
        submitDataDHEquipment();
        submitDataLabour();
        submitDataApplication();
        submitDataWeatherCondition();
        submitDataApplicants();
        submitDataHerbicide();
        Future.delayed(const Duration(seconds: 2), () {
          print('navigation');
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pop(context);
        });
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

  Future<void> submitDataDHEquipment() async {
    const apiUrl =
        'http://civmapi.ariespro.com/civmapi/dailyHerbicideApplicationForm/insertSP_INSERT_DH_EQUIPMENT';
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    Map<String, String?> a;
    List<Map<String, dynamic>> mapDataList = [];
    for (int i = 0; i < int.parse(noOfEquipment.toString()); i++) {
      if (equipment[i].equipment?.text.toString() != "" ||
          equipment[i].equipmentNo?.text.toString() != "" ||
          equipment[i].quantity?.text.toString() != "" ||
          equipment[i].hoursEach?.text.toString() != "" ||
          equipment[i].totalHours?.text.toString() != "") {
        a = {
          "dailyHerbicideId": widget.id,
          "equipment": equipment[i].equipment?.text.toString() ?? "",
          "equipment_no": equipment[i].equipmentNo?.text.toString() ?? "",
          "quantity": equipment[i].quantity?.text.toString() ?? "",
          "hours_each": equipment[i].hoursEach?.text.toString() ?? "",
          "total_hours": equipment[i].totalHours?.text.toString() ?? "",
          "workOrderNo": widget.id,
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
        print('Request successful Equipment');
        print('Response: ${response.body}');
        CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
            'Successfully Submitted', context);
      } else {
        print('Error: ${response.statusCode}');
        print('Response: ${response.body}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  Future<void> submitDataLabour() async {
    const apiUrl =
        'http://civmapi.ariespro.com/civmapi/dailyHerbicideApplicationForm/insertSP_INSERT_DH_LABORs';
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    Map<String, String?> a;
    List<Map<String, dynamic>> mapDataList = [];
    for (int i = 0; i < int.parse(noOfLabor.toString()); i++) {
      if (labor[i].quantity?.text.toString() != "" ||
          labor[i].totalHours?.text.toString() != "" ||
          labor[i].hoursEach?.text.toString() != "" ||
          labor[i].labor?.text.toString() != "") {
        a = {
          "quantity": labor[i].quantity?.text.toString() ?? "",
          "dailyHerbicideId": widget.id,
          "totalHours": labor[i].totalHours?.text.toString() ?? "",
          "hoursEach": labor[i].hoursEach?.text.toString() ?? "",
          "labor": labor[i].labor?.text.toString() ?? "",
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
        print('Request successful Labour');
        print('Response: ${response.body}');
        CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
            'Successfully Submitted', context);
      } else {
        print('Error: ${response.statusCode}');
        print('Response: ${response.body}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  Future<void> submitDataApplication() async {
    const apiUrl =
        'http://civmapi.ariespro.com/civmapi/dailyHerbicideApplicationForm/insertSP_INSERT_DH_APPLICATION';
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    Map<String, String?> a;
    List<Map<String, dynamic>> mapDataList = [];
    for (int i = 0; i < int.parse(noOfTimeOfApplication.toString()); i++) {
      if (timeOfApplication[i].reason?.text.toString() != "" ||
          timeOfApplication[i].applicationStartTime?.text.toString() != "" ||
          timeOfApplication[i].breakEndTime?.text.toString() != "" ||
          timeOfApplication[i].breakStartTime?.text.toString() != "" ||
          timeOfApplication[i].applicationEndTime?.text.toString() != "") {
        a = {
          "reason": timeOfApplication[i].reason?.text.toString() ?? "",
          "applicationStartTime":
              timeOfApplication[i].applicationStartTime?.text.toString() ?? "",
          "breakEndTime":
              timeOfApplication[i].breakEndTime?.text.toString() ?? "",
          "dailyHerbicideId": widget.id,
          "breakStartTime":
              timeOfApplication[i].breakStartTime?.text.toString() ?? "",
          "applicationEndTime":
              timeOfApplication[i].applicationEndTime?.text.toString() ?? "",
          "workOrderNo": widget.id,
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
        print('Request successful Application');
        print('Response: ${response.body}');
        CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
            'Successfully Submitted', context);
      } else {
        print('Error: ${response.statusCode}');
        print('Response: ${response.body}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  Future<void> submitDataWeatherCondition() async {
    const apiUrl =
        'http://civmapi.ariespro.com/civmapi/dailyHerbicideApplicationForm/insertSP_INSERT_DH_WEATHER_CONDITION';
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    Map<String, String?> a;
    List<Map<String, dynamic>> mapDataList = [];
    for (int i = 0; i < int.parse(noOfWeatherConditionAtSite.toString()); i++) {
      if (weatherConditionAtSite[i].temperature?.text.toString() != "" ||
          weatherConditionAtSite[i].time?.text.toString() != "" ||
          weatherConditionAtSite[i].windSpeed?.text.toString() != "" ||
          weatherConditionAtSite[i].windDirection?.text.toString() != "") {
        a = {
          "dailyHerbicideId": widget.id,
          "temperature":
              weatherConditionAtSite[i].temperature?.text.toString() ?? "",
          "time": weatherConditionAtSite[i].time?.text.toString() ?? "",
          "windSpeed":
              weatherConditionAtSite[i].windSpeed?.text.toString() ?? "",
          "direction":
              weatherConditionAtSite[i].windDirection?.text.toString() ?? "",
          "workOrderNo": widget.id,
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
        print('Request successful Weather Condition');
        print('Response: ${response.body}');
        CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
            'Successfully Submitted', context);
      } else {
        print('Error: ${response.statusCode}');
        print('Response: ${response.body}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  Future<void> submitDataApplicants() async {
    const apiUrl =
        'http://civmapi.ariespro.com/civmapi/dailyHerbicideApplicationForm/insertSP_INSERT_DH_APPLICANTS';
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    Map<String, String?> a;
    List<Map<String, dynamic>> mapDataList = [];
    for (int i = 0; i < int.parse(noOfApplicants.toString()); i++) {
      if (applicants[i].applicantsLicenceNo?.text.toString() != "" ||
          applicants[i].applicantsName?.text.toString() != "" ||
          applicants[i].applicantsDigitalSign?.text.toString() != "") {
        a = {
          "applicantLicenseNumber":
              applicants[i].applicantsLicenceNo?.text.toString() ?? "",
          "dailyHerbicideId": widget.id,
          "applicantName": applicants[i].applicantsName?.text.toString() ?? "",
          "applicantsDigitalSignature":
              applicants[i].applicantsDigitalSign?.text.toString() ?? "",
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
        print('Request successful Applicants');
        print('Response: ${response.body}');
        CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
            'Successfully Submitted', context);
        Future.delayed(const Duration(seconds: 1), () {
          Navigator.pop(context);
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

  Future<void> submitDataHerbicide() async {
    const apiUrl =
        'http://civmapi.ariespro.com/civmapi/dailyHerbicideApplicationForm/insertSP_INSERT_DAILY_HERBICIDE_DETAILS';
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    Map<String, String?> a;
    List<Map<String, dynamic>> mapDataList = [];
    for (int i = 0; i < int.parse(noOfHerbicide.toString()); i++) {
      if (dailyHerbicide[i].rowWidth20?.text.toString() != "" ||
          dailyHerbicide[i].rowWidth30?.text.toString() != "" ||
          dailyHerbicide[i].rowWidth40?.text.toString() != "" ||
          dailyHerbicide[i].rowWidth50?.text.toString() != "" ||
          dailyHerbicide[i].rowWidth60?.text.toString() != "" ||
          dailyHerbicide[i].rowWidth70?.text.toString() != "" ||
          dailyHerbicide[i].rowWidth80?.text.toString() != "" ||
          dailyHerbicide[i].acersPerSection?.text.toString() != "" ||
          dailyHerbicide[i].sectionTowmShipRange?.text.toString() != "" ||
          dailyHerbicide[i].productName?.text.toString() != "" ||
          dailyHerbicide[i].epnNo?.text.toString() != "" ||
          dailyHerbicide[i].appliedRatePerGallon?.text.toString() != "" ||
          dailyHerbicide[i].gallonOfSolution?.text.toString() != "") {
        a = {
          "dailyHerbicideId": widget.id,
          "rowWidth40": dailyHerbicide[i].rowWidth40?.text.toString() ?? "",
          "rowWidth30": dailyHerbicide[i].rowWidth30?.text.toString() ?? "",
          "rowWidth20": dailyHerbicide[i].rowWidth20?.text.toString() ?? "",
          "appliedRatePerGallon":
              dailyHerbicide[i].appliedRatePerGallon?.text.toString() ?? "",
          "rowWidth80": dailyHerbicide[i].rowWidth80?.text.toString() ?? "",
          "rowWidth70": dailyHerbicide[i].rowWidth70?.text.toString() ?? "",
          "productName": dailyHerbicide[i].productName?.text.toString() ?? "",
          "rowWidth60": dailyHerbicide[i].rowWidth60?.text.toString() ?? "",
          "rowWidth50": dailyHerbicide[i].rowWidth50?.text.toString() ?? "",
          "epaNo": dailyHerbicide[i].epnNo?.text.toString() ?? "",
          "sectionRange":
              dailyHerbicide[i].sectionTowmShipRange?.text.toString() ?? "",
          "acresPerSection":
              dailyHerbicide[i].acersPerSection?.text.toString() ?? "",
          "gallonsOfSolution":
              dailyHerbicide[i].gallonOfSolution?.text.toString() ?? "",
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
        print('Request successful Daily Herbicide');
        print('Response: ${response.body}');
        CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
            'Successfully Submitted', context);
      } else {
        print('Error: ${response.statusCode}');
        print('Response: ${response.body}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }
}

class EditApplicantsClass {
  TextEditingController? applicantsName;
  TextEditingController? applicantsLicenceNo;
  TextEditingController? applicantsDigitalSign;

  EditApplicantsClass(this.applicantsName, this.applicantsLicenceNo,
      this.applicantsDigitalSign);
}

class EditWeatherConditionAtSiteClass {
  TextEditingController? time;
  TextEditingController? temperature;
  TextEditingController? windSpeed;
  TextEditingController? windDirection;

  EditWeatherConditionAtSiteClass(
      this.time, this.temperature, this.windSpeed, this.windDirection);
}

class EditTimeOfApplicationClass {
  TextEditingController? applicationStartTime;
  TextEditingController? applicationEndTime;
  TextEditingController? breakStartTime;
  TextEditingController? breakEndTime;
  TextEditingController? reason;

  EditTimeOfApplicationClass(this.applicationStartTime, this.applicationEndTime,
      this.breakStartTime, this.breakEndTime, this.reason);
}

class EditLaborClass {
  TextEditingController? labor;
  TextEditingController? quantity;
  TextEditingController? hoursEach;
  TextEditingController? totalHours;

  EditLaborClass(this.labor, this.quantity, this.hoursEach, this.totalHours);
}

class EditDailyHerbicideApplicationClass {
  TextEditingController? sectionTowmShipRange;
  TextEditingController? productName;
  TextEditingController? epnNo;
  TextEditingController? appliedRatePerGallon;
  TextEditingController? gallonOfSolution;
  TextEditingController? rowWidth20;
  TextEditingController? rowWidth30;
  TextEditingController? rowWidth40;
  TextEditingController? rowWidth50;
  TextEditingController? rowWidth60;
  TextEditingController? rowWidth70;
  TextEditingController? rowWidth80;
  TextEditingController? acersPerSection;

  EditDailyHerbicideApplicationClass(
      this.sectionTowmShipRange,
      this.productName,
      this.epnNo,
      this.appliedRatePerGallon,
      this.gallonOfSolution,
      this.rowWidth20,
      this.rowWidth30,
      this.rowWidth40,
      this.rowWidth50,
      this.rowWidth60,
      this.rowWidth70,
      this.rowWidth80,
      this.acersPerSection);
}

class EditEquipmentClass {
  TextEditingController? equipment;
  TextEditingController? equipmentNo;
  TextEditingController? quantity;
  TextEditingController? hoursEach;
  TextEditingController? totalHours;

  EditEquipmentClass(this.equipment, this.equipmentNo, this.quantity,
      this.hoursEach, this.totalHours);
}
