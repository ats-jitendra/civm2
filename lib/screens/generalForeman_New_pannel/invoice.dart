import 'dart:io';
import 'package:CIVM/data/response/status.dart';
import 'package:CIVM/screens/generalForeman_New_pannel/view_invoice.dart';
import 'package:CIVM/view_model/invoice_create_invoice_view_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class Invoice extends StatefulWidget {
  String changeOrderNo;

  Invoice({
    Key? key,
    required this.changeOrderNo,
  }) : super(key: key);

  @override
  State<Invoice> createState() => _InvoiceState();
}

class _InvoiceState extends State<Invoice> {
  // int _currentIndex = 0;
  // final List<Widget> _children = [
  //   RowMaintenancePlan(),
  //   // BottomNavigationHomePage(),
  //   // BottomNavigationAccountPage()
  // ];

  final TextEditingController _invoiceNo = TextEditingController();
  final TextEditingController _invoiceTotal = TextEditingController();
  final TextEditingController _labourTotal = TextEditingController();

  List<InvoiceCard> invoiceCards = [];

  // ignore: non_constant_identifier_names
  final select_noOfResources = [
    'SELECT HERE',
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
  String? noOfResources = 'SELECT HERE';

  // ignore: prefer_typing_uninitialized_variables
  var selectedChangeOrder;

  // ignore: non_constant_identifier_names
  final select_employeeType = [
    'Engineer',
    'Line Switchman',
    'Trouble Lineman',
    'Line Helper Driver/Trouble',
    'Trouble Lineman Foreman'
  ];
  // ignore: non_constant_identifier_names
  // String? employeeType;

  File? image;

  InvoiceCreateInvoiceViewModel invoiceCreateInvoiceViewModel =
      InvoiceCreateInvoiceViewModel();

  onTappedBar(int index) {
    setState(() {
      // _currentIndex = index;
    });
  }

  String datetime = DateTime.now().toString();
  DateTime date1 = DateTime.now();
  late String dateSelected1 = DateFormat('MM-dd-yyyy').format(DateTime.now());
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

  final _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    invoiceCreateInvoiceViewModel.fetchInvoiceGetDataApi(context);
    setData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text(
            'Invoice',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: const Color.fromARGB(255, 7, 59, 120),
        ),
        body: ChangeNotifierProvider<InvoiceCreateInvoiceViewModel>(
            create: (BuildContext context) => invoiceCreateInvoiceViewModel,
            child: Consumer<InvoiceCreateInvoiceViewModel>(
                builder: (context, value, _) {
              switch (value.ivoiceGetData.status) {
                case Status.LOADING:
                  return const Center(child: CircularProgressIndicator());
                case Status.ERROR:
                  return
                      // CustomToastSnackBarProgressDialog.flushBarErrorMessage(
                      //     value.ivoiceGetData.message.toString(), context);
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
                  return RefreshIndicator(
                    onRefresh: () async {
                      await invoiceCreateInvoiceViewModel
                          .fetchInvoiceGetDataApi(context);
                      setData();
                    },
                    child: SingleChildScrollView(
                        child: Column(children: [
                      Form(
                        key: _formkey,
                        child: Container(
                          margin: const EdgeInsets.only(
                              left: 8, right: 8, top: 10, bottom: 8),
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
                              const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 2.0,
                                        right: 2.0,
                                        bottom: 2.0,
                                        top: 20.0),
                                    child: Text(
                                      "INVOICE NO",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color:
                                              Color.fromARGB(255, 7, 59, 120),
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: TextFormField(
                                    enabled: false,
                                    controller: _invoiceNo,
                                    style: const TextStyle(
                                        color: Color.fromARGB(255, 7, 59, 120),
                                        fontSize: 16),
                                    obscureText: false,
                                    // keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(
                                          // borderRadius: BorderRadius.circular(25),
                                          ),
                                      disabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color:
                                              Color.fromARGB(255, 7, 59, 120),
                                        ),
                                        // borderRadius: BorderRadius.circular(25),
                                      ),
                                      hintText: 'Enter Invoice No',
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Please enter Invoice No";
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
                                        top: 20.0),
                                    child: Text(
                                      "JOB NO",
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          color:
                                              Color.fromARGB(255, 7, 59, 120),
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: SizedBox(
                                  child: DropdownButtonFormField<String>(
                                    hint: const Text('-Select-'),
                                    dropdownColor: Colors.white,
                                    value: selectedChangeOrder,
                                    style: const TextStyle(
                                        color: Color.fromARGB(255, 7, 59, 120),
                                        fontSize: 16),
                                    icon: const Icon(
                                      Icons.arrow_drop_down,
                                      color: Color.fromARGB(255, 7, 59, 120),
                                      size: 40,
                                    ),
                                    decoration: const InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color:
                                              Color.fromARGB(255, 7, 59, 120),
                                        ),
                                        // borderRadius: BorderRadius.circular(25),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color:
                                              Color.fromARGB(255, 7, 59, 120),
                                        ),
                                        // borderRadius: BorderRadius.circular(25),
                                      ),
                                    ),
                                    isExpanded: true,
                                    items: invoiceCreateInvoiceViewModel
                                        .ivoiceGetData
                                        .data!
                                        .findAllIdByStatusClosedList!
                                        .map((e) {
                                      return DropdownMenuItem(
                                        value: e.id.toString(),
                                        // e.getIdAndSubstationByCountId![0].subStation.toString(),
                                        child: Text(e.id.toString()),
                                      );
                                    }).toList(),
                                    onChanged: (val) {
                                      setState(() {
                                        selectedChangeOrder = val;
                                      });
                                    },
                                    validator: (value) =>
                                        value == null ? 'field required' : null,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 4.0, right: 4, top: 20),
                                child: Column(
                                  children: [
                                    const Align(
                                        alignment: Alignment.centerLeft,
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                            left: 2.0,
                                            right: 2.0,
                                          ),
                                          child: Text(
                                            "DATE",
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                color: Color.fromARGB(
                                                    255, 7, 59, 120),
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )),
                                    Container(
                                      height: 60,
                                      width: size.width * 0.99,
                                      decoration: const BoxDecoration(
                                          // shape: BoxShape.circle,
                                          boxShadow: [],
                                          gradient: LinearGradient(
                                            colors: [
                                              Color.fromARGB(255, 7, 59, 120),
                                              Color.fromARGB(255, 7, 59, 120),
                                            ],
                                          )),
                                      child: Padding(
                                        padding: const EdgeInsets.all(1.0),
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
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 2),
                                                        child: IconButton(
                                                          icon: const Icon(Icons
                                                              .calendar_month),
                                                          iconSize: 22,
                                                          color: const Color
                                                              .fromARGB(
                                                              255, 7, 59, 120),
                                                          onPressed: () {
                                                            selectDate(context);
                                                            // print(date);
                                                          },
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 2),
                                                        child: Text(
                                                            dateSelected1,
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 16,
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
                                  ],
                                ),
                              ),
                              const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 2.0,
                                        right: 2.0,
                                        bottom: 2.0,
                                        top: 20.0),
                                    child: Text(
                                      "NO OF RESOURCES WORKED ON MAINTENANCE *",
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          color:
                                              Color.fromARGB(255, 7, 59, 120),
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: DropdownButtonFormField<String>(
                                    hint: const Text('-Select-'),
                                    dropdownColor: Colors.white,
                                    value: noOfResources,
                                    style: const TextStyle(
                                        color: Color.fromARGB(255, 7, 59, 120),
                                        fontSize: 16),
                                    icon: const Icon(
                                      Icons.arrow_drop_down,
                                      color: Color.fromARGB(255, 7, 59, 120),
                                      size: 40,
                                    ),
                                    decoration: const InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color:
                                              Color.fromARGB(255, 7, 59, 120),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color:
                                              Color.fromARGB(255, 7, 59, 120),
                                        ),
                                      ),
                                    ),
                                    isExpanded: true,
                                    items: select_noOfResources
                                        .map(buildMenuItem)
                                        .toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        noOfResources = value;
                                      });
                                      createResourceControllerList(
                                          int.parse(value.toString()));
                                    },
                                    validator: (value) =>
                                        value == null ? 'field required' : null,
                                  ),
                                ),
                              ),
                              // (int.parse(noOfResources.toString()) > 0)
                              noOfResources.toString() != 'SELECT HERE'
                                  ? Container(
                                      margin: const EdgeInsets.only(
                                          left: 8,
                                          right: 8,
                                          top: 20,
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
                                          itemCount: int.parse(
                                              noOfResources.toString()),
                                          itemBuilder:
                                              (BuildContext ctxt, int index) {
                                            return Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 4.0,
                                                          bottom: 4,
                                                          left: 4),
                                                  child: Container(
                                                    width: size.width * 0.83,
                                                    padding:
                                                        const EdgeInsets.all(8),
                                                    decoration: BoxDecoration(
                                                        color: const Color
                                                            .fromARGB(
                                                            255, 7, 59, 120),
                                                        border: Border.all(
                                                          color: Colors.white,
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
                                                          topLeft:
                                                              Radius.circular(
                                                                  10),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  10),
                                                        )),
                                                    child: Column(children: [
                                                      Row(
                                                        children: [
                                                          Expanded(
                                                            child: Align(
                                                              alignment: Alignment
                                                                  .centerRight,
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        2.0),
                                                                child:
                                                                    TextFormField(
                                                                  //  key: formkey5,
                                                                  controller: invoiceCards[
                                                                          index]
                                                                      .employeeName,
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          12),
                                                                  obscureText:
                                                                      false,
                                                                  // keyboardType: TextInputType.number,
                                                                  decoration: const InputDecoration(
                                                                      border: OutlineInputBorder(
                                                                          // borderRadius: BorderRadius.circular(25),
                                                                          ),
                                                                      enabledBorder: OutlineInputBorder(
                                                                        borderSide:
                                                                            BorderSide(
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                        // borderRadius: BorderRadius.circular(25),
                                                                      ),
                                                                      labelText: 'EMPLOYEE NAME',
                                                                      labelStyle: TextStyle(color: Colors.white, fontSize: 12)),

                                                                  validator:
                                                                      (value) {
                                                                    if (value!
                                                                        .isEmpty) {
                                                                      return "Please enter Employee name";
                                                                    } else {
                                                                      return null;
                                                                    }
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Align(
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        2.0),
                                                                child:
                                                                    DropdownButtonFormField<
                                                                        String>(
                                                                  dropdownColor:
                                                                      const Color
                                                                          .fromARGB(
                                                                          255,
                                                                          7,
                                                                          59,
                                                                          120),
                                                                  value: invoiceCards[
                                                                          index]
                                                                      .employeeType,
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          2),
                                                                  icon:
                                                                      const Icon(
                                                                    Icons
                                                                        .arrow_drop_down,
                                                                    color: Colors
                                                                        .white,
                                                                    size: 40,
                                                                  ),
                                                                  decoration:
                                                                      const InputDecoration(
                                                                    labelText:
                                                                        'EMPLOYEE TYPE',
                                                                    labelStyle: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            12),
                                                                    enabledBorder:
                                                                        OutlineInputBorder(
                                                                      borderSide:
                                                                          BorderSide(
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                    ),
                                                                    focusedBorder:
                                                                        OutlineInputBorder(
                                                                      borderSide:
                                                                          BorderSide(
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  isExpanded:
                                                                      true,
                                                                  items: select_employeeType
                                                                      .map(
                                                                          buildMenuItem)
                                                                      .toList(),
                                                                  onChanged: (value) =>
                                                                      setState(() =>
                                                                          invoiceCards[index].employeeType =
                                                                              value),
                                                                  validator: (value) =>
                                                                      value ==
                                                                              null
                                                                          ? 'field required'
                                                                          : null,
                                                                ),
                                                              ),
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
                                                            child: Align(
                                                              alignment: Alignment
                                                                  .centerRight,
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        2.0),
                                                                child:
                                                                    TextFormField(
                                                                  //  key: formkey5,
                                                                  controller: invoiceCards[
                                                                          index]
                                                                      .noOfHours,
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          12),
                                                                  obscureText:
                                                                      false,
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .number,
                                                                  decoration: const InputDecoration(
                                                                      border: OutlineInputBorder(
                                                                          // borderRadius: BorderRadius.circular(25),
                                                                          ),
                                                                      enabledBorder: OutlineInputBorder(
                                                                        borderSide:
                                                                            BorderSide(
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                        // borderRadius: BorderRadius.circular(25),
                                                                      ),
                                                                      labelText: 'NO OF HOURS WORKED',
                                                                      labelStyle: TextStyle(color: Colors.white, fontSize: 12)),
                                                                  onChanged:
                                                                      (value) {
                                                                    calculateTotalCost(
                                                                        index);
                                                                    print(
                                                                        '123456');
                                                                  },
                                                                  validator:
                                                                      (value) {
                                                                    if (value!
                                                                        .isEmpty) {
                                                                      return "Please enter No of hours worked";
                                                                    } else {
                                                                      return null;
                                                                    }
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Align(
                                                              alignment: Alignment
                                                                  .centerRight,
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        2.0),
                                                                child:
                                                                    TextFormField(
                                                                  controller: invoiceCards[
                                                                          index]
                                                                      .hourlyRate,
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          12),
                                                                  obscureText:
                                                                      false,
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .number,
                                                                  decoration: const InputDecoration(
                                                                      border: OutlineInputBorder(
                                                                          // borderRadius: BorderRadius.circular(25),
                                                                          ),
                                                                      enabledBorder: OutlineInputBorder(
                                                                        borderSide:
                                                                            BorderSide(
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                        // borderRadius: BorderRadius.circular(25),
                                                                      ),
                                                                      labelText: 'HOURLY RATE (\$)',
                                                                      labelStyle: TextStyle(color: Colors.white, fontSize: 12)),
                                                                  onChanged:
                                                                      (value) {
                                                                    calculateTotalCost(
                                                                      index,
                                                                    );
                                                                    print(
                                                                        '789999999');
                                                                  },
                                                                  validator:
                                                                      (value) {
                                                                    if (value!
                                                                        .isEmpty) {
                                                                      return "Please enter Hourly rate(\$)";
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
                                                        color: Colors.grey,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Expanded(
                                                            child: Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      right: size
                                                                              .width *
                                                                          0.39),
                                                              child: Align(
                                                                alignment: Alignment
                                                                    .centerRight,
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          2.0),
                                                                  child:
                                                                      TextFormField(
                                                                    enabled:
                                                                        false,
                                                                    //  key: formkey5,
                                                                    controller:
                                                                        invoiceCards[index]
                                                                            .laborCost,
                                                                    style: const TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            12),
                                                                    obscureText:
                                                                        false,
                                                                    // keyboardType: TextInputType.number,
                                                                    decoration: const InputDecoration(
                                                                        border: OutlineInputBorder(
                                                                            // borderRadius: BorderRadius.circular(25),
                                                                            ),
                                                                        disabledBorder: OutlineInputBorder(
                                                                          borderSide:
                                                                              BorderSide(
                                                                            color:
                                                                                Colors.white,
                                                                          ),
                                                                          // borderRadius: BorderRadius.circular(25),
                                                                        ),
                                                                        labelText: 'LABOR COST (\$)',
                                                                        labelStyle: TextStyle(color: Colors.white, fontSize: 12)),
                                                                    validator:
                                                                        (value) {
                                                                      if (value!
                                                                          .isEmpty) {
                                                                        return "Please enter Labor cost(\$)";
                                                                      } else {
                                                                        return null;
                                                                      }
                                                                    },
                                                                  ),
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
                              const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 2.0,
                                        right: 2.0,
                                        bottom: 2.0,
                                        top: 20.0),
                                    child: Text(
                                      "LABOR TOTAL(\$)",
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          color:
                                              Color.fromARGB(255, 7, 59, 120),
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: TextFormField(
                                    enabled: false,
                                    controller: _labourTotal,
                                    style: const TextStyle(
                                        color: Color.fromARGB(255, 7, 59, 120),
                                        fontSize: 16),
                                    obscureText: false,
                                    // keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(
                                          // borderRadius: BorderRadius.circular(25),
                                          ),
                                      disabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color:
                                              Color.fromARGB(255, 7, 59, 120),
                                        ),
                                        // borderRadius: BorderRadius.circular(25),
                                      ),
                                      hintText: 'Enter Labor Totals',
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Please enter Labor Totals";
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
                                        top: 20.0),
                                    child: Text(
                                      "INVOICE TOTAL(\$) ",
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          color:
                                              Color.fromARGB(255, 7, 59, 120),
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: TextFormField(
                                    enabled: false,
                                    controller: _invoiceTotal,
                                    style: const TextStyle(
                                        color: Color.fromARGB(255, 7, 59, 120),
                                        fontSize: 16),
                                    obscureText: false,
                                    // keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(
                                          // borderRadius: BorderRadius.circular(25),
                                          ),
                                      disabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color:
                                              Color.fromARGB(255, 7, 59, 120),
                                        ),
                                        // borderRadius: BorderRadius.circular(25),
                                      ),
                                      hintText: 'Enter Invoice Totals',
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Please enter Invoice Totals";
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                ),
                              ),
                              Container(
                                  margin: const EdgeInsets.only(
                                      left: 6, right: 6, top: 20.0, bottom: 10),
                                  child: InkWell(
                                    onTap: () {
                                      if (_formkey.currentState!.validate()) {
                                        Map<String, String?> a;
                                        List<Map<String, dynamic>> mapDataList =
                                            [];

                                        for (int i = 0;
                                            i <
                                                int.parse(
                                                    noOfResources.toString());
                                            i++) {
                                          a = {
                                            "toekenNo": selectedChangeOrder,
                                            "vmaMaintTimeSheetId":
                                                noOfResources,
                                            "empName": invoiceCards[i]
                                                    .employeeName
                                                    ?.text
                                                    .toString() ??
                                                "",
                                            "empType": invoiceCards[i]
                                                .employeeType
                                                .toString(),
                                            "workingHrs": invoiceCards[i]
                                                    .noOfHours
                                                    ?.text
                                                    .toString() ??
                                                "",
                                            "hRlyRate": invoiceCards[i]
                                                    .hourlyRate
                                                    ?.text
                                                    .toString() ??
                                                "",
                                            "laborCost": invoiceCards[i]
                                                    .laborCost
                                                    ?.text
                                                    .toString() ??
                                                "",
                                            "laborTotal": (_labourTotal
                                                    .text.isEmpty)
                                                ? ''
                                                : _labourTotal.text.toString(),
                                            "invoiceTotal": (_invoiceTotal
                                                    .text.isEmpty)
                                                ? ''
                                                : _invoiceTotal.text.toString(),
                                            "invoiceDate": dateSelected1,
                                          };
                                          mapDataList.add(a);
                                        }
                                        print('mapDataList');
                                        print(mapDataList);
                                        invoiceCreateInvoiceViewModel
                                            .fetchInvoiceCreateInvoiceSubmitListApi(
                                                context, mapDataList)
                                            .then((value) {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (BuildContext
                                                          context) =>
                                                      InvoicePage(
                                                          id: selectedChangeOrder)));
                                        });
                                      } else {
                                        print(
                                            "Please fill all mendetory fields!!!");
                                      }
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
                                              "SUBMIT",
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
                    ])),
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

  setData() {
    _invoiceNo.text = widget.changeOrderNo;
    selectedChangeOrder = widget.changeOrderNo;
  }

  createResourceControllerList(int noOfResoureces) {
    invoiceCards.clear();
    if (noOfResoureces != 0) {
      for (int i = 0; i < noOfResoureces; i++) {
        invoiceCards.add(InvoiceCard(
            TextEditingController(),
            'Engineer',
            TextEditingController(),
            TextEditingController(),
            TextEditingController()));
      }
    }
    print(invoiceCards.length);
  }

  calculateTotalCost(int index) {
    setState(() {
      int totalCost = 0;

      int noOfHours = (invoiceCards[index].noOfHours!.text.toString().isEmpty)
          ? 0
          : int.parse(invoiceCards[index].noOfHours!.text.toString());
      int hourlyRate = (invoiceCards[index].hourlyRate!.text.toString().isEmpty)
          ? 0
          : int.parse(invoiceCards[index].hourlyRate!.text.toString());

      totalCost = noOfHours * hourlyRate;
      invoiceCards[index].laborCost!.text = totalCost.toString();

      int totalSum = 0;
      for (int i = 0; i < invoiceCards.length; i++) {
        totalSum = totalSum +
            int.parse((invoiceCards[i].laborCost!.text.toString().isEmpty)
                ? '0'
                : invoiceCards[i].laborCost!.text.toString());
      }
      _labourTotal.text = totalSum.toString();
      _invoiceTotal.text = totalSum.toString();
    });
  }
}

class InvoiceCard {
  TextEditingController? employeeName;
  String? employeeType;
  TextEditingController? noOfHours;
  TextEditingController? hourlyRate;
  TextEditingController? laborCost;

  InvoiceCard(this.employeeName, this.employeeType, this.noOfHours,
      this.hourlyRate, this.laborCost);
}
