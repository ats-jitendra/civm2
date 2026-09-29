import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ViewChangeOrder extends StatefulWidget {
  String orderNo;
  String substation;
  String feeder;
  String maintenanceType;
  String totalMiles;
  String costPerMile;
  String totalCost;
  String contractor;
  String type;
  String contractYear;
  String cycle;
  String nextMaintDue;
  String contractorCompany;
  String status;
  String? dailyHerbicideApplication;
  String? ivmTimesheet;
  String? mixingInventory;
  String serviceStreetAddress;
  String serviceMapLocation;
  String adminNotes1;
  String dateOfInspection;
  String followUpDate;
  String createDate;

  ViewChangeOrder({
    Key? key,
    required this.orderNo,
    required this.substation,
    required this.feeder,
    required this.maintenanceType,
    required this.totalMiles,
    required this.costPerMile,
    required this.totalCost,
    required this.type,
    required this.contractor,
    required this.contractYear,
    required this.cycle,
    required this.nextMaintDue,
    required this.contractorCompany,
    required this.status,
    required this.dailyHerbicideApplication,
    required this.ivmTimesheet,
    required this.mixingInventory,
    required this.serviceStreetAddress,
    required this.serviceMapLocation,
    required this.adminNotes1,
    required this.dateOfInspection,
    required this.followUpDate,
    required this.createDate,
  }) : super(key: key);

  @override
  State<ViewChangeOrder> createState() => _ViewChangeOrderState();
}

