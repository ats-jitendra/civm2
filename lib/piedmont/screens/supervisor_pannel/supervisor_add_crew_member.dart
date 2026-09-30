import 'package:CIVM/piedmont/data/response/status.dart';
import 'package:CIVM/piedmont/repository/map_url.dart';
import 'package:CIVM/piedmont/resources/app_colors.dart';
import 'package:CIVM/piedmont/screens/leaflat_map/leaf_lat_map_wakeLock.dart';
import 'package:CIVM/piedmont/screens/login_page.dart';
import 'package:CIVM/piedmont/screens/map/provider/location_provider.dart';
import 'package:CIVM/piedmont/screens/my_chrome_safari_map_recording.dart';
import 'package:CIVM/piedmont/screens/supervisor_pannel/change_order_new_inDrawer.dart';
import 'package:CIVM/piedmont/screens/supervisor_pannel/service_order.dart';
import 'package:CIVM/piedmont/screens/supervisor_pannel/sup_invoice_list.dart';
import 'package:CIVM/piedmont/screens/supervisor_pannel/supervisor_add_new_row_table.dart';
import 'package:CIVM/piedmont/screens/supervisor_pannel/supervisor_approve_civm_access.dart';
import 'package:CIVM/piedmont/screens/supervisor_pannel/supervisor_bottom_navigation_pannel.dart';
import 'package:CIVM/piedmont/screens/supervisor_pannel/supervisor_row_maintenance_progress.dart';
import 'package:CIVM/piedmont/utils/common_functions.dart';
import 'package:CIVM/piedmont/utils/custom_toast_snackbar_progressdialog.dart';
import 'package:CIVM/piedmont/view_model/add_crew_member_view_model.dart';
import 'package:CIVM/sharedPrefs/constants.dart';
import 'package:CIVM/utils/user_pref.dart';
import 'package:CIVM/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SupervisorAddCrewMember extends StatefulWidget {
  const SupervisorAddCrewMember({Key? key}) : super(key: key);

  @override
  State<SupervisorAddCrewMember> createState() =>
      _SupervisorAddCrewMemberState();
}

class _SupervisorAddCrewMemberState extends State<SupervisorAddCrewMember> {
  final TextEditingController _crewName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  List<String> menu = [];

  // ignore: prefer_typing_uninitialized_variables
  var selectedAssignContractor;
  int assignContratorId = 0;

  bool? _active = false;

  final TextEditingController _input = TextEditingController();
  final GlobalKey<FormState> _addCrewFormKey = GlobalKey<FormState>();

  onTappedBar(int index) {
    setState(() {
      // _currentIndex = index;
    });
  }

