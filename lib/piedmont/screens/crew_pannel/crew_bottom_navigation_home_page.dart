import 'dart:io';
import 'package:CIVM/piedmont/models/crewChangeOrderListModel.dart';
import 'package:CIVM/piedmont/models/ivmMaintenance_table_model.dart';
import 'package:CIVM/piedmont/resources/app_url.dart';
import 'package:CIVM/piedmont/screens/crew_pannel/change_order_crew.dart';
// import 'package:CIVM/piedmont/screens/crew_pannel/crew_ivm_maintenance_progress_old.dart';
// import 'package:CIVM/piedmont/screens/crew_pannel/crew_ivm_maintenance_progress_new.dart';
import 'package:CIVM/piedmont/screens/leaflat_map/leaf_lat_map_wakeLock.dart';
import 'package:CIVM/piedmont/resources/app_colors.dart';
import 'package:CIVM/piedmont/screens/login_page.dart';
import 'package:CIVM/piedmont/screens/map/provider/location_provider.dart';
import 'package:CIVM/piedmont/screens/my_chrome_safari_map_recording.dart';
import 'package:CIVM/utils/user_pref.dart';
import 'package:CIVM/models/user_model.dart';
import 'package:CIVM/piedmont/view_model/crew_change_order_records_view_model.dart';
import 'package:CIVM/piedmont/view_model/ivm_maintenance_progress_view_model.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
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

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final userPreferences = Provider.of<UserPref>(context);
    var provider = Provider.of<LocationProviderPemc>(context, listen: true);
    // ignore: deprecated_member_use
    return PopScope(
      canPop: false,
     onPopInvokedWithResult: (didPop, result) {
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
        )),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.white),
            title: const Text(
              'CIVM',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: AppColors.baseColor,
            actions: [
              IconButton(
                icon: const Icon(Icons.logout, color: Colors.white),
                onPressed: () {
                  userPreferences.remove().then((value) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const LoginPagePemc()));
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
                messages: UpgraderMessages(code: "Kindly update your app.")),
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: const AssetImage('assets/registration_bg.jpg'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.45), BlendMode.darken),
                ),
              ),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 30.0),
                          child: Container(
                            margin: const EdgeInsets.only(
                                left: 10, right: 10, top: 10.0),
                            padding: const EdgeInsets.all(8),
                            alignment: Alignment.center,
                          ),
                        ),
                        Card(
                          color: Colors.white.withOpacity(0.4),
                          margin: const EdgeInsets.only(
                            left: 16.0,
                            right: 16,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Column(children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Form(
                                    child: Padding(
                                  padding: const EdgeInsets.all(0),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 8.0,
                                            left: 8,
                                            top: 2,
                                            bottom: 2),
                                        child: Image(
                                          image: const AssetImage(
                                              'assets/Ariespro full logo v2 without BG.png'),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.4,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.05,
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 100),
                                        child: InkWell(
                                          onTap: () {
                                            // Navigator.of(context).push(
                                            //     MaterialPageRoute(
                                            //         builder: (BuildContext
                                            //                 context) =>
                                            //             const ChangeOrderTable()));

                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        ChangeOrderCrew(
                                                            // budgetType: "",
                                                            // heading: "Change Order",
                                                            // maintenanceType: "",
                                                            )));
                                          },
                                          child: Container(
                                            margin:
                                                const EdgeInsets.only(top: 8.0),
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
                                                          255, 2, 75, 4),
                                                      blurRadius: 5,
                                                      offset: Offset(2.0, 5.0))
                                                ],
                                                gradient: const LinearGradient(
                                                  colors: [
                                                    Colors.white,
                                                    Colors.white,
                                                  ],
                                                )),
                                            child: Row(children: [
                                              const Expanded(
                                                flex: 2,
                                                child: Align(
                                                  alignment:
                                                      Alignment.topCenter,
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        bottom: 10.0, top: 10),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  15.0)),
                                                      child: Image(
                                                        image: AssetImage(
                                                            'assets/2.png'),
                                                        // image: AssetImage(
                                                        //     'assets/2.png'),
                                                        color: Color.fromARGB(
                                                            255, 82, 185, 13),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const Expanded(
                                                flex: 3,
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom: 10.0, top: 10),
                                                  child: Text(
                                                    "View Change Order",
                                                    // "Change Order",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 82, 185, 13),
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
                                              // Expanded(
                                              //   child: Padding(
                                              //     padding: const EdgeInsets.only(
                                              //         bottom: 10.0, top: 10),
                                              //     child: Text(
                                              //       changeOrderLength.toString(),
                                              //       textAlign: TextAlign.center,
                                              //       style: const TextStyle(
                                              //         color: Color.fromARGB(
                                              //             255, 82, 185, 13),
                                              //         fontWeight: FontWeight.bold,
                                              //         fontSize: 22,
                                              //       ),
                                              //     ),
                                              //   ),
                                              // ),
                                            ]),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 100),
                                        child: InkWell(
                                          onTap: () async {
                                            provider.getLocation();
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const MapScreenLeafLat()));
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.only(
                                                top: 10.0),
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
                                                          255, 2, 75, 4),
                                                      blurRadius: 5,
                                                      offset: Offset(2.0, 5.0))
                                                ],
                                                gradient: const LinearGradient(
                                                  colors: [
                                                    Colors.white,
                                                    Colors.white,
                                                  ],
                                                )),
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
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 10.0,
                                                                bottom: 10),
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          15.0)),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    top: 8.0),
                                                            child: Image(
                                                              image: AssetImage(
                                                                  'assets/map1.png'),
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      82,
                                                                      185,
                                                                      13),
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
                                                          top: 10),
                                                      child: Text(
                                                        "PEMC System Map",
                                                        // "Live IVM System Map",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          color: Color.fromARGB(
                                                              255, 82, 185, 13),
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
                                                ]),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                              ),
                            ]),
                          ),
                        ),
                        const SizedBox(
                          height: 80,
                        ),
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
                                    fontWeight: FontWeight.bold),
                              ),
                              const Text(
                                " Ariespro.",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Color.fromARGB(255, 255, 102, 0),
                                    fontWeight: FontWeight.bold),
                              ),
                              const Text(
                                " All rights reserved.",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
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
                        color: AppColors.baseColor,
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
                          child: const Text("Yes",
                              style: TextStyle(color: Colors.white)),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red.shade800),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                          child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text("No",
                            style: TextStyle(color: Colors.white)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                      ))
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  static int getCurrentYear() {
    DateTime now = DateTime.now();
    int currentYear = now.year;
    return currentYear;
  }

  Future<void> getData() async {
    fetchChangeOrdersCounts();
    fetchIVMCounts();
  }

  Future<void> fetchChangeOrdersCounts() async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();

    id = data.user!.id.toString();
    final url = Uri.parse(AppUrl.crewChangeOrderTabularDataEndPoint).replace(
      queryParameters: {"crewId": id},
    );
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
            .where((record) =>
                record.status == 'PENDING' || record.status == 'REJECTED')
            .length;

        print('Total Records: ${changeOrders.length}');
      } else {
        print('API Error: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Exception: $e');
    }
  }

  Future<void> fetchIVMCounts() async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();

    id = data.user!.id.toString();
    final url = Uri.parse(AppUrl.crewIvmMaintenanceTabularDataEndPoint).replace(
      queryParameters: {"contractor": id},
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
}
