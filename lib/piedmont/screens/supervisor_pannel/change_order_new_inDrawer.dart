import 'dart:convert';
import 'package:CIVM/piedmont/repository/map_url.dart';
import 'package:CIVM/piedmont/resources/app_colors.dart';
import 'package:CIVM/piedmont/resources/app_url.dart';
// import 'package:CIVM/piedmont/repository/map_url.dart';
import 'package:CIVM/piedmont/screens/leaflat_map/leaf_lat_map_wakeLock.dart';
import 'package:CIVM/piedmont/screens/login_page.dart';
import 'package:CIVM/piedmont/screens/map/provider/location_provider.dart';
import 'package:CIVM/piedmont/screens/my_chrome_safari_map_recording.dart';
import 'package:CIVM/piedmont/screens/supervisor_pannel/row_maintenance_supervisor.dart';
import 'package:CIVM/piedmont/screens/supervisor_pannel/service_order.dart';
import 'package:CIVM/piedmont/screens/supervisor_pannel/sup_invoice_list.dart';
import 'package:CIVM/piedmont/screens/supervisor_pannel/supervisor_WO_Completed.dart';
import 'package:CIVM/piedmont/screens/supervisor_pannel/supervisor_WO_T&M_inProgress.dart';
import 'package:CIVM/piedmont/screens/supervisor_pannel/supervisor_WO_ready_for_review.dart';
import 'package:CIVM/piedmont/screens/supervisor_pannel/supervisor_WO_rejected.dart';
import 'package:CIVM/piedmont/screens/supervisor_pannel/supervisor_add_crew_member.dart';
import 'package:CIVM/piedmont/screens/supervisor_pannel/supervisor_add_new_row_table.dart';
import 'package:CIVM/piedmont/screens/supervisor_pannel/supervisor_approve_civm_access.dart';
import 'package:CIVM/piedmont/screens/supervisor_pannel/supervisor_row_maintenance_progress.dart';
import 'package:CIVM/sharedPrefs/constants.dart';
import 'package:CIVM/piedmont/utils/common_functions.dart';
import 'package:CIVM/utils/user_pref.dart';
import 'package:CIVM/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:provider/provider.dart';

import 'package:http/http.dart' as http;

class ChangeOrderNewInDrawer extends StatefulWidget {
  const ChangeOrderNewInDrawer({Key? key}) : super(key: key);

  @override
  State<ChangeOrderNewInDrawer> createState() => _ChangeOrderNewInDrawerState();
}

class _ChangeOrderNewInDrawerState extends State<ChangeOrderNewInDrawer> {
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

