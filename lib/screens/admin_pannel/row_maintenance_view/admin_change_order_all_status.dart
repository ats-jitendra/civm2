import 'package:CIVM/models/sup_change_order_all_status_model.dart';
import 'package:CIVM/models/user_model.dart';
import 'package:CIVM/resources/app_url.dart';
import 'package:CIVM/screens/admin_pannel/row_maintenance_view/add_new_row_table.dart';
import 'package:CIVM/screens/admin_pannel/row_maintenance_view/admin_job_details_screen.dart';
import 'package:CIVM/screens/admin_pannel/row_maintenance_view/admin_pannel.dart';
import 'package:CIVM/screens/admin_pannel/row_maintenance_view/user_management_tabs.dart';
import 'package:CIVM/screens/leaflat_map/leaf_lat_map_wakeLock.dart';
import 'package:CIVM/screens/login_page.dart';
import 'package:CIVM/screens/map/provider/location_provider.dart';
import 'package:CIVM/sharedPrefs/constants.dart';
import 'package:CIVM/utils/common_functions.dart';
import 'package:CIVM/utils/custom_toast_snackbar_progressdialog.dart';
import 'package:CIVM/utils/user_pref.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class AdminChangeOrderAllStatus extends StatefulWidget {
  String source;
  AdminChangeOrderAllStatus({required this.source, super.key});

  @override
  State<AdminChangeOrderAllStatus> createState() =>
      _AdminChangeOrderAllStatusState();
}

