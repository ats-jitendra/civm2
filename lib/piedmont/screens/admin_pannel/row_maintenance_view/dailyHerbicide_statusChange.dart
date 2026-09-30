// ignore: file_names
import 'package:CIVM/piedmont/data/response/status.dart';
import 'package:CIVM/piedmont/resources/app_colors.dart';
import 'package:CIVM/piedmont/view_model/daily_herbicide_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class DailyHerbicideStatusChange extends StatefulWidget {
  String id;

  DailyHerbicideStatusChange({Key? key, required this.id}) : super(key: key);
  @override
  State<DailyHerbicideStatusChange> createState() =>
      _DailyHerbicideStatusChangeState();
}

class _DailyHerbicideStatusChangeState
    extends State<DailyHerbicideStatusChange> {
  final TextEditingController _changeOrderNo = TextEditingController();
  final TextEditingController _date = TextEditingController();
  final TextEditingController _maintenanceType = TextEditingController();
  final TextEditingController _foreman = TextEditingController();
  final TextEditingController _jobNumber = TextEditingController();

  final TextEditingController _substation = TextEditingController();
  final TextEditingController _map = TextEditingController();
  final TextEditingController _subnumber = TextEditingController();
  final TextEditingController _circuitNumber = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  bool _isVisibilityHerbicide = true;
  bool _isVisibilityEquipment = false;
  bool _isVisibilityLabor = false;
  bool _isVisibilityTimeOfApplication = false;
  bool _isVisibilityWeather = false;
  bool _isVisibilityApplicants = false;

  bool isHerbicideSelected = true;
  bool isEquipmentSelected = false;
  bool isLaborSelected = false;
  bool isTimeSelected = false;
  bool isWeatherSelected = false;
  bool isApplicantsSelected = false;

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
       backgroundColor:AppColors.backgroundColor,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text(
            'DAILY HERBICIDE APPLICATION',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: AppColors.baseColor,
        ),
        // drawer: DrawerManu(menu: menu),
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
                  setData(value);
                  return RefreshIndicator(
                    onRefresh: () async {
                      await dailyHerbicideViewModel
                          .fetchDailyHerbicideTabularListApi(
                              context, widget.id);
                    },
                    child: SingleChildScrollView(
                      child: DefaultTabController(
                        length: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Form(
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
                                            color:
                                                AppColors.baseColor,
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
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            )),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: TextFormField(
                                              enabled: false,
                                              //  key: formkey5,
                                              controller: _date,
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
                                                hintText: 'date',
                                              ),
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return "Please enter date";
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
                                                "MAINTENANCE TYPE",
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
                                            padding: const EdgeInsets.all(2.0),
                                            child: TextFormField(
                                              enabled: false,
                                              //  key: formkey5,
                                              controller: _maintenanceType,
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
                                                hintText: 'maintenance type',
                                              ),
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return "Please enter maintenance type";
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
                                            padding: const EdgeInsets.all(2.0),
                                            child: TextFormField(
                                              enabled: false,
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
                                                disabledBorder:
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
                                                "FOREMAN",
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
                                            padding: const EdgeInsets.all(2.0),
                                            child: TextFormField(
                                              enabled: false,
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
                                                disabledBorder:
                                                    OutlineInputBorder(
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
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            )),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: TextFormField(
                                              enabled: false,
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
                                                disabledBorder:
                                                    OutlineInputBorder(
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
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            )),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: TextFormField(
                                              enabled: false,
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
                                                disabledBorder:
                                                    OutlineInputBorder(
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
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            )),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: TextFormField(
                                              enabled: false,
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
                                                disabledBorder:
                                                    OutlineInputBorder(
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
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            )),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: TextFormField(
                                              enabled: false,
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
                                                disabledBorder:
                                                    OutlineInputBorder(
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
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      alignment: Alignment.center,
                                      height: size.height * 0.05,
                                      width: size.width * 0.3,
                                      decoration: const BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Color.fromARGB(255, 135, 10, 1),
                                            blurRadius: 5,
                                            offset: Offset(2.0, 5.0),
                                          ),
                                        ],
                                        // Use a ternary operator to set the background color based on the selection state
                                        color: Colors.red,
                                      ),
                                      child: const Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "PRINT",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                      left: 4, right: 4, top: 10, bottom: 8),
                                  padding: const EdgeInsets.all(8),
                                  alignment: Alignment.center,
                                  height: size.height * 0.6,
                                  width: size.width * 0.99,
                                  decoration: BoxDecoration(
                                      // shape: BoxShape.circle,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: const [
                                        BoxShadow(
                                            color:
                                                AppColors.baseColor,
                                            blurRadius: 10,
                                            offset: Offset(2.0, 5.0))
                                      ],
                                      gradient: const LinearGradient(
                                        colors: [
                                          Color.fromARGB(255, 255, 255, 255),
                                          Color.fromARGB(255, 255, 255, 255),
                                        ],
                                      )),
                                  child: Column(children: [
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              _isVisibilityHerbicide = true;
                                              _isVisibilityEquipment = false;
                                              _isVisibilityLabor = false;
                                              _isVisibilityTimeOfApplication =
                                                  false;
                                              _isVisibilityWeather = false;
                                              _isVisibilityApplicants = false;

                                              setState(() {
                                                isHerbicideSelected = true;
                                                isEquipmentSelected = false;
                                                isLaborSelected = false;
                                                isTimeSelected = false;
                                                isWeatherSelected = false;
                                                isApplicantsSelected = false;
                                              });
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.all(10),
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                boxShadow: const [
                                                  BoxShadow(
                                                    color: Color.fromARGB(
                                                        255, 3, 47, 97),
                                                    blurRadius: 5,
                                                    offset: Offset(2.0, 5.0),
                                                  ),
                                                ],
                                                // Use a ternary operator to set the background color based on the selection state
                                                color: isHerbicideSelected
                                                    ? const Color.fromARGB(
                                                        255, 5, 119, 249)
                                                    : const Color.fromARGB(
                                                        255, 7, 59, 120),
                                              ),
                                              child: const Align(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  "Herbicide",
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: GestureDetector(
                                              onTap: () {
                                                _isVisibilityHerbicide = false;
                                                _isVisibilityEquipment = true;
                                                _isVisibilityLabor = false;
                                                _isVisibilityTimeOfApplication =
                                                    false;
                                                _isVisibilityWeather = false;
                                                _isVisibilityApplicants = false;

                                                setState(() {
                                                  isHerbicideSelected = false;
                                                  isEquipmentSelected = true;
                                                  isLaborSelected = false;
                                                  isTimeSelected = false;
                                                  isWeatherSelected = false;
                                                  isApplicantsSelected = false;
                                                });
                                              },
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  boxShadow: const [
                                                    BoxShadow(
                                                      color: Color.fromARGB(
                                                          255, 3, 47, 97),
                                                      blurRadius: 5,
                                                      offset: Offset(2.0, 5.0),
                                                    ),
                                                  ],
                                                  // Use a ternary operator to set the background color based on the selection state
                                                  color: isEquipmentSelected
                                                      ? const Color.fromARGB(
                                                          255, 5, 119, 249)
                                                      : const Color.fromARGB(
                                                          255, 7, 59, 120),
                                                ),
                                                child: const Align(
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    "Equipment",
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: GestureDetector(
                                              onTap: () {
                                                _isVisibilityHerbicide = false;
                                                _isVisibilityEquipment = false;
                                                _isVisibilityLabor = true;
                                                _isVisibilityTimeOfApplication =
                                                    false;
                                                _isVisibilityWeather = false;
                                                _isVisibilityApplicants = false;

                                                setState(() {
                                                  isHerbicideSelected = false;
                                                  isEquipmentSelected = false;
                                                  isLaborSelected = true;
                                                  isTimeSelected = false;
                                                  isWeatherSelected = false;
                                                  isApplicantsSelected = false;
                                                });
                                              },
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  boxShadow: const [
                                                    BoxShadow(
                                                      color: Color.fromARGB(
                                                          255, 3, 47, 97),
                                                      blurRadius: 5,
                                                      offset: Offset(2.0, 5.0),
                                                    ),
                                                  ],
                                                  // Use a ternary operator to set the background color based on the selection state
                                                  color: isLaborSelected
                                                      ? const Color.fromARGB(
                                                          255, 5, 119, 249)
                                                      : const Color.fromARGB(
                                                          255, 7, 59, 120),
                                                ),
                                                child: const Align(
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    "Labor",
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: GestureDetector(
                                              onTap: () {
                                                _isVisibilityHerbicide = false;
                                                _isVisibilityEquipment = false;
                                                _isVisibilityLabor = false;
                                                _isVisibilityTimeOfApplication =
                                                    true;
                                                _isVisibilityWeather = false;
                                                _isVisibilityApplicants = false;

                                                setState(() {
                                                  isHerbicideSelected = false;
                                                  isEquipmentSelected = false;
                                                  isLaborSelected = false;
                                                  isTimeSelected = true;
                                                  isWeatherSelected = false;
                                                  isApplicantsSelected = false;
                                                });
                                              },
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  boxShadow: const [
                                                    BoxShadow(
                                                      color: Color.fromARGB(
                                                          255, 3, 47, 97),
                                                      blurRadius: 5,
                                                      offset: Offset(2.0, 5.0),
                                                    ),
                                                  ],
                                                  // Use a ternary operator to set the background color based on the selection state
                                                  color: isTimeSelected
                                                      ? const Color.fromARGB(
                                                          255, 5, 119, 249)
                                                      : const Color.fromARGB(
                                                          255, 7, 59, 120),
                                                ),
                                                child: const Align(
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    "Time Of Application",
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: GestureDetector(
                                              onTap: () {
                                                _isVisibilityHerbicide = false;
                                                _isVisibilityEquipment = false;
                                                _isVisibilityLabor = false;
                                                _isVisibilityTimeOfApplication =
                                                    false;
                                                _isVisibilityWeather = true;
                                                _isVisibilityApplicants = false;

                                                setState(() {
                                                  isHerbicideSelected = false;
                                                  isEquipmentSelected = false;
                                                  isLaborSelected = false;
                                                  isTimeSelected = false;
                                                  isWeatherSelected = true;
                                                  isApplicantsSelected = false;
                                                });
                                              },
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  boxShadow: const [
                                                    BoxShadow(
                                                      color: Color.fromARGB(
                                                          255, 3, 47, 97),
                                                      blurRadius: 5,
                                                      offset: Offset(2.0, 5.0),
                                                    ),
                                                  ],
                                                  // Use a ternary operator to set the background color based on the selection state
                                                  color: isWeatherSelected
                                                      ? const Color.fromARGB(
                                                          255, 5, 119, 249)
                                                      : const Color.fromARGB(
                                                          255, 7, 59, 120),
                                                ),
                                                child: const Align(
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    "Weather Condition at Site",
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: GestureDetector(
                                              onTap: () {
                                                _isVisibilityHerbicide = false;
                                                _isVisibilityEquipment = false;
                                                _isVisibilityLabor = false;
                                                _isVisibilityTimeOfApplication =
                                                    false;
                                                _isVisibilityWeather = false;
                                                _isVisibilityApplicants = true;

                                                setState(() {
                                                  isHerbicideSelected = false;
                                                  isEquipmentSelected = false;
                                                  isLaborSelected = false;
                                                  isTimeSelected = false;
                                                  isWeatherSelected = false;
                                                  isApplicantsSelected = true;
                                                });
                                              },
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  boxShadow: const [
                                                    BoxShadow(
                                                      color: Color.fromARGB(
                                                          255, 3, 47, 97),
                                                      blurRadius: 5,
                                                      offset: Offset(2.0, 5.0),
                                                    ),
                                                  ],
                                                  // Use a ternary operator to set the background color based on the selection state
                                                  color: isApplicantsSelected
                                                      ? const Color.fromARGB(
                                                          255, 5, 119, 249)
                                                      : const Color.fromARGB(
                                                          255, 7, 59, 120),
                                                ),
                                                child: const Align(
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    "Applicants",
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Visibility(
                                      visible: _isVisibilityHerbicide,
                                      child: Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 8.0, left: 4),
                                          child: ListView.builder(
                                              itemCount: dailyHerbicideViewModel
                                                  .dailyHerbicideGetTabularData
                                                  .data!
                                                  .getDailyHerbicideDetailsDataList!
                                                  .length,
                                              itemBuilder: (BuildContext ctxt,
                                                  int index) {
                                                return Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                        top: 4.0,
                                                        bottom: 4,
                                                      ),
                                                      child: Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.9,
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.35,
                                                        // margin:  EdgeInsets.only(
                                                        //     top: 5.0, bottom: 5.0, left: 2,right: 2),
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8),
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
                                                        begin:
                                                            Alignment.topLeft,
                                                        end: Alignment
                                                            .bottomRight,
                                                      ),
                                                      border: Border.all(
                                                        color: Colors.white,
                                                      ),
                                                      borderRadius:
                                                          const BorderRadius
                                                              .only(
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
                                                        child: Column(
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        left:
                                                                            8.0),
                                                                child: Row(
                                                                  children: [
                                                                    Expanded(
                                                                      // alignment: Alignment.topLeft,
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          const Align(
                                                                            alignment:
                                                                                Alignment.topLeft,
                                                                            child:
                                                                                Text(
                                                                              "SECTION TOWNSHIP RANGE: ",
                                                                              textAlign: TextAlign.left,
                                                                              style: TextStyle(
                                                                                fontSize: 12,
                                                                                fontWeight: FontWeight.bold,
                                                                                color: Colors.white,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Align(
                                                                            alignment:
                                                                                Alignment.topLeft,
                                                                            child:
                                                                                Text(
                                                                              (dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!.getDailyHerbicideDetailsDataList![index].sectionPage == null || dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!.getDailyHerbicideDetailsDataList![index].sectionPage.toString() == 'null') ? '' : dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!.getDailyHerbicideDetailsDataList![index].sectionPage.toString(),
                                                                              textAlign: TextAlign.left,
                                                                              style: const TextStyle(
                                                                                fontSize: 12,
                                                                                color: Colors.white,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      // alignment: Alignment.topLeft,
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          const Align(
                                                                            alignment:
                                                                                Alignment.topLeft,
                                                                            child:
                                                                                Text(
                                                                              "PRODUCT NAME: ",
                                                                              textAlign: TextAlign.left,
                                                                              style: TextStyle(
                                                                                fontSize: 12,
                                                                                fontWeight: FontWeight.bold,
                                                                                color: Colors.white,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Align(
                                                                            alignment:
                                                                                Alignment.topLeft,
                                                                            child:
                                                                                Text(
                                                                              (dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!.getDailyHerbicideDetailsDataList![index].productName == null || dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!.getDailyHerbicideDetailsDataList![index].productName.toString() == 'null') ? '' : dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!.getDailyHerbicideDetailsDataList![index].productName.toString(),
                                                                              textAlign: TextAlign.left,
                                                                              style: const TextStyle(
                                                                                fontSize: 12,
                                                                                color: Colors.white,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      // alignment: Alignment.topLeft,
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          const Align(
                                                                            alignment:
                                                                                Alignment.topLeft,
                                                                            child:
                                                                                Text(
                                                                              "EPN NUMBER: ",
                                                                              textAlign: TextAlign.left,
                                                                              style: TextStyle(
                                                                                fontSize: 12,
                                                                                fontWeight: FontWeight.bold,
                                                                                color: Colors.white,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Align(
                                                                            alignment:
                                                                                Alignment.topLeft,
                                                                            child:
                                                                                Text(
                                                                              (dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!.getDailyHerbicideDetailsDataList![index].epaNo == null || dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!.getDailyHerbicideDetailsDataList![index].epaNo.toString() == 'null') ? '' : dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!.getDailyHerbicideDetailsDataList![index].epaNo.toString(),
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
                                                              const Divider(
                                                                color:
                                                                    Colors.grey,
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        left:
                                                                            8.0),
                                                                child: Row(
                                                                  children: [
                                                                    Expanded(
                                                                      // alignment: Alignment.topLeft,
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          const Align(
                                                                            alignment:
                                                                                Alignment.topLeft,
                                                                            child:
                                                                                Text(
                                                                              "APPLIED RATE PER GALLON: ",
                                                                              textAlign: TextAlign.left,
                                                                              style: TextStyle(
                                                                                fontSize: 12,
                                                                                fontWeight: FontWeight.bold,
                                                                                color: Colors.white,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Align(
                                                                            alignment:
                                                                                Alignment.topLeft,
                                                                            child:
                                                                                Text(
                                                                              (dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!.getDailyHerbicideDetailsDataList![index].appliedRatePerGallon == null || dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!.getDailyHerbicideDetailsDataList![index].appliedRatePerGallon.toString() == 'null') ? '' : dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!.getDailyHerbicideDetailsDataList![index].appliedRatePerGallon.toString(),
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
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          const Align(
                                                                            alignment:
                                                                                Alignment.topLeft,
                                                                            child:
                                                                                Text(
                                                                              "GALLON OF SOLUTION: ",
                                                                              textAlign: TextAlign.left,
                                                                              style: TextStyle(
                                                                                fontSize: 12,
                                                                                fontWeight: FontWeight.bold,
                                                                                color: Colors.white,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Align(
                                                                            alignment:
                                                                                Alignment.topLeft,
                                                                            child:
                                                                                Text(
                                                                              (dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!.getDailyHerbicideDetailsDataList![index].gallonsOfSolution == null || dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!.getDailyHerbicideDetailsDataList![index].gallonsOfSolution.toString() == 'null') ? '' : dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!.getDailyHerbicideDetailsDataList![index].gallonsOfSolution.toString(),
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
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          const Align(
                                                                            alignment:
                                                                                Alignment.topLeft,
                                                                            child:
                                                                                Text(
                                                                              "ROW WIDTH 20: ",
                                                                              textAlign: TextAlign.left,
                                                                              style: TextStyle(
                                                                                fontSize: 12,
                                                                                fontWeight: FontWeight.bold,
                                                                                color: Colors.white,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Align(
                                                                            alignment:
                                                                                Alignment.topLeft,
                                                                            child:
                                                                                Text(
                                                                              (dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!.getDailyHerbicideDetailsDataList![index].rowWith20 == null || dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!.getDailyHerbicideDetailsDataList![index].rowWith20.toString() == 'null') ? '' : dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!.getDailyHerbicideDetailsDataList![index].rowWith20.toString(),
                                                                              textAlign: TextAlign.left,
                                                                              style: const TextStyle(
                                                                                fontSize: 12,
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
                                                              const Divider(
                                                                color:
                                                                    Colors.grey,
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        left:
                                                                            8.0),
                                                                child: Row(
                                                                  children: [
                                                                    Expanded(
                                                                      // alignment: Alignment.topLeft,
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          const Align(
                                                                            alignment:
                                                                                Alignment.topLeft,
                                                                            child:
                                                                                Text(
                                                                              "ROW WIDTH 30: ",
                                                                              textAlign: TextAlign.left,
                                                                              style: TextStyle(
                                                                                fontSize: 12,
                                                                                fontWeight: FontWeight.bold,
                                                                                color: Colors.white,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Align(
                                                                            alignment:
                                                                                Alignment.topLeft,
                                                                            child:
                                                                                Text(
                                                                              (dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!.getDailyHerbicideDetailsDataList![index].rowWith30 == null || dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!.getDailyHerbicideDetailsDataList![index].rowWith30.toString() == 'null') ? '' : dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!.getDailyHerbicideDetailsDataList![index].rowWith30.toString(),
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
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          const Align(
                                                                            alignment:
                                                                                Alignment.topLeft,
                                                                            child:
                                                                                Text(
                                                                              "ROW WIDTH 40: ",
                                                                              textAlign: TextAlign.left,
                                                                              style: TextStyle(
                                                                                fontSize: 12,
                                                                                fontWeight: FontWeight.bold,
                                                                                color: Colors.white,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Align(
                                                                            alignment:
                                                                                Alignment.topLeft,
                                                                            child:
                                                                                Text(
                                                                              (dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!.getDailyHerbicideDetailsDataList![index].rowWith40 == null || dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!.getDailyHerbicideDetailsDataList![index].rowWith40.toString() == 'null') ? '' : dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!.getDailyHerbicideDetailsDataList![index].rowWith40.toString(),
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
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          const Align(
                                                                            alignment:
                                                                                Alignment.topLeft,
                                                                            child:
                                                                                Text(
                                                                              "ROW WIDTH 50: ",
                                                                              textAlign: TextAlign.left,
                                                                              style: TextStyle(
                                                                                fontSize: 12,
                                                                                fontWeight: FontWeight.bold,
                                                                                color: Colors.white,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Align(
                                                                            alignment:
                                                                                Alignment.topLeft,
                                                                            child:
                                                                                Text(
                                                                              (dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!.getDailyHerbicideDetailsDataList![index].rowWith50 == null || dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!.getDailyHerbicideDetailsDataList![index].rowWith50.toString() == 'null') ? '' : dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!.getDailyHerbicideDetailsDataList![index].rowWith50.toString(),
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
                                                              const Divider(
                                                                color:
                                                                    Colors.grey,
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        left:
                                                                            8.0),
                                                                child: Row(
                                                                  children: [
                                                                    Expanded(
                                                                      // alignment: Alignment.topLeft,
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          const Align(
                                                                            alignment:
                                                                                Alignment.topLeft,
                                                                            child:
                                                                                Text(
                                                                              "ROW WIDTH 60: ",
                                                                              textAlign: TextAlign.left,
                                                                              style: TextStyle(
                                                                                fontSize: 12,
                                                                                fontWeight: FontWeight.bold,
                                                                                color: Colors.white,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Align(
                                                                            alignment:
                                                                                Alignment.topLeft,
                                                                            child:
                                                                                Text(
                                                                              (dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!.getDailyHerbicideDetailsDataList![index].rowWith60 == null || dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!.getDailyHerbicideDetailsDataList![index].rowWith60.toString() == 'null') ? '' : dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!.getDailyHerbicideDetailsDataList![index].rowWith60.toString(),
                                                                              textAlign: TextAlign.left,
                                                                              style: const TextStyle(
                                                                                fontSize: 12,
                                                                                color: Colors.white,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      // alignment: Alignment.topLeft,
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          const Align(
                                                                            alignment:
                                                                                Alignment.topLeft,
                                                                            child:
                                                                                Text(
                                                                              "ROW WIDTH 70: ",
                                                                              textAlign: TextAlign.left,
                                                                              style: TextStyle(
                                                                                fontSize: 12,
                                                                                fontWeight: FontWeight.bold,
                                                                                color: Colors.white,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Align(
                                                                            alignment:
                                                                                Alignment.topLeft,
                                                                            child:
                                                                                Text(
                                                                              (dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!.getDailyHerbicideDetailsDataList![index].rowWith70 == null || dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!.getDailyHerbicideDetailsDataList![index].rowWith70.toString() == 'null') ? '' : dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!.getDailyHerbicideDetailsDataList![index].rowWith70.toString(),
                                                                              textAlign: TextAlign.left,
                                                                              style: const TextStyle(
                                                                                fontSize: 12,
                                                                                color: Colors.white,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      // alignment: Alignment.topLeft,
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          const Align(
                                                                            alignment:
                                                                                Alignment.topLeft,
                                                                            child:
                                                                                Text(
                                                                              "ROW WIDTH 80: ",
                                                                              textAlign: TextAlign.left,
                                                                              style: TextStyle(
                                                                                fontSize: 12,
                                                                                fontWeight: FontWeight.bold,
                                                                                color: Colors.white,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Align(
                                                                            alignment:
                                                                                Alignment.topLeft,
                                                                            child:
                                                                                Text(
                                                                              (dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!.getDailyHerbicideDetailsDataList![index].rowWith80 == null || dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!.getDailyHerbicideDetailsDataList![index].rowWith80.toString() == 'null') ? '' : dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!.getDailyHerbicideDetailsDataList![index].rowWith80.toString(),
                                                                              textAlign: TextAlign.left,
                                                                              style: const TextStyle(
                                                                                fontSize: 12,
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
                                                              const Divider(
                                                                color:
                                                                    Colors.grey,
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        left:
                                                                            8.0),
                                                                child: Row(
                                                                  children: [
                                                                    Expanded(
                                                                      // alignment: Alignment.topLeft,
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          const Align(
                                                                            alignment:
                                                                                Alignment.topLeft,
                                                                            child:
                                                                                Text(
                                                                              "ACRES PER SECTION: ",
                                                                              textAlign: TextAlign.left,
                                                                              style: TextStyle(
                                                                                fontSize: 12,
                                                                                fontWeight: FontWeight.bold,
                                                                                color: Colors.white,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Align(
                                                                            alignment:
                                                                                Alignment.topLeft,
                                                                            child:
                                                                                Text(
                                                                              (dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!.getDailyHerbicideDetailsDataList![index].acrossPerSections == null || dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!.getDailyHerbicideDetailsDataList![index].acrossPerSections.toString() == 'null') ? '' : dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!.getDailyHerbicideDetailsDataList![index].acrossPerSections.toString(),
                                                                              textAlign: TextAlign.left,
                                                                              style: const TextStyle(
                                                                                fontSize: 12,
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
                                                            ]),
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              }),
                                        ),
                                      ),
                                    ),
                                    Visibility(
                                      visible: _isVisibilityEquipment,
                                      child: Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 8.0, left: 4),
                                          child: ListView.builder(
                                              itemCount: dailyHerbicideViewModel
                                                  .dailyHerbicideGetTabularData
                                                  .data!
                                                  .getDailyHerbicideDHEQUIPMENTDataList!
                                                  .length,
                                              // itemCount: historyList.length,
                                              itemBuilder: (BuildContext ctxt,
                                                  int index) {
                                                return Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                        top: 4.0,
                                                        bottom: 4,
                                                      ),
                                                      child: Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.9,
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.15,
                                                        // margin:  EdgeInsets.only(
                                                        //     top: 5.0, bottom: 5.0, left: 2,right: 2),
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8),
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
                                                        begin:
                                                            Alignment.topLeft,
                                                        end: Alignment
                                                            .bottomRight,
                                                      ),
                                                      border: Border.all(
                                                        color: Colors.white,
                                                      ),
                                                      borderRadius:
                                                          const BorderRadius
                                                              .only(
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
                                                        child: Column(
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        left:
                                                                            8.0),
                                                                child: Row(
                                                                  children: [
                                                                    Expanded(
                                                                      // alignment: Alignment.topLeft,
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          const Align(
                                                                            alignment:
                                                                                Alignment.topLeft,
                                                                            child:
                                                                                Text(
                                                                              "EQUIPMENT: ",
                                                                              textAlign: TextAlign.left,
                                                                              style: TextStyle(
                                                                                fontSize: 12,
                                                                                fontWeight: FontWeight.bold,
                                                                                color: Colors.white,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Align(
                                                                            alignment:
                                                                                Alignment.topLeft,
                                                                            child:
                                                                                Text(
                                                                              (dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!.getDailyHerbicideDHEQUIPMENTDataList![index].equipment == null || dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!.getDailyHerbicideDHEQUIPMENTDataList![index].equipment.toString() == 'null') ? '' : dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!.getDailyHerbicideDHEQUIPMENTDataList![index].equipment.toString(),
                                                                              textAlign: TextAlign.left,
                                                                              style: const TextStyle(
                                                                                fontSize: 12,
                                                                                color: Colors.white,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      // alignment: Alignment.topLeft,
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          const Align(
                                                                            alignment:
                                                                                Alignment.topLeft,
                                                                            child:
                                                                                Text(
                                                                              "EQUIPMENT NUMBER: ",
                                                                              textAlign: TextAlign.left,
                                                                              style: TextStyle(
                                                                                fontSize: 12,
                                                                                fontWeight: FontWeight.bold,
                                                                                color: Colors.white,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Align(
                                                                            alignment:
                                                                                Alignment.topLeft,
                                                                            child:
                                                                                Text(
                                                                              (dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!.getDailyHerbicideDHEQUIPMENTDataList![index].equipmentNo == null || dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!.getDailyHerbicideDHEQUIPMENTDataList![index].equipmentNo.toString() == 'null') ? '' : dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!.getDailyHerbicideDHEQUIPMENTDataList![index].equipmentNo.toString(),
                                                                              textAlign: TextAlign.left,
                                                                              style: const TextStyle(
                                                                                fontSize: 12,
                                                                                color: Colors.white,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      // alignment: Alignment.topLeft,
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          const Align(
                                                                            alignment:
                                                                                Alignment.topLeft,
                                                                            child:
                                                                                Text(
                                                                              "QUANTITY: ",
                                                                              textAlign: TextAlign.left,
                                                                              style: TextStyle(
                                                                                fontSize: 12,
                                                                                fontWeight: FontWeight.bold,
                                                                                color: Colors.white,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Align(
                                                                            alignment:
                                                                                Alignment.topLeft,
                                                                            child:
                                                                                Text(
                                                                              (dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!.getDailyHerbicideDHEQUIPMENTDataList![index].quantity == null || dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!.getDailyHerbicideDHEQUIPMENTDataList![index].quantity.toString() == 'null') ? '' : dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!.getDailyHerbicideDHEQUIPMENTDataList![index].quantity.toString(),
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
                                                              const Divider(
                                                                color:
                                                                    Colors.grey,
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        left:
                                                                            8.0),
                                                                child: Row(
                                                                  children: [
                                                                    Expanded(
                                                                      // alignment: Alignment.topLeft,
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          const Align(
                                                                            alignment:
                                                                                Alignment.topLeft,
                                                                            child:
                                                                                Text(
                                                                              "HOURS EACH: ",
                                                                              textAlign: TextAlign.left,
                                                                              style: TextStyle(
                                                                                fontSize: 12,
                                                                                fontWeight: FontWeight.bold,
                                                                                color: Colors.white,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Align(
                                                                            alignment:
                                                                                Alignment.topLeft,
                                                                            child:
                                                                                Text(
                                                                              (dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!.getDailyHerbicideDHEQUIPMENTDataList![index].hoursEach == null || dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!.getDailyHerbicideDHEQUIPMENTDataList![index].hoursEach.toString() == 'null') ? '' : dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!.getDailyHerbicideDHEQUIPMENTDataList![index].hoursEach.toString(),
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
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          const Align(
                                                                            alignment:
                                                                                Alignment.topLeft,
                                                                            child:
                                                                                Text(
                                                                              "TOTAL HOURS: ",
                                                                              textAlign: TextAlign.left,
                                                                              style: TextStyle(
                                                                                fontSize: 12,
                                                                                fontWeight: FontWeight.bold,
                                                                                color: Colors.white,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Align(
                                                                            alignment:
                                                                                Alignment.topLeft,
                                                                            child:
                                                                                Text(
                                                                              (dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!.getDailyHerbicideDHEQUIPMENTDataList![index].totalHours == null || dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!.getDailyHerbicideDHEQUIPMENTDataList![index].totalHours.toString() == 'null') ? '' : dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!.getDailyHerbicideDHEQUIPMENTDataList![index].totalHours.toString(),
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
                                                                    const Expanded(
                                                                      // alignment: Alignment.topLeft,
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          Align(
                                                                            alignment:
                                                                                Alignment.topLeft,
                                                                            child:
                                                                                Text(
                                                                              "",
                                                                              textAlign: TextAlign.left,
                                                                              style: TextStyle(
                                                                                fontSize: 12,
                                                                                fontWeight: FontWeight.bold,
                                                                                color: Colors.white,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Align(
                                                                            alignment:
                                                                                Alignment.topLeft,
                                                                            child:
                                                                                Text(
                                                                              '',
                                                                              textAlign: TextAlign.left,
                                                                              style: TextStyle(
                                                                                fontSize: 12,
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
                                                            ]),
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              }),
                                        ),
                                      ),
                                    ),
                                    Visibility(
                                      visible: _isVisibilityLabor,
                                      child: Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 8.0, left: 4),
                                          child: ListView.builder(
                                              itemCount: dailyHerbicideViewModel
                                                  .dailyHerbicideGetTabularData
                                                  .data!
                                                  .getDailyHerbicideDHLABORDataList!
                                                  .length,
                                              // itemCount: historyList.length,
                                              itemBuilder: (BuildContext ctxt,
                                                  int index) {
                                                return Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                        top: 4.0,
                                                        bottom: 4,
                                                      ),
                                                      child: Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.9,
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.15,
                                                        // margin:  EdgeInsets.only(
                                                        //     top: 5.0, bottom: 5.0, left: 2,right: 2),
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8),
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
                                                        begin:
                                                            Alignment.topLeft,
                                                        end: Alignment
                                                            .bottomRight,
                                                      ),
                                                      border: Border.all(
                                                        color: Colors.white,
                                                      ),
                                                      borderRadius:
                                                          const BorderRadius
                                                              .only(
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
                                                        child: Column(
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        left:
                                                                            8.0),
                                                                child: Row(
                                                                  children: [
                                                                    Expanded(
                                                                      // alignment: Alignment.topLeft,
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          const Align(
                                                                            alignment:
                                                                                Alignment.topLeft,
                                                                            child:
                                                                                Text(
                                                                              "LABOR: ",
                                                                              textAlign: TextAlign.left,
                                                                              style: TextStyle(
                                                                                fontSize: 12,
                                                                                fontWeight: FontWeight.bold,
                                                                                color: Colors.white,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Align(
                                                                            alignment:
                                                                                Alignment.topLeft,
                                                                            child:
                                                                                Text(
                                                                              (dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!.getDailyHerbicideDHLABORDataList![index].labour == null || dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!.getDailyHerbicideDHLABORDataList![index].labour.toString() == 'null') ? '' : dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!.getDailyHerbicideDHLABORDataList![index].labour.toString(),
                                                                              textAlign: TextAlign.left,
                                                                              style: const TextStyle(
                                                                                fontSize: 12,
                                                                                color: Colors.white,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      // alignment: Alignment.topLeft,
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          const Align(
                                                                            alignment:
                                                                                Alignment.topLeft,
                                                                            child:
                                                                                Text(
                                                                              "QUANTITY: ",
                                                                              textAlign: TextAlign.left,
                                                                              style: TextStyle(
                                                                                fontSize: 12,
                                                                                fontWeight: FontWeight.bold,
                                                                                color: Colors.white,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Align(
                                                                            alignment:
                                                                                Alignment.topLeft,
                                                                            child:
                                                                                Text(
                                                                              (dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!.getDailyHerbicideDHLABORDataList![index].quantity == null || dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!.getDailyHerbicideDHLABORDataList![index].quantity.toString() == 'null') ? '' : dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!.getDailyHerbicideDHLABORDataList![index].quantity.toString(),
                                                                              textAlign: TextAlign.left,
                                                                              style: const TextStyle(
                                                                                fontSize: 12,
                                                                                color: Colors.white,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      // alignment: Alignment.topLeft,
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          const Align(
                                                                            alignment:
                                                                                Alignment.topLeft,
                                                                            child:
                                                                                Text(
                                                                              "HOURS EACH: ",
                                                                              textAlign: TextAlign.left,
                                                                              style: TextStyle(
                                                                                fontSize: 12,
                                                                                fontWeight: FontWeight.bold,
                                                                                color: Colors.white,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Align(
                                                                            alignment:
                                                                                Alignment.topLeft,
                                                                            child:
                                                                                Text(
                                                                              (dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!.getDailyHerbicideDHLABORDataList![index].hoursEach == null || dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!.getDailyHerbicideDHLABORDataList![index].hoursEach.toString() == 'null') ? '' : dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!.getDailyHerbicideDHLABORDataList![index].hoursEach.toString(),
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
                                                              const Divider(
                                                                color:
                                                                    Colors.grey,
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        left:
                                                                            8.0),
                                                                child: Row(
                                                                  children: [
                                                                    Expanded(
                                                                      // alignment: Alignment.topLeft,
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          const Align(
                                                                            alignment:
                                                                                Alignment.topLeft,
                                                                            child:
                                                                                Text(
                                                                              "TOTAL HOURS: ",
                                                                              textAlign: TextAlign.left,
                                                                              style: TextStyle(
                                                                                fontSize: 12,
                                                                                fontWeight: FontWeight.bold,
                                                                                color: Colors.white,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Align(
                                                                            alignment:
                                                                                Alignment.topLeft,
                                                                            child:
                                                                                Text(
                                                                              (dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!.getDailyHerbicideDHLABORDataList![index].totalHours == null || dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!.getDailyHerbicideDHLABORDataList![index].totalHours.toString() == 'null') ? '' : dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!.getDailyHerbicideDHLABORDataList![index].totalHours.toString(),
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
                                                            ]),
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              }),
                                        ),
                                      ),
                                    ),
                                    Visibility(
                                      visible: _isVisibilityTimeOfApplication,
                                      child: Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 8.0, left: 4),
                                          child: ListView.builder(
                                              itemCount: dailyHerbicideViewModel
                                                  .dailyHerbicideGetTabularData
                                                  .data!
                                                  .getDailyHerbicideDHAPPLICATIONDataList!
                                                  .length,
                                              itemBuilder: (BuildContext ctxt,
                                                  int index) {
                                                return Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                        top: 4.0,
                                                        bottom: 4,
                                                      ),
                                                      child: Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.9,
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.15,
                                                        // margin:  EdgeInsets.only(
                                                        //     top: 5.0, bottom: 5.0, left: 2,right: 2),
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8),
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
                                                        begin:
                                                            Alignment.topLeft,
                                                        end: Alignment
                                                            .bottomRight,
                                                      ),
                                                      border: Border.all(
                                                        color: Colors.white,
                                                      ),
                                                      borderRadius:
                                                          const BorderRadius
                                                              .only(
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
                                                        child: Column(
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        left:
                                                                            8.0),
                                                                child: Row(
                                                                  children: [
                                                                    Expanded(
                                                                      // alignment: Alignment.topLeft,
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          const Align(
                                                                            alignment:
                                                                                Alignment.topLeft,
                                                                            child:
                                                                                Text(
                                                                              "APPLICATION START TIME: ",
                                                                              textAlign: TextAlign.left,
                                                                              style: TextStyle(
                                                                                fontSize: 12,
                                                                                fontWeight: FontWeight.bold,
                                                                                color: Colors.white,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Align(
                                                                            alignment:
                                                                                Alignment.topLeft,
                                                                            child:
                                                                                Text(
                                                                              (dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!.getDailyHerbicideDHAPPLICATIONDataList![index].applicationStartTime == null || dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!.getDailyHerbicideDHAPPLICATIONDataList![index].applicationStartTime.toString() == 'null') ? '' : dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!.getDailyHerbicideDHAPPLICATIONDataList![index].applicationStartTime.toString(),
                                                                              textAlign: TextAlign.left,
                                                                              style: const TextStyle(
                                                                                fontSize: 12,
                                                                                color: Colors.white,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      // alignment: Alignment.topLeft,
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          const Align(
                                                                            alignment:
                                                                                Alignment.topLeft,
                                                                            child:
                                                                                Text(
                                                                              "APPLICATION END TIME: ",
                                                                              textAlign: TextAlign.left,
                                                                              style: TextStyle(
                                                                                fontSize: 12,
                                                                                fontWeight: FontWeight.bold,
                                                                                color: Colors.white,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Align(
                                                                            alignment:
                                                                                Alignment.topLeft,
                                                                            child:
                                                                                Text(
                                                                              (dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!.getDailyHerbicideDHAPPLICATIONDataList![index].applicationEndTime == null || dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!.getDailyHerbicideDHAPPLICATIONDataList![index].applicationEndTime.toString() == 'null') ? '' : dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!.getDailyHerbicideDHAPPLICATIONDataList![index].applicationEndTime.toString(),
                                                                              textAlign: TextAlign.left,
                                                                              style: const TextStyle(
                                                                                fontSize: 12,
                                                                                color: Colors.white,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      // alignment: Alignment.topLeft,
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          const Align(
                                                                            alignment:
                                                                                Alignment.topLeft,
                                                                            child:
                                                                                Text(
                                                                              "BREAK START TIME: ",
                                                                              textAlign: TextAlign.left,
                                                                              style: TextStyle(
                                                                                fontSize: 12,
                                                                                fontWeight: FontWeight.bold,
                                                                                color: Colors.white,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Align(
                                                                            alignment:
                                                                                Alignment.topLeft,
                                                                            child:
                                                                                Text(
                                                                              (dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!.getDailyHerbicideDHAPPLICATIONDataList![index].breakStartTime == null || dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!.getDailyHerbicideDHAPPLICATIONDataList![index].breakStartTime.toString() == 'null') ? '' : dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!.getDailyHerbicideDHAPPLICATIONDataList![index].breakStartTime.toString(),
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
                                                              const Divider(
                                                                color:
                                                                    Colors.grey,
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        left:
                                                                            8.0),
                                                                child: Row(
                                                                  children: [
                                                                    Expanded(
                                                                      // alignment: Alignment.topLeft,
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          const Align(
                                                                            alignment:
                                                                                Alignment.topLeft,
                                                                            child:
                                                                                Text(
                                                                              "BREAK END TIME: ",
                                                                              textAlign: TextAlign.left,
                                                                              style: TextStyle(
                                                                                fontSize: 12,
                                                                                fontWeight: FontWeight.bold,
                                                                                color: Colors.white,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Align(
                                                                            alignment:
                                                                                Alignment.topLeft,
                                                                            child:
                                                                                Text(
                                                                              (dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!.getDailyHerbicideDHAPPLICATIONDataList![index].breakEndTime == null || dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!.getDailyHerbicideDHAPPLICATIONDataList![index].breakEndTime.toString() == 'null') ? '' : dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!.getDailyHerbicideDHAPPLICATIONDataList![index].breakEndTime.toString(),
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
                                                                    const Expanded(
                                                                      // alignment: Alignment.topLeft,
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          Align(
                                                                            alignment:
                                                                                Alignment.topLeft,
                                                                            child:
                                                                                Text(
                                                                              "REASON: ",
                                                                              textAlign: TextAlign.left,
                                                                              style: TextStyle(
                                                                                fontSize: 12,
                                                                                fontWeight: FontWeight.bold,
                                                                                color: Colors.white,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Align(
                                                                            alignment:
                                                                                Alignment.topLeft,
                                                                            child:
                                                                                Text(
                                                                              "",
                                                                              textAlign: TextAlign.left,
                                                                              style: TextStyle(
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
                                                                    const Expanded(
                                                                      // alignment: Alignment.topLeft,
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          Align(
                                                                            alignment:
                                                                                Alignment.topLeft,
                                                                            child:
                                                                                Text(
                                                                              "",
                                                                              textAlign: TextAlign.left,
                                                                              style: TextStyle(
                                                                                fontSize: 12,
                                                                                fontWeight: FontWeight.bold,
                                                                                color: Colors.white,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Align(
                                                                            alignment:
                                                                                Alignment.topLeft,
                                                                            child:
                                                                                Text(
                                                                              '',
                                                                              textAlign: TextAlign.left,
                                                                              style: TextStyle(
                                                                                fontSize: 12,
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
                                                            ]),
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              }),
                                        ),
                                      ),
                                    ),
                                    Visibility(
                                      visible: _isVisibilityWeather,
                                      child: Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 8.0, left: 4),
                                          child: ListView.builder(
                                              itemCount: dailyHerbicideViewModel
                                                  .dailyHerbicideGetTabularData
                                                  .data!
                                                  .getDailyHerbicideDHWEATHERCONDITIONDataList!
                                                  .length,
                                              // itemCount: historyList.length,
                                              itemBuilder: (BuildContext ctxt,
                                                  int index) {
                                                return Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                        top: 4.0,
                                                        bottom: 4,
                                                      ),
                                                      child: Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.9,
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.15,
                                                        // margin:  EdgeInsets.only(
                                                        //     top: 5.0, bottom: 5.0, left: 2,right: 2),
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8),
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
                                                        begin:
                                                            Alignment.topLeft,
                                                        end: Alignment
                                                            .bottomRight,
                                                      ),
                                                      border: Border.all(
                                                        color: Colors.white,
                                                      ),
                                                      borderRadius:
                                                          const BorderRadius
                                                              .only(
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
                                                        child: Column(
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        left:
                                                                            8.0),
                                                                child: Row(
                                                                  children: [
                                                                    Expanded(
                                                                      // alignment: Alignment.topLeft,
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          const Align(
                                                                            alignment:
                                                                                Alignment.topLeft,
                                                                            child:
                                                                                Text(
                                                                              "TIME: ",
                                                                              textAlign: TextAlign.left,
                                                                              style: TextStyle(
                                                                                fontSize: 12,
                                                                                fontWeight: FontWeight.bold,
                                                                                color: Colors.white,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Align(
                                                                            alignment:
                                                                                Alignment.topLeft,
                                                                            child:
                                                                                Text(
                                                                              (dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!.getDailyHerbicideDHWEATHERCONDITIONDataList![index].time == null || dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!.getDailyHerbicideDHWEATHERCONDITIONDataList![index].time.toString() == 'null') ? '' : dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!.getDailyHerbicideDHWEATHERCONDITIONDataList![index].time.toString(),
                                                                              textAlign: TextAlign.left,
                                                                              style: const TextStyle(
                                                                                fontSize: 12,
                                                                                color: Colors.white,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      // alignment: Alignment.topLeft,
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          const Align(
                                                                            alignment:
                                                                                Alignment.topLeft,
                                                                            child:
                                                                                Text(
                                                                              "TEMPERATURE (F): ",
                                                                              textAlign: TextAlign.left,
                                                                              style: TextStyle(
                                                                                fontSize: 12,
                                                                                fontWeight: FontWeight.bold,
                                                                                color: Colors.white,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Align(
                                                                            alignment:
                                                                                Alignment.topLeft,
                                                                            child:
                                                                                Text(
                                                                              (dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!.getDailyHerbicideDHWEATHERCONDITIONDataList![index].temperature == null || dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!.getDailyHerbicideDHWEATHERCONDITIONDataList![index].temperature.toString() == 'null') ? '' : dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!.getDailyHerbicideDHWEATHERCONDITIONDataList![index].temperature.toString(),
                                                                              textAlign: TextAlign.left,
                                                                              style: const TextStyle(
                                                                                fontSize: 12,
                                                                                color: Colors.white,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      // alignment: Alignment.topLeft,
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          const Align(
                                                                            alignment:
                                                                                Alignment.topLeft,
                                                                            child:
                                                                                Text(
                                                                              "WIND SPEED (MPH): ",
                                                                              textAlign: TextAlign.left,
                                                                              style: TextStyle(
                                                                                fontSize: 12,
                                                                                fontWeight: FontWeight.bold,
                                                                                color: Colors.white,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Align(
                                                                            alignment:
                                                                                Alignment.topLeft,
                                                                            child:
                                                                                Text(
                                                                              (dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!.getDailyHerbicideDHWEATHERCONDITIONDataList![index].windSpeed == null || dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!.getDailyHerbicideDHWEATHERCONDITIONDataList![index].windSpeed.toString() == 'null') ? '' : dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!.getDailyHerbicideDHWEATHERCONDITIONDataList![index].windSpeed.toString(),
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
                                                              const Divider(
                                                                color:
                                                                    Colors.grey,
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        left:
                                                                            8.0),
                                                                child: Row(
                                                                  children: [
                                                                    Expanded(
                                                                      // alignment: Alignment.topLeft,
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          const Align(
                                                                            alignment:
                                                                                Alignment.topLeft,
                                                                            child:
                                                                                Text(
                                                                              "WIND DIRECTION: ",
                                                                              textAlign: TextAlign.left,
                                                                              style: TextStyle(
                                                                                fontSize: 12,
                                                                                fontWeight: FontWeight.bold,
                                                                                color: Colors.white,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Align(
                                                                            alignment:
                                                                                Alignment.topLeft,
                                                                            child:
                                                                                Text(
                                                                              (dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!.getDailyHerbicideDHWEATHERCONDITIONDataList![index].direction == null || dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!.getDailyHerbicideDHWEATHERCONDITIONDataList![index].direction.toString() == 'null') ? '' : dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!.getDailyHerbicideDHWEATHERCONDITIONDataList![index].direction.toString(),
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
                                                            ]),
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              }),
                                        ),
                                      ),
                                    ),
                                    Visibility(
                                      visible: _isVisibilityApplicants,
                                      child: Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 8.0, left: 4),
                                          child: ListView.builder(
                                              itemCount: dailyHerbicideViewModel
                                                  .dailyHerbicideGetTabularData
                                                  .data!
                                                  .getDailyHerbicideDHAPPLICANTSDataList!
                                                  .length,
                                              // itemCount: historyList.length,
                                              itemBuilder: (BuildContext ctxt,
                                                  int index) {
                                                return Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                        top: 4.0,
                                                        bottom: 4,
                                                      ),
                                                      child: Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.9,
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.1,
                                                        // margin:  EdgeInsets.only(
                                                        //     top: 5.0, bottom: 5.0, left: 2,right: 2),
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8),
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
                                                        begin:
                                                            Alignment.topLeft,
                                                        end: Alignment
                                                            .bottomRight,
                                                      ),
                                                      border: Border.all(
                                                        color: Colors.white,
                                                      ),
                                                      borderRadius:
                                                          const BorderRadius
                                                              .only(
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
                                                        child: Column(
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        left:
                                                                            8.0),
                                                                child: Row(
                                                                  children: [
                                                                    Expanded(
                                                                      // alignment: Alignment.topLeft,
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          const Align(
                                                                            alignment:
                                                                                Alignment.topLeft,
                                                                            child:
                                                                                Text(
                                                                              "APPLICANT'S NAME: ",
                                                                              textAlign: TextAlign.left,
                                                                              style: TextStyle(
                                                                                fontSize: 12,
                                                                                fontWeight: FontWeight.bold,
                                                                                color: Colors.white,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Align(
                                                                            alignment:
                                                                                Alignment.topLeft,
                                                                            child:
                                                                                Text(
                                                                              (dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!.getDailyHerbicideDHAPPLICANTSDataList![index].applicantName == null || dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!.getDailyHerbicideDHAPPLICANTSDataList![index].applicantName.toString() == 'null') ? '' : dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!.getDailyHerbicideDHAPPLICANTSDataList![index].applicantName.toString(),
                                                                              textAlign: TextAlign.left,
                                                                              style: const TextStyle(
                                                                                fontSize: 12,
                                                                                color: Colors.white,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      // alignment: Alignment.topLeft,
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          const Align(
                                                                            alignment:
                                                                                Alignment.topLeft,
                                                                            child:
                                                                                Text(
                                                                              "APPLICANT'S LICENSE NUMBER: ",
                                                                              textAlign: TextAlign.left,
                                                                              style: TextStyle(
                                                                                fontSize: 12,
                                                                                fontWeight: FontWeight.bold,
                                                                                color: Colors.white,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Align(
                                                                            alignment:
                                                                                Alignment.topLeft,
                                                                            child:
                                                                                Text(
                                                                              (dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!.getDailyHerbicideDHAPPLICANTSDataList![index].applicantLicense == null || dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!.getDailyHerbicideDHAPPLICANTSDataList![index].applicantLicense.toString() == 'null') ? '' : dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!.getDailyHerbicideDHAPPLICANTSDataList![index].applicantLicense.toString(),
                                                                              textAlign: TextAlign.left,
                                                                              style: const TextStyle(
                                                                                fontSize: 12,
                                                                                color: Colors.white,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      // alignment: Alignment.topLeft,
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          const Align(
                                                                            alignment:
                                                                                Alignment.topLeft,
                                                                            child:
                                                                                Text(
                                                                              "APPLICANT'S DIGITAL SIGNATURE: ",
                                                                              textAlign: TextAlign.left,
                                                                              style: TextStyle(
                                                                                fontSize: 12,
                                                                                fontWeight: FontWeight.bold,
                                                                                color: Colors.white,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Align(
                                                                            alignment:
                                                                                Alignment.topLeft,
                                                                            child:
                                                                                Text(
                                                                              (dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!.getDailyHerbicideDHAPPLICANTSDataList![index].applicantDigitalSignature == null || dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!.getDailyHerbicideDHAPPLICANTSDataList![index].applicantDigitalSignature.toString() == 'null') ? '' : dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!.getDailyHerbicideDHAPPLICANTSDataList![index].applicantDigitalSignature.toString(),
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
                                                            ]),
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              }),
                                        ),
                                      ),
                                    ),
                                  ]),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: InkWell(
                                          onTap: () {
                                            dailyHerbicideViewModel
                                                .fetchApproveCIVMUpdatePutListApi(
                                                    context,
                                                    widget.id,
                                                    'APPROVED');
                                            Future.delayed(
                                                const Duration(seconds: 2), () {
                                              Navigator.of(context).pop();
                                              // ignore: use_build_context_synchronously
                                              Navigator.of(context).pop();
                                              // Navigator.of(context).push(
                                              //     MaterialPageRoute(
                                              //         builder: (BuildContext
                                              //                 context) =>
                                              //             const LCPDocumentApprovalPending()));
                                            });
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(10),
                                            alignment: Alignment.center,
                                            height: size.height * 0.05,
                                            width: size.width * 0.25,
                                            decoration: const BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Color.fromARGB(
                                                      255, 1, 81, 4),
                                                  blurRadius: 5,
                                                  offset: Offset(2.0, 5.0),
                                                ),
                                              ],
                                              color: Colors.green,
                                            ),
                                            child: const Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                "Approve",
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Expanded(
                                        child: InkWell(
                                          onTap: () {
                                            dailyHerbicideViewModel
                                                .fetchApproveCIVMUpdatePutListApi(
                                                    context,
                                                    widget.id,
                                                    'REJECTED');
                                            Future.delayed(
                                                const Duration(seconds: 2), () {
                                              // Navigator.of(context).push(
                                              //     MaterialPageRoute(
                                              //         builder: (BuildContext
                                              //                 context) =>
                                              //             const LCPDocumentApprovalPending()));

                                              Navigator.of(context).pop();
                                              // ignore: use_build_context_synchronously
                                              Navigator.of(context).pop();
                                            });
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(10),
                                            alignment: Alignment.center,
                                            height: size.height * 0.05,
                                            width: size.width * 0.25,
                                            decoration: const BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Color.fromARGB(
                                                      255, 135, 10, 1),
                                                  blurRadius: 5,
                                                  offset: Offset(2.0, 5.0),
                                                ),
                                              ],
                                              color: Colors.red,
                                            ),
                                            child: const Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                "Reject",
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      alignment: Alignment.center,
                                      height: size.height * 0.05,
                                      width: size.width * 0.25,
                                      decoration: const BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Color.fromARGB(255, 135, 10, 1),
                                            blurRadius: 5,
                                            offset: Offset(2.0, 5.0),
                                          ),
                                        ],
                                        color: Colors.red,
                                      ),
                                      child: const Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Close",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
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

  setData(DailyHerbicideViewModel value) {
    _changeOrderNo.text = widget.id;

    _date.text = (dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!
                    .getDailyHerbicideDataList![0].date ==
                null ||
            dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!
                    .getDailyHerbicideDataList![0].date
                    .toString() ==
                'null')
        ? ''
        : dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!
            .getDailyHerbicideDataList![0].date
            .toString();

    _maintenanceType.text = (dailyHerbicideViewModel
                    .dailyHerbicideGetTabularData
                    .data!
                    .getDailyHerbicideDataList![0]
                    .maintenanceType ==
                null ||
            dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!
                    .getDailyHerbicideDataList![0].maintenanceType
                    .toString() ==
                'null')
        ? ''
        : dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!
            .getDailyHerbicideDataList![0].maintenanceType
            .toString();

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

    _foreman.text = (dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!
                    .getDailyHerbicideDataList![0].foreman ==
                null ||
            dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!
                    .getDailyHerbicideDataList![0].foreman
                    .toString() ==
                'null')
        ? ''
        : dailyHerbicideViewModel.dailyHerbicideGetTabularData.data!
            .getDailyHerbicideDataList![0].foreman
            .toString();

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

    _circuitNumber.text = (dailyHerbicideViewModel.dailyHerbicideGetTabularData
                    .data!.getDailyHerbicideDataList![0].circuitNo ==
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
}
