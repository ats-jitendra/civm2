import 'dart:convert';
import 'dart:io';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:CIVM/repository/map_url.dart';
import 'package:CIVM/models/add_new_row_maint_model.dart';
import 'package:CIVM/models/add_new_row_tabular_data.dart';
import 'package:CIVM/models/user_details.dart';
import 'package:CIVM/models/user_model.dart';
import 'package:CIVM/resources/app_url.dart';
import 'package:CIVM/screens/generalForeman_New_pannel/contractor_bottom_navigation.dart';
import 'package:CIVM/screens/my_chrome_safari_map_recording.dart';
import 'package:CIVM/screens/planner_pannel.dart/planner_add_new_row_maintenance_plan_table_tab1_detail_screen.dart';
import 'package:CIVM/utils/common_functions.dart';
import 'package:CIVM/utils/user_pref.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:upgrader/upgrader.dart';
// import 'package:url_launcher/url_launcher.dart';
import '../../../data/response/status.dart';
import '../../../utils/custom_toast_snackbar_progressdialog.dart';
import '../../../view_model/add_new_row_maintenance_plan_view_model.dart';
import 'package:http/http.dart' as http;
import 'package:CIVM/screens/planner_pannel.dart/planner_add_crew_memeber.dart';
import 'package:CIVM/screens/planner_pannel.dart/planner_change_order_all_status.dart';
import 'package:CIVM/sharedPrefs/constants.dart';
import 'package:CIVM/screens/leaflat_map/leaf_lat_map_wakeLock.dart';
import 'package:CIVM/screens/login_page.dart';
import 'package:CIVM/screens/map/provider/location_provider.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class PlannerAddNewRowTable extends StatefulWidget {
  const PlannerAddNewRowTable({Key? key}) : super(key: key);

  @override
  State<PlannerAddNewRowTable> createState() => _PlannerAddNewRowTableState();
}

class _PlannerAddNewRowTableState extends State<PlannerAddNewRowTable> {
  // int _currentIndex = 0;

  AddNewRowMaintModel? addNewRowMaintModel;

  List<String> menu = [];

  List<Map<String, dynamic>> listOfColumns = [];
  List<Map<String, dynamic>> listOfColumns1 = [];

  var result = [];

  final TextEditingController _input = TextEditingController();

  // ignore: prefer_typing_uninitialized_variables
  var selectedYear;

  onTappedBar(int index) {
    setState(() {
      // _currentIndex = index;
    });
  }

  bool _isVisibleCrewList = false;
  String now = DateFormat("yyyy-MM-dd hh:mm:ss").format(DateTime.now());

  final select_crewOrGF = ['Crew', 'General Foreman'];
  var crewOrGF = 'General Foreman';

  AddNewRowMaintenancePlanViewModel addNewRowMaintenancePlanViewModel =
      AddNewRowMaintenancePlanViewModel();

  final browser = MyChromeSafariBrowser();
  int currentYear = DateTime.now().year;
  final TextEditingController _workOrder = TextEditingController();


  String selectedCrewLoginID = '';
  List<Map<String, dynamic>> crewList = [];
  String? selectedCrew;

  bool isLoadingIVM = false;
  String userTypeText = '';
  String primaryRoleText = '';
  List<GetAlls> allData = [];
  List<GetAlls> filteredList = [];

