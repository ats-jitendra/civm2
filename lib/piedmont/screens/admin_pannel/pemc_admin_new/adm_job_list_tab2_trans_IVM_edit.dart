import 'dart:convert';
import 'dart:io';
import 'package:CIVM/piedmont/models/transmission_ivm_inprogress_model.dart';
import 'package:CIVM/piedmont/resources/app_colors.dart';
import 'package:CIVM/piedmont/resources/app_url.dart';
import 'package:CIVM/piedmont/screens/admin_pannel/row_maintenance_view/add_new_row_table.dart';

import 'package:CIVM/piedmont/utils/common_functions.dart';
import 'package:CIVM/piedmont/utils/custom_toast_snackbar_progressdialog.dart';
import 'package:CIVM/utils/user_pref.dart';
import 'package:CIVM/models/user_model.dart';
// import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import 'package:provider/provider.dart';

import 'package:http/http.dart' as http;
import 'package:file_selector/file_selector.dart';

// ignore: must_be_immutable
class AdmJobListtransIVMEdit extends StatefulWidget {
  String tokenNo;

  AdmJobListtransIVMEdit({
    Key? key,
    required this.tokenNo,
    // required this.tokenNo,
  }) : super(key: key);

  @override
  State<AdmJobListtransIVMEdit> createState() => _AdmJobListtransIVMEditState();
}

class _AdmJobListtransIVMEditState extends State<AdmJobListtransIVMEdit> {
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

  // ignore: prefer_typing_uninitialized_variables
  var deleteImage1;
  // ignore: prefer_typing_uninitialized_variables
  var deleteImage2;
  // ignore: prefer_typing_uninitialized_variables
  var deleteImage3;
  String imagePath = '';
  String imagePath2 = '';
  String imagePath3 = '';
  File? image1;
  File? image2;
  File? image3;

