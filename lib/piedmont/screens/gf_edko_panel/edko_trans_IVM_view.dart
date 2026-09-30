import 'dart:convert';
import 'dart:io';
import 'package:CIVM/piedmont/models/gf_edko_dashboard_data_list_model.dart';
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
class EdkotransIVMView extends StatefulWidget {
  String tokenNo;

  EdkotransIVMView({
    Key? key,
    required this.tokenNo,
  }) : super(key: key);

  @override
  State<EdkotransIVMView> createState() => _EdkotransIVMViewState();
}

class _EdkotransIVMViewState extends State<EdkotransIVMView> {
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
  
  late final TextEditingController _contractRowYear = TextEditingController();
  
  final TextEditingController _substation = TextEditingController();
  final TextEditingController _feeder = TextEditingController();
  final TextEditingController _nextMaintYear = TextEditingController();
  final TextEditingController _maintType = TextEditingController();
  final TextEditingController _type = TextEditingController();
  final TextEditingController _planType = TextEditingController();
  final TextEditingController _budgetType = TextEditingController();
  final TextEditingController _assignForman = TextEditingController();
  final TextEditingController _contractorCompany = TextEditingController();
  final TextEditingController _transmissionName = TextEditingController();

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
          "Transmission IVM",
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

                    
                      buildField(
                        "NEXT MAINT YEAR",
                        _nextMaintYear,
                      ),
                      buildField("TRANSMISSION NAME", _transmissionName),
                      buildField(
                        "MAINTENANCE TYPE",
                        _maintType,
                      ),

                      buildField(
                        "TOTAL MILES",
                        _totalMiles,
                        type: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                      ),

                      // buildField(
                      //   "COST PER MILE",
                      //   _costPerMile,
                      //   type: const TextInputType.numberWithOptions(
                      //     decimal: true,
                      //   ),
                      // ),

                      // buildField("TOTAL COST", _totalCost),

                      buildField("TYPE", _type),
                      buildField("PLAN TYPE", _planType),
                      buildField("BUDGET TYPE", _budgetType),

                      /// 🔥 REPLACED DROPDOWN → TEXT FIELD
                      buildField("CONTRACTOR COMPANY", _contractorCompany),

                      /// ASSIGN FOREMAN
                      if (_isVisibleAssignForeman)
                        buildField("ASSIGN FOREMAN", _assignForman),

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

  GfEdkoDashboardDatadata? item;
   String id = '';
  Future<void> fetchDetails(BuildContext context) async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
     id = data.user!.id.toString();
    var url =
       "${AppUrl.baseUrl}rowVegetationManagementDashboard/gf2Datalist?contractorId=$id&JobNo=${widget.tokenNo}";

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
          item = GfEdkoDashboardDatadata.fromJson(list[0]);

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
    _nextMaintYear.text = getYearOrNA(item?.nextMaintDue ?? '');
    _substation.text = item?.substation ?? '';
    _feeder.text = item?.feeder ?? '';
    _budgetType.text = item?.budgetType ?? '';
    _planType.text = item?.planType ?? '';
    _maintType.text = item?.type ?? '';
    _type.text = item?.maintenanceType ?? '';
    _totalMiles.text = item?.totalMiles?.toString() ?? '';
    // _costPerMile.text = item?.costPerMile?.toString() ?? '';
    // _totalCost.text = item?.totalCost?.toString() ?? '';
    _contractorCompany.text = item?.contractorCompany ?? '';
    //_transmissionName.text = item?.transmissionName ?? '';
    _assignForman.text = item?.contractor ?? '';
  }
}
