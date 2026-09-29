import 'dart:async';
import 'dart:io';
import 'package:CIVM/models/crewChangeOrderListModel.dart';
import 'package:CIVM/models/ivmMaintenance_table_model.dart';
import 'package:CIVM/models/user_model.dart';
import 'package:CIVM/resources/app_url.dart';
import 'package:CIVM/screens/crew_pannel/change_order_records.dart';
// import 'package:CIVM/screens/crew_pannel/crew_ivm_maintenance_progress_old.dart';
// import 'package:CIVM/screens/crew_pannel/crew_ivm_maintenance_progress_new.dart';
import 'package:CIVM/screens/crew_pannel/crew_ivm_maintenance_plan_table.dart';
import 'package:CIVM/screens/leaflat_map/leaf_lat_map_wakeLock.dart';
// import 'package:CIVM/screens/crew_pannel/crew_map_view.dart';
import 'package:CIVM/screens/login_page.dart';
import 'package:CIVM/screens/map/provider/location_provider.dart';
import 'package:CIVM/screens/my_chrome_safari_map_recording.dart';
import 'package:CIVM/utils/user_pref.dart';
import 'package:CIVM/view_model/crew_change_order_records_view_model.dart';
import 'package:CIVM/view_model/ivm_maintenance_progress_view_model.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:upgrader/upgrader.dart';

class CrewBottomNavigationHomePage extends StatefulWidget {
  const CrewBottomNavigationHomePage({Key? key}) : super(key: key);

  @override
  State<CrewBottomNavigationHomePage> createState() =>
      _CrewBottomNavigationHomePageState();
}

