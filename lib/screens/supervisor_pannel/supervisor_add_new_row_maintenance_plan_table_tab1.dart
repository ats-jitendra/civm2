import 'package:CIVM/models/add_new_row_maint_model.dart';
import 'package:CIVM/models/user_model.dart';
import 'package:CIVM/screens/login_page.dart';
import 'package:CIVM/screens/my_chrome_safari_map_recording.dart';
import 'package:CIVM/screens/supervisor_pannel/supervisor_add_new_row_maintenance_plan_table_tab1_detail_screen.dart';
import 'package:CIVM/utils/common_functions.dart';
import 'package:CIVM/utils/user_pref.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../data/response/status.dart';
import '../../../view_model/add_new_row_maintenance_plan_view_model.dart';

import 'package:CIVM/models/add_new_row_tabular_data.dart';

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:CIVM/resources/app_url.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// import 'package:flutter_sms/flutter_sms.dart';
// import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class SupervisorAddNewRowMaintenancePlanTableTab1 extends StatefulWidget {
  String? budgetType;
  String? year;
  SupervisorAddNewRowMaintenancePlanTableTab1({
    super.key,
    this.budgetType,
    required this.year,
  });

  @override
  State<SupervisorAddNewRowMaintenancePlanTableTab1> createState() =>
      _SupervisorAddNewRowMaintenancePlanTableTab1State();
}

