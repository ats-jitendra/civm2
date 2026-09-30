import 'package:CIVM/piedmont/models/user_model.dart';
import 'package:CIVM/piedmont/resources/app_colors.dart';
import 'package:CIVM/piedmont/screens/admin_pannel/pemc_admin_new/adm_invoice_list.dart';
import 'package:CIVM/piedmont/screens/admin_pannel/pemc_admin_new/adm_service_order.dart';
import 'package:CIVM/piedmont/screens/admin_pannel/row_maintenance_view/add_crew_member.dart';
import 'package:CIVM/piedmont/screens/admin_pannel/row_maintenance_view/add_new_row_maintenance_plan_tab_2.dart';
import 'package:CIVM/piedmont/screens/admin_pannel/row_maintenance_view/add_new_row_maintenance_plan_tab_1.dart';
import 'package:CIVM/piedmont/screens/admin_pannel/row_maintenance_view/approve_civm_access.dart';
import 'package:CIVM/piedmont/screens/admin_pannel/row_maintenance_view/budget_planning.dart';
import 'package:CIVM/piedmont/screens/admin_pannel/pemc_admin_new/inspection_zielies.dart';
import 'package:CIVM/piedmont/screens/admin_pannel/row_maintenance_view/row_maintenance_plan.dart';
import 'package:CIVM/piedmont/screens/admin_pannel/row_maintenance_view/ivm_maintenance_progress.dart';
import 'package:CIVM/piedmont/screens/leaflat_map/leaf_lat_map_wakeLock.dart';
import 'package:CIVM/piedmont/screens/map/provider/location_provider.dart';
import 'package:CIVM/piedmont/utils/common_functions.dart';
import 'package:CIVM/piedmont/utils/user_pref.dart';
import 'package:CIVM/utils/user_pref.dart';
import 'package:CIVM/models/user_model.dart';
import 'package:CIVM/piedmont/view_model/row_maintenance_plan_dashboard_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../login_page.dart';
import 'package:CIVM/piedmont/repository/map_url.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:CIVM/piedmont/screens/my_chrome_safari_map_recording.dart';

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
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text(
            'View IVM, Spray Maintenance Plan ',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: AppColors.baseColor,
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
                    color: AppColors.lightGreen,
                    // borderRadius: BorderRadius.circular(25.0)
                  ),
                  child: const TabBar(
                    indicator: BoxDecoration(
                      color: AppColors.baseColor,
                      // borderRadius: BorderRadius.circular(25.0),
                    ),
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelColor: Colors.white,
                    unselectedLabelColor: AppColors.baseColor,
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
    var provider = Provider.of<LocationProviderPemc>(context, listen: true);
     final browser = MyChromeSafariBrowser();
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: AppColors.lighterBaseColor,
            ),
            child: Column(
              children: [
                menuLogo(),
                Padding(
                  padding: const EdgeInsets.only(top: 6.0),
                  child: Text(
                    userName,
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.computer,
            ),
            title: const Text('Row Maintenance Plan'),
            textColor: AppColors.baseColor,
            iconColor: AppColors.baseColor,
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) =>
                      const RowMaintenanceView()));
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.compare,
            ),
            title: const Text('Inspection'),
            textColor: AppColors.baseColor,
            iconColor: AppColors.baseColor,
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) =>
                      const InspectionZielies()));
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
                  builder: (BuildContext context) => const AdmServiceOrder()));
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.airplane_ticket_sharp,
            ),
            title: const Text('Job List'),
            textColor: AppColors.baseColor,
            iconColor: AppColors.baseColor,
            onTap: () {
              Navigator.pop(context);
            },
          ),
          // Visibility(
          //   visible: (widget.menu.isNotEmpty &&
          //           widget.menu.contains('Energy Audit Ticket'))
          //       ? true
          //       : false,
          // child:
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
            leading: const Icon(
              Icons.open_in_new,
            ),
            title: const Text('IVM Maintenance Progress'),
            textColor: AppColors.baseColor,
            iconColor: AppColors.baseColor,
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) =>
                      const RowMaintenanceProgress()));
            },
          ),
          // ),
          // ListTile(
          //   leading: const Icon(
          //     Icons.closed_caption_off,
          //   ),
          //   title: const Text('Row Analytics Dashboard'),
          //   textColor: AppColors.baseColor,
          //   iconColor: AppColors.baseColor,
          //   onTap: () {
          //     Navigator.of(context).push(MaterialPageRoute(
          //         builder: (BuildContext context) =>
          //             const RowAnalyticsDashboard()));
          //   },
          // ),
                  ListTile(
                    leading: const Icon(
                      Icons.list,
                    ),
                    title: const Text('Invoice List'),
                    textColor: AppColors.baseColor,
                    iconColor: AppColors.baseColor,
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const AdmInvoiceList()));
                    },
                  ),
          ListTile(
            leading: const Icon(
              Icons.data_usage,
            ),
            title: const Text('Budget Planning'),
            textColor: AppColors.baseColor,
            iconColor: AppColors.baseColor,
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => const BudgetPlanning()));
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
              Icons.check,
            ),
            title: const Text('Approve CIVM Access'),
            textColor: AppColors.baseColor,
            iconColor: AppColors.baseColor,
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) =>
                      const ApproveCIVMAccess()));
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
                  builder: (BuildContext context) => const AddCrewMember()));
            },
          ),

          ListTile(
            leading: const Icon(
              Icons.logout,
            ),
            title: const Text('Logout'),
            textColor: AppColors.baseColor,
            iconColor: AppColors.baseColor,
            onTap: () {
              // Constants.prefs.setBool("LoggedIn", false);
              userPreferences.remove().then((value) {
                // ignore: use_build_context_synchronously
                // Navigator.pushReplacement(context, RoutesName.login);
                // Navigator.pushNamed(
                //     context, RoutesName.login);
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => const LoginPagePemc()));
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
      'https://atsdev2test.ariespro.com/assets/clientuploads/${data.user!.profilePhoto}',
    );
    String imageUrl =
        'https://atsdev2test.ariespro.com/assets/clientuploads/${data.user!.profilePhoto}';
    _imagePath = imageUrl;
    setState(() {
      userName = '${data.user!.fName} ${data.user!.lName}';
    });
  }
}