  File? image;
  List<String> imagePaths = [];
  List<XFile> images = [];

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
  List<dynamic> transNameList = [];
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
  var selectedTransmissionName;
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
  @override
  void initState() {
    fetchDetails(context);
    super.initState();
    _contractRowYear.text = DateFormat("yyyy").format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Transmission IVM',
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
                    await fetchDetails(context);
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
                              // headerWidget("TRABSMISSION IVM"),

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
                                          "TRANSMISSION NAME*",
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
                                          value: getSafeValue(
                                            selectedTransmissionName,
                                            transNameList,
                                            "transmissionName",
                                          ),
                                          // selectedTransmissionName,
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
                                          items: transNameList.map((e) {
                                            return DropdownMenuItem(
                                              value: e["transmissionName"]
                                                  .toString(),
                                              child: Text(
                                                e["transmissionName"]
                                                    .toString(),
                                              ),
                                            );
                                          }).toList(),
                                          onChanged: (val) {
                                            setState(() {
                                              /// Store substationId
                                              selectedTransmissionName = val;
                                            });

                                            getMaintenanceDropdownData(
                                              "$selectedyear",
                                              "$selectedTransmissionName",
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
                              // Padding(
                              //       padding: const EdgeInsets.only(
                              //           left: 2.0,
                              //           right: 2.0,
                              //           bottom: 2.0,
                              //           top: 10.0),
                              //       child: Column(
                              //         children: [
                              //           const Align(
                              //               alignment: Alignment.centerLeft,
                              //               child: Text(
                              //                 "MAINT TYPE*",
                              //                 style: TextStyle(
                              //                     fontSize: 16,
                              //                     color: AppColors.baseColor,
                              //                     fontWeight: FontWeight.bold),
                              //               )),
                              //           Align(
                              //             alignment: Alignment.centerLeft,
                              //             child: Padding(
                              //               padding: const EdgeInsets.all(2.0),
                              //               child: DropdownButtonFormField<String>(
                              //                 hint: const Text('-Select-'),
                              //                 dropdownColor: Colors.white,
                              //                 value: selectedMainttype,
                              //                 style: const TextStyle(
                              //                     color: AppColors.baseColor,
                              //                     fontSize: 16),
                              //                 icon: const Icon(
                              //                   Icons.arrow_drop_down,
                              //                   color: AppColors.baseColor,
                              //                   size: 40,
                              //                 ),
                              //                 decoration: const InputDecoration(
                              //                   enabledBorder: OutlineInputBorder(
                              //                     borderSide: BorderSide(
                              //                       color: AppColors.baseColor,
                              //                     ),
                              //                   ),
                              //                   focusedBorder: OutlineInputBorder(
                              //                     borderSide: BorderSide(
                              //                       color: AppColors.baseColor,
                              //                     ),
                              //                   ),
                              //                 ),
                              //                 isExpanded: true,
                              //                 items: maintTypeList.map((e) {
                              //                   return DropdownMenuItem(
                              //                     value: e["maintType"].toString(),
                              //                     child: Text(
                              //                       e["maintType"].toString(),
                              //                     ),
                              //                   );
                              //                 }).toList(),
                              //                 onChanged: (val) {
                              //                   setState(() {
                              //                     selectedMainttype = val;
                              //                   });
                              //                 },
                              //                 validator: (value) => value == null
                              //                     ? 'field required'
                              //                     : null,
                              //               ),
                              //             ),
                              //           ),
                              //         ],
                              //       ),
                              //     ),

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
                                          value: getSafeValue(
                                            contractorCompany,
                                            contractorCompanyList,
                                            "contractorComapany",
                                          ),
                                          //contractorCompany,
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
                                              "$selectedTransmissionName",
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
                              // Visibility(
                              //   visible: _isVisibleAssignForeman,
                              //   child: Padding(
                              //     padding: const EdgeInsets.only(
                              //         left: 2.0,
                              //         right: 2.0,
                              //         bottom: 2.0,
                              //         top: 10.0),
                              //     child: Column(
                              //       children: [
                              //         const Align(
                              //           alignment: Alignment.centerLeft,
                              //           child: Text(
                              //             "ASSIGN FOREMAN*",
                              //             style: TextStyle(
                              //               fontSize: 16,
                              //               color: AppColors.baseColor,
                              //               fontWeight: FontWeight.bold,
                              //             ),
                              //           ),
                              //         ),
                              //         Align(
                              //           alignment: Alignment.centerLeft,
                              //           child: Padding(
                              //             padding: const EdgeInsets.all(2.0),
                              //             child:
                              //                 DropdownButtonFormField<String>(
                              //               hint: const Text('-Select-'),
                              //               dropdownColor: Colors.white,
                              //               value: getSafeValue(
                              //                 selectedAssignForman,
                              //                 assignForemanList,
                              //                 "name",
                              //               ),
                              //               //selectedAssignForman,
                              //               style: const TextStyle(
                              //                 color: AppColors.baseColor,
                              //                 fontSize: 16,
                              //               ),
                              //               icon: const Icon(
                              //                 Icons.arrow_drop_down,
                              //                 color: AppColors.baseColor,
                              //                 size: 40,
                              //               ),
                              //               decoration: const InputDecoration(
                              //                 enabledBorder: OutlineInputBorder(
                              //                   borderSide: BorderSide(
                              //                     color: AppColors.baseColor,
                              //                   ),
                              //                 ),
                              //                 focusedBorder: OutlineInputBorder(
                              //                   borderSide: BorderSide(
                              //                     color: AppColors.baseColor,
                              //                   ),
                              //                 ),
                              //               ),
                              //               isExpanded: true,

                              //               /// getAllContractorList from API
                              //               items: assignForemanList.map((e) {
                              //                 return DropdownMenuItem(
                              //                   value: e["name"].toString(),
                              //                   child: Text(
                              //                     e["name"].toString(),
                              //                   ),
                              //                 );
                              //               }).toList(),

                              //               onChanged: (val) {
                              //                 setState(() {
                              //                   selectedAssignForman = val;
                              //                 });

                              //                 // Find selected item from list
                              //                 final selectedItem =
                              //                     assignForemanList.firstWhere(
                              //                   (element) =>
                              //                       element["name"]
                              //                           .toString() ==
                              //                       val,
                              //                 );
                              //                 assignFormanId =
                              //                     selectedItem["loginId"];

                              //                 print(
                              //                     "Selected Assign Foreman => ${selectedItem["name"]}");
                              //                 print(
                              //                     "Selected loginId => $assignFormanId");
                              //               },

                              //               validator: (value) => value == null
                              //                   ? 'field required'
                              //                   : null,
                              //             ),
                              //           ),
                              //         ),
                              //       ],
                              //     ),
                              //   ),
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

  IconData getFileTypeIcon(String filePath) {
    if (filePath.endsWith('.pdf')) {
      return Icons.picture_as_pdf;
    } else if (filePath.endsWith('.doc') || filePath.endsWith('.docx')) {
      return Icons.description;
    } else {
      return Icons.insert_drive_file;
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
        "${AppUrl.findClosedPendingPageData}?status=PENDING&budgetType=Transmission maintenance&maintType=RegularMaint&panel=supervisor&planType=IVM Transmission Plan&contractorCompany=PEMC&year=2026&tokenNo=${widget.tokenNo}";

    print('fetchDetails urltab2 $url');

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
            getYearOrNA(item?.nextMaintDue),
            item?.transmissionName ?? '',
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
    return input.split('(')[0].replaceAll('.', '').trim();
  }

  String id = '';
  List<String> selectedTypes = [];

  Future<void> getMaintenanceDropdownData(
    String nextMaintYear,
    String transName,
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
          "${AppUrl.baseUrl}supervisorJobList/getTransmissionIVMJobListEditFormData?yearList=$nextMaintYear&transmissionNameList=$transName&contractorCampany=$conctractorComp";
      print('getMaintenanceDropdownData tab2apiUrl $apiUrl');
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
          // /// NEXT MAINT YEAR
          // nextMaintYearList = jsonData["next_maint_due_year"] ?? [];
          final rawYearList = jsonData["next_maint_due_year"] ?? [];

          nextMaintYearList = rawYearList
              .map<String>((e) => e["next_maint_due"].toString())
              .toList();
          print('nextMaintYearListnew $nextMaintYearList');

          /// SUBSTATION
          transNameList = jsonData["transmissionNames"] ?? [];

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
          if (assignForemanList.isNotEmpty) {
            selectedAssignForman = assignForemanList[0]["name"].toString();

            assignFormanId = assignForemanList[0]["loginId"];
          }
          // final rawAssignForemanList = jsonData["getAllContractorList"] ?? [];

          // assignForemanList = rawAssignForemanList
          //     .map<String>((e) => e["name"].toString())
          //     .toList();
          // print('assignForemanListnew $assignForemanList');
          var totalMiles = jsonData["miles"] ?? 0.0;
          _totalMiles.text = totalMiles.toString();

          /// SET DEFAULT VALUES INITIALLY

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
          if (showLoader == false) {
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

  void setData() {
    setState(() {});

    ///  Year
    selectedyear = nextMaintYearList.contains(getYearOrNA(item?.nextMaintDue))
        ? getYearOrNA(item?.nextMaintDue)
        : null;
    print('selectedyear1111 ${selectedyear}');
// Transmission
    selectedTransmissionName = getSafeValue(
      item?.transmissionName,
      transNameList,
      "transmissionName",
    );
    // selectedTransmissionName = item?.transmissionName;

    maintenanceType = item?.type;
    print('update ${maintenanceType}');

    _totalMiles.text = item?.totalMiles ?? '';

    // // selectedAssignForman = item?.contractor ?? '';
    // ///  Foreman
    // selectedAssignForman = getSafeValue(
    //   item?.contractor,
    //   assignForemanList,
    //   "name",
    // );

    // if (selectedAssignForman != null) {
    //   final foreman = assignForemanList.firstWhere(
    //     (e) => e["name"].toString() == selectedAssignForman,
    //   );
    //   assignFormanId = foreman["loginId"];
    // } else {
    //   assignFormanId = 0;
    // }

    ///  Contractor
    contractorCompany = getSafeValue(
      item?.contractorCompany,
      contractorCompanyList,
      "contractorComapany",
    );
    //contractorCompany = item?.contractorCompany ?? '';
//--------------------------
    String typeFromApi = item?.type ?? '';
// "JARRAFF, MOWING, BUCKET, GROUND"

    selectedTypes = typeFromApi
        .split(',')
        .map((e) => e.trim()) // removes extra spaces
        .toList();
//-----------------------------------------
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
        "Supervisor": "",
        "Contractor": "",
        "Crew": "",
        "MaintType": "RegularMaint",
        // selectedMainttype,
        "District": "",
        "County": "",
        "Substation": "",
        "Feeder": "",
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
        "VisibilityFlag": "2",
        "CrewNotes": "",
        "TransmissionName": selectedTransmissionName
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

      printWrapped("whole map data ${jsonEncode(body)}");
      print("Status Code => ${response.statusCode}");
      print("Response => ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        setState(() {
          isSubmitLoading = false;
        });
        CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
            'Successfully Submitted', context);
        await Future.delayed(const Duration(seconds: 2));
        if (mounted) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) =>
                  AdminAddNewRowTable(index: '1')));
        }
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
}