class _AdminChangeOrderAllStatusState extends State<AdminChangeOrderAllStatus>
    with TickerProviderStateMixin {
  TextEditingController searchController = TextEditingController();
  final List<Color> containerColors = [
    const Color.fromARGB(255, 252, 231, 238),
    const Color.fromARGB(255, 226, 246, 253),
    const Color.fromARGB(255, 212, 249, 212),
    const Color.fromARGB(255, 251, 251, 215),
    const Color.fromARGB(255, 251, 239, 251),
  ];

  Future? myFuture;
  List<SupChangeOrderAllStatusData> dataList = [];
  List<SupChangeOrderAllStatusData> filteredList = [];
  String auditId = '';
  String accountNumber = '';
  String status = '';
  bool isError = false;
  bool isLoading = false;
  String selectedCrewLoginID = '';
  List<Map<String, dynamic>> crewList = [];
  String? selectedCrew;
  List<String> menu = [];
  List<String> years = ["2021", "2022", "2023", "2024", "2025", "2026", "2027"];
  String? selectedYear;
  var selectedYearCurrent;
  int currentYear = DateTime.now().year;

  @override
  void initState() {
    selectedYear = selectedYearCurrent = currentYear.toString();
    myFuture = fetchData(selectedYear.toString());
       _initializeScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Change Order',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 7, 59, 120),
        actions: [
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
      body: SafeArea(
        child: FutureBuilder(
          future: myFuture,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            // API ERROR
            if (isError) {
              return buildNoDataWidget();
            }

            //  //EMPTY DATA
            //   if (energyAuditList.isEmpty) {
            //     return buildNoDataWidget();
            //   }

            // SUCCESS DATA
            return GestureDetector(
              onTap: () {
                FocusScopeNode currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
              },
              child: RefreshIndicator(
                onRefresh: () async {
                  await fetchData(selectedYear.toString());
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
                  height: size.height * 0.9,
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
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            "TOTAL NO OF RECORDS : ${dataList.length.toString()}",
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
                                  controller: searchController,
                                  onChanged: (value) =>
                                      filterData(value), // 👈 important
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
                                    hintText: 'Search your input...',
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
                                      builder: (_) => AdminJobDetailsScreen(
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
                                                "FEEDER : ${item.feeder ?? ""}",
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

                                        ///  DIVIDER
                                        Container(
                                          height: 1,
                                          color: Colors.black12,
                                        ),

                                        const SizedBox(height: 8),

                                        ///  BOTTOM ROW
                                        const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
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
                            //                               Row(
                            //                                 children: [
                            //                                   Padding(
                            //                                     padding: const EdgeInsets.all(4),
                            //                                     child: Container(
                            //                                       width: MediaQuery.of(context).size.width *
                            //                                           0.9,
                            //                                       padding: const EdgeInsets.all(8),
                            //                                       // decoration: BoxDecoration(
                            //                                       //   gradient: LinearGradient(
                            //                                       //     colors: [
                            //                                       //    const Color.fromARGB(
                            //                                       //             255, 7, 59, 120),
                            //                                       //               const Color.fromARGB(
                            //                                       //             255, 7, 59, 120),
                            //                                       //     ],
                            //                                       //   ),
                            //                                       //   borderRadius: BorderRadius.circular(10),
                            //                                       // ),
                            //                                       decoration: BoxDecoration(
                            //   color: getCardColor(item.status), //  dynamic color here
                            //   borderRadius: BorderRadius.circular(10),
                            // ),
                            //                                       child: Column(
                            //                                         children: [
                            //                                           Padding(
                            //                                             padding: const EdgeInsets.only(
                            //                                                 left: 8.0),
                            //                                             child: Row(
                            //                                               children: [
                            //                                                 Expanded(
                            //                                                   // alignment: Alignment.topLeft,
                            //                                                   child: Column(
                            //                                                     children: [
                            //                                                       const Align(
                            //                                                         alignment:
                            //                                                             Alignment.topLeft,
                            //                                                         child: Text(
                            //                                                           "JOB NO: ",
                            //                                                           textAlign:
                            //                                                               TextAlign.left,
                            //                                                           style: TextStyle(
                            //                                                             fontSize: 12,
                            //                                                             fontWeight:
                            //                                                                 FontWeight.bold,
                            //                                                             color: Colors.black,
                            //                                                           ),
                            //                                                         ),
                            //                                                       ),
                            //                                                       Align(
                            //                                                         alignment:
                            //                                                             Alignment.topLeft,
                            //                                                         child: Text(
                            //                                                           item.tokenNo
                            //                                                               .toString(),
                            //                                                           textAlign:
                            //                                                               TextAlign.left,
                            //                                                           style:
                            //                                                               const TextStyle(
                            //                                                             fontSize: 12,
                            //                                                             //  fontWeight:
                            //                                                             //      FontWeight.bold,
                            //                                                             color: Colors.black,
                            //                                                           ),
                            //                                                         ),
                            //                                                       ),
                            //                                                     ],
                            //                                                   ),
                            //                                                 ),
                            //                                                 Expanded(
                            //                                                   // alignment: Alignment.topLeft,
                            //                                                   child: Column(
                            //                                                     children: [
                            //                                                       Align(
                            //                                                         alignment:
                            //                                                             Alignment.topLeft,
                            //                                                         child: Text(
                            //                                                           "STATUS: ",
                            //                                                           textAlign:
                            //                                                               TextAlign.left,
                            //                                                           style: TextStyle(
                            //                                                             fontSize: 12,
                            //                                                             fontWeight:
                            //                                                                 FontWeight.bold,
                            //                                                             color: Colors.black,
                            //                                                           ),
                            //                                                         ),
                            //                                                       ),
                            //                                                       Align(
                            //                                                         alignment:
                            //                                                             Alignment.topLeft,
                            //                                                         child: Text(
                            //                                                           item.status
                            //                                                               .toString(),
                            //                                                           textAlign:
                            //                                                               TextAlign.left,
                            //                                                           style: TextStyle(
                            //                                                             fontSize: 12,
                            //                                                             //  fontWeight:
                            //                                                             //      FontWeight.bold,
                            //                                                             color: getStatusColor(
                            //                                                                 item.status), //  dynamic color
                            //                                                           ),
                            //                                                         ),
                            //                                                       ),
                            //                                                     ],
                            //                                                   ),
                            //                                                 ),
                            //                                                 Expanded(
                            //                                                   // alignment: Alignment.topLeft,
                            //                                                   child: Column(
                            //                                                     children: [
                            //                                                       const Align(
                            //                                                         alignment:
                            //                                                             Alignment.topLeft,
                            //                                                         child: Text(
                            //                                                           "SUBSTATION: ",
                            //                                                           textAlign:
                            //                                                               TextAlign.left,
                            //                                                           style: TextStyle(
                            //                                                             fontSize: 12,
                            //                                                             fontWeight:
                            //                                                                 FontWeight.bold,
                            //                                                             color: Colors.black,
                            //                                                           ),
                            //                                                         ),
                            //                                                       ),
                            //                                                       Align(
                            //                                                         alignment:
                            //                                                             Alignment.topLeft,
                            //                                                         child: Text(
                            //                                                           item.substation
                            //                                                               .toString(),
                            //                                                           textAlign:
                            //                                                               TextAlign.left,
                            //                                                           style:
                            //                                                               const TextStyle(
                            //                                                             fontSize: 12,
                            //                                                             //  fontWeight:
                            //                                                             //      FontWeight.bold,
                            //                                                             color: Colors.black,
                            //                                                           ),
                            //                                                         ),
                            //                                                       ),
                            //                                                     ],
                            //                                                   ),
                            //                                                 ),
                            //                                               ],
                            //                                             ),
                            //                                           ),

                            //                                         ],
                            //                                       ),
                            //                                     ),
                            //                                   ),
                            //                                 ],
                            //                               );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  String id = "";
  Future<void> fetchData(String year) async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    id = data.user!.id.toString();
    String allStatus = '';
    if (widget.source == '') {
      allStatus =
          "PENDING LCP APPROVAL,PENDING ZIELIES ASSIGNMENT,CANCELLED,COMPLETED";
    } else {
      allStatus = "PENDING LCP APPROVAL";
    }
    var url =
        "${AppUrl.iniciatedCancelWorkApprovalEndPoint}?status=$allStatus&id=$id&year=$year";
    // "${AppUrl.getAllDataEndPoint}?id=$id";

    print('url $url');

    var headers = {
      "Content-Type": "application/json",
      // "Authorization": "Bearer $token", //  Add this line
      "Authorization": 'Bearer ${data.token!}',
    };

    try {
      var response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        print(" API Success:");
        print(response.body);

        var data = jsonDecode(response.body);

        List list = data["data"] ?? [];

        setState(() {
          dataList = list
              .map((e) => SupChangeOrderAllStatusData.fromJson(e))
              .toList();

          filteredList = dataList;
          isError = false;
        });

        print(data["success"]);
      } else {
        print("❌ API Error: ${response.statusCode}");
        print(response.body);
        setState(() {
          isError = true;
        });
      }
    } catch (e) {
      setState(() {
        isError = true;
      });
      print("❌ Exception: $e");
    }
  }

  void filterData(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredList = dataList;
      });
    } else {
      setState(() {
        filteredList = dataList.where((item) {
          final searchText = query.toLowerCase();

          return (item.tokenNo ?? "").toString().toLowerCase().contains(
                searchText,
              ) ||
              (item.substation ?? "").toString().toLowerCase().contains(
                searchText,
              ) ||
              (item.feeder ?? "").toString().toLowerCase().contains(
                searchText,
              ) ||
              (item.maintType ?? "").toString().toLowerCase().contains(
                searchText,
              ) ||
              (item.status ?? "").toString().toLowerCase().contains(searchText);
        }).toList();
      });
    }
  }

  Future<void> updateFlagValue(String token) async {
    String url = "";
    // '';
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer ${data.token}',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      );

      print("url testing $url");
      if (response.statusCode == 200) {
        var responseBody = json.decode(response.body);
        print('responseBody $responseBody');
        //  String responceMessage = responseBody['message'];
        print('API call successful');

        CustomToastSnackBarProgressDialog.flushBarSuccessMessage(
          'Job no: $token  Successfully Shared with General Foreman',
          context,
        );
        print('Job no: $token  Successfully Shared with General Foreman');
        //  Navigator.pop(context);
        fetchData(selectedYear.toString());
      } else {
        print('Failed to update flag: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }

  Future<void> fetchCrewList() async {
    setState(() {
      isLoading = true;
    });

    String url =
        "https://atsdev2test.ariespro.com/civmapi/login_user/getAllSupervisorsAndContractors";

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);

        if (jsonResponse.containsKey("findAllContractorList") &&
            jsonResponse["findAllContractorList"] is List) {
          final List<dynamic> crewData = jsonResponse["findAllContractorList"];

          setState(() {
            crewList = crewData.map((e) {
              return {
                "id": e["id"].toString(),
                "name": e["fName"], // 👈 using fName here
              };
            }).toList();

            if (crewList.isNotEmpty) {
              selectedCrew = crewList[0]["id"];
            }
          });
        }
      } else {
        print("Error: ${response.statusCode}");
      }
    } catch (e) {
      print("Exception: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void showYearFilterDialog() {
    filteredList.clear();
    final String currentYear = DateTime.now().year.toString();

    if (selectedYear == null || !years.contains(selectedYear)) {
      selectedYear = years.contains(currentYear) ? currentYear : null;
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

                    myFuture = fetchData(selectedYear.toString());
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
                    leading: const Icon(Icons.open_in_new),
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
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.pending),
                    title: const Text('Change Order Job List'),
                    textColor: const Color.fromARGB(255, 7, 59, 120),
                    iconColor: const Color.fromARGB(255, 7, 59, 120),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.airplane_ticket_sharp),
                    title: const Text('IVM Maintenance Job List'),
                    textColor: const Color.fromARGB(255, 7, 59, 120),
                    iconColor: const Color.fromARGB(255, 7, 59, 120),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const AdminAddNewRowTable(),
                        ),
                      );
                    },
                  ),

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
                    leading: const Icon(Icons.group_add),
                    title: const Text('User Management'),
                    textColor: const Color.fromARGB(255, 7, 59, 120),
                    iconColor: const Color.fromARGB(255, 7, 59, 120),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const UserManagementTabs(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.logout),
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
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const LoginPage(),
                          ),
                        );
                      });
                      // Navigator.of(context).push(MaterialPageRoute(
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