  Future? myFuture;
  @override
  void initState() {
    myFuture = fetchCardsCountMethod();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text(
            'Work Order ',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: AppColors.baseColor,
        ),
        drawer: DrawerManu(menu: menu),
        body: FutureBuilder(
          future: myFuture,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return GestureDetector(
                onTap: () {
                  FocusScopeNode currentFocus = FocusScope.of(context);
                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.unfocus();
                  }
                },
                child: Stack(fit: StackFit.expand, children: [
                  RefreshIndicator(
                    onRefresh: () async {
                      await fetchCardsCountMethod();
                      print('RefreshIndicator called');
                    },
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Column(
                          children: [
                            //  Container(
                            //     margin: const EdgeInsets.only(
                            //         left: 8, right: 8, top: 10, bottom: 8),
                            //     decoration: const BoxDecoration(
                            //         // shape: BoxShape.circle,
                            //         borderRadius: BorderRadius.only(
                            //             // topRight: Radius.circular(50),
                            //             // bottomLeft: Radius.circular(50)
                            //             ),
                            //         boxShadow: [
                            //           BoxShadow(
                            //               color: Color.fromARGB(255, 3, 47, 97),
                            //               blurRadius: 5,
                            //               offset: Offset(2.0, 5.0))
                            //         ],
                            //         color: Color.fromARGB(255, 130, 193, 245),
                            //         gradient: LinearGradient(
                            //           colors: [
                            //             AppColors.baseColor,
                            //             Color.fromARGB(255, 7, 59, 120)
                            //           ],
                            //         )),
                            //     child: InkWell(
                            //       onTap: () {
                            //         Navigator.of(context).push(MaterialPageRoute(
                            //             builder: (BuildContext context) =>
                            //                 SupervisorZIELIESCreateOrderWithoutData(
                            //                     subStation: '',
                            //                     serviceStreetAddress: '',
                            //                     serviceMapLocation: '',
                            //                     notes: '',
                            //                     type: '',
                            //                     maintType: '',
                            //                     contractorCompany: '',
                            //                     assignForeman: '')));
                            //       },
                            //       child: Container(
                            //           decoration: BoxDecoration(
                            //             border: Border.all(
                            //               color: Colors.white,
                            //             ),
                            //             boxShadow: const [
                            //               BoxShadow(
                            //                   color:
                            //                       Color.fromARGB(255, 3, 47, 97),
                            //                   blurRadius: 10,
                            //                   offset: Offset(2.0, 5.0))
                            //             ],
                            //             image: DecorationImage(
                            //               image: const AssetImage(
                            //                   'assets/Dash_6.jpg'),
                            //               fit: BoxFit.cover,
                            //               colorFilter: ColorFilter.mode(
                            //                   Colors.black.withOpacity(0.45),
                            //                   BlendMode.darken),
                            //             ),
                            //           ),
                            //           margin: const EdgeInsets.only(
                            //               left: 8, right: 8, top: 10, bottom: 8),
                            //           padding: const EdgeInsets.all(8),
                            //           alignment: Alignment.center,
                            //           height: size.height * 0.15,
                            //           width: size.width * 0.99,
                            //           child: const Stack(children: [
                            //             Text(
                            //               'Create a Change Order(Real Time)',
                            //               style: TextStyle(
                            //                   fontSize: 22,
                            //                   color: Colors.white,
                            //                   fontWeight: FontWeight.w800),
                            //             ),
                            //           ])),
                            //     ),
                            //   ),
                            DashboardCardWithIconNew(
                              icon: Icons.autorenew,
                              title: 'In Progress',
                              count: woInprogressCount.toString(),
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        SupervisorZIELIESTotalOrderPending(
                                          budgetType: '',
                                          maintenanceType: 'ChangeOrder',
                                          heading: 'Change Order',
                                        )));
                              },
                            ),
                            DashboardCardWithIconNew(
                              icon: Icons.pending_actions,
                              title: 'Ready For Review',
                              count: woInspectionPendingCount.toString(),
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        SupervisorZIELIESDocumentApprovalPending(
                                          budgetType: '',
                                          maintenanceType: 'ChangeOrder',
                                          heading: 'Change Order',
                                        )));
                              },
                            ),

                            DashboardCardWithIconNew(
                              icon: Icons.block,
                              title: 'Rejected',
                              count: woRejectedCount.toString(),
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        SupervisorZIELIESTotalOrderRejectCO(
                                          budgetType: '',
                                          maintenanceType: 'ChangeOrder',
                                          heading: 'CO',
                                        )));
                              },
                            ),
                            DashboardCardWithIconNew(
                              icon: Icons.autorenew,
                              title: 'Completed',
                              count: woCompletedCount.toString(),
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        SupervisorZIELIESTotalOrderClosed(
                                          budgetType: '',
                                          maintenanceType: 'ChangeOrder',
                                          heading: 'CO',
                                        )));
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ]),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(
                  color: Color.fromARGB(255, 7, 59, 120),
                ),
              );
            }
          },
        ));
  }

  int woInspectionPendingCount = 0;
  int woInprogressCount = 0;
  int woRejectedCount = 0;
  int woCompletedCount = 0;
  int soOpenCount = 0;
  int soInprogressCount = 0;
  int soReadyForReviewCount = 0;
  int soClosedCount = 0;
  String id = "";
  Future<void> fetchCardsCountMethod() async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel userData = await userPreferences.getUser();
    id = userData.user!.id.toString();
    print("id test ${id}");
    String url = '${AppUrl.workAndServiceOrderCount}';

    print("url cards count $url");
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer ${userData.token}',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print('responseBody $data');

        print('API call successful $url');
        setState(() {
          woInspectionPendingCount = data['work_order_inspection_pending'] ?? 0;
          woInprogressCount = data['work_order_inProgress'] ?? 0;
          woRejectedCount = data['work_order_rejected'] ?? 0;
          woCompletedCount = data['work_order_completed'] ?? 0;
          soOpenCount = data['service_order_open'] ?? 0;
          soInprogressCount = data['service_order_inProgress'] ?? 0;
          soReadyForReviewCount = data['service_order_readyfor_review'] ?? 0;
          soClosedCount = data['service_order_closed'] ?? 0;
        });
        //  initiatedCount = data['countOfInitiatedOrder'] ?? 0;
      } else {
        setState(() {});
        print('Failed to update status: ${response.statusCode}');
      }
    } catch (e) {
      setState(() {});
      print('Error occurred: $e');
    }
  }
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

  @override
  void initState() {
    setUserName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    var provider = Provider.of<LocationProviderPemc>(context, listen: true);
    final browser = MyChromeSafariBrowser();
    return Drawer(
      child: SafeArea(
        child: Column(
          // Important: Remove any padding from the ListView.
          // padding: EdgeInsets.zero,
          children: [
            Container(
              width: double.infinity,
              height: 180,
              color: AppColors.lighterBaseColor,
              padding: const EdgeInsets.only(top: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  menuLogo(),
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
                    leading: const Icon(
                      Icons.computer,
                    ),
                    title: const Text('Dashboard'),
                    textColor: AppColors.baseColor,
                    iconColor: AppColors.baseColor,
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const RowMaintenanceSupervisor()));
                    },
                  ),

                  ListTile(
                    leading: const Icon(
                      Icons.pending,
                    ),
                    title: const Text('Work Order'),
                    textColor: AppColors.baseColor,
                    iconColor: AppColors.baseColor,
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.pending,
                    ),
                    title: const Text('Service Order'),
                    textColor: AppColors.baseColor,
                    iconColor: AppColors.baseColor,
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const ServiceOrder()));
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.rowing,
                    ),
                    title: const Text('Job List'),
                    textColor: AppColors.baseColor,
                    iconColor: AppColors.baseColor,
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              SupervisorAddNewRowTable(index: '0')));
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.inventory,
                    ),
                    title: const Text('IVM Maintenance Progress'),
                    textColor: AppColors.baseColor,
                    iconColor: AppColors.baseColor,
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const SupervisorRowMaintenanceProgress()));
                    },
                  ),
                  ///////////new added maps for PEMC
                  ListTile(
                    leading: const Icon(
                      Icons.vertical_distribute,
                    ),
                    title: const Text('Add ROW Distribution Map'),
                    textColor: AppColors.baseColor,
                    iconColor: AppColors.baseColor,
                    onTap: () async {
                      String id = '';
                      final userPreferences1 =
                          Provider.of<UserPref>(context, listen: false);
                      UserModel data = await userPreferences1.getUser();
                      id = data.user!.id.toString();
                      await browser.open(
                          url: WebUri(
                              MapUrl.getPlannerDistributionMapEndPoint(id)),
                          settings: ChromeSafariBrowserSettings(
                              shareState: CustomTabsShareState.SHARE_STATE_OFF,
                              barCollapsingEnabled: true));
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.maps_ugc,
                    ),
                    title: const Text('Add ROW Transmission Map'),
                    textColor: AppColors.baseColor,
                    iconColor: AppColors.baseColor,
                    onTap: () async {
                      String id = '';
                      final userPreferences1 =
                          Provider.of<UserPref>(context, listen: false);
                      UserModel data = await userPreferences1.getUser();
                      id = data.user!.id.toString();
                      await browser.open(
                          url: WebUri(
                              MapUrl.getPlannerTransmissionMapEndPoint(id)),
                          settings: ChromeSafariBrowserSettings(
                              shareState: CustomTabsShareState.SHARE_STATE_OFF,
                              barCollapsingEnabled: true));
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.map,
                    ),
                    title: const Text('Add Herbicide Transmission Map'),
                    textColor: AppColors.baseColor,
                    iconColor: AppColors.baseColor,
                    onTap: () async {
                      String id = '';
                      final userPreferences1 =
                          Provider.of<UserPref>(context, listen: false);
                      UserModel data = await userPreferences1.getUser();
                      id = data.user!.id.toString();
                      await browser.open(
                          url: WebUri(MapUrl.midTransmissionMapEndPoint(id)),
                          settings: ChromeSafariBrowserSettings(
                              shareState: CustomTabsShareState.SHARE_STATE_OFF,
                              barCollapsingEnabled: true));
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.maps_ugc_rounded,
                    ),
                    title: const Text('Add Annual Herbicide Map'),
                    textColor: AppColors.baseColor,
                    iconColor: AppColors.baseColor,
                    onTap: () async {
                      String id = '';
                      final userPreferences1 =
                          Provider.of<UserPref>(context, listen: false);
                      UserModel data = await userPreferences1.getUser();
                      id = data.user!.id.toString();
                      await browser.open(
                          url: WebUri(MapUrl.officeTransmissionMapEndPoint(id)),
                          settings: ChromeSafariBrowserSettings(
                              shareState: CustomTabsShareState.SHARE_STATE_OFF,
                              barCollapsingEnabled: true));
                    },
                  ),
                  ////////////////////////////////////
                  ListTile(
                    leading: Icon(
                      Icons.list,
                    ),
                    title: const Text('Invoice List'),
                    textColor: AppColors.baseColor,
                    iconColor: AppColors.baseColor,
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              SupInvoiceList()));
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.location_on,
                    ),
                    title: const Text('Live IVM System Map'),
                    textColor: AppColors.baseColor,
                    iconColor: AppColors.baseColor,
                    onTap: () {
                      provider.getLocation();
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const MapScreenLeafLat()));
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.approval,
                    ),
                    title: const Text('Approve CIVM Access'),
                    textColor: AppColors.baseColor,
                    iconColor: AppColors.baseColor,
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const SupervisorApproveCIVMAccess()));
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.add,
                    ),
                    title: const Text('Add Crew Member'),
                    textColor: AppColors.baseColor,
                    iconColor: AppColors.baseColor,
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const SupervisorAddCrewMember()));
                    },
                  ),

                  ListTile(
                    leading: const Icon(
                      Icons.logout,
                    ),
                    title: const Text('Log Out'),
                    textColor: AppColors.baseColor,
                    iconColor: AppColors.baseColor,
                    onTap: () {
                      // // Constants.prefs.setBool("LoggedIn", false);
                      // Navigator.of(context).pushReplacement(MaterialPageRoute(
                      //     builder: (BuildContext context) => const LoginPage()));

                      userPreferences.remove().then((value) {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const LoginPagePemc()));
                      });
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
      'https://atsdev2test.ariespro.com/assets/clientuploads/${data.user!.profilePhoto}',
    );
    // String imageUrl =
    //     'https://atsdev2test.ariespro.com/assets/clientuploads/${data.user!.profilePhoto}';
    setState(() {
      userName = '${data.user!.fName} ${data.user!.lName}';
    });
  }
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text("Google Maps Sample"),
//         ),
//         body: Center(child: EntryToMap()),
//       ),
//     );
//   }
// }
