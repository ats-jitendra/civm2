import 'dart:convert';

import 'package:CIVM/models/approve_civm_access_model.dart';
import 'package:CIVM/models/user_model.dart';
import 'package:CIVM/resources/app_url.dart';
import 'package:CIVM/screens/admin_pannel/row_maintenance_view/admin_add_supervisor.dart';
import 'package:CIVM/screens/login_page.dart';
import 'package:CIVM/utils/common_functions.dart';
import 'package:CIVM/utils/user_pref.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../data/response/status.dart';
import '../../../utils/custom_toast_snackbar_progressdialog.dart';
import '../../../view_model/approve_civm_view_model.dart';
import 'package:http/http.dart' as http;

class ApproveCIVMAccess extends StatefulWidget {
  const ApproveCIVMAccess({Key? key}) : super(key: key);

  @override
  State<ApproveCIVMAccess> createState() => _ApproveCIVMAccessState();
}

class _ApproveCIVMAccessState extends State<ApproveCIVMAccess> {
  // int _currentIndex = 0;
  // final List<Widget> _children = [
  //   RowMaintenancePlan(),
  //   // BottomNavigationHomePage(),
  //   // BottomNavigationAccountPage()
  // ];
  List<String> menu = [];

  DateTime now = DateTime.now();
  var formatter = DateFormat('yyyy-MM-dd');

  // ignore: prefer_typing_uninitialized_variables
  var selectedSubstation;
  int substationId = 0;

  final TextEditingController _input = TextEditingController();
  final TextEditingController _input2 = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _fName = TextEditingController();
  final TextEditingController _lName = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _emailSendRecipient = TextEditingController();
  final TextEditingController _subject = TextEditingController();
  final TextEditingController _message = TextEditingController();

  onTappedBar(int index) {
    setState(() {
      // _currentIndex = index;
    });
  }

  ApproveCIVMAccessViewModel approveCIVMAccessViewModel =
      ApproveCIVMAccessViewModel();

  late bool _isLoading;

  List<FindAllSupervisorList> originalSupervisorList = [];
  List<FindAllSupervisorList> filteredSupervisorList = [];