class _SupervisorAddNewRowMaintenancePlanTableTab1State
    extends State<SupervisorAddNewRowMaintenancePlanTableTab1> {
  // int _currentIndex = 0;

  AddNewRowMaintModel? addNewRowMaintModel;

  // final List<Widget> _children = [
  //   RowMaintenancePlan(),
  //   // BottomNavigationHomePage(),
  //   // BottomNavigationAccountPage()
  // ];
  List<String> menu = [];

  List<Map<String, dynamic>> listOfColumns = [];
  List<Map<String, dynamic>> listOfColumns1 = [];

  var result = [];

  final TextEditingController _input = TextEditingController();

  // ignore: non_constant_identifier_names
  final select_contractorCompany = ['LCP', 'ZIELIES'];
  String? contractorCompany;

  // ignore: non_constant_identifier_names
  final select_assignForman = ['LCP', 'ZIELIES'];
  String? assignForman;
  // ignore: non_constant_identifier_names
  final select_street = ['-NA-', ''];
  String? street;
  // ignore: non_constant_identifier_names
  // final select_MaintenanceType = [
  //   'Herbicides',
  //   'Mechenical Clearing',
  //   'Mechenical Puring',
  //   'Ariel Puring',
  //   'Pruning',
  //   'Mechenical Tree Removal',
  // ];
  // // ignore: non_constant_identifier_names
  // String? MaintenanceType;
  // final _formkey = GlobalKey<FormState>();
  List countyList = [];
  List substationList = [];
  List feederList = [];
  // ignore: prefer_typing_uninitialized_variables
  var selectedSubstation;
  // ignore: prefer_typing_uninitialized_variables
  var selectedCounty;
  // ignore: prefer_typing_uninitialized_variables
  var selectedFeeder;

  // ignore: non_constant_identifier_names
  List<String> select_maintenanceType = [
    'Herbicides',
    'Mechenical Clearing',
    'Mechenical Puring',
    'Ariel Puring',
    'Pruning',
    'Mechenical Tree Removal',
  ];
  String? maintenanceType;

  onTappedBar(int index) {
    setState(() {
      // _currentIndex = index;
    });
  }

  String now = DateFormat("yyyy-MM-dd hh:mm:ss").format(DateTime.now());

  AddNewRowMaintenancePlanViewModel addNewRowMaintenancePlanViewModel =
      AddNewRowMaintenancePlanViewModel();

  final browser = MyChromeSafariBrowser();

  int currentYear = DateTime.now().year;
  // ignore: prefer_typing_uninitialized_variables
  var selectedYear;

  List<GetAlls> allData = [];
  List<GetAlls> filteredList = [];

  @override
  void initState() {
    selectedYear = (widget.year != '') ? widget.year : currentYear.toString();
    // currentYear.toString();
    addNewRowMaintenancePlanViewModel
        .fetchAddNewRowMaintenancePlanTabularListApi(
          context,
          selectedYear,
          widget.budgetType.toString(),
        );
    _initializeScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: ChangeNotifierProvider<AddNewRowMaintenancePlanViewModel>(
        create: (BuildContext context) => addNewRowMaintenancePlanViewModel,
        child: Consumer<AddNewRowMaintenancePlanViewModel>(
          builder: (context, value, _) {
            switch (value.addNewRowMaintenancePlanGetTabularData.status) {
              case Status.LOADING:
                return const Center(child: CircularProgressIndicator());
              case Status.ERROR:
                return
                // CustomToastSnackBarProgressDialog.flushBarErrorMessage(
                //     value.addNewRowMaintenancePlanGetTabularData.message
                //         .toString(),
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
                if (allData.isEmpty) {
                  allData = List.from(
                    value.addNewRowMaintenancePlanGetTabularData.data!.getAlls!,
                  );

                  filteredList = List.from(allData);
                }
                return RefreshIndicator(
                  onRefresh: () async {
                    _input.clear();
                    // selectedYear = currentYear.toString();
                    allData.clear();
                    filteredList.clear();
                    await addNewRowMaintenancePlanViewModel
                        .fetchAddNewRowMaintenancePlanTabularListApi(
                          context,
                          // currentYear.toString(),
                          selectedYear,
                          widget.budgetType.toString(),
                        );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      alignment: Alignment.center,
                      height: size.height * 1,
                      width: size.width * 0.99,
                      decoration: const BoxDecoration(
                        // shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(255, 7, 59, 120),
                            blurRadius: 10,
                            offset: Offset(2.0, 5.0),
                          ),
                        ],
                        gradient: LinearGradient(
                          colors: [
                            Color.fromARGB(255, 255, 255, 255),
                            Color.fromARGB(255, 255, 255, 255),
                          ],
                        ),
                      ),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: DropdownButtonFormField<String>(
                                hint: const Text('-Select Year-'),
                                dropdownColor: Colors.white,
                                value: selectedYear,
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
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color.fromARGB(255, 7, 59, 120),
                                    ),
                                  ),
                                ),
                                isExpanded: true,
                                items: addNewRowMaintenancePlanViewModel
                                    .addNewRowMaintenancePlanGetTabularData
                                    .data!
                                    .yearList!
                                    .map((e) {
                                      return DropdownMenuItem(
                                        value: e.year.toString(),
                                        child: Text(e.year.toString()),
                                      );
                                    })
                                    .toList(),
                                onChanged: (val) {
                                  setState(() {
                                    selectedYear = val;
                                  });
                                  allData.clear();
                                  filteredList.clear();
                                  addNewRowMaintenancePlanViewModel
                                      .fetchAddNewRowMaintenancePlanTabularListApi(
                                        context,
                                        selectedYear,
                                        widget.budgetType.toString(),
                                      );
                                        _initializeScreen();
                                },
                                validator: (value) =>
                                    value == null ? 'field required' : null,
                              ),
                            ),
                          ),
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
                                      color: Color.fromARGB(255, 7, 59, 120),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  filteredList.length.toString(),
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
                          Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 4.0,
                                right: 4.0,
                                top: 4,
                                bottom: 4,
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
                                  border: OutlineInputBorder(),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color.fromARGB(255, 23, 1, 88),
                                    ),
                                  ),
                                  hintText:
                                      'Search by Substation/Feeder/Job No/Master Job No',
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
                            child: Align(
                              alignment: Alignment.center,
                              child: ListView.builder(
                                physics: const AlwaysScrollableScrollPhysics(),
                                itemCount: filteredList.length,
                                itemBuilder: (BuildContext ctxt, int index) {
                                  var item = filteredList[index];
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 6,
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) =>
                                                SupervisorAddNewRowMaintenancePlanDetailsScreen(
                                                  tokenNo: item.tokenNo
                                                      .toString(),
                                                  year: item.nextMaintDue
                                                      .toString(),
                                                ),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: getCardColor(item.status),
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withOpacity(
                                                0.2,
                                              ),
                                              blurRadius: 6,
                                              offset: const Offset(2, 4),
                                            ),
                                          ],
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(12),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              /// 🔹 TOP ROW (Job No + Status Badge)
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "JOB NO: ${item.tokenNo}",
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                    ),
                                                  ),

                                                  /// STATUS BADGE
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.symmetric(
                                                          horizontal: 10,
                                                          vertical: 4,
                                                        ),
                                                    decoration: BoxDecoration(
                                                      color: getStatusColor(
                                                        item.status,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            20,
                                                          ),
                                                    ),
                                                    child: Text(
                                                      item.status ?? "",
                                                      style: const TextStyle(
                                                        fontSize: 11,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),

                                              const SizedBox(height: 10),
                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons.numbers,
                                                    size: 16,
                                                    color: Colors.black,
                                                  ),
                                                  const SizedBox(width: 6),
                                                  Expanded(
                                                    child: Text(
                                                      "MASTER JOB NO. : ${(item.masterJobNo == null || item.masterJobNo.toString().trim().isEmpty || item.masterJobNo.toString().trim().toLowerCase() == 'null' || item.masterJobNo.toString().trim().toUpperCase() == 'N/A') ? '' : item.masterJobNo.toString()}",
                                                      style: const TextStyle(
                                                        fontSize: 13,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 4),

                                              ///  SUBSTATION ROW
                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons.location_on,
                                                    size: 16,
                                                    color: Colors.black,
                                                  ),
                                                  const SizedBox(width: 6),
                                                  Expanded(
                                                    child: Text(
                                                      "SUBSTATION : ${item.substation ?? ""}",
                                                      style: const TextStyle(
                                                        fontSize: 13,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 4),

                                              ///  FEEDER ROW
                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons.work,
                                                    size: 16,
                                                    color: Colors.black,
                                                  ),
                                                  const SizedBox(width: 6),
                                                  Expanded(
                                                    child: Text(
                                                      "FEEDER : ${item.feeder ?? ""}",
                                                      style: const TextStyle(
                                                        fontSize: 13,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 4),

                                              ///  TYPE ROW
                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons.build,
                                                    size: 16,
                                                    color: Colors.black,
                                                  ),
                                                  const SizedBox(width: 6),
                                                  Expanded(
                                                    child: Text(
                                                      "TYPE : ${item.maintType ?? ""}",
                                                      style: const TextStyle(
                                                        fontSize: 13,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),

                                              const SizedBox(height: 8),

                                              ///  DIVIDER
                                              Container(
                                                height: 1,
                                                color: Colors.black12,
                                              ),

                                              const SizedBox(height: 8),

                                              ///  BOTTOM ROW
                                              const Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "View Details",
                                                    style: TextStyle(
                                                      fontSize: 11,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  Icon(
                                                    Icons.arrow_forward_ios,
                                                    size: 14,
                                                    color: Colors.black,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
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
    setState(() {
      if (query.trim().isEmpty) {
        filteredList = List.from(allData);
      } else {
        final q = query.toLowerCase();

        filteredList = allData.where((item) {
          return item.tokenNo.toString().toLowerCase().contains(q) ||
              (item.masterJobNo ?? "").toLowerCase().contains(q) ||
              (item.substation ?? "").toLowerCase().contains(q) ||
              (item.feeder ?? "").toLowerCase().contains(q) ||
              (item.maintType ?? "").toLowerCase().contains(q) ||
              (item.status ?? "").toLowerCase().contains(q);
        }).toList();
      }
    });
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