  @override
  void initState() {
    selectedYear = currentYear.toString();
    addNewRowMaintenancePlanViewModel
        .fetchAddNewRowMaintenancePlanTabularListApi(
          context,
          currentYear.toString(),
          '',
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
          'IVM Maintenance Job List',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 7, 59, 120),
        actions: [
          InkWell(
            onTap: () {
              _initializeScreen();
              showFilterDialog();
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
          messages: UpgraderMessages(code: "Kindly update your app."),
        ),
        child: PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, result) async {
            if (didPop) {
              return;
            }
            showExitPopup(context);
          },
          child: ChangeNotifierProvider<AddNewRowMaintenancePlanViewModel>(
            create: (BuildContext context) => addNewRowMaintenancePlanViewModel,
            child: Consumer<AddNewRowMaintenancePlanViewModel>(
              builder: (context, value, _) {
                switch (value.addNewRowMaintenancePlanGetTabularData.status) {
                  case Status.LOADING:
                    return const Center(child: CircularProgressIndicator());
                  case Status.ERROR:
                    return
                    //  CustomToastSnackBarProgressDialog.flushBarErrorMessage(
                    //     value.addNewRowMaintenancePlanGetTabularData.message
                    //         .toString(),
                    //     context);
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 16.0,
                        bottom: 16,
                        left: 8,
                        right: 8,
                      ),
                      child: Center(
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
                    );
                  case Status.COMPLETED:
                    if (allData.isEmpty) {
                      allData = List.from(
                        value
                            .addNewRowMaintenancePlanGetTabularData
                            .data!
                            .getAlls!,
                      );

                      filteredList = List.from(allData);
                    }
                    return RefreshIndicator(
                      onRefresh: () async {
                        _input.clear();
                        // selectedYear = currentYear.toString();
                        allData.clear();
                        filteredList.clear();
                        await addNewRowMaintenancePlanViewModel
                            .fetchAddNewRowMaintenancePlanTabularListApi(
                              context,
                              // currentYear.toString(),
                              selectedYear,
                              '',
                            );
                            _initializeScreen();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          alignment: Alignment.center,
                          height: size.height * 1,
                          width: size.width * 0.99,
                          decoration: const BoxDecoration(
                            // shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromARGB(255, 7, 59, 120),
                                blurRadius: 10,
                                offset: Offset(2.0, 5.0),
                              ),
                            ],
                            gradient: LinearGradient(
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
                                      padding: EdgeInsets.only(
                                        top: 8.0,
                                        left: 8,
                                      ),
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
                              Row(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(top: 8.0, left: 8),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        "Total Record : ",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          color: Color.fromARGB(
                                            255,
                                            7,
                                            59,
                                            120,
                                          ),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Text(
                                      filteredList.length.toString(),
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(
                                        color: Color.fromARGB(255, 7, 59, 120),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Align(
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

                                    //keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color.fromARGB(255, 23, 1, 88),
                                        ),
                                      ),
                                      hintText:
                                          'Search by Substation/Feeder/Job No/Master Job No',
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Please search your input";
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: ListView.builder(
                                    physics:
                                        const AlwaysScrollableScrollPhysics(),
                                    itemCount: filteredList.length,
                                    itemBuilder: (BuildContext ctxt, int index) {
                                      var item = filteredList[index];
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 6,
                                        ),
                                        child: InkWell(
                                          onTap: () async {
                                            await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (_) =>
                                                    PlannerAddNewRowMaintenancePlanDetailsScreen(
                                                      tokenNo: item.tokenNo
                                                          .toString(),
                                                      year: item.nextMaintDue
                                                          .toString(),
                                                    ),
                                              ),
                                            );
                                            await addNewRowMaintenancePlanViewModel
                                                .fetchAddNewRowMaintenancePlanTabularListApi(
                                                  context,
                                                  currentYear.toString(),
                                                  '',
                                                );
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: getCardColor(item.status),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.2),
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
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "JOB NO: ${item.tokenNo}",
                                                        style: const TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold,
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
                                                              BorderRadius.circular(
                                                                20,
                                                              ),
                                                        ),
                                                        child: Text(
                                                          item.status ?? "",
                                                          style:
                                                              const TextStyle(
                                                                fontSize: 11,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .black,
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
                                                          style:
                                                              const TextStyle(
                                                                fontSize: 13,
                                                                color: Colors
                                                                    .black,
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
                                                          "SUBSTATION : ${item.substation ?? ""}",
                                                          style:
                                                              const TextStyle(
                                                                fontSize: 13,
                                                                color: Colors
                                                                    .black,
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
                                                          "FEEDER : ${item.feeder ?? ""}",
                                                          style:
                                                              const TextStyle(
                                                                fontSize: 13,
                                                                color: Colors
                                                                    .black,
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
                                                          "BUDGET TYPE : ${item.budgetType ?? ""}",
                                                          style:
                                                              const TextStyle(
                                                                fontSize: 13,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),

                                                  const SizedBox(height: 8),

                                                  ///  DIVIDER
                                                  Container(
                                                    height: 1,
                                                    color: Colors.black12,
                                                  ),

                                                  const SizedBox(height: 8),

                                                  ///  BOTTOM ROW
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
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );

                  default:
                    return const Text('data');
                }
              },
            ),
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

  void _filterData(String query) {
    setState(() {
      if (query.trim().isEmpty) {
        filteredList = List.from(allData);
      } else {
        final q = query.toLowerCase();

        filteredList = allData.where((item) {
          return item.tokenNo.toString().toLowerCase().contains(q) ||
              (item.masterJobNo ?? "").toLowerCase().contains(q) ||
              (item.substation ?? "").toLowerCase().contains(q) ||
              (item.feeder ?? "").toLowerCase().contains(q) ||
              (item.maintType ?? "").toLowerCase().contains(q) ||
              (item.status ?? "").toLowerCase().contains(q);
        }).toList();
      }
    });
  }

  Future<void> updateFlagValueIVM(String token, int flag, String status) async {
    String url =
        "${AppUrl.baseUrl}vma_row_custom_main_plan/updateFlagValueNew?token=$token&flag=$flag&crewId=$selectedCrewLoginID&status=$status";

    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer ${data.token}',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          // 'token': token,
          // 'flag': flag.toString(),
          // 'crewId': selectedCrewLoginID,
          // 'status': status
        },
      );
      print(
        "map data ${{'token': token, 'flag': flag.toString(), 'crewId': selectedCrewLoginID}}",
      );
      if (response.statusCode == 200) {
        var responseBody = json.decode(response.body);
        print('responseBody $responseBody');
        String generalForemanEmailId = responseBody['generalForemanEmailId'];
        print('generalForemanEmailId $generalForemanEmailId');
        print('API call successful');
        if (crewOrGF == 'Crew') {
          CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
            '$token IVM Maintenance Successfully Shared with Crew',
            context,
          );
        } else {
          CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
            '$token IVM Maintenance Successfully Shared with General Foreman',
            context,
          );
        }

        DateTime now = DateTime.now();
        var formatter = DateFormat('MM-dd-yyyy HH:mm:ss');
        String formattedDate = formatter.format(now);
        var subject = 'CIVM ROW';
        // var msg =
        //     'Job No. $token Row Maintenance Successfully Shared with you on $formattedDate.';
        var msg =
            'Job No. $token IVM Maintenance Successfully Shared with you on $formattedDate.';

        _sendMail(subject, msg, generalForemanEmailId);
        ////////****************message sending code*********************/////////////
        // sendSmsTulio("+917018775670", 'Hellow CIVM sms testing Twilio');
        // Navigator.pop(context);
        addNewRowMaintenancePlanViewModel
            .fetchAddNewRowMaintenancePlanTabularListApi(
              context,
              currentYear.toString(),
              '',
            );
        selectedYear = currentYear.toString();
        await Future.delayed(Duration(seconds: 3));
        // Navigator.pop(context);
        Navigator.pop(context);
      } else {
        print('Failed to update flag: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }

  Future<void> _sendMail(
    String subject,
    String content,
    String generalForemanEmailId,
  ) async {
    List<String> recipientsList = [];
    for (int i = 0; i < recipientsList.length; i++) {
      recipientsList.add(recipientsList[i]);
    }

    String username = 'ats.ariespro@gmail.com';
    String password = 'ahbfhcshjujvkgge';

    final smtpServer = gmail(username, password);
    final message = Message()
      ..from = Address(username, 'CIVM')
      ..recipients.addAll([
        // 'jitendra.kushwaha@ariespro.com',
        // 'preetika.patel@ariespro.com',
        generalForemanEmailId,
      ])
      ..subject = subject
      // ..html = "<h4>Hi,</h4>\n<p>${content}</p>";
      ..html =
          "<h4>Hi,</h4>\n<p>$content</p>\n<p>Note: DO NOT REPLY TO THIS EMAIL. </p>\n<p>Thank you, </p>\n<p>AriesPro Utilities</p>";

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
  }

  // Future<void> sendSmsTulio(String to, String message) async {
  //   final String url =
  //       'https://api.twilio.com/2010-04-01/Accounts/$accountSid/Messages.json';

  //   final response = await http.post(
  //     Uri.parse(url),
  //     headers: {
  //       'Authorization':
  //           'Basic ${base64Encode(utf8.encode('$accountSid:$authToken'))}',
  //       'Content-Type': 'application/x-www-form-urlencoded',
  //     },
  //     body: {'From': twilioNumber, 'To': to, 'Body': message},
  //   );

  //   if (response.statusCode == 201) {
  //     print('SMS sent successfully');
  //   } else {
  //     print('Failed to send SMS: ${response.statusCode}, ${response.body}');
  //   }
  // }

  bool isSubmitting = false; // loader state for YES button
  List<String> selectedCrewList = [];
  void showCrewDialogIVM(
    BuildContext context,
    String tokenNo,
    String type,
  ) async {
    await fetchCrewList(); // Fetch crew list before showing the dialog

    // String? selectedCrew; // Local state for dropdown selection
    String? errorMessage; // To show validation error message
    _workOrder.text = '${tokenNo} - ${type}';
    print('_workOrder.text ${_workOrder.text}');
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              title: const Text(
                "SELECT CREW",
                style: TextStyle(
                  fontSize: 20.0,
                  color: Color.fromARGB(255, 7, 59, 120),
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: isLoadingIVM
                  ? const Center(child: CircularProgressIndicator())
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "WORK ORDER",
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Color.fromARGB(255, 7, 59, 120),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: TextFormField(
                              enabled: false,
                              controller: _workOrder,
                              style: const TextStyle(
                                color: Color.fromARGB(255, 7, 59, 120),
                                fontSize: 16,
                              ),
                              obscureText: false,
                              // keyboardType:
                              //     TextInputType.number,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                    decimal: true,
                                    signed: false,
                                  ),
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                disabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(255, 7, 59, 120),
                                  ),
                                ),
                                hintText: '',
                              ),
                              maxLines: null,
                              minLines: 1,
                              expands: false,
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 8.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              // "BUDGET TYPE*",
                              "SHARE WITH*",
                              style: TextStyle(
                                fontSize: 16,
                                color: Color.fromARGB(255, 7, 59, 120),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: DropdownButtonFormField<String>(
                              hint: const Text('-Select-'),
                              dropdownColor: Colors.white,
                              value: crewOrGF,
                              style: const TextStyle(
                                color: Color.fromARGB(255, 7, 59, 120),
                                fontSize: 16,
                              ),
                              icon: const Icon(
                                Icons.arrow_drop_down,
                                color: Color.fromARGB(255, 7, 59, 120),
                                size: 40,
                              ),
                              decoration: const InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(255, 7, 59, 120),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(255, 7, 59, 120),
                                  ),
                                ),
                              ),
                              isExpanded: true,
                              items: select_crewOrGF
                                  .map(buildMenuItem)
                                  .toList(),
                              onChanged: (value) {
                                setStateDialog(() {
                                  crewOrGF = value!;
                                  _isVisibleCrewList =
                                      (crewOrGF ==
                                      'Crew'); // Correct way to update visibility
                                });
                              },
                              validator: (value) =>
                                  value == null ? 'field required' : null,
                            ),
                          ),
                        ),
                        Visibility(
                          visible: _isVisibleCrewList,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Column(
                              children: [
                                const Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "CREW NAME",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Color.fromARGB(255, 7, 59, 120),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                MultiSelectDialogField(
                                  items: crewList.map((crew) {
                                    return MultiSelectItem<String>(
                                      crew["loginId"].toString(),
                                      crew["name"],
                                    );
                                  }).toList(),
                                  listType: MultiSelectListType.CHIP,
                                  title: const Text("Select Crew"),
                                  // selectedColor: Colors.blue,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    //  borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: Color.fromARGB(255, 7, 59, 120),
                                      width: 1,
                                    ),
                                  ),
                                  buttonIcon: const Icon(
                                    Icons.arrow_drop_down,
                                    size: 40,
                                    color: Color.fromARGB(255, 7, 59, 120),
                                  ),
                                  buttonText: const Text(
                                    "Select Crew",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                                  ),

                                  onConfirm: (values) {
                                    setStateDialog(() {
                                      selectedCrewList = values.cast<String>();

                                      errorMessage = null; // Clear error
                                    });
                                    selectedCrewLoginID = selectedCrewList.join(
                                      ",",
                                    );

                                    print(selectedCrewList);
                                    print(
                                      'selectedCrewLoginID ${selectedCrewLoginID}',
                                    );
                                  },
                                ),

                                // DropdownButtonFormField<String>(
                                //   value: selectedCrew,
                                //   hint: const Text("Select Crew"),
                                //   isExpanded: true,
                                //   icon: const Icon(
                                //     Icons.arrow_drop_down,
                                //     color: Color.fromARGB(255, 7, 59, 120),
                                //     size: 40,
                                //   ),
                                //   decoration: const InputDecoration(
                                //     border: OutlineInputBorder(),
                                //     enabledBorder: OutlineInputBorder(
                                //       borderSide: BorderSide(
                                //         color: Color.fromARGB(255, 7, 59, 120),
                                //       ),
                                //     ),
                                //     focusedBorder: OutlineInputBorder(
                                //       borderSide: BorderSide(
                                //         color: Color.fromARGB(255, 7, 59, 120),
                                //         width: 2.0,
                                //       ),
                                //     ),
                                //   ),
                                //   items: crewList.map((crew) {
                                //     return DropdownMenuItem(
                                //       value: crew["loginId"].toString(),
                                //       child: Text(crew["name"]),
                                //     );
                                //   }).toList(),
                                //   onChanged: (value) {
                                //     setStateDialog(() {
                                //       selectedCrew = value;
                                //       errorMessage =
                                //           null; // Clear error when selected
                                //     });
                                //     selectedCrewLoginID = value.toString();
                                //   },
                                // ),
                                if (errorMessage !=
                                    null) // Show error if exists
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Text(
                                      errorMessage!,
                                      style: const TextStyle(
                                        color: Colors.red,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
              actions: [
                Align(
                  alignment: Alignment.center,
                  child: Row(
                    children: [
                      // NO Button
                      _buildDialogButtonIVM(
                        context,
                        text: "NO",
                        color: Colors.red,
                        onTap: () => Navigator.pop(dialogContext),
                      ),

                      // YES Button (with validation)
                      _buildDialogButtonIVM(
                        context,
                        text: "YES",
                        color: Colors.green,
                        isLoading: isSubmitting,
                        onTap: () async {
                          if (crewOrGF == 'Crew' && selectedCrewLoginID == "") {
                            print('22222222');
                            setStateDialog(() {
                              print('3333333');
                              errorMessage = "Please select a crew.";
                            });
                            print('44444');
                            return;
                          }
                          setStateDialog(() {
                            isSubmitting = true; // START LOADER
                          });
                          print('55555');
                          // Updating flag value based on selection
                          // if (crewOrGF == 'Crew') {
                          //   print('if condition');
                          //   updateFlagValue(tokenNo, 2);
                          // } else {
                          //   print('else condition');
                          //   updateFlagValue(tokenNo, 1);
                          // }
                          try {
                            if (crewOrGF == 'Crew') {
                              await updateFlagValueIVM(tokenNo, 2, "ASSIGNED");
                            } else {
                              await updateFlagValueIVM(
                                tokenNo,
                                1,
                                "PENDING ZIELIES ASSIGNMENT",
                              );
                            }

                            Navigator.pop(
                              dialogContext,
                            ); // close dialog after success
                          } catch (e) {
                            print(e);
                          } finally {
                            setStateDialog(() {
                              isSubmitting = false; // STOP LOADER
                            });
                          }
                          //
                        },
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> fetchCrewList() async {
    setState(() {
      isLoadingIVM = true;
    });

    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    // String contractorId = "";
    // data.user!.id.toString();

    String url = AppUrl.crewList;
    // "https://civmapi.ariespro.com/civmapi/login_user/getAllCrewFromCREWMASTER?contractorId=$contractorId";

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          "Authorization": 'Bearer ${data.token!}',
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);

        if (jsonResponse.containsKey("AllCrewListOfCrewMASTER") &&
            jsonResponse["AllCrewListOfCrewMASTER"] is List) {
          final List<dynamic> crewData =
              jsonResponse["AllCrewListOfCrewMASTER"];

          print('dataCrewList $crewData');

          setState(() {
            crewList = crewData
                .map((e) => {"loginId": e["loginId"], "name": e["name"]})
                .toList();
            // Optionally set a default value for selectedCrew (e.g., the first crew in the list)
            if (crewList.isNotEmpty) {
              selectedCrew = crewList[0]["loginId"].toString();
            }
          });
        } else {
          print("Unexpected response format: $jsonResponse");
        }
      } else {
        print("Error fetching crew: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    } finally {
      setState(() {
        isLoadingIVM = false;
      });
    }
  }

  // Helper function for dialog buttons
  Widget _buildDialogButtonIVM(
    BuildContext context, {
    required String text,
    required Color color,
    required VoidCallback onTap,
    bool isLoading = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(left: 6, top: 6.0, bottom: 10),
      child: InkWell(
        onTap: isLoading ? null : onTap, // disable while loading
        child: Container(
          margin: const EdgeInsets.only(bottom: 10.0),
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width * 0.25,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.8),
                blurRadius: 5,
                offset: const Offset(2.0, 5.0),
              ),
            ],
            gradient: LinearGradient(colors: [color, color]),
          ),
          child: Center(
            child: isLoading
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : Text(
                    text,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  void showFilterDialog() {
    String? tempSelectedYear = selectedYear;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              title: const Text(
                'Filter By Year',
                style: TextStyle(
                  color: Color.fromARGB(255, 7, 59, 120),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: SizedBox(
                width: double.maxFinite,
                child: DropdownButtonFormField<String>(
                  hint: const Text('-Select Year-'),
                  value: tempSelectedYear,
                  isExpanded: true,
                  dropdownColor: Colors.white,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 7, 59, 120),
                    fontSize: 16,
                  ),
                  icon: const Icon(
                    Icons.arrow_drop_down,
                    color: Color.fromARGB(255, 7, 59, 120),
                    size: 40,
                  ),
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 7, 59, 120),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 7, 59, 120),
                      ),
                    ),
                  ),
                  items: addNewRowMaintenancePlanViewModel
                      .addNewRowMaintenancePlanGetTabularData
                      .data!
                      .yearList!
                      .map((e) {
                        return DropdownMenuItem<String>(
                          value: e.year.toString(),
                          child: Text(e.year.toString()),
                        );
                      })
                      .toList(),
                  onChanged: (value) {
                    setDialogState(() {
                      tempSelectedYear = value;
                    });
                  },
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      color: Color.fromARGB(255, 7, 59, 120),
                      fontSize: 16,
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 7, 59, 120),
                  ),
                  onPressed: () {
                    allData.clear();
                    filteredList.clear();
                    setState(() {
                      selectedYear = tempSelectedYear;
                    });

                    Navigator.pop(context);

                    addNewRowMaintenancePlanViewModel
                        .fetchAddNewRowMaintenancePlanTabularListApi(
                          context,
                          selectedYear,
                          '',
                        );
                  },
                  child: const Text(
                    'Search',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            );
          },
        );
      },
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
                      color: Color.fromARGB(255, 7, 59, 120),
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
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red.shade800,
                        ),
                        child: const Text(
                          "Yes",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                        child: const Text(
                          "No",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
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

        print("Current User Response11: $responseData");

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
  bool isDrawerLoading = true;

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
                padding: EdgeInsets.zero,
                children: [
                  ListTile(
                    leading: const Icon(Icons.computer),
                    title: const Text('IVM Maintenance Job List'),
                    textColor: const Color.fromARGB(255, 7, 59, 120),
                    iconColor: const Color.fromARGB(255, 7, 59, 120),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.change_circle),
                    title: const Text('Change Order Job List'),
                    textColor: const Color.fromARGB(255, 7, 59, 120),
                    iconColor: const Color.fromARGB(255, 7, 59, 120),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              PlannerChangeOrderAllStatus(),
                        ),
                      );
                    },
                  ),

                  ListTile(
                    leading: const Icon(Icons.location_searching),
                    title: const Text('Add Row Maintenance Map'),
                    textColor: const Color.fromARGB(255, 7, 59, 120),
                    iconColor: const Color.fromARGB(255, 7, 59, 120),
                    onTap: () async {
                      String id = '';
                      final userPreferences1 = Provider.of<UserPref>(
                        context,
                        listen: false,
                      );
                      UserModel data = await userPreferences1.getUser();
                      id = data.user!.id.toString();
                      await browser.open(
                        url: WebUri(
                          // "https://mapapi.ariespro.com/main/planner/CIVM_Map/USRQWXH589Z"),
                          MapUrl.getPlannerWithoutTokenEndPoint(id),
                        ),
                        settings: ChromeSafariBrowserSettings(
                          shareState: CustomTabsShareState.SHARE_STATE_OFF,
                          barCollapsingEnabled: true,
                        ),
                      );
                    },
                  ),

                  // ListTile(
                  //   leading: const Icon(Icons.location_searching),
                  //   title: const Text('IVM System Map'),
                  //   textColor: const Color.fromARGB(255, 7, 59, 120),
                  //   iconColor: const Color.fromARGB(255, 7, 59, 120),
                  //   onTap: () {
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //         builder: (context) => const MapScreen(),
                  //       ),
                  //     );
                  //   },
                  // ),
                  ListTile(
                    leading: const Icon(Icons.location_on),
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
                              const PlannerAddCrewMember(),
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
                    title: const Text('Logout'),
                    textColor: const Color.fromARGB(255, 7, 59, 120),
                    iconColor: const Color.fromARGB(255, 7, 59, 120),
                    onTap: () {
                      userPreferences.remove().then((value) {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const LoginPage(),
                          ),
                        );
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
      'https://civm.ariespro.com/assets/clientuploads/${data.user!.profilePhoto}',
    );
    setState(() {
      String fName = (data.user!.fName == 'null')
          ? ''
          : data.user!.fName.toString();
      String lName = (data.user!.lName == 'null')
          ? ''
          : data.user!.lName.toString();
      // userName = '${data.user!.fName} ${(data.user!.lName) != null? data.user!.lName :''}';
      userName = '$fName $lName';
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
                      onPressed: () async {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Work as Planner",
                        style: TextStyle(
                          color: Color.fromARGB(255, 151, 228, 248),
                        ),
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

                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        ContractorBottomNavigationPannel(),
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
                        "Work as General Foreman",
                        style: TextStyle(color: Colors.white),
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
          "&switchTo=3";

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

        await pref.setString('userType', '3');

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
