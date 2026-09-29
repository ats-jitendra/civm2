import 'dart:convert';
import 'package:CIVM/models/ivm_change_order_count_GF_model.dart';
import 'package:CIVM/models/user_details.dart';
import 'package:CIVM/models/user_model.dart';
import 'package:CIVM/screens/generalForeman_New_pannel/contractor_bottom_navigation.dart';
import 'package:CIVM/resources/app_url.dart';
import 'package:CIVM/screens/generalForeman_New_pannel/gf_change_order_all_status.dart';
import 'package:CIVM/screens/generalForeman_New_pannel/gf_add_crew_member.dart';
import 'package:CIVM/screens/generalForeman_New_pannel/gf_ivm_all_status.dart';
import 'package:CIVM/screens/generalForeman_New_pannel/gf_ivm_rework_failed_status_list.dart';
import 'package:CIVM/screens/generalForeman_New_pannel/gf_maintenance_report_view_new.dart';
import 'package:CIVM/screens/leaflat_map/leaf_lat_map_wakeLock.dart';
import 'package:CIVM/screens/login_page.dart';
import 'package:CIVM/screens/planner_pannel.dart/planner_bottom_navigation.dart';
import 'package:CIVM/utils/common_functions.dart';
import 'package:CIVM/screens/map/provider/location_provider.dart';
import 'package:CIVM/screens/my_chrome_safari_map_recording.dart';
import 'package:CIVM/sharedPrefs/constants.dart';
import 'package:CIVM/utils/user_pref.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../view_model/lcp_view_model.dart';

// ignore: must_be_immutable
class Inspection extends StatefulWidget {
  String year;
  Inspection({super.key, required this.year});

  @override
  State<Inspection> createState() => _InspectionState();
}

class _InspectionState extends State<Inspection> {
  // int _currentIndex = 0;
  // final List<Widget> _children = [
  //   RowMaintenancePlan(),
  //   // BottomNavigationHomePage(),
  //   // BottomNavigationAccountPage()
  // ];
  List<String> menu = [];

  onTappedBar(int index) {
    setState(() {
      // _currentIndex = index;
    });
  }

  LCPViewModel lCPViewModel = LCPViewModel();
  String userTypeText = '';
  String primaryRoleText = '';
  bool _isLoading = false;

  int ivmCount = 0;
  int changeOrderCount = 0;
  String note = '';

  int reworkRejected = 0;
  int lcpInspectionFailed = 0;

  List<String> years = ["2021", "2022", "2023", "2024", "2025", "2026", "2027"];
  String? selectedYear;
  var selectedYearCurrent;
  int currentYear = DateTime.now().year;

