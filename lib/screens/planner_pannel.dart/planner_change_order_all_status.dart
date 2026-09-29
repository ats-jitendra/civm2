import 'package:CIVM/models/gf_change_order_all_status_model.dart';
import 'package:CIVM/models/user_details.dart';
import 'package:CIVM/models/user_model.dart';
import 'package:CIVM/resources/app_url.dart';
import 'package:CIVM/screens/generalForeman_New_pannel/contractor_bottom_navigation.dart';
import 'package:CIVM/screens/leaflat_map/leaf_lat_map_wakeLock.dart';
import 'package:CIVM/screens/login_page.dart';
import 'package:CIVM/screens/map/provider/location_provider.dart';
import 'package:CIVM/screens/my_chrome_safari_map_recording.dart';
import 'package:CIVM/screens/planner_pannel.dart/planner_add_crew_memeber.dart';
import 'package:CIVM/screens/planner_pannel.dart/planner_add_new_row_table.dart';
import 'package:CIVM/screens/planner_pannel.dart/planner_job_details_screen.dart';
import 'package:CIVM/sharedPrefs/constants.dart';
import 'package:CIVM/utils/common_functions.dart';
import 'package:CIVM/utils/custom_toast_snackbar_progressdialog.dart';
import 'package:CIVM/utils/user_pref.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:CIVM/repository/map_url.dart';

// ignore: must_be_immutable
class PlannerChangeOrderAllStatus extends StatefulWidget {
  PlannerChangeOrderAllStatus({super.key});

  @override
  State<PlannerChangeOrderAllStatus> createState() =>
      _PlannerChangeOrderAllStatusState();
}

