import 'package:CIVM/models/user_details.dart';
import 'package:CIVM/models/user_model.dart';
import 'package:CIVM/screens/generalForeman_New_pannel/contractor_bottom_navigation.dart';
import 'package:CIVM/resources/app_url.dart';
import 'package:CIVM/screens/planner_pannel.dart/planner_bottom_navigation.dart';
import 'package:CIVM/utils/common_functions.dart';
import 'package:CIVM/screens/generalForeman_New_pannel/gf_maintenance_report_view_new.dart';
import 'package:CIVM/screens/generalForeman_New_pannel/inspection.dart';
import 'package:CIVM/screens/leaflat_map/leaf_lat_map_wakeLock.dart';
import 'package:CIVM/screens/login_page.dart';
import 'package:CIVM/screens/map/provider/location_provider.dart';
import 'package:CIVM/screens/my_chrome_safari_map_recording.dart';
import 'package:CIVM/sharedPrefs/constants.dart';
import 'package:CIVM/utils/custom_toast_snackbar_progressdialog.dart';
import 'package:CIVM/utils/user_pref.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../data/response/status.dart';
import '../../../view_model/add_crew_member_view_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class GFAddCrewMember extends StatefulWidget {
  const GFAddCrewMember({Key? key}) : super(key: key);

  @override
  State<GFAddCrewMember> createState() => _GFAddCrewMemberState();
}

class _GFAddCrewMemberState extends State<GFAddCrewMember> {
  // final List<Widget> _children = [
  //   RowMaintenancePlan(),
  //   // BottomNavigationHomePage(),
  //   // BottomNavigationAccountPage()
  // ];

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
  bool isSaveLoading = false;
  bool isUpdateLoading = false;
  String? crewTypeError;
  String userTypeText = '';
  String primaryRoleText = '';