  @override
  void initState() {
    selectedYear = selectedYearCurrent = (widget.year != '')
        ? widget.year
        : currentYear.toString();
    super.initState();
    loadInitialData(selectedYearCurrent);
    _initializeScreen();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'IVM/Change Order',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 7, 59, 120),
        actions: [
          InkWell(
            onTap: () {
              _initializeScreen();
              showYearFilterDialog();
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                // width: 75,
                height: kToolbarHeight,
                margin: const EdgeInsets.only(right: 8),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromARGB(255, 17, 69, 129),
                      blurRadius: 10,
                      offset: Offset(2.0, 5.0),
                    ),
                  ],
                  gradient: const LinearGradient(
                    colors: [
                      Color.fromARGB(255, 30, 108, 196),
                      Color.fromARGB(255, 71, 152, 246),
                    ],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8),
                  child: Text(
                    selectedYear ?? '',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      height: 1.0,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      drawer: DrawerManu(menu: menu),
      body: Stack(
        fit: StackFit.expand,
        children: [
          _isLoading
              ? Container(
                  color: Colors.white,
                  child: const Center(child: CircularProgressIndicator()),
                )
              : RefreshIndicator(
                  onRefresh: () async {
                    loadInitialData(selectedYear.toString());
                    _initializeScreen();
                  },
                  displacement: 40,
                  edgeOffset: 10,
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Column(
                        children: [
                          (primaryRoleText != userTypeText)
                              ? Padding(
                                  padding: EdgeInsets.only(top: 8.0, left: 8),
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

                          Container(
                            margin: const EdgeInsets.only(
                              left: 8,
                              right: 8,
                              top: 10,
                              bottom: 8,
                            ),
                            decoration: const BoxDecoration(
                              // shape: BoxShape.circle,
                              borderRadius: BorderRadius.only(
                                // topRight: Radius.circular(50),
                                // bottomLeft: Radius.circular(50)
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromARGB(255, 3, 47, 97),
                                  blurRadius: 5,
                                  offset: Offset(2.0, 5.0),
                                ),
                              ],
                              color: Color.fromARGB(255, 130, 193, 245),
                              gradient: LinearGradient(
                                colors: [
                                  Color.fromARGB(255, 7, 59, 120),
                                  Color.fromARGB(255, 7, 59, 120),
                                ],
                              ),
                            ),
                            child: InkWell(
                              onTap: () async {
                                await Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        GFIvmAllStatus(
                                          budgetType: 'Regular IVM maintenance',
                                          maintenanceType: 'RegularMaint',
                                          heading: 'IVM Maintenance',
                                          year: selectedYear.toString(),
                                        ),
                                  ),
                                );
                                await loadInitialData(selectedYear.toString());
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.white),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color.fromARGB(255, 3, 47, 97),
                                      blurRadius: 10,
                                      offset: Offset(2.0, 5.0),
                                    ),
                                  ],
                                  image: DecorationImage(
                                    image: const AssetImage(
                                      'assets/Dash_3.png',
                                    ),
                                    fit: BoxFit.cover,
                                    colorFilter: ColorFilter.mode(
                                      Colors.black.withOpacity(0.45),
                                      BlendMode.darken,
                                    ),
                                  ),
                                ),
                                margin: const EdgeInsets.only(
                                  left: 8,
                                  right: 8,
                                  top: 10,
                                  bottom: 8,
                                ),
                                padding: const EdgeInsets.all(8),
                                alignment: Alignment.center,
                                height: size.height * 0.15,
                                width: size.width * 0.99,
                                child: Stack(
                                  children: [
                                    Center(
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'IVM Maintenance',
                                            style: TextStyle(
                                              fontSize: 22,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w800,
                                            ),
                                          ),
                                          const SizedBox(width: 40),
                                          Text(
                                            ivmCount.toString(),
                                            style: TextStyle(
                                              fontSize: 30,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w800,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                              left: 8,
                              right: 8,
                              top: 10,
                              bottom: 8,
                            ),
                            decoration: const BoxDecoration(
                              // shape: BoxShape.circle,
                              borderRadius: BorderRadius.only(
                                // topRight: Radius.circular(50),
                                // bottomLeft: Radius.circular(50)
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromARGB(255, 3, 47, 97),
                                  blurRadius: 5,
                                  offset: Offset(2.0, 5.0),
                                ),
                              ],
                              color: Color.fromARGB(255, 130, 193, 245),
                              gradient: LinearGradient(
                                colors: [
                                  Color.fromARGB(255, 7, 59, 120),
                                  Color.fromARGB(255, 7, 59, 120),
                                ],
                              ),
                            ),
                            child: InkWell(
                              onTap: () async {
                                await Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        GFIvmReworkFailedStatus(
                                          budgetType: 'Regular IVM maintenance',
                                          maintenanceType: 'RegularMaint',
                                          heading: 'IVM Maintenance',
                                          status: 'rejected',
                                          year: selectedYear.toString(),
                                        ),
                                  ),
                                );
                                await loadInitialData(selectedYear.toString());
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.white),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color.fromARGB(255, 3, 47, 97),
                                      blurRadius: 10,
                                      offset: Offset(2.0, 5.0),
                                    ),
                                  ],
                                  image: DecorationImage(
                                    image: const AssetImage(
                                      'assets/Dash_3.png',
                                    ),
                                    fit: BoxFit.cover,
                                    colorFilter: ColorFilter.mode(
                                      Colors.black.withOpacity(0.45),
                                      BlendMode.darken,
                                    ),
                                  ),
                                ),
                                margin: const EdgeInsets.only(
                                  left: 8,
                                  right: 8,
                                  top: 10,
                                  bottom: 8,
                                ),
                                padding: const EdgeInsets.all(8),
                                alignment: Alignment.center,
                                height: size.height * 0.15,
                                width: size.width * 0.99,
                                child: Stack(
                                  children: [
                                    Center(
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Failed Inspection List',
                                            style: TextStyle(
                                              fontSize: 22,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w800,
                                            ),
                                          ),
                                          const SizedBox(width: 40),
                                          Text(
                                            lcpInspectionFailed.toString(),
                                            style: TextStyle(
                                              fontSize: 30,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w800,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          Container(
                            margin: const EdgeInsets.only(
                              left: 8,
                              right: 8,
                              top: 10,
                              bottom: 8,
                            ),
                            decoration: const BoxDecoration(
                              // shape: BoxShape.circle,
                              borderRadius: BorderRadius.only(
                                // topRight: Radius.circular(50),
                                // bottomLeft: Radius.circular(50)
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromARGB(255, 3, 47, 97),
                                  blurRadius: 5,
                                  offset: Offset(2.0, 5.0),
                                ),
                              ],
                              color: Color.fromARGB(255, 130, 193, 245),
                              gradient: LinearGradient(
                                colors: [
                                  Color.fromARGB(255, 7, 59, 120),
                                  Color.fromARGB(255, 7, 59, 120),
                                ],
                              ),
                            ),
                            child: InkWell(
                              onTap: () async {
                                await Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        GFIvmReworkFailedStatus(
                                          budgetType: 'Regular IVM maintenance',
                                          maintenanceType: 'RegularMaint',
                                          heading: 'IVM Maintenance',
                                          status: 'rework',
                                          year: selectedYear.toString(),
                                        ),
                                  ),
                                );
                                await loadInitialData(selectedYear.toString());
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.white),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color.fromARGB(255, 3, 47, 97),
                                      blurRadius: 10,
                                      offset: Offset(2.0, 5.0),
                                    ),
                                  ],
                                  image: DecorationImage(
                                    image: const AssetImage(
                                      'assets/Dash_3.png',
                                    ),
                                    fit: BoxFit.cover,
                                    colorFilter: ColorFilter.mode(
                                      Colors.black.withOpacity(0.45),
                                      BlendMode.darken,
                                    ),
                                  ),
                                ),
                                margin: const EdgeInsets.only(
                                  left: 8,
                                  right: 8,
                                  top: 10,
                                  bottom: 8,
                                ),
                                padding: const EdgeInsets.all(8),
                                alignment: Alignment.center,
                                height: size.height * 0.15,
                                width: size.width * 0.99,
                                child: Stack(
                                  children: [
                                    Center(
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Rework List',
                                            style: TextStyle(
                                              fontSize: 22,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w800,
                                            ),
                                          ),
                                          const SizedBox(width: 40),
                                          Text(
                                            reworkRejected.toString(),
                                            style: TextStyle(
                                              fontSize: 30,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w800,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          Container(
                            margin: const EdgeInsets.only(
                              left: 8,
                              right: 8,
                              top: 10,
                              bottom: 8,
                            ),
                            decoration: const BoxDecoration(
                              // shape: BoxShape.circle,
                              borderRadius: BorderRadius.only(
                                // topRight: Radius.circular(50),
                                // bottomLeft: Radius.circular(50)
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromARGB(255, 3, 47, 97),
                                  blurRadius: 5,
                                  offset: Offset(2.0, 5.0),
                                ),
                              ],
                              color: Color.fromARGB(255, 130, 193, 245),
                              gradient: LinearGradient(
                                colors: [
                                  Color.fromARGB(255, 7, 59, 120),
                                  Color.fromARGB(255, 7, 59, 120),
                                ],
                              ),
                            ),
                            child: InkWell(
                              onTap: () async {
                                await Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        GfChangeOrderAllStatus(
                                          year: selectedYear.toString(),
                                        ),
                                  ),
                                );
                                await loadInitialData(selectedYear.toString());
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.white),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color.fromARGB(255, 3, 47, 97),
                                      blurRadius: 10,
                                      offset: Offset(2.0, 5.0),
                                    ),
                                  ],
                                  image: DecorationImage(
                                    image: const AssetImage(
                                      'assets/Dash_1.jpg',
                                    ),
                                    fit: BoxFit.cover,
                                    colorFilter: ColorFilter.mode(
                                      Colors.black.withOpacity(0.45),
                                      BlendMode.darken,
                                    ),
                                  ),
                                ),
                                margin: const EdgeInsets.only(
                                  left: 8,
                                  right: 8,
                                  top: 10,
                                  bottom: 8,
                                ),
                                padding: const EdgeInsets.all(8),
                                alignment: Alignment.center,
                                height: size.height * 0.15,
                                width: size.width * 0.99,
                                child: Stack(
                                  children: [
                                    Center(
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Change Order',
                                            style: TextStyle(
                                              fontSize: 22,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w800,
                                            ),
                                          ),
                                          const SizedBox(width: 40),
                                          Text(
                                            changeOrderCount.toString(),
                                            style: TextStyle(
                                              fontSize: 30,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w800,
                                            ),
                                          ),
                                        ],
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
                ),
        ],
      ),
    );
  }

  Future<void> getUserType() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();

    String userType = pref.getString('userType') ?? '';
    String primaryRole = pref.getString('primaryRole') ?? '';

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

    if (mounted) {}
  }

  Future<void> fetchCounts(String year) async {
    final result = await getIvmAndChangeOrderCount(year);

    if (!mounted) return;

    setState(() {
      ivmCount = result!.ivmCount ?? 0;
      changeOrderCount = result.changeOrderCount ?? 0;
      note = result.note ?? "";
      reworkRejected = result.reworkRejected ?? 0;
      lcpInspectionFailed = result.lcpInspectionFailed ?? 0;
    });
  }

  Future<IvmChangeOrderCountGFModel?> getIvmAndChangeOrderCount(
    String year,
  ) async {
    try {
      final userPreferences = Provider.of<UserPref>(context, listen: false);
      UserModel data = await userPreferences.getUser();
      var url = "${AppUrl.ivmAndChangeOrderCountContractorPanel}?year=$year";

      print('url:: $url');
      final response = await http.get(
        Uri.parse(url),
        headers: {
          "Authorization": "Bearer ${data.token}",
          "Content-Type": "application/json",
        },
      );
      print("Status Code : ${response.statusCode}");
      print("Response : ${response.body}");

      if (response.statusCode == 200) {
        return IvmChangeOrderCountGFModel.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      print(e);
    }

    return null;
  }

  Future<void> loadInitialData(String year) async {
    ivmCount = 0;
    changeOrderCount = 0;
    reworkRejected = 0;
    lcpInspectionFailed = 0;

    setState(() {
      _isLoading = true;
    });

    await Future.wait([fetchCounts(year), getUserType()]);

    if (!mounted) return;

    setState(() {
      _isLoading = false;
    });
  }

  void showYearFilterDialog() {
    final String currentYear = DateTime.now().year.toString();

    if (selectedYear == null || !years.contains(selectedYear)) {
      selectedYear = years.contains(currentYear) ? currentYear : null;
    }
    String? tempSelectedYear = selectedYear;
    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (dialogContext, setDialogState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),

              title: const Text(
                "Filter",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),

              content: DropdownButtonFormField<String>(
                value: years.contains(tempSelectedYear)
                    ? tempSelectedYear
                    : null,

                isExpanded: true,

                decoration: InputDecoration(
                  labelText: "Select Year",
                  prefixIcon: const Icon(Icons.calendar_today_rounded),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 14,
                  ),
                ),

                items: years.map((year) {
                  return DropdownMenuItem<String>(
                    value: year,
                    child: Text(year),
                  );
                }).toList(),

                onChanged: (value) {
                  setDialogState(() {
                    tempSelectedYear = value;
                  });
                },
              ),

              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(dialogContext);
                  },
                  child: const Text("Cancel"),
                ),

                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectedYear = tempSelectedYear;
                    });

                    Navigator.pop(dialogContext);

                    print("Selected Year: $selectedYear");

                    loadInitialData(selectedYear.toString());
                  },
                  child: const Text("Search"),
                ),
              ],
            );
          },
        );
      },
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

  //----
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
  bool isDrawerLoading = true;

  @override
  void initState() {
    setUserName();
    _loadData();
    super.initState();
  }

  Future<void> _loadData() async {
    await setUserName();
    await getUserDetailsByUsername();

    setState(() {
      isDrawerLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final userPreferences = Provider.of<UserPref>(context);
    var provider = Provider.of<LocationProvider>(context, listen: true);
    final browser = MyChromeSafariBrowser();
    if (isDrawerLoading) {
      return const Drawer(child: Center(child: CircularProgressIndicator()));
    }
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
                      Navigator.pop(context);
                    },
                  ),
                  //  ListTile(
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
                  //       //   Navigator.push(
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
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const GFAddCrewMember(),
                        ),
                      );
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
    setState(() {
      userName = '${data.user!.fName} ${data.user!.lName}';
    });
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

      // Any other error
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