class _PlannerChangeOrderAllStatusState
    extends State<PlannerChangeOrderAllStatus>
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
  List<GFChangeOrderAllStatusData> dataList = [];
  List<GFChangeOrderAllStatusData> filteredList = [];
  String auditId = '';
  String accountNumber = '';
  String status = '';
  bool isError = false;
  bool isLoading = false;
  String selectedCrewLoginID = '';
  List<Map<String, dynamic>> crewList = [];
  String? selectedCrew;
  List<String> menu = [];
  String userTypeText = '';
  String primaryRoleText = '';
  // Dynamic year list: 2021 to 2027
  final List<String> yearList = List.generate(
    7,
    (index) => (2021 + index).toString(),
  );
  var selectedYear = DateTime.now().year.toString();
  String yearValue = "";
  @override
  void initState() {
    myFuture = fetchData();
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
          'Change Order Job List',
          style: TextStyle(color: Colors.white),
        ),
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
                    selectedYear,
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
        backgroundColor: const Color.fromARGB(255, 7, 59, 120),
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
                  await fetchData();
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
                                onTap: () async {
                                  await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => PlannerJobDetailsScreen(
                                        tokenNo: item.tokenNo.toString(),
                                      ),
                                    ),
                                  );
                                  await fetchData();
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
  Future<void> fetchData() async {
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    id = data.user!.id.toString();
    var url = "${AppUrl.getAllDataEndPoint}?id=$id&year=$selectedYear";

    print('urlCOOO $url');

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
              .map((e) => GFChangeOrderAllStatusData.fromJson(e))
              .toList();

          filteredList = dataList;
          isError = false;
          if (yearValue == "show") {
            Navigator.pop(context);
            yearValue = "";
          }
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
              (item.maintType ?? "").toString().toLowerCase().contains(
                searchText,
              ) ||
              (item.substation ?? "").toString().toLowerCase().contains(
                searchText,
              ) ||
              (item.feeder ?? "").toString().toLowerCase().contains(
                searchText,
              ) ||
              (item.status ?? "").toString().toLowerCase().contains(searchText);
        }).toList();
      });
    }
  }

  void showCrewDialog(BuildContext context, String tokenNo) async {
    await fetchCrewList(); // Fetch crew list before showing the dialog

    String? selectedCrew; // Local state for dropdown selection
    //  String? errorMessage; // To show validation error message

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              title: Text.rich(
                TextSpan(
                  text: "Select General Foreman to share Job no: ",
                  style: const TextStyle(
                    fontSize: 16,
                    // fontWeight: FontWeight.bold,
                  ),
                  children: [
                    TextSpan(
                      text: "$tokenNo ",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const TextSpan(text: "with:", style: TextStyle()),
                  ],
                ),
              ),
              content: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        //   DropdownButton<String>(
                        //     value: selectedCrew,
                        //     hint: Text("Select Crew"),
                        //     items: crewList.map<DropdownMenuItem<String>>((item) {
                        //       return DropdownMenuItem<String>(
                        //         value: item["id"],
                        //         child: Text(item["name"]), //  shows fName
                        //       );
                        //     }).toList(),
                        //     onChanged: (value) {
                        //       setState(() {
                        //         selectedCrew = value!;
                        //       });
                        //     },
                        //   ),
                        //   if (errorMessage != null) // Show error if exists
                        //     Padding(
                        //       padding: const EdgeInsets.only(top: 8.0),
                        //       child: Text(
                        //         errorMessage!,
                        //         style: const TextStyle(
                        //           color: Colors.red,
                        //           fontSize: 14,
                        //         ),
                        //       ),
                        //     ),
                        DropdownButtonFormField<String>(
                          value: selectedCrew,
                          isExpanded: true,
                          decoration: InputDecoration(
                            // labelText: "Select Crew",
                            hintText: "Select here",
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 4, // adjust this for vertical centering
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Colors.grey.shade400,
                              ),
                            ),
                            // focusedBorder: OutlineInputBorder(
                            //   borderRadius: BorderRadius.circular(10),
                            //   borderSide: BorderSide(color: Colors.blue, width: 1.5),
                            // ),
                          ),
                          items: crewList.map<DropdownMenuItem<String>>((item) {
                            return DropdownMenuItem<String>(
                              value: item["id"],
                              child: Text(
                                item["name"],
                                style: const TextStyle(fontSize: 14),
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setStateDialog(() {
                              selectedCrew = value;
                              // errorMessage =
                              //     null; // Clear error when user selects
                            });
                          },
                        ),
                      ],
                    ),
              actions: [
                Align(
                  alignment: Alignment.center,
                  child: Row(
                    children: [
                      // YES Button (with validation)
                      _buildDialogButton(
                        context,
                        text: "YES",
                        color: Colors.green,
                        onTap: () {
                          if (selectedCrew == null) {
                            setStateDialog(() {
                              //  errorMessage = "Please select a crew.";
                            });
                            return;
                          }
                          updateFlagValue(tokenNo);
                          Navigator.pop(dialogContext);
                        },
                      ),
                      // NO Button
                      _buildDialogButton(
                        context,
                        text: "NO",
                        color: Colors.red,
                        onTap: () => Navigator.pop(dialogContext),
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

  Widget _buildDialogButton(
    BuildContext context, {
    required String text,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(left: 6, top: 6.0, bottom: 10),
      child: InkWell(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.only(bottom: 10.0),
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width * 0.25,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Color.fromARGB(255, 3, 47, 97),
                blurRadius: 5,
                offset: Offset(2.0, 5.0),
              ),
            ],
            gradient: LinearGradient(colors: [color, color]),
          ),
          child: Align(
            alignment: Alignment.center,
            child: Text(
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
        fetchData();
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

  void showFilterDialog() {
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
                  value: selectedYear,
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
                  // Dynamic years
                  items: yearList.map((year) {
                    return DropdownMenuItem<String>(
                      value: year,
                      child: Text(year),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setDialogState(() {
                      yearValue = "show";
                      selectedYear = value!;
                      //  Navigator.pop(context);
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
                    myFuture = fetchData();
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
                  //             const PlannerRowMaintenanceView()));
                  //   },
                  // ),
                  ListTile(
                    leading: const Icon(Icons.computer),
                    title: const Text('IVM Maintenance Job List'),
                    textColor: const Color.fromARGB(255, 7, 59, 120),
                    iconColor: const Color.fromARGB(255, 7, 59, 120),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const PlannerAddNewRowTable(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.change_circle),
                    title: const Text('Change Order Job List'),
                    textColor: const Color.fromARGB(255, 7, 59, 120),
                    iconColor: const Color.fromARGB(255, 7, 59, 120),
                    onTap: () {
                      Navigator.pop(context);
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

  // Future<bool> switchUser() async {
  //   try {
  //     final userPreferences = Provider.of<UserPref>(context, listen: false);

  //     UserModel user = await userPreferences.getUser();
  //     String id = '';
  //     UserModel data = await userPreferences.getUser();
  //     id = data.user!.id.toString();

  //     final uri =
  //         "${AppUrl.baseUrl}login_user/switchUser"
  //         "?loginId=$id"
  //         "&switchTo=3";
  //     print('uriuri:: $uri');
  //     final response = await http.put(
  //       Uri.parse(uri),
  //       headers: {
  //         "Authorization": "Bearer ${user.token}",
  //         "Content-Type": "application/json",
  //       },
  //     );

  //     print("Switch User Status : ${response.statusCode}");
  //     print("Switch User Response : ${response.body}");

  //     if (response.statusCode == 200) {
  //       final SharedPreferences pref = await SharedPreferences.getInstance();
  //       pref.setString('userType', '3');
  //       return true;
  //     } else {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text(response.body), backgroundColor: Colors.red),
  //       );

  //       return false;
  //     }
  //   } catch (e) {
  //     print("switchUser Error : $e");

  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text(e.toString()), backgroundColor: Colors.red),
  //     );

  //     return false;
  //   }
  // }
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
