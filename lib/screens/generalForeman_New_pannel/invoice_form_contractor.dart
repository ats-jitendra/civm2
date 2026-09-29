import 'dart:io';
import 'package:CIVM/models/user_model.dart';
import 'package:CIVM/screens/generalForeman_New_pannel/contractor_bottom_navigation.dart';
import 'package:CIVM/screens/generalForeman_New_pannel/create_invoice_contractor.dart';
import 'package:CIVM/screens/generalForeman_New_pannel/gf_add_crew_member.dart';
import 'package:CIVM/screens/generalForeman_New_pannel/gf_maintenance_report_view_new.dart';
import 'package:CIVM/screens/generalForeman_New_pannel/inspection.dart';
import 'package:CIVM/screens/generalForeman_New_pannel/invoice_list_contractor.dart';
import 'package:CIVM/screens/leaflat_map/leaf_lat_map_wakeLock.dart';
import 'package:CIVM/screens/map/provider/location_provider.dart';
import 'package:CIVM/sharedPrefs/constants.dart';
import 'package:CIVM/utils/common_functions.dart';
import 'package:CIVM/utils/user_pref.dart';
import 'package:CIVM/view_model/invoice_form_view_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../login_page.dart';

class InvoiceFormContractor extends StatefulWidget {
  const InvoiceFormContractor({Key? key}) : super(key: key);

  @override
  State<InvoiceFormContractor> createState() => _InvoiceFormContractorState();
}

class _InvoiceFormContractorState extends State<InvoiceFormContractor> {
  // int _currentIndex = 0;
  // final List<Widget> _children = [
  //   RowMaintenancePlan(),
  //   // BottomNavigationHomePage(),
  //   // BottomNavigationAccountPage()
  // ];

  final TextEditingController _contractorName = TextEditingController();
  // final TextEditingController _crewNumber = TextEditingController();
  final TextEditingController _drawID = TextEditingController();
  final TextEditingController _invoiceID = TextEditingController();
  final TextEditingController _contractID = TextEditingController();
  final TextEditingController _location = TextEditingController();
  final TextEditingController _itemID = TextEditingController();
  final TextEditingController _itemDescription = TextEditingController();

  final TextEditingController _contractAmount = TextEditingController();
  // final TextEditingController _foremanDigitalSignature2 =
  //     TextEditingController();
  final TextEditingController _retainage = TextEditingController();
  final TextEditingController _lessPreviousBillings = TextEditingController();
  final TextEditingController _totalInvoice = TextEditingController();
  final TextEditingController _amountSubTotal = TextEditingController();
  final TextEditingController _amountDueThisInvoice = TextEditingController();

  List<String> menu = [];

  String datetime = DateTime.now().toString();

  File? image;

  final _formkey = GlobalKey<FormState>();

  onTappedBar(int index) {
    setState(() {
      // _currentIndex = index;
    });
  }

