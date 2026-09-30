import 'dart:convert';
import 'dart:io';
import 'package:CIVM/piedmont/models/transmission_ivm_inprogress_model.dart';
import 'package:CIVM/piedmont/resources/app_colors.dart';
import 'package:CIVM/piedmont/resources/app_url.dart';
import 'package:CIVM/piedmont/screens/admin_pannel/row_maintenance_view/pdf_view.dart';
import 'package:CIVM/piedmont/screens/supervisor_pannel/supervisor_add_new_row_table.dart';
import 'package:CIVM/piedmont/screens/video_folder/fullVideo/full_screen_video_player.dart';
import 'package:CIVM/piedmont/utils/common_functions.dart';
import 'package:CIVM/piedmont/view_model/image_code_view_model.dart';
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
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:provider/provider.dart';
import 'package:CIVM/piedmont/utils/custom_toast_snackbar_progressdialog.dart';

import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:file_selector/file_selector.dart';

// ignore: must_be_immutable
class SupJobListDistriIVMEdit extends StatefulWidget {
  String tokenNo;

  SupJobListDistriIVMEdit({
    Key? key,
    required this.tokenNo,
  }) : super(key: key);

  @override
  State<SupJobListDistriIVMEdit> createState() =>
      _SupJobListDistriIVMEditState();
}

class _SupJobListDistriIVMEditState extends State<SupJobListDistriIVMEdit> {
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
  ImageViewViewModel imageViewModel = ImageViewViewModel();
  @override
  void initState() {
    cameraInit();
    myFuture = Future.wait([
      fetchDetails(context),
      imageViewModel.fetchImageApi(context, widget.tokenNo),
    ]);
    // fetchDetails(context);
    // //   getInitData();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   imageViewModel.fetchImageApi(context, widget.tokenNo);
    // });
    super.initState();
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
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Distribution IVM',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: AppColors.baseColor,
      ),
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
                    myFuture = Future.wait([
                      fetchDetails(context),
                      imageViewModel.fetchImageApi(context, widget.tokenNo),
                    ]);
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
                              // // /// HEADER
                              // headerWidget("DISTRIBUTION IVM"),

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
                                          items: nextMaintYearList
                                              .map(
                                                  (item) => buildMenuItem(item))
                                              .toList(),
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
                                          // value: selectedSubstationId,
                                          value: getSafeValue(
                                            selectedSubstationId,
                                            subStationList,
                                            "subId",
                                          ),
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
                                              selectedSubstationId = val;

                                              final selectedItem =
                                                  subStationList.firstWhere(
                                                (e) =>
                                                    e["subId"].toString() ==
                                                    val,
                                              );

                                              selectedSubstation =
                                                  selectedItem["subStation"]
                                                      .toString();