class _CrewBottomNavigationHomePageState
    extends State<CrewBottomNavigationHomePage> {
  DateTime now = DateTime.now();
  int currentYear = getCurrentYear();
  final browser = MyChromeSafariBrowser();
  CrewChangeOrderRecordsViewModel crewChangeOrderRecordsViewModel =
      CrewChangeOrderRecordsViewModel();
  IVMMaintenancePlanViewModel ivmMiantenanceTableViewModel =
      IVMMaintenancePlanViewModel();
  String id = '';
  int changeOrderLength = 0;
  int iVMLength = 0;
  Timer? _timer;

  List<String> years = ["2021", "2022", "2023", "2024", "2025", "2026", "2027"];
  String? selectedYear;
  var selectedYearCurrent;


  @override
  void initState() {
    selectedYear = selectedYearCurrent = currentYear.toString();
    super.initState();
    getData(selectedYearCurrent);
    // _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
    //   if (mounted) {
    //     getData(selectedYearCurrent);
    //   }
    // });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final userPreferences = Provider.of<UserPref>(context);
    var provider = Provider.of<LocationProvider>(context, listen: true);
    // ignore: deprecated_member_use
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) {
          return;
        }
        showExitPopup(context);
      },
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/vma_bg.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.white),
            title: const Text('CIVM', style: TextStyle(color: Colors.white)),
            backgroundColor: const Color.fromARGB(255, 7, 59, 120),
            actions: [
             
              IconButton(
                icon: const Icon(Icons.logout, color: Colors.white),
                onPressed: () {
                  userPreferences.remove().then((value) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) => const LoginPage(),
                      ),
                    );
                  });
                  // Navigator.of(context).push(MaterialPageRoute(
                  //     builder: (BuildContext context) => const LoginPage()));
                },
              ),
            ],
          ),
          body: UpgradeAlert(
            barrierDismissible: false,
            showLater: true,
            showIgnore: true,
            showReleaseNotes: false,
            dialogStyle: Platform.isIOS
                ? UpgradeDialogStyle.cupertino
                : UpgradeDialogStyle.material,
            upgrader: Upgrader(
              debugDisplayAlways: false,
              messages: UpgraderMessages(code: "Kindly update your app."),
            ),
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: const AssetImage('assets/bac3.jpg'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.45),
                    BlendMode.darken,
                  ),
                ),
              ),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  RefreshIndicator(
                    onRefresh: () async {
                      await getData(selectedYearCurrent);
                    },
                    // Important when content is smaller than screen
                    displacement: 40, 
                    edgeOffset: 10,
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(
                              left: 10,
                              right: 10,
                              top: 10.0,
                            ),
                            padding: const EdgeInsets.all(8),
                            alignment: Alignment.center,
                          ),
                          Card(
                            color: Colors.white.withOpacity(0.4),
                            margin: const EdgeInsets.only(left: 16.0, right: 16),
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Column(
                                children: [
                                  Form(
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white.withOpacity(
                                                0.5,
                                              ),
                                              borderRadius: BorderRadius.circular(
                                                10,
                                              ),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                right: 8.0,
                                                left: 8,
                                                top: 2,
                                                bottom: 2,
                                              ),
                                              child: Image(
                                                image: const AssetImage(
                                                  'assets/logo_dark.png',
                                                ),
                                                width:
                                                    MediaQuery.of(
                                                      context,
                                                    ).size.width *
                                                    0.4,
                                                height:
                                                    MediaQuery.of(
                                                      context,
                                                    ).size.height *
                                                    0.05,
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () async {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (BuildContext context) =>
                                                       CrewIVMMaintenancePlanTable(year: selectedYear.toString()),
                                                ),
                                              );
                                             await getData(
                                  selectedYear.toString()
                                );
                    
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.only(
                                                top: 30.0,
                                              ),
                                              padding: const EdgeInsets.all(8),
                                              alignment: Alignment.center,
                                              height: size.height * 0.15,
                                              width: size.width * 0.99,
                                              decoration: BoxDecoration(
                                                // shape: BoxShape.circle,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                boxShadow: const [
                                                  BoxShadow(
                                                    color: Color.fromARGB(
                                                      255,
                                                      2,
                                                      75,
                                                      4,
                                                    ),
                                                    blurRadius: 5,
                                                    offset: Offset(2.0, 5.0),
                                                  ),
                                                ],
                                                gradient: const LinearGradient(
                                                  colors: [
                                                    Colors.white,
                                                    Colors.white,
                                                  ],
                                                ),
                                              ),
                                              child: Row(
                                                children: [
                                                  const Expanded(
                                                    flex: 2,
                                                    child: Align(
                                                      alignment:
                                                          Alignment.topCenter,
                                                      child: Padding(
                                                        padding: EdgeInsets.only(
                                                          bottom: 10.0,
                                                          top: 10,
                                                        ),
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                Radius.circular(
                                                                  15.0,
                                                                ),
                                                              ),
                                                          child: Image(
                                                            image: AssetImage(
                                                              'assets/1.png',
                                                            ),
                                                            // image: AssetImage(
                                                            //     'assets/2.png'),
                                                            color: Color.fromARGB(
                                                              255,
                                                              82,
                                                              185,
                                                              13,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  const Expanded(
                                                    flex: 3,
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                        bottom: 10.0,
                                                        top: 10,
                                                      ),
                                                      child: Text(
                                                        "IVM Maintenance Job List",
                                                        // "IVM Maintenance Progress",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          color: Color.fromARGB(
                                                            255,
                                                            82,
                                                            185,
                                                            13,
                                                          ),
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 18,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                            bottom: 10.0,
                                                            top: 10,
                                                          ),
                                                      child: Text(
                                                        iVMLength.toString(),
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: const TextStyle(
                                                          color: Color.fromARGB(
                                                            255,
                                                            82,
                                                            185,
                                                            13,
                                                          ),
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 22,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () async {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder:
                                                      (BuildContext context) =>
                                                           ChangeOrderTable(year: selectedYear.toString()),
                                                ),
                                              );
                    
                                               await getData(
                                  selectedYear.toString()
                                );
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.only(
                                                top: 8.0,
                                              ),
                                              padding: const EdgeInsets.all(8),
                                              alignment: Alignment.center,
                                              height: size.height * 0.15,
                                              width: size.width * 0.99,
                                              decoration: BoxDecoration(
                                                // shape: BoxShape.circle,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                boxShadow: const [
                                                  BoxShadow(
                                                    color: Color.fromARGB(
                                                      255,
                                                      2,
                                                      75,
                                                      4,
                                                    ),
                                                    blurRadius: 5,
                                                    offset: Offset(2.0, 5.0),
                                                  ),
                                                ],
                                                gradient: const LinearGradient(
                                                  colors: [
                                                    Colors.white,
                                                    Colors.white,
                                                  ],
                                                ),
                                              ),
                                              child: Row(
                                                children: [
                                                  const Expanded(
                                                    flex: 2,
                                                    child: Align(
                                                      alignment:
                                                          Alignment.topCenter,
                                                      child: Padding(
                                                        padding: EdgeInsets.only(
                                                          bottom: 10.0,
                                                          top: 10,
                                                        ),
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                Radius.circular(
                                                                  15.0,
                                                                ),
                                                              ),
                                                          child: Image(
                                                            image: AssetImage(
                                                              'assets/2.png',
                                                            ),
                                                            // image: AssetImage(
                                                            //     'assets/2.png'),
                                                            color: Color.fromARGB(
                                                              255,
                                                              82,
                                                              185,
                                                              13,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  const Expanded(
                                                    flex: 3,
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                        bottom: 10.0,
                                                        top: 10,
                                                      ),
                                                      child: Text(
                                                        "View Change Order",
                                                        // "Change Order",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          color: Color.fromARGB(
                                                            255,
                                                            82,
                                                            185,
                                                            13,
                                                          ),
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 18,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  // Expanded(
                                                  //   flex:1,
                                                  //   child: Container(),
                                                  // ),
                                                  Expanded(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                            bottom: 10.0,
                                                            top: 10,
                                                          ),
                                                      child: Text(
                                                        changeOrderLength
                                                            .toString(),
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: const TextStyle(
                                                          color: Color.fromARGB(
                                                            255,
                                                            82,
                                                            185,
                                                            13,
                                                          ),
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 22,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          
                                          InkWell(
                                            onTap: () async {
                                              provider.getLocation();
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const MapScreenLeafLat(),
                                                ),
                                              );
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.only(
                                                top: 10.0,
                                              ),
                                              padding: const EdgeInsets.all(8),
                                              alignment: Alignment.center,
                                              height: size.height * 0.15,
                                              width: size.width * 0.99,
                                              decoration: BoxDecoration(
                                                // shape: BoxShape.circle,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                boxShadow: const [
                                                  BoxShadow(
                                                    color: Color.fromARGB(
                                                      255,
                                                      2,
                                                      75,
                                                      4,
                                                    ),
                                                    blurRadius: 5,
                                                    offset: Offset(2.0, 5.0),
                                                  ),
                                                ],
                                                gradient: const LinearGradient(
                                                  colors: [
                                                    Colors.white,
                                                    Colors.white,
                                                  ],
                                                ),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  const Expanded(
                                                    flex: 2,
                                                    child: Align(
                                                      alignment:
                                                          Alignment.topCenter,
                                                      child: Padding(
                                                        padding: EdgeInsets.only(
                                                          top: 10.0,
                                                          bottom: 10,
                                                        ),
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                Radius.circular(
                                                                  15.0,
                                                                ),
                                                              ),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                  top: 8.0,
                                                                ),
                                                            child: Image(
                                                              image: AssetImage(
                                                                'assets/map1.png',
                                                              ),
                                                              color:
                                                                  Color.fromARGB(
                                                                    255,
                                                                    82,
                                                                    185,
                                                                    13,
                                                                  ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  const Expanded(
                                                    flex: 3,
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                        bottom: 10.0,
                                                        top: 10,
                                                      ),
                                                      child: Text(
                                                        "LCP System Map",
                                                        // "Live IVM System Map",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          color: Color.fromARGB(
                                                            255,
                                                            82,
                                                            185,
                                                            13,
                                                          ),
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 18,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Container(),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 100),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                    
                              // alignment: Alignment.bottomCenter,
                              children: [
                                Text(
                                  "Copyright © $currentYear",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Text(
                                  " Ariespro.",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Color.fromARGB(255, 255, 102, 0),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Text(
                                  " All rights reserved.",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> showExitPopup(context) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
            height: 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Text(
                    "Do you want to exit?",
                    style: TextStyle(
                      color: Color.fromARGB(255, 7, 59, 120),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          exit(0);
                        },
                        child: const Text(
                          "Yes",
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red.shade800,
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          "No",
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static int getCurrentYear() {
    DateTime now = DateTime.now();
    int currentYear = now.year;
    return currentYear;
  }

  Future<void> getData(String year) async {
    changeOrderLength = 0;
    iVMLength = 0;
    fetchChangeOrdersCounts(year);
    fetchIVMCounts(year);
    _initializeScreen();
  }

  Future<void> fetchChangeOrdersCounts(String year) async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();

    id = data.user!.id.toString();
    final url = Uri.parse(
      AppUrl.crewChangeOrderTabularDataEndPoint,
    ).replace(queryParameters: {"crewId": id, "vFlag": "0,1,2","year": year});
    print('url::change order $url');
    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer ${data.token}',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final parsed = CrewChangeOrderModel.fromJson(jsonData);
        List<Data> changeOrders = [];
        setState(() {
          changeOrders = parsed.data ?? [];
        });
        changeOrderLength = (parsed.data ?? [])
            .where(
              (record) =>
                  record.status == 'ASSIGNED' ||
                  record.status == 'REJECTED' ||
                  record.status == 'PENDING ZIELIES APPROVAL',
            )
            .length;

        print('Total Records: ${changeOrders.length}');
        print('View Change Orders: ${changeOrderLength}');
      } else {
        print('API Error: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Exception: $e');
    }
  }

  Future<void> fetchIVMCounts(String year) async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();

    id = data.user!.id.toString();
    final url = Uri.parse(AppUrl.crewIvmMaintenanceTabularDataEndPoint).replace(
      queryParameters: {
        "contractor": id,
        "visibilityFlag": "2",
        "status": "PENDING ZIELIES APPROVAL,REJECTED,ASSIGNED",
        "year": year
      },
    );
    print('url::Ivm $url');
    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer ${data.token}',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final parsed = IVMMaintenanceTableDataModel.fromJson(jsonData);
        List<GetAllTableData> ivm = [];
        setState(() {
          ivm = parsed.getAllTableData ?? [];
        });

        iVMLength = ivm.length;
        print('Total Records ivm: ${ivm.length}');
      } else {
        print('API Error: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Exception: $e');
    }
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
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),

            content: DropdownButtonFormField<String>(
              value: years.contains(tempSelectedYear)
                  ? tempSelectedYear
                  : null,

              isExpanded: true,

              decoration: InputDecoration(
                labelText: "Select Year",
                prefixIcon: const Icon(
                  Icons.calendar_today_rounded,
                ),
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

                  print(
                    "Selected Year: $selectedYear",
                  );

                 getData(
              selectedYear.toString()
            );
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
    await Future.delayed(const Duration(seconds: 10));
    if (!mounted) return;
    await checkCurrentUser();
  }//----
}