  late String timeSelect = 'HH:MM';
  late String dateSelected1 = 'MM-dd-yyyy';
  late String dateSelected2 = 'MM-dd-yyyy';
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
        dateSelected1 = DateFormat('MM-dd-yyyy').format(picked);
      });
    }
  }

  DateTime date2 = DateTime.now();
  Future<void> selectDate12(BuildContext context) async {
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

  InvoiceFormViewModel invoiceFormViewModel = InvoiceFormViewModel();

  @override
  void initState() {
    // getOwnPermissions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text(
            'Invoice Form',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: const Color.fromARGB(255, 7, 59, 120),
        ),
        drawer: DrawerManu(menu: menu),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8),
            child: Form(
              key: _formkey,
              child: Column(
                children: [
                  const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 2.0, right: 2.0, bottom: 2.0, top: 20.0),
                        child: Text(
                          "GENERAL FOREMAN NAME",
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
                        //key: formkey4,
                        controller: _contractorName,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 7, 59, 120),
                            fontSize: 16),
                        obscureText: false,
                        // keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              // borderRadius: BorderRadius.circular(25),
                              ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 7, 59, 120),
                            ),
                            // borderRadius: BorderRadius.circular(25),
                          ),
                          hintText: 'Enter General Foreman Name',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter Contractor Name";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 4.0, right: 4, top: 20),
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
                                    color: Color.fromARGB(255, 7, 59, 120),
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
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 2),
                                            child: IconButton(
                                              icon: const Icon(
                                                  Icons.calendar_month),
                                              iconSize: 22,
                                              color: const Color.fromARGB(
                                                  255, 7, 59, 120),
                                              onPressed: () {
                                                selectDate(context);
                                                // print(date);
                                              },
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 2),
                                            child: Text(dateSelected1,
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  color: Color.fromARGB(
                                                      255, 7, 59, 120),
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
                            left: 2.0, right: 2.0, bottom: 2.0, top: 20.0),
                        child: Text(
                          "DRAW ID",
                          style: TextStyle(
                              fontSize: 16.0,
                              color: Color.fromARGB(255, 7, 59, 120),
                              fontWeight: FontWeight.bold),
                        ),
                      )),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: TextFormField(
                        //key: formkey4,
                        controller: _drawID,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 7, 59, 120),
                            fontSize: 16),
                        obscureText: false,
                        // keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              // borderRadius: BorderRadius.circular(25),
                              ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 7, 59, 120),
                            ),
                            // borderRadius: BorderRadius.circular(25),
                          ),
                          hintText: 'Enter Draw ID',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter Draw ID";
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
                            left: 2.0, right: 2.0, bottom: 2.0, top: 20.0),
                        child: Text(
                          "INVOICE ID",
                          style: TextStyle(
                              fontSize: 16.0,
                              color: Color.fromARGB(255, 7, 59, 120),
                              fontWeight: FontWeight.bold),
                        ),
                      )),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: TextFormField(
                        //  key: formkey5,
                        controller: _invoiceID,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 7, 59, 120),
                            fontSize: 16),
                        obscureText: false,
                        // keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              // borderRadius: BorderRadius.circular(25),
                              ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 7, 59, 120),
                            ),
                            // borderRadius: BorderRadius.circular(25),
                          ),
                          hintText: 'Enter Invoice ID',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter Invoice ID";
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
                            left: 2.0, right: 2.0, bottom: 2.0, top: 20.0),
                        child: Text(
                          "CONTRACT ID",
                          style: TextStyle(
                              fontSize: 16.0,
                              color: Color.fromARGB(255, 7, 59, 120),
                              fontWeight: FontWeight.bold),
                        ),
                      )),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: TextFormField(
                        //  key: formkey5,
                        controller: _contractID,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 7, 59, 120),
                            fontSize: 16),
                        obscureText: false,
                        // keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              // borderRadius: BorderRadius.circular(25),
                              ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 7, 59, 120),
                            ),
                            // borderRadius: BorderRadius.circular(25),
                          ),
                          hintText: 'Enter Contract ID',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter Contract ID";
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
                            left: 2.0, right: 2.0, bottom: 2.0, top: 20.0),
                        child: Text(
                          "LOCATION ",
                          style: TextStyle(
                              fontSize: 16.0,
                              color: Color.fromARGB(255, 7, 59, 120),
                              fontWeight: FontWeight.bold),
                        ),
                      )),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: TextFormField(
                        //  key: formkey5,
                        controller: _location,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 7, 59, 120),
                            fontSize: 16),
                        obscureText: false,
                        // keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              // borderRadius: BorderRadius.circular(25),
                              ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 7, 59, 120),
                            ),
                            // borderRadius: BorderRadius.circular(25),
                          ),
                          hintText: 'Enter Location',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter Location";
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
                            left: 2.0, right: 2.0, bottom: 2.0, top: 20.0),
                        child: Text(
                          "ITEM ID",
                          style: TextStyle(
                              fontSize: 16.0,
                              color: Color.fromARGB(255, 7, 59, 120),
                              fontWeight: FontWeight.bold),
                        ),
                      )),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: TextFormField(
                        //  key: formkey5,
                        controller: _itemID,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 7, 59, 120),
                            fontSize: 16),
                        obscureText: false,
                        // keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              // borderRadius: BorderRadius.circular(25),
                              ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 7, 59, 120),
                            ),
                            // borderRadius: BorderRadius.circular(25),
                          ),
                          hintText: 'Enter Item ID',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter Item ID";
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
                            left: 2.0, right: 2.0, bottom: 2.0, top: 20.0),
                        child: Text(
                          "ITEM DESCRIPTION",
                          style: TextStyle(
                              fontSize: 16.0,
                              color: Color.fromARGB(255, 7, 59, 120),
                              fontWeight: FontWeight.bold),
                        ),
                      )),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: TextFormField(
                        //  key: formkey5,
                        controller: _itemDescription,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 7, 59, 120),
                            fontSize: 16),
                        obscureText: false,
                        // keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              // borderRadius: BorderRadius.circular(25),
                              ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 7, 59, 120),
                            ),
                            // borderRadius: BorderRadius.circular(25),
                          ),
                          hintText: 'Enter Item Description',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter Item Description";
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
                            left: 2.0, right: 2.0, bottom: 2.0, top: 20.0),
                        child: Text(
                          "CONTRACT AMOUNT",
                          style: TextStyle(
                              fontSize: 16.0,
                              color: Color.fromARGB(255, 7, 59, 120),
                              fontWeight: FontWeight.bold),
                        ),
                      )),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: TextFormField(
                        //  key: formkey5,
                        controller: _contractAmount,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 7, 59, 120),
                            fontSize: 16),
                        obscureText: false,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              // borderRadius: BorderRadius.circular(25),
                              ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 7, 59, 120),
                            ),
                            // borderRadius: BorderRadius.circular(25),
                          ),
                          hintText: 'Enter Contract Amount',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter Contract Amount";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 4.0, right: 4, top: 20),
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
                                "COMPLETED TO DATE",
                                style: TextStyle(
                                    fontSize: 16.0,
                                    color: Color.fromARGB(255, 7, 59, 120),
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
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 2),
                                            child: IconButton(
                                              icon: const Icon(
                                                  Icons.calendar_month),
                                              iconSize: 22,
                                              color: const Color.fromARGB(
                                                  255, 7, 59, 120),
                                              onPressed: () {
                                                selectDate12(context);
                                                print(date2);
                                              },
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 2),
                                            child: Text(dateSelected2,
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  color: Color.fromARGB(
                                                      255, 7, 59, 120),
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
                            left: 2.0, right: 2.0, bottom: 2.0, top: 20.0),
                        child: Text(
                          "RETAINAGE",
                          style: TextStyle(
                              fontSize: 16.0,
                              color: Color.fromARGB(255, 7, 59, 120),
                              fontWeight: FontWeight.bold),
                        ),
                      )),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: TextFormField(
                        //  key: formkey5,
                        controller: _retainage,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 7, 59, 120),
                            fontSize: 16),
                        obscureText: false,
                        // keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              // borderRadius: BorderRadius.circular(25),
                              ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 7, 59, 120),
                            ),
                            // borderRadius: BorderRadius.circular(25),
                          ),
                          hintText: 'Enter Retainage',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter Retainage";
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
                            left: 2.0, right: 2.0, bottom: 2.0, top: 20.0),
                        child: Text(
                          "LESS PREVIOUS BILLINGS",
                          style: TextStyle(
                              fontSize: 16.0,
                              color: Color.fromARGB(255, 7, 59, 120),
                              fontWeight: FontWeight.bold),
                        ),
                      )),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: TextFormField(
                        //  key: formkey5,
                        controller: _lessPreviousBillings,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 7, 59, 120),
                            fontSize: 16),
                        obscureText: false,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              // borderRadius: BorderRadius.circular(25),
                              ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 7, 59, 120),
                            ),
                            // borderRadius: BorderRadius.circular(25),
                          ),
                          hintText: 'Enter Less Previous Billings',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter Less Previous Billings";
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
                            left: 2.0, right: 2.0, bottom: 2.0, top: 20.0),
                        child: Text(
                          "TOTAL INVOICE",
                          style: TextStyle(
                              fontSize: 16.0,
                              color: Color.fromARGB(255, 7, 59, 120),
                              fontWeight: FontWeight.bold),
                        ),
                      )),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: TextFormField(
                        //  key: formkey5,
                        controller: _totalInvoice,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 7, 59, 120),
                            fontSize: 16),
                        obscureText: false,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              // borderRadius: BorderRadius.circular(25),
                              ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 7, 59, 120),
                            ),
                            // borderRadius: BorderRadius.circular(25),
                          ),
                          hintText: 'Enter Total Invoice',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter Total Invoice";
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
                            left: 2.0, right: 2.0, bottom: 2.0, top: 20.0),
                        child: Text(
                          "AMOUNT SUB TOTAL",
                          style: TextStyle(
                              fontSize: 16.0,
                              color: Color.fromARGB(255, 7, 59, 120),
                              fontWeight: FontWeight.bold),
                        ),
                      )),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: TextFormField(
                        //  key: formkey5,
                        controller: _amountSubTotal,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 7, 59, 120),
                            fontSize: 16),
                        obscureText: false,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              // borderRadius: BorderRadius.circular(25),
                              ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 7, 59, 120),
                            ),
                            // borderRadius: BorderRadius.circular(25),
                          ),
                          hintText: 'Enter Amount Sub Total',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter Amount Sub Total";
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
                            left: 2.0, right: 2.0, bottom: 2.0, top: 20.0),
                        child: Text(
                          "AMOUNT DUE THIS INVOICE",
                          style: TextStyle(
                              fontSize: 16.0,
                              color: Color.fromARGB(255, 7, 59, 120),
                              fontWeight: FontWeight.bold),
                        ),
                      )),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: TextFormField(
                        //  key: formkey5,
                        controller: _amountDueThisInvoice,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 7, 59, 120),
                            fontSize: 16),
                        obscureText: false,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              // borderRadius: BorderRadius.circular(25),
                              ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 7, 59, 120),
                            ),
                            // borderRadius: BorderRadius.circular(25),
                          ),
                          hintText: 'Enter Amount Due This Invoice',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter Amount Due This Invoice";
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
                            DateTime parsedDate = DateFormat("MM-dd-yyyy").parse(dateSelected1);
  String formattedDateFordateSelected1 = DateFormat("yyyy-MM-dd").format(parsedDate);
                            Map mapData = {
                              "contractorName": _contractorName.text.toString(),
                              "date": formattedDateFordateSelected1,
                              // dateSelected1,
                              "drawId": _drawID.text.toString(),
                              "invoiceId": _invoiceID.text.toString(),
                              "contractId": _contractID.text.toString(),
                              "location": _location.text.toString(),
                              "itemId": _itemID.text.toString(),
                              "itemDescription":
                                  _itemDescription.text.toString(),
                              "contractAmount": _contractAmount.text.toString(),
                              "completedToDate": dateSelected2,
                              "retaInAge": _retainage.text.toString(),
                              "lessPreviousBillings":
                                  _lessPreviousBillings.text.toString(),
                              "totalThisInvoceLseeRetaInAge":
                                  _totalInvoice.text.toString(),
                              "amountSubTotal": _amountSubTotal.text.toString(),
                              "amountDueThisInvoice":
                                  _amountDueThisInvoice.text.toString()
                            };
                            print('API called.........');
                            invoiceFormViewModel.fetchInvoiceFormSubmitListApi(
                                context, mapData);
                            print('mapData');
                            print(mapData);
                            print('name1');
                            Future.delayed(const Duration(seconds: 5), () {
                              setState(() {
                                _contractorName.clear();
                                _drawID.clear();
                                _invoiceID.clear();
                                _contractID.clear();
                                _location.clear();
                                _itemID.clear();
                                _itemDescription.clear();
                                _contractAmount.clear();
                                _retainage.clear();
                                _lessPreviousBillings.clear();
                                _totalInvoice.clear();
                                _amountSubTotal.clear();
                                _amountDueThisInvoice.clear();
                              });
                            });
                            // _showUpdateDataDialog();
                          } else {
                            print("Please fill all mendetory fields!!!");
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
        ));
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
      value: item,
      child: Text(item,
          style: const TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 20,
          )));
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
    var provider = Provider.of<LocationProvider>(context, listen: true);
    return Drawer(
      child: SafeArea(
        child: Column(
          // Important: Remove any padding from the ListView.
          // padding: EdgeInsets.zero,
          children: [
 Container(
          width: double.infinity,
          height: 180,
          color: const Color.fromARGB(255, 3, 47, 97),
          padding: const EdgeInsets.only(top: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
menuLogoLCP(),const SizedBox(height: 6),
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
                    title: const Text('General Foreman Dashboard'),
                    textColor: const Color.fromARGB(255, 7, 59, 120),
                    iconColor: const Color.fromARGB(255, 7, 59, 120),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const ContractorBottomNavigationPannel()));
                    },
                               ),
                   // ListTile(
            //   leading: const Icon(
            //     Icons.pending,
            //   ),
            //   title: const Text('Change Order Pending'),
            //   textColor: const Color.fromARGB(255, 7, 59, 120),
            //   iconColor: const Color.fromARGB(255, 7, 59, 120),
            //   onTap: () {
            //     Navigator.of(context).push(MaterialPageRoute(
            //         builder: (BuildContext context) =>
            //             const WorkOrderPendingContractor()));
            //   },
            // ),
            // Visibility(
            //   visible: (widget.menu.isNotEmpty &&
            //           widget.menu.contains('Energy Audit Ticket'))
            //       ? true
            //       : false,
            // child:
            // ListTile(
            //   leading: const Icon(
            //     Icons.running_with_errors,
            //   ),
            //   title: const Text('IVM Maintenance Progress'),
            //   textColor: const Color.fromARGB(255, 7, 59, 120),
            //   iconColor: const Color.fromARGB(255, 7, 59, 120),
            //   onTap: () {
            //     Navigator.of(context).push(MaterialPageRoute(
            //         builder: (BuildContext context) =>
            //             const RowMaintenanceProgressContractor()));
            //   },
            // ),
            // ),
              ListTile(
              leading: const Icon(
               Icons.settings_applications_sharp,
              ),
              title: const Text('Maintenance Report View'),
              textColor: const Color.fromARGB(255, 7, 59, 120),
              iconColor: const Color.fromARGB(255, 7, 59, 120),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) =>
                         GfMaintenanceReportViewNew(year:'')));
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.change_circle,
              ),
              title: const Text('IVM/Change Order'),
              textColor: const Color.fromARGB(255, 7, 59, 120),
              iconColor: const Color.fromARGB(255, 7, 59, 120),
              onTap: () {
                // Navigator.of(context).push(MaterialPageRoute(
                //     builder: (BuildContext context) =>
                //         const ChangeOrderContractor()));
                 Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) =>
                         Inspection(year: '',),));
              },
            ),
        
            // ListTile(
            //   leading: const Icon(
            //     Icons.inventory,
            //   ),
            //   title: const Text('Daily Herbicide Application Form'),
            //   textColor: const Color.fromARGB(255, 7, 59, 120),
            //   iconColor: const Color.fromARGB(255, 7, 59, 120),
            //   onTap: () {
            //     Navigator.of(context).push(MaterialPageRoute(
            //         builder: (BuildContext context) =>
            //             const DailyHerbicideApplicationFormContractor()));
            //   },
            // ),
        
            // ListTile(
            //   leading: const Icon(
            //     Icons.list_alt,
            //   ),
            //   title: const Text('Power Time Form'),
            //   textColor: const Color.fromARGB(255, 7, 59, 120),
            //   iconColor: const Color.fromARGB(255, 7, 59, 120),
            //   onTap: () {
            //     Navigator.of(context).push(MaterialPageRoute(
            //         builder: (BuildContext context) =>
            //             const PowerTimeFormContractor()));
            //   },
            // ),
        
            ListTile(
              leading: const Icon(
                Icons.list_alt,
              ),
              title: const Text('Invoice Form'),
              textColor: const Color.fromARGB(255, 7, 59, 120),
              iconColor: const Color.fromARGB(255, 7, 59, 120),
              onTap: () {
                Navigator.pop(context);
              },
            ),
        
            // ListTile(
            //   leading: const Icon(
            //     Icons.list_alt,
            //   ),
            //   title: const Text('Mixing Inventory Form'),
            //   textColor: const Color.fromARGB(255, 7, 59, 120),
            //   iconColor: const Color.fromARGB(255, 7, 59, 120),
            //   onTap: () {
            //     Navigator.of(context).push(MaterialPageRoute(
            //         builder: (BuildContext context) =>
            //             const MixingInventoryFormContractor()));
            //   },
            // ),
            ListTile(
              leading: const Icon(
                Icons.create,
              ),
              title: const Text('Create Invoice'),
              textColor: const Color.fromARGB(255, 7, 59, 120),
              iconColor: const Color.fromARGB(255, 7, 59, 120),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) =>
                        const CreateInvoiceContractor()));
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.list,
              ),
              title: const Text('Invoice List'),
              textColor: const Color.fromARGB(255, 7, 59, 120),
              iconColor: const Color.fromARGB(255, 7, 59, 120),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) =>
                        const InvoiceListContrator()));
              },
            ),
              ListTile(
              leading: const Icon(
                Icons.map,
              ),
              title: const Text('Live IVM System Map'),
              textColor: const Color.fromARGB(255, 7, 59, 120),
              iconColor: const Color.fromARGB(255, 7, 59, 120),
              onTap: () {
                provider.getLocation();
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const MapScreenLeafLat()));
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.add,
              ),
              title: const Text('Add Crew Member'),
              textColor: const Color.fromARGB(255, 7, 59, 120),
              iconColor: const Color.fromARGB(255, 7, 59, 120),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) =>
                        const GFAddCrewMember()));
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.logout,
              ),
              title: const Text('Log Out'),
              textColor: const Color.fromARGB(255, 7, 59, 120),
              iconColor: const Color.fromARGB(255, 7, 59, 120),
              onTap: () {
                // // Constants.prefs.setBool("LoggedIn", false);
                userPreferences.remove().then((value) {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => const LoginPage()));
                });
                // Navigator.of(context).pushReplacement(MaterialPageRoute(
                //     builder: (BuildContext context) => const LoginPage()));
              },
            ),],
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
        ) 
          ],
        ),
      ),
    );
  }

  Future<void> setUserName() async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    Image.network(
      'https://civm.ariespro.com/assets/clientuploads/${data.user!.profilePhoto}',
    );
    String imageUrl =
        'https://civm.ariespro.com/assets/clientuploads/${data.user!.profilePhoto}';
    _imagePath = imageUrl;
    setState(() {
      userName = '${data.user!.fName} ${data.user!.lName}';
    });
  }
}
