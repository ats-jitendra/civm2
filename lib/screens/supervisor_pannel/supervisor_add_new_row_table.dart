import 'package:CIVM/models/user_model.dart';
import 'package:CIVM/screens/supervisor_pannel/sup_change_order_all_status.dart';
import 'package:CIVM/screens/supervisor_pannel/supervisor_user_management_tabs.dart';
import 'package:CIVM/utils/common_functions.dart';
import 'package:CIVM/screens/leaflat_map/leaf_lat_map_wakeLock.dart';
import 'package:CIVM/screens/login_page.dart';
import 'package:CIVM/screens/map/provider/location_provider.dart';
import 'package:CIVM/screens/supervisor_pannel/supervisor_add_new_row_maintenance_plan_table_tab1.dart';
import 'package:CIVM/screens/supervisor_pannel/supervisor_bottom_navigation_pannel.dart';
import 'package:CIVM/screens/supervisor_pannel/supervisor_inspection_zielies.dart';
import 'package:CIVM/screens/supervisor_pannel/supervisor_row_maintenance_progress.dart';
import 'package:CIVM/sharedPrefs/constants.dart';
import 'package:CIVM/utils/user_pref.dart';
import 'package:CIVM/view_model/row_maintenance_plan_dashboard_view_model.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class SupervisorAddNewRowTable extends StatefulWidget {
  String index;
  String? budgetType;
  String? year;
  SupervisorAddNewRowTable({
    Key? key,
    required this.index,
    this.budgetType,
    required this.year,
  }) : super(key: key);

  @override
  State<SupervisorAddNewRowTable> createState() =>
      _SupervisorAddNewRowTableState();
}

class _SupervisorAddNewRowTableState extends State<SupervisorAddNewRowTable> {
  RowMaintenancePlanViewModel rowMaintenancePlanViewModel =
      RowMaintenancePlanViewModel();
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
    // getOwnPermissions();
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text(
            'IVM Maintenance Job List',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: const Color.fromARGB(255, 7, 59, 120),
        ),
        drawer: DrawerManu(menu: menu),
        body: DefaultTabController(
          initialIndex: int.parse(widget.index),
          length: 2,
          // initialIndex: int.parse(widget.index),
          child:  Padding(
            padding: EdgeInsets.all(4.0),
            child: Column(
              children: [
               
                Expanded(
                  child: TabBarView(
                    children: [
                      SupervisorAddNewRowMaintenancePlanTableTab1(budgetType:widget.budgetType, year: widget.year),
                    //  SupervisorAddNewRowMaintenancePlanTableTab2(),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
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
                ListTile(
                    leading: const Icon(
                      Icons.computer,
                    ),
                    title: const Text('Dashboard'),
                    textColor: const Color.fromARGB(255, 7, 59, 120),
                    iconColor: const Color.fromARGB(255, 7, 59, 120),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const SupervisorBottomNavigationPannel()));
                    },
                  ),
                ListTile(
              leading: const Icon(
                Icons.change_circle,
              ),
              title: const Text('Inspection'),
              textColor: const Color.fromARGB(255, 7, 59, 120),
              iconColor: const Color.fromARGB(255, 7, 59, 120),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) =>
                         SupervisorInspectionZielies(year: '',)));
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
                         SupChangeOrderAllStatus(source: '',year: '',)));
                // Navigator.of(context).push(MaterialPageRoute(
                //     builder: (BuildContext context) =>
                //         const ChangeOrderNewInDrawer()));
              },
            ),
            
        
            ListTile(
              leading: const Icon(
                Icons.rowing,
              ),
              title: const Text('IVM Maintenance Job List'),
              textColor: const Color.fromARGB(255, 7, 59, 120),
              iconColor: const Color.fromARGB(255, 7, 59, 120),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.inventory,
              ),
              title: const Text('IVM Maintenance Progress'),
              textColor: const Color.fromARGB(255, 7, 59, 120),
              iconColor: const Color.fromARGB(255, 7, 59, 120),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) =>
                        const SupervisorRowMaintenanceProgress()));
              },
            ),
        
           
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
                    builder: (BuildContext context) => const SupervisorUserManagementTabs()));
              },
            ),
            
        
            ListTile(
              leading: const Icon(
                Icons.logout,
              ),
              title: const Text('Log Out'),
              textColor: const Color.fromARGB(255, 7, 59, 120),
              iconColor: const Color.fromARGB(255, 7, 59, 120),
              onTap: () {
                // // Constants.prefs.setBool("LoggedIn", false);
                userPreferences.remove().then((value) {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => const LoginPage()));
                });
                // Navigator.of(context).pushReplacement(MaterialPageRoute(
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
    setState(() {
      userName = '${data.user!.fName} ${data.user!.lName}';
    });
  }
}