  AddCrewMemberViewModel addCrewMemberViewModel = AddCrewMemberViewModel();
  @override
  void initState() {
    addCrewMemberViewModel.fetchAddCrewMemberTabularListApi(context);
    // getOwnPermissions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text(
            'Add New Crew Member',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: AppColors.baseColor,
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.add,
                color: Colors.white,
              ),
              onPressed: () {
                openDailogAddCrewMember();
                // do something
              },
            )
          ],
        ),
        drawer: DrawerManu(menu: menu),
        body: ChangeNotifierProvider<AddCrewMemberViewModel>(
            create: (BuildContext context) => addCrewMemberViewModel,
            child:
                Consumer<AddCrewMemberViewModel>(builder: (context, value, _) {
              switch (value.addCrewMemberTabularData.status) {
                case Status.LOADING:
                  return const Center(child: CircularProgressIndicator());
                case Status.ERROR:
                  return
                      // CustomToastSnackBarProgressDialog.flushBarErrorMessage(
                      //     value.addCrewMemberTabularData.message.toString(),
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
                  return RefreshIndicator(
                    onRefresh: () async {
                      _input.clear();
                      await addCrewMemberViewModel
                          .fetchAddCrewMemberTabularListApi(context);
                    },
                    child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0, right: 8.0),
                                child: TextFormField(
                                  onChanged: (value) => _filterData(value),
                                  //  key: formkey2,
                                  controller: _input,
                                  style: const TextStyle(
                                      color: AppColors.baseColor, fontSize: 16),
                                  obscureText: false,

                                  //keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(
                                        // borderRadius: BorderRadius.circular(25),
                                        ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Color.fromARGB(255, 7, 59, 120)),
                                      // borderRadius: BorderRadius.circular(25),
                                    ),
                                    hintText: 'Search your input...',
                                    hintStyle: TextStyle(color: Colors.grey),
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
                              child: SingleChildScrollView(
                                physics: const AlwaysScrollableScrollPhysics(),
                                child: ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount: addCrewMemberViewModel
                                      .addCrewMemberTabularData
                                      .data!
                                      .getaAllCewMemberTableDatas!
                                      .length,
                                  itemBuilder: (context, index) {
                                    return Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.285,
                                            // height: MediaQuery.of(context)
                                            //         .size
                                            //         .height *
                                            //     0.25,
                                            // height: 190,
                                            margin: const EdgeInsets.only(
                                                left: 8.0,
                                                right: 8.0,
                                                top: 5.0,
                                                bottom: 5.0),
                                            padding: const EdgeInsets.all(8),
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
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomRight,
                                              ),
                                              border: Border.all(
                                                color: Colors.white,
                                              ),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topRight: Radius.circular(10),
                                                bottomRight:
                                                    Radius.circular(10),
                                                topLeft: Radius.circular(10),
                                                bottomLeft: Radius.circular(10),
                                              ),
                                            ),
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
                                                                alignment:
                                                                    Alignment
                                                                        .topLeft,
                                                                child: Text(
                                                                  "SERIAL: ",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          7,
                                                                          59,
                                                                          120)),
                                                                ),
                                                              ),
                                                              Align(
                                                                alignment:
                                                                    Alignment
                                                                        .topLeft,
                                                                child: Text(
                                                                  (addCrewMemberViewModel.addCrewMemberTabularData.data!.getaAllCewMemberTableDatas![index].id ==
                                                                              null ||
                                                                          addCrewMemberViewModel.addCrewMemberTabularData.data!.getaAllCewMemberTableDatas![index].id.toString() ==
                                                                              'null')
                                                                      ? ''
                                                                      : addCrewMemberViewModel
                                                                          .addCrewMemberTabularData
                                                                          .data!
                                                                          .getaAllCewMemberTableDatas![
                                                                              index]
                                                                          .id
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
                                                                              120)),
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
                                                                  "CREW NAME: ",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          7,
                                                                          59,
                                                                          120)),
                                                                ),
                                                              ),
                                                              Align(
                                                                alignment:
                                                                    Alignment
                                                                        .topLeft,
                                                                child: Text(
                                                                  (addCrewMemberViewModel.addCrewMemberTabularData.data!.getaAllCewMemberTableDatas![index].name ==
                                                                              null ||
                                                                          addCrewMemberViewModel.addCrewMemberTabularData.data!.getaAllCewMemberTableDatas![index].name.toString() ==
                                                                              'null')
                                                                      ? ''
                                                                      : addCrewMemberViewModel
                                                                          .addCrewMemberTabularData
                                                                          .data!
                                                                          .getaAllCewMemberTableDatas![
                                                                              index]
                                                                          .name
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
                                                                              120)),
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
                                                                alignment:
                                                                    Alignment
                                                                        .topLeft,
                                                                child: Text(
                                                                  "GENERAL FOREMAN NAME: ",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          7,
                                                                          59,
                                                                          120)),
                                                                ),
                                                              ),
                                                              Align(
                                                                alignment:
                                                                    Alignment
                                                                        .topLeft,
                                                                child: Text(
                                                                  (addCrewMemberViewModel.addCrewMemberTabularData.data!.getaAllCewMemberTableDatas![index].contractor ==
                                                                              null ||
                                                                          addCrewMemberViewModel.addCrewMemberTabularData.data!.getaAllCewMemberTableDatas![index].contractor.toString() ==
                                                                              'null')
                                                                      ? ''
                                                                      : addCrewMemberViewModel
                                                                          .addCrewMemberTabularData
                                                                          .data!
                                                                          .getaAllCewMemberTableDatas![
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
                                                                          //  fontWeight:
                                                                          //      FontWeight.bold,
                                                                          color: Color.fromARGB(
                                                                              255,
                                                                              7,
                                                                              59,
                                                                              120)),
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
                                                                  "SUPERVISOR NAME: ",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          7,
                                                                          59,
                                                                          120)),
                                                                ),
                                                              ),
                                                              Align(
                                                                alignment:
                                                                    Alignment
                                                                        .topLeft,
                                                                child: Text(
                                                                  (addCrewMemberViewModel.addCrewMemberTabularData.data!.getaAllCewMemberTableDatas![index].supervisor ==
                                                                              null ||
                                                                          addCrewMemberViewModel.addCrewMemberTabularData.data!.getaAllCewMemberTableDatas![index].supervisor.toString() ==
                                                                              'null')
                                                                      ? ''
                                                                      : addCrewMemberViewModel
                                                                          .addCrewMemberTabularData
                                                                          .data!
                                                                          .getaAllCewMemberTableDatas![
                                                                              index]
                                                                          .supervisor
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
                                                                              120)),
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
                                                                alignment:
                                                                    Alignment
                                                                        .topLeft,
                                                                child: Text(
                                                                  "STATUS: ",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          7,
                                                                          59,
                                                                          120)),
                                                                ),
                                                              ),
                                                              Align(
                                                                alignment:
                                                                    Alignment
                                                                        .topLeft,
                                                                child: Text(
                                                                  (addCrewMemberViewModel.addCrewMemberTabularData.data!.getaAllCewMemberTableDatas![index].status ==
                                                                              null ||
                                                                          addCrewMemberViewModel.addCrewMemberTabularData.data!.getaAllCewMemberTableDatas![index].status.toString() ==
                                                                              'null')
                                                                      ? ''
                                                                      : addCrewMemberViewModel
                                                                          .addCrewMemberTabularData
                                                                          .data!
                                                                          .getaAllCewMemberTableDatas![
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
                                                                          //  fontWeight:
                                                                          //      FontWeight.bold,
                                                                          color: Color.fromARGB(
                                                                              255,
                                                                              7,
                                                                              59,
                                                                              120)),
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
                                                          child: Row(
                                                            children: [
                                                              const Align(
                                                                alignment:
                                                                    Alignment
                                                                        .topLeft,
                                                                child: Text(
                                                                  "ACTION: ",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          7,
                                                                          59,
                                                                          120)),
                                                                ),
                                                              ),
                                                              // Align(
                                                              //   alignment:
                                                              //       Alignment
                                                              //           .topLeft,
                                                              //   child: InkWell(
                                                              //     onTap: () {
                                                              //       openDailogAddCrewMember();
                                                              //     },
                                                              //     child:
                                                              //         Container(
                                                              //       // padding: const EdgeInsets.all(2),
                                                              //       alignment:
                                                              //           Alignment
                                                              //               .center,
                                                              //       height: 30,
                                                              //       width: 80,
                                                              //       decoration: const BoxDecoration(
                                                              //           // shape: BoxShape.circle,
                                                              //           // borderRadius: BorderRadius.circular(10),
                                                              //           boxShadow: [
                                                              //             BoxShadow(
                                                              //                 color: Color.fromARGB(
                                                              //                     255,
                                                              //                     1,
                                                              //                     104,
                                                              //                     4),
                                                              //                 blurRadius:
                                                              //                     10,
                                                              //                 offset:
                                                              //                     Offset(2.0, 5.0))
                                                              //           ],
                                                              //           color: Colors.black,
                                                              //           gradient: LinearGradient(
                                                              //             colors: [
                                                              //               Colors
                                                              //                   .green,
                                                              //               Colors
                                                              //                   .green,
                                                              //               // Color.fromARGB(255, 3, 224, 10),
                                                              //             ],
                                                              //           )),
                                                              //       child: const Column(
                                                              //           children: [
                                                              //             Expanded(
                                                              //               child:
                                                              //                   Align(
                                                              //                 alignment:
                                                              //                     Alignment.center,
                                                              //                 child:
                                                              //                     Text(
                                                              //                   'EDIT',
                                                              //                   textAlign: TextAlign.center,
                                                              //                   style: TextStyle(
                                                              //                     color: Colors.white,
                                                              //                     fontWeight: FontWeight.bold,
                                                              //                     fontSize: 15,
                                                              //                   ),
                                                              //                 ),
                                                              //               ),
                                                              //             ),
                                                              //           ]),
                                                              //     ),
                                                              //   ),
                                                              // ),
                                                              // const SizedBox(
                                                              //   width: 5,
                                                              // ),

                                                              Align(
                                                                alignment:
                                                                    Alignment
                                                                        .topLeft,
                                                                child: InkWell(
                                                                  onTap: () {
                                                                    deny(
                                                                        (addCrewMemberViewModel.addCrewMemberTabularData.data!.getaAllCewMemberTableDatas![index].status!.isNotEmpty && addCrewMemberViewModel.addCrewMemberTabularData.data!.getaAllCewMemberTableDatas![index].status!.toString() == 'PENDING')
                                                                            ? 'ALLOW'
                                                                            : 'DENY',
                                                                        index,
                                                                        addCrewMemberViewModel
                                                                            .addCrewMemberTabularData
                                                                            .data!
                                                                            .getaAllCewMemberTableDatas![
                                                                                index]
                                                                            .id
                                                                            .toString(),
                                                                        addCrewMemberViewModel
                                                                            .addCrewMemberTabularData
                                                                            .data!
                                                                            .getaAllCewMemberTableDatas![index]
                                                                            .status
                                                                            .toString());
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    // padding: const EdgeInsets.all(2),
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    height: 30,
                                                                    width: 90,
                                                                    decoration: BoxDecoration(
                                                                        // shape: BoxShape.circle,
                                                                        // borderRadius: BorderRadius.circular(10),
                                                                        boxShadow: (addCrewMemberViewModel.addCrewMemberTabularData.data!.getaAllCewMemberTableDatas![index].status!.toString().isNotEmpty && addCrewMemberViewModel.addCrewMemberTabularData.data!.getaAllCewMemberTableDatas![index].status!.toString() == 'PENDING')
                                                                            ? [
                                                                                const BoxShadow(color: Color.fromARGB(255, 2, 43, 113), blurRadius: 5, offset: Offset(2.0, 5.0))
                                                                              ]
                                                                            : [
                                                                                const BoxShadow(color: Color.fromARGB(255, 117, 10, 2), blurRadius: 5, offset: Offset(2.0, 5.0))
                                                                              ],
                                                                        color: Colors.black,
                                                                        gradient: LinearGradient(
                                                                          colors: (addCrewMemberViewModel.addCrewMemberTabularData.data!.getaAllCewMemberTableDatas![index].status!.toString().isNotEmpty &&
                                                                                  addCrewMemberViewModel.addCrewMemberTabularData.data!.getaAllCewMemberTableDatas![index].status.toString() ==
                                                                                      'ACTIVE')
                                                                              ? (addCrewMemberViewModel.addCrewMemberTabularData.data!.getaAllCewMemberTableDatas![index].status!.toString().isNotEmpty &&
                                                                                      addCrewMemberViewModel.addCrewMemberTabularData.data!.getaAllCewMemberTableDatas![index].status.toString() ==
                                                                                          'PENDING')
                                                                                  ? [
                                                                                      const Color.fromARGB(255, 243, 128, 119),
                                                                                      const Color.fromARGB(255, 243, 128, 119),
                                                                                      const Color.fromARGB(255, 243, 128, 119)
                                                                                    ]
                                                                                  : [
                                                                                      Colors.red,
                                                                                      Colors.red,
                                                                                      Colors.red
                                                                                    ]
                                                                              : [
                                                                                  Colors.blueAccent,
                                                                                  const Color.fromARGB(255, 3, 91, 242),
                                                                                  Colors.blueAccent,
                                                                                ],
                                                                        )),
                                                                    child: Column(
                                                                        children: [
                                                                          Expanded(
                                                                            child:
                                                                                Align(
                                                                              alignment: Alignment.center,
                                                                              child: Text(
                                                                                (addCrewMemberViewModel.addCrewMemberTabularData.data!.getaAllCewMemberTableDatas![index].status!.toString().isNotEmpty && addCrewMemberViewModel.addCrewMemberTabularData.data!.getaAllCewMemberTableDatas![index].status!.toString() == 'PENDING') ? 'ALLOW' : 'DENY',
                                                                                textAlign: TextAlign.center,
                                                                                style: const TextStyle(
                                                                                  color: Colors.white,
                                                                                  fontWeight: FontWeight.bold,
                                                                                  fontSize: 15,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ]),
                                                                  ),
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                width: 5,
                                                              ),
                                                              // Align(
                                                              //   alignment:
                                                              //       Alignment
                                                              //           .topLeft,
                                                              //   child: InkWell(
                                                              //     onTap: () {
                                                              //       addCrewMemberViewModel.fetchAddCrewMemberDeleteApi(
                                                              //           context,
                                                              //           addCrewMemberViewModel
                                                              //               .addCrewMemberTabularData
                                                              //               .data!
                                                              //               .getaAllCewMemberTableDatas![index]
                                                              //               .id
                                                              //               .toString());

                                                              //       Future
                                                              //           .delayed(
                                                              //         const Duration(
                                                              //             seconds:
                                                              //                 2),
                                                              //         () {
                                                              //           addCrewMemberViewModel
                                                              //               .fetchAddCrewMemberTabularListApi(context);
                                                              //         },
                                                              //       );
                                                              //     },
                                                              //     child:
                                                              //         Container(
                                                              //       // padding: const EdgeInsets.all(2),
                                                              //       alignment:
                                                              //           Alignment
                                                              //               .center,
                                                              //       height: 30,
                                                              //       width: 90,
                                                              //       decoration: const BoxDecoration(
                                                              //           // shape: BoxShape.circle,
                                                              //           // borderRadius: BorderRadius.circular(10),
                                                              //           boxShadow: [
                                                              //             BoxShadow(
                                                              //                 color: Color.fromARGB(255, 1, 75, 136),
                                                              //                 blurRadius: 10,
                                                              //                 offset: Offset(2.0, 5.0))
                                                              //           ],
                                                              //           color: Colors.black,
                                                              //           gradient: LinearGradient(
                                                              //             colors: [
                                                              //               Colors.blue,
                                                              //               Colors.blue,
                                                              //               // Color.fromARGB(255, 3, 224, 10),
                                                              //             ],
                                                              //           )),
                                                              //       child: const Column(
                                                              //           children: [
                                                              //             Expanded(
                                                              //               child:
                                                              //                   Align(
                                                              //                 alignment: Alignment.center,
                                                              //                 child: Text(
                                                              //                   'DELETE',
                                                              //                   textAlign: TextAlign.center,
                                                              //                   style: TextStyle(
                                                              //                     color: Colors.white,
                                                              //                     fontWeight: FontWeight.bold,
                                                              //                     fontSize: 15,
                                                              //                   ),
                                                              //                 ),
                                                              //               ),
                                                              //             ),
                                                              //           ]),
                                                              //     ),
                                                              //   ),
                                                              // ),
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
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        )),
                  );

                default:
                  return const Text('data');
              }
            })));
  }

  Future openDailogAddCrewMember() => showDialog(
      context: context,
      builder: (context) {
        // setDataCrew();
        bool _obscurePassword = true;
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            content: Form(
              key: _addCrewFormKey,
              child: SingleChildScrollView(
                child: Column(
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
                                  "Crew Name",
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: AppColors.baseColor,
                                  ),
                                ),
                              )),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: TextFormField(
                                //  key: formkey2,
                                controller: _crewName,
                                style: const TextStyle(
                                    color: AppColors.baseColor, fontSize: 16),
                                obscureText: false,
                                // keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                      // borderRadius: BorderRadius.circular(25),
                                      ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppColors.baseColor,
                                    ),
                                    // borderRadius: BorderRadius.circular(25),
                                  ),
                                  hintText: 'Crew Name',
                                  // prefixIcon: const Icon(
                                  //   Icons.person,
                                  //   color: AppColors.baseColor,
                                  // ),
                                ),

                                validator: (value) {
                                  if (value.toString() == '') {
                                    return "Please enter crew name";
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                          )
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
                                  "Email",
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: AppColors.baseColor,
                                  ),
                                ),
                              )),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: TextFormField(
                                //  key: formkey2,
                                controller: _email,
                                style: const TextStyle(
                                    color: AppColors.baseColor, fontSize: 16),
                                obscureText: false,
                                // keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                      // borderRadius: BorderRadius.circular(25),
                                      ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppColors.baseColor,
                                    ),
                                    // borderRadius: BorderRadius.circular(25),
                                  ),
                                  hintText: 'Email',
                                  // prefixIcon: const Icon(
                                  //   Icons.person,
                                  //   color: AppColors.baseColor,
                                  // ),
                                ),

                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return "Please enter email";
                                  }

                                  if (value.contains(' ')) {
                                    return "Email should not contain spaces";
                                  }

                                  // // Optional: Proper email format validation
                                  // if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                  //     .hasMatch(value)) {
                                  //   return "Enter a valid email address";
                                  // }

                                  return null;
                                },
                              ),
                            ),
                          )
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
                                  "Password",
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: AppColors.baseColor,
                                  ),
                                ),
                              )),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: TextFormField(
                                controller: _password,
                                style: const TextStyle(
                                  color: AppColors.baseColor,
                                  fontSize: 16,
                                ),
                                obscureText: _obscurePassword,
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppColors.baseColor,
                                    ),
                                  ),
                                  hintText: 'Password',
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _obscurePassword
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: AppColors.baseColor,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _obscurePassword = !_obscurePassword;
                                      });
                                    },
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please enter password";
                                  }
                                  return null;
                                },
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
                                  "Assign Foreman",
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: AppColors.baseColor,
                                  ),
                                ),
                              )),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: DropdownButtonFormField<String>(
                                hint: const Text('-Select-'),
                                dropdownColor: Colors.white,
                                value: selectedAssignContractor,
                                style: const TextStyle(
                                    color: AppColors.baseColor, fontSize: 16),
                                icon: const Icon(
                                  Icons.arrow_drop_down,
                                  color: AppColors.baseColor,
                                  size: 40,
                                ),
                                decoration: const InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppColors.baseColor,
                                    ),
                                    // borderRadius: BorderRadius.circular(25),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppColors.baseColor,
                                    ),
                                    // borderRadius: BorderRadius.circular(25),
                                  ),
                                ),
                                isExpanded: true,
                                items: addCrewMemberViewModel
                                    .addCrewMemberTabularData
                                    .data!
                                    .contractorListNameId!
                                    .map((e) {
                                  return DropdownMenuItem(
                                    value: e.id.toString(),
                                    child: Text(e.name.toString()),
                                  );
                                }).toList(),
                                onChanged: (val) {
                                  assignContratorId = int.parse(val!);
                                  setState(() {
                                    selectedAssignContractor = val;
                                  });
                                },
                                validator: (value) =>
                                    value == null ? 'field required' : null,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: CheckboxListTile(
                        title: const Text("Active",
                            style: TextStyle(
                                color: AppColors.baseColor, fontSize: 20)),
                        //secondary: Icon(Icons.beach_access),
                        controlAffinity: ListTileControlAffinity.leading,
                        value: _active,
                        onChanged: (val) {
                          setState(() {
                            _active = val;
                          });
                        },
                        activeColor: const Color.fromARGB(255, 80, 157, 244),
                        checkColor: AppColors.baseColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              Container(
                  margin: const EdgeInsets.only(left: 6, right: 6, bottom: 10),
                  child: InkWell(
                    onTap: () {
                      print("bb");
                      if (!_addCrewFormKey.currentState!.validate()) {
                        return; // ❌ Stop if validation fails
                      }
                      Map<String, dynamic> mapData = {
                        "fName": (_crewName.text.toString() == 'null' ||
                                _crewName.text.toString() == '')
                            ? 'N/A'
                            : _crewName.text.toString(),
                        "status": (_active == true) ? 'ACTIVE' : 'PENDING',
                        // "userName": (_crewName.text.toString() == 'null' ||
                        //         _crewName.text.toString() == '')
                        //     ? 'N/A'
                        //     : _crewName.text.toString(),
                        "email": (_email.text.toString() == 'null' ||
                                _email.text.toString() == '')
                            ? 'N/A'
                            : _email.text.toString(),
                        "password": (_password.text.toString() == 'null' ||
                                _password.text.toString() == '')
                            ? 'N/A'
                            : _password.text.toString(),
                        "contractor": assignContratorId.toString(),
                      };
                      print(mapData);
                      createCrew(context, mapData);
                      //           addCrewMemberViewModel
                      //               .fetchAddCrewMemberInsertApi(context, mapData)
                      //               .then((value) {
                      // //                 CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
                      // // 'Crew Inserted Successfully', context);
                      //             Navigator.pop(context);
                      //             addCrewMemberViewModel
                      //                 .fetchAddCrewMemberTabularListApi(context);
                      //           });
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
                                color: Colors.blue,
                                blurRadius: 5,
                                offset: Offset(2.0, 5.0))
                          ],
                          color: Colors.black,
                          gradient: LinearGradient(
                            colors: [
                              Color.fromARGB(255, 1, 45, 120),
                              Colors.blue,
                              Color.fromARGB(255, 0, 79, 215),
                            ],
                          )),
                      child: const Row(children: [
                        Expanded(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Save",
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
          );
        });
      });

  Future deny(var data, int ind, String userName, String status) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
              title: Column(
                children: [
                  Text(
                    'Are you sure you want to ${data} this user?',
                    style: const TextStyle(
                        color: AppColors.baseColor,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 15.0, left: 60),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Row(
                      children: [
                        InkWell(
                          onTap: (() {
                            if (data == 'DENY') {
                              addCrewMemberViewModel
                                  .addCrewMemberTabularData
                                  .data!
                                  .getaAllCewMemberTableDatas![ind]
                                  .status = 'PENDING';
                            } else {
                              addCrewMemberViewModel
                                  .addCrewMemberTabularData
                                  .data!
                                  .getaAllCewMemberTableDatas![ind]
                                  .status = 'ACTIVE';
                            }
                            addCrewMemberViewModel
                                .fetchApproveCIVMUpdatePutListApi(
                                    context,
                                    (data == 'DENY') ? 'PENDING' : 'ACTIVE',
                                    userName);
                            Navigator.of(context).pop();
                          }),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.2,
                            height: MediaQuery.of(context).size.height * 0.052,
                            decoration: const BoxDecoration(
                                // shape: BoxShape.circle,

                                boxShadow: [
                                  BoxShadow(
                                      color: Color.fromARGB(255, 142, 209, 145),
                                      blurRadius: 5,
                                      offset: Offset(2.0, 5.0))
                                ],
                                color: Colors.black,
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.green,
                                    Colors.green,
                                  ],
                                )),
                            child: const Row(children: [
                              Expanded(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Yes",
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
                        ),
                        InkWell(
                          onTap: (() {
                            Navigator.of(context).pop();
                          }),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.2,
                              height:
                                  MediaQuery.of(context).size.height * 0.052,
                              decoration: const BoxDecoration(
                                  // shape: BoxShape.circle,

                                  boxShadow: [
                                    BoxShadow(
                                        color:
                                            Color.fromARGB(255, 253, 138, 176),
                                        blurRadius: 5,
                                        offset: Offset(2.0, 5.0))
                                  ],
                                  color: Colors.black,
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.red,
                                      Colors.red,
                                    ],
                                  )),
                              child: const Row(children: [
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Cancel",
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
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ]));

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
      value: item,
      child: Text(item,
          style: const TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 20,
          )));

  Future<void> _filterData(String query) async {
    if (query.isEmpty) {
      addCrewMemberViewModel.fetchAddCrewMemberTabularListApi(context);
    } else {
      addCrewMemberViewModel
              .addCrewMemberTabularData.data?.getaAllCewMemberTableDatas =
          addCrewMemberViewModel
              .addCrewMemberTabularData.data?.getaAllCewMemberTableDatas
              ?.where((item) =>
                  item.status
                      .toString()
                      .toLowerCase()
                      .contains(query.toLowerCase()) ||
                  item.name
                      .toString()
                      .toLowerCase()
                      .contains(query.toLowerCase()) ||
                  item.contractor
                      .toString()
                      .toLowerCase()
                      .contains(query.toLowerCase()) ||
                  item.supervisor
                      .toString()
                      .toLowerCase()
                      .contains(query.toLowerCase()) ||
                  item.id
                      .toString()
                      .toLowerCase()
                      .contains(query.toLowerCase()))
              .toList();
    }
    setState(() {});
  }

  Future<void> setDataCrew() async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    _email.text = data.user!.email.toString();
    _password.text = data.user!.password.toString();
  }

  Future<bool> createCrew(
    BuildContext context,
    Map<String, dynamic> mappedData,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('https://atsdev3test.ariespro.com/main/create_crew'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(mappedData),
      );

      final decoded = jsonDecode(response.body);

      // ✅ SUCCESS
      if (response.statusCode >= 200 && response.statusCode < 300) {
        if (context.mounted) {
          CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
            decoded['message'] ?? 'Crew Inserted Successfully!',
            context,
          );
          addCrewMemberViewModel.fetchAddCrewMemberTabularListApi(context);
          Future.delayed(const Duration(seconds: 5), () {
            if (context.mounted) {
              Navigator.of(context, rootNavigator: true).pop();
              Navigator.of(context, rootNavigator: true).pop();
            }
          });
          // Navigator.pop(context);
          // Navigator.pop(context);
        }
        return true;
      }

      // ❌ ERROR
      else {
        if (context.mounted) {
          CustomToastSnackBarProgressDialog.flushBarErrorMessage(
            decoded['message'] ?? 'Something went wrong',
            context,
          );
        }
        return false;
      }
    } catch (e) {
      if (context.mounted) {
        CustomToastSnackBarProgressDialog.flushBarErrorMessage(
          'Network error. Please try again.',
          context,
        );
      }
      return false;
    }
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
    var provider = Provider.of<LocationProviderPemc>(context, listen: true);
    final browser = MyChromeSafariBrowser();
    return Drawer(
      child: SafeArea(
        child: Column(
          // Important: Remove any padding from the ListView.
          // padding: EdgeInsets.zero,
          children: [
            Container(
              width: double.infinity,
              height: 180,
              color: AppColors.lighterBaseColor,
              padding: const EdgeInsets.only(top: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  menuLogo(),
                  const SizedBox(height: 6),
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
                    title: const Text('Dashboard'),
                    textColor: AppColors.baseColor,
                    iconColor: AppColors.baseColor,
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const SupervisorBottomNavigationPannel()));
                    },
                  ),

                  ListTile(
                    leading: const Icon(
                      Icons.pending,
                    ),
                    title: const Text('Work Order'),
                    textColor: AppColors.baseColor,
                    iconColor: AppColors.baseColor,
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const ChangeOrderNewInDrawer()));
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.pending,
                    ),
                    title: const Text('Service Order'),
                    textColor: AppColors.baseColor,
                    iconColor: AppColors.baseColor,
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const ServiceOrder()));
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.rowing,
                    ),
                    title: const Text('Job List'),
                    textColor: AppColors.baseColor,
                    iconColor: AppColors.baseColor,
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              SupervisorAddNewRowTable(index: '0')));
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.inventory,
                    ),
                    title: const Text('IVM Maintenance Progress'),
                    textColor: AppColors.baseColor,
                    iconColor: AppColors.baseColor,
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const SupervisorRowMaintenanceProgress()));
                    },
                  ),
                  ///////////new added maps for PEMC
                  ListTile(
                    leading: const Icon(
                      Icons.vertical_distribute,
                    ),
                    title: const Text('Add ROW Distribution Map'),
                    textColor: AppColors.baseColor,
                    iconColor: AppColors.baseColor,
                    onTap: () async {
                      String id = '';
                      final userPreferences1 =
                          Provider.of<UserPref>(context, listen: false);
                      UserModel data = await userPreferences1.getUser();
                      id = data.user!.id.toString();
                      await browser.open(
                          url: WebUri(
                              MapUrl.getPlannerDistributionMapEndPoint(id)),
                          settings: ChromeSafariBrowserSettings(
                              shareState: CustomTabsShareState.SHARE_STATE_OFF,
                              barCollapsingEnabled: true));
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.maps_ugc,
                    ),
                    title: const Text('Add ROW Transmission Map'),
                    textColor: AppColors.baseColor,
                    iconColor: AppColors.baseColor,
                    onTap: () async {
                      String id = '';
                      final userPreferences1 =
                          Provider.of<UserPref>(context, listen: false);
                      UserModel data = await userPreferences1.getUser();
                      id = data.user!.id.toString();
                      await browser.open(
                          url: WebUri(
                              MapUrl.getPlannerTransmissionMapEndPoint(id)),
                          settings: ChromeSafariBrowserSettings(
                              shareState: CustomTabsShareState.SHARE_STATE_OFF,
                              barCollapsingEnabled: true));
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.map,
                    ),
                    title: const Text('Add Herbicide Transmission Map'),
                    textColor: AppColors.baseColor,
                    iconColor: AppColors.baseColor,
                    onTap: () async {
                      String id = '';
                      final userPreferences1 =
                          Provider.of<UserPref>(context, listen: false);
                      UserModel data = await userPreferences1.getUser();
                      id = data.user!.id.toString();
                      await browser.open(
                          url: WebUri(MapUrl.midTransmissionMapEndPoint(id)),
                          settings: ChromeSafariBrowserSettings(
                              shareState: CustomTabsShareState.SHARE_STATE_OFF,
                              barCollapsingEnabled: true));
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.maps_ugc_rounded,
                    ),
                    title: const Text('Add Annual Herbicide Map'),
                    textColor: AppColors.baseColor,
                    iconColor: AppColors.baseColor,
                    onTap: () async {
                      String id = '';
                      final userPreferences1 =
                          Provider.of<UserPref>(context, listen: false);
                      UserModel data = await userPreferences1.getUser();
                      id = data.user!.id.toString();
                      await browser.open(
                          url: WebUri(MapUrl.officeTransmissionMapEndPoint(id)),
                          settings: ChromeSafariBrowserSettings(
                              shareState: CustomTabsShareState.SHARE_STATE_OFF,
                              barCollapsingEnabled: true));
                    },
                  ),
                  ////////////////////////////////////
                  ListTile(
                    leading: Icon(
                      Icons.list,
                    ),
                    title: const Text('Invoice List'),
                    textColor: AppColors.baseColor,
                    iconColor: AppColors.baseColor,
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              SupInvoiceList()));
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.location_on,
                    ),
                    title: const Text('Live IVM System Map'),
                    textColor: AppColors.baseColor,
                    iconColor: AppColors.baseColor,
                    onTap: () {
                      provider.getLocation();
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const MapScreenLeafLat()));
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.approval,
                    ),
                    title: const Text('Approve CIVM Access'),
                    textColor: AppColors.baseColor,
                    iconColor: AppColors.baseColor,
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const SupervisorApproveCIVMAccess()));
                    },
                  ),

                  ListTile(
                    leading: const Icon(
                      Icons.add,
                    ),
                    title: const Text('Add Crew Member'),
                    textColor: AppColors.baseColor,
                    iconColor: AppColors.baseColor,
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),

                  // ListTile(
                  //   leading: const Icon(
                  //     Icons.close,
                  //   ),
                  //   title: const Text('Order Closed'),
                  //   textColor: AppColors.baseColor,
                  //   iconColor: AppColors.baseColor,
                  //   onTap: () {
                  //     Navigator.of(context).push(MaterialPageRoute(
                  //         builder: (BuildContext context) =>
                  //             const OrderClosedSupervisor()));
                  //   },
                  // ),

                  // ListTile(
                  //   leading: const Icon(
                  //     Icons.inventory,
                  //   ),
                  //   title: const Text('Create Invoice'),
                  //   textColor: AppColors.baseColor,
                  //   iconColor: AppColors.baseColor,
                  //   onTap: () {
                  //     Navigator.of(context).push(MaterialPageRoute(
                  //         builder: (BuildContext context) => const CreateInvoice()));
                  //   },
                  // ),

                  // ListTile(
                  //   leading: const Icon(
                  //     Icons.list_alt,
                  //   ),
                  //   title: const Text('Invoice List'),
                  //   textColor: AppColors.baseColor,
                  //   iconColor: AppColors.baseColor,
                  //   onTap: () {
                  //     Navigator.of(context).push(MaterialPageRoute(
                  //         builder: (BuildContext context) => const InvoiceList()));
                  //   },
                  // ),

                  ListTile(
                    leading: const Icon(
                      Icons.logout,
                    ),
                    title: const Text('Log Out'),
                    textColor: AppColors.baseColor,
                    iconColor: AppColors.baseColor,
                    onTap: () {
                      // // Constants.prefs.setBool("LoggedIn", false);
                      userPreferences.remove().then((value) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const LoginPagePemc()));
                      });
                      // Navigator.of(context).pushReplacement(MaterialPageRoute(
                      //     builder: (BuildContext context) => const LoginPage()));
                    },
                  ),
                ],
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
      'https://atsdev2test.ariespro.com/assets/clientuploads/${data.user!.profilePhoto}',
    );
    String imageUrl =
        'https://atsdev2test.ariespro.com/assets/clientuploads/${data.user!.profilePhoto}';
    _imagePath = imageUrl;
    setState(() {
      userName = '${data.user!.fName} ${data.user!.lName}';
    });
  }
}
