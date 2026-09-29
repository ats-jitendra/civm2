import 'dart:io';
import 'package:CIVM/utils/common_functions.dart';
import 'package:CIVM/data/response/status.dart';
import 'package:CIVM/models/user_model.dart';
import 'package:CIVM/screens/generalForeman_New_pannel/contractor_bottom_navigation.dart';
import 'package:CIVM/screens/generalForeman_New_pannel/create_invoice_contractor.dart';
import 'package:CIVM/screens/generalForeman_New_pannel/gf_add_crew_member.dart';
import 'package:CIVM/screens/generalForeman_New_pannel/gf_maintenance_report_view_new.dart';
import 'package:CIVM/screens/generalForeman_New_pannel/inspection.dart';
import 'package:CIVM/screens/generalForeman_New_pannel/invoice_form_contractor.dart';
import 'package:CIVM/screens/leaflat_map/leaf_lat_map_wakeLock.dart';
import 'package:CIVM/screens/map/provider/location_provider.dart';
import 'package:CIVM/sharedPrefs/constants.dart';
import 'package:CIVM/utils/user_pref.dart';
import 'package:CIVM/view_model/invoice_list_contractor_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import '../login_page.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:image/image.dart' as img;

class InvoiceListContrator extends StatefulWidget {
  const InvoiceListContrator({Key? key}) : super(key: key);

  @override
  State<InvoiceListContrator> createState() => _InvoiceListContratorState();
}

class _InvoiceListContratorState extends State<InvoiceListContrator> {
  // final List<Widget> _children = [
  //   RowMaintenancePlan(),
  //   // BottomNavigationHomePage(),
  //   // BottomNavigationAccountPage()
  // ];
  List<String> menu = [];

  List<Map<String, dynamic>> listOfColumns = [];
  List<Map<String, dynamic>> listOfColumns1 = [];
  final TextEditingController _input = TextEditingController();

  // ignore: non_constant_identifier_names
  List<String> select_WorkOrderNo = ['35', '32', '31', '30'];
  // ignore: non_constant_identifier_names
  String? WorkOrderNo;

  onTappedBar(int index) {
    setState(() {
      // _currentIndex = index;
    });
  }

  InvoiceListViewModel invoiceListViewModel = InvoiceListViewModel();

  String formattedContractYear = '';
  String formattedNextMaintDue = '';

