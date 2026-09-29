import 'package:CIVM/data/response/status.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../view_model/ivm_timeSheet_view_model.dart';

// ignore: must_be_immutable
class IVMTimeSheetWithOutEditOptionContractor extends StatefulWidget {
  String id;
  IVMTimeSheetWithOutEditOptionContractor({Key? key, required this.id})
      : super(key: key);

  @override
  State<IVMTimeSheetWithOutEditOptionContractor> createState() =>
      _IVMTimeSheetWithOutEditOptionContractorState();
}

class _IVMTimeSheetWithOutEditOptionContractorState
    extends State<IVMTimeSheetWithOutEditOptionContractor> {
  final TextEditingController _changeOrderNo = TextEditingController();
  final TextEditingController _date = TextEditingController();
  final TextEditingController _contractor = TextEditingController();
  final TextEditingController _crewNumber = TextEditingController();
  final TextEditingController _jobNumber = TextEditingController();

  final TextEditingController _weekendDate = TextEditingController();
  final TextEditingController _generalForeman = TextEditingController();
  final TextEditingController _foreman = TextEditingController();
  final TextEditingController _foremanTwo = TextEditingController();
  final TextEditingController _contractorTwo = TextEditingController();
  final TextEditingController _pesticide = TextEditingController();
  final TextEditingController _remarks = TextEditingController();

  final TextEditingController _personnelName = TextEditingController();
  final TextEditingController _personnelType = TextEditingController();
  final TextEditingController _value = TextEditingController();
  final TextEditingController _estimatedValue = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  bool _isVisibilityEmployee = true;
  bool _isVisibilityEquipment = false;
  bool _isVisibilityActivity = false;

  bool isEmployeeSelected = true;
  bool isEquipmentSelected = false;
  bool isActivitiesSelected = false;

  int sum = 0;
  int flag = 0;

  IvmTimeSheetViewModel ivmTimeSheetViewModel = IvmTimeSheetViewModel();

  @override
  void initState() {
    ivmTimeSheetViewModel.fetchivmTimeSheetTabularListApi(context, widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text(
            'IVM TIMESHEET',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: const Color.fromARGB(255, 7, 59, 120),
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
                      //  CustomToastSnackBarProgressDialog.flushBarErrorMessage(
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
                  setData(value);
                  return SingleChildScrollView(
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
                                              "CONTRACTOR",
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
                                            controller: _contractor,
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
                                            controller: _crewNumber,
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
                                              "WEEKEND DATE",
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
                                            controller: _weekendDate,
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
                                              hintText: 'weekend date',
                                            ),
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return "Please enter weekend date";
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
                                              "GENERAL FOREMAN",
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
                                            controller: _generalForeman,
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
                                            controller: _contractorTwo,
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
                                            controller: _pesticide,
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
                                              hintText: 'pesticide lic number',
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
                                            enabled: false,
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
                                              disabledBorder:
                                                  OutlineInputBorder(
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
                                            enabled: false,
                                            //  key: formkey5,
                                            controller: _foremanTwo,
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
                                              "PERSONNEL NAME",
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
                                            controller: _personnelName,
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
                                              hintText: 'personnel name',
                                            ),
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return "Please enter personnel name";
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
                                              "PERSONNEL TYPE",
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
                                            controller: _personnelType,
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
                                              hintText: 'personnel type',
                                            ),
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return "Please enter personnel type";
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
                                              "VALUE",
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
                                            controller: _value,
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
                                            controller: _estimatedValue,
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
                              const Column(
                                children: [
                                  // Row(
                                  //   children: [
                                  //     Expanded(
                                  //       child: Container(
                                  //         padding: const EdgeInsets.all(10),
                                  //         alignment: Alignment.center,
                                  //         decoration: const BoxDecoration(
                                  //           boxShadow: [
                                  //             BoxShadow(
                                  //               color: Color.fromARGB(
                                  //                   255, 135, 10, 1),
                                  //               blurRadius: 5,
                                  //               offset: Offset(2.0, 5.0),
                                  //             ),
                                  //           ],
                                  //           // Use a ternary operator to set the background color based on the selection state
                                  //           color: Colors.red,
                                  //         ),
                                  //         child: const Align(
                                  //           alignment: Alignment.center,
                                  //           child: Text(
                                  //             "IVM TIMESHEET PRINT",
                                  //             textAlign: TextAlign.left,
                                  //             style: TextStyle(
                                  //               color: Colors.white,
                                  //               fontWeight: FontWeight.bold,
                                  //               fontSize: 16,
                                  //             ),
                                  //           ),
                                  //         ),
                                  //       ),
                                  //     ),
                                  //     const SizedBox(width: 8),
                                  //     Expanded(
                                  //       child: Container(
                                  //         padding: const EdgeInsets.all(10),
                                  //         alignment: Alignment.center,
                                  //         decoration: const BoxDecoration(
                                  //           boxShadow: [
                                  //             BoxShadow(
                                  //               color: Color.fromARGB(
                                  //                   255, 135, 10, 1),
                                  //               blurRadius: 5,
                                  //               offset: Offset(2.0, 5.0),
                                  //             ),
                                  //           ],
                                  //           // Use a ternary operator to set the background color based on the selection state
                                  //           color: Colors.red,
                                  //         ),
                                  //         child: const Align(
                                  //           alignment: Alignment.center,
                                  //           child: Text(
                                  //             "EMPLOYEE TIMESHEET PRINT",
                                  //             textAlign: TextAlign.left,
                                  //             style: TextStyle(
                                  //               color: Colors.white,
                                  //               fontWeight: FontWeight.bold,
                                  //               fontSize: 16,
                                  //             ),
                                  //           ),
                                  //         ),
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),
                                ],
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
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () {
                                              _isVisibilityEmployee = true;
                                              _isVisibilityEquipment = false;
                                              _isVisibilityActivity = false;
                                              setState(() {
                                                isEmployeeSelected = true;
                                                isActivitiesSelected = false;
                                                isEquipmentSelected = false;
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
                                                color: isEmployeeSelected
                                                    ? const Color.fromARGB(
                                                        255, 5, 119, 249)
                                                    : const Color.fromARGB(
                                                        255, 7, 59, 120),
                                              ),
                                              child: const Align(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  "Employees",
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
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: GestureDetector(
                                              onTap: () {
                                                _isVisibilityEmployee = false;
                                                _isVisibilityEquipment = true;
                                                _isVisibilityActivity = false;
                                                setState(() {
                                                  // Toggle the color and selection state
                                                  isEquipmentSelected = true;
                                                  isActivitiesSelected = false;
                                                  isEmployeeSelected = false;
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
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: GestureDetector(
                                              onTap: () {
                                                _isVisibilityEmployee = false;
                                                _isVisibilityEquipment = false;
                                                _isVisibilityActivity = true;
                                                setState(() {
                                                  // isActivitiesSelected =
                                                  //     !isActivitiesSelected;
                                                  isActivitiesSelected = true;
                                                  isEquipmentSelected = false;
                                                  isEmployeeSelected = false;
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
                                                  color: isActivitiesSelected
                                                      ? const Color.fromARGB(
                                                          255, 5, 119, 249)
                                                      : const Color.fromARGB(
                                                          255, 7, 59, 120),
                                                ),
                                                child: const Align(
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    "Activities",
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
                                        ),
                                      ],
                                    ),
                                    Visibility(
                                      visible: _isVisibilityEmployee,
                                      child: Expanded(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8.0),
                                          child: ListView.builder(
                                              itemCount: ivmTimeSheetViewModel
                                                  .ivmTimeSheetGetTabularData
                                                  .data!
                                                  .getPOWERTIMEREPORTEMPLOYEESDataList!
                                                  .length,
                                              // itemCount: historyList.length,
                                              itemBuilder: (BuildContext ctxt,
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
                                                            0.3,
                                                        // height: 190,
                                                        margin: const EdgeInsets
                                                            .only(
                                                            left: 4.0,
                                                            top: 5.0,
                                                            bottom: 5.0),
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
                                                                  color: const Color
                                                                      .fromARGB(
                                                                      255,
                                                                      7,
                                                                      59,
                                                                      120),
                                                                ),
                                                                borderRadius: const BorderRadius
                                                                    .only(
                                                                    topLeft: Radius
                                                                        .circular(
                                                                            10),
                                                                    bottomLeft:
                                                                        Radius.circular(
                                                                            10))),
                                                        child: Column(
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
                                                                        "EMPLOYEE N0.: ",
                                                                        textAlign:
                                                                            TextAlign.left,
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .topLeft,
                                                                      child:
                                                                          Text(
                                                                        (ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!.getPOWERTIMEREPORTEMPLOYEESDataList![index].empNo == null ||
                                                                                ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!.getPOWERTIMEREPORTEMPLOYEESDataList![index].empNo.toString() == 'null')
                                                                            ? ''
                                                                            : ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!.getPOWERTIMEREPORTEMPLOYEESDataList![index].empNo.toString(),
                                                                        textAlign:
                                                                            TextAlign.left,
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
                                                                // alignment: Alignment.topLeft,
                                                                child: Column(
                                                                  children: [
                                                                    const Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .topLeft,
                                                                      child:
                                                                          Text(
                                                                        "EMPLOYEE NAME: ",
                                                                        textAlign:
                                                                            TextAlign.left,
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .topLeft,
                                                                      child:
                                                                          Text(
                                                                        (ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!.getPOWERTIMEREPORTEMPLOYEESDataList![index].empName == null ||
                                                                                ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!.getPOWERTIMEREPORTEMPLOYEESDataList![index].empName.toString() == 'null')
                                                                            ? ''
                                                                            : ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!.getPOWERTIMEREPORTEMPLOYEESDataList![index].empName.toString(),
                                                                        textAlign:
                                                                            TextAlign.left,
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
                                                                      alignment:
                                                                          Alignment
                                                                              .topLeft,
                                                                      child:
                                                                          Text(
                                                                        "OTHER CREW:",
                                                                        textAlign:
                                                                            TextAlign.left,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                12,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            color: Colors.white),
                                                                      ),
                                                                    ),
                                                                    Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .topLeft,
                                                                      child:
                                                                          Text(
                                                                        (ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!.getPOWERTIMEREPORTEMPLOYEESDataList![index].otherCew == null ||
                                                                                ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!.getPOWERTIMEREPORTEMPLOYEESDataList![index].otherCew.toString() == 'null')
                                                                            ? ''
                                                                            : ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!.getPOWERTIMEREPORTEMPLOYEESDataList![index].otherCew.toString(),
                                                                        textAlign:
                                                                            TextAlign.left,
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
                                                            0.3,
                                                        margin: const EdgeInsets
                                                            .only(
                                                            right: 4.0,
                                                            top: 5.0,
                                                            bottom: 5.0),
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8),
                                                        decoration:
                                                            BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                border:
                                                                    Border.all(
                                                                  color: const Color
                                                                      .fromARGB(
                                                                      255,
                                                                      7,
                                                                      59,
                                                                      120),
                                                                ),
                                                                borderRadius: const BorderRadius
                                                                    .only(
                                                                    topRight: Radius
                                                                        .circular(
                                                                            10),
                                                                    bottomRight:
                                                                        Radius.circular(
                                                                            10))),
                                                        child: Column(
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  const Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .topLeft,
                                                                    child: Text(
                                                                      "CLASS CODE: ",
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        color: Color.fromARGB(
                                                                            255,
                                                                            7,
                                                                            59,
                                                                            120),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .topLeft,
                                                                    child: Text(
                                                                      (ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!.getPOWERTIMEREPORTEMPLOYEESDataList![index].classCode == null ||
                                                                              ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!.getPOWERTIMEREPORTEMPLOYEESDataList![index].classCode.toString() ==
                                                                                  'null')
                                                                          ? ''
                                                                          : ivmTimeSheetViewModel
                                                                              .ivmTimeSheetGetTabularData
                                                                              .data!
                                                                              .getPOWERTIMEREPORTEMPLOYEESDataList![index]
                                                                              .classCode
                                                                              .toString(),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                      style:
                                                                          const TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        //  fontWeight:
                                                                        //      FontWeight.bold,
                                                                        color: Color.fromARGB(
                                                                            255,
                                                                            7,
                                                                            59,
                                                                            120),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Expanded(
                                                                child: ListView
                                                                    .builder(
                                                                        itemCount: ivmTimeSheetViewModel
                                                                            .ivmTimeSheetGetTabularData
                                                                            .data!
                                                                            .getPOWERTIMEREPORTEMPLOYEESDataList![
                                                                                index]
                                                                            .getEMPWORKINGDATAByEmpNumberAndEmpNameAndClassCodeAndotherCewDataList!
                                                                            .length,
                                                                        itemBuilder:
                                                                            (BuildContext ctxt,
                                                                                int i) {
                                                                          return Row(
                                                                            children: [
                                                                              Container(
                                                                                width: MediaQuery.of(context).size.width * 0.52,
                                                                                // height: MediaQuery.of(context).size.height * 0.2,
                                                                                margin: const EdgeInsets.only(right: 4.0, top: 5.0, bottom: 5.0),
                                                                                padding: const EdgeInsets.all(8),
                                                                                decoration: BoxDecoration(
                                                                                    color: const Color.fromARGB(255, 7, 59, 120),
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
                                                                                        child: Row(
                                                                                          children: [
                                                                                            Expanded(
                                                                                              // alignment: Alignment.topLeft,
                                                                                              child: Column(
                                                                                                children: [
                                                                                                  const Align(
                                                                                                    alignment: Alignment.topLeft,
                                                                                                    child: Text(
                                                                                                      "DAY: ",
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
                                                                                                      (ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!.getPOWERTIMEREPORTEMPLOYEESDataList![index].getEMPWORKINGDATAByEmpNumberAndEmpNameAndClassCodeAndotherCewDataList![i].day == null || ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!.getPOWERTIMEREPORTEMPLOYEESDataList![index].getEMPWORKINGDATAByEmpNumberAndEmpNameAndClassCodeAndotherCewDataList![i].day.toString() == 'null') ? '' : ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!.getPOWERTIMEREPORTEMPLOYEESDataList![index].getEMPWORKINGDATAByEmpNumberAndEmpNameAndClassCodeAndotherCewDataList![i].day.toString(),
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
                                                                                                      "HOURS: ",
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
                                                                                                      (ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!.getPOWERTIMEREPORTEMPLOYEESDataList![index].getEMPWORKINGDATAByEmpNumberAndEmpNameAndClassCodeAndotherCewDataList![i].hours == null || ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!.getPOWERTIMEREPORTEMPLOYEESDataList![index].getEMPWORKINGDATAByEmpNumberAndEmpNameAndClassCodeAndotherCewDataList![i].hours.toString() == 'null') ? '' : ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!.getPOWERTIMEREPORTEMPLOYEESDataList![index].getEMPWORKINGDATAByEmpNumberAndEmpNameAndClassCodeAndotherCewDataList![i].hours.toString(),
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
                                                                                                    alignment: Alignment.topLeft,
                                                                                                    child: Text(
                                                                                                      "MORNING IN: ",
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
                                                                                                      (ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!.getPOWERTIMEREPORTEMPLOYEESDataList![index].getEMPWORKINGDATAByEmpNumberAndEmpNameAndClassCodeAndotherCewDataList![i].mIn == null || ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!.getPOWERTIMEREPORTEMPLOYEESDataList![index].getEMPWORKINGDATAByEmpNumberAndEmpNameAndClassCodeAndotherCewDataList![i].mIn.toString() == 'null') ? '' : ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!.getPOWERTIMEREPORTEMPLOYEESDataList![index].getEMPWORKINGDATAByEmpNumberAndEmpNameAndClassCodeAndotherCewDataList![i].mIn.toString(),
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
                                                                                                      "MORNING OUT: ",
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
                                                                                                      (ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!.getPOWERTIMEREPORTEMPLOYEESDataList![index].getEMPWORKINGDATAByEmpNumberAndEmpNameAndClassCodeAndotherCewDataList![i].mOut == null || ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!.getPOWERTIMEREPORTEMPLOYEESDataList![index].getEMPWORKINGDATAByEmpNumberAndEmpNameAndClassCodeAndotherCewDataList![i].mOut.toString() == 'null') ? '' : ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!.getPOWERTIMEREPORTEMPLOYEESDataList![index].getEMPWORKINGDATAByEmpNumberAndEmpNameAndClassCodeAndotherCewDataList![i].mOut.toString(),
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
                                                                                                    alignment: Alignment.topLeft,
                                                                                                    child: Text(
                                                                                                      "AFTERNOON IN: ",
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
                                                                                                      (ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!.getPOWERTIMEREPORTEMPLOYEESDataList![index].getEMPWORKINGDATAByEmpNumberAndEmpNameAndClassCodeAndotherCewDataList![i].eIn == null || ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!.getPOWERTIMEREPORTEMPLOYEESDataList![index].getEMPWORKINGDATAByEmpNumberAndEmpNameAndClassCodeAndotherCewDataList![i].eIn.toString() == 'null') ? '' : ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!.getPOWERTIMEREPORTEMPLOYEESDataList![index].getEMPWORKINGDATAByEmpNumberAndEmpNameAndClassCodeAndotherCewDataList![i].eIn.toString(),
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
                                                                                                      "AFTERNOON OUT: ",
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
                                                                                                      (ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!.getPOWERTIMEREPORTEMPLOYEESDataList![index].getEMPWORKINGDATAByEmpNumberAndEmpNameAndClassCodeAndotherCewDataList![i].eOut == null || ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!.getPOWERTIMEREPORTEMPLOYEESDataList![index].getEMPWORKINGDATAByEmpNumberAndEmpNameAndClassCodeAndotherCewDataList![i].eOut.toString() == 'null') ? '' : ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!.getPOWERTIMEREPORTEMPLOYEESDataList![index].getEMPWORKINGDATAByEmpNumberAndEmpNameAndClassCodeAndotherCewDataList![i].eOut.toString(),
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
                                      ),
                                    ),
                                    Visibility(
                                      visible: _isVisibilityEquipment,
                                      child: Expanded(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8.0),
                                          child: ListView.builder(
                                              itemCount: ivmTimeSheetViewModel
                                                  .ivmTimeSheetGetTabularData
                                                  .data!
                                                  .getPOWERTIMEREPORTEQUIPMENTSDataList!
                                                  .length,
                                              itemBuilder: (BuildContext ctxt,
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
                                                            0.3,
                                                        // height: 190,
                                                        margin: const EdgeInsets
                                                            .only(
                                                            left: 4.0,
                                                            top: 5.0,
                                                            bottom: 5.0),
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
                                                                  color: const Color
                                                                      .fromARGB(
                                                                      255,
                                                                      7,
                                                                      59,
                                                                      120),
                                                                ),
                                                                borderRadius: const BorderRadius
                                                                    .only(
                                                                    topLeft: Radius
                                                                        .circular(
                                                                            10),
                                                                    bottomLeft:
                                                                        Radius.circular(
                                                                            10))),
                                                        child: Column(
                                                            children: [
                                                              Expanded(
                                                                flex: 2,
                                                                // alignment: Alignment.topLeft,
                                                                child: Column(
                                                                  children: [
                                                                    const Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .topLeft,
                                                                      child:
                                                                          Text(
                                                                        "EQUIPMENT TYPE: ",
                                                                        textAlign:
                                                                            TextAlign.left,
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .topLeft,
                                                                      child:
                                                                          Text(
                                                                        (ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!.getPOWERTIMEREPORTEQUIPMENTSDataList![index].equipmentType == null ||
                                                                                ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!.getPOWERTIMEREPORTEQUIPMENTSDataList![index].equipmentType.toString() == 'null')
                                                                            ? ''
                                                                            : ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!.getPOWERTIMEREPORTEQUIPMENTSDataList![index].equipmentType.toString(),
                                                                        textAlign:
                                                                            TextAlign.left,
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
                                                                flex: 1,
                                                                // alignment: Alignment.topLeft,
                                                                child: Column(
                                                                  children: [
                                                                    const Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .topLeft,
                                                                      child:
                                                                          Text(
                                                                        "EQUIPMENT CODE: ",
                                                                        textAlign:
                                                                            TextAlign.left,
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .topLeft,
                                                                      child:
                                                                          Text(
                                                                        (ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!.getPOWERTIMEREPORTEQUIPMENTSDataList![index].reportId == null ||
                                                                                ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!.getPOWERTIMEREPORTEQUIPMENTSDataList![index].reportId.toString() == 'null')
                                                                            ? ''
                                                                            : ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!.getPOWERTIMEREPORTEQUIPMENTSDataList![index].reportId.toString(),
                                                                        textAlign:
                                                                            TextAlign.left,
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
                                                                flex: 1,
                                                                child: Column(
                                                                  children: [
                                                                    const Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .topLeft,
                                                                      child:
                                                                          Text(
                                                                        "OTHER CREW:",
                                                                        textAlign:
                                                                            TextAlign.left,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                12,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            color: Colors.white),
                                                                      ),
                                                                    ),
                                                                    Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .topLeft,
                                                                      child:
                                                                          Text(
                                                                        (ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!.getPOWERTIMEREPORTEQUIPMENTSDataList![index].otherEquipment == null ||
                                                                                ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!.getPOWERTIMEREPORTEQUIPMENTSDataList![index].otherEquipment.toString() == 'null')
                                                                            ? ''
                                                                            : ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!.getPOWERTIMEREPORTEQUIPMENTSDataList![index].otherEquipment.toString(),
                                                                        textAlign:
                                                                            TextAlign.left,
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
                                                            0.3,
                                                        margin: const EdgeInsets
                                                            .only(
                                                            right: 4.0,
                                                            top: 5.0,
                                                            bottom: 5.0),
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8),
                                                        decoration:
                                                            BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                border:
                                                                    Border.all(
                                                                  color: const Color
                                                                      .fromARGB(
                                                                      255,
                                                                      7,
                                                                      59,
                                                                      120),
                                                                ),
                                                                borderRadius: const BorderRadius
                                                                    .only(
                                                                    topRight: Radius
                                                                        .circular(
                                                                            10),
                                                                    bottomRight:
                                                                        Radius.circular(
                                                                            10))),
                                                        child: Column(
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Expanded(
                                                                    child: Row(
                                                                      children: [
                                                                        Expanded(
                                                                          // alignment: Alignment.topLeft,
                                                                          child:
                                                                              Column(
                                                                            children: [
                                                                              const Align(
                                                                                alignment: Alignment.topLeft,
                                                                                child: Text(
                                                                                  "CLASS CODE: ",
                                                                                  textAlign: TextAlign.left,
                                                                                  style: TextStyle(
                                                                                    fontSize: 12,
                                                                                    fontWeight: FontWeight.bold,
                                                                                    color: Color.fromARGB(255, 7, 59, 120),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              Align(
                                                                                alignment: Alignment.topLeft,
                                                                                child: Text(
                                                                                  (ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!.getPOWERTIMEREPORTEQUIPMENTSDataList![index].code == null || ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!.getPOWERTIMEREPORTEQUIPMENTSDataList![index].code.toString() == 'null') ? '' : ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!.getPOWERTIMEREPORTEQUIPMENTSDataList![index].code.toString(),
                                                                                  textAlign: TextAlign.left,
                                                                                  style: const TextStyle(
                                                                                    fontSize: 12,
                                                                                    //  fontWeight:
                                                                                    //      FontWeight.bold,
                                                                                    color: Color.fromARGB(255, 7, 59, 120),
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
                                                                                alignment: Alignment.topLeft,
                                                                                child: Text(
                                                                                  "RATE: ",
                                                                                  textAlign: TextAlign.left,
                                                                                  style: TextStyle(
                                                                                    fontSize: 12,
                                                                                    fontWeight: FontWeight.bold,
                                                                                    color: Color.fromARGB(255, 7, 59, 120),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              Align(
                                                                                alignment: Alignment.topLeft,
                                                                                child: Text(
                                                                                  (ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!.getPOWERTIMEREPORTEQUIPMENTSDataList![index].equipmentsRatesValue == null || ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!.getPOWERTIMEREPORTEQUIPMENTSDataList![index].equipmentsRatesValue.toString() == 'null') ? '' : ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!.getPOWERTIMEREPORTEQUIPMENTSDataList![index].equipmentsRatesValue.toString(),
                                                                                  textAlign: TextAlign.left,
                                                                                  style: const TextStyle(
                                                                                    fontSize: 12,
                                                                                    //  fontWeight:
                                                                                    //      FontWeight.bold,
                                                                                    color: Color.fromARGB(255, 7, 59, 120),
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
                                                                child: ListView
                                                                    .builder(
                                                                        itemCount: ivmTimeSheetViewModel
                                                                            .ivmTimeSheetGetTabularData
                                                                            .data!
                                                                            .getPOWERTIMEREPORTEQUIPMENTSDataList![
                                                                                index]
                                                                            .getSubPOWERTIMEREPORTEQUIPMENTSOfDayHrsList!
                                                                            .length,
                                                                        itemBuilder:
                                                                            (BuildContext ctxt,
                                                                                int i) {
                                                                          if (flag ==
                                                                              0) {
                                                                            sum =
                                                                                0;
                                                                            for (int i = 0;
                                                                                i < ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!.getPOWERTIMEREPORTEQUIPMENTSDataList![index].getSubPOWERTIMEREPORTEQUIPMENTSOfDayHrsList!.length;
                                                                                i++) {
                                                                              int hours = int.tryParse(ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!.getPOWERTIMEREPORTEQUIPMENTSDataList![index].getSubPOWERTIMEREPORTEQUIPMENTSOfDayHrsList![i].hours.toString()) ?? 0;
                                                                              sum += hours;
                                                                              flag = 1;
                                                                            }
                                                                          }

                                                                          return Row(
                                                                            children: [
                                                                              Container(
                                                                                width: MediaQuery.of(context).size.width * 0.52,
                                                                                height: MediaQuery.of(context).size.height * 0.13,
                                                                                margin: const EdgeInsets.only(right: 4.0, top: 5.0, bottom: 5.0),
                                                                                padding: const EdgeInsets.all(8),
                                                                                decoration: BoxDecoration(
                                                                                    color: const Color.fromARGB(255, 7, 59, 120),
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
                                                                                        child: Row(
                                                                                          children: [
                                                                                            Expanded(
                                                                                              // alignment: Alignment.topLeft,
                                                                                              child: Column(
                                                                                                children: [
                                                                                                  const Align(
                                                                                                    alignment: Alignment.topLeft,
                                                                                                    child: Text(
                                                                                                      "DAY: ",
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
                                                                                                      (ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!.getPOWERTIMEREPORTEQUIPMENTSDataList![index].getSubPOWERTIMEREPORTEQUIPMENTSOfDayHrsList![i].day == null || ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!.getPOWERTIMEREPORTEQUIPMENTSDataList![index].getSubPOWERTIMEREPORTEQUIPMENTSOfDayHrsList![i].day.toString() == 'null') ? '' : ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!.getPOWERTIMEREPORTEQUIPMENTSDataList![index].getSubPOWERTIMEREPORTEQUIPMENTSOfDayHrsList![i].day.toString(),
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
                                                                                                      "HOURS: ",
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
                                                                                                      (ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!.getPOWERTIMEREPORTEQUIPMENTSDataList![index].getSubPOWERTIMEREPORTEQUIPMENTSOfDayHrsList![i].hours == null || ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!.getPOWERTIMEREPORTEQUIPMENTSDataList![index].getSubPOWERTIMEREPORTEQUIPMENTSOfDayHrsList![i].hours.toString() == 'null') ? '' : ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!.getPOWERTIMEREPORTEQUIPMENTSDataList![index].getSubPOWERTIMEREPORTEQUIPMENTSOfDayHrsList![i].hours.toString(),
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
                                                                                                    alignment: Alignment.topLeft,
                                                                                                    child: Text(
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
                                                                                                    alignment: Alignment.topLeft,
                                                                                                    child: Text(
                                                                                                      sum.toString(),
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
                                      ),
                                    ),
                                    Visibility(
                                      visible: _isVisibilityActivity,
                                      child: Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 8.0, left: 4),
                                          child: ListView.builder(
                                              itemCount: ivmTimeSheetViewModel
                                                  .ivmTimeSheetGetTabularData
                                                  .data!
                                                  .getLCPTIMEREPORTACTIVITIESDataList!
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
                                                        // height: MediaQuery.of(
                                                        //             context)
                                                        //         .size
                                                        //         .height *
                                                        //     0.4,
                                                        // margin:  EdgeInsets.only(
                                                        //     top: 5.0, bottom: 5.0, left: 2,right: 2),
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
                                                                              "DAY OF WEEK: ",
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
                                                                              (ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!.getLCPTIMEREPORTACTIVITIESDataList![index].dayOfWeek == null || ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!.getLCPTIMEREPORTACTIVITIESDataList![index].dayOfWeek.toString() == 'null') ? '' : ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!.getLCPTIMEREPORTACTIVITIESDataList![index].dayOfWeek.toString(),
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
                                                                              "SUBSTATION ID: ",
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
                                                                              (ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!.getLCPTIMEREPORTACTIVITIESDataList![index].substationId == null || ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!.getLCPTIMEREPORTACTIVITIESDataList![index].substationId.toString() == 'null') ? '' : ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!.getLCPTIMEREPORTACTIVITIESDataList![index].substationId.toString(),
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
                                                                              "FEEDER ID: ",
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
                                                                              (ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!.getLCPTIMEREPORTACTIVITIESDataList![index].feederId == null || ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!.getLCPTIMEREPORTACTIVITIESDataList![index].feederId.toString() == 'null') ? '' : ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!.getLCPTIMEREPORTACTIVITIESDataList![index].feederId.toString(),
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
                                                                              "WORK TYPE: ",
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
                                                                              (ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!.getLCPTIMEREPORTACTIVITIESDataList![index].workType == null || ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!.getLCPTIMEREPORTACTIVITIESDataList![index].workType.toString() == 'null') ? '' : ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!.getLCPTIMEREPORTACTIVITIESDataList![index].workType.toString(),
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
                                                                              "ACCOUNT/WO NUMBER: ",
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
                                                                              (ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!.getLCPTIMEREPORTACTIVITIESDataList![index].accountNo == null || ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!.getLCPTIMEREPORTACTIVITIESDataList![index].accountNo.toString() == 'null') ? '' : ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!.getLCPTIMEREPORTACTIVITIESDataList![index].accountNo.toString(),
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
                                                                              "MAP NUMBER: ",
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
                                                                              (ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!.getLCPTIMEREPORTACTIVITIESDataList![index].mapNumber == null || ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!.getLCPTIMEREPORTACTIVITIESDataList![index].mapNumber.toString() == 'null') ? '' : ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!.getLCPTIMEREPORTACTIVITIESDataList![index].mapNumber.toString(),
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
                                                                              "SECTION ADDRESS: ",
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
                                                                              (ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!.getLCPTIMEREPORTACTIVITIESDataList![index].sectionAddress == null || ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!.getLCPTIMEREPORTACTIVITIESDataList![index].sectionAddress.toString() == 'null') ? '' : ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!.getLCPTIMEREPORTACTIVITIESDataList![index].sectionAddress.toString(),
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
                                                                              " POLE NUMBER: ",
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
                                                                              (ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!.getLCPTIMEREPORTACTIVITIESDataList![index].poleNumber == null || ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!.getLCPTIMEREPORTACTIVITIESDataList![index].poleNumber.toString() == 'null') ? '' : ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!.getLCPTIMEREPORTACTIVITIESDataList![index].poleNumber.toString(),
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
                                                                              "NOTES ACTIVITY CODE: ",
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
                                                                              (ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!.getLCPTIMEREPORTACTIVITIESDataList![index].notesActivityCode == null || ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!.getLCPTIMEREPORTACTIVITIESDataList![index].notesActivityCode.toString() == 'null') ? '' : ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!.getLCPTIMEREPORTACTIVITIESDataList![index].notesActivityCode.toString(),
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
                                                                              "MAN HOURS: ",
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
                                                                              (ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!.getLCPTIMEREPORTACTIVITIESDataList![index].manHours == null || ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!.getLCPTIMEREPORTACTIVITIESDataList![index].manHours.toString() == 'null') ? '' : ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!.getLCPTIMEREPORTACTIVITIESDataList![index].manHours.toString(),
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
                                                                              "SPANS: ",
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
                                                                              (ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!.getLCPTIMEREPORTACTIVITIESDataList![index].spans == null || ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!.getLCPTIMEREPORTACTIVITIESDataList![index].spans.toString() == 'null') ? '' : ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!.getLCPTIMEREPORTACTIVITIESDataList![index].spans.toString(),
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
                                                                              "LENGTH: ",
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
                                                                              (ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!.getLCPTIMEREPORTACTIVITIESDataList![index].lengths == null || ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!.getLCPTIMEREPORTACTIVITIESDataList![index].lengths.toString() == 'null') ? '' : ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!.getLCPTIMEREPORTACTIVITIESDataList![index].lengths.toString(),
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
                                                                              "WIDTH: ",
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
                                                                              (ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!.getLCPTIMEREPORTACTIVITIESDataList![index].widths == null || ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!.getLCPTIMEREPORTACTIVITIESDataList![index].widths.toString() == 'null') ? '' : ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!.getLCPTIMEREPORTACTIVITIESDataList![index].widths.toString(),
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
                                                                              "CHEMICAL CODE: ",
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
                                                                              (ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!.getLCPTIMEREPORTACTIVITIESDataList![index].chemicalCode == null || ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!.getLCPTIMEREPORTACTIVITIESDataList![index].chemicalCode.toString() == 'null') ? '' : ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!.getLCPTIMEREPORTACTIVITIESDataList![index].chemicalCode.toString(),
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
                                                                              "CHEMICAL QUANTITY: ",
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
                                                                              (ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!.getLCPTIMEREPORTACTIVITIESDataList![index].chemicalQuantity == null || ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!.getLCPTIMEREPORTACTIVITIESDataList![index].chemicalQuantity.toString() == 'null') ? '' : ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!.getLCPTIMEREPORTACTIVITIESDataList![index].chemicalQuantity.toString(),
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
                  );

                default:
                  return const Text('data');
              }
            })));
  }

  setData(IvmTimeSheetViewModel value) {
    _changeOrderNo.text = widget.id;

    _date.text = (ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!
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

    _weekendDate.text = (ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!
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

    _pesticide.text = (ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!
                    .getLAKECOUNTRYPOWERTIMEREPORTDataList![0].pesticiedLicNo ==
                null ||
            ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!
                    .getLAKECOUNTRYPOWERTIMEREPORTDataList![0].pesticiedLicNo
                    .toString() ==
                'null')
        ? ''
        : ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!
            .getLAKECOUNTRYPOWERTIMEREPORTDataList![0].pesticiedLicNo
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
    _personnelName.text = (ivmTimeSheetViewModel
                    .ivmTimeSheetGetTabularData
                    .data!
                    .getLAKECOUNTRYPOWERTIMEREPORTDataList![0]
                    .personnelName ==
                null ||
            ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!
                    .getLAKECOUNTRYPOWERTIMEREPORTDataList![0].personnelName
                    .toString() ==
                'null')
        ? ''
        : ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!
            .getLAKECOUNTRYPOWERTIMEREPORTDataList![0].personnelName
            .toString();

    _personnelType.text = (ivmTimeSheetViewModel
                    .ivmTimeSheetGetTabularData
                    .data!
                    .getLAKECOUNTRYPOWERTIMEREPORTDataList![0]
                    .personnelType ==
                null ||
            ivmTimeSheetViewModel.ivmTimeSheetGetTabularData.data!
                    .getLAKECOUNTRYPOWERTIMEREPORTDataList![0].personnelType
                    .toString() ==
                'null')
        ? ''
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
}
