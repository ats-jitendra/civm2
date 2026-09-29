import 'dart:convert';

import 'package:CIVM/data/response/status.dart';
import 'package:CIVM/models/user_model.dart';
import 'package:CIVM/resources/app_url.dart';
import 'package:CIVM/utils/common_functions.dart';
import 'package:CIVM/screens/generalForeman_New_pannel/contractor_bottom_navigation.dart';
import 'package:CIVM/screens/generalForeman_New_pannel/gf_add_crew_member.dart';
import 'package:CIVM/screens/generalForeman_New_pannel/gf_maintenance_report_view_new.dart';
import 'package:CIVM/screens/generalForeman_New_pannel/inspection.dart';
import 'package:CIVM/screens/generalForeman_New_pannel/invoice.dart';
import 'package:CIVM/screens/generalForeman_New_pannel/invoice_form_contractor.dart';
import 'package:CIVM/screens/generalForeman_New_pannel/invoice_list_contractor.dart';
import 'package:CIVM/screens/leaflat_map/leaf_lat_map_wakeLock.dart';
import 'package:CIVM/screens/map/provider/location_provider.dart';
import 'package:CIVM/sharedPrefs/constants.dart';
import 'package:CIVM/utils/user_pref.dart';
import 'package:CIVM/view_model/create_invoice_contractor_view_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../login_page.dart';

class CreateInvoiceContractor extends StatefulWidget {
  const CreateInvoiceContractor({Key? key}) : super(key: key);

  @override
  State<CreateInvoiceContractor> createState() =>
      _CreateInvoiceContractorState();
}

class _CreateInvoiceContractorState extends State<CreateInvoiceContractor> {
  // final List<Widget> _children = [
  //   RowMaintenancePlan(),
  //   // BottomNavigationHomePage(),
  //   // BottomNavigationAccountPage()
  // ];
  List<String> menu = [];

  final TextEditingController _input = TextEditingController();

  // ignore: prefer_typing_uninitialized_variables
  var selectedSubstation;
  late int subId;
  // ignore: prefer_typing_uninitialized_variables
  var selectedFeeder;
  late int feederId;

  onTappedBar(int index) {
    setState(() {
      // _currentIndex = index;
    });
  }

  CreateInvoiceContractorViewModel createInvoiceContractorViewModel =
      CreateInvoiceContractorViewModel();

  String formattedContractYear = '';
  String formattedNextMaintDue = '';

