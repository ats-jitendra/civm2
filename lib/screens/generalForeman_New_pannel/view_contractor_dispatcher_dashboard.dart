import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ViewContractorDispatcherDashboard extends StatefulWidget {
  String type;
  String orderNo;
  String status;
  String substation;
  String feeder;
  String maintType;
  String contractor;
  String totalMiles;
  String contractYear;
  String cycle;
  String serviceStreetAddress;
  String serviceMapLocation;
  String adminNotes1;
  String contractorNotes;
  String adminNotes2;
  String contractorCompany;
  String dateOfInspection;
  String followUpDate;
  String costPerMile;
  String totalCost;
  String nextMaintDue;
  String createDate;
  ViewContractorDispatcherDashboard(
      {Key? key,
      required this.type,
      required this.orderNo,
      required this.status,
      required this.substation,
      required this.feeder,
      required this.maintType,
      required this.contractor,
      required this.totalMiles,
      required this.contractYear,
      required this.cycle,
      required this.serviceStreetAddress,
      required this.serviceMapLocation,
      required this.adminNotes1,
      required this.contractorNotes,
      required this.adminNotes2,
      required this.contractorCompany,
      required this.dateOfInspection,
      required this.followUpDate,
      required this.costPerMile,
      required this.totalCost,
      required this.nextMaintDue,
      required this.createDate})
      : super(key: key);

  @override
  State<ViewContractorDispatcherDashboard> createState() =>
      _ViewContractorDispatcherDashboardState();
}

class _ViewContractorDispatcherDashboardState
    extends State<ViewContractorDispatcherDashboard> {
  final TextEditingController _type = TextEditingController();
  final TextEditingController _orderNo = TextEditingController();
  final TextEditingController _status = TextEditingController();
  final TextEditingController _substation = TextEditingController();
  final TextEditingController _feeder = TextEditingController();
  final TextEditingController _maintenanceType = TextEditingController();
  final TextEditingController _contractor = TextEditingController();
  final TextEditingController _totalMiles = TextEditingController();
  final TextEditingController _contractYear = TextEditingController();
  final TextEditingController _cycle = TextEditingController();
  final TextEditingController _serviceStreetAddress = TextEditingController();
  final TextEditingController _serviceMapLocation = TextEditingController();
  final TextEditingController _adminNotes1 = TextEditingController();
  final TextEditingController _contractorNotes = TextEditingController();
  final TextEditingController _adminNotes2 = TextEditingController();
  final TextEditingController _contractorCompany = TextEditingController();
  final TextEditingController _dateOfInspection = TextEditingController();
  final TextEditingController _followUpDate = TextEditingController();
  final TextEditingController _costPerMile = TextEditingController();
  final TextEditingController _totalCost = TextEditingController();
  final TextEditingController _nextMaintDue = TextEditingController();
  final TextEditingController _createDate = TextEditingController();

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          '',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 7, 59, 120),
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
                            left: 2.0, right: 2.0, bottom: 2.0, top: 10.0),
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
                          //key: formkey4,
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
                              hintText: 'Type')),
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
                          "CONTRACTOR",
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
                          )),
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
                  const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 2.0, right: 2.0, bottom: 2.0, top: 20.0),
                        child: Text(
                          "SERVICE STREET ADDRESS",
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
                        controller: _serviceStreetAddress,
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
                            hintText: 'Service street address'),
                      ),
                    ),
                  ),
                  const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 2.0, right: 2.0, bottom: 2.0, top: 20.0),
                        child: Text(
                          "SERVICE MAP LOCATION",
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
                        controller: _serviceMapLocation,
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
                            hintText: 'Service map location'),
                      ),
                    ),
                  ),
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
                          "CONTRACTOR NOTES",
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
                        controller: _contractorNotes,
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
                          hintText: 'Contractor notes',
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
                          "ADMIN NOTES 2",
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
                        controller: _adminNotes2,
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
                          hintText: 'Admin notes 2',
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
                ],
              )),
        ),
      ),
    );
  }

  void getData() {
    _type.text = widget.type;
    _orderNo.text = widget.orderNo;
    _status.text = widget.status;
    _substation.text = widget.substation;
    _feeder.text = widget.feeder;
    _maintenanceType.text = widget.maintType;
    _contractor.text = widget.contractor;
    _totalMiles.text = widget.totalMiles;
    _contractYear.text = widget.contractYear;
    _cycle.text = widget.cycle;
    _serviceStreetAddress.text = widget.serviceStreetAddress;
    _serviceMapLocation.text = widget.serviceMapLocation;
    _adminNotes1.text = widget.adminNotes1;
    _contractorNotes.text = widget.contractorNotes;
    _adminNotes2.text = widget.adminNotes2;
    _contractorCompany.text = widget.contractorCompany;
    _dateOfInspection.text = widget.dateOfInspection;
    _followUpDate.text = widget.followUpDate;
    _costPerMile.text = widget.costPerMile;
    _totalCost.text = widget.totalCost;
    _nextMaintDue.text = widget.nextMaintDue;
    _createDate.text = widget.createDate;
  }
}
