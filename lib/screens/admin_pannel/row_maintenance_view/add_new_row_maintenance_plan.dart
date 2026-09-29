import 'package:CIVM/models/user_model.dart';
import 'package:CIVM/screens/admin_pannel/row_maintenance_view/admin_change_order_all_status.dart';
import 'package:CIVM/screens/admin_pannel/row_maintenance_view/admin_pannel.dart';
import 'package:CIVM/screens/admin_pannel/row_maintenance_view/user_management_tabs.dart';
import 'package:CIVM/utils/common_functions.dart';
import 'package:CIVM/screens/admin_pannel/row_maintenance_view/add_new_row_maintenance_plan_tab_2.dart';
import 'package:CIVM/screens/admin_pannel/row_maintenance_view/add_new_row_maintenance_plan_tab_1.dart';
import 'package:CIVM/screens/leaflat_map/leaf_lat_map_wakeLock.dart';
import 'package:CIVM/screens/map/provider/location_provider.dart';
import 'package:CIVM/utils/user_pref.dart';
import 'package:CIVM/view_model/row_maintenance_plan_dashboard_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../login_page.dart';

// ignore: must_be_immutable
class AddNewRowMaintenancePlan extends StatefulWidget {
  String tokenNo;
  String index;
  String subStation;
  String feeder;
  String nextMaintYear;
  String maintType;
  String totalMiles;
  String costPerMile;
  String totalCost;
  dynamic budgetType;
  String contractRowYear;
  String rowCycle;
  String rowYear;
  dynamic contractorCompany;
  dynamic assignForeman;

  AddNewRowMaintenancePlan({
    Key? key,
    required this.tokenNo,
    required this.index,
    required this.subStation,
    required this.feeder,
    required this.nextMaintYear,
    required this.maintType,
    required this.totalMiles,
    required this.costPerMile,
    required this.totalCost,
    required this.budgetType,
    required this.contractRowYear,
    required this.rowCycle,
    required this.rowYear,
    required this.contractorCompany,
    required this.assignForeman,
  }) : super(key: key);

  @override
  State<AddNewRowMaintenancePlan> createState() =>
      _AddNewRowMaintenancePlanState();
}