  @override
  void initState() {
    createInvoiceContractorViewModel
        .fetchCreateInvoiceContractorViewModelTabularListApi(context, '', '');
    super.initState();
    _initializeScreen();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text(
            'Create Invoice',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: const Color.fromARGB(255, 7, 59, 120),
        ),
        drawer: DrawerManu(menu: menu),
        body: ChangeNotifierProvider<CreateInvoiceContractorViewModel>(
            create: (BuildContext context) => createInvoiceContractorViewModel,
            child: Consumer<CreateInvoiceContractorViewModel>(
                builder: (context, value, _) {
              switch (
                  value.createInvoiceContractorViewModelGetTabularData.status) {
                case Status.LOADING:
                  return const Center(child: CircularProgressIndicator());
                case Status.ERROR:
                  return
                      // CustomToastSnackBarProgressDialog.flushBarErrorMessage(
                      //     value.createInvoiceContractorViewModelGetTabularData
                      //         .message
                      //         .toString(),
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
                  return RefreshIndicator(
                    onRefresh: () async {
                      _input.clear();
                      selectedSubstation = null;
                      selectedFeeder = null;
                      await createInvoiceContractorViewModel
                          .fetchCreateInvoiceContractorViewModelTabularListApi(
                              context, '', '');
                      _initializeScreen();
                    },
                    child: SingleChildScrollView(
                        child: Column(children: [
                      Container(
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
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
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
                                              color: Color.fromARGB(
                                                  255, 7, 59, 120),
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        )),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: SizedBox(
                                          width: 200,
                                          child:
                                              DropdownButtonFormField<String>(
                                            hint: const Text('-Select-'),
                                            dropdownColor: const Color.fromRGBO(
                                                255, 255, 255, 1),
                                            value: selectedSubstation,
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
                                            items: createInvoiceContractorViewModel
                                                .createInvoiceContractorViewModelGetTabularData
                                                .data!
                                                .findAllSubstation!
                                                .map((e) {
                                              return DropdownMenuItem(
                                                value: e.subId.toString(),
                                                // e.getIdAndSubstationByCountId![0].subStation.toString(),
                                                child: Text(
                                                    e.substation.toString()),
                                              );
                                            }).toList(),
                                            onChanged: (val) {
                                              if (selectedFeeder != null) {
                                                selectedFeeder = null;
                                              }
                                              fetchData(val!, '');
                                              subId = int.parse(val);
                                              setState(() {
                                                selectedSubstation = val;
                                              });
                                            },
                                            validator: (value) => value == null
                                                ? 'field required'
                                                : null,
                                          ),
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
                                              color: Color.fromARGB(
                                                  255, 7, 59, 120),
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        )),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: SizedBox(
                                          width: 200,
                                          child:
                                              DropdownButtonFormField<String>(
                                            hint: const Text('-Select-'),
                                            dropdownColor: Colors.white,
                                            value: selectedFeeder,
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
                                            items: createInvoiceContractorViewModel
                                                .createInvoiceContractorViewModelGetTabularData
                                                .data!
                                                .getAllFdrBySubstationList!
                                                .map((e) {
                                              return DropdownMenuItem(
                                                value: e.feeder.toString(),
                                                // e.getIdAndSubstationByCountId![0].subStation.toString(),
                                                child:
                                                    Text(e.fdrName.toString()),
                                              );
                                            }).toList(),
                                            onChanged: (val) {
                                              fetchData(
                                                  selectedSubstation, val!);
                                              feederId = int.parse(val);
                                              setState(() {
                                                selectedFeeder = val;
                                              });
                                            },
                                            validator: (value) => value == null
                                                ? 'field required'
                                                : null,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          //  margin:  EdgeInsets.only(
                          //      top: 10, bottom: 10, left: 8, right: 8),
                          //  padding:  EdgeInsets.all(8),
                          alignment: Alignment.center,
                          height: size.height * 0.9,
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
                              Row(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(top: 8.0, left: 8),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        "Total Record : ",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 7, 59, 120),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Text(
                                      createInvoiceContractorViewModel
                                          .createInvoiceContractorViewModelGetTabularData
                                          .data!
                                          .findAllTableData!
                                          .length
                                          .toString(),
                                      // result.length.toString(),
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(
                                        color: Color.fromARGB(255, 7, 59, 120),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 4.0,
                                            right: 4.0,
                                            top: 4,
                                            bottom: 4),
                                        child: TextFormField(
                                          onChanged: (value) =>
                                              _filterData(value),
                                          //  key: formkey2,
                                          controller: _input,
                                          style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 7, 59, 120),
                                              fontSize: 16),
                                          obscureText: false,

                                          //keyboardType: TextInputType.number,
                                          decoration: const InputDecoration(
                                            border: OutlineInputBorder(
                                                // borderRadius: BorderRadius.circular(25),
                                                ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color.fromARGB(
                                                    255, 23, 1, 88),
                                              ),
                                              // borderRadius: BorderRadius.circular(25),
                                            ),
                                            hintText: 'Search your input...',
                                          ),
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "Please search your input";
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
                              //newcode
                              Expanded(
                                child: ListView.builder(
                                    itemCount: createInvoiceContractorViewModel
                                        .createInvoiceContractorViewModelGetTabularData
                                        .data!
                                        .findAllTableData!
                                        .length,
                                    // itemCount: historyList.length,
                                    itemBuilder:
                                        (BuildContext ctxt, int index) {
                                      String? dateString =
                                          createInvoiceContractorViewModel
                                              .createInvoiceContractorViewModelGetTabularData
                                              .data!
                                              .findAllTableData![index]
                                              .createDate;
                                      String formattedDate = '';
                                      if (dateString != null) {
                                        DateTime date =
                                            DateTime.parse(dateString);
                                        formattedDate = DateFormat('MM/dd/yyyy')
                                            .format(date);
                                      } else {
                                        formattedDate = '';
                                      }
                                      newDateFormat(index);
                                      return Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 4.0,
                                                bottom: 4,
                                                left: 4,
                                                right: 4),
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.935,
                                              // height: MediaQuery.of(context)
                                              //         .size
                                              //         .height *
                                              //     0.73,
                                              // margin:  EdgeInsets.only(
                                              //     top: 5.0, bottom: 5.0, left: 2,right: 2),
                                              padding: const EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                  color: const Color.fromARGB(
                                                      255, 7, 59, 120),
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
                                                  )),
                                              child: Column(children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        //  flex: 3,
                                                        child: Column(
                                                          children: [
                                                            const Align(
                                                              alignment:
                                                                  Alignment
                                                                      .topLeft,
                                                              child: Text(
                                                                "INVOICE :",
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                            ),
                                                            Align(
                                                              alignment:
                                                                  Alignment
                                                                      .topLeft,
                                                              child: InkWell(
                                                                onTap: () {
                                                                  Navigator.of(context).push(MaterialPageRoute(
                                                                      builder: (BuildContext context) => Invoice(
                                                                          changeOrderNo: createInvoiceContractorViewModel
                                                                              .createInvoiceContractorViewModelGetTabularData
                                                                              .data!
                                                                              .findAllTableData![index]
                                                                              .id
                                                                              .toString())));
                                                                },
                                                                child:
                                                                    const Icon(
                                                                  Icons.edit,
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          151,
                                                                          249,
                                                                          154),
                                                                ),
                                                              ),
                                                            )
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
                                                              child: Text(
                                                                "TYPE: ",
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style:
                                                                    TextStyle(
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
                                                              child: Text(
                                                                (createInvoiceContractorViewModel.createInvoiceContractorViewModelGetTabularData.data!.findAllTableData![index].maintType ==
                                                                            null ||
                                                                        createInvoiceContractorViewModel.createInvoiceContractorViewModelGetTabularData.data!.findAllTableData![index].maintType.toString() ==
                                                                            'null')
                                                                    ? ''
                                                                    : createInvoiceContractorViewModel
                                                                        .createInvoiceContractorViewModelGetTabularData
                                                                        .data!
                                                                        .findAllTableData![
                                                                            index]
                                                                        .maintType
                                                                        .toString(),
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 12,
                                                                  //  fontWeight:
                                                                  //      FontWeight.bold,
                                                                  color: Colors
                                                                      .white,
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
                                                              child: Text(
                                                                "JOB NO: ",
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style:
                                                                    TextStyle(
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
                                                              child: Text(
                                                                (createInvoiceContractorViewModel.createInvoiceContractorViewModelGetTabularData.data!.findAllTableData![index].tokenNo ==
                                                                            null ||
                                                                        createInvoiceContractorViewModel.createInvoiceContractorViewModelGetTabularData.data!.findAllTableData![index].tokenNo.toString() ==
                                                                            'null')
                                                                    ? ''
                                                                    : createInvoiceContractorViewModel
                                                                        .createInvoiceContractorViewModelGetTabularData
                                                                        .data!
                                                                        .findAllTableData![
                                                                            index]
                                                                        .tokenNo
                                                                        .toString(),
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 12,
                                                                  //  fontWeight:
                                                                  //      FontWeight.bold,
                                                                  color: Colors
                                                                      .white,
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
                                                  color: Colors.grey,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0),
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
                                                              child: Text(
                                                                "STATUS: ",
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style:
                                                                    TextStyle(
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
                                                              child: Text(
                                                                (createInvoiceContractorViewModel.createInvoiceContractorViewModelGetTabularData.data!.findAllTableData![index].status ==
                                                                            null ||
                                                                        createInvoiceContractorViewModel.createInvoiceContractorViewModelGetTabularData.data!.findAllTableData![index].status.toString() ==
                                                                            'null')
                                                                    ? ''
                                                                    : createInvoiceContractorViewModel
                                                                        .createInvoiceContractorViewModelGetTabularData
                                                                        .data!
                                                                        .findAllTableData![
                                                                            index]
                                                                        .status
                                                                        .toString(),
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 12,
                                                                  //  fontWeight:
                                                                  //      FontWeight.bold,
                                                                  color: Colors
                                                                      .white,
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
                                                              child: Text(
                                                                "SUBSTATION: ",
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style:
                                                                    TextStyle(
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
                                                              child: Text(
                                                                (createInvoiceContractorViewModel.createInvoiceContractorViewModelGetTabularData.data!.findAllTableData![index].substation ==
                                                                            null ||
                                                                        createInvoiceContractorViewModel.createInvoiceContractorViewModelGetTabularData.data!.findAllTableData![index].substation.toString() ==
                                                                            'null')
                                                                    ? ''
                                                                    : createInvoiceContractorViewModel
                                                                        .createInvoiceContractorViewModelGetTabularData
                                                                        .data!
                                                                        .findAllTableData![
                                                                            index]
                                                                        .substation
                                                                        .toString(),
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 12,
                                                                  //  fontWeight:
                                                                  //      FontWeight.bold,
                                                                  color: Colors
                                                                      .white,
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
                                                              child: Text(
                                                                "FEEDER: ",
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style:
                                                                    TextStyle(
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
                                                              child: Text(
                                                                (createInvoiceContractorViewModel.createInvoiceContractorViewModelGetTabularData.data!.findAllTableData![index].fdrName ==
                                                                            null ||
                                                                        createInvoiceContractorViewModel.createInvoiceContractorViewModelGetTabularData.data!.findAllTableData![index].fdrName.toString() ==
                                                                            'null')
                                                                    ? ''
                                                                    : createInvoiceContractorViewModel
                                                                        .createInvoiceContractorViewModelGetTabularData
                                                                        .data!
                                                                        .findAllTableData![
                                                                            index]
                                                                        .fdrName
                                                                        .toString(),
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 12,
                                                                  //  fontWeight:
                                                                  //      FontWeight.bold,
                                                                  color: Colors
                                                                      .white,
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
                                                  color: Colors.grey,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0),
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
                                                              child: Text(
                                                                "MAINTENANCE TYPE: ",
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style:
                                                                    TextStyle(
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
                                                              child: Text(
                                                                (createInvoiceContractorViewModel.createInvoiceContractorViewModelGetTabularData.data!.findAllTableData![index].type ==
                                                                            null ||
                                                                        createInvoiceContractorViewModel.createInvoiceContractorViewModelGetTabularData.data!.findAllTableData![index].type.toString() ==
                                                                            'null')
                                                                    ? ''
                                                                    : createInvoiceContractorViewModel
                                                                        .createInvoiceContractorViewModelGetTabularData
                                                                        .data!
                                                                        .findAllTableData![
                                                                            index]
                                                                        .type
                                                                        .toString(),
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 12,
                                                                  //  fontWeight:
                                                                  //      FontWeight.bold,
                                                                  color: Colors
                                                                      .white,
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
                                                              child: Text(
                                                                "CONTRACTOR: ",
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style:
                                                                    TextStyle(
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
                                                              child: Text(
                                                                (createInvoiceContractorViewModel.createInvoiceContractorViewModelGetTabularData.data!.findAllTableData![index].contractor ==
                                                                            null ||
                                                                        createInvoiceContractorViewModel.createInvoiceContractorViewModelGetTabularData.data!.findAllTableData![index].contractor.toString() ==
                                                                            'null')
                                                                    ? ''
                                                                    : createInvoiceContractorViewModel
                                                                        .createInvoiceContractorViewModelGetTabularData
                                                                        .data!
                                                                        .findAllTableData![
                                                                            index]
                                                                        .contractor
                                                                        .toString(),
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 12,
                                                                  //  fontWeight:
                                                                  //      FontWeight.bold,
                                                                  color: Colors
                                                                      .white,
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
                                                              child: Text(
                                                                "TOTAL MILES: ",
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style:
                                                                    TextStyle(
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
                                                              child: Text(
                                                                (createInvoiceContractorViewModel.createInvoiceContractorViewModelGetTabularData.data!.findAllTableData![index].totalMiles ==
                                                                            null ||
                                                                        createInvoiceContractorViewModel.createInvoiceContractorViewModelGetTabularData.data!.findAllTableData![index].totalMiles.toString() ==
                                                                            'null')
                                                                    ? ''
                                                                    : createInvoiceContractorViewModel
                                                                        .createInvoiceContractorViewModelGetTabularData
                                                                        .data!
                                                                        .findAllTableData![
                                                                            index]
                                                                        .totalMiles
                                                                        .toString(),
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 12,
                                                                  //  fontWeight:
                                                                  //      FontWeight.bold,
                                                                  color: Colors
                                                                      .white,
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
                                                  color: Colors.grey,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0),
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
                                                              child: Text(
                                                                "CONTRACT YEAR: ",
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style:
                                                                    TextStyle(
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
                                                              child: Text(
                                                                (createInvoiceContractorViewModel.createInvoiceContractorViewModelGetTabularData.data!.findAllTableData![index].contractYear ==
                                                                            null ||
                                                                        createInvoiceContractorViewModel.createInvoiceContractorViewModelGetTabularData.data!.findAllTableData![index].contractYear.toString() ==
                                                                            'null')
                                                                    ? ''
                                                                    : formattedContractYear,
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 12,
                                                                  //  fontWeight:
                                                                  //      FontWeight.bold,
                                                                  color: Colors
                                                                      .white,
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
                                                              child: Text(
                                                                "CYCLE: ",
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style:
                                                                    TextStyle(
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
                                                              child: Text(
                                                                (createInvoiceContractorViewModel.createInvoiceContractorViewModelGetTabularData.data!.findAllTableData![index].cycle ==
                                                                            null ||
                                                                        createInvoiceContractorViewModel.createInvoiceContractorViewModelGetTabularData.data!.findAllTableData![index].cycle.toString() ==
                                                                            'null')
                                                                    ? ''
                                                                    : createInvoiceContractorViewModel
                                                                        .createInvoiceContractorViewModelGetTabularData
                                                                        .data!
                                                                        .findAllTableData![
                                                                            index]
                                                                        .cycle
                                                                        .toString(),
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 12,
                                                                  //  fontWeight:
                                                                  //      FontWeight.bold,
                                                                  color: Colors
                                                                      .white,
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
                                                              child: Text(
                                                                "SERVICE STREET ADDRESS: ",
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style:
                                                                    TextStyle(
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
                                                              child: Text(
                                                                (createInvoiceContractorViewModel.createInvoiceContractorViewModelGetTabularData.data!.findAllTableData![index].streetAddress ==
                                                                            null ||
                                                                        createInvoiceContractorViewModel.createInvoiceContractorViewModelGetTabularData.data!.findAllTableData![index].streetAddress.toString() ==
                                                                            'null')
                                                                    ? ''
                                                                    : createInvoiceContractorViewModel
                                                                        .createInvoiceContractorViewModelGetTabularData
                                                                        .data!
                                                                        .findAllTableData![
                                                                            index]
                                                                        .streetAddress
                                                                        .toString(),
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 12,
                                                                  //  fontWeight:
                                                                  //      FontWeight.bold,
                                                                  color: Colors
                                                                      .white,
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
                                                  color: Colors.grey,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0),
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
                                                              child: Text(
                                                                "SERVICE MAP LOCATION: ",
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style:
                                                                    TextStyle(
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
                                                              child: Text(
                                                                (createInvoiceContractorViewModel.createInvoiceContractorViewModelGetTabularData.data!.findAllTableData![index].mapLocation ==
                                                                            null ||
                                                                        createInvoiceContractorViewModel.createInvoiceContractorViewModelGetTabularData.data!.findAllTableData![index].mapLocation.toString() ==
                                                                            'null')
                                                                    ? ''
                                                                    : createInvoiceContractorViewModel
                                                                        .createInvoiceContractorViewModelGetTabularData
                                                                        .data!
                                                                        .findAllTableData![
                                                                            index]
                                                                        .mapLocation
                                                                        .toString(),
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 12,
                                                                  //  fontWeight:
                                                                  //      FontWeight.bold,
                                                                  color: Colors
                                                                      .white,
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
                                                              child: Text(
                                                                "SERVICE MAP LOCATION: ",
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style:
                                                                    TextStyle(
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
                                                              child: Text(
                                                                (createInvoiceContractorViewModel.createInvoiceContractorViewModelGetTabularData.data!.findAllTableData![index].mapLocation ==
                                                                            null ||
                                                                        createInvoiceContractorViewModel.createInvoiceContractorViewModelGetTabularData.data!.findAllTableData![index].mapLocation.toString() ==
                                                                            'null')
                                                                    ? ''
                                                                    : createInvoiceContractorViewModel
                                                                        .createInvoiceContractorViewModelGetTabularData
                                                                        .data!
                                                                        .findAllTableData![
                                                                            index]
                                                                        .mapLocation
                                                                        .toString(),
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 12,
                                                                  //  fontWeight:
                                                                  //      FontWeight.bold,
                                                                  color: Colors
                                                                      .white,
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
                                                              child: Text(
                                                                "GENERAL FOREMAN NOTES 1: ",
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style:
                                                                    TextStyle(
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
                                                              child: Text(
                                                                (createInvoiceContractorViewModel.createInvoiceContractorViewModelGetTabularData.data!.findAllTableData![index].adminNotes1 ==
                                                                            null ||
                                                                        createInvoiceContractorViewModel.createInvoiceContractorViewModelGetTabularData.data!.findAllTableData![index].adminNotes1.toString() ==
                                                                            'null')
                                                                    ? ''
                                                                    : createInvoiceContractorViewModel
                                                                        .createInvoiceContractorViewModelGetTabularData
                                                                        .data!
                                                                        .findAllTableData![
                                                                            index]
                                                                        .adminNotes1
                                                                        .toString(),
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 12,
                                                                  //  fontWeight:
                                                                  //      FontWeight.bold,
                                                                  color: Colors
                                                                      .white,
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
                                                  color: Colors.grey,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0),
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
                                                              child: Text(
                                                                "GENERAL FOREMAN NOTES 2: ",
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style:
                                                                    TextStyle(
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
                                                              child: Text(
                                                                (createInvoiceContractorViewModel.createInvoiceContractorViewModelGetTabularData.data!.findAllTableData![index].contractorNotes ==
                                                                            null ||
                                                                        createInvoiceContractorViewModel.createInvoiceContractorViewModelGetTabularData.data!.findAllTableData![index].contractorNotes.toString() ==
                                                                            'null')
                                                                    ? ''
                                                                    : createInvoiceContractorViewModel
                                                                        .createInvoiceContractorViewModelGetTabularData
                                                                        .data!
                                                                        .findAllTableData![
                                                                            index]
                                                                        .contractorNotes
                                                                        .toString(),
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 12,
                                                                  //  fontWeight:
                                                                  //      FontWeight.bold,
                                                                  color: Colors
                                                                      .white,
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
                                                              child: Text(
                                                                "ADMIN NOTES: ",
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style:
                                                                    TextStyle(
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
                                                              child: Text(
                                                                (createInvoiceContractorViewModel.createInvoiceContractorViewModelGetTabularData.data!.findAllTableData![index].adminNotes2 ==
                                                                            null ||
                                                                        createInvoiceContractorViewModel.createInvoiceContractorViewModelGetTabularData.data!.findAllTableData![index].adminNotes2.toString() ==
                                                                            'null')
                                                                    ? ''
                                                                    : createInvoiceContractorViewModel
                                                                        .createInvoiceContractorViewModelGetTabularData
                                                                        .data!
                                                                        .findAllTableData![
                                                                            index]
                                                                        .adminNotes2
                                                                        .toString(),
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 12,
                                                                  //  fontWeight:
                                                                  //      FontWeight.bold,
                                                                  color: Colors
                                                                      .white,
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
                                                              child: Text(
                                                                "CONTRACTOR COMPANY: ",
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style:
                                                                    TextStyle(
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
                                                              child: Text(
                                                                (createInvoiceContractorViewModel.createInvoiceContractorViewModelGetTabularData.data!.findAllTableData![index].contactorCompany ==
                                                                            null ||
                                                                        createInvoiceContractorViewModel.createInvoiceContractorViewModelGetTabularData.data!.findAllTableData![index].contactorCompany.toString() ==
                                                                            'null')
                                                                    ? ''
                                                                    : createInvoiceContractorViewModel
                                                                        .createInvoiceContractorViewModelGetTabularData
                                                                        .data!
                                                                        .findAllTableData![
                                                                            index]
                                                                        .contactorCompany
                                                                        .toString(),
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 12,
                                                                  //  fontWeight:
                                                                  //      FontWeight.bold,
                                                                  color: Colors
                                                                      .white,
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
                                                  color: Colors.grey,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0),
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
                                                              child: Text(
                                                                "DATE OF INSPECTION: ",
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style:
                                                                    TextStyle(
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
                                                              child: Text(
                                                                (createInvoiceContractorViewModel.createInvoiceContractorViewModelGetTabularData.data!.findAllTableData![index].dateOfInspection ==
                                                                            null ||
                                                                        createInvoiceContractorViewModel.createInvoiceContractorViewModelGetTabularData.data!.findAllTableData![index].dateOfInspection.toString() ==
                                                                            'null')
                                                                    ? ''
                                                                    : createInvoiceContractorViewModel
                                                                        .createInvoiceContractorViewModelGetTabularData
                                                                        .data!
                                                                        .findAllTableData![
                                                                            index]
                                                                        .dateOfInspection
                                                                        .toString(),
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 12,
                                                                  //  fontWeight:
                                                                  //      FontWeight.bold,
                                                                  color: Colors
                                                                      .white,
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
                                                              child: Text(
                                                                "FOLLOW UP DATE: ",
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style:
                                                                    TextStyle(
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
                                                              child: Text(
                                                                (createInvoiceContractorViewModel.createInvoiceContractorViewModelGetTabularData.data!.findAllTableData![index].followUpDate ==
                                                                            null ||
                                                                        createInvoiceContractorViewModel.createInvoiceContractorViewModelGetTabularData.data!.findAllTableData![index].followUpDate.toString() ==
                                                                            'null')
                                                                    ? ''
                                                                    : createInvoiceContractorViewModel
                                                                        .createInvoiceContractorViewModelGetTabularData
                                                                        .data!
                                                                        .findAllTableData![
                                                                            index]
                                                                        .followUpDate
                                                                        .toString(),
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 12,
                                                                  //  fontWeight:
                                                                  //      FontWeight.bold,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      // Expanded(
                                                      //   // alignment: Alignment.topLeft,
                                                      //   child: Column(
                                                      //     children: [
                                                      //       const Align(
                                                      //         alignment: Alignment
                                                      //             .topLeft,
                                                      //         child: Text(
                                                      //           "COST PER MILE: ",
                                                      //           textAlign:
                                                      //               TextAlign
                                                      //                   .left,
                                                      //           style: TextStyle(
                                                      //             fontSize: 12,
                                                      //             fontWeight:
                                                      //                 FontWeight
                                                      //                     .bold,
                                                      //             color: Colors
                                                      //                 .white,
                                                      //           ),
                                                      //         ),
                                                      //       ),
                                                      //       Align(
                                                      //         alignment: Alignment
                                                      //             .topLeft,
                                                      //         child: Text(
                                                      //           (createInvoiceContractorViewModel
                                                      //                           .createInvoiceContractorViewModelGetTabularData
                                                      //                           .data!
                                                      //                           .findAllTableData![
                                                      //                               index]
                                                      //                           .costPerMile ==
                                                      //                       null ||
                                                      //                   createInvoiceContractorViewModel
                                                      //                           .createInvoiceContractorViewModelGetTabularData
                                                      //                           .data!
                                                      //                           .findAllTableData![
                                                      //                               index]
                                                      //                           .costPerMile
                                                      //                           .toString() ==
                                                      //                       'null')
                                                      //               ? ''
                                                      //               : createInvoiceContractorViewModel
                                                      //                   .createInvoiceContractorViewModelGetTabularData
                                                      //                   .data!
                                                      //                   .findAllTableData![
                                                      //                       index]
                                                      //                   .costPerMile
                                                      //                   .toString(),
                                                      //           textAlign:
                                                      //               TextAlign
                                                      //                   .left,
                                                      //           style:
                                                      //               const TextStyle(
                                                      //             fontSize: 12,
                                                      //             //  fontWeight:
                                                      //             //      FontWeight.bold,
                                                      //             color: Colors
                                                      //                 .white,
                                                      //           ),
                                                      //         ),
                                                      //       ),
                                                      //     ],
                                                      //   ),
                                                      // ),
                                                      Expanded(
                                                        // alignment: Alignment.topLeft,
                                                        child: Column(
                                                          children: [
                                                            const Align(
                                                              alignment:
                                                                  Alignment
                                                                      .topLeft,
                                                              child: Text(
                                                                "NEXT MAINT DUE: ",
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style:
                                                                    TextStyle(
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
                                                              child: Text(
                                                                (createInvoiceContractorViewModel.createInvoiceContractorViewModelGetTabularData.data!.findAllTableData![index].nextMaintDue ==
                                                                            null ||
                                                                        createInvoiceContractorViewModel.createInvoiceContractorViewModelGetTabularData.data!.findAllTableData![index].nextMaintDue.toString() ==
                                                                            'null')
                                                                    ? ''
                                                                    : formattedNextMaintDue,
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 12,
                                                                  //  fontWeight:
                                                                  //      FontWeight.bold,
                                                                  color: Colors
                                                                      .white,
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
                                                  color: Colors.grey,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0),
                                                  child: Row(
                                                    children: [
                                                      // Expanded(
                                                      //   // alignment: Alignment.topLeft,
                                                      //   child: Column(
                                                      //     children: [
                                                      //       const Align(
                                                      //         alignment: Alignment
                                                      //             .topLeft,
                                                      //         child: Text(
                                                      //           "TOTAL COST: ",
                                                      //           textAlign:
                                                      //               TextAlign
                                                      //                   .left,
                                                      //           style: TextStyle(
                                                      //             fontSize: 12,
                                                      //             fontWeight:
                                                      //                 FontWeight
                                                      //                     .bold,
                                                      //             color: Colors
                                                      //                 .white,
                                                      //           ),
                                                      //         ),
                                                      //       ),
                                                      //       Align(
                                                      //         alignment: Alignment
                                                      //             .topLeft,
                                                      //         child: Text(
                                                      //           (createInvoiceContractorViewModel
                                                      //                           .createInvoiceContractorViewModelGetTabularData
                                                      //                           .data!
                                                      //                           .findAllTableData![
                                                      //                               index]
                                                      //                           .totalCost ==
                                                      //                       null ||
                                                      //                   createInvoiceContractorViewModel
                                                      //                           .createInvoiceContractorViewModelGetTabularData
                                                      //                           .data!
                                                      //                           .findAllTableData![
                                                      //                               index]
                                                      //                           .totalCost
                                                      //                           .toString() ==
                                                      //                       'null')
                                                      //               ? ''
                                                      //               : createInvoiceContractorViewModel
                                                      //                   .createInvoiceContractorViewModelGetTabularData
                                                      //                   .data!
                                                      //                   .findAllTableData![
                                                      //                       index]
                                                      //                   .totalCost
                                                      //                   .toString(),
                                                      //           textAlign:
                                                      //               TextAlign
                                                      //                   .left,
                                                      //           style:
                                                      //               const TextStyle(
                                                      //             fontSize: 12,
                                                      //             //  fontWeight:
                                                      //             //      FontWeight.bold,
                                                      //             color: Colors
                                                      //                 .white,
                                                      //           ),
                                                      //         ),
                                                      //       ),
                                                      //     ],
                                                      //   ),
                                                      // ),

                                                      Expanded(
                                                        // alignment: Alignment.topLeft,
                                                        child: Column(
                                                          children: [
                                                            const Align(
                                                              alignment:
                                                                  Alignment
                                                                      .topLeft,
                                                              child: Text(
                                                                "CREATE DATE: ",
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style:
                                                                    TextStyle(
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
                                                              child: Text(
                                                                (createInvoiceContractorViewModel.createInvoiceContractorViewModelGetTabularData.data!.findAllTableData![index].createDate ==
                                                                            null ||
                                                                        createInvoiceContractorViewModel.createInvoiceContractorViewModelGetTabularData.data!.findAllTableData![index].createDate.toString() ==
                                                                            'null')
                                                                    ? ''
                                                                    : formattedDate,
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 12,
                                                                  //  fontWeight:
                                                                  //      FontWeight.bold,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 2,
                                                        // alignment: Alignment.topLeft,
                                                        child: Column(
                                                          children: [
                                                            const Align(
                                                              alignment:
                                                                  Alignment
                                                                      .topLeft,
                                                              child: Text(
                                                                "ESTIMATED TIME: ",
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style:
                                                                    TextStyle(
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
                                                              child: Text(
                                                                (createInvoiceContractorViewModel.createInvoiceContractorViewModelGetTabularData.data!.findAllTableData![index].estTime ==
                                                                            null ||
                                                                        createInvoiceContractorViewModel.createInvoiceContractorViewModelGetTabularData.data!.findAllTableData![index].estTime.toString() ==
                                                                            'null')
                                                                    ? ''
                                                                    : createInvoiceContractorViewModel
                                                                        .createInvoiceContractorViewModelGetTabularData
                                                                        .data!
                                                                        .findAllTableData![
                                                                            index]
                                                                        .estTime
                                                                        .toString(),
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 12,
                                                                  //  fontWeight:
                                                                  //      FontWeight.bold,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                // const Divider(
                                                //   color: Colors.grey,
                                                // ),
                                                const Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 8.0),
                                                  child: Row(
                                                    children: [
                                                      // Expanded(
                                                      //   // alignment: Alignment.topLeft,
                                                      //   child: Column(
                                                      //     children: [
                                                      //       const Align(
                                                      //         alignment: Alignment
                                                      //             .topLeft,
                                                      //         child: Text(
                                                      //           "ESTIMATED COST: ",
                                                      //           textAlign:
                                                      //               TextAlign
                                                      //                   .left,
                                                      //           style: TextStyle(
                                                      //             fontSize: 12,
                                                      //             fontWeight:
                                                      //                 FontWeight
                                                      //                     .bold,
                                                      //             color: Colors
                                                      //                 .white,
                                                      //           ),
                                                      //         ),
                                                      //       ),
                                                      //       Align(
                                                      //         alignment: Alignment
                                                      //             .topLeft,
                                                      //         child: Text(
                                                      //           (createInvoiceContractorViewModel
                                                      //                           .createInvoiceContractorViewModelGetTabularData
                                                      //                           .data!
                                                      //                           .findAllTableData![
                                                      //                               index]
                                                      //                           .estCost ==
                                                      //                       null ||
                                                      //                   createInvoiceContractorViewModel
                                                      //                           .createInvoiceContractorViewModelGetTabularData
                                                      //                           .data!
                                                      //                           .findAllTableData![
                                                      //                               index]
                                                      //                           .estCost
                                                      //                           .toString() ==
                                                      //                       'null')
                                                      //               ? ''
                                                      //               : createInvoiceContractorViewModel
                                                      //                   .createInvoiceContractorViewModelGetTabularData
                                                      //                   .data!
                                                      //                   .findAllTableData![
                                                      //                       index]
                                                      //                   .estCost
                                                      //                   .toString(),
                                                      //           textAlign:
                                                      //               TextAlign
                                                      //                   .left,
                                                      //           style:
                                                      //               const TextStyle(
                                                      //             fontSize: 12,
                                                      //             //  fontWeight:
                                                      //             //      FontWeight.bold,
                                                      //             color: Colors
                                                      //                 .white,
                                                      //           ),
                                                      //         ),
                                                      //       ),
                                                      //     ],
                                                      //   ),
                                                      // ),

                                                      // Expanded(
                                                      //   // alignment: Alignment.topLeft,
                                                      //   child: Column(
                                                      //     children: [
                                                      //       const Align(
                                                      //         alignment: Alignment
                                                      //             .topLeft,
                                                      //         child: Text(
                                                      //           "ACTUAL COST: ",
                                                      //           textAlign:
                                                      //               TextAlign
                                                      //                   .left,
                                                      //           style: TextStyle(
                                                      //             fontSize: 12,
                                                      //             fontWeight:
                                                      //                 FontWeight
                                                      //                     .bold,
                                                      //             color: Colors
                                                      //                 .white,
                                                      //           ),
                                                      //         ),
                                                      //       ),
                                                      //       Align(
                                                      //         alignment: Alignment
                                                      //             .topLeft,
                                                      //         child: Text(
                                                      //           (createInvoiceContractorViewModel
                                                      //                           .createInvoiceContractorViewModelGetTabularData
                                                      //                           .data!
                                                      //                           .findAllTableData![
                                                      //                               index]
                                                      //                           .actualCost ==
                                                      //                       null ||
                                                      //                   createInvoiceContractorViewModel
                                                      //                           .createInvoiceContractorViewModelGetTabularData
                                                      //                           .data!
                                                      //                           .findAllTableData![
                                                      //                               index]
                                                      //                           .actualCost
                                                      //                           .toString() ==
                                                      //                       'null')
                                                      //               ? ''
                                                      //               : createInvoiceContractorViewModel
                                                      //                   .createInvoiceContractorViewModelGetTabularData
                                                      //                   .data!
                                                      //                   .findAllTableData![
                                                      //                       index]
                                                      //                   .actualCost
                                                      //                   .toString(),
                                                      //           textAlign:
                                                      //               TextAlign
                                                      //                   .left,
                                                      //           style:
                                                      //               const TextStyle(
                                                      //             fontSize: 12,
                                                      //             //  fontWeight:
                                                      //             //      FontWeight.bold,
                                                      //             color: Colors
                                                      //                 .white,
                                                      //           ),
                                                      //         ),
                                                      //       ),
                                                      //     ],
                                                      //   ),
                                                      // ),
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

  fetchData(String substation, String feeder) {
    createInvoiceContractorViewModel
        .fetchCreateInvoiceContractorViewModelTabularListApi(
            context, substation, feeder);
  }

  // Future<void> _filterData(String query) async {
  //   if (query.isEmpty) {
  //     createInvoiceContractorViewModel
  //         .fetchCreateInvoiceContractorViewModelTabularListApi(context, '', '');
  //   } else {
  //     createInvoiceContractorViewModel
  //             .createInvoiceContractorViewModelGetTabularData
  //             .data!
  //             .findAllTableData =
  //         createInvoiceContractorViewModel
  //             .createInvoiceContractorViewModelGetTabularData
  //             .data!
  //             .findAllTableData!
  //             .where((item) =>
  //                 item.type!.toLowerCase().contains(query.toLowerCase()) ||
  //                 item.status!.toString().contains(query.toLowerCase()) ||
  //                 item.substation!
  //                     .toLowerCase()
  //                     .contains(query.toLowerCase()) ||
  //                 item.fdrName!.toString().contains(query.toLowerCase()) ||
  //                 item.maintType!.toLowerCase().contains(query.toLowerCase()) ||
  //                 item.totalMiles!.toString().contains(query.toLowerCase()) ||
  //                 item.contractYear!
  //                     .toLowerCase()
  //                     .contains(query.toLowerCase()) ||
  //                 item.cycle!.toString().contains(query.toLowerCase()) ||
  //                 item.streetAddress!
  //                     .toLowerCase()
  //                     .contains(query.toLowerCase()) ||
  //                 item.mapLocation!.toString().contains(query.toLowerCase()) ||
  //                 item.adminNotes1!
  //                     .toLowerCase()
  //                     .contains(query.toLowerCase()) ||
  //                 item.contractorNotes!
  //                     .toString()
  //                     .contains(query.toLowerCase()) ||
  //                 item.adminNotes2!
  //                     .toLowerCase()
  //                     .contains(query.toLowerCase()) ||
  //                 item.contactorCompany!.toString().contains(query.toLowerCase()) ||
  //                 item.dateOfInspection!.toLowerCase().contains(query.toLowerCase()) ||
  //                 item.followUpDate!.toString().contains(query.toLowerCase()) ||
  //                 item.costPerMile!.toLowerCase().contains(query.toLowerCase()) ||
  //                 item.totalCost!.toString().contains(query.toLowerCase()) ||
  //                 item.nextMaintDue!.toLowerCase().contains(query.toLowerCase()) ||
  //                 item.createDate!.toLowerCase().contains(query.toLowerCase()) ||
  //                 item.contractor!.toString().toLowerCase().contains(query.toLowerCase()))
  //             .toList();
  //   }
  //   setState(() {});
  // }

//

  Future<void> _filterData(String query) async {
    if (query.isEmpty) {
      selectedSubstation = null;
      selectedFeeder = null;
      createInvoiceContractorViewModel
          .fetchCreateInvoiceContractorViewModelTabularListApi(context, '', '');
    } else {
      createInvoiceContractorViewModel
              .createInvoiceContractorViewModelGetTabularData
              .data!
              .findAllTableData =
          createInvoiceContractorViewModel
              .createInvoiceContractorViewModelGetTabularData
              .data!
              .findAllTableData!
              .where((item) =>
                  item.maintType!.toLowerCase().contains(query.toLowerCase()) ||
                  item.id!
                      .toString()
                      .toLowerCase()
                      .contains(query.toLowerCase()))
              .toList();
    }
    setState(() {});
  }

  void newDateFormat(
    int index,
  ) {
    String? rawContractYear = createInvoiceContractorViewModel
        .createInvoiceContractorViewModelGetTabularData
        .data!
        .findAllTableData![index]
        .contractYear
        ?.toString();

    String? rawNextMaintDue = createInvoiceContractorViewModel
        .createInvoiceContractorViewModelGetTabularData
        .data!
        .findAllTableData![index]
        .nextMaintDue
        ?.toString();
    formattedContractYear = extractYear(rawContractYear);
    formattedNextMaintDue = extractYear(rawNextMaintDue);
    print('rawCreateDate $rawContractYear');
    print('formattedContractYear: $formattedContractYear');
    print('formattedNextMaintDue: $formattedNextMaintDue');
  }

  String extractYear(String? date) {
    if (date == null || date.isEmpty || date == "N/A") {
      return ""; // Handle null or invalid dates
    }
    try {
      if (date.contains('T')) {
        // ISO 8601 format (e.g., 2024-12-07T11:37:16.750+00:00)
        DateTime parsedDate = DateTime.parse(date);
        return parsedDate.year.toString();
      } else if (date.contains(' ')) {
        // Formats like "Dec  7 2024 12:00AM"
        String normalizedDate =
            date.replaceAll(RegExp(r'\s+'), ' '); // Remove extra spaces
        DateTime parsedDate =
            DateFormat("MMM d yyyy h:mma").parse(normalizedDate);
        return parsedDate.year.toString();
      } else if (date.contains('/')) {
        // Format MM/dd/yyyy
        DateTime parsedDate = DateFormat("MM/dd/yyyy").parse(date);
        return parsedDate.year.toString();
      }
    } catch (e) {
      print("Error parsing date: $date, Error: $e");
    }
    return ""; // Default if parsing fails
  }

   Future<void> checkCurrentUser() async {
    print('planner authentication');

    try {
      final prefs = await SharedPreferences.getInstance();

      final fcmToken = prefs.getString('device_token_for_logOut');

      if (fcmToken == null || fcmToken.isEmpty) {
        print("FCM token not found in SharedPreferences");
        return;
      }
      final userPreferences1 = Provider.of<UserPref>(context, listen: false);

      UserModel data = await userPreferences1.getUser();

      final String id = data.user!.id.toString();

      final apiUrl =
          "${AppUrl.baseUrl}login_user/checkCurrentUser"
          "?fcmToken=${Uri.encodeQueryComponent(fcmToken)}"
          "&userId=${Uri.encodeQueryComponent(id)}";

      final url = Uri.parse(apiUrl);

      print("API URL for authentication: $url");
      print("Bearer Token: ${data.token}");

      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer ${data.token!}',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      print("Status Code: ${response.statusCode}");
      print("Response: ${response.body}");

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        print("Current User Response: $responseData");

        if (responseData == false) {
          final userPreferences = Provider.of<UserPref>(context, listen: false);

          await userPreferences.remove();

          if (!mounted) return;

          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (BuildContext context) => const LoginPage(),
            ),
            (route) => false,
          );
        }
      } else if (response.statusCode == 401) {
        print("Unauthorized - Bearer token is invalid or expired");
      } else {
        print(
          "checkCurrentUser failed: "
          "${response.statusCode} - ${response.body}",
        );
      }
    } catch (e) {
      print("checkCurrentUser Error: $e");
    }
  }

  Future<void> _initializeScreen() async {
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    await checkCurrentUser();
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
menuLogoLCP(), const SizedBox(height: 6),
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
                Icons.closed_caption_off,
              ),
              title: const Text('IVM/Change Order'),
              textColor: const Color.fromARGB(255, 7, 59, 120),
              iconColor: const Color.fromARGB(255, 7, 59, 120),
              onTap: () {
                // Navigator.of(context).push(MaterialPageRoute(
                //     builder: (BuildContext context) =>
                //         const ChangeOrderContractor()));
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) =>  Inspection(year: '',),));
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
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) =>
                        const InvoiceFormContractor()));
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
                Icons.pin_invoke_outlined,
              ),
              title: const Text('Create Invoice'),
              textColor: const Color.fromARGB(255, 7, 59, 120),
              iconColor: const Color.fromARGB(255, 7, 59, 120),
              onTap: () {
                Navigator.pop(context);
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
                }),
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
            ), ],
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
        ),],
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
