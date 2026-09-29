import 'package:CIVM/models/user_model.dart';
import 'package:CIVM/screens/login_page.dart';
import 'package:CIVM/screens/supervisor_pannel/sup_change_order_all_status.dart';
import 'package:CIVM/screens/supervisor_pannel/supervisor_user_management_tabs.dart';
import 'package:CIVM/utils/common_functions.dart';
import 'package:CIVM/screens/supervisor_pannel/supervisor_add_new_row_maintenance_plan_tab1.dart';
import 'package:CIVM/screens/supervisor_pannel/supervisor_add_new_row_maintenance_plan_tab2.dart';
import 'package:CIVM/screens/supervisor_pannel/supervisor_bottom_navigation_pannel.dart';
import 'package:CIVM/screens/supervisor_pannel/supervisor_inspection_zielies.dart';
import 'package:CIVM/screens/supervisor_pannel/supervisor_row_maintenance_progress.dart';
import 'package:CIVM/utils/user_pref.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../view_model/add_new_row_maintenance_plan_view_model.dart';

// ignore: must_be_immutable
class SupervisorAddNewRowMaintenancePlan extends StatefulWidget {
  // const SupervisorAddNewRowMaintenancePlan({Key? key}) : super(key: key);
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

  SupervisorAddNewRowMaintenancePlan({
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
  State<SupervisorAddNewRowMaintenancePlan> createState() =>
      _SupervisorAddNewRowMaintenancePlanState();
}

class _SupervisorAddNewRowMaintenancePlanState
    extends State<SupervisorAddNewRowMaintenancePlan> {
  // int _currentIndex = 0;
  // final List<Widget> _children = [
  //   RowMaintenancePlan(),
  //   // BottomNavigationHomePage(),
  //   // BottomNavigationAccountPage()
  // ];
  List<String> menu = [];

  List<Map<String, dynamic>> listOfColumns = [];
  List<Map<String, dynamic>> listOfColumns1 = [];

  var result = [];
  DateTime currentDate = DateTime.now();
  int feederId = 0;
  int substationId = 0;
  int assignFormanId = 0;
  String supervisorId = '';
  String supervisorIdGlobal = '';

  late final TextEditingController _contractRowYear = TextEditingController();
  final TextEditingController _assignOtherForeman = TextEditingController();

  String name1 = '';

  // ignore: non_constant_identifier_names
  final select_contractorCompany = [
    'LCP',
    'ZIELIES',
  ];
  String? contractorCompany;

  // ignore: non_constant_identifier_names
  final select_budgetType = [
    'Regular IVM maintenance',
    'Mid Cycle maintenance'
  ];
  String? budgetType;

  String a = '';

  List countyList = [];
  List substationList = [];
  List feederList = [];
  // ignore: prefer_typing_uninitialized_variables
  var selectedSubstation;
  // ignore: prefer_typing_uninitialized_variables
  var selectedCounty;
  // ignore: prefer_typing_uninitialized_variables
  var selectedFeeder;
  // ignore: prefer_typing_uninitialized_variables
  var selectedAssignForman;

  String feederName = '';
  String substationName = '';

  onTappedBar(int index) {
    setState(() {
      // _currentIndex = index;
    });
  }

  String now = DateFormat("yyyy-MM-dd hh:mm:ss").format(DateTime.now());

  AddNewRowMaintenancePlanViewModel addNewRowMaintenancePlanViewModel =
      AddNewRowMaintenancePlanViewModel();

  DateTime date20 = DateTime.now();
  late String dateSelected20 = DateFormat('yyyy-MM-dd').format(date20);

  @override
  void initState() {
    // addNewRowMaintenancePlanViewModel.fetchAddNewRowMaintenancePlanViewListApi(
    //     context, '0', 'Get', '', '', '', '', '', '');
    super.initState();
    _contractRowYear.text = DateFormat("yyyy").format(DateTime.now());
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
          //               const SupervisorAddNewRowMaintenancePlanTable()));
          //     },
          //   ),
          // ],
        ),
      //  drawer: DrawerManu(menu: menu),
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
                      SupervisorAddNewRowMaintenancePlanTab1(
                        tokenNo: widget.tokenNo,
                        index: '0',
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
                      SupervisorAddNewRowMaintenancePlanTab2(
                        tokenNo: widget.tokenNo,
                        index: '1',
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

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
      value: item,
      child: Text(item,
          style: const TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 20,
          )));

  calculateTotalCost(
    double totalMiles,
    double costPerMiles,
    TextEditingController totalCostCTLR,
  ) {
    setState(() {
      double totalCost = 0.0;
      totalCost = totalMiles * costPerMiles;
      totalCostCTLR.text = totalCost.toStringAsFixed(2);
    });
  }

  calculateNextMaintenanceYear(
    int contractRowYear,
    int rowCycle,
    TextEditingController nextMaintenanceYearCTRL,
  ) {
    setState(() {
      int nextMaintenanceYear = 0;
      // contractRowYear = DateFormat("yyyy").format(DateTime.now()) as int;
      print(contractRowYear);
      nextMaintenanceYear = contractRowYear + rowCycle;
      nextMaintenanceYearCTRL.text = nextMaintenanceYear.toString();
    });
  }

  void onTextChanged() {
    print('Other selected on assign foreman11111111111111111111');
    name1 = _assignOtherForeman.text.toString();
    print('Other selected on assign foreman');
    print('name1');
    print('a');
    print(name1);
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
               menuLogoLCP(), Padding(
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
                //   builder: (BuildContext context) =>
                //       const ChangeOrderNewInDrawer()));
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
              Icons.change_circle,
            ),
            title: const Text('Change Order Job List'),
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
    setState(() {
      userName = '${data.user!.fName} ${data.user!.lName}';
    });
  }
}
