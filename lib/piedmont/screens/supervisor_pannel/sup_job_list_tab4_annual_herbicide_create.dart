import 'dart:convert';
import 'dart:io';
import 'package:CIVM/piedmont/resources/app_colors.dart';
import 'package:CIVM/piedmont/resources/app_url.dart';
import 'package:CIVM/piedmont/screens/supervisor_pannel/supervisor_add_new_row_table.dart';
import 'package:CIVM/piedmont/utils/common_functions.dart';
import 'package:CIVM/piedmont/utils/custom_toast_snackbar_progressdialog.dart';
import 'package:CIVM/utils/user_pref.dart';
import 'package:CIVM/models/user_model.dart';
// import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:http/http.dart' as http;
import 'package:file_selector/file_selector.dart';

// ignore: must_be_immutable
class SupJobListAnnualHerbicideCreate extends StatefulWidget {
  // String tokenNo;

  SupJobListAnnualHerbicideCreate({
    Key? key,
    // required this.tokenNo,
  }) : super(key: key);

  @override
  State<SupJobListAnnualHerbicideCreate> createState() =>
      _SupJobListAnnualHerbicideCreateState();
}

class _SupJobListAnnualHerbicideCreateState
    extends State<SupJobListAnnualHerbicideCreate> {
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
  List<dynamic> subStationList = [];
  List<dynamic> feederList = [];
  List<dynamic> officeList = [];
  List<dynamic> typeList = [];
  List<dynamic> budgetTypeList = [];
  List<dynamic> planTypeList = [];
  List<dynamic> contractorCompanyList = [];
  String? contractorCompany;
  String? selectedAssignForman;

  List<dynamic> assignForemanList = [];

  // ignore: prefer_typing_uninitialized_variables
  var selectedSubstation;
  var selectedSubstationName;
  var selectedSubstationId;
  // ignore: prefer_typing_uninitialized_variables
  var selectedFeeder;
  var selectedOffice;
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
    // print('widget.tokenNo ${widget.tokenNo}');
    myFuture = getMaintenanceDropdownData(
      "",
      "",
      showLoader: false,
    );

    super.initState();
    _contractRowYear.text = DateFormat("yyyy").format(DateTime.now());
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
                              headerWidget("ANNUAL HERBICIDE"),

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
                                          "YEAR*",
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
                                  top: 10.0,
                                ),
                                child: Column(
                                  children: [
                                    const Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "SUBSTATION*",
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

                                          /// important
                                          value: selectedSubstation,

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
                                            final substationName =
                                                e["subStation"].toString();

                                            return DropdownMenuItem<String>(
                                              value: substationName,
                                              child: Text(substationName),
                                            );
                                          }).toList(),

                                          onChanged: (val) async {
                                            setState(() {
                                              selectedSubstation = val;
                                            });

                                            print(
                                              "Selected Substation Name => $selectedSubstation",
                                            );

                                            await getMaintenanceDropdownData(
                                              "$selectedyear",
                                              "$selectedSubstation",
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
                                          "OFFICE LIST*",
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
                                          value: selectedOffice,
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
                                          items: officeList.map((e) {
                                            return DropdownMenuItem(
                                              value: e["Office"].toString(),
                                              child: Text(
                                                e["Office"].toString(),
                                              ),
                                            );
                                          }).toList(),
                                          onChanged: (val) {
                                            setState(() {
                                              selectedOffice = val;
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
  String id = '';
  List<String> selectedTypes = [];

  Future<void> getMaintenanceDropdownData(
    String nextMaintYear,
    String substationName, {
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
          "${AppUrl.baseUrl}supervisorJobList/getAnnualHerbicideJobListEditFormData?yearList=$nextMaintYear&SubstationNameList=$substationName";

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
          officeList = jsonData["Office"] ?? [];
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
    final String apiUrl = AppUrl.insertOrUpdateAnnualHerbicideApiEndPoint;
     final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    id = data.user!.id.toString();
    try {
      var body = {
        "Substations": selectedSubstation,
        "Offices": selectedOffice,
        "Year": selectedyear
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
        setState(() {
          isSubmitLoading = false;
        });
        CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
            'Successfully Submitted', context);
        await Future.delayed(const Duration(seconds: 2));
        if (mounted) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) =>
                  SupervisorAddNewRowTable(index: '3')));
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
