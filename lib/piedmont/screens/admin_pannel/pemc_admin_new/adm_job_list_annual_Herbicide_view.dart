import 'dart:convert';
import 'dart:io';
import 'package:CIVM/piedmont/models/admin_dashboard_data_list_model.dart';
import 'package:CIVM/piedmont/resources/app_colors.dart';
import 'package:CIVM/piedmont/resources/app_url.dart';
import 'package:CIVM/piedmont/utils/common_functions.dart';
import 'package:CIVM/utils/user_pref.dart';
import 'package:CIVM/models/user_model.dart';
// import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../view_model/add_new_row_maintenance_plan_view_model.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class AdmJobListAnnualHerbicideView extends StatefulWidget {
  String tokenNo;

  AdmJobListAnnualHerbicideView({
    Key? key,
    required this.tokenNo,
  }) : super(key: key);

  @override
  State<AdmJobListAnnualHerbicideView> createState() =>
      _AdmJobListAnnualHerbicideViewState();
}

class _AdmJobListAnnualHerbicideViewState
    extends State<AdmJobListAnnualHerbicideView> {
  // int _currentIndex = 0;
  // final List<Widget> _children = [
  //   RowMaintenancePlan(),
  //   // BottomNavigationHomePage(),
  //   // BottomNavigationAccountPage()
  // ];
  List<String> menu = [];

  List<Map<String, dynamic>> listOfColumns = [];
  List<Map<String, dynamic>> listOfColumns1 = [];
  DateTime currentDate = DateTime.now();
  var result = [];

  int feederId = 0;
  int substationId = 0;
  int assignFormanId = 0;
  String supervisorId = '';
  String supervisorIdGlobal = '';

  String feederName = '';
  String substationName = '';
  int loadingIndex = 0;
  bool _isVisibleAssignForeman = true;

  // ignore: prefer_typing_uninitialized_variables
  var deleteImage1;
  // ignore: prefer_typing_uninitialized_variables
  var deleteImage2;
  // ignore: prefer_typing_uninitialized_variables
  var deleteImage3;

  File? image1;
  File? image2;
  File? image3;

  File? image;

  final TextEditingController _totalMiles = TextEditingController();
  final TextEditingController _costPerMile = TextEditingController();
  final TextEditingController _totalCost = TextEditingController();
  // final TextEditingController _budget = TextEditingController();
  late final TextEditingController _contractRowYear = TextEditingController();
  // final TextEditingController _contractEndYear = TextEditingController();
  final TextEditingController _rowCycle = TextEditingController();

  // final TextEditingController _nextMaintYear = TextEditingController();
  final TextEditingController _rowYear = TextEditingController();
  final TextEditingController _substation = TextEditingController();
  final TextEditingController _feeder = TextEditingController();
  final TextEditingController _nextMaintYear = TextEditingController();
  final TextEditingController _maintType = TextEditingController();
  final TextEditingController _type = TextEditingController();
  final TextEditingController _planType = TextEditingController();
  final TextEditingController _budgetType = TextEditingController();
  final TextEditingController _assignForman = TextEditingController();
  final TextEditingController _contractorCompany = TextEditingController();
  final TextEditingController _annualHerbicide = TextEditingController();
  final TextEditingController _status = TextEditingController();

  final TextEditingController _supervisorNotes = TextEditingController();
  final TextEditingController _generalforemanNotes = TextEditingController();
  final TextEditingController _year = TextEditingController();
  final TextEditingController _area = TextEditingController();

  String name1 = '';

  // ignore: non_constant_identifier_names
  final select_contractorCompany = [
    // 'LCP',
    'PEMC',
  ];

  // ignore: non_constant_identifier_names
  final select_budgetType = [
    'Regular IVM maintenance',
    // 'Mid Cycle maintenance'
  ];
  var budgetType;

  String a = '';

  final _formkey = GlobalKey<FormState>();
  List countyList = [];
  List substationList = [];
  List feederList = [];

  // ignore: prefer_typing_uninitialized_variables
  String? contractorCompany;
  // ignore: prefer_typing_uninitialized_variables
  var selectedSubstation;
  // ignore: prefer_typing_uninitialized_variables
  var selectedFeeder;
  // ignore: prefer_typing_uninitialized_variables
  var selectedAssignForman;

  // ignore: prefer_typing_uninitialized_variables
  var selectedyear;

  // ignore: non_constant_identifier_names
  List<String> select_maintenanceType = [
    'JARRAFF',
    'MOWING',
    'MINI JARRAFF',
    'BYL',
    'BUCKET',
    'GROUND',
    'CROSS-COUNTRY SPRAY',
    'ROADSIDE SPRAY',
    'NO SPRAY',
  ];
  String? maintenanceType = 'JARRAFF';

  List<String> types = ['JARRAFF'];

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
  String dynamicYear = '';
  String? year;

  @override
  void initState() {
    fetchDetails(context);
    print('widget.tokenNo ${widget.tokenNo}');

    super.initState();
    _contractRowYear.text = DateFormat("yyyy").format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Annual Herbicide",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColors.baseColor,
      ),
      backgroundColor: AppColors.backgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(8),
                padding: const EdgeInsets.all(12),
                width: size.width,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.baseColor,
                      blurRadius: 10,
                      offset: Offset(2.0, 5.0),
                    ),
                  ],
                  color: Colors.white,
                ),
                child: Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      // /// HEADER
                      // Container(
                      //   height: 50,
                      //   width: double.infinity,
                      //   padding: const EdgeInsets.all(10),
                      //   decoration: const BoxDecoration(
                      //     gradient: LinearGradient(
                      //       colors: [
                      //         AppColors.baseColor,
                      //         AppColors.buttonOrange,
                      //         AppColors.baseColor,
                      //       ],
                      //     ),
                      //   ),
                      //   child: const Align(
                      //     alignment: Alignment.centerLeft,
                      //     child: Text(
                      //       "IVM MAINTENANCE PLAN",
                      //       style: TextStyle(
                      //         color: Colors.white,
                      //         fontWeight: FontWeight.bold,
                      //         fontSize: 20,
                      //       ),
                      //     ),
                      //   ),
                      // ),

                      buildField("TYPE", _type),
                      buildField("ANNUAL HERBICIDE", _annualHerbicide),
                      buildField("STATUS", _status),
                      buildField("SUBSTATION", _substation),
                      //  buildField("SUPERVISOR NOTES", _supervisorNotes),
                      buildField("GENERAL FOREMAN NOTES", _generalforemanNotes),
                      buildField("YEAR", _year),
                      buildField("AREA", _area),

                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 20),
        ),
      );

  AdminDashboardDataListdata? item;
   String id = '';
  Future<void> fetchDetails(BuildContext context) async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    id = data.user!.id.toString();
    var url =
        "${AppUrl.baseUrl}rowVegetationManagementDashboard/Admindatalist?contractorId=$id&JobNo=${widget.tokenNo}";

    print('url $url');

    var headers = {
      "Content-Type": "application/json",
      // "Authorization": "Bearer $token", //  Add this line
      "Authorization": 'Bearer ${data.token!}'
    };

    try {
      var response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        var res = jsonDecode(response.body);

        print(response.body);

        List list = res["gettabledata"];

        if (list.isNotEmpty) {
          item = AdminDashboardDataListdata.fromJson(list[0]);

          WidgetsBinding.instance.addPostFrameCallback((_) {
            setData();
          });

          setState(() {});
        }
      } else {
        // setState(() => isLoading = false);
      }
    } catch (e) {
      // setState(() => isLoading = false);
    }
  }

  void setData() {
    _nextMaintYear.text = item?.nextMaintDue ?? '';
    _substation.text = item?.substation ?? '';

    _type.text = item?.maintenanceType ?? '';
    _annualHerbicide.text = item?.annualHerbicide ?? '';

    _status.text = item?.status ?? '';
    _generalforemanNotes.text = item?.generalForemanNotes ?? '';
    _year.text = getYearOrNA(item?.contractYear ?? '');
  }
}