  @override
  void initState() {
    invoiceListViewModel.fetchInvoiceListTabularListApi(context);
    // invoiceListViewModel.fetchInvoiceApi(context, '78');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text(
            'Invoice List',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: const Color.fromARGB(255, 7, 59, 120),
        ),
        drawer: DrawerManu(menu: menu),
        body: ChangeNotifierProvider<InvoiceListViewModel>(
            create: (BuildContext context) => invoiceListViewModel,
            child: Consumer<InvoiceListViewModel>(builder: (context, value, _) {
              switch (value.invoiceListGetTabularData.status) {
                case Status.LOADING:
                  return const Center(child: CircularProgressIndicator());
                case Status.ERROR:
                  return
                      // CustomToastSnackBarProgressDialog.flushBarErrorMessage(
                      //     value.invoiceListGetTabularData.message.toString(),
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
                  // table1Data();
                  return RefreshIndicator(
                    onRefresh: () async {
                      _input.clear();
                      await invoiceListViewModel
                          .fetchInvoiceListTabularListApi(context);
                    },
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(
                                top: 4, bottom: 4, left: 4, right: 4),
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
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0,
                                        right: 8.0,
                                        top: 4,
                                        bottom: 4),
                                    child: TextFormField(
                                      onChanged: (value) => _filterData(value),
                                      controller: _input,
                                      style: const TextStyle(
                                        color: Color.fromARGB(255, 7, 59, 120),
                                        fontSize: 16,
                                      ),
                                      obscureText: false,
                                      decoration: const InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color:
                                                Color.fromARGB(255, 23, 1, 88),
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color:
                                                Color.fromARGB(255, 23, 1, 88),
                                          ),
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
                                Expanded(
                                  child: ListView.builder(
                                      itemCount: invoiceListViewModel
                                          .invoiceListGetTabularData
                                          .data!
                                          .findInvoiceListDatas!
                                          .length,
                                      itemBuilder:
                                          (BuildContext ctxt, int index) {
                                        String? dateStringCreateDate =
                                            invoiceListViewModel
                                                .invoiceListGetTabularData
                                                .data!
                                                .findInvoiceListDatas![index]
                                                .createDate;

                                        String formattedDateCreateDate = '';
                                        print('1111111111111111111111');
                                        print(
                                            'object111111111111111   ${invoiceListViewModel.invoiceListGetTabularData.data!.findInvoiceListDatas![0].nextMaintDue}');
                                        if (dateStringCreateDate != null) {
                                          DateTime date = DateTime.parse(
                                              dateStringCreateDate);
                                          formattedDateCreateDate =
                                              DateFormat('MM/dd/yyyy')
                                                  .format(date);
                                        } else {
                                          formattedDateCreateDate = '';
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
                                                    0.95,
                                                // height: MediaQuery.of(context)
                                                //         .size
                                                //         .height *
                                                //     0.73,
                                                // margin:  EdgeInsets.only(
                                                //     top: 5.0, bottom: 5.0, left: 2,right: 2),
                                                padding:
                                                    const EdgeInsets.all(8),
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
                                                          flex: 1,
                                                          // alignment: Alignment.topLeft,
                                                          child: Column(
                                                            children: [
                                                              const Align(
                                                                alignment:
                                                                    Alignment
                                                                        .topLeft,
                                                                child: Text(
                                                                  "SERIAL: ",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        12,
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
                                                                  (index + 1)
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
                                                                  "JOB NO: ",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        12,
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
                                                                  (invoiceListViewModel.invoiceListGetTabularData.data!.findInvoiceListDatas![index].tokenNo ==
                                                                              null ||
                                                                          invoiceListViewModel.invoiceListGetTabularData.data!.findInvoiceListDatas![index].tokenNo.toString() ==
                                                                              'null')
                                                                      ? ''
                                                                      : invoiceListViewModel
                                                                          .invoiceListGetTabularData
                                                                          .data!
                                                                          .findInvoiceListDatas![
                                                                              index]
                                                                          .tokenNo
                                                                          .toString(),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        12,
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
                                                        //         alignment:
                                                        //             Alignment
                                                        //                 .topLeft,
                                                        //         child: Text(
                                                        //           "VIEW: ",
                                                        //           textAlign:
                                                        //               TextAlign
                                                        //                   .left,
                                                        //           style:
                                                        //               TextStyle(
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
                                                        //           alignment:
                                                        //               Alignment
                                                        //                   .topLeft,
                                                        //           child: InkWell(
                                                        //             onTap: () {
                                                        //               // await invoiceListViewModel.fetchInvoiceApi(
                                                        //               //     context,
                                                        //               //     invoiceListViewModel
                                                        //               //         .invoiceListGetTabularData
                                                        //               //         .data!
                                                        //               //         .findInvoiceListDatas![index]
                                                        //               //         .id
                                                        //               //         .toString());
                                                        //               // openPdf(invoiceListViewModel
                                                        //               //     .invoiceListGetTabularData
                                                        //               //     .data!
                                                        //               //     .findInvoiceListDatas![
                                                        //               //         index]
                                                        //               //     .id
                                                        //               //     .toString());
                                                        //               // Navigator.of(
                                                        //               //         context)
                                                        //               //     .push(MaterialPageRoute(
                                                        //               //         builder: (BuildContext context) =>
                                                        //               //             InvoicePage(id: invoiceListViewModel.invoiceListGetTabularData.data!.findInvoiceListDatas![index].id.toString())));
                                                        //               invoiceListViewModel.fetchInvoiceApi(
                                                        //                   context,
                                                        //                   invoiceListViewModel
                                                        //                       .invoiceListGetTabularData
                                                        //                       .data!
                                                        //                       .findInvoiceListDatas![index]
                                                        //                       .id
                                                        //                       .toString());
                                                        //               openPdf(invoiceListViewModel
                                                        //                   .invoiceListGetTabularData
                                                        //                   .data!
                                                        //                   .findInvoiceListDatas![
                                                        //                       index]
                                                        //                   .id
                                                        //                   .toString());

                                                        //               table1Data();
                                                        //             },
                                                        //             child:
                                                        //                 const Icon(
                                                        //               Icons
                                                        //                   .remove_red_eye,
                                                        //               color: Colors
                                                        //                   .red,
                                                        //             ),
                                                        //           )),
                                                        //     ],
                                                        //   ),
                                                        // ),
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
                                                                    fontSize:
                                                                        12,
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
                                                                  (invoiceListViewModel.invoiceListGetTabularData.data!.findInvoiceListDatas![index].status ==
                                                                              null ||
                                                                          invoiceListViewModel.invoiceListGetTabularData.data!.findInvoiceListDatas![index].status.toString() ==
                                                                              'null')
                                                                      ? ''
                                                                      : invoiceListViewModel
                                                                          .invoiceListGetTabularData
                                                                          .data!
                                                                          .findInvoiceListDatas![
                                                                              index]
                                                                          .status
                                                                          .toString(),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        12,
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
                                                                    fontSize:
                                                                        12,
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
                                                                  (invoiceListViewModel.invoiceListGetTabularData.data!.findInvoiceListDatas![index].substation ==
                                                                              null ||
                                                                          invoiceListViewModel.invoiceListGetTabularData.data!.findInvoiceListDatas![index].substation.toString() ==
                                                                              'null')
                                                                      ? ''
                                                                      : invoiceListViewModel
                                                                          .invoiceListGetTabularData
                                                                          .data!
                                                                          .findInvoiceListDatas![
                                                                              index]
                                                                          .substation
                                                                          .toString(),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        12,
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
                                                                    fontSize:
                                                                        12,
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
                                                                  (invoiceListViewModel.invoiceListGetTabularData.data!.findInvoiceListDatas![index].fdrName ==
                                                                              null ||
                                                                          invoiceListViewModel.invoiceListGetTabularData.data!.findInvoiceListDatas![index].fdrName.toString() ==
                                                                              'null')
                                                                      ? ''
                                                                      : invoiceListViewModel
                                                                          .invoiceListGetTabularData
                                                                          .data!
                                                                          .findInvoiceListDatas![
                                                                              index]
                                                                          .fdrName
                                                                          .toString(),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        12,
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
                                                                    fontSize:
                                                                        12,
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
                                                                  (invoiceListViewModel.invoiceListGetTabularData.data!.findInvoiceListDatas![index].type ==
                                                                              null ||
                                                                          invoiceListViewModel.invoiceListGetTabularData.data!.findInvoiceListDatas![index].type.toString() ==
                                                                              'null')
                                                                      ? ''
                                                                      : invoiceListViewModel
                                                                          .invoiceListGetTabularData
                                                                          .data!
                                                                          .findInvoiceListDatas![
                                                                              index]
                                                                          .type
                                                                          .toString(),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        12,
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
                                                                    fontSize:
                                                                        12,
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
                                                                  (invoiceListViewModel.invoiceListGetTabularData.data!.findInvoiceListDatas![index].contractor ==
                                                                              null ||
                                                                          invoiceListViewModel.invoiceListGetTabularData.data!.findInvoiceListDatas![index].contractor.toString() ==
                                                                              'null')
                                                                      ? ''
                                                                      : invoiceListViewModel
                                                                          .invoiceListGetTabularData
                                                                          .data!
                                                                          .findInvoiceListDatas![
                                                                              index]
                                                                          .contractor
                                                                          .toString(),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        12,
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
                                                                    fontSize:
                                                                        12,
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
                                                                  (invoiceListViewModel.invoiceListGetTabularData.data!.findInvoiceListDatas![index].totalMiles ==
                                                                              null ||
                                                                          invoiceListViewModel.invoiceListGetTabularData.data!.findInvoiceListDatas![index].totalMiles.toString() ==
                                                                              'null')
                                                                      ? ''
                                                                      : invoiceListViewModel
                                                                          .invoiceListGetTabularData
                                                                          .data!
                                                                          .findInvoiceListDatas![
                                                                              index]
                                                                          .totalMiles
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
                                                                    fontSize:
                                                                        12,
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
                                                                  (invoiceListViewModel.invoiceListGetTabularData.data!.findInvoiceListDatas![index].contractYear ==
                                                                              null ||
                                                                          invoiceListViewModel.invoiceListGetTabularData.data!.findInvoiceListDatas![index].contractYear.toString() ==
                                                                              'null')
                                                                      ? ''
                                                                      : formattedContractYear,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        12,
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
                                                                    fontSize:
                                                                        12,
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
                                                                  (invoiceListViewModel.invoiceListGetTabularData.data!.findInvoiceListDatas![index].cycle ==
                                                                              null ||
                                                                          invoiceListViewModel.invoiceListGetTabularData.data!.findInvoiceListDatas![index].cycle.toString() ==
                                                                              'null')
                                                                      ? ''
                                                                      : invoiceListViewModel
                                                                          .invoiceListGetTabularData
                                                                          .data!
                                                                          .findInvoiceListDatas![
                                                                              index]
                                                                          .cycle
                                                                          .toString(),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        12,
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
                                                                    fontSize:
                                                                        12,
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
                                                                  (invoiceListViewModel.invoiceListGetTabularData.data!.findInvoiceListDatas![index].streetAddress ==
                                                                              null ||
                                                                          invoiceListViewModel.invoiceListGetTabularData.data!.findInvoiceListDatas![index].streetAddress.toString() ==
                                                                              'null')
                                                                      ? ''
                                                                      : invoiceListViewModel
                                                                          .invoiceListGetTabularData
                                                                          .data!
                                                                          .findInvoiceListDatas![
                                                                              index]
                                                                          .streetAddress
                                                                          .toString(),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        12,
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
                                                                    fontSize:
                                                                        12,
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
                                                                  (invoiceListViewModel.invoiceListGetTabularData.data!.findInvoiceListDatas![index].mapLocation ==
                                                                              null ||
                                                                          invoiceListViewModel.invoiceListGetTabularData.data!.findInvoiceListDatas![index].mapLocation.toString() ==
                                                                              'null')
                                                                      ? ''
                                                                      : invoiceListViewModel
                                                                          .invoiceListGetTabularData
                                                                          .data!
                                                                          .findInvoiceListDatas![
                                                                              index]
                                                                          .mapLocation
                                                                          .toString(),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        12,
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
                                                                    fontSize:
                                                                        12,
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
                                                                  (invoiceListViewModel.invoiceListGetTabularData.data!.findInvoiceListDatas![index].adminNotes1 ==
                                                                              null ||
                                                                          invoiceListViewModel.invoiceListGetTabularData.data!.findInvoiceListDatas![index].adminNotes1.toString() ==
                                                                              'null')
                                                                      ? ''
                                                                      : invoiceListViewModel
                                                                          .invoiceListGetTabularData
                                                                          .data!
                                                                          .findInvoiceListDatas![
                                                                              index]
                                                                          .adminNotes1
                                                                          .toString(),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        12,
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
                                                                  "GENERAL FOREMAN NOTES 2: ",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        12,
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
                                                                  (invoiceListViewModel.invoiceListGetTabularData.data!.findInvoiceListDatas![index].contractorNotes ==
                                                                              null ||
                                                                          invoiceListViewModel.invoiceListGetTabularData.data!.findInvoiceListDatas![index].contractorNotes.toString() ==
                                                                              'null')
                                                                      ? ''
                                                                      : invoiceListViewModel
                                                                          .invoiceListGetTabularData
                                                                          .data!
                                                                          .findInvoiceListDatas![
                                                                              index]
                                                                          .contractorNotes
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
                                                                  "CONTRACTOR COMPANY: ",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        12,
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
                                                                  (invoiceListViewModel.invoiceListGetTabularData.data!.findInvoiceListDatas![index].contactorCompany ==
                                                                              null ||
                                                                          invoiceListViewModel.invoiceListGetTabularData.data!.findInvoiceListDatas![index].contactorCompany.toString() ==
                                                                              'null')
                                                                      ? ''
                                                                      : invoiceListViewModel
                                                                          .invoiceListGetTabularData
                                                                          .data!
                                                                          .findInvoiceListDatas![
                                                                              index]
                                                                          .contactorCompany
                                                                          .toString(),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        12,
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
                                                                  "DATE OF INSPECTION: ",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        12,
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
                                                                  (invoiceListViewModel.invoiceListGetTabularData.data!.findInvoiceListDatas![index].dateOfInspection ==
                                                                              null ||
                                                                          invoiceListViewModel.invoiceListGetTabularData.data!.findInvoiceListDatas![index].dateOfInspection.toString() ==
                                                                              'null')
                                                                      ? ''
                                                                      : invoiceListViewModel
                                                                          .invoiceListGetTabularData
                                                                          .data!
                                                                          .findInvoiceListDatas![
                                                                              index]
                                                                          .dateOfInspection
                                                                          .toString(),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        12,
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
                                                                    fontSize:
                                                                        12,
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
                                                                  (invoiceListViewModel.invoiceListGetTabularData.data!.findInvoiceListDatas![index].followUpDate ==
                                                                              null ||
                                                                          invoiceListViewModel.invoiceListGetTabularData.data!.findInvoiceListDatas![index].followUpDate.toString() ==
                                                                              'null')
                                                                      ? ''
                                                                      : invoiceListViewModel
                                                                          .invoiceListGetTabularData
                                                                          .data!
                                                                          .findInvoiceListDatas![
                                                                              index]
                                                                          .followUpDate
                                                                          .toString(),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        12,
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
                                                        //         alignment:
                                                        //             Alignment
                                                        //                 .topLeft,
                                                        //         child: Text(
                                                        //           "COST PER MILE: ",
                                                        //           textAlign:
                                                        //               TextAlign
                                                        //                   .left,
                                                        //           style:
                                                        //               TextStyle(
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
                                                        //         alignment:
                                                        //             Alignment
                                                        //                 .topLeft,
                                                        //         child: Text(
                                                        //           (invoiceListViewModel.invoiceListGetTabularData.data!.findInvoiceListDatas![index].costPerMile ==
                                                        //                       null ||
                                                        //                   invoiceListViewModel.invoiceListGetTabularData.data!.findInvoiceListDatas![index].costPerMile.toString() ==
                                                        //                       'null')
                                                        //               ? ''
                                                        //               : invoiceListViewModel
                                                        //                   .invoiceListGetTabularData
                                                        //                   .data!
                                                        //                   .findInvoiceListDatas![
                                                        //                       index]
                                                        //                   .costPerMile
                                                        //                   .toString(),
                                                        //           textAlign:
                                                        //               TextAlign
                                                        //                   .left,
                                                        //           style:
                                                        //               const TextStyle(
                                                        //             fontSize: 12,
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
                                                        //         alignment:
                                                        //             Alignment
                                                        //                 .topLeft,
                                                        //         child: Text(
                                                        //           "TOTAL COST: ",
                                                        //           textAlign:
                                                        //               TextAlign
                                                        //                   .left,
                                                        //           style:
                                                        //               TextStyle(
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
                                                        //         alignment:
                                                        //             Alignment
                                                        //                 .topLeft,
                                                        //         child: Text(
                                                        //           (invoiceListViewModel.invoiceListGetTabularData.data!.findInvoiceListDatas![index].totalCost ==
                                                        //                       null ||
                                                        //                   invoiceListViewModel.invoiceListGetTabularData.data!.findInvoiceListDatas![index].totalCost.toString() ==
                                                        //                       'null')
                                                        //               ? ''
                                                        //               : invoiceListViewModel
                                                        //                   .invoiceListGetTabularData
                                                        //                   .data!
                                                        //                   .findInvoiceListDatas![
                                                        //                       index]
                                                        //                   .totalCost
                                                        //                   .toString(),
                                                        //           textAlign:
                                                        //               TextAlign
                                                        //                   .left,
                                                        //           style:
                                                        //               const TextStyle(
                                                        //             fontSize: 12,
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
                                                                    fontSize:
                                                                        12,
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
                                                                  (invoiceListViewModel.invoiceListGetTabularData.data!.findInvoiceListDatas![index].nextMaintDue ==
                                                                              null ||
                                                                          invoiceListViewModel.invoiceListGetTabularData.data!.findInvoiceListDatas![index].nextMaintDue.toString() ==
                                                                              'null')
                                                                      ? ''
                                                                      : formattedNextMaintDue,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        12,
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
                                                                  "CREATE DATE: ",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        12,
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
                                                                  (invoiceListViewModel.invoiceListGetTabularData.data!.findInvoiceListDatas![index].createDate ==
                                                                              null ||
                                                                          invoiceListViewModel.invoiceListGetTabularData.data!.findInvoiceListDatas![index].createDate.toString() ==
                                                                              'null')
                                                                      ? ''
                                                                      : formattedDateCreateDate,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        12,
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
                                                                  "ESTIMATED TIME: ",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        12,
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
                                                                  (invoiceListViewModel.invoiceListGetTabularData.data!.findInvoiceListDatas![index].estTime ==
                                                                              null ||
                                                                          invoiceListViewModel.invoiceListGetTabularData.data!.findInvoiceListDatas![index].estTime.toString() ==
                                                                              'null')
                                                                      ? ''
                                                                      : invoiceListViewModel
                                                                          .invoiceListGetTabularData
                                                                          .data!
                                                                          .findInvoiceListDatas![
                                                                              index]
                                                                          .estTime
                                                                          .toString(),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        12,
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
                                                        //         alignment:
                                                        //             Alignment
                                                        //                 .topLeft,
                                                        //         child: Text(
                                                        //           "ESTIMATED COST: ",
                                                        //           textAlign:
                                                        //               TextAlign
                                                        //                   .left,
                                                        //           style:
                                                        //               TextStyle(
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
                                                        //         alignment:
                                                        //             Alignment
                                                        //                 .topLeft,
                                                        //         child: Text(
                                                        //           (invoiceListViewModel.invoiceListGetTabularData.data!.findInvoiceListDatas![index].estCost ==
                                                        //                       null ||
                                                        //                   invoiceListViewModel.invoiceListGetTabularData.data!.findInvoiceListDatas![index].estCost.toString() ==
                                                        //                       'null')
                                                        //               ? ''
                                                        //               : invoiceListViewModel
                                                        //                   .invoiceListGetTabularData
                                                        //                   .data!
                                                        //                   .findInvoiceListDatas![
                                                        //                       index]
                                                        //                   .estCost
                                                        //                   .toString(),
                                                        //           textAlign:
                                                        //               TextAlign
                                                        //                   .left,
                                                        //           style:
                                                        //               const TextStyle(
                                                        //             fontSize: 12,
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
                                                  // const Divider(
                                                  //   color: Colors.grey,
                                                  // ),
                                                  // Padding(
                                                  //   padding:
                                                  //       const EdgeInsets.only(
                                                  //           left: 8.0),
                                                  //   child: Row(
                                                  //     children: [
                                                  //       Expanded(
                                                  //         // alignment: Alignment.topLeft,
                                                  //         child: Column(
                                                  //           children: [
                                                  //             const Align(
                                                  //               alignment:
                                                  //                   Alignment
                                                  //                       .topLeft,
                                                  //               child: Text(
                                                  //                 "ACTUAL COST: ",
                                                  //                 textAlign:
                                                  //                     TextAlign
                                                  //                         .left,
                                                  //                 style:
                                                  //                     TextStyle(
                                                  //                   fontSize: 12,
                                                  //                   fontWeight:
                                                  //                       FontWeight
                                                  //                           .bold,
                                                  //                   color: Colors
                                                  //                       .white,
                                                  //                 ),
                                                  //               ),
                                                  //             ),
                                                  //             Align(
                                                  //               alignment:
                                                  //                   Alignment
                                                  //                       .topLeft,
                                                  //               child: Text(
                                                  //                 (invoiceListViewModel.invoiceListGetTabularData.data!.findInvoiceListDatas![index].actualCost ==
                                                  //                             null ||
                                                  //                         invoiceListViewModel.invoiceListGetTabularData.data!.findInvoiceListDatas![index].actualCost.toString() ==
                                                  //                             'null')
                                                  //                     ? ''
                                                  //                     : invoiceListViewModel
                                                  //                         .invoiceListGetTabularData
                                                  //                         .data!
                                                  //                         .findInvoiceListDatas![
                                                  //                             index]
                                                  //                         .actualCost
                                                  //                         .toString(),
                                                  //                 textAlign:
                                                  //                     TextAlign
                                                  //                         .left,
                                                  //                 style:
                                                  //                     const TextStyle(
                                                  //                   fontSize: 12,
                                                  //                   color: Colors
                                                  //                       .white,
                                                  //                 ),
                                                  //               ),
                                                  //             ),
                                                  //           ],
                                                  //         ),
                                                  //       ),
                                                  //     ],
                                                  //   ),
                                                  // ),
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
                        ],
                      ),
                    ),
                  );
                default:
                  return const Text('data');
              }
            })));
  }

  Future<void> _filterData(String query) async {
    if (query.isEmpty) {
      invoiceListViewModel.fetchInvoiceListTabularListApi(context);
    } else {
      invoiceListViewModel
              .invoiceListGetTabularData.data!.findInvoiceListDatas =
          invoiceListViewModel
              .invoiceListGetTabularData.data!.findInvoiceListDatas!
              .where((item) =>
                  item.id!.toString().contains(query.toLowerCase()) ||
                  item.status!.toString().contains(query.toLowerCase()) ||
                  item.substation!.toString().contains(query.toLowerCase()) ||
                  item.type!.toString().contains(query.toLowerCase()) ||
                  item.contractor!.toString().contains(query.toLowerCase()) ||
                  item.cycle!.toString().contains(query.toLowerCase()) ||
                  item.streetAddress!
                      .toString()
                      .contains(query.toLowerCase()) ||
                  item.mapLocation!.toString().contains(query.toLowerCase()) ||
                  item.adminNotes1!.toString().contains(query.toLowerCase()) ||
                  item.contractorNotes!
                      .toString()
                      .contains(query.toLowerCase()) ||
                  item.contactorCompany!
                      .toString()
                      .contains(query.toLowerCase()) ||
                  item.dateOfInspection!
                      .toString()
                      .contains(query.toLowerCase()) ||
                  item.followUpDate!.toString().contains(query.toLowerCase()) ||
                  item.costPerMile!.toString().contains(query.toLowerCase()) ||
                  item.totalCost!.toString().contains(query.toLowerCase()) ||
                  item.nextMaintDue!.toString().contains(query.toLowerCase()) ||
                  item.createDate!.toString().contains(query.toLowerCase()) ||
                  item.fdrName!
                      .toString()
                      .toLowerCase()
                      .contains(query.toLowerCase()))
              .toList();
    }
    setState(() {});
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
      value: item,
      child: Text(item,
          style: const TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 20,
          )));

  Future<void> openPdf(String tokenNo) async {
    writeOnPdf(tokenNo);
    // final output = await getExternalStorageDirectory();
    // final file = File("${output!.path}/example.pdf");
    // OpenFile.open(file.path);
    final output = await getExternalStorageDirectory();
    final file = File("${output!.path}/invoiceCIVM.pdf");
    await file.writeAsBytes(await pdf.save());
    OpenFile.open(file.path);
  }

  Future<void> savePdf() async {
    final output = await getExternalStorageDirectory();
    final file = File("${output!.path}/invoiceCIVM.pdf");
    await file.writeAsBytes(await pdf.save());
    OpenFile.open(file.path);
  }

  final pdf = pw.Document();
  List<Map<String, dynamic>> tableData = [];
  String total = '';
  String laborTotal = '';
  String invoiceTotal = '';
  String invoiceData = '';
  String formattedDate = '';

  List<Map<String, dynamic>> table1Data() {
    tableData.clear();
    for (var i = 0;
        i < invoiceListViewModel.invoiceData.data!.findInvoiceByTokenNo!.length;
        i++) {
      var invoice =
          invoiceListViewModel.invoiceData.data!.findInvoiceByTokenNo![i];

      tableData.add({
        'Serial': (i + 1).toString(),
        'Employee Name':
            (invoice.empName == null || invoice.empName.toString() == 'null')
                ? ''
                : invoice.empName,
        'Employee Type':
            (invoice.empType == null || invoice.empType.toString() == 'null')
                ? ''
                : invoice.empType,
        'Total Hours': (invoice.workingHrs == null ||
                invoice.workingHrs.toString() == 'null')
            ? ''
            : invoice.workingHrs,
        'Hourly Rate (\$)':
            (invoice.hrlyRate == null || invoice.hrlyRate.toString() == 'null')
                ? ''
                : invoice.hrlyRate,
        'Labor Cost (\$)': (invoice.laborCost == null ||
                invoice.laborCost.toString() == 'null')
            ? ''
            : invoice.laborCost,
      });
      total = (invoiceListViewModel
                      .invoiceData.data!.findInvoiceByTokenNo![i].laborTotal ==
                  null ||
              invoiceListViewModel
                      .invoiceData.data!.findInvoiceByTokenNo![i].laborTotal
                      .toString() ==
                  'null')
          ? ''
          : invoiceListViewModel
              .invoiceData.data!.findInvoiceByTokenNo![i].laborTotal
              .toString();
      laborTotal = (invoiceListViewModel
                      .invoiceData.data!.findInvoiceByTokenNo![i].laborTotal ==
                  null ||
              invoiceListViewModel
                      .invoiceData.data!.findInvoiceByTokenNo![i].laborTotal
                      .toString() ==
                  'null')
          ? ''
          : invoiceListViewModel
              .invoiceData.data!.findInvoiceByTokenNo![i].laborTotal
              .toString();
      invoiceTotal = (invoiceListViewModel.invoiceData.data!
                      .findInvoiceByTokenNo![i].invoiceTotal ==
                  null ||
              invoiceListViewModel
                      .invoiceData.data!.findInvoiceByTokenNo![i].invoiceTotal
                      .toString() ==
                  'null')
          ? ''
          : invoiceListViewModel
              .invoiceData.data!.findInvoiceByTokenNo![i].invoiceTotal
              .toString();
      invoiceData = (invoiceListViewModel
                      .invoiceData.data!.findInvoiceByTokenNo![i].invoiceDate ==
                  null ||
              invoiceListViewModel
                      .invoiceData.data!.findInvoiceByTokenNo![i].invoiceDate
                      .toString() ==
                  'null')
          ? ''
          : invoiceListViewModel
              .invoiceData.data!.findInvoiceByTokenNo![i].invoiceDate
              .toString();
      formattedDate =
          DateFormat('MMMM dd, yyyy').format(DateTime.parse(invoiceData));
    }
    return tableData;
  }

  // final List<Map<String, dynamic>> tableData = [
  //   {
  //     'Serial': '1',
  //     'Employee Name': 'John Doe',
  //     'Employee Type': 'Manager',
  //     'Total Hours': 50,
  //     'Hourly Rate (\$)': 20.00,
  //     'Labor Cost (\$)': 1000.00,
  //   },
  //   {
  //     'Serial': '2',
  //     'Employee Name': 'Jane Doe',
  //     'Employee Type': 'Developer',
  //     'Total Hours': 40,
  //     'Hourly Rate (\$)': 25.00,
  //     'Labor Cost (\$)': 1000.00,
  //   },
  //   {
  //     'Serial': '3',
  //     'Employee Name': 'Bob Smith',
  //     'Employee Type': 'Designer',
  //     'Total Hours': 35,
  //     'Hourly Rate (\$)': 30.00,
  //     'Labor Cost (\$)': 1050.00,
  //   },
  // ];
  writeOnPdf(String tokenNo) async {
    final ByteData data = await rootBundle.load('assets/civm_logo.png');
    final Uint8List bytes = data.buffer.asUint8List();
    final image = img.decodeImage(bytes)!;
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Container(
            padding: const pw.EdgeInsets.all(16),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                pw.Image(
                    pw.MemoryImage(Uint8List.fromList(img.encodePng(image))),
                    width: 200,
                    height: 200),
                pw.SizedBox(height: 20),

                pw.Row(
                  children: [
                    pw.Expanded(
                      child: pw.Padding(
                        padding: const pw.EdgeInsets.only(left: 8.0),
                        child: pw.Column(
                          children: [
                            pw.Align(
                              alignment: pw.Alignment.centerLeft,
                              child: pw.Text(
                                "Sparksuite, Inc.",
                                textAlign: pw.TextAlign.left,
                                style: pw.TextStyle(
                                  fontSize: 12,
                                  fontWeight: pw.FontWeight.bold,
                                  // color: const PdfColor.fromInt(255, 7, 59, 120),
                                ),
                              ),
                            ),
                            pw.Align(
                              alignment: pw.Alignment.centerLeft,
                              child: pw.Text(
                                "12345 Sunny Road",
                                textAlign: pw.TextAlign.left,
                                style: pw.TextStyle(
                                  fontSize: 12,
                                  fontWeight: pw.FontWeight.bold,
                                  // color: const PdfColor.fromInt(255, 7, 59, 120),
                                ),
                              ),
                            ),
                            pw.Align(
                              alignment: pw.Alignment.centerLeft,
                              child: pw.Text(
                                "Sunnyville, CA 12345",
                                textAlign: pw.TextAlign.left,
                                style: pw.TextStyle(
                                  fontSize: 12,
                                  fontWeight: pw.FontWeight.bold,
                                  // color: const PdfColor.fromInt(255, 7, 59, 120),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    pw.Expanded(
                      child: pw.Padding(
                        padding: const pw.EdgeInsets.only(right: 8.0),
                        child: pw.Column(
                          children: [
                            pw.Align(
                              alignment: pw.Alignment.centerRight,
                              child: pw.Text(
                                "Invoice Number: $tokenNo",
                                textAlign: pw.TextAlign.left,
                                style: pw.TextStyle(
                                  fontSize: 12,
                                  fontWeight: pw.FontWeight.bold,
                                  // color: const PdfColor.fromInt(255, 7, 59, 120),
                                ),
                              ),
                            ),
                            pw.Align(
                              alignment: pw.Alignment.centerRight,
                              child: pw.Text(
                                "Invoice Date: $formattedDate",
                                textAlign: pw.TextAlign.left,
                                style: pw.TextStyle(
                                  fontSize: 12,
                                  fontWeight: pw.FontWeight.bold,
                                  // color: const PdfColor.fromInt(255, 7, 59, 120),
                                ),
                              ),
                            ),
                            pw.Align(
                              alignment: pw.Alignment.centerRight,
                              child: pw.Text(
                                "Change Order No: $tokenNo",
                                textAlign: pw.TextAlign.left,
                                style: pw.TextStyle(
                                  fontSize: 12,
                                  fontWeight: pw.FontWeight.bold,
                                  // color: const PdfColor.fromInt(255, 7, 59, 120),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                // ignore: deprecated_member_use
                pw.SizedBox(height: 20),
                // ignore: deprecated_member_use
                pw.Table.fromTextArray(
                  context: context,
                  cellAlignment: pw.Alignment.centerLeft,
                  headerDecoration: const pw.BoxDecoration(
                    color: PdfColors.grey,
                  ),
                  cellHeight: 30,
                  headerHeight: 40,
                  cellAlignments: {
                    0: pw.Alignment.center,
                    1: pw.Alignment.center,
                    2: pw.Alignment.center,
                    3: pw.Alignment.center,
                    4: pw.Alignment.center,
                    5: pw.Alignment.center,
                  },
                  headerStyle: pw.TextStyle(
                      fontSize: 12, fontWeight: pw.FontWeight.bold),
                  cellStyle: const pw.TextStyle(fontSize: 10),
                  headers: [
                    'Serial',
                    'Employee Name',
                    'Employee Type',
                    'Total Hours',
                    'Hourly Rate (\$)',
                    'Labor Cost (\$)'
                  ],
                  data: tableData
                      .map((row) => [
                            row['Serial'],
                            row['Employee Name'],
                            row['Employee Type'],
                            row['Total Hours'].toString(),
                            '\$${row['Hourly Rate (\$)'].toStringAsFixed(2)}', // Format as currency
                            '\$${row['Labor Cost (\$)'].toStringAsFixed(2)}', // Format as currency
                          ])
                      .toList(),
                ),

                // ignore: deprecated_member_use
                pw.Table.fromTextArray(
                  context: context,
                  cellAlignment: pw.Alignment.centerLeft,
                  headerDecoration: const pw.BoxDecoration(
                    color: PdfColors.white,
                  ),
                  cellHeight: 30,
                  headerHeight: 40,
                  cellAlignments: {
                    0: pw.Alignment.center,
                    1: pw.Alignment.center,
                    2: pw.Alignment.center,
                    3: pw.Alignment.center,
                    4: pw.Alignment.center,
                    5: pw.Alignment.center,
                  },
                  headerStyle: pw.TextStyle(
                      fontSize: 12, fontWeight: pw.FontWeight.bold),
                  cellStyle: const pw.TextStyle(fontSize: 10),
                  headers: ['Total', '\$ $total'],
                  data: [],
                ),

                // ignore: deprecated_member_use
                pw.SizedBox(height: 20),
                // ignore: deprecated_member_use
                pw.Table.fromTextArray(
                    context: context,
                    cellAlignment: pw.Alignment.centerLeft,
                    headerDecoration: const pw.BoxDecoration(
                      color: PdfColors.grey,
                    ),
                    cellHeight: 30,
                    headerHeight: 40,
                    cellAlignments: {
                      0: pw.Alignment.center,
                      1: pw.Alignment.center,
                      2: pw.Alignment.center,
                      3: pw.Alignment.center,
                      4: pw.Alignment.center,
                      5: pw.Alignment.center,
                    },
                    headerStyle: pw.TextStyle(
                        fontSize: 12, fontWeight: pw.FontWeight.bold),
                    cellStyle: const pw.TextStyle(fontSize: 10),
                    headers: ['Invoice Summary'],
                    data: []),
// ignore: deprecated_member_use
                pw.Table.fromTextArray(
                    context: context,
                    cellAlignment: pw.Alignment.centerLeft,
                    headerDecoration: const pw.BoxDecoration(
                      color: PdfColors.white,
                    ),
                    cellHeight: 30,
                    headerHeight: 40,
                    cellAlignments: {
                      0: pw.Alignment.center,
                      1: pw.Alignment.center,
                      2: pw.Alignment.center,
                      3: pw.Alignment.center,
                      4: pw.Alignment.center,
                      5: pw.Alignment.center,
                    },
                    headerStyle: pw.TextStyle(
                        fontSize: 12, fontWeight: pw.FontWeight.bold),
                    cellStyle: const pw.TextStyle(fontSize: 10),
                    headers: ['Labor Total', '\$ $laborTotal'],
                    data: []),

                // ignore: deprecated_member_use
                pw.Table.fromTextArray(
                    context: context,
                    cellAlignment: pw.Alignment.centerLeft,
                    headerDecoration: const pw.BoxDecoration(
                      color: PdfColors.white,
                    ),
                    cellHeight: 30,
                    headerHeight: 40,
                    cellAlignments: {
                      0: pw.Alignment.center,
                      1: pw.Alignment.center,
                      2: pw.Alignment.center,
                      3: pw.Alignment.center,
                      4: pw.Alignment.center,
                      5: pw.Alignment.center,
                    },
                    headerStyle: pw.TextStyle(
                        fontSize: 12, fontWeight: pw.FontWeight.bold),
                    cellStyle: const pw.TextStyle(fontSize: 10),
                    headers: ['Invoice Total 	', '\$ $invoiceTotal'],
                    data: []),

                pw.SizedBox(height: 20),

                // pw.Container(
                //     padding: const pw.EdgeInsets.all(8),
                //     //  padding:  EdgeInsets.all(8),

                //     decoration: const pw.BoxDecoration(
                //         // shape: BoxShape.circle,
                //         // borderRadius: BorderRadius.circular(10),
                //         // boxShadow: [
                //         //   pw.BoxShadow(
                //         //       color: PdfColors.blue,
                //         //       // PdfColors.fromARGB(255, 7, 59, 120),
                //         //       blurRadius: 10,
                //         //       // pw.offset: Offset(2.0, 5.0)
                //         //       )
                //         // ],
                //         gradient: pw.LinearGradient(
                //       colors: [
                //         PdfColors.blue,
                //         PdfColors.blue,
                //       ],
                //     )),
                //     child: pw.Text(
                //       'Download Invoice',
                //       style: pw.TextStyle(
                //         fontSize: 16,
                //         color: PdfColors.white,
                //         fontWeight: pw.FontWeight.bold,
                //         decoration: pw.TextDecoration.underline,
                //       ),
                //     )

                //     // child: pw.Link(
                //     //   destination: 'https://example.com', // Fake URL
                //     //   child: pw.Text(
                //     //     'Download Invoice',
                //     //     style:  pw.TextStyle(
                //     //       fontSize: 16,
                //     //       color: PdfColors.white,
                //     //       fontWeight: pw.FontWeight.bold,
                //     //       decoration: pw.TextDecoration.underline,
                //     //     ),
                //     //   ),
                //     // ),
                //     )
              ],
            ),
          );
        },
      ),
    );
  }

  void newDateFormat(
    int index,
  ) {
    String? rawContractYear = invoiceListViewModel.invoiceListGetTabularData
        .data!.findInvoiceListDatas![index].contractYear
        ?.toString();

    String? rawNextMaintDue = invoiceListViewModel.invoiceListGetTabularData
        .data!.findInvoiceListDatas![index].nextMaintDue
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
            //     Icons.open_in_browser,
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
            //     Icons.pending,
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
                  Navigator.pop(context);
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
        ),
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
