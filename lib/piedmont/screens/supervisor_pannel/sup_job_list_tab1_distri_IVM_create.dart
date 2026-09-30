import 'dart:convert';
import 'dart:io';
import 'package:CIVM/piedmont/resources/app_colors.dart';
import 'package:CIVM/piedmont/resources/app_url.dart';
import 'package:CIVM/piedmont/screens/supervisor_pannel/supervisor_add_new_row_table.dart';
import 'package:CIVM/piedmont/utils/common_functions.dart';
import 'package:CIVM/utils/user_pref.dart';
import 'package:CIVM/models/user_model.dart';
import 'package:camera/camera.dart';
// import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:CIVM/piedmont/utils/custom_toast_snackbar_progressdialog.dart';

import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:file_selector/file_selector.dart';

// ignore: must_be_immutable
class SupJobListDistriIVMCreate extends StatefulWidget {
  SupJobListDistriIVMCreate({
    Key? key,
  }) : super(key: key);

  @override
  State<SupJobListDistriIVMCreate> createState() =>
      _SupJobListDistriIVMCreateState();
}

class _SupJobListDistriIVMCreateState extends State<SupJobListDistriIVMCreate> {
  List<String> menu = [];

  List<Map<String, dynamic>> listOfColumns = [];
  List<Map<String, dynamic>> listOfColumns1 = [];
  DateTime currentDate = DateTime.now();
  var result = [];

  int feederId = 0;
  int substationId = 0;
  int assignFormanId = 0;
  String supervisorId = '';
  String supervisorIdGlobal = '';

  String feederName = '';
  String substationName = '';
  int loadingIndex = 0;
  bool _isVisibleAssignForeman = true;

  final TextEditingController _totalMiles = TextEditingController();

  late final TextEditingController _contractRowYear = TextEditingController();

  String name1 = '';

  // ignore: non_constant_identifier_names
  final select_contractorCompany = [
    // 'LCP',
    'PEMC',
  ];

  // ignore: non_constant_identifier_names
  final select_budgetType = [
    'Regular IVM maintenance',
    // 'Mid Cycle maintenance'
  ];
  var budgetType;

  String a = '';

  final _formkey = GlobalKey<FormState>();
  List<dynamic> nextMaintYearList = [];
  List<dynamic> subStationList = [];
  List<dynamic> feederList = [];
  List<dynamic> maintTypeList = [];
  List<dynamic> typeList = [];
  List<dynamic> budgetTypeList = [];
  List<dynamic> planTypeList = [];
  List<dynamic> contractorCompanyList = [];
  String? contractorCompany;
  String? selectedAssignForman;

  List<dynamic> assignForemanList = [];

  // ignore: prefer_typing_uninitialized_variables
  var selectedSubstation;
  var selectedSubstationId;
  // ignore: prefer_typing_uninitialized_variables
  var selectedFeeder;
  var selectedMainttype;
  var selectedBudgettype;
  var selectedPlanType;
  var budgettype;
  // ignore: prefer_typing_uninitialized_variables

  // ignore: prefer_typing_uninitialized_variables
  var selectedyear;

  // ignore: non_constant_identifier_names
  List<String> select_maintenanceType = [
    'JARRAFF',
    'MOWING',
    'MINI JARRAFF',
    'BYL',
    'BUCKET',
    'GROUND',
    'CROSS-COUNTRY SPRAY',
    'ROADSIDE SPRAY',
    'NO SPRAY',
  ];
  String? maintenanceType = 'JARRAFF';

  List<String> types = ['JARRAFF'];

  onTappedBar(int index) {
    setState(() {
      // _currentIndex = index;
    });
  }

  String now = DateFormat("yyyy-MM-dd hh:mm:ss").format(DateTime.now());

  DateTime date20 = DateTime.now();
  late String dateSelected20 = DateFormat('yyyy-MM-dd').format(date20);
  String dynamicYear = '';
  String? year;
  List<String> select_year = generateYearList();
  Future? myFuture;
  bool isError = false;
  bool isSubmitLoading = false;
  ////////
  late List<CameraDescription> _cameras;
  late CameraController _camerasController;
  List<String> imagePaths = [];
  List<XFile> images = [];
  @override
  void initState() {
    cameraInit();
    // print('widget.tokenNo ${widget.tokenNo}');
    myFuture = getMaintenanceDropdownData(
      "",
      "",
      "",
      "",
      "",
      showLoader: false,
    );

    super.initState();
    _contractRowYear.text = DateFormat("yyyy").format(DateTime.now());
  }

  @override
  void dispose() {
    disposeCamera();
    super.dispose();
  }

