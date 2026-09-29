import 'package:CIVM/models/user_model.dart';
import 'package:CIVM/screens/admin_pannel/row_maintenance_view/add_new_row_table.dart';
import 'package:CIVM/screens/admin_pannel/row_maintenance_view/admin_change_order_all_status.dart';
import 'package:CIVM/screens/admin_pannel/row_maintenance_view/ivmMaintenanceProgressDashboard.dart';
import 'package:CIVM/screens/admin_pannel/row_maintenance_view/user_management_tabs.dart';
import 'package:CIVM/screens/leaflat_map/leaf_lat_map_wakeLock.dart';
import 'package:CIVM/screens/map/provider/location_provider.dart';
import 'package:CIVM/sharedPrefs/constants.dart';
import 'package:CIVM/utils/user_pref.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../login_page.dart';
import 'package:CIVM/utils/common_functions.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:CIVM/resources/app_url.dart';

class RowMaintenanceProgress extends StatefulWidget {
  const RowMaintenanceProgress({Key? key}) : super(key: key);

  @override
  State<RowMaintenanceProgress> createState() => _RowMaintenanceProgressState();
}

class _RowMaintenanceProgressState extends State<RowMaintenanceProgress> {
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

  @override
  void initState() {
       _initializeScreen();
    // getOwnPermissions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return Scaffold(
        // appBar: AppBar(
        //   iconTheme: const IconThemeData(color: Colors.white),
        //   title: const Text(
        //     'IVM Maintenance Progress',
        //     style: TextStyle(color: Colors.white),
        //   ),
        //   backgroundColor: const Color.fromARGB(255, 7, 59, 120),
        // ),
        drawer: DrawerManu(menu: menu),
        body: const DefaultTabController(
          length: 1,
          child: Padding(
            padding: EdgeInsets.all(4.0),
            child: Column(
              children: [
                Expanded(
                  child: TabBarView(
                    children: [
                      IVMMaintenanceProgressDashboard(),
                   //   IVMMaintenanceProgressTabView(),
                    
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
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

  String? _imagePath;

  @override
  void initState() {
    setUserName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userPreferences = Provider.of<UserPref>(context);
    var provider = Provider.of<LocationProvider>(context, listen: true);
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
       menuLogoLCP(),const SizedBox(height: 6),
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
                  //  ListTile(
                  //   leading: const Icon(
                  //     Icons.computer,
                  //   ),
                  //   title: const Text('Row Maintenance Plan'),
                  //   textColor: const Color.fromARGB(255, 7, 59, 120),
                  //   iconColor: const Color.fromARGB(255, 7, 59, 120),
                  //   onTap: () {
                  //     Navigator.of(context).push(MaterialPageRoute(
                  //         builder: (BuildContext context) =>
                  //             const EnergyAuditPannel()));
                  //   },
                  //              ),
            //         ListTile(
            //   leading: const Icon(
            //     Icons.compare,
            //   ),
            //   title: const Text('Inspection'),
            //   textColor: const Color.fromARGB(255, 7, 59, 120),
            //   iconColor: const Color.fromARGB(255, 7, 59, 120),
            //   onTap: () {
            //     Navigator.of(context).push(MaterialPageRoute(
            //         builder: (BuildContext context) => const InspectionZielies()));
            //   },
            // ),
              ListTile(
              leading: const Icon(
                Icons.open_in_new,
              ),
              title: const Text('IVM Maintenance Progress'),
              textColor: const Color.fromARGB(255, 7, 59, 120),
              iconColor: const Color.fromARGB(255, 7, 59, 120),
              onTap: () {
                Navigator.pop(context);
                // Navigator.of(context).push(MaterialPageRoute(
                //     builder: (BuildContext context) => const EATicketsOpen()));
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.pending,
              ),
              title: const Text('Change Order Job List'),
              textColor: const Color.fromARGB(255, 7, 59, 120),
              iconColor: const Color.fromARGB(255, 7, 59, 120),
              onTap: () {
               Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) =>
                                 AdminChangeOrderAllStatus(source: '',)));
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.airplane_ticket_sharp,
              ),
              title: const Text('IVM Maintenance Job List'),
              textColor: const Color.fromARGB(255, 7, 59, 120),
              iconColor: const Color.fromARGB(255, 7, 59, 120),
              onTap: () {
                 Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) =>
                          const AdminAddNewRowTable()));
              },
            ),
            //  ListTile(
            //   leading: const Icon(
            //     Icons.settings_applications_sharp,
            //   ),
            //   title: const Text('Maintenance Report View'),
            //   textColor: const Color.fromARGB(255, 7, 59, 120),
            //   iconColor: const Color.fromARGB(255, 7, 59, 120),
            //   onTap: () {
            //    Navigator.of(context).push(MaterialPageRoute(
            //         builder: (BuildContext context) =>
            //             const AdminMaintenanceReportViewNew()));
            //   },
            // ),
          
           
            // ListTile(
            //   leading: const Icon(
            //     Icons.data_usage,
            //   ),
            //   title: const Text('Budget Planning'),
            //   textColor: const Color.fromARGB(255, 7, 59, 120),
            //   iconColor: const Color.fromARGB(255, 7, 59, 120),
            //   onTap: () {
            //     Navigator.of(context).push(MaterialPageRoute(
            //         builder: (BuildContext context) => const BudgetPlanning()));
            //   },
            // ),
           
            ListTile(
              leading: const Icon(
                Icons.location_on,
              ),
              title: const Text('Live IVM System Map'),
              textColor: const Color.fromARGB(255, 7, 59, 120),
              iconColor: const Color.fromARGB(255, 7, 59, 120),
              onTap: () {
                provider.getLocation();
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const MapScreenLeafLat()));
              },
            ),
             ListTile(
              leading: const Icon(
                Icons.group_add,
              ),
              title: const Text('User Management'),
              textColor: const Color.fromARGB(255, 7, 59, 120),
              iconColor: const Color.fromARGB(255, 7, 59, 120),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => const UserManagementTabs()));
              },
            ),
            // ListTile(
            //   leading: const Icon(
            //     Icons.check,
            //   ),
            //   title: const Text('Approve CIVM Access'),
            //   textColor: const Color.fromARGB(255, 7, 59, 120),
            //   iconColor: const Color.fromARGB(255, 7, 59, 120),
            //   onTap: () {
            //     Navigator.of(context).push(MaterialPageRoute(
            //         builder: (BuildContext context) =>
            //             const ApproveCIVMAccess()));
            //   },
            // ),
            // ListTile(
            //   leading: const Icon(
            //     Icons.add,
            //   ),
            //   title: const Text('Add Crew Member'),
            //   textColor: const Color.fromARGB(255, 7, 59, 120),
            //   iconColor: const Color.fromARGB(255, 7, 59, 120),
            //   onTap: () {
            //     Navigator.of(context).push(MaterialPageRoute(
            //         builder: (BuildContext context) => const AddCrewMember()));
            //   },
            // ),
            // ListTile(
            //   leading: const Icon(
            //     Icons.group_add,
            //   ),
            //   title: const Text('Add Planner/GF'),
            //   textColor: const Color.fromARGB(255, 7, 59, 120),
            //   iconColor: const Color.fromARGB(255, 7, 59, 120),
            //   onTap: () {
            //     Navigator.of(context).push(MaterialPageRoute(
            //         builder: (BuildContext context) => const AdminAddPlannerGFMemberCardData()));
            //   },
            // ),
            ListTile(
              leading: const Icon(
                Icons.logout,
              ),
              title: const Text('Logout'),
              textColor: const Color.fromARGB(255, 7, 59, 120),
              iconColor: const Color.fromARGB(255, 7, 59, 120),
              onTap: () {
                // Constants.prefs.setBool("LoggedIn", false);
                userPreferences.remove().then((value) {
                  // ignore: use_build_context_synchronously
                  // Navigator.pushReplacement(context, RoutesName.login);
                  // Navigator.pushNamed(
                  //     context, RoutesName.login);
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => const LoginPage()));
                });
                // Navigator.of(context).push(MaterialPageRoute(
                //     builder: (BuildContext context) => const LoginPage()));
              },
            ),],
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
    String imageUrl =
        'https://civm.ariespro.com/assets/clientuploads/${data.user!.profilePhoto}';
    _imagePath = imageUrl;
    setState(() {
      userName = '${data.user!.fName} ${data.user!.lName}';
    });
  }
}
