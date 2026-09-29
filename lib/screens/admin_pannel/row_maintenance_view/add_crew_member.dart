import 'package:CIVM/models/add_crew_member_model.dart';
import 'package:CIVM/models/user_model.dart';
import 'package:CIVM/resources/app_url.dart';
import 'package:CIVM/screens/login_page.dart';
import 'package:CIVM/utils/common_functions.dart';
import 'package:CIVM/utils/custom_toast_snackbar_progressdialog.dart';
import 'package:CIVM/utils/user_pref.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../data/response/status.dart';
import '../../../view_model/add_crew_member_view_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AddCrewMember extends StatefulWidget {
  const AddCrewMember({Key? key}) : super(key: key);

  @override
  State<AddCrewMember> createState() => _AddCrewMemberState();
}

class _AddCrewMemberState extends State<AddCrewMember> {
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

  List<GetaAllCewMemberTableDatas> originalCrewMemberList = [];
  List<GetaAllCewMemberTableDatas> filteredCrewMemberList = [];

  @override
  void initState() {
    super.initState();
    _loadCrewMembers();
    _initializeScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

              case Status.COMPLETED:
                return RefreshIndicator(
                  onRefresh: () async {
                    _input.clear();

                    await addCrewMemberViewModel
                        .fetchAddCrewMemberTabularListApi(context);

                    originalCrewMemberList =
                        List<GetaAllCewMemberTableDatas>.from(
                          addCrewMemberViewModel
                              .addCrewMemberTabularData
                              .data!
                              .getaAllCewMemberTableDatas!,
                        );

                    if (mounted) {
                      setState(() {});
                    }

                    _initializeScreen();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Column(
                      children: [
                        progressHeaderCivm(
                          "Add Crew Member",
                          onTap: () {
                            _initializeScreen();
                            openDailogAddCrewMember();
                          },
                        ),

                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 16, 10, 8),
                          child: TextField(
                            controller: _input,
                            onChanged: (value) => _filterData(value),
                            decoration: InputDecoration(
                              hintText: "Search your input...",
                              prefixIcon: const Icon(Icons.search),
                              suffixIcon: _input.text.isNotEmpty
                                  ? IconButton(
                                      icon: const Icon(Icons.clear),
                                      onPressed: () {
                                        _input.clear();
                                        _filterData('');
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
                          child: SingleChildScrollView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: filteredCrewMemberList.length,
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
                                                                (filteredCrewMemberList[index].id ==
                                                                            null ||
                                                                        filteredCrewMemberList[index].id
                                                                                .toString() ==
                                                                            'null')
                                                                    ? ''
                                                                    : filteredCrewMemberList[index]
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
                                                                (filteredCrewMemberList[index].name ==
                                                                            null ||
                                                                        filteredCrewMemberList[index].name
                                                                                .toString() ==
                                                                            'null')
                                                                    ? ''
                                                                    : filteredCrewMemberList[index]
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
                                                                (filteredCrewMemberList[index].contractor ==
                                                                            null ||
                                                                        filteredCrewMemberList[index].contractor
                                                                                .toString() ==
                                                                            'null')
                                                                    ? ''
                                                                    : filteredCrewMemberList[index]
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
                                                                (filteredCrewMemberList[index].supervisor ==
                                                                            null ||
                                                                        filteredCrewMemberList[index].supervisor
                                                                                .toString() ==
                                                                            'null')
                                                                    ? ''
                                                                    : filteredCrewMemberList[index]
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
                                                          (filteredCrewMemberList[index]
                                                                          .status ==
                                                                      null ||
                                                                  filteredCrewMemberList[index]
                                                                          .status
                                                                          .toString() ==
                                                                      'null')
                                                              ? ''
                                                              : filteredCrewMemberList[index]
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
                                                          (filteredCrewMemberList[index]
                                                                          .crewType ==
                                                                      null ||
                                                                  filteredCrewMemberList[index]
                                                                          .crewType
                                                                          .toString() ==
                                                                      'null')
                                                              ? "Not Assigned"
                                                              : filteredCrewMemberList[index]
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

                                                            Align(
                                                              alignment:
                                                                  Alignment
                                                                      .topLeft,
                                                              child: InkWell(
                                                                onTap: () {
                                                                  deny(
                                                                    (filteredCrewMemberList[index].status!.isNotEmpty &&
                                                                            filteredCrewMemberList[index].status!.toString() ==
                                                                                'PENDING')
                                                                        ? 'ALLOW'
                                                                        : 'DENY',
                                                                    index,
                                                                    filteredCrewMemberList[index]
                                                                        .id
                                                                        .toString(),
                                                                    filteredCrewMemberList[index]
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
                                                                        (filteredCrewMemberList[index].status!.toString().isNotEmpty &&
                                                                            filteredCrewMemberList[index].status!.toString() ==
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
                                                                          (filteredCrewMemberList[index].status!.toString().isNotEmpty &&
                                                                              filteredCrewMemberList[index].status.toString() ==
                                                                                  'ACTIVE')
                                                                          ? (filteredCrewMemberList[index].status!.toString().isNotEmpty &&
                                                                                    filteredCrewMemberList[index].status.toString() ==
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
                                                                            (filteredCrewMemberList[index].status!.toString().isNotEmpty &&
                                                                                    filteredCrewMemberList[index].status!.toString() ==
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
                                                              width: 5,
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
                                                                      (filteredCrewMemberList[index].crewType ==
                                                                              null ||
                                                                          filteredCrewMemberList[index].crewType
                                                                                  .toString() ==
                                                                              'null')
                                                                      ? ''
                                                                      : filteredCrewMemberList[index]
                                                                            .crewType
                                                                            .toString();
                                                                  openDailogUpdateCrewType(
                                                                    crewTypeValue,
                                                                    filteredCrewMemberList[index]
                                                                        .id
                                                                        .toString(),
                                                                    filteredCrewMemberList[index]
                                                                        .fName
                                                                        .toString(),
                                                                    filteredCrewMemberList[index]
                                                                        .lName
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
                                                                            'EDIT',
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

  void _filterData(String query) {
    final searchText = query.trim().toLowerCase();

    if (searchText.isEmpty) {
      filteredCrewMemberList = List.from(originalCrewMemberList);
    } else {
      filteredCrewMemberList = originalCrewMemberList.where((item) {
        return item.status.toString().toLowerCase().contains(searchText) ||
            item.name.toString().toLowerCase().contains(searchText) ||
            item.contractor.toString().toLowerCase().contains(searchText) ||
            item.supervisor.toString().toLowerCase().contains(searchText) ||
            item.id.toString().toLowerCase().contains(searchText);
      }).toList();
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
                      //  (_password.text.toString() == 'null' ||
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
    String fName,
    String lName,
  ) {
    final TextEditingController fNameController = TextEditingController(
      text: fName,
    );
    final TextEditingController lNameController = TextEditingController(
      text: lName,
    );
    return showDialog(
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
                    "Edit Crew",
                    style: TextStyle(color: Color.fromARGB(255, 7, 59, 120)),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: SizedBox(
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
                      Column(
                        children: [
                          TextFormField(
                            controller: fNameController,
                            textCapitalization: TextCapitalization.words,
                            decoration: InputDecoration(
                              labelText: 'First Name',
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              hintText: 'Enter first name',
                              prefixIcon: const Icon(
                                Icons.person_outline,
                                color: Color.fromARGB(255, 7, 59, 120),
                              ),
                              filled: true,
                              fillColor: const Color(0xffF5F7FA),
                              contentPadding: const EdgeInsets.only(
                                left: 14,
                                right: 14,
                                top: 18,
                                bottom: 14,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Colors.grey.shade300,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Colors.grey.shade300,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 7, 59, 120),
                                  width: 2,
                                ),
                              ),
                            ),
                            style: const TextStyle(
                              fontSize: 15,
                              color: Color.fromARGB(255, 7, 59, 120),
                              fontWeight: FontWeight.w500,
                            ),
                          ),

                          const SizedBox(height: 10),

                          TextFormField(
                            controller: lNameController,
                            textCapitalization: TextCapitalization.words,
                            decoration: InputDecoration(
                              labelText: 'Last Name',
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              hintText: 'Enter last name',
                              prefixIcon: const Icon(
                                Icons.person_outline,
                                color: Color.fromARGB(255, 7, 59, 120),
                              ),
                              filled: true,
                              fillColor: const Color(0xffF5F7FA),
                              contentPadding: const EdgeInsets.only(
                                left: 14,
                                right: 14,
                                top: 18,
                                bottom: 14,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Colors.grey.shade300,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Colors.grey.shade300,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 7, 59, 120),
                                  width: 2,
                                ),
                              ),
                            ),
                            style: const TextStyle(
                              fontSize: 15,
                              color: Color.fromARGB(255, 7, 59, 120),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
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
                                                selectedUpdateCrewTypes
                                                    .contains("ROADSIDE SPRAY")
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
                                                selectedUpdateCrewTypes.add(
                                                  type,
                                                );
                                              }
                                            } else {
                                              selectedUpdateCrewTypes.remove(
                                                type,
                                              );
                                            }
                                          }
                                        });

                                        print(
                                          selectedUpdateCrewTypes.join(","),
                                        );
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
                            fNameController.text.toString(),
                            lNameController.text.toString(),
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
  }

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
                      filteredCrewMemberList[ind].status = 'PENDING';
                    } else {
                      filteredCrewMemberList[ind].status = 'ACTIVE';
                    }
                    addCrewMemberViewModel.fetchApproveCIVMUpdatePutListApi(
                      context,
                      (data == 'DENY') ? 'PENDING' : 'ACTIVE',
                      userName,
                    );
                    Navigator.of(context).pop();
                    _loadCrewMembers();
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
          originalCrewMemberList = List.from(filteredCrewMemberList);
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
    String fName,
    String lName,
  ) async {
    try {
      final userPreferences = Provider.of<UserPref>(context, listen: false);
      UserModel data = await userPreferences.getUser();

      var url =
          '${AppUrl.baseUrl}login_user/editCrewType?type=$crewType&id=$id&fName=$fName&lName=$lName';

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
        _input.clear();

        print('updated success');

        if (context.mounted) {
          // Future.delayed(const Duration(seconds: 2), () {
          //   if (context.mounted) {
          //     Navigator.of(context, rootNavigator: true).pop();
          //   }
          // });
          Navigator.of(context, rootNavigator: true).pop();
          _loadCrewMembers();
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

  Future<void> _loadCrewMembers() async {
    print("========== LOAD CREW START ==========");

    await addCrewMemberViewModel.fetchAddCrewMemberTabularListApi(context);

    print("========== API CALL FINISHED ==========");

    if (!mounted) {
      print("Widget is NOT mounted");
      return;
    }

    print("STATUS: ${addCrewMemberViewModel.addCrewMemberTabularData.status}");

    print("DATA: ${addCrewMemberViewModel.addCrewMemberTabularData.data}");

    print(
      "CREW LIST: ${addCrewMemberViewModel.addCrewMemberTabularData.data?.getaAllCewMemberTableDatas}",
    );

    print(
      "CREW COUNT: ${addCrewMemberViewModel.addCrewMemberTabularData.data?.getaAllCewMemberTableDatas?.length}",
    );

    final apiList =
        addCrewMemberViewModel
            .addCrewMemberTabularData
            .data
            ?.getaAllCewMemberTableDatas ??
        [];

    originalCrewMemberList = List<GetaAllCewMemberTableDatas>.from(apiList);

    filteredCrewMemberList = List<GetaAllCewMemberTableDatas>.from(apiList);

    print("ORIGINAL COUNT: ${originalCrewMemberList.length}");
    print("FILTERED COUNT: ${filteredCrewMemberList.length}");

    setState(() {});

    print("========== LOAD CREW END ==========");
    _input.clear();
  }
}