  Future<void> disposeCamera() async {
    if (_camerasController.value.isInitialized) {
      await _camerasController.dispose();
      // _camerasController = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: FutureBuilder(
          future: myFuture,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            // API ERROR
            if (isError) {
              return buildNoDataWidget();
            }

            //  //EMPTY DATA
            //   if (energyAuditList.isEmpty) {
            //     return buildNoDataWidget();
            //   }

            // SUCCESS DATA
            return GestureDetector(
                onTap: () {
                  FocusScopeNode currentFocus = FocusScope.of(context);
                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.unfocus();
                  }
                },
                child: RefreshIndicator(
                  onRefresh: () async {
                    await getMaintenanceDropdownData(
                      "",
                      "",
                      "",
                      "",
                      "",
                      showLoader: false,
                    );
                  },
                  child: SingleChildScrollView(
                      child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                            left: 8, right: 8, top: 8, bottom: 8),
                        padding: const EdgeInsets.all(8),
                        alignment: Alignment.center,
                        // height: size.height * 0.5,
                        width: size.width * 0.99,
                        decoration: const BoxDecoration(
                            // shape: BoxShape.circle,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                  color: AppColors.baseColor,
                                  blurRadius: 10,
                                  offset: Offset(2.0, 5.0))
                            ],
                            gradient: LinearGradient(
                              colors: [
                                Color.fromARGB(255, 255, 255, 255),
                                Color.fromARGB(255, 255, 255, 255),
                              ],
                            )),
                        child: Form(
                          key: _formkey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // /// HEADER
                              headerWidget("DISTRIBUTION IVM"),

                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 2.0,
                                    right: 2.0,
                                    bottom: 2.0,
                                    top: 10.0),
                                child: Column(
                                  children: [
                                    const Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "NEXT MAINT YEAR*",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: AppColors.baseColor,
                                              fontWeight: FontWeight.bold),
                                        )),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: DropdownButtonFormField<String>(
                                          hint: const Text('-Select-'),
                                          dropdownColor: Colors.white,
                                          value: selectedyear,
                                          style: const TextStyle(
                                              color: AppColors.baseColor,
                                              fontSize: 16),
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
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: AppColors.baseColor,
                                              ),
                                            ),
                                          ),
                                          isExpanded: true,
                                          items: nextMaintYearList.map((e) {
                                            return DropdownMenuItem(
                                              value: e["next_maint_due"]
                                                  .toString(),
                                              child: Text(
                                                e["next_maint_due"].toString(),
                                              ),
                                            );
                                          }).toList(),
                                          onChanged: (val) {
                                            setState(() {
                                              selectedyear = val;
                                            });

                                            getMaintenanceDropdownData(
                                                "$selectedyear",
                                                "",
                                                "",
                                                "",
                                                "");
                                          },
                                          validator: (value) => value == null
                                              ? 'field required'
                                              : null,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 2.0,
                                    right: 2.0,
                                    bottom: 2.0,
                                    top: 10.0),
                                child: Column(
                                  children: [
                                    const Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "SUBSTATION*",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: AppColors.baseColor,
                                              fontWeight: FontWeight.bold),
                                        )),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: DropdownButtonFormField<String>(
                                          hint: const Text('-Select-'),
                                          dropdownColor: Colors.white,
                                          value: selectedSubstationId,
                                          style: const TextStyle(
                                            color: AppColors.baseColor,
                                            fontSize: 16,
                                          ),
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
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: AppColors.baseColor,
                                              ),
                                            ),
                                          ),
                                          isExpanded: true,
                                          items: subStationList.map((e) {
                                            return DropdownMenuItem(
                                              value: e["subId"].toString(),
                                              child: Text(
                                                e["subStation"].toString(),
                                              ),
                                            );
                                          }).toList(),
                                          onChanged: (val) {
                                            setState(() {
                                              /// Store substationId
                                              selectedSubstationId = val;

                                              /// Store substation Name
                                              final selectedItem =
                                                  subStationList.firstWhere(
                                                (e) =>
                                                    e["subId"].toString() ==
                                                    val,
                                              );

                                              selectedSubstation =
                                                  selectedItem["subStation"]
                                                      .toString();

                                              print(
                                                  "Selected Substation ID => $selectedSubstationId");
                                              print(
                                                  "Selected Substation Name => $selectedSubstation");
                                            });

                                            getMaintenanceDropdownData(
                                              "$selectedyear",
                                              "$selectedSubstationId",
                                              "$selectedSubstation",
                                              "",
                                              "",
                                            );
                                          },
                                          validator: (value) => value == null
                                              ? 'field required'
                                              : null,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 2.0,
                                    right: 2.0,
                                    bottom: 2.0,
                                    top: 10.0),
                                child: Column(
                                  children: [
                                    const Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "FEEDER*",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: AppColors.baseColor,
                                              fontWeight: FontWeight.bold),
                                        )),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: DropdownButtonFormField<String>(
                                          hint: const Text('-Select-'),
                                          dropdownColor: Colors.white,
                                          value: selectedFeeder,
                                          style: const TextStyle(
                                              color: AppColors.baseColor,
                                              fontSize: 16),
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
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: AppColors.baseColor,
                                              ),
                                            ),
                                          ),
                                          isExpanded: true,
                                          items: feederList.map((e) {
                                            return DropdownMenuItem(
                                              value: e["fdrName"].toString(),
                                              child: Text(
                                                e["fdrName"].toString(),
                                              ),
                                            );
                                          }).toList(),
                                          onChanged: (val) {
                                            setState(() {
                                              selectedFeeder = val;
                                            });
                                            // Find selected item from list
                                            final selectedItem =
                                                feederList.firstWhere(
                                              (element) =>
                                                  element["fdrName"]
                                                      .toString() ==
                                                  val,
                                            );
                                            feederId = selectedItem["fdrId"];

                                            print(
                                                "Selected Feeder => ${selectedItem["fdrName"]}");
                                            print(
                                                "Selected FeederId => $feederId");

                                            getMaintenanceDropdownData(
                                                "$selectedyear",
                                                "$selectedSubstationId",
                                                "$selectedSubstation",
                                                "$selectedFeeder",
                                                "");
                                          },
                                          validator: (value) => value == null
                                              ? 'field required'
                                              : null,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 2.0,
                                    right: 2.0,
                                    bottom: 2.0,
                                    top: 10.0),
                                child: Column(
                                  children: [
                                    const Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "MAINT TYPE*",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: AppColors.baseColor,
                                              fontWeight: FontWeight.bold),
                                        )),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: DropdownButtonFormField<String>(
                                          hint: const Text('-Select-'),
                                          dropdownColor: Colors.white,
                                          value: selectedMainttype,
                                          style: const TextStyle(
                                              color: AppColors.baseColor,
                                              fontSize: 16),
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
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: AppColors.baseColor,
                                              ),
                                            ),
                                          ),
                                          isExpanded: true,
                                          items: maintTypeList.map((e) {
                                            return DropdownMenuItem(
                                              value: e["maintType"].toString(),
                                              child: Text(
                                                e["maintType"].toString(),
                                              ),
                                            );
                                          }).toList(),
                                          onChanged: (val) {
                                            setState(() {
                                              selectedMainttype = val;
                                            });
                                          },
                                          validator: (value) => value == null
                                              ? 'field required'
                                              : null,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 2.0,
                                    right: 2.0,
                                    bottom: 2.0,
                                    top: 10.0),
                                child: Column(
                                  children: [
                                    const Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "TYPE*",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: AppColors.baseColor,
                                              fontWeight: FontWeight.bold),
                                        )),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 12,
                                            vertical: 4,
                                          ),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: AppColors.baseColor,
                                            ),
                                          ),
                                          child: MultiSelectDialogField(
                                            /// Show all items selected initially
                                            initialValue: selectedTypes,

                                            items: typeList
                                                .map(
                                                  (e) => MultiSelectItem(
                                                    e["type"].toString(),
                                                    e["type"].toString(),
                                                  ),
                                                )
                                                .toList(),

                                            listType: MultiSelectListType.CHIP,

                                            onConfirm: (List<dynamic> value) {
                                              setState(() {
                                                selectedTypes =
                                                    value.cast<String>();
                                                maintenanceType =
                                                    selectedTypes.join(', ');
                                              });

                                              print(
                                                  "maintenanceType => $maintenanceType");
                                            },

                                            validator: (value) =>
                                                value == null || value.isEmpty
                                                    ? 'Field required'
                                                    : null,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 2.0,
                                    right: 2.0,
                                    bottom: 2.0,
                                    top: 10.0),
                                child: Column(
                                  children: [
                                    const Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "BUDGET TYPE*",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: AppColors.baseColor,
                                              fontWeight: FontWeight.bold),
                                        )),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: DropdownButtonFormField<String>(
                                          hint: const Text('-Select-'),
                                          dropdownColor: Colors.white,
                                          value: selectedBudgettype,
                                          style: const TextStyle(
                                              color: AppColors.baseColor,
                                              fontSize: 16),
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
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: AppColors.baseColor,
                                              ),
                                            ),
                                          ),
                                          isExpanded: true,
                                          items: budgetTypeList.map((e) {
                                            return DropdownMenuItem(
                                              value: e["budgetType"].toString(),
                                              child: Text(
                                                e["budgetType"].toString(),
                                              ),
                                            );
                                          }).toList(),
                                          onChanged: (val) {
                                            setState(() {
                                              selectedBudgettype = val;
                                            });
                                          },
                                          validator: (value) => value == null
                                              ? 'field required'
                                              : null,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 2.0,
                                    right: 2.0,
                                    bottom: 2.0,
                                    top: 10.0),
                                child: Column(
                                  children: [
                                    const Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "PLAN TYPE*",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: AppColors.baseColor,
                                              fontWeight: FontWeight.bold),
                                        )),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: DropdownButtonFormField<String>(
                                          hint: const Text('-Select-'),
                                          dropdownColor: Colors.white,
                                          value: selectedPlanType,
                                          style: const TextStyle(
                                              color: AppColors.baseColor,
                                              fontSize: 16),
                                          icon: const Icon(
                                            Icons.arrow_drop_down,
                                            color: AppColors.baseColor,
                                            size: 40,
                                          ),
                                          //     /// Remove arrow icon
                                          // icon: const SizedBox(),
                                          decoration: const InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: AppColors.baseColor,
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: AppColors.baseColor,
                                              ),
                                            ),
                                          ),
                                          isExpanded: true,
                                          items: planTypeList.map((e) {
                                            return DropdownMenuItem(
                                              value: e["workPlan"].toString(),
                                              child: Text(
                                                e["workPlan"].toString(),
                                              ),
                                            );
                                          }).toList(),
                                          onChanged: (val) {
                                            setState(() {
                                              selectedPlanType = val;
                                            });
                                          },
                                          validator: (value) => value == null
                                              ? 'field required'
                                              : null,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 2.0,
                                    right: 2.0,
                                    bottom: 2.0,
                                    top: 10.0),
                                child: Column(
                                  children: [
                                    const Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "TOTAL MILES",
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              color: AppColors.baseColor,
                                              fontWeight: FontWeight.bold),
                                        )),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: TextFormField(
                                          inputFormatters: [
                                            FilteringTextInputFormatter.deny(
                                                RegExp(r'-')),
                                          ],
                                          //key: formkey4,
                                          controller: _totalMiles,
                                          style: const TextStyle(
                                              color: AppColors.baseColor,
                                              fontSize: 16),
                                          obscureText: false,
                                          // keyboardType:
                                          //     TextInputType.number,
                                          keyboardType: const TextInputType
                                              .numberWithOptions(
                                            decimal: true,
                                            signed: false,
                                          ),
                                          decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: AppColors.baseColor,
                                              ),
                                            ),
                                            hintText: '0',
                                          ),
                                          onChanged: (value) {
                                            setState(() {});
                                          },
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "Please enter total cost";
                                            } else if (double.tryParse(
                                                    _totalMiles.text) ==
                                                0) {
                                              return "Total miles cannot be 0";
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
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 2.0,
                                    right: 2.0,
                                    bottom: 2.0,
                                    top: 10.0),
                                child: Column(
                                  children: [
                                    const Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "CONTRACTOR COMPANY*",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: AppColors.baseColor,
                                          fontWeight: FontWeight.bold,
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
                                          value: contractorCompany,
                                          style: const TextStyle(
                                            color: AppColors.baseColor,
                                            fontSize: 16,
                                          ),
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
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: AppColors.baseColor,
                                              ),
                                            ),
                                          ),
                                          isExpanded: true,

                                          /// contractorComapany from API
                                          items: contractorCompanyList.map((e) {
                                            return DropdownMenuItem(
                                              value: e["contractorComapany"]
                                                  .toString(),
                                              child: Text(
                                                e["contractorComapany"]
                                                    .toString(),
                                              ),
                                            );
                                          }).toList(),

                                          onChanged: (value) {
                                            setState(() {
                                              contractorCompany = value;
                                            });

                                            print(
                                                "Selected Contractor Company => $contractorCompany");

                                            getMaintenanceDropdownData(
                                              "$selectedyear",
                                              "$selectedSubstationId",
                                              "$selectedSubstation",
                                              "$selectedFeeder",
                                              "$contractorCompany",
                                            );
                                          },

                                          validator: (value) => value == null
                                              ? 'field required'
                                              : null,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Visibility(
                                visible: _isVisibleAssignForeman,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 2.0,
                                      right: 2.0,
                                      bottom: 2.0,
                                      top: 10.0),
                                  child: Column(
                                    children: [
                                      const Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "ASSIGN FOREMAN*",
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: AppColors.baseColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child:
                                              DropdownButtonFormField<String>(
                                            hint: const Text('-Select-'),
                                            dropdownColor: Colors.white,
                                            value: selectedAssignForman,
                                            style: const TextStyle(
                                              color: AppColors.baseColor,
                                              fontSize: 16,
                                            ),
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
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: AppColors.baseColor,
                                                ),
                                              ),
                                            ),
                                            isExpanded: true,

                                            /// getAllContractorList from API
                                            items: assignForemanList.map((e) {
                                              return DropdownMenuItem(
                                                value: e["name"].toString(),
                                                child: Text(
                                                  e["name"].toString(),
                                                ),
                                              );
                                            }).toList(),

                                            onChanged: (val) {
                                              setState(() {
                                                selectedAssignForman = val;
                                              });

                                              // Find selected item from list
                                              final selectedItem =
                                                  assignForemanList.firstWhere(
                                                (element) =>
                                                    element["name"]
                                                        .toString() ==
                                                    val,
                                              );
                                              assignFormanId =
                                                  selectedItem["loginId"];

                                              print(
                                                  "Selected Assign Foreman => ${selectedItem["name"]}");
                                              print(
                                                  "Selected loginId => $assignFormanId");
                                            },

                                            validator: (value) => value == null
                                                ? 'field required'
                                                : null,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              Column(
                                children: [
                                  Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 2.0,
                                            right: 2.0,
                                            bottom: 2.0,
                                            top: 8.0),
                                        child: Text(
                                          "UPLOAD (IMAGE)*",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: AppColors.baseColor,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )),
                                  Align(
                                    alignment: Alignment.bottomLeft,
                                    child: InkWell(
                                      onTap: () {
                                        _takePictureDialog();
                                        //  pickImageOptions();
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.only(
                                            bottom: 10.0, top: 2),
                                        padding: const EdgeInsets.all(8),
                                        alignment: Alignment.center,
                                        width: 120,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: const [
                                            BoxShadow(
                                                color: AppColors.buttonShadow,
                                                blurRadius: 5,
                                                offset: Offset(2.0, 5.0))
                                          ],
                                          color: AppColors.lighterBaseColor,
                                          // gradient: const LinearGradient(
                                          //   colors: [
                                          //     AppColors.baseColor,
                                          //     AppColors.buttonOrange,
                                          //     AppColors.baseColor,
                                          //   ],
                                          // )
                                        ),
                                        child: Center(
                                          child: Text(
                                            'Choose File',
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white,
                                              //fontWeight: FontWeight.bold
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: List.generate(imagePaths.length, (
                                      index,
                                    ) {
                                      return Container(
                                        margin: const EdgeInsets.symmetric(
                                          horizontal: 5,
                                        ),
                                        width: 100,
                                        child: Stack(
                                          children: [
                                            Center(
                                              child: Image.file(
                                                File(imagePaths[index]),
                                                height: 100,
                                                width: 100,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Positioned(
                                              top: 0,
                                              right: 0,
                                              child: InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    // Remove the image path from the list
                                                    imagePaths.removeAt(
                                                      index,
                                                    );
                                                    images.removeAt(
                                                      index,
                                                    ); // Also remove from images list
                                                  });
                                                  // Call your API to delete the image
                                                  // deleteOnlineImageApi(
                                                  //   imagePaths[index],
                                                  //   selectedChangeOrderNo,
                                                  // );
                                                },
                                                child: const Icon(
                                                  Icons.delete,
                                                  color: Colors.red,
                                                  size: 30,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }),
                                  ),
                                ),
                              ),

                              // SingleChildScrollView(
                              //   scrollDirection: Axis.horizontal,
                              //   child: Row(
                              //     children:
                              //         List.generate(imagePaths.length, (index) {
                              //       return Container(
                              //         margin: const EdgeInsets.symmetric(
                              //             horizontal:
                              //                 5), // Optional: Add margin for spacing
                              //         width:
                              //             100, // Set a fixed width for each image/icon
                              //         child: Stack(
                              //           children: [
                              //             Center(
                              //               child: Image.file(
                              //                 File(imagePaths[index]),
                              //                 height:
                              //                     100, // Set a height for the image
                              //                 width:
                              //                     100, // Set a width for the image
                              //                 fit: BoxFit
                              //                     .cover, // Ensure the image covers the container without distortion
                              //               ),
                              //             ),
                              //             Positioned(
                              //               top: 0,
                              //               right: 0,
                              //               child: InkWell(
                              //                 onTap: () {
                              //                   setState(() {
                              //                     // Remove the image path from the list
                              //                     imagePaths.removeAt(index);
                              //                     images.removeAt(
                              //                         index); // Also remove from images list
                              //                   });
                              //                   // // Call your API to delete the image
                              //                   // deleteOnlineImageApi(
                              //                   //     imagePaths[index]);
                              //                 },
                              //                 child: const Icon(Icons.delete,
                              //                     color: Colors.red, size: 30),
                              //               ),
                              //             ),
                              //           ],
                              //         ),
                              //       );
                              //     }),
                              //   ),
                              // ),
                              // Row(
                              //   children: [
                              //     Expanded(
                              //       child: Visibility(
                              //         visible: _isVisibleImageDoc,
                              //         child: Stack(
                              //           children: [
                              //             if (imagePath.isNotEmpty)
                              //               Center(
                              //                 child: Icon(
                              //                   getFileTypeIcon(imagePath),
                              //                   size: 100,
                              //                 ),
                              //               ),
                              //             InkWell(
                              //               onTap: () async {
                              //                 setState(() {
                              //                   _isVisibleImageDoc = false;
                              //                 });
                              //                 deleteOnlineImageApi(imagePath);
                              //               },
                              //               child: const Icon(Icons.delete,
                              //                   color: Colors.red, size: 30),
                              //             ),
                              //           ],
                              //         ),
                              //       ),
                              //     ),
                              //     Expanded(
                              //       child: Visibility(
                              //         visible: _isVisibleImage2Doc,
                              //         child: Stack(
                              //           children: [
                              //             if (imagePath2.isNotEmpty)
                              //               Center(
                              //                 child: Icon(
                              //                   getFileTypeIcon(imagePath2),
                              //                   size: 100,
                              //                 ),
                              //               ),
                              //             InkWell(
                              //               onTap: () {
                              //                 setState(() {
                              //                   _isVisibleImage2Doc = false;
                              //                 });
                              //                 deleteOnlineImageApi(imagePath2);
                              //               },
                              //               child: const Icon(Icons.delete,
                              //                   color: Colors.red, size: 30),
                              //             ),
                              //           ],
                              //         ),
                              //       ),
                              //     ),
                              //     Expanded(
                              //       child: Visibility(
                              //         visible: _isVisibleImage3Doc,
                              //         child: Stack(
                              //           children: [
                              //             if (imagePath3.isNotEmpty)
                              //               Center(
                              //                 child: Icon(
                              //                   getFileTypeIcon(imagePath3),
                              //                   size: 100,
                              //                 ),
                              //               ),
                              //             InkWell(
                              //               onTap: () {
                              //                 setState(() {
                              //                   _isVisibleImage3Doc = false;
                              //                 });
                              //                 deleteOnlineImageApi(imagePath3);
                              //               },
                              //               child: const Icon(Icons.delete,
                              //                   color: Colors.red, size: 30),
                              //             ),
                              //           ],
                              //         ),
                              //       ),
                              //     ),
                              //   ],
                              // ),
                              // Row(
                              //   children: [
                              //     Expanded(
                              //       child: Visibility(
                              //         visible: _isVisibleImage,
                              //         child: Stack(
                              //           children: [
                              //             if (imagePath.isNotEmpty)
                              //               Image.file(
                              //                 File(imagePath),
                              //                 height: 200,
                              //                 width: 200,
                              //                 fit: BoxFit.cover,
                              //               ),
                              //             InkWell(
                              //               onTap: () async {
                              //                 setState(() {
                              //                   _isVisibleImage = false;
                              //                 });
                              //                 deleteOnlineImageApi(
                              //                     deleteImage1);
                              //               },
                              //               child: const Icon(Icons.delete,
                              //                   color: Colors.red, size: 30),
                              //             ),
                              //           ],
                              //         ),
                              //       ),
                              //     ),
                              //     Expanded(
                              //       child: Visibility(
                              //         visible: _isVisibleImage2,
                              //         child: Stack(
                              //           children: [
                              //             if (imagePath2.isNotEmpty)
                              //               Image.file(
                              //                 File(imagePath),
                              //                 height: 200,
                              //                 width: 200,
                              //                 fit: BoxFit.cover,
                              //               ),
                              //             InkWell(
                              //               onTap: () {
                              //                 setState(() {
                              //                   _isVisibleImage2 = false;
                              //                 });
                              //                 deleteOnlineImageApi(
                              //                     deleteImage2);
                              //               },
                              //               child: const Icon(Icons.delete,
                              //                   color: Colors.red, size: 30),
                              //             ),
                              //           ],
                              //         ),
                              //       ),
                              //     ),
                              //     Expanded(
                              //       child: Visibility(
                              //         visible: _isVisibleImage3,
                              //         child: Stack(
                              //           children: [
                              //             if (imagePath3.isNotEmpty)
                              //               Image.file(
                              //                 File(imagePath3),
                              //                 height: 200,
                              //                 width: 200,
                              //                 fit: BoxFit.cover,
                              //               ),
                              //             InkWell(
                              //               onTap: () {
                              //                 setState(() {
                              //                   _isVisibleImage3 = false;
                              //                 });
                              //                 deleteOnlineImageApi(
                              //                     deleteImage3);
                              //               },
                              //               child: const Icon(Icons.delete,
                              //                   color: Colors.red, size: 30),
                              //             ),
                              //           ],
                              //         ),
                              //       ),
                              //     ),
                              //   ],
                              // ),

                              Align(
                                alignment: Alignment.center,
                                child: InkWell(
                                  onTap: () {
                                    if (_formkey.currentState!.validate()) {
                                      setState(() {
                                        isSubmitLoading = true;
                                      });
                                      submitMaintenancePlan();
                                    } else {
                                      setState(() {
                                        isSubmitLoading = false;
                                      });
                                    }
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(
                                        bottom: 10.0, top: 10),
                                    padding: const EdgeInsets.all(4),
                                    alignment: Alignment.center,
                                    width: 120,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: const [
                                        BoxShadow(
                                            color: AppColors.buttonShadow,
                                            blurRadius: 5,
                                            offset: Offset(2.0, 5.0))
                                      ],
                                      color: AppColors.baseColor,
                                      // gradient: const LinearGradient(
                                      //   colors: [
                                      //     AppColors.baseColor,
                                      //     AppColors.buttonOrange,
                                      //     AppColors.baseColor,
                                      //   ],
                                      // )
                                    ),
                                    child: Center(
                                      child: isSubmitLoading
                                          ? progressBar()
                                          : Text(
                                              'SUBMIT',
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white,
                                                //fontWeight: FontWeight.bold
                                              ),
                                            ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
                ));
          },
        ),
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
      value: item,
      child: Text(item,
          style: const TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 20,
          )));

  static List<String> generateYearList() {
    DateTime now = DateTime.now();
    int currentYear = now.year;
    List<String> years = [];
    for (int i = currentYear - 5; i <= currentYear + 9; i++) {
      years.add(i.toString());
    }
    return years;
  }

  // Future<void> _checkPermission(BuildContext context) async {
  //   FocusScope.of(context).requestFocus(FocusNode());
  //   Map<Permission, PermissionStatus> statues = await [
  //     Permission.camera,
  //     Permission.storage,
  //     Permission.photos
  //   ].request();
  //   PermissionStatus? statusCamera = statues[Permission.camera];
  //   PermissionStatus? statusStorage;
  //   PermissionStatus? statusPhotos;
  //   if (Platform.isAndroid) {
  //     final androidInfo = await DeviceInfoPlugin().androidInfo;
  //     if (androidInfo.version.sdkInt <= 32) {
  //       statusStorage = statues[Permission.storage];

  //       /// use [Permissions.storage.status]
  //     } else {
  //       statusPhotos = statues[Permission.photos];

  //       /// use [Permissions.photos.status]
  //     }
  //   }

  //   bool isGranted = statusCamera == PermissionStatus.granted &&
  //           statusStorage == PermissionStatus.granted ||
  //       statusCamera == PermissionStatus.granted &&
  //           statusPhotos == PermissionStatus.granted;
  //   if (isGranted) {
  //     pickImageOptions();
  //     // _pickImages();
  //   }
  //   bool isPermanentlyDenied =
  //       statusCamera == PermissionStatus.permanentlyDenied ||
  //           statusStorage == PermissionStatus.permanentlyDenied ||
  //           statusPhotos == PermissionStatus.permanentlyDenied;
  //   if (isPermanentlyDenied) {
  //     // _showSettingsDialog(context);
  //   }
  // }
/////////////////////////////
/////////////
  List<String> selectedFiles = [];
  Future pickImageOptions() => showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            content: const SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    "Select image from",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: AppColors.baseColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        _takePictureDialog();
                      },
                      child: Container(
                        margin: const EdgeInsets.only(
                            left: 4, right: 4, bottom: 10.0),
                        // padding: const EdgeInsets.all(8),
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        height: 40,
                        decoration: const BoxDecoration(
                            // shape: BoxShape.circle,
                            // borderRadius: BorderRadius.circular(25),
                            boxShadow: [
                              BoxShadow(
                                  color: Color.fromARGB(255, 112, 68, 1),
                                  blurRadius: 5,
                                  offset: Offset(2.0, 5.0))
                            ],
                            color: Colors.black,
                            gradient: LinearGradient(
                              colors: [
                                Colors.orange,
                                Colors.orange,
                              ],
                            )),
                        child: const Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Camera",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        pickFromGallery();
                      },
                      child: Container(
                        margin: const EdgeInsets.only(
                            left: 4, right: 4, bottom: 10.0),
                        // padding: const EdgeInsets.all(8),
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        height: 40,
                        decoration: const BoxDecoration(
                            // shape: BoxShape.circle,
                            // borderRadius: BorderRadius.circular(25),
                            boxShadow: [
                              BoxShadow(
                                  color: Color.fromARGB(255, 112, 68, 1),
                                  blurRadius: 5,
                                  offset: Offset(2.0, 5.0))
                            ],
                            color: Colors.black,
                            gradient: LinearGradient(
                              colors: [
                                Colors.orange,
                                Colors.orange,
                              ],
                            )),
                        child: const Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Gallery",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        // pickDocument();
                      },
                      child: Container(
                        margin: const EdgeInsets.only(
                            left: 4, right: 4, bottom: 10.0),
                        // padding: const EdgeInsets.all(8),
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        height: 40,
                        decoration: const BoxDecoration(
                            // shape: BoxShape.circle,
                            // borderRadius: BorderRadius.circular(25),
                            boxShadow: [
                              BoxShadow(
                                  color: Color.fromARGB(255, 112, 68, 1),
                                  blurRadius: 5,
                                  offset: Offset(2.0, 5.0))
                            ],
                            color: Colors.black,
                            gradient: LinearGradient(
                              colors: [
                                Colors.orange,
                                Colors.orange,
                              ],
                            )),
                        child: const Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Document",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        });
      });
  // Gallery Picker
  Future<void> pickFromGallery() async {
    final ImagePicker picker = ImagePicker();

    final List<XFile> images = await picker.pickMultiImage(
      imageQuality: 80,
    );

    if (images.isNotEmpty) {
      setState(() {
        selectedFiles.addAll(
          images.map((e) => e.path).toList(),
        );
      });

      Navigator.pop(context); // close dialog
    }
  }
