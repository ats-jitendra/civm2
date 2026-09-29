import 'dart:convert';
import 'package:CIVM/models/mainTenance_report_view_new.dart';
import 'package:CIVM/models/user_details.dart';
import 'package:CIVM/resources/app_url.dart';
import 'package:CIVM/screens/generalForeman_New_pannel/gf_maintenance_report_view_new_detail_screen.dart';
import 'package:CIVM/screens/planner_pannel.dart/planner_bottom_navigation.dart';
import 'package:CIVM/utils/common_functions.dart';
import 'package:CIVM/screens/generalForeman_New_pannel/gf_add_crew_member.dart';
import 'package:CIVM/screens/generalForeman_New_pannel/inspection.dart';
import 'package:CIVM/screens/leaflat_map/leaf_lat_map_wakeLock.dart';
import 'package:CIVM/screens/map/provider/location_provider.dart';
import 'package:CIVM/sharedPrefs/constants.dart';
import 'package:CIVM/utils/custom_toast_snackbar_progressdialog.dart';
import 'package:camera/camera.dart';
import 'package:CIVM/data/response/status.dart';
import 'package:CIVM/models/user_model.dart';
import 'package:CIVM/screens/generalForeman_New_pannel/contractor_bottom_navigation.dart';
import 'package:CIVM/screens/my_chrome_safari_map_recording.dart';
import 'package:CIVM/utils/user_pref.dart';
import 'package:CIVM/view_model/maintenance_report_view_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../login_page.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class GfMaintenanceReportViewNew extends StatefulWidget {
  String year;

  GfMaintenanceReportViewNew({super.key, required this.year});

  @override
  State<GfMaintenanceReportViewNew> createState() =>
      _GfMaintenanceReportViewNewState();
}