  @override
  void initState() {
    addCrewMemberViewModel.fetchAddCrewMemberTabularListApi(context);
    super.initState();
    getUserType();
    _initializeScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Add New Crew Member',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 7, 59, 120),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add, color: Colors.white),
            onPressed: () {
              _initializeScreen();
              openDailogAddCrewMember();
              // do something
            },
          ),
        ],
      ),
      drawer: DrawerManu(menu: menu),
      body: ChangeNotifierProvider<AddCrewMemberViewModel>(
        create: (BuildContext context) => addCrewMemberViewModel,
        child: Consumer<AddCrewMemberViewModel>(
          builder: (context, value, _) {
            switch (value.addCrewMemberTabularData.status) {
              case Status.LOADING:
                return const Center(child: CircularProgressIndicator());
              case Status.ERROR:
                return Padding(
                  padding: const EdgeInsets.only(
                    top: 16.0,
                    bottom: 16,
                    left: 8,
                    right: 8,
                  ),
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

              // CustomToastSnackBarProgressDialog.flushBarErrorMessage(
              //     value.addCrewMemberTabularData.message.toString(),
              //     context);

              case Status.COMPLETED:
                return RefreshIndicator(
                  onRefresh: () async {
                    _input.clear();
                    await addCrewMemberViewModel
                        .fetchAddCrewMemberTabularListApi(context);
                    _initializeScreen();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Column(
                      children: [
                        (primaryRoleText != userTypeText)
                            ? Padding(
                                padding: EdgeInsets.only(
                                  top: 8.0,
                                  left: 8,
                                  bottom: 8,
                                ),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "$primaryRoleText, acting as $userTypeText.",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              )
                            : Container(),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 8.0,
                              right: 8.0,
                            ),
                            child: TextFormField(
                              onChanged: (value) => _filterData(value),
                              //  key: formkey2,
                              controller: _input,
                              style: const TextStyle(
                                color: Color.fromARGB(255, 7, 59, 120),
                                fontSize: 16,
                              ),
                              obscureText: false,

                              //keyboardType: TextInputType.number,
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
                                        width:
                                            MediaQuery.of(context).size.width *
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
                                          bottom: 5.0,
                                        ),
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                            color: const Color.fromARGB(
                                              255,
                                              7,
                                              59,
                                              120,
                                            ),
                                          ),
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            bottomLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                            bottomRight: Radius.circular(10),
                                          ),
                                        ),
                                        child: Column(
                                          children: [
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
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color:
                                                                      Color.fromARGB(
                                                                        255,
                                                                        7,
                                                                        59,
                                                                        120,
                                                                      ),
                                                                ),
                                                              ),
                                                            ),
                                                            Align(
                                                              alignment:
                                                                  Alignment
                                                                      .topLeft,
                                                              child: Text(
                                                                (addCrewMemberViewModel.addCrewMemberTabularData.data!.getaAllCewMemberTableDatas![index].id ==
                                                                            null ||
                                                                        addCrewMemberViewModel.addCrewMemberTabularData.data!.getaAllCewMemberTableDatas![index].id
                                                                                .toString() ==
                                                                            'null')
                                                                    ? ''
                                                                    : addCrewMemberViewModel
                                                                          .addCrewMemberTabularData
                                                                          .data!
                                                                          .getaAllCewMemberTableDatas![index]
                                                                          .id
                                                                          .toString(),
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style: const TextStyle(
                                                                  fontSize: 12,
                                                                  //  fontWeight:
                                                                  //      FontWeight.bold,
                                                                  color:
                                                                      Color.fromARGB(
                                                                        255,
                                                                        7,
                                                                        59,
                                                                        120,
                                                                      ),
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
                                                                "CREW NAME: ",
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style: TextStyle(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color:
                                                                      Color.fromARGB(
                                                                        255,
                                                                        7,
                                                                        59,
                                                                        120,
                                                                      ),
                                                                ),
                                                              ),
                                                            ),
                                                            Align(
                                                              alignment:
                                                                  Alignment
                                                                      .topLeft,
                                                              child: Text(
                                                                (addCrewMemberViewModel.addCrewMemberTabularData.data!.getaAllCewMemberTableDatas![index].name ==
                                                                            null ||
                                                                        addCrewMemberViewModel.addCrewMemberTabularData.data!.getaAllCewMemberTableDatas![index].name
                                                                                .toString() ==
                                                                            'null')
                                                                    ? ''
                                                                    : addCrewMemberViewModel
                                                                          .addCrewMemberTabularData
                                                                          .data!
                                                                          .getaAllCewMemberTableDatas![index]
                                                                          .name
                                                                          .toString(),
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style: const TextStyle(
                                                                  fontSize: 12,
                                                                  //  fontWeight:
                                                                  //      FontWeight.bold,
                                                                  color:
                                                                      Color.fromARGB(
                                                                        255,
                                                                        7,
                                                                        59,
                                                                        120,
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
                                              ],
                                            ),
                                            const Divider(color: Colors.grey),
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
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color:
                                                                      Color.fromARGB(
                                                                        255,
                                                                        7,
                                                                        59,
                                                                        120,
                                                                      ),
                                                                ),
                                                              ),
                                                            ),
                                                            Align(
                                                              alignment:
                                                                  Alignment
                                                                      .topLeft,
                                                              child: Text(
                                                                (addCrewMemberViewModel.addCrewMemberTabularData.data!.getaAllCewMemberTableDatas![index].contractor ==
                                                                            null ||
                                                                        addCrewMemberViewModel.addCrewMemberTabularData.data!.getaAllCewMemberTableDatas![index].contractor
                                                                                .toString() ==
                                                                            'null')
                                                                    ? ''
                                                                    : addCrewMemberViewModel
                                                                          .addCrewMemberTabularData
                                                                          .data!
                                                                          .getaAllCewMemberTableDatas![index]
                                                                          .contractor
                                                                          .toString(),
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style: const TextStyle(
                                                                  fontSize: 12,
                                                                  //  fontWeight:
                                                                  //      FontWeight.bold,
                                                                  color:
                                                                      Color.fromARGB(
                                                                        255,
                                                                        7,
                                                                        59,
                                                                        120,
                                                                      ),
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
                                                                "SUPERVISOR NAME: ",
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style: TextStyle(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color:
                                                                      Color.fromARGB(
                                                                        255,
                                                                        7,
                                                                        59,
                                                                        120,
                                                                      ),
                                                                ),
                                                              ),
                                                            ),
                                                            Align(
                                                              alignment:
                                                                  Alignment
                                                                      .topLeft,
                                                              child: Text(
                                                                (addCrewMemberViewModel.addCrewMemberTabularData.data!.getaAllCewMemberTableDatas![index].supervisor ==
                                                                            null ||
                                                                        addCrewMemberViewModel.addCrewMemberTabularData.data!.getaAllCewMemberTableDatas![index].supervisor
                                                                                .toString() ==
                                                                            'null')
                                                                    ? ''
                                                                    : addCrewMemberViewModel
                                                                          .addCrewMemberTabularData
                                                                          .data!
                                                                          .getaAllCewMemberTableDatas![index]
                                                                          .supervisor
                                                                          .toString(),
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style: const TextStyle(
                                                                  fontSize: 12,
                                                                  //  fontWeight:
                                                                  //      FontWeight.bold,
                                                                  color:
                                                                      Color.fromARGB(
                                                                        255,
                                                                        7,
                                                                        59,
                                                                        120,
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
                                              ],
                                            ),
                                            const Divider(color: Colors.grey),
                                            Row(
                                              children: [
                                                Expanded(
                                                  // alignment: Alignment.topLeft,
                                                  child: Column(
                                                    children: [
                                                      const Align(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: Text(
                                                          "STATUS: ",
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Color.fromARGB(
                                                                  255,
                                                                  7,
                                                                  59,
                                                                  120,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                      Align(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: Text(
                                                          (addCrewMemberViewModel
                                                                          .addCrewMemberTabularData
                                                                          .data!
                                                                          .getaAllCewMemberTableDatas![index]
                                                                          .status ==
                                                                      null ||
                                                                  addCrewMemberViewModel
                                                                          .addCrewMemberTabularData
                                                                          .data!
                                                                          .getaAllCewMemberTableDatas![index]
                                                                          .status
                                                                          .toString() ==
                                                                      'null')
                                                              ? ''
                                                              : addCrewMemberViewModel
                                                                    .addCrewMemberTabularData
                                                                    .data!
                                                                    .getaAllCewMemberTableDatas![index]
                                                                    .status
                                                                    .toString(),
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: const TextStyle(
                                                            fontSize: 12,
                                                            //  fontWeight:
                                                            //      FontWeight.bold,
                                                            color:
                                                                Color.fromARGB(
                                                                  255,
                                                                  7,
                                                                  59,
                                                                  120,
                                                                ),
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
                                                            Alignment.topLeft,
                                                        child: Text(
                                                          "CREW TYPE: ",
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Color.fromARGB(
                                                                  255,
                                                                  7,
                                                                  59,
                                                                  120,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                      Align(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: Text(
                                                          (addCrewMemberViewModel
                                                                          .addCrewMemberTabularData
                                                                          .data!
                                                                          .getaAllCewMemberTableDatas![index]
                                                                          .crewType ==
                                                                      null ||
                                                                  addCrewMemberViewModel
                                                                          .addCrewMemberTabularData
                                                                          .data!
                                                                          .getaAllCewMemberTableDatas![index]
                                                                          .crewType
                                                                          .toString() ==
                                                                      'null')
                                                              ? "Not Assigned"
                                                              : addCrewMemberViewModel
                                                                    .addCrewMemberTabularData
                                                                    .data!
                                                                    .getaAllCewMemberTableDatas![index]
                                                                    .crewType
                                                                    .toString(),
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: const TextStyle(
                                                            fontSize: 12,
                                                            //  fontWeight:
                                                            //      FontWeight.bold,
                                                            color:
                                                                Color.fromARGB(
                                                                  255,
                                                                  7,
                                                                  59,
                                                                  120,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const Divider(color: Colors.grey),
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
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color:
                                                                      Color.fromARGB(
                                                                        255,
                                                                        7,
                                                                        59,
                                                                        120,
                                                                      ),
                                                                ),
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
                                                                    (addCrewMemberViewModel.addCrewMemberTabularData.data!.getaAllCewMemberTableDatas![index].status!.isNotEmpty &&
                                                                            addCrewMemberViewModel.addCrewMemberTabularData.data!.getaAllCewMemberTableDatas![index].status!.toString() ==
                                                                                'PENDING')
                                                                        ? 'ALLOW'
                                                                        : 'DENY',
                                                                    index,
                                                                    addCrewMemberViewModel
                                                                        .addCrewMemberTabularData
                                                                        .data!
                                                                        .getaAllCewMemberTableDatas![index]
                                                                        .id
                                                                        .toString(),
                                                                    addCrewMemberViewModel
                                                                        .addCrewMemberTabularData
                                                                        .data!
                                                                        .getaAllCewMemberTableDatas![index]
                                                                        .status
                                                                        .toString(),
                                                                  );
                                                                },
                                                                child: Container(
                                                                  // padding: const EdgeInsets.all(2),
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  height: 30,
                                                                  width: 90,
                                                                  decoration: BoxDecoration(
                                                                    // shape: BoxShape.circle,
                                                                    // borderRadius: BorderRadius.circular(10),
                                                                    boxShadow:
                                                                        (addCrewMemberViewModel.addCrewMemberTabularData.data!.getaAllCewMemberTableDatas![index].status!.toString().isNotEmpty &&
                                                                            addCrewMemberViewModel.addCrewMemberTabularData.data!.getaAllCewMemberTableDatas![index].status!.toString() ==
                                                                                'PENDING')
                                                                        ? [
                                                                            const BoxShadow(
                                                                              color: Color.fromARGB(
                                                                                255,
                                                                                2,
                                                                                43,
                                                                                113,
                                                                              ),
                                                                              blurRadius: 5,
                                                                              offset: Offset(
                                                                                2.0,
                                                                                5.0,
                                                                              ),
                                                                            ),
                                                                          ]
                                                                        : [
                                                                            const BoxShadow(
                                                                              color: Color.fromARGB(
                                                                                255,
                                                                                117,
                                                                                10,
                                                                                2,
                                                                              ),
                                                                              blurRadius: 5,
                                                                              offset: Offset(
                                                                                2.0,
                                                                                5.0,
                                                                              ),
                                                                            ),
                                                                          ],
                                                                    color: Colors
                                                                        .black,
                                                                    gradient: LinearGradient(
                                                                      colors:
                                                                          (addCrewMemberViewModel.addCrewMemberTabularData.data!.getaAllCewMemberTableDatas![index].status!.toString().isNotEmpty &&
                                                                              addCrewMemberViewModel.addCrewMemberTabularData.data!.getaAllCewMemberTableDatas![index].status.toString() ==
                                                                                  'ACTIVE')
                                                                          ? (addCrewMemberViewModel.addCrewMemberTabularData.data!.getaAllCewMemberTableDatas![index].status!.toString().isNotEmpty &&
                                                                                    addCrewMemberViewModel.addCrewMemberTabularData.data!.getaAllCewMemberTableDatas![index].status.toString() ==
                                                                                        'PENDING')
                                                                                ? [
                                                                                    const Color.fromARGB(
                                                                                      255,
                                                                                      243,
                                                                                      128,
                                                                                      119,
                                                                                    ),
                                                                                    const Color.fromARGB(
                                                                                      255,
                                                                                      243,
                                                                                      128,
                                                                                      119,
                                                                                    ),
                                                                                    const Color.fromARGB(
                                                                                      255,
                                                                                      243,
                                                                                      128,
                                                                                      119,
                                                                                    ),
                                                                                  ]
                                                                                : [
                                                                                    Colors.red,
                                                                                    Colors.red,
                                                                                    Colors.red,
                                                                                  ]
                                                                          : [
                                                                              Colors.blueAccent,
                                                                              const Color.fromARGB(
                                                                                255,
                                                                                3,
                                                                                91,
                                                                                242,
                                                                              ),
                                                                              Colors.blueAccent,
                                                                            ],
                                                                    ),
                                                                  ),
                                                                  child: Column(
                                                                    children: [
                                                                      Expanded(
                                                                        child: Align(
                                                                          alignment:
                                                                              Alignment.center,
                                                                          child: Text(
                                                                            (addCrewMemberViewModel.addCrewMemberTabularData.data!.getaAllCewMemberTableDatas![index].status!.toString().isNotEmpty &&
                                                                                    addCrewMemberViewModel.addCrewMemberTabularData.data!.getaAllCewMemberTableDatas![index].status!.toString() ==
                                                                                        'PENDING')
                                                                                ? 'ALLOW'
                                                                                : 'DENY',
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style: const TextStyle(
                                                                              color: Colors.white,
                                                                              fontWeight: FontWeight.bold,
                                                                              fontSize: 15,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              width: 10,
                                                            ),
                                                            Align(
                                                              alignment:
                                                                  Alignment
                                                                      .topLeft,
                                                              child: InkWell(
                                                                onTap: () {
                                                                  var crewTypeValue =
                                                                      (addCrewMemberViewModel.addCrewMemberTabularData.data!.getaAllCewMemberTableDatas![index].crewType ==
                                                                              null ||
                                                                          addCrewMemberViewModel.addCrewMemberTabularData.data!.getaAllCewMemberTableDatas![index].crewType
                                                                                  .toString() ==
                                                                              'null')
                                                                      ? ''
                                                                      : addCrewMemberViewModel
                                                                            .addCrewMemberTabularData
                                                                            .data!
                                                                            .getaAllCewMemberTableDatas![index]
                                                                            .crewType
                                                                            .toString();
                                                                  openDailogUpdateCrewType(
                                                                    crewTypeValue,
                                                                    addCrewMemberViewModel
                                                                        .addCrewMemberTabularData
                                                                        .data!
                                                                        .getaAllCewMemberTableDatas![index]
                                                                        .id
                                                                        .toString(),
                                                                    addCrewMemberViewModel
                                                                        .addCrewMemberTabularData
                                                                        .data!
                                                                        .getaAllCewMemberTableDatas![index]
                                                                        .name
                                                                        .toString(),
                                                                  );
                                                                },
                                                                child: Container(
                                                                  // padding: const EdgeInsets.all(2),
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  height: 30,
                                                                  width: 120,
                                                                  decoration: const BoxDecoration(
                                                                    // shape: BoxShape.circle,
                                                                    // borderRadius: BorderRadius.circular(10),
                                                                    boxShadow: [
                                                                      BoxShadow(
                                                                        color: Color.fromARGB(
                                                                          255,
                                                                          1,
                                                                          104,
                                                                          4,
                                                                        ),
                                                                        blurRadius:
                                                                            10,
                                                                        offset: Offset(
                                                                          2.0,
                                                                          5.0,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                    color: Colors
                                                                        .black,
                                                                    gradient: LinearGradient(
                                                                      colors: [
                                                                        Colors
                                                                            .green,
                                                                        Colors
                                                                            .green,
                                                                        // Color.fromARGB(255, 3, 224, 10),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  child: const Column(
                                                                    children: [
                                                                      Expanded(
                                                                        child: Align(
                                                                          alignment:
                                                                              Alignment.center,
                                                                          child: Text(
                                                                            'EDIT TYPE',
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style: TextStyle(
                                                                              color: Colors.white,
                                                                              fontWeight: FontWeight.bold,
                                                                              fontSize: 15,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
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
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );

              default:
                return const Text('data');
            }
          },
        ),
      ),
    );
  }

  Future<void> _filterData(String query) async {
    if (query.isEmpty) {
      addCrewMemberViewModel.fetchAddCrewMemberTabularListApi(context);
    } else {
      addCrewMemberViewModel
          .addCrewMemberTabularData
          .data
          ?.getaAllCewMemberTableDatas = addCrewMemberViewModel
          .addCrewMemberTabularData
          .data
          ?.getaAllCewMemberTableDatas
          ?.where(
            (item) =>
                item.status.toString().toLowerCase().contains(
                  query.toLowerCase(),
                ) ||
                item.name.toString().toLowerCase().contains(
                  query.toLowerCase(),
                ) ||
                item.contractor.toString().toLowerCase().contains(
                  query.toLowerCase(),
                ) ||
                item.supervisor.toString().toLowerCase().contains(
                  query.toLowerCase(),
                ) ||
                item.id.toString().toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
    }
    setState(() {});
  }

  List<String> crewTypes = [
    "JARRAFF",
    "MOWING",
    "BYL",
    "BUCKET",
    "GROUND",
    "MINI JARRAFF",
    "HERBICIDE",
  ];
  List<String> selectedCrewTypes = [];
  Future openDailogAddCrewMember() => showDialog(
    context: context,
    builder: (context) {
      // setDataCrew();
      crewTypeError = null;
      // setDataCrew();
      bool _obscurePassword = true;
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Add New Crew",
                  style: TextStyle(color: Color.fromARGB(255, 7, 59, 120)),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 30,
                    width: 30,
                    child: const Center(
                      child: Icon(Icons.close, color: Colors.red, size: 25),
                    ),
                  ),
                ),
              ],
            ),
            content: Form(
              key: _addCrewFormKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 0),
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
                                  color: Color.fromARGB(255, 7, 59, 120),
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: TextFormField(
                                //  key: formkey2,
                                controller: _crewName,
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 7, 59, 120),
                                  fontSize: 16,
                                ),
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
                                  hintText: 'Crew Name',
                                  // prefixIcon: const Icon(
                                  //   Icons.person,
                                  //   color: Color.fromARGB(255, 7, 59, 120),
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
                                "Email",
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Color.fromARGB(255, 7, 59, 120),
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: TextFormField(
                                //  key: formkey2,
                                controller: _email,
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 7, 59, 120),
                                  fontSize: 16,
                                ),
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
                                  hintText: 'Email',
                                  // prefixIcon: const Icon(
                                  //   Icons.person,
                                  //   color: Color.fromARGB(255, 7, 59, 120),
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
                          ),
                        ],
                      ),
                    ),

                    //       Container(
                    //         margin: const EdgeInsets.only(top: 10),
                    //         child: Column(
                    //           children: [
                    //             const Align(
                    //                 alignment: Alignment.centerLeft,
                    //                 child: Padding(
                    //                   padding: EdgeInsets.all(2.0),
                    //                   child: Text(
                    //                     "Password",
                    //                     style: TextStyle(
                    //                       fontSize: 16.0,
                    //                       color: Color.fromARGB(255, 7, 59, 120),
                    //                     ),
                    //                   ),
                    //                 )),
                    //           Align(
                    //   alignment: Alignment.centerRight,
                    //   child: Padding(
                    //     padding: const EdgeInsets.all(2.0),
                    //     child: TextFormField(
                    //       controller: _password,
                    //       style: const TextStyle(
                    //         color: Color.fromARGB(255, 7, 59, 120),
                    //         fontSize: 16,
                    //       ),
                    //       obscureText: _obscurePassword,
                    //       decoration: InputDecoration(
                    //         border: const OutlineInputBorder(),
                    //         enabledBorder: const OutlineInputBorder(
                    //           borderSide: BorderSide(
                    // color: Color.fromARGB(255, 7, 59, 120),
                    //           ),
                    //         ),
                    //         hintText: 'Password',
                    //         suffixIcon: IconButton(
                    //           icon: Icon(
                    // _obscurePassword ? Icons.visibility_off : Icons.visibility,
                    // color: const Color.fromARGB(255, 7, 59, 120),
                    //           ),
                    //           onPressed: () {
                    // setState(() {
                    //   _obscurePassword = !_obscurePassword;
                    // });
                    //           },
                    //         ),
                    //       ),
                    //       validator: (value) {
                    //         if (value == null || value.isEmpty) {
                    //           return "Please enter password";
                    //         }
                    //         return null;
                    //       },
                    //     ),
                    //   ),
                    // ),

                    //           ],
                    //         ),
                    //       ),
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
                                  color: Color.fromARGB(255, 7, 59, 120),
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: DropdownButtonFormField<String>(
                                hint: const Text('-Select-'),
                                dropdownColor: Colors.white,
                                value: selectedAssignContractor,
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 7, 59, 120),
                                  fontSize: 16,
                                ),
                                icon: const Icon(
                                  Icons.arrow_drop_down,
                                  color: Color.fromARGB(255, 7, 59, 120),
                                  size: 40,
                                ),
                                decoration: const InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color.fromARGB(255, 7, 59, 120),
                                    ),
                                    // borderRadius: BorderRadius.circular(25),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color.fromARGB(255, 7, 59, 120),
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
                                    })
                                    .toList(),
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
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Crew Type",
                            style: TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 7, 59, 120),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 4),
                            // padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              // color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: const Color.fromARGB(255, 7, 59, 120),
                              ),
                            ),
                            child: Wrap(
                              spacing: 0,
                              children: crewTypes.map((type) {
                                return SizedBox(
                                  width: 140,
                                  child: CheckboxListTile(
                                    dense: true,
                                    visualDensity: const VisualDensity(
                                      horizontal: -4,
                                      vertical: -4,
                                    ),
                                    contentPadding: EdgeInsets.zero,
                                    title: Text(
                                      type,
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                    // value: selectedCrewTypes.contains(type),
                                    value: type == "HERBICIDE"
                                        ? selectedCrewTypes.contains(
                                                "CROSS-COUNTRY SPRAY",
                                              ) &&
                                              selectedCrewTypes.contains(
                                                "ROADSIDE SPRAY",
                                              )
                                        : selectedCrewTypes.contains(type),
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                    // onChanged: (value) {
                                    //   setState(() {
                                    //     if (value == true) {
                                    //       selectedCrewTypes.add(type);
                                    //     } else {
                                    //       selectedCrewTypes.remove(type);
                                    //     }
                                    //   });
                                    // },
                                    onChanged: (value) {
                                      setState(() {
                                        crewTypeError = null;
                                        if (type == "HERBICIDE") {
                                          if (value == true) {
                                            if (!selectedCrewTypes.contains(
                                              "CROSS-COUNTRY SPRAY",
                                            )) {
                                              selectedCrewTypes.add(
                                                "CROSS-COUNTRY SPRAY",
                                              );
                                            }
                                            if (!selectedCrewTypes.contains(
                                              "ROADSIDE SPRAY",
                                            )) {
                                              selectedCrewTypes.add(
                                                "ROADSIDE SPRAY",
                                              );
                                            }
                                          } else {
                                            selectedCrewTypes.remove(
                                              "CROSS-COUNTRY SPRAY",
                                            );
                                            selectedCrewTypes.remove(
                                              "ROADSIDE SPRAY",
                                            );
                                          }
                                        } else {
                                          if (value == true) {
                                            if (!selectedCrewTypes.contains(
                                              type,
                                            )) {
                                              selectedCrewTypes.add(type);
                                            }
                                          } else {
                                            selectedCrewTypes.remove(type);
                                          }
                                        }
                                      });

                                      print(selectedCrewTypes.join(","));
                                    },
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (crewTypeError != null)
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 0),
                          child: Text(
                            crewTypeError!,
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    Row(
                      children: [
                        const Text(
                          "Active",
                          style: TextStyle(
                            color: Color.fromARGB(255, 7, 59, 120),
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Switch(
                          value: _active ?? false,
                          onChanged: (value) {
                            setState(() {
                              _active = value;
                            });
                          },
                        ),
                      ],
                    ),
                    // Align(
                    //   alignment: Alignment.centerLeft,
                    //   child: CheckboxListTile(
                    //     title: const Text("Active",
                    //         style: TextStyle(
                    //             color: Color.fromARGB(255, 7, 59, 120),
                    //             fontSize: 20)),
                    //     //secondary: Icon(Icons.beach_access),
                    //     controlAffinity: ListTileControlAffinity.leading,
                    //     value: _active,
                    //     onChanged: (val) {
                    //       setState(() {
                    //         _active = val;
                    //       });
                    //     },
                    //     activeColor: const Color.fromARGB(255, 80, 157, 244),
                    //     checkColor: const Color.fromARGB(255, 7, 59, 120),
                    //   ),
                    // ),
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
                    if (selectedCrewTypes.isEmpty) {
                      setState(() {
                        crewTypeError = "Please select any Crew Type";
                      });
                      return;
                    } else {
                      setState(() {
                        crewTypeError = null;
                      });
                    }
                    setState(() {
                      isSaveLoading = true;
                    });
                    Map<String, dynamic> mapData = {
                      "fName":
                          (_crewName.text.toString() == 'null' ||
                              _crewName.text.toString() == '')
                          ? 'N/A'
                          : _crewName.text.toString(),
                      "status": (_active == true) ? 'ACTIVE' : 'PENDING',
                      // "userName": (_crewName.text.toString() == 'null' ||
                      //         _crewName.text.toString() == '')
                      //     ? 'N/A'
                      //     : _crewName.text.toString(),
                      "email":
                          (_email.text.toString() == 'null' ||
                              _email.text.toString() == '')
                          ? 'N/A'
                          : _email.text.toString(),
                      "password": "",
                      // (_password.text.toString() == 'null' ||
                      //         _password.text.toString() == '')
                      //     ? 'N/A'
                      //     : _password.text.toString(),
                      "contractor": assignContratorId.toString(),
                      "crew_type": selectedCrewTypes.join(","),
                    };
                    print(mapData);
                    createCrew(context, mapData);
                    // addCrewMemberViewModel
                    //     .fetchAddCrewMemberInsertApi(context, mapData)
                    //     .then((value) {
                    //   Navigator.pop(context);
                    //   addCrewMemberViewModel
                    //       .fetchAddCrewMemberTabularListApi(context);
                    // });
                  },
                  child: Container(
                    margin: const EdgeInsets.only(
                      left: 40,
                      right: 40,
                      bottom: 10.0,
                    ),
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
                          offset: Offset(2.0, 5.0),
                        ),
                      ],
                      color: Colors.black,
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(255, 1, 45, 120),
                          Colors.blue,
                          Color.fromARGB(255, 0, 79, 215),
                        ],
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Align(
                            alignment: Alignment.center,
                            child: isSaveLoading
                                ? progressBar()
                                : Text(
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
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      );
    },
  );
  List<String> selectedUpdateCrewTypes = [];
  Future openDailogUpdateCrewType(
    String crewType,
    String id,
    String crewName,
  ) => showDialog(
    context: context,
    builder: (context) {
      crewTypeError = null;
      String crewTypeString = crewType;

      selectedUpdateCrewTypes = crewTypeString
          .split(',')
          .map((e) => e.trim())
          .toList();
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Edit Crew Type",
                  style: TextStyle(color: Color.fromARGB(255, 7, 59, 120)),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 30,
                    width: 30,
                    child: const Center(
                      child: Icon(Icons.close, color: Colors.red, size: 25),
                    ),
                  ),
                ),
              ],
            ),
            content: Form(
              key: _addCrewFormKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      // margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: const Color(0xffE9EDF3),
                        borderRadius: BorderRadius.circular(14),
                        border: const Border(
                          left: BorderSide(
                            color: Color.fromARGB(
                              255,
                              7,
                              59,
                              120,
                            ), // your border color
                            width: 5, // border thickness
                          ),
                        ),
                      ),
                      child: Text.rich(
                        TextSpan(
                          children: [
                            const TextSpan(
                              text: 'Crew Name : ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 7, 59, 120),
                              ),
                            ),
                            TextSpan(
                              text: crewName,
                              style: const TextStyle(
                                fontWeight: FontWeight.normal,
                                color: Color.fromARGB(255, 7, 59, 120),
                              ),
                            ),
                          ],
                        ),
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Select Crew Type",
                            style: TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 7, 59, 120),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 4),
                            // padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              // color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: const Color.fromARGB(255, 7, 59, 120),
                              ),
                            ),
                            child: Wrap(
                              spacing: 0,
                              children: crewTypes.map((type) {
                                return SizedBox(
                                  width: 140,
                                  child: CheckboxListTile(
                                    dense: true,
                                    visualDensity: const VisualDensity(
                                      horizontal: -4,
                                      vertical: -4,
                                    ),
                                    contentPadding: EdgeInsets.zero,
                                    title: Text(
                                      type,
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                    // value: selectedCrewTypes.contains(type),
                                    value: type == "HERBICIDE"
                                        ? selectedUpdateCrewTypes.contains(
                                                "CROSS-COUNTRY SPRAY",
                                              ) &&
                                              selectedUpdateCrewTypes.contains(
                                                "ROADSIDE SPRAY",
                                              )
                                        : selectedUpdateCrewTypes.contains(
                                            type,
                                          ),
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                    // onChanged: (value) {
                                    //   setState(() {
                                    //     if (value == true) {
                                    //       selectedCrewTypes.add(type);
                                    //     } else {
                                    //       selectedCrewTypes.remove(type);
                                    //     }
                                    //   });
                                    // },
                                    onChanged: (value) {
                                      setState(() {
                                        crewTypeError = null;
                                        if (type == "HERBICIDE") {
                                          if (value == true) {
                                            if (!selectedUpdateCrewTypes
                                                .contains(
                                                  "CROSS-COUNTRY SPRAY",
                                                )) {
                                              selectedUpdateCrewTypes.add(
                                                "CROSS-COUNTRY SPRAY",
                                              );
                                            }
                                            if (!selectedUpdateCrewTypes
                                                .contains("ROADSIDE SPRAY")) {
                                              selectedUpdateCrewTypes.add(
                                                "ROADSIDE SPRAY",
                                              );
                                            }
                                          } else {
                                            selectedUpdateCrewTypes.remove(
                                              "CROSS-COUNTRY SPRAY",
                                            );
                                            selectedUpdateCrewTypes.remove(
                                              "ROADSIDE SPRAY",
                                            );
                                          }
                                        } else {
                                          if (value == true) {
                                            if (!selectedUpdateCrewTypes
                                                .contains(type)) {
                                              selectedUpdateCrewTypes.add(type);
                                            }
                                          } else {
                                            selectedUpdateCrewTypes.remove(
                                              type,
                                            );
                                          }
                                        }
                                      });

                                      print(selectedUpdateCrewTypes.join(","));
                                    },
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (crewTypeError != null)
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 0),
                          child: Text(
                            crewTypeError!,
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(top: 8),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.lightBlue.shade50,
                        border: Border.all(color: Colors.lightBlue.shade100),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.info_outline,
                            size: 16,
                            color: Colors.blueGrey,
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text.rich(
                              const TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Note: ',
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        'Selecting HERBICIDE will automatically include '
                                        'CROSS-COUNTRY SPRAY, and ROADSIDE SPRAY.',
                                  ),
                                ],
                              ),
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.blueGrey.shade700,
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
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                      left: 6,
                      right: 6,
                      bottom: 10,
                    ),
                    child: InkWell(
                      onTap: () {
                        print("bb");
                        // if (!_addCrewFormKey.currentState!.validate()) {
                        //   return; // ❌ Stop if validation fails
                        // }
                        if (selectedUpdateCrewTypes.isEmpty) {
                          setState(() {
                            crewTypeError = "Please select any Crew Type";
                          });
                          return;
                        } else {
                          setState(() {
                            crewTypeError = null;
                          });
                        }
                        setState(() {
                          isUpdateLoading = true;
                          print('loader loading');
                        });

                        updateCrewType(
                          context,
                          selectedUpdateCrewTypes.join(","),
                          id,
                        );
                      },
                      child: Container(
                        // margin: const EdgeInsets.only(
                        //     left: 40, right: 40, bottom: 10.0),
                        // padding: const EdgeInsets.all(8),
                        alignment: Alignment.center,
                        width: 100,
                        height: 40,
                        decoration: const BoxDecoration(
                          // shape: BoxShape.circle,
                          // borderRadius: BorderRadius.circular(25),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black54,
                              blurRadius: 5,
                              offset: Offset(2.0, 5.0),
                            ),
                          ],
                          color: Colors.black,
                          gradient: LinearGradient(
                            colors: [
                              Color.fromRGBO(46, 125, 50, 1),
                              Colors.green,
                              Color.fromRGBO(46, 125, 50, 1),
                            ],
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Align(
                                alignment: Alignment.center,
                                child: isUpdateLoading
                                    ? progressBar()
                                    : const Text(
                                        "Update",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
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
                      left: 6,
                      right: 6,
                      bottom: 10,
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        // margin: const EdgeInsets.only(
                        //     left: 40, right: 40, bottom: 10.0),
                        // padding: const EdgeInsets.all(8),
                        alignment: Alignment.center,
                        width: 100,
                        height: 40,
                        decoration: const BoxDecoration(
                          // shape: BoxShape.circle,
                          // borderRadius: BorderRadius.circular(25),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black54,
                              blurRadius: 5,
                              offset: Offset(2.0, 5.0),
                            ),
                          ],
                          color: Colors.black,
                          gradient: LinearGradient(
                            colors: [
                              Colors.red,
                              Color.fromRGBO(229, 115, 115, 1),
                              Colors.red,
                            ],
                          ),
                        ),
                        child: const Row(
                          children: [
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
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      );
    },
  );

  Future deny(var data, int ind, String userName, String status) => showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Column(
        children: [
          Text(
            'Are you sure you want to ${data} this user?',
            style: const TextStyle(
              color: Color.fromARGB(255, 7, 59, 120),
              fontWeight: FontWeight.bold,
            ),
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
                              .status =
                          'PENDING';
                    } else {
                      addCrewMemberViewModel
                              .addCrewMemberTabularData
                              .data!
                              .getaAllCewMemberTableDatas![ind]
                              .status =
                          'ACTIVE';
                    }
                    addCrewMemberViewModel.fetchApproveCIVMUpdatePutListApi(
                      context,
                      (data == 'DENY') ? 'PENDING' : 'ACTIVE',
                      userName,
                    );
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
                          offset: Offset(2.0, 5.0),
                        ),
                      ],
                      color: Colors.black,
                      gradient: LinearGradient(
                        colors: [Colors.green, Colors.green],
                      ),
                    ),
                    child: const Row(
                      children: [
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
                      ],
                    ),
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
                      height: MediaQuery.of(context).size.height * 0.052,
                      decoration: const BoxDecoration(
                        // shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(255, 253, 138, 176),
                            blurRadius: 5,
                            offset: Offset(2.0, 5.0),
                          ),
                        ],
                        color: Colors.black,
                        gradient: LinearGradient(
                          colors: [Colors.red, Colors.red],
                        ),
                      ),
                      child: const Row(
                        children: [
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
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
    value: item,
    child: Text(
      item,
      style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 20),
    ),
  );

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
        Uri.parse('https://lcpmapapi.ariespro.com/main/create_crew'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(mappedData),
      );

      final decoded = jsonDecode(response.body);

      // ✅ SUCCESS
      if (response.statusCode >= 200 && response.statusCode < 300) {
        //  CALL SECOND API HERE
        print("Calling sendMailApi...");
        sendMailApi(context);

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

  Future<void> updateCrewType(
    BuildContext context,
    String crewType,
    String id,
  ) async {
    try {
      final userPreferences = Provider.of<UserPref>(context, listen: false);
      UserModel data = await userPreferences.getUser();

      var url =
          '${AppUrl.baseUrl}login_user/editCrewType?type=$crewType&id=$id';

      final response = await http.put(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          "Authorization": 'Bearer ${data.token!}',
        },
      );

      print('update url $url');

      if (response.statusCode == 200) {
        setState(() {
          isUpdateLoading = false;
        });

        print('updated success');

        if (context.mounted) {
          // Future.delayed(const Duration(seconds: 2), () {
          //   if (context.mounted) {
          //     Navigator.of(context, rootNavigator: true).pop();
          //   }
          // });
          Navigator.of(context, rootNavigator: true).pop();
          addCrewMemberViewModel.fetchAddCrewMemberTabularListApi(context);
        }
      } else {
        setState(() {
          isUpdateLoading = false;
        });

        if (context.mounted) {
          // Show error message
        }
      }
    } catch (e) {
      setState(() {
        isUpdateLoading = false;
      });

      if (context.mounted) {
        CustomToastSnackBarProgressDialog.flushBarErrorMessage(
          'Network error. Please try again.',
          context,
        );
      }
    }
  }

  void sendMailApi(BuildContext context) async {
    print('print mail api called');
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    String id = data.user!.id.toString();
    final String url =
        '${AppUrl.baseUrl}rowVegetationManagementDashboard/sendMailToCrew?email=${_email.text}&crewName=${_crewName.text}&loginId=$id';
    print('url: $url');
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer ${data.token}',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        print('Success: ${response.body}');
        print('send mail success');
        // CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
        //   'Crew Inserted Successfully!',
        //   context,
        // );
        setState(() {
          isSaveLoading = false;
        });
      } else {
        setState(() {
          isSaveLoading = false;
        });
        print('Failed: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      setState(() {
        isSaveLoading = false;
      });
      print('Error: $e');
    }
  }

  Future<void> getUserType() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String userType = pref.getString('userType').toString();
    String primaryRole = pref.getString('primaryRole').toString();
    if (userType == '3') {
      userTypeText = 'General Foreman';
    } else if (userType == '6') {
      userTypeText = 'Planner';
    }
    if (primaryRole == '3') {
      primaryRoleText = 'General Foreman';
    } else if (primaryRole == '6') {
      primaryRoleText = 'Planner';
    }
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
    getUserDetailsByUsername();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userPreferences = Provider.of<UserPref>(context);
    var provider = Provider.of<LocationProvider>(context, listen: true);
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
              color: const Color.fromARGB(255, 3, 47, 97),
              padding: const EdgeInsets.only(top: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  menuLogoLCP(),
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
                    leading: const Icon(Icons.computer),
                    title: const Text('General Foreman Dashboard'),
                    textColor: const Color.fromARGB(255, 7, 59, 120),
                    iconColor: const Color.fromARGB(255, 7, 59, 120),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const ContractorBottomNavigationPannel(),
                        ),
                      );
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
                    leading: const Icon(Icons.settings_applications_sharp),
                    title: const Text('Maintenance Report View'),
                    textColor: const Color.fromARGB(255, 7, 59, 120),
                    iconColor: const Color.fromARGB(255, 7, 59, 120),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              GfMaintenanceReportViewNew(year: ''),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.closed_caption_off),
                    title: const Text('IVM/Change Order'),
                    textColor: const Color.fromARGB(255, 7, 59, 120),
                    iconColor: const Color.fromARGB(255, 7, 59, 120),
                    onTap: () {
                      // Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (BuildContext context) =>
                      //         const ChangeOrderContractor()));
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              Inspection(year: ''),
                        ),
                      );
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

                  // ListTile(
                  //   leading: const Icon(
                  //     Icons.list_alt,
                  //   ),
                  //   title: const Text('Invoice Form'),
                  //   textColor: const Color.fromARGB(255, 7, 59, 120),
                  //   iconColor: const Color.fromARGB(255, 7, 59, 120),
                  //   onTap: () {
                  //     Navigator.of(context).push(MaterialPageRoute(
                  //         builder: (BuildContext context) =>
                  //             const InvoiceFormContractor()));
                  //   },
                  // ),
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
                  // ListTile(
                  //   leading: const Icon(
                  //     Icons.pin_invoke_outlined,
                  //   ),
                  //   title: const Text('Create Invoice'),
                  //   textColor: const Color.fromARGB(255, 7, 59, 120),
                  //   iconColor: const Color.fromARGB(255, 7, 59, 120),
                  //   onTap: () {
                  //     Navigator.of(context).push(MaterialPageRoute(
                  //         builder: (BuildContext context) =>
                  //             const CreateInvoiceContractor()));
                  //   },
                  // ),
                  // ListTile(
                  //     leading: const Icon(
                  //       Icons.list,
                  //     ),
                  //     title: const Text('Invoice List'),
                  //     textColor: const Color.fromARGB(255, 7, 59, 120),
                  //     iconColor: const Color.fromARGB(255, 7, 59, 120),
                  //     onTap: () {
                  //       Navigator.of(context).push(MaterialPageRoute(
                  //           builder: (BuildContext context) =>
                  //               const InvoiceListContrator()));
                  //     }),
                  // ListTile(
                  //     leading: const Icon(
                  //       Icons.map,
                  //     ),
                  //     title: const Text('IVM Offline Map'),
                  //     textColor: const Color.fromARGB(255, 7, 59, 120),
                  //     iconColor: const Color.fromARGB(255, 7, 59, 120),
                  //     onTap: () async {
                  //       String id = '';
                  //       final userPreferences1 =
                  //           Provider.of<UserPref>(context, listen: false);
                  //       UserModel data = await userPreferences1.getUser();
                  //       id = data.user!.id.toString();
                  //       // Navigator.push(
                  //       //   context,
                  //       //   MaterialPageRoute(
                  //       //     builder: (context) => MapViewPage(
                  //       //       url:
                  //       //           "https://lcpmapapi.ariespro.com/main/ivm_map_view/CIVM_Map/USRQWXH589Z/$id",
                  //       //     ),
                  //       //   ),
                  //       // );
                  //       await browser.open(
                  //           url: WebUri(
                  //               "https://lcpmapapi.ariespro.com/main/ivm_map_view/CIVM_Map/USRQWXH589Z/$id"),
                  //           //crew id in place of id in above line
                  //           settings: ChromeSafariBrowserSettings(
                  //               shareState:
                  //                   CustomTabsShareState.SHARE_STATE_OFF,
                  //               barCollapsingEnabled: true));
                  //     }),

                  // ListTile(
                  //     leading: const Icon(
                  //       Icons.map_outlined,
                  //     ),
                  //     title: const Text('Herbicide Offline Map'),
                  //     textColor: const Color.fromARGB(255, 7, 59, 120),
                  //     iconColor: const Color.fromARGB(255, 7, 59, 120),
                  //     onTap: () async {
                  //       String id = '';
                  //       final userPreferences1 =
                  //           Provider.of<UserPref>(context, listen: false);
                  //       UserModel data = await userPreferences1.getUser();
                  //       id = data.user!.id.toString();
                  //       //   Navigator.push(
                  //       //   context,
                  //       //   MaterialPageRoute(
                  //       //     builder: (context) => MapViewPage(
                  //       //       url:
                  //       //           "https://lcpmapapi.ariespro.com/main/mid_cycle/CIVM_Map/USRQWXH589Z/$id",
                  //       //     ),
                  //       //   ),
                  //       // );
                  //       await browser.open(
                  //           url: WebUri(
                  //               "https://lcpmapapi.ariespro.com/main/mid_cycle/CIVM_Map/USRQWXH589Z/$id"),
                  //           //crew id in place of id in above line
                  //           settings: ChromeSafariBrowserSettings(
                  //               shareState:
                  //                   CustomTabsShareState.SHARE_STATE_OFF,
                  //               barCollapsingEnabled: true));
                  //     }),

                  // ListTile(
                  //     leading: const Icon(
                  //       Icons.location_searching,
                  //     ),
                  //     title: const Text('Offline Maintenance Map'),
                  //     textColor: const Color.fromARGB(255, 7, 59, 120),
                  //     iconColor: const Color.fromARGB(255, 7, 59, 120),
                  //     onTap: () async {
                  //       String id = '';
                  //       final userPreferences1 =
                  //           Provider.of<UserPref>(context, listen: false);
                  //       UserModel data = await userPreferences1.getUser();
                  //       id = data.user!.id.toString();
                  //       //    Navigator.push(
                  //       //   context,
                  //       //   MaterialPageRoute(
                  //       //     builder: (context) => MapViewPage(
                  //       //       url:
                  //       //           "https://lcpmapapi.ariespro.com/main/change_order_view/CIVM_Map/USRQWXH589Z/$id",
                  //       //     ),
                  //       //   ),
                  //       // );
                  //       await browser.open(
                  //           url: WebUri(
                  //               "https://lcpmapapi.ariespro.com/main/change_order_view/CIVM_Map/USRQWXH589Z/$id"),
                  //           //crew id in place of id in above line
                  //           settings: ChromeSafariBrowserSettings(
                  //               shareState:
                  //                   CustomTabsShareState.SHARE_STATE_OFF,
                  //               barCollapsingEnabled: true));
                  //     }),
                  ListTile(
                    leading: Icon(Icons.location_on),
                    title: const Text('Live IVM System Map'),
                    textColor: const Color.fromARGB(255, 7, 59, 120),
                    iconColor: const Color.fromARGB(255, 7, 59, 120),
                    onTap: () {
                      provider.getLocation();
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const MapScreenLeafLat(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.add),
                    title: const Text('Add Crew Member'),
                    textColor: const Color.fromARGB(255, 7, 59, 120),
                    iconColor: const Color.fromARGB(255, 7, 59, 120),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  // ignore: unnecessary_null_comparison
                  (Constants.prefs
                              .getString('additionalUserType')
                              .toString()
                              .isNotEmpty &&
                          Constants.prefs
                                  .getString('additionalUserType')
                                  .toString() !=
                              'null')
                      ? ListTile(
                          leading: const Icon(Icons.refresh),
                          title: const Text('Switch Panel'),
                          textColor: const Color.fromARGB(255, 7, 59, 120),
                          iconColor: const Color.fromARGB(255, 7, 59, 120),
                          onTap: () {
                            _openLoginDialog(context);
                          },
                        )
                      : Container(),
                  ListTile(
                    leading: const Icon(Icons.logout),
                    title: const Text('Log Out'),
                    textColor: const Color.fromARGB(255, 7, 59, 120),
                    iconColor: const Color.fromARGB(255, 7, 59, 120),
                    onTap: () {
                      // // Constants.prefs.setBool("LoggedIn", false);
                      userPreferences.remove().then((value) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const LoginPage(),
                          ),
                        );
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
      'https://civm.ariespro.com/assets/clientuploads/${data.user!.profilePhoto}',
    );
    String imageUrl =
        'https://civm.ariespro.com/assets/clientuploads/${data.user!.profilePhoto}';
    _imagePath = imageUrl;
    setState(() {
      userName = '${data.user!.fName} ${data.user!.lName}';
    });
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
        String normalizedDate = date.replaceAll(
          RegExp(r'\s+'),
          ' ',
        ); // Remove extra spaces
        DateTime parsedDate = DateFormat(
          "MMM d yyyy h:mma",
        ).parse(normalizedDate);
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

  Future<void> _openLoginDialog(BuildContext context) async {
 // Show loader
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return const Center(child: CircularProgressIndicator());
      },
    );

    // Wait for API
    final bool isValid = await checkCurrentUserDrawer();

    if (!mounted) return;

    // Close loader
    Navigator.of(context, rootNavigator: true).pop();

    // API returned false
    if (!isValid) {
      Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const LoginPage()),
        (route) => false,
      );

      return;
    }

    // API returned true
    bool isLoading = false;


    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              titlePadding: const EdgeInsets.fromLTRB(24, 20, 12, 0),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Switch Panel',
                    style: TextStyle(
                      color: Color.fromARGB(255, 7, 59, 120),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.grey),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              content: SizedBox(
                width: 280,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (isLoading) ...[
                      const Padding(
                        padding: EdgeInsets.only(bottom: 20),
                        child: CircularProgressIndicator(),
                      ),
                      const Text(
                        "Switching panel...",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 20),
                    ],

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 45),
                        backgroundColor: const Color.fromARGB(255, 7, 59, 120),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: isLoading
                          ? null
                          : () async {
                              setDialogState(() {
                                isLoading = true;
                              });

                              bool success = await switchUser();

                              setDialogState(() {
                                isLoading = false;
                              });

                              if (success) {
                                Navigator.pop(context);

                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        PlannerBottomNavigationPannel(),
                                  ),
                                );
                              } else {
                                // Navigator.pop(context);
                                // showAccessDeniedDialog(this.context);
                                Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        const LoginPage(),
                                  ),
                                  (route) => false,
                                );
                              }
                            },
                      child: const Text(
                        "Work as Planner",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),

                    const SizedBox(height: 12),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 45),
                        backgroundColor: const Color.fromARGB(255, 7, 59, 120),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () async {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Work as General Foreman",
                        style: TextStyle(
                          color: Color.fromARGB(255, 151, 228, 248),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future<bool> switchUser() async {
    try {
      final userPreferences = Provider.of<UserPref>(context, listen: false);

      UserModel user = await userPreferences.getUser();

      final String id = user.user!.id.toString();

      final uri =
          "${AppUrl.baseUrl}login_user/switchUser"
          "?loginId=$id"
          "&switchTo=6";

      print('uriuri:: $uri');

      final response = await http.put(
        Uri.parse(uri),
        headers: {
          "Authorization": "Bearer ${user.token}",
          "Content-Type": "application/json",
        },
      );

      print("Switch User Status : ${response.statusCode}");
      print("Switch User Response : ${response.body}");

      if (response.statusCode == 200) {
        final SharedPreferences pref = await SharedPreferences.getInstance();

        await pref.setString('userType', '6');

        print('userType:: ${pref.getString('userType')}');

        return true;
      }

      // ============================================================
      // SWITCH FAILED - SHOW ACCESS DENIED DIALOG
      // ============================================================
      // if (response.statusCode == 400) {
      //   showAccessDeniedDialog(context);
      //   return false;
      // }

      // // Any other error
      // showAccessDeniedDialog(context);
      return false;
    } catch (e) {
      print("switchUser Error : $e");

      // showAccessDeniedDialog(context);

      return false;
    }
  }

  void showAccessDeniedDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.cancel, color: Colors.red, size: 80),

              const SizedBox(height: 12),

              const Text(
                'Switch Failed',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 7, 59, 120),
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'Access Denied!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.red,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: 100,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(dialogContext).pop();
                  },
                  child: const Text('OK'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<UserDetails?> getUserDetailsByUsername() async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    String email = data.user!.email.toString();
    var url = "${AppUrl.baseUrl}login_user/get_userDetails_by_username/$email";
    print('url: $url');
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          "Authorization": "Bearer ${data.token}",
          "Content-Type": "application/json",
        },
      );
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        String? userType = responseData["userDetails"]["userType"]?.toString();
        String? additionalUserType =
            responseData["userDetails"]["additionalUserType"]?.toString();
        final SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setString('userType', userType.toString());
        pref.setString('additionalUserType', additionalUserType.toString());
        print('additionalUserType:: $additionalUserType');
        return UserDetails.fromJson(responseData["userDetails"]);
      } else {
        print("Error : ${response.statusCode}");
        print(response.body);
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

 Future<bool> checkCurrentUserDrawer() async {
    print('planner authentication');

    try {
      final prefs = await SharedPreferences.getInstance();

      final fcmToken = prefs.getString('device_token_for_logOut');

      if (fcmToken == null || fcmToken.isEmpty) {
        print("FCM token not found in SharedPreferences");
        return false;
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

        if (responseData == true) {
          return true;
        }

        // API returned false
        if (responseData == false) {
          final userPreferences = Provider.of<UserPref>(context, listen: false);

          await userPreferences.remove();

          return false;
        }

        return false;
      }

      if (response.statusCode == 401) {
        print("Unauthorized - Bearer token is invalid or expired");
        return false;
      }

      print(
        "checkCurrentUser failed: "
        "${response.statusCode} - ${response.body}",
      );

      return false;
    } catch (e) {
      print("checkCurrentUser Error: $e");
      return false;
    }
  }

}

class ChartData {
  ChartData(this.x, this.y, this.color);
  final String x;
  final double y;
  final Color color;
}

// class _ChartDataSimpleColumnChart1 {
//   _ChartDataSimpleColumnChart1(this.x, this.y1,this.y2,this.y3);

//   final String x;
//   final double y1;
//    final String y2;
//     final String y3;
//   // final Color? color;
// }
class _ChartDataSimpleColumnChart1 {
  _ChartDataSimpleColumnChart1(this.x, this.y1);

  final String x;
  final double y1;
  // final Color? color;
}

//new
class ChartDataNew {
  final String month;
  final int miles;

  ChartDataNew(this.month, this.miles);
}

// ignore: must_be_immutable
class DashboardCard extends StatefulWidget {
  String cardTitle;
  String cardCount;
  dynamic cardIcon;
  Color? iconColor;
  Color? cardColor;

  DashboardCard({
    Key? key,
    required this.cardTitle,
    required this.cardCount,
    this.cardIcon,
    this.iconColor,
    this.cardColor,
  }) : super(key: key);

  @override
  State<DashboardCard> createState() => _DashboardCardState();
}

class _DashboardCardState extends State<DashboardCard> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.only(top: 8, bottom: 8, left: 8, right: 8),
      alignment: Alignment.center,
      width: size.width * 0.425,
      height: MediaQuery.of(context).size.height * 0.12,
      decoration: BoxDecoration(
        color: widget.cardColor,
        // shape: BoxShape.circle,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black,
            blurRadius: 5,
            offset: Offset(0.0, 2.0),
          ),
        ],
        // gradient:  LinearGradient(
        //   colors: [
        //      cardColor,
        //      cardColor
        //     //  Color.fromARGB(255, 255, 255, 255),
        //     //  Color.fromARGB(255, 255, 255, 255),
        //   ],
        // )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            widget.cardTitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            widget.cardCount,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