// PDF / Document Picker
// Future<void> pickDocument() async {
//   FilePickerResult? result = await FilePicker.platform.pickFiles(
//     type: FileType.custom,
//     allowedExtensions: ['pdf'],
//     allowMultiple: true,
//   );

//   if (result != null) {
//     setState(() {
//       selectedFiles.addAll(
//         result.paths
//             .where((path) => path != null)
//             .cast<String>()
//             .toList(),
//       );
//     });

//     Navigator.pop(context); // close dialog
//   }
// }

  // Future<void> _pickImagesCamera() async {
  //   final ImagePicker picker = ImagePicker();
  //   const ImageSource source = ImageSource.camera;
  //   List<String> chosenImagePaths = [];

  //   for (int i = 0; i < 3; i++) {
  //     final XFile? image = await picker.pickImage(
  //       source: source,
  //       maxWidth: 1024,
  //       maxHeight: 1024,
  //       imageQuality: 100,
  //     );

  //     if (image != null) {
  //       chosenImagePaths.add(image.path);
  //     }
  //   }

  //   setState(() {
  //     for (int i = 0; i < chosenImagePaths.length; i++) {
  //       if (_imagePath.isEmpty) {
  //         _imagePath = chosenImagePaths[i];
  //         setState(() {
  //           _isVisibleImage = true;
  //         });
  //       } else if (_imagePath2.isEmpty) {
  //         _imagePath2 = chosenImagePaths[i];
  //         setState(() {
  //           _isVisibleImage2 = true;
  //         });
  //       } else if (_imagePath3.isEmpty) {
  //         _imagePath3 = chosenImagePaths[i];
  //         setState(() {
  //           _isVisibleImage3 = true;
  //         });
  //       } else {
  //         CustomToastSnackBarProgressDialog.toastMessage(
  //           'You can select a maximum of 3 images!',
  //         );
  //         break;
  //       }
  //     }
  //   });
  // }

  // Future<void> _pickImagesGallery() async {
  //   final ImagePicker picker = ImagePicker();
  //   List<String> chosenImagePaths = [];

  //   for (int i = 0; i < 3; i++) {
  //     final XFile? image = await picker.pickImage(
  //       source: ImageSource.gallery, // Set source to ImageSource.gallery only
  //       maxWidth: 1024,
  //       maxHeight: 1024,
  //       imageQuality: 100,
  //     );

  //     if (image != null) {
  //       chosenImagePaths.add(image.path);
  //     }
  //   }

  //   setState(() {
  //     for (int i = 0; i < chosenImagePaths.length; i++) {
  //       if (_imagePath.isEmpty) {
  //         _imagePath = chosenImagePaths[i];
  //         setState(() {
  //           _isVisibleImage = true;
  //         });
  //       } else if (_imagePath2.isEmpty) {
  //         _imagePath2 = chosenImagePaths[i];
  //         setState(() {
  //           _isVisibleImage2 = true;
  //         });
  //       } else if (_imagePath3.isEmpty) {
  //         _imagePath3 = chosenImagePaths[i];
  //         setState(() {
  //           _isVisibleImage3 = true;
  //         });
  //       } else {
  //         CustomToastSnackBarProgressDialog.toastMessage(
  //           'You can select a maximum of 3 images!',
  //         );
  //         break;
  //       }
  //     }
  //   });
  // }

  // Future<void> _uploadDocuments() async {
  //   print('document upload');

  //   const XTypeGroup typeGroup = XTypeGroup(
  //     label: 'documents',
  //     extensions: ['pdf', 'doc', 'docx'],
  //   );

  //   try {
  //     final List<XFile> documentResult = await openFiles(
  //       acceptedTypeGroups: [typeGroup],
  //     );

  //     if (documentResult.isNotEmpty) {
  //       List<String> chosenDocumentPaths = [];

  //       for (int i = 0; i < documentResult.length; i++) {
  //         if (chosenDocumentPaths.length < 3) {
  //           chosenDocumentPaths.add(documentResult[i].path);
  //         } else {
  //           CustomToastSnackBarProgressDialog.toastMessage(
  //             'You can select a maximum of 3 documents!',
  //           );
  //           return;
  //         }
  //       }
  //       setState(() {
  //         for (int i = 0; i < chosenDocumentPaths.length; i++) {
  //           if (_imagePath.isEmpty) {
  //             _imagePath = chosenDocumentPaths[i];
  //             setState(() {
  //               _isVisibleImageDoc = true;
  //             });
  //           } else if (_imagePath2.isEmpty) {
  //             _imagePath2 = chosenDocumentPaths[i];
  //             setState(() {
  //               _isVisibleImage2Doc = true;
  //             });
  //           } else if (_imagePath3.isEmpty) {
  //             _imagePath3 = chosenDocumentPaths[i];
  //             setState(() {
  //               _isVisibleImage3Doc = true;
  //             });
  //           } else {
  //             CustomToastSnackBarProgressDialog.toastMessage(
  //               'You can select a maximum of 3 documents!',
  //             );
  //             break;
  //           }
  //         }
  //       });
  //     } else {
  //       CustomToastSnackBarProgressDialog.toastMessage(
  //         'Please select at least one document.',
  //       );
  //     }
  //   } catch (e) {
  //     print('Error occurred while picking documents: $e');
  //     CustomToastSnackBarProgressDialog.toastMessage(
  //       'Error occurred while picking documents: $e',
  //     );
  //   }
  // }

  // Future<void> deleteOnlineImageApi(String fileName) async {
  //   final apiUrl =
  //       'https://atsdev2test.ariespro.com/civmapi/changeOrderLcpCreateOrder/deleteFile?fileName=$fileName';
  //   final userPreferences = Provider.of<UserPref>(context, listen: false);
  //   UserModel data = await userPreferences.getUser();

  //   try {
  //     final response = await http.delete(
  //       Uri.parse(apiUrl),
  //       headers: {"Authorization": 'Bearer ${data.token!}'},
  //     );

  //     if (response.statusCode == 200) {
  //       setState(() {});
  //     } else {}
  //   } catch (e) {}
  // }

  // void setCycleAndYear(String year) {
  //   int yearValue = int.tryParse(year) ?? 0;
  //   int cycle = ((yearValue - 2014) ~/ 7) + 1;
  //   int yearInCycle = ((yearValue - 2014) % 7) + 1;
  //   _rowCycle.text = cycle.toString();
  //   _rowYear.text = yearInCycle.toString();
  //   // getTotalMiles();
  // }

  // Future<void> submitImage(String fileName, String tokenNo) async {
  //   print('submit image api11111111111');
  //   Directory tempDir = await getTemporaryDirectory();
  //   print('submit image 22222222222222222');
  //   String tempPath = tempDir.path;
  //   try {
  //     print('submit image 333333333333333333333');
  //     var uri = Uri.parse(
  //         "https://atsdev2test.ariespro.com/civmapi/contractorPanel/updateImageVEGETATION_CREW_FORMs");
  //     var request = http.MultipartRequest("POST", uri);
  //     final userPreferences = Provider.of<UserPref>(context, listen: false);
  //     UserModel data = await userPreferences.getUser();
  //     print('submit image 4444444444444444444');
  //     var headers = {
  //       "Content-Type": "multipart/form-data",
  //       "Accept": "*/*",
  //       "Authorization": 'Bearer ${data.token!}'
  //     };
  //     // var stream1 = http.ByteStream(image.openRead());
  //     // // Get the file length
  //     // var length = await image.length();
  //     // Create a multipart file from the byte stream
  //     // var multipartFile1 = http.MultipartFile(
  //     //   'ClientDoc1', // Field name for the file
  //     //   stream1, // Byte stream of the file
  //     //   length, // Length of the file
  //     //   filename: basename(image.path), // Original file name
  //     // );
  //     // request.files.add(multipartFile1); // Add the single file to the request
  //     List<http.MultipartFile> newList = [];
  //     if (_imagePath != '') {
  //       print('submit image 4555555555555555555555');
  //       File img1 = new File(_imagePath);
  //       File file = await img1.copy(
  //           '${tempPath}/img_${DateFormat('yyyyMMddHHmmss').format(DateTime.now())}${_imagePath.contains('.pdf') ? '.pdf' : '.jpg'}');
  //       print('submit image 666666666666666');
  //       var stream1 = http.ByteStream(file.openRead());
  //       var length1 = await file.length();
  //       // Get the file length
  //       var multipartFile = http.MultipartFile("files", stream1, length1,
  //           filename: path.basename(file.path));
  //       deleteImage1 = path.basename(file.path);
  //       newList.add(multipartFile);
  //     }

  //     if (_imagePath2 != '') {
  //       File img2 = new File(_imagePath2);
  //       File file2 = await img2.copy(
  //           '${tempPath}/img_${DateFormat('yyyyMMddHHmmss').format(DateTime.now())}2${_imagePath2.contains('.pdf') ? '.pdf' : '.jpg'}');

  //       var stream2 = http.ByteStream(file2.openRead());
  //       var length2 = await file2.length();
  //       // Get the file length
  //       var multipartFile2 = http.MultipartFile("files", stream2, length2,
  //           filename: path.basename(file2.path));

  //       deleteImage2 = path.basename(file2.path);

  //       newList.add(multipartFile2);
  //     }

  //     if (_imagePath3 != '') {
  //       File img3 = new File(_imagePath3);
  //       File file3 = await img3.copy(
  //           '${tempPath}/img_${DateFormat('yyyyMMddHHmmss').format(DateTime.now())}3${_imagePath3.contains('.pdf') ? '.pdf' : '.jpg'}');

  //       var stream3 = http.ByteStream(file3.openRead());
  //       var length3 = await file3.length();
  //       // Get the file length
  //       var multipartFile3 = http.MultipartFile("files", stream3, length3,
  //           filename: path.basename(file3.path));
  //       deleteImage3 = path.basename(file3.path);
  //       newList.add(multipartFile3);
  //     }

  //     if (newList.isNotEmpty) {
  //       request.files.addAll(newList); // Add the multiple file to the request
  //     }
  //     request.headers.addAll(headers);
  //     request.fields['tokenNo'] = tokenNo;
  //     // Send the request
  //     var streamedResponse = await request.send();
  //     var response = await http.Response.fromStream(streamedResponse);
  //     // listen for response
  //     // streamedResponse.stream.transform(utf8.decoder).listen((value) {
  //     //   print(value);
  //     // });
  //     if (response.statusCode == 200) {
  //       print('image successfully uploaded...........');
  //       print(response.body);
  //       if (_imagePath != '') {
  //         setState(() {
  //           _isVisibleImage = true;
  //         });
  //       }

  //       if (_imagePath2 != '') {
  //         setState(() {
  //           _isVisibleImage2 = true;
  //         });
  //       }

  //       if (_imagePath3 != '') {
  //         setState(() {
  //           _isVisibleImage3 = true;
  //         });
  //       }
  //       Navigator.of(context).push(MaterialPageRoute(
  //           builder: (BuildContext context) => const AdminAddNewRowTable()));
  //     }
  //   } catch (e) {
  //     print('inside catch of image upload api.................');
  //   }
  //   _isVisibleImage = true;
  // }

  // IconData getFileTypeIcon(String filePath) {
  //   if (filePath.endsWith('.pdf')) {
  //     return Icons.picture_as_pdf;
  //   } else if (filePath.endsWith('.doc') || filePath.endsWith('.docx')) {
  //     return Icons.description;
  //   } else {
  //     return Icons.insert_drive_file;
  //   }
  // }

  ///====================== GET API METHOD ======================///
  String id = '';
  List<String> selectedTypes = [];

  Future<void> getMaintenanceDropdownData(
    String nextMaintYear,
    String subId,
    String substation,
    String feeder,
    String conctractorComp, {
    bool showLoader = true,
  }) async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    id = data.user!.id.toString();

    /// Show loader only when needed
    if (showLoader) {
      showLoadingDialog();
    }
    try {
      final String apiUrl =
          "${AppUrl.baseUrl}supervisorJobList/getDistributionIVMJobListEditFormData?yearList=$nextMaintYear&substationList=$subId&substationNameList=$substation&feederNameList=$feeder&contractorCampany=$conctractorComp";
      final response = await http.get(
        Uri.parse(apiUrl), // your API URL

        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": 'Bearer ${data.token!}'
        },
      );
      print('apiUrl $apiUrl');
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);

        /// Print Status Code
        print("Status Code => ${response.statusCode}");
        setState(() {
          /// NEXT MAINT YEAR
          nextMaintYearList = jsonData["next_maint_due_year"] ?? [];

          /// SUBSTATION
          subStationList = jsonData["subStations"] ?? [];

          /// FEEDER
          feederList = jsonData["feeders"] ?? [];

          /// MAINT TYPE
          maintTypeList = jsonData["maint_type"] ?? [];

          /// TYPE
          typeList = jsonData["type"] ?? [];

          /// Initially select all type items from API
          if (selectedTypes.isEmpty && typeList.isNotEmpty) {
            selectedTypes =
                typeList.map<String>((e) => e["type"].toString()).toList();

            maintenanceType = selectedTypes.join(', ');

            print("Initial Selected Types => $maintenanceType");
          }

          /// BUDGET TYPE
          budgetTypeList = jsonData["budgetType"] ?? [];

          /// PLAN TYPE
          planTypeList = jsonData["workPlan"] ?? [];

          /// CONTRACTOR
          contractorCompanyList = jsonData["contractorComapany"] ?? [];

          /// Assign Foreman Dropdown
          assignForemanList = jsonData["getAllContractorList"] ?? [];
          var totalMiles = jsonData["miles"] ?? 0.0;
          _totalMiles.text = totalMiles.toString();

          /// ===============================
          /// SET DEFAULT VALUES INITIALLY
          /// ===============================

          /// Maint Type default
          if (selectedMainttype == null && maintTypeList.isNotEmpty) {
            selectedMainttype = maintTypeList.first["maintType"].toString();
          }

          /// Budget Type default
          if (selectedBudgettype == null && budgetTypeList.isNotEmpty) {
            selectedBudgettype = budgetTypeList.first["budgetType"].toString();
          }

          /// Plan Type default
          if (selectedPlanType == null && planTypeList.isNotEmpty) {
            selectedPlanType = planTypeList.first["workPlan"].toString();
          }

          print("selectedMainttype => $selectedMainttype");
          print("selectedBudgettype => $selectedBudgettype");
          print("selectedPlanType => $selectedPlanType");
        });
      } else {
        print("API Failed : ${response.statusCode}");
      }
    } catch (e) {
      print("Exception : $e");
    } finally {
      if (showLoader) {
        hideLoadingDialog();
      }
    }
  }

  void showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Center(
            child: CircularProgressIndicator(
              color: AppColors.baseColor,
            ),
          ),
        );
      },
    );
  }

  void hideLoadingDialog() {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }

  Future<void> submitMaintenancePlan() async {
    final String apiUrl = AppUrl.addNewRowMaintenancePlanSubmitApiEndPoint;
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    id = data.user!.id.toString();
    try {
      var body = {
        "Id": 0,
        "TokenNo": 0,
        "CreatedBy": id,
        "Supervisor": selectedAssignForman,
        "Contractor": assignFormanId.toString(),
        "Crew": "",
        "MaintType": selectedMainttype,
        "District": "",
        "County": "",
        "Substation": selectedSubstationId,
        "Feeder": feederId.toString(),
        "Street": "",
        "Type": maintenanceType,
        "ContractYear": selectedyear,
        "Cycle": "2",
        "LastMaintDone": DateTime.now().toUtc().toIso8601String(),
        "NextMaintDue": DateTime.now().toUtc().toIso8601String(),
        "ContractEndYear": "",
        "MaintCount": 0,
        "MaintDateHistory": "",
        "TotalMiles": _totalMiles.text.trim(),
        "CostPerMile": 0,
        "TotalCost": 0,
        "DueMonth": 0,
        "DueWeek": 0,
        "Budget": 0,
        "BudgetType": selectedBudgettype,
        "MilesCompleted": 0,
        "MilesInProgress": 0,
        "MilesPending": 0,
        "ActionNeeded": "",
        "TreeType": "",
        "GrowthRate": "",
        "GrowthScore": "",
        "Status": "PENDING",
        "DocumentUpload": "",
        "InvoiceCreated": "",
        "WorkProperty": "",
        "CreateDate": DateTime.now().toUtc().toIso8601String(),
        "TblVmaNewRowMaintenancePlanId": 0,
        "ApprovedBy": "",
        "PlanType": selectedPlanType,
        "ContractorCompay": contractorCompany,
        "StreetAddress": "",
        "MapLocation": "",
        "ChangeOrderImage": "",
        "AdminNotes1": "",
        "ContractorNotes": "",
        "AdminNotes2": "",
        "DateOfInspection": "",
        "FollowUpDate": "",
        "RowYear": "",
        "EstTime": "",
        "EstCost": "",
        "ActualCost": "",
        "VisibilityFlag": "0",
        "CrewNotes": "",
        "TransmissionName": ""
      };

      print("Submit Request Body => ${jsonEncode(body)}");

      var response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          "Content-Type": "application/json",
          "Authorization": 'Bearer ${data.token!}'
        },
        body: jsonEncode(body),
      );

      print("Status Code => ${response.statusCode}");
      print("Response => ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        /// Decode response
        final responseData = jsonDecode(response.body);

        /// Store tokenNo (Job No)
        String jobNo = responseData["tokenNo"].toString();

        print("Stored Job No => $jobNo");
        submitMediaFiles(
          imagePaths,
          jobNo,
        );
        // if (imagePaths.isNotEmpty) {
        // }
      } else {
        setState(() {
          isSubmitLoading = false;
        });
        CustomToastSnackBarProgressDialog.flushBarErrorMessage(
            'Failed to Submit', context);
        //Text("Failed: ${response.body}")
      }
    } catch (e) {
      setState(() {
        isSubmitLoading = false;
      });
      print("Submit Error => $e");
      CustomToastSnackBarProgressDialog.flushBarErrorMessage(
          "Error: $e", context);
      //Text("Error: $e"),
    }
  }

  //////image upload code----------
  Future<void> cameraInit() async {
    _cameras = await availableCameras();
    _camerasController = CameraController(_cameras[0], ResolutionPreset.max);
    _camerasController.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            // Handle access errors here.
            break;
          default:
            // Handle other errors here.
            break;
        }
      }
    });
  }

  Future<void> _takePictureDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Take Picture',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.baseColor,
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: IconButton(
                      icon: const Icon(Icons.close, color: Colors.red),
                      onPressed: () {
                        Navigator.of(context).pop(); // Close the dialog
                      },
                    ),
                  ),
                ],
              ),
              content: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(top: 4.0),
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: CameraPreview(_camerasController),
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: InkWell(
                      onTap: (() async {
                        Navigator.of(context).pop();
                        XFile image = await _camerasController.takePicture();
                        refreshPath(image.path, image);

                        Navigator.of(context).pop();
                      }),
                      child: Container(
                        margin: const EdgeInsets.all(4.0),
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: MediaQuery.of(context).size.height * 0.052,
                        decoration: const BoxDecoration(
                          // shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(255, 60, 59, 59),
                              blurRadius: 5,
                              offset: Offset(2.0, 5.0),
                            ),
                          ],
                          color: Colors.black,
                          gradient: LinearGradient(
                            colors: [
                              AppColors.baseColor,
                              AppColors.buttonOrange,
                              AppColors.baseColor,
                            ],
                          ),
                        ),
                        child: const Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Take Picture",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
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
  }

  void refreshPath(String path, XFile imageARG) {
    setState(() {
      imagePaths.add(path);
      images.add(imageARG);
    });
  }

  Future<void> submitMediaFiles(
    List<String> imagePaths,
    String tokenNo,
  ) async {
    print('Image Paths: $imagePaths');

    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;

    try {
      var uri = Uri.parse(
        AppUrl.uploadFilesApiEndPoint,
      );
      var request = http.MultipartRequest("POST", uri);

      final userPreferences = Provider.of<UserPref>(context, listen: false);
      UserModel data = await userPreferences.getUser();

      var headers = {
        "Content-Type": "multipart/form-data",
        "Accept": "*/*",
        "Authorization": 'Bearer ${data.token!}',
      };
      request.headers.addAll(headers);

      // Add images to the request
      List<http.MultipartFile> multipartFiles = [];
      for (int i = 0; i < imagePaths.length; i++) {
        String imagePath = imagePaths[i];

        if (imagePath.isNotEmpty) {
          File img = File(imagePath);

          File file = await img.copy(
            '$tempPath/img_${DateFormat('yyyyMMddHHmmss').format(DateTime.now())}_$i${imagePath.contains('.pdf') ? '.pdf' : '.jpg'}',
          );

          var stream = http.ByteStream(file.openRead());
          var length = await file.length();

          var multipartFile = http.MultipartFile(
            "files",
            stream,
            length,
            filename: path.basename(file.path),
          );

          multipartFiles.add(multipartFile);
        }
      }

      // Add files to the request
      if (multipartFiles.isNotEmpty) {
        request.files.addAll(multipartFiles);
      }

      // Add additional fields
      request.fields['tokenNo'] = tokenNo;

      // Send the request
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        print("Media files submitted successfully.");
        setState(() {
          isSubmitLoading = false;
        });
        CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
            'Successfully Submitted', context);
        await Future.delayed(const Duration(seconds: 2));
        if (mounted) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) =>
                  SupervisorAddNewRowTable(index: '0')));
        }

        // Future.delayed(const Duration(seconds: 2), () {

        print('API called.........');

        // Future.delayed(const Duration(seconds: 2), () {
        //   Navigator.pop(context);
        //   Navigator.pop(context);
        //   Navigator.pop(context);
        // });
      } else {
        print(
          "Failed to submit media files. Status code: ${response.statusCode}",
        );
        print("Response body: ${response.body}");
      }
    } catch (e, stacktrace) {
      print('Exception: $e\n$stacktrace');
    }
  }
}