class _AddNewRowMaintenancePlanState extends State<AddNewRowMaintenancePlan> {
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
          // actions: [
          //   IconButton(
          //     icon: const Icon(
          //       Icons.table_chart_outlined,
          //       color: Colors.white,
          //     ),
          //     onPressed: () {
          //       Navigator.of(context).push(MaterialPageRoute(
          //           builder: (BuildContext context) =>
          //               const AddNewRowMaintenancePlanTable()));
          //     },
          //   ),
          // ],
        ),
       // drawer: DrawerManu(menu: menu),
        body: DefaultTabController(
          length: 2,
          initialIndex: int.parse(widget.index),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(4),
                  height: 45,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 132, 179, 233),
                    // borderRadius: BorderRadius.circular(25.0)
                  ),
                  child: const TabBar(
                    indicator: BoxDecoration(
                      color: Color.fromARGB(255, 7, 59, 120),
                      // borderRadius: BorderRadius.circular(25.0),
                    ),
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelColor: Colors.white,
                    unselectedLabelColor: Color.fromARGB(255, 7, 59, 120),
                    tabs: [
                      Tab(
                        // icon: Icon(Icons.tab, color: Colors.white),
                        text: 'IVM WORK PLAN',
                      ),
                      Tab(
                        // icon: Icon(Icons.map, color: Colors.white),
                        text: 'MID CYCLE HERBICIDE WORK PLAN',
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      AddNewRowMaintenancePlanTab1(
                        index: '0',
                        tokenNo: widget.tokenNo,
                        totalMiles:
                            (widget.index == '0') ? widget.totalMiles : '',
                        subStation:
                            (widget.index == '0') ? widget.subStation : '',
                        feeder: (widget.index == '0') ? widget.feeder : '',
                        nextMaintYear:
                            (widget.index == '0') ? widget.nextMaintYear : '',
                        maintType:
                            (widget.index == '0') ? widget.maintType : '',
                        totalCost:
                            (widget.index == '0') ? widget.totalCost : '',
                        costPerMile:
                            (widget.index == '0') ? widget.costPerMile : '',
                        budgetType:
                            (widget.index == '0') ? widget.budgetType : '',
                        contractRowYear:
                            (widget.index == '0') ? widget.contractRowYear : '',
                        rowCycle: (widget.index == '0') ? widget.rowCycle : '',
                        rowYear: (widget.index == '0') ? widget.rowYear : '',
                        contractorCompany: (widget.index == '0')
                            ? widget.contractorCompany
                            : '',
                        assignForeman:
                            (widget.index == '0') ? widget.assignForeman : '',
                      ),
                      AddNewRowMaintenancePlanTab2(
                        index: '1',
                        tokenNo: widget.tokenNo,
                        totalMiles:
                            (widget.index == '1') ? widget.totalMiles : '',
                        subStation:
                            (widget.index == '1') ? widget.subStation : '',
                        feeder: (widget.index == '1') ? widget.feeder : '',
                        nextMaintYear:
                            (widget.index == '1') ? widget.nextMaintYear : '',
                        maintType:
                            (widget.index == '1') ? widget.maintType : '',
                        totalCost:
                            (widget.index == '1') ? widget.totalCost : '',
                        costPerMile:
                            (widget.index == '1') ? widget.costPerMile : '',
                        budgetType:
                            (widget.index == '1') ? widget.budgetType : '',
                        contractRowYear:
                            (widget.index == '1') ? widget.contractRowYear : '',
                        rowCycle: (widget.index == '1') ? widget.rowCycle : '',
                        rowYear: (widget.index == '1') ? widget.rowYear : '',
                        contractorCompany: (widget.index == '1')
                            ? widget.contractorCompany
                            : '',
                        assignForeman:
                            (widget.index == '1') ? widget.assignForeman : '',
                      ),
                      // EcAnalysisTabView(rateID: widget.rateID, ac: widget.ac),
                      // EcSavingTipsTabView(rateID: widget.rateID, ac: widget.ac),
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
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 7, 59, 120),
            ),
            child: Column(
              children: [
                menuLogoLCP(),Padding(
                  padding: const EdgeInsets.only(top: 6.0),
                  child: Text(
                    userName,
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          // ListTile(
          //   leading: const Icon(
          //     Icons.computer,
          //   ),
          //   title: const Text('Row Maintenance Plan'),
          //   textColor: const Color.fromARGB(255, 7, 59, 120),
          //   iconColor: const Color.fromARGB(255, 7, 59, 120),
          //   onTap: () {
          //     Navigator.of(context).push(MaterialPageRoute(
          //         builder: (BuildContext context) =>
          //             const RowMaintenanceView()));
          //   },
          // ),
          //  ListTile(
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
              Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const EnergyAuditPannel(),
                        ),
                      );
              // Navigator.of(context).push(MaterialPageRoute(
              //     builder: (BuildContext context) =>
              //         const RowMaintenanceProgress()));
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
              Navigator.pop(context);
            },
          ),
          //  ListTile(
          //     leading: const Icon(
          //       Icons.settings_applications_sharp,
          //     ),
          //     title: const Text('Maintenance Report View'),
          //     textColor: const Color.fromARGB(255, 7, 59, 120),
          //     iconColor: const Color.fromARGB(255, 7, 59, 120),
          //     onTap: () {
          //      Navigator.of(context).push(MaterialPageRoute(
          //           builder: (BuildContext context) =>
          //               const AdminMaintenanceReportViewNew()));
          //     },
          //   ),
         
         
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
          //     leading: const Icon(
          //       Icons.group_add,
          //     ),
          //     title: const Text('Add Planner/GF'),
          //     textColor: const Color.fromARGB(255, 7, 59, 120),
          //     iconColor: const Color.fromARGB(255, 7, 59, 120),
          //     onTap: () {
          //       Navigator.of(context).push(MaterialPageRoute(
          //           builder: (BuildContext context) => const AdminAddPlannerGFMemberCardData()));
          //     },
          //   ),
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
          ),
        ],
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