class _GfMaintenanceReportViewNewState
    extends State<GfMaintenanceReportViewNew> {
  // final List<Widget> _children = [
  //   RowMaintenancePlan(),
  //   // BottomNavigationHomePage(),
  //   // BottomNavigationAccountPage()
  // ];

  final TextEditingController _input = TextEditingController();

  List<String> menu = [];

  onTappedBar(int index) {
    setState(() {
      // _currentIndex = index;
    });
  }

  MaintenanceReportViewViewModel maintenanceReportViewViewModel =
      MaintenanceReportViewViewModel();

  // ignore: prefer_typing_uninitialized_variables
  var selectedSubstation;
  late int subId;
  // ignore: prefer_typing_uninitialized_variables
  var selectedFeeder;
  late int feederId;
  // ignore: prefer_typing_uninitialized_variables
  var selectedType;

  final browser = MyChromeSafariBrowser();

  // ignore: prefer_typing_uninitialized_variables
  var deleteImage1;
  // ignore: prefer_typing_uninitialized_variables
  var deleteImage2;
  // ignore: prefer_typing_uninitialized_variables
  var deleteImage3;

  String id = '';

  String imagePath = '';
  String imagePath2 = '';
  String imagePath3 = '';
  var image1;
  var image2;
  var image3;

  final List<Color> cardColorsOutage = [Colors.yellow, Colors.yellow];

  //   File? image1;
  // File? image2;
  // File? image3;
  // String _imagePath = '';
  // String _imagePath2 = '';
  // String _imagePath3 = '';

  List<String> imagePaths = [];
  List<XFile> images = [];

  String formattedNextRowMaintenanceDue = '';
  String newFormatedOrderDate = '';

  String? rights;

  String tokenNoForCloseDailog = '';
  String idForCloseDailog = '';
  String userTypeText = '';
  String primaryRoleText = '';
  int? loadingIndex;
  List<FindAllJoinDatas> allData = [];
  List<FindAllJoinDatas> filteredList = [];

  List<String> years = ["2021", "2022", "2023", "2024", "2025", "2026", "2027"];
  String? selectedYear;
  var selectedYearCurrent;
  int currentYear = DateTime.now().year;

  @override
  void initState() {
    selectedYear = selectedYearCurrent = (widget.year != '')
        ? widget.year
        : currentYear.toString();
    maintenanceReportViewViewModel.fetchMaintenanceReportViewTabularListApiNew(
      context,
      '',
      '',
      '',
      '',
      selectedYearCurrent,
    );
    getUserType();
    super.initState();
    _initializeScreen();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Maintenance Report View',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 7, 59, 120),
        actions: <Widget>[
          InkWell(
            onTap: () {
              _initializeScreen();
              showYearFilterDialog();
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                // width: 75,
                height: kToolbarHeight,
                margin: const EdgeInsets.only(right: 8),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromARGB(255, 17, 69, 129),
                      blurRadius: 10,
                      offset: Offset(2.0, 5.0),
                    ),
                  ],
                  gradient: const LinearGradient(
                    colors: [
                      Color.fromARGB(255, 30, 108, 196),
                      Color.fromARGB(255, 71, 152, 246),
                    ],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8),
                  child: Text(
                    selectedYear ?? '',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      height: 1.0,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      drawer: DrawerManu(menu: menu),
      body: ChangeNotifierProvider<MaintenanceReportViewViewModel>(
        create: (BuildContext context) => maintenanceReportViewViewModel,
        child: Consumer<MaintenanceReportViewViewModel>(
          builder: (context, value, _) {
            switch (value.maintenanceReportViewGetTabularDataNew.status) {
              case Status.LOADING:
                return const Center(child: CircularProgressIndicator());
              case Status.ERROR:
                return Padding(
                  padding: const EdgeInsets.only(
                    top: 16.0,
                    bottom: 16,
                    left: 8,
                    right: 8,
                  ),
                  child: Center(
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/empty_box.png',
                            height: 200,
                            width: 200,
                            fit: BoxFit.cover,
                          ),
                          const Center(
                            child: Text(
                              'Sorry, Data Not Found!',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Color.fromARGB(255, 7, 59, 120),
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              case Status.COMPLETED:
                if (allData.isEmpty) {
                  allData = List.from(
                    value
                        .maintenanceReportViewGetTabularDataNew
                        .data!
                        .findAllJoinDatas!,
                  );

                  filteredList = List.from(allData);
                }
                return RefreshIndicator(
                  onRefresh: () async {
                    _input.clear();
                    selectedSubstation = null;
                    selectedFeeder = null;
                    selectedSubstation = null;
                    selectedFeeder = null;
                    maintenanceReportViewViewModel
                        .fetchMaintenanceReportViewTabularListApiNew(
                          context,
                          '',
                          '',
                          '',
                          '',
                          selectedYear.toString(),
                        );
                        _initializeScreen();
                  },
                  child: Container(
                    margin: const EdgeInsets.only(
                      left: 8,
                      right: 8,
                      top: 10,
                      bottom: 8,
                    ),
                    padding: const EdgeInsets.all(8),
                    alignment: Alignment.center,
                    height: size.height * 1,
                    width: size.width * 0.99,
                    decoration: BoxDecoration(
                      // shape: BoxShape.circle,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromARGB(255, 7, 59, 120),
                          blurRadius: 10,
                          offset: Offset(2.0, 5.0),
                        ),
                      ],
                      gradient: const LinearGradient(
                        colors: [
                          Color.fromARGB(255, 255, 255, 255),
                          Color.fromARGB(255, 255, 255, 255),
                        ],
                      ),
                    ),
                    child: Column(
                      children: [
                        (primaryRoleText != userTypeText)
                            ? Padding(
                                padding: EdgeInsets.only(top: 8.0),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "$primaryRoleText, acting as $userTypeText.",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              )
                            : Container(),

                        // SingleChildScrollView(
                        //   scrollDirection: Axis.horizontal,
                        //   child: Row(
                        //     children: [
                        //       Container(
                        //         margin: const EdgeInsets.only(top: 10),
                        //         child: Column(
                        //           children: [
                        //             const Align(
                        //               alignment: Alignment.centerLeft,
                        //               child: Padding(
                        //                 padding: EdgeInsets.all(2.0),
                        //                 child: Text(
                        //                   "Substation",
                        //                   style: TextStyle(
                        //                     fontSize: 16.0,
                        //                     color: Color.fromARGB(
                        //                       255,
                        //                       7,
                        //                       59,
                        //                       120,
                        //                     ),
                        //                     fontWeight: FontWeight.bold,
                        //                   ),
                        //                 ),
                        //               ),
                        //             ),
                        //             Align(
                        //               alignment: Alignment.centerLeft,
                        //               child: Padding(
                        //                 padding: const EdgeInsets.all(2.0),
                        //                 child: SizedBox(
                        //                   width: 200,
                        //                   child: DropdownButtonFormField<String>(
                        //                     hint: const Text('-Select-'),
                        //                     dropdownColor: Colors.white,
                        //                     value: selectedSubstation,
                        //                     style: const TextStyle(
                        //                       color: Color.fromARGB(
                        //                         255,
                        //                         7,
                        //                         59,
                        //                         120,
                        //                       ),
                        //                       fontSize: 16,
                        //                     ),
                        //                     icon: const Icon(
                        //                       Icons.arrow_drop_down,
                        //                       color: Color.fromARGB(
                        //                         255,
                        //                         7,
                        //                         59,
                        //                         120,
                        //                       ),
                        //                       size: 40,
                        //                     ),
                        //                     decoration: const InputDecoration(
                        //                       enabledBorder: OutlineInputBorder(
                        //                         borderSide: BorderSide(
                        //                           color: Color.fromARGB(
                        //                             255,
                        //                             7,
                        //                             59,
                        //                             120,
                        //                           ),
                        //                         ),
                        //                       ),
                        //                       focusedBorder: OutlineInputBorder(
                        //                         borderSide: BorderSide(
                        //                           color: Color.fromARGB(
                        //                             255,
                        //                             7,
                        //                             59,
                        //                             120,
                        //                           ),
                        //                         ),
                        //                       ),
                        //                     ),
                        //                     isExpanded: true,
                        //                     items: maintenanceReportViewViewModel
                        //                         .maintenanceReportViewGetTabularDataNew
                        //                         .data!
                        //                         .findSubstationAndSubIds!
                        //                         .map((e) {
                        //                           return DropdownMenuItem(
                        //                             value: e.subId.toString(),
                        //                             // e.getIdAndSubstationByCountId![0].subStation.toString(),
                        //                             child: Text(
                        //                               e.subStation.toString(),
                        //                             ),
                        //                           );
                        //                         })
                        //                         .toList(),
                        //                     onChanged: (val) {
                        //                       if (selectedFeeder != null ||
                        //                           selectedType != null) {
                        //                         selectedFeeder = null;
                        //                       }
                        //                       fetchData('', val!, '');
                        //                       subId = int.parse(val);
                        //                       setState(() {
                        //                         selectedSubstation = val;
                        //                       });
                        //                     },
                        //                     validator: (value) => value == null
                        //                         ? 'field required'
                        //                         : null,
                        //                   ),
                        //                 ),
                        //               ),
                        //             ),
                        //           ],
                        //         ),
                        //       ),
                        //       Container(
                        //         margin: const EdgeInsets.only(top: 10),
                        //         child: Column(
                        //           children: [
                        //             const Align(
                        //               alignment: Alignment.centerLeft,
                        //               child: Padding(
                        //                 padding: EdgeInsets.all(2.0),
                        //                 child: Text(
                        //                   "Feeder",
                        //                   style: TextStyle(
                        //                     fontSize: 16.0,
                        //                     color: Color.fromARGB(
                        //                       255,
                        //                       7,
                        //                       59,
                        //                       120,
                        //                     ),
                        //                     fontWeight: FontWeight.bold,
                        //                   ),
                        //                 ),
                        //               ),
                        //             ),
                        //             Align(
                        //               alignment: Alignment.centerLeft,
                        //               child: Padding(
                        //                 padding: const EdgeInsets.all(2.0),
                        //                 child: SizedBox(
                        //                   width: 200,
                        //                   child: DropdownButtonFormField<String>(
                        //                     hint: const Text('-Select-'),
                        //                     dropdownColor: Colors.white,
                        //                     value: selectedFeeder,
                        //                     style: const TextStyle(
                        //                       color: Color.fromARGB(
                        //                         255,
                        //                         7,
                        //                         59,
                        //                         120,
                        //                       ),
                        //                       fontSize: 16,
                        //                     ),
                        //                     icon: const Icon(
                        //                       Icons.arrow_drop_down,
                        //                       color: Color.fromARGB(
                        //                         255,
                        //                         7,
                        //                         59,
                        //                         120,
                        //                       ),
                        //                       size: 40,
                        //                     ),
                        //                     decoration: const InputDecoration(
                        //                       enabledBorder: OutlineInputBorder(
                        //                         borderSide: BorderSide(
                        //                           color: Color.fromARGB(
                        //                             255,
                        //                             7,
                        //                             59,
                        //                             120,
                        //                           ),
                        //                         ),
                        //                       ),
                        //                       focusedBorder: OutlineInputBorder(
                        //                         borderSide: BorderSide(
                        //                           color: Color.fromARGB(
                        //                             255,
                        //                             7,
                        //                             59,
                        //                             120,
                        //                           ),
                        //                         ),
                        //                       ),
                        //                     ),
                        //                     isExpanded: true,
                        //                     items: maintenanceReportViewViewModel
                        //                         .maintenanceReportViewGetTabularDataNew
                        //                         .data!
                        //                         .findAllFdrBySubstation!
                        //                         .map((e) {
                        //                           return DropdownMenuItem(
                        //                             value: e.feedrId.toString(),
                        //                             // e.getIdAndSubstationByCountId![0].subStation.toString(),
                        //                             child: Text(
                        //                               e.feederName.toString(),
                        //                             ),
                        //                           );
                        //                         })
                        //                         .toList(),
                        //                     onChanged: (val) {
                        //                       if (selectedType != null) {
                        //                         selectedType = null;
                        //                       }
                        //                       fetchData(
                        //                         '',
                        //                         selectedSubstation,
                        //                         val!,
                        //                       );
                        //                       feederId = int.parse(val);
                        //                       setState(() {
                        //                         selectedFeeder = val;
                        //                       });
                        //                     },
                        //                     validator: (value) => value == null
                        //                         ? 'field required'
                        //                         : null,
                        //                   ),
                        //                 ),
                        //               ),
                        //             ),
                        //           ],
                        //         ),
                        //       ),
                        //       Container(
                        //         margin: const EdgeInsets.only(top: 10),
                        //         child: Column(
                        //           children: [
                        //             const Align(
                        //               alignment: Alignment.centerLeft,
                        //               child: Padding(
                        //                 padding: EdgeInsets.all(2.0),
                        //                 child: Text(
                        //                   "Type",
                        //                   style: TextStyle(
                        //                     fontSize: 16.0,
                        //                     color: Color.fromARGB(
                        //                       255,
                        //                       7,
                        //                       59,
                        //                       120,
                        //                     ),
                        //                     fontWeight: FontWeight.bold,
                        //                   ),
                        //                 ),
                        //               ),
                        //             ),
                        //             Align(
                        //               alignment: Alignment.centerLeft,
                        //               child: Padding(
                        //                 padding: const EdgeInsets.all(2.0),
                        //                 child: SizedBox(
                        //                   width: 400,
                        //                   child: DropdownButtonFormField<String>(
                        //                     hint: const Text('-Select-'),
                        //                     dropdownColor: Colors.white,
                        //                     value: selectedType,
                        //                     style: const TextStyle(
                        //                       color: Color.fromARGB(
                        //                         255,
                        //                         7,
                        //                         59,
                        //                         120,
                        //                       ),
                        //                       fontSize: 16,
                        //                     ),
                        //                     icon: const Icon(
                        //                       Icons.arrow_drop_down,
                        //                       color: Color.fromARGB(
                        //                         255,
                        //                         7,
                        //                         59,
                        //                         120,
                        //                       ),
                        //                       size: 40,
                        //                     ),
                        //                     decoration: const InputDecoration(
                        //                       enabledBorder: OutlineInputBorder(
                        //                         borderSide: BorderSide(
                        //                           color: Color.fromARGB(
                        //                             255,
                        //                             7,
                        //                             59,
                        //                             120,
                        //                           ),
                        //                         ),
                        //                       ),
                        //                       focusedBorder: OutlineInputBorder(
                        //                         borderSide: BorderSide(
                        //                           color: Color.fromARGB(
                        //                             255,
                        //                             7,
                        //                             59,
                        //                             120,
                        //                           ),
                        //                         ),
                        //                       ),
                        //                     ),
                        //                     isExpanded: true,
                        //                     items: maintenanceReportViewViewModel
                        //                         .maintenanceReportViewGetTabularDataNew
                        //                         .data!
                        //                         .findAllTypeBySubstations!
                        //                         .map((e) {
                        //                           return DropdownMenuItem(
                        //                             value: e.type.toString(),
                        //                             // e.getIdAndSubstationByCountId![0].subStation.toString(),
                        //                             child: Text(
                        //                               e.type.toString(),
                        //                             ),
                        //                           );
                        //                         })
                        //                         .toList(),
                        //                     onChanged: (val) {
                        //                       fetchData(
                        //                         val!,
                        //                         selectedSubstation,
                        //                         selectedFeeder,
                        //                       );
                        //                       // workOrderNoId = int.parse(val);
                        //                       setState(() {
                        //                         selectedType = val;
                        //                       });
                        //                     },
                        //                     validator: (value) => value == null
                        //                         ? 'field required'
                        //                         : null,
                        //                   ),
                        //                 ),
                        //               ),
                        //             ),
                        //           ],
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              "TOTAL NO OF RECORDS : ${filteredList.length.toString()}",
                              style: const TextStyle(
                                fontSize: 16,
                                color: Color.fromARGB(255, 7, 59, 120),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 4.0,
                                    right: 4.0,
                                    top: 4,
                                    bottom: 4,
                                  ),
                                  child: TextFormField(
                                    onChanged: (value) => _filterData(value),
                                    //  key: formkey2,
                                    controller: _input,
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 7, 59, 120),
                                      fontSize: 16,
                                    ),
                                    obscureText: false,

                                    // keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color.fromARGB(255, 23, 1, 88),
                                        ),
                                        // borderRadius:
                                        //     BorderRadius.circular(25),
                                      ),
                                      hintText:
                                          'Search by Substation/Feeder/Job No/Master Job No',
                                    ),
                                    validator: (value) {
                                      if (value!.toString == 'null') {
                                        return "Please search your input";
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: ListView.builder(
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemCount: filteredList.length,
                            itemBuilder: (BuildContext ctxt, int index) {
                              var item = filteredList[index];
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 6,
                                ),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) =>
                                            GFMaintenanceReportViewDetailsScreen(
                                              tokenNo: item.tokenNo.toString(),
                                            ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: getCardColor(item.status),
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.2),
                                          blurRadius: 6,
                                          offset: const Offset(2, 4),
                                        ),
                                      ],
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          /// 🔹 TOP ROW (Job No + Status Badge)
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "JOB NO: ${item.tokenNo}",
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              ),

                                              /// STATUS BADGE
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 4,
                                                    ),
                                                decoration: BoxDecoration(
                                                  color: getStatusColor(
                                                    item.status,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                child: Text(
                                                  item.status ?? "",
                                                  style: const TextStyle(
                                                    fontSize: 11,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),

                                          const SizedBox(height: 10),
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.numbers,
                                                size: 16,
                                                color: Colors.black,
                                              ),
                                              const SizedBox(width: 6),
                                              Expanded(
                                                child: Text(
                                                  "MASTER JOB NO. : ${(item.masterJobNo == null || item.masterJobNo.toString().trim().isEmpty || item.masterJobNo.toString().trim().toLowerCase() == 'null' || item.masterJobNo.toString().trim().toUpperCase() == 'N/A') ? '' : item.masterJobNo.toString()}",
                                                  style: const TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 4),

                                          ///  SUBSTATION ROW
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.location_on,
                                                size: 16,
                                                color: Colors.black,
                                              ),
                                              const SizedBox(width: 6),
                                              Expanded(
                                                child: Text(
                                                  "SUBSTATION : ${item.subStationName ?? ""}",
                                                  style: const TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 4),

                                          ///  FEEDER ROW
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.work,
                                                size: 16,
                                                color: Colors.black,
                                              ),
                                              const SizedBox(width: 6),
                                              Expanded(
                                                child: Text(
                                                  "FEEDER : ${item.feederName ?? ""}",
                                                  style: const TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),

                                          const SizedBox(height: 4),

                                          ///  TYPE ROW
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.build,
                                                size: 16,
                                                color: Colors.black,
                                              ),
                                              const SizedBox(width: 6),
                                              Expanded(
                                                child: Text(
                                                  "TYPE : ${item.maintType ?? ""}",
                                                  style: const TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 8),
                                          Container(
                                            height: 1,
                                            color: Colors.black12,
                                          ),
                                          const SizedBox(height: 10),
                                          Row(
                                            children: [
                                              (item.showICon == "TRUE")
                                                  ? InkWell(
                                                      onTap:
                                                          loadingIndex == index
                                                          ? null
                                                          : () async {
                                                              await sendForLcpInspection(
                                                                item.tokenNo
                                                                    .toString(),
                                                                index,
                                                              );
                                                            },
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            12,
                                                          ),
                                                      child: Container(
                                                        constraints:
                                                            const BoxConstraints(
                                                              minWidth: 150,
                                                            ),
                                                        padding:
                                                            const EdgeInsets.symmetric(
                                                              vertical: 4,
                                                              horizontal: 6,
                                                            ),
                                                        decoration: BoxDecoration(
                                                          gradient:
                                                              const LinearGradient(
                                                                colors: [
                                                                  Color(
                                                                    0xFF1565C0,
                                                                  ),
                                                                  Color(
                                                                    0xFF42A5F5,
                                                                  ),
                                                                ],
                                                              ),
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                12,
                                                              ),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Colors.blue
                                                                  .withOpacity(
                                                                    0.30,
                                                                  ),
                                                              blurRadius: 10,
                                                              offset:
                                                                  const Offset(
                                                                    0,
                                                                    5,
                                                                  ),
                                                            ),
                                                          ],
                                                        ),
                                                        child:
                                                            loadingIndex ==
                                                                index
                                                            ? Center(
                                                                child: const SizedBox(
                                                                  height: 15,
                                                                  width: 15,
                                                                  child: CircularProgressIndicator(
                                                                    strokeWidth:
                                                                        2.5,
                                                                    valueColor:
                                                                        AlwaysStoppedAnimation<
                                                                          Color
                                                                        >(
                                                                          Colors
                                                                              .white,
                                                                        ),
                                                                  ),
                                                                ),
                                                              )
                                                            : Text(
                                                                "Send For LCP Inspection",
                                                                style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 11,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  letterSpacing:
                                                                      0.3,
                                                                ),
                                                              ),
                                                      ),
                                                    )
                                                  : Spacer(),
                                              Spacer(),
                                              const Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "View Details",
                                                    style: TextStyle(
                                                      fontSize: 11,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  Icon(
                                                    Icons.arrow_forward_ios,
                                                    size: 14,
                                                    color: Colors.black,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );

              default:
                return const Text('data');
            }
          },
        ),
      ),
    );
  }

  void _filterData(String query) {
    setState(() {
      if (query.trim().isEmpty) {
        filteredList = List.from(allData);
      } else {
        final q = query.toLowerCase();

        filteredList = allData.where((item) {
          return item.tokenNo.toString().toLowerCase().contains(q) ||
              (item.masterJobNo ?? "").toLowerCase().contains(q) ||
              (item.subStationName ?? "").toLowerCase().contains(q) ||
              (item.feederName ?? "").toLowerCase().contains(q) ||
              (item.maintType ?? "").toLowerCase().contains(q) ||
              (item.status ?? "").toLowerCase().contains(q);
        }).toList();
      }
    });
  }

  Future<void> sendForLcpInspection(String tokenNo, int index) async {
    setState(() {
      loadingIndex = index;
    });
    try {
      final userPreferences = Provider.of<UserPref>(context, listen: false);
      UserModel data = await userPreferences.getUser();

      var api =
          "${AppUrl.baseUrl}work_order_pending_approval/updateStatusByTokenNo?tokenNo=$tokenNo&status=PENDING LCP INSPECTION";
      final url = Uri.parse(api);

      final response = await http.put(
        url,
        headers: {
          "Authorization": "Bearer ${data.token}",
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
          "Sent for LCP Inspection successfully.",
          context,
        );
        await Future.delayed(const Duration(seconds: 2));
        maintenanceReportViewViewModel
            .fetchMaintenanceReportViewTabularListApiNew(
              context,
              '',
              '',
              '',
              '',
              selectedYear.toString(),
            );
      } else {
        CustomToastSnackBarProgressDialog.flushBarErrorMessage(
          "Something went wrong.",
          context,
        );
      }
    } catch (e) {
      CustomToastSnackBarProgressDialog.flushBarErrorMessage(
        e.toString(),
        context,
      );
    } finally {
      if (mounted) {
        setState(() {
          loadingIndex = null;
        });
      }
    }
  }

  void showYearFilterDialog() {
    allData.clear();
    filteredList.clear();
    final String currentYear = DateTime.now().year.toString();

    // if (selectedYear == null || !years.contains(selectedYear)) {
    //   selectedYear = years.contains(currentYear)
    //       ? currentYear
    //       : null;
    // }
    final String initialYear =
        (widget.year != '' && years.contains(widget.year))
        ? widget.year
        : (years.contains(currentYear) ? currentYear : '');

    if (selectedYear == null || !years.contains(selectedYear)) {
      selectedYear = initialYear;
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
                style: TextStyle(fontWeight: FontWeight.bold),
              ),

              content: DropdownButtonFormField<String>(
                value: years.contains(tempSelectedYear)
                    ? tempSelectedYear
                    : null,

                isExpanded: true,

                decoration: InputDecoration(
                  labelText: "Select Year",
                  prefixIcon: const Icon(Icons.calendar_today_rounded),
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

                    print("Selected Year: $selectedYear");

                    maintenanceReportViewViewModel
                        .fetchMaintenanceReportViewTabularListApiNew(
                          context,
                          '',
                          '',
                          '',
                          '',
                          selectedYear.toString(),
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

  Future<void> getUserType() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String userType = pref.getString('userType').toString();
    String primaryRole = pref.getString('primaryRole').toString();
    if (userType == '3') {
      userTypeText = 'General Foreman';
    } else if (userType == '6') {
      userTypeText = 'Planner';
    }
    if (primaryRole == '3') {
      primaryRoleText = 'General Foreman';
    } else if (primaryRole == '6') {
      primaryRoleText = 'Planner';
    }
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
    await Future.delayed(const Duration(seconds: 2));
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
  bool isDrawerLoading = true;
  // String? _imagePath;

  @override
  void initState() {
    setUserName();
    _loadData();
    super.initState();
  }

  Future<void> _loadData() async {
    await setUserName();
    await getUserDetailsByUsername();

    setState(() {
      isDrawerLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final userPreferences = Provider.of<UserPref>(context);
    var provider = Provider.of<LocationProvider>(context, listen: true);
    final browser = MyChromeSafariBrowser();
    if (isDrawerLoading) {
      return const Drawer(child: Center(child: CircularProgressIndicator()));
    }
    return Drawer(
      child: Column(
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
                menuLogoLCP(),
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
                  leading: const Icon(Icons.computer),
                  title: const Text('General Foreman Dashboard'),
                  textColor: const Color.fromARGB(255, 7, 59, 120),
                  iconColor: const Color.fromARGB(255, 7, 59, 120),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const ContractorBottomNavigationPannel(),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.settings_applications_sharp),
                  title: const Text('Maintenance Report View'),
                  textColor: const Color.fromARGB(255, 7, 59, 120),
                  iconColor: const Color.fromARGB(255, 7, 59, 120),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                // ),
                ListTile(
                  leading: const Icon(Icons.change_circle),
                  title: const Text('IVM/Change Order'),
                  textColor: const Color.fromARGB(255, 7, 59, 120),
                  iconColor: const Color.fromARGB(255, 7, 59, 120),
                  onTap: () {
                    // Navigator.of(context).push(MaterialPageRoute(
                    //     builder: (BuildContext context) =>
                    //         const ChangeOrderContractor()));
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) => Inspection(year: ''),
                      ),
                    );
                  },
                ),

                // ListTile(
                //   leading: const Icon(
                //     Icons.list_alt,
                //   ),
                //   title: const Text('Invoice Form'),
                //   textColor: const Color.fromARGB(255, 7, 59, 120),
                //   iconColor: const Color.fromARGB(255, 7, 59, 120),
                //   onTap: () {
                //     Navigator.of(context).push(MaterialPageRoute(
                //         builder: (BuildContext context) =>
                //             const InvoiceFormContractor()));
                //   },
                // ),

                // ListTile(
                //   leading: const Icon(
                //     Icons.create,
                //   ),
                //   title: const Text('Create Invoice'),
                //   textColor: const Color.fromARGB(255, 7, 59, 120),
                //   iconColor: const Color.fromARGB(255, 7, 59, 120),
                //   onTap: () {
                //     Navigator.of(context).push(MaterialPageRoute(
                //         builder: (BuildContext context) =>
                //             const CreateInvoiceContractor()));
                //   },
                // ),
                // ListTile(
                //   leading: const Icon(
                //     Icons.list,
                //   ),
                //   title: const Text('Invoice List'),
                //   textColor: const Color.fromARGB(255, 7, 59, 120),
                //   iconColor: const Color.fromARGB(255, 7, 59, 120),
                //   onTap: () {
                //     Navigator.of(context).push(MaterialPageRoute(
                //         builder: (BuildContext context) =>
                //             const InvoiceListContrator()));
                //   },
                // ),
                // ListTile(
                //   leading: const Icon(Icons.map),
                //   title: const Text('IVM Offline Map'),
                //   textColor: const Color.fromARGB(255, 7, 59, 120),
                //   iconColor: const Color.fromARGB(255, 7, 59, 120),
                //   onTap: () async {
                //     String id = '';
                //     final userPreferences1 = Provider.of<UserPref>(
                //       context,
                //       listen: false,
                //     );
                //     UserModel data = await userPreferences1.getUser();
                //     id = data.user!.id.toString();
                //     // Navigator.push(
                //     //   context,
                //     //   MaterialPageRoute(
                //     //     builder: (context) => MapViewPage(
                //     //       url:
                //     //           "https://lcpmapapi.ariespro.com/main/ivm_map_view/CIVM_Map/USRQWXH589Z/$id",
                //     //     ),
                //     //   ),
                //     // );
                //     await browser.open(
                //       url: WebUri(
                //         "https://lcpmapapi.ariespro.com/main/ivm_map_view/CIVM_Map/USRQWXH589Z/$id",
                //       ),
                //       //crew id in place of id in above line
                //       settings: ChromeSafariBrowserSettings(
                //         shareState: CustomTabsShareState.SHARE_STATE_OFF,
                //         barCollapsingEnabled: true,
                //       ),
                //     );
                //   },
                // ),

                // ListTile(
                //   leading: const Icon(Icons.map_outlined),
                //   title: const Text('Herbicide Offline Map'),
                //   textColor: const Color.fromARGB(255, 7, 59, 120),
                //   iconColor: const Color.fromARGB(255, 7, 59, 120),
                //   onTap: () async {
                //     String id = '';
                //     final userPreferences1 = Provider.of<UserPref>(
                //       context,
                //       listen: false,
                //     );
                //     UserModel data = await userPreferences1.getUser();
                //     id = data.user!.id.toString();
                //     // Navigator.push(
                //     //   context,
                //     //   MaterialPageRoute(
                //     //     builder: (context) => MapViewPage(
                //     //       url:
                //     //           "https://lcpmapapi.ariespro.com/main/mid_cycle/CIVM_Map/USRQWXH589Z/$id",
                //     //     ),
                //     //   ),
                //     // );
                //     await browser.open(
                //       url: WebUri(
                //         "https://lcpmapapi.ariespro.com/main/mid_cycle/CIVM_Map/USRQWXH589Z/$id",
                //       ),
                //       //crew id in place of id in above line
                //       settings: ChromeSafariBrowserSettings(
                //         shareState: CustomTabsShareState.SHARE_STATE_OFF,
                //         barCollapsingEnabled: true,
                //       ),
                //     );
                //   },
                // ),
                // ListTile(
                //   leading: const Icon(Icons.location_searching),
                //   title: const Text('Offline Maintenance Map'),
                //   textColor: const Color.fromARGB(255, 7, 59, 120),
                //   iconColor: const Color.fromARGB(255, 7, 59, 120),
                //   onTap: () async {
                //     String id = '';
                //     final userPreferences1 = Provider.of<UserPref>(
                //       context,
                //       listen: false,
                //     );
                //     UserModel data = await userPreferences1.getUser();
                //     id = data.user!.id.toString();
                //     // Navigator.push(
                //     //   context,
                //     //   MaterialPageRoute(
                //     //     builder: (context) => MapViewPage(
                //     //       url:
                //     //           "https://lcpmapapi.ariespro.com/main/change_order_view/CIVM_Map/USRQWXH589Z/$id",
                //     //     ),
                //     //   ),
                //     // );

                //     await browser.open(
                //       url: WebUri(
                //         "https://lcpmapapi.ariespro.com/main/change_order_view/CIVM_Map/USRQWXH589Z/$id",
                //       ),
                //       //crew id in place of id in above line
                //       settings: ChromeSafariBrowserSettings(
                //         shareState: CustomTabsShareState.SHARE_STATE_OFF,
                //         barCollapsingEnabled: true,
                //       ),
                //     );
                //   },
                // ),
                ListTile(
                  leading: Icon(Icons.location_on),
                  title: const Text('Live IVM System Map'),
                  textColor: const Color.fromARGB(255, 7, 59, 120),
                  iconColor: const Color.fromARGB(255, 7, 59, 120),
                  onTap: () {
                    provider.getLocation();
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const MapScreenLeafLat(),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.add),
                  title: const Text('Add Crew Member'),
                  textColor: const Color.fromARGB(255, 7, 59, 120),
                  iconColor: const Color.fromARGB(255, 7, 59, 120),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const GFAddCrewMember(),
                      ),
                    );
                  },
                ),
                // ignore: unnecessary_null_comparison
                (Constants.prefs
                            .getString('additionalUserType')
                            .toString()
                            .isNotEmpty &&
                        Constants.prefs
                                .getString('additionalUserType')
                                .toString() !=
                            'null')
                    ? ListTile(
                        leading: const Icon(Icons.refresh),
                        title: const Text('Switch Panel'),
                        textColor: const Color.fromARGB(255, 7, 59, 120),
                        iconColor: const Color.fromARGB(255, 7, 59, 120),
                        onTap: () {
                          _openLoginDialog(context);
                        },
                      )
                    : Container(),
                ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text('Log Out'),
                  textColor: const Color.fromARGB(255, 7, 59, 120),
                  iconColor: const Color.fromARGB(255, 7, 59, 120),
                  onTap: () {
                    // // Constants.prefs.setBool("LoggedIn", false);
                    userPreferences.remove().then((value) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) => const LoginPage(),
                        ),
                      );
                    });
                    // Navigator.of(context).pushReplacement(MaterialPageRoute(
                    //     builder: (BuildContext context) => const LoginPage()));
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
    );
  }

  Future<void> setUserName() async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    Image.network(
      'https://civm.ariespro.com/assets/clientuploads/${data.user!.profilePhoto}',
    );
    // String imageUrl =
    //     'https://civm.ariespro.com/assets/clientuploads/${data.user!.profilePhoto}';
    // _imagePath = imageUrl;
    setState(() {
      userName = '${data.user!.fName} ${data.user!.lName}';
    });
  }

  Future<void> _openLoginDialog(BuildContext context) async {
   // Show loader
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return const Center(child: CircularProgressIndicator());
      },
    );

    // Wait for API
    final bool isValid = await checkCurrentUserDrawer();

    if (!mounted) return;

    // Close loader
    Navigator.of(context, rootNavigator: true).pop();

    // API returned false
    if (!isValid) {
      Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const LoginPage()),
        (route) => false,
      );

      return;
    }

    // API returned true
    bool isLoading = false;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              titlePadding: const EdgeInsets.fromLTRB(24, 20, 12, 0),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Switch Panel',
                    style: TextStyle(
                      color: Color.fromARGB(255, 7, 59, 120),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.grey),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              content: SizedBox(
                width: 280,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (isLoading) ...[
                      const Padding(
                        padding: EdgeInsets.only(bottom: 20),
                        child: CircularProgressIndicator(),
                      ),
                      const Text(
                        "Switching panel...",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 20),
                    ],

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 45),
                        backgroundColor: const Color.fromARGB(255, 7, 59, 120),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: isLoading
                          ? null
                          : () async {
                              setDialogState(() {
                                isLoading = true;
                              });

                              bool success = await switchUser();

                              setDialogState(() {
                                isLoading = false;
                              });

                              if (success) {
                                Navigator.pop(context);

                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        PlannerBottomNavigationPannel(),
                                  ),
                                );
                              } else {
                                // Navigator.pop(context);
                                // showAccessDeniedDialog(this.context);
                                Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        const LoginPage(),
                                  ),
                                  (route) => false,
                                );
                              }
                            },
                      child: const Text(
                        "Work as Planner",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),

                    const SizedBox(height: 12),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 45),
                        backgroundColor: const Color.fromARGB(255, 7, 59, 120),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () async {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Work as General Foreman",
                        style: TextStyle(
                          color: Color.fromARGB(255, 151, 228, 248),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future<UserDetails?> getUserDetailsByUsername() async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    String email = data.user!.email.toString();
    var url = "${AppUrl.baseUrl}login_user/get_userDetails_by_username/$email";
    print('url: $url');
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          "Authorization": "Bearer ${data.token}",
          "Content-Type": "application/json",
        },
      );
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        String? userType = responseData["userDetails"]["userType"]?.toString();
        String? additionalUserType =
            responseData["userDetails"]["additionalUserType"]?.toString();
        final SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setString('userType', userType.toString());
        pref.setString('additionalUserType', additionalUserType.toString());
        print('additionalUserType:: $additionalUserType');
        return UserDetails.fromJson(responseData["userDetails"]);
      } else {
        print("Error : ${response.statusCode}");
        print(response.body);
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<bool> switchUser() async {
    try {
      final userPreferences = Provider.of<UserPref>(context, listen: false);

      UserModel user = await userPreferences.getUser();

      final String id = user.user!.id.toString();

      final uri =
          "${AppUrl.baseUrl}login_user/switchUser"
          "?loginId=$id"
          "&switchTo=6";

      print('uriuri:: $uri');

      final response = await http.put(
        Uri.parse(uri),
        headers: {
          "Authorization": "Bearer ${user.token}",
          "Content-Type": "application/json",
        },
      );

      print("Switch User Status : ${response.statusCode}");
      print("Switch User Response : ${response.body}");

      if (response.statusCode == 200) {
        final SharedPreferences pref = await SharedPreferences.getInstance();

        await pref.setString('userType', '6');

        print('userType:: ${pref.getString('userType')}');

        return true;
      }

      // ============================================================
      // SWITCH FAILED - SHOW ACCESS DENIED DIALOG
      // ============================================================
      // if (response.statusCode == 400) {
      //   showAccessDeniedDialog(context);
      //   return false;
      // }

      // // Any other error
      // showAccessDeniedDialog(context);
      return false;
    } catch (e) {
      print("switchUser Error : $e");

      // showAccessDeniedDialog(context);

      return false;
    }
  }

  void showAccessDeniedDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.cancel, color: Colors.red, size: 80),

              const SizedBox(height: 12),

              const Text(
                'Switch Failed',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 7, 59, 120),
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'Access Denied!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.red,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: 100,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(dialogContext).pop();
                  },
                  child: const Text('OK'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

 Future<bool> checkCurrentUserDrawer() async {
    print('planner authentication');

    try {
      final prefs = await SharedPreferences.getInstance();

      final fcmToken = prefs.getString('device_token_for_logOut');

      if (fcmToken == null || fcmToken.isEmpty) {
        print("FCM token not found in SharedPreferences");
        return false;
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

        if (responseData == true) {
          return true;
        }

        // API returned false
        if (responseData == false) {
          final userPreferences = Provider.of<UserPref>(context, listen: false);

          await userPreferences.remove();

          return false;
        }

        return false;
      }

      if (response.statusCode == 401) {
        print("Unauthorized - Bearer token is invalid or expired");
        return false;
      }

      print(
        "checkCurrentUser failed: "
        "${response.statusCode} - ${response.body}",
      );

      return false;
    } catch (e) {
      print("checkCurrentUser Error: $e");
      return false;
    }
  }

}