  @override
  void initState() {
    // approveCIVMAccessViewModel.fetchApproveCIVMAccessTabularListApi(
    //   context,
    //   '',
    //   '',
    // );
    // getOwnPermissions();
    super.initState();
     _initializeScreen();
    _loadApproveCIVMAccess();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // appBar: AppBar(
      //   iconTheme: const IconThemeData(color: Colors.white),
      //   title: const Text(
      //     'Approve CIVM Access',
      //     style: TextStyle(color: Colors.white),
      //   ),
      //   backgroundColor: const Color.fromARGB(255, 7, 59, 120),
      // ),
      //  drawer: DrawerManu(menu: menu),
      body: ChangeNotifierProvider<ApproveCIVMAccessViewModel>(
        create: (BuildContext context) => approveCIVMAccessViewModel,
        child: Consumer<ApproveCIVMAccessViewModel>(
          builder: (context, value, _) {
            switch (value.approveCIVMAccessTabularData.status) {
              case Status.LOADING:
                return const Center(child: CircularProgressIndicator());
              case Status.ERROR:
                return
                // CustomToastSnackBarProgressDialog.flushBarErrorMessage(
                //     value.approveCIVMAccessTabularData.message.toString(),
                //     context);
                Padding(
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

              case Status.COMPLETED:
                return RefreshIndicator(
                  onRefresh: () async {
                    _input.clear();
                    _input2.clear();
                    await approveCIVMAccessViewModel
                        .fetchApproveCIVMAccessTabularListApi(context, '', '');
                        _initializeScreen();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Column(
                      children: [
                        progressHeaderCivm(
                          "Add Supervisor",
                          onTap: () async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AdminAddSupervisor(),
                              ),
                            );
                          },
                        ),
                        // Align(
                        //   alignment: Alignment.centerRight,
                        //   child: Padding(
                        //     padding: const EdgeInsets.only(
                        //       left: 8.0,
                        //       right: 8.0,
                        //     ),
                        //     child: TextFormField(
                        //       onChanged: (value) => _filterData1(value),
                        //       //  key: formkey2,
                        //       controller: _input,
                        //       style: const TextStyle(
                        //         color: Color.fromARGB(255, 7, 59, 120),
                        //         fontSize: 16,
                        //       ),
                        //       obscureText: false,

                        //       //keyboardType: TextInputType.number,
                        //       decoration: const InputDecoration(
                        //         border: OutlineInputBorder(
                        //           // borderRadius:
                        //           //     BorderRadius.circular(25),
                        //         ),
                        //         enabledBorder: OutlineInputBorder(
                        //           borderSide: BorderSide(
                        //             color: Color.fromARGB(255, 7, 59, 120),
                        //           ),
                        //           // borderRadius:
                        //           //     BorderRadius.circular(25),
                        //         ),
                        //         hintText: 'Search your input...',
                        //         hintStyle: TextStyle(color: Colors.grey),
                        //       ),
                        //       validator: (value) {
                        //         if (value!.isEmpty) {
                        //           return "Please search your input";
                        //         } else {
                        //           return null;
                        //         }
                        //       },
                        //     ),
                        //   ),
                        // ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 16, 10, 8),
                          child: TextField(
                            controller: _input,
                            onChanged: (value) => _filterData1(value),
                            decoration: InputDecoration(
                              hintText: "Search your input...",
                              prefixIcon: const Icon(Icons.search),
                              suffixIcon: _input.text.isNotEmpty
                                  ? IconButton(
                                      icon: const Icon(Icons.clear),
                                      onPressed: () {
                                        _input.clear();
                                        _filterData1('');
                                      },
                                    )
                                  : null,
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            // physics: const NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            // shrinkWrap: true,
                            itemCount: filteredSupervisorList
                                .length,
                            itemBuilder: (context, index) {
                              return Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      width:
                                          MediaQuery.of(context).size.width *
                                          0.28,
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
                                                            alignment: Alignment
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
                                                            alignment: Alignment
                                                                .topLeft,
                                                            child: Text(
                                                              (filteredSupervisorList[index]
                                                                              .id ==
                                                                          null ||
                                                                      filteredSupervisorList[index]
                                                                              .id
                                                                              .toString() ==
                                                                          'null')
                                                                  ? ''
                                                                  : filteredSupervisorList[index]
                                                                        .id
                                                                        .toString(),
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: const TextStyle(
                                                                fontSize: 12,
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
                                                            alignment: Alignment
                                                                .topLeft,
                                                            child: Text(
                                                              "NAME: ",
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
                                                            alignment: Alignment
                                                                .topLeft,
                                                            child: Text(
                                                              (filteredSupervisorList[index].fName ==
                                                                              null &&
                                                                          filteredSupervisorList[index].lName ==
                                                                              null ||
                                                                      filteredSupervisorList[index].fName.toString() ==
                                                                              'null' &&
                                                                          filteredSupervisorList[index].lName.toString() ==
                                                                              'null' ||
                                                                      filteredSupervisorList[index]
                                                                              .fName!
                                                                              .isEmpty &&
                                                                          filteredSupervisorList[index]
                                                                              .lName!
                                                                              .isEmpty)
                                                                  ? ''
                                                                  : ('${filteredSupervisorList[index].fName.toString()} ${filteredSupervisorList[index].lName.toString()}'),
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
                                                            alignment: Alignment
                                                                .topLeft,
                                                            child: Text(
                                                              "USER NAME: ",
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
                                                            alignment: Alignment
                                                                .topLeft,
                                                            child: Text(
                                                              (filteredSupervisorList[index]
                                                                              .fName ==
                                                                          null ||
                                                                      filteredSupervisorList[index]
                                                                              .fName
                                                                              .toString() ==
                                                                          'null' ||
                                                                      filteredSupervisorList[index]
                                                                          .fName!
                                                                          .isEmpty)
                                                                  ? ''
                                                                  : filteredSupervisorList[index]
                                                                        .fName
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
                                                            alignment: Alignment
                                                                .topLeft,
                                                            child: Text(
                                                              "EMAIL: ",
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
                                                            alignment: Alignment
                                                                .topLeft,
                                                            child: Text(
                                                              (filteredSupervisorList[index]
                                                                              .email ==
                                                                          null ||
                                                                      filteredSupervisorList[index]
                                                                              .email
                                                                              .toString() ==
                                                                          'null' ||
                                                                      filteredSupervisorList[index]
                                                                          .email!
                                                                          .isEmpty)
                                                                  ? ''
                                                                  : filteredSupervisorList[index]
                                                                        .email
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
                                                            alignment: Alignment
                                                                .topLeft,
                                                            child: Text(
                                                              "ROLE: ",
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
                                                            alignment: Alignment
                                                                .topLeft,
                                                            child: Text(
                                                              (filteredSupervisorList[index]
                                                                              .role ==
                                                                          null ||
                                                                      filteredSupervisorList[index]
                                                                              .role
                                                                              .toString() ==
                                                                          'null' ||
                                                                      filteredSupervisorList[index]
                                                                          .role!
                                                                          .isEmpty)
                                                                  ? ''
                                                                  : filteredSupervisorList[index]
                                                                        .role
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
                                                            alignment: Alignment
                                                                .topLeft,
                                                            child: Text(
                                                              "ADMIN: ",
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
                                                            alignment: Alignment
                                                                .topLeft,
                                                            child: Text(
                                                              (filteredSupervisorList[index]
                                                                              .adminId ==
                                                                          null ||
                                                                      filteredSupervisorList[index]
                                                                              .adminId
                                                                              .toString() ==
                                                                          'null' ||
                                                                      filteredSupervisorList[index]
                                                                          .adminId!
                                                                          .isEmpty)
                                                                  ? ''
                                                                  : filteredSupervisorList[index]
                                                                        .adminId
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
                                                      child: Row(
                                                        children: [
                                                          const Align(
                                                            alignment: Alignment
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
                                                          Align(
                                                            alignment: Alignment
                                                                .topLeft,
                                                            child: InkWell(
                                                              onTap: () {
                                                                denySupervisor(
                                                                  (filteredSupervisorList[index]
                                                                              .status!
                                                                              .isNotEmpty &&
                                                                         filteredSupervisorList[index].status!.toString() ==
                                                                              'PENDING')
                                                                      ? 'ACCEPT'
                                                                      : 'REJECT',
                                                                  index,
                                                                  filteredSupervisorList[index]
                                                                      .id
                                                                      .toString(),
                                                                  filteredSupervisorList[index]
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
                                                                      (filteredSupervisorList[index]
                                                                              .status!
                                                                              .toString()
                                                                              .isNotEmpty &&
                                                                          filteredSupervisorList[index].status!.toString() ==
                                                                              'PENDING')
                                                                      ? [
                                                                          const BoxShadow(
                                                                            color: Color.fromARGB(
                                                                              255,
                                                                              2,
                                                                              43,
                                                                              113,
                                                                            ),
                                                                            blurRadius:
                                                                                5,
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
                                                                            blurRadius:
                                                                                5,
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
                                                                        (filteredSupervisorList[index].status!.toString().isNotEmpty &&
                                                                            filteredSupervisorList[index].status.toString() ==
                                                                                'ACTIVE')
                                                                        ? (filteredSupervisorList[index].status!.toString().isNotEmpty &&
                                                                                 filteredSupervisorList[index].status.toString() ==
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
                                                                          (filteredSupervisorList[index].status!.toString().isNotEmpty &&
                                                                                  filteredSupervisorList[index].status!.toString() ==
                                                                                      'PENDING')
                                                                              ? 'ACCEPT'
                                                                              : 'REJECT',
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          style: const TextStyle(
                                                                            color:
                                                                                Colors.white,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            fontSize:
                                                                                15,
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
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                child: Row(
                                                  children: [
                                                    const Align(
                                                      alignment:
                                                          Alignment.topLeft,
                                                      child: Text(
                                                        "SEND EMAIL: ",
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Color.fromARGB(
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
                                                      child: InkWell(
                                                        onTap: () {
                                                          String
                                                          email = filteredSupervisorList[index]
                                                              .email!
                                                              .toString();
                                                          onPressedSendMail(
                                                            email,
                                                          );
                                                        },
                                                        child: const Icon(
                                                          Icons.mail,
                                                          color: Colors.red,
                                                          size: 40,
                                                        ),
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

  void _filterData1(String query) {
  final searchText = query.trim().toLowerCase();

  if (searchText.isEmpty) {
    filteredSupervisorList =
        List<FindAllSupervisorList>.from(originalSupervisorList);
  } else {
    filteredSupervisorList = originalSupervisorList.where((item) {
      return (item.adminId ?? '').toLowerCase().contains(searchText) ||
          (item.fName ?? '').toLowerCase().contains(searchText) ||
          (item.lName ?? '').toLowerCase().contains(searchText) ||
          (item.status ?? '').toLowerCase().contains(searchText) ||
          (item.role ?? '').toLowerCase().contains(searchText) ||
          (item.userName ?? '').toLowerCase().contains(searchText) ||
          (item.email ?? '').toLowerCase().contains(searchText);
    }).toList();
  }

  setState(() {});
}
  
  Future denySupervisor(var data, int ind, String userName, String status) =>
      showDialog(
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
                        if (data == 'REJECT') {
                          filteredSupervisorList[ind]
                                  .status =
                              'PENDING';
                        } else {
                          filteredSupervisorList[ind]
                                  .status =
                              'ACTIVE';
                        }
                        approveCIVMAccessViewModel
                            .fetchApproveCIVMUpdatePutListApi(
                              context,
                              (data == 'REJECT') ? 'PENDING' : 'ACTIVE',
                              userName,
                            );
                        Navigator.of(context).pop();
                        _loadApproveCIVMAccess();
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

  Future denyContractor(var data, int ind, String userName, String status) =>
      showDialog(
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
                        if (data == 'REJECT') {
                          approveCIVMAccessViewModel
                                  .approveCIVMAccessTabularData
                                  .data!
                                  .findAllContractorList![ind]
                                  .status =
                              'PENDING';
                        } else {
                          approveCIVMAccessViewModel
                                  .approveCIVMAccessTabularData
                                  .data!
                                  .findAllContractorList![ind]
                                  .status =
                              'ACTIVE';
                        }
                        approveCIVMAccessViewModel
                            .fetchApproveCIVMUpdatePutListApi(
                              context,
                              (data == 'REJECT') ? 'PENDING' : 'ACTIVE',
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

  Future<void> fetchDataAndOpenMethod(
    String id,
    String userName,
    String fName,
  ) async {
    try {
      // CustomToastSnackBarProgressDialog.showLoaderDialog(context);
      await approveCIVMAccessViewModel
          .fetchApproveCIVMAccessTabularListApi(context, id, id)
          .then((value) async {
            await Future.delayed(const Duration(seconds: 5), () {
              setState(() {
                _isLoading = false;
              });
            });
            _isLoading
                ? CustomToastSnackBarProgressDialog.showLoaderDialog(context)
                : onPressedEdit(id, userName, fName);
          });
    } catch (error) {
      print("Error: $error");
    }
  }

  setDataInEditDailog() {
    _email.text =
        (approveCIVMAccessViewModel
                    .approveCIVMAccessTabularData
                    .data!
                    .loginData!
                    .email ==
                null ||
            approveCIVMAccessViewModel
                    .approveCIVMAccessTabularData
                    .data!
                    .loginData!
                    .email
                    .toString() ==
                'null' ||
            approveCIVMAccessViewModel
                .approveCIVMAccessTabularData
                .data!
                .loginData!
                .email
                .toString()
                .isEmpty)
        ? ''
        : approveCIVMAccessViewModel
              .approveCIVMAccessTabularData
              .data!
              .loginData!
              .email
              .toString();

    _fName.text =
        (approveCIVMAccessViewModel
                    .approveCIVMAccessTabularData
                    .data!
                    .loginData!
                    .fName ==
                null ||
            approveCIVMAccessViewModel
                    .approveCIVMAccessTabularData
                    .data!
                    .loginData!
                    .fName
                    .toString() ==
                'null' ||
            approveCIVMAccessViewModel
                .approveCIVMAccessTabularData
                .data!
                .loginData!
                .fName
                .toString()
                .isEmpty)
        ? ''
        : approveCIVMAccessViewModel
              .approveCIVMAccessTabularData
              .data!
              .loginData!
              .fName
              .toString();

    _lName.text =
        (approveCIVMAccessViewModel
                    .approveCIVMAccessTabularData
                    .data!
                    .loginData!
                    .lName ==
                null ||
            approveCIVMAccessViewModel
                    .approveCIVMAccessTabularData
                    .data!
                    .loginData!
                    .lName
                    .toString() ==
                'null' ||
            approveCIVMAccessViewModel
                .approveCIVMAccessTabularData
                .data!
                .loginData!
                .lName
                .toString()
                .isEmpty)
        ? ''
        : approveCIVMAccessViewModel
              .approveCIVMAccessTabularData
              .data!
              .loginData!
              .lName
              .toString();

    _password.text =
        (approveCIVMAccessViewModel
                    .approveCIVMAccessTabularData
                    .data!
                    .loginData!
                    .password ==
                null ||
            approveCIVMAccessViewModel
                    .approveCIVMAccessTabularData
                    .data!
                    .loginData!
                    .password
                    .toString() ==
                'null' ||
            approveCIVMAccessViewModel
                .approveCIVMAccessTabularData
                .data!
                .loginData!
                .password
                .toString()
                .isEmpty)
        ? ''
        : approveCIVMAccessViewModel
              .approveCIVMAccessTabularData
              .data!
              .loginData!
              .password
              .toString();
  }

  onPressedEdit(String id, String userName, String fName) {
    setDataInEditDailog();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: SingleChildScrollView(
          child: Column(
            children: [
              const Text(
                'CONTACT DETAILS',
                style: TextStyle(
                  color: Color.fromARGB(255, 7, 59, 120),
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
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
                          "Assign To ",
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
                          value: selectedSubstation,
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
                          items: approveCIVMAccessViewModel
                              .approveCIVMAccessTabularData
                              .data!
                              .getAllAssignToContractorList!
                              .map((e) {
                                return DropdownMenuItem(
                                  value: e.id.toString(),
                                  // e.getIdAndSubstationByCountId![0].subStation.toString(),
                                  child: Text(e.name.toString()),
                                );
                              })
                              .toList(),
                          onChanged: (val) {
                            substationId = int.parse(val!);
                            setState(() {
                              selectedSubstation = val;
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
                            if (value.toString() == '') {
                              return "Please enter email";
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
                          "First Name",
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
                          controller: _fName,
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
                            hintText: 'First Name',
                            // prefixIcon: const Icon(
                            //   Icons.person,
                            //   color: Color.fromARGB(255, 7, 59, 120),
                            // ),
                          ),

                          validator: (value) {
                            if (value.toString() == '') {
                              return "Please enter email";
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
                          "Last Name",
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
                          controller: _lName,
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
                            hintText: 'Last Name',
                            // prefixIcon: const Icon(
                            //   Icons.person,
                            //   color: Color.fromARGB(255, 7, 59, 120),
                            // ),
                          ),

                          validator: (value) {
                            if (value.toString() == '') {
                              return "Please enter email";
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
                          "Password",
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
                          controller: _password,
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
                            hintText: 'Password',
                            // prefixIcon: const Icon(
                            //   Icons.person,
                            //   color: Color.fromARGB(255, 7, 59, 120),
                            // ),
                          ),

                          validator: (value) {
                            if (value.toString() == '') {
                              return "Please enter email";
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
            ],
          ),
        ),
        actions: [
          Row(
            children: [
              Container(
                margin: const EdgeInsets.only(
                  left: 6,
                  right: 6,
                  top: 6.0,
                  bottom: 10,
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(left: 10, bottom: 10.0),
                    // padding: const EdgeInsets.all(8),
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width * 0.2,
                    height: 40,
                    decoration: const BoxDecoration(
                      // shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(255, 131, 11, 2),
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
                              "Close",
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
                  top: 6.0,
                  bottom: 10,
                ),
                child: InkWell(
                  onTap: () {
                    print("object");
                    Map mappedData = {
                      "id": approveCIVMAccessViewModel
                          .approveCIVMAccessTabularData
                          .data!
                          .loginData!
                          .id
                          .toString(),
                      "userName": approveCIVMAccessViewModel
                          .approveCIVMAccessTabularData
                          .data!
                          .loginData!
                          .userName
                          .toString(),
                      "password": _password.text.toString(),
                      "fName": _fName.text.toString(),
                      "lName": _lName.text.toString(),
                      "email": _email.text.toString(),
                    };

                    print('mappedData');
                    print(mappedData);

                    approveCIVMAccessViewModel.fetchApproveCIVMSubmitListApi1(
                      context,
                      mappedData,
                    );

                    secondApi(id, fName);

                    // Future.delayed(const Duration(seconds: 2));
                    // Navigator.pop(context);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(left: 10, bottom: 10.0),
                    // padding: const EdgeInsets.all(8),
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width * 0.37,
                    height: 40,
                    decoration: const BoxDecoration(
                      // shape: BoxShape.circle,
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
                    child: const Row(
                      children: [
                        Expanded(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Save Changes",
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
      ),
    );
  }

  onPressedSendMail(String email) {
    _emailSendRecipient.text = email;
    _subject.text = 'Reminder';
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 10.0),
                // padding: const EdgeInsets.all(8),
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width * 0.7,
                height: 40,
                decoration: const BoxDecoration(
                  // shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(255, 116, 70, 1),
                      blurRadius: 5,
                      offset: Offset(2.0, 5.0),
                    ),
                  ],
                  color: Colors.black,
                  gradient: LinearGradient(
                    colors: [Colors.orange, Colors.orange],
                  ),
                ),
                child: const Row(
                  children: [
                    Expanded(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Compose Email",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
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
                          "To:",
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
                          controller: _emailSendRecipient,
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
                            if (value.toString() == '') {
                              return "Please enter email";
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
                          "Subject:",
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
                          controller: _subject,
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
                            hintText: 'Subject',
                            // prefixIcon: const Icon(
                            //   Icons.person,
                            //   color: Color.fromARGB(255, 7, 59, 120),
                            // ),
                          ),

                          validator: (value) {
                            if (value.toString() == '') {
                              return "Please enter subject";
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
                          "Message:",
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
                          controller: _message,
                          style: const TextStyle(
                            color: Color.fromARGB(255, 7, 59, 120),
                            fontSize: 16,
                          ),
                          obscureText: false,
                          minLines: 4,
                          maxLines: 10,
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
                            hintText: 'Type your message here',
                            // prefixIcon: const Icon(
                            //   Icons.person,
                            //   color: Color.fromARGB(255, 7, 59, 120),
                            // ),
                          ),

                          validator: (value) {
                            if (value.toString() == '') {
                              return "Please enter message";
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
            ],
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(
              left: 6,
              right: 6,
              top: 6.0,
              bottom: 10,
            ),
            child: InkWell(
              onTap: () {
                List<String> list = [
                  // 'jitendra.kushwaha@ariespro.com',
                  'preetika.patel@ariespro.com',
                ];
                _sendMail(
                  list,
                  _subject.text.toString(),
                  _message.text.toString(),
                  _emailSendRecipient.text.toString(),
                );
              },
              child: Center(
                child: Container(
                  margin: const EdgeInsets.only(left: 10, bottom: 10.0),
                  // padding: const EdgeInsets.all(8),
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width * 0.37,
                  height: 40,
                  decoration: const BoxDecoration(
                    // shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(255, 0, 79, 215),
                        blurRadius: 5,
                        offset: Offset(2.0, 5.0),
                      ),
                    ],
                    color: Colors.black,
                    gradient: LinearGradient(
                      colors: [Colors.blue, Colors.blue],
                    ),
                  ),
                  child: const Row(
                    children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Send Email",
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
          ),
        ],
      ),
    );
  }

  Future<void> _sendMail(
    List<String> recipientsList,
    String subject,
    String content,
    String email,
  ) async {
    String username = 'ats.ariespro@gmail.com';
    String password = 'ahbfhcshjujvkgge';

    final smtpServer = gmail(username, password);

    print('SMTP Host: mail.ariespro.com');
    print('Username: $username');
    print('Recipient: $email');

    final message = Message()
      ..from = Address(username, 'CIVM')
      ..recipients.add(email)
      ..subject = subject
      ..html = "<h4>Hi,</h4><p>$content</p>";

    try {
      final sendReport = await send(message, smtpServer);

      print('Message sent: $sendReport');

      CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
        'Email Sent',
        context,
      );
      await Future.delayed(const Duration(seconds: 2));

      if (context.mounted) {
        Navigator.pop(context);
        Navigator.pop(context);
      }
    } on MailerException catch (e) {
      print('Message not sent.');

      for (var p in e.problems) {
        print('Problem: ${p.code}');
        print('Message: ${p.msg}');
      }

      CustomToastSnackBarProgressDialog.flushBarErrorMessage(
        'Email Not Sent',
        context,
      );
    } catch (e, stackTrace) {
      print('Unexpected error: $e');
      print(stackTrace);

      CustomToastSnackBarProgressDialog.flushBarErrorMessage(
        'Email Not Sent',
        context,
      );
    }
  }

  void secondApi(String id, String fName) {
    Map mappedData2 = {
      "name": fName,
      "supervisorId": substationId,
      "loginId": id,
    };
    print('mappedData2');
    print(mappedData2);
    approveCIVMAccessViewModel.fetchApproveCIVMSubmitListApi2(
      context,
      mappedData2,
    );
    thirdApi();
  }

  void thirdApi() {
    approveCIVMAccessViewModel.fetchApproveCIVMSubmitListApi3(
      context,
      approveCIVMAccessViewModel
          .approveCIVMAccessTabularData
          .data!
          .contractorMasterDataList![0]
          .contractorMasterData!
          .supervisorId
          .toString(),
      approveCIVMAccessViewModel
          .approveCIVMAccessTabularData
          .data!
          .contractorMasterDataList![0]
          .contractorMasterData!
          .loginId
          .toString(),
    );
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

  Future<void> _loadApproveCIVMAccess() async {
  print("========== LOAD SUPERVISOR START ==========");

  await approveCIVMAccessViewModel
      .fetchApproveCIVMAccessTabularListApi(
    context,
    '',
    '',
  );

  if (!mounted) return;

  final apiList = approveCIVMAccessViewModel
          .approveCIVMAccessTabularData
          .data
          ?.findAllSupervisorList ??
      [];

  print("STATUS: ${approveCIVMAccessViewModel.approveCIVMAccessTabularData.status}");
  print("SUPERVISOR COUNT: ${apiList.length}");

  originalSupervisorList =
      List<FindAllSupervisorList>.from(apiList);

  filteredSupervisorList =
      List<FindAllSupervisorList>.from(apiList);

  print("ORIGINAL COUNT: ${originalSupervisorList.length}");
  print("FILTERED COUNT: ${filteredSupervisorList.length}");

  setState(() {});

  print("========== LOAD SUPERVISOR END ==========");
  _input.clear();
}

}