                                              /// ✅ RESET CHILD DROPDOWNS
                                              selectedFeeder = null;
                                              contractorCompany = null;
                                              selectedAssignForman = null;
                                            });

                                            getMaintenanceDropdownData(
                                              "$selectedyear",
                                              "$selectedSubstationId",
                                              "$selectedSubstation",
                                              "",
                                              "",
                                            );
                                          },
                                          // onChanged: (val) {
                                          //   setState(() {
                                          //     /// Store substationId
                                          //     selectedSubstationId = val;

                                          //     /// Store substation Name
                                          //     final selectedItem =
                                          //         subStationList.firstWhere(
                                          //       (e) =>
                                          //           e["subId"].toString() ==
                                          //           val,
                                          //     );

                                          //     selectedSubstation =
                                          //         selectedItem["subStation"]
                                          //             .toString();

                                          //     print(
                                          //         "Selected Substation ID => $selectedSubstationId");
                                          //     print(
                                          //         "Selected Substation Name => $selectedSubstation");
                                          //   });

                                          //   getMaintenanceDropdownData(
                                          //     "$selectedyear",
                                          //     "$selectedSubstationId",
                                          //     "$selectedSubstation",
                                          //     "",
                                          //     "",
                                          //   );
                                          // },

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
                                        //   value: selectedFeeder,
                                          value: getSafeValue(
                                            selectedFeeder,
                                            feederList,
                                            "fdrName",
                                          ),
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

                                              ///  RESET CHILD DROPDOWNS
                                              contractorCompany = null;
                                              selectedAssignForman = null;
                                            });
                                            print(
                                                '1111 selectedFeeder$selectedFeeder');
                                            final selectedItem =
                                                feederList.firstWhere(
                                              (element) =>
                                                  element["fdrName"]
                                                      .toString() ==
                                                  val,
                                            );

                                            feederId = selectedItem["fdrId"];

                                            getMaintenanceDropdownData(
                                              "$selectedyear",
                                              "$selectedSubstationId",
                                              "$selectedSubstation",
                                              "$selectedFeeder",
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
                                          //  value: contractorCompany,
                                          value: getSafeValue(
                                            contractorCompany,
                                            contractorCompanyList,
                                            "contractorComapany",
                                          ),
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
                                            // value: selectedAssignForman,
                                            value: getSafeValue(
                                              selectedAssignForman,
                                              assignForemanList,
                                              "name",
                                            ),
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
                                            'Choose Files',
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
                              const SizedBox(height: 8),

                              ///  IMAGE GRID VIEW
                              _buildImageGrid(),

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
                                              'UPDATE',
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

  ///====================== GET API METHOD ======================///
  ///
  TransIVMInprogressModel? item;

  Future<void> fetchDetails(BuildContext context) async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    id = data.user!.id.toString();
    var url =
        "${AppUrl.findClosedPendingPageData}?status=PENDING&budgetType=Regular IVM maintenance&maintType=RegularMaint&panel=supervisor&planType=IVM Work Plan&contractorCompany=Lewis Tree&year=2026&tokenNo=${widget.tokenNo}";

    print('fetchDetails urltab1 $url');

    var headers = {
      "Content-Type": "application/json",
      // "Authorization": "Bearer $token", //  Add this line
      "Authorization": 'Bearer ${data.token!}'
    };

    try {
      var response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        var res = jsonDecode(response.body);

        print("${response.statusCode},${response.body}");

        List list = res["findAllTableData"];

        if (list.isNotEmpty) {
          item = TransIVMInprogressModel.fromJson(list[0]);

          myFuture = getMaintenanceDropdownData(
            // "2026",
            // "11",
            // "Cherry Grove",
            // "Camp Springs W.",
            // "Lewis Tree",
            getYearOrNA(item?.nextMaintDue ?? ''),
            item?.subId ?? '',
            item?.substation ?? '',
            getFeederName(item?.fdrName ?? ''),
            item?.contractorCompany ?? '',
            showLoader: false,
          );

          WidgetsBinding.instance.addPostFrameCallback((_) {});

          setState(() {});
        }
      } else {
        // setState(() => isLoading = false);
      }
    } catch (e) {
      // setState(() => isLoading = false);
    }
  }

  String getFeederName(String input) {
    //  return input.split('(')[0].replaceAll('.', '').trim();
    return input.split('(')[0].trim();
  }

  ///
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
      print('getMaintenanceDropdownData apiUrl $apiUrl');
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);

        /// Print Status Code
        print("Status Code => ${response.statusCode}");
        setState(() {
          /// NEXT MAINT YEAR
          //   nextMaintYearList = jsonData["next_maint_due_year"] ?? [];

          final rawYearList = jsonData["next_maint_due_year"] ?? [];

          nextMaintYearList = rawYearList
              .map<String>((e) => e["next_maint_due"].toString())
              .toList();
          print('nextMaintYearListnew $nextMaintYearList');

          /// SUBSTATION
          subStationList = jsonData["subStations"] ?? [];

          /// FEEDER
          feederList = jsonData["feeders"] ?? [];

          /// MAINT TYPE
          maintTypeList = jsonData["maint_type"] ?? [];

          /// TYPE
          typeList = jsonData["type"] ?? [];

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
/////////////////////////////
          /// update
        if(showLoader==false){
           setData();
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

  String? getSafeValue(String? value, List list, String key) {
    if (value == null) return null;

    return list.any((e) => e[key].toString() == value) ? value : null;
  }
//   void setData() {
//     setState(() {});

//     selectedyear = nextMaintYearList.contains(getYearOrNA(item?.nextMaintDue))
//         ? getYearOrNA(item?.nextMaintDue)
//         : null;
//     print('selectedyear ${selectedyear}');

//     selectedSubstationId = item?.subId;
//     print('selectedSubstationId${selectedSubstationId}');

//     selectedFeeder = getFeederName(item?.fdrName ?? '');
//     print('123333 ${getFeederName(item?.fdrName ?? '')}');
//     maintenanceType = item?.type;
//     print('update ${maintenanceType}');

//     _totalMiles.text = item?.totalMiles ?? '';
//     contractorCompany = item?.contractorCompany;
//     selectedAssignForman =
//         assignForemanList.contains(item?.contractor) ? item?.contractor : "Alex";
// //--------------
//     String typeFromApi = item?.type ?? '';
// // "JARRAFF, MOWING, BUCKET, GROUND"
//     selectedTypes = typeFromApi
//         .split(',')
//         .map((e) => e.trim()) // removes extra spaces
//         .toList();
//     //------------------
//    // selectedAssignForman = item?.contractor ?? '';
//   }
  void setData() {
    setState(() {
      ///  Year
      selectedyear = nextMaintYearList.contains(getYearOrNA(item?.nextMaintDue))
          ? getYearOrNA(item?.nextMaintDue)
          : null;

      ///  Substation
      selectedSubstationId = getSafeValue(
        item?.subId?.toString(),
        subStationList,
        "subId",
      );

      ///  Substation Name (ONLY if ID valid)
      if (selectedSubstationId != null) {
        final sub = subStationList.firstWhere(
          (e) => e["subId"].toString() == selectedSubstationId,
        );
        selectedSubstation = sub["subStation"].toString();
      } else {
        selectedSubstation = null;
      }

      ///  Feeder
      String? feederName = getFeederName(item?.fdrName ?? '');

      selectedFeeder = getSafeValue(
        feederName,
        feederList,
        "fdrName",
      );

      ///  Feeder ID
      if (selectedFeeder != null) {
        final feeder = feederList.firstWhere(
          (e) => e["fdrName"].toString() == selectedFeeder,
        );
        feederId = feeder["fdrId"];
      } else {
        feederId = 0;
      }

      ///  Contractor
      contractorCompany = getSafeValue(
        item?.contractorCompany,
        contractorCompanyList,
        "contractorComapany",
      );

      ///  Foreman
      selectedAssignForman = getSafeValue(
        item?.contractor,
        assignForemanList,
        "name",
      );

      if (selectedAssignForman != null) {
        final foreman = assignForemanList.firstWhere(
          (e) => e["name"].toString() == selectedAssignForman,
        );
        assignFormanId = foreman["loginId"];
      } else {
        assignFormanId = 0;
      }

      ///  Other fields
      maintenanceType = item?.type;
      _totalMiles.text = item?.totalMiles ?? '';

      ///  Multi-select types
      String typeFromApi = item?.type ?? '';
      selectedTypes = typeFromApi.split(',').map((e) => e.trim()).toList();
    });
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
        "TokenNo": widget.tokenNo,
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

  void getInitData() {
    setState(() {});
  }

  //////////////////////////image code////////////////////////
  Widget _buildImageGrid() {
    int length = imageViewModel.imageData.data?.images?.length ?? 0;

    if (length == 0) {
      return const Center(
        child: Text(
          "No images found",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemBuilder: (context, index) {
        String? fileLocation =
            imageViewModel.imageData.data?.images?[index].imageLocation;

        if (fileLocation == null) return const SizedBox();

        bool isVideo(String file) {
          return file.endsWith('.mp4') || file.endsWith('.mov');
        }

        return Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
          child: Stack(
            children: [
              /// PDF
              if (isPDF(fileLocation))
                Center(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => PDFViewer(
                            pdfUrl:
                                'https://pemccivm.ariespro.com/assets/clientuploads/$fileLocation',
                          ),
                        ),
                      );
                    },
                    child: Image.asset('assets/pdflogo.jpg', height: 80),
                  ),
                )

              /// VIDEO
              else if (isVideo(fileLocation))
                InkWell(
                  onTap: () => openFullSizeVideoDialog(fileLocation),
                  child: VideoPlayerWidget(
                    videoUrl:
                        'https://pemccivm.ariespro.com/assets/clientuploads/$fileLocation',
                  ),
                )

              /// IMAGE
              else
                InkWell(
                  onTap: () => openFullSizeImageDialog(fileLocation),
                  child: Image.network(
                    'https://pemccivm.ariespro.com/assets/clientuploads/$fileLocation',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),

              /// ACTION BUTTONS
              Positioned(
                top: 5,
                left: 5,
                child: InkWell(
                  onTap: () {
                    downloadFile(
                      'https://pemccivm.ariespro.com/assets/clientuploads/$fileLocation',
                      'File',
                    );
                  },
                  child: const Icon(
                    Icons.download,
                    color: Colors.blue,
                    size: 18,
                  ),
                ),
              ),

              Positioned(
                top: 5,
                right: 5,
                child: InkWell(
                  onTap: () {
                    deleteOnlineImageApi2(fileLocation, widget.tokenNo);
                  },
                  child: const Icon(Icons.delete, color: Colors.red, size: 18),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future openDialogPicture(String tokenNo) => showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
              int length = imageViewModel.imageData.data?.images?.length ?? 0;

              return AlertDialog(
                content: Container(
                  width: MediaQuery.of(context).size.width * 0.99,
                  padding: const EdgeInsets.only(top: 8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        if (length == 0)
                          const Center(
                            child: Text(
                              "No image found!",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: const Color.fromARGB(255, 7, 59, 120),
                              ),
                            ),
                          )
                        else
                          for (int i = 0; i < length; i += 2)
                            Row(
                              children: [
                                if (i < length) ...[
                                  buildImageWidget(i, tokenNo.toString()),
                                ],
                                if (i + 1 < length) ...[
                                  // const SizedBox(width: 8),
                                  buildImageWidget(i + 1, tokenNo.toString()),
                                ],
                              ],
                            ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      );
  Widget buildImageWidget(int i, String tokenNo) {
    String? fileLocation =
        imageViewModel.imageData.data?.images![i].imageLocation;

    bool isVideo(String file) {
      return file.endsWith('.mp4') || file.endsWith('.mov');
    }

    return Expanded(
      child: (fileLocation != null)
          ? Container(
              //  margin: const EdgeInsets.only(top:8, bottom:8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 2),
              ),
              child: Stack(
                children: [
                  if (isPDF(fileLocation))
                    Center(
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) => PDFViewer(
                                pdfUrl:
                                    'https://pemccivm.ariespro.com/assets/clientuploads/$fileLocation',
                              ),
                            ),
                          );
                        },
                        child: Image.asset(
                          'assets/pdflogo.jpg',
                          height: 150,
                          width: 150,
                        ),
                      ),
                    )
                  else if (isVideo(fileLocation))
                    InkWell(
                      onTap: () {
                        openFullSizeVideoDialog(fileLocation);
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                          5,
                        ), // Optional rounded corners
                        child: SizedBox(
                          height: 150,
                          width: double.infinity,
                          child: VideoPlayerWidget(
                            videoUrl:
                                'https://pemccivm.ariespro.com/assets/clientuploads/$fileLocation',
                          ),
                        ),
                      ),
                    )
                  else
                    InkWell(
                      onTap: () {
                        openFullSizeImageDialog(fileLocation);
                      },
                      child: Image.network(
                        'https://pemccivm.ariespro.com/assets/clientuploads/$fileLocation',
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            if (!isPDF(fileLocation)) {
                              downloadFile(
                                'https://pemccivm.ariespro.com/assets/clientuploads/$fileLocation',
                                'File',
                              );
                              Navigator.pop(context);
                            } else {
                              downloadFile(
                                'https://pemccivm.ariespro.com/assets/clientuploads/$fileLocation',
                                'PDF',
                              );
                              Navigator.pop(context);
                            }
                          },
                          child: const Icon(
                            Icons.download,
                            color: Colors.blue,
                            size: 20,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            deleteOnlineImageApi2(fileLocation, tokenNo);
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.delete,
                            color: Colors.red,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          : const Center(
              child: Text(
                "NO IMAGE",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 7, 59, 120),
                ),
              ),
            ),
    );
  }

  bool isPDF(String fileLocation) {
    return fileLocation.toLowerCase().endsWith('.pdf');
  }

  void openFullSizeVideoDialog(String videoUrl) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: EdgeInsets.zero,
          child: FullScreenVideoPlayer(videoUrl: videoUrl),
        );
      },
    );
  }

  void openFullSizeImageDialog(String imageUrl) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: EdgeInsets.zero,
          child: Stack(
            children: [
              PhotoViewGallery(
                pageController: PageController(),
                backgroundDecoration: const BoxDecoration(color: Colors.black),
                onPageChanged: (index) {},
                scrollPhysics: const BouncingScrollPhysics(),
                pageOptions: [
                  PhotoViewGalleryPageOptions(
                    imageProvider: NetworkImage(
                      'https://pemccivm.ariespro.com/assets/clientuploads/$imageUrl',
                    ),
                    minScale: PhotoViewComputedScale.contained * 0.5,
                    maxScale: PhotoViewComputedScale.covered * 0.5,
                  ),
                ],
              ),
              Positioned(
                top: 30,
                right: 20,
                child: IconButton(
                  icon: const Icon(Icons.close, color: Colors.white, size: 30),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> downloadFile(String fileUrl, String fileType) async {
    final response = await http.get(Uri.parse(fileUrl));
    if (response.statusCode == 200) {
      final appDir = await getApplicationDocumentsDirectory();
      final fileName = fileUrl.split('/').last;
      final file = File('${appDir.path}/$fileName');
      await file.writeAsBytes(response.bodyBytes);
      print('$fileType downloaded to: ${file.path}');
      CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
        '$fileType Downloaded',
        context,
      );
    } else {
      print(
        'Failed to download $fileType. Status code: ${response.statusCode}',
      );
    }
  }

  Future<void> deleteOnlineImageApi2(String fileName, String tokenNo) async {
    final apiUrl =
        '${AppUrl.baseUrl}changeOrderLcpCreateOrder/deleteFile?fileName=$fileName&tokenNo=$tokenNo';
    print(apiUrl);
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();

    try {
      final response = await http.delete(
        Uri.parse(apiUrl),
        headers: {"Authorization": 'Bearer ${data.token!}'},
      );

      if (response.statusCode == 200) {
        print('API response: ${response.body}');
        setState(() {});
        print('Image deleted successfully');
        CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
          'Image deleted Successfully',
          context,
        );
        // Navigator.pop(context);
        await Future.delayed(const Duration(seconds: 2));

        myFuture = Future.wait([
          fetchDetails(context),
          imageViewModel.fetchImageApi(context, widget.tokenNo),
        ]);
      } else {
        print('API request failed with status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  /////////////////////////////////////////////////////
}