class _ViewChangeOrderState extends State<ViewChangeOrder> {
  final TextEditingController _type = TextEditingController();
  final TextEditingController _orderNo = TextEditingController();
  final TextEditingController _status = TextEditingController();
  final TextEditingController _substation = TextEditingController();
  final TextEditingController _feeder = TextEditingController();
  final TextEditingController _maintenanceType = TextEditingController();
  final TextEditingController _totalMiles = TextEditingController();
  final TextEditingController _contractYear = TextEditingController();
  final TextEditingController _cycle = TextEditingController();
  final TextEditingController _serviceStreetAddress = TextEditingController();
  final TextEditingController _serviceMapLocation = TextEditingController();
  final TextEditingController _adminNotes1 = TextEditingController();
  final TextEditingController _contractorCompany = TextEditingController();
  final TextEditingController _dateOfInspection = TextEditingController();
  final TextEditingController _followUpDate = TextEditingController();
  final TextEditingController _costPerMile = TextEditingController();
  final TextEditingController _totalCost = TextEditingController();
  final TextEditingController _nextMaintDue = TextEditingController();
  final TextEditingController _createDate = TextEditingController();
  final TextEditingController _contractor = TextEditingController();

  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() {
    _orderNo.text = widget.orderNo;
    _substation.text = widget.substation;
    _feeder.text = widget.feeder;
    _maintenanceType.text = widget.maintenanceType;
    _totalMiles.text = widget.totalMiles;
    _costPerMile.text = widget.costPerMile;
    _totalCost.text = widget.totalCost;
    _type.text = widget.type;
    _contractYear.text = widget.contractYear;
    _cycle.text = widget.cycle;
    _nextMaintDue.text = widget.nextMaintDue;
    _contractor.text = widget.contractor;
    _contractorCompany.text = widget.contractorCompany;
    _status.text = widget.status;
    // _dailyHerbicideApplication.text = widget.dailyHerbicideApplication;
    // _ivmTimesheet.text = widget.ivmTimesheet;
    // _mixingInventory.text = widget.mixingInventory;
    _serviceStreetAddress.text = widget.serviceStreetAddress;
    _serviceMapLocation.text = widget.serviceMapLocation;
    _adminNotes1.text = widget.adminNotes1;
    _dateOfInspection.text = widget.dateOfInspection;
    _followUpDate.text = widget.followUpDate;
    _createDate.text = widget.createDate;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 7, 59, 120),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
              margin:
                  const EdgeInsets.only(left: 8, right: 8, top: 14, bottom: 8),
              padding: const EdgeInsets.all(8),
              alignment: Alignment.center,
              width: size.width * 0.99,
              decoration: BoxDecoration(
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
                    decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Color.fromARGB(255, 3, 47, 97),
                              blurRadius: 5,
                              offset: Offset(2.0, 5.0))
                        ],
                        gradient: LinearGradient(
                          colors: [
                            Color.fromARGB(255, 7, 59, 120),
                            Color.fromARGB(255, 7, 59, 120)
                          ],
                        )),
                    child: const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "VIEW ADD NEW ROW MAINTENANCE PLAN",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      const Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 2.0, right: 2.0, bottom: 2.0, top: 20.0),
                            child: Text(
                              "JOB NO",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 7, 59, 120),
                                  fontWeight: FontWeight.bold),
                            ),
                          )),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: TextFormField(
                            enabled: false,
                            //key: formkey4,
                            controller: _orderNo,
                            style: const TextStyle(
                                color: Color.fromARGB(255, 7, 59, 120),
                                fontSize: 16),
                            obscureText: false,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(255, 7, 59, 120),
                                  ),
                                ),
                                disabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(255, 7, 59, 120),
                                  ),
                                ),
                                hintText: 'Job No'),
                          ),
                        ),
                      ),

                      const Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 2.0, right: 2.0, bottom: 2.0, top: 20.0),
                            child: Text(
                              "SUBSTATION",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 7, 59, 120),
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
                            controller: _substation,
                            style: const TextStyle(
                                color: Color.fromARGB(255, 7, 59, 120),
                                fontSize: 16),
                            obscureText: false,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(255, 7, 59, 120),
                                  ),
                                ),
                                disabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(255, 7, 59, 120),
                                  ),
                                ),
                                hintText: 'Substation'),
                          ),
                        ),
                      ),
                      const Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 2.0, right: 2.0, bottom: 2.0, top: 20.0),
                            child: Text(
                              "FEEDER",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 7, 59, 120),
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
                            controller: _feeder,
                            style: const TextStyle(
                                color: Color.fromARGB(255, 7, 59, 120),
                                fontSize: 16),
                            obscureText: false,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(255, 7, 59, 120),
                                  ),
                                ),
                                disabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(255, 7, 59, 120),
                                  ),
                                ),
                                hintText: 'Feeder'),
                          ),
                        ),
                      ),
                     
                      const Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 2.0, right: 2.0, bottom: 2.0, top: 20.0),
                            child: Text(
                              "MAINTENANCE TYPE",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 7, 59, 120),
                                  fontWeight: FontWeight.bold),
                            ),
                          )),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: TextFormField(
                            minLines: 3,
                            maxLines: 5,
                            enabled: false,
                            //  key: formkey5,
                            controller: _type,
                            style: const TextStyle(
                                color: Color.fromARGB(255, 7, 59, 120),
                                fontSize: 16),
                            obscureText: false,
                            keyboardType: TextInputType.number,

                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromARGB(255, 7, 59, 120),
                                ),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromARGB(255, 7, 59, 120),
                                ),
                              ),
                              hintText: 'Type',
                            ),
                          ),
                        ),
                      ),





                       const Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 2.0, right: 2.0, bottom: 2.0, top: 20.0),
                            child: Text(
                              "TYPE",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 7, 59, 120),
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
                            controller: _maintenanceType,
                            style: const TextStyle(
                                color: Color.fromARGB(255, 7, 59, 120),
                                fontSize: 16),
                            obscureText: false,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(255, 7, 59, 120),
                                  ),
                                ),
                                disabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(255, 7, 59, 120),
                                  ),
                                ),
                                hintText: 'Maintenance Type'),
                          ),
                        ),
                      ),

                      const Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 2.0, right: 2.0, bottom: 2.0, top: 20.0),
                            child: Text(
                              "TOTAL MILES",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 7, 59, 120),
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
                              controller: _totalMiles,
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 7, 59, 120),
                                  fontSize: 16),
                              obscureText: false,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color.fromARGB(255, 7, 59, 120),
                                    ),
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color.fromARGB(255, 7, 59, 120),
                                    ),
                                  ),
                                  hintText: 'Total Miles')),
                        ),
                      ),
                      const Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 2.0, right: 2.0, bottom: 2.0, top: 20.0),
                            child: Text(
                              "COST PER MILE",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 7, 59, 120),
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
                            controller: _costPerMile,
                            style: const TextStyle(
                                color: Color.fromARGB(255, 7, 59, 120),
                                fontSize: 16),
                            obscureText: false,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromARGB(255, 7, 59, 120),
                                ),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromARGB(255, 7, 59, 120),
                                ),
                              ),
                              hintText: 'Cost per mile',
                            ),
                          ),
                        ),
                      ),
                      const Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 2.0, right: 2.0, bottom: 2.0, top: 20.0),
                            child: Text(
                              "TOTAL COST",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 7, 59, 120),
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
                            controller: _totalCost,
                            style: const TextStyle(
                                color: Color.fromARGB(255, 7, 59, 120),
                                fontSize: 16),
                            obscureText: false,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromARGB(255, 7, 59, 120),
                                ),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromARGB(255, 7, 59, 120),
                                ),
                              ),
                              hintText: 'Total cost',
                            ),
                          ),
                        ),
                      ),
                      const Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 2.0, right: 2.0, bottom: 2.0, top: 20.0),
                            child: Text(
                              "ASSIGN FOREMAN",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 7, 59, 120),
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
                                color: Color.fromARGB(255, 7, 59, 120),
                                fontSize: 16),
                            obscureText: false,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(255, 7, 59, 120),
                                  ),
                                ),
                                disabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(255, 7, 59, 120),
                                  ),
                                ),
                                hintText: 'Contractor'),
                          ),
                        ),
                      ),
                      const Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 2.0, right: 2.0, bottom: 2.0, top: 20.0),
                            child: Text(
                              "CONTRACT YEAR",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 7, 59, 120),
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
                              controller: _contractYear,
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 7, 59, 120),
                                  fontSize: 16),
                              obscureText: false,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color.fromARGB(255, 7, 59, 120),
                                    ),
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color.fromARGB(255, 7, 59, 120),
                                    ),
                                  ),
                                  hintText: 'Contract Year')),
                        ),
                      ),
                      const Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 2.0, right: 2.0, bottom: 2.0, top: 20.0),
                            child: Text(
                              "CYCLE",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 7, 59, 120),
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
                            controller: _cycle,
                            style: const TextStyle(
                                color: Color.fromARGB(255, 7, 59, 120),
                                fontSize: 16),
                            obscureText: false,
                            keyboardType: TextInputType.number,

                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromARGB(255, 7, 59, 120),
                                ),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromARGB(255, 7, 59, 120),
                                ),
                              ),
                              hintText: 'Cycle',
                            ),
                          ),
                        ),
                      ),

                      const Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 2.0, right: 2.0, bottom: 2.0, top: 20.0),
                            child: Text(
                              "NEXT MAINT DUE",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 7, 59, 120),
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
                            controller: _nextMaintDue,
                            style: const TextStyle(
                                color: Color.fromARGB(255, 7, 59, 120),
                                fontSize: 16),
                            obscureText: false,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromARGB(255, 7, 59, 120),
                                ),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromARGB(255, 7, 59, 120),
                                ),
                              ),
                              hintText: 'Next maint due',
                            ),
                          ),
                        ),
                      ),
                      const Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 2.0, right: 2.0, bottom: 2.0, top: 20.0),
                            child: Text(
                              "CONTRACTOR COMPANY",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 7, 59, 120),
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
                            controller: _contractorCompany,
                            style: const TextStyle(
                                color: Color.fromARGB(255, 7, 59, 120),
                                fontSize: 16),
                            obscureText: false,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromARGB(255, 7, 59, 120),
                                ),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromARGB(255, 7, 59, 120),
                                ),
                              ),
                              hintText: 'Contractor company',
                            ),
                          ),
                        ),
                      ),
                      const Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 2.0, right: 2.0, bottom: 2.0, top: 20.0),
                            child: Text(
                              "STATUS",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 7, 59, 120),
                                  fontWeight: FontWeight.bold),
                            ),
                          )),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: TextFormField(
                            enabled: false,
                            //key: formkey4,
                            controller: _status,
                            style: const TextStyle(
                                color: Color.fromARGB(255, 7, 59, 120),
                                fontSize: 16),
                            obscureText: false,
                            keyboardType: TextInputType.number,

                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(255, 7, 59, 120),
                                  ),
                                ),
                                disabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(255, 7, 59, 120),
                                  ),
                                ),
                                hintText: 'Status'),
                          ),
                        ),
                      ),
                      // const Align(
                      //     alignment: Alignment.centerLeft,
                      //     child: Padding(
                      //       padding: EdgeInsets.only(
                      //           left: 2.0, right: 2.0, bottom: 2.0, top: 20.0),
                      //       child: Text(
                      //         "DAILY HERBICIDE APPLICATION",
                      //         style: TextStyle(
                      //             fontSize: 16,
                      //             color: Color.fromARGB(255, 7, 59, 120),
                      //             fontWeight: FontWeight.bold),
                      //       ),
                      //     )),
                      // Align(
                      //   alignment: Alignment.centerRight,
                      //   child: Padding(
                      //     padding: const EdgeInsets.all(2.0),
                      //     child: TextFormField(
                      //       enabled: false,
                      //       //key: formkey4,
                      //       controller: _dailyHerbicideApplication,
                      //       style: const TextStyle(
                      //           color: Color.fromARGB(255, 7, 59, 120),
                      //           fontSize: 16),
                      //       obscureText: false,
                      //       keyboardType: TextInputType.number,

                      //       decoration: const InputDecoration(
                      //           border: OutlineInputBorder(),
                      //           enabledBorder: OutlineInputBorder(
                      //             borderSide: BorderSide(
                      //               color: Color.fromARGB(255, 7, 59, 120),
                      //             ),
                      //           ),
                      //           disabledBorder: OutlineInputBorder(
                      //             borderSide: BorderSide(
                      //               color: Color.fromARGB(255, 7, 59, 120),
                      //             ),
                      //           ),
                      //           hintText: 'Daily herbicide application'),
                      //     ),
                      //   ),
                      // ),
                      // const Align(
                      //     alignment: Alignment.centerLeft,
                      //     child: Padding(
                      //       padding: EdgeInsets.only(
                      //           left: 2.0, right: 2.0, bottom: 2.0, top: 20.0),
                      //       child: Text(
                      //         "IVM TIMESHEET",
                      //         style: TextStyle(
                      //             fontSize: 16,
                      //             color: Color.fromARGB(255, 7, 59, 120),
                      //             fontWeight: FontWeight.bold),
                      //       ),
                      //     )),
                      // Align(
                      //   alignment: Alignment.centerRight,
                      //   child: Padding(
                      //     padding: const EdgeInsets.all(2.0),
                      //     child: TextFormField(
                      //       enabled: false,
                      //       //key: formkey4,
                      //       controller: _ivmTimesheet,
                      //       style: const TextStyle(
                      //           color: Color.fromARGB(255, 7, 59, 120),
                      //           fontSize: 16),
                      //       obscureText: false,
                      //       keyboardType: TextInputType.number,

                      //       decoration: const InputDecoration(
                      //           border: OutlineInputBorder(),
                      //           enabledBorder: OutlineInputBorder(
                      //             borderSide: BorderSide(
                      //               color: Color.fromARGB(255, 7, 59, 120),
                      //             ),
                      //           ),
                      //           disabledBorder: OutlineInputBorder(
                      //             borderSide: BorderSide(
                      //               color: Color.fromARGB(255, 7, 59, 120),
                      //             ),
                      //           ),
                      //           hintText: 'IVM timesheet'),
                      //     ),
                      //   ),
                      // ),
                      // const Align(
                      //     alignment: Alignment.centerLeft,
                      //     child: Padding(
                      //       padding: EdgeInsets.only(
                      //           left: 2.0, right: 2.0, bottom: 2.0, top: 20.0),
                      //       child: Text(
                      //         "MIXING INVENTORY",
                      //         style: TextStyle(
                      //             fontSize: 16,
                      //             color: Color.fromARGB(255, 7, 59, 120),
                      //             fontWeight: FontWeight.bold),
                      //       ),
                      //     )),
                      // Align(
                      //   alignment: Alignment.centerRight,
                      //   child: Padding(
                      //     padding: const EdgeInsets.all(2.0),
                      //     child: TextFormField(
                      //       enabled: false,
                      //       //key: formkey4,
                      //       controller: _mixingInventory,
                      //       style: const TextStyle(
                      //           color: Color.fromARGB(255, 7, 59, 120),
                      //           fontSize: 16),
                      //       obscureText: false,
                      //       keyboardType: TextInputType.number,

                      //       decoration: const InputDecoration(
                      //           border: OutlineInputBorder(),
                      //           enabledBorder: OutlineInputBorder(
                      //             borderSide: BorderSide(
                      //               color: Color.fromARGB(255, 7, 59, 120),
                      //             ),
                      //           ),
                      //           disabledBorder: OutlineInputBorder(
                      //             borderSide: BorderSide(
                      //               color: Color.fromARGB(255, 7, 59, 120),
                      //             ),
                      //           ),
                      //           hintText: 'Mixing inventory'),
                      //     ),
                      //   ),
                      // ),
                      // const Align(
                      //     alignment: Alignment.centerLeft,
                      //     child: Padding(
                      //       padding: EdgeInsets.only(
                      //           left: 2.0, right: 2.0, bottom: 2.0, top: 20.0),
                      //       child: Text(
                      //         "SERVICE STREET ADDRESS",
                      //         style: TextStyle(
                      //             fontSize: 16,
                      //             color: Color.fromARGB(255, 7, 59, 120),
                      //             fontWeight: FontWeight.bold),
                      //       ),
                      //     )),
                      // Align(
                      //   alignment: Alignment.centerRight,
                      //   child: Padding(
                      //     padding: const EdgeInsets.all(2.0),
                      //     child: TextFormField(
                      //       enabled: false,
                      //       //  key: formkey5,
                      //       controller: _serviceStreetAddress,
                      //       style: const TextStyle(
                      //           color: Color.fromARGB(255, 7, 59, 120),
                      //           fontSize: 16),
                      //       obscureText: false,
                      //       keyboardType: TextInputType.number,
                      //       decoration: const InputDecoration(
                      //           border: OutlineInputBorder(),
                      //           enabledBorder: OutlineInputBorder(
                      //             borderSide: BorderSide(
                      //               color: Color.fromARGB(255, 7, 59, 120),
                      //             ),
                      //           ),
                      //           disabledBorder: OutlineInputBorder(
                      //             borderSide: BorderSide(
                      //               color: Color.fromARGB(255, 7, 59, 120),
                      //             ),
                      //           ),
                      //           hintText: 'Service street address'),
                      //     ),
                      //   ),
                      // ),
                      // const Align(
                      //     alignment: Alignment.centerLeft,
                      //     child: Padding(
                      //       padding: EdgeInsets.only(
                      //           left: 2.0, right: 2.0, bottom: 2.0, top: 20.0),
                      //       child: Text(
                      //         "SERVICE MAP LOCATION",
                      //         style: TextStyle(
                      //             fontSize: 16,
                      //             color: Color.fromARGB(255, 7, 59, 120),
                      //             fontWeight: FontWeight.bold),
                      //       ),
                      //     )),
                      // Align(
                      //   alignment: Alignment.centerRight,
                      //   child: Padding(
                      //     padding: const EdgeInsets.all(2.0),
                      //     child: TextFormField(
                      //       enabled: false,
                      //       //  key: formkey5,
                      //       controller: _serviceMapLocation,
                      //       style: const TextStyle(
                      //           color: Color.fromARGB(255, 7, 59, 120),
                      //           fontSize: 16),
                      //       obscureText: false,
                      //       keyboardType: TextInputType.number,
                      //       decoration: const InputDecoration(
                      //           border: OutlineInputBorder(),
                      //           enabledBorder: OutlineInputBorder(
                      //             borderSide: BorderSide(
                      //               color: Color.fromARGB(255, 7, 59, 120),
                      //             ),
                      //           ),
                      //           disabledBorder: OutlineInputBorder(
                      //             borderSide: BorderSide(
                      //               color: Color.fromARGB(255, 7, 59, 120),
                      //             ),
                      //           ),
                      //           hintText: 'Service map location'),
                      //     ),
                      //   ),
                      // ),
                      const Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 2.0, right: 2.0, bottom: 2.0, top: 20.0),
                            child: Text(
                              "ADMIN NOTES 1",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 7, 59, 120),
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
                              controller: _adminNotes1,
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 7, 59, 120),
                                  fontSize: 16),
                              obscureText: false,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(255, 7, 59, 120),
                                  ),
                                ),
                                disabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(255, 7, 59, 120),
                                  ),
                                ),
                                hintText: 'Admin Notes 1',
                              )),
                        ),
                      ),

                      const Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 2.0, right: 2.0, bottom: 2.0, top: 20.0),
                            child: Text(
                              "DATE OF INSPECTION",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 7, 59, 120),
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
                            controller: _dateOfInspection,
                            style: const TextStyle(
                                color: Color.fromARGB(255, 7, 59, 120),
                                fontSize: 16),
                            obscureText: false,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromARGB(255, 7, 59, 120),
                                ),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromARGB(255, 7, 59, 120),
                                ),
                              ),
                              hintText: 'Date of inspection',
                            ),
                          ),
                        ),
                      ),
                      const Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 2.0, right: 2.0, bottom: 2.0, top: 20.0),
                            child: Text(
                              "FOLLOW UP DATE",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 7, 59, 120),
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
                            controller: _followUpDate,
                            style: const TextStyle(
                                color: Color.fromARGB(255, 7, 59, 120),
                                fontSize: 16),
                            obscureText: false,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromARGB(255, 7, 59, 120),
                                ),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromARGB(255, 7, 59, 120),
                                ),
                              ),
                              hintText: 'Follow up date',
                            ),
                          ),
                        ),
                      ),

                      const Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 2.0, right: 2.0, bottom: 2.0, top: 20.0),
                            child: Text(
                              "CREATE DATE",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 7, 59, 120),
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
                            controller: _createDate,
                            style: const TextStyle(
                                color: Color.fromARGB(255, 7, 59, 120),
                                fontSize: 16),
                            obscureText: false,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromARGB(255, 7, 59, 120),
                                ),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromARGB(255, 7, 59, 120),
                                ),
                              ),
                              hintText: 'Create date',
                            ),
                          ),
                        ),
                      ),

                      // InkWell(
                      //   onTap: () {},
                      //   child: Align(
                      //     alignment: Alignment.centerLeft,
                      //     child: Container(
                      //       margin: const EdgeInsets.only(top: 15, left: 4),
                      //       padding: const EdgeInsets.all(8),
                      //       alignment: Alignment.centerLeft,
                      //       width: 80,
                      //       // MediaQuery.of(context).size.width,
                      //       // height: MediaQuery.of(context).size.height * 0.4,
                      //       decoration: const BoxDecoration(
                      //           // shape: BoxShape.circle,

                      //           color: Color.fromARGB(255, 0, 58, 106),
                      //           gradient: LinearGradient(
                      //             colors: [
                      //               Color.fromARGB(255, 0, 79, 215),
                      //               Colors.blue,
                      //               Color.fromARGB(255, 0, 79, 215),
                      //             ],
                      //           )),
                      //       child: const Align(
                      //         alignment: Alignment.center,
                      //         child: Text(
                      //           "VIEW MAP",
                      //           style: TextStyle(
                      //             color: Colors.white,
                      //             fontWeight: FontWeight.bold,
                      //             fontSize: 10,
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
