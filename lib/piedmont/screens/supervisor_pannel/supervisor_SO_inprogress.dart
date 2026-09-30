import 'package:CIVM/piedmont/resources/app_colors.dart';
import 'package:CIVM/piedmont/resources/app_url.dart';
import 'package:CIVM/piedmont/screens/supervisor_pannel/supervisor_SO_view.dart';
import 'package:CIVM/piedmont/utils/common_functions.dart';
import 'package:CIVM/utils/user_pref.dart';
import 'package:CIVM/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:CIVM/piedmont/view_model/image_code_view_model.dart';

// ignore: must_be_immutable
class SupervisorSOInprogress extends StatefulWidget {
  SupervisorSOInprogress({
    super.key,
  });

  @override
  State<SupervisorSOInprogress> createState() => _SupervisorSOInprogressState();
}

class _SupervisorSOInprogressState extends State<SupervisorSOInprogress>
    with TickerProviderStateMixin {
  List<dynamic> filteredList = [];
  TextEditingController searchController = TextEditingController();
  final List<Color> containerColors = [
    const Color.fromARGB(255, 252, 231, 238),
    const Color.fromARGB(255, 226, 246, 253),
    const Color.fromARGB(255, 212, 249, 212),
    const Color.fromARGB(255, 251, 251, 215),
    const Color.fromARGB(255, 251, 239, 251),
  ];

  Future? myFuture;
  List<dynamic> energyAuditList = [];
  String auditId = '';
  String accountNumber = '';
  String status = '';
  bool isError = false;
  ImageViewViewModel imageViewModel = ImageViewViewModel();
  @override
  void initState() {
    myFuture = fetchEnergyAuditData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Service Order (In Progress)',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColors.baseColor,
      ),
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
                    await fetchEnergyAuditData();
                  },
                  child: Container(
                    margin: const EdgeInsets.only(
                        left: 8, right: 8, top: 10, bottom: 8),
                    padding: const EdgeInsets.all(8),
                    alignment: Alignment.center,
                    height: size.height * 0.9,
                    width: size.width * 0.99,
                    decoration: BoxDecoration(
                        // shape: BoxShape.circle,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                              color: AppColors.baseColor,
                              blurRadius: 10,
                              offset: Offset(2.0, 5.0))
                        ],
                        gradient: const LinearGradient(
                          colors: [
                            Color.fromARGB(255, 255, 255, 255),
                            Color.fromARGB(255, 255, 255, 255),
                          ],
                        )),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              "TOTAL NO OF RECORDS : ${energyAuditList.length.toString()}",
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: AppColors.baseColor,
                                  fontWeight: FontWeight.bold),
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
                                      left: 4.0, right: 4.0, top: 4, bottom: 4),
                                  child: TextFormField(
                                    controller: searchController,
                                    onChanged: (value) =>
                                        filterData(value), // 👈 important
                                    style: const TextStyle(
                                        color: AppColors.baseColor,
                                        fontSize: 16),
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
                                    horizontal: 8, vertical: 6),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SupervisorSOView(
                                                    tokenNo:
                                                        item["ID"].toString(),
                                                    status: "ASSIGNED",
                                                    soNo: item["BI_SO_NBR"])));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: getCardColorPemc(
                                          item["STATUS"] ?? ''),
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
                                          ///  TOP ROW (Job No + Status Badge)
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  "SERVICE ORDER NO: ${item["BI_SO_NBR"] ?? ''}",
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),

                                              /// STATUS BADGE
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10,
                                                        vertical: 4),
                                                decoration: BoxDecoration(
                                                  color: getStatusColorPemc(
                                                      item["STATUS"] ?? ''),
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                child: Text(
                                                  item["STATUS"] ?? "",
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
                                                Icons.person,
                                                size: 16,
                                                color: Colors.black,
                                              ),
                                              const SizedBox(width: 6),
                                              Expanded(
                                                child: Text(
                                                  "NAME : ${item["BI_SO_FULL_NM"] ?? ''} ",
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
                                                Icons.numbers,
                                                size: 16,
                                                color: Colors.black,
                                              ),
                                              const SizedBox(width: 6),
                                              Expanded(
                                                child: Text(
                                                  "ACCOUNT NO : ${item["ACCOUNT_NO"] ?? ''}",
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
                                                Icons.location_on,
                                                size: 16,
                                                color: Colors.black,
                                              ),
                                              const SizedBox(width: 6),
                                              Expanded(
                                                child: Text(
                                                  "ADDRESS : ${item["ADDRESS"] ?? ''}",
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
//
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ));
          },
        ),
      ),
    );
  }

  Future<void> fetchEnergyAuditData() async {
    var url = "${AppUrl.getServiceOrderByStatus}?status=ASSIGNED";
    print('url $url');
    final userPreferences = Provider.of<UserPref>(context, listen: false);
    UserModel data = await userPreferences.getUser();
    var headers = {
      "Content-Type": "application/json",
      // "Authorization": "Bearer $token", //  Add this line
      "Authorization": 'Bearer ${data.token!}'
    };

    try {
      var response = await http.get(
        Uri.parse(url),
        headers: headers,
      );

      if (response.statusCode == 200) {
        print("✅ API Success:");
        print(response.body);

        var data = jsonDecode(response.body);

        setState(() {
          energyAuditList = data["Service_Order_For_Review_Data"];
          filteredList = energyAuditList; //  initialize
          isError = false;
        });

        print(data["success"]);
      } else {
        setState(() {
          isError = true;
        });
        print("❌ API Error: ${response.statusCode}");
        print(response.body);
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
        filteredList = energyAuditList;
      });
    } else {
      setState(() {
        filteredList = energyAuditList.where((item) {
          final searchText = query.toLowerCase();
          return (item["BI_SO_NBR"] ?? "")
                  .toString()
                  .toLowerCase()
                  .contains(searchText) ||
              (item["STATUS"] ?? "")
                  .toString()
                  .toLowerCase()
                  .contains(searchText) ||
              (item["ACCOUNT_NO"] ?? "")
                  .toString()
                  .toLowerCase()
                  .contains(searchText) ||
              (item["BI_SO_FULL_NM"] ?? "")
                  .toString()
                  .toLowerCase()
                  .contains(searchText);
        }).toList();
      });
    }
  }
}
